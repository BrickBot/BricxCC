{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License Version
1.1 (the "License"); you may not use this file except in compliance with the
License. You may obtain a copy of the License at
http://www.mozilla.org/NPL/NPL-1_1Final.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: mwGenericLex.pas, released April, 2001.

The Initial Developer of the Original Code is Martin Waldenburg
(Martin.Waldenburg@T-Online.de).
Portions created by Martin Waldenburg are Copyright (C) 2001 Martin Waldenburg.
All Rights Reserved.

Contributor(s): _____________________________________.


Last Modified: mm/dd/yyyy
Current Version: 0.9

Notes: This program is a fast generic scriptable lexical analyser.

Modification history:

Known Issues:
-----------------------------------------------------------------------------}
{$A+,B-,C-,D-,E-,I+,J-,O+,Q-,R-,S-,V-}
unit mwGenericLex;

{$IFDEF FPC}
{$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes;

const
  piAtEnd = High(Word);
  piZero = High(Word) - 1;
  piUnknown = High(Word) - 2;
  piSymbol = 0;
  piSpace = 1;
  piLineEnd = 2;
  piInnerLineEnd = 3;
  piIdent = 4;
  piKeyWord = 5;
  piString = 6;
  piComment = 7;
  piNumber = 8;
  piAssembler = 9;
  piBadString = 10;
  piDirective = 11;
  piChar = 12;
  piBadChar = 13;



type
  TAny = class;
  TmwGenLex = class;

  TmwLexInitProc = procedure(Lex: TmwGenLex);
  TmwLexInitMethod = procedure(Lex: TmwGenLex) of object;

  TmwCharClass = set of Char;
  PmwChars = ^TmwChars;
  TmwChars = record
    Chars: TmwCharClass;
  end;

  TAnyKind = (
    pkAny,
    pkChar,
    pkCharClass,
    pkInnerLineEnd,
    pkKey,
    pkLineEnd,
    pkTillChars,
    pkTillKey
    );

  TAnyStatus = (
    psMultiLine,
    psNegative,
    psProcessingNeeded,
    psRegress
    );

  TAnyStorage = packed record
    Count: Byte;
    Kind: TAnyKind;
    Status: set of TAnyStatus;
    Min: Byte;
    Id: Word;
    ExId: Word;
    Max: Word;
  end;

  PmwOptionsList = ^TmwOptionsList;
  TmwOptionsList = array[0..0] of TAny;

  TAny = class(TPersistent)
  private
    fOptionsList: PmwOptionsList;
    fToRegress: TAny;
    FKey: string;
    FFollow: TAny;
    function GetNodes(Index: Byte): TAny;
    function GetMultiLine: Boolean;
    function GetNegative: Boolean;
    function GetProcessingNeeded: Boolean;
    procedure SetMultiLine(const Value: Boolean);
    procedure SetNegative(const Value: Boolean);
    procedure SetProcessingNeeded(const Value: Boolean);
    procedure SetKey(const Value: string);
    procedure SetCharClass(const Value: TmwCharClass);
    function GetCharClass: TmwCharClass;
    function GetRegress: Boolean;
    procedure SetRegress(const Value: Boolean);
  protected
    Storage: TAnyStorage;
    ToRestore: TAny;
  public
    constructor Create(AParent: TAny); virtual;
    destructor Destroy; override;
    function AddOption(const Value: TAny): Integer;
    function IndexOf(const Any: TAny): Integer;
    property CharClass: TmwCharClass read GetCharClass write SetCharClass;
    property Count: Byte read Storage.Count;
    property Options[Index: Byte]: TAny read GetNodes; default;
    property ToRegress: TAny read fToRegress write FToRegress;
  published
    property ExId: Word read Storage.ExId write Storage.ExId;
    property Follow: TAny read FFollow write FFollow;
    property Id: Word read Storage.Id write Storage.Id;
    property Max: Word read Storage.Max write Storage.Max;
    property Min: Byte read Storage.Min write Storage.Min;
    property Key: string read FKey write SetKey;
    property Kind: TAnyKind read Storage.Kind write Storage.Kind;
    property MultiLine: Boolean read GetMultiLine write SetMultiLine;
    property Negative: Boolean read GetNegative write SetNegative;
    property ProcessingNeeded: Boolean read GetProcessingNeeded write SetProcessingNeeded;
    property Regress: Boolean read GetRegress write SetRegress;
  end;

  TLineEnd = class(TAny)
  public
    constructor Create(AParent: TAny); override;
  end;

  TAlpha = class(TAny)
  public
    constructor Create(AParent: TAny); override;
  end;

  TAlphaNumeric = class(TAny)
  public
    constructor Create(AParent: TAny); override;
  end;

(*
  TCharAlpha = class(TAny)
  public
    constructor Create(AParent: TAny); override;
  end;

  TCharAlphaNumeric = class(TAny)
  public
    constructor Create(AParent: TAny); override;
  end;

  TCharLower = class(TAny)
  public
    constructor Create(AParent: TAny); override;
  end;

  TCharUpper = class(TAny)
  public
    constructor Create(AParent: TAny); override;
  end;
*)

  TIdentifier = class(TAlpha)
  public
    constructor Create(AParent: TAny); override;
  end;

  TCRLF = class(TAny)
  public
    constructor Create(AParent: TAny); override;
  end;

  TLF = class(TAny)
  public
    constructor Create(AParent: TAny); override;
  end;

  TNotZero = class(TAny)
  public
    constructor Create(AParent: TAny); override;
  end;

  TNumeric = class(TAny)
  public
    constructor Create(AParent: TAny); override;
  end;

  TTill = class(TAny)
  public
    constructor Create(AParent: TAny); override;
  end;

  TTillChars = class(TAny)
  public
    constructor Create(AParent: TAny); override;
  end;

  TTillLineEnd = class(TAny)
  public
    constructor Create(AParent: TAny); override;
  end;

  TZero = class(TAny)
  public
    constructor Create(AParent: TAny); override;
  end;

  TmwGenLex = class(TPersistent)
  private
    FChain: TList;
    FCurrent: TAny;
    FSensitive: Boolean;
    FInitMethod: TmwLexInitMethod;
    FInitProc: TmwLexInitProc;
    FRange: TAny;
    FOrigin: PChar;
    FProcessingNeeded: Boolean;
    function ApplyAny: Boolean;
    function ApplyChar: Boolean;
    function ApplyCharClass: Boolean;
    function ApplyInnerLineEnd: Boolean;
    function ApplyKey: Boolean;
    function ApplyLineEnd: Boolean;
    function ApplyTillChars: Boolean;
    function ApplyTillKey: Boolean;
    function GetToken: string;
    procedure SetInitMethod(const Value: TmwLexInitMethod);
    procedure SetInitProc(const Value: TmwLexInitProc);
    procedure SetInput(const Value: string);
    procedure SetOrigin(const Value: PChar);
    function GetRunPos: Integer;
    procedure SetRunPos(const Value: Integer);
    function GetEndPos: Integer;
    procedure SetEndPos(const Value: Integer);
    function SubNext: Boolean;
    function GetLinePos: Integer;
  protected
    fLineCount : Longint;
    FExId: Word;
    FId: Word;
    Run: PChar;
    Start: PChar;
    TheEnd: PChar;
    InnerLineEnd: TAny;
    MainSelector: array[#0..#255] of TAny;
    Selector: array[Low(TAnyKind)..High(TAnyKind)] of function: Boolean of object;
    procedure AddToMainSelector(Pattern: TAny);
    procedure Clear;
    function Execute: Boolean;
    procedure InitMainSelector;
    procedure InitSelector;
    property Current: TAny read FCurrent write FCurrent;
    property Chain: TList read FChain write FChain;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(Pattern: TAny);
    function AtEnd: Boolean;
    procedure Next;
    procedure SetStartData(Ptr: Pointer; aLen: Integer);
    property EndPos: Integer read GetEndPos write SetEndPos;
    property Id: Word read FId;
    property ExId: Word read FExId;
    property Input: string write SetInput;
    property Origin: PChar read FOrigin write SetOrigin;
    property ProcessingNeeded: Boolean read FProcessingNeeded;
    property Range: TAny read FRange write FRange;
    property RunPos: Integer read GetRunPos write SetRunPos;
    property LinePos : Integer read GetLinePos;
    property Sensitive: Boolean read FSensitive write FSensitive;
    property Token: string read GetToken;
    property InitProc: TmwLexInitProc read FInitProc write SetInitProc;
    property InitMethod: TmwLexInitMethod read FInitMethod write SetInitMethod;
  end;

implementation

uses
  SysUtils;

var
  CompTable: array[#0..#255] of Char;

procedure InitTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    CompTable[I] := AnsiUpperCase(I)[1];
end;

{ TAny }

function TAny.AddOption(const Value: TAny): Integer;
begin
  Result := -1;
  if Assigned(Value) then
  begin
    Result := Storage.Count;
    inc(Storage.Count);
    ReallocMem(fOptionsList, Storage.Count * SizeOf(TAny));
    fOptionsList^[Result] := Value;
  end;
end;

constructor TAny.Create(AParent: TAny);
begin
  inherited Create;
  if Assigned(AParent) then AParent.Follow := Self;
end;

destructor TAny.Destroy;
var
  I: Integer;
begin
  if Assigned(Follow) then Follow.Free;
  for I := 0 to Storage.Count - 1 do
    fOptionsList^[I].Free;
  ReallocMem(fOptionsList, 0);
  inherited Destroy;
end;

function GetIt(const C): TmwCharClass;
begin
  Result := TmwCharClass(C);
end;

function TAny.GetCharClass: TmwCharClass;
begin
  Result := PmwChars(FKey).Chars;
end;

function TAny.GetMultiLine: Boolean;
begin
  Result := psMultiLine in Storage.Status;
end;

function TAny.GetNegative: Boolean;
begin
  Result := psNegative in Storage.Status;
end;

function TAny.GetNodes(Index: Byte): TAny;
begin
  Result := nil;
  if Index < Storage.Count then Result := fOptionsList^[Index];
end;

function TAny.GetProcessingNeeded: Boolean;
begin
  Result := psProcessingNeeded in Storage.Status;
end;

function TAny.GetRegress: Boolean;
begin
  Result := psRegress in Storage.Status;
end;

function TAny.IndexOf(const Any: TAny): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if FOptionsList[I] = Any then
    begin
      Result := I;
      break;
    end;
end;

procedure TAny.SetCharClass(const Value: TmwCharClass);
begin
  SetLength(FKey, 32);
  PmwChars(FKey).Chars := Value;
  Storage.Kind := pkCharClass;
end;

procedure TAny.SetKey(const Value: string);
begin
  FKey := Value;
  case Storage.Kind of
    pkTillChars: ;
  else
    if Length(Value) > 1 then
      Storage.Kind := pkKey
    else
      if Length(Value) = 1 then
        Storage.Kind := pkChar
      else
        Storage.Kind := pkAny;
  end;
end;

procedure TAny.SetMultiLine(const Value: Boolean);
begin
  case Value of
    True: Include(Storage.Status, psMultiLine);
    False: Exclude(Storage.Status, psMultiLine);
  end;
end;

procedure TAny.SetNegative(const Value: Boolean);
begin
  case Value of
    True: Include(Storage.Status, psNegative);
    False: Exclude(Storage.Status, psNegative);
  end;
end;

procedure TAny.SetProcessingNeeded(const Value: Boolean);
begin
  case Value of
    True: Include(Storage.Status, psProcessingNeeded);
    False: Exclude(Storage.Status, psProcessingNeeded);
  end;
end;

procedure TAny.SetRegress(const Value: Boolean);
begin
  case Value of
    True: Include(Storage.Status, psRegress);
    False: Exclude(Storage.Status, psRegress);
  end;
end;

{ TLineEnd }

constructor TLineEnd.Create(AParent: TAny);
var
  Pattern, Option: TAny;
begin
  inherited Create(AParent);
  Key := #13;
  Max := 1;
  Option := TAny.Create(nil);
  Option.Key := #10;
  Option.Min := 1;
  AddOption(Option);
  Pattern := TAny.Create(Self);
  Pattern.Key := #10;
  Pattern.Max := 1;
end;

{ TCRLF }

constructor TCRLF.Create(AParent: TAny);
begin
  inherited Create(AParent);
  Key := #13#10;
  Min := 1;
  Max := 1;
end;

{ TLF }

constructor TLF.Create(AParent: TAny);
begin
  inherited Create(AParent);
  Key := #10;
  Min := 1;
  Max := 1;
end;

{ TNotZero }

constructor TNotZero.Create(AParent: TAny);
begin
  inherited Create(AParent);
  Storage.Kind := pkCharClass;
  CharClass := [#0];
  Negative := True;
end;

{ TTill }

constructor TTill.Create(AParent: TAny);
begin
  inherited Create(AParent);
  Storage.Kind := pkTillKey;
end;

{ TTillChars }

constructor TTillChars.Create(AParent: TAny);
begin
  inherited Create(AParent);
  Storage.Kind := pkTillChars;
end;

{ TTillLineEnd }

constructor TTillLineEnd.Create(AParent: TAny);
begin
  inherited Create(AParent);
  Storage.Kind := pkTillChars;
  CharClass := [#10, #13];
  Negative := True;
end;

{ TZero }

constructor TZero.Create(AParent: TAny);
begin
  inherited Create(AParent);
  Key := #0;
  Id := piZero;
end;

{ TAlpha }

constructor TAlpha.Create(AParent: TAny);
begin
  inherited Create(AParent);
  Min := 1;
  Id := piIdent;
  Storage.Kind := pkCharClass;
  CharClass := ['_', 'A'..'Z', 'a'..'z'];
end;

{ TAlphaNumeric }

constructor TAlphaNumeric.Create(AParent: TAny);
begin
  inherited Create(AParent);
  Min := 1;
  Id := piIdent;
  Storage.Kind := pkCharClass;
  CharClass := ['_', '0'..'9', 'A'..'Z', 'a'..'z'];
end;

{ TNumeric }

constructor TNumeric.Create(AParent: TAny);
begin
  inherited Create(AParent);
  Min := 1;
  Storage.Kind := pkCharClass;
  CharClass := ['0'..'9'];
end;

{ TIdentifier }

constructor TIdentifier.Create(AParent: TAny);
begin
  inherited Create(AParent);
  TAlphaNumeric.Create(Self);
end;

(*
{ TCharAlpha }

constructor TCharAlpha.Create(AParent: TAny);
var
  I: Char;
begin
  inherited Create(AParent);
  Storage.Kind := pkCharClass;
  SetLength(FKey, 32);
  for I := #0 to #255 do
    if IsCharAlpha(I) then Include(PmwChars(FKey).Chars, I);
end;

{ TCharAlphaNumeric }

constructor TCharAlphaNumeric.Create(AParent: TAny);
var
  I: Char;
begin
  inherited Create(AParent);
  Storage.Kind := pkCharClass;
  SetLength(FKey, 32);
  for I := #0 to #255 do
    if IsCharAlphaNumeric(I) then Include(PmwChars(FKey).Chars, I);
end;

{ TCharLower }

constructor TCharLower.Create(AParent: TAny);
var
  I: Char;
begin
  inherited Create(AParent);
  Storage.Kind := pkCharClass;
  SetLength(FKey, 32);
  for I := #0 to #255 do
    if IsCharLower(I) then Include(PmwChars(FKey).Chars, I);
end;

{ TCharUpper }

constructor TCharUpper.Create(AParent: TAny);
var
  I: Char;
begin
  inherited Create(AParent);
  Storage.Kind := pkCharClass;
  SetLength(FKey, 32);
  for I := #0 to #255 do
    if IsCharUpper(I) then Include(PmwChars(FKey).Chars, I);
end;
*)

{ TmwGenLex }

procedure TmwGenLex.Add(Pattern: TAny);
var
  I: Integer;
begin
  FChain.Add(Pattern);
  AddToMainSelector(Pattern);
  for I := 0 to Pattern.Count - 1 do
    AddToMainSelector(Pattern[Byte(I)]);
end;

procedure TmwGenLex.AddToMainSelector(Pattern: TAny);
var
  I: Char;
begin
  case Pattern.Kind of
    pkAny, pkTillChars, pkTillKey:
      raise exception.Create('pkAny, pkTillChars, pkTillKey not allowed here');
    pkCharClass:
      for I := #0 to #255 do
        case Pattern.Negative of
          True:
            if not (I in Pattern.CharClass) then
              MainSelector[Char(I)] := Pattern;
          False:
            if I in Pattern.CharClass then
              MainSelector[I] := Pattern;
        end;
    pkLineEnd:
      begin
        MainSelector[#10] := Pattern;
        MainSelector[#13] := Pattern;
      end;
  else
    if Length(Pattern.Key) > 0 then
      MainSelector[Pattern.Key[1]] := Pattern;
  end;
end;

function TmwGenLex.ApplyAny: Boolean;
begin
  Range := nil;
  Result := True;
  if Run >= TheEnd then
  begin
    Result := False;
    exit;
  end;
  inc(Run);
end;

function TmwGenLex.ApplyChar: Boolean;
var
  Temp: PChar;
begin
  Range := nil;
  Temp := Run;
  case psNegative in Current.Storage.Status of
    True:
      case Sensitive of
        True: if Current.Key <> Run^ then
          begin
            if Run >= TheEnd then
            begin
              Result := False;
              exit;
            end;
            inc(Run)
          end;
        False: if CompTable[Current.Key[1]] <> CompTable[Run^] then
          begin
            if Run >= TheEnd then
            begin
              Result := False;
              exit;
            end;
            inc(Run)
          end;
      end;
    False:
      case Sensitive of
        True: if Current.Key = Run^ then
          begin
            if Run >= TheEnd then
            begin
              Result := False;
              exit;
            end;
            inc(Run)
          end;
        False: if CompTable[Current.Key[1]] = CompTable[Run^] then
          begin
            if Run >= TheEnd then
            begin
              Result := False;
              exit;
            end;
            inc(Run)
          end;
      end;
  end;
  Result := Run - Temp = 1;
end;

function TmwGenLex.ApplyCharClass: Boolean;
var
  Temp: PChar;
begin
  Range := nil;
  Temp := Run;
  case psNegative in Current.Storage.Status of
    True:
      if Current.Max > 0 then
      begin
        if not (Run^ in PmwChars(Current.FKey).Chars) then
          if not AtEnd then inc(Run)
      end else
        while not (Run^ in PmwChars(Current.FKey).Chars) do
        begin
          if Run >= TheEnd then break;
          inc(Run);
        end;
    False:
      if Current.Max > 0 then
      begin
        if Run^ in PmwChars(Current.FKey).Chars then
          if not AtEnd then inc(Run)
      end else
        while Run^ in PmwChars(Current.FKey).Chars do
        begin
          if Run >= TheEnd then break;
          inc(Run);
        end;
  end;
  Result := Run > Temp;
end;

function TmwGenLex.ApplyInnerLineEnd: Boolean;
begin
  Result := True;
  case Run^ of
    #13:
      begin
        inc(Run);
        if Run < TheEnd then if Run^ = #10 then inc(Run);
      end;
    #10: inc(Run);
  end;
  if Result then
    Inc(fLineCount);
  Range := Current.ToRestore;
end;

function TmwGenLex.ApplyKey: Boolean;
var
  I: Integer;
  Temp: PChar;
begin
  Range := nil;
  Temp := Run;
  for I := 1 to Length(Current.Key) do
  begin
    if Run >= TheEnd then break;
    case Sensitive of
      True: if Current.Key[I] = Run^ then inc(Run) else break;
      False: if CompTable[Current.Key[I]] = CompTable[Run^] then inc(Run) else break;
    end;
  end;
  Result := (Run - Temp) = Length(Current.Key);
  if not Result then Run := Temp;
end;

function TmwGenLex.ApplyLineEnd: Boolean;
begin
  Range := nil;
  Result := True;
  case Run^ of
    #13:
      begin
        inc(Run);
        if Run < TheEnd then if Run^ = #10 then inc(Run);
      end;
    #10: inc(Run);
  else Result := False;
  end;
  if Result then
    Inc(fLineCount);
end;

function TmwGenLex.ApplyTillChars: Boolean;
var
  Temp: PChar;
begin
  Temp := Run;
  Result := False;
  while Result = False do
  begin
    if Run >= TheEnd then break;
    case Run^ of
      #10, #13:
        case Current.Multiline of
          True:
            begin
              Range := InnerLineEnd;
              InnerLineEnd.ToRestore := Current;
              Exit;
            end;
          False:
            begin
              Result := False;
              break;
            end;
        end;
    else
      Temp := Run;
      Result := ApplyCharClass;
      if Result = False then inc(Run);
    end;
  end;
  if Result then
  begin
    Range := nil;
    if psNegative in Current.Storage.Status then Run := Temp;
  end else
    case Current.Multiline of
      True: Range := Current;
      False:
        begin
          Range := nil;
          Run := Temp;
        end;
    end;
end;

function TmwGenLex.ApplyTillKey: Boolean;
var
  Temp: PChar;
begin
  Temp := Run;
  Result := False;
  while Result = False do
  begin
    if Run >= TheEnd then break;
    case Run^ of
      #10, #13:
        case Current.Multiline of
          True:
            begin
              Range := InnerLineEnd;
              InnerLineEnd.ToRestore := Current;
              Exit;
            end;
          False:
            begin
              Result := False;
              break;
            end;
        end;
    else
      if Run^ = Current.Key[1] then
      begin
        Result := ApplyKey;
        if Result = False then inc(Run);
      end else inc(Run)
    end;
  end;
  if Result then
  begin
    Range := nil;
    if psNegative in Current.Storage.Status then Run := Run - Length(Current.Key);
  end else
    case Current.Multiline of
      True: Range := Current;
      False:
        begin
          Range := nil;
          Run := Temp;
        end;
    end;
end;

function TmwGenLex.AtEnd: Boolean;
begin
  Result := Run >= TheEnd;
end;

procedure TmwGenLex.Clear;
var
  I: Integer;
begin
  for I := 0 to fChain.Count - 1 do
    if Assigned(fChain[I]) then TObject(fChain[I]).Free;
  fChain.Clear;
end;

constructor TmwGenLex.Create;
begin
  inherited Create;
  fLineCount := 0;
  InnerLineEnd := TAny.Create(nil);
  InnerLineEnd.Kind := pkInnerLineEnd;
  InnerLineEnd.Id := piInnerLineEnd;
  InitSelector;
  FChain := TList.Create;
  InitMainSelector;
  FId := piUnknown;
  FExId := piUnknown;
end;

destructor TmwGenLex.Destroy;
begin
  InnerLineEnd.Free;
  Clear;
  FChain.Free;
  inherited Destroy;
end;

function TmwGenLex.Execute: Boolean;
var
  I: Integer;
  Temp: PChar;
begin
  Temp := Run;
  Result := True;
  if (Current.Max = 0) and (Current.Min = 0) then Selector[Current.Kind] else
  begin
    for I := 0 to Current.Min - 1 do Result := Selector[Current.Kind];
    if not Result then Run := Temp;
    for I := Current.Min to Current.Max - 1 do Selector[Current.Kind];
  end;
end;

function TmwGenLex.GetEndPos: Integer;
begin
  Result := TheEnd - FOrigin;
end;

function TmwGenLex.GetLinePos: Integer;
begin
  Result := fLineCount;
end;

function TmwGenLex.GetRunPos: Integer;
begin
  Result := Run - FOrigin;
end;

function TmwGenLex.GetToken: string;
begin
  SetLength(Result, Run - Start);
  Move(Start^, Result[1], Run - Start);
end;

procedure TmwGenLex.InitMainSelector;
var
  I: Char;
  Default: TAny;
begin
  Default := TAny.Create(nil);
  Default.Key := #0;
  Default.Id := piZero;
  FChain.Add(Default);
  MainSelector[#0] := Default;
  Default := TAny.Create(nil);
  FChain.Add(Default);
  for I := #1 to #255 do
    MainSelector[I] := Default;
end;

procedure TmwGenLex.InitSelector;
begin
  Selector[pkAny] := ApplyAny;
  Selector[pkChar] := ApplyChar;
  Selector[pkCharClass] := ApplyCharClass;
  Selector[pkInnerLineEnd] := ApplyInnerLineEnd;
  Selector[pkKey] := ApplyKey;
  Selector[pkLineEnd] := ApplyLineEnd;
  Selector[pkTillChars] := ApplyTillChars;
  Selector[pkTillKey] := ApplyTillKey;
end;

procedure TmwGenLex.Next;
var
  Succeed: Boolean;
  TempRun: PChar;
begin
  Start := Run;
  if Range <> nil then Current := Range else
    Current := MainSelector[Run^];
  while Current <> nil do
  begin
    case Current.Regress of
      True:
        begin
          TempRun := Run;
          Succeed := SubNext;
          if Succeed then
          begin
            Current := Current.ToRegress;
            Succeed := SubNext
          end;
          if Succeed then
          begin
            FId := Current.Id;
            FExId := Current.ExId;
            Current := Current.Follow;
          end else
          begin
            Run := TempRun;
            Current:= nil;
          end;
        end;
      False:
        begin
          Succeed := SubNext;
          if Succeed then
          begin
            FId := Current.Id;
            FExId := Current.ExId;
            Current := Current.Follow;
          end;
        end;
    end;
  end;
end;

procedure TmwGenLex.SetEndPos(const Value: Integer);
begin
  TheEnd := FOrigin + Value;
end;

procedure TmwGenLex.SetInitMethod(const Value: TmwLexInitMethod);
begin
  if Assigned(Value) then
  begin
    Clear;
    FInitMethod := Value;
    InitMainSelector;
    Value(Self);
  end;
end;

procedure TmwGenLex.SetInitProc(const Value: TmwLexInitProc);
begin
  if Assigned(Value) then
  begin
    Clear;
    FInitProc := Value;
    InitMainSelector;
    Value(Self);
  end;
end;

procedure TmwGenLex.SetInput(const Value: string);
begin
  FOrigin := PChar(Value);
  Run := FOrigin;
  TheEnd := FOrigin + Length(Value);
end;

procedure TmwGenLex.SetOrigin(const Value: PChar);
begin
  FOrigin := Value;
  Run := FOrigin;
  Start := Value;
  TheEnd := FOrigin;
  fLineCount := 0;
end;

procedure TmwGenLex.SetRunPos(const Value: Integer);
begin
  Run := FOrigin + Value;
  Start := Run;
end;

procedure TmwGenLex.SetStartData(Ptr: Pointer; aLen: Integer);
begin
  Origin := Ptr;
  TheEnd := PChar(Ptr) + aLen;
end;

function TmwGenLex.SubNext: Boolean;
var
  I: Integer;
  Temp: TAny;
begin
  Result := Execute;
  if not Result then
    if Current.Count = 0 then Current := nil else
      for I := 0 to Current.Count - 1 do
      begin
        Temp := Current;
        Current := Current[Byte(I)];
        Result := Execute;
        if Result then break else
        begin
          Current := Temp;
          if I = Current.Count - 1 then
          begin
            Current := nil;
            break;
          end;
        end;
      end;
end;

initialization
  InitTables;

end.

