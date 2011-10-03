unit uSerial;

interface

const
  MAX_SERIAL_IDX = 128;

function GetSerialDeviceName(idx : integer) : string;
function SerialRead(Handle: LongInt; Buffer : Pointer; Count: LongInt; ms : LongInt): LongInt;
procedure SerialFlush(Handle: LongInt);
function SerialWrite(Handle: LongInt; Buffer : Pointer; Count: LongInt): LongInt;
function SerialSetParams(Handle: LongInt; BitsPerSec: LongInt;
  ByteSize: byte; Parity: byte; StopBits: byte) : boolean;
function SerialOpen(const DeviceName: String): LongInt;
procedure SerialClose(Handle: LongInt);
procedure SerialFlushRead(Handle: LongInt; delay : Integer);
function SerialSetDTR(Handle: LongInt; bDTR: Boolean): Boolean;
function SerialSetRTS(Handle: LongInt; bRTS: Boolean): Boolean;

implementation

uses
  SysUtils,
  {$IFNDEF FPC}
  Windows
  {$ELSE}
  {$IFDEF Darwin}BaseUnix, termio, unix{$ENDIF}
  {$IFNDEF Darwin}
  {$IFDEF Unix}BaseUnix, termio, unix{$ENDIF}
  {$IFDEF Windows}Windows{$ENDIF}
  {$ENDIF}
  {$ENDIF};

function GetSerialDeviceName(idx : integer) : string;
begin
{$IFNDEF FPC}
  Result := Format('\\.\COM%d', [idx]);
{$ELSE}
{$IFDEF Darwin}
  Result := Format('/dev/rfcomm%d', [idx]);
{$ENDIF}
{$IFNDEF Darwin}
{$IFDEF Unix}
  Result := Format('/dev/rfcomm%d', [idx]);
{$ENDIF}
{$IFDEF Windows}
  Result := Format('\\.\COM%d', [idx]);
{$ENDIF}
{$ENDIF}
{$ENDIF}
end;

{$IFNDEF FPC}
function SetTimeout(Handle: LongInt; ms: Integer): Boolean;
var
  timeouts : TCommTimeouts;
begin
  timeouts.ReadIntervalTimeout := 0;
  timeouts.ReadTotalTimeoutMultiplier := 0;
  timeouts.ReadTotalTimeoutConstant := 0;
  timeouts.WriteTotalTimeoutMultiplier := 0;
  timeouts.WriteTotalTimeoutConstant := 0;

  case ms of
    -1 : ;
    0 : timeouts.ReadIntervalTimeout := MAXDWORD;
  else
    timeouts.ReadTotalTimeoutConstant   := Abs(ms);
    timeouts.ReadIntervalTimeout        := MAXDWORD;
    timeouts.ReadTotalTimeoutMultiplier := MAXDWORD;
  end;
  Result := SetCommTimeouts(Handle, timeouts);
end;

function InternalRead(Handle: LongInt; Buffer: Pointer; count: Integer): LongInt;
var
  actual, Errors : DWORD;
  cstat : TComStat;
begin
  actual := 10;
  if not ReadFile(Handle, Buffer^, Cardinal(count), actual, nil) then
  begin
    GetLastError();
    ClearCommError(Handle, Errors, @cstat);
    Result := 0;
  end
  else
  begin
    Result := actual;
  end;
end;

{$ELSE}
function TimerGTEQ(a, b : PTimeval) : boolean;
begin
  Result := False;
  if a^.tv_sec < b^.tv_sec then
    Exit
  else if a^.tv_sec = b^.tv_sec then
  begin
    if a^.tv_usec < b^.tv_usec then
      Exit;
  end;
  Result := True;
end;

procedure TimerSub(a, b, result : PTimeval);
begin
  result^.tv_sec  := a^.tv_sec - b^.tv_sec;
  result^.tv_usec := a^.tv_usec - b^.tv_usec;
  if result^.tv_usec < 0 then
  begin
    dec(result^.tv_sec);
    result^.tv_usec := result^.tv_usec + 1000000;
  end;
end;

