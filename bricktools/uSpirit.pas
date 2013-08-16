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
unit uSpirit;

interface

{$IFDEF FPC}

{$PACKRECORDS C}

{$ENDIF}


uses
  rcx_constants, Classes, FantomDefs, uProgram, uCompCommon;

const
  MAX_COMPORT   = 8;
  MAX_USBPORT   = MAX_COMPORT+4;

const
  SOUND_CLICK       = 0; //*!< Play the standard key click sound
  SOUND_DOUBLE_BEEP = 1; //*!< Play the standard double beep sound
  SOUND_DOWN        = 2; //*!< Play the standard sweep down sound
  SOUND_UP          = 3; //*!< Play the standard sweep up sound
  SOUND_LOW_BEEP    = 4; //*!< Play the standard low beep sound
  SOUND_FAST_UP     = 5; //*!< Play the standard fast up sound

type
//  TBrickType = rtRCX..rtNXT;
  TDownloadStatusEvent = procedure(Sender : TObject; cur, total : Integer; var Abort : boolean) of object;
  TGetVarInfoByIDEvent = procedure(Sender : TObject; const ID : integer; var offset, size, vartype : integer) of object;
  TGetVarInfoByNameEvent = procedure(Sender : TObject; const name : string; var offset, size, vartype : integer) of object;
//  TPortNum = 1..MAX_USBPORT;
  TDataSendReceiveEvent = procedure(Sender : TObject; const Sending : boolean; const Data : array of byte) of object;

  NXTLSBlock = record
    TXCount : byte;
    RXCount : byte;
    Data : array[0..15] of Byte;
  end;

  PBRMessage = record
    Inbox : byte;
    Size : byte;
    Data : array[0..58] of Byte;
  end;

  PBRDataBuffer = record
    Data : array[0..1023] of Byte;
