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
 * Portions created by John Hansen are Copyright (C) 2012-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit SSHSpirit;

interface

{$IFDEF FPC}
{$HINTS OFF}
{$ENDIF}

uses
  Classes, SysUtils, rcx_cmd, uSpirit, uNXTConstants, FantomDefs,
  uUtilities, uSerial, uCompCommon;

type
  TSSHSpirit = class(TBrickComm)
  private
    fSerialHandle : THandle;
    dcResponse : array [0..63] of byte;
  protected
    function  GetPortName: string; override;
    function  GetDownloadWaitTime: Integer; override;
    function  GetEEPROM(addr: Byte): Byte; override;
    function  GetEEPROMBlock(idx: Integer): EEPROMBlock; override;
    function  GetIsOpen: boolean; override;
    function  GetLSBlock(aPort: byte): NXTLSBlock; override;
    function  GetOmitHeader: Boolean; override;
    function  GetQuiet: Boolean; override;
    function  GetRCXFirmwareChunkSize: Integer; override;
    function  GetRxTimeout: Word; override;
    function  GetLinkLog: string; override;
    procedure SetDownloadWaitTime(const Value: Integer); override;
    procedure SetEEPROM(addr: Byte; const Value: Byte); override;
    procedure SetLSBlock(aPort: byte; const Value: NXTLSBlock); override;
    procedure SetOmitHeader(const Value: Boolean); override;
    procedure SetPort(const Value: string); override;
    procedure SetQuiet(const Value: Boolean); override;
    procedure SetRCXFirmwareChunkSize(const Value: Integer); override;
    procedure SetRxTimeout(const Value: Word); override;
  protected
    function  dcBuffer: PByte;
    function  GetReplyByte(index: integer): Byte;
    function  GetReplyCardinal(index: integer): Cardinal;
    function  GetReplyWord(index: integer): Word;

    function  DoSerialWrite(Handle: THandle; Data : array of byte; Count: LongInt) : LongInt; overload;
    function  DoSerialWrite(Handle: THandle; Data : string; Count: LongInt) : LongInt; overload;
    function  DoSerialFlushRead(Handle: THandle; delay : Integer; var Data : TJCHBytes) : boolean;
    function  DoSerialFlushToChar(Handle: THandle; delay : Integer; ch : Char; var Data : TJCHBytes) : LongInt;

  public
    constructor Create(aType : byte = 0; const aPort : string = ''); override;
    destructor Destroy; override;

    function  Open : boolean; override;
    function  Close : boolean; override;

    procedure FlushReceiveBuffer; override;
    procedure SendRawData(Data : array of byte); override;

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

    function Poll(aSrc, aNum : integer) : variant; override;
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
    function GetVariableValue(aVar: integer): variant; override;
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
    function DCStartProgram(const filename : string) : boolean; override;
    function DCStopProgram : boolean; override;
    function DCPlaySoundFile(const filename : string; bLoop : boolean) : boolean; override;
    function DCGetOutputState(const aPort : byte; var power : integer;
      var mode, regmode : byte; var turnratio : integer;
      var runstate : byte; var tacholimit : cardinal; var tachocount,
      blocktachocount, rotationcount : longint) : boolean; override;
    function DCSetOutputState(const aPort : byte; const power : integer;
      const mode, regmode : byte; const turnratio : integer;
      const runstate : byte; const tacholimit : cardinal) : boolean; override;
    function DCGetInputValues(const aPort : byte; var valid, calibrated : boolean;
      var stype, smode : byte; var raw, normalized : word;
      var scaled, calvalue : smallint) : boolean; override;
    function DCSetInputMode(const aPort, stype, smode : byte) : boolean; override;
    function DCResetInputScaledValue(const aPort : byte) : boolean; override;
    function DCResetOutputPosition(const aPort : byte; const Relative : boolean) : boolean; override;
    function DCMessageWrite(const inbox : byte; const msg : string) : boolean; override;
    function DCKeepAlive(var time : cardinal; const chkResponse : boolean = true) : boolean; override;
    function DCLSGetStatus(aPort : byte; var bytesReady : byte; var lsstate : byte) : boolean; override;
    function DCGetCurrentProgramName(var name : string) : boolean; override;
    function DCGetButtonState(const idx : byte; const reset : boolean;
      var pressed : boolean; var count : byte) : boolean; override;
    function DCMessageRead(const remote, local : byte; const remove : boolean; var Msg : PBRMessage) : boolean; override;
    function DCSetPropDebugging(const debugging : boolean; const pauseClump : byte; const pausePC : Word) : boolean; override;
    function DCGetPropDebugging(var debugging : boolean; var pauseClump : byte; var pausePC : Word) : boolean; override;
    function DCSetVMState(const state : byte) : boolean; override;
    function DCSetVMStateEx(var state : byte; var clump : byte; var pc : word) : boolean; override;
    function DCGetVMState(var state : byte; var clump : byte; var pc : word) : boolean; override;
    // NXT system commands
    function SCOpenRead(const filename : string; var handle : FantomHandle;
      var size : cardinal) : boolean; override;
    function SCOpenWrite(const filename : string; const size : cardinal;
      var handle : FantomHandle) : boolean; override;
    function SCRead(var handle : FantomHandle; var count : word;
      var buffer : PBRDataBuffer) : boolean; override;
    function SCWrite(var handle : FantomHandle; const buffer : PBRDataBuffer;
      var count : word; const chkResponse : boolean = false) : boolean; override;
    function SCCloseFile(var handle : FantomHandle; const chkResponse: boolean = false) : boolean; override;
    function SCDeleteFile(var filename : string; const chkResponse: boolean = false) : boolean; override;
    function SCFindFirstFile(var filename : string; var IterHandle : FantomHandle; var filesize, availsize : cardinal) : boolean; override;
    function SCFindNextFile(var IterHandle : FantomHandle; var filename : string; var filesize, availsize : cardinal) : boolean; override;
    function SCFindClose(var IterHandle : FantomHandle) : boolean; override;
    function SCGetVersions(var protmin, protmaj, firmmin, firmmaj : byte) : boolean; override;
    function SCFirmwareVersion : word; override;
    function SCInstalledFirmware : TInstalledFirmware; override;
    function SCOpenWriteLinear(const filename : string; const size : cardinal;
      var handle : FantomHandle) : boolean; override;
    function SCOpenReadLinear(const filename : string; var handle : FantomHandle;
      var size : cardinal) : boolean; override;
    function SCOpenWriteData(const filename : string; const size : cardinal;
      var handle : FantomHandle) : boolean; override;
    function SCOpenAppendData(const filename : string; var size : cardinal;
      var handle : FantomHandle) : boolean; override;
    function SCCloseModuleHandle(var handle : FantomHandle; const chkResponse: boolean = false) : boolean; override;
    function SCBootCommand(const chkResponse: boolean = false) : boolean; override;
    function SCSetBrickName(const name : string; const chkResponse: boolean = false) : boolean; override;
    function SCGetDeviceInfo(var name : string; var BTAddress : string;
      var BTSignal : Cardinal; var memFree : Cardinal) : boolean; override;
    function SCFreeMemory : integer; override;
    function SCDeleteUserFlash(const chkResponse: boolean = false) : boolean; override;
    function SCBTFactoryReset(const chkResponse: boolean = false) : boolean; override;
    function SCPollCommandLen(const bufNum : byte; var count : byte) : boolean; override;
    function SCPollCommand(const bufNum : byte; var count : byte;
      var buffer : PBRDataBuffer) : boolean; override;
    function SCWriteIOMap(var ModID : Cardinal; const Offset : Word;
      var count : Word; const buffer : PBRDataBuffer; chkResponse : Boolean = False) : boolean; override;
    function SCReadIOMap(var ModID : Cardinal; const Offset : Word;
      var count : Word; var buffer : PBRDataBuffer) : boolean; override;
    function SCFindFirstModule(var ModName : string; var Handle : FantomHandle;
      var ModID, ModSize : Cardinal; var IOMapSize : Word) : boolean; override;
    function SCFindNextModule(var Handle : FantomHandle; var ModName : string;
      var ModID, ModSize : Cardinal; var IOMapSize : Word) : boolean; override;
    function SCRenameFile(const old, new : string; const chkResponse: boolean = false) : boolean; override;
    // wrapper functions
    function DownloadFile(const filename : string; const filetype : TPBRFileType) : boolean; override;
    function DownloadStream(aStream : TStream; const dest : string; const filetype : TPBRFileType) : boolean; override;
    function UploadFile(const filename : string; const dir : string = '') : boolean; override;
    function UploadFileToStream(const filename : string; aStream : TStream) : boolean; override;
    function ListFiles(const searchPattern : string; Files : TStrings) : boolean; override;
    function ListModules(const searchPattern : string; Modules : TStrings) : boolean; override;
    function ListBricks(Bricks : TStrings) : boolean; override;
    function InitializeResourceNames : boolean; override;
    function UpdateResourceNames : boolean; override;
  end;

