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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uFakeSpirit;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, AxCtrls, Classes, FakeSpiritLib_TLB, FakeSpirit, StdVcl,
  FantomSpirit;

type
  TOleFakeSpirit = class(TAutoObject, IConnectionPointContainer, IFakeSpirit)
  private
    { Private declarations }
    FConnectionPoints: TConnectionPoints;
    FConnectionPoint: TConnectionPoint;
    FEvents: IFakeSpiritEvents;
    { note: FEvents maintains a *single* event sink. For access to more
      than one event sink, use FConnectionPoint.SinkList, and iterate
      through the list of sinks. }
  public
    procedure Initialize; override;
    procedure HandleOnDownloadStart(Sender : TObject);
    procedure HandleOnDownloadDone(Sender : TObject);
    procedure HandleOnOpenStateChanged(Sender : TObject);
    procedure HandleOnDownloadStatus(Sender : TObject; cur, total : Integer; var Abort : Boolean);
  protected
    { Protected declarations }
    property ConnectionPoints: TConnectionPoints read FConnectionPoints
      implements IConnectionPointContainer;
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    // IFakeSpirit interface
    function AbsVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function AndVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function BatteryLevel: SYSINT; safecall;
    function BrickAlive: WordBool; safecall;
    function CalibrateEvent(enumb, upper, lower, hysteresis: SYSINT): WordBool;
      safecall;
    function CalibrateLightSensor: WordBool; safecall;
    function ClearAllEvents: WordBool; safecall;
    function ClearCounter(num: TAutoCounterNumber): WordBool; safecall;
    function ClearMemory: WordBool; safecall;
    function ClearSensorValue(aNum: SYSINT): WordBool; safecall;
    function ClearSound: WordBool; safecall;
    function ClearTachoCounter(aMotorList: Byte): WordBool; safecall;
    function ClearTimer(aNum: SYSINT): WordBool; safecall;
    function Close: WordBool; safecall;
    function DatalogNext(aSrc, aNum: SYSINT): WordBool; safecall;
    function DecCounter(num: TAutoCounterNumber): WordBool; safecall;
    function DeleteAllSubs: WordBool; safecall;
    function DeleteAllTasks: WordBool; safecall;
    function DeleteSub(aSub: SYSINT): WordBool; safecall;
    function DeleteTask(aTask: SYSINT): WordBool; safecall;
    function DivVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function DownloadFirmware(const aFile: WideString; bFast, bComp,
      bUnlock: WordBool): WordBool; safecall;
    function DownloadMemoryMap: WideString; safecall;
    function Drive(aLeft, aRight: SYSINT): WordBool; safecall;
    function Get_IsOpen: WordBool; safecall;
    function Get_NicePortName: WideString; safecall;
    function Get_PortName: WideString; safecall;
    function Get_BrickType: TAutoBrickType; safecall;
    function GetCounterValue(aNum: SYSINT): SYSINT; safecall;
    function GetInputValue(aIn: SYSINT): SYSINT; safecall;
    function GetMessageValue(aNum: SYSINT): SYSINT; safecall;
    function GetOutputStatus(aOut: SYSINT): SYSINT; safecall;
    function GetTimerValue(aNum: SYSINT): SYSINT; safecall;
    function GetVariableValue(aVar: SYSINT): SYSINT; safecall;
    function IncCounter(num: TAutoCounterNumber): WordBool; safecall;
    function MotorsFloat(aMotorList: Byte): WordBool; safecall;
    function MotorsOff(aMotorList: Byte): WordBool; safecall;
    function MotorsOn(aMotorList: Byte): WordBool; safecall;
    function MulVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function MuteSound: WordBool; safecall;
    function OnWait(aMotorList: Byte; aNum: SYSINT; aTime: Byte): WordBool;
      safecall;
    function OnWaitDifferent(aMotorList: Byte; aNum0, aNum1, aNum2: SYSINT;
      aTime: Byte): WordBool; safecall;
    function Open: WordBool; safecall;
    function OrVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function Ping: WordBool; safecall;
    function PlaySystemSound(aSnd: SYSINT): WordBool; safecall;
    function PlayTone(aFreq, aTime: SYSINT): WordBool; safecall;
    function Poll(aSrc, aNum: SYSINT): SYSINT; safecall;
    function PollEEPROM(Block: SYSINT): WideString; safecall;
    function PollMemory(address, size: SYSINT): WideString; safecall;
    function PowerDownTime(aTime: SYSINT): WordBool; safecall;
    function PrepareBrick: WordBool; safecall;
    function Scout(aVal: SYSINT): WordBool; safecall;
    function ScoutPower(bPower: WordBool): WordBool; safecall;
    function ScoutRules(motion: TAutoScoutMotion; touch: TAutoScoutTouch;
      light: TAutoScoutLight; time: TAutoScoutScale;
      fx: TAutoScoutEffects): WordBool; safecall;
    function ScoutSound(bSoundEnable, bSoundOff: WordBool;
      aNum: TAutoSoundSetNumber): WordBool; safecall;
    function SelectDisplay(aSrc, aNumber: SYSINT): WordBool; safecall;
    function SelectProgram(aProg: SYSINT): WordBool; safecall;
    function SendMessage(aMsg: SYSINT): WordBool; safecall;
    function SendRawCommand(const aCmd: WideString;
      bRetry: WordBool): WideString; safecall;
    function SendRemoteNum(aEvent: SYSUINT; aRepeat: SYSINT): WordBool;
      safecall;
    function SendRemoteStr(const aEvent: WideString;
      aRepeat: SYSINT): WordBool; safecall;
    function SendUARTData(istart, isize: SYSINT): WordBool; safecall;
    function SendVLL(aSrc, aNum: SYSINT): WordBool; safecall;
    function SetCounterLimit(num: TAutoCounterNumber; src: TAutoTCSource;
      val: SYSINT): WordBool; safecall;
    function SetDatalog(aSize: SYSINT): WordBool; safecall;
    function SetEvent(enumb, snumb, etype: SYSINT): WordBool; safecall;
    function SetFeedback(src, val: SYSINT): WordBool; safecall;
    function SetFwd(aMotorList: Byte): WordBool; safecall;
    function SetGlobalDirection(motors: TAutoMotorsNum;
      action: TAutoGlobalDirAction): WordBool; safecall;
    function SetGlobalOutput(motors: TAutoMotorsNum;
      action: TAutoGlobalOutAction): WordBool; safecall;
    function SetLight(bOn: WordBool): WordBool; safecall;
    function SetLightSensorBlinkTime(src: TAutoLSSource;
      val: SYSUINT): WordBool; safecall;
    function SetLightSensorHysteresis(src: TAutoLSSource;
      val: SYSUINT): WordBool; safecall;
    function SetLightSensorLowerThreshold(src: TAutoLSSource;
      val: SYSUINT): WordBool; safecall;
    function SetLightSensorUpperThreshold(src: TAutoLSSource;
      val: SYSUINT): WordBool; safecall;
    function SetMaxPower(motors: TAutoMotorsNum; src, num: SYSINT): WordBool;
      safecall;
    function SetMotorPower(aMotorList: Byte; aSrc, aNum: SYSINT): WordBool;
      safecall;
    function SetRwd(aMotorList: Byte): WordBool; safecall;
    function SetSensorMode(aNum, aMode, aSlope: SYSINT): WordBool; safecall;
    function SetSensorType(aNum, aType: SYSINT): WordBool; safecall;
    function SetSourceValue(DestSrc, DestVal, OrigSrc,
      OrigVal: SYSINT): WordBool; safecall;
    function SetTimerLimit(num: TAutoTimerNumber; src: TAutoTCSource;
      val: SYSINT): WordBool; safecall;
    function SetVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function SetWatchNum(aHrs, aMins: SYSINT): WordBool; safecall;
    function SetWatchStr(const aTime: WideString): WordBool; safecall;
    function SgnVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function Shutdown: WordBool; safecall;
    function Sleep(aVal: SYSINT): WordBool; safecall;
    function StartTask(aTask: SYSINT): WordBool; safecall;
    function StopAllTasks: WordBool; safecall;
    function StopTask(aTask: SYSINT): WordBool; safecall;
    function SubVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function SumVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function SwitchDirection(aMotorList: Byte): WordBool; safecall;
    function TowerExists: WordBool; safecall;
    function TransmitPower(aLevel: TAutoTransmitLevel): WordBool; safecall;
    function UnlockBrick: WideString; safecall;
    function UnlockFirmware: WordBool; safecall;
    function UnmuteSound: WordBool; safecall;
    function UploadDatalog(aFrom, aSize: SYSINT): WideString; safecall;
    function UploadDatalogSimple(bVerbose: WordBool): WideString; safecall;
    function Version(out rom, ram: LongWord): WordBool; safecall;
    function ViewSourceValue(prec, src, Value: SYSINT): WordBool; safecall;
    procedure Set_BrickType(Value: TAutoBrickType); safecall;
    function Get_TowerExistsSleep: Integer; safecall;
    procedure Set_TowerExistsSleep(Value: Integer); safecall;
    function Get_RCXFirmwareChunkSize: Integer; safecall;
    procedure Set_RCXFirmwareChunkSize(Value: Integer); safecall;
    function Get_DownloadWaitTime: Integer; safecall;
    procedure Set_DownloadWaitTime(Value: Integer); safecall;
    function Get_OmitHeader: WordBool; safecall;
    procedure Set_OmitHeader(Value: WordBool); safecall;
    function Get_Datalog: WideString; safecall;
    function Get_MemoryData: WideString; safecall;
    function Get_MemoryMap: WideString; safecall;
    function Get_Port: WideString; safecall;
    procedure Set_Port(const Value: WideString); safecall;
    function MonitorIR(Secs: SYSINT): WideString; safecall;
    function Get_FastMode: WordBool; safecall;
    procedure Set_FastMode(Value: WordBool); safecall;
    function Get_UseBluetooth: WordBool; safecall;
    procedure Set_UseBluetooth(Value: WordBool); safecall;
    function Get_Quiet: WordBool; safecall;
    procedure Set_Quiet(Value: WordBool); safecall;
    function Get_BrickTypeName: WideString; safecall;
    procedure SetEEPROMByte(addr: Byte; value: Byte); safecall;
    function GetEEPROMByte(addr: Byte): Byte; safecall;
    procedure GetEEPROMBlock(idx: Integer; out b1: Byte; out b2: Byte; out b3: Byte;
                             out b4: Byte; out b5: Byte; out b6: Byte;
                             out b7: Byte; out b8: Byte; out b9: Byte;
                             out b10: Byte; out b11: Byte; out b12: Byte;
                             out b13: Byte; out b14: Byte; out b15: Byte;
                             out b16: Byte); safecall;
    function Get_VerboseMode: WordBool; safecall;
    procedure Set_VerboseMode(Value: WordBool); safecall;
    procedure SetNXTLSBlock(port: Byte; TxLen: Byte; RxLen: Byte; b1: Byte; b2: Byte; b3: Byte; 
                            b4: Byte; b5: Byte; b6: Byte; b7: Byte; b8: Byte; b9: Byte; b10: Byte; 
                            b11: Byte; b12: Byte; b13: Byte; b14: Byte; b15: Byte; b16: Byte); safecall;
    procedure GetNXTLSBlock(port: Byte; out RxLen: Byte; out b1: Byte; out b2: Byte; out b3: Byte; 
                            out b4: Byte; out b5: Byte; out b6: Byte; out b7: Byte; out b8: Byte; 
                            out b9: Byte; out b10: Byte; out b11: Byte; out b12: Byte; 
                            out b13: Byte; out b14: Byte; out b15: Byte; out b16: Byte); safecall;
    function StartProgram(const filename: WideString): WordBool; safecall;
    function StopProgram: WordBool; safecall;
    function PlaySoundFile(const filename: WideString; loop: WordBool): WordBool; safecall;
    function GetNXTOutputState(Port: Byte; out power: Integer; out mode: Byte; out regmode: Byte; 
                               out turnratio: Integer; out runstate: Byte; 
                               out tacholimit: LongWord; out tachocount: Integer; 
                               out blocktachocount: Integer; out rotationcount: Integer): WordBool; safecall;
    function SetNXTOutputState(Port: Byte; power: Integer; mode: Byte; regmode: Byte; 
                               turnratio: Integer; runstate: Byte; tacholimit: LongWord): WordBool; safecall;
    function GetNXTInputValues(Port: Byte; out valid: WordBool; out calibrated: WordBool; 
                               out stype: Byte; out smode: Byte; out raw: LongWord; 
                               out normalized: LongWord; out scaled: Smallint; 
                               out calvalue: Smallint): WordBool; safecall;
    function SetNXTInputMode(Port: Byte; stype: Byte; smode: Byte): WordBool; safecall;
    function ResetInputScaledValue(Port: Byte): WordBool; safecall;
    function ResetOutputPosition(Port: Byte; relative: WordBool): WordBool; safecall;
    function MessageWrite(inbox: Byte; const msg: WideString): WordBool; safecall;
    function MessageRead(remote: Byte; remove: WordBool; var local: Byte; out size: Byte; 
                         out msg: WideString): WordBool; safecall;
    function KeepAlive(chkResponse: WordBool; out time: LongWord): WordBool; safecall;
    function LSGetStatus(Port: Byte; out bytesReady: Byte): WordBool; safecall;
    function GetCurrentProgramName(out filename: WideString): WordBool; safecall;
    function GetButtonState(idx: Byte; reset: WordBool; out pressed: WordBool; out count: Byte): WordBool; safecall;
    function NXTOpenRead(const filename: WideString; out handle: LongWord; out size: LongWord): WordBool; safecall;
    function NXTOpenReadLinear(const filename: WideString; out handle: LongWord; out size: LongWord): WordBool; safecall;
    function NXTOpenWrite(const filename: WideString; size: LongWord; out handle: LongWord): WordBool; safecall;
    function NXTOpenWriteLinear(const filename: WideString; size: LongWord; out handle: LongWord): WordBool; safecall;
    function NXTOpenWriteData(const filename: WideString; size: LongWord; out handle: LongWord): WordBool; safecall;
    function NXTOpenAppendData(const filename: WideString; out size: LongWord; out handle: LongWord): WordBool; safecall;
    function NXTRead(var handle: LongWord; var count: Smallint; out buffer: PByte): WordBool; safecall;
    function NXTWrite(var handle: LongWord; buffer: PByte; var count: Smallint; chkResponse: WordBool): WordBool; safecall;
    function NXTCloseFile(var handle: LongWord; chkResponse: WordBool): WordBool; safecall;
    function NXTDeleteFile(var filename: WideString; chkResponse: WordBool): WordBool; safecall;
    function NXTFindFirstFile(var filename: WideString; out handle: LongWord; out size: LongWord): WordBool; safecall;
    function NXTFindNextFile(var handle: LongWord; out filename: WideString; out size: LongWord): WordBool; safecall;
    function NXTGetVersions(out protmin: Byte; out protmaj: Byte; out firmmin: Byte; 
                            out firmmaj: Byte): WordBool; safecall;
    function NXTCloseModuleHandle(var handle: LongWord; chkResponse: WordBool): WordBool; safecall;
    function NXTBootCommand(chkResponse: WordBool): WordBool; safecall;
    function NXTSetBrickName(const name: WideString; chkResponse: WordBool): WordBool; safecall;
    function NXTGetDeviceInfo(out name: WideString; out BTAddress: Byte; out BTSignal: Byte;
                              out FreeMem: LongWord): WordBool; safecall;
    function NXTDeleteUserFlash(chkResponse: WordBool): WordBool; safecall;
    function NXTBTFactoryReset(chkResponse: WordBool): WordBool; safecall;
    function NXTPollCommandLen(bufNum: Byte; out count: Byte): WordBool; safecall;
    function NXTPollCommand(bufNum: Byte; var count: Byte; out aCmd: PByte): WordBool; safecall;
    function NXTWriteIOMap(ModID: LongWord; Offset: Smallint; var count: Smallint; Data: PByte; chkResponse : WordBool): WordBool; safecall;
    function NXTReadIOMap(ModID: LongWord; Offset: Smallint; var count: Smallint; var Data: PByte): WordBool; safecall;
    function NXTFindFirstModule(var ModName: WideString; out handle: LongWord; out ModID: LongWord; 
                                out ModSize: LongWord; out IOMapSize: Smallint): WordBool; safecall;
    function NXTFindNextModule(var handle: LongWord; out ModName: WideString; out ModID: LongWord; 
                               out ModSize: LongWord; out IOMapSize: Smallint): WordBool; safecall;
    function DownloadFile(const filename: WideString; filetype: TAutoNXTFileType): WordBool; safecall;
    function NXTUploadFile(const filename: WideString; const dir: WideString): WordBool; safecall;
    function NXTListFiles(const searchPattern: WideString; out Files: WideString): WordBool; safecall;
    function NXTListModules(const searchPattern: WideString; out Files: WideString): WordBool; safecall;
  end;

