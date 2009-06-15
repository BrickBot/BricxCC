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
unit uNXCComp;

interface

uses
  Classes, uNBCCommon, uGenLexer, uNXTClasses, uPreprocess, Contnrs;

type
  TNXCComp = class
  private
    fStackDepth : integer;
    fStatementType : TStatementType;
    fInlineFunctionStack : TObjectStack;
    fLastErrLine : integer;
    fLastErrMsg : string;
    endofallsource : boolean;
    fEnhancedFirmware: boolean;
    fIgnoreSystemFile: boolean;
    fParenDepth : integer;
    fSafeCalls: boolean;
    fMaxErrors: word;
    fFirmwareVersion: word;
    fStackVarNames : TStringList;
    fOnCompilerStatusChange: TCompilerStatusChangeEvent;
    function FunctionParameterTypeName(const name: string; idx: integer): string;
    function LocalDataType(const n: string): char;
    function LocalTypeName(const n: string): string;
    function LocalConstantValue(const n: string): string;
    function GlobalDataType(const n: string): char;
    function GlobalTypeName(const n: string): string;
    function ParamDataType(const n: string): char;
    function ParamTypeName(const n: string): string;
    function ParamConstantValue(const n: string): string;
    procedure OptionalSemi;
    procedure CheckSemicolon;
    procedure OpenParen;
    procedure CloseParen;
    procedure InitializeGraphicOutVars;
    procedure LocalEmitLn(SL: TStrings; const line: string);
    procedure LocalEmitLnNoTab(SL: TStrings; const line: string);
    procedure pop;
    procedure push;
    procedure SetStatementType(const Value: TStatementType);
    procedure DoCompilerStatusChange(const Status: string);
  protected
    fDD: TDataDefs;
    fCurrentStruct : TDataspaceEntry;
    fNamedTypes : TMapList;
    fEmittedLocals : TStringList;
    fLocals : TVariableList;
    fParams : TVariableList;
    fGlobals : TVariableList;
    fFuncParams : TFunctionParameters;
    fCurrentInlineFunction : TInlineFunction;
    fInlineFunctions : TInlineFunctions;
    fArrayHelpers : TArrayHelperVars;
    fNBCSrc : TStrings;
    fMessages : TStrings;
    fMS : TMemoryStream;
    fTempChar : Char;
    fCCSet : boolean;
    fIncludeDirs: TStrings;
    fCurFile: string;
    fOnCompMSg: TOnCompilerMessage;
    fDirLine : string;
    fCurrentLine : string;
    fExpStr : string;
    fExpStrHasVars : boolean;
    fAPIFunctions : TStrings;
    fAPIStrFunctions : TStrings;
    fThreadNames : TStrings;
    fCurrentThreadName : string;
    fBytesRead : integer;
    fSwitchFixups : TStrings;
    fSwitchRegNames : TStrings;
    fSwitchDepth : integer;
    fCalc : TNBCExpParser;
    fOptimizeLevel: integer;
//    fInlining : boolean;
    fInlineDepth : integer;
    fInlineStack : TObjectList; // list of TStrings
    fSafeCalling : boolean;
    fNestingLevel : integer;
    fLHSDataType : char;
    fLHSName : string;
    fWarningsOff: boolean;
    fFunctionNameCallStack : TStrings;
    fSemiColonRequired : boolean;
    fExpressionIsSigned : boolean;
    fConstStringMap : TStringList;
    fArrayIndexStack : TStringList;
    fStructDecls : TStringList;
    fUDTOnStack : string;
    fLastExpressionOptimizedToConst : boolean;
    fLastLoadedConst : string;
    function AmInlining : boolean;
    procedure IncrementInlineDepth;
    procedure DecrementInlineDepth;
    procedure HandleSpecialNames;
    procedure EmitNXCRequiredStructs;
    procedure ResetStatementType;
    procedure DecrementNestingLevel;
    procedure GetCharX;
    procedure GetChar;
    procedure Init;
    procedure Prog; virtual;
    procedure SkipCommentBlock;
    procedure SkipLine;
    procedure SkipDirectiveLine;
    procedure SkipWhite;
    procedure GetDirective;
    procedure GetName;
    procedure GetNum;
    procedure GetHexNum;
    procedure GetCharLit;
    procedure GetOp;
    procedure Next(bProcessDirectives : boolean = True);
    procedure MatchString(x: string);
    procedure Semi;
    procedure NotNumericFactor;
    procedure NumericFactor;
    procedure Modulo;
    procedure Divide;
    procedure Multiply;
    procedure Term;
    procedure Add;
    procedure Equal;
    procedure EqualString;
    procedure LessString;
    procedure EqualArrayOrUDT(const lhs : string);
    procedure LessArrayOrUDT(const lhs : string);
    procedure Expression;
    procedure DoPreIncOrDec(bPutOnStack : boolean);
    function  IncrementOrDecrement : boolean;
    function OptimizeExpression(const idx : integer) : string;
    procedure LessOrEqual;
    procedure NotEqual;
    procedure Subtract;
    procedure BoolExpression;
    procedure Greater;
    procedure LeftShift;
    procedure Less;
    procedure NEqual;
    procedure Relation;
    procedure StoreZeroFlag;
    function  ValueIsStringType : boolean;
    function  ValueIsArrayType : boolean;
    function  ValueIsUserDefinedType : boolean;
    procedure RightShift;
    procedure BoolTerm;
    procedure NotFactor;
    function  TypesAreCompatible(lhs, rhs : char) : boolean;
    function  GetParamName(procname : string; idx : integer) : string;
    procedure DoCall(procname: string);
    function  GetValueOf(const name : string) : string;
    procedure DoCallAPIFunc(procname: string);
    function  APIFuncNameToID(procname : string) : integer;
    function  IsAPIFunc(procname : string) : boolean;
    procedure DoAssignValue(const aName : string; dt : char);
    procedure DoLocalArrayInit(const aName, ival : string; dt : char);
    procedure DoArrayAssignValue(const aName, idx : string; dt : char);
    procedure DoNewArrayIndex(theArrayDT : Char; theArray, aLHSName : string);
    procedure Assignment;
    procedure CheckNotConstant(const aName : string);
    procedure Block(const lend : string = ''; const lstart : string = '');
    procedure BlockStatements(const lend : string = ''; const lstart : string = '');
    procedure CheckBytesRead(const oldBytesRead : integer);
    procedure DoFor;
    procedure DoIf(const lend, lstart : string);
    procedure DoWhile;
    procedure DoDoWhile;
    procedure DoRepeat;
    procedure DoAsm(var dt : char);
    function  DecorateVariables(const asmStr : string) : string;
    procedure DoSwitch;
    procedure DoSwitchCase;
    function  GetCaseConstant : string;
    procedure DoSwitchDefault;
    function  SwitchFixupIndex : integer;
    function  SwitchIsString : Boolean;
    function  SwitchRegisterName : string;
    procedure ClearSwitchFixups;
    procedure FixupSwitch(idx : integer; lbl : string);
    procedure DoLabel;
    procedure DoStart;
    procedure DoStopTask;
    procedure DoSetPriority;
    procedure Statement(const lend, lstart : string);
    procedure ProcessDirectives(bScan : boolean = True);
    procedure HandlePoundLine;
    function  ArrayOfType(dt : char; dimensions : integer) : char;
    function  GetVariableType(vt: char; bUnsigned: boolean): char;
    function  RemoveArrayDimension(dt : char) : char;
    function  AddArrayDimension(dt : char) : char;
    procedure IncLineNumber;
    function AddLocal(name: string; dt: char; const tname : string;
      bConst : boolean; const lenexp : string) : integer;
    procedure AllocGlobal(const tname : string; dt: char; bInline, bSafeCall, bConst : boolean);
    procedure AllocLocal(const sub, tname: string; dt: char; bConst : boolean);
    function  GetInitialValue(dt : char) : string;
    procedure DoLocals(const sub: string);
    procedure AddFunctionParameter(pname, varname, tname : string; idx : integer;
      ptype : char; bIsConst, bIsRef, bIsArray : boolean; aDim : integer);
    function  FormalList(protoexists: boolean; procname: string): integer;
    procedure ProcedureBlock;
    procedure InitializeGlobalArrays;
    procedure FunctionBlock(const Name, tname : string; dt : char; bInline, bSafeCall : boolean);
//    procedure Error(s: string);
    procedure AbortMsg(s: string);
    procedure Expected(s: string);
    procedure Undefined(n: string);
    procedure CheckIdent;
    procedure CheckEnhancedFirmware;
    procedure CheckDataType(dt : char);
    procedure CheckTypeCompatibility(fp : TFunctionParameter; dt : char; const name : string);
    procedure Duplicate(n: string);
//    function SizeOfType(dt: char): integer;
    procedure AddEntry(N: string; T: char; const tname, lenexp : string; bConst : boolean = False; bSafeCall : boolean = False);
    procedure CheckDup(N: string);
    procedure CheckTable(const N: string);
    procedure CheckGlobal(const N: string);
    procedure AddParam(N: string; T: char; const tname : string; bConst : boolean);
    function  DataType(const n: string): char;
    procedure LoadVar(const Name: string);
    procedure CheckNotProc(const Name : string);
    procedure Store(const Name: string);
    procedure Allocate(const Name, aVal, Val, tname: string; dt: char);
    procedure InitializeArray(const Name, aVal, Val, tname: string; dt : char;
      lenexpr : string);
    function  InlineDecoration : string;
    procedure Epilog(bIsSub: boolean);
    procedure Prolog(const name: string; bIsSub: boolean);
    procedure EmitRegisters;
    procedure EmitStackVariables;
    procedure EmitMutexDeclaration(const name : string);
    procedure EmitInlineParametersAndLocals(func : TInlineFunction);
//    procedure EmitTypeDefs;
    procedure EmitLn(s: string);
    procedure EmitLnNoTab(s: string);
    procedure PostLabel(L: string);
    procedure LoadConst(n: string);
//    procedure EmitInlineFunction(const idx : integer);
    procedure Negate;
    procedure NotIt;
    procedure Complement;
    procedure PopAdd;
    procedure PopAnd;
    procedure PopCmpEqual;
    procedure PopCmpGreater;
    procedure PopCmpGreaterOrEqual;
    procedure PopCmpLess;
    procedure PopCmpLessOrEqual;
    procedure PopCmpNEqual;
    procedure PopMod;
    procedure PopDiv;
    procedure PopLeftShift;
    procedure PopMul;
    procedure PopOr;
    procedure PopRightShift;
    procedure PopSub;
    procedure PopXor;
    procedure PushPrim;
    procedure SetZeroCC;
    procedure Branch(L: string);
    procedure BranchFalse(L: string);
    procedure BranchTrue(L: string);
    procedure ClearReg;
    procedure ArrayAssignment(const name : string; dt : char; bIndexed : boolean);
    procedure UDTAssignment(const name : string);
    procedure GetAndStoreUDT(const name : string);
    procedure MathAssignment(const name : string);
    procedure StoreAdd(const name: string);
    procedure StoreDiv(const name: string);
    procedure StoreMod(const name: string);
    procedure StoreAnd(const name: string);
    procedure StoreOr(const name: string);
    procedure StoreXor(const name: string);
    procedure StoreAbs(const name: string);
    procedure StoreSign(const name: string);
    procedure StoreShift(bRight : boolean; const name: string);
    procedure StoreMul(const name: string);
    procedure StoreSub(const name: string);
    procedure StoreInc(const name: string; const val: integer = 1);
    procedure StoreDec(const name: string; const val: integer = 1);
    procedure DoAPICommands(const lend, lstart : string);
    procedure DoResetScreen;
    procedure DoReadButton(idx : integer);
    procedure DoBreakContinue(idx : integer; const lbl : string);
    procedure DoOnFwdRev;
    procedure DoOnFwdRevReg;
    procedure DoOnFwdRevSync;
    procedure DoOnFwdRevEx;
    procedure DoOnFwdRevRegEx;
    procedure DoOnFwdRevSyncEx;
    procedure DoOnFwdRevRegPID;
    procedure DoOnFwdRevSyncPID;
    procedure DoOnFwdRevRegExPID;
    procedure DoOnFwdRevSyncExPID;
    procedure DoResetCounters;
    procedure DoRotateMotors(idx : integer);
    procedure DoSetSensorTypeMode(idx : integer);
    procedure DoClearSetResetSensor;
    procedure DoTextNumOut(idx : integer);
    procedure DoFontTextNumOut(idx : integer);
    procedure DoDrawPoint;
    procedure DoDrawPoly;
    procedure DoDrawEllipse;
    procedure DoDrawLineRect(idx : integer);
    procedure DoDrawCircle;
    procedure DoDrawGraphic(idx : integer);
    procedure DoPlayToneEx;
    procedure DoPlayFileEx;
    procedure DoAcquireRelease;
    procedure DoExitTo;
    procedure DoSetInputOutput(const idx : integer);
    procedure DoStop;
    procedure DoGoto;
    procedure DoPrecedesFollows;
    procedure DoReturn;
    procedure DoStopMotors;
    procedure DoStopMotorsEx;
    procedure DoStrCat;
    procedure DoSubString;
    procedure DoStrReplace;
    procedure DoStrToNum;
    procedure ReportProblem(const lineNo: integer; const fName, msg: string; const err: boolean);
    procedure Scan;
    function  IsWhite(c: char): boolean;
    function  IsRelop(c: char): boolean;
    function  IsOrop(c: char): boolean;
    function  IsDigit(c: char): boolean;
    function  IsHex(c: char): boolean;
    function  IsAlNum(c: char): boolean;
    function  IsAddop(c: char): boolean;
    function  IsMulop(c: char): boolean;
    procedure GetString;
    procedure CheckNumeric;
    function  ValueIsNumeric : boolean;
    procedure CheckString;
    procedure LoadAPIFunctions;
    procedure AddAPIFunction(const name : string; id : integer);
    function  WhatIs(const n: string): TSymbolType;
    procedure StringExpression(const Name : string; bAdd : boolean = False);
    procedure StringConcatAssignment(const Name : string);
    procedure StringFunction(const Name : string);
    function  TempSignedByteName: string;
    function  TempSignedWordName: string;
    function  TempSignedLongName : string;
    function  TempUnsignedLongName : string;
    function  TempFloatName : string;
    function  RegisterName(name : string = '') : string;
    function  SignedRegisterName(name : string = '') : string;
    function  UnsignedRegisterName(name : string = '') : string;
    function  FloatRegisterName(name : string = '') : string;
    function  ZeroFlag : string;
    function  tos: string;
    function  StrTmpBufName(name : string = '') : string;
    function  StrBufName(name : string = '') : string;
    function  StrRetValName(name : string = '') : string;
    procedure StoreString(const Name: string);
    procedure AddAPIStringFunction(const name: string; id: integer);
    function  APIStrFuncNameToID(procname: string): integer;
    function  IsAPIStrFunc(procname: string): boolean;
    procedure DoStrLen;
    procedure DoStrIndex;
    procedure DoFormatNum;
    function  ReplaceTokens(const line: string): string;
    procedure EmitAsmLines(s: string);
    procedure EmitPoundLine;
    function  IsLocal(n: string): boolean;
    function  LocalIdx(n: string): integer;
    function  IsOldParam(n: string): boolean;
    function  IsFuncParam(n: string): boolean;
    function  IsParam(n: string): boolean;
    function  ParamIdx(n: string): integer;
    procedure AllocateHelper(const Name, aVal, Val, tname: string; dt: char);
    function  AlreadyDecorated(n : string) : boolean;
    function  GetDecoratedValue: string;
    function  GetDecoratedIdent(const val: string): string;
    procedure PopCmpHelper(const cc: string);
    procedure GreaterString;
    procedure NEqualString;
    procedure CmpHelper(const cc, lhs, rhs : string);
    procedure GreaterArrayOrUDT(const lhs : string);
    procedure NEqualArrayOrUDT(const lhs : string);
    procedure BoolSubExpression;
    function  NewLabel: string;
    procedure StoreArray(const name, idx, val: string);
    procedure CheckTask(const Name: string);
    procedure NumericRelation;
    function  GetNBCSrc: TStrings;
    function  FunctionReturnType(const name: string): char;
    function  FunctionParameterCount(const name: string): integer;
    function  FunctionParameterType(const name : string; idx : integer) : char;
    procedure ClearLocals;
    procedure ClearParams;
    procedure ClearGlobals;
    function  IsGlobal(n: string): boolean;
    function  GlobalIdx(n: string): integer;
    procedure SetDefines(const Value: TStrings);
    function  GetFunctionParam(const procname: string;
      idx: integer): TFunctionParameter;
    procedure CheckStringConst;
    function  AdvanceToNextParam : string;
    function  FunctionParameterIsConstant(const name: string;
      idx: integer): boolean;
    function  IsParamConst(n: string): boolean;
    function  IsLocalConst(n: string): boolean;
    function  IsGlobalConst(n: string): boolean;
    function  GlobalUsesSafeCall(const n: string): boolean;
    function  GetUDTType(n : string) : string;
    procedure AddTypeNameAlias(const lbl, args : string);
    function  TranslateTypeName(const name : string) : string;
    procedure ProcessTypedef;
    procedure ProcessStruct(bTypeDef : boolean = False);
    procedure CheckForTypedef(var bUnsigned, bConst, bInline, bSafeCall : boolean);
    function  IsUserDefinedType(const name : string) : boolean;
    function  RootOf(const name : string) : string;
    function  DataTypeOfDataspaceEntry(DE : TDataspaceEntry) : char;
    procedure LoadSystemFile(S : TStream);
    procedure CheckForMain;
  protected
    fTmpAsmLines : TStrings;
    fBadProgram : boolean;
    fProgErrorCount : integer;
    fDefines : TStrings;
    procedure InternalParseStream;
    procedure Clear;
    property  SwitchFixups : TStrings read fSwitchFixups;
    property  SwitchRegisterNames : TStrings read fSwitchRegNames;
  protected
    procedure TopDecls; virtual;
    procedure Header; virtual;
    procedure Trailer; virtual;
    procedure PreProcess; virtual;
    function  GetPreProcLexerClass : TGenLexerClass; virtual;
    // dataspace definitions property
    property  DataDefinitions : TDataDefs read fDD;
    property  StatementType : TStatementType read fStatementType write SetStatementType;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Parse(const aFilename : string); overload;
    procedure Parse(aStream : TStream); overload;
    procedure Parse(aStrings : TStrings); overload;
    property  Defines : TStrings read fDefines write SetDefines;
    property  NBCSource : TStrings read GetNBCSrc;
    property  CompilerMessages : TStrings read fMessages;
    property  IncludeDirs : TStrings read fIncludeDirs;
    property  CurrentFile : string read fCurFile write fCurFile;
    property  OptimizeLevel : integer read fOptimizeLevel write fOptimizeLevel;
    property  WarningsOff : boolean read fWarningsOff write fWarningsOff;
    property  EnhancedFirmware : boolean read fEnhancedFirmware write fEnhancedFirmware;
    property  FirmwareVersion : word read fFirmwareVersion write fFirmwareVersion;
    property  IgnoreSystemFile : boolean read fIgnoreSystemFile write fIgnoreSystemFile;
    property  SafeCalls : boolean read fSafeCalls write fSafeCalls;
    property  MaxErrors : word read fMaxErrors write fMaxErrors;
    property  OnCompilerMessage : TOnCompilerMessage read fOnCompMSg write fOnCompMsg;
    property  ErrorCount : integer read fProgErrorCount;
    property OnCompilerStatusChange : TCompilerStatusChangeEvent read fOnCompilerStatusChange write fOnCompilerStatusChange;
  end;

implementation

uses
  SysUtils, Math, uNXCLexer, uNBCLexer, mwGenericLex, uLocalizedStrings,
  NBCCommonData, NXCDefsData, uNXTConstants;

{--------------------------------------------------------------}
{ Constant Declarations }

const
  TAB = ^I;
  CR  = ^M;
  LF  = ^J;

var
  LCount : integer = 0;

const
  MAXGLOBALS = 1000;
  MAXPARAMS  = 32;

{--------------------------------------------------------------}
{ Type Declarations }

type
  SymTab = array[1..MAXGLOBALS] of string;
  TabPtr = ^SymTab;

{--------------------------------------------------------------}
{ Variable Declarations }

var
  Look: char = LF;              { Lookahead Character }
//  PrevLook : char;
  Token: char;             { Encoded Token       }
  Value: string;           { Unencoded Token     }

var
  slevel : integer = 1;
  linenumber : integer;	// current source line number
  totallines : integer = 0;

var
  GS_Name : SymTab;
  GS_Type : array[1..MAXGLOBALS] of char;
  GS_Size : array[1..MAXGLOBALS] of integer;	// size (in 'data type' units)
  GS_ReturnType : array[1..MAXGLOBALS] of char; // only for procedures
  NumGlobals : integer = 0;

{--------------------------------------------------------------}
{ Definition of Keywords and Token Types }

const
  NKW  = 32; //18;
  NKW1 = 33; //19;

const
  KWlist: array[1..NKW] of string =
              ('if', 'else', 'while',
               'for', 'sub', 'void', 'task',
               'do', 'repeat', 'switch', 'asm', 'const',
               'default', 'case', 'struct', 'typedef', 'inline', 'safecall',
               'start', 'stop', 'priority',
               'unsigned', 'long', 'short', 'int',
               'char', 'bool', 'byte', 'mutex', 'float', 'string',
               'end');

