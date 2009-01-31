unit BricxCC_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 12/15/2006 1:53:27 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: G:\nxt\BricxCC\source\BricxCC.tlb (1)
// LIBID: {6B34C712-C93C-4680-9BFD-DDC9FDB58AFB}
// LCID: 0
// Helpfile: 
// HelpString: BricxCC Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\System32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  BricxCCMajorVersion = 1;
  BricxCCMinorVersion = 2;

  LIBID_BricxCC: TGUID = '{6B34C712-C93C-4680-9BFD-DDC9FDB58AFB}';

  IID_IBricxCCSpirit: TGUID = '{FC6ABA46-69E2-4B62-9D0A-D059D8CF953C}';
  DIID_IBricxCCSpiritEvents: TGUID = '{7F46381F-F98C-49E6-8925-4172C83B831E}';
  CLASS_BricxCCSpirit: TGUID = '{721A1747-5FE1-4BFC-B8E3-FEE371296DEB}';
  IID_IBricxCCApp: TGUID = '{8AA107BB-FB90-4303-B4B9-69A97BC2AF01}';
  DIID_IBricxCCAppEvents: TGUID = '{BB1426CA-96AF-4295-A3C7-6673D92A77C0}';
  CLASS_BricxCCApp: TGUID = '{F9F55E9F-E0AF-495A-920E-49D8201979D6}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TAutoBrickType
type
  TAutoBrickType = TOleEnum;
const
  artRCX = $00000000;
  artCybermaster = $00000001;
  artScout = $00000002;
  artRCX2 = $00000003;
  artSpy = $00000004;

// Constants for enum TAutoTransmitLevel
type
  TAutoTransmitLevel = TOleEnum;
const
  atlNear = $00000000;
  atlFar = $00000001;

// Constants for enum TAutoLSSource
type
  TAutoLSSource = TOleEnum;
const
  alsVariable = $00000000;
  alsError = $00000001;
  alsConstant = $00000002;

// Constants for enum TAutoTimerNumber
type
  TAutoTimerNumber = TOleEnum;
const
  atnZero = $00000000;
  atnOne = $00000001;
  atnTwo = $00000002;
  atnThree = $00000003;

// Constants for enum TAutoCounterNumber
type
  TAutoCounterNumber = TOleEnum;
const
  acnZero = $00000000;
  acnOne = $00000001;
  acnTwo = $00000002;

// Constants for enum TAutoTCSource
type
  TAutoTCSource = TOleEnum;
const
  atcVariable = $00000000;
  atcError1 = $00000001;
  atcConstant = $00000002;
  atcError2 = $00000003;
  atcRandom = $00000004;

// Constants for enum TAutoScoutMotion
type
  TAutoScoutMotion = TOleEnum;
const
  asmNone = $00000000;
  asmForward = $00000001;
  asmZigZag = $00000002;
  asmCircleRight = $00000003;
  asmCircleLeft = $00000004;
  asmLoopA = $00000005;
  asmLoopB = $00000006;
  asmLoopAB = $00000007;

// Constants for enum TAutoScoutTouch
type
  TAutoScoutTouch = TOleEnum;
const
  astIgnore = $00000000;
  astReverse = $00000001;
  astAvoid = $00000002;
  astWaitFor = $00000003;
  astBrake = $00000004;

// Constants for enum TAutoScoutLight
type
  TAutoScoutLight = TOleEnum;
const
  aslIgnore = $00000000;
  aslSeekLight = $00000001;
  aslSeekDark = $00000002;
  aslAvoid = $00000003;
  aslWaitFor = $00000004;
  aslBrake = $00000005;

// Constants for enum TAutoScoutScale
type
  TAutoScoutScale = TOleEnum;
const
  assShort = $00000000;
  assMedium = $00000001;
  assLong = $00000002;

// Constants for enum TAutoScoutEffects
type
  TAutoScoutEffects = TOleEnum;
const
  aseNone = $00000000;
  aseBug = $00000001;
  aseAlarm = $00000002;
  aseRandom = $00000003;
  aseScience = $00000004;

// Constants for enum TAutoSoundSetNumber
type
  TAutoSoundSetNumber = TOleEnum;
const
  assnZero = $00000000;
  assnOne = $00000001;
  assnTwo = $00000002;
  assnThree = $00000003;
  assnFour = $00000004;
  assnFive = $00000005;

