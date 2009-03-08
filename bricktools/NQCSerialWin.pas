unit NQCSerialWin;

interface

uses
  Windows, TOWERAPI, NQCStream;

type
  TNQCSerial = class(TNQCStream)
  protected
    fFile : THandle;
    function InternalRead(Ptr : PByte; count: Integer): LongInt;
    procedure SetLinkMode(const Value: TLinkMode); override;
  public
    function Open(Name : string) : Boolean; virtual;
    procedure Close; override;
    function Read(Ptr : PByte; count : Longint; timeout : Longint = kPStream_NeverTimeout) : LongInt; override;
    function Write(Ptr : PByte; count : LongInt) : LongInt; override;
    procedure FlushWrite; override;
    procedure FlushRead(delay : Integer); override;
    function SetTimeout(timeout_ms : LongInt = kPStream_NeverTimeout) : Boolean; override;
    function SetSpeed(speed : integer; opts : integer = 0) : Boolean; virtual;
    function SetDTR(bDTR : Boolean) : Boolean; virtual;
    function SetRTS(bRTS : Boolean) : Boolean; virtual;
  end;

  TNQCSpybotSerial = class(TNQCSerial)
  public
    function SetTimeout(timeout_ms : LongInt = kPStream_NeverTimeout) : Boolean; override;
  end;

  TNQCUsbTower = class(TNQCSerial)
  private
  protected
    procedure SetLinkMode(const Value: TLinkMode); override;
  public
    function Open(Name : string) : Boolean; override;
    procedure FlushWrite; override;
    procedure FlushRead(delay : Integer); override;
    function SetTimeout(timeout_ms : LongInt = kPStream_NeverTimeout) : Boolean; override;
    function SetSpeed(speed : integer; opts : integer = 0) : Boolean; override;
    function SetDTR(bDTR : Boolean) : Boolean; override;
    function SetRTS(bRTS : Boolean) : Boolean; override;
    function GetCaps(mode : longint) : LT_CAPS;
    function GetCommStats : LT_COMMSTATS;
    function ResetCommStats : Boolean;
  end;

implementation

uses
  SysUtils, Math;

const
  K_WRITE_WAIT = 40;
//  K_USB_WRITE  = 40;
//  K_USB_READ   = 15;
  K_USB_WRITE  = 0;
  K_USB_READ   = 20;

{ TNQCSerial }

procedure TNQCSerial.Close;
begin
  if not Active then Exit;
  CloseHandle(fFile);
  inherited Close;
end;

procedure TNQCSerial.FlushRead(delay : Integer);
var
  buff : PByte;
const
  BUFFSIZE = 512;
begin
  GetMem(buff, BUFFSIZE);
  try
    while Read(buff, BUFFSIZE, delay) > 0 do
    begin
    end;
//    PurgeComm(fFile, PURGE_RXCLEAR);
  finally
    FreeMem(buff, BUFFSIZE);
  end;
end;

procedure TNQCSerial.FlushWrite;
begin
  FlushFileBuffers(fFile);
end;

function TNQCSerial.InternalRead(Ptr: PByte; count: Integer): LongInt;
var
  actual, Errors : DWORD;
  cstat : TComStat;
begin
  actual := 10;
  if not ReadFile(fFile, Ptr^, Cardinal(count), actual, nil) then
  begin
    GetLastError();
    ClearCommError(fFile, Errors, @cstat);
    Result := 0;
  end
  else
  begin
    Result := actual;
  end;
end;

function TNQCSerial.Open(Name: string): Boolean;
begin
  Result := False;
  if Active then Exit;

  fFile := CreateFile(PChar(Name), GENERIC_READ or GENERIC_WRITE, 0,
                      nil, OPEN_EXISTING, 0, 0);

  if fFile = INVALID_HANDLE_VALUE then Exit;

  if not SetSpeed(kDefaultSpeed) then Exit;
//  SetBlocking(True);
  fOpen := True;
  Result := True;
end;

function TNQCSerial.Read(Ptr : PByte; count : Longint; timeout : LongInt): LongInt;
begin
  if count > 1 then
    SetTimeout(timeout);
  Result := InternalRead(Ptr, count);
