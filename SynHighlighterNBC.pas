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
unit SynHighlighterNBC;

{$I BricxCCSynEdit.inc}

interface

uses
  Classes,
  SynEditHighlighter,
  SynHighlighterHashEntries,
  SynEditTypes;

type
  TtkTokenKind = (tkComment, tkDirective, tkIdentifier, tkKey, tkCommand, tkConstant,
    tkNull, tkNumber, tkSpace, tkString, tkSymbol, tkUnknown);

  TRangeState = (rsUnKnown, rsCStyle, rsMultiLineDirective, rsMultilineString);

  TProcTableProc = procedure of object;

type
  TSynNBCSyn = class(TSynCustomHighlighter)
  private
    fLine: PChar;
    fLineNumber: Integer;
    fProcTable: array[#0..#255] of TProcTableProc;
    Run: LongInt;
    fRange: TRangeState;
    fStringLen: Integer;
    fToIdent: PChar;
    fTokenPos: Integer;
    fTokenID: TtkTokenKind;
    fCommentAttri: TSynHighlighterAttributes;
    fDirecAttri: TSynHighlighterAttributes;
    fIdentifierAttri: TSynHighlighterAttributes;
    fKeyAttri: TSynHighlighterAttributes;
    fCommandAttri: TSynHighlighterAttributes;
    fConstantAttri: TSynHighlighterAttributes;
    fNumberAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;
    fStringAttri: TSynHighlighterAttributes;
    fSymbolAttri: TSynHighlighterAttributes;
    fKeywords: TSynHashEntryList;
    fPreProcDirs : TStringList;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: String): Boolean;
    procedure CommentProc;
    procedure CRProc;
    procedure GreaterProc;
    procedure IdentProc;
    procedure LFProc;
    procedure LowerProc;
    procedure NullProc;
    procedure NumberProc;
    procedure SlashProc;
    procedure SpaceProc;
    procedure SingleQuoteStringProc;
    procedure SingleQuoteStringEndProc;
    procedure SymbolProc;
    procedure UnknownProc;
//    procedure DirectiveProc;
    procedure DoAddKeyword(AKeyword: string; AKind: integer);
    function IdentKind(MayBe: PChar): TtkTokenKind;
    procedure MakeMethodTables;
    procedure CStyleProc;
    function InvalidDirective(const dirname : string): boolean;
    procedure DirectiveEndProc;
    procedure AsciiCharProc;
  protected
    function GetIdentChars: TSynIdentChars; override;
    function GetSampleSource: string; override;
  public
    {$IFNDEF SYN_CPPB_1} class {$ENDIF}                                         //mh 2000-07-14
    function GetLanguageName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetRange: Pointer; override;
    procedure ResetRange; override;
    procedure SetRange(Value: Pointer); override;
    function GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
      override;
    function GetEol: Boolean; override;
    function GetTokenID: TtkTokenKind;
    procedure SetLine({$IFDEF FPC}const {$ENDIF}NewValue: String; LineNumber:Integer); override;
    function GetToken: String; override;
    {$IFDEF SYN_LAZARUS}
    procedure GetTokenEx(var TokenStart: PChar; var TokenLength: integer); override;
    {$ENDIF}
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;
    procedure Next; override;
  published
    property CommentAttri: TSynHighlighterAttributes read fCommentAttri write fCommentAttri;
    property DirectiveAttri: TSynHighlighterAttributes read fDirecAttri write fDirecAttri;
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri write fIdentifierAttri;
    property KeyAttri: TSynHighlighterAttributes read fKeyAttri write fKeyAttri;
    property CommandAttri: TSynHighlighterAttributes read fCommandAttri write fCommandAttri;
    property ConstantAttri: TSynHighlighterAttributes read fConstantAttri write fConstantAttri;
    property NumberAttri: TSynHighlighterAttributes read fNumberAttri write fNumberAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri write fSpaceAttri;
    property StringAttri: TSynHighlighterAttributes read fStringAttri write fStringAttri;
    property SymbolAttri: TSynHighlighterAttributes read fSymbolAttri write fSymbolAttri;
  end;

procedure LoadNBCCodeComplete(aItems : TStrings);
procedure LoadNXCConstants(aItems : TStrings);

implementation

uses
  SysUtils,
  Graphics,
  SynEditStrConst;

const
  SYN_ATTR_COMMAND  = 7;
  SYN_ATTR_CONSTANT = 8;
  
