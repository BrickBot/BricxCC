(*
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * The Initial Developer of this code is John Hansen.
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit FakeSpirit;

interface

uses
  Classes, SysUtils, rcx_link, rcx_constants, uSpirit, FantomDefs;

type
  EMessageInvalid = class(Exception)
  public
    constructor Create(aMsg : string);
  end;

type
  TFakeSpirit = class(TBrickComm)
  private
    fLink : TAutoLink;
  protected
    function  GetDownloadWaitTime: Integer; override;
    function  GetEEPROM(addr: Byte): Byte; override;
    function  GetEEPROMBlock(idx: Integer): EEPROMBlock; override;
    function  GetIsOpen: boolean; override;
    function  GetLSBlock(port: byte): NXTLSBlock; override;
    function  GetOmitHeader: Boolean; override;
    function  GetPortName: string; override;
    function  GetQuiet: Boolean; override;
    function  GetRCXFirmwareChunkSize: Integer; override;
    function  GetRxTimeout: Word; override;
    function  GetLinkLog: string; override;
    procedure SetBrickType(const Value: byte); override;
    procedure SetDownloadWaitTime(const Value: Integer); override;
    procedure SetEEPROM(addr: Byte; const Value: Byte); override;
    procedure SetFastMode(const Value: boolean); override;
    procedure SetLSBlock(port: byte; const Value: NXTLSBlock); override;
    procedure SetOmitHeader(const Value: Boolean); override;
    procedure SetPort(const Value: string); override;
    procedure SetQuiet(const Value: Boolean); override;
    procedure SetRCXFirmwareChunkSize(const Value: Integer); override;
    procedure SetRxTimeout(const Value: Word); override;
    procedure SetUseBT(const Value: boolean); override;
    procedure SetVerbose(const Value: boolean); override;
  protected
    procedure HandleDownloadDone(Sender : TObject);
    procedure HandleDownloadStart(Sender : TObject);
    procedure HandleDownloadStatus(Sender : TObject; cur, total : Integer; var Abort : boolean);
    procedure HandleOpenStateChanged(Sender : TObject);
    function  VarHelper(aOp, aVar, aSrc : Byte; aNum : integer) : boolean;
  public
    constructor Create(aType : byte = 0; const aPort : string = ''); override;
    destructor Destroy; override;

    function  Open : boolean; override;
    function  Close : boolean; override;

    // PBrick sound commands
    function PlayTone(aFreq, aTime : word) : boolean; override;
    function PlaySystemSound(aSnd : byte) : boolean; override;

    // PBrick output control commands
    function MotorsOn(aMotorList : Byte) : boolean; override;
    function MotorsOff(aMotorList : Byte) : boolean; override;
    function MotorsFloat(aMotorList : Byte) : boolean; override;
    function SetFwd(aMotorList : Byte) : boolean; override;
    function SetRwd(aMotorList : Byte) : boolean; override;
    function SwitchDirection(aMotorList : Byte) : boolean; override;
    function SetMotorPower(aMotorList : Byte; aSrc, aNum : integer) : boolean; override;

    // PBrick input control commands
    function SetSensorType(aNum, aType : integer) : boolean; override;
    function SetSensorMode(aNum, aMode, aSlope : integer) : boolean; override;
    function ClearSensorValue(aNum : integer) : boolean; override;

    // general
    function TowerExists : boolean; override;
    function Ping : boolean; override;
    function PrepareBrick : boolean; override;
    function UnlockFirmware : boolean; override;
    function UnlockBrick : string; override;
    function DownloadMemoryMap : TStrings; override;
    function MonitorIR(aSeconds: integer): TStrings; override;
    function PowerDownTime(aTime : integer) : boolean; override;
    function BatteryLevel : integer; override;
    function BrickAlive : boolean; override;
    function Shutdown : boolean; override;
    function Sleep(aVal : integer) : boolean; override;
    function Version(var rom : Cardinal; var ram : Cardinal) : boolean; override;
    function TransmitPower(aLevel : TTransmitLevel) : boolean; override;

    function Poll(aSrc, aNum : integer) : integer; override;
    function StartTask(aTask : integer) : boolean; override;
    function StopTask(aTask : integer) : boolean; override;
    function StopAllTasks : boolean; override;
    function DeleteTask(aTask : integer) : boolean; override;
    function DeleteAllTasks : boolean; override;
    function DeleteSub(aSub : integer) : boolean; override;
    function DeleteAllSubs : boolean; override;
    function ClearTimer(aNum : integer) : boolean; override;
    function ClearMemory : boolean; override;

    function GetOutputStatus(aOut : integer) : integer; override;
    function GetVariableValue(aVar: integer): integer; override;
    function GetInputValue(aIn: integer): integer; override;
    function GetMessageValue(aNum : integer) : integer; override;
    function GetTimerValue(aNum : integer) : integer; override;
    function GetCounterValue(aNum : integer) : integer; override;

    // PBrick arithmetic/logical commands
    function SetVar(aVar, aSrc, aNum : integer) : boolean; override;
    function SumVar(aVar, aSrc, aNum : integer) : boolean; override;
    function SubVar(aVar, aSrc, aNum : integer) : boolean; override;
    function DivVar(aVar, aSrc, aNum : integer) : boolean; override;
    function MulVar(aVar, aSrc, aNum : integer) : boolean; override;
    function SgnVar(aVar, aSrc, aNum : integer) : boolean; override;
    function AbsVar(aVar, aSrc, aNum : integer) : boolean; override;
    function AndVar(aVar, aSrc, aNum : integer) : boolean; override;
    function OrVar(aVar, aSrc, aNum : integer) : boolean; override;

    // communication to brick
    function SendRawCommand(aCmd : string; bRetry : boolean) : string; override;
    function SendRemoteStr(aEvent : string; aRepeat : integer = 1) : boolean; override;
    function SendRemote(aEvent : Word; aRepeat : integer = 1) : boolean; override;
    function SendMessage(aMsg : integer) : boolean; override;

    // RCX/2 only
    function SelectProgram(aProg : integer) : boolean; override;
    function SelectDisplay(aSrc, aNumber : integer) : boolean; override;
    function SetWatchHHMM(aHrs, aMins : integer) : boolean; override;
    function SetWatch(aTime : string) : boolean; override;
    function DownloadFirmware(aFile : string; bFast, bComp, bUnlock : boolean) : boolean; override;
    function SetDatalog(aSize : integer) : boolean; override;
    function DatalogNext(aSrc, aNum : integer) : boolean; override;
    function UploadPartialDatalog(aFrom, aSize : integer) : TStrings; override;
    function UploadDatalog(bVerbose : boolean) : TStrings; override;

    // CM only methods
    function Drive(aLeft, aRight : integer) : boolean; override;
    function ClearTachoCounter(aMotorList : Byte) : boolean; override;
    function OnWait(aMotorList : Byte; aNum : integer; aTime : Byte) : boolean; override;
    function OnWaitDifferent(aMotorList : Byte; aNum0, aNum1, aNum2 : integer; aTime : Byte) : boolean; override;

    // Scout only methods
    function ScoutNum(aVal : integer) : boolean; override;
    function Scout(bPower : boolean = true) : boolean; override;
    function CalibrateLightSensor : boolean; override;
    function SetFeedback(src, val : integer) : boolean; override;
    function SetLightSensorUpperThreshold(src : TLSSource; val : TThresholdValue) : boolean; override;
    function SetLightSensorLowerThreshold(src : TLSSource; val : TThresholdValue) : boolean; override;
    function SetLightSensorHysteresis(src : TLSSource; val : TThresholdValue) : boolean; override;
    function SetLightSensorBlinkTime(src : TLSSource; val : TBlinkTimeValue) : boolean; override;
    function SetTimerLimit(num : TTimerNumber; src : TTCSource; val : integer) : boolean; override;
    function SetCounterLimit(num : TCounterNumber; src : TTCSource; val : integer) : boolean; override;
    function ScoutRules(motion : TScoutMotion; touch : TScoutTouch;
      light : TScoutLight; time : TScoutScale; fx : TScoutEffects) : boolean; override;
    function ScoutSound(bSoundEnable : boolean; bSoundOff : boolean; aNum : TSoundSetNumber) : boolean; override;

    // Scout & Spybot only methods
    function SendVLL(aSrc, aNum : integer) : boolean; override;
    function SetLight(bOn : boolean) : boolean; override;

    // RCX2, Scout, & Spybot methods
    function PollMemory(address : Integer; size : Integer = 128) : TStrings; override;
    function SetGlobalOutput(motors : TMotorsNum; action : TGlobalOutAction) : boolean; override;
    function SetGlobalDirection(motors : TMotorsNum; action : TGlobalDirAction) : boolean; override;
    function SetMaxPower(motors : TMotorsNum; src, num : integer) : boolean; override;
    function IncCounter(num : TCounterNumber) : boolean; override;
    function DecCounter(num : TCounterNumber) : boolean; override;
    function ClearCounter(num : TCounterNumber) : boolean; override;

    // RCX2 & spybot only methods
    function ClearSound : boolean; override;
    function UnmuteSound : boolean; override;
    function SendUARTData(start, size : integer) : boolean; override;
    function SetEvent(enum, snum, etype : integer) : boolean; override;
    function CalibrateEvent(enum, upper, lower, hysteresis : integer) : boolean; override;
    function ClearAllEvents : boolean; override;
    function SetSourceValue(aDestSrc, aDestVal, aOrigSrc: Byte; aOrigVal: Smallint): boolean; override;

    // RCX2, Spy, & NXT
    function MuteSound : boolean; override;

    // RCX2 only methods
    function ViewSourceValue(prec, src, value : integer) : boolean; override;

    // Spybot only methods
    function PollEEPROM(block : Integer = -1) : TStrings; override;

    // NXT only methods
    // NXT direct commands
    function StartProgram(const filename : string) : boolean; override;
    function StopProgram : boolean; override;
    function PlaySoundFile(const filename : string; bLoop : boolean) : boolean; override;
    function GetNXTOutputState(const port : byte; var power : integer;
      var mode, regmode : byte; var turnratio : integer;
      var runstate : byte; var tacholimit : cardinal; var tachocount,
      blocktachocount, rotationcount : longint) : boolean; override;
    function SetNXTOutputState(const port : byte; const power : integer;
      const mode, regmode : byte; const turnratio : integer;
      const runstate : byte; const tacholimit : cardinal) : boolean; override;
    function GetNXTInputValues(const port : byte; var valid, calibrated : boolean;
      var stype, smode : byte; var raw, normalized : word;
      var scaled, calvalue : smallint) : boolean; override;
    function SetNXTInputMode(const port, stype, smode : byte) : boolean; override;
    function ResetInputScaledValue(const port : byte) : boolean; override;
    function ResetOutputPosition(const port : byte; const Relative : boolean) : boolean; override;
    function MessageWrite(const inbox : byte; const msg : string) : boolean; override;
    function KeepAlive(var time : cardinal; const chkResponse : boolean = true) : boolean; override;
    function LSGetStatus(port : byte; var bytesReady : byte) : boolean; override;
    function GetCurrentProgramName(var name : string) : boolean; override;
    function GetButtonState(const idx : byte; const reset : boolean;
      var pressed : boolean; var count : byte) : boolean; override;
    function MessageRead(const remote, local : byte; const remove : boolean; var Msg : NXTMessage) : boolean; override;
    function SetPropDebugging(const debugging : boolean; const pauseClump : byte; const pausePC : Word) : boolean; override;
    function GetPropDebugging(var debugging : boolean; var pauseClump : byte; var pausePC : Word) : boolean; override;
    function SetVMState(const state : byte) : boolean; override;
    function SetVMStateEx(var state : byte; var clump : byte; var pc : word) : boolean; override;
    function GetVMState(var state : byte; var clump : byte; var pc : word) : boolean; override;
    // NXT system commands
    function NXTOpenRead(const filename : string; var handle : FantomHandle;
      var size : cardinal) : boolean; override;
    function NXTOpenWrite(const filename : string; const size : cardinal;
      var handle : FantomHandle) : boolean; override;
    function NXTRead(var handle : FantomHandle; var count : word;
      var buffer : NXTDataBuffer) : boolean; override;
    function NXTWrite(var handle : FantomHandle; const buffer : NXTDataBuffer;
      var count : word; const chkResponse : boolean = false) : boolean; override;
    function NXTCloseFile(var handle : FantomHandle; const chkResponse: boolean = false) : boolean; override;
    function NXTDeleteFile(var filename : string; const chkResponse: boolean = false) : boolean; override;
    function NXTFindFirstFile(var filename : string; var IterHandle : FantomHandle; var filesize, availsize : cardinal) : boolean; override;
    function NXTFindNextFile(var IterHandle : FantomHandle; var filename : string; var filesize, availsize : cardinal) : boolean; override;
    function NXTFindClose(var IterHandle : FantomHandle) : boolean; override;
    function NXTGetVersions(var protmin, protmaj, firmmin, firmmaj : byte) : boolean; override;
    function NXTOpenWriteLinear(const filename : string; const size : cardinal;
      var handle : FantomHandle) : boolean; override;
    function NXTOpenReadLinear(const filename : string; var handle : FantomHandle;
      var size : cardinal) : boolean; override;
    function NXTOpenWriteData(const filename : string; const size : cardinal;
      var handle : FantomHandle) : boolean; override;
    function NXTOpenAppendData(const filename : string; var size : cardinal;
      var handle : FantomHandle) : boolean; override;
    function NXTCloseModuleHandle(var handle : FantomHandle; const chkResponse: boolean = false) : boolean; override;
    function NXTBootCommand(const chkResponse: boolean = false) : boolean; override;
    function NXTSetBrickName(const name : string; const chkResponse: boolean = false) : boolean; override;
    function NXTGetDeviceInfo(var name : string; var BTAddress : string;
      var BTSignal : Cardinal; var memFree : Cardinal) : boolean; override;
    function NXTFreeMemory : integer; override;
    function NXTDeleteUserFlash(const chkResponse: boolean = false) : boolean; override;
    function NXTBTFactoryReset(const chkResponse: boolean = false) : boolean; override;
    function NXTPollCommandLen(const bufNum : byte; var count : byte) : boolean; override;
    function NXTPollCommand(const bufNum : byte; var count : byte;
      var buffer : NXTDataBuffer) : boolean; override;
    function NXTWriteIOMap(var ModID : Cardinal; const Offset : Word;
      var count : Word; const buffer : NXTDataBuffer; chkResponse : Boolean = False) : boolean; override;
    function NXTReadIOMap(var ModID : Cardinal; const Offset : Word;
      var count : Word; var buffer : NXTDataBuffer) : boolean; override;
    function NXTFindFirstModule(var ModName : string; var handle : FantomHandle;
      var ModID, ModSize : Cardinal; var IOMapSize : Word) : boolean; override;
    function NXTFindNextModule(var handle : FantomHandle; var ModName : string;
      var ModID, ModSize : Cardinal; var IOMapSize : Word) : boolean; override;
    function NXTRenameFile(const old, new : string; const chkResponse: boolean = false) : boolean; override;
    // wrapper functions
    function NXTDownloadFile(const filename : string; const filetype : TNXTFileType) : boolean; override;
    function NXTDownloadStream(aStream : TStream; const dest : string; const filetype : TNXTFileType) : boolean; override;
    function NXTUploadFile(const filename : string; const dir : string = '') : boolean; override;
    function NXTUploadFileToStream(const filename : string; aStream : TStream) : boolean; override;
    function NXTListFiles(const searchPattern : string; Files : TStrings) : boolean; override;
    function NXTListModules(const searchPattern : string; Modules : TStrings) : boolean; override;
    function NXTListBricks(Bricks : TStrings) : boolean; override;
    procedure NXTInitializeResourceNames; override;
    procedure NXTUpdateResourceNames; override;
  end;

implementation

uses
  RcxLog, srecord, rcx_cmd, NQCSerialWin, Math, uCommonUtils, uGlobals;

{ TFakeSpirit }

constructor TFakeSpirit.Create(aType : byte; const aPort: string);
begin
  inherited Create(aType, aPort);
  fLink              := TAutoLink.Create;
  fLink.FastMode     := fFastMode;
  fLink.UseBluetooth := fUseBT;
  fLink.Port         := FPort;
  fLink.Target       := FBrickType;

  fLink.OnDownloadStart    := HandleDownloadStart;
  fLink.OnDownloadDone     := HandleDownloadDone;
  fLink.OnDownloadStatus   := HandleDownloadStatus;
  fLink.OnOpenStateChanged := HandleOpenStateChanged;
end;

destructor TFakeSpirit.Destroy;
begin
  Close;
  fLink.Free;
  inherited Destroy;
end;

function TFakeSpirit.DownloadMemoryMap: TStrings;
var
  bOpen : boolean;
begin
  bOpen := Open;
  fMemMap.Clear;
  try
    if bopen then
      fLink.GetMemMap(fMemMap);
  finally
    if fAutoClose then Close;
  end;
  result := fMemMap;
end;

function TFakeSpirit.MonitorIR(aSeconds : integer): TStrings;
var
  bOpen : boolean;
begin
  bOpen := Open;
  fMemMap.Clear;
  try
    if bopen then
      fLink.MonitorIR(fMemMap, aSeconds);
  finally
    if fAutoClose then Close;
  end;
  result := fMemMap;
end;

function TFakeSpirit.PowerDownTime(aTime: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    Result := fLink.Send(cmd.SetVal(kRCX_AutoOffOp, aTime)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SelectDisplay(aSrc, aNumber: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.MakeDisplay(aSrc, aNumber)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SelectProgram(aProg: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  if BrickType in [SU_RCX, SU_RCX2, SU_SWAN] then
  begin
    cmd := TRcxCmd.Create;
    try
      result := fLink.Send(cmd.SetVal(kRCX_SelectProgramOp, Byte(aProg-1)), 1, false) >= kRCX_OK;
    finally
      cmd.Free;
      if fAutoClose then Close;
    end;
  end;
end;

function TFakeSpirit.SetWatchHHMM(aHrs, aMins: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_SetWatchOp, Byte(aHrs), Byte(aMins))) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetWatch(aTime: string): boolean;
var
  H, M, S, MS : Word;
  t : integer;
begin
  if LowerCase(aTime) = 'now' then
  begin
    DecodeTime(Now, H, M, S, MS);
  end
  else
  begin
    // string is assumed to be HHMM
    t := StrToIntDef(aTime, 0);
    H := t div 100;
    M := t mod 100;
  end;
  result := SetWatchHHMM(H, M);
end;

function TFakeSpirit.UnlockFirmware: boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    // sending a simple command will unlock the firmware if necessary
    result := fLink.Send(cmd.MakePing) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.UnlockBrick: string;
var
  cmd : TRcxCmd;
  cnt, i : integer;
begin
  Open;
  cmd := TRcxCmd.Create;
  try
    cnt := fLink.Send(cmd.MakeUnlock);
    if cnt >= kRCX_Ok then
    begin
      for i := 0 to cnt - 1 do
        result := result + IntToStr(fLink.GetReplyByte(i));
    end;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.BatteryLevel: integer;
var
  bopen : boolean;
begin
  bOpen := Open;
  result := -1;
  try
    if bopen then
      result := fLink.GetBatteryLevel;
  finally
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.BrickAlive: boolean;
begin
  Result := Open;
  if not Result then Exit;
  if BrickType = rtScout then
  begin
    // the scout doesn't respond to pinging unless it is unlocked
    result := UnlockFirmware;
  end;
  if result then
    result := Ping;
end;

function TFakeSpirit.Shutdown: boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_PBTurnOffOp)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
  if Result then
    Close; // if the brick has been shutdown then close
end;

function TFakeSpirit.TransmitPower(aLevel: TTransmitLevel): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_IRModeOp, Ord(aLevel))) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.Poll(aSrc, aNum: integer): integer;
var
  bOpen : boolean;
begin
  Result := -1;
  bopen := Open;
  try
    if bOpen then
      Result := fLink.Poll(aSrc, aNum);
  finally
    if fAutoClose then Close;
  end;
end;

(*
function TFakeSpirit.Poll(aSrc, aNum: integer): integer;
var
  cmd : TRcxCmd;
  val, cnt : integer;
begin
  cmd := TRcxCmd.Create;
  try
    val := integer((aSrc shl 16) or (aNum and $FFFF));
    cnt := fLink.Send(cmd.MakePoll(val));
    if cnt <> 2 then
    begin
      result := -1;
      Exit;
    end;
    result := Cardinal(fLink.GetReplyByte(1) shl 8) + fLink.GetReplyByte(0);
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;
*)

function TFakeSpirit.StartTask(aTask: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_StartTaskOp, aTask)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.StopTask(aTask: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.MakeStopTask(aTask)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.DeleteAllTasks: boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_DeleteTasksOp)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.DeleteTask(aTask: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_DeleteTaskOp, aTask)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.StopAllTasks: boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_StopAllOp)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.DeleteSub(aSub: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_DeleteSubOp, aSub)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.DeleteAllSubs: boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_DeleteSubsOp)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.MotorsOn(aMotorList: Byte): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.MakeOutputMode(aMotorList, kRCX_OutputOn)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.MotorsOff(aMotorList: Byte): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.MakeOutputMode(aMotorList, kRCX_OutputOff)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.MotorsFloat(aMotorList: Byte): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.MakeOutputMode(aMotorList, kRCX_OutputFloat)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetFwd(aMotorList: Byte): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.MakeOutputDir(aMotorList, kRCX_OutputForward)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetRwd(aMotorList: Byte): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.MakeOutputDir(aMotorList, kRCX_OutputBackward)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SwitchDirection(aMotorList: Byte): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.MakeOutputDir(aMotorList, kRCX_OutputToggle)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetMotorPower(aMotorList: Byte; aSrc, aNum: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_OutputPowerOp, aMotorList, aSrc, aNum)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.Drive(aLeft, aRight: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  // CM only
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.MakeDrive(aLeft, aRight)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.ClearTachoCounter(aMotorList: Byte): boolean;
var
  cmd : TRcxCmd;
begin
  // CM only
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_ClearTachoOp, aMotorList)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.PlayTone(aFreq, aTime: word): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    if BrickType = rtNXT then
      result := fLink.Send(cmd.SetVal(kNXT_DirectCmdNoReply, kNXT_DCPlayTone,
        Lo(aFreq), Hi(aFreq), Lo(aTime), Hi(aTime))) >= kRCX_OK
    else
      result := fLink.Send(cmd.MakePlayTone(aFreq, aTime)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.PlaySystemSound(aSnd: byte): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.MakePlaySound(aSnd)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetSensorType(aNum, aType: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.MakeInputType(aNum, aType)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetSensorMode(aNum, aMode, aSlope: integer): boolean;
var
  cmd : TRcxCmd;
  val : Byte;
const
  SPY_MODES : array[0..2] of integer = ($00, $01, $04);
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    if BrickType = rtSpy then
      val := SPY_MODES[Max(Min(aMode, 2), 0)] shl 5
    else
      val := ((aMode and $7) shl 5) or (aSlope and $F);
    result := fLink.Send(cmd.MakeInputMode(aNum, val)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.ClearSensorValue(aNum: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_ClearSensorOp, aNum)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.ClearTimer(aNum: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_ClearTimerOp, aNum)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.VarHelper(aOp, aVar, aSrc : Byte; aNum : Integer): boolean;
var
  cmd : TRcxCmd;
  l, h, op : Byte;
begin
  Result := Open;
  if not Result then Exit;
  l := aNum and $FF;
  h := (aNum shr 8) and $FF;
  op := aOp;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(op, aVar, aSrc, l, h)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetVar(aVar, aSrc, aNum: integer): boolean;
begin
  result := VarHelper(kRCX_SetVarOp, aVar, aSrc, aNum);
end;

function TFakeSpirit.SumVar(aVar, aSrc, aNum: integer): boolean;
begin
  result := VarHelper(kRCX_SumVarOp, aVar, aSrc, aNum);
end;

function TFakeSpirit.SubVar(aVar, aSrc, aNum: integer): boolean;
begin
  result := VarHelper(kRCX_SubVarOp, aVar, aSrc, aNum);
end;

function TFakeSpirit.DivVar(aVar, aSrc, aNum: integer): boolean;
begin
  result := VarHelper(kRCX_DivVarOp, aVar, aSrc, aNum);
end;

function TFakeSpirit.MulVar(aVar, aSrc, aNum: integer): boolean;
begin
  result := VarHelper(kRCX_MulVarOp, aVar, aSrc, aNum);
end;

function TFakeSpirit.SgnVar(aVar, aSrc, aNum: integer): boolean;
begin
  result := VarHelper(kRCX_SgnVarOp, aVar, aSrc, aNum);
end;

function TFakeSpirit.AbsVar(aVar, aSrc, aNum: integer): boolean;
begin
  result := VarHelper(kRCX_AbsVarOp, aVar, aSrc, aNum);
end;

function TFakeSpirit.AndVar(aVar, aSrc, aNum: integer): boolean;
begin
  result := VarHelper(kRCX_AndVarOp, aVar, aSrc, aNum);
end;

function TFakeSpirit.OrVar(aVar, aSrc, aNum: integer): boolean;
begin
  result := VarHelper(kRCX_OrVarOp, aVar, aSrc, aNum);
end;

function TFakeSpirit.SetSourceValue(aDestSrc, aDestVal, aOrigSrc : byte; aOrigVal: smallint): boolean;
var
  cmd : TRcxCmd;
  dst, src : Integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    dst := RCX_VALUE(aDestSrc, aDestVal);
    src := RCX_VALUE(aOrigSrc, aOrigVal);
    result := fLink.Send(cmd.MakeSet(dst, src)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.DatalogNext(aSrc, aNum: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_DatalogOp, aSrc, aNum)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetDatalog(aSize: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.MakeSetDatalog(aSize)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.UploadPartialDatalog(aFrom, aSize: integer): TStrings;
var
  cmd : TRcxCmd;
  response, i : integer;
  buf : array of Byte;
begin
  Open;
  result := fDataLog;
  fDataLog.Clear;
  cmd := TRcxCmd.Create;
  try
    response := fLink.Send(cmd.MakeUploadDatalog(aFrom, aSize));
    if response > 0 then
    begin
      System.SetLength(buf, response);
      fLink.GetReply(@buf, response);
      for i := 0 to response - 1 do
      begin
        fDataLog.Add(Format('%d', [buf[i]]));
      end;
    end;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.UploadDatalog(bVerbose: boolean): TStrings;
var
  log : TRcxLog;
  i : integer;
  response : integer;
begin
  Open;
  result := fDataLog;
  fDataLog.Clear;
  log := TRcxLog.Create;
  try
    if fLink.Open then
    begin
      response := log.Upload(fLink);
      if response < 0 then Exit;
      for i := 0 to log.Length - 1 do
      begin
        fDataLog.Add(log.SPrintEntry(i, bVerbose));
      end;
    end;
  finally
    if fAutoClose then Close;
    log.Free;
  end;
end;

function TFakeSpirit.PrepareBrick: boolean;
begin
  result := UnlockFirmware;
{
  if BrickType = rtScout then
  begin
    result := Scout(true);
  end;
}
end;

function TFakeSpirit.Scout(bPower : boolean = true) : boolean;
var
  cmd : TRcxCmd;
  val : Byte;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    if bPower then
      val := $80
    else
      val := $00;
    result := fLink.Send(cmd.SetVal(kRCX_ScoutOp, val)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.Close: boolean;
begin
  Result := fLink.Close;
  fActive := False;
end;

function TFakeSpirit.Open: boolean;
begin
  Result := IsOpen;
  if not Result then begin
    Result := fLink.Open;
    fActive := Result;
  end;
end;

function TFakeSpirit.ClearMemory: boolean;
var
  cmd : TRcxCmd;
  response, i : integer;
begin
  Result := Open;
  if not Result then Exit;
  if fBrickType = rtNXT then
    Result := NXTDeleteUserFlash(True)
  else
  begin
    result := False;
    cmd := TRcxCmd.Create;
    try
      response := fLink.Send(cmd.SetVal(kRCX_StopAllOp));
      if response < 0 then Exit;

      if (fBrickType = rtRCX) or (fBrickType = rtRCX2) or (FBrickType = rtSwan) then
      begin
        for i := 0 to 4 do
        begin
          response := fLink.Send(cmd.SetVal(kRCX_SelectProgramOp, i));
          if response < 0 then Exit;

          response := fLink.Send(cmd.MakeDeleteSubs);
          if response < 0 then Exit;

          response := fLink.Send(cmd.MakeDeleteTasks);
          if response < 0 then Exit;
        end;
        response := fLink.Send(cmd.SetVal(kRCX_SetDatalogOp, 0, 0));
      end
      else
      begin
        response := fLink.Send(cmd.MakeDeleteSubs);
        if response < 0 then Exit;

        response := fLink.Send(cmd.MakeDeleteTasks);
        if response < 0 then Exit;
      end;

      result := response >= 0;
    finally
      cmd.Free;
      if fAutoClose then Close;
    end;
  end;
end;

function TFakeSpirit.Sleep(aVal: integer): boolean;
begin
  Result := PowerDownTime(aVal);
end;

function TFakeSpirit.SendRawCommand(aCmd: string; bRetry: boolean): string;
var
  len, response, i : integer;
  cmd : TRcxCmd;
  bStr : string;
  tmpByte : Byte;
  orig : PByte;
begin
  Open;
  result := '';
  len := Length(aCmd);
  if (len mod 2) = 0 then
  begin
    len := len div 2;
    cmd := TRcxCmd.Create;
    try
      cmd.SetLength(len);
      orig := cmd.GetBody;
      while aCmd <> '' do
      begin
        bStr := Copy(aCmd, 1, 2);
        Delete(aCmd, 1, 2);
        tmpByte := StrToIntDef('$' + bStr, 0);
        orig^ := tmpByte;
        inc(orig);
      end;
      response := fLink.Send(cmd, kDefaultRetryCount, bRetry);
      if response > 0 then
      begin
        for i := 0 to response - 1 do
        begin
          result := result + Format('%2.2x ', [fLink.GetReplyByte(i)]);
        end;
      end;
    finally
      cmd.Free;
      if fAutoClose then Close;
    end;
  end;
end;

function TFakeSpirit.SendRemoteStr(aEvent: string; aRepeat: integer): boolean;
var
  val : integer;
begin
  Result := False;
  if aRepeat <= 0 then Exit;
  if Length(aEvent) <> 4 then Exit;
  val := StrToIntDef('$' + Copy(aEvent, 1, 4), 0);
  result := SendRemote(val, aRepeat);
end;

function TFakeSpirit.SendRemote(aEvent: Word; aRepeat: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  if aRepeat <= 0 then Exit;
  cmd := TRcxCmd.Create;
  try
    // open, sync, send
    result := fLink.Open;
    try
      if not result then Exit;

      result := fLink.Sync(false) >= kRCX_OK;
      if not result then Exit;

      cmd.SetVal(kRCX_Remote, Lo(aEvent), Hi(aEvent));
      while aRepeat > 0 do
      begin
        fLink.Send1(cmd.GetBody, cmd.GetLength);
        dec(aRepeat);
      end;
    finally
      if fAutoClose then Close;
    end;
    result := true;
  finally
    cmd.Free;
  end;
end;

function TFakeSpirit.SendMessage(aMsg: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  try
    cmd := TRcxCmd.Create;
    try
      cmd.SetVal(kRCX_Message, Byte(aMsg));
      result := fLink.Send1(cmd.GetBody, cmd.GetLength) >= kRCX_OK;
  //    result := fLink.Send(cmd.SetVal(kRCX_Message, Byte(aMsg)), false) >= kRCX_OK;
    finally
      cmd.Free;
    end;
  finally
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.GetCounterValue(aNum: integer): integer;
var
  bOpen : boolean;
begin
  Result := -1;
  bopen := Open;
  try
    if bOpen then
      result := fLink.GetCounterValue(aNum);
  finally
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.GetTimerValue(aNum: integer): integer;
var
  bOpen : boolean;
begin
  Result := -1;
  bopen := Open;
  try
    if bOpen then
      result := fLink.GetTimerValue(aNum);
  finally
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.GetMessageValue(aNum: integer): integer;
var
  bOpen : boolean;
begin
  Result := -1;
  bopen := Open;
  try
    if bOpen then
      result := fLink.GetMessageValue(aNum);
  finally
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.GetInputValue(aIn : integer) : integer;
var
  bOpen : boolean;
begin
  Result := -1;
  bopen := Open;
  try
    if bOpen then
      result := fLink.GetInputValue(aIn);
  finally
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.GetVariableValue(aVar : integer) : integer;
var
  bOpen : boolean;
begin
  Result := -1;
  bopen := Open;
  try
    if bOpen then
      result := fLink.GetVariableValue(aVar);
  finally
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.GetOutputStatus(aOut: integer): integer;
var
  bOpen : boolean;
begin
  Result := -1;
  bopen := Open;
  try
    if bOpen then
      result := fLink.GetOutputStatus(aOut);
  finally
    if fAutoClose then Close;
  end;
end;

procedure TFakeSpirit.SetPort(const Value: string);
begin
  inherited SetPort(Value);
  fLink.Port := Value;
end;

procedure TFakeSpirit.SetVerbose(const Value: boolean);
begin
  inherited SetVerbose(Value);
  fLink.Verbose := Value;
end;

procedure TFakeSpirit.SetBrickType(const Value: byte);
begin
  inherited SetBrickType(Value);
  fLink.Target := Value;
end;

function TFakeSpirit.ScoutNum(aVal: integer): boolean;
var
  bPower : boolean;
begin
  bPower := aVal <> 0;
  result := Scout(bPower);
end;

function TFakeSpirit.Version(var rom, ram: Cardinal): boolean;
begin
  Result := Open;
  if not Result then Exit;
  try
    if Result then
      result := fLink.GetVersion(rom, ram) >= kRCX_OK;
  finally
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.DownloadFirmware(aFile: string; bFast : Boolean;
  bComp : Boolean; bUnlock : boolean): boolean;
const
  kMaxFirmware = 65536;
var
  F : TextFile;
  srec : TSRecClass;
  ok : boolean;
  response : integer;
  rom, ram : Cardinal;
begin
  Result := Open;
  if not Result then Exit;
  try
    AssignFile(F, aFile);
    srec := TSRecClass.Create;
    try
      Reset(F);
      try
        ok := srec.Read(F, kMaxFirmware);
        if not ok then
        begin
          result := False;
          Exit;
        end;
      finally
        CloseFile(F);
      end;
	    result := fLink.Open;
      try
        if not result then Exit;
        response := fLink.DownloadFirmware(srec.GetData, srec.GetLength, srec.GetStart, bFast, bComp);
        if response < 0 then
        begin
          result := False;
          Exit;
        end;
        // this unlocks the firmware
        if bUnlock then
          response := fLink.GetVersion(rom, ram);
        result := not bFast or (response >= 0);
      finally
        if fAutoClose then Close;
      end;
    finally
      srec.Free;
    end;
  except
  end;
end;

procedure TFakeSpirit.HandleDownloadDone(Sender: TObject);
begin
  DoDownloadDone;
end;

procedure TFakeSpirit.HandleDownloadStart(Sender: TObject);
begin
  DoDownloadStart;
end;

procedure TFakeSpirit.HandleDownloadStatus(Sender: TObject;
  cur, total : Integer; var Abort: boolean);
begin
  DoDownloadStatus(cur, total, Abort);
end;

function TFakeSpirit.Ping: boolean;
var
  cmd : TRcxCmd;
  ot : integer;
  odt : boolean;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    ot  := fLink.RxTimeout;
    odt := fLink.DynamicTimeout;
    try
      fLink.RxTimeout := Self.RxTimeout;
      result := fLink.Send(cmd.MakePing) >= kRCX_OK;
    finally
      fLink.RxTimeout := ot;
      fLink.DynamicTimeout := odt;
    end;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.TowerExists: boolean;
var
  cmd : TRcxCmd;
  val : integer;
begin
  cmd := TRcxCmd.Create;
  try
    Result := Open;
    if Result then
    begin
      OSSleep(TowerExistsSleep); // sleep some milliseconds
      val := fLink.Send(cmd.MakePing, 0, False);
      Result := (val <> kRCX_OpenSerialError) and (val <> kRCX_IREchoError);
      if not Result and (val <> kRCX_OpenSerialError) then
      begin
        // try again
        val := fLink.Send(cmd.MakePing, 0, False);
        Result := (val <> kRCX_OpenSerialError) and (val <> kRCX_IREchoError);
      end;
    end;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.OnWait(aMotorList: Byte; aNum: integer;
  aTime: Byte): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  // CM only
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.MakeOnWait(aMotorList, aNum, aTime)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.OnWaitDifferent(aMotorList: Byte; aNum0, aNum1,
  aNum2: integer; aTime: Byte): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  // CM only
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(
      cmd.MakeOnWaitDifferent(aMotorList, aNum0, aNum1, aNum2, aTime)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.CalibrateLightSensor: boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_LSCalibrateOp)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SendVLL(aSrc, aNum: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_VLLOp, aSrc, aNum)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetFeedback(src, val: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_SetFeedbackOp, src, Lo(val), Hi(val))) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetLightSensorUpperThreshold(src : TLSSource; val: TThresholdValue): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_LSUpperThreshOp, Ord(src), Lo(Ord(val)), Hi(Ord(val)))) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetLightSensorLowerThreshold(src : TLSSource; val: TThresholdValue): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_LSLowerThreshOp, Ord(src), Lo(Ord(val)), Hi(Ord(val)))) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetLightSensorHysteresis(src: TLSSource; val: TThresholdValue): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_LSHysteresisOp, Ord(src), Lo(Ord(val)), Hi(Ord(val)))) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetLightSensorBlinkTime(src: TLSSource; val: TBlinkTimeValue): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_LSBlinkTimeOp, Ord(src), Lo(Ord(val)), Hi(Ord(val)))) >= kRCX_OK;
   finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetTimerLimit(num: TTimerNumber; src: TTCSource; val: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_SetTimerLimitOp, num, Ord(src), Lo(Ord(val)), Hi(Ord(val)))) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetCounterLimit(num: TCounterNumber; src: TTCSource; val: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_SetCounterOp, num, Ord(src), Lo(Ord(val)), Hi(Ord(val)))) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetLight(bOn: boolean): boolean;