// Constants for enum TAutoGlobalOutAction
type
  TAutoGlobalOutAction = TOleEnum;
const
  agoaFloat = $00000000;
  agoaOff = $00000001;
  agoaOn = $00000002;

// Constants for enum TAutoGlobalDirAction
type
  TAutoGlobalDirAction = TOleEnum;
const
  agdaBackward = $00000000;
  agdaSwitch = $00000001;
  agdaForward = $00000002;

// Constants for enum TAutoMotorsNum
type
  TAutoMotorsNum = TOleEnum;
const
  amnOne = $00000001;
  amnTwo = $00000002;
  amnThree = $00000003;
  amnFour = $00000004;
  amnFive = $00000005;
  amnSix = $00000006;
  amnSeven = $00000007;

// Constants for enum TBricxCCSlots
type
  TBricxCCSlots = TOleEnum;
const
  bsOne = $00000000;
  bsTwo = $00000001;
  bsThree = $00000002;
  bsFour = $00000003;
  bsFive = $00000004;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IBricxCCSpirit = interface;
  IBricxCCSpiritDisp = dispinterface;
  IBricxCCSpiritEvents = dispinterface;
  IBricxCCApp = interface;
  IBricxCCAppDisp = dispinterface;
  IBricxCCAppEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  BricxCCSpirit = IBricxCCSpirit;
  BricxCCApp = IBricxCCApp;


