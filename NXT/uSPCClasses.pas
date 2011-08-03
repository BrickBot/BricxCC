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
 * Portions created by John Hansen are Copyright (C) 2011 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uSPCClasses;

{$B-}

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, Contnrs, SysUtils, uNXTConstants, uPreprocess,
  uNBCCommon, uNXTClasses;

type
  TSProOpCode = Word;
  TSProArgType = (satConstant, satPC, satSlot, satChar, satAddress, satNone);
  TSProArgDir = (sadInput, sadOutput, sadBoth, sadNeither);

  CodeArray = array of Word;

  TSPMArg = class(TCollectionItem)
  private
    fValue: string;
    fAddress: integer;
    fIndirect: boolean;
  protected
    procedure SetValue(const aValue: string);
    function  GetValue : string;
    function  GetAddress: integer;
  public
    constructor Create(Collection: TCollection); override;
    function Evaluate(Calc : TNBCExpParser) : Extended;
    property Value : string read GetValue write SetValue;
    property Address : integer read GetAddress;
    property Indirect : boolean read fIndirect;
  end;

  TOnNameToAddress = procedure(const aName : string; var aAddress : integer) of object;

  TSPMArguments = class(TCollection)
  private
    function GetItem(Index: Integer): TSPMArg;
    procedure SetItem(Index: Integer; const Value: TSPMArg);
    function GetAsString: string;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
    function  Add: TSPMArg;
    function Insert(Index: Integer): TSPMArg;
    property  Items[Index: Integer]: TSPMArg read GetItem write SetItem; default;
    property  AsString : string read GetAsString;
  end;

  TSProProcessCode = class;
  TSProProcess = class;
  TSProProgram = class;

  TSPMLine = class(TCollectionItem)
  private
    procedure RemoveVariableReference(const arg: string;
      const idx: integer);
    procedure RemoveVariableReferences;
  protected
    fComment: string;
    fLabel: string;
    fArgs: TSPMArguments;
    fOpCode: TSProOpcode;
    fLineNum: integer;
    fInstrSize : integer;
    fStartAddress : integer;
    fCode : CodeArray;
    function  GetAsString: string;
    function  GetSProProcess: TSProProcess;
    function  GetSProProgram: TSProProgram;
    function  GetPC: word;
    function GetOptimizable: boolean;
    procedure SetArgs(const Value: TSPMArguments);
    function  GetSProProcessCode: TSProProcessCode;
    function  IsLabel(const name : string; var aID : integer) : boolean;
    procedure HandleNameToAddress(const name: string; var aAddress: integer);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure AddArgs(sargs : string);
    function InstructionSize : integer;
    property LineLabel : string read fLabel write fLabel;
    property Command : TSProOpcode read fOpCode write fOpCode;
    property Args : TSPMArguments read fArgs write SetArgs;
    property Comment : string read fComment write fComment;
    property LineNum : integer read fLineNum write fLineNum;
    property ProgramCounter : word read GetPC;
    property SProProcessCode : TSProProcessCode read GetSProProcessCode;
    property SProProcess : TSProProcess read GetSProProcess;
    property SProProgram : TSProProgram read GetSProProgram;
    property StartAddress : integer read fStartAddress;
    property AsString : string read GetAsString;
    property Optimizable : boolean read GetOptimizable;
  end;

  TSProProcessCode = class(TCollection)
  private
    fOnNameToAddress: TOnNameToAddress;
    fSProProcess : TSProProcess;
  protected
    function GetItem(Index: Integer): TSPMLine;
    procedure SetItem(Index: Integer; const Value: TSPMLine);
    procedure HandleNameToAddress(const aName : string; var aAddress : integer);
  public
    constructor Create(aSProProcess : TSProProcess);
    destructor Destroy; override;
    function  Add: TSPMLine;
    property  Items[Index: Integer]: TSPMLine read GetItem write SetItem; default;
    property  SProProcess : TSProProcess read fSProProcess;
    property  OnNameToAddress : TOnNameToAddress read fOnNameToAddress write fOnNameToAddress;
  end;

  TSProProcess = class(TCollectionItem)
  private
    fName: string;
    fSProProcessCode: TSProProcessCode;
    fIsSub: boolean;
    fDatasize : integer;
    fCode : CodeArray;
    fFilename: string;
    fLastLine: integer;
    function GetSProProgram: TSProProgram;
    function GetDataSize: Word;
    function GetStartAddress: Word;
    function GetCaseSensitive: boolean;
    function GetInUse: boolean;
    procedure RemoveOrNOPLine(AL, ALNext: TSPMLine; const idx: integer);
    function GetCallerCount: Byte;
    function IsMovOptimizationSafe(bEnhanced: boolean; op: TSProOpCode; aValue : string): boolean;
  protected
    fLabelMap : TStringList;
    fCallers : TStringList;
    fRefCount : integer;
    procedure FinalizeSProProcess;
    procedure HandleNameToAddress(const aname : string; var aAddress : integer);
    procedure RemoveReferences;
    procedure FixupPragmas(line1, line2 : TSPMLine; const arg : string);
    procedure RemoveLineIfPossible(line : TSPMLine; const arg : string);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Optimize(const level : Integer);
    procedure RemoveUnusedLabels;
    procedure RemoveUnusedPragmas;
    procedure AddCaller(const clumpName : string);
    procedure AddLabel(const lbl : string; Line : TSPMLine);
    function  IndexOfLabel(const lbl : string) : integer;
    function  AsmLineFromLabelIndex(const idx : integer) : TSPMLine;
    procedure IncRefCount;
    procedure DecRefCount;
    procedure SaveToCode(var Store : CodeArray);
    property SProProgram : TSProProgram read GetSProProgram;
    property StartAddress : Word read GetStartAddress;
    property DataSize : Word read GetDataSize;
    property Name : string read fName write fName;
    property CallerCount : Byte read GetCallerCount;
    property SProProcessCode : TSProProcessCode read fSProProcessCode;
    property IsSubroutine : boolean read fIsSub write fIsSub;
    property CaseSensitive : boolean read GetCaseSensitive;
    property InUse : boolean read GetInUse;
    property Filename : string read fFilename write fFilename;
    property LastLine : integer read fLastLine write fLastLine;
  end;

  TSProProgram = class(TCollection)
  private
    fOnNameToAddress: TOnNameToAddress;
    fCalc: TNBCExpParser;
    fCaseSensitive : Boolean;
    fDS: TDataspace;
    fOnCompilerStatusChange: TCompilerStatusChangeEvent;
    function GetCaseSensitive: boolean;
    procedure SetCaseSensitive(const Value: boolean);
    procedure BuildReferences;
    procedure DoCompilerStatusChange(const Status: string; const bDone: boolean = False);
    procedure FinalizeDependencies;
    procedure SaveToStrings(aStrings: TStrings);
    procedure SaveToSymbolTable(aStrings: TStrings);
  protected
    fInitName: string;
    fAddresses : TObjectList;
    function  GetItem(aIndex: Integer): TSProProcess;
    procedure SetItem(aIndex: Integer; const aValue: TSProProcess);
    procedure FinalizeAddresses;
    function  GetAddress(aIndex: Integer): Word;
    procedure HandleNameToAddress(const aName : string; var aAddress : integer);
    procedure RemoveUnusedLabels;
    procedure RemoveUnusedPragmas;
  public
    constructor Create(ds : TDataspace);
    destructor Destroy; override;
    function  Add: TSProProcess;
    procedure Compact;
    procedure Optimize(const level : Integer);
    function  IndexOf(const aName : string) : integer;
    procedure AddReferenceIfPresent(aSProProcess : TSProProcess; const aName : string);
    procedure RemoveReferenceIfPresent(const aName : string);
    property  Items[aIndex: Integer]: TSProProcess read GetItem write SetItem; default;
    property  StartingAddresses[aIndex: Integer] : Word read GetAddress;
    property  InitialSProProcessName : string read fInitName write fInitName;
    property  Calc : TNBCExpParser read fCalc write fCalc;
    property  OnNameToAddress : TOnNameToAddress read fOnNameToAddress write fOnNameToAddress;
    property  OnCompilerStatusChange : TCompilerStatusChangeEvent read fOnCompilerStatusChange write fOnCompilerStatusChange;
    property  CaseSensitive : boolean read GetCaseSensitive write SetCaseSensitive;
    property  Dataspace : TDataspace read fDS;
  end;

implementation

uses
  uLocalizedStrings;

type
  TIntegerObject = class
  protected
    fValue : Integer;
  public
    constructor Create(aValue : Integer);
    property Value : Integer read fValue;
  end;

  SProInstruction = record
    Encoding : TSProOpCode;
    Arity  : Byte;
    Size  : Byte;
    Name : string;
  end;