end;

function TNQCSerial.SetDTR(bDTR: Boolean): Boolean;
begin
  if bDTR then
    Result := EscapeCommFunction(fFile, Windows.SETDTR)
  else
    Result := EscapeCommFunction(fFile, CLRDTR);
end;

procedure TNQCSerial.SetLinkMode(const Value: TLinkMode);
begin
  fLinkMode := lmIR;
end;

function TNQCSerial.SetRTS(bRTS: Boolean): Boolean;
begin
  if bRTS then
    Result := EscapeCommFunction(fFile, Windows.SETRTS)
  else
    Result := EscapeCommFunction(fFile, CLRRTS);
end;

function GetBaud(speed : Integer) : Integer;
begin
  case speed of
    LT_SPEED_BPS_300 : Result := 300;
    LT_SPEED_BPS_600 : Result := 600;
    LT_SPEED_BPS_1200 : Result := 1200;
    LT_SPEED_BPS_2400 : Result := 2400;
    LT_SPEED_BPS_4800 : Result := 4800;
    LT_SPEED_BPS_9600	: Result := 9600;
    LT_SPEED_BPS_19200 : Result := 19200;
    LT_SPEED_BPS_38400 : Result := 38400;
    LT_SPEED_BPS_57600 : Result := 57600;
    LT_SPEED_BPS_115200 : Result := 115200;
    LT_SPEED_BPS_230400 : Result := 230400;
    LT_SPEED_BPS_460800 : Result := 460800;
  else
    result := kDefaultSpeed;
  end;
end;

function TNQCSerial.SetSpeed(speed, opts: integer): Boolean;
var
  dcb : TDCB;
begin
  Result := False;
  FillChar(dcb, sizeof(TDCB), 0);
  dcb.DCBlength := sizeof(TDCB);
  if not GetCommState(fFile, dcb) then Exit;
  dcb.BaudRate  := GetBaud(speed);
  dcb.XonLim    := 100;
  dcb.XoffLim   := 100;
  dcb.ByteSize  := 8 - (opts and kPSerial_DataMask);
  dcb.Parity    := (opts and kPSerial_ParityMask) shr kPSerial_ParityShift;
  dcb.StopBits  := (opts and kPSerial_StopMask) shr kPSerial_StopShift;
  dcb.XonChar   := #1;
  dcb.XoffChar  := #2;
//  dcb.XonChar   := #17;
//  dcb.XoffChar  := #19;
  dcb.ErrorChar := #0;
  dcb.EofChar   := #0;
  dcb.EvtChar   := #0;
  dcb.Flags     := fBinary or fDtrControlEnable;
  if UseXonXoff then
    dcb.Flags   := dcb.Flags or fOutX or fInX;
  Result := SetCommState(fFile, dcb);
end;

function TNQCSerial.SetTimeout(timeout_ms: Integer): Boolean;
var
  timeouts : TCommTimeouts;
begin
  timeouts.ReadIntervalTimeout := 0;
  timeouts.ReadTotalTimeoutMultiplier := 0;
  timeouts.ReadTotalTimeoutConstant := 0;
  timeouts.WriteTotalTimeoutMultiplier := 0;
  timeouts.WriteTotalTimeoutConstant := 0;

  case timeout_ms of
    kPStream_NeverTimeout : ;
    0 : timeouts.ReadIntervalTimeout := MAXDWORD;
  else
    timeouts.ReadTotalTimeoutConstant   := Abs(timeout_ms);
  end;
  Result := SetCommTimeouts(fFile, timeouts);
end;

function TNQCSerial.Write(Ptr : PByte; count: Integer): LongInt;
var
  actual : DWORD;
begin
  if not WriteFile(fFile, Ptr^, Cardinal(count), actual, nil) then
    Result := -1
  else
    Result := actual;
  FlushWrite;
end;

{ TNQCSpybotSerial }

function TNQCSpybotSerial.SetTimeout(timeout_ms: Integer): Boolean;
var
  timeouts : TCommTimeouts;