var
  cmd : TRcxCmd;
  val : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    val := $0;
    if bOn then
      val := $80;
    result := fLink.Send(cmd.SetVal(kRCX_LightOp, val)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.ScoutRules(motion: TScoutMotion; touch: TScoutTouch;
  light: TScoutLight; time: TScoutScale; fx: TScoutEffects): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_ScoutRulesOp, Ord(motion),
      Ord(touch), Ord(light), Ord(time), Ord(fx))) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.ScoutSound(bSoundEnable, bSoundOff: boolean;
  aNum: TSoundSetNumber): boolean;
var
  cmd : TRcxCmd;
  num : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    num := aNum;
    if bSoundEnable then
      inc(num, $80);
    if bSoundOff then
      inc(num, $40);
    result := fLink.Send(cmd.SetVal(kRCX_SoundOp, num)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.PollMemory(address, size: integer): TStrings;
var
  cmd : TRcxCmd;
  cnt, i : integer;
  buf : PByte;
  amt : Integer;
const
  CHUNK = 128;
begin
  Open;
  result := fMemData;
  fMemData.Clear;
  cmd := TRcxCmd.Create;
  try
    amt := 0;
    while amt < size do
    begin
      cnt := fLink.Send(cmd.SetVal(kRCX_PollMemoryOp, Lo(address+amt), Hi(address+amt), Min(CHUNK, size-amt)));
      if cnt > 0 then
      begin
        GetMem(buf, cnt);
        try
          fLink.GetReply(buf, cnt);
          for i := 0 to cnt - 1 do
          begin
            fMemData.Add(Format('%d', [PByte(PChar(buf) + i)^]));
          end;
        finally
          FreeMem(buf);
        end;
      end;
      Inc(amt, CHUNK);
    end;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.PollEEPROM(block: Integer): TStrings;
var
  cmd : TRcxCmd;
  cnt, i : integer;
  buf : PByte;
  j, start, finish : Integer;
begin
  Open;
  result := fMemData;
  fMemData.Clear;
  cmd := TRcxCmd.Create;
  try
    start := block;
    finish := block;
    if block < 0 then
    begin
      start := 0;
      finish := $FF;
    end;
    for j := start to finish do
    begin
      cnt := fLink.Send(cmd.SetVal(kRCX_UploadEepromOp, j));
      if cnt > 0 then
      begin
        GetMem(buf, cnt);
        try
          fLink.GetReply(buf, cnt);
          for i := 0 to cnt - 1 do
          begin
            fMemData.Add(Format('%d', [PByte(PChar(buf) + i)^]));
          end;
        finally
          FreeMem(buf);
        end;
      end
      else
        Break; // no bytes returned
    end;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetGlobalOutput(motors: TMotorsNum; action: TGlobalOutAction): boolean;
var
  cmd : TRcxCmd;
  act : integer;
begin
  Result := Open;
  if not Result then Exit;
  case action of
    goaOff : act := $40;
    goaOn  : act := $80;
  else
    act := 0;
  end;
  inc(act, motors);
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_GOutputModeOp, act)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetGlobalDirection(motors: TMotorsNum; action: TGlobalDirAction): boolean;
var
  cmd : TRcxCmd;
  act : integer;
