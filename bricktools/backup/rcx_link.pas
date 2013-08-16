unit rcx_link;

interface

uses
  Classes, SysUtils, NQCSerial, Windows, rcx_cmd, uSpirit;

const
  kMaxCmdLength   = 9000;
  kMaxReplyLength = 1000;

  K_MAX_ZEROS_USB = 23;
  K_MAX_ZEROS_COM = 30;
  K_MAX_ONES      = 90;

  kDefaultRetryCount = 5;

type
  TRcxLink = class
  private
    fSerial : TNQCSerial;
    fTarget : TBrickType;
    fFastMode: boolean;
    fTxData : PByte;
    fTxLength : integer;
    fTxLastCommand : Byte;

    fRxData : PByte;
    fRxLength : integer;

    fReply : array[0..kMaxReplyLength] of Byte;

    fResult : integer;

    fVerbose : boolean;
    fPredictive : boolean;
    fSynced : boolean;
    fRxTimeout : integer;
    fDynamicTimeout : boolean;

    fDownloadTotal : integer;
    fDownloadSoFar : integer;
    FOnDownloadStatus: TDownloadStatusEvent;
    fOnDownloadDone: TNotifyEvent;
    fOnDownloadStart: TNotifyEvent;
    fOnOpenStateChanged: TNotifyEvent;
    fOmitHeader: Boolean;
    fRCXFirmwareChunkSize: Integer;
    fQuiet: Boolean;
    fUseBT: boolean;
    function  TransferFirmware(data : PByte; length, start : integer; progress : boolean) : integer;
    procedure SendFromTxBuffer(delay : Integer);
    function  IncrementProgress(delta : integer) : boolean;
    procedure BuildTxData(data : PByte; length : integer; duplicateReduction : boolean);
    procedure BeginProgress(total : integer);
    procedure SetFastMode(const Value: boolean);
    function  TransportVerifyReply(const rxExpected : integer; data: PByte; length: integer; cmd: Byte): integer;
    function  TransportSend(const txData: PByte; txLength: integer;
      rxData: PByte; rxExpected, rxMax: Integer; retry: Boolean;
      timeout : integer; tryCount : integer): Integer;
    function  TransportReceiveReply(rxExpected, timeout, tryCount: Integer;
      var replyOffset: Integer): Integer;
    procedure TransportCopyReply(dst: PByte; offset, length: Integer);
    procedure TransportAdjustTimeout(TheResult, attempt: integer);
    function  TransportFindReply(const rxExpected : integer; var offset : integer) : integer;
    procedure TransportSetFastMode(fast, comp : Boolean);
    procedure ResetRxTimeout;
    function LongTimeout : Integer;
    function ExpectedReceiveLen(const rxExpected: Integer): integer;
    function AdjustChunkSize(const n, nMaxZeros, nMaxOnes: Integer;
      const data: PByte; bComplement: boolean): Integer;
    function GetActive: boolean;
    procedure SetUseBT(const Value: boolean);
  protected
    fLog : string;
    fPort: string;
    fComplementData : Boolean;
    fSync : PByte;
    fTimeoutAdjustingAllowed : Boolean;
    fTimeoutToUse : Integer;
    fDownloadWaitTime : Integer;
    procedure WriteToLog(s : string);
    function  GetPort: string; virtual;
    procedure SetPort(const Value: string); virtual;
    procedure DumpData(ptr : PByte; length : integer);
    procedure ClearLog;
    procedure SetVerbose(b : boolean);
    function  GetVerbose : boolean;
    procedure SetTarget(target : TBrickType);
    procedure DoDownloadDone;
    procedure DoDownloadStart;
    procedure DoDownloadStatus(cur, total : Integer; var Abort : boolean);
    procedure DoOpenStateChanged;
    function  PredictReplyLength(data : PByte; len : integer) : Integer;
    function  PredictNXTReplyLength(data : PByte) : Integer;
    function  ExpectedReplyLength(data: PByte; len: integer): integer;
    procedure SetRxTimeout(t : integer);
    function  GetNQCSerial : TNQCSerial;
    property  NQCSerial : TNQCSerial read GetNQCSerial;
    function  GetPortName : string;
    procedure SetSyncPointer;
    function  TargetCommandOffset : byte;
  public
    constructor Create;
    destructor  Destroy; override;

    property  Active : boolean read GetActive;

    function  Sync(bScoutPower : Boolean = True) : integer;

    function  Send(cmd : TBaseCmd; tryCount : integer = kDefaultRetryCount;
      retry : boolean = true;  timeout : integer = 0) : integer; overload;
    function  Send(data : PByte; length : integer;
      tryCount : integer = kDefaultRetryCount; retry : boolean = true;
      timeout : integer = 0) : integer; overload;
    function  Send1(data : PByte; length : integer) : integer;

    function  GetReply(data : PByte; maxLength : integer) : integer;
    function  GetReplyByte(const index : integer) : Byte;
    function  GetReplyWord(const index : integer) : Word;
    function  GetReplyCardinal(const index : integer) : Cardinal;
    function  GetReplyString(const index, len : integer) : string;

    function  DownloadProgress(soFar, total : integer) : boolean; virtual;
//    function  SendFragment(ftype : TRcxFragment; taskNumber : Byte; const data : PByte; length : integer; total : integer = 0) : integer;
    function  DownloadFirmware(const data : PByte; length, start : integer; fast, comp : boolean) : integer;
    function  Download(const data : PByte; length, chunk : integer) : integer;

    function  GetVersion(var rom : Cardinal; var ram : Cardinal) : integer;
    function  GetMemMap(aMemMap : TStrings) : integer;
    function  MonitorIR(aIR : TStrings; aSeconds : Integer) : Integer;
    function  GetBatteryLevel : integer;

    function  GetOutputStatus(aOut : Byte) : Integer;
    function  GetVariableValue(aVar : Byte) : Integer;
    function  GetInputValue(aIn: Byte): Integer;
    function  GetMessageValue(aNum : Byte) : Integer;
    function  GetTimerValue(aNum : Byte) : Integer;
    function  GetCounterValue(aNum : Byte) : Integer;
    function  Poll(aSrc, aNum : integer) : integer;
    function  GetValue(value : integer) : integer;
    function  Open(const aPort : string) : boolean; overload;
    function  Close : boolean; virtual;

    property  Log : string read fLog;
    property  Port : string read GetPort write SetPort;
    property  PortName : string read GetPortName;
    property  Verbose : boolean read GetVerbose write SetVerbose;
    property  Target : TBrickType read fTarget write SetTarget;
    property  FastMode : boolean read fFastMode write SetFastMode;
    property  UseBluetooth : boolean read fUseBT write SetUseBT;
    property  Quiet : Boolean read fQuiet write fQuiet;
    property  RxTimeout : integer read fRxTimeout write SetRxTimeout;
    property  DynamicTimeout : boolean read fDynamicTimeout write fDynamicTimeout;
    property  OmitHeader : Boolean read fOmitHeader write fOmitHeader;
    property  RCXFirmwareChunkSize : Integer read fRCXFirmwareChunkSize write fRCXFirmwareChunkSize;
    property  DownloadWaitTime : Integer read fDownloadWaitTime write fDownloadWaitTime;
    property  OnDownloadStart : TNotifyEvent read fOnDownloadStart write fOnDownloadStart;
    property  OnDownloadDone : TNotifyEvent read fOnDownloadDone write fOnDownloadDone;
    property  OnDownloadStatus : TDownloadStatusEvent read FOnDownloadStatus write FOnDownloadStatus;
    property  OnOpenStateChanged : TNotifyEvent read fOnOpenStateChanged write fOnOpenStateChanged;
  end;

  TAutoLink = class(TRcxLink)
  private
  protected
    procedure SetPort(const Value: string); override;
  public
    function Open : boolean; overload;
    function Close : boolean; override;
    function Send(cmd : TBaseCmd; tryCount : integer = kDefaultRetryCount;
      bRetry : boolean = true) : integer; overload;
    function DownloadProgress(soFar, total : integer) : boolean; override;
  end;

implementation

uses
  rcx_constants, scout_def, TOWERAPI, Math;

const
  cmSync : array[1..2] of Byte = (1, $FF);
  rcxSync : array[1..4] of Byte = (3, $55, $ff, $00);
  rcxNo55Sync : array[1..3] of Byte = (2, $ff, $00);
  spyboticsSync : array[1..2] of Byte = (1, $98);
  nxtSync : array[1..2] of Byte = (1, kNXT_CmdReply);

const
  kReplyState = 0;

  // global constants
  kMinTimeout = 50;
  kMaxTimeout = 400;
  MAX_FIRMWARE_TIMEOUT = 1200;

  kMaxTxData  = 2 * kMaxCmdLength + 6;
  kMaxRxData  = kMaxTxData + (2 * kMaxReplyLength) + 5;

