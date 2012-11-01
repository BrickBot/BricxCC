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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit SynHighlighterSPASM;

{$I BricxCCSynEdit.inc}

interface

uses
  Classes,
  SynEditHighlighter,
  SynHighlighterHashEntries,
  SynEditTypes;

type
  TtkTokenKind = (tkComment, tkDirective, tkIdentifier, tkKey, tkNull, tkNumber, tkSpace,
    tkString, tkSymbol, tkUnknown);

  TProcTableProc = procedure of object;

type
  TSynSPASMSyn = class(TSynCustomHighlighter)
  private
    fLine: PChar;
    fLineNumber: Integer;
    fProcTable: array[#0..#255] of TProcTableProc;
    Run: LongInt;
    fStringLen: Integer;
    fToIdent: PChar;
    fTokenPos: Integer;
    fTokenID: TtkTokenKind;
    fCommentAttri: TSynHighlighterAttributes;
    fDirecAttri: TSynHighlighterAttributes;
    fIdentifierAttri: TSynHighlighterAttributes;
    fKeyAttri: TSynHighlighterAttributes;
    fNumberAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;
    fStringAttri: TSynHighlighterAttributes;
    fSymbolAttri: TSynHighlighterAttributes;
    fKeywords: TSynHashEntryList;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: String): Boolean;
    procedure CommentProc;
    procedure CRProc;
    procedure GreaterProc;
    procedure IdentProc;
    procedure LFProc;
    procedure LowerProc;
    procedure NullProc;
    procedure NumberProc;
    procedure SlashProc;
    procedure SpaceProc;
    procedure StringProc;
    procedure SymbolProc;
    procedure UnknownProc;
    procedure DirectiveProc;
    procedure DoAddKeyword(AKeyword: string; AKind: integer);
    function IdentKind(MayBe: PChar): TtkTokenKind;
    procedure MakeMethodTables;
  protected
    function GetIdentChars: TSynIdentChars; override;
    function GetSampleSource: string; override;
  public
    {$IFNDEF SYN_CPPB_1} class {$ENDIF}                                         //mh 2000-07-14
    function GetLanguageName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
      override;
    function GetEol: Boolean; override;
    function GetTokenID: TtkTokenKind;
    procedure SetLine({$IFDEF FPC}const {$ENDIF}NewValue: String; LineNumber:Integer); override;
    function GetToken: String; override;
    {$IFDEF SYN_LAZARUS}
    procedure GetTokenEx(out TokenStart: PChar; out TokenLength: integer); override;
    {$ENDIF}
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;
    procedure Next; override;
  published
    property CommentAttri: TSynHighlighterAttributes read fCommentAttri write fCommentAttri;
    property DirectiveAttri: TSynHighlighterAttributes read fDirecAttri write fDirecAttri;
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri write fIdentifierAttri;
    property KeyAttri: TSynHighlighterAttributes read fKeyAttri write fKeyAttri;
    property NumberAttri: TSynHighlighterAttributes read fNumberAttri write fNumberAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri write fSpaceAttri;
    property StringAttri: TSynHighlighterAttributes read fStringAttri write fStringAttri;
    property SymbolAttri: TSynHighlighterAttributes read fSymbolAttri write fSymbolAttri;
  end;

procedure LoadSPASMCodeComplete(aItems : TStrings);

implementation

uses
  SysUtils,
  Graphics,
  SynEditStrConst;

