unit uSpirit;

interface

uses
  rcx_constants, Classes;

const
  K_RCX   = 'RCX';
  K_CYBER = 'CyberMaster';
  K_SCOUT = 'Scout';
  K_RCX2  = 'RCX2';
  K_SPY   = 'Spybot';
  K_SWAN  = 'Swan';
  K_NXT   = 'NXT';

const
  rtRCX         = 0;
  rtCybermaster = 1;
  rtScout       = 2;
  rtRCX2        = 3;
  rtSpy         = 4;
  rtSwan        = 5;
  rtNXT         = 6;

const
  SU_RCX         = rtRCX;
  SU_CYBERMASTER = rtCybermaster;
  SU_SCOUT       = rtScout;
  SU_RCX2        = rtRCX2;
  SU_SPYBOTIC    = rtSpy;
  SU_SWAN        = rtSwan;
  SU_NXT         = rtNXT;

const
  MAX_COMPORT   = 8;
  MAX_USBPORT   = MAX_COMPORT+4;

const
  // remote commands
  kRemoteKeysReleased = $0000;
  kRemotePBMessage1   = $0100;
  kRemotePBMessage2   = $0200;
  kRemotePBMessage3   = $0400;
  kRemoteOutAForward  = $0800;
  kRemoteOutBForward  = $1000;
  kRemoteOutCForward  = $2000;
  kRemoteOutABackward = $4000;
  kRemoteOutBBackward = $8000;
  kRemoteOutCBackward = $0001;
  kRemoteSelProgram1  = $0002;
  kRemoteSelProgram2  = $0004;
  kRemoteSelProgram3  = $0008;
  kRemoteSelProgram4  = $0010;
  kRemoteSelProgram5  = $0020;
  kRemoteStopOutOff   = $0040;
  kRemotePlayASound   = $0080;