const
  OP_MVI     = $0000;
  OP_ADI     = $1000;
  OP_SBI     = $2000;
  OP_MUI     = $3000;
  OP_DVI     = $4000;
  OP_ANI     = $5000;
  OP_ORI     = $6000;
  OP_XRI     = $7000;
  OP_MOV     = $8000;
  OP_ADD     = $8100;
  OP_SUB     = $8200;
  OP_MUL     = $8300;
  OP_DIV     = $8400;
  OP_AND     = $8500;
  OP_OR      = $8600;
  OP_XOR     = $8700;
  OP_TST     = $8E00;
  OP_INC     = $8E01;
  OP_DEC     = $8E02;
  OP_COM     = $8E03;
  OP_NEG     = $8E04;
  OP_CLR     = $8E05;
  OP_LSL     = $8E06;
  OP_LSR     = $8E08;
  OP_ASR     = $8E0A;
  OP_RLC     = $8E0C;
  OP_RRC     = $8E0D;
  OP_PUSH    = $8E0E;
  OP_POP     = $8E0F;
  OP_TRND    = $8E10;
  OP_TRNH    = $8E11;
  OP_TRSD    = $8E12;
  OP_SQRT    = $8E13;
  OP_LOG     = $8E14;
  OP_LREAD   = $8E15;
  OP_WAIT    = $8F00;
  OP_START   = $8F01;
  OP_RET     = $8F02;
  OP_STALL   = $8F03;
  OP_HALT    = $8F04;
  OP_CLC     = $8F05;
  OP_INVC    = $8F06;
  OP_STC     = $8F07;
  OP_CLZ     = $8F08;
  OP_INVZ    = $8F09;
  OP_STZ     = $8F0A;
  OP_HALTALL = $8F0B;
  OP_TRSP    = $8F0C;
  OP_TRNL    = $8F0D;
  OP_TRCR    = $8F0E;
  OP_HALTEX  = $8F0F;
  OP_LINIT   = $8F10;
  OP_LOPEN   = $8F11;
  OP_LCLOSE  = $8F12;
  OP_LSTAT   = $8F13;
  OP_SWITCH  = $8F18;
  OP_TRCH    = $8F20;
  OP_FORK    = $9000;
  OP_JMP     = $A000;
  OP_CALL    = $B000;
  OP_JZ      = $C000;
  OP_JP      = $D000;
  OP_JN      = $E000;
  OP_JC      = $F000;

  OPS_DS      = $FFFE;
  OPS_INCLUDE = $FFFD;
  OPS_DORG    = $FFFC;
  OPS_SUBTTL  = $FFFB;
  OPS_END     = $FFFA;
  OPS_INVALID = $FFFF;


const
  SProInstructionsCount = 63+5;
  SProInstructions : array[0..SProInstructionsCount] of SProInstruction =
  (
    ( Encoding: OP_MVI     ; Arity: 2; Size: 2; Name: 'MVI'; ),
    ( Encoding: OP_ADI     ; Arity: 2; Size: 2; Name: 'ADI'; ),
    ( Encoding: OP_SBI     ; Arity: 2; Size: 2; Name: 'SBI'; ),
    ( Encoding: OP_MUI     ; Arity: 2; Size: 2; Name: 'MUI'; ),
    ( Encoding: OP_DVI     ; Arity: 2; Size: 2; Name: 'DVI'; ),
    ( Encoding: OP_ANI     ; Arity: 2; Size: 2; Name: 'ANI'; ),
    ( Encoding: OP_ORI     ; Arity: 2; Size: 2; Name: 'ORI'; ),
    ( Encoding: OP_XRI     ; Arity: 2; Size: 2; Name: 'XRI'; ),
    ( Encoding: OP_MOV     ; Arity: 2; Size: 2; Name: 'MOV'; ),
    ( Encoding: OP_ADD     ; Arity: 2; Size: 2; Name: 'ADD'; ),
    ( Encoding: OP_SUB     ; Arity: 2; Size: 2; Name: 'SUB'; ),
    ( Encoding: OP_MUL     ; Arity: 2; Size: 2; Name: 'MUL'; ),
    ( Encoding: OP_DIV     ; Arity: 2; Size: 2; Name: 'DIV'; ),
    ( Encoding: OP_AND     ; Arity: 2; Size: 2; Name: 'AND'; ),
    ( Encoding: OP_OR      ; Arity: 2; Size: 2; Name: 'OR'; ),
    ( Encoding: OP_XOR     ; Arity: 2; Size: 2; Name: 'XOR'; ),
    ( Encoding: OP_TST     ; Arity: 1; Size: 2; Name: 'TST'; ),
    ( Encoding: OP_INC     ; Arity: 1; Size: 2; Name: 'INC'; ),
    ( Encoding: OP_DEC     ; Arity: 1; Size: 2; Name: 'DEC'; ),
    ( Encoding: OP_COM     ; Arity: 1; Size: 2; Name: 'COM'; ),
    ( Encoding: OP_NEG     ; Arity: 1; Size: 2; Name: 'NEG'; ),
    ( Encoding: OP_CLR     ; Arity: 1; Size: 2; Name: 'CLR'; ),
    ( Encoding: OP_LSL     ; Arity: 2; Size: 2; Name: 'LSL'; ),
    ( Encoding: OP_LSR     ; Arity: 2; Size: 2; Name: 'LSR'; ),
    ( Encoding: OP_ASR     ; Arity: 2; Size: 2; Name: 'ASR'; ),
    ( Encoding: OP_RLC     ; Arity: 1; Size: 2; Name: 'RLC'; ),
    ( Encoding: OP_RRC     ; Arity: 1; Size: 2; Name: 'RRC'; ),
    ( Encoding: OP_PUSH    ; Arity: 1; Size: 2; Name: 'PUSH'; ),
    ( Encoding: OP_POP     ; Arity: 1; Size: 2; Name: 'POP'; ),
    ( Encoding: OP_TRND    ; Arity: 1; Size: 2; Name: 'TRND'; ),
    ( Encoding: OP_TRNH    ; Arity: 1; Size: 2; Name: 'TRNH'; ),
    ( Encoding: OP_TRSD    ; Arity: 1; Size: 2; Name: 'TRSD'; ),
    ( Encoding: OP_SQRT    ; Arity: 1; Size: 2; Name: 'SQRT'; ),
    ( Encoding: OP_LOG     ; Arity: 1; Size: 2; Name: 'LOG'; ),
    ( Encoding: OP_LREAD   ; Arity: 1; Size: 2; Name: 'LREAD'; ),
    ( Encoding: OP_WAIT    ; Arity: 0; Size: 1; Name: 'WAIT'; ),
    ( Encoding: OP_START   ; Arity: 0; Size: 1; Name: 'START'; ),
    ( Encoding: OP_RET     ; Arity: 0; Size: 1; Name: 'RET'; ),
    ( Encoding: OP_STALL   ; Arity: 0; Size: 1; Name: 'STALL'; ),
    ( Encoding: OP_HALT    ; Arity: 0; Size: 1; Name: 'HALT'; ),
    ( Encoding: OP_CLC     ; Arity: 0; Size: 1; Name: 'CLC'; ),
    ( Encoding: OP_INVC    ; Arity: 0; Size: 1; Name: 'INVC'; ),
    ( Encoding: OP_STC     ; Arity: 0; Size: 1; Name: 'STC'; ),
    ( Encoding: OP_CLZ     ; Arity: 0; Size: 1; Name: 'CLZ'; ),
    ( Encoding: OP_INVZ    ; Arity: 0; Size: 1; Name: 'INVZ'; ),
    ( Encoding: OP_STZ     ; Arity: 0; Size: 1; Name: 'STZ'; ),
    ( Encoding: OP_HALTALL ; Arity: 0; Size: 1; Name: 'HALTALL'; ),
    ( Encoding: OP_TRSP    ; Arity: 0; Size: 1; Name: 'TRSP'; ),
    ( Encoding: OP_TRNL    ; Arity: 0; Size: 1; Name: 'TRNL'; ),
    ( Encoding: OP_TRCR    ; Arity: 0; Size: 1; Name: 'TRCR'; ),
    ( Encoding: OP_HALTEX  ; Arity: 0; Size: 1; Name: 'HALTEX'; ),
    ( Encoding: OP_LINIT   ; Arity: 0; Size: 1; Name: 'LINIT'; ),
    ( Encoding: OP_LOPEN   ; Arity: 0; Size: 1; Name: 'LOPEN'; ),
    ( Encoding: OP_LCLOSE  ; Arity: 0; Size: 1; Name: 'LCLOSE'; ),
    ( Encoding: OP_LSTAT   ; Arity: 0; Size: 1; Name: 'LSTAT'; ),
    ( Encoding: OP_SWITCH  ; Arity: 1; Size: 1; Name: 'SWITCH'; ),
    ( Encoding: OP_TRCH    ; Arity: 1; Size: 1; Name: 'TRCH'; ),
    ( Encoding: OP_FORK    ; Arity: 1; Size: 1; Name: 'FORK'; ),
    ( Encoding: OP_JMP     ; Arity: 1; Size: 1; Name: 'JMP'; ),
    ( Encoding: OP_CALL    ; Arity: 1; Size: 1; Name: 'CALL'; ),
    ( Encoding: OP_JZ      ; Arity: 1; Size: 1; Name: 'JZ'; ),
    ( Encoding: OP_JP      ; Arity: 1; Size: 1; Name: 'JP'; ),
    ( Encoding: OP_JN      ; Arity: 1; Size: 1; Name: 'JN'; ),
    ( Encoding: OP_JC      ; Arity: 1; Size: 1; Name: 'JC'; ),
// pseudo-opcodes
    ( Encoding: OPS_DS      ; Arity: 1; Size: 0; Name: 'DS'; ),
    ( Encoding: OPS_INCLUDE ; Arity: 1; Size: 0; Name: 'INCLUDE'; ),
    ( Encoding: OPS_DORG    ; Arity: 1; Size: 0; Name: 'DORG'; ),
    ( Encoding: OPS_SUBTTL  ; Arity: 1; Size: 0; Name: 'SUBTTL'; ),
    ( Encoding: OPS_END     ; Arity: 0; Size: 0; Name: 'END'; )
  );