begin
  Result := Open;
  if not Result then Exit;
  case action of
    gdaSwitch  : act := $40;
    gdaForward : act := $80;
  else
    act := 0;
  end;
  inc(act, motors);
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_GOutputDirOp, act)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetMaxPower(motors : TMotorsNum; src, num: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_GOutputPowerOp, motors, Ord(src), Ord(num) )) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.IncCounter(num: TCounterNumber): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_IncCounterOp, num)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.DecCounter(num: TCounterNumber): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_DecCounterOp, num)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.ClearCounter(num: TCounterNumber): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_ClearCounterOp, num)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.ClearSound: boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_ClearSound)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.MuteSound: boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    if BrickType = rtScout then
    begin
      result := ScoutSound(True, True, 0);
    end
    else if BrickType = rtNXT then
    begin
      // NXT stop sound
      result := fLink.Send(cmd.SetVal(kNXT_DirectCmdNoReply, kNXT_DCStopSoundPlayback)) >= kRCX_OK;
    end
    else
      result := fLink.Send(cmd.SetVal(kRCX_MuteSoundOp)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.UnmuteSound: boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    if BrickType = rtScout then
    begin
      result := ScoutSound(True, False, 0);
    end
    else
      result := fLink.Send(cmd.SetVal(kRCX_UnmuteSoundOp)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SendUARTData(start, size: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    cmd.SetVal(kRCX_SendUARTDataOp, start, size);
    result := fLink.Send1(cmd.GetBody, cmd.GetLength) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetEvent(enum, snum, etype: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_SetEventOp, enum, snum, etype)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.CalibrateEvent(enum, upper, lower, hysteresis: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_CalibrateEventOp, enum, upper, lower, hysteresis)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.ClearAllEvents: boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_ClearAllEventsOp)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.ViewSourceValue(prec, src, value: integer): boolean;
var
  cmd : TRcxCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TRcxCmd.Create;
  try
    result := fLink.Send(cmd.SetVal(kRCX_ViewSourceValOp, 0, prec, src, Lo(value), Hi(value))) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

procedure TFakeSpirit.SetFastMode(const Value: boolean);
begin
  if fFastMode <> Value then
  begin
    inherited SetFastMode(Value);
    fLink.FastMode := Value;
  end;
end;

function TFakeSpirit.GetPortName: string;
begin
  Result := fLink.PortName;
end;

function TFakeSpirit.GetIsOpen: boolean;
begin
  Result := inherited GetIsOpen;
  Result := Result and fLink.Active;
end;

procedure TFakeSpirit.HandleOpenStateChanged(Sender: TObject);
begin
  DoOpenStateChanged;
end;

function TFakeSpirit.GetEEPROM(addr: Byte): Byte;
begin
  Result := 0;
  if BrickType <> rtSpy then Exit;
  Result := Poll(kRCX_SpybotEepromType, addr);
end;

procedure TFakeSpirit.SetEEPROM(addr: Byte; const Value: Byte);
begin
  if BrickType <> rtSpy then Exit;
  Self.SetSourceValue(kRCX_SpybotEepromType, addr, kRCX_ConstantType, Value);
end;

function TFakeSpirit.GetEEPROMBlock(idx: Integer): EEPROMBlock;
var
  cmd : TRcxCmd;
  cnt, i : Integer;
  buf, p : PByte;
begin
  Open;
  for i := 0 to 15 do
    Result.Data[i] := 0;
  if BrickType <> rtSpy then Exit;
  if PortIsUSB(Port) then
  begin
    for i := 0 to 15 do
      Result.Data[i] := EEPROM[idx*16+i];
  end
  else
  begin
    cmd := TRcxCmd.Create;
    try
      cnt := fLink.Send(cmd.SetVal(kRCX_UploadEepromOp, idx));
      if cnt > 0 then
      begin
        GetMem(buf, cnt);
        try
          fLink.GetReply(buf, cnt);
          p := buf;
          for i := 0 to cnt - 1 do
          begin
            Result.Data[i] := p^;
            Inc(p, 1);
          end;
        finally
          FreeMem(buf);
        end;
      end;
    finally
      cmd.Free;
    end;
  end;
end;

function TFakeSpirit.GetRxTimeout: Word;
begin
  Result := fLink.RxTimeout;
end;

procedure TFakeSpirit.SetRxTimeout(const Value: Word);
begin
  if fLink.RxTimeout <> Value then
    fLink.RxTimeout := Value;
end;

function TFakeSpirit.GetRCXFirmwareChunkSize: Integer;
begin
  Result := fLink.RCXFirmwareChunkSize;
end;

procedure TFakeSpirit.SetRCXFirmwareChunkSize(const Value: Integer);
begin
  if fLink.RCXFirmwareChunkSize <> Value then
    fLink.RCXFirmwareChunkSize := Value;
end;

function TFakeSpirit.GetOmitHeader: Boolean;
begin
  Result := fLink.OmitHeader;
end;

procedure TFakeSpirit.SetOmitHeader(const Value: Boolean);
begin
  if fLink.OmitHeader <> Value then
    fLink.OmitHeader := Value;
end;

function TFakeSpirit.GetQuiet: Boolean;
begin
  Result := fLink.Quiet;
end;

procedure TFakeSpirit.SetQuiet(const Value: Boolean);
begin
  fLink.Quiet := Value;
end;

function TFakeSpirit.GetDownloadWaitTime: Integer;
begin
  Result := fLink.DownloadWaitTime;
end;

procedure TFakeSpirit.SetDownloadWaitTime(const Value: Integer);
begin
  fLink.DownloadWaitTime := Value;
end;

function TFakeSpirit.StartProgram(const filename: string): boolean;
var
  cmd : TNxtCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    Result := fLink.Send(cmd.MakeCmdWithFilename(
                kNXT_DirectCmd,
                kNXT_DCStartProgram,
                filename)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.StopProgram: boolean;
var
  cmd : TBaseCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    fLink.Send(cmd.SetVal(kNXT_DirectCmd, kNXT_DCStopProgram));
    result := True;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.PlaySoundFile(const filename: string; bLoop: boolean): boolean;
var
  i : integer;
  cmd : TBaseCmd;
  orig : PByte;
  nxtFilename : string;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    // filename is limited to 19 bytes + null terminator
    cmd.SetLength(23);
    orig := cmd.GetBody;
    orig^ := kNXT_DirectCmdNoReply;
    inc(orig);
    orig^ := kNXT_DCPlaySoundFile;
    inc(orig);
    orig^ := Ord(bLoop);
    inc(orig);
    i := 1;
    nxtFilename := MakeValidNXTFilename(filename);
    while i <= 19 do
    begin
      // copy the first nineteen bytes from the filename provided
      if i > Length(nxtFilename) then
        orig^ := 0
      else
        orig^ := Ord(nxtFilename[i]);
      inc(orig);
      inc(i);
    end;
    orig^ := 0; // set last byte to null
    Result := fLink.Send(cmd) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.GetNXTOutputState(const port: byte; var power: integer;
  var mode, regmode: byte; var turnratio: integer; var runstate: byte;
  var tacholimit: cardinal; var tachocount, blocktachocount, rotationcount: Integer): boolean;
var
  cmd : TBaseCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_DirectCmd, kNXT_DCGetOutputState, port));
    if len <> 22 then
    begin
      result := False;
      Exit;
    end;
    result := True;
//    port      := fLink.GetReplyByte(0)
    power     := fLink.GetReplyByte(1);
    mode      := fLink.GetReplyByte(2);
    regmode   := fLink.GetReplyByte(3);
    turnratio := fLink.GetReplyByte(4);
    runstate  := fLink.GetReplyByte(5);
    tacholimit := fLink.GetReplyCardinal(6);
    tachocount := Integer(fLink.GetReplyCardinal(10));
    blocktachocount := Integer(fLink.GetReplyCardinal(14));
    rotationcount := Integer(fLink.GetReplyCardinal(18));
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetNXTOutputState(const port: byte;
  const power: integer; const mode, regmode: byte;
  const turnratio: integer; const runstate: byte;
  const tacholimit: cardinal): boolean;
var
  cmd : TBaseCmd;
  orig : PByte;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    cmd.SetLength(12);
    orig := cmd.GetBody;
    orig^ := kNXT_DirectCmdNoReply;
    inc(orig);
    orig^ := kNXT_DCSetOutputState;
    inc(orig);
    orig^ := port;
    inc(orig);
    orig^ := ShortInt(power);
    inc(orig);
    orig^ := mode;
    inc(orig);
    orig^ := regmode;
    inc(orig);
    orig^ := ShortInt(turnratio);
    inc(orig);
    orig^ := Byte(runstate);
    inc(orig);
    orig^ := Byte(Word(tacholimit));
    inc(orig);
    orig^ := HiByte(Word(tacholimit));
    inc(orig);
    orig^ := Byte(HiWord(tacholimit));
    inc(orig);
    orig^ := HiByte(HiWord(tacholimit));
    Result := fLink.Send(cmd) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.GetNXTInputValues(const port: byte; var valid,
  calibrated: boolean; var stype, smode: byte; var raw, normalized: word;
  var scaled, calvalue: smallint): boolean;
var
  cmd : TBaseCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_DirectCmd, kNXT_DCGetInputValues, port));
    if len <> 13 then
    begin
      result := False; // indicate an error???
      Exit;
    end;
    Result := True;
