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
unit uNBCCommon;

interface

uses
  Parser10, uNXTConstants, Classes, SysUtils;

type
  TLangName = (lnNBC, lnNXC, lnNXCHeader, lnRICScript, lnUnknown);

  TNBCExpParser = class(TExpParser)
  private
    fStandardDefs: boolean;
    fExtraDefs: boolean;
    fFirmwareVersion: word;
    procedure SetStandardDefs(const aValue: boolean);
    procedure SetExtraDefs(const aValue: boolean);
    procedure SetFirmwareVersion(const Value: word);
  public
    constructor Create(AOwner: TComponent); override;
    procedure InitializeCalc;
    property StandardDefines : boolean read fStandardDefs write SetStandardDefs;
    property ExtraDefines : boolean read fExtraDefs write SetExtraDefs;
    property FirmwareVersion : word read fFirmwareVersion write SetFirmwareVersion;
  end;

  TStatementType = (stUnsigned, stSigned, stFloat);
  TSymbolType = (stUnknown, stParam, stLocal, stGlobal, stAPIFunc, stAPIStrFunc);
  TOnCompilerMessage = procedure(const msg : string; var stop : boolean) of object;
  TFuncParamType = (fptUBYTE, fptSBYTE, fptUWORD, fptSWORD, fptULONG, fptSLONG, fptUDT, fptString, fptMutex, fptFloat);

  TFunctionParameter = class(TCollectionItem)
  private
    fName: string;
    fProcName: string;
    fIsReference: boolean;
    fIsArray: boolean;
    fIsConstant: boolean;
    fParamType: TFuncParamType;
    fParamIndex: integer;
    fDim: integer;
    fConstValue : string;
    fPTName: string;
    fFuncIsInline: boolean;
    fHasDefault: boolean;
    fDefaultValue: string;
    function GetParamDataType: char;
    function GetIsConstReference: boolean;
    function GetIsVarReference: boolean;
    function GetConstValue: string;
    procedure SetConstValue(const Value: string);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(ACollection: TCollection); override;
    property ProcName : string read fProcName write fProcName;
    property Name : string read fName write fName;
    property ParamIndex : integer read fParamIndex write fParamIndex;
    property ParamType : TFuncParamType read fParamType write fParamType;
    property ParamTypeName : string read fPTName write fPTName;
    property IsReference : boolean read fIsReference write fIsReference;
    property IsConstant : boolean read fIsConstant write fIsConstant;
    property IsArray : boolean read fIsArray write fIsArray;
    property ArrayDimension : integer read fDim write fDim;
    property ParameterDataType : char read GetParamDataType;
    property IsVarReference : boolean read GetIsVarReference;
    property IsConstReference : boolean read GetIsConstReference;
    property ConstantValue : string read GetConstValue write SetConstValue;
    property FuncIsInline : boolean read fFuncIsInline write fFuncIsInline;
    property HasDefault : boolean read fHasDefault write fHasDefault;
    property DefaultValue : string read fDefaultValue write fDefaultValue;
  end;

  TFunctionParameters = class(TCollection)
  private
    function GetItem(Index: Integer): TFunctionParameter;
    procedure SetItem(Index: Integer; const Value: TFunctionParameter);
  public
    constructor Create; virtual;
    function  Add: TFunctionParameter;
    function  Insert(Index: Integer): TFunctionParameter;
    property  Items[Index: Integer]: TFunctionParameter read GetItem write SetItem; default;
    function  IndexOf(const procname : string; const idx : integer) : integer; overload;
    function  ParamCount(const name : string) : integer;
    function  RequiredParamCount(const name : string) : integer;
  end;

  TVariable = class(TCollectionItem)
  private
    fIsConst: boolean;
    fDataType: char;
    fName: string;
    fValue: string;
    fTypeName: string;
    fLenExpr: string;
    fUseSafeCall: boolean;
    fLevel: integer;
    fHasDef: boolean;
    fDefValue: string;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(ACollection: TCollection); override;
    property Name : string read fName write fName;
    property DataType : char read fDataType write fDataType;
    property IsConstant : boolean read fIsConst write fIsConst;
    property UseSafeCall : boolean read fUseSafeCall write fUseSafeCall;
    property Value : string read fValue write fValue;
    property TypeName : string read fTypeName write fTypeName;
    property LenExpr : string read fLenExpr write fLenExpr;
    property Level : integer read fLevel write fLevel;
    property HasDefault : boolean read fHasDef write fHasDef;
    property DefaultValue : string read fDefValue write fDefValue;
  end;

  TVariableList = class(TCollection)
  private
    function GetItem(Index: Integer): TVariable;
    procedure SetItem(Index: Integer; const Value: TVariable);
  public
    constructor Create; virtual;
    function  Add: TVariable;
    function  Insert(Index: Integer): TVariable;
    function  IndexOfName(const name : string) : integer;
    property  Items[Index: Integer]: TVariable read GetItem write SetItem; default;
  end;

  TInlineFunction = class(TCollectionItem)
  private
    fName: string;
    fCode: TStrings;
    fEmitCount : integer;
    fVariables: TVariableList;
    fCallers: TStrings;
    fParams: TFunctionParameters;
    fCurrentCaller: string;
    procedure SetCode(const Value: TStrings);
    procedure SetParams(const Value: TFunctionParameters);
    function GetEndLabel: string;
    function FixupLabels(const tmpCode : string) : string;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Emit(aStrings : TStrings);
    property Name : string read fName write fName;
    property Code : TStrings read fCode write SetCode;
    property LocalVariables : TVariableList read fVariables;
    property Callers : TStrings read fCallers;
    property Parameters : TFunctionParameters read fParams write SetParams;
    property CurrentCaller : string read fCurrentCaller write fCurrentCaller;
    property EndLabel : string read GetEndLabel;
  end;

  TInlineFunctions = class(TCollection)
  private
    function GetItem(Index: Integer): TInlineFunction;
    procedure SetItem(Index: Integer; const Value: TInlineFunction);
  public
    constructor Create; virtual;
    function  Add: TInlineFunction;
    function  Insert(Index: Integer): TInlineFunction;
    function  IndexOfName(const name : string) : integer;
    property  Items[Index: Integer]: TInlineFunction read GetItem write SetItem; default;
  end;

  TArrayHelperVar = class(TCollectionItem)
  private
    fThreadName: string;
    fUDType : string;
    fDataType: char;
    fIndex : integer;
    fLocked : boolean;
    function GetName : string;
  public
    constructor Create(ACollection: TCollection); override;
    property ThreadName : string read fThreadName write fThreadName;
    property DataType : char read fDataType write fDataType;
    property UserDefinedType : string read fUDType write fUDType;
    property Index : integer read fIndex;
    property Locked : boolean read fLocked;
    property Name : string read GetName;
  end;

  TArrayHelperVars = class(TCollection)
  private
    function GetItem(Index: Integer): TArrayHelperVar;
    procedure SetItem(Index: Integer; const Value: TArrayHelperVar);
  public
    constructor Create; virtual;
    function  Add: TArrayHelperVar;
    function  Insert(Index: Integer): TArrayHelperVar;
    function  IndexOfName(const name : string) : integer;
    function  GetHelper(const tname, udType : string; const dt : char) : TArrayHelperVar;
    procedure ReleaseHelper(aHelper : TArrayHelperVar);
    property  Items[Index: Integer]: TArrayHelperVar read GetItem write SetItem; default;
  end;

const
  LABEL_PREFIX = '__NXC_Label_';

const
  STR_NA    = 'NA';
  STR_TRUE  = 'TRUE';
  STR_FALSE = 'FALSE';
  STR_OUT_A = 'OUT_A';
  STR_OUT_B = 'OUT_B';
  STR_OUT_C = 'OUT_C';
  OUT_A = $00;
  OUT_B = $01;
  OUT_C = $02;
  OUT_AB = $03;
  OUT_AC = $04;
  OUT_BC = $05;
  OUT_ABC = $06;
  STR_IN_1 = 'IN_1';
  STR_IN_2 = 'IN_2';
  STR_IN_3 = 'IN_3';
  STR_IN_4 = 'IN_4';
  IN_1 = $00;
  IN_2 = $01;
  IN_3 = $02;
  IN_4 = $03;
  STR_IO_BASE    = 'IO_BASE';
  STR_MOD_INPUT  = 'MOD_INPUT';
  STR_MOD_OUTPUT = 'MOD_OUTPUT';
  STR_IO_IN_FPP  = 'IO_IN_FPP';
  STR_IO_OUT_FPP = 'IO_OUT_FPP';
  IO_BASE    = $c000;
  MOD_INPUT  = $0000;
  MOD_OUTPUT = $0200;
  IO_IN_FPP  = 6;
  IO_OUT_FPP = 15;

type
  CCEncoding = record
    Encoding : Byte;
    Group : Byte;
    Mode : String;
    Symbol : String;
  end;

const
  CCEncodingsCount = 6;
  CCEncodings : array[0..CCEncodingsCount-1] of CCEncoding =
  (
    ( Encoding: 0; Group: 1; Mode: 'LT'  ; Symbol: '<'; ),
    ( Encoding: 1; Group: 1; Mode: 'GT'  ; Symbol: '>'; ),
    ( Encoding: 2; Group: 1; Mode: 'LTEQ'; Symbol: '<='; ),
    ( Encoding: 3; Group: 1; Mode: 'GTEQ'; Symbol: '>='; ),
    ( Encoding: 4; Group: 1; Mode: 'EQ'  ; Symbol: '=='; ),
    ( Encoding: 5; Group: 1; Mode: 'NEQ' ; Symbol: '!='; )
  );

type
  IDRec = record
    ID : integer;
    Name : string;
  end;

const
  UFCount = 8;
  UFRecords : array[0..UFCount-1] of IDRec =
  (
    ( ID: UF_UPDATE_MODE;                 Name: 'UF_UPDATE_MODE'; ),
    ( ID: UF_UPDATE_SPEED;                Name: 'UF_UPDATE_SPEED'; ),
    ( ID: UF_UPDATE_TACHO_LIMIT;          Name: 'UF_UPDATE_TACHO_LIMIT'; ),
    ( ID: UF_UPDATE_RESET_COUNT;          Name: 'UF_UPDATE_RESET_COUNT'; ),
    ( ID: UF_UPDATE_PID_VALUES;           Name: 'UF_UPDATE_PID_VALUES'; ),
    ( ID: UF_UPDATE_RESET_BLOCK_COUNT;    Name: 'UF_UPDATE_RESET_BLOCK_COUNT'; ),
    ( ID: UF_UPDATE_RESET_ROTATION_COUNT; Name: 'UF_UPDATE_RESET_ROTATION_COUNT'; ),
    ( ID: UF_PENDING_UPDATES;             Name: 'UF_PENDING_UPDATES'; )
  );

const
  OutModeCount = 5;
  OutModeRecords : array[0..OutModeCount-1] of IDRec =
  (
    ( ID: OUT_MODE_COAST;     Name: 'OUT_MODE_COAST'; ),
    ( ID: OUT_MODE_MOTORON;   Name: 'OUT_MODE_MOTORON'; ),
    ( ID: OUT_MODE_BRAKE;     Name: 'OUT_MODE_BRAKE'; ),
    ( ID: OUT_MODE_REGULATED; Name: 'OUT_MODE_REGULATED'; ),
    ( ID: OUT_MODE_REGMETHOD; Name: 'OUT_MODE_REGMETHOD'; )
  );

const
  OutRunStateCount = 4;
  OutRunStateRecords : array[0..OutRunStateCount-1] of IDRec =
  (
    ( ID: OUT_RUNSTATE_IDLE;     Name: 'OUT_RUNSTATE_IDLE'; ),
    ( ID: OUT_RUNSTATE_RAMPUP;   Name: 'OUT_RUNSTATE_RAMPUP'; ),
    ( ID: OUT_RUNSTATE_RUNNING;  Name: 'OUT_RUNSTATE_RUNNING'; ),
    ( ID: OUT_RUNSTATE_RAMPDOWN; Name: 'OUT_RUNSTATE_RAMPDOWN'; )
  );

const
  OutRegModeCount = 3;
  OutRegModeRecords : array[0..OutRegModeCount-1] of IDRec =
  (
    ( ID: OUT_REGMODE_IDLE;  Name: 'OUT_REGMODE_IDLE'; ),
    ( ID: OUT_REGMODE_SPEED; Name: 'OUT_REGMODE_SPEED'; ),
    ( ID: OUT_REGMODE_SYNC;  Name: 'OUT_REGMODE_SYNC'; )
  );

const
  InTypeCount = 18;
  InTypeRecords : array[0..InTypeCount-1] of IDRec =
  (
    ( ID: IN_TYPE_NO_SENSOR;      Name: 'IN_TYPE_NO_SENSOR'; ),
    ( ID: IN_TYPE_SWITCH;         Name: 'IN_TYPE_SWITCH'; ),
    ( ID: IN_TYPE_TEMPERATURE;    Name: 'IN_TYPE_TEMPERATURE'; ),
    ( ID: IN_TYPE_REFLECTION;     Name: 'IN_TYPE_REFLECTION'; ),
    ( ID: IN_TYPE_ANGLE;          Name: 'IN_TYPE_ANGLE'; ),
    ( ID: IN_TYPE_LIGHT_ACTIVE;   Name: 'IN_TYPE_LIGHT_ACTIVE'; ),
    ( ID: IN_TYPE_LIGHT_INACTIVE; Name: 'IN_TYPE_LIGHT_INACTIVE'; ),
    ( ID: IN_TYPE_SOUND_DB;       Name: 'IN_TYPE_SOUND_DB'; ),
    ( ID: IN_TYPE_SOUND_DBA;      Name: 'IN_TYPE_SOUND_DBA'; ),
    ( ID: IN_TYPE_CUSTOM;         Name: 'IN_TYPE_CUSTOM'; ),
    ( ID: IN_TYPE_LOWSPEED;       Name: 'IN_TYPE_LOWSPEED'; ),
    ( ID: IN_TYPE_LOWSPEED_9V;    Name: 'IN_TYPE_LOWSPEED_9V'; ),
    ( ID: IN_TYPE_HISPEED;        Name: 'IN_TYPE_HISPEED'; ),
    ( ID: IN_TYPE_COLORFULL;      Name: 'IN_TYPE_COLORFULL'; ),
    ( ID: IN_TYPE_COLORRED;       Name: 'IN_TYPE_COLORRED'; ),
    ( ID: IN_TYPE_COLORGREEN;     Name: 'IN_TYPE_COLORGREEN'; ),
    ( ID: IN_TYPE_COLORBLUE;      Name: 'IN_TYPE_COLORBLUE'; ),
    ( ID: IN_TYPE_COLORNONE;      Name: 'IN_TYPE_COLORNONE'; )
  );

