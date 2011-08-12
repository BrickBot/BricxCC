unit FakeSpiritLib_TLB;

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
// File generated on 4/26/2006 9:54:35 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\winapps\projects\BricxCC\source\FakeSpiritLib.tlb (1)
// LIBID: {694CCD40-823A-4E79-A959-FB4EE8C865D5}
// LCID: 0
// Helpfile: 
// HelpString: FakeSpiritLib Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
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
  FakeSpiritLibMajorVersion = 1;
  FakeSpiritLibMinorVersion = 0;

  LIBID_FakeSpiritLib: TGUID = '{694CCD40-823A-4E79-A959-FB4EE8C865D5}';

  IID_IFakeSpirit: TGUID = '{C3BAEBC8-008E-46E0-8A09-E6C6A19AD47F}';
  DIID_IFakeSpiritEvents: TGUID = '{4A1F2573-25EE-4A2F-B488-4985A805886A}';
  CLASS_FakeSpirit: TGUID = '{AF90A083-5E24-4F7B-A7E4-D422E5458494}';

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
  artSwan = $00000005;
  artMicroScout = $00000006;
  artNXT = $00000007;

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

// Constants for enum TAutoNXTFileType
type
  TAutoNXTFileType = TOleEnum;
const
  anftProgram = $00000000;
  anftGraphics = $00000001;
  anftSound = $00000002;
  anftData = $00000003;
  anftOther = $00000004;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IFakeSpirit = interface;
  IFakeSpiritDisp = dispinterface;
  IFakeSpiritEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  FakeSpirit = IFakeSpirit;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PByte1 = ^Byte; {*}


