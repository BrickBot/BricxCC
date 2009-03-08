unit SynHighlighterRS;

{$I BricxCCSynEdit.inc}

interface

uses
  Classes,
  SynEditHighlighter,
  SynHighlighterHashEntries,
  SynEditTypes;

type
  TtkTokenKind = (tkComment, tkCommand, tkNull, tkNumber, tkSpace, tkSymbol, tkUnknown);

  TRangeState = (rsUnKnown, rsCStyle);

  TProcTableProc = procedure of object;

type
  TSynRSSyn = class(TSynCustomHighlighter)
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
    fCommandAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;
    fSymbolAttri: TSynHighlighterAttributes;
    fNumberAttri: TSynHighlighterAttributes;
    fKeywords: TSynHashEntryList;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: String): Boolean;
    procedure CRProc;
    procedure GreaterProc;
    procedure IdentProc;
    procedure LFProc;
    procedure LowerProc;
    procedure NullProc;
    procedure SlashProc;
    procedure NumberProc;
    procedure SpaceProc;
    procedure SymbolProc;
    procedure UnknownProc;
//    procedure DirectiveProc;
    procedure DoAddKeyword(AKeyword: string; AKind: integer);
    function IdentKind(MayBe: PChar): TtkTokenKind;
    procedure MakeMethodTables;
    procedure CStyleProc;
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
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;
    procedure Next; override;
  published
    property CommentAttri: TSynHighlighterAttributes read fCommentAttri write fCommentAttri;
    property CommandAttri: TSynHighlighterAttributes read fCommandAttri write fCommandAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri write fSpaceAttri;
    property SymbolAttri: TSynHighlighterAttributes read fSymbolAttri write fSymbolAttri;
    property NumberAttri: TSynHighlighterAttributes read fNumberAttri write fNumberAttri;
  end;

procedure LoadRSCodeComplete(aItems : TStrings);

implementation

uses
  SysUtils,
  Graphics,
  SynEditStrConst;

const
  SYN_ATTR_COMMAND  = 7;

var
  Identifiers: array[#0..#255] of ByteBool;
  mHashTable: array[#0..#255] of Integer;

{$IFDEF SYN_COMPILER_3_UP}
resourcestring
{$ELSE}
const
{$ENDIF}
  SYNS_AttrCommand  = 'Command';
  SYNS_FilterRS = 'RICScript Files (*.rs)|*.rs';
  SYNS_LangRS   = 'RICScript';

const
  RSCommands: string =
    'desc, sprite, varmap, copybits, line, rect, pixel, circle, numbox, arg, maparg, f';

procedure LoadRSCodeComplete(aItems : TStrings);
var
  tmpSL : TStringList;
begin
  aItems.Clear;
  tmpSL := TStringList.Create;
  try
    tmpSL.CommaText := RSCommands;
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

function TSynRSSyn.KeyHash(ToHash: PChar): Integer;
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

function TSynRSSyn.KeyComp(const aKey: String): Boolean;
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

procedure TSynRSSyn.DoAddKeyword(AKeyword: string; AKind: integer);
var
  HashValue: integer;
begin
  HashValue := KeyHash(PChar(AKeyword));
  fKeywords[HashValue] := TSynHashEntry.Create(AKeyword, AKind);
end;

function TSynRSSyn.IdentKind(MayBe: PChar): TtkTokenKind;
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
  Result := tkUnknown;
end;

procedure TSynRSSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
       #0 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NullProc;
      #10 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LFProc;
      #13 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}CRProc;
      '>' : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}GreaterProc;
      '<' : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LowerProc;
      '/' : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SlashProc;
      'A'..'Z', 'a'..'z', '_', '.':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}IdentProc;
      '0'..'9':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NumberProc;
      #1..#9, #11, #12, #14..#32:
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SpaceProc;
      ':', ';', '&', '{', '}', '=', '^', '-', '+', '(', ')', '*', '@', '"':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SymbolProc;
      else
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}UnknownProc;
    end;
end;

constructor TSynRSSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fKeywords := TSynHashEntryList.Create;

  fCommentAttri       := TSynHighlighterAttributes.Create(SYNS_AttrComment);
  fCommentAttri.Style := [fsItalic];
  AddAttribute(fCommentAttri);

  fCommandAttri := TSynHighlighterAttributes.Create(SYNS_AttrCommand);
  fCommandAttri.Foreground := clBlue;
  AddAttribute(fCommandAttri);

  fNumberAttri        := TSynHighlighterAttributes.Create(SYNS_AttrNumber);
  AddAttribute(fNumberAttri);

  fSpaceAttri         := TSynHighlighterAttributes.Create(SYNS_AttrSpace);
  AddAttribute(fSpaceAttri);

  fSymbolAttri        := TSynHighlighterAttributes.Create(SYNS_AttrSymbol);
  AddAttribute(fSymbolAttri);

  MakeMethodTables;
  EnumerateKeywords(Ord(tkCommand), RSCommands, IdentChars, {$IFDEF FPC}@{$ENDIF}DoAddKeyword);
  SetAttributesOnChange({$IFDEF FPC}@{$ENDIF}DefHighlightChange);
  fDefaultFilter      := SYNS_FilterRS;
  fRange := rsUnknown;