const
  InModeCount = 10;
  InModeRecords : array[0..InModeCount-1] of IDRec =
  (
    ( ID: IN_MODE_RAW;           Name: 'IN_MODE_RAW'; ),
    ( ID: IN_MODE_BOOLEAN;       Name: 'IN_MODE_BOOLEAN'; ),
    ( ID: IN_MODE_TRANSITIONCNT; Name: 'IN_MODE_TRANSITIONCNT'; ),
    ( ID: IN_MODE_PERIODCOUNTER; Name: 'IN_MODE_PERIODCOUNTER'; ),
    ( ID: IN_MODE_PCTFULLSCALE;  Name: 'IN_MODE_PCTFULLSCALE'; ),
    ( ID: IN_MODE_CELSIUS;       Name: 'IN_MODE_CELSIUS'; ),
    ( ID: IN_MODE_FAHRENHEIT;    Name: 'IN_MODE_FAHRENHEIT'; ),
    ( ID: IN_MODE_ANGLESTEP;     Name: 'IN_MODE_ANGLESTEP'; ),
    ( ID: IN_MODE_SLOPEMASK;     Name: 'IN_MODE_SLOPEMASK'; ),
    ( ID: IN_MODE_MODEMASK;      Name: 'IN_MODE_MODEMASK'; )
  );

const
  OutputFieldIDsCount = 18;
  NumOutputs          = 3;
  OutputFieldIDs : array[0..OutputFieldIDsCount-1] of IDRec =
  (
    ( ID: UpdateFlags;     Name: 'UpdateFlags'; ),
    ( ID: OutputMode;      Name: 'OutputMode'; ),
    ( ID: Power;           Name: 'Power'; ),
    ( ID: ActualSpeed;     Name: 'ActualSpeed'; ),
    ( ID: TachoCount;      Name: 'TachoCount'; ),
    ( ID: TachoLimit;      Name: 'TachoLimit'; ),
    ( ID: RunState;        Name: 'RunState'; ),
    ( ID: TurnRatio;       Name: 'TurnRatio'; ),
    ( ID: RegMode;         Name: 'RegMode'; ),
    ( ID: Overloaded;      Name: 'Overload'; ),
    ( ID: RegPValue;       Name: 'RegPValue'; ),
    ( ID: RegIValue;       Name: 'RegIValue'; ),
    ( ID: RegDValue;       Name: 'RegDValue'; ),
    ( ID: BlockTachoCount; Name: 'BlockTachoCount'; ),
    ( ID: RotationCount;   Name: 'RotationCount'; ),
    ( ID: OutputOptions;   Name: 'OutputOptions'; ),
    ( ID: MaxSpeed;        Name: 'MaxSpeed'; ),
    ( ID: MaxAcceleration; Name: 'MaxAcceleration'; )
  );

const
  InputFieldIDsCount = 6;
  NumInputs          = 4;
  InputFieldIDs : array[0..InputFieldIDsCount-1] of IDRec =
  (
    ( ID: InputType;       Name: 'Type'; ),
    ( ID: InputMode;       Name: 'InputMode'; ),
    ( ID: RawValue;        Name: 'RawValue'; ),
    ( ID: NormalizedValue; Name: 'NormalizedValue'; ),
    ( ID: ScaledValue;     Name: 'ScaledValue'; ),
    ( ID: InvalidData;     Name: 'InvalidData'; )
  );

const
  IOMapFieldIDsCount = (InputFieldIDsCount*NumInputs)+((OutputFieldIDsCount-3)*NumOutputs);
  IOMapFieldIDs : array[0..IOMapFieldIDsCount-1] of IDRec =
  (
// input IO Map addresses
    ( ID: IO_BASE+$000; Name: 'InputIOType0'; ),
    ( ID: IO_BASE+$001; Name: 'InputIOInputMode0'; ),
    ( ID: IO_BASE+$002; Name: 'InputIORawValue0'; ),
    ( ID: IO_BASE+$003; Name: 'InputIONormalizedValue0'; ),
    ( ID: IO_BASE+$004; Name: 'InputIOScaledValue0'; ),
    ( ID: IO_BASE+$005; Name: 'InputIOInvalidData0'; ),
    ( ID: IO_BASE+$006; Name: 'InputIOType1'; ),
    ( ID: IO_BASE+$007; Name: 'InputIOInputMode1'; ),
    ( ID: IO_BASE+$008; Name: 'InputIORawValue1'; ),
    ( ID: IO_BASE+$009; Name: 'InputIONormalizedValue1'; ),
    ( ID: IO_BASE+$00a; Name: 'InputIOScaledValue1'; ),
    ( ID: IO_BASE+$00b; Name: 'InputIOInvalidData1'; ),
    ( ID: IO_BASE+$00c; Name: 'InputIOType2'; ),
    ( ID: IO_BASE+$00d; Name: 'InputIOInputMode2'; ),
    ( ID: IO_BASE+$00e; Name: 'InputIORawValue2'; ),
    ( ID: IO_BASE+$00f; Name: 'InputIONormalizedValue2'; ),
    ( ID: IO_BASE+$010; Name: 'InputIOScaledValue2'; ),
    ( ID: IO_BASE+$011; Name: 'InputIOInvalidData2'; ),
    ( ID: IO_BASE+$012; Name: 'InputIOType3'; ),
    ( ID: IO_BASE+$013; Name: 'InputIOInputMode3'; ),
    ( ID: IO_BASE+$014; Name: 'InputIORawValue3'; ),
    ( ID: IO_BASE+$015; Name: 'InputIONormalizedValue3'; ),
    ( ID: IO_BASE+$016; Name: 'InputIOScaledValue3'; ),
    ( ID: IO_BASE+$017; Name: 'InputIOInvalidData3'; ),
// output IO Map addresses
    ( ID: IO_BASE+$200; Name: 'OutputIOUpdateFlags0'; ),
    ( ID: IO_BASE+$201; Name: 'OutputIOOutputMode0'; ),
    ( ID: IO_BASE+$202; Name: 'OutputIOPower0'; ),
    ( ID: IO_BASE+$203; Name: 'OutputIOActualSpeed0'; ),
    ( ID: IO_BASE+$204; Name: 'OutputIOTachoCount0'; ),
    ( ID: IO_BASE+$205; Name: 'OutputIOTachoLimit0'; ),
    ( ID: IO_BASE+$206; Name: 'OutputIORunState0'; ),
    ( ID: IO_BASE+$207; Name: 'OutputIOTurnRatio0'; ),
    ( ID: IO_BASE+$208; Name: 'OutputIORegMode0'; ),
    ( ID: IO_BASE+$209; Name: 'OutputIOOverload0'; ),
    ( ID: IO_BASE+$20a; Name: 'OutputIORegPValue0'; ),
    ( ID: IO_BASE+$20b; Name: 'OutputIORegIValue0'; ),
    ( ID: IO_BASE+$20c; Name: 'OutputIORegDValue0'; ),
    ( ID: IO_BASE+$20d; Name: 'OutputIOBlockTachoCount0'; ),
    ( ID: IO_BASE+$20e; Name: 'OutputIORotationCount0'; ),
    ( ID: IO_BASE+$20f; Name: 'OutputIOUpdateFlags1'; ),
    ( ID: IO_BASE+$210; Name: 'OutputIOOutputMode1'; ),
    ( ID: IO_BASE+$211; Name: 'OutputIOPower1'; ),
    ( ID: IO_BASE+$212; Name: 'OutputIOActualSpeed1'; ),
    ( ID: IO_BASE+$213; Name: 'OutputIOTachoCount1'; ),
    ( ID: IO_BASE+$214; Name: 'OutputIOTachoLimit1'; ),
    ( ID: IO_BASE+$215; Name: 'OutputIORunState1'; ),
    ( ID: IO_BASE+$216; Name: 'OutputIOTurnRatio1'; ),
    ( ID: IO_BASE+$217; Name: 'OutputIORegMode1'; ),
    ( ID: IO_BASE+$218; Name: 'OutputIOOverload1'; ),
    ( ID: IO_BASE+$219; Name: 'OutputIORegPValue1'; ),
    ( ID: IO_BASE+$21a; Name: 'OutputIORegIValue1'; ),
    ( ID: IO_BASE+$21b; Name: 'OutputIORegDValue1'; ),
    ( ID: IO_BASE+$21c; Name: 'OutputIOBlockTachoCount1'; ),
    ( ID: IO_BASE+$21d; Name: 'OutputIORotationCount1'; ),
    ( ID: IO_BASE+$21e; Name: 'OutputIOUpdateFlags2'; ),
    ( ID: IO_BASE+$21f; Name: 'OutputIOOutputMode2'; ),
    ( ID: IO_BASE+$220; Name: 'OutputIOPower2'; ),
    ( ID: IO_BASE+$221; Name: 'OutputIOActualSpeed2'; ),
    ( ID: IO_BASE+$222; Name: 'OutputIOTachoCount2'; ),
    ( ID: IO_BASE+$223; Name: 'OutputIOTachoLimit2'; ),
    ( ID: IO_BASE+$224; Name: 'OutputIORunState2'; ),
    ( ID: IO_BASE+$225; Name: 'OutputIOTurnRatio2'; ),
    ( ID: IO_BASE+$226; Name: 'OutputIORegMode2'; ),
    ( ID: IO_BASE+$227; Name: 'OutputIOOverload2'; ),
    ( ID: IO_BASE+$228; Name: 'OutputIORegPValue2'; ),
    ( ID: IO_BASE+$229; Name: 'OutputIORegIValue2'; ),
    ( ID: IO_BASE+$22a; Name: 'OutputIORegDValue2'; ),
    ( ID: IO_BASE+$22b; Name: 'OutputIOBlockTachoCount2'; ),
    ( ID: IO_BASE+$22c; Name: 'OutputIORotationCount2'; )
  );


const
  SysCallMethodIDsCount1x = 48;
  SysCallMethodIDs1x : array[0..SysCallMethodIDsCount1x-1] of IDRec =
  (
    ( ID: 0; Name: 'FileOpenRead'; ),
    ( ID: 1; Name: 'FileOpenWrite'; ),
    ( ID: 2; Name: 'FileOpenAppend'; ),
    ( ID: 3; Name: 'FileRead'; ),
    ( ID: 4; Name: 'FileWrite'; ),
    ( ID: 5; Name: 'FileClose'; ),
    ( ID: 6; Name: 'FileResolveHandle'; ),
    ( ID: 7; Name: 'FileRename'; ),
    ( ID: 8; Name: 'FileDelete'; ),
    ( ID: 9; Name: 'SoundPlayFile'; ),
    ( ID: 10; Name: 'SoundPlayTone'; ),
    ( ID: 11; Name: 'SoundGetState'; ),
    ( ID: 12; Name: 'SoundSetState'; ),
    ( ID: 13; Name: 'DrawText'; ),
    ( ID: 14; Name: 'DrawPoint'; ),
    ( ID: 15; Name: 'DrawLine'; ),
    ( ID: 16; Name: 'DrawCircle'; ),
    ( ID: 17; Name: 'DrawRect'; ),
    ( ID: 18; Name: 'DrawGraphic'; ),
    ( ID: 19; Name: 'SetScreenMode'; ),
    ( ID: 20; Name: 'ReadButton'; ),
    ( ID: 21; Name: 'CommLSWrite'; ),
    ( ID: 22; Name: 'CommLSRead'; ),
    ( ID: 23; Name: 'CommLSCheckStatus'; ),
    ( ID: 24; Name: 'RandomNumber'; ),
    ( ID: 25; Name: 'GetStartTick'; ),
    ( ID: 26; Name: 'MessageWrite'; ),
    ( ID: 27; Name: 'MessageRead'; ),
    ( ID: 28; Name: 'CommBTCheckStatus'; ),
    ( ID: 29; Name: 'CommBTWrite'; ),
    ( ID: 30; Name: 'CommBTRead'; ),
    ( ID: 31; Name: 'KeepAlive'; ),
    ( ID: 32; Name: 'IOMapRead'; ),
    ( ID: 33; Name: 'IOMapWrite'; ),
    ( ID: 34; Name: 'IOMapReadByID'; ),
    ( ID: 35; Name: 'IOMapWriteByID'; ),
    ( ID: 36; Name: 'DisplayExecuteFunction'; ),
    ( ID: 37; Name: 'CommExecuteFunction'; ),
    ( ID: 38; Name: 'LoaderExecuteFunction'; ),
    ( ID: 39; Name: 'FileFindFirst'; ),
    ( ID: 40; Name: 'FileFindNext'; ),
    ( ID: 41; Name: 'FileOpenWriteLinear'; ),
    ( ID: 42; Name: 'FileOpenWriteNonLinear'; ),
    ( ID: 43; Name: 'FileOpenReadLinear'; ),
    ( ID: 44; Name: 'CommHSControl'; ),
    ( ID: 45; Name: 'CommHSCheckStatus'; ),
    ( ID: 46; Name: 'CommHSWrite'; ),
    ( ID: 47; Name: 'CommHSRead'; )
  );

