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
 unit SynHighlighterH8;

{$I BricxCCSynEdit.inc}

interface

uses
  Classes,
  SynEditHighlighter,
  SynHighlighterHashEntries,
  SynEditTypes;

type
  TtkTokenKind = (tkComment, tkIdentifier, tkKey, tkNull, tkNumber, tkSpace,
    tkString, tkSymbol, tkUnknown);

  TProcTableProc = procedure of object;

type
  TSynH8Syn = class(TSynCustomHighlighter)
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
//    procedure SingleQuoteStringProc;
    procedure SymbolProc;
    procedure UnknownProc;
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
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;
    procedure Next; override;
  published
    property CommentAttri: TSynHighlighterAttributes read fCommentAttri
      write fCommentAttri;
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri
      write fIdentifierAttri;
    property KeyAttri: TSynHighlighterAttributes read fKeyAttri write fKeyAttri;
    property NumberAttri: TSynHighlighterAttributes read fNumberAttri
      write fNumberAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri
      write fSpaceAttri;
    property StringAttri: TSynHighlighterAttributes read fStringAttri
      write fStringAttri;
    property SymbolAttri: TSynHighlighterAttributes read fSymbolAttri
      write fSymbolAttri;
  end;

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
  SYNS_FilterAsmH8 = 'H8 Assembler Files (*.SRC)|*.SRC';
  SYNS_LangH8Asm   = 'H8 assembler';

const
  OpCodes: string =
    'add.b,add.w,adds.w,addx.b,and.b,andc,band,bcc,bclr,bcs,beq,bf,bge,bgt,bhi,' +
    'bhs,biand,bild,bior,bist,bixor,bld,ble,blo,bls,blt,bmi,bne,bnot,' +
    'bor,bpl,bra,bset,bsr,bst,bt,btst,bvc,bvs,bxor,cmp.b,cmp.w,' +
    'daa.b,das.b,dec.b,divxs,divxu.b,' +
    'eepmov.b,eepmov.w,exts,extu,inc.b,' +
    'jmp,jsr,ldc,mov.b,mov.w,movfpe,movtpe,' +
    'mulxs,mulxu.b,neg.b,nop,not.b,' +
    'or.b,orc,pop,push,rotl.b,rotr.b,rotxl.b,rotxr.b,' +
    'rte,rts,shal.b,shar.b,shll.b,shlr.b,sleep,' +
    'stc,sub.b,sub.w,subs.w,subx.b,trapa,xor.b,xorc';

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

function TSynH8Syn.KeyHash(ToHash: PChar): Integer;
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

function TSynH8Syn.KeyComp(const aKey: String): Boolean;
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

procedure TSynH8Syn.DoAddKeyword(AKeyword: string; AKind: integer);
var
  HashValue: integer;
begin
  HashValue := KeyHash(PChar(AKeyword));
  fKeywords[HashValue] := TSynHashEntry.Create(AKeyword, AKind);
end;

function TSynH8Syn.IdentKind(MayBe: PChar): TtkTokenKind;
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

procedure TSynH8Syn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
       #0 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NullProc;
      #10 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LFProc;
      #13 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}CRProc;
      #34 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}StringProc;