// *********************************************************************//
// Interface: IBricxCCSpirit
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FC6ABA46-69E2-4B62-9D0A-D059D8CF953C}
// *********************************************************************//
  IBricxCCSpirit = interface(IDispatch)
    ['{FC6ABA46-69E2-4B62-9D0A-D059D8CF953C}']
    function Open: WordBool; safecall;
    function Close: WordBool; safecall;
    function Get_BrickType: TAutoBrickType; safecall;
    procedure Set_BrickType(Value: TAutoBrickType); safecall;
    function Get_PortName: WideString; safecall;
    function Get_NicePortName: WideString; safecall;
    function PlayTone(aFreq: SYSINT; aTime: SYSINT): WordBool; safecall;
    function PlaySystemSound(aSnd: SYSINT): WordBool; safecall;
    function MotorsOn(aMotorList: Byte): WordBool; safecall;
    function MotorsOff(aMotorList: Byte): WordBool; safecall;
    function MotorsFloat(aMotorList: Byte): WordBool; safecall;
    function SetFwd(aMotorList: Byte): WordBool; safecall;
    function SetRwd(aMotorList: Byte): WordBool; safecall;
    function SwitchDirection(aMotorList: Byte): WordBool; safecall;
    function SetMotorPower(aMotorList: Byte; aSrc: SYSINT; aNum: SYSINT): WordBool; safecall;
    function SetSensorType(aNum: SYSINT; aType: SYSINT): WordBool; safecall;
    function SetSensorMode(aNum: SYSINT; aMode: SYSINT; aSlope: SYSINT): WordBool; safecall;
    function ClearSensorValue(aNum: SYSINT): WordBool; safecall;
    function TowerExists: WordBool; safecall;
    function Ping: WordBool; safecall;
    function PrepareBrick: WordBool; safecall;
    function UnlockFirmware: WordBool; safecall;
    function UnlockBrick: WideString; safecall;
    function DownloadMemoryMap: WideString; safecall;
    function PowerDownTime(aTime: SYSINT): WordBool; safecall;
    function BatteryLevel: SYSINT; safecall;
    function BrickAlive: WordBool; safecall;
    function Shutdown: WordBool; safecall;
    function Sleep(aVal: SYSINT): WordBool; safecall;
    function Version(out rom: LongWord; out ram: LongWord): WordBool; safecall;
    function TransmitPower(aLevel: TAutoTransmitLevel): WordBool; safecall;
    function Poll(aSrc: SYSINT; aNum: SYSINT): SYSINT; safecall;
    function StartTask(aTask: SYSINT): WordBool; safecall;
    function StopTask(aTask: SYSINT): WordBool; safecall;
    function StopAllTasks: WordBool; safecall;
    function DeleteTask(aTask: SYSINT): WordBool; safecall;
    function DeleteAllTasks: WordBool; safecall;
    function DeleteSub(aSub: SYSINT): WordBool; safecall;
    function DeleteAllSubs: WordBool; safecall;
    function ClearTimer(aNum: SYSINT): WordBool; safecall;
    function ClearMemory: WordBool; safecall;
    function GetOutputStatus(aOut: SYSINT): SYSINT; safecall;
    function GetVariableValue(aVar: SYSINT): SYSINT; safecall;
    function GetInputValue(aIn: SYSINT): SYSINT; safecall;
    function GetMessageValue(aNum: SYSINT): SYSINT; safecall;
    function GetTimerValue(aNum: SYSINT): SYSINT; safecall;
    function GetCounterValue(aNum: SYSINT): SYSINT; safecall;
    function SetVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; safecall;
    function SumVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; safecall;
    function SubVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; safecall;
    function DivVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; safecall;
    function MulVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; safecall;
    function SgnVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; safecall;
    function AbsVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; safecall;
    function AndVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; safecall;
    function OrVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; safecall;
    function SendRawCommand(const aCmd: WideString; bRetry: WordBool): WideString; safecall;
    function SendRemoteStr(const aEvent: WideString; aRepeat: SYSINT): WordBool; safecall;
    function SendRemoteNum(aEvent: SYSUINT; aRepeat: SYSINT): WordBool; safecall;
    function SendMessage(aMsg: SYSINT): WordBool; safecall;
    function SelectProgram(aProg: SYSINT): WordBool; safecall;
    function SelectDisplay(aSrc: SYSINT; aNumber: SYSINT): WordBool; safecall;
    function SetWatchNum(aHrs: SYSINT; aMins: SYSINT): WordBool; safecall;
    function SetWatchStr(const aTime: WideString): WordBool; safecall;
    function DownloadFirmware(const aFile: WideString; bFast: WordBool; bComp: WordBool; 
                              bUnlock: WordBool): WordBool; safecall;
    function SetDatalog(aSize: SYSINT): WordBool; safecall;
    function DatalogNext(aSrc: SYSINT; aNum: SYSINT): WordBool; safecall;
    function UploadDatalog(aFrom: SYSINT; aSize: SYSINT): WideString; safecall;
    function UploadDatalogSimple(bVerbose: WordBool): WideString; safecall;
    function Drive(aLeft: SYSINT; aRight: SYSINT): WordBool; safecall;
    function ClearTachoCounter(aMotorList: Byte): WordBool; safecall;
    function OnWait(aMotorList: Byte; aNum: SYSINT; aTime: Byte): WordBool; safecall;
    function OnWaitDifferent(aMotorList: Byte; aNum0: SYSINT; aNum1: SYSINT; aNum2: SYSINT; 
                             aTime: Byte): WordBool; safecall;
    function Scout(aVal: SYSINT): WordBool; safecall;
    function ScoutPower(bPower: WordBool): WordBool; safecall;
    function CalibrateLightSensor: WordBool; safecall;
    function SendVLL(aSrc: SYSINT; aNum: SYSINT): WordBool; safecall;
    function SetFeedback(src: SYSINT; val: SYSINT): WordBool; safecall;
    function SetLightSensorUpperThreshold(src: TAutoLSSource; val: SYSUINT): WordBool; safecall;
    function SetLightSensorLowerThreshold(src: TAutoLSSource; val: SYSUINT): WordBool; safecall;
    function SetLightSensorHysteresis(src: TAutoLSSource; val: SYSUINT): WordBool; safecall;
    function SetLightSensorBlinkTime(src: TAutoLSSource; val: SYSUINT): WordBool; safecall;
    function SetTimerLimit(num: TAutoTimerNumber; src: TAutoTCSource; val: SYSINT): WordBool; safecall;
    function SetCounterLimit(num: TAutoCounterNumber; src: TAutoTCSource; val: SYSINT): WordBool; safecall;
    function SetLight(bOn: WordBool): WordBool; safecall;
    function ScoutRules(motion: TAutoScoutMotion; touch: TAutoScoutTouch; light: TAutoScoutLight; 
                        time: TAutoScoutScale; fx: TAutoScoutEffects): WordBool; safecall;
    function ScoutSound(bSoundEnable: WordBool; bSoundOff: WordBool; aNum: TAutoSoundSetNumber): WordBool; safecall;
    function PollMemory(address: SYSINT; size: SYSINT): WideString; safecall;
    function SetGlobalOutput(motors: TAutoMotorsNum; action: TAutoGlobalOutAction): WordBool; safecall;
    function SetGlobalDirection(motors: TAutoMotorsNum; action: TAutoGlobalDirAction): WordBool; safecall;
    function SetMaxPower(motors: TAutoMotorsNum; src: SYSINT; num: SYSINT): WordBool; safecall;
    function IncCounter(num: TAutoCounterNumber): WordBool; safecall;
    function DecCounter(num: TAutoCounterNumber): WordBool; safecall;
    function ClearCounter(num: TAutoCounterNumber): WordBool; safecall;
    function ClearSound: WordBool; safecall;
    function MuteSound: WordBool; safecall;
    function UnmuteSound: WordBool; safecall;
    function SendUARTData(istart: SYSINT; isize: SYSINT): WordBool; safecall;
    function SetEvent(enumb: SYSINT; snumb: SYSINT; etype: SYSINT): WordBool; safecall;
    function CalibrateEvent(enumb: SYSINT; upper: SYSINT; lower: SYSINT; hysteresis: SYSINT): WordBool; safecall;
    function ClearAllEvents: WordBool; safecall;
    function ViewSourceValue(prec: SYSINT; src: SYSINT; Value: SYSINT): WordBool; safecall;
    function Get_IsOpen: WordBool; safecall;
    function SetSourceValue(DestSrc: SYSINT; DestVal: SYSINT; OrigSrc: SYSINT; OrigVal: SYSINT): WordBool; safecall;
    function PollEEPROM(Block: SYSINT): WideString; safecall;
    function Get_Port: WideString; safecall;
    procedure Set_Port(const Value: WideString); safecall;
    function Get_UseBluetooth: WordBool; safecall;
    procedure Set_UseBluetooth(Value: WordBool); safecall;
    property BrickType: TAutoBrickType read Get_BrickType write Set_BrickType;
    property PortName: WideString read Get_PortName;
    property NicePortName: WideString read Get_NicePortName;
    property IsOpen: WordBool read Get_IsOpen;
    property Port: WideString read Get_Port write Set_Port;
    property UseBluetooth: WordBool read Get_UseBluetooth write Set_UseBluetooth;
  end;