//    Data : array[0..kNXT_MaxBytes-1] of Byte;
  end;

  NXTConnection = packed record
    Name : array[0..15] of Char;
    ClassOfDevice : array[0..3] of Byte;
    PinCode : array[0..15] of Char;
    BTAddress : array[0..6] of Byte;
    HandleNum : byte;
    StreamStatus : byte;
    LinkQuality : byte;
  end;

  NXTDevice = packed record
    Name : array[0..15] of Char;
    ClassOfDevice : array[0..3] of Byte;
    BTAddress : array[0..6] of Byte;
    DeviceStatus : byte;
  end;

  TTransmitLevel = (tlNear, tlFar);
  TLSSource = (lsVariable, lsError, lsConstant);
  TThresholdValue = 0..1020;
  TBlinkTimeValue = 1..32767;
  TTimerNumber = 0..3; // rcx2 has 4, scout only has 3
  TCounterNumber = 0..2; // rcx2 has 3 counters, scout only has 2
  TTCSource = (tcVariable, tcError1, tcConstant, tcError2, tcRandom);
  TScoutMotion = (smNone, smForward, smZigZag, smCircleRight, smCircleLeft, smLoopA, smLoopB, smLoopAB);
  TScoutTouch = (stIgnore, stReverse, stAvoid, stWaitFor, stBrake);
  TScoutLight = (slIgnore, slSeekLight, slSeekDark, slAvoid, slWaitFor, slBrake);
  TScoutScale = (ssShort, ssMedium, ssLong);
  TScoutEffects = (seNone, seBug, seAlarm, seRandom, seScience);
  TSoundSetNumber = 0..5;
  TGlobalOutAction = (goaFloat, goaOff, goaOn);
  TGlobalDirAction = (gdaBackward, gdaSwitch, gdaForward);
  TMotorsNum = 1..15;
  TInstalledFirmware = (ifUnknown, ifStandard, ifEnhanced);

  TTransportType = (ttUSB, ttSER, ttBTH, ttTCP, ttSSH, ttAny);
  TTransportTypes = set of TTransportType; 

  EEPROMBlock = record
    Data : array[0..15] of Byte;
  end;

  TBrickComm = class
  private
  protected
    fPowerScaleFactor : byte;
    fLayer : byte;
    fSoundMuted : boolean;
    fBrickFolder: string;
    fNXTUseMailbox: boolean;
    fNXTMailboxNum: integer;
    fSearchBT: boolean;
    fLocalIFW : TInstalledFirmware;
    fLocalFV : Word;
    fOffsetDS : integer;
    fOffsetDVA : integer;
    fActive : boolean;
    fAutoClose: boolean;
    fBrickType: byte;
    fBST: Cardinal;
    fBTName: string;
    fDataLog: TStrings;
    fFastMode: boolean;
    fMemData: TStrings;
    fMemMap: TStrings;
    fOnDownloadDone: TNotifyEvent;
    fOnDownloadStart: TNotifyEvent;
    fOnDownloadStatus: TDownloadStatusEvent;
    fOnOpenStateChanged: TNotifyEvent;
    fOnGetVarInfoByID: TGetVarInfoByIDEvent;
    fOnGetVarInfoByName: TGetVarInfoByNameEvent;
    fOnDataReceiving: TDataSendReceiveEvent;
    fOnDataSending: TDataSendReceiveEvent;
    fProgram: TProgram;
    fPort: string;
    fTowerExistsSleep: Word;
    fUseBT: boolean;
    fVerbose: boolean;
    fMotorPower : array[0..15] of byte;
    fMotorForward : array[0..15] of boolean;
    fMotorOn : array[0..15] of boolean;
    fSensorType : array[0..15] of Byte;
    fSensorMode : array[0..15] of Byte;
    fStatus : integer;
    function GetBrickTypeName: string; virtual;
    function GetDownloadWaitTime: Integer; virtual; abstract;
    function GetEEPROM(addr: Byte): Byte; virtual; abstract;
    function GetEEPROMBlock(idx: Integer): EEPROMBlock; virtual; abstract;
    function GetIsOpen: boolean; virtual;
    function GetLinkLog: string; virtual; abstract;
    function GetLSBlock(port: byte): NXTLSBlock; virtual; abstract;
    function GetNicePortName: string; virtual;
    function GetFullPortName: string; virtual;
    function GetOmitHeader: Boolean; virtual; abstract;
    function GetPortName: string; virtual;
    function GetQuiet: Boolean; virtual; abstract;
    function GetRCXFirmwareChunkSize: Integer; virtual; abstract;
    function GetRxTimeout: Word; virtual; abstract;
    function GetUseBT: Boolean; virtual;
    procedure SetBrickType(const Value: byte); virtual;
    procedure SetBTName(const Value: string); virtual;
    procedure SetDownloadWaitTime(const Value: Integer); virtual; abstract;
    procedure SetEEPROM(addr: Byte; const Value: Byte); virtual; abstract;
    procedure SetFastMode(const Value: boolean); virtual;
    procedure SetLSBlock(port: byte; const Value: NXTLSBlock); virtual; abstract;
    procedure SetOmitHeader(const Value: Boolean); virtual; abstract;
    procedure SetPort(const Value: string); virtual;
    procedure SetQuiet(const Value: Boolean); virtual; abstract;
    procedure SetRCXFirmwareChunkSize(const Value: Integer); virtual; abstract;
    procedure SetRxTimeout(const Value: Word); virtual; abstract;
    procedure SetUseBT(const Value: boolean); virtual;
    procedure SetVerbose(const Value: boolean); virtual;
  protected
    procedure DoDownloadDone;
    procedure DoDownloadStart;
    procedure DoDownloadStatus(cur, total : Integer; var Abort : boolean);
    procedure DoOpenStateChanged;
    procedure DoGetVarInfoByID(const id : integer; var offset, size, vartype : integer);
    procedure DoGetVarInfoByName(const name : string; var offset, size, vartype : integer);
    procedure DoDataSend(Data : array of byte); overload;
    procedure DoDataSend(Data : string); overload;
    procedure DoDataSend(Data : byte); overload;
    procedure DoDataReceive(Data : array of byte); overload;
    procedure DoDataReceive(Data : string); overload;
    procedure DoDataReceive(Data : byte); overload;
    function GetErrorStatus: integer; virtual;
  public
    constructor Create(aType : byte = 0; const aPort : string = ''); virtual;
    destructor Destroy; override;

    function  Open : boolean; virtual; abstract;
    function  Close : boolean; virtual;

    function TransportTypes : TTransportTypes; virtual;

    procedure FlushReceiveBuffer; virtual; abstract;
    procedure SendRawData(Data : array of byte); virtual; abstract;

    // PBrick sound commands
    function PlayTone(aFreq, aTime : word) : boolean; virtual; abstract;
    function PlaySystemSound(aSnd : byte) : boolean; virtual; abstract;

    // PBrick output control commands
    function MotorsOn(aMotorList : Byte) : boolean; virtual; abstract;
    function MotorsOff(aMotorList : Byte) : boolean; virtual; abstract;
    function MotorsFloat(aMotorList : Byte) : boolean; virtual; abstract;
    function SetFwd(aMotorList : Byte) : boolean; virtual; abstract;
    function SetRwd(aMotorList : Byte) : boolean; virtual; abstract;
    function SwitchDirection(aMotorList : Byte) : boolean; virtual; abstract;
    function SetMotorPower(aMotorList : Byte; aSrc, aNum : integer) : boolean; virtual; abstract;

    // PBrick input control commands
    function SetSensorType(aNum, aType : integer) : boolean; virtual; abstract;
    function SetSensorMode(aNum, aMode, aSlope : integer) : boolean; virtual; abstract;
    function ClearSensorValue(aNum : integer) : boolean; virtual; abstract;

    // general
    function TowerExists : boolean; virtual; abstract;
    function Ping : boolean; virtual; abstract;
    function PrepareBrick : boolean; virtual; abstract;
    function UnlockFirmware : boolean; virtual; abstract;
    function UnlockBrick : string; virtual; abstract;
    function DownloadMemoryMap : TStrings; virtual; abstract;
    function MonitorIR(aSeconds: integer): TStrings; virtual; abstract;
    function PowerDownTime(aTime : integer) : boolean; virtual; abstract;
    function BatteryLevel : integer; virtual; abstract;
    function BrickAlive : boolean; virtual; abstract;
    function Shutdown : boolean; virtual; abstract;
    function Sleep(aVal : integer) : boolean; virtual; abstract;
	  function Version(var rom : Cardinal; var ram : Cardinal) : boolean; virtual; abstract;
    function VersionString : string; virtual;
    function TransmitPower(aLevel : TTransmitLevel) : boolean; virtual; abstract;

    function Poll(aSrc, aNum : integer) : variant; virtual; abstract;
    function StartTask(aTask : integer) : boolean; virtual; abstract;
    function StopTask(aTask : integer) : boolean; virtual; abstract;
    function StopAllTasks : boolean; virtual; abstract;
    function DeleteTask(aTask : integer) : boolean; virtual; abstract;
    function DeleteAllTasks : boolean; virtual; abstract;
    function DeleteSub(aSub : integer) : boolean; virtual; abstract;
    function DeleteAllSubs : boolean; virtual; abstract;
    function ClearTimer(aNum : integer) : boolean; virtual; abstract;
    function ClearMemory : boolean; virtual; abstract;

    function GetOutputStatus(aOut : integer) : integer; virtual; abstract;
    function GetVariableValue(aVar: integer): variant; virtual; abstract;
    function GetInputValue(aIn: integer): integer; virtual; abstract;
    function GetMessageValue(aNum : integer) : integer; virtual; abstract;
    function GetTimerValue(aNum : integer) : integer; virtual; abstract;
    function GetCounterValue(aNum : integer) : integer; virtual; abstract;

    // PBrick arithmetic/logical commands
    function SetVar(aVar, aSrc, aNum : integer) : boolean; virtual; abstract;
    function SumVar(aVar, aSrc, aNum : integer) : boolean; virtual; abstract;
    function SubVar(aVar, aSrc, aNum : integer) : boolean; virtual; abstract;
    function DivVar(aVar, aSrc, aNum : integer) : boolean; virtual; abstract;
    function MulVar(aVar, aSrc, aNum : integer) : boolean; virtual; abstract;
    function SgnVar(aVar, aSrc, aNum : integer) : boolean; virtual; abstract;
    function AbsVar(aVar, aSrc, aNum : integer) : boolean; virtual; abstract;
    function AndVar(aVar, aSrc, aNum : integer) : boolean; virtual; abstract;
    function OrVar(aVar, aSrc, aNum : integer) : boolean; virtual; abstract;

    // communication to brick
    function SendRawCommand(aCmd : string; bRetry : boolean) : string; virtual; abstract;
    function SendRemoteStr(aEvent : string; aRepeat : integer = 1) : boolean; virtual; abstract;
    function SendRemote(aEvent : Word; aRepeat : integer = 1) : boolean; virtual; abstract;
    function SendMessage(aMsg : integer) : boolean; virtual; abstract;

    // RCX/2 only
    function SelectProgram(aProg : integer) : boolean; virtual; abstract;
    function SelectDisplay(aSrc, aNumber : integer) : boolean; virtual; abstract;
    function SetWatchHHMM(aHrs, aMins : integer) : boolean; virtual; abstract;
    function SetWatch(aTime : string) : boolean; virtual; abstract;
    function DownloadFirmware(aFile : string; bFast, bComp, bUnlock : boolean) : boolean; virtual; abstract;
    function SetDatalog(aSize : integer) : boolean; virtual; abstract;
    function DatalogNext(aSrc, aNum : integer) : boolean; virtual; abstract;
    function UploadPartialDatalog(aFrom, aSize : integer) : TStrings; virtual; abstract;
    function UploadDatalog(bVerbose : boolean) : TStrings; virtual; abstract;

    // CM only methods
    function Drive(aLeft, aRight : integer) : boolean; virtual; abstract;
    function ClearTachoCounter(aMotorList : Byte) : boolean; virtual; abstract;
    function OnWait(aMotorList : Byte; aNum : integer; aTime : Byte) : boolean; virtual; abstract;
    function OnWaitDifferent(aMotorList : Byte; aNum0, aNum1, aNum2 : integer; aTime : Byte) : boolean; virtual; abstract;

    // Scout only methods
    function ScoutNum(aVal : integer) : boolean; virtual; abstract;
    function Scout(bPower : boolean = true) : boolean; virtual; abstract;
    function CalibrateLightSensor : boolean; virtual; abstract;
    function SetFeedback(src, val : integer) : boolean; virtual; abstract;
    function SetLightSensorUpperThreshold(src : TLSSource; val : TThresholdValue) : boolean; virtual; abstract;
    function SetLightSensorLowerThreshold(src : TLSSource; val : TThresholdValue) : boolean; virtual; abstract;
    function SetLightSensorHysteresis(src : TLSSource; val : TThresholdValue) : boolean; virtual; abstract;
    function SetLightSensorBlinkTime(src : TLSSource; val : TBlinkTimeValue) : boolean; virtual; abstract;
    function SetTimerLimit(num : TTimerNumber; src : TTCSource; val : integer) : boolean; virtual; abstract;
    function SetCounterLimit(num : TCounterNumber; src : TTCSource; val : integer) : boolean; virtual; abstract;
    function ScoutRules(motion : TScoutMotion; touch : TScoutTouch; 
      light : TScoutLight; time : TScoutScale; fx : TScoutEffects) : boolean; virtual; abstract;
    function ScoutSound(bSoundEnable : boolean; bSoundOff : boolean; aNum : TSoundSetNumber) : boolean; virtual; abstract;

    // Scout & Spybot only methods
    function SendVLL(aSrc, aNum : integer) : boolean; virtual; abstract;
    function SetLight(bOn : boolean) : boolean; virtual; abstract;

    // RCX2, Scout, & Spybot methods
    function PollMemory(address : Integer; size : Integer = 128) : TStrings; virtual; abstract;
    function SetGlobalOutput(motors : TMotorsNum; action : TGlobalOutAction) : boolean; virtual; abstract;
    function SetGlobalDirection(motors : TMotorsNum; action : TGlobalDirAction) : boolean; virtual; abstract;
    function SetMaxPower(motors : TMotorsNum; src, num : integer) : boolean; virtual; abstract;
    function IncCounter(num : TCounterNumber) : boolean; virtual; abstract;
    function DecCounter(num : TCounterNumber) : boolean; virtual; abstract;
    function ClearCounter(num : TCounterNumber) : boolean; virtual; abstract;

    // RCX2 & spybot only methods
    function ClearSound : boolean; virtual; abstract;
    function UnmuteSound : boolean; virtual; abstract;
    function SendUARTData(start, size : integer) : boolean; virtual; abstract;
    function SetEvent(enum, snum, etype : integer) : boolean; virtual; abstract;
    function CalibrateEvent(enum, upper, lower, hysteresis : integer) : boolean; virtual; abstract;
    function ClearAllEvents : boolean; virtual; abstract;
    function SetSourceValue(aDestSrc, aDestVal, aOrigSrc: Byte; aOrigVal: Smallint): boolean; virtual; abstract;

    // RCX2, Spy, & NXT
    function MuteSound : boolean; virtual; abstract;

    // RCX2 only methods
    function ViewSourceValue(prec, src, value : integer) : boolean; virtual; abstract;

    // Spybot only methods
    function PollEEPROM(block : Integer = -1) : TStrings; virtual; abstract;

    // NXT only methods
    // NXT direct commands
    function DCStartProgram(const filename : string) : boolean; virtual; abstract;
    function DCStopProgram : boolean; virtual; abstract;
    function DCPlaySoundFile(const filename : string; bLoop : boolean) : boolean; virtual; abstract;
    function DCGetOutputState(const port : byte; var power : integer;
      var mode, regmode : byte; var turnratio : integer;
      var runstate : byte; var tacholimit : cardinal; var tachocount,
      blocktachocount, rotationcount : longint) : boolean; virtual; abstract;
    function DCSetOutputState(const port : byte; const power : integer;
      const mode, regmode : byte; const turnratio : integer;
      const runstate : byte; const tacholimit : cardinal) : boolean; virtual; abstract;
    function DCGetInputValues(const port : byte; var valid, calibrated : boolean;
      var stype, smode : byte; var raw, normalized : word;
      var scaled, calvalue : smallint) : boolean; virtual; abstract;
    function DCSetInputMode(const port, stype, smode : byte) : boolean; virtual; abstract;
    function DCResetInputScaledValue(const port : byte) : boolean; virtual; abstract;
    function DCResetOutputPosition(const port : byte; const Relative : boolean) : boolean; virtual; abstract;
    function DCMessageWrite(const inbox : byte; const msg : string) : boolean; virtual; abstract;
    function DCKeepAlive(var time : cardinal; const chkResponse : boolean = true) : boolean; virtual; abstract;
    function DCLSGetStatus(port : byte; var bytesReady : byte; var lsstate: byte) : boolean; virtual; abstract;
    function DCGetCurrentProgramName(var name : string) : boolean; virtual; abstract;
    function DCGetButtonState(const idx : byte; const reset : boolean;
      var pressed : boolean; var count : byte) : boolean; virtual; abstract;
    function DCMessageRead(const remote, local : byte; const remove : boolean; var Msg : PBRMessage) : boolean; virtual; abstract;
    function DCSetPropDebugging(const debugging : boolean; const pauseClump : byte; const pausePC : Word) : boolean; virtual; abstract;
    function DCGetPropDebugging(var debugging : boolean; var pauseClump : byte; var pausePC : Word) : boolean; virtual; abstract;
    function DCSetVMState(const state : byte) : boolean; virtual; abstract;
    function DCSetVMStateEx(var state : byte; var clump : byte; var pc : word) : boolean; virtual; abstract;
    function DCGetVMState(var state : byte; var clump : byte; var pc : word) : boolean; virtual; abstract;
    // NXT system commands
    function SCOpenRead(const filename : string; var handle : FantomHandle;
      var size : cardinal) : boolean; virtual; abstract;
    function SCOpenWrite(const filename : string; const size : cardinal;
      var handle : FantomHandle) : boolean; virtual; abstract;
    function SCRead(var handle : FantomHandle; var count : word;
      var buffer : PBRDataBuffer) : boolean; virtual; abstract;
    function SCWrite(var handle : FantomHandle; const buffer : PBRDataBuffer;
      var count : word; const chkResponse : boolean = false) : boolean; virtual; abstract;
    function SCCloseFile(var handle : FantomHandle; const chkResponse: boolean = false) : boolean; virtual; abstract;
    function SCDeleteFile(var filename : string; const chkResponse: boolean = false) : boolean; virtual; abstract;
    function SCFindFirstFile(var filename : string; var IterHandle : FantomHandle; var filesize, availsize : cardinal) : boolean; virtual; abstract;
    function SCFindNextFile(var IterHandle : FantomHandle; var filename : string; var filesize, availsize : cardinal) : boolean; virtual; abstract;
    function SCFindClose(var IterHandle : FantomHandle) : boolean; virtual; abstract;
    function SCGetVersions(var protmin, protmaj, firmmin, firmmaj : byte) : boolean; virtual; abstract;
    function SCOpenWriteLinear(const filename : string; const size : cardinal;
      var handle : FantomHandle) : boolean; virtual; abstract;
    function SCOpenReadLinear(const filename : string; var handle : FantomHandle;
      var size : cardinal) : boolean; virtual; abstract;
    function SCOpenWriteData(const filename : string; const size : cardinal;
      var handle : FantomHandle) : boolean; virtual; abstract;
    function SCOpenAppendData(const filename : string; var size : cardinal;
      var handle : FantomHandle) : boolean; virtual; abstract;
    function SCCloseModuleHandle(var handle : FantomHandle; const chkResponse: boolean = false) : boolean; virtual; abstract;
    function SCBootCommand(const chkResponse: boolean = false) : boolean; virtual; abstract;
    function SCSetBrickName(const name : string; const chkResponse: boolean = false) : boolean; virtual; abstract;
    function SCGetDeviceInfo(var name : string; var BTAddress : string;
      var BTSignal : Cardinal; var memFree : Cardinal) : boolean; virtual; abstract;
    function SCFreeMemory : integer; virtual;
    function SCDeleteUserFlash(const chkResponse: boolean = false) : boolean; virtual; abstract;
    function SCBTFactoryReset(const chkResponse: boolean = false) : boolean; virtual; abstract;
    function SCPollCommandLen(const bufNum : byte; var count : byte) : boolean; virtual; abstract;
    function SCPollCommand(const bufNum : byte; var count : byte;
      var buffer : PBRDataBuffer) : boolean; virtual; abstract;
    function SCWriteIOMap(var ModID : Cardinal; const Offset : Word;
      var count : Word; const buffer : PBRDataBuffer; chkResponse : Boolean = False) : boolean; overload; virtual; abstract;
    function SCWriteIOMap(var ModID : Cardinal; const Offset : Word;
      var count : Word; buffer : PChar; chkResponse : Boolean = False) : boolean; overload; virtual; abstract;
    function SCReadIOMap(var ModID : Cardinal; const Offset : Word;
      var count : Word; var buffer : PBRDataBuffer) : boolean; overload; virtual; abstract;
    function SCReadIOMap(var ModID : Cardinal; const Offset : Word;
      var count : Word; buffer : PChar) : boolean; overload; virtual; abstract;
    function SCFindFirstModule(var ModName : string; var Handle : FantomHandle;
      var ModID, ModSize : Cardinal; var IOMapSize : Word) : boolean; virtual; abstract;
    function SCFindNextModule(var Handle : FantomHandle; var ModName : string;
      var ModID, ModSize : Cardinal; var IOMapSize : Word) : boolean; virtual; abstract;
    function SCRenameFile(const old, new : string; const chkResponse: boolean = false) : boolean; virtual; abstract;
    // wrapper functions
    function DownloadFile(const filename : string; const filetype : TPBRFileType) : boolean; virtual; abstract;
    function DownloadStream(aStream : TStream; const dest : string; const filetype : TPBRFileType) : boolean; virtual; abstract;
    function UploadFile(const filename : string; const dir : string = '') : boolean; virtual; abstract;
    function UploadFileToStream(const filename : string; aStream : TStream) : boolean; virtual; abstract;
    function ListFiles(const searchPattern : string; Files : TStrings) : boolean; virtual; abstract;
    function ListModules(const searchPattern : string; Modules : TStrings) : boolean; virtual; abstract;
    function ListBricks(Bricks : TStrings) : boolean; virtual; abstract;
    function InitializeResourceNames : boolean; virtual;
    function UpdateResourceNames : boolean; virtual;
    function SCDefragmentFlash : Boolean; virtual;
    function SCBTDeviceCount : integer;
    function SCBTDeviceNameCount : integer;
    function SCBTDevice(idx : byte) : NXTDevice;
    function SCBTConnection(conn : byte) : NXTConnection;
    function SCFirmwareVersion : word; virtual;
    function SCInstalledFirmware : TInstalledFirmware; virtual;
    function SCGetBrickName : string;
    function PlayDownloadCompletedSound : boolean; virtual;

    // properties
    property  EEPROM[addr : Byte] : Byte read GetEEPROM write SetEEPROM;
    property  EEPROMBlocks[idx : Integer] : EEPROMBlock read GetEEPROMBlock;
    property  NXTLowSpeed[port : byte] : NXTLSBlock read GetLSBlock write SetLSBlock;
    property  IsOpen : boolean read GetIsOpen;
    property  FastMode : boolean read fFastMode write SetFastMode;
    property  UseBluetooth : boolean read GetUseBT write SetUseBT;
    property  BluetoothName : string read fBTName write SetBTName;
    property  BluetoothSearchTimeout : Cardinal read fBST write fBST;
    property  SearchBluetooth : boolean read fSearchBT write fSearchBT;
    property  Quiet : Boolean read GetQuiet write SetQuiet;
    property  BrickType : byte read FBrickType write SetBrickType;
    property  Port : string read fPort write SetPort;
    property  PortName : string read GetPortName;
    property  NicePortName : string read GetNicePortName;
    property  FullPortName : string read GetFullPortName;
    property  BrickTypeName : string read GetBrickTypeName;
    property  RxTimeout : Word read GetRxTimeout write SetRxTimeout;
    property  VerboseMode : boolean read fVerbose write SetVerbose;
    property  AutoClose : boolean read fAutoClose write fAutoClose;
    property  DataLog : TStrings read fDataLog;
    property  MemoryMap : TStrings read fMemMap;
    property  MemoryData : TStrings read fMemData;
    property  TowerExistsSleep : Word read fTowerExistsSleep write fTowerExistsSleep;
    property  LinkLog : String read GetLinkLog;
    property  RCXFirmwareChunkSize : Integer read GetRCXFirmwareChunkSize write SetRCXFirmwareChunkSize;
    property  DownloadWaitTime : Integer read GetDownloadWaitTime write SetDownloadWaitTime;
    property  OmitHeader : Boolean read GetOmitHeader write SetOmitHeader;
    property  TheProgram : TProgram read fProgram write fProgram;
    property  NXTUseMailbox : boolean read fNXTUseMailbox write fNXTUseMailbox;
    property  NXTMailboxNum : integer read fNXTMailboxNum write fNXTMailboxNum;
    property  ErrorStatus : integer read GetErrorStatus;
    property  BrickFolder : string read fBrickFolder write fBrickFolder;
    property  Layer : byte read fLayer write fLayer;
    property  PowerScaleFactor : byte read fPowerScaleFactor write fPowerScaleFactor;
    property  OnDownloadStart : TNotifyEvent read fOnDownloadStart write fOnDownloadStart;
    property  OnDownloadDone : TNotifyEvent read fOnDownloadDone write fOnDownloadDone;
    property  OnDownloadStatus : TDownloadStatusEvent read fOnDownloadStatus write fOnDownloadStatus;
    property  OnOpenStateChanged : TNotifyEvent read fOnOpenStateChanged write fOnOpenStateChanged;
    property  OnGetVarInfoByID : TGetVarInfoByIDEvent read fOnGetVarInfoByID write fOnGetVarInfoByID;
    property  OnGetVarInfoByName : TGetVarInfoByNameEvent read fOnGetVarInfoByName write fOnGetVarInfoByName;
    property  OnDataSending : TDataSendReceiveEvent read fOnDataSending write fOnDataSending;
    property  OnDataReceiving : TDataSendReceiveEvent read fOnDataReceiving write fOnDataReceiving;
  end;