const
  SysCallMethodIDsCount2x = 100;
  SysCallMethodIDs2x : array[0..SysCallMethodIDsCount2x-1] of IDRec =
  (
    ( ID: 0; Name: 'FileOpenRead'; ),
    ( ID: 1; Name: 'FileOpenWrite'; ),
    ( ID: 2; Name: 'FileOpenAppend'; ),
    ( ID: 3; Name: 'FileRead'; ),
    ( ID: 4; Name: 'FileWrite'; ),
    ( ID: 5; Name: 'FileClose'; ),
    ( ID: 6; Name: 'FileResolveHandle'; ),
    ( ID: 7; Name: 'FileRename'; ),
    ( ID: 8; Name: 'FileDelete'; ),
    ( ID: 9; Name: 'SoundPlayFile'; ),
    ( ID: 10; Name: 'SoundPlayTone'; ),
    ( ID: 11; Name: 'SoundGetState'; ),
    ( ID: 12; Name: 'SoundSetState'; ),
    ( ID: 13; Name: 'DrawText'; ),
    ( ID: 14; Name: 'DrawPoint'; ),
    ( ID: 15; Name: 'DrawLine'; ),
    ( ID: 16; Name: 'DrawCircle'; ),
    ( ID: 17; Name: 'DrawRect'; ),
    ( ID: 18; Name: 'DrawGraphic'; ),
    ( ID: 19; Name: 'SetScreenMode'; ),
    ( ID: 20; Name: 'ReadButton'; ),
    ( ID: 21; Name: 'CommLSWrite'; ),
    ( ID: 22; Name: 'CommLSRead'; ),
    ( ID: 23; Name: 'CommLSCheckStatus'; ),
    ( ID: 24; Name: 'RandomNumber'; ),
    ( ID: 25; Name: 'GetStartTick'; ),
    ( ID: 26; Name: 'MessageWrite'; ),
    ( ID: 27; Name: 'MessageRead'; ),
    ( ID: 28; Name: 'CommBTCheckStatus'; ),
    ( ID: 29; Name: 'CommBTWrite'; ),
    ( ID: 30; Name: 'CommBTRead'; ),
    ( ID: 31; Name: 'KeepAlive'; ),
    ( ID: 32; Name: 'IOMapRead'; ),
    ( ID: 33; Name: 'IOMapWrite'; ),
    ( ID: 34; Name: 'ColorSensorRead'; ),
    ( ID: 35; Name: 'CommBTOnOff'; ),
    ( ID: 36; Name: 'CommBTConnection'; ),
    ( ID: 37; Name: 'CommHSWrite'; ),
    ( ID: 38; Name: 'CommHSRead'; ),
    ( ID: 39; Name: 'CommHSCheckStatus'; ),
    ( ID: 40; Name: 'ReadSemData'; ),
    ( ID: 41; Name: 'WriteSemData'; ),
    ( ID: 42; Name: 'ComputeCalibValue'; ),
    ( ID: 43; Name: 'UpdateCalibCacheInfo'; ),
    ( ID: 44; Name: 'DatalogWrite'; ),
    ( ID: 45; Name: 'DatalogGetTimes'; ),
    ( ID: 46; Name: 'SetSleepTimeoutVal'; ),
    ( ID: 47; Name: 'ListFiles'; ),
    ( ID: 48; Name: 'syscall48'; ),
    ( ID: 49; Name: 'syscall49'; ),
    ( ID: 50; Name: 'syscall50'; ),
    ( ID: 51; Name: 'syscall51'; ),
    ( ID: 52; Name: 'syscall52'; ),
    ( ID: 53; Name: 'syscall53'; ),
    ( ID: 54; Name: 'syscall54'; ),
    ( ID: 55; Name: 'syscall55'; ),
    ( ID: 56; Name: 'syscall56'; ),
    ( ID: 57; Name: 'syscall57'; ),
    ( ID: 58; Name: 'syscall58'; ),
    ( ID: 59; Name: 'syscall59'; ),
    ( ID: 60; Name: 'syscall60'; ),
    ( ID: 61; Name: 'syscall61'; ),
    ( ID: 62; Name: 'syscall62'; ),
    ( ID: 63; Name: 'syscall63'; ),
    ( ID: 64; Name: 'syscall64'; ),
    ( ID: 65; Name: 'syscall65'; ),
    ( ID: 66; Name: 'syscall66'; ),
    ( ID: 67; Name: 'syscall67'; ),
    ( ID: 68; Name: 'syscall68'; ),
    ( ID: 69; Name: 'syscall69'; ),
    ( ID: 70; Name: 'syscall70'; ),
    ( ID: 71; Name: 'syscall71'; ),
    ( ID: 72; Name: 'syscall72'; ),
    ( ID: 73; Name: 'syscall73'; ),
    ( ID: 74; Name: 'syscall74'; ),
    ( ID: 75; Name: 'syscall75'; ),
    ( ID: 76; Name: 'syscall76'; ),
    ( ID: 77; Name: 'syscall77'; ),
    ( ID: 78; Name: 'IOMapReadByID'; ),
    ( ID: 79; Name: 'IOMapWriteByID'; ),
    ( ID: 80; Name: 'DisplayExecuteFunction'; ),
    ( ID: 81; Name: 'CommExecuteFunction'; ),
    ( ID: 82; Name: 'LoaderExecuteFunction'; ),
    ( ID: 83; Name: 'FileFindFirst'; ),
    ( ID: 84; Name: 'FileFindNext'; ),
    ( ID: 85; Name: 'FileOpenWriteLinear'; ),
    ( ID: 86; Name: 'FileOpenWriteNonLinear'; ),
    ( ID: 87; Name: 'FileOpenReadLinear'; ),
    ( ID: 88; Name: 'CommHSControl'; ),
    ( ID: 89; Name: 'CommLSWriteEx'; ),
    ( ID: 90; Name: 'FileSeek'; ),
    ( ID: 91; Name: 'FileResize'; ),
    ( ID: 92; Name: 'DrawGraphicArray'; ),
    ( ID: 93; Name: 'DrawPolygon'; ),
    ( ID: 94; Name: 'DrawEllipse'; ),
    ( ID: 95; Name: 'DrawFont'; ),
    ( ID: 96; Name: 'MemoryManager'; ),
    ( ID: 97; Name: 'ReadLastResponse'; ),
    ( ID: 98; Name: 'FileTell'; ),
    ( ID: 99; Name: 'syscall99'; )
  );

const
  MSCount = 45;
  MSRecords : array[0..MSCount-1] of IDRec =
  (
    ( ID: 1; Name: 'MS_1'; ),
    ( ID: 2; Name: 'MS_2'; ),
    ( ID: 3; Name: 'MS_3'; ),
    ( ID: 4; Name: 'MS_4'; ),
    ( ID: 5; Name: 'MS_5'; ),
    ( ID: 6; Name: 'MS_6'; ),
    ( ID: 7; Name: 'MS_7'; ),
    ( ID: 8; Name: 'MS_8'; ),
    ( ID: 9; Name: 'MS_9'; ),
    ( ID: 10; Name: 'MS_10'; ),
    ( ID: 20; Name: 'MS_20'; ),
    ( ID: 30; Name: 'MS_30'; ),
    ( ID: 40; Name: 'MS_40'; ),
    ( ID: 50; Name: 'MS_50'; ),
    ( ID: 60; Name: 'MS_60'; ),
    ( ID: 70; Name: 'MS_70'; ),
    ( ID: 80; Name: 'MS_80'; ),
    ( ID: 90; Name: 'MS_90'; ),
    ( ID: 100; Name: 'MS_100'; ),
    ( ID: 150; Name: 'MS_150'; ),
    ( ID: 200; Name: 'MS_200'; ),
    ( ID: 250; Name: 'MS_250'; ),
    ( ID: 300; Name: 'MS_300'; ),
    ( ID: 350; Name: 'MS_350'; ),
    ( ID: 400; Name: 'MS_400'; ),
    ( ID: 450; Name: 'MS_450'; ),
    ( ID: 500; Name: 'MS_500'; ),
    ( ID: 600; Name: 'MS_600'; ),
    ( ID: 700; Name: 'MS_700'; ),
    ( ID: 800; Name: 'MS_800'; ),
    ( ID: 900; Name: 'MS_900'; ),
    ( ID: 1000; Name: 'SEC_1'; ),
    ( ID: 2000; Name: 'SEC_2'; ),
    ( ID: 3000; Name: 'SEC_3'; ),
    ( ID: 4000; Name: 'SEC_4'; ),
    ( ID: 5000; Name: 'SEC_5'; ),
    ( ID: 6000; Name: 'SEC_6'; ),
    ( ID: 7000; Name: 'SEC_7'; ),
    ( ID: 8000; Name: 'SEC_8'; ),
    ( ID: 9000; Name: 'SEC_9'; ),
    ( ID: 10000; Name: 'SEC_10'; ),
    ( ID: 15000; Name: 'SEC_15'; ),
    ( ID: 20000; Name: 'SEC_20'; ),
    ( ID: 30000; Name: 'SEC_30'; ),
    ( ID: 60000; Name: 'MIN_1'; )
  );

const
  ToneCount = 60;
  ToneRecords : array[0..ToneCount-1] of IDRec =
  (
    ( ID: 131; Name: 'TONE_C3'; ),
    ( ID: 139; Name: 'TONE_CS3'; ),
    ( ID: 147; Name: 'TONE_D3'; ),
    ( ID: 156; Name: 'TONE_DS3'; ),
    ( ID: 165; Name: 'TONE_E3'; ),
    ( ID: 175; Name: 'TONE_F3'; ),
    ( ID: 185; Name: 'TONE_FS3'; ),
    ( ID: 196; Name: 'TONE_G3'; ),
    ( ID: 208; Name: 'TONE_GS3'; ),
    ( ID: 220; Name: 'TONE_A3'; ),
    ( ID: 233; Name: 'TONE_AS3'; ),
    ( ID: 247; Name: 'TONE_B3'; ),
    ( ID: 262; Name: 'TONE_C4'; ),
    ( ID: 277; Name: 'TONE_CS4'; ),
    ( ID: 294; Name: 'TONE_D4'; ),
    ( ID: 311; Name: 'TONE_DS4'; ),
    ( ID: 330; Name: 'TONE_E4'; ),
    ( ID: 349; Name: 'TONE_F4'; ),
    ( ID: 370; Name: 'TONE_FS4'; ),
    ( ID: 392; Name: 'TONE_G4'; ),
    ( ID: 415; Name: 'TONE_GS4'; ),
    ( ID: 440; Name: 'TONE_A4'; ),
    ( ID: 466; Name: 'TONE_AS4'; ),
    ( ID: 494; Name: 'TONE_B4'; ),
    ( ID: 523; Name: 'TONE_C5'; ),
    ( ID: 554; Name: 'TONE_CS5'; ),
    ( ID: 587; Name: 'TONE_D5'; ),
    ( ID: 622; Name: 'TONE_DS5'; ),
    ( ID: 659; Name: 'TONE_E5'; ),
    ( ID: 698; Name: 'TONE_F5'; ),
    ( ID: 740; Name: 'TONE_FS5'; ),
    ( ID: 784; Name: 'TONE_G5'; ),
    ( ID: 831; Name: 'TONE_GS5'; ),
    ( ID: 880; Name: 'TONE_A5'; ),
    ( ID: 932; Name: 'TONE_AS5'; ),
    ( ID: 988; Name: 'TONE_B5'; ),
    ( ID: 1047; Name: 'TONE_C6'; ),
    ( ID: 1109; Name: 'TONE_CS6'; ),
    ( ID: 1175; Name: 'TONE_D6'; ),
    ( ID: 1245; Name: 'TONE_DS6'; ),
    ( ID: 1319; Name: 'TONE_E6'; ),
    ( ID: 1397; Name: 'TONE_F6'; ),
    ( ID: 1480; Name: 'TONE_FS6'; ),
    ( ID: 1568; Name: 'TONE_G6'; ),
    ( ID: 1661; Name: 'TONE_GS6'; ),
    ( ID: 1760; Name: 'TONE_A6'; ),
    ( ID: 1865; Name: 'TONE_AS6'; ),
    ( ID: 1976; Name: 'TONE_B6'; ),
    ( ID: 2093; Name: 'TONE_C7'; ),
    ( ID: 2217; Name: 'TONE_CS7'; ),
    ( ID: 2349; Name: 'TONE_D7'; ),
    ( ID: 2489; Name: 'TONE_DS7'; ),
    ( ID: 2637; Name: 'TONE_E7'; ),
    ( ID: 2794; Name: 'TONE_F7'; ),
    ( ID: 2960; Name: 'TONE_FS7'; ),
    ( ID: 3136; Name: 'TONE_G7'; ),
    ( ID: 3322; Name: 'TONE_GS7'; ),
    ( ID: 3520; Name: 'TONE_A7'; ),
    ( ID: 3729; Name: 'TONE_AS7'; ),
    ( ID: 3951; Name: 'TONE_B7'; )
  );