// *********************************************************************//
// DispIntf:  IBricxCCSpiritDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FC6ABA46-69E2-4B62-9D0A-D059D8CF953C}
// *********************************************************************//
  IBricxCCSpiritDisp = dispinterface
    ['{FC6ABA46-69E2-4B62-9D0A-D059D8CF953C}']
    function Open: WordBool; dispid 1;
    function Close: WordBool; dispid 2;
    property BrickType: TAutoBrickType dispid 3;
    property PortName: WideString readonly dispid 5;
    property NicePortName: WideString readonly dispid 6;
    function PlayTone(aFreq: SYSINT; aTime: SYSINT): WordBool; dispid 7;
    function PlaySystemSound(aSnd: SYSINT): WordBool; dispid 8;
    function MotorsOn(aMotorList: Byte): WordBool; dispid 9;
    function MotorsOff(aMotorList: Byte): WordBool; dispid 10;
    function MotorsFloat(aMotorList: Byte): WordBool; dispid 11;
    function SetFwd(aMotorList: Byte): WordBool; dispid 12;
    function SetRwd(aMotorList: Byte): WordBool; dispid 13;
    function SwitchDirection(aMotorList: Byte): WordBool; dispid 14;
    function SetMotorPower(aMotorList: Byte; aSrc: SYSINT; aNum: SYSINT): WordBool; dispid 15;
    function SetSensorType(aNum: SYSINT; aType: SYSINT): WordBool; dispid 16;
    function SetSensorMode(aNum: SYSINT; aMode: SYSINT; aSlope: SYSINT): WordBool; dispid 17;
    function ClearSensorValue(aNum: SYSINT): WordBool; dispid 18;
    function TowerExists: WordBool; dispid 19;
    function Ping: WordBool; dispid 20;
    function PrepareBrick: WordBool; dispid 21;
    function UnlockFirmware: WordBool; dispid 22;
    function UnlockBrick: WideString; dispid 23;
    function DownloadMemoryMap: WideString; dispid 24;
    function PowerDownTime(aTime: SYSINT): WordBool; dispid 25;
    function BatteryLevel: SYSINT; dispid 26;
    function BrickAlive: WordBool; dispid 27;
    function Shutdown: WordBool; dispid 28;
    function Sleep(aVal: SYSINT): WordBool; dispid 29;
    function Version(out rom: LongWord; out ram: LongWord): WordBool; dispid 30;
    function TransmitPower(aLevel: TAutoTransmitLevel): WordBool; dispid 31;
    function Poll(aSrc: SYSINT; aNum: SYSINT): SYSINT; dispid 32;
    function StartTask(aTask: SYSINT): WordBool; dispid 33;
    function StopTask(aTask: SYSINT): WordBool; dispid 34;
    function StopAllTasks: WordBool; dispid 35;
    function DeleteTask(aTask: SYSINT): WordBool; dispid 36;
    function DeleteAllTasks: WordBool; dispid 37;
    function DeleteSub(aSub: SYSINT): WordBool; dispid 38;
    function DeleteAllSubs: WordBool; dispid 39;
    function ClearTimer(aNum: SYSINT): WordBool; dispid 40;
    function ClearMemory: WordBool; dispid 41;
    function GetOutputStatus(aOut: SYSINT): SYSINT; dispid 42;
    function GetVariableValue(aVar: SYSINT): SYSINT; dispid 43;
    function GetInputValue(aIn: SYSINT): SYSINT; dispid 44;
    function GetMessageValue(aNum: SYSINT): SYSINT; dispid 45;
    function GetTimerValue(aNum: SYSINT): SYSINT; dispid 46;
    function GetCounterValue(aNum: SYSINT): SYSINT; dispid 47;
    function SetVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; dispid 48;
    function SumVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; dispid 49;
    function SubVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; dispid 50;
    function DivVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; dispid 51;
    function MulVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; dispid 52;
    function SgnVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; dispid 53;
    function AbsVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; dispid 54;
    function AndVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; dispid 55;
    function OrVar(aVar: SYSINT; aSrc: SYSINT; aNum: SYSINT): WordBool; dispid 56;
    function SendRawCommand(const aCmd: WideString; bRetry: WordBool): WideString; dispid 57;
    function SendRemoteStr(const aEvent: WideString; aRepeat: SYSINT): WordBool; dispid 58;
    function SendRemoteNum(aEvent: SYSUINT; aRepeat: SYSINT): WordBool; dispid 59;
    function SendMessage(aMsg: SYSINT): WordBool; dispid 60;
    function SelectProgram(aProg: SYSINT): WordBool; dispid 61;
    function SelectDisplay(aSrc: SYSINT; aNumber: SYSINT): WordBool; dispid 62;
    function SetWatchNum(aHrs: SYSINT; aMins: SYSINT): WordBool; dispid 63;
    function SetWatchStr(const aTime: WideString): WordBool; dispid 64;
    function DownloadFirmware(const aFile: WideString; bFast: WordBool; bComp: WordBool; 
                              bUnlock: WordBool): WordBool; dispid 65;
    function SetDatalog(aSize: SYSINT): WordBool; dispid 66;
    function DatalogNext(aSrc: SYSINT; aNum: SYSINT): WordBool; dispid 67;
    function UploadDatalog(aFrom: SYSINT; aSize: SYSINT): WideString; dispid 68;
    function UploadDatalogSimple(bVerbose: WordBool): WideString; dispid 69;
    function Drive(aLeft: SYSINT; aRight: SYSINT): WordBool; dispid 70;
    function ClearTachoCounter(aMotorList: Byte): WordBool; dispid 71;
    function OnWait(aMotorList: Byte; aNum: SYSINT; aTime: Byte): WordBool; dispid 72;
    function OnWaitDifferent(aMotorList: Byte; aNum0: SYSINT; aNum1: SYSINT; aNum2: SYSINT; 
                             aTime: Byte): WordBool; dispid 73;
    function Scout(aVal: SYSINT): WordBool; dispid 74;
    function ScoutPower(bPower: WordBool): WordBool; dispid 75;
    function CalibrateLightSensor: WordBool; dispid 76;
    function SendVLL(aSrc: SYSINT; aNum: SYSINT): WordBool; dispid 77;
    function SetFeedback(src: SYSINT; val: SYSINT): WordBool; dispid 78;
    function SetLightSensorUpperThreshold(src: TAutoLSSource; val: SYSUINT): WordBool; dispid 79;
    function SetLightSensorLowerThreshold(src: TAutoLSSource; val: SYSUINT): WordBool; dispid 80;
    function SetLightSensorHysteresis(src: TAutoLSSource; val: SYSUINT): WordBool; dispid 81;
    function SetLightSensorBlinkTime(src: TAutoLSSource; val: SYSUINT): WordBool; dispid 82;
    function SetTimerLimit(num: TAutoTimerNumber; src: TAutoTCSource; val: SYSINT): WordBool; dispid 83;
    function SetCounterLimit(num: TAutoCounterNumber; src: TAutoTCSource; val: SYSINT): WordBool; dispid 84;
    function SetLight(bOn: WordBool): WordBool; dispid 85;
    function ScoutRules(motion: TAutoScoutMotion; touch: TAutoScoutTouch; light: TAutoScoutLight; 
                        time: TAutoScoutScale; fx: TAutoScoutEffects): WordBool; dispid 86;
    function ScoutSound(bSoundEnable: WordBool; bSoundOff: WordBool; aNum: TAutoSoundSetNumber): WordBool; dispid 87;
    function PollMemory(address: SYSINT; size: SYSINT): WideString; dispid 88;
    function SetGlobalOutput(motors: TAutoMotorsNum; action: TAutoGlobalOutAction): WordBool; dispid 89;
    function SetGlobalDirection(motors: TAutoMotorsNum; action: TAutoGlobalDirAction): WordBool; dispid 90;
    function SetMaxPower(motors: TAutoMotorsNum; src: SYSINT; num: SYSINT): WordBool; dispid 91;
    function IncCounter(num: TAutoCounterNumber): WordBool; dispid 92;
    function DecCounter(num: TAutoCounterNumber): WordBool; dispid 93;
    function ClearCounter(num: TAutoCounterNumber): WordBool; dispid 94;
    function ClearSound: WordBool; dispid 95;
    function MuteSound: WordBool; dispid 96;
    function UnmuteSound: WordBool; dispid 97;
    function SendUARTData(istart: SYSINT; isize: SYSINT): WordBool; dispid 98;
    function SetEvent(enumb: SYSINT; snumb: SYSINT; etype: SYSINT): WordBool; dispid 99;
    function CalibrateEvent(enumb: SYSINT; upper: SYSINT; lower: SYSINT; hysteresis: SYSINT): WordBool; dispid 100;
    function ClearAllEvents: WordBool; dispid 101;
    function ViewSourceValue(prec: SYSINT; src: SYSINT; Value: SYSINT): WordBool; dispid 102;
    property IsOpen: WordBool readonly dispid 103;
    function SetSourceValue(DestSrc: SYSINT; DestVal: SYSINT; OrigSrc: SYSINT; OrigVal: SYSINT): WordBool; dispid 104;
    function PollEEPROM(Block: SYSINT): WideString; dispid 105;
    property Port: WideString dispid 201;
    property UseBluetooth: WordBool dispid 202;
  end;