implementation

uses
{$IFNDEF FPC}
  Windows,
{$ENDIF}
  rcx_constants, Contnrs, Math, uCommonUtils, uDebugLogging;

{$IFDEF FPC}
const
  NOPARITY = 0;
  ODDPARITY = 1;
  EVENPARITY = 2;
  MARKPARITY = 3;
  SPACEPARITY = 4;

  ONESTOPBIT = 0;
  ONE5STOPBITS = 1;
  TWOSTOPBITS = 2;
{$ENDIF}

procedure DoBeep(aFreq, aDur : cardinal);
begin
{$IFNDEF FPC}
  Beep(aFreq, aDur);
{$ELSE}
  if (aFreq > 0) and (aDur > 0) then
    Beep;
{$ENDIF}
end;

function EV3SerialOpen(const DeviceName: String): THandle;
begin
  Result := SerialOpen(DeviceName);
  if SerialIsHandleValid(Result) then
  begin
    SerialSetParams(Result, 115200, 8, NOPARITY, ONESTOPBIT);
    SerialSetDTR(Result, True);
    SerialSetRTS(Result, False);
  end;
end;

{ TSSHSpirit }

constructor TSSHSpirit.Create(aType: byte; const aPort: string);
begin
  inherited Create(aType, aPort);
  fSerialHandle := INVALID_HANDLE_VALUE;
