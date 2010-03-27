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
unit SynHighlighterNQC;

{$I BricxCCSynEdit.inc}

interface

uses
  {$IFNDEF FPC}
  Windows,
  {$ENDIF}
  Classes, Registry,
  SynEditTypes, SynEditHighlighter;

type
  TtkTokenKind = (tkComment, tkIdentifier, tkKey, tkCommand, tkConstant, tkNull,
    tkNumber, tkPreprocessor, tkSpace, tkField, tkSymbol, tkUnknown);

  TCommentStyle = (csAnsiStyle, csPasStyle, csCStyle, csAsmStyle, csBasStyle);
  CommentStyles = set of TCommentStyle;

  TRangeState = (rsUnknown, rsAnsi, rsCStyle, rsMultiLineDirective, rsMultiLineField);

  TStringDelim = (sdSingleQuote, sdDoubleQuote);

  TProcTableProc = procedure of object;

type
  TSynBaseNCSyn = class(TSynCustomHighlighter)
  private
    fRange: TRangeState;
    fLine: PChar;
    fProcTable: array[#0..#255] of TProcTableProc;
    Run: LongInt;
    fTokenPos: Integer;
    fTokenID: TtkTokenKind;
    fLineNumber : Integer;
    fCommentAttri: TSynHighlighterAttributes;
    fIdentifierAttri: TSynHighlighterAttributes;
    fKeyAttri: TSynHighlighterAttributes;
    fCommandAttri: TSynHighlighterAttributes;
    fConstantAttri: TSynHighlighterAttributes;
    fNumberAttri: TSynHighlighterAttributes;
    fPreprocessorAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;
    fFieldAttri: TSynHighlighterAttributes;
    fSymbolAttri: TSynHighlighterAttributes;
    fKeyWords: TStrings;
    fCommands: TStrings;
    fConstants: TStrings;
    fComments: CommentStyles;
    fFieldDelimCh: char;
    fIdentChars: TSynIdentChars;
    fDetectPreprocessor: boolean;
    procedure AsciiCharProc;
    procedure BraceOpenProc;
    procedure PointCommaProc;
    procedure CRProc;
    procedure IdentProc;
    procedure IntegerProc;
    procedure LFProc;
    procedure NullProc;
    procedure NumberProc;
    procedure RoundOpenProc;
    procedure SlashProc;
    procedure SpaceProc;
    procedure FieldProc;
    procedure FieldEndProc;
    procedure UnknownProc;
    procedure MakeMethodTables;
    procedure CStyleProc;
    procedure SetKeyWords(const Value: TStrings);
    procedure SetCommands(const Value: TStrings);
    procedure SetConstants(const Value: TStrings);
    procedure SetComments(Value: CommentStyles);
    function GetStringDelim: TStringDelim;
    procedure SetStringDelim(const Value: TStringDelim);
    function GetIdentifierChars: string;
    procedure SetIdentifierChars(const Value: string);
    procedure SetDetectPreprocessor(Value: boolean);
    procedure DirectiveEndProc;
    function GetSourceStrings: TStrings;
    procedure SetSourceStrings(const Value: TStrings);
  protected
    fSampleSourceStrings : TStrings;
    function GetIdentChars: TSynIdentChars; override;
    function GetSampleSource : String; override;
    procedure LoadDefaultKeywords; virtual;
    procedure LoadDefaultCommands; virtual;
    procedure LoadDefaultConstants; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
      override;
    function GetEol: Boolean; override;
    function GetRange: Pointer; override;
    function GetTokenID: TtkTokenKind;
    function GetToken: String; override;
    {$IFDEF SYN_LAZARUS}
    procedure GetTokenEx(var TokenStart: PChar; var TokenLength: integer); override;
    {$ENDIF}
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;
    function IsKeyword(const AKeyword: string): boolean; override;              //mh 2000-11-08
    function IsCommand(const AToken: string): boolean;
    function IsConstant(const AToken: string): boolean;
    procedure Next; override;
    procedure ResetRange; override;
    procedure SetRange(Value: Pointer); override;
    procedure SetLine({$IFDEF FPC}const {$ENDIF}NewValue: String; LineNumber: Integer); override;
    {$IFNDEF SYN_KYLIX}
    function SaveToRegistry(RootKey: HKEY; Key: string): boolean; override;
    function LoadFromRegistry(RootKey: HKEY; Key: string): boolean; override;
    {$ENDIF}
  published
    property CommentAttri: TSynHighlighterAttributes read fCommentAttri
      write fCommentAttri;
    property Comments: CommentStyles read fComments write SetComments;
    property DetectPreprocessor: boolean read fDetectPreprocessor
      write SetDetectPreprocessor;
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri
      write fIdentifierAttri;
    property IdentifierChars: string read GetIdentifierChars
      write SetIdentifierChars;
    property KeyAttri: TSynHighlighterAttributes read fKeyAttri write fKeyAttri;
    property KeyWords: TStrings read fKeyWords write SetKeyWords;
    property CommandAttri: TSynHighlighterAttributes read fCommandAttri write fCommandAttri;
    property Commands: TStrings read fCommands write SetCommands;
    property ConstantAttri: TSynHighlighterAttributes read fConstantAttri write fConstantAttri;
    property Constants: TStrings read fConstants write SetConstants;
    property NumberAttri: TSynHighlighterAttributes read fNumberAttri
      write fNumberAttri;
    property PreprocessorAttri: TSynHighlighterAttributes
      read fPreprocessorAttri write fPreprocessorAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri
      write fSpaceAttri;
    property FieldAttri: TSynHighlighterAttributes read fFieldAttri
      write fFieldAttri;
    property SymbolAttri: TSynHighlighterAttributes read fSymbolAttri
      write fSymbolAttri;
    property FieldDelim: TStringDelim read GetStringDelim write SetStringDelim
      default sdDoubleQuote;
    property SampleSourceStrings : TStrings read GetSourceStrings write SetSourceStrings;
  end;

  TSynNXCSyn = class(TSynBaseNCSyn)
  public
    constructor Create(AOwner: TComponent); override;
{$IFNDEF SYN_CPPB_1} class {$ENDIF}
    function GetLanguageName: string; override;
  end;

  TSynNQCSyn = class(TSynBaseNCSyn)
  public
    constructor Create(AOwner: TComponent); override;
{$IFNDEF SYN_CPPB_1} class {$ENDIF}
    function GetLanguageName: string; override;
  end;

const
  SYN_ATTR_FIELD    = 6;
  SYN_ATTR_COMMAND  = 7;
  SYN_ATTR_CONSTANT = 8;


implementation

uses
  SysUtils,
  Graphics,
  SynEditStrConst;

{$IFDEF SYN_COMPILER_3_UP}
resourcestring
{$ELSE}
const
{$ENDIF}
  SYNS_AttrKeyword  = 'Keyword';
  SYNS_AttrCommand  = 'Command';
  SYNS_AttrConstant = 'Constant';
  SYNS_AttrField    = 'Field';
  SYNS_FilterNQC    = 'NQC Files (*.nqc,*.nqh)|*.nqc;*.nqh';
  SYNS_LangNQC      = 'NQC';
  SYNS_FilterNXC    = 'NXC Files (*.nxc)|*.nxc';
  SYNS_LangNXC      = 'NXC';

const
  K_MAX_COMMANDS = 240+92;
  K_MAX_CONSTANTS = 347+145+57+43;
  K_MAX_KEYWORDS = 36;
  K_DEF_COMMANDS : array[0..K_MAX_COMMANDS-1] of string =
  (
    'abs', 'sign',
    'SetSensor','SetSensorType','SetSensorMode','ClearSensor','SensorValue',
    'SensorType','SensorMode','SensorValueBool','SensorValueRaw',
    'SetSensorLowerLimit','SetSensorUpperLimit','SetSensorHysteresis',
    'CalibrateSensor','SetOutput','SetDirection','SetPower','OutputStatus',
    'On','Off','Float','Fwd','Rev','Toggle','OnFwd','OnRev','OnFor',
    'SetGlobalOutput','SetGlobalDirection','SetMaxPower','GlobalOutputStatus',
    'EnableOutput','DisableOutput','InvertOutput','ObvertOutput',
    'PlaySound','PlayTone','MuteSound','UnmuteSound','ClearSound',
    'SelectSounds','SelectDisplay','SetUserDisplay','Message','ClearMessage',
    'SendMessage','SetTxPower','SetSerialComm','SetSerialPacket',
    'SetMessage', 'SerialPacket', 'SerialComm',
    'SetSerialData','SerialData','SendSerial','SendVLL','ClearTimer','Timer',
    'SetTimer','FastTimer','ClearCounter','IncCounter','DecCounter','Counter',
    'SetPriority','ActiveEvents','CurrentEvents','Event','SetEvent',
    'ClearEvent','ClearAllEvents','EventState','CalibrateEvent','SetUpperLimit',
    'UpperLimit','SetLowerLimit','LowerLimit','SetHysteresis','Hysteresis',
    'SetClickTime','ClickTime','SetClickCounter','ClickCounter',
    'SetSensorClickTime','SetCounterLimit','SetTimerLimit','CreateDatalog',
    'AddToDatalog','UploadDatalog','Wait','StopAllTasks','Random',
    'SetRandomSeed','SetSleepTime','SleepNow','Program','SelectProgram',
    'BatteryLevel','FirmwareVersion','Watch','SetWatch','SetScoutRules',
    'ScoutRules','SetScoutMode','SetEventFeedback','EventFeedback','SetLight',
    'CounterLimit','TimerLimit',
    'Drive','OnWait','OnWaitDifferent','ClearTachoCounter','TachoCount',
    'TachoSpeed','ExternalMotorRunning','AGC', 'DIRSPEED',
    'EVENT_MASK', 'Set',
    'Indirect', 'SetIndirectVar', 'DatalogType', 'DatalogValue',
    'DatalogByte', 'InitSpybotComm', 'SendSpybotMsg', 'SetSpybotMessage',
    'SendSpybotMessage', 'SendSpybotCtrlMsg', 'SetSpybotCtrlMessage',
    'SendSpybotCtrlMessage', 'SendSpybotCtrlPingMsg', 'SetSpybotCtrlPingMessage',
    'SendSpybotCtrlPingMessage', 'SendSpybotPingMsg', 'SetSpybotPing',
    'SendSpybotPing', 'InitRCComm', 'SendRCMsg', 'SetRCMessage', 'SendRCMessage',
    'SetAnimation','SetLED','VLL','LED',
    'SerialType', 'SetSerialType', 'SerialBaud',
    'SetSerialBaud', 'SerialChannel', 'SetSerialChannel',
    'SerialPreamblePos', 'SetSerialPreamblePos', 'SerialPreambleLen',
    'SetSerialPreambleLen', 'SerialChecksum', 'SetSerialChecksum',
    'SerialBiPhase', 'SetSerialBiPhase', 'RxMessageLock',
    'SetRxMessageLock', 'RxMessageIndex', 'RxMessageChannel',
    'RxMessageID', 'RxMessage', 'AnimateLED',
    'RepeatAnimation', 'Gate', 'GateOff',
    'Glide', 'Vibrato', 'WaitEffect',
    'FixedWaitEffect', 'Tone', 'FixedTone',
    'RepeatEffect', 'EffectSound', 'EffectTime',
    'SetEffectSound', 'SetEffectTime', 'FindWorld',
    'ClearWorld', 'Target', 'SetTargetID',
    'SetTargetNote', 'GetWorld', 'GetWorldShortID',
    'GetWorldLinkID', 'GetWorldRange', 'GetWorldDirection',
    'GetWorldAspect', 'GetWorldNote', 'SetWorldNote',
    'World', 'WorldShortID', 'WorldLinkID', 'WorldRange',
    'WorldDirection', 'WorldAspect', 'WorldNote',
    'Stack', 'Push', 'Pop',
    'SetStack', 'TimerState', 'SetTimerState',
    'CurrentTaskID', 'PingControl', 'PingData',
    'SetPingData', 'PingInterval', 'SetPingInterval',
    'PingID', 'BeaconControl', 'LinkID',
    'SetLinkID', 'RCRxChannel', 'SetRCRxChannel',
    'RCTxChannel', 'SetRCTxChannel', 'RCTxMode',
    'SetRCTxMode', 'EEPROM',
    'SetEEPROM', 'StartTask', 'StopTask',
    'SendSpybotMessage', 'SendRCXMessage', 'SendAllRangeMessage',
    'Disp', 'BasicMove', 'Action',
    'RandomMove', 'FancyMove', 'SlowDownMove',
    'SpeedUpMove', 'Sum2Mem', 'Sum4Mem',
    'BitClear', 'BitSet', 'ClearAll', 'CommErrorsFraming', 'CommErrorsOverrun',
    'CommErrorsParity', 'CommErrorsTimeout', 'CurrentTask', 'DatalogSize',
    'DebugTaskMode', 'DefaultSerialComm', 'DefaultSerialPacket', 'DefaultStackSize',
    'EventCounts', 'EventSrc', 'EventType', 'ExpandedRemoteMessages',
    'ExpandedSubroutines', 'FloatDuringInactivePWM', 'GlobalVar',
    'IgnoreMessagesCPU', 'ImmediateBatteryLevel', 'InterCharTimeout',
    'IntrinsicIndGlobal', 'LCDRefreshRate', 'MemoryMapAddress', 'MessageParam',
    'MissedSensorADConversions', 'MotorBrakePower',
    'MotorPower128', 'MotorPower8', 'MotorPowerSigned', 'MotorTransitionDelay',
    'MSTimer', 'Negate', 'NoPowerDownOnAC', 'OpcodesPerTimeslice',
    'PlaySounds', 'PowerDownDelay', 'QueuedSoundCount', 'ResetMSTimer',
    'RotDebouncedGlitches', 'RotErrorsCount', 'SendMessageWithParam',
    'SensorDelayCycles', 'SensorRefreshRate', 'SensorRefreshState',
    'SensorScanCount', 'SensorStartupDelay', 'SerialLinkStatus',
    'SetDefaultSerialComm', 'SetDefaultSerialPacket', 'SetDefaultStackSize',
    'SetEventCounts', 'SetEventSrc', 'SetEventType', 'SetExpandedRemoteMessages',
    'SetExpandedSubroutines', 'SetFloatDuringInactivePWM', 'SetInterCharTimeout',
    'SetLCDRefreshRate', 'SetMessageByteParam', 'SetMessageVariableParam',
    'SetMessageWordParam', 'SetMotorBrakePower', 'SetMotorPower128',
    'SetMotorPower8', 'SetMotorPowerSigned', 'SetMotorTransitionDelay',
    'SetNoPowerDownOnAC', 'SetOpcodesPerTimeslice', 'SetPlaySounds',
    'SetSensorRefreshRate', 'SetSensorStartupDelay', 'SetSystem',
    'SetSystemPreambleSize', 'SetTaskAcquirePriority', 'SetTaskSchedulingPriority',
    'SetVolume', 'SetWatchFormat', 'SoundActive', 'StackAddress', 'StackSize',
    'System', 'SystemPreambleSize', 'TaskAcquirePriority', 'TaskSchedulingPriority',
    'TransmitterRange', 'UnsolicitedMessages', 'Volume', 'WaitMS', 'WatchFormat'
  );
  K_DEF_CONSTANTS : array[0..K_MAX_CONSTANTS-1] of string =
  (
    'SENSOR_1', 'SENSOR_2', 'SENSOR_3', 'SENSOR_L', 'SENSOR_M', 'SENSOR_R',
    'SENSOR_MODE_RAW', 'SENSOR_MODE_BOOL', 'SENSOR_MODE_EDGE', 'SENSOR_MODE_PULSE',
    'SENSOR_MODE_PERCENT', 'SENSOR_MODE_CELSIUS', 'SENSOR_MODE_FAHRENHEIT',
    'SENSOR_MODE_ROTATION', 'SENSOR_TYPE_NONE', 'SENSOR_TYPE_TOUCH',
    'SENSOR_TYPE_TEMPERATURE', 'SENSOR_TYPE_LIGHT', 'SENSOR_TYPE_ROTATION',
    'SENSOR_TOUCH', 'SENSOR_LIGHT', 'SENSOR_ROTATION', 'SENSOR_PULSE',
    'SENSOR_EDGE', 'SENSOR_CELSIUS', 'SENSOR_FAHRENHEIT', 'OUT_A', 'OUT_B', 'OUT_C',
    'OUT_L', 'OUT_R', 'OUT_X', 'OUT_OFF', 'OUT_ON', 'OUT_FLOAT', 'OUT_REV',
    'OUT_TOGGLE', 'OUT_FWD', 'OUT_FULL', 'OUT_LOW', 'OUT_HALF', 'SOUND_CLICK',
    'SOUND_DOUBLE_BEEP', 'SOUND_DOWN', 'SOUND_UP', 'SOUND_LOW_BEEP',
    'SOUND_FAST_UP', 'DISPLAY_WATCH', 'DISPLAY_SENSOR_1',
    'DISPLAY_SENSOR_2', 'DISPLAY_SENSOR_3', 'DISPLAY_OUT_A', 'DISPLAY_OUT_B',
    'DISPLAY_OUT_C', 'DISPLAY_USER', 'TX_POWER_LO', 'TX_POWER_HI',
    'SERIAL_COMM_DEFAULT', 'SERIAL_COMM_4800', 'SERIAL_COMM_DUTY25',
    'SERIAL_COMM_76KHZ', 'SERIAL_PACKET_DEFAULT', 'SERIAL_PACKET_PREAMBLE',
    'SERIAL_PACKET_NEGATED', 'SERIAL_PACKET_CHECKSUM', 'SERIAL_PACKET_RCX',
    'SERIAL_PACKET_RC', 'SERIAL_PACKET_SPYBOT', 'SERIAL_COMM_RCX',
    'SERIAL_COMM_RC', 'SERIAL_COMM_SPYBOT',
    'S1', 'S2', 'S3', 'T1', 'T2', 'T3', 'T4',
    'OUT_AB', 'OUT_AC', 'OUT_BC', 'OUT_ABC',
    'ACQUIRE_OUT_A', 'ACQUIRE_OUT_B', 'ACQUIRE_OUT_C', 'ACQUIRE_SOUND',
    'ACQUIRE_USER_1', 'ACQUIRE_USER_2', 'ACQUIRE_USER_3', 'ACQUIRE_USER_4',
    'ACQUIRE_LED', 'EVENT_TYPE_PRESSED', 'EVENT_TYPE_RELEASED', 'EVENT_TYPE_PULSE',
    'EVENT_TYPE_EDGE', 'EVENT_TYPE_FASTCHANGE', 'EVENT_TYPE_LOW',
    'EVENT_TYPE_NORMAL', 'EVENT_TYPE_HIGH', 'EVENT_TYPE_CLICK',
    'EVENT_TYPE_DOUBLECLICK', 'EVENT_TYPE_MESSAGE', 'EVENT_TYPE_ENTRY_FOUND',
    'EVENT_TYPE_MSG_DISCARD', 'EVENT_TYPE_MSG_RECEIVED',
    'EVENT_TYPE_VLL_MSG_RECEIVED', 'EVENT_TYPE_ENTRY_CHANGED', 'EVENT_1_PRESSED',
    'EVENT_1_RELEASED', 'EVENT_2_PRESSED', 'EVENT_2_RELEASED', 'EVENT_LIGHT_HIGH',
    'EVENT_LIGHT_NORMAL', 'EVENT_LIGHT_LOW', 'EVENT_LIGHT_CLICK',
    'EVENT_LIGHT_DOUBLECLICK', 'EVENT_COUNTER_0', 'EVENT_COUNTER_1',
    'EVENT_TIMER_0', 'EVENT_TIMER_1', 'EVENT_TIMER_2', 'EVENT_MESSAGE',
    'CMD_FIRE_ELECTRONET', 'CMD_FIRE_LASER', 'CMD_FIRE_SPINNER',
    'CMD_FROM_RCX2', 'CMD_GAME_BLINK', 'CMD_GAME_COMMAND',
    'CMD_GAME_GETVAR', 'CMD_GAME_GIVE', 'CMD_GAME_LOSE',
    'CMD_GAME_START', 'CMD_GAME_TAKE', 'CMD_GAME_VALUE',
    'CMD_GAME_WIN', 'CMD_REACT_TO_GIGAMESH', 'CMD_REACT_TO_SHADOWSTRIKE',
    'CMD_REACT_TO_SNAPTRAX', 'CMD_REACT_TO_TECHNOJAW', 'CMD_TELL_DIZZY',
    'CMD_TELL_FLASHBLIND', 'CMD_TELL_FREEZE', 'CMD_TELL_MAGNET',
    'CMD_TELL_REPULSE', 'CMD_TELL_REVERSE', 'CMD_TELL_SLOW',
    'CMD_TELL_TAKECONTROL', 'CMD_TYPE_SPARE', 'CMD_TYPE_USER',
    'CMD_TYPE_VLL', 'MSG_BROADCAST', 'MSG_DIRECT', 'MSG_LINKCAST',
    'RC_CHANNEL_1', 'RC_CHANNEL_2', 'RC_CHANNEL_3', 'RC_CMD_FLOAT',
    'RC_CMD_FWD', 'RC_CMD_OFF', 'RC_CMD_REV', 'SCOUT_MODE_POWER',
    'SCOUT_MODE_STANDALONE', 'SPY_CTRL_BTN_1', 'SPY_CTRL_BTN_2',
    'SPY_CTRL_BTN_3', 'SPY_CTRL_BTN_4', 'SPY_CTRL_BTN_5',
    'SPY_CTRL_RCX_1', 'SPY_CTRL_RCX_2', 'SPY_CTRL_RCX_3',
    'SPY_CTRL_RCX_4', 'SPY_CTRL_RCX_5', 'SPY_CTRL_RCX_6',
    'SPY_CTRL_RCX_7', 'SPY_CTRL_RCX_8', 'UART_BOT', 'UART_CTRL',
    'UART_PING', 'UART_RC',
    'LED_MODE_ON', 'LED_MODE_BLINK', 'LED_MODE_DURATION', 'LED_MODE_SCALE',
    'LED_MODE_SCALE_BLINK', 'LED_MODE_SCALE_DURATION', 'LED_MODE_RED_SCALE',
    'LED_MODE_RED_SCALE_BLINK', 'LED_MODE_GREEN_SCALE',
    'LED_MODE_GREEN_SCALE_BLINK', 'LED_MODE_YELLOW', 'LED_MODE_YELLOW_BLINK',
    'LED_MODE_YELLOW_DURATION', 'LED_MODE_VLL', 'LED_MODE_VLL_BLINK',
    'LED_MODE_VLL_DURATION', 'ANIMATION_SCAN', 'ANIMATION_SPARKLE',
    'ANIMATION_FLASH', 'ANIMATION_RED_TO_GREEN', 'ANIMATION_GREEN_TO_RED',
    'ANIMATION_POINT_FORWARD', 'ANIMATION_ALARM', 'ANIMATION_THINKING',
    'LIGHT_ON', 'LIGHT_OFF',
    'SERIAL_TYPE', 'SERIAL_TYPE_SPYBOT', 'SERIAL_TYPE_RCX',
    'SERIAL_TYPE_RC', 'SERIAL_TYPE_USER', 'SERIAL_BAUD',
    'SERIAL_BAUD_2400', 'SERIAL_BAUD_4800', 'SERIAL_BAUD_9600',
    'SERIAL_CHANNEL', 'SERIAL_CHANNEL_IR', 'SERIAL_CHANNEL_PC',
    'SERIAL_PREAMBLE_POS', 'SERIAL_PREAMBLE_LEN', 'SERIAL_CHECKSUM',
    'SERIAL_CHECKSUM_NONE', 'SERIAL_CHECKSUM_SUM', 'SERIAL_CHECKSUM_ZERO_SUM',
    'SERIAL_BIPHASE', 'SERIAL_BIPHASE_OFF', 'SERIAL_BIPHASE_ON',
    'MSG_NONE', 'MSG_IR', 'MSG_PC',
    'MSG_INDEX', 'MSG_COMMAND', 'MSG_HI_BYTE',
    'MSG_LO_BYTE', 'COMMAND_CONTROLLER', 'INDEX_LINKCAST',
    'INDEX_BROADCAST', 'INDEX_INVALID', 'TARGET_NONE',
    'ID_NONE', 'ID_CTRL1', 'ID_CTRL2',
    'ID_CTRL3', 'ID_CTRL4', 'ID_CTRL5',
    'ID_CTRL6', 'ID_PC', 'ID_BOT_MIN',
    'ID_BOT_MAX', 'RANGE_NOWHERE', 'RANGE_ANYWHERE',
    'RANGE_THERE', 'RANGE_HERE', 'DIRECTION_LEFT',
    'DIRECTION_LEFT_OF_CENTER', 'DIRECTION_CENTER', 'DIRECTION_RIGHT_OF_CENTER',
    'DIRECTION_RIGHT', 'ASPECT_FRONT_LEFT', 'ASPECT_FRONT',
    'ASPECT_FRONT_RIGHT', 'ASPECT_BACK_RIGHT', 'ASPECT_BACK',
    'ASPECT_BACK_LEFT', 'SPY_TARGETID', 'SPY_NOTE',
    'SPY_LINKID', 'SPY_RANGE', 'SPY_DIRECTION',
    'SPY_ASPECT', 'SPY_INFO', 'SPY_SHORTID',
    'REL_GT', 'REL_LT', 'REL_EQ',
    'REL_NE', 'TIMER_RUNNING', 'TIMER_STOPPED',
    'RC_CHANNEL_BROADCAST', 'RC_CHANNEL_1', 'RC_CHANNEL_2',
    'RC_CHANNEL_3', 'RC_CHANNEL_DISABLED', 'CONTROLLER_BUTTON1',
    'CONTROLLER_BUTTON2', 'CONTROLLER_BUTTON3', 'CONTROLLER_BUTTON4',
    'CONTROLLER_BUTTON5', 'RCTXMODE_SINGLE_SHOT', 'RCTXMODE_CONTINUOUS',
    'MOVE_BASIC', 'MOVE_RANDOM', 'MOVE_FANCY',
    'MOVE_SLOWDOWN', 'MOVE_SPEEDUP', 'MOVE_MASK',
    'MOVE_TYPE_MASK', 'MOVE_BASIC_FORWARD', 'MOVE_BASIC_BACKWARD',
    'MOVE_BASIC_SPIN_LEFT', 'MOVE_BASIC_SPIN_RIGHT', 'MOVE_BASIC_TURN_LEFT',
    'MOVE_BASIC_TURN_RIGHT', 'MOVE_BASIC_AVOID_LEFT', 'MOVE_BASIC_AVOID_RIGHT',
    'MOVE_BASIC_REST', 'MOVE_BASIC_STOP', 'MOVE_RANDOM_FORWARD',
    'MOVE_RANDOM_BACKWARD', 'MOVE_RANDOM_SPIN_LEFT', 'MOVE_RANDOM_SPIN_RIGHT',
    'MOVE_RANDOM_TURN_LEFT', 'MOVE_RANDOM_TURN_RIGHT', 'MOVE_RANDOM_REST',
    'MOVE_FANCY_ZIGZAG', 'MOVE_FANCY_SHAKE', 'MOVE_FANCY_SCAN',
    'MOVE_FANCY_STEP', 'MOVE_FANCY_STEP_BACK', 'MOVE_FANCY_SEARCH',
    'MOVE_FANCY_FAKE_LEFT', 'MOVE_FANCY_RAKE_RIGHT', 'MOVE_FANCY_BUG_FORWARD',
    'MOVE_FANCY_LAZY', 'MOVE_FANCY_WALK', 'MOVE_FANCY_WALK_BACK',
    'MOVE_FANCY_DANCE', 'MOVE_SLOWDOWN_FORWARD', 'MOVE_SLOWDOWN_BACKWARD',
    'MOVE_SLOWDOWN_SPIN_LEFT', 'MOVE_SLOWDOWN_SPIN_RIGHT', 'MOVE_SPEEDUP_FORWARD',
    'MOVE_SPEEDUP_BACKWARD', 'MOVE_SPEEDUP_SPIN_LEFT', 'MOVE_SPEEDUP_SPIN_RIGHT',
    'SOUND_NONE', 'SOUND_SHOCKED', 'SOUND_FIRE_LASER',
    'SOUND_FIRE_ELECTRONET', 'SOUND_FIRE_SPINNER', 'SOUND_HIT_BY_LASER',
    'SOUND_HIT_BY_ELECTRONET', 'SOUND_HIT_BY_SPINNER', 'SOUND_TAG',
    'SOUND_CRASH', 'SOUND_FIGHT', 'SOUND_GOT_IT',
    'SOUND_GENERAL_ALERT', 'SOUND_OUT_OF_ENERGY_ALERT', 'SOUND_LOW_ENERGY_ALERT',
    'SOUND_SCORE_ALERT', 'SOUND_TIME_ALERT', 'SOUND_PROXIMITY_ALERT',
    'SOUND_DANGER_ALERT', 'SOUND_BOMB_ALERT', 'SOUND_FINAL_COUNTDOWN',
    'SOUND_TICK_TOCK', 'SOUND_GOTO', 'SOUND_SCAN',
    'SOUND_POINT_TO', 'SOUND_ACTIVATE_SHIELDS', 'SOUND_ACTIVATE_REFLECT',
    'SOUND_ACTIVATE_CLOAK', 'SOUND_ACTIVATE_FLASH_BLIND', 'SOUND_MAGNET',
    'SOUND_QUAD_DAMAGE', 'SOUND_REPULSE', 'SOUND_TURBO',
    'SOUND_FREEZE', 'SOUND_SLOW', 'SOUND_REVERSE',
    'SOUND_DIZZY', 'SOUND_BOOST', 'SOUND_DEACTIVATE_SHIELDS',
    'SOUND_DEACTIVATE_REFLECT', 'SOUND_DEACTIVATE_CLOAK', 'SOUND_REFLECT',
    'SOUND_EXPLOSION', 'SOUND_BIG_EXPLOSION', 'SOUND_PLACE_BOMB',
    'SOUND_HIT_BY_WIND', 'SOUND_OUCH', 'SOUND_GEIGER',
    'SOUND_WHISTLE', 'SOUND_IM_IT', 'SOUND_HELP',
    'SOUND_SIREN', 'SOUND_BURNT', 'SOUND_GRINDED',
    'SOUND_SMACKED', 'SOUND_TRILL_UP', 'SOUND_TRILL_DOWN',
    'SOUND_YELL', 'SOUND_WHISPER', 'LED_RED1',
    'LED_RED2', 'LED_RED3', 'LED_GREEN1',
    'LED_GREEN2', 'LED_GREEN3', 'LED_YELLOW',
    'LED_ALL_RED', 'LED_ALL_GREEN', 'LED_ALL_RED_GREEN', 'LED_ALL',
    'EEPROM_MOTORCONTROL', 'EEPROM_SPECIES', 'EEPROM_LONGID',
    'EEPROM_USERLEVEL', 'EEPROM_DEFAULTPINGRATE', 'EEPROM_RUNS',
    'EEPROM_WINS', 'EEPROM_LOSSES', 'EEPROM_POINTS', 'EEPROM_PLAYSECONDS',
    'EEPROM_TOTALPLAYTIME', 'EEPROM_MAXBOTS', 'EEPROM_MISSIONID',
    'EEPROM_MISSIONSPLAYED', 'EEPROM_MISSIONPOINTS', 'EEPROM_HIGHSCORE',
    'EEPROM_ROBOTNAME', 'EEPROM_BIRTHDATE', 'EEPROM_BOTDATA', 'EEPROM_STATUS',
    'EEPROM_FIRSTTOKEN', 'EEPROM_LASTTOKEN', 'EEPROM_MAXTOKENS',
    'MOTORCONTROL_NORMALSPEEDMASK', 'MOTORCONTROL_SLOWSPEEDMASK',
    'MOTORCONTROL_LEFTDIR', 'MOTORCONTROL_RIGHTDIR',
    'SPECIES_GIGAMESH', 'SPECIES_SNAPTRAX', 'SPECIES_SHADOWSTRIKE',
    'SPECIES_TECHNOJAW', 'STATUS_INITIALIZING', 'STATUS_DOWNLOADING',
    'STATUS_LOCKED', 'BATTERY_MAX', 'BATTERY_LOW', 'BATTERY_MIN',
    'CMD_TYPE_MASK', 'CMD_TYPE_GAME', 'CMD_TYPE_FIRE', 'CMD_TYPE_REACT_TO',
    'CMD_TYPE_TELL', 'CMD_SMART_BOMB',
    'SENSOR_TYPE_ACTIVE_RAW', 'OUT_D', 'OUT_E', 'OUT_F',
    'SOUND_SHORT_BLIP', 'SOUND_EXCEPTION', 'DISPLAY_EXCEPTION',
    'SERIAL_COMM_9600', 'EVENT_TYPE_4', 'EVENT_TYPE_5', 'EVENT_TYPE_6',
    'EVENT_TYPE_VIRTUAL_MOTOR_CHANGE', 'EVENT_TYPE_VIRTUAL_MOTOR_POWER',
    'EVENT_TYPE_VIRTUAL_SENSOR_DEF', 'EVENT_TYPE_INFRARED_IDLE',
    'EVENT_TYPE_RESET', 'MTR_A', 'MTR_B', 'MTR_C', 'MTR_D', 'MTR_E',
    'MTR_F', 'MPD_FWD', 'MPD_REV', 'MPD_FLOAT', 'MPD_OFF',
    'MS_FLOAT', 'MS_BRAKE', 'MS_FWD', 'MS_REV', 'SMOTOR_FWD',
    'MTR_FWD_POWER_1', 'MTR_FWD_POWER_2', 'MTR_FWD_POWER_3',
    'MTR_FWD_POWER_4', 'MTR_FWD_POWER_5', 'MTR_FWD_POWER_6',
    'MTR_FWD_POWER_7', 'MTR_FWD_POWER_8', 'MTR_REV_POWER_1',
    'MTR_REV_POWER_2', 'MTR_REV_POWER_3', 'MTR_REV_POWER_4',
    'MTR_REV_POWER_5', 'MTR_REV_POWER_6', 'MTR_REV_POWER_7',
    'MTR_REV_POWER_8', 'MTR_FLOAT_POWER_1', 'MTR_FLOAT_POWER_2',
    'MTR_FLOAT_POWER_3', 'MTR_FLOAT_POWER_4', 'MTR_FLOAT_POWER_5',
    'MTR_FLOAT_POWER_6', 'MTR_FLOAT_POWER_7', 'MTR_FLOAT_POWER_8',
    'MTR_BRAKE_POWER_1', 'MTR_BRAKE_POWER_2', 'MTR_BRAKE_POWER_3',
    'MTR_BRAKE_POWER_4', 'MTR_BRAKE_POWER_5', 'MTR_BRAKE_POWER_6',
    'MTR_BRAKE_POWER_7', 'MTR_BRAKE_POWER_8', 'EST_SENSOR_1',
    'EST_SENSOR_2', 'EST_SENSOR_3', 'EST_TIMER_1', 'EST_TIMER_2',
    'EST_TIMER_3', 'EST_TIMER_4', 'EST_LAST_IR_MSG', 'EST_COUNTER_1',
    'EST_COUNTER_2', 'EST_COUNTER_3', 'EST_USER_EVENT_0',
    'EST_USER_EVENT_1', 'EST_USER_EVENT_2', 'EST_USER_EVENT_3',
    'EST_USER_EVENT_4', 'EST_VIRTUAL_MOTOR', 'EST_VIRTUAL_SENSOR',
    'EST_WAIT_FOR_MSG', 'EST_INFRARED_STATUS', 'EST_SENSOR_UNUSED',
    'ES_BELOW_LOWER', 'ES_BETWEEN', 'ES_ABOVE_UPPER', 'ES_UNDETERMINED',
    'SYS_BATTERY_LEVEL', 'SYS_DEBUG_TASK_MODE', 'SYS_MEMORY_MAP_ADDRESS',
    'SYS_CURRENT_TASK', 'SYS_SERIAL_LINK_STATUS', 'SYS_OPCODES_PER_TIMESLICE',
    'SYS_MOTOR_TRANSITION_DELAY', 'SYS_SENSOR_REFRESH_RATE',
    'SYS_EXPANDED_RC_MESSAGES', 'SYS_LCD_REFRESH_RATE',
    'SYS_NO_POWER_DOWN_ON_AC', 'SYS_DEFAULT_TASK_STACK_SIZE',
    'SYS_TASK_ACQUIRE_PRIORITY', 'SYS_TRANSMITTER_RANGE',
    'SYS_FLOAT_DURING_INACTIVE_PWM', 'SYS_ROT_ERRORS_COUNT',
    'SYS_ROT_DEBOUNCED_GLITCHES', 'SYS_PREAMBLE_SIZE',
    'SYS_UNSOLICITED_MESSAGES', 'SYS_EXPANDED_SUBROUTINES',
    'SYS_POWER_DOWN_DELAY', 'SYS_WATCH_FORMAT',
    'SYS_SENSOR_MISSED_CONVERSIONS', 'SYS_IGNORE_MESSAGES_CPU',
    'SYS_COMM_ERRORS_TIMEOUT', 'SYS_COMM_ERRORS_PARITY',
    'SYS_COMM_ERRORS_FRAMING', 'SYS_COMM_ERRORS_OVERRUN',
    'SYS_INTER_CHAR_TIMEOUT', 'SYS_TASK_SCHEDULING_PRIORITY',
    'SYS_VOLUME', 'SYS_SOUND_PLAYING', 'SYS_PLAY_SOUNDS',
    'SYS_QUEUED_SOUND_COUNT', 'SYS_SENSOR_STARTUP_DELAY',
    'SYS_SENSOR_DELAY_CYCLES', 'SYS_SENSOR_REFRESH_STATE',
    'SYS_SENSOR_SCAN_COUNT', 'SYS_DATALOG_SIZE', 'SLS_WAIT_FOR_MSG',
    'SLS_RECEIVING_MSG', 'SLS_TRANSMITTING', 'SLS_UNKNOWN', 'FMT_HHMM',
    'FMT_MMSS', 'FMT_MSSTENTHS', 'MAX_VOLUME', 'IRM_ACCEPT_ALL',
    'IRM_ACCEPT_USER', 'IRM_DISCARD', 'CLR_TIMERS', 'CLR_INPUTS',
    'CLR_VARIABLES', 'CLR_TASK_STACK', 'CLR_EVENTS', 'CLR_BREAKPOINTS',
    'CLR_DATALOG'
  );
  K_DEF_KEYWORDS : array[0..K_MAX_KEYWORDS-1] of string =
  (
    '__NQC__', '__event_src', '__nolist', '__res', '__sensor', '__type',
    'ANIMATION', 'acquire', 'asm', 'break',
    'case', 'catch', 'const', 'continue',
    'do', 'default', 'else', 'false', 'for', 'goto', 'if', 'inline', 'int',
    'monitor', 'repeat', 'return',
    'SOUNDEFFECT', 'start', 'stop', 'sub', 'switch', 'task', 'true',
    'until', 'void', 'while'
  );

var
  Identifiers: array[#0..#255] of ByteBool;

procedure MakeIdentTable;
var
  I: Char;
begin
  for I := #0 to #255 do
  begin
    Case I of
      '_', '0'..'9', 'a'..'z', 'A'..'Z': Identifiers[I] := True;
    else Identifiers[I] := False;
    end;
  end;
end;

procedure TSynBaseNCSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      '#': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}AsciiCharProc;
      '{': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}BraceOpenProc;
      ';': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}PointCommaProc;
      #13: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}CRProc;
      'A'..'Z', 'a'..'z', '_': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}IdentProc;
      '$': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}IntegerProc;
      #10: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LFProc;
      #0: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NullProc;
      '0'..'9': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NumberProc;
      '(': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}RoundOpenProc;
      '/': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SlashProc;
      #1..#9, #11, #12, #14..#32: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SpaceProc;
      else fProcTable[I] := {$IFDEF FPC}@{$ENDIF}UnknownProc;
    end;
  fProcTable[fFieldDelimCh] := {$IFDEF FPC}@{$ENDIF}FieldProc;
