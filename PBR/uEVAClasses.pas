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
 * Portions created by John Hansen are Copyright (C) 2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uEVAClasses;

{$B-}

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, Contnrs, SysUtils, uPreprocess, uCompCommon;

type
  TSProOpCode = Word;
  TSProArgType = (satConstant, satPC, satSlot, satChar, satAddress, satString, satNone);
  TSProArgDir = (sadInput, sadOutput, sadBoth, sadNeither);
  TOpcodeType = (ot0, ot1, ot2, ot3, ot4, ot5, ot6, ot7, ot8, ot9, ot10);

  CodeArray = array of Word;

  TDSObject = class
  private
    function GetInUse: boolean;
  protected
    fName : string;
    fAddress : Word;
    fCount : Word;
    fRefCount: Word;
  public
    constructor Create(const aName : string; const aAddress, aCount : Word);
    procedure AddRef;
    procedure Release;
    function AsString : string;
    property Name : string read fName;
    property Address : Word read fAddress write fAddress;
    property Count : Word read fCount;
    property ReferenceCount : Word read fRefCount;
    property InUse : boolean read GetInUse;
  end;

  TCodeSpaceAry = class
  public
    Code : CodeArray;
    function CodespaceCount : Word;
    procedure SaveToStream(aStream : TStream);
  end;

  TSPMLine = class;

  TSPMArg = class(TCollectionItem)
  private
    fValue: string;
    fAddress: integer;
    fIndirect: boolean;
    function GetEncoding: word;
    function GetNumericValue: Integer;
    function GetLine: TSPMLine;
  protected
    procedure SetValue(const aValue: string);
    function  GetValue : string;
    function  GetAddress: integer;
    function GetAsString: string;
  public
    constructor Create(Collection: TCollection); override;
    function Evaluate(Calc : TCCExpParser) : Extended;
    property Value : string read GetValue write SetValue;
    property Address : Integer read GetAddress;
    property Indirect : boolean read fIndirect write fIndirect;
    property Encoding : word read GetEncoding;
    property AsString : string read GetAsString;
    property NumericValue : Integer read GetNumericValue;
    property Line : TSPMLine read GetLine;
  end;

  TOnNameToAddress = procedure(const aName : string; var aAddress : integer) of object;

  TSPMArguments = class(TCollection)
  private
    fOwner : TSPMLine;
    function GetItem(Index: Integer): TSPMArg;
    procedure SetItem(Index: Integer; const Value: TSPMArg);
    function GetAsString: string;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(aOwner : TSPMLine);
    function  Add: TSPMArg;
    function Insert(Index: Integer): TSPMArg;
    property  Items[Index: Integer]: TSPMArg read GetItem write SetItem; default;
    property  AsString : string read GetAsString;
    property  Line : TSPMLine read fOwner;
  end;

  TSProProgram = class;

  TSPMLine = class(TCollectionItem)
  private
    fOpType: TOpcodeType;
    procedure SetOpCode(const Value: TSProOpcode);
    function GetComStr: string;
    procedure SetComStr(const Value: string);
    procedure ChunkLine(line: string; var lbl, opcode, args: string);
    function GetOpType: TOpcodeType;
  protected
    fCode : CodeArray;
    fComment: string;
    fLabel: string;
    fArgs: TSPMArguments;
    fOpCode: TSProOpcode;
    fOpStr : string;
    fLineNum: integer;
    fInstrSize : integer;
    fStartAddress : integer;
    fSpecial : boolean;
    fSpecialValue : string;
    fComments : string;
    procedure EncodeType1;
    procedure EncodeType2;
    procedure EncodeType3;
    procedure EncodeType4;
    procedure EncodeType5;
    procedure EncodeType6;
    procedure EncodeType7;
    procedure EncodeType8;
    procedure EncodeType9;
    procedure EncodeType10;
    procedure RemoveVariableReference(const arg: string; const idx: integer);
    procedure RemoveVariableReferences;
    procedure FinalizeCode;
    procedure SetPC(const Value: word);
    function  GetAsString: string;
    procedure SetAsString(const Value: string);
    function  GetSProProgram: TSProProgram;
    function  GetPC: word;
    function GetOptimizable: boolean;
    procedure SetArgs(const Value: TSPMArguments);
    function  IsLabel(const name : string; var aPC : Word) : boolean;
    procedure HandleNameToAddress(const name: string; var aAddress: integer);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure AddArgs(sargs : string);
    function InstructionSize : integer;
    procedure SaveToCode(var Store: CodeArray);
    property LineLabel : string read fLabel write fLabel;
    property Command : TSProOpcode read fOpCode write SetOpCode;
    property CommandString : string read GetComStr write SetComStr;
    property OpType : TOpcodeType read GetOpType write fOpType;
    property Args : TSPMArguments read fArgs write SetArgs;
    property Comment : string read fComment write fComment;
    property LineNum : integer read fLineNum write fLineNum;
    property ProgramCounter : word read GetPC write SetPC;
//    property SProProcessCode : TSProProcessCode read GetSProProcessCode;
//    property SProProcess : TSProProcess read GetSProProcess;
    property SProProgram : TSProProgram read GetSProProgram;
    property StartAddress : integer read fStartAddress;
    property AsString : string read GetAsString write SetAsString;
    property Optimizable : boolean read GetOptimizable;
  end;

  TProcessObject = class
  private
    fLast: TSPMLine;
    fFirst: TSPMLine;
    fRefCount : integer;
    fProcessName: string;
    fProg : TSProProgram;
    function GetInUse: boolean;
    function GetItems(aIndex: integer): TSPMLine;
  public
    constructor Create(aProg : TSProProgram);
    procedure AddRef;
    procedure Release;
    procedure Optimize(level : integer);
    function  Count : integer;
    property Items[aIndex : integer] : TSPMLine read GetItems; default;
    property ProcessName : string read fProcessName write fProcessName;
    property FirstLine : TSPMLine read fFirst write fFirst;
    property LastLine : TSPMLine read fLast write fLast;
    property ReferenceCount : integer read fRefCount;
    property InUse : boolean read GetInUse;
    property SProProgram : TSProProgram read fProg;
  end;

  TSProProgram = class(TCollection)
  private
    fCode : TCodeSpaceAry;
    fBaseDO : word;
    fDataOrigin : word;
    fCurrentProcess : TProcessObject;
    fOnNameToAddress: TOnNameToAddress;
    fCalc: TCCExpParser;
    fCaseSensitive : Boolean;
//    fDS: TDataspace;
    fOnCompilerStatusChange: TCompilerStatusChangeEvent;
    fOptimizeLevel: integer;
    fLineCounter: integer;
    fSkipCount : integer;
    fCurrentFile: string;
    fNQCStyleList: boolean;
    function GetCaseSensitive: boolean;
    procedure SetCaseSensitive(const Value: boolean);
    procedure BuildReferences;
    procedure DoCompilerStatusChange(const Status: string; const bDone: boolean = False);
    procedure FinalizeDependencies;
    procedure SetDataOrigin(const Value: Word);
    function GetCompilerOutput: TStrings;
    function GetSymbolTable: TStrings;
    procedure MoveProcess(aFrom, aTo : TProcessObject);
    procedure RemoveOrNOPLine(AL, ALNext: TSPMLine; const idx: integer);
    procedure FixupPragmas(line1, line2: TSPMLine; const arg: string);
    procedure DataspaceSort;
    procedure UpdateDataspaceAddresses;
    function GetAsString: string;
  protected
    fCodeOrigin : Word;
    fBadProgram : boolean;
    fCompilerOutput : TStrings;
    fSymbolTable : TStrings;
    fInitName: string;
    fAddresses : TObjectList;
    fProcesses : TObjectList;
    fDataSpecifiers : TStringList;
    fSortedDS : TStringList;
    fLabelMap : TStringList;
    function  GetItem(aIndex: Integer): TSPMLine;
    procedure SetItem(aIndex: Integer; const aValue: TSPMLine);
    procedure FinalizeAddresses;
    function  GetAddress(aIndex: Integer): Word;
    procedure HandleNameToAddress(const aName : string; var aAddress : integer);
    procedure RemoveUnusedLabels;
    procedure RemoveUnusedPragmas;
    procedure SaveDataSpecifiers(aStrings: TStrings);
    procedure DataspaceCompact;
    procedure ClearDataSpecifiers;
    procedure ClearAllContainers;
    procedure RemoveReferences(PO : TProcessObject);
    procedure AddLabel(const lbl: string; Line: TSPMLine);
    function AsmLineFromLabelIndex(const idx: integer): TSPMLine;
    function IndexOfLabel(const lbl: string): integer;
    procedure SaveToCodeArray;
    procedure UpdateAddresses;
    function CodeSize : integer;
    procedure CheckSiblingsAndAddRefIfNeeded(const aName : string);
    function AddressOfDataSpecifier(const aName : string) : Word;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddASMLine(const aLine : string);
    function  Add: TSPMLine;
    function Insert(Index: Integer): TSPMLine;
    procedure InsertASMLine(const Index : Integer; const aLine : string);
    procedure AddProcess(const aName : string);
    procedure EndProcess;
    procedure AddDataSpecifier(const aName : string; const cnt : word; addr : integer = -1);
    function  FindDataSpecifierByName(const aName : string) : TDSObject;
    function  FindProcessByName(const aName : string) : TProcessObject;
    procedure AddProcessReferenceIfPresent(const aName : string);
    procedure AddDataSpecifierReferenceIfPresent(const aName : string);
    procedure Compact;
    procedure DeleteProcess(PO : TProcessObject);
    procedure Optimize(const level : Integer);
(*
    procedure RemoveReferenceIfPresent(const aName : string);
    procedure SaveToSymbolTable(aStrings: TStrings);
*)
    procedure SaveToStrings(aStrings: TStrings);
    function  SaveToStream(aStream: TStream): boolean;
    function  LoadFromBinaryStream(aStream: TStream) : boolean;
    function  LoadFromBinaryFile(const aFilename: string) : boolean;
    function  LoadFromStrings(aStrings: TStrings) : boolean;
    function  LoadFromFile(aFilename : string) : boolean;
    property  AsString : string read GetAsString;
    property  Items[aIndex: Integer]: TSPMLine read GetItem write SetItem; default;
    property  StartingAddresses[aIndex: Integer] : Word read GetAddress;
    property  InitialSProProcessName : string read fInitName write fInitName;
    property  Calc : TCCExpParser read fCalc write fCalc;
    property  OnNameToAddress : TOnNameToAddress read fOnNameToAddress write fOnNameToAddress;
    property  OnCompilerStatusChange : TCompilerStatusChangeEvent read fOnCompilerStatusChange write fOnCompilerStatusChange;
    property  CaseSensitive : boolean read GetCaseSensitive write SetCaseSensitive;