implementation

uses ComServ, rcx_link, uSpirit, brick_common;

procedure TOleFakeSpirit.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IFakeSpiritEvents;
end;

procedure TOleFakeSpirit.Initialize;
begin
  inherited Initialize;
  FConnectionPoints := TConnectionPoints.Create(Self);
  if AutoFactory.EventTypeInfo <> nil then
    FConnectionPoint := FConnectionPoints.CreateConnectionPoint(
      AutoFactory.EventIID, ckSingle, EventConnect)
  else FConnectionPoint := nil;
end;

procedure TOleFakeSpirit.HandleOnDownloadStart(Sender : TObject);
begin
  if FEvents <> nil then
    FEvents.OnDownloadStart;
end;

procedure TOleFakeSpirit.HandleOnDownloadDone(Sender: TObject);
begin
  if FEvents <> nil then
    FEvents.OnDownloadDone;
end;

procedure TOleFakeSpirit.HandleOnOpenStateChanged(Sender: TObject);
begin
  if FEvents <> nil then
    FEvents.OnOpenStateChanged;
end;

procedure TOleFakeSpirit.HandleOnDownloadStatus(Sender: TObject; cur,
  total: Integer; var Abort: Boolean);
var
  tmp : WordBool;
begin
  if FEvents <> nil then begin
    tmp := Abort;
    FEvents.OnDownloadStatus(cur, total, tmp);
    Abort := tmp;
  end;