function IsStack(const str : string) : boolean;
begin
  Result := (Pos('__signed_stack_', str) = 1) or
            (Pos('__unsigned_stack_', str) = 1) or
            (Pos('__float_stack_', str) = 1);
end;

function IsReg(const str : string) : boolean;
begin
  Result := (Pos('__D0', str) = 1) or
            (Pos('__DU0', str) = 1) or
            (Pos('__DF0', str) = 1);
end;

function IsArrayHelper(const str : string) : boolean;
begin
  // if the array helper type is a struct and has a member reference
  // then it is no longer an array helper type
  Result := (Pos('__ArrHelper__', str) = 1) and (Pos('.', str) = 0);
end;

function IsStackOrHelper(const str : string) : boolean;
begin
  Result := IsStack(str) or IsArrayHelper(str);
end;

function IsVolatile(const str : string) : boolean;
begin
  Result := IsReg(str) or IsStack(str) or IsArrayHelper(str);
end;

function IsConstant(const str : string) : boolean;
begin
  Result := (Pos('__constVal', str) = 1);
end;

function ExpectedSProArgType(const op : TSProOpCode; const argIdx: integer): TSProArgType;
begin
  case op of
    OP_MVI, OP_ADI, OP_SBI, OP_MUI, OP_DVI, OP_ANI, OP_ORI, OP_XRI,
    OP_LSL, OP_LSR, OP_ASR : begin
      if argIdx > 0 then
        Result := satConstant
      else
        Result := satAddress;
    end;
    OP_MOV, OP_ADD, OP_SUB, OP_MUL, OP_DIV, OP_AND, OP_OR, OP_XOR : begin
      Result := satAddress;
    end;
    OP_TST, OP_PUSH, OP_TRND, OP_TRNH, OP_TRSD, OP_LOG : begin
      Result := satAddress;
    end;
    OP_INC, OP_DEC, OP_COM, OP_NEG, OP_CLR, OP_RLC, OP_RRC, OP_SQRT : begin
      Result := satAddress;
    end;
    OP_POP, OP_LREAD : begin
      Result := satAddress;
    end;
    OP_WAIT, OP_START, OP_RET, OP_STALL, OP_HALT, OP_CLC, OP_INVC, OP_STC,
    OP_CLZ, OP_INVZ, OP_STZ, OP_HALTALL, OP_TRSP, OP_TRNL, OP_TRCR, OP_HALTEX,
    OP_LINIT, OP_LOPEN, OP_LCLOSE, OP_LSTAT : begin
      Result := satNone;
    end;
    OP_SWITCH : begin
      Result := satSlot;
    end;
    OP_TRCH : begin
      Result := satChar;
    end;
    OP_FORK, OP_JMP, OP_CALL, OP_JZ, OP_JP, OP_JN, OP_JC : begin
      Result := satPC;
    end;
  else
    Result := satNone;
  end;
end;

function SProArgDirection(const op : TSProOpCode; const argIdx: integer): TSProArgDir;
begin
  case op of
    OP_MVI, OP_MOV : begin
      if argIdx > 0 then
        Result := sadInput
      else
        Result := sadOutput;
    end;
    OP_ADI, OP_SBI, OP_MUI, OP_DVI, OP_ANI, OP_ORI, OP_XRI,
    OP_LSL, OP_LSR, OP_ASR,
    OP_ADD, OP_SUB, OP_MUL, OP_DIV, OP_AND, OP_OR, OP_XOR : begin
      if argIdx > 0 then
        Result := sadInput
      else
        Result := sadBoth;
    end;
    OP_TST, OP_PUSH, OP_TRND, OP_TRNH, OP_TRSD, OP_LOG : begin
      Result := sadInput;
    end;
    OP_INC, OP_DEC, OP_COM, OP_NEG, OP_CLR, OP_RLC, OP_RRC, OP_SQRT : begin
      Result := sadBoth;
    end;
    OP_POP, OP_LREAD : begin
      Result := sadOutput;
    end;
    OP_WAIT, OP_START, OP_RET, OP_STALL, OP_HALT, OP_CLC, OP_INVC, OP_STC,
    OP_CLZ, OP_INVZ, OP_STZ, OP_HALTALL, OP_TRSP, OP_TRNL, OP_TRCR, OP_HALTEX,
    OP_LINIT, OP_LOPEN, OP_LCLOSE, OP_LSTAT : begin
      Result := sadNeither;
    end;
    OP_SWITCH : begin
      Result := sadInput;
    end;
    OP_TRCH : begin
      Result := sadInput;
    end;
    OP_FORK, OP_JMP, OP_CALL, OP_JZ, OP_JP, OP_JN, OP_JC : begin
      Result := sadInput;
    end;
  else
    Result := sadNeither;
  end;
end;

function IndexOfOpcode(op: TSProOpCode): integer;
var
  i : integer;
begin
  Result := -1;
  for i := Low(SProInstructions) to High(SProInstructions) do
  begin
    if SProInstructions[i].Encoding = op then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function OpcodeToStr(const op: TSProOpCode): string;
var
  i : integer;
begin
  if op <> OPS_INVALID then
    Result := Format('bad op (%d)', [Ord(op)])
  else
    Result := '';
  for i := Low(SProInstructions) to High(SProInstructions) do
  begin
    if SProInstructions[i].Encoding = op then
    begin
      Result := SProInstructions[i].Name;
      break;
    end;
  end;
end;

{ TSPMLine }

procedure TSPMLine.AddArgs(sargs: string);
var
  i : integer;
  SL : TStringList;
  Arg : TSPMArg;
  tmp : string;
begin
  // args is a comma-separated list of opcode arguments
  if Trim(sargs) = '' then Exit;
  SL := TStringList.Create;
  try
    // arguments can be delimited by single quotes, double quotes, or braces.
    // In any of those cases the entire contents of
    // the delimited item is a single argument
    if Pos('{', sargs) <> 0 then
    begin
      while sargs <> '' do
      begin
        // is the start of the next argument a delimiter?
        if IsDelimiter('{"''', sargs, 1) then
        begin
          tmp := Copy(sargs, 1, 1);//'{';
          if tmp = '{' then
          begin
            System.Delete(sargs, 1, 1); // remove the delimiter
            i := Pos('}', sargs);
            if i = 0 then
            begin
              tmp := tmp + Copy(sargs, 1, MaxInt) + '}';
            end
            else
              tmp := tmp + Copy(sargs, 1, i);
            System.Delete(sargs, 1, i);
          end
          else
          begin
            // the argument string starts with " or '
            // let's just try adding the rest using CommaText. UGLY KLUDGE!!!!
            SL.CommaText := sargs;
            for i := 0 to SL.Count - 1 do
            begin
              Arg := Args.Add;
              Arg.Value := Trim(SL[i]);
            end;
            sargs := '';
            break;
          end;
        end
        else
        begin
          i := Pos(',', sargs);
          if i = 0 then
            tmp := sargs
          else
            tmp := Copy(sargs, 1, i-1);
          System.Delete(sargs, 1, Length(tmp));
        end;
        sargs := Trim(sargs);
        // remove comma between this arg and next if there is one
        if Pos(',', sargs) = 1 then
        begin
          System.Delete(sargs, 1, 1);
          sargs := Trim(sargs);
        end;
        Arg := Args.Add;
        Arg.Value := Trim(tmp);
      end;
    end
    else
    begin
      SL.CommaText := sargs;
      for i := 0 to SL.Count - 1 do
      begin
        Arg := Args.Add;
        Arg.Value := Trim(SL[i]);
      end;
    end;
  finally
    SL.Free;
  end;
end;

constructor TSPMLine.Create(ACollection: TCollection);
begin
  inherited;
  fOpCode := OPS_INVALID;
  fInstrSize := -1;
  fArgs := TSPMArguments.Create;
end;

function TSPMLine.InstructionSize: integer;
begin
  Result := fInstrSize;
end;

destructor TSPMLine.Destroy;
begin
  FreeAndNil(fArgs);
  inherited;
end;

function TSPMLine.GetSProProcessCode: TSProProcessCode;
begin
  Result := TSProProcessCode(Collection);
end;

procedure TSPMLine.SetArgs(const Value: TSPMArguments);
begin
  fArgs.Assign(Value);
end;

procedure TSPMLine.HandleNameToAddress(const name: string; var aAddress: integer);
begin
  SProProcessCode.HandleNameToAddress(name, aAddress);
end;

function TSPMLine.IsLabel(const name: string; var aID : integer): boolean;
var
  i : integer;
  AL : TSPMLine;
begin
  aID := 0;
  i := SProProcess.IndexOfLabel(name);
  Result := i <> -1;
  if Result then
  begin
    AL := SProProcess.AsmLineFromLabelIndex(i);
    aID := AL.StartAddress;
  end;
end;

function TSPMLine.GetAsString: string;
begin
  Result := LineLabel;
  if Result <> '' then
    Result := Result + ':';
  if Command <> OPS_INVALID then
  begin
    Result := Result + #9;
    Result := Result + OpcodeToStr(Command) + ' ' + Args.AsString;
  end;
end;

