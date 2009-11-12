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
unit uNXTClasses;

{$B-}

interface

uses
  Classes, Contnrs, SysUtils, uNXTConstants, uPreprocess,
  uNBCCommon;

type
  TCompilerStatusChangeEvent = procedure(Sender : TObject; const StatusMsg : string) of object;

  NXTInstruction = record
    Encoding : TOpCode;
    CCType : Byte;
    Arity  : Byte;
    Name : string;
  end;

type
  TAsmLineType = (altBeginDS, altEndDS, altBeginClump, altEndClump, altCode,
    altVarDecl, altTypeDecl, altBeginStruct, altEndStruct, altBeginSub,
    altEndSub, altCodeDepends, altInvalid);

  TAsmLineTypes = set of TAsmLineType;

  TMainAsmState = (masDataSegment, masCodeSegment, masClump, masClumpSub, masStruct,
    masDSClump, masStructDSClump, masDSClumpSub, masStructDSClumpSub,
    masBlockComment);

  PRXEHeader = ^RXEHeader;
  RXEHeader = record
    FormatString : array[0..13] of Char; // add null terminator at end
    Skip : Byte; // second 0
    Version : Byte;
    DSCount : Word;
    DSSize : Word;
    DSStaticSize : Word;
    DSDefaultsSize : Word;
    DynDSDefaultsOffset : Word;
    DynDSDefaultsSize : Word;
    MemMgrHead : Word;
    MemMgrTail : Word;
    DVArrayOffset : Word;
    ClumpCount : Word;
    CodespaceCount : Word;
  end;

  DSTocEntry = record
    TypeDesc : Byte;
    Flags : Byte;
    DataDesc: Word;
    Size : Word;
    RefCount: Word;
  end;

  DSTocEntries = array of DSTocEntry; // dynamic array

  DopeVector = record
    offset : Word;
    elemsize : Word;
    count : Word;
    backptr : Word;
    link : Word;
  end;

  DopeVectors = array of DopeVector; // dynamic array

  ClumpRecord = record
    FireCount : Byte;
    DependentCount : Byte;
    CodeStart : Word;
  end;

  ClumpRecords = array of ClumpRecord; // dynamic array

  TSTTFuncType = function(const stype : string; bUseCase : Boolean = false) : TDSType;

const
  BytesPerType : array[TDSType] of Byte = (4, 1, 1, 2, 2, 4, 4, 2, 4, 4, 4);
  NOT_AN_ELEMENT = $FFFF;

type
  TDSBase = class;
  TDSData = class;

  TDataspaceEntry = class(TCollectionItem)
  private
    fThreadNames : TStrings;
    fDataType: TDSType;
    fIdentifier: string;
    fDefValue: Cardinal;
    fAddress: Word;
    fSubEntries: TDSBase;
    fArrayValues: TObjectList;
    fDSID: integer;
    fArrayMember: boolean;
    fRefCount : integer;
    fTypeName: string;
    function  GetValue(idx: integer): Cardinal;
    function  GetArrayInit: string;
    procedure SetSubEntries(const Value: TDSBase);
    function GetDataTypeAsString: string;
    function GetFullPathIdentifier: string;
    function GetDSBase: TDSBase;
    procedure SetArrayMember(const Value: boolean);
    procedure SetIdentifier(const Value: string);
    function GetInUse: boolean;
    function GetRefCount: integer;
    function GetClusterInit: string;
    function GetInitializationString: string;
    function GetArrayBaseType: TDSType;
    function GetIsArray: boolean;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure SaveToDynamicDefaults(aDS : TDSData; const cnt, doffset : integer);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure SaveToStream(aStream : TStream);
    procedure SaveToStrings(aStrings : TStrings; bDefine : boolean = false;
      bInCluster : boolean = false);
    procedure LoadFromStream(aStream : TStream);
    procedure AddValue(aValue : Cardinal);
    function AddValuesFromString(Calc : TNBCExpParser; sargs : string) : TDSType;
    function  ValueCount : Word;
    function  ArrayElementSize : Word;
    function  ElementSize : Word;
    procedure IncRefCount;
    procedure DecRefCount;
    procedure AddThread(const aThreadName : string);
    function  ThreadCount : integer;
    property DSBase : TDSBase read GetDSBase;
    property DSID : integer read fDSID write fDSID;
    property Identifier : string read fIdentifier write SetIdentifier;
    property TypeName : string read fTypeName write fTypeName;
    property DataType : TDSType read fDataType write fDataType;
    property DataTypeAsString : string read GetDataTypeAsString;
    property DefaultValue : Cardinal read fDefValue write fDefValue;
    property Address : Word read fAddress write fAddress;
    property SubEntries : TDSBase read fSubEntries write SetSubEntries; // used to store array types and cluster structure
    property Values[idx : integer] : Cardinal read GetValue; // used to store array default values
    property FullPathIdentifier : string read GetFullPathIdentifier;
    property InitializationString : string read GetInitializationString;
    property ArrayMember : boolean read fArrayMember write SetArrayMember;
    property BaseDataType : TDSType read GetArrayBaseType;
    property IsArray : boolean read GetIsArray;
    property InUse : boolean read GetInUse;
    property RefCount : integer read GetRefCount;
  end;

  TDSData = class
  private
    fDSStaticSize : integer;
  public
    TOC : DSTocEntries;
    TOCNames : array of string;
    StaticDefaults : array of byte;
    DynamicDefaults : array of byte;
    DopeVecs : DopeVectors;
    Head : Word;
    Tail : Word;
    constructor Create;
    function DynDSDefaultsOffset : Word;
    function DynDSDefaultsSize : Word;
    function DSCount : Word;
    function DSStaticSize : Word;
    function DVArrayOffset : Word;
    procedure SaveToStream(aStream : TStream);
    procedure SaveToSymbolTable(aStrings : TStrings);
  end;

  TDSBaseSortCompare = function(List: TDSBase; Index1, Index2: Integer): Integer;

  EDuplicateDataspaceEntry = class(Exception)
  public
    constructor Create(DE : TDataspaceEntry);
  end;

//  TDataspaceEntry = class;

  TDSBase = class(TCollection)
  private
    fParent: TPersistent;
    procedure ExchangeItems(Index1, Index2: Integer);
    function GetRoot: TDataspaceEntry;
  protected
    fEntryIndex : TStringList;
    function  GetItem(Index: Integer): TDataspaceEntry;
    procedure SetItem(Index: Integer; Value: TDataspaceEntry);
    procedure AssignTo(Dest : TPersistent); override;
    procedure QuickSort(L, R: Integer; SCompare: TDSBaseSortCompare);
    function  ResolveNestedArrayAddress(DS : TDSData; DV : DopeVector) : TDataspaceEntry;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function  Add: TDataspaceEntry;
    function  Insert(Index: Integer): TDataspaceEntry;
    function  IndexOfName(const name : string) : integer;
    function  FullPathName(DE : TDataspaceEntry) : string;
    function  FindEntryByAddress(Addr : Word) : TDataspaceEntry; virtual;
    function  FindEntryByFullName(const path : string) : TDataspaceEntry; virtual;
    function  FindEntryByName(name : string) : TDataspaceEntry; virtual;
    procedure Sort; virtual;
    procedure CheckEntry(DE : TDataspaceEntry);
    property  Items[Index: Integer]: TDataspaceEntry read GetItem write SetItem; default;
    property  Parent : TPersistent read fParent write fParent;
    property  Root : TDataspaceEntry read GetRoot;
  end;

  TDataDefs = class(TDSBase);

  TDataspace = class(TDSBase)
  private
    function GetCaseSensitive: boolean;
    procedure SetCaseSensitive(const Value: boolean);
  protected
    fVectors : DopeVectors;
    fMMTail: Word;
    fMMHead: Word;
    fDSIndexMap : TStringList;
    fDSList : TObjectList;
    function  GetVector(index: Integer): DopeVector;
  protected
    procedure LoadArrayValuesFromDynamicData(DS : TDSData);
    function  FinalizeDataspace(DS : TDSBase; addr : Word) : Word;
    procedure ProcessDopeVectors(aDS : TDSData; addr : Word);
    procedure ProcessArray(DE : TDataspaceEntry; aDS : TDSData; var doffset : integer);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Compact;
    procedure SaveToStream(aStream : TStream);
    procedure SaveToStrings(aStrings : TStrings);
    procedure LoadFromStream(aStream : TStream);
    procedure LoadFromDSData(aDS : TDSData);
    procedure SaveToDSData(aDS : TDSData);
    function  IndexOfEntryByAddress(Addr : Word) : Integer;
    function  FindEntryByFullName(const path : string) : TDataspaceEntry; override;
    function  FindEntryAndAddReference(const path : string) : TDataspaceEntry;
    procedure RemoveReferenceIfPresent(const path : string);
    procedure AddReference(DE : TDataspaceEntry);
    procedure RemoveReference(DE : TDataspaceEntry);
    function  DataspaceIndex(const ident : string) : Integer;
    property  Vectors[index : Integer] : DopeVector read GetVector;
    property  MMHead : Word read fMMHead write fMMHead;
    property  MMTail : Word read fMMTail write fMMTail;
    property  CaseSensitive : boolean read GetCaseSensitive write SetCaseSensitive;
  end;

  ClumpDepArray = array of Byte;

  TClumpData = class
  public
    CRecs : ClumpRecords;
    ClumpDeps : ClumpDepArray;
    procedure SaveToStream(aStream : TStream);
  end;

  TRXEHeader = class
  public
    Head : RXEHeader;
  end;

  CodeArray = array of Word;

  TCodeSpaceAry = class
  public
    Code : CodeArray;
    function CodespaceCount : Word;
    procedure SaveToStream(aStream : TStream);
  end;

  TAsmArgument = class(TCollectionItem)
  private
    fValue: string;
    fDSID: integer;
    procedure SetValue(const Value: string);
  public
    property Value : string read fValue write SetValue;
    function IsQuoted(delim : char) : boolean;
    property DSID : integer read fDSID;
    function Evaluate(Calc : TNBCExpParser) : Extended;
  end;

  TOnNameToDSID = procedure(const aName : string; var aId : integer) of object;

  TAsmArguments = class(TCollection)
  private
    function GetItem(Index: Integer): TAsmArgument;
    procedure SetItem(Index: Integer; const Value: TAsmArgument);
    function GetAsString: string;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
    function  Add: TAsmArgument;
    function Insert(Index: Integer): TAsmArgument;
    property  Items[Index: Integer]: TAsmArgument read GetItem write SetItem; default;
    property  AsString : string read GetAsString;
  end;

  TClumpCode = class;
  TClump = class;
  TCodeSpace = class;
  TRXEProgram = class;

  TAsmLine = class(TCollectionItem)
  private
    fMacroExpansion: boolean;
    function  GetAsString: string;
    procedure SetAsString(const Value: string);
    function  GetClump: TClump;
    function  GetCodeSpace: TCodeSpace;
    function  GetPC: word;
    function GetOptimizable: boolean;
  protected
    fComment: string;
    fLabel: string;
    fArgs: TAsmArguments;
    fOpCode: TOpcode;
    fLineNum: integer;
//    fPC: word;
    fInstrSize : integer;
    fStartAddress : integer;
    fCode : CodeArray;
    fArity : Byte;
    fCC : Byte;
    fsop : ShortInt;
    fIsSpecial : boolean;
    fSpecialStr : string;
    procedure SetArgs(const Value: TAsmArguments);
    function GetClumpCode: TClumpCode;
    function CanBeShortOpEncoded : boolean;
    procedure FinalizeASMInstrSize;
    procedure FinalizeCode;
    procedure FinalizeArgs(bResolveDSIDs : Boolean);
    procedure FixupFinClump;
    function  IsLabel(const name : string; var aID : integer) : boolean;
    procedure HandleNameToDSID(const name : string; var aId : integer);
    procedure RemoveVariableReference(const arg : string; const idx : integer);
    procedure RemoveVariableReferences;
    function FirmwareVersion : word;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure AddArgs(sargs : string);
    function InstructionSize : integer;
    procedure SaveToCode(var Store : CodeArray);
    property LineLabel : string read fLabel write fLabel;
    property Command : TOpcode read fOpCode write fOpCode;
    property Args : TAsmArguments read fArgs write SetArgs;
    property Comment : string read fComment write fComment;
    property LineNum : integer read fLineNum write fLineNum;
    property ProgramCounter : word read GetPC;
    property IsPartOfMacroExpansion : boolean read fMacroExpansion;
    property IsSpecial : boolean read fIsSpecial;
//    property ProgramCounter : word read fPC write fPC;
    property ClumpCode : TClumpCode read GetClumpCode;
    property Clump : TClump read GetClump;
    property CodeSpace : TCodeSpace read GetCodeSpace;
    property StartAddress : integer read fStartAddress;
    property AsString : string read GetAsString write SetAsString;
    property Optimizable : boolean read GetOptimizable;
  end;

  TClumpCode = class(TCollection)
  private
    fOnNameToDSID: TOnNameToDSID;
    fClump : TClump;
  protected
    function GetItem(Index: Integer): TAsmLine;
    procedure SetItem(Index: Integer; const Value: TAsmLine);
    procedure HandleNameToDSID(const aName : string; var aId : integer);
    procedure FixupFinalization;
  public
    constructor Create(aClump : TClump);
    destructor Destroy; override;
    function  Add: TAsmLine;
    property  Items[Index: Integer]: TAsmLine read GetItem write SetItem; default;
    property  Clump : TClump read fClump;
    property  OnNameToDSID : TOnNameToDSID read fOnNameToDSID write fOnNameToDSID;
  end;

  TClump = class(TCollectionItem)
  private
    fName: string;
    fClumpCode: TClumpCode;
    fIsSub: boolean;
    fDatasize : integer;
    fCode : CodeArray;
    fFilename: string;
    fLastLine: integer;
    function GetUpstream(aIndex: integer): string;
    function GetCodeSpace: TCodeSpace;
    function GetDataSize: Word;
    function GetStartAddress: Word;
    function GetDownstream(aIndex: integer): string;
    function GetDownCount: Byte;
    function GetUpCount: integer;
    function GetFireCount: Word;
    function GetCaseSensitive: boolean;
    function GetInUse: boolean;
    procedure RemoveOrNOPLine(AL, ALNext: TAsmLine; const idx: integer);
    function GetCallerCount: Byte;
    function GetIsMultithreaded: boolean;
  protected
    fLabelMap : TStringList;
    fUpstream : TStringList;
    fDownstream : TStringList;
    fCallers : TStringList;
    fRefCount : integer;
    procedure FinalizeClump;
    procedure HandleNameToDSID(const aname : string; var aId : integer);
    procedure RemoveReferences;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Optimize(const level : Integer);
    procedure OptimizeMutexes;
    procedure RemoveUnusedLabels;
    procedure AddClumpDependencies(const opcode, args : string);
    procedure AddDependant(const clumpName : string);
    procedure AddAncestor(const clumpName : string);
    procedure AddCaller(const clumpName : string);
    procedure AddLabel(const lbl : string; Line : TAsmLine);
    function  IndexOfLabel(const lbl : string) : integer;
    function  AsmLineFromLabelIndex(const idx : integer) : TAsmLine;
    procedure IncRefCount;
    procedure DecRefCount;
    procedure SaveToCode(var Store : CodeArray);
    procedure SaveDependencies(var Store : ClumpDepArray);
    property CodeSpace : TCodeSpace read GetCodeSpace;
    property StartAddress : Word read GetStartAddress;
    property FireCount : Word read GetFireCount;
    property DataSize : Word read GetDataSize;
    property Name : string read fName write fName;
    property UpstreamClumps[aIndex : integer] : string read GetUpstream;
    property UpstreamCount : integer read GetUpCount;
    property DownstreamClumps[aIndex : integer] : string read GetDownstream;
    property DownstreamCount : Byte read GetDownCount;
    property CallerCount : Byte read GetCallerCount;
    property ClumpCode : TClumpCode read fClumpCode;
    property IsSubroutine : boolean read fIsSub write fIsSub;
    property CaseSensitive : boolean read GetCaseSensitive;
    property InUse : boolean read GetInUse;
    property Filename : string read fFilename write fFilename;
    property LastLine : integer read fLastLine write fLastLine;
    property IsMultithreaded : boolean read GetIsMultithreaded;
  end;

  TCodeSpace = class(TCollection)
  private
    fNXTInstructions : array of NXTInstruction;
    fOnNameToDSID: TOnNameToDSID;
    fCalc: TNBCExpParser;
    fCaseSensitive : Boolean;
    fDS: TDataspace;
    fFirmwareVersion: word;
    function GetCaseSensitive: boolean;
    procedure SetCaseSensitive(const Value: boolean);
    procedure BuildReferences;
    procedure InitializeInstructions;
    function IndexOfOpcode(op: TOpCode): integer;
    function OpcodeToStr(const op : TOpCode) : string;
    procedure SetFirmwareVersion(const Value: word);
  protected
    fRXEProg : TRXEProgram;
    fInitName: string;
    fAddresses : TObjectList;
    fFireCounts : TObjectList;
    fMultiThreadedClumps : TStrings;
    function  GetItem(aIndex: Integer): TClump;
    procedure SetItem(aIndex: Integer; const aValue: TClump);
    function  GetAddress(aIndex: Integer): Word;
    function  GetFireCount(aIndex: integer): Byte;
    procedure FinalizeDependencies;
    procedure FinalizeAddressesAndFireCounts;
    procedure HandleNameToDSID(const aName : string; var aId : integer);
    function  GetNXTInstruction(const idx : integer) : NXTInstruction;
    procedure RemoveUnusedLabels;
  public
    constructor Create(rp : TRXEProgram; ds : TDataspace);
    destructor Destroy; override;
    function  Add: TClump;
    procedure Compact;
    procedure Optimize(const level : Integer);
    procedure OptimizeMutexes;
    procedure SaveToCodeData(aCD : TClumpData; aCode : TCodeSpaceAry);
    procedure SaveToSymbolTable(aStrings : TStrings);
    procedure SaveToStrings(aStrings : TStrings);
    function  IndexOf(const aName : string) : integer;
    procedure AddReferenceIfPresent(aClump : TClump; const aName : string);
    procedure RemoveReferenceIfPresent(const aName : string);
    procedure MultiThread(const aName : string);
    property  Items[aIndex: Integer]: TClump read GetItem write SetItem; default;
    property  StartingAddresses[aIndex: Integer] : Word read GetAddress;
    property  FireCounts[aIndex : integer] : Byte read GetFireCount;
    property  InitialClumpName : string read fInitName write fInitName;
    property  Calc : TNBCExpParser read fCalc write fCalc;
    property  OnNameToDSID : TOnNameToDSID read fOnNameToDSID write fOnNameToDSID;
    property  CaseSensitive : boolean read GetCaseSensitive write SetCaseSensitive;
    property  Dataspace : TDataspace read fDS;
    property  FirmwareVersion : word read fFirmwareVersion write SetFirmwareVersion;
    property  RXEProgram : TRXEProgram read fRXEProg;
  end;

  TAsmArgType = (aatVariable, aatVarNoConst, aatVarOrNull, aatConstant,
    aatClumpID, aatLabelID, aatCluster, aatString, aatStringNoConst,
    aatArray, aatScalar, aatScalarNoConst, aatScalarOrNull, aatMutex,
    aatTypeName);

  TOnNBCCompilerMessage = procedure(const msg : string; var stop : boolean) of object;

  TRXEProgram = class(TPersistent)
  private
    fNXTInstructions : array of NXTInstruction;
    fOnCompMSg: TOnNBCCompilerMessage;
    fCalc: TNBCExpParser;
    fCaseSensitive: boolean;
    fStandardDefines: boolean;
    fExtraDefines: boolean;
    fCompVersion: byte;
    fIncDirs: TStrings;
    fCompilerOutput : TStrings;
    fSymbolTable : TStrings;
    fOptimizeLevel: integer;
    fReturnRequired: boolean;
    fDefines: TStrings;
    fWarningsOff: boolean;
    fEnhancedFirmware: boolean;
    fIgnoreSystemFile: boolean;
    fMaxErrors: word;
    fFirmwareVersion: word;
    fOnCompilerStatusChange: TCompilerStatusChangeEvent;
    procedure SetCaseSensitive(const Value: boolean);
    procedure SetStandardDefines(const Value: boolean);
    procedure SetExtraDefines(const Value: boolean);
    procedure SetCompVersion(const Value: byte);
    procedure SetIncDirs(const Value: TStrings);
    function GetSymbolTable: TStrings;
    function GetCurrentFile(bFullPath: boolean): string;
    function GetCurrentPath: string;
    procedure SetCurrentFile(const Value: string);
    procedure CreateReturnerClump(const basename: string);
    procedure CreateSpawnerClump(const basename: string);
    procedure SetDefines(const Value: TStrings);
    procedure LoadSystemFile(S: TStream);
    procedure SetLineCounter(const Value: integer);
    procedure SetFirmwareVersion(const Value: word);
    function IndexOfOpcode(op: TOpCode): integer;
    procedure InitializeInstructions;
    procedure ChunkLine(const state: TMainAsmState; namedTypes: TMapList;
      line: string; bUseCase: boolean; var lbl, opcode, args: string;
      var lineType: TAsmLineType; var bIgnoreDups: boolean);
    function DetermineLineType(const state: TMainAsmState;
      namedTypes: TMapList; op: string; bUseCase: boolean): TAsmLineType;
    function StrToOpcode(const op: string; bUseCase: boolean = False): TOpCode;
    function OpcodeToStr(const op: TOpCode): string;
  protected
    fDSData : TDSData;
    fClumpData : TClumpData;
    fCode : TCodeSpaceAry;
    fMainStateLast : TMainAsmState;
    fMainStateCurrent : TMainAsmState;
    fCurrentFile : string;
    fCurrentPath : string;
    fLineCounter : integer;
    fDD : TDataDefs;
    fDS : TDataspace;
    fCS : TCodeSpace;
    fHeader : RXEHeader;
    fNamedTypes : TMapList;
    fConstStrMap : TMapList;
    fCurrentClump : TClump;
    fCurrentStruct : TDataspaceEntry;
    fMsgs : TStrings;
    fBadProgram : boolean;
    fProgErrorCount : integer;
    fClumpUsesWait : boolean;
    fClumpUsesSign : boolean;
    fClumpUsesShift : boolean;
    fAbsCount : integer;
    fSignCount : integer;
    fShiftCount : integer;
    fVarI : integer;
    fVarJ : integer;
    fClumpName : string;
    fSkipCount : integer;
    fProductVersion : string;
    fSpawnedThreads : TStrings;
    fIgnoreDupDefs : boolean;
    fSpecialFunctions : TObjectList;
    fIgnoreLines : boolean;
    procedure DoCompilerStatusChange(const Status : string);
    function  GetVersion: byte;
    procedure SetVersion(const Value: byte);
    function  GetFormat: string;
    procedure SetFormat(const Value: string);
    function  GetClumpCount: Word;
    function  GetCodespaceCount: Word;
    function  GetDSCount: Word;
    function  GetDSDefaultsSize: Word;
    function  GetDSSize: Word;
    function  GetDVArrayOffset: Word;
    function  GetDynDSDefaultsOffset: Word;
    function  GetDynDSDefaultsSize: Word;
    function  GetMemMgrHead: Word;
    function  GetMemMgrTail: Word;
    function  GetNXTInstruction(const idx : integer) : NXTInstruction;
    procedure ReportProblem(const lineNo : integer; const fName, line, msg : string; err : boolean);
    procedure ProcessASMLine(aStrings : TStrings; idx : integer);
    procedure HandleConstantExpressions(AL : TAsmLine);
    procedure ProcessSpecialFunctions(AL : TAsmLine);
    procedure HandlePseudoOpcodes(AL : TAsmLine; op : TOpCode{; const args : string});
    procedure UpdateHeader;
    procedure CheckArgs(AL : TAsmLine);
    procedure DoCompilerCheck(AL : TAsmLine; bIfCheck : boolean);
    procedure DoCompilerCheckType(AL : TAsmLine);
    procedure ValidateLabels(aClump : TClump);
    procedure HandleNameToDSID(const aName : string; var aId : integer);
    procedure CreateObjects;
    procedure FreeObjects;
    procedure InitializeHeader;
    procedure LoadSpecialFunctions;
    procedure HandleCalcParserError(Sender: TObject; E: Exception);
    procedure CreateWaitClump(const basename : string);
    procedure DefineWaitArgs(const basename : string);
    procedure DefineShiftArgs(const basename : string);
    function  ReplaceTokens(const line : string) : string;
    procedure FixupComparisonCodes(Arg : TAsmArgument);
    procedure DefineVar(aVarName : string; dt :TDSType);
    procedure RegisterThreadForSpawning(aThreadName : string);
    procedure ProcessSpawnedThreads;
    procedure OutputUnusedItemWarnings;
    procedure CheckMainThread;
    procedure HandleSpecialFunctionSizeOf(Arg : TAsmArgument; const left, right, name : string);
    procedure HandleSpecialFunctionIsConst(Arg : TAsmArgument; const left, right, name : string);
    procedure HandleSpecialFunctionValueOf(Arg : TAsmArgument; const left, right, name : string);
    procedure HandleSpecialFunctionTypeOf(Arg : TAsmArgument; const left, right, name : string);
    property  LineCounter : integer read fLineCounter write SetLineCounter;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function  Parse(aStream : TStream) : string; overload;
    function  Parse(aStrings : TStrings) : string; overload;
    procedure LoadFromStream(aStream : TStream);
    function  SaveToStream(aStream : TStream) : boolean;
    function  SaveToFile(const filename : string) : boolean;
    procedure SaveToStrings(aStrings : TStrings);
    property  Calc : TNBCExpParser read fCalc;
    property  IncludeDirs : TStrings read fIncDirs write SetIncDirs;
    // header properties
    property  FormatString : string read GetFormat write SetFormat;
    property  Version : byte read GetVersion write SetVersion;
    property  DSCount : Word read GetDSCount;
    property  DSSize : Word read GetDSSize;
    property  DSDefaultsSize : Word read GetDSDefaultsSize;
    property  DynDSDefaultsOffset : Word read GetDynDSDefaultsOffset;
    property  DynDSDefaultsSize : Word read GetDynDSDefaultsSize;
    property  MemMgrHead : Word read GetMemMgrHead;
    property  MemMgrTail : Word read GetMemMgrTail;
    property  DVArrayOffset : Word read GetDVArrayOffset;
    property  ClumpCount : Word read GetClumpCount;
    property  CodespaceCount : Word read GetCodespaceCount;
    // dataspace definitions property
    property  DataDefinitions : TDataDefs read fDD;
    // dataspace property
    property  Dataspace : TDataspace read fDS;
    // codespace property
    property  Codespace : TCodeSpace read fCS;
    property  CompilerMessages : TStrings read fMsgs;
    property  SymbolTable : TStrings read GetSymbolTable;
    property  CompilerOutput : TStrings read fCompilerOutput;
    property  CaseSensitive : boolean read fCaseSensitive write SetCaseSensitive;
    property  CurrentFile : string read fCurrentFile write SetCurrentFile;
    property  StandardDefines : boolean read fStandardDefines write SetStandardDefines;
    property  ExtraDefines : boolean read fExtraDefines write SetExtraDefines;
    property  CompilerVersion : byte read fCompVersion write SetCompVersion;
    property  ReturnRequiredInSubroutine : boolean read fReturnRequired write fReturnRequired;
    property  OptimizeLevel : integer read fOptimizeLevel write fOptimizeLevel;
    property  Defines : TStrings read fDefines write SetDefines;
    property  WarningsOff : boolean read fWarningsOff write fWarningsOff;
    property  EnhancedFirmware : boolean read fEnhancedFirmware write fEnhancedFirmware;
    property  FirmwareVersion : word read fFirmwareVersion write SetFirmwareVersion;
    property  IgnoreSystemFile : boolean read fIgnoreSystemFile write fIgnoreSystemFile;
    property  MaxErrors : word read fMaxErrors write fMaxErrors;
    property  OnCompilerMessage : TOnNBCCompilerMessage read fOnCompMSg write fOnCompMsg;
    property OnCompilerStatusChange : TCompilerStatusChangeEvent read fOnCompilerStatusChange write fOnCompilerStatusChange;
  end;

  TRXEDumper = class
  private
    fNXTInstructions : array of NXTInstruction;
    fOnlyDumpCode: boolean;
    fFirmwareVersion: word;
    function TOCNameFromArg(DS : TDSData; const argValue: word): string;
    procedure SetFirmwareVersion(const Value: word);
    procedure InitializeInstructions;
    function IndexOfOpcode(op: TOpCode): integer;
  protected
    fHeader : TRXEHeader;
    fDSData : TDSData;
    fClumpData : TClumpData;
    fCode : TCodeSpaceAry;
    fFilename : string;
    fAddrList : TStringList;
    fFixups : TStringList;
    fTmpDataspace : TDataspace;
    function  GetAddressLine(const str : string) : string;
    procedure FixupLabelStrings(aStrings : TStrings; const addr, line : integer);
    procedure OutputByteCodePhaseOne(aStrings : TStrings);
    procedure OutputDataspace(aStrings: TStrings);
    procedure OutputBytecode(aStrings: TStrings);
    procedure OutputClumpBeginEndIfNeeded(CD : TClumpData; const addr : integer; aStrings : TStrings);
    function ProcessInstructionArg(DS : TDSData; const addr : integer;
      const op : TOpCode; const argIdx : integer; const argValue : word) : string;
    function ProcessInstruction(DS : TDSData; CS : TCodeSpaceAry;
      const addr: integer; aStrings : TStrings): integer;
    procedure DumpRXEHeader(aStrings : TStrings);
    procedure DumpRXEDataSpace(aStrings : TStrings);
    procedure DumpRXEClumpRecords(aStrings : TStrings);
    procedure DumpRXECodeSpace(aStrings : TStrings);
    procedure FinalizeRXE;
    procedure InitializeRXE;
    function  GetNXTInstruction(const idx : integer) : NXTInstruction;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromFile(const aFilename : string);
    procedure LoadFromStream(aStream : TStream);
    procedure SaveToFile(const aFilename : string);
    procedure SaveToStream(aStream : TStream);
    procedure DumpRXE(aStrings : TStrings);
    procedure Decompile(aStrings : TStrings);
    property  Filename : string read fFilename write fFilename;
    property  OnlyDumpCode : boolean read fOnlyDumpCode write fOnlyDumpCode;
    property  FirmwareVersion : word read fFirmwareVersion write SetFirmwareVersion;
  end;


const
  RXEHeaderText =
    'FormatString = %0:s'#13#10 +
    'Version = %1:d'#13#10 +
    'DSCount = %2:d (0x%2:x)'#13#10 +
    'DSSize = %3:d (0x%3:x)'#13#10 +
    'DSStaticSize = %4:d (0x%4:x)'#13#10 +
    'DSDefaultsSize = %5:d (0x%5:x)'#13#10 +
    'DynDSDefaultsOffset = %6:d (0x%6:x)'#13#10 +
    'DynDSDefaultsSize = %7:d (0x%7:x)'#13#10 +
    'MemMgrHead = %8:d (0x%8:x)'#13#10 +
    'MemMgrTail = %9:d (0x%9:x)'#13#10 +
    'DVArrayOffset = %10:d (0x%10:x)'#13#10 +
    'ClumpCount = %11:d (0x%11:x)'#13#10 +
    'CodespaceCount = %12:d (0x%12:x)';

const
  STR_USES = 'precedes';

type
  TNXTInstructions = array of NXTInstruction;

var
  NXTInstructions : array of NXTInstruction;