// *********************************************************************//
// DispIntf:  IBricxCCSpiritEvents
// Flags:     (4096) Dispatchable
// GUID:      {7F46381F-F98C-49E6-8925-4172C83B831E}
// *********************************************************************//
  IBricxCCSpiritEvents = dispinterface
    ['{7F46381F-F98C-49E6-8925-4172C83B831E}']
    procedure OnDownloadStart; dispid 1;
    procedure OnDownloadDone; dispid 2;
    procedure OnOpenStateChanged; dispid 3;
    procedure OnDownloadStatus(cur: SYSINT; total: SYSINT; var abort: WordBool); dispid 4;
  end;

// *********************************************************************//
// Interface: IBricxCCApp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8AA107BB-FB90-4303-B4B9-69A97BC2AF01}
// *********************************************************************//
  IBricxCCApp = interface(IDispatch)
    ['{8AA107BB-FB90-4303-B4B9-69A97BC2AF01}']
    procedure Show; safecall;
    procedure Hide; safecall;
    function Compile(bDownload: WordBool; bRun: WordBool; iSlot: TBricxCCSlots; 
                     out sErrors: WideString): WordBool; safecall;
    procedure OpenFile(const aPath: WideString); safecall;
    procedure CloseFile(index: Integer); safecall;
    procedure NewFile; safecall;
    procedure FocusFile(index: Integer); safecall;
    function Get_FileCount: Integer; safecall;
    procedure InsertText(index: Integer; row: LongWord; col: LongWord; const Value: WideString); safecall;
    procedure Run; safecall;
    procedure Stop; safecall;
    function Get_BrickType: TAutoBrickType; safecall;
    procedure Set_BrickType(Value: TAutoBrickType); safecall;
    procedure HelpOnWord(const aWord: WideString); safecall;
    function Get_Port: WideString; safecall;
    procedure Set_Port(const Value: WideString); safecall;
    function Get_UseBluetooth: WordBool; safecall;
    procedure Set_UseBluetooth(Value: WordBool); safecall;
    procedure GotoXY(row: LongWord; col: LongWord); safecall;
    property FileCount: Integer read Get_FileCount;
    property BrickType: TAutoBrickType read Get_BrickType write Set_BrickType;
    property Port: WideString read Get_Port write Set_Port;
    property UseBluetooth: WordBool read Get_UseBluetooth write Set_UseBluetooth;
  end;

