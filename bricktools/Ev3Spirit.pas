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
 * Portions created by John Hansen are Copyright (C) 2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit Ev3Spirit;

interface

uses
  Classes, SysUtils, rcx_cmd, uSpirit, uNXTConstants, FantomDefs, uCompCommon;

type
  TEv3Spirit = class(TBrickComm)
  private
    fSerialHandle : THandle;
    dcResponse : array [0..1024] of byte;
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
    function NXTStartProgram(const filename : string) : boolean; override;
    function NXTStopProgram : boolean; override;
    function NXTPlaySoundFile(const filename : string; bLoop : boolean) : boolean; override;
    function GetNXTOutputState(const aPort : byte; var power : integer;
      var mode, regmode : byte; var turnratio : integer;
      var runstate : byte; var tacholimit : cardinal; var tachocount,
      blocktachocount, rotationcount : longint) : boolean; override;
    function SetNXTOutputState(const aPort : byte; const power : integer;
      const mode, regmode : byte; const turnratio : integer;
      const runstate : byte; const tacholimit : cardinal) : boolean; override;
    function GetNXTInputValues(const aPort : byte; var valid, calibrated : boolean;
      var stype, smode : byte; var raw, normalized : word;
      var scaled, calvalue : smallint) : boolean; override;
    function SetNXTInputMode(const aPort, stype, smode : byte) : boolean; override;
    function NXTResetInputScaledValue(const aPort : byte) : boolean; override;
    function NXTResetOutputPosition(const aPort : byte; const Relative : boolean) : boolean; override;
    function NXTMessageWrite(const inbox : byte; const msg : string) : boolean; override;
    function NXTKeepAlive(var time : cardinal; const chkResponse : boolean = true) : boolean; override;
    function NXTLSGetStatus(aPort : byte; var bytesReady : byte; var lsstate : byte) : boolean; override;
    function NXTGetCurrentProgramName(var name : string) : boolean; override;
    function NXTGetButtonState(const idx : byte; const reset : boolean;
      var pressed : boolean; var count : byte) : boolean; override;
    function NXTMessageRead(const remote, local : byte; const remove : boolean; var Msg : NXTMessage) : boolean; override;
    function NXTSetPropDebugging(const debugging : boolean; const pauseClump : byte; const pausePC : Word) : boolean; override;
    function NXTGetPropDebugging(var debugging : boolean; var pauseClump : byte; var pausePC : Word) : boolean; override;
    function NXTSetVMState(const state : byte) : boolean; override;
    function NXTSetVMStateEx(var state : byte; var clump : byte; var pc : word) : boolean; override;
    function NXTGetVMState(var state : byte; var clump : byte; var pc : word) : boolean; override;
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
    function NXTFirmwareVersion : word; override;
    function NXTInstalledFirmware : TInstalledFirmware; override;
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
    function NXTFindFirstModule(var ModName : string; var Handle : FantomHandle;
      var ModID, ModSize : Cardinal; var IOMapSize : Word) : boolean; override;
    function NXTFindNextModule(var Handle : FantomHandle; var ModName : string;
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
    function NXTInitializeResourceNames : boolean; override;
    function NXTUpdateResourceNames : boolean; override;
  end;

implementation

uses
{$IFNDEF FPC}
  Windows,
{$ENDIF}
  rcx_constants, Contnrs, Math, uCommonUtils, uUtilities, uDebugLogging,
  hidapi, uCasperDevice;

procedure DoBeep(aFreq, aDur : cardinal);
begin
{$IFNDEF FPC}
  Beep(aFreq, aDur);
{$ELSE}
  if (aFreq > 0) and (aDur > 0) then
    Beep;
{$ENDIF}
end;

{ TEv3Spirit }

constructor TEv3Spirit.Create(aType: byte; const aPort: string);
begin
  inherited Create(aType, aPort);
  fSerialHandle := INVALID_HANDLE_VALUE;
end;

destructor TEv3Spirit.Destroy;
begin
  inherited Destroy;
end;

function TEv3Spirit.BatteryLevel: integer;
begin
  Result := -1;
  if IsOpen then
  begin
  end;
end;

function TEv3Spirit.Shutdown: boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.MotorsOn(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TEv3Spirit.MotorsOff(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TEv3Spirit.MotorsFloat(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TEv3Spirit.SetFwd(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TEv3Spirit.SetRwd(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TEv3Spirit.SwitchDirection(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TEv3Spirit.SetMotorPower(aMotorList: Byte; aSrc, aNum: integer): boolean;
begin
  Result := False;
end;

function TEv3Spirit.PlayTone(aFreq, aTime: word): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  DoBeep(aFreq, aTime);
end;

function TEv3Spirit.SetSensorType(aNum, aType: integer): boolean;
begin
  Result := False;
end;

function TEv3Spirit.SetSensorMode(aNum, aMode, aSlope: integer): boolean;
begin
  Result := False;
end;

function TEv3Spirit.ClearSensorValue(aNum: integer): boolean;
begin
  Result := False;
end;

function TEv3Spirit.Close: boolean;
begin
  Result := inherited Close;
//  SerialClose(fSerialHandle);
  fActive := False;
  fSerialHandle := INVALID_HANDLE_VALUE;
end;

function TEv3Spirit.Open: boolean;
begin
  DebugLog('TEv3Spirit.Open: Checking whether the connection is already open');
  Result := IsOpen;
  if not HidAPILoaded then Exit;
  if not Result then begin
    DebugLog('TEv3Spirit.Open: IsOpen returned FALSE');
    
    Result := fActive;
  end;
end;

function TEv3Spirit.ClearMemory: boolean;
begin
  Result := False;
end;

function TEv3Spirit.Sleep(aVal: integer): boolean;
begin
  Result := Open;
end;

function TEv3Spirit.GetInputValue(aIn : integer) : integer;
begin
  Result := -1;
  if Open then
  begin
  end;
end;

procedure TEv3Spirit.SetPort(const Value: string);
begin
  inherited SetPort(Value);
end;

function TEv3Spirit.DownloadFirmware(aFile: string; bFast : Boolean;
  bComp : Boolean; bUnlock : boolean): boolean;
begin
  Result := False;
end;

function TEv3Spirit.Ping: boolean;
begin
  Result := Open;
  if not Result then Exit;
  // send something and check for echo?
end;

function TEv3Spirit.MuteSound: boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.UnmuteSound: boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.GetIsOpen: boolean;
begin
  Result := inherited GetIsOpen;
end;

function TEv3Spirit.NXTStartProgram(const filename: string): boolean;
begin
  Result := StartTask(0);
end;

function TEv3Spirit.NXTStopProgram: boolean;
begin
  Result := Open;
  if not Result then Exit;
end;

function TEv3Spirit.NXTPlaySoundFile(const filename: string; bLoop: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.GetNXTOutputState(const aPort: byte; var power: integer;
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

function TEv3Spirit.SetNXTOutputState(const aPort: byte;
  const power: integer; const mode, regmode: byte;
  const turnratio: integer; const runstate: byte;
  const tacholimit: cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.GetNXTInputValues(const aPort: byte; var valid,
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

function TEv3Spirit.SetNXTInputMode(const aPort, stype, smode: byte): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTResetInputScaledValue(const aPort: byte): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTResetOutputPosition(const aPort: byte;
  const Relative: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTMessageWrite(const inbox: byte; const msg: string): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTKeepAlive(var time: cardinal; const chkResponse : boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTLSGetStatus(aPort : byte; var bytesReady: byte; var lsstate : byte): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.GetLSBlock(aPort: byte): NXTLSBlock;
begin
  Result.RXCount := 0;
end;

procedure TEv3Spirit.SetLSBlock(aPort: byte; const Value: NXTLSBlock);
begin
  if aPort = 0 then Exit;
end;

function TEv3Spirit.NXTGetCurrentProgramName(var name: string): boolean;
begin
  Result := IsOpen;
  name := '';
end;

function TEv3Spirit.NXTGetButtonState(const idx: byte; const reset: boolean;
  var pressed: boolean; var count: byte): boolean;
begin
  Result := IsOpen;
  pressed := False;
  count := 0;
end;

function TEv3Spirit.NXTMessageRead(const remote, local: byte;
  const remove: boolean; var Msg: NXTMessage): boolean;
begin
  Msg.Inbox := 0;
  Msg.Size  := 0;
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTOpenRead(const filename: string; var handle: FantomHandle;
  var size: cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  handle := 0;
  size := 0;
end;

function TEv3Spirit.NXTOpenReadLinear(const filename: string;
  var handle: FantomHandle; var size: cardinal): boolean;
begin
  Result := NXTOpenRead(filename, handle, size);
end;

function TEv3Spirit.NXTOpenAppendData(const filename: string;
  var size: cardinal; var handle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTOpenWrite(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTOpenWriteData(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTOpenWriteLinear(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTRead(var handle: FantomHandle; var count: word;
  var buffer: NXTDataBuffer): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTWrite(var handle: FantomHandle; const buffer: NXTDataBuffer;
  var count: word; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTCloseFile(var handle: FantomHandle; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTDeleteFile(var filename: string; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTFindFirstFile(var filename: string;
  var IterHandle: FantomHandle; var filesize, availsize : cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTFindNextFile(var IterHandle: FantomHandle; var filename: string;
  var filesize, availsize : cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTFindClose(var IterHandle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTGetVersions(var protmin, protmaj, firmmin, firmmaj : byte): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  protmin := 0;
  protmaj := 0;
  firmmin := 0;
  firmmaj := 0;
end;

function TEv3Spirit.NXTFirmwareVersion : word;
begin
  Result := 128;
end;

function TEv3Spirit.NXTInstalledFirmware : TInstalledFirmware;
begin
  result := ifEnhanced;
end;

function TEv3Spirit.NXTCloseModuleHandle(var handle: FantomHandle; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTBootCommand(const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTSetBrickName(const name: string; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTGetDeviceInfo(var name: string;
  var BTAddress : String; var BTSignal : Cardinal; var memFree : Cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTDeleteUserFlash(const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTBTFactoryReset(const chkResponse: boolean): boolean;
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

function TEv3Spirit.NXTUploadFile(const filename: string; const dir : string): boolean;
begin
  Result := False;
end;

function TEv3Spirit.NXTUploadFileToStream(const filename: string; aStream: TStream): boolean;
begin
  Result := False;
end;

function TEv3Spirit.NXTListFiles(const searchPattern: string; Files: TStrings): boolean;
begin
  Result := False;
  Files.Clear;
end;

function TEv3Spirit.NXTListModules(const searchPattern: string;  Modules: TStrings): boolean;
begin
  Result := False;
  Modules.Clear;
end;

function TEv3Spirit.NXTListBricks(Bricks: TStrings): boolean;
begin
  Result := False;
  Bricks.Clear;
end;

function TEv3Spirit.NXTDownloadFile(const filename: string; const filetype: TNXTFileType): boolean;
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
      Result := NXTDownloadStream(MS, filename, filetype);
    finally
      MS.Free;
    end;
  end;
end;

function TEv3Spirit.NXTDownloadStream(aStream: TStream; const dest : string;
  const filetype: TNXTFileType): boolean;
//var
//  b1, b2, b3 : byte;
//  SL : TStringList;
//  i, len : integer;
//  tmp : string;
//  Data : TJCHBytes;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.NXTPollCommandLen(const bufNum : byte; var count: byte): boolean;
begin
  Result := False;
end;

function TEv3Spirit.NXTPollCommand(const bufNum: byte; var count: byte;
  var buffer: NXTDataBuffer): boolean;
begin
  Result := False;
end;

function TEv3Spirit.NXTWriteIOMap(var ModID: Cardinal;
  const Offset: Word; var count: Word; const buffer: NXTDataBuffer;
  chkResponse : Boolean): boolean;
begin
  Result := False;
end;

function TEv3Spirit.NXTReadIOMap(var ModID: Cardinal;
  const Offset: Word; var Count: Word; var buffer: NXTDataBuffer): boolean;
begin
  Result := False;
end;

function TEv3Spirit.NXTFindNextModule(var Handle: FantomHandle;
  var ModName: string; var ModID, ModSize: Cardinal;
  var IOMapSize: Word): boolean;
begin
  Result := False;
end;

function TEv3Spirit.NXTFindFirstModule(var ModName: string; var Handle: FantomHandle;
  var ModID, ModSize: Cardinal; var IOMapSize: Word): boolean;
begin
  Result := False;
end;

function TEv3Spirit.dcBuffer: PByte;
begin
  Result := @dcResponse[0];
end;

function TEv3Spirit.GetReplyByte(index: integer): Byte;
const
  DCReplyOffset = 2;
begin
  Result := dcResponse[index + DCReplyOffset];
end;

function TEv3Spirit.GetReplyCardinal(index: integer): Cardinal;
begin
  Result := BytesToCardinal(GetReplyByte(index),
                            GetReplyByte(index+1),
                            GetReplyByte(index+2),
                            GetReplyByte(index+3));
end;

function TEv3Spirit.GetReplyWord(index: integer): Word;
begin
  Result := Word(BytesToCardinal(GetReplyByte(index), GetReplyByte(index+1)));
end;

function TEv3Spirit.GetDownloadWaitTime: Integer;
begin
  Result := 0;
end;

function TEv3Spirit.GetEEPROM(addr: Byte): Byte;
begin
  Result := addr;
end;

function TEv3Spirit.GetEEPROMBlock(idx: Integer): EEPROMBlock;
begin
  Result.Data[idx] := 0;
end;

function TEv3Spirit.GetLinkLog: string;
begin
  Result := '';
end;

function TEv3Spirit.GetOmitHeader: Boolean;
begin
  Result := False;
end;

function TEv3Spirit.GetQuiet: Boolean;
begin
  Result := False;
end;

function TEv3Spirit.GetRCXFirmwareChunkSize: Integer;
begin
  Result := 200;
end;

function TEv3Spirit.GetRxTimeout: Word;
begin
  Result := 400;
end;

procedure TEv3Spirit.SetDownloadWaitTime(const Value: Integer);
begin
// do nothing
  if Value = 0 then Exit;
end;

procedure TEv3Spirit.SetEEPROM(addr: Byte; const Value: Byte);
begin
// do nothing
  if Value = 0 then Exit;
  if addr = 0 then Exit;
end;

procedure TEv3Spirit.SetOmitHeader(const Value: Boolean);
begin
// do nothing
  if Value then Exit;
end;

procedure TEv3Spirit.SetQuiet(const Value: Boolean);
begin
// do nothing
  if Value then Exit;
end;

procedure TEv3Spirit.SetRCXFirmwareChunkSize(const Value: Integer);
begin
// do nothing
  if Value = 0 then Exit;
end;

procedure TEv3Spirit.SetRxTimeout(const Value: Word);
begin
// do nothing
  if Value = 0 then Exit;
end;

function TEv3Spirit.AbsVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TEv3Spirit.AndVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TEv3Spirit.BrickAlive: boolean;
begin
  Result := Open;
end;

function TEv3Spirit.CalibrateEvent(enum, upper, lower,
  hysteresis: integer): boolean;
begin
  Result := Open;
  if enum = 0 then Exit;
  if upper = 0 then Exit;
  if lower = 0 then Exit;
  if hysteresis = 0 then Exit;
end;

function TEv3Spirit.CalibrateLightSensor: boolean;
begin
  Result := Open;
end;

function TEv3Spirit.ClearAllEvents: boolean;
begin
  Result := Open;
end;

function TEv3Spirit.ClearCounter(num: TCounterNumber): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
end;

function TEv3Spirit.ClearSound: boolean;
begin
  Result := Open;
end;

function TEv3Spirit.ClearTachoCounter(aMotorList: Byte): boolean;
begin
  Result := Open;
  if aMotorList = 0 then Exit;
end;

function TEv3Spirit.ClearTimer(aNum: integer): boolean;
begin
  Result := Open;
  if aNum = 0 then Exit;
end;

function TEv3Spirit.DatalogNext(aSrc, aNum: integer): boolean;
begin
  Result := False;
  if aSrc = 0 then Exit;
  if aNum = 0 then Exit;
end;

function TEv3Spirit.DecCounter(num: TCounterNumber): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
end;

function TEv3Spirit.DeleteAllSubs: boolean;
begin
  Result := False;
end;

function TEv3Spirit.DeleteAllTasks: boolean;
begin
  Result := False;
end;

function TEv3Spirit.DeleteSub(aSub: integer): boolean;
begin
  Result := False;
end;

function TEv3Spirit.DeleteTask(aTask: integer): boolean;
begin
  Result := False;
  if aTask = 0 then Exit;
end;

function TEv3Spirit.DivVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TEv3Spirit.DownloadMemoryMap: TStrings;
begin
  Result := fMemMap;
end;

function TEv3Spirit.Drive(aLeft, aRight: integer): boolean;
begin
  Result := Open;
  if aLeft = 0 then Exit;
  if aRight = 0 then Exit;
end;

function TEv3Spirit.GetCounterValue(aNum: integer): integer;
begin
  Result := Poll(kRCX_CounterType, aNum);
end;

function TEv3Spirit.GetMessageValue(aNum: integer): integer;
begin
  Result := Poll(kRCX_MessageType, aNum);
end;

function TEv3Spirit.GetOutputStatus(aOut: integer): integer;
begin
  Result := 0;
  if aOut = 0 then Exit;
end;

function TEv3Spirit.GetTimerValue(aNum: integer): integer;
begin
  Result := Poll(kRCX_TimerType, aNum);
end;

function TEv3Spirit.GetVariableValue(aVar: integer): variant;
begin
  Result := Poll(kRCX_VariableType, aVar);
end;

function TEv3Spirit.IncCounter(num: TCounterNumber): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
end;

function TEv3Spirit.MonitorIR(aSeconds: integer): TStrings;
begin
  Result := fMemData;
  if aSeconds = 0 then Exit;
end;

function TEv3Spirit.MulVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TEv3Spirit.OnWait(aMotorList: Byte; aNum: integer; aTime: Byte): boolean;
begin
  Result := Open;
  if aMotorList = 0 then Exit;
  if aNum = 0 then Exit;
  if aTime = 0 then Exit;
end;

function TEv3Spirit.OnWaitDifferent(aMotorList: Byte; aNum0, aNum1,
  aNum2: integer; aTime: Byte): boolean;
begin
  Result := Open;
  if aMotorList = 0 then Exit;
  if aNum0 = 0 then Exit;
  if aNum1 = 0 then Exit;
  if aNum2 = 0 then Exit;
  if aTime = 0 then Exit;
end;

function TEv3Spirit.OrVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TEv3Spirit.PlaySystemSound(aSnd: byte): boolean;
begin
  Result := False;
end;

function TEv3Spirit.Poll(aSrc, aNum: integer): variant;
begin
  Result := 0;
end;

function TEv3Spirit.PollEEPROM(block: Integer): TStrings;
begin
  Result := fMemData;
  fMemData.Clear;
end;

function TEv3Spirit.PollMemory(address, size: Integer): TStrings;
begin
  Result := fMemData;
end;

function TEv3Spirit.PowerDownTime(aTime: integer): boolean;
begin
  Result := Open;
  if not Result then Exit;
end;

function TEv3Spirit.PrepareBrick: boolean;
begin
  Result := Open;
end;

function TEv3Spirit.Scout(bPower: boolean): boolean;
begin
  Result := Open and bPower;
end;

function TEv3Spirit.ScoutNum(aVal: integer): boolean;
begin
  Result := Open;
  if aVal = 0 then Exit;
end;

function TEv3Spirit.ScoutRules(motion: TScoutMotion; touch: TScoutTouch;
  light: TScoutLight; time: TScoutScale; fx: TScoutEffects): boolean;
begin
  Result := Open;
  if motion = smNone then Exit;
  if touch = stIgnore then Exit;
  if light = slIgnore then Exit;
  if time = ssShort then Exit;
  if fx = seNone then Exit;
end;

function TEv3Spirit.ScoutSound(bSoundEnable, bSoundOff: boolean;
  aNum: TSoundSetNumber): boolean;
begin
  Result := Open and bSoundEnable and bSoundOff;
  if aNum = 0 then Exit;
end;

function TEv3Spirit.SelectDisplay(aSrc, aNumber: integer): boolean;
begin
  Result := False;
  if (aSrc = 0) or (aNumber = 0) then Exit;
end;

function TEv3Spirit.SelectProgram(aProg: integer): boolean;
//var
//  Data : TJCHBytes;
begin
  Result := Open;
  if Result then
  begin
  end;
end;

function TEv3Spirit.SendMessage(aMsg: integer): boolean;
begin
  Result := NXTMessageWrite(0, IntToStr(aMsg));
end;

function TEv3Spirit.SendRawCommand(aCmd: string; bRetry: boolean): string;
begin
  Result := '';
  if (aCmd = '') or bRetry then Exit;
end;

function TEv3Spirit.SendRemoteStr(aEvent: string; aRepeat: integer): boolean;
begin
  Result := Open;
  if (aEvent = '') or (aRepeat = 0) then Exit;
end;

function TEv3Spirit.SendRemote(aEvent: Word; aRepeat: integer): boolean;
begin
  Result := Open;
  if (aEvent = 0) or (aRepeat = 0) then Exit;
end;

function TEv3Spirit.SendUARTData(start, size: integer): boolean;
begin
  Result := Open;
  if start = 0 then Exit;
  if size = 0 then Exit;
end;

function TEv3Spirit.SendVLL(aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if aSrc = 0 then Exit;
  if aNum = 0 then Exit;
end;

function TEv3Spirit.SetCounterLimit(num: TCounterNumber; src: TTCSource;
  val: integer): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
  if src = tcVariable then Exit;
  if val = 0 then Exit;
end;

function TEv3Spirit.SetDatalog(aSize: integer): boolean;
begin
  Result := False;
  if aSize = 0 then Exit;
end;

function TEv3Spirit.SetEvent(enum, snum, etype: integer): boolean;
begin
  Result := Open;
  if (enum = 0) or (snum = 0) or (etype = 0) then Exit;
end;

function TEv3Spirit.SetFeedback(src, val: integer): boolean;
begin
  Result := Open;
  if (src = 0) or (val = 0) then Exit;
end;

function TEv3Spirit.SetGlobalDirection(motors: TMotorsNum; action: TGlobalDirAction): boolean;
begin
  Result := Open;
  if (motors = 0) or (action = gdaBackward) then Exit;
end;

function TEv3Spirit.SetGlobalOutput(motors: TMotorsNum; action: TGlobalOutAction): boolean;
begin
  Result := Open;
  if (motors = 0) or (action = goaFloat) then Exit;
end;

function TEv3Spirit.SetLight(bOn: boolean): boolean;
begin
  Result := Open and bOn;
end;

function TEv3Spirit.SetLightSensorBlinkTime(src: TLSSource; val: TBlinkTimeValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TEv3Spirit.SetLightSensorHysteresis(src: TLSSource; val: TThresholdValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TEv3Spirit.SetLightSensorLowerThreshold(src: TLSSource; val: TThresholdValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TEv3Spirit.SetLightSensorUpperThreshold(src: TLSSource; val: TThresholdValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TEv3Spirit.SetMaxPower(motors: TMotorsNum; src, num: integer): boolean;
begin
  Result := Open;
  if (motors = 0) or (src = 0) or (num = 0) then Exit;
end;

function TEv3Spirit.SetSourceValue(aDestSrc, aDestVal, aOrigSrc: Byte; aOrigVal: Smallint): boolean;
begin
  Result := Open;
  if (aDestSrc = 0) or (aDestVal = 0) or (aOrigSrc = 0) or (aOrigVal = 0) then Exit;
end;

function TEv3Spirit.SetTimerLimit(num: TTimerNumber; src: TTCSource; val: integer): boolean;
begin
  Result := Open;
  if (val = 0) or (src = tcVariable) or (num = 0) then Exit;
end;

function TEv3Spirit.SetVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TEv3Spirit.SetWatch(aTime: string): boolean;
begin
  Result := Open;
  if aTime = '' then Exit;
end;

function TEv3Spirit.SetWatchHHMM(aHrs, aMins: integer): boolean;
begin
  Result := Open;
  if (aHrs = 0) or (aMins = 0) then Exit;
end;

function TEv3Spirit.SgnVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TEv3Spirit.StartTask(aTask: integer): boolean;
//var
//  Data : TJCHBytes;
begin
  Result := Open;
  if Result then
  begin
  end;
end;

function TEv3Spirit.StopAllTasks: boolean;
begin
  Result := NXTStopProgram;
end;

function TEv3Spirit.StopTask(aTask: integer): boolean;
begin
  Result := False;
end;

function TEv3Spirit.SubVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TEv3Spirit.SumVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TEv3Spirit.TowerExists: boolean;
//var
//  Buf : PChar;
//  b1 : Byte;
begin
  Result := Open;
//  if Result then
//    Result := MonitorMode;
end;

function TEv3Spirit.TransmitPower(aLevel: TTransmitLevel): boolean;
begin
  Result := Open;
  if aLevel = tlNear then Exit;
end;

function TEv3Spirit.UnlockBrick: string;
begin
  Open;
  Result := '';
end;

function TEv3Spirit.UnlockFirmware: boolean;
begin
  Result := Open;
end;

function TEv3Spirit.UploadDatalog(bVerbose: boolean): TStrings;
begin
  Open;
  Result := fDataLog;
  if bVerbose then Exit;
end;

function TEv3Spirit.UploadPartialDatalog(aFrom, aSize: integer): TStrings;
begin
  Open;
  Result := fDataLog;
  if aFrom = 0 then Exit;
  if aSize = 0 then Exit;
end;

function TEv3Spirit.Version(var rom, ram: Cardinal): boolean;
begin
  Result := False;
end;

function TEv3Spirit.ViewSourceValue(prec, src, value: integer): boolean;
begin
  Result := Open;
  if (prec = 0) or (src = 0) or (value = 0) then Exit;
end;

function TEv3Spirit.NXTInitializeResourceNames : boolean;
begin
  Result := False;
end;

function TEv3Spirit.NXTFreeMemory: integer;
begin
  Result  := 0;
end;

function TEv3Spirit.NXTRenameFile(const old, new: string; const chkResponse: boolean): boolean;
begin
  Result := False;
end;

function TEv3Spirit.NXTGetVMState(var state: byte; var clump : byte; var pc : word): boolean;
begin
  Result := False;
end;

function TEv3Spirit.NXTSetVMStateEx(var state, clump: byte; var pc: word): boolean;
begin
  Result := False;
end;

function TEv3Spirit.NXTSetVMState(const state: byte): boolean;
begin
  Result := False;
end;

function TEv3Spirit.NXTGetPropDebugging(var debugging : boolean; var pauseClump: byte;
  var pausePC: Word): boolean;
begin
  Result := False;
end;

function TEv3Spirit.NXTSetPropDebugging(const debugging : boolean; const pauseClump: byte;
  const pausePC: Word): boolean;
begin
  Result := False;
end;

function TEv3Spirit.NXTUpdateResourceNames : boolean;
begin
  Result := False;
end;

function TEv3Spirit.GetPortName: string;
begin
  Result := '\\.\'+fPort;
end;

procedure TEv3Spirit.FlushReceiveBuffer;
//var
//  Data : TJCHBytes;
begin
  if IsOpen then
  begin
  end;
end;

procedure TEv3Spirit.SendRawData(Data: array of byte);
//var
//  len : integer;
begin
  if IsOpen then
  begin
//    len := Length(Data);
  end;
end;

end.