const
  StandardOpcodeCount1x = 54;
  EnhancedOpcodeCount1x = 27;
  PseudoOpcodeCount1x   = 39;
  NXTInstructionsCount1x = StandardOpcodeCount1x+EnhancedOpcodeCount1x+PseudoOpcodeCount1x;
  NXTInstructions1x : array[0..NXTInstructionsCount1x-1] of NXTInstruction =
  (
    ( Encoding: OP_ADD           ; CCType: 0; Arity: 3; Name: 'add'; ),
    ( Encoding: OP_SUB           ; CCType: 0; Arity: 3; Name: 'sub'; ),
    ( Encoding: OP_NEG           ; CCType: 0; Arity: 2; Name: 'neg'; ),
    ( Encoding: OP_MUL           ; CCType: 0; Arity: 3; Name: 'mul'; ),
    ( Encoding: OP_DIV           ; CCType: 0; Arity: 3; Name: 'div'; ),
    ( Encoding: OP_MOD           ; CCType: 0; Arity: 3; Name: 'mod'; ),
    ( Encoding: OP_AND           ; CCType: 0; Arity: 3; Name: 'and'; ),
    ( Encoding: OP_OR            ; CCType: 0; Arity: 3; Name: 'or'; ),
    ( Encoding: OP_XOR           ; CCType: 0; Arity: 3; Name: 'xor'; ),
    ( Encoding: OP_NOT           ; CCType: 0; Arity: 2; Name: 'not'; ),
    ( Encoding: OP_CMNT          ; CCType: 0; Arity: 2; Name: 'cmnt'; ),
    ( Encoding: OP_LSL           ; CCType: 0; Arity: 3; Name: 'lsl'; ),
    ( Encoding: OP_LSR           ; CCType: 0; Arity: 3; Name: 'lsr'; ),
    ( Encoding: OP_ASL           ; CCType: 0; Arity: 3; Name: 'asl'; ),
    ( Encoding: OP_ASR           ; CCType: 0; Arity: 3; Name: 'asr'; ),
    ( Encoding: OP_ROTL          ; CCType: 0; Arity: 3; Name: 'rotl'; ),
    ( Encoding: OP_ROTR          ; CCType: 0; Arity: 3; Name: 'rotr'; ),
    ( Encoding: OP_CMP           ; CCType: 2; Arity: 3; Name: 'cmp'; ),
    ( Encoding: OP_TST           ; CCType: 1; Arity: 2; Name: 'tst'; ),
    ( Encoding: OP_CMPSET        ; CCType: 2; Arity: 4; Name: 'cmpset'; ),
    ( Encoding: OP_TSTSET        ; CCType: 1; Arity: 3; Name: 'tstset'; ),
    ( Encoding: OP_INDEX         ; CCType: 0; Arity: 3; Name: 'index'; ),
    ( Encoding: OP_REPLACE       ; CCType: 0; Arity: 4; Name: 'replace'; ),
    ( Encoding: OP_ARRSIZE       ; CCType: 0; Arity: 2; Name: 'arrsize'; ),
    ( Encoding: OP_ARRBUILD      ; CCType: 0; Arity: 6; Name: 'arrbuild'; ),
    ( Encoding: OP_ARRSUBSET     ; CCType: 0; Arity: 4; Name: 'arrsubset'; ),
    ( Encoding: OP_ARRINIT       ; CCType: 0; Arity: 3; Name: 'arrinit'; ),
    ( Encoding: OP_MOV           ; CCType: 0; Arity: 2; Name: 'mov'; ),
    ( Encoding: OP_SET           ; CCType: 0; Arity: 2; Name: 'set'; ),
    ( Encoding: OP_FLATTEN       ; CCType: 0; Arity: 2; Name: 'flatten'; ),
    ( Encoding: OP_UNFLATTEN     ; CCType: 0; Arity: 4; Name: 'unflatten'; ),
    ( Encoding: OP_NUMTOSTRING   ; CCType: 0; Arity: 2; Name: 'numtostr'; ),
    ( Encoding: OP_STRINGTONUM   ; CCType: 0; Arity: 5; Name: 'strtonum'; ),
    ( Encoding: OP_STRCAT        ; CCType: 0; Arity: 6; Name: 'strcat'; ),
    ( Encoding: OP_STRSUBSET     ; CCType: 0; Arity: 4; Name: 'strsubset'; ),
    ( Encoding: OP_STRTOBYTEARR  ; CCType: 0; Arity: 2; Name: 'strtoarr'; ),
    ( Encoding: OP_BYTEARRTOSTR  ; CCType: 0; Arity: 2; Name: 'arrtostr'; ),
    ( Encoding: OP_JMP           ; CCType: 0; Arity: 1; Name: 'jmp'; ),
    ( Encoding: OP_BRCMP         ; CCType: 2; Arity: 3; Name: 'brcmp'; ),
    ( Encoding: OP_BRTST         ; CCType: 1; Arity: 2; Name: 'brtst'; ),
    ( Encoding: OP_SYSCALL       ; CCType: 0; Arity: 2; Name: 'syscall'; ),
    ( Encoding: OP_STOP          ; CCType: 0; Arity: 1; Name: 'stop'; ),
    ( Encoding: OP_FINCLUMP      ; CCType: 0; Arity: 2; Name: 'exit'; ),
    ( Encoding: OP_FINCLUMPIMMED ; CCType: 0; Arity: 1; Name: 'exitto'; ),
    ( Encoding: OP_ACQUIRE       ; CCType: 0; Arity: 1; Name: 'acquire'; ),
    ( Encoding: OP_RELEASE       ; CCType: 0; Arity: 1; Name: 'release'; ),
    ( Encoding: OP_SUBCALL       ; CCType: 0; Arity: 2; Name: 'subcall'; ),
    ( Encoding: OP_SUBRET        ; CCType: 0; Arity: 1; Name: 'subret'; ),
    ( Encoding: OP_SETIN         ; CCType: 0; Arity: 3; Name: 'setin'; ),
    ( Encoding: OP_SETOUT        ; CCType: 0; Arity: 6; Name: 'setout'; ),
    ( Encoding: OP_GETIN         ; CCType: 0; Arity: 3; Name: 'getin'; ),
    ( Encoding: OP_GETOUT        ; CCType: 0; Arity: 3; Name: 'getout'; ),
    ( Encoding: OP_WAIT          ; CCType: 0; Arity: 1; Name: 'wait'; ),
    ( Encoding: OP_GETTICK       ; CCType: 0; Arity: 1; Name: 'gettick'; ),
// enhanced firmware opcodes
    ( Encoding: OPS_WAITV        ; CCType: 0; Arity: 1; Name: 'waitv'; ),
    ( Encoding: OPS_ABS          ; CCType: 0; Arity: 2; Name: 'abs'; ),
    ( Encoding: OPS_SIGN         ; CCType: 0; Arity: 2; Name: 'sign'; ),
    ( Encoding: OPS_STOPCLUMP    ; CCType: 0; Arity: 1; Name: 'stopthread'; ),
    ( Encoding: OPS_START        ; CCType: 0; Arity: 1; Name: 'start'; ),
    ( Encoding: OPS_PRIORITY     ; CCType: 0; Arity: 2; Name: 'priority'; ),
    ( Encoding: OPS_FMTNUM       ; CCType: 0; Arity: 3; Name: 'fmtnum'; ),
    ( Encoding: OPS_ARROP        ; CCType: 0; Arity: 5; Name: 'arrop'; ),
    ( Encoding: OPS_ACOS         ; CCType: 0; Arity: 2; Name: 'acos'; ),
    ( Encoding: OPS_ASIN         ; CCType: 0; Arity: 2; Name: 'asin'; ),
    ( Encoding: OPS_ATAN         ; CCType: 0; Arity: 2; Name: 'atan'; ),
    ( Encoding: OPS_CEIL         ; CCType: 0; Arity: 2; Name: 'ceil'; ),
    ( Encoding: OPS_EXP          ; CCType: 0; Arity: 2; Name: 'exp'; ),
    ( Encoding: OPS_FABS         ; CCType: 0; Arity: 2; Name: 'fabs'; ),
    ( Encoding: OPS_FLOOR        ; CCType: 0; Arity: 2; Name: 'floor'; ),
    ( Encoding: OPS_SQRT         ; CCType: 0; Arity: 2; Name: 'sqrt'; ),
    ( Encoding: OPS_TAN          ; CCType: 0; Arity: 2; Name: 'tan'; ),
    ( Encoding: OPS_TANH         ; CCType: 0; Arity: 2; Name: 'tanh'; ),
    ( Encoding: OPS_COS          ; CCType: 0; Arity: 2; Name: 'cos'; ),
    ( Encoding: OPS_COSH         ; CCType: 0; Arity: 2; Name: 'cosh'; ),
    ( Encoding: OPS_LOG          ; CCType: 0; Arity: 2; Name: 'log'; ),
    ( Encoding: OPS_LOG10        ; CCType: 0; Arity: 2; Name: 'log10'; ),
    ( Encoding: OPS_SIN          ; CCType: 0; Arity: 2; Name: 'sin'; ),
    ( Encoding: OPS_SINH         ; CCType: 0; Arity: 2; Name: 'sinh'; ),
    ( Encoding: OPS_ATAN2        ; CCType: 0; Arity: 3; Name: 'atan2'; ),
    ( Encoding: OPS_FMOD         ; CCType: 0; Arity: 3; Name: 'fmod'; ),
    ( Encoding: OPS_POW          ; CCType: 0; Arity: 3; Name: 'pow'; ),
// pseudo-opcodes
    ( Encoding: OPS_THREAD       ; CCType: 0; Arity: 0; Name: 'thread'; ),
    ( Encoding: OPS_ENDT         ; CCType: 0; Arity: 0; Name: 'endt'; ),
    ( Encoding: OPS_SUBROUTINE   ; CCType: 0; Arity: 0; Name: 'subroutine'; ),
    ( Encoding: OPS_REQUIRES     ; CCType: 0; Arity: 0; Name: 'follows'; ),
    ( Encoding: OPS_USES         ; CCType: 0; Arity: 0; Name: STR_USES; ),
    ( Encoding: OPS_SEGMENT      ; CCType: 0; Arity: 0; Name: 'segment'; ),
    ( Encoding: OPS_ENDS         ; CCType: 0; Arity: 0; Name: 'ends'; ),
    ( Encoding: OPS_TYPEDEF      ; CCType: 0; Arity: 0; Name: 'typedef'; ),
    ( Encoding: OPS_STRUCT       ; CCType: 0; Arity: 0; Name: 'struct'; ),
    ( Encoding: OPS_DB           ; CCType: 0; Arity: 0; Name: 'db'; ),
    ( Encoding: OPS_BYTE         ; CCType: 0; Arity: 0; Name: 'byte'; ),
    ( Encoding: OPS_SBYTE        ; CCType: 0; Arity: 0; Name: 'sbyte'; ),
    ( Encoding: OPS_UBYTE        ; CCType: 0; Arity: 0; Name: 'ubyte'; ),
    ( Encoding: OPS_DW           ; CCType: 0; Arity: 0; Name: 'dw'; ),
    ( Encoding: OPS_WORD         ; CCType: 0; Arity: 0; Name: 'word'; ),
    ( Encoding: OPS_SWORD        ; CCType: 0; Arity: 0; Name: 'sword'; ),
    ( Encoding: OPS_UWORD        ; CCType: 0; Arity: 0; Name: 'uword'; ),
    ( Encoding: OPS_DD           ; CCType: 0; Arity: 0; Name: 'dd'; ),
    ( Encoding: OPS_DWORD        ; CCType: 0; Arity: 0; Name: 'dword'; ),
    ( Encoding: OPS_SDWORD       ; CCType: 0; Arity: 0; Name: 'sdword'; ),
    ( Encoding: OPS_UDWORD       ; CCType: 0; Arity: 0; Name: 'udword'; ),
    ( Encoding: OPS_LONG         ; CCType: 0; Arity: 0; Name: 'long'; ),
    ( Encoding: OPS_SLONG        ; CCType: 0; Arity: 0; Name: 'slong'; ),
    ( Encoding: OPS_ULONG        ; CCType: 0; Arity: 0; Name: 'ulong'; ),
    ( Encoding: OPS_VOID         ; CCType: 0; Arity: 0; Name: 'void'; ),
    ( Encoding: OPS_MUTEX        ; CCType: 0; Arity: 0; Name: 'mutex'; ),
    ( Encoding: OPS_FLOAT        ; CCType: 0; Arity: 0; Name: 'float'; ),
    ( Encoding: OPS_CALL         ; CCType: 0; Arity: 1; Name: 'call'; ),
    ( Encoding: OPS_RETURN       ; CCType: 0; Arity: 0; Name: 'return'; ),
    ( Encoding: OPS_STRINDEX     ; CCType: 0; Arity: 3; Name: 'strindex'; ),
    ( Encoding: OPS_STRREPLACE   ; CCType: 0; Arity: 4; Name: 'strreplace'; ),
    ( Encoding: OPS_SHL          ; CCType: 0; Arity: 3; Name: 'shl'; ),
    ( Encoding: OPS_SHR          ; CCType: 0; Arity: 3; Name: 'shr'; ),
    ( Encoding: OPS_STRLEN       ; CCType: 0; Arity: 2; Name: 'strlen'; ),
    ( Encoding: OPS_COMPCHK      ; CCType: 0; Arity: 3; Name: 'compchk'; ),
    ( Encoding: OPS_COMPIF       ; CCType: 0; Arity: 3; Name: 'compif'; ),
    ( Encoding: OPS_COMPELSE     ; CCType: 0; Arity: 0; Name: 'compelse'; ),
    ( Encoding: OPS_COMPEND      ; CCType: 0; Arity: 0; Name: 'compend'; ),
    ( Encoding: OPS_COMPCHKTYPE  ; CCType: 0; Arity: 2; Name: 'compchktype'; )
  );

  StandardOpcodeCount2x = 56;
  EnhancedOpcodeCount2x = 37;
  PseudoOpcodeCount2x   = 39;
  NXTInstructionsCount2x = StandardOpcodeCount2x+EnhancedOpcodeCount2x+PseudoOpcodeCount2x;
  NXTInstructions2x : array[0..NXTInstructionsCount2x-1] of NXTInstruction =
  (
    ( Encoding: OP_ADD           ; CCType: 0; Arity: 3; Name: 'add'; ),
    ( Encoding: OP_SUB           ; CCType: 0; Arity: 3; Name: 'sub'; ),
    ( Encoding: OP_NEG           ; CCType: 0; Arity: 2; Name: 'neg'; ),
    ( Encoding: OP_MUL           ; CCType: 0; Arity: 3; Name: 'mul'; ),
    ( Encoding: OP_DIV           ; CCType: 0; Arity: 3; Name: 'div'; ),
    ( Encoding: OP_MOD           ; CCType: 0; Arity: 3; Name: 'mod'; ),
    ( Encoding: OP_AND           ; CCType: 0; Arity: 3; Name: 'and'; ),
    ( Encoding: OP_OR            ; CCType: 0; Arity: 3; Name: 'or'; ),
    ( Encoding: OP_XOR           ; CCType: 0; Arity: 3; Name: 'xor'; ),
    ( Encoding: OP_NOT           ; CCType: 0; Arity: 2; Name: 'not'; ),
    ( Encoding: OP_CMNT          ; CCType: 0; Arity: 2; Name: 'cmnt'; ),
    ( Encoding: OP_LSL           ; CCType: 0; Arity: 3; Name: 'lsl'; ),
    ( Encoding: OP_LSR           ; CCType: 0; Arity: 3; Name: 'lsr'; ),
    ( Encoding: OP_ASL           ; CCType: 0; Arity: 3; Name: 'asl'; ),
    ( Encoding: OP_ASR           ; CCType: 0; Arity: 3; Name: 'asr'; ),
    ( Encoding: OP_ROTL          ; CCType: 0; Arity: 3; Name: 'rotl'; ),
    ( Encoding: OP_ROTR          ; CCType: 0; Arity: 3; Name: 'rotr'; ),
    ( Encoding: OP_CMP           ; CCType: 2; Arity: 3; Name: 'cmp'; ),
    ( Encoding: OP_TST           ; CCType: 1; Arity: 2; Name: 'tst'; ),
    ( Encoding: OP_CMPSET        ; CCType: 2; Arity: 4; Name: 'cmpset'; ),
    ( Encoding: OP_TSTSET        ; CCType: 1; Arity: 3; Name: 'tstset'; ),
    ( Encoding: OP_INDEX         ; CCType: 0; Arity: 3; Name: 'index'; ),
    ( Encoding: OP_REPLACE       ; CCType: 0; Arity: 4; Name: 'replace'; ),
    ( Encoding: OP_ARRSIZE       ; CCType: 0; Arity: 2; Name: 'arrsize'; ),
    ( Encoding: OP_ARRBUILD      ; CCType: 0; Arity: 6; Name: 'arrbuild'; ),
    ( Encoding: OP_ARRSUBSET     ; CCType: 0; Arity: 4; Name: 'arrsubset'; ),
    ( Encoding: OP_ARRINIT       ; CCType: 0; Arity: 3; Name: 'arrinit'; ),
    ( Encoding: OP_MOV           ; CCType: 0; Arity: 2; Name: 'mov'; ),
    ( Encoding: OP_SET           ; CCType: 0; Arity: 2; Name: 'set'; ),
    ( Encoding: OP_FLATTEN       ; CCType: 0; Arity: 2; Name: 'flatten'; ),
    ( Encoding: OP_UNFLATTEN     ; CCType: 0; Arity: 4; Name: 'unflatten'; ),
    ( Encoding: OP_NUMTOSTRING   ; CCType: 0; Arity: 2; Name: 'numtostr'; ),
    ( Encoding: OP_STRINGTONUM   ; CCType: 0; Arity: 5; Name: 'strtonum'; ),
    ( Encoding: OP_STRCAT        ; CCType: 0; Arity: 6; Name: 'strcat'; ),
    ( Encoding: OP_STRSUBSET     ; CCType: 0; Arity: 4; Name: 'strsubset'; ),
    ( Encoding: OP_STRTOBYTEARR  ; CCType: 0; Arity: 2; Name: 'strtoarr'; ),
    ( Encoding: OP_BYTEARRTOSTR  ; CCType: 0; Arity: 2; Name: 'arrtostr'; ),
    ( Encoding: OP_JMP           ; CCType: 0; Arity: 1; Name: 'jmp'; ),
    ( Encoding: OP_BRCMP         ; CCType: 2; Arity: 3; Name: 'brcmp'; ),
    ( Encoding: OP_BRTST         ; CCType: 1; Arity: 2; Name: 'brtst'; ),
    ( Encoding: OP_SYSCALL       ; CCType: 0; Arity: 2; Name: 'syscall'; ),
    ( Encoding: OP_STOP          ; CCType: 0; Arity: 1; Name: 'stop'; ),
    ( Encoding: OP_FINCLUMP      ; CCType: 0; Arity: 2; Name: 'exit'; ),
    ( Encoding: OP_FINCLUMPIMMED ; CCType: 0; Arity: 1; Name: 'exitto'; ),
    ( Encoding: OP_ACQUIRE       ; CCType: 0; Arity: 1; Name: 'acquire'; ),
    ( Encoding: OP_RELEASE       ; CCType: 0; Arity: 1; Name: 'release'; ),
    ( Encoding: OP_SUBCALL       ; CCType: 0; Arity: 2; Name: 'subcall'; ),
    ( Encoding: OP_SUBRET        ; CCType: 0; Arity: 1; Name: 'subret'; ),
    ( Encoding: OP_SETIN         ; CCType: 0; Arity: 3; Name: 'setin'; ),
    ( Encoding: OP_SETOUT        ; CCType: 0; Arity: 6; Name: 'setout'; ),
    ( Encoding: OP_GETIN         ; CCType: 0; Arity: 3; Name: 'getin'; ),
    ( Encoding: OP_GETOUT        ; CCType: 0; Arity: 3; Name: 'getout'; ),
    ( Encoding: OP_WAIT          ; CCType: 0; Arity: 2; Name: 'wait2'; ),
    ( Encoding: OP_GETTICK       ; CCType: 0; Arity: 1; Name: 'gettick'; ),
    ( Encoding: OP_SQRT_2        ; CCType: 0; Arity: 2; Name: 'sqrt'; ),
    ( Encoding: OP_ABS_2         ; CCType: 0; Arity: 2; Name: 'abs'; ),
// enhanced firmware opcodes
    ( Encoding: OPS_WAITI_2      ; CCType: 0; Arity: 1; Name: 'wait'; ),
    ( Encoding: OPS_WAITV_2      ; CCType: 0; Arity: 1; Name: 'waitv'; ),
    ( Encoding: OPS_SIGN_2       ; CCType: 0; Arity: 2; Name: 'sign'; ),
    ( Encoding: OPS_STOPCLUMP_2  ; CCType: 0; Arity: 1; Name: 'stopthread'; ),
    ( Encoding: OPS_START_2      ; CCType: 0; Arity: 1; Name: 'start'; ),
    ( Encoding: OPS_PRIORITY_2   ; CCType: 0; Arity: 2; Name: 'priority'; ),
    ( Encoding: OPS_FMTNUM_2     ; CCType: 0; Arity: 3; Name: 'fmtnum'; ),
    ( Encoding: OPS_ARROP_2      ; CCType: 0; Arity: 5; Name: 'arrop'; ),
    ( Encoding: OPS_ACOS_2       ; CCType: 0; Arity: 2; Name: 'acos'; ),
    ( Encoding: OPS_ASIN_2       ; CCType: 0; Arity: 2; Name: 'asin'; ),
    ( Encoding: OPS_ATAN_2       ; CCType: 0; Arity: 2; Name: 'atan'; ),
    ( Encoding: OPS_CEIL_2       ; CCType: 0; Arity: 2; Name: 'ceil'; ),
    ( Encoding: OPS_EXP_2        ; CCType: 0; Arity: 2; Name: 'exp'; ),
    ( Encoding: OPS_FLOOR_2      ; CCType: 0; Arity: 2; Name: 'floor'; ),
    ( Encoding: OPS_TAN_2        ; CCType: 0; Arity: 2; Name: 'tan'; ),
    ( Encoding: OPS_TANH_2       ; CCType: 0; Arity: 2; Name: 'tanh'; ),
    ( Encoding: OPS_COS_2        ; CCType: 0; Arity: 2; Name: 'cos'; ),
    ( Encoding: OPS_COSH_2       ; CCType: 0; Arity: 2; Name: 'cosh'; ),
    ( Encoding: OPS_LOG_2        ; CCType: 0; Arity: 2; Name: 'log'; ),
    ( Encoding: OPS_LOG10_2      ; CCType: 0; Arity: 2; Name: 'log10'; ),
    ( Encoding: OPS_SIN_2        ; CCType: 0; Arity: 2; Name: 'sin'; ),
    ( Encoding: OPS_SINH_2       ; CCType: 0; Arity: 2; Name: 'sinh'; ),
    ( Encoding: OPS_TRUNC_2      ; CCType: 0; Arity: 2; Name: 'trunc'; ),
    ( Encoding: OPS_FRAC_2       ; CCType: 0; Arity: 2; Name: 'frac'; ),
    ( Encoding: OPS_ATAN2_2      ; CCType: 0; Arity: 3; Name: 'atan2'; ),
    ( Encoding: OPS_POW_2        ; CCType: 0; Arity: 3; Name: 'pow'; ),
    ( Encoding: OPS_MULDIV_2     ; CCType: 0; Arity: 4; Name: 'muldiv'; ),
    ( Encoding: OPS_ACOSD_2      ; CCType: 0; Arity: 2; Name: 'acosd'; ),
    ( Encoding: OPS_ASIND_2      ; CCType: 0; Arity: 2; Name: 'asind'; ),
    ( Encoding: OPS_ATAND_2      ; CCType: 0; Arity: 2; Name: 'atand'; ),
    ( Encoding: OPS_TAND_2       ; CCType: 0; Arity: 2; Name: 'tand'; ),
    ( Encoding: OPS_TANHD_2      ; CCType: 0; Arity: 2; Name: 'tanhd'; ),
    ( Encoding: OPS_COSD_2       ; CCType: 0; Arity: 2; Name: 'cosd'; ),
    ( Encoding: OPS_COSHD_2      ; CCType: 0; Arity: 2; Name: 'coshd'; ),
    ( Encoding: OPS_SIND_2       ; CCType: 0; Arity: 2; Name: 'sind'; ),
    ( Encoding: OPS_SINHD_2      ; CCType: 0; Arity: 2; Name: 'sinhd'; ),
    ( Encoding: OPS_ATAN2D_2     ; CCType: 0; Arity: 3; Name: 'atan2d'; ),
// pseudo-opcodes
    ( Encoding: OPS_THREAD       ; CCType: 0; Arity: 0; Name: 'thread'; ),
    ( Encoding: OPS_ENDT         ; CCType: 0; Arity: 0; Name: 'endt'; ),
    ( Encoding: OPS_SUBROUTINE   ; CCType: 0; Arity: 0; Name: 'subroutine'; ),
    ( Encoding: OPS_REQUIRES     ; CCType: 0; Arity: 0; Name: 'follows'; ),
    ( Encoding: OPS_USES         ; CCType: 0; Arity: 0; Name: STR_USES; ),
    ( Encoding: OPS_SEGMENT      ; CCType: 0; Arity: 0; Name: 'segment'; ),
    ( Encoding: OPS_ENDS         ; CCType: 0; Arity: 0; Name: 'ends'; ),
    ( Encoding: OPS_TYPEDEF      ; CCType: 0; Arity: 0; Name: 'typedef'; ),
    ( Encoding: OPS_STRUCT       ; CCType: 0; Arity: 0; Name: 'struct'; ),
    ( Encoding: OPS_DB           ; CCType: 0; Arity: 0; Name: 'db'; ),
    ( Encoding: OPS_BYTE         ; CCType: 0; Arity: 0; Name: 'byte'; ),
    ( Encoding: OPS_SBYTE        ; CCType: 0; Arity: 0; Name: 'sbyte'; ),
    ( Encoding: OPS_UBYTE        ; CCType: 0; Arity: 0; Name: 'ubyte'; ),
    ( Encoding: OPS_DW           ; CCType: 0; Arity: 0; Name: 'dw'; ),
    ( Encoding: OPS_WORD         ; CCType: 0; Arity: 0; Name: 'word'; ),
    ( Encoding: OPS_SWORD        ; CCType: 0; Arity: 0; Name: 'sword'; ),
    ( Encoding: OPS_UWORD        ; CCType: 0; Arity: 0; Name: 'uword'; ),
    ( Encoding: OPS_DD           ; CCType: 0; Arity: 0; Name: 'dd'; ),
    ( Encoding: OPS_DWORD        ; CCType: 0; Arity: 0; Name: 'dword'; ),
    ( Encoding: OPS_SDWORD       ; CCType: 0; Arity: 0; Name: 'sdword'; ),
    ( Encoding: OPS_UDWORD       ; CCType: 0; Arity: 0; Name: 'udword'; ),
    ( Encoding: OPS_LONG         ; CCType: 0; Arity: 0; Name: 'long'; ),
    ( Encoding: OPS_SLONG        ; CCType: 0; Arity: 0; Name: 'slong'; ),
    ( Encoding: OPS_ULONG        ; CCType: 0; Arity: 0; Name: 'ulong'; ),
    ( Encoding: OPS_VOID         ; CCType: 0; Arity: 0; Name: 'void'; ),
    ( Encoding: OPS_MUTEX        ; CCType: 0; Arity: 0; Name: 'mutex'; ),
    ( Encoding: OPS_FLOAT        ; CCType: 0; Arity: 0; Name: 'float'; ),
    ( Encoding: OPS_CALL         ; CCType: 0; Arity: 1; Name: 'call'; ),
    ( Encoding: OPS_RETURN       ; CCType: 0; Arity: 0; Name: 'return'; ),
    ( Encoding: OPS_STRINDEX     ; CCType: 0; Arity: 3; Name: 'strindex'; ),
    ( Encoding: OPS_STRREPLACE   ; CCType: 0; Arity: 4; Name: 'strreplace'; ),
    ( Encoding: OPS_SHL          ; CCType: 0; Arity: 3; Name: 'shl'; ),
    ( Encoding: OPS_SHR          ; CCType: 0; Arity: 3; Name: 'shr'; ),
    ( Encoding: OPS_STRLEN       ; CCType: 0; Arity: 2; Name: 'strlen'; ),
    ( Encoding: OPS_COMPCHK      ; CCType: 0; Arity: 3; Name: 'compchk'; ),
    ( Encoding: OPS_COMPIF       ; CCType: 0; Arity: 3; Name: 'compif'; ),
    ( Encoding: OPS_COMPELSE     ; CCType: 0; Arity: 0; Name: 'compelse'; ),
    ( Encoding: OPS_COMPEND      ; CCType: 0; Arity: 0; Name: 'compend'; ),
    ( Encoding: OPS_COMPCHKTYPE  ; CCType: 0; Arity: 2; Name: 'compchktype'; )
  );

type
  ShortOpEncoding = record
    Encoding : Byte;
    LongEncoding : TOpCode;
    GCName : String;
    ShortOp : String;
  end;

const
  ShortOpEncodingsCount = 4;
  ShortOpEncodings : array[0..ShortOpEncodingsCount-1] of ShortOpEncoding =
  (
    ( Encoding: 0; LongEncoding: OP_MOV    ; GCName: 'MOV'    ; ShortOp: 'OP_MOV'; ),
    ( Encoding: 1; LongEncoding: OP_ACQUIRE; GCName: 'ACQUIRE'; ShortOp: 'OP_ACQUIRE'; ),
    ( Encoding: 2; LongEncoding: OP_RELEASE; GCName: 'RELEASE'; ShortOp: 'OP_RELEASE'; ),
    ( Encoding: 3; LongEncoding: OP_SUBCALL; GCName: 'SUBCALL'; ShortOp: 'OP_SUBCALL'; )
  );

const
  TC_VOID    = 0;
  TC_UBYTE   = 1;
  TC_SBYTE   = 2;
  TC_UWORD   = 3;
  TC_SWORD   = 4;
  TC_ULONG   = 5;
  TC_SLONG   = 6;
  TC_ARRAY   = 7;
  TC_CLUSTER = 8;
  TC_MUTEX   = 9;
  TC_FLOAT   = 10;

const
  SHOP_MASK = $08; // b00001000
  INST_MASK = $F0; // b11110000
  CC_MASK   = $07; // b00000111

function TypeToStr(const TypeDesc : byte) : string; overload;
function TypeToStr(const aType : TDSType) : string; overload;
function StrToType(const stype : string; bUseCase : Boolean = false) : TDSType;
function GenerateTOCName(const TypeDesc : byte; const idx : Int64; const fmt : string = '%s%4.4x') : string;
function ShortOpEncoded(const b : byte) : boolean;
function CompareCodeToStr(const cc : byte) : string;
function ShortOpToLongOp(const op : byte) : TOpCode;
function GenericIDToStr(genIDs : array of IDRec; const ID : integer) : string;
function SysCallMethodIDToStr(const fver : word; const ID : integer) : string;
function InputFieldIDToStr(const ID : integer) : string;
function OutputFieldIDToStr(const ID : integer) : string;

procedure LoadRXEHeader(H : TRXEHeader; aStream : TStream);
procedure LoadRXEDataSpace(H : TRXEHeader; DS : TDSData; aStream : TStream);
procedure LoadRXEClumpRecords(H : TRXEHeader; CD : TClumpData; aStream : TStream);
procedure LoadRXECodeSpace(H : TRXEHeader; CS : TCodeSpaceAry; aStream : TStream);

function GetArgDataType(val : Extended): TDSType;
function ExpectedArgType(const firmVer : word; const op : TOpCode; const argIdx: integer): TAsmArgType;
function ProcessCluster(aDS : TDSData; Item : TDataspaceEntry; idx : Integer;
  var staticIndex : Integer) : integer;

function GetTypeHint(DSpace : TDataspace; const aLine: TASMLine;
  const idx : integer; bEnhanced : boolean): TDSType;
function CreateConstantVar(DSpace : TDataspace; val : Extended;
  bIncCount : boolean; aTypeHint : TDSType = dsVoid) : string;

procedure InstantiateCluster(DD : TDataDefs; DE: TDataspaceEntry; const clustername: string);
procedure HandleVarDecl(DD : TDataDefs; NT : TMapList; bCaseSensitive : boolean;
  DSE : TDataspaceEntry; albl, aopcode : string; sttFunc : TSTTFuncType);


implementation

uses
  StrUtils, Math, uNBCLexer, uCommonUtils, uVersionInfo, uLocalizedStrings,
  {$IFDEF FAST_MM}FastStrings, {$ENDIF}
  NBCCommonData, NXTDefsData;

const
  CLUMP_FMT = 't%3.3d';
  DWORD_LEN = 4;

  SubroutineReturnAddressType = dsUByte;

type
  TCardinalObject = class
  protected
    fValue : Cardinal;
  public
    constructor Create(aValue : Cardinal);
    property Value : Cardinal read fValue;
  end;

  TIntegerObject = class
  protected
    fValue : Integer;
  public
    constructor Create(aValue : Integer);
    property Value : Integer read fValue;
  end;

  TSpecialFunctionExecute = procedure(Arg : TAsmArgument; const left, right, name : string) of object;

  TSpecialFunction = class
  private
    fFunc: string;
    fExecute: TSpecialFunctionExecute;
  public
    property Func : string read fFunc write fFunc;
    property Execute : TSpecialFunctionExecute read fExecute write fExecute;
  end;

function QuotedString(const sargs : string) : boolean;
var
  p1, len, L1, p2, L2 : integer;