(*
const
  IOMapOffsetCount = 244;
  IOMapOffsetRecords : array[0..IOMapOffsetCount-1] of IDRec =
  (
    ( ID: CommandOffsetFormatString; Name: 'CommandOffsetFormatString'; ),
    ( ID: CommandOffsetPRCHandler; Name: 'CommandOffsetPRCHandler'; ),
    ( ID: CommandOffsetTick; Name: 'CommandOffsetTick'; ),
    ( ID: CommandOffsetOffsetDS; Name: 'CommandOffsetOffsetDS'; ),
    ( ID: CommandOffsetOffsetDVA; Name: 'CommandOffsetOffsetDVA'; ),
    ( ID: CommandOffsetProgStatus; Name: 'CommandOffsetProgStatus'; ),
    ( ID: CommandOffsetAwake; Name: 'CommandOffsetAwake'; ),
    ( ID: CommandOffsetActivateFlag; Name: 'CommandOffsetActivateFlag'; ),
    ( ID: CommandOffsetDeactivateFlag; Name: 'CommandOffsetDeactivateFlag'; ),
    ( ID: CommandOffsetFileName; Name: 'CommandOffsetFileName'; ),
    ( ID: CommandOffsetMemoryPool; Name: 'CommandOffsetMemoryPool'; ),
    ( ID: IOCtrlOffsetPowerOn; Name: 'IOCtrlOffsetPowerOn'; ),
    ( ID: LoaderOffsetPFunc; Name: 'LoaderOffsetPFunc'; ),
    ( ID: LoaderOffsetFreeUserFlash; Name: 'LoaderOffsetFreeUserFlash'; ),
    ( ID: SoundOffsetFreq; Name: 'SoundOffsetFreq'; ),
    ( ID: SoundOffsetDuration; Name: 'SoundOffsetDuration'; ),
    ( ID: SoundOffsetSampleRate; Name: 'SoundOffsetSampleRate'; ),
    ( ID: SoundOffsetSoundFilename; Name: 'SoundOffsetSoundFilename'; ),
    ( ID: SoundOffsetFlags; Name: 'SoundOffsetFlags'; ),
    ( ID: SoundOffsetState; Name: 'SoundOffsetState'; ),
    ( ID: SoundOffsetMode; Name: 'SoundOffsetMode'; ),
    ( ID: SoundOffsetVolume; Name: 'SoundOffsetVolume'; ),
    ( ID: ButtonOffsetPressedCnt0; Name: 'ButtonOffsetPressedCnt0'; ),
    ( ID: ButtonOffsetLongPressCnt0; Name: 'ButtonOffsetLongPressCnt0'; ),
    ( ID: ButtonOffsetShortRelCnt0; Name: 'ButtonOffsetShortRelCnt0'; ),
    ( ID: ButtonOffsetLongRelCnt0; Name: 'ButtonOffsetLongRelCnt0'; ),
    ( ID: ButtonOffsetRelCnt0; Name: 'ButtonOffsetRelCnt0'; ),
    ( ID: ButtonOffsetSpareOne0; Name: 'ButtonOffsetSpareOne0'; ),
    ( ID: ButtonOffsetSpareTwo0; Name: 'ButtonOffsetSpareTwo0'; ),
    ( ID: ButtonOffsetSpareThree0; Name: 'ButtonOffsetSpareThree0'; ),
    ( ID: ButtonOffsetPressedCnt1; Name: 'ButtonOffsetPressedCnt1'; ),
    ( ID: ButtonOffsetLongPressCnt1; Name: 'ButtonOffsetLongPressCnt1'; ),
    ( ID: ButtonOffsetShortRelCnt1; Name: 'ButtonOffsetShortRelCnt1'; ),
    ( ID: ButtonOffsetLongRelCnt1; Name: 'ButtonOffsetLongRelCnt1'; ),
    ( ID: ButtonOffsetRelCnt1; Name: 'ButtonOffsetRelCnt1'; ),
    ( ID: ButtonOffsetSpareOne1; Name: 'ButtonOffsetSpareOne1'; ),
    ( ID: ButtonOffsetSpareTwo1; Name: 'ButtonOffsetSpareTwo1'; ),
    ( ID: ButtonOffsetSpareThree1; Name: 'ButtonOffsetSpareThree1'; ),
    ( ID: ButtonOffsetPressedCnt2; Name: 'ButtonOffsetPressedCnt2'; ),
    ( ID: ButtonOffsetLongPressCnt2; Name: 'ButtonOffsetLongPressCnt2'; ),
    ( ID: ButtonOffsetShortRelCnt2; Name: 'ButtonOffsetShortRelCnt2'; ),
    ( ID: ButtonOffsetLongRelCnt2; Name: 'ButtonOffsetLongRelCnt2'; ),
    ( ID: ButtonOffsetRelCnt2; Name: 'ButtonOffsetRelCnt2'; ),
    ( ID: ButtonOffsetSpareOne2; Name: 'ButtonOffsetSpareOne2'; ),
    ( ID: ButtonOffsetSpareTwo2; Name: 'ButtonOffsetSpareTwo2'; ),
    ( ID: ButtonOffsetSpareThree2; Name: 'ButtonOffsetSpareThree2'; ),
    ( ID: ButtonOffsetPressedCnt3; Name: 'ButtonOffsetPressedCnt3'; ),
    ( ID: ButtonOffsetLongPressCnt3; Name: 'ButtonOffsetLongPressCnt3'; ),
    ( ID: ButtonOffsetShortRelCnt3; Name: 'ButtonOffsetShortRelCnt3'; ),
    ( ID: ButtonOffsetLongRelCnt3; Name: 'ButtonOffsetLongRelCnt3'; ),
    ( ID: ButtonOffsetRelCnt3; Name: 'ButtonOffsetRelCnt3'; ),
    ( ID: ButtonOffsetSpareOne3; Name: 'ButtonOffsetSpareOne3'; ),
    ( ID: ButtonOffsetSpareTwo3; Name: 'ButtonOffsetSpareTwo3'; ),
    ( ID: ButtonOffsetSpareThree3; Name: 'ButtonOffsetSpareThree3'; ),
    ( ID: ButtonOffsetState0; Name: 'ButtonOffsetState0'; ),
    ( ID: ButtonOffsetState1; Name: 'ButtonOffsetState1'; ),
    ( ID: ButtonOffsetState2; Name: 'ButtonOffsetState2'; ),
    ( ID: ButtonOffsetState3; Name: 'ButtonOffsetState3'; ),
    ( ID: UIOffsetPMenu; Name: 'UIOffsetPMenu'; ),
    ( ID: UIOffsetBatteryVoltage; Name: 'UIOffsetBatteryVoltage'; ),
    ( ID: UIOffsetLMSfilename; Name: 'UIOffsetLMSfilename'; ),
    ( ID: UIOffsetFlags; Name: 'UIOffsetFlags'; ),
    ( ID: UIOffsetState; Name: 'UIOffsetState'; ),
    ( ID: UIOffsetButton; Name: 'UIOffsetButton'; ),
    ( ID: UIOffsetRunState; Name: 'UIOffsetRunState'; ),
    ( ID: UIOffsetBatteryState; Name: 'UIOffsetBatteryState'; ),
    ( ID: UIOffsetBluetoothState; Name: 'UIOffsetBluetoothState'; ),
    ( ID: UIOffsetUsbState; Name: 'UIOffsetUsbState'; ),
    ( ID: UIOffsetSleepTimeout; Name: 'UIOffsetSleepTimeout'; ),
    ( ID: UIOffsetSleepTimer; Name: 'UIOffsetSleepTimer'; ),
    ( ID: UIOffsetRechargeable; Name: 'UIOffsetRechargeable'; ),
    ( ID: UIOffsetVolume; Name: 'UIOffsetVolume'; ),
    ( ID: UIOffsetError; Name: 'UIOffsetError'; ),
    ( ID: UIOffsetOBPPointer; Name: 'UIOffsetOBPPointer'; ),
    ( ID: UIOffsetForceOff; Name: 'UIOffsetForceOff'; ),
    ( ID: InputOffsetCustomZeroOffset0; Name: 'InputOffsetCustomZeroOffset0'; ),
    ( ID: InputOffsetADRaw0; Name: 'InputOffsetADRaw0'; ),
    ( ID: InputOffsetSensorRaw0; Name: 'InputOffsetSensorRaw0'; ),
    ( ID: InputOffsetSensorValue0; Name: 'InputOffsetSensorValue0'; ),
    ( ID: InputOffsetSensorType0; Name: 'InputOffsetSensorType0'; ),
    ( ID: InputOffsetSensorMode0; Name: 'InputOffsetSensorMode0'; ),
    ( ID: InputOffsetSensorBoolean0; Name: 'InputOffsetSensorBoolean0'; ),
    ( ID: InputOffsetDigiPinsDir0; Name: 'InputOffsetDigiPinsDir0'; ),
    ( ID: InputOffsetDigiPinsIn0; Name: 'InputOffsetDigiPinsIn0'; ),
    ( ID: InputOffsetDigiPinsOut0; Name: 'InputOffsetDigiPinsOut0'; ),
    ( ID: InputOffsetCustomPctFullScale0; Name: 'InputOffsetCustomPctFullScale0'; ),
    ( ID: InputOffsetCustomActiveStatus0; Name: 'InputOffsetCustomActiveStatus0'; ),
    ( ID: InputOffsetInvalidData0; Name: 'InputOffsetInvalidData0'; ),
    ( ID: InputOffsetSpare10; Name: 'InputOffsetSpare10'; ),
    ( ID: InputOffsetSpare20; Name: 'InputOffsetSpare20'; ),
    ( ID: InputOffsetSpare30; Name: 'InputOffsetSpare30'; ),
    ( ID: InputOffsetCustomZeroOffset1; Name: 'InputOffsetCustomZeroOffset1'; ),
    ( ID: InputOffsetADRaw1; Name: 'InputOffsetADRaw1'; ),
    ( ID: InputOffsetSensorRaw1; Name: 'InputOffsetSensorRaw1'; ),
    ( ID: InputOffsetSensorValue1; Name: 'InputOffsetSensorValue1'; ),
    ( ID: InputOffsetSensorType1; Name: 'InputOffsetSensorType1'; ),
    ( ID: InputOffsetSensorMode1; Name: 'InputOffsetSensorMode1'; ),
    ( ID: InputOffsetSensorBoolean1; Name: 'InputOffsetSensorBoolean1'; ),
    ( ID: InputOffsetDigiPinsDir1; Name: 'InputOffsetDigiPinsDir1'; ),
    ( ID: InputOffsetDigiPinsIn1; Name: 'InputOffsetDigiPinsIn1'; ),
    ( ID: InputOffsetDigiPinsOut1; Name: 'InputOffsetDigiPinsOut1'; ),
    ( ID: InputOffsetCustomPctFullScale1; Name: 'InputOffsetCustomPctFullScale1'; ),
    ( ID: InputOffsetCustomActiveStatus1; Name: 'InputOffsetCustomActiveStatus1'; ),
    ( ID: InputOffsetInvalidData1; Name: 'InputOffsetInvalidData1'; ),
    ( ID: InputOffsetSpare11; Name: 'InputOffsetSpare11'; ),
    ( ID: InputOffsetSpare21; Name: 'InputOffsetSpare21'; ),
    ( ID: InputOffsetSpare31; Name: 'InputOffsetSpare31'; ),
    ( ID: InputOffsetCustomZeroOffset2; Name: 'InputOffsetCustomZeroOffset2'; ),
    ( ID: InputOffsetADRaw2; Name: 'InputOffsetADRaw2'; ),
    ( ID: InputOffsetSensorRaw2; Name: 'InputOffsetSensorRaw2'; ),
    ( ID: InputOffsetSensorValue2; Name: 'InputOffsetSensorValue2'; ),
    ( ID: InputOffsetSensorType2; Name: 'InputOffsetSensorType2'; ),
    ( ID: InputOffsetSensorMode2; Name: 'InputOffsetSensorMode2'; ),
    ( ID: InputOffsetSensorBoolean2; Name: 'InputOffsetSensorBoolean2'; ),
    ( ID: InputOffsetDigiPinsDir2; Name: 'InputOffsetDigiPinsDir2'; ),
    ( ID: InputOffsetDigiPinsIn2; Name: 'InputOffsetDigiPinsIn2'; ),
    ( ID: InputOffsetDigiPinsOut2; Name: 'InputOffsetDigiPinsOut2'; ),
    ( ID: InputOffsetCustomPctFullScale2; Name: 'InputOffsetCustomPctFullScale2'; ),
    ( ID: InputOffsetCustomActiveStatus2; Name: 'InputOffsetCustomActiveStatus2'; ),
    ( ID: InputOffsetInvalidData2; Name: 'InputOffsetInvalidData2'; ),
    ( ID: InputOffsetSpare12; Name: 'InputOffsetSpare12'; ),
    ( ID: InputOffsetSpare22; Name: 'InputOffsetSpare22'; ),
    ( ID: InputOffsetSpare32; Name: 'InputOffsetSpare32'; ),
    ( ID: InputOffsetCustomZeroOffset3; Name: 'InputOffsetCustomZeroOffset3'; ),
    ( ID: InputOffsetADRaw3; Name: 'InputOffsetADRaw3'; ),
    ( ID: InputOffsetSensorRaw3; Name: 'InputOffsetSensorRaw3'; ),
    ( ID: InputOffsetSensorValue3; Name: 'InputOffsetSensorValue3'; ),
    ( ID: InputOffsetSensorType3; Name: 'InputOffsetSensorType3'; ),
    ( ID: InputOffsetSensorMode3; Name: 'InputOffsetSensorMode3'; ),
    ( ID: InputOffsetSensorBoolean3; Name: 'InputOffsetSensorBoolean3'; ),
    ( ID: InputOffsetDigiPinsDir3; Name: 'InputOffsetDigiPinsDir3'; ),
    ( ID: InputOffsetDigiPinsIn3; Name: 'InputOffsetDigiPinsIn3'; ),
    ( ID: InputOffsetDigiPinsOut3; Name: 'InputOffsetDigiPinsOut3'; ),
    ( ID: InputOffsetCustomPctFullScale3; Name: 'InputOffsetCustomPctFullScale3'; ),
    ( ID: InputOffsetCustomActiveStatus3; Name: 'InputOffsetCustomActiveStatus3'; ),
    ( ID: InputOffsetInvalidData3; Name: 'InputOffsetInvalidData3'; ),
    ( ID: InputOffsetSpare13; Name: 'InputOffsetSpare13'; ),
    ( ID: InputOffsetSpare23; Name: 'InputOffsetSpare23'; ),
    ( ID: InputOffsetSpare33; Name: 'InputOffsetSpare33'; ),
    ( ID: OutputOffsetTachoCnt0; Name: 'OutputOffsetTachoCnt0'; ),
    ( ID: OutputOffsetBlockTachoCount0; Name: 'OutputOffsetBlockTachoCount0'; ),
    ( ID: OutputOffsetRotationCount0; Name: 'OutputOffsetRotationCount0'; ),
    ( ID: OutputOffsetTachoLimit0; Name: 'OutputOffsetTachoLimit0'; ),
    ( ID: OutputOffsetMotorRPM0; Name: 'OutputOffsetMotorRPM0'; ),
    ( ID: OutputOffsetFlags0; Name: 'OutputOffsetFlags0'; ),
    ( ID: OutputOffsetMode0; Name: 'OutputOffsetMode0'; ),
    ( ID: OutputOffsetSpeed0; Name: 'OutputOffsetSpeed0'; ),
    ( ID: OutputOffsetActualSpeed0; Name: 'OutputOffsetActualSpeed0'; ),
    ( ID: OutputOffsetRegPParameter0; Name: 'OutputOffsetRegPParameter0'; ),
    ( ID: OutputOffsetRegIParameter0; Name: 'OutputOffsetRegIParameter0'; ),
    ( ID: OutputOffsetRegDParameter0; Name: 'OutputOffsetRegDParameter0'; ),
    ( ID: OutputOffsetRunState0; Name: 'OutputOffsetRunState0'; ),
    ( ID: OutputOffsetRegMode0; Name: 'OutputOffsetRegMode0'; ),
    ( ID: OutputOffsetOverloaded0; Name: 'OutputOffsetOverloaded0'; ),
    ( ID: OutputOffsetSyncTurnParameter0; Name: 'OutputOffsetSyncTurnParameter0'; ),
    ( ID: OutputOffsetSpareOne0; Name: 'OutputOffsetSpareOne0'; ),
    ( ID: OutputOffsetSpareTwo0; Name: 'OutputOffsetSpareTwo0'; ),
    ( ID: OutputOffsetSpareThree0; Name: 'OutputOffsetSpareThree0'; ),
    ( ID: OutputOffsetTachoCnt1; Name: 'OutputOffsetTachoCnt1'; ),
    ( ID: OutputOffsetBlockTachoCount1; Name: 'OutputOffsetBlockTachoCount1'; ),
    ( ID: OutputOffsetRotationCount1; Name: 'OutputOffsetRotationCount1'; ),
    ( ID: OutputOffsetTachoLimit1; Name: 'OutputOffsetTachoLimit1'; ),
    ( ID: OutputOffsetMotorRPM1; Name: 'OutputOffsetMotorRPM1'; ),
    ( ID: OutputOffsetFlags1; Name: 'OutputOffsetFlags1'; ),
    ( ID: OutputOffsetMode1; Name: 'OutputOffsetMode1'; ),
    ( ID: OutputOffsetSpeed1; Name: 'OutputOffsetSpeed1'; ),
    ( ID: OutputOffsetActualSpeed1; Name: 'OutputOffsetActualSpeed1'; ),
    ( ID: OutputOffsetRegPParameter1; Name: 'OutputOffsetRegPParameter1'; ),
    ( ID: OutputOffsetRegIParameter1; Name: 'OutputOffsetRegIParameter1'; ),
    ( ID: OutputOffsetRegDParameter1; Name: 'OutputOffsetRegDParameter1'; ),
    ( ID: OutputOffsetRunState1; Name: 'OutputOffsetRunState1'; ),
    ( ID: OutputOffsetRegMode1; Name: 'OutputOffsetRegMode1'; ),
    ( ID: OutputOffsetOverloaded1; Name: 'OutputOffsetOverloaded1'; ),
    ( ID: OutputOffsetSyncTurnParameter1; Name: 'OutputOffsetSyncTurnParameter1'; ),
    ( ID: OutputOffsetSpareOne1; Name: 'OutputOffsetSpareOne1'; ),
    ( ID: OutputOffsetSpareTwo1; Name: 'OutputOffsetSpareTwo1'; ),
    ( ID: OutputOffsetSpareThree1; Name: 'OutputOffsetSpareThree1'; ),
    ( ID: OutputOffsetTachoCnt2; Name: 'OutputOffsetTachoCnt2'; ),
    ( ID: OutputOffsetBlockTachoCount2; Name: 'OutputOffsetBlockTachoCount2'; ),
    ( ID: OutputOffsetRotationCount2; Name: 'OutputOffsetRotationCount2'; ),
    ( ID: OutputOffsetTachoLimit2; Name: 'OutputOffsetTachoLimit2'; ),
    ( ID: OutputOffsetMotorRPM2; Name: 'OutputOffsetMotorRPM2'; ),
    ( ID: OutputOffsetFlags2; Name: 'OutputOffsetFlags2'; ),
    ( ID: OutputOffsetMode2; Name: 'OutputOffsetMode2'; ),
    ( ID: OutputOffsetSpeed2; Name: 'OutputOffsetSpeed2'; ),
    ( ID: OutputOffsetActualSpeed2; Name: 'OutputOffsetActualSpeed2'; ),
    ( ID: OutputOffsetRegPParameter2; Name: 'OutputOffsetRegPParameter2'; ),
    ( ID: OutputOffsetRegIParameter2; Name: 'OutputOffsetRegIParameter2'; ),
    ( ID: OutputOffsetRegDParameter2; Name: 'OutputOffsetRegDParameter2'; ),
    ( ID: OutputOffsetRunState2; Name: 'OutputOffsetRunState2'; ),
    ( ID: OutputOffsetRegMode2; Name: 'OutputOffsetRegMode2'; ),
    ( ID: OutputOffsetOverloaded2; Name: 'OutputOffsetOverloaded2'; ),
    ( ID: OutputOffsetSyncTurnParameter2; Name: 'OutputOffsetSyncTurnParameter2'; ),
    ( ID: OutputOffsetSpareOne2; Name: 'OutputOffsetSpareOne2'; ),
    ( ID: OutputOffsetSpareTwo2; Name: 'OutputOffsetSpareTwo2'; ),
    ( ID: OutputOffsetSpareThree2; Name: 'OutputOffsetSpareThree2'; ),
    ( ID: OutputOffsetPwnFreq; Name: 'OutputOffsetPwnFreq'; ),
    ( ID: LowSpeedOffsetInBufBuf0; Name: 'LowSpeedOffsetInBufBuf0'; ),
    ( ID: LowSpeedOffsetInBufInPtr0; Name: 'LowSpeedOffsetInBufInPtr0'; ),
    ( ID: LowSpeedOffsetInBufOutPtr0; Name: 'LowSpeedOffsetInBufOutPtr0'; ),
    ( ID: LowSpeedOffsetInBufBytesToRx0; Name: 'LowSpeedOffsetInBufBytesToRx0'; ),
    ( ID: LowSpeedOffsetInBufBuf1; Name: 'LowSpeedOffsetInBufBuf1'; ),
    ( ID: LowSpeedOffsetInBufInPtr1; Name: 'LowSpeedOffsetInBufInPtr1'; ),
    ( ID: LowSpeedOffsetInBufOutPtr1; Name: 'LowSpeedOffsetInBufOutPtr1'; ),
    ( ID: LowSpeedOffsetInBufBytesToRx1; Name: 'LowSpeedOffsetInBufBytesToRx1'; ),
    ( ID: LowSpeedOffsetInBufBuf2; Name: 'LowSpeedOffsetInBufBuf2'; ),
    ( ID: LowSpeedOffsetInBufInPtr2; Name: 'LowSpeedOffsetInBufInPtr2'; ),
    ( ID: LowSpeedOffsetInBufOutPtr2; Name: 'LowSpeedOffsetInBufOutPtr2'; ),
    ( ID: LowSpeedOffsetInBufBytesToRx2; Name: 'LowSpeedOffsetInBufBytesToRx2'; ),
    ( ID: LowSpeedOffsetInBufBuf3; Name: 'LowSpeedOffsetInBufBuf3'; ),
    ( ID: LowSpeedOffsetInBufInPtr3; Name: 'LowSpeedOffsetInBufInPtr3'; ),
    ( ID: LowSpeedOffsetInBufOutPtr3; Name: 'LowSpeedOffsetInBufOutPtr3'; ),
    ( ID: LowSpeedOffsetInBufBytesToRx3; Name: 'LowSpeedOffsetInBufBytesToRx3'; ),
    ( ID: LowSpeedOffsetOutBufBuf0; Name: 'LowSpeedOffsetOutBufBuf0'; ),
    ( ID: LowSpeedOffsetOutBufInPtr0; Name: 'LowSpeedOffsetOutBufInPtr0'; ),
    ( ID: LowSpeedOffsetOutBufOutPtr0; Name: 'LowSpeedOffsetOutBufOutPtr0'; ),
    ( ID: LowSpeedOffsetOutBufBytesToRx0; Name: 'LowSpeedOffsetOutBufBytesToRx0'; ),
    ( ID: LowSpeedOffsetOutBufBuf1; Name: 'LowSpeedOffsetOutBufBuf1'; ),
    ( ID: LowSpeedOffsetOutBufInPtr1; Name: 'LowSpeedOffsetOutBufInPtr1'; ),
    ( ID: LowSpeedOffsetOutBufOutPtr1; Name: 'LowSpeedOffsetOutBufOutPtr1'; ),
    ( ID: LowSpeedOffsetOutBufBytesToRx1; Name: 'LowSpeedOffsetOutBufBytesToRx1'; ),
    ( ID: LowSpeedOffsetOutBufBuf2; Name: 'LowSpeedOffsetOutBufBuf2'; ),
    ( ID: LowSpeedOffsetOutBufInPtr2; Name: 'LowSpeedOffsetOutBufInPtr2'; ),
    ( ID: LowSpeedOffsetOutBufOutPtr2; Name: 'LowSpeedOffsetOutBufOutPtr2'; ),
    ( ID: LowSpeedOffsetOutBufBytesToRx2; Name: 'LowSpeedOffsetOutBufBytesToRx2'; ),
    ( ID: LowSpeedOffsetOutBufBuf3; Name: 'LowSpeedOffsetOutBufBuf3'; ),
    ( ID: LowSpeedOffsetOutBufInPtr3; Name: 'LowSpeedOffsetOutBufInPtr3'; ),
    ( ID: LowSpeedOffsetOutBufOutPtr3; Name: 'LowSpeedOffsetOutBufOutPtr3'; ),
    ( ID: LowSpeedOffsetOutBufBytesToRx3; Name: 'LowSpeedOffsetOutBufBytesToRx3'; ),
    ( ID: LowSpeedOffsetMode0; Name: 'LowSpeedOffsetMode0'; ),
    ( ID: LowSpeedOffsetMode1; Name: 'LowSpeedOffsetMode1'; ),
    ( ID: LowSpeedOffsetMode2; Name: 'LowSpeedOffsetMode2'; ),
    ( ID: LowSpeedOffsetMode3; Name: 'LowSpeedOffsetMode3'; ),
    ( ID: LowSpeedOffsetChannelState0; Name: 'LowSpeedOffsetChannelState0'; ),
    ( ID: LowSpeedOffsetChannelState1; Name: 'LowSpeedOffsetChannelState1'; ),
    ( ID: LowSpeedOffsetChannelState2; Name: 'LowSpeedOffsetChannelState2'; ),
    ( ID: LowSpeedOffsetChannelState3; Name: 'LowSpeedOffsetChannelState3'; ),
    ( ID: LowSpeedOffsetErrorType0; Name: 'LowSpeedOffsetErrorType0'; ),
    ( ID: LowSpeedOffsetErrorType1; Name: 'LowSpeedOffsetErrorType1'; ),
    ( ID: LowSpeedOffsetErrorType2; Name: 'LowSpeedOffsetErrorType2'; ),
    ( ID: LowSpeedOffsetErrorType3; Name: 'LowSpeedOffsetErrorType3'; ),
    ( ID: LowSpeedOffsetState; Name: 'LowSpeedOffsetState'; ),
    ( ID: LowSpeedOffsetSpeed; Name: 'LowSpeedOffsetSpeed'; ),
    ( ID: LowSpeedOffsetSpare1; Name: 'LowSpeedOffsetSpare1'; )
  );
*)