var
  Identifiers: array[#0..#255] of ByteBool;
  mHashTable: array[#0..#255] of Integer;

{$IFDEF SYN_COMPILER_3_UP}
resourcestring
{$ELSE}
const
{$ENDIF}
  SYNS_AttrCommand  = 'Command';
  SYNS_AttrConstant = 'Constant';
  SYNS_FilterNBC = 'Next Byte Code Files (*.nbc)|*.nbc';
  SYNS_LangNBC   = 'Next Byte Codes';

const
  PreProcDirectives: string =
    '#download,#include,#define,#ifndef,#pragma,#endif,#error,#ifdef,#undef,#elif,#else,#line,#if,#import';
  OpCodes: string =
// standard opcodes
    'add,sub,neg,mul,div,mod,and,or,xor,not,'+
    'cmnt,lsl,lsr,asl,asr,rotl,rotr,'+
    'cmp,tst,index,replace,arrsize,'+
    'arrbuild,arrsubset,arrinit,mov,set,flatten,unflatten,numtostr,'+
    'strtonum,strcat,strsubset,strtoarr,arrtostr,jmp,brcmp,brtst,'+
    'syscall,stop,exit,exitto,acquire,release,subcall,subret,'+
    'setin,setout,getin,getout,wait,gettick,wait2,'+
// enhanced firmware opcodes
    'waitv,abs,sign,stopthread,start,priority,fmtnum,'+
    'arrop,acos,asin,atan,ceil,exp,floor,sqrt,tan,tanh,'+
    'cos,cosh,log,log10,sin,sinh,trunc,frac,atan2,pow,muldiv,'+
// pseudo-opcodes
    'thread,endt,subroutine,'+
    'follows,precedes,segment,ends,typedef,struct,db,byte,sbyte,ubyte,dw,'+
    'word,sword,uword,dd,dword,sdword,udword,long,slong,ulong,void,mutex,float,'+
    'call,return,strindex,strreplace,strlen,shl,shr,sizeof,valueof,isconst,'+
    'compchk,compif,compelse,compend,compchktype';
  NBCCommands: string =
    'OnFwd, OnRev, Coast, Float, Off, OnFwdReg, OnRevReg, OnFwdSync, OnRevSync,'+
    'OnFwdEx, OnRevEx, CoastEx, OffEx, OnFwdRegEx, OnRevRegEx, OnFwdSyncEx, OnRevSyncEx,'+
    'OnFwdRegExPID, OnFwdRegPID, OnFwdSyncExPID, OnFwdSyncPID, OnRevRegExPID,'+
    'OnRevRegPID, OnRevSyncExPID, OnRevSyncPID,'+
    'ResetTachoCount, ResetBlockTachoCount, ResetRotationCount, ResetAllTachoCounts,'+
    'RotateMotor, RotateMotorEx, RotateMotorPID, RotateMotorExPID,'+
    'SetSensorLowspeed, SetSensorHTEOPD, SetSensorHTGyro, ReadSensorHTTouchMultiplexer,'+
    'SetSensorType, SetSensorMode, ReadSensor, ClearSensor,'+
    'SetSensorTouch, SetSensorLight, SetSensorSound, SetSensorUltrasonic,'+
    'ReadSensorUSEx, ReadI2CRegister, WriteI2CRegister,'+
    'ResetSensor, ReadSensorUS, ReadSensorHTEOPD, ReadSensorHTGyro, PlayTone, PlayFile,'+
    'Random, ResetSleepTimer, PlayToneEx, PlayFileEx, SignedRandom,'+
    'TextOut, NumOut, PointOut, LineOut, RectOut, CircleOut, GraphicOut, GraphicArrayOut,'+
    'FontTextOut, FontTextOutEx, FontNumOut, FontNumOutEx,'+
    'TextOutEx, NumOutEx, PointOutEx, LineOutEx, RectOutEx, CircleOutEx,'+
    'GraphicOutEx, GraphicArrayOutEx, PolyOut, PolyOutEx, EllipseOut, EllipseOutEx,'+
    'RebootInFirmwareMode, HTPFComboDirect, HTPFSinglePin, HTPFSingleOutputCST,'+
    'HTPFSingleOutputPWM, HTPFComboPWM, HTPFTrain, HTIRTrain, HTPFRawOutput,'+
    'HTPFRepeat, PowerDown, ReadButtonEx, SetIOMapValue, SetUIModuleValue,'+
    'SetIOCtrlModuleValue, SetCommandModuleValue, SetSoundModuleValue,'+
    'SetButtonModuleValue, SetInputModuleValue, SetOutputModuleValue,'+
    'SetLowSpeedModuleValue, SetDisplayModuleValue, SetCommModuleValue,'+
    'SetVolume, SetOnBrickProgramPointer, SetAbortFlag, GetFirstTick,'+
    'GetFreeMemory, GetBatteryLevel, GetIOMapValue, GetUIModuleValue,'+
    'GetLoaderModuleValue, GetCommandModuleValue, GetSoundModuleValue,'+
    'GetButtonModuleValue, GetInputModuleValue, GetOutputModuleValue,'+
    'GetLowSpeedModuleValue, GetDisplayModuleValue, GetCommModuleValue,'+
    'CreateFile, OpenFileAppend, OpenFileRead, CloseFile, ResolveHandle,'+
    'RenameFile, DeleteFile, SendMessage, ReceiveMessage, LowspeedStatus,'+
    'LowspeedWrite, LowspeedRead, BluetoothStatus, BluetoothWrite,'+
    'SetSoundFrequency, SetSoundDuration, SetSoundSampleRate, SetSoundFlags,'+
    'SetSoundState, SetSoundModuleState, SetSoundMode, SetSoundVolume, SetButtonPressCount,'+
    'SetButtonLongPressCount, SetButtonShortReleaseCount,'+
    'SetButtonLongReleaseCount, SetButtonReleaseCount, SetButtonState,'+
    'SetCommandFlags, SetUIState, SetUIButton, SetVMRunState, SetBatteryState,'+
    'SetBluetoothState, SetUsbState, SetSleepTimeout, SetSleepTimer, ForceOff,'+
    'GetSoundFrequency, GetSoundDuration, GetSoundSampleRate, GetSoundFlags,'+
    'GetSoundState, GetSoundMode, GetSoundVolume, GetButtonPressCount,'+
    'GetButtonLongPressCount, GetButtonShortReleaseCount,'+
    'GetButtonLongReleaseCount, GetButtonReleaseCount, GetButtonState,'+
    'GetCommandFlags, GetUIState, GetUIButton, GetVMRunState, GetBatteryState,'+
    'GetBluetoothState, GetUsbState, GetSleepTimeout, GetSleepTimer,'+
    'GetRechargeableBattery, GetVolume, GetOnBrickProgramPointer, GetAbortFlag,'+
    'GetInCustomZeroOffset, GetInSensorBoolean, GetInDigiPinsDirection,'+
    'GetInDigiPinsStatus, GetInDigiPinsOutputLevel, GetInCustomPercentFullScale,'+
    'GetInCustomActiveStatus, GetOutPwnFreq, SetInCustomZeroOffset,'+
    'SetInSensorBoolean, SetInDigiPinsDirection, SetInDigiPinsStatus,'+
    'SetInDigiPinsOutputLevel, SetInCustomPercentFullScale,'+
    'SetInCustomActiveStatus, SetOutPwnFreq, GetLSState, GetLSSpeed, GetLSMode,'+
    'GetLSChannelState, GetLSErrorType, SetLSState, SetLSSpeed, SetLSMode,'+
    'SetLSChannelState, SetLSErrorType, GetLSInputBuffer, GetLSInputBufferInPtr,'+
    'GetLSInputBufferOutPtr, GetLSInputBufferBytesToRx, GetLSOutputBuffer,'+
    'GetLSOutputBufferInPtr, GetLSOutputBufferOutPtr, GetLSOutputBufferBytesToRx,'+
    'GetBTDeviceName, GetBTDeviceClass, GetBTDeviceAddress, GetBTDeviceStatus,'+
    'GetBTConnectionName, GetBTConnectionClass, GetBTConnectionPinCode,'+
    'GetBTConnectionAddress, GetBTConnectionHandleNum, GetBTConnectionStreamStatus,'+
    'GetBTConnectionLinkQuality, GetBrickDataName, GetBrickDataBluecoreVersion,'+
    'GetBrickDataAddress, GetBrickDataBtStateStatus, GetBrickDataBtHardwareStatus,'+
    'GetBrickDataTimeoutValue, GetBTInputBuffer, GetBTInputBufferInPtr,'+
    'GetBTInputBufferOutPtr, GetBTOutputBuffer, GetBTOutputBufferInPtr,'+
    'GetBTOutputBufferOutPtr, GetHSInputBuffer, GetHSInputBufferInPtr,'+
    'GetHSInputBufferOutPtr, GetHSOutputBuffer, GetHSOutputBufferInPtr,'+
    'GetHSOutputBufferOutPtr, GetUSBInputBuffer, GetUSBInputBufferInPtr,'+
    'GetUSBInputBufferOutPtr, GetUSBOutputBuffer, GetUSBOutputBufferInPtr,'+
    'GetUSBOutputBufferOutPtr, GetUSBPollBuffer, GetUSBPollBufferInPtr,'+
    'GetUSBPollBufferOutPtr, GetBTDeviceCount, GetBTDeviceNameCount,'+
    'GetHSFlags, GetHSSpeed, GetHSState, GetUSBState, SetLSInputBuffer,'+
    'SetLSInputBufferInPtr, SetLSInputBufferOutPtr, SetLSInputBufferBytesToRx,'+
    'SetLSOutputBuffer, SetLSOutputBufferInPtr, SetLSOutputBufferOutPtr,'+
    'SetLSOutputBufferBytesToRx, SetBTDeviceName, SetBTDeviceClass,'+
    'SetBTDeviceAddress, SetBTDeviceStatus, SetBTConnectionName,'+
    'SetBTConnectionClass, SetBTConnectionPinCode, SetBTConnectionAddress,'+
    'SetBTConnectionHandleNum, SetBTConnectionStreamStatus,'+
    'SetBTConnectionLinkQuality, SetBrickDataName, SetBrickDataBluecoreVersion,'+
    'SetBrickDataAddress, SetBrickDataBtStateStatus, SetBrickDataBtHardwareStatus,'+
    'SetBrickDataTimeoutValue, SetBTInputBuffer, SetBTInputBufferInPtr,'+
    'SetBTInputBufferOutPtr, SetBTOutputBuffer, SetBTOutputBufferInPtr,'+
    'SetBTOutputBufferOutPtr, SetHSInputBuffer, SetHSInputBufferInPtr,'+
    'SetHSInputBufferOutPtr, SetHSOutputBuffer, SetHSOutputBufferInPtr,'+
    'SetHSOutputBufferOutPtr, SetUSBInputBuffer, SetUSBInputBufferInPtr,'+
    'SetUSBInputBufferOutPtr, SetUSBOutputBuffer, SetUSBOutputBufferInPtr,'+
    'SetUSBOutputBufferOutPtr, SetUSBPollBuffer, SetUSBPollBufferInPtr,'+
    'SetUSBPollBufferOutPtr, SetBTDeviceCount, SetBTDeviceNameCount,'+
    'SetHSFlags, SetHSSpeed, SetHSState, SetUSBState,'+
    'GetDisplayEraseMask, GetDisplayUpdateMask, GetDisplayContrast, GetDisplayDisplay, GetDisplayFlags,'+
    'GetDisplayTextLinesCenterFlags, GetDisplayNormal, GetDisplayPopup,'+
    'SetDisplayEraseMask, SetDisplayUpdateMask, SetDisplayContrast, SetDisplayDisplay, SetDisplayFlags,'+
    'SetDisplayTextLinesCenterFlags, SetDisplayNormal, SetDisplayPopup, Wait,'+
    'Read, ReadLn, ReadBytes, Write, WriteLn, WriteString, WriteLnString,'+
    'WriteBytes, WriteBytesEx, ClearScreen, ReadI2CBytes,'+
    'ReceiveRemoteBool, ReceiveRemoteNumber, ReceiveRemoteString,'+
    'ReceiveRemoteMessageEx, SendRemoteBool, SendRemoteNumber, SendRemoteString,'+
    'SendResponseBool, SendResponseNumber, SendResponseString,'+
    'RemoteMessageRead, RemoteMessageWrite, RemoteStartProgram,'+
    'RemoteStopProgram, RemotePlaySoundFile, RemotePlayTone, RemoteStopSound,'+
    'RemoteKeepAlive, RemoteResetScaledValue, RemoteResetMotorPosition,'+
    'RemoteSetInputMode, RemoteSetOutputState, Sqrt, Sin, Cos, Asin, Acos, bcd2dec,'+
    'ReadSensorHTAccel, ReadSensorHTColor, ReadSensorHTRawColor,'+
    'ReadSensorHTNormalizedColor, ReadSensorHTIRSeeker, ReadSensorHTCompass,'+
    'ReadSensorHTColorNum, ReadSensorHTIRSeekerDir,'+
    'ReadSensorHTIRSeeker2DC, ReadSensorHTIRSeeker2AC, SetHTIRSeeker2Mode,'+
    'MSReadValueEx, MSReadValue,'+
    'DISTNxGP2D12, DISTNxGP2D120, DISTNxGP2YA21, DISTNxGP2YA02, DISTNxEnergize,'+
    'SetSensorMSDRODActive, SetSensorMSDRODInactive, ReadSensorMSDROD,'+
    'ReadDISTNxDistance, ReadDISTNxVoltage, ReadDISTNxModuleType,'+
    'ReadDISTNxNumPoints, ReadDISTNxMinDistance, ReadDISTNxMaxDistance,'+
    'SetSensorMSPressure, ReadSensorMSPressure, ReadSensorMSPressureRaw,'+
    'ReadSensorMSCompass, ReadSensorMSCompassEx, ReadSensorMSRTClock,'+
    'ReadSensorMSTilt, ReadSensorMSTiltEx, ReadSensorMSAccel, ReadSensorMSAccelEx,'+
    'PSPNxEnergize, ReadSensorMSPlayStationEx, ReadSensorMSPlayStation,'+
    'NRLink2400, NRLink4800, NRLinkFlush, NRLinkIRLong, NRLinkIRShort,'+
    'NRLinkTxRaw, NRLinkSetRCX, NRLinkSetTrain, NRLinkSetPF,'+
    'RunNRLinkMacroEx, RunNRLinkMacro, ReadNRLinkStatusEx, ReadNRLinkStatus,'+
    'WriteNRLinkBytesEx, WriteNRLinkBytes, ReadNRLinkBytesEx, ReadNRLinkBytes,'+
    'MSPFComboDirectEx, MSPFComboDirect, MSPFSinglePinEx, MSPFSinglePin,'+
    'MSPFSingleOutputCSTEx, MSPFSingleOutputCST, MSPFSingleOutputPWMEx, MSPFSingleOutputPWM,'+
    'MSPFComboPWMEx, MSPFComboPWM, MSPFTrainEx, MSPFTrain, MSIRTrainEx, MSIRTrain,'+
    'MSPFRawOutputEx, MSPFRawOutput, MSPFRepeatEx, MSPFRepeat,'+
    'HTRCXSetIRLinkPort, HTRCXPoll, HTRCXBatteryLevel, HTRCXPing,'+
    'HTRCXDeleteTasks, HTRCXStopAllTasks, HTRCXPBTurnOff, HTRCXDeleteSubs,'+
    'HTRCXClearSound, HTRCXClearMsg, HTRCXMuteSound,'+
    'HTRCXUnmuteSound, HTRCXClearAllEvents, HTRCXSetOutput, HTRCXSetDirection,'+
    'HTRCXSetPower, HTRCXOn, HTRCXOff, HTRCXFloat,'+
    'HTRCXToggle, HTRCXFwd, HTRCXRev, HTRCXOnFwd,'+
    'HTRCXOnRev, HTRCXOnFor, HTRCXSetTxPower, HTRCXPlaySound,'+
    'HTRCXDeleteTask, HTRCXStartTask, HTRCXStopTask, HTRCXSelectProgram,'+
    'HTRCXClearTimer, HTRCXSetSleepTime, HTRCXDeleteSub, HTRCXClearSensor,'+
    'HTRCXPlayToneVar, HTRCXSetWatch, HTRCXSetSensorType, HTRCXSetSensorMode,'+
    'HTRCXCreateDatalog, HTRCXAddToDatalog, HTRCXSendSerial, HTRCXRemote,'+
    'HTRCXEvent, HTRCXPlayTone, HTRCXSelectDisplay, HTRCXPollMemory,'+
    'HTRCXSetEvent, HTRCXSetGlobalOutput, HTRCXSetGlobalDirection, HTRCXSetMaxPower,'+
    'HTRCXEnableOutput, HTRCXDisableOutput, HTRCXInvertOutput, HTRCXObvertOutput,'+
    'HTRCXIncCounter,'+
    'HTRCXDecCounter, HTRCXClearCounter, HTRCXSetPriority, HTRCXSetMessage,'+
    'HTScoutCalibrateSensor, HTScoutMuteSound, HTScoutUnmuteSound,'+
    'HTScoutSelectSounds, HTScoutSetLight,'+
    'HTScoutSetSensorClickTime, HTScoutSetSensorHysteresis,'+
    'HTScoutSetSensorLowerLimit, HTScoutSetSensorUpperLimit, HTScoutSetEventFeedback,'+
    'HTScoutSendVLL, HTScoutSetScoutMode, MSRCXSetNRLinkEx,'+
    'MSRCXSetNRLinkPort, MSRCXPoll, MSRCXBatteryLevel, MSRCXPing,'+
    'MSRCXDeleteTasks, MSRCXStopAllTasks, MSRCXPBTurnOff, MSRCXDeleteSubs,'+
    'MSRCXClearSound, MSRCXClearMsg, MSRCXMuteSound,'+
    'MSRCXUnmuteSound, MSRCXClearAllEvents, MSRCXSetOutput, MSRCXSetDirection,'+
    'MSRCXSetPower, MSRCXOn, MSRCXOff, MSRCXFloat,'+
    'MSRCXToggle, MSRCXFwd, MSRCXRev, MSRCXOnFwd,'+
    'MSRCXOnRev, MSRCXOnFor, MSRCXSetTxPower, MSRCXPlaySound,'+
    'MSRCXDeleteTask, MSRCXStartTask, MSRCXStopTask, MSRCXSelectProgram,'+
    'MSRCXClearTimer, MSRCXSetSleepTime, MSRCXDeleteSub, MSRCXClearSensor,'+
    'MSRCXPlayToneVar, MSRCXSetWatch, MSRCXSetSensorType, MSRCXSetSensorMode,'+
    'MSRCXCreateDatalog, MSRCXAddToDatalog, MSRCXSendSerial, MSRCXRemote,'+
    'MSRCXEvent, MSRCXPlayTone, MSRCXSelectDisplay, MSRCXPollMemory,'+
    'MSRCXSetEvent, MSRCXSetGlobalOutput, MSRCXSetGlobalDirection, MSRCXSetMaxPower,'+
    'MSRCXEnableOutput, MSRCXDisableOutput, MSRCXInvertOutput, MSRCXObvertOutput,'+
    'MSRCXCalibrateEvent, MSRCXSetVar, MSRCXSumVar, MSRCXSubVar, MSRCXDivVar,'+
    'MSRCXMulVar, MSRCXSgnVar, MSRCXAbsVar, MSRCXAndVar, MSRCXOrVar, MSRCXSet,'+
    'MSRCXUnlock, MSRCXReset, MSRCXBoot, MSRCXSetUserDisplay, MSRCXIncCounter,'+
    'MSRCXDecCounter, MSRCXClearCounter, MSRCXSetPriority, MSRCXSetMessage,'+
    'MSScoutCalibrateSensor, MSScoutMuteSound, MSScoutUnmuteSound,'+
    'MSScoutSelectSounds, MSScoutSetLight, MSScoutSetCounterLimit,'+
    'MSScoutSetTimerLimit, MSScoutSetSensorClickTime, MSScoutSetSensorHysteresis,'+
    'MSScoutSetSensorLowerLimit, MSScoutSetSensorUpperLimit, MSScoutSetEventFeedback,'+
    'MSScoutSendVLL, MSScoutSetScoutRules, MSScoutSetScoutMode,'+
    'FindFirstFile, FindNextFile, CreateFileLinear, CreateFileNonLinear,'+
    'OpenFileReadLinear, RS485Control, RS485Exit, RS485Init, RS485Read,'+
    'RS485Status, RS485Uart, RS485Write, SendRS485Bool, SendRS485Number,'+
    'SendRS485String,' +
    'I2CSendCommand, I2CSendCommandEx, ReadSensorHTIRReceiverEx,' +
    'SetHTColor2Mode, ReadSensorHTColor2Active, ReadSensorHTIRReceiver,' +
    'ReadSensorHTNormalizedColor2Active, ReadSensorHTRawColor2,' +
    'ReadI2CDeviceInfoEx, ReadI2CDeviceInfo, ReadI2CVersionEx, ReadI2CVersion,' +
    'ReadI2CVendorIdEx, ReadI2CVendorId, ReadI2CDeviceIdEx, ReadI2CDeviceId,' +
    'RICImgPoint, RICImgRect, RICOpDescription, RICOpCopyBits, RICOpPixel, RICOpLine,'+
    'RICOpRect, RICOpCircle, RICOpNumBox, RICOpSprite, RICSpriteData, RICOpVarMap,'+
    'RICMapElement, RICMapFunction, RICArg, RICMapArg';

  NBCConstants: string =
    'NA,TRUE,FALSE,OUT_A,OUT_B,OUT_C,OUT_AB,OUT_AC,OUT_BC,OUT_ABC,'+
    'IN_1,IN_2,IN_3,IN_4,IO_BASE,'+
    'MOD_INPUT,MOD_OUTPUT,IO_IN_FPP,IO_OUT_FPP,'+
    'LT,GT,LTEQ,GTEQ,EQ,NEQ,'+
    'UF_UPDATE_MODE,UF_UPDATE_SPEED,UF_UPDATE_TACHO_LIMIT,'+
    'UF_UPDATE_RESET_COUNT,UF_UPDATE_PID_VALUES,'+
    'UF_UPDATE_RESET_BLOCK_COUNT,UF_UPDATE_RESET_ROTATION_COUNT,UF_PENDING_UPDATES,'+
    'OUT_MODE_COAST,OUT_MODE_MOTORON,OUT_MODE_BRAKE,OUT_MODE_REGULATED,OUT_MODE_REGMETHOD,'+
    'OUT_RUNSTATE_IDLE,OUT_RUNSTATE_RAMPUP,OUT_RUNSTATE_RUNNING,OUT_RUNSTATE_RAMPDOWN,'+
    'OUT_REGMODE_IDLE,OUT_REGMODE_SPEED,OUT_REGMODE_SYNC,'+
    'IN_TYPE_NO_SENSOR,IN_TYPE_SWITCH,IN_TYPE_TEMPERATURE,'+
    'IN_TYPE_REFLECTION,IN_TYPE_ANGLE,IN_TYPE_LIGHT_ACTIVE,'+
    'IN_TYPE_LIGHT_INACTIVE,IN_TYPE_SOUND_DB,IN_TYPE_SOUND_DBA,'+
    'IN_TYPE_CUSTOM,IN_TYPE_LOWSPEED,IN_TYPE_LOWSPEED_9V,IN_TYPE_HISPEED,'+
    'IN_TYPE_COLORFULL,IN_TYPE_COLORRED,IN_TYPE_COLORGREEN,IN_TYPE_COLORBLUE,IN_TYPE_COLORNONE,'+
    'IN_MODE_RAW,IN_MODE_BOOLEAN,IN_MODE_TRANSITIONCNT,IN_MODE_PERIODCOUNTER,'+
    'IN_MODE_PCTFULLSCALE,IN_MODE_CELSIUS,IN_MODE_FAHRENHEIT,'+
    'IN_MODE_ANGLESTEP,IN_MODE_SLOPEMASK,IN_MODE_MODEMASK,'+
    'UpdateFlags,OutputMode,Power,ActualSpeed,TachoCount,TachoLimit,RunState,OutputOptions,'+
    'TurnRatio,RegMode,Overload,RegPValue,RegIValue,RegDValue,BlockTachoCount,RotationCount,'+
    'Type,InputMode,RawValue,NormalizedValue,ScaledValue,InvalidData,'+
    'InputIOType0,InputIOInputMode0,InputIORawValue0,InputIONormalizedValue0,'+
    'InputIOScaledValue0,InputIOInvalidData0,'+
    'InputIOType1,InputIOInputMode1,InputIORawValue1,InputIONormalizedValue1,'+
    'InputIOScaledValue1,InputIOInvalidData1,'+
    'InputIOType2,InputIOInputMode2,InputIORawValue2,InputIONormalizedValue2,'+
    'InputIOScaledValue2,InputIOInvalidData2,'+
    'InputIOType3,InputIOInputMode3,InputIORawValue3,InputIONormalizedValue3,'+
    'InputIOScaledValue3,InputIOInvalidData3,'+
    'OutputIOUpdateFlags0,OutputIOOutputMode0,OutputIOPower0,OutputIOActualSpeed0,'+
    'OutputIOTachoCount0,OutputIOTachoLimit0,OutputIORunState0,OutputIOTurnRatio0,'+
    'OutputIORegMode0,OutputIOOverload0,OutputIORegPValue0,OutputIORegIValue0,'+
    'OutputIORegDValue0,OutputIOBlockTachoCount0,OutputIORotationCount0,'+
    'OutputIOUpdateFlags1,OutputIOOutputMode1,OutputIOPower1,OutputIOActualSpeed1,'+
    'OutputIOTachoCount1,OutputIOTachoLimit1,OutputIORunState1,OutputIOTurnRatio1,'+
    'OutputIORegMode1,OutputIOOverload1,OutputIORegPValue1,OutputIORegIValue1,'+
    'OutputIORegDValue1,OutputIOBlockTachoCount1,OutputIORotationCount1,'+
    'OutputIOUpdateFlags2,OutputIOOutputMode2,OutputIOPower2,OutputIOActualSpeed2,'+
    'OutputIOTachoCount2,OutputIOTachoLimit2,OutputIORunState2,OutputIOTurnRatio2,'+
    'OutputIORegMode2,OutputIOOverload2,OutputIORegPValue2,OutputIORegIValue2,'+
    'OutputIORegDValue2,OutputIOBlockTachoCount2,OutputIORotationCount2,'+
    'FileOpenRead,FileOpenWrite,FileOpenAppend,FileRead,FileWrite,FileClose,'+
    'FileResolveHandle,FileRename,FileDelete,'+
    'SoundPlayFile,SoundPlayTone,SoundGetState,SoundSetState,'+
    'DrawText,DrawPoint,DrawLine,DrawCircle,DrawRect,DrawGraphic,'+
    'SetScreenMode,ReadButton,CommLSWrite,CommLSRead,CommLSCheckStatus,'+
    'RandomNumber,GetStartTick,MessageWrite,MessageRead,'+
    'CommBTCheckStatus,CommBTWrite,CommBTRead,KeepAlive,IOMapRead,IOMapWrite,'+
    'MAILBOX1,MAILBOX2,MAILBOX3,MAILBOX4,MAILBOX5,MAILBOX6,MAILBOX7,MAILBOX8,MAILBOX9,MAILBOX10,'+
    'MS_1,MS_2,MS_3,MS_4,MS_5,MS_6,MS_7,MS_8,MS_9,'+
    'MS_10,MS_20,MS_30,MS_40,MS_50,MS_60,MS_70,MS_80,MS_90,'+
    'MS_100,MS_150,MS_200,MS_250,MS_300,MS_350,MS_400,MS_450,MS_500,'+
    'MS_600,MS_700,MS_800,MS_900,SEC_1,SEC_2,SEC_3,SEC_4,SEC_5,SEC_6,'+
    'SEC_7,SEC_8,SEC_9,SEC_10,SEC_15,SEC_20,SEC_30,MIN_1,'+
    'TONE_A3,TONE_AS3,TONE_B3,'+
    'TONE_C4,TONE_CS4,TONE_D4,TONE_DS4,TONE_E4,TONE_F4,TONE_FS4,TONE_G4,TONE_GS4,TONE_A4,TONE_AS4,TONE_B4,'+
    'TONE_C5,TONE_CS5,TONE_D5,TONE_DS5,TONE_E5,TONE_F5,TONE_FS5,TONE_G5,TONE_GS5,TONE_A5,TONE_AS5,TONE_B5,'+
    'TONE_C6,TONE_CS6,TONE_D6,TONE_DS6,TONE_E6,TONE_F6,TONE_FS6,TONE_G6,TONE_GS6,TONE_A6,TONE_AS6,TONE_B6,'+
    'TONE_C7,TONE_CS7,TONE_D7,TONE_DS7,TONE_E7,TONE_F7,TONE_FS7,TONE_G7,TONE_GS7,TONE_A7,TONE_AS7,TONE_B7,'+
    'CommandModuleName, IOCtrlModuleName, LoaderModuleName, SoundModuleName,'+
    'ButtonModuleName, UIModuleName, InputModuleName, OutputModuleName,'+
    'LowSpeedModuleName, DisplayModuleName, CommModuleName,'+
    'CommandModuleID, IOCtrlModuleID, LoaderModuleID, SoundModuleID,'+
    'ButtonModuleID, UIModuleID, InputModuleID, OutputModuleID,'+
    'LowSpeedModuleID, DisplayModuleID, CommModuleID,'+
    'CommandOffsetFormatString, CommandOffsetPRCHandler, CommandOffsetTick,'+
    'CommandOffsetOffsetDS, CommandOffsetOffsetDVA, CommandOffsetProgStatus,'+
    'CommandOffsetAwake, CommandOffsetActivateFlag, CommandOffsetDeactivateFlag,' +
    'CommandOffsetFileName, CommandOffsetMemoryPool,' +
    'CommandOffsetSyncTime, CommandOffsetSyncTick,' +
    'IOCtrlOffsetPowerOn, LoaderOffsetPFunc, LoaderOffsetFreeUserFlash,'+
    'LDR_SUCCESS, LDR_INPROGRESS, LDR_REQPIN, LDR_NOMOREHANDLES, LDR_NOSPACE,'+
    'LDR_NOMOREFILES, LDR_EOFEXPECTED, LDR_ENDOFFILE, LDR_NOTLINEARFILE,'+
    'LDR_FILENOTFOUND, LDR_HANDLEALREADYCLOSED, LDR_NOLINEARSPACE,'+
    'LDR_UNDEFINEDERROR, LDR_FILEISBUSY, LDR_NOWRITEBUFFERS,'+
    'LDR_APPENDNOTPOSSIBLE, LDR_FILEISFULL, LDR_FILEEXISTS, LDR_MODULENOTFOUND,'+
    'LDR_OUTOFBOUNDARY, LDR_ILLEGALFILENAME, LDR_ILLEGALHANDLE, LDR_BTBUSY,'+
    'LDR_BTCONNECTFAIL, LDR_BTTIMEOUT, LDR_FILETX_TIMEOUT, LDR_FILETX_DSTEXISTS,'+
    'LDR_FILETX_SRCMISSING, LDR_FILETX_STREAMERROR, LDR_FILETX_CLOSEERROR,'+
    'LDR_INVALIDSEEK, LDR_CMD_RESIZEDATAFILE, LDR_CMD_SEEKFROMSTART,'+
    'LDR_CMD_SEEKFROMCURRENT, LDR_CMD_SEEKFROMEND, ' +
    'LDR_CMD_OPENREAD, LDR_CMD_OPENWRITE, LDR_CMD_READ, LDR_CMD_WRITE,'+
    'LDR_CMD_CLOSE, LDR_CMD_DELETE, LDR_CMD_FINDFIRST, LDR_CMD_FINDNEXT,'+
    'LDR_CMD_OPENWRITELINEAR, LDR_CMD_OPENREADLINEAR, LDR_CMD_OPENWRITEDATA,'+
    'LDR_CMD_OPENAPPENDDATA, LDR_CMD_FINDFIRSTMODULE, LDR_CMD_FINDNEXTMODULE,'+
    'LDR_CMD_CLOSEMODHANDLE, LDR_CMD_IOMAPREAD, LDR_CMD_IOMAPWRITE,'+
    'LDR_CMD_DELETEUSERFLASH, LDR_CMD_RENAMEFILE, LDR_CMD_CROPDATAFILE,'+
    'DIST_CMD_GP2D12, DIST_CMD_GP2D120, DIST_CMD_GP2YA21, DIST_CMD_GP2YA02,'+
    'DIST_CMD_CUSTOM, DIST_CMD_ENERGIZED, DIST_CMD_DEENERGIZED, DIST_CMD_ADPA_ON,'+
    'DIST_CMD_ADPA_OFF,'+
    'DIST_REG_DIST, DIST_REG_VOLT, DIST_REG_MODULE_TYPE,'+
    'DIST_REG_NUM_POINTS, DIST_REG_DIST_MIN, DIST_REG_DIST_MAX,'+
    'DIST_REG_VOLT1, DIST_REG_DIST1,'+
    'US_CMD_OFF, US_CMD_SINGLESHOT, US_CMD_CONTINUOUS, US_CMD_EVENTCAPTURE,'+
    'US_CMD_WARMRESET, US_REG_CM_INTERVAL, US_REG_ACTUAL_ZERO,'+
    'US_REG_SCALE_FACTOR, US_REG_SCALE_DIVISOR, US_REG_FACTORY_ACTUAL_ZERO,'+
    'US_REG_FACTORY_SCALE_FACTOR, US_REG_FACTORY_SCALE_DIVISOR,'+
    'US_REG_MEASUREMENT_UNITS,'+
    'SoundOffsetFreq, SoundOffsetDuration, SoundOffsetSampleRate,'+
    'SoundOffsetSoundFilename, SoundOffsetFlags, SoundOffsetState,'+
    'SoundOffsetMode, SoundOffsetVolume, ButtonOffsetPressedCnt,'+
    'ButtonOffsetLongPressCnt, ButtonOffsetShortRelCnt, ButtonOffsetLongRelCnt,'+
    'ButtonOffsetRelCnt, ButtonOffsetState, UIOffsetPMenu,'+
    'UIOffsetBatteryVoltage, UIOffsetLMSfilename, UIOffsetFlags,'+
    'UIOffsetState, UIOffsetButton, UIOffsetRunState, UIOffsetBatteryState,'+
    'UIOffsetBluetoothState, UIOffsetUsbState, UIOffsetSleepTimeout,'+
    'UIOffsetSleepTimer, UIOffsetRechargeable, UIOffsetVolume, UIOffsetError,'+
    'UIOffsetOBPPointer, UIOffsetForceOff, UIOffsetLongAbort, InputOffsetCustomZeroOffset,'+
    'InputOffsetADRaw, InputOffsetSensorRaw, InputOffsetSensorValue,'+
    'InputOffsetSensorType, InputOffsetSensorMode, InputOffsetSensorBoolean,'+
    'InputOffsetDigiPinsDir, InputOffsetDigiPinsIn, InputOffsetDigiPinsOut,'+
    'InputOffsetCustomPctFullScale, InputOffsetCustomActiveStatus,'+
    'InputOffsetInvalidData,'+
    'InputOffsetColorCalibration, InputOffsetColorCalLimits, InputOffsetColorADRaw,'+
    'InputOffsetColorSensorRaw, InputOffsetColorSensorValue,'+
    'InputOffsetColorSensorBoolean, InputOffsetColorCalibrationState,'+
    'OutputOffsetTachoCount,'+
    'OutputOffsetBlockTachoCount, OutputOffsetRotationCount, OutputOffsetTachoLimit,'+
    'OutputOffsetMotorRPM, OutputOffsetFlags, OutputOffsetMode,'+
    'OutputOffsetSpeed, OutputOffsetActualSpeed, OutputOffsetRegPParameter,'+
    'OutputOffsetRegIParameter, OutputOffsetRegDParameter, OutputOffsetRunState,'+
    'OutputOffsetRegMode, OutputOffsetOverloaded, OutputOffsetSyncTurnParameter,'+
    'OutputOffsetPwnFreq,'+
    'LowSpeedOffsetInBufBuf, LowSpeedOffsetInBufInPtr, LowSpeedOffsetInBufOutPtr,'+
    'LowSpeedOffsetInBufBytesToRx, LowSpeedOffsetOutBufBuf, LowSpeedOffsetOutBufInPtr,'+
    'LowSpeedOffsetOutBufOutPtr, LowSpeedOffsetOutBufBytesToRx, LowSpeedOffsetMode,'+
    'LowSpeedOffsetChannelState, LowSpeedOffsetErrorType,'+
    'LowSpeedOffsetState, LowSpeedOffsetSpeed,'+
    'DisplayOffsetPFunc, DisplayOffsetEraseMask, DisplayOffsetUpdateMask,'+
    'DisplayOffsetPFont, DisplayOffsetPTextLines, DisplayOffsetPStatusText,'+
    'DisplayOffsetPStatusIcons, DisplayOffsetPScreens, DisplayOffsetPBitmaps,'+
    'DisplayOffsetPMenuText, DisplayOffsetPMenuIcons, DisplayOffsetPStepIcons,'+
    'DisplayOffsetDisplay, DisplayOffsetStatusIcons, DisplayOffsetStepIcons,'+
    'DisplayOffsetFlags, DisplayOffsetTextLinesCenterFlags,'+
    'DisplayOffsetNormal, DisplayOffsetPopup, DisplayOffsetContrast,'+
    'CommOffsetPFunc, CommOffsetPFuncTwo, CommOffsetBtDeviceTableName,'+
    'CommOffsetBtDeviceTableClassOfDevice, CommOffsetBtDeviceTableBdAddr,'+
    'CommOffsetBtDeviceTableDeviceStatus,'+
    'CommOffsetBtConnectTableName, CommOffsetBtConnectTableClassOfDevice,'+
    'CommOffsetBtConnectTablePinCode, CommOffsetBtConnectTableBdAddr,'+
    'CommOffsetBtConnectTableHandleNr, CommOffsetBtConnectTableStreamStatus,'+
    'CommOffsetBtConnectTableLinkQuality,'+
    'CommOffsetBrickDataName, CommOffsetBrickDataBluecoreVersion,'+
    'CommOffsetBrickDataBdAddr, CommOffsetBrickDataBtStateStatus,'+
    'CommOffsetBrickDataBtHwStatus, CommOffsetBrickDataTimeOutValue,'+
    'CommOffsetBtInBufBuf, CommOffsetBtInBufInPtr, CommOffsetBtInBufOutPtr,'+
    'CommOffsetBtOutBufBuf, CommOffsetBtOutBufInPtr, CommOffsetBtOutBufOutPtr,'+
    'CommOffsetHsInBufBuf, CommOffsetHsInBufInPtr, CommOffsetHsInBufOutPtr,'+
    'CommOffsetHsOutBufBuf, CommOffsetHsOutBufInPtr, CommOffsetHsOutBufOutPtr,'+
    'CommOffsetUsbInBufBuf, CommOffsetUsbInBufInPtr, CommOffsetUsbInBufOutPtr,'+
    'CommOffsetUsbOutBufBuf, CommOffsetUsbOutBufInPtr, CommOffsetUsbOutBufOutPtr,'+
    'CommOffsetUsbPollBufBuf, CommOffsetUsbPollBufInPtr, CommOffsetUsbPollBufOutPtr,'+
    'CommOffsetBtDeviceCnt, CommOffsetBtDeviceNameCnt, CommOffsetHsFlags,'+
    'CommOffsetHsSpeed, CommOffsetHsState, CommOffsetUsbState,'+
    'STAT_MSG_EMPTY_MAILBOX, STAT_COMM_PENDING, STOP_REQ, BREAKOUT_REQ,'+
    'PC_OVERRIDE, CLUMP_SUSPEND, CLUMP_DONE, NO_ERR, ERR_ARG, ERR_INSTR,'+
    'ERR_FILE, ERR_VER, ERR_MEM, ERR_BAD_PTR, ERR_INVALID_PORT, ERR_INVALID_FIELD,'+
    'ERR_INVALID_QUEUE, ERR_INVALID_SIZE, ERR_NO_PROG, ERR_COMM_CHAN_NOT_READY,'+
    'ERR_COMM_CHAN_INVALID, ERR_COMM_BUFFER_FULL, ERR_COMM_BUS_ERR,,'+
    'ERR_RC_ILLEGAL_VAL, ERR_RC_BAD_PACKET, ERR_RC_UNKNOWN_CMD, ERR_RC_FAILED,'+
    'PROG_IDLE, PROG_OK, PROG_RUNNING, PROG_ERROR, PROG_ABORT, PROG_RESET,'+
    'INPUT_DIGI0, INPUT_DIGI1, INPUT_CUSTOMINACTIVE, INPUT_CUSTOM9V,'+
    'INPUT_CUSTOMACTIVE, INPUT_INVALID_DATA,'+
    'INPUT_RED, INPUT_GREEN, INPUT_BLUE, INPUT_BLANK, INPUT_NO_OF_COLORS,'+
    'INPUT_BLACKCOLOR, INPUT_BLUECOLOR, INPUT_GREENCOLOR, INPUT_YELLOWCOLOR,'+
    'INPUT_REDCOLOR, INPUT_WHITECOLOR, INPUT_SENSORCAL, INPUT_SENSOROFF,'+
    'INPUT_RUNNINGCAL, INPUT_STARTCAL, INPUT_RESETCAL, INPUT_CAL_POINT_0,'+
    'INPUT_CAL_POINT_1, INPUT_CAL_POINT_2, INPUT_NO_OF_POINTS,'+
    'BTN1, BTN2, BTN3, BTN4, BTNEXIT, BTNCENTER, BTNLEFT, BTNRIGHT, NO_OF_BTNS,'+
    'BTNSTATE_PRESSED_EV, BTNSTATE_SHORT_RELEASED_EV, BTNSTATE_LONG_PRESSED_EV,'+
    'BTNSTATE_LONG_RELEASED_EV, BTNSTATE_PRESSED_STATE,'+
    'SOUND_FLAGS_IDLE, SOUND_FLAGS_UPDATE, SOUND_FLAGS_RUNNING,'+
    'SOUND_STATE_IDLE, SOUND_STATE_FILE, SOUND_STATE_TONE, SOUND_STATE_STOP,'+
    'SOUND_MODE_ONCE, SOUND_MODE_LOOP, SOUND_MODE_TONE,'+
    'UI_FLAGS_UPDATE, UI_FLAGS_DISABLE_LEFT_RIGHT_ENTER,'+
    'UI_FLAGS_DISABLE_EXIT, UI_FLAGS_REDRAW_STATUS, UI_FLAGS_RESET_SLEEP_TIMER,'+
    'UI_FLAGS_EXECUTE_LMS_FILE, UI_FLAGS_BUSY, UI_FLAGS_ENABLE_STATUS_UPDATE,'+
    'UI_STATE_INIT_DISPLAY, UI_STATE_INIT_LOW_BATTERY, UI_STATE_INIT_INTRO,'+
    'UI_STATE_INIT_WAIT, UI_STATE_INIT_MENU, UI_STATE_NEXT_MENU,'+
    'UI_STATE_DRAW_MENU, UI_STATE_TEST_BUTTONS, UI_STATE_LEFT_PRESSED,'+
    'UI_STATE_RIGHT_PRESSED, UI_STATE_ENTER_PRESSED, UI_STATE_EXIT_PRESSED,'+
    'UI_STATE_CONNECT_REQUEST, UI_STATE_EXECUTE_FILE, UI_STATE_EXECUTING_FILE,'+
    'UI_STATE_LOW_BATTERY, UI_STATE_BT_ERROR, UI_BUTTON_NONE,'+
    'UI_BUTTON_LEFT, UI_BUTTON_ENTER, UI_BUTTON_RIGHT, UI_BUTTON_EXIT,'+
    'UI_BT_STATE_VISIBLE, UI_BT_STATE_CONNECTED, UI_BT_STATE_OFF,'+
    'UI_BT_ERROR_ATTENTION, UI_BT_CONNECT_REQUEST, UI_BT_PIN_REQUEST,'+
    'LS_DEVTYPE_ULTRA_SONIC, LS_DEVTYPE_CUSTOM_LS_DEVICE, COM_CHANNEL_NONE_ACTIVE,'+
    'COM_CHANNEL_ONE_ACTIVE, COM_CHANNEL_TWO_ACTIVE, COM_CHANNEL_THREE_ACTIVE,'+
    'COM_CHANNEL_FOUR_ACTIVE, LOWSPEED_IDLE, LOWSPEED_INIT,'+
    'LOWSPEED_LOAD_BUFFER, LOWSPEED_COMMUNICATING, LOWSPEED_ERROR,'+
    'LOWSPEED_DONE, LOWSPEED_TRANSMITTING, LOWSPEED_RECEIVING,'+
    'LOWSPEED_DATA_RECEIVED, LOWSPEED_NO_ERROR, LOWSPEED_CH_NOT_READY,'+
    'LOWSPEED_TX_ERROR, LOWSPEED_RX_ERROR,'+
    'DISPLAY_ERASE_ALL, DISPLAY_PIXEL, DISPLAY_HORISONTAL_LINE,'+
    'DISPLAY_VERTICAL_LINE, DISPLAY_CHAR, DISPLAY_ON, DISPLAY_REFRESH,'+
    'DISPLAY_POPUP, DISPLAY_REFRESH_DISABLED, DISPLAY_BUSY, DISPLAY_HEIGHT,'+
    'DISPLAY_WIDTH, DISPLAY_MENUICONS_Y, DISPLAY_MENUICONS_X_OFFS,'+
    'DISPLAY_CONTRAST_DEFAULT, DISPLAY_CONTRAST_MAX,'+
    'DISPLAY_MENUICONS_X_DIFF, TEXTLINE_1, TEXTLINE_2, TEXTLINE_3, TEXTLINE_4,'+
    'TEXTLINE_5, TEXTLINE_6, TEXTLINE_7, TEXTLINE_8, NUM_TEXTLINES,'+
    'MENUICON_LEFT, MENUICON_CENTER, MENUICON_RIGHT, NUM_MENUICONS,'+
    'FRAME_SELECT, STATUSTEXT, MENUTEXT, STEPLINE, TOPLINE, NUM_SPECIALS,'+
    'STATUSICON_BLUETOOTH, STATUSICON_USB, STATUSICON_VM, STATUSICON_BATTERY,'+
    'NUM_STATUSICONS, SCREEN_BACKGROUND, SCREEN_LARGE, SCREEN_SMALL, NUM_SCREENS,'+
    'BITMAP_1, BITMAP_2, BITMAP_3, BITMAP_4, NUM_BITMAPS, STEPICON_1, STEPICON_2,'+
    'STEPICON_3, STEPICON_4, STEPICON_5, NUM_STEPICONS, SCREEN_BITS,'+
    'STEPICON_BITS, BITMAP_BITS, MENUICON_BITS, STATUSICON_BITS, SPECIAL_BITS,'+
    'TEXTLINE_BITS, SCREEN_BIT, STEPICON_BIT, BITMAP_BIT, MENUICON_BIT,'+
    'STATUSICON_BIT, SPECIAL_BIT, TEXTLINE_BIT,'+
    'SIZE_OF_USBBUF, USB_PROTOCOL_OVERHEAD, SIZE_OF_USBDATA, SIZE_OF_HSBUF,'+
    'SIZE_OF_BTBUF, BT_CMD_BYTE, SIZE_OF_BT_DEVICE_TABLE,'+
    'SIZE_OF_BT_CONNECT_TABLE, SIZE_OF_BT_NAME, SIZE_OF_BRICK_NAME,'+
    'SIZE_OF_CLASS_OF_DEVICE, SIZE_OF_BT_PINCODE, SIZE_OF_BDADDR,'+
    'MAX_BT_MSG_SIZE, BT_DEFAULT_INQUIRY_MAX, BT_DEFAULT_INQUIRY_TIMEOUT_LO,'+
    'BT_ARM_OFF, BT_ARM_CMD_MODE, BT_ARM_DATA_MODE, BT_BRICK_VISIBILITY,'+
    'BT_BRICK_PORT_OPEN, BT_CONNECTION_0_ENABLE, BT_CONNECTION_1_ENABLE,'+
    'BT_CONNECTION_2_ENABLE, BT_CONNECTION_3_ENABLE, BT_ENABLE, BT_DISABLE,'+
    'HS_UPDATE, HS_INITIALISE, HS_INIT_RECEIVER, HS_SEND_DATA, HS_DISABLE,'+
    'HS_ENABLE, HS_CTRL_INIT, HS_CTRL_UART, HS_CTRL_EXIT,' +
    'HS_BAUD_1200, HS_BAUD_2400, HS_BAUD_3600, HS_BAUD_4800, HS_BAUD_7200,'+
    'HS_BAUD_9600, HS_BAUD_14400, HS_BAUD_19200, HS_BAUD_28800, HS_BAUD_38400,'+
    'HS_BAUD_57600, HS_BAUD_76800, HS_BAUD_115200, HS_BAUD_230400, HS_BAUD_460800,'+
    'HS_BAUD_921600, HS_MODE_5_DATA, HS_MODE_6_DATA, HS_MODE_7_DATA, HS_MODE_8_DATA,'+
    'HS_MODE_10_STOP, HS_MODE_15_STOP, HS_MODE_20_STOP, HS_MODE_E_PARITY,'+
    'HS_MODE_O_PARITY, HS_MODE_S_PARITY, HS_MODE_M_PARITY, HS_MODE_N_PARITY,'+
    'HS_MODE_8N1, HS_MODE_7E1, INTF_CONNECTBYNAME,'+
    'BT_DEVICE_EMPTY, BT_DEVICE_UNKNOWN, BT_DEVICE_KNOWN, BT_DEVICE_NAME,'+
    'BT_DEVICE_AWAY, INTF_SENDFILE, INTF_SEARCH, INTF_STOPSEARCH, INTF_CONNECT,'+
    'INTF_DISCONNECT, INTF_DISCONNECTALL, INTF_REMOVEDEVICE, INTF_VISIBILITY,'+
    'INTF_SETCMDMODE, INTF_OPENSTREAM, INTF_SENDDATA, INTF_FACTORYRESET,'+
    'INTF_BTON, INTF_BTOFF, INTF_SETBTNAME, INTF_EXTREAD, INTF_PINREQ,'+
    'INTF_CONNECTREQ, LR_SUCCESS, LR_COULD_NOT_SAVE, LR_STORE_IS_FULL,'+
    'LR_ENTRY_REMOVED, LR_UNKNOWN_ADDR, USB_CMD_READY, BT_CMD_READY,'+
    'HS_CMD_READY, LCD_LINE1, LCD_LINE2, LCD_LINE3, LCD_LINE4, LCD_LINE5,'+
    'LCD_LINE6, LCD_LINE7, LCD_LINE8,'+
    'RESET_NONE, RESET_COUNT, RESET_BLOCK_COUNT, RESET_ROTATION_COUNT,'+
    'RESET_BLOCKANDTACHO, RESET_ALL,'+
    'PF_CMD_STOP, PF_CMD_FWD, PF_CMD_REV, PF_CMD_BRAKE,'+
    'PF_CHANNEL_1, PF_CHANNEL_2, PF_CHANNEL_3, PF_CHANNEL_4,'+
    'PF_MODE_TRAIN, PF_MODE_COMBO_DIRECT, PF_MODE_SINGLE_PIN_CONT,'+
    'PF_MODE_SINGLE_PIN_TIME, PF_MODE_COMBO_PWM, PF_MODE_SINGLE_OUTPUT_PWM,'+
    'PF_MODE_SINGLE_OUTPUT_CST, TRAIN_FUNC_STOP, TRAIN_FUNC_INCR_SPEED,'+
    'TRAIN_FUNC_DECR_SPEED, TRAIN_FUNC_TOGGLE_LIGHT, TRAIN_CHANNEL_1,'+
    'TRAIN_CHANNEL_2, TRAIN_CHANNEL_3, TRAIN_CHANNEL_ALL, PF_OUT_A,'+
    'PF_OUT_B, PF_PIN_C1, PF_PIN_C2, PF_FUNC_NOCHANGE, PF_FUNC_CLEAR,'+
    'PF_FUNC_SET, PF_FUNC_TOGGLE, PF_CST_CLEAR1_CLEAR2, PF_CST_SET1_CLEAR2,'+
    'PF_CST_CLEAR1_SET2, PF_CST_SET1_SET2, PF_CST_INCREMENT_PWM,'+
    'PF_CST_DECREMENT_PWM, PF_CST_FULL_FWD, PF_CST_FULL_REV, PF_CST_TOGGLE_DIR,'+
    'PF_PWM_FLOAT, PF_PWM_FWD1, PF_PWM_FWD2, PF_PWM_FWD3, PF_PWM_FWD4,'+
    'PF_PWM_FWD5, PF_PWM_FWD6, PF_PWM_FWD7, PF_PWM_BRAKE, PF_PWM_REV7,'+
    'PF_PWM_REV6, PF_PWM_REV5, PF_PWM_REV4, PF_PWM_REV3, PF_PWM_REV2, PF_PWM_REV1,'+
    'RCX_OUT_A, RCX_OUT_B, RCX_OUT_C, RCX_OUT_AB,'+
    'RCX_OUT_AC, RCX_OUT_BC, RCX_OUT_ABC, RCX_OUT_FLOAT,'+
    'RCX_OUT_OFF, RCX_OUT_ON, RCX_OUT_REV, RCX_OUT_TOGGLE,'+
    'RCX_OUT_FWD, RCX_OUT_LOW, RCX_OUT_HALF, RCX_OUT_FULL,'+
    'RCX_VariableSrc, RCX_TimerSrc, RCX_ConstantSrc, RCX_OutputStatusSrc,'+
    'RCX_RandomSrc, RCX_ProgramSlotSrc, RCX_InputValueSrc, RCX_InputTypeSrc,'+
    'RCX_InputModeSrc, RCX_InputRawSrc, RCX_InputBooleanSrc, RCX_WatchSrc,'+
    'RCX_MessageSrc, RCX_GlobalMotorStatusSrc, RCX_ScoutRulesSrc, RCX_ScoutLightParamsSrc,'+
    'RCX_ScoutTimerLimitSrc, RCX_CounterSrc, RCX_ScoutCounterLimitSrc, RCX_TaskEventsSrc,'+
    'RCX_ScoutEventFBSrc, RCX_EventStateSrc, RCX_TenMSTimerSrc, RCX_ClickCounterSrc,'+
    'RCX_UpperThresholdSrc, RCX_LowerThresholdSrc, RCX_HysteresisSrc, RCX_DurationSrc,'+
    'RCX_UARTSetupSrc, RCX_BatteryLevelSrc, RCX_FirmwareVersionSrc, RCX_IndirectVarSrc,'+
    'RCX_DatalogSrcIndirectSrc, RCX_DatalogSrcDirectSrc, RCX_DatalogValueIndirectSrc, RCX_DatalogValueDirectSrc,'+
    'RCX_DatalogRawIndirectSrc, RCX_DatalogRawDirectSrc, RCX_PingOp, RCX_BatteryLevelOp,'+
    'RCX_DeleteTasksOp, RCX_StopAllTasksOp, RCX_PBTurnOffOp, RCX_DeleteSubsOp,'+
    'RCX_ClearSoundOp, RCX_ClearMsgOp, RCX_LSCalibrateOp, RCX_MuteSoundOp,'+
    'RCX_UnmuteSoundOp, RCX_ClearAllEventsOp, RCX_OnOffFloatOp, RCX_IRModeOp,'+
    'RCX_PlaySoundOp, RCX_DeleteTaskOp, RCX_StartTaskOp, RCX_StopTaskOp,'+
    'RCX_SelectProgramOp, RCX_ClearTimerOp, RCX_AutoOffOp, RCX_DeleteSubOp,'+
    'RCX_ClearSensorOp, RCX_OutputDirOp, RCX_PlayToneVarOp, RCX_PollOp,'+
    'RCX_SetWatchOp, RCX_InputTypeOp, RCX_InputModeOp, RCX_SetDatalogOp,'+
    'RCX_DatalogOp, RCX_SendUARTDataOp, RCX_RemoteOp, RCX_VLLOp,'+
    'RCX_DirectEventOp, RCX_OutputPowerOp, RCX_PlayToneOp, RCX_DisplayOp,'+
    'RCX_PollMemoryOp, RCX_SetFeedbackOp, RCX_SetEventOp, RCX_GOutputPowerOp,'+
    'RCX_LSUpperThreshOp, RCX_LSLowerThreshOp, RCX_LSHysteresisOp, RCX_LSBlinkTimeOp,'+
    'RCX_CalibrateEventOp, RCX_SetVarOp, RCX_SumVarOp, RCX_SubVarOp,'+
    'RCX_DivVarOp, RCX_MulVarOp, RCX_SgnVarOp, RCX_AbsVarOp,'+
    'RCX_AndVarOp, RCX_OrVarOp, RCX_UploadDatalogOp, RCX_SetTimerLimitOp,'+
    'RCX_SetCounterOp, RCX_SetSourceValueOp, RCX_UnlockOp, RCX_BootModeOp,'+
    'RCX_UnlockFirmOp, RCX_ScoutRulesOp, RCX_ViewSourceValOp, RCX_ScoutOp,'+
    'RCX_SoundOp, RCX_GOutputModeOp, RCX_GOutputDirOp, RCX_LightOp,'+
    'RCX_IncCounterOp, RCX_DecCounterOp, RCX_ClearCounterOp, RCX_SetPriorityOp,'+
    'RCX_MessageOp, RCX_SOUND_CLICK, RCX_SOUND_DOUBLE_BEEP, RCX_SOUND_DOWN,'+
    'RCX_SOUND_UP, RCX_SOUND_LOW_BEEP, RCX_SOUND_FAST_UP, RCX_RemoteKeysReleased,'+
    'RCX_RemotePBMessage1, RCX_RemotePBMessage2, RCX_RemotePBMessage3, RCX_RemoteOutAForward,'+
    'RCX_RemoteOutBForward, RCX_RemoteOutCForward, RCX_RemoteOutABackward, RCX_RemoteOutBBackward,'+
    'RCX_RemoteOutCBackward, RCX_RemoteSelProgram1, RCX_RemoteSelProgram2, RCX_RemoteSelProgram3,'+
    'RCX_RemoteSelProgram4, RCX_RemoteSelProgram5, RCX_RemoteStopOutOff, RCX_RemotePlayASound,'+
    'SCOUT_LIGHT_ON, SCOUT_LIGHT_OFF, SCOUT_SOUND_REMOTE, SCOUT_SOUND_ENTERSA,'+
    'SCOUT_SOUND_KEYERROR, SCOUT_SOUND_NONE, SCOUT_SOUND_TOUCH1_PRES, SCOUT_SOUND_TOUCH1_REL,'+
    'SCOUT_SOUND_TOUCH2_PRES, SCOUT_SOUND_TOUCH2_REL, SCOUT_SOUND_ENTER_BRIGHT, SCOUT_SOUND_ENTER_NORMAL,'+
    'SCOUT_SOUND_ENTER_DARK, SCOUT_SOUND_1_BLINK, SCOUT_SOUND_2_BLINK, SCOUT_SOUND_COUNTER1,'+
    'SCOUT_SOUND_COUNTER2, SCOUT_SOUND_TIMER1, SCOUT_SOUND_TIMER2, SCOUT_SOUND_TIMER3,'+
    'SCOUT_SOUND_MAIL_RECEIVED, SCOUT_SOUND_SPECIAL1, SCOUT_SOUND_SPECIAL2, SCOUT_SOUND_SPECIAL3,'+
    'SCOUT_SNDSET_NONE, SCOUT_SNDSET_BASIC, SCOUT_SNDSET_BUG, SCOUT_SNDSET_ALARM,'+
    'SCOUT_SNDSET_RANDOM, SCOUT_SNDSET_SCIENCE, SCOUT_MODE_STANDALONE, SCOUT_MODE_POWER,'+
    'SCOUT_MR_NO_MOTION, SCOUT_MR_FORWARD, SCOUT_MR_ZIGZAG, SCOUT_MR_CIRCLE_RIGHT,'+
    'SCOUT_MR_CIRCLE_LEFT, SCOUT_MR_LOOP_A, SCOUT_MR_LOOP_B, SCOUT_MR_LOOP_AB,'+
    'SCOUT_TR_IGNORE, SCOUT_TR_REVERSE, SCOUT_TR_AVOID, SCOUT_TR_WAIT_FOR,'+
    'SCOUT_TR_OFF_WHEN, SCOUT_LR_IGNORE, SCOUT_LR_SEEK_LIGHT, SCOUT_LR_SEEK_DARK,'+
    'SCOUT_LR_AVOID, SCOUT_LR_WAIT_FOR, SCOUT_LR_OFF_WHEN, SCOUT_TGS_SHORT,'+
    'SCOUT_TGS_MEDIUM, SCOUT_TGS_LONG, SCOUT_FXR_NONE, SCOUT_FXR_BUG,'+
    'SCOUT_FXR_ALARM, SCOUT_FXR_RANDOM, SCOUT_FXR_SCIENCE,' +
    'OPARR_SUM, OPARR_MEAN, OPARR_SUMSQR, OPARR_STD, OPARR_MIN, OPARR_MAX, OPARR_SORT,' +
    'IOMapReadByID, IOMapWriteByID, DisplayExecuteFunction, CommExecuteFunction,' +
    'LoaderExecuteFunction, FileFindFirst, FileFindNext, FileOpenWriteLinear,' +
    'FileOpenWriteNonLinear, FileOpenReadLinear, CommHSControl,' +
    'CommHSCheckStatus, CommHSWrite, CommHSRead, ColorSensorRead,' +
    'CommBTOnOff, CommBTConnection, ReadSemData, WriteSemData,' +
    'ComputeCalibValue, UpdateCalibCacheInfo, DatalogWrite, DatalogGetTimes,' +
    'SetSleepTimeoutVal, ListFiles, CommLSWriteEx, FileSeek, FileResize, DrawGraphicArray,' +
    'DRAW_OPT_FONT_DIRECTIONS, DRAW_OPT_FONT_WRAP, DRAW_OPT_FONT_DIR_L2RB,' +
    'DRAW_OPT_FONT_DIR_L2RT, DRAW_OPT_FONT_DIR_R2LB, DRAW_OPT_FONT_DIR_R2LT,' +
    'DRAW_OPT_FONT_DIR_B2TL, DRAW_OPT_FONT_DIR_B2TR, DRAW_OPT_FONT_DIR_T2BL,' +
    'DRAW_OPT_FONT_DIR_T2BR, DrawFont, DrawPolygon, DrawEllipse,' +
    'I2C_REG_VERSION, I2C_REG_VENDOR_ID, I2C_REG_DEVICE_ID, I2C_REG_CMD,' +
    'HT_CMD_COLOR2_ACTIVE, HT_CMD_COLOR2_PASSIVE, HT_CMD_COLOR2_RAW,' +
    'HT_CMD_COLOR2_50HZ, HT_CMD_COLOR2_60HZ, HT_CMD_COLOR2_BLCAL,' +
    'HT_CMD_COLOR2_WBCAL, HT_CMD_COLOR2_FAR, HT_CMD_COLOR2_LED_HI,' +
    'HT_CMD_COLOR2_LED_LOW, HT_CMD_COLOR2_NEAR,' +
    'HT_CH1_A, HT_CH1_B, HT_CH2_A, HT_CH2_B, HT_CH3_A, HT_CH3_B, HT_CH4_A, HT_CH4_B';

  NXCConstants: string =
    'S1, S2, S3, S4, SENSOR_1, SENSOR_2, SENSOR_3, SENSOR_4,'+
    'SENSOR_TYPE_NONE, SENSOR_TYPE_TOUCH, SENSOR_TYPE_TEMPERATURE,'+
    'SENSOR_TYPE_LIGHT, SENSOR_TYPE_ROTATION, SENSOR_TYPE_LIGHT_ACTIVE,'+
    'SENSOR_TYPE_LIGHT_INACTIVE, SENSOR_TYPE_SOUND_DB,'+
    'SENSOR_TYPE_SOUND_DBA, SENSOR_TYPE_CUSTOM, SENSOR_TYPE_LOWSPEED,'+
    'SENSOR_TYPE_LOWSPEED_9V, SENSOR_TYPE_HIGHSPEED, SENSOR_MODE_RAW,'+
    'SENSOR_TYPE_COLORFULL, SENSOR_TYPE_COLORRED, SENSOR_TYPE_COLORGREEN,'+
    'SENSOR_TYPE_COLORBLUE, SENSOR_TYPE_COLORNONE,'+
    'SENSOR_MODE_BOOL, SENSOR_MODE_EDGE, SENSOR_MODE_PULSE,'+
    'SENSOR_MODE_PERCENT, SENSOR_MODE_CELSIUS, SENSOR_MODE_FAHRENHEIT,'+
    'SENSOR_MODE_ROTATION, SENSOR_TOUCH, SENSOR_LIGHT, SENSOR_ROTATION,'+
    'SENSOR_CELSIUS, SENSOR_FAHRENHEIT, SENSOR_PULSE, SENSOR_EDGE';

procedure LoadNBCCodeComplete(aItems : TStrings);
var
  tmpSL : TStringList;
begin
  aItems.Clear;
  tmpSL := TStringList.Create;
  try
    tmpSL.CommaText := OpCodes+', '+NBCCommands+', '+NBCConstants;
    tmpSL.Sort;
    aItems.AddStrings(tmpSL);
  finally
    tmpSL.Free;
  end;
end;

procedure LoadNXCConstants(aItems : TStrings);
var
  tmpSL : TStringList;
begin
  aItems.Clear;
  tmpSL := TStringList.Create;
  try
    tmpSL.CommaText := NBCConstants + ',' + NXCConstants;
    tmpSL.Sort;
    aItems.AddStrings(tmpSL);
  finally
    tmpSL.Free;
  end;
end;

procedure MakeIdentTable;
var
  c: char;
begin
  FillChar(Identifiers, SizeOf(Identifiers), 0);
  for c := 'a' to 'z' do
    Identifiers[c] := TRUE;
  for c := 'A' to 'Z' do
    Identifiers[c] := TRUE;
  for c := '0' to '9' do
    Identifiers[c] := TRUE;
  Identifiers['_'] := TRUE;
  Identifiers['.'] := TRUE;

  FillChar(mHashTable, SizeOf(mHashTable), 0);
  for c := 'a' to 'z' do
    mHashTable[c] := 1 + Ord(c) - Ord('a');
  for c := 'A' to 'Z' do
    mHashTable[c] := 27 + Ord(c) - Ord('A');
  for c := '0' to '9' do
    mHashTable[c] := 53 + Ord(c) - Ord('0');
{
  for c := 'a' to 'z' do
    mHashTable[c] := 1 + Ord(c) - Ord('a');
  for c := 'A' to 'Z' do
    mHashTable[c] := 1 + Ord(c) - Ord('A');
  for c := '0' to '9' do
    mHashTable[c] := 27 + Ord(c) - Ord('0');
}
end;

function TSynNBCSyn.KeyHash(ToHash: PChar): Integer;
begin
  Result := 0;
  while Identifiers[ToHash^] do begin
{$IFOPT Q-}
    Result := 7 * Result + mHashTable[ToHash^];
{$ELSE}
    Result := (7 * Result + mHashTable[ToHash^]) and $FFFFFF;
{$ENDIF}
    inc(ToHash);
  end;
  Result := Result and $3FF;
  fStringLen := ToHash - fToIdent;
end;

function TSynNBCSyn.KeyComp(const aKey: String): Boolean;
var
  i: integer;
  pKey1, pKey2: PChar;
begin
  pKey1 := fToIdent;
  // Note: fStringLen is always > 0 !
  pKey2 := pointer(aKey);
  for i := 1 to fStringLen do
  begin
    if mHashTable[pKey1^] <> mHashTable[pKey2^] then
    begin
      Result := FALSE;
      exit;
    end;
    Inc(pKey1);
    Inc(pKey2);
  end;
  Result := TRUE;
end;

procedure TSynNBCSyn.DoAddKeyword(AKeyword: string; AKind: integer);
var
  HashValue: integer;
begin
  HashValue := KeyHash(PChar(AKeyword));
  fKeywords[HashValue] := TSynHashEntry.Create(AKeyword, AKind);
end;

function TSynNBCSyn.IdentKind(MayBe: PChar): TtkTokenKind;
var
  Entry: TSynHashEntry;
begin
  fToIdent := MayBe;
  Entry := fKeywords[KeyHash(MayBe)];
  while Assigned(Entry) do begin
    if Entry.KeywordLen > fStringLen then
      break
    else if Entry.KeywordLen = fStringLen then
      if KeyComp(Entry.Keyword) then begin
        Result := TtkTokenKind(Entry.Kind);
        exit;
      end;
    Entry := Entry.Next;
  end;
  Result := tkIdentifier;
end;

procedure TSynNBCSyn.AsciiCharProc;
var
  dirname : string;
  bDone : boolean;
begin
  if Trim(fLine)[1] <> '#' then // '#' is not first non-whitespace char on the line, treat it as an invalid char
  begin
    fTokenID := tkUnknown;
    Inc(Run);
    Exit;
  end;
  fTokenID := tkDirective;
  dirname := '#';
  bDone := False;
  repeat
    if fLine[Run] = '/' then // comment?
    begin
      if fLine[Run + 1] = '/' then // is end of directive as well
      begin
        fRange := rsUnknown;                                              //ek 2000-04-25
        Exit;
      end;
    end;
    if (fLine[Run] = '\') and (fLine[Run +1 ] = #0) then // a multiline directive
    begin
      Inc(Run);
      fRange := rsMultiLineDirective;
      Exit;
    end;
    // once I see a space I am done collecting the directive name
    inc(Run);
    if fLine[Run] <= #32 then
      bDone := True;
    if not bDone then
      dirname := dirname + fLine[Run];
    if bDone and InvalidDirective(dirname) then
    begin
      fTokenID := tkUnknown;
      break;
    end;
  until fLine[Run] in [#0, #10, #13];
end;

procedure TSynNBCSyn.DirectiveEndProc;
begin
  fTokenID := tkDirective;
  case FLine[Run] of
    #0:
      begin
        NullProc;
        Exit;
      end;
    #10:
      begin
        LFProc;
        Exit;
      end;
    #13:
      begin
        CRProc;
        Exit;
      end;
  end;
  fRange := rsUnknown;
  repeat
    case FLine[Run] of
      #0, #10, #13: Break;
      '/': // comment?
        begin
          case fLine[Run + 1] of
            '/': // is end of directive as well
              begin
                fRange := rsUnknown;                                              //ek 2000-04-25
                Exit;
              end;
          end;
        end;
      '\': // yet another line?
        begin
          if fLine[Run + 1] = #0 then
          begin
            Inc(Run);
            fRange := rsMultiLineDirective;
            Exit;
          end;
        end;
    end;
    Inc(Run);
  until fLine[Run] in [#0, #10, #13];
end;

procedure TSynNBCSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      '#' : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}AsciiCharProc;
       #0 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NullProc;
      #10 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LFProc;
      #13 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}CRProc;
      #39 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SingleQuoteStringProc;
      '>' : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}GreaterProc;
      '<' : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LowerProc;
      '/' : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SlashProc;
      'A'..'Z', 'a'..'z', '_', '.':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}IdentProc;
      '0'..'9':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NumberProc;
      #1..#9, #11, #12, #14..#32:
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SpaceProc;
      ';':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}CommentProc;
      ':', '&', '{', '}', '=', '^', '-', '+', '(', ')', '*', '@', '"':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SymbolProc;
      else
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}UnknownProc;
    end;