//  kFragmentChunk     = 20;
  kFirmwareChunk     = 200;
  kDownloadWaitTime  = 100; // base wait time

  kNubStart          = $8000;

  // 4x speed serial tower (4800 baud/No complements)
  rcxnub : array[0..87] of Byte = (
    $79,$06,$00,$0f,$6b,$86,$ee,$80,$79,$06,$ee,$64,$6d,$f6,$79,$06,
    $ee,$74,$5e,$00,$3b,$9a,$0b,$87,$79,$06,$ee,$5e,$5e,$00,$06,$88,
    $7f,$d8,$72,$50,$fe,$67,$3e,$d9,$18,$ee,$6a,$8e,$ef,$51,$fe,$02,
    $6a,$8e,$ef,$06,$fe,$0d,$6a,$8e,$ee,$5e,$54,$70,$44,$6f,$20,$79,
    $6f,$75,$20,$62,$79,$74,$65,$2c,$20,$77,$68,$65,$6e,$20,$49,$20,
    $6b,$6e,$6f,$63,$6b,$3f,$00,$00
  );

  // 2x speed serial tower (4800 baud/With complements)
  rcxnub2 : array[0..81] of Byte = (
    121,  6,  0, 15,107,134,238,128,121,  6,238,100,109,246,121,  6,
    238,116, 94,  0, 59,154, 11,135,121,  6,238, 94, 94,  0,  6,136,
    254,103, 62,217,127,216,114, 80,254,  2,106,142,239,  6,254, 13,
    106,142,238, 94, 84,112, 68,111, 32,121,111,117, 32, 98,121,116,
    101, 44, 32,119,104,101,110, 32, 73, 32,107,110,111, 99,107, 63,
      0,  0
  );

  // 2x speed serial tower (2400 baud/No complements)
  rcxnub3 : array[0..83] of Byte = (
    121,  6,  0, 15,107,134,238,128,121,  6,238,100,109,246,121,  6,
    238,116, 94,  0, 59,154, 11,135,121,  6,238, 94, 94,  0,  6,136,
    127,216,114, 80, 24,238,106,142,239, 81,254,  2,106,142,239,  6,
    254, 13,106,142,238, 94, 84,112, 68,111, 32,121,111,117, 32, 98,
    121,116,101, 44, 32,119,104,101,110, 32, 73, 32,107,110,111, 99,
    107, 63,  0,  0
  );

  // 4x speed usb tower (4800 baud/No complements)
  rcxusbnub : array[0..83] of Byte = (
    $79,$06,$00,$0F,$6B,$86,$EE,$80,$79,$06,$EE,$64,$6D,$F6,$79,$06,
    $EE,$74,$5E,$00,$3B,$9A,$0B,$87,$79,$06,$EE,$5E,$5E,$00,$06,$88,
    $FE,$67,$3E,$D9,$18,$EE,$6A,$8E,$EF,$51,$FE,$02,$6A,$8E,$EF,$06,
    $FE,$0D,$6A,$8E,$EE,$5E,$54,$70,$44,$6F,$20,$79,$6F,$75,$20,$62,
    $79,$74,$65,$2C,$20,$77,$68,$65,$6E,$20,$49,$20,$6B,$6E,$6F,$63,
    $6B,$3F,$00,$00
  );

  // 2x speed usb tower (4800 baud/With complements)
  rcxusbnub2 : array[0..77] of Byte = (
    121,  6,  0, 15,107,134,238,128,121,  6,238,100,109,246,121,  6,
    238,116, 94,  0, 59,154, 11,135,121,  6,238, 94, 94,  0,  6,136,
    254,103, 62,217,254,  2,106,142,239,  6,254, 13,106,142,238, 94,
     84,112, 68,111, 32,121,111,117, 32, 98,121,116,101, 44, 32,119,
    104,101,110, 32, 73, 32,107,110,111, 99,107, 63,  0,  0
  );

  // 2x speed usb tower (2400 baud/No complements)
  rcxusbnub3 : array[0..79] of Byte = (
    121,  6,  0, 15,107,134,238,128,121,  6,238,100,109,246,121,  6,
    238,116, 94,  0, 59,154, 11,135,121,  6,238, 94, 94,  0,  6,136,
     24,238,106,142,239, 81,254,  2,106,142,239,  6,254, 13,106,142,
    238, 94, 84,112, 68,111, 32,121,111,117, 32, 98,121,116,101, 44,
     32,119,104,101,110, 32, 73, 32,107,110,111, 99,107, 63,  0,  0
  );

const
  USB_TOWER = '\\.\LEGOTOWER1';
  COM_PORT  = '\\.\';

function RCX_ERROR(res : integer) : boolean;
begin
  Result := res < 0;
end;

function ComputeChecksum(dataSum : Byte; target : TBrickType) : Byte;
begin
  if target = rtSpy then
  begin
    Result := -$98 - dataSum;
  end
  else
  begin
    Result := dataSum;
  end;
end;

function Checksum(const data : PByte; length : Integer) : Integer;
var
  p : PByte;
begin
  Result := 0;
  p := data;
  while length > 0 do
  begin
    Inc(Result, p^);
    Inc(p);
    Dec(length);
  end;
end;

function MoreComplicatedFindSync(const data : PByte; const len : Integer; const sync : PByte; const syncLen : Integer; const cmd : Byte) : Integer;
var
  stuff : array[0..3] of Byte;
  i, j, k : Integer;
  cmdReply : Byte;
begin
  cmdReply := ($FF and not cmd);
  Result := 0;
  for i := Low(stuff) to High(stuff) do
    stuff[i] := PByte(PChar(data) + i)^;
  for k := 0 to 3 do begin
    if (len >= (syncLen - k + 1)) and (syncLen > k) then
    begin
      // is the byte at syncLen + 1 = cmdReply?
      if PByte(PChar(data) + (syncLen - k))^ = cmdReply then
      begin
        // if at least one byte in the data matches the sync regardless of position
        // then we assume it is a valid reply
        for i := 0 to syncLen - k do begin
          for j := 0 to syncLen - k do begin
            if stuff[i] = PByte(PChar(data) + j)^ then
            begin
              Result := syncLen - k;
              Exit;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function FindSync(const data : PByte; length : Integer; const sync : PByte;
  const cmd : Byte; bComplement : boolean) : Integer;
var
  syncLen, i : Integer;
  _end, ptr, p1, p2, psync : PByte;
  bMatch : boolean;
begin
  Result := 0;
  psync := sync;
  syncLen := psync^;
  Inc(psync);

  while (syncLen > 0) do
  begin
    _end := data;
    Inc(_end, length - syncLen + 1);

    ptr := data;
    while Integer(ptr) < Integer(_end) do
    begin
      i := 0;
      while i < syncLen do
      begin
        p1 := ptr;
        p2 := psync;
        Inc(p1, i);
        Inc(p2, i);
        if p1^ <> p2^ then Break;
        Inc(i);
      end;
      // check the next byte to see if it matches the command.
      // if it doesn't then we haven't really found the sync
      p1 := ptr;
      Inc(p1, syncLen);
      if bComplement then
        bMatch := (p1^ and $F7) = ($F7 and not cmd)
//        bMatch := p1^ = ($FF and not cmd)
      else
        bMatch := p1^ = cmd;
      if (i = syncLen) and bMatch then
      begin
        Result := Integer(ptr) - Integer(data) + syncLen;
        Exit;
      end;
      Inc(ptr);
    end;
    Inc(psync);
    Dec(syncLen);
  end;
{
  // the above algorithm handles sync|response and garbage|sync|response
  if length > 0 then
  begin
    psync := sync;
    syncLen := psync^;
    Inc(psync);
    Result := MoreComplicatedFindSync(data, length, psync, syncLen, cmd);
  end;
}
end;

(*
function VerifyFastReply(data : PByte; length : integer; cmd : Byte) : integer;
var
  checksum : Byte;
  ptr, _end, match : PByte;
begin
  // always need a cmd and a checksum
  if length < 2 then
  begin
    result := kRCX_ReplyError;
    Exit;
  end;

  // check the cmd
  if data^ <> ((not cmd) and $ff) then
  begin
    result := kRCX_ReplyError;
    Exit;
  end;

  ptr := data;
  Inc(ptr);
  _end := data;
  Inc(_end, length);
  checksum := data^;
  match := nil;

  while Integer(ptr) < Integer(_end) do
  begin
    if ptr^ = checksum then
      match := ptr;

    checksum := checksum + ptr^;
    Inc(ptr);
  end;

  if match = nil then
  begin
    result := kRCX_ReplyError;
    Exit;
  end;

  result := ((Integer(match) - Integer(data))) - 1;
end;
*)

{ TRcxLink }