begin
  timeouts.ReadIntervalTimeout := 0;
  timeouts.ReadTotalTimeoutMultiplier := 0;
  timeouts.ReadTotalTimeoutConstant := 0;
  timeouts.WriteTotalTimeoutMultiplier := 0;
  timeouts.WriteTotalTimeoutConstant := 0;

  case timeout_ms of
    kPStream_NeverTimeout : ;
    0 : timeouts.ReadIntervalTimeout := MAXDWORD;
  else
    timeouts.ReadTotalTimeoutConstant   := Abs(timeout_ms);
    timeouts.ReadIntervalTimeout        := MAXDWORD;
    timeouts.ReadTotalTimeoutMultiplier := MAXDWORD;
  end;
  Result := SetCommTimeouts(fFile, timeouts);
end;

{ TNQCUsbTower }

procedure TNQCUsbTower.FlushRead(delay : Integer);
begin
  if LegoTowerApiLoaded then
    LEGOTowerFlush(fFile, LT_FLUSH_RX_BUFFER);
end;

procedure TNQCUsbTower.FlushWrite;
begin
  if LegoTowerApiLoaded then
    LEGOTowerFlush(fFile, LT_FLUSH_TX_BUFFER);
end;

function LinkModeToInt(lm : TLinkMode) : Integer;
begin
  case lm of
    lmVLL   : Result := LT_LINK_VLL;
    lmIRC   : Result := LT_LINK_IRC;
    lmRadio : Result := LT_LINK_RADIO;
  else
    Result := LT_LINK_IR;
  end;
end;

function TNQCUsbTower.GetCaps(mode : longint): LT_CAPS;
begin
  if LegoTowerAPILoaded then
  begin
    LEGOTowerGetCaps(fFile, mode, Result);
  end;
end;

function TNQCUsbTower.GetCommStats: LT_COMMSTATS;
begin
  if LegoTowerAPILoaded then
    LEGOTowerGetCommStats(fFile, Result);
end;

function TNQCUsbTower.Open(Name: string): Boolean;
begin
  result := inherited Open(Name);
  if LegoTowerApiLoaded then
  begin
    if Result then
      Result := LEGOTowerSetLinkMode(fFile, LinkModeToInt(LinkMode));
  end;
end;

function TNQCUsbTower.ResetCommStats: Boolean;
begin
  Result := False;
  if LegoTowerAPILoaded then
    Result := LEGOTowerResetCommStats(fFile);
end;

function TNQCUsbTower.SetDTR(bDTR: Boolean): Boolean;
begin
//  Result := inherited SetDTR(bDTR);
  Result := True;
end;

procedure TNQCUsbTower.SetLinkMode(const Value: TLinkMode);
begin
  fLinkMode := Value;
end;

function TNQCUsbTower.SetRTS(bRTS: Boolean): Boolean;
begin
//  Result := inherited SetRTS(bRTS);
  Result := True;
end;

function TNQCUsbTower.SetSpeed(speed, opts: integer): Boolean;
begin
  Result := False;
  if LegoTowerApiLoaded then
  begin
    if speed in [LT_SPEED_BPS_2400, LT_SPEED_BPS_4800] then
    begin
      Result := LEGOTowerSetIRSpeed(fFile, speed, speed);
      // Note: Tower drivers set carrier frequency to 76 Khz when baud rate is set to 4800.
      // RCX always uses 38 Khz, so need to set it back.
      // if 4800 then set carrier to 76 else set it to 38
      if Result and ForceRCXFrequency then
        Result := LEGOTowerSetCarrierFrequency(fFile, 38);
    end;
  end;
end;

function TNQCUsbTower.SetTimeout(timeout_ms: Integer): Boolean;
begin
  Result := False;
  if timeout_ms < kPStream_NeverTimeout then
  begin
    Sleep(Abs(timeout_ms));
    Result := True;
    if LegoTowerApiLoaded then
      LEGOTowerSetTimeouts(fFile, 70, K_USB_READ, K_USB_WRITE);
  end
  else
  begin
    if LegoTowerApiLoaded then
    begin
      if timeout_ms = 0 then
        timeout_ms := 400;
      Result := LEGOTowerSetTimeouts(fFile, timeout_ms, K_USB_READ, K_USB_WRITE);
    end;
  end;
end;

end.