// miscellaneous IOMap-related constants
const
  INPUT_DIGI0 = $1;
  INPUT_DIGI1 = $2;
  INPUT_CUSTOMINACTIVE = $00;
  INPUT_CUSTOM9V       = $01;
  INPUT_CUSTOMACTIVE   = $02;
  INPUT_INVALID_DATA   = $01;
  BTN1       = $0;
  BTN2       = $1;
  BTN3       = $2;
  BTN4       = $3;
  NO_OF_BTNS = $4;
  BTNSTATE_PRESSED_EV          = $01;
  BTNSTATE_SHORT_RELEASED_EV   = $02;
  BTNSTATE_LONG_PRESSED_EV     = $04;
  BTNSTATE_LONG_RELEASED_EV    = $08;
  BTNSTATE_PRESSED_STATE       = $80;
  SOUND_FLAGS_UPDATE           = $01;
  SOUND_FLAGS_RUNNING          = $02;
  SOUND_STATE_IDLE             = $00;
  SOUND_STATE_BUSY             = $02;
  SOUND_STATE_FREQ             = $03;
  SOUND_STATE_STOP             = $04;
  SOUND_MODE_ONCE              = $00;
  SOUND_MODE_LOOP              = $01;
  SOUND_MODE_TONE              = $02;
  UI_FLAGS_UPDATE                   = $01;
  UI_FLAGS_DISABLE_LEFT_RIGHT_ENTER = $02;
  UI_FLAGS_DISABLE_EXIT             = $04;
  UI_FLAGS_REDRAW_STATUS            = $08;
  UI_FLAGS_RESET_SLEEP_TIMER        = $10;
  UI_FLAGS_EXECUTE_LMS_FILE         = $20;
  UI_FLAGS_BUSY                     = $40;
  UI_FLAGS_ENABLE_STATUS_UPDATE     = $80;
  UI_STATE_INIT_DISPLAY        = $0;
  UI_STATE_INIT_LOW_BATTERY    = $1;
  UI_STATE_INIT_INTRO          = $2;
  UI_STATE_INIT_WAIT           = $3;
  UI_STATE_INIT_MENU           = $4;
  UI_STATE_NEXT_MENU           = $5;
  UI_STATE_DRAW_MENU           = $6;
  UI_STATE_TEST_BUTTONS        = $7;
  UI_STATE_LEFT_PRESSED        = $8;
  UI_STATE_RIGHT_PRESSED       = $9;
  UI_STATE_ENTER_PRESSED       = $0a;
  UI_STATE_EXIT_PRESSED        = $0b;
  UI_STATE_CONNECT_REQUEST     = $0c;
  UI_STATE_EXECUTE_FILE        = $0d;
  UI_STATE_EXECUTING_FILE      = $0e;
  UI_STATE_LOW_BATTERY         = $0f;
  UI_STATE_BT_ERROR            = $10;
  UI_BUTTON_NONE               = $1;
  UI_BUTTON_LEFT               = $2;
  UI_BUTTON_ENTER              = $3;
  UI_BUTTON_RIGHT              = $4;
  UI_BUTTON_EXIT               = $5;
  UI_BT_STATE_VISIBLE          = $01;
  UI_BT_STATE_CONNECTED        = $02;
  UI_BT_STATE_OFF              = $04;
  UI_BT_ERROR_ATTENTION        = $08;
  UI_BT_CONNECT_REQUEST        = $40;
  UI_BT_PIN_REQUEST            = $80;
  LS_DEVTYPE_ULTRA_SONIC       = $2;
  LS_DEVTYPE_CUSTOM_LS_DEVICE  = $3;
  COM_CHANNEL_NONE_ACTIVE      = $00;
  COM_CHANNEL_ONE_ACTIVE       = $01;
  COM_CHANNEL_TWO_ACTIVE       = $02;
  COM_CHANNEL_THREE_ACTIVE     = $04;
  COM_CHANNEL_FOUR_ACTIVE      = $08;
  LOWSPEED_IDLE                = $0;
  LOWSPEED_INIT                = $1;
  LOWSPEED_LOAD_BUFFER         = $2;
  LOWSPEED_COMMUNICATING       = $3;
  LOWSPEED_ERROR               = $4;
  LOWSPEED_DONE                = $5;
  LOWSPEED_TRANSMITTING        = $1;
  LOWSPEED_RECEIVING           = $2;
  LOWSPEED_DATA_RECEIVED       = $3;
  LOWSPEED_NO_ERROR            = $0;
  LOWSPEED_CH_NOT_READY        = $1;
  LOWSPEED_TX_ERROR            = $2;
  LOWSPEED_RX_ERROR            = $3;

