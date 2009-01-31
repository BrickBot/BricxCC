unit uBricxCCSpirit;

interface

uses
  ComObj, ActiveX, AxCtrls, BricxCC_TLB, StdVcl, FakeSpirit, Classes, Windows;

type
  TBricxCCSpirit = class(TAutoObject, IConnectionPointContainer, IBricxCCSpirit)
  private
    { Private declarations }
    FConnectionPoints: TConnectionPoints;
    FConnectionPoint: TConnectionPoint;
    FSinkList: TList;
    FEvents: IBricxCCSpiritEvents;
  protected
    property ConnectionPoints: TConnectionPoints read FConnectionPoints
      implements IConnectionPointContainer;
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    function Open: WordBool; safecall;
    function Close: WordBool; safecall;
    function Get_BrickType: TAutoBrickType; safecall;
    procedure Set_BrickType(Value: TAutoBrickType); safecall;
    function Get_PortName: WideString; safecall;
    function Get_NicePortName: WideString; safecall;
    function PlayTone(aFreq, aTime: SYSINT): WordBool; safecall;
    function BatteryLevel: SYSINT; safecall;
    function BrickAlive: WordBool; safecall;
    function ClearSensorValue(aNum: SYSINT): WordBool; safecall;
    function DownloadMemoryMap: WideString; safecall;
    function MotorsFloat(aMotorList: Byte): WordBool; safecall;
    function MotorsOff(aMotorList: Byte): WordBool; safecall;
    function MotorsOn(aMotorList: Byte): WordBool; safecall;
    function Ping: WordBool; safecall;
    function PlaySystemSound(aSnd: SYSINT): WordBool; safecall;
    function PowerDownTime(aTime: SYSINT): WordBool; safecall;
    function PrepareBrick: WordBool; safecall;
    function SetFwd(aMotorList: Byte): WordBool; safecall;
    function SetMotorPower(aMotorList: Byte; aSrc, aNum: SYSINT): WordBool;
      safecall;
    function SetRwd(aMotorList: Byte): WordBool; safecall;
    function SetSensorMode(aNum, aMode, aSlope: SYSINT): WordBool; safecall;
    function SetSensorType(aNum, aType: SYSINT): WordBool; safecall;
    function Shutdown: WordBool; safecall;
    function Sleep(aVal: SYSINT): WordBool; safecall;
    function SwitchDirection(aMotorList: Byte): WordBool; safecall;
    function TowerExists: WordBool; safecall;
    function UnlockBrick: WideString; safecall;
    function UnlockFirmware: WordBool; safecall;
    function Version(out rom, ram: LongWord): WordBool; safecall;
    function TransmitPower(aLevel: TAutoTransmitLevel): WordBool; safecall;
    function AbsVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function AndVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function CalibrateLightSensor: WordBool; safecall;
    function ClearMemory: WordBool; safecall;
    function ClearTachoCounter(aMotorList: Byte): WordBool; safecall;
    function ClearTimer(aNum: SYSINT): WordBool; safecall;
    function DatalogNext(aSrc, aNum: SYSINT): WordBool; safecall;
    function DeleteAllSubs: WordBool; safecall;
    function DeleteAllTasks: WordBool; safecall;
    function DeleteSub(aSub: SYSINT): WordBool; safecall;
    function DeleteTask(aTask: SYSINT): WordBool; safecall;
    function DivVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function DownloadFirmware(const aFile: WideString; bFast, bComp,
      bUnlock: WordBool): WordBool; safecall;
    function Drive(aLeft, aRight: SYSINT): WordBool; safecall;
    function GetCounterValue(aNum: SYSINT): SYSINT; safecall;
    function GetInputValue(aIn: SYSINT): SYSINT; safecall;
    function GetMessageValue(aNum: SYSINT): SYSINT; safecall;
    function GetOutputStatus(aOut: SYSINT): SYSINT; safecall;
    function GetTimerValue(aNum: SYSINT): SYSINT; safecall;
    function GetVariableValue(aVar: SYSINT): SYSINT; safecall;
    function MulVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function OnWait(aMotorList: Byte; aNum: SYSINT; aTime: Byte): WordBool;
      safecall;
    function OnWaitDifferent(aMotorList: Byte; aNum0, aNum1, aNum2: SYSINT;
      aTime: Byte): WordBool; safecall;
    function OrVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function Poll(aSrc, aNum: SYSINT): SYSINT; safecall;
    function Scout(aVal: SYSINT): WordBool; safecall;
    function ScoutPower(bPower: WordBool): WordBool; safecall;
    function SelectDisplay(aSrc, aNumber: SYSINT): WordBool; safecall;
    function SelectProgram(aProg: SYSINT): WordBool; safecall;
    function SendMessage(aMsg: SYSINT): WordBool; safecall;
    function SendRawCommand(const aCmd: WideString;
      bRetry: WordBool): WideString; safecall;
    function SendRemoteNum(aEvent: SYSUINT; aRepeat: SYSINT): WordBool;
      safecall;
    function SendRemoteStr(const aEvent: WideString;
      aRepeat: SYSINT): WordBool; safecall;
    function SendVLL(aSrc, aNum: SYSINT): WordBool; safecall;
    function SetDatalog(aSize: SYSINT): WordBool; safecall;
    function SetFeedback(src, val: SYSINT): WordBool; safecall;
    function SetLightSensorHysteresis(src: TAutoLSSource;
      val: SYSUINT): WordBool; safecall;
    function SetLightSensorLowerThreshold(src: TAutoLSSource;
      val: SYSUINT): WordBool; safecall;
    function SetLightSensorUpperThreshold(src: TAutoLSSource;
      val: SYSUINT): WordBool; safecall;
    function SetVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function SetWatchNum(aHrs, aMins: SYSINT): WordBool; safecall;
    function SetWatchStr(const aTime: WideString): WordBool; safecall;
    function SgnVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function StartTask(aTask: SYSINT): WordBool; safecall;
    function StopAllTasks: WordBool; safecall;
    function StopTask(aTask: SYSINT): WordBool; safecall;
    function SubVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function SumVar(aVar, aSrc, aNum: SYSINT): WordBool; safecall;
    function UploadDatalog(aFrom, aSize: SYSINT): WideString; safecall;
    function UploadDatalogSimple(bVerbose: WordBool): WideString; safecall;
    function CalibrateEvent(enumb, upper, lower, hysteresis: SYSINT): WordBool;
      safecall;
    function ClearAllEvents: WordBool; safecall;
    function ClearCounter(num: TAutoCounterNumber): WordBool; safecall;
    function ClearSound: WordBool; safecall;
    function DecCounter(num: TAutoCounterNumber): WordBool; safecall;
    function IncCounter(num: TAutoCounterNumber): WordBool; safecall;
    function MuteSound: WordBool; safecall;
    function PollMemory(address, size: SYSINT): WideString; safecall;
    function SetLight(bOn: WordBool): WordBool; safecall;
    function ScoutRules(motion: TAutoScoutMotion; touch: TAutoScoutTouch;
      light: TAutoScoutLight; time: TAutoScoutScale;
      fx: TAutoScoutEffects): WordBool; safecall;
    function ScoutSound(bSoundEnable, bSoundOff: WordBool;
      aNum: TAutoSoundSetNumber): WordBool; safecall;
    function SendUARTData(istart, isize: SYSINT): WordBool; safecall;
    function SetCounterLimit(num: TAutoCounterNumber; src: TAutoTCSource;
      val: SYSINT): WordBool; safecall;
    function SetEvent(enumb, snumb, etype: SYSINT): WordBool; safecall;
    function SetGlobalDirection(motors: TAutoMotorsNum;
      action: TAutoGlobalDirAction): WordBool; safecall;
    function SetGlobalOutput(motors: TAutoMotorsNum;
      action: TAutoGlobalOutAction): WordBool; safecall;
    function SetLightSensorBlinkTime(src: TAutoLSSource;
      val: SYSUINT): WordBool; safecall;
    function SetMaxPower(motors: TAutoMotorsNum; src, num: SYSINT): WordBool;
      safecall;
    function SetTimerLimit(num: TAutoTimerNumber; src: TAutoTCSource;
      val: SYSINT): WordBool; safecall;
    function UnmuteSound: WordBool; safecall;
    function ViewSourceValue(prec, src, Value: SYSINT): WordBool; safecall;
    function Get_IsOpen: WordBool; safecall;
    function SetSourceValue(DestSrc, DestVal, OrigSrc,
      OrigVal: SYSINT): WordBool; safecall;
    function PollEEPROM(Block: SYSINT): WideString; safecall;
    function Get_Port: WideString; safecall;
    procedure Set_Port(const Value: WideString); safecall;
    function Get_UseBluetooth: WordBool; safecall;
    procedure Set_UseBluetooth(Value: WordBool); safecall;
  public
    destructor Destroy; override;
    procedure Initialize; override;
    procedure HandleOnDownloadStart(Sender : TObject);
    procedure HandleOnDownloadDone(Sender : TObject);
    procedure HandleOnOpenStateChanged(Sender : TObject);
    procedure HandleOnDownloadStatus(Sender : TObject; cur, total : Integer; var Abort : Boolean);
  end;

