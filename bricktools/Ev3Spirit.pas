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
 * Portions created by John Hansen are Copyright (C) 2012-2103 John Hansen.
 * All Rights Reserved.
 *
 *)
unit Ev3Spirit;

interface

uses
  Classes, SysUtils, rcx_cmd, uSpirit, uNXTConstants, FantomDefs, uCompCommon,
  uEV3Transport, rcx_constants;

type
  TEv3Spirit = class(TBrickComm)
  private
    fResPort : string;
    fBRSerialNumber : string;
    fBRExpectedName : string;
    fBRIPAddress : string;
    fBRTransportType : TTransportType;
    fResourceNames : TStrings;
    fSnapshotMS : TMemoryStream;
    fSnapshotBaseOffset : integer;
    procedure LookupResourceName;
    procedure UpdateBrickRestrictions;
    function UploadFromDeviceLowLevel(const DirList: boolean;
      const path: string; data: TStream): boolean;
    function ListFilesAndFolders(const searchPattern : string; aList : TStrings) : boolean;
    function ConvertToAbsoluteBrickPath(const filename: string): string;
    function EV3ButtonPressOrRelease(const buffer: PBRDataBuffer): boolean;
    function EV3ReadScreenHack(Offset: Word; var Count: Word;
      var buffer: PBRDataBuffer): boolean;
    function PrettyPathToBrickPath(prettyPath: string;
      bOnSD: boolean): string;
  protected
    function  GetCanCaptureScreen: boolean; override;
    function  GetFullPortName: string; override;
    function  GetNicePortName: string; override;
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
    function  GetTransport : IEV3Transport;
  protected
    fSnapshotFolder : string;
    fSequenceID : Word;
    fAvailableTransports : TInterfaceList;
    fActiveTransport : IEV3Transport;
    procedure RefreshAvailableTransports;
    procedure FreeAllTransports;
    function SuitableTransport(Tport: IEV3Transport): boolean;
    function NextSequenceID : Word;
    function GetEV3StorageStatus(var ramTotal : Cardinal; var ramFree : Cardinal;
      var sdPresent : Byte; var sdTotal : Cardinal; var sdFree : Cardinal;
      var usbPresent : Byte; var usbTotal : Cardinal; var usbFree : Cardinal) : boolean;
    procedure SetupSnapshotTool;
    property  Transport : IEV3Transport read GetTransport;
  public
    constructor Create(aType : byte = 0; const aPort : string = ''); override;
    destructor Destroy; override;

    function  Open : boolean; override;
    function  Close : boolean; override;

    function TransportTypes : TTransportTypes; override;

    procedure FlushReceiveBuffer; override;
    procedure SendRawData(Data : array of byte); override;

    // PBrick sound commands
    function PlayTone(aFreq, aTime : word) : boolean; override;
    function PlaySystemSound(aSnd : byte) : boolean; override;

    // PBrick output control commands
    function ControlMotors(aMotorList : Byte; Power : ShortInt;
      dir : TMotorDirection; state : TMotorState) : boolean; override;
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
    function VersionString : string; override;
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
    function CreateFolder(const foldername : string) : boolean; override;
    function DownloadFile(const filename : string; const filetype : TPBRFileType) : boolean; override;
    function DownloadStream(aStream : TStream; const dest : string; const filetype : TPBRFileType) : boolean; override;
    function UploadFile(const filename : string; const dir : string = '') : boolean; override;
    function UploadFileToStream(const filename : string; aStream : TStream) : boolean; override;
    function ListFiles(const searchPattern : string; Files : TStrings) : boolean; override;
    function ListModules(const searchPattern : string; Modules : TStrings) : boolean; override;
    function ListBricks(Bricks : TStrings) : boolean; override;
    function PlayDownloadCompletedSound : boolean; override;
  end;

implementation

uses
{$IFNDEF FPC}
  Windows,
{$ENDIF}
  Contnrs, Math, uCommonUtils, uUtilities, uDebugLogging,
  uEV3HIDTransport, uEV3TCPTransport, uEV3BTHTransport, uGlobals,
  uPBRMiscTypes, uPBRSimpleTypes;

const
  MaxFileDownloadBytes = 1000;
  MaxFileUploadBytes = 900;
  SNAPSHOT_DISABLED = 'DISABLED';
  MIN_RAMDISK_SNAPSHOT = 332;


procedure DoBeep(aFreq, aDur : cardinal);
begin
{$IFNDEF FPC}
  Beep(aFreq, aDur);
{$ELSE}
  if (aFreq > 0) and (aDur > 0) then
    Beep;
{$ENDIF}
end;

procedure DecodeOutputs(var bits : byte; var layer : byte);
const
  LAYER_MASK = $70;
  OUT_MASK = $0f;
begin
  layer := (bits and LAYER_MASK) shr 4;
  bits := bits and OUT_MASK;
end;

function InputGetDevice(port : byte; layer : byte) : byte;
begin
  Result := port + (layer * 4);
end;

procedure DecodePort(var port : byte; var layer : byte);
begin
  // port is greater than 16?
  layer := (port div 4) mod 4;
  if port >= 16 then
    port := 16 + (port mod 4)
  else
    port  := port mod 4;
end;

procedure DecodeInput(var port : byte; var layer : byte);
begin
  layer := port div 4;
  port  := port mod 4;
end;

procedure DecodeOutput(var port : byte; var layer : byte);
begin
  layer := port div 4;
  port  := port mod 4;
end;

{ TEv3Spirit }

constructor TEv3Spirit.Create(aType: byte; const aPort: string);
begin
  inherited Create(aType, aPort);
  fSnapshotMS := TMemoryStream.Create;
  fSnapshotFolder  := '';
  fBRSerialNumber  := '';
  fBRExpectedName  := '';
  fBRIPAddress     := '';
  fBRTransportType := ttAny;
  fBrickFolder := '../prjs/';
//  fBrickFolder := '../prjs/SD_Card/';
//  fBrickFolder := '/media/card/';
  fPowerScaleFactor := 14;
  fResPort := '';
  fResourceNames := TStringList.Create;
  fAvailableTransports := TInterfaceList.Create;
  RefreshAvailableTransports;
end;

destructor TEv3Spirit.Destroy;
begin
  FreeAllTransports;
  FreeAndNil(fAvailableTransports);
  FreeAndNil(fResourceNames);
  FreeAndNil(fSnapshotMS);
  inherited Destroy;
end;

function TEv3Spirit.BatteryLevel: integer;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
  voltage : single;
begin
  Result := -1;
  if not IsOpen then Exit;
  ms := TMemoryStream.Create;
  try
    TDirectCommandBuilder.StartCommand(ctDirectWithReply, 4, 0, ms);
    TDirectCommandBuilder.GetBrickBatteryVoltage(0, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 50, id) then
      begin
        DebugLog(rspData);
        if (rspData[0] = DIRECT_REPLY_OK) then
        begin
          Move(rspData[1], voltage, 4);
          DebugFmt('%f', [voltage]);
          Result := Trunc(voltage*1000);
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.Shutdown: boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

const
  MotorBits : array[0..3] of byte = (1, 2, 4, 8);

function TEv3Spirit.ControlMotors(aMotorList : Byte; Power: ShortInt;
  dir: TMotorDirection; state: TMotorState): boolean;
var
  ms : TMemoryStream;
  id : Word;
  layer : byte;
  i : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  ms := TMemoryStream.Create;
  try
    layer := 0;
    DecodeOutputs(aMotorList, layer);
    for i := 0 to 3 do
    begin
      if (MotorBits[i] and aMotorList) = MotorBits[i] then
      begin
        fMotorOn[i]      := state = msOn;
        fMotorPower[i]   := Power;
        fMotorForward[i] := dir = mdForward;
      end;
    end;
    TDirectCommandBuilder.StartCommand(ctDirectNoReply, 0, 0, ms);
    if state = msOn then
    begin
      // power scaled from 0..7 to 0..100
      if PowerScaleFactor <> 0 then
      begin
        if Power >= 7 then
          Power := 100
        else
          Power := Power * PowerScaleFactor;
      end;
      if dir = mdReverse then
        Power := Power * -1;
      TDirectCommandBuilder.OutputStart(layer, aMotorList, ms);
      TDirectCommandBuilder.OutputPower(layer, aMotorList, Power, ms);
    end
    else // state is Off or Float
    begin
      TDirectCommandBuilder.OutputStop(layer, aMotorList, state = msOff, ms);
    end;
    id := NextSequenceID;
    Result := Transport.SendStream(id, ms) = ms.Size;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.MotorsOn(aMotorList: Byte): boolean;
var
  ms : TMemoryStream;
  id : Word;
  layer : byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  ms := TMemoryStream.Create;
  try
    layer := 0;
    DecodeOutputs(aMotorList, layer);
    TDirectCommandBuilder.StartCommand(ctDirectNoReply, 0, 0, ms);
    TDirectCommandBuilder.OutputStart(layer, aMotorList, ms);
    id := NextSequenceID;
    Result := Transport.SendStream(id, ms) = ms.Size;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.MotorsOff(aMotorList: Byte): boolean;
var
  ms : TMemoryStream;
  id : Word;
  layer : byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  ms := TMemoryStream.Create;
  try
    layer := 0;
    DecodeOutputs(aMotorList, layer);
    TDirectCommandBuilder.StartCommand(ctDirectNoReply, 0, 0, ms);
    TDirectCommandBuilder.OutputStop(layer, aMotorList, true, ms);
    id := NextSequenceID;
    Result := Transport.SendStream(id, ms) = ms.Size;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.MotorsFloat(aMotorList: Byte): boolean;
var
  ms : TMemoryStream;
  id : Word;
  layer : byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  ms := TMemoryStream.Create;
  try
    layer := 0;
    DecodeOutputs(aMotorList, layer);
    TDirectCommandBuilder.StartCommand(ctDirectNoReply, 0, 0, ms);
    TDirectCommandBuilder.OutputStop(layer, aMotorList, false, ms);
    id := NextSequenceID;
    Result := Transport.SendStream(id, ms) = ms.Size;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.SetFwd(aMotorList: Byte): boolean;
var
  i : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  for i := 0 to 3 do
  begin
    if (MotorBits[i] and aMotorList) = MotorBits[i] then
    begin
      fMotorForward[i] := true;
    end;
  end;
end;

function TEv3Spirit.SetRwd(aMotorList: Byte): boolean;
var
  i : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  for i := 0 to 3 do
  begin
    if (MotorBits[i] and aMotorList) = MotorBits[i] then
    begin
      fMotorForward[i] := false;
    end;
  end;
end;

function TEv3Spirit.SwitchDirection(aMotorList: Byte): boolean;
var
  i : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  for i := 0 to 3 do
  begin
    if (MotorBits[i] and aMotorList) = MotorBits[i] then
    begin
      fMotorForward[i] := not fMotorForward[i];
    end;
  end;
end;

function TEv3Spirit.SetMotorPower(aMotorList: Byte; aSrc, aNum: integer): boolean;
var
  ms : TMemoryStream;
  id : Word;
  layer : byte;
  bFirst, bAllSame : boolean;
  i, power : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  if aSrc <> kRCX_ConstantType then
  begin
    Result := False;
    Exit;
  end
  else
  begin
    layer := 0;
    DecodeOutputs(aMotorList, layer);
    // power scaled from 0..7 to 0..100
    if PowerScaleFactor <> 0 then
    begin
      if aNum = 7 then
        aNum := 100
      else
        aNum := aNum * PowerScaleFactor;
    end;
    // are some false and some true?
    bAllSame := True;
    bFirst := fMotorForward[0];
    for i := 0 to 3 do
    begin
      if bFirst <> fMotorForward[i] then
      begin
        bAllSame := False;
        break;
      end;
    end;
    if not bAllSame then
    begin
      // send a command for each motor
      for i := 0 to 3 do
      begin
        if (MotorBits[i] and aMotorList) = MotorBits[i] then
        begin
          if not fMotorForward[i] then
            power := aNum * -1
          else
            power := aNum;
          ms := TMemoryStream.Create;
          try
            TDirectCommandBuilder.StartCommand(ctDirectNoReply, 0, 0, ms);
            TDirectCommandBuilder.OutputPower(layer, MotorBits[i], power, ms);
            id := NextSequenceID;
            Result := Transport.SendStream(id, ms) = ms.Size;
          finally
            ms.Free;
          end;
        end;
      end;
    end
    else
    begin
      if not bFirst then
        power := aNum * -1
      else
        power := aNum;
      ms := TMemoryStream.Create;
      try
        TDirectCommandBuilder.StartCommand(ctDirectNoReply, 0, 0, ms);
        TDirectCommandBuilder.OutputPower(layer, aMotorList, power, ms);
        id := NextSequenceID;
        Result := Transport.SendStream(id, ms) = ms.Size;
      finally
        ms.Free;
      end;
    end;
  end;
end;

function TEv3Spirit.PlayTone(aFreq, aTime: word): boolean;
var
  ms : TMemoryStream;
  id : Word;
