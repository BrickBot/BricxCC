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
unit uCompCommon;

interface

uses
  Classes, Contnrs, SysUtils, Parser10;

type
  TDSType = (dsVoid, dsUByte, dsSByte, dsUWord, dsSWord, dsULong, dsSLong,
    dsArray, dsCluster, dsMutex, dsFloat);

const
  BytesPerType : array[TDSType] of Byte = (4, 1, 1, 2, 2, 4, 4, 2, 4, 4, 4);
  DWORD_LEN = 4;
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

type
  DSTocEntry = record
    TypeDesc : Byte;
    Flags : Byte;
    DataDesc: Word;
    Size : Word;
    RefCount: Word;
  end;

  TCompilerStatusChangeEvent = procedure(Sender : TObject; const StatusMsg : string; const bDone : boolean) of object;
  TLangName = (lnNBC, lnNXC, lnNXCHeader, lnRICScript, lnSPC, lnEVC, lnEVA, lnUnknown);
  TOnCompilerMessage = procedure(const msg : string; var stop : boolean) of object;

  TNXTFileType = (nftProgram, nftGraphics, nftSound, nftData, nftOther, nftFirmware);
  TEV3FileType = (eftProgram, eftGraphics, eftSound, eftData, eftOther, eftFirmware);

  TMapList = class(TStringList)
  private
    fConsiderCase: boolean;
    function GetMapValue(index: integer): string;
    procedure SetConsiderCase(const AValue: boolean);
    procedure SetMapValue(index: integer; const Value: string);
  protected
{$IFDEF FPC}
    function DoCompareText(const s1,s2 : string) : PtrInt; override;
{$ENDIF}
  public
    constructor Create;
    function  AddEntry(const aName, aValue : string) : integer;
    procedure AddDefines(aValue : TStrings);
    procedure Define(const aName : string);
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    property MapValue[index : integer] : string read GetMapValue write SetMapValue;
    property ConsiderCase : boolean read fConsiderCase write SetConsiderCase;
  end;

  TCCExpParser = class(TExpParser)
  private
    fBasicDefs: boolean;
    fStandardDefs: boolean;
    fExtraDefs: boolean;
    fFirmwareVersion: word;
    procedure SetBasicDefs(const aValue: boolean);
    procedure SetStandardDefs(const aValue: boolean);
    procedure SetExtraDefs(const aValue: boolean);
    procedure SetFirmwareVersion(const aValue: word);
  protected
    procedure InitializeCalc; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    property BasicDefines : boolean read fBasicDefs write SetBasicDefs;
    property StandardDefines : boolean read fStandardDefs write SetStandardDefs;
    property ExtraDefines : boolean read fExtraDefs write SetExtraDefs;
    property FirmwareVersion : word read fFirmwareVersion write SetFirmwareVersion;
  end;

  EPreprocessorException = class(Exception)
  private
    fLineNo : integer;
    fLinePos : integer;
  public
    constructor Create(const msg : string; const lineno : integer);
    property LineNo : integer read fLineNo;
    property LinePos : integer read fLinePos;
  end;

  TDSBase = class;

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
    function GetSizeOf: integer;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure SaveToStream(aStream : TStream);
    procedure SaveToStrings(aStrings : TStrings; bDefine : boolean = false;
      bInCluster : boolean = false);
    procedure LoadFromStream(aStream : TStream);
    procedure AddValue(aValue : Cardinal);
    function AddValuesFromString(Calc : TCCExpParser; sargs : string) : TDSType;
    function  ValueCount : Word;
    function  ArrayElementSize(bPad : boolean = true) : Word;
    function  ElementSize(bPad : boolean = true) : Word;
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
    property SizeOf : integer read GetSizeOf;
  end;

  TDSBaseSortCompare = function(List: TDSBase; Index1, Index2: Integer): Integer;

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

  EDuplicateDataspaceEntry = class(Exception)
  public
    constructor Create(DE : TDataspaceEntry);
  end;

  TSTTFuncType = function(const stype : string; bUseCase : Boolean = false) : TDSType;

  
function RootOf(const name: string): string;

function NameToNXTFileType(name : string) : TNXTFileType;
function NameToEV3FileType(name : string) : TEV3FileType;