implementation

uses ComServ, rcx_link, MainUnit, uSpirit, brick_common;

procedure TBricxCCSpirit.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IBricxCCSpiritEvents;
  if FConnectionPoint <> nil then
    FSinkList := FConnectionPoint.SinkList;
end;

procedure TBricxCCSpirit.Initialize;
begin
  inherited Initialize;
  FConnectionPoints := TConnectionPoints.Create(Self);
  if AutoFactory.EventTypeInfo <> nil then
    FConnectionPoint := FConnectionPoints.CreateConnectionPoint(
      AutoFactory.EventIID, ckSingle, EventConnect)
  else
    FConnectionPoint := nil;
end;

destructor TBricxCCSpirit.Destroy;
begin
  inherited;
end;


procedure TBricxCCSpirit.HandleOnDownloadStart(Sender : TObject);
begin
  if FEvents <> nil then
    FEvents.OnDownloadStart;
end;

procedure TBricxCCSpirit.HandleOnDownloadDone(Sender: TObject);
begin
  if FEvents <> nil then
    FEvents.OnDownloadDone;
end;

procedure TBricxCCSpirit.HandleOnOpenStateChanged(Sender: TObject);
begin
  if FEvents <> nil then
    FEvents.OnOpenStateChanged;
  if Assigned(MainForm) then
    MainForm.HandleOpenStateChanged(Sender);