// *********************************************************************//
// DispIntf:  IBricxCCAppDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8AA107BB-FB90-4303-B4B9-69A97BC2AF01}
// *********************************************************************//
  IBricxCCAppDisp = dispinterface
    ['{8AA107BB-FB90-4303-B4B9-69A97BC2AF01}']
    procedure Show; dispid 1;
    procedure Hide; dispid 2;
    function Compile(bDownload: WordBool; bRun: WordBool; iSlot: TBricxCCSlots; 
                     out sErrors: WideString): WordBool; dispid 3;
    procedure OpenFile(const aPath: WideString); dispid 4;
    procedure CloseFile(index: Integer); dispid 5;
    procedure NewFile; dispid 6;
    procedure FocusFile(index: Integer); dispid 7;
    property FileCount: Integer readonly dispid 8;
    procedure InsertText(index: Integer; row: LongWord; col: LongWord; const Value: WideString); dispid 9;
    procedure Run; dispid 10;
    procedure Stop; dispid 11;
    property BrickType: TAutoBrickType dispid 12;
    procedure HelpOnWord(const aWord: WideString); dispid 14;
    property Port: WideString dispid 201;
    property UseBluetooth: WordBool dispid 202;
    procedure GotoXY(row: LongWord; col: LongWord); dispid 203;
  end;