end;

function TOleFakeSpirit.Open: WordBool;
begin
  BrickComm.OnDownloadDone     := HandleOnDownloadDone;
  BrickComm.OnDownloadStart    := HandleOnDownloadStart;
  BrickComm.OnOpenStateChanged := HandleOnOpenStateChanged;
  BrickComm.OnDownloadStatus   := HandleOnDownloadStatus;
  result := BrickComm.Open;
end;

function TOleFakeSpirit.Close: WordBool;
begin
  result := BrickComm.Close;
end;

function TOleFakeSpirit.Get_BrickType: TAutoBrickType;
begin
  result := BrickComm.BrickType;
end;

procedure TOleFakeSpirit.Set_BrickType(Value: TAutoBrickType);
begin
  LocalBrickType := Value;
  BrickComm.BrickType := Value;
end;

function TOleFakeSpirit.Get_PortName: WideString;
begin
  result := BrickComm.PortName;
end;

function TOleFakeSpirit.Get_NicePortName: WideString;
begin
  result := BrickComm.NicePortName;
end;

function TOleFakeSpirit.PlayTone(aFreq, aTime: SYSINT): WordBool;
begin
  result := BrickComm.PlayTone(aFreq, aTime);
end;

function TOleFakeSpirit.BatteryLevel: SYSINT;
begin
  result := BrickComm.BatteryLevel;
end;

function TOleFakeSpirit.BrickAlive: WordBool;
begin
  result := BrickComm.BrickAlive;
end;

function TOleFakeSpirit.ClearSensorValue(aNum: SYSINT): WordBool;
begin
  result := BrickComm.ClearSensorValue(aNum);
end;

function TOleFakeSpirit.DownloadMemoryMap: WideString;
begin
  result := BrickComm.DownloadMemoryMap.Text;
end;

function TOleFakeSpirit.MotorsFloat(aMotorList: Byte): WordBool;
begin
  result := BrickComm.MotorsFloat(aMotorList);
end;

function TOleFakeSpirit.MotorsOff(aMotorList: Byte): WordBool;
begin
  result := BrickComm.MotorsOff(aMotorList);