function TRcxLink.PredictReplyLength(data : PByte; len : integer) : integer;
begin
  case (data^ and $F7) of
    kRCX_BeginTaskOp,  kRCX_BeginSubOp,
    kRCX_DownloadOp, kRCX_BeginFirmwareOp :
      result := 1;
    kRCX_PollOp, kRCX_BatteryLevelOp :
      result := 2;
    kRCX_UnlockOp :
      result := 8;
    kRCX_UnlockFirmOp :
      result := 25;
    kRCX_UploadEepromOp :
      if fTarget = rtCybermaster then
        result := 0
      else
        result := 16;
    kRCX_MemMapOp : begin
      if fTarget = rtCybermaster then
        result := 20
      else if fTarget = rtScout then
        result := 0 // unsupported op-code
      else
        result := 188;
    end;
    kRCX_PollMemoryOp : begin
      if len <> 4 then
        result := 0
      else
        result := PByte(Integer(data)+3)^;
    end;
    kRCX_UploadDatalogOp : begin
      if len <> 5 then
        result := 0
      else
        result := ( PByte(Integer(data)+3)^ +
                   (Integer(PByte(Integer(data)+4)^) shl 8)) * 3;
    end;
  else
    result := 0;
  end;
end;

function TRcxLink.PredictNXTReplyLength(data : PByte) : integer;
var
  d2 : PByte;
  b1, b2 : Byte;
  count : word;
begin
  case data^ of
    kNXT_DirectCmdNoReply, kNXT_SystemCmdNoReply : Result := 0;
    kNXT_DirectCmd :
    begin
      d2 := data;
      inc(d2);
      case d2^ of
        kNXT_DCStartProgram, kNXT_DCStopProgram,
        kNXT_DCPlaySoundFile, kNXT_DCPlayTone,
        kNXT_DCSetOutputState, kNXT_DCSetInputMode,
        kNXT_DCResetInputScaledValue, kNXT_DCMessageWrite,
        kNXT_DCResetMotorPosition, kNXT_DCStopSoundPlayback,
        kNXT_DCLSWrite : Result := 2;
        kNXT_DCGetOutputState  : Result := 24;
        kNXT_DCGetInputValues  : Result := 15;
        kNXT_DCGetBatteryLevel,
        kNXT_DCGetButtonState  : Result := 4;
        kNXT_DCKeepAlive       : Result := 6;
        kNXT_DCLSGetStatus     : Result := 3;
        kNXT_DCLSRead          : Result := 19;
        kNXT_DCGetCurrentProgramName : Result := 22;
        kNXT_DCMessageRead     : Result := 63;
      else
        Result := 2;
      end;
    end;
    kNXT_SystemCmd :
    begin
      d2 := data;
      inc(d2);
      case d2^ of
        kNXT_SCOpenRead,
        kNXT_SCOpenAppendData,
        kNXT_SCOpenReadLinear        : Result := 7;
        kNXT_SCOpenWrite,
        kNXT_SCOpenWriteData,
        kNXT_SCOpenWriteLinear,
        kNXT_SCClose,
        kNXT_SCCloseModuleHandle     : Result := 3;
        kNXT_SCRead                  :
        begin
          inc(d2); // skip the handle
          inc(d2);
          b1 := d2^;
          inc(d2);
          b2 := d2^;
          count := Word(b1) + (Word(b2) shl 8);
          Result := count + 5;
        end;
        kNXT_SCDelete                : Result := 22;
        kNXT_SCWrite                 : Result := 5;
        kNXT_SCFindFirst,
        kNXT_SCFindNext              : Result := 27;
        kNXT_SCGetVersions,
        kNXT_SCBootCommand           : Result := 6;
        kNXT_SCSetBrickName,
        kNXT_SCDeleteUserFlash,
        kNXT_SCBTFactoryReset        : Result := 2;
        kNXT_SCGetDeviceInfo         : Result := 32;
        kNXT_SCPollCommandLen        : Result := 4;
        kNXT_SCPollCommand           : Result := 64;
        kNXT_SCFindFirstModule,
        kNXT_SCFindNextModule        : Result := 33;
        kNXT_SCIOMapRead             :
        begin
          inc(d2, 4); // skip the module ID (4 bytes)
          inc(d2, 2); // skip the offset (2 bytes)
          inc(d2);
          b1 := d2^;
          inc(d2);
          b2 := d2^;
          count := Word(b1) + (Word(b2) shl 8);
          Result := count + 8;
        end;
        kNXT_SCIOMapWrite            : Result := 8;
        kNXT_SCGetBTAddress          : Result := 2; // not used?
        kNXT_SCRenameFile            : Result := 2; // not used?
      else
        Result := 2;
      end;
    end;
  else
    Result := 0;
  end;
end;

function TRcxLink.ExpectedReplyLength(data : PByte; len : integer) : integer;
begin
  if fTarget = rtNXT then
    Result := PredictNXTReplyLength(data)
  else
    Result := PredictReplyLength(data, len) + 1;
end;

function TRcxLink.TransferFirmware(data: PByte; length, start: integer;
  progress: boolean): integer;
var
  cmd : TRcxCmd;
  check, cksumlen, oldRx, tries : Integer;
  function AdjustingAllowedToString : string;
  begin
    Result := 'false';
    if fTimeoutAdjustingAllowed then Result := 'true';
  end;
begin
  tries := kDefaultRetryCount;
  fTimeoutAdjustingAllowed := False;