function TSPMLine.GetSProProcess: TSProProcess;
begin
  Result := SProProcessCode.SProProcess;
end;

function TSPMLine.GetSProProgram: TSProProgram;
begin
  Result := SProProcess.SProProgram;
end;

procedure TSPMLine.RemoveVariableReferences;
var
  i : integer;
begin
  for i := 0 to Args.Count - 1 do
  begin
    RemoveVariableReference(Args[i].Value, i);
  end;
end;

procedure TSPMLine.RemoveVariableReference(const arg: string; const idx : integer);
var
  argType : TSProArgType;
begin
  argType := ExpectedSProArgType(Command, idx);
  case argType of
    satAddress :
    begin
      SProProgram.Dataspace.RemoveReferenceIfPresent(arg);
    end;
    satPC : begin
      SProProgram.RemoveReferenceIfPresent(arg);
    end;
  end;
end;

function TSPMLine.GetPC: word;
begin
  Result := Word(StartAddress);
end;

function TSPMLine.GetOptimizable: boolean;
var
  op : TSProOpCode;
begin
  Result := False;
  op := Command;
  if ({(op >= OP_MVI) and }(op <= OP_XOR)) or
     ((op >= OP_TST) and (op <= OP_CLR)) or
     ((op >= OP_LSL) and (op <= OP_ASR)) or
     ((op >= OP_RLC) and (op <= OP_RRC)) then
  begin
    Result := True;
  end;
end;

{ TSPMArguments }

function TSPMArguments.Add: TSPMArg;
begin
  Result := TSPMArg(inherited Add);
end;

procedure TSPMArguments.AssignTo(Dest: TPersistent);
var
  i : integer;
  arg : TSPMArg;
begin
  if Dest is TSPMArguments then
  begin
    TSPMArguments(Dest).Clear;
    for i := 0 to Self.Count - 1 do
    begin
      arg := TSPMArguments(Dest).Add;
      arg.Value := Self[i].Value;
    end;
  end
  else
    inherited;
end;

constructor TSPMArguments.Create;
begin
  inherited Create(TSPMArg);
end;

function TSPMArguments.GetAsString: string;
var
  i : integer;
begin
  Result := '';
  for i := 0 to Count - 1 do
    Result := Result + Items[i].Value + ', ';
  if Count > 0 then
    System.Delete(Result, Length(Result)-1, 2);
end;

function TSPMArguments.GetItem(Index: Integer): TSPMArg;
begin
  Result := TSPMArg(inherited GetItem(Index));
end;

function TSPMArguments.Insert(Index: Integer): TSPMArg;
begin
  Result := TSPMArg(inherited Insert(Index));
end;

procedure TSPMArguments.SetItem(Index: Integer; const Value: TSPMArg);
begin
  inherited SetItem(Index, Value);
end;

{ TSProProgram }

function TSProProgram.Add: TSProProcess;
begin
  Result := TSProProcess(inherited Add);
end;

procedure TSProProgram.BuildReferences;
var
  i, j : integer;
  C : TSProProcess;
  AL : TSPMLine;
begin
  // build references
  for i := 0 to Count - 1 do
  begin
    C := Items[i];
    if i = 0 then
      C.IncRefCount; // the first clump is required
    for j := 0 to C.SProProcessCode.Count - 1 do
    begin
      AL := C.SProProcessCode.Items[j];
      if (AL.Command = OP_CALL) or (AL.Command = OP_FORK) then
      begin
        // a process name argument
        if AL.Args.Count > 0 then
          AddReferenceIfPresent(C, AL.Args[0].Value);
      end;
    end;
  end;
end;

procedure TSProProgram.Compact;
var
  bDone : boolean;
  i : integer;
  C : TSProProcess;
begin
  // remove any unused clumps from the codespace
  bDone := False;
  while not bDone do
  begin
    bDone := True;
    // never check clump 0 since it is the main clump
    for i := 1 to Count - 1 do
    begin
      C := Items[i];
      if not C.InUse then
      begin
        // remove this clump from the codespace
        C.RemoveReferences;
        Delete(i);
        bDone := False;
        break;
      end;
    end;
  end;
end;

constructor TSProProgram.Create(ds : TDataspace);
begin
  inherited Create(TSProProcess);
  fDS := ds;
  fInitName := 'main';
  fAddresses := TObjectList.Create;
end;

destructor TSProProgram.Destroy;
begin
  FreeAndNil(fAddresses);
  inherited;
end;

procedure TSProProgram.FinalizeDependencies;
var
  i : integer;
  X : TSProProcess;
begin
  // if there is a process called main make it the first process
  i := IndexOf(InitialSProProcessName);
  if i <> -1 then
  begin
    X := Items[i];
    X.Index := 0;
  end;
end;

function TSProProgram.GetAddress(aIndex: Integer): Word;
begin
  if fAddresses.Count <> Count then
    FinalizeAddresses;
  Result := Word(TIntegerObject(fAddresses[aIndex]).Value);
end;

function TSProProgram.GetCaseSensitive: boolean;
begin
  Result := fCaseSensitive;
end;

function TSProProgram.GetItem(aIndex: Integer): TSProProcess;
begin
  Result := TSProProcess(inherited GetItem(aIndex));
end;

procedure TSProProgram.HandleNameToAddress(const aName: string; var aAddress: integer);
begin
  aAddress := 0;
  if Assigned(fOnNameToAddress) then
    fOnNameToAddress(aName, aAddress);
end;

function TSProProgram.IndexOf(const aName: string): integer;
var
  i : integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    if Items[i].Name = aName then
    begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TSProProgram.AddReferenceIfPresent(aSProProcess : TSProProcess; const aName: string);
var
  i : integer;
  C : TSProProcess;
begin
  i := IndexOf(aName);
  if i <> -1 then begin
    C := Items[i];
    C.IncRefCount;
    if C.IsSubroutine then
      C.AddCaller(aSProProcess.Name);
  end;
end;

procedure TSProProgram.RemoveReferenceIfPresent(const aName: string);
var
  i : integer;
begin
  i := IndexOf(aName);
  if i <> -1 then
    Items[i].DecRefCount;
end;

procedure TSProProgram.SetCaseSensitive(const Value: boolean);
var
  i : integer;
begin
  fCaseSensitive := Value;
  for i := 0 to Count - 1 do
  begin
    Items[i].fLabelMap.CaseSensitive := Value;
  end;
end;

procedure TSProProgram.SetItem(aIndex: Integer; const aValue: TSProProcess);
begin
  inherited SetItem(aIndex, aValue);
end;

procedure TSProProgram.FinalizeAddresses;
var
  i : integer;
  X : TSProProcess;
  addr : integer;
begin
  // calculate addresses for all the processes
  addr := 0;
  fAddresses.Clear;
  for i := 0 to Count - 1 do
  begin
    X := Items[i];
    fAddresses.Add(TIntegerObject.Create(addr));
    inc(addr, X.DataSize);
  end;
end;

procedure TSProProgram.DoCompilerStatusChange(const Status: string; const bDone : boolean);
begin
  if Assigned(fOnCompilerStatusChange) then
    fOnCompilerStatusChange(Self, Status, bDone);
end;

procedure TSProProgram.Optimize(const level : Integer);
var
  i : integer;
  C : TSProProcess;
begin
  // have each process optimize itself
  for i := 0 to Count - 1 do
  begin
    C := Items[i];
    // skip processes starting with '__' under the assumption that
    // they are API-level (hand optimized) processes
    if Pos('__', C.Name) = 1 then
      Continue;
    DoCompilerStatusChange(Format(sNBCOptClump, [C.Name]));
    C.Optimize(level);
  end;
end;

procedure TSProProgram.SaveToSymbolTable(aStrings: TStrings);
var
  i, j : integer;
  C : TSProProcess;
  AL : TSPMLine;