end;

function TOleFakeSpirit.MotorsOn(aMotorList: Byte): WordBool;
begin
  result := BrickComm.MotorsOn(aMotorList);
end;

function TOleFakeSpirit.Ping: WordBool;
begin
  result := BrickComm.Ping;
end;

function TOleFakeSpirit.PlaySystemSound(aSnd: SYSINT): WordBool;
begin
  result := BrickComm.PlaySystemSound(aSnd);
end;

function TOleFakeSpirit.PowerDownTime(aTime: SYSINT): WordBool;
begin
  result := BrickComm.PowerDownTime(aTime);
end;

function TOleFakeSpirit.PrepareBrick: WordBool;
begin
  result := BrickComm.PrepareBrick;
end;

function TOleFakeSpirit.SetFwd(aMotorList: Byte): WordBool;
begin
  result := BrickComm.SetFwd(aMotorList);
end;

function TOleFakeSpirit.SetMotorPower(aMotorList: Byte; aSrc,
  aNum: SYSINT): WordBool;
begin
  result := BrickComm.SetMotorPower(aMotorList, aSrc, aNum);
end;

function TOleFakeSpirit.SetRwd(aMotorList: Byte): WordBool;
begin
  result := BrickComm.SetRwd(aMotorList);
end;

function TOleFakeSpirit.SetSensorMode(aNum, aMode,
  aSlope: SYSINT): WordBool;
begin
  result := BrickComm.SetSensorMode(aNum, aMode, aSlope);
end;

function TOleFakeSpirit.SetSensorType(aNum, aType: SYSINT): WordBool;
begin
  result := BrickComm.SetSensorType(aNum, aType);
end;

function TOleFakeSpirit.Shutdown: WordBool;
begin
  result := BrickComm.Shutdown;
end;

function TOleFakeSpirit.Sleep(aVal: SYSINT): WordBool;
begin
  result := BrickComm.Sleep(aVal);
end;

function TOleFakeSpirit.SwitchDirection(aMotorList: Byte): WordBool;
begin
  result := BrickComm.SwitchDirection(aMotorList);
end;

function TOleFakeSpirit.TowerExists: WordBool;
begin
  result := BrickComm.TowerExists;
end;

function TOleFakeSpirit.UnlockBrick: WideString;
begin
  result := BrickComm.UnlockBrick;
end;

function TOleFakeSpirit.UnlockFirmware: WordBool;
begin
  result := BrickComm.UnlockFirmware;
end;

function TOleFakeSpirit.Version(out rom, ram: LongWord): WordBool;
begin
  result := BrickComm.Version(rom, ram);
end;

function TOleFakeSpirit.TransmitPower(
  aLevel: TAutoTransmitLevel): WordBool;
begin
  result := BrickComm.TransmitPower(TTransmitLevel(aLevel));
end;

function TOleFakeSpirit.AbsVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.AbsVar(aVar, aSrc, aNum);
end;

function TOleFakeSpirit.AndVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.AndVar(aVar, aSrc, aNum);
end;

function TOleFakeSpirit.CalibrateLightSensor: WordBool;
begin
  result := BrickComm.CalibrateLightSensor;
end;

function TOleFakeSpirit.ClearMemory: WordBool;
begin
  result := BrickComm.ClearMemory;
end;

function TOleFakeSpirit.ClearTachoCounter(aMotorList: Byte): WordBool;
begin
  result := BrickComm.ClearTachoCounter(aMotorList);
end;

function TOleFakeSpirit.ClearTimer(aNum: SYSINT): WordBool;
begin
  result := BrickComm.ClearTimer(aNum);
end;