begin
  Result := IsOpen;
  if not Result then Exit;
  if fSoundMuted then
  begin
    Result := False;
    Exit;
  end;
  ms := TMemoryStream.Create;
  try
    TDirectCommandBuilder.StartCommand(ctDirectNoReply, 0, 0, ms);
    TDirectCommandBuilder.PlayTone(100, aFreq, aTime, ms);
    id := NextSequenceID;
    Result := Transport.SendStream(id, ms) = ms.Size;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.SetSensorType(aNum, aType: integer): boolean;
var
  ms : TMemoryStream;
  id : Word;
  rspData : TEV3Data;
  layer, port, stype, smode : byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  Result := False;
  ms := TMemoryStream.Create;
  try
    port  := Byte(aNum);
    layer := 0;
    // this can handle both inputs and outputs
    DecodePort(port, layer);
    stype := aType;
    smode := Byte(MODE_KEEP);
    TDirectCommandBuilder.StartCommand(ctDirectWithReply, 1, 0, ms);
    TDirectCommandBuilder.InputRead(layer, TPortId(port), stype, smode, 0, 0, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 500, id) then
      begin
        DebugLog(rspData);
        if (rspData[0] = DIRECT_REPLY_OK) then
        begin
          Result := True;
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.SetSensorMode(aNum, aMode, aSlope: integer): boolean;
var
  ms : TMemoryStream;
  id : Word;
  rspData : TEV3Data;
  layer, port, stype, smode : byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  Result := False;
  ms := TMemoryStream.Create;
  try
    port  := Byte(aNum);
    layer := 0;
    // this can handle both inputs and outputs
    DecodePort(port, layer);
    stype := TYPE_KEEP;
    smode := Byte(aMode);
    TDirectCommandBuilder.StartCommand(ctDirectWithReply, 1, 0, ms);
    TDirectCommandBuilder.InputRead(layer, TPortId(port), stype, smode, 0, 0, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 500, id) then
      begin
        DebugLog(rspData);
        if (rspData[0] = DIRECT_REPLY_OK) then
        begin
          Result := True;
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.ClearSensorValue(aNum: integer): boolean;
var
  ms : TMemoryStream;
  id : Word;
  rspData : TEV3Data;
  layer, port : byte;
  data : TJCHBytes;
begin
  Result := IsOpen;
  if not Result then Exit;
  Result := False;
  ms := TMemoryStream.Create;
  try
    if aNum < 0 then
    begin
      // all ports (all layers?)
      TDirectCommandBuilder.StartCommand(ctDirectWithReply, 0, 0, ms);
      TDirectCommandBuilder.InputDeviceClearAll($FF, ms);
    end
    else if aNum >= 16 then
    begin
      // output port
      TDirectCommandBuilder.StartCommand(ctDirectWithReply, 0, 0, ms);
      TDirectCommandBuilder.OutputClearCount(0, Byte(1 shl (aNum-16)), ms);
    end
    else
    begin
      // input port
      port  := Byte(aNum);
      layer := 0;
      DecodeInput(port, layer);
      if fSensorType[aNum] = 32 then
      begin
        // for some reason there is special handling for the EV3 Gyro sensor
        SetLength(data, 1);
        data[0] := DEVCMD_RESET;
        TDirectCommandBuilder.StartCommand(ctDirectWithReply, 4, 0, ms);
        TDirectCommandBuilder.InputReadyRead(layer, TPortId(port), 32, 0, 1, 1, 0, ms);
        TDirectCommandBuilder.InputWrite(layer, TPortId(port), data, ms);
      end
      else
      begin
        TDirectCommandBuilder.StartCommand(ctDirectWithReply, 0, 0, ms);
        TDirectCommandBuilder.InputDeviceClearChanges(layer, TPortId(port), ms);
      end;
    end;
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 500, id) then
      begin
        DebugLog(rspData);
        if (rspData[0] = DIRECT_REPLY_OK) then
        begin
          Result := True;
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.Close: boolean;
begin
  Result := inherited Close;
  if IsOpen then
  begin
    fResPort   := ''; // clear this so that it gets looked up again when opening
    DebugLog('TFantomSpirit.Close: Closing our open connection');
    if Assigned(fActiveTransport) then
      fActiveTransport.Close;
    fActiveTransport := nil;
    fSnapshotFolder := '';
    fActive := False;
  end;
end;

function TEv3Spirit.Open: boolean;
begin
  DebugLog('TEv3Spirit.Open: Checking whether the connection is already open');
  Result := IsOpen;
  if not Result then begin
    // check whether we need to refresh our transport list or not
    if fAvailableTransports.Count = 1 then
      RefreshAvailableTransports;
    DebugLog('TEv3Spirit.Open: IsOpen returned FALSE');
    fSequenceID := 0;
    if fResPort = '' then
      LookupResourceName;
    if fResPort = '' then
      fResPort := fPort;
//    pName := AnsiUpperCase(fResPort);
//    bName := AnsiUpperCase(BluetoothName);
//    DebugFmt('TFantomSpirit.Open: pName = "%s"', [pName]);
//    DebugFmt('TFantomSpirit.Open: bName = "%s"', [bName]);
    fActive := Transport.Open;
    fSnapshotFolder := '';
    Result := fActive;
  end;
end;

function TEv3Spirit.TransportTypes: TTransportTypes;
begin
  Result := [ttUSB, ttBTH, ttTCP];
end;

function TEv3Spirit.ClearMemory: boolean;
begin
  Result := SCDeleteUserFlash(True);
end;

function TEv3Spirit.Sleep(aVal: integer): boolean;
begin
  Result := PowerDownTime(aVal);
end;

function TEv3Spirit.GetInputValue(aIn : integer) : integer;
var
  bOpen : boolean;
begin
  Result := -1;
  bopen := Open;
  if bOpen then
  begin
    Result := Poll(kRCX_InputValueType, aIn);
  end;
end;
(*
	TPortId = (
		pidNone,
		pidOutputFlag = 256,
		pidOutputA = 272,  // 16
		pidOutputB,        // 17
		pidOutputC,        // 18
		pidOutputD,        // 19
		pidAllOutputs = 287,
		pidInputFlag = 512,
		pidInputOne = 512,  // 0
		pidInputTwo,        // 1
		pidInputThree,      // 2
		pidInputFour,       // 3
		pidLayerMask = 16711680
	);
		private void GetLiveSensorValues()
		{
			lock (this.CasperDevice)
			{
				byte[] reply = new byte[2000];
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 32, 0, new byte[][]
				{
					DirectCommandBuilder.SensorRead(0, PortId.InputFlag, base.PortHardware[0], 0, true, 0),
					DirectCommandBuilder.SensorRead(0, PortId.InputTwo, base.PortHardware[1], 0, true, 4),
					DirectCommandBuilder.SensorRead(0, PortId.InputThree, base.PortHardware[2], 0, true, 8),
					DirectCommandBuilder.SensorRead(0, PortId.InputFour, base.PortHardware[3], 0, true, 12),
					DirectCommandBuilder.SensorRead(0, PortId.OutputA, base.PortHardware[4], 0, true, 16),
					DirectCommandBuilder.SensorRead(0, PortId.OutputB, base.PortHardware[5], 0, true, 20),
					DirectCommandBuilder.SensorRead(0, PortId.OutputC, base.PortHardware[6], 0, true, 24),
					DirectCommandBuilder.SensorRead(0, PortId.OutputD, base.PortHardware[7], 0, true, 28)
				});
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok)
				{
					if (reply[0] == 2)
					{
						for (int i = 0; i < base.PortHardware.Count<byte>(); i++)
						{
							PingBuffer.AddResponse(new LiveSensorResponse
							{
								SensorInfo = new HardwarePortValue
								{
									PortId = this._portIDs[i],
									Value = (double)BitConverter.ToSingle(reply, i * 4 + 1)
								}
							});
						}
					}
				}
				else
				{
					PBrickDevice.ReportError("read sensor.");
				}
			}
		}
*)

procedure TEv3Spirit.LookupResourceName;
var
  name : string;
  i : integer;
begin
  // lookup a resource string given this port name
  if fResourceNames.Count = 0 then
  begin
    name := GetInitFilename;
    if FileExists(name) then
    begin
      fResourceNames.LoadFromFile(name);
    end;
  end;
  i := fResourceNames.IndexOfName(fPort);
  if i <> -1 then
    fResPort := fResourceNames.Values[fPort];
end;

procedure TEv3Spirit.SetPort(const Value: string);
begin
  if (Value <> fPort) or (fResPort = '') then
  begin
    Close;
    inherited SetPort(Value);
    fResPort := fPort;
    LookupResourceName;
    UpdateBrickRestrictions;
    RefreshAvailableTransports;
  end;
end;

procedure TEv3Spirit.UpdateBrickRestrictions;
var
  tmp : string;
  i : integer;
begin
  // extract brick serial number from resport
  // did they ask for a particular EV3?
  fBRSerialNumber := '';
  fBRExpectedName := '';
  fBRIPAddress := '';
  fBRTransportType := ttAny;
  tmp := UpperCase(fResPort);
  //alias1=USB0::0X0694::0X0005::0016533DDA3A::RAW
  i := Pos('0X0694::0X0005::', tmp);
  if i > 0 then
  begin
    fBRSerialNumber := Copy(tmp, i+16, 12);
    fBRTransportType := ttUSB;
  end
  else
  begin
    if Pos('BTH', tmp) = 1 then
    begin
      //EV3BT=BTH::EV3::00:16:53:3D:DA:3A::5
      System.Delete(tmp, 1, 5);
      i := Pos('::', tmp);
      fBRExpectedName := Copy(fResPort, 6, i-1);
      tmp := Copy(tmp, i+2, 17);
      fBRSerialNumber := Replace(tmp, ':', '');
      fBRTransportType := ttBTH;
    end
    else if Pos('TCP', tmp) = 1 then
    begin
      //tcp0=TCP::192.168.2.125::0016533DDA3A
      System.Delete(tmp, 1, 5);
      i := Pos('::', tmp);
      fBRIPAddress := Copy(tmp, 1, i-1);
      System.Delete(tmp, 1, i+1);
      fBRSerialNumber := tmp;
      fBRTransportType := ttTCP;
    end
    else if tmp = 'USB' then
    begin
      fBRTransportType := ttUSB;
    end;
  end;
end;

function TEv3Spirit.DownloadFirmware(aFile: string; bFast : Boolean;
  bComp : Boolean; bUnlock : boolean): boolean;
begin
  Result := False;
(*
function TCasperDevice.DownloadProgram(image: TStream): cardinal;
var
  imageLength, totalBytesDownloaded, actualReadSize : integer;
  crc : Cardinal;
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
  calculator : TCrcCalculator;
  payload : TByteArray;
begin
  imageLength := Integer(image.Size);
  Update(pbrsDownloadingImage, 0, imageLength);
  calculator := TCrcCalculator.Create;
  try
    crc := 0;
    command := TPBrickGenericCommandObject.Create;
    try
      command.Write(ctSystemWithReply);
      command.Write(rcDownloadData);
      totalBytesDownloaded := 0;
      actualReadSize := image.Read(payload, 1018);
      while (actualReadSize <> 0) do
      begin
        command.BaseStream.Seek(2, soBeginning);
        command.BaseStream.Size := 2;
        command.BaseStream.Write(payload, actualReadSize);
        crc := calculator.CalculateCrc(payload, actualReadSize, crc);
        token := Self.SendMessage(command.BaseStream, true);
        if not token.TryReceiveMessage(nil, 5000) then
        begin
          Update(pbrsDownloadingImageFailed, totalBytesDownloaded, imageLength);
          break;
        end;
        totalBytesDownloaded := totalBytesDownloaded + actualReadSize;
        Update(pbrsDownloadingImage, totalBytesDownloaded, imageLength);
        actualReadSize := image.Read(payload, 1018);
      end;
      Result := crc;
    finally
      command.Free;
    end;
  finally
    calculator.Free;
  end;
end;

procedure TCasperDevice.StartApplication;
var
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
begin
  Update(pbrsStartingApplication, 0, 1);
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcStartApp);
    token := SendMessage(command.OutStream, true);
    if token.TryReceiveMessage(nil, 5000) then
    begin
      Update(pbrsStartingApplication, 1, 1);
    end;
  finally
    command.Free;
  end;
end;

function TCasperDevice.GetChecksum(address, imageSize: integer): cardinal;
var
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
begin
  Update(pbrsStartingApplication, 0, 1);
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcGetChecksum);
    command.Write(address);
    command.Write(imageSize);
    token := SendMessage(command.OutStream, true);
    while not token.TryReceiveMessage(nil, 5000) do
    begin
      Update(pbrsVerifyingImage, 1, 1);
    end;
    if token.MessageReady then
    begin
      token.ReadBuffer(3, Result);
    end;
  finally
    command.Free;
  end;
end;

procedure TCasperDevice.Recover(fileName: string);
var
  image : TMemoryStream;
  checkCrc : boolean;
  expectedChecksum, receivedCheckSum : Cardinal;