// *********************************************************************//
// DispIntf:  IBricxCCAppEvents
// Flags:     (4096) Dispatchable
// GUID:      {BB1426CA-96AF-4295-A3C7-6673D92A77C0}
// *********************************************************************//
  IBricxCCAppEvents = dispinterface
    ['{BB1426CA-96AF-4295-A3C7-6673D92A77C0}']
  end;

// *********************************************************************//
// The Class CoBricxCCSpirit provides a Create and CreateRemote method to          
// create instances of the default interface IBricxCCSpirit exposed by              
// the CoClass BricxCCSpirit. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBricxCCSpirit = class
    class function Create: IBricxCCSpirit;
    class function CreateRemote(const MachineName: string): IBricxCCSpirit;
  end;

// *********************************************************************//
// The Class CoBricxCCApp provides a Create and CreateRemote method to          
// create instances of the default interface IBricxCCApp exposed by              
// the CoClass BricxCCApp. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBricxCCApp = class
    class function Create: IBricxCCApp;
    class function CreateRemote(const MachineName: string): IBricxCCApp;
  end;

implementation

uses ComObj;

class function CoBricxCCSpirit.Create: IBricxCCSpirit;
begin
  Result := CreateComObject(CLASS_BricxCCSpirit) as IBricxCCSpirit;
end;

class function CoBricxCCSpirit.CreateRemote(const MachineName: string): IBricxCCSpirit;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BricxCCSpirit) as IBricxCCSpirit;
end;

class function CoBricxCCApp.Create: IBricxCCApp;
begin
  Result := CreateComObject(CLASS_BricxCCApp) as IBricxCCApp;
end;

class function CoBricxCCApp.CreateRemote(const MachineName: string): IBricxCCApp;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BricxCCApp) as IBricxCCApp;
end;

end.