function TOleFakeSpirit.DatalogNext(aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.DatalogNext(aSrc, aNum);
end;

function TOleFakeSpirit.DeleteAllSubs: WordBool;
begin
  result := BrickComm.DeleteAllSubs;
end;

function TOleFakeSpirit.DeleteAllTasks: WordBool;
begin
  result := BrickComm.DeleteAllTasks;
end;

function TOleFakeSpirit.DeleteSub(aSub: SYSINT): WordBool;
begin
  result := BrickComm.DeleteSub(aSub);
end;

function TOleFakeSpirit.DeleteTask(aTask: SYSINT): WordBool;
begin
  result := BrickComm.DeleteTask(aTask);
end;

function TOleFakeSpirit.DivVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.DivVar(aVar, aSrc, aNum);
end;

function TOleFakeSpirit.DownloadFirmware(const aFile: WideString; bFast,
  bComp, bUnlock: WordBool): WordBool;
begin
  result := BrickComm.DownloadFirmware(aFile, bFast, bComp, bUnlock);
end;

function TOleFakeSpirit.Drive(aLeft, aRight: SYSINT): WordBool;
begin
  result := BrickComm.Drive(aLeft, aRight);
end;

function TOleFakeSpirit.GetCounterValue(aNum: SYSINT): SYSINT;
begin
  result := BrickComm.GetCounterValue(aNum);
end;

function TOleFakeSpirit.GetInputValue(aIn: SYSINT): SYSINT;
begin
  result := BrickComm.GetInputValue(aIn);
end;

function TOleFakeSpirit.GetMessageValue(aNum: SYSINT): SYSINT;
begin
  result := BrickComm.GetMessageValue(aNum);
end;

function TOleFakeSpirit.GetOutputStatus(aOut: SYSINT): SYSINT;
begin
  result := BrickComm.GetOutputStatus(aOut);
end;

function TOleFakeSpirit.GetTimerValue(aNum: SYSINT): SYSINT;
begin
  result := BrickComm.GetTimerValue(aNum);
end;

function TOleFakeSpirit.GetVariableValue(aVar: SYSINT): SYSINT;
begin
  result := BrickComm.GetVariableValue(aVar);
end;

function TOleFakeSpirit.MulVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.MulVar(aVar, aSrc, aNum);
end;

function TOleFakeSpirit.OnWait(aMotorList: Byte; aNum: SYSINT;
  aTime: Byte): WordBool;
begin
  result := BrickComm.OnWait(aMotorList, aNum, aTime);
end;

function TOleFakeSpirit.OnWaitDifferent(aMotorList: Byte; aNum0, aNum1,
  aNum2: SYSINT; aTime: Byte): WordBool;
begin
  result := BrickComm.OnWaitDifferent(aMotorList, aNum0, aNum1, aNum2, aTime);
end;

function TOleFakeSpirit.OrVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.OrVar(aVar, aSrc, aNum);
end;

function TOleFakeSpirit.Poll(aSrc, aNum: SYSINT): SYSINT;
begin
  result := BrickComm.Poll(aSrc, aNum);
end;

function TOleFakeSpirit.Scout(aVal: SYSINT): WordBool;
begin
  result := BrickComm.ScoutNum(aVal);
end;

function TOleFakeSpirit.ScoutPower(bPower: WordBool): WordBool;
begin
  result := BrickComm.Scout(bPower);
end;

function TOleFakeSpirit.SelectDisplay(aSrc, aNumber: SYSINT): WordBool;
begin
  result := BrickComm.SelectDisplay(aSrc, aNumber);
end;

function TOleFakeSpirit.SelectProgram(aProg: SYSINT): WordBool;
begin
  result := BrickComm.SelectProgram(aProg);
end;

function TOleFakeSpirit.SendMessage(aMsg: SYSINT): WordBool;
begin
  result := BrickComm.SendMessage(aMsg);
end;

function TOleFakeSpirit.SendRawCommand(const aCmd: WideString;
  bRetry: WordBool): WideString;
begin
  result := BrickComm.SendRawCommand(aCmd, bRetry);
end;

function TOleFakeSpirit.SendRemoteNum(aEvent: SYSUINT;
  aRepeat: SYSINT): WordBool;
begin
  result := BrickComm.SendRemote(aEvent, aRepeat);
end;

function TOleFakeSpirit.SendRemoteStr(const aEvent: WideString;
  aRepeat: SYSINT): WordBool;
begin
  result := BrickComm.SendRemoteStr(aEvent, aRepeat);
end;

function TOleFakeSpirit.SendVLL(aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.SendVLL(aSrc, aNum);
end;

function TOleFakeSpirit.SetDatalog(aSize: SYSINT): WordBool;
begin
  result := BrickComm.SetDatalog(aSize);
end;

function TOleFakeSpirit.SetFeedback(src, val: SYSINT): WordBool;
begin
  result := BrickComm.SetFeedback(src, val);
end;

function TOleFakeSpirit.SetLightSensorHysteresis(src: TAutoLSSource;
  val: SYSUINT): WordBool;
begin
  result := BrickComm.SetLightSensorHysteresis(TLSSource(src), val);
end;

function TOleFakeSpirit.SetLightSensorLowerThreshold(src: TAutoLSSource;
  val: SYSUINT): WordBool;
begin
  result := BrickComm.SetLightSensorLowerThreshold(TLSSource(src), val);
end;

function TOleFakeSpirit.SetLightSensorUpperThreshold(src: TAutoLSSource;
  val: SYSUINT): WordBool;
begin
  result := BrickComm.SetLightSensorUpperThreshold(TLSSource(src), val);
end;

function TOleFakeSpirit.SetVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.SetVar(aVar, aSrc, aNum);
end;

function TOleFakeSpirit.SetWatchNum(aHrs, aMins: SYSINT): WordBool;
begin
  result := BrickComm.SetWatchHHMM(aHrs, aMins);
end;

function TOleFakeSpirit.SetWatchStr(const aTime: WideString): WordBool;
begin
  result := BrickComm.SetWatch(aTime);
end;

function TOleFakeSpirit.SgnVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.SgnVar(aVar, aSrc, aNum);
end;

function TOleFakeSpirit.StartTask(aTask: SYSINT): WordBool;
begin
  result := BrickComm.StartTask(aTask);
end;

function TOleFakeSpirit.StopAllTasks: WordBool;
begin
  result := BrickComm.StopAllTasks;
end;

function TOleFakeSpirit.StopTask(aTask: SYSINT): WordBool;
begin
  result := BrickComm.StopTask(aTask);
end;

function TOleFakeSpirit.SubVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.SubVar(aVar, aSrc, aNum);
end;

function TOleFakeSpirit.SumVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.SumVar(aVar, aSrc, aNum);
end;

function TOleFakeSpirit.UploadDatalog(aFrom, aSize: SYSINT): WideString;
begin
  result := BrickComm.UploadPartialDatalog(aFrom, aSize).Text;
end;

function TOleFakeSpirit.UploadDatalogSimple(bVerbose: WordBool): WideString;
begin
  result := BrickComm.UploadDatalog(bVerbose).Text;
end;

function TOleFakeSpirit.CalibrateEvent(enumb, upper, lower,
  hysteresis: SYSINT): WordBool;
begin
  result := BrickComm.CalibrateEvent(enumb, upper, lower, hysteresis);
end;

function TOleFakeSpirit.ClearAllEvents: WordBool;
begin
  result := BrickComm.ClearAllEvents;
end;

function TOleFakeSpirit.ClearCounter(num: TAutoCounterNumber): WordBool;
begin
  result := BrickComm.ClearCounter(num);
end;

function TOleFakeSpirit.ClearSound: WordBool;
begin
  result := BrickComm.ClearSound;
end;

function TOleFakeSpirit.DecCounter(num: TAutoCounterNumber): WordBool;
begin
  result := BrickComm.DecCounter(num);
end;

function TOleFakeSpirit.IncCounter(num: TAutoCounterNumber): WordBool;
begin
  result := BrickComm.IncCounter(num);
end;

function TOleFakeSpirit.MuteSound: WordBool;
begin
  result := BrickComm.MuteSound;
end;

function TOleFakeSpirit.PollMemory(address, size: SYSINT): WideString;
begin
  result := BrickComm.PollMemory(address, size).Text;
end;

function TOleFakeSpirit.SetLight(bOn: WordBool): WordBool;
begin
  result := BrickComm.SetLight(bOn);
end;

function TOleFakeSpirit.ScoutRules(motion: TAutoScoutMotion;
  touch: TAutoScoutTouch; light: TAutoScoutLight; time: TAutoScoutScale;
  fx: TAutoScoutEffects): WordBool;
begin
  result := BrickComm.ScoutRules(TScoutMotion(motion), TScoutTouch(touch),
    TScoutLight(light), TScoutScale(time), TScoutEffects(fx));
end;

function TOleFakeSpirit.ScoutSound(bSoundEnable, bSoundOff: WordBool;
  aNum: TAutoSoundSetNumber): WordBool;
begin
  result := BrickComm.ScoutSound(bSoundEnable, bSoundOff, aNum);
end;

function TOleFakeSpirit.SendUARTData(istart, isize: SYSINT): WordBool;
begin
  result := BrickComm.SendUARTData(istart, isize);
end;

function TOleFakeSpirit.SetCounterLimit(num: TAutoCounterNumber;
  src: TAutoTCSource; val: SYSINT): WordBool;
begin
  result := BrickComm.SetCounterLimit(num, TTCSource(src), val);
end;

function TOleFakeSpirit.SetEvent(enumb, snumb, etype: SYSINT): WordBool;
begin
  result := BrickComm.SetEvent(enumb, snumb, etype);
end;

function TOleFakeSpirit.SetGlobalDirection(motors: TAutoMotorsNum;
  action: TAutoGlobalDirAction): WordBool;
begin
  result := BrickComm.SetGlobalDirection(motors, TGlobalDirAction(action));
end;

function TOleFakeSpirit.SetGlobalOutput(motors: TAutoMotorsNum;
  action: TAutoGlobalOutAction): WordBool;
begin
  result := BrickComm.SetGlobalOutput(motors, TGlobalOutAction(action));
end;

function TOleFakeSpirit.SetLightSensorBlinkTime(src: TAutoLSSource;
  val: SYSUINT): WordBool;
begin
  result := BrickComm.SetLightSensorBlinkTime(TLSSource(src), val);
end;

function TOleFakeSpirit.SetMaxPower(motors: TAutoMotorsNum; src,
  num: SYSINT): WordBool;
begin
  result := BrickComm.SetMaxPower(motors, src, num);
end;

function TOleFakeSpirit.SetTimerLimit(num: TAutoTimerNumber;
  src: TAutoTCSource; val: SYSINT): WordBool;
begin
  result := BrickComm.SetTimerLimit(num, TTCSource(src), val);
end;

function TOleFakeSpirit.UnmuteSound: WordBool;
begin
  result := BrickComm.UnmuteSound;
end;

function TOleFakeSpirit.ViewSourceValue(prec, src,
  Value: SYSINT): WordBool;
begin
  result := BrickComm.ViewSourceValue(prec, src, value);
end;

function TOleFakeSpirit.Get_IsOpen: WordBool;
begin
  result := BrickComm.IsOpen;
end;

function TOleFakeSpirit.SetSourceValue(DestSrc, DestVal, OrigSrc,
  OrigVal: SYSINT): WordBool;
begin
  result := BrickComm.SetSourceValue(DestSrc, DestVal, OrigSrc, OrigVal);
end;

function TOleFakeSpirit.PollEEPROM(Block: SYSINT): WideString;
begin
  Result := BrickComm.PollEEPROM(Block).Text;
end;

function TOleFakeSpirit.Get_Datalog: WideString;
begin
  Result := BrickComm.DataLog.Text;
end;

function TOleFakeSpirit.Get_DownloadWaitTime: Integer;
begin
  Result := BrickComm.DownloadWaitTime;
end;

function TOleFakeSpirit.Get_MemoryData: WideString;
begin
  Result := BrickComm.MemoryData.Text;
end;

function TOleFakeSpirit.Get_MemoryMap: WideString;
begin
  Result := BrickComm.MemoryMap.Text;
end;

function TOleFakeSpirit.Get_OmitHeader: WordBool;
begin
  Result := BrickComm.OmitHeader;
end;

function TOleFakeSpirit.Get_RCXFirmwareChunkSize: Integer;
begin
  Result := BrickComm.RCXFirmwareChunkSize;
end;

function TOleFakeSpirit.Get_TowerExistsSleep: Integer;
begin
  Result := BrickComm.TowerExistsSleep;
end;

procedure TOleFakeSpirit.Set_DownloadWaitTime(Value: Integer);
begin
  BrickComm.DownloadWaitTime := Value;
end;

procedure TOleFakeSpirit.Set_OmitHeader(Value: WordBool);
begin
  BrickComm.OmitHeader := Value;
end;

procedure TOleFakeSpirit.Set_RCXFirmwareChunkSize(Value: Integer);
begin
  BrickComm.RCXFirmwareChunkSize := Value;
end;

procedure TOleFakeSpirit.Set_TowerExistsSleep(Value: Integer);
begin
  BrickComm.TowerExistsSleep := Value;
end;

function TOleFakeSpirit.Get_Port: WideString;
begin
  Result := BrickComm.Port;
end;

procedure TOleFakeSpirit.Set_Port(const Value: WideString);
begin
  BrickComm.Port := Value;
end;

function TOleFakeSpirit.MonitorIR(Secs: SYSINT): WideString;
begin
  Result := BrickComm.MonitorIR(Secs).Text;
end;

function TOleFakeSpirit.Get_FastMode: WordBool;
begin
  Result := BrickComm.FastMode;
end;

function TOleFakeSpirit.Get_Quiet: WordBool;
begin
  Result := BrickComm.Quiet;
end;

function TOleFakeSpirit.Get_UseBluetooth: WordBool;
begin
  Result := BrickComm.UseBluetooth;
end;

procedure TOleFakeSpirit.Set_FastMode(Value: WordBool);
begin
  BrickComm.FastMode := Value;
end;

procedure TOleFakeSpirit.Set_Quiet(Value: WordBool);
begin
  BrickComm.Quiet := Value;
end;

procedure TOleFakeSpirit.Set_UseBluetooth(Value: WordBool);
begin
  BrickComm.UseBluetooth := Value;
end;

function TOleFakeSpirit.Get_BrickTypeName: WideString;
begin
  Result := BrickComm.BrickTypeName;
end;

function TOleFakeSpirit.Get_VerboseMode: WordBool;
begin
  Result := BrickComm.VerboseMode;
end;

procedure TOleFakeSpirit.GetEEPROMBlock(idx: Integer; out b1, b2, b3, b4,
  b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16: Byte);
var
  Block : EEPROMBlock;
begin
  Block := BrickComm.EEPROMBlock[idx];
  b1  := Block.Data[0];
  b2  := Block.Data[1];
  b3  := Block.Data[2];
  b4  := Block.Data[3];
  b5  := Block.Data[4];
  b6  := Block.Data[5];
  b7  := Block.Data[6];
  b8  := Block.Data[7];
  b9  := Block.Data[8];
  b10 := Block.Data[9];
  b11 := Block.Data[10];
  b12 := Block.Data[11];
  b13 := Block.Data[12];
  b14 := Block.Data[13];
  b15 := Block.Data[14];
  b16 := Block.Data[15];
end;

function TOleFakeSpirit.GetEEPROMByte(addr: Byte): Byte;
begin
  Result := BrickComm.EEPROM[addr];
end;

procedure TOleFakeSpirit.Set_VerboseMode(Value: WordBool);
begin
  BrickComm.VerboseMode := Value;
end;

procedure TOleFakeSpirit.SetEEPROMByte(addr, value: Byte);
begin
  BrickComm.EEPROM[addr] := value;
end;

procedure TOleFakeSpirit.GetNXTLSBlock(port: Byte; out RxLen, b1, b2, b3,
  b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16: Byte);
var
  Block : NXTLSBlock;
begin
  Block := BrickComm.NXTLowSpeed[port];
  RxLen := Block.RXCount;
  b1 :=  Block.Data[0];
  b2 :=  Block.Data[1];
  b3 :=  Block.Data[2];
  b4 :=  Block.Data[3];
  b5 :=  Block.Data[4];
  b6 :=  Block.Data[5];
  b7 :=  Block.Data[6];
  b8 :=  Block.Data[7];
  b9 :=  Block.Data[8];
  b10 := Block.Data[9];
  b11 := Block.Data[10];
  b12 := Block.Data[11];
  b13 := Block.Data[12];
  b14 := Block.Data[13];
  b15 := Block.Data[14];
  b16 := Block.Data[15];
end;

procedure TOleFakeSpirit.SetNXTLSBlock(port, TxLen, RxLen, b1, b2, b3, b4,
  b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16: Byte);
var
  Block : NXTLSBlock;
begin
  Block.TXCount := TxLen;
  Block.RXCount := RxLen;
  Block.Data[0]  := b1;
  Block.Data[1]  := b2;
  Block.Data[2]  := b3;
  Block.Data[3]  := b4;
  Block.Data[4]  := b5;
  Block.Data[5]  := b6;
  Block.Data[6]  := b7;
  Block.Data[7]  := b8;
  Block.Data[8]  := b9;
  Block.Data[9]  := b10;
  Block.Data[10] := b11;
  Block.Data[11] := b12;
  Block.Data[12] := b13;
  Block.Data[13] := b14;
  Block.Data[14] := b15;
  Block.Data[15] := b16;
  BrickComm.NXTLowSpeed[port] := Block;
end;

function TOleFakeSpirit.GetButtonState(idx: Byte; reset: WordBool;
  out pressed: WordBool; out count: Byte): WordBool;
var
  tmpPressed : Boolean;
begin
  Result := BrickComm.GetButtonState(idx, reset, tmpPressed, count);
  pressed := tmpPressed;
end;

function TOleFakeSpirit.GetCurrentProgramName(out filename: WideString): WordBool;
var
  tmpFilename : string;
begin
  Result := BrickComm.GetCurrentProgramName(tmpFilename);
  filename := tmpFilename;
end;

function TOleFakeSpirit.GetNXTInputValues(Port: Byte; out valid,
  calibrated: WordBool; out stype, smode: Byte; out raw,
  normalized: LongWord; out scaled, calvalue: Smallint): WordBool;
var
  bValid, bCalibrated : Boolean;
  wRaw, wNorm : Word;
begin
  Result := BrickComm.GetNXTInputValues(Port, bValid, bCalibrated, stype,
    smode, wRaw, wNorm, scaled, calvalue);
  valid := bValid;
  calibrated := bCalibrated;
  raw := wRaw;
  normalized := wNorm;
end;

function TOleFakeSpirit.GetNXTOutputState(Port: Byte; out power: Integer;
  out mode, regmode: Byte; out turnratio: Integer; out runstate: Byte;
  out tacholimit: LongWord; out tachocount, blocktachocount,
  rotationcount: Integer): WordBool;
begin
  Result := BrickComm.GetNXTOutputState(Port, power, mode, regmode, turnratio,
    runstate, tacholimit, tachocount, blocktachocount, rotationcount);
end;

function TOleFakeSpirit.KeepAlive(chkResponse: WordBool;
  out time: LongWord): WordBool;
begin
  Result := BrickComm.KeepAlive(time, chkResponse);
end;

function TOleFakeSpirit.LSGetStatus(Port: Byte;
  out bytesReady: Byte): WordBool;
begin
  Result := BrickComm.LSGetStatus(Port, bytesReady);
end;

function TOleFakeSpirit.MessageRead(remote: Byte; remove: WordBool;
  var local: Byte; out size: Byte; out msg: WideString): WordBool;
var
  MsgRec : NXTMessage;
  tmpStr : string;
  i : integer;
begin
  Result := BrickComm.MessageRead(remote, local, remove, MsgRec);
  local := MsgRec.Inbox;
  size := MsgRec.Size;
  tmpStr := '';
  for i := Low(MsgRec.Data) to High(MsgRec.Data) do
    tmpStr := tmpStr + Chr(MsgRec.Data[i]);
  msg := tmpStr;
end;

function TOleFakeSpirit.MessageWrite(inbox: Byte; const msg: WideString): WordBool;
begin
  Result := BrickComm.MessageWrite(inbox, msg);
end;

function TOleFakeSpirit.NXTBootCommand(chkResponse: WordBool): WordBool;
begin
  Result := BrickComm.NXTBootCommand(chkResponse);
end;

function TOleFakeSpirit.NXTBTFactoryReset(chkResponse: WordBool): WordBool;
begin
  Result := BrickComm.NXTBTFactoryReset(chkResponse);
end;

function TOleFakeSpirit.NXTCloseFile(var handle: LongWord;
  chkResponse: WordBool): WordBool;
begin
  Result := BrickComm.NXTCloseFile(handle, chkResponse);
end;

function TOleFakeSpirit.NXTCloseModuleHandle(var handle: LongWord;
  chkResponse: WordBool): WordBool;
begin
  Result := BrickComm.NXTCloseModuleHandle(handle, chkResponse);
end;

function TOleFakeSpirit.NXTDeleteFile(var filename: WideString;
  chkResponse: WordBool): WordBool;
var
  tmpFilename : string;
begin
  tmpFilename := filename;
  Result := BrickComm.NXTDeleteFile(tmpFilename);
  filename := tmpFilename;
end;

function TOleFakeSpirit.NXTDeleteUserFlash(chkResponse: WordBool): WordBool;
begin
  Result := BrickComm.NXTDeleteUserFlash(chkResponse);
end;

function TOleFakeSpirit.NXTUploadFile(const filename: WideString; const dir: WideString): WordBool;
begin
  Result := BrickComm.NXTUploadFile(filename, dir);
end;

function TOleFakeSpirit.NXTFindFirstFile(var filename: WideString;
  out handle: LongWord; out size : LongWord): WordBool;
var
  tmpFilename : string;
begin
  tmpFilename := filename;
  Result := BrickComm.NXTFindFirstFile(tmpFilename, handle, size);
  filename := tmpFilename;
end;

function TOleFakeSpirit.NXTFindFirstModule(var ModName: WideString;
  out handle: LongWord; out ModID, ModSize: LongWord;
  out IOMapSize: Smallint): WordBool;
var
  tmpModName : string;
  wIOMapSize : word;
begin
  tmpModName := ModName;
  Result := BrickComm.NXTFindFirstModule(tmpModName, handle, ModID, ModSize, wIOMapSize);
  ModName := tmpModName;
  IOMapSize := wIOMapSize;
end;

function TOleFakeSpirit.NXTFindNextFile(var handle: LongWord;
  out filename: WideString; out size: LongWord): WordBool;
var
  tmpFilename : string;
begin
  Result := BrickComm.NXTFindNextFile(handle, tmpFilename, size);
  filename := tmpFilename;
end;

function TOleFakeSpirit.NXTFindNextModule(var handle: LongWord;
  out ModName: WideString; out ModID, ModSize: LongWord;
  out IOMapSize: Smallint): WordBool;
var
  tmpModName : string;
  wIOMapSize : Word;
begin
  tmpModName := ModName;
  Result := BrickComm.NXTFindNextModule(handle, tmpModName, ModID, ModSize,
    wIOMapSize);
  ModName := tmpModName;
  IOMapSize := wIOMapSize;
end;

function TOleFakeSpirit.NXTGetDeviceInfo(out name: WideString; out BTAddress: Byte;
  out BTSignal: Byte; out FreeMem: LongWord): WordBool;
var
  tmpName : string;
  tmpBTAddr : byte;
  tmpBTSig : byte;
  tmpFreeMem : Cardinal;
begin
  tmpName   := '';
//  Result    := BrickComm.NXTGetDeviceInfo(tmpName, tmpBTAddr, tmpBTSig, tmpFreeMem);
  name      := tmpName;
  BTAddress := tmpBTAddr;
  BTSignal  := tmpBTSig;
  FreeMem   := tmpFreeMem;
end;

function TOleFakeSpirit.NXTGetVersions(out protmin, protmaj, firmmin,
  firmmaj: Byte): WordBool;
begin
  Result := BrickComm.NXTGetVersions(protmin, protmaj, firmmin, firmmaj);
end;

function TOleFakeSpirit.NXTListFiles(const searchPattern: WideString;
  out Files: WideString): WordBool;
var
  SL : TStringList;
begin
  SL := TStringList.Create;
  try
    Result := BrickComm.NXTListFiles(searchPattern, SL);
    Files := SL.Text;
  finally
    SL.Free;
  end;
end;

function TOleFakeSpirit.NXTOpenAppendData(const filename: WideString;
  out size: LongWord; out handle: LongWord): WordBool;
begin
  Result := BrickComm.NXTOpenAppendData(filename, size, handle);
end;

function TOleFakeSpirit.NXTOpenRead(const filename: WideString;
  out handle: LongWord; out size: LongWord): WordBool;
begin
  Result := BrickComm.NXTOpenRead(filename, handle, size);
end;

function TOleFakeSpirit.NXTOpenReadLinear(const filename: WideString;
  out handle: LongWord; out size: LongWord): WordBool;
begin
  Result := BrickComm.NXTOpenReadLinear(filename, handle, size);
end;

function TOleFakeSpirit.NXTOpenWrite(const filename: WideString;
  size: LongWord; out handle: LongWord): WordBool;
begin
  Result := BrickComm.NXTOpenWrite(filename, size, handle);
end;

function TOleFakeSpirit.NXTOpenWriteData(const filename: WideString;
  size: LongWord; out handle: LongWord): WordBool;
begin
  Result := BrickComm.NXTOpenWriteData(filename, size, handle);
end;

function TOleFakeSpirit.NXTOpenWriteLinear(const filename: WideString;
  size: LongWord; out handle: LongWord): WordBool;
begin
  Result := BrickComm.NXTOpenWriteLinear(filename, size, handle);
end;

function TOleFakeSpirit.NXTPollCommand(bufNum: Byte; var count: Byte;
  out aCmd: PByte): WordBool;
var
  buffer : NXTDataBuffer;
begin
  Result := BrickComm.NXTPollCommand(bufNum, count, buffer);
  aCmd := @buffer.Data[0];
end;

function TOleFakeSpirit.NXTPollCommandLen(bufNum: Byte;
  out count: Byte): WordBool;
begin
  Result := BrickComm.NXTPollCommandLen(bufNum, count)
end;

function TOleFakeSpirit.NXTRead(var handle: LongWord; var count: Smallint;
  out buffer: PByte): WordBool;
var
  wCount : Word;
  buf : NXTDataBuffer;
begin
  wCount := count;
  Result := BrickComm.NXTRead(handle, wCount, buf);
  buffer := @buf.Data[0];
  count := wCount;
end;

function TOleFakeSpirit.NXTReadIOMap(ModID: LongWord; Offset: Smallint;
  var count: Smallint; var Data: PByte): WordBool;
var
  wCount : Word;
  buf : NXTDataBuffer;
begin
  wCount := count;
  Result := BrickComm.NXTReadIOMap(ModID, Offset, wCount, buf);
  Data := @buf.Data[0];
  count := wCount;
end;

function TOleFakeSpirit.NXTSetBrickName(const name: WideString;
  chkResponse: WordBool): WordBool;
begin
  Result := BrickComm.NXTSetBrickName(name, chkResponse);
end;

function TOleFakeSpirit.DownloadFile(const filename: WideString;
  filetype: TAutoNXTFileType): WordBool;
begin
  Result := BrickComm.DownloadFile(filename, TNXTFileType(filetype));
end;

function TOleFakeSpirit.NXTWrite(var handle : LongWord; buffer: PByte;
  var count: Smallint; chkResponse: WordBool): WordBool;
var
  wCount : Word;
  buf : NXTDataBuffer;
begin
  wCount := count;
  Move(buffer^, buf.Data[0], count);
  Result := BrickComm.NXTWrite(handle, buf, wCount, chkResponse);
  count := wCount;
end;

function TOleFakeSpirit.NXTWriteIOMap(ModID: LongWord; Offset: Smallint;
  var count: Smallint; Data: PByte; chkResponse : WordBool): WordBool;
var
  wCount : Word;
  buf : NXTDataBuffer;
begin
  wCount := count;
  Move(Data^, buf.Data[0], count);
  Result := BrickComm.NXTWriteIOMap(ModID, Offset, wCount, buf, chkResponse);
  count := wCount;
end;

function TOleFakeSpirit.PlaySoundFile(const filename: WideString;
  loop: WordBool): WordBool;
begin
  Result := BrickComm.PlaySoundFile(filename, loop);
end;

function TOleFakeSpirit.ResetInputScaledValue(Port: Byte): WordBool;
begin
  Result := BrickComm.ResetInputScaledValue(Port);
end;

function TOleFakeSpirit.ResetOutputPosition(Port: Byte;
  relative: WordBool): WordBool;
begin
  Result := BrickComm.ResetOutputPosition(Port, relative);
end;

function TOleFakeSpirit.SetNXTInputMode(Port, stype,
  smode: Byte): WordBool;
begin
  Result := BrickComm.SetNXTInputMode(Port, stype, smode);
end;

function TOleFakeSpirit.SetNXTOutputState(Port: Byte; power: Integer; mode,
  regmode: Byte; turnratio: Integer; runstate: Byte;
  tacholimit: LongWord): WordBool;
begin
  Result := BrickComm.SetNXTOutputState(Port, power, mode, regmode, turnratio,
  runstate, tacholimit);
end;

function TOleFakeSpirit.StartProgram(const filename: WideString): WordBool;
begin
  Result := BrickComm.StartProgram(filename);
end;

function TOleFakeSpirit.StopProgram: WordBool;
begin
  Result := BrickComm.StopProgram;
end;

function TOleFakeSpirit.NXTListModules(const searchPattern: WideString;
  out Files: WideString): WordBool;
var
  SL : TStringList;
begin
  SL := TStringList.Create;
  try
    Result := BrickComm.NXTListModules(searchPattern, SL);
    Files := SL.Text;
  finally
    SL.Free;
  end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TOleFakeSpirit, Class_FakeSpirit,
    ciSingleInstance, tmApartment);
end.