begin
  checkCrc := Copy(fileName, 1, 1) = '!';
  if checkCrc then
  begin
    fileName := Copy(fileName, 2, MaxInt);
  end;

  try
    image := TMemoryStream.Create;
    try
      try
        image.LoadFromFile(fileName);
        BeginFlashDownloadWithErase(0, Integer(image.Size));
        expectedChecksum := DownloadProgram(image);
        if checkCrc then
          receivedChecksum := GetChecksum(0, Integer(image.Size))
        else
          receivedChecksum := expectedChecksum;
        if expectedChecksum = receivedChecksum then
          StartApplication
        else
          Self.Update(pbrsImageVerificationFailed, 0, 0);
      except
        on E : EIOException do
        begin
          Self.Update(pbrsFileNotFound, 0, 0);
        end
        else
          raise;
      end;
    finally
      image.Free;
    end;
  except
    on E : EThreadAbortException do
    begin
      Update(pbrsAborted, 1, 1);
    end;
  end;
end;

function TCasperDevice.EraseFlash: integer;
var
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
  start : TDateTime;
begin
  Update(pbrsErasingChip, 0, 1);
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcChipErase);
    start := Now;
    token := Self.SendMessage(command.OutStream, true);
    while not token.TryReceiveMessage(nil, 2000) do
    begin
      Update(pbrsErasingChip, 1, 1);
    end;
  finally
    command.Free;
  end;
  Result := Trunc(TimeStampToMSecs(DateTimeToTimeStamp(Now-start)));
end;

procedure TCasperDevice.BeginFlashDownload(address, imageSize: integer);
var
  command : TPBrickGenericCommandObject;
begin
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcBeginDownload);
    command.Write(address);
    command.Write(imageSize);
    SendMessage(command.OutStream, true).ReceiveMessage(5000);
  finally
    command.Free;
  end;
end;

procedure TCasperDevice.BeginFlashDownloadWithErase(address, imageSize: integer);
var
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
begin
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcBeginDownloadWithErase);
    command.Write(address);
    command.Write(imageSize);
    token := SendMessage(command.OutStream, true);
    while not token.TryReceiveMessage(nil, 2000) do
    begin
      Update(pbrsErasingChip, 1, 2);
    end;
    Update(pbrsErasingChip, 2, 2);
  finally
    command.Free;
  end;
end;

		public override void UpdateFirmware(string fileName, bool abort)
		{
			using (PBrickGenericCommandObject command = new PBrickGenericCommandObject())
			{
				command.Write(129);
				command.Write(160);
				bool flag = false;
				try
				{
					CasperDevice casperDevice;
					Monitor.Enter(casperDevice = this.CasperDevice, ref flag);
					CasperDevice device = this.CasperDevice;
					device.AllowedTransports = new string[]
					{
						"USB"
					};
					device.SendMessage(command.ToArray(), false);
					Thread.Sleep(4000);
					this.Disconnect();
					ThreadPool.QueueUserWorkItem(delegate(object param0)
					{
						Thread.Sleep(20000);
						device.AllowedTransports = null;
					});
				}
				finally
				{
					if (flag)
					{
						CasperDevice casperDevice;
						Monitor.Exit(casperDevice);
					}
				}
			}
		}

*)
end;

function TEv3Spirit.Ping: boolean;
begin
  Result := Open;
  if not Result then Exit;
  // send something and check for echo?
end;

function TEv3Spirit.MuteSound: boolean;
var
  ms : TMemoryStream;
  id : Word;
begin
  Result := IsOpen;
  if not Result then Exit;
  ms := TMemoryStream.Create;
  try
    TDirectCommandBuilder.StartCommand(ctDirectNoReply, 0, 0, ms);
    TDirectCommandBuilder.StopSound(ms);
    id := NextSequenceID;
    Result := Transport.SendStream(id, ms) = ms.Size;
    if Result then
      fSoundMuted := True;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.UnmuteSound: boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  fSoundMuted := False;
end;

function TEv3Spirit.GetIsOpen: boolean;
begin
  Result := inherited GetIsOpen;
end;

function TEv3Spirit.DCStartProgram(const filename: string): boolean;
var
  ms : TMemoryStream;
  id : Word;
  rspData : TEV3Data;
  name, path : string;
  data : TJCHBytes;
  i, offset, sboCount : integer;
  ft : TPBRFileType;
begin
  Result := Open;
  if not Result then Exit;
  Result := False;
  ms := TMemoryStream.Create;
  try
//			fileName = PBrickDevice.PrettyPathToBrickPath(fileName, this._defaultStorageLocation);
    name := ExtractUnixFileName(filename);
    path := ExtractUnixFilePath(filename);
    if path = '' then
      path := BrickFolder;
    ft := EV3NameToPBRFileType(name);
    name := path + name;
    if (ft = nftOther) and (LocalFirmwareType = ftLinux) then
    begin
      TDirectCommandBuilder.StartCommand(ctDirectWithReply, 4, 0, ms);
      TDirectCommandBuilder.System(name, 0, ms);
    end
    else
    begin
      DCStopProgram;
      SetLength(data, 1);
      data[0] := 1;
      sboCount := 0;
      TDirectCommandBuilder.StartCommand(ctDirectWithReply, 0, 10, ms);
      TDirectCommandBuilder.PutInMruList(name, ms);
      TDirectCommandBuilder.LoadImage(name, 1, 0, 4, ms);
      TDirectCommandBuilder.ProgramStart(pslUserSlot, 0, 4, psmLoadOnly, ms); // psmNormal or psmDebug
      TDirectCommandBuilder.InitBytes(8, data, ms);
      // write start block offsets to memory
      for i := 0 to sboCount - 1 do
      begin
        offset := 0;
        TDirectCommandBuilder.MemoryWrite(pslUserSlot, 0, offset, 1, 8, ms);
      end;
      TDirectCommandBuilder.ProgramObjectStart(pslUserSlot, 1, ms);
    end;
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 500, id) then
      begin
        DebugLog(rspData);
        if (rspData[0] = DIRECT_REPLY_OK) then
        begin
          Result := True;
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.DCStopProgram: boolean;
var
  ms : TMemoryStream;
  id : Word;
const
  OUT_ALL = $0f;
begin
  Result := Open;
  if not Result then Exit;
  ms := TMemoryStream.Create;
  try
    TDirectCommandBuilder.StartCommand(ctDirectNoReply, 0, 0, ms);
    TDirectCommandBuilder.ProgramStop(pslDebugSlot, ms);    // do we need to stop this slot?
    TDirectCommandBuilder.ProgramStop(pslUserSlot, ms);
    TDirectCommandBuilder.OutputStop(0, OUT_ALL, False, ms);
    id := NextSequenceID;
    Result := Transport.SendStream(id, ms) = ms.Size;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.ConvertToAbsoluteBrickPath(const filename : string) : string;
//var
//  dir : string;
//  bRelative : boolean;
//  len : integer;
begin
  Result := filename;
{
  // does filename include a path?
  dir := ExtractUnixFilePath(filename);
  bRelative := False;
  len := Length(dir);
  if len > 0 then
  begin
    // do we have a relative or absolute path?
    bRelative := dir[1] <> '/';
  end;
  if len = 0 then
    dir := BrickFolder
  else if bRelative then
    dir := BrickFolder + dir;
  Result := dir + ExtractUnixFileName(filename);
}
end;

function TEv3Spirit.DCPlaySoundFile(const filename: string; bLoop: boolean): boolean;
var
  ms : TMemoryStream;
  id : Word;
  name : string;