const                                     // 'xileweRWve'
  KWcode: array[1..NKW1+1] of Char =
    (TOK_IDENTIFIER, TOK_IF, TOK_ELSE, TOK_WHILE,
     TOK_FOR, TOK_PROCEDURE, TOK_PROCEDURE, TOK_TASK,
     TOK_DO, TOK_REPEAT, TOK_SWITCH, TOK_ASM, TOK_CONST,
     TOK_DEFAULT, TOK_CASE, TOK_STRUCT, TOK_TYPEDEF, TOK_INLINE, TOK_SAFECALL,
     TOK_START, TOK_STOP, TOK_PRIORITY,
     TOK_UNSIGNED, TOK_LONGDEF, TOK_SHORTDEF, TOK_SHORTDEF,
     TOK_CHARDEF, TOK_BYTEDEF, TOK_BYTEDEF, TOK_MUTEXDEF, TOK_FLOATDEF, TOK_STRINGDEF,
     TOK_END,
     #0);

const
  API_BREAK    = 0;
  API_CONTINUE = 1;
  API_ONFWD    = 3;
  API_ONREV    = 4;
  API_ONFWDREG = 5;
  API_ONREVREG = 6;
  API_ONFWDSYNC = 7;
  API_ONREVSYNC = 8;
  API_COAST     = 9;
  API_OFF       = 10;
  API_ROTATEMOTOR = 11;
  API_ROTATEMOTOREX = 12;
  API_SETSENSORTYPE = 13;
  API_SETSENSORMODE = 14;
  API_CLEARSENSOR = 15;
  API_SETSENSORTOUCH = 16;
  API_SETSENSORLIGHT = 17;
  API_SETSENSORSOUND = 18;
  API_SETSENSORLOWSPEED = 19;
  API_RESETSENSOR = 20;
  API_RETURN = 21;
  API_ACQUIRE = 22;
  API_RELEASE = 23;
  API_PRECEDES = 24;
  API_FOLLOWS  = 25;
  API_EXITTO = 26;
  API_SETINPUT = 27;
  API_SETOUTPUT = 28;
  API_STOP = 29;
  API_GOTO = 30;
  API_FLOAT = 31;
  API_ONFWDEX    = 32;
  API_ONREVEX    = 33;
  API_ONFWDREGEX = 34;
  API_ONREVREGEX = 35;
  API_ONFWDSYNCEX = 36;
  API_ONREVSYNCEX = 37;
  API_COASTEX     = 38;
  API_OFFEX       = 39;
  API_ROTATEMOTORPID = 40;
  API_ROTATEMOTOREXPID = 41;
  API_RESETTACHOCOUNT      = 42;
  API_RESETBLOCKTACHOCOUNT = 43;
  API_RESETROTATIONCOUNT   = 44;
  API_RESETALLTACHOCOUNTS  = 45;
  API_ONFWDREGPID = 46;
  API_ONREVREGPID = 47;
  API_ONFWDSYNCPID = 48;
  API_ONREVSYNCPID = 49;
  API_ONFWDREGEXPID = 50;
  API_ONREVREGEXPID = 51;
  API_ONFWDSYNCEXPID = 52;
  API_ONREVSYNCEXPID = 53;
  API_WAIT                 =  2; // moved to header file as inline function

  APICount = 54;
  APIList : array[0..APICount-1] of string = (
    'break', 'continue', '__Wait__',
    'OnFwd', 'OnRev', 'OnFwdReg', 'OnRevReg',
    'OnFwdSync', 'OnRevSync', 'Coast', 'Off',
    'RotateMotor', 'RotateMotorEx',
    'SetSensorType', 'SetSensorMode', 'ClearSensor',
    'SetSensorTouch', 'SetSensorLight', 'SetSensorSound', 'SetSensorLowspeed',
    'ResetSensor',
    'return', 'Acquire', 'Release', 'Precedes', 'Follows',
    'ExitTo', 'SetInput', 'SetOutput', 'Stop', 'goto', 'Float',
    'OnFwdEx', 'OnRevEx', 'OnFwdRegEx', 'OnRevRegEx',
    'OnFwdSyncEx', 'OnRevSyncEx', 'CoastEx', 'OffEx',
    'RotateMotorPID', 'RotateMotorExPID',
    'ResetTachoCount', 'ResetBlockTachoCount',
    'ResetRotationCount', 'ResetAllTachoCounts',
    'OnFwdRegPID', 'OnRevRegPID', 'OnFwdRegExPID', 'OnRevRegExPID',
    'OnFwdSyncPID', 'OnRevSyncPID', 'OnFwdSyncExPID', 'OnRevSyncExPID'
  );

const
  NonAggregateTypes = [TOK_CHARDEF, TOK_SHORTDEF, TOK_LONGDEF,
                       TOK_BYTEDEF, TOK_USHORTDEF, TOK_ULONGDEF, TOK_FLOATDEF];
  IntegerTypes = [TOK_CHARDEF, TOK_SHORTDEF, TOK_LONGDEF,
                  TOK_BYTEDEF, TOK_USHORTDEF, TOK_ULONGDEF];
const
  UnsignedIntegerTypes = [TOK_BYTEDEF, TOK_USHORTDEF, TOK_ULONGDEF];
  SignedIntegerTypes = [TOK_CHARDEF, TOK_SHORTDEF, TOK_LONGDEF];
  SignedTypes = SignedIntegerTypes + [TOK_FLOATDEF];

function GetArrayDimension(dt : char) : integer;
begin
  case dt of
    TOK_ARRAYFLOAT..TOK_ARRAYFLOAT4         : Result := Ord(dt) - Ord(TOK_ARRAYFLOAT) + 1;
    TOK_ARRAYSTRING..TOK_ARRAYSTRING4       : Result := Ord(dt) - Ord(TOK_ARRAYSTRING) + 1;
    TOK_ARRAYUDT..TOK_ARRAYUDT4             : Result := Ord(dt) - Ord(TOK_ARRAYUDT) + 1;
    TOK_ARRAYCHARDEF..TOK_ARRAYCHARDEF4     : Result := Ord(dt) - Ord(TOK_ARRAYCHARDEF) + 1;
    TOK_ARRAYSHORTDEF..TOK_ARRAYSHORTDEF4   : Result := Ord(dt) - Ord(TOK_ARRAYSHORTDEF) + 1;
    TOK_ARRAYLONGDEF..TOK_ARRAYLONGDEF4     : Result := Ord(dt) - Ord(TOK_ARRAYLONGDEF) + 1;
    TOK_ARRAYBYTEDEF..TOK_ARRAYBYTEDEF4     : Result := Ord(dt) - Ord(TOK_ARRAYBYTEDEF) + 1;
    TOK_ARRAYUSHORTDEF..TOK_ARRAYUSHORTDEF4 : Result := Ord(dt) - Ord(TOK_ARRAYUSHORTDEF) + 1;
    TOK_ARRAYULONGDEF..TOK_ARRAYULONGDEF4   : Result := Ord(dt) - Ord(TOK_ARRAYULONGDEF) + 1;
  else
    Result := 0;
  end;
end;

function IsArrayType(dt: char): boolean;
begin
  Result := (dt >= TOK_ARRAYFLOAT) and (dt <= TOK_ARRAYULONGDEF4);
end;

function IsUDT(dt: char): boolean;
begin
  Result := dt = TOK_USERDEFINEDTYPE;
end;

function ArrayBaseType(dt: char): char;
begin
  case dt of
    TOK_ARRAYFLOAT..TOK_ARRAYFLOAT4         : Result := TOK_FLOATDEF;
    TOK_ARRAYSTRING..TOK_ARRAYSTRING4       : Result := TOK_STRINGDEF;
    TOK_ARRAYUDT..TOK_ARRAYUDT4             : Result := TOK_USERDEFINEDTYPE;
    TOK_ARRAYCHARDEF..TOK_ARRAYCHARDEF4     : Result := TOK_CHARDEF;
    TOK_ARRAYSHORTDEF..TOK_ARRAYSHORTDEF4   : Result := TOK_SHORTDEF;
    TOK_ARRAYLONGDEF..TOK_ARRAYLONGDEF4     : Result := TOK_LONGDEF;
    TOK_ARRAYBYTEDEF..TOK_ARRAYBYTEDEF4     : Result := TOK_BYTEDEF;
    TOK_ARRAYUSHORTDEF..TOK_ARRAYUSHORTDEF4 : Result := TOK_USHORTDEF;
    TOK_ARRAYULONGDEF..TOK_ARRAYULONGDEF4   : Result := TOK_ULONGDEF;
  else
    Result := dt;
  end;
end;

function DataTypeToArrayDimensions(dt : char) : string;
var
  d, i : integer;
begin
  Result := '';
  d := GetArrayDimension(dt);
  for i := 0 to d - 1 do
    Result := Result + '[]';
end;

procedure TNXCComp.pop;
begin
  dec(fStackDepth);
  fStackVarNames.Delete(fStackVarNames.Count - 1);
end;

procedure TNXCComp.push;
var
  tosName : string;
begin
  inc(fStackDepth);
  MaxStackDepth := Max(MaxStackDepth, fStackDepth);
  if fStatementType = stFloat then
    tosName := Format('__float_stack_%3.3d%s', [fStackDepth, fCurrentThreadName])
  else if fStatementType = stUnsigned then
    tosName := Format('__unsigned_stack_%3.3d%s', [fStackDepth, fCurrentThreadName])
  else
    tosName := Format('__signed_stack_%3.3d%s', [fStackDepth, fCurrentThreadName]);
  fStackVarNames.Add(tosName);
end;

procedure TNXCComp.GetCharX;
var
  bytesread : integer;
begin
  bytesread := fMS.Read(Look, 1);
  inc(fBytesRead, bytesread);
  fCurrentLine := fCurrentLine + Look;
  if Look = LF then
  begin
    IncLineNumber;
    fCurrentLine := '';
  end;
  if bytesread < 1 then
    endofallsource := True;
  if endofallsource and (slevel > 1) then begin
    // close file pointer
    linenumber := 0;
    dec(slevel);
    Look := LF;
    endofallsource := False;
  end;
end;

{--------------------------------------------------------------}
{ Read New Character From Input Stream }

procedure TNXCComp.GetChar;
begin
  if fTempChar <> ' ' then begin
    Look := fTempChar;
    fCurrentLine := fCurrentLine + Look;
    fTempChar := ' ';
  end
  else begin
    GetCharX;
    if Look = '/' then begin
      fMS.Read(fTempChar, 1);
      if fTempChar = '*' then begin
        Look := TOK_BLOCK_COMMENT;
        fTempChar := ' ';
      end
      else if fTempChar = '/' then begin
        Look := TOK_LINE_COMMENT;
        fTempChar := ' ';
      end;
    end;
  end;
end;


{--------------------------------------------------------------}
{ Report Error and Halt }

procedure TNXCComp.ReportProblem(const lineNo: integer; const fName,
  msg: string; const err : boolean);
var
  tmp, tmp1, tmp2, tmp3, tmp4 : string;
  stop : boolean;
begin
  // exit without doing anything if this is not an error and warnings are off
  if WarningsOff and not err then
    Exit;
  if (lineNo <> fLastErrLine) or (msg <> fLastErrMsg) then
  begin
    fLastErrLine := lineNo;
    fLastErrMsg  := msg;
    if lineNo = -1 then
    begin
      tmp := msg;
      fMessages.Add(tmp);
    end
    else
    begin
      if err then
        tmp1 := Format('# Error: %s', [msg])
      else
        tmp1 := Format('# Warning: %s', [msg]);
      fMessages.Add(tmp1);
      tmp2 := Format('File "%s" ; line %d', [fName, lineNo]);
      fMessages.Add(tmp2);
      tmp3 := Format('#   %s', [fCurrentLine]);
      fMessages.Add(tmp3);
      tmp4 := '#----------------------------------------------------------';
      fMessages.Add(tmp4);
      tmp := tmp1+#13#10+tmp2+#13#10+tmp3+#13#10+tmp4;
    end;
    fBadProgram := err;
    if err then
      inc(fProgErrorCount);
    stop := (MaxErrors > 0) and (fProgErrorCount >= MaxErrors);
    if assigned(fOnCompMsg) then
      fOnCompMsg(tmp, stop);
    if stop then
      Abort;
  end;
end;

procedure TNXCComp.AbortMsg(s: string);
begin
  ReportProblem(linenumber, CurrentFile, s, True);
end;

(*
{--------------------------------------------------------------}
{Return the size in base units of a standard datatype }

function TNXCComp.SizeOfType(dt : char) : integer;
begin
  case dt of
    TOK_CHARDEF, TOK_BYTEDEF : Result := 1;
    TOK_SHORTDEF, TOK_USHORTDEF : Result := 2;
    TOK_LONGDEF, TOK_ULONGDEF : Result := 4;
    TOK_MUTEXDEF : Result := 4;
    TOK_FLOATDEF : Result := 4; // ???
  else
    Result := 0;
    AbortMsg('SizeOfType() - Unknown Data Type');
  end;
end;
*)

{--------------------------------------------------------------}
{ Report What Was Expected }

procedure TNXCComp.Expected(s: string);
begin
  AbortMsg(Format(sExpectedString, [s]));
end;

{--------------------------------------------------------------}
{ Report an Undefined Identifier }

procedure TNXCComp.Undefined(n: string);
begin
  AbortMsg(Format(sUndefinedIdentifier, [n]));
end;


{--------------------------------------------------------------}
{ Report a Duplicate Identifier }

procedure TNXCComp.Duplicate(n: string);
begin
   AbortMsg(Format(sDuplicateIdentifier, [StripDecoration(n)]));
end;


{--------------------------------------------------------------}
{ Check to Make Sure the Current Token is an Identifier }

procedure TNXCComp.CheckIdent;
begin
  if Token <> TOK_IDENTIFIER then Expected(sIdentifier);
end;

{--------------------------------------------------------------}
{ Check to Make Sure the Current Token is a Number }

function TNXCComp.ValueIsNumeric: boolean;
var
  vName : string;
  idx : integer;
  V : TVariable;
begin
  Result := True;
  if not (Token in [TOK_NUM, TOK_HEX]) then
  begin
    // what about a constant numeric variable?
    if Token = TOK_IDENTIFIER then
    begin
      // it is an identifier
      vName := GetDecoratedValue;
      // if it is a global constant then it can be evaluated using our
      // expression evaluator
      fCalc.SilentExpression := vName;
      if fCalc.ParserError then
      begin
        // what about a constant local?
        idx := LocalIdx(vName);
        if idx <> -1 then
        begin
          V := fLocals[idx];
          if V.IsConstant and (V.Value <> '') then
            Value := V.Value
          else
            Result := False;
        end
        else
          Result := False;
      end
      else
        Value := NBCFloatToStr(fCalc.Value);
    end
    else
      Result := False;
  end;
end;

procedure TNXCComp.CheckNumeric;
begin
  if not ValueIsNumeric then
    Expected(sNumber);
end;

procedure TNXCComp.CheckString;
begin
  if (Token <> TOK_STRINGLIT) and
     not (DataType(Value) in [TOK_STRINGDEF, TOK_ARRAYBYTEDEF]) then
    Expected(sStringType);
end;

procedure TNXCComp.CheckStringConst;
begin
  if (Token <> TOK_STRINGLIT) then
    Expected(sStringLiteral);
end;



{--------------------------------------------------------------}
{ Recognize a Decimal Digit }

function TNXCComp.IsDigit(c: char): boolean;
begin
  Result := c in ['0'..'9'];
end;

{--------------------------------------------------------------}
{ Recognize a Hex Digit }

function TNXCComp.IsHex(c: char): boolean;
begin
  Result := IsDigit(c) or (c in ['a'..'f', 'A'..'F']);
end;

{--------------------------------------------------------------}
{ Recognize an Alphanumeric }

function TNXCComp.IsAlNum(c: char): boolean;
begin
  Result := IsAlpha(c) or IsDigit(c) or (c = '.');
end;

{--------------------------------------------------------------}
{ Recognize an Addop }

function TNXCComp.IsAddop(c: char) : boolean;
begin
  Result := c in ['+', '-'];
end;

{--------------------------------------------------------------}
{ Recognize a Mulop }

function TNXCComp.IsMulop(c: char): boolean;
begin
  Result := c in ['*', '/', '%'];
end;

{--------------------------------------------------------------}
{ Recognize a Boolean Orop }

function TNXCComp.IsOrop(c: char): boolean;
begin
  Result := c in ['|', '^'];
end;

{--------------------------------------------------------------}
{ Recognize a Relop }

function TNXCComp.IsRelop(c: char): boolean;
begin
  Result := c in ['=', '!', '<', '>'];
end;

{--------------------------------------------------------------}
{ Recognize White Space }

function TNXCComp.IsWhite(c: char): boolean;
begin
  Result := c in [' ', TAB, CR, LF, TOK_BLOCK_COMMENT, TOK_LINE_COMMENT];
end;

{--------------------------------------------------------------}
{ Skip A Comment Field }

procedure TNXCComp.SkipCommentBlock;
begin
  repeat
    repeat
      GetCharX;
    until (Look = '*') or endofallsource;
    GetCharX;
  until (Look = '/') or endofallsource;
  GetChar;
end;


{--------------------------------------------------------------}
{ Skip A Comment To End Of Line field }

procedure TNXCComp.SkipLine;
begin
  repeat
    GetCharX;
  until (Look = LF) or endofallsource;
  GetChar;
end;

procedure TNXCComp.SkipDirectiveLine;
begin
  fDirLine := Value + ' ';
  repeat
    GetCharX;
    fDirLine := fDirLine + Look;
  until (Look = LF) or endofallsource;
  GetChar;
end;

{--------------------------------------------------------------}
{ Skip Over Leading White Space }

procedure TNXCComp.SkipWhite;
begin
  while IsWhite(Look) and not endofallsource do begin
    case Look of
      TOK_LINE_COMMENT : SkipLine;
      TOK_BLOCK_COMMENT : SkipCommentBlock;
    else
      GetChar;
    end;
  end;
end;


{--------------------------------------------------------------}
{ Table Lookup }

function Lookup(T: TabPtr; s: string; n: integer): integer;
var
  i: integer;
  found: Boolean;
begin
  found := false;
  i := n;
  while (i > 0) and not found do
     if s = T^[i] then
        found := true
     else
        dec(i);
  Result := i;
end;


{--------------------------------------------------------------}
{ Locate a Symbol in Table }
{ Returns the index of the entry.  Zero if not present. }

function TNXCComp.GlobalIdx(n: string): integer;
begin
  Result := Lookup(@GS_Name, RootOf(n), NumGlobals);
end;

function TNXCComp.IsGlobal(n: string): boolean;
begin
  Result := GlobalIdx(RootOf(n)) <> 0;
end;

function TNXCComp.IsGlobalConst(n: string): boolean;
var
  i : integer;
begin
  Result := False;
  i := fGlobals.IndexOfName(RootOf(n));
  if i <> -1 then
    Result := fGlobals[i].IsConstant;
end;

function TNXCComp.GlobalDataType(const n: string): char;
var
  i : integer;
begin
  Result := #0;
  i := fGlobals.IndexOfName(RootOf(n));
  if i <> -1 then
    Result := fGlobals[i].DataType;
end;

function TNXCComp.GlobalTypeName(const n: string): string;
var
  i : integer;
begin
  Result := '';
  i := fGlobals.IndexOfName(RootOf(n));
  if i <> -1 then
    Result := fGlobals[i].TypeName;
end;

function TNXCComp.GlobalUsesSafeCall(const n: string): boolean;
var
  i : integer;
begin
  Result := False;
  i := fGlobals.IndexOfName(RootOf(n));
  if i <> -1 then
    Result := fGlobals[i].UseSafeCall;
end;

function TNXCComp.AlreadyDecorated(n: string): boolean;
var
  i : integer;
  tmp : string;
begin
  // a variable is considered to be already decorated if it
  // starts with "__" followed by a task name followed by DECOR_SEP
  // OR it starts with "__signed_stack_"
  // OR it starts with "__unsigned_stack_"
  // OR it starts with "__float_stack_"
  // OR it starts with %%CALLER%%_
  Result := False;
  i := Pos('__', n);
  if i = 1 then
  begin
    System.Delete(n, 1, 2); // remove the '__' at the beginning
    Result := Pos('%%CALLER%%_', n) = 1;
    if Result then Exit;
    i := Pos(DECOR_SEP, n);
    if i > 1 then
    begin
      tmp := Copy(n, 1, i-1);
      i := fThreadNames.IndexOf(tmp);
      Result := (i <> -1) or (tmp = 'signed_stack') or
                (tmp = 'unsigned_stack') or (tmp = 'float_stack');
    end;
  end;
end;

{--------------------------------------------------------------}
{ Look for Symbol in Parameter Table }

function TNXCComp.IsOldParam(n: string): boolean;
begin
  Result := ParamIdx(RootOf(n)) <> -1{0};
end;

function TNXCComp.IsFuncParam(n: string): boolean;
var
  i : integer;
  fp : TFunctionParameter;
begin
  Result := False;
  // check in the fFuncParams
  for i := 0 to fFuncParams.Count - 1 do
  begin
    fp := fFuncParams[i];
    if ApplyDecoration(fp.ProcName, fp.Name, 0) = RootOf(n) then
    begin
      Result := True;
      Break;
    end;
  end;
end;


function TNXCComp.IsParam(n: string): boolean;
begin
  Result := IsOldParam(n);
  if not Result then
    Result := IsFuncParam(n);
end;

function TNXCComp.ParamIdx(n: string): integer;
begin
  n := RootOf(n);
  if AlreadyDecorated(n) then
    Result := fParams.IndexOfName(n)
  else
    Result := fParams.IndexOfName(ApplyDecoration(fCurrentThreadName, n, 0));
end;

function TNXCComp.IsParamConst(n: string): boolean;
var
  i : integer;
begin
  Result := False;
  i := ParamIdx(RootOf(n));
  if i <> -1 then
    Result := fParams[i].IsConstant;
end;

function TNXCComp.ParamConstantValue(const n: string): string;
var
  i : integer;
begin
  Result := n;
  i := ParamIdx(RootOf(n));
  if i <> -1 then
  begin
    if fParams[i].IsConstant then
      Result := fParams[i].Value;
  end;
end;

function TNXCComp.ParamDataType(const n: string): char;
var
  i : integer;
begin
  Result := #0;
  i := ParamIdx(RootOf(n));
  if i <> -1 then
    Result := fParams[i].DataType;
end;

function TNXCComp.ParamTypeName(const n: string): string;
var
  i : integer;
begin
  Result := '';
  i := ParamIdx(RootOf(n));
  if i <> -1 then
    Result := fParams[i].TypeName;
end;

{--------------------------------------------------------------}
{ Look for Symbol in Local Table }

function TNXCComp.IsLocal(n: string): boolean;
begin
  Result := LocalIdx(RootOf(n)) <> -1{0};
  if not Result then
  begin
    // is this a special internal variable name?
  end;
end;

function TNXCComp.LocalIdx(n: string): integer;
var
  i : integer;
begin
  n := RootOf(n);
  if AlreadyDecorated(n) then
    Result := fLocals.IndexOfName(n)
  else
  begin
    Result := -1;
    for i := fNestingLevel downto 0 do
    begin
      Result := fLocals.IndexOfName(ApplyDecoration(fCurrentThreadName, n, i));
      if Result > -1 then
        break;
    end;
  end;
end;

function TNXCComp.IsLocalConst(n: string): boolean;
var
  i : integer;
begin
  Result := False;
  i := LocalIdx(RootOf(n));
  if i <> -1 then
    Result := fLocals[i].IsConstant;
end;

function TNXCComp.LocalConstantValue(const n: string): string;
var
  i : integer;
begin
  Result := n;
  i := LocalIdx(RootOf(n));
  if i <> -1 then
  begin
    if fLocals[i].IsConstant then
      Result := fLocals[i].Value;
  end;
end;

function TNXCComp.LocalDataType(const n: string): char;
var
  i : integer;
begin
  Result := #0;
  i := LocalIdx(RootOf(n));
  if i <> -1 then
    Result := fLocals[i].DataType;
end;

function TNXCComp.LocalTypeName(const n: string): string;
var
  i : integer;
begin
  Result := '';
  i := LocalIdx(RootOf(n));
  if i <> -1 then
    Result := fLocals[i].TypeName;
end;

{--------------------------------------------------------------}
{ Check to See if an Identifier is in the Symbol Table         }
{ Report an error if it's not. }

procedure TNXCComp.CheckTable(const N: string);
begin
  if not IsParam(N) and
     not IsLocal(N) and
     not IsGlobal(N) then
    Undefined(N);
end;

procedure TNXCComp.CheckGlobal(const N: string);
begin
  if not IsGlobal(N) then
    Undefined(N);
end;

{--------------------------------------------------------------}
{ Check the Symbol Table for a Duplicate Identifier }
{ Report an error if identifier is already in table. }


procedure TNXCComp.CheckDup(N: string);
begin
  if IsGlobal(N) then
    Duplicate(N);
end;


{--------------------------------------------------------------}
{ Add a New Entry to Symbol Table }

procedure TNXCComp.AddEntry(N: string; T: char; const tname, lenexp : string;
  bConst, bSafeCall : boolean);
begin
  CheckDup(N);
  if NumGlobals = MAXGLOBALS then AbortMsg(sSymbolTableFull);
  Inc(NumGlobals);
  GS_Name[NumGlobals] := N;
  GS_Type[NumGlobals] := T;

  with fGlobals.Add do
  begin
    Name        := N;
    DataType    := T;
    IsConstant  := bConst;
    UseSafeCall := bSafeCall;
    TypeName    := tname;
    LenExpr     := lenexp;
  end;
end;


{--------------------------------------------------------------}
{ Get an preprocessor directive }

procedure TNXCComp.GetDirective;
begin
  SkipWhite;
  if Look <> '#' then Expected(sDirective);
  Token := TOK_DIRECTIVE;
  Value := '';
  repeat
    Value := Value + Look;
    GetChar;
  until not IsAlpha(Look);
end;

{--------------------------------------------------------------}
{ Get an Identifier }

procedure TNXCComp.GetName;
begin
  SkipWhite;
  if not IsAlpha(Look) then Expected(sIdentifier);
  Token := TOK_IDENTIFIER;
  Value := '';
  repeat
    Value := Value + Look;
    GetChar;
  until not IsAlNum(Look);
  HandleSpecialNames;
  fExpStrHasVars := True;
end;


{--------------------------------------------------------------}
{ Get a Number }

procedure TNXCComp.GetNum;
var
  savedLook : char;
begin
  SkipWhite;
  if not IsDigit(Look) then Expected(sNumber);
  savedLook := Look;
  GetChar;
  if Look in ['x', 'X'] then
  begin
    GetHexNum;
  end
  else
  begin
    Token := TOK_NUM;
    Value := savedLook;
    if not (IsDigit(Look) or (Look = '.')) then Exit;
    repeat
      Value := Value + Look;
      GetChar;
    until not (IsDigit(Look) or (Look = '.'));
  end;
end;


{--------------------------------------------------------------}
{ Get a Hex Number }

procedure TNXCComp.GetHexNum;
begin
  SkipWhite;
  GetChar(); // skip the $ (or 'x')
  if not IsHex(Look) then Expected(sHexNumber);
  Token := TOK_HEX;
  Value := '0x';
  repeat
    Value := Value + Look;
    GetChar;
  until not IsHex(Look);
end;


{--------------------------------------------------------------}
{ Get a Character Literal }

procedure TNXCComp.GetCharLit;
begin
  SkipWhite;
  GetChar; // skip the '
  Token := TOK_NUM;
  Value := IntToStr(Ord(Look));
  GetChar;
  if Look <> '''' then Expected(sCharLiteral);
  GetChar;
end;

{--------------------------------------------------------------}
{ Get a string Literal }

procedure TNXCComp.GetString;
var
  bEscapeNext : boolean;
begin
  SkipWhite;
  GetChar; // skip the "
  Token := TOK_STRINGLIT;
  if Look = '"' then
  begin
    // empty string
    Value := '''''';
    GetChar;
  end
  else
  begin
    Value := '''' + Look;
    repeat
      bEscapeNext := Look = '\';
      GetCharX;
      if not ((Look = LF) or ((Look = '"') and not bEscapeNext)) then
      begin
        if (Look = '''') and not bEscapeNext then
          Value := Value + '\'''
        else
          Value := Value + Look;
{
        if Look = '''' then
          Value := Value + '"'
        else
          Value := Value + Look;
}
      end;
    until ((Look = '"') and not bEscapeNext) or (Look = LF) or endofallsource;
    Value := Value + '''';
    if Look <> '"' then Expected(sStringLiteral);
    GetChar;
  end;
end;


{--------------------------------------------------------------}
{ Get an Operator }

procedure TNXCComp.GetOp;
begin
  SkipWhite;
  Token := Look;
  Value := Look;
  GetChar;
end;


{--------------------------------------------------------------}
{ Get the Next Input Token }

procedure TNXCComp.Next(bProcessDirectives : boolean);
begin
  SkipWhite;
  if Look = '''' then GetCharLit
  else if Look = '"' then GetString
  else if Look = '#' then GetDirective
  else if IsAlpha(Look) then GetName
  else if IsDigit(Look) then GetNum
  else if Look = '$' then GetHexNum
  else GetOp;
  if bProcessDirectives then
  begin
    ProcessDirectives(False);
    fExpStr := fExpStr + Value;
  end;
end;

function IsAPICommand(const name : string) : boolean;
var
  i : integer;
begin
  Result := False;
  for i := Low(APIList) to High(APIList) do
  begin
    if APIList[i] = name then
    begin
      Result := True;
      Break;
    end;
  end;
end;

{--------------------------------------------------------------}
{ Scan the Current Identifier for Keywords }

procedure TNXCComp.Scan;
var
  idx : integer;
begin
  if Token = TOK_IDENTIFIER then
  begin
    idx := Lookup(Addr(KWlist), Value, NKW);
    if idx <> 0 then
      Token := KWcode[idx + 1]
    else
    begin
      // is it an API command?
      if IsAPICommand(Value) then
        Token := TOK_API
      else if IsUserDefinedType(Value) then
        Token := TOK_USERDEFINEDTYPE;
    end;
  end;
end;


{--------------------------------------------------------------}
{ Match a Specific Input String }

procedure TNXCComp.MatchString(x: string);
begin
  if Value <> x then Expected('''' + x + '''');
  Next;
end;


{--------------------------------------------------------------}
{ Match a Semicolon }

procedure TNXCComp.Semi;
begin
  MatchString(TOK_SEMICOLON);
//  if Token = TOK_SEMICOLON then
//    Next;
end;

procedure TNXCComp.OptionalSemi;
begin
  if Token = TOK_SEMICOLON then
    Next;
end;

{--------------------------------------------------------------}
{ Output a String with Tab and CRLF }

procedure TNXCComp.EmitLn(s: string);
begin
  EmitPoundLine;
  NBCSource.Add(#9+s);
end;

procedure TNXCComp.EmitPoundLine;
begin
  NBCSource.Add('#line ' + IntToStr(linenumber-1) + ' "' + CurrentFile + '"');
end;


{--------------------------------------------------------------}
{ Output a String without Tab with CRLF }

procedure TNXCComp.EmitLnNoTab(s: string);
begin
  NBCSource.Add(s);
end;

procedure TNXCComp.EmitAsmLines(s: string);
begin
  if Pos(#10, s) > 0 then
  begin
    fTmpAsmLines.Text := s;
    NBCSource.Add(Format('#pragma macro %d', [fTmpAsmLines.Count]));
    NBCSource.AddStrings(fTmpAsmLines);
    EmitPoundLine;
  end
  else
    NBCSource.Add(s);
end;


{--------------------------------------------------------------}
{ Generate a Unique Label }

function TNXCComp.NewLabel: string;
var
  S: string;
begin
  S := '';
  Str(LCount, S);
  NewLabel := LABEL_PREFIX + S;
  Inc(LCount);
end;


{--------------------------------------------------------------}
{ Post a Label To Output }

procedure TNXCComp.PostLabel(L: string);
begin
  EmitLnNoTab(L+':');
end;


{---------------------------------------------------------------}
{ Initialize Parameter Table to Null }
procedure TNXCComp.ClearParams;
begin
  fParams.Clear;
end;

{---------------------------------------------------------------}
{ Initialize Locals Table to Null }
procedure TNXCComp.ClearLocals;
begin
  fLocals.Clear;
  fEmittedLocals.Clear;
end;

procedure TNXCComp.ClearGlobals;
var
  i : integer;
begin
  for i := 1 to MAXGLOBALS do
  begin
    GS_Name[i] := '';
    GS_Type[i] := #0;
    GS_Size[i] := 0;
    GS_ReturnType[i] := #0;
  end;
  NumGlobals := 0;
  fGlobals.Clear;
end;



{--------------------------------------------------------------}
{ Add a Parameter to Table }

procedure TNXCComp.AddParam(N: string; T: char; const tname : string; bConst : boolean);
begin
  if IsOldParam(N) then Duplicate(N);
  with fParams.Add do
  begin
    Name       := N;
    DataType   := T;
    IsConstant := bConst;
    TypeName   := tname;
  end;
end;

function TNXCComp.WhatIs(const n : string) : TSymbolType;
begin
  if IsParam(n) then Result := stParam
  else if IsLocal(n) then Result := stLocal
  else if IsGlobal(n) then Result := stGlobal
  else if IsAPIFunc(n) then Result := stAPIFunc
  else if IsAPIStrFunc(n) then Result := stAPIStrFunc
  else Result := stUnknown;
end;

function TNXCComp.DataType(const n : string) : char;
var
  p : integer;
  tname : string;
  DE : TDataspaceEntry;
begin
  if (n = '') then
    Result := TOK_LONGDEF
  else if (n = 'true') or (n = 'false') then
    Result := TOK_BYTEDEF
  else
  begin
    case WhatIs(n) of
      stParam : begin
        Result := ParamDataType(n);
        p := Pos('.', n);
        if (Result = TOK_USERDEFINEDTYPE) and (p > 0) then
        begin
          tname := ParamTypeName(n);
          DE := DataDefinitions.FindEntryByFullName(tname + Copy(n, p, MaxInt));
          Result := DataTypeOfDataspaceEntry(DE);
        end;
      end;
      stLocal : begin
        Result := LocalDataType(n);
        p := Pos('.', n);
        if (Result = TOK_USERDEFINEDTYPE) and (p > 0) then
        begin
          tname := LocalTypeName(n);
          DE := DataDefinitions.FindEntryByFullName(tname + Copy(n, p, MaxInt));
          Result := DataTypeOfDataspaceEntry(DE);
        end;
      end;
      stGlobal : begin
        Result := GlobalDataType(n);
        p := Pos('.', n);
        if (Result = TOK_USERDEFINEDTYPE) and (p > 0) then
        begin
          tname := GlobalTypeName(n);
          DE := DataDefinitions.FindEntryByFullName(tname + Copy(n, p, MaxInt));
          Result := DataTypeOfDataspaceEntry(DE);
        end;
      end;
      stAPIFunc : Result := TOK_APIFUNC;
      stAPIStrFunc : Result := TOK_APISTRFUNC;
    else
      // handle some special cases (register variables)
      if (Pos('__strretval', n) = 1) or (Pos('__strtmpbuf', n) = 1) or (Pos('__strbuf', n) = 1) then
        Result := TOK_STRINGDEF
      else if (Pos('__D0', n) = 1) or (Pos('__signed_stack_', n) = 1) or (Pos('__tmpslong', n) = 1) then
        Result := TOK_LONGDEF
      else if (Pos('__DU0', n) = 1) or (Pos('__unsigned_stack_', n) = 1) or (Pos('__tmplong', n) = 1) then
        Result := TOK_ULONGDEF
      else if (Pos('__DF0', n) = 1) or (Pos('__float_stack_', n) = 1) or (Pos('__tmpfloat', n) = 1) then
        Result := TOK_FLOATDEF
      else if (Pos('__zf', n) = 1) then
        Result := TOK_BYTEDEF
      else if (Pos('__tmpsbyte', n) = 1) then
        Result := TOK_CHARDEF
      else if (Pos('__tmpsword', n) = 1) then
        Result := TOK_SHORTDEF
      else
      begin
        Result := #0;
        Undefined(StripDecoration(n));
      end;
    end;
  end;
end;

function TNXCComp.ArrayOfType(dt: char; dimensions : integer): char;
begin
  Result := dt;
  if (dimensions > 4) or (dimensions < 1) then begin
    AbortMsg(sInvalidArrayDim);
    Exit;
  end
  else begin
    dec(dimensions); // convert 1-4 range into 0-3 range
    case dt of
      TOK_CHARDEF : begin
        Result := Char(Ord(TOK_ARRAYCHARDEF)+dimensions);
      end;
      TOK_SHORTDEF : begin
        Result := Char(Ord(TOK_ARRAYSHORTDEF)+dimensions);
      end;
      TOK_LONGDEF : begin
        Result := Char(Ord(TOK_ARRAYLONGDEF)+dimensions);
      end;
      TOK_BYTEDEF : begin
        Result := Char(Ord(TOK_ARRAYBYTEDEF)+dimensions);
      end;
      TOK_USHORTDEF : begin
        Result := Char(Ord(TOK_ARRAYUSHORTDEF)+dimensions);
      end;
      TOK_ULONGDEF : begin
        Result := Char(Ord(TOK_ARRAYULONGDEF)+dimensions);
      end;
      TOK_USERDEFINEDTYPE : begin
        Result := Char(Ord(TOK_ARRAYUDT)+dimensions);
      end;
      TOK_STRINGDEF : begin
        Result := Char(Ord(TOK_ARRAYSTRING)+dimensions);
      end;
      TOK_FLOATDEF : begin
        Result := Char(Ord(TOK_ARRAYFLOAT)+dimensions);
      end;
    else
      Result := dt;
    end;
  end;
end;

{---------------------------------------------------------------}
{ Add Primary or var }

procedure TNXCComp.StoreAdd(const name : string);
begin
  EmitLn(Format('add %0:s, %0:s, %s', [GetDecoratedIdent(name), RegisterName]));
end;

{---------------------------------------------------------------}
{ Subtract Primary from var }

procedure TNXCComp.StoreSub(const name : string);
begin
  EmitLn(Format('sub %0:s, %0:s, %s', [GetDecoratedIdent(name), RegisterName]));
end;

{---------------------------------------------------------------}
{ Multiply Primary with var }

procedure TNXCComp.StoreMul(const name : string);
begin
  EmitLn(Format('mul %0:s, %0:s, %s', [GetDecoratedIdent(name), RegisterName]));
end;

{---------------------------------------------------------------}
{ Divide Primary with var }

procedure TNXCComp.StoreDiv(const name : string);
begin
  // check for unsafe division (signed by unsigned)
  if (DataType(name) in SignedTypes) and (StatementType = stUnsigned) then
  begin
    // cast the unsigned type to a signed type
    EmitLn(Format('mov %s, %s', [SignedRegisterName, UnsignedRegisterName]));
    StatementType := stSigned;
  end;
  EmitLn(Format('div %0:s, %0:s, %s', [GetDecoratedIdent(name), RegisterName]));
end;

{---------------------------------------------------------------}
{ Mod Primary with var }

procedure TNXCComp.StoreMod(const name : string);
begin
  EmitLn(Format('mod %0:s, %0:s, %s', [GetDecoratedIdent(name), RegisterName]));
end;

procedure TNXCComp.StoreAbs(const name: string);
begin
  EmitLn(Format('abs %0:s, %s', [GetDecoratedIdent(name), RegisterName]));
end;

procedure TNXCComp.StoreAnd(const name: string);
begin
  EmitLn(Format('and %0:s, %0:s, %s', [GetDecoratedIdent(name), RegisterName]));
end;

procedure TNXCComp.StoreOr(const name: string);
begin
  EmitLn(Format('or %0:s, %0:s, %s', [GetDecoratedIdent(name), RegisterName]));
end;

procedure TNXCComp.StoreShift(bRight: boolean; const name: string);
begin
  if bRight then
    EmitLn(Format('shr %0:s, %0:s, %s', [GetDecoratedIdent(name), RegisterName]))
  else
    EmitLn(Format('shl %0:s, %0:s, %s', [GetDecoratedIdent(name), RegisterName]));
end;

procedure TNXCComp.StoreSign(const name: string);
begin
  EmitLn(Format('sign %0:s, %s', [GetDecoratedIdent(name), RegisterName]));
end;

procedure TNXCComp.StoreXor(const name: string);
begin
  EmitLn(Format('xor %0:s, %0:s, %s', [GetDecoratedIdent(name), RegisterName]));
end;

{---------------------------------------------------------------}
{ increment var }

procedure TNXCComp.StoreInc(const name : string; const val : integer);
begin
  EmitLn(Format('add %0:s, %0:s, %d', [GetDecoratedIdent(name), val]));
end;

{---------------------------------------------------------------}
{ decrement var }

procedure TNXCComp.StoreDec(const name : string; const val : integer);
begin
  EmitLn(Format('sub %0:s, %0:s, %d', [GetDecoratedIdent(name), val]));
end;

{---------------------------------------------------------------}
{ Clear the Primary Register }

procedure TNXCComp.ClearReg;
var
  fmtStr : string;
begin
  fCCSet := False;
  // 2009-03-18 JCH: It is never safe to use "set" with a float variable
  if StatementType = stFloat then
    fmtStr := 'mov %s, 0'
  else
    fmtStr := 'set %s, 0';
  EmitLn(Format(fmtStr, [RegisterName]));
end;

{---------------------------------------------------------------}
{ Bitwise Negate the Primary Register }

procedure TNXCComp.Complement;
begin
  CheckEnhancedFirmware;
  fCCSet := False;
  EmitLn(Format('cmnt %0:s, %0:s', [RegisterName]));
end;

{---------------------------------------------------------------}
{ Negate the Primary Register }

procedure TNXCComp.Negate;
begin
  fCCSet := False;
  EmitLn(Format('neg %0:s, %0:s', [RegisterName]));
end;

{---------------------------------------------------------------}
{ Complement the Primary Register }

procedure TNXCComp.NotIt;
begin
  fCCSet := False;
  EmitLn(Format('not %0:s, %0:s', [RegisterName]));
end;


{---------------------------------------------------------------}
{ Load a Constant Value to Primary Register }

procedure TNXCComp.LoadConst(n: string);
var
  cval : int64;
  tmpSrc : string;
begin
  fLastLoadedConst := n;
  if (Pos('.', n) > 0) or (StatementType = stFloat) then
  begin
    tmpSrc := 'mov %s, %s';
    StatementType := stFloat;
  end
  else
  begin
    cval := StrToInt64Def(n, 0);
    if cval <= MaxInt then
      StatementType := stSigned
    else
      StatementType := stUnsigned;
    if (cval > High(smallint)) or
       ((cval < 0) and (not EnhancedFirmware or (cval < Low(smallint)))) then
      tmpSrc := 'mov %s, %s'
    else
      tmpSrc := 'set %s, %s';
  end;
  fCCSet := False;
  EmitLn(Format(tmpSrc, [RegisterName, n]));
end;

procedure TNXCComp.CheckNotProc(const Name : string);
begin
  if DataType(Name) in [TOK_PROCEDURE, TOK_TASK] then
    AbortMsg(sAssignTaskError);
end;

procedure TNXCComp.CheckTask(const Name : string);
begin
  if DataType(Name) <> TOK_TASK then
    AbortMsg(sArgMustBeTask);
end;

{---------------------------------------------------------------}
{ Load a Variable to Primary Register }

procedure TNXCComp.LoadVar(const Name: string);
var
  dt : Char;
begin
  CheckNotProc(Name);
  dt := DataType(Name);
  if dt = TOK_FLOATDEF then
    StatementType := stFloat
  else if not (dt in UnsignedIntegerTypes) then
    StatementType := stSigned
  else
    StatementType := stUnsigned;
  fCCSet := False;
  EmitLn(Format('mov %s, %s', [RegisterName, GetDecoratedIdent(Name)]));
end;

{---------------------------------------------------------------}
{ Push Primary onto Stack }

procedure TNXCComp.PushPrim;
begin
  push;
  EmitLn(Format('mov %1:s, %0:s', [RegisterName, tos]));
end;

{---------------------------------------------------------------}
{ Add Top of Stack to Primary }

procedure TNXCComp.PopAdd;
begin
  fCCSet := False;
  EmitLn(Format('add %2:s, %1:s, %0:s', [RegisterName, tos, RegisterName]));
  pop;
end;

{---------------------------------------------------------------}
{ Subtract Primary from Top of Stack }

procedure TNXCComp.PopSub;
begin
  fCCSet := False;
  EmitLn(Format('sub %2:s, %1:s, %0:s', [RegisterName, tos, RegisterName]));
  pop;
end;

{---------------------------------------------------------------}
{ Multiply Top of Stack by Primary }

procedure TNXCComp.PopMul;
begin
  fCCSet := False;
  EmitLn(Format('mul %2:s, %1:s, %0:s', [RegisterName, tos, RegisterName]));
  pop;
end;

{---------------------------------------------------------------}
{ Divide Top of Stack by Primary }

procedure TNXCComp.PopDiv;
var
  p0, p1, p2 : string;
begin
  p0 := RegisterName;
  p1 := tos;
  p2 := RegisterName;
  if (DataType(p1) in SignedTypes) and (DataType(p0) in UnsignedIntegerTypes) then
  begin
    // cast the unsigned type to a signed type
    EmitLn(Format('mov %s, %s', [SignedRegisterName, UnsignedRegisterName]));
    p0 := SignedRegisterName;
  end;
  fCCSet := False;
  EmitLn(Format('div %2:s, %1:s, %0:s', [p0, p1, p2]));
  pop;
end;

{---------------------------------------------------------------}
{ Modulo Top of Stack by Primary }

procedure TNXCComp.PopMod;
begin
  fCCSet := False;
  EmitLn(Format('mod %2:s, %1:s, %0:s', [RegisterName, tos, RegisterName]));
  pop;
end;

{---------------------------------------------------------------}
{ AND Top of Stack with Primary }

procedure TNXCComp.PopAnd;
begin
  fCCSet := False;
  EmitLn(Format('and %2:s, %1:s, %0:s', [RegisterName, tos, RegisterName]));
  pop;
end;

{---------------------------------------------------------------}
{ OR Top of Stack with Primary }

procedure TNXCComp.PopOr;
begin
  fCCSet := False;
  EmitLn(Format('or %2:s, %1:s, %0:s', [RegisterName, tos, RegisterName]));
  pop;
end;

{---------------------------------------------------------------}
{ XOR Top of Stack with Primary }

procedure TNXCComp.PopXor;
begin
  fCCSet := False;
  EmitLn(Format('xor %2:s, %1:s, %0:s', [RegisterName, tos, RegisterName]));
  pop;
end;


{---------------------------------------------------------------}
{ Left Shift Top of Stack to Primary }

procedure TNXCComp.PopLeftShift;
begin
  fCCSet := False;
  EmitLn(Format('shl %2:s, %1:s, %0:s', [RegisterName, tos, RegisterName]));
  pop;
end;

{---------------------------------------------------------------}
{ Right Shift Top of Stack to Primary }

procedure TNXCComp.PopRightShift;
begin
  fCCSet := False;
  EmitLn(Format('shr %2:s, %1:s, %0:s', [RegisterName, tos, RegisterName]));
  pop;
end;

{---------------------------------------------------------------}
{ Set zero flag based on __D0 value }

procedure TNXCComp.SetZeroCC;
begin
  fCCSet := True;
  EmitLn(Format('tst NEQ, %s, %s',[ZeroFlag, RegisterName]));
end;

function TNXCComp.FunctionReturnType(const name : string) : char;
var
  i : integer;
begin
  Result := #0;
  i := GlobalIdx(name);
  if (i > 0) and (GS_Type[i] = TOK_PROCEDURE) then
    Result := GS_ReturnType[i];
end;

function TNXCComp.ValueIsStringType: boolean;
begin
  Result := IsAPIStrFunc(Value);
  if not Result then
  begin
    Result := (Token = TOK_STRINGLIT) or
              ((Token = TOK_IDENTIFIER) and
               (DataType(Value) = TOK_STRINGDEF));
    if not Result then
      Result := FunctionReturnType(Value) = TOK_STRINGDEF
    else
    begin
      // if we are indexing into the string then it is not really a string type
      if Look = '[' then
        Result := False;
    end;
  end;
end;

function TNXCComp.ValueIsArrayType: boolean;
begin
  Result := IsArrayType(DataType(Value));
end;

function TNXCComp.ValueIsUserDefinedType: boolean;
begin
  Result := DataType(Value) = TOK_USERDEFINEDTYPE;
end;

procedure TNXCComp.CmpHelper(const cc, lhs, rhs: string);
begin
  fCCSet := True;
  EmitLn(Format('cmp %s, %s, %s, %s',[cc, ZeroFlag, lhs, rhs]));
end;

procedure TNXCComp.PopCmpHelper(const cc : string);
begin
  CmpHelper(cc, tos, RegisterName);
  pop;
end;

{---------------------------------------------------------------}
{ Set __zf If Compare was = }

procedure TNXCComp.PopCmpEqual;
begin
  PopCmpHelper('EQ');
end;

{---------------------------------------------------------------}
{ Set __D0 If Compare was != }

procedure TNXCComp.PopCmpNEqual;
begin
  PopCmpHelper('NEQ');
end;

{---------------------------------------------------------------}
{ Set __D0 If Compare was > }

procedure TNXCComp.PopCmpGreater;
begin
  PopCmpHelper('GT');
end;

{---------------------------------------------------------------}
{ Set __D0 If Compare was < }

procedure TNXCComp.PopCmpLess;
begin
  PopCmpHelper('LT');
end;

{---------------------------------------------------------------}
{ Set __D0 If Compare was <= }

procedure TNXCComp.PopCmpLessOrEqual;
begin
  PopCmpHelper('LTEQ');
end;

{---------------------------------------------------------------}
{ Set __D0 If Compare was >= }

procedure TNXCComp.PopCmpGreaterOrEqual;
begin
  PopCmpHelper('GTEQ');
end;

{---------------------------------------------------------------}
{ Store Primary to Variable }

procedure TNXCComp.Store(const Name: string);
begin
  CheckNotProc(Name);
  EmitLn(Format('mov %s, %s',[GetDecoratedIdent(Name), RegisterName]));
end;

procedure TNXCComp.StoreString(const Name : string);
begin
  CheckNotProc(Name);
  EmitLn(Format('mov %s, %s', [GetDecoratedIdent(Name), StrBufName]));
end;

{---------------------------------------------------------------}
{ Branch Unconditional  }

procedure TNXCComp.Branch(L: string);
begin
  EmitLn('jmp ' + L);
end;

{---------------------------------------------------------------}
{ Branch False }

procedure TNXCComp.BranchFalse(L: string);
begin
  // if the condition code has not been set then set it manually
  if not fCCSet then
    SetZeroCC;
  EmitLn(Format('brtst EQ, %s, %s', [L, ZeroFlag]));
end;

{---------------------------------------------------------------}
{ Branch True }

procedure TNXCComp.BranchTrue(L: string);
begin
  // if the condition code has not been set then set it manually
  if not fCCSet then
    SetZeroCC;
  EmitLn(Format('brtst NEQ, %s, %s', [L, ZeroFlag]));
end;

{--------------------------------------------------------------}
{ Write Header Info }

procedure TNXCComp.Header;
begin
  // do nothing
end;

{--------------------------------------------------------------}
{ Write Trailer Info }

procedure TNXCComp.Trailer;
var
  tmp : TStrings;
begin
  DoCompilerStatusChange(sNXCGenerateTrailer);
  CheckForMain;
  // handle stack variables
  tmp := TStringList.Create;
  try
    tmp.AddStrings(NBCSource);
    NBCSource.Clear;
    // emit struct decls
    NBCSource.AddStrings(fStructDecls);
    EmitLnNoTab('dseg segment');
    // structures
    EmitNXCRequiredStructs;
    EmitLn('__SSMArgs TNXCSetScreenMode');
    EmitLn('__SPTArgs TNXCSoundPlayTone');
    EmitLn('__SPFArgs TNXCSoundPlayFile');
    // mutexes
    EmitLn('__SSMArgsMutex mutex');
    EmitLn('__SPTArgsMutex mutex');
    EmitLn('__SPFArgsMutex mutex');

    EmitRegisters;
    EmitStackVariables;

    EmitLnNoTab('dseg ends');
    NBCSource.AddStrings(tmp);
  finally
    tmp.Free;
  end;
end;

{--------------------------------------------------------------}
{ Write the Prolog }

procedure TNXCComp.Prolog(const name : string; bIsSub : boolean);
begin
  if bIsSub then
  begin
    if AmInlining then
    begin
      fCurrentInlineFunction := fInlineFunctions.Add;
      fCurrentInlineFunction.Name := name;
    end
    else
      EmitLnNoTab('subroutine ' + name);
  end
  else
    EmitLnNoTab('thread ' + name);
end;

{--------------------------------------------------------------}
{ Write the Epilog }

procedure TNXCComp.Epilog(bIsSub : boolean);
begin
  if bIsSub then
  begin
    if AmInlining then
    begin
      DecrementInlineDepth;
//      dec(fInlineDepth);
//      fInlining := False;
    end
    else
    begin
      EmitLn('return');
      EmitLnNoTab('ends');
    end;
  end
  else
    EmitLnNoTab('endt');
  EmitLnNoTab('');
end;

{--------------------------------------------------------------}
{ Allocate Storage for a Static variable }

procedure TNXCComp.AllocateHelper(const Name, aVal, Val, tname: string; dt : char);
begin
  case dt of
    TOK_CHARDEF,
    TOK_ARRAYCHARDEF..TOK_ARRAYCHARDEF4 :
      EmitLn(Format('%s sbyte%s %s', [Name, aVal, Val]));
    TOK_SHORTDEF,
    TOK_ARRAYSHORTDEF..TOK_ARRAYSHORTDEF4  :
      EmitLn(Format('%s sword%s %s', [Name, aVal, Val]));
    TOK_LONGDEF,
    TOK_ARRAYLONGDEF..TOK_ARRAYLONGDEF4   :
      EmitLn(Format('%s sdword%s %s', [Name, aVal, Val]));
    TOK_BYTEDEF,
    TOK_ARRAYBYTEDEF..TOK_ARRAYBYTEDEF4   :
      EmitLn(Format('%s byte%s %s', [Name, aVal, Val]));
    TOK_USHORTDEF,
    TOK_ARRAYUSHORTDEF..TOK_ARRAYUSHORTDEF4 :
      EmitLn(Format('%s word%s %s', [Name, aVal, Val]));
    TOK_ULONGDEF,
    TOK_ARRAYULONGDEF..TOK_ARRAYULONGDEF4  :
      EmitLn(Format('%s dword%s %s', [Name, aVal, Val]));
    TOK_MUTEXDEF  : EmitLn(Format('%s mutex', [Name]));
    TOK_FLOATDEF,
    TOK_ARRAYFLOAT..TOK_ARRAYFLOAT4  :
      EmitLn(Format('%s float%s %s', [Name, aVal, Val]));
    TOK_STRINGDEF : EmitLn(Format('%s byte[] %s', [Name, Val]));
    TOK_ARRAYSTRING..TOK_ARRAYSTRING4  :
      EmitLn(Format('%s byte[]%s %s', [Name, aVal, Val]));
    TOK_USERDEFINEDTYPE,
    TOK_ARRAYUDT..TOK_ARRAYUDT4 :
      EmitLn(Format('%s %s%s %s', [Name, tname, aVal, Val]));
  else
    EmitLn(Format('%s sword %s', [Name, Val]));
  end;
end;

procedure TNXCComp.Allocate(const Name, aVal, Val, tname: string; dt : char);
//var
//  oldInlining : boolean;
begin
  if (dt in [TOK_FLOATDEF, TOK_ARRAYFLOAT..TOK_ARRAYFLOAT4]) and
     (FirmwareVersion < MIN_FW_VER2X) then
    AbortMsg(sFloatNotSupported);
  // 2007-07-05 JCH:
  // changed this function to perform no code generation of variable
  // declarations whatsoever if the current function is marked
  // as inline.
  // Instead all the local variable and parameter information is gathered
  // in data structures to be output at the point of the first call of
  // the inline function on a per CALLER basis (i.e., once per caller)
  // the variables will be decorated at that point with the CALLER name
  // and an indication that these are inline variables.
  // For each local variable and function parameter stored in the
  // data structures for a particular inline function the body of the
  // inline function code will be processed and any matching tokens
  // (i.e., the names of these variables) will be replaced with the
  // decorated version of the local variable or function parameter name
  if AmInlining then Exit;
  // variables are not output within inline functions
//  oldInlining := fInlining;
  try
//    fInlining := False;
    EmitLnNoTab('dseg segment');
    AllocateHelper(Name, aVal, Val, tname, dt);
    EmitLnNoTab('dseg ends');
  finally
//    fInlining := oldInlining;
  end;
end;

{---------------------------------------------------------------}
{ Parse and Translate a Math Factor with Leading NOT }

procedure TNXCComp.NotNumericFactor;
begin
  if Token = '~' then begin
    Next;
    NumericFactor;
    Complement;
  end
  else
    NumericFactor;
end;

{---------------------------------------------------------------}
{ Parse and Translate a Math Factor }

procedure TNXCComp.NumericFactor;
var
  savedtoken, rdt : char;
  savedvalue : string;
begin
  if Token = TOK_OPENPAREN then begin
    OpenParen;
//    Next;
    BoolExpression;
    CloseParen;
  end
  else begin
    savedtoken := Token;
    savedvalue := Value;
    // JCH fix bug where function call with whitespace between function name
    // and open paren was causing a compiler error. (2007-12-10)
    if (savedtoken = TOK_IDENTIFIER) and (DataType(savedvalue) = TOK_PROCEDURE) then
    begin
      rdt := FunctionReturnType(savedvalue);
      if (rdt <> #0) and (rdt <> TOK_STRINGDEF) then
        DoCall(savedvalue)
      else
        AbortMsg(sInvalidReturnType);
    end
    else
    begin
      Next;
      case savedtoken of
        TOK_IDENTIFIER : begin
          if Token = '[' then
          begin
            fArrayIndexStack.Clear;
//            DoArrayIndex(DataType(fLHSName), fLHSName, savedvalue);
//            DoArrayIndex(ArrayBaseType(DataType(savedvalue)), fLHSName, savedvalue);
            DoNewArrayIndex(DataType(savedvalue), savedvalue, fLHSName);
          end
          else if ((Token = '+') and (Look = '+')) or
                  ((Token = '-') and (Look = '-')) then
          begin
            // increment/decrement
            LoadVar(savedvalue);
            if Token = '+' then
              StoreInc(savedvalue, 1)
            else
              StoreDec(savedvalue, 1);
            Next;
            Next;
          end
          else if savedvalue = 'true' then
            LoadConst('1')
          else if savedvalue = 'false' then
            LoadConst('0')
          else if IsAPIFunc(savedvalue) then
          begin
            DoCallAPIFunc(savedvalue);
          end
          else if IsArrayType(fLHSDataType) then
          begin
            rdt := DataType(savedvalue);
            if not TypesAreCompatible(fLHSDataType, rdt) then
              AbortMsg(sDatatypesNotCompatible)
            else
              EmitLn(Format('mov %s, %s', [GetDecoratedIdent(fLHSName), GetDecoratedIdent(savedvalue)]));
          end
          else if fLHSDataType = TOK_USERDEFINEDTYPE then
          begin
            if GetUDTType(fLHSName) <> GetUDTType(savedvalue) then
              AbortMsg(sUDTNotEqual)
            else
              EmitLn(Format('mov %s, %s', [GetDecoratedIdent(fLHSName), GetDecoratedIdent(savedvalue)]));
          end
          else
            LoadVar(savedvalue);
        end;
        TOK_NUM, TOK_HEX : begin
          LoadConst(savedvalue);
        end;
        '-' : begin
          if Token = TOK_NUM then
          begin
            LoadConst(savedvalue+value);
            Next;
          end
          else
            Expected(sMathFactor);
        end;
      else
        Expected(sMathFactor);
      end;
    end;
  end;
end;

{--------------------------------------------------------------}
{ Recognize and Translate a Multiply }

procedure TNXCComp.Multiply;
begin
  Next;
  NotNumericFactor;
  PopMul;
end;

{-------------------------------------------------------------}
{ Recognize and Translate a Divide }

procedure TNXCComp.Divide;
begin
  Next;
  NotNumericFactor;
  PopDiv;
end;

{-------------------------------------------------------------}
{ Recognize and Translate a Module }

procedure TNXCComp.Modulo;
begin
  Next;
  NotNumericFactor;
  PopMod;
end;

{---------------------------------------------------------------}
{ Parse and Translate a Math Term }

procedure TNXCComp.Term;
begin
  NotNumericFactor;
  while IsMulop(Token) do begin
    PushPrim;
    case Token of
      '*': Multiply;
      '/': Divide;
      '%': Modulo;
    end;
  end;
end;

{--------------------------------------------------------------}
{ Recognize and Translate an Add }

procedure TNXCComp.Add;
begin
  Next;
  Term;
  PopAdd;
end;

{-------------------------------------------------------------}
{ Recognize and Translate a Subtract }

procedure TNXCComp.Subtract;
begin
  Next;
  Term;
  PopSub;
end;

{---------------------------------------------------------------}
{ Parse and Translate an Expression }

procedure TNXCComp.Expression;
var
  prev, lenVal : integer;
  oldExpStr, optExp : string;
begin
  fExpStrHasVars := False;
  // 2009-04-09 JCH:
  // Store the old expression string and restore it at the end of this routine
  // so that recursive optimizations do not destroy the previous level of
  // the expression.  This fixes the bug caused by commenting out
  // "and not (fExpStr[1] in ['+', '-'])" in the OptimizeExpression function
  // below.  Without this, an expression like x = MyFunc(233)+10; was being
  // optimized to x = 10;
  oldExpStr := fExpStr;
  try
    // set the old expression to be everything except for the first token in
    // the new expression (aka "Value").
    lenVal := Length(Value);
    Delete(oldExpStr, Length(oldExpStr)-lenVal+1, lenVal);
    // now start our new expression with the current token
    fExpStr := Value;
    prev := NBCSource.Count;
    if IncrementOrDecrement then
    begin
      // pre-increment or pre-decrement
      DoPreIncOrDec(true);
    end
    else
    begin
      if IsAddOp(Token) then
        ClearReg
      else
        Term;
      while IsAddop(Token) do begin
        PushPrim;
        case Token of
          '+': Add;
          '-': Subtract;
        end;
      end;
      optExp := OptimizeExpression(prev);
    end;
  finally
    fExpStr := oldExpStr + optExp + Value;
  end;
end;

function TNXCComp.OptimizeExpression(const idx: integer) : string;
begin
  fLastExpressionOptimizedToConst := False;
  System.Delete(fExpStr, Length(fExpStr), 1);
  Result := fExpStr;
  if (OptimizeLevel >= 1) and (NBCSource.Count > (idx+1)) and
     not fExpStrHasVars then
  begin
    // 2009-03-18 JCH: I do not recall why I added the check for
    // + and - as the first character of an expression
    // I haven't been able to detect any harm in removing this check but
    // it could be something very obscure that will come up again

    // 2009-04-09 JCH: See my comment in the Expression function above.
    // The commented-out code was preventing a bug that had far too many
    // lines of code being removed if an expression ended in +nnn or -nnn.

    if (fExpStr <> '') {and not (fExpStr[1] in ['+', '-'])} then
    begin
      fCalc.SilentExpression := fExpStr;
      if not fCalc.ParserError then
      begin
        if StatementType = stFloat then
          fExpStr := NBCFloatToStr(fCalc.Value)
        else
          fExpStr := IntToStr(Trunc(fCalc.Value));
        Result := fExpStr;
        // in theory, we can replace all the lines between idx and
        // NBCSource.Count with one line
        while NBCSource.Count > idx do
          NBCSource.Delete(NBCSource.Count-1);
        LoadConst(fExpStr);
        fExpStr := '';
        fLastExpressionOptimizedToConst := True;
      end;
    end;
  end;
end;

{---------------------------------------------------------------}
{ Parse and Translate a String Expression }

procedure TNXCComp.StringConcatAssignment(const Name: string);
begin
  if Look = '=' then
  begin
    Next; // move to '='
    Next; // move to next token
    StringExpression(Name, True);
    StoreString(Name);
  end
  else
    AbortMsg(sInvalidStringAssign);
end;

function TNXCComp.GetDecoratedIdent(const val : string) : string;
var
  i : integer;
begin
  Result := val;
  if not AlreadyDecorated(val) then
  begin
    case WhatIs(val) of
      stParam :
        Result := ApplyDecoration(fCurrentThreadName, val, 0);
      stLocal : begin
        // apply decoration at greatest nesting level and iterate
        // until we find the right value.
        for i := fNestingLevel downto 0 do
        begin
          Result := ApplyDecoration(fCurrentThreadName, val, i);
          if IsLocal(Result) then
            break;
        end;
      end;
    else
      Result := val;
    end;
  end;
end;

function TNXCComp.GetDecoratedValue : string;
begin
  Result := GetDecoratedIdent(Value);
end;

procedure TNXCComp.StringExpression(const Name : string; bAdd : boolean);
var
  asmStr, val : string;
  dt : char;
begin
  fCCSet := False;
  if Look = TOK_OPENPAREN then
  begin
    // a function call that returns a string
    val := Value;
    if DataType(val) = TOK_PROCEDURE then
    begin
      if FunctionReturnType(val) = TOK_STRINGDEF then
        DoCall(val)
      else
        Expected(sStringReturnValue);
    end
    else
    begin
      Next; // move to TOK_OPENPAREN
      StringFunction(val);
    end;
    if bAdd then
      asmStr := Format('strcat %s, %s, %s', [StrBufName, GetDecoratedIdent(Name), StrRetValName])
    else
      asmStr := Format('mov %s, %s', [StrBufName, StrRetValName]);
    EmitLn(asmStr);
  end
  else if Look = '[' then
  begin
    val := Value;
    Next;
    fArrayIndexStack.Clear;
    DoNewArrayIndex(DataType(val), val, StrRetValName);
    if bAdd then
      asmStr := Format('strcat %s, %s, %s', [StrBufName, GetDecoratedIdent(Name), StrRetValName])
    else
      asmStr := Format('mov %s, %s', [StrBufName, StrRetValName]);
    EmitLn(asmStr);
  end
  else if Value = 'asm' then
  begin
    // asm
    Next;
    dt := #0;
    DoAsm(dt);
    fSemiColonRequired := True;
    if dt <> TOK_STRINGDEF then
      Expected(sStringReturnValue)
    else
    begin
      if bAdd then
        asmStr := Format('strcat %s, %s, %s', [StrBufName, GetDecoratedIdent(Name), StrRetValName])
      else
        asmStr := Format('mov %s, %s', [StrBufName, StrRetValName]);
      EmitLn(asmStr);
    end;
  end
  else
  begin
    CheckString;
    if bAdd then
      asmStr := Format('strcat %s, %s, %s', [StrBufName, GetDecoratedIdent(Name), GetDecoratedValue])
    else
    begin
      if Look = TOK_SEMICOLON then
        asmStr := Format('mov %s, %s', [StrBufName, GetDecoratedValue])
      else
        asmStr := Format('strcat %s, %s', [StrBufName, GetDecoratedValue]);
    end;
    Next;
    while Token = '+' do begin
      Next;
      CheckString;
      asmStr := asmStr + ', ' + GetDecoratedValue;
      Next;
    end;
    EmitLn(asmStr);
  end;
end;

{---------------------------------------------------------------}
{ Recognize and Translate a Relational "Equals" }

procedure TNXCComp.Equal;
begin
  Next; // two equal signs of equality comparison
  MatchString('=');
  Expression;
  PopCmpEqual;
  StoreZeroFlag;
end;

procedure TNXCComp.EqualArrayOrUDT(const lhs : string);
var
  rhs : string;
begin
  Next; // two equal signs of equality comparison
  MatchString('=');
  CheckIdent;
  rhs := Value;
  Next;
  CmpHelper('EQ', lhs, GetDecoratedIdent(rhs));
  StoreZeroFlag;
end;

procedure TNXCComp.LessArrayOrUDT(const lhs : string);
var
  rhs : string;
begin
  Next;
  case Token of
    '=' : begin
      Next;
      CheckIdent;
      rhs := Value;
      Next;
      CmpHelper('LTEQ', lhs, GetDecoratedIdent(rhs));
    end;
    '>' : begin
      Next;
      CheckIdent;
      rhs := Value;
      Next;
      CmpHelper('NEQ', lhs, GetDecoratedIdent(rhs));
    end;
  else
    CheckIdent;
    rhs := Value;
    Next;
    CmpHelper('LT', lhs, GetDecoratedIdent(rhs));
  end;
  StoreZeroFlag;
end;

procedure TNXCComp.GreaterArrayOrUDT(const lhs: string);
var
  rhs : string;
begin
  Next;
  case Token of
    '=' : begin
      Next;
      CheckIdent;
      rhs := Value;
      Next;
      CmpHelper('GTEQ', lhs, GetDecoratedIdent(rhs));
    end;
  else
    CheckIdent;
    rhs := Value;
    Next;
    CmpHelper('GT', lhs, GetDecoratedIdent(rhs));
  end;
  StoreZeroFlag;
end;

procedure TNXCComp.NEqualArrayOrUDT(const lhs: string);
var
  rhs : string;
begin
  Next;
  if Token = '=' then
  begin
    Next;
    CheckIdent;
    rhs := Value;
    Next;
    CmpHelper('NEQ', lhs, GetDecoratedIdent(rhs));
    StoreZeroFlag;
  end
  else
    Expected('"!="');
end;

procedure TNXCComp.EqualString;
begin
  Next; // two equal signs of equality comparison
  MatchString('=');
  StringExpression('');
  CmpHelper('EQ', StrTmpBufName, StrBufName);
  StoreZeroFlag;
end;

procedure TNXCComp.LessString;
begin
  Next;
  case Token of
    '=' : begin
      Next;
      StringExpression('');
      CmpHelper('LTEQ', StrTmpBufName, StrBufName);
    end;
    '>' : begin
      Next;
      StringExpression('');
      CmpHelper('NEQ', StrTmpBufName, StrBufName);
    end;
  else
    StringExpression('');
    CmpHelper('LT', StrTmpBufName, StrBufName);
  end;
  StoreZeroFlag;
end;

procedure TNXCComp.GreaterString;
begin
  Next;
  case Token of
    '=' : begin
      Next;
      StringExpression('');
      CmpHelper('GTEQ', StrTmpBufName, StrBufName);
    end;
  else
    StringExpression('');
    CmpHelper('GT', StrTmpBufName, StrBufName);
  end;
  StoreZeroFlag;
end;

procedure TNXCComp.NEqualString;
begin
  Next;
  if Token = '=' then
  begin
    Next;
    StringExpression('');
    CmpHelper('NEQ', StrTmpBufName, StrBufName);
    StoreZeroFlag;
  end
  else
    Expected('"!="');
end;

{---------------------------------------------------------------}
{ Recognize and Translate a Relational "Less Than or Equal" }

procedure TNXCComp.LessOrEqual;
begin
  Next;
  Expression;
  PopCmpLessOrEqual;
  StoreZeroFlag;
end;

{---------------------------------------------------------------}
{ Recognize and Translate a Relational "Not Equals" }

procedure TNXCComp.NotEqual;
begin
  Next;
  Expression;
  PopCmpNEqual;
  StoreZeroFlag;
end;

{---------------------------------------------------------------}
{ Recognize and Translate a left shift }

procedure TNXCComp.LeftShift;
begin
  Next;
  Expression;
  PopLeftShift;
end;

{---------------------------------------------------------------}
{ Recognize and Translate a right shift }

procedure TNXCComp.RightShift;
begin
  Next;
  Expression;
  PopRightShift;
end;

{---------------------------------------------------------------}
{ Recognize and Translate a Relational "Less Than" }

procedure TNXCComp.Less;
begin
  Next;
  case Token of
    '=' : LessOrEqual;
    '>' : NotEqual;
    '<' : LeftShift;
  else
    Expression;
    PopCmpLess;
    StoreZeroFlag;
  end;
end;

{---------------------------------------------------------------}
{ Recognize and Translate a Relational "Greater Than" }

procedure TNXCComp.Greater;
begin
  Next;
  case Token of
    '=' : begin
      Next;
      Expression;
      PopCmpGreaterOrEqual;
      StoreZeroFlag;
    end;
    '>' : begin
      RightShift;
    end;
  else
    Expression;
    PopCmpGreater;
    StoreZeroFlag;
  end;
end;

procedure TNXCComp.NEqual;
begin
  Next;
  if Token = '=' then
    NotEqual
  else
    Expected('"!="');
end;

procedure TNXCComp.NumericRelation;
begin
  Expression;
  if IsRelop(Token) then begin
    PushPrim;
    case Token of
      '=': Equal;
      '<': Less;
      '>': Greater;
      '!': NEqual;
    end;
  end;
end;

{---------------------------------------------------------------}
{ Parse and Translate a Relation }

procedure TNXCComp.Relation;
var
  lhs : string;
//  dt : char;
begin
  if ValueIsStringType then
  begin
    if Look <> '[' then
    begin
      StringExpression('');
      if IsRelop(Token) then begin
        // copy to temp string buffer
        EmitLn(Format('mov %s, %s', [StrTmpBufName, StrBufName]));
        case Token of
          '=': EqualString;
          '<': LessString;
          '>': GreaterString;
          '!': NEqualString;
        end;
      end
      else
        LoadConst('1'); // a string expression is "true"
    end
    else
      NumericRelation;
  end
  else if (Token = TOK_IDENTIFIER) and
          (ValueIsArrayType or ValueIsUserDefinedType) then
  begin
    if Look = '[' then
    begin
{
      dt := RemoveArrayDimension(DataType(Value));
      if IsArrayType(dt) then
        AbortMsg(sInvalidArrayExpr)
      else
}
        NumericRelation;
    end
    else
    begin
      // only variables are allowed here - no expressions
      CheckIdent;
      lhs := GetDecoratedIdent(Value);
      Next;
      if IsRelop(Token) then begin
        case Token of
          '=': EqualArrayOrUDT(lhs);
          '<': LessArrayOrUDT(lhs);
          '>': GreaterArrayOrUDT(lhs);
          '!': NEqualArrayOrUDT(lhs);
        end;
      end
      else
      begin
        // is the left hand side an array, udt or a scalar?
        if IsArrayType(fLHSDataType) or IsUDT(fLHSDataType) then
        begin
          // do something clever
        end
        else
          LoadConst('1'); // an array or UDT expression is "true"
      end;
    end;
  end
  else
  begin
    NumericRelation;
  end;
end;

procedure TNXCComp.StoreZeroFlag;
begin
  EmitLn(Format('mov %s, %s', [RegisterName, ZeroFlag]));
end;

{---------------------------------------------------------------}
{ Parse and Translate a Boolean Factor with Leading NOT }

procedure TNXCComp.NotFactor;
begin
  if Token = '!' then begin
    Next;
    Relation;
    NotIt;
  end
  else
    Relation;
end;

{---------------------------------------------------------------}
{ Parse and Translate a Boolean Term }

procedure TNXCComp.BoolTerm;
var
  L : string;
  bLogicalAnd : boolean;
begin
  L := NewLabel;
  NotFactor;
  while Token = '&' do begin
    bLogicalAnd := False;
    Next;
    if Token = '&' then
    begin
      Next;
      bLogicalAnd := True;
    end;
    if bLogicalAnd then
    begin
      // convert D0 to boolean value if necessary
      if not fCCSet then
      begin
        SetZeroCC;
        StoreZeroFlag;
      end;
      BranchFalse(L);
    end;
    PushPrim;
    NotFactor;
    if bLogicalAnd and not fCCSet then
    begin
      // convert D0 to boolean value if necessary
      SetZeroCC;
      StoreZeroFlag;
    end;
    PopAnd;
  end;
  PostLabel(L);
end;

{---------------------------------------------------------------}
{ Parse and Translate a Boolean Expression }

procedure TNXCComp.BoolExpression;
var
  L1, L2 : string;
begin
  fCCSet := False;
  BoolSubExpression;
  while Token = '?' do begin
    // we are parsing a ?: expression
    Next;
    L1 := NewLabel;
    L2 := NewLabel;
    BranchFalse(L1);
    BoolExpression;
    Branch(L2);
    MatchString(':');
    PostLabel(L1);
    BoolExpression;
    PostLabel(L2);
  end;
//  ResetStatementType;
end;

procedure TNXCComp.BoolSubExpression;
var
  L : string;
  bLogicalOr : boolean;
begin
  L := NewLabel;
  BoolTerm;
  while IsOrOp(Token) do begin
    case Token of
      '|':
      begin
        bLogicalOr := False;
        Next;
        if Token = '|' then
        begin
          Next;
          bLogicalOr := True;
        end;
        if bLogicalOr then
        begin
          // convert D0 to boolean value if necessary
          if not fCCSet then
          begin
            SetZeroCC;
            StoreZeroFlag;
          end;
          BranchTrue(L);
        end;
        PushPrim;
        BoolTerm;
        if bLogicalOr and not fCCSet then
        begin
          // convert D0 to boolean value if necessary
          SetZeroCC;
          StoreZeroFlag;
        end;
        PopOr;
      end;
      '^':
      begin
        Next;
        PushPrim;
        BoolTerm;
        PopXor;
      end;
    end;
  end;
  PostLabel(L);
end;

function TNXCComp.GetParamName(procname: string; idx: integer): string;
var
  i : integer;
begin
  Result := '';
  i := fFuncParams.IndexOf(procname, idx);
  if i <> -1 then
    Result := ApplyDecoration(procname, fFuncParams[i].Name, 0);
end;

function DataTypeToParamType(ptype : char) : TFuncParamType;
begin
  case ptype of
    TOK_ARRAYCHARDEF..TOK_ARRAYCHARDEF4, TOK_CHARDEF : Result := fptSBYTE;
    TOK_ARRAYSHORTDEF..TOK_ARRAYSHORTDEF4, TOK_SHORTDEF : Result := fptSWORD;
    TOK_ARRAYLONGDEF..TOK_ARRAYLONGDEF4, TOK_LONGDEF : Result := fptSLONG;
    TOK_ARRAYBYTEDEF..TOK_ARRAYBYTEDEF4, TOK_BYTEDEF : Result := fptUBYTE;
    TOK_ARRAYUSHORTDEF..TOK_ARRAYUSHORTDEF4, TOK_USHORTDEF : Result := fptUWORD;
    TOK_ARRAYULONGDEF..TOK_ARRAYULONGDEF4, TOK_ULONGDEF : Result := fptULONG;
    TOK_ARRAYUDT..TOK_ARRAYUDT4, TOK_USERDEFINEDTYPE : Result := fptUDT;
    TOK_ARRAYSTRING..TOK_ARRAYSTRING4, TOK_STRINGDEF : Result := fptString;
    TOK_ARRAYFLOAT..TOK_ARRAYFLOAT4, TOK_FLOATDEF : Result := fptFloat;
    TOK_MUTEXDEF : Result := fptMutex;
  else
    Result := fptUBYTE;
  end;
end;

procedure TNXCComp.AddFunctionParameter(pname, varname, tname: string; idx: integer;
  ptype : char; bIsConst, bIsRef, bIsArray : boolean; aDim : integer);
begin
  // if this function is not an inline function then we will automagically
  // convert any Const not Ref parameter into a Const Ref parameter
  if bIsConst and not bIsRef and not AmInlining then
    bIsRef := True; // convert to const ref type
(*
  // add a check here for a parameter that is const but not reference
  // when we are not inlining
  if bIsConst and not bIsRef and not AmInlining and (ptype in NonAggregateTypes) then
    ReportProblem(linenumber, CurrentFile, sConstNotInline, false);
//    AbortMsg(sConstNotInline);
*)
  with fFuncParams.Add do
  begin
    ProcName       := pname;
    Name           := varname;
    ParamType      := DataTypeToParamType(ptype);
    ParamTypeName  := tname;
    ParamIndex     := idx;
    IsArray        := bIsArray;
    IsConstant     := bIsConst;
    IsReference    := bIsRef;
    ArrayDimension := aDim;
    FuncIsInline   := AmInlining;
  end;
end;

function TNXCComp.FunctionParameterCount(const name : string) : integer;
begin
  Result := fFuncParams.ParamCount(name);
end;

function TNXCComp.FunctionParameterType(const name: string;
  idx: integer): char;
var
  i : integer;
begin
  Result := #0;
  i := fFuncParams.IndexOf(name, idx);
  if i <> -1 then
    Result := fFuncParams[i].ParameterDataType;
end;

function TNXCComp.FunctionParameterTypeName(const name: string;
  idx: integer): string;
var
  i : integer;
begin
  Result := '';
  i := fFuncParams.IndexOf(name, idx);
  if i <> -1 then
    Result := fFuncParams[i].ParamTypeName;
end;

function TNXCComp.FunctionParameterIsConstant(const name: string;
  idx: integer): boolean;
var
  i : integer;
begin
  Result := False;
  i := fFuncParams.IndexOf(name, idx);
  if i <> -1 then
    Result := fFuncParams[i].IsConstant;
end;

function TNXCComp.GetFunctionParam(const procname : string; idx : integer) : TFunctionParameter;
var
  i : integer;
begin
  Result := nil;
  i := fFuncParams.IndexOf(procname, idx);
  if i <> -1 then
    Result := fFuncParams[i];
end;

function TNXCComp.AdvanceToNextParam : string;
begin
  Result := '';
  Next;
  while not ((Token in [TOK_CLOSEPAREN, TOK_COMMA]) or endofallsource) do
  begin
    Result := Result + Value;
    Next;
  end;
  Result := Trim(Result);
end;

procedure TNXCComp.DoCall(procname : string);
var
  protocount, acount, idx, i : integer;
  dt, rdt, pdt, oldLHSDT : char;
  parname, parvalue, junk, oldLHSName : string;
  bError : boolean;
  fp : TFunctionParameter;
  fInputs : TStrings;
  bFunctionIsInline, bSafeCall : boolean;
  inlineFunc : TInlineFunction;
begin
  fUDTOnStack := ''; // by default there is no UDT/Array on the return stack
  if fFunctionNameCallStack.IndexOf(procname) = -1 then
  begin
    fFunctionNameCallStack.Add(procname);
    try
      // is procname the same as the current thread name
      // (i.e., is this a recursive function call)?
      if procname = fCurrentThreadName then
        AbortMsg(sRecursiveNotAllowed);
      // is procname an inline function?
      idx := fInlineFunctions.IndexOfName(procname);
      bFunctionIsInline := idx <> -1;
//      if AmInlining and bFunctionIsInline then
//        AbortMsg(sRecursiveInlineError);
      if bFunctionIsInline then
      begin
        inlineFunc := fInlineFunctions[idx];
        if inlineFunc.Parameters.Count = 0 then
          inlineFunc.Parameters := fFuncParams;
        inlineFunc.CurrentCaller := fCurrentThreadName;
      end
      else
        inlineFunc := nil;
      fInputs := TStringList.Create;
      try
        acount := 0;
        protocount := FunctionParameterCount(procname);
        Next;
        bError := Value <> TOK_OPENPAREN;
        if not bError then
          OpenParen
        else
          Expected('"("');
        if bFunctionIsInline and
           (inlineFunc.Callers.IndexOf(fCurrentThreadName) = -1) then
        begin
          inlineFunc.Callers.Add(fCurrentThreadName);
          // first call in this thread to this inline function
          // output all parameters and local variables with decoration
          EmitInlineParametersAndLocals(inlineFunc);
          // make sure the very first call to this inline function
          // by this thread doesn't get optimized out
          fExpStr := '__DO_NOT_OPTIMIZE!@#$%_';
        end;
        bSafeCall := GlobalUsesSafeCall(procname);
        // acquire the mutex
        if not bFunctionIsInline and (SafeCalls or bSafeCall) then
          EmitLn(Format('acquire __%s_mutex', [procname]));
        rdt := FunctionReturnType(procname);
        while not bError and (Token <> TOK_CLOSEPAREN) do begin
          if acount >= protocount then
          begin
            AbortMsg(sTooManyArgs);
            bError := True;
          end;
          fp := GetFunctionParam(procname, acount);
          if Assigned(fp) then
          begin
            dt := FunctionParameterType(procname, acount);
            parname := GetParamName(procname, acount);
            if bFunctionIsInline then
              parname := InlineName(fCurrentThreadName, parname);
            // now process the current parameter
            oldLHSDT := fLHSDataType;
            oldLHSName := fLHSName;
            fLHSDataType := dt;
            fLHSName     := parname;
            try
              // reference types cannot take expressions
              // mutex, user defined types, and array types cannot take expressions
              if fp.IsVarReference or {fp.IsArray or}
                 (fp.ParamType in [{fptUDT, }fptMutex]) then
              begin
                CheckIdent;
                parvalue := GetDecoratedValue;
                pdt := DataType(parvalue);
                if fp.IsArray then
                begin
                  if not IsArrayType(pdt) then
                    Expected(sArrayDatatype);
                end;
                fInputs.AddObject(parvalue, fp);
                EmitLn(Format('mov %s, %s', [parname, parvalue]));
                junk := AdvanceToNextParam;
                if junk <> '' then
                  AbortMsg(sExpNotSupported)
                else
                  CheckTypeCompatibility(fp, pdt, parvalue);
              end
  // beginning of addition for handling expressions for UDT and array parameters
              else if fp.IsArray or (fp.ParamType = fptUDT) then
              begin
                if IsArrayType(dt) then
                begin
                  DoArrayAssignValue(parname, '', dt);
                end
                else if dt = TOK_USERDEFINEDTYPE then
                begin
                  GetAndStoreUDT(parname);
                end;
              end
  // end of addition for handling expressions for UDT and array parameters
  // beginning of previously commented out block
              else if fp.IsConstant and not fp.IsReference then
              begin
                // must be a number (or constant expression) or a string literal
                if dt = TOK_STRINGDEF then
                begin
                  parvalue := Value;
                  CheckStringConst;
                  fp.ConstantValue := parvalue;
                  fInputs.AddObject(parvalue, fp);
                  if bFunctionIsInline then
                  begin
                    i := inlineFunc.Parameters.IndexOf(inlineFunc.Name, acount);
                    if i <> -1 then
                    begin
                      inlineFunc.Parameters[i].Assign(fp);
                    end;
                  end;
                  EmitLn(Format('mov %s, %s', [parname, parvalue]));
                  Next;
                end
                else if dt <> #0 then
                begin
                  // collect tokens to TOK_CLOSEPAREN or TOK_COMMA
                  parvalue := Value;
                  while not (Look in [TOK_CLOSEPAREN, TOK_COMMA]) or endofallsource do begin
                    Next;
                    parvalue := parvalue + Value;
                  end;
                  Next;
                  fCalc.SilentExpression := GetValueOf(parvalue);
                  if not fCalc.ParserError then
                  begin
                    parvalue := NBCFloatToStr(fCalc.Value);
                    fCalc.SetVariable(parname, fCalc.Value);
                    fp.ConstantValue := parvalue;
                    fInputs.AddObject(parvalue, fp);
                    if bFunctionIsInline then
                    begin
                      i := inlineFunc.Parameters.IndexOf(inlineFunc.Name, acount);
                      if i <> -1 then
                      begin
                        inlineFunc.Parameters[i].Assign(fp);
                      end;
                    end;
                    EmitLn(Format('mov %s, %s', [parname, parvalue]));
                  end
                  else
                  begin
                    if IsParamConst(parvalue) then
                    begin
                      fp.ConstantValue := ApplyDecoration(fCurrentThreadName, parvalue, 0);
  //                    fp.ConstantValue := parvalue;
                      fInputs.AddObject(parvalue, fp);
                      if bFunctionIsInline then
                      begin
                        i := inlineFunc.Parameters.IndexOf(inlineFunc.Name, acount);
                        if i <> -1 then
                        begin
                          inlineFunc.Parameters[i].Assign(fp);
                        end;
                      end;
                    end
                    else
                    begin
                      fInputs.AddObject('', fp);
                      Expected('constant or constant expression');
                    end;
                  end;
                end;
              end
  // end of previously commented out block
              else
              begin
                fInputs.AddObject('', fp);
                if dt = TOK_STRINGDEF then
                begin
                  StringExpression(parname);
                  EmitLn(Format('mov %s, %s', [parname, StrBufName]));
                end
                else if dt <> #0 then
                begin
                  BoolExpression;
                  EmitLn(Format('mov %s, %s', [parname, RegisterName]));
                end;
              end;
            finally
              fLHSDataType := oldLHSDT;
              fLHSName     := oldLHSName;
            end;
          end;
          inc(acount);
          Scan;
          if Token = TOK_COMMA then begin
            Next;
            Scan;
          end;
        end;
        if protocount > acount then
          AbortMsg(sTooFewParams);
        if Value = TOK_CLOSEPAREN then
        begin
          CloseParen;
          if bFunctionIsInline then
            inlineFunc.Emit(NBCSource)
          else
            EmitLn('call '+procname);
          fCCSet := False;
          for i := 0 to fInputs.Count - 1 do begin
            fp := TFunctionParameter(fInputs.Objects[i]);
            if fp.IsVarReference then begin
              // must copy out the non-const references
              parname := GetParamName(procname, i);
              if bFunctionIsInline then
                parname := InlineName(fCurrentThreadName, parname);
              EmitLn(Format('mov %s, %s', [fInputs[i], parname]));
            end;
          end;
          if rdt = TOK_STRINGDEF then
          begin
            // copy value from subroutine to register
            if bFunctionIsInline then
              EmitLn(Format('mov %s, %s', [StrRetValName, StrBufName(InlineName(fCurrentThreadName, procname))]))
            else
              EmitLn(Format('mov %s, %s', [StrRetValName, StrBufName(procname)]));
          end
          else if IsUDT(rdt) or IsArrayType(rdt) then
          begin
            // tell the compiler that a UDT/Array is on stack
            fUDTOnStack := Format('__result_%s', [procname]);
          end
          else if rdt in NonAggregateTypes then
          begin
            // copy value from subroutine to register
            if rdt = TOK_FLOATDEF then
              StatementType := stFloat
            else if not (rdt in UnsignedIntegerTypes) then
              StatementType := stSigned
            else
              StatementType := stUnsigned;
            if bFunctionIsInline then
              EmitLn(Format('mov %s, %s', [RegisterName, RegisterName(InlineName(fCurrentThreadName, procname))]))
            else
              EmitLn(Format('mov %s, %s', [RegisterName, RegisterName(procname)]));
          end;
          // release the mutex
          if not bFunctionIsInline and (SafeCalls or bSafeCall) then
            EmitLn(Format('release __%s_mutex', [procname]));
        end
        else
          Expected('")"');
      finally
        fInputs.Free;
      end;
    finally
      fFunctionNameCallStack.Delete(fFunctionNameCallStack.Count - 1);
    end;
  end
  else
  begin
    AbortMsg(sNestedCallsError);
  end;
end;

procedure TNXCComp.StoreArray(const name, idx, val : string);
begin
  // move RHS to array[idx] or set array = to RHS
  if idx = '' then
    EmitLn(Format('arrbuild %0:s, %s', [GetDecoratedIdent(name), val]))
  else
    EmitLn(Format('replace %0:s, %0:s, %s, %s', [GetDecoratedIdent(name), idx, val]));
end;

function TNXCComp.RemoveArrayDimension(dt: char): char;
begin
  Result := dt;
  if IsArrayType(dt) then
  begin
    case dt of
      TOK_ARRAYFLOAT     : Result := TOK_FLOATDEF;
      TOK_ARRAYSTRING    : Result := TOK_STRINGDEF;
      TOK_ARRAYUDT       : Result := TOK_USERDEFINEDTYPE;
      TOK_ARRAYCHARDEF   : Result := TOK_CHARDEF;
      TOK_ARRAYSHORTDEF  : Result := TOK_SHORTDEF;
      TOK_ARRAYLONGDEF   : Result := TOK_LONGDEF;
      TOK_ARRAYBYTEDEF   : Result := TOK_BYTEDEF;
      TOK_ARRAYUSHORTDEF : Result := TOK_USHORTDEF;
      TOK_ARRAYULONGDEF  : Result := TOK_ULONGDEF;
    else
      Result := Char(Ord(dt)-1);
    end;
  end
  else if dt = TOK_STRINGDEF then
    Result := TOK_BYTEDEF;
end;

function TNXCComp.AddArrayDimension(dt: char): char;
begin
  case dt of
    TOK_FLOATDEF        : Result := TOK_ARRAYFLOAT;
    TOK_STRINGDEF       : Result := TOK_ARRAYSTRING;
    TOK_USERDEFINEDTYPE : Result := TOK_ARRAYUDT;
    TOK_CHARDEF         : Result := TOK_ARRAYCHARDEF;
    TOK_SHORTDEF        : Result := TOK_ARRAYSHORTDEF;
    TOK_LONGDEF         : Result := TOK_ARRAYLONGDEF;
    TOK_BYTEDEF         : Result := TOK_ARRAYBYTEDEF;
    TOK_USHORTDEF       : Result := TOK_ARRAYUSHORTDEF;
    TOK_ULONGDEF        : Result := TOK_ARRAYULONGDEF;
  else
    if IsArrayType(dt) then
    begin
      Result := Char(Ord(dt)+1);
//      if ArrayBaseType(Result) <> ArrayBaseType(dt) then
//        AbortMsg(sInvalidArrayDim);
    end
    else
      Result := dt;
  end;
end;

procedure TNXCComp.ArrayAssignment(const name : string; dt : char; bIndexed : boolean);
var
  tmp, aval, udType, tmpUDTName : string;
  oldType : char;
  AHV : TArrayHelperVar;
begin
  tmp := '';
  if bIndexed then
  begin
    Next;
    oldType := fLHSDataType;
    try
      fLHSDataType := TOK_LONGDEF;
      BoolExpression;
    finally
      fLHSDataType := oldType;
    end;
    MatchString(']');
    push;
    tmp := tos;
    EmitLn(Format('mov %s, %s', [tmp, RegisterName]));
    dt := RemoveArrayDimension(dt);
    fLHSDataType := RemoveArrayDimension(fLHSDataType);
  end;
  // check for additional levels of indexing
  if (Token = '[') and (IsArrayType(dt) or (dt = TOK_STRINGDEF)) then
  begin
    udType := '';
    if IsUDT(ArrayBaseType(dt)) then
      udType := GetUDTType(name);
    // get a temporary thread-safe variable of the right type
    AHV := fArrayHelpers.GetHelper(fCurrentThreadName, udType, dt);
    try
      aval := AHV.Name;
      if fGlobals.IndexOfName(aval) = -1 then
        AddEntry(aval, dt, udType, '');
      // set the variable to the specified element from previous array
      EmitLn(Format('index %s, %s, %s',[aval, GetDecoratedIdent(name), tmp]));
      // pass its name into the call to ArrayAssignment
      ArrayAssignment(aval, dt, True);
      // store temporary thread-safe variable back into previous array
      StoreArray(name, tmp, aval);
    finally
      fArrayHelpers.ReleaseHelper(AHV);
    end;
  end
  else if (Token = '.') and IsUDT(dt) then // check for struct member notation
  begin
    // set the variable to the specified element from previous array
    udType := '';
    if IsUDT(ArrayBaseType(dt)) then
      udType := GetUDTType(name);
    // get a temporary thread-safe variable of the right type
    AHV := fArrayHelpers.GetHelper(fCurrentThreadName, udType, dt);
    try
      aval := AHV.Name;
      if fGlobals.IndexOfName(aval) = -1 then
        AddEntry(aval, dt, udType, '');
      // set the variable to the specified element from previous array
      EmitLn(Format('index %s, %s, %s',[aval, GetDecoratedIdent(name), tmp]));
      // process dots
      tmpUDTName := aval;
      tmpUDTName := tmpUDTName + Value; // add the dot
      Next;
      tmpUDTName := tmpUDTName + Value; // add everything else
      // set value to full udt name
      Value := tmpUDTName;
      // recurse to the Assignment procedure
      Assignment;
      // store temporary thread-safe variable back into previous array
      StoreArray(name, tmp, aval);
    finally
      fArrayHelpers.ReleaseHelper(AHV);
    end;
  end
  else if Token in ['+', '-', '/', '*', '%', '&', '|', '^', '>', '<'] then
  begin
    if (dt in NonAggregateTypes) and bIndexed then
    begin
      // get the indexed value
      if dt = TOK_FLOATDEF then
        StatementType := stFloat
      else if not (dt in UnsignedIntegerTypes) then
        StatementType := stSigned
      else
        StatementType := stUnsigned;
      push;
      aval := tos;
      EmitLn(Format('index %s, %s, %s',[aval, GetDecoratedIdent(name), tmp]));
      MathAssignment(aval);
      StoreArray(name, tmp, aval);
      pop;
    end
    else
    begin
      MathAssignment(name);
    end;
  end
  else
  begin
    MatchString('=');
    DoArrayAssignValue(name, tmp, dt);
  end;
  if bIndexed then
    pop;
end;

procedure TNXCComp.CheckDataType(dt: char);
var
  rhsDT : char;
begin
  rhsDT := DataType(Value);
  if Look = '[' then
    rhsDT := RemoveArrayDimension(rhsDT);
  if (IsArrayType(rhsDT) <> IsArrayType(dt)) or
     (GetArrayDimension(rhsDT) <> GetArrayDimension(dt)) then
    AbortMsg(sDatatypesNotCompatible);
end;

procedure TNXCComp.DoArrayAssignValue(const aName, idx: string; dt: char);
var
  oldType : Char;
  oldName, udType : string;
  AHV : TArrayHelperVar;
begin
  if dt = TOK_STRINGDEF then
  begin
    // name of array variable is of type string
    StringExpression(aName);
    StoreArray(aName, idx, StrBufName);
  end
  else if dt = TOK_USERDEFINEDTYPE then
  begin
    CheckIdent;
    CheckDataType(dt);
    StoreArray(aName, idx, GetDecoratedValue);
    Next;
  end
  else if IsArrayType(dt) then
  begin
    // lhs is an array.  That means we can only have a factor on the rhs.
    if idx = '' then
    begin
      if Token = '!' then begin
        Next;
        NumericFactor;
        EmitLn(Format('not %0:s, %0:s', [GetDecoratedIdent(aName)]));
      end
      else
        NumericFactor;
    end
    else
    begin
      if Look = '[' then
      begin
        oldType := fLHSDataType;
        oldName := fLHSName;
        try
          udType := '';
          if IsUDT(ArrayBaseType(dt)) then
            udType := GetUDTType(aName);
          AHV := fArrayHelpers.GetHelper(fCurrentThreadName, udType, dt);
          try
            fLHSDataType := dt;
            fLHSName     := AHV.Name;
            if fGlobals.IndexOfName(fLHSName) = -1 then
              AddEntry(fLHSName, dt, udType, '');
            NumericFactor;
            StoreArray(aName, idx, fLHSName);
          finally
            fArrayHelpers.ReleaseHelper(AHV);
          end;
        finally
          fLHSDataType := oldType;
          fLHSName     := oldName;
        end;
      end
      else
      begin
        CheckIdent;
        CheckDataType(dt);
        StoreArray(aName, idx, GetDecoratedValue);
        Next;
      end;
    end;
  end
  else
  begin
    BoolExpression;
    StoreArray(aName, idx, RegisterName);
  end;
end;

procedure TNXCComp.MathAssignment(const name : string);
var
  savedtoken : char;
begin
  // Look has to be '=', '+', or '-' or it's all messed up
  if Look = '=' then
  begin
    savedtoken := Token;
    Next; // move to '='
    Next; // move to next token
    BoolExpression;
    case savedtoken of
      '+' : StoreAdd(name);
      '-' : StoreSub(name);
      '*' : StoreMul(name);
      '/' : StoreDiv(name);
      '%' : StoreMod(name);
      '&' : StoreAnd(name);
      '|' : StoreOr(name);
      '^' : StoreXor(name);
    end;
  end
  else if (Token = '+') and (Look = '+') then
  begin
    Next; // move to second +
    Next;
//    Semi;
    StoreInc(name, 1);
  end
  else if (Token = '-') and (Look = '-') then
  begin
    Next; // move to second -
    Next;
//    Semi;
    StoreDec(name, 1);
  end
  else if (Token = '+') and (Look = '-') then
  begin
    Next; // move to -
    if Look = '=' then
    begin
      Next; // move to '='
      Next; // move to next token
      BoolExpression;
      StoreSign(name);
    end
    else
      AbortMsg(sInvalidAssignment);
  end
  else if (Token = '|') and (Look = '|') then
  begin
    Next; // move to second |
    if Look = '=' then
    begin
      Next; // move to '='
      Next; // move to next token
      BoolExpression;
      StoreAbs(name);
    end
    else
      AbortMsg(sInvalidAssignment);
  end
  else if ((Token = '>') and (Look = '>')) or ((Token = '<') and (Look = '<')) then
  begin
    savedtoken := Token;
    Next; // move to second > or <
    if Look = '=' then
    begin
      Next; // move to '='
      Next; // move to next token
      BoolExpression;
      StoreShift(savedtoken='>', name);
    end
    else
      AbortMsg(sInvalidAssignment);
  end
  else
    AbortMsg(sInvalidAssignment);
end;

procedure TNXCComp.DoLabel;
var
  lbl : string;
begin
  lbl := Value;
  Next; // the colon
  if not IsGlobal(lbl) then
  begin
    AddEntry(lbl, TOK_LABEL, '', '');
    PostLabel(lbl);
  end
  else
    Duplicate(lbl);
  fSemiColonRequired := False;
  Next;
end;

procedure TNXCComp.DoStart;
var
  taskname : string;
begin
  Next;
  taskname := Value;
  CheckTask(taskname);
  Next;
  EmitLn(Format('start %s', [taskname]));
end;

procedure TNXCComp.DoStopTask;
var
  taskname : string;
begin
  Next;
  taskname := Value;
  CheckTask(taskname);
  Next;
  EmitLn(Format('stopthread %s', [taskname]));
end;

procedure TNXCComp.DoSetPriority;
var
  taskname : string;
begin
  // priority task, value
  Next;
  taskname := Value;
  CheckTask(taskname);
  Next;
  MatchString(TOK_COMMA);
  CheckNumeric;
  EmitLn(Format('priority %s, %s', [taskname, Value]));
  Next;
end;

{--------------------------------------------------------------}
{ Parse and Translate an Assignment Statement }

procedure TNXCComp.Assignment;
var
  Name: string;
  dt : char;
begin
  if IncrementOrDecrement then
  begin
    DoPreIncOrDec(false);
  end
  else
  begin
    if not IsParam(Value) and
       not IsLocal(Value) and
       not IsGlobal(Value) and
       not IsAPIFunc(Value) and
       not IsAPIStrFunc(Value) then
      Undefined(Value);
    Name := Value;
    dt := DataType(Name);
    if dt = TOK_PROCEDURE then begin
      DoCall(Name);
    end
    else if dt = TOK_TASK then begin
      AbortMsg(sInvalidUseOfTaskName);
      SkipLine;
      Next;
    end
    else if dt = TOK_APIFUNC then begin
      Next;
      DoCallAPIFunc(Name); // functions should set register
    end
    else if dt = TOK_APISTRFUNC then begin
      Next;
      StringFunction(Name); // functions should set register
    end
    else begin
      Next;
      fLHSDataType := dt;
      fLHSName     := Name;
      try
        CheckNotConstant(Name);
        if (Token = '[') or IsArrayType(dt) then
        begin
          ArrayAssignment(Name, dt, Token = '[');
        end
        else if dt = TOK_USERDEFINEDTYPE then
        begin
          UDTAssignment(Name);
        end
        else if Token in ['+', '-', '/', '*', '%', '&', '|', '^', '>', '<'] then
        begin
          if (Token = '+') and (dt = TOK_STRINGDEF) then
            StringConcatAssignment(Name)
          else
            MathAssignment(Name);
        end
        else
        begin
          MatchString('=');
          DoAssignValue(Name, dt);
        end;
      finally
        fLHSDataType := TOK_LONGDEF;
        fLHSName     := '';
      end;
    end;
  end;
end;

procedure TNXCComp.DoAssignValue(const aName: string; dt: char);
begin
  if dt = TOK_STRINGDEF then
  begin
    StringExpression(aName);
    StoreString(aName);
  end
  else
  begin
    BoolExpression;
    Store(aName);
  end;
end;

{---------------------------------------------------------------}
{ Recognize and Translate an IF Construct }

procedure TNXCComp.DoIf(const lend, lstart : string);
var
  L1, L2: string;
begin
  Next;
  OpenParen;
  BoolExpression;
  CloseParen;
  L1 := NewLabel;
  L2 := L1;
  BranchFalse(L1);
  Block(lend, lstart);
  CheckSemicolon;
  fSemiColonRequired := Token = TOK_ELSE;
  if Token = TOK_ELSE then
  begin
    Next;
    L2 := NewLabel;
    Branch(L2);
    PostLabel(L1);
    Block(lend, lstart);
  end;
  PostLabel(L2);
end;


{--------------------------------------------------------------}
{ Parse and Translate a WHILE Statement }

procedure TNXCComp.DoWhile;
var
  L1, L2: string;
begin
  Next;
  OpenParen;
  L1 := NewLabel;
  L2 := NewLabel;
  PostLabel(L1);
  BoolExpression;
  CloseParen;
  BranchFalse(L2);
  Block(L2, L1);
  Branch(L1);
  PostLabel(L2);
end;

procedure TNXCComp.DoDoWhile;
var
  L1, L2: string;
begin
  Next;
  L1 := NewLabel;
  L2 := NewLabel;
  PostLabel(L1);
  Block(L2, L1);
  MatchString('while');
  OpenParen;
  BoolExpression;
  CloseParen;
  BranchFalse(L2);
  Branch(L1);
  PostLabel(L2);
end;

procedure TNXCComp.DoRepeat;
var
  L1, L2: string;
  svar : string;
begin
  Next;
  OpenParen;
  L1 := NewLabel;
  L2 := NewLabel;
  BoolExpression;
  CloseParen;
  push;
  svar := tos;
  EmitLn(Format('mov %s, %s',[svar, RegisterName]));
  PostLabel(L1);
  StoreDec(svar);
  EmitLn('brtst LT,' + L2 + ', ' + svar);
  Block(L2, L1);
  Branch(L1);
  PostLabel(L2);
  pop;
end;

function BoolToString(aValue : boolean) : string;
begin
  if aValue then
    Result := 'TRUE'
  else
    Result := 'FALSE';
end;

function StringToBool(const aValue : string) : boolean;
begin
  Result := aValue = 'TRUE';
end;

procedure TNXCComp.DoSwitch;
var
  L2 : string;
  idx : integer;
  bSwitchIsString : boolean;
begin
  Next;
  OpenParen;
  bSwitchIsString := ValueIsStringType;
  if bSwitchIsString then
    StringExpression('')
  else
    BoolExpression;
  CloseParen;
  L2 := NewLabel;
  idx := SwitchFixupIndex;
  inc(fSwitchDepth);
  try
    ClearSwitchFixups;
    SwitchFixups.Add(Format('%d_Type=%s', [fSwitchDepth, IntToStr(Ord(bSwitchIsString))]));
    SwitchRegisterNames.Add(Format('%d=%s', [fSwitchDepth, RegisterName]));
    Block(L2);
    PostLabel(L2);
    FixupSwitch(idx, L2);
  finally
    dec(fSwitchDepth);
  end;
end;

function TNXCComp.GetCaseConstant: string;
begin
  Result := '';
  // collect tokens up to ':' (this allows for constant expressions)
  while (Token <> ':') and not endofallsource do
  begin
    Result := Result + Value;
    Next;
  end;
  // convert true|false to TRUE|FALSE
  if (Result = 'true') or (Result = 'false') then
    Result := UpperCase(Result);
  // convert 'x' (character constant) into ordinal value
  if (Length(Result) = 3) and
     IsDelimiter('''', Result, 1) and
     IsDelimiter('''', Result, 3) then
  begin
    Result := Copy(Result, 2, 1);
    Result := IntToStr(Ord(Result[1]));
  end;
end;

procedure TNXCComp.DoSwitchCase;
var
  L1 : string;
  caseval, stackval : string;
begin
  caseval := '';
  if fSwitchDepth > 0 then
  begin
    Next; // move past 'case'
    caseval := GetCaseConstant;
    MatchString(':'); // token should be ':' at this point
    L1 := NewLabel;
    PostLabel(L1);
    if SwitchIsString then
      stackval := StrBufName
    else
      stackval := SwitchRegisterName;
    SwitchFixups.Add(Format('%d=brcmp EQ, %s, %s, %s', [fSwitchDepth, L1, caseval, stackval]));
    fSemiColonRequired := False;
  end
  else
    AbortMsg(sCaseInvalid);
end;

procedure TNXCComp.DoSwitchDefault;
var
  L1 : string;
begin
  if fSwitchDepth > 0 then
  begin
    Next; // move past 'default'
    MatchString(':');
    L1 := NewLabel;
    PostLabel(L1);
    SwitchFixups.Add(Format('%d=jmp %s', [fSwitchDepth, L1]));
    fSemiColonRequired := False;
  end
  else
    AbortMsg(sDefaultInvalid);
end;

procedure TNXCComp.ClearSwitchFixups;
var
  i : integer;
begin
// remove all fixups with depth == fSwitchDepth
  for i := SwitchFixups.Count - 1 downto 0 do
  begin
    if (SwitchFixups.Names[i] = IntToStr(fSwitchDepth)) or
       (SwitchFixups.Names[i] = Format('%d_Type', [fSwitchDepth])) then
      SwitchFixups.Delete(i);
  end;
  for i := SwitchRegisterNames.Count - 1 downto 0 do
  begin
    if SwitchRegisterNames.Names[i] = IntToStr(fSwitchDepth) then
      SwitchRegisterNames.Delete(i);
  end;
end;

function TNXCComp.SwitchIsString: Boolean;
var
  i : integer;
begin
  Result := False;
  for i := 0 to SwitchFixups.Count - 1 do
  begin
    if SwitchFixups.Names[i] = Format('%d_Type', [fSwitchDepth]) then
    begin
      Result := Boolean(StrToIntDef(SwitchFixups.ValueFromIndex[i], 0));
      Break;
    end;
  end;
end;

function TNXCComp.SwitchRegisterName: string;
var
  i : integer;
begin
  Result := RegisterName;
  for i := 0 to SwitchRegisterNames.Count - 1 do
  begin
    if SwitchRegisterNames.Names[i] = IntToStr(fSwitchDepth) then
    begin
      Result := SwitchRegisterNames.ValueFromIndex[i];
      break;
    end;
  end;
end;

procedure TNXCComp.FixupSwitch(idx : integer; lbl : string);
var
  i : integer;
  cnt : integer;
begin
  // always add a jump to the end of the switch in case
  // there aren't any default labels in the switch
  SwitchFixups.Add(Format('%d=jmp %s', [fSwitchDepth, lbl]));
  cnt := 0;
  for i := 0 to SwitchFixups.Count - 1 do
  begin
    if SwitchFixups.Names[i] = IntToStr(fSwitchDepth) then
    begin
      NBCSource.Insert(idx+cnt, SwitchFixups.ValueFromIndex[i]);
      inc(cnt);
    end;
  end;
end;

function TNXCComp.SwitchFixupIndex: integer;
begin
  Result := NBCSource.Count;
end;

function TNXCComp.ReplaceTokens(const line: string) : string;
begin
  Result := line; // line is already trimmed
  if Length(Result) = 0 then Exit;
  Result := Replace(Result, '__RETURN__', Format(#13#10'mov %s,', [SignedRegisterName]));
  Result := Replace(Result, '__RETURNS__', Format(#13#10'mov %s,', [SignedRegisterName]));
  if Pos('__RETURNU__', Result) > 0 then
  begin
    Result := Replace(Result, '__RETURNU__', Format(#13#10'mov %s,', [UnsignedRegisterName]));
    if StatementType <> stUnsigned then
      StatementType := stUnsigned;
  end;
  if Pos('__RETURNF__', Result) > 0 then
  begin
    Result := Replace(Result, '__RETURNF__', Format(#13#10'mov %s,', [FloatRegisterName]));
    if StatementType <> stFloat then
      StatementType := stFloat;
  end;
  Result := Replace(Result, '__TMPBYTE__', TempSignedByteName);
  Result := Replace(Result, '__TMPWORD__', TempSignedWordName);
  Result := Replace(Result, '__TMPLONG__', TempSignedLongName);
  Result := Replace(Result, '__TMPULONG__', TempUnsignedLongName);
  Result := Replace(Result, '__TMPFLOAT__', TempFloatName);
  Result := Replace(Result, '__RETVAL__', SignedRegisterName);
  if Pos('__FLTRETVAL__', Result) > 0 then
  begin
    Result := Replace(Result, '__FLTRETVAL__', FloatRegisterName);
    if StatementType <> stFloat then
      StatementType := stFloat;
  end;
  Result := Replace(Result, '__STRRETVAL__', StrRetValName);
  Result := Replace(Result, '__GENRETVAL__', RegisterName);
  Result := Replace(Result, 'true', 'TRUE');
  Result := Replace(Result, 'false', 'FALSE');
  Result := Replace(Result, 'asminclude', '#include');
end;

function TNXCComp.DecorateVariables(const asmStr: string): string;
var
  Lex : TGenLexer;
  len : integer;
  bPartOfStruct : boolean;

  procedure AddToResult;
  begin
    if Lex.Id = piIdent then
    begin
      // is this a local variable or a parameter?
      if bPartOfStruct then
        Result := Result + Lex.Token
      else
        Result := Result + GetDecoratedIdent(Lex.Token);
    end
    else
      Result := Result + Lex.Token;
    if not bPartOfStruct then
      bPartOfStruct := Lex.Token = '.'
    else
      bPartOfStruct := (Lex.Token = '.') or (Lex.Id in [piIdent]);
  end;
begin
  Result := '';
  len := Length(asmStr);
  if len > 0 then
  begin
    Lex := TNBCLexer.CreateLexer;
    try
      bPartOfStruct := False;
      Lex.SetStartData(@asmStr[1], len);
      while not Lex.AtEnd do
      begin
        AddToResult;
        Lex.Next;
      end;
      if Lex.Id <> piUnknown then
        AddToResult;
    finally
      Lex.Free;
    end;
  end;
end;

procedure TNXCComp.DoAsm(var dt : char);
var
  asmStr : string;
  nestLevel : integer;
begin
// gather everything within asm block and output it
  EmitPoundLine;
  MatchString(TOK_BEGIN);
  if Value <> TOK_END then
  begin
    asmStr := Value + Look;
    repeat
      nestLevel := 0;
      repeat
        GetCharX;
        if Look = TOK_BEGIN then
          inc(nestLevel);
        if (Look <> TOK_END) or (nestLevel > 0) then
          asmStr := asmStr + Look;
        if Look = TOK_END then
          dec(nestLevel);
      until ((nestLevel < 0) and (Look = TOK_END)) or (Look = LF) or endofallsource;
      if Pos('__STRRETVAL__', asmStr) > 0 then
        dt := TOK_STRINGDEF
      else if Pos('__FLTRETVAL__', asmStr) > 0 then
        dt := TOK_FLOATDEF
      else
        dt := TOK_LONGDEF;
      asmStr := ReplaceTokens(Trim(asmStr));
      asmStr := DecorateVariables(asmStr);
      if (asmStr <> '') or (Look <> TOK_END) then
        EmitAsmLines(asmStr);
      asmStr := '';
    until (Look = TOK_END) or endofallsource;
    GetChar; // get the end token
    fSemiColonRequired := False;
  end;
  Next;
end;

{--------------------------------------------------------------}
{ Parse and Translate a FOR Statement }

procedure TNXCComp.DoFor;
var
  L1, L2, L3, L4: string;
begin
  Next;
  OpenParen;
  Scan;
  L1 := NewLabel;
  L2 := NewLabel;
  L3 := NewLabel;
  L4 := NewLabel;
  inc(fNestingLevel);
  try
    if Token in [TOK_UNSIGNED, TOK_LONGDEF, TOK_SHORTDEF, TOK_CHARDEF,
                 TOK_BYTEDEF, TOK_STRINGDEF] then
    begin
      DoLocals(fCurrentThreadName);
    end
    else
    begin
      if Token <> TOK_SEMICOLON then
      begin
        Assignment;
        while Token = TOK_COMMA do
        begin
          Next;
          Assignment;
        end;
      end;
      Semi;
    end;
    PostLabel(L1);
    if Token <> TOK_SEMICOLON then
      BoolExpression
    else
      LoadConst('1');
    Semi;
    BranchFalse(L2);
    Branch(L3);
    PostLabel(L4);
    if Token <> TOK_CLOSEPAREN then
    begin
      Assignment;
      while Token = TOK_COMMA do
      begin
        Next;
        Assignment;
      end;
    end;
    CloseParen;
    Branch(L1);
    PostLabel(L3);
    Block(L2, L4);
    Branch(L4);
    PostLabel(L2);
  finally
    DecrementNestingLevel;
  end;
end;

function IndexOfAPICommand(const name : string) : integer;
begin
  for Result := Low(APIList) to High(APIList) do
  begin
    if APIList[Result] = name then
      Exit;
  end;
  Result := -1;
end;

procedure TNXCComp.DoAPICommands(const lend, lstart : string);
var
  idx : integer;
begin
  idx := IndexOfAPICommand(Value);
  case idx of
    API_BREAK    : DoBreakContinue(idx, lend);
    API_CONTINUE : DoBreakContinue(idx, lstart);
    API_RETURN   : DoReturn;
//    API_WAIT     : DoWait;
    API_ONFWD,
    API_ONREV    : DoOnFwdRev;
    API_ONFWDEX,
    API_ONREVEX  : DoOnFwdRevEx;
    API_ONFWDREG,
    API_ONREVREG : DoOnFwdRevReg;
    API_ONFWDREGEX,
    API_ONREVREGEX : DoOnFwdRevRegEx;
    API_ONFWDREGPID,
    API_ONREVREGPID : DoOnFwdRevRegPID;
    API_ONFWDREGEXPID,
    API_ONREVREGEXPID : DoOnFwdRevRegExPID;
    API_OFF,
    API_COAST,
    API_FLOAT    : DoStopMotors;
    API_OFFEX,
    API_COASTEX  : DoStopMotorsEx;
    API_ONFWDSYNC,
    API_ONREVSYNC : DoOnFwdRevSync;
    API_ONFWDSYNCEX,
    API_ONREVSYNCEX : DoOnFwdRevSyncEx;
    API_ONFWDSYNCPID,
    API_ONREVSYNCPID : DoOnFwdRevSyncPID;
    API_ONFWDSYNCEXPID,
    API_ONREVSYNCEXPID : DoOnFwdRevSyncExPID;
    API_RESETTACHOCOUNT,
    API_RESETBLOCKTACHOCOUNT,
    API_RESETROTATIONCOUNT,
    API_RESETALLTACHOCOUNTS : DoResetCounters;
    API_ROTATEMOTOR,
    API_ROTATEMOTOREX,
    API_ROTATEMOTORPID,
    API_ROTATEMOTOREXPID : DoRotateMotors(idx);
    API_SETSENSORTYPE,
    API_SETSENSORMODE : DoSetSensorTypeMode(idx);
    API_CLEARSENSOR,
    API_SETSENSORTOUCH,
    API_SETSENSORLIGHT,
    API_SETSENSORSOUND,
    API_SETSENSORLOWSPEED,
    API_RESETSENSOR : DoClearSetResetSensor;
    API_PRECEDES,
    API_FOLLOWS : DoPrecedesFollows;
    API_ACQUIRE,
    API_RELEASE : DoAcquireRelease;
    API_EXITTO : DoExitTo;
    API_SETINPUT,
    API_SETOUTPUT : DoSetInputOutput(idx);
    API_STOP : DoStop;
    API_GOTO : DoGoto;
  else
    AbortMsg(sUnknownAPICommand);
  end;
end;

{--------------------------------------------------------------}
{ Parse and Translate a Single Statement }

procedure TNXCComp.Statement(const lend, lstart : string);
var
  dt : Char;
begin
  ResetStatementType;
  fSemiColonRequired := True;
  if Token = TOK_BEGIN then
    Block(lend, lstart)
  else
  begin
    ProcessDirectives;
    case Token of
      TOK_IF:         DoIf(lend, lstart);
      TOK_WHILE:      DoWhile;
      TOK_FOR:        DoFor;
      TOK_DO:         DoDoWhile;
      TOK_REPEAT:     DoRepeat;
      TOK_SWITCH:     DoSwitch;
      TOK_CASE:       DoSwitchCase;
      TOK_DEFAULT:    DoSwitchDefault;
      TOK_START:      DoStart;
      TOK_STOP:       DoStopTask;
      TOK_PRIORITY:   DoSetPriority;
      TOK_ASM: begin
        Next;
        dt := #0;
        DoAsm(dt);
      end;
      TOK_API:        DoAPICommands(lend, lstart);
      TOK_IDENTIFIER: begin
        if Look = ':' then
          DoLabel
        else
          Assignment;
      end;
      TOK_HEX, TOK_NUM, '+', '-': begin
        BoolExpression;
      end;
      TOK_CLOSEPAREN : CloseParen;
      TOK_SEMICOLON : ;// do nothing
      TOK_END : fSemiColonRequired := False;
    end;
    EmitPoundLine;
  end;
end;


{--------------------------------------------------------------}
{ Parse and Translate a Block of Statements }

procedure TNXCComp.Block(const lend, lstart : string);
var
  bBlockStatement : boolean;
begin
  bBlockStatement := Value = TOK_BEGIN;
  if bBlockStatement then
  begin
    Next;
    inc(fNestingLevel);
    try
      BlockStatements(lend, lstart);
    finally
      DecrementNestingLevel;
    end;
    MatchString(TOK_END);
    fSemiColonRequired := False;
    Scan;
  end
  else
  begin
    Scan;
    Statement(lend, lstart);
  end;
end;

procedure TNXCComp.CheckBytesRead(const oldBytesRead: integer);
begin
  if fBytesRead = oldBytesRead then
  begin
    AbortMsg(sParserError);
    SkipLine;
    Next;
  end;
end;

procedure TNXCComp.BlockStatements(const lend, lstart: string);
var
  oldBytesRead : integer;
begin
  Scan;
  while not (Token in [TOK_END, TOK_ELSE]) and not endofallsource do
  begin
    oldBytesRead := fBytesRead;
    DoLocals(fCurrentThreadName);
    Statement(lend, lstart);
    CheckSemicolon;
    CheckBytesRead(oldBytesRead);
  end;
end;

{--------------------------------------------------------------}
{ Allocate Storage for a Variable }

procedure TNXCComp.AllocLocal(const sub, tname : string; dt : char; bConst : boolean);
var
  savedval : string;
  ival, aval, lenexpr, varName : string;
  bIsArray, bDone, bOpen : boolean;
  idx, dimensions : integer;
  V : TVariable;
begin
  Next;
  if Token <> TOK_IDENTIFIER then
    Expected(sVariableName);
  savedval := Value;
  ival := '';
  Next;
  aval := '';
  lenexpr := '';
  bIsArray := False;
  if (Token = '[') {and (Look = ']') }then begin
    // declaring an array
    bDone := False;
    bOpen := False;
    while not bDone {Token in ['[', ']']} do
    begin
      lenexpr := lenexpr + Value;
      if Token in ['[', ']'] then
        aval := aval + Token;
      if bOpen and (Token = ']') then
        bOpen := False
      else if not bOpen and (Token = '[') then
        bOpen := True
      else if (bOpen and (Token = '[')) or
              (not bOpen and (Token = ']')) then
        AbortMsg(sInvalidArrayDeclaration);
      Next;
      if not bOpen and (Token <> '[') then
        bDone := True;
    end;
    dimensions := Length(aval) div 2; // number of array dimensions
    dt := ArrayOfType(dt, dimensions);
    bIsArray := True;
  end;
  if bIsArray and bConst then
    AbortMsg(sConstLocArrNotSupported);
  varName := ApplyDecoration(sub, savedval, fNestingLevel);
  idx := AddLocal(varName, dt, tname, bConst, lenexpr);
  if (Token = TOK_COMMA) or (Token = TOK_SEMICOLON) then
  begin
    if bConst then
      Expected(sConstInitialization);
    // no need to allocate if we've already emitted this name&type
    if fEmittedLocals.IndexOf(varName+tname) = -1 then
      Allocate(varName, aval, ival, tname, dt);
    if bIsArray and (lenexpr <> '') then
      InitializeArray(varName, aval, ival, tname, dt, lenexpr);
  end
  else if Token = '=' then
  begin
    // move past the '=' sign
    fLHSDataType := dt;
    fLHSName     := savedval;
    try
      Next;
      ival := '';
      if fEmittedLocals.IndexOf(varName+tname) = -1 then
        Allocate(varName, aval, ival, tname, dt);
      if bIsArray then begin
        ival := GetInitialValue(dt);
        DoLocalArrayInit(varName, ival, dt);
  //    if not bIsArray then
  //      DoArrayAssignValue(savedval, '', dt)
      end
      else if dt = TOK_USERDEFINEDTYPE then
      begin
        GetAndStoreUDT(savedval);
      end
      else
      begin
        DoAssignValue(savedval, dt);
        if fLastExpressionOptimizedToConst and (idx <> -1) then
        begin
          V := fLocals[idx];
          if V.IsConstant then
            V.Value := fLastLoadedConst;
        end;
      end;
    finally
      fLHSDataType := TOK_LONGDEF;
      fLHSName     := '';
    end;
  end
  else
    Next;
  fEmittedLocals.Add(varName+tname);
end;

function TNXCComp.GetInitialValue(dt : char): string;
var
  nestLevel, i : integer;
  tmpExpr : string;
  procedure UpdateResultWithValueForArrayTypes;
  begin
    if tmpExpr <> '' then
    begin
      if ArrayBaseType(dt) = TOK_STRINGDEF then
      begin
        Result := Result + tmpExpr + Value;
        tmpExpr := '';
      end
      else
      begin
        fCalc.SilentExpression := tmpExpr;
        if not fCalc.ParserError then
        begin
          if ArrayBaseType(dt) = TOK_FLOATDEF then
          begin
            tmpExpr := NBCFloatToStr(fCalc.Value);
          end
          else
            tmpExpr := IntToStr(Trunc(fCalc.Value))
        end
        else
          AbortMsg(sInvalidConstExpr);
        Result := Result + tmpExpr + Value;
        tmpExpr := '';
      end;
    end
    else
      Result := Result + Value;
  end;
begin
  Result := '';
  // handle string variables differently
  if dt = TOK_STRINGDEF then
  begin
    if Token = TOK_IDENTIFIER then
    begin
      // try to resolve this as a constant string into a string literal
      i := fConstStringMap.IndexOfName(Value);
      if i <> -1 then
      begin
        Token := TOK_STRINGLIT;
        Value := fConstStringMap.Values[Value];
      end;
    end;
    Result := Value;
    if Token <> TOK_STRINGLIT then
      AbortMsg(sInvalidStringInit);
    Next;
  end
  else if IsArrayType(dt) then
  begin
    // array initialization could involve nested {} pairs
    if Token <> TOK_BEGIN then
      AbortMsg(sInvalidGlobalArrayInit);
    nestLevel := 1;
    while ((Token <> TOK_END) or (nestLevel > 0)) and not endofallsource do
    begin
      if Token = TOK_BEGIN then
      begin
        tmpExpr := '';
        UpdateResultWithValueForArrayTypes;
      end
      else if Token in [TOK_END, TOK_COMMA] then
      begin
        UpdateResultWithValueForArrayTypes;
      end
      else
      begin
        tmpExpr := tmpExpr + Value;
      end;
      Next;
      if Token = TOK_BEGIN then
        inc(nestLevel)
      else if Token = TOK_END then
        dec(nestLevel);
    end;
    if Token = TOK_END then
    begin
      UpdateResultWithValueForArrayTypes;
      Next;
    end
    else
      AbortMsg(sInvalidGlobalArrayInit);
  end
  else
  begin
    if dt = TOK_MUTEXDEF then
      AbortMsg(sInitNotAllowed);
    // not a string, not an array, not a mutex.  Must be a scalar type or user-defined type
    while not (Token in [TOK_COMMA, TOK_SEMICOLON]) and not endofallsource do
    begin
      Result := Result + Value;
      Next;
    end;
    Result := Trim(Result);
    if dt in NonAggregateTypes then
    begin
      // evaluate so that constants and expressions are handled properly
      if Result = 'false' then
        Result := '0'
      else if Result = 'true' then
        Result := '1'
      else
      begin
        fCalc.SilentExpression := Result;
        if not fCalc.ParserError then
        begin
          if dt = TOK_FLOATDEF then
            Result := NBCFloatToStr(fCalc.Value)
          else
            Result := IntToStr(Trunc(fCalc.Value));
        end
        else
          AbortMsg(sInvalidConstExpr);
      end;
    end;
  end;
end;

procedure TNXCComp.AllocGlobal(const tname : string; dt : char; bInline, bSafeCall, bConst : boolean);
var
  savedval, ival, aval, lenexpr : string;
  dimensions, idx : integer;
  bDone, bOpen, bArray : boolean;
begin
  Next;
  Scan;
  if Token <> TOK_IDENTIFIER then Expected(sVariableName);
  // optional initial value
  savedval := Value;
  ival := '';
  Next;
  // it is possible that we are looking at a function declaration
  // rather than a variable declaration.
  if Token = TOK_OPENPAREN then
  begin
    FunctionBlock(savedval, tname, dt, bInline, bSafeCall);
    fSemiColonRequired := False;
  end
  else
  begin
    fSemiColonRequired := True;
    CheckDup(savedval);
    if bInline then
      AbortMsg(sInlineInvalid);
    if bSafeCall then
      AbortMsg(sSafeCallInvalid);
    aval := '';
    lenexpr := '';
    bArray := False;
    dimensions := 0;
    if (Token = '[') {and (Look = ']') }then begin
//      if bConst then
//        AbortMsg(sInvalidArrayDeclaration); // arrays cannot be declared constant
      // declaring an array
      bDone := False;
      bOpen := False;
      while not bDone {Token in ['[', ']']} do
      begin
        lenexpr := lenexpr + Value;
        if Token in ['[', ']'] then
          aval := aval + Token;
        if bOpen and (Token = ']') then
          bOpen := False
        else if not bOpen and (Token = '[') then
          bOpen := True
        else if (bOpen and (Token = '[')) or
                (not bOpen and (Token = ']')) then
          AbortMsg(sInvalidArrayDeclaration);
        Next;
        if not bOpen and (Token <> '[') then
          bDone := True;
      end;
{
    if (Token = '[') and (Look = ']') then begin
      // declaring an array
      while Token in ['[', ']'] do begin
        aval := aval + Token;
        Next;
      end;
}
      dimensions := Length(aval) div 2; // number of array dimensions
      dt := ArrayOfType(dt, dimensions);
      bArray := True;
    end;
    AddEntry(savedval, dt, tname, lenexpr, bConst);
    if (Token = TOK_COMMA) or (Token = TOK_SEMICOLON) then
    begin
      if bConst then
        Expected(sConstInitialization);
      Allocate(savedval, aval, ival, tname, dt);
    end
    else if Token = '=' then
    begin
      if bArray and (ArrayBaseType(dt) = TOK_STRINGDEF) then
        inc(dimensions);
      // move past the '=' sign
      Next;
      ival := GetInitialValue(dt);
      // lookup global and set its value
      idx := fGlobals.IndexOfName(savedval);
      if idx <> -1 then
      begin
        // do not set the value for 1 dimensional arrays since the initial
        // values can be set statically
        if dimensions <> 1 then
          fGlobals[idx].Value := ival;
      end;
      // the value must be a numeric constant expression if the type
      // is an integer type
      if bConst then
      begin
        if dt in NonAggregateTypes then
        begin
          if dt = TOK_FLOATDEF then
            fCalc.SetVariable(savedval, NBCStrToFloatDef(ival, 0))
          else
            fCalc.SetVariable(savedval, StrToInt64Def(ival, 0));
        end
        else if dt = TOK_STRINGDEF then
        begin
          // string constants - use a variable name to value map (string list)
          fConstStringMap.Add(savedval+'='+ival);
        end
        else if not bArray then
          AbortMsg(sInvalidConstExpr);
      end;
      // arrays with > 1 dimension cannot be initialized statically
      if dimensions > 1 then
        ival := '';
      Allocate(savedval, aval, ival, tname, dt);
    end
    else
      Next;
  end;
end;

function TNXCComp.GetVariableType(vt : char; bUnsigned : boolean) : char;
begin
  if not bUnsigned then
    Result := vt
  else
    case vt of
      TOK_LONGDEF : Result := TOK_ULONGDEF;
      TOK_SHORTDEF : Result := TOK_USHORTDEF;
      TOK_CHARDEF : Result := TOK_BYTEDEF;
    else
      if vt = TOK_FLOATDEF then
        AbortMsg(sNoUnsignedFloat);
      Result := vt;
    end;
end;

{--------------------------------------------------------------}
{ Parse and Translate Global Declarations }

procedure TNXCComp.TopDecls;
var
  vt : char;
  bUnsigned, bInline, bSafeCall, bConst : boolean;
  oldBytesRead : Integer;
  dt : char;
  tname : string;
begin
  DoCompilerStatusChange(sNXCProcessGlobals);
  bUnsigned := False;
  bInline   := False;
  bSafeCall := False;
  bConst    := False;
  Scan;
  if Token = TOK_IDENTIFIER then
    CheckForTypedef(bUnsigned, bConst, bInline, bSafeCall);
  while not (Token in [TOK_TASK, TOK_PROCEDURE]) and not endofallsource do
  begin
    oldBytesRead := fBytesRead;
    case Token of
      TOK_ASM: begin
        Next;
        dt := #0;
        DoAsm(dt);
        Scan;
      end;
      TOK_DIRECTIVE : begin
        ProcessDirectives;
        Scan;
      end;
      TOK_CONST : begin
        Next;
        Scan;
        bConst := True;
      end;
      TOK_UNSIGNED : begin
        Next;
        Scan;
        bUnsigned := True;
      end;
      TOK_INLINE : begin
        Next;
        Scan;
        bInline := True;
      end;
      TOK_SAFECALL : begin
        Next;
        Scan;
        bSafeCall := True;
      end;
      TOK_TYPEDEF : begin
        ProcessTypedef;
      end;
      TOK_STRUCT : begin
        ProcessStruct(False);
      end;
      TOK_USERDEFINEDTYPE,
      TOK_LONGDEF, TOK_SHORTDEF,
      TOK_CHARDEF, TOK_BYTEDEF,
      TOK_MUTEXDEF, TOK_FLOATDEF,
      TOK_STRINGDEF : begin
        tname := Value;
        vt := Token;
        AllocGlobal(tname, GetVariableType(vt, bUnsigned), bInline, bSafeCall, bConst);
        while Token = TOK_COMMA do
          AllocGlobal(tname, GetVariableType(vt, bUnsigned), bInline, bSafeCall, bConst);
        CheckSemicolon;
        bUnsigned := False;
        bInline   := False;
        bSafeCall := False;
        bConst    := False;
      end;
    else
      // nothing here right now
      Semi;
      Scan;
    end;
    if Token = TOK_IDENTIFIER then
      CheckForTypedef(bUnsigned, bConst, bInline, bSafeCall);
    CheckBytesRead(oldBytesRead);
  end;
  if bInLine then
    IncrementInlineDepth;
//  fInlining := bInLine;
  fSafeCalling := bSafeCall;
end;

function TNXCComp.AddLocal(name : string; dt : char; const tname : string;
  bConst : boolean; const lenexp : string) : integer;
var
  l, IL : TVariable;
begin
  Result := -1;
  if IsParam(name) or IsLocal(name) then
    Duplicate(name)
  else
  begin
    l := fLocals.Add;
    l.Name       := name;
    l.DataType   := dt;
    l.IsConstant := bConst;
    l.TypeName   := tname;
    l.LenExpr    := lenexp;                 
    l.Level      := fNestingLevel;
    if AmInlining and Assigned(fCurrentInlineFunction) then
    begin
      IL := fCurrentInlineFunction.LocalVariables.Add;
      IL.Assign(l);
    end;
    Result := l.Index;
  end;
end;

procedure TNXCComp.DoLocals(const sub : string);
var
  bIsUnsigned, bIsConst, bDummy : boolean;
  dt : char;
  tname : string;
begin
  bIsUnsigned := False;
  bIsConst    := False;
  bDummy      := False;
  Scan;
  if Token = TOK_IDENTIFIER then
    CheckForTypedef(bIsUnsigned, bIsConst, bDummy, bDummy);
  while (Token in [TOK_DIRECTIVE, TOK_UNSIGNED, TOK_CONST,
    TOK_TYPEDEF, TOK_STRUCT,
    TOK_USERDEFINEDTYPE,
    TOK_LONGDEF, TOK_SHORTDEF, TOK_CHARDEF,
    TOK_BYTEDEF, TOK_MUTEXDEF, TOK_FLOATDEF, TOK_STRINGDEF]) and not endofallsource do
  begin
    case Token of
      TOK_DIRECTIVE : begin
        ProcessDirectives;
        Scan;
      end;
      TOK_CONST : begin
        Next;
        Scan;
        bIsConst := True;
      end;
      TOK_UNSIGNED : begin
        Next;
        Scan;
        bIsUnsigned := True;
      end;
      TOK_TYPEDEF : begin
        ProcessTypedef;
      end;
      TOK_STRUCT : begin
        ProcessStruct(False);
      end;
      TOK_USERDEFINEDTYPE,
      TOK_LONGDEF, TOK_SHORTDEF,
      TOK_CHARDEF, TOK_BYTEDEF,
      TOK_MUTEXDEF, TOK_FLOATDEF, TOK_STRINGDEF : begin
        tname := Value;
        dt := Token;
        AllocLocal(sub, tname, GetVariableType(dt, bIsUnsigned), bIsConst);
        while Token = TOK_COMMA do
          AllocLocal(sub, tname, GetVariableType(dt, bIsUnsigned), bIsConst);
        Semi;
        Scan;
        bIsUnsigned := False;
        bIsConst    := False;
      end;
    else
      Expected(sValidProgBlock);
    end;
    if Token = TOK_IDENTIFIER then
      CheckForTypedef(bIsUnsigned, bIsConst, bDummy, bDummy);
  end;
end;

const
  HASPROTO = 2;
  HASNOPROTO = 3;

function TNXCComp.FormalList(protoexists : boolean; procname : string) : integer;
var
  protocount : integer;
  pltype : integer;
  pcount : integer;
  ptype : char;
  varnam : string;
  bIsUnsigned, bIsArray, bIsConst, bIsRef, bError : boolean;
  aval, tname : string;
  dimensions : integer;
  oldBytesRead : integer;

  procedure CheckParam1;
  begin
    AbortMsg(sBadPrototype);
    bError := True;
    if protocount >= MAXPARAMS then
      AbortMsg(sMaxParamCountExceeded);
    inc(protocount);
  end;

  procedure CheckParamHasProto;
  begin
    if not protoexists then
    begin
      Expected(sDataType);
      bError := True;
    end;
    if pcount >= MAXPARAMS then
    begin
      AbortMsg(sMaxParamCountExceeded);
      bError := True;
    end;
    if not bError then
    begin
      AddParam(ApplyDecoration(procname, varnam, 0),
        FunctionParameterType(procname, pcount),
        FunctionParameterTypeName(procname, pcount),
        FunctionParameterIsConstant(procname, pcount));
      inc(pcount);
      if pcount > protocount then
      begin
        AbortMsg(sTooManyArgs);
        bError := True;
      end;
    end;
  end;

  procedure CheckParamHasNoProto;
  var
    fpDT : char;
    fpType : string;
    fpIsConst : boolean;
  begin
    if pcount >= MAXPARAMS then
    begin
      AbortMsg(sMaxParamCountExceeded);
      bError := True;
    end;
    if protoexists and not bError and (pcount >= protocount) then
    begin
      AbortMsg(sTooManyArgs);
      bError := True;
    end;
    if protoexists and not bError then
    begin
      // compare known type to specified type
      fpDT      := FunctionParameterType(procname, pcount);
      fpType    := FunctionParameterTypeName(procname, pcount);
      fpIsConst := FunctionParameterIsConstant(procname, pcount);
      if (fpDT <> ptype) or (fpType <> tname) or (fpIsConst <> bIsConst) then
      begin
        AbortMsg(sFuncParamDeclMismatch);
        bError := True;
      end;
    end;
    if not bError then
    begin
      AddParam(ApplyDecoration(procname, varnam, 0), ptype, tname, bIsConst);
      if not protoexists then
      begin
        Allocate(ApplyDecoration(procname, varnam, 0), aval, '', tname, ptype);
        AddFunctionParameter(procname, varnam, tname, pcount, ptype, bIsConst,
          bIsRef, bIsArray, dimensions);
        inc(protocount);
      end;
      inc(pcount);
    end;
  end;

  procedure CheckPLType;
  begin
    case pltype of
      1          : CheckParam1;
      HASPROTO   : CheckParamHasProto;
      HASNOPROTO : CheckParamHasNoProto;
    end;
  end;

  procedure ProcessTypes(const bFirstParam : boolean);
  begin
    bIsUnsigned := False;
    bIsArray    := False;
    bIsConst    := False;
    bIsRef      := False;
    ptype       := #0;
    if Token = TOK_CONST then begin
      bIsConst := True;
      Next;
      Scan;
      if bFirstParam then pltype := 1;
    end;
    if Token = TOK_UNSIGNED then begin
      bIsUnsigned := True;
      Next;
      Scan;
      if bFirstParam then pltype := 1;
    end;
    if Token in [TOK_CHARDEF, TOK_BYTEDEF, TOK_SHORTDEF, TOK_LONGDEF,
      TOK_MUTEXDEF, TOK_FLOATDEF, TOK_STRINGDEF, TOK_USERDEFINEDTYPE, TOK_STRINGLIT] then
    begin
      ptype := Token;
      tname := Value;
      if bFirstParam then pltype := 1;
      Next;
      Scan;
      if (Token <> '[') and (Token <> TOK_COMMA) and
         (Token <> TOK_CLOSEPAREN) and (Token <> '&') and
         (Token <> TOK_IDENTIFIER) then
      begin
        AbortMsg(sUnexpectedChar);
        bError := True;
      end;
    end
    else if bIsUnsigned then
    begin
      AbortMsg(sMissingDataType);
      bError := True;
    end;
    if Token = '&' then
    begin
      bIsRef := True;
      Next;
      Scan;
    end;
  end;
  
  procedure CheckParamTypeAndArrays;
  begin
    if pltype = HASNOPROTO then
    begin
      ptype := GetVariableType(ptype, bIsUnsigned);
      if ptype = #0 then
        bError := True;
      if not bError then
      begin
        aval := '';
        dimensions := 0;
        if (Token = '[') and (Look = ']') then begin
          // declaring an array
          while Token in ['[', ']'] do begin
            aval := aval + Token;
            Next;
          end;
          bIsArray := True;
          dimensions := Length(aval) div 2; // number of array dimensions
          ptype := ArrayOfType(ptype, dimensions);
        end;
      end;
    end;
  end;
begin
  dimensions := 0;
  protocount := 0;
  pcount := 0;
  pltype := 0;
  if protoexists then
    protocount := FunctionParameterCount(procname);
  bError := False;
  while (Token <> TOK_CLOSEPAREN) and not endofallsource do
  begin
    oldBytesRead := fBytesRead;
    if bError then
      Break;
    Scan;
    // handle void all by itself
    if Token = TOK_PROCEDURE then begin
      Next;
      Scan;
      Continue;
    end;
    ProcessTypes(true);
    if Token = TOK_IDENTIFIER then
    begin
      varnam := Value;
      Next;
      Scan;
      if pltype = 1 then
        pltype := HASNOPROTO
      else
        pltype := HASPROTO;
    end;
    CheckParamTypeAndArrays;
    if bError then
      Continue;
    CheckPLType;

    // process remaining parameters
    while (Token = TOK_COMMA) and not endofallsource do begin
      if bError then
        Break;
      Next;
      Scan;
      if (pltype = 1) or (pltype = HASNOPROTO) then
        ProcessTypes(false);
      if (pltype = HASPROTO) or (pltype = HASNOPROTO) then
      begin
        if Token = TOK_IDENTIFIER then begin
          varnam := Value;
          Next;
          Scan;
        end
        else
        begin
          Expected(sVariableName);
          bError := True;
        end;
      end;
      CheckParamTypeAndArrays;
      if bError then
        Continue;
      CheckPLType;
    end; // while Token = TOK_COMMA
    CheckBytesRead(oldBytesRead);
  end; // while Token <> TOK_CLOSEPAREN
  if protoexists and (pcount < protocount) then
    AbortMsg(sTooFewArgs);
  if bError then
    while (Token <> TOK_CLOSEPAREN) and not endofallsource do
      Next; // eat tokens up to TOK_CLOSEPAREN
  Result := pltype;
end;

procedure TNXCComp.ProcedureBlock;
var
  Name : string;
  procexists : integer;
  protoexists, bIsSub : boolean;
  pltype : integer;
  savedToken : char;
begin
  while Token in [TOK_INLINE, TOK_SAFECALL, TOK_PROCEDURE, TOK_TASK] do
  begin
    if Token = TOK_INLINE then
    begin
      Next;
      IncrementInlineDepth;
//      fInlining := True;
    end;
    if Token = TOK_SAFECALL then
    begin
      Next;
      fSafeCalling := True;
    end;
    bIsSub := Token = TOK_PROCEDURE;
    if AmInlining and not bIsSub then
      AbortMsg(sInlineInvalid);
    if fSafeCalling and not bIsSub then
      AbortMsg(sSafeCallInvalid);
    savedToken := Token;
    Next;
    Scan;
    CheckIdent;
    Name := Value;
    DoCompilerStatusChange(Format(sNXCProcedure, [Name]));
    if bIsSub and (Name = 'main') then
      AbortMsg(sMainMustBeTask);
    procexists := GlobalIdx(Name);
    protoexists := False;
    if procexists <> 0 then begin
      if not (GS_Type[procexists] in [TOK_PROCEDURE, TOK_TASK]) then
        Duplicate(Name);
      if GS_Size[procexists] = 0 then
        protoexists := True
      else
        Duplicate(Name);
    end
    else begin
      if bIsSub and (SafeCalls or fSafeCalling) then
      begin
        // define a mutex for this subroutine/function
        EmitMutexDeclaration(Name);
      end;
      AddEntry(Name, savedToken, '', '', False, fSafeCalling);
      GS_ReturnType[NumGlobals] := #0;
    end;
    Next;
    OpenParen;
    fCurrentThreadName := Name;
    fThreadNames.Add(Name);
    if bIsSub then
      pltype := FormalList(protoexists, Name)
    else
      pltype := 0;
    // allow for the possibility that tasks have (void) args
    if Value = 'void' then
      Next;
    CloseParen;
    if Token = TOK_SEMICOLON then
    begin
      // this is a function declaration (a prototype) - not a function definition
      pltype := 1;
      Next;
    end;
//    OptionalSemi;
    Scan;
    ProcessDirectives; // just in case there are any between the ) and the {
    if Token = TOK_BEGIN then
    begin
      if pltype = 1 then
        AbortMsg(sNotValidForPrototype);
      if protoexists then
        GS_Size[procexists] := 1
      else
        GS_Size[NumGlobals] := 1;
      Prolog(Name, bIsSub);
      MatchString(TOK_BEGIN);
      if Name = 'main' then
      begin
        InitializeGlobalArrays;
        InitializeGraphicOutVars;
      end;
      ClearLocals;
      fNestingLevel := 0;
      DoLocals(Name);
      BlockStatements();
      MatchString(TOK_END);
      Epilog(bIsSub);
      Scan;
    end
    else
    begin
      if protoexists then
        Expected(sProtoAlreadyDefined);
      Scan;
    end;
    ClearParams;
//    DecrementInlineDepth;
//    fInlining := False;
    fSafeCalling := False;
    TopDecls;
  end;
end;

procedure TNXCComp.FunctionBlock(const Name, tname : string; dt: char;
  bInline, bSafeCall : boolean);
var
  procexists : integer;
  protoexists : boolean;
  pltype : integer;
begin
  if bInline then
    IncrementInlineDepth;
//  fInlining := bInline;
  if Name = 'main' then
    AbortMsg(sMainMustBeTask);
  procexists := GlobalIdx(Name);
  protoexists := False;
  if procexists <> 0 then begin
    if not (GS_Type[procexists] in [TOK_PROCEDURE, TOK_TASK]) then
      Duplicate(Name);
    if GS_Size[procexists] = 0 then
      protoexists := True
    else
      Duplicate(Name);
  end
  else begin
    // define a mutex for this function if safecall
    if SafeCalls or bSafeCall then
      EmitMutexDeclaration(Name);
    AddEntry(Name, TOK_PROCEDURE, tname, '', False, bSafeCall);
    GS_ReturnType[NumGlobals] := dt;
    if IsArrayType(dt) or IsUDT(dt) then
      AddEntry(Format('__result_%s', [Name]), dt, tname, '');
  end;
  OpenParen;
  fCurrentThreadName := Name;
  fThreadNames.Add(Name);
  pltype := FormalList(protoexists, Name);
  CloseParen;
  if Token = TOK_SEMICOLON then
  begin
    // this is a function declaration (a prototype) - not a function definition
    pltype := 1;
    Next;
  end;
//  OptionalSemi;
  Scan;
  ProcessDirectives; // just in case there are any in between the ) and the {
  if Token = TOK_BEGIN then
  begin
    if pltype = 1 then
      AbortMsg(sNotValidForPrototype);
    if protoexists then
      GS_Size[procexists] := 1
    else
      GS_Size[NumGlobals] := 1;
    Prolog(Name, True);
    MatchString(TOK_BEGIN);
    ClearLocals;
    fNestingLevel := 0;
    DoLocals(Name);
    BlockStatements();
    MatchString(TOK_END);
    Epilog(True);
    Scan;
  end
  else
  begin
    if protoexists then
      Expected(sProtoAlreadyDefined);
    Scan;
  end;
  ClearParams;
end;

{--------------------------------------------------------------}
{ Initialize }

procedure TNXCComp.Init;
begin
  fInlineDepth := 0;
  fLastExpressionOptimizedToConst := False;
  fLastLoadedConst := '';
  fCurrentLine := '';
  totallines := 1;
  linenumber := 1;
  ClearParams;
  fStackDepth   := 0;
  MaxStackDepth := 0;
  GetChar;
  Next;
end;

{--------------------------------------------------------------}
{  Parse and Translate a Program }

procedure TNXCComp.Prog;
begin
  Header;
  TopDecls;
  if Token in [TOK_INLINE, TOK_SAFECALL, TOK_PROCEDURE, TOK_TASK] then
    ProcedureBlock;
  Trailer;
end;

{ TNXCComp }

constructor TNXCComp.Create;
begin
  inherited Create;
  fMaxErrors := 0;
  NumGlobals := 0;
  endofallsource := False;
  fEnhancedFirmware := False;
  fFirmwareVersion  := 105; // 1.05 NXT 1.1 firmware 
  fIgnoreSystemFile := False;
  fWarningsOff      := False;
  fDD := TDataDefs.Create;
  fNamedTypes := TMapList.Create;
  fNamedTypes.CaseSensitive := True;
  fNamedTypes.Duplicates := dupError;
  fDefines := TStringList.Create;
  fEmittedLocals := TStringList.Create;
  fLocals := TVariableList.Create;
  fParams := TVariableList.Create;
  fGlobals := TVariableList.Create;
  fFuncParams := TFunctionParameters.Create;
  fInlineFunctionStack := TObjectStack.Create;
  fInlineFunctions := TInlineFunctions.Create;
  fArrayHelpers := TArrayHelperVars.Create;
  fTmpAsmLines := TStringList.Create;
  fStackVarNames := TStringList.Create;
  fNBCSrc := TStringList.Create;
  fMS := TMemoryStream.Create;
  fMessages := TStringList.Create;
  fIncludeDirs := TStringList.Create;
  fAPIFunctions := TStringList.Create;
  TStringList(fAPIFunctions).Sorted := True;
  fAPIStrFunctions := TStringList.Create;
  TStringList(fAPIStrFunctions).Sorted := True;
  fThreadNames := TStringList.Create;
  TStringList(fThreadNames).Sorted := True;
  TStringList(fThreadNames).Duplicates := dupIgnore;
  fSwitchFixups := TStringList.Create;
  fSwitchRegNames := TStringList.Create;
  fSwitchDepth := 0;
  fFunctionNameCallStack := TStringList.Create;
  fConstStringMap := TStringList.Create;
  fConstStringMap.Sorted := True;
  fArrayIndexStack := TStringList.Create;
  fStructDecls := TStringList.Create;
  fInlineStack := TObjectList.Create(false);
  fCalc := TNBCExpParser.Create(nil);
  fCalc.PascalNumberformat := False;
  fCalc.CaseSensitive := True;
  fCalc.StandardDefines := True;
  fCalc.ExtraDefines := True;
  LoadAPIFunctions;
  fOptimizeLevel := 0;
  Clear;
end;

destructor TNXCComp.Destroy;
begin
  FreeAndNil(fDD);
  FreeAndNil(fNamedTypes);
  FreeAndNil(fDefines);
  FreeAndNil(fEmittedLocals);
  FreeAndNil(fLocals);
  FreeAndNil(fParams);
  FreeAndNil(fGlobals);
  FreeAndNil(fFuncParams);
  FreeAndNil(fInlineFunctionStack);
  FreeAndNil(fInlineFunctions);
  FreeAndNil(fArrayHelpers);
  FreeAndNil(fTmpAsmLines);
  FreeAndNil(fStackVarNames);
  FreeAndNil(fNBCSrc);
  FreeAndNil(fMS);
  FreeAndNil(fMessages);
  FreeAndNil(fIncludeDirs);
  FreeAndNil(fAPIFunctions);
  FreeAndNil(fAPIStrFunctions);
  FreeAndNil(fFunctionNameCallStack);
  FreeAndNil(fConstStringMap);
  FreeAndNil(fArrayIndexStack);
  FreeAndNil(fStructDecls);
  FreeAndNil(fThreadNames);
//  FreeAndNil(fParamNames);
  FreeAndNil(fSwitchFixups);
  FreeAndNil(fSwitchRegNames);
  FreeAndNil(fInlineStack);
  FreeAndNil(fCalc);
  inherited;
end;

procedure TNXCComp.InternalParseStream;
begin
  try
    DoCompilerStatusChange(sNXCCompBegin);
    fFuncParams.Clear;
    fThreadNames.Clear;
    fConstStringMap.Clear;
    fGlobals.Clear;
    fBadProgram     := False;
    fBytesRead      := 0;
    fProgErrorCount := 0;
    fLastErrLine    := -99;
    fLastErrMsg     := '';
    fLHSDataType    := #0;
    fLHSName        := '';
    DoCompilerStatusChange(sNXCPreprocess);
    PreProcess;
    fMS.Position := 0;
    fParenDepth  := 0;
    DoCompilerStatusChange(sNXCInitProgram);
    Init;
    DoCompilerStatusChange(sNXCParseProg);
    Prog;
    DoCompilerStatusChange(sNXCCodeGenComplete);
  except
    on E : EAbort do
    begin
      fBadProgram := True;
      // end processing file due to Abort in ReportProblem
    end;
    on E : EPreprocessorException do
    begin
      fBadProgram := True;
      ReportProblem(E.LineNo, CurrentFile, E.Message, true);
    end;
    on E : Exception do
    begin
      fBadProgram := True;
      ReportProblem(linenumber, CurrentFile, E.Message, true);
    end;
  end;
end;

procedure TNXCComp.Parse(aStrings: TStrings);
begin
  Clear;
  if not IgnoreSystemFile then
    LoadSystemFile(fMS);
  aStrings.SaveToStream(fMS);
  InternalParseStream;
end;

procedure TNXCComp.Parse(aStream: TStream);
begin
  Clear;
  if not IgnoreSystemFile then
    LoadSystemFile(fMS);
  fMS.CopyFrom(aStream, 0);
  InternalParseStream;
end;

procedure TNXCComp.Parse(const aFilename: string);
var
  Stream : TFileStream;
begin
  Clear;
  if not IgnoreSystemFile then
    LoadSystemFile(fMS);
  Stream := TFileStream.Create(aFilename, fmOpenRead or fmShareDenyWrite);
  try
    fMS.CopyFrom(Stream, 0);
  finally
    Stream.Free;
  end;
  InternalParseStream;
end;

procedure TNXCComp.Clear;
begin
  fMS.Clear;
  NBCSource.Clear;
  fInlineFunctions.Clear;
  fArrayHelpers.Clear;
  fStructDecls.Clear;
  fMessages.Clear;
  fTempChar    := ' ';
  fLHSDataType := #0;
  fLHSName     := '';
  LCount       := 0;
  ClearLocals;
  ClearParams;
  ClearGlobals;
end;

{--------------------------------------------------------------}
{ Recognize and Translate a break/continue }

procedure TNXCComp.DoBreakContinue(idx : integer; const lbl: string);
var
  val : string;
begin
  val := APIList[idx];
  MatchString(val);
//  Semi;
  if lbl <> '' then
    Branch(lbl)
  else
    AbortMsg(Format(sInvalidBreakContinue, [val]));
end;

procedure TNXCComp.DoOnFwdRev;
var
  op, arg1 : string;
begin
  //OnFwd(ports, pwr)
  op := Value;
  Next;
  OpenParen;
  // ports
  arg1 := GetDecoratedValue;
  Next;
  MatchString(TOK_COMMA);
  // pwr
  BoolExpression;
  CloseParen;
  EmitLn(Format('%s(%s, %s)',[op, arg1, RegisterName]));
end;

procedure TNXCComp.DoOnFwdRevEx;
var
  op, arg1, arg3 : string;
begin
  //OnFwdEx(ports, pwr, reset)
  //OnRevEx(ports, pwr, reset)
  op := Value;
  Next;
  OpenParen;
  // ports
  arg1 := GetDecoratedValue;
  Next;
  MatchString(TOK_COMMA);
  // pwr
  BoolExpression;
  MatchString(TOK_COMMA);
  // reset
  CheckNumeric;
  arg3 := Value;
  Next;
  CloseParen;
  EmitLn(Format('%s(%s, %s, %s)',[op, arg1, RegisterName, arg3]));
end;

procedure TNXCComp.DoOnFwdRevReg;
var
  op, arg1, svar : string;
begin
  //OnFwdReg(ports, pwr, regmode)
  op := Value;
  Next;
  OpenParen;
  // ports
  arg1 := GetDecoratedValue;
  Next;
  MatchString(TOK_COMMA);
  // pwr
  BoolExpression;
  push;
  svar := tos;
  EmitLn(Format('mov %s, %s',[svar, RegisterName]));
  MatchString(TOK_COMMA);
  // regmode
  BoolExpression;
  CloseParen;
  EmitLn(Format('%s(%s, %s, %s)',[op, arg1, svar, RegisterName]));
  pop;
end;

procedure TNXCComp.DoOnFwdRevRegEx;
var
  op, arg1, svar, arg4 : string;
begin
  //OnFwdRegEx(ports, pwr, regmode, reset)
  //OnRevRegEx(ports, pwr, regmode, reset)
  op := Value;
  Next;
  OpenParen;
  // ports
  arg1 := GetDecoratedValue;
  Next;
  MatchString(TOK_COMMA);
  // pwr
  BoolExpression;
  push;
  svar := tos;
  EmitLn(Format('mov %s, %s',[svar, RegisterName]));
  MatchString(TOK_COMMA);
  // regmode
  BoolExpression;
  MatchString(TOK_COMMA);
  // reset
  CheckNumeric;
  arg4 := Value;
  Next;
  CloseParen;
  EmitLn(Format('%s(%s, %s, %s, %s)',[op, arg1, svar, RegisterName, arg4]));
  pop;
end;

procedure TNXCComp.DoOnFwdRevSync;
var
  op, ports, pwr : string;
begin
  //OnFwdSync(ports, pwr, turnpct)
  op := Value;
  Next;
  OpenParen;
  // ports
  ports := GetDecoratedValue;
  Next;
  MatchString(TOK_COMMA);
  // pwr
  BoolExpression;
  push;
  pwr := tos;
  EmitLn(Format('mov %s, %s',[pwr, RegisterName]));
  MatchString(TOK_COMMA);
  // turnpct
  BoolExpression;
  CloseParen;
  EmitLn(Format('%s(%s, %s, %s)',[op, ports, pwr, RegisterName]));
  pop;
end;

procedure TNXCComp.DoOnFwdRevSyncEx;
var
  op, ports, pwr, arg4 : string;
begin
  //OnFwdSyncEx(ports, pwr, turnpct, reset)
  //OnRevSyncEx(ports, pwr, turnpct, reset)
  op := Value;
  Next;
  OpenParen;
  // ports
  ports := GetDecoratedValue;
  Next;
  MatchString(TOK_COMMA);
  // pwr
  BoolExpression;
  push;
  pwr := tos;
  EmitLn(Format('mov %s, %s',[pwr, RegisterName]));
  MatchString(TOK_COMMA);
  // turnpct
  BoolExpression;
  MatchString(TOK_COMMA);
  // reset
  CheckNumeric;
  arg4 := Value;
  Next;
  CloseParen;
  EmitLn(Format('%s(%s, %s, %s, %s)',[op, ports, pwr, RegisterName, arg4]));
  pop;
end;

procedure TNXCComp.DoOnFwdRevRegPID;
var
  op, arg1, svar, regvar, pvar, ivar : string;
begin
  //OnFwdReg(ports, pwr, regmode, p, i, d)
  //OnRevReg(ports, pwr, regmode, p, i, d)
  op := Value;
  Next;
  OpenParen;
  // ports
  arg1 := GetDecoratedValue;
  Next;
  MatchString(TOK_COMMA);
  // pwr
  BoolExpression;
  push;
  svar := tos;
  EmitLn(Format('mov %s, %s',[svar, RegisterName]));
  MatchString(TOK_COMMA);
  // regmode
  BoolExpression;
  push;
  regvar := tos;
  EmitLn(Format('mov %s, %s',[regvar, RegisterName]));
  MatchString(TOK_COMMA);
  // p
  BoolExpression;
  push;
  pvar := tos;
  EmitLn(Format('mov %s, %s',[pvar, RegisterName]));
  MatchString(TOK_COMMA);
  // i
  BoolExpression;
  push;
  ivar := tos;
  EmitLn(Format('mov %s, %s',[ivar, RegisterName]));
  MatchString(TOK_COMMA);
  // d
  BoolExpression;
  CloseParen;
  EmitLn(Format('%s(%s, %s, %s, %s, %s, %s)',[op, arg1, svar, regvar, pvar, ivar, RegisterName]));
  pop;
  pop;
  pop;
  pop;
end;

procedure TNXCComp.DoOnFwdRevRegExPID;
var
  op, arg1, svar, arg4, regvar, pvar, ivar : string;
begin
  //OnFwdRegExPID(ports, pwr, regmode, reset, p, i, d)
  //OnRevRegExPID(ports, pwr, regmode, reset, p, i, d)
  op := Value;
  Next;
  OpenParen;
  // ports
  arg1 := GetDecoratedValue;
  Next;
  MatchString(TOK_COMMA);
  // pwr
  BoolExpression;
  push;
  svar := tos;
  EmitLn(Format('mov %s, %s',[svar, RegisterName]));
  MatchString(TOK_COMMA);
  // regmode
  BoolExpression;
  push;
  regvar := tos;
  EmitLn(Format('mov %s, %s',[regvar, RegisterName]));
  MatchString(TOK_COMMA);
  // reset
  CheckNumeric;
  arg4 := Value;
  MatchString(TOK_COMMA);
  // p
  BoolExpression;
  push;
  pvar := tos;
  EmitLn(Format('mov %s, %s',[pvar, RegisterName]));
  MatchString(TOK_COMMA);
  // i
  BoolExpression;
  push;
  ivar := tos;
  EmitLn(Format('mov %s, %s',[ivar, RegisterName]));
  MatchString(TOK_COMMA);
  // d
  BoolExpression;
  CloseParen;
  EmitLn(Format('%s(%s, %s, %s, %s, %s, %s, %s)',[op, arg1, svar, regvar, arg4, pvar, ivar, RegisterName]));
  pop;
  pop;
  pop;
  pop;
end;

procedure TNXCComp.DoOnFwdRevSyncPID;
var
  op, ports, pwr, turnvar, pvar, ivar : string;
begin
  //OnFwdSyncPID(ports, pwr, turnpct, p, i, d)
  //OnRevSyncPID(ports, pwr, turnpct, p, i, d)
  op := Value;
  Next;
  OpenParen;
  // ports
  ports := GetDecoratedValue;
  Next;
  MatchString(TOK_COMMA);
  // pwr
  BoolExpression;
  push;
  pwr := tos;
  EmitLn(Format('mov %s, %s',[pwr, RegisterName]));
  MatchString(TOK_COMMA);
  // turnpct
  BoolExpression;
  push;
  turnvar := tos;
  EmitLn(Format('mov %s, %s',[turnvar, RegisterName]));
  MatchString(TOK_COMMA);
  // p
  BoolExpression;
  push;
  pvar := tos;
  EmitLn(Format('mov %s, %s',[pvar, RegisterName]));
  MatchString(TOK_COMMA);
  // i
  BoolExpression;
  push;
  ivar := tos;
  EmitLn(Format('mov %s, %s',[ivar, RegisterName]));
  MatchString(TOK_COMMA);
  // d
  BoolExpression;
  CloseParen;
  EmitLn(Format('%s(%s, %s, %s, %s, %s, %s)',[op, ports, pwr, turnvar, pvar, ivar, RegisterName]));
  pop;
  pop;
  pop;
  pop;
end;

procedure TNXCComp.DoOnFwdRevSyncExPID;
var
  op, ports, pwr, arg4, turnvar, pvar, ivar : string;
begin
  //OnFwdSyncExPID(ports, pwr, turnpct, reset, p, i, d)
  //OnRevSyncExPID(ports, pwr, turnpct, reset, p, i, d)
  op := Value;
  Next;
  OpenParen;
  // ports
  ports := GetDecoratedValue;
  Next;
  MatchString(TOK_COMMA);
  // pwr
  BoolExpression;
  push;
  pwr := tos;
  EmitLn(Format('mov %s, %s',[pwr, RegisterName]));
  MatchString(TOK_COMMA);
  // turnpct
  BoolExpression;
  push;
  turnvar := tos;
  EmitLn(Format('mov %s, %s',[turnvar, RegisterName]));
  MatchString(TOK_COMMA);
  // reset
  CheckNumeric;
  arg4 := Value;
  MatchString(TOK_COMMA);
  // p
  BoolExpression;
  push;
  pvar := tos;
  EmitLn(Format('mov %s, %s',[pvar, RegisterName]));
  MatchString(TOK_COMMA);
  // i
  BoolExpression;
  push;
  ivar := tos;
  EmitLn(Format('mov %s, %s',[ivar, RegisterName]));
  MatchString(TOK_COMMA);
  // d
  BoolExpression;
  CloseParen;
  EmitLn(Format('%s(%s, %s, %s, %s, %s, %s, %s)',[op, ports, pwr, turnvar, arg4, pvar, ivar, RegisterName]));
  pop;
  pop;
  pop;
  pop;
end;

procedure TNXCComp.DoRotateMotors(idx: integer);
var
  op, ports, pwr, angle, turnpct, bsync, bstop, p, i : string;
begin
  //RotateMotor(ports, pwr, angle)
  //RotateMotorEx(ports, pwr, angle, turnpct, bSync, bStop)
  //RotateMotorPID(ports, pwr, angle, p, i, d)
  //RotateMotorExPID(ports, pwr, angle, turnpct, bSync, bStop, p, i, d)
  op := Value;
  Next;
  OpenParen;
  // ports
  ports := GetDecoratedValue;
  Next;
  MatchString(TOK_COMMA);
  // power
  BoolExpression;
  push;
  pwr := tos;
  EmitLn(Format('mov %s, %s',[pwr, RegisterName]));
  MatchString(TOK_COMMA);
  // angle
  BoolExpression;
  if idx = API_ROTATEMOTOR then
  begin
    // RotateMotor
    CloseParen;
    EmitLn(Format('%s(%s, %s, %s)', [op, ports, pwr, RegisterName]))
  end
  else if idx = API_ROTATEMOTORPID then
  begin
    // RotateMotorPID
    push;
    angle := tos;
    EmitLn(Format('mov %s, %s',[angle, RegisterName]));
    MatchString(TOK_COMMA);
    // P
    BoolExpression;
    push;
    p := tos;
    EmitLn(Format('mov %s, %s',[p, RegisterName]));
    MatchString(TOK_COMMA);
    // I
    BoolExpression;
    push;
    i := tos;
    EmitLn(Format('mov %s, %s',[i, RegisterName]));
    MatchString(TOK_COMMA);
    // D
    BoolExpression;
    CloseParen;
    EmitLn(Format('%s(%s, %s, %s, %s, %s, %s)', [op, ports, pwr, angle, p, i, RegisterName]));
    pop;
    pop;
    pop;
  end
  else
  begin
    // RotateMotorEx or RotateMotorExPID
    push;
    angle := tos;
    EmitLn(Format('mov %s, %s',[angle, RegisterName]));
    MatchString(TOK_COMMA);
    // turn pct
    BoolExpression;
    push;
    turnpct := tos;
    EmitLn(Format('mov %s, %s',[turnpct, RegisterName]));
    MatchString(TOK_COMMA);
    // bsync
    BoolExpression;
    push;
    bsync := tos;
    EmitLn(Format('mov %s, %s',[bsync, RegisterName]));
    MatchString(TOK_COMMA);
    // bStop
    BoolExpression;
    if idx = API_ROTATEMOTOREX then
    begin
      CloseParen;
      EmitLn(Format('%s(%s, %s, %s, %s, %s, %s)', [op, ports, pwr, angle, turnpct, bsync, RegisterName]));
    end
    else
    begin
      // RotateMotorExPID
      push;
      bstop := tos;
      EmitLn(Format('mov %s, %s',[bstop, RegisterName]));
      MatchString(TOK_COMMA);
      // P
      BoolExpression;
      push;
      p := tos;
      EmitLn(Format('mov %s, %s',[p, RegisterName]));
      MatchString(TOK_COMMA);
      // I
      BoolExpression;
      push;
      i := tos;
      EmitLn(Format('mov %s, %s',[i, RegisterName]));
      MatchString(TOK_COMMA);
      // D
      BoolExpression;
      CloseParen;
      EmitLn(Format('%s(%s, %s, %s, %s, %s, %s, %s, %s, %s)', [op, ports, pwr, angle, turnpct, bsync, bstop, p, i, RegisterName]));
      pop;
      pop;
      pop;
    end;
    pop;
    pop;
    pop;
  end;
  pop;
end;

procedure TNXCComp.DoClearSetResetSensor;
var
  op, port : string;
begin
  //ClearSensor(port)
  //SetSensorTouch(port)
  //SetSensorLight(port)
  //SetSensorSound(port)
  //SetSensorLowspeed(port)
  //ResetSensor(port)
  op := Value;
  Next;
  OpenParen;
  // port
  port := GetDecoratedValue;
  Next;
  CloseParen;
  EmitLn(op + TOK_OPENPAREN + port + TOK_CLOSEPAREN);
end;

procedure TNXCComp.DoSetSensorTypeMode(idx : integer);
var
  port : string;
begin
  //SetSensorType(port,type)
  //SetSensorMode(port,mode)
  Next;
  OpenParen;
  // port
  port := GetDecoratedValue;
  Next;
  MatchString(TOK_COMMA);
  // type/mode
  BoolExpression;
  CloseParen;
  if idx = API_SETSENSORTYPE then
    EmitLn(Format('setin %s, %s, Type',[RegisterName, port]))
  else
    EmitLn(Format('setin %s, %s, InputMode',[RegisterName, port]));
end;

procedure TNXCComp.DoAcquireRelease;
var
  op, val : string;
begin
 // Acquire(mutex);
 // Release(mutex);
  op := LowerCase(Value);
  Next;
  OpenParen;
  // mutex
  val := GetDecoratedValue;
  CheckIdent;
  CheckGlobal(val); // mutex must be a global variable
  if DataType(val) <> TOK_MUTEXDEF then
    Expected(sMutexType);
  Next;
  CloseParen;
  EmitLn(op + ' ' + val);
end;

procedure TNXCComp.DoPrecedesFollows;
var
  op, val : string;
begin
  // Precedes(x, y, z, ...);
  // Follows(x, y, z);
  op := LowerCase(Value);
  Next;
  OpenParen;
  val := Value;
  CheckIdent;
  CheckGlobal(val); // task names must be global
  if DataType(val) <> TOK_TASK then
    Expected(sTaskName);
  Next;
  while Value = TOK_COMMA do
  begin
    val := val + Value; // the comma
    Next;
    CheckIdent;
    CheckGlobal(Value);
    val := val + ' ' + Value; // the next value
    Next;
  end;
  CloseParen;
  EmitLn(op + ' ' + val);
end;

procedure TNXCComp.DoExitTo;
var
  op, val : string;
begin
  // ExitTo(task);
  op := LowerCase(Value);
  Next;
  OpenParen;
  // task
  val := Value;
  CheckIdent;
  CheckGlobal(val); // must be global name
  if DataType(val) <> TOK_TASK then
    Expected(sTaskName);
  Next;
  CloseParen;
  EmitLn(op + ' ' + val);
end;

procedure TNXCComp.DoStop;
begin
  // Stop(stop?);
  Next;
  OpenParen;
  // stop?
  BoolExpression;
  CloseParen;
  EmitLn(Format('stop %s',[RegisterName]));
end;

procedure TNXCComp.DoGoto;
begin
  // goto labelName;
  Next;
  // labelName
  CheckIdent;
  Branch(Value);
//  EmitLn(Format('jmp %s',[Value]));
  Next;
end;

procedure TNXCComp.DoSetInputOutput(const idx: integer);
var
  port, pchk, field, val, asmstr : string;
  i, cnt, iport : integer;
begin
  // SetInput(port, field, value)
  // SetOutput(ports, field, value [, field, value, ...])
  Next;
  OpenParen;
  // port
  port := GetDecoratedValue;
  Next;
  MatchString(TOK_COMMA);
  // field
  CheckNumeric;
  field := Value;
  Next;
  MatchString(TOK_COMMA);
  // value
  BoolExpression;
  if idx = API_SETINPUT then
  begin
    // SetInput
    CloseParen;
    EmitLn(Format('setin %s, %s, %s', [RegisterName, port, field]));
  end
  else
  begin
    // setout can take additional optional field/value pairs
    cnt := 0;
    pchk := port;
    if idx = API_SETOUTPUT then
    begin
      iport := StrToIntDef(port, 0);
      case iport of
        OUT_AB  : port := '__OUT_AB';
        OUT_AC  : port := '__OUT_AC';
        OUT_BC  : port := '__OUT_BC';
        OUT_ABC : port := '__OUT_ABC';
      end;
    end;
    asmstr := Format('setout %s, %s', [port, field]);
    while (Token = TOK_COMMA) and not endofallsource do
    begin
      inc(cnt);
      push;
      val := tos;
      EmitLn(Format('mov %s, %s',[val, RegisterName]));
      Next;
      // field
      CheckNumeric;
      field := Value;
      Next;
      MatchString(TOK_COMMA);
      // value
      BoolExpression;
      asmstr := asmstr + Format(', %s, %s', [val, field]);
    end;
    CloseParen;
    asmstr := asmstr + Format(', %s', [RegisterName]);
    EmitLn(Format('compif EQ, isconst(%s), FALSE', [pchk]));
    EmitLn(asmstr);
    EmitLn('compelse');
    EmitLn(Format('compchk LT, %s, 0x07', [pchk]));
    EmitLn(Format('compchk GTEQ, %s, 0x00', [pchk]));
    EmitLn(asmstr);
    EmitLn('compend');
    for i := 0 to cnt - 1 do
      pop;
  end;
end;

procedure TNXCComp.DoReturn;
var
  dt : char;
  idx : integer;
  bFuncStyle : boolean;
begin
  // return
  idx := GlobalIdx(fCurrentThreadName);
  if GS_Type[idx] <> TOK_PROCEDURE then
    AbortMsg(sReturnInvalid);
  dt := FunctionReturnType(fCurrentThreadName);
  Next;
  // leave return value on "stack"
  if dt = TOK_STRINGDEF then
  begin
    bFuncStyle := Token = TOK_OPENPAREN;
    if bFuncStyle then
      Next;
    StringExpression('');
    if bFuncStyle then
      Next;
  end
  else if IsUDT(dt) or IsArrayType(dt) then
  begin
    // currently this code only supports returning a variable for UDTs or Arrays
    // TODO : add support for an array or UDT expression
    bFuncStyle := Token = TOK_OPENPAREN;
    if bFuncStyle then
      Next;
    fLHSDataType := dt;
    fLHSName := Format('__result_%s',[fCurrentThreadName]);
    try
      NumericFactor;
    finally
      fLHSDataType := TOK_LONGDEF;
      fLHSName := '';
    end;
{
    // 2008-12-14 JCH - needed the decorated value rather than just Value
    EmitLn(Format('mov __result_%s, %s',[fCurrentThreadName, GetDecoratedValue]));
    // 2008-12-14 JCH The next line fixes a bug where parser gets out
    // of sync with the end of the return statement
    Next; // move to the ')' or ';'
}
    if bFuncStyle then
      Next;
  end
  else if dt <> #0 then
  begin
    BoolExpression;
    if (dt in UnsignedIntegerTypes) and (StatementType <> stUnsigned) then
      EmitLn(Format('mov %s, %s', [UnsignedRegisterName, RegisterName])); 
  end;
//  Semi;
  EmitLn('return');
end;

procedure TNXCComp.DoResetCounters;
var
  op, arg1 : string;
begin
  // ResetTachoCount(ports)  (etc...)
  op := Value;
  Next;
  OpenParen;
  // ports
  arg1 := GetDecoratedValue;
  Next;
  CloseParen;
  EmitLn(op + TOK_OPENPAREN + arg1 + TOK_CLOSEPAREN);
end;

procedure TNXCComp.DoStopMotors;
var
  op, arg1 : string;
begin
  // Off(ports)
  // Coast(ports)
  // Float(ports)
  op := Value;
  Next;
  OpenParen;
  // ports
  arg1 := GetDecoratedValue;
  Next;
  CloseParen;
  EmitLn(op + TOK_OPENPAREN + arg1 + TOK_CLOSEPAREN);
end;

procedure TNXCComp.DoStopMotorsEx;
var
  op, arg1, arg2 : string;
begin
  // OffEx(ports, reset)
  // CoastEx(ports, reset)
  op := Value;
  Next;
  OpenParen;
  // ports
  arg1 := GetDecoratedValue;
  Next;
  MatchString(TOK_COMMA);
  // reset
  CheckNumeric;
  arg2 := Value;
  Next;
  CloseParen;
  EmitLn(Format('%s(%s, %s)', [op, arg1, arg2]));
end;

procedure TNXCComp.PreProcess;
var
  P : TLangPreprocessor;
  i, idx : integer;
  tmpFile, tmpMsg : string;
begin
  P := TLangPreprocessor.Create(GetPreProcLexerClass, ExtractFilePath(ParamStr(0)), lnNXC);
  try
    P.AddPoundLineToMultiLineMacros := True;
    P.Defines.AddDefines(Defines);
    if EnhancedFirmware then
      P.Defines.Define('__ENHANCED_FIRMWARE');
    P.Defines.AddEntry('__FIRMWARE_VERSION', IntToStr(FirmwareVersion));
    P.AddIncludeDirs(IncludeDirs);
    if not IgnoreSystemFile then
    begin
      P.SkipIncludeFile('NBCCommon.h');
      P.SkipIncludeFile('NXCDefs.h');
    end;
    P.Preprocess(CurrentFile, fMS);
    for i := 0 to P.Warnings.Count - 1 do
    begin
      tmpMsg := P.Warnings.ValueFromIndex[i];
      idx := Pos('|', tmpMsg);
      tmpFile := Copy(tmpMsg, 1, idx-1);
      Delete(tmpMsg, 1, idx);
      ReportProblem(StrToIntDef(P.Warnings.Names[i], 0), tmpFile, tmpMsg, false);
    end;
  finally
    P.Free;
  end;
end;

procedure TNXCComp.ProcessDirectives(bScan : boolean);
begin
  while Token = TOK_DIRECTIVE do
  begin
    // look for #line statements
    if LowerCase(Value) = '#line' then
    begin
      SkipDirectiveLine;
      HandlePoundLine;
      Next(False);
    end
    else
    begin
      SkipDirectiveLine;
      Next(False);
    end;
    EmitLn(Trim(fDirLine));
    if bScan then
      Scan;
  end;
end;

procedure TNXCComp.HandlePoundLine;
var
  i : integer;
  tmpLine, tmpFile : string;
begin
  i := Pos('#line ', fDirLine);
  if i = 1 then
  begin
    // this is a special preprocessor line
    tmpLine := Trim(fDirLine);
    Delete(tmpLine, 1, 6);
    i := Pos(' ', tmpLine);
    linenumber{[slevel]} := StrToIntDef(Copy(tmpLine, 1, i - 1), linenumber{[slevel]});
    IncLineNumber;
    Delete(tmpLine, 1, i);
    tmpFile      := Replace(tmpLine, '"', '');
    CurrentFile  := tmpFile;
  end;
end;

procedure TNXCComp.IncLineNumber;
begin
  linenumber := linenumber + 1;
  inc(totallines);
end;

function TNXCComp.APIFuncNameToID(procname: string): integer;
begin
  Result := StrToIntDef(fAPIFunctions.Values[procname], 0);
end;

function TNXCComp.APIStrFuncNameToID(procname: string): integer;
begin
  Result := StrToIntDef(fAPIStrFunctions.Values[procname], 0);
end;

function TNXCComp.IsAPIFunc(procname: string): boolean;
begin
  Result := fAPIFunctions.IndexOfName(procname) <> -1;
end;

function TNXCComp.IsAPIStrFunc(procname: string): boolean;
begin
  Result := fAPIStrFunctions.IndexOfName(procname) <> -1;
end;

procedure TNXCComp.AddAPIFunction(const name: string; id: integer);
begin
  fAPIFunctions.Add(name + '=' + IntToStr(id));
end;

procedure TNXCComp.AddAPIStringFunction(const name: string; id: integer);
begin
  fAPIStrFunctions.Add(name + '=' + IntToStr(id));
end;

function TNXCComp.tos : string;
begin
  Result := fStackVarNames[fStackVarNames.Count - 1];
  // set statement type based on type on top of stack
  if Pos('__float_stack_', Result) <> 0 then
    StatementType := stFloat
  else if (Pos('__signed_stack_', Result) <> 0) and (StatementType <> stFloat) then
    StatementType := stSigned;
{
  if fStatementType = stFloat then
    Result := Format('__float_stack_%3.3d%s', [fStackDepth, fCurrentThreadName])
  else if fStatementType = stUnsigned then
    Result := Format('__unsigned_stack_%3.3d%s', [fStackDepth, fCurrentThreadName])
  else
    Result := Format('__signed_stack_%3.3d%s', [fStackDepth, fCurrentThreadName]);
}
end;

function TNXCComp.TempSignedByteName: string;
begin
  Result := Format('__tmpsbyte%s', [fCurrentThreadName]);
end;

function TNXCComp.TempSignedWordName: string;
begin
  Result := Format('__tmpsword%s', [fCurrentThreadName]);
end;

function TNXCComp.TempSignedLongName: string;
begin
  Result := Format('__tmpslong%s', [fCurrentThreadName]);
end;

function TNXCComp.TempUnsignedLongName: string;
begin
  Result := Format('__tmplong%s', [fCurrentThreadName]);
end;

function TNXCComp.TempFloatName: string;
begin
  Result := Format('__tmpfloat%s', [fCurrentThreadName]);
end;

function TNXCComp.RegisterName(name : string): string;
begin
  if fUDTOnStack <> '' then
  begin
    Result := fUDTOnStack;
  end
  else
  begin
    if fStatementType = stFloat then
      Result := FloatRegisterName(name)
    else if fStatementType = stUnsigned then
      Result := UnsignedRegisterName(name)
    else
    Result := SignedRegisterName(name);
  end;
end;

function TNXCComp.SignedRegisterName(name: string): string;
begin
  if name = '' then
    name := fCurrentThreadName;
  Result := Format('__D0%s',[name]);
end;

function TNXCComp.UnsignedRegisterName(name: string): string;
begin
  if name = '' then
    name := fCurrentThreadName;
  Result := Format('__DU0%s',[name]);
end;

function TNXCComp.FloatRegisterName(name: string): string;
begin
  if name = '' then
    name := fCurrentThreadName;
  Result := Format('__DF0%s',[name]);
end;

function TNXCComp.ZeroFlag: string;
begin
  Result := Format('__zf%s', [fCurrentThreadName]);
end;

function TNXCComp.StrTmpBufName(name : string): string;
begin
  if name = '' then
    name := fCurrentThreadName;
  Result := Format('__strtmpbuf%s', [name]);
end;

function TNXCComp.StrBufName(name : string): string;
begin
  if name = '' then
    name := fCurrentThreadName;
  Result := Format('__strbuf%s', [name]);
end;

function TNXCComp.StrRetValName(name : string): string;
begin
  if name = '' then
    name := fCurrentThreadName;
  Result := Format('__strretval%s', [name]);
end;

procedure TNXCComp.EmitRegisters;
var
  j, k, idx, LastRegIdx : integer;
  f : TInlineFunction;
  H : TArrayHelperVar;
  dt : Char;
  name, tname : string;
  function EmitFmt(const idx : integer) : string;
  begin
    Result := REGVARS_ARRAY[idx] + ' ' + REGVARTYPES_ARRAY[idx];
  end;
begin
  LastRegIdx := High(REGVARS_ARRAY);
  if FirmwareVersion < MIN_FW_VER2X then
    dec(LastRegIdx, 2);
  for j := 0 to fArrayHelpers.Count - 1 do
  begin
    H  := fArrayHelpers[j];
    dt := H.DataType;
    name  := H.Name;
    tname := GlobalTypeName(name);
    AllocateHelper(name, DataTypeToArrayDimensions(dt), '', tname, dt);
  end;
  for j := 0 to fThreadNames.Count - 1 do
  begin
    name := fThreadNames[j];
    if fInlineFunctions.IndexOfName(name) = -1 then
    begin
      for idx := Low(REGVARS_ARRAY) to LastRegIdx do
        EmitLn(Format(EmitFmt(idx), [name]));
      dt := FunctionReturnType(name);
      if IsUDT(dt) or IsArrayType(dt) then
      begin
        tname := GlobalTypeName(name);
        AllocateHelper(Format('__result_%s', [name]), DataTypeToArrayDimensions(dt), '', tname, dt);
      end;
    end;
  end;
  for j := 0 to fInlineFunctions.Count - 1 do
  begin
    f := fInlineFunctions[j];
    for k := 0 to f.Callers.Count - 1 do
    begin
      name := InlineName(f.Callers[k], f.Name);
      for idx := Low(REGVARS_ARRAY) to LastRegIdx do
        EmitLn(Format(EmitFmt(idx), [name]));
      dt := FunctionReturnType(f.Name);
      if IsUDT(dt) or IsArrayType(dt) then
      begin
        tname := GlobalTypeName(f.Name);
        AllocateHelper(Format('__result_%s', [name]), DataTypeToArrayDimensions(dt), '', tname, dt);
      end;
    end;
  end;
end;

procedure TNXCComp.EmitStackVariables;
var
  i, j, k : integer;
  f : TInlineFunction;
  name : string;
begin
  for j := 0 to fThreadNames.Count - 1 do
  begin
    name := fThreadNames[j];
    if fInlineFunctions.IndexOfName(name) = -1 then
    begin
      for i := 1 to MaxStackDepth do begin
        EmitLn(Format('__signed_stack_%3.3d%s slong', [i, name]));
      end;
      for i := 1 to MaxStackDepth do begin
        EmitLn(Format('__unsigned_stack_%3.3d%s long', [i, name]));
      end;
      if FirmwareVersion >= MIN_FW_VER2X then
      begin
        for i := 1 to MaxStackDepth do begin
          EmitLn(Format('__float_stack_%3.3d%s float', [i, name]));
        end;
      end;
    end;
  end;
  for j := 0 to fInlineFunctions.Count - 1 do
  begin
    f := fInlineFunctions[j];
    for k := 0 to f.Callers.Count - 1 do
    begin
      name := InlineName(f.Callers[k], f.Name);
      for i := 1 to MaxStackDepth do begin
        EmitLn(Format('__signed_stack_%3.3d%s slong', [i, name]));
      end;
      for i := 1 to MaxStackDepth do begin
        EmitLn(Format('__unsigned_stack_%3.3d%s long', [i, name]));
      end;
      if FirmwareVersion >= MIN_FW_VER2X then
      begin
        for i := 1 to MaxStackDepth do begin
          EmitLn(Format('__float_stack_%3.3d%s float', [i, name]));
        end;
      end;
    end;
  end;
end;

const
  APISF_NUMTOSTR   = 0;
  APISF_STRCAT     = 1;
  APISF_SUBSTR     = 2;
  APISF_FLATTEN    = 3;
  APISF_STRREPLACE = 4;
  APISF_FORMATNUM  = 5;

procedure TNXCComp.StringFunction(const Name : string);
var
  id : integer;
  op : string;
begin
  id := APIStrFuncNameToID(Name);
  case id of
    APISF_NUMTOSTR, APISF_FLATTEN : begin
      OpenParen;
      BoolExpression;
      CloseParen;
      if id = APISF_NUMTOSTR then
        op := 'numtostr'
      else
        op := 'flatten';
      EmitLn(Format('%s %s, %s', [op, StrRetValName, RegisterName]));
    end;
    APISF_STRCAT : DoStrCat;
    APISF_SUBSTR : DoSubString;
    APISF_STRREPLACE : DoStrReplace;
    APISF_FORMATNUM : DoFormatNum;
  end;
end;

procedure TNXCComp.DoStrReplace;
var
  str, strnew : string;
begin
  // StrReplace(string, idx, strnew)
  OpenParen;
  // string
  str := GetDecoratedValue;
  CheckString;
  Next;
  MatchString(TOK_COMMA);
  // idx
  BoolExpression;
  MatchString(TOK_COMMA);
  // strnew
  strnew := GetDecoratedValue;
  CheckString;
  Next;
  CloseParen;
  EmitLn(Format('strtoarr %s, %s', [StrBufName, strnew]));
  EmitLn(Format('strreplace %s, %s, %s, %s', [StrRetValName, str, RegisterName, StrBufName]));
end;

procedure TNXCComp.DoStrCat;
var
  asmStr : string;
begin
  // StrCat(str1, str2, ..., strN)
  OpenParen;
  CheckString;
  asmStr := Format('strcat %s, %s', [StrRetValName, GetDecoratedValue]);
  Next;
  while Token = TOK_COMMA do begin
    Next;
    CheckString;
    asmStr := asmStr + ', ' + GetDecoratedValue;
    Next;
  end;
  CloseParen;
  EmitLn(asmStr);
end;

procedure TNXCComp.DoSubString;
var
  str, idx : string;
begin
  // SubStr(string, idx, len)
  OpenParen;
  // string
  str := GetDecoratedValue;
  CheckString;
  Next;
  MatchString(TOK_COMMA);
  // idx
  BoolExpression;
  push;
  idx := tos;
  EmitLn(Format('mov %s, %s', [idx, RegisterName]));
  MatchString(TOK_COMMA);
  // len
  BoolExpression;
  CloseParen;
  EmitLn(Format('strsubset %s, %s, %s, %s', [StrRetValName, str, idx, RegisterName]));
  pop;
end;

const
  APIF_ABS              = 0;
  APIF_SIGN             = 1;
  APIF_RANDOM           = 2;
  APIF_GETINPUT         = 3;
  APIF_GETOUTPUT        = 4;
  APIF_RESETSCREEN      = 7;
  APIF_TEXTOUT          = 8;
  APIF_NUMOUT           = 9;
  APIF_PLAYTONEEX       = 12;
  APIF_PLAYFILEEX       = 13;
  APIF_BUTTONPRESSED    = 18;
  APIF_BUTTONCOUNT      = 19;
  APIF_READBUTTONEX     = 20;
  APIF_DRAWPOINT        = 22;
  APIF_DRAWLINE         = 23;
  APIF_DRAWCIRCLE       = 24;
  APIF_DRAWRECT         = 25;
  APIF_DRAWGRAPHIC      = 26;
  APIF_DRAWGRAPHICEX    = 27;
  APIF_STRTONUM         = 31;
  APIF_STRLEN           = 32;
  APIF_STRINDEX         = 33;
  APIF_ASM              = 34;
  APIF_DRAWGRAPHICAR    = 35;
  APIF_DRAWGRAPHICAREX  = 36;
  APIF_DRAWPOLY         = 37;
  APIF_DRAWELLIPSE      = 38;
  APIF_FONTTEXTOUT      = 39;
  APIF_FONTNUMOUT       = 40;

procedure TNXCComp.DoCallAPIFunc(procname: string);
var
  arg, parg, op, asmStr : string;
  id : integer;
  dt : char;
begin
  fCCSet := False;
  ResetStatementType;
  id := APIFuncNameToID(procname);
  case id of
    APIF_ASM : begin
      dt := #0;
      DoAsm(dt);
      fSemiColonRequired := True;
    end;
    APIF_RANDOM : begin
      OpenParen;
      if Value = TOK_CLOSEPAREN then
      begin
        CloseParen;
        EmitLn(Format('SignedRandom(%0:s)', [RegisterName]));
      end
      else
      begin
        BoolExpression;
        CloseParen;
        EmitLn(Format('Random(%0:s, %0:s)', [RegisterName]));
      end;
    end;
    APIF_ABS, APIF_SIGN :
    begin
      OpenParen;
      BoolExpression;
      CloseParen;
      case id of
        APIF_ABS : asmStr := 'abs %0:s, %0:s';
        APIF_SIGN : asmStr := 'sign %0:s, %0:s';
      end;
      EmitLn(Format(asmStr, [RegisterName]));
    end;
    APIF_GETINPUT, APIF_GETOUTPUT :
    begin
      // GetInput(port, field)
      // GetOutput(port, field)
      OpenParen;
      // port
      parg := GetDecoratedValue;
      Next;
      MatchString(TOK_COMMA);
      // field
      CheckNumeric;
      arg := Value;
      Next;
      CloseParen;
      case id of
        APIF_GETINPUT  : op := 'getin';
        APIF_GETOUTPUT : op := 'getout';
      end;
      EmitLn(Format('%s %s, %s, %s', [op, RegisterName, parg, arg]));
    end;
    APIF_RESETSCREEN : DoResetScreen;
    APIF_TEXTOUT, APIF_NUMOUT : DoTextNumOut(id);
    APIF_PLAYTONEEX : DoPlayToneEx;
    APIF_PLAYFILEEX : DoPlayFileEx;
    APIF_BUTTONPRESSED, APIF_BUTTONCOUNT, APIF_READBUTTONEX : DoReadButton(id);
    APIF_DRAWPOINT : DoDrawPoint;
    APIF_DRAWLINE, APIF_DRAWRECT : DoDrawLineRect(id);
    APIF_DRAWCIRCLE : DoDrawCircle;
    APIF_DRAWGRAPHIC,
    APIF_DRAWGRAPHICEX,
    APIF_DRAWGRAPHICAR,
    APIF_DRAWGRAPHICAREX : DoDrawGraphic(id);
    APIF_STRTONUM : DoStrToNum;
    APIF_STRLEN : DoStrLen;
    APIF_STRINDEX : DoStrIndex;
    APIF_DRAWPOLY : DoDrawPoly;
    APIF_DRAWELLIPSE : DoDrawEllipse;
    APIF_FONTTEXTOUT, APIF_FONTNUMOUT : DoFontTextNumOut(id);
  end;
end;

procedure TNXCComp.DoStrIndex;
var
  arg : string;
begin
  // StrIndex(string, idx)
  OpenParen;
  // string
  arg := GetDecoratedValue;
  CheckString;
  Next;
  MatchString(TOK_COMMA);
  // idx
  BoolExpression;
  CloseParen;
  EmitLn(Format('strindex %0:s, %s, %0:s',[RegisterName, arg]));
end;

procedure TNXCComp.DoStrLen;
var
  arg : string;
begin
  // StrLen(string)
  OpenParen;
  // string
  arg := GetDecoratedValue;
  CheckString;
  Next;
  CloseParen;
  EmitLn(Format('strlen %s, %s', [RegisterName, arg]));
end;

procedure TNXCComp.DoStrToNum;
var
  arg : string;
begin
  // StrToNum(string)
  OpenParen;
  // string
  arg := GetDecoratedValue;
  CheckString;
  Next;
  CloseParen;
  push;
  EmitLn(Format('strtonum %0:s, %s, %s, NA, NA', [RegisterName, tos, arg]));
  pop;
end;

procedure TNXCComp.DoResetScreen;
begin
  OpenParen;
  CloseParen;
  EmitLn('acquire __SSMArgsMutex');
  EmitLn('set __SSMArgs.ScreenMode, 0');
  EmitLn('syscall SetScreenMode, __SSMArgs');
  EmitLn(Format('mov %s, __SSMArgs.Result', [RegisterName]));
  EmitLn('release __SSMArgsMutex');
end;

procedure TNXCComp.DoTextNumOut(idx: integer);
var
  x, y, txt, val : string;
  bCls : boolean;
begin
  //TextOut(x,y,txt,options=false)
  //NumOut(x,y,num,options=false)
  OpenParen;
  // arg1 = x
  BoolExpression;
  push;
  x := tos;
  EmitLn(Format('mov %s, %s', [x, RegisterName]));
  MatchString(TOK_COMMA);
  // arg2 = y
  BoolExpression;
  push;
  y := tos;
  EmitLn(Format('mov %s, %s', [y, RegisterName]));
  MatchString(TOK_COMMA);
  if idx = APIF_NUMOUT then
  begin
    BoolExpression;
    bCls := Token = TOK_COMMA;
    if bCls then
    begin
      push;
      val := tos;
      EmitLn(Format('mov %s, %s', [val, RegisterName]));
      MatchString(TOK_COMMA);
      // arg4 = cls
      BoolExpression;
    end;
    CloseParen;
    EmitLn('acquire __TextOutMutex');
    EmitLn('mov __TextOutArgs.Location.X, ' + x);
    EmitLn('mov __TextOutArgs.Location.Y, ' + y);
    if bCls then
    begin
      EmitLn('mov __TextOutArgs.Options, ' + RegisterName);
      EmitLn(Format('numtostr __TextOutArgs.Text, %s',[val]));
    end
    else
    begin
      EmitLn('set __TextOutArgs.Options, 0');
      EmitLn(Format('numtostr __TextOutArgs.Text, %s',[RegisterName]));
    end;
    EmitLn('syscall DrawText, __TextOutArgs');
    ResetStatementType;
    EmitLn(Format('mov %s, __TextOutArgs.Result',[RegisterName]));
    EmitLn('release __TextOutMutex');
    if bCls then
      pop;
  end
  else
  begin
    StringExpression('');
    txt := StrBufName;
    bCls := Token = TOK_COMMA;
    if bCls then
    begin
      MatchString(TOK_COMMA);
      // arg4 = cls
      BoolExpression;
    end;
    CloseParen;
    EmitLn('acquire __TextOutMutex');
    EmitLn('mov __TextOutArgs.Location.X, ' + x);
    EmitLn('mov __TextOutArgs.Location.Y, ' + y);
    if bCls then
      EmitLn('mov __TextOutArgs.Options, ' + RegisterName)
    else
      EmitLn('set __TextOutArgs.Options, 0');
    EmitLn('mov __TextOutArgs.Text, ' + txt);
    EmitLn('syscall DrawText, __TextOutArgs');
    ResetStatementType;
    EmitLn(Format('mov %s, __TextOutArgs.Result',[RegisterName]));
    EmitLn('release __TextOutMutex');
  end;
  pop;
  pop;
end;

procedure TNXCComp.DoFontTextNumOut(idx: integer);
var
  x, y, fntname, txt, val : string;
  bCls : boolean;
begin
  //FontTextOut(x,y,file,txt,options=false)
  //FontNumOut(x,y,file,num,options=false)
  OpenParen;
  // arg1 = x
  BoolExpression;
  push;
  x := tos;
  EmitLn(Format('mov %s, %s', [x, RegisterName]));
  MatchString(TOK_COMMA);
  // arg2 = y
  BoolExpression;
  push;
  y := tos;
  EmitLn(Format('mov %s, %s', [y, RegisterName]));
  MatchString(TOK_COMMA);
  // arg3 = file
  CheckString;
  fntname := Value;
  Next;
  MatchString(TOK_COMMA);
  if idx = APIF_FONTNUMOUT then
  begin
    BoolExpression;
    bCls := Token = TOK_COMMA;
    if bCls then
    begin
      push;
      val := tos;
      EmitLn(Format('mov %s, %s', [val, RegisterName]));
      MatchString(TOK_COMMA);
      // arg4 = cls
      BoolExpression;
    end;
    CloseParen;
    EmitLn('acquire __FontOutMutex');
    EmitLn('mov __FontOutArgs.Location.X, ' + x);
    EmitLn('mov __FontOutArgs.Location.Y, ' + y);
    EmitLn('mov __FontOutArgs.Filename, ' + fntname);
    if bCls then
    begin
      EmitLn('mov __FontOutArgs.Options, ' + RegisterName);
      EmitLn(Format('numtostr __FontOutArgs.Text, %s',[val]));
    end
    else
    begin
      EmitLn('set __FontOutArgs.Options, 0');
      EmitLn(Format('numtostr __FontOutArgs.Text, %s',[RegisterName]));
    end;
    EmitLn('syscall DrawFont, __FontOutArgs');
    ResetStatementType;
    EmitLn(Format('mov %s, __FontOutArgs.Result',[RegisterName]));
    EmitLn('release __FontOutMutex');
    if bCls then
      pop;
  end
  else
  begin
    StringExpression('');
    txt := StrBufName;
    bCls := Token = TOK_COMMA;
    if bCls then
    begin
      MatchString(TOK_COMMA);
      // arg4 = cls
      BoolExpression;
    end;
    CloseParen;
    EmitLn('acquire __FontOutMutex');
    EmitLn('mov __FontOutArgs.Location.X, ' + x);
    EmitLn('mov __FontOutArgs.Location.Y, ' + y);
    EmitLn('mov __FontOutArgs.Filename, ' + fntname);
    if bCls then
      EmitLn('mov __FontOutArgs.Options, ' + RegisterName)
    else
      EmitLn('set __FontOutArgs.Options, 0');
    EmitLn('mov __FontOutArgs.Text, ' + txt);
    EmitLn('syscall DrawFont, __FontOutArgs');
    ResetStatementType;
    EmitLn(Format('mov %s, __FontOutArgs.Result',[RegisterName]));
    EmitLn('release __FontOutMutex');
  end;
  pop;
  pop;
end;

procedure TNXCComp.DoDrawPoint;
var
  x, y : string;
  bCls : boolean;
begin
  //PointOut(x,y,cls=false)
  OpenParen;
  // arg1 = x
  BoolExpression;
  push;
  x := tos;
  EmitLn(Format('mov %s, %s', [x, RegisterName]));
  MatchString(TOK_COMMA);
  // arg2 = y
  BoolExpression;
  bCls := Token = TOK_COMMA;
  if bCls then
  begin
    push;
    y := tos;
    EmitLn(Format('mov %s, %s', [y, RegisterName]));
    MatchString(TOK_COMMA);
    // arg3 = cls
    BoolExpression;
  end;
  CloseParen;
  EmitLn('acquire __PointOutMutex');
  EmitLn('mov __PointOutArgs.Location.X, ' + x);
  if bCls then begin
    EmitLn('mov __PointOutArgs.Location.Y, ' + y);
    EmitLn('mov __PointOutArgs.Options, ' + RegisterName);
  end
  else begin
    EmitLn('mov __PointOutArgs.Location.Y, ' + RegisterName);
    EmitLn('set __PointOutArgs.Options, 0');
  end;
  EmitLn('syscall DrawPoint, __PointOutArgs');
  ResetStatementType;
  EmitLn(Format('mov %s, __PointOutArgs.Result',[RegisterName]));
  EmitLn('release __PointOutMutex');
  pop;
  if bCls then
    pop;
end;

procedure TNXCComp.DoDrawPoly;
var
  pts : string;
  bCls : boolean;
begin
  //PolyOut(points,options=false)
  OpenParen;
  // arg1 = points
  pts := Value;
  Next;
  bCls := Token = TOK_COMMA;
  if bCls then
  begin
    MatchString(TOK_COMMA);
    // arg2 = cls
    BoolExpression;
  end;
  CloseParen;
  EmitLn('acquire __PolyOutMutex');
  EmitLn('mov __PolyOutArgs.Points, ' + pts);
  if bCls then begin
    EmitLn('mov __PolyOutArgs.Options, ' + RegisterName);
  end
  else begin
    EmitLn('set __PolyOutArgs.Options, 0');
  end;
  EmitLn('syscall DrawPolygon, __PolyOutArgs');
  ResetStatementType;
  EmitLn(Format('mov %s, __PolyOutArgs.Result',[RegisterName]));
  EmitLn('release __PolyOutMutex');
end;

procedure TNXCComp.DoDrawLineRect(idx : integer);
var
  x, y, x2, y2 : string;
  bCls : boolean;
begin
  //LineOut(x1,y1,x2,y2,cls=false)
  //RectOut(x1,y1,width,height,cls=false)
  OpenParen;
  // arg1 = x
  BoolExpression;
  push;
  x := tos;
  EmitLn(Format('mov %s, %s', [x, RegisterName]));
  MatchString(TOK_COMMA);
  // arg2 = y
  BoolExpression;
  push;
  y := tos;
  EmitLn(Format('mov %s, %s', [y, RegisterName]));
  MatchString(TOK_COMMA);
  // arg3 = x2
  BoolExpression;
  push;
  x2 := tos;
  EmitLn(Format('mov %s, %s', [x2, RegisterName]));
  MatchString(TOK_COMMA);
  // arg4 = y2
  BoolExpression;
  bCls := Token = TOK_COMMA;
  if bCls then
  begin
    push;
    y2 := tos;
    EmitLn(Format('mov %s, %s', [y2, RegisterName]));
    MatchString(TOK_COMMA);
    // arg5 = cls
    BoolExpression;
  end;
  CloseParen;
  if idx = APIF_DRAWRECT then
  begin
    EmitLn('acquire __RectOutMutex');
    EmitLn('mov __RectOutArgs.Location.X, ' + x);
    EmitLn('mov __RectOutArgs.Location.Y, ' + y);
    EmitLn('mov __RectOutArgs.Size.Width, ' + x2);
    if bCls then begin
      EmitLn('mov __RectOutArgs.Size.Height, ' + y2);
      EmitLn('mov __RectOutArgs.Options, ' + RegisterName);
    end
    else begin
      EmitLn('mov __RectOutArgs.Size.Height, ' + RegisterName);
      EmitLn('set __RectOutArgs.Options, 0');
    end;
    EmitLn('syscall DrawRect, __RectOutArgs');
    ResetStatementType;
    EmitLn(Format('mov %s, __RectOutArgs.Result',[RegisterName]));
    EmitLn('release __RectOutMutex');
  end
  else
  begin
    EmitLn('acquire __LineOutMutex');
    EmitLn('mov __LineOutArgs.StartLoc.X, ' + x);
    EmitLn('mov __LineOutArgs.StartLoc.Y, ' + y);
    EmitLn('mov __LineOutArgs.EndLoc.X, ' + x2);
    if bCls then begin
      EmitLn('mov __LineOutArgs.EndLoc.Y, ' + y2);
      EmitLn('mov __LineOutArgs.Options, ' + RegisterName);
    end
    else begin
      EmitLn('mov __LineOutArgs.EndLoc.Y, ' + RegisterName);
      EmitLn('set __LineOutArgs.Options, 0');
    end;
    EmitLn('syscall DrawLine, __LineOutArgs');
    ResetStatementType;
    EmitLn(Format('mov %s, __LineOutArgs.Result',[RegisterName]));
    EmitLn('release __LineOutMutex');
  end;
  pop;
  pop;
  pop;
  if bCls then
    pop;
end;

procedure TNXCComp.DoDrawCircle;
var
  x, y, radius : string;
  bCls : boolean;
begin
  //CircleOut(x1,y1,radius,cls=false)
  OpenParen;
  // arg1 = x
  BoolExpression;
  push;
  x := tos;
  EmitLn(Format('mov %s, %s', [x, RegisterName]));
  MatchString(TOK_COMMA);
  // arg2 = y
  BoolExpression;
  push;
  y := tos;
  EmitLn(Format('mov %s, %s', [y, RegisterName]));
  MatchString(TOK_COMMA);
  // arg3 = radius
  BoolExpression;
  bCls := Token = TOK_COMMA;
  if bCls then
  begin
    push;
    radius := tos;
    EmitLn(Format('mov %s, %s', [radius, RegisterName]));
    MatchString(TOK_COMMA);
    // arg4 = cls
    BoolExpression;
  end;
  CloseParen;
  EmitLn('acquire __CircleOutMutex');
  EmitLn('mov __CircleOutArgs.Center.X, ' + x);
  EmitLn('mov __CircleOutArgs.Center.Y, ' + y);
  if bCls then begin
    EmitLn('mov __CircleOutArgs.Size, ' + radius);
    EmitLn('mov __CircleOutArgs.Options, ' + RegisterName);
  end
  else begin
    EmitLn('mov __CircleOutArgs.Size, ' + RegisterName);
    EmitLn('set __CircleOutArgs.Options, 0');
  end;
  EmitLn('syscall DrawCircle, __CircleOutArgs');
  ResetStatementType;
  EmitLn(Format('mov %s, __CircleOutArgs.Result',[RegisterName]));
  EmitLn('release __CircleOutMutex');
  pop;
  pop;
  if bCls then
    pop;
end;

procedure TNXCComp.DoDrawEllipse;
var
  x, y, radiusX, radiusY : string;
  bCls : boolean;
begin
  //EllipseOut(x,y,radiusX,radiusY,cls=false)
  OpenParen;
  // arg1 = x
  BoolExpression;
  push;
  x := tos;
  EmitLn(Format('mov %s, %s', [x, RegisterName]));
  MatchString(TOK_COMMA);
  // arg2 = y
  BoolExpression;
  push;
  y := tos;
  EmitLn(Format('mov %s, %s', [y, RegisterName]));
  MatchString(TOK_COMMA);
  // arg3 = radiusX
  BoolExpression;
  push;
  radiusX := tos;
  EmitLn(Format('mov %s, %s', [radiusX, RegisterName]));
  MatchString(TOK_COMMA);
  // arg4 = radiusY
  BoolExpression;
  bCls := Token = TOK_COMMA;
  if bCls then
  begin
    push;
    radiusY := tos;
    EmitLn(Format('mov %s, %s', [radiusY, RegisterName]));
    MatchString(TOK_COMMA);
    // arg5 = cls
    BoolExpression;
  end;
  CloseParen;
  EmitLn('acquire __EllipseOutMutex');
  EmitLn('mov __EllipseOutArgs.Center.X, ' + x);
  EmitLn('mov __EllipseOutArgs.Center.Y, ' + y);
  EmitLn('mov __EllipseOutArgs.SizeX, ' + radiusX);
  if bCls then begin
    EmitLn('mov __EllipseOutArgs.SizeY, ' + radiusY);
    EmitLn('mov __EllipseOutArgs.Options, ' + RegisterName);
  end
  else begin
    EmitLn('mov __EllipseOutArgs.SizeY, ' + RegisterName);
    EmitLn('set __EllipseOutArgs.Options, 0');
  end;
  EmitLn('syscall DrawEllipse, __EllipseOutArgs');
  ResetStatementType;
  EmitLn(Format('mov %s, __EllipseOutArgs.Result',[RegisterName]));
  EmitLn('release __EllipseOutMutex');
  pop;
  pop;
  pop;
  if bCls then
    pop;
end;

procedure TNXCComp.DoDrawGraphic(idx : integer);
var
  x, y, fname, vars : string;
  bCls : boolean;
begin
  //GraphicOut(x,y,fname,cls=false)
  //GraphicOutEx(x,y,fname,vars,cls=false)
  //GraphicArrayOut(x,y,data,cls=false)
  //GraphicArrayOutEx(x,y,data,vars,cls=false)
  OpenParen;
  // arg1 = x
  BoolExpression;
  push;
  x := tos;
  EmitLn(Format('mov %s, %s', [x, RegisterName]));
  MatchString(TOK_COMMA);
  // arg2 = y
  BoolExpression;
  MatchString(TOK_COMMA);
  // arg3 = fname|data
  fname := GetDecoratedValue;
  if idx in [APIF_DRAWGRAPHIC, APIF_DRAWGRAPHICEX] then
    CheckString
  else
  begin
    if DataType(Value) <> TOK_ARRAYBYTEDEF then
      Expected(sByteArrayType);
  end;
  Next;
  if idx in [APIF_DRAWGRAPHICEX, APIF_DRAWGRAPHICAREX] then
  begin
    MatchString(TOK_COMMA);
    // arg4 = vars
    vars := GetDecoratedValue;
    Next;
  end;
  bCls := Token = TOK_COMMA;
  if bCls then
  begin
    push;
    y := tos;
    EmitLn(Format('mov %s, %s', [y, RegisterName]));
    MatchString(TOK_COMMA);
    // arg4 = cls
    BoolExpression;
  end;
  CloseParen;
  EmitLn('acquire __GraphicOutMutex');
  if idx in [APIF_DRAWGRAPHIC, APIF_DRAWGRAPHICEX] then
  begin
    EmitLn('mov __GraphicOutArgs.Location.X, ' + x);
    if bCls then begin
      EmitLn('mov __GraphicOutArgs.Location.Y, ' + y);
      EmitLn('mov __GraphicOutArgs.Options, ' + RegisterName);
    end
    else begin
      EmitLn('mov __GraphicOutArgs.Location.Y, ' + RegisterName);
      EmitLn('set __GraphicOutArgs.Options, 0');
    end;
    EmitLn('mov __GraphicOutArgs.Filename, ' + fname);
    if idx = APIF_DRAWGRAPHICEX then
      EmitLn('mov __GraphicOutArgs.Variables, ' + vars)
    else
      EmitLn('mov __GraphicOutArgs.Variables, __GraphicOutEmptyVars');
    EmitLn('syscall DrawGraphic, __GraphicOutArgs');
    ResetStatementType;
    EmitLn(Format('mov %s, __GraphicOutArgs.Result',[RegisterName]));
  end
  else
  begin
    EmitLn('mov __GraphicArrayOutArgs.Location.X, ' + x);
    if bCls then begin
      EmitLn('mov __GraphicArrayOutArgs.Location.Y, ' + y);
      EmitLn('mov __GraphicArrayOutArgs.Options, ' + RegisterName);
    end
    else begin
      EmitLn('mov __GraphicArrayOutArgs.Location.Y, ' + RegisterName);
      EmitLn('set __GraphicArrayOutArgs.Options, 0');
    end;
    EmitLn('mov __GraphicArrayOutArgs.Data, ' + fname);
    if idx = APIF_DRAWGRAPHICAREX then
      EmitLn('mov __GraphicArrayOutArgs.Variables, ' + vars)
    else
      EmitLn('mov __GraphicArrayOutArgs.Variables, __GraphicOutEmptyVars');
    EmitLn('syscall DrawGraphicArray, __GraphicArrayOutArgs');
    ResetStatementType;
    EmitLn(Format('mov %s, __GraphicArrayOutArgs.Result',[RegisterName]));
  end;
  EmitLn('release __GraphicOutMutex');
  pop;
  if bCls then
    pop;
end;

procedure TNXCComp.DoPlayToneEx;
var
  freq, dur, vol : string;
begin
  //PlayToneEx(freq, dur, vol, loop)
  OpenParen;
  // arg1 == Frequency
  BoolExpression;
  push;
  freq := tos;
  EmitLn(Format('mov %s, %s', [freq, RegisterName]));
  MatchString(TOK_COMMA);
  // arg2 == Duration
  BoolExpression;
  push;
  dur := tos;
  EmitLn(Format('mov %s, %s', [dur, RegisterName]));
  MatchString(TOK_COMMA);
  // arg3 == Volume
  BoolExpression;
  push;
  vol := tos;
  EmitLn(Format('mov %s, %s', [vol, RegisterName]));
  MatchString(TOK_COMMA);
  // arg4 == loop?
  BoolExpression;
  CloseParen;
  EmitLn('acquire __SPTArgsMutex');
  EmitLn('mov __SPTArgs.Frequency, ' + freq);
  EmitLn('mov __SPTArgs.Duration, ' + dur);
  EmitLn('mov __SPTArgs.Volume, ' + vol);
  EmitLn(Format('mov __SPTArgs.Loop, %s',[RegisterName]));
  EmitLn('syscall SoundPlayTone, __SPTArgs');
  ResetStatementType;
  EmitLn(Format('mov %s, __SPTArgs.Result',[RegisterName]));
  EmitLn('release __SPTArgsMutex');
  pop;
  pop;
  pop;
end;

procedure TNXCComp.DoPlayFileEx;
var
  fname, vol : string;
begin
  //PlayFileEx(file, vol, loop?)
  OpenParen;
  // arg1 == Filename (either constant string or string variable)
  fname := GetDecoratedValue;
  CheckString;
  Next;
  MatchString(TOK_COMMA);
  // arg2 == Volume
  BoolExpression;
  push;
  vol := tos;
  EmitLn(Format('mov %s, %s', [vol, RegisterName]));
  MatchString(TOK_COMMA);
  // arg3 == loop?
  BoolExpression;
  CloseParen;
  EmitLn('acquire __SPFArgsMutex');
  EmitLn('mov __SPFArgs.Filename, ' + fname);
  EmitLn('mov __SPFArgs.Volume, ' + vol);
  EmitLn(Format('mov __SPFArgs.Loop, %s', [RegisterName]));
  EmitLn('syscall SoundPlayFile, __SPFArgs');
  ResetStatementType;
  EmitLn(Format('mov %s, __SPFArgs.Result', [RegisterName]));
  EmitLn('release __SPFArgsMutex');
  pop;
end;

procedure TNXCComp.DoReadButton(idx: integer);
var
  btn, pressed, count : string;
begin
  // ButtonPressed(btn, reset)
  // ButtonCount(btn, reset)
  // ReadButtonEx(btn, reset, pressed, count)
  OpenParen;
  // arg1 = button index
  BoolExpression;
  push;
  btn := tos;
  EmitLn(Format('mov %s, %s', [btn, RegisterName]));
  MatchString(TOK_COMMA);
  // arg2 = reset?
  BoolExpression;
  if idx = APIF_READBUTTONEX then
  begin
    // two output args
    MatchString(TOK_COMMA);
    // pressed
    pressed := GetDecoratedValue;
    CheckIdent;
    CheckTable(Value);
    Next;
    MatchString(TOK_COMMA);
    // count
    count := GetDecoratedValue;
    CheckIdent;
    CheckTable(Value);
    Next;
  end;
  CloseParen;
  EmitLn('acquire __RBtnMutex');
  EmitLn('mov __RBtnArgs.Index, ' + btn);
  EmitLn(Format('mov __RBtnArgs.Reset, %s', [RegisterName]));
  EmitLn('syscall ReadButton, __RBtnArgs');
  ResetStatementType;
  if idx = APIF_BUTTONCOUNT then
    EmitLn(Format('mov %s, __RBtnArgs.Count',[RegisterName]))
  else if idx = APIF_BUTTONPRESSED then
    EmitLn(Format('mov %s, __RBtnArgs.Pressed',[RegisterName]))
  else
  begin
    EmitLn(Format('mov %s, __RBtnArgs.Pressed', [pressed]));
    EmitLn(Format('mov %s, __RBtnArgs.Count', [count]));
    EmitLn(Format('mov %s, __RBtnArgs.Result', [RegisterName]));
  end;
  EmitLn('release __RBtnMutex');
  pop;
end;

procedure TNXCComp.LoadAPIFunctions;
begin
  AddAPIFunction('asm', APIF_ASM);
  AddAPIFunction('abs', APIF_ABS);
  AddAPIFunction('sign', APIF_SIGN);
  AddAPIFunction('Random', APIF_RANDOM);
  AddAPIFunction('GetInput', APIF_GETINPUT);
  AddAPIFunction('GetOutput', APIF_GETOUTPUT);
  AddAPIFunction('ResetScreen', APIF_RESETSCREEN);
  AddAPIFunction('TextOut', APIF_TEXTOUT);
  AddAPIFunction('NumOut', APIF_NUMOUT);
  AddAPIFunction('PlayToneEx', APIF_PLAYTONEEX);
  AddAPIFunction('PlayFileEx', APIF_PLAYFILEEX);
  AddAPIFunction('ButtonPressed', APIF_BUTTONPRESSED);
  AddAPIFunction('ButtonCount', APIF_BUTTONCOUNT);
  AddAPIFunction('ReadButtonEx', APIF_READBUTTONEX);
  AddAPIFunction('PointOut', APIF_DRAWPOINT);
  AddAPIFunction('LineOut', APIF_DRAWLINE);
  AddAPIFunction('CircleOut', APIF_DRAWCIRCLE);
  AddAPIFunction('RectOut', APIF_DRAWRECT);
  AddAPIFunction('GraphicOut', APIF_DRAWGRAPHIC);
  AddAPIFunction('GraphicOutEx', APIF_DRAWGRAPHICEX);
  AddAPIFunction('StrToNum', APIF_STRTONUM);
  AddAPIFunction('StrLen', APIF_STRLEN);
  AddAPIFunction('StrIndex', APIF_STRINDEX);
  AddAPIStringFunction('NumToStr', APISF_NUMTOSTR);
  AddAPIStringFunction('StrCat', APISF_STRCAT);
  AddAPIStringFunction('SubStr', APISF_SUBSTR);
  AddAPIStringFunction('Flatten', APISF_FLATTEN);
  AddAPIStringFunction('StrReplace', APISF_STRREPLACE);
  AddAPIStringFunction('FormatNum', APISF_FORMATNUM);
  AddAPIFunction('GraphicArrayOut', APIF_DRAWGRAPHICAR);
  AddAPIFunction('GraphicArrayOutEx', APIF_DRAWGRAPHICAREX);
  AddAPIFunction('PolyOut', APIF_DRAWPOLY);
  AddAPIFunction('EllipseOut', APIF_DRAWELLIPSE);
  AddAPIFunction('FontTextOut', APIF_FONTTEXTOUT);
  AddAPIFunction('FontNumOut', APIF_FONTNUMOUT);
end;

function TNXCComp.GetNBCSrc: TStrings;
begin
  if AmInlining and Assigned(fCurrentInlineFunction) then
    Result := fCurrentInlineFunction.Code
  else
    Result := fNBCSrc;
end;

{
procedure TNXCComp.EmitInlineFunction(const idx: integer);
begin
  if (idx >= 0) and (idx < fInlineFunctions.Count) then
  begin
    fInlineFunctions.Items[idx].Emit(NBCSource);
  end;
end;
}

procedure TNXCComp.SetDefines(const Value: TStrings);
begin
  fDefines.Assign(Value);
end;

procedure TNXCComp.CheckTypeCompatibility(fp: TFunctionParameter; dt: char; const name : string);
var
  expectedBase, providedBase : char;
begin
  if GetArrayDimension(fp.ParameterDataType) <> GetArrayDimension(dt) then
    AbortMsg(sDatatypesNotCompatible)
  else
  begin
    expectedBase := ArrayBaseType(fp.ParameterDataType);
    providedBase := ArrayBaseType(dt);
    if (expectedBase in NonAggregateTypes) and not (providedBase in NonAggregateTypes) then
      Expected(sNumericType)
    else if (expectedBase = TOK_STRINGDEF) and (providedBase <> TOK_STRINGDEF) then
      Expected(sStringVarType)
    else if expectedBase = TOK_USERDEFINEDTYPE then
    begin
      if providedBase <> TOK_USERDEFINEDTYPE then
        Expected(sStructType)
      else begin
        // struct types must be the same
        if fp.ParamTypeName <> GetUDTType(name) then
          AbortMsg(sUDTNotEqual);
      end;
    end
    else if (expectedBase = TOK_MUTEXDEF) and (providedBase <> TOK_MUTEXDEF) then
      Expected(sMutexType);
  end;
end;

procedure TNXCComp.CheckNotConstant(const aName: string);
begin
  // is this thing constant?
  if (IsParam(aName) and IsParamConst(aName)) or
     (IsLocal(aName) and IsLocalConst(aName)) or
     (IsGlobal(aName) and IsGlobalConst(aName)) then
    AbortMsg(sConstNotAllowed);
end;

function TNXCComp.IncrementOrDecrement: boolean;
begin
  Result := ((Token = '+') and (Look = '+')) or
            ((Token = '-') and (Look = '-'));
end;

procedure TNXCComp.DoPreIncOrDec(bPutOnStack : boolean);
var
  bInc : boolean;
begin
  bInc := Token = '+';
  Next;
  Next;
  CheckIdent;
  // identifier must be an integer type
  if not (DataType(Value) in NonAggregateTypes) then
    Expected(sNumericType);
  if bInc then
    StoreInc(Value, 1)
  else
    StoreDec(Value, 1);
  if bPutOnStack then
    LoadVar(Value);
  Next;
end;

function TNXCComp.GetPreProcLexerClass: TGenLexerClass;
begin
  Result := TNXCLexer;
end;

function TNXCComp.InlineDecoration: string;
begin
//  if fInlining then
//    Result := '%%CALLER%%_'
//  else
    Result := '';
end;

procedure TNXCComp.AddTypeNameAlias(const lbl, args: string);
begin
  // add a named type alias
  if fNamedTypes.IndexOf(lbl) = -1 then
    fNamedTypes.AddEntry(lbl, args)
  else
    Duplicate(lbl);
end;

function TNXCComp.TranslateTypeName(const name: string): string;
var
  idx : integer;
  tname : string;
begin
  Result := name;
  idx := fNamedTypes.IndexOf(name);
  if idx <> -1 then
  begin
    tname := fNamedTypes.MapValue[idx];
    if tname <> name then
      Result := TranslateTypeName(tname)
    else
      Result := tname;
  end;
end;

procedure TNXCComp.ProcessTypedef;
var
  basetype, newtype : string;
  i, lb, ln : integer;
begin
  // typedef basetype newtype;
  // or
  // typedef struct {...} newtype;
  // base type can be multiple tokens (e.g., unsigned int)
  Next;
  Scan;
  if Token = TOK_STRUCT then
  begin
    ProcessStruct(True);
  end
  else
  begin
    basetype := '';
    while Token <> TOK_SEMICOLON do
    begin
      newtype := Value;
      if Look <> TOK_SEMICOLON then
        basetype := basetype + ' ' + Value;
      Next;
    end;
    i := Pos(newtype, basetype);
    lb := Length(basetype);
    ln := Length(newtype);
    if i = lb - ln + 1 then
      System.Delete(basetype, lb - ln + 1, MaxInt);
    basetype := Trim(basetype);
    AddTypeNameAlias(newtype, basetype);
    Semi;
    Scan;
  end;
end;

function NXCStrToType(const stype : string; bUseCase : Boolean = false) : TDSType;
var
  tmptype : string;
begin
  tmptype := stype;
  if not bUseCase then
    tmptype := LowerCase(tmptype);
  if (tmptype = 'unsigned char') or (tmptype = 'byte') or (tmptype = 'bool') then
    Result := dsUByte
  else if tmptype = 'char' then
    Result := dsSByte
  else if (tmptype = 'unsigned int') or (tmptype = 'unsigned short') then
    Result := dsUWord
  else if (tmptype = 'int') or (tmptype = 'short') then
    Result := dsSWord
  else if tmptype = 'unsigned long' then
    Result := dsULong
  else if tmptype = 'long' then
    Result := dsSLong
  else if tmptype = 'mutex' then
    Result := dsMutex
  else if tmptype = 'float' then
    Result := dsFloat
  else if tmptype = 'void' then
    Result := dsVoid
  else
    Result := dsCluster;
end;

procedure TNXCComp.LocalEmitLnNoTab(SL : TStrings; const line : string);
begin
  SL.Add(line);
end;

procedure TNXCComp.LocalEmitLn(SL : TStrings; const line : string);
begin
  SL.Add(#9+line);
end;

procedure TNXCComp.ProcessStruct(bTypeDef : boolean);
var
  sname, mtype, aval, mname, mtypename : string;
  DE : TDataspaceEntry;
  dt : TDSType;
  SL : TStringList;
  i : integer;
begin
  // struct name {...};
  // or
  // struct {...} name; (and bTypeDef is true)
  Next;
  SL := TStringList.Create;
  try
    // create a new structure definition
    fCurrentStruct := DataDefinitions.Add;
    fCurrentStruct.DataType := dsCluster;
    if not bTypeDef then
    begin
      sname := Value;
      AddTypeNameAlias(sname, sname);
      fCurrentStruct.Identifier := sname;
      fCurrentStruct.TypeName   := sname;
      Next; // skip past the type name
    end;
    MatchString(TOK_BEGIN);
    while (Token <> TOK_END) and not endofallsource do
    begin
      // process a member declaration
      // format is multi-part typename membername [];
      // e.g., unsigned int membername
      // or    int membername
      Scan;
      mtypename := Value;
      if Token = TOK_UNSIGNED then
      begin
        Next;
        Scan;
        mtypename := mtypename + ' ' + Value;
      end;
      // make sure we translate typedefs
      mtype := TranslateTypeName(mtypename);
      Next;
      mname := Value;
      Next;
      aval := '';
      if (Token = '[') and (Look = ']') then begin
        // declaring an array
        while Token in ['[', ']'] do begin
          aval := aval + Token;
          Next;
        end;
      end;
      Semi;
      // add a member to the current structure definition
      if mtype = 'string' then
      begin
        mtype := 'byte';
        aval := '[]' + aval;
      end;
      dt := NXCStrToType(mtype, True);
      if dt = dsCluster then
        LocalEmitLn(SL, Format('%s %s%s', [mname, mtype, aval]))
      else
        LocalEmitLn(SL, Format('%s %s%s', [mname, TypeToStr(dt), aval]));
      DE := fCurrentStruct.SubEntries.Add;
      HandleVarDecl(DataDefinitions, fNamedTypes, True, DE, mname, mtype+aval, @NXCStrToType);
    end;
    Next; // skip past the '}' (aka TOK_END)
    if bTypeDef then
    begin
      sname := Value;
      AddTypeNameAlias(sname, sname);
      fCurrentStruct.Identifier := sname;
      fCurrentStruct.TypeName   := sname;
      Next; // skip past the type name
    end;
    // all struct declarations will be emitted to a special stringlist
    // and then output at the start of the NBC code
    LocalEmitLnNoTab(fStructDecls, 'dseg segment');
    LocalEmitLn(fStructDecls, sname+' struct');
    for i := 0 to SL.Count - 1 do
      LocalEmitLnNoTab(fStructDecls, SL[i]);
    LocalEmitLn(fStructDecls, sname+' ends');
    LocalEmitLnNoTab(fStructDecls, 'dseg ends');
  finally
    SL.Free;
  end;
  Semi; // skip past the ';'
  Scan;
end;

procedure TNXCComp.CheckForTypedef(var bUnsigned, bConst, bInline, bSafeCall : boolean);
var
  i : integer;
begin
  Value := TranslateTypeName(Value);
  i := Pos('unsigned', Value);
  if i > 0 then
  begin
    System.Delete(Value, i, 9);
    bUnsigned := True;
  end;
  i := Pos('const', Value);
  if i > 0 then
  begin
    System.Delete(Value, i, 6);
    bConst := True;
  end;
  i := Pos('inline', Value);
  if i > 0 then
  begin
    System.Delete(Value, i, 7);
    bInline := True;
  end;
  i := Pos('safecall', Value);
  if i > 0 then
  begin
    System.Delete(Value, i, 9);
    bSafeCall := True;
  end;
  Value := Trim(Value);
  Scan;
end;

function TNXCComp.IsUserDefinedType(const name: string): boolean;
begin
  Result := DataDefinitions.IndexOfName(name) <> -1;
end;

function TNXCComp.RootOf(const name: string): string;
var
  p : integer;
begin
  p := Pos('.', name);
  if p > 0 then
    Result := Copy(name, 1, p-1)
  else
    Result := name;
end;

function TNXCComp.DataTypeOfDataspaceEntry(DE: TDataspaceEntry): char;
var
  dim : integer;
  bt : char;
  tmpDE : TDataspaceEntry;
begin
  Result := #0;
  if not Assigned(DE) then Exit;
  case DE.DataType of
    dsUByte : Result := TOK_BYTEDEF;
    dsSByte : Result := TOK_CHARDEF;
    dsUWord : Result := TOK_USHORTDEF;
    dsSWord : Result := TOK_SHORTDEF;
    dsULong : Result := TOK_ULONGDEF;
    dsSLong : Result := TOK_LONGDEF;
    dsCluster : Result := TOK_USERDEFINEDTYPE;
    dsMutex : Result := TOK_MUTEXDEF;
    dsFloat : Result := TOK_FLOATDEF;
    dsArray : begin
      // count dimensions and find base type
      dim := 1;
      tmpDE := DE.SubEntries[0];
      while tmpDE.DataType = dsArray do
      begin
        inc(dim);
        tmpDE := tmpDE.SubEntries[0];
      end;
      bt := DataTypeOfDataspaceEntry(tmpDE);
      Result := ArrayOfType(bt, dim);
      // temporarily tree byte[] as string
      if Result = TOK_ARRAYBYTEDEF then
        Result := TOK_STRINGDEF;
    end;
  else
    Result := #0;
  end;
end;

procedure TNXCComp.UDTAssignment(const name: string);
//var
//  tmp, aval : string;
begin
  if Token in ['+', '-', '/', '*', '%', '&', '|', '^'] then
  begin
    MathAssignment(name);
//    StoreUDT(name, tmp, aval);
  end
  else
  begin
    MatchString('=');
    GetAndStoreUDT(name);
  end;
end;

procedure TNXCComp.GetAndStoreUDT(const name: string);
begin
  NotNumericFactor;
  if fUDTOnStack <> '' then
  begin
    Store(name);
    fUDTOnStack := '';
  end;
end;

function TNXCComp.GetUDTType(n: string): string;
var
  i : integer;
  root_type, root_name : string;
  DE : TDataspaceEntry;
  fp : TFunctionParameter;
begin
  Result := '';
  case WhatIs(n) of
    stParam : begin
      i := ParamIdx(n);
      if i <> -1 then
      begin
        if ArrayBaseType(fParams[i].DataType) = TOK_USERDEFINEDTYPE then
        begin
          root_name := RootOf(n);
          if root_name <> n then
          begin
            root_type := fParams[i].TypeName;
            System.Delete(n, 1, Length(root_name)+1);
            n := root_type + '.' + n;
            DE := DataDefinitions.FindEntryByFullName(n);
            if Assigned(DE) then
              Result := DE.TypeName;
          end
          else
            Result := fParams[i].TypeName;
        end;
      end
      else
      begin
        // i = -1
        for i := 0 to fFuncParams.Count - 1 do
        begin
          fp := fFuncParams[i];
          if n = ApplyDecoration(fp.ProcName, fp.Name, 0) then
          begin
            Result := fp.ParamTypeName;
            Break;
          end;
        end;
      end;
    end;
    stLocal : begin
      i := LocalIdx(n);
      if (i <> -1) and (ArrayBaseType(fLocals[i].DataType) = TOK_USERDEFINEDTYPE) then
//      if i = -1 then
      begin
        // maybe this is a member of a struct which might itself be a user defined type
        root_name := RootOf(n);
        if root_name <> n then
        begin
//          i := LocalIdx(root_name);
//          i := fLocals.IndexOfName(root_name);
//          if (i <> -1) and (ArrayBaseType(fLocals[i].DataType) = TOK_USERDEFINEDTYPE) then
//          begin
            root_type := fLocals[i].TypeName;
            System.Delete(n, 1, Length(root_name)+1);
            n := root_type + '.' + n;
            DE := DataDefinitions.FindEntryByFullName(n);
            if Assigned(DE) then
              Result := DE.TypeName;
//          end;
        end
        else
          Result := fLocals[i].TypeName;
      end;
//      else if ArrayBaseType(fLocals[i].DataType) = TOK_USERDEFINEDTYPE then
//        Result := fLocals[i].TypeName;
    end;
    stGlobal : begin
      i := fGlobals.IndexOfName(n);
      if i = -1 then
      begin
        // maybe this is a member of a struct which might itself be a user defined type
        root_name := RootOf(n);
        if root_name <> n then
        begin
          i := fGlobals.IndexOfName(root_name);
          if (i <> -1) and (ArrayBaseType(fGlobals[i].DataType) = TOK_USERDEFINEDTYPE) then
          begin
            root_type := fGlobals[i].TypeName;
            System.Delete(n, 1, Length(root_name)+1);
            n := root_type + '.' + n;
            DE := DataDefinitions.FindEntryByFullName(n);
            if Assigned(DE) then
              Result := DE.TypeName;
          end;
        end;
      end
      else if ArrayBaseType(fGlobals[i].DataType) = TOK_USERDEFINEDTYPE then
        Result := fGlobals[i].TypeName;
    end;
  else
    Result := '';
    AbortMsg(sUnknownUDT);
  end;
end;

procedure TNXCComp.InitializeArray(const Name, aVal, Val, tname: string;
  dt: char; lenexpr: string);
var
  tmpVal, expr, tmpType, codeStr : string;
  idx, n, dim : integer;
begin
  if (lenexpr = '') or
     (lenexpr = '[]') or
     (lenexpr = '[][]') or
     (lenexpr = '[][][]') then
    Exit;
  tmpType := tname;
  if tmpType = 'string' then
    tmpType := 'byte[]';
  // grab the first array expression from lenexpr
  idx := Pos('[', lenexpr);
  n := Pos(']', lenexpr);
  expr := Copy(lenexpr, idx+1, n-idx-1);
  System.Delete(lenexpr, idx, n-idx+1);
  // now check dimensions
  dim := GetArrayDimension(dt);
  if dim = 1 then
  begin
    if ArrayBaseType(dt) in NonAggregateTypes then
      tmpVal := '0'
    else
    begin
      // create a variable to be used for initializing the array
      dec(dim);
      tmpVal := Format('__%s_%d', [Name, dim]);
      EmitLn('dseg segment');
      AllocateHelper(tmpVal, '', '', tmpType, dt);
      EmitLn('dseg ends');
    end;
    if expr = '' then
      expr := '1';
    codeStr := Format('arrinit %s, %s, %s', [Name, tmpVal, expr]);
    EmitLn(codeStr);
  end
  else
  begin
    // recurse if needed
    dt := RemoveArrayDimension(dt);
    // define a variable at this new level
    tmpVal := Format('__%s_%d', [Name, dim]);
    EmitLn('dseg segment');
    AllocateHelper(tmpVal, DataTypeToArrayDimensions(dt), '', tmpType, dt);
    EmitLn('dseg ends');
    InitializeArray(tmpVal, aVal, Val, tname, dt, lenexpr);
    if expr = '' then
      expr := '1';
    codeStr := Format('arrinit %s, %s, %s', [Name, tmpVal, expr]);
    EmitLn(codeStr);
  end;
end;

procedure TNXCComp.LoadSystemFile(S : TStream);
var
  tmp : string;
begin
  // load fMS with the contents of NBCCommon.h followed by NXCDefs.h
  tmp := '#line 0 "NXTDefs.h"'#13#10;
  S.Write(PChar(tmp)^, Length(tmp));

  S.Write(nbc_common_data, High(nbc_common_data)+1);
  S.Write(nxc_defs_data, High(nxc_defs_data)+1);
//  tmp := Format('#line 0 "%s"'#13#10, [CurrentFile]);
  tmp := '#reset'#13#10;
  S.Write(PChar(tmp)^, Length(tmp));
end;

procedure TNXCComp.CheckSemicolon;
begin
  if fSemiColonRequired then
  begin
    Semi;
    Scan;
  end;
end;

procedure TNXCComp.CloseParen;
begin
  dec(fParenDepth);
  if fParenDepth < 0 then
    AbortMsg(sUnmatchedCloseParen);
  MatchString(TOK_CLOSEPAREN);
end;

procedure TNXCComp.OpenParen;
begin
  MatchString(TOK_OPENPAREN);
  inc(fParenDepth);
end;

procedure TNXCComp.InitializeGraphicOutVars;
begin
  if IgnoreSystemFile then
    Exit; // do not intialization if we are not including the standard headers
  if not EnhancedFirmware then
    EmitLn('arrinit __GraphicOutEmptyVars, 0, 256')
  else
    EmitLn('arrinit __GraphicOutEmptyVars, 0, 16');
end;

procedure TNXCComp.EmitMutexDeclaration(const name: string);
begin
  EmitLn('dseg segment');
  EmitLn(Format('  __%s_mutex mutex', [name]));
  EmitLn('dseg ends');
end;

procedure TNXCComp.EmitInlineParametersAndLocals(func: TInlineFunction);
var
  i : integer;
  p : TFunctionParameter;
  v : TVariable;
  varname, tname : string;
  dt : char;
  bConst : boolean;
begin
  for i := 0 to FunctionParameterCount(func.Name) - 1 do
  begin
    p := GetFunctionParam(func.Name, i);
    if Assigned(p) then
    begin
      varname := InlineName(fCurrentThreadName, ApplyDecoration(p.ProcName, p.Name, 0));
      tname   := p.ParamTypeName;
      dt      := p.ParameterDataType;
      bConst  := p.IsConstant;
      if AmInlining then
      begin
        // call AddLocal instead
        if not IsLocal(varname) then
          AddLocal(varname, dt, tname, bConst, '');
      end
      else
      begin
        // allocate this parameter
        Allocate(varname, DataTypeToArrayDimensions(dt), '', tname, dt);
      end;
    end;
  end;
  for i := 0 to func.LocalVariables.Count - 1 do
  begin
    v := func.LocalVariables[i];
    varname := InlineName(fCurrentThreadName, v.Name);
    tname   := v.TypeName;
    dt      := v.DataType;
    bConst  := v.IsConstant;
    if AmInlining then
    begin
      // call AddLocal instead
      if not IsLocal(varname) then
        AddLocal(varname, dt, tname, bConst, '');
    end
    else
    begin
      // allocate this variable
      Allocate(varname, DataTypeToArrayDimensions(dt), '', tname, dt);
    end;
  end;
end;

function TNXCComp.TypesAreCompatible(lhs, rhs: char): boolean;
var
  lDim, rDim : integer;
  lBase, rBase : Char;
begin
  Result := ((lhs <> TOK_MUTEXDEF) and (rhs <> TOK_MUTEXDEF)) and
            ((lhs = rhs) or
             ((lhs in [TOK_ARRAYBYTEDEF, TOK_STRINGDEF]) and
              (rhs in [TOK_ARRAYBYTEDEF, TOK_STRINGDEF])) or
             ((lhs in [Chr(Ord(TOK_ARRAYBYTEDEF)+1), TOK_ARRAYSTRING]) and
              (rhs in [Chr(Ord(TOK_ARRAYBYTEDEF)+1), TOK_ARRAYSTRING])) or
             ((lhs in [Chr(Ord(TOK_ARRAYBYTEDEF)+2), Chr(Ord(TOK_ARRAYSTRING)+1)]) and
              (rhs in [Chr(Ord(TOK_ARRAYBYTEDEF)+2), Chr(Ord(TOK_ARRAYSTRING)+1)])) or
             ((lhs in [Chr(Ord(TOK_ARRAYBYTEDEF)+3), Chr(Ord(TOK_ARRAYSTRING)+2)]) and
              (rhs in [Chr(Ord(TOK_ARRAYBYTEDEF)+3), Chr(Ord(TOK_ARRAYSTRING)+2)]))
            );
  if not Result then
  begin
    if IsArrayType(lhs) or IsArrayType(rhs) then
    begin
      // dimension counts have to match and base types have to be compatible
      lDim := GetArrayDimension(lhs);
      rDim := GetArrayDimension(rhs);
      Result := lDim = rDim;
      if Result then
      begin
        // also base type compatible
        lBase := ArrayBaseType(lhs);
        rBase := ArrayBaseType(rhs);
        Result := ((lBase in NonAggregateTypes) and (rBase in NonAggregateTypes)) or (lBase = rBase);
      end;
    end
    else
    begin
      // neither is an array
      Result := (lhs in NonAggregateTypes) and (rhs in NonAggregateTypes);
    end;
  end;
end;

procedure TNXCComp.DoFormatNum;
var
  str : string;
begin
  // FormatNum(string, value)
  OpenParen;
  // string
  str := GetDecoratedValue;
  CheckString;
  Next;
  MatchString(TOK_COMMA);
  // value
  BoolExpression;
  CloseParen;
  EmitLn(Format('fmtnum %s, %s, %s', [StrRetValName, str, RegisterName]));
end;

procedure TNXCComp.DecrementNestingLevel;
var
  i : integer;
begin
  dec(fNestingLevel);
  // clear any locals defined below the current level
  // since they have just gone out of scope
  for i := fLocals.Count - 1 downto 0 do
  begin
    if fLocals[i].Level > fNestingLevel then
      fLocals.Delete(i);
  end;
end;

procedure TNXCComp.CheckEnhancedFirmware;
begin
  if not EnhancedFirmware then
    AbortMsg(sEnhancedFirmwareReqd);
end;

procedure TNXCComp.InitializeGlobalArrays;
var
  i : integer;
  V : TVariable;
  aval : string;
begin
  for i := 0 to fGlobals.Count - 1 do
  begin
    V := fGlobals[i];
    if IsArrayType(V.DataType) then
    begin
      if (V.LenExpr <> '') and (V.Value = '') then
      begin
        // generate code to initialize this array.
        aval := DataTypeToArrayDimensions(V.DataType);
        InitializeArray(V.Name, aval, '', V.TypeName, V.DataType, V.LenExpr);
      end
      else if V.Value <> '' then
      begin
        DoLocalArrayInit(V.Name, V.Value, V.DataType);
      end;
    end
  end;
end;

function StripBraces(str : string) : string;
begin
  Result := Copy(str, 2, Length(str)-2);
end;

procedure TNXCComp.DoLocalArrayInit(const aName, ival: string; dt: char);
var
  asmstr, {src, }tmp : string;
//  i : integer;
begin
  // generate an arrbuild asm statement for this array given the initial values
  asmstr := Format('arrbuild %s', [aName]);
  tmp := StripBraces(ival);
  asmstr := asmstr + ', ' + tmp;
  EmitLn(asmstr);
end;

procedure TNXCComp.DoNewArrayIndex(theArrayDT : Char; theArray, aLHSName : string);
var
  AHV : TArrayHelperVar;
  tmp, udType, aval, tmpUDTName, oldExpStr : string;
  tmpDT : char;
begin
  // grab the index as an expression and put it on the stack
  Next;
  tmpDT := fLHSDataType;
  oldExpStr := fExpStr;
  try
    fLHSDataType := TOK_LONGDEF;
    BoolExpression;
  finally
    fLHSDataType := tmpDT;
    fExpStr      := oldExpStr;
  end;
  if Value <> ']' then
    Expected(''']''');
  push;
  tmp := tos;
  EmitLn(Format('mov %s, %s', [tmp, RegisterName]));
  fArrayIndexStack.Add(tmp);
  theArrayDT := RemoveArrayDimension(theArrayDT);

  // check for additional levels of indexing
  if (Look = '[') and (IsArrayType(theArrayDT) or (theArrayDT = TOK_STRINGDEF)) then
  begin
    Next; // move to '['
    udType := '';
    if IsUDT(ArrayBaseType(theArrayDT)) then
      udType := GetUDTType(theArray);
    // get a temporary thread-safe variable of the right type
    AHV := fArrayHelpers.GetHelper(fCurrentThreadName, udType, theArrayDT);
    try
      aval := AHV.Name;
      if fGlobals.IndexOfName(aval) = -1 then
        AddEntry(aval, theArrayDT, udType, '');
      // set the variable to the specified element from previous array
      EmitLn(Format('index %s, %s, %s',[aval, GetDecoratedIdent(theArray), tmp]));
      // pass its name into the call to DoNewArrayIndex
      DoNewArrayIndex(theArrayDT, aval, aLHSName);
    finally
      fArrayHelpers.ReleaseHelper(AHV);
    end;
  end
  else
  begin
    // no more indexing
    udType := '';
    if IsUDT(ArrayBaseType(theArrayDT)) then
      udType := GetUDTType(theArray);
    // get a temporary thread-safe variable of the right type
    AHV := fArrayHelpers.GetHelper(fCurrentThreadName, udType, theArrayDT);
    try
      aval := AHV.Name;
      if fGlobals.IndexOfName(aval) = -1 then
        AddEntry(aval, theArrayDT, udType, '');
      // set the variable to the specified element from previous array
      EmitLn(Format('index %s, %s, %s',[aval, GetDecoratedIdent(theArray), tmp]));
      // check for struct member notation
      if (Look = '.') and IsUDT(theArrayDT) then
      begin
        Next; // move to the dot
        // process dots
        tmpUDTName := aval;
        tmpUDTName := tmpUDTName + Value; // add the dot
        Next;
        tmpUDTName := tmpUDTName + Value; // add everything else
        // set value to full udt name
        Value := tmpUDTName;
      end
      else
      begin
        // set value to temporary array name
        Value := aval;
      end;
      Token := TOK_IDENTIFIER;
      tmpDT := DataType(Value);
      if (tmpDT in NonAggregateTypes) and (aLHSName = '') then
      begin
        LoadVar(Value);
        Next; // move to the next token
      end
      else
      if aLHSName <> '' then
      begin
        if tmpDT = TOK_STRINGDEF then
          EmitLn(Format('strcat %s, %s', [aLHSName, GetDecoratedValue]))
        else if tmpDT in NonAggregateTypes then
          LoadVar(Value)
        else
          EmitLn(Format('mov %s, %s', [GetDecoratedIdent(aLHSName), GetDecoratedValue]));
        Next; // move to the next token
      end
      else
      begin
        // recurse to the NumericRelation procedure
        NumericRelation;
      end;
    finally
      fArrayHelpers.ReleaseHelper(AHV);
    end;
  end;
  pop;
end;

procedure TNXCComp.SetStatementType(const Value: TStatementType);
begin
  fStatementType := Value;
  if (Value = stFloat) and (FirmwareVersion < MIN_FW_VER2X) then
    AbortMsg(sFloatNotSupported);
end;

procedure TNXCComp.ResetStatementType;
begin
  StatementType := stSigned;
end;

procedure TNXCComp.EmitNXCRequiredStructs;
var
  SL : TStringList;
begin
  SL := TStringList.Create;
  try
    SL.Text :=
      'TNXCSoundPlayFile struct'#13#10 +
      ' Result sbyte'#13#10 +
      ' Filename byte[]'#13#10 +
      ' Loop byte'#13#10 +
      ' Volume byte'#13#10 +
      'TNXCSoundPlayFile ends'#13#10 +
      'TNXCSoundPlayTone struct'#13#10 +
      ' Result sbyte'#13#10 +
      ' Frequency	word'#13#10 +
      ' Duration word'#13#10 +
      ' Loop byte'#13#10 +
      ' Volume byte'#13#10 +
      'TNXCSoundPlayTone ends'#13#10 +
      'TNXCSetScreenMode struct'#13#10 +
      ' Result sbyte'#13#10 +
      ' ScreenMode dword'#13#10 +
      'TNXCSetScreenMode ends';
    NBCSource.AddStrings(SL);
    NBCSource.Add('');
  finally
    SL.Free;
  end;
end;

procedure TNXCComp.CheckForMain;
var
  i : integer;
  V : TVariable;
begin
  for i := 0 to fGlobals.Count - 1 do
  begin
    V := fGlobals[i];
    if (V.DataType = TOK_TASK) and (V.Name = 'main') then
      Exit;
  end;
  // if we get here we know that main does not exist
  AbortMsg(sMainTaskNotFound);
end;

procedure TNXCComp.DoCompilerStatusChange(const Status: string);
begin
  if Assigned(fOnCompilerStatusChange) then
    fOnCompilerStatusChange(Self, Status);
end;

function TNXCComp.AmInlining: boolean;
begin
//  Result := fInlineStack.Count > 0;
  Result := fInlineDepth > 0;
end;

procedure TNXCComp.DecrementInlineDepth;
begin
  // remove the
  dec(fInlineDepth);
end;

procedure TNXCComp.IncrementInlineDepth;
begin
  inc(fInlineDepth);
//  fInlineStack.Add(TStringList.Create);
end;

procedure TNXCComp.HandleSpecialNames;
begin
  if Value = '__TMPBYTE__' then
    Value := TempSignedByteName
  else if Value = '__TMPWORD__' then
    Value := TempSignedWordName
  else if Value = '__TMPLONG__' then
    Value := TempSignedLongName
  else if Value = '__TMPULONG__' then
    Value := TempUnsignedLongName
  else if Value = '__TMPFLOAT__' then
    Value := TempFloatName
  else if Value = '__RETVAL__' then
    Value := SignedRegisterName
  else if Value = '__FLTRETVAL__' then
    Value := FloatRegisterName
  else if Value = '__STRRETVAL__' then
    Value := StrRetValName
  else if Value = '__GENRETVAL__' then
    Value := RegisterName;
end;

function TNXCComp.GetValueOf(const name: string): string;
begin
  Result := name;
  if IsLocalConst(name) then
  begin
    Result := LocalConstantValue(name);
  end
{
  else if IsParamConst(name) then
  begin
    Result := ParamConstantValue(name);
  end;
}
end;

end.