//    port       := fLink.GetReplyByte(0);
    valid      := fLink.GetReplyByte(1) <> 0;
    calibrated := fLink.GetReplyByte(2) <> 0;
    stype      := fLink.GetReplyByte(3);
    smode      := fLink.GetReplyByte(4);
    raw        := fLink.GetReplyWord(5);
    normalized := fLink.GetReplyWord(7);
    scaled     := SmallInt(fLink.GetReplyWord(9));
    calvalue   := SmallInt(fLink.GetReplyWord(11));
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetNXTInputMode(const port, stype, smode: byte): boolean;
var
  cmd : TBaseCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    Result := fLink.Send(cmd.SetVal(kNXT_DirectCmdNoReply,
      kNXT_DCSetInputMode, port, stype, smode)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.ResetInputScaledValue(const port: byte): boolean;
var
  cmd : TBaseCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    fLink.Send(cmd.SetVal(kNXT_DirectCmdNoReply, kNXT_DCResetInputScaledValue, port));
    Result := True;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.ResetOutputPosition(const port: byte;
  const Relative: boolean): boolean;
var
  cmd : TBaseCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    fLink.Send(cmd.SetVal(kNXT_DirectCmdNoReply, kNXT_DCResetMotorPosition,
      port, Ord(Relative)));
    Result := True;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.MessageWrite(const inbox: byte; const msg: string): boolean;
var
  i, len : integer;
  cmd : TBaseCmd;
  orig : PByte;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    // message is limited to 59 bytes + null terminator
    len := Min(Length(msg), kNXT_MaxBytes-5);
    cmd.SetLength(len+5);
    orig := cmd.GetBody;
    orig^ := kNXT_DirectCmdNoReply;
    inc(orig);
    orig^ := kNXT_DCMessageWrite;
    inc(orig);
    orig^ := inbox;
    inc(orig);
    orig^ := len+1; // add null terminator
    inc(orig);
    i := 1;
    while i <= len do
    begin
      orig^ := Ord(msg[i]);
      inc(orig);
      inc(i);
    end;
    orig^ := 0; // set last byte to null
    Result := fLink.Send(cmd) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.KeepAlive(var time: cardinal; const chkResponse : boolean): boolean;
var
  cmd : TBaseCmd;
  len : integer;
  b : byte;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    result := False;
    if chkResponse then
      b := kNXT_DirectCmd
    else
      b := kNXT_DirectCmdNoReply;
    len := fLink.Send(cmd.SetVal(b, kNXT_DCKeepAlive));
    if chkResponse then
    begin
      if len <> 4 then
      begin
        result := False;
        Exit;
      end;
      time := Integer(fLink.GetReplyCardinal(0));
    end;
    Result := True;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

procedure TFakeSpirit.SetUseBT(const Value: boolean);
begin
  if fUseBT <> Value then
  begin
    inherited SetUseBT(Value);
    fLink.UseBluetooth := Value;
  end;
end;

function TFakeSpirit.LSGetStatus(port : byte; var bytesReady: byte): boolean;
var
  cmd : TBaseCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_DirectCmd, kNXT_DCLSGetStatus, port));
    if len <> 1 then
    begin
      Result := False;
      Exit;
    end;
    Result := True;
    bytesReady := fLink.GetReplyByte(0);
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.GetLSBlock(port: byte): NXTLSBlock;
var
  cmd : TBaseCmd;
  len, i : integer;