function CCStrToFloat(const AValue: string): Double;
function CCStrToFloatDef(const AValue: string; const aDef : Double): Double;
//function CCTextToFloat(Buffer: PChar; var Value; ValueType: TFloatValue): Boolean;
function CCFormat(const FmtStr: string; const theArgs: array of const) : string;
function CCFloatToStr(const AValue: Double): string;
function CCStrToInt64Def(const AValue: string; const aDef : Int64): Int64;

function GetArgDataType(val : Extended): TDSType;
function ValueOutside64BitRange(aValue : Extended) : boolean;
function QuotedString(const sargs : string) : boolean;
function RoundToByteSize(addr : Word; size : byte) : Word;

function TypeToStr(const TypeDesc : byte) : string; overload;
function TypeToStr(const aType : TDSType) : string; overload;

procedure InstantiateCluster(DD : TDataDefs; DE: TDataspaceEntry; const clustername: string);
procedure HandleVarDecl(DD : TDataDefs; NT : TMapList; bCaseSensitive : boolean;
  DSE : TDataspaceEntry; albl, aopcode : string; sttFunc : TSTTFuncType);


var
  MaxStackDepth : integer;

implementation

uses
{$IFDEF FAST_MM}
  FastStrings,
{$ENDIF}
  StrUtils,
  Math,
  uCommonUtils,
  uUtilities,
  uStreamRW,
  uLocalizedStrings;

const
  STR_TRUE  = 'TRUE';
  STR_FALSE = 'FALSE';
  STR_OUT_A = 'OUT_A';
  STR_OUT_B = 'OUT_B';
  STR_OUT_C = 'OUT_C';
  STR_OUT_D = 'OUT_D';
  OUT_A = $00;
  OUT_B = $01;
  OUT_C = $02;
  OUT_D = $03;
  STR_IN_1 = 'IN_1';
  STR_IN_2 = 'IN_2';
  STR_IN_3 = 'IN_3';
  STR_IN_4 = 'IN_4';
  IN_1 = $00;
  IN_2 = $01;
  IN_3 = $02;
  IN_4 = $03;
  
type
  TCardinalObject = class
  protected
    fValue : Cardinal;
  public
    constructor Create(aValue : Cardinal);
    property Value : Cardinal read fValue;
  end;

function RootOf(const name: string): string;
var
  p : integer;
begin
  p := Pos('.', name);
  if p > 0 then
    Result := Copy(name, 1, p-1)
  else
    Result := name;
end;

function NameToNXTFileType(name : string) : TNXTFileType;
var
  ext : string;
begin
  Result := nftOther;
  ext := AnsiLowercase(ExtractFileExt(name));
  if (ext = '.rso') or (ext = '.rmd') then
    Result := nftSound
  else if ext = '.rdt' then
    Result := nftData
  else if (ext = '.ric') then
    Result := nftGraphics
  else if (ext = '.rxe') or (ext = '.sys') or (ext = '.rtm') then
    Result := nftProgram
end;

function NameToEV3FileType(name : string) : TEV3FileType;
var
  ext : string;
begin
  Result := eftOther;
  ext := AnsiLowercase(ExtractFileExt(name));
  if (ext = '.rsf') then
    Result := eftSound
  else if (ext = '.rgf') then
    Result := eftGraphics
  else if (ext = '.rbf') then
    Result := eftProgram
end;

procedure CCFormatSettings(var aFS : TFormatSettings; const aDS : Char);
begin
  aFS.DecimalSeparator  := aDS;
  aFS.ThousandSeparator := #0;
  aFS.CurrencyFormat    := 0;
  aFS.NegCurrFormat     := 0;
  aFS.CurrencyDecimals  := 2;
  aFS.CurrencyString    := '$';
end;

function CCFloatToStr(const AValue: Double): string;
begin
  Result := StripTrailingZeros(CCFormat('%.10f', [AValue]));
end;

function CCStrToFloat(const AValue: string): Double;
var
  FS : TFormatSettings;
begin
  FS.DecimalSeparator := '.';
  CCFormatSettings(FS, '.');
  Result := StrToFloat(AValue, FS);
end;

function CCStrToFloatDef(const AValue: string; const aDef : Double): Double;
var
  FS : TFormatSettings;