var
  Identifiers: array[#0..#255] of ByteBool;
  mHashTable: array[#0..#255] of Integer;

{$IFDEF SYN_COMPILER_3_UP}
resourcestring
{$ELSE}
const
{$ENDIF}
  SYNS_FilterSPASM = 'SPASM Files (*.spasm)|*.spasm';
  SYNS_LangSPASM   = 'SuperPro Assembler';

const
  OpCodes: string =
    'ADD, ADI, AND, ANI, ASR, CALL, CLC, CLR, CLZ, COM, DEC, DIV, DORG, DS,' +
    'DVI, END, ENDINCLUDE, EQU, FORK, HALTALL, HALTEX, HALTME, INC, INCLUDE,' +
    'INVC, INVZ, JC, JMP, JN, JNC, JNN, JNP, JNZ, JP, JZ, LCLOSE, LINIT, LOG,' +
    'LOPEN, LSL, LSR, LSTAT, MOV, MUI, MUL, MVI, NEG, OR, ORG, ORI, POP, PUSH,' +
    'READ, RET, RLC, RRC, SBI, SQRT, STALL, START, STC, STZ, SUB, SUBTTL, SUI,' +
    'SWITCH, TITLE, TRCH, TRCR, TRND, TRNH, TRNL, TRNS, TRSP, TRST, TST, WAIT,' +
    'XOR, XRI';

procedure LoadSPASMCodeComplete(aItems : TStrings);
var
  tmpSL : TStringList;
begin
  aItems.Clear;
  tmpSL := TStringList.Create;
  try
    tmpSL.CommaText := OpCodes;
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
    mHashTable[c] := 1 + Ord(c) - Ord('A');
  for c := '0' to '9' do
    mHashTable[c] := 27 + Ord(c) - Ord('0');
end;

function TSynSPASMSyn.KeyHash(ToHash: PChar): Integer;
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

function TSynSPASMSyn.KeyComp(const aKey: String): Boolean;
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

procedure TSynSPASMSyn.DoAddKeyword(AKeyword: string; AKind: integer);
var
  HashValue: integer;
begin
  HashValue := KeyHash(PChar(AKeyword));
  fKeywords[HashValue] := TSynHashEntry.Create(AKeyword, AKind);
end;

function TSynSPASMSyn.IdentKind(MayBe: PChar): TtkTokenKind;
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
  Result := tkIdentifier;
end;

procedure TSynSPASMSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      '#' : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}DirectiveProc;
       #0 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NullProc;
      #10 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LFProc;
      #13 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}CRProc;
      #34 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}StringProc;
      '>' : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}GreaterProc;
      '<' : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LowerProc;
      'A'..'Z', 'a'..'z', '_', '.':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}IdentProc;
      '0'..'9':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NumberProc;
      #1..#9, #11, #12, #14..#32:
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SpaceProc;
      ';':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}CommentProc;
      '\':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SlashProc;
      ':', '&', '{', '}', '=', '^', '-', '+', '(', ')', '*', '''', '@':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SymbolProc;
      else
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}UnknownProc;
    end;
end;

constructor TSynSPASMSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fKeywords := TSynHashEntryList.Create;

  fCommentAttri       := TSynHighlighterAttributes.Create(SYNS_AttrComment);
  fCommentAttri.Style := [fsItalic];
  AddAttribute(fCommentAttri);

  fDirecAttri := TSynHighlighterAttributes.Create(SYNS_AttrPreprocessor);
  fDirecAttri.Foreground := clPurple;
  AddAttribute(fDirecAttri);

  fIdentifierAttri    := TSynHighlighterAttributes.Create(SYNS_AttrIdentifier);
  AddAttribute(fIdentifierAttri);

  fKeyAttri           := TSynHighlighterAttributes.Create(SYNS_AttrReservedWord);
  fKeyAttri.Style     := [fsBold];
  AddAttribute(fKeyAttri);

  fNumberAttri        := TSynHighlighterAttributes.Create(SYNS_AttrNumber);
  AddAttribute(fNumberAttri);

  fSpaceAttri         := TSynHighlighterAttributes.Create(SYNS_AttrSpace);
  AddAttribute(fSpaceAttri);

  fStringAttri        := TSynHighlighterAttributes.Create(SYNS_AttrString);
  AddAttribute(fStringAttri);

  fSymbolAttri        := TSynHighlighterAttributes.Create(SYNS_AttrSymbol);
  AddAttribute(fSymbolAttri);

  MakeMethodTables;
  EnumerateKeywords(Ord(tkKey), OpCodes, IdentChars, {$IFDEF FPC}@{$ENDIF}DoAddKeyword);
  SetAttributesOnChange({$IFDEF FPC}@{$ENDIF}DefHighlightChange);
  fDefaultFilter      := SYNS_FilterSPASM;
end;

destructor TSynSPASMSyn.Destroy;
begin
  fKeywords.Free;
  inherited Destroy;
end;

procedure TSynSPASMSyn.SetLine({$IFDEF FPC}const {$ENDIF}NewValue: String; LineNumber:Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end;

procedure TSynSPASMSyn.CommentProc;
begin
  fTokenID := tkComment;
  repeat
    Inc(Run);
  until fLine[Run] in [#0, #10, #13];
end;

procedure TSynSPASMSyn.CRProc;
begin
  fTokenID := tkSpace;
  Inc(Run);
  if fLine[Run] = #10 then Inc(Run);
end;

procedure TSynSPASMSyn.GreaterProc;
begin
  Inc(Run);
  fTokenID := tkSymbol;
  if fLine[Run] = '=' then Inc(Run);
end;

procedure TSynSPASMSyn.IdentProc;
begin
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
end;

procedure TSynSPASMSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TSynSPASMSyn.LowerProc;
begin
  Inc(Run);
  fTokenID := tkSymbol;
  if fLine[Run] in ['=', '>'] then Inc(Run);
end;

procedure TSynSPASMSyn.NullProc;
begin
  fTokenID := tkNull;
end;

{
procedure TSynSPASMSyn.NumberProc;
begin
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in ['0'..'9', '.', 'a'..'f', 'h', 'A'..'F', 'H'] do
    Inc(Run);
end;
}

procedure TSynSPASMSyn.NumberProc;
var
  idx1: Integer; // token[1]
  bIsHex : Boolean;
begin
  idx1 := Run;
  Inc(Run);
  fTokenID := tkNumber;
  bIsHex := False;
  while FLine[Run] in
    ['0'..'9', 'A'..'F', 'a'..'f', 'x', 'X'] do
  begin
    case FLine[Run] of
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

procedure TSynSPASMSyn.SlashProc;
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
  else
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
end;

procedure TSynSPASMSyn.SpaceProc;
begin
  fTokenID := tkSpace;
  repeat
    Inc(Run);
  until (fLine[Run] > #32) or (fLine[Run] in [#0, #10, #13]);
end;

procedure TSynSPASMSyn.StringProc;
begin
  fTokenID := tkString;
  if (FLine[Run + 1] = #34) and (FLine[Run + 2] = #34) then
    inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = #34;
  if FLine[Run] <> #0 then inc(Run);
end;

procedure TSynSPASMSyn.SymbolProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
end;

procedure TSynSPASMSyn.UnknownProc;
begin
{$IFDEF SYN_MBCSSUPPORT}
  if FLine[Run] in LeadBytes then
    Inc(Run,2)
  else
{$ENDIF}
  inc(Run);
  fTokenID := tkIdentifier;
end;

procedure TSynSPASMSyn.Next;
begin
  fTokenPos := Run;
  fProcTable[fLine[Run]];
end;

function TSynSPASMSyn.GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT: Result := fCommentAttri;
    SYN_ATTR_IDENTIFIER: Result := fIdentifierAttri;
    SYN_ATTR_KEYWORD: Result := fKeyAttri;
    SYN_ATTR_STRING: Result := fStringAttri;
    SYN_ATTR_WHITESPACE: Result := fSpaceAttri;
    SYN_ATTR_SYMBOL: Result := fSymbolAttri;
  else
    Result := nil;
  end;
end;

function TSynSPASMSyn.GetEol: Boolean;
begin
  Result := fTokenId = tkNull;
end;

function TSynSPASMSyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

{$IFDEF SYN_LAZARUS}
procedure TSynSPASMSyn.GetTokenEx(out TokenStart: PChar;
  out TokenLength: integer);
begin
  TokenLength:=Run-fTokenPos;
  TokenStart:=FLine + fTokenPos;
end;
{$ENDIF}

function TSynSPASMSyn.GetTokenAttribute: TSynHighlighterAttributes;
begin
  case fTokenID of
    tkComment: Result := fCommentAttri;
    tkDirective: Result := fDirecAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkNumber: Result := fNumberAttri;
    tkSpace: Result := fSpaceAttri;
    tkString: Result := fStringAttri;
    tkSymbol: Result := fSymbolAttri;
    tkUnknown: Result := fIdentifierAttri;
    else Result := nil;
  end;
end;

function TSynSPASMSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TSynSPASMSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TSynSPASMSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

function TSynSPASMSyn.GetIdentChars: TSynIdentChars;
begin
  Result := TSynValidStringChars;
end;

{$IFNDEF SYN_CPPB_1} class {$ENDIF}
function TSynSPASMSyn.GetLanguageName: string;
begin
  Result := SYNS_LangSPASM;
end;

function TSynSPASMSyn.GetSampleSource: string;
begin
  Result :=
    '        SUBTTL  SPMEM.ASM'#13#10 +
    'ADCHANNEL0      DS      1'#13#10 +
    'ADCHANNEL1      DS      1'#13#10 +
    'ADCHANNEL2      DS      1'#13#10 +
    'ADCHANNEL3      DS      1'#13#10 +
    '                DORG    08H'#13#10 +
    'DIGITALIN       DS      1'#13#10 +
    'DIGITALOUT      DS      1'#13#10 +
    'DIGITALCTRL     DS      1'#13#10 +
    'STROBECTRL      DS      1'#13#10 +
    'TIMER0          DS      1'#13#10 +
    'TIMER1          DS      1'#13#10 +
    'TIMER2          DS      1'#13#10 +
    'TIMER3          DS      1'#13#10 +
    'SERINCOUNT      DS      1'#13#10 +
    'SERINBYTE       DS      1'#13#10 +
    'SEROUTCOUNT     DS      1'#13#10 +
    'SEROUTBYTE      DS      1'#13#10 +
    '                DORG    18H'#13#10 +
    'DACMODE1        DS      1'#13#10 +
    'DACFREQ1        DS      1'#13#10 +
    'DACVOLT1        DS      1'#13#10 +
    'DACMODE2        DS      1'#13#10 +
    'DACFREQ2        DS      1'#13#10 +
    'DACVOLT2        DS      1'#13#10 +
    '                DORG    20H'#13#10 +
    ';'#13#10 +
    ';'#13#10 +
    '        SUBTTL  TEST.ASM'#13#10 +
    'VAR             DS      1'#13#10 +
    ';'#13#10 +
    ';       INCLUDE MONITOR.ASM'#13#10 +
    '        START'#13#10 +
    ';'#13#10 +
    '        MVI     STROBECTRL,3FH'#13#10 +
    '        CLR     DIGITALCTRL'#13#10 +
    'MAINLOOP:'#13#10 +
    'WAITLOOP:'#13#10 +
    '        TST     TIMER0'#13#10 +
    '        JNZ     WAITLOOP'#13#10 +
    ';'#13#10 +
    '        JMP     MAINLOOP'#13#10 +
    ';'#13#10 +
    '        HALTME'#13#10 +
    ';'#13#10 +
    '        END';
end;

procedure TSynSPASMSyn.DirectiveProc;
begin
  fTokenID := tkDirective;
  repeat
    inc(Run);
  until fLine[Run] in [#0, #10, #13];
end;

initialization
  MakeIdentTable;
{$IFNDEF SYN_CPPB_1}
  RegisterPlaceableHighlighter(TSynSPASMSyn);
{$ENDIF}
end.