begin
  // LSRead
  Open;
  Result.TXCount := 0;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_DirectCmd, kNXT_DCLSRead, port));
    if len <> 17 then
    begin
      Result.RXCount := 0;
      Exit;
    end;
    Result.RXCount := fLink.GetReplyByte(0);
    for i := 1 to len - 1 do
    begin
      Result.Data[i-1] := fLink.GetReplyByte(i);
    end;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

procedure TFakeSpirit.SetLSBlock(port: byte; const Value: NXTLSBlock);
var
  i, len : integer;
  cmd : TBaseCmd;
  orig : PByte;
begin
  // LSWrite
  Open;
  cmd := TBaseCmd.Create;
  try
    len := Min(Value.TXCount, 16);
    cmd.SetLength(len+5); // up to a max of 21 bytes
    orig := cmd.GetBody;
    orig^ := kNXT_DirectCmdNoReply;
    inc(orig);
    orig^ := kNXT_DCLSWrite;
    inc(orig);
    orig^ := port;
    inc(orig);
    orig^ := len;
    inc(orig);
    orig^ := Min(Value.RXCount, 16);
    inc(orig);
    i := 0;
    while i < len do
    begin
      orig^ := Value.Data[i];
      inc(orig);
      inc(i);
    end;
    orig^ := 0; // set last byte to null
    fLink.Send(cmd);
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.GetCurrentProgramName(var name: string): boolean;
var
  cmd : TBaseCmd;
  len, i : integer;
  Buf : array[0..19] of Char;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_DirectCmd, kNXT_DCGetCurrentProgramName));
    if len <> 20 then
    begin
      name   := '';
      Result := False;
      Exit;
    end;
    Result := True;
    for i := 0 to len - 1 do
    begin
      Buf[i] := Char(fLink.GetReplyByte(i));
    end;
    name := Buf;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.GetButtonState(const idx: byte; const reset: boolean;
  var pressed: boolean; var count: byte): boolean;