begin
  FS.DecimalSeparator := '.';
  CCFormatSettings(FS, '.');
  Result := StrToFloatDef(AValue, aDef, FS);
end;

(*
function CCTextToFloat(Buffer: PChar; var Value; ValueType: TFloatValue): Boolean;
var
  FS : TFormatSettings;
  val : Extended;
begin
  FS.DecimalSeparator := '.';
  CCFormatSettings(FS, '.');
  Result := TextToFloat(Buffer, val, ValueType, FS);
  Extended(Value) := 0;
end;
*)

function CCFormat(const FmtStr: string; const theArgs: array of const) : string;
var
  FS : TFormatSettings;
begin
  FS.DecimalSeparator := '.';
  CCFormatSettings(FS, '.');
  Result := Format(FmtStr, theArgs, FS);
end;

function CCStrToInt64Def(const AValue: string; const aDef : Int64): Int64;
begin
  if Pos('0b', AValue) = 1 then
  begin
    Result := BinToIntDef(Copy(AValue, 3, MaxInt), Integer(aDef));
  end
  else
    Result := StrToInt64Def(AValue, aDef);
end;

function GetArgDataType(val : Extended): TDSType;
var
  iVal : Int64;
begin
  if ValueOutside64BitRange(val) then
  begin
     Result := dsFloat;
  end
  else
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
  end;
end;

function ValueOutside64BitRange(aValue : Extended) : boolean;
begin
  Result := (aValue > High(Int64)) or (aValue < Low(Int64));
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

function RoundToByteSize(addr : Word; size : byte) : Word;
var
  x : Word;
begin
  x := Word(addr mod size);
  if x <> 0 then
    Result := Word(addr + size - x)
  else
    Result := addr;
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

function TypeToStr(const aType : TDSType) : string;
begin
  Result := TypeToStr(Byte(Ord(aType)));
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
      dsFloat : Result := CCFloatToStr(CardinalToSingle(aVal));
    else
      Result := '???';
    end;
end;

{ TCCExpParser }

constructor TCCExpParser.Create(AOwner: TComponent);
begin
  inherited;
  fFirmwareVersion := 100;
  fExtraDefs := False;
  fStandardDefs := False;
  fBasicDefs := True;
  InitializeCalc;
end;

procedure TCCExpParser.InitializeCalc;
begin
  ClearVariables;
  if BasicDefines then
  begin
    SetVariable(STR_FALSE, Ord(false));
    SetVariable(STR_TRUE, Ord(true));
    SetVariable(STR_OUT_A, OUT_A);
    SetVariable(STR_OUT_B, OUT_B);
    SetVariable(STR_OUT_C, OUT_C);
    SetVariable(STR_OUT_D, OUT_D);
    SetVariable(STR_IN_1, IN_1);
    SetVariable(STR_IN_2, IN_2);
    SetVariable(STR_IN_3, IN_3);
    SetVariable(STR_IN_4, IN_4);
  end;
end;

procedure TCCExpParser.SetBasicDefs(const aValue: boolean);
begin
  if fBasicDefs <> aValue then
  begin
    fBasicDefs := aValue;
    InitializeCalc;
  end;
end;

procedure TCCExpParser.SetExtraDefs(const aValue: boolean);
begin
  if fExtraDefs <> aValue then
  begin
    fExtraDefs := aValue;
    InitializeCalc;
  end;
end;

procedure TCCExpParser.SetFirmwareVersion(const aValue: word);
begin
  if fFirmwareVersion <> aValue then
  begin
    fFirmwareVersion := aValue;
    InitializeCalc;
  end;
end;

procedure TCCExpParser.SetStandardDefs(const aValue: boolean);
begin
  if fStandardDefs <> aValue then
  begin
    fStandardDefs := aValue;
    InitializeCalc;
  end;
end;

{ TMapList }

type
  TStrObj = class(TObject)
  public
    Value : string;
  end;

function TMapList.AddEntry(const aName, aValue: string): integer;
var
  obj : TStrObj;
begin
  Result := IndexOf(aName);
  if Result = -1 then
  begin
    obj := TStrObj.Create;
    Result := AddObject(aName, obj);
    obj.Value := aValue;
  end;
end;

procedure TMapList.Clear;
var
  i : integer;
begin
  for i := 0 to Count - 1 do
    Objects[i].Free;
  inherited;