end;

destructor TSynRSSyn.Destroy;
begin
  fKeywords.Free;
  inherited Destroy;
end;

procedure TSynRSSyn.SetLine({$IFDEF FPC}const {$ENDIF}NewValue: String; LineNumber:Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end;

procedure TSynRSSyn.CRProc;
begin
  fTokenID := tkSpace;
  Inc(Run);
  if fLine[Run] = #10 then Inc(Run);
end;

procedure TSynRSSyn.GreaterProc;
begin
  Inc(Run);
  fTokenID := tkSymbol;
  if fLine[Run] = '=' then Inc(Run);
end;

procedure TSynRSSyn.IdentProc;
begin
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
end;

procedure TSynRSSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TSynRSSyn.LowerProc;
begin
  Inc(Run);
  fTokenID := tkSymbol;
  if fLine[Run] in ['=', '>'] then Inc(Run);
end;

procedure TSynRSSyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TSynRSSyn.NumberProc;
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


procedure TSynRSSyn.SlashProc;
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

procedure TSynRSSyn.CStyleProc;
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

procedure TSynRSSyn.SpaceProc;
begin
  fTokenID := tkSpace;
  repeat
    Inc(Run);
  until (fLine[Run] > #32) or (fLine[Run] in [#0, #10, #13]);
end;

procedure TSynRSSyn.SymbolProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
end;

procedure TSynRSSyn.UnknownProc;
begin
{$IFDEF SYN_MBCSSUPPORT}
  if FLine[Run] in LeadBytes then
    Inc(Run,2)
  else
{$ENDIF}
  inc(Run);
  fTokenID := tkUnknown;
end;

procedure TSynRSSyn.Next;
begin
  fTokenPos := Run;
  case fRange of
    rsCStyle: CStyleProc;
  else
    fRange := rsUnknown;
    fProcTable[fLine[Run]];
  end;
end;

function TSynRSSyn.GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT: Result := fCommentAttri;
    SYN_ATTR_COMMAND: Result := fCommandAttri;
    SYN_ATTR_WHITESPACE: Result := fSpaceAttri;
    SYN_ATTR_SYMBOL: Result := fSymbolAttri;
  else
    Result := nil;
  end;
end;

function TSynRSSyn.GetEol: Boolean;
begin
  Result := fTokenId = tkNull;
end;

function TSynRSSyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TSynRSSyn.GetTokenAttribute: TSynHighlighterAttributes;
begin
  case fTokenID of
    tkComment: Result := fCommentAttri;
    tkCommand: Result := fCommandAttri;
    tkNumber: Result  := fNumberAttri;
    tkSpace: Result   := fSpaceAttri;
    tkSymbol: Result  := fSymbolAttri;
    tkUnknown: Result := fSymbolAttri;
    else Result       := nil;
  end;
end;

function TSynRSSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TSynRSSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TSynRSSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

function TSynRSSyn.GetIdentChars: TSynIdentChars;
begin
  Result := TSynValidStringChars;
end;

{$IFNDEF SYN_CPPB_1} class {$ENDIF}
function TSynRSSyn.GetLanguageName: string;
begin
  Result := SYNS_LangRS;
end;

function TSynRSSyn.GetSampleSource: string;
begin
  Result :=
    '// testing.ric'#13#10 +
    'desc(0, 8, 8);'#13#10 +
    'sprite(1, 0x01, 0x03, 0x05, 0x09, 0x11, 0x21, 0x41, 0xFF);'#13#10 +
    'sprite(2, 0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3F, 0x7F, 0xFF);'#13#10 +
    'copybits(0, arg(0), 0, 0, 8, 8, 0, 0);';
end;

procedure TSynRSSyn.ResetRange;
begin
  fRange := rsUnknown;
end;

procedure TSynRSSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

function TSynRSSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

initialization
  MakeIdentTable;
{$IFNDEF SYN_CPPB_1}                                                            //mh 2000-07-14
  RegisterPlaceableHighlighter(TSynRSSyn);
{$ENDIF}
end.