// *********************************************************************//
// Interface: IFakeSpirit
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C3BAEBC8-008E-46E0-8A09-E6C6A19AD47F}
// *********************************************************************//
  IFakeSpirit = interface(IDispatch)
    ['{C3BAEBC8-008E-46E0-8A09-E6C6A19AD47F}']
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
    function MonitorIR(Secs: SYSINT): WideString; safecall;
    function Get_FastMode: WordBool; safecall;
    procedure Set_FastMode(Value: WordBool); safecall;
    function Get_UseBluetooth: WordBool; safecall;
    procedure Set_UseBluetooth(Value: WordBool); safecall;
    function Get_Quiet: WordBool; safecall;
    procedure Set_Quiet(Value: WordBool); safecall;
    function Get_Port: WideString; safecall;
    procedure Set_Port(const Value: WideString); safecall;
    function Get_BrickTypeName: WideString; safecall;
    procedure SetEEPROMByte(addr: Byte; Value: Byte); safecall;
    function GetEEPROMByte(addr: Byte): Byte; safecall;
    procedure GetEEPROMBlock(idx: Integer; out b1: Byte; out b2: Byte; out b3: Byte; out b4: Byte; 
                             out b5: Byte; out b6: Byte; out b7: Byte; out b8: Byte; out b9: Byte; 
                             out b10: Byte; out b11: Byte; out b12: Byte; out b13: Byte; 
                             out b14: Byte; out b15: Byte; out b16: Byte); safecall;
    function Get_VerboseMode: WordBool; safecall;
    procedure Set_VerboseMode(Value: WordBool); safecall;
    procedure SetNXTLSBlock(Port: Byte; TxLen: Byte; RxLen: Byte; b1: Byte; b2: Byte; b3: Byte; 
                            b4: Byte; b5: Byte; b6: Byte; b7: Byte; b8: Byte; b9: Byte; b10: Byte; 
                            b11: Byte; b12: Byte; b13: Byte; b14: Byte; b15: Byte; b16: Byte); safecall;
    procedure GetNXTLSBlock(Port: Byte; out RxLen: Byte; out b1: Byte; out b2: Byte; out b3: Byte; 
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
    function NXTOpenRead(const filename: WideString; out handle: longword; out size: LongWord): WordBool; safecall;
    function NXTOpenReadLinear(const filename: WideString; out handle: longword; out size: LongWord): WordBool; safecall;
    function NXTOpenWrite(const filename: WideString; size: LongWord; out handle: longword): WordBool; safecall;
    function NXTOpenWriteLinear(const filename: WideString; size: LongWord; out handle: longword): WordBool; safecall;
    function NXTOpenWriteData(const filename: WideString; size: LongWord; out handle: longword): WordBool; safecall;
    function NXTOpenAppendData(const filename: WideString; out size: LongWord; out handle: longword): WordBool; safecall;
    function NXTRead(var handle: longword; var count: Smallint; out buffer: PByte1): WordBool; safecall;
    function NXTWrite(var handle: longword; buffer: PByte; var count: Smallint; chkResponse: WordBool): WordBool; safecall;
    function NXTCloseFile(var handle: longword; chkResponse: WordBool): WordBool; safecall;
    function NXTDeleteFile(var filename: WideString; chkResponse: WordBool): WordBool; safecall;
    function NXTFindFirstFile(var filename: WideString; out handle: longword; out size: LongWord): WordBool; safecall;
    function NXTFindNextFile(var handle: longword; out filename: WideString; out size: LongWord): WordBool; safecall;
    function NXTGetVersions(out protmin: Byte; out protmaj: Byte; out firmmin: Byte; 
                            out firmmaj: Byte): WordBool; safecall;
    function NXTCloseModuleHandle(var handle: longword; chkResponse: WordBool): WordBool; safecall;
    function NXTBootCommand(chkResponse: WordBool): WordBool; safecall;
    function NXTSetBrickName(const name: WideString; chkResponse: WordBool): WordBool; safecall;
    function NXTGetDeviceInfo(out name: WideString; out BTAddress: WideString; 
                              out BTSignal: LongWord; out FreeMem: LongWord): WordBool; safecall;
    function NXTDeleteUserFlash(chkResponse: WordBool): WordBool; safecall;
    function NXTBTFactoryReset(chkResponse: WordBool): WordBool; safecall;
    function NXTPollCommandLen(bufNum: Byte; out count: Byte): WordBool; safecall;
    function NXTPollCommand(bufNum: Byte; var count: Byte; out aCmd: PByte1): WordBool; safecall;
    function NXTWriteIOMap(ModID: LongWord; Offset: Smallint; var count: Smallint; Data: PByte; 
                           chkResponse: WordBool): WordBool; safecall;
    function NXTReadIOMap(ModID: LongWord; Offset: Smallint; var count: Smallint; var Data: PByte1): WordBool; safecall;
    function NXTFindFirstModule(var ModName: WideString; out handle: longword; out ModID: LongWord; 
                                out ModSize: LongWord; out IOMapSize: Smallint): WordBool; safecall;
    function NXTFindNextModule(var handle: longword; out ModName: WideString; out ModID: LongWord; 
                               out ModSize: LongWord; out IOMapSize: Smallint): WordBool; safecall;
    function DownloadFile(const filename: WideString; filetype: TAutoNXTFileType): WordBool; safecall;
    function NXTUploadFile(const filename: WideString; const dir: WideString): WordBool; safecall;
    function NXTListFiles(const searchPattern: WideString; out Files: WideString): WordBool; safecall;
    function NXTListModules(const searchPattern: WideString; out Files: WideString): WordBool; safecall;
    property BrickType: TAutoBrickType read Get_BrickType write Set_BrickType;
    property PortName: WideString read Get_PortName;
    property NicePortName: WideString read Get_NicePortName;
    property IsOpen: WordBool read Get_IsOpen;
    property TowerExistsSleep: Integer read Get_TowerExistsSleep write Set_TowerExistsSleep;
    property RCXFirmwareChunkSize: Integer read Get_RCXFirmwareChunkSize write Set_RCXFirmwareChunkSize;
    property DownloadWaitTime: Integer read Get_DownloadWaitTime write Set_DownloadWaitTime;
    property OmitHeader: WordBool read Get_OmitHeader write Set_OmitHeader;
    property Datalog: WideString read Get_Datalog;
    property MemoryData: WideString read Get_MemoryData;
    property MemoryMap: WideString read Get_MemoryMap;
    property FastMode: WordBool read Get_FastMode write Set_FastMode;
    property UseBluetooth: WordBool read Get_UseBluetooth write Set_UseBluetooth;
    property Quiet: WordBool read Get_Quiet write Set_Quiet;
    property Port: WideString read Get_Port write Set_Port;
    property BrickTypeName: WideString read Get_BrickTypeName;
    property VerboseMode: WordBool read Get_VerboseMode write Set_VerboseMode;
  end;

// *********************************************************************//
// DispIntf:  IFakeSpiritDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C3BAEBC8-008E-46E0-8A09-E6C6A19AD47F}
// *********************************************************************//
  IFakeSpiritDisp = dispinterface
    ['{C3BAEBC8-008E-46E0-8A09-E6C6A19AD47F}']
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
    property TowerExistsSleep: Integer dispid 201;
    property RCXFirmwareChunkSize: Integer dispid 202;
    property DownloadWaitTime: Integer dispid 203;
    property OmitHeader: WordBool dispid 204;
    property Datalog: WideString readonly dispid 205;
    property MemoryData: WideString readonly dispid 206;
    property MemoryMap: WideString readonly dispid 207;
    function MonitorIR(Secs: SYSINT): WideString; dispid 208;
    property FastMode: WordBool dispid 209;
    property UseBluetooth: WordBool dispid 210;
    property Quiet: WordBool dispid 211;
    property Port: WideString dispid 212;
    property BrickTypeName: WideString readonly dispid 213;
    procedure SetEEPROMByte(addr: Byte; Value: Byte); dispid 214;
    function GetEEPROMByte(addr: Byte): Byte; dispid 215;
    procedure GetEEPROMBlock(idx: Integer; out b1: Byte; out b2: Byte; out b3: Byte; out b4: Byte; 
                             out b5: Byte; out b6: Byte; out b7: Byte; out b8: Byte; out b9: Byte; 
                             out b10: Byte; out b11: Byte; out b12: Byte; out b13: Byte; 
                             out b14: Byte; out b15: Byte; out b16: Byte); dispid 217;
    property VerboseMode: WordBool dispid 218;
    procedure SetNXTLSBlock(Port: Byte; TxLen: Byte; RxLen: Byte; b1: Byte; b2: Byte; b3: Byte; 
                            b4: Byte; b5: Byte; b6: Byte; b7: Byte; b8: Byte; b9: Byte; b10: Byte; 
                            b11: Byte; b12: Byte; b13: Byte; b14: Byte; b15: Byte; b16: Byte); dispid 216;
    procedure GetNXTLSBlock(Port: Byte; out RxLen: Byte; out b1: Byte; out b2: Byte; out b3: Byte; 
                            out b4: Byte; out b5: Byte; out b6: Byte; out b7: Byte; out b8: Byte; 
                            out b9: Byte; out b10: Byte; out b11: Byte; out b12: Byte; 
                            out b13: Byte; out b14: Byte; out b15: Byte; out b16: Byte); dispid 219;
    function StartProgram(const filename: WideString): WordBool; dispid 220;
    function StopProgram: WordBool; dispid 221;
    function PlaySoundFile(const filename: WideString; loop: WordBool): WordBool; dispid 222;
    function GetNXTOutputState(Port: Byte; out power: Integer; out mode: Byte; out regmode: Byte; 
                               out turnratio: Integer; out runstate: Byte; 
                               out tacholimit: LongWord; out tachocount: Integer; 
                               out blocktachocount: Integer; out rotationcount: Integer): WordBool; dispid 223;
    function SetNXTOutputState(Port: Byte; power: Integer; mode: Byte; regmode: Byte; 
                               turnratio: Integer; runstate: Byte; tacholimit: LongWord): WordBool; dispid 224;
    function GetNXTInputValues(Port: Byte; out valid: WordBool; out calibrated: WordBool; 
                               out stype: Byte; out smode: Byte; out raw: LongWord; 
                               out normalized: LongWord; out scaled: Smallint; 
                               out calvalue: Smallint): WordBool; dispid 225;
    function SetNXTInputMode(Port: Byte; stype: Byte; smode: Byte): WordBool; dispid 226;
    function ResetInputScaledValue(Port: Byte): WordBool; dispid 227;
    function ResetOutputPosition(Port: Byte; relative: WordBool): WordBool; dispid 228;
    function MessageWrite(inbox: Byte; const msg: WideString): WordBool; dispid 229;
    function MessageRead(remote: Byte; remove: WordBool; var local: Byte; out size: Byte; 
                         out msg: WideString): WordBool; dispid 230;
    function KeepAlive(chkResponse: WordBool; out time: LongWord): WordBool; dispid 231;
    function LSGetStatus(Port: Byte; out bytesReady: Byte): WordBool; dispid 232;
    function GetCurrentProgramName(out filename: WideString): WordBool; dispid 233;
    function GetButtonState(idx: Byte; reset: WordBool; out pressed: WordBool; out count: Byte): WordBool; dispid 234;
    function NXTOpenRead(const filename: WideString; out handle: longword; out size: LongWord): WordBool; dispid 235;
    function NXTOpenReadLinear(const filename: WideString; out handle: longword; out size: LongWord): WordBool; dispid 236;
    function NXTOpenWrite(const filename: WideString; size: LongWord; out handle: longword): WordBool; dispid 237;
    function NXTOpenWriteLinear(const filename: WideString; size: LongWord; out handle: longword): WordBool; dispid 238;
    function NXTOpenWriteData(const filename: WideString; size: LongWord; out handle: longword): WordBool; dispid 239;
    function NXTOpenAppendData(const filename: WideString; out size: LongWord; out handle: longword): WordBool; dispid 240;
    function NXTRead(var handle: longword; var count: Smallint; out buffer: {??PByte1}OleVariant): WordBool; dispid 241;
    function NXTWrite(var handle: longword; var buffer: Byte; var count: Smallint; chkResponse: WordBool): WordBool; dispid 242;
    function NXTCloseFile(var handle: longword; chkResponse: WordBool): WordBool; dispid 243;
    function NXTDeleteFile(var filename: WideString; chkResponse: WordBool): WordBool; dispid 244;
    function NXTFindFirstFile(var filename: WideString; out handle: longword; out size: LongWord): WordBool; dispid 245;
    function NXTFindNextFile(var handle: longword; out filename: WideString; out size: LongWord): WordBool; dispid 246;
    function NXTGetVersions(out protmin: Byte; out protmaj: Byte; out firmmin: Byte; 
                            out firmmaj: Byte): WordBool; dispid 247;
    function NXTCloseModuleHandle(var handle: longword; chkResponse: WordBool): WordBool; dispid 248;
    function NXTBootCommand(chkResponse: WordBool): WordBool; dispid 249;
    function NXTSetBrickName(const name: WideString; chkResponse: WordBool): WordBool; dispid 250;
    function NXTGetDeviceInfo(out name: WideString; out BTAddress: WideString; 
                              out BTSignal: LongWord; out FreeMem: LongWord): WordBool; dispid 251;
    function NXTDeleteUserFlash(chkResponse: WordBool): WordBool; dispid 252;
    function NXTBTFactoryReset(chkResponse: WordBool): WordBool; dispid 253;
    function NXTPollCommandLen(bufNum: Byte; out count: Byte): WordBool; dispid 254;
    function NXTPollCommand(bufNum: Byte; var count: Byte; out aCmd: {??PByte1}OleVariant): WordBool; dispid 255;
    function NXTWriteIOMap(ModID: LongWord; Offset: Smallint; var count: Smallint; var Data: Byte; 
                           chkResponse: WordBool): WordBool; dispid 256;
    function NXTReadIOMap(ModID: LongWord; Offset: Smallint; var count: Smallint; 
                          var Data: {??PByte1}OleVariant): WordBool; dispid 257;
    function NXTFindFirstModule(var ModName: WideString; out handle: longword; out ModID: LongWord; 
                                out ModSize: LongWord; out IOMapSize: Smallint): WordBool; dispid 258;
    function NXTFindNextModule(var handle: longword; out ModName: WideString; out ModID: LongWord; 
                               out ModSize: LongWord; out IOMapSize: Smallint): WordBool; dispid 259;
    function DownloadFile(const filename: WideString; filetype: TAutoNXTFileType): WordBool; dispid 260;
    function NXTUploadFile(const filename: WideString; const dir: WideString): WordBool; dispid 261;
    function NXTListFiles(const searchPattern: WideString; out Files: WideString): WordBool; dispid 262;
    function NXTListModules(const searchPattern: WideString; out Files: WideString): WordBool; dispid 263;
  end;

// *********************************************************************//
// DispIntf:  IFakeSpiritEvents
// Flags:     (4096) Dispatchable
// GUID:      {4A1F2573-25EE-4A2F-B488-4985A805886A}
// *********************************************************************//
  IFakeSpiritEvents = dispinterface
    ['{4A1F2573-25EE-4A2F-B488-4985A805886A}']
    procedure OnDownloadStart; dispid 1;
    procedure OnDownloadDone; dispid 2;
    procedure OnOpenStateChanged; dispid 3;
    procedure OnDownloadStatus(cur: SYSINT; total: SYSINT; var abort: WordBool); dispid 4;
  end;

// *********************************************************************//
// The Class CoFakeSpirit provides a Create and CreateRemote method to          
// create instances of the default interface IFakeSpirit exposed by              
// the CoClass FakeSpirit. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFakeSpirit = class
    class function Create: IFakeSpirit;
    class function CreateRemote(const MachineName: string): IFakeSpirit;
  end;

implementation

uses ComObj;

class function CoFakeSpirit.Create: IFakeSpirit;
begin
  Result := CreateComObject(CLASS_FakeSpirit) as IFakeSpirit;
end;

class function CoFakeSpirit.CreateRemote(const MachineName: string): IFakeSpirit;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FakeSpirit) as IFakeSpirit;
end;

end.