(*
  IOMapMiscCount = 81;
  IOMapMiscRecords : array[0..IOMapMiscCount-1] of IDRec =
  (
    ( ID: INPUT_DIGI0; Name: 'INPUT_DIGI0'; ),
    ( ID: INPUT_DIGI1; Name: 'INPUT_DIGI1'; ),
    ( ID: INPUT_CUSTOMINACTIVE; Name: 'INPUT_CUSTOMINACTIVE'; ),
    ( ID: INPUT_CUSTOM9V; Name: 'INPUT_CUSTOM9V'; ),
    ( ID: INPUT_CUSTOMACTIVE; Name: 'INPUT_CUSTOMACTIVE'; ),
    ( ID: INPUT_INVALID_DATA; Name: 'INPUT_INVALID_DATA'; ),
    ( ID: BTN1 ; Name: 'BTN1'; ),
    ( ID: BTN2 ; Name: 'BTN2'; ),
    ( ID: BTN3 ; Name: 'BTN3'; ),
    ( ID: BTN4 ; Name: 'BTN4'; ),
    ( ID: NO_OF_BTNS ; Name: 'NO_OF_BTNS'; ),
    ( ID: BTNSTATE_PRESSED_EV         ; Name: 'BTNSTATE_PRESSED_EV'; ),
    ( ID: BTNSTATE_SHORT_RELEASED_EV  ; Name: 'BTNSTATE_SHORT_RELEASED_EV'; ),
    ( ID: BTNSTATE_LONG_PRESSED_EV    ; Name: 'BTNSTATE_LONG_PRESSED_EV'; ),
    ( ID: BTNSTATE_LONG_RELEASED_EV   ; Name: 'BTNSTATE_LONG_RELEASED_EV'; ),
    ( ID: BTNSTATE_PRESSED_STATE      ; Name: 'BTNSTATE_PRESSED_STATE'; ),
    ( ID: SOUND_FLAGS_UPDATE  ; Name: 'SOUND_FLAGS_UPDATE'; ),
    ( ID: SOUND_FLAGS_RUNNING ; Name: 'SOUND_FLAGS_RUNNING'; ),
    ( ID: SOUND_STATE_IDLE ; Name: 'SOUND_STATE_IDLE'; ),
    ( ID: SOUND_STATE_BUSY ; Name: 'SOUND_STATE_BUSY'; ),
    ( ID: SOUND_STATE_FREQ ; Name: 'SOUND_STATE_FREQ'; ),
    ( ID: SOUND_STATE_STOP ; Name: 'SOUND_STATE_STOP'; ),
    ( ID: SOUND_MODE_ONCE ; Name: 'SOUND_MODE_ONCE'; ),
    ( ID: SOUND_MODE_LOOP ; Name: 'SOUND_MODE_LOOP'; ),
    ( ID: SOUND_MODE_TONE ; Name: 'SOUND_MODE_TONE'; ),
    ( ID: UI_FLAGS_UPDATE                   ; Name: 'UI_FLAGS_UPDATE'; ),
    ( ID: UI_FLAGS_DISABLE_LEFT_RIGHT_ENTER ; Name: 'UI_FLAGS_DISABLE_LEFT_RIGHT_ENTER'; ),
    ( ID: UI_FLAGS_DISABLE_EXIT             ; Name: 'UI_FLAGS_DISABLE_EXIT'; ),
    ( ID: UI_FLAGS_REDRAW_STATUS            ; Name: 'UI_FLAGS_REDRAW_STATUS'; ),
    ( ID: UI_FLAGS_RESET_SLEEP_TIMER        ; Name: 'UI_FLAGS_RESET_SLEEP_TIMER'; ),
    ( ID: UI_FLAGS_EXECUTE_LMS_FILE         ; Name: 'UI_FLAGS_EXECUTE_LMS_FILE'; ),
    ( ID: UI_FLAGS_BUSY                     ; Name: 'UI_FLAGS_BUSY'; ),
    ( ID: UI_FLAGS_ENABLE_STATUS_UPDATE     ; Name: 'UI_FLAGS_ENABLE_STATUS_UPDATE'; ),
    ( ID: UI_STATE_INIT_DISPLAY       ; Name: 'UI_STATE_INIT_DISPLAY'; ),
    ( ID: UI_STATE_INIT_LOW_BATTERY   ; Name: 'UI_STATE_INIT_LOW_BATTERY'; ),
    ( ID: UI_STATE_INIT_INTRO         ; Name: 'UI_STATE_INIT_INTRO'; ),
    ( ID: UI_STATE_INIT_WAIT          ; Name: 'UI_STATE_INIT_WAIT'; ),
    ( ID: UI_STATE_INIT_MENU          ; Name: 'UI_STATE_INIT_MENU'; ),
    ( ID: UI_STATE_NEXT_MENU          ; Name: 'UI_STATE_NEXT_MENU'; ),
    ( ID: UI_STATE_DRAW_MENU          ; Name: 'UI_STATE_DRAW_MENU'; ),
    ( ID: UI_STATE_TEST_BUTTONS       ; Name: 'UI_STATE_TEST_BUTTONS'; ),
    ( ID: UI_STATE_LEFT_PRESSED       ; Name: 'UI_STATE_LEFT_PRESSED'; ),
    ( ID: UI_STATE_RIGHT_PRESSED      ; Name: 'UI_STATE_RIGHT_PRESSED'; ),
    ( ID: UI_STATE_ENTER_PRESSED     ; Name: 'UI_STATE_ENTER_PRESSED'; ),
    ( ID: UI_STATE_EXIT_PRESSED      ; Name: 'UI_STATE_EXIT_PRESSED'; ),
    ( ID: UI_STATE_CONNECT_REQUEST   ; Name: 'UI_STATE_CONNECT_REQUEST'; ),
    ( ID: UI_STATE_EXECUTE_FILE      ; Name: 'UI_STATE_EXECUTE_FILE'; ),
    ( ID: UI_STATE_EXECUTING_FILE    ; Name: 'UI_STATE_EXECUTING_FILE'; ),
    ( ID: UI_STATE_LOW_BATTERY       ; Name: 'UI_STATE_LOW_BATTERY'; ),
    ( ID: UI_STATE_BT_ERROR          ; Name: 'UI_STATE_BT_ERROR'; ),
    ( ID: UI_BUTTON_NONE             ; Name: 'UI_BUTTON_NONE'; ),
    ( ID: UI_BUTTON_LEFT             ; Name: 'UI_BUTTON_LEFT'; ),
    ( ID: UI_BUTTON_ENTER            ; Name: 'UI_BUTTON_ENTER'; ),
    ( ID: UI_BUTTON_RIGHT            ; Name: 'UI_BUTTON_RIGHT'; ),
    ( ID: UI_BUTTON_EXIT             ; Name: 'UI_BUTTON_EXIT'; ),
    ( ID: UI_BT_STATE_VISIBLE        ; Name: 'UI_BT_STATE_VISIBLE'; ),
    ( ID: UI_BT_STATE_CONNECTED      ; Name: 'UI_BT_STATE_CONNECTED'; ),
    ( ID: UI_BT_STATE_OFF            ; Name: 'UI_BT_STATE_OFF'; ),
    ( ID: UI_BT_ERROR_ATTENTION      ; Name: 'UI_BT_ERROR_ATTENTION'; ),
    ( ID: UI_BT_CONNECT_REQUEST      ; Name: 'UI_BT_CONNECT_REQUEST'; ),
    ( ID: UI_BT_PIN_REQUEST          ; Name: 'UI_BT_PIN_REQUEST'; ),
    ( ID: LS_DEVTYPE_ULTRA_SONIC       ; Name: 'LS_DEVTYPE_ULTRA_SONIC'; ),
    ( ID: LS_DEVTYPE_CUSTOM_LS_DEVICE  ; Name: 'LS_DEVTYPE_CUSTOM_LS_DEVICE'; ),
    ( ID: COM_CHANNEL_NONE_ACTIVE  ; Name: 'COM_CHANNEL_NONE_ACTIVE'; ),
    ( ID: COM_CHANNEL_ONE_ACTIVE   ; Name: 'COM_CHANNEL_ONE_ACTIVE'; ),
    ( ID: COM_CHANNEL_TWO_ACTIVE   ; Name: 'COM_CHANNEL_TWO_ACTIVE'; ),
    ( ID: COM_CHANNEL_THREE_ACTIVE ; Name: 'COM_CHANNEL_THREE_ACTIVE'; ),
    ( ID: COM_CHANNEL_FOUR_ACTIVE  ; Name: 'COM_CHANNEL_FOUR_ACTIVE'; ),
    ( ID: LOWSPEED_IDLE          ; Name: 'LOWSPEED_IDLE'; ),
    ( ID: LOWSPEED_INIT          ; Name: 'LOWSPEED_INIT'; ),
    ( ID: LOWSPEED_LOAD_BUFFER   ; Name: 'LOWSPEED_LOAD_BUFFER'; ),
    ( ID: LOWSPEED_COMMUNICATING ; Name: 'LOWSPEED_COMMUNICATING'; ),
    ( ID: LOWSPEED_ERROR         ; Name: 'LOWSPEED_ERROR'; ),
    ( ID: LOWSPEED_DONE          ; Name: 'LOWSPEED_DONE'; ),
    ( ID: LOWSPEED_TRANSMITTING   ; Name: 'LOWSPEED_TRANSMITTING'; ),
    ( ID: LOWSPEED_RECEIVING      ; Name: 'LOWSPEED_RECEIVING'; ),
    ( ID: LOWSPEED_DATA_RECEIVED  ; Name: 'LOWSPEED_DATA_RECEIVED'; ),
    ( ID: LOWSPEED_NO_ERROR     ; Name: 'LOWSPEED_NO_ERROR'; ),
    ( ID: LOWSPEED_CH_NOT_READY ; Name: 'LOWSPEED_CH_NOT_READY'; ),
    ( ID: LOWSPEED_TX_ERROR     ; Name: 'LOWSPEED_TX_ERROR'; ),
    ( ID: LOWSPEED_RX_ERROR     ; Name: 'LOWSPEED_RX_ERROR'; )
  );
*)

function IsAlpha(c: char): boolean;
function IsCharWhiteSpace(C: Char): Boolean;
function StrContains(const SubStr, Str: string): Boolean;
function InlineName(const tname, name: string): string;
function StripInline(const name: string): string;
function InlineThreadName(const name: string): string;
function IsInlined(const name: string) : boolean;
function StripAllInlineDecoration(const name: string): string;
function StripDecoration(const name : string) : string;
function PrettyNameStrip(const name : string) : string;
function ApplyDecoration(const pre, val: string; const level : integer): string;
function Replace(const str : string; const src, rep : string) : string;
function NBCStrToFloat(const AValue: string): Double;
function NBCStrToFloatDef(const AValue: string; const aDef : Double): Double;
function NBCTextToFloat(Buffer: PChar; var Value; ValueType: TFloatValue): Boolean;
function NBCFormat(const FmtStr: string; const theArgs: array of const) : string;
function NBCFloatToStr(const AValue: Double): string;
function StripQuotes(const str : string) : string;
function JCHExtractStrings(Separators, WhiteSpace: TSysCharSet; Content: PChar;
  Strings: TStrings): Integer;
function ValueToDataType(const value : integer) : char;
function DataTypeToTypeName(const dt : char) : string;
function BoolToString(aValue : boolean) : string;

const
  TOK_SEMICOLON     = ';';
  TOK_OPENPAREN     = '(';
  TOK_CLOSEPAREN    = ')';
  TOK_COMMA         = ',';
  TOK_IDENTIFIER		= 'x';
  TOK_IF			      = 'i';
  TOK_ELSE		      = 'l';
  TOK_DO            = 'd';
  TOK_ASM           = 'a';
  TOK_REPEAT        = 'r';
  TOK_SWITCH        = 's';
  TOK_DEFAULT       = 'D';
  TOK_CASE          = 'c';
  TOK_WHILE		      = 'w';
  TOK_FOR			      = 'f';
  TOK_ENUM          = 'm';
  TOK_END			      = '}';
  TOK_APISTRFUNC    = 'E';
  TOK_APIFUNC       = 'F';
  TOK_PROCEDURE		  = 'R';
  TOK_TASK          = 'K';
  TOK_BEGIN		      = '{';
  TOK_DIRECTIVE		  = '#';
  TOK_API           = 'Z';
  TOK_LABEL         = 'B';
  TOK_TYPEDEF       = 't';
  TOK_STRUCT        = 'T';
  TOK_CONST         = 'k';
  TOK_INLINE        = 'n';
  TOK_START         = 'A';
  TOK_STOP          = 'X';
  TOK_PRIORITY      = 'p';
  TOK_NUM			      = 'N';
  TOK_HEX			      = 'H';
  TOK_UNSIGNED		  = 'U';
  TOK_CHARDEF		    = 'C';
  TOK_SHORTDEF 	    = 'I';
  TOK_LONGDEF       = 'L';
  TOK_BYTEDEF       = 'b';
  TOK_USHORTDEF     = #06;
  TOK_ULONGDEF      = #05;
  TOK_MUTEXDEF      = 'M';
  TOK_FLOATDEF      = 'O';
  TOK_STRINGDEF     = 'S';
  TOK_STRINGLIT     = 'G';
  TOK_SAFECALL        = #218;
  TOK_USERDEFINEDTYPE = #219;
  TOK_ARRAYFLOAT      = #220;
  TOK_ARRAYFLOAT4     = #223;
  TOK_ARRAYSTRING     = #224;
  TOK_ARRAYSTRING4    = #227;
  TOK_ARRAYUDT        = #228;
  TOK_ARRAYUDT4       = #231;
  TOK_ARRAYCHARDEF    = #232;
  TOK_ARRAYCHARDEF4   = #235;
  TOK_ARRAYSHORTDEF   = #236;
  TOK_ARRAYSHORTDEF4  = #239;
  TOK_ARRAYLONGDEF    = #240;
  TOK_ARRAYLONGDEF4   = #243;
  TOK_ARRAYBYTEDEF    = #244;
  TOK_ARRAYBYTEDEF4   = #247;
  TOK_ARRAYUSHORTDEF  = #248;
  TOK_ARRAYUSHORTDEF4 = #251;
  TOK_ARRAYULONGDEF   = #252;
  TOK_ARRAYULONGDEF4  = #255;
  TOK_BLOCK_COMMENT   = #01;
  TOK_LINE_COMMENT    = #02;

const
  REGVARS_ARRAY : array[0..11] of string = (
    '__tmpsbyte%s',
    '__tmpsword%s',
    '__tmpslong%s',
    '__tmplong%s',
    '__D0%s',
    '__DU0%s',
    '__zf%s',
    '__strtmpbuf%s',
    '__strbuf%s',
    '__strretval%s',
    '__tmpfloat%s',
    '__DF0%s'
  );
  REGVARTYPES_ARRAY : array[0..11] of string = (
    'sbyte',
    'sword',
    'slong',
    'long',
    'slong',
    'long',
    'byte',
    'byte[]',
    'byte[]',
    'byte[]',
    'float',
    'float'
  );

const
  DECOR_SEP = '_7qG2_';


var
  MaxStackDepth : integer;

implementation


uses
{$IFDEF FAST_MM}
  FastStrings,
{$ENDIF}
  strutils,
  uCommonUtils;


function IsAlpha(c: char): boolean;
begin
  Result := c in ['A'..'Z', 'a'..'z', '_'];