end;

procedure TBricxCCSpirit.HandleOnDownloadStatus(Sender: TObject; cur,
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

function TBricxCCSpirit.Open: WordBool;
begin
  BrickComm.OnDownloadDone     := HandleOnDownloadDone;
  BrickComm.OnDownloadStart    := HandleOnDownloadStart;
  BrickComm.OnOpenStateChanged := HandleOnOpenStateChanged;
  BrickComm.OnDownloadStatus   := HandleOnDownloadStatus;
  result := BrickComm.Open;
end;

function TBricxCCSpirit.Close: WordBool;
begin
  result := BrickComm.Close;
end;

function TBricxCCSpirit.Get_BrickType: TAutoBrickType;
begin
  result := BrickComm.BrickType;
end;

procedure TBricxCCSpirit.Set_BrickType(Value: TAutoBrickType);
begin
  LocalBrickType := TBrickType(Value);
  BrickComm.BrickType := TBrickType(Value);
end;

function TBricxCCSpirit.Get_PortName: WideString;
begin
  result := BrickComm.PortName;
end;

function TBricxCCSpirit.Get_NicePortName: WideString;
begin
  result := BrickComm.NicePortName;
end;

function TBricxCCSpirit.PlayTone(aFreq, aTime: SYSINT): WordBool;
begin
  result := BrickComm.PlayTone(aFreq, aTime);
end;

function TBricxCCSpirit.BatteryLevel: SYSINT;
begin
  result := BrickComm.BatteryLevel;
end;

function TBricxCCSpirit.BrickAlive: WordBool;
begin
  result := BrickComm.BrickAlive;
end;

function TBricxCCSpirit.ClearSensorValue(aNum: SYSINT): WordBool;
begin
  result := BrickComm.ClearSensorValue(aNum);
end;

function TBricxCCSpirit.DownloadMemoryMap: WideString;
begin
  result := BrickComm.DownloadMemoryMap.Text;
end;

function TBricxCCSpirit.MotorsFloat(aMotorList: Byte): WordBool;
begin
  result := BrickComm.MotorsFloat(aMotorList);
end;

function TBricxCCSpirit.MotorsOff(aMotorList: Byte): WordBool;
begin
  result := BrickComm.MotorsOff(aMotorList);
end;

function TBricxCCSpirit.MotorsOn(aMotorList: Byte): WordBool;
begin
  result := BrickComm.MotorsOn(aMotorList);
end;

function TBricxCCSpirit.Ping: WordBool;
begin
  result := BrickComm.Ping;
end;

function TBricxCCSpirit.PlaySystemSound(aSnd: SYSINT): WordBool;
begin
  result := BrickComm.PlaySystemSound(aSnd);
end;

function TBricxCCSpirit.PowerDownTime(aTime: SYSINT): WordBool;
begin
  result := BrickComm.PowerDownTime(aTime);
end;

function TBricxCCSpirit.PrepareBrick: WordBool;
begin
  result := BrickComm.PrepareBrick;
end;

function TBricxCCSpirit.SetFwd(aMotorList: Byte): WordBool;
begin
  result := BrickComm.SetFwd(aMotorList);
end;

function TBricxCCSpirit.SetMotorPower(aMotorList: Byte; aSrc,
  aNum: SYSINT): WordBool;
begin
  result := BrickComm.SetMotorPower(aMotorList, aSrc, aNum);
end;

function TBricxCCSpirit.SetRwd(aMotorList: Byte): WordBool;
begin
  result := BrickComm.SetRwd(aMotorList);
end;

function TBricxCCSpirit.SetSensorMode(aNum, aMode,
  aSlope: SYSINT): WordBool;
begin
  result := BrickComm.SetSensorMode(aNum, aMode, aSlope);
end;

function TBricxCCSpirit.SetSensorType(aNum, aType: SYSINT): WordBool;
begin
  result := BrickComm.SetSensorType(aNum, aType);
end;

function TBricxCCSpirit.Shutdown: WordBool;
begin
  result := BrickComm.Shutdown;
end;

function TBricxCCSpirit.Sleep(aVal: SYSINT): WordBool;
begin
  result := BrickComm.Sleep(aVal);
end;

function TBricxCCSpirit.SwitchDirection(aMotorList: Byte): WordBool;
begin
  result := BrickComm.SwitchDirection(aMotorList);
end;

function TBricxCCSpirit.TowerExists: WordBool;
begin
  result := BrickComm.TowerExists;
end;

function TBricxCCSpirit.UnlockBrick: WideString;
begin
  result := BrickComm.UnlockBrick;
end;

function TBricxCCSpirit.UnlockFirmware: WordBool;
begin
  result := BrickComm.UnlockFirmware;
end;

function TBricxCCSpirit.Version(out rom, ram: LongWord): WordBool;
begin
  result := BrickComm.Version(rom, ram);
end;

function TBricxCCSpirit.TransmitPower(
  aLevel: TAutoTransmitLevel): WordBool;
begin
  result := BrickComm.TransmitPower(TTransmitLevel(aLevel));
end;

function TBricxCCSpirit.AbsVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.AbsVar(aVar, aSrc, aNum);
end;

function TBricxCCSpirit.AndVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.AndVar(aVar, aSrc, aNum);
end;

function TBricxCCSpirit.CalibrateLightSensor: WordBool;
begin
  result := BrickComm.CalibrateLightSensor;
end;

function TBricxCCSpirit.ClearMemory: WordBool;
begin
  result := BrickComm.ClearMemory;
end;

function TBricxCCSpirit.ClearTachoCounter(aMotorList: Byte): WordBool;
begin
  result := BrickComm.ClearTachoCounter(aMotorList);
end;

function TBricxCCSpirit.ClearTimer(aNum: SYSINT): WordBool;
begin
  result := BrickComm.ClearTimer(aNum);
end;

function TBricxCCSpirit.DatalogNext(aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.DatalogNext(aSrc, aNum);
end;

function TBricxCCSpirit.DeleteAllSubs: WordBool;
begin
  result := BrickComm.DeleteAllSubs;
end;

function TBricxCCSpirit.DeleteAllTasks: WordBool;
begin
  result := BrickComm.DeleteAllTasks;
end;

function TBricxCCSpirit.DeleteSub(aSub: SYSINT): WordBool;
begin
  result := BrickComm.DeleteSub(aSub);
end;

function TBricxCCSpirit.DeleteTask(aTask: SYSINT): WordBool;
begin
  result := BrickComm.DeleteTask(aTask);
end;

function TBricxCCSpirit.DivVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.DivVar(aVar, aSrc, aNum);
end;

function TBricxCCSpirit.DownloadFirmware(const aFile: WideString; bFast,
  bComp, bUnlock: WordBool): WordBool;
begin
  result := BrickComm.DownloadFirmware(aFile, bFast, bComp, bUnlock);
end;

function TBricxCCSpirit.Drive(aLeft, aRight: SYSINT): WordBool;
begin
  result := BrickComm.Drive(aLeft, aRight);
end;

function TBricxCCSpirit.GetCounterValue(aNum: SYSINT): SYSINT;
begin
  result := BrickComm.GetCounterValue(aNum);
end;

function TBricxCCSpirit.GetInputValue(aIn: SYSINT): SYSINT;
begin
  result := BrickComm.GetInputValue(aIn);
end;

function TBricxCCSpirit.GetMessageValue(aNum: SYSINT): SYSINT;
begin
  result := BrickComm.GetMessageValue(aNum);
end;

function TBricxCCSpirit.GetOutputStatus(aOut: SYSINT): SYSINT;
begin
  result := BrickComm.GetOutputStatus(aOut);
end;

function TBricxCCSpirit.GetTimerValue(aNum: SYSINT): SYSINT;
begin
  result := BrickComm.GetTimerValue(aNum);
end;

function TBricxCCSpirit.GetVariableValue(aVar: SYSINT): SYSINT;
begin
  result := BrickComm.GetVariableValue(aVar);
end;

function TBricxCCSpirit.MulVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.MulVar(aVar, aSrc, aNum);
end;

function TBricxCCSpirit.OnWait(aMotorList: Byte; aNum: SYSINT;
  aTime: Byte): WordBool;
begin
  result := BrickComm.OnWait(aMotorList, aNum, aTime);
end;

function TBricxCCSpirit.OnWaitDifferent(aMotorList: Byte; aNum0, aNum1,
  aNum2: SYSINT; aTime: Byte): WordBool;
begin
  result := BrickComm.OnWaitDifferent(aMotorList, aNum0, aNum1, aNum2, aTime);
end;

function TBricxCCSpirit.OrVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.OrVar(aVar, aSrc, aNum);
end;

function TBricxCCSpirit.Poll(aSrc, aNum: SYSINT): SYSINT;
begin
  result := BrickComm.Poll(aSrc, aNum);
end;

function TBricxCCSpirit.Scout(aVal: SYSINT): WordBool;
begin
  result := BrickComm.Scout(aVal);
end;

function TBricxCCSpirit.ScoutPower(bPower: WordBool): WordBool;
begin
  result := BrickComm.Scout(bPower);
end;

function TBricxCCSpirit.SelectDisplay(aSrc, aNumber: SYSINT): WordBool;
begin
  result := BrickComm.SelectDisplay(aSrc, aNumber);
end;

function TBricxCCSpirit.SelectProgram(aProg: SYSINT): WordBool;
begin
  result := BrickComm.SelectProgram(aProg);
end;

function TBricxCCSpirit.SendMessage(aMsg: SYSINT): WordBool;
begin
  result := BrickComm.SendMessage(aMsg);
end;

function TBricxCCSpirit.SendRawCommand(const aCmd: WideString;
  bRetry: WordBool): WideString;
begin
  result := BrickComm.SendRawCommand(aCmd, bRetry);
end;

function TBricxCCSpirit.SendRemoteNum(aEvent: SYSUINT;
  aRepeat: SYSINT): WordBool;
begin
  result := BrickComm.SendRemote(aEvent, aRepeat);
end;

function TBricxCCSpirit.SendRemoteStr(const aEvent: WideString;
  aRepeat: SYSINT): WordBool;
begin
  result := BrickComm.SendRemote(aEvent, aRepeat);
end;

function TBricxCCSpirit.SendVLL(aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.SendVLL(aSrc, aNum);
end;

function TBricxCCSpirit.SetDatalog(aSize: SYSINT): WordBool;
begin
  result := BrickComm.SetDatalog(aSize);
end;

function TBricxCCSpirit.SetFeedback(src, val: SYSINT): WordBool;
begin
  result := BrickComm.SetFeedback(src, val);
end;

function TBricxCCSpirit.SetLightSensorHysteresis(src: TAutoLSSource;
  val: SYSUINT): WordBool;
begin
  result := BrickComm.SetLightSensorHysteresis(TLSSource(src), val);
end;

function TBricxCCSpirit.SetLightSensorLowerThreshold(src: TAutoLSSource;
  val: SYSUINT): WordBool;
begin
  result := BrickComm.SetLightSensorLowerThreshold(TLSSource(src), val);
end;

function TBricxCCSpirit.SetLightSensorUpperThreshold(src: TAutoLSSource;
  val: SYSUINT): WordBool;
begin
  result := BrickComm.SetLightSensorUpperThreshold(TLSSource(src), val);
end;

function TBricxCCSpirit.SetVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.SetVar(aVar, aSrc, aNum);
end;

function TBricxCCSpirit.SetWatchNum(aHrs, aMins: SYSINT): WordBool;
begin
  result := BrickComm.SetWatch(aHrs, aMins);
end;

function TBricxCCSpirit.SetWatchStr(const aTime: WideString): WordBool;
begin
  result := BrickComm.SetWatch(aTime);
end;

function TBricxCCSpirit.SgnVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.SgnVar(aVar, aSrc, aNum);
end;

function TBricxCCSpirit.StartTask(aTask: SYSINT): WordBool;
begin
  result := BrickComm.StartTask(aTask);
end;

function TBricxCCSpirit.StopAllTasks: WordBool;
begin
  result := BrickComm.StopAllTasks;
end;

function TBricxCCSpirit.StopTask(aTask: SYSINT): WordBool;
begin
  result := BrickComm.StopTask(aTask);
end;

function TBricxCCSpirit.SubVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.SubVar(aVar, aSrc, aNum);
end;

function TBricxCCSpirit.SumVar(aVar, aSrc, aNum: SYSINT): WordBool;
begin
  result := BrickComm.SumVar(aVar, aSrc, aNum);
end;

function TBricxCCSpirit.UploadDatalog(aFrom, aSize: SYSINT): WideString;
begin
  result := BrickComm.UploadDatalog(aFrom, aSize).Text;
end;

function TBricxCCSpirit.UploadDatalogSimple(bVerbose: WordBool): WideString;
begin
  result := BrickComm.UploadDatalog(bVerbose).Text;
end;

function TBricxCCSpirit.CalibrateEvent(enumb, upper, lower,
  hysteresis: SYSINT): WordBool;
begin
  result := BrickComm.CalibrateEvent(enumb, upper, lower, hysteresis);
end;

function TBricxCCSpirit.ClearAllEvents: WordBool;
begin
  result := BrickComm.ClearAllEvents;
end;

function TBricxCCSpirit.ClearCounter(num: TAutoCounterNumber): WordBool;
begin
  result := BrickComm.ClearCounter(num);
end;

function TBricxCCSpirit.ClearSound: WordBool;
begin
  result := BrickComm.ClearSound;
end;

function TBricxCCSpirit.DecCounter(num: TAutoCounterNumber): WordBool;
begin
  result := BrickComm.DecCounter(num);
end;

function TBricxCCSpirit.IncCounter(num: TAutoCounterNumber): WordBool;
begin
  result := BrickComm.IncCounter(num);
end;

function TBricxCCSpirit.MuteSound: WordBool;
begin
  result := BrickComm.MuteSound;
end;

function TBricxCCSpirit.PollMemory(address, size: SYSINT): WideString;
begin
  result := BrickComm.PollMemory(address, size).Text;
end;

function TBricxCCSpirit.SetLight(bOn: WordBool): WordBool;
begin
  result := BrickComm.SetLight(bOn);
end;

function TBricxCCSpirit.ScoutRules(motion: TAutoScoutMotion;
  touch: TAutoScoutTouch; light: TAutoScoutLight; time: TAutoScoutScale;
  fx: TAutoScoutEffects): WordBool;
begin
  result := BrickComm.ScoutRules(TScoutMotion(motion), TScoutTouch(touch),
    TScoutLight(light), TScoutScale(time), TScoutEffects(fx));
end;

function TBricxCCSpirit.ScoutSound(bSoundEnable, bSoundOff: WordBool;
  aNum: TAutoSoundSetNumber): WordBool;
begin
  result := BrickComm.ScoutSound(bSoundEnable, bSoundOff, aNum);
end;

function TBricxCCSpirit.SendUARTData(istart, isize: SYSINT): WordBool;
begin
  result := BrickComm.SendUARTData(istart, isize);
end;

function TBricxCCSpirit.SetCounterLimit(num: TAutoCounterNumber;
  src: TAutoTCSource; val: SYSINT): WordBool;
begin
  result := BrickComm.SetCounterLimit(num, TTCSource(src), val);
end;

function TBricxCCSpirit.SetEvent(enumb, snumb, etype: SYSINT): WordBool;
begin
  result := BrickComm.SetEvent(enumb, snumb, etype);
end;

function TBricxCCSpirit.SetGlobalDirection(motors: TAutoMotorsNum;
  action: TAutoGlobalDirAction): WordBool;
begin
  result := BrickComm.SetGlobalDirection(motors, TGlobalDirAction(action));
end;

function TBricxCCSpirit.SetGlobalOutput(motors: TAutoMotorsNum;
  action: TAutoGlobalOutAction): WordBool;
begin
  result := BrickComm.SetGlobalOutput(motors, TGlobalOutAction(action));
end;

function TBricxCCSpirit.SetLightSensorBlinkTime(src: TAutoLSSource;
  val: SYSUINT): WordBool;
begin
  result := BrickComm.SetLightSensorBlinkTime(TLSSource(src), val);
end;

function TBricxCCSpirit.SetMaxPower(motors: TAutoMotorsNum; src,
  num: SYSINT): WordBool;
begin
  result := BrickComm.SetMaxPower(motors, src, num);
end;

function TBricxCCSpirit.SetTimerLimit(num: TAutoTimerNumber;
  src: TAutoTCSource; val: SYSINT): WordBool;
begin
  result := BrickComm.SetTimerLimit(num, TTCSource(src), val);
end;

function TBricxCCSpirit.UnmuteSound: WordBool;
begin
  result := BrickComm.UnmuteSound;
end;

function TBricxCCSpirit.ViewSourceValue(prec, src,
  Value: SYSINT): WordBool;
begin
  result := BrickComm.ViewSourceValue(prec, src, value);
end;

function TBricxCCSpirit.Get_IsOpen: WordBool;
begin
  result := BrickComm.IsOpen;
end;

function TBricxCCSpirit.SetSourceValue(DestSrc, DestVal, OrigSrc,
  OrigVal: SYSINT): WordBool;
begin
  result := BrickComm.SetSourceValue(DestSrc, DestVal, OrigSrc, OrigVal);
end;

function TBricxCCSpirit.PollEEPROM(Block: SYSINT): WideString;
begin
  Result := BrickComm.PollEEPROM(Block).Text;
end;

function TBricxCCSpirit.Get_Port: WideString;
begin
  Result := BrickComm.Port;
end;

procedure TBricxCCSpirit.Set_Port(const Value: WideString);
begin
  BrickComm.Port := Value;
end;

function TBricxCCSpirit.Get_UseBluetooth: WordBool;
begin
  Result := BrickComm.UseBluetooth;
end;

procedure TBricxCCSpirit.Set_UseBluetooth(Value: WordBool);
begin
  BrickComm.UseBluetooth := Value;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TBricxCCSpirit, Class_BricxCCSpirit,
    ciSingleInstance, tmApartment);
end.