function MakeValidNXTFilename(const filename : string) : string;
function GetInitFilename: string;
function FantomAPIAvailable : boolean;
procedure LoadKnownPorts(aStrings : TStrings);
function InstalledFirmwareAsString(const ifw : TInstalledFirmware) : string;
procedure LoadLSBlock(var aBlock : NXTLSBlock; addr : byte; str : string; rxCount : integer);
function PortIsUSB(const aPort : string) : Boolean;

implementation

uses
  SysUtils, uGlobals, uNXTConstants,
  {$IFNDEF FPC}
  FANTOM
  {$ELSE}
  {$IFDEF Darwin}fantomosx{$ENDIF}
  {$IFNDEF Darwin}
  {$IFDEF Unix}fantomfpc{$ENDIF}
  {$IFDEF Windows}FANTOM{$ENDIF}
  {$ENDIF}
  {$ENDIF};

function PortIsUSB(const aPort : string) : Boolean;
begin
  Result := (aPort = 'usb') or (Pos('usb', LowerCase(aPort)) = 1);
end;

function InstalledFirmwareAsString(const ifw : TInstalledFirmware) : string;
const
  FWSTR : array[TInstalledFirmware] of string = ('unknown', 'standard', 'enhanced');
begin
  Result := FWSTR[ifw];