var
  cmd : TBaseCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_DirectCmd, kNXT_DCGetButtonState,
      idx, Ord(reset)));
    if len <> 2 then
    begin
      Result := False;
      Exit;
    end;
    Result := True;
    pressed := Boolean(fLink.GetReplyByte(0));
    count   := fLink.GetReplyByte(1);
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.MessageRead(const remote, local: byte;
  const remove: boolean; var Msg: NXTMessage): boolean;
var
  cmd : TBaseCmd;
  len, i : integer;
begin
  Result := Open;
  if not Result then Exit;
  Msg.Inbox := 0;
  Msg.Size  := 0;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_DirectCmd, kNXT_DCMessageRead,
      remote, local, Ord(remove)));
    if len <> 61 then
    begin
      Result := False;
      Exit;
    end;
    Result := True;
    Msg.Inbox := fLink.GetReplyByte(0);
    Msg.Size  := fLink.GetReplyByte(1);
    for i := 2 to len - 1 do
    begin
      Msg.Data[i-2] := fLink.GetReplyByte(i);
    end;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.GetPropDebugging(var debugging : boolean; var pauseClump: byte;
  var pausePC: Word): boolean;
var
  cmd : TBaseCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_DirectCmd, kNXT_DCGetProperty, kNXT_Property_Debugging));
    if len <> 4 then
    begin
      result := False; // indicate an error???
      Exit;
    end;
    Result := True;
    debugging  := Boolean(fLink.GetReplyByte(0));
    pauseClump := fLink.GetReplyByte(1);
    pausePC    := fLink.GetReplyWord(2);
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetPropDebugging(const debugging : boolean; const pauseClump: byte;
  const pausePC: Word): boolean;
var
  cmd : TBaseCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    Result := fLink.Send(cmd.SetVal(kNXT_DirectCmdNoReply,
      kNXT_DCSetProperty, kNXT_Property_Debugging, Ord(debugging),
      pauseClump, Lo(pausePC), Hi(pausePC))) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetVMState(const state : byte) : boolean;
var
  cmd : TBaseCmd;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    Result := fLink.Send(cmd.SetVal(kNXT_DirectCmdNoReply,
      kNXT_DCSetVMState, state)) >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.SetVMStateEx(var state, clump: byte; var pc: word): boolean;
var
  cmd : TBaseCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_DirectCmd, kNXT_DCSetVMState, state));
    if len <> 4 then
    begin
      result := False; // indicate an error???
      Exit;
    end;
    Result := True;
    state := fLink.GetReplyByte(0);
    clump := fLink.GetReplyByte(1);
    pc    := fLink.GetReplyWord(2);
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.GetVMState(var state : byte; var clump : byte; var pc : word) : boolean;
var
  cmd : TBaseCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_DirectCmd, kNXT_DCGetVMState));
    if len <> 4 then
    begin
      result := False; // indicate an error???
      Exit;
    end;
    Result := True;
    state := fLink.GetReplyByte(0);
    clump := fLink.GetReplyByte(1);
    pc    := fLink.GetReplyWord(2);
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTOpenRead(const filename: string; var handle: FantomHandle;
  var size: cardinal): boolean;