type
  TBrickType = rtRCX..rtNXT;
  TDownloadStatusEvent = procedure(Sender : TObject; cur, total : Integer; var Abort : boolean) of object;
  TPortNum = 1..MAX_USBPORT;

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
    Data : array[0..kNXT_MaxBytes-1] of Byte;
  end;

  TPBRFileType = (nftProgram, nftGraphics, nftSound, nftData, nftOther, nftFirmware);

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
  TMotorsNum = 1..7;

  EEPROMBlock = record
    Data : array[0..15] of Byte;
  end;

  TBrickComm = class
  private
  protected
    fActive : boolean;
    fAutoClose: boolean;
    fBrickType: TBrickType;
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
    fPort: string;
    fTowerExistsSleep: Word;
    fUseBT: boolean;
    fVerbose: boolean;
    fMotorPower : array[0..2] of byte;
    fMotorForward : array[0..2] of boolean;
    fMotorOn : array[0..2] of boolean;
    fSensorType : array[0..3] of integer;
    fSensorMode : array[0..3] of integer;
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
    procedure SetBrickType(const Value: TBrickType); virtual;
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
  public
    constructor Create(aType : TBrickType = 0; const aPort : string = 'COM1'); virtual;
    destructor Destroy; override;

    function  Open : boolean; virtual; abstract;
    function  Close : boolean; virtual; abstract;

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
    function TransmitPower(aLevel : TTransmitLevel) : boolean; virtual; abstract;

    function Poll(aSrc, aNum : integer) : integer; virtual; abstract;
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
    function GetVariableValue(aVar: integer): integer; virtual; abstract;
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
    function SendRemote(aEvent : string; aRepeat : integer = 1) : boolean; overload; virtual; abstract;
    function SendRemote(aEvent : Word; aRepeat : integer = 1) : boolean; overload; virtual; abstract;
    function SendMessage(aMsg : integer) : boolean; overload; virtual; abstract;

    // RCX/2 only
    function SelectProgram(aProg : integer) : boolean; virtual; abstract;
    function SelectDisplay(aSrc, aNumber : integer) : boolean; virtual; abstract;
    function SetWatch(aHrs, aMins : integer) : boolean; overload; virtual; abstract;
    function SetWatch(aTime : string) : boolean; overload; virtual; abstract;
    function DownloadFirmware(aFile : string; bFast, bComp, bUnlock : boolean) : boolean; virtual; abstract;
    function SetDatalog(aSize : integer) : boolean; virtual; abstract;
    function DatalogNext(aSrc, aNum : integer) : boolean; virtual; abstract;
    function UploadDatalog(aFrom, aSize : integer) : TStrings; overload; virtual; abstract;
    function UploadDatalog(bVerbose : boolean) : TStrings; overload; virtual; abstract;

    // CM only methods
    function Drive(aLeft, aRight : integer) : boolean; virtual; abstract;
    function ClearTachoCounter(aMotorList : Byte) : boolean; virtual; abstract;
    function OnWait(aMotorList : Byte; aNum : integer; aTime : Byte) : boolean; virtual; abstract;
    function OnWaitDifferent(aMotorList : Byte; aNum0, aNum1, aNum2 : integer; aTime : Byte) : boolean; virtual; abstract;

    // Scout only methods
    function Scout(aVal : integer) : boolean; overload; virtual; abstract;
    function Scout(bPower : boolean = true) : boolean; overload; virtual; abstract;
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
    function StartProgram(const filename : string) : boolean; virtual; abstract;
    function StopProgram : boolean; virtual; abstract;
    function PlaySoundFile(const filename : string; bLoop : boolean) : boolean; virtual; abstract;
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
    function ResetInputScaledValue(const port : byte) : boolean; virtual; abstract;
    function ResetOutputPosition(const port : byte; const Relative : boolean) : boolean; virtual; abstract;
    function MessageWrite(const inbox : byte; const msg : string) : boolean; overload; virtual; abstract;
    function KeepAlive(var time : cardinal; const chkResponse : boolean = true) : boolean; virtual; abstract;
    function LSGetStatus(port : byte; var bytesReady : byte) : boolean; virtual; abstract;
    function GetCurrentProgramName(var name : string) : boolean; virtual; abstract;
    function GetButtonState(const idx : byte; const reset : boolean;
      var pressed : boolean; var count : byte) : boolean; virtual; abstract;
    function MessageRead(const remote, local : byte; const remove : boolean; var Msg : PBRMessage) : boolean; virtual; abstract;
    // NXT system commands
    function SCOpenRead(const filename : string; var handle : cardinal;
      var size : cardinal) : boolean; virtual; abstract;
    function SCOpenWrite(const filename : string; const size : cardinal;
      var handle : cardinal) : boolean; virtual; abstract;
    function SCRead(var handle : cardinal; var count : word;
      var buffer : PBRDataBuffer) : boolean; virtual; abstract;
    function SCWrite(var handle : cardinal; const buffer : PBRDataBuffer;
      var count : word; const chkResponse : boolean = false) : boolean; virtual; abstract;
    function SCCloseFile(var handle : cardinal; const chkResponse: boolean = false) : boolean; virtual; abstract;
    function SCDeleteFile(var filename : string; const chkResponse: boolean = false) : boolean; virtual; abstract;
    function SCFindFirstFile(var filename : string; var handle : cardinal; var filesize : cardinal) : boolean; virtual; abstract;
    function SCFindNextFile(var handle : cardinal; var filename : string; var filesize : cardinal) : boolean; virtual; abstract;
    function SCGetVersions(var protmin, protmaj, firmmin, firmmaj : byte) : boolean; virtual; abstract;
    function SCOpenWriteLinear(const filename : string; const size : cardinal;
      var handle : cardinal) : boolean; virtual; abstract;
    function SCOpenReadLinear(const filename : string; var handle : cardinal;
      var size : cardinal) : boolean; virtual; abstract;
    function SCOpenWriteData(const filename : string; const size : cardinal;
      var handle : cardinal) : boolean; virtual; abstract;
    function SCOpenAppendData(const filename : string; var size : cardinal;
      var handle : cardinal) : boolean; virtual; abstract;
    function SCCloseModuleHandle(var handle : cardinal; const chkResponse: boolean = false) : boolean; virtual; abstract;
    function SCBootCommand(const chkResponse: boolean = false) : boolean; virtual; abstract;
    function SCSetBrickName(const name : string; const chkResponse: boolean = false) : boolean; virtual; abstract;
    function SCGetBrickName : string;
    function SCGetDeviceInfo(var name : string; BTAddress : PByte;
      var BTSignal : Cardinal; var memFree : Cardinal) : boolean; virtual; abstract;
    function SCFreeMemory : integer; virtual; abstract;
    function SCDeleteUserFlash(const chkResponse: boolean = false) : boolean; virtual; abstract;
    function SCBTFactoryReset(const chkResponse: boolean = false) : boolean; virtual; abstract;
    function SCPollCommandLen(const bufNum : byte; var count : byte) : boolean; virtual; abstract;
    function SCPollCommand(const bufNum : byte; var count : byte;
      var buffer : PBRDataBuffer) : boolean; virtual; abstract;
    function SCWriteIOMap(var ModID : Cardinal; const Offset : Word;
      var count : Word; const buffer : PBRDataBuffer; chkResponse : Boolean = False) : boolean; virtual; abstract;
    function SCReadIOMap(var ModID : Cardinal; const Offset : Word;
      var count : Word; var buffer : PBRDataBuffer) : boolean; virtual; abstract;
    function SCFindFirstModule(var ModName : string; var Handle : cardinal;
      var ModID, ModSize : Cardinal; var IOMapSize : Word) : boolean; virtual; abstract;
    function SCFindNextModule(var Handle : cardinal; var ModName : string;
      var ModID, ModSize : Cardinal; var IOMapSize : Word) : boolean; virtual; abstract;
    function SCRenameFile(const old, new : string; const chkResponse: boolean = false) : boolean; virtual; abstract;
{
  kNXT_SCGetBTAddress          = $9A;
}
    // wrapper functions
    function DownloadFile(const filename : string; const filetype : TPBRFileType) : boolean; virtual; abstract;
    function DownloadStream(aStream : TStream; const dest : string; const filetype : TPBRFileType) : boolean; virtual; abstract;
    function UploadFile(const filename : string; const dir : string = '') : boolean; virtual; abstract;
    function ListFiles(const searchPattern : string; Files : TStrings) : boolean; virtual; abstract;
    function ListModules(const searchPattern : string; Modules : TStrings) : boolean; virtual; abstract;
    function ListBricks(Bricks : TStrings) : boolean; virtual; abstract;
    procedure InitializeResourceNames; virtual; abstract;
    function SCDefragmentFlash : Boolean; virtual;

    // properties
    property  EEPROM[addr : Byte] : Byte read GetEEPROM write SetEEPROM;
    property  EEPROMBlock[idx : Integer] : EEPROMBlock read GetEEPROMBlock;
    property  NXTLowSpeed[port : byte] : NXTLSBlock read GetLSBlock write SetLSBlock;
    property  IsOpen : boolean read GetIsOpen;
    property  FastMode : boolean read fFastMode write SetFastMode;
    property  UseBluetooth : boolean read GetUseBT write SetUseBT;
    property  BluetoothName : string read fBTName write SetBTName;
    property  BluetoothSearchTimeout : Cardinal read fBST write fBST;
    property  Quiet : Boolean read GetQuiet write SetQuiet;
    property  BrickType : TBrickType read FBrickType write SetBrickType;
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
    property  OnDownloadStart : TNotifyEvent read fOnDownloadStart write fOnDownloadStart;
    property  OnDownloadDone : TNotifyEvent read fOnDownloadDone write fOnDownloadDone;
    property  OnDownloadStatus : TDownloadStatusEvent read fOnDownloadStatus write fOnDownloadStatus;
    property  OnOpenStateChanged : TNotifyEvent read fOnOpenStateChanged write fOnOpenStateChanged;
  end;