end;

function FantomAPIAvailable : boolean;
begin
  Result := FantomAPILoaded;
end;

procedure LoadKnownPorts(aStrings : TStrings);
var
  i : integer;
  SL : TStringList;
  name : string;
begin
  name := GetInitFilename;
  if FileExists(name) then
  begin
    SL := TStringList.Create;
    try
      SL.LoadFromFile(name);
      for i := 0 to SL.Count - 1 do
        aStrings.Add(SL.Names[i]);
      for i := 0 to SL.Count - 1 do
        aStrings.Add(SL.Values[SL.Names[i]]);
    finally
      SL.Free;
    end;
  end;
end;

function MakeValidNXTFilename(const filename : string) : string;
begin
  Result := ExtractFileName(filename);
  Result := Copy(ChangeFileExt(Result, ''), 1, 15) + ExtractFileExt(Result);
end;

procedure LoadLSBlock(var aBlock : NXTLSBlock; addr : byte; str : string; rxCount : integer);
var
  i : integer;
  tmpStr : string;
begin
  aBlock.Data[0] := addr;
  // str is hex 2-digit values separated by space or comma
  i := 1;
  while Length(str) > 0 do
  begin
    tmpStr := '$' + Copy(str, 1, 2);
    aBlock.Data[i] := StrToIntDef(tmpStr, 0);
    System.Delete(str, 1, 3);
    inc(i);
  end;
  aBlock.TXCount := i;
  aBlock.RXCount := rxCount;