end;

constructor TMapList.Create;
begin
  inherited;
  CaseSensitive := True;
  ConsiderCase  := True;
  Sorted := True;
  Duplicates := dupIgnore;
end;

procedure TMapList.Delete(Index: Integer);
begin
  Objects[Index].Free;
  Objects[Index] := nil;
  inherited;
end;

function TMapList.GetMapValue(index: integer): string;
begin
  Result := TStrObj(Objects[index]).Value;
end;

procedure TMapList.SetMapValue(index: integer; const Value: string);
begin
  TStrObj(Objects[index]).Value := Value;
end;

procedure TMapList.SetConsiderCase(const AValue: boolean);
begin
  if fConsiderCase=AValue then exit;
  fConsiderCase:=AValue;
  if Sorted then
    Sort;
end;

{$IFDEF FPC}
function TMapList.DoCompareText(const s1, s2: string): PtrInt;
begin
  if CaseSensitive or ConsiderCase then
    result := AnsiCompareStr(s1,s2)
  else
    result := AnsiCompareText(s1,s2);
end;
{$ENDIF}

procedure TMapList.AddDefines(aValue: TStrings);
var
  i : integer;
begin
  for i := 0 to aValue.Count - 1 do
    AddEntry(aValue.Names[i], aValue.ValueFromIndex[i]);
end;

procedure TMapList.Define(const aName: string);
begin
  AddEntry(aName, '1');
end;

{ EPreprocessorException }

constructor EPreprocessorException.Create(const msg: string;
  const lineno: integer);
begin
  inherited Create(msg);
  fLineNo := lineno;
  fLinePos := 0;
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
  if (aDST = dsFloat) or ValueOutside64BitRange(aValue) then
  begin
    sVal := aValue;
    Result := SingleToCardinal(sVal);
  end
  else
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

function TDataspaceEntry.AddValuesFromString(Calc : TCCExpParser; sargs: string) : TDSType;
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
          3 : AddValue(9);  // tab
          4 : AddValue(10); // lf
          5 : AddValue(13); // cr
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

function TDataspaceEntry.ElementSize(bPad : boolean) : Word;
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
        bpt := DE.ElementSize(bPad); // 2006-10-02 JCH recursively calculate the element size
        // this fixes a problem with the size of arrays containing nested aggregate types
        if bPad then
        begin
          padBytes := bpt - (Result mod bpt);
          if padBytes < bpt then
          begin
            Result := Word(Result + padBytes);
          end;
        end;
        Result := Word(Result + bpt);
      end;
      if bPad then
        Result := RoundToByteSize(Result, DWORD_LEN);
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

function TDataspaceEntry.ArrayElementSize(bPad : boolean) : Word;
begin
  Result := 0;
  if DataType <> dsArray then Exit;
  if SubEntries[0].DataType = dsArray then
    Result := 2
  else
    Result := SubEntries[0].ElementSize(bPad);
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
        if not (Values[i] in [9, 10, 13, 32..126]) then
//        if (Values[i] < 32) or (Values[i] > 126) then
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
          '"', '''', '\' : Result := Result + '\' + x;
          #9 : Result := Result + '\t';
          #10 : Result := Result + '\n';
          #13 : Result := Result + '\r';
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
  ReadWord(aStream, X.DataDesc);
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
  WriteWord(aStream, X.DataDesc);
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

function TDataspaceEntry.GetSizeOf: integer;
var
  i : integer;
  sub : TDataspaceEntry;
begin
  if DataType = dsCluster then
  begin
    Result := 0;
    for i := 0 to SubEntries.Count - 1 do
    begin
      sub := SubEntries[i];
      Result := Result + sub.SizeOf;
    end;
  end
  else if DataType = dsArray then
  begin
    Result := 2; // TODO: fix this to properly calculate the size of an array
  end
  else
    Result := 1; // base size is 1
end;

{ EDuplicateDataspaceEntry }

constructor EDuplicateDataspaceEntry.Create(DE : TDataspaceEntry);
begin
  inherited Create(Format(sDuplicateDSEntry, [DE.FullPathIdentifier]));
end;

{ TCardinalObject }

constructor TCardinalObject.Create(aValue: Cardinal);
begin
  fValue := aValue;
end;

end.