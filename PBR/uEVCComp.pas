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
unit uEVCComp;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, uCompTokens, uGenLexer, uPreprocess, Contnrs, uNBCCommon,
  uEVAClasses, uCompCommon;

type
  TSizeMap = class
  private
    fMap : TStrings;
    function GetSize(aName: string): integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddEntry(const aName : string; const aSize : integer);
    procedure Clear;
    function Count : integer;
    property Size[aName : string] : integer read GetSize;
  end;

  TCompareCode = (ccLT, ccGT, ccLTEQ, ccGTEQ, ccEQ, ccNEQ);
  TEVCComp = class
  private
    fStackDepth : integer;
    fLastErrLine : integer;
    fLastErrMsg : string;
    endofallsource : boolean;
    fEnhancedFirmware: boolean;
    fIgnoreSystemFile: boolean;
    fParenDepth : integer;
    fMaxErrors: word;
    fFirmwareVersion: word;
    fStackVarNames : TStringList;
    fOnCompilerStatusChange: TCompilerStatusChangeEvent;
    fMaxPreProcDepth: word;
    fSizeMap : TSizeMap;
    function FunctionParameterTypeName(const name: string; idx: integer): string;
    function LocalDataType(const n: string): char;
    function LocalTypeName(const n: string): string;
    function LocalConstantValue(const n: string): string;
    function GlobalDataType(const n: string): char;
    function GlobalTypeName(const n: string): string;
    function ParamDataType(const n: string): char;
    function ParamTypeName(const n: string): string;
    function FuncParamDataType(const n: string): char;
    procedure CheckSemicolon;
    procedure OpenParen;
    procedure CloseParen;
    procedure pop;
    procedure push;
    procedure DoCompilerStatusChange(const Status: string; const bDone : boolean = False);
    procedure DoCommonFuncProcDecl(var bProtoExists: boolean;
      var Name: string; const tname: string; const tok, dt: char;
      bInline, bPointer : boolean);
    procedure HandlePreprocStatusChange(Sender : TObject; const StatusMsg : string);
    procedure SetCurFile(const Value: string);
    function IsCharLiteral(const aName: string): boolean;
    function ArraySize(DE : TDataspaceEntry): integer;
    function UDTSize(const tname: string): integer;
    function CountElements(lenexpr: string): integer;
    function CountValues(ival: string): integer;
    function SubAsString(const aLHS, aRHS: string): string;
    function MoveAsString(const aLHS, aRHS : string): string;
    function SubImmAsString(const aLHS, aRHS : string): string;
    function BranchAsString(const aLabel: string) : string;
    function BranchPositiveAsString(const aLabel: string): string;
    function BranchNegativeAsString(const aLabel: string): string;
    function BranchFalseAsString(const aLabel: string) : string;
    function BranchTrueAsString(const aLabel: string): string;
    procedure EndOfProcess;
    procedure StartOfCode(const aName: string);
    procedure StoreAddress(const dest, src: string);
    procedure StoreValue(const dest, src: string);
    procedure ClearIndirect(const element: string);
    procedure DoIncrement(const aName: string);
    procedure DoDecrement(const aName: string);
    procedure SourceAdd(const str: string; const bAbortOnDS : boolean = False);
    procedure SourceAddStrings(aStrings: TStrings; const bAbortOnDS : boolean = False);
    procedure SourceRemoveCallToInitGlobals;
    procedure SourceSwitchWaitToStart;
    procedure SourceInsert(const idx: integer; const aValue: string);
    procedure SourceDelete(const line: integer);
    procedure SourceClear;
    function SourceCount : integer;
    procedure HandleAcquireReleaseHelper(Sender: TObject; bAcquire: boolean; const aName: string);
    procedure ReleaseVolatile(const aName: string);
    procedure AcquireVolatile(const aName: string);
    procedure SetToFalse(const aName: string);
    procedure SetToTrue(const aName: string);
    procedure SetZeroCC;
    function TestAsString(const aName: string): string;
    procedure GetSProAddress;
    procedure TraceChar(const C: Char);
    procedure TraceString(const S: string);
    procedure StartProcess(const aName: string);
    procedure CloseLog;
    procedure OpenLogForWrite;
    procedure OpenLogForRead;
    procedure LogStatus;
    procedure Rotate(bRight: boolean; const aName: string);
    procedure PopVar(const aName: string);
    procedure PushVar(const aName: string);
    procedure TraceVar(bDecimal: boolean; const aName: string);
    procedure ReadVar(const aName: string);
    procedure WriteVar(const aName: string);
    procedure RunProgram(const slot: byte);
    procedure ExitToProcess(const aName: string);
    procedure SquareRoot(const aName: string);
    procedure AbsoluteValue;
    procedure SignValue;
    procedure SizeOfValue(const aName: string);
    function CalculatedSize(const aName : string) : integer;
//    procedure WaitForClock;
    procedure StopAllProcesses(const aName: string);
    procedure HaltEx;
    procedure TraceCarriageReturn;
    procedure TraceNewLine;
    procedure TraceSpace;
//    procedure TraceCRLF;
    procedure GetStringLiteral;
    procedure CheckStringConst;
    procedure WaitMS(const aName: string);
    procedure TraceStringWithEscapes(tmp: string);
    procedure TraceCharAsString(const aValue: string);
    procedure CheckPointer(const aName: string);
    procedure StorePreDec(const name: string);
    procedure StorePreInc(const name: string);
    procedure CopyArrayVar(const dest, src: string);
    procedure CopyUDTVar(const dest, src: string);
    procedure TestVariable(const name: string);
    procedure OutputDirective(const directive: string);
    function GetCompilerOutput: TStrings;
    function GetSymbolTable: TStrings;
    function IsReferenceType(n: string): boolean;
    procedure InitializeArrayReference(const dest, src: string);
    procedure InitializeUDTReference(const dest, src: string);
    procedure InitializeVarReference(const dest, src: string);
    procedure SetOnCompilerStatusChange(
      const Value: TCompilerStatusChangeEvent);
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
    fASM : TStrings;
    fMessages : TStrings;
    fMS : TMemoryStream;
    fTempChar : Char;
    fCCSet : boolean;
    fIncludeDirs: TStrings;
    fCurFile: string;
    fOldCurFile: string;
    fOnCompMSg: TOnCompilerMessage;
    fDirLine : string;
    fCurrentLine : string;
    fExpStr : string;
    fExpStrHasVars : boolean;
    fBoolSubExpStr : string;
    fBoolSubExpStrHasVars : boolean;
    fAPIFunctions : TStringList;
    fAPIStrFunctions : TStringList;
    fThreadNames : TStringList;
    fCurrentThreadName : string;
    fBytesRead : integer;
    fSwitchFixups : TStringList;
    fSwitchRegNames : TStringList;
    fSwitchDepth : integer;
    fCalc : TCCExpParser;
    fOptimizeLevel: integer;
    fInlineDepth : integer;
    fInlineStack : TObjectList; // list of TStrings
    fNestingLevel : integer;
    fLHSDataType : char;
    fLHSName : string;
    fWarningsOff: boolean;
    fFunctionNameCallStack : TStringList;
    fSemiColonRequired : boolean;
    fExpressionIsSigned : boolean;
    fArrayIndexStack : TStringList;
    fUDTOnStack : string;
    fLastExpressionOptimizedToConst : boolean;
    fLastLoadedConst : string;
    fProcessingMathAssignment : boolean;
    fProcessingAsmBlock : boolean;
    fNoCommaOperator : boolean;
    fDerefAssignment : boolean;
    fDerefValue : boolean;
    fAddressOfValue : boolean;
    fAutoStart : boolean;
    fIGDProcess : TProcessObject;
    procedure AddArrayDataDefinition(const aName : string; dt : char;
      lenexpr, tname : string);
    function AmInlining : boolean;
    procedure IncrementInlineDepth;
    procedure DecrementInlineDepth;
    procedure HandleSpecialNames;
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
    procedure Expression;
    procedure DoPreIncOrDec(bPutOnStack : boolean);
    function  IncrementOrDecrement : boolean;
    function OptimizeExpression(str : string; const idx : integer; bFlag : boolean; const aValue : string) : string;
    procedure Subtract;
    procedure CommaExpression;
    procedure BoolExpression;
    procedure Relation;
    procedure StoreZeroFlag;
    procedure CallRoutine(const name : string);
    procedure ReturnFromRoutine;
    function  ValueIsArrayType : boolean;
    function  ValueIsUserDefinedType : boolean;
    procedure BoolTerm;
    procedure BitOr;
    procedure BitXor;
    procedure BitAnd;
    function  TypesAreCompatible(lhs, rhs : char) : boolean;
    function  GetParamName(procname : string; idx : integer) : string;
    procedure DoCall(procname: string);
    function  GetValueOf(const name : string) : string;
    procedure DoCallAPIFunc(procname: string);
    function  APIFuncNameToID(procname : string) : integer;
    function  IsAPIFunc(procname : string) : boolean;
    procedure DoAssignValue(const aName : string; dt : char; bNoChecks : boolean = False);
    procedure DoLocalArrayInit(const aName, ival : string; dt : char);
    procedure DoArrayAssignValue(const aName, idx : string; dt : char);
    function DoNewArrayIndex(theArrayDT : Char; theArray, aLHSName : string) : boolean;
    procedure OffsetUDTPointer(const UDTType : string; const aPointer : string);
    procedure OffsetArrayPointer(const ArrayType : string; const aPointer : string);
    procedure Assignment;
    procedure CheckNotConstant(const aName : string);
    function CheckConstant(const aName : string) : string;
    function Block(const lend : string = ''; const lstart : string = '') : boolean;
    procedure BlockStatements(const lend : string = ''; const lstart : string = '');
    procedure CheckBytesRead(const oldBytesRead : integer);
    procedure DoFor;
    procedure DoIf(const lend, lstart : string);
    procedure DoWhile;
    procedure DoDoWhile;
    procedure DoRepeat;
    procedure DoAsm(var dt : char);
    function  DecorateVariables(const asmStr : string) : string;
    procedure DoSwitch(const lstart : string);
    procedure DoSwitchCase;
    function  GetCaseConstant : string;
    procedure DoSwitchDefault;
    function  SwitchFixupIndex : integer;
    function  SwitchRegisterName : string;
    procedure ClearSwitchFixups;
    procedure FixupSwitch(idx : integer; lbl : string);
    procedure DoLabel;
    procedure DoStart;
    procedure CommaStatement(const lend, lstart : string);
    procedure Statement(const lend, lstart : string);
    procedure ProcessDirectives(bScan : boolean = True);
    procedure HandlePoundLine;
    procedure HandlePoundPragma;
    procedure HandlePoundReset;
    function  ArrayOfType(dt : char; dimensions : integer) : char;
    function  GetVariableType(vt: char): char;
    procedure CheckForValidDataType(dt : char);
    function  RemoveArrayDimension(dt : char) : char;
    function  AddArrayDimension(dt : char) : char;
    procedure IncLineNumber;
    function AddLocal(name: string; dt: char; const tname : string;
      bConst : boolean; const lenexp : string; bPointer : boolean) : integer;
    procedure AllocGlobal(const tname : string; dt: char; bInline, bConst, bStatic : boolean);
    procedure AllocLocal(const sub, tname: string; dt: char; bConst, bStatic : boolean);
    function  GetInitialValue(dt : char) : string;
    procedure DoLocals(const sub: string);
    procedure AddFunctionParameter(pname, varname, tname : string; idx : integer;
      ptype : char; bIsConst, bIsRef, bIsArray : boolean; aDim : integer;
      bHasDefault : boolean; defValue : string);
    function  FormalList(protoexists: boolean; var procname: string): integer;
    procedure ProcedureBlock;
    procedure InitializeGlobalArrays;
    procedure EmitGlobalDataInitSubroutine;
    procedure FunctionBlock(Name, tname : string; dt : char; bInline, bPointer : boolean);
    procedure AbortMsg(const s: string);
    procedure WarningMsg(const s: string);
    procedure Expected(const s: string);
    procedure Undefined(const n: string);
    procedure Duplicate(const n: string);
    procedure CheckIdent;
    procedure CheckEnhancedFirmware;
    procedure CheckDataType(dt : char);
    procedure CheckTypeCompatibility(fp : TFunctionParameter; dt : char; const name : string);
//    function SizeOfType(dt: char): integer;
    function AddEntry(N: string; dt: char; const tname, lenexp : string;
      bConst : boolean = False; bPointer : boolean = False) : integer;
    procedure CheckDup(N: string);
    procedure CheckTable(const N: string);
    procedure CheckGlobal(const N: string);
    procedure AddParam(N: string; dt: char; const tname : string;
      bConst, bHasDefault, bIsReference : boolean; const defValue : string);
    function  DataType(const n: string): char;
    function  DataTypeName(const n: string): string;
    procedure CheckAndLoadVar(const Name: string);
    procedure LoadVar(const Name: string);
    procedure LoadVarToDest(const Dest: string; const Name: string);
    procedure CheckNotProc(const Name : string);
    procedure CheckAndStore(const Name: string);
    procedure Store(const name: string);
    procedure CopyVar(const dest, src : string);
    procedure Allocate(const Name, aVal, Val, tname: string; dt: char; cnt : integer = 1);
    procedure InitializeArray(const Name, aVal, Val, tname: string; dt : char;
      lenexpr : string);
//    function  InlineDecoration : string;
    procedure Epilog(bIsSub: boolean);
    procedure Prolog(const name: string; bIsSub: boolean);
    procedure EmitRegisters;
    procedure EmitStackVariables;
    procedure EmitInlineParametersAndLocals(func : TInlineFunction);
    procedure EmitLn(const s: string);
    procedure EmitLnNoTab(const s: string);
    procedure PostLabel(const L: string);
    procedure LoadConstToDest(const dest, n: string);
    procedure LoadConst(const n: string);
    procedure Negate;
    procedure NotIt(const aName : string);
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
    procedure Branch(const L: string);
    procedure BranchFalse(const L: string);
    procedure BranchTrue(const L: string);
    procedure BranchPositive(const L: string);
    procedure ClearReg;
    procedure ArrayAssignment(const name : string; dt : char; bIndexed : boolean);
    procedure UDTAssignment(const name : string);
    procedure GetAndStoreUDT(const name : string);
    procedure MathAssignment(const name : string);
    procedure DoAdd(const dest, src : string);
    procedure DoAddImmediate(const dest : string; const offset : integer);
    procedure StoreAdd(const name: string);
    procedure StoreDiv(const name: string);
    procedure StoreMod(const name: string);
    procedure StoreAnd(const name: string);
    procedure StoreOr(const name: string);
    procedure StoreXor(const name: string);
    procedure StoreShift(bRight : boolean; const name: string);
    procedure StoreMul(const name: string);
    procedure StoreSub(const name: string);
    procedure StoreInc(const name: string);
    procedure StoreDec(const name: string);
    procedure DoAPICommands(const lend, lstart : string);
    procedure DoBreakContinue(idx : integer; const lbl : string);
    procedure DoExitTo;
    procedure DoOpenLog;
    procedure DoCloseLog;
    procedure DoWriteToLog;
    procedure DoReadFromLog;
    procedure DoLogStatus;
    procedure DoRotate(const idx : integer);
    procedure DoPush;
    procedure DoPop;
    procedure DoSquareRoot;
    procedure DoRunProgram;
    procedure DoWait;
    procedure DoStopProcesses;
    procedure DoPutChar;
    procedure DoPutString;
    procedure DoPrintf;
    procedure DoStop;
    procedure DoGoto;
    procedure DoReturn;
    procedure DoAbs;
    procedure DoSign;
    procedure DoSizeOf;
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
    procedure CheckNumeric;
    function  ValueIsNumeric : boolean;
    procedure LoadAPIFunctions;
    procedure AddAPIFunction(const name : string; id : integer);
    function  WhatIs(const n: string): TSymbolType;
    function  TempSignedLongName : string;
    function  RegisterName(name : string = '') : string;
//    function  ZeroFlag : string;
    function  tos: string;
    function  ReplaceTokens(const line: string): string;
    procedure EmitAsmLines(const s: string);
    procedure EmitPoundLine;
    function  IsLocal(n: string): boolean;
    function  LocalIdx(n: string): integer;
    function  IsOldParam(n: string): boolean;
    function  IsFuncParam(n: string; bStripInline : boolean = false): boolean;
    function  IsParam(n: string): boolean;
    function  ParamIdx(n: string): integer;
    function AllocateHelper(aName, tname : string; dt: char; cnt : integer = 1) : integer;
    function  GetDecoratedValue: string;
    function  GetDecoratedIdent(const val: string): string;
    procedure PopCmpHelper(const cc : TCompareCode);
    procedure CmpHelper(const cc : TCompareCode; const lhs, rhs : string);
    procedure BoolSubExpression;
    function  NewLabel: string;
    procedure StoreArray(const name, idx, val: string);
    procedure CopyArray(const name, val : string);
    procedure DoIndex(const aValue, aName, aIndex : string);
    procedure CheckTask(const Name: string);
    procedure NumericRelation;
    procedure NumericRelationLTGT;
    procedure NumericShiftLeftRight;
    function  GetASMSrc: TStrings;
    function  FunctionReturnType(const name: string): char;
    function  FunctionParameterCount(const name: string): integer;
    function  FunctionRequiredParameterCount(const name: string): integer;
    function  FunctionParameterType(const name : string; idx : integer) : char;
    procedure ClearLocals;
    procedure ClearParams;
    procedure ClearGlobals;
    function  IsGlobal(n: string): boolean;
    function  GlobalIdx(n: string): integer;
    procedure SetDefines(const Value: TStrings);
    function  GetFunctionParam(const procname: string; idx: integer): TFunctionParameter;
    function  AdvanceToNextParam : string;
    function  FunctionParameterIsConstant(const name: string;
      idx: integer): boolean;
    function FunctionParameterIsReference(const name: string;
      idx: integer): boolean;
    function FunctionParameterDefaultValue(const name: string;
      idx: integer): string;
    function FunctionParameterHasDefault(const name: string;
      idx: integer): boolean;
    function  IsPointer(const aName: string): boolean;
    function  IsParamConst(n: string): boolean;
    function  IsParamPointer(n: string): boolean;
    function  IsLocalConst(n: string): boolean;
    function  IsLocalPointer(n: string): boolean;
    function  IsGlobalConst(n: string): boolean;
    function  IsGlobalPointer(n: string): boolean;
    function  GetUDTType(n : string) : string;
    procedure AddTypeNameAlias(const lbl, args : string);
    function  TranslateTypeName(const name : string) : string;
    procedure ProcessEnum(bGlobal : boolean);
    procedure ProcessTypedef;
    procedure ProcessStruct(bTypeDef : boolean = False);
    procedure CheckForTypedef(var bConst, bStatic, bInline : boolean);
    function  IsUserDefinedType(const name : string) : boolean;
    function  DataTypeOfDataspaceEntry(DE : TDataspaceEntry) : char;
    procedure LoadSourceStream(Src, Dest : TStream);
    procedure CheckForMain;
    function ProcessArrayDimensions(var lenexpr : string) : string;
    procedure CheckForCast;
    procedure HandleCast;
  protected
    fSProProgram : TSProProgram;
    fTmpAsmLines : TStrings;
    fBadProgram : boolean;
    fProgErrorCount : integer;
    fDefines : TStrings;
    procedure InternalParseStream;
    procedure Clear;
    property  SwitchFixups : TStringList read fSwitchFixups;
    property  SwitchRegisterNames : TStringList read fSwitchRegNames;
  protected
    procedure TopDecls; virtual;
    procedure Header; virtual;
    procedure Trailer; virtual;
    procedure PreProcess; virtual;
    function  GetPreProcLexerClass : TGenLexerClass; virtual;
    // dataspace definitions property
    property  DataDefinitions : TDataDefs read fDD;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Parse(const aFilename : string); overload;
    procedure Parse(aStream : TStream); overload;
    procedure Parse(aStrings : TStrings); overload;
    function  SaveToStream(aStream: TStream): boolean;
    procedure ParseASM(const aFilename : string); overload;
    procedure ParseASM(aStream : TStream); overload;
    procedure ParseASM(aStrings : TStrings); overload;
    property  Defines : TStrings read fDefines write SetDefines;
    property  ASMSource : TStrings read GetASMSrc;
    property  CompilerMessages : TStrings read fMessages;
    property  IncludeDirs : TStrings read fIncludeDirs;
    property  CurrentFile : string read fCurFile write SetCurFile;
    property  OptimizeLevel : integer read fOptimizeLevel write fOptimizeLevel;
    property  WarningsOff : boolean read fWarningsOff write fWarningsOff;
    property  EnhancedFirmware : boolean read fEnhancedFirmware write fEnhancedFirmware;
    property  FirmwareVersion : word read fFirmwareVersion write fFirmwareVersion;
    property  IgnoreSystemFile : boolean read fIgnoreSystemFile write fIgnoreSystemFile;
    property  MaxErrors : word read fMaxErrors write fMaxErrors;
    property  MaxPreprocessorDepth : word read fMaxPreProcDepth write fMaxPreProcDepth;
    property  OnCompilerMessage : TOnCompilerMessage read fOnCompMSg write fOnCompMsg;
    property  ErrorCount : integer read fProgErrorCount;
    property  OnCompilerStatusChange : TCompilerStatusChangeEvent read fOnCompilerStatusChange write SetOnCompilerStatusChange;
    property  SymbolTable : TStrings read GetSymbolTable;
    property  CompilerOutput : TStrings read GetCompilerOutput;
    class function BinToText(aStream : TStream; const aFilename : string = '') : string; overload;
    class function BinToText(const aFilename : string) : string; overload;
  end;

implementation

uses
  SysUtils, Math, uEVCLexer, uEVALexer, mwGenericLex, uLocalizedStrings,
  uNXTConstants, uCommonUtils;

{--------------------------------------------------------------}
{ Constant Declarations }

const
  TAB = ^I;
  CR  = ^M;
  LF  = ^J;

var
  LCount : integer = 0;

const
  MAXGLOBALS = 10000;
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
  NKW  = 24; //18;
  NKW1 = 25; //19;

const
  KWlist: array[1..NKW] of string =
              ('if', 'else', 'while',
               'for', 'sub', 'void', 'task',
               'do', 'repeat', 'switch', 'asm', 'const', 'static',
               'default', 'case', 'typedef', 'inline', 'long', 'enum',
               'int', 'bool', 'struct', 'start', 'char'
               );