end;

{ TBrickComm }

constructor TBrickComm.Create(aType: byte; const aPort: string);
var
  i : integer;
begin
  inherited Create;
  fActive    := False;
  fFastMode  := False;
  fUseBT     := False;
  fAutoClose := False;
  fBrickType := aType;
  fPort      := aPort;
  fTowerExistsSleep := 30;
  fBST       := 30;
  fBTName    := '';
  fLocalIFW  := ifUnknown;
  fLocalFV   := 0;
  fSearchBT  := True;
  fNXTUseMailbox := False;
  fNXTMailboxNum := 9;
  fBrickFolder := '';
  fSoundMuted := False;
  fLayer := 0;
  fPowerScaleFactor := 0;
  
  for i := 0 to 15 do
  begin
    fMotorPower[i] := 4;
    fMotorForward[i] := True;
    fMotorOn[i] := False;
  end;

  for i := 0 to 15 do
  begin
    fSensorType[i] := 0;
    fSensorMode[i] := 0;
  end;

  fDatalog := TStringList.Create;
  fMemMap  := TStringList.Create;
  fMemData := TStringList.Create;
end;

destructor TBrickComm.Destroy;
begin
  Close;
  FreeAndNil(fDatalog);
  FreeAndNil(fMemMap);
  FreeAndNil(fMemData);
  inherited Destroy;