function NXTNameToPBRFileType(name : string) : TPBRFileType;
function MakeValidNXTFilename(const filename : string) : string;
function GetInitFilename: string;
function FantomAPIAvailable : boolean;
procedure LoadNXTPorts(aStrings : TStrings);

implementation

uses
  SysUtils, {$IFNDEF FPC}FANTOM, SHFolder, Windows{$ELSE}FANTOMFPC{$ENDIF};

{$IFNDEF FPC}
function GetSpecialFolderPath(folder : integer) : string;
const
  SHGFP_TYPE_CURRENT = 0;
var
  path: array [0..MAX_PATH] of char;
begin
  if SUCCEEDED(SHGetFolderPath(0,folder,0,SHGFP_TYPE_CURRENT,@path[0])) then
    Result := path
  else
    Result := '';
end;

function GetInitFilename: string;
begin
  Result := GetSpecialFolderPath(CSIDL_APPDATA{CSIDL_LOCAL_APPDATA})+'\JoCar Consulting\BricxCC\3.3\bricks.dat';
end;

{$ELSE}

function GetInitFilename: string;
begin
  Result := ExtractFilePath(ParamStr(0))+'bricks.dat';
end;

{$ENDIF}


function FantomAPIAvailable : boolean;
begin
  Result := FantomAPILoaded;