//  fTimeoutAdjustingAllowed := PortIsUSB(GetPort) or fFastMode;
  if fVerbose then
    WriteToLog(Format('timeout adjusting allowed = %s'#13#10, [AdjustingAllowedToString()]));
  oldRx := fRxTimeout;
  try
    ResetRxTimeout;
    cmd := TRcxCmd.Create;
    try
      if fVerbose then
        WriteToLog(Format('timeout = %d'#13#10, [fRxTimeout]));

      // delete firmware
      result := Send(cmd.SetVal(kRCX_BootModeOp, 1, 3, 5, 7, 11), tries, not fFastMode, LongTimeout);
      if fFastMode then
      begin
        // for some reason the response doesn't checksum in fast mode
        // just assume it was ok
        result := kRCX_OK;
      end;
      if fVerbose then
        WriteToLog(Format('boot mode result = %d'#13#10, [result]));
      if (RCX_ERROR(result)) then Exit;

      cksumlen := length;
      if cksumlen > $4c00 then cksumlen := $4c00;

      check := Checksum(data, cksumlen);

      result := Send(cmd.SetVal(kRCX_BeginFirmwareOp, Byte(start), Byte(start shr 8),
        Byte(check), Byte(check shr 8), 0), tries, true, LongTimeout);

      if fVerbose then
        WriteToLog(Format('begin firmware result = %d'#13#10, [result]));
      if (RCX_ERROR(result)) then Exit;

      if progress then
        BeginProgress(length)
      else
        BeginProgress(0);

      result := Download(data, length, RCXFirmwareChunkSize);
      if fVerbose then
        WriteToLog(Format('download result = %d'#13#10, [result]));
      if (RCX_ERROR(result)) then Exit;

      // unlock firmware
      // last packet is no-retry with an extra long delay
      // this gives the RCX time to respond and makes sure response doesn't get trampled
      result := Send(cmd.MakeBoot(), tries, false, LongTimeout);
      if fFastMode then
      begin
        // for some reason the response doesn't checksum in fast mode
        // just assume it was ok
        result := kRCX_OK;
      end;

      if fVerbose then
        WriteToLog(Format('make boot result = %d'#13#10, [result]));

    finally
      cmd.Free;
    end;
  finally
    fRxTimeout := oldRx;
    fTimeoutAdjustingAllowed := True;
  end;
end;

procedure TRcxLink.SendFromTxBuffer(delay: Integer);
begin
  // drain serial rx buffer
  NQCSerial.FlushRead(delay);

  // send command
  NQCSerial.Write(fTxData, fTxLength);
  if fVerbose then
  begin
    WriteToLog('Tx: ');
    DumpData(fTxData, fTxLength);
  end;
end;

procedure TRcxLink.BeginProgress(total: integer);
begin
  fDownloadTotal := total;
  fDownloadSoFar := 0;
  DoDownloadStart;
end;

procedure TRcxLink.BuildTxData(data: PByte; length: integer;
  duplicateReduction: boolean);
var
  i : integer;
  b, checksum, dataSum : Byte;
  ptr : PByte;
begin
  dataSum := 0;
  ptr := fTxData;

  if fTarget = rtCybermaster then
  begin
    // CM sync pattern
    ptr^ := $fe;
    Inc(ptr);
    ptr^ := $0;
    Inc(ptr);
    ptr^ := $0;
    Inc(ptr);
    ptr^ := $FF;
    Inc(ptr);
  end
  else if fTarget = rtSpy then
  begin
    ptr^ := $98;
    Inc(ptr);
  end
  else if fTarget = rtNXT then
  begin
    // no header for USB
    if UseBluetooth then
    begin
      ptr^ := LoByte(length);
      Inc(ptr);
      ptr^ := HiByte(length);
      Inc(ptr);
    end;
  end
  else if fFastMode then
  begin
    ptr^ := $FF;
    Inc(ptr);
  end
  else
  begin
    if not fOmitHeader then
    begin
      // RCX sync pattern
      ptr^ := $55;
      Inc(ptr);
      ptr^ := $FF;
      Inc(ptr);
      ptr^ := $0;
      Inc(ptr);
    end;
  end;

  if fTarget = rtNXT then
  begin
    // copy date to transmit buffer
    for i := 0 to length - 1 do
    begin
      b := data^;
      Inc(data);
      if i = 1 then // command is second byte
      begin
        fTxLastCommand := b;
      end;
      ptr^ := b;
      Inc(ptr);
    end;
  end
  else
  begin
    // interleaved data & inverse data
    for i := 0 to length - 1 do
    begin
      b := data^;
      Inc(data);
      if i = 0 then
      begin
        if duplicateReduction and (b = fTxLastCommand) then
          b := b xor 8;
        fTxLastCommand := b;
      end;
      ptr^ := b;
      Inc(ptr);
      if fComplementData then
      begin
        ptr^ := Byte(not b);
        Inc(ptr);
      end;
      dataSum := dataSum + b;
    end;
    // checksum
    checksum := ComputeChecksum(dataSum, fTarget);
    ptr^ := checksum;
    Inc(ptr);
    if fComplementData then
    begin
      ptr^ := Byte(not checksum);
      Inc(ptr);
    end;
  end;
  fTxLength := (DWord(ptr) - DWord(fTxData)) div sizeof(Byte);
end;

function TRcxLink.Close: boolean;
begin
  fSynced := False;
  NQCSerial.Close;
  result := True;
end;

constructor TRcxLink.Create;
begin
  inherited Create;
  fComplementData  := True;
  fQuiet := False;
  fLog := '';
  fTxData  := AllocMem(kMaxTxData * sizeof(Byte));
  fRxData  := AllocMem(kMaxRxData * sizeof(Byte));
  fVerbose := False;
  fSynced  := False;
  fTxLastCommand := 0;
  fRxTimeout     := kMaxTimeout;
  fTimeoutToUse  := kMaxTimeout;
  SetTarget(rtRCX);
  fPort := 'COM1';
  fFastMode := False;
  fOmitHeader := False;
  fRCXFirmwareChunkSize := kFirmwareChunk;
  fDownloadWaitTime     := kDownloadWaitTime;
end;

destructor TRcxLink.Destroy;
begin
  Close;
  FreeMem(fTxData);
  FreeMem(fRxData);
  if Assigned(fSerial) then FreeAndNil(fSerial);
  inherited Destroy;
end;

const
  nOnesDensity : array[0..255] of integer = (
  0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4,
  1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
  1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
  1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
  3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
  1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
  3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
  3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
  3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
  4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8
  );

function TRcxLink.AdjustChunkSize(const n : Integer; const nMaxZeros : Integer;
  const nMaxOnes : Integer; const data: PByte; bComplement : boolean) : Integer;
var
  i, j, nLotsOfOnes, size : Integer;
  p, q : PByte;
const
  kOnesPlusMinusScore = 3;
begin
  size := n;

  // Avoid long strings of zeroes -- fast downloading doesn't like it and messaging
  // can loose sync. Especially with short distances and transmitter set to long
  // range [i.e. high power]

  // Only need this check when complement byte transmission is disabled
  if not bComplement then
  begin

    // first check for zeros
    i := 0;
    while i < (size - nMaxZeros) do
    begin
      p := data;
      Inc(p, i);
      if p^ <> 0 then
      begin
        Inc(i);
        Continue;
      end;

      // found a zero -- check to see how many
      j := 0;
      while j < nMaxZeros do
      begin
        q := data;
        Inc(q, i);
        Inc(q, j);
        if q^ <> 0 then
          Break;
        Inc(j);
      end;

      // have we reached our maximum?
      if j >= nMaxZeros then
      begin
        // too many consecutive zeros. Shorten the message size
        size := i + nMaxZeros;
        if fVerbose then
          WriteToLog(Format('Too many consecutive zeros: size=%d'#13#10, [size]));
        Break;
      end;
      Inc(i);
    end;

    // now check for sparse ones
    i := 0;
    while i < (size - nMaxOnes) do
    begin
      p := data;
      Inc(p, i);
      if nOnesDensity[p^] >= 3 then
      begin
        Inc(i);
        Continue;
      end;

      // found a sparse byte -- check to see how many consecutive
      nLotsOfOnes := 0;
      j := 0;
      while j < nMaxOnes do
      begin
        p := data;
        Inc(p, i);
        Inc(p, j);
        if nOnesDensity[p^] >= 3 then
        begin
          Inc(nLotsOfOnes);
          if nLotsOfOnes > kOnesPlusMinusScore then
            Break;
        end
        else
        begin
          Dec(nLotsOfOnes, 2);
          nLotsOfOnes := Max(0, nLotsOfOnes);
        end;
        Inc(j);
      end;
      if j >= nMaxOnes then
      begin
        // too many consecutive sparse bytes. Shorten the message size
        size := Max(i, nMaxOnes);
        if fVerbose then
          WriteToLog(Format('Too many consecutive sparse bytes: size=%d'#13#10, [size]));
        Break;
      end;
      Inc(i);
    end;
  end;
  Result := size;
end;

function TRcxLink.Download(const data: PByte; length, chunk: integer): integer;
var
  cmd : TRcxCmd;
  seq : Word;
  remain, n, maxZeros : integer;
  tmpD : PByte;
begin
  cmd := TRcxCmd.Create;
  try
    tmpD := data;
    remain := length;
    seq := 1;
    while remain > 0 do
    begin
      if remain <= chunk then
      begin
        if not Quiet then
          seq := 0;
        n := remain;
      end
      else
      begin
        n := chunk;
      end;

      if PortIsUSB(GetPort) then
        maxZeros := K_MAX_ZEROS_USB
      else
        maxZeros := K_MAX_ZEROS_COM;
      n := AdjustChunkSize(n, maxZeros, K_MAX_ONES, tmpD, fComplementData);

//      result := Send(cmd.MakeDownload(seq, tmpD, Word(n)));
//      result := Send(cmd.MakeDownload(seq, tmpD, Word(n)), 10, true, Min(MAX_FIRMWARE_TIMEOUT, 300 + n + ((length-remain) div 50)));
//      result := Send(cmd.MakeDownload(seq, tmpD, Word(n)), 10, true, 1500);
//      result := Send(cmd.MakeDownload(seq, tmpD, Word(n)), 10, true, -1*fRxTimeout);
//      result := Send(cmd.MakeDownload(seq, tmpD, Word(n)), 10, true, -1*fDownloadWaitTime);
      result := Send(cmd.MakeDownload(seq, tmpD, Word(n)), 10, true, Max(MAX_FIRMWARE_TIMEOUT*-1, (fDownloadWaitTime + n)*-1));
      if fVerbose then
        WriteToLog(Format('make download (seq = %d, len = %d) result = %d'#13#10, [seq, n, result]));
      Inc(seq);
      if result < 0 then Exit;

      dec(remain, n);
      Inc(tmpD, n);
      if not IncrementProgress(n) then
      begin
        result := kRCX_AbortError;
        Exit;
      end;
    end;
    result := kRCX_OK;
  finally
    cmd.Free;
  end;
end;

function TRcxLink.DownloadProgress(soFar, total: integer): boolean;
begin
  result := true;
end;

function TRcxLink.GetBatteryLevel: integer;
var
  cmd : TRcxCmd;
begin
  cmd := TRcxCmd.Create;
  try
    result := Sync();
    if RCX_ERROR(result) then Exit;

    if fTarget = rtScout then
    begin
      result := Send(cmd.SetVal(kRCX_PollMemoryOp, $3a, $01, $01));
      if result <> 1 then
      begin
        result := kRCX_ReplyError;
        Exit;
      end;
      result := Integer(GetReplyByte(0)) * 109;
    end
    else
    begin
      if fTarget = rtNXT then
        result := Send(cmd.SetVal(kNXT_DirectCmd, kNXT_DCGetBatteryLevel))
      else
        result := Send(cmd.SetVal(kRCX_BatteryLevelOp));
      if result <> 2 then
      begin
        result := kRCX_ReplyError;
        Exit;
      end;
      result := Integer(GetReplyByte(0)) + (Integer(GetReplyByte(1)) shl 8);
    end;
  finally
    cmd.Free;
  end;
end;

function TRcxLink.GetReply(data: PByte; maxLength: integer): integer;
var
  length, i : integer;
  src : PByte;
begin
  if fResult < 0 then
  begin
    result := fResult;
    Exit;
  end;

  src := @fReply[0];
  Inc(src);

  length := fResult;
  if length > maxLength then
    length := maxLength;
  i := 0;
  while i < length do
  begin
    Inc(i);
    data^ := src^;
    Inc(data);
    Inc(src);
  end;

  result := length;
end;

function TRcxLink.GetReplyByte(const index: integer): Byte;
begin
  Result := fReply[index + TargetCommandOffset];
end;

function BytesToCardinal(b1 : byte; b2 : byte = 0; b3 : byte = 0; b4 : Byte = 0) : Cardinal;
begin
  Result := Cardinal(b1) + (Cardinal(b2) shl 8) + (Cardinal(b3) shl 16) + (Cardinal(b4) shl 24);
end;

function TRcxLink.GetReplyWord(const index: integer): Word;
begin
  Result := Word(BytesToCardinal(GetReplyByte(index), GetReplyByte(index+1)));
end;

function TRcxLink.GetReplyCardinal(const index: integer): Cardinal;
begin
  Result := BytesToCardinal(GetReplyByte(index),
                            GetReplyByte(index+1),
                            GetReplyByte(index+2),
                            GetReplyByte(index+3));
end;

function TRcxLink.GetReplyString(const index, len: integer): string;
var
  i : integer;
begin
  Result := '';
  for i := index to index + len do
  begin
    Result := Result + Chr(GetReplyByte(i));
  end;
end;

function TRcxLink.GetValue(value: integer): integer;
var
  cmd : TRcxCmd;
begin
  cmd := TRcxCmd.Create;
  try
    result := Sync();
    if RCX_ERROR(result) then Exit;

    result := Send(cmd.MakePoll(value));
    if RCX_ERROR(result) then Exit;
    if result <> 2 then
    begin
      result := kRCX_ReplyError;
      Exit;
    end;

    result := Integer(GetReplyByte(0)) + (Integer(GetReplyByte(1)) shl 8);
  finally
    cmd.Free;
  end;
end;

function TRcxLink.GetVerbose: boolean;
begin
  result := fVerbose;
end;

function TRcxLink.GetVersion(var rom, ram: Cardinal): integer;
var
  cmd : TRcxCmd;
  reply : array[0..7] of Byte;
begin
  if fVerbose then
    WriteToLog('attempting to GetVersion'#13#10);
  cmd := TRcxCmd.Create;
  try
    result := Sync();
    if fVerbose then
      WriteToLog(Format('sync result = %d'#13#10, [result]));
    if RCX_ERROR(result) then Exit;

    result := Send(cmd.MakeUnlock());
    if fVerbose then
      WriteToLog(Format('make unlock result = %d'#13#10, [result]));
    if RCX_ERROR(result) then Exit;

    if result <> 8 then
    begin
      result := kRCX_ReplyError;
      Exit;
    end;

    GetReply(@reply[0],8);

    rom := (Cardinal(reply[0]) shl 24) or (Cardinal(reply[1]) shl 16) or
           (Cardinal(reply[2]) shl 8) or Cardinal(reply[3]);
    ram := (Cardinal(reply[4]) shl 24) or (Cardinal(reply[5]) shl 16) or
           (Cardinal(reply[6]) shl 8) or Cardinal(reply[7]);

    if fVerbose then
      WriteToLog(Format('version = %8.8x/%8.8x'#13#10, [rom, ram]));
    result := kRCX_OK;
  finally
    cmd.Free;
  end;
end;

function TRcxLink.IncrementProgress(delta: integer): boolean;
begin
  Inc(fDownloadSoFar, delta);
  if fDownloadTotal <> 0 then
    result := DownloadProgress(fDownloadSoFar, fDownloadTotal)
  else
    result := true;
end;

function TRcxLink.Open(const aPort : string): boolean;
var
  myport : string;
begin
  Port := aPort;
  myport := PortName;
  Result := NQCSerial.Open(myport);
  if not Result then Exit;

  if fTarget = rtSpy then
    NQCSerial.SetSpeed(LT_SPEED_BPS_4800, kPSerial_ParityOdd)
  else if fTarget = rtNXT then
    NQCSerial.SetSpeed(LT_SPEED_BPS_460800, kPSerial_ParityNone)
  else if fFastMode then
    NQCSerial.SetSpeed(LT_SPEED_BPS_4800)
  else
    NQCSerial.SetSpeed(LT_SPEED_BPS_2400, kPSerial_ParityOdd);

  if (fTarget = rtCybermaster) or (fTarget = rtSpy) then
  begin
    NQCSerial.SetDTR(true);
    NQCSerial.SetRTS(false);
  end
  else if fTarget = rtNXT then
  begin
    NQCSerial.SetDTR(true);  // ???
    NQCSerial.SetRTS(false); // ???
  end;
  SetSyncPointer;
end;

function TRcxLink.Send(cmd: TBaseCmd; tryCount : integer; retry: boolean;
  timeout: integer): integer;
begin
  result := Send(cmd.GetBody, cmd.GetLength, tryCount, retry, timeout);
end;

function TRcxLink.TransportVerifyReply(const rxExpected : integer; data : PByte; length : integer; cmd : Byte) : integer;
var
  dataSum : Byte;
  ptr, _end, match, tmpD : PByte;
  width : Integer;
  complementCmd : Boolean;

  function CmdWidth : Integer;
  begin
    if complementCmd then Result := 2
    else Result := 1;
  end;
begin
  // skip verification for NXT
  if fTarget = rtNXT then
  begin
    Result := rxExpected;
  end
  else
  begin
    dataSum := data^;
    ptr := data;
    match := nil;
    if fComplementData then
      width := 2
    else
      width := 1;

    _end := data;
    Inc(_end, length + 1 - width);

    if fFastMode and ((cmd and $f7) = $a5) then
      complementCmd := true
    else
      complementCmd := fComplementData;
    if length < (CmdWidth + width) then
    begin
      Result := 0;
      Exit;
    end;

    // check the cmd
    if (ptr^ and $f7) <> ((not cmd) and $f7) then
    begin
      result := 0;
      Exit;
    end;
    Inc(ptr);

    if complementCmd then
    begin
      if (ptr^ and $f7) <> (cmd and $f7) then
      begin
        result := 0;
        Exit;
      end;
      Inc(ptr);
    end;

    while Integer(ptr) < Integer(_end) do
    begin
      tmpD := ptr;
      Inc(tmpD);
      if fComplementData and ((ptr^ and $f7) <> ((not tmpD^) and $f7)) then
        break;

      if ptr^ = ComputeChecksum(dataSum, fTarget) then
        match := ptr;

      dataSum := dataSum + ptr^;
      Inc(ptr,width);
    end;

    // certain spybot responses have screwed-up checksums when
    // communicating via USB tower
    if (match = nil) and (fTarget = rtSpy) and PortIsUSB(GetPort) then
    begin
      if length = rxExpected+1 then
        match := PByte(PChar(_end) - 1);
    end;

    if match = nil then
    begin
      result := 0;
      Exit;
    end;

    result := ((Integer(match) - Integer(data)) div width);
  end;
end;

function TRcxLink.TransportFindReply(const rxExpected : integer; var offset: integer): integer;
var
  tmpRxD : PByte;
  length, start : Integer;
begin
  offset := 0;
  if UseBluetooth then
    inc(offset, 2); // skip the length bytes
  while true do
  begin
    tmpRxD := fRxData;
    Inc(tmpRxD, offset);
    start := FindSync(tmpRxD, fRxLength - offset, fSync, fTxLastCommand, fTarget <> rtNXT);

    if start = 0 then
    begin
      Result := 0;
      Exit;
    end;

    Inc(offset, start);

    tmpRxD := fRxData;
    Inc(tmpRxD, offset);
    length := TransportVerifyReply(rxExpected, tmpRxD, fRxLength - offset, fTxLastCommand);

    if length > 0 then
    begin
      Result := length;
      Exit;
    end;
  end;
end;

procedure TRcxLink.TransportCopyReply(dst : PByte; offset : Integer; length : Integer);
var
  src : PByte;
begin
  if fTarget = rtNXT then
    inc(length); // account for the extra status byte
  src := fRxData;
  Inc(src, offset);
  while length > 0 do
  begin
    dst^ := src^;
    Inc(dst);
    Inc(src);
    if fComplementData then
      Inc(src);
    Dec(length);
  end;
end;

procedure TRcxLink.TransportAdjustTimeout(TheResult : integer; attempt : integer);
var
  newTimeout : Integer;
begin
  newTimeout := fRxTimeout;
  if not RCX_ERROR(TheResult) and (attempt = 0) then
  begin
    // go faster
    newTimeout := fRxTimeout - (fRxTimeout div 10);
    if newTimeout < kMinTimeout then
      newTimeout := kMinTimeout;
  end
  else if RCX_ERROR(TheResult) and (attempt > 0) then
  begin
    // slow down
    newTimeout := newTimeout * 2;
    if newTimeout > kMaxTimeout then
      newTimeout := kMaxTimeout;
  end;
  if newTimeout <> fRxTimeout then
    fRxTimeout := newTimeout;
  if fVerbose then
    WriteToLog(Format('timeout = %d'#13#10, [fRxTimeout]));
end;

function TRcxLink.ExpectedReceiveLen(const rxExpected : Integer) : integer;
begin
  Result := rxExpected;
  if fTarget = rtNXT then
  begin
    inc(Result); // 1 byte for header
    if UseBluetooth then
      inc(Result, 2); // 2 bytes for length
  end
  else
  begin
    if fComplementData then
      Result := Result * 2;
    if (fFastMode and ((fTxLastCommand and $f7) = $a5)) or fComplementData then
      Result := Result + 2
    else
      Result := Result + 1;
    // allow at least one byte for the header
    Inc(Result, 3); // 3 bytes for header
  end;
end;

function TRcxLink.TransportReceiveReply(rxExpected, timeout, tryCount : Integer;
  var replyOffset : Integer) : Integer;
var
  length : Integer;
  tmpRxD : PByte;
  receiveLen, bytesRead, tmpLen : Integer;
  bFirstRead : boolean;
begin
  receiveLen := ExpectedReceiveLen(rxExpected);
  if not ((fTarget = rtSpy) or PortIsUSB(GetPort)) then
    inc(receiveLen, fTxLength); // the serial tower echoes the transmitted data
  fRxLength := 0;
  length := 0;
  bFirstRead := True;
  while fRxLength < kMaxRxData do
  begin
    tmpRxD := fRxData;
    Inc(tmpRxD,fRxLength);

    if bFirstRead then
    begin
      bFirstRead := False;
      if fVerbose then
        WriteToLog(Format('Reading %d bytes. timeout = %d'#13#10, [receiveLen, timeout]));
      bytesRead := NQCSerial.Read(tmpRxD, receiveLen, timeout);
      if fVerbose then
        WriteToLog(Format('Bytes read = %d'#13#10, [bytesRead]));
      if bytesRead = 0 then
      begin
        // we will try a second time with a shorter timeout.
        if fVerbose then
          WriteToLog(Format('bytesRead = 0.  Trying again. timeout = %d'#13#10, [timeout div 2]));
        bytesRead := NQCSerial.Read(tmpRxD, receiveLen, timeout div 2);
        if bytesRead = 0 then
        begin
          if fVerbose then
            WriteToLog('bytesRead is still 0.'#13#10);
          Break;
        end;
      end;
      Inc(fRxLength, bytesRead);
    end
    else
    begin
      tmpLen := Max(receiveLen-fRxLength, 1);
      if fVerbose then
        WriteToLog(Format('Reading %d bytes. timeout = %d'#13#10, [tmpLen, abs(timeout div 2)]));
      bytesRead := NQCSerial.Read(tmpRxD, tmpLen, abs(timeout div 2));
      if bytesRead = 0 then
        Break;
      inc(fRxLength, bytesRead);
{
      if fVerbose then
        WriteToLog(Format('Reading 1 byte. timeout = %d'#13#10, [abs(timeout div 2)]));
      if NQCSerial.Read(tmpRxD, 1, abs(timeout div 2)) <> 1 then
        Break;
      Inc(fRxLength);
}
    end;

//    if NQCSerial.Read(tmpRxD, 1, timeout) <> 1 then
//      Break;
//    Inc(fRxLength);

//    if fRxLength < receiveLen then Continue;

    length := TransportFindReply(rxExpected, replyOffset);
    if length = rxExpected then
      Break;
  end;
  if fVerbose then
  begin
    WriteToLog('Reply Offset = ' + IntToStr(replyOffset) + #13#10);
    WriteToLog('Rx: ');
    DumpData(fRxData, fRxLength);
  end;

  if (fRxLength = 0) and not PortIsUSB(GetPort) and (fTarget <> rtCybermaster) then
  begin
    Result := kRCX_IREchoError;
    Exit;
  end;

  if length = 0 then
  begin
    Result := kRCX_ReplyError;
    Exit;
  end;

  Result := length - TargetCommandOffset;
end;

function TRcxLink.TransportSend(const txData : PByte; txLength : integer;
  rxData : PByte; rxExpected : Integer; rxMax : Integer; retry : Boolean;
  timeout : integer; tryCount : integer) : Integer;
var
  tmpTimeout, replyOffset, tries, length, originalTimeout, i : integer;
begin
  Result := 0;

  BuildTxData(txData, txLength, retry);

  if retry then
    tries := tryCount
  else
    tries := 1;

  originalTimeout := fRxTimeout;

  i := 0;
  while i < tries do
  begin
    if fFastMode then
      SendFromTxBuffer(100)
    else
      SendFromTxBuffer(0);

	  // if no reply is expected, we can just return now (no retries, no errors, etc)
    if (rxExpected = 0) then
    begin
      Result := kRCX_OK;
      Exit;
    end;

    if timeout <> 0 then
      tmpTimeout := timeout
    else
      tmpTimeout := fRxTimeout;

    // special case for negative timeouts and retrying
    if (i > 0) and (timeout < 0) then
      tmpTimeout := fRxTimeout * -1;

    replyOffset := 0;
    Result := TransportReceiveReply(rxExpected, tmpTimeout, i, replyOffset);
    if fDynamicTimeout and fTimeoutAdjustingAllowed then
      TransportAdjustTimeout(Result, i);

    if not RCX_ERROR(Result) then
    begin
      if rxData <> nil then
      begin
        length := Result+1;
        if length > rxMax then
          length := rxMax;
        TransportCopyReply(rxData, replyOffset, length);
      end;

      Exit;
    end;

    // only the second kRCX_IREchoError is catastrophic
    // this is somewhat of a hack - I really should keep track
    // of the echo, but for now this makes sure that a serial
    // level failure on a single packet doesn't kill the entire
    // send
    if (Result = kRCX_IREchoError) and (i > 0) then
      Break;

    Inc(i);
    if fVerbose and retry then
      WriteToLog(Format('retrying last TransportSend (%d)'#13#10, [i]));
  end;

  if fVerbose then
    WriteToLog('TransportSend failed'#13#10);
  // retries exceeded, restore original timeout and lose the sync
  if retry then
  begin
    if fDynamicTimeout then
      fRxTimeout := originalTimeout;
    fSynced := false;
  end;
end;

procedure TRcxLink.TransportSetFastMode(fast, comp: Boolean);
begin
  if fast = fFastMode then Exit;

  if fast then
  begin
    fComplementData := false;
    if not comp then
      NQCSerial.SetSpeed(LT_SPEED_BPS_4800);
  end
  else
  begin
    fComplementData := not (fTarget in [rtSpy, rtNXT]);
    NQCSerial.SetSpeed(LT_SPEED_BPS_2400, kPSerial_ParityOdd);
  end;

  fFastMode := fast;
end;

function TRcxLink.Send(data: PByte; length: integer; tryCount : integer;
  retry: boolean; timeout: integer): integer;
var
  expected : Integer;
  T0 : Cardinal;
begin
  T0 := GetTickCount;
  expected := ExpectedReplyLength(data, length);

  if (length > kMaxCmdLength) or (expected > kMaxReplyLength) then
  begin
    result := kRCX_RequestError;
    Exit;
  end;

  fResult := TransportSend(data, length, @fReply[0], expected,
    kMaxReplyLength, retry, timeout, tryCount);

  result := fResult;
  if fVerbose then
    WriteToLog(Format('Total time = %d'#13#10, [GetTickCount-T0]));
end;

function TRcxLink.Send1(data: PByte; length: integer): integer;
begin
  if length > kMaxCmdLength then
  begin
    result := kRCX_RequestError;
    Exit;
  end;

  // format the command
  BuildTxData(data, length, false);
  NQCSerial.Write(fTxData, fTxLength);
  result := kRCX_OK;
end;

function TRcxLink.DownloadFirmware(const data: PByte; length, start: integer;
  fast, comp: boolean): integer;
begin
  if fast then
  begin
    // send the nub first
    if PortIsUSB(GetPort) then
    begin
      if comp then
        result := TransferFirmware(@rcxusbnub3[0], sizeof(rcxusbnub3), kNubStart, false)
      else
        result := TransferFirmware(@rcxusbnub[0], sizeof(rcxusbnub), kNubStart, false);
    end
    else
    begin
      if comp then
        result := TransferFirmware(@rcxnub3[0], sizeof(rcxnub3), kNubStart, false)
      else
        result := TransferFirmware(@rcxnub[0], sizeof(rcxnub), kNubStart, false);
    end;
    if fVerbose then
      WriteToLog(Format('initial transfer result = %d'#13#10, [result]));
    if RCX_ERROR(result) then Exit;

    // switch to fast mode
    TransportSetFastMode(true, comp);

    result := TransferFirmware(data, length, start, true);
    if fVerbose then
      WriteToLog(Format('full transfer result = %d'#13#10, [result]));

    TransportSetFastMode(false, comp);
  end
  else
  begin
    result := TransferFirmware(data, length, start, true);
  end;
end;

(*
function TRcxLink.SendFragment(ftype: TRcxFragment; taskNumber: Byte;
  const data: PByte; length, total: integer): integer;
var
  cmd : TRcxCmd;
begin
  cmd := TRcxCmd.Create;
  try
    result := Sync;
    if RCX_ERROR(result) then Exit;

    result := Send(cmd.MakeBegin(ftype, taskNumber, Word(length)));
    if RCX_ERROR(result) then Exit;

    // make sure we have enough room
    if (result <> 1) or (GetReplyByte(0) <> 0) then
    begin
      result := kRCX_MemFullError;
      Exit;
    end;

    if total = 0 then
      total := length;

    if total > 0 then
      BeginProgress(total);

    result := Download(data, length, kFragmentChunk);
  finally
    cmd.Free;
  end;
end;
*)

procedure TRcxLink.SetRxTimeout(t: integer);
begin
  fTimeoutToUse := t;
  fRxTimeout := t;
  fDynamicTimeout := false;
end;

procedure TRcxLink.SetVerbose(b: boolean);
begin
  fVerbose := b;
end;

function TRcxLink.Sync(bScoutPower : Boolean) : integer;
var
  cmd : TRcxCmd;
begin
  if fSynced then begin
    Result := kRCX_OK;
    Exit;
  end;
  if fTarget = rtNXT then
  begin
    fSynced := true;
    Result := kRCX_OK;
    Exit;
  end;
  cmd := TRcxCmd.Create;
  try
    if (fTarget = rtSpy) and PortIsUSB(GetPort) then
    begin
      // turn off pinging
      Result := Send(cmd.MakeSet(RCX_VALUE(kRCX_SpybotPingCtrlType, 1),
                                 RCX_VALUE(kRCX_ConstantType, 0)));
    end;
    // always start with a ping
//    Result := Send(cmd.MakePing(), kDefaultRetryCount, False, LongTimeout);
    Result := Send(cmd.MakePing());
    // if error, try a second time
    if Result = kRCX_ReplyError then
//      Result := Send(cmd, kDefaultRetryCount, False, LongTimeout);
      Result := Send(cmd);
    if RCX_ERROR(Result) then Exit;

    // cybermaster requires an unlock also
    if fTarget = rtCybermaster then
    begin
      Result := Send(cmd.MakeUnlockCM());
      if RCX_ERROR(Result) then
        Exit;
    end
    else if fTarget = rtScout then
    begin
      Result := Send(cmd.MakeBoot());
      if RCX_ERROR(Result) then Exit;

      if bScoutPower then
      begin
        Result := Send(cmd.SetVal(kRCX_ScoutOp, $80));
        if RCX_ERROR(Result) then Exit;
      end;
    end;

    fSynced := true;
    Result := kRCX_OK;
  finally
    cmd.Free;
  end;
end;

procedure TRcxLink.SetTarget(target: TBrickType);
begin
  fTarget := target;
  fPredictive := true;
  fDynamicTimeout := true;
  ResetRxTimeout;

  fComplementData := not (target in [rtSpy, rtNXT]);
end;

procedure TRcxLink.WriteToLog(s: string);
begin
  fLog := fLog + s;
end;

procedure TRcxLink.ClearLog;
begin
  fLog := '';
end;

procedure TRcxLink.DumpData(ptr: PByte; length: integer);
var
  i : integer;
  s : string;
begin
  s := '';
  for i := 0 to length - 1 do
  begin
    s := s + Format('%2.2x ', [ptr^]);
    Inc(ptr);
  end;
  WriteToLog(s + #13#10);
end;

procedure TRcxLink.DoDownloadDone;
begin
  if Assigned(fOnDownloadDone) then
    fOnDownloadDone(self);
end;

procedure TRcxLink.DoDownloadStart;
begin
  if Assigned(fOnDownloadStart) then
    fOnDownloadStart(self);
end;

procedure TRcxLink.DoDownloadStatus(cur, total : Integer; var Abort: boolean);
begin
  Abort := False;
  if assigned(fOnDownloadStatus) then
    fOnDownloadStatus(self, cur, total, Abort);
end;

function TRcxLink.GetMemMap(aMemMap: TStrings): integer;
const
  K_RCX_LEN = 188;
  K_CYBER_LEN = 20;
  K_SCOUT_LEN = 22;
  K_SPY_LEN = 18;
var
  cmd : TRcxCmd;
  b1, b2 : Byte;
  i, j, val : integer;
//  addr : Word;
begin
  aMemMap.Clear;
  cmd := TRcxCmd.Create;
  try
    result := Sync();
    if RCX_ERROR(result) then Exit;

    if fTarget = rtScout then
    begin
      // scout memory map starts at $0233 and it is 22 bytes long
      result := Send(cmd.SetVal(kRCX_PollMemoryOp, Lo(ADDR_MEM), Hi(ADDR_MEM), K_SCOUT_LEN));
      if result <> K_SCOUT_LEN then
      begin
        result := kRCX_ReplyError;
        Exit;
      end;
      i := 0;
      while i < result do
      begin
        b1  := GetReplyByte(i);
        b2  := GetReplyByte(i+1);
        val := (Cardinal(b2) shl 8) or Cardinal(b1);
        aMemMap.Add(IntToStr(val));
        Inc(i, 2);
      end;
    end
    else if fTarget = rtSpy then
    begin
(*
      j := $100;
      while j <= $184 do begin
        b1  := Poll(kRCX_SpybotEepromType, j);
        b2  := Poll(kRCX_SpybotEepromType, j+1);;
        val := (Cardinal(b2) shl 8) or Cardinal(b1);
        aMemMap.Add(IntToStr(val));
        Inc(j, 2);
      end;
*)
      // the memory map is in block 16 through block 24
      for j := 16 to 24 do
      begin
        Result := Send(cmd.SetVal(kRCX_UploadEepromOp, j));
        if result <> 16 then
        begin
          result := kRCX_ReplyError;
          Exit;
        end;
        i := 0;
        while (i < Result) and (aMemMap.Count < 66) do
        begin
          b1  := GetReplyByte(i);
          b2  := GetReplyByte(i+1);
          // bytes 6-8 are fouled up if we are using the USB port
          val := (Cardinal(b2) shl 8) or Cardinal(b1);
          aMemMap.Add(IntToStr(val));
          Inc(i, 2);
        end;
      end;
    end
    else
    begin
      result := Send(cmd.SetVal(kRCX_MemMapOp));

      if fTarget = rtCybermaster then
      begin
        if result <> K_CYBER_LEN then
        begin
          result := kRCX_ReplyError;
          Exit;
        end;
      end
      else
      begin
        if result <> K_RCX_LEN then
        begin
          result := kRCX_ReplyError;
          Exit;
        end;
      end;
      i := 0;
      while i < result do
      begin
        b1  := GetReplyByte(i);
        b2  := GetReplyByte(i+1);
        val := (Cardinal(b1) shl 8) or Cardinal(b2) - 32768;
        aMemMap.Add(IntToStr(val));
        Inc(i, 2);
      end;
    end;
    result := kRCX_OK;
  finally
    cmd.Free;
  end;
end;

function TRcxLink.MonitorIR(aIR: TStrings; aSeconds: Integer): Integer;
var
  T1 : Cardinal;
  buffer : array[0..101] of Byte;
  bread, i : Integer;
  tmpStr : string;
begin
  aIR.Clear;
  T1 := GetTickCount;
  while (GetTickCount - T1) < Cardinal(aSeconds * 1000) do
  begin
    bread := NQCSerial.Read(@(buffer[0]), 100, -1);
    if bread > 0 then
    begin
      tmpStr := '';
      for i := 0 to bread - 1 do
        tmpStr := tmpStr + Format(' %2.2x', [buffer[i]]);
      aIR.Add(tmpStr);
    end;
  end;
  Result := kRCX_OK;
end;

function TRcxLink.GetOutputStatus(aOut: Byte): integer;
var
  cmd : TRcxCmd;
begin
  if fTarget = rtScout then
  begin
    cmd := TRcxCmd.Create;
    try
      result := Sync();
      if RCX_ERROR(result) then Exit;
      // aOut = 0, 1, 2.  For the scout the motor state is located at memory
      // addresses 144, 145, and 146.
      result := Send(cmd.SetVal(kRCX_PollMemoryOp, $44 + aOut, $01, $01));
      if result <> 1 then
      begin
        result := kRCX_ReplyError;
        Exit;
      end;
      result := GetReplyByte(0);
    finally
      cmd.Free;
    end;
  end
  else
  begin
    result := Poll(kRCX_OutputStatusType, aOut);
  end;
end;

function TRcxLink.GetVariableValue(aVar: Byte): Integer;
var
  cmd : TRcxCmd;
  addr : Word;
begin
  if fTarget = rtScout then
  begin
    cmd := TRcxCmd.Create;
    try
      result := Sync();
      if RCX_ERROR(result) then Exit;

      // global variables start at ADDR_GV and go up from there by Two's
      // aOut = 0, 1, 2.  For the scout the motor state is located at memory
      // addresses 144, 145, and 146.
      addr := ADDR_GV + aVar*2;
      result := Send(cmd.SetVal(kRCX_PollMemoryOp, Lo(addr), Hi(addr), $02));
      if result <> 2 then
      begin
        result := kRCX_ReplyError;
        Exit;
      end;
      result := SmallInt(Cardinal(GetReplyByte(1) shl 8) + GetReplyByte(0));
    finally
      cmd.Free;
    end;
  end
  else
  begin
    result := Poll(kRCX_VariableType, aVar);
  end;
end;

function TRcxLink.GetInputValue(aIn: Byte): Integer;
var
  cmd : TRcxCmd;
  addr : Word;
begin
  if fTarget = rtScout then
  begin
    cmd := TRcxCmd.Create;
    try
      result := Sync();
      if RCX_ERROR(result) then Exit;
      // inputs start at ADDR_IO and go up from there by Two's
      addr := ADDR_IO + aIn*2;
      result := Send(cmd.SetVal(kRCX_PollMemoryOp, Lo(addr), Hi(addr), $02));
      if result <> 2 then
      begin
        result := kRCX_ReplyError;
        Exit;
      end;
      result := SmallInt(Cardinal(GetReplyByte(1) shl 8) + GetReplyByte(0));
    finally
      cmd.Free;
    end;
  end
  else
  begin
    result := Poll(kRCX_InputValueType, aIn);
  end;
end;

function TRcxLink.GetMessageValue(aNum: Byte) : Integer;
var
  cmd : TRcxCmd;
  addr : Word;
begin
  if fTarget = rtScout then
  begin
    cmd := TRcxCmd.Create;
    try
      result := Sync();
      if RCX_ERROR(result) then Exit;
      // PB Message is at ADDR_MESSAGE (aNum is ignored)
      addr := ADDR_MESSAGE;
      result := Send(cmd.SetVal(kRCX_PollMemoryOp, Lo(addr), Hi(addr), $01));
      if result <> 1 then
      begin
        result := kRCX_ReplyError;
        Exit;
      end;
      result := GetReplyByte(0);
    finally
      cmd.Free;
    end;
  end
  else
  begin
    result := Poll(kRCX_MessageType, aNum);
  end;
end;

function TRcxLink.GetTimerValue(aNum: Byte): Integer;
var
  cmd : TRcxCmd;
  addr : Word;
begin
  if fTarget = rtScout then
  begin
    cmd := TRcxCmd.Create;
    try
      result := Sync();
      if RCX_ERROR(result) then Exit;
      // timers are at ADDR_TMR and go up by 2
      addr := ADDR_TMR + aNum*2;
      result := Send(cmd.SetVal(kRCX_PollMemoryOp, Lo(addr), Hi(addr), $02));
      if result <> 2 then
      begin
        result := kRCX_ReplyError;
        Exit;
      end;
      result := SmallInt(Cardinal(GetReplyByte(1) shl 8) + GetReplyByte(0));
    finally
      cmd.Free;
    end;
  end
  else
  begin
    result := Poll(kRCX_TimerType, aNum);
  end;
end;

function TRcxLink.GetCounterValue(aNum: Byte): Integer;
var
  cmd : TRcxCmd;
  addr : Word;
begin
  if fTarget = rtScout then
  begin
    if aNum > 1 then
    begin
      result := 0;
      Exit;
    end;
    cmd := TRcxCmd.Create;
    try
      result := Sync();
      if RCX_ERROR(result) then Exit;
      // counters are at ADDR_CTR and go up by 2
      addr := ADDR_CTR + aNum*2;
      result := Send(cmd.SetVal(kRCX_PollMemoryOp, Lo(addr), Hi(addr), $02));
      if result <> 2 then
      begin
        result := kRCX_ReplyError;
        Exit;
      end;
      result := SmallInt(Cardinal(GetReplyByte(1) shl 8) + GetReplyByte(0));
    finally
      cmd.Free;
    end;
  end
  else
  begin
    result := Poll(kRCX_CounterType, aNum);
  end;
end;

function TRcxLink.Poll(aSrc, aNum: integer): integer;
var
  cmd : TRcxCmd;
  val, cnt : integer;
begin
  cmd := TRcxCmd.Create;
  try
    result := Sync();
    if RCX_ERROR(result) then Exit;

    val := integer((aSrc shl 16) or (aNum and $FFFF));
    cnt := Send(cmd.MakePoll(val));
    if cnt <> 2 then
    begin
      result := -1;
      Exit;
    end;
    result := SmallInt(Cardinal(GetReplyByte(1) shl 8) + GetReplyByte(0));
  finally
    cmd.Free;
  end;
end;

procedure TRcxLink.SetFastMode(const Value: boolean);
begin
  if Value = fFastMode then Exit;
  Close;
  if Value then
    fComplementData := False
  else
    fComplementData := not (fTarget in [rtSpy, rtNXT]);
  fFastMode := Value;
end;

function TRcxLink.GetNQCSerial: TNQCSerial;
begin
  if not Assigned(fSerial) then begin
    if PortIsUSB(GetPort) then
      fSerial := TNQCUsbTower.Create
    else if Target = rtSpy then
      fSerial := TNQCSpybotSerial.Create
    else
      fSerial := TNQCSerial.Create;
  end;
  fSerial.ForceRCXFrequency := Target <> rtSpy;
  result := fSerial;
end;

function TRcxLink.GetPortName: string;
begin
  if PortIsUSB(GetPort) then
    Result := USB_TOWER
  else
    Result := COM_PORT + GetPort;
end;

function TRcxLink.GetPort: string;
begin
  Result := fPort;
end;

procedure TRcxLink.SetPort(const Value: string);
var
  tmp : TNQCSerial;
begin
  if Value <> fPort then begin
    fPort := Value;
    tmp := fSerial;
    fSerial := nil;
    tmp.Free;
  end;
end;

procedure TRcxLink.DoOpenStateChanged;
begin
  if Assigned(FOnOpenStateChanged) then
    FOnOpenStateChanged(self);
end;

procedure TRcxLink.SetSyncPointer;
begin
  case fTarget of
    rtCybermaster : fSync := @cmSync;
    rtSpy : fSync := @spyboticsSync;
    rtNXT : fSync := @nxtSync;
  else
    if PortIsUSB(GetPort) then
      fSync := @rcxNo55Sync
    else
      fSync := @rcxSync;
  end;
end;

procedure TRcxLink.ResetRxTimeout;
begin
  if fPredictive then
    fRxTimeout := fTimeoutToUse
  else
    fRxTimeout := kMinTimeout;
end;

function TRcxLink.LongTimeout: Integer;
begin
  Result := RxTimeout * -2;
end;

function TRcxLink.GetActive: boolean;
begin
  Result := NQCSerial.Active;
end;

procedure TRcxLink.SetUseBT(const Value: boolean);
begin
  if Value = fUseBT then Exit;
  Close;
  fUseBT := Value;
end;

function TRcxLink.TargetCommandOffset: byte;
begin
  Result := 1;
  if fTarget = rtNXT then
    inc(Result);
end;

{ TAutoLink }

function TAutoLink.Close: boolean;
begin
  if Active then
  begin
    inherited Close;
    DoOpenStateChanged;
  end;
  Result := True;
end;

function TAutoLink.DownloadProgress(soFar, total: integer): boolean;
var
  abort : boolean;
begin
  result := inherited DownloadProgress(soFar, total);
  if result then
  begin
    DoDownloadStatus(soFar, total, abort);
    result := not abort;
  end;
  if abort or (soFar >= total) then
    DoDownloadDone;
end;

function TAutoLink.Open : boolean;
begin
  if not Active then
  begin
    Result := inherited Open(Port);
    if Result then
      DoOpenStateChanged;
  end
  else
    Result := True;
end;

function TAutoLink.Send(cmd: TBaseCmd; tryCount : integer; bRetry: boolean): integer;
var
  val : boolean;
begin
  Result := kRCX_OpenSerialError;
  val := Open;
  if val then
  begin
    if bRetry then
    begin
      Result := Sync;
      val := RCX_ERROR(result);
      if val then Exit;
    end;
    Result := inherited Send(cmd, tryCount, bRetry);
  end;
end;

procedure TAutoLink.SetPort(const Value: string);
var
  tmp : TNQCSerial;
begin
  if Value <> fPort then begin
    fPort := Value;
    tmp := fSerial;
    fSerial := nil;
    tmp.Free;
    Close;
  end;
end;

end.