begin
  aStrings.Add('#SOURCES');
  aStrings.Add('SProProcess'#9'Line'#9'PC'#9'Source');
  for i := 0 to Count - 1 do
  begin
    C := Items[i];
    for j := 0 to C.SProProcessCode.Count - 1 do
    begin
      AL := C.SProProcessCode.Items[j];
      if (AL.Command <> OPS_INVALID) then
        aStrings.Add(Format('%d'#9'%d'#9'%d'#9'%s',
          [i, AL.LineNum, AL.ProgramCounter, AL.AsString]));
    end;
  end;
  aStrings.Add('#PROCESSES');
  aStrings.Add('SProProcess'#9'Name'#9'Offset'#9'File');
  for i := 0 to Count - 1 do
  begin
    C := Items[i];
    aStrings.Add(Format('%d'#9'%s'#9'%d'#9'%s',
      [i, C.Name, C.StartAddress, C.Filename]));
  end;
end;

procedure TSProProgram.RemoveUnusedLabels;
var
  i : integer;
begin
  // now remove any labels that are not targets of a branch/jump
  for i := 0 to Count - 1 do
    Items[i].RemoveUnusedLabels;
end;

procedure TSProProgram.SaveToStrings(aStrings: TStrings);
var
  i, j : integer;
  C : TSProProcess;
  AL : TSPMLine;
  tmpStr : string;
begin
  aStrings.Add(';------- code -------');
  for i := 0 to Count - 1 do
  begin
    C := Items[i];
    if C.IsSubroutine then
      aStrings.Add('subroutine ' + C.Name)
    else
      aStrings.Add('thread ' + C.Name);
    for j := 0 to C.SProProcessCode.Count - 1 do
    begin
      AL := C.SProProcessCode.Items[j];
      // skip blank lines
      tmpStr := AL.AsString;
      if Trim(tmpStr) <> '' then
        aStrings.Add(tmpStr);
    end;
    if C.IsSubroutine then
      aStrings.Add('ends')
    else
      aStrings.Add('endt');
    aStrings.Add(';------------------------');
  end;
end;

procedure TSProProgram.RemoveUnusedPragmas;
var
  i : integer;
begin
  // now remove any #pragma acquire or #pragma release lines
  for i := 0 to Count - 1 do
    Items[i].RemoveUnusedPragmas;
end;

{ TSProProcess }

constructor TSProProcess.Create(ACollection: TCollection);
begin
  inherited;
  fDatasize := -1;
  fIsSub    := False;
  fRefCount := 0;
  fLabelMap := TStringList.Create;
  fLabelMap.CaseSensitive := SProProgram.CaseSensitive;
  fLabelMap.Sorted := True;
  fSProProcessCode := TSProProcessCode.Create(Self);
  fSProProcessCode.OnNameToAddress := HandleNameToAddress;
  fCallers := TStringList.Create;
  fCallers.CaseSensitive := SProProgram.CaseSensitive;
  fCallers.Sorted := True;
  fCallers.Duplicates := dupIgnore;
end;

destructor TSProProcess.Destroy;
begin
  FreeAndNil(fLabelMap);
  FreeAndNil(fSProProcessCode);
  FreeAndNil(fCallers);
  inherited;
end;

function TSProProcess.GetSProProgram: TSProProgram;
begin
  Result := TSProProgram(Collection);
end;

function TSProProcess.GetDataSize: Word;
begin
  // calculate the datasize from the code contained in this clump
  if fDatasize = -1 then
    FinalizeSProProcess;
  Result := Word(fDatasize);
end;

function TSProProcess.GetStartAddress: Word;
begin
  // the starting address of a clump is determined by the codespace
  Result := SProProgram.StartingAddresses[Self.Index];
end;

procedure TSProProcess.FinalizeSProProcess;
var
  i : integer;
  AL : TSPMLine;
begin
  fDataSize := 0; // no code to start with
  for i := 0 to SProProcessCode.Count - 1 do
  begin
    AL := SProProcessCode[i];
    AL.fStartAddress := fDataSize;
    inc(fDataSize, AL.InstructionSize div 2);
  end;
(*
  // save code
  for i := 0 to SProProcessCode.Count - 1 do
  begin
    AL := SProProcessCode[i];
    AL.SaveToCode(fCode);
  end;
*)
end;

procedure TSProProcess.SaveToCode(var Store: CodeArray);
var
  i, len, start : integer;
begin
  if Length(fCode) = 0 then
    FinalizeSProProcess;
  len := Length(fCode);
  start := Length(Store);
  // copy data from our local array to the passed in array
  SetLength(Store, start + len);
  for i := 0 to len - 1 do
  begin
    Store[start+i] := fCode[i];
  end;
end;

procedure TSProProcess.HandleNameToAddress(const aname: string; var aAddress: integer);
begin
  SProProgram.HandleNameToAddress(aname, aAddress);
end;

procedure TSProProcess.AddCaller(const clumpName: string);
begin
  fCallers.Add(clumpName); // duplicates are ignored
end;

function TSProProcess.GetCaseSensitive: boolean;
begin
  Result := SProProgram.CaseSensitive;
end;

procedure TSProProcess.AddLabel(const lbl: string; Line : TSPMLine);
begin
  fLabelMap.AddObject(lbl, Line);
end;

function TSProProcess.IndexOfLabel(const lbl: string): integer;
begin
  Result := fLabelMap.IndexOf(lbl);
end;

function TSProProcess.AsmLineFromLabelIndex(const idx: integer): TSPMLine;
begin
  Result := TSPMLine(fLabelMap.Objects[idx]);
end;

function TSProProcess.GetInUse: boolean;
begin
  Result := fRefCount > 0;
end;

procedure TSProProcess.RemoveReferences;
var
  i : integer;
begin
  // remove references in code
  for i := 0 to SProProcessCode.Count - 1 do
  begin
    SProProcessCode.Items[i].RemoveVariableReferences;
  end;
  // if this clump is a subroutine remove
  // the return address variable as well
  if Self.IsSubroutine then
    SProProgram.Dataspace.RemoveReferenceIfPresent(Format('__%s_return', [Name]));
end;

procedure TSProProcess.DecRefCount;
begin
  dec(fRefCount);
end;

procedure TSProProcess.IncRefCount;
begin
  inc(fRefCount);
end;

procedure TSProProcess.RemoveOrNOPLine(AL, ALNext : TSPMLine; const idx : integer);
begin
  if AL.LineLabel = '' then
  begin
    SProProcessCode.Delete(idx);
  end
  else if Assigned(ALNext) and (ALNext.LineLabel = '') then
  begin
    ALNext.LineLabel := AL.LineLabel;
    SProProcessCode.Delete(idx);
  end
  else
  begin
    AL.Command := OPS_INVALID;
    AL.Args.Clear;
  end;
end;

procedure ConvertToSetOrMov(DS : TDataspace; var AL : TSPMLine; iVal : Double; var arg1 : string);
var
  tmp : string;
  DE : TDataspaceEntry;
begin
  if (iVal < Low(SmallInt)) or (iVal > High(Word)) or (Trunc(iVal) <> iVal) then
  begin
    // we need to use mov
    AL.Command := OP_MOV;
    // the type of the output variable determines whether we should truncate this value or not
    tmp := AL.Args[0].Value;
    DE := DS.FindEntryByFullName(tmp);
    if Assigned(DE) then
    begin
      if DE.DataType <> dsFloat then
        iVal := Trunc(iVal);
    end;
    arg1 := CreateConstantVar(DS, iVal, True);
  end
  else begin
    // no need to use mov - we can use set instead
    AL.Command := OP_SET;
    arg1 := IntToStr(Trunc(iVal));
  end;
end;

function GetArgValuePart1(arg1 : string; var val : Double) : boolean;
var
  bIsNeg : boolean;
  bIsFloat : boolean;
begin
  Result := True;
  // remove __constVal or __constValNeg
  bIsNeg := Pos('__constValNeg', arg1) = 1;
  if bIsNeg then
    System.Delete(arg1, 1, 13)
  else
    System.Delete(arg1, 1, 10);
  bIsFloat := (Pos('f', arg1) > 0) or (Pos('P', arg1) > 0);
  if bIsFloat then
  begin
    arg1 := Replace(Replace(arg1, 'f', ''), 'P', '.');
    val := NBCStrToFloatDef(arg1, 0);
  end
  else
    val := StrToIntDef(arg1, 0);
  if bIsNeg then
    val := val * -1;
end;

function GetArgValuePart2(EP : TNBCExpParser; arg1 : string; var val : Double) : boolean;
begin
  EP.SilentExpression := arg1;
  Result := not EP.ParserError;
  if Result then
    val := EP.Value
  else
    val := 0;
end;

function GetArgValue(EP : TNBCExpParser; arg1 : string; var val : Double) : boolean;
begin
  if IsVolatile(arg1) then
  begin
    Result := False;
  end
  else if IsConstant(arg1) then
  begin
    Result := GetArgValuePart1(arg1, val);
  end
  else
  begin
    Result := GetArgValuePart2(EP, arg1, val);
  end;
end;

function CountArgUsage(AL : TSPMLine; const arg : string) : integer;
var
  i : integer;
begin
  Result := 0;
  for i := 0 to AL.Args.Count - 1 do
  begin
    if AL.Args[i].Value = arg then
      inc(Result);
  end;
end;

function TSProProcess.IsMovOptimizationSafe(bEnhanced : boolean; op : TSProOpCode; aValue : string) : boolean;
var
  DE : TDataspaceEntry;
begin
  Result := True;
(*
  if (op = OP_SET) or ((not bEnhanced) and (op in
        [OP_GETTICK, OP_NOT, OP_ARRSIZE, OP_GETOUT, OP_GETIN, OP_UNFLATTEN,
         OP_CMP, OP_WAIT, OP_STRINGTONUM])) then
  begin
    // need to also check the type of the next line's output arg
    DE := SProProgram.Dataspace.FindEntryByFullName(aValue);
    if Assigned(DE) then
      Result := DE.DataType <> dsFloat
    else
      Result := False;
  end;
*)
end;

procedure TSProProcess.Optimize(const level : Integer);
var
  i, offset, j, tmpIdx : integer;
  iVal, Arg1Val, Arg2Val : Double;
  AL, ALNext, tmpAL : TSPMLine;
  arg1, arg2, arg3, tmp : string;
  bEnhanced, bDone, bArg1Numeric, bArg2Numeric : boolean;
  DE : TDataspaceEntry;
  firmVer : Word;
  argDir : TAsmArgDir;

  function CheckReferenceCount : boolean;
  var
    cnt : integer;
  begin
    Result := True;
    arg1 := AL.Args[0].Value; // check the output (dest) argument
    cnt := CountArgUsage(AL, arg1);
    DE := SProProgram.Dataspace.FindEntryByFullName(arg1);
    if Assigned(DE) then
    begin
      // simple case - refcount is less than this line's usage
      if DE.RefCount <= cnt then
      begin
        // setting a variable to a value and never referencing it again
        // set|mov X, whatever
        // nop (or delete line)
        // remove the references
        AL.RemoveVariableReferences;
        RemoveOrNOPLine(AL, nil, i);
        Result := False;
      end;
    end;
  end;
begin
(*
  bDone := False;
  while not bDone do begin
    bDone := True; // assume we are done
    for i := 0 to SProProcessCode.Count - 1 do begin
      AL := SProProcessCode.Items[i];
      if AL.Command = OPS_INVALID then
        Continue;

      // the first set of optimizations are for any optimizable opcode
      // followed by a mov opcode

      // any line of this form: op reg/stack, rest
      // followed by this line  mov anything, reg/stack
      // where reg/stack1 == reg/stack2
      // can be replaced by one line of this form:
      //   op anything, rest
      //   nop
      if AL.Optimizable then
      begin

        // first check reference count of output variable
        if not CheckReferenceCount then
        begin
          bDone := False;
          Break;
        end;

        arg1 := AL.Args[0].Value;
        if IsVolatile(arg1) then
        begin
          // mov arg1, arg1
          // nop
          if (AL.Command = OP_MOV) and (arg1 = AL.Args[1].Value) then
          begin
            AL.RemoveVariableReferences;
            RemoveOrNOPLine(AL, nil, i);
            bDone := False;
            Break;
          end;

          // the output argument of this opcode is a temporary variable (stack/reg/array helper)
          // so maybe we can do an optimization
          // find the next line (which may not be i+1) that is not (NOP or labeled)
          offset := 1;
          while (i < SProProcessCode.Count - offset) do begin
            tmpAL := SProProcessCode.Items[i+offset];
            if (tmpAL.Command <> OPS_INVALID) or (tmpAL.LineLabel <> '') then
              Break;
            inc(offset);
          end;
          // every line between Items[i] and Items[i+offset] are NOP lines without labels.
          if i < (SProProcessCode.Count - offset) then
          begin
            ALNext := SProProcessCode.Items[i+offset];
            // now check other cases
            // bricxcc-Bugs-1669679 - make sure the next line
            // cannot be jumped to from elsewhere.  If it does then the
            // "previous" line may actually be skipped so we cannot
            // do any optimization
            if (ALNext.LineLabel = '') and
               (ALNext.Command = OP_MOV) and
               (ALNext.Args[1].Value = arg1) then
            begin
              // op reg/stack/ah, rest
              // mov anything, reg/stack/ah
              // op anything, rest
              // nop
              if IsMovOptimizationSafe(bEnhanced, AL.Command, ALNext.Args[0].Value) then
              begin
                AL.RemoveVariableReference(arg1, 0);
                tmp := ALNext.Args[0].Value;
                AL.Args[0].Value := tmp; // switch output arg (no ref count changes)
                ALNext.RemoveVariableReference(arg1, 1);
                ALNext.Command := OPS_INVALID; // no-op next line
                ALNext.Args.Clear;
                // if the variable we moved from ALNext to AL was a stack or array helper
                // then we have a little extra work to do
                if IsStackOrHelper(tmp) then
                  FixupPragmas(AL, ALNext, tmp);
                bDone := False;
                Break;
              end;
            end;
          end;

          // at higher optimization levels we'll do more here
          if level >= 3 then
          begin
            // the 0th output argument of this opcode is a temporary variable
            // (aka stack/reg/array helper)
            // so maybe we can do an optimization
            // find the next line (which may not be i+1) that refers to the
            // same temporary variable with no labeled statements
            // or branches in between
            offset := 1;
            tmpIdx := -1;
            while (i < SProProcessCode.Count - offset) do begin
              tmpAL := SProProcessCode.Items[i+offset];
              tmpIdx := -1;
              tmp := '';
              if tmpAL.LineLabel <> '' then
                Break;
              if (tmpAL.Command in [OP_BRCMP, OP_BRTST, OP_JMP]) then
                Break;
              // does this line refer to the same temporary variable?
              // prefer to find input parameters over finding output parameters
              // so we start at the last arg and work toward the first
              for j := tmpAL.Args.Count - 1 downto 0 do
              begin
                tmp := tmpAL.Args[j].Value;
                if arg1 = RootOf(tmp) then
                begin
                  tmpIdx := j;
                  Break;
                end;
              end;
              if tmpIdx <> -1 then
                Break;
              inc(offset);
            end;
            if (tmpIdx <> -1) and (i < (SProProcessCode.Count - offset)) and (arg1 = tmp) then
            begin
              ALNext := SProProcessCode.Items[i+offset];
              // now check other cases
              // bricxcc-Bugs-1669679 - make sure the next line
              // cannot be jumped to from elsewhere.  If it does then the
              // "previous" line may actually be skipped so we cannot
              // do any optimization
              if ALNext.LineLabel = '' then
              begin
                // is the next reference to this temporary variable an output
                // or is it an input?
                argDir := ArgDirection(firmVer, ALNext.Command, tmpIdx);
                if argDir = aadOutput then
                begin
                  // if the next line with no labels or branches in between uses this
                  // same temporary as an output variable then the first line
                  // can be replaced with a no-op
                  //
                  // op reg/stack/ah, rest
                  // op reg/stack/ah, rest
                  // nop
                  // op reg/stack/ah, rest
                  AL.RemoveVariableReferences;
                  RemoveOrNOPLine(AL, nil, i);
                  bDone := False;
                  Break;
                end
                else if argDir = aadInput then
                begin
                  tmp := ALNext.Args[0].Value;
                  if (ALNext.Command = OP_MOV) and (IsVolatile(tmp) or not (AL.Command in [OP_MOV, OP_SET])) then
                  begin
                    // if the next line with no labels or branches in between uses this same
                    // temporary as an input variable and it is a mov then
                    // we may be able to optimize out the mov.
                    //
                    // op reg/stack/ah, rest
                    // mov anything, reg/stack/ah
                    // op anything, rest
                    // nop
                    if IsMovOptimizationSafe(bEnhanced, AL.Command, tmp) then
                    begin
                      AL.RemoveVariableReference(arg1, 0);
                      AL.Args[0].Value := tmp; // switch output arg (no ref count changes)
                      ALNext.RemoveVariableReference(arg1, 1);
                      ALNext.Command := OPS_INVALID; // no-op next line
                      ALNext.Args.Clear;
                      // if the variable we moved from ALNext to AL was a stack or array helper
                      // then we have a little extra work to do
                      if IsStackOrHelper(tmp) then
                        FixupPragmas(AL, ALNext, tmp);
                      bDone := False;
                      Break;
                    end;
                  end
                  else if (AL.Command = OP_SET) {and ALNext.Optimizable} then
                  begin
                    // set reg/stack/ah, input
                    // op anything, reg/stack/ah
                    // set reg/stack/ah, input - we might be able to remove/nop this line
                    // op anything, input
                    tmp := CreateConstantVar(SProProgram.Dataspace, StrToIntDef(AL.Args[1].Value, 0), True);
                    // if the output of set is input of any opcode then it is safe
                    // to set the ALNext's input to AL's input
                    ALNext.RemoveVariableReference(arg1, tmpIdx);
                    ALNext.Args[tmpIdx].Value := tmp; // switch input arg (no ref count changes)
                    // We can't remove the set in case the temporary
                    // is reused as an input in subsequent lines.
                    // This restriction can be removed if we can tell that this
                    // particular temporary is never used as an input from the
                    // time it is acquired to the time it is released.
                    if IsStackOrHelper(arg1) then
                      RemoveLineIfPossible(AL, arg1);
                    bDone := False;
                    Break;
                  end
                  else if (AL.Command = OP_MOV) {and ALNext.Optimizable} then
                  begin
                    // mov reg/stack/ah, constant
                    // op anything, reg/stack/ah
                    // mov reg/stack/ah, constant - we might be able to remove/nop this line
                    // op anything, constant
                    tmp := AL.Args[1].Value;
                    if IsConstant(tmp) then
                    begin
                      SProProgram.Dataspace.FindEntryAndAddReference(tmp);
                      // if the output of set is input of any opcode then it is safe
                      // to set the ALNext's input to AL's input
                      ALNext.RemoveVariableReference(arg1, tmpIdx);
                      ALNext.Args[tmpIdx].Value := tmp; // switch input arg (no ref count changes)
                      // We can't remove the set in case the temporary
                      // is reused as an input in subsequent lines.
                      // This restriction can be removed if we can tell that this
                      // particular temporary is never used as an input from the
                      // time it is acquired to the time it is released.
                      if IsStackOrHelper(arg1) then
                        RemoveLineIfPossible(AL, arg1);
                      bDone := False;
                      Break;
                    end;
                  end;
                end;
              end;
            end;

          end;

        end;
      end;

      // this next set of optimizations are organized by opcode
      // 1. set or mov
      // 2. add, sub, mul div, mod, and, or, xor, asl, asr
      // 3. neg, not
      // 4. jmp, brcmp, brtst

      case AL.Command of
        OP_SET, OP_MOV : begin
          // this is a set or mov line
{
          // first check reference count of output variable
          if not CheckReferenceCount then
          begin
            bDone := False;
            Break;
          end;
}
          if AL.Args[0].Value = AL.Args[1].Value then
          begin
            // set|mov X, X <-- replace with nop or delete
            AL.RemoveVariableReferences;
            RemoveOrNOPLine(AL, nil, i);
            bDone := False;
            Break;
          end;
          arg1 := AL.Args[0].Value;
          // find the next line (which may not be i+1) that is not (NOP or labeled)
          offset := 1;
          while (i < SProProcessCode.Count - offset) do begin
            tmpAL := SProProcessCode.Items[i+offset];
            if tmpAL.LineLabel <> '' then
              Break
            else if tmpAL.Command <> OPS_INVALID then
            begin
              // is it safe to ignore this line?  If it is a set or a mov for
              // different variables then yes (at higher optimization levels) ...
              // (this is not always safe AKA buggy)
              if not ((tmpAL.Command in [OP_SET, OP_MOV]) and
                      (arg1 <> tmpAL.Args[0].Value) and
                      (arg1 <> tmpAL.Args[1].Value) and
                      (level >= 5)) then
                Break;
            end;
            inc(offset);
          end;
          // every line between Items[i] and Items[i+offset] are NOP lines without labels.
          // OR unlabeled set|mov opcodes that have nothing whatsoever to do with the
          // output variable in Items[i]
          if i < (SProProcessCode.Count - offset) then
          begin
            ALNext := SProProcessCode.Items[i+offset];
            // now check other cases
            // bricxcc-Bugs-1669679 - make sure the next line
            // cannot be jumped to from elsewhere.  If it does then the
            // "previous" line may actually be skipped so we cannot
            // do any optimization
            if ALNext.LineLabel = '' then
            begin


              case ALNext.Command of
                OP_SET, OP_MOV : begin
                  if ALNext.Args[0].Value = AL.Args[0].Value then begin
                    // set|mov X, whatever
                    // set|mov X, whatever <-- replace these two lines with
                    // nop  (or delete line)
                    // set|mov X, whatever
                    AL.RemoveVariableReferences;
                    RemoveOrNOPLine(AL, ALNext, i);
                    bDone := False;
                    Break;
                  end
                  else begin
                    arg1 := AL.Args[0].Value;
                    arg2 := ALNext.Args[1].Value;
                    if (arg1 = arg2) then begin
                      // set|mov __D0,whatever   (__D0 or __stack_nnn)
                      // mov X,__D0 <-- replace these two lines with
                      // nop  (if arg1 and arg2 are stack or register variables)
                      // mov X,whatever
                      if AL.Command = OP_SET then
                        tmp := CreateConstantVar(SProProgram.Dataspace, StrToIntDef(AL.Args[1].Value, 0), True)
                      else
                      begin
                        tmp := AL.Args[1].Value;
                        SProProgram.Dataspace.FindEntryAndAddReference(tmp);
                      end;
                      ALNext.Command := OP_MOV;
                      ALNext.Args[1].Value := tmp;
{
                      ALNext.Command := AL.Command;
                      ALNext.Args[1].Value := AL.Args[1].Value;
}
                      ALNext.RemoveVariableReference(arg2, 1);
                      if IsVolatile(arg1) then
                      begin
                        // remove second reference to _D0
                        AL.RemoveVariableReferences;
//                        AL.RemoveVariableReference(arg1, 0);
                        RemoveOrNOPLine(AL, ALNext, i);
                      end;
                      bDone := False;
                      Break;
                    end;
                  end;
                end;
                OPS_WAITV, OPS_WAITV_2 : begin
                  // these two opcodes are only present if EnhancedFirmware is true
                  arg1 := AL.Args[0].Value;
                  arg2 := ALNext.Args[0].Value;
                  if (arg1 = arg2) then begin
                    // set|mov __D0,whatever  (__D0 or __stack_nnn)
                    // waitv __D0 <-- replace these two lines with
                    // nop (if arg1 and arg2 are stack or register variables)
                    // waitv|wait whatever
                    ALNext.Args[0].Value := AL.Args[1].Value;
                    ALNext.RemoveVariableReference(arg2, 0);
                    if AL.Command = OP_SET then
                    begin
                      if SProProgram.FirmwareVersion > MAX_FW_VER1X then
                        ALNext.Command := OPS_WAITI_2
                      else
                        ALNext.Command := OP_WAIT;
                    end;
                    SProProgram.Dataspace.FindEntryAndAddReference(ALNext.Args[0].Value);
                    if IsVolatile(arg1) then
                    begin
                      // remove second reference to _D0
                      AL.RemoveVariableReferences;
//                      AL.RemoveVariableReference(arg1, 0);
                      RemoveOrNOPLine(AL, ALNext, i);
                    end;
                    bDone := False;
                    Break;
                  end;
                end;
                OP_ADD, OP_SUB, OP_MUL, OP_DIV, OP_MOD, OP_AND, OP_OR, OP_XOR,
                OP_LSL, OP_LSR, OP_ASL, OP_ASR : begin
                  arg1 := AL.Args[0].Value;
                  arg2 := ALNext.Args[2].Value;
                  arg3 := ALNext.Args[1].Value;
                  if (arg1 = arg2) or (arg1 = arg3) then begin
                    // set|mov __D0,X
                    // arithop A, B, __D0 <-- replace these two lines with
                    // nop
                    // arithop A, B, X
                    if AL.Command = OP_SET then
                      tmp := CreateConstantVar(SProProgram.Dataspace, StrToIntDef(AL.Args[1].Value, 0), True)
                    else
                    begin
                      // increment the reference count of this variable
                      tmp := AL.Args[1].Value;
                      SProProgram.Dataspace.FindEntryAndAddReference(tmp);
                    end;
                    if (arg1 = arg2) then begin
                      ALNext.Args[2].Value := tmp;
                      ALNext.RemoveVariableReference(arg2, 2);
                    end
                    else begin  // arg1=arg3 (aka ALNext.Args[1].Value)
                      ALNext.Args[1].Value := tmp;
                      ALNext.RemoveVariableReference(arg3, 1);
                    end;
                    if IsVolatile(arg1) then
                    begin
                      // remove second reference to _D0
                      AL.RemoveVariableReferences;
//                      AL.RemoveVariableReference(arg1, 0);
                      RemoveOrNOPLine(AL, ALNext, i);
                    end;
                    bDone := False;
                    Break;
                  end;
                end;
                OP_NEG, OP_NOT : begin
                  arg1 := AL.Args[0].Value;
                  arg2 := ALNext.Args[1].Value;
                  if arg1 = arg2 then begin
                    // set|mov __D0,X
                    // neg|not A, __D0 <-- replace these two lines with
                    // nop
                    // neg|not A, X
                    if AL.Command = OP_SET then
                      tmp := CreateConstantVar(SProProgram.Dataspace, StrToIntDef(AL.Args[1].Value, 0), True)
                    else
                    begin
                      tmp := AL.Args[1].Value;
                      SProProgram.Dataspace.FindEntryAndAddReference(tmp);
                    end;
                    ALNext.Args[1].Value := tmp;
                    ALNext.RemoveVariableReference(arg2, 1);
                    if IsVolatile(arg1) then
                    begin
                      // remove second reference to _D0
                      AL.RemoveVariableReference(arg1, 0);
                      RemoveOrNOPLine(AL, ALNext, i);
                    end;
                    bDone := False;
                    Break;
                  end;
                end;
              else
                // nothing
              end;
            end;
          end;
        end;
        OP_ADD, OP_SUB, OP_MUL, OP_DIV, OP_MOD, OP_AND, OP_OR, OP_XOR, OP_ASL, OP_ASR : begin
{
          // first check reference count of output variable
          if not CheckReferenceCount then
          begin
            bDone := False;
            Break;
          end;
}
          if level >= 4 then
          begin
            // process argument 1
            // is it a constant variable (i.e., aname == _constVal...)
            arg1 := AL.Args[1].Value;
            Arg1Val := 0;
            bArg1Numeric := GetArgValue(SProProgram.Calc, arg1, Arg1Val);
            // now process argument 2
            arg2 := AL.Args[2].Value;
            Arg2Val := 0;
            bArg2Numeric := GetArgValue(SProProgram.Calc, arg2, Arg2Val);
            // ready to process
            if bArg1Numeric and bArg2Numeric then
            begin
              if (AL.Command in [OP_ADD, OP_SUB, OP_MUL, OP_DIV]) or
                 ((Trunc(Arg1Val) = Arg1Val) and (Trunc(Arg2Val) = Arg2Val)) then
              begin
                // both arguments are numeric
                AL.RemoveVariableReference(arg1, 1);
                AL.RemoveVariableReference(arg2, 2);
                case AL.Command of
                  OP_ADD : iVal := Arg1Val + Arg2Val;
                  OP_SUB : iVal := Arg1Val - Arg2Val;
                  OP_MUL : iVal := Arg1Val * Arg2Val;
                  OP_DIV : iVal := Arg1Val / Arg2Val;
                  OP_MOD : iVal := Trunc(Arg1Val) mod Trunc(Arg2Val);
                  OP_AND : iVal := integer(Trunc(Arg1Val) and Trunc(Arg2Val));
                  OP_OR  : iVal := integer(Trunc(Arg1Val) or  Trunc(Arg2Val));
                  OP_XOR : iVal := integer(Trunc(Arg1Val) xor Trunc(Arg2Val));
                  OP_ASL : iVal := integer(Trunc(Arg1Val) shl Trunc(Arg2Val));
                  OP_ASR : iVal := integer(Trunc(Arg1Val) shr Trunc(Arg2Val));
                else
                  iVal := 0;
                end;
                // arithop X, N1, N2 <-- replace this line with
                // set|mov X, N (where N = N1 arithop N2)
                ConvertToSetOrMov(SProProgram.Dataspace, AL, iVal, arg1);
                AL.Args.Delete(2);
                AL.Args[1].Value := arg1;
                bDone := False;
                Break;
              end;
            end;
          end;
        end;
        OP_NEG, OP_NOT : begin
{
          // first check reference count of output variable
          if not CheckReferenceCount then
          begin
            bDone := False;
            Break;
          end;
}
          if level >= 4 then
          begin
            // process argument 1
            // is it a constant variable (i.e., aname == _constVal...)
            arg1 := AL.Args[1].Value;
            bArg1Numeric := GetArgValue(SProProgram.Calc, arg1, Arg1Val);
            // ready to process
            if bArg1Numeric and ((AL.Command = OP_NEG) or (Trunc(Arg1Val) = Arg1Val)) then
            begin
              // the argument is numeric
              AL.RemoveVariableReference(arg1, 1);
              case AL.Command of
                OP_NEG : iVal := Arg1Val * -1;
                OP_NOT : iVal := integer(not boolean(Trunc(Arg1Val)));
              else
                iVal := 0;
              end;
              // neg|not X, N1 <-- replace this line with
              // set|mov X, N (where N = neg|not N1 )
              ConvertToSetOrMov(SProProgram.Dataspace, AL, iVal, arg1);
              AL.Args[1].Value := arg1;
              bDone := False;
              Break;
            end;
          end;
        end;
        OP_JMP, OP_BRCMP, OP_BRTST : begin
          // if this line is a some kind of jump statement and the destination is the very next line that
          // is not a no-op then it can be optimized.
          if AL.Command = OP_JMP then
          begin
            arg1 := AL.Args[0].Value; // first argument is label
          end
          else // if AL.Command in [OP_BRCMP, OP_BRTST] then
          begin
            arg1 := AL.Args[1].Value; // second argument is label
          end;
          // find the next line (which may not be i+1) that is not (NOP or labeled)
          offset := 1;
          while (i < SProProcessCode.Count - offset) do begin
            tmpAL := SProProcessCode.Items[i+offset];
            if (tmpAL.Command <> OPS_INVALID) or (tmpAL.LineLabel <> '') then
              Break;
            inc(offset);
          end;
          // every line between Items[i] and Items[i+offset] are NOP lines without labels.
          if i < (SProProcessCode.Count - offset) then
          begin
            ALNext := SProProcessCode.Items[i+offset];
            // if the next line has a label == to arg1 then we can delete the current line
            if ALNext.LineLabel = arg1 then
            begin
              AL.RemoveVariableReferences;
              RemoveOrNOPLine(AL, ALNext, i);
              RemoveUnusedLabels;
              bDone := False;
              Break;
            end;
          end;
        end;
      else
        // nothing
      end;
    end;
  end;
*)
end;

function TSProProcess.GetCallerCount: Byte;
begin
  Result := Byte(fCallers.Count);
end;

procedure TSProProcess.RemoveUnusedLabels;
var
  i : integer;
  AL : TSPMLine;
  SL : TStringList;
begin
  // first gather a list of jump targets in this clump
  SL := TStringList.Create;
  try
    SL.Sorted := True;
    SL.Duplicates := dupIgnore;
    for i := 0 to SProProcessCode.Count - 1 do begin
      AL := SProProcessCode.Items[i];
      if AL.Command = OP_JMP then
      begin
        SL.Add(AL.Args[0].Value); // first argument is label
      end
      else if AL.Command in [OP_BRCMP, OP_BRTST] then
      begin
        SL.Add(AL.Args[1].Value); // second argument is label
      end;
    end;
    for i := 0 to SProProcessCode.Count - 1 do begin
      AL := SProProcessCode.Items[i];
      if SL.IndexOf(AL.LineLabel) = -1 then
        AL.LineLabel := '';
    end;
  finally
    SL.Free;
  end;
end;

procedure TSProProcess.RemoveUnusedPragmas;
var
  i : integer;
  tmp : string;
begin
  // now strip out all the #pragma acquire and #pragma release lines
  for i := SProProcessCode.Count - 1 downto 0 do
  begin
    tmp := SProProcessCode.Items[i].AsString;
    if (Pos('#pragma acquire(', tmp) <> 0) or (Pos('#pragma release(', tmp) <> 0) then
    begin
      SProProcessCode.Delete(i);
    end;
  end;
end;

procedure TSProProcess.FixupPragmas(line1, line2: TSPMLine; const arg : string);
var
  tmpAL : TSPMLine;
  tmp : string;
begin
  // find the #pragma acquire for this variable prior to ALNext
  tmpAL := line2;
  while tmpAL.Index > line1.Index do begin
    if (tmpAL.Command = OPS_INVALID) then
    begin
      tmp := tmpAL.AsString;
      if (Pos('#pragma', tmp) > 0) and (Pos(arg, tmp) > 0) then
      begin
        // move this line before line1
        tmpAL.Index := line1.Index - 1;
      end;
    end;
    if tmpAL.Index > 0 then
      tmpAL := SProProcessCode.Items[tmpAL.Index - 1]
    else
      break;
  end;
end;

procedure TSProProcess.RemoveLineIfPossible(line: TSPMLine; const arg: string);
var
  tmpAL : TSPMLine;
  acqIdx, relIdx, i, j : integer;
  tmp : string;
  bCanDeleteLine : boolean;
begin
  acqIdx := -1;
  relIdx := -1;
  // search backward to find where this variable is acquired
  tmpAL := line;
  while tmpAL.Index > 0 do
  begin
    if tmpAL.Command = OPS_INVALID then
    begin
      tmp := Trim(tmpAL.AsString);
      if tmp = '#pragma acquire('+arg+')' then
      begin
        acqIdx := tmpAL.Index;
        break;
      end;
    end;
    tmpAL := SProProcessCode.Items[tmpAL.Index - 1];
  end;
  // now search forward to find where this variable is released
  tmpAL := line;
  while tmpAL.Index < SProProcessCode.Count - 1 do
  begin
    if tmpAL.Command = OPS_INVALID then
    begin
      tmp := Trim(tmpAL.AsString);
      if tmp = '#pragma release('+arg+')' then
      begin
        relIdx := tmpAL.Index;
        break;
      end;
    end;
    tmpAL := SProProcessCode.Items[tmpAL.Index + 1];
  end;
  if (acqIdx <> -1) and (relIdx <> -1) and (relIdx > acqIdx) then
  begin
    bCanDeleteLine := True;
    // search within this acquire/release pair for a line other than the current
    // line that uses this variable as an input argument
    for i := acqIdx + 1 to relIdx - 1 do
    begin
      tmpAL := SProProcessCode.Items[i];
      if tmpAL = line then
        Continue;
      // prefer to find input parameters over finding output parameters
      // so we start at the last arg and work toward the first
      for j := tmpAL.Args.Count - 1 downto 0 do
      begin
        if (arg = tmpAL.Args[j].Value) and
           (SProArgDirection(tmpAL.Command, j) = sadInput) then
        begin
          bCanDeleteLine := False;
          Break;
        end;
      end;
      if not bCanDeleteLine then
        break;
    end;
    if bCanDeleteLine then
      RemoveOrNOPLine(line, nil, line.Index);
  end;
end;

{ TSProProcessCode }

function TSProProcessCode.Add: TSPMLine;
begin
  Result := TSPMLine(inherited Add);
end;

constructor TSProProcessCode.Create(aSProProcess : TSProProcess);
begin
  inherited Create(TSPMLine);
  fSProProcess := aSProProcess;
end;

destructor TSProProcessCode.Destroy;
begin

  inherited;
end;

function TSProProcessCode.GetItem(Index: Integer): TSPMLine;
begin
  Result := TSPMLine(inherited GetItem(Index));
end;

procedure TSProProcessCode.HandleNameToAddress(const aName: string; var aAddress: integer);
begin
  aAddress := 0;
  if Assigned(fOnNameToAddress) then
    fOnNameToAddress(aName, aAddress);
end;

procedure TSProProcessCode.SetItem(Index: Integer; const Value: TSPMLine);
begin
  inherited SetItem(Index, Value);
end;

{ TSPMArg }

constructor TSPMArg.Create(Collection: TCollection);
begin
  inherited;
  fAddress  := -1;
  fValue    := '';
  fIndirect := False;
end;

function TSPMArg.Evaluate(Calc: TNBCExpParser): Extended;
begin
  Calc.Expression := Value;
  Result := Calc.Value;
end;

function TSPMArg.GetAddress: integer;
begin
  Result := fAddress;
end;

function TSPMArg.GetValue: string;
begin
  Result := fValue;
  if fIndirect then
    Result := '(' + Result + ')';
end;

procedure TSPMArg.SetValue(const aValue: string);
begin
  fAddress := -1;
  fValue   := aValue;
  fIndirect := Pos('(', aValue) = 1;
  if fIndirect then
  begin
    System.Delete(fValue, 1, 1); // remove the '('
    System.Delete(fValue, Length(fValue), 1); // remove the ')'
  end;
end;

{ TIntegerObject }

constructor TIntegerObject.Create(aValue: Integer);
begin
  fValue := aValue;
end;

end.