end;

constructor TSynNBCSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fPreProcDirs := TStringList.Create;
  fPreProcDirs.CaseSensitive := True;
  fPreProcDirs.CommaText := PreProcDirectives;
  fPreProcDirs.Sorted := True;
  
  fKeywords := TSynHashEntryList.Create;

  fCommentAttri       := TSynHighlighterAttributes.Create(SYNS_AttrComment);
  fCommentAttri.Style := [fsItalic];
  AddAttribute(fCommentAttri);

  fDirecAttri := TSynHighlighterAttributes.Create(SYNS_AttrPreprocessor);
  fDirecAttri.Foreground := clPurple;
  AddAttribute(fDirecAttri);

  fIdentifierAttri    := TSynHighlighterAttributes.Create(SYNS_AttrIdentifier);
  AddAttribute(fIdentifierAttri);

  fKeyAttri           := TSynHighlighterAttributes.Create(SYNS_AttrReservedWord);
  fKeyAttri.Style     := [fsBold];
  AddAttribute(fKeyAttri);

  fCommandAttri := TSynHighlighterAttributes.Create(SYNS_AttrCommand);
  fCommandAttri.Foreground := clBlue;
  AddAttribute(fCommandAttri);

  fConstantAttri := TSynHighlighterAttributes.Create(SYNS_AttrConstant);
  fConstantAttri.Foreground := clGreen;
  AddAttribute(fConstantAttri);

  fNumberAttri        := TSynHighlighterAttributes.Create(SYNS_AttrNumber);
  AddAttribute(fNumberAttri);

  fSpaceAttri         := TSynHighlighterAttributes.Create(SYNS_AttrSpace);
  AddAttribute(fSpaceAttri);

  fStringAttri        := TSynHighlighterAttributes.Create(SYNS_AttrString);
  AddAttribute(fStringAttri);

  fSymbolAttri        := TSynHighlighterAttributes.Create(SYNS_AttrSymbol);
  AddAttribute(fSymbolAttri);

  MakeMethodTables;
  EnumerateKeywords(Ord(tkKey), OpCodes, IdentChars, {$IFDEF FPC}@{$ENDIF}DoAddKeyword);
  EnumerateKeywords(Ord(tkCommand), NBCCommands, IdentChars, {$IFDEF FPC}@{$ENDIF}DoAddKeyword);
  EnumerateKeywords(Ord(tkConstant), NBCConstants, IdentChars, {$IFDEF FPC}@{$ENDIF}DoAddKeyword);
  SetAttributesOnChange({$IFDEF FPC}@{$ENDIF}DefHighlightChange);
  fDefaultFilter      := SYNS_FilterNBC;
  fRange := rsUnknown;