end;

procedure TBrickComm.DoDownloadDone;
begin
  if Assigned(fOnDownloadDone) then
    fOnDownloadDone(self);
end;

procedure TBrickComm.DoDownloadStart;
begin
  if Assigned(fOnDownloadStart) then
    fOnDownloadStart(self);
end;

procedure TBrickComm.DoDownloadStatus(cur, total: Integer; var Abort: boolean);
begin
  Abort := False;
  if Assigned(fOnDownloadStatus) then
    fOnDownloadStatus(Self, cur, total, Abort);
end;

procedure TBrickComm.DoOpenStateChanged;
begin
  if Assigned(fOnOpenStateChanged) then
    fOnOpenStateChanged(self);
end;

procedure TBrickComm.DoDataReceive(Data: array of byte);
begin
  if Assigned(fOnDataReceiving) then
    fOnDataReceiving(Self, False, Data);
end;

procedure TBrickComm.DoDataReceive(Data : string);
var
  tmpData : array of byte;
  i : integer;
begin
  SetLength(tmpData, Length(Data));
  for i := 0 to Length(Data)-1 do
    tmpData[i] := Byte(Data[i+1]);
  DoDataReceive(tmpData);
end;

procedure TBrickComm.DoDataReceive(Data : byte);
var
  tmpData : array of byte;
begin
  SetLength(tmpData, 1);
  tmpData[0] := Data;
  DoDataReceive(tmpData);
end;

procedure TBrickComm.DoDataSend(Data: array of byte);
begin
  if Assigned(fOnDataSending) then
    fOnDataSending(Self, True, Data);
end;

procedure TBrickComm.DoDataSend(Data : string);
var
  tmpData : array of byte;
  i : integer;
begin
  SetLength(tmpData, Length(Data));
  for i := 0 to Length(Data)-1 do
    tmpData[i] := Byte(Data[i+1]);
  DoDataSend(tmpData);
end;

procedure TBrickComm.DoDataSend(Data : byte);
var
  tmpData : array of byte;
begin
  SetLength(tmpData, 1);
  tmpData[0] := Data;
  DoDataSend(tmpData);
end;