//    property  Dataspace : TDataspace read fDS;
    property  DataOrigin : Word read fDataOrigin write SetDataOrigin;
    property  SymbolTable : TStrings read GetSymbolTable;
    property  CompilerOutput : TStrings read GetCompilerOutput;
    property  CurrentProcess : TProcessObject read fCurrentProcess;
    property  OptimizeLevel : integer read fOptimizeLevel write fOptimizeLevel;
    property  LineCounter : integer read fLineCounter write fLineCounter;
    property  CurrentFile : string read fCurrentFile write fCurrentFile;
    property  NQCStyleListing : boolean read fNQCStyleList write fNQCStyleList;
  end;

  TRBFDumper = class
  private
    fFirmwareVersion: word;
  public
    property FirmwareVersion : word read fFirmwareVersion write fFirmwareVersion;
    procedure LoadFromFile(filename : string);
    procedure Decompile(output : TStrings);
  end;

implementation

uses
  uLocalizedStrings, uUtilities, uStreamRW, uCommonUtils;

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
    OpType : TOpcodeType;
    Name : string;
  end;

  PSProInstruction = ^SProInstruction;

const
// TYPE1 ccccnnnn-nnnnnnnn-nnnniddd-dddddddd
  OP_MVI     = $0000; // type 1
  OP_ADI     = $1000; // type 1
  OP_SBI     = $2000; // type 1
  OP_MUI     = $3000; // type 1
  OP_DVI     = $4000; // type 1
  OP_ANI     = $5000; // type 1
  OP_ORI     = $6000; // type 1
  OP_XRI     = $7000; // type 1

// TYPE2 cccccccc-ssssssss-isssiddd-dddddddd
  OP_MOV     = $8000; // type 2
  OP_ADD     = $8100; // type 2
  OP_SUB     = $8200; // type 2
  OP_MUL     = $8300; // type 2
  OP_DIV     = $8400; // type 2
  OP_AND     = $8500; // type 2
  OP_OR      = $8600; // type 2
  OP_XOR     = $8700; // type 2

// TYPE3 cccccccc-cccccccc-0000iddd-dddddddd
  OP_TST     = $8E00; // type 3
  OP_INC     = $8E01; // type 3
  OP_DEC     = $8E02; // type 3
  OP_COM     = $8E03; // type 3
  OP_NEG     = $8E04; // type 3
  OP_CLR     = $8E05; // type 3
  OP_RLC     = $8E0C; // type 3
  OP_RRC     = $8E0D; // type 3
  OP_PUSH    = $8E0E; // type 3
  OP_POP     = $8E0F; // type 3
  OP_TRND    = $8E10; // type 3
  OP_TRNH    = $8E11; // type 3
  OP_TRNS    = $8E12; // type 3
  OP_SQRT    = $8E13; // type 3
  OP_LOG     = $8E14; // type 3
  OP_READ    = $8E15; // type 3

// TYPE4 cccccccc-cccccccn-nnnniddd-dddddddd
  OP_LSL     = $8E06; // type 4
  OP_LSR     = $8E08; // type 4
  OP_ASR     = $8E0A; // type 4

// TYPE5 cccccccc-cccccccc
  OP_WAIT    = $8F00; // type 5
  OP_START   = $8F01; // type 5
  OP_RET     = $8F02; // type 5
  OP_STALL   = $8F03; // type 5
  OP_HALTME  = $8F04; // type 5
  OP_CLC     = $8F05; // type 5
  OP_INVC    = $8F06; // type 5
  OP_STC     = $8F07; // type 5
  OP_CLZ     = $8F08; // type 5
  OP_INVZ    = $8F09; // type 5
  OP_STZ     = $8F0A; // type 5
  OP_HALTALL = $8F0B; // type 5
  OP_TRSP    = $8F0C; // type 5
  OP_TRNL    = $8F0D; // type 5
  OP_TRCR    = $8F0E; // type 5
  OP_HALTEX  = $8F0F; // type 5
  OP_LINIT   = $8F10; // type 5
  OP_LOPEN   = $8F11; // type 5
  OP_LCLOSE  = $8F12; // type 5
  OP_LSTAT   = $8F13; // type 5

// TYPE6 ccccpppp-pppppppp
  OP_FORK    = $9000; // type 6
  OP_JMP     = $A000; // type 6
  OP_CALL    = $B000; // type 6
  OP_JZ      = $C000; // type 6
  OP_JP      = $D000; // type 6
  OP_JN      = $E000; // type 6
  OP_JC      = $F000; // type 6

// TYPE7 cccccccc-pppppppp
  OP_TRCH    = $8F20; // type 7 (0x20-0xFF)

// TYPE8 ccccpppp-pppppppp 1010qqqq-qqqqqqqq
  OP_JNZ     = $C000; // type 8
  OP_JNP     = $D000; // type 8
  OP_JNN     = $E000; // type 8
  OP_JNC     = $F000; // type 8

// TYPE9 cccccccc-pppppppp
  OP_TRST    = $8F21; // type 9 (string)

// TYPE10 10001110-00011ttt
  OP_SWITCH  = $8E18; // type 10

  OPS_DS         = $FFF6;
  OPS_END        = $FFF7;
  OPS_EQU        = $FFF8;
  OPS_TITLE      = $FFF9;
  OPS_SUBTTL     = $FFFA;
  OPS_ORG        = $FFFB;
  OPS_DORG       = $FFFC;
  OPS_INCLUDE    = $FFFD;
  OPS_ENDINCLUDE = $FFFE;

  OPS_INVALID    = $FFFF;


const
  SProInstructionsCount = 69+10;
  SProInstructions : array[0..SProInstructionsCount] of SProInstruction =
  (
    ( Encoding: OP_MVI     ; Arity: 2; Size: 4; OpType: ot1;  Name: 'MVI'; ),
    ( Encoding: OP_ADI     ; Arity: 2; Size: 4; OpType: ot1;  Name: 'ADI'; ),
    ( Encoding: OP_SBI     ; Arity: 2; Size: 4; OpType: ot1;  Name: 'SUI'; ),
    ( Encoding: OP_SBI     ; Arity: 2; Size: 4; OpType: ot1;  Name: 'SBI'; ),
    ( Encoding: OP_MUI     ; Arity: 2; Size: 4; OpType: ot1;  Name: 'MUI'; ),
    ( Encoding: OP_DVI     ; Arity: 2; Size: 4; OpType: ot1;  Name: 'DVI'; ),
    ( Encoding: OP_ANI     ; Arity: 2; Size: 4; OpType: ot1;  Name: 'ANI'; ),
    ( Encoding: OP_ORI     ; Arity: 2; Size: 4; OpType: ot1;  Name: 'ORI'; ),
    ( Encoding: OP_XRI     ; Arity: 2; Size: 4; OpType: ot1;  Name: 'XRI'; ),
    ( Encoding: OP_MOV     ; Arity: 2; Size: 4; OpType: ot2;  Name: 'MOV'; ),
    ( Encoding: OP_ADD     ; Arity: 2; Size: 4; OpType: ot2;  Name: 'ADD'; ),
    ( Encoding: OP_SUB     ; Arity: 2; Size: 4; OpType: ot2;  Name: 'SUB'; ),
    ( Encoding: OP_MUL     ; Arity: 2; Size: 4; OpType: ot2;  Name: 'MUL'; ),
    ( Encoding: OP_DIV     ; Arity: 2; Size: 4; OpType: ot2;  Name: 'DIV'; ),
    ( Encoding: OP_AND     ; Arity: 2; Size: 4; OpType: ot2;  Name: 'AND'; ),
    ( Encoding: OP_OR      ; Arity: 2; Size: 4; OpType: ot2;  Name: 'OR'; ),
    ( Encoding: OP_XOR     ; Arity: 2; Size: 4; OpType: ot2;  Name: 'XOR'; ),
    ( Encoding: OP_TST     ; Arity: 1; Size: 4; OpType: ot3;  Name: 'TST'; ),
    ( Encoding: OP_INC     ; Arity: 1; Size: 4; OpType: ot3;  Name: 'INC'; ),
    ( Encoding: OP_DEC     ; Arity: 1; Size: 4; OpType: ot3;  Name: 'DEC'; ),
    ( Encoding: OP_COM     ; Arity: 1; Size: 4; OpType: ot3;  Name: 'COM'; ),
    ( Encoding: OP_NEG     ; Arity: 1; Size: 4; OpType: ot3;  Name: 'NEG'; ),
    ( Encoding: OP_CLR     ; Arity: 1; Size: 4; OpType: ot3;  Name: 'CLR'; ),
    ( Encoding: OP_LSL     ; Arity: 2; Size: 4; OpType: ot4;  Name: 'LSL'; ),
    ( Encoding: OP_LSR     ; Arity: 2; Size: 4; OpType: ot4;  Name: 'LSR'; ),
    ( Encoding: OP_ASR     ; Arity: 2; Size: 4; OpType: ot4;  Name: 'ASR'; ),
    ( Encoding: OP_RLC     ; Arity: 1; Size: 4; OpType: ot3;  Name: 'RLC'; ),
    ( Encoding: OP_RRC     ; Arity: 1; Size: 4; OpType: ot3;  Name: 'RRC'; ),
    ( Encoding: OP_PUSH    ; Arity: 1; Size: 4; OpType: ot3;  Name: 'PUSH'; ),
    ( Encoding: OP_POP     ; Arity: 1; Size: 4; OpType: ot3;  Name: 'POP'; ),
    ( Encoding: OP_TRND    ; Arity: 1; Size: 4; OpType: ot3;  Name: 'TRND'; ),
    ( Encoding: OP_TRNH    ; Arity: 1; Size: 4; OpType: ot3;  Name: 'TRNH'; ),
    ( Encoding: OP_TRNS    ; Arity: 1; Size: 4; OpType: ot3;  Name: 'TRNS'; ),
    ( Encoding: OP_SQRT    ; Arity: 1; Size: 4; OpType: ot3;  Name: 'SQRT'; ),
    ( Encoding: OP_LOG     ; Arity: 1; Size: 4; OpType: ot3;  Name: 'LOG'; ),
    ( Encoding: OP_READ    ; Arity: 1; Size: 4; OpType: ot3;  Name: 'READ'; ),
    ( Encoding: OP_WAIT    ; Arity: 0; Size: 2; OpType: ot5;  Name: 'WAIT'; ),
    ( Encoding: OP_START   ; Arity: 0; Size: 2; OpType: ot5;  Name: 'START'; ),
    ( Encoding: OP_RET     ; Arity: 0; Size: 2; OpType: ot5;  Name: 'RET'; ),
    ( Encoding: OP_STALL   ; Arity: 0; Size: 2; OpType: ot5;  Name: 'STALL'; ),
    ( Encoding: OP_HALTME  ; Arity: 0; Size: 2; OpType: ot5;  Name: 'HALTME'; ),
    ( Encoding: OP_CLC     ; Arity: 0; Size: 2; OpType: ot5;  Name: 'CLC'; ),
    ( Encoding: OP_INVC    ; Arity: 0; Size: 2; OpType: ot5;  Name: 'INVC'; ),
    ( Encoding: OP_STC     ; Arity: 0; Size: 2; OpType: ot5;  Name: 'STC'; ),
    ( Encoding: OP_CLZ     ; Arity: 0; Size: 2; OpType: ot5;  Name: 'CLZ'; ),
    ( Encoding: OP_INVZ    ; Arity: 0; Size: 2; OpType: ot5;  Name: 'INVZ'; ),
    ( Encoding: OP_STZ     ; Arity: 0; Size: 2; OpType: ot5;  Name: 'STZ'; ),
    ( Encoding: OP_HALTALL ; Arity: 0; Size: 2; OpType: ot5;  Name: 'HALTALL'; ),
    ( Encoding: OP_TRSP    ; Arity: 0; Size: 2; OpType: ot5;  Name: 'TRSP'; ),
    ( Encoding: OP_TRNL    ; Arity: 0; Size: 2; OpType: ot5;  Name: 'TRNL'; ),
    ( Encoding: OP_TRCR    ; Arity: 0; Size: 2; OpType: ot5;  Name: 'TRCR'; ),
    ( Encoding: OP_HALTEX  ; Arity: 0; Size: 2; OpType: ot5;  Name: 'HALTEX'; ),
    ( Encoding: OP_LINIT   ; Arity: 0; Size: 2; OpType: ot5;  Name: 'LINIT'; ),
    ( Encoding: OP_LOPEN   ; Arity: 0; Size: 2; OpType: ot5;  Name: 'LOPEN'; ),
    ( Encoding: OP_LCLOSE  ; Arity: 0; Size: 2; OpType: ot5;  Name: 'LCLOSE'; ),
    ( Encoding: OP_LSTAT   ; Arity: 0; Size: 2; OpType: ot5;  Name: 'LSTAT'; ),
    ( Encoding: OP_SWITCH  ; Arity: 1; Size: 2; OpType: ot10; Name: 'SWITCH'; ),
    ( Encoding: OP_TRCH    ; Arity: 1; Size: 2; OpType: ot7;  Name: 'TRCH'; ),
    ( Encoding: OP_TRST    ; Arity: 1; Size: 2; OpType: ot9;  Name: 'TRST'; ),
    ( Encoding: OP_FORK    ; Arity: 1; Size: 2; OpType: ot6;  Name: 'FORK'; ),
    ( Encoding: OP_JMP     ; Arity: 1; Size: 2; OpType: ot6;  Name: 'JMP'; ),
    ( Encoding: OP_CALL    ; Arity: 1; Size: 2; OpType: ot6;  Name: 'CALL'; ),
    ( Encoding: OP_JZ      ; Arity: 1; Size: 2; OpType: ot6;  Name: 'JZ'; ),
    ( Encoding: OP_JP      ; Arity: 1; Size: 2; OpType: ot6;  Name: 'JP'; ),
    ( Encoding: OP_JN      ; Arity: 1; Size: 2; OpType: ot6;  Name: 'JN'; ),
    ( Encoding: OP_JC      ; Arity: 1; Size: 2; OpType: ot6;  Name: 'JC'; ),
    ( Encoding: OP_JNZ     ; Arity: 1; Size: 4; OpType: ot8;  Name: 'JNZ'; ),
    ( Encoding: OP_JNP     ; Arity: 1; Size: 4; OpType: ot8;  Name: 'JNP'; ),
    ( Encoding: OP_JNN     ; Arity: 1; Size: 4; OpType: ot8;  Name: 'JNN'; ),
    ( Encoding: OP_JNC     ; Arity: 1; Size: 4; OpType: ot8;  Name: 'JNC'; ),
// pseudo-opcodes
    ( Encoding: OPS_DS         ; Arity: 1; Size: 0; OpType: ot0; Name: 'DS'; ),
    ( Encoding: OPS_END        ; Arity: 0; Size: 0; OpType: ot0; Name: 'END'; ),
    ( Encoding: OPS_EQU        ; Arity: 1; Size: 0; OpType: ot0; Name: 'EQU'; ),
    ( Encoding: OPS_TITLE      ; Arity: 1; Size: 0; OpType: ot0; Name: 'TITLE'; ),
    ( Encoding: OPS_SUBTTL     ; Arity: 1; Size: 0; OpType: ot0; Name: 'SUBTTL'; ),
    ( Encoding: OPS_ORG        ; Arity: 1; Size: 0; OpType: ot0; Name: 'ORG'; ),
    ( Encoding: OPS_DORG       ; Arity: 1; Size: 0; OpType: ot0; Name: 'DORG'; ),
    ( Encoding: OPS_INCLUDE    ; Arity: 1; Size: 0; OpType: ot0; Name: 'INCLUDE'; ),
    ( Encoding: OPS_ENDINCLUDE ; Arity: 0; Size: 0; OpType: ot0; Name: 'ENDINCLUDE'; ),
    ( Encoding: OPS_INVALID    ; Arity: 0; Size: 0; OpType: ot0; Name: ''; )
  );