end;

destructor TSynNBCSyn.Destroy;
begin
  fPreProcDirs.Free;
  fKeywords.Free;
  inherited Destroy;
end;

procedure TSynNBCSyn.SetLine({$IFDEF FPC}const {$ENDIF}NewValue: String; LineNumber:Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end;

procedure TSynNBCSyn.CommentProc;
begin
  fTokenID := tkComment;
  repeat
    Inc(Run);
  until fLine[Run] in [#0, #10, #13];
end;

procedure TSynNBCSyn.CRProc;
begin
  fTokenID := tkSpace;
  Inc(Run);
  if fLine[Run] = #10 then Inc(Run);
end;

procedure TSynNBCSyn.GreaterProc;
begin
  Inc(Run);
  fTokenID := tkSymbol;
  if fLine[Run] = '=' then Inc(Run);
end;

procedure TSynNBCSyn.IdentProc;
begin
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
end;

procedure TSynNBCSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TSynNBCSyn.LowerProc;
begin
  Inc(Run);
  fTokenID := tkSymbol;
  if fLine[Run] in ['=', '>'] then Inc(Run);
end;

procedure TSynNBCSyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TSynNBCSyn.NumberProc;
var
  idx1: Integer; // token[1]
  bIsHex : Boolean;
begin
  idx1 := Run;
  Inc(Run);
  fTokenID := tkNumber;
  bIsHex := False;
  while FLine[Run] in
    ['0'..'9', 'A'..'F', 'a'..'f', '.', 'x', 'X'] do
  begin
    case FLine[Run] of
      '.':
        if FLine[Succ(Run)] = '.' then
          Break
        else
          if bIsHex then
          begin
            fTokenID := tkUnknown;
            Exit;
          end;
      'a'..'f', 'A'..'F':
        if not bIsHex then // invalid char
          Break;
      'x', 'X':
        if (Run = Succ(idx1)) and   // 0x... 'x' must be second char
           (FLine[idx1] = '0') and  // 0x...
           (FLine[Succ(Run)] in ['0'..'9', 'a'..'f', 'A'..'F']) then // 0x... must be continued with a number
             bIsHex := True
           else // invalid char
           begin
             if (not Identifiers[fLine[Succ(Run)]]) and
                (FLine[Succ(idx1)] in ['x', 'X']) then
             begin
               Inc(Run); // highlight 'x' too
               fTokenID := tkUnknown;
             end;
             Break;
           end;
    end; // case
    Inc(Run);
  end; // while
  if FLine[Run] in ['A'..'Z', 'a'..'z', '_'] then
    fTokenID := tkUnknown;
end;


procedure TSynNBCSyn.SlashProc;
begin
  case FLine[Run + 1] of
    '/':
      begin
        inc(Run, 2);
        fTokenID := tkComment;
        while FLine[Run] <> #0 do
        begin
          case FLine[Run] of
            #10, #13: break;
          end;
          inc(Run);
        end;
      end;
    '*':
      begin
        fTokenID := tkComment;
        fRange := rsCStyle;
        inc(Run);
        while fLine[Run] <> #0 do
          case fLine[Run] of
            '*':
              if fLine[Run + 1] = '/' then
              begin
                fRange := rsUnKnown;
                inc(Run, 2);
                break;
              end else inc(Run);
            #10: break;
            #13: break;
          else inc(Run);
          end;
      end;
  else
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
end;

procedure TSynNBCSyn.CStyleProc;
begin
  case fLine[Run] of
     #0: NullProc;
    #10: LFProc;
    #13: CRProc;
  else
    fTokenID := tkComment;
    repeat
      if (fLine[Run] = '*') and (fLine[Run + 1] = '/') then begin
        fRange := rsUnKnown;
        Inc(Run, 2);
        break;
      end;
      Inc(Run);
    until fLine[Run] in [#0, #10, #13];
  end;
end;

procedure TSynNBCSyn.SpaceProc;
begin
  fTokenID := tkSpace;
  repeat
    Inc(Run);
  until (fLine[Run] > #32) or (fLine[Run] in [#0, #10, #13]);
end;

procedure TSynNBCSyn.SingleQuoteStringProc;
begin
  fTokenID := tkString;
  repeat
    if fLine[Run] = '\' then begin
      case fLine[Run + 1] of
        #39, '\':
          Inc(Run);
        #00:
          begin
            Inc(Run);
            fRange := rsMultilineString;
            Exit;
          end;
      end;
    end;
    inc(Run);
  until fLine[Run] in [#0, #10, #13, #39];
  if FLine[Run] = #39 then
    inc(Run);
(*
  fTokenID := tkString;
  if (FLine[Run + 1] = #39) and (FLine[Run + 2] = #39) then
    inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = #39;
  if FLine[Run] <> #0 then inc(Run);
*)
end;

procedure TSynNBCSyn.SingleQuoteStringEndProc;
begin
  fTokenID := tkString;

  case FLine[Run] of
    #0:
      begin
        NullProc;
        Exit;
      end;
    #10:
      begin
        LFProc;
        Exit;
      end;
    #13:
      begin
        CRProc;
        Exit;
      end;
  end;

  fRange := rsUnknown;

  repeat
    case FLine[Run] of
      #0, #10, #13: Break;
      '\':
        begin
          case fLine[Run + 1] of
            #39, '\':
              Inc(Run);
            #00:
              begin
                Inc(Run);
                fRange := rsMultilineString;
                Exit;
              end;
          end;
        end;
      #39: Break;
    end;
    inc(Run);
  until fLine[Run] in [#0, #10, #13, #39];
  if FLine[Run] = #39 then
    inc(Run);
end;

procedure TSynNBCSyn.SymbolProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
end;

procedure TSynNBCSyn.UnknownProc;
begin
{$IFDEF SYN_MBCSSUPPORT}
  if FLine[Run] in LeadBytes then
    Inc(Run,2)
  else
{$ENDIF}
  inc(Run);
  fTokenID := tkIdentifier;
end;

procedure TSynNBCSyn.Next;
begin
  fTokenPos := Run;
  case fRange of
    rsCStyle: CStyleProc;
    rsMultiLineDirective: DirectiveEndProc; // dj
    rsMultilineString: SingleQuoteStringEndProc;
  else
    fRange := rsUnknown;
    fProcTable[fLine[Run]];
  end;
end;

function TSynNBCSyn.GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT: Result := fCommentAttri;
    SYN_ATTR_IDENTIFIER: Result := fIdentifierAttri;
    SYN_ATTR_KEYWORD: Result := fKeyAttri;
    SYN_ATTR_COMMAND: Result := fCommandAttri;
    SYN_ATTR_CONSTANT: Result := fConstantAttri;
    SYN_ATTR_STRING: Result := fStringAttri;
    SYN_ATTR_WHITESPACE: Result := fSpaceAttri;
    SYN_ATTR_SYMBOL: Result := fSymbolAttri;
  else
    Result := nil;
  end;
end;

function TSynNBCSyn.GetEol: Boolean;
begin
  Result := fTokenId = tkNull;
end;

function TSynNBCSyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

{$IFDEF SYN_LAZARUS}
procedure TSynNBCSyn.GetTokenEx(var TokenStart: PChar;
  var TokenLength: integer);
begin
  TokenLength:=Run-fTokenPos;
  TokenStart:=FLine + fTokenPos;
end;
{$ENDIF}

function TSynNBCSyn.GetTokenAttribute: TSynHighlighterAttributes;
begin
  case fTokenID of
    tkComment: Result := fCommentAttri;
    tkDirective: Result := fDirecAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkCommand: Result := fCommandAttri;
    tkConstant: Result := fConstantAttri;
    tkNumber: Result := fNumberAttri;
    tkSpace: Result := fSpaceAttri;
    tkString: Result := fStringAttri;
    tkSymbol: Result := fSymbolAttri;
    tkUnknown: Result := fIdentifierAttri;
    else Result := nil;
  end;
end;

function TSynNBCSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TSynNBCSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TSynNBCSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

function TSynNBCSyn.GetIdentChars: TSynIdentChars;
begin
  Result := TSynValidStringChars;
end;

{$IFNDEF SYN_CPPB_1} class {$ENDIF}
function TSynNBCSyn.GetLanguageName: string;
begin
  Result := SYNS_LangNBC;
end;

function TSynNBCSyn.GetSampleSource: string;
begin
  Result :=
    '; waitasec.rxe'#13#10 +
    '#include "NXTDefs.h"'#13#10 +
    '; -------------- variable declarations --------------'#13#10 +
    'dseg	segment'#13#10 +
    ' endtick dword // this is a test'#13#10 +
    ' nowtick dword'#13#10 +
    ' msdelay sdword 5000'#13#10 +
    ' negVal sbyte 0xe3'#13#10 +
    ' tmpStr byte[] ''Testing'''#13#10 +
    '// fred byte 10'#13#10 +
    'dseg	ends'#13#10 +
    '; -------------- program code --------------'#13#10 +
    'thread main'#13#10 +
    ' set negVal, UF_UPDATE_SPEED'#13#10 +
    ' OnFwd(OUT_A) // a command'#13#10 +
    '/* this is a comment */'#13#10 +
    ' gettick nowtick	; time starts NOW'#13#10 +
    ' add endtick, nowtick, msdelay ; this is where we stop'#13#10 +
    'ticking:'#13#10 +
    ' gettick nowtick'#13#10 +
    ' brcmp EQ, ticking, nowtick, endtick'#13#10 +
    'tock:'#13#10 +
    ' exit'#13#10 +
    'endt';
end;

function TSynNBCSyn.InvalidDirective(const dirname : string) : boolean;
begin
  Result := fPreProcDirs.IndexOf(dirname) = -1;
end;

(*
procedure TSynNBCSyn.DirectiveProc;
var
  dirname : string;
  bDone : boolean;
begin
  fTokenID := tkDirective;
  dirname := '#';
  bDone := False;
  repeat
    // once I see a space I am done collecting the directive name
    inc(Run);
    if fLine[Run] <= #32 then
      bDone := True;
    if not bDone then
      dirname := dirname + fLine[Run];
    if bDone and InvalidDirective(dirname) then
    begin
      fTokenID := tkUnknown;
      break;
    end;
  until fLine[Run] in [#0, #10, #13];
end;
*)

procedure TSynNBCSyn.ResetRange;
begin
  fRange := rsUnknown;
end;

procedure TSynNBCSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

function TSynNBCSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

initialization
  MakeIdentTable;
{$IFNDEF SYN_CPPB_1}                                                            //mh 2000-07-14
  RegisterPlaceableHighlighter(TSynNBCSyn);
{$ENDIF}
end.