//      #39 : fProcTable[I] := SingleQuoteStringProc;
      '>' : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}GreaterProc;
      '<' : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LowerProc;
      '/' : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SlashProc;
      'A'..'Z', 'a'..'z', '_', '.':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}IdentProc;
      '0'..'9':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NumberProc;
      #1..#9, #11, #12, #14..#32:
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SpaceProc;
      ';':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}CommentProc;
      ':', '&', '{', '}', '=', '^', '-', '+', '(', ')', '*', '#', '''', '@':
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SymbolProc;
      else
        fProcTable[I] := {$IFDEF FPC}@{$ENDIF}UnknownProc;
    end;
end;

constructor TSynH8Syn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fKeywords := TSynHashEntryList.Create;

  fCommentAttri       := TSynHighlighterAttributes.Create(SYNS_AttrComment);
  fCommentAttri.Style := [fsItalic];
  AddAttribute(fCommentAttri);
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
  fDefaultFilter      := SYNS_FilterAsmH8;
end;

destructor TSynH8Syn.Destroy;
begin
  fKeywords.Free;
  inherited Destroy;
end;

procedure TSynH8Syn.SetLine({$IFDEF FPC}const {$ENDIF}NewValue: String; LineNumber:Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end;

procedure TSynH8Syn.CommentProc;
begin
  fTokenID := tkComment;
  repeat
    Inc(Run);
  until fLine[Run] in [#0, #10, #13];
end;

procedure TSynH8Syn.CRProc;
begin
  fTokenID := tkSpace;
  Inc(Run);
  if fLine[Run] = #10 then Inc(Run);
end;

procedure TSynH8Syn.GreaterProc;
begin
  Inc(Run);
  fTokenID := tkSymbol;
  if fLine[Run] = '=' then Inc(Run);
end;

procedure TSynH8Syn.IdentProc;
begin
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
end;

procedure TSynH8Syn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TSynH8Syn.LowerProc;
begin
  Inc(Run);
  fTokenID := tkSymbol;
  if fLine[Run] in ['=', '>'] then Inc(Run);
end;

procedure TSynH8Syn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TSynH8Syn.NumberProc;
begin
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in ['0'..'9', '.', 'a'..'f', 'h', 'A'..'F', 'H'] do
    Inc(Run);
end;

procedure TSynH8Syn.SlashProc;
begin
  Inc(Run);
  if fLine[Run] = '/' then begin
    fTokenID := tkComment;
    repeat
      Inc(Run);
    until fLine[Run] in [#0, #10, #13];
  end else
    fTokenID := tkSymbol;
end;

procedure TSynH8Syn.SpaceProc;
begin
  fTokenID := tkSpace;
  repeat
    Inc(Run);
  until (fLine[Run] > #32) or (fLine[Run] in [#0, #10, #13]);
end;

procedure TSynH8Syn.StringProc;
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

{
procedure TSynH8Syn.SingleQuoteStringProc;
begin
  fTokenID := tkString;
  if (FLine[Run + 1] = #39) and (FLine[Run + 2] = #39) then
    inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = #39;
  if FLine[Run] <> #0 then inc(Run);
end;
}

procedure TSynH8Syn.SymbolProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
end;

procedure TSynH8Syn.UnknownProc;
begin
{$IFDEF SYN_MBCSSUPPORT}
  if FLine[Run] in LeadBytes then
    Inc(Run,2)
  else
{$ENDIF}
  inc(Run);
  fTokenID := tkIdentifier;
end;

procedure TSynH8Syn.Next;
begin
  fTokenPos := Run;
  fProcTable[fLine[Run]];
end;

function TSynH8Syn.GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
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

function TSynH8Syn.GetEol: Boolean;
begin
  Result := fTokenId = tkNull;
end;

function TSynH8Syn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TSynH8Syn.GetTokenAttribute: TSynHighlighterAttributes;
begin
  case fTokenID of
    tkComment: Result := fCommentAttri;
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

function TSynH8Syn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TSynH8Syn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TSynH8Syn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

function TSynH8Syn.GetIdentChars: TSynIdentChars;
begin
  Result := TSynValidStringChars + ['.'];                                               //DDH 10/17/01
end;

{$IFNDEF SYN_CPPB_1} class {$ENDIF}                                             //mh 2000-07-14
function TSynH8Syn.GetLanguageName: string;
begin
  Result := SYNS_LangH8Asm;
end;

function TSynH8Syn.GetSampleSource: string;
begin
  Result :=
    '        MOV.B   @H''4000,R0L ;'#13#10 +
    '        AND.B   #H''01,R0L   ; Read the sensor'#13#10 +
    '        CMP.B   #H''01,R0L   ;'#13#10 +
    '        BEQ     ON           ;'#13#10 +
    'OFF:    MOV.B   @H''4001,R0H ; When the sensor is 0'#13#10 +
    '        AND.B   #H''FE,R0H   ;'#13#10 +
    '        MOV.B   R0H,@H''4001 ; *Turn off the heater'#13#10 +
    '        BRA     EXIT         ;'#13#10 +
    'ON:     MOV.B   @H''4001,R0H ; When the sensor is 1'#13#10 +
    '        OR.B    #H''01,R0H   ;'#13#10 +
    '        MOV.B   R0H,@H''4001 ; *Turn on the heater'#13#10 +
    'EXIT:   BRA     EXIT';
end;

initialization
  MakeIdentTable;
{$IFNDEF SYN_CPPB_1}                                                            //mh 2000-07-14
  RegisterPlaceableHighlighter(TSynH8Syn);
{$ENDIF}
end.