end;

constructor TSynBaseNCSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fKeyWords := TStringList.Create;
  TStringList(fKeyWords).CaseSensitive := True;
  TStringList(fKeyWords).Sorted        := True;
  TStringList(fKeyWords).Duplicates    := dupIgnore;
  LoadDefaultKeywords;

  fCommands := TStringList.Create;
  TStringList(fCommands).CaseSensitive := True;
  TStringList(fCommands).Sorted        := True;
  TStringList(fCommands).Duplicates    := dupIgnore;
  LoadDefaultCommands;

  fConstants := TStringList.Create;
  TStringList(fConstants).CaseSensitive := True;
  TStringList(fConstants).Sorted       := True;
  TStringList(fConstants).Duplicates   := dupIgnore;
  LoadDefaultConstants;

  fCommentAttri := TSynHighlighterAttributes.Create(SYNS_AttrComment);
  fCommentAttri.Style := [fsItalic];
  AddAttribute(fCommentAttri);

  fIdentifierAttri := TSynHighlighterAttributes.Create(SYNS_AttrIdentifier);
  AddAttribute(fIdentifierAttri);

  fKeyAttri := TSynHighlighterAttributes.Create(SYNS_AttrKeyword);
  fKeyAttri.Style := [fsBold];
  AddAttribute(fKeyAttri);

  fCommandAttri := TSynHighlighterAttributes.Create(SYNS_AttrCommand);
  fCommandAttri.Foreground := clBlue;
  AddAttribute(fCommandAttri);

  fConstantAttri := TSynHighlighterAttributes.Create(SYNS_AttrConstant);
  fConstantAttri.Foreground := clGreen;
  AddAttribute(fConstantAttri);

  fNumberAttri := TSynHighlighterAttributes.Create(SYNS_AttrNumber);
  fNumberAttri.Foreground := clRed;
  AddAttribute(fNumberAttri);

  fSpaceAttri := TSynHighlighterAttributes.Create(SYNS_AttrSpace);
  AddAttribute(fSpaceAttri);

  fFieldAttri := TSynHighlighterAttributes.Create(SYNS_AttrField);
  fFieldAttri.Foreground := clMaroon;
  fFieldAttri.Style := [fsItalic];
  AddAttribute(fFieldAttri);

  fSymbolAttri := TSynHighlighterAttributes.Create(SYNS_AttrSymbol);
  AddAttribute(fSymbolAttri);

  fPreprocessorAttri := TSynHighlighterAttributes.Create(SYNS_AttrPreprocessor);
  fPreprocessorAttri.Foreground := clPurple;
  AddAttribute(fPreprocessorAttri);

  SetAttributesOnChange({$IFDEF FPC}@{$ENDIF}DefHighlightChange);

  fComments := [csCStyle];
  fFieldDelimCh := '"';
  fIdentChars := ['_', '0'..'9', 'a'..'z', 'A'..'Z'];
  MakeMethodTables;
  fRange := rsUnknown;
  fDetectPreprocessor := true;

  fSampleSourceStrings := TStringList.Create;