end;

destructor TSSHSpirit.Destroy;
begin
  inherited Destroy;
end;

function TSSHSpirit.BatteryLevel: integer;
begin
  Result := -1;
  if IsOpen then
  begin
  end;
end;

function TSSHSpirit.Shutdown: boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.MotorsOn(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TSSHSpirit.MotorsOff(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TSSHSpirit.MotorsFloat(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TSSHSpirit.SetFwd(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TSSHSpirit.SetRwd(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TSSHSpirit.SwitchDirection(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TSSHSpirit.SetMotorPower(aMotorList: Byte; aSrc, aNum: integer): boolean;
begin
  Result := False;
end;

function TSSHSpirit.PlayTone(aFreq, aTime: word): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  DoBeep(aFreq, aTime);
end;

function TSSHSpirit.SetSensorType(aNum, aType: integer): boolean;
begin
  Result := False;
end;

function TSSHSpirit.SetSensorMode(aNum, aMode, aSlope: integer): boolean;
begin
  Result := False;
end;

function TSSHSpirit.ClearSensorValue(aNum: integer): boolean;
begin
  Result := False;
end;

function TSSHSpirit.Close: boolean;
begin
  Result := inherited Close;
  SerialClose(fSerialHandle);
  fActive := False;
  fSerialHandle := INVALID_HANDLE_VALUE;
end;

function TSSHSpirit.Open: boolean;
begin
  Result := IsOpen;
  if not Result then begin
    fSerialHandle := EV3SerialOpen(PortName);
    fActive := SerialIsHandleValid(fSerialHandle);
    Result := fActive;
  end;
end;

function TSSHSpirit.ClearMemory: boolean;
begin
  Result := False;
end;

function TSSHSpirit.Sleep(aVal: integer): boolean;
begin
  Result := Open;
end;

function TSSHSpirit.GetInputValue(aIn : integer) : integer;
begin
  Result := -1;
  if Open then
  begin
  end;
end;

procedure TSSHSpirit.SetPort(const Value: string);
begin
  inherited SetPort(Value);
end;

function TSSHSpirit.DownloadFirmware(aFile: string; bFast : Boolean;
  bComp : Boolean; bUnlock : boolean): boolean;
begin
  Result := False;
end;

function TSSHSpirit.Ping: boolean;
begin
  Result := Open;
  if not Result then Exit;
  // send something and check for echo?
end;

function TSSHSpirit.MuteSound: boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.UnmuteSound: boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.GetIsOpen: boolean;
begin
  Result := inherited GetIsOpen;
end;

function TSSHSpirit.DCStartProgram(const filename: string): boolean;
begin
  Result := StartTask(0);
end;

function TSSHSpirit.DCStopProgram: boolean;
begin
  Result := Open;
  if not Result then Exit;
end;

function TSSHSpirit.DCPlaySoundFile(const filename: string; bLoop: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.DCGetOutputState(const aPort: byte; var power: integer;
  var mode, regmode: byte; var turnratio: integer; var runstate: byte;
  var tacholimit: cardinal; var tachocount, blocktachocount, rotationcount: Integer): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  power := 0;
  mode := 0;
  regmode := 0;
  turnratio := 0;
  runstate := 0;
  tacholimit := 0;
  tachocount := 0;
  blocktachocount := 0;
  rotationcount := 0;
end;

function TSSHSpirit.DCSetOutputState(const aPort: byte;
  const power: integer; const mode, regmode: byte;
  const turnratio: integer; const runstate: byte;
  const tacholimit: cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.DCGetInputValues(const aPort: byte; var valid,
  calibrated: boolean; var stype, smode: byte; var raw, normalized: word;
  var scaled, calvalue: smallint): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  stype := 0;
  smode := 0;
  raw := 0;
  normalized := 0;
  scaled := 0;
  calvalue := 0;
end;

function TSSHSpirit.DCSetInputMode(const aPort, stype, smode: byte): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.DCResetInputScaledValue(const aPort: byte): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.DCResetOutputPosition(const aPort: byte;
  const Relative: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.DCMessageWrite(const inbox: byte; const msg: string): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.DCKeepAlive(var time: cardinal; const chkResponse : boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.DCLSGetStatus(aPort : byte; var bytesReady: byte; var lsstate : byte): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.GetLSBlock(aPort: byte): NXTLSBlock;
begin
  Result.RXCount := 0;
end;

procedure TSSHSpirit.SetLSBlock(aPort: byte; const Value: NXTLSBlock);
begin
  if aPort = 0 then Exit;
end;

function TSSHSpirit.DCGetCurrentProgramName(var name: string): boolean;
begin
  Result := IsOpen;
  name := '';
end;

function TSSHSpirit.DCGetButtonState(const idx: byte; const reset: boolean;
  var pressed: boolean; var count: byte): boolean;
begin
  Result := IsOpen;
  pressed := False;
  count := 0;
end;

function TSSHSpirit.DCMessageRead(const remote, local: byte;
  const remove: boolean; var Msg: PBRMessage): boolean;
begin
  Msg.Inbox := 0;
  Msg.Size  := 0;
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCOpenRead(const filename: string; var handle: FantomHandle;
  var size: cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  handle := 0;
  size := 0;
end;

function TSSHSpirit.SCOpenReadLinear(const filename: string;
  var handle: FantomHandle; var size: cardinal): boolean;
begin
  Result := SCOpenRead(filename, handle, size);
end;

function TSSHSpirit.SCOpenAppendData(const filename: string;
  var size: cardinal; var handle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCOpenWrite(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCOpenWriteData(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCOpenWriteLinear(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCRead(var handle: FantomHandle; var count: word;
  var buffer: PBRDataBuffer): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCWrite(var handle: FantomHandle; const buffer: PBRDataBuffer;
  var count: word; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCCloseFile(var handle: FantomHandle; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCDeleteFile(var filename: string; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCFindFirstFile(var filename: string;
  var IterHandle: FantomHandle; var filesize, availsize : cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCFindNextFile(var IterHandle: FantomHandle; var filename: string;
  var filesize, availsize : cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCFindClose(var IterHandle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCGetVersions(var protmin, protmaj, firmmin, firmmaj : byte): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  protmin := 0;
  protmaj := 0;
  firmmin := 0;
  firmmaj := 0;
end;

function TSSHSpirit.SCFirmwareVersion : word;
begin
  Result := 128;
end;

function TSSHSpirit.SCInstalledFirmware : TInstalledFirmware;
begin
  result := ifEnhanced;
end;

function TSSHSpirit.SCCloseModuleHandle(var handle: FantomHandle; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCBootCommand(const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCSetBrickName(const name: string; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCGetDeviceInfo(var name: string;
  var BTAddress : String; var BTSignal : Cardinal; var memFree : Cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCDeleteUserFlash(const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSSHSpirit.SCBTFactoryReset(const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

type
  TFileInfoRec = class
  public
    FileHandle : FantomHandle;
    TotalSize : Cardinal;
    AvailableSize : Cardinal;
    Name : string;
  end;

function TSSHSpirit.UploadFile(const filename: string; const dir : string): boolean;
begin
  Result := False;
end;

function TSSHSpirit.UploadFileToStream(const filename: string; aStream: TStream): boolean;
begin
  Result := False;
end;

function TSSHSpirit.ListFiles(const searchPattern: string; Files: TStrings): boolean;
begin
  Result := False;
  Files.Clear;
end;

function TSSHSpirit.ListModules(const searchPattern: string;  Modules: TStrings): boolean;
begin
  Result := False;
  Modules.Clear;
end;

function TSSHSpirit.ListBricks(Bricks: TStrings): boolean;
begin
  Result := False;
  Bricks.Clear;
end;

function TSSHSpirit.DownloadFile(const filename: string; const filetype: TPBRFileType): boolean;
var
  MS : TMemoryStream;
begin
  Result := IsOpen;
  if not Result then Exit;
  Result := FileExists(filename);
  if Result then
  begin
    MS := TMemoryStream.Create;
    try
      MS.LoadFromFile(filename);
      Result := DownloadStream(MS, filename, filetype);
    finally
      MS.Free;
    end;
  end;
end;

function TSSHSpirit.DownloadStream(aStream: TStream; const dest : string;
  const filetype: TPBRFileType): boolean;
var
  b1, b2, b3 : byte;
  SL : TStringList;
  i, len : integer;
  tmp : string;
  Data : TJCHBytes;
begin
  Result := IsOpen;
  if not Result then Exit;
  // does the stream start with $0D$0A$3A?  If not then it is not in OBJ format.
  // also needs to end in $0D$0A$1A
  Result := aStream.Size > 3;
  if not Result then Exit;
  aStream.Position := 0;
  aStream.Read(b1, 1);
  aStream.Read(b2, 1);
  aStream.Read(b3, 1);
  Result := (b1 = $0D) and (b2 = $0A) and (b3 = $3A);
  if not Result then Exit;
  aStream.Seek(-3, soFromEnd);
  aStream.Read(b1, 1);
  aStream.Read(b2, 1);
  aStream.Read(b3, 1);
  Result := (b1 = $0D) and (b2 = $0A) and (b3 = $1A);
  if not Result then Exit;

  DoSerialFlushRead(fSerialHandle, 50, Data);

  aStream.Position := 0;
  SL := TStringList.Create;
  try
    SL.LoadFromStream(aStream);
    // skip line 0 since it is blank and the last line (containing only $1A)
    for i := 1 to SL.Count - 2 do
    begin
      tmp := SL[i] + #13#10;  // need to send CRLF after each line (doh!)
      len := Length(tmp);
      Result := DoSerialWrite(fSerialHandle, tmp, len) = len;
      if not Result then Exit;
      // read echo until we (eventually) get the LF echo
      DoSerialFlushToChar(fSerialHandle, 50, Chr($0A), Data);
      // once we get the LF then drain anything else
      DoSerialFlushRead(fSerialHandle, 50, Data);
    end;
  finally
    SL.Free;
  end;
end;

function TSSHSpirit.SCPollCommandLen(const bufNum : byte; var count: byte): boolean;
begin
  Result := False;
end;

function TSSHSpirit.SCPollCommand(const bufNum: byte; var count: byte;
  var buffer: PBRDataBuffer): boolean;
begin
  Result := False;
end;

function TSSHSpirit.SCWriteIOMap(var ModID: Cardinal;
  const Offset: Word; var count: Word; const buffer: PBRDataBuffer;
  chkResponse : Boolean): boolean;
begin
  Result := False;
end;

function TSSHSpirit.SCReadIOMap(var ModID: Cardinal;
  const Offset: Word; var Count: Word; var buffer: PBRDataBuffer): boolean;
begin
  Result := False;
end;

function TSSHSpirit.SCFindNextModule(var Handle: FantomHandle;
  var ModName: string; var ModID, ModSize: Cardinal;
  var IOMapSize: Word): boolean;
begin
  Result := False;
end;

function TSSHSpirit.SCFindFirstModule(var ModName: string; var Handle: FantomHandle;
  var ModID, ModSize: Cardinal; var IOMapSize: Word): boolean;
begin
  Result := False;
end;

function TSSHSpirit.dcBuffer: PByte;
begin
  Result := @dcResponse[0];
end;

function TSSHSpirit.GetReplyByte(index: integer): Byte;
const
  DCReplyOffset = 2;
begin
  Result := dcResponse[index + DCReplyOffset];
end;

function TSSHSpirit.GetReplyCardinal(index: integer): Cardinal;
begin
  Result := BytesToCardinal(GetReplyByte(index),
                            GetReplyByte(index+1),
                            GetReplyByte(index+2),
                            GetReplyByte(index+3));
end;

function TSSHSpirit.GetReplyWord(index: integer): Word;
begin
  Result := Word(BytesToCardinal(GetReplyByte(index), GetReplyByte(index+1)));
end;

function TSSHSpirit.GetDownloadWaitTime: Integer;
begin
  Result := 0;
end;

function TSSHSpirit.GetEEPROM(addr: Byte): Byte;
begin
  Result := addr;
end;

function TSSHSpirit.GetEEPROMBlock(idx: Integer): EEPROMBlock;
begin
  Result.Data[idx] := 0;
end;

function TSSHSpirit.GetLinkLog: string;
begin
  Result := '';
end;

function TSSHSpirit.GetOmitHeader: Boolean;
begin
  Result := False;
end;

function TSSHSpirit.GetQuiet: Boolean;
begin
  Result := False;
end;

function TSSHSpirit.GetRCXFirmwareChunkSize: Integer;
begin
  Result := 200;
end;

function TSSHSpirit.GetRxTimeout: Word;
begin
  Result := 400;
end;

procedure TSSHSpirit.SetDownloadWaitTime(const Value: Integer);
begin
// do nothing
  if Value = 0 then Exit;
end;

procedure TSSHSpirit.SetEEPROM(addr: Byte; const Value: Byte);
begin
// do nothing
  if Value = 0 then Exit;
  if addr = 0 then Exit;
end;

procedure TSSHSpirit.SetOmitHeader(const Value: Boolean);
begin
// do nothing
  if Value then Exit;
end;

procedure TSSHSpirit.SetQuiet(const Value: Boolean);
begin
// do nothing
  if Value then Exit;
end;

procedure TSSHSpirit.SetRCXFirmwareChunkSize(const Value: Integer);
begin
// do nothing
  if Value = 0 then Exit;
end;

procedure TSSHSpirit.SetRxTimeout(const Value: Word);
begin
// do nothing
  if Value = 0 then Exit;
end;

function TSSHSpirit.AbsVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSSHSpirit.AndVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSSHSpirit.BrickAlive: boolean;
begin
  Result := Open;
end;

function TSSHSpirit.CalibrateEvent(enum, upper, lower,
  hysteresis: integer): boolean;
begin
  Result := Open;
  if enum = 0 then Exit;
  if upper = 0 then Exit;
  if lower = 0 then Exit;
  if hysteresis = 0 then Exit;
end;

function TSSHSpirit.CalibrateLightSensor: boolean;
begin
  Result := Open;
end;

function TSSHSpirit.ClearAllEvents: boolean;
begin
  Result := Open;
end;

function TSSHSpirit.ClearCounter(num: TCounterNumber): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
end;

function TSSHSpirit.ClearSound: boolean;
begin
  Result := Open;
end;

function TSSHSpirit.ClearTachoCounter(aMotorList: Byte): boolean;
begin
  Result := Open;
  if aMotorList = 0 then Exit;
end;

function TSSHSpirit.ClearTimer(aNum: integer): boolean;
begin
  Result := Open;
  if aNum = 0 then Exit;
end;

function TSSHSpirit.DatalogNext(aSrc, aNum: integer): boolean;
begin
  Result := False;
  if aSrc = 0 then Exit;
  if aNum = 0 then Exit;
end;

function TSSHSpirit.DecCounter(num: TCounterNumber): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
end;

function TSSHSpirit.DeleteAllSubs: boolean;
begin
  Result := False;
end;

function TSSHSpirit.DeleteAllTasks: boolean;
begin
  Result := False;
end;

function TSSHSpirit.DeleteSub(aSub: integer): boolean;
begin
  Result := False;
end;

function TSSHSpirit.DeleteTask(aTask: integer): boolean;
begin
  Result := False;
  if aTask = 0 then Exit;
end;

function TSSHSpirit.DivVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSSHSpirit.DownloadMemoryMap: TStrings;
begin
  Result := fMemMap;
end;

function TSSHSpirit.Drive(aLeft, aRight: integer): boolean;
begin
  Result := Open;
  if aLeft = 0 then Exit;
  if aRight = 0 then Exit;
end;

function TSSHSpirit.GetCounterValue(aNum: integer): integer;
begin
  Result := Poll(kRCX_CounterType, aNum);
end;

function TSSHSpirit.GetMessageValue(aNum: integer): integer;
begin
  Result := Poll(kRCX_MessageType, aNum);
end;

function TSSHSpirit.GetOutputStatus(aOut: integer): integer;
begin
  Result := 0;
  if aOut = 0 then Exit;
end;

function TSSHSpirit.GetTimerValue(aNum: integer): integer;
begin
  Result := Poll(kRCX_TimerType, aNum);
end;

function TSSHSpirit.GetVariableValue(aVar: integer): variant;
begin
  Result := Poll(kRCX_VariableType, aVar);
end;

function TSSHSpirit.IncCounter(num: TCounterNumber): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
end;

function TSSHSpirit.MonitorIR(aSeconds: integer): TStrings;
begin
  Result := fMemData;
  if aSeconds = 0 then Exit;
end;

function TSSHSpirit.MulVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSSHSpirit.OnWait(aMotorList: Byte; aNum: integer; aTime: Byte): boolean;
begin
  Result := Open;
  if aMotorList = 0 then Exit;
  if aNum = 0 then Exit;
  if aTime = 0 then Exit;
end;

function TSSHSpirit.OnWaitDifferent(aMotorList: Byte; aNum0, aNum1,
  aNum2: integer; aTime: Byte): boolean;
begin
  Result := Open;
  if aMotorList = 0 then Exit;
  if aNum0 = 0 then Exit;
  if aNum1 = 0 then Exit;
  if aNum2 = 0 then Exit;
  if aTime = 0 then Exit;
end;

function TSSHSpirit.OrVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSSHSpirit.PlaySystemSound(aSnd: byte): boolean;
begin
  Result := False;
end;

function TSSHSpirit.Poll(aSrc, aNum: integer): variant;
begin
  Result := 0;
end;

function TSSHSpirit.PollEEPROM(block: Integer): TStrings;
begin
  Result := fMemData;
  fMemData.Clear;
end;

function TSSHSpirit.PollMemory(address, size: Integer): TStrings;
begin
  Result := fMemData;
end;

function TSSHSpirit.PowerDownTime(aTime: integer): boolean;
begin
  Result := Open;
  if not Result then Exit;
end;

function TSSHSpirit.PrepareBrick: boolean;
begin
  Result := Open;
end;

function TSSHSpirit.Scout(bPower: boolean): boolean;
begin
  Result := Open and bPower;
end;

function TSSHSpirit.ScoutNum(aVal: integer): boolean;
begin
  Result := Open;
  if aVal = 0 then Exit;
end;

function TSSHSpirit.ScoutRules(motion: TScoutMotion; touch: TScoutTouch;
  light: TScoutLight; time: TScoutScale; fx: TScoutEffects): boolean;
begin
  Result := Open;
  if motion = smNone then Exit;
  if touch = stIgnore then Exit;
  if light = slIgnore then Exit;
  if time = ssShort then Exit;
  if fx = seNone then Exit;
end;

function TSSHSpirit.ScoutSound(bSoundEnable, bSoundOff: boolean;
  aNum: TSoundSetNumber): boolean;
begin
  Result := Open and bSoundEnable and bSoundOff;
  if aNum = 0 then Exit;
end;

function TSSHSpirit.SelectDisplay(aSrc, aNumber: integer): boolean;
begin
  Result := False;
  if (aSrc = 0) or (aNumber = 0) then Exit;
end;

function TSSHSpirit.SelectProgram(aProg: integer): boolean;
begin
  Result := Open;
  if aProg > 0 then Exit;
end;

function TSSHSpirit.SendMessage(aMsg: integer): boolean;
begin
  Result := DCMessageWrite(0, IntToStr(aMsg));
end;

function TSSHSpirit.SendRawCommand(aCmd: string; bRetry: boolean): string;
begin
  Result := '';
  if (aCmd = '') or bRetry then Exit;
end;

function TSSHSpirit.SendRemoteStr(aEvent: string; aRepeat: integer): boolean;
begin
  Result := Open;
  if (aEvent = '') or (aRepeat = 0) then Exit;
end;

function TSSHSpirit.SendRemote(aEvent: Word; aRepeat: integer): boolean;
begin
  Result := Open;
  if (aEvent = 0) or (aRepeat = 0) then Exit;
end;

function TSSHSpirit.SendUARTData(start, size: integer): boolean;
begin
  Result := Open;
  if start = 0 then Exit;
  if size = 0 then Exit;
end;

function TSSHSpirit.SendVLL(aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if aSrc = 0 then Exit;
  if aNum = 0 then Exit;
end;

function TSSHSpirit.SetCounterLimit(num: TCounterNumber; src: TTCSource;
  val: integer): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
  if src = tcVariable then Exit;
  if val = 0 then Exit;
end;

function TSSHSpirit.SetDatalog(aSize: integer): boolean;
begin
  Result := False;
  if aSize = 0 then Exit;
end;

function TSSHSpirit.SetEvent(enum, snum, etype: integer): boolean;
begin
  Result := Open;
  if (enum = 0) or (snum = 0) or (etype = 0) then Exit;
end;

function TSSHSpirit.SetFeedback(src, val: integer): boolean;
begin
  Result := Open;
  if (src = 0) or (val = 0) then Exit;
end;

function TSSHSpirit.SetGlobalDirection(motors: TMotorsNum; action: TGlobalDirAction): boolean;
begin
  Result := Open;
  if (motors = 0) or (action = gdaBackward) then Exit;
end;

function TSSHSpirit.SetGlobalOutput(motors: TMotorsNum; action: TGlobalOutAction): boolean;
begin
  Result := Open;
  if (motors = 0) or (action = goaFloat) then Exit;
end;

function TSSHSpirit.SetLight(bOn: boolean): boolean;
begin
  Result := Open and bOn;
end;

function TSSHSpirit.SetLightSensorBlinkTime(src: TLSSource; val: TBlinkTimeValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TSSHSpirit.SetLightSensorHysteresis(src: TLSSource; val: TThresholdValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TSSHSpirit.SetLightSensorLowerThreshold(src: TLSSource; val: TThresholdValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TSSHSpirit.SetLightSensorUpperThreshold(src: TLSSource; val: TThresholdValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TSSHSpirit.SetMaxPower(motors: TMotorsNum; src, num: integer): boolean;
begin
  Result := Open;
  if (motors = 0) or (src = 0) or (num = 0) then Exit;
end;

function TSSHSpirit.SetSourceValue(aDestSrc, aDestVal, aOrigSrc: Byte; aOrigVal: Smallint): boolean;
begin
  Result := Open;
  if (aDestSrc = 0) or (aDestVal = 0) or (aOrigSrc = 0) or (aOrigVal = 0) then Exit;
end;

function TSSHSpirit.SetTimerLimit(num: TTimerNumber; src: TTCSource; val: integer): boolean;
begin
  Result := Open;
  if (val = 0) or (src = tcVariable) or (num = 0) then Exit;
end;

function TSSHSpirit.SetVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSSHSpirit.SetWatch(aTime: string): boolean;
begin
  Result := Open;
  if aTime = '' then Exit;
end;

function TSSHSpirit.SetWatchHHMM(aHrs, aMins: integer): boolean;
begin
  Result := Open;
  if (aHrs = 0) or (aMins = 0) then Exit;
end;

function TSSHSpirit.SgnVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSSHSpirit.StartTask(aTask: integer): boolean;
begin
  Result := Open;
  if aTask > 0 then Exit;
end;

function TSSHSpirit.StopAllTasks: boolean;
begin
  Result := DCStopProgram;
end;

function TSSHSpirit.StopTask(aTask: integer): boolean;
begin
  Result := False;
end;

function TSSHSpirit.SubVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSSHSpirit.SumVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSSHSpirit.TowerExists: boolean;
begin
  Result := Open;
end;

function TSSHSpirit.TransmitPower(aLevel: TTransmitLevel): boolean;
begin
  Result := Open;
  if aLevel = tlNear then Exit;
end;

function TSSHSpirit.UnlockBrick: string;
begin
  Open;
  Result := '';
end;

function TSSHSpirit.UnlockFirmware: boolean;
begin
  Result := Open;
end;

function TSSHSpirit.UploadDatalog(bVerbose: boolean): TStrings;
begin
  Open;
  Result := fDataLog;
  if bVerbose then Exit;
end;

function TSSHSpirit.UploadPartialDatalog(aFrom, aSize: integer): TStrings;
begin
  Open;
  Result := fDataLog;
  if aFrom = 0 then Exit;
  if aSize = 0 then Exit;
end;

function TSSHSpirit.Version(var rom, ram: Cardinal): boolean;
begin
  Result := False;
end;

function TSSHSpirit.ViewSourceValue(prec, src, value: integer): boolean;
begin
  Result := Open;
  if (prec = 0) or (src = 0) or (value = 0) then Exit;
end;

function TSSHSpirit.InitializeResourceNames : boolean;
begin
  Result := False;
end;

function TSSHSpirit.SCFreeMemory: integer;
begin
  Result  := 0;
end;

function TSSHSpirit.SCRenameFile(const old, new: string; const chkResponse: boolean): boolean;
begin
  Result := False;
end;

function TSSHSpirit.DCGetVMState(var state: byte; var clump : byte; var pc : word): boolean;
begin
  Result := False;
end;

function TSSHSpirit.DCSetVMStateEx(var state, clump: byte; var pc: word): boolean;
begin
  Result := False;
end;

function TSSHSpirit.DCSetVMState(const state: byte): boolean;
begin
  Result := False;
end;

function TSSHSpirit.DCGetPropDebugging(var debugging : boolean; var pauseClump: byte;
  var pausePC: Word): boolean;
begin
  Result := False;
end;

function TSSHSpirit.DCSetPropDebugging(const debugging : boolean; const pauseClump: byte;
  const pausePC: Word): boolean;
begin
  Result := False;
end;

function TSSHSpirit.UpdateResourceNames : boolean;
begin
  Result := False;
end;

function TSSHSpirit.GetPortName: string;
begin
  Result := '\\.\'+fPort;
end;

procedure TSSHSpirit.FlushReceiveBuffer;
var
  Data : TJCHBytes;
begin
  if IsOpen then
  begin
    DoSerialFlushRead(fSerialHandle, 50, Data);
  end;
end;

procedure TSSHSpirit.SendRawData(Data: array of byte);
var
  len : integer;
begin
  if IsOpen then
  begin
    len := Length(Data);
    DoSerialWrite(fSerialHandle, Data, len);
  end;
end;

function TSSHSpirit.DoSerialWrite(Handle: THandle; Data : array of byte; Count: LongInt) : LongInt;
begin
  Result := SerialWrite(Handle, @(Data[0]), Count);
  if Result = Count then
    DoDataSend(Data);
end;

function TSSHSpirit.DoSerialWrite(Handle: THandle; Data: string; Count: LongInt): LongInt;
begin
  Result := SerialWrite(Handle, PChar(Data), Count);
  if Result = Count then
    DoDataSend(Data);
end;

function TSSHSpirit.DoSerialFlushRead(Handle: THandle; delay: Integer; var Data: TJCHBytes): boolean;
begin
  SetLength(Data, 0);
  Result := SerialFlushRead(Handle, delay, Data);
  DoDataReceive(Data);
end;

function TSSHSpirit.DoSerialFlushToChar(Handle: THandle; delay: Integer;
  ch: Char; var Data: TJCHBytes): LongInt;
begin
  SetLength(Data, 0);
  Result := SerialFlushToChar(Handle, delay, ch, Data);
  if Result > 0 then
    DoDataReceive(Data);
end;

{$IFDEF FPC}
{$HINTS ON}
{$ENDIF}

end.