procedure TBrickComm.DoGetVarInfoByID(const id: integer; var offset, size, vartype: integer);
var
  DSE : TDSTocEntry;
begin
  offset  := -1;
  size    := -1;
  vartype := -1;
  if Assigned(fOnGetVarInfoByID) then
    fOnGetVarInfoByID(Self, id, offset, size, vartype)
  else if Assigned(fProgram) then
  begin
    // read offset, size, and vartype from compiler symbol table output
    if fProgram.Dataspace.Count > ID then
    begin
      DSE     := fProgram.Dataspace[ID];
      offset  := DSE.Offset;
      size    := DSE.Size;
      vartype := Ord(DSE.DataType);
    end;
  end;
end;

procedure TBrickComm.DoGetVarInfoByName(const name: string; var offset, size, vartype: integer);
var
  DSE : TDSTocEntry;
  ID : integer;
begin
  offset  := -1;
  size    := -1;
  vartype := -1;
  if Assigned(fOnGetVarInfoByName) then
    fOnGetVarInfoByName(Self, name, offset, size, vartype)
  else if Assigned(fProgram) then
  begin
    // read offset, size, and vartype from compiler symbol table output
    if fProgram.Dataspace.Count > 0 then
    begin
      ID := fProgram.Dataspace.IndexOfName(name);
      if ID <> -1 then
      begin
        DSE     := fProgram.Dataspace[ID];
        offset  := DSE.Offset;
        size    := DSE.Size;
        vartype := Ord(DSE.DataType);
      end;
    end;
  end;
end;

function TBrickComm.GetBrickTypeName: string;
const
  BrickNames : array[rtRCX..rtEV3] of String = (K_RCX, K_CYBER, K_SCOUT, K_RCX2,
    K_SPY, K_SWAN, K_NXT, K_SPRO, K_EV3);
begin
  Result := BrickNames[BrickType];
end;

function TBrickComm.GetIsOpen: boolean;
begin
  Result := FActive;
end;

function TBrickComm.GetFullPortName: string;
begin
  Result := PortName;
end;

function TBrickComm.GetNicePortName: string;
begin
  Result := Copy(PortName, 5, 15);
end;

function TBrickComm.GetPortName: string;
begin
  Result := fPort;
end;

function TBrickComm.GetUseBT: Boolean;
begin
  Result := fUseBT;
end;

procedure TBrickComm.SetBrickType(const Value: byte);
begin
  fBrickType := Value;
end;

procedure TBrickComm.SetBTName(const Value: string);
begin
  if fBTName <> Value then
  begin
    Close;
    fBTName := Value;
  end;
end;

procedure TBrickComm.SetFastMode(const Value: boolean);
begin
  if fFastMode <> Value then
  begin
    Close;
    fFastMode := Value;
  end;
end;

procedure TBrickComm.SetPort(const Value: string);
begin
  fPort := Value;
end;

procedure TBrickComm.SetUseBT(const Value: boolean);
begin
  if fUseBT <> Value then
  begin
    Close;
    fUseBT := Value;
  end;
end;

procedure TBrickComm.SetVerbose(const Value: boolean);
begin
  fVerbose := Value;
end;

function IsLinear(const ext : string) : Boolean;
begin
  Result := (ext = '.rxe') or (ext = '.ric');
end;

function DefragFileCompare(List: TStringList; Index1, Index2: Integer): Integer;
var
  f1, f2 : string;
  size1, size2 : integer;
  l1, l2 : boolean;
begin
  f1 := List.Names[Index1];
  f2 := List.Names[Index2];
  size1 := StrToIntDef(List.Values[f1], 0);
  size2 := StrToIntDef(List.Values[f2], 0);
  l1 := IsLinear(ExtractFileExt(f1));
  l2 := IsLinear(ExtractFileExt(f2));
  if (l1 = l2) then
  begin
    if size1 = size2 then
      Result := 0
    else if size1 < size2 then
      Result := 1
    else
      Result := -1;
  end
  else if l1 and not l2 then
    Result := -1
  else
    Result := 1;
end;

function TBrickComm.SCDefragmentFlash: Boolean;
var
  origFileList : TStringList;
  i : integer;
  filename : string;
begin
  origFileList := TStringList.Create;
  try
    Result := ListFiles('*.*', origFileList);
    // if there aren't any files then we are nearly done.
    if origFileList.Count > 0 then
    begin
      // upload all files
      Result := UploadFile('*.*', UserDataLocalPath);
      if Result then
      begin
        // in theory we have all the files in our list now
        // let's just quickly make sure.
        for i := 0 to origFileList.Count - 1 do begin
          if not FileExists(UserDataLocalPath + origFileList.Names[i]) then
          begin
            // do something clever here???
            Result := False;
            Exit;
          end;
        end;
        // ok.
        Result := ClearMemory;
        if Result then
        begin
          // we are committed now.
          // figure out the correct order using the file ext
          // (.rxe or .ric first) and file size (within each category
          // of file type.
          origFileList.CustomSort(@DefragFileCompare);
          // now download these files in order
          for i := 0 to origFileList.Count - 1 do begin
            filename := origFileList.Names[i];
            Result := DownloadFile(UserDataLocalPath + filename, NXTNameToPBRFileType(filename));
            if not Result then begin
              // do something clever here
              Exit;
            end;
          end;
          // if we were able to download all the files we uploaded then
          // it is safe to delete them from the PC
          for i := 0 to origFileList.Count - 1 do begin
            // delete files locally
            Result := SysUtils.DeleteFile(UserDataLocalPath + origFileList.Names[i]);
          end;
        end;
      end;
    end
    else
    begin
      // even if there aren't any files we clear the flash
      Result := ClearMemory;
    end;
  finally
    FreeAndNil(origFileList);
  end;
end;

function TBrickComm.SCGetBrickName: string;
var
  btsig, memfree : Cardinal;
  tmpAddr : string;