const FIONREAD = $541B;
{$ENDIF}

{$IFDEF WIN32}
function ReadWithTimeOut(Handle: LongInt; Buffer : Pointer; Count: LongInt; ms : LongInt) : LongInt;
begin
  if count > 1 then
    SetTimeout(Handle, ms);
  Result := InternalRead(Handle, Buffer, Count);
end;
{$ELSE}
function ReadWithTimeOut(Handle: LongInt; Buffer : Pointer; Count: LongInt; ms : LongInt) : LongInt;
var
  cur : PChar;
  expire, delay : TTimeval;
  tz : TTimezone;
  rfds : TFDSet;
  nread, total : integer;
begin
  // time limited read
  cur := PChar(Buffer);
  if fpGetTimeOfDay(@expire, @tz) < 0 then
  begin
    Result := -1;
    Exit;
  end;

  expire.tv_sec  := expire.tv_sec + (ms div 1000);
  expire.tv_usec := expire.tv_usec + ((ms mod 1000) * 1000);

  rfds[0] := 0;
  total := 0;
  while Count > 0 do
  begin
    fpFD_Zero(rfds);
    fpFD_Set(Handle, rfds);
    if fpGetTimeOfDay(@delay, @tz) < 0 then
    begin
      Result := -1;
      Exit;
    end;

    if TimerGTEQ(@delay, @expire) then
      break;

    TimerSub(@expire, @delay, @delay);

    if fpSelect(Handle + 1, @rfds, nil, nil, @delay) <> 0 then
    begin
      if fpIOCtl(Handle, FIONREAD, @nread) < 0 then
      begin
        Result := -1;
        Exit;
      end;

      if Count < nread then
        nread := Count;

      nread := fpRead(Handle, cur, nread);
      if nread < 0 then
      begin
        Result := -1;
        Exit;
      end;
      dec(Count, nread);
      cur := cur + nread;
      inc(total, nread);
    end
    else
      break;
  end;
  Result := total;
end;
{$ENDIF}

function SerialRead(Handle: LongInt; Buffer : Pointer; Count: LongInt; ms : LongInt): LongInt;
begin
  Result := ReadWithTimeOut(Handle, Buffer, Count, ms);
end;

procedure SerialFlush(Handle: LongInt);
begin
{$IFNDEF FPC}
  FlushFileBuffers(Handle);
{$ELSE}
  fpfsync(Handle);
{$ENDIF}  
end;

{$IFNDEF FPC}
function SerialWrite(Handle: LongInt; Buffer : Pointer; Count: LongInt): LongInt;
var
  actual : DWORD;
begin
  if not WriteFile(Handle, Buffer^, Cardinal(Count), actual, nil) then
    Result := -1
  else
    Result := actual;
  SerialFlush(Handle);
end;
{$ELSE}
function SerialWrite(Handle: LongInt; Buffer : Pointer; Count: LongInt): LongInt;
begin
  Result := fpWrite(Handle, Buffer^, Count);
end;
{$ENDIF}

{$IFNDEF FPC}
function SerialSetParams(Handle: LongInt; BitsPerSec: LongInt;
  ByteSize: byte; Parity: byte; StopBits: byte) : boolean;
var
  dcb : TDCB;
begin
  Result := False;
  FillChar(dcb, sizeof(TDCB), 0);
  dcb.DCBlength := sizeof(TDCB);  // 28
  if not GetCommState(Handle, dcb) then Exit;
  dcb.BaudRate  := BitsPerSec;  // 1200
  dcb.ByteSize  := ByteSize; // 7
  dcb.Parity    := Parity;   // 0 == no parity
  dcb.StopBits  := StopBits; // 0 == 1 stop bit
//  dcb.Flags     := $0001 or $0010;   // $1011
//  dcb.XonLim    := 100; // 2048
//  dcb.XoffLim   := 100; // 512
//  dcb.XonChar   := #1;  // #17
//  dcb.XoffChar  := #2;  // #19
//  dcb.ErrorChar := #0;  // #0
//  dcb.EofChar   := #0;  // #0
//  dcb.EvtChar   := #0;  // #0
  Result := SetCommState(Handle, dcb);