begin
  len := Length(sargs);
  p1 := Pos('''', sargs);
  p2 := Pos('"', sargs);
  L1 := LastDelimiter('''', sargs);
  L2 := LastDelimiter('"', sargs);
  Result := ((p1 = 1) and (L1 = len)) or ((p2 = 1) and (L2 = len));
end;

function StripExtraQuotes(str : string) : string;
var
  tmp : string;
begin
  Result := str;
  while true do
  begin
    if QuotedString(Result) then
    begin
      tmp := Result;
      System.Delete(tmp, 1, 1);
      System.Delete(tmp, Length(tmp), 1);
      if QuotedString(tmp) then
      begin
        // we have a string with a duplicate set of quotation marks
        Result := tmp;
      end
      else
        break;
    end
    else
      break;
  end;
end;

function Replace(const str : string; const src, rep : string) : string;
begin
{$IFDEF FAST_MM}
  Result := FastReplace(str, src, rep, True);
{$ELSE}
  Result := StringReplace(str, src, rep, [rfReplaceAll]);
{$ENDIF}
end;

function IndexOfIOMapID(iomapID : integer) : integer;
var
  i : integer;
begin
  Result := -1;
  for i := Low(IOMapFieldIDs) to High(IOMapFieldIDs) do
  begin
    if IOMapFieldIDs[i].ID = iomapID then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function IndexOfIOMapName(const aName : string) : integer;
var
  i : integer;
begin
  Result := -1;
  for i := Low(IOMapFieldIDs) to High(IOMapFieldIDs) do
  begin
    if IOMapFieldIDs[i].Name = aName then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function LongOpToShortOp(op : TOpCode) : ShortInt;
var
  i : integer;
  SOE : ShortOpEncoding;
begin
  Result := -1;
  for i := Low(ShortOpEncodings) to High(ShortOpEncodings) do
  begin
    SOE := ShortOpEncodings[i];
    if SOE.LongEncoding = op then
    begin
      Result := SOE.Encoding;
      Break;
    end;
  end;
end;

function TypeToStr(const aType : TDSType) : string;
begin
  Result := TypeToStr(Byte(Ord(aType)));
end;

const
  NXTTypes : array[0..17] of NXTInstruction =
   (
    ( Encoding: OPS_DB           ; CCType: 0; Arity: 0; Name: 'db'; ),
    ( Encoding: OPS_BYTE         ; CCType: 0; Arity: 0; Name: 'byte'; ),
    ( Encoding: OPS_SBYTE        ; CCType: 0; Arity: 0; Name: 'sbyte'; ),
    ( Encoding: OPS_UBYTE        ; CCType: 0; Arity: 0; Name: 'ubyte'; ),
    ( Encoding: OPS_DW           ; CCType: 0; Arity: 0; Name: 'dw'; ),
    ( Encoding: OPS_WORD         ; CCType: 0; Arity: 0; Name: 'word'; ),
    ( Encoding: OPS_SWORD        ; CCType: 0; Arity: 0; Name: 'sword'; ),
    ( Encoding: OPS_UWORD        ; CCType: 0; Arity: 0; Name: 'uword'; ),
    ( Encoding: OPS_DD           ; CCType: 0; Arity: 0; Name: 'dd'; ),
    ( Encoding: OPS_DWORD        ; CCType: 0; Arity: 0; Name: 'dword'; ),
    ( Encoding: OPS_SDWORD       ; CCType: 0; Arity: 0; Name: 'sdword'; ),
    ( Encoding: OPS_UDWORD       ; CCType: 0; Arity: 0; Name: 'udword'; ),
    ( Encoding: OPS_LONG         ; CCType: 0; Arity: 0; Name: 'long'; ),
    ( Encoding: OPS_SLONG        ; CCType: 0; Arity: 0; Name: 'slong'; ),
    ( Encoding: OPS_ULONG        ; CCType: 0; Arity: 0; Name: 'ulong'; ),
    ( Encoding: OPS_VOID         ; CCType: 0; Arity: 0; Name: 'void'; ),
    ( Encoding: OPS_MUTEX        ; CCType: 0; Arity: 0; Name: 'mutex'; ),
    ( Encoding: OPS_FLOAT        ; CCType: 0; Arity: 0; Name: 'float'; )
   );

function StrToType(const stype : string; bUseCase : Boolean = false) : TDSType;
var
  op : TOpCode;
  i : integer;
  tmpName : string;
begin
  op := OPS_INVALID;
  for i := Low(NXTTypes) to High(NXTTypes) do
  begin
    if bUseCase then
      tmpName := stype
    else
      tmpName := AnsiLowerCase(stype);
    if NXTTypes[i].Name = tmpName then
    begin
      op := NXTTypes[i].Encoding;
      break;
    end;
  end;
  case op of
    OPS_DB,
    OPS_BYTE,
    OPS_UBYTE  : Result := dsUByte;
    OPS_SBYTE  : Result := dsSByte;
    OPS_DW,
    OPS_WORD,
    OPS_UWORD  : Result := dsUWord;
    OPS_SWORD  : Result := dsSWord;
    OPS_DD,
    OPS_DWORD,
    OPS_UDWORD,
    OPS_LONG,
    OPS_ULONG  : Result := dsULong;
    OPS_SDWORD,
    OPS_SLONG  : Result := dsSLong;
    OPS_MUTEX  : Result := dsMutex;
    OPS_FLOAT  : Result := dsFloat;
  else
    Result := dsVoid;
  end;
end;

{$ifdef FPC}
function CardinalToSingle(const cVal : Cardinal) : Single;
begin
  Result := Single(cVal);
end;

function SingleToCardinal(const sVal : Single) : Cardinal;
begin
  Result := Cardinal(sVal);
end;
{$else}
function CardinalToSingle(const cVal : Cardinal) : Single;
begin
  Result := Single(Pointer(cVal));
end;

function SingleToCardinal(const sVal : Single) : Cardinal;
begin
  Result := Cardinal(Pointer(sVal));
end;
{$endif}

function ValToStr(const aType : TDSType; aVal : Cardinal) : string;
begin
  if aVal = 0 then
    Result := '' // don't output question marks needlessly
  else
    case aType of
      dsVoid : Result := '';
      dsUByte : Result := Format('%u', [Byte(aVal)]);
      dsSByte : Result := Format('%d', [Shortint(aVal)]);
      dsUWord : Result := Format('%u', [Word(aVal)]);
      dsSWord : Result := Format('%d', [Smallint(aVal)]);
      dsULong : Result := Format('%u', [aVal]);
      dsSLong : Result := Format('%d', [Integer(aVal)]);
      dsMutex : Result := Format('%u', [aVal]);
      dsArray : Result := '';
      dsCluster : Result := '';
      dsFloat : Result := NBCFloatToStr(CardinalToSingle(aVal));
    else
      Result := '???';
    end;
end;

function TypeToStr(const TypeDesc : byte) : string;
begin
  case TypeDesc of
    TC_VOID : Result := 'void';
    TC_UBYTE : Result := 'byte';
    TC_SBYTE : Result := 'sbyte';
    TC_UWORD : Result := 'word';
    TC_SWORD : Result := 'sword';
    TC_ULONG : Result := 'dword';
    TC_SLONG : Result := 'sdword';
    TC_ARRAY : Result := 'array';
    TC_CLUSTER : Result := 'struct';
    TC_MUTEX : Result := 'mutex';
    TC_FLOAT : Result := 'float';
  else
    Result := '????';
  end;
end;

function GenerateTOCName(const TypeDesc : byte; const idx : Int64; const fmt : string) : string;
var
  prefix : string;
begin
  case TypeDesc of
    TC_VOID : prefix := 'v';
    TC_UBYTE : prefix := 'ub';
    TC_SBYTE : prefix := 'sb';
    TC_UWORD : prefix := 'uw';
    TC_SWORD : prefix := 'sw';
    TC_ULONG : prefix := 'ul';
    TC_SLONG : prefix := 'sl';
    TC_ARRAY : prefix := 'a';
    TC_CLUSTER : prefix := 'c';
    TC_MUTEX : prefix := 'm';
    TC_FLOAT : prefix := 'f';
  else
    prefix := '?';
  end;
  Result := Format(fmt, [prefix, idx]);
end;

function ShortOpEncoded(const b : byte) : boolean;
begin
  Result := (SHOP_MASK and b) = SHOP_MASK;
end;

function CompareCodeToStr(const cc : byte) : string;
var
  i : integer;
begin
  Result := '??';
  for i := Low(CCEncodings) to High(CCEncodings) do
  begin
    if CCEncodings[i].Encoding = cc then
    begin
      Result := CCEncodings[i].Mode;
      break;
    end;
  end;
end;

function ValidCompareCode(const cc : byte) : boolean;
begin
  Result := CompareCodeToStr(cc) <> '??';
end;

function ShortOpToLongOp(const op : byte) : TOpCode;
var
  i : integer;
begin
  Result := TOpCode(op);
  for i := Low(ShortOpEncodings) to High(ShortOpEncodings) do
  begin
    if ShortOpEncodings[i].Encoding = op then
    begin
      Result := ShortOpEncodings[i].LongEncoding;
      break;
    end;
  end;
end;

function TRXEProgram.StrToOpcode(const op : string; bUseCase : boolean) : TOpCode;
var
  i : integer;
  tmpName : string;
begin
  Result := OPS_INVALID;
  for i := Low(fNXTInstructions) to High(fNXTInstructions) do
  begin
    if bUseCase then
      tmpName := op
    else
      tmpName := AnsiLowerCase(op);
    if fNXTInstructions[i].Name = tmpName then
    begin
      Result := fNXTInstructions[i].Encoding;
      break;
    end;
  end;
end;

function TRXEProgram.OpcodeToStr(const op : TOpCode) : string;
var
  i : integer;
begin
  if op <> OPS_INVALID then
    Result := Format('bad op (%d)', [Ord(op)])
  else
    Result := '';
  for i := Low(fNXTInstructions) to High(fNXTInstructions) do
  begin
    if fNXTInstructions[i].Encoding = op then
    begin
      Result := fNXTInstructions[i].Name;
      break;
    end;
  end;
end;

function GenericIDToStr(genIDs : array of IDRec; const ID : integer) : string;
var
  i : integer;
begin
  Result := Format('%d', [ID]);
  for i := Low(genIDs) to High(genIDs) do
  begin
    if genIDs[i].ID = ID then
    begin
      Result := genIDs[i].Name;
      break;
    end;
  end;
end;

function SysCallMethodIDToStr(const fver : word; const ID : integer) : string;
begin
  if fver > MAX_FW_VER1X then
    Result := GenericIDToStr(SysCallMethodIDs2x, ID)
  else
    Result := GenericIDToStr(SysCallMethodIDs1x, ID);
end;

function InputFieldIDToStr(const ID : integer) : string;
begin
  Result := GenericIDToStr(InputFieldIDs, ID);
end;

function OutputFieldIDToStr(const ID : integer) : string;
begin
  Result := GenericIDToStr(OutputFieldIDs, ID);
end;

function LineTypeToStr(lt : TAsmLineType) : string;
begin
  case lt of
    altBeginDS     : Result := 'Begin Datasegment';
    altEndDS       : Result := 'End Datasegment';
    altBeginClump  : Result := 'Begin thread';
    altEndClump    : Result := 'End Thread';
    altCode        : Result := 'Code';
    altVarDecl     : Result := 'Variable Declaration';
    altTypeDecl    : Result := 'Type Declaration';
    altBeginStruct : Result := 'Begin Structure';
    altEndStruct   : Result := 'End Structure';
    altBeginSub    : Result := 'Begin Subroutine';
    altEndSub      : Result := 'End Subroutine';
    altCodeDepends : Result := 'Thread Relationships';
    altInvalid     : Result := 'Invalid';
  else
    Result := 'Unknown Line Type';
  end;
end;

function LineTypesToStr(lts : TAsmLineTypes) : string;
var
  i : TAsmLineType;
begin
  Result := '[';
  for i := Low(TAsmLineType) to High(TAsmLinetype) do
  begin
    if i in lts then
      Result := Result + LineTypeToStr(i) + ', ';
  end;
  if Pos(',', Result) <> 0 then
    Delete(Result, Length(Result)-1, 2); // remove trailing comma + space
  Result := Result + ']';
end;

function AsmStateToStr(asmState : TMainAsmState) : string;
begin
  case asmState of
    masDataSegment,
    masDSClump,
    masDSClumpSub       : Result := 'Data Segment';
    masCodeSegment      : Result := 'Code Segment';
    masClump            : Result := 'Thread';
    masClumpSub         : Result := 'Subroutine';
    masStruct,
    masStructDSClump,
    masStructDSClumpSub : Result := 'Struct Definition';
    masBlockComment     : Result := 'Block Comment';
  else
    Result := 'Unknown';
  end;
end;

function SizeOfDSTocEntry : Integer;
begin
  Result := SizeOf(Byte)+SizeOf(Byte)+SizeOf(Word);
end;

procedure LoadRXEClumpRecords(H : TRXEHeader; CD : TClumpData; aStream: TStream);
var
  i, start, stop, depCount : integer;
begin
  if H.Head.Version <> 0 then
  begin
    start := SizeOf(RXEHeader)+(SizeOfDSTocEntry*H.Head.DSCount)+H.Head.DSDefaultsSize;
    // pad if start is an odd number
    if (start mod 2) <> 0 then
      inc(start);
    stop  := Integer(aStream.Size-(2*H.Head.CodespaceCount));
    aStream.Seek(start, soFromBeginning);
    SetLength(CD.CRecs, H.Head.ClumpCount);
    for i := 0 to H.Head.ClumpCount - 1 do
    begin
      aStream.Read(CD.CRecs[i].FireCount, 1);
      aStream.Read(CD.CRecs[i].DependentCount, 1);
      ReadWordFromStream(aStream, CD.CRecs[i].CodeStart);
    end;
    // now read the packed clump dependency list which is an array of byte
    // the number of bytes to read is stop-start-(4*ClumpCount).
    depCount := stop-start-(H.Head.ClumpCount*SizeOf(ClumpRecord));
    if depCount > 0 then
    begin
      aStream.Seek(start+(H.Head.ClumpCount*SizeOf(ClumpRecord)), soFromBeginning);
      SetLength(CD.ClumpDeps, depCount);
      i := 0;
      while i < depCount do
      begin
        aStream.Read(CD.ClumpDeps[i], SizeOf(Byte));
        inc(i);
      end;
    end;
  end;
end;

procedure TRXEDumper.DumpRXEClumpRecords(aStrings: TStrings);
var
  i, j, k : integer;
  tmpStr : string;
begin
  aStrings.Add('ClumpRecords');
  aStrings.Add('----------------');
  if fHeader.Head.Version <> 0 then
  begin
    aStrings.Add(Format('%d record(s) (Fire Cnt, Dependent Cnt, Code Start)', [fHeader.Head.ClumpCount]));
    for i := 0 to fHeader.Head.ClumpCount - 1 do
    begin
      with fClumpData.CRecs[i] do
        aStrings.Add(Format(CLUMP_FMT+': %2.2x %2.2x %4.4x',
          [i, FireCount, DependentCount, CodeStart]));
    end;
    // now output dependencies by clump
    k := 0;
    for i := 0 to Length(fClumpData.CRecs) - 1 do
    begin
      if fClumpData.CRecs[i].DependentCount > 0 then
      begin
        tmpStr := Format(CLUMP_FMT+' dependencies: ', [i]);
        for j := 0 to fClumpData.CRecs[i].DependentCount - 1 do
        begin
          tmpStr := tmpStr + Format(CLUMP_FMT+' ', [fClumpData.ClumpDeps[k]]);
          inc(k);
        end;
        aStrings.Add(tmpStr);
      end;
    end;
  end;
  aStrings.Add('----------------');
end;

function TRXEDumper.TOCNameFromArg(DS : TDSData; const argValue : word) : string;
var
  DE : TDataspaceEntry;
  i : integer;
begin
  if (fTmpDataspace.Count > 0) and (argValue < Length(DS.TOCNames)) then
  begin
    DE := fTmpDataspace.FindEntryByName(DS.TOCNames[argValue]);
    if Assigned(DE) then
      Result := DE.FullPathIdentifier
    else
    begin
      Result := DS.TOCNames[argValue];
    end;
  end
  else if argValue < Length(DS.TOCNames) then
    Result := DS.TOCNames[argValue]
  else
  begin
    // maybe an IO Map address???
    i := IndexOfIOMapID(argValue);
    if i <> -1 then
      Result := IOMapFieldIDs[i].Name
    else
      Result := Format(HEX_FMT, [argValue]);
  end;
end;

function TRXEDumper.ProcessInstructionArg(DS : TDSData; const addr : integer;
  const op : TOpCode; const argIdx: integer; const argValue: word): string;
var
  offset : SmallInt;
begin
  // this routine uses special handling for certain opcodes
  case op of
    OP_ADD, OP_SUB, OP_NEG, OP_MUL, OP_DIV, OP_MOD,
    OP_AND, OP_OR, OP_XOR, OP_NOT, OP_CMNT,
    OP_LSL, OP_LSR, OP_ASL, OP_ASR, OP_ROTL, OP_ROTR,
    OP_CMP, OP_TST, OP_CMPSET, OP_TSTSET,
    OP_MOV,
    OP_ARRSIZE, OP_ARRBUILD,
    OP_FLATTEN, OP_UNFLATTEN, OP_NUMTOSTRING,
    OP_STRCAT, OP_STRTOBYTEARR, OP_BYTEARRTOSTR,
    OP_ACQUIRE, OP_RELEASE, OP_SUBRET, OP_GETTICK :
    begin
      Result := TOCNameFromArg(DS, argValue);
    end;
    OP_STOP, OP_ARRINIT, OP_INDEX, OP_REPLACE,
    OP_ARRSUBSET, OP_STRSUBSET, OP_STRINGTONUM :
    begin
      if argValue = NOT_AN_ELEMENT then
        Result := STR_NA
      else
        Result := TOCNameFromArg(DS, argValue);
    end;
    OP_SET : begin
      if argIdx > 0 then
        Result := Format(HEX_FMT, [argValue])
      else
        Result := TOCNameFromArg(DS, argValue);
    end;
    OP_SUBCALL : begin
      if argIdx = 0 then
        Result := Format(CLUMP_FMT, [argValue])
      else
        Result := TOCNameFromArg(DS, argValue);
    end;
    OP_FINCLUMP : begin
      Result := Format('%d', [SmallInt(argValue)]);
    end;
    OP_FINCLUMPIMMED : begin
      Result := Format(CLUMP_FMT, [SmallInt(argValue)]);
    end;
    OP_JMP, OP_BRCMP, OP_BRTST : begin
      if argIdx = 0 then
      begin
        // the first argument is an offset and could be forward or reverse
        offset := SmallInt(argValue);
        // Instead of outputting the offset value we want to output a label
        // specifying the line to jump to
        Result := Format('lbl%4.4x', [addr+offset]);
        // we also need to store this address for post processing of the
        // output
        fFixups.Add(Format('%d', [addr+offset]));
      end
      else
        Result := TOCNameFromArg(DS, argValue);
    end;
    OP_SYSCALL : begin
      if argIdx = 0 then
        Result := SysCallMethodIDToStr(FirmwareVersion, argValue)
      else
        Result := TOCNameFromArg(DS, argValue);
    end;
    OP_SETIN, OP_GETIN : begin
      if argIdx = 2 then
        Result := InputFieldIDToStr(argValue)
      else
        Result := TOCNameFromArg(DS, argValue);
    end;
    OP_SETOUT : begin
      if (argIdx mod 2) = 1 then
        Result := OutputFieldIDToStr(argValue)
      else
        Result := TOCNameFromArg(DS, argValue);
    end;
    OP_GETOUT : begin
      if argIdx = 2 then
        Result := OutputFieldIDToStr(argValue)
      else
        Result := TOCNameFromArg(DS, argValue);
    end;
    OP_WAIT : begin
      if FirmwareVersion > MAX_FW_VER1X then
      begin
        if argValue = NOT_AN_ELEMENT then
          Result := STR_NA
        else
          Result := TOCNameFromArg(DS, argValue);
      end
      else
        Result := Format(HEX_FMT, [argValue]);
    end;
    OPS_WAITI_2 : begin
      Result := Format(HEX_FMT, [argValue]);
    end;
    OPS_WAITV, OPS_ABS, {OP_SQRT_2, OP_ABS_2, }OPS_SIGN, OPS_FMTNUM,
    OPS_ACOS, OPS_ASIN, OPS_ATAN, OPS_CEIL,
    OPS_EXP, OPS_FABS, OPS_FLOOR, OPS_SQRT, OPS_TAN, OPS_TANH,
    OPS_COS, OPS_COSH, OPS_LOG, OPS_LOG10, OPS_SIN, OPS_SINH,
    OPS_ATAN2, OPS_FMOD, OPS_POW,
    OPS_WAITV_2, OPS_SIGN_2, OPS_FMTNUM_2, OPS_ACOS_2, OPS_ASIN_2,
    OPS_ATAN_2, OPS_CEIL_2, OPS_EXP_2, OPS_FLOOR_2, OPS_TAN_2, OPS_TANH_2,
    OPS_COS_2, OPS_COSH_2, OPS_LOG_2, OPS_LOG10_2, OPS_SIN_2, OPS_SINH_2,
    OPS_TRUNC_2, OPS_FRAC_2, OPS_ATAN2_2, OPS_POW_2, OPS_MULDIV_2,
    OPS_ACOSD_2, OPS_ASIND_2, OPS_ATAND_2, OPS_TAND_2, OPS_TANHD_2,
    OPS_COSD_2, OPS_COSHD_2, OPS_SIND_2, OPS_SINHD_2, OPS_ATAN2D_2 :
    begin
      Result := TOCNameFromArg(DS, argValue);
    end;
    OPS_PRIORITY, OPS_PRIORITY_2 :
    begin
      if argValue = NOT_AN_ELEMENT then
        Result := STR_NA
      else
        Result := Format(HEX_FMT, [argValue]);
    end;
    OPS_ARROP, OPS_ARROP_2 :
    begin
      if argValue = NOT_AN_ELEMENT then
        Result := STR_NA
      else if argIdx = 0 then
        Result := Format(HEX_FMT, [argValue])
      else
        Result := TOCNameFromArg(DS, argValue);
    end;
  else
    Result := Format(HEX_FMT, [argValue]);
  end;
end;

function TRXEDumper.ProcessInstruction(DS : TDSData; CS : TCodeSpaceAry;
  const addr : integer; aStrings : TStrings) : integer;
var
  B1, B2, cc, sarg : byte;
  op : TOpCode;
  rarg : Shortint;
  instsize, x, opIdx : integer;
  NI : NXTInstruction;
  bShortEncoded, bNotFirst : boolean;
  tmpStr, TabStr : string;
  line : integer;
begin
  // initialize variables and begin processing the current instruction
  TabStr := #9;
  tmpStr := '';
  Result := addr;
  B1 := Lo(CS.Code[Result]); // xxxxxxxx
  B2 := Hi(CS.Code[Result]); // iiiifsss
  instsize := Byte((INST_MASK and B2) shr 4);
  bShortEncoded := ShortOpEncoded(B2);
  if bShortEncoded then
  begin
    op   := ShortOpToLongOp(CC_MASK and B2);
    cc   := 0;
    sarg := B1;
  end
  else
  begin
    op   := TOpCode(B1);
    cc   := (CC_MASK and B2);
    sarg := 0;
  end;
  // begin to generate the output string
  bNotFirst := False;
  opIdx := IndexOfOpcode(op);
  if opIdx = -1 then
    raise Exception.CreateFmt(sInvalidOpcode, [Ord(op)]);
  NI :=  GetNXTInstruction(opIdx);
  tmpStr := tmpStr + #9 + NI.Name;
  inc(Result); // move to next word in array
  dec(instsize, 2);
  if NI.CCType <> 0 then
  begin
    tmpStr := tmpStr + #9 + CompareCodeToStr(cc);
    bNotFirst := True;
  end;
  if bShortEncoded and (instsize = 0) then
  begin
    tmpStr := tmpStr + IfThen(bNotFirst, ', ', #9) + TOCNameFromArg(DS, sarg);
    bNotFirst := True;
  end;
  if instsize > 0 then
    tmpStr := tmpStr + IfThen(bNotFirst, ', ', TabStr);
  // we need special handling for 3 opcodes
  if ((op = OP_STRCAT) or
      (op = OP_ARRBUILD) or
      (op = OP_SETOUT)) and (instsize > 0) then
  begin
    // handle the extra argument stuff
    instsize := CS.Code[Result];
    dec(instsize, 4); // subtract out the instruction and the instsize arg
    inc(Result);
  end;
  x := 0;
  while instsize > 0 do
  begin
    if bShortEncoded and (x = 0) then
    begin
      // special handling if there are multiple arguments and the first
      // argument was short-op encoded (as a relative offset from
      // from the second argument)
      rarg   := ShortInt(sarg);
      tmpStr := tmpStr + ProcessInstructionArg(DS, addr, op, x, Word(CS.Code[Result]+rarg)) + ', ';
      inc(x);
      continue;
    end;
    // these should be arguments to the opcode we found above
    tmpStr := tmpStr + ProcessInstructionArg(DS, addr, op, x, CS.code[Result]);
    inc(x);
    inc(Result);
    dec(instsize, 2);
    if instsize > 0 then
      tmpStr := tmpStr + ', ';
  end;
  line := aStrings.Add(tmpStr);
  fAddrList.Add(Format('%d=%d', [addr, line]));
end;

procedure LoadRXECodeSpace(H : TRXEHeader; CS : TCodeSpaceAry; aStream: TStream);
var
  i : integer;
begin
  if H.Head.Version <> 0 then
  begin
    aStream.Seek(Integer(aStream.Size-(2*H.Head.CodespaceCount)), soFromBeginning);
    i := 0;
    SetLength(CS.Code, H.Head.CodespaceCount);
    while i < H.Head.CodespaceCount do
    begin
      ReadWordFromStream(aStream, CS.Code[i]);
      inc(i);
    end;
  end;
end;

procedure TRXEDumper.FixupLabelStrings(aStrings: TStrings; const addr,
  line: integer);
var
  str : string;
begin
  str := Format('lbl%4.4x:', [addr]) + aStrings[line];
  aStrings[line] := str;
end;

function TRXEDumper.GetAddressLine(const str: string): string;
begin
  Result := fAddrList.Values[str];
end;

procedure TRXEDumper.OutputByteCodePhaseOne(aStrings: TStrings);
var
  i : integer;
begin
  // format code for output
  i := 0;
  while i < Length(fCode.Code) do
  begin
    // if we are at the start of a clump we should end the previous clump
    // (if there is one) and start the new clump.
    OutputClumpBeginEndIfNeeded(fClumpData, i, aStrings);
    // now process the current instruction
    i := ProcessInstruction(fDSData, fCode, i, aStrings);
  end;
  aStrings.Add(#9'endt'); // end the last clump
end;

procedure TRXEDumper.OutputBytecode(aStrings: TStrings);
var
  i, line, addr : integer;
  str : string;
  tmpSL : TStringList;
begin
  aStrings.Add('; -------------- program code --------------');
  tmpSL := TStringList.Create;
  try
    OutputBytecodePhaseOne(tmpSL);
    // we need to fixup the labels for jumps
    for i := 0 to fFixups.Count - 1 do
    begin
      str := fFixups[i];
      addr := StrToIntDef(str, -1);
      line := StrToIntDef(GetAddressLine(str), -1);
      if (addr <> -1) and (line <> -1) then
      begin
        FixupLabelStrings(tmpSL, addr, line);
      end;
    end;
    aStrings.AddStrings(tmpSL);
  finally
    tmpSL.Free;
  end;
end;

procedure TRXEDumper.DumpRXECodeSpace(aStrings: TStrings);
begin
  if fHeader.Head.Version <> 0 then
  begin
    OutputDataspace(aStrings);
    OutputBytecode(aStrings);
  end;
end;

procedure LoadRXEDataSpace(H : TRXEHeader; DS : TDSData; aStream: TStream);
var
  i : integer;
  B : Byte;
begin
  if H.Head.Version <> 0 then
  begin
    // dataspace contains DSCount 4 byte structures (the TOC)
    // followed by the static and dynamic defaults
    aStream.Seek(SizeOf(RXEHeader), soFromBeginning);
    SetLength(DS.TOC, H.Head.DSCount);
    SetLength(DS.TOCNames, H.Head.DSCount);
    for i := 0 to H.Head.DSCount - 1 do
    begin
      aStream.Read(DS.TOC[i].TypeDesc, 1);
      aStream.Read(DS.TOC[i].Flags, 1);
      ReadWordFromStream(aStream, DS.TOC[i].DataDesc);
      DS.TOCNames[i] := GenerateTOCName(DS.TOC[i].TypeDesc, i);
    end;
    // static bytes are next
    aStream.Seek(SizeOf(RXEHeader)+(SizeOfDSTocEntry*H.Head.DSCount), soFromBeginning);
    i := 0;
    B := 0;
    SetLength(DS.StaticDefaults, H.Head.DynDSDefaultsOffset);
    while i < H.Head.DynDSDefaultsOffset do
    begin
      aStream.Read(B, SizeOf(Byte));
      DS.StaticDefaults[i] := B;
      inc(i);
    end;
    // now we can read the dynamic default data
    aStream.Seek(SizeOf(RXEHeader)+(SizeOfDSTocEntry*H.Head.DSCount)+H.Head.DynDSDefaultsOffset, soFromBeginning);
    i := 0;
    SetLength(DS.DynamicDefaults, H.Head.DVArrayOffset-H.Head.DSStaticSize);
    while i < (H.Head.DVArrayOffset-H.Head.DSStaticSize) do
    begin
      aStream.Read(B, SizeOf(Byte));
      DS.DynamicDefaults[i] := B;
      inc(i);
    end;
    // now read the Dope Vectors (10 bytes each)
    i := 0;
    SetLength(DS.DopeVecs, (H.Head.DynDSDefaultsSize - (H.Head.DVArrayOffset-H.Head.DSStaticSize)) div 10);
    while i < Length(DS.DopeVecs) do
    begin
      with DS.DopeVecs[i] do
      begin
        ReadWordFromStream(aStream, offset);
        ReadWordFromStream(aStream, elemsize);
        ReadWordFromStream(aStream, count);
        ReadWordFromStream(aStream, backptr);
        ReadWordFromStream(aStream, link);
      end;
      inc(i);
    end;
    // set the dataspace memory manager indexes from the header
    DS.Head := H.Head.MemMgrHead;
    DS.Tail := H.Head.MemMgrTail;
  end;
end;

procedure TRXEDumper.OutputDataspace(aStrings: TStrings);
begin
  fTmpDataspace.LoadFromDSData(self.fDSData);
  aStrings.Add('; -------------- variable declarations --------------');
  fTmpDataspace.SaveToStrings(aStrings);
end;

procedure TRXEDumper.DumpRXEDataSpace(aStrings: TStrings);
var
  i : integer;
  tmpStr : string;
begin
  aStrings.Add('DataSpace');
  aStrings.Add('----------------');
  // dataspace contains DSCount 4 byte structures (the TOC)
  // followed by the static and dynamic defaults
  aStrings.Add('DSTOC');
  for i := 0 to Length(fDSData.TOC) - 1 do
  begin
    with fDSData do
      aStrings.Add(Format('%8s: %2.2x %2.2x %4.4x',
        [TOCNames[i], TOC[i].TypeDesc, TOC[i].Flags, TOC[i].DataDesc]));
  end;
  // static bytes are next
  i := 0;
  tmpStr := '';
  aStrings.Add('Static DS Defaults');
  while i < Length(fDSData.StaticDefaults) do
  begin
    tmpStr := tmpStr + Format('%2.2x ', [fDSData.StaticDefaults[i]]);
    inc(i);
    if i mod 16 = 0 then
    begin
      aStrings.Add(tmpStr);
      tmpStr := '';
    end;
  end;
  if tmpStr <> '' then
    aStrings.Add(tmpStr);
  // now we can dump the dynamic default data
  i := 0;
  tmpStr := '';
  aStrings.Add('Dynamic DS Defaults');
  while i < Length(fDSData.DynamicDefaults) do
  begin
    tmpStr := tmpStr + Format('%2.2x ', [fDSData.DynamicDefaults[i]]);
    inc(i);
    if i mod 16 = 0 then
    begin
      aStrings.Add(tmpStr);
      tmpStr := '';
    end;
  end;
  if tmpStr <> '' then
    aStrings.Add(tmpStr);
  // now output the Dope Vectors (10 bytes each)
  i := 0;
  aStrings.Add('Dope Vectors (offset, elem size, count, back ptr, link)');
  while i < Length(fDSData.DopeVecs) do
  begin
    tmpStr := '';
    with fDSData do
    begin
      tmpStr := tmpStr + Format('%2.2x %2.2x ', [Hi(DopeVecs[i].offset), Lo(DopeVecs[i].offset)]);
      tmpStr := tmpStr + Format('%2.2x %2.2x ', [Hi(DopeVecs[i].elemsize), Lo(DopeVecs[i].elemsize)]);
      tmpStr := tmpStr + Format('%2.2x %2.2x ', [Hi(DopeVecs[i].count), Lo(DopeVecs[i].count)]);
      tmpStr := tmpStr + Format('%2.2x %2.2x ', [Hi(DopeVecs[i].backptr), Lo(DopeVecs[i].backptr)]);
      tmpStr := tmpStr + Format('%2.2x %2.2x', [Hi(DopeVecs[i].link), Lo(DopeVecs[i].link)]);
    end;
    aStrings.Add(tmpStr);
    inc(i);
  end;
  aStrings.Add('----------------');
end;

procedure LoadRXEHeader(H : TRXEHeader; aStream: TStream);
begin
  aStream.Seek(0, soFromBeginning);
  with H.Head do
  begin
    aStream.Read(FormatString, 14);
    aStream.Read(Skip, 1);
    aStream.Read(Version, 1);
    ReadWordFromStream(aStream, DSCount);
    ReadWordFromStream(aStream, DSSize);
    ReadWordFromStream(aStream, DSStaticSize);
    ReadWordFromStream(aStream, DSDefaultsSize);
    ReadWordFromStream(aStream, DynDSDefaultsOffset);
    ReadWordFromStream(aStream, DynDSDefaultsSize);
    ReadWordFromStream(aStream, MemMgrHead);
    ReadWordFromStream(aStream, MemMgrTail);
    ReadWordFromStream(aStream, DVArrayOffset);
    ReadWordFromStream(aStream, ClumpCount);
    ReadWordFromStream(aStream, CodespaceCount);
  end;
end;

procedure TRXEDumper.DumpRXEHeader(aStrings: TStrings);
begin
  aStrings.Add('Header');
  aStrings.Add('----------------');
  with fHeader.Head do
    aStrings.Text := aStrings.Text +
      Format(RXEHeaderText,
        [FormatString, Version, DSCount, DSSize,
         DSStaticSize, DSDefaultsSize, DynDSDefaultsOffset,
         DynDSDefaultsSize, MemMgrHead, MemMgrTail,
         DVArrayOffset, ClumpCount, CodespaceCount]);
  aStrings.Add('----------------');
end;

procedure TRXEDumper.OutputClumpBeginEndIfNeeded(CD : TClumpData; const addr: integer;
  aStrings: TStrings);
var
  i, j, depOffset : integer;
  tmpStr : string;
begin
  // if we are at the start of a clump we should end the previous clump
  // (if there is one) and start the new clump.
  depOffset := 0;
  for i := 0 to Length(CD.CRecs) - 1 do
  begin
    if CD.CRecs[i].CodeStart = addr then
    begin
      if i > 0 then
      begin
        // output the end of the previous clump
        aStrings.Add(#9'endt');
        aStrings.Add(';-----------------------------------');
      end;
      // output the beginning of the new clump
      aStrings.Add(Format(#9'thread '+CLUMP_FMT, [i]));
      // while we are at the start of a clump we should also
      // output our dependency information
      if CD.CRecs[i].DependentCount > 0 then
      begin
        tmpStr := #9 + STR_USES + #9;
        for j := 0 to CD.CRecs[i].DependentCount - 1 do
        begin
          tmpStr := tmpStr + Format(CLUMP_FMT+', ', [fClumpData.ClumpDeps[depOffset+j]]);
        end;
        Delete(tmpStr, Length(tmpStr)-1, 2); // remove the last ', ' sequence.
        aStrings.Add(tmpStr);
      end;
    end;
    inc(depOffset, CD.CRecs[i].DependentCount);
  end;
end;

constructor TRXEDumper.Create;
begin
  inherited;
  fHeader := TRXEHeader.Create;
  fDSData := TDSData.Create;
  fClumpData := TClumpData.Create;
  fCode := TCodeSpaceAry.Create;
  fAddrList := TStringList.Create;
  fAddrList.Sorted := True;
  fAddrList.Duplicates := dupIgnore;
  fFixups := TStringList.Create;
  fFixups.Sorted := True;
  fFixups.Duplicates := dupIgnore;
  fTmpDataspace := TDataspace.Create;
  fHeader.Head.DSCount := 0;
  fOnlyDumpCode := False;
  FirmwareVersion := 0; 
end;

destructor TRXEDumper.Destroy;
begin
  FreeAndNil(fHeader);
  FreeAndNil(fDSData);
  FreeAndNil(fClumpData);
  FreeAndNil(fCode);
  FreeAndNil(fAddrList);
  FreeAndNil(fFixups);
  FreeAndNil(fTmpDataspace);
  inherited;
end;

procedure TRXEDumper.DumpRXE(aStrings : TStrings);
var
  SL : TStringList;
begin
  aStrings.Clear;
  aStrings.BeginUpdate;
  try
    SL := TStringList.Create;
    try
      if not OnlyDumpCode then
      begin
        SL.Add('/*');
        SL.Add(ExtractFileName(Filename));
        DumpRXEHeader(SL);
        DumpRXEDataSpace(SL);
        DumpRXEClumpRecords(SL);
        SL.Add('*/');
      end;
      DumpRXECodeSpace(SL);
      // copy from temporary string list into the provided TStrings class
      aStrings.AddStrings(SL);
    finally
      SL.Free;
    end;
  finally
    aStrings.EndUpdate;
  end;
end;

procedure TRXEDumper.Decompile(aStrings: TStrings);
begin
  aStrings.Clear;
  aStrings.BeginUpdate;
  try
    aStrings.Add('; '+ExtractFileName(Filename));
    DumpRXECodeSpace(aStrings);
  finally
    aStrings.EndUpdate;
  end;
end;

procedure TRXEDumper.LoadFromFile(const aFilename : string);
var
  MS : TMemoryStream;
begin
  Filename := aFilename;
  MS := TMemoryStream.Create;
  try
    MS.LoadFromFile(aFilename);
    LoadFromStream(MS);
  finally
    FreeAndNil(MS);
  end;
end;

procedure TRXEDumper.LoadFromStream(aStream: TStream);
begin
  aStream.Position := 0;
  LoadRXEHeader(fHeader, aStream);
  if FirmwareVersion = 0 then
  begin
    // only set the firmware version based on the file contents if
    // it has not been explicitly set to a non-zero value externally
    if fHeader.Head.Version > 5 then
      FirmwareVersion := MIN_FW_VER2X
    else
      FirmwareVersion := MAX_FW_VER1X;
  end;
  LoadRXEDataSpace(fHeader, fDSData, aStream);
  LoadRXEClumpRecords(fHeader, fClumpData, aStream);
  LoadRXECodeSpace(fHeader, fCode, aStream);
  InitializeRXE;
end;

procedure TRXEDumper.SaveToFile(const aFilename: string);
var
  MS : TMemoryStream;
begin
  MS := TMemoryStream.Create;
  try
    SaveToStream(MS);
    MS.SaveToFile(aFilename);
  finally
    MS.Free;
  end;
end;

procedure WriteHeaderToStream(aStream: TStream; Head : RXEHeader);
begin
  with Head do
  begin
    aStream.Write(FormatString, 14);
    aStream.Write(Skip, 1);
    aStream.Write(Version, 1);
    WriteWordToStream(aStream, DSCount);
    WriteWordToStream(aStream, DSSize);
    WriteWordToStream(aStream, DSStaticSize);
    WriteWordToStream(aStream, DSDefaultsSize);
    WriteWordToStream(aStream, DynDSDefaultsOffset);
    WriteWordToStream(aStream, DynDSDefaultsSize);
    WriteWordToStream(aStream, MemMgrHead);
    WriteWordToStream(aStream, MemMgrTail);
    WriteWordToStream(aStream, DVArrayOffset);
    WriteWordToStream(aStream, ClumpCount);
    WriteWordToStream(aStream, CodespaceCount);
  end;
end;

procedure TRXEDumper.SaveToStream(aStream: TStream);
begin
  FinalizeRXE;
  // write the header
  WriteHeaderToStream(aStream, fHeader.Head);
  fDSData.SaveToStream(aStream);
  // write the clump records
  fClumpData.SaveToStream(aStream);
  // write the codespace
  fCode.SaveToStream(aStream);
end;

procedure TRXEDumper.FinalizeRXE;
begin
  // prepare all the dynamic arrays from the class structure
end;

procedure TRXEDumper.InitializeRXE;
begin
  // process dynamic arrays and build the class
  // representation of the code
end;

function TRXEDumper.GetNXTInstruction(const idx: integer): NXTInstruction;
begin
  Result := fNXTInstructions[idx];
end;

procedure TRXEDumper.SetFirmwareVersion(const Value: word);
begin
  fFirmwareVersion := Value;
  InitializeInstructions;
end;

procedure TRXEDumper.InitializeInstructions;
var
  i : integer;
begin
  if fFirmwareVersion > MAX_FW_VER1X then
  begin
    SetLength(fNXTInstructions, NXTInstructionsCount2x);
    for i := 0 to NXTInstructionsCount2x - 1 do begin
      fNXTInstructions[i] := NXTInstructions2x[i];
    end;
  end
  else
  begin
    SetLength(fNXTInstructions, NXTInstructionsCount1x);
    for i := 0 to NXTInstructionsCount1x - 1 do begin
      fNXTInstructions[i] := NXTInstructions1x[i];
    end;
  end;
end;

function TRXEDumper.IndexOfOpcode(op : TOpCode) : integer;
var
  i : integer;
begin
  Result := -1;
  for i := Low(fNXTInstructions) to High(fNXTInstructions) do
  begin
    if fNXTInstructions[i].Encoding = op then
    begin
      Result := i;
      Break;
    end;
  end;
end;

{ TDSBase }

function TDSBase.Add: TDataspaceEntry;
begin
  Result := TDataspaceEntry(inherited Add);
end;

procedure TDSBase.AssignTo(Dest: TPersistent);
var
  i : integer;
begin
  if Dest is TDSBase then
  begin
    TDSBase(Dest).Clear;
    for i := 0 to Self.Count - 1 do
    begin
      TDSBase(Dest).Add.Assign(Self[i]);
    end;
  end
  else
    inherited;
end;

function TDSBase.GetItem(Index: Integer): TDataspaceEntry;
begin
  Result := TDataspaceEntry(inherited GetItem(Index));
end;

function TDSBase.FindEntryByFullName(const path : string): TDataspaceEntry;
var
  i, p : integer;
  tmp : string;
  DE : TDataspaceEntry;
begin
  i := fEntryIndex.IndexOf(path);
  if i <> -1 then
    Result := TDataspaceEntry(fEntryIndex.Objects[i])
  else
  begin
    Result := nil;
    for i := 0 to Self.Count - 1 do
    begin
      DE := Items[i];
      if DE.Identifier = path then
      begin
        Result := DE;
        Break;
      end
      else
      begin
        p := Pos(DE.Identifier + '.', path);
        if p = 1 then // 2009-05-12 JCH: was p > 0
        begin
          tmp := Copy(path, p+Length(DE.Identifier)+1, MaxInt);
          Result := DE.SubEntries.FindEntryByFullName(tmp);
          if Result <> nil then
            Break;
        end;
      end;
    end;
  end;
end;

function TDSBase.IndexOfName(const name : string): integer;
var
  DE : TDataspaceEntry;
begin
  DE := FindEntryByFullName(name);
  if Assigned(DE) then
    Result := DE.Index
  else
    Result := -1;
end;

function TDSBase.Insert(Index: Integer): TDataspaceEntry;
begin
  result := TDataspaceEntry(inherited Insert(Index));
end;

procedure TDSBase.ExchangeItems(Index1, Index2: Integer);
var
  Temp1, Temp2: Integer;
  de1, de2 : TDataspaceEntry;
begin
  de1 := Items[Index1];
  de2 := Items[Index2];
  Temp1 := de1.Index;
  Temp2 := de2.Index;
  BeginUpdate;
  try
    de1.Index := Temp2;
    de2.Index := Temp1;
  finally
    EndUpdate;
  end;
end;

procedure TDSBase.QuickSort(L, R: Integer; SCompare: TDSBaseSortCompare);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(Self, I, P) < 0 do Inc(I);
      while SCompare(Self, J, P) > 0 do Dec(J);
      if I <= J then
      begin
        ExchangeItems(I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J, SCompare);
    L := I;
  until I >= R;
end;

procedure TDSBase.SetItem(Index: Integer; Value: TDataspaceEntry);
begin
  inherited SetItem(Index, Value);
end;

function GetBytesPerType(dt : TDSType) : integer;
begin
  if dt = dsCluster then
    Result := -10
  else if dt = dsArray then
    Result := -20
  else
    Result := BytesPerType[dt];
end;

function IsScalarType(dt : TDSType) : boolean;
begin
  Result := not (dt in [dsArray, dsCluster]);
end;

function DSBaseCompareSizes(List: TDSBase; Index1, Index2: Integer): Integer;
var
  de1, de2 : TDataspaceEntry;
  b1, b2 : Integer;
//  dt1, dt2 : TDSType;
//  bScalar1, bScalar2 : boolean;
begin
{
  -1 if the item identified by Index1 comes before the item identified by Index2
	0 if the two are equivalent
	1 if the item with Index1 comes after the item identified by Index2.
}
  de1 := List.Items[Index1];
  de2 := List.Items[Index2];
  b1 := GetBytesPerType(de1.DataType);
  b2 := GetBytesPerType(de2.DataType);
  if b1 > b2 then  // larger sizes of scalar types come first
    Result := -1
  else if b1 = b2 then
    Result := 0
  else
    Result := 1;
(*
{
  We want to sort the dataspace so that
  1. all scalar types come before aggregate types.
  2. scalar types are ordered by size with 4 byte types before 2 byte types
     before 1 byte types
  3. All structs come before arrays
  4. arrays are last

  TDSType = (dsVoid, dsUByte, dsSByte, dsUWord, dsSWord, dsULong, dsSLong,
    dsArray, dsCluster, dsMutex, dsFloat);
}
  dt1 := de1.DataType;
  dt2 := de2.DataType;
  bScalar1 := IsScalarType(dt1);
  bScalar2 := IsScalarType(dt2);
  if bScalar1 and bScalar2 then
  begin
    b1 := GetBytesPerType(dt1);
    b2 := GetBytesPerType(dt2);
    if b1 > b2 then  // larger sizes of scalar types come first
      Result := -1
    else if b1 = b2 then
      Result := 0
    else
      Result := 1;
  end
  else if bScalar1 then
  begin
    // 1 is scalar but 2 is not
    Result := -1;
  end
  else if bScalar2 then
  begin
    // 2 is scalar but 1 is not
    Result := 1;
  end
  else begin
    // neither one is scalar
    if dt1 < dt2 then
      Result := 1
    else if dt1 = dt2 then
      Result := 0
    else
      Result := -1;
  end;
*)
end;

procedure TDSBase.Sort;
begin
  if Count = 0 then Exit;
  QuickSort(0, Count - 1, @DSBaseCompareSizes);
end;

constructor TDSBase.Create;
begin
  inherited Create(TDataspaceEntry);
  fEntryIndex := TStringList.Create;
  fEntryIndex.CaseSensitive := True;
  fEntryIndex.Sorted := True;
  fParent := nil;
end;

function TDSBase.FullPathName(DE: TDataspaceEntry): string;
begin
  if Parent <> nil then
    Result := TDataspaceEntry(Parent).FullPathIdentifier + '.' + DE.Identifier
  else
    Result := DE.Identifier;
end;

function TDSBase.FindEntryByAddress(Addr: Word): TDataspaceEntry;
var
  i : integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    if Items[i].DataType = dsCluster then
    begin
      Result := Items[i].SubEntries.FindEntryByAddress(Addr);
      if assigned(Result) then Break;
    end
    else if Items[i].Address = Addr then
    begin
      Result := Items[i];
      Break;
    end;
  end;
end;

function TDSBase.FindEntryByName(name: string): TDataspaceEntry;
var
  i : integer;
begin
  // find the first entry with a matching name (could be duplicates).
  Result := nil;
  for i := 0 to Self.Count - 1 do
  begin
    if Items[i].Identifier = name then
    begin
      Result := Items[i];
      Break;
    end
    else
    begin
      Result := Items[i].SubEntries.FindEntryByName(name);
      if Result <> nil then
        Break;
    end;
  end;
end;

procedure TDSBase.CheckEntry(DE: TDataspaceEntry);
var
  X : TDataspaceEntry;
begin
  // identifier must be valid
  if not IsValidIdent(DE.Identifier) then
    raise Exception.CreateFmt(sInvalidVarDecl, [DE.Identifier]);
  // make sure entry is unique
  X := FindEntryByFullName(DE.FullPathIdentifier);
  if (X <> nil) and (X <> DE) then
    raise EDuplicateDataspaceEntry.Create(DE);
end;

function EqualDopeVectors(DV1, DV2 : DopeVector) : boolean;
begin
  Result := (DV1.offset = DV2.offset) and (DV1.elemsize = DV2.elemsize) and
            (DV1.count = DV2.count) and (DV1.backptr = DV2.backptr) and
            (DV1.link = DV2.link); 
end;

function TDSBase.ResolveNestedArrayAddress(DS: TDSData;
  DV: DopeVector): TDataspaceEntry;
var
  i, addr : integer;
begin
  addr := -1;
  // find the index of the DV in DS.DopeVectors and look at
  // the item just before it to get the Dataspace entry address
  for i := Low(DS.DopeVecs) to High(DS.DopeVecs) do
  begin
    if EqualDopeVectors(DS.DopeVecs[i], DV) and (i > Low(DS.DopeVecs)) then
    begin
      // found the item
      addr := DS.DopeVecs[i-1].backptr;
      Break;
    end;
  end;
  Result := FindEntryByAddress(Word(addr));
end;

function TDSBase.GetRoot: TDataspaceEntry;
begin
  Result := nil;
  if Assigned(Parent) then
    Result := TDataspaceEntry(Parent).DSBase.Root;
  if not Assigned(Result) then
    Result := TDataspaceEntry(Parent);
end;

destructor TDSBase.Destroy;
begin
  FreeAndNil(fEntryIndex);
  inherited;
end;

{ TDataspace }

constructor TDataspace.Create;
begin
  inherited;
  fDSIndexMap := TStringList.Create;
  fDSIndexMap.CaseSensitive := True;
  fDSIndexMap.Sorted := True;
  // an unsorted list of all dataspace entries regardless of their nesting level
  fDSList := TObjectList.Create;
end;

destructor TDataspace.Destroy;
begin
  FreeAndNil(fDSIndexMap);
  FreeAndNil(fDSList);
  inherited;
end;

function RoundToBytesize(addr : Word; size : byte) : Word;
var
  x : Word;
begin
  x := Word(addr mod size);
  if x <> 0 then
    Result := Word(addr + size - x)
  else
    Result := addr;
end;

function TDataspace.FinalizeDataspace(DS : TDSBase; addr : Word) : Word;
var
  i : integer;
  DE : TDataspaceEntry;
  currAddress : Word;
begin
  // run through the dataspace and set the Address property for each entry and
  // build a map for the dataspace indices
  currAddress := addr;
  for i := 0 to DS.Count - 1 do
  begin
    DE := DS.Items[i];
    fDSIndexMap.AddObject(DE.FullPathIdentifier, DE);
    fDSList.Add(DE);
    DE.DSID := fDSList.Count - 1;
    if DE.DataType = dsCluster then
    begin
      DE.Address := Word(DE.SubEntries.Count);
      currAddress := FinalizeDataspace(DE.SubEntries,
        RoundToBytesize(currAddress, BytesPerType[dsCluster]));
    end
    else if DE.DataType = dsArray then
    begin
      DE.Address := RoundToBytesize(currAddress, BytesPerType[dsArray]);
      FinalizeDataspace(DE.SubEntries, 0);
      currAddress := Word(DE.Address + BytesPerType[DE.DataType]);
    end
    else
    begin
      DE.Address := RoundToBytesize(currAddress, BytesPerType[DE.DataType]);
      currAddress := Word(DE.Address + BytesPerType[DE.DataType]);
    end;
  end;
  Result := currAddress;
end;

function TDataspace.DataspaceIndex(const ident: string): Integer;
var
  DE : TDataspaceEntry;
begin
  if fDSIndexMap.Count = 0 then
    FinalizeDataspace(Self, 0);
  Result := fDSIndexMap.IndexOf(ident);
  if Result <> -1 then
  begin
    DE := TDataspaceEntry(fDSIndexMap.Objects[Result]);
    Result := DE.DSID;
  end;
end;

function TDataspace.GetVector(index: Integer): DopeVector;
begin
  Result := fVectors[index];
end;

function TDataspace.IndexOfEntryByAddress(Addr: Word): Integer;
var
  DE : TDataspaceEntry;
begin
  DE := FindEntryByAddress(Addr);
  if Assigned(DE) then
    Result := DE.Index
  else
    Result := -1;
end;

function AddArrayItem(aDS : TDSData; Item : TDataspaceEntry; idx : Integer;
  var staticIndex : Integer) : integer;
var
  Sub : TDataspaceEntry;
begin
  // when this function is called idx is pointing one past the array item
  Result := idx;
  // the next entry contains the datatype (which, unfortunately, could be an array)
  Sub := Item.SubEntries.Add;
  Sub.Identifier := aDS.TOCNames[Result];
  Sub.DataType := TDSType(aDS.TOC[Result].TypeDesc);
  Sub.DSID := Result;
  Sub.DefaultValue := 0;
  Sub.ArrayMember := True;
  if Sub.DataType = dsArray then
  begin
    inc(Result);
    Result := AddArrayItem(aDS, Sub, Result, staticIndex);
  end
  else if Sub.DataType = dsCluster then
    Result := ProcessCluster(aDS, Sub, Result, staticIndex)
  else
    inc(Result);
end;

procedure GetStaticDefaults(X: TDataspaceEntry; aDS: TDSData;
  var staticIndex: integer);
var
  val : Cardinal;
begin
  // read the static bytes and convert to default value
  case BytesPerType[X.DataType] of
    1 : val := BytesToCardinal(aDS.StaticDefaults[staticIndex]);
    2 : val := BytesToCardinal(aDS.StaticDefaults[staticIndex],
                               aDS.StaticDefaults[staticIndex+1]);
    4 : val := BytesToCardinal(aDS.StaticDefaults[staticIndex],
                               aDS.StaticDefaults[staticIndex+1],
                               aDS.StaticDefaults[staticIndex+2],
                               aDS.StaticDefaults[staticIndex+3]);
  else
    val := 0;
  end;
  X.DefaultValue := val;
  // increment the static index
  inc(staticIndex, BytesPerType[X.DataType]);
end;

function ProcessCluster(aDS : TDSData; Item : TDataspaceEntry; idx : Integer;
  var staticIndex : Integer) : integer;
var
  n, j : integer;
  member : TDataspaceEntry;
  DSE : DSTocEntry;
begin
  Result := idx;
  inc(Result);
  n := aDS.TOC[idx].DataDesc; // number of elements in this cluster
  j := 1;
  while j <= n do
  begin
    // the next entry contains the datatype
    member := Item.SubEntries.Add;
    DSE := aDS.TOC[Result];
    member.Identifier := aDS.TOCNames[Result];
    member.DataType := TDSType(DSE.TypeDesc);
    member.DSID := Result;
    member.DefaultValue := 0;
    member.ArrayMember := Item.ArrayMember;
    case member.DataType of
      dsArray : begin
        inc(Result); // move past the array element to its child
        // read an extra item
        member.Address := DSE.DataDesc; // data description is the address
        Result := AddArrayItem(aDS, member, Result, staticIndex);
        // if this array is a root level array (i.e., not an ArrayMember) then
        // get the DVAIndex from the static dataspace
        if (DSE.Flags = 0) and not Item.ArrayMember then
        begin
          GetStaticDefaults(member, aDS, staticIndex);
        end;
      end;
      dsCluster : begin
        member.Address := DSE.DataDesc; // data description is the number of elements
        Result := ProcessCluster(aDS, member, Result, staticIndex);
      end;
    else
      inc(Result);
      member.Address := DSE.DataDesc; // data description is the address
      if (DSE.Flags = 0) and not Item.ArrayMember then
      begin
        GetStaticDefaults(member, aDS, staticIndex);
      end;
    end;
    inc(j);
  end;
end;

const
  INVALID_LINK = $FFFF;
  NESTED_ARRAY_BACKPTR = $FFFE;

procedure TDataspace.LoadArrayValuesFromDynamicData(DS: TDSData);
var
  idx, dp : integer;
  actualbytes, i, paddedbytes : Word;
  DV : DopeVector;
  X : TDataspaceEntry;

  function ProcessElement(aArray : TDataspaceEntry; DE : TDataspaceEntry; k : word) : word;
  var
    b1, b2, b3, b4 : byte;
    j : integer;
  begin
    Result := k;
    case DE.DataType of
      dsUByte, dsSByte : begin
        b1 := DS.DynamicDefaults[dp+k];
        if DV.count > 0 then
          aArray.AddValue(BytesToCardinal(b1));
      end;
      dsUWord, dsSWord : begin
        b1 := DS.DynamicDefaults[dp+k];
        b2 := DS.DynamicDefaults[dp+k+1];
        if DV.count > 0 then
          aArray.AddValue(BytesToCardinal(b1, b2));
      end;
      dsULong, dsSLong : begin
        b1 := DS.DynamicDefaults[dp+k];
        b2 := DS.DynamicDefaults[dp+k+1];
        b3 := DS.DynamicDefaults[dp+k+2];
        b4 := DS.DynamicDefaults[dp+k+3];
        if DV.count > 0 then
          aArray.AddValue(BytesToCardinal(b1, b2, b3, b4));
      end;
    else
      if DE.DataType = dsCluster then // an array of cluster
      begin
        for j := 0 to DE.SubEntries.Count - 1 do
        begin
          k := RoundToByteSize(k, BytesPerType[DE.SubEntries[j].DataType]);
          k := ProcessElement(DE, DE.SubEntries[j], k);
        end;
      end
      else if DE.DataType = dsArray then // an array of array
      begin
        ProcessElement(DE, DE.SubEntries[0], k);
      end;
    end;
    if DE.DataType = dsArray then
      inc(Result, DV.elemsize)
    else
      inc(Result, DE.ElementSize);
  end;
begin
  dp := 0;
  idx := 0;
  while idx < Length(DS.DopeVecs) do
  begin
    DV := DS.DopeVecs[idx];
    if (DV.backptr <> INVALID_LINK){ and ((DV.count > 0) or (DV.elemsize > 4))} then
    begin
      if DV.backptr = NESTED_ARRAY_BACKPTR then
      begin
        inc(dp, 4);
      end
      else
      begin
        X := FindEntryByAddress(DV.backptr);
        // if X is not assigned it is because this is a nested array
        if not Assigned(X) then
          X := ResolveNestedArrayAddress(DS, DV);
        if (X <> nil) and
           (X.DataType = dsArray) and
           ((DV.count > 0) or
            (X.SubEntries[0].DataType = dsCluster) or // array of cluster or array of array
            (X.SubEntries[0].DataType = dsArray)) then
        begin
          // process the default data for this element
          // the number of bytes to read from the dynamic defaults array is
          // (DV.Count * DV.Size) + (4 - ((DV.Count * DV.Size) mod 4))
          if DV.count > 0 then
            actualbytes := Word(DV.count * DV.elemsize)
          else
            actualbytes := DV.elemsize;
          paddedbytes := RoundToByteSize(actualbytes, DWORD_LEN);
          // read from the current dynamic defaults pointer (dp)
          i := 0;
          while i < actualbytes do
          begin
            i := ProcessElement(X, X.SubEntries[0], i);
          end;
          inc(dp, paddedbytes);
        end;
      end;
    end;
    inc(idx);
  end;
end;

procedure TDataspace.LoadFromDSData(aDS: TDSData);
var
  i : integer;
  staticIndex : integer;
  DSE : DSTocEntry;
  X : TDataspaceEntry;
begin
  Clear;
  fDSIndexMap.Clear;
  fDSList.Clear;
  i := 0;
  staticIndex := 0;
  fMMHead := aDS.Head;
  fMMTail := aDS.Tail;
  while i < Length(aDS.TOC) do
  begin
    DSE := aDS.TOC[i];
    X := Self.Add;
    X.Identifier := aDS.TOCNames[i];
    X.DataType := TDSType(DSE.TypeDesc);
    X.DSID := i;
    X.DefaultValue := 0;
    case X.DataType of
      dsArray : begin
        inc(i);
        X.Address := DSE.DataDesc; // data description is the address
        i := AddArrayItem(aDS, X, i, staticIndex);
        // root-level arrays have DV index in static dataspace
        GetStaticDefaults(X, aDS, staticIndex);
      end;
      dsCluster : begin
        // the data descriptor is the number of items in the cluster
        // we need to process clusters recursively since a cluster
        // can contain another cluster
        X.Address := DSE.DataDesc;
        i := ProcessCluster(aDS, X, i, staticIndex);
      end;
    else
      // all other datatypes are simple scalars
      X.Address := DSE.DataDesc; // data description is the address
      // a flags value of 0 for a scalar type means it has a static default value
      if DSE.Flags = 0 then
      begin
        GetStaticDefaults(X, aDS, staticIndex);
      end;
      inc(i);
    end;
  end;
  // process dynamic data using dopevectors
  LoadArrayValuesFromDynamicData(aDS);
end;

procedure TDataspace.LoadFromStream(aStream: TStream);
begin
  fDSIndexMap.Clear;
  fDSList.Clear;
  // TODO: implement TDataspace.LoadFromStream
  aStream.Position := 0;
end;

procedure TDataspace.SaveToDSData(aDS: TDSData);
var
  i, j, offset, doffset : integer;
  cnt, maxAddress, DVAIndex : Word;
  pTE : ^DSTocEntry;
  DE : TDataspaceEntry;
begin
  fDSList.Clear;
  fDSIndexMap.Clear;
  FinalizeDataspace(self, 0);
  aDS.Head := 0;
  aDS.Tail := 0;

  // add the first dope vector which contains the number of dope vectors
  // if the dope vector array is empty
  SetLength(aDS.DopeVecs, 1);
  with aDS.DopeVecs[0] do
  begin
    offset := 0;
    elemsize := 10; // the size of each dope vector
    count := 1; // start at 1
    backptr := $FFFF; // invalid pointer
  end;

  // fill the table of contents
  maxAddress := 0;
  doffset := 0;
  offset := 0;
  DVAIndex := 1;
  SetLength(aDS.TOC, fDSList.Count);
  SetLength(aDS.TOCNames, fDSList.Count);
  for i := 0 to fDSList.Count - 1 do
  begin
    pTE := @(aDS.TOC[i]);
    DE := TDataspaceEntry(fDSList[i]);
    aDS.TOCNames[i] := DE.GetFullPathIdentifier;
    if DE.DataType = dsMutex then
      DE.DefaultValue := $FFFFFFFF;
    pTE^.TypeDesc := Byte(Ord(DE.DataType));
    if (DE.DefaultValue = 0) and
       not (DE.DataType in [dsArray, dsCluster]) and
       not DE.ArrayMember then
      pTE^.Flags := 1
    else
      pTE^.Flags := 0;
    pTE^.DataDesc := DE.Address;
    // these next two fields are only used when outputting the symbol table
    pTE^.RefCount := Word(DE.RefCount);
    pTE^.Size     := DE.ElementSize;
    // keep track of the maximum dataspace address
    if DE.Address >= maxAddress then
      maxAddress := Word(DE.Address+BytesPerType[DE.DataType]);
    // generate the static defaults data
    if (DE.DefaultValue <> 0) and (DE.DataType <> dsArray) then
    begin
      // add bytes to static data
      cnt := BytesPerType[DE.DataType];
      SetLength(aDS.StaticDefaults, offset+cnt);
      for j := 0 to cnt - 1 do
      begin
        aDS.StaticDefaults[offset+j] := GetByte(DE.DefaultValue, j);
      end;
      inc(offset, cnt);
    end
    else if (DE.DataType = dsArray) then
    begin
      if not DE.ArrayMember then
      begin
        // top-level arrays output DVA index in static data
        SetLength(aDS.StaticDefaults, offset+BytesPerType[dsArray]);
        aDS.StaticDefaults[offset]   := Lo(Word(DVAIndex));
        aDS.StaticDefaults[offset+1] := Hi(Word(DVAIndex));
        inc(offset, 2);
      end;
      DE.DefaultValue := DVAIndex;
      inc(DVAIndex); // all arrays get a DVA and we increment the index accordingly
    end;
    // generate the dynamic defaults data and dope vectors
    if (DE.DataType = dsArray) then
    begin
      ProcessArray(DE, aDS, doffset);
    end;
  end;
  // now process the dope vectors array and set the offset and link values
  ProcessDopeVectors(aDS, maxAddress);
end;

procedure TDataspace.SaveToStream(aStream: TStream);
var
  DS : TDSData;
begin
  DS := TDSData.Create;
  try
    SaveToDSData(DS);
    DS.SaveToStream(aStream);
  finally
    DS.Free;
  end;
end;

procedure TDataspace.SaveToStrings(aStrings: TStrings);
var
  i : integer;
begin
  aStrings.BeginUpdate;
  try
    aStrings.Add('dseg'#9'segment');
  // output all unique definitions first
    aStrings.Add(';------- definitions -------');
    for i := 0 to Count - 1 do
      Items[i].SaveToStrings(aStrings, true);
  //now output declarations
    aStrings.Add(';------- declarations -------');
    for i := 0 to Count - 1 do
      Items[i].SaveToStrings(aStrings);
    aStrings.Add('dseg'#9'ends');
  finally
    aStrings.EndUpdate;
  end;
end;

function TDataspace.FindEntryByFullName(const path: string): TDataspaceEntry;
var
  i : integer;
begin
  if fDSIndexMap.Count <> 0 then
  begin
    i := fDSIndexMap.IndexOf(path);
    if i <> -1 then
      Result := TDataspaceEntry(fDSIndexMap.Objects[i])
    else
      Result := nil;
  end
  else
    Result := inherited FindEntryByFullName(path);
end;

procedure TDataspace.ProcessDopeVectors(aDS: TDSData; addr: Word);
var
  i, idxEmpty, idxFull : integer;
  pDV : ^DopeVector;
  delta : Word;
begin
  // make sure starting address is a 4 byte boundary
  addr := RoundToByteSize(addr, DWORD_LEN);
  idxEmpty := 0;
  idxFull  := aDS.Head;
  for i := 1 to Length(aDS.DopeVecs) - 1 do
  begin
    pDV := @(aDS.DopeVecs[i]);
    if pDV^.count = 0 then
    begin
      pDV^.offset := $FFFF;
      // store the greatest index with an offset of $FFFF as the tail
      if i > aDS.Tail then
        aDS.Tail := Word(i);
      // handle special case of empty arrays of struct or empty nested arrays
      if pDV^.link <> 0 then
      begin
        // increment maxAddress
        delta := pDV^.elemsize;
        delta := RoundToByteSize(delta, DWORD_LEN);
        inc(addr, delta);
      end;
      // set link pointer
      pDV := @(aDS.DopeVecs[idxEmpty]);
      pDV^.link := Word(i);
      idxEmpty := i;
    end
    else
    begin
      pDV^.offset := addr;
      // if the last element in the array is not empty then link it back to the
      // first empty element (always 0)
      // increment maxAddress
      delta := Word(pDV^.count * pDV^.elemsize);
      delta := RoundToByteSize(delta, DWORD_LEN);
      inc(addr, delta);
      if pDV^.backptr = 0 then
      begin
        // a nested array
        pDV^.backptr := addr;
      end;
      // set link pointer
      if i = idxFull then
      begin
        // special case where there is only one non-empty array
        pDV := @(aDS.DopeVecs[i]);
        pDV^.link := Word(0);
      end
      else
      begin
        pDV := @(aDS.DopeVecs[idxFull]);
        pDV^.link := Word(i);
        idxFull := i;
      end;
    end;
  end;
  // link the last Full item back to zero (the first empty item)
  // unless the last full item is item 0
  if idxFull <> 0 then
  begin
    pDV := @(aDS.DopeVecs[idxFull]);
    pDV^.link := 0;
  end;
  pDV := @(aDS.DopeVecs[Length(aDS.DopeVecs)-1]);
  if pDV^.count > 0 then
    pDV^.link := 0;
  aDS.DopeVecs[0].offset := RoundToBytesize(addr, DWORD_LEN);
  aDS.DopeVecs[aDS.Tail].link := $FFFF;
end;

function TDataspace.GetCaseSensitive: boolean;
begin
  Result := fDSIndexMap.CaseSensitive;
end;

procedure TDataspace.SetCaseSensitive(const Value: boolean);
begin
  fDSIndexMap.CaseSensitive := Value;
end;

procedure TDataspace.Compact;
var
  i : integer;
begin
  // this routine removes dataspace entries (root level)
  // which are not in use.
  for i := Count - 1 downto 0 do
  begin
    if not Items[i].InUse then
      Delete(i);
  end;
end;

function TDataspace.FindEntryAndAddReference(const path: string): TDataspaceEntry;
begin
  Result := FindEntryByFullName(path);
  if Assigned(Result) then
  begin
    AddReference(Result);
  end;
end;

procedure TDataspace.RemoveReferenceIfPresent(const path: string);
var
  DE : TDataspaceEntry;
begin
  DE := FindEntryByFullName(path);
  if Assigned(DE) then
    RemoveReference(DE);
end;

procedure TDataspace.ProcessArray(DE: TDataspaceEntry; aDS: TDSData; var doffset : integer);
var
  j, k, bytesWritten : integer;
  idx, cnt : Word;
  pDV : ^DopeVector;
  val : Cardinal;
  Sub : TDataspaceEntry;
begin
// 1. Create a new DopeVector entry in our DopeVectorArray
  idx := Word(Length(aDS.DopeVecs));
  // create a dope vector entry for this array
  SetLength(aDS.DopeVecs, idx+1);
  pDV := @(aDS.DopeVecs[idx]);

// 2. Increment our dope vector count
  inc(aDS.DopeVecs[0].count);
  // offset and link values will be calculated after we have finished

// 3. Fill in DopeVector values common to all three types of arrays
  pDV^.elemsize := DE.ArrayElementSize;
  // NOTE: the backptr value is unused in the 1.03 firmware
{ TODO: I need to add code here to handle arrays of arrays which
  output a different backptr value. }
  if DE.ArrayMember then
    pDV^.backptr := NESTED_ARRAY_BACKPTR
  else
    pDV^.backptr  := DE.Address; // the DS address of the array

// 4. Fill in the DopeVector values based on array type (array of struct,
//    array of array, or array of scalar)
// 5. Write dynamic default values to the dataspace (by array type)
  Sub := DE.SubEntries[0];
  if (Sub.DataType = dsArray) or DE.ArrayMember then
  begin
    // array of array or array of struct or scalar that is itself an array member
    if DE.ArrayMember and (Sub.DataType <> dsArray) then
      pDV^.count := 1
    else
      pDV^.count := 0; // an array containing an array always has count of 0 ???
    if DE.ArrayMember then
      k := 2 // nested arrays output DVAIndex ???
    else
      k := 1; // the top level element of a nested array seems to write just one byte (padded)
    cnt := RoundToByteSize(Word(k), DWORD_LEN);
    SetLength(aDS.DynamicDefaults, doffset+cnt);
    pDV^.link := 2;
    // write to dynamic data
    bytesWritten := k;
    if DE.ArrayMember then
    begin
      aDS.DynamicDefaults[doffset+0] := GetByte(DE.DefaultValue, 0);
      aDS.DynamicDefaults[doffset+1] := GetByte(DE.DefaultValue, 1);
    end
    else
    begin
      aDS.DynamicDefaults[doffset+0] := 1;
    end;
    // now write the pad bytes
    for j := 0 to cnt - bytesWritten - 1 do
      aDS.DynamicDefaults[doffset+bytesWritten+j] := $FF;
  end
  else if Sub.DataType = dsCluster {and not an array member} then
  begin
    // array of struct
    pDV^.count := Word(Sub.ValueCount div Sub.SubEntries.Count);
    // even if there are not initialization values for an array of struct
    // we will write out dynamic data for the array anyway
    if pDV^.count = 0 then
      cnt := pDV^.elemsize
    else
      cnt := Word(pDV^.count * pDV^.elemsize);
    cnt := RoundToByteSize(cnt, DWORD_LEN);
    SetLength(aDS.DynamicDefaults, doffset+cnt);
    // set a flag so that I can tell whether this is an array of struct
    // or a nested array or an array of scalar
    pDV^.link := 1;
    // write to dynamic data
    // clusters store the initialization data one level down
    // and it is organized by cluster member
    DE.SaveToDynamicDefaults(aDS, cnt, doffset);
  end
  else
  begin
    // non-nested array of scalars
    pDV^.count := DE.ValueCount;
    cnt := Word(pDV^.count * pDV^.elemsize);
    cnt := RoundToByteSize(cnt, DWORD_LEN);
    SetLength(aDS.DynamicDefaults, doffset+cnt);
    pDV^.link := 0;
    // write to dynamic data
    bytesWritten := 0;
    for j := 0 to pDV^.count - 1 do
    begin
      val := DE.Values[j];
      for k := 0 to pDV^.elemsize - 1 do
      begin
        aDS.DynamicDefaults[doffset+(j*pDV^.elemsize)+k] := GetByte(val, k);
        inc(bytesWritten);
      end;
    end;
    // now write the pad bytes
    for j := 0 to cnt - bytesWritten - 1 do
      aDS.DynamicDefaults[doffset+bytesWritten+j] := $FF;
  end;

// 6. Update the Memory Manager Head pointer (if needed)
  // Point the head at this entry if it a) hasn't been set yet and
  //   b) this entry has a count > 0
  if (aDS.Head = 0) and (pDV^.count > 0) then
    aDS.Head := idx; // the index of this entry in the array

// 7. Finally, increment the dynamic default data offset pointer
  inc(doffset, cnt);
end;

procedure TDataspace.AddReference(DE: TDataspaceEntry);
begin
  // if this item has a parent then incref at the parent level
  if DE.DSBase.Root <> nil then
    DE.DSBase.Root.IncRefCount
  else
    DE.IncRefCount;
end;

procedure TDataspace.RemoveReference(DE: TDataspaceEntry);
begin
  if DE.DSBase.Root <> nil then
    DE.DSBase.Root.DecRefCount
  else
    DE.DecRefCount;
end;

{ TDataspaceEntry }

procedure TDataspaceEntry.AddValue(aValue: Cardinal);
begin
  fArrayValues.Add(TCardinalObject.Create(aValue));
end;

function StripArrayAndStructDelimiters(const str : string) : string;
begin
  Result := Trim(Replace(Replace(Replace(Replace(str, '{', ''), '}', ''), '[', ''), ']', ''));
  // if the string either starts or ends with a comma then delete it.
  if Pos(',', Result) = 1 then
    System.Delete(Result, 1, 1);
  if LastDelimiter(',', Result) = Length(Result) then
    System.Delete(Result, Length(Result), 1);
  Result := Trim(Result);
end;

function ValueAsCardinal(aValue : Extended; aDST : TDSType = dsVoid) : Cardinal;
var
  iVal : Int64;
  sVal : Single;
begin
  iVal := Trunc(aValue);
  if (iVal = aValue) and (aDST <> dsFloat) then
    Result := Cardinal(iVal)
  else
  begin
    sVal := aValue;
    Result := SingleToCardinal(sVal);
  end;
end;

function CalcDSType(aDSType : TDSType; aValue : Extended) : TDSType;
var
  oldBPT, newBPT : byte;
begin
  Result := GetArgDataType(aValue);
  if Result <> aDSType then
  begin
    oldBPT := BytesPerType[aDSType];
    newBPT := BytesPerType[Result];
    if oldBPT >= newBPT then
    begin
      // we will return the old type since it is >= new type
      if (Result in [dsSByte, dsSWord, dsSLong]) and
         (aDSType in [dsUByte, dsUWord, dsULong]) then
      begin
        // if new type is signed but old is unsigned then switch to equivalent signed type
        Result := TDSType(Ord(aDSType)+1); // signed is always unsigned+1
      end
      else
      begin
        // in all other cases (old signed, new unsigned or both same)
        // just return old type
        Result := aDSType;
      end;
    end;
  end;
end;

function TDataspaceEntry.AddValuesFromString(Calc : TNBCExpParser; sargs: string) : TDSType;
var
  i : integer;
  SL : TStringList;
  x : Byte;
  fVal : Extended;
begin
  Result := dsUByte; // default value type is unsigned byte
  sargs := Trim(sargs);
  // sargs is a comma-separated list of values
  // it could also be a ? or a {} pair
  if (sargs = '') or (sargs = '?') or (sargs = '{}') then Exit;
  SL := TStringList.Create;
  try
    // is sargs a quoted string?
    if QuotedString(sargs) then
    begin
      sargs := Copy(sargs, 2, Length(sargs)-2); // remove quotes at both ends
      for i := 1 to Length(sargs) do
      begin
        x := Ord(sargs[i]);
        case x of
          6 : AddValue(Ord('\'));
          7 : AddValue(Ord(''''));
          8 : AddValue(Ord('"'));
        else
          AddValue(x);
        end;
      end;
      // add a null terminator
      AddValue(0);
    end
    else
    begin
      sargs := StripArrayAndStructDelimiters(sargs);
      SL.CommaText := sargs;
      if DataType = dsCluster then
      begin
        // initialize cluster members
        if Self.ArrayMember then
        begin
          for i := 0 to SL.Count - 1 do
          begin
            Calc.Expression := SL[i];
            fVal := Calc.Value;
            AddValue(ValueAsCardinal(fVal));
            Result := CalcDSType(Result, fVal);
          end;
        end
        else
        begin
          for i := 0 to Self.SubEntries.Count - 1 do
          begin
            if i < SL.Count then
            begin
              Calc.Expression := SL[i];
              fVal := Calc.Value;
              SubEntries[i].DefaultValue := ValueAsCardinal(fVal, SubEntries[i].DataType);
              Result := CalcDSType(dsUByte, fVal);
            end;
          end;
        end;
      end
      else if DataType = dsArray then
      begin
        // initialize array
        // first check whether this is an array of scalars or an array
        // of structs or array of array
        if Self.SubEntries[0].DataType in [dsCluster, dsArray] then
          SubEntries[0].AddValuesFromString(Calc, sargs)
        else
        begin
          for i := 0 to SL.Count - 1 do
          begin
            Calc.Expression := SL[i];
            fVal := Calc.Value;
            AddValue(ValueAsCardinal(fVal, Self.SubEntries[0].DataType));
            Result := CalcDSType(Result, fVal);
          end;
        end;
      end
      else
      begin
        // initialize scalar types
        // if there is only one value then used DefaultValue rather
        // than AddValue
        Calc.Expression := SL[0];
        fVal := Calc.Value;
        DefaultValue := ValueAsCardinal(fVal, DataType);
        Result := CalcDSType(dsUByte, fVal);
      end;
    end;
  finally
    SL.Free;
  end;
end;

function TDataspaceEntry.ElementSize: Word;
var
  i, bpt, padBytes : integer;
  DE : TDataspaceEntry;
begin
  Result := 0;
  if DataType in [dsVoid..dsSLong, dsMutex, dsFloat] then
  begin
    Result := Word(BytesPerType[DataType]);
  end
  else
  begin
    // handle special cases (arrays of clusters and arrays of arrays)
    if DataType = dsCluster then
    begin
      // calculate the padded size of a cluster
      for i := 0 to SubEntries.Count - 1 do
      begin
        DE := SubEntries[i];
        bpt := DE.ElementSize; // 2006-10-02 JCH recursively calculate the element size
        // this fixes a problem with the size of arrays containing nested aggregate types
        padBytes := bpt - (Result mod bpt);
        if padBytes < bpt then
        begin
          Result := Word(Result + padBytes);
        end;
        Result := Word(Result + bpt);
      end;
      Result := RoundToBytesize(Result, DWORD_LEN);
    end
    else if DataType = dsArray then
    begin
      // TODO: check validity of array of array element size calculation
//      Result := ArrayElementSize + 4;
      Result := 4;
    end
    else
      Result := 4;
  end;
end;

function TDataspaceEntry.ArrayElementSize: Word;
begin
  Result := 0;
  if DataType <> dsArray then Exit;
  if SubEntries[0].DataType = dsArray then
    Result := 2
  else
    Result := SubEntries[0].ElementSize;
end;

procedure TDataspaceEntry.AssignTo(Dest: TPersistent);
var
  i : integer;
begin
  if Dest is TDataspaceEntry then
  begin
    TDataspaceEntry(Dest).Identifier   := Self.Identifier;
    TDataspaceEntry(Dest).DataType     := Self.DataType;
    TDataspaceEntry(Dest).DefaultValue := Self.DefaultValue;
    TDataspaceEntry(Dest).ArrayMember  := Self.ArrayMember;
    TDataspaceEntry(Dest).SubEntries   := Self.SubEntries;
    TDataspaceEntry(Dest).fArrayValues.Clear;
    for i := 0 to Self.ValueCount - 1 do
      TDataspaceEntry(Dest).AddValue(Self.Values[i]);
  end
  else
    inherited;
end;

constructor TDataspaceEntry.Create(ACollection: TCollection);
begin
  inherited;
  fThreadNames := TStringList.Create;
  TStringList(fThreadNames).Sorted := True;
  TStringList(fThreadNames).Duplicates := dupIgnore;
  fSubEntries := TDSBase.Create;
  fSubEntries.Parent := Self;
  fArrayValues := TObjectList.Create;
  fArrayMember := False;
  fRefCount    := 0;
end;

destructor TDataspaceEntry.Destroy;
begin
  FreeAndNil(fThreadNames);
  FreeAndNil(fArrayValues);
  FreeAndNil(fSubEntries);
  inherited;
end;

function TDataspaceEntry.GetInitializationString: string;
begin
  if DataType = dsArray then
    Result := GetArrayInit
  else if DataType = dsCluster then
    Result := GetClusterInit
  else
    Result := ValToStr(DataType, DefaultValue);
end;

function TDataspaceEntry.GetArrayInit: string;
var
  i : integer;
  bIsString : boolean;
  Sub : TDataspaceEntry;
  x : Char;
begin
  Result := '';
  if DataType <> dsArray then Exit; // no output if this isn't an array
  if Self.ArrayMember then Exit;
  Sub := SubEntries[0];
  if Sub.DataType = dsCluster then
  begin
    // the values are each considered to be the values of cluster members
    // so group the values using {} around N elements based on the
    // cluster definition
    for i := 0 to Sub.ValueCount - 1 do
    begin
      if (i mod Sub.SubEntries.Count) = 0 then
      begin
        if Length(Result) > 0 then
          Delete(Result, Length(Result)-1, MaxInt);
        if i > 0 then
          Result := Result + '}, {'
        else
          Result := Result + '{';
      end;
      Result := Result + '0x' + IntToHex(Sub.Values[i], 1) + ', ';
    end;
    Delete(Result, Length(Result)-1, MaxInt);
    if Length(Result) > 0 then
      Result := Result + '}';
  end
  else if Sub.DataType = dsArray then
  begin
    Result := Sub.InitializationString; // ????
    if Trim(Result) <> '' then
      Result := '['+Result+']';
  end
  else
  begin
    // an array of scalars
    bIsString := False;
    if (ValueCount > 1) and
       (Values[ValueCount - 1] = 0) and
       (Sub.DataType in [dsUByte, dsSByte]) then
    begin
      // at least 2 items and the last one is zero and it is an array of byte
      // Maybe this is a string???
      bIsString := True;
      for i := 0 to ValueCount - 2 do // skip the 0 at the end
      begin
        // check that all values are in the alphanumeric ASCII range
        if (Values[i] < 32) or (Values[i] > 126) then
        begin
          bIsString := False;
          break;
        end;
      end;
    end;
    if bIsString then
    begin
      Result := '''';
      for i := 0 to ValueCount - 2 do // skip null
      begin
        x := Chr(Values[i]);
        case x of
          '"', '''' : Result := Result + '\' + x;
        else
          Result := Result + x;
        end;
      end;
      Result := Result + '''';
    end
    else
    begin
      for i := 0 to ValueCount - 1 do
      begin
        Result := Result + '0x' + IntToHex(Values[i], 1) + ', ';
      end;
      Delete(Result, Length(Result)-1, MaxInt);
    end;
  end;
end;

function TDataspaceEntry.GetClusterInit: string;
var
  i : integer;
  Sub : TDataspaceEntry;
begin
  Result := '';
  if DataType <> dsCluster then Exit; // no output if this isn't a cluster
  for i := 0 to SubEntries.Count - 1 do
  begin
    Sub := SubEntries[i];
    if Result = '' then
      Result := Sub.InitializationString
    else
      Result := Result + ', ' + Sub.InitializationString;
  end;
  if Result <> '' then
    Result := '{' + Result + '}';
end;

function TDataspaceEntry.GetDataTypeAsString: string;
begin
  if DataType = dsCluster then
    Result := Identifier + '_def'
  else if DataType = dsArray then
  begin
    if SubEntries[0].DataType = dsCluster then
      Result := SubEntries[0].Identifier + '_def[]'
    else if SubEntries[0].DataType = dsArray then
      Result := SubEntries[0].DataTypeAsString + '[]'
    else
      Result := TypeToStr(SubEntries[0].DataType) + '[]';
  end
  else
    Result := TypeToStr(DataType);
end;

function TDataspaceEntry.GetDSBase: TDSBase;
begin
  Result := TDSBase(Collection);
end;

function TDataspaceEntry.GetFullPathIdentifier: string;
begin
  // ask my collection what my full path identifier is
  Result := DSBase.FullPathName(self);
end;

function TDataspaceEntry.GetValue(idx: integer): Cardinal;
begin
  Result := TCardinalObject(fArrayValues[idx]).Value;
end;

procedure TDataspaceEntry.LoadFromStream(aStream: TStream);
var
  X : DSTOCEntry;
begin
  X.TypeDesc := 0;
  X.Flags := 0;
  X.DataDesc := 0;
  aStream.Read(X.TypeDesc, 1);
  aStream.Read(X.Flags, 1);
  ReadWordFromStream(aStream, X.DataDesc);
  // copy DSTOCEntry values to collection item
  X.TypeDesc := Byte(Ord(Self.DataType));
end;

procedure TDataspaceEntry.SaveToStream(aStream: TStream);
var
  X : DSTOCEntry;
begin
  // copy collection item values to DSTOCEntry
  X.TypeDesc := Byte(Ord(DataType));
  if DefaultValue <> 0 then
    X.Flags := 0
  else
    X.Flags := 1;
  case DataType of
    dsCluster : X.DataDesc := Word(SubEntries.Count);
  else
    X.DataDesc := Address;
  end;
  aStream.Write(X.TypeDesc, 1);
  aStream.Write(X.Flags, 1);
  WriteWordToStream(aStream, X.DataDesc);
end;

function Replicate(const str : string; const times : integer) : string;
var
  i : integer;
begin
  Result := '';
  for i := 0 to times - 1 do
    Result := Result + str;
end;

procedure TDataspaceEntry.SaveToStrings(aStrings: TStrings; bDefine, bInCluster : boolean);
var
  tmpStr : string;
  i : integer;
begin
  // write self and subentries to strings
  if bDefine then
  begin
    for i := 0 to SubEntries.Count - 1 do
      SubEntries[i].SaveToStrings(aStrings, True);
  end;
  case DataType of
    dsArray : begin
      // arrays should have only one sub entry
      if SubEntries.Count > 0 then
      begin
        // if the array type is a structure then define it first and then output
        // the array declaration
        tmpStr := Format('%s'#9'%s', [Identifier, DataTypeAsString]);
        if not bInCluster then
          tmpStr := tmpStr + Format(#9'%s', [InitializationString]);
        if not bDefine or bInCluster then
          aStrings.Add(tmpStr);
      end;
    end;
    dsCluster : begin
        // definitions are only needed for items which are clusters
      if bDefine then
      begin
        if DataType = dsCluster then
        begin
          // only output a definition if this item is the first of its type
          tmpStr := Format('%s_def'#9'%s', [Identifier, 'struct']);
          aStrings.Add(tmpStr);
          for i := 0 to SubEntries.Count - 1 do
            SubEntries[i].SaveToStrings(aStrings, False, True);
          tmpStr := Format('%s_def'#9'%s', [Identifier, 'ends']);
          aStrings.Add(tmpStr);
        end;
      end
      else
      begin
        tmpStr := Format('%s'#9'%s'#9'%s', [Identifier, DataTypeAsString, InitializationString]);
        aStrings.Add(tmpStr);
      end;
    end;
    dsVoid, dsMutex : begin
      tmpStr := Format('%s'#9'%s', [Identifier, DataTypeAsString]);
      if not bDefine or bInCluster then
        aStrings.Add(tmpStr);
    end;
  else
    // scalars & floats
    tmpStr := Format('%s'#9'%s', [Identifier, DataTypeAsString]);
    if not {bDefine}bInCluster then
      tmpStr := tmpStr + Format(#9'%s', [InitializationString]);
    if not bDefine or bInCluster then
      aStrings.Add(tmpStr);
  end;
end;

procedure TDataspaceEntry.SetArrayMember(const Value: boolean);
var
  i : integer;
begin
  fArrayMember := Value;
  // iterate through all sub entries
  for i := 0 to SubEntries.Count - 1 do
    SubEntries[i].ArrayMember := Value;
end;

procedure TDataspaceEntry.SetIdentifier(const Value: string);
begin
  fIdentifier := Value;
  DSBase.fEntryIndex.AddObject(Self.FullPathIdentifier, Self);
  DSBase.CheckEntry(self);
end;

procedure TDataspaceEntry.SetSubEntries(const Value: TDSBase);
begin
  fSubEntries.Assign(Value);
end;

function TDataspaceEntry.ValueCount: Word;
begin
  Result := Word(fArrayValues.Count);
end;

procedure TDataspaceEntry.SaveToDynamicDefaults(aDS: TDSData;
  const cnt, doffset: integer);
var
  elemsize : integer;
  X : TDataspaceEntry;

  procedure DoSaveToDynDefaults;
  var
    idx, vc : integer;
    val : Cardinal;
    j, bytesWritten : word;
    bpt : Byte;
    i, k : integer;
  begin
    if X.ValueCount = 0 then
      vc := X.SubEntries.Count
    else
      vc := X.ValueCount;
    // we need to write a total of cnt bytes to aDS.DynamicDefaults at
    // offset == doffset
    // the values come from SubEntries[0].Values[n]
    bytesWritten := 0;
    j := 0;
    for i := 0 to vc - 1 do
    begin
      if X.ValueCount = 0 then
        val := 0
      else
        val := X.Values[i];
      idx := i mod X.SubEntries.Count; // calculate the field index
      bpt := BytesPerType[X.SubEntries[idx].DataType];
      if (idx = 0) and (i <> 0) then
      begin
        // we have wrapped around to another element in the array
        // pad to full structure size.
        // j must be within 0..elemsize-1
        j := Word((elemsize - (j mod elemsize)) mod elemsize);
        for k := 0 to j - 1 do
          aDS.DynamicDefaults[doffset+bytesWritten+k] := $FF;
        inc(bytesWritten, j);
        j := bytesWritten;
      end;
      // are we at the right boundary for the next (current) struct field?
      j := RoundToBytesize(j, bpt);
      if j > bytesWritten then
        for k := 0 to j - bytesWritten - 1 do
          aDS.DynamicDefaults[doffset+bytesWritten+k] := $FF;
      bytesWritten := j;
      // now we are ready to output this field's value
      for k := 0 to bpt - 1 do
      begin
        aDS.DynamicDefaults[doffset+j+k] := GetByte(val, k);
        inc(bytesWritten);
      end;
      j := bytesWritten;
    end;
    // if we haven't written the full cnt bytes out then pad.
    for k := 0 to cnt - bytesWritten - 1 do
      aDS.DynamicDefaults[doffset+bytesWritten+k] := $FF;
  end;
begin
  // this routine is for saving array of struct or array of arrays to dynamic data
  if DataType <> dsArray then Exit;
  if SubEntries.Count <> 1 then Exit;
  elemsize := ArrayElementSize;
  X := SubEntries[0];
  if X.DataType in [dsCluster, dsArray] then
  begin
    DoSaveToDynDefaults;
  end;
end;

function TDataspaceEntry.GetInUse: boolean;
var
  i : integer;
begin
  Result := fRefCount > 0;
  if not Result and (DataType = dsCluster) then
  begin
    for i := 0 to SubEntries.Count - 1 do
    begin
      Result := SubEntries[i].InUse;
      if Result then
        Break;
    end;
  end;
end;

function TDataspaceEntry.GetRefCount: integer;
begin
  Result := fRefCount;
end;

procedure TDataspaceEntry.IncRefCount;
var
  i : integer;
begin
  inc(fRefCount);
  // check sub entries if this entry is a cluster
  if DataType = dsCluster then
  begin
    for i := 0 to SubEntries.Count - 1 do
    begin
      SubEntries[i].IncRefCount;
    end;
  end;
end;

procedure TDataspaceEntry.DecRefCount;
var
  i : integer;
begin
  dec(fRefCount);
  if DataType = dsCluster then
  begin
    for i := 0 to SubEntries.Count - 1 do
    begin
      SubEntries[i].DecRefCount;
    end;
  end;
end;

function TDataspaceEntry.GetArrayBaseType: TDSType;
begin
  Result := DataType;
  if IsArray then
    Result := SubEntries[0].BaseDataType;
end;

function TDataspaceEntry.GetIsArray: boolean;
begin
  Result := DataType = dsArray;
end;

procedure TDataspaceEntry.AddThread(const aThreadName: string);
begin
  fThreadNames.Add(aThreadName);
end;

function TDataspaceEntry.ThreadCount: integer;
begin
  Result := fThreadNames.Count;
end;

{ TRXEProgram }

constructor TRXEProgram.Create;
begin
  inherited;
  fMaxErrors        := 0;
  fIgnoreSystemFile := False;
  fEnhancedFirmware := False;
  fWarningsOff      := False;
  fReturnRequired   := False;
  fCaseSensitive    := True;
  fStandardDefines  := True;
  fExtraDefines     := True;
  fCompVersion      := 5;
  fProductVersion   := GetProductVersion;
  CreateObjects;
  InitializeHeader;
  FirmwareVersion  := 105; // 1.05 NXT 1.1 firmware
end;

destructor TRXEProgram.Destroy;
begin
  FreeObjects;
  inherited;
end;

procedure TRXEProgram.LoadFromStream(aStream: TStream);
begin
 // TODO: implement loadfromstream
  aStream.Position := 0;
end;

function TRXEProgram.SaveToFile(const filename: string) : boolean;
var
  MS : TMemoryStream;
begin
  MS := TMemoryStream.Create;
  try
    Result := SaveToStream(MS);
    MS.SaveToFile(filename);
  finally
    MS.Free;
  end;
end;

function TRXEProgram.SaveToStream(aStream: TStream) : boolean;
begin
  Result := False;
  if fBadProgram then
  begin
    fMsgs.Add(Format(sProgramError, [fProgErrorCount]));
  end
  else
  begin
    DoCompilerStatusChange(sNBCFinalizeDepends);
    // make sure our dependencies are finalized
    Codespace.FinalizeDependencies;
    // possibly optimize if Optimize level > 0
    if OptimizeLevel >= 1 then
    begin
      DoCompilerStatusChange(Format(sNBCOptimizeLevel, [OptimizeLevel]));
      DoCompilerStatusChange(sNBCBuildRefs);
      // build references if we are optimizing
      Codespace.BuildReferences;
      DoCompilerStatusChange(sNBCOptMutexes);
      // optimize mutexes
      Codespace.OptimizeMutexes;
      DoCompilerStatusChange(sNBCCompactCode);
      // compact the codespace before codespace optimizations
      Codespace.Compact;
      DoCompilerStatusChange(sNBCRemoveLabels);
      // also get rid of extra labels
      Codespace.RemoveUnusedLabels;
      // 2009-03-18 JCH: I have restored the level 2 optimizations
      // As defects are revealed they will be fixed  Some optimizations
      // will be only performed at levels higher than 2 so I now pass the
      // level into the optimization function itself.
      if OptimizeLevel >= 2 then
      begin
        DoCompilerStatusChange(sNBCRunCodeOpts);
        Codespace.Optimize(OptimizeLevel);
        DoCompilerStatusChange(sNBCCompactAfterOpt);
        // after optimizations we should re-compact the codespace
        Codespace.Compact;
      end;
      // after optimizing and compacting the codespace we remove
      // unused variables from the dataspace
      DoCompilerStatusChange(sNBCCompactData);
      Dataspace.Compact;
    end
    else
    begin
      // level zero (no optimizations)
      DoCompilerStatusChange(sNBCRemoveLabels);
      // also get rid of extra labels
      Codespace.RemoveUnusedLabels;
      // after optimizing and compacting the codespace we remove
      // unused variables from the dataspace
      DoCompilerStatusChange(sNBCCompactData);
      Dataspace.Compact;
    end;
    if not WarningsOff then
      OutputUnusedItemWarnings;
    DoCompilerStatusChange(sNBCSortDataspace);
    // sort the dataspace
    Dataspace.Sort;
    DoCompilerStatusChange(sNBCGenerateRawDS);
    // write the dataspace to DSData
    Dataspace.SaveToDSData(fDSData);
    DoCompilerStatusChange(sNBCFillCodeArrays);
    // fill the clumprecords and codespace array
    Codespace.SaveToCodeData(fClumpData, fCode);
    DoCompilerStatusChange(sNBCUpdateHeader);
    // having done that I can now update the header
    UpdateHeader;
    // and write everything to the stream
    aStream.Position := 0;
    DoCompilerStatusChange(sNBCWriteHeader);
    WriteHeaderToStream(aStream, fHeader);
    DoCompilerStatusChange(sNBCWriteDataspace);
    fDSData.SaveToStream(aStream);
    DoCompilerStatusChange(sNBCWriteClumpData);
    fClumpData.SaveToStream(aStream);
    DoCompilerStatusChange(sNBCWriteCodespace);
    fCode.SaveToStream(aStream);
    Result := not fBadProgram;
    if Result then
    begin
      DoCompilerStatusChange(sNBCWriteOptSource);
      // replace the original "compiler output" with the optimized version
      SaveToStrings(CompilerOutput);
    end;
  end;
  DoCompilerStatusChange(sNBCFinished);
end;

function TRXEProgram.GetVersion: byte;
begin
  Result := fHeader.Version;
end;

procedure TRXEProgram.SetVersion(const Value: byte);
begin
  fHeader.Version := Value;
end;

function TRXEProgram.GetFormat: string;
begin
  Result := fHeader.FormatString;
end;

procedure TRXEProgram.SetFormat(const Value: string);
var
  i : integer;
begin
  for i := 0 to 12 do
    fHeader.FormatString[i] := Value[i];
  fHeader.FormatString[13] := #0;
end;

function TRXEProgram.GetClumpCount: Word;
begin
  Result := fHeader.ClumpCount;
end;

function TRXEProgram.GetCodespaceCount: Word;
begin
  Result := fHeader.CodespaceCount;
end;

function TRXEProgram.GetDSCount: Word;
begin
  Result := fHeader.DSCount;
end;

function TRXEProgram.GetDSDefaultsSize: Word;
begin
  Result := fHeader.DSDefaultsSize;
end;

function TRXEProgram.GetDSSize: Word;
begin
  Result := fHeader.DSSize;
end;

function TRXEProgram.GetDVArrayOffset: Word;
begin
  Result := fHeader.DVArrayOffset;
end;

function TRXEProgram.GetDynDSDefaultsOffset: Word;
begin
  Result := fHeader.DynDSDefaultsOffset;
end;

function TRXEProgram.GetDynDSDefaultsSize: Word;
begin
  Result := fHeader.DynDSDefaultsSize;
end;

function TRXEProgram.GetMemMgrHead: Word;
begin
  Result := fHeader.MemMgrHead;
end;

function TRXEProgram.GetMemMgrTail: Word;
begin
  Result := fHeader.MemMgrTail;
end;

function TRXEProgram.Parse(aStream: TStream) : string;
var
  S : TStrings;
begin
  S := TStringList.Create;
  try
    S.LoadFromStream(aStream);
    Result := Parse(S);
  finally
    S.Free;
  end;
end;

procedure TRXEProgram.LoadSystemFile(S : TStream);
var
  tmp : string;
begin
  // load fMS with the contents of NBCCommon.h followed by NXTDefs.h
  tmp := '#line 0 "NXTDefs.h"'#13#10;
  S.Write(PChar(tmp)^, Length(tmp));
  S.Write(nbc_common_data, High(nbc_common_data)+1);
  S.Write(nxt_defs_data, High(nxt_defs_data)+1);
  tmp := '#reset'#13#10;
  S.Write(PChar(tmp)^, Length(tmp));
end;

function TRXEProgram.Parse(aStrings: TStrings) : string;
var
  i, idx : integer;
  P : TLangPreprocessor;
  S : TMemoryStream;
  tmpFile, tmpMsg : string;
begin
  Result := '';
  try
    if not IgnoreSystemFile then
    begin
      S := TMemoryStream.Create;
      try
        DoCompilerStatusChange(sNBCLoadSystemFiles);
        LoadSystemFile(S);
        aStrings.SaveToStream(S);
        S.Position := 0;
        aStrings.LoadFromStream(S);
      finally
        S.Free;
      end;
    end;
    fBadProgram       := False;
    fProgErrorCount   := 0;
    LineCounter       := 0;
    fAbsCount         := 0;
    fSignCount        := 0;
    fShiftCount       := 0;
    fMainStateLast    := masCodeSegment; // used only when we enter a block comment
    fMainStateCurrent := masCodeSegment; // default state
    P := TLangPreprocessor.Create(TNBCLexer, ExtractFilePath(ParamStr(0)), lnNBC);
    try
      P.Defines.AddDefines(Defines);
      if EnhancedFirmware then
        P.Defines.Define('__ENHANCED_FIRMWARE');
      P.Defines.AddEntry('__FIRMWARE_VERSION', IntToStr(FirmwareVersion));
      P.AddIncludeDirs(IncludeDirs);
      if not IgnoreSystemFile then
      begin
        P.SkipIncludeFile('NBCCommon.h');
        P.SkipIncludeFile('NXTDefs.h');
      end;
      DoCompilerStatusChange(sNBCPreprocess);
      // Preprocess returns a list of files from #download statements
      Result := P.Preprocess(GetCurrentFile(true), aStrings);
      for i := 0 to P.Warnings.Count - 1 do
      begin
        tmpMsg := P.Warnings.ValueFromIndex[i];
        idx := Pos('|', tmpMsg);
        tmpFile := Copy(tmpMsg, 1, idx-1);
        Delete(tmpMsg, 1, idx);
        ReportProblem(StrToIntDef(P.Warnings.Names[i], 0), tmpFile, '', tmpMsg, false);
      end;
    finally
      P.Free;
    end;
//    aStrings.SaveToFile('preproc.txt');
    DoCompilerStatusChange(sNBCCompilingSource);
    for i := 0 to aStrings.Count - 1 do
    begin
      if fSkipCount = 0 then
        LineCounter := LineCounter + 1;
      ProcessASMLine(aStrings, i);
      if fSkipCount > 0 then
        Dec(fSkipCount);
    end;
    DoCompilerStatusChange(sNBCCompFinished);
    CheckMainThread;
    if not fBadProgram then
      fBadProgram := Codespace.Count = 0;
    if not fBadProgram then
      fCompilerOutput.Assign(aStrings);
  except
    on E : EAbort do
    begin
      fBadProgram := True;
      // end processing file due to Abort in ReportProblem
    end;
    on E : EPreprocessorException do
    begin
      fBadProgram := True;
      ReportProblem(E.LineNo, GetCurrentFile(true), sException, E.Message, true);
    end;
    on E : Exception do
    begin
      fBadProgram := True;
      ReportProblem(LineCounter, GetCurrentFile(true), sException, E.Message, true);
    end;
  end;
end;

function GetValidLineTypes(const state : TMainAsmState) : TAsmLineTypes;
begin
  case state of
    masClump            : Result := [altEndClump, altBeginDS, altCode, altCodeDepends];
    masClumpSub         : Result := [altEndSub, altBeginDS, altCode];
    masCodeSegment      : Result := [altBeginClump, altBeginDS, altBeginSub];
    masStruct           : Result := [altEndStruct, altVarDecl];
    masDSClump          : Result := [altEndDS, altVarDecl, altTypeDecl, altBeginStruct];
    masStructDSClump    : Result := [altEndStruct, altVarDecl];
    masDSClumpSub       : Result := [altEndDS, altVarDecl, altTypeDecl, altBeginStruct];
    masStructDSClumpSub : Result := [altEndStruct, altVarDecl];
  else // masDataSegment
    Result := [altEndDS, altVarDecl, altTypeDecl, altBeginStruct];
  end;
end;

function CommasToSpaces(const line : string) : string;
var
  i : integer;
  bInString : boolean;
  ch : Char;
begin
  i := Pos('''', line); // is there a string initializer on this line?
  if i > 0 then
  begin
    // if there is a string on this line then process a character at a time
    bInString := False;
    Result := '';
    for i := 1 to Length(line) do begin
      ch := line[i];
      if (ch = ',') and not bInString then
        ch := ' '
      else if ch = '''' then
        bInString := not bInString;
      Result := Result + ch;
    end;
  end
  else
    Result := Replace(line, ',', ' ');
end;

function TRXEProgram.DetermineLineType(const state : TMainAsmState; namedTypes: TMapList;
  op : string; bUseCase : boolean) : TAsmLineType;
begin
  // special handling for [] at end of opcode
  op := Replace(op, '[]', '');
  case StrToOpcode(op, bUseCase) of
    OP_ADD..OP_GETTICK : Result := altCode;
    OPS_WAITV..OPS_POW : Result := altCode; // pseudo opcodes
//    OPS_SQRT_2..OPS_ABS_2 : Result := altCode; // standard 1.26+ opcodes (included in OPS_WAITV..OPS_POW due to overlap)
    OPS_WAITI_2..OPS_ATAN2D_2 : Result := altCode; // enhanced 1.26+ opcodes
    OPS_SEGMENT : Result := altBeginDS;
    OPS_ENDS :
      if state in [masStruct, masStructDSClump, masStructDSClumpSub] then
        Result := altEndStruct
      else if state = masClumpSub then
        Result := altEndSub
      else
        Result := altEndDS;
    OPS_TYPEDEF : Result := altTypeDecl;
    OPS_THREAD : Result := altBeginClump;
    OPS_ENDT : Result := altEndClump;
    OPS_SUBROUTINE : Result := altBeginSub;
    OPS_STRUCT : Result := altBeginStruct;
    OPS_REQUIRES, OPS_USES : Result := altCodeDepends;
    OPS_DB..OPS_FLOAT : Result := altVarDecl;
    OPS_CALL..OPS_COMPCHKTYPE : Result := altCode; // pseudo opcodes
  else
    // if the opcode isn't known perhaps it is a typedef
    if state in [masDataSegment, masStruct, masDSClump, masStructDSClump,
      masDSClumpSub, masStructDSClumpSub] then
    begin
      if namedTypes.IndexOf(op) <> -1 then
        Result := altVarDecl
      else
        Result := altInvalid;
    end
    else
      Result := altInvalid;
  end;
end;

procedure TrimComments(var line : string; p : integer; const sub : string);
var
  k, j, x : integer;
  tmp : string;
begin
  // before we decide to trim these comment we need to know whether they are
  // embedded in a string or not.
  tmp := line;
  while (p > 0) do
  begin
    k := Pos('''', tmp);
    j := 0;
    if k < p then
    begin
      // hmmm, is there another single quote?
      tmp := Copy(tmp, k+1, MaxInt);
      j := Pos('''', tmp);
      tmp := Copy(tmp, j+1, MaxInt);
      j := j + k;
    end;
    if not ((p > k) and (p < j)) then
    begin
      Delete(line, p, MaxInt); // trim off any trailing comment
      line := TrimRight(line); // trim off any trailing whitespace
      tmp := line;
      p := 0;
    end
    else
      p := j;
    x := Pos(sub, tmp);
    if x > 0 then
      inc(p, x-1)
    else
      p := 0;
  end;
end;

function NBCExtractStrings(str : string; values : TStrings) : integer;
var
  s, p : integer;
begin
  // between 0 and 3 entries in values when I'm done
  values.Clear;
  str := Replace(str, #9, ' ');
  s := Pos(' ', str);
  p := Pos(',', str);
  while (s > 0) and (s < p) do
  begin
    if values.Count > 1 then Break;
    values.Add(Copy(str, 1, s-1));
    System.Delete(str, 1, s);
    str := Trim(str);
    s := Pos(' ', str);
    p := Pos(',', str);
  end;
  if str <> '' then
    values.Add(str);
  Result := values.Count;
end;

procedure TRXEProgram.ChunkLine(const state : TMainAsmState; namedTypes: TMapList;
  line : string; bUseCase : boolean; var lbl, opcode, args : string;
  var lineType : TAsmLineType; var bIgnoreDups : boolean);
var
  i : integer;
  tmp : string;
  values : TStringList;
begin
  bIgnoreDups := True;
  lbl := '';
  opcode := '';
  args := '';
  lineType := altInvalid;
  // break apart the line into its constituent parts
  // whitespace at the beginning and end of the line has already been trimmed.
  // if the first word in the line is an opcode (of any kind) then
  // the label is blank and everything after the opcode is the args
  // if the first word is NOT an opcode then we assume it is a label
  // and we check the second word for whether it is an opcode or not
  // if it is not then the line is invalid.  If it is then everything after
  // the second word is the args
  i := Pos(';', line);
  if i <> 0 then
    TrimComments(line, i, ';');
  i := Pos('//', line);
  if i <> 0 then
    TrimComments(line, i, '//');
  values := TStringList.Create;
  try
    line := CommasToSpaces(line);
    i := JCHExtractStrings([' ', #9], [], PChar(line), values);
    if i = 1 then
    begin
      if StrToOpcode(values[0], bUseCase) = OPS_INVALID then
      begin
        // if there is only one item in the line and it isn't an opcode
        // then it should be a label
        // with an required trailing ':'.  If the colon is missing then
        // the line is invalid
        i := Pos(':', line);
        if i = Length(line) then
        begin
          lbl := Copy(line, 1, i-1);
          lineType := altCode;
        end;
      end
      else
      begin
        // it could be an endt or ends opcode to end the current thread/subroutine
        lbl := '';
        opcode := values[0];
        lineType := DetermineLineType(state, namedTypes, opcode, bUseCase);
      end;
    end
    else if (i > 1) and (i < 3) then
    begin
      // special case is the dseg segment and dseg ends lines
      tmp := values[0];
      if tmp = 'dseg' then
      begin
        lbl := tmp;
        opcode := values[1];
        bIgnoreDups := (values.Count = 3) and (values[2] = '1');
        if opcode = OpcodeToStr(OPS_SEGMENT) then
          lineType := altBeginDS
        else if opcode = OpcodeToStr(OPS_ENDS) then
          lineType := altEndDS;
      end
      else
      begin
        // if the first item is a known opcode then assume no label
        // exists in this line
        if StrToOpcode(values[0], bUseCase) = OPS_INVALID then
        begin
          // label + opcode and no args
          lbl := values[0];
          opcode := values[1];
        end
        else
        begin
          // no label - just opcode and args
          lbl := '';
          opcode := values[0];
          values.Delete(0);
          args := Trim(values.CommaText);
        end;
        lineType := DetermineLineType(state, namedTypes, opcode, bUseCase);
      end;
    end
    else
    begin
      // i >= 3
      // if the first item is a known opcode then assume no label
      // exists in this line
      if StrToOpcode(values[0]) = OPS_INVALID then
      begin
        lbl := values[0];
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
      lineType := DetermineLineType(state, namedTypes, opcode, bUseCase);
    end;
  finally
    values.Free;
  end;
end;

procedure InstantiateCluster(DD : TDataDefs; DE: TDataspaceEntry;
  const clustername: string);
var
  idx : integer;
  Def : TDataspaceEntry;
begin
  DE.TypeName := clustername;
  // find an entry in the datadefs collection with clustername
  idx := DD.IndexOfName(clustername);
  if idx <> -1 then
  begin
    Def := DD[idx];
    DE.SubEntries := Def.SubEntries;
  end;
end;

procedure HandleVarDecl(DD : TDataDefs; NT : TMapList; bCaseSensitive : boolean;
  DSE : TDataspaceEntry; albl, aopcode : string; sttFunc : TSTTFuncType);
var
  stype : string;
  idx, p, len : integer;
  Sub : TDataspaceEntry;
begin
  DSE.Identifier := albl;
  stype := aopcode;
  p := Pos('[]', stype);
  len := Length(stype);
  // calculate the named type index without [] if there are any
  if p > 0 then
  begin
    Delete(aopcode, len-1, 2); // assumes that [] are last two characters
    stype := aopcode;
  end;
  idx := NT.IndexOf(stype);
  if idx <> -1 then
    stype := NT.MapValue[idx];
  if (p > 0) then
  begin
    // this is an array type
    DSE.DataType := dsArray;
    DSE.TypeName := stype;
    Sub := DSE.SubEntries.Add;
    Sub.Identifier := DSE.Identifier + '_type';
    // could be an array of structs (yuck!)
    if (idx <> -1) and (aopcode = stype) then
    begin
      // must be a struct type
      Sub.DataType := dsCluster;
      InstantiateCluster(DD, Sub, stype);
    end
    else
    begin
      HandleVarDecl(DD, NT, bCaseSensitive, Sub, Sub.Identifier, aopcode, sttFunc);
    end;
    Sub.DefaultValue := 0;
    Sub.ArrayMember := True;
  end
  else if (idx <> -1) and (aopcode = stype) then
  begin
    DSE.DataType := dsCluster;
    InstantiateCluster(DD, DSE, stype);
  end
  else
  begin
    // a simple type
    DSE.DataType := sttFunc(stype, bCaseSensitive);
  end;
end;

procedure TRXEProgram.ProcessASMLine(aStrings: TStrings; idx : integer);
var
  i, endBCPos, cPos : integer;
  lbl, opcode, args, errMsg, tmpFile, tmpLine, line : string;
  lineType : TASMLineType;
  ValidLineTypes : TASMLineTypes;
  DE : TDataspaceEntry;
  AL : TAsmLine;
  inBlockComment : boolean;
  theOp : TOpCode;
begin
  try
    lineType := altInvalid;
    args     := '';
    opcode   := '';
    lbl      := '';
    line     := aStrings[idx];
    line := ReplaceTokens(Trim(line));
    aStrings[idx] := line;
    // do nothing if line is blank or a comment
    if (line = '') or (Pos(';', line) = 1) or (Pos('//', line) = 1) then
      Exit;
    // replace \' with #07, replace \" with #08, replace \\ with #06
    line := Replace(Replace(Replace(Replace(line, '\\', #06), '\"', #08), '\''', #07), '"', '''');
    // replace " with '
    line := Replace(line, '"', '''');
    i := Pos('#line ', line);
    if i = 1 then
    begin
      // this is a special preprocessor line
      tmpLine := line;
      Delete(line, 1, 6);
      i := Pos(' ', line);
      LineCounter  := StrToIntDef(Copy(line, 1, i - 1), LineCounter);
      Delete(line, 1, i);
      tmpFile      := Replace(line, '"', '');
      tmpFile      := Replace(tmpFile, '''', '');
      CurrentFile  := tmpFile;
      if fMainStateCurrent in [masClump, masClumpSub] then
      begin
        // add code to the current clump
        AL := fCurrentClump.ClumpCode.Add;
        AL.AsString := tmpLine;
        AL.LineNum  := LineCounter;
      end;
    end
    else if Pos('#download', line) = 1 then
    begin
      // ignore #download lines
      // if we are in a clump then add a special asm line for the #download
      // otherwise just skip it.
      if fMainStateCurrent in [masClump, masClumpSub] then
      begin
        // add code to the current clump
        AL := fCurrentClump.ClumpCode.Add;
        AL.AsString := line;
        AL.LineNum  := LineCounter;
      end;
    end
    else if Pos('#reset', line) = 1 then
    begin
      tmpLine := line;
      LineCounter := 1;
      if fMainStateCurrent in [masClump, masClumpSub] then
      begin
        // add code to the current clump
        AL := fCurrentClump.ClumpCode.Add;
        AL.AsString := tmpLine;
        AL.LineNum  := LineCounter;
      end;
    end
    else if Pos('#pragma ', line) = 1 then
    begin
      // this is a special preprocessor line
      // if we are in a clump then add a special asm line for the #pragma
      // otherwise just skip it.
      if fMainStateCurrent in [masClump, masClumpSub] then
      begin
        // add code to the current clump
        AL := fCurrentClump.ClumpCode.Add;
        AL.AsString := line;
        AL.LineNum  := LineCounter;
        if Pos('safecalling', line) > 0 then
          CodeSpace.Multithread(fCurrentClump.Name);
      end;
      // is this a special #pragma macro line?
      if Pos('macro', line) = 9 then
      begin
        System.Delete(line, 1, 14);
        fSkipCount := StrToIntDef(line, 0)+1;
      end;
    end
    else
    begin
      // check for the possibility that we are starting or ending a block comment on this line
      // nesting block comments is not supported and will result in compiler errors
      i := Pos('/*', line);
      endBCPos := Pos('*/', line);
      if (endBCPos = 0) or ((fMainStateCurrent <> masBlockComment) and (endBCPos = 0)) then
        inBlockComment := i > 0
      else if endBCPos <> 0 then
        inBlockComment := i > endBCPos+1
      else
        inBlockComment := False;
      if (endBCPos > 0) and (fMainStateCurrent = masBlockComment) then
      begin
        // remove everything from line up to end block comment
        Delete(line, 1, endBCPos+1);
        // revert to previous state
        fMainStateCurrent := fMainStateLast;
      end;
      if inBlockComment then
      begin
        Delete(line, i, MaxInt); // delete to end of line
      end
      else if (i > 0) and (endBCPos > i+1) then
      begin
        // just remove the block comment portion of the line
        Delete(line, i, endBCPos-i+2);
        // we don't want a block comment remove to result in a valid
        // identifier or function
        Insert(' ', line, i);
      end;
      // if we were already in a block comment before starting this line
      // and we still are in a block comment after the above processing
      // then we can skip the rest of this routine
      if fMainStateCurrent = masBlockComment then
        Exit;
      // double check for a blank line since we have manipulated it
      if Trim(line) <> '' then
      begin
        // go ahead and process this line as normal
        // chunk the line into its consituent parts
        ChunkLine(fMainStateCurrent, fNamedTypes, line, CaseSensitive, lbl, opcode, args, lineType, fIgnoreDupDefs);
        // what state are we in?
        ValidLineTypes := GetValidLineTypes(fMainStateCurrent);
        if lineType in ValidLineTypes then
        begin
          case fMainStateCurrent of
            masClump, masClumpSub : begin
              // 1. end of clump/sub
              // 2. start of datasegment
              // 3. code
              if (lineType = altEndClump) or (lineType = altEndSub) then
              begin
                fIgnoreLines := False;
                fCurrentClump.LastLine := LineCounter;
                fMainStateCurrent := masCodeSegment;
                // at the end of the current clump we can validate labels
                ValidateLabels(fCurrentClump);
                if ReturnRequiredInSubroutine and (lineType = altEndSub) then
                begin
                  // the last line of a subroutine must be a return!!!
                  if (fCurrentClump.ClumpCode.Count > 0) then
                  begin
                    AL := fCurrentClump.ClumpCode[fCurrentClump.ClumpCode.Count-1];
                    if AL.Command <> OP_SUBRET then
                      ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
                        sNoReturnAtEndOfSub, true);
                  end
                  else
                    ReportProblem(LineCounter, GetCurrentFile(true), line,
                      sNoReturnAtEndOfSub, true);
                end;
                ProcessSpawnedThreads;
                // if we have just ended a clump we may need to create a new
                // one if the clump uses the wait opcode.
                if fClumpUsesWait then
                  CreateWaitClump(fCurrentClump.Name);
                fClumpName := '';
              end
              else if lineType = altBeginDS then
              begin
                if fMainStateCurrent = masClump then
                  fMainStateCurrent := masDSClump
                else
                  fMainStateCurrent := masDSClumpSub;
              end
              else if lineType = altCode then
              begin
                // add code to the current clump
                AL := fCurrentClump.ClumpCode.Add;
                cPos := Pos(':', lbl);
                if cPos > 0 then
                  System.Delete(lbl, cPos, MaxInt);
                lbl := Trim(lbl);
                if lbl <> '' then
                begin
                  AL.LineLabel := lbl;
                  if fCurrentClump.IndexOfLabel(lbl) = -1 then
                    fCurrentClump.AddLabel(lbl, AL)
                  else
                  begin
                    errMsg := Format(sDuplicateLabel, [lbl]);
                    ReportProblem(LineCounter, GetCurrentFile(true), line, errMsg, true);
                  end;
                end;
                AL.LineNum := LineCounter;
                theOp      := StrToOpcode(opcode, CaseSensitive);
                AL.Command := theOp;
                AL.AddArgs(args);
                HandleConstantExpressions(AL);
                if not fIgnoreLines then
                  CheckArgs(AL);
                HandlePseudoOpcodes(AL, theOp{, args});
                if fIgnoreLines then
                  AL.Command := OPS_INVALID;
              end
              else if (lineType = altCodeDepends) then
              begin
                if not fIgnoreLines then
                  fCurrentClump.AddClumpDependencies(opcode, args);
              end;
            end;
            masCodeSegment : begin
              // 1. start of clump/sub
              // 2. start of datasegment
              if lineType = altBeginDS then
                fMainStateCurrent := masDataSegment
              else
              begin
                if lineType = altBeginSub then
                  fMainStateCurrent := masClumpSub
                else
                  fMainStateCurrent := masClump;
                // starting a clump so define one
                fClumpUsesWait := False;
                fClumpUsesSign := False;
                fClumpUsesShift := False;
                fIgnoreLines    := False;
                fVarI := 0;  // each clump starts with I and J reset to 0.
                fVarJ := 0;
                fCurrentClump := CodeSpace.Add;
                fCurrentClump.Name := args;
                fClumpName := fCurrentClump.Name;
                fCurrentClump.IsSubroutine := fMainStateCurrent = masClumpSub;
                fCurrentClump.Filename := GetCurrentFile(true);
                if fCurrentClump.IsSubroutine then
                begin
                  // subroutines each have their own unsigned byte variable in
                  // the dataspace to store the return address
                  DE := Dataspace.Add;
                  DE.DataType := SubroutineReturnAddressType;
                  DE.Identifier := Format('__%s_return', [fCurrentClump.Name]);
                  DE.IncRefCount;
                end;
              end;
            end;
            masStruct, masStructDSClump, masStructDSClumpSub : begin
              // we are inside a structure definition
              // the only valid line type are:
              // 1. end of structure definition
              // 2. variable declaration
              if lineType = altEndStruct then
              begin
                if fMainStateCurrent = masStructDSClump then
                  fMainStateCurrent := masDSClump
                else if fMainStateCurrent = masStructDSClumpSub then
                  fMainStateCurrent := masDSClumpSub
                else
                  fMainStateCurrent := masDataSegment
              end
              else if lineType = altVarDecl then
              begin
                // add a member to the current structure definition
                DE := fCurrentStruct.SubEntries.Add;
                HandleVarDecl(DataDefinitions, fNamedTypes, CaseSensitive, DE, lbl, opcode, @StrToType);
                // the args value is an initializer
                DE.AddValuesFromString(Calc, args);
              end;
            end;
            masDatasegment, masDSClump, masDSClumpSub : begin
              // 1. end of datasegment
              // 2. variable declaration
              // 3. type declaration
              // 4. start of struct definition
              if lineType = altEndDS then
              begin
                if fMainStateCurrent = masDataSegment then
                  fMainStateCurrent := masCodeSegment
                else if fMainStateCurrent = masDSClumpSub then
                  fMainStateCurrent := masClumpSub
                else
                  fMainStateCurrent := masClump;
              end
              else if lineType = altVarDecl then
              begin
                // add a variable declaration to the dataspace
                DE := Dataspace.Add;
                HandleVarDecl(DataDefinitions, fNamedTypes, CaseSensitive, DE, lbl, opcode, @StrToType);
                // the args value is an initializer
                if args <> '' then
                  args := StripExtraQuotes(args);
                DE.AddValuesFromString(Calc, args);
              end
              else if lineType = altTypeDecl then
              begin
                // add a named type alias
                if fNamedTypes.IndexOf(lbl) = -1 then
                  fNamedTypes.AddEntry(lbl, args)
                else
                  raise Exception.CreateFmt(sDuplicateType, [lbl]);
              end
              else if lineType = altBeginStruct then
              begin
                if fMainStateCurrent = masDataSegment then
                  fMainStateCurrent := masStruct
                else
                if fMainStateCurrent = masDSClumpSub then
                  fMainStateCurrent := masStructDSClumpSub
                else
                  fMainStateCurrent := masStructDSClump;
                // add a named type alias
                if fNamedTypes.IndexOf(lbl) = -1 then
                  fNamedTypes.AddEntry(lbl, lbl)
                else
                  raise Exception.CreateFmt(sDuplicateType, [lbl]);
                // create a new structure definition
                fCurrentStruct := DataDefinitions.Add;
                fCurrentStruct.Identifier := lbl;
              end;
            end;
          end;
        end
        else
        begin
          if not fIgnoreLines then
          begin
            // tell the user what type of line was found and
            // what the current state is
            if lineType = altInvalid then
              errMsg := sInvalidStatement
            else
              errMsg := Format(sInvalidLine, [LineTypeToStr(lineType), ASMStateToStr(fMainStateCurrent)]);
            ReportProblem(LineCounter, GetCurrentFile(true), line, errMsg, true);
          end;
        end;
      end;
      // now handle the fact that we may have stated a block comment on this line
      if inBlockComment then
      begin
        fMainStateLast := fMainStateCurrent;
        fMainStateCurrent := masBlockComment;
      end;
    end;
  except
    on E : Exception do
    begin
      ReportProblem(LineCounter, GetCurrentFile(true), line, E.Message, true);
    end;
  end;
end;

procedure TRXEProgram.ReportProblem(const lineNo: integer; const fName, line,
  msg: string; err : boolean);
var
  tmp, tmp1, tmp2, tmp3, tmp4 : string;
  stop : boolean;
begin
  // exit without doing anything if this is not an error and warnings are off
  if WarningsOff and not err then
    Exit;
  if lineNo = -1 then
  begin
    tmp := msg;
    fMsgs.Add(tmp);
  end
  else
  begin
    if err then
      tmp1 := Format('# Error: %s', [msg])
    else
      tmp1 := Format('# Warning: %s', [msg]);
    fMsgs.Add(tmp1);
    tmp2 := Format('File "%s" ; line %d', [fName, lineNo]);
    fMsgs.Add(tmp2);
    tmp3 := Format('#   %s', [line]);
    fMsgs.Add(tmp3);
    tmp4 := '#----------------------------------------------------------';
    fMsgs.Add(tmp4);
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

function ExpectedArgType(const firmVer : word; const op : TOpCode; const argIdx: integer): TAsmArgType;
begin
  case op of
    OP_ADD, OP_SUB, OP_NEG, OP_MUL, OP_DIV, OP_MOD,
    OP_AND, OP_OR, OP_XOR, OP_NOT,
    OP_CMNT, OP_LSL, OP_LSR, OP_ASL, OP_ASR, OP_ROTL, OP_ROTR,
    OP_MOV,
    OPS_ACOS, OPS_ASIN, OPS_ATAN, OPS_CEIL,
    OPS_EXP, OPS_FABS, OPS_FLOOR, OPS_SQRT, OPS_TAN, OPS_TANH,
    OPS_COS, OPS_COSH, OPS_LOG, OPS_LOG10, OPS_SIN, OPS_SINH,
    OPS_ATAN2, OPS_FMOD, OPS_POW,
    OPS_ACOS_2, OPS_ASIN_2, OPS_ATAN_2, OPS_CEIL_2,
    OPS_EXP_2, OPS_FLOOR_2, OPS_TAN_2, OPS_TANH_2,
    OPS_COS_2, OPS_COSH_2, OPS_LOG_2, OPS_LOG10_2, OPS_SIN_2, OPS_SINH_2,
    OPS_TRUNC_2, OPS_FRAC_2, OPS_ATAN2_2, OPS_POW_2, OPS_MULDIV_2,
    OPS_ACOSD_2, OPS_ASIND_2, OPS_ATAND_2, OPS_COSD_2, OPS_COSHD_2,
    OPS_TAND_2, OPS_TANHD_2, OPS_SIND_2, OPS_SINHD_2, OPS_ATAN2D_2 :
    begin
      if argIdx > 0 then
        Result := aatVariable
      else
        Result := aatVarNoConst;
    end;
    OP_ARRBUILD : begin
      if argIdx > 0 then
        Result := aatVariable
      else
        Result := aatArray;
    end;
    OP_FLATTEN :
    begin
      if argIdx > 0 then
        Result := aatVariable
      else // 0
        Result := aatStringNoConst;
    end;
    OP_STRCAT :
    begin
      if argIdx > 0 then
        Result := aatString
      else
        Result := aatStringNoConst;
    end;
    OP_NUMTOSTRING :
    begin
      if argIdx > 0 then
        Result := aatScalar
      else // 0
        Result := aatStringNoConst;
    end;
    OP_ARRSIZE : begin
      if argIdx = 1 then
        Result := aatArray
      else // 0
        Result := aatScalarNoConst;
    end;
    OP_UNFLATTEN : begin
      if argIdx > 2 then
        Result := aatVariable
      else if argIdx = 2 then
        Result := aatString
      else if argIdx = 1 then
        Result := aatScalarNoConst
      else // 0
        Result := aatVarNoConst;
    end;
    OP_INDEX : begin
      if argIdx > 2 then
        Result := aatVariable
      else if argIdx = 2 then
        Result := aatScalarOrNull
      else if argIdx = 1 then
        Result := aatArray
      else // 0
        Result := aatVarNoConst;
    end;
    OP_REPLACE : begin
      if argIdx = 2 then
        Result := aatScalarOrNull
      else if argIdx > 2 then
        Result := aatVariable
      else // 0 or 1
        Result := aatArray;
    end;
    OP_CMP, OP_TST, OP_CMPSET, OP_TSTSET : begin
      if argIdx = 0 then
        Result := aatConstant
      else if argIdx > 1 then
        Result := aatVariable
      else
        Result := aatVarNoConst;
    end;
    OP_STRTOBYTEARR : begin
      if argIdx = 0 then
        Result := aatArray
      else // 1
        Result := aatString;
    end;
    OP_BYTEARRTOSTR : begin
      if argIdx = 1 then
        Result := aatArray
      else // 0
        Result := aatStringNoConst;
    end;
    OP_ACQUIRE, OP_RELEASE : begin
      Result := aatMutex;
    end;
    OP_SUBRET : begin
      Result := aatScalarNoConst;
    end;
    OP_GETTICK : begin
      Result := aatScalarNoConst;
    end;
    OP_STOP : begin
      Result := aatScalarorNull;
    end;
    OP_ARRSUBSET : begin
      if argIdx >= 2 then
        Result := aatScalarOrNull
      else
        Result := aatArray;
    end;
    OPS_ARROP, OPS_ARROP_2 : begin
      if argIdx = 0 then
        Result := aatConstant
      else if argIdx = 1 then
        Result := aatVarNoConst
      else if argIdx >= 3 then
        Result := aatScalarOrNull
      else
        Result := aatArray;
    end;
    OP_STRSUBSET : begin
      if argIdx >= 2 then
        Result := aatScalarOrNull
      else if argIdx = 1 then
        Result := aatString
      else // 0
        Result := aatStringNoConst;
    end;
    OP_SET : begin
      if argIdx > 0 then
        Result := aatConstant
      else
        Result := aatScalarNoConst;
    end;
    OP_SUBCALL : begin
      if argIdx = 0 then
        Result := aatClumpID
      else
        Result := aatScalarNoConst;
    end;
    OP_FINCLUMP : begin
      Result := aatConstant;
    end;
    OP_FINCLUMPIMMED : begin
      Result := aatClumpID;
    end;
    OP_JMP : begin
      Result := aatLabelID;
    end;
    OP_BRCMP, OP_BRTST : begin
      if argIdx = 0 then
        Result := aatConstant
      else if argIdx = 1 then
        Result := aatLabelID
      else
        Result := aatVariable;
    end;
    OP_SYSCALL : begin
      if argIdx = 0 then
        Result := aatConstant
      else
        Result := aatCluster;
    end;
    OP_SETIN, OP_GETIN : begin
      if argIdx = 2 then
        Result := aatConstant
      else if (op = OP_GETIN) and (argIdx = 0) then
        Result := aatScalarNoConst
      else
        Result := aatScalar;
    end;
    OP_SETOUT : begin
      if argIdx = 0 then
        Result := aatVariable // could be a scalar or an array
      else if (argIdx mod 2) = 1 then
        Result := aatConstant
      else // argIdx > 0 and even
        Result := aatScalar;
    end;
    OP_GETOUT : begin
      if argIdx = 2 then
        Result := aatConstant
      else if argIdx = 1 then
        Result := aatScalar
      else
        Result := aatScalarNoConst;
    end;
    OP_ARRINIT : begin
      if argIdx = 2 then
        Result := aatScalarOrNull
      else if argIdx = 1 then
        Result := aatVariable
      else // arg 0
        Result := aatArray;
    end;
    OP_STRINGTONUM : begin
      if argIdx >= 3 then
        Result := aatScalarOrNull
      else if argIdx = 2 then
        Result := aatString
      else // 0 or 1
        Result := aatScalarNoConst;
    end;
    OP_WAIT : begin
      if firmVer > MAX_FW_VER1X then
      begin
        Result := aatScalarOrNull;
      end
      else
        Result := aatConstant;
    end;
    OPS_WAITV{, OP_SQRT_2} : begin
      if firmVer > MAX_FW_VER1X then
      begin
        // OPS_WAITV == OP_SQRT_2 in 2.x firmware
        if argIdx > 0 then
          Result := aatVariable
        else
          Result := aatVarNoConst;
      end
      else
        Result := aatScalar;
    end;
    OPS_WAITV_2 : begin
      Result := aatScalar;
    end;
    OPS_CALL : begin
      Result := aatClumpID;
    end;
    OPS_ABS{, OP_ABS_2}, OPS_SIGN, OPS_SIGN_2 : begin
      if argIdx = 1 then
        Result := aatScalar
      else // 0
        Result := aatScalarNoConst;
    end;
    OPS_SHL, OPS_SHR : begin
      if argIdx >= 1 then
        Result := aatScalar
      else // 0
        Result := aatScalarNoConst;
    end;
    OPS_STRINDEX : begin
      if argIdx > 2 then
        Result := aatVariable
      else if argIdx = 2 then
        Result := aatScalarOrNull
      else if argIdx = 1 then
        Result := aatString
      else // 0
        Result := aatVarNoConst;
    end;
    OPS_STRREPLACE : begin
      if argIdx = 2 then
        Result := aatScalarOrNull
      else if argIdx > 2 then
        Result := aatVariable
      else // 0 or 1
        Result := aatString;
    end;
    OPS_STRLEN : begin
      if argIdx = 1 then
        Result := aatString
      else // 0
        Result := aatScalarNoConst;
    end;
    OPS_COMPCHK, OPS_COMPIF : begin
      Result := aatConstant;
    end;
    OPS_COMPCHKTYPE : begin
      if argIdx = 0 then
        Result := aatVariable
      else
        Result := aatTypeName;
    end;
    OPS_START, OPS_START_2 : begin
      Result := aatClumpID;
    end;
    OPS_STOPCLUMP, OPS_STOPCLUMP_2 : begin
      Result := aatClumpID;
    end;
    OPS_PRIORITY, OPS_PRIORITY_2 : begin
      if argIdx = 0 then
        Result := aatClumpID
      else
        Result := aatConstant;
    end;
    OPS_FMTNUM, OPS_FMTNUM_2 : begin
      if argIdx > 1 then
        Result := aatScalar
      else if argIdx = 1 then
        Result := aatString
      else // 0
        Result := aatStringNoConst;
    end;
  else
    Result := aatConstant;
  end;
end;

procedure TRXEProgram.HandleConstantExpressions(AL: TAsmLine);
var
  expected : TAsmArgType;
  i, j, delta : integer;
//  n : integer;
  arg : TAsmArgument;
  val : Extended;
  iVal : Int64;
  tmpName, tmpValue : string;
  DE, Sub : TDataspaceEntry;
  bValidCC : boolean;
//  newLine : TAsmLine;
  tmpType : TDSType;
begin
  // if this line requires a reference to a temporary scalar variable
  // then define a constant variable reference and use it whereever this value
  // needs to be used
  // The new asm line calls the "set" opcode setting the temporary variable
  // to the constant value.

  // check all the arguments for this line to see if their argument type
  // matches the expected argument type.  If it does then do nothing.
  // if it doesn't and the expected type allows for a temporary then create one
  // and adjust the argument appropriately.
//  n := 0;
  ProcessSpecialFunctions(AL);
  if AL.Command in [OP_CMP, OP_TST, OP_CMPSET, OP_TSTSET, OP_BRCMP, OP_BRTST] then
  begin
    if AL.Args.Count > 0 then
    begin
      FixupComparisonCodes(AL.Args[0]);
      arg := AL.Args[0];
      bValidCC := False;
      Calc.SilentExpression := arg.Value;
      if not Calc.ParserError then
      begin
        iVal := Trunc(Calc.Value);
        bValidCC := ValidCompareCode(Byte(iVal));
        if bValidCC then
          arg.Value := IntToStr(iVal);
      end;
      if Calc.ParserError or not bValidCC then
      begin
        ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
          Format(sInvalidCompareCode, [arg.Value]), true);
        arg.Value := '-1'; // set to a valid numeric string constant
      end;
    end;
    // skip the comparison argument
    delta := 1;
  end
  else
    delta := 0;
  for i := delta to AL.Args.Count - 1 do
  begin
    expected := ExpectedArgType(FirmwareVersion, AL.Command, i);
    arg := AL.Args[i];
    if expected in
       [aatVariable, aatVarOrNull, aatArray, aatString, aatScalar, aatScalarOrNull] then
    begin
      // look at the argument and see if it is of the variable type
      // if not then create temporary.
      j := Dataspace.IndexOfName(arg.Value);
      if j = -1 then
      begin
        // the current argument is not a known variable and it is supposed to be one
        // argument could also be a constant expression which needs to be evaluated.
        // but first we need to rule out the possibility that the argument is a
        // IO Map address macro
        j := IndexOfIOMapName(arg.Value);
        if j = -1 then
        begin
          // is it a string?
          if (arg.IsQuoted('''') or arg.IsQuoted('"')) and
             not (expected in [aatScalar, aatScalarOrNull]) then
          begin
            // maintain a map between string constants and variable names
            tmpValue := StripQuotes(arg.Value);
            j := fConstStrMap.IndexOf(tmpValue);
            if j = -1 then
            begin
              tmpName := Format('__constStr%4.4d', [fConstStrMap.Count]);
              fConstStrMap.AddEntry(tmpValue, tmpName);
              DE := DataSpace.Add;
              // this is an array type
              DE.Identifier := tmpName;
              DE.DataType := dsArray;
              Sub := DE.SubEntries.Add;
              Sub.Identifier := DE.Identifier + '_type';
              Sub.DataType := dsUByte;
              // the args value is an initializer
              DE.AddValuesFromString(Calc, arg.Value);
            end
            else
              tmpName := fConstStrMap.MapValue[j];
            // we have a temporary called 'tmpName' in the dataspace
            // so switch our line to use it instead
            arg.Value := tmpName;
          end
          else if (IsDelimiter('{', arg.Value, 1) and
                   IsDelimiter('}', arg.Value, Length(arg.Value))) and
             not (expected in [aatScalar, aatScalarOrNull]) then
          begin
            // maintain a map between constants and variable names
            tmpValue := StripQuotes(arg.Value); // removes '{' and '}'
            j := fConstStrMap.IndexOf(tmpValue);
            if j = -1 then
            begin
              tmpName := Format('__constStr%4.4d', [fConstStrMap.Count]);
              fConstStrMap.AddEntry(tmpValue, tmpName);
              DE := DataSpace.Add;
              // this is an array type
              DE.Identifier := tmpName;
              DE.DataType := dsArray;
              Sub := DE.SubEntries.Add;
              Sub.Identifier := DE.Identifier + '_type';
              // constant array type defaults to signed long
              Sub.DataType := dsSLong;
              // the args value is an initializer
              tmpType := DE.AddValuesFromString(Calc, arg.Value);
              Sub.DataType := tmpType;
            end
            else
              tmpName := fConstStrMap.MapValue[j];
            // we have a temporary called 'tmpName' in the dataspace
            // so switch our line to use it instead
            arg.Value := tmpName;
          end
          else
          begin
            // now we can assume the arg is supposed to be a constant expression
            val := arg.Evaluate(Calc);
            iVal := Trunc(val);
            // one more check with respect to IOMap Addresses.
            j := IndexOfIOMapID(Integer(iVal));
            if ((expected in [aatVarOrNull, aatScalarOrNull]) and
                (iVal = NOT_AN_ELEMENT)) or (j <> -1) then
            begin
              // we have an IO Map address as a constant expression
              arg.Value := IntToStr(iVal);
            end
            else
            begin
              // definitely not an IO Map Address
              // what type should this temporary be?
              tmpName := CreateConstantVar(DataSpace, val, False,
                GetTypeHint(DataSpace, AL, i, EnhancedFirmware));
              // we have a temporary called 'tmpName' in the dataspace
              // so switch our line to use it instead
              arg.Value := tmpName;
            end;
          end;
        end;
      end;
    end
    else if expected = aatConstant then
    begin
      Calc.SilentExpression := arg.Value;
      if Calc.ParserError then
      begin
        if not fIgnoreLines then
          ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
            Format(sBadConstExpression, [arg.Value]), true);
        arg.Value := '-1'; // set to a valid numeric string
      end
      else
        arg.Value := NBCFloatToStr(Calc.Value);
//        arg.Value := IntToStr(Trunc(Calc.Value));
    end;
  end;
end;

function GetArgDataType(val : Extended): TDSType;
var
  iVal : Int64;
begin
  iVal := Trunc(val);
  if iVal = val then
  begin
    val := iVal;
    // see if this works.  if not then figure out the
    // type based on the size of the value
    if (val >= Low(ShortInt)) and (val <= High(ShortInt)) then
      Result := dsSByte
    else if (val >= Low(SmallInt)) and (val <= High(SmallInt)) then
      Result := dsSWord
    else if (val >= Low(Integer)) and (val <= High(Integer)) then
      Result := dsSLong
    else if (val > High(Cardinal)) or (val < Low(Integer)) then
      Result := dsFloat
    else
      Result := dsULong;
  end
  else
    Result := dsFloat;
//  else if ((val >= 0) and (val <= High(Byte)) then
//    Result := dsUByte
//  else if ((val >= 0) and (val <= High(Word)) then
//    Result := dsUWord
end;

procedure TRXEProgram.UpdateHeader;
begin
  fHeader.DSCount             := fDSData.DSCount;
  fHeader.DSStaticSize        := fDSData.DSStaticSize;
  fHeader.DynDSDefaultsOffset := fDSData.DynDSDefaultsOffset;
  fHeader.DynDSDefaultsSize   := fDSData.DynDSDefaultsSize;
  fHeader.DVArrayOffset       := fDSData.DVArrayOffset;
  fHeader.ClumpCount          := Word(Codespace.Count);
  fHeader.CodespaceCount      := fCode.CodespaceCount;
  fHeader.MemMgrHead          := fDSData.Head;
  fHeader.MemMgrTail          := fDSData.Tail;
  fHeader.DSDefaultsSize      := Word(fHeader.DynDSDefaultsOffset + fHeader.DynDSDefaultsSize);
  fHeader.DSSize              := Word(fHeader.DSStaticSize + fHeader.DynDSDefaultsSize);
end;

procedure TRXEProgram.CheckArgs(AL: TAsmLine);
var
  arg : string;
  NI : NXTInstruction;
  i : integer;
  val : integer;
  argType : TAsmArgType;
  de, de2 : TDataspaceEntry;
begin
  if AL.Command <> OPS_INVALID then
  begin
    i := IndexOfOpcode(AL.Command);
    if i = -1 then
    begin
      ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
        Format(sInvalidOpcode, [OpcodeToStr(Al.Command)]), true);
    end
    else
    begin
      NI := GetNXTInstruction(i);
      case AL.Command of
        OP_CMP, OP_TST, OP_CMPSET, OP_TSTSET, OP_BRCMP, OP_BRTST : begin
          if AL.Args.Count <> NI.Arity+1 then
            ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
              Format(sInvalidNumArgs, [NI.Arity+1, AL.Args.Count]), true);
        end;
        OP_FINCLUMP : begin
          // can have 2 or zero arguments
          if (AL.Args.Count <> NI.Arity) and (AL.Args.Count <> 0) then
            ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
              Format(sInvalidNumArgs, [NI.Arity, AL.Args.Count]), true);
        end;
        OP_ARRBUILD, OP_STRCAT : begin
          // must have at least 2 arguments
          if (AL.Args.Count < 2) then
            ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
              Format(sInvalidNumArgsVar, [2, AL.Args.Count]), true);
        end;
        OP_SETOUT : begin
          // must have at least 3 arguments
          if (AL.Args.Count < 3) then
            ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
              Format(sInvalidNumArgsVar, [3, AL.Args.Count]), true)
          else if (AL.Args.Count mod 2) = 0 then
          begin
            // total number of args must be odd
            ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
              sInvalidNumArgsOdd, true);
          end;
        end;
        OP_DIV : begin
          // if second argument is signed and third is unsigned then
          // bad things might happen
          if AL.Args.Count = NI.Arity then
          begin
            de  := Dataspace.FindEntryByFullName(AL.Args[1].Value);
            de2 := Dataspace.FindEntryByFullName(AL.Args[2].Value);
            if Assigned(de) and Assigned(de2) then
            begin
              if (de.DataType in [dsSByte, dsSWord, dsSLong]) and
                 (de2.DataType in [dsUByte, dsUWord, dsULong]) then
                ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
                  sUnsafeDivision, false);
            end
            else
            begin
              if not Assigned(de) then
                ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, Format(sInvalidVarArg, [AL.Args[1].Value]), true)
              else
                ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, Format(sInvalidVarArg, [AL.Args[2].Value]), true);
            end;

          end;
        end;
        OP_SET : begin
          // must have 2 arguments
          if AL.Args.Count <> NI.Arity then
            ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
              Format(sInvalidNumArgs, [NI.Arity, AL.Args.Count]), true);
          // the first argument must not be anything other than an integer datatype
          de := Dataspace.FindEntryByFullName(AL.Args[0].Value);
          if Assigned(de) then
          begin
            if de.DataType = dsFloat then
              ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, sInvalidSetStatement, true);
          end
          else
            ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, Format(sInvalidVarArg, [AL.Args[0].Value]), true);
          // second argument must be a constant within the range of UWORD
          // or SWORD
          arg := AL.Args[1].Value; // should be a number
          Calc.SilentExpression := arg;
          if Calc.ParserError then
            ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
              Format(sBadConstExpression, [arg]), true)
          else
          begin
            // make sure it is in range
            val := Integer(Trunc(Calc.Value));
            if (val < Low(SmallInt)) or (val > High(Word)) then
              ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
                Format(sConstOutOfRange, [val, Low(SmallInt), High(Word)]), true)
          end;
        end;
      else // case
        if (NI.Arity < 6) and (AL.Args.Count <> NI.Arity) then
          ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
            Format(sInvalidNumArgs, [NI.Arity, AL.Args.Count]), true);
      end;
      for i := 0 to AL.Args.Count - 1 do begin
        arg := AL.Args[i].Value;
        argType := ExpectedArgType(FirmwareVersion, Al.Command, i);
        case argType of
          aatVariable, aatVarNoConst, aatVarOrNull,
          aatScalar, aatScalarNoConst, aatScalarOrNull :
          begin
            // arg must be in list of known variables
            de := Dataspace.FindEntryAndAddReference(arg);
            if (de = nil) and (IndexOfIOMapName(arg) = -1) then
            begin
              Calc.SilentExpression := arg;
              val := Integer(Trunc(Calc.Value));
              if IndexOfIOMapID(val) = -1 then
              begin
                if (not (argType in [aatVarOrNull, aatScalarOrNull])) or
                   ((val <> NOT_AN_ELEMENT) and (val <> -1)) then
                  ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
                    Format(sInvalidVarArg, [arg]), true);
              end;
            end
            else if Assigned(de) and
              (argType in [aatScalar, aatScalarNoConst, aatScalarOrNull]) then
            begin
              // a known variable name but is it a scalar
              if de.DataType in [dsVoid, dsArray, dsCluster, dsMutex] then
                ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
                  Format(sInvalidScalarArg, [arg]), true);
            end;
          end;
          aatArray : begin
            de := Dataspace.FindEntryAndAddReference(arg);
            if (de = nil) or (de.DataType <> dsArray) then
              ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
                Format(sInvalidArrayArg, [arg]), true);
          end;
          aatString, aatStringNoConst :
          begin
            // arg must be in list of known variables
            de := Dataspace.FindEntryAndAddReference(arg);
            if (de = nil) or (de.DataType <> dsArray) or
               not (de.SubEntries[0].DataType in [dsUByte, dsSByte]) then
              ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
                Format(sInvalidStringArg, [arg]), true);
          end;
          aatConstant : begin
            // if it is a constant then I should be able to evaluate it
            Calc.SilentExpression := arg;
            if Calc.ParserError then
              ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
                Format(sBadConstExpression, [arg]), true);
          end;
          aatLabelID : begin
            // Labels are checked elsewhere (ValidateLabels)
          end;
          aatClumpID : begin
            // can't check clumpIDs yet since it could be not yet defined
            // but we can at least require them to be valid identifiers
            if not IsValidIdent(arg) then
              ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
                Format(sInvalidClumpArg, [arg]), true);
          end;
          aatCluster : begin
            de := Dataspace.FindEntryAndAddReference(arg);
            if (de = nil) or (de.DataType <> dsCluster) then
              ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
                Format(sInvalidClusterArg, [arg]), true);
          end;
          aatMutex : begin
            de := Dataspace.FindEntryAndAddReference(arg);
            // we want to keep a list of all the threads that reference a
            // mutex in order to help us correctly optimize them later on.
            if Assigned(de) and (de.DataType = dsMutex) then
            begin
              de.AddThread(fClumpName);
            end
            else
//            if (de = nil) or (de.DataType <> dsMutex) then
              ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
                Format(sInvalidMutexArg, [arg]), true);
          end;
        end;
      end;
    end;
  end;
end;

procedure TRXEProgram.HandleNameToDSID(const aName: string; var aId: integer);
begin
  aId := Dataspace.DataspaceIndex(aName);
end;

procedure TRXEProgram.CreateObjects;
begin
  fCalc := TNBCExpParser.Create(nil);
  fCalc.CaseSensitive := fCaseSensitive;
  fCalc.OnParserError := HandleCalcParserError;
  fCalc.StandardDefines := fStandardDefines;
  fCalc.ExtraDefines := fExtraDefines;

  fDD := TDataDefs.Create;
  fDS := TDataspace.Create;
  fDS.CaseSensitive := fCaseSensitive;

  fCS := TCodeSpace.Create(self, fDS);
  fCS.CaseSensitive := fCaseSensitive;
  fCS.OnNameToDSID := HandleNameToDSID;

  fDSData := TDSData.Create;
  fClumpData := TClumpData.Create;
  fCode := TCodeSpaceAry.Create;

  fNamedTypes := TMapList.Create;
  fNamedTypes.CaseSensitive := fCaseSensitive;
  fNamedTypes.Duplicates := dupError;

  fConstStrMap := TMapList.Create;

  fMsgs := TStringList.Create;
  fCS.Calc := fCalc;

  fIncDirs := TStringList.Create;

  fCompilerOutput := TStringList.Create;

  fSymbolTable := TStringList.Create;

  fDefines := TStringList.Create;

  fSpawnedThreads := TStringList.Create;
  TStringList(fSpawnedThreads).CaseSensitive := True;
  TStringList(fSpawnedThreads).Duplicates := dupIgnore;

  fSpecialFunctions := TObjectList.Create;
  LoadSpecialFunctions;

  fVarI := 0;
  fVarJ := 0;
  fOptimizeLevel := 0;
end;

procedure TRXEProgram.FreeObjects;
begin
  fConstStrMap.Clear;
  fNamedTypes.Clear;
  FreeAndNil(fDD);
  FreeAndNil(fDS);
  FreeAndNil(fCS);
  FreeAndNil(fNamedTypes);
  FreeAndNil(fConstStrMap);
  FreeAndNil(fDSData);
  FreeAndNil(fClumpData);
  FreeAndNil(fCode);
  FreeAndNil(fMsgs);
  FreeAndNil(fCalc);
  FreeAndNil(fIncDirs);
  FreeAndNil(fCompilerOutput);
  FreeAndNil(fSymbolTable);
  FreeAndNil(fDefines);
  FreeAndNil(fSpawnedThreads);
  FreeAndNil(fSpecialFunctions);
end;

procedure TRXEProgram.Clear;
begin
  FreeObjects;
  CreateObjects;
  InitializeHeader;
end;

procedure TRXEProgram.InitializeHeader;
begin
  fHeader.FormatString        := 'MindstormsNXT';
  fHeader.Version             := CompilerVersion;
  fHeader.DSCount             := 0;
  fHeader.DSSize              := 0;
  fHeader.DSStaticSize        := 0;
  fHeader.DSDefaultsSize      := 0;
  fHeader.DynDSDefaultsOffset := 0;
  fHeader.DynDSDefaultsSize   := 0;
  fHeader.MemMgrHead          := 0;
  fHeader.MemMgrTail          := 0;
  fHeader.ClumpCount          := 0;
  fHeader.CodespaceCount      := 0;
end;

procedure TRXEProgram.HandleCalcParserError(Sender: TObject; E: Exception);
begin
  if Assigned(Sender) and not fIgnoreLines then
    ReportProblem(LineCounter, GetCurrentFile(true), '', E.Message, True);
end;

procedure TRXEProgram.SetCaseSensitive(const Value: boolean);
begin
  fCaseSensitive := Value;
  fCalc.CaseSensitive := Value;
  fNamedTypes.CaseSensitive := Value;
  fDS.CaseSensitive := fCaseSensitive;
  fCS.CaseSensitive := fCaseSensitive;
end;

procedure TRXEProgram.SetStandardDefines(const Value: boolean);
begin
  fCalc.StandardDefines := Value;
  fStandardDefines := Value;
end;

procedure TRXEProgram.SetExtraDefines(const Value: boolean);
begin
  fCalc.ExtraDefines := Value;
  fExtraDefines := Value;
end;

procedure TRXEProgram.SetCompVersion(const Value: byte);
begin
  fCompVersion := Value;
  fHeader.Version := Value;
end;

procedure TRXEProgram.ValidateLabels(aClump: TClump);
var
  arg : string;
  i, j : integer;
  argType : TAsmArgType;
  AL : TAsmLine;
begin
  for j := 0 to aCLump.ClumpCode.Count - 1 do
  begin
    AL := aClump.ClumpCode[j];
    if AL.Command <> OPS_INVALID then
    begin
      for i := 0 to AL.Args.Count - 1 do
      begin
        arg := AL.Args[i].Value;
        argType := ExpectedArgType(FirmwareVersion, Al.Command, i);
        case argType of
          aatLabelID : begin
            // check labels
            if (aClump.IndexOfLabel(arg) = -1) or not IsValidIdent(arg) then
              ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
                Format(sInvalidLabelArg, [arg]), true);
          end;
        end;
      end;
    end;
  end;
end;

procedure TRXEProgram.SetIncDirs(const Value: TStrings);
begin
  fIncDirs.Assign(Value);
end;

function TRXEProgram.GetSymbolTable: TStrings;
begin
  Result := fSymbolTable;
  Result.Clear;
  Result.BeginUpdate;
  try
    fDSData.SaveToSymbolTable(Result);
    Codespace.SaveToSymbolTable(Result);
  finally
    Result.EndUpdate;
  end;
end;

procedure TRXEProgram.CreateWaitClump(const basename: string);
var
  C : TClump;
  AL : TAsmLine;
begin
  C := CodeSpace.Add;
  C.Name := Format('__%s_wait', [basename]);
  C.Filename := GetCurrentFile(true);
  AL := C.ClumpCode.Add;
  AL.Command := OP_GETTICK;
  AL.AddArgs(Format('%s_now', [C.Name]));
  AL := C.ClumpCode.Add;
  AL.Command := OP_ADD;
  AL.AddArgs(Format('%0:s_then, %0:s_now, %0:s_ms', [C.Name]));
  AL := C.ClumpCode.Add;
  AL.LineLabel := Format('%sing', [C.Name]);
  C.AddLabel(AL.LineLabel, AL);
  AL.Command := OP_GETTICK;
  AL.AddArgs(Format('%s_now', [C.Name]));
  AL := C.ClumpCode.Add;
  AL.Command := OP_BRCMP;
  AL.AddArgs(Format('LT, %0:sing, %0:s_now, %0:s_then', [C.Name]));
  AL := C.ClumpCode.Add;
  AL.Command := OP_SUBRET;
  AL.AddArgs(Format('%s_return', [C.Name]));
end;

procedure TRXEProgram.CreateSpawnerClump(const basename: string);
var
  C : TClump;
  AL : TAsmLine;
begin
  C := CodeSpace.Add;
  C.Name := Format('__%s_Spawner', [basename]);
  C.Filename := GetCurrentFile(true);
  C.AddClumpDependencies('precedes', Format('%0:s, __%0:s_Returner', [basename]));
  // exit
  AL := C.ClumpCode.Add;
  AL.Command := OP_FINCLUMP;
end;

procedure TRXEProgram.CreateReturnerClump(const basename: string);
var
  C : TClump;
  AL : TAsmLine;
begin
  C := CodeSpace.Add;
  C.Name := Format('__%s_Returner', [basename]);
  C.Filename := GetCurrentFile(true);
  // subret __x_Spawner_return
  AL := C.ClumpCode.Add;
  AL.Command := OP_SUBRET;
  AL.AddArgs(Format('__%s_Spawner_return', [basename]));
end;

procedure TRXEProgram.DefineWaitArgs(const basename: string);
var
  DE : TDataspaceEntry;
  idstr : string;
begin
  idstr := Format('__%s_wait_', [basename]);
  DE := Dataspace.Add;
  DE.DataType := SubroutineReturnAddressType;
  DE.Identifier := idstr + 'return'; // refcount is 1+caller
  DE.IncRefCount;
  DE := Dataspace.Add;
  DE.DataType := dsUWord;
  DE.Identifier := idstr + 'ms'; // refcount is 1+caller
  DE.IncRefCount;
  DE := Dataspace.Add;
  DE.DataType := dsULong;
  DE.Identifier := idstr + 'now'; // refcount is 3
  DE.IncRefCount;
  DE.IncRefCount;
  DE.IncRefCount;
  DE := Dataspace.Add;
  DE.DataType := dsULong;
  DE.Identifier := idstr + 'then'; // refcount is 2
  DE.IncRefCount;
  DE.IncRefCount;
end;

procedure TRXEProgram.HandlePseudoOpcodes(AL: TAsmLine; op: TOpCode{; const args: string});
var
  Arg : TAsmArgument;
  a1, a2, a3, a4, a5, c1, c2 : string;
  de1, de2, de3, de4, de5 : TDataspaceEntry;
  tmpLine, shiftConst : integer;
begin
  tmpLine := AL.LineNum;
  case op of
    OP_WAIT, OPS_WAITV, OPS_WAITI_2, OPS_WAITV_2 : begin
      // 2.x firmwares support wait and OPS_WAITV == OP_SQRT_2
      if (FirmwareVersion > MAX_FW_VER1X) then
      begin
        if op in [OP_WAIT, OP_SQRT_2{, OPS_WAITV}] then
          Exit;
        if not EnhancedFirmware then
        begin
          // opcode is either OPS_WAITI_2 or OPS_WAITV_2
          // convert it to OP_WAIT with 2 args
          if op = OPS_WAITI_2 then
          begin
            //AL == waiti 12345
            c1 := CreateConstantVar(DataSpace, StrToIntDef(AL.Args[0].Value, 0), True);
            Arg := AL.Args[0];
            Arg.Value := c1;
          end;
          Arg := AL.Args.Insert(0);
          Arg.Value := STR_NA;
          AL.Command := OP_WAIT;
        end;
      end
      else
      begin
        if not EnhancedFirmware then
        begin
          // convert OPS_WAITV
          // if this is a wait opcode we replace it with two lines of code
          if not fClumpUsesWait then
            DefineWaitArgs(fCurrentClump.Name);
          fClumpUsesWait := True;
          if op = OP_WAIT then
            AL.Command := OP_SET
          else
            AL.Command := OP_MOV;
          Arg := AL.Args.Insert(0);
          Arg.Value := Format('__%s_wait_ms', [fCurrentClump.Name]);
          Dataspace.FindEntryAndAddReference(Arg.Value); // inc refcount
          AL := fCurrentClump.ClumpCode.Add;
          AL.Command  := OP_SUBCALL;
          AL.LineNum  := tmpLine;
          Arg := AL.Args.Add;
          Arg.Value := Format('__%s_wait', [fCurrentClump.Name]);
          Arg := AL.Args.Add;
          Arg.Value := Format('__%0:s_wait_return', [fCurrentClump.Name]);
          Dataspace.FindEntryAndAddReference(Arg.Value); // inc refcount
        end;
      end;
    end;
    OPS_STRINDEX : begin
      // just replace opcode
      AL.Command := OP_INDEX;
    end;
    OPS_STRREPLACE : begin
      // just replace opcode
      AL.Command := OP_REPLACE;
    end;
    OPS_COMPCHK : begin
      AL.Command := OPS_INVALID; // make this line a no-op
      DoCompilerCheck(AL, False);
    end;
    OPS_COMPCHKTYPE : begin
      AL.Command := OPS_INVALID; // make this line a no-op
      DoCompilerCheckType(AL);
    end;
    OPS_COMPIF : begin
      AL.Command := OPS_INVALID; // make this line a no-op
      DoCompilerCheck(AL, True);
    end;
    OPS_COMPELSE : begin
      AL.Command := OPS_INVALID; // make this line a no-op
      fIgnoreLines := not fIgnoreLines;
    end;
    OPS_COMPEND : begin
      AL.Command := OPS_INVALID; // make this line a no-op
      fIgnoreLines := False;
    end;
    OPS_STRLEN : begin
      if AL.Args.Count = 2 then
      begin
        c1 := CreateConstantVar(DataSpace, 1, True);
        a1 := AL.Args[0].Value;
        de1 := Dataspace.FindEntryByFullName(a1);
        AL.Command := OP_ARRSIZE;
        // sub
        AL := fCurrentClump.ClumpCode.Add;
        AL.Command  := OP_SUB;
        AL.LineNum  := tmpLine;
        AL.AddArgs(Format('%0:s, %0:s, %s', [a1, c1]));
        if Assigned(de1) then
        begin
          de1.IncRefCount;
          de1.IncRefCount;
        end
        else
          ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, Format(sInvalidVarArg, [AL.Args[0].Value]), true);
      end;
    end;
    OPS_START, OPS_START_2 : begin
      if AL.Args.Count < 1 then
        ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, sInvalidStatement, true)
      else
      begin
        a1 := AL.Args[0].Value; // base thread name
        if not EnhancedFirmware then
        begin
          // replace start with subcall and automatic return address variable.
          AL.Command := OP_SUBCALL;
          AL.Args[0].Value := Format('__%s_Spawner', [a1]);
          Arg := AL.Args.Add;
          Arg.Value := Format('%s_return', [AL.Args[0].Value]);
          DefineVar(Arg.Value, SubroutineReturnAddressType);
          RegisterThreadForSpawning(a1);
        end;
        // need to mark clumps as multi-threaded
        CodeSpace.Multithread(fCurrentClump.Name);
        CodeSpace.Multithread(a1);
      end;
    end;
    OPS_STOPCLUMP, OPS_PRIORITY, OPS_FMTNUM,
    OPS_STOPCLUMP_2, OPS_PRIORITY_2, OPS_FMTNUM_2 : begin
      if not EnhancedFirmware then
      begin
        // replace with no-op if not running enhanced firmware and report error
        ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
          Format(sInvalidOpcode, [OpcodeToStr(Al.Command)]), true);
        AL.Command := OPS_INVALID;
      end;
    end;
    OPS_CALL : begin
      // subcall with automatic return address variable.
      AL.Command := OP_SUBCALL;
      Arg := AL.Args.Add;
      Arg.Value := Format('__%s_return', [AL.Args[0].Value]);
      Dataspace.FindEntryAndAddReference(Arg.Value); // inc refcount
    end;
    OPS_RETURN : begin
      // first make sure it only is present in a subroutine
      if not fCurrentClump.IsSubroutine then
        ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, sReturnNotInSub, true);
      // subret with automatic return address variable
      AL.Command := OP_SUBRET;
      Arg := AL.Args.Add;
      Arg.Value := Format('__%s_return', [fCurrentClump.Name]);
      Dataspace.FindEntryAndAddReference(Arg.Value); // inc refcount
    end;
    OPS_ABS{, OP_ABS_2} : begin
      // 2.x standard firmware supports ABS opcode
      if FirmwareVersion > MAX_FW_VER1X then
        Exit;
      if not EnhancedFirmware then
      begin
        if AL.Args.Count = 2 then
        begin
          a1  := AL.Args[0].Value;
          a2  := AL.Args[1].Value;
          de1 := Dataspace.FindEntryByFullName(a1);
          de2 := Dataspace.FindEntryByFullName(a2);
          AL.Command := OP_MOV;
          AL.Args.Clear;
          AL.AddArgs(Format('%s, %s', [a1, a2]));
          AL := fCurrentClump.ClumpCode.Add;
          AL.Command := OP_BRTST;
          AL.LineNum  := tmpLine;
          AL.AddArgs(Format('GTEQ, __abs_%d, %s', [fAbsCount, a2]));
          AL := fCurrentClump.ClumpCode.Add;
          AL.Command := OP_NEG;
          AL.LineNum  := tmpLine;
          AL.AddArgs(Format('%s, %s', [a1, a2]));
          AL := fCurrentClump.ClumpCode.Add;
          AL.Command := OPS_INVALID; // OPS_MOV;
          AL.LineNum  := tmpLine;
          AL.LineLabel := Format('__abs_%d', [fAbsCount]);
          fCurrentClump.AddLabel(AL.LineLabel, AL);
          inc(fAbsCount);
          if Assigned(de1) and Assigned(de2) then
          begin
            de1.IncRefCount;
            de2.IncRefCount;
            de2.IncRefCount;
          end
          else
          begin
            if not Assigned(de1) then
              ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, Format(sInvalidVarArg, [a1]), true)
            else
              ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, Format(sInvalidVarArg, [a2]), true);
          end;
        end
        else
          ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, sInvalidStatement, true);
      end;
    end;
    OPS_SIGN, OPS_SIGN_2 : begin
      if not EnhancedFirmware then
      begin
        if AL.Args.Count = 2 then
        begin
          a1  := AL.Args[0].Value;
          a2  := AL.Args[1].Value;
          de2 := Dataspace.FindEntryByFullName(a2);
          a3 := Format('__%s_sign_tmp', [fCurrentClump.Name]);
          if not fClumpUsesSign then
          begin
            with Dataspace.Add do begin
              DataType := dsSByte; // only needs to store -1, 0, or 1
              Identifier := a3;
            end;
          end;
          de3 := Dataspace.FindEntryByFullName(a3);
          fClumpUsesSign := True;
          AL.Command := OP_SET;
          AL.Args.Clear;
          AL.AddArgs(Format('%s, 0', [a3]));
          de3.IncRefCount;
          AL := fCurrentClump.ClumpCode.Add;
          AL.Command := OP_BRTST;
          AL.LineNum  := tmpLine;
          AL.AddArgs(Format('EQ, __sign_%d, %s', [fSignCount, a2]));
          AL := fCurrentClump.ClumpCode.Add;
          AL.Command := OP_SET;
          AL.LineNum  := tmpLine;
          AL.AddArgs(Format('%s, -1', [a3]));
          de3.IncRefCount;
          AL := fCurrentClump.ClumpCode.Add;
          AL.Command := OP_BRTST;
          AL.LineNum  := tmpLine;
          AL.AddArgs(Format('LT, __sign_%d, %s', [fSignCount, a2]));
          AL := fCurrentClump.ClumpCode.Add;
          AL.Command := OP_SET;
          AL.LineNum  := tmpLine;
          AL.AddArgs(Format('%s, 1', [a3]));
          de3.IncRefCount;
          AL := fCurrentClump.ClumpCode.Add;
          AL.Command := OP_MOV;
          AL.LineNum  := tmpLine;
          AL.LineLabel := Format('__sign_%d', [fSignCount]);
          AL.AddArgs(Format('%s, %s', [a1, a3]));
          de3.IncRefCount;
          fCurrentClump.AddLabel(AL.LineLabel, AL);
          inc(fSignCount);
          if Assigned(de2) then
            de2.IncRefCount
          else
            ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, Format(sInvalidVarArg, [a2]), true);
        end
        else
          ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, sInvalidStatement, true);
      end;
    end;
    OPS_SHL, OPS_SHR : begin
      if AL.Args.Count = 3 then
      begin
        a1 := AL.Args[0].Value;
        a2 := AL.Args[1].Value;
        a3 := AL.Args[2].Value;
        // is this argument a constant???
        if Pos('__constVal', a3) = 1 then
        begin
          // if the argument is a constant then generate a single mul or div
          // shLR a1, a2, a3
          // first get the constant value
          de3 := Dataspace.FindEntryByFullName(a3);
          if Assigned(de3) then
          begin
            de3.DecRefCount; // this constant is used 1 less time than it used to be
            shiftConst := Integer(de3.DefaultValue);
          end
          else
          begin
            ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, Format(sInvalidVarArg, [a3]), true);
            shiftConst := 0;
          end;
          if shiftConst >= 0 then
          begin
            if shiftConst = 0 then
              AL.Command := OPS_INVALID
            else if AL.Command = OPS_SHL then
              AL.Command := OP_MUL
            else
              AL.Command := OP_DIV;
            shiftConst := Trunc(Power(2,shiftConst));
            c1 := CreateConstantVar(DataSpace, shiftConst, True);
            AL.Args.Clear;
            AL.AddArgs(Format('%s, %s, %s', [a1, a2, c1]));
          end
          else
            ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, sNoNegShifts, true);
        end
        else
        begin
          if not EnhancedFirmware then
          begin
            // what about shifting by a variable containing a negative value???
            c1 := CreateConstantVar(DataSpace, 1, True);
            c2 := CreateConstantVar(DataSpace, 2, True);
            if not fClumpUsesShift then
              DefineShiftArgs(fCurrentClump.Name);
            fClumpUsesShift := True;
            a4  := Format('__%s_shift_cnt', [fCurrentClump.Name]);
            a5  := Format('__%s_shift_tmp', [fCurrentClump.Name]);
            de1 := Dataspace.FindEntryByFullName(a1);
            de4 := Dataspace.FindEntryByFullName(a4);
            de5 := Dataspace.FindEntryByFullName(a5);
            if assigned(de1) and assigned(de4) and assigned(de5) then
            begin
              // shLR a1, a2, a3
              // mov __shift_cnt, a3
              AL.Command := OP_MOV;
              AL.Args.Clear;
              AL.AddArgs(Format('%s, %s', [a4, a3]));
              de4.IncRefCount;
              // mov __shift_tmp, a2
              AL := fCurrentClump.ClumpCode.Add;
              AL.Command := OP_MOV;
              AL.LineNum  := tmpLine;
              AL.AddArgs(Format('%s, %s', [a5, a2]));
              de5.IncRefCount;
              // label: brtst LTEQ, __shiftdone_NN, __shift_cnt
              AL := fCurrentClump.ClumpCode.Add;
              AL.Command := OP_BRTST;
              AL.LineNum  := tmpLine;
              AL.AddArgs(Format('LTEQ, __shiftdone_%d, %s', [fShiftCount, a4]));
              AL.LineLabel := Format('__shiftstart_%d', [fShiftCount]);
              fCurrentClump.AddLabel(AL.LineLabel, AL);
              de4.IncRefCount;
              // mul/div __shift_tmp, __shift_tmp, 2
              AL := fCurrentClump.ClumpCode.Add;
              if op = OPS_SHR then
                AL.Command := OP_DIV
              else
                AL.Command := OP_MUL;
              AL.LineNum  := tmpLine;
              AL.AddArgs(Format('%0:s, %0:s, %s', [a5, c2]));
              de5.IncRefCount;
              de5.IncRefCount;
              // sub __shift_cnt, __shift_cnt, 1
              AL := fCurrentClump.ClumpCode.Add;
              AL.Command := OP_SUB;
              AL.LineNum  := tmpLine;
              AL.AddArgs(Format('%0:s, %0:s, %s', [a4, c1]));
              de4.IncRefCount;
              de4.IncRefCount;
              // jmp __shiftstart_NNN
              AL := fCurrentClump.ClumpCode.Add;
              AL.Command := OP_JMP;
              AL.LineNum  := tmpLine;
              AL.AddArgs(Format('__shiftstart_%d', [fShiftCount]));
              // label __shiftdone_NNN
              AL := fCurrentClump.ClumpCode.Add;
              AL.Command := OPS_INVALID;
              AL.LineNum  := tmpLine;
              AL.LineLabel := Format('__shiftdone_%d', [fShiftCount]);
              fCurrentClump.AddLabel(AL.LineLabel, AL);
              // mov a1, __shift_tmp
              AL := fCurrentClump.ClumpCode.Add;
              AL.Command := OP_MOV;
              AL.LineNum  := tmpLine;
              AL.AddArgs(Format('%s, %s', [a1, a5]));
              de1.IncRefCount;
              de5.IncRefCount;
              inc(fShiftCount);
            end
            else
              ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, sInvalidStatement, true);
          end
          else
          begin
            if op = OPS_SHL then
              AL.Command := OP_ASL
            else
              AL.Command := OP_ASR;
          end;
        end;
      end
      else
        ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString, sInvalidStatement, true);
    end;
  end;
end;

function TRXEProgram.ReplaceTokens(const line: string): string;
var
  p : integer;
begin
  Result := line; // line is already trimmed
  if Length(Result) = 0 then Exit;
//  Result := Replace(Result, '##', '');
  if Length(Result) = 0 then Exit;
  if Pos('__ResetI__', Result) > 0 then
  begin
    Result := Replace(Result, '__ResetI__', '');
    fVarI := 0;
  end;
  if Length(Result) = 0 then Exit;
  p := Pos('__IncI__', Result);
  while p > 0 do begin
    inc(fVarI);
    System.Delete(Result, p, 8);
    p := Pos('__IncI__', Result);
  end;
  if Length(Result) = 0 then Exit;
  p := Pos('__DecI__', Result);
  while p > 0 do begin
    dec(fVarI);
    System.Delete(Result, p, 8);
    p := Pos('__DecI__', Result);
  end;
  if Length(Result) = 0 then Exit;
  if Pos('__ResetJ__', Result) > 0 then
  begin
    Result := Replace(Result, '__ResetJ__', '');
    fVarJ := 0;
  end;
  if Length(Result) = 0 then Exit;
  p := Pos('__IncJ__', Result);
  while p > 0 do begin
    inc(fVarJ);
    System.Delete(Result, p, 8);
    p := Pos('__IncJ__', Result);
  end;
  if Length(Result) = 0 then Exit;
  p := Pos('__DecJ__', Result);
  while p > 0 do begin
    dec(fVarJ);
    System.Delete(Result, p, 8);
    p := Pos('__DecJ__', Result);
  end;
  if Length(Result) = 0 then Exit;
  Result := Replace(Result, '__I__', IntToStr(fVarI));
  Result := Replace(Result, '__J__', IntToStr(fVarJ));
  Result := Replace(Result, '__THREADNAME__', fClumpName);
  Result := Replace(Result, '__LINE__', IntToStr(LineCounter));
  Result := Replace(Result, '__FILE__', GetCurrentFile(false));
  Result := Replace(Result, '__VER__', fProductVersion);
end;

function TRXEProgram.GetCurrentFile(bFullPath: boolean): string;
begin
  Result := fCurrentFile;
  if bFullPath and (GetCurrentPath <> '') then
    Result := IncludeTrailingPathDelimiter(GetCurrentPath) + Result;
end;

function TRXEProgram.GetCurrentPath: string;
begin
  Result := fCurrentPath;
end;

procedure TRXEProgram.SetCurrentFile(const Value: string);
begin
  fCurrentFile := ExtractFilename(Value);
  fCurrentPath := ExtractFilePath(Value);
end;

procedure TRXEProgram.FixupComparisonCodes(Arg: TAsmArgument);
var
  val : string;
begin
  val := Arg.Value;
  if      val = '<'  then Arg.Value := '0'
  else if val = '>'  then Arg.Value := '1'
  else if val = '<=' then Arg.Value := '2'
  else if val = '>=' then Arg.Value := '3'
  else if val = '==' then Arg.Value := '4'
  else if val = '!=' then Arg.Value := '5'
  else if val = '<>' then Arg.Value := '5';
end;

procedure TRXEProgram.ProcessSpecialFunctions(AL: TAsmLine);
var
  i, j, p : integer;
  Arg : TAsmArgument;
  name, leftstr, rightstr : string;
  SF : TSpecialFunction;
begin
  for i := 0 to AL.Args.Count - 1 do begin
    Arg := AL.Args[i];
    for j := 0 to fSpecialFunctions.Count - 1 do
    begin
      SF := TSpecialFunction(fSpecialFunctions[j]);
      p := Pos(SF.Func, Arg.Value);
      while p > 0 do
      begin
        name := Arg.Value;
        leftstr := Copy(name, 1, p-1); // everything before the first "sizeof("
        System.Delete(name, 1, p+Length(SF.Func)-1);
        p := Pos(')', name);
        rightstr := Copy(name, p+1, MaxInt); // everything after the first ")"
        System.Delete(name, p, MaxInt);
        SF.Execute(Arg, leftstr, rightstr, name);
        p := Pos(SF.Func, Arg.Value);
      end;
    end;
  end;
end;

procedure TRXEProgram.DefineShiftArgs(const basename: string);
var
  DE : TDataspaceEntry;
begin
  DE := Dataspace.Add;
  DE.DataType := dsSByte;
  DE.Identifier := Format('__%s_shift_cnt', [basename]);
  DE := Dataspace.Add;
  DE.DataType := dsSLong;
  DE.Identifier := Format('__%s_shift_tmp', [basename]);
end;

procedure TRXEProgram.DoCompilerCheck(AL: TAsmLine; bIfCheck : boolean);
var
  i1, i2, i3 : integer;
  bCheckOkay : boolean;
begin
  if fIgnoreLines then Exit;
  bCheckOkay := False;
  if AL.Args.Count = 3 then
  begin
    i2 := StrToIntDef(AL.Args[0].Value, OPCC1_EQ);
    i1 := StrToIntDef(AL.Args[1].Value, 0);
    i3 := StrToIntDef(AL.Args[2].Value, 0);
    case i2 of
      OPCC1_LT   : bCheckOkay := i1 < i3;
      OPCC1_GT   : bCheckOkay := i1 > i3;
      OPCC1_LTEQ : bCheckOkay := i1 <= i3;
      OPCC1_GTEQ : bCheckOkay := i1 >= i3;
      OPCC1_EQ   : bCheckOkay := i1 = i3;
      OPCC1_NEQ  : bCheckOkay := i1 <> i3;
    end;
    if not bCheckOkay then
    begin
      if bIfCheck then
        fIgnoreLines := True
      else
        ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
          Format(sCompCheckFailed, [i1, CCToStr(i2), i3]), true);
    end
    else
      if bIfCheck then
        fIgnoreLines := False;
  end
  else
    ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
      sInvalidCompCheck, true);
end;

procedure TRXEProgram.DefineVar(aVarName: string; dt :TDSType);
var
  DE : TDataspaceEntry;
begin
  DE := Dataspace.FindEntryByFullName(aVarName);
  if not Assigned(DE) then
  begin
    DE := Dataspace.Add;
    DE.DataType := dt;
    DE.Identifier := aVarName;
  end;
  DE.IncRefCount;
end;

procedure TRXEProgram.RegisterThreadForSpawning(aThreadName: string);
begin
  fSpawnedThreads.Add(aThreadName);
end;

procedure TRXEProgram.ProcessSpawnedThreads;
var
  i : integer;
  t, spawner : string;
begin
  for i := 0 to fSpawnedThreads.Count - 1 do
  begin
    t := fSpawnedThreads[i];
    spawner := Format('__%s_Spawner', [t]);
    if Codespace.IndexOf(spawner) = -1 then
    begin
      // need to create Spawner and Returner threads
      CreateReturnerClump(t);
      CreateSpawnerClump(t);
    end;
  end;
  fSpawnedThreads.Clear;
end;

procedure TRXEProgram.OutputUnusedItemWarnings;
var
  i : integer;
  de : TDataspaceEntry;
begin
  for i := DataSpace.Count - 1 downto 0 do
  begin
    de := DataSpace.Items[i];
    if not de.InUse then
      ReportProblem(0, GetCurrentFile(true), '',
        Format(sUnusedVar, [de.FullPathIdentifier]), false);
  end;
end;

procedure TRXEProgram.SetDefines(const Value: TStrings);
begin
  fDefines.Assign(Value);
end;

procedure TRXEProgram.LoadSpecialFunctions;
var
  SF : TSpecialFunction;
begin
  // sizeof
  SF := TSpecialFunction.Create;
  fSpecialFunctions.Add(SF);
  SF.Func := 'sizeof(';
  SF.Execute := HandleSpecialFunctionSizeOf;
  // isconst
  SF := TSpecialFunction.Create;
  fSpecialFunctions.Add(SF);
  SF.Func := 'isconst(';
  SF.Execute := HandleSpecialFunctionIsConst;
  // valueof
  SF := TSpecialFunction.Create;
  fSpecialFunctions.Add(SF);
  SF.Func := 'valueof(';
  SF.Execute := HandleSpecialFunctionValueOf;
  // typeof
  SF := TSpecialFunction.Create;
  fSpecialFunctions.Add(SF);
  SF.Func := 'typeof(';
  SF.Execute := HandleSpecialFunctionTypeOf;
end;

procedure TRXEProgram.HandleSpecialFunctionSizeOf(Arg: TAsmArgument;
  const left, right, name: string);
var
  de1 : TDataspaceEntry;
  dt : TDSType;
begin
  // is name a constant value?
  Calc.SilentExpression := name;
  if Calc.ParserError then
  begin
    de1 := Dataspace.FindEntryByFullName(name);
    if Assigned(de1) then
      Arg.Value := left + IntToStr(de1.ElementSize) + right
    else
    begin
      Arg.Value := left + '0' + right;
      ReportProblem(LineCounter, GetCurrentFile(true), '',
        Format(sInvalidVarArg, [name]), true);
    end
  end
  else
  begin
    dt := GetArgDataType(Calc.Value);
    Arg.Value := left + IntToStr(BytesPerType[dt]) + right;
  end;
end;

procedure TRXEProgram.HandleSpecialFunctionIsConst(Arg: TAsmArgument;
  const left, right, name: string);
begin
  // is name a constant value (i.e., can it be evaluated)?
  Calc.SilentExpression := name;
  if Calc.ParserError then
  begin
    Arg.Value := left + '0' + right;
  end
  else
  begin
    Arg.Value := left + '1' + right;
  end;
end;

procedure TRXEProgram.HandleSpecialFunctionValueOf(Arg: TAsmArgument;
  const left, right, name: string);
begin
  // is name a constant value?
  Calc.SilentExpression := name;
  if Calc.ParserError then
  begin
    Arg.Value := left + '0' + right;
    ReportProblem(LineCounter, GetCurrentFile(true), '',
      Format(sBadConstExpression, [name]), true);
  end
  else
  begin
    Arg.Value := left + NBCFloatToStr(Calc.Value) + right;
  end;
end;

procedure TRXEProgram.HandleSpecialFunctionTypeOf(Arg: TAsmArgument;
  const left, right, name: string);
var
  de1 : TDataspaceEntry;
  dt : TDSType;
begin
  // is name a constant value?
  Calc.SilentExpression := name;
  if Calc.ParserError then
  begin
    de1 := Dataspace.FindEntryByFullName(name);
    if Assigned(de1) then
      Arg.Value := left + IntToStr(Ord(de1.DataType)) + right
    else
    begin
      Arg.Value := left + '0' + right;
      ReportProblem(LineCounter, GetCurrentFile(true), '',
        Format(sInvalidVarArg, [name]), true);
    end
  end
  else
  begin
    dt := GetArgDataType(Calc.Value);
    Arg.Value := left + IntToStr(Ord(dt)) + right;
  end;
end;

procedure TRXEProgram.DoCompilerCheckType(AL: TAsmLine);
var
  s1, s2, s3 : string;
  bCheckOkay : boolean;
  de : TDataspaceEntry;
begin
  if fIgnoreLines then Exit;
  if AL.Args.Count = 2 then
  begin
    de := Dataspace.FindEntryByFullName(AL.Args[0].Value);
    if Assigned(de) then
    begin
      s1 := AL.Args[1].Value;
      s2 := de.TypeName;
      s3 := de.GetDataTypeAsString;
      bCheckOkay := (s1 = s2) or (s1 = s3);
      if not bCheckOkay then
      begin
          ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
            Format(sCompCheckTypFailed, [AL.Args[0].Value, s1]), true);
      end;
    end
    else
      ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
        sInvalidCompCheckTyp, true);
  end
  else
    ReportProblem(AL.LineNum, GetCurrentFile(true), AL.AsString,
      sInvalidCompCheckTyp, true);
end;

procedure TRXEProgram.SetLineCounter(const Value: integer);
begin
  fLineCounter := Value;
end;

function TRXEProgram.GetNXTInstruction(const idx: integer): NXTInstruction;
begin
  Result := fNXTInstructions[idx];
end;

procedure TRXEProgram.SetFirmwareVersion(const Value: word);
begin
  fFirmwareVersion := Value;
  CodeSpace.FirmwareVersion := Value;
  if fFirmwareVersion > MAX_FW_VER1X then
    CompilerVersion := 6
  else
    CompilerVersion := 5;
  InitializeInstructions;
end;

function TRXEProgram.IndexOfOpcode(op : TOpCode) : integer;
var
  i : integer;
begin
  Result := -1;
  for i := Low(fNXTInstructions) to High(fNXTInstructions) do
  begin
    if fNXTInstructions[i].Encoding = op then
    begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TRXEProgram.InitializeInstructions;
var
  i : integer;
begin
  if fFirmwareVersion > MAX_FW_VER1X then
  begin
    SetLength(fNXTInstructions, NXTInstructionsCount2x);
    for i := 0 to NXTInstructionsCount2x - 1 do begin
      fNXTInstructions[i] := NXTInstructions2x[i];
    end;
  end
  else
  begin
    SetLength(fNXTInstructions, NXTInstructionsCount1x);
    for i := 0 to NXTInstructionsCount1x - 1 do begin
      fNXTInstructions[i] := NXTInstructions1x[i];
    end;
  end;
end;

procedure TRXEProgram.CheckMainThread;
var
  i : integer;
  X : TClump;
begin
  i := Codespace.IndexOf(Codespace.InitialClumpName);
  if i = -1 then
  begin
    i := Codespace.IndexOf('t000');
    if i > -1 then
    begin
      X := Codespace.Items[i];
      X.Index := 0;
    end
    else
      ReportProblem(LineCounter, GetCurrentFile(true), '', sMainUndefined, false);
  end;
end;

procedure TRXEProgram.SaveToStrings(aStrings: TStrings);
begin
  // write source code to aStrings
  aStrings.Clear;
  DataSpace.SaveToStrings(aStrings);
  Codespace.SaveToStrings(aStrings);
end;

procedure TRXEProgram.DoCompilerStatusChange(const Status: string);
begin
  if Assigned(fOnCompilerStatusChange) then
    fOnCompilerStatusChange(Self, Status);
end;

{ TAsmLine }

procedure TAsmLine.AddArgs(sargs: string);
var
  i : integer;
  SL : TStringList;
  Arg : TAsmArgument;
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
        if IsDelimiter('{', sargs, 1) then
        begin
          tmp := '{';
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

constructor TAsmLine.Create(ACollection: TCollection);
begin
  inherited;
  fOpCode := OPS_INVALID;
  fInstrSize := -1;
  fMacroExpansion := False;
  fIsSpecial      := False;
  fArgs := TAsmArguments.Create;
end;

function TAsmLine.InstructionSize: integer;
begin
  if fInstrSize = -1 then
    FinalizeASMInstrSize;
  Result := fInstrSize;
end;

destructor TAsmLine.Destroy;
begin
  FreeAndNil(fArgs);
  inherited;
end;

function TAsmLine.GetClumpCode: TClumpCode;
begin
  Result := TClumpCode(Collection);
end;

procedure TAsmLine.SetArgs(const Value: TAsmArguments);
begin
  fArgs.Assign(Value);
end;

function TAsmLine.CanBeShortOpEncoded: boolean;
var
  rarg : ShortInt;
  w : word;
  tmpInt : integer;
begin
  Result := False;
  fsop := LongOpToShortOp(Command);
  if fsop <> -1 then
  begin
    case Args.Count of
      1 : begin
{
If the arg array has only 1 item and when the U16 value is converted to an I8 the two
are equal then short ops are allowed and the relative arg output is the I8 value.
}
        rarg := ShortInt(Args[0].DSID);
        w := Word(Args[0].DSID);
        Result := w = Word(rarg);
      end;
      2 : begin
{
If there are two args in the array then take (arg 0 - arg 1), convert to I8, add arg 1,
compare arg 0 to the result.  If equal the short op is allowed.  relative arg output is
the I8 difference between arg 0 and arg 1.
}
        tmpInt := (Args[0].DSID - Args[1].DSID);
        rarg := ShortInt(tmpInt);
        tmpInt := Args[1].DSID + rarg;
        Result := Args[0].DSID = tmpInt;
      end;
    else
      Result := False;
    end;
  end;
end;

procedure TAsmLine.FinalizeASMInstrSize;
var
  idx : integer;
  NI : NXTInstruction;
begin
  FinalizeArgs(False);
  fInstrSize := 0;
  fArity := 0;
  fCC := 0;
  if Command = OPS_INVALID then Exit;
  idx := CodeSpace.IndexOfOpcode(Command);
  if idx <> -1 then
  begin
    NI := CodeSpace.GetNXTInstruction(idx);
    fArity := NI.Arity;
    fCC := NI.CCType;
    if fArity = 6 then
    begin
      // opcodes with an arity of 6 have to be handled in a special manner
      fInstrSize := (2+Args.Count)*2;
    end
    else
    begin
      fInstrSize := (fArity + 1) * 2;
      if CanBeShortOpEncoded then
        Dec(fInstrSize, 2);
    end;
  end;
end;

procedure TAsmLine.HandleNameToDSID(const name: string; var aId: integer);
var
  i : integer;
begin
  // check whether the name matches an IO Map macro name
  i := IndexOfIOMapName(name);
  if i <> -1 then
    aId := IOMapFieldIDs[i].ID
  else
    ClumpCode.HandleNameToDSID(name, aId);
end;

procedure TAsmLine.SaveToCode(var Store: CodeArray);
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

procedure TAsmLine.FinalizeCode;
var
  i, argidx, isize : integer;
  b1, b2, cc : byte;
  rarg : ShortInt;
  bShort : boolean;
  arg0, arg1 : word;
begin
  FinalizeArgs(True);
  SetLength(fCode, fInstrSize div 2);
  bShort := CanBeShortOpEncoded;
  argidx := 0;
  isize := (farity+1)*2;
  if bShort then
    dec(isize, 2);
  for i := 0 to Length(fCode) - 1 do
  begin
    if (i = 0) and bShort then
    begin
      // first word short
      //iiiifsss xxxxxxxx
      b2 := (Byte(isize shl 4) and INST_MASK) or SHOP_MASK or (Byte(fsop) and CC_MASK);
      if farity = 1 then
      begin
        b1 := Byte(Args[argidx].DSID); // low byte
        // eat the first argument
        inc(argidx);
        fCode[i] := Word((Word(b1) and $FF) + (Word(b2) shl 8));
      end
      else
      begin
        arg0 := Word(Args[argidx].DSID);
        // eat the first argument
        inc(argidx);
        // peek at the second argument as well and calculate a temporary word
        // for the next slot in fCode
        arg1 := Word(Args[argidx].DSID);
        // the low byte in the first slot is a relative argument
        rarg := ShortInt(arg0 - arg1);
        fCode[i] := Word((Word(rarg) and $FF) + (Word(b2) shl 8));
      end;
    end
    else if i = 0 then
    begin
      // first word long
      b1 := Byte(Ord(Command)); // low byte
      b2 := (Byte(isize shl 4) and INST_MASK);
      if fCC <> 0 then
      begin
        // first argument should be comparison code
        cc := Byte(Args[argidx].DSID);
        inc(argidx);
        b2 := b2 or (cc and CC_MASK);
      end;
      fCode[i] := Word((Word(b1) and $FF) + (Word(b2) shl 8));
    end
    else
    begin
      // special handling for opcodes with arity = 6
      if (fArity = 6) and (i = 1) then
      begin
        fCode[i] := Word(fInstrSize);
      end
      else
      begin
        // all other words (regardless of encoding type)
        fCode[i] := Word(Args[argidx].DSID);
        inc(argidx);
      end;
    end;
  end;
end;

procedure TAsmLine.FinalizeArgs(bResolveDSIDs : Boolean);
var
  i, dsid, x, fsop : integer;
  Arg : TAsmArgument;
  argType : TAsmArgType;
begin
  if Command = OPS_INVALID then
    Exit;
  if (Command = OP_FINCLUMP) and (Args.Count <> 2) then
  begin
    FixupFinClump;
  end
  else
  begin
    // commands which can be short op encoded need to have their arguments
    // finalized regardless of the bResolveDSIDs value
    fsop := LongOpToShortOp(Command);
    if (fsop <> -1) or bResolveDSIDs then
    begin
      for i := 0 to Args.Count - 1 do
      begin
        Arg := Args[i];
        x := 0;
        Val(Arg.Value, dsid, x);
        // Val was interpreting variables such as 'xd' and 'xcb' as hexadecimal
        // numbers.  By checking also whether Arg.Value is a valid identifier
        // we can correctly resolve the variable (2006-05-04 JCH)
        if (x <> 0) or IsValidIdent(Arg.Value) then
        begin
          // some opcodes have clump IDs as their arguments.  Those need
          // special handling.
          if ((Command in [OP_SUBCALL, OPS_CALL, OPS_PRIORITY, OPS_PRIORITY_2]) and (i = 0)) or
             (Command in [OP_FINCLUMPIMMED, OPS_START, OPS_STOPCLUMP, OPS_START_2, OPS_STOPCLUMP_2]) then
          begin
            // try to lookup the clump # from the clump name
            dsid := CodeSpace.IndexOf(Arg.Value);
          end
          else
          begin
            // argument is not a valid integer (in string form)
            // could this argument be a label?
            argType := ExpectedArgType(FirmwareVersion, Self.Command, i);
            if argType = aatLabelID then
            begin
              if IsLabel(Arg.Value, dsid) then
              begin
                // id is start address of line containing label
                // we need to calculate positive or negative offset
                dsid := dsid - StartAddress;
              end
              else
                HandleNameToDSID(Arg.Value, dsid);
            end
            else
              HandleNameToDSID(Arg.Value, dsid);
          end;
        end;
        // if we have a dsid of -1 then try to resolve it one last time as
        // a constant expression
        if dsid = -1 then
          dsid := Integer(Trunc(Arg.Evaluate(CodeSpace.Calc)));
        Arg.fDSID := dsid;
      end;
    end;
  end;
end;

function TAsmLine.IsLabel(const name: string; var aID : integer): boolean;
var
  i : integer;
  AL : TAsmLine;
begin
  aID := 0;
  i := Clump.IndexOfLabel(name);
  Result := i <> -1;
  if Result then
  begin
    AL := Clump.AsmLineFromLabelIndex(i);
    aID := AL.StartAddress;
  end;
end;

function TAsmLine.GetAsString: string;
begin
  if fIsSpecial then
    Result := fSpecialStr
  else
  begin
    Result := LineLabel;
    if Result <> '' then
      Result := Result + ':';
    if Command <> OPS_INVALID then
    begin
      Result := Result + #9;
      Result := Result + CodeSpace.OpcodeToStr(Command) + ' ' + Args.AsString;
    end;
  end;
end;

function TAsmLine.GetClump: TClump;
begin
  Result := ClumpCode.Clump;
end;

function TAsmLine.GetCodeSpace: TCodeSpace;
begin
  Result := Clump.CodeSpace;
end;

procedure TAsmLine.FixupFinClump;
var
  A1, A2 : TAsmArgument;
begin
  Args.Clear;
  A1 := Args.Add;
  A2 := Args.Add;
  // automatically generate the correct arguments and DSID values
  if Clump.DownstreamCount > 0 then
    A1.fDSID := 0
  else
    A1.fDSID := -1;
  A2.fDSID := Clump.DownstreamCount - 1;
  A1.Value := IntToStr(A1.DSID);
  A2.Value := IntToStr(A2.DSID);
end;

procedure TAsmLine.RemoveVariableReferences;
var
  i : integer;
begin
  for i := 0 to Args.Count - 1 do
  begin
    RemoveVariableReference(Args[i].Value, i);
  end;
end;

procedure TAsmLine.RemoveVariableReference(const arg: string; const idx : integer);
var
  argType : TAsmArgType;
begin
  argType := ExpectedArgType(FirmwareVersion, Command, idx);
  case argType of
    aatVariable, aatVarNoConst, aatVarOrNull,
    aatScalar, aatScalarNoConst, aatScalarOrNull, aatMutex,
    aatCluster, aatArray, aatString, aatStringNoConst :
    begin
      CodeSpace.Dataspace.RemoveReferenceIfPresent(arg);
    end;
    aatClumpID : begin
      CodeSpace.RemoveReferenceIfPresent(arg);
    end;
  end;
end;

function TAsmLine.GetPC: word;
begin
  Result := Word(StartAddress);
end;

procedure TAsmLine.SetAsString(const Value: string);
begin
  fIsSpecial := True;
  Command := OPS_INVALID;
  fSpecialStr := Value;
end;

function TAsmLine.FirmwareVersion: word;
begin
  Result := CodeSpace.FirmwareVersion;
end;

function TAsmLine.GetOptimizable: boolean;
var
  op : TOpCode;
begin
  Result := False;
  op := Command;
  if (op in [OP_ADD..OP_ROTR]) or
     (op in [OP_GETIN, OP_GETOUT, OP_GETTICK]) or
     (op in [OP_INDEX..OP_BYTEARRTOSTR]) or
     ((FirmwareVersion > MAX_FW_VER1X) and
      (op in [OP_SQRT_2, OP_ABS_2, OPS_SIGN_2, OPS_FMTNUM_2, OPS_ACOS_2..OPS_ATAN2D_2])) or
     ((FirmwareVersion <= MAX_FW_VER1X) and
      (op in [OPS_ABS, OPS_SIGN, OPS_FMTNUM, OPS_ACOS..OPS_POW])) then
  begin
    Result := True;
  end;
end;

{ TAsmArguments }

function TAsmArguments.Add: TAsmArgument;
begin
  Result := TAsmArgument(inherited Add);
end;

procedure TAsmArguments.AssignTo(Dest: TPersistent);
var
  i : integer;
  arg : TAsmArgument;
begin
  if Dest is TAsmArguments then
  begin
    TAsmArguments(Dest).Clear;
    for i := 0 to Self.Count - 1 do
    begin
      arg := TAsmArguments(Dest).Add;
      arg.Value := Self[i].Value;
    end;
  end
  else
    inherited;
end;

constructor TAsmArguments.Create;
begin
  inherited Create(TAsmArgument);
end;

function TAsmArguments.GetAsString: string;
var
  i : integer;
begin
  Result := '';
  for i := 0 to Count - 1 do
    Result := Result + Items[i].Value + ', ';
  if Count > 0 then
    System.Delete(Result, Length(Result)-1, 2);
end;

function TAsmArguments.GetItem(Index: Integer): TAsmArgument;
begin
  Result := TAsmArgument(inherited GetItem(Index));
end;

function TAsmArguments.Insert(Index: Integer): TAsmArgument;
begin
  Result := TAsmArgument(inherited Insert(Index));
end;

procedure TAsmArguments.SetItem(Index: Integer; const Value: TAsmArgument);
begin
  inherited SetItem(Index, Value);
end;

{ TCodeSpace }

function TCodeSpace.Add: TClump;
begin
  Result := TClump(inherited Add);
end;

procedure TCodeSpace.BuildReferences;
var
  i, j : integer;
  C : TClump;
  AL : TAsmLine;
begin
  // build references
  for i := 0 to Count - 1 do
  begin
    C := Items[i];
    if i = 0 then
      C.IncRefCount; // the first clump is required
    for j := 0 to C.ClumpCode.Count - 1 do
    begin
      AL := C.ClumpCode.Items[j];
      if AL.Command in [OP_SUBCALL, OPS_CALL, OP_FINCLUMPIMMED,
                        OPS_START, OPS_STOPCLUMP, OPS_PRIORITY,
                        OPS_START_2, OPS_STOPCLUMP_2, OPS_PRIORITY_2] then
      begin
        // a clump name argument
        if AL.Args.Count > 0 then
          AddReferenceIfPresent(C, AL.Args[0].Value);
      end;
    end;
    // downstream clumps
    for j := 0 to C.DownstreamCount - 1 do
    begin
      AddReferenceIfPresent(C, C.DownstreamClumps[j]);
    end;
  end;
end;

procedure TCodeSpace.Compact;
var
  bDone : boolean;
  i : integer;
  C : TClump;
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

constructor TCodeSpace.Create(rp : TRXEProgram; ds : TDataspace);
begin
  inherited Create(TClump);
  fRXEProg := rp;
  fDS := ds;
  fInitName := 'main';
  fAddresses := TObjectList.Create;
  fFireCounts := TObjectList.Create;
  fMultiThreadedClumps := TStringList.Create;
  TStringList(fMultiThreadedClumps).CaseSensitive := True;
  TStringList(fMultiThreadedClumps).Duplicates := dupIgnore;
  FirmwareVersion := 105;
end;

destructor TCodeSpace.Destroy;
begin
  FreeAndNil(fAddresses);
  FreeAndNil(fFireCounts);
  FreeAndNil(fMultiThreadedClumps);
  inherited;
end;

procedure TCodeSpace.FinalizeDependencies;
var
  i, j, idx : integer;
  X : TClump;
  cName : string;
begin
  // if there is a clump called main make it the first clump
  i := IndexOf(InitialClumpName);
  if i <> -1 then
  begin
    X := Items[i];
    X.Index := 0;
  end;
  // update dependencies
  for i := 0 to Count - 1 do
  begin
    X := Items[i];
    for j := 0 to X.UpstreamCount - 1 do
    begin
      // add myself to each (thread in my upstream list)'s downstream list
      cName := X.UpstreamClumps[j];
      idx := IndexOf(cName);
      if idx <> -1 then
        Items[idx].AddDependant(X.Name);
    end;
    for j := 0 to X.DownstreamCount - 1 do
    begin
      // add myself to each (thread in my downstream list)'s upstream list
      cName := X.DownstreamClumps[j];
      idx := IndexOf(cName);
      if idx <> -1 then
        Items[idx].AddAncestor(X.Name);
    end;
  end;
end;

function TCodeSpace.GetAddress(aIndex: Integer): Word;
begin
  if fAddresses.Count <> Count then
    FinalizeAddressesAndFireCounts;
  Result := Word(TIntegerObject(fAddresses[aIndex]).Value);
end;

function TCodeSpace.GetCaseSensitive: boolean;
begin
  Result := fCaseSensitive;
end;

function TCodeSpace.GetFireCount(aIndex: integer): Byte;
begin
  if fFireCounts.Count <> Count then
    FinalizeAddressesAndFireCounts;
  Result := Byte(TIntegerObject(fFireCounts[aIndex]).Value);
end;

function TCodeSpace.GetItem(aIndex: Integer): TClump;
begin
  Result := TClump(inherited GetItem(aIndex));
end;

procedure TCodeSpace.HandleNameToDSID(const aName: string; var aId: integer);
begin
  aId := 0;
  if Assigned(fOnNameToDSID) then
    fOnNameToDSID(aName, aId);
end;

function TCodeSpace.IndexOf(const aName: string): integer;
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

procedure TCodeSpace.AddReferenceIfPresent(aClump : TClump; const aName: string);
var
  i : integer;
  C : TClump;
begin
  i := IndexOf(aName);
  if i <> -1 then begin
    C := Items[i];
    C.IncRefCount;
    if C.IsSubroutine then
      C.AddCaller(aClump.Name);
  end;
end;

procedure TCodeSpace.RemoveReferenceIfPresent(const aName: string);
var
  i : integer;
begin
  i := IndexOf(aName);
  if i <> -1 then
    Items[i].DecRefCount;
end;

procedure TCodeSpace.SaveToCodeData(aCD: TClumpData; aCode : TCodeSpaceAry);
var
  pX : ^ClumpRecord;
  C : TClump;
  i : integer;
begin
  if (fAddresses.Count <> Count) or (fFireCounts.Count <> Count) then
    FinalizeAddressesAndFireCounts;
  SetLength(aCD.ClumpDeps, 0); // start with an empty array
  SetLength(aCode.Code, 0);
  SetLength(aCD.CRecs, Count);
  for i := 0 to Count - 1 do
  begin
    pX := @(aCD.CRecs[i]);
    C := Items[i];
    pX^.FireCount := FireCounts[i];
    pX^.DependentCount := C.DownstreamCount;
    pX^.CodeStart := StartingAddresses[i];
    C.SaveDependencies(aCD.ClumpDeps);
    C.SaveToCode(aCode.Code);
  end;
end;

procedure TCodeSpace.SetCaseSensitive(const Value: boolean);
var
  i : integer;
begin
  fCaseSensitive := Value;
  for i := 0 to Count - 1 do
  begin
    Items[i].fLabelMap.CaseSensitive := Value;
    Items[i].fUpstream.CaseSensitive := Value;
    Items[i].fDownstream.CaseSensitive := Value;
  end;
end;

procedure TCodeSpace.SetItem(aIndex: Integer; const aValue: TClump);
begin
  inherited SetItem(aIndex, aValue);
end;

procedure TCodeSpace.FinalizeAddressesAndFireCounts;
var
  i : integer;
  X : TClump;
  addr : integer;
begin
  // calculate addresses for all the clumps
  addr := 0;
  fAddresses.Clear;
  fFireCounts.Clear;
  for i := 0 to Count - 1 do
  begin
    X := Items[i];
    fAddresses.Add(TIntegerObject.Create(addr));
    inc(addr, X.DataSize);
    fFireCounts.Add(TIntegerObject.Create(X.FireCount));
  end;
end;

procedure TCodeSpace.Optimize(const level : Integer);
var
  i : integer;
  C : TClump;
begin
  // level 2 optimizations are buggy so don't do them.
  // have each clump optimize itself
  for i := 0 to Count - 1 do
  begin
    C := Items[i];
    // skip clumps starting with '__' under the assumption that
    // they are API-level (hand optimized) clumps
    if Pos('__', C.Name) = 1 then
      Continue;
    RXEProgram.DoCompilerStatusChange(Format(sNBCOptClump, [C.Name]));
    C.Optimize(level);
  end;
end;

procedure TCodeSpace.OptimizeMutexes;
var
  i : integer;
begin
  // have each clump optimize itself
  for i := 0 to Count - 1 do
    Items[i].OptimizeMutexes;
end;

procedure TCodeSpace.SaveToSymbolTable(aStrings: TStrings);
var
  i, j : integer;
  C : TClump;
  AL : TAsmLine;
begin
  aStrings.Add('#SOURCES');
  aStrings.Add('Clump'#9'Line'#9'PC'#9'Source');
  for i := 0 to Count - 1 do
  begin
    C := Items[i];
    for j := 0 to C.ClumpCode.Count - 1 do
    begin
      AL := C.ClumpCode.Items[j];
      if not AL.IsPartOfMacroExpansion and ((AL.Command <> OPS_INVALID) or (AL.IsSpecial)) then
        aStrings.Add(Format('%d'#9'%d'#9'%d'#9'%s',
          [i, AL.LineNum, AL.ProgramCounter, AL.AsString]));
    end;
  end;
  aStrings.Add('#CLUMPS');
  aStrings.Add('Clump'#9'Name'#9'Offset'#9'File');
  for i := 0 to Count - 1 do
  begin
    C := Items[i];
    aStrings.Add(Format('%d'#9'%s'#9'%d'#9'%s',
      [i, C.Name, C.StartAddress, C.Filename]));
  end;
end;

procedure TCodeSpace.MultiThread(const aName: string);
begin
  fMultiThreadedClumps.Add(aName);
end;

function TCodeSpace.GetNXTInstruction(const idx: integer): NXTInstruction;
begin
  Result := fNXTInstructions[idx];
end;

procedure TCodeSpace.InitializeInstructions;
var
  i : integer;
begin
  if fFirmwareVersion > MAX_FW_VER1X then
  begin
    SetLength(fNXTInstructions, NXTInstructionsCount2x);
    for i := 0 to NXTInstructionsCount2x - 1 do begin
      fNXTInstructions[i] := NXTInstructions2x[i];
    end;
  end
  else
  begin
    SetLength(fNXTInstructions, NXTInstructionsCount1x);
    for i := 0 to NXTInstructionsCount1x - 1 do begin
      fNXTInstructions[i] := NXTInstructions1x[i];
    end;
  end;
end;

function TCodeSpace.IndexOfOpcode(op: TOpCode): integer;
var
  i : integer;
begin
  Result := -1;
  for i := Low(fNXTInstructions) to High(fNXTInstructions) do
  begin
    if fNXTInstructions[i].Encoding = op then
    begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TCodeSpace.SetFirmwareVersion(const Value: word);
begin
  fFirmwareVersion := Value;
  InitializeInstructions;
end;

function TCodeSpace.OpcodeToStr(const op: TOpCode): string;
var
  i : integer;
begin
  if op <> OPS_INVALID then
    Result := Format('bad op (%d)', [Ord(op)])
  else
    Result := '';
  for i := Low(fNXTInstructions) to High(fNXTInstructions) do
  begin
    if fNXTInstructions[i].Encoding = op then
    begin
      Result := fNXTInstructions[i].Name;
      break;
    end;
  end;
end;

procedure TCodeSpace.RemoveUnusedLabels;
var
  i : integer;
begin
  // now remove any labels that are not targets of a branch/jump
  for i := 0 to Count - 1 do
    Items[i].RemoveUnusedLabels;
end;

procedure TCodeSpace.SaveToStrings(aStrings: TStrings);
var
  i, j : integer;
  C : TClump;
  AL : TAsmLine;
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
    for j := 0 to C.ClumpCode.Count - 1 do
    begin
      AL := C.ClumpCode.Items[j];
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

{ TClump }

procedure TClump.AddClumpDependencies(const opcode, args: string);
var
  tmpSL : TStringList;
  i : integer;
begin
  // clumps with no downstream dependencies finalize -1, -1
  // clumps with downstream dependencies finalize and conditionally schedule
  // all their downstream dependants with 0..N where N is the number of
  // dependants - 1.
  tmpSL := TStringList.Create;
  try
    tmpSL.CommaText := args;
    if opcode = CodeSpace.OpcodeToStr(OPS_REQUIRES) then
    begin
      // upstream clumps
      fUpstream.AddStrings(tmpSL);
    end
    else if opcode = CodeSpace.OpcodeToStr(OPS_USES) then
    begin
      // downstream clumps
//      fDownstream.AddStrings(tmpSL);  // this seems to do the same as the for loop does
      for i := 0 to tmpSL.Count - 1 do
        AddDependant(tmpSL[i]);
    end;
  finally
    tmpSL.Free;
  end;
end;

constructor TClump.Create(ACollection: TCollection);
begin
  inherited;
  fDatasize := -1;
  fIsSub    := False;
  fRefCount := 0;
  fLabelMap := TStringList.Create;
  fLabelMap.CaseSensitive := CodeSpace.CaseSensitive;
  fLabelMap.Sorted := True;
  fUpstream := TStringList.Create;
  fUpstream.CaseSensitive := CodeSpace.CaseSensitive;
  fUpstream.Sorted := False; // do not sort dependencies
  fUpstream.Duplicates := dupIgnore;
  fDownstream := TStringList.Create;
  fDownstream.CaseSensitive := CodeSpace.CaseSensitive;
  fDownstream.Sorted := False; // do not sort dependencies
  fDownstream.Duplicates := dupIgnore;
  fClumpCode := TClumpCode.Create(Self);
  fClumpCode.OnNameToDSID := HandleNameToDSID;
  fCallers := TStringList.Create;
  fCallers.CaseSensitive := CodeSpace.CaseSensitive;
  fCallers.Sorted := True;
  fCallers.Duplicates := dupIgnore;
end;

destructor TClump.Destroy;
begin
  FreeAndNil(fLabelMap);
  FreeAndNil(fUpstream);
  FreeAndNil(fDownstream);
  FreeAndNil(fClumpCode);
  FreeAndNil(fCallers);
  inherited;
end;

function TClump.GetUpstream(aIndex: integer): string;
begin
  Result := fUpstream[aIndex];
end;

function TClump.GetCodeSpace: TCodeSpace;
begin
  Result := TCodeSpace(Collection);
end;

function TClump.GetDataSize: Word;
begin
  // calculate the datasize from the code contained in this clump
  if fDatasize = -1 then
    FinalizeClump;
  Result := Word(fDatasize);
end;

function TClump.GetStartAddress: Word;
begin
  // the starting address of a clump is determined by the codespace
  Result := CodeSpace.StartingAddresses[Self.Index];
end;

function TClump.GetDownstream(aIndex: integer): string;
begin
  Result := fDownstream[aIndex];
end;

function TClump.GetDownCount: Byte;
begin
  Result := Byte(fDownstream.Count);
end;

function TClump.GetUpCount: integer;
begin
  Result := fUpstream.Count;
end;

procedure TClump.FinalizeClump;
var
  i : integer;
  AL : TAsmLine;
begin
  fDataSize := 0; // no code to start with
  ClumpCode.FixupFinalization;
  for i := 0 to ClumpCode.Count - 1 do
  begin
    AL := ClumpCode[i];
    AL.fStartAddress := fDataSize;
    inc(fDataSize, AL.InstructionSize div 2);
  end;
  // save code
  for i := 0 to ClumpCode.Count - 1 do
  begin
    AL := ClumpCode[i];
    AL.SaveToCode(fCode);
  end;
end;

procedure TClump.SaveToCode(var Store: CodeArray);
var
  i, len, start : integer;
begin
  if Length(fCode) = 0 then
    FinalizeClump;
  len := Length(fCode);
  start := Length(Store);
  // copy data from our local array to the passed in array
  SetLength(Store, start + len);
  for i := 0 to len - 1 do
  begin
    Store[start+i] := fCode[i];
  end;
end;

procedure TClump.SaveDependencies(var Store: ClumpDepArray);
var
  len, i : integer;
begin
  len := Length(Store);
  SetLength(Store, len+DownstreamCount);
  for i := 0 to DownstreamCount - 1 do
  begin
    Store[len+i] := Byte(CodeSpace.IndexOf(DownstreamClumps[i]));
  end;
end;

procedure TClump.HandleNameToDSID(const aname: string; var aId: integer);
begin
  CodeSpace.HandleNameToDSID(aname, aId);
end;

function TClump.GetFireCount: Word;
var
  i, j : integer;
  cnt : Word;
  C : TClump;
begin
  if Self.Index = 0 then
    Result := 0
  else
  begin
    Result := 1;
    // how many times am I listed in other clumps downstream clumps list?
    cnt := 0;
    for i := 0 to CodeSpace.Count - 1 do
    begin
      C := CodeSpace[i];
      if C.Index = Self.Index then Continue;
      for j := 0 to C.DownstreamCount - 1 do
      begin
        if C.DownstreamClumps[j] = Self.Name then
        begin
          inc(cnt);
          break;
        end;
      end;
    end;
    if cnt > 0 then
      Result := cnt;
  end;
end;

procedure TClump.AddDependant(const clumpName: string);
begin
  if fDownstream.IndexOf(clumpName) = -1 then
    fDownstream.Add(clumpName);
end;

procedure TClump.AddAncestor(const clumpName: string);
begin
  if fUpstream.IndexOf(clumpName) = -1 then
    fUpstream.Add(clumpName);
end;

procedure TClump.AddCaller(const clumpName: string);
begin
  fCallers.Add(clumpName); // duplicates are ignored
end;

function TClump.GetCaseSensitive: boolean;
begin
  Result := CodeSpace.CaseSensitive;
end;

procedure TClump.AddLabel(const lbl: string; Line : TAsmLine);
begin
  fLabelMap.AddObject(lbl, Line);
end;

function TClump.IndexOfLabel(const lbl: string): integer;
begin
  Result := fLabelMap.IndexOf(lbl);
end;

function TClump.AsmLineFromLabelIndex(const idx: integer): TAsmLine;
begin
  Result := TAsmLine(fLabelMap.Objects[idx]);
end;

function TClump.GetInUse: boolean;
begin
  Result := fRefCount > 0;
end;

procedure TClump.RemoveReferences;
var
  i : integer;
begin
  // remove references in code
  for i := 0 to ClumpCode.Count - 1 do
  begin
    ClumpCode.Items[i].RemoveVariableReferences;
  end;
  // remove downstream dependency references
  for i := 0 to DownstreamCount - 1 do
  begin
    CodeSpace.RemoveReferenceIfPresent(DownstreamClumps[i]);
  end;
  // if this clump is a subroutine remove
  // the return address variable as well
  if Self.IsSubroutine then
    CodeSpace.Dataspace.RemoveReferenceIfPresent(Format('__%s_return', [Name]));
end;

procedure TClump.DecRefCount;
begin
  dec(fRefCount);
end;

procedure TClump.IncRefCount;
begin
  inc(fRefCount);
end;

function IsStackOrReg(const str : string) : boolean;
begin
  Result := (Pos('__D0', str) = 1) or (Pos('__signed_stack_', str) = 1) or
            (Pos('__unsigned_stack_', str) = 1) or (Pos('__float_stack_', str) = 1) or
            (Pos('__DU0', str) = 1) or (Pos('__DF0', str) = 1);
end;

procedure TClump.RemoveOrNOPLine(AL, ALNext : TAsmLine; const idx : integer);
begin
  if AL.LineLabel = '' then
  begin
    ClumpCode.Delete(idx);
  end
  else if Assigned(ALNext) and (ALNext.LineLabel = '') then
  begin
    ALNext.LineLabel := AL.LineLabel;
    ClumpCode.Delete(idx);
  end
  else
  begin
    AL.Command := OPS_INVALID;
    AL.Args.Clear;
  end;
end;

function GetTypeHint(DSpace : TDataspace; const aLine: TASMLine; const idx : integer; bEnhanced : boolean): TDSType;
var
  DE : TDataspaceEntry;
begin
  Result := dsVoid;
  case aLine.Command of
    OP_ARRINIT : begin
      if (idx = 1) and not bEnhanced then
      begin
        // the first argument is always an array.  We need the base type
        DE := DSpace.FindEntryByFullName(aLine.Args[0].Value);
        if Assigned(DE) then
          Result := DE.BaseDataType;
      end;
    end;
  else
    Result := dsVoid;
  end;
end;

function CreateConstantVar(DSpace : TDataspace; val : Extended;
  bIncCount : boolean; aTypeHint : TDSType) : string;
var
  datatype : TDSType;
  DE : TDataspaceEntry;
//  iVal : Int64;
  sVal : Single;
begin
  if aTypeHint <> dsVoid then
    datatype := aTypeHint
  else
    datatype := GetArgDataType(val);
//  iVal := Trunc(val*1000000); // scale by 6 decimal places
//  Result := GenerateTOCName(Byte(Ord(datatype)), Int64(abs(iVal)), '%1:d');
  Result := Replace(NBCFloatToStr(abs(val)), '.', 'P');
  if datatype = dsFloat then
    Result := 'f' + Result; // distinguish between float constants and integer constants
  if val < 0 then
    Result := '__constValNeg' + Result
  else
    Result := '__constVal' + Result;
  // is this temporary already in the dataspace?
  DE := DSpace.FindEntryByFullName(Result);
  if not Assigned(DE) then
  begin
    // we need to add it
    DE := DSpace.Add;
    DE.Identifier := Result;
    DE.DataType := datatype;
//    DE.DefaultValue := ValueAsCardinal(val, datatype);
    if datatype = dsFloat then
    begin
      sVal := val;
      DE.DefaultValue := SingleToCardinal(sVal);
    end
    else
      DE.DefaultValue := Cardinal(Trunc(val));
  end;
  if Assigned(DE) and bIncCount then
    DE.IncRefCount;
end;

procedure ConvertToSetOrMov(DS : TDataspace; var AL : TAsmLine; iVal : Double; var arg1 : string);
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

function GetArgValue(EP : TNBCExpParser; arg1 : string; var val : Double) : boolean;
var
  bIsNeg : boolean;
  bIsFloat : boolean;
begin
  if Pos('__constVal', arg1) = 1 then
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
  end
  else
  begin
    EP.SilentExpression := arg1;
    Result := not EP.ParserError;
    if Result then
      val := EP.Value
    else
      val := 0;
  end;
end;

function CountArgUsage(AL : TAsmLine; const arg : string) : integer;
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

procedure TClump.Optimize(const level : Integer);
var
  i, offset : integer;
  iVal : Double;
  AL, ALNext, tmpAL : TAsmLine;
  arg1, arg2, arg3, tmp : string;
  bDone, bArg1Numeric, bArg2Numeric, bCanOptimize : boolean;
  Arg1Val, Arg2Val : Double;
  DE : TDataspaceEntry;

  function CheckReferenceCount : boolean;
  var
    cnt : integer;
  begin
    Result := True;
    arg1 := AL.Args[0].Value; // check the output (dest) argument
    cnt := CountArgUsage(AL, arg1);
    DE := CodeSpace.Dataspace.FindEntryByFullName(arg1);
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
  bDone := False;
  while not bDone do begin
    bDone := True; // assume we are done
    for i := 0 to ClumpCode.Count - 1 do begin
      AL := ClumpCode.Items[i];
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
        if IsStackOrReg(arg1) then
        begin
          // maybe we can do an optimization
          // find the next line (which may not be i+1) that is not (NOP or labeled)
          offset := 1;
          while (i < ClumpCode.Count - offset) do begin
            tmpAL := ClumpCode.Items[i+offset];
            if (tmpAL.Command <> OPS_INVALID) or (tmpAL.LineLabel <> '') then
              Break;
            inc(offset);
          end;
          // every line between Items[i] and Items[i+offset] are NOP lines without labels.
          if i < (ClumpCode.Count - offset) then
          begin
            ALNext := ClumpCode.Items[i+offset];
            // now check other cases
            // bricxcc-Bugs-1669679 - make sure the next line
            // cannot be jumped to from elsewhere.  If it does then the
            // "previous" line may actually be skipped so we cannot
            // do any optimization
            if (ALNext.LineLabel = '') and
               (ALNext.Command = OP_MOV) and
               (ALNext.Args[1].Value = arg1) then
            begin
              bCanOptimize := True;
              if AL.Command = OP_SET then
              begin
                // need to also check the type of the next line's output arg
                DE := CodeSpace.Dataspace.FindEntryByFullName(ALNext.Args[0].Value);
                if Assigned(DE) then
                  bCanOptimize := DE.DataType <> dsFloat
                else
                  bCanOptimize := False;
              end;
              if bCanOptimize then
              begin
                AL.RemoveVariableReference(arg1, 0);
                AL.Args[0].Value := ALNext.Args[0].Value; // switch output arg (no ref count changes)
                ALNext.RemoveVariableReference(arg1, 1);
                ALNext.Command := OPS_INVALID; // no-op next line
                ALNext.Args.Clear;
                bDone := False;
                Break;
              end;
            end;
          end;
        end;
      end;
      case AL.Command of
        OP_SET, OP_MOV : begin
          // this is a set or mov line
          // first check reference count of output variable
          if not CheckReferenceCount then
          begin
            bDone := False;
            Break;
          end;
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
          while (i < ClumpCode.Count - offset) do begin
            tmpAL := ClumpCode.Items[i+offset];
            if (tmpAL.Command <> OPS_INVALID) or (tmpAL.LineLabel <> '') then
            begin
              // is it safe to ignore this line?  If it is a set or a mov for
              // different variables then yes (at higher optimization levels) ...
              // (this is not always safe AKA buggy)
              if not ((tmpAL.Command in [OP_SET, OP_MOV]) and
                      (tmpAL.LineLabel = '') and
                      (arg1 <> tmpAL.Args[0].Value) and
                      (arg1 <> tmpAL.Args[1].Value) and
                      (level >= 4)) then
                Break;
            end;
            inc(offset);
          end;
          // every line between Items[i] and Items[i+offset] are NOP lines without labels.
          // OR lines that have nothing whatsoever to do with the output variable in
          // Items[i]
          if i < (ClumpCode.Count - offset) then
          begin
            ALNext := ClumpCode.Items[i+offset];
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
                        tmp := CreateConstantVar(CodeSpace.Dataspace, StrToIntDef(AL.Args[1].Value, 0), True)
                      else
                      begin
                        tmp := AL.Args[1].Value;
                        CodeSpace.Dataspace.FindEntryAndAddReference(tmp);
                      end;
                      ALNext.Command := OP_MOV;
                      ALNext.Args[1].Value := tmp;
{
                      ALNext.Command := AL.Command;
                      ALNext.Args[1].Value := AL.Args[1].Value;
}
                      ALNext.RemoveVariableReference(arg2, 1);
                      if IsStackOrReg(arg1) then
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
                      if CodeSpace.FirmwareVersion > MAX_FW_VER1X then
                        ALNext.Command := OPS_WAITI_2
                      else
                        ALNext.Command := OP_WAIT;
                    end;
                    CodeSpace.Dataspace.FindEntryAndAddReference(ALNext.Args[0].Value);
                    if IsStackOrReg(arg1) then
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
                      tmp := CreateConstantVar(CodeSpace.Dataspace, StrToIntDef(AL.Args[1].Value, 0), True)
                    else
                    begin
                      // increment the reference count of this variable
                      tmp := AL.Args[1].Value;
                      CodeSpace.Dataspace.FindEntryAndAddReference(tmp);
                    end;
                    if (arg1 = arg2) then begin
                      ALNext.Args[2].Value := tmp;
                      ALNext.RemoveVariableReference(arg2, 2);
                    end
                    else begin  // arg1=arg3 (aka ALNext.Args[1].Value)
                      ALNext.Args[1].Value := tmp;
                      ALNext.RemoveVariableReference(arg3, 1);
                    end;
                    if IsStackOrReg(arg1) then
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
                      tmp := CreateConstantVar(CodeSpace.Dataspace, StrToIntDef(AL.Args[1].Value, 0), True)
                    else
                    begin
                      tmp := AL.Args[1].Value;
                      CodeSpace.Dataspace.FindEntryAndAddReference(tmp);
                    end;
                    ALNext.Args[1].Value := tmp;
                    ALNext.RemoveVariableReference(arg2, 1);
                    if IsStackOrReg(arg1) then
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
          // first check reference count of output variable
          if not CheckReferenceCount then
          begin
            bDone := False;
            Break;
          end;
          if level >= 3 then
          begin
            // process argument 1
            // is it a constant variable (i.e., aname == _constVal...)
            arg1 := AL.Args[1].Value;
            Arg1Val := 0;
            bArg1Numeric := GetArgValue(CodeSpace.Calc, arg1, Arg1Val);
            // now process argument 2
            arg2 := AL.Args[2].Value;
            Arg2Val := 0;
            bArg2Numeric := GetArgValue(CodeSpace.Calc, arg2, Arg2Val);
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
                ConvertToSetOrMov(CodeSpace.Dataspace, AL, iVal, arg1);
                AL.Args.Delete(2);
                AL.Args[1].Value := arg1;
                bDone := False;
                Break;
              end;
            end;
          end;
        end;
        OP_NEG, OP_NOT : begin
          // first check reference count of output variable
          if not CheckReferenceCount then
          begin
            bDone := False;
            Break;
          end;
          if level >= 3 then
          begin
            // process argument 1
            // is it a constant variable (i.e., aname == _constVal...)
            arg1 := AL.Args[1].Value;
            bArg1Numeric := GetArgValue(CodeSpace.Calc, arg1, Arg1Val);
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
              ConvertToSetOrMov(CodeSpace.Dataspace, AL, iVal, arg1);
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
          while (i < ClumpCode.Count - offset) do begin
            tmpAL := ClumpCode.Items[i+offset];
            if (tmpAL.Command <> OPS_INVALID) or (tmpAL.LineLabel <> '') then
              Break;
            inc(offset);
          end;
          // every line between Items[i] and Items[i+offset] are NOP lines without labels.
          if i < (ClumpCode.Count - offset) then
          begin
            ALNext := ClumpCode.Items[i+offset];
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
end;

procedure TClump.OptimizeMutexes;
var
  i : integer;
  AL : TAsmLine;
  de : TDataspaceEntry;

  function AllCallersHaveZeroAncestors : boolean;
  var
    j, idx : integer;
    C : TClump;
  begin
    Result := True;
    for j := 0 to CallerCount - 1 do begin
      idx := CodeSpace.IndexOf(fCallers[j]);
      if idx <> -1 then begin
        C := CodeSpace[idx];
        if C.UpstreamCount > 0 then begin
          Result := False;
          Break;
        end;
      end;
    end;
  end;
begin
  if (UpstreamCount = 0) and
     ((CallerCount <= 1) or AllCallersHaveZeroAncestors) and
     (not IsMultithreaded) then
    for i := 0 to ClumpCode.Count - 1 do begin
      AL := ClumpCode.Items[i];
      if AL.Command in [OP_ACQUIRE, OP_RELEASE] then
      begin
        de := self.CodeSpace.Dataspace.FindEntryByName(Al.Args[0].Value);
        if Assigned(de) and
           (de.DataType = dsMutex) and
           (de.ThreadCount <= 1) then
        begin
          AL.RemoveVariableReferences;
          AL.Command := OPS_INVALID; // no-op
          AL.Args.Clear;
        end;
      end;
    end;
end;

function TClump.GetCallerCount: Byte;
begin
  Result := Byte(fCallers.Count);
end;

function TClump.GetIsMultithreaded: boolean;
begin
  Result := Codespace.fMultiThreadedClumps.IndexOf(Self.Name) <> -1;
end;

procedure TClump.RemoveUnusedLabels;
var
  i : integer;
  AL : TAsmLine;
  SL : TStringList;
begin
  // first gather a list of jump targets in this clump
  SL := TStringList.Create;
  try
    SL.Sorted := True;
    SL.Duplicates := dupIgnore;
    for i := 0 to ClumpCode.Count - 1 do begin
      AL := ClumpCode.Items[i];
      if AL.Command = OP_JMP then
      begin
        SL.Add(AL.Args[0].Value); // first argument is label
      end
      else if AL.Command in [OP_BRCMP, OP_BRTST] then
      begin
        SL.Add(AL.Args[1].Value); // second argument is label
      end;
    end;
    for i := 0 to ClumpCode.Count - 1 do begin
      AL := ClumpCode.Items[i];
      if SL.IndexOf(AL.LineLabel) = -1 then
        AL.LineLabel := '';
    end;
  finally
    SL.Free;
  end;
end;

{ TClumpCode }

function TClumpCode.Add: TAsmLine;
begin
  Result := TAsmLine(inherited Add);
end;

constructor TClumpCode.Create(aClump : TClump);
begin
  inherited Create(TAsmLine);
  fClump := aClump;
end;

destructor TClumpCode.Destroy;
begin

  inherited;
end;

procedure TClumpCode.FixupFinalization;
var
  i : integer;
  AL : TAsmLine;
  bDone : boolean;
begin
  // if this clump does not contain exit, exitto or subret calls anywhere
  // or if the last line has an invalid opcode (empty line with label)
  // then add exit at the very end
  bDone := False;
  for i := 0 to Count - 1 do
  begin
    AL := Items[i];
    if AL.Command in [OP_FINCLUMP, OP_FINCLUMPIMMED, OP_SUBRET] then
    begin
      bDone := True;
      Break;
    end;
  end;
  if not bDone or ((Count > 0) and (Items[Count - 1].Command = OPS_INVALID)) then
  begin
    // need to add fthread to end of clump code
    AL := Add;
    AL.LineNum := Clump.LastLine;
    if Clump.IsSubroutine then
    begin
      AL.Command := OP_SUBRET;
      AL.AddArgs(Format('__%s_return', [Clump.Name]));
    end
    else
      AL.Command := OP_FINCLUMP;
  end;
end;

function TClumpCode.GetItem(Index: Integer): TAsmLine;
begin
  Result := TAsmLine(inherited GetItem(Index));
end;

procedure TClumpCode.HandleNameToDSID(const aName: string; var aId: integer);
begin
  aId := 0;
  if Assigned(fOnNameToDSID) then
    fOnNameToDSID(aName, aId);
end;

procedure TClumpCode.SetItem(Index: Integer; const Value: TAsmLine);
begin
  inherited SetItem(Index, Value);
end;

{ TAsmArgument }

function TAsmArgument.Evaluate(Calc: TNBCExpParser): Extended;
begin
  Calc.Expression := Value;
  Result := Calc.Value;
end;

function TAsmArgument.IsQuoted(delim : char): boolean;
begin
  // the argument is a quoted if it starts and ends with
  // the specified delimiter.
  Result := (IsDelimiter(delim, Value, 1) and
             IsDelimiter(delim, Value, Length(Value)));
end;

procedure TAsmArgument.SetValue(const Value: string);
begin
  fDSID := -1;
  fValue := Value;
end;

{ TDSData }

constructor TDSData.Create;
begin
  fDSStaticSize := -1;
end;

function TDSData.DSCount: Word;
begin
  Result := Word(Length(TOC));
end;

function TDSData.DSStaticSize: Word;
var
  i : integer;
  X : DSTocEntry;
begin
  if fDSStaticSize = -1 then
  begin
    // the maximum address in toc + the size in bytes
    fDSStaticSize := 0;
    for i := 0 to Length(TOC) - 1 do
    begin
      X := TOC[i];
      if X.DataDesc >= fDSStaticSize then
      begin
        fDSStaticSize := LongInt(X.DataDesc) + LongInt(BytesPerType[TDSType(X.TypeDesc)]);
      end;
    end;
    fDSStaticSize := Integer(RoundToByteSize(Word(fDSStaticSize), DWORD_LEN));
  end;
  Result := Word(fDSStaticSize);
end;

function TDSData.DVArrayOffset: Word;
begin
  Result := DopeVecs[0].offset;
end;

function TDSData.DynDSDefaultsOffset: Word;
begin
  Result := Word(Length(StaticDefaults));
end;

function TDSData.DynDSDefaultsSize: Word;
begin
  Result := Word((DVArrayOffset - DSStaticSize) + (Length(DopeVecs)*SizeOf(DopeVector)));
end;

procedure TDSData.SaveToStream(aStream: TStream);
var
  i, len, sBytes : integer;
  B : Byte;
begin
  // dataspace table of contents
  for i := 0 to Length(TOC) - 1 do
  begin
    with TOC[i] do
    begin
      aStream.Write(TypeDesc, 1);
      aStream.Write(Flags, 1);
      WriteWordToStream(aStream, DataDesc);
    end;
  end;

  // static default data
  sBytes := DynDSDefaultsOffset;
  i := 0;
  len := Length(StaticDefaults);
  while i < sBytes do
  begin
    if i < len then
      B := StaticDefaults[i]
    else
      B := $FF;
    aStream.Write(B, SizeOf(Byte));
    inc(i);
  end;

  // dynamic default data
  for i := 0 to Length(DynamicDefaults) - 1 do
    aStream.Write(DynamicDefaults[i], SizeOf(Byte));

  // dope vectors
  for i := 0 to Length(DopeVecs) - 1 do
  begin
    with DopeVecs[i] do
    begin
      WriteWordToStream(aStream, offset);
      WriteWordToStream(aStream, elemsize);
      WriteWordToStream(aStream, count);
      WriteWordToStream(aStream, backptr);
      WriteWordToStream(aStream, link);
    end;
  end;

  // pad to even boundary at the end of the dataspace if needed
  if (sBytes mod 2) > 0 then
  begin
    B := $FF;
    aStream.Write(B, SizeOf(Byte));
  end;
end;

procedure TDSData.SaveToSymbolTable(aStrings: TStrings);
var
  i : integer;
  X : DSTOCEntry;
begin
  aStrings.Add('#SYMBOLS');
  aStrings.Add('Index'#9'Identifier'#9'Type'#9'Flag'#9'Data'#9'Size'#9'RefCount');
  for i := 0 to DSCount - 1 do
  begin
    X := TOC[i];
    aStrings.Add(Format('%d'#9'%s'#9'%d'#9'%d'#9'%d'#9'%d'#9'%d',
      [i, TOCNames[i], X.TypeDesc, X.Flags, X.DataDesc, X.Size, X.RefCount]));
  end;
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
    WriteWordToStream(aStream, Code[i]);
  end;
end;

{ TClumpData }

procedure TClumpData.SaveToStream(aStream: TStream);
var
  i : integer;
  B : byte;
begin
  // clump records
  for i := 0 to Length(CRecs) - 1 do
  begin
    aStream.Write(CRecs[i].FireCount, 1);
    aStream.Write(CRecs[i].DependentCount, 1);
    WriteWordToStream(aStream, CRecs[i].CodeStart);
  end;
  // clump dependencies
  for i := 0 to Length(ClumpDeps) - 1 do
  begin
    aStream.Write(ClumpDeps[i], SizeOf(Byte));
  end;
  if Length(ClumpDeps) mod 2 <> 0 then
  begin
    B := $FF;
    aStream.Write(B, 1);
  end;
end;

{ TCardinalObject }

constructor TCardinalObject.Create(aValue: Cardinal);
begin
  fValue := aValue;
end;

{ TIntegerObject }

constructor TIntegerObject.Create(aValue: Integer);
begin
  fValue := aValue;
end;

{ EDuplicateDataspaceEntry }

constructor EDuplicateDataspaceEntry.Create(DE : TDataspaceEntry);
begin
  inherited Create(Format(sDuplicateDSEntry, [DE.FullPathIdentifier]));
end;

end.