function IsNumeric(const Value : string): boolean;
var
  tmp : string;
  i : integer;
begin
  tmp := UpperCase(Value);
  i := Length(tmp);
  if Pos('B', tmp) = i then
  begin
    System.Delete(tmp, i, 1);
    Result := Integer(BinToIntDef(tmp, MaxInt)) <> MaxInt;
  end
  else
  begin
    if Pos('H', tmp) = i then
    begin
      System.Delete(tmp, i, 1);
      tmp := '$'+tmp;
    end
    else if Pos('0X', tmp) = 1 then
    begin
      System.Delete(tmp, 1, 2);
      tmp := '$'+tmp;
    end;
    Result := StrToIntDef(tmp, MaxInt) <> MaxInt;
  end;
end;

function IsStack(const str : string) : boolean;
begin
  Result := (Pos('__signed_stack_', str) = 1);
end;

function IsReg(const str : string) : boolean;
begin
  Result := (Pos('__D0', str) = 1);
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
    OP_TST, OP_PUSH, OP_TRND, OP_TRNH, OP_TRNS, OP_LOG : begin
      Result := satAddress;
    end;
    OP_INC, OP_DEC, OP_COM, OP_NEG, OP_CLR, OP_RLC, OP_RRC, OP_SQRT : begin
      Result := satAddress;
    end;
    OP_POP, OP_READ : begin
      Result := satAddress;
    end;
    OP_WAIT, OP_START, OP_RET, OP_STALL, OP_HALTME, OP_CLC, OP_INVC, OP_STC,
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
    OP_FORK, OP_JMP, OP_CALL, OP_JZ, OP_JP, OP_JN, OP_JC{, OP_JNZ, OP_JNP, OP_JNN, OP_JNC} : begin
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
    OP_TST, OP_PUSH, OP_TRND, OP_TRNH, OP_TRNS, OP_LOG : begin
      Result := sadInput;
    end;
    OP_INC, OP_DEC, OP_COM, OP_NEG, OP_CLR, OP_RLC, OP_RRC, OP_SQRT : begin
      Result := sadBoth;
    end;
    OP_POP, OP_READ : begin
      Result := sadOutput;
    end;
    OP_WAIT, OP_START, OP_RET, OP_STALL, OP_HALTME, OP_CLC, OP_INVC, OP_STC,
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
    OP_FORK, OP_JMP, OP_CALL, OP_JZ, OP_JP, OP_JN, OP_JC{, OP_JNZ, OP_JNP, OP_JNN, OP_JNC} : begin
      Result := sadInput;
    end;
  else
    Result := sadNeither;
  end;
end;

function IndexOfOpcode(const op: string): integer; overload;
var
  i : integer;
  pi : PSProInstruction;
begin
  Result := -1;
  for i := Low(SProInstructions) to High(SProInstructions) do
  begin
    pi := @(SProInstructions[i]);
    if pi^.Name = op then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function IndexOfOpcode(op: TSProOpCode): integer; overload;
var
  i : integer;
  pi : PSProInstruction;
begin
  Result := -1;
  for i := Low(SProInstructions) to High(SProInstructions) do
  begin
    pi := @(SProInstructions[i]);
    if pi^.Encoding = op then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function StrToOpcode(const op : string) : TSProOpCode;
var
  i : integer;
  pi : PSProInstruction;
begin
  Result := OPS_INVALID;
  for i := Low(SProInstructions) to High(SProInstructions) do
  begin
    pi := @(SProInstructions[i]);
    if pi^.Name = op then
    begin
      Result := pi^.Encoding;
      break;
    end;
  end;
end;

function OpcodeToStr(const op: TSProOpCode; const ot : TOpcodeType = ot0): string;
var
  i : integer;
  pi : PSProInstruction;
begin
  if op <> OPS_INVALID then
    Result := Format('bad op (%d)', [Ord(op)])
  else
    Result := '';
  for i := Low(SProInstructions) to High(SProInstructions) do
  begin
    pi := @(SProInstructions[i]);
    if pi^.Encoding = op then
    begin
      if (ot = ot0) or (pi^.OpType = ot) then
      begin
        Result := pi^.Name;
        break;
      end;
    end;
  end;
end;

function OpcodeType(const op: string) : TOpcodeType;
var
  i : integer;
  pi : PSProInstruction;
begin
  Result := ot0;
  for i := Low(SProInstructions) to High(SProInstructions) do
  begin
    pi := @(SProInstructions[i]);
    if pi^.Name = op then
    begin
      Result := pi^.OpType;
      break;
    end;
  end;
end;

function OpcodeSize(const op: string) : Byte;
var
  i : integer;
  pi : PSProInstruction;
begin
  Result := 0;
  for i := Low(SProInstructions) to High(SProInstructions) do
  begin
    pi := @(SProInstructions[i]);
    if pi^.Name = op then
    begin
      Result := pi^.Size;
      break;
    end;
  end;
end;

{ TIntegerObject }

constructor TIntegerObject.Create(aValue: Integer);
begin
  fValue := aValue;
end;

{ TDSObject }

procedure TDSObject.AddRef;
begin
  inc(fRefCount);
end;

function TDSObject.AsString: string;
begin
  if fCount = 0 then
    Result := fName + ' ' + Format('%3.3xH', [fAddress])
  else
    Result := fName + ' DS ' + IntToStr(fCount) + ' ; ' + Format('%3.3xH', [fAddress]);
end;

constructor TDSObject.Create(const aName : string; const aAddress, aCount: Word);
begin
  fName := aName;
  fAddress := aAddress;
  fCount := aCount;
  fRefCount := 0;
end;

function TDSObject.GetInUse: boolean;
begin
  if Name = #9'DORG' then
    Result := True
  else
    Result := ReferenceCount > 0;
end;

procedure TDSObject.Release;
begin
  dec(fRefCount);
end;

{ TSPMArg }

constructor TSPMArg.Create(Collection: TCollection);
begin
  inherited;
  fAddress  := -1;
  fValue    := '';
  fIndirect := False;
end;

function TSPMArg.Evaluate(Calc: TCCExpParser): Extended;
begin
  Calc.Expression := Value;
  Result := Calc.Value;
end;

function TSPMArg.GetAddress: integer;
var
  O : TDSObject;
begin
  if fAddress = -1 then
  begin
    if IsNumeric(Value) then
      fAddress := NumericValue
    else
    begin
      // look up the address of this variable
      O := Line.SProProgram.FindDataSpecifierByName(Value);
      if Assigned(O) then
        fAddress := O.Address
      else
        raise Exception.Create('Invalid argument: ' + Value);
    end;
    if fAddress = MaxInt then
      raise Exception.Create('Invalid argument: ' + Value);
  end;
  Result := fAddress;
end;

function TSPMArg.GetAsString: string;
begin
  Result := Value;
  if fIndirect then
    Result := '(' + Result + ')';
end;