end;

function IsCharWhiteSpace(C: Char): Boolean;
begin
  Result := C in [#9, #10, #11, #12, #13, #32];
end;

function StrContains(const SubStr, Str: string): Boolean;
begin
  Result := Pos(SubStr, Str) > 0;
end;

const
  INLINE_DECOR_SEP = '_inline_'{ + DECOR_SEP};
//  INLINE_DECORATION = '__%s_inline_%s';
  INLINE_DECORATION = '%1:s' + INLINE_DECOR_SEP + '%0:s';

function InlineName(const tname, name: string): string;
begin
  Result := Format(INLINE_DECORATION, [tname, name]);
//  Result := name;
end;

function RPos(Substr: string ; S: string ): Integer;
begin
  Result := Pos(ReverseString(Substr), ReverseString(S));
  if Result <> 0 then
    Result := Length(S) - (Result - 1) - (Length(Substr) - 1);
end;

function StripInline(const name: string): string;
var
  i : integer;
begin
  Result := name;
  i := RPos(INLINE_DECOR_SEP, Result);
  if i > 0 then
    Result := Copy(Result, 1, i-1);
end;

function InlineThreadName(const name: string): string;
var
  i : integer;
begin
  Result := name;
  i := RPos(INLINE_DECOR_SEP, Result);
  if i > 0 then
    Result := Copy(Result, i+Length(INLINE_DECOR_SEP), MaxInt);
end;

function IsInlined(const name: string) : boolean;
begin
  Result := Pos(INLINE_DECOR_SEP, name) > 0;
end;

function StripAllInlineDecoration(const name: string): string;
var
  i : integer;
begin
  Result := name;
  i := Pos(INLINE_DECOR_SEP, Result);
  if i > 0 then
    Result := Copy(Result, 1, i-1);
end;

function StripDecoration(const name : string) : string;
var
  i : integer;
  varName : string;
begin
  Result := StripInline(name);
  // a decorated name has this pattern:
  // __threadnameDECOR_SEPvariablenameDECOR_SEPNNNetc
  i := Pos(DECOR_SEP, Result);
  if i > 0 then
  begin
    System.Delete(Result, 1, i+Length(DECOR_SEP)-1);
    i := Pos(DECOR_SEP, Result);
    if i > 0 then
    begin
      varName := Copy(Result, 1, i-1);
      System.Delete(Result, 1, i+Length(DECOR_SEP)+2);
      Result := varName + Result;
    end;
  end;
end;

function PrettyNameStrip(const name : string) : string;
var
  i : integer;
begin
  Result := name;
  // a decorated name has this pattern:
  // __threadnameDECOR_SEPvariablenameDECOR_SEPNNNetc
  i := Pos(DECOR_SEP, Result);
  if i > 0 then
  begin
    System.Delete(Result, 1, 2); // drop the underscores
    Result := Replace(Result, DECOR_SEP, '.');
  end;
end;

function ApplyDecoration(const pre, val: string; const level : integer): string;
var
  p : integer;
  first, last : string;
begin
  // if val contains dots then separate it into two pieces
  p := Pos('.', val);
  if p > 0 then
  begin
    first := Copy(val, 1, p-1);
    last  := Copy(val, p, MaxInt);
    Result := Format('__%s%s%s%s%3.3d%s', [pre, DECOR_SEP, first, DECOR_SEP, level, last]);
//    Result := Format('__%s_%s_%3.3d%s', [pre, first, level, last]);
  end
  else
  begin
    Result := Format('__%s%s%s%s%3.3d', [pre, DECOR_SEP, val, DECOR_SEP, level]);
//    Result := Format('__%s_%s_%3.3d', [pre, val, level]);
  end;
end;

function Replace(const str : string; const src, rep : string) : string;
begin
{$IFDEF FAST_MM}
  Result := FastReplace(str, src, rep);
{$ELSE}
  Result := StringReplace(str, src, rep, [rfReplaceAll]);
{$ENDIF}
end;

procedure NBCFormatSettings(var aFS : TFormatSettings; const aDS : Char);
begin
  aFS.DecimalSeparator  := aDS;
  aFS.ThousandSeparator := ThousandSeparator;
  aFS.CurrencyFormat    := CurrencyFormat;
  aFS.NegCurrFormat     := NegCurrFormat;
  aFS.CurrencyDecimals  := CurrencyDecimals;
  aFS.CurrencyString    := CurrencyString;
end;

function NBCFloatToStr(const AValue: Double): string;
begin
  Result := StripTrailingZeros(NBCFormat('%.10f', [AValue]));
end;

function NBCStrToFloat(const AValue: string): Double;
var
  FS : TFormatSettings;
begin
  FS.DecimalSeparator := DecimalSeparator;
  NBCFormatSettings(FS, '.');
  Result := StrToFloat(AValue, FS);
end;

function NBCStrToFloatDef(const AValue: string; const aDef : Double): Double;
var
  FS : TFormatSettings;
begin
  FS.DecimalSeparator := DecimalSeparator;
  NBCFormatSettings(FS, '.');
  Result := StrToFloatDef(AValue, aDef, FS);
end;

function NBCTextToFloat(Buffer: PChar; var Value; ValueType: TFloatValue): Boolean;
var
  FS : TFormatSettings;
  val : Extended;
begin
  FS.DecimalSeparator := DecimalSeparator;
  NBCFormatSettings(FS, '.');
  Result := TextToFloat(Buffer, val, fvExtended, FS);
end;

function NBCFormat(const FmtStr: string; const theArgs: array of const) : string;
var
  FS : TFormatSettings;
begin
  FS.DecimalSeparator := DecimalSeparator;
  NBCFormatSettings(FS, '.');
  Result := Format(FmtStr, theArgs, FS);
end;

function StripQuotes(const str : string) : string;
begin
  Result := Copy(str, 2, Length(str)-2);
end;

{$IFDEF FPC}
function JCHExtractStrings(Separators, WhiteSpace: TSysCharSet; Content: PChar;
  Strings: TStrings): Integer;
var
  Head, Tail: PChar;
  EOS, InQuote: Boolean;
  QuoteChar: Char;
  Item: string;
begin
  Item := '';
  Result := 0;
  if (Content = nil) or (Content^=#0) or (Strings = nil) then Exit;
  Tail := Content;
  InQuote := False;
  QuoteChar := #0;
  Strings.BeginUpdate;
  try
    repeat
      while Tail^ in WhiteSpace + [#13, #10] do inc(Tail);
      Head := Tail;
      while True do
      begin
        while (InQuote and not (Tail^ in [QuoteChar, #0])) or
          not (Tail^ in Separators + [#0, #13, #10, '''', '"']) do
            inc(Tail);
        if Tail^ in ['''', '"'] then
        begin
          if (QuoteChar <> #0) and (QuoteChar = Tail^) then
            QuoteChar := #0
          else if QuoteChar = #0 then
            QuoteChar := Tail^;
          InQuote := QuoteChar <> #0;
          inc(Tail);
        end else Break;
      end;
      EOS := Tail^ = #0;
      if (Head <> Tail) and (Head^ <> #0) then
      begin
        if Strings <> nil then
        begin
          SetString(Item, Head, Tail - Head);
          Strings.Add(Item);
        end;
        Inc(Result);
      end;
      inc(Tail);
    until EOS;
  finally
    Strings.EndUpdate;
  end;
end;
{$ELSE}
function JCHExtractStrings(Separators, WhiteSpace: TSysCharSet; Content: PChar;
  Strings: TStrings): Integer;
begin
  Result := ExtractStrings(Separators, WhiteSpace, Content, Strings);
end;
{$ENDIF}

function ValueToDataType(const value : integer) : char;
begin
  if value < 0 then begin
    Result := TOK_CHARDEF;
    if value < Low(Shortint) then
    begin
      Result := TOK_SHORTDEF;
      if value < Low(Smallint) then
        Result := TOK_LONGDEF;
    end;
  end
  else begin
    Result := TOK_BYTEDEF;
    if value > High(Byte) then
    begin
      Result := TOK_USHORTDEF;
      if value > High(Word) then
        Result := TOK_ULONGDEF;
    end;
  end;
end;

function DataTypeToTypeName(const dt : char) : string;
begin
  case dt of
    TOK_CHARDEF		: Result := 'char';
    TOK_SHORTDEF 	: Result := 'int';
    TOK_LONGDEF   : Result := 'long';
    TOK_BYTEDEF   : Result := 'byte';
    TOK_USHORTDEF : Result := 'unsigned int';
    TOK_ULONGDEF  : Result := 'unsigned long';
  else
    Result := 'unexpected type';
  end;
end;

function BoolToString(aValue : boolean) : string;
begin
  if aValue then
    Result := 'TRUE'
  else
    Result := 'FALSE';
end;

{ TNBCExpParser }

constructor TNBCExpParser.Create(AOwner: TComponent);
begin
  inherited;
  fFirmwareVersion := MAX_FW_VER1X;
end;

procedure TNBCExpParser.InitializeCalc;
var
  i : integer;
begin
  ClearVariables;
  if StandardDefines then
  begin
    SetVariable(STR_NA, NOT_AN_ELEMENT);
    SetVariable(STR_FALSE, Ord(false));
    SetVariable(STR_TRUE, Ord(true));
    // add comparison codes
    for i := Low(CCEncodings) to High(CCEncodings) do
      SetVariable(CCEncodings[i].Mode, CCEncodings[i].Encoding);
    // add output field IDs
    for i := Low(OutputFieldIDs) to High(OutputFieldIDs) do
      SetVariable(OutputFieldIDs[i].Name, OutputFieldIDs[i].ID);
    // add input field IDs
    for i := Low(InputFieldIDs) to High(InputFieldIDs) do
      SetVariable(InputFieldIDs[i].Name, InputFieldIDs[i].ID);
    if FirmwareVersion > MAX_FW_VER1X then
    begin
      // add syscall method IDs
      for i := Low(SysCallMethodIDs2x) to High(SysCallMethodIDs2x) do
        SetVariable(SysCallMethodIDs2x[i].Name, SysCallMethodIDs2x[i].ID);
    end
    else
    begin
      // add syscall method IDs
      for i := Low(SysCallMethodIDs1x) to High(SysCallMethodIDs1x) do
        SetVariable(SysCallMethodIDs1x[i].Name, SysCallMethodIDs1x[i].ID);
    end;
    // add IOMap field IDs
    for i := Low(IOMapFieldIDs) to High(IOMapFieldIDs) do
      SetVariable(IOMapFieldIDs[i].Name, IOMapFieldIDs[i].ID);

{
    // add IOMap Offset IDs
    for i := Low(IOMapOffsetRecords) to High(IOMapOffsetRecords) do
      SetVariable(IOMapOffsetRecords[i].Name, IOMapOffsetRecords[i].ID);
}
  end;
  if ExtraDefines then
  begin
    SetVariable(STR_OUT_A, OUT_A);
    SetVariable(STR_OUT_B, OUT_B);
    SetVariable(STR_OUT_C, OUT_C);
    SetVariable(STR_IN_1, IN_1);
    SetVariable(STR_IN_2, IN_2);
    SetVariable(STR_IN_3, IN_3);
    SetVariable(STR_IN_4, IN_4);
    SetVariable(STR_IO_BASE, IO_BASE);
    SetVariable(STR_MOD_OUTPUT, MOD_OUTPUT);
    SetVariable(STR_MOD_INPUT, MOD_INPUT);
    SetVariable(STR_IO_IN_FPP, IO_IN_FPP);
    SetVariable(STR_IO_OUT_FPP, IO_OUT_FPP);
    // add Update Flag IDs
    for i := Low(UFRecords) to High(UFRecords) do
      SetVariable(UFRecords[i].Name, UFRecords[i].ID);
    // add Output Mode IDs
    for i := Low(OutModeRecords) to High(OutModeRecords) do
      SetVariable(OutModeRecords[i].Name, OutModeRecords[i].ID);
    // add Output RunState IDs
    for i := Low(OutRunStateRecords) to High(OutRunStateRecords) do
      SetVariable(OutRunStateRecords[i].Name, OutRunStateRecords[i].ID);
    // add Output RegMode IDs
    for i := Low(OutRegModeRecords) to High(OutRegModeRecords) do
      SetVariable(OutRegModeRecords[i].Name, OutRegModeRecords[i].ID);
    // add Input Type IDs
    for i := Low(InTypeRecords) to High(InTypeRecords) do
      SetVariable(InTypeRecords[i].Name, InTypeRecords[i].ID);
    // add Input Mode IDs
    for i := Low(InModeRecords) to High(InModeRecords) do
      SetVariable(InModeRecords[i].Name, InModeRecords[i].ID);
    // add MS_X IDs
    for i := Low(MSRecords) to High(MSRecords) do
      SetVariable(MSRecords[i].Name, MSRecords[i].ID);
    // add TONE_X IDs
    for i := Low(ToneRecords) to High(ToneRecords) do
      SetVariable(ToneRecords[i].Name, ToneRecords[i].ID);
{
    // add miscellaneous IOMap constants
    for i := Low(IOMapMiscRecords) to High(IOMapMiscRecords) do
      SetVariable(IOMapMiscRecords[i].Name, IOMapMiscRecords[i].ID);
}
  end;
end;

procedure TNBCExpParser.SetExtraDefs(const aValue: boolean);
begin
  if fExtraDefs <> aValue then
  begin
    fExtraDefs := aValue;
    InitializeCalc;
  end;
end;

procedure TNBCExpParser.SetFirmwareVersion(const Value: word);
begin
  fFirmwareVersion := Value;
end;

procedure TNBCExpParser.SetStandardDefs(const aValue: boolean);
begin
  if fStandardDefs <> aValue then
  begin
    fStandardDefs := aValue;
    InitializeCalc;
  end;
end;

{ TInlineFunction }

constructor TInlineFunction.Create(ACollection: TCollection);
begin
  inherited;
  fCode := TStringList.Create;
  fVariables := TVariableList.Create;
  fCallers := TStringList.Create;
  TStringList(fCallers).Sorted := True;
  TStringList(fCallers).Duplicates := dupError;
  fParams  := TFunctionParameters.Create;
  fEmitCount := 0;
end;

destructor TInlineFunction.Destroy;
begin
  FreeAndNil(fCode);
  FreeAndNil(fVariables);
  FreeAndNil(fCallers);
  FreeAndNil(fParams);
  inherited;
end;

procedure TInlineFunction.Emit(aStrings: TStrings);
var
  tmpSL : TStringList;
  tmpCode, oldname, newname, NameInline : string;
  i : integer;
  fp : TFunctionParameter;
begin
  inc(fEmitCount);
  // adjust labels
  tmpSL := TStringList.Create;
  try
    tmpCode := FixupLabels(fCode.Text);
    tmpCode := Replace(tmpCode, 'return', Format('jmp %s', [EndLabel]));
    // do all the variable replacing that is needed
    for i := 0 to Parameters.Count - 1 do
    begin
      fp := Parameters[i];
      oldname := ApplyDecoration(fp.ProcName, fp.Name, 0);
      newname := InlineName(CurrentCaller, oldname);
      // is this parameter a constant?
      if fp.IsConstant and not fp.IsReference then
        tmpCode := Replace(tmpCode, oldname, fp.ConstantValue)
      else
        tmpCode := Replace(tmpCode, oldname, newname);
    end;
    for i := 0 to LocalVariables.Count - 1 do
    begin
      oldname := LocalVariables[i].Name;
      newname := InlineName(CurrentCaller, oldname);
      tmpCode := Replace(tmpCode, oldname, newname);
    end;
    // need to fix string return buffer name, string temp buffer name,
    // register name, and all the stack variable names.
    // YUCKY !!!!!!!
    NameInline := InlineName(CurrentCaller, Name);
    for i := Low(REGVARS_ARRAY) to High(REGVARS_ARRAY) do
    begin
      oldname := Format(REGVARS_ARRAY[i], [Name]);
      newname := Format(REGVARS_ARRAY[i], [NameInline]);
      tmpCode := Replace(tmpCode, oldName, newName);
    end;
    oldname := Format('__result_%s', [Name]);
    newname := Format('__result_%s', [NameInline]);
    tmpCode := Replace(tmpCode, oldName, newName);
    for i := 1 to MaxStackDepth do
    begin
      oldname := Format('__signed_stack_%3.3d%s', [i, Name]);
      newname := Format('__signed_stack_%3.3d%s', [i, NameInline]);
      tmpCode := Replace(tmpCode, oldName, newName);
    end;
    for i := 1 to MaxStackDepth do
    begin
      oldname := Format('__unsigned_stack_%3.3d%s', [i, Name]);
      newname := Format('__unsigned_stack_%3.3d%s', [i, NameInline]);
      tmpCode := Replace(tmpCode, oldName, newName);
    end;
    for i := 1 to MaxStackDepth do
    begin
      oldname := Format('__float_stack_%3.3d%s', [i, Name]);
      newname := Format('__float_stack_%3.3d%s', [i, NameInline]);
      tmpCode := Replace(tmpCode, oldName, newName);
    end;
    if Pos(EndLabel, tmpCode) > 0 then
      tmpCode := tmpCode + #13#10 + EndLabel + ':';
    tmpSL.Text := tmpCode;
    aStrings.AddStrings(tmpSL);
  finally
    tmpSL.Free;
  end;
end;

function TInlineFunction.FixupLabels(const tmpCode: string): string;
{
var
  tmp, values : TStringList;
  i, j : integer;
  line : string;
}
begin
  // NXC-generated labels are fixed-up here
  Result := Replace(tmpCode, LABEL_PREFIX, Format('__%3.3d%s', [fEmitCount, LABEL_PREFIX]));
  // also need to fix any other user-defined labels in the code so that
  // emitting this code more than once will not cause duplicate label
  // problems
{
  tmp := TStringList.Create;
  try
    tmp.Text := Result;
    for i := 0 to tmp.Count - 1 do
    begin
      line := tmp[i];
      // does this line contain a label?
      values := TStringList.Create;
      try
        j := JCHExtractStrings([' ', #9], [], PChar(line), values);
      finally
        values.Free;
      end;
    end;
  finally
    tmp.Free;
  end;
}
end;

function TInlineFunction.GetEndLabel: string;
begin
  Result := Format(LABEL_PREFIX+'%s_inline_%s_%3.3d_end_lbl', [CurrentCaller, Name, fEmitCount]);
end;

procedure TInlineFunction.SetCode(const Value: TStrings);
begin
  fCode.Assign(Value);
end;

procedure TInlineFunction.SetParams(const Value: TFunctionParameters);
var
  i : integer;
  fp, newFP : TFunctionParameter;
begin
  // copy into fParams the parameters in Value that are for this function
  fParams.Clear;
  for i := 0 to Value.Count - 1 do
  begin
    fp := Value[i];
    if fp.ProcName = Self.Name then
    begin
      newFP := Self.Parameters.Add;
      newFP.Assign(fp);
    end;
  end;
end;

{ TInlineFunctions }

function TInlineFunctions.Add: TInlineFunction;
begin
  Result := TInlineFunction(inherited Add);
end;

constructor TInlineFunctions.Create;
begin
  inherited Create(TInlineFunction);
end;

function TInlineFunctions.GetItem(Index: Integer): TInlineFunction;
begin
  Result := TInlineFunction(inherited GetItem(Index));
end;

function TInlineFunctions.IndexOfName(const name: string): integer;
var
  i : integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    if Items[i].Name = name then
    begin
      Result := Items[i].Index;
      break;
    end;
  end;
end;

function TInlineFunctions.Insert(Index: Integer): TInlineFunction;
begin
  result := TInlineFunction(inherited Insert(Index));
end;

procedure TInlineFunctions.SetItem(Index: Integer; const Value: TInlineFunction);
begin
  inherited SetItem(Index, Value);
end;

{ TFunctionParameters }

function TFunctionParameters.Add: TFunctionParameter;
begin
  Result := TFunctionParameter(inherited Add);
end;

constructor TFunctionParameters.Create;
begin
  inherited Create(TFunctionParameter);
end;

function TFunctionParameters.GetItem(Index: Integer): TFunctionParameter;
begin
  Result := TFunctionParameter(inherited GetItem(Index));
end;

function TFunctionParameters.IndexOf(const procname: string;
  const idx: integer): integer;
var
  i : integer;
  fp : TFunctionParameter;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    fp := Items[i];
    if (fp.ProcName = procname) and (fp.ParamIndex = idx) then
    begin
      Result := fp.Index;
      break;
    end;
  end;
end;

function TFunctionParameters.Insert(Index: Integer): TFunctionParameter;
begin
  result := TFunctionParameter(inherited Insert(Index));
end;

function TFunctionParameters.ParamCount(const name: string): integer;
var
  i : integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do begin
    if Items[i].ProcName = name then
      inc(Result);
  end;
end;

function TFunctionParameters.RequiredParamCount(const name: string): integer;
var
  i : integer;
  fp : TFunctionParameter;
begin
  Result := 0;
  for i := 0 to Count - 1 do begin
    fp := Items[i];
    if (fp.ProcName = name) and not fp.HasDefault then
      inc(Result);
  end;
end;

procedure TFunctionParameters.SetItem(Index: Integer; const Value: TFunctionParameter);
begin
  inherited SetItem(Index, Value);
end;

{ TFunctionParameter }

procedure TFunctionParameter.AssignTo(Dest: TPersistent);
var
  fp : TFunctionParameter;
begin
  if Dest is TFunctionParameter then
  begin
    fp := TFunctionParameter(Dest);
    fp.ProcName       := ProcName;
    fp.Name           := Name;
    fp.ParamType      := ParamType;
    fp.ParamTypeName  := ParamTypeName;
    fp.ParamIndex     := ParamIndex;
    fp.IsArray        := IsArray;
    fp.IsConstant     := IsConstant;
    fp.IsReference    := IsReference;
    fp.ArrayDimension := ArrayDimension;
    fp.ConstantValue  := ConstantValue;
    fp.FuncIsInline   := FuncIsInline;
    fp.HasDefault     := HasDefault;
    fp.DefaultValue   := DefaultValue;
  end
  else
    inherited;
end;

constructor TFunctionParameter.Create(ACollection: TCollection);
begin
  inherited;
  fProcName     := '';
  fName         := '';
  fParamIndex   := 0;
  fIsConstant   := False;
  fIsReference  := False;
  fIsArray      := False;
  fDim          := 0;
  fParamType    := fptUBYTE;
  fFuncIsInline := False;
  fHasDefault   := False;
  fDefaultValue := '';
end;

function TFunctionParameter.GetConstValue: string;
begin
  Result := fConstValue;
end;

function TFunctionParameter.GetIsConstReference: boolean;
begin
  Result := IsConstant and IsReference;
end;

function TFunctionParameter.GetIsVarReference: boolean;
begin
  Result := not IsConstant and IsReference;
end;

function TFunctionParameter.GetParamDataType: char;
begin
  case ParamType of
    fptSBYTE : begin
      if not IsArray then
        Result := TOK_CHARDEF
      else
        Result := Char(Ord(TOK_ARRAYCHARDEF) + ArrayDimension-1);
    end;
    fptUBYTE : begin
      if not IsArray then
        Result := TOK_BYTEDEF
      else
        Result := Char(Ord(TOK_ARRAYBYTEDEF) + ArrayDimension-1);
    end;
    fptSWORD : begin
      if not IsArray then
        Result := TOK_SHORTDEF
      else
        Result := Char(Ord(TOK_ARRAYSHORTDEF) + ArrayDimension-1);
    end;
    fptUWORD : begin
      if not IsArray then
        Result := TOK_USHORTDEF
      else
        Result := Char(Ord(TOK_ARRAYUSHORTDEF) + ArrayDimension-1);
    end;
    fptSLONG : begin
      if not IsArray then
        Result := TOK_LONGDEF
      else
        Result := Char(Ord(TOK_ARRAYLONGDEF) + ArrayDimension-1);
    end;
    fptULONG : begin
      if not IsArray then
        Result := TOK_ULONGDEF
      else
        Result := Char(Ord(TOK_ARRAYULONGDEF) + ArrayDimension-1);
    end;
    fptString : begin
      if not IsArray then
        Result := TOK_STRINGDEF
      else
        Result := Char(Ord(TOK_ARRAYSTRING) + ArrayDimension-1);
    end;
    fptUDT : begin
      if not IsArray then
        Result := TOK_USERDEFINEDTYPE
      else
        Result := Char(Ord(TOK_ARRAYUDT) + ArrayDimension-1);
    end;
    fptMutex : Result := TOK_MUTEXDEF;
    fptFloat : begin
      if not IsArray then
        Result := TOK_FLOATDEF
      else
        Result := Char(Ord(TOK_ARRAYFLOAT) + ArrayDimension-1);
    end;
  else
    Result := TOK_BYTEDEF;
  end;
end;

procedure TFunctionParameter.SetConstValue(const Value: string);
begin
  fConstValue := Value;
end;

{ TVariable }

procedure TVariable.AssignTo(Dest: TPersistent);
var
  V : TVariable;
begin
  if Dest is TVariable then
  begin
    V := TVariable(Dest);
    V.Name         := Name;
    V.DataType     := DataType;
    V.IsConstant   := IsConstant;
    V.TypeName     := TypeName;
    V.LenExpr      := LenExpr;
    V.Level        := Level;
    V.HasDefault   := HasDefault;
    V.DefaultValue := DefaultValue;
  end
  else
    inherited;
end;

constructor TVariable.Create(ACollection: TCollection);
begin
  inherited;
  fName     := '';
  fValue    := '';
  fTypeName := '';
  fDataType := TOK_BYTEDEF;
  fIsConst  := False;
  fLevel    := 0;
  fHasDef   := False;
  fDefValue := '';
end;

{ TVariableList }

function TVariableList.Add: TVariable;
begin
  Result := TVariable(inherited Add);
end;

constructor TVariableList.Create;
begin
  inherited Create(TVariable);
end;

function TVariableList.GetItem(Index: Integer): TVariable;
begin
  Result := TVariable(inherited GetItem(Index));
end;

function TVariableList.IndexOfName(const name: string): integer;
var
  i : integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    if Items[i].Name = name then
    begin
      Result := Items[i].Index;
      break;
    end;
  end;
end;

function TVariableList.Insert(Index: Integer): TVariable;
begin
  Result := TVariable(inherited Insert(Index));
end;

procedure TVariableList.SetItem(Index: Integer; const Value: TVariable);
begin
  inherited SetItem(Index, Value);
end;

{ TArrayHelperVar }

constructor TArrayHelperVar.Create(ACollection: TCollection);
begin
  inherited;
  fThreadName := 'main';
  fDataType   := #0;
  fUDType     := '';
  fIndex      := 0;
  fLocked     := False;
end;

function TArrayHelperVar.GetName: string;
begin
  Result := Format('__ArrHelper__%s%s_%d_%d', [fThreadName, fUDType, Ord(fDataType), fIndex]);
end;

{ TArrayHelperVars }

function TArrayHelperVars.Add: TArrayHelperVar;
begin
  Result := TArrayHelperVar(inherited Add);
end;

constructor TArrayHelperVars.Create;
begin
  inherited Create(TArrayHelperVar);
end;

function TArrayHelperVars.GetHelper(const tname, udType: string; const dt: char): TArrayHelperVar;
var
  i, newIdx : integer;
  X : TArrayHelperVar;
begin
  Result := nil;
  // look for existing helper.  If not found, create one.
  for i := 0 to Count - 1 do
  begin
    X := Items[i];
    if (X.ThreadName = tname) and (X.DataType = dt) and
       (X.UserDefinedType = udType) and not X.Locked then
    begin
      Result := X;
      Break;
    end;
  end;
  if Result = nil then
  begin
    newIdx := 0;
    for i := Count - 1 downto 0 do
    begin
      X := Items[i];
      if (X.ThreadName = tname) and (X.DataType = dt) and (X.UserDefinedType = udType) then
      begin
        // duplicate item
        newIdx := X.Index + 1;
        break;
      end;
    end;
    // create new helper
    Result := Add;
    Result.ThreadName      := tname;
    Result.DataType        := dt;
    Result.UserDefinedType := udType;
    Result.fIndex          := newIdx;
  end;
  Result.fLocked := True;
end;

function TArrayHelperVars.GetItem(Index: Integer): TArrayHelperVar;
begin
  Result := TArrayHelperVar(inherited GetItem(Index));
end;

function TArrayHelperVars.IndexOfName(const name: string): integer;
var
  i : integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    if Items[i].Name = name then
    begin
      Result := Items[i].Index;
      break;
    end;
  end;
end;

function TArrayHelperVars.Insert(Index: Integer): TArrayHelperVar;
begin
  Result := TArrayHelperVar(inherited Insert(Index));
end;

procedure TArrayHelperVars.ReleaseHelper(aHelper: TArrayHelperVar);
begin
  aHelper.fLocked := False;
end;

procedure TArrayHelperVars.SetItem(Index: Integer; const Value: TArrayHelperVar);
begin
  inherited SetItem(Index, Value);
end;

end.