var
  cmd : TNxtCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    len := fLink.Send(cmd.MakeCmdWithFilename(kNXT_SystemCmd,
      kNXT_SCOpenRead, filename));
    if len <> 5 then
    begin
      Result := False;
      Exit;
    end;
    Result := True;
    handle := fLink.GetReplyByte(0);
    size   := fLink.GetReplyCardinal(1);
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTOpenReadLinear(const filename: string;
  var handle: FantomHandle; var size: cardinal): boolean;
var
  cmd : TNxtCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    len := fLink.Send(cmd.MakeCmdWithFilename(kNXT_SystemCmd, kNXT_SCOpenReadLinear, filename));
    if len <> 5 then
    begin
      Result := False;
      Exit;
    end;
    Result := True;
    handle := fLink.GetReplyByte(0);
    size   := fLink.GetReplyCardinal(1);
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTOpenAppendData(const filename: string;
  var size: cardinal; var handle: FantomHandle): boolean;
var
  cmd : TNxtCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    len := fLink.Send(cmd.MakeCmdWithFilename(kNXT_SystemCmd,
      kNXT_SCOpenAppendData, filename));
    if len <> 5 then
    begin
      Result := False;
      Exit;
    end;
    Result := True;
    handle := fLink.GetReplyByte(0);
    size   := fLink.GetReplyCardinal(1);
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTOpenWrite(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
var
  cmd : TNxtCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    len := fLink.Send(cmd.MakeCmdWithFilename(kNXT_SystemCmd,
      kNXT_SCOpenWrite, filename, size));
    if len <> 1 then
    begin
      Result := False;
      Exit;
    end;
    Result := True;
    handle := fLink.GetReplyByte(0);
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTOpenWriteData(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
var
  cmd : TNxtCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    len := fLink.Send(cmd.MakeCmdWithFilename(kNXT_SystemCmd,
      kNXT_SCOpenWriteData, filename, size));
    if len <> 1 then
    begin
      Result := False;
      Exit;
    end;
    Result := True;
    handle := fLink.GetReplyByte(0);
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTOpenWriteLinear(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
var
  cmd : TNxtCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    len := fLink.Send(cmd.MakeCmdWithFilename(kNXT_SystemCmd,
      kNXT_SCOpenWriteLinear, filename, size));
    if len <> 1 then
    begin
      Result := False;
      Exit;
    end;
    Result := True;
    handle := fLink.GetReplyByte(0);
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTRead(var handle: FantomHandle; var count: word;
  var buffer: NXTDataBuffer): boolean;
var
  cmd : TBaseCmd;
  len, i : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_SystemCmd, kNXT_SCRead, handle, Lo(count), Hi(count)));
    if len < 3 then
    begin
      Result := False;
      Exit;
    end;
    handle := fLink.GetReplyByte(0);
    count  := fLink.GetReplyWord(1);
    for i := 0 to 63 do begin
      if i >= count then Break;
      buffer.Data[i] := fLink.GetReplyByte(3+i);
    end;
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTWrite(var handle: FantomHandle; const buffer: NXTDataBuffer;
  var count: word; const chkResponse: boolean): boolean;
var
  cmd : TNxtCmd;
  b : byte;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    if chkResponse then
      b := kNXT_SystemCmd
    else
      b := kNXT_SystemCmdNoReply;
    len := fLink.Send(cmd.MakeCmdWriteFile(b, kNXT_SCWrite, handle, count, buffer.Data));
    if chkResponse then
    begin
      if len <> 3 then
      begin
        Result := False;
        Exit;
      end;
      handle := fLink.GetReplyByte(0);
      count  := fLink.GetReplyWord(1);
    end;
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTCloseFile(var handle: FantomHandle; const chkResponse: boolean): boolean;
var
  cmd : TBaseCmd;
  b : byte;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    if chkResponse then
      b := kNXT_SystemCmd
    else
      b := kNXT_SystemCmdNoReply;
    len := fLink.Send(cmd.SetVal(b, kNXT_SCClose, handle));
    if chkResponse then
    begin
      if len <> 1 then
      begin
        Result := False;
        Exit;
      end;
      handle := fLink.GetReplyByte(0);
    end;
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTDeleteFile(var filename: string; const chkResponse: boolean): boolean;
var
  cmd : TNxtCmd;
  len, i : integer;
  b : byte;
  Buf : array[0..19] of Char;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    if chkResponse then
      b := kNXT_SystemCmd
    else
      b := kNXT_SystemCmdNoReply;
    len := fLink.Send(cmd.MakeCmdWithFilename(b, kNXT_SCDelete, filename));
    if chkResponse then
    begin
      if len <> 20 then
      begin
        Result := False;
        Exit;
      end;
      for i := Low(Buf) to High(Buf) do
      begin
        Buf[i] := Char(fLink.GetReplyByte(i));
      end;
      filename := Buf;
    end;
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTFindFirstFile(var filename: string;
  var IterHandle: FantomHandle; var filesize, availsize : cardinal): boolean;
var
  cmd : TNxtCmd;
  len, i : integer;
  Buf : array[0..19] of Char;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    len := fLink.Send(cmd.MakeCmdWithFilename(kNXT_SystemCmd, kNXT_SCFindFirst, filename));
    if len <> 25 then
    begin
      Result := False;
      Exit;
    end;
    IterHandle := fLink.GetReplyByte(0);    // 1 byte
    for i := Low(Buf) to High(Buf) do   // 20 bytes
    begin
      Buf[i] := Char(fLink.GetReplyByte(i+1));
    end;
    filename := Buf;
    filesize := fLink.GetReplyCardinal(21); // 4 bytes
    availsize := 0;
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTFindNextFile(var IterHandle: FantomHandle; var filename: string;
  var filesize, availsize : cardinal): boolean;
var
  cmd : TBaseCmd;
  len, i : integer;
  Buf : array[0..19] of Char;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_SystemCmd, kNXT_SCFindNext, IterHandle));
    if len <> 25 then
    begin
      Result := False;
      Exit;
    end;
    IterHandle := fLink.GetReplyByte(0);    // 1 byte
    for i := Low(Buf) to High(Buf) do   // 20 bytes
    begin
      Buf[i] := Char(fLink.GetReplyByte(i+1));
    end;
    filename := Buf;
    filesize := fLink.GetReplyCardinal(21); // 4 bytes
    availsize := 0;
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTGetVersions(var protmin, protmaj, firmmin, firmmaj : byte): boolean;
var
  cmd : TBaseCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_SystemCmd, kNXT_SCGetVersions));
    if len <> 4 then
    begin
      Result := False;
      Exit;
    end;
    protmin := fLink.GetReplyByte(0);    // 1 byte
    protmaj := fLink.GetReplyByte(1);    // 1 byte
    firmmin := fLink.GetReplyByte(2);    // 1 byte
    firmmaj := fLink.GetReplyByte(3);    // 1 byte
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTCloseModuleHandle(var handle: FantomHandle; const chkResponse: boolean): boolean;
var
  cmd : TBaseCmd;
  b : byte;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    if chkResponse then
      b := kNXT_SystemCmd
    else
      b := kNXT_SystemCmdNoReply;
    len := fLink.Send(cmd.SetVal(b, kNXT_SCCloseModuleHandle, handle));
    if chkResponse then
    begin
      if len <> 1 then
      begin
        Result := False;
        Exit;
      end;
      handle := fLink.GetReplyByte(0);
    end;
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTBootCommand(const chkResponse: boolean): boolean;
var
  cmd : TNxtCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    len := fLink.Send(cmd.MakeBoot(chkResponse));
    if chkResponse then
    begin
      if len <> 4 then
      begin
        Result := False;
        Exit;
      end;
    end;
    // no need to read the 'Yes'#0 response.
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTSetBrickName(const name: string; const chkResponse: boolean): boolean;
var
  cmd : TNxtCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    len := fLink.Send(cmd.MakeSetName(name, chkResponse));
    if chkResponse then
    begin
      if len <> kRCX_OK then
      begin
        Result := False;
        Exit;
      end;
    end;
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTGetDeviceInfo(var name: string;
  var BTAddress : String; var BTSignal : Cardinal; var memFree : Cardinal): boolean;
var
  cmd : TBaseCmd;
  len, i : integer;
  addr : array[0..5] of Byte;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_SystemCmd, kNXT_SCGetDeviceInfo));
    if len <> 30 then
    begin
      Result := False;
      Exit;
    end;
    name      := fLink.GetReplyString(0, 14);
    for i := 0 to 5 do
      addr[i] := fLink.GetReplyByte(15+i);
    BTAddress := Format('%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x',
      [addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]]);
    BTSignal  := fLink.GetReplyCardinal(22);
    memFree   := fLink.GetReplyCardinal(26);
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTDeleteUserFlash(const chkResponse: boolean): boolean;
var
  cmd : TBaseCmd;
  b : byte;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    if chkResponse then
      b := kNXT_SystemCmd
    else
      b := kNXT_SystemCmdNoReply;
    len := fLink.Send(cmd.SetVal(b, kNXT_SCDeleteUserFlash));
    if chkResponse then
    begin
      if len <> kRCX_OK then
      begin
        Result := False;
        Exit;
      end;
    end;
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTBTFactoryReset(const chkResponse: boolean): boolean;
var
  cmd : TBaseCmd;
  b : byte;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    if chkResponse then
      b := kNXT_SystemCmd
    else
      b := kNXT_SystemCmdNoReply;
    len := fLink.Send(cmd.SetVal(b, kNXT_SCBTFactoryReset));
    if chkResponse then
    begin
      if len <> kRCX_OK then
      begin
        Result := False;
        Exit;
      end;
    end;
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTUploadFile(const filename: string; const dir : string): boolean;
var
  handle, h2 : FantomHandle;
  size, asize, xferred : Cardinal;
  cnt : Word;
  i : integer;
  MS : TMemoryStream;
  buf : NXTDataBuffer;
  tmpFilename : string;