function TSPMArg.GetEncoding: word;
begin
  Result := Address;
  if Indirect then
    Result := Result or $800;
end;

function TSPMArg.GetLine: TSPMLine;
begin
  Result := TSPMArguments(Collection).Line;
end;

function TSPMArg.GetNumericValue: Integer;
var
  tmp : string;
  i : integer;
begin
  tmp := UpperCase(Value);
  i := Length(tmp);
  if Pos('B', tmp) = i then
  begin
    System.Delete(tmp, i, 1); // get rid of the B
    Result := BinToIntDef(tmp, MaxInt);
  end
  else
  begin
    if Pos('H', tmp) = i then
    begin
      System.Delete(tmp, i, 1);
      tmp := '$'+tmp;
    end
    else if Pos('0X', tmp) = 1 then
    begin
      System.Delete(tmp, 1, 2);
      tmp := '$'+tmp;
    end;
    Result := StrToIntDef(tmp, MaxInt);
  end;
end;

function TSPMArg.GetValue: string;
begin
  Result := fValue;
end;

procedure TSPMArg.SetValue(const aValue: string);
begin
  fAddress := -1;
  fValue   := Trim(aValue);
  fIndirect := (Pos('(', fValue) = 1) and (Pos(')', fValue) = Length(fValue));
  if fIndirect then
  begin
    fValue := StripParens(fValue);
  end;
  // remove the '@' which is used by EV3 to indicate an absolute numeric address
  if Pos('@', fValue) = 1 then
    System.Delete(fValue, 1, 1);
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

constructor TSPMArguments.Create(aOwner : TSPMLine);
begin
  inherited Create(TSPMArg);
  fOwner := aOwner;
end;

function TSPMArguments.GetAsString: string;
var
  i : integer;
begin
  Result := '';
  for i := 0 to Count - 1 do
    Result := Result + Items[i].AsString + ', ';
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

{ TSPMLine }

procedure TSPMLine.AddArgs(sargs: string);
var
  i : integer;
  SL : TStringList;
  Arg : TSPMArg;
begin
  // args is a comma-separated list of opcode arguments
  // or a single quoted string
  sargs := Trim(sargs);
  if sargs = '' then Exit;
  if Command = OP_TRST then
  begin
    Arg := Args.Add;
    Arg.Value := sargs;
  end
  else
  begin
    SL := TStringList.Create;
    try
      SL.CommaText := sargs;
      for i := 0 to SL.Count - 1 do
      begin
        Arg := Args.Add;
        Arg.Value := Trim(SL[i]);
      end;
    finally
      SL.Free;
    end;
  end;
end;

constructor TSPMLine.Create(ACollection: TCollection);
begin
  inherited;
  fOpCode := OPS_INVALID;
  fOpType := ot0;
  fInstrSize := -1;
  fSpecial := False;
  fArgs := TSPMArguments.Create(Self);
end;

function TSPMLine.InstructionSize: integer;
begin
  if fInstrSize = -1 then
  begin
    fInstrSize := OpcodeSize(CommandString);
    if Command = OP_TRST then
    begin
      // instruction size of TRST depends on the length of the argument (string)
      // remaining line should just be 'text'
      fInstrSize := (Length(Args[0].Value)-2)*fInstrSize;
    end;
  end;
  Result := fInstrSize;
end;

destructor TSPMLine.Destroy;
begin
  FreeAndNil(fArgs);
  inherited;
end;

{
function TSPMLine.GetSProProcessCode: TSProProcessCode;
begin
  Result := TSProProcessCode(Collection);
end;
}

procedure TSPMLine.SetArgs(const Value: TSPMArguments);
begin
  fArgs.Assign(Value);
end;

procedure TSPMLine.HandleNameToAddress(const name: string; var aAddress: integer);
begin
//  SProProcessCode.HandleNameToAddress(name, aAddress);
end;

function TSPMLine.IsLabel(const name: string; var aPC : Word): boolean;
var
  i : integer;
  AL : TSPMLine;
begin
  aPC := 0;
  i := SProProgram.IndexOfLabel(name);
  Result := i <> -1;
  if Result then
  begin
    AL := SProProgram.AsmLineFromLabelIndex(i);
    aPC := AL.StartAddress;
  end;
end;

function TSPMLine.GetAsString: string;
begin
  if fSpecial then
  begin
    Result := fSpecialValue;
  end
  else
  begin
    Result := LineLabel;
    if Result <> '' then
      Result := Result + ':';
    if Command <> OPS_INVALID then
    begin
      Result := Result + #9;
      if (Command = OP_JZ) or (Command = OP_JN) or
         (Command = OP_JP) or (Command = OP_JC) then
        Result := Result + OpcodeToStr(Command, OpType)
      else
        Result := Result + OpcodeToStr(Command);
      Result := Result + ' ' + Args.AsString;
    end;
  end;
end;

function TSPMLine.GetSProProgram: TSProProgram;
begin
  Result := TSProProgram(Collection);
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
  DSO : TDSObject;
  PO : TProcessObject;
begin
  argType := ExpectedSProArgType(Command, idx);
  case argType of
    satAddress :
    begin
      if not IsNumeric(arg) then
      begin
        DSO := SProProgram.FindDataSpecifierByName(arg);
        if Assigned(DSO) then
          DSO.Release
        else
          raise Exception.Create('Invalid dataspace argument: ' + arg);
      end;
    end;
    satPC : begin
      if (Command = OP_FORK) or (Command = OP_CALL) then
      begin
        PO := SProProgram.FindProcessByName(arg);
        if Assigned(PO) then
          PO.Release
        else
          raise Exception.Create('Invalid process argument: ' + arg);
      end;
    end;
  end;
end;

function TSPMLine.GetPC: word;
begin
  Result := Word(StartAddress);
end;

function TSPMLine.GetOptimizable: boolean;
begin
  Result := (Command = OP_MVI) or (Command = OP_MOV) or
            (Command = OP_POP) or (Command = OP_READ);
end;

procedure TSPMLine.ChunkLine(line : string; var lbl, opcode, args : string);
var
  i : integer;
  tmp : string;
  values : TStringList;
  procedure CheckLabel(const value : string);
  begin
    i := Pos(':', value);
    if i = Length(value) then
    begin
      lbl := Copy(value, 1, i-1);
    end
    else
      raise Exception.Create('Invalid label: ' + value);
  end;