begin
  Result  := '';
  tmpAddr := '';
  memfree := 0;
  btsig   := 0;
  SCGetDeviceInfo(Result, tmpAddr, btsig, memfree);
end;

function TBrickComm.PlayDownloadCompletedSound : boolean;
begin
  Result := False;
end;

function GetInitFilename: string;
begin
  Result := UserDataLocalPath+'bricks.dat';
end;

function TBrickComm.SCFirmwareVersion: word;
var
  pmin, pmaj, fmin, fmaj : byte;
begin
  Result := fLocalFV;
  if Result = 0 then
  begin
    pmin := 0; pmaj := 0; fmin := 0; fmaj := 0;
    if SCGetVersions(pmin, pmaj, fmin, fmaj) then
      Result := fmaj*100 + fmin;
    fLocalFV := Result;
  end;
end;

function TBrickComm.SCInstalledFirmware: TInstalledFirmware;
var
  state, clump : byte;
  pc : word;
begin
  Result := fLocalIFW;
  if IsOpen and (Result = ifUnknown) then
  begin
    // if we can call a direct command that only exists in the enhanced firmware
    // then we know that it is enhanced.
    state := 0; clump := 0; pc := 0; 
    if DCGetVMState(state, clump, pc) then
      Result := ifEnhanced
    else
      Result := ifStandard;
    fLocalIFW := Result;
  end;
end;

function TBrickComm.Close: boolean;
begin
  Result := True;
  fLocalFV := 0;
  fLocalIFW := ifUnknown;
end;

function TBrickComm.SCBTDeviceCount: integer;
var
  buffer : PBRDataBuffer;
  modID : Cardinal;
  count : Word;
begin
  Result := 0;
  // IOMapRead CommOffsetBtDeviceCnt
  modID := kNXT_ModuleComm;
  count := 1;
  buffer.Data[0] := 0;
  if SCReadIOMap(modID, CommOffsetBtDeviceCnt, count, buffer) then
    Result := buffer.Data[0];
end;

function TBrickComm.SCBTDeviceNameCount: integer;
var
  buffer : PBRDataBuffer;
  modID : Cardinal;
  count : Word;
begin
  Result := 0;
  // IOMapRead CommOffsetBtDeviceNameCnt
  modID := kNXT_ModuleComm;
  count := 1;
  buffer.Data[0] := 0;
  if SCReadIOMap(modID, CommOffsetBtDeviceNameCnt, count, buffer) then
    Result := buffer.Data[0];
end;

function TBrickComm.SCBTConnection(conn: byte): NXTConnection;
var
  buffer : PBRDataBuffer;
  modID : Cardinal;
  count : Word;
begin
  FillChar(Result, SizeOf(Result), 0);
  // IOMapRead CommOffsetBtDeviceNameCnt
  modID := kNXT_ModuleComm;
  count := SizeOf(Result);
  buffer.Data[0] := 0;
  if SCReadIOMap(modID, CommOffsetBtConnectTableName(conn), count, buffer) then
    Move(PByte(@(buffer.Data[0]))^, Result, count);
end;

function TBrickComm.SCBTDevice(idx: byte): NXTDevice;
var
  buffer : PBRDataBuffer;
  modID : Cardinal;
  count : Word;
begin
  FillChar(Result, SizeOf(Result), 0);
  // IOMapRead CommOffsetBtDeviceNameCnt
  modID := kNXT_ModuleComm;
  count := SizeOf(Result);
  buffer.Data[0] := 0;
  if SCReadIOMap(modID, CommOffsetBtDeviceTableName(idx), count, buffer) then
    Move(PByte(@(buffer.Data[0]))^, Result, count);
end;

function TBrickComm.GetErrorStatus: integer;
begin
  Result := Abs(fStatus);
end;

function TBrickComm.VersionString: string;
var
  rom, ram : cardinal;
begin
  rom := 0;
  ram := 0;
  Version(rom, ram);
  Result := Format('%d%d.%d%d / %d%d.%d%d',
    [(rom and $FF000000) shr 24, (rom and $00FF0000) shr 16,
     (rom and $0000FF00) shr 8,  (rom and $000000FF),
     (ram and $FF000000) shr 24, (ram and $00FF0000) shr 16,
     (ram and $0000FF00) shr 8,  (ram and $000000FF)]);

end;

function TBrickComm.SCFreeMemory: integer;
var
  memFree, BTSig : Cardinal;
  nxtName, nxtAddr : string;
begin
  Result  := 0;
  memFree := 0;
  BTSig   := 0;
  nxtName := '';
  nxtAddr := '';
  if SCGetDeviceInfo(nxtName, nxtAddr, BTSig, memFree) then
  begin
    Result := memFree;
  end;
end;

function TBrickComm.TransportTypes: TTransportTypes;
begin
  Result := [ttUSB, ttSER];
end;

function TBrickComm.InitializeResourceNames : boolean;
var
  SL : TStringList;
  name : string;
begin
  SL := TStringList.Create;
  try
    Result := ListBricks(SL);
    name := GetInitFilename;
    ForceDirectories(ExtractFilePath(name));
    SL.Sort;
    SL.SaveToFile(name);
  finally
    SL.Free;
  end;
end;

function TBrickComm.UpdateResourceNames : boolean;
var
  SL, tmpSL : TStringList;
  fname : string;
begin
  SL := TStringList.Create;
  try
    SL.Sorted := True;
    SL.Duplicates := dupIgnore;
    tmpSL := TStringList.Create;
    try
      Result := ListBricks(tmpSL);
      fname := GetInitFilename;
      if FileExists(fname) then
        SL.LoadFromFile(fname);
      SL.AddStrings(tmpSL);
      ForceDirectories(ExtractFilePath(fname));
      SL.SaveToFile(fname);
    finally
      tmpSL.Free;
    end;
  finally
    SL.Free;
  end;
end;

end.