end;
{$ELSE}
function SerialSetParams(Handle: LongInt; BitsPerSec: LongInt;
  ByteSize: byte; Parity: byte; StopBits: byte) : boolean;
var
  tios: termios;
begin
  tios.c_oflag := 0;
  FillChar(tios, SizeOf(tios), #0);

  case BitsPerSec of
    50: tios.c_cflag := B50;
    75: tios.c_cflag := B75;
    110: tios.c_cflag := B110;
    134: tios.c_cflag := B134;
    150: tios.c_cflag := B150;
    200: tios.c_cflag := B200;
    300: tios.c_cflag := B300;
    600: tios.c_cflag := B600;
    1200: tios.c_cflag := B1200;
    1800: tios.c_cflag := B1800;
    2400: tios.c_cflag := B2400;
    4800: tios.c_cflag := B4800;
    19200: tios.c_cflag := B19200;
    38400: tios.c_cflag := B38400;
    57600: tios.c_cflag := B57600;
    115200: tios.c_cflag := B115200;
    230400: tios.c_cflag := B230400;
{$ifndef BSD}
    460800: tios.c_cflag := B460800;
{$endif}
    else tios.c_cflag := B9600;
  end;
  tios.c_ispeed := tios.c_cflag;
  tios.c_ospeed := tios.c_ispeed;

  tios.c_cflag := tios.c_cflag or CREAD or CLOCAL;

  case ByteSize of
    5: tios.c_cflag := tios.c_cflag or CS5;
    6: tios.c_cflag := tios.c_cflag or CS6;
    7: tios.c_cflag := tios.c_cflag or CS7;
  else
    tios.c_cflag := tios.c_cflag or CS8;
  end;

  case Parity of
    1: tios.c_cflag := tios.c_cflag or PARENB or PARODD;
    2: tios.c_cflag := tios.c_cflag or PARENB;
  end;

  if StopBits = 2 then
    tios.c_cflag := tios.c_cflag or CSTOPB;

  tios.c_cc[VMIN] := 1;
  tios.c_cc[VTIME] := 0;
  tcsetattr(Handle, TCSAFLUSH, tios);
  Result := True;
end;
{$ENDIF}

function SerialOpen(const DeviceName: String): LongInt;
begin
{$IFNDEF FPC}
  Result := CreateFile(PChar(DeviceName), GENERIC_READ or GENERIC_WRITE, 0,
                       nil, OPEN_EXISTING, 0, 0);
{$ELSE}
  Result := fpopen(DeviceName, O_RDWR);
{$ENDIF}
end;

procedure SerialClose(Handle: LongInt);
begin
  try
{$IFNDEF FPC}
  CloseHandle(Handle);
{$ELSE}
  fpClose(Handle);
{$ENDIF}
  except
  end;
end;

procedure SerialFlushRead(Handle: LongInt; delay : Integer);
var
  buff : PByte;
const
  BUFFSIZE = 512;
begin
  GetMem(buff, BUFFSIZE);
  try
    while SerialRead(Handle, buff, BUFFSIZE, delay) > 0 do
    begin
    end;
  finally
    FreeMem(buff, BUFFSIZE);
  end;
end;

{$IFNDEF FPC}
function SerialSetRTS(Handle: LongInt; bRTS: Boolean): Boolean;
begin
  if bRTS then
    Result := EscapeCommFunction(Handle, Windows.SETRTS)
  else
    Result := EscapeCommFunction(Handle, CLRRTS);
end;

function SerialSetDTR(Handle: LongInt; bDTR: Boolean): Boolean;
begin
  if bDTR then
    Result := EscapeCommFunction(Handle, Windows.SETDTR)
  else
    Result := EscapeCommFunction(Handle, CLRDTR);
end;
{$ELSE}
function SerialSetRTS(Handle: LongInt; bRTS: Boolean): Boolean;
begin
end;

function SerialSetDTR(Handle: LongInt; bDTR: Boolean): Boolean;
begin
end;
{$ENDIF}


end.