begin
  lbl := '';
  opcode := '';
  args := '';
  // break apart the line into its constituent parts
  // whitespace at the beginning and end of the line has already been trimmed.
  // trailing comments have also already been trimmed.

  // if the first word in the line is an opcode (of any kind) then
  // the label is blank and everything after the opcode is the args
  // if the first word is NOT an opcode then we assume it is a label
  // and we check the second word for whether it is an opcode or not
  // if it is not then the line is invalid.  If it is then everything after
  // the second word is the args

  values := TStringList.Create;
  try
    line := CommasToSpaces(line);
    i := JCHExtractStrings([' ', #9], [], PChar(line), values);
    if i = 1 then
    begin
      if StrToOpcode(values[0]) = OPS_INVALID then
      begin
        // if there is only one item in the line and it isn't an opcode
        // then it should be a label
        // with an required trailing ':'.  If the colon is missing then
        // the line is invalid
        CheckLabel(values[0]);
      end
      else
      begin
        lbl := '';
        opcode := values[0];
      end;
    end
    else if i = 2 then
    begin
      tmp := values[0];
      // if the first item is a known opcode then assume no label
      // exists in this line
      if StrToOpcode(values[0]) = OPS_INVALID then
      begin
        // label + opcode and no args
        CheckLabel(values[0]);
        opcode := values[1];
      end
      else
      begin
        // no label - just opcode and args
        lbl := '';
        opcode := values[0];
        values.Delete(0);
        args := Trim(values[0]);
      end;
    end
    else // i >= 3
    begin
      // if the first item is a known opcode then assume no label
      // exists in this line
      if StrToOpcode(values[0]) = OPS_INVALID then
      begin
        CheckLabel(values[0]);
        opcode := values[1];
        values.Delete(0);
        values.Delete(0);
      end
      else
      begin
        lbl := '';
        opcode := values[0];
        values.Delete(0);
      end;
      if values.Count = 1 then
        args := Trim(values[0])
      else
        args := Trim(values.CommaText);
    end;
  finally
    values.Free;
  end;
end;

procedure TSPMLine.SetAsString(const Value: string);
var
  line, {op, }lbl, opcode, argstr : string;
  i : integer;
begin
  // magic happens here
  line := Trim(Value);
  if (Pos('#line', line) = 1) or
     (Pos('#reset', line) = 1) or
     (Pos('#pragma', line) = 1) then
  begin
    fSpecial := True;
    fSpecialValue := line;
  end
  else
  begin
    // double check for a blank line since we have manipulated it
    if line <> '' then
    begin
      // go ahead and process this line as normal
      // chunk the line into its consituent parts
      ChunkLine(line, lbl, opcode, argstr);
      if lbl <> '' then
      begin
        LineLabel := lbl;
        SProProgram.AddLabel(LineLabel, Self);
      end;
      i := IndexOfOpcode(opcode);
      if i <> -1 then
      begin
        Command := SProInstructions[i].Encoding;
        OpType  := SProInstructions[i].OpType;
      end
      else
        raise Exception.Create('Unexpected opcode: ' + opcode);
      AddArgs(argstr);
      if Command = OPS_ORG then
        SProProgram.fCodeOrigin := Args[0].NumericValue;
    end;
(*
    // does this line start with a label?
    i := Pos(':', line);
    if i > 0 then
    begin
      LineLabel := Copy(line, 1, i-1);
      System.Delete(line, 1, i);
      SProProgram.AddLabel(LineLabel, Self);
    end;
    // does this line have a comment?
    i := Pos(';', line);
    if i > 0 then
    begin
      fComments := Copy(line, i, MaxInt);
      System.Delete(line, i, MaxInt);
    end;
    line := Trim(line);
    // what is left should be opcode|pseudo-opcode [args]
    line := Replace(line, #9, ' '); // replace any tabs with spaces
    i := Pos(' ', line);
    if i > 0 then
    begin
      op := Copy(line, 1, i-1);
      System.Delete(line, 1, i);
      line := Trim(line);
    end
    else
    begin
      op := line;
      line := '';
    end;
    i := IndexOfOpcode(op);
    if i <> -1 then
    begin
      Command := SProInstructions[i].Encoding;
    end
    else
      raise Exception.Create('Unexpected opcode: ' + op);
    AddArgs(line);
    if Command = OPS_ORG then
      SProProgram.fCodeOrigin := Args[0].NumericValue;
*)
  end;
end;

procedure TSPMLine.SaveToCode(var Store: CodeArray);
var
  i, len, start : integer;
begin
  if Length(fCode) = 0 then
    FinalizeCode;
  len := Length(fCode);
  start := Length(Store);
  // copy data from our local array to the passed in array
  SetLength(Store, start + len);
  for i := 0 to len - 1 do
  begin
    Store[start+i] := fCode[i];
  end;
end;

procedure TSPMLine.FinalizeCode;
begin
  case OpType of
//  case OpcodeType(CommandString) of
    ot1: EncodeType1;
    ot2: EncodeType2;
    ot3: EncodeType3;
    ot4: EncodeType4;
    ot5: EncodeType5;
    ot6: EncodeType6;
    ot7: EncodeType7;
    ot8: EncodeType8;
    ot9: EncodeType9;
    ot10: EncodeType10;
  else
    // nothing to do otherwise
  end;
end;

(*
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

function GetArgValuePart2(EP : TCCExpParser; arg1 : string; var val : Double) : boolean;
begin
  EP.SilentExpression := arg1;
  Result := not EP.ParserError;
  if Result then
    val := EP.Value
  else
    val := 0;
end;

function GetArgValue(EP : TCCExpParser; arg1 : string; var val : Double) : boolean;
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
*)

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

procedure TSPMLine.SetPC(const Value: word);
begin
  fStartAddress := Value;
end;

procedure TSPMLine.SetOpCode(const Value: TSProOpcode);
begin
  if fOpCode <> Value then
  begin
    fOpCode := Value;
    fOpStr := '';
    fOpType := ot0;
  end;
end;

procedure TSPMLine.EncodeType1;
var
  d, n : Word;
begin
  // TYPE1 ccccnnnn-nnnnnnnn-nnnniddd-dddddddd
  SetLength(fCode, 2);
  d := Args[0].Encoding;
  n := Args[1].Encoding;
  fCode[0] := Command or (n and $FFF); // lower 12 bits of n
  fCode[1] :=((HiByte(n) and $F0) shl 8) or (d and $FFF)
end;

procedure TSPMLine.EncodeType2;
var
  d, s : Word;
begin
  // TYPE2 cccccccc-ssssssss-isssiddd-dddddddd
  SetLength(fCode, 2);
  d := Args[0].Encoding;
  s := Args[1].Encoding;
  fCode[0] := Command or Byte(s); // lower 8 bits of s
  fCode[1] := ((HiByte(s) and $F) shl 12) or (d and $FFF);
end;

procedure TSPMLine.EncodeType3;
begin
  // TYPE3 cccccccc-cccccccc-0000iddd-dddddddd
  SetLength(fCode, 2);
  fCode[0] := Command;
  fCode[1] := Args[0].Encoding;
end;

procedure TSPMLine.EncodeType4;
var
  d : Word;
  n : ShortInt;
begin
  // TYPE4 cccccccc-cccccccn-nnnniddd-dddddddd
  SetLength(fCode, 2);
  d := Args[0].Encoding;
  n := Args[1].NumericValue;
  if (n > 31) or (n < 0) then
    raise Exception.Create('Invalid shift constant: ' + IntToStr(n));
  fCode[0] := Command or ((n shr 4) and $01); // 1 bit only
  fCode[1] := (n shl 12) or (d and $FFF);
end;

procedure TSPMLine.EncodeType5;
begin
  // TYPE5 cccccccc-cccccccc
  SetLength(fCode, 1);
  fCode[0] := Command;
end;

procedure TSPMLine.EncodeType6;
var
  lblpc : Word;
  lbl : string;
begin
  // TYPE6 ccccpppp-pppppppp
  SetLength(fCode, 1);
  // now lookup PC from label
  lbl := Args[0].Value;
  if not IsLabel(lbl, lblpc) then
    raise Exception.Create('Invalid label: ' + lbl);
  fCode[0] := Command or lblpc;
end;

procedure TSPMLine.EncodeType7;
var
  ch : char;
  val : string;
begin
  // TYPE7 cccccccc-pppppppp
  SetLength(fCode, 1);
  val := Args[0].Value;
  if val = '' then
    ch := ' '
  else
  begin
    if (Length(val) > 1) and (Pos('#', val) = 1) then
    begin
      System.Delete(val, 1, 1); // remove the #
      ch := Char(StrToIntDef(val, $20));
    end
    else
      ch := val[1];
  end;
  fCode[0] := (Command-$20) or Ord(ch);
end;

procedure TSPMLine.EncodeType8;
var
  lblpc : Word;
  lbl : string;
begin
  // TYPE8 ccccpppp-pppppppp 1010qqqq-qqqqqqqq
  SetLength(fCode, 2);
  // now lookup PC from label
  lbl := Args[0].Value;
  if not IsLabel(lbl, lblpc) then
    raise Exception.Create('Invalid label: ' + lbl);
  fCode[0] := Command or (ProgramCounter+2);
  fCode[1] := OP_JMP or lblpc;
end;

procedure TSPMLine.EncodeType9;
var
  s : string;
  i, len : integer;
begin
  // TYPE9 cccccccc-pppppppp
  s := StripQuotes(Args[0].Value);
  len := Length(s);
  SetLength(fCode, len);
  for i := 0 to len-1 do
    fCode[i] := (OP_TRCH-$20) or Ord(s[i+1]);
end;

procedure TSPMLine.EncodeType10;
var
  n : byte;
begin
  // TYPE10 10001110-00011ttt
  n := Args[0].NumericValue;
  if n > 6 then
    raise Exception.Create('Invalid program slot: ' + IntToStr(n));
  SetLength(fCode, 1);
  fCode[0] := Command or n;
end;

function TSPMLine.GetComStr: string;
begin
  if fOpStr = '' then
  begin
    fOpStr := OpcodeToStr(fOpCode, fOpType);
  end;
  Result := fOpStr;
end;

procedure TSPMLine.SetComStr(const Value: string);
begin
  if fOpStr <> Value then
  begin
    fOpStr := Value;
    fOpCode := StrToOpcode(Value);
  end;
end;

function TSPMLine.GetOpType: TOpcodeType;
begin
  if fOpType = ot0 then
  begin
    fOpType := OpcodeType(CommandString);
  end;
  Result := fOpType;
end;

{ TSProProgram }

function TSProProgram.Add: TSPMLine;
begin
  Result := TSPMLine(inherited Add);
end;

function TSProProgram.Insert(Index: Integer): TSPMLine;
begin
  Result := TSPMLine(inherited Insert(Index));
end;

procedure TSProProgram.BuildReferences;
var
  i, j : integer;
  AL : TSPMLine;
  sat : TSProArgType;
  O : TDSObject;
begin
  // build references
  for i := 0 to Count - 1 do
  begin
    AL := Items[i];
    if (AL.Command = OP_CALL) or (AL.Command = OP_FORK) then
    begin
      // a process name argument
      if AL.Args.Count > 0 then
        AddProcessReferenceIfPresent(AL.Args[0].Value);
    end
    else
    begin
      for j := 0 to AL.Args.Count - 1 do
      begin
        sat := ExpectedSProArgType(AL.Command, j);
        if sat = satAddress then
        begin
          AddDataSpecifierReferenceIfPresent(AL.Args[j].Value);
        end
        else if (sat = satConstant) and (AL.Command <= OP_XRI) then
        begin
          // a variable name for any of the "immediate" opcodes 2nd arg
          // still needs to be AddRefed.
          AddDataSpecifierReferenceIfPresent(AL.Args[j].Value);
        end;
      end;
    end;
  end;
  // make sure all fields in a referenced structure have at least one reference
  for i := 0 to fSortedDS.Count - 1 do
  begin
    O := TDSObject(fSortedDS.Objects[i]);
    if (O.ReferenceCount > 0) and (Pos('.', O.Name) > 0) then
      CheckSiblingsAndAddRefIfNeeded(O.Name);
  end;
end;

procedure TSProProgram.Compact;
var
  bDone : boolean;
  i : integer;
  PO : TProcessObject;
begin
  // remove any unused clumps from the codespace
  bDone := False;
  while not bDone do
  begin
    bDone := True;
    for i := 0 to fProcesses.Count - 1 do
    begin
      PO := TProcessObject(fProcesses[i]);
      if not PO.InUse then
      begin
        // remove this process from the codespace
        RemoveReferences(PO);
        DeleteProcess(PO);
        bDone := False;
        break;
      end;
    end;
  end;
end;

constructor TSProProgram.Create;
begin
  inherited Create(TSPMLine);
  fNQCStyleList := True;
  fBaseDO := $40;
  fDataOrigin := fBaseDO;
  fCodeOrigin := 0;
  fInitName := 'main';
  fAddresses := TObjectList.Create;
  fProcesses := TObjectList.Create;
  fDataSpecifiers := TStringList.Create;
  fSortedDS := TStringList.Create;
  fSortedDS.Sorted := True;
  fSortedDS.Duplicates := dupIgnore;
  fCompilerOutput := TStringList.Create;
  fSymbolTable := TStringList.Create;
  fLabelMap := TStringList.Create;
  fLabelMap.Sorted := True;
  fCode := TCodeSpaceAry.Create;
end;

destructor TSProProgram.Destroy;
begin
  FreeAndNil(fAddresses);
  FreeAndNil(fProcesses);
  ClearDataSpecifiers;
  FreeAndNil(fDataSpecifiers);
  FreeAndNil(fSortedDS);
  FreeAndNil(fCompilerOutput);
  FreeAndNil(fSymbolTable);
  FreeAndNil(fLabelMap);
  FreeAndNil(fCode);
  inherited;
end;

procedure TSProProgram.FinalizeDependencies;
var
  i : integer;
  X, O : TProcessObject;
begin
  // if there is a process called main make it the first process
  X := FindProcessByName(InitialSProProcessName);
  if Assigned(X) then
  begin
    // move to the front of the line
    i := fProcesses.IndexOf(X);
    if i <> 0 then
    begin
      O := TProcessObject(fProcesses[0]);
      fProcesses.Move(i, 0);
      MoveProcess(X, O);
    end;
  end;
//  else
//    raise Exception.Create('No task main provided');
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

function TSProProgram.GetItem(aIndex: Integer): TSPMLine;
begin
  Result := TSPMLine(inherited GetItem(aIndex));
end;

procedure TSProProgram.HandleNameToAddress(const aName: string; var aAddress: integer);
begin
  aAddress := 0;
  if Assigned(fOnNameToAddress) then
    fOnNameToAddress(aName, aAddress);
end;

procedure TSProProgram.AddProcessReferenceIfPresent(const aName: string);
var
  i : integer;
  PO : TProcessObject;
begin
  for i := 0 to fProcesses.Count - 1 do
  begin
    PO := TProcessObject(fProcesses[i]);
    if PO.ProcessName = aName then
    begin
      PO.AddRef;
      break;
    end;
  end;
end;

(*
procedure TSProProgram.RemoveReferenceIfPresent(const aName: string);
var
  i : integer;
begin
  i := IndexOf(aName);
  if i <> -1 then
    Items[i].DecRefCount;
end;
*)
procedure TSProProgram.SetCaseSensitive(const Value: boolean);
//var
//  i : integer;
begin
  fCaseSensitive := Value;
//  for i := 0 to Count - 1 do
//  begin
//    Items[i].fLabelMap.CaseSensitive := Value;
//  end;
end;

procedure TSProProgram.AddLabel(const lbl: string; Line : TSPMLine);
begin
  if IndexOfLabel(lbl) = -1 then
    fLabelMap.AddObject(lbl, Line)
  else
    raise Exception.Create('Duplicate label found: ' + lbl);
end;

function TSProProgram.IndexOfLabel(const lbl: string): integer;
begin
  Result := fLabelMap.IndexOf(lbl);
end;

function TSProProgram.AsmLineFromLabelIndex(const idx: integer): TSPMLine;
begin
  Result := TSPMLine(fLabelMap.Objects[idx]);
end;

procedure TSProProgram.SetItem(aIndex: Integer; const aValue: TSPMLine);
begin
  inherited SetItem(aIndex, aValue);
end;

procedure TSProProgram.FinalizeAddresses;
//var
//  i : integer;
//  X : TSProProcess;
//  addr : integer;
begin
  // calculate addresses for all the processes
{
  addr := 0;
  fAddresses.Clear;
  for i := 0 to Count - 1 do
  begin
    X := Items[i];
    fAddresses.Add(TIntegerObject.Create(addr));
    inc(addr, X.DataSize);
  end;
}
end;

procedure TSProProgram.DoCompilerStatusChange(const Status: string; const bDone : boolean);
begin
  if Assigned(fOnCompilerStatusChange) then
    fOnCompilerStatusChange(Self, Status, bDone);
end;

procedure TSProProgram.Optimize(const level : Integer);
var
  i : integer;
  PO : TProcessObject;
begin
  // have each process optimize itself
  for i := 0 to fProcesses.Count - 1 do
  begin
    PO := TProcessObject(fProcesses[i]);
    // skip processes starting with '__' under the assumption that
    // they are API-level (hand optimized) processes
    if Pos('__', PO.ProcessName) = 1 then
      Continue;
    DoCompilerStatusChange(Format(sOptClump, [PO.ProcessName]));
    PO.Optimize(level);
  end;
end;

procedure TSProProgram.RemoveUnusedLabels;
var
  i : integer;
  AL : TSPMLine;
  SL : TStringList;
begin
  // first gather a list of jump targets
  SL := TStringList.Create;
  try
    SL.Sorted := True;
    SL.Duplicates := dupIgnore;
    for i := 0 to Count - 1 do begin
      AL := Items[i];
      if (AL.Command >= OP_FORK) and (AL.Command <= OP_JC) then
      begin
        SL.Add(AL.Args[0].Value); // first argument is label
      end;
    end;
    for i := 0 to Count - 1 do begin
      AL := Items[i];
      if AL.LineLabel = 'main' then
        Continue;
      if SL.IndexOf(AL.LineLabel) = -1 then
        AL.LineLabel := '';
    end;
  finally
    SL.Free;
  end;
end;

procedure TSProProgram.SaveDataSpecifiers(aStrings: TStrings);
var
  i : integer;
  DS : TDSObject;
begin
  if fSortedDS.IndexOf(#9'DORG') = -1 then
    aStrings.Add(Format(#9'DORG %3.3xH', [fBaseDO]));
  for i := 0 to fDataSpecifiers.Count - 1 do
  begin
    DS := TDSObject(fDataSpecifiers.Objects[i]);
    aStrings.Add(DS.AsString);
  end;
end;

procedure TSProProgram.SaveToStrings(aStrings: TStrings);
var
  i : integer;
  AL : TSPMLine;
  tmpStr : string;
begin
  aStrings.Clear;
  // add the dataspace to the strings
  SaveDataSpecifiers(aStrings);
  // then add the code to the strings
  for i := 0 to Count - 1 do
  begin
    AL := Items[i];
    // skip blank lines
    tmpStr := AL.AsString;
    if Trim(tmpStr) <> '' then
      aStrings.Add(tmpStr);
  end;
end;

function TSProProgram.GetAsString: string;
var
  SL : TStringList;
begin
  SL := TStringList.Create;
  try
    SaveToStrings(SL);
    Result := SL.Text;
  finally
    SL.Free;
  end;
end;

function TSProProgram.SaveToStream(aStream: TStream) : boolean;
begin
//  Result := False;
  DoCompilerStatusChange(sFinalizeDepends);
  // make sure our dependencies are finalized
  FinalizeDependencies;
  DoCompilerStatusChange(sBuildRefs);
  // build references if we are optimizing
  BuildReferences;
  // possibly optimize if Optimize level > 0
  if OptimizeLevel >= 1 then
  begin
    // now proceed with optimizations
    DoCompilerStatusChange(Format(sOptimizeLevel, [OptimizeLevel]));
    DoCompilerStatusChange(sCompactCode);
    // compact the codespace before codespace optimizations
    Compact;
    DoCompilerStatusChange(sRemoveLabels);
    // also get rid of extra labels
    RemoveUnusedLabels;
    if OptimizeLevel >= 2 then
    begin
      DoCompilerStatusChange(sRunCodeOpts);
      Optimize(OptimizeLevel);
      DoCompilerStatusChange(sCompactAfterOpt);
      // after optimizations we should re-compact the codespace
      Compact;
    end;
    // also get rid of extra pragmas
    DoCompilerStatusChange(sRemovePragmas);
    RemoveUnusedPragmas;
    // after optimizing and compacting the codespace we remove
    // unused variables from the dataspace
    DoCompilerStatusChange(sCompactData);
    DataspaceCompact;
  end
  else
  begin
    // level zero (no optimizations)
    // get rid of extra labels
    DoCompilerStatusChange(sRemoveLabels);
    RemoveUnusedLabels;
    // also get rid of extra pragmas
    DoCompilerStatusChange(sRemovePragmas);
    RemoveUnusedPragmas;
    // after optimizing and compacting the codespace we remove
    // unused variables from the dataspace
    DoCompilerStatusChange(sCompactData);
    DataspaceCompact;
  end;
//  if not WarningsOff then
//    OutputUnusedItemWarnings;
  DoCompilerStatusChange(sSortDataspace);
  // sort the dataspace
  DataspaceSort;
  DoCompilerStatusChange(sFillCodeArrays);
  // fill the codespace array
  SaveToCodeArray;
  // and write everything to the stream
  aStream.Position := 0;
  DoCompilerStatusChange(sWriteCodespace);
  fCode.SaveToStream(aStream);
  Result := not fBadProgram;
  if Result then
  begin
    DoCompilerStatusChange(sWriteOptSource);
    // replace the original "compiler output" with the optimized version
    SaveToStrings(CompilerOutput);
  end;
  DoCompilerStatusChange(sFinished, True);
end;

(*
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
*)

procedure TSProProgram.RemoveUnusedPragmas;
var
  i : integer;
  tmp : string;
begin
  // now strip out all the #pragma acquire and #pragma release lines
  for i := Count - 1 downto 0 do
  begin
    tmp := Items[i].AsString;
    if (Pos('#pragma acquire(', tmp) <> 0) or (Pos('#pragma release(', tmp) <> 0) then
    begin
      Delete(i);
    end;
  end;
end;

procedure TSProProgram.AddProcess(const aName: string);
var
  proc : TProcessObject;
begin
// add this process name to a list.  Mark it as the current process.
// keep track of the start line number for this process and
// then the last line number for this process (the HALTME or RET instruction)
  proc := TProcessObject.Create(Self);
  fProcesses.Add(proc);
  proc.ProcessName := aName;
  proc.FirstLine := Items[Count-1]; // index of first line for this process
  fCurrentProcess := proc;
end;

procedure TSProProgram.EndProcess;
begin
  if Assigned(fCurrentProcess) then
  begin
    fCurrentProcess.LastLine := Items[Count-1];
    fCurrentProcess := nil;
  end;
end;

procedure TSProProgram.AddDataSpecifier(const aName: string; const cnt: word;
  addr : integer);
var
  obj : TDSObject;
  tmp : Word;
begin
//  if addr = 0 then
//    addr := fDataSpecifiers.Count
//  else
//    inc(fDataOrigin, cnt);
//  obj := TDSObject.Create(aName, addr, cnt);
  if addr = -1 then
    tmp := fDataSpecifiers.Count
  else
    tmp := addr;
  inc(fDataOrigin, cnt);
  obj := TDSObject.Create(aName, tmp, cnt);
  fDataSpecifiers.AddObject(aName, obj);
  fSortedDS.AddObject(aName, obj);
  if (addr <> -1) and (addr < fBaseDO) then
    obj.AddRef;
end;

procedure TSProProgram.SetDataOrigin(const Value: Word);
var
  name : string;
  obj : TDSObject;
begin
  fDataOrigin := Value;
  name := #9'DORG';
  obj := TDSObject.Create(name, DataOrigin, 0);
  fDataSpecifiers.AddObject(name, obj);
  fSortedDS.AddObject(name, obj);
end;

function TSProProgram.FindDataSpecifierByName(const aName: string): TDSObject;
var
  i : integer;
begin
  Result := nil;
  i := fSortedDS.IndexOf(aName);
  if i <> -1 then
    Result := TDSObject(fSortedDS.Objects[i]);
end;

function TSProProgram.FindProcessByName(const aName: string): TProcessObject;
var
  i : integer;
  PO : TProcessObject;
begin
  Result := nil;
  for i := 0 to fProcesses.Count - 1 do
  begin
    PO := TProcessObject(fProcesses[i]);
    if PO.ProcessName = aName then
    begin
      Result := PO;
      break;
    end;
  end;
end;

function TSProProgram.GetCompilerOutput: TStrings;
begin
//  SaveToStrings(fCompilerOutput);
  Result := fCompilerOutput;
end;

function TSProProgram.GetSymbolTable: TStrings;
begin
  Result := fSymbolTable;
end;

procedure TSProProgram.DataspaceCompact;
var
  i, j : integer;
  DSO : TDSObject;
begin
  // remove any objects from the dataspace that are no longer in use
  for i := fDataSpecifiers.Count - 1 downto 0 do
  begin
    DSO := TDSObject(fDataSpecifiers.Objects[i]);
    if not DSO.InUse then
    begin
      fDataSpecifiers.Delete(i);
      j := fSortedDS.IndexOf(DSO.Name);
      if j <> -1 then
        fSortedDS.Delete(j);
      FreeAndNil(DSO);
    end;
  end;
end;

function TSProProgram.LoadFromBinaryStream(aStream: TStream): boolean;
var
//  AL : TSPMLine;
  w1{, w2} : word;
begin
  Result := True;
  ClearAllContainers;
  // load binary program into our object
  aStream.Position := 0; // start from beginning
  while aStream.Position < aStream.Size do
  begin
    if aStream.Read(w1, 2) <> 2 then
      break;
    // TODO: finish implementing TSproProgram.LoadFromBinaryStream
  end;
end;

function TSProProgram.LoadFromBinaryFile(const aFilename: string): boolean;
var
  MS : TMemoryStream;
begin
  MS := TMemoryStream.Create;
  try
    MS.LoadFromFile(aFilename);
    Result := LoadFromBinaryStream(MS);
  finally
    MS.Free;
  end;
end;

procedure TSProProgram.ClearAllContainers;
begin
  LineCounter := 0;
  fSkipCount := 0;
  fCodeOrigin := 0;
  Clear; // get rid of SPMLines
  ClearDataSpecifiers;
  fAddresses.Clear;
  fProcesses.Clear;
  fCompilerOutput.Clear;
  fSymbolTable.Clear;
  SetLength(fCode.Code, 0);
end;

procedure TSProProgram.ClearDataSpecifiers;
var
  i : integer;
begin
  fDataOrigin := fBaseDO;
  for i := 0 to fDataSpecifiers.Count - 1 do
  begin
    fDataSpecifiers.Objects[i].Free;
  end;
  fDataSpecifiers.Clear;
  fSortedDS.Clear;
end;

function TSProProgram.LoadFromFile(aFilename: string): boolean;
var
  bIsBin : boolean;
  MS : TMemoryStream;
  SL : TStringList;
  ext : string;
begin
  Result := FileExists(aFilename);
  if Result then
  begin
    ext := UpperCase(ExtractFileExt(aFilename));
    bIsBin := ext = '.BIN';
    if bIsBin then
    begin
      MS := TMemoryStream.Create;
      try
        MS.LoadFromFile(aFilename);
        Result := LoadFromBinaryStream(MS);
      finally
        MS.Free;
      end;
    end
    else
    begin
      SL := TStringList.Create;
      try
        SL.LoadFromFile(aFilename);
        CurrentFile := aFilename;
        Result := LoadFromStrings(SL);
      finally
        SL.Free;
      end;
    end;
  end;
end;

function TSProProgram.LoadFromStrings(aStrings: TStrings): boolean;
var
  i : integer;
  proc : TProcessObject;
begin
  Result := True;
  ClearAllContainers;
  fDataOrigin := $0;
  proc := TProcessObject.Create(Self);
  fProcesses.Add(proc);
  proc.ProcessName := 'AllCode';
  // parse ASM source code to load SProProgram
  for i := 0 to aStrings.Count - 1 do
  begin
    if fSkipCount = 0 then
      LineCounter := LineCounter + 1;
    AddASMLine(aStrings[i]);
    if fSkipCount > 0 then
      Dec(fSkipCount);
  end;
  proc.AddRef;
  proc.FirstLine := Items[0];
  proc.LastLine := Items[Count-1];
end;

procedure TSProProgram.DeleteProcess(PO: TProcessObject);
var
  L : TSPMLine;
  i : integer;
begin
  // start deleting lines from the end of the process
  L := PO.LastLine;
  while L <> PO.FirstLine do
  begin
    i := L.Index;
    L := Items[i-1];
    Delete(i);
  end;
  // now delete the first line
  i := L.Index;
  Delete(i);
  // and remove the process
  i := fProcesses.IndexOf(PO);
  if i <> -1 then
    fProcesses.Delete(i);
end;

procedure TSProProgram.RemoveReferences(PO: TProcessObject);
var
  L : TSPMLine;
begin
  // go through all the lines in this process and remove dataspace references
  L := PO.FirstLine;
  while L <> PO.LastLine do
  begin
    L.RemoveVariableReferences;
    L := Self.Items[L.Index+1];
  end;
  // remove the last line's references
  L.RemoveVariableReferences;
end;

procedure TSProProgram.AddASMLine(const aLine: string);
var
  AL : TSPMLine;
  line, tmp, aName, tmpLine, tmpFile : string;
  Org, cnt : integer;
  i, j : integer;
begin
  line := Trim(aLine);
  // do nothing if line is blank or a comment
  if (line = '') or (Pos(';', line) = 1) or (Pos('//', line) = 1) then
    Exit;

  // strip off trailing comments (not embedded in strings)
  i := Pos(';', line);
  if i <> 0 then
    TrimComments(line, i, ';');
  i := Pos('//', line);
  if i <> 0 then
    TrimComments(line, i, '//');

  // check to see if this happens to be a dataspace declaration
  tmp := Replace(Replace(line, ' ', ','), #9, ',');
  i := Pos(',DS,', tmp);
  j := Pos('DORG,', tmp);
  if i > 0 then
  begin
    aName := Replace(Copy(tmp, 1, i-1), ',', '');
    System.Delete(tmp, 1, i+3);
    tmp := Replace(tmp, ',', '');
    i := Pos('H', UpperCase(tmp));
    if i > 0 then
    begin
      System.Delete(tmp, i, MaxInt);
      tmp := '$'+tmp;
    end;
    cnt := StrToIntDef(tmp, -1);
    if cnt <> -1 then
      AddDataSpecifier(aName, cnt, DataOrigin)
    else
      raise Exception.Create('Invalid DS statement');
  end
  else if j > 0 then
  begin
    System.Delete(tmp, 1, j+4);
    tmp := Replace(tmp, ',', '');
    i := Pos('H', UpperCase(tmp));
    if i > 0 then
    begin
      System.Delete(tmp, i, MaxInt);
      tmp := '$'+tmp;
    end;
    Org := StrToIntDef(tmp, -1);
    if Org <> -1 then
      DataOrigin := Org
    else
      raise Exception.Create('Invalid DORG statement');
  end
  else
  begin
    tmpLine := line;
    if Pos('#line ', line) = 1 then
    begin
      // this is a special preprocessor line
      System.Delete(line, 1, 6);
      i := Pos(' ', line);
      LineCounter  := StrToIntDef(Copy(line, 1, i - 1), LineCounter);
      System.Delete(line, 1, i);
      tmpFile      := Replace(line, '"', '');
      tmpFile      := Replace(tmpFile, '''', '');
      CurrentFile  := tmpFile;
    end
    else if Pos('#reset', line) = 1 then
    begin
      LineCounter := 1;
    end
    else if Pos('#pragma ', line) = 1 then
    begin
      // is this a special #pragma macro line?
      if Pos('macro', line) = 9 then
      begin
        System.Delete(line, 1, 14);
        fSkipCount := StrToIntDef(line, 0)+1;
      end;
    end;
    AL := Self.Add;
    AL.AsString := tmpLine;
    AL.LineNum  := LineCounter;
  end;
end;

procedure TSProProgram.InsertASMLine(const Index: Integer; const aLine: string);
var
  line : TSPMLine;
begin
  line := Self.Insert(Index);
  line.AsString := aLine;
end;

procedure TSProProgram.AddDataSpecifierReferenceIfPresent(const aName: string);
var
  i : integer;
  O : TDSObject;
begin
  // first check for an exact match
  i := fSortedDS.IndexOf(aName);
  if i <> -1 then
    TDSObject(fSortedDS.Objects[i]).AddRef
  else
  begin
    // now check for a partial structure name match
    for i := 0 to fSortedDS.Count - 1 do
    begin
      O := TDSObject(fSortedDS.Objects[i]);
      // match has to start at the beginning of the name
      if Pos(aName+'.', O.Name) = 1 then
        O.AddRef;
    end;
  end;
end;

procedure TSProProgram.MoveProcess(aFrom, aTo: TProcessObject);
var
  L : TSPMLine;
  i : integer;
begin
  // all the lines in aFrom need to be inserted before the first line of aTo
  L := aFrom.FirstLine;
  while L <> aFrom.LastLine do
  begin
    // store the index of the current line
    i := L.Index;
    // move this line ahead of the first line in aTo.
    L.Index := aTo.FirstLine.Index;
    L := Items[i + 1]; // move to the next line
  end;
  // now move the last line
  L.Index := aTo.FirstLine.Index;
end;

procedure TSProProgram.RemoveOrNOPLine(AL, ALNext : TSPMLine; const idx : integer);
begin
  if AL.LineLabel = '' then
  begin
    Delete(idx);
  end
  else if Assigned(ALNext) and (ALNext.LineLabel = '') then
  begin
    ALNext.LineLabel := AL.LineLabel;
    Delete(idx);
  end
  else
  begin
    AL.Command := OPS_INVALID;
    AL.Args.Clear;
  end;
end;

procedure TSProProgram.FixupPragmas(line1, line2: TSPMLine; const arg : string);
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
      tmpAL := Items[tmpAL.Index - 1]
    else
      break;
  end;
end;

function DSCompareSize(List: TStringList; Index1, Index2: Integer): Integer;
var
  o1, o2 : TDSObject;
begin
  o1 := TDSObject(List.Objects[Index1]);
  o2 := TDSObject(List.Objects[Index2]);
  if o1.Count = o2.Count then
  begin
    if o1.Address = o2.Address then
      Result := 0
    else if o1.Address < o2.Address then
      Result := -1
    else
      Result := 1;
  end
  else if o1.Count < o2.Count then
    Result := -1
  else
    Result := 1;
end;

procedure TSProProgram.DataspaceSort;
begin
  // only sort the dataspace if there are no DORG entries in it.
  if fSortedDS.IndexOf(#9'DORG') = -1 then
  begin
    // order dataspace by DS size smallest to largest
    fDataSpecifiers.CustomSort(DSCompareSize);
    // now that we have reordered things we need to update the address field
    UpdateDataspaceAddresses;
  end;
end;

procedure TSProProgram.UpdateDataspaceAddresses;
var
  i : integer;
  O : TDSObject;
begin
  fDataOrigin := fBaseDO;
  for i := 0 to fDataSpecifiers.Count - 1 do
  begin
    O := TDSObject(fDataSpecifiers.Objects[i]);
    O.Address := DataOrigin;
    fDataOrigin := fDataOrigin + O.Count;
  end;
end;

procedure TSProProgram.SaveToCodeArray;
var
  i : integer;
begin
  // dataspace is ready
  UpdateAddresses;
  // pass through all our lines of code
  SetLength(fCode.Code, 0);
  for i := 0 to Count - 1 do
  begin
    Items[i].SaveToCode(fCode.Code);
  end;
  i := Length(fCode.Code);
  if i > $FFF then
    raise Exception.Create('Code size exceeds 4k: ' + IntToStr(i));
end;

function TSProProgram.CodeSize: integer;
var
  i : integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
  begin
    Result := Result + Items[i].InstructionSize;
  end;
  Result := Result div 2; // convert byte count to word count
end;

procedure TSProProgram.UpdateAddresses;
var
  i : integer;
  L : TSPMLine;
begin
  for i := 0 to Count - 1 do
  begin
    L := Items[i];
    L.ProgramCounter := fCodeOrigin;
    inc(fCodeOrigin, L.InstructionSize div 2);
  end;
end;

procedure TSProProgram.CheckSiblingsAndAddRefIfNeeded(const aName: string);
var
  i : integer;
  base, tmp : string;
  O : TDSObject;
begin
  // are there any other entries that start with the same root
  // (i.e., fields from the same struct instance)
  // if so, addref them - but only if
  // these other fields have a reference count of zero
  base := RootOf(aName);
  for i := 0 to fSortedDS.Count - 1 do
  begin
    O := TDSObject(fSortedDS.Objects[i]);
    tmp := O.Name;
    // don't addref the passed in variable
    if tmp = aName then
      Continue;
    if (Pos(base+'.', O.Name) > 0) and (O.ReferenceCount = 0) then
    begin
      O.AddRef;
    end;
  end;
end;

function TSProProgram.AddressOfDataSpecifier(const aName: string): Word;
var
  i : integer;
  O : TDSObject;
  tmp : string;
begin
  // THIS FUNCTION SHOULD NOT BE CALLED PRIOR TO DataspaceSort
  Result := $FFFF;
  // first check for exact match
  i := fSortedDS.IndexOf(aName);
  if i <> -1 then
    Result := TDSObject(fSortedDS.Objects[i]).Address
  else
  begin
    // now check for a partial structure match
    for i := 0 to fDataSpecifiers.Count - 1 do
    begin
      O := TDSObject(fDataSpecifiers.Objects[i]);
      tmp := O.Name;
      // match has to start at the beginning of the name
      if Pos(aName+'.', tmp) = 1 then
      begin
        Result := O.Address;
        break;
      end;
    end;
  end;
end;

{ TProcessObject }

procedure TProcessObject.AddRef;
begin
  inc(fRefCount);
end;

function TProcessObject.Count: integer;
begin
  Result := LastLine.Index - FirstLine.Index + 1;
end;

constructor TProcessObject.Create(aProg : TSProProgram);
begin
  inherited Create;
  fProg := aProg;
  fProcessName := '';
  fLast := nil;
  fFirst := nil;
  fRefCount := 0;
end;

function TProcessObject.GetInUse: boolean;
begin
  Result := ReferenceCount > 0;
end;

function TProcessObject.GetItems(aIndex: integer): TSPMLine;
var
  c : integer;
begin
  c := Count;
  if aIndex >= c then
    raise Exception.Create('List index out of bounds: ' + IntToStr(aIndex));
  if aIndex = 0 then
    Result := FirstLine
  else if aIndex = (c - 1) then
    Result := LastLine
  else
  begin
    Result := fProg[FirstLine.Index + aIndex];
  end;
end;

procedure TProcessObject.Optimize(level: integer);
var
  i, offset : integer;
  AL, ALNext, tmpAL : TSPMLine;
  arg1, tmp : string;
  bDone : boolean;
  DSO : TDSObject;

  function CheckReferenceCount : boolean;
  var
    cnt : integer;
  begin
    Result := True;
    arg1 := AL.Args[0].Value; // check the output (dest) argument
    cnt := CountArgUsage(AL, arg1);
    DSO := SProProgram.FindDataSpecifierByName(arg1);
    if Assigned(DSO) then
    begin
      // simple case - refcount is less than this line's usage
      if DSO.ReferenceCount <= cnt then
      begin
        // setting a variable to a value and never referencing it again
        // set|mov X, whatever
        // nop (or delete line)
        // remove the references
        AL.RemoveVariableReferences;
        SProProgram.RemoveOrNOPLine(AL, nil, i);
        Result := False;
      end;
    end;
  end;
begin
  bDone := False;
  while not bDone do begin
    bDone := True; // assume we are done
    for i := 0 to SProProgram.Count - 1 do begin
      AL := SProProgram.Items[i];
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

        arg1 := AL.Args[0].Value; // output variable
        if IsVolatile(arg1) then
        begin
          // mov arg1, arg1
          // nop
          if (AL.Command = OP_MOV) and
             (AL.Args[0].Value = AL.Args[1].Value) and
             (AL.Args[0].Indirect = AL.Args[1].Indirect) then
          begin
            AL.RemoveVariableReferences;
            SProProgram.RemoveOrNOPLine(AL, nil, i);
            bDone := False;
            Break;
          end;

          // the output argument of this opcode is a temporary variable (stack/reg/array helper)
          // so maybe we can do an optimization
          // find the next line (which may not be i+1) that is not (NOP or labeled)
          offset := 1;
          while (i < SProProgram.Count - offset) do begin
            tmpAL := SProProgram.Items[i+offset];
            if (tmpAL.Command <> OPS_INVALID) or (tmpAL.LineLabel <> '') then
              Break;
            inc(offset);
          end;
          // every line between Items[i] and Items[i+offset] are NOP lines without labels.
          if i < (SProProgram.Count - offset) then
          begin
            ALNext := SProProgram.Items[i+offset];
            // now check other cases
            // bricxcc-Bugs-1669679 - make sure the next line
            // cannot be jumped to from elsewhere.  If it does then the
            // "previous" line may actually be skipped so we cannot
            // do any optimization
            if (ALNext.LineLabel = '') and
               (ALNext.Command = OP_MOV) and
               (ALNext.Args[1].Value = AL.Args[0].Value) and
               (ALNext.Args[1].Indirect = AL.Args[0].Indirect) then
            begin
              // op reg/stack/ah, rest
              // mov anything, reg/stack/ah
              // op anything, rest
              // nop
              AL.RemoveVariableReference(arg1, 0);
              tmp := ALNext.Args[0].Value;
              AL.Args[0].Value := tmp; // switch output arg (no ref count changes)
              AL.Args[0].Indirect := ALNext.Args[0].Indirect;
              ALNext.RemoveVariableReference(arg1, 1);
              ALNext.Command := OPS_INVALID; // no-op next line
              ALNext.Args.Clear;
              // if the variable we moved from ALNext to AL was a stack or array helper
              // then we have a little extra work to do
              if IsStackOrHelper(tmp) then
                SProProgram.FixupPragmas(AL, ALNext, tmp);
              bDone := False;
              Break;
            end
            else if (ALNext.LineLabel = '') and
                    (AL.Command = OP_MVI) and
                    ((ALNext.Command >= OP_MOV) and (ALNext.Command <= OP_XOR)) and
                    (ALNext.Args[1].Value = AL.Args[0].Value) and
                    (ALNext.Args[1].Indirect = AL.Args[0].Indirect) then
            begin
              // mvi reg/stack/ah, rest
              // op anything, reg/stack/ah
              // opi anything, rest
              // nop
              // AL.Command is (ALNext.Command - OP_MOV) shl 4
              AL.RemoveVariableReference(arg1, 0);
              tmp := ALNext.Args[0].Value;
              AL.Args[0].Value := tmp; // switch output arg (no ref count changes)
              AL.Args[0].Indirect := ALNext.Args[0].Indirect;
              AL.Command := ((ALNext.Command - OP_MOV) shl 4);
              ALNext.RemoveVariableReference(arg1, 1);
              ALNext.Command := OPS_INVALID; // no-op next line
              ALNext.Args.Clear;
              // if the variable we moved from ALNext to AL was a stack or array helper
              // then we have a little extra work to do
              if IsStackOrHelper(tmp) then
                SProProgram.FixupPragmas(AL, ALNext, tmp);
              bDone := False;
              Break;
            end;
          end;

        end;
      end;

      // this next set of optimizations are organized by opcode
      // 1. jmp, jz, jp, jn, jc, jnz, jnp, jnn, jnc
      // 2. ret
      // 3. mov

      case AL.Command of
        OP_JMP, OP_JZ..OP_JC : begin // this also includes JNZ..JNC (since they share encoding with JZ..JC)
          // if this line is a some kind of jump statement and the destination is the very next line that
          // is not a no-op then it can be optimized.
          arg1 := AL.Args[0].Value; // first argument is label
          // find the next line (which may not be i+1) that is not (NOP or labeled)
          offset := 1;
          while (i < SProProgram.Count - offset) do begin
            tmpAL := SProProgram.Items[i+offset];
            if (tmpAL.Command <> OPS_INVALID) or (tmpAL.LineLabel <> '') then
              Break;
            inc(offset);
          end;
          // every line between Items[i] and Items[i+offset] are NOP lines without labels.
          if i < (SProProgram.Count - offset) then
          begin
            ALNext := SProProgram.Items[i+offset];
            // if the next line has a label == to arg1 then we can delete the current line
            if ALNext.LineLabel = arg1 then
            begin
              AL.RemoveVariableReferences;
              SProProgram.RemoveOrNOPLine(AL, ALNext, i);
              SProProgram.RemoveUnusedLabels;
              bDone := False;
              Break;
            end;
          end;
        end;
        OP_RET: begin
          // find the next line (which may not be i+1) that is not (NOP or labeled)
          offset := 1;
          while (i < SProProgram.Count - offset) do begin
            tmpAL := SProProgram.Items[i+offset];
            if (tmpAL.Command <> OPS_INVALID) or (tmpAL.LineLabel <> '') then
              Break;
            inc(offset);
          end;
          // every line between Items[i] and Items[i+offset] are NOP lines without labels.
          if i < (SProProgram.Count - offset) then
          begin
            ALNext := SProProgram.Items[i+offset];
            if (ALNext.LineLabel = '') and (ALNext.Command = OP_RET) then
            begin
              // two RETs in a row - delete the first one
              AL.Command := OPS_INVALID;
              bDone := False;
              Break;
            end;
          end;
        end;
(*
        OP_MOV: begin
          // MOV reg/stack/helper, rest
          arg1 := AL.Args[0].Value; // output variable
          if IsVolatile(arg1) then
          begin
            // find the next line (which may not be i+1) that is not (NOP or labeled)
            offset := 1;
            while (i < SProProgram.Count - offset) do begin
              tmpAL := SProProgram.Items[i+offset];
              if (tmpAL.Command <> OPS_INVALID) or (tmpAL.LineLabel <> '') then
                Break;
              inc(offset);
            end;
            // every line between Items[i] and Items[i+offset] are NOP lines without labels.
            if i < (SProProgram.Count - offset) then
            begin
              ALNext := SProProgram.Items[i+offset];
              if (ALNext.LineLabel = '') and
                 ((ALNext.Command = OP_MOV) or (ALNext.Command = OP_ADD) or
                  (ALNext.Command = OP_SUB) or (ALNext.Command = OP_MUL) or
                  (ALNext.Command = OP_DIV) or (ALNext.Command = OP_AND) or
                  (ALNext.Command = OP_OR)  or (ALNext.Command = OP_XOR)) and
                 (ALNext.Args[1].Value = arg1) and
                 (ALNext.Args[1].Indirect = AL.Args[0].Indirect) then
              begin
//	MOV reg/stack/helper, rest
//	MOV|ADD|SUB|MUL|DIV|AND|OR|XOR any, reg/stack/helper
// ->
//  MOV reg/stack/helper, rest (may not be able to nop/remove this)
//	MOV|ADD|SUB|MUL|DIV|AND|OR|XOR any, rest
              end
              else if (ALNext.LineLabel = '') and
                 (ALNext.Args[0].Value = arg1) and
                 (ALNext.Args[0].Indirect = AL.Args[0].Indirect) and
                 ((ALNext.Command = OP_LOG) or (ALNext.Command = OP_TRNH) or
                  (ALNext.Command = OP_TRND) or (ALNext.Command = OP_TST)) then
              begin
                tmp := AL.Args[1].Value;
                ALNext.RemoveVariableReference(arg1, 0);
                ALNext.Args[0].Value := tmp; // switch output arg (no ref count changes)
                ALNext.Args[0].Indirect := AL.Args[1].Indirect;
                AL.RemoveVariableReference(arg1, 0);
                AL.Command := OPS_INVALID; // no-op line
                AL.Args.Clear;
                bDone := False;
                Break;
              end;
            end;
          end;
        end;
*)
      else
        // nothing
      end;
    end;
  end;
end;

procedure TProcessObject.Release;
begin
  dec(fRefCount);
end;

{ TCodeSpaceAry }

function TCodeSpaceAry.CodespaceCount: Word;
begin
  Result := Word(Length(Code));
end;

procedure TCodeSpaceAry.SaveToStream(aStream: TStream);
var
  i : integer;
begin
  // output code array
  for i := 0 to Length(Code) - 1 do
  begin
    WriteWord(aStream, Code[i]); // little endian
  end;
end;

{ TRBFDumper }

procedure TRBFDumper.Decompile(output: TStrings);
begin

end;

procedure TRBFDumper.LoadFromFile(filename: string);
begin

end;

end.