end; { Create }

destructor TSynBaseNCSyn.Destroy;
begin
  fKeyWords.Free;
  fCommands.Free;
  fConstants.Free;
  fSampleSourceStrings.Free;
  inherited Destroy;
end; { Destroy }

procedure TSynBaseNCSyn.SetLine({$IFDEF FPC}const {$ENDIF}NewValue: String; LineNumber:Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end; { SetLine }

procedure TSynBaseNCSyn.CStyleProc;
begin
  case fLine[Run] of
     #0: NullProc;
    #10: LFProc;
    #13: CRProc;
  else
    fTokenID := tkComment;
    repeat
      if (fLine[Run] = '*') and (fLine[Run + 1] = '/') then begin
        fRange := rsUnknown;
        Inc(Run, 2);
        break;
      end;
      Inc(Run);
    until fLine[Run] in [#0, #10, #13];
  end;
end;

procedure TSynBaseNCSyn.AsciiCharProc;
begin
  if fDetectPreprocessor then begin
    if Trim(fLine)[1] <> '#' then // '#' is not first non-whitespace char on the line, treat it as an invalid char
    begin
      fTokenID := tkUnknown;
      Inc(Run);
      Exit;
    end;
    fTokenID := tkPreprocessor;
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
      inc(Run);
    until fLine[Run] in [#0, #10, #13];
  end else begin
    fTokenID := tkField;
    repeat
      inc(Run);
    until not (fLine[Run] in ['0'..'9']);
  end;
end;

procedure TSynBaseNCSyn.BraceOpenProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
end;

procedure TSynBaseNCSyn.PointCommaProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
end;

procedure TSynBaseNCSyn.CRProc;
begin
  fTokenID := tkSpace;
  Inc(Run);
  if fLine[Run] = #10 then Inc(Run);
end;

procedure TSynBaseNCSyn.IdentProc;
begin
  while Identifiers[fLine[Run]] do inc(Run);
  if IsKeyWord(GetToken) then fTokenId := tkKey
  else if IsCommand(GetToken) then fTokenId := tkCommand
  else if IsConstant(GetToken) then fTokenId := tkConstant
  else fTokenId := tkIdentifier;
end;

procedure TSynBaseNCSyn.IntegerProc;
begin
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in ['0'..'9', 'A'..'F', 'a'..'f'] do inc(Run);
end;

procedure TSynBaseNCSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TSynBaseNCSyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TSynBaseNCSyn.NumberProc;
begin
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in ['0'..'9', '.', 'e', 'E', 'x'] do
  begin
    case FLine[Run] of
      'x': begin // handle C style hex numbers
             IntegerProc;
             break;
           end;
      '.':
        if FLine[Run + 1] = '.' then break;
    end;
    inc(Run);
  end;
end;

procedure TSynBaseNCSyn.RoundOpenProc;
begin
  inc(Run);
  fTokenId := tkSymbol;
end;

procedure TSynBaseNCSyn.SlashProc;
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
                fRange := rsUnknown;
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

procedure TSynBaseNCSyn.SpaceProc;
begin
  inc(Run);
  fTokenID := tkSpace;
  while FLine[Run] in [#1..#9, #11, #12, #14..#32] do inc(Run);
end;

procedure TSynBaseNCSyn.FieldProc;
var
  ch : Char;
begin
  fTokenID := tkField;
  repeat
    if fLine[Run] = '\' then begin
      ch := fLine[Run + 1];
      if ch in ['\', fFieldDelimCh] then
        Inc(Run)
      else if ch = #0 then begin
        Inc(Run);
        fRange := rsMultilineField;
        Exit;
      end;
    end;
    inc(Run);
  until fLine[Run] in [#0, #10, #13, fFieldDelimCh];
  if FLine[Run] = fFieldDelimCh then
    inc(Run);
(*
  fTokenID := tkField;
  if (fLine[Run + 1] = fFieldDelimCh) and (fLine[Run + 2] = fFieldDelimCh) then
    Inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = fFieldDelimCh;
  if FLine[Run] <> #0 then inc(Run);
*)
end;

procedure TSynBaseNCSyn.FieldEndProc;
begin
  fTokenID := tkField;

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
            #34, '\':
              Inc(Run);
            #00:
              begin
                Inc(Run);
                fRange := rsMultilineField;
                Exit;
              end;
          end;
        end;
      #34: Break;
    end;
    inc(Run);
  until fLine[Run] in [#0, #10, #13, #34];
  if FLine[Run] = #34 then
    inc(Run);
end;

procedure TSynBaseNCSyn.UnknownProc;
begin
  inc(Run);
  fTokenID := tkUnKnown;
end;

procedure TSynBaseNCSyn.Next;
begin
  fTokenPos := Run;
  case fRange of
    rsCStyle: CStyleProc;
    rsMultiLineDirective: DirectiveEndProc; // dj
    rsMultilineField: FieldEndProc;
  else
    fRange := rsUnknown;
    fProcTable[fLine[Run]];
  end;
end;

function TSynBaseNCSyn.GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT: Result := fCommentAttri;
    SYN_ATTR_IDENTIFIER: Result := fIdentifierAttri;
    SYN_ATTR_KEYWORD: Result := fKeyAttri;
    SYN_ATTR_STRING: Result := fFieldAttri;
    SYN_ATTR_WHITESPACE: Result := fSpaceAttri;
    SYN_ATTR_SYMBOL: Result := fSymbolAttri;
    SYN_ATTR_FIELD: Result := fFieldAttri;
    SYN_ATTR_COMMAND: Result := fCommandAttri;
    SYN_ATTR_CONSTANT: Result := fConstantAttri;
  else
    Result := nil;
  end;
end;

function TSynBaseNCSyn.GetEol: Boolean;
begin
  Result := fTokenId = tkNull;
end;

function TSynBaseNCSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

function TSynBaseNCSyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

{$IFDEF SYN_LAZARUS}
procedure TSynBaseNCSyn.GetTokenEx(var TokenStart: PChar;
  var TokenLength: integer);
begin
  TokenLength:=Run-fTokenPos;
  TokenStart:=FLine + fTokenPos;
end;
{$ENDIF}

function TSynBaseNCSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TSynBaseNCSyn.GetTokenAttribute: TSynHighlighterAttributes;
begin
  case fTokenID of
    tkComment     : Result := fCommentAttri;
    tkIdentifier  : Result := fIdentifierAttri;
    tkKey         : Result := fKeyAttri;
    tkCommand     : Result := fCommandAttri;
    tkConstant    : Result := fConstantAttri;
    tkNumber      : Result := fNumberAttri;
    tkPreprocessor: Result := fPreprocessorAttri;
    tkSpace       : Result := fSpaceAttri;
    tkField       : Result := fFieldAttri;
    tkSymbol      : Result := fSymbolAttri;
    tkUnknown     : Result := fSymbolAttri;
  else
    Result := nil;
  end;
end;

function TSynBaseNCSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TSynBaseNCSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

procedure TSynBaseNCSyn.ReSetRange;
begin
  fRange := rsUnknown;
end;

procedure TSynBaseNCSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

procedure TSynBaseNCSyn.SetKeyWords(const Value: TStrings);
begin
  fKeyWords.Assign(Value);
  DefHighLightChange(nil);
end;

procedure TSynBaseNCSyn.SetCommands(const Value: TStrings);
begin
  fCommands.Assign(Value);
  DefHighLightChange(nil);
end;

procedure TSynBaseNCSyn.SetConstants(const Value: TStrings);
begin
  fConstants.Assign(Value);
  DefHighLightChange(nil);
end;

function TSynBaseNCSyn.LoadFromRegistry(RootKey: HKEY; Key: string): boolean;
var
  r: TBetterRegistry;
begin
  r:= TBetterRegistry.Create;
  try
    r.RootKey := RootKey;
    if r.OpenKeyReadOnly(Key) then begin
      if r.ValueExists('KeyWords') then KeyWords.Text:= r.ReadString('KeyWords');
      if r.ValueExists('Commands') then Commands.Text:= r.ReadString('Commands');
      if r.ValueExists('Constants') then Constants.Text:= r.ReadString('Constants');
      Result := inherited LoadFromRegistry(RootKey, Key);
    end
    else Result := false;
  finally r.Free; end;
end;

function TSynBaseNCSyn.SaveToRegistry(RootKey: HKEY; Key: string): boolean;
var
  r: TBetterRegistry;
begin
  r:= TBetterRegistry.Create;
  try
    r.RootKey := RootKey;
    if r.OpenKey(Key,true) then begin
      Result := true;
      r.WriteString('KeyWords', KeyWords.Text);
      r.WriteString('Commands', Commands.Text);
      r.WriteString('Constants', Constants.Text);
      Result := inherited SaveToRegistry(RootKey, Key);
    end
    else Result := false;
  finally r.Free; end;
end;

function TSynBaseNCSyn.GetIdentifierChars: string;
var
  ch: char;
  s: shortstring;
begin
  s := '';
  for ch := #0 to #255 do
    if ch in fIdentChars then s := s + ch;
  Result := s;
end;

procedure TSynBaseNCSyn.SetIdentifierChars(const Value: string);
var
  i: integer;
begin
  fIdentChars := [];
  for i := 1 to Length(Value) do begin
    fIdentChars := fIdentChars + [Value[i]];
  end; //for
end;

function TSynBaseNCSyn.GetIdentChars: TSynIdentChars;
begin
  Result := fIdentChars;
end;

procedure TSynBaseNCSyn.SetDetectPreprocessor(Value: boolean);
begin
  if Value <> fDetectPreprocessor then begin
    fDetectPreprocessor := Value;
    DefHighlightChange(Self);
  end;
end;

function TSynBaseNCSyn.IsKeyword(const AKeyword: string): boolean;
var
  i : integer;
begin
  Result := TStringList(fKeywords).Find(AKeyword, i);
end;

function TSynBaseNCSyn.IsCommand(const AToken: string): boolean;
var
  i : integer;
begin
  Result := TStringList(fCommands).Find(AToken, i);
end;

function TSynBaseNCSyn.IsConstant(const AToken: string): boolean;
var
  i : integer;
begin
  Result := TStringList(fConstants).Find(AToken, i);
end;

function TSynBaseNCSyn.GetStringDelim: TStringDelim;
begin
  if fFieldDelimCh = '''' then
    Result := sdSingleQuote
  else
    Result := sdDoubleQuote;
end;

procedure TSynBaseNCSyn.SetComments(Value: CommentStyles);
begin
  fComments := Value;
  DefHighLightChange(nil);
end;

procedure TSynBaseNCSyn.SetStringDelim(const Value: TStringDelim);
var
  newCh: char;
begin
  case Value of
    sdSingleQuote: newCh := '''';
    else newCh := '"';
  end; //case
  if newCh <> fFieldDelimCh then begin
    fFieldDelimCh := newCh;
    MakeMethodTables;
  end;
end;

function TSynBaseNCSyn.GetSampleSource: String;
begin
  Result := fSampleSourceStrings.Text;
end;

procedure TSynBaseNCSyn.LoadDefaultCommands;
var
  i : Integer;
begin
  for i := Low(K_DEF_COMMANDS) to High(K_DEF_COMMANDS) do
    fCommands.Add(K_DEF_COMMANDS[i]);
end;

procedure TSynBaseNCSyn.LoadDefaultConstants;
var
  i : Integer;
begin
  for i := Low(K_DEF_CONSTANTS) to High(K_DEF_CONSTANTS) do
    fConstants.Add(K_DEF_CONSTANTS[i]);
end;

procedure TSynBaseNCSyn.LoadDefaultKeywords;
var
  i : Integer;
begin
  for i := Low(K_DEF_KEYWORDS) to High(K_DEF_KEYWORDS) do
    fKeyWords.Add(K_DEF_KEYWORDS[i]);
end;

procedure TSynBaseNCSyn.DirectiveEndProc;
begin
  fTokenID := tkPreprocessor;
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

function TSynBaseNCSyn.GetSourceStrings: TStrings;
begin
  Result := fSampleSourceStrings;
end;

procedure TSynBaseNCSyn.SetSourceStrings(const Value: TStrings);
begin
  fSampleSourceStrings.Assign(Value);
end;

{ TSynNXCSyn }

constructor TSynNXCSyn.Create(AOwner: TComponent);
begin
  inherited;
  fDefaultFilter := SYNS_FilterNXC;
  fSampleSourceStrings.Text :=
    '/* syntax highlighting */'#13#10 +
    '// This is a Comment'#13#10 +
    '// #define is a Preprocessor'#13#10 +
    '#define NUM_LOOPS 4'#13#10 +
    'task main() // task is a Keyword'#13#10 +
    '{ // {},+(); are all Symbols'#13#10 +
    '  // NUM_LOOPS is an Identifier'#13#10 +
    '  repeat(NUM_LOOPS)'#13#10 +
    '  {'#13#10 +
    '    // TextOut is a Command'#13#10 +
    '    // "power_level" is a Field (aka String)'#13#10 +
    '    TextOut(0, 0, true, "power_level");'#13#10 +
    '    // OUT_AB is a Constant'#13#10 +
    '    OnFwd(OUT_AB, 75);'#13#10 +
    '    // 4000 is a Number'#13#10 +
    '    Wait(4000);'#13#10 +
    '  }'#13#10 +
    '}';
end;

{$IFNDEF SYN_CPPB_1}class {$ENDIF}
function TSynNXCSyn.GetLanguageName: string;
begin
  Result := SYNS_LangNXC;
end;

{ TSynNQCSyn }

constructor TSynNQCSyn.Create(AOwner: TComponent);
begin
  inherited;
  fDefaultFilter := SYNS_FilterNQC;
  fSampleSourceStrings.Text :=
    '/* syntax highlighting */'#13#10 +
    '// This is a Comment'#13#10 +
    '// #define is a Preprocessor'#13#10 +
    '#define NUM_LOOPS 4'#13#10 +
    'task main() // task is a Keyword'#13#10 +
    '{ // {},+(); are all Symbols'#13#10 +
    '  // NUM_LOOPS is an Identifier'#13#10 +
    '  repeat(NUM_LOOPS)'#13#10 +
    '  {'#13#10 +
    '    // SetPower is a Command'#13#10 +
    '    // "power_level" is a Field'#13#10 +
    '    SetPower(OUT_A+OUT_B,"power_level");'#13#10 +
    '    // OUT_A is a Constant'#13#10 +
    '    OnFwd(OUT_A+OUT_B);'#13#10 +
    '    // 400 is a Number'#13#10 +
    '    Wait(400);'#13#10 +
    '  }'#13#10 +
    '}';
end;

{$IFNDEF SYN_CPPB_1}class {$ENDIF}
function TSynNQCSyn.GetLanguageName: string;
begin
  Result := SYNS_LangNQC;
end;

initialization
  MakeIdentTable;
{$IFNDEF SYN_CPPB_1}
  RegisterPlaceableHighlighter(TSynNQCSyn);
  RegisterPlaceableHighlighter(TSynNXCSyn);
{$ENDIF}
end.