begin
  Result := Open;
  if not Result then Exit;
  // upload means from NXT to PC
  tmpFilename := filename;
  Result := NXTFindFirstFile(tmpFilename, h2, size, asize);
  while Result and (tmpFilename <> '') do
  begin
    Result := NXTOpenRead(tmpFilename, handle, size) and Result;
    if Result then
    begin
      MS := TMemoryStream.Create;
      try
        xferred := 0;
        while xferred < size do
        begin
          cnt := Min(size-xferred, kNXT_MaxBytes-6);
          Result := NXTRead(handle, cnt, buf);
          if not Result then
            Break;
          for i := 0 to cnt - 1 do
            MS.Write(buf.Data[i], 1);
          inc(xferred, cnt);
        end;
        if dir <> '' then
          tmpFilename := IncludeTrailingPathDelimiter(dir) + tmpFilename;
        MS.SaveToFile(tmpFilename);
      finally
        MS.Free;
      end;
      NXTCloseFile(handle);
    end;
    Result := NXTFindNextFile(h2, tmpFilename, size, asize);
  end;
  if Result then
    NXTCloseFile(h2);
end;

function TFakeSpirit.NXTUploadFileToStream(const filename: string; aStream: TStream): boolean;
begin
  Result := True;
end;

function TFakeSpirit.NXTListFiles(const searchPattern: string;
  Files: TStrings): boolean;
var
  handle : FantomHandle;
  size, asize : Cardinal;
  tmpfilename : string;
begin
  Result := Open;
  if not Result then Exit;
  tmpfilename := searchPattern;
  Result := NXTFindFirstFile(tmpfilename, handle, size, asize);
  while Result and (tmpfilename <> '') do
  begin
    Files.Add(tmpfilename + '=' + IntToStr(size));
    Result := NXTFindNextFile(handle, tmpfilename, size, asize);
  end;
end;

function TFakeSpirit.NXTListModules(const searchPattern: string;
  Modules: TStrings): boolean;
var
  handle : FantomHandle;
  size, mID : Cardinal;
  iosize : Word;
  tmpname : string;
begin
  Result := Open;
  if not Result then Exit;
  tmpname := searchPattern;
  Result := NXTFindFirstModule(tmpname, handle, mID, size, iosize);
  while Result and (tmpname <> '') do
  begin
    Modules.Add(Format('%s=%d, %d, %d', [tmpname, mID, size, iosize]));
    Result := NXTFindNextModule(handle, tmpname, mID, size, iosize);
  end;
end;

function TFakeSpirit.NXTListBricks(Bricks: TStrings): boolean;
begin
  Result := False;
end;

function TFakeSpirit.NXTDownloadFile(const filename: string;
  const filetype: TNXTFileType): boolean;
var
  MS : TMemoryStream;
begin
  Result := Open;
  if not Result then Exit;
  // download means from PC to NXT
  Result := FileExists(filename);
  if Result then
  begin
    MS := TMemoryStream.Create;
    try
      MS.LoadFromFile(filename);
      Result := NXTDownloadStream(MS, filename, filetype);
    finally
      MS.Free;
    end;
  end;
end;

function TFakeSpirit.NXTDownloadStream(aStream: TStream; const dest : string;
  const filetype: TNXTFileType): boolean;
var
  size, xferred : Cardinal;
  cnt : Word;
  handle : FantomHandle;
  i : integer;
  buf : NXTDataBuffer;
  nxtFilename, delname : string;
begin
  Result := Open;
  if not Result then Exit;
  // download means from PC to NXT
  // make destination filename a valid NXT filename (15.3)
  nxtFilename := MakeValidNXTFilename(dest);
  delname := nxtFilename;
  NXTDeleteFile(delname, True);
  size := aStream.Size;
  if filetype in [nftProgram, nftGraphics] then
    Result := NXTOpenWriteLinear(nxtFilename, size, handle)
  else if filetype = nftData then
    Result := NXTOpenWriteData(nxtFilename, size, handle)
  else
    Result := NXTOpenWrite(nxtFilename, size, handle);
  if Result then
  begin
    // write in < 64 byte chunks
    xferred := 0;
    aStream.Position := 0; // start at the beginning
    while xferred < size do
    begin
      cnt := Min(size - xferred, kNXT_MaxBytes-3);
//      // position the stream to the current read location
//      aStream.Seek(xferred, soFromBeginning);
      // fill our buffer with the right number of bytes
      for i := 0 to cnt - 1 do
        aStream.Read(buf.Data[i], 1);
      // write these bytes to the NXT
      Result := NXTWrite(handle, buf, cnt, cnt = (size - xferred));
      if not Result then Break;
      inc(xferred, cnt);
    end;
    Result := NXTCloseFile(handle) and Result;
  end;
end;

function TFakeSpirit.NXTPollCommandLen(const bufNum : byte; var count: byte): boolean;
var
  cmd : TBaseCmd;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_SystemCmd, kNXT_SCPollCommandLen, bufNum));
    if len <> 2 then
    begin
      Result := False;
      Exit;
    end;
    // ignore the first return byte (bufNum)
    count := fLink.GetReplyByte(1);
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTPollCommand(const bufNum: byte; var count: byte;
  var buffer: NXTDataBuffer): boolean;
var
  cmd : TBaseCmd;
  len, i : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_SystemCmd, kNXT_SCPollCommand, bufNum, count));
    if len <> kNXT_MaxBytes-3 then
    begin
      Result := False;
      Exit;
    end;
    // ignore the first return byte (bufNum)
    count := fLink.GetReplyByte(1);
    for i := 0 to count - 1 do
    begin
      buffer.Data[i] := fLink.GetReplyByte(i+2);
    end;
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTWriteIOMap(var ModID: Cardinal;
  const Offset: Word; var count: Word; const buffer: NXTDataBuffer;
  chkResponse : Boolean): boolean;
var
  cmd : TNxtCmd;
  b : byte;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    if chkResponse then
      b := kNXT_SystemCmd
    else
      b := kNXT_SystemCmdNoReply;
    len := fLink.Send(cmd.MakeCmdWriteIOMap(b, kNXT_SCIOMapWrite, ModID, offset, count, buffer.Data));
    if chkResponse then
    begin
      if len <> 6 then
      begin
        Result := False;
        Exit;
      end;
      ModID := fLink.GetReplyCardinal(0); // first 4 bytes
      count  := fLink.GetReplyWord(4); // bytes 5 & 6
    end;
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTReadIOMap(var ModID: Cardinal;
  const Offset: Word; var Count: Word; var buffer: NXTDataBuffer): boolean;
var
  cmd : TNxtCmd;
  len, i : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    len := fLink.Send(cmd.MakeCmdReadIOMap(kNXT_SystemCmd, kNXT_SCIOMapRead,
      ModID, Offset, Count));
    if len < 6 then
    begin
      Result := False;
      Exit;
    end;
    ModID := fLink.GetReplyCardinal(0); // first 4 bytes
    Count  := fLink.GetReplyWord(4); // bytes 5 & 6
    for i := 0 to 63 do begin
      if i >= Count then Break;
      buffer.Data[i] := fLink.GetReplyByte(6+i);
    end;
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTFindNextModule(var Handle: FantomHandle;
  var ModName: string; var ModID, ModSize: Cardinal;
  var IOMapSize: Word): boolean;
var
  cmd : TBaseCmd;
  len, i : integer;
  Buf : array[0..19] of Char;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TBaseCmd.Create;
  try
    len := fLink.Send(cmd.SetVal(kNXT_SystemCmd, kNXT_SCFindNextModule, Handle));
    if len <> 31 then
    begin
      Result := False;
      Exit;
    end;
    Handle := fLink.GetReplyByte(0);    // 1 byte
    for i := Low(Buf) to High(Buf) do   // 20 bytes
    begin
      Buf[i] := Char(fLink.GetReplyByte(i+1));
    end;
    ModName := Buf;
    ModID := fLink.GetReplyCardinal(21); // 4 bytes
    ModSize := fLink.GetReplyCardinal(25); // 4 bytes
    IOMapSize := fLink.GetReplyCardinal(29); // 2 bytes
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTFindFirstModule(var ModName: string; var Handle: FantomHandle;
  var ModID, ModSize: Cardinal; var IOMapSize: Word): boolean;
var
  cmd : TNxtCmd;
  len, i : integer;
  Buf : array[0..19] of Char;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    len := fLink.Send(cmd.MakeCmdWithFilename(kNXT_SystemCmd, kNXT_SCFindFirstModule, ModName));
    if len <> 31 then
    begin
      Result := False;
      Exit;
    end;
    Handle := fLink.GetReplyByte(0);    // 1 byte
    for i := Low(Buf) to High(Buf) do   // 20 bytes
    begin
      Buf[i] := Char(fLink.GetReplyByte(i+1));
    end;
    ModName := Buf;
    ModID := fLink.GetReplyCardinal(21); // 4 bytes
    ModSize := fLink.GetReplyCardinal(25); // 4 bytes
    IOMapSize := fLink.GetReplyCardinal(29); // 2 bytes
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.GetLinkLog: string;
begin
  Result := fLink.Log;
end;

procedure TFakeSpirit.NXTInitializeResourceNames;
begin
  // do nothing
end;

function TFakeSpirit.NXTFreeMemory: integer;
begin
  Result := 0;
end;

function TFakeSpirit.NXTRenameFile(const old, new: string;
  const chkResponse: boolean): boolean;
var
  cmd : TNxtCmd;
  len : integer;
  b : byte;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    if chkResponse then
      b := kNXT_SystemCmd
    else
      b := kNXT_SystemCmdNoReply;
    len := fLink.Send(cmd.MakeCmdRenameFile(b, old, new));
    if chkResponse then
    begin
      if len <> 41 then // check this???
      begin
        Result := False;
        Exit;
      end;
    end;
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
end;

function TFakeSpirit.NXTFindClose(var IterHandle: FantomHandle): boolean;
begin
  Result := True;
end;

procedure TFakeSpirit.NXTUpdateResourceNames;
begin
  // do nothing
end;

{ EMessageInvalid }

resourcestring
  sErrorInvalidMessage = 'Invalid raw message';

constructor EMessageInvalid.Create(aMsg: string);
begin
  inherited Create(sErrorInvalidMessage + ' ' + aMsg);
end;

end.