begin
  Result := IsOpen;
  if not Result then Exit;
  Result := False;
  if fSoundMuted then
  begin
    Exit;
  end;
  name := ConvertToAbsoluteBrickPath(filename);
  ms := TMemoryStream.Create;
  try
    TDirectCommandBuilder.StartCommand(ctDirectNoReply, 0, 0, ms);
    TDirectCommandBuilder.PlaySoundFile(ChangeFileExt(name, ''), 100, 0, ms);
    id := NextSequenceID;
    Result := Transport.SendStream(id, ms) = ms.Size;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.DCGetOutputState(const aPort: byte; var power: integer;
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

function TEv3Spirit.DCSetOutputState(const aPort: byte;
  const power: integer; const mode, regmode: byte;
  const turnratio: integer; const runstate: byte;
  const tacholimit: cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.DCGetInputValues(const aPort: byte; var valid,
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

(*
procedure TCasperDevice.AutoIDHardware;
var
  command : TMemoryStream;
  token : TPendingResponse;
begin
//			lock (this.CasperDevice)
  command := TMemoryStream.Create;
  try
    TDirectCommandBuilder.BuildCommand(ctDirectWithReply, 16, 0, nil, command);
  finally
    command.Free;
  end;
{
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 16, 0, new byte[][]
				{
					DirectCommandBuilder.InputDeviceGetTypeMode(0, PortId.InputFlag, 0, 4),
					DirectCommandBuilder.InputDeviceGetTypeMode(0, PortId.InputTwo, 1, 5),
					DirectCommandBuilder.InputDeviceGetTypeMode(0, PortId.InputThree, 2, 6),
					DirectCommandBuilder.InputDeviceGetTypeMode(0, PortId.InputFour, 3, 7),
					DirectCommandBuilder.InputDeviceGetTypeMode(0, PortId.OutputA, 4, 8),
					DirectCommandBuilder.InputDeviceGetTypeMode(0, PortId.OutputB, 5, 9),
					DirectCommandBuilder.InputDeviceGetTypeMode(0, PortId.OutputC, 6, 10),
					DirectCommandBuilder.InputDeviceGetTypeMode(0, PortId.OutputD, 7, 11)
				});
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok)
				{
					for (int i = 0; i < base.PortHardware.Count<byte>(); i++)
					{
						byte currentSensorType = reply[1 + i];
						base.PortHardware[i] = currentSensorType;
						DetectedHardwareResponse detectedHardwareResponse = new DetectedHardwareResponse();
						detectedHardwareResponse.PortID = this._portIDs[i];
						DetectedHardwareResponse arg_118_0 = detectedHardwareResponse;
						int num = (int)currentSensorType;
						arg_118_0.HardwareID = num.ToString(CultureInfo.InvariantCulture);
						PingBuffer.AddResponse(detectedHardwareResponse);
					}
				}
				else
				{
					PBrickDevice.ReportError("AutoId connected hardware.");
				}
//			unlock (this.CasperDevice)
}
end;
*)

function TEv3Spirit.DCSetInputMode(const aPort, stype, smode: byte): boolean;
var
  ms : TMemoryStream;
  id : Word;
  rspData : TEV3Data;
  layer, port : byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  Result := False;
  ms := TMemoryStream.Create;
  try
    port  := Byte(aPort);
    layer := 0;
    // this can handle both inputs and outputs
    DecodePort(port, layer);
    TDirectCommandBuilder.StartCommand(ctDirectWithReply, 4, 0, ms);
    TDirectCommandBuilder.InputRead(layer, TPortId(port), stype, smode, 1, 0, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 500, id) then
      begin
        DebugLog(rspData);
        if (rspData[0] = DIRECT_REPLY_OK) then
        begin
          Result := True;
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.DCResetInputScaledValue(const aPort: byte): boolean;
begin
  Result := ClearSensorValue(aPort);
end;

function TEv3Spirit.DCResetOutputPosition(const aPort: byte;
  const Relative: boolean): boolean;
var
  ms : TMemoryStream;
  id : Word;
  layer, port : byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  ms := TMemoryStream.Create;
  try
    layer := 0;
    port := aPort;
    DecodeOutputs(port, layer);
    TDirectCommandBuilder.StartCommand(ctDirectNoReply, 0, 0, ms);
    TDirectCommandBuilder.OutputClearCount(layer, port, ms);
    id := NextSequenceID;
    Result := Transport.SendStream(id, ms) = ms.Size;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.DCMessageWrite(const inbox: byte; const msg: string): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.DCKeepAlive(var time: cardinal; const chkResponse : boolean): boolean;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
  minutes : byte;
begin
  time := 0;
  Result := IsOpen;
  if not Result then Exit;
  ms := TMemoryStream.Create;
  try
    TDirectCommandBuilder.StartCommand(ctDirectWithReply, 1, 0, ms);
    TDirectCommandBuilder.KeepAlive(0, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 50, id) then
      begin
        DebugLog(rspData);
        if (rspData[0] = DIRECT_REPLY_OK) then
        begin
          Move(rspData[1], minutes, 1);
          // convert minutes into milliseconds
          time := minutes * 60 * 1000;
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.DCLSGetStatus(aPort : byte; var bytesReady: byte; var lsstate : byte): boolean;
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

function TEv3Spirit.DCGetCurrentProgramName(var name: string): boolean;
begin
  Result := IsOpen;
  name := '';
  // there is no way to query the brick for the name of the currently running program
end;

function TEv3Spirit.DCGetButtonState(const idx: byte; const reset: boolean;
  var pressed: boolean; var count: byte): boolean;
begin
  Result := IsOpen;
  pressed := False;
  count := 0;
  // only used in NeXTTool
end;

function TEv3Spirit.DCMessageRead(const remote, local: byte;
  const remove: boolean; var Msg: PBRMessage): boolean;
begin
  Msg.Inbox := 0;
  Msg.Size  := 0;
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.SCOpenRead(const filename: string; var handle: FantomHandle;
  var size: cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  handle := 0;
  size := 0;
end;

function TEv3Spirit.SCOpenReadLinear(const filename: string;
  var handle: FantomHandle; var size: cardinal): boolean;
begin
  Result := SCOpenRead(filename, handle, size);
end;

function TEv3Spirit.SCOpenAppendData(const filename: string;
  var size: cardinal; var handle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.SCOpenWrite(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
begin
  Result := IsOpen;
  if not Result then Exit;
  Result := False;
  handle := Cardinal(-1);
  ms := TMemoryStream.Create;
  try
    TSystemCommandBuilder.FileDownloadHeader(filename, size, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 60000, id) then
      begin
        DebugLog(rspData);
        Result := (rspData[0] = SYSTEM_REPLY_OK) and
                  (Length(rspData) = 4) and
                  (TFileHandlingStatus(rspData[2]) = fhsSuccess);
        if Result then
        begin
          handle := rspData[3];
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.SCOpenWriteData(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
begin
  Result := SCOpenWrite(filename, size, handle);
end;

function TEv3Spirit.SCOpenWriteLinear(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
begin
  Result := SCOpenWrite(filename, size, handle);
end;

function TEv3Spirit.SCRead(var handle: FantomHandle; var count: word;
  var buffer: PBRDataBuffer): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.SCWrite(var handle: FantomHandle; const buffer: PBRDataBuffer;
  var count: word; const chkResponse: boolean): boolean;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
  b : byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  Result := False;
  ms := TMemoryStream.Create;
  try
    b := Byte(handle);
    TSystemCommandBuilder.FileDownloadSection(PByte(@(buffer.Data[0])), count, b, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 60000, id) then
      begin
        DebugLog(rspData);
        Result := (rspData[0] = SYSTEM_REPLY_OK) and (Length(rspData) > 2);
        if Result then
        begin
          // check file handling status
          if not (TFileHandlingStatus(rspData[2]) in [fhsSuccess, fhsEndOfFile]) then
            Result := False;
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.SCCloseFile(var handle: FantomHandle; const chkResponse: boolean): boolean;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
  b : byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  Result := False;
  ms := TMemoryStream.Create;
  try
    b := Byte(handle);
    TSystemCommandBuilder.FileDownloadCloseHandle(b, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 50, id) then
      begin
        DebugLog(rspData);
        Result := (rspData[0] = SYSTEM_REPLY_OK) or
                  ((Length(rspData) > 2) and (TFileHandlingStatus(rspData[2]) = fhsUnknownHandle));
      end;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.SCDeleteFile(var filename: string; const chkResponse: boolean): boolean;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
  cmd : TCommandType;
begin
  Result := IsOpen;
  if not Result then Exit;
  ms := TMemoryStream.Create;
  try
    cmd := ctDirectNoReply;
    if chkResponse then
    begin
      cmd := ctDirectWithReply;
    end;
    TDirectCommandBuilder.StartCommand(cmd, 0, 0, ms);
    TDirectCommandBuilder.DeleteFile(filename, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if chkResponse and (id = Transport.ReceiveMessage(rspData, 5000, id)) then
      begin
        DebugLog(rspData);
        Result := (Length(rspData) > 0) and (rspData[0] = DIRECT_REPLY_OK);
      end
      else
        Result := True;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.SCFindFirstFile(var filename: string;
  var IterHandle: FantomHandle; var filesize, availsize : cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.SCFindNextFile(var IterHandle: FantomHandle; var filename: string;
  var filesize, availsize : cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.SCFindClose(var IterHandle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.SCGetVersions(var protmin, protmaj, firmmin, firmmaj : byte): boolean;
begin
  protmin := 0;
  protmaj := 0;
  firmmin := 0;
  firmmaj := 0;
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.SCCloseModuleHandle(var handle: FantomHandle; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.SCBootCommand(const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.SCSetBrickName(const name: string; const chkResponse: boolean): boolean;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
  cmd : TCommandType;
begin
  Result := IsOpen;
  if not Result then Exit;
  ms := TMemoryStream.Create;
  try
    cmd := ctDirectNoReply;
    if chkResponse then
    begin
      cmd := ctDirectWithReply;
    end;
    TDirectCommandBuilder.StartCommand(cmd, 0, 0, ms);
    TDirectCommandBuilder.RenameBrick(name, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if chkResponse and (id = Transport.ReceiveMessage(rspData, 50, id)) then
      begin
        DebugLog(rspData);
        Result := rspData[0] = DIRECT_REPLY_OK;
      end
      else
        Result := True;
    end;
  finally
    ms.Free;
  end;
end;

function FormatBTAddress(addr : string) : string;
var
  i : integer;
begin
  addr := UpperCase(addr);
  i := 1;
  Result := '';
  while i < Length(addr) do
  begin
    Result := Result + Copy(addr, i, 2 ) + ':';
    inc(i, 2);
  end;
  System.Delete(Result, Length(Result), 1);
end;

function TEv3Spirit.SCGetDeviceInfo(var name: string;
  var BTAddress : String; var BTSignal : Cardinal; var memFree : Cardinal): boolean;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
begin
  name := '';
  BTAddress := '';
  BTSignal := 0;
  memFree := 0;
  Result := IsOpen;
  if not Result then Exit;
  Result := False;
  ms := TMemoryStream.Create;
  try
    TDirectCommandBuilder.StartCommand(ctDirectWithReply, 148, 0, ms);
    TDirectCommandBuilder.GetOnBrickStorageStatus(0, 4, ms);
    TDirectCommandBuilder.GetBrickName(120, 8, ms);
    TDirectCommandBuilder.GetBrickBTAddress(20, 128, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 50, id) then
      begin
        DebugLog(rspData);
        if (rspData[0] = DIRECT_REPLY_OK) then
        begin
          Move(rspData[5], memfree, 4);
          memfree := memfree * 1024; // bytes
          name := String(PChar(@rspData[9]));
          BTAddress := FormatBTAddress(String(PChar(@rspData[129])));
          Result := True;
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.SCDeleteUserFlash(const chkResponse: boolean): boolean;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
  cmd : TCommandType;
  globalCount : byte;
  resolvedDirectory : string;
begin
  Result := IsOpen;
  if not Result then Exit;
  Result := False;
  ms := TMemoryStream.Create;
  try
    globalCount := 0;
    cmd := ctDirectNoReply;
    if chkResponse then
    begin
      cmd := ctDirectWithReply;
      globalCount := 100;
    end;
    resolvedDirectory := BrickFolder;
    TDirectCommandBuilder.StartCommand(cmd, globalCount, 0, ms);
    TDirectCommandBuilder.CleanDirectory(resolvedDirectory, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if chkResponse and (id = Transport.ReceiveMessage(rspData, 500, id)) then
      begin
        DebugLog(rspData);
        if (rspData[0] = DIRECT_REPLY_OK) then
        begin
          Result := True;
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.SCBTFactoryReset(const chkResponse: boolean): boolean;
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

function TEv3Spirit.UploadFile(const filename: string; const dir : string): boolean;
var
  ms : TMemoryStream;
  tmpFilename : string;
begin
  Result := IsOpen;
  if not Result then Exit;
  ms := TMemoryStream.Create;
  try
    DoDownloadStart;
    try
      Result := UploadFileToStream(filename, ms);
    finally
      DoDownloadDone;
    end;
    tmpFilename := ExtractFilename(Replace(filename, '/', PathDelim));
    if dir <> '' then
      tmpFilename := IncludeTrailingPathDelimiter(dir) + tmpFilename;
    if Result then
      MS.SaveToFile(tmpFilename);
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.UploadFileToStream(const filename: string; aStream: TStream): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  Result := UploadFromDeviceLowLevel(False, filename, aStream);
end;

function TEv3Spirit.UploadFromDeviceLowLevel(const DirList : boolean;
  const path: string; data : TStream): boolean;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id, tmpid, len : Word;
  fhs : TFileHandlingStatus;
  handle : byte;
  fileSize, filePointer, payloadSize : Cardinal;
  bStop : boolean;
  cur, steps : integer;
begin
  data.Size := 0; // clear the data stream
  Result := IsOpen;
  if not Result then Exit;
  Result := False;
  ms := TMemoryStream.Create;
  try
    TSystemCommandBuilder.FileUploadHeader(path, MaxFileUploadBytes, DirList, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      tmpid := Transport.ReceiveMessage(rspData, 60000, id);
      len   := Length(rspData);
      if (id <> tmpid) or
         (len < 3) or
         ((len > 0) and (rspData[0] <> SYSTEM_REPLY_OK)) then
      begin
        Result := False;
        Exit;
      end;
      DebugLog(rspData);
      fhs := TFileHandlingStatus(rspData[2]);
      Result := (fhs in [fhsSuccess, fhsEndOfFile]);
      if not Result then
        Exit;
      // so far so good
      handle := rspData[7];
      Move(rspData[3], fileSize, 4);

      bStop := False;
      cur := 0;
      steps := (fileSize div MaxFileUploadBytes);

      filePointer := 0;
      payloadSize := len - 8;
      if payloadSize > 0 then
      begin
        // copy from response to data stream
        data.Write(Pointer(@rspData[8])^, payloadSize);
        filePointer := payloadSize;
      end;
      inc(cur);
      DoDownloadStatus(cur, steps, bStop);
      while Result and (filePointer < fileSize) do
      begin
        ms.Size := 0; // clear our memory stream
        TSystemCommandBuilder.FileUploadSection(handle, MaxFileUploadBytes, DirList, ms);
        id := NextSequenceID;
        Result := Transport.SendStream(id, ms) = ms.Size;
        if Result then
        begin
          tmpid := Transport.ReceiveMessage(rspData, 60000, id);
          len   := Length(rspData);
          Result := (id = tmpid) and (len > 4) and (rspData[0] = SYSTEM_REPLY_OK);
          if Result then
          begin
            DebugLog(rspData);
            fhs := TFileHandlingStatus(rspData[2]);
            DebugFmt('File handling status = %d', [Ord(fhs)]);
            payloadSize := Min(len - 4, fileSize - filePointer);
            data.Write(Pointer(@rspData[4])^, payloadSize);
            inc(filePointer, payloadSize);
            inc(cur);
            DoDownloadStatus(cur, steps, bStop);
          end;
        end;
      end;
      if not Result then
      begin
        data.Size := 0;
      end;
    end;
  finally
    ms.Free;
  end;
end;

function MemoryStreamToString(M: TMemoryStream): AnsiString;
begin
  SetString(Result, PAnsiChar(M.Memory), M.Size);
end;

function TEv3Spirit.ListFilesAndFolders(const searchPattern: string; aList: TStrings): boolean;
var
  dir : string;
//  bRelative : boolean;
//  len : integer;
  ms : TMemoryStream;
  list : string;
begin
  aList.Clear;
  Result := IsOpen;
  if not Result then Exit;
  dir := ExtractUnixFilePath(searchPattern);
(*
  bRelative := False;
  len := Length(dir);
  if len > 0 then
  begin
    // do we have a relative or absolute path?
    bRelative := dir[1] <> '/';
  end;
  if len = 0 then
    dir := BrickFolder
  else if bRelative then
  begin
    if (Length(dir) >= Length(BrickFolder)) and
       (Pos(BrickFolder, dir) = 1) then
    begin
      // don't change dir
    end
    else if (Length(dir) < Length(BrickFolder)) and
            (Pos(dir, BrickFolder) = 1) then
    begin
      // also do not change dir
    end
    else
    begin
      dir := BrickFolder + dir;
    end;
  end;
*)
  ms := TMemoryStream.Create;
  try
    if dir = '' then
      dir := '/';
    Result := UploadFromDeviceLowLevel(true, dir, ms);
    list := MemoryStreamToString(ms);
    list := Replace(list, #10, #13#10);
    aList.Text := list;
    if (dir <> '/') and (dir <> '') then
      aList.Add('../');
    if aList.Count = 0 then
      aList.Add('../');
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.ListFiles(const searchPattern: string; Files: TStrings): boolean;
var
  ext : string;
  allData : TStringList;
  i, size, delPos : integer;
  tmp, tmpMD5, tmpHexSize : string;
  bFilterList : boolean;
begin
  Files.Clear;
  Result := IsOpen;
  if not Result then Exit;
  ext := ExtractFileExt(searchPattern);
  bFilterList  := ext <> '.*';
  allData := TStringList.Create;
  try
    allData.Sorted := True;
    allData.Duplicates := dupIgnore;
    Result := ListFilesAndFolders(searchPattern, allData);
    if Result then
    begin
      // copy files into Files list if they match the specified extension
      // 32 chars (hex) of MD5SUM + space + 8 chars (hex) of filesize + space + filename
      // OR
      // foldername + /
      for i := 0 to allData.Count - 1 do
      begin
        tmp := allData[i];
        if tmp[Length(tmp)] <> '/' then
        begin
          // this is a file
          delPos := Pos(' ', tmp);
          tmpMD5 := Copy(tmp, 1, delPos-1);
          System.Delete(tmp, 1, delPos);
          delPos := Pos(' ', tmp);
          tmpHexSize := '$' + Copy(tmp, 1, delPos-1);
          size := StrToIntDef(tmpHexSize, 0);
          System.Delete(tmp, 1, delPos);
          // all that is left is filename
          // does it match our search criteria?
          if not bFilterList or (Pos(ext, tmp) > 0) then
            Files.Add(tmp + '=' + IntToStr(size));
        end
        else
        begin
          // this is a folder
          System.Delete(tmp, Length(tmp), 1); // remove '/'
          if (tmp <> '.') and
             ((tmp = '..') or (tmp[1] <> '.')) then
            Files.Add(tmp + '=-1');
        end;
      end;
    end;
  finally
    allData.Free;
  end;
end;

function TEv3Spirit.ListModules(const searchPattern: string;  Modules: TStrings): boolean;
begin
  Result := False;
  Modules.Clear;
end;

function TEv3Spirit.ListBricks(Bricks: TStrings): boolean;
begin
  Result := False;
  Bricks.Clear;
  // find EV3 bricks via all possible transport layers.
end;

function TEv3Spirit.CreateFolder(const foldername: string): boolean;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
  name, path : string;
begin
  Result := IsOpen;
  if not Result then Exit;
  path := foldername;
  name := ExtractUnixFileName(foldername);
  path := ExtractUnixFilePath(foldername);
  if path = '' then
    path := BrickFolder;
  name := path + name;
  ms := TMemoryStream.Create;
  try
    TDirectCommandBuilder.StartCommand(ctDirectWithReply, 1, 0, ms);
    TDirectCommandBuilder.MakeFolder(name, 0, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 500, id) then
      begin
        DebugLog(rspData);
        if (rspData[0] = DIRECT_REPLY_OK) then
        begin
          Result := rspData[1] = 1;
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.DownloadFile(const filename: string; const filetype: TPBRFileType): boolean;
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
      DoDownloadStart;
      try
        Result := DownloadStream(MS, filename, filetype);
      finally
        DoDownloadDone;
      end;
    finally
      MS.Free;
    end;
  end;
end;

function TEv3Spirit.DownloadStream(aStream: TStream; const dest : string;
  const filetype: TPBRFileType): boolean;
var
  size, xferred : Cardinal;
  cnt : Word;
  handle : FantomHandle;
//  i : integer;
  ev3Filename, delname : string;
  buf : PBRDataBuffer;
  bStop : boolean;
  cur, steps : integer;
begin
  Result := Open;
  if not Result then Exit;
  // download means from PC to EV3
  // make destination filename a valid EV3 filename
  bStop := False;
  cur := 0;
  size := aStream.Size;
  steps := (size div MaxFileDownloadBytes) + 3;

  ev3Filename := BrickFolder + ExtractFilename(dest);
  delname := ev3Filename;
  SCDeleteFile(delname, True);
  inc(cur);
  DoDownloadStatus(cur, steps, bStop);
  Result := SCOpenWrite(ev3Filename, size, handle);
  inc(cur);
  DoDownloadStatus(cur, steps, bStop);
  if Result then
  begin
    // write in < MaxFileDownloadBytes byte chunks
    xferred := 0;
    aStream.Position := 0; // start at the beginning
    while xferred < size do
    begin
      cnt := Min(size - xferred, MaxFileDownloadBytes);
      // fill our buffer with the right number of bytes
      aStream.Read(Pointer(@(buf.Data[0]))^, cnt);
      // write these bytes to the NXT
      Result := SCWrite(handle, buf, cnt, cnt = (size - xferred));
      inc(cur);
      DoDownloadStatus(cur, steps, bStop);
      if not Result then Break;
      inc(xferred, cnt);
    end;
    Result := SCCloseFile(handle) and Result;
    cur := steps;
    DoDownloadStatus(cur, steps, bStop);
  end;
end;

function TEv3Spirit.SCPollCommandLen(const bufNum : byte; var count: byte): boolean;
begin
  Result := False;
end;

function TEv3Spirit.SCPollCommand(const bufNum: byte; var count: byte;
  var buffer: PBRDataBuffer): boolean;
begin
  Result := False;
end;

function TranslateButton(btn : byte) : byte;
begin
  if btn > ANY_BUTTON then
    btn := btn - 8;
  case btn of
    1 : Result := LEFT_BUTTON;
    2 : Result := ENTER_BUTTON;
    3 : Result := RIGHT_BUTTON;
    4 : Result := BACK_BUTTON;
    5 : Result := UP_BUTTON;
    6 : Result := DOWN_BUTTON;
  else
    Result := NO_BUTTON;
  end;
end;

function TEv3Spirit.EV3ButtonPressOrRelease(const buffer: PBRDataBuffer): boolean;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
  btn : byte;
  bRelease : boolean;
begin
  Result := False;
  btn := buffer.Data[0];
  bRelease := btn > ANY_BUTTON;
  btn := TranslateButton(btn);
  ms := TMemoryStream.Create;
  try
    TDirectCommandBuilder.StartCommand(ctDirectNoReply, 0, 0, ms);
    if bRelease then
      TDirectCommandBuilder.ButtonRelease(btn, ms)
    else
      TDirectCommandBuilder.ButtonPress(btn, ms);
    id := NextSequenceID;
    Result := Transport.SendStream(id, ms) = ms.Size;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.SCWriteIOMap(var ModID: Cardinal;
  const Offset: Word; var count: Word; const buffer: PBRDataBuffer;
  chkResponse : Boolean): boolean;
begin
  Result := False;
  if IsOpen and (ModID = kNXT_ModuleUI) and (Offset = UIOffsetButton) and (count = 1) then
  begin
    // this appears to be an attempt to press an EV3 button
    Result := EV3ButtonPressOrRelease(buffer);
  end;
end;

function TEv3Spirit.EV3ReadScreenHack(Offset: Word; var Count: Word; var buffer: PBRDataBuffer): boolean;
const
  EV3_LCD_BUFFER_SIZE = 2944;
  EV3_SNAPSHOT_FILE = 'snapshot.raw';
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
  status : integer;
  pTmp : PByte;
  filename : string;
begin
  FillChar(buffer.Data[0], kEV3_MaxBytes, 0);
  Result := IsOpen;
  if Result then
  begin
    Result := False;
    status := -1;
    if (fSnapshotMS.Size = 0) and
       ((Offset = DisplayOffsetNormal(0, 0)) or
        (Offset = DisplayOffsetPopup(0, 0))) then
    begin
      SetupSnapshotTool;
      fSnapshotBaseOffset := Offset;
      // create snapshot, upload file to stream, and process first Count bytes
      fSnapshotMS.Clear;
      // try to execute system opcode in order to take a snapshot
      ms := TMemoryStream.Create;
      try
        TDirectCommandBuilder.StartCommand(ctDirectWithReply, 4, 0, ms);
        TDirectCommandBuilder.System(fSnapshotFolder+'snapshot -f1', 0, ms);
        id := NextSequenceID;
        if Transport.SendStream(id, ms) = ms.Size then
        begin
          if id = Transport.ReceiveMessage(rspData, 5000, id) then
          begin
            DebugLog(rspData);
            if (rspData[0] = DIRECT_REPLY_OK) then
            begin
              Move(rspData[1], status, 4);
            end;
          end;
        end;
      finally
        ms.Free;
      end;
      if status <> -1 then
      begin
        filename := fSnapshotFolder+EV3_SNAPSHOT_FILE;
        if UploadFileToStream(filename, fSnapshotMS) and
           ((fSnapshotMS.Size = EV3_LCD_BUFFER_SIZE)) then
        begin
//          // try to delete the file
//          SCDeleteFile(filename, true);
          // copy data from the memory stream
          pTmp := fSnapshotMS.Memory;
          Move(pTmp^, buffer.Data[0], Count);
          Result := True;
        end;
      end;
    end
    else
    begin
      // process Count bytes from previously uploaded stream
      pTmp := fSnapshotMS.Memory;
      inc(pTmp, Offset-fSnapshotBaseOffset);
      Move(pTmp^, buffer.Data[0], Count);
      if (Offset+Count) >= (fSnapshotBaseOffset+EV3_LCD_BUFFER_SIZE) then
      begin
        // empty out the snapshot stream
        fSnapshotMS.Clear;
      end;
      Result := True;
    end;
  end;
end;

function TEv3Spirit.SCReadIOMap(var ModID: Cardinal;
  const Offset: Word; var Count: Word; var buffer: PBRDataBuffer): boolean;
begin
  Result := False;
  if IsOpen and (ModID = kNXT_ModuleDisplay) and
     (Offset >= DisplayOffsetNormal(0, 0)) then
  begin
    // this appears to be an attempt to read screen memory (either normal or popup)
    Result := EV3ReadScreenHack(Offset, Count, buffer);
  end;
end;

function TEv3Spirit.SCFindNextModule(var Handle: FantomHandle;
  var ModName: string; var ModID, ModSize: Cardinal;
  var IOMapSize: Word): boolean;
begin
  Result := False;
end;

function TEv3Spirit.SCFindFirstModule(var ModName: string; var Handle: FantomHandle;
  var ModID, ModSize: Cardinal; var IOMapSize: Word): boolean;
begin
  Result := False;
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
(*
		public override int WriteVMMemory(int targetSegment, int targetOffset, byte[] data, int offset, int count)
		{
			lock (this.CasperDevice)
			{
				using (PBrickDirectCommandObject commandsObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 1, 2))
				{
					commandsObject.Write(DirectCommandBuilder.InitBytes(0, data));
					commandsObject.Write(DirectCommandBuilder.MemoryWrite(ProgramSlot.UserSlot, targetSegment, targetOffset, data.Length, 0));
					byte[] reply;
					this.CasperDevice.SendMessage(commandsObject.ToArray(), true).TryReceiveMessage(out reply);
				}
			}
			return 1;
		}
*)
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
  Result := IsOpen;
end;

function TEv3Spirit.ClearAllEvents: boolean;
begin
  Result := IsOpen;
end;

function TEv3Spirit.ClearCounter(num: TCounterNumber): boolean;
begin
  Result := IsOpen;
  if num = 0 then Exit;
end;

function TEv3Spirit.ClearSound: boolean;
var
  ms : TMemoryStream;
  id : Word;
begin
  Result := IsOpen;
  if not Result then Exit;
  ms := TMemoryStream.Create;
  try
    TDirectCommandBuilder.StartCommand(ctDirectNoReply, 0, 0, ms);
    TDirectCommandBuilder.StopSound(ms);
    id := NextSequenceID;
    Result := Transport.SendStream(id, ms) = ms.Size;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.ClearTachoCounter(aMotorList: Byte): boolean;
begin
  Result := IsOpen;
  if Result then
  begin
    Result := DCResetOutputPosition(aMotorList, False);
  end;
end;

function TEv3Spirit.ClearTimer(aNum: integer): boolean;
begin
  Result := IsOpen;
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
var
  SL : TStringList;
  i : integer;
  name : string;
  sdPresent, usbPresent : Byte;
  sdTotal, sdFree, usbTotal, usbFree, ramTotal, ramFree : Cardinal;
begin
  fMemMap.Clear;
  SL := TStringList.Create;
  try
    fMemMap.Add('Files');
    fMemMap.Add('');
    if ListFiles('../prjs/SD_Card/*.*', SL) then
    begin
      for i := 0 to SL.Count - 1 do
      begin
        name := SL[i];
        if Pos('-1', name) > 0 then Continue;
        fMemMap.Add(SL.Names[i]);
        fMemMap.Add(SL.ValueFromIndex[i]);
      end;
    end;
    SL.Clear;
    fMemMap.Add('');
    fMemMap.Add('');
    ramTotal := 0; ramFree := 0;
    sdTotal  := 0; sdFree  := 0;
    usbTotal := 0; usbFree := 0;
    sdPresent := 0; usbPresent := 0;
    if GetEV3StorageStatus(ramTotal, ramFree, sdPresent, sdTotal, sdFree, usbPresent, usbTotal, usbFree) then
    begin
      fMemMap.Add('Total RAM (kb)');
      fMemMap.Add(IntToStr(ramTotal));
      fMemMap.Add('Free RAM (kb)');
      fMemMap.Add(IntToStr(ramFree));
      fMemMap.Add('SD Card Present');
      fMemMap.Add(IntToStr(sdPresent));
      if sdPresent <> 0 then
      begin
        fMemMap.Add('Total SD Card (kb)');
        fMemMap.Add(IntToStr(sdTotal));
        fMemMap.Add('Free SD Card (kb)');
        fMemMap.Add(IntToStr(sdFree));
      end;
      fMemMap.Add('USB Stick Present');
      fMemMap.Add(IntToStr(usbPresent));
      if usbPresent <> 0 then
      begin
        fMemMap.Add('Total USB Stick (kb)');
        fMemMap.Add(IntToStr(usbTotal));
        fMemMap.Add('Free USB Stick (kb)');
        fMemMap.Add(IntToStr(usbFree));
      end;
    end
    else
    begin
      i := SCFreeMemory;
      fMemMap.Add('Free Memory');
      fMemMap.Add(IntToStr(i));
    end;
  finally
    SL.Free;
  end;
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
  if not IsOpen then Exit;
  Result := fMotorPower[aOut]; // bits 0..2
  if fMotorForward[aOut] then
    Result := Result + (1 shl 3); // bit 3
//  if bBrake then
//    Result := Result + (1 shl 6); // bit 6
  if fMotorOn[aOut] then
    Result := Result + (1 shl 7); // bit 7
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
var
  i : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  if fSoundMuted then
  begin
    Result := False;
    Exit;
  end;

  case aSnd of
    SOUND_CLICK : begin
      PlayTone(600, 200);
      Sleep(200);
    end;
    SOUND_DOUBLE_BEEP : begin
      PlayTone(587, 150);
      Sleep(200);
      PlayTone(587, 150);
      Sleep(150);
    end;
    SOUND_DOWN : begin
      for i := 7 downto 4 do
      begin
        PlayTone(523 * i div 4, 100);
        Sleep(100);
      end;
    end;
    SOUND_UP : begin
      for i := 4 to 7 do
      begin
        PlayTone(523 * i div 4, 100);
        Sleep(100);
      end;
    end;
    SOUND_LOW_BEEP : begin
      PlayTone(100, 500);
      Sleep(500);
    end;
    SOUND_FAST_UP : begin
      for i := 4 to 7 do
      begin
        PlayTone(523 * i div 4, 50);
        Sleep(50);
      end;
    end;
  end;
end;

function TEv3Spirit.Poll(aSrc, aNum: integer): variant;
var
  res : boolean;
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
  layer, port, stype, smode, bval, readSI, gCnt : byte;
  value : integer;
  svalue : single;
begin
  Result := 0;
  case aSrc of
    kRCX_VariableType : begin     // 0
      Result := 0; //GetEV3VariableHelper(aNum, 0, 0, 18);
    end;
    kRCX_TimerType : begin        // 1
      Result := 0;
    end;
    kRCX_ConstantType : begin     // 2
      Result := aNum;
    end;
    kRCX_OutputStatusType : begin // 3
      Result := GetOutputStatus(aNum);
    end;
    kRCX_RandomType : begin       // 4
      Result := Random(aNum);
    end;
    kRCX_TachCounterType : begin  // 5
      Result := 0;
      ms := TMemoryStream.Create;
      try
        layer := 0;
        port := Byte(aNum);
        DecodeOutput(port, layer);
        TDirectCommandBuilder.StartCommand(ctDirectWithReply, 4, 0, ms);
        TDirectCommandBuilder.OutputGetCount(layer, port, 0, ms);
        id := NextSequenceID;
        if Transport.SendStream(id, ms) = ms.Size then
        begin
          if id = Transport.ReceiveMessage(rspData, 500, id) then
          begin
            DebugLog(rspData);
            if (rspData[0] = DIRECT_REPLY_OK) then
            begin
              Move(rspData[1], value, 4);
              Result := value;
            end;
          end;
        end;
      finally
        ms.Free;
      end;
    end;
    kRCX_InputTypeType,
    kRCX_InputModeType : begin  // 10, 11
      Result := 0;
      ms := TMemoryStream.Create;
      try
        // inputs are 0-15  (4 sensors per layer * 4 layers)
        // outputs are 16-32 (ditto)
        layer := 0;
        port := Byte(aNum);
        // this can handle both inputs and outputs
        DecodePort(port, layer);
        TDirectCommandBuilder.StartCommand(ctDirectWithReply, 2, 0, ms);
        TDirectCommandBuilder.InputDeviceGetTypeMode(layer, TPortId(port), 0, 1, ms);
        id := NextSequenceID;
        if Transport.SendStream(id, ms) = ms.Size then
        begin
          if id = Transport.ReceiveMessage(rspData, 500, id) then
          begin
            DebugLog(rspData);
            if (rspData[0] = DIRECT_REPLY_OK) then
            begin
              stype := rspData[1];
              if stype = 126 then stype := 0;
              smode := rspData[2] * 32;
              if aSrc = kRCX_InputTypeType then
              begin
                fSensorType[aNum] := stype;
                Result := stype;
              end
              else if aSrc = kRCX_InputModeType then
              begin
                fSensorMode[aNum] := smode;
                Result := smode;
              end;
            end;
          end;
        end;
      finally
        ms.Free;
      end;
    end;
    kRCX_InputRawType: // 12
    begin
      Result := 0;
      ms := TMemoryStream.Create;
      try
        // inputs are 0-15  (4 sensors per layer * 4 layers)
        // outputs are 16-32 (ditto)
        layer := 0;
        port := Byte(aNum);
        // this can handle both inputs and outputs
        DecodePort(port, layer);
        TDirectCommandBuilder.StartCommand(ctDirectWithReply, 4, 0, ms);
        TDirectCommandBuilder.InputDeviceGetRaw(layer, TPortId(port), 0, ms);
        id := NextSequenceID;
        if Transport.SendStream(id, ms) = ms.Size then
        begin
          if id = Transport.ReceiveMessage(rspData, 500, id) then
          begin
            DebugLog(rspData);
            if (rspData[0] = DIRECT_REPLY_OK) then
            begin
              Move(rspData[1], value, 4);
              Result := value;
            end;
          end;
        end;
      finally
        ms.Free;
      end;
    end;
    kRCX_InputValueType,
    kRCX_InputBooleanType : begin  // 9, 13
      Result := 0;
      readSI := 0;
      gCnt   := 1;
      if aSrc = kRCX_InputValueType then
      begin
        readSI := 1;
        gCnt   := 4;
      end;
      ms := TMemoryStream.Create;
      try
        // inputs are 0-15  (4 sensors per layer * 4 layers)
        // outputs are 16-32 (ditto)
        layer := 0;
        port := Byte(aNum);
        // this can handle both inputs and outputs
        DecodePort(port, layer);
        TDirectCommandBuilder.StartCommand(ctDirectWithReply, gCnt, 0, ms);
        TDirectCommandBuilder.InputRead(layer, TPortId(port), TYPE_KEEP, MODE_KEEP, readSI, 0, ms);
        id := NextSequenceID;
        if Transport.SendStream(id, ms) = ms.Size then
        begin
          if id = Transport.ReceiveMessage(rspData, 500, id) then
          begin
            DebugLog(rspData);
            if (rspData[0] = DIRECT_REPLY_OK) then
            begin
              if aSrc = kRCX_InputValueType then
              begin
                Move(rspData[1], svalue, 4);
                Result := svalue;
              end
              else if aSrc = kRCX_InputBooleanType then
              begin
                bVal := rspData[1];
                Result := bVal;
              end;
              Move(rspData[1], value, 4);
              Result := value;
            end;
          end;
        end;
      finally
        ms.Free;
      end;
    end;
    kRCX_BatteryLevelType : begin     // 34
      Result := BatteryLevel;
    end;
    kRCX_FirmwareVersionType : begin  // 35
      Result := '';
      if not Open then Exit;
      ms := TMemoryStream.Create;
      try
        TDirectCommandBuilder.StartCommand(ctDirectWithReply, 7, 0, ms);
        TDirectCommandBuilder.GetBrickFirmwareVersion(7, 0, ms);
        id := NextSequenceID;
        if Transport.SendStream(id, ms) = ms.Size then
        begin
          if id = Transport.ReceiveMessage(rspData, 50, id) then
          begin
            DebugLog(rspData);
            if (rspData[0] = DIRECT_REPLY_OK) then
            begin
              Result := Trunc(StrToFloatDef(String(PChar(@rspData[1])), 0)*100);
            end;
          end;
        end;
      finally
        ms.Free;
      end;
    end;
    kNXT_I2CBaseValueType..kNXT_I2CMaxValueType : begin
      Result := 0;
//      Result := ReadI2CData(aSrc-kNXT_I2CBaseValueType, aNum);
    end;
  end;
end;

function TEv3Spirit.PollEEPROM(block: Integer): TStrings;
begin
  Result := fMemData;
  fMemData.Clear;
  // TODO: implement some sort of memory polling?
end;

function TEv3Spirit.PollMemory(address, size: Integer): TStrings;
begin
  Result := fMemData;
(*
		public override byte[] ReadVMMemory(int targetSegment, int targetOffset, int offset, int count, bool isHandle)
		{
			int chunksize = 900;
			byte[] buffer = new byte[count];
			if (isHandle && count > chunksize)
			{
				PBrickDevice.ReportError("ReadVMMemory");
			}
			for (int i = 0; i < count; i += chunksize)
			{
				this._readVMMemory(targetSegment, i + targetOffset, i + offset, Math.Min(chunksize, count - i), isHandle, ref buffer);
			}
			return buffer;
		}

		private void _readVMMemory(int targetSegment, int targetOffset, int offset, int count, bool isHandle, ref byte[] buffer)
		{
			lock (this.CasperDevice)
			{
				byte[] command;
				if (isHandle)
				{
					command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, count + 12, 0, new byte[][]
					{
						DirectCommandBuilder.GetProgramStatus(ProgramSlot.UserSlot, 0),
						DirectCommandBuilder.MemoryRead(ProgramSlot.UserSlot, targetSegment, targetOffset, 2, 2),
						DirectCommandBuilder.ReadArrayContent(ProgramSlot.UserSlot, 2, 0, count, 8),
						DirectCommandBuilder.ReadArraySize(ProgramSlot.UserSlot, 2, 4)
					});
				}
				else
				{
					command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, count + 1, 0, new byte[][]
					{
						DirectCommandBuilder.GetProgramStatus(ProgramSlot.UserSlot, 0),
						DirectCommandBuilder.MemoryRead(ProgramSlot.UserSlot, targetSegment, targetOffset, count, 1)
					});
				}
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok)
				{
					ProgramStatus status = (ProgramStatus)reply[1];
					this.UpdateRunningStatus(status);
					if (status == ProgramStatus.Running)
					{
						if (isHandle)
						{
							int actualArraySize = BitConverter.ToInt32(reply, 5);
							if (actualArraySize < count)
							{
								Array.Resize<byte>(ref buffer, actualArraySize);
								count = actualArraySize;
							}
							Array.Copy(reply, 9, buffer, offset, count);
						}
						else
						{
							Array.Copy(reply, 2, buffer, offset, count);
						}
					}
				}
				else
				{
					PBrickDevice.ReportError("read memory.");
				}
			}
		}
*)
end;

function TEv3Spirit.PowerDownTime(aTime: integer): boolean;
var
  ms : TMemoryStream;
  id : Word;
begin
  Result := IsOpen;
  if not Result then Exit;
  ms := TMemoryStream.Create;
  try
    TDirectCommandBuilder.StartCommand(ctDirectNoReply, 0, 0, ms);
    TDirectCommandBuilder.SetSleepMinutes(Byte(aTime), ms);
    id := NextSequenceID;
    Result := Transport.SendStream(id, ms) = ms.Size;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.PrepareBrick: boolean;
begin
  Result := False;
end;

function TEv3Spirit.Scout(bPower: boolean): boolean;
begin
  Result := False;
  if bPower then Exit;
end;

function TEv3Spirit.ScoutNum(aVal: integer): boolean;
begin
  Result := False;
  if aVal = 0 then Exit;
end;

function TEv3Spirit.ScoutRules(motion: TScoutMotion; touch: TScoutTouch;
  light: TScoutLight; time: TScoutScale; fx: TScoutEffects): boolean;
begin
  Result := False;
  if motion = smNone then Exit;
  if touch = stIgnore then Exit;
  if light = slIgnore then Exit;
  if time = ssShort then Exit;
  if fx = seNone then Exit;
end;

function TEv3Spirit.ScoutSound(bSoundEnable, bSoundOff: boolean;
  aNum: TSoundSetNumber): boolean;
begin
  Result := False;
  if bSoundEnable and bSoundOff then Exit;
  if aNum = 0 then Exit;
end;

function TEv3Spirit.SelectDisplay(aSrc, aNumber: integer): boolean;
begin
  Result := False;
  if (aSrc = 0) or (aNumber = 0) then Exit;
end;

function TEv3Spirit.SelectProgram(aProg: integer): boolean;
begin
  Result := Open;
  if not Result then Exit;
end;

function TEv3Spirit.SendMessage(aMsg: integer): boolean;
begin
  Result := DCMessageWrite(0, IntToStr(aMsg));
end;

function TEv3Spirit.SendRawCommand(aCmd: string; bRetry: boolean): string;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
  tmp: string;
  i, len : integer;
  b : Byte;
begin
  Result := '';
  len := Length(aCmd);
  // only even length command strings
  if len mod 2 <> 0 then Exit;

  if not Open then Exit;
  ms := TMemoryStream.Create;
  try
    i := 1;
    while i < len do
    begin
      tmp := '$' + Copy(aCmd, i, 2);
      b := StrToIntDef(tmp, 0);
      ms.Write(b, 1);
      inc(i, 2);
    end;
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 50, id) then
      begin
        Result := '';
        for i := 0 to Length(rspData) - 1 do
        begin
          Result := Result + Format('%2.2x', [rspData[i]]);
        end;
        DebugLog(rspData);
      end;
    end;
  finally
    ms.Free;
  end;
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
begin
  Result := Open;
  if not Result then Exit;
end;

function TEv3Spirit.StopAllTasks: boolean;
begin
  Result := DCStopProgram;
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
begin
  Result := Open;
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
  rom := 0;
  ram := 0;
  Result := IsOpen;
  if not Result then Exit;
end;

function TEv3Spirit.VersionString : string;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
begin
  Result := '';
  if not Open then Exit;
  ms := TMemoryStream.Create;
  try
    TDirectCommandBuilder.StartCommand(ctDirectWithReply, 13, 0, ms);
    TDirectCommandBuilder.GetBrickHardwareVersion(6, 0, ms);
    TDirectCommandBuilder.GetBrickFirmwareVersion(7, 6, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 50, id) then
      begin
        DebugLog(rspData);
        if (rspData[0] = DIRECT_REPLY_OK) then
        begin
          Result := String(PChar(@rspData[1])) + ' / ' +  String(PChar(@rspData[7]));
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.ViewSourceValue(prec, src, value: integer): boolean;
begin
  Result := Open;
  if (prec = 0) or (src = 0) or (value = 0) then Exit;
end;

function TEv3Spirit.DCGetVMState(var state: byte; var clump : byte; var pc : word): boolean;
begin
  Result := False;
end;

function TEv3Spirit.DCSetVMStateEx(var state, clump: byte; var pc: word): boolean;
begin
  Result := False;
end;

function TEv3Spirit.DCSetVMState(const state: byte): boolean;
begin
  Result := False;
end;

function TEv3Spirit.DCGetPropDebugging(var debugging : boolean; var pauseClump: byte;
  var pausePC: Word): boolean;
begin
  Result := False;
end;

function TEv3Spirit.DCSetPropDebugging(const debugging : boolean; const pauseClump: byte;
  const pausePC: Word): boolean;
begin
  Result := False;
end;

function TEv3Spirit.SCRenameFile(const old, new: string; const chkResponse: boolean): boolean;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
  cmd : TCommandType;
begin
  Result := IsOpen;
  if not Result then Exit;
  ms := TMemoryStream.Create;
  try
    cmd := ctDirectNoReply;
    if chkResponse then
    begin
      cmd := ctDirectWithReply;
    end;
    TDirectCommandBuilder.StartCommand(cmd, 0, 0, ms);
    TDirectCommandBuilder.CopyFile(old, new, ms);
    TDirectCommandBuilder.DeleteFile(old, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if chkResponse then
      begin
        if (id = Transport.ReceiveMessage(rspData, 60000, id)) then
        begin
          DebugLog(rspData);
          Result := rspData[0] = DIRECT_REPLY_OK;
        end
        else
          Result := False;
      end
      else
        Result := True;
    end;
  finally
    ms.Free;
  end;
(*
		public override void CopyFile(FileStorageLocation sourceStorageLocation, string sourcePath, FileStorageLocation destinationStorageLocation, string destinationPath)
		{
			string soruceFilePath = PBrickDevice.PrettyPathToBrickPath(sourcePath, sourceStorageLocation);
			string destinationFilePath = PBrickDevice.PrettyPathToBrickPath(destinationPath, destinationStorageLocation);
			byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 0, 0, new byte[][]
			{
				DirectCommandBuilder.CopyFile(soruceFilePath, destinationFilePath)
			});
			lock (this.CasperDevice)
			{
				byte[] reply;
				this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
			}
		}
*)
end;

function TEv3Spirit.GetFullPortName: string;
begin
  Result := fResPort;
end;

function TEv3Spirit.GetNicePortName: string;
var
  i : integer;
begin
  i := Pos('::', fResPort);
  if i > 0 then
    Result := Copy(fResPort, 1, i-1)
  else
    Result := fResPort;
end;

function TEv3Spirit.GetPortName: string;
begin
  Result := FPort;
end;

procedure TEv3Spirit.FlushReceiveBuffer;
var
  rspData : TEV3Data;
begin
  if IsOpen then
  begin
    Transport.ReceiveMessage(rspData, 500, 0);
  end;
end;

procedure TEv3Spirit.SendRawData(Data: array of byte);
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
begin
  if not Open then Exit;
  ms := TMemoryStream.Create;
  try
    ms.Write(Data, Length(Data)*SizeOf(Byte));
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 50, id) then
      begin
        DebugLog(rspData);
      end;
    end;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.SuitableTransport(Tport : IEV3Transport) : boolean;
begin
  Result := true;
  if fBRTransportType <> ttAny then
  begin
  end;
  if Result and (fBRSerialNumber <> '') then
  begin
    Result := Tport.SerialNumber = fBRSerialNumber;
  end;
  if Result and (fBRTransportType = ttTCP) and (fBRIPAddress <> '') then
  begin
  end;
end;

function TEv3Spirit.GetTransport: IEV3Transport;
var
  i : integer;
begin
  if not Assigned(fActiveTransport) then
  begin
    // look for an available transport that matches the
    // desired connection type
    for i := 0 to fAvailableTransports.Count - 1 do
    begin
      fActiveTransport := fAvailableTransports[i] as IEV3Transport;
      if SuitableTransport(fActiveTransport) then
        break;
    end;
  end;
  Result := fActiveTransport;
end;

procedure TEv3Spirit.FreeAllTransports;
begin
  fActiveTransport := nil;
  fAvailableTransports.Clear;
end;

procedure TEv3Spirit.RefreshAvailableTransports;
var
  tmp : string;
begin
  FreeAllTransports;
  // the port tells us what type of transports to look for
  tmp := UpperCase(fResPort);
  if Pos('USB', tmp) = 1 then
  begin
    LoadEV3HIDTransports(fAvailableTransports);
  end
  else if Pos('BTH', tmp) = 1 then
  begin
    LoadEV3BTHTransports(fAvailableTransports);
  end
  else if Pos('TCP', tmp) = 1 then
  begin
    LoadEV3TCPTransports(fAvailableTransports);
  end
  else
  begin
    fAvailableTransports.Add(TEV3NullTransport.Create);
  end;
end;

function TEv3Spirit.NextSequenceID: Word;
begin
  Result := fSequenceID;
  Inc(fSequenceID);
end;

function TEv3Spirit.PlayDownloadCompletedSound: boolean;
var
  ms : TMemoryStream;
  id : Word;
begin
  Result := IsOpen;
  if not Result then Exit;
  if fSoundMuted then
  begin
    Result := False;
    Exit;
  end;
  ms := TMemoryStream.Create;
  try
    TDirectCommandBuilder.StartCommand(ctDirectNoReply, 0, 0, ms);
    TDirectCommandBuilder.DownloadCompleteSound(ms);
    id := NextSequenceID;
    Result := Transport.SendStream(id, ms) = ms.Size;
  finally
    ms.Free;
  end;
end;

function TEv3Spirit.PrettyPathToBrickPath(prettyPath : string; bOnSD : boolean) : string;
var
  rootPath : string;
begin
  Result := prettyPath;
  if (Pos('Projects/', prettyPath) = 1) then
  begin
    if bOnSD then
      rootPath := '../prjs/SD_Card/'
    else
      rootPath := '../prjs/';
    Result := rootPath + Copy(prettyPath, Length('Projects/'), MaxInt);
  end;
  if (Pos('Applications/', prettyPath) = 1) then
  begin
    rootPath := '../apps/';
    Result := rootPath + Copy(prettyPath, Length('Applications/'), MaxInt);;
  end;
end;

function TEv3Spirit.GetEV3StorageStatus(var ramTotal : Cardinal; var ramFree : Cardinal;
  var sdPresent : Byte; var sdTotal : Cardinal; var sdFree : Cardinal;
  var usbPresent : Byte; var usbTotal : Cardinal; var usbFree : Cardinal) : boolean;
var
  ms : TMemoryStream;
  rspData : TEV3Data;
  id : Word;
begin
  ramTotal   := 0;
  ramFree    := 0;
  sdPresent  := 0;
  sdTotal    := 0;
  sdFree     := 0;
  usbPresent := 0;
  usbTotal   := 0;
  usbFree    := 0;
  Result := IsOpen;
  if not Result then Exit;
  // read 26 bytes
  ms := TMemoryStream.Create;
  try
    ms.Clear;
    TDirectCommandBuilder.StartCommand(ctDirectWithReply, 32, 0, ms);
    TDirectCommandBuilder.GetOnBrickStorageStatus(0, 4, ms);
    TDirectCommandBuilder.GetBrickSDCardStatus(8, 12, 16, ms);
    TDirectCommandBuilder.GetBrickUSBStickStatus(20, 24, 28, ms);
    id := NextSequenceID;
    if Transport.SendStream(id, ms) = ms.Size then
    begin
      if id = Transport.ReceiveMessage(rspData, 500, id) then
      begin
        DebugLog(rspData);
        if (rspData[0] = DIRECT_REPLY_OK) then
        begin
          Result := True;
          Move(rspData[1], ramTotal, 4);
          Move(rspData[5], ramFree, 4);
          Move(rspData[9], sdPresent, 1);
          Move(rspData[13], sdTotal, 4);
          Move(rspData[17], sdFree, 4);
          Move(rspData[21], usbPresent, 1);
          Move(rspData[25], usbTotal, 4);
          Move(rspData[29], usbFree, 4);
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

procedure TEv3Spirit.SetupSnapshotTool;
var
  SL : TStringList;
  i : integer;
  bFound : boolean;
  oldBF : string;
  ms : TMemoryStream;
  sdPresent, usbPresent : Byte;
  sdTotal, sdFree, usbTotal, usbFree, ramTotal, ramFree : Cardinal;
begin
  if fSnapshotFolder <> '' then Exit;
  // is there a file called snapshot at /media/card/snapshot/snapshot?
  // is there a file called snapshot at /mnt/ramdisk/prjs/snapshot?
  SL := TStringList.Create;
  try
    bFound := False;
    ListFiles('/media/card/snapshot/*.*', SL);
    for i := 0 to SL.Count - 1 do
    begin
      if Pos('snapshot=', SL[i]) = 1 then
      begin
        bFound := True;
        fSnapshotFolder := '/media/card/snapshot/';
        break;
      end;
    end;
    if not bFound then
    begin
      ListFiles('/mnt/ramdisk/prjs/snapshot/*.*', SL);
      for i := 0 to SL.Count - 1 do
      begin
        if Pos('snapshot=', SL[i]) = 1 then
        begin
          bFound := True;
          fSnapshotFolder := '/mnt/ramdisk/prjs/snapshot/';
          break;
        end;
      end;
    end;
    // if we didn't find it then we need to download it to the EV3
    if not bFound then
    begin
      ramTotal := 0; ramFree := 0;
      sdTotal  := 0; sdFree  := 0;
      usbTotal := 0; usbFree := 0;
      sdPresent := 0; usbPresent := 0;
      GetEV3StorageStatus(ramTotal, ramFree, sdPresent, sdTotal, sdFree, usbPresent, usbTotal, usbFree);
      // do we have enough memory in ramdisk - we need at least 17 kb
      if ramFree > MIN_RAMDISK_SNAPSHOT then
        fSnapshotFolder := '/mnt/ramdisk/prjs/snapshot/'
      else if sdPresent <> 0 then
        fSnapshotFolder := '/media/card/snapshot/'
      else
        fSnapshotFolder := SNAPSHOT_DISABLED;
      if fSnapshotFolder <> SNAPSHOT_DISABLED then
      begin
        oldBF := BrickFolder;
        try
          BrickFolder := fSnapshotFolder;
          DownloadFile(ProgramDir+'snapshot', nftProgram);
        finally
          BrickFolder := oldBF;
        end;
      end;
    end;
  finally
    SL.Free;
  end;
end;

function TEv3Spirit.GetCanCaptureScreen: boolean;
begin
  Result := fSnapshotFolder <> SNAPSHOT_DISABLED;
end;

(*
		private void CheckSensors()
		{
			byte[][] args = new byte[base.Ports.Count<DevicePort>() * 2 + 1][];
			int i = 0;
			int replyIndex = 0;
			lock (base.Ports)
			{
				foreach (DevicePort port in base.Ports)
				{
					args[i++] = DirectCommandBuilder.InputDeviceGetTypeMode(port.LayerNumber, port.PortNumber, (byte)replyIndex, (byte)(replyIndex + 1));
					replyIndex += 2;
				}
				foreach (DevicePort port in base.Ports)
				{
					if (port.DatasetIndex == 0)
					{
						args[i++] = DirectCommandBuilder.SensorRead(port.LayerNumber, port.PortNumber, 0, -1, true, (int)((byte)replyIndex));
						replyIndex += 4;
					}
					else
					{
						byte numReturnValues = port.DatasetIndex + 1;
						args[i++] = DirectCommandBuilder.SensorReadyRead(port.LayerNumber, port.PortNumber, 0, -1, numReturnValues, true, replyIndex);
						replyIndex += (int)(4 * numReturnValues);
					}
				}
				args[i++] = DirectCommandBuilder.GetProgramStatus(ProgramSlot.UserSlot, (byte)replyIndex);
				replyIndex++;
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, replyIndex, 0, args);
				lock (this.CasperDevice)
				{
					byte[] reply;
					bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
					if (ok)
					{
						replyIndex = 1;
						foreach (DevicePort port in base.Ports)
						{
							byte currentSensorType = reply[replyIndex++];
							sbyte currentSensorMode = (sbyte)reply[replyIndex++];
							if (port.Type != currentSensorType || port.Mode != currentSensorMode)
							{
								port.Type = currentSensorType;
								port.Mode = currentSensorMode;
								port.DatasetIndex = 0;
								DetectedHardwareResponse detectedHardwareResponse = new DetectedHardwareResponse();
								detectedHardwareResponse.PortID = port.Name;
								DetectedHardwareResponse arg_1E8_0 = detectedHardwareResponse;
								int num = (int)currentSensorType;
								arg_1E8_0.HardwareID = num.ToString(CultureInfo.InvariantCulture);
								detectedHardwareResponse.ModeID = currentSensorMode;
								detectedHardwareResponse.DataSetIndex = port.DatasetIndex;
								PingBuffer.AddResponse(detectedHardwareResponse);
							}
						}
						List<HardwarePortValue> sensorInfos = new List<HardwarePortValue>();
						foreach (DevicePort port in base.Ports)
						{
							if (port.Type != 126 && port.Type != 100)
							{
								for (int dataset = 0; dataset <= (int)port.DatasetIndex; dataset++)
								{
									double value = (double)BitConverter.ToSingle(reply, replyIndex);
									sensorInfos.Add(new HardwarePortValue
									{
										PortId = port.Name,
										Value = value,
										DataSetIndex = dataset
									});
									replyIndex += 4;
								}
							}
							else
							{
								replyIndex += 4;
							}
						}
						PingBuffer.AddResponse(new LiveSensorResponse
						{
							HardwarePortValues = sensorInfos
						});
						this.UpdateRunningStatus((ProgramStatus)reply[replyIndex++]);
					}
					else
					{
						PBrickDevice.ReportError("AutoId connected hardware.");
					}
				}
			}
		}

*)
(*
		private void InitializePorts()
		{
			int numLayers = 4;
			base.Ports = new List<DevicePort>();
			byte layer = 0;
			while ((int)layer < numLayers)
			{
				string layerString = ((int)(layer + 1)).ToString(CultureInfo.InvariantCulture);
				base.Ports.Add(new DevicePort
				{
					Name = layerString + ".1",
					LayerNumber = layer,
					PortNumber = 0
				});
				base.Ports.Add(new DevicePort
				{
					Name = layerString + ".2",
					LayerNumber = layer,
					PortNumber = 1
				});
				base.Ports.Add(new DevicePort
				{
					Name = layerString + ".3",
					LayerNumber = layer,
					PortNumber = 2
				});
				base.Ports.Add(new DevicePort
				{
					Name = layerString + ".4",
					LayerNumber = layer,
					PortNumber = 3
				});
				base.Ports.Add(new DevicePort
				{
					Name = layerString + ".A",
					LayerNumber = layer,
					PortNumber = 16
				});
				base.Ports.Add(new DevicePort
				{
					Name = layerString + ".B",
					LayerNumber = layer,
					PortNumber = 17
				});
				base.Ports.Add(new DevicePort
				{
					Name = layerString + ".C",
					LayerNumber = layer,
					PortNumber = 18
				});
				base.Ports.Add(new DevicePort
				{
					Name = layerString + ".D",
					LayerNumber = layer,
					PortNumber = 19
				});
				layer += 1;
			}
		}
*)
(*
		public override List<PairedDeviceInfo> PairedDevices()
		{
			List<PairedDeviceInfo> pairedDevices = new List<PairedDeviceInfo>();
			lock (this.CasperDevice)
			{
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 1, 0, new byte[][]
				{
					DirectCommandBuilder.GetFavorItemsCount()
				});
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok && reply[0] == 2)
				{
					byte numItems = reply[1];
					for (byte i = 0; i < numItems; i += 1)
					{
						command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 34, 0, new byte[][]
						{
							DirectCommandBuilder.GetFavorItem(i)
						});
						ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
						if (ok && reply[0] == 2)
						{
							PairedDeviceInfo info = new PairedDeviceInfo();
							string name = Encoding.UTF8.GetString(reply, 1, 30);
							info.Name = name.Substring(0, name.IndexOf('\0'));
							info.Paired = BitConverter.ToBoolean(reply, 31);
							info.Connected = BitConverter.ToBoolean(reply, 32);
							info.DeviceType = (byte)BitConverter.ToChar(reply, 33);
							pairedDevices.Add(info);
						}
					}
				}
			}
			return pairedDevices;
		}
*)
(*
		private const int BrickPollingRate = 200;
		private const int DeviceInfoSkipCount = 5;
		private const string BrickProjectPrefix = "../prjs/";
		private const string BrickSdCardProjectPrefix = "../prjs/SD_Card/";
		private const string BrickApplicationPrefix = "../apps/";
		private PBrickDatalogEngine _pbrickDatalogger;
		private FileStorageLocation _defaultStorageLocation;

		private void UpdateRunningStatus(ProgramStatus currentStatus)
		{
			if (currentStatus == ProgramStatus.Stopped && !string.IsNullOrEmpty(base.ActiveProgramName))
			{
				base.ActiveProgramName = string.Empty;
				PingBuffer.AddResponse(new GetCurrentProgramNameResponse
				{
					FileName = string.Empty
				});
				return;
			}
			if (currentStatus == ProgramStatus.Running && string.IsNullOrEmpty(base.ActiveProgramName))
			{
				base.ActiveProgramName = "UnknownUserProgram";
				PingBuffer.AddResponse(new GetCurrentProgramNameResponse
				{
					FileName = "UnknownUserProgram"
				});
			}
		}

		public override ConnectionResult Connect(string desiredTransport, string passkey)
		{
			this.CasperDevice = PBrickDevice.DiscoveryManager.KnownDevices.FirstOrDefault((CasperDevice device) => device.SerialNumber == base.TheDeviceInfo.SerialNumber);
			if (!string.IsNullOrEmpty(passkey))
			{
				PBrickDevice._bluetoothAuthenticationTokens[this.CasperDevice.SerialNumber] = passkey;
			}
			CasperErrorCode connectionReply = this.CasperDevice.Connect(desiredTransport);
			X3Log.DebugLog.WriteLine("PBR:Result from connection {0}", new object[]
			{
				connectionReply
			});
			CasperErrorCode casperErrorCode = connectionReply;
			if (casperErrorCode == CasperErrorCode.NoError)
			{
				base.TheDeviceInfo.ConnectedTransport = this.CasperDevice.ConnectedTransport;
				X3Log.DebugLog.WriteLine("PBR:Connected over {0} transport", new object[]
				{
					base.TheDeviceInfo.ConnectedTransport
				});
				if (this.CasperDevice.ConnectedTransport == "USB" && !Helpers.IsMac)
				{
					X3Log.DebugLog.WriteLine("PBR:sending BTH authentication token");
					this.SendAuthenticationToken();
					ThreadPool.QueueUserWorkItem(delegate(object param0)
					{
						PBrickDevice.DiscoveryManager.ForceActiveScan(new string[]
						{
							"BTH"
						});
					});
				}
				this.InitializePorts();
				lock (this.CasperDevice)
				{
					X3Log.DebugLog.WriteLine("PBR:Sync clock and get brick name");
					byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 24, 0, new byte[][]
					{
						DirectCommandBuilder.SetDatalogSyncTimeAndTick(0),
						DirectCommandBuilder.GetBrickName(20, 4)
					});
					PendingResponse SendObject = this.CasperDevice.SendMessage(command, true);
					byte[] reply;
					bool ok = SendObject.TryReceiveMessage(out reply);
					if (!ok)
					{
						X3Log.DebugLog.WriteLine("PBR:Unable to get response to initial command");
						return ConnectionResult.ProtocolFailure;
					}
					string name = Encoding.UTF8.GetString(reply.Skip(5).TakeWhile((byte t) => t != 0).ToArray<byte>());
					this.CasperDevice.Name = name;
					X3Log.DebugLog.WriteLine("PBR:current name of brick is {0}", new object[]
					{
						name
					});
				}
				this.StartPollingBrickForStuff();
				this._pbrickDatalogger = new PBrickDatalogEngine(this.CasperDevice);
				X3Log.DebugLog.WriteLine("PBR:Connection successful");
				return ConnectionResult.Success;
			}
			if (casperErrorCode != CasperErrorCode.AuthenticationNeeded)
			{
				return ConnectionResult.ProtocolFailure;
			}
			X3Log.DebugLog.WriteLine("PBR:Pass key needed in order to connect");
			return ConnectionResult.PromptForPasskey;
		}

		public override void GetStorageInfo(ref GetStorageInfoResponse theResponse)
		{
			byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 20, 0, new byte[][]
			{
				DirectCommandBuilder.GetBrickSDCardStatus(0, 4, 8),
				DirectCommandBuilder.GetOnBrickStorageStatus(12, 16)
			});
			byte[] reply;
			bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
			if (ok && reply[0] == 2)
			{
				theResponse.SDCardTotalKB = BitConverter.ToInt32(reply, 5);
				theResponse.SDCardFreeKB = BitConverter.ToInt32(reply, 9);
				theResponse.FlashTotalKB = BitConverter.ToInt32(reply, 13);
				theResponse.FlashFreeKB = BitConverter.ToInt32(reply, 17);
			}
		}

		public override void AddRemovePortHardware(string portID, string inputHardware, sbyte mode, byte datasetIndex)
		{
			lock (base.Ports)
			{
				DevicePort port = base.GetDevicePortByName(portID);
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 4, 0, new byte[][]
				{
					DirectCommandBuilder.SensorReadyRead(port.LayerNumber, port.PortNumber, port.Type, mode, 1, true, 0)
				});
				lock (this.CasperDevice)
				{
					byte[] reply;
					this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				}
				port.Mode = mode;
				port.DatasetIndex = datasetIndex;
				PingBuffer.AddResponse(new DetectedHardwareResponse
				{
					PortID = portID,
					HardwareID = port.Type.ToString(CultureInfo.InvariantCulture),
					ModeID = mode,
					DataSetIndex = datasetIndex
				});
			}
		}
					string token = PBrickDevice.GetAuthenticationToken(serial);
					byte[] commandBytes;
					using (PBrickGenericCommandObject commandsObject = new PBrickGenericCommandObject())
					{
						commandsObject.Write(1);
						commandsObject.Write(159);
						commandsObject.Write((byte)(hostMac.Length + 1));
						commandsObject.Write(Encoding.UTF8.GetBytes(hostMac));
						commandsObject.Write(0);
						commandsObject.Write((byte)(token.Length + 1));
						commandsObject.Write(Encoding.UTF8.GetBytes(token));
						commandsObject.Write(0);
						commandBytes = commandsObject.ToArray();
					}
					byte[] response;
					if (this.CasperDevice.SendMessage(commandBytes, true).TryReceiveMessage(out response) && response[0] == 3)
					{
						byte arg_12D_0 = response[0];
						byte arg_132_0 = response[1];
						byte arg_137_0 = response[2];
						byte arg_13C_0 = response[3];
						byte arg_142_0 = response[17];
						Encoding.UTF8.GetString(response, 4, 12);
						Encoding.UTF8.GetString(response, 18, 4);
					}

}


IMGDATA CLR_LAYER_CLR_CHANGES[]       = { opINPUT_DEVICE,CLR_CHANGES,0,0,opINPUT_DEVICE,CLR_CHANGES,0,1,opINPUT_DEVICE,CLR_CHANGES,0,2,opINPUT_DEVICE,CLR_CHANGES,0,3,opOBJECT_END };
IMGDATA CLR_LAYER_CLR_BUMBED[]        = { opUI_BUTTON,FLUSH,opOBJECT_END };
IMGDATA CLR_LAYER_OUTPUT_RESET[]      = { opOUTPUT_RESET,0,15,opOBJECT_END };
IMGDATA CLR_LAYER_OUTPUT_CLR_COUNT[]  = { opOUTPUT_CLR_COUNT,0,15,opOBJECT_END };
IMGDATA CLR_LAYER_INPUT_WRITE[]       = { opINPUT_WRITE,0,0,1,DEVCMD_RESET,opINPUT_WRITE,0,1,1,DEVCMD_RESET,opINPUT_WRITE,0,2,1,DEVCMD_RESET,opINPUT_WRITE,0,3,1,DEVCMD_RESET,opOBJECT_END };


void      ClrLayer(void)
{
  ExecuteByteCode(CLR_LAYER_CLR_CHANGES,NULL,NULL);
  ExecuteByteCode(CLR_LAYER_CLR_BUMBED,NULL,NULL);
  ExecuteByteCode(CLR_LAYER_OUTPUT_RESET,NULL,NULL);
  ExecuteByteCode(CLR_LAYER_OUTPUT_CLR_COUNT,NULL,NULL);
  ExecuteByteCode(CLR_LAYER_INPUT_WRITE,NULL,NULL);
}

*)

end.