end;

procedure LoadNXTPorts(aStrings : TStrings);
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

function NXTNameToPBRFileType(name : string) : TPBRFileType;
var
  ext : string;
begin
  Result := nftOther;
  ext := AnsiLowercase(ExtractFileExt(name));
  if (ext = '.rso') or (ext = '.rmd') then
    Result := nftSound
  else if ext = '.rdt' then
    Result := nftData
  else if (ext = '.ric') or (ext = '.rbm') then
    Result := nftGraphics
  else if (ext = '.rxe') or (ext = '.sys') or (ext = '.rtm') or (ext = '.rpg') then
    Result := nftProgram
end;

function MakeValidNXTFilename(const filename : string) : string;
begin
  Result := ExtractFileName(filename);
  Result := Copy(ChangeFileExt(Result, ''), 1, 15) + ExtractFileExt(Result);
end;

{ TBrickComm }

constructor TBrickComm.Create(aType: TBrickType; const aPort: string);
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

  for i := 0 to 2 do
  begin
    fMotorPower[i] := 4;
    fMotorForward[i] := True;
    fMotorOn[i] := False;
  end;

  for i := 0 to 3 do
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
  fDatalog.Free;
  fMemMap.Free;
  fMemData.Free;
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

function TBrickComm.GetBrickTypeName: string;
const
  BrickNames : array[TBrickType] of String = (K_RCX, K_CYBER, K_SCOUT, K_RCX2,
    K_SPY, K_SWAN, K_NXT);
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

procedure TBrickComm.SetBrickType(const Value: TBrickType);
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
    // if there aren't any files then we are done.
    if origFileList.Count = 0 then Exit;
    // upload all files
    Result := UploadFile('*.*');
    if Result then
    begin
      // in theory we have all the files in our list now
      // let's just quickly make sure.
      for i := 0 to origFileList.Count - 1 do begin
        if not FileExists(origFileList.Names[i]) then
        begin
          // do something clever here???
          Result := False;
          Exit;
        end;
      end;
      // ok.
      Result := ClearMemory;
{
      for i := 0 to origFileList.Count - 1 do begin
        filename := origFileList.Names[i];
        Result := SCDeleteFile(filename, True);
        if not Result then begin
          // something clever here
          Exit;
        end;
      end;
}
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
          Result := DownloadFile(filename, NXTNameToPBRFileType(filename));
          if not Result then begin
            // do something clever here
            Exit;
          end;
        end;
        // if we were able to download all the files we uploaded then
        // it is safe to delete them from the PC
        for i := 0 to origFileList.Count - 1 do begin
          // delete files locally
          Result := SysUtils.DeleteFile(origFileList.Names[i]);
        end;
      end;
    end;
  finally
    FreeAndNil(origFileList);
  end;
end;

function TBrickComm.SCGetBrickName: string;
var
  bt : array[0..5] of byte;
  btsig, memfree : Cardinal;
begin
  Result := '';
  SCGetDeviceInfo(Result, @bt[0], btsig, memfree);
end;

end.