const                                     
  KWcode: array[1..NKW1+1] of Char =
    (TOK_IDENTIFIER, TOK_IF, TOK_ELSE, TOK_WHILE,
     TOK_FOR, TOK_PROCEDURE, TOK_PROCEDURE, TOK_TASK,
     TOK_DO, TOK_REPEAT, TOK_SWITCH, TOK_ASM, TOK_CONST, TOK_STATIC,
     TOK_DEFAULT, TOK_CASE, TOK_TYPEDEF, TOK_INLINE, TOK_LONGDEF, TOK_ENUM,
     TOK_LONGDEF, TOK_LONGDEF, TOK_STRUCT, TOK_START, TOK_LONGDEF,
     #0);

const
  API_BREAK    = 0;
  API_CONTINUE = 1;
  API_RETURN   = 2;
  API_GOTO     = 3;
  API_STOP     = 4;
  API_EXITTO   = 5;
  API_ROTLEFT  = 6;
  API_ROTRIGHT = 7;
  API_RUN      = 8;
  API_WAIT     = 9;
  API_HALTEX   = 10;

  APICount = 11;
  APIList : array[0..APICount-1] of string = (
    'break', 'continue', 'return', 'goto',
    'Stop', 'ExitTo',
    'RotateLeft', 'RotateRight',
    'Run', 'Wait', 'StopProcesses'
  );

const
  NonAggregateTypes = [TOK_LONGDEF];
  IntegerTypes = [TOK_LONGDEF];
const
  UnsignedIntegerTypes = [];
  SignedIntegerTypes = [TOK_LONGDEF];
  SignedTypes = SignedIntegerTypes;

function GetArrayDimension(dt : char) : integer;
begin
  case dt of
    TOK_ARRAYUDT..TOK_ARRAYUDT4         : Result := Ord(dt) - Ord(TOK_ARRAYUDT) + 1;
    TOK_ARRAYLONGDEF..TOK_ARRAYLONGDEF4 : Result := Ord(dt) - Ord(TOK_ARRAYLONGDEF) + 1;
  else
    Result := 0;
  end;
end;

function IsArrayType(dt: char): boolean;
begin
  Result := ((dt >= TOK_ARRAYUDT) and (dt <= TOK_ARRAYUDT4)) or
            ((dt >= TOK_ARRAYLONGDEF) and (dt <= TOK_ARRAYLONGDEF4));
end;

function IsUDT(dt: char): boolean;
begin
  Result := dt = TOK_USERDEFINEDTYPE;
end;

function ArrayBaseType(dt: char): char;
begin
  case dt of
    TOK_ARRAYUDT..TOK_ARRAYUDT4         : Result := TOK_USERDEFINEDTYPE;
    TOK_ARRAYLONGDEF..TOK_ARRAYLONGDEF4 : Result := TOK_LONGDEF;
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

function EVCStrToType(const stype : string; bUseCase : Boolean = false) : TDSType;
var
  tmptype : string;
begin
  tmptype := stype;
  if not bUseCase then
    tmptype := LowerCase(tmptype);
  if (tmptype = 'bool') then
    Result := dsSLong
  else if (tmptype = 'char') then
    Result := dsSLong
  else if (tmptype = 'int') then
    Result := dsSLong
  else if tmptype = 'long' then
    Result := dsSLong
  else if tmptype = 'void' then
    Result := dsVoid
  else
    Result := dsCluster;
end;

type
  TSizeObj = class
  private
    fSize : integer;
  public
    constructor Create(const aSize : integer);
    property Size : integer read fSize;
  end;

{ TSizeObj }

constructor TSizeObj.Create(const aSize: integer);
begin
  inherited Create;
  fSize := aSize;
end;

{ TSizeMap }

procedure TSizeMap.AddEntry(const aName: string; const aSize: integer);
var
  obj : TSizeObj;
begin
  obj := TSizeObj.Create(aSize);
  try
    fMap.AddObject(aName, obj);
  except
    obj.Free;
    raise;
  end;
end;

procedure TSizeMap.Clear;
var
  i : integer;
begin
  for i := 0 to fMap.Count - 1 do
    fMap.Objects[i].Free;
end;

function TSizeMap.Count: integer;
begin
  Result := fMap.Count;
end;

constructor TSizeMap.Create;
begin
  inherited Create;
  fMap := TStringList.Create;
  TStringList(fMap).Sorted := True;
  TStringList(fMap).Duplicates := dupError;
end;

destructor TSizeMap.Destroy;
begin
  Clear;
  FreeAndNil(fMap);
  inherited;
end;

function TSizeMap.GetSize(aName: string): integer;
var
  i : integer;
begin
  Result := 0;
  i := fMap.IndexOf(aName);
  if i <> -1 then
    Result := TSizeObj(fMap.Objects[i]).Size;
end;

{ TEVCComp }

procedure TEVCComp.pop;
begin
  dec(fStackDepth);
  ReleaseVolatile(fStackVarNames[fStackVarNames.Count - 1]);
  fStackVarNames.Delete(fStackVarNames.Count - 1);
end;

procedure TEVCComp.push;
var
  tosName : string;
begin
  inc(fStackDepth);
  MaxStackDepth := Max(MaxStackDepth, fStackDepth);
  tosName := Format('__signed_stack_%3.3d%s', [fStackDepth, fCurrentThreadName]);
  fStackVarNames.Add(tosName);
  AcquireVolatile(tosName);
end;

procedure TEVCComp.GetCharX;
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

procedure TEVCComp.GetChar;
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
      end
      else begin
        // we need to put that character we just read back into the buffer
        fMS.Seek(-1, soFromCurrent);
        fTempChar := ' ';
      end;
    end;
  end;
end;

procedure TEVCComp.ReportProblem(const lineNo: integer; const fName,
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

procedure TEVCComp.AbortMsg(const s: string);
begin
  ReportProblem(linenumber, CurrentFile, s, True);
end;

procedure TEVCComp.WarningMsg(const s: string);
begin
  ReportProblem(linenumber, CurrentFile, s, False);
end;

procedure TEVCComp.Expected(const s: string);
begin
  AbortMsg(Format(sExpectedString, [s]));
end;

procedure TEVCComp.Undefined(const n: string);
begin
  AbortMsg(Format(sUndefinedIdentifier, [n]));
end;

procedure TEVCComp.Duplicate(const n: string);
begin
   AbortMsg(Format(sDuplicateIdentifier, [StripDecoration(n)]));
end;

procedure TEVCComp.CheckIdent;
begin
  if Token <> TOK_IDENTIFIER then Expected(sIdentifier);
end;

function TEVCComp.ValueIsNumeric: boolean;
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
        Value := CCFloatToStr(Trunc(fCalc.Value));
    end
    else
      Result := False;
  end;
end;

procedure TEVCComp.CheckNumeric;
begin
  if not ValueIsNumeric then
    Expected(sNumber);
end;

procedure TEVCComp.CheckStringConst;
begin
  if (Token <> TOK_STRINGLIT) then
    Expected(sStringLiteral);
end;

function TEVCComp.IsDigit(c: char): boolean;
begin
  Result := c in ['0'..'9'];
end;

function TEVCComp.IsHex(c: char): boolean;
begin
  Result := IsDigit(c) or (c in ['a'..'f', 'A'..'F']);
end;

function TEVCComp.IsAlNum(c: char): boolean;
begin
  Result := IsAlpha(c) or IsDigit(c){ or (c = '.')};
end;

function TEVCComp.IsAddop(c: char) : boolean;
begin
  Result := c in ['+', '-'];
end;

function TEVCComp.IsMulop(c: char): boolean;
begin
  Result := c in ['*', '/', '%'];
end;

function TEVCComp.IsOrop(c: char): boolean;
begin
  Result := c in ['|', '^'];
end;

function TEVCComp.IsRelop(c: char): boolean;
begin
  Result := c in ['=', '!', '<', '>'];
end;

function TEVCComp.IsWhite(c: char): boolean;
begin
  Result := c in [' ', TAB, CR, LF, TOK_BLOCK_COMMENT, TOK_LINE_COMMENT];
end;

procedure TEVCComp.SkipCommentBlock;
begin
  repeat
    repeat
      GetCharX;
    until (Look = '*') or endofallsource;
    GetCharX;
  until (Look = '/') or endofallsource;
  GetChar;
end;

procedure TEVCComp.SkipLine;
begin
  repeat
    GetCharX;
  until (Look = LF) or endofallsource;
  GetChar;
end;

procedure TEVCComp.SkipDirectiveLine;
begin
  fDirLine := Value + ' ';
  SkipWhite;
  repeat
    fDirLine := fDirLine + Look;
    GetCharX;
  until (Look = LF) or endofallsource;
  fDirLine := fDirLine + Look;
  fDirLine := Trim(fDirLine);
  GetChar;
end;

procedure TEVCComp.SkipWhite;
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

function TEVCComp.GlobalIdx(n: string): integer;
begin
  Result := Lookup(@GS_Name, RootOf(n), NumGlobals);
end;

function TEVCComp.IsGlobal(n: string): boolean;
begin
  if (Pos('@', n) = 1) then
  begin
    System.Delete(n, 1, 1);
    // is the remainder a valid number?
    fCalc.SilentExpression := n;
    if fCalc.ParserError then
      Result := False
    else
      Result := True;
  end
  else
    Result := GlobalIdx(RootOf(n)) <> 0;
end;

function TEVCComp.IsGlobalConst(n: string): boolean;
var
  i : integer;
begin
  Result := False;
  i := fGlobals.IndexOfName(RootOf(n));
  if i <> -1 then
    Result := fGlobals[i].IsConstant;
end;

function TEVCComp.IsGlobalPointer(n: string): boolean;
var
  i : integer;
begin
  Result := False;
  i := fGlobals.IndexOfName(RootOf(n));
  if i <> -1 then
    Result := fGlobals[i].IsPointer;
end;

function TEVCComp.GlobalDataType(const n: string): char;
var
  i : integer;
begin
  Result := #0;
  i := fGlobals.IndexOfName(RootOf(n));
  if i <> -1 then
    Result := fGlobals[i].DataType;
end;

function TEVCComp.GlobalTypeName(const n: string): string;
var
  i : integer;
begin
  Result := '';
  i := fGlobals.IndexOfName(RootOf(n));
  if i <> -1 then
    Result := fGlobals[i].TypeName;
end;

function TEVCComp.IsOldParam(n: string): boolean;
begin
  Result := ParamIdx(RootOf(n)) <> -1{0};
end;

function TEVCComp.IsFuncParam(n: string; bStripInline : boolean): boolean;
var
  i : integer;
  fp : TFunctionParameter;
  decvar : string;
begin
  Result := False;
  // check in the fFuncParams
  for i := 0 to fFuncParams.Count - 1 do
  begin
    fp := fFuncParams[i];
    decvar := ApplyDecoration(fp.ProcName, fp.Name, 0);
    if bStripInline and fp.FuncIsInline then
    begin
      if decvar = StripInline(RootOf(n)) then
      begin
        Result := True;
        Break;
      end;
    end
    else
    begin
      if decvar = RootOf(n) then
      begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

function TEVCComp.FuncParamDataType(const n: string): char;
var
  i : integer;
  fp : TFunctionParameter;
  decvar : string;
begin
  Result := #0;
  // check in the fFuncParams
  for i := 0 to fFuncParams.Count - 1 do
  begin
    fp := fFuncParams[i];
    decvar := ApplyDecoration(fp.ProcName, fp.Name, 0);
    if decvar = StripInline(RootOf(n)) then
    begin
      Result := fp.ParameterDataType;
      Break;
    end;
  end;
end;

function TEVCComp.IsParam(n: string): boolean;
begin
  Result := IsOldParam(n);
  if not Result then
    Result := IsFuncParam(n);
end;

function TEVCComp.ParamIdx(n: string): integer;
begin
  n := RootOf(n);
  if AlreadyDecorated(n, fThreadNames) then
    Result := fParams.IndexOfName(n)
  else
    Result := fParams.IndexOfName(ApplyDecoration(fCurrentThreadName, n, 0));
end;

function TEVCComp.IsParamConst(n: string): boolean;
var
  i : integer;
begin
  Result := False;
  i := ParamIdx(RootOf(n));
  if i <> -1 then
    Result := fParams[i].IsConstant;
end;

function TEVCComp.IsParamPointer(n: string): boolean;
var
  i : integer;
begin
  Result := False;
  i := ParamIdx(RootOf(n));
  if i <> -1 then
    Result := fParams[i].IsPointer;
end;

function TEVCComp.ParamDataType(const n: string): char;
var
  i : integer;
begin
  i := ParamIdx(RootOf(n));
  if i <> -1 then
    Result := fParams[i].DataType
  else
  begin
    // maybe a function parameter?
    Result := FuncParamDataType(RootOf(n));
  end;
end;

function TEVCComp.ParamTypeName(const n: string): string;
var
  i : integer;
begin
  Result := '';
  i := ParamIdx(RootOf(n));
  if i <> -1 then
    Result := fParams[i].TypeName;
end;

function TEVCComp.IsLocal(n: string): boolean;
begin
  Result := LocalIdx(RootOf(n)) <> -1{0};
  if not Result then
  begin
    // is this a special internal variable name?
  end;
end;

function TEVCComp.LocalIdx(n: string): integer;
var
  i : integer;
begin
  n := RootOf(n);
  if AlreadyDecorated(n, fThreadNames) then
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

function TEVCComp.IsLocalConst(n: string): boolean;
var
  i : integer;
begin
  Result := False;
  i := LocalIdx(RootOf(n));
  if i <> -1 then
    Result := fLocals[i].IsConstant;
end;

function TEVCComp.IsLocalPointer(n: string): boolean;
var
  i : integer;
begin
  Result := False;
  i := LocalIdx(RootOf(n));
  if i <> -1 then
    Result := fLocals[i].IsPointer;
end;

function TEVCComp.LocalConstantValue(const n: string): string;
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

function TEVCComp.LocalDataType(const n: string): char;
var
  i : integer;
begin
  Result := #0;
  i := LocalIdx(RootOf(n));
  if i <> -1 then
    Result := fLocals[i].DataType;
end;

function TEVCComp.LocalTypeName(const n: string): string;
var
  i : integer;
begin
  Result := '';
  i := LocalIdx(RootOf(n));
  if i <> -1 then
    Result := fLocals[i].TypeName;
end;

procedure TEVCComp.CheckTable(const N: string);
begin
  if not IsParam(N) and
     not IsLocal(N) and
     not IsGlobal(N) then
    Undefined(N);
end;

procedure TEVCComp.CheckGlobal(const N: string);
begin
  if not IsGlobal(N) then
    Undefined(N);
end;

procedure TEVCComp.CheckDup(N: string);
begin
  if IsGlobal(N) then
    Duplicate(N);
end;

function TEVCComp.AddEntry(N: string; dt: char; const tname, lenexp : string;
  bConst, bPointer : boolean) : integer;
var
  V : TVariable;
begin
  CheckForValidDataType(dt);
  CheckDup(N);
  if NumGlobals = MAXGLOBALS then AbortMsg(sSymbolTableFull);
  Inc(NumGlobals);
  GS_Name[NumGlobals] := N;
  GS_Type[NumGlobals] := dt;

  V := fGlobals.Add;
  with V do
  begin
    Name       := N;
    DataType   := dt;
    IsConstant := bConst;
    IsPointer  := bPointer;
    TypeName   := tname;
    LenExpr    := lenexp;
  end;
  Result := V.Index;
end;

procedure TEVCComp.GetDirective;
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

procedure TEVCComp.GetName;
begin
  SkipWhite;
  if not IsAlpha(Look) then Expected(sIdentifier);
  Token := TOK_IDENTIFIER;
  Value := '';
  repeat
    Value := Value + Look;
    GetChar;
  until not IsAlNum(Look);
  fExpStrHasVars := True;
  fBoolSubExpStrHasVars := True;
  HandleSpecialNames;
end;

procedure TEVCComp.GetNum;
var
  savedLook : char;
  bExponent : boolean;
begin
  bExponent := False;
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
    if not (IsDigit(Look) or (Look in ['e', 'E'])) then Exit;
    repeat
      bExponent := bExponent or (Look in ['e', 'E']);
      Value := Value + Look;
      savedLook := Look;
      GetChar;
    until not (IsDigit(Look) or
               (not bExponent and (Look in ['e', 'E'])) or
               (bExponent and (savedLook in ['e', 'E']) and ((Look in ['+', '-']) or (IsDigit(Look)))));
  end;
end;

procedure TEVCComp.GetHexNum;
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

procedure TEVCComp.GetSProAddress;
begin
  SkipWhite;
  GetChar; // skip the @
  if IsDigit(Look) then
  begin
    GetNum;
    Value := '@'+Value;
    Token := TOK_IDENTIFIER;
  end
  else
    Expected(sNumber);
end;

procedure TEVCComp.GetCharLit;
var
  i : integer;
begin
  GetCharX; // skip the '
  Token := TOK_NUM;
  if Look = '\' then
  begin
    GetCharX; // skip the '\'
    i := Pos(Look, 'nr''"\?');
    case i of
      1 : Value := '10'; // new line
      2 : Value := '13'; // carriage return
      3 : Value := '39'; // single quote
      4 : Value := '34'; // double quote
      5 : Value := '92'; // backslash
      6 : Value := '63'; // question mark
    else
      Value := IntToStr(Ord(' ')); // unsupported character escape
    end;
  end
  else
  begin
    Value := IntToStr(Ord(Look));
  end;
  GetCharX;
  if Look <> '''' then Expected(sCharLiteral);
  GetChar;
end;

procedure TEVCComp.GetStringLiteral;
var
  bEscapeNext : boolean;
begin
  GetCharX; // skip the "
  Token := TOK_STRINGLIT;
  if Look = '"' then
  begin
    // empty string
    Value := '''''';
  end
  else
  begin
    bEscapeNext := False;
    Value := '''';
    if (Look = '''') then
      Value := Value + '\'''
    else
      Value := Value + Look;
    repeat
      if not bEscapeNext then
        bEscapeNext := Look = '\'
      else
        bEscapeNext := False;
      GetCharX;
      if not ((Look = LF) or ((Look = '"') and not bEscapeNext)) then
      begin
        if (Look = '''') and not bEscapeNext then
          Value := Value + '\'''
        else
          Value := Value + Look;
      end;
    until ((Look = '"') and not bEscapeNext) or (Look = LF) or endofallsource;
    Value := Value + '''';
    if Look <> '"' then Expected(sStringLiteral);
  end;
  GetChar;
end;

procedure TEVCComp.GetOp;
begin
  SkipWhite;
  Token := Look;
  Value := Look;
  GetChar;
end;

procedure TEVCComp.Next(bProcessDirectives : boolean);
begin
  SkipWhite;
  if Look = '''' then GetCharLit
  else if Look = '"' then GetStringLiteral
  else if Look = '#' then GetDirective
  else if IsAlpha(Look) then GetName
  else if IsDigit(Look) then GetNum
  else if Look = '$' then GetHexNum
  else if Look = '@' then GetSProAddress
  else GetOp;
  if bProcessDirectives then
  begin
    ProcessDirectives(False);
    fExpStr := fExpStr + Value;
    fBoolSubExpStr := fBoolSubExpStr + Value;
  end;
  if not fProcessingAsmBlock and
     not (Token in ['<', '>', '|', '^', '&', '%', '/', '*', '-', '+', '=']) then
    SkipWhite; // also skip any whitespace after this token
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

procedure TEVCComp.Scan;
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

procedure TEVCComp.MatchString(x: string);
begin
  if Value <> x then Expected('''' + x + '''');
  Next;
end;

procedure TEVCComp.Semi;
begin
  MatchString(TOK_SEMICOLON);
end;

function TEVCComp.NewLabel: string;
var
  S: string;
begin
  S := '';
  Str(LCount, S);
  NewLabel := LABEL_PREFIX + S;
  Inc(LCount);
end;

procedure TEVCComp.ClearParams;
begin
  fParams.Clear;
end;

procedure TEVCComp.ClearLocals;
begin
  fLocals.Clear;
  fEmittedLocals.Clear;
end;

procedure TEVCComp.ClearGlobals;
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

procedure TEVCComp.AddParam(N: string; dt: char; const tname : string;
  bConst, bHasDefault, bIsReference : boolean; const defValue : string);
begin
  CheckForValidDataType(dt);
  if IsOldParam(N) then Duplicate(N);
  with fParams.Add do
  begin
    Name        := N;
    DataType    := dt;
    IsConstant  := bConst;
    TypeName    := tname;
    IsReference := bIsReference;
  end;
end;

function TEVCComp.WhatIs(const n : string) : TSymbolType;
begin
  // calling IsOldParam and IsFuncParam separately in order to
  // tell IsFuncParam to strip inline decoration in this case.
  if IsOldParam(n) then Result := stParam
  else if IsFuncParam(n, True) then Result := stParam
  else if IsLocal(n) then Result := stLocal
  else if IsGlobal(n) then Result := stGlobal
  else if IsAPIFunc(n) then Result := stAPIFunc
  else Result := stUnknown;
end;

function TEVCComp.DataType(const n : string) : char;
var
  p : integer;
  tname : string;
  DE : TDataspaceEntry;
begin
  if (n = '') then
    Result := TOK_LONGDEF
  else if (n = 'true') or (n = 'false') or (n = '1') or (n = '0') then
    Result := TOK_LONGDEF
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
    else
      // handle some special cases (register variables)
      if (Pos('__D0', n) = 1) or (Pos('__signed_stack_', n) = 1) or (Pos('__tmpslong', n) = 1) then
        Result := TOK_LONGDEF
//      else if (Pos('__zf', n) = 1) then
//        Result := TOK_LONGDEF
      else
      begin
        Result := #0;
        Undefined(StripDecoration(n));
      end;
    end;
  end;
end;

function TEVCComp.DataTypeName(const n : string) : string;
begin
  Result := '';
  case WhatIs(n) of
    stParam : begin
      Result := ParamTypeName(n);
    end;
    stLocal : begin
      Result := LocalTypeName(n);
    end;
    stGlobal : begin
      Result := GlobalTypeName(n);
    end;
  end;
end;

function TEVCComp.ArrayOfType(dt: char; dimensions : integer): char;
begin
  Result := dt;
  if (dimensions > 4) or (dimensions < 1) then begin
    AbortMsg(sInvalidArrayDim);
    Exit;
  end
  else begin
    dec(dimensions); // convert 1-4 range into 0-3 range
    case dt of
      TOK_LONGDEF : begin
        Result := Char(Ord(TOK_ARRAYLONGDEF)+dimensions);
      end;
      TOK_USERDEFINEDTYPE : begin
        Result := Char(Ord(TOK_ARRAYUDT)+dimensions);
      end;
    else
      Result := dt;
    end;
  end;
end;

procedure TEVCComp.CheckNotProc(const Name : string);
begin
  if DataType(Name) in [TOK_PROCEDURE, TOK_TASK] then
    AbortMsg(sAssignTaskError);
end;

procedure TEVCComp.CheckTask(const Name : string);
begin
  if DataType(Name) <> TOK_TASK then
    AbortMsg(sArgMustBeTask);
end;

function TEVCComp.FunctionReturnType(const name : string) : char;
var
  i : integer;
begin
  Result := #0;
  i := GlobalIdx(name);
  if (i > 0) and (GS_Type[i] = TOK_PROCEDURE) then
    Result := GS_ReturnType[i];
end;

function TEVCComp.ValueIsArrayType: boolean;
begin
  Result := IsArrayType(DataType(Value));
end;

function TEVCComp.ValueIsUserDefinedType: boolean;
begin
  Result := DataType(Value) = TOK_USERDEFINEDTYPE;
end;

procedure TEVCComp.PopCmpHelper(const cc : TCompareCode);
begin
  CmpHelper(cc, tos, RegisterName);
  pop;
end;

procedure TEVCComp.PopCmpEqual;
begin
  PopCmpHelper(ccEQ);
end;

procedure TEVCComp.PopCmpNEqual;
begin
  PopCmpHelper(ccNEQ);
end;

procedure TEVCComp.PopCmpGreater;
begin
  PopCmpHelper(ccGT);
end;

procedure TEVCComp.PopCmpLess;
begin
  PopCmpHelper(ccLT);
end;

procedure TEVCComp.PopCmpLessOrEqual;
begin
  PopCmpHelper(ccLTEQ);
end;

procedure TEVCComp.PopCmpGreaterOrEqual;
begin
  PopCmpHelper(ccGTEQ);
end;

procedure TEVCComp.NotNumericFactor;
begin
  if Token = '~' then begin  // handle unary complement
    Next;
    NumericFactor;
    Complement;
  end
  else if Token = '!' then // handle unary logical not
  begin
    Next;
    NumericFactor;
    NotIt(RegisterName);
  end
  else
    NumericFactor;
end;

procedure TEVCComp.NumericFactor;
var
  savedtoken, rdt, dt : char;
  savedvalue, pLHS : string;
  oldNoCommas, oldDA, bNeedToPop : boolean;
begin
  bNeedToPop := False;
  if Token = TOK_OPENPAREN then begin
    OpenParen;
    oldNoCommas := fNoCommaOperator;
    try
      fNoCommaOperator := False;
      CommaExpression;
    finally
      fNoCommaOperator := oldNoCommas;
    end;
    CloseParen;
  end
  else begin
    // scan here so that Token is changed from IDENTIFIER to the
    // appropriate keyword token
    Scan;
    savedtoken := Token;
    savedvalue := Value;
    // JCH fix bug where function call with whitespace between function name
    // and open paren was causing a compiler error. (2007-12-10)
    if (savedtoken = TOK_IDENTIFIER) and (DataType(savedvalue) = TOK_PROCEDURE) then
    begin
      rdt := FunctionReturnType(savedvalue);
      if (rdt <> #0) then
        DoCall(savedvalue)
      else
        AbortMsg(sInvalidReturnType);
    end
    else
    begin
      // current token is stored in savedtoken
      // is it '*'?
      fDerefValue := Token = '*';
      fAddressOfValue := Token = '&';
      if fDerefValue or fAddressOfValue then
      begin
        Next;
        Scan;
        savedtoken := Token;
        savedvalue := Value;
      end;
      Next;
      case savedtoken of
        TOK_IDENTIFIER : begin
          dt := DataType(savedvalue);
// JCH - handle UDT member selection - 2011-10-21
          if Token = '.' then
          begin
            if dt <> TOK_USERDEFINEDTYPE then
              AbortMsg('member selection invalid');
            // UDT member selection
            savedvalue := GetDecoratedIdent(savedvalue);
            Next;
            fDerefValue := True;
            // take the address of savedvalue and store it in pLHS
            bNeedToPop := True;
            push;
            pLHS := tos;
            StoreAddress(pLHS, savedvalue);
            // now offset the pointer by the specified member
            OffsetUDTPointer(GetUDTType(savedvalue), pLHS);
            savedvalue := pLHS;
          end
          else if (Token = '-') and (Look = '>') then
          begin
            if dt <> TOK_USERDEFINEDTYPE then
              AbortMsg('member selection invalid');
            savedvalue := GetDecoratedIdent(savedvalue);
            if not IsPointer(savedvalue) then
              AbortMsg('pointer to member selection invalid');
            Next;
            Next;
            fDerefValue := True;
            // take the address of savedvalue and store it in pLHS
            bNeedToPop := True;
            push;
            pLHS := tos;
            StoreValue(pLHS, savedvalue); // savedvalue is already a pointer so don't store its address
            // now offset the pointer by the specified member
            OffsetUDTPointer(GetUDTType(savedvalue), pLHS);
            savedvalue := pLHS;
          end
// JCH - end handle UDT member selection - 2011-10-21
          else if Token = '[' then
          begin
            if not IsArrayType(dt) then
              AbortMsg('invalid array indexing');
            savedvalue := GetDecoratedIdent(savedvalue);
            Next; // skip past the '[' token
            fDerefValue := True;
            // take the address of savedvalue and store it in pLHS
            bNeedToPop := True;
            push;
            pLHS := tos;
            StoreAddress(pLHS, savedvalue);
            // now offset the pointer by the specified member
            // for array offsets we use the dataspace entry rather than the
            // name of the dataspace entry

            OffsetArrayPointer(savedvalue, pLHS);
            savedvalue := pLHS;
          end;
{
          if Token = '[' then
          begin
            if fDerefValue or fAddressOfValue then
              AbortMsg(sInvalidPointerSyntax);
            fArrayIndexStack.Clear;
            DoNewArrayIndex(DataType(savedvalue), savedvalue, fLHSName);
          end
          else
}
          if ((Token = '+') and (Look = '+')) or
                  ((Token = '-') and (Look = '-')) then
          begin
            // postfix increment/decrement operators have higher precedence than dereference
            CheckAndLoadVar(savedvalue); // put the current value in the register
            oldDA := fDerefAssignment;
            fDerefAssignment := fDerefValue;
            try
              if Token = '+' then
                StoreInc(savedvalue)
              else
                StoreDec(savedvalue);
            finally
              fDerefAssignment := oldDA;
            end;
            Next;
            Next;
          end
          // The next two blocks are not exactly C with respect to operator precedence
          // A better way to allow for assignment/math assignment within an expression
          // should be found. 2010-06-07 JCH
          else if (Token in ['+', '-', '/', '*', '%', '&', '|', '^']) and (Look = '=') then
          begin
            oldDA := fDerefAssignment;
            fDerefAssignment := fDerefValue;
            try
              MathAssignment(savedvalue);
            finally
              fDerefAssignment := oldDA;
            end;
            CheckAndLoadVar(savedvalue);
          end
          else if (Token = '=') and (Look <> '=') then
          begin
            // var = expression rather than var == expression
            // i.e., an assignment statement
            Next;
            oldDA := fDerefAssignment;
            fDerefAssignment := fDerefValue;
            try
              DoAssignValue(savedvalue, DataType(savedvalue));
            finally
              fDerefAssignment := oldDA;
            end;
            CheckAndLoadVar(savedvalue);
          end
          //
          // end of not exactly C handling of assignment/math assignment
          //
          else if savedvalue = 'true' then
          begin
            if fDerefValue or fAddressOfValue then
              AbortMsg(sInvalidPointerSyntax);
            LoadConst('1');
          end
          else if savedvalue = 'false' then
          begin
            if fDerefValue or fAddressOfValue then
              AbortMsg(sInvalidPointerSyntax);
            LoadConst('0');
          end
          else if IsAPIFunc(savedvalue) then
          begin
            if fDerefValue or fAddressOfValue then
              AbortMsg(sInvalidPointerSyntax);
            DoCallAPIFunc(savedvalue);
          end
          else if IsArrayType(fLHSDataType) and not fProcessingMathAssignment then
          begin
            rdt := DataType(savedvalue);
            if not TypesAreCompatible(fLHSDataType, rdt) then
              AbortMsg(sDatatypesNotCompatible)
            else
              CopyArrayVar(GetDecoratedIdent(fLHSName), GetDecoratedIdent(savedvalue));
          end
          else if (fLHSDataType = TOK_USERDEFINEDTYPE) and not fProcessingMathAssignment then
          begin
            if GetUDTType(fLHSName) <> GetUDTType(savedvalue) then
              AbortMsg(sUDTNotEqual)
            else
              CopyUDTVar(GetDecoratedIdent(fLHSName), GetDecoratedIdent(savedvalue));
          end
          else
            CheckAndLoadVar(savedvalue);
        end;
        TOK_ASM : begin
          if fDerefValue or fAddressOfValue then
            AbortMsg(sInvalidPointerSyntax);
          DoAsm(fLHSDataType);
        end;
        TOK_NUM, TOK_HEX : begin
          if fDerefValue or fAddressOfValue then
            AbortMsg(sInvalidPointerSyntax);
          LoadConst(savedvalue);
        end;
        '-' : begin
          if Token = TOK_NUM then
          begin
            if fDerefValue or fAddressOfValue then
              AbortMsg(sInvalidPointerSyntax);
            LoadConst(savedvalue+value);
            Next;
          end
          else
            Expected(sMathFactor);
        end;
      else
        Expected(sMathFactor);
      end;
      fDerefValue := False;
      fAddressOfValue := False;
    end;
  end;
  if bNeedToPop then
    pop;
end;

procedure TEVCComp.Multiply;
begin
  Next;
  NotNumericFactor;
  PopMul;
end;

procedure TEVCComp.Divide;
begin
  Next;
  NotNumericFactor;
  PopDiv;
end;

procedure TEVCComp.Modulo;
begin
  Next;
  NotNumericFactor;
  PopMod;
end;

procedure TEVCComp.Term;
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

procedure TEVCComp.Add;
begin
  Next;
  Term;
  PopAdd;
end;

procedure TEVCComp.Subtract;
begin
  Next;
  Term;
  PopSub;
end;

procedure TEVCComp.Expression;
var
  prev, lenVal : integer;
  oldExpStr, optExp, oldBS : string;
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
  oldBS := fBoolSubExpStr;
  try
    // set the old expression to be everything except for the first token in
    // the new expression (aka "Value").
    lenVal := Length(Value);
    Delete(oldExpStr, Length(oldExpStr)-lenVal+1, lenVal);
    Delete(oldBS, Length(oldBS)-lenVal+1, lenVal);
    // now start our new expression with the current token
    fExpStr := Value;
    fBoolSubExpStr := Value;
    prev := SourceCount;
    if IncrementOrDecrement then
    begin
      // handle pre-increment or pre-decrement unary operators
      DoPreIncOrDec(true);
    end
    else
    begin
      if IsAddOp(Token) then
        ClearReg  // handle + and - unary operators
      else
        Term;
      while IsAddop(Token) do begin
        PushPrim;
        case Token of
          '+': Add;
          '-': Subtract;
        end;
      end;
      optExp := OptimizeExpression(fExpStr, prev, fExpStrHasVars, Value);
    end;
  finally
    fExpStr := oldExpStr + optExp + Value;
    fBoolSubExpStr := oldBS + optExp + Value;
  end;
end;

function TEVCComp.OptimizeExpression(str : string; const idx: integer; bFlag : boolean; const aValue : string) : string;
var
  p, len1, len2 : integer;
begin
  fLastExpressionOptimizedToConst := False;
{
  // if the last character is a ) or a ; then delete it.
  if str[Length(str)] in [')', ';'] then
    System.Delete(str, Length(str), 1);
}
  Result := str;
  p := Pos(aValue, Result);
  len1 := Length(Result);
  len2 := Length(aValue);
  if (p > 0) and (p = (len1 - len2 + 1)) then
    System.Delete(Result, p, MaxInt);
  if (OptimizeLevel >= 0) and (SourceCount > (idx+1)) and not bFlag then
  begin
    // 2009-03-18 JCH: I do not recall why I added the check for
    // + and - as the first character of an expression
    // I haven't been able to detect any harm in removing this check but
    // it could be something very obscure that will come up again

    // 2009-04-09 JCH: See my comment in the Expression function above.
    // The commented-out code was preventing a bug that had far too many
    // lines of code being removed if an expression ended in +nnn or -nnn.

    if (str <> '') {and not (str[1] in ['+', '-'])} then
    begin
      fCalc.SilentExpression := Result;
      if not fCalc.ParserError then
      begin
        str := IntToStr(Trunc(fCalc.Value));
        Result := str;
        // in theory, we can replace all the lines between idx and
        // SourceCount with one line
        while SourceCount > idx do
          SourceDelete(SourceCount-1);
        LoadConst(str);
        str := '';
        fLastExpressionOptimizedToConst := True;
      end;
    end;
  end;
end;

function TEVCComp.GetDecoratedIdent(const val : string) : string;
var
  i : integer;
begin
  Result := val;
  if not AlreadyDecorated(val, fThreadNames) then
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
      if Pos('@', Result) = 1 then
      begin
        System.Delete(Result, 1, 1);
        if Pos('0x', Result) = 1 then
        begin
          System.Delete(Result, 1, 2);
          Result := Result + 'H';
        end;
      end;
    end;
  end;
end;

function TEVCComp.GetDecoratedValue : string;
begin
  Result := GetDecoratedIdent(Value);
end;

procedure TEVCComp.NumericRelation;
var
  savedToken, savedLook : Char;
begin
  NumericRelationLTGT;
  while ((Token = '=') and (Look = '=')) or // C/C++ equal
        ((Token = '!') and (Look = '=')) or // C/C++ not equal
        ((Token = '<') and (Look = '>')) do // pascal not equal
  begin
    savedToken := Token;
    savedLook  := Look;
    PushPrim;
    Next;
    Next;
    NumericRelationLTGT;
    if (savedToken = '=') and (savedLook = '=') then
      PopCmpEqual
    else
      PopCmpNEqual;
//    StoreZeroFlag;
  end;
end;

procedure TEVCComp.NumericRelationLTGT;
var
  savedToken, savedLook : Char;
begin
  NumericShiftLeftRight;
  while (not ((Token = '<') and (Look = '>'))) and // not <> (pascal not equal)
        (((Token = '<') and (Look = '='))   or // <=
         ((Token = '<') and (Look <> '<'))  or // < (not left shift)
         ((Token = '>') and (Look = '='))   or // >=
         ((Token = '>') and (Look <> '>'))) do // > (not right shift)
  begin
    savedToken := Token;
    savedLook  := Look;
    PushPrim;
    if (Look = '=') then // handle <= and >= case
      Next;
    Next;
    NumericShiftLeftRight;
    if      (savedToken = '<') and (savedLook = '=')  then // <=
      PopCmpLessOrEqual
    else if (savedToken = '<') and (savedLook <> '<') then // <
      PopCmpLess
    else if (savedToken = '>') and (savedLook = '=')  then // >=
      PopCmpGreaterOrEqual
    else                                                   // >
      PopCmpGreater;
//    StoreZeroFlag;
  end;
end;

procedure TEVCComp.NumericShiftLeftRight;
var
  val : integer;
  savedToken, savedLook : Char;
begin
  Expression;
  while ((Token = '<') and (Look = '<')) or  // <<
        ((Token = '>') and (Look = '>')) do  // >>
  begin
    savedToken := Token;
    savedLook  := Look;
    PushPrim;
    Next;
    Next;
    Expression;
    if fLastExpressionOptimizedToConst then
    begin
      val := StrToIntDef(fLastLoadedConst, MaxInt);
      if (val < 1) or (val > 31) then
        AbortMsg(sInvalidShift);
      if (savedToken = '<') and (savedLook = '<')  then
        PopLeftShift
      else
        PopRightShift;
    end
    else
      AbortMsg(sConstantShifts);
  end;
end;

{---------------------------------------------------------------}
{ Parse and Translate a Relation }

procedure TEVCComp.Relation;
begin
  // would it be better to check for unary operators before branching by
  // relation type???
  if (Token = TOK_IDENTIFIER) and (ValueIsArrayType or ValueIsUserDefinedType) then
  begin
    if (Look = '[') or (Look = '.') or (Look = '-') then
    begin
      NumericRelation;
    end;
  end
  else
  begin
    NumericRelation;
  end;
end;

procedure TEVCComp.BoolTerm;
var
  L : string;
  bAnd : boolean;
begin
  bAnd := False;
  L := NewLabel;
  // 2010-05-27 JCH new code for BoolTerm
  BitOr;
  while (Token = '&') and (Look = '&') do
  begin
    bAnd := True;
    // move to the second '&'
    Next;
    // move past the second '&'
    Next;
    // convert D0 to boolean value if necessary
    if not fCCSet then
    begin
      SetZeroCC;
//      StoreZeroFlag;
    end;
    BranchFalse(L);
//    PushPrim;
    BitOr;
    // convert D0 to boolean value if necessary
    if not fCCSet then
    begin
      SetZeroCC;
//      StoreZeroFlag;
    end;
//    PopAnd;
  end;
  PostLabel(L);
  if bAnd then
    StoreZeroFlag;
end;

procedure TEVCComp.BitOr;
begin
  BitXor;
  while (Token = '|') and (Look <> '|') do
  begin
    Next;
    PushPrim;
    BitXor;
    PopOr;
  end;
end;

procedure TEVCComp.BitXor;
begin
  BitAnd;
  while (Token = '^') do
  begin
    Next;
    PushPrim;
    BitAnd;
    PopXor;
  end;
end;

procedure TEVCComp.BitAnd;
begin
  Relation;
  while (Token = '&') and (Look <> '&') do
  begin
    Next;
    PushPrim;
    Relation;
    PopAnd;
  end;
end;

procedure TEVCComp.CommaExpression;
begin
  BoolExpression;
  if fNoCommaOperator then Exit;
  // handle comma?
  if Token = TOK_COMMA then
  begin
    Next; // skip past the comma
    CommaExpression;
  end;
end;

procedure TEVCComp.BoolExpression;
var
  L1, L2 : string;
begin
  CheckForCast;
  BoolSubExpression;
  while Token = '?' do begin
    // we are parsing a ?: expression
    Next;
    L1 := NewLabel;
    L2 := NewLabel;
    BranchFalse(L1);
    CommaExpression;
    Branch(L2);
    MatchString(':');
    PostLabel(L1);
    CommaExpression;
    PostLabel(L2);
  end;
  HandleCast;
end;

procedure TEVCComp.BoolSubExpression;
var
  L : string;
  bOr : boolean;
  prev, lenVal : integer;
  oldBS, optExp : string;
begin
  fBoolSubExpStrHasVars := False;
  oldBS := fBoolSubExpStr;
  try
    // set the old expression to be everything except for the first token in
    // the new expression (aka "Value").
    lenVal := Length(Value);
    Delete(oldBS, Length(oldBS)-lenVal+1, lenVal);
    // now start our new bool sub expression with the current token
    fBoolSubExpStr := Value;
    prev := SourceCount;

    bOr := False;
    L := NewLabel;
    BoolTerm;
    while (Token = '|') and (Look = '|') do begin
      bOr := True;
      // advance to second '|'
      Next;
      // advance past the second '|'
      Next;
      // convert D0 to boolean value if necessary
      if not fCCSet then
      begin
        SetZeroCC;
//        StoreZeroFlag;
      end;
      BranchTrue(L);
//      PushPrim;
      BoolTerm;
      // convert D0 to boolean value if necessary
      if not fCCSet then
      begin
        SetZeroCC;
//        StoreZeroFlag;
      end;
//      PopOr;
    end;
    PostLabel(L);
    if bOr then
      StoreZeroFlag;

    optExp := OptimizeExpression(fBoolSubExpStr, prev, fBoolSubExpStrHasVars, Value);
  finally
    fBoolSubExpStr := oldBS + optExp + Value;
  end;
end;

function TEVCComp.GetParamName(procname: string; idx: integer): string;
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
    TOK_ARRAYLONGDEF..TOK_ARRAYLONGDEF4, TOK_LONGDEF : Result := fptSLONG;
    TOK_ARRAYUDT..TOK_ARRAYUDT4, TOK_USERDEFINEDTYPE : Result := fptUDT;
  else
    Result := fptSLONG;
  end;
end;

procedure TEVCComp.AddFunctionParameter(pname, varname, tname: string; idx: integer;
  ptype : char; bIsConst, bIsRef, bIsArray : boolean; aDim : integer;
  bHasDefault : boolean; defValue : string);
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
    HasDefault     := bHasDefault;
    DefaultValue   := defValue;
  end;
end;

function TEVCComp.FunctionParameterCount(const name : string) : integer;
begin
  Result := fFuncParams.ParamCount(name);
end;

function TEVCComp.FunctionRequiredParameterCount(const name : string) : integer;
begin
  Result := fFuncParams.RequiredParamCount(name);
end;

function TEVCComp.FunctionParameterType(const name: string;
  idx: integer): char;
var
  i : integer;
begin
  Result := #0;
  i := fFuncParams.IndexOf(name, idx);
  if i <> -1 then
    Result := fFuncParams[i].ParameterDataType;
end;

function TEVCComp.FunctionParameterTypeName(const name: string;
  idx: integer): string;
var
  i : integer;
begin
  Result := '';
  i := fFuncParams.IndexOf(name, idx);
  if i <> -1 then
    Result := fFuncParams[i].ParamTypeName;
end;

function TEVCComp.FunctionParameterIsConstant(const name: string;
  idx: integer): boolean;
var
  i : integer;
begin
  Result := False;
  i := fFuncParams.IndexOf(name, idx);
  if i <> -1 then
    Result := fFuncParams[i].IsConstant;
end;

function TEVCComp.FunctionParameterIsReference(const name: string;
  idx: integer): boolean;
var
  i : integer;
begin
  Result := False;
  i := fFuncParams.IndexOf(name, idx);
  if i <> -1 then
    Result := fFuncParams[i].IsReference;
end;

function TEVCComp.FunctionParameterHasDefault(const name: string;
  idx: integer): boolean;
var
  i : integer;
begin
  Result := False;
  i := fFuncParams.IndexOf(name, idx);
  if i <> -1 then
    Result := fFuncParams[i].HasDefault;
end;

function TEVCComp.FunctionParameterDefaultValue(const name: string;
  idx: integer): string;
var
  i : integer;
begin
  Result := '';
  i := fFuncParams.IndexOf(name, idx);
  if i <> -1 then
    Result := fFuncParams[i].DefaultValue;
end;

function TEVCComp.GetFunctionParam(const procname : string; idx : integer) : TFunctionParameter;
var
  i : integer;
begin
  Result := nil;
  i := fFuncParams.IndexOf(procname, idx);
  if i <> -1 then
    Result := fFuncParams[i];
end;

function TEVCComp.AdvanceToNextParam : string;
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

procedure TEVCComp.DoCall(procname : string);
var
  protocount, protoreqcount, acount, idx, i : integer;
  dt, rdt, pdt, oldLHSDT : char;
  parname, parvalue, junk, oldLHSName : string;
  bError : boolean;
  fp : TFunctionParameter;
  fInputs : TStrings;
  bFunctionIsInline : boolean;
  inlineFunc : TInlineFunction;
begin
  fNoCommaOperator := True;
  try
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
          protoreqcount := FunctionRequiredParameterCount(procname);
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
            fBoolSubExpStr := fExpStr;
          end;
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
                if fp.IsVarReference then
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
                  if fp.IsArray then
                    InitializeArrayReference(parname, parvalue)
                  else if fp.ParamType = fptUDT then
                    InitializeUDTReference(parname, parvalue)
                  else
                    InitializeVarReference(parname, parvalue);
                  junk := AdvanceToNextParam;
                  if junk <> '' then
                    AbortMsg(sExpNotSupported)
                  else
                    CheckTypeCompatibility(fp, pdt, parvalue);
                end
    // beginning of addition for handling expressions for UDT and array parameters
                else if fp.IsArray or (fp.ParamType = fptUDT) then
                begin
                  fInputs.AddObject('', fp);
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
                  if dt <> #0 then
                  begin
                    // collect tokens to TOK_CLOSEPAREN or TOK_COMMA
                    parvalue := Value;
                    SkipWhite; // skip any whitespace just in case
                    while not (Look in [TOK_CLOSEPAREN, TOK_COMMA]) or endofallsource do begin
                      Next;
                      parvalue := parvalue + Value;
                    end;
                    Next;
                    fCalc.SilentExpression := GetValueOf(parvalue);
                    if not fCalc.ParserError then
                    begin
                      parvalue := CCFloatToStr(Trunc(fCalc.Value));
                      fCalc.SetVariable(parname, Trunc(fCalc.Value));
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
                      CopyVar(parname, parvalue);
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
                        Expected(sConstOrConstExpr);
                      end;
                    end;
                  end;
                end
    // end of previously commented out block
                else
                begin
                  fInputs.AddObject('', fp);
                  // pass in True to make it so that no checks are performed
                  // in Store and StoreString
                  DoAssignValue(parname, dt, False);
                end;
              finally
                fLHSDataType := oldLHSDT;
                fLHSName     := oldLHSName;
              end;
            end;
            inc(acount);
            Scan;
            if acount < protoreqcount then
            begin
              MatchString(TOK_COMMA);
              Scan;
            end
            else begin
              // we are now supposed to either have a comma or a close paren
              // depending on the value of acount compared to protocount
              if (acount < protocount) and not (Token in [TOK_COMMA, TOK_CLOSEPAREN]) then
              begin
                MatchString(TOK_COMMA);
                Scan;
              end
              else
              begin
                if Token = TOK_COMMA then begin
                  Next;
                  Scan;
                end;
              end;
            end;
          end;
          if Value = TOK_CLOSEPAREN then
          begin
            CloseParen;

            // TODO: look up the decorated function name given the procname
            // and the types of all the parameters passed into the function
            // if we find a function with the right name and parameters
            // then keep going.  Otherwise report an error
            // if the number of parameters provided is less than the function's
            // defined number of parameters

            if protoreqcount > acount then
              AbortMsg(sTooFewParams);

            while acount < protocount do
            begin
              // use default values for all the arguments not provided
              fp := GetFunctionParam(procname, acount);
              if Assigned(fp) then
              begin
                parname := GetParamName(procname, acount);
                if bFunctionIsInline then
                  parname := InlineName(fCurrentThreadName, parname);
                parvalue := FunctionParameterDefaultValue(procname, acount);
                CopyVar(parname, parvalue);
              end;
              inc(acount);
            end;

            if bFunctionIsInline then
              EmitAsmLines(inlineFunc.AsString('RET', 'JMP'))
            else
              CallRoutine(procname);
(*
            // copy out non-const reference values
            for i := 0 to fInputs.Count - 1 do begin
              fp := TFunctionParameter(fInputs.Objects[i]);
              if fp.IsVarReference then begin
                // must copy out the non-const references
                parname := GetParamName(procname, i);
                if bFunctionIsInline then
                  parname := InlineName(fCurrentThreadName, parname);
                CopyVar(fInputs[i], parname);
              end;
            end;
*)
            rdt := FunctionReturnType(procname);
            if IsUDT(rdt) or IsArrayType(rdt) then
            begin
              // tell the compiler that a UDT/Array is on stack
              if bFunctionIsInline then
                fUDTOnStack := Format('__result_%s', [InlineName(fCurrentThreadName, procname)])
              else
                fUDTOnStack := Format('__result_%s', [procname]);
            end
            else if rdt in NonAggregateTypes then
            begin
              // copy value from subroutine to register
              if bFunctionIsInline then
                CopyVar(RegisterName, RegisterName(InlineName(fCurrentThreadName, procname)))
              else
                CopyVar(RegisterName, RegisterName(procname));
            end;
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
  finally
    fNoCommaOperator := False;
  end;
end;

function TEVCComp.RemoveArrayDimension(dt: char): char;
begin
  Result := dt;
  if IsArrayType(dt) then
  begin
    case dt of
      TOK_ARRAYUDT       : Result := TOK_USERDEFINEDTYPE;
      TOK_ARRAYLONGDEF   : Result := TOK_LONGDEF;
    else
      Result := Char(Ord(dt)-1);
    end;
  end;
end;

function TEVCComp.AddArrayDimension(dt: char): char;
begin
  case dt of
    TOK_USERDEFINEDTYPE : Result := TOK_ARRAYUDT;
    TOK_LONGDEF         : Result := TOK_ARRAYLONGDEF;
  else
    if IsArrayType(dt) then
    begin
      Result := Char(Ord(dt)+1);
    end
    else
      Result := dt;
  end;
end;

procedure TEVCComp.ArrayAssignment(const name : string; dt : char; bIndexed : boolean);
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
      CommaExpression;
    finally
      fLHSDataType := oldType;
    end;
    MatchString(']');
    push;
    tmp := tos;
    CopyVar(tmp, RegisterName);
    dt := RemoveArrayDimension(dt);
    fLHSDataType := RemoveArrayDimension(fLHSDataType);
  end;
  // check for additional levels of indexing
  if (Token = '[') and IsArrayType(dt) then
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
      DoIndex(aval, GetDecoratedIdent(name), tmp);
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
      DoIndex(aval, GetDecoratedIdent(name), tmp);
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
      push;
      aval := tos;
      DoIndex(aval, GetDecoratedIdent(name), tmp);
      MathAssignment(aval);
      StoreArray(name, tmp, aval);
      pop;
    end
    // 2011-02-11 - Added code to handle math assignment for arrays of UDTs
    else if IsUDT(dt) and bIndexed then
    begin
      // dt is not non-aggregated
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
        DoIndex(aval, GetDecoratedIdent(name), tmp);
        MathAssignment(aval);
        // store temporary thread-safe variable back into previous array
        StoreArray(name, tmp, aval);
      finally
        fArrayHelpers.ReleaseHelper(AHV);
      end;
    end
    // 2011-02-11 - End of new code for arrays of UDTs
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

procedure TEVCComp.CheckDataType(dt: char);
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

procedure TEVCComp.DoArrayAssignValue(const aName, idx: string; dt: char);
var
  oldType : Char;
  oldName, udType : string;
  AHV : TArrayHelperVar;
begin
  if (Token = TOK_IDENTIFIER) and IsUDT(DataType(Value)) {dt = TOK_USERDEFINEDTYPE} then
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
        if fUDTOnStack <> '' then
        begin
          CheckAndStore(aName);
          fUDTOnStack := '';
        end;
        NotIt(GetDecoratedIdent(aName));
      end
      else begin
        NumericFactor;
        if fUDTOnStack <> '' then
        begin
          CheckAndStore(aName);
          fUDTOnStack := '';
        end;
      end;
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
            if fUDTOnStack <> '' then
            begin
              CheckAndStore(fLHSName);
              fUDTOnStack := '';
            end;
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
    // since this is an assignment statement we do not allow comma operators
    // due to the = operator having a higher precedence than the , operator.
    BoolExpression;
    StoreArray(aName, idx, RegisterName);
  end;
end;

procedure TEVCComp.MathAssignment(const name : string);
var
  savedtoken : char;
  val : integer;
//  oldType : char;
begin
  fProcessingMathAssignment := True;
  try
    // Look has to be '=', '+', or '-' or it's all messed up
    if Look = '=' then
    begin
      savedtoken := Token;
      Next; // move to '='
      Next; // move to next token
      // 2010-05-05 JCH - to make += work with non-scalars on the RHS I undid the
      // above change.  Testing seems to prove that scalars on the RHS still
      // work correctly.
      BoolExpression;
      // end of 2010-05-05 changes
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
      StoreInc(name); // postfix increment has higher precedence than dereference
    end
    else if (Token = '-') and (Look = '-') then
    begin
      Next; // move to second -
      Next;
      StoreDec(name); // postfix decrement has higher precedence than dereference
    end
    else if ((Token = '>') and (Look = '>')) or ((Token = '<') and (Look = '<')) then
    begin
      savedtoken := Token;
      Next; // move to second > or <
      if Look = '=' then
      begin
        Next; // move to '='
        Next; // move to next token
        Expression;
        if fLastExpressionOptimizedToConst then
        begin
          val := StrToIntDef(fLastLoadedConst, MaxInt);
          if (val < 1) or (val > 31) then
            AbortMsg(sInvalidShift);
          StoreShift(savedtoken='>', name);
        end
        else
          AbortMsg(sConstantShifts);
      end
      else
        AbortMsg(sInvalidAssignment);
    end
    else
      AbortMsg(sInvalidAssignment);
  finally
    fProcessingMathAssignment := False;
  end;
end;

procedure TEVCComp.DoLabel;
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

procedure TEVCComp.DoStart;
var
  taskname : string;
begin
  Next;
  taskname := Value;
  CheckTask(taskname);
  Next;
  StartProcess(taskname);
end;

procedure TEVCComp.OffsetUDTPointer(const UDTType : string; const aPointer: string);
var
  member : string;
  DE, sub : TDataspaceEntry;
  i : integer;
  offset : integer;
begin
  // recursively offset this pointer by member names, etc...
  member := Value;
  offset := 0;
  DE := DataDefinitions.FindEntryByFullName(UDTType);
  if Assigned(DE) then
  begin
    sub := nil;
    for i := 0 to DE.SubEntries.Count - 1 do
    begin
      sub := DE.SubEntries[i];
      // is this the member we are looking for?
      if sub.Identifier = member then
      begin
        break;
      end
      else
      begin
        offset := offset + sub.SizeOf;
      end;
    end;
    if offset > 0 then
      DoAddImmediate(aPointer, offset);
    Next; // move past member name
    if (Token = '.') or (Token = '-') and (Look = '>') then
    begin
      // now offset the pointer by the specified member
      Next;
      if Token = '>' then
      begin
//        CheckPointer(UDTType+'.'+member);
        Next;
      end;
      if Assigned(sub) then
        OffsetUDTPointer(sub.TypeName, aPointer);
    end
    else if Token = '[' then
    begin
      Next;
      OffsetArrayPointer(UDTType+'.'+member, aPointer);
    end;
  end
  else
    AbortMsg('unknown user-defined type: ' + UDTType);
end;

procedure TEVCComp.OffsetArrayPointer(const ArrayType : string; const aPointer: string);
var
  DE : TDataspaceEntry;
//  i : integer;
//  offset : integer;
  dsType : TDSType;
begin
  // TODO: finish implementing this code.
  // recursively offset this pointer by array index, etc...
//  offset := 0;
  DE := DataDefinitions.FindEntryByFullName(ArrayType);
  if Assigned(DE) then
  begin
    // the array's data type is stored in its first and only sub entry
    if DE.SubEntries.Count > 0 then
    begin
      dsType := DE.SubEntries[0].DataType;
    end
    else
      dsType := dsSLong;

    if dsType = dsArray then
      ;

//    DoAddImmediate(aPointer, offset);
    Next; // move past ']'
    if (Token = '.') or (Token = '-') and (Look = '>') then
    begin
(*
      // now offset the pointer by the specified member
      Next;
      if Token = '>' then
        Next;
      OffsetUDTPointer(GetUDTType(UDTType+'.'+member), aPointer);
*)
    end
    else if Token = '[' then
    begin
//      Next;
//      OffsetArrayPointer(ArrayType+'.'+member, aPointer);
    end;
  end
  else
    AbortMsg('unknown array type: ' + ArrayType);
end;

procedure TEVCComp.Assignment;
var
  Name, pLHS: string;
  dt : char;
  bNeedToPop : boolean;
begin
  bNeedToPop := False;
  fDerefAssignment := Token = '*';
  if fDerefAssignment then
    Next;
  if IncrementOrDecrement then
  begin
    DoPreIncOrDec(false);
  end
  else
  begin
    if not IsParam(Value) and
       not IsLocal(Value) and
       not IsGlobal(Value) and
       not IsAPIFunc(Value) then
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
    else begin
      if fDerefAssignment then
        CheckPointer(Name);
      Next; // move past the variable name
      if Token = '.' then
      begin
        if dt <> TOK_USERDEFINEDTYPE then
          AbortMsg('member selection invalid');
        // UDT member selection
        Name := GetDecoratedIdent(Name);
        Next;
        fDerefAssignment := True;
        // take the address of Name and store it in pLHS
        bNeedToPop := True;
        push;
        pLHS := tos;
        StoreAddress(pLHS, Name);
        // now offset the pointer by the specified member
        OffsetUDTPointer(GetUDTType(Name), pLHS);
        Name := pLHS;
        dt := DataType(Name);
      end
      else if (Token = '-') and (Look = '>') then
      begin
        if dt <> TOK_USERDEFINEDTYPE then
          AbortMsg('member selection invalid');
        Name := GetDecoratedIdent(Name);
        if not IsPointer(Name) then
          AbortMsg('pointer to member selection invalid');
        Next;
        Next;
        fDerefAssignment := True;
        // take the address of Name and store it in pLHS
        bNeedToPop := True;
        push;
        pLHS := tos;
        StoreValue(pLHS, Name); // Name is already a pointer so don't store its address
        // now offset the pointer by the specified member
        OffsetUDTPointer(GetUDTType(Name), pLHS);
        Name := pLHS;
        dt := DataType(Name);
      end;
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
          MathAssignment(Name);
        end
        else if Token = '=' then
        begin
          MatchString('=');
          DoAssignValue(Name, dt);
        end
        else
        begin
          // just an identifier but not assignment operator
          // put it on the stack
          CheckAndLoadVar(Name);
        end;
      finally
        fLHSDataType := TOK_LONGDEF;
        fLHSName     := '';
      end;
    end;
  end;
  fDerefAssignment := False;
  if bNeedToPop then
    pop;
end;

procedure TEVCComp.DoAssignValue(const aName: string; dt: char; bNoChecks : boolean);
begin
  // no comma expression here since the assignment operator has a
  // higher precedence than the comma operator
  BoolExpression;
  if bNoChecks then
    Store(aName)
  else
    CheckAndStore(aName);
end;

procedure TEVCComp.DoIf(const lend, lstart : string);
var
  L1, L2: string;
begin
  Next;
  OpenParen;
  CommaExpression;
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

procedure TEVCComp.DoWhile;
var
  L1, L2: string;
begin
  Next;
  L1 := NewLabel;
  L2 := NewLabel;
  PostLabel(L1);
  OpenParen;
  CommaExpression;
  CloseParen;
  BranchFalse(L2);
  Block(L2, L1);
  Branch(L1);
  PostLabel(L2);
end;

procedure TEVCComp.DoDoWhile;
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
  CommaExpression;
  CloseParen;
  BranchFalse(L2);
  Branch(L1);
  PostLabel(L2);
end;

procedure TEVCComp.DoRepeat;
var
  L1, L2: string;
  svar : string;
begin
  Next;
  L1 := NewLabel;
  L2 := NewLabel;
  OpenParen;
  CommaExpression;
  CloseParen;
  push;
  svar := tos;
  CopyVar(svar, RegisterName);
  PostLabel(L1);
  StoreDec(svar);
  Block(L2, L1);
  TestVariable(svar);
  BranchPositive(L1);
  PostLabel(L2);
  pop;
end;

function StringToBool(const aValue : string) : boolean;
begin
  Result := aValue = 'TRUE';
end;

procedure TEVCComp.DoSwitch(const lstart : string);
var
  L2 : string;
  idx : integer;
  tmpRN : string;
begin
  Next;
  OpenParen;
  CommaExpression;
  CloseParen;
  push;
  tmpRN := tos;
  CopyVar(tmpRN, RegisterName);
  L2 := NewLabel;
  idx := SwitchFixupIndex;
  inc(fSwitchDepth);
  try
    ClearSwitchFixups;
    SwitchFixups.Add(Format('%d_Type=0', [fSwitchDepth]));
    SwitchRegisterNames.Add(Format('%d=%s', [fSwitchDepth, tmpRN]));
    Block(L2, lstart);
    PostLabel(L2);
    FixupSwitch(idx, L2);
  finally
    dec(fSwitchDepth);
  end;
  pop;
end;

function TEVCComp.GetCaseConstant: string;
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
  if IsLocal(Result) then
    Result := GetDecoratedIdent(Result);
  Result := CheckConstant(Result);
end;

procedure TEVCComp.DoSwitchCase;
var
  L1 : string;
  caseval, stackval, tmp : string;
begin
  caseval := '';
  if fSwitchDepth > 0 then
  begin
    Next; // move past 'case'
    caseval := GetCaseConstant;
    MatchString(':'); // token should be ':' at this point
    L1 := NewLabel;
    PostLabel(L1);
    stackval := SwitchRegisterName;
    tmp := Format('%d_Cases=%s', [fSwitchDepth, caseval]);
    if SwitchFixups.IndexOf(tmp) <> -1 then
      AbortMsg(sCaseDuplicateNotAllowed)
    else
    begin
      SwitchFixups.Add(tmp);
      push;
      SwitchFixups.Add(Format('%d=%s', [fSwitchDepth, MoveAsString(tos, stackval)]));
      SwitchFixups.Add(Format('%d=%s', [fSwitchDepth, SubImmAsString(tos, caseval)]));
      SwitchFixups.Add(Format('%d=%s', [fSwitchDepth, BranchFalseAsString(L1)]));
      pop;
    end;
    fSemiColonRequired := False;
  end
  else
    AbortMsg(sCaseInvalid);
end;

procedure TEVCComp.DoSwitchDefault;
var
  L1, tmp : string;
begin
  if fSwitchDepth > 0 then
  begin
    Next; // move past 'default'
    MatchString(':');
    L1 := NewLabel;
    PostLabel(L1);
    tmp := Format('%d_Default=default', [fSwitchDepth]);
    if SwitchFixups.IndexOf(tmp) <> -1 then
      AbortMsg(sCaseDuplicateNotAllowed)
    else
    begin
      SwitchFixups.Add(tmp);
      SwitchFixups.Add(Format('%d_Default=%s', [fSwitchDepth, BranchAsString(L1)]));
    end;
    fSemiColonRequired := False;
  end
  else
    AbortMsg(sDefaultInvalid);
end;

procedure TEVCComp.ClearSwitchFixups;
var
  i : integer;
  tmpType, tmpCases, tmpDepth, tmpDefault, name : string;
begin
// remove all fixups with depth == fSwitchDepth
  tmpDepth := IntTostr(fSwitchDepth);
  tmpType  := Format('%d_Type', [fSwitchDepth]);
  tmpCases := Format('%d_Cases', [fSwitchDepth]);
  tmpDefault := Format('%d_Default', [fSwitchDepth]);
  for i := SwitchFixups.Count - 1 downto 0 do
  begin
    name := SwitchFixups.Names[i];
    if (name = tmpDepth) or (name = tmpType) or (name = tmpCases) or (name = tmpDefault) then
      SwitchFixups.Delete(i);
  end;
  for i := SwitchRegisterNames.Count - 1 downto 0 do
  begin
    if SwitchRegisterNames.Names[i] = tmpDepth then
      SwitchRegisterNames.Delete(i);
  end;
end;

function TEVCComp.SwitchRegisterName: string;
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

procedure TEVCComp.FixupSwitch(idx : integer; lbl : string);
var
  i : integer;
  cnt : integer;
  tmpDepth, tmpDefault, tmpVal : string;
begin
  tmpDepth := IntToStr(fSwitchDepth);
  tmpDefault := Format('%d_Default', [fSwitchDepth]);
  // add a jump to the end of the switch if
  // there isn't a default label in the switch
  if SwitchFixups.IndexOf(tmpDefault+'=default') = -1 then
    SwitchFixups.Add(Format('%d=%s', [fSwitchDepth, BranchAsString(lbl)]));
  cnt := 0;
  // add the case branches first
  for i := 0 to SwitchFixups.Count - 1 do
  begin
    if SwitchFixups.Names[i] = tmpDepth then
    begin
      SourceInsert(idx+cnt, #9+SwitchFixups.ValueFromIndex[i]);
      inc(cnt);
    end;
  end;
  // now add the default branch last
  for i := 0 to SwitchFixups.Count - 1 do
  begin
    if SwitchFixups.Names[i] = tmpDefault then
    begin
      tmpVal := SwitchFixups.ValueFromIndex[i];
      if (tmpVal <> 'default') then
      begin
        SourceInsert(idx+cnt, #9+tmpVal);
        break;
      end;
    end;
  end;
end;

function TEVCComp.SwitchFixupIndex: integer;
begin
  Result := SourceCount;
end;

function TEVCComp.ReplaceTokens(const line: string) : string;
begin
  Result := line; // line is already trimmed
  if Length(Result) = 0 then Exit;
  Result := Replace(Result, '__RETURN__', #13#10#9+MoveAsString(RegisterName, ''));
  Result := Replace(Result, '__RETURNS__', #13#10#9+MoveAsString(RegisterName, ''));
  Result := Replace(Result, '__TMPLONG__', TempSignedLongName);
  Result := Replace(Result, '__RETVAL__', RegisterName);
  Result := Replace(Result, 'true', 'TRUE');
  Result := Replace(Result, 'false', 'FALSE');
end;

function TEVCComp.DecorateVariables(const asmStr: string): string;
var
  Lex : TGenLexer;
  len : integer;
  bPartOfStruct, bPastFirstKeyword : boolean;

  procedure AddToResult;
  begin
    if (Lex.Id = piIdent) or (bPastFirstKeyword and (Lex.Id = piKeyWord)) then
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
    Lex := TEVALexer.CreateLexer;
    try
      bPartOfStruct := False;
      bPastFirstKeyword := False;
      Lex.SetStartData(@asmStr[1], len);
      while not Lex.AtEnd do
      begin
        AddToResult;
        if not bPastFirstKeyword and (Lex.Id = piKeyWord) then
          bPastFirstKeyword := True;
        Lex.Next;
      end;
      if Lex.Id <> piUnknown then
        AddToResult;
    finally
      Lex.Free;
    end;
  end;
end;

procedure TEVCComp.DoAsm(var dt : char);
var
  asmStr : string;
  nestLevel : integer;
begin
// gather everything within asm block and output it
  fProcessingAsmBlock := True;
  try
    EmitPoundLine;
    MatchString(TOK_BEGIN);
    if Value <> TOK_END then
    begin
      asmStr := Value + ' ' + Look;
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
        if Pos('__RETVAL__', asmStr) > 0 then
        begin
          // 2011-07-15 - this change fixes a bug found by muntoo
          //(http://sourceforge.net/apps/phpbb/mindboards/viewtopic.php?f=3&t=955)
          dt := TOK_LONGDEF;
        end;
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
  finally
    fProcessingAsmBlock := False;
  end;
end;

procedure TEVCComp.DoFor;
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
    if Token in [TOK_LONGDEF] then
    begin
      DoLocals(fCurrentThreadName);
    end
    else
    begin
      if Token <> TOK_SEMICOLON then
      begin
        fNoCommaOperator := True;
        try
          Assignment;
          while Token = TOK_COMMA do
          begin
            Next;
            Assignment;
          end;
        finally
          fNoCommaOperator := False;
        end;
      end;
      Semi;
    end;
    PostLabel(L1);
    if Token <> TOK_SEMICOLON then
      CommaExpression
    else
      LoadConst('1');
    Semi;
    BranchFalse(L2);
    Branch(L3);
    PostLabel(L4);
    if Token <> TOK_CLOSEPAREN then
    begin
      fNoCommaOperator := True;
      try
        Assignment;
        while Token = TOK_COMMA do
        begin
          Next;
          Assignment;
        end;
      finally
        fNoCommaOperator := False;
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

procedure TEVCComp.DoAPICommands(const lend, lstart : string);
var
  idx : integer;
begin
  idx := IndexOfAPICommand(Value);
  case idx of
    API_BREAK    : DoBreakContinue(idx, lend);
    API_CONTINUE : DoBreakContinue(idx, lstart);
    API_RETURN   : DoReturn;
    API_STOP     : DoStop;
    API_GOTO     : DoGoto;
    API_EXITTO   : DoExitTo;
    API_ROTLEFT  : DoRotate(idx);
    API_ROTRIGHT : DoRotate(idx);
    API_RUN      : DoRunProgram;
    API_WAIT     : DoWait;
    API_HALTEX   : DoStopProcesses;
  else
    AbortMsg(sUnknownAPICommand);
  end;
end;

procedure TEVCComp.Statement(const lend, lstart : string);
var
  dt : Char;
begin
  fUDTOnStack := ''; // a UDT can't remain on the stack across a statement boundary
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
      TOK_SWITCH:     DoSwitch(lstart);
      TOK_CASE:       DoSwitchCase;
      TOK_DEFAULT:    DoSwitchDefault;
      TOK_START:      DoStart;
      TOK_ASM: begin
        Next;
        dt := #0;
        DoAsm(dt);
      end;
      TOK_API:        DoAPICommands(lend, lstart);
      TOK_IDENTIFIER, '*': begin
        if Look = ':' then
          DoLabel
        else
          Assignment;
      end;
      TOK_HEX, TOK_NUM, '+', '-': begin
        CommaExpression;
      end;
      TOK_CLOSEPAREN : CloseParen;
      TOK_SEMICOLON : ;// do nothing
      TOK_END : fSemiColonRequired := False;
    end;
    EmitPoundLine;
  end;
end;

function TEVCComp.Block(const lend, lstart : string) : boolean;
begin
  Result := Value = TOK_BEGIN;
  if Result then
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
    CommaStatement(lend, lstart);
  end;
end;

procedure TEVCComp.CheckBytesRead(const oldBytesRead: integer);
begin
  if fBytesRead = oldBytesRead then
  begin
    AbortMsg(sParserError);
    SkipLine;
    Next;
  end;
end;

procedure TEVCComp.BlockStatements(const lend, lstart: string);
var
  oldBytesRead : integer;
begin
  Scan;
  while not (Token in [TOK_END, TOK_ELSE]) and not endofallsource do
  begin
    oldBytesRead := fBytesRead;
    DoLocals(fCurrentThreadName);
    CommaStatement(lend, lstart);
    CheckSemicolon;
    CheckBytesRead(oldBytesRead);
  end;
end;

procedure TEVCComp.AllocLocal(const sub, tname : string; dt : char; bConst, bStatic : boolean);
var
  savedval : string;
  ival, aval, lenexpr, varName : string;
  bIsArray, bDone, bOpen, bPointer : boolean;
  idx, dimensions, i, cnt : integer;
  V : TVariable;
begin
  Next;
  Scan;
  bPointer := Token = '*';
  if bPointer then
  begin
    Next;
    Scan;
  end;
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
  if bIsArray and bStatic then
    AbortMsg(sStatLocArrNotSupported);
  varName := ApplyDecoration(sub, savedval, fNestingLevel);
  // if the variable is an array with an empty size then it is
  // to be treated as a pointer
  if (aval <> '') and (aval = lenexpr) then
    bPointer := True;
  idx := AddLocal(varName, dt, tname, bConst, lenexpr, bPointer);
  if (Token = TOK_COMMA) or (Token = TOK_SEMICOLON) then
  begin
//    if (aval <> '') and (aval = lenexpr) then
//      AbortMsg(sArrayLenRequired);
    if bConst then
      Expected(sConstInitialization);
    // no need to allocate if we've already emitted this name&type
    if fEmittedLocals.IndexOf(varName+tname) = -1 then
    begin
      cnt := CountElements(lenexpr);
      Allocate(varName, aval, ival, tname, dt, cnt);
    end;
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
      if bStatic and not bIsArray then
      begin
        ival := GetInitialValue(dt);
        // 2011-07-18 Fixed a problem with static variables used
        // in inline functions not being statically initialized.
        V := nil;
        if idx <> -1 then
        begin
          V := fLocals[idx];
          V.Value := ival;
        end;
        if AmInlining and Assigned(fCurrentInlineFunction) and Assigned(V) then
        begin
          i := fCurrentInlineFunction.LocalVariables.IndexOfName(V.Name);
          if i <> -1 then
          begin
            V := fCurrentInlineFunction.LocalVariables[i];
            V.Value := ival;
          end;
        end;
      end
      else
        ival := '';
      if bIsArray then
        ival := GetInitialValue(dt);
      if fEmittedLocals.IndexOf(varName+tname) = -1 then
      begin
        cnt := CountValues(ival);
        Allocate(varName, aval, ival, tname, dt, cnt);
      end;
      if bIsArray then
      begin
        DoLocalArrayInit(varName, ival, dt);
      end
      else if dt = TOK_USERDEFINEDTYPE then
      begin
        GetAndStoreUDT(savedval);
      end
      else if not bStatic then
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

function TEVCComp.GetInitialValue(dt : char): string;
var
  nestLevel : integer;
  tmpExpr : string;
  procedure UpdateResultWithValueForArrayTypes;
  begin
    if tmpExpr <> '' then
    begin
      fCalc.SilentExpression := tmpExpr;
      if not fCalc.ParserError then
      begin
        tmpExpr := IntToStr(Trunc(fCalc.Value));
      end
      else
        AbortMsg(sInvalidConstExpr);
      Result := Result + tmpExpr + Value;
      tmpExpr := '';
    end
    else
      Result := Result + Value;
  end;
begin
  Result := '';
  if IsArrayType(dt) or IsUDT(dt) then
  begin
    // array and struct initialization could involve nested {} pairs
    if Token <> TOK_BEGIN then
      AbortMsg(sInvalidArrayInit);
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
      AbortMsg(sInvalidArrayInit);
  end
  else
  begin
    // Must be a scalar type or user-defined type
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
          Result := IntToStr(Trunc(fCalc.Value));
        end
        else
          AbortMsg(sInvalidConstExpr);
      end;
    end;
  end;
end;

procedure TEVCComp.AllocGlobal(const tname : string; dt : char; bInline, bConst, bStatic : boolean);
var
  savedval, ival, aval, lenexpr : string;
  dimensions, idx, cnt : integer;
  bPointer : boolean;
begin
  Next;
  Scan;
  bPointer := Token = '*';
  if bPointer then
  begin
    Next;
    Scan;
  end;
  if Token <> TOK_IDENTIFIER then Expected(sVariableName);
  // optional initial value
  savedval := Value;
  ival := '';
  Next;
  // it is possible that we are looking at a function declaration
  // rather than a variable declaration.
  if Token = TOK_OPENPAREN then
  begin
    FunctionBlock(savedval, tname, dt, bInline, bPointer);
    fSemiColonRequired := False;
  end
  else
  begin
    fSemiColonRequired := True;
    CheckDup(savedval);
    if bInline then
      AbortMsg(sInlineInvalid);
    aval := '';
    lenexpr := '';
    if Token = '[' then begin
      aval := ProcessArrayDimensions(lenexpr);
      dimensions := Length(aval) div 2; // number of array dimensions
      dt := ArrayOfType(dt, dimensions);
    end;
    // if the variable is an array with an empty size then it is
    // to be treated as a pointer
    if (aval <> '') and (aval = lenexpr) then
      bPointer := True;
    AddEntry(savedval, dt, tname, lenexpr, bConst, bPointer);
    if (Token = TOK_COMMA) or (Token = TOK_SEMICOLON) then
    begin
//      if (aval <> '') and (aval = lenexpr) then
//        AbortMsg(sArrayLenRequired);
      if bConst then
        Expected(sConstInitialization);
      cnt := CountElements(lenexpr);
      Allocate(savedval, aval, ival, tname, dt, cnt);
    end
    else if Token = '=' then
    begin
      // move past the '=' sign
      Next;
      ival := GetInitialValue(dt);
      // lookup global and set its value
      idx := fGlobals.IndexOfName(savedval);
      if idx <> -1 then
      begin
        fGlobals[idx].Value := ival;
      end;
      // the value must be a numeric constant expression if the type
      // is an integer type
      if bConst and (dt in NonAggregateTypes) then
      begin
        fCalc.SetVariable(savedval, StrToInt64Def(ival, 0));
      end;
      cnt := CountValues(ival);
      Allocate(savedval, aval, ival, tname, dt, cnt);
    end
    else
      Next;
  end;
end;

function TEVCComp.GetVariableType(vt : char) : char;
begin
  Result := vt;
end;

procedure TEVCComp.TopDecls;
var
  vt : char;
  bInline, bConst, bStatic : boolean;
  oldBytesRead : Integer;
  dt : char;
  tname : string;
begin
  DoCompilerStatusChange(Format(sXXXProcessGlobals, ['EVC']));
  bInline   := False;
  bConst    := False;
  bStatic   := False;
  Scan;
  if Token = TOK_IDENTIFIER then
    CheckForTypedef(bConst, bStatic, bInline);
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
      TOK_STATIC : begin
        Next;
        Scan;
        bStatic := True;
      end;
      TOK_INLINE : begin
        Next;
        Scan;
        bInline := True;
      end;
      TOK_TYPEDEF : begin
        ProcessTypedef;
      end;
      TOK_ENUM: begin
        ProcessEnum(true);
      end;
      TOK_STRUCT : begin
        ProcessStruct(False);
      end;
      TOK_USERDEFINEDTYPE,
      TOK_LONGDEF : begin
        tname := Value;
        vt := Token;
        AllocGlobal(tname, GetVariableType(vt), bInline, bConst, bStatic);
        while Token = TOK_COMMA do
          AllocGlobal(tname, GetVariableType(vt), bInline, bConst, bStatic);
        CheckSemicolon;
        bInline   := False;
        bConst    := False;
        bStatic   := False;
      end;
    else
      // nothing here right now
      Semi;
      Scan;
    end;
    if Token = TOK_IDENTIFIER then
      CheckForTypedef(bConst, bStatic, bInline);
    CheckBytesRead(oldBytesRead);
  end;
  if bInLine then
    IncrementInlineDepth;
end;

procedure TEVCComp.AddArrayDataDefinition(const aName: string; dt: char;
  lenexpr, tname: string);
var
  DE{, Sub} : TDataspaceEntry;
  p{, dimlen} : integer;
  tmp : string;
begin
  if lenexpr = '' then Exit;
  // if this is an array then we need to add a datatype for it
  DE := DataDefinitions.Add;
  DE.DataType := dsArray;
  DE.Identifier := aName;
  DE.TypeName   := aName;
//  Sub := DE.SubEntries.Add;
  while lenexpr <> '' do
  begin
    System.Delete(lenexpr, 1, 1); // delete the '['
    p := Pos(']', lenexpr);
    if p > 0 then
    begin
      tmp := Copy(lenexpr, 1, p-1);
      // get integer version of dimension length
//      dimlen := StrToIntDef(tmp, 0);
// TODO: finish implementing TEVCComp.AddArrayDataDefinition
      // remove first dimension and keep going
      System.Delete(lenexpr, 1, p);
    end;
  end;
end;

function TEVCComp.AddLocal(name : string; dt : char; const tname : string;
  bConst : boolean; const lenexp : string; bPointer : boolean) : integer;
var
  l, IL : TVariable;
  bAmInlining : boolean;
begin
  CheckForValidDataType(dt);
  Result := -1;
  bAmInlining := AmInlining;
  if IsParam(name) or IsLocal(name) then
    Duplicate(name)
  else
  begin
    l := fLocals.Add;
    l.Name       := name;
    l.DataType   := dt;
    l.IsConstant := bConst;
    l.IsPointer  := bPointer;
    l.TypeName   := tname;
    l.LenExpr    := lenexp;
    l.Level      := fNestingLevel;
    if bAmInlining and Assigned(fCurrentInlineFunction) then
    begin
      IL := fCurrentInlineFunction.LocalVariables.Add;
      IL.Assign(l);
    end;
    Result := l.Index;
    if lenexp <> '' then
    begin
      AddArrayDataDefinition(name, dt, lenexp, tname);
    end;
  end;
end;

procedure TEVCComp.DoLocals(const sub : string);
var
  bIsConst, bDummy, bIsStatic : boolean;
  dt : char;
  tname : string;
begin
  fNoCommaOperator := True;
  try
    bIsConst    := False;
    bDummy      := False;
    bIsStatic   := False;
    Scan;
    if Token = TOK_IDENTIFIER then
      CheckForTypedef(bIsConst, bIsStatic, bDummy);
    while (Token in [TOK_DIRECTIVE, TOK_CONST, TOK_STATIC,
      TOK_TYPEDEF, TOK_STRUCT, TOK_ENUM,
      TOK_USERDEFINEDTYPE, TOK_LONGDEF]) and not endofallsource do
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
        TOK_STATIC : begin
          Next;
          Scan;
          bIsStatic := True;
        end;
        TOK_TYPEDEF : begin
          ProcessTypedef;
        end;
        TOK_ENUM : begin
          ProcessEnum(False);
        end;
        TOK_STRUCT : begin
          ProcessStruct(False);
        end;
        TOK_USERDEFINEDTYPE, TOK_LONGDEF : begin
          tname := Value;
          dt := Token;
          AllocLocal(sub, tname, GetVariableType(dt), bIsConst, bIsStatic);
          while Token = TOK_COMMA do
            AllocLocal(sub, tname, GetVariableType(dt), bIsConst, bIsStatic);
          Semi;
          Scan;
          bIsConst  := False;
          bIsStatic := False;
        end;
      else
        Expected(sValidProgBlock);
      end;
      if Token = TOK_IDENTIFIER then
        CheckForTypedef(bIsConst, bIsStatic, bDummy);
    end;
  finally
    fNoCommaOperator := False;
  end;
end;

const
  HASPROTO = 2;
  HASNOPROTO = 3;

function TEVCComp.FormalList(protoexists : boolean; var procname : string) : integer;
var
  protocount : integer;
  pltype : integer;
  pcount : integer;
  ptype : char;
  varnam : string;
  bIsArray, bIsConst, bIsRef, bError, bIsStatic : boolean;
  bHasDefault, bRequireDefaults : boolean;
  aval, tname, defValue : string;
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
        FunctionParameterIsConstant(procname, pcount),
        FunctionParameterHasDefault(procname, pcount),
        FunctionParameterIsReference(procname, pcount),
        FunctionParameterDefaultValue(procname, pcount));
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
      AddParam(ApplyDecoration(procname, varnam, 0), ptype, tname, bIsConst, bHasDefault, bIsRef, defValue);
      if not protoexists then
      begin
        Allocate(ApplyDecoration(procname, varnam, 0), aval, '', tname, ptype, 1);
        AddFunctionParameter(procname, varnam, tname, pcount, ptype, bIsConst,
          bIsRef, bIsArray, dimensions, bHasDefault, defValue);
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
  var
    bInline : boolean;
  begin
    bIsArray    := False;
    bIsConst    := False;
    bIsRef      := False;
    bIsStatic   := False;
    ptype       := #0;
    if Token = TOK_CONST then begin
      bIsConst := True;
      Next;
      Scan;
      if bFirstParam then pltype := 1;
    end;
// new code starts here
    tname := Value;
    Value := tname;
    CheckForTypedef(bIsConst, bIsStatic, bInline);
    // re-assign type name variable in case CheckForTypedef changed it.
    tname := Value;
    ptype := Token;
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
      ptype := GetVariableType(ptype);
      if ptype = #0 then
        bError := True;
      CheckForValidDataType(ptype);
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

  procedure CheckForDefaultArgumentValue;
  begin
    bHasDefault := False;
    defValue    := '';
    // check for optional equal sign
    if Token = '=' then
    begin
      bHasDefault := True;
      Next;
      defValue := Value;
      if defValue = '-' then
      begin
        Next;
        defValue := defValue + Value;
      end;
      Next;
    end;
    if bRequireDefaults and not bHasDefault then
    begin
      AbortMsg(sDefaultParamError);
      bError := True;
    end;
    if bHasDefault then
      bRequireDefaults := True;
  end;
begin
  bRequireDefaults := False;
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
    // check for optional = and default value
    CheckForDefaultArgumentValue;
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
      // check for optional = and default value
      CheckForDefaultArgumentValue;
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

procedure TEVCComp.ProcedureBlock;
var
  Name : string;
  protoexists, bIsSub, bInline : boolean;
  savedToken : char;
begin
  while Token in [TOK_INLINE, TOK_PROCEDURE, TOK_TASK] do
  begin
    bInline := False;
    if Token = TOK_INLINE then
    begin
      Next;
      IncrementInlineDepth;
      bInline := True;
    end;
    bIsSub := Token = TOK_PROCEDURE;
    if AmInlining and not bIsSub then
      AbortMsg(sInlineInvalid);
    savedToken := Token;
    Next;
    Scan;
    CheckIdent;
    Name := Value;
    DoCompilerStatusChange(Format(sXXXProcedure, ['EVC', Name]));
    if bIsSub and (Name = 'main') then
      AbortMsg(sMainMustBeTask);
    protoexists := False;
    Next;

    DoCommonFuncProcDecl(protoexists, Name, '', savedToken, #0, AmInlining, False);

    if Token = TOK_BEGIN then
    begin
      Prolog(Name, bIsSub);
      MatchString(TOK_BEGIN);
      if Name = 'main' then
      begin
        InitializeGlobalArrays;
      end;
      ClearLocals;
      fNestingLevel := 0;
      DoLocals(Name);
      BlockStatements();
      Epilog(bIsSub);
      // MatchString(TOK_END) must be after the epilog or process directives
      // can be called while still inlining
      MatchString(TOK_END);
      Scan;
    end
    else
    begin
      // if "inline" is used on a function prototype make sure we do not
      // forget to decrement the inline depth which we incremented above.
      if bInline then
        DecrementInlineDepth;
      if protoexists then
        Expected(sProtoAlreadyDefined);
      Scan;
    end;
    ClearParams;
    TopDecls;
  end;
end;

procedure TEVCComp.DoCommonFuncProcDecl(var bProtoExists : boolean;
  var Name : string; const tname : string;
  const tok, dt: char;  bInline, bPointer : boolean);
var
  procexists : integer;
  pltype : integer;
  bIsSub : boolean;
begin
  bIsSub := tok = TOK_PROCEDURE;

// TODO: move this code after the processing of the formal list of parameters
// so that we can decorate the function name before checking for duplicates

  procexists := GlobalIdx(Name);
  if procexists <> 0 then begin
    if not (GS_Type[procexists] in [TOK_PROCEDURE, TOK_TASK]) then
      Duplicate(Name);
    if GS_Size[procexists] = 0 then
      bProtoExists := True
    else
      Duplicate(Name);
  end
  else begin
    AddEntry(Name, tok, tname, '', False, bPointer);
    GS_ReturnType[NumGlobals] := dt;
    if (dt <> #0) and (IsArrayType(dt) or IsUDT(dt)) then
      AddEntry(Format('__result_%s', [Name]), dt, tname, '', False, bPointer);
  end;

  OpenParen;
  if bIsSub then
    pltype := FormalList(bProtoExists, Name)
  else begin
    pltype := 0;
    // allow for the possibility that tasks have (void) args
    if Value = 'void' then
      Next;
  end;
  CloseParen;

  fCurrentThreadName := Name;
  fThreadNames.Add(Name);

  // allow for "stuff" after the close parenthesis and before either ; or {
  Scan;
  ProcessDirectives; // just in case there are any in between the ) and the {
  // now it has to either be a ; or a {
  if not (Token in [TOK_SEMICOLON, TOK_BEGIN]) then
    AbortMsg(sInvalidFuncDecl);
  if Token = TOK_SEMICOLON then
  begin
    // this is a function declaration (a prototype) - not a function definition
    pltype := 1;
    Next;
  end;
  if Token = TOK_BEGIN then
  begin
    if pltype = 1 then
      AbortMsg(sNotValidForPrototype);
    if bProtoExists then
      GS_Size[procexists] := 1
    else
      GS_Size[NumGlobals] := 1;
  end;
end;

procedure TEVCComp.FunctionBlock(Name, tname : string; dt: char; bInline, bPointer : boolean);
var
  protoexists : boolean;
begin
  DoCompilerStatusChange(Format(sXXXFunction, ['EVC', Name]));
  if bInline then
    IncrementInlineDepth;
  if Name = 'main' then
    AbortMsg(sMainMustBeTask);
  protoexists := False;
  DoCommonFuncProcDecl(protoexists, Name, tname, TOK_PROCEDURE, dt, bInline, bPointer);
  if Token = TOK_BEGIN then
  begin
    Prolog(Name, True);
    MatchString(TOK_BEGIN);
    ClearLocals;
    fNestingLevel := 0;
    DoLocals(Name);
    BlockStatements();
    Epilog(True);
    // MatchString(TOK_END) must be after the epilog or process directives
    // can be called while still inlining
    MatchString(TOK_END);
    Scan;
  end
  else
  begin
    // if "inline" is used on a function prototype make sure we do not
    // forget to decrement the inline depth which we incremented above.
    if bInline then
      DecrementInlineDepth;
    if protoexists then
      Expected(sProtoAlreadyDefined);
    Scan;
  end;
  ClearParams;
end;

procedure TEVCComp.Init;
begin
  fNoCommaOperator := False;
  fProcessingMathAssignment := False;
  fInlineDepth := 0;
  fLastExpressionOptimizedToConst := False;
  fLastLoadedConst := '';
  fCurrentLine := '';
  totallines := 1;
  linenumber := 1;
  ClearParams;
  fStackDepth   := 0;
  MaxStackDepth := 0;
  fAutoStart := False;
  LCount := 0;
  GetChar;
  Next;
end;

procedure TEVCComp.Prog;
begin
  Header;
  TopDecls;
  if Token in [TOK_INLINE, TOK_PROCEDURE, TOK_TASK] then
    ProcedureBlock;
  Trailer;
end;

constructor TEVCComp.Create;
begin
  inherited Create;
  fMaxPreprocDepth := 10;
  fMaxErrors := 0;
  NumGlobals := 0;
  endofallsource := False;
  fEnhancedFirmware := False;
  fFirmwareVersion  := 128; // 1.28 NXT 2.0 firmware
  fIgnoreSystemFile := False;
  fWarningsOff      := False;
  fDD := TDataDefs.Create;
  fNamedTypes := TMapList.Create;
  fNamedTypes.CaseSensitive := True;
  fNamedTypes.Duplicates := dupError;
  fDefines := TStringList.Create;
  fEmittedLocals := TStringList.Create;
  fEmittedLocals.CaseSensitive := True;
  fEmittedLocals.Sorted := True;
  fLocals := TVariableList.Create;
  fParams := TVariableList.Create;
  fGlobals := TVariableList.Create;
  fFuncParams := TFunctionParameters.Create;
  fInlineFunctions := TInlineFunctions.Create;
  fTmpAsmLines := TStringList.Create;
  fStackVarNames := TStringList.Create;
  fASM := TStringList.Create;
  fArrayHelpers := TArrayHelperVars.Create;
  fArrayHelpers.OnAcquireReleaseHelper := HandleAcquireReleaseHelper;
  fMS := TMemoryStream.Create;
  fMessages := TStringList.Create;
  fIncludeDirs := TStringList.Create;
  fAPIFunctions := TStringList.Create;
  fAPIFunctions.CaseSensitive := True;
  fAPIFunctions.Sorted := True;
  fThreadNames := TStringList.Create;
  fThreadNames.CaseSensitive := True;
  fThreadNames.Sorted := True;
  fThreadNames.Duplicates := dupIgnore;
  fSwitchFixups := TStringList.Create;
  fSwitchRegNames := TStringList.Create;
  fSwitchDepth := 0;
  fFunctionNameCallStack := TStringList.Create;
  fFunctionNameCallStack.CaseSensitive := True;
  fArrayIndexStack := TStringList.Create;
  fInlineStack := TObjectList.Create(false);
  fCalc := TCCExpParser.Create(nil);
  fCalc.PascalNumberformat := False;
  fCalc.CaseSensitive := True;
  fSProProgram := TSProProgram.Create;
  fSizeMap := TSizeMap.Create;
  LoadAPIFunctions;
  fOptimizeLevel := 0;
  Clear;
end;

destructor TEVCComp.Destroy;
begin
  FreeAndNil(fDD);
  FreeAndNil(fNamedTypes);
  FreeAndNil(fDefines);
  FreeAndNil(fEmittedLocals);
  FreeAndNil(fLocals);
  FreeAndNil(fParams);
  FreeAndNil(fGlobals);
  FreeAndNil(fFuncParams);
  FreeAndNil(fInlineFunctions);
  FreeAndNil(fArrayHelpers);
  FreeAndNil(fTmpAsmLines);
  FreeAndNil(fStackVarNames);
  FreeAndNil(fASM);
  FreeAndNil(fMS);
  FreeAndNil(fMessages);
  FreeAndNil(fIncludeDirs);
  FreeAndNil(fAPIFunctions);
  FreeAndNil(fFunctionNameCallStack);
  FreeAndNil(fArrayIndexStack);
  FreeAndNil(fThreadNames);
  FreeAndNil(fSwitchFixups);
  FreeAndNil(fSwitchRegNames);
  FreeAndNil(fInlineStack);
  FreeAndNil(fCalc);
  FreeAndNil(fSProProgram);
  FreeAndNil(fSizeMap);
  inherited;
end;

procedure TEVCComp.SetOnCompilerStatusChange(const Value: TCompilerStatusChangeEvent);
begin
  fOnCompilerStatusChange := Value;
  fSProProgram.OnCompilerStatusChange := Value;
end;

procedure TEVCComp.InternalParseStream;
begin
  try
    DoCompilerStatusChange(Format(sXXXCompBegin, ['EVC']));
    DoCompilerStatusChange(Format(sCompileTargets, [FirmwareVersion, BoolToString(EnhancedFirmware)]));
    fFuncParams.Clear;
    fThreadNames.Clear;
    fGlobals.Clear;
    fBadProgram     := False;
    fBytesRead      := 0;
    fProgErrorCount := 0;
    fLastErrLine    := -99;
    fLastErrMsg     := '';
    fLHSDataType    := #0;
    fLHSName        := '';
    DoCompilerStatusChange(Format(sXXXPreprocess, ['EVC']));
    PreProcess;
    fMS.Position := 0;
    fParenDepth  := 0;
    DoCompilerStatusChange(Format(sXXXInitProgram, ['EVC']));
    Init;
    DoCompilerStatusChange(Format(sXXXParseProg, ['EVC']));
    Prog;
    DoCompilerStatusChange(Format(sXXXCodeGenComplete, ['EVC']));
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

procedure TEVCComp.Parse(aStrings: TStrings);
var
  Stream : TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    aStrings.SaveToStream(Stream);
    Parse(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TEVCComp.Parse(aStream: TStream);
begin
  Clear;
  LoadSourceStream(aStream, fMS);
  InternalParseStream;
end;

procedure TEVCComp.Parse(const aFilename: string);
var
  Stream : TFileStream;
begin
  Stream := TFileStream.Create(aFilename, fmOpenRead or fmShareDenyWrite);
  try
    Parse(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TEVCComp.ParseASM(aStrings: TStrings);
begin
  Clear;
  fSProProgram.LoadFromStrings(aStrings);
end;

procedure TEVCComp.ParseASM(aStream: TStream);
var
  SL : TStringList;
begin
  SL := TStringList.Create;
  try
    SL.LoadFromStream(aStream);
    ParseASM(SL);
  finally
    SL.Free;
  end;
end;

procedure TEVCComp.ParseASM(const aFilename: string);
var
  SL : TStringList;
begin
  SL := TStringList.Create;
  try
    SL.LoadFromFile(aFilename);
    ParseASM(SL);
  finally
    SL.Free;
  end;
end;

procedure TEVCComp.Clear;
begin
  fSProProgram.Clear;
  fMS.Clear;
  SourceClear;
  fInlineFunctions.Clear;
  fArrayHelpers.Clear;
  fMessages.Clear;
  fTempChar    := ' ';
  fLHSDataType := #0;
  fLHSName     := '';
  LCount       := 0;
  ClearLocals;
  ClearParams;
  ClearGlobals;
end;

procedure TEVCComp.DoBreakContinue(idx : integer; const lbl: string);
var
  val : string;
begin
  val := APIList[idx];
  MatchString(val);
  if lbl <> '' then
    Branch(lbl)
  else
    AbortMsg(Format(sInvalidBreakContinue, [val]));
end;

procedure TEVCComp.DoExitTo;
var
  val : string;
begin
  // ExitTo(task);
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
  ExitToProcess(val);
end;

procedure TEVCComp.DoStop;
begin
  // Stop(stop?);
  Next;
  OpenParen;
  // stop?
  BoolExpression;
  CloseParen;
  StopAllProcesses(RegisterName);
end;

procedure TEVCComp.DoGoto;
begin
  // goto labelName;
  Next;
  // labelName
  CheckIdent;
  Branch(Value);
  Next;
end;

procedure TEVCComp.DoReturn;
var
  rdt : char;
  idx : integer;
  bFuncStyle : boolean;
begin
  // return
  idx := GlobalIdx(fCurrentThreadName);
  if GS_Type[idx] <> TOK_PROCEDURE then
    AbortMsg(sReturnInvalid);
  rdt := FunctionReturnType(fCurrentThreadName);
  Next;
  // leave return value on "stack"
  if IsUDT(rdt) or IsArrayType(rdt) then
  begin
    // currently this code only supports returning a variable for UDTs or Arrays
    // TODO : add support for an array or UDT expression
    bFuncStyle := Token = TOK_OPENPAREN;
    if bFuncStyle then
      Next;
    fLHSDataType := rdt;
    fLHSName := Format('__result_%s',[fCurrentThreadName]);
    try
      NumericFactor;
    finally
      fLHSDataType := TOK_LONGDEF;
      fLHSName := '';
    end;
    if bFuncStyle then
      Next;
  end
  else if rdt <> #0 then
  begin
    CommaExpression;
  end;
  ReturnFromRoutine;
end;

procedure TEVCComp.TraceCharAsString(const aValue : string);
var
  i : integer;
begin
  i := StrToIntDef(aValue, -1);
  if i = -1 then
    AbortMsg('Invalid character literal');
  if i = 13 then
    TraceCarriageReturn
  else if i = 10 then
    TraceNewLine
  else if i > 32 then
    TraceChar(Char(i))
  else
    TraceSpace;
end;

procedure TEVCComp.TraceStringWithEscapes(tmp : string);
var
  t2 : string;
  i : integer;
  ch : char;
begin
  i := Pos('\', tmp);
  while i > 0 do
  begin
    t2 := Copy(tmp, 1, i-1);
    System.Delete(tmp, 1, i); // delete up to and including '\'
    if t2 <> '' then
      TraceString(t2);
    // get the next character
    t2 := Copy(tmp, 1, 1);
    ch := t2[1];
    System.Delete(tmp, 1, 1);
    i := Pos(ch, 'nr''"\?');
    case i of
      1 : TraceNewLine; // new line
      2 : TraceCarriageReturn; // carriage return
      3..6 : TraceChar(ch);
    else
      // whitespace
      TraceSpace;
    end;
    // check for another escape
    i := Pos('\', tmp);
  end;
  if tmp <> '' then
    TraceString(tmp);
end;

procedure TEVCComp.DoCloseLog;
begin
  // x = close();
  OpenParen;
  CloseParen;
  CloseLog;
end;

procedure TEVCComp.DoLogStatus;
begin
  // x = stat();
  OpenParen;
  CloseParen;
  LogStatus;
end;

procedure TEVCComp.DoOpenLog;
begin
  // x = open(mode);
  OpenParen;
  CheckStringConst;
  if Value = '''r''' then
    OpenLogForRead
  else if Value = '''w''' then
    OpenLogForWrite
  else
    AbortMsg('Invalid open mode');
  Next;
  CloseParen;
end;

procedure TEVCComp.DoPop;
begin
  // var = pop();
  OpenParen;
  CloseParen;
  PopVar(RegisterName);
end;

procedure TEVCComp.DoPush;
begin
  // x = push(int var);
  OpenParen;
  BoolExpression;
  CloseParen;
  PushVar(RegisterName);
end;

procedure TEVCComp.DoPutChar;
begin
  // x = putchar(const char ch);
  OpenParen;
  CheckNumeric;
  TraceCharAsString(Value);
  LoadConst(Value);
  Next;
  CloseParen;
end;

procedure TEVCComp.DoPutString;
begin
  // x = puts(const char * s);
  OpenParen;
  CheckStringConst;
  TraceStringWithEscapes(StripQuotes(Value));
  SetToTrue(RegisterName);
  Next;
  CloseParen;
end;

procedure TEVCComp.DoReadFromLog;
begin
  // var = read();
  OpenParen;
  CloseParen;
  ReadVar(RegisterName);
end;

procedure TEVCComp.DoWriteToLog;
begin
  // x = write(int var);
  OpenParen;
  BoolExpression;
  CloseParen;
  WriteVar(RegisterName);
end;

procedure TEVCComp.DoRunProgram;
var
  i : integer;
begin
  // run(const char slot);
  Next;
  OpenParen;
  CheckNumeric;
  i := StrToIntDef(Value, -1);
  if (i >= 0) and (i <= 6) then
    RunProgram(i)
  else
    AbortMsg('Invalid program slot number');
  Next;
  CloseParen;
end;

procedure TEVCComp.DoSquareRoot;
begin
  // x = sqrt(int value);
  OpenParen;
  BoolExpression;
  CloseParen;
  SquareRoot(RegisterName);
end;

procedure TEVCComp.DoAbs;
begin
  // x = abs(int value);
  OpenParen;
  BoolExpression;
  CloseParen;
  AbsoluteValue;
end;

procedure TEVCComp.DoSign;
begin
  // x = sign(int value);
  OpenParen;
  BoolExpression;
  CloseParen;
  SignValue;
end;

procedure TEVCComp.DoSizeOf;
var
  tmp : string;
begin
  // x = SizeOf(variant & value);
  OpenParen;
  CheckIdent;
  tmp := GetDecoratedIdent(Value);
  Next;
  CloseParen;
  SizeOfValue(tmp);
end;

function TEVCComp.CalculatedSize(const aName: string): integer;
//var
//  dt : Char;
begin
  Result := fSizeMap.Size[aName];
(*
  Result := 1; // most things have sizeof == 1
  dt := DataType(aName);
  if IsUDT(dt) then
  begin
    Result := UDTSize(GetUDTType(aName));
  end
  else if IsArrayType(dt) then
  begin
  end
  else
    Result := 1;
*)
end;

procedure TEVCComp.DoRotate(const idx: integer);
var
  tmp : string;
begin
  // RotateLeft(int & var);
  // RotateRight(int & var);
  Next;
  OpenParen;
  CheckIdent;
  tmp := GetDecoratedIdent(Value);
  Next;
  CloseParen;
  Rotate(idx = API_ROTRIGHT, tmp);
end;

procedure TEVCComp.DoStopProcesses;
begin
  // StopProcesses();
  Next;
  OpenParen;
  CloseParen;
  HaltEx;
end;

procedure TEVCComp.DoWait;
begin
  // Wait(int ms);
  Next;
  OpenParen;
  BoolExpression;
  CloseParen;
  WaitMS(RegisterName);
end;

procedure TEVCComp.DoPrintf;
var
  fmt, tmp, t2 : string;
  i : integer;
begin
  // x = printf(const char * fmt, ...);
  OpenParen;
  // first param must be string literal
  CheckStringConst;
  fmt := StripQuotes(Value);
  Next;
  // the presence of % in the format string controls the number
  // of subsequent parameters
  // variable number of parameters of various types
  i := Pos('%', fmt);
  while (i > 0) and (Token <> TOK_CLOSEPAREN) do
  begin
    tmp := Copy(fmt, 1, i-1);
    System.Delete(fmt, 1, i); // delete through %
    TraceStringWithEscapes(tmp);
    // skip past the ocmma
    MatchString(TOK_COMMA);
    // process the format string
    t2 := Copy(fmt, 1, 1);
    System.Delete(fmt, 1, 1);
    // t2 should be == s, d, x, X, c
    if t2 = 's' then
    begin
      // get a string literal
      CheckStringConst;
      TraceStringWithEscapes(StripQuotes(Value));
      Next;
    end
    else if t2[1] in ['d', 'x', 'X'] then
    begin
      // get a signed integer
      BoolExpression;
      TraceVar(t2 = 'd', RegisterName);
    end
    else if t2 = 'c' then
    begin
      // get a character literal
      CheckNumeric;
      TraceCharAsString(Value);
      Next;
    end
    else
    begin
      AbortMsg('Unsupported or invalid printf format string');
    end;
    i := Pos('%', fmt);
  end;
  if fmt <> '' then
    TraceStringWithEscapes(fmt);
  CloseParen;
  SetToTrue(RegisterName);
end;

procedure TEVCComp.PreProcess;
var
  P : TLangPreprocessor;
  i, idx : integer;
  tmpFile, tmpMsg : string;
begin
  P := TLangPreprocessor.Create(GetPreProcLexerClass, ExtractFilePath(ParamStr(0)), lnEVC, MaxPreprocessorDepth, fCalc);
  try
    P.OnPreprocessorStatusChange := HandlePreprocStatusChange;
    P.AddPoundLineToMultiLineMacros := True;
    P.Defines.AddDefines(Defines);
    if EnhancedFirmware then
      P.Defines.Define('__ENHANCED_FIRMWARE');
    P.Defines.AddEntry('__FIRMWARE_VERSION', IntToStr(FirmwareVersion));
    P.AddIncludeDirs(IncludeDirs);
    if not IgnoreSystemFile then
    begin
      P.SkipIncludeFile('spmem.h');
      P.SkipIncludeFile('EVCDefs.h');
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

procedure TEVCComp.ProcessDirectives(bScan : boolean);
begin
  while Token = TOK_DIRECTIVE do
  begin
    // look for #line statements
    SkipDirectiveLine;
    if Pos('#line', fDirLine) = 1 then
    begin
      HandlePoundLine;
    end
    else if Pos('#pragma', fDirLine) = 1 then
    begin
      HandlePoundPragma;
    end
    else if Pos('#reset', fDirLine) = 1 then
    begin
      HandlePoundReset;
    end;
    Next(False);
    OutputDirective(fDirLine);
    if bScan then
      Scan;
  end;
end;

procedure TEVCComp.HandlePoundLine;
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
    tmpFile     := Replace(tmpLine, '"', '');
    fOldCurFile := CurrentFile;
    CurrentFile := tmpFile;
  end;
end;

procedure TEVCComp.HandlePoundPragma;
var
  i : integer;
  tmpLine : string;
begin
  i := Pos('#pragma ', fDirLine);
  if i = 1 then
  begin
    // this is a special preprocessor line
    tmpLine := fDirLine;
    Delete(tmpLine, 1, 8);
    // 'autostart'
    if tmpLine = 'autostart' then
      fAutoStart := True;
  end;
end;

procedure TEVCComp.HandlePoundReset;
var
  i : integer;
begin
  i := Pos('#reset', fDirLine);
  if i = 1 then
  begin
    CurrentFile := fOldCurFile;
  end;
end;

procedure TEVCComp.IncLineNumber;
begin
  linenumber := linenumber + 1;
  inc(totallines);
end;

function TEVCComp.APIFuncNameToID(procname: string): integer;
begin
  Result := StrToIntDef(fAPIFunctions.Values[procname], -1);
end;

function TEVCComp.IsAPIFunc(procname: string): boolean;
begin
  Result := fAPIFunctions.IndexOfName(procname) <> -1;
end;

procedure TEVCComp.AddAPIFunction(const name: string; id: integer);
begin
  fAPIFunctions.Add(name + '=' + IntToStr(id));
end;

function TEVCComp.tos : string;
begin
  Result := fStackVarNames[fStackVarNames.Count - 1];
end;

function TEVCComp.TempSignedLongName: string;
begin
  Result := Format('__tmpslong%s', [fCurrentThreadName]);
end;

function TEVCComp.RegisterName(name : string): string;
begin
  if fUDTOnStack <> '' then
  begin
    Result := fUDTOnStack;
    fUDTOnStack := ''; // once it has been used it is removed from the stack
  end
  else
  begin
    if name = '' then
      name := fCurrentThreadName;
    Result := Format('__D0%s',[name]);
  end;
end;

//function TEVCComp.ZeroFlag: string;
//begin
//  Result := Format('__zf%s', [fCurrentThreadName]);
//end;

const
  APIF_ASM      = 0;
  APIF_OPEN     = 1;
  APIF_CLOSE    = 2;
  APIF_WRITE    = 3;
  APIF_READ     = 4;
  APIF_STAT     = 5;
  APIF_PUSH     = 6;
  APIF_POP      = 7;
  APIF_SQRT     = 8;
  APIF_PUTCHAR  = 9;
  APIF_PUTS     = 10;
  APIF_PRINTF   = 11;
  APIF_ABS      = 12;
  APIF_SIGN     = 13;
  APIF_SIZEOF   = 14;

procedure TEVCComp.DoCallAPIFunc(procname: string);
var
  id : integer;
  dt : char;
begin
  id := APIFuncNameToID(procname);
  case id of
    APIF_ASM : begin
      dt := #0;
      DoAsm(dt);
      fSemiColonRequired := True;
    end;
    APIF_OPEN    : DoOpenLog;
    APIF_CLOSE   : DoCloseLog;
    APIF_WRITE   : DoWriteToLog;
    APIF_READ    : DoReadFromLog;
    APIF_STAT    : DoLogStatus;
    APIF_PUSH    : DoPush;
    APIF_POP     : DoPop;
    APIF_SQRT    : DoSquareRoot;
    APIF_PUTCHAR : DoPutChar;
    APIF_PUTS    : DoPutString;
    APIF_PRINTF  : DoPrintf;
    APIF_ABS     : DoAbs;
    APIF_SIGN    : DoSign;
    APIF_SIZEOF  : DoSizeOf;
  else
    AbortMsg(Format(sNotAnAPIFunc, [procname]));
  end;
end;

procedure TEVCComp.LoadAPIFunctions;
begin
  AddAPIFunction('asm', APIF_ASM);
  AddAPIFunction('open', APIF_OPEN);
  AddAPIFunction('close', APIF_CLOSE);
  AddAPIFunction('write', APIF_WRITE);
  AddAPIFunction('read', APIF_READ);
  AddAPIFunction('stat', APIF_STAT);
  AddAPIFunction('push', APIF_PUSH);
  AddAPIFunction('pop', APIF_POP);
  AddAPIFunction('sqrt', APIF_SQRT);
  AddAPIFunction('putchar', APIF_PUTCHAR);
  AddAPIFunction('puts', APIF_PUTS);
  AddAPIFunction('printf', APIF_PRINTF);
  AddAPIFunction('abs', APIF_ABS);
  AddAPIFunction('sign', APIF_SIGN);
  AddAPIFunction('SizeOf', APIF_SIZEOF);
end;

function TEVCComp.GetASMSrc: TStrings;
begin
  if AmInlining and Assigned(fCurrentInlineFunction) then
    Result := fCurrentInlineFunction.Code
  else
    Result := fASM;
end;

procedure TEVCComp.SetDefines(const Value: TStrings);
begin
  fDefines.Assign(Value);
end;

procedure TEVCComp.CheckTypeCompatibility(fp: TFunctionParameter; dt: char; const name : string);
var
  expectedBase, providedBase : char;
begin
  if GetArrayDimension(fp.ParameterDataType) <> GetArrayDimension(dt) then
    AbortMsg(sDatatypesNotCompatible)
  else
  begin
    expectedBase := ArrayBaseType(fp.ParameterDataType);
    providedBase := ArrayBaseType(dt);
    if (expectedBase in NonAggregateTypes) then
    begin
      if not (providedBase in NonAggregateTypes) then
        Expected(sNumericType)
      else begin
        // if parameter type name is a named type then type names must match
        if (fNamedTypes.IndexOf(fp.ParamTypeName) <> -1) and
           (fp.ParamTypeName <> DataTypeName(name)) then
          AbortMsg(sUDTNotEqual);
      end;
    end
    else if expectedBase = TOK_USERDEFINEDTYPE then
    begin
      if providedBase <> TOK_USERDEFINEDTYPE then
        Expected(sStructType)
      else begin
        // struct types must be the same
        if fp.ParamTypeName <> GetUDTType(name) then
          AbortMsg(sUDTNotEqual);
      end;
    end;
  end;
end;

procedure TEVCComp.CheckNotConstant(const aName: string);
begin
  // is this thing constant?
  if (IsParam(aName) and IsParamConst(aName)) or
     (IsLocal(aName) and IsLocalConst(aName)) or
     (IsGlobal(aName) and IsGlobalConst(aName)) then
    AbortMsg(sConstNotAllowed);
end;

function TEVCComp.IsCharLiteral(const aName: string) : boolean;
begin
  Result := (Pos('''', aName) = 1) and (LastDelimiter('''', aName) = Length(aName));
end;

function TEVCComp.CheckConstant(const aName: string) : string;
var
  bIsConst : boolean;
  idx : integer;
  V : TVariable;
begin
  // is this thing constant?
  Result := aName;
  if IsParam(aName) then
  begin
    bIsConst := IsParamConst(aName);
  end
  else if IsLocal(aName) then
  begin
    idx := LocalIdx(aName);
    if idx <> -1 then
    begin
      V := fLocals[idx];
      bIsConst := V.IsConstant;
      if bIsConst then
        Result := V.Value;
    end
    else
      bIsConst := False;
  end
  else if IsGlobal(aName) then
  begin
    idx := fGlobals.IndexOfName(aName);
    if idx <> -1 then
    begin
      V := fGlobals[idx];
      bIsConst := V.IsConstant;
      if bIsConst then
        Result := V.Value;
    end
    else
      bIsConst := False;
  end
  else if IsCharLiteral(aName) then
  begin
    bIsConst := True;
  end
  else
  begin
    // perhaps it is a constant expression that can be evaluated?
    fCalc.SilentExpression := aName;
    bIsConst := not fCalc.ParserError;
    if bIsConst then
      Result := CCFloatToStr(Trunc(fCalc.Value));
  end;
  if not bIsConst then
    AbortMsg(sConstRequired);
end;

function TEVCComp.IsPointer(const aName : string) : boolean;
begin
  // is this thing a pointer?
  if IsParam(aName) then
  begin
    Result := IsParamPointer(aName);
  end
  else if IsLocal(aName) then
  begin
    Result := IsLocalPointer(aName);
  end
  else if IsGlobal(aName) then
  begin
    Result := IsGlobalPointer(aName);
  end
  else
    Result := False;
end;

procedure TEVCComp.CheckPointer(const aName: string);
begin
  if not IsPointer(aName) then
    AbortMsg(sPointerRequired);
end;

function TEVCComp.IncrementOrDecrement: boolean;
begin
  Result := ((Token = '+') and (Look = '+')) or
            ((Token = '-') and (Look = '-'));
end;

procedure TEVCComp.DoPreIncOrDec(bPutOnStack : boolean);
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
    StorePreInc(Value)
  else
    StorePreDec(Value);
  if bPutOnStack then
    CheckAndLoadVar(Value);
  Next;
end;

function TEVCComp.GetPreProcLexerClass: TGenLexerClass;
begin
  Result := TEVCLexer;
end;

procedure TEVCComp.AddTypeNameAlias(const lbl, args: string);
begin
  // add a named type alias
  if fNamedTypes.IndexOf(lbl) = -1 then
    fNamedTypes.AddEntry(lbl, args)
  else
    Duplicate(lbl);
end;

function TEVCComp.TranslateTypeName(const name: string): string;
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

procedure TEVCComp.ProcessEnum(bGlobal : boolean);
var
  bNewType : boolean;
  sTypeName, varName, eName : string;
  iEnumVal, idx : integer;
  dt : Char;
  V : TVariable;
begin
  // enums in EVC are unsigned bytes by default
  dt        := TOK_LONGDEF;
  iEnumVal  := 0;
  bNewType  := False;
  sTypeName := '';
  // enum [tag] { enumerators } [declarator];
  // eat until semi-colon
  Next;
  Scan; // skip past the "enum" keyword
  // optional type name
  if Token = TOK_IDENTIFIER then
  begin
    bNewType := True;
    sTypeName := Value;
    Next;
    Scan;
  end;
  MatchString(TOK_BEGIN);
  Scan;
  // process enumerators
  while Token <> TOK_END do begin
    // name [= val] ,
    CheckIdent;
    eName := Value;
    Next;
    if Token = '=' then begin
      Next; // skip past the equal sign to the value
      CheckNumeric;
      iEnumVal := StrToIntDef(Value, 0);
      Next; // skip past the value to comma or }
    end;
//    EVC only has one integer type (signed long)
//    dt := ValueToDataType(iEnumVal);
    V := nil;
    if bGlobal then
    begin
      idx := AddEntry(eName, dt, sTypeName, '', True);
      if idx <> -1 then
        V := fGlobals[idx];
      Allocate(eName, '', IntToStr(iEnumVal), sTypeName, dt, 1);
    end
    else
    begin
      eName := ApplyDecoration(fCurrentThreadName, eName, fNestingLevel);
      idx := AddLocal(eName, dt, sTypeName, True, '', False);
      if idx <> -1 then
        V := fLocals[idx];
      // no need to allocate if we've already emitted this name&type
      if fEmittedLocals.IndexOf(eName+sTypeName) = -1 then
        Allocate(eName, '', IntToStr(iEnumVal), sTypeName, dt, 1);
    end;
    if Assigned(V) then
      V.Value := IntToStr(iEnumVal);
    inc(iEnumVal);
    if Token <> TOK_END then
    begin
      Next;
      Scan;
    end;
  end;
  // should be at TOK_END
  MatchString(TOK_END);
  if bNewType then
    AddTypeNameAlias(sTypeName, DataTypeToTypeName(dt));
  // optional type name
  if Token = TOK_IDENTIFIER then
  begin
    // declare a variable of this type (only valid if bNewType is true
    if not bNewType then
      AbortMsg(sInvalidEnumDecl);
    varName := Value;
    if bGlobal then
    begin
      AddEntry(varName, dt, sTypeName, '', False);
      Allocate(varName, '', '', sTypeName, dt, 1);
    end
    else
    begin
      varName := ApplyDecoration(fCurrentThreadName, varName, fNestingLevel);
      AddLocal(varName, dt, sTypeName, False, '', False);
      // no need to allocate if we've already emitted this name&type
      if fEmittedLocals.IndexOf(varName+sTypeName) = -1 then
        Allocate(varName, '', '', sTypeName, dt, 1);
    end;
    Next;
    Scan; // move past identifier
  end;
  Semi; // required semicolon
  Scan;
end;

procedure TEVCComp.ProcessTypedef;
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

procedure TEVCComp.ProcessStruct(bTypeDef : boolean);
var
  sname, mtype, aval, mname, mtypename, tmp : string;
  DE : TDataspaceEntry;
  dt : TDSType;
  procedure AddMemberToCurrentStructure;
  var
    i, cnt : integer;
  begin
    // add a member to the current structure definition
    dt := EVCStrToType(mtype, True);
    DE := fCurrentStruct.SubEntries.Add;
    HandleVarDecl(DataDefinitions, fNamedTypes, True, DE, mname, mtype+aval, @EVCStrToType);
    // add default value (0) for each array element if this member
    // is an array
    if tmp <> '' then
    begin
      cnt := CountElements(tmp);
      for i := 0 to cnt - 1 do
        DE.AddValue(0);
    end;
    aval := '';
  end;
begin
  // struct name {...};
  // or
  // struct {...} name; (and bTypeDef is true)
  Next;
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
  if Token = TOK_IDENTIFIER then begin
    // invalid at this location
    Expected(TOK_BEGIN);
    Next;
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
    // make sure we translate typedefs
    mtype := TranslateTypeName(mtypename);
    Next;
    mname := Value;
    Next;
    aval := '';
    while Token <> TOK_SEMICOLON do begin
      if Token = '[' then begin
        aval := ProcessArrayDimensions(tmp);
      end;
      if Token = ',' then begin
        AddMemberToCurrentStructure;
        Next;
        mname := Value;
        Next;
      end;
      if not (Token in [TOK_SEMICOLON, '[', ',']) then
      begin
        AbortMsg(sUnexpectedChar);
        mname := '';
        mtype := '';
        break;
        Next;
      end;
    end;
    if mname <> '' then
    begin
      Semi;
      AddMemberToCurrentStructure;
    end;
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
  Semi; // skip past the ';'
  Scan;
end;

procedure TEVCComp.CheckForTypedef(var bConst, bStatic, bInline : boolean);
var
  i : integer;
  tmpName : string;
begin
  tmpName := TranslateTypeName(Value);
  if Value <> tmpName then
  begin
    Token := TOK_IDENTIFIER;
    Value := tmpName;
    // only need to check if Value
    i := Pos('const ', Value);
    if i > 0 then
    begin
      System.Delete(Value, i, 6);
      bConst := True;
    end;
    i := Pos('static ', Value);
    if i > 0 then
    begin
      System.Delete(Value, i, 7);
      bStatic := True;
    end;
    i := Pos('inline ', Value);
    if i > 0 then
    begin
      System.Delete(Value, i, 7);
      bInline := True;
    end;
    Value := Trim(Value);
  end;
  Scan;
end;

function TEVCComp.IsUserDefinedType(const name: string): boolean;
begin
  Result := DataDefinitions.IndexOfName(name) <> -1;
end;

function TEVCComp.DataTypeOfDataspaceEntry(DE: TDataspaceEntry): char;
var
  dim : integer;
  bt : char;
  tmpDE : TDataspaceEntry;
begin
  Result := #0;
  if not Assigned(DE) then Exit;
  case DE.DataType of
    dsSLong : Result := TOK_LONGDEF;
    dsCluster : Result := TOK_USERDEFINEDTYPE;
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
    end;
  else
    Result := #0;
  end;
end;

procedure TEVCComp.UDTAssignment(const name: string);
begin
  if Token in ['+', '-', '/', '*', '%', '&', '|', '^'] then
  begin
    MathAssignment(name);
  end
  else
  begin
    MatchString('=');
    GetAndStoreUDT(name);
  end;
end;

procedure TEVCComp.GetAndStoreUDT(const name: string);
begin
  NotNumericFactor;
  if fUDTOnStack <> '' then
  begin
    CheckAndStore(name);
    fUDTOnStack := '';
  end;
end;

function TEVCComp.IsReferenceType(n : string) : boolean;
var
  i : integer;
  root_name : string;
  fp : TFunctionParameter;
begin
  Result := False;
  n := StripInline(n);
  case WhatIs(n) of
    stParam : begin
      i := ParamIdx(n);
      if i <> -1 then
      begin
        Result := fParams[i].IsReference;
      end
      else
      begin
        // i = -1
        for i := 0 to fFuncParams.Count - 1 do
        begin
          fp := fFuncParams[i];
          if n = ApplyDecoration(fp.ProcName, fp.Name, 0) then
          begin
            Result := fp.IsReference;
            Break;
          end;
        end;
      end;
    end;
    stLocal : begin
      i := LocalIdx(n);
      if i <> -1 then
      begin
        Result := fLocals[i].IsReference;
      end;
    end;
    stGlobal : begin
      i := fGlobals.IndexOfName(n);
      if i <> -1 then
      begin
        Result := fGlobals[i].IsReference;
      end
      else
      begin
        // maybe this is a member of a struct which might itself be a user defined type
        root_name := RootOf(n);
        if root_name <> n then
        begin
          i := fGlobals.IndexOfName(root_name);
          if (i <> -1) and (ArrayBaseType(fGlobals[i].DataType) = TOK_USERDEFINEDTYPE) then
          begin
            Result := fGlobals[i].IsReference;
          end;
        end;
      end;
    end;
  end;
end;

function TEVCComp.GetUDTType(n: string): string;
var
  i : integer;
  root_type, root_name : string;
  DE : TDataspaceEntry;
  fp : TFunctionParameter;
begin
  Result := '';
  n := StripInline(n);
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
      begin
        // maybe this is a member of a struct which might itself be a user defined type
        root_name := RootOf(n);
        if root_name <> n then
        begin
            root_type := fLocals[i].TypeName;
            System.Delete(n, 1, Length(root_name)+1);
            n := root_type + '.' + n;
            DE := DataDefinitions.FindEntryByFullName(n);
            if Assigned(DE) then
              Result := DE.TypeName;
        end
        else
          Result := fLocals[i].TypeName;
      end;
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

procedure TEVCComp.LoadSourceStream(Src, Dest : TStream);
//var
//  tmp : string;
//  tmpStream : TMemoryStream;
//  bSPMemReplaced, bEVCDefsReplaced : boolean;
begin
//  bSPMemReplaced := False;
//  bEVCDefsReplaced := False;
  // Src is the input source code stream
  // Dest is the output source code stream
(*
  if not IgnoreSystemFile then
  begin
    // look for #include "spmem.h" and #include "EVCDefs.h"
    tmpStream := TMemoryStream.Create;
    try

      if not bSPMemReplaced then
      begin
        // load destination stream with the contents of spmem.h followed by EVCDefs.h
        tmp := '#line 0 "spmem.h"'#13#10;
        tmpStream.Write(PChar(tmp)^, Length(tmp));
        tmpStream.Write(spmem_data, High(spmem_data)+1);
        tmp := '#reset'#13#10;
        tmpStream.Write(PChar(tmp)^, Length(tmp));
      end;
      if not bEVCDefsReplaced then
      begin
        tmp := '#line 0 "EVCDefs.h"'#13#10;
        tmpStream.Write(PChar(tmp)^, Length(tmp));
        tmpStream.Write(spc_defs_data, High(spc_defs_data)+1);
        tmp := '#reset'#13#10;
        tmpStream.Write(PChar(tmp)^, Length(tmp));
      end;
      Dest.CopyFrom(tmpStream, 0);
    finally
      tmpStream.Free;
    end;
  end;
*)
  Dest.CopyFrom(Src, 0);
end;

procedure TEVCComp.CheckSemicolon;
begin
  if fSemiColonRequired then
  begin
    Semi;
    Scan;
  end;
end;

procedure TEVCComp.CloseParen;
begin
  dec(fParenDepth);
  if fParenDepth < 0 then
    AbortMsg(sUnmatchedCloseParen);
  MatchString(TOK_CLOSEPAREN);
end;

procedure TEVCComp.OpenParen;
begin
  MatchString(TOK_OPENPAREN);
  inc(fParenDepth);
end;

procedure TEVCComp.EmitInlineParametersAndLocals(func: TInlineFunction);
var
  i : integer;
  p : TFunctionParameter;
  v : TVariable;
  varname, tname : string;
  dt : char;
  bConst, bPointer : boolean;
begin
  for i := 0 to FunctionParameterCount(func.Name) - 1 do
  begin
    p := GetFunctionParam(func.Name, i);
    if Assigned(p) then
    begin
      varname  := InlineName(fCurrentThreadName, ApplyDecoration(p.ProcName, p.Name, 0));
      tname    := p.ParamTypeName;
      dt       := p.ParameterDataType;
      bConst   := p.IsConstant;
      bPointer := p.IsPointer;
      if AmInlining then
      begin
        // call AddLocal instead
        if not IsLocal(varname) then
          AddLocal(varname, dt, tname, bConst, '', bPointer);
      end
      else
      begin
        // allocate this parameter
        Allocate(varname, DataTypeToArrayDimensions(dt), '', tname, dt, 1);
      end;
    end;
  end;
  for i := 0 to func.LocalVariables.Count - 1 do
  begin
    v := func.LocalVariables[i];
    varname  := InlineName(fCurrentThreadName, v.Name);
    tname    := v.TypeName;
    dt       := v.DataType;
    bConst   := v.IsConstant;
    bPointer := v.IsPointer;
    if AmInlining then
    begin
      // call AddLocal instead
      if not IsLocal(varname) then
        AddLocal(varname, dt, tname, bConst, '', bPointer);
    end
    else
    begin
      // allocate this variable
      // 2011-07-18 Fix for static variables in inline functions not being initialized statically
      Allocate(varname, DataTypeToArrayDimensions(dt), v.Value, tname, dt, 1);
    end;
  end;
end;

function TEVCComp.TypesAreCompatible(lhs, rhs: char): boolean;
var
  lDim, rDim : integer;
  lBase, rBase : Char;
begin
  Result := (lhs = rhs);
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

procedure TEVCComp.DecrementNestingLevel;
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

procedure TEVCComp.CheckEnhancedFirmware;
begin
  if not EnhancedFirmware then
    AbortMsg(sEnhancedFirmwareReqd);
end;

procedure TEVCComp.InitializeGlobalArrays;
begin
  // all this routine does is emit a call to the global array
  // initialization subroutine
  CallRoutine('__initialize_global_data');
end;

function TEVCComp.DoNewArrayIndex(theArrayDT : Char; theArray, aLHSName : string) : boolean;
var
  AHV : TArrayHelperVar;
  tmp, udType, aval, tmpUDTName, oldExpStr, oldBS : string;
  tmpDT : char;
  dim : integer;
begin
  Result := False;
  dim := 0;
  while (dim < 4) and (Token = '[') and IsArrayType(theArrayDT) do
  begin
    // grab the index as an expression and put it on the stack
    Next;
    tmpDT := fLHSDataType;
    oldExpStr := fExpStr;
    oldBS := fBoolSubExpStr;
    try
      fLHSDataType := TOK_LONGDEF;
      CommaExpression;
    finally
      fLHSDataType := tmpDT;
      fExpStr := oldExpStr;
      fBoolSubExpStr := oldBS;
    end;
    if Value <> ']' then
      Expected(''']''');
    push;
    tmp := tos;
    CopyVar(tmp, RegisterName);
    fArrayIndexStack.Add(tmp);
    theArrayDT := RemoveArrayDimension(theArrayDT);
    inc(dim);
    if Look = '[' then
      Next;
  end;

  // check for additional levels of indexing
  if (Look = '[') and IsArrayType(theArrayDT) then
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
      DoIndex(aval, GetDecoratedIdent(theArray), tmp);
      // pass its name into the call to DoNewArrayIndex
      Result := DoNewArrayIndex(theArrayDT, aval, aLHSName);
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
      DoIndex(aval, GetDecoratedIdent(theArray), tmp);
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
        Result := True; // i.e., loaded a value on the stack
        CheckAndLoadVar(Value);
        Next; // move to the next token
      end
      else if aLHSName <> '' then
      begin
        if tmpDT in NonAggregateTypes then
        begin
          Result := True; // loaded a value onto the stack
          CheckAndLoadVar(Value);
        end
        else if not IsArrayType(DataType(StripInline(aLHSName))) then
          CopyVar(GetDecoratedIdent(aLHSName), GetDecoratedValue)
        else
        begin
          Result := True; // sort of loaded a value onto the stack
          fUDTOnStack := Value;
        end;
        Next; // move to the next token
      end
      else
      begin
        // recurse to the NumericRelation procedure
        Result := True; // a numeric relation always puts a value on the stack
        NumericRelation;
      end;
    finally
      fArrayHelpers.ReleaseHelper(AHV);
    end;
  end;
  pop;
end;

procedure TEVCComp.CheckForMain;
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

procedure TEVCComp.DoCompilerStatusChange(const Status: string; const bDone : boolean);
begin
  if Assigned(fOnCompilerStatusChange) then
    fOnCompilerStatusChange(Self, Status, bDone);
end;

function TEVCComp.AmInlining: boolean;
begin
  Result := fInlineDepth > 0;
end;

procedure TEVCComp.DecrementInlineDepth;
begin
  // remove the
  dec(fInlineDepth);
end;

procedure TEVCComp.IncrementInlineDepth;
begin
  inc(fInlineDepth);
end;

procedure TEVCComp.HandleSpecialNames;
begin
  if Value = '__TMPLONG__' then
    Value := TempSignedLongName
  else if Value = '__RETVAL__' then
    Value := RegisterName
  else if Value = '__LINE__' then
    Value := IntToStr(linenumber)
  else if Value = '__FILE__' then
    Value := Format('"%s"', [CurrentFile])
  else if Value = '__FUNCTION__' then
    Value := Format('"%s"', [fCurrentThreadName])
  else if Value = '__DATE__' then
    Value := FormatDateTime('"mmm dd yyyy"', Date)
  else if Value = '__TIME__' then
    Value := FormatDateTime('"hh:nn:ss"', Now)
  else if Value = 'false' then
  begin
    Value := '0';
    Token := TOK_NUM;
  end
  else if Value = 'true' then
  begin
    Value := '1';
    Token := TOK_NUM;
  end;
end;

function TEVCComp.GetValueOf(const name: string): string;
begin
  Result := name;
  if IsLocalConst(name) then
  begin
    Result := LocalConstantValue(name);
  end
end;

procedure TEVCComp.CheckForValidDataType(dt: char);
begin
  // valid data types
  if not (dt in [TOK_LONGDEF,
                 TOK_USERDEFINEDTYPE, TOK_ARRAYUDT..TOK_ARRAYUDT4,
                 TOK_ARRAYLONGDEF..TOK_ARRAYLONGDEF4,
                 TOK_PROCEDURE, TOK_TASK, TOK_LABEL]) then
    AbortMsg(sUnknownDatatype);
end;

procedure TEVCComp.HandlePreprocStatusChange(Sender: TObject;
  const StatusMsg: string);
begin
  DoCompilerStatusChange(StatusMsg);
end;

procedure TEVCComp.SetCurFile(const Value: string);
begin
  if CurrentFile <> Value then
  begin
    fCurFile := Value;
    DoCompilerStatusChange(Format(sCurrentFile, [Value]));
  end;
end;

function TEVCComp.ProcessArrayDimensions(var lenexpr : string) : string;
var
  bDone, bOpen : boolean;
begin
  lenexpr := '';
  Result := '';
  // declaring an array
  bDone := False;
  bOpen := False;
  while not bDone do
  begin
    lenexpr := lenexpr + Value;
    if Token in ['[', ']'] then
      Result := Result + Token;
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
end;

procedure TEVCComp.CommaStatement(const lend, lstart: string);
begin
  Statement(lend, lstart);
  if fNoCommaOperator then Exit;
  // handle comma?
  if Token = TOK_COMMA then
  begin
    Next; // skip past the comma
    CommaStatement(lend, lstart);
  end;
end;

procedure TEVCComp.CheckAndLoadVar(const Name: string);
begin
  CheckNotProc(Name);
  LoadVar(Name);
end;

procedure TEVCComp.CheckAndStore(const Name: string);
begin
  CheckNotProc(Name);
  Store(Name);
end;

function TEVCComp.CountElements(lenexpr : string) : integer;
var
  expr : string;
  idx, n, dim, i : integer;
  dlen : array[0..3] of integer;
begin
  Result := 0;
  for i := Low(dlen) to High(dlen) do
    dlen[i] := 0;
  dim := 0;
  while (dim < 4) and (lenexpr <> '') do
  begin
    // grab the first array expression from lenexpr
    idx := Pos('[', lenexpr);
    n := Pos(']', lenexpr);
    expr := Copy(lenexpr, idx+1, n-idx-1);
    if expr <> '' then
    begin
      dlen[dim] := StrToIntDef(expr, -1);
      if dlen[dim] < 0 then
        AbortMsg(sArrayLenInvalid);
    end;
    System.Delete(lenexpr, idx, n-idx+1);
    inc(dim);
  end;
  if dlen[0] > 0 then
    Result := dlen[0];
  for i := 1 to 3 do
    if dlen[i] > 0 then
      Result := Result * dlen[i];
end;

function TEVCComp.CountValues(ival: string): integer;
var
  SL : TStringList;
begin
  ival := StripBraces(ival);
  // ival is a comma separated string
  SL := TStringList.Create;
  try
    SL.CommaText := ival;
    Result := SL.Count;
  finally
    SL.Free;
  end;
end;

function TEVCComp.ArraySize(DE : TDataspaceEntry) : integer;
var
  esize : integer;
  tmpDE : TDataspaceEntry;
begin
  tmpDE := DE.SubEntries[0];
  while tmpDE.DataType = dsArray do
    tmpDE := tmpDE.SubEntries[0];
  if tmpDE.DataType = dsCluster then
  begin
    esize := UDTSize(tmpDE.FullPathIdentifier);
  end
  else
    esize := 1; // base element size is 1
  Result := DE.ValueCount * esize;
end;

function TEVCComp.UDTSize(const tname : string) : integer;
var
  DE : TDataspaceEntry;
  i : integer;
begin
  Result := 0;
  DE := DataDefinitions.FindEntryByFullName(tname);
  if Assigned(DE) then
  begin
    for i := 0 to DE.SubEntries.Count - 1 do
    begin
      case DE.SubEntries[i].DataType of
        dsArray : begin
          inc(Result, ArraySize(DE.SubEntries[i]));
        end;
        dsCluster : begin
          inc(Result, UDTSize(DE.SubEntries[i].FullPathIdentifier));
        end;
      else
        inc(Result);
      end
    end;
  end;
end;

procedure TEVCComp.Prolog(const name : string; bIsSub : boolean);
begin
  if bIsSub then
  begin
    if AmInlining then
    begin
      fCurrentInlineFunction := fInlineFunctions.Add;
      fCurrentInlineFunction.Name := name;
    end
    else
      StartOfCode(name);
  end
  else
    StartOfCode(name);
end;

procedure TEVCComp.Epilog(bIsSub : boolean);
begin
  if bIsSub then
  begin
    if AmInlining then
    begin
      DecrementInlineDepth;
    end
    else
    begin
      ReturnFromRoutine;
      fSProProgram.EndProcess;
    end;
  end
  else
  begin
    EndOfProcess;
    fSProProgram.EndProcess;
  end;
end;

procedure TEVCComp.LoadConst(const n: string);
begin
  LoadConstToDest(RegisterName, n);
end;

procedure TEVCComp.HandleAcquireReleaseHelper(Sender: TObject; bAcquire: boolean; const aName: string);
begin
  if bAcquire then
    AcquireVolatile(aName)
  else
    ReleaseVolatile(aName);
end;

procedure TEVCComp.EmitStackVariables;
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
        AllocateHelper(Format('__signed_stack_%3.3d%s', [i, name]), '', TOK_LONGDEF, 1);
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
        AllocateHelper(Format('__signed_stack_%3.3d%s', [i, name]), '', TOK_LONGDEF, 1);
      end;
    end;
  end;
end;

procedure TEVCComp.EmitRegisters;
const
  REGVARS_ARRAY : array[0..1] of string = ('__tmpslong%s', '__D0%s');
var
  j, k, idx : integer;
  f : TInlineFunction;
  H : TArrayHelperVar;
  dt : Char;
  name, tname : string;
begin
  for j := 0 to fArrayHelpers.Count - 1 do
  begin
    H  := fArrayHelpers[j];
    dt := H.DataType;
    name  := H.Name;
    tname := GlobalTypeName(name);
    AllocateHelper(name, tname, dt, 1);
  end;
  for j := 0 to fThreadNames.Count - 1 do
  begin
    name := fThreadNames[j];
    if fInlineFunctions.IndexOfName(name) = -1 then
    begin
      for idx := Low(REGVARS_ARRAY) to High(REGVARS_ARRAY) do
        AllocateHelper(Format(REGVARS_ARRAY[idx], [name]), '', TOK_LONGDEF, 1);
      dt := FunctionReturnType(name);
      if IsUDT(dt) or IsArrayType(dt) then
      begin
        tname := GlobalTypeName(name);
        AllocateHelper(Format('__result_%s', [name]), tname, dt, 1);
      end;
    end;
  end;
  for j := 0 to fInlineFunctions.Count - 1 do
  begin
    f := fInlineFunctions[j];
    for k := 0 to f.Callers.Count - 1 do
    begin
      name := InlineName(f.Callers[k], f.Name);
      for idx := Low(REGVARS_ARRAY) to High(REGVARS_ARRAY) do
        AllocateHelper(Format(REGVARS_ARRAY[idx], [name]), '', TOK_LONGDEF, 1);
      dt := FunctionReturnType(f.Name);
      if IsUDT(dt) or IsArrayType(dt) then
      begin
        tname := GlobalTypeName(f.Name);
        AllocateHelper(Format('__result_%s', [name]), tname, dt, 1);
      end;
    end;
  end;
end;

procedure TEVCComp.Allocate(const Name, aVal, Val, tname: string; dt : char; cnt : integer);
begin
  if AmInlining then Exit;
  // variables are not output within inline functions
  AllocateHelper(Name, tname, dt, cnt);
end;

procedure TEVCComp.InitializeArray(const Name, aVal, Val, tname: string;
  dt: char; lenexpr: string);
var
  n, i : integer;
  tmp : string;
begin
  n := CountElements(lenexpr);
  if n > 0 then
  begin
    push;
    tmp := tos;
    StoreAddress(tmp, Name);
    for i := 0 to n - 1 do
    begin
      ClearIndirect(tmp);
      if i < (n - 1) then
        DoIncrement(tmp);
    end;
    pop;
  end;
end;

procedure TEVCComp.DoLocalArrayInit(const aName, ival: string; dt: char);
var
  n, i : integer;
  tmp, val : string;
  SL : TStringList;
begin
  SL := TStringList.Create;
  try
    SL.CommaText := StripBraces(ival);
    n := SL.Count;
    if n > 0 then
    begin
      push;
      tmp := tos;
      StoreAddress(tmp, aName);
      for i := 0 to n - 1 do
      begin
        val := SL[i];
        fCalc.SilentExpression := val;
        if fCalc.ParserError then
        begin
          // a variable?
          CopyVar('('+tmp+')', val);
        end
        else
        begin
          // a constant
          LoadConstToDest('('+tmp+')', val);
        end;
        if i < (n - 1) then
          DoIncrement(tmp);
      end;
      pop;
    end;
  finally
    SL.Free;
  end;
end;

procedure TEVCComp.EmitGlobalDataInitSubroutine;
var
  i : integer;
  V : TVariable;
  aval : string;
begin
  StartOfCode('__initialize_global_data');
  fIGDProcess := fSProProgram.CurrentProcess;
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
    else if V.DataType in NonAggregateTypes then
    begin
      LoadConstToDest(V.Name, V.Value);
    end
    else if IsUDT(V.DataType) then
    begin
    end;
  end;
  ReturnFromRoutine;
  fSProProgram.EndProcess;
end;

procedure TEVCComp.EmitLn(const s: string);
begin
  EmitPoundLine;
  SourceAdd(#9+s);
end;

procedure TEVCComp.EmitPoundLine;
begin
  SourceAdd('#line ' + IntToStr(linenumber-1) + ' "' + CurrentFile + '"');
end;

procedure TEVCComp.EmitLnNoTab(const s: string);
begin
  SourceAdd(s);
end;

procedure TEVCComp.EmitAsmLines(const s: string);
begin
  if Pos(#10, s) > 0 then
  begin
    fTmpAsmLines.Text := s;
    SourceAdd(Format('#pragma macro %d', [fTmpAsmLines.Count]));
    SourceAddStrings(fTmpAsmLines, True);
    EmitPoundLine;
  end
  else
    SourceAdd(s, True);
end;

procedure TEVCComp.StoreInc(const name : string);
var
  tmp : string;
begin
  tmp := GetDecoratedIdent(name);
  if fDerefAssignment or IsReferenceType(tmp) then
    tmp := '(' + tmp + ')';
  DoIncrement(tmp);
end;

procedure TEVCComp.StoreDec(const name : string);
var
  tmp : string;
begin
  tmp := GetDecoratedIdent(name);
  if fDerefAssignment or IsReferenceType(tmp) then
    tmp := '(' + tmp + ')';
  DoDecrement(tmp);
end;

procedure TEVCComp.StorePreInc(const name : string);
var
  tmp : string;
begin
  tmp := GetDecoratedIdent(name);
  if IsReferenceType(tmp) then
    tmp := '(' + tmp + ')';
  DoIncrement(tmp);
end;

procedure TEVCComp.StorePreDec(const name : string);
var
  tmp : string;
begin
  tmp := GetDecoratedIdent(name);
  if IsReferenceType(tmp) then
    tmp := '(' + tmp + ')';
  DoDecrement(tmp);
end;

function TEVCComp.GetCompilerOutput: TStrings;
begin
  Result := fSProProgram.CompilerOutput;
end;

function TEVCComp.GetSymbolTable: TStrings;
begin
  Result := FSProProgram.SymbolTable;
end;

function TEVCComp.SaveToStream(aStream: TStream): boolean;
begin
  try
    fSProProgram.OptimizeLevel := OptimizeLevel;
    Result := fSProProgram.SaveToStream(aStream);
  except
    on E : Exception do
    begin
      Result := False;
      AbortMsg(E.Message);
    end;
  end;
end;

procedure TEVCComp.CheckForCast;
begin
  if Token = TOK_OPENPAREN then
  begin
  end;
end;

procedure TEVCComp.HandleCast;
begin

end;

class function TEVCComp.BINToText(aStream: TStream; const aFilename: string): string;
begin
  with TSProProgram.Create do
  try
    CurrentFile := aFilename;
    LoadFromBinaryStream(aStream);
    Result := AsString;
  finally
    Free;
  end;
end;

class function TEVCComp.BINToText(const aFilename: string): string;
begin
  with TSProProgram.Create do
  try
    LoadFromBinaryFile(aFilename);
    Result := AsString;
  finally
    Free;
  end;
end;

//==========================================================================
//==========================================================================
//================== FUNCTIONS THAT GENERATE ASM CODE ======================
//==========================================================================
//==========================================================================

procedure TEVCComp.SourceInsert(const idx : integer; const aValue : string);
begin
  fSProProgram.InsertASMLine(idx, aValue);
end;

procedure TEVCComp.SourceClear;
begin
  fSProProgram.Clear;
end;

procedure TEVCComp.SourceDelete(const line : integer);
begin
  fSProProgram.Delete(line);
end;

function TEVCComp.SourceCount: integer;
begin
  Result := fSProProgram.Count;
end;

procedure TEVCComp.SourceSwitchWaitToStart;
var
  i : integer;
  AL : TSPMLine;
begin
  for i := 0 to fSProProgram.Count - 1 do
  begin
    AL := fSProProgram[i];
    if AL.CommandString = 'WAIT' then
    begin
      AL.CommandString := 'START';
      break;
    end;
  end;
end;

procedure TEVCComp.SourceRemoveCallToInitGlobals;
var
  i : integer;
  AL : TSPMLine;
begin
  for i := 0 to fSProProgram.Count - 1 do
  begin
    AL := fSProProgram[i];
    if (AL.CommandString = 'CALL') and
       (AL.Args[0].Value = '__initialize_global_data') then
    begin
      fSProProgram.Delete(AL.Index);
      break;
    end;
  end;
end;

procedure TEVCComp.SourceAdd(const str : string; const bAbortOnDS : boolean);
var
  tmp : string;
begin
  if AmInlining and Assigned(fCurrentInlineFunction) then
  begin
    fCurrentInlineFunction.Code.Add(str);
  end
  else
  begin
    // check to see if this happens to be a dataspace declaration
    tmp := str;
    tmp := UpperCase(Replace(Replace(tmp, ' ', ','), #9, ','));
    if (Pos(',DS,', tmp) > 0) or (Pos('DORG,', tmp) > 0) then
    begin
      // handle as a dataspace declaration - not code
      if bAbortOnDS then
        AbortMsg('Dataspace declarations are not supported in asm statements');
    end
    else
    begin
      fSProProgram.AddASMLine(str);
    end;
  end;
end;

procedure TEVCComp.SourceAddStrings(aStrings : TStrings; const bAbortOnDS : boolean);
var
  i : integer;
begin
  for i := 0 to aStrings.Count - 1 do
    SourceAdd(AStrings[i], bAbortOnDS);
end;

procedure TEVCComp.ReleaseVolatile(const aName : string);
begin
  EmitLnNoTab('#pragma release(' + aName + ')');
end;

procedure TEVCComp.AcquireVolatile(const aName : string);
begin
  EmitLnNoTab('#pragma acquire(' + aName + ')');
end;

procedure TEVCComp.CopyArrayVar(const dest, src: string);
begin
  AbortMsg('array copy not yet implemented');
  StoreValue(dest, src);
end;

procedure TEVCComp.CopyUDTVar(const dest, src: string);
begin
  AbortMsg('struct copy not yet implemented');
  StoreValue(dest, src);
end;

procedure TEVCComp.CopyVar(const dest, src: string);
begin
  StoreValue(dest, src);
end;

procedure TEVCComp.InitializeArrayReference(const dest, src: string);
begin
  if IsReferenceType(src) then
    StoreValue(dest, src)
  else
    StoreAddress(dest, src);
end;

procedure TEVCComp.InitializeUDTReference(const dest, src: string);
begin
  if IsReferenceType(src) then
    StoreValue(dest, src)
  else
    StoreAddress(dest, src);
end;

procedure TEVCComp.InitializeVarReference(const dest, src: string);
begin
  if IsReferenceType(src) then
    StoreValue(dest, src)
  else
    StoreAddress(dest, src);
end;

procedure TEVCComp.Store(const name: string);
var
  tmp : string;
begin
  tmp := GetDecoratedIdent(name);
  if fDerefAssignment or IsReferenceType(tmp) then
    tmp := '(' + tmp + ')';
  StoreValue(tmp, RegisterName);
end;

procedure TEVCComp.StoreAdd(const name : string);
var
  tmp : string;
begin
  tmp := GetDecoratedIdent(name);
  if fDerefAssignment or IsReferenceType(tmp) then
    tmp := '(' + tmp + ')';
  DoAdd(tmp, RegisterName);
end;

procedure TEVCComp.DoAdd(const dest, src : string);
begin
  EmitLn(Format('ADD %s, %s', [dest, src]));
end;

procedure TEVCComp.DoAddImmediate(const dest : string; const offset : integer);
begin
  EmitLn(Format('ADI %s, %d', [dest, offset]));
end;

procedure TEVCComp.StoreSub(const name : string);
var
  tmp : string;
begin
  tmp := GetDecoratedIdent(name);
  if fDerefAssignment or IsReferenceType(tmp) then
    tmp := '(' + tmp + ')';
  EmitLn(SubAsString(tmp, RegisterName));
end;

procedure TEVCComp.StoreMul(const name : string);
var
  tmp : string;
begin
  tmp := GetDecoratedIdent(name);
  if fDerefAssignment or IsReferenceType(tmp) then
    tmp := '(' + tmp + ')';
  EmitLn(Format('MUL %s, %s', [tmp, RegisterName]));
end;

procedure TEVCComp.StoreDiv(const name : string);
var
  tmp : string;
begin
  tmp := GetDecoratedIdent(name);
  if fDerefAssignment or IsReferenceType(tmp) then
    tmp := '(' + tmp + ')';
  EmitLn(Format('DIV %s, %s', [tmp, RegisterName]));
end;

procedure TEVCComp.StoreMod(const name : string);
var
  tmp, dest, src : string;
begin
  dest := GetDecoratedIdent(name);
  if fDerefAssignment or IsReferenceType(dest) then
    dest := '(' + dest + ')';
  src  := RegisterName;
  push;
  tmp := tos;
  StoreValue(tmp, dest);
  EmitLn(Format('DIV %s, %s', [tmp, src]));
  EmitLn(Format('MUL %s, %s', [tmp, src]));
  EmitLn(SubAsString(dest, tmp));
  pop;
end;

procedure TEVCComp.StoreAnd(const name: string);
var
  tmp : string;
begin
  tmp := GetDecoratedIdent(name);
  if fDerefAssignment or IsReferenceType(tmp) then
    tmp := '(' + tmp + ')';
  EmitLn(Format('AND %s, %s', [tmp, RegisterName]));
end;

procedure TEVCComp.StoreOr(const name: string);
var
  tmp : string;
begin
  tmp := GetDecoratedIdent(name);
  if fDerefAssignment or IsReferenceType(tmp) then
    tmp := '(' + tmp + ')';
  EmitLn(Format('OR %s, %s', [tmp, RegisterName]));
end;

procedure TEVCComp.StoreXor(const name: string);
var
  tmp : string;
begin
  tmp := GetDecoratedIdent(name);
  if fDerefAssignment or IsReferenceType(tmp) then
    tmp := '(' + tmp + ')';
  EmitLn(Format('XOR %s, %s', [tmp, RegisterName]));
end;

procedure TEVCComp.StoreShift(bRight: boolean; const name: string);
var
  tmp : string;
begin
  tmp := GetDecoratedIdent(name);
  if fDerefAssignment or IsReferenceType(tmp) then
    tmp := '(' + tmp + ')';
  if bRight then
    EmitLn(Format('ASR %s, %s', [tmp, fLastLoadedConst]))
  else
    EmitLn(Format('LSL %s, %s', [tmp, fLastLoadedConst]));
end;

procedure TEVCComp.Complement;
begin
  fCCSet := False;
  EmitLn(Format('COM %s', [RegisterName]));
end;

procedure TEVCComp.Negate;
begin
  fCCSet := False;
  EmitLn(Format('NEG %s', [RegisterName]));
end;

procedure TEVCComp.ClearReg;
begin
  fCCSet := False;
  EmitLn(Format('CLR %s', [RegisterName]));
end;

procedure TEVCComp.LoadVar(const Name: string);
begin
  LoadVarToDest(RegisterName, Name);
end;

procedure TEVCComp.LoadVarToDest(const Dest: string; const Name: string);
var
  tmp : string;
begin
  fCCSet := False;
  tmp := GetDecoratedIdent(Name);
  if fAddressOfValue then
  begin
    StoreAddress(Dest, tmp);
  end
  else
  begin
    if fDerefValue or IsReferenceType(tmp) then
      tmp := '(' + tmp + ')';
    StoreValue(Dest, tmp);
  end;
end;

procedure TEVCComp.PushPrim;
begin
  push;
  StoreValue(tos, RegisterName);
end;

procedure TEVCComp.PopAdd;
begin
  fCCSet := False;
  DoAdd(RegisterName, tos);
  pop;
end;

procedure TEVCComp.PopSub;
begin
  fCCSet := False;
  EmitLn(SubAsString(tos, RegisterName));
  CopyVar(RegisterName, tos);
  pop;
end;

procedure TEVCComp.PopMul;
begin
  fCCSet := False;
  EmitLn(Format('MUL %s, %s', [RegisterName, tos]));
  pop;
end;

procedure TEVCComp.PopDiv;
begin
  fCCSet := False;
  EmitLn(Format('DIV %s, %s', [tos, RegisterName]));
  CopyVar(RegisterName, tos);
  pop;
end;

procedure TEVCComp.PopMod;
var
  tmp, lhs, rhs : string;
begin
  fCCSet := False;
  rhs := RegisterName;
  lhs  := tos;
  push;
  tmp := tos;
  StoreValue(tmp, lhs);
  EmitLn(Format('DIV %s, %s', [tmp, rhs]));
  EmitLn(Format('MUL %s, %s', [tmp, rhs]));
  EmitLn(SubAsString(lhs, tmp));
  CopyVar(RegisterName, lhs);
  pop;
  pop;
end;

procedure TEVCComp.PopAnd;
begin
  fCCSet := False;
  EmitLn(Format('AND %s, %s', [RegisterName, tos]));
  pop;
end;

procedure TEVCComp.PopOr;
begin
  fCCSet := False;
  EmitLn(Format('OR %s, %s', [RegisterName, tos]));
  pop;
end;

procedure TEVCComp.PopXor;
begin
  fCCSet := False;
  EmitLn(Format('XOR %s, %s', [RegisterName, tos]));
  pop;
end;

procedure TEVCComp.LoadConstToDest(const dest, n: string);
var
  val : integer;
begin
  fLastLoadedConst := n;
  val := StrToIntDef(n, 0);
  if (val > High(SmallInt)) or (val < Low(SmallInt)) then
  begin
    // requires a 32-bit load
    EmitLn(Format('MVI %s, 0%4.4xH', [dest, Word(val shr 16)]));
    EmitLn(Format('LSL %s, 16', [dest]));
    EmitLn(Format('ORI %s, 0%4.4xH', [dest, Word(val)]));
  end
  else
    EmitLn(Format('MVI %s, %d', [dest, val]));
  fCCSet := False;
end;

procedure TEVCComp.Branch(const L: string);
begin
  EmitLn(BranchAsString(L));
end;

procedure TEVCComp.CallRoutine(const name : string);
begin
  EmitLn('CALL '+name);
end;

procedure TEVCComp.ReturnFromRoutine;
begin
  EmitLn('RET');
end;

procedure TEVCComp.PostLabel(const L: string);
begin
  EmitLnNoTab(L+':');
end;

procedure TEVCComp.PopLeftShift;
begin
  fCCSet := False;
  EmitLn(Format('LSL %s, %s', [tos, fLastLoadedConst]));
  CopyVar(RegisterName, tos);
  pop;
end;

procedure TEVCComp.PopRightShift;
begin
  fCCSet := False;
  EmitLn(Format('ASR %s, %s', [tos, fLastLoadedConst]));
  CopyVar(RegisterName, tos);
  pop;
end;

procedure TEVCComp.SetToTrue(const aName : string);
begin
  EmitLn(Format('MVI %s, 1', [aName]));
end;

procedure TEVCComp.SetToFalse(const aName : string);
begin
  EmitLn(Format('MVI %s, 0', [aName]));
end;

procedure TEVCComp.NotIt(const aName : string);
var
  L : string;
begin
  fCCSet := False;
  L := NewLabel;
  EmitLn(TestAsString(aName)); // sets Z flag
  SetToTrue(aName);
  EmitLn(BranchFalseAsString(L));
  SetToFalse(aName);
  PostLabel(L);
end;

procedure TEVCComp.StoreArray(const name, idx, val : string);
var
  tmp, src : string;
begin
  // move RHS to array[idx] or set array = to RHS
  if idx = '' then
    CopyArray(name, val)
  else
  begin
    src := GetDecoratedIdent(name);
    push;
    tmp := tos;
    StoreAddress(tmp, src);
    // TODO: Add index * size of array elements, which may be > 1
    DoAdd(tmp, idx); // add idx to pointer
    EmitLn(Format('MOV (%s), %s', [tmp, val])); // mov val into array
    pop;
  end;
end;

procedure TEVCComp.DoIndex(const aValue, aName, aIndex : string);
var
  tmp, src : string;
begin
  src := aName;
  push;
  tmp := tos;
  StoreAddress(tmp, src);
  DoAdd(tmp, aIndex); // add aIndex to pointer
  EmitLn(Format('MOV %s, (%s)', [aValue, tmp])); // extract val from array
  pop;
end;

procedure TEVCComp.StartOfCode(const aName : string);
begin
  PostLabel(aName);
  fSProProgram.AddProcess(aName);
  if aName = 'main' then
    fSProProgram.CurrentProcess.AddRef;
end;

procedure TEVCComp.EndOfProcess;
begin
  EmitLn('HALTME');
end;

procedure TEVCComp.Header;
begin
//  EmitLn(Format('SUBTTL %s.ASM', [UpperCase(ChangeFileExt(ExtractFileName(CurrentFile), ''))]));
  // changed to WAIT instead of START to support download/download and run
  EmitLn('WAIT');
end;

procedure TEVCComp.Trailer;
begin
  DoCompilerStatusChange(Format(sXXXGenerateTrailer, ['EVC']));
  CheckForMain;
  EmitRegisters;      // writes to a simple dataspace now
  EmitStackVariables; // writes to a simple dataspace now

  if fAutoStart then
    SourceSwitchWaitToStart;

  // output the array initialization subroutine last
  EmitGlobalDataInitSubroutine;
  if Assigned(fIGDProcess) and (fIGDProcess.Count <= 3) then
  begin
    fSProProgram.DeleteProcess(fIGDProcess);
    SourceRemoveCallToInitGlobals;
  end;
  EmitLn('END');
end;

procedure TEVCComp.StoreAddress(const dest, src : string);
begin
  EmitLn(Format('MVI %s, %s', [dest, src])); // grab address of src
end;

procedure TEVCComp.StoreValue(const dest, src : string);
begin
  EmitLn(MoveAsString(dest, src));
end;

procedure TEVCComp.ClearIndirect(const element : string);
begin
  EmitLn(Format('CLR (%s)', [element]));
end;

procedure TEVCComp.DoIncrement(const aName : string);
begin
  EmitLn(Format('INC %s', [aName]));
end;

procedure TEVCComp.DoDecrement(const aName : string);
begin
  EmitLn(Format('DEC %s', [aName]));
end;

procedure TEVCComp.StartProcess(const aName : string);
begin
  EmitLn(Format('FORK %s', [aName]));
end;

procedure TEVCComp.TraceChar(const C : Char);
begin
  if C in [' ', ',', ';', '"'] then
    TraceString(C)
  else
    EmitLn(Format('TRCH %s', [C]));
end;

procedure TEVCComp.TraceString(const S : string);
begin
  EmitLn(Format('TRST ''%s''', [S]));
end;

procedure TEVCComp.OpenLogForWrite;
var
  L : string;
begin
  L := NewLabel;
  EmitLn('LINIT');
  SetToFalse(RegisterName);
  EmitLn('JC ' + L);
  SetToTrue(RegisterName);
  PostLabel(L);
end;

procedure TEVCComp.OpenLogForRead;
var
  L : string;
begin
  L := NewLabel;
  EmitLn('LOPEN');
  SetToFalse(RegisterName);
  EmitLn('JC ' + L);
  SetToTrue(RegisterName);
  PostLabel(L);
end;

procedure TEVCComp.CloseLog;
var
  L : string;
begin
  L := NewLabel;
  EmitLn('LCLOSE');
  SetToFalse(RegisterName);
  EmitLn('JC ' + L);
  SetToTrue(RegisterName);
  PostLabel(L);
end;

procedure TEVCComp.LogStatus;
var
  L : string;
begin
  // log file is closed (0), busy (1), or open (2)
  L := NewLabel;
  EmitLn('LSTAT');
  EmitLn(Format('MVI %s, %d', [RegisterName, 2])); // open
  EmitLn(BranchTrueAsString(L));
  DoDecrement(RegisterName); // busy
  EmitLn('JC ' + L);
  DoDecrement(RegisterName); // closed
  PostLabel(L);
end;

procedure TEVCComp.Rotate(bRight : boolean; const aName : string);
begin
  if bRight then
    EmitLn('RRC ' + aName)
  else
    EmitLn('RLC ' + aName);
end;

procedure TEVCComp.PushVar(const aName : string);
begin
  EmitLn('PUSH ' + aName);
end;

procedure TEVCComp.PopVar(const aName : string);
begin
  EmitLn('POP ' + aName);
end;

procedure TEVCComp.TraceVar(bDecimal : boolean; const aName : string);
begin
  if bDecimal then
    EmitLn('TRND ' + aName)
  else
    EmitLn('TRNH ' + aName);
end;

procedure TEVCComp.WriteVar(const aName : string);
begin
  EmitLn('LOG ' + aName);
end;

procedure TEVCComp.ReadVar(const aName : string);
begin
  EmitLn('READ ' + aName);
end;

procedure TEVCComp.RunProgram(const slot : byte);
begin
  EmitLn(Format('SWITCH %d',[slot]));
end;

procedure TEVCComp.SquareRoot(const aName : string);
begin
  EmitLn('SQRT ' + aName);
end;

procedure TEVCComp.AbsoluteValue;
var
  L : string;
begin
  L := NewLabel;
  EmitLn(TestAsString(RegisterName)); // test the value
  EmitLn(BranchPositiveAsString(L));
  Negate;
  PostLabel(L);
end;

procedure TEVCComp.SignValue;
var
  L : string;
begin
  // set RegisterName to 1, 0, or -1 if positive, zero, or negative
  L := NewLabel;
  EmitLn(TestAsString(RegisterName)); // test the value
  SetToTrue(RegisterName);
  EmitLn(BranchPositiveAsString(L));
  EmitLn(Format('MVI %s, -1', [RegisterName]));
  EmitLn(BranchNegativeAsString(L));
  SetToFalse(RegisterName);
  PostLabel(L);
end;

procedure TEVCComp.SizeOfValue(const aName : string);
begin
  LoadConst(IntToStr(CalculatedSize(aName)));
end;

procedure TEVCComp.WaitMS(const aName : string);
var
  L, svar : string;
begin
  L := NewLabel;
  push;
  svar := tos;
  CopyVar(svar, '01FH');
  DoAdd(svar, aName);
  PostLabel(L);
  push;
  CopyVar(tos, svar);
  EmitLn(Format('SUB %s, 01FH', [tos]));
  pop;
  EmitLn(BranchPositiveAsString(L));
  pop;
end;

procedure TEVCComp.ExitToProcess(const aName : string);
begin
  StartProcess(aName);
  EndOfProcess;
end;

{
procedure TEVCComp.WaitForClock;
begin
  EmitLn('STALL');
end;
}

procedure TEVCComp.StopAllProcesses(const aName : string);
var
  L : string;
begin
  L := NewLabel;
  EmitLn(TestAsString(RegisterName));
  EmitLn(BranchFalseAsString(L));
  EmitLn('HALTALL');
  PostLabel(L);
end;

procedure TEVCComp.HaltEx;
begin
  EmitLn('HALTEX');
end;

procedure TEVCComp.TraceCarriageReturn;
begin
  EmitLn('TRCR');
end;

procedure TEVCComp.TraceNewLine;
begin
  EmitLn('TRNL');
end;

procedure TEVCComp.TraceSpace;
begin
  EmitLn('TRSP');
end;

(*
procedure TEVCComp.TraceCRLF;
begin
  TraceCarriageReturn;
  TraceNewLine;
end;
*)

function TEVCComp.SubAsString(const aLHS, aRHS : string) : string;
begin
  Result := Format('SUB %s, %s', [aLHS, aRHS]);
end;

function TEVCComp.MoveAsString(const aLHS, aRHS : string) : string;
begin
  Result := Format('MOV %s, %s', [aLHS, aRHS]);
end;

function TEVCComp.SubImmAsString(const aLHS, aRHS : string) : string;
begin
  Result := Format('SBI %s, %s', [aLHS, aRHS]);
end;

function TEVCComp.BranchAsString(const aLabel: string) : string;
begin
  Result := 'JMP ' + aLabel;
end;

function TEVCComp.BranchPositiveAsString(const aLabel: string) : string;
begin
  Result := 'JP ' + aLabel;
end;

function TEVCComp.BranchNegativeAsString(const aLabel: string) : string;
begin
  Result := 'JN ' + aLabel;
end;

function TEVCComp.BranchFalseAsString(const aLabel: string) : string;
begin
  Result := 'JZ ' + aLabel;
end;

function TEVCComp.BranchTrueAsString(const aLabel: string) : string;
begin
  Result := 'JNZ ' + aLabel;
end;

function TEVCComp.TestAsString(const aName : string) : string;
begin
  Result := 'TST ' + aName;
end;

procedure TEVCComp.CopyArray(const name, val: string);
begin
  EmitLn(Format('arrbuild %s, %s', [GetDecoratedIdent(name), val]))
end;

procedure TEVCComp.CmpHelper(const cc : TCompareCode; const lhs, rhs: string);
var
  tmp, L : string;
begin
  push;
  tmp := tos;
  L := NewLabel;
  StoreValue(tmp, lhs);
  EmitLn(SubAsString(tmp, rhs));
  SetToTrue(RegisterName);
  if cc in [ccLT, ccLTEQ] then begin
    if cc = ccLTEQ then
      EmitLn(BranchFalseAsString(L)); // Z will be set if lhs == rhs
    EmitLn(BranchNegativeAsString(L));   // N will be set if lhs < rhs
  end
  else if cc in [ccGT, ccGTEQ] then begin
    if cc = ccGTEQ then
      EmitLn(BranchFalseAsString(L)); // Z will be set if lhs == rhs
    EmitLn(BranchPositiveAsString(L));   // P will be set if lhs > rhs
  end
  else begin
    if cc = ccNEQ then
      EmitLn('INVZ');  // Z will not be set if lhs != rhs
    EmitLn(BranchFalseAsString(L));  // Z will be set if lhs == rhs
  end;
  SetToFalse(RegisterName);
  PostLabel(L);
  SetZeroCC;
  pop;
end;

procedure TEVCComp.StoreZeroFlag;
var
  L : string;
begin
  // set Register if Z is not set, otherwise clear register
  L := NewLabel;
  SetToFalse(RegisterName);
  EmitLn(BranchFalseAsString(L));
  SetToTrue(RegisterName);
  PostLabel(L);
end;

procedure TEVCComp.BranchFalse(const L: string);
begin
  if not fCCSet then
    SetZeroCC;
  EmitLn(BranchFalseAsString(L));
end;

procedure TEVCComp.BranchTrue(const L: string);
begin
  if not fCCSet then
    SetZeroCC;
  EmitLn(BranchTrueAsString(L));
end;

procedure TEVCComp.BranchPositive(const L: string);
begin
  EmitLn(BranchPositiveAsString(L));
end;

procedure TEVCComp.SetZeroCC;
begin
  fCCSet := True;
  EmitLn(TestAsString(RegisterName));
end;

procedure TEVCComp.TestVariable(const name : string);
begin
  EmitLn(TestAsString(name));
end;

procedure TEVCComp.OutputDirective(const directive : string);
begin
  EmitPoundLine;
  EmitLnNoTab(directive);
end;

//==========================================================================
//==========================================================================
//=============== FUNCTIONS THAT GENERATE DATA SPECIFIERS ==================
//==========================================================================
//==========================================================================

function TEVCComp.AllocateHelper(aName, tname : string; dt : char; cnt : integer) : integer;
var
  DE : TDataspaceEntry;
//  i : integer;
//  Sub : TDataspaceEntry;
//  len, org : integer;
begin
  Result := 0;
  case dt of
    TOK_LONGDEF : begin
      Result := 1;
      fSProProgram.AddDataSpecifier(aName, Result);
    end;
    TOK_USERDEFINEDTYPE :
    begin
      // we need to know how many elements to allocate
      DE := DataDefinitions.FindEntryByFullName(tname);
      if Assigned(DE) then
      begin
        Result := UDTSize(tname);
        fSProProgram.AddDataSpecifier(aName, Result);
{
        len := UDTSize(tname);
        org := fSProProgram.DataOrigin;
        fSProProgram.AddDataSpecifier(aName, len);
}
(*
        Result := 0;
        for i := 0 to DE.SubEntries.Count - 1 do
        begin
          Sub := DE.SubEntries[i];
          case Sub.DataType of
            dsSLong : begin
              Result := Result + AllocateHelper(Replace(Sub.FullPathIdentifier, tname, aName), '', TOK_LONGDEF, 1);
            end;
            dsArray : begin
              Result := Result + AllocateHelper(Replace(Sub.FullPathIdentifier, tname, aName), '', TOK_ARRAYLONGDEF, Sub.ValueCount);
            end;
            dsCluster : begin
              Result := Result + AllocateHelper(Replace(Sub.FullPathIdentifier, tname, aName), sub.TypeName, TOK_USERDEFINEDTYPE, 1);
            end;
          end
        end;
*)
      end
      else
        AbortMsg('Unknown struct type');
    end;
    TOK_ARRAYLONGDEF..TOK_ARRAYLONGDEF4   :
    begin
      // we need to know how many elements to allocate
      Result := cnt;
      fSProProgram.AddDataSpecifier(aName, Result);
    end;
    TOK_ARRAYUDT..TOK_ARRAYUDT4 :
    begin
      // we need to know how many elements to allocate
      Result := UDTSize(tname)*cnt;
      fSProProgram.AddDataSpecifier(aName, Result);
    end;
  else
    AbortMsg(sUnknownDatatype);
  end;
  fSizeMap.AddEntry(aName, Result);
end;

end.