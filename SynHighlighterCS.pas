{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: SynHighlighterCS.pas, released 2001-10-28.
The Original Code is based on SynHighlighterCpp.pas, released 2000-04-10,
which in turn is based on the dcjCppSyn.pas file from the mwEdit component
suite by Martin Waldenburg and other developers, the Initial Author of this file
is Michael Trier. All Rights Reserved.

Contributors to the SynEdit and mwEdit projects are listed in the
Contributors.txt file.

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.

$Id: SynHighlighterCS.pas,v 1.1.1.1 2009/01/12 02:38:17 jhansen Exp $

You may retrieve the latest version of SynEdit from the SynEdit home page,
located at http://SynEdit.SourceForge.net

You may retrieve the latest version of this file from
http://www.ashleybrown.co.uk/synedit/

Known Issues:
  - strings on multiple lines are not supported 
-------------------------------------------------------------------------------}
{
@abstract(Provides a C# syntax highlighter for SynEdit)
@author(Ashley Brown)
@created(2001)
@lastmod(2001-10-20)
The SynHighlighterCS unit provides SynEdit with a C# syntax highlighter.
Based on SynHighlighterCpp.pas
}
unit SynHighlighterCS;

{$I BricxCCSynEdit.inc}

interface

uses
  SysUtils, Classes, Graphics, SynEditTypes, SynEditHighlighter;

type
  TtkTokenKind = (tkAsm, tkComment, tkDirective, tkIdentifier, tkKey, tkNull,
    tkNumber, tkSpace, tkString, tkSymbol, tkUnknown);

  TxtkTokenKind = (
    xtkAdd, xtkAddAssign, xtkAnd, xtkAndAssign, xtkArrow, xtkAssign,
    xtkBitComplement, xtkBraceClose, xtkBraceOpen, xtkColon, xtkComma,
    xtkDecrement, xtkDivide, xtkDivideAssign, xtkEllipse, xtkGreaterThan,
    xtkGreaterThanEqual, xtkIncOr, xtkIncOrAssign, xtkIncrement, xtkLessThan,
    xtkLessThanEqual, xtkLogAnd, xtkLogComplement, xtkLogEqual, xtkLogOr,
    xtkMod, xtkModAssign, xtkMultiplyAssign, xtkNotEqual, xtkPoint, xtkQuestion,
    xtkRoundClose, xtkRoundOpen, xtkScopeResolution, xtkSemiColon, xtkShiftLeft,
    xtkShiftLeftAssign, xtkShiftRight, xtkShiftRightAssign, xtkSquareClose,
    xtkSquareOpen, xtkStar, xtkSubtract, xtkSubtractAssign, xtkXor,
    xtkXorAssign);

  TRangeState = (rsUnknown, rsAnsiC, rsAnsiCAsm, rsAnsiCAsmBlock, rsAsm,
    rsAsmBlock, rsDirective, rsDirectiveComment, rsString34, rsString39,
    rsMultiLineString);                                                         //ek 2001-08-02

  TProcTableProc = procedure of object;

  PIdentFuncTableFunc = ^TIdentFuncTableFunc;
  TIdentFuncTableFunc = function: TtkTokenKind of object;

  TSynCSSyn = class(TSynCustomHighlighter)
  private
    fAsmStart: Boolean;
    fRange: TRangeState;
    fLine: PChar;
    fProcTable: array[#0..#255] of TProcTableProc;
    Run: LongInt;
    fStringLen: Integer;
    fToIdent: PChar;
    fTokenPos: Integer;
    FTokenID: TtkTokenKind;
    FExtTokenID: TxtkTokenKind;
    fLineNumber: Integer;
    fIdentFuncTable: array[0..206] of TIdentFuncTableFunc;
    fAsmAttri: TSynHighlighterAttributes;
    fCommentAttri: TSynHighlighterAttributes;
    fDirecAttri: TSynHighlighterAttributes;
    fIdentifierAttri: TSynHighlighterAttributes;
    fInvalidAttri: TSynHighlighterAttributes;
    fKeyAttri: TSynHighlighterAttributes;
    fNumberAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;
    fStringAttri: TSynHighlighterAttributes;
    fSymbolAttri: TSynHighlighterAttributes;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: String): Boolean;
    function Func17: TtkTokenKind;
	function Func21: TtkTokenKind;
	function Func22: TtkTokenKind;
	function Func25: TtkTokenKind;
	function Func30: TtkTokenKind;
	function Func31: TtkTokenKind;
	function Func32: TtkTokenKind;
	function Func34: TtkTokenKind;
	function Func40: TtkTokenKind;
	function Func42: TtkTokenKind;
	function Func45: TtkTokenKind;
	function Func46: TtkTokenKind;
	function Func48: TtkTokenKind;
	function Func52: TtkTokenKind;
	function Func53: TtkTokenKind;
	function Func54: TtkTokenKind;
	function Func56: TtkTokenKind;
	function Func57: TtkTokenKind;
	function Func59: TtkTokenKind;
    function Func60: TtkTokenKind;
    function Func61: TtkTokenKind;
	function Func62: TtkTokenKind;
	function Func63: TtkTokenKind;
	function Func65: TtkTokenKind;
    function Func66: TtkTokenKind;
    function Func67: TtkTokenKind;
    function Func68: TtkTokenKind;
    function Func69: TtkTokenKind;
	function Func71: TtkTokenKind;
	function Func72: TtkTokenKind;
	function Func74: TtkTokenKind;
	function Func75: TtkTokenKind;
	function Func76: TtkTokenKind;
	function Func78: TtkTokenKind;
	function Func83: TtkTokenKind;
	function Func86: TtkTokenKind;
	function Func88: TtkTokenKind;
	function Func89: TtkTokenKind;
	function Func90: TtkTokenKind;
	function Func92: TtkTokenKind;
	function Func93: TtkTokenKind;
	function Func98: TtkTokenKind;
	function Func99: TtkTokenKind;
	function Func101: TtkTokenKind;
	function Func102: TtkTokenKind;
	function Func104: TtkTokenKind;
	function Func106: TtkTokenKind;
    function Func107: TtkTokenKind;
    function Func109: TtkTokenKind;
    function Func110: TtkTokenKind;
    function Func115: TtkTokenKind;
	function Func116: TtkTokenKind;

	procedure AnsiCProc;
    procedure AndSymbolProc;
    procedure AsciiCharProc;
    procedure AtSymbolProc;
    procedure BraceCloseProc;
    procedure BraceOpenProc;
    procedure CRProc;
    procedure ColonProc;
    procedure CommaProc;
    procedure DirectiveProc;
    procedure EqualProc;
    procedure GreaterProc;
    procedure IdentProc;
    procedure LFProc;
    procedure LowerProc;
    procedure MinusProc;
    procedure ModSymbolProc;
    procedure NotSymbolProc;
    procedure NullProc;
    procedure NumberProc;
    procedure OrSymbolProc;
    procedure PlusProc;
    procedure PointProc;
    procedure QuestionProc;
    procedure RoundCloseProc;
    procedure RoundOpenProc;
    procedure SemiColonProc;
    procedure SlashProc;
    procedure SpaceProc;
    procedure SquareCloseProc;
    procedure SquareOpenProc;
    procedure StarProc;
    procedure StringProc;
    procedure TildeProc;
    procedure XOrSymbolProc;
    procedure UnknownProc;
    function AltFunc: TtkTokenKind;
    procedure InitIdent;
    function IdentKind(MayBe: PChar): TtkTokenKind;
    procedure MakeMethodTables;
    procedure StringEndProc;
  protected
    function GetSampleSource: string; override;
    function GetIdentChars: TSynIdentChars; override;
    function GetExtTokenID: TxtkTokenKind;
  public
    {$IFNDEF SYN_CPPB_1} class {$ENDIF}                                         //mh 2000-07-14
    function GetCapabilities: TSynHighlighterCapabilities; override;
    {$IFNDEF SYN_CPPB_1} class {$ENDIF}                                         //mh 2000-07-14
    function GetLanguageName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
      override;
    function GetEol: Boolean; override;
    function GetRange: Pointer; override;
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
    procedure SetRange(Value: Pointer); override;
    procedure ResetRange; override;
    function UseUserSettings(settingIndex: integer): boolean; override;
    procedure EnumUserSettings(settings: TStrings); override;
    property ExtTokenID: TxtkTokenKind read GetExtTokenID;
  published
    property AsmAttri: TSynHighlighterAttributes read fAsmAttri write fAsmAttri;
    property CommentAttri: TSynHighlighterAttributes read fCommentAttri
      write fCommentAttri;
    property DirecAttri: TSynHighlighterAttributes read fDirecAttri
      write fDirecAttri;
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri
      write fIdentifierAttri;
    property InvalidAttri: TSynHighlighterAttributes read fInvalidAttri
      write fInvalidAttri;
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
  uCommonUtils,
  SynEditStrConst;

var
  Identifiers: array[#0..#255] of ByteBool;
  mHashTable: array[#0..#255] of Integer;

procedure MakeIdentTable;
var
  I: Char;
begin
  for I := #0 to #255 do
  begin
    Case I of
      '_', '0'..'9', 'a'..'z', 'A'..'Z': Identifiers[I] := True;
    else Identifiers[I] := False;
    end;
    Case I in['_', 'a'..'z', 'A'..'Z'] of
      True:
        begin
          if (I > #64) and (I < #91) then mHashTable[I] := Ord(I) - 64 else
            if (I > #96) then mHashTable[I] := Ord(I) - 95;
        end;
    else mHashTable[I] := 0;
    end;
  end;
end;

procedure TSynCSSyn.InitIdent;
var
  I: Integer;
  pF: PIdentFuncTableFunc;
begin
  pF := PIdentFuncTableFunc(@fIdentFuncTable);
  for I := Low(fIdentFuncTable) to High(fIdentFuncTable) do begin
    pF^ := {$IFDEF FPC}@{$ENDIF}AltFunc;
    Inc(pF);
  end;
  fIdentFuncTable[17] := {$IFDEF FPC}@{$ENDIF}Func17;
  fIdentFuncTable[21] := {$IFDEF FPC}@{$ENDIF}Func21;
  fIdentFuncTable[22] := {$IFDEF FPC}@{$ENDIF}Func22;
  fIdentFuncTable[25] := {$IFDEF FPC}@{$ENDIF}Func25;
  fIdentFuncTable[30] := {$IFDEF FPC}@{$ENDIF}Func30;
  fIdentFuncTable[31] := {$IFDEF FPC}@{$ENDIF}Func31;
  fIdentFuncTable[32] := {$IFDEF FPC}@{$ENDIF}Func32;
  fIdentFuncTable[34] := {$IFDEF FPC}@{$ENDIF}Func34;
  fIdentFuncTable[40] := {$IFDEF FPC}@{$ENDIF}Func40;
  fIdentFuncTable[42] := {$IFDEF FPC}@{$ENDIF}Func42;
  fIdentFuncTable[45] := {$IFDEF FPC}@{$ENDIF}Func45;
  fIdentFuncTable[46] := {$IFDEF FPC}@{$ENDIF}Func46;
  fIdentFuncTable[48] := {$IFDEF FPC}@{$ENDIF}Func48;
  fIdentFuncTable[52] := {$IFDEF FPC}@{$ENDIF}Func52;
  fIdentFuncTable[53] := {$IFDEF FPC}@{$ENDIF}Func53;
  fIdentFuncTable[54] := {$IFDEF FPC}@{$ENDIF}Func54;
  fIdentFuncTable[56] := {$IFDEF FPC}@{$ENDIF}Func56;
  fIdentFuncTable[57] := {$IFDEF FPC}@{$ENDIF}Func57;
  fIdentFuncTable[59] := {$IFDEF FPC}@{$ENDIF}Func59;
  fIdentFuncTable[60] := {$IFDEF FPC}@{$ENDIF}Func60;
  fIdentFuncTable[61] := {$IFDEF FPC}@{$ENDIF}Func61;
  fIdentFuncTable[62] := {$IFDEF FPC}@{$ENDIF}Func62;
  fIdentFuncTable[63] := {$IFDEF FPC}@{$ENDIF}Func63;
  fIdentFuncTable[65] := {$IFDEF FPC}@{$ENDIF}Func65;
  fIdentFuncTable[66] := {$IFDEF FPC}@{$ENDIF}Func66;
  fIdentFuncTable[67] := {$IFDEF FPC}@{$ENDIF}Func67;
  fIdentFuncTable[68] := {$IFDEF FPC}@{$ENDIF}Func68;
  fIdentFuncTable[69] := {$IFDEF FPC}@{$ENDIF}Func69;
  fIdentFuncTable[71] := {$IFDEF FPC}@{$ENDIF}Func71;
  fIdentFuncTable[72] := {$IFDEF FPC}@{$ENDIF}Func72;
  fIdentFuncTable[74] := {$IFDEF FPC}@{$ENDIF}Func74;
  fIdentFuncTable[75] := {$IFDEF FPC}@{$ENDIF}Func75;
  fIdentFuncTable[76] := {$IFDEF FPC}@{$ENDIF}Func76;
  fIdentFuncTable[78] := {$IFDEF FPC}@{$ENDIF}Func78;
  fIdentFuncTable[83] := {$IFDEF FPC}@{$ENDIF}Func83;
  fIdentFuncTable[86] := {$IFDEF FPC}@{$ENDIF}Func86;
  fIdentFuncTable[88] := {$IFDEF FPC}@{$ENDIF}Func88;
  fIdentFuncTable[89] := {$IFDEF FPC}@{$ENDIF}Func89;
  fIdentFuncTable[90] := {$IFDEF FPC}@{$ENDIF}Func90;
  fIdentFuncTable[92] := {$IFDEF FPC}@{$ENDIF}Func92;
  fIdentFuncTable[93] := {$IFDEF FPC}@{$ENDIF}Func93;
  fIdentFuncTable[98] := {$IFDEF FPC}@{$ENDIF}Func98;
  fIdentFuncTable[99] := {$IFDEF FPC}@{$ENDIF}Func99;
  fIdentFuncTable[101] := {$IFDEF FPC}@{$ENDIF}Func101;
  fIdentFuncTable[102] := {$IFDEF FPC}@{$ENDIF}Func102;
  fIdentFuncTable[104] := {$IFDEF FPC}@{$ENDIF}Func104;
  fIdentFuncTable[106] := {$IFDEF FPC}@{$ENDIF}Func106;
  fIdentFuncTable[107] := {$IFDEF FPC}@{$ENDIF}Func107;
  fIdentFuncTable[109] := {$IFDEF FPC}@{$ENDIF}Func109;
  fIdentFuncTable[110] := {$IFDEF FPC}@{$ENDIF}Func110;
  fIdentFuncTable[115] := {$IFDEF FPC}@{$ENDIF}Func115;
  fIdentFuncTable[116] := {$IFDEF FPC}@{$ENDIF}Func116;
end;

function TSynCSSyn.KeyHash(ToHash: PChar): Integer;
begin
  Result := 0;
  while ToHash^ in ['_', '0'..'9', 'a'..'z', 'A'..'Z'] do
  begin
    inc(Result, mHashTable[ToHash^]);
    inc(ToHash);
  end;
  fStringLen := ToHash - fToIdent;
end; { KeyHash }

function TSynCSSyn.KeyComp(const aKey: String): Boolean;
var
  I: Integer;
  Temp: PChar;
begin
  Temp := fToIdent;
  if Length(aKey) = fStringLen then
  begin
    Result := True;
    for i := 1 to fStringLen do
    begin
	  if Temp^ <> aKey[i] then
      begin
        Result := False;
        break;
      end;
      inc(Temp);
    end;
  end else Result := False;
end; { KeyComp }

function TSynCSSyn.Func17: TtkTokenKind;
begin
  if KeyComp('if') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func21: TtkTokenKind;
begin
  if KeyComp('do') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func22: TtkTokenKind;
begin
  if KeyComp('as') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func25: TtkTokenKind;
begin
  if KeyComp('in') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func30: TtkTokenKind;
begin
  if KeyComp('is') then Result := tkKey else Result := tkIdentifier;
end;


function TSynCSSyn.Func32: TtkTokenKind;
begin
  if KeyComp('ref') then Result := tkKey else
	  if KeyComp('case') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func31: TtkTokenKind;
begin
  if KeyComp('base') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func34: TtkTokenKind;
begin
  if KeyComp('char') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func40: TtkTokenKind;
begin
  if KeyComp('catch') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func42: TtkTokenKind;
begin
  if KeyComp('for') then Result := tkKey else
    if KeyComp('break') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func45: TtkTokenKind;
begin
  if KeyComp('lock') then Result := tkKey else
    if KeyComp('else') then Result := tkKey else
      if KeyComp('new') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func46: TtkTokenKind;
begin
  if KeyComp('checked') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func48: TtkTokenKind;
begin
  if KeyComp('false') then Result := tkKey else
	if KeyComp('bool') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func52: TtkTokenKind;
begin
  if KeyComp('sealed') then Result := tkKey else
    if KeyComp('long') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func53: TtkTokenKind;
begin
  if KeyComp('fixed') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func54: TtkTokenKind;
begin
  if KeyComp('decimal') then Result := tkKey else
    if KeyComp('void') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func56: TtkTokenKind;
begin
  if KeyComp('byte') then Result := tkKey else Result := tkIdentifier;
end;


function TSynCSSyn.Func57: TtkTokenKind;
begin
  if KeyComp('enum') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func59: TtkTokenKind;
begin
  if KeyComp('out') then Result := tkKey else
    if KeyComp('class') then Result := tkKey else
      if KeyComp('float') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func60: TtkTokenKind;
begin
  if KeyComp('this') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func61: TtkTokenKind;
begin
  if KeyComp('object') then Result := tkKey else  
    if KeyComp('goto') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func62: TtkTokenKind;
begin
    
  if KeyComp('while') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func63: TtkTokenKind;
begin
  if KeyComp('foreach') then Result := tkKey else    
    if KeyComp('null') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func65: TtkTokenKind;
begin
  if KeyComp('double') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func66: TtkTokenKind;
begin
  if KeyComp('try') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func67: TtkTokenKind;
begin
    if KeyComp('delegate') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func68: TtkTokenKind;
begin
  if KeyComp('uint') then Result := tkKey else    
    if KeyComp('true') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func69: TtkTokenKind;
begin
  
  if KeyComp('public') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func71: TtkTokenKind;
begin
  if KeyComp('event') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func72: TtkTokenKind;
begin
  if KeyComp('unsafe') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func74: TtkTokenKind;
begin
  if KeyComp('ulong') then Result := tkKey else    
    if KeyComp('params') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func75: TtkTokenKind;
begin
    if KeyComp('using') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func76: TtkTokenKind;
begin
  if KeyComp('sbyte') then Result := tkKey else
    if KeyComp('const') then Result := tkKey else
      if KeyComp('default') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func78: TtkTokenKind;
begin
  if KeyComp('static') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func83: TtkTokenKind;
begin
  if KeyComp('unchecked') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func86: TtkTokenKind;
begin
  if KeyComp('sizeof') then Result := tkKey else
    if KeyComp('finally') then Result := tkKey else
      if KeyComp('namespace') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func88: TtkTokenKind;
begin
  
  if KeyComp('switch') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func89: TtkTokenKind;
begin
  if KeyComp('throw') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func90: TtkTokenKind;
begin
  if KeyComp('interface') then Result := tkKey else Result := tkIdentifier;
end;


function TSynCSSyn.Func92: TtkTokenKind;
begin
  if KeyComp('abstract') then Result := tkKey else
    if KeyComp('extern') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func93: TtkTokenKind;
begin
  if KeyComp('typeof') then Result := tkKey else
	if KeyComp('string') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func98: TtkTokenKind;
begin
  if KeyComp('private') then Result := tkKey else Result := tkIdentifier;
end;


function TSynCSSyn.Func99: TtkTokenKind;
begin
  if KeyComp('implicit') then Result := tkKey else Result := tkIdentifier;
end;


function TSynCSSyn.Func101: TtkTokenKind;
begin
  if KeyComp('internal') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func102: TtkTokenKind;
begin
  if KeyComp('readonly') then Result := tkKey else
    if KeyComp('return') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func104: TtkTokenKind;
begin
  if KeyComp('override') then Result := tkKey else Result := tkIdentifier;
end;


function TSynCSSyn.Func106: TtkTokenKind;
begin
  if KeyComp('explicit') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func107: TtkTokenKind;
begin
  if KeyComp('ushort') then Result := tkKey else
    if KeyComp('stackalloc') then Result := tkKey else
      if KeyComp('struct') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func109: TtkTokenKind;
begin
    
  if KeyComp('continue') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func110: TtkTokenKind;
begin
  if KeyComp('virtual') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func115: TtkTokenKind;
begin
  if KeyComp('protected') then Result := tkKey else Result := tkIdentifier;
end;

function TSynCSSyn.Func116: TtkTokenKind;
begin
  if KeyComp('operator') then Result := tkKey else Result := tkIdentifier;
end;


function TSynCSSyn.AltFunc: TtkTokenKind;
begin
  Result := tkIdentifier;
end;

function TSynCSSyn.IdentKind(MayBe: PChar): TtkTokenKind;
var
  HashKey: Integer;
begin
  fToIdent := MayBe;
  HashKey := KeyHash(MayBe);
  if HashKey < 207 then
    Result := fIdentFuncTable[HashKey]()
  else
    Result := tkIdentifier;
end;

procedure TSynCSSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      '&': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}AndSymbolProc;
      #39: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}AsciiCharProc;
      '@': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}AtSymbolProc;
      '}': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}BraceCloseProc;
      '{': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}BraceOpenProc;
      #13: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}CRProc;
      ':': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}ColonProc;
      ',': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}CommaProc;
      '#': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}DirectiveProc;
      '=': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}EqualProc;
      '>': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}GreaterProc;
      '?': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}QuestionProc;
      'A'..'Z', 'a'..'z', '_': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}IdentProc;
      #10: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LFProc;
      '<': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LowerProc;
      '-': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}MinusProc;
      '%': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}ModSymbolProc;
      '!': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NotSymbolProc;
      #0: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NullProc;
      '0'..'9': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NumberProc;
      '|': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}OrSymbolProc;
      '+': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}PlusProc;
      '.': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}PointProc;
      ')': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}RoundCloseProc;
      '(': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}RoundOpenProc;
      ';': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SemiColonProc;
      '/': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SlashProc;
      #1..#9, #11, #12, #14..#32: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SpaceProc;
      ']': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SquareCloseProc;
      '[': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SquareOpenProc;
      '*': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}StarProc;
      #34: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}StringProc;
      '~': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}TildeProc;
      '^': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}XOrSymbolProc;
      else fProcTable[I] := {$IFDEF FPC}@{$ENDIF}UnknownProc;
    end;
end;

constructor TSynCSSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fAsmAttri := TSynHighlighterAttributes.Create(SYNS_AttrAssembler);
  AddAttribute(fAsmAttri);
  fCommentAttri := TSynHighlighterAttributes.Create(SYNS_AttrComment);
  fCommentAttri.Style:= [fsItalic];
  AddAttribute(fCommentAttri);
  fIdentifierAttri := TSynHighlighterAttributes.Create(SYNS_AttrIdentifier);
  AddAttribute(fIdentifierAttri);
  fInvalidAttri := TSynHighlighterAttributes.Create(SYNS_AttrIllegalChar);
  AddAttribute(fInvalidAttri);
  fKeyAttri := TSynHighlighterAttributes.Create(SYNS_AttrReservedWord);
  fKeyAttri.Style:= [fsBold];
  AddAttribute(fKeyAttri);
  fNumberAttri := TSynHighlighterAttributes.Create(SYNS_AttrNumber);
  AddAttribute(fNumberAttri);
  fSpaceAttri := TSynHighlighterAttributes.Create(SYNS_AttrSpace);
  fSpaceAttri.Foreground := clWindow;
  AddAttribute(fSpaceAttri);
  fStringAttri := TSynHighlighterAttributes.Create(SYNS_AttrString);
  AddAttribute(fStringAttri);
  fSymbolAttri := TSynHighlighterAttributes.Create(SYNS_AttrSymbol);
  AddAttribute(fSymbolAttri);
  fDirecAttri := TSynHighlighterAttributes.Create(SYNS_AttrPreprocessor);
  AddAttribute(fDirecAttri);
  SetAttributesOnChange({$IFDEF FPC}@{$ENDIF}DefHighlightChange);
  InitIdent;
  MakeMethodTables;
  fRange := rsUnknown;
  fAsmStart := False;
  fDefaultFilter := 'C# Files (*.cs)|*.cs';
end; { Create }

procedure TSynCSSyn.SetLine({$IFDEF FPC}const {$ENDIF}NewValue: String; LineNumber:Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end; { SetLine }

procedure TSynCSSyn.AnsiCProc;
begin
  fTokenID := tkComment;
  case FLine[Run] of
    #0:
      begin
        NullProc;
        exit;
      end;
    #10:
      begin
        LFProc;
        exit;
      end;
    #13:
      begin
        CRProc;
        exit;
      end;
  end;

  while FLine[Run] <> #0 do
    case FLine[Run] of
      '*':
        if fLine[Run + 1] = '/' then
        begin
          inc(Run, 2);
          if fRange = rsAnsiCAsm then
            fRange := rsAsm
          else if fRange = rsAnsiCAsmBlock then
            fRange := rsAsmBlock
          else if fRange = rsDirectiveComment then
            fRange := rsDirective
          else
            fRange := rsUnKnown;
          break;
        end else
          inc(Run);
      #10: break;
      #13: break;
    else inc(Run);
    end;
end;

procedure TSynCSSyn.AndSymbolProc;
begin
  fTokenID := tkSymbol;
  case FLine[Run + 1] of
    '=':                               {and assign}
      begin
        inc(Run, 2);
        FExtTokenID := xtkAndAssign;
      end;
    '&':                               {logical and}
      begin
        inc(Run, 2);
        FExtTokenID := xtkLogAnd;
      end;
  else                                 {and}
    begin
      inc(Run);
      FExtTokenID := xtkAnd;
    end;
  end;
end;

procedure TSynCSSyn.AsciiCharProc;
begin
  fTokenID := tkString;
  repeat
    if fLine[Run] = '\' then begin
      if fLine[Run + 1] in [#39, '\'] then                                      //ek 2000-04-26
        inc(Run);
    end;
    inc(Run);
  until fLine[Run] in [#0, #10, #13, #39];
  if fLine[Run] = #39 then
    inc(Run);
end;

procedure TSynCSSyn.AtSymbolProc;
begin
  fTokenID := tkUnknown;
  inc(Run);
end;

procedure TSynCSSyn.BraceCloseProc;
begin
  inc(Run);
  fTokenId := tkSymbol;
  FExtTokenID := xtkBraceClose;
  if fRange = rsAsmBlock then fRange := rsUnknown;
end;

procedure TSynCSSyn.BraceOpenProc;
begin
  inc(Run);
  fTokenId := tkSymbol;
  FExtTokenID := xtkBraceOpen;
  if fRange = rsAsm then
  begin
    fRange := rsAsmBlock;
    fAsmStart := True;
  end;
end;

procedure TSynCSSyn.CRProc;
begin
  fTokenID := tkSpace;
  Inc(Run);
  if fLine[Run + 1] = #10 then Inc(Run);
end;

procedure TSynCSSyn.ColonProc;
begin
  fTokenID := tkSymbol;
  Case FLine[Run + 1] of
    ':':                               {scope resolution operator}
      begin
        inc(Run, 2);
        FExtTokenID := xtkScopeResolution;
      end;
  else                                 {colon}
    begin
      inc(Run);
      FExtTokenID := xtkColon;
    end;
  end;
end;

procedure TSynCSSyn.CommaProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
  FExtTokenID := xtkComma;
end;

procedure TSynCSSyn.DirectiveProc;
begin
  if fLine[Run] in [#0, #10, #13] then begin
    if (Run <= 0) or (fLine[Run - 1] <> '\') then
      fRange := rsUnknown;
    fProcTable[fLine[Run]];
  end else begin
    fTokenID := tkDirective;
    while TRUE do
      case fLine[Run] of
        '/': // comment?
          begin
            if fLine[Run + 1] = '/' then begin // is end of directive as well
              fRange := rsUnknown;                                              //ek 2000-04-25
              break;
            end else if fLine[Run + 1] = '*' then begin // might be embedded only
              fRange := rsDirectiveComment;
              break;
            end else
              Inc(Run);
          end;
        '\': // directive continued on next line?
          begin
            Inc(Run);
            if fLine[Run] in [#0, #10, #13] then begin
              fRange := rsDirective;
              break;
            end;
          end;
        #0, #10, #13:
          begin
            fRange := rsUnknown;
            break;
          end;
        else Inc(Run);
      end;
  end;
end;

procedure TSynCSSyn.EqualProc;
begin
  fTokenID := tkSymbol;
  case FLine[Run + 1] of
    '=':                               {logical equal}
      begin
        inc(Run, 2);
        FExtTokenID := xtkLogEqual;
      end;
  else                                 {assign}
    begin
      inc(Run);
      FExtTokenID := xtkAssign;
    end;
  end;
end;

procedure TSynCSSyn.GreaterProc;
begin
  fTokenID := tkSymbol;
  Case FLine[Run + 1] of
    '=':                               {greater than or equal to}
      begin
        inc(Run, 2);
        FExtTokenID := xtkGreaterThanEqual;
      end;
    '>':
      begin
        if FLine[Run + 2] = '=' then   {shift right assign}
        begin
          inc(Run, 3);
          FExtTokenID := xtkShiftRightAssign;
        end
        else                           {shift right}
        begin
          inc(Run, 2);
          FExtTokenID := xtkShiftRight;
        end;
      end;
  else                                 {greater than}
    begin
      inc(Run);
      FExtTokenID := xtkGreaterThan;
    end;
  end;
end;

procedure TSynCSSyn.QuestionProc;
begin
  fTokenID := tkSymbol;                {conditional}
  FExtTokenID := xtkQuestion;
  inc(Run);
end;

procedure TSynCSSyn.IdentProc;
begin
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
end;

procedure TSynCSSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TSynCSSyn.LowerProc;
begin
  fTokenID := tkSymbol;
  case FLine[Run + 1] of
    '=':                               {less than or equal to}
      begin
        inc(Run, 2);
        FExtTokenID := xtkLessThanEqual;
      end;
    '<':
      begin
        if FLine[Run + 2] = '=' then   {shift left assign}
        begin
          inc(Run, 3);
          FExtTokenID := xtkShiftLeftAssign;
        end
        else                           {shift left}
        begin
          inc(Run, 2);
          FExtTokenID := xtkShiftLeft;
        end;
      end;
  else                                 {less than}
    begin
      inc(Run);
      FExtTokenID := xtkLessThan;
    end;
  end;
end;

procedure TSynCSSyn.MinusProc;
begin
  fTokenID := tkSymbol;
  case FLine[Run + 1] of
    '=':                               {subtract assign}
      begin
        inc(Run, 2);
        FExtTokenID := xtkSubtractAssign;
      end;
    '-':                               {decrement}
      begin
        inc(Run, 2);
        FExtTokenID := xtkDecrement;
      end;
    '>':                               {arrow}
      begin
        inc(Run, 2);
        FExtTokenID := xtkArrow;
      end;
  else                                 {subtract}
    begin
      inc(Run);
      FExtTokenID := xtkSubtract;
    end;
  end;
end;

procedure TSynCSSyn.ModSymbolProc;
begin
  fTokenID := tkSymbol;
  case FLine[Run + 1] of
    '=':                               {mod assign}
      begin
        inc(Run, 2);
        FExtTokenID := xtkModAssign;
      end;
  else                                 {mod}
    begin
      inc(Run);
      FExtTokenID := xtkMod;
    end;
  end;
end;

procedure TSynCSSyn.NotSymbolProc;
begin
  fTokenID := tkSymbol;
  case FLine[Run + 1] of
    '=':                               {not equal}
      begin
        inc(Run, 2);
        FExtTokenID := xtkNotEqual;
      end;
  else                                 {not}
    begin
      inc(Run);
      FExtTokenID := xtkLogComplement;
    end;
  end;
end;

procedure TSynCSSyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TSynCSSyn.NumberProc;
begin
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in
    ['0'..'9', 'A'..'F', 'a'..'f', '.', 'u', 'U', 'l', 'L', 'x', 'X'] do
  begin
    case FLine[Run] of
      '.':
        if FLine[Run + 1] = '.' then break;
    end;
    inc(Run);
  end;
end;

procedure TSynCSSyn.OrSymbolProc;
begin
  fTokenID := tkSymbol;
  case FLine[Run + 1] of
    '=':                               {or assign}
      begin
        inc(Run, 2);
        FExtTokenID := xtkIncOrAssign;
      end;
    '|':                               {logical or}
      begin
        inc(Run, 2);
        FExtTokenID := xtkLogOr;
      end;
  else                                 {or}
    begin
      inc(Run);
      FExtTokenID := xtkIncOr;
    end;
  end;
end;

procedure TSynCSSyn.PlusProc;
begin
  fTokenID := tkSymbol;
  case FLine[Run + 1] of
    '=':                               {add assign}
      begin
        inc(Run, 2);
        FExtTokenID := xtkAddAssign;
      end;
    '+':                               {increment}
      begin
        inc(Run, 2);
        FExtTokenID := xtkIncrement;
      end;
  else                                 {add}
    begin
      inc(Run);
      FExtTokenID := xtkAdd;
    end;
  end;
end;

procedure TSynCSSyn.PointProc;
begin
  fTokenID := tkSymbol;
  if (FLine[Run + 1] = '.') and (FLine[Run + 2] = '.') then
    begin                              {ellipse}
      inc(Run, 3);
      FExtTokenID := xtkEllipse;
    end
  else                                 {point}
    begin
      inc(Run);
      FExtTokenID := xtkPoint;
    end;
end;

procedure TSynCSSyn.RoundCloseProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
  FExtTokenID := xtkRoundClose;
end;

procedure TSynCSSyn.RoundOpenProc;
begin
  inc(Run);
  FTokenID := tkSymbol;
  FExtTokenID := xtkRoundOpen;
end;

procedure TSynCSSyn.SemiColonProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
  FExtTokenID := xtkSemiColon;
  if fRange = rsAsm then fRange := rsUnknown;
end;

procedure TSynCSSyn.SlashProc;
begin
  case FLine[Run + 1] of
    '/':                               {c++ style comments}
      begin
        fTokenID := tkComment;
        inc(Run, 2);
        while not (fLine[Run] in [#0, #10, #13]) do Inc(Run);
      end;
    '*':                               {c style comments}
      begin
        fTokenID := tkComment;
        if fRange = rsAsm then
          fRange := rsAnsiCAsm
        else if fRange = rsAsmBlock then
          fRange := rsAnsiCAsmBlock
        else if fRange <> rsDirectiveComment then
          fRange := rsAnsiC;
        inc(Run, 2);
        while fLine[Run] <> #0 do
          case fLine[Run] of
            '*':
              if fLine[Run + 1] = '/' then
              begin
                inc(Run, 2);
                if fRange = rsDirectiveComment then
                  fRange := rsDirective
                else if fRange = rsAnsiCAsm then
                  fRange := rsAsm
                else
                  begin
                  if fRange = rsAnsiCAsmBlock then
                    fRange := rsAsmBlock
                  else
                    fRange := rsUnKnown;
                  end;
                break;
              end else inc(Run);
            #10, #13:
              begin
                if fRange = rsDirectiveComment then
                  fRange := rsAnsiC;
                break;
              end;
          else inc(Run);
          end;
      end;
    '=':                               {divide assign}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        FExtTokenID := xtkDivideAssign;
      end;
  else                                 {divide}
    begin
      inc(Run);
      fTokenID := tkSymbol;
      FExtTokenID := xtkDivide;
    end;
  end;
end;

procedure TSynCSSyn.SpaceProc;
begin
  inc(Run);
  fTokenID := tkSpace;
  while FLine[Run] in [#1..#9, #11, #12, #14..#32] do inc(Run);
end;

procedure TSynCSSyn.SquareCloseProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
  FExtTokenID := xtkSquareClose;
end;

procedure TSynCSSyn.SquareOpenProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
  FExtTokenID := xtkSquareOpen;
end;

procedure TSynCSSyn.StarProc;
begin
  fTokenID := tkSymbol;
  case FLine[Run + 1] of
    '=':                               {multiply assign}
      begin
        inc(Run, 2);
        FExtTokenID := xtkMultiplyAssign;
      end;
  else                                 {star}
    begin
      inc(Run);
      FExtTokenID := xtkStar;
    end;
  end;
end;

procedure TSynCSSyn.StringProc;
begin
  fTokenID := tkString;
  repeat
    if fLine[Run] = '\' then begin
      case fLine[Run + 1] of
        #34, '\':
          Inc(Run);
        #00:
          begin
            Inc(Run);
            fRange := rsMultilineString;
            Exit;
          end;
      end;
    end;
    inc(Run);
  until fLine[Run] in [#0, #10, #13, #34];
  if FLine[Run] = #34 then
    inc(Run);
end;

procedure TSynCSSyn.StringEndProc;
begin
  fTokenID := tkString;

  case FLine[Run] of
    #0:
      begin
        NullProc;
        Exit;
      end;
    #10:
      begin
        LFProc;
        Exit;
      end;
    #13:
      begin
        CRProc;
        Exit;
      end;
  end;

  fRange := rsUnknown;

  repeat
    case FLine[Run] of
      #0, #10, #13: Break;
      '\':
        begin
          case fLine[Run + 1] of
            #34, '\':
              Inc(Run);
            #00:
              begin
                Inc(Run);
                fRange := rsMultilineString;
                Exit;
              end;
          end;
        end;
      #34: Break;
    end;
    inc(Run);
  until fLine[Run] in [#0, #10, #13, #34];
  if FLine[Run] = #34 then
    inc(Run);
end;

procedure TSynCSSyn.TildeProc;
begin
  inc(Run);                            {bitwise complement}
  fTokenId := tkSymbol;
  FExtTokenID := xtkBitComplement;
end;

procedure TSynCSSyn.XOrSymbolProc;
begin
  fTokenID := tkSymbol;
  Case FLine[Run + 1] of
  	'=':                               {xor assign}
      begin
        inc(Run, 2);
        FExtTokenID := xtkXorAssign;
      end;
  else                                 {xor}
    begin
      inc(Run);
      FExtTokenID := xtkXor;
    end;
  end;
end;

procedure TSynCSSyn.UnknownProc;
begin
  inc(Run);
  fTokenID := tkUnknown;
end;

procedure TSynCSSyn.Next;
begin
  fAsmStart := False;
  fTokenPos := Run;
  case fRange of
    rsAnsiC, rsAnsiCAsm,
    rsAnsiCAsmBlock, rsDirectiveComment: AnsiCProc;
    rsDirective: DirectiveProc;
    rsMultilineString: StringEndProc;                                           //ek 2001-08-02    
  else
    begin
      fRange := rsUnknown;
      fProcTable[fLine[Run]];
    end;
  end;
end;

function TSynCSSyn.GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT: Result := fCommentAttri;
    SYN_ATTR_IDENTIFIER: Result := fIdentifierAttri;
    SYN_ATTR_KEYWORD: Result := fKeyAttri;
    SYN_ATTR_STRING: Result := fStringAttri;
    SYN_ATTR_WHITESPACE: Result := fSpaceAttri;
    else Result := nil;
  end;
end;

function TSynCSSyn.GetEol: Boolean;
begin
  Result := fTokenID = tkNull;
end;

function TSynCSSyn.GetRange: Pointer;
begin
{$IFDEF FPC}
  Result := Pointer(PtrInt(fRange));
{$ELSE}
  Result := Pointer(fRange);
{$ENDIF}
end;

function TSynCSSyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

{$IFDEF SYN_LAZARUS}
procedure TSynCSSyn.GetTokenEx(out TokenStart: PChar;
  out TokenLength: integer);
begin
  TokenLength:=Run-fTokenPos;
  TokenStart:=FLine + fTokenPos;
end;
{$ENDIF}

function TSynCSSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
  if ((fRange = rsAsm) or (fRange = rsAsmBlock)) and not fAsmStart
    and not (fTokenId in [tkComment, tkSpace, tkNull])
  then
    Result := tkAsm;
end;

function TSynCSSyn.GetExtTokenID: TxtkTokenKind;
begin
  Result := FExtTokenID;
end;

function TSynCSSyn.GetTokenAttribute: TSynHighlighterAttributes;
begin
  case fTokenID of
    tkAsm: Result := fAsmAttri;
    tkComment: Result := fCommentAttri;
    tkDirective: Result := fDirecAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkNumber: Result := fNumberAttri;
    tkSpace: Result := fSpaceAttri;
    tkString: Result := fStringAttri;
    tkSymbol: Result := fSymbolAttri;
    tkUnknown: Result := fInvalidAttri;
    else Result := nil;
  end;
end;

function TSynCSSyn.GetTokenKind: integer;
begin
  Result := Ord(GetTokenID);
end;

function TSynCSSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

procedure TSynCSSyn.ReSetRange;
begin
  fRange:= rsUnknown;
end;

procedure TSynCSSyn.SetRange(Value: Pointer);
begin
{$IFDEF FPC}
  fRange := TRangeState(PtrUInt(Value));
{$ELSE}
  fRange := TRangeState(Value);
{$ENDIF}
end;

procedure TSynCSSyn.EnumUserSettings(settings: TStrings);
begin
  { returns the user settings that exist in the registry }
  {$IFNDEF FPC}
  with TBetterRegistry.Create do
  begin
    try
      RootKey := HKEY_LOCAL_MACHINE;
      if OpenKeyReadOnly('\SOFTWARE\Borland\C++Builder') then
      begin
        try
          GetKeyNames(settings);
        finally
          CloseKey;
        end;
      end;
    finally
      Free;
    end;
  end;
  {$ENDIF}
end;

function TSynCSSyn.UseUserSettings(settingIndex: integer): boolean;
// Possible parameter values:
//   index into TStrings returned by EnumUserSettings
// Possible return values:
//   true : settings were read and used
//   false: problem reading settings or invalid version specified - old settings
//          were preserved

  {$IFNDEF FPC}
  function ReadCPPBSettings(settingIndex: integer): boolean;

    function ReadCPPBSetting(settingTag: string; attri: TSynHighlighterAttributes; key: string): boolean;

      function ReadCPPB1(settingTag: string; attri: TSynHighlighterAttributes; name: string): boolean;
      var
        i: integer;
      begin
        for i := 1 to Length(name) do
          if name[i] = ' ' then name[i] := '_';
        Result := attri.LoadFromBorlandRegistry(HKEY_CURRENT_USER,
             '\SOFTWARE\Borland\C++Builder\'+settingTag+'\Highlight',name,true);
      end; { ReadCPPB1 }

      function ReadCPPB3OrMore(settingTag: string; attri: TSynHighlighterAttributes; key: string): boolean;
      begin
        Result := attri.LoadFromBorlandRegistry(HKEY_CURRENT_USER,
                 '\Software\Borland\C++Builder\'+settingTag+'\Editor\Highlight',
                 key,false);
      end; { ReadCPPB3OrMore }

    begin { ReadCPPBSetting }
      try
        if (settingTag[1] = '1')
          then Result := ReadCPPB1(settingTag,attri,key)
          else Result := ReadCPPB3OrMore(settingTag,attri,key);
      except Result := false; end;
    end; { ReadCPPBSetting }

  var
    tmpStringAttri    : TSynHighlighterAttributes;
    tmpNumberAttri    : TSynHighlighterAttributes;
    tmpKeyAttri       : TSynHighlighterAttributes;
    tmpSymbolAttri    : TSynHighlighterAttributes;
    tmpAsmAttri       : TSynHighlighterAttributes;
    tmpCommentAttri   : TSynHighlighterAttributes;
    tmpIdentifierAttri: TSynHighlighterAttributes;
    tmpInvalidAttri   : TSynHighlighterAttributes;
    tmpSpaceAttri     : TSynHighlighterAttributes;
    tmpDirecAttri     : TSynHighlighterAttributes;
    s                 : TStringList;

  begin { ReadCPPBSettings }
    s := TStringList.Create;
    try
      EnumUserSettings(s);
      if settingIndex >= s.Count then Result := false
      else begin
        tmpStringAttri    := TSynHighlighterAttributes.Create('');
        tmpNumberAttri    := TSynHighlighterAttributes.Create('');
        tmpKeyAttri       := TSynHighlighterAttributes.Create('');
        tmpSymbolAttri    := TSynHighlighterAttributes.Create('');
        tmpAsmAttri       := TSynHighlighterAttributes.Create('');
        tmpCommentAttri   := TSynHighlighterAttributes.Create('');
        tmpIdentifierAttri:= TSynHighlighterAttributes.Create('');
        tmpInvalidAttri   := TSynHighlighterAttributes.Create('');
        tmpSpaceAttri     := TSynHighlighterAttributes.Create('');
        tmpDirecAttri     := TSynHighlighterAttributes.Create('');
        tmpStringAttri    .Assign(fStringAttri);
        tmpNumberAttri    .Assign(fNumberAttri);
        tmpKeyAttri       .Assign(fKeyAttri);
        tmpSymbolAttri    .Assign(fSymbolAttri);
        tmpAsmAttri       .Assign(fAsmAttri);
        tmpCommentAttri   .Assign(fCommentAttri);
        tmpIdentifierAttri.Assign(fIdentifierAttri);
        tmpInvalidAttri   .Assign(fInvalidAttri);
        tmpSpaceAttri     .Assign(fSpaceAttri);
        tmpDirecAttri     .Assign(fDirecAttri);
        if s[settingIndex][1] = '1'
          then Result := ReadCPPBSetting(s[settingIndex],fAsmAttri,'Plain text')
          else Result := ReadCPPBSetting(s[settingIndex],fAsmAttri,'Assembler');
        Result := Result                                                         and
                  ReadCPPBSetting(s[settingIndex],fCommentAttri,'Comment')       and
                  ReadCPPBSetting(s[settingIndex],fIdentifierAttri,'Identifier') and
                  ReadCPPBSetting(s[settingIndex],fInvalidAttri,'Illegal Char')  and 
                  ReadCPPBSetting(s[settingIndex],fKeyAttri,'Reserved word')     and
                  ReadCPPBSetting(s[settingIndex],fNumberAttri,'Integer')        and
                  ReadCPPBSetting(s[settingIndex],fSpaceAttri,'Whitespace')      and
                  ReadCPPBSetting(s[settingIndex],fStringAttri,'String')         and
                  ReadCPPBSetting(s[settingIndex],fSymbolAttri,'Symbol')         and
                  ReadCPPBSetting(s[settingIndex],fDirecAttri,'Preprocessor');
        if not Result then begin
          fStringAttri    .Assign(tmpStringAttri);
          fNumberAttri    .Assign(tmpNumberAttri);
          fKeyAttri       .Assign(tmpKeyAttri);
          fSymbolAttri    .Assign(tmpSymbolAttri);
          fAsmAttri       .Assign(tmpAsmAttri);
          fCommentAttri   .Assign(tmpCommentAttri);
          fIdentifierAttri.Assign(tmpIdentifierAttri);
          fInvalidAttri.Assign(tmpInvalidAttri);
          fSpaceAttri     .Assign(tmpSpaceAttri);
          fDirecAttri     .Assign(tmpDirecAttri);
        end;
        tmpStringAttri    .Free;
        tmpNumberAttri    .Free;
        tmpKeyAttri       .Free;
        tmpSymbolAttri    .Free;
        tmpAsmAttri       .Free;
        tmpCommentAttri   .Free;
        tmpIdentifierAttri.Free;
        tmpInvalidAttri   .Free;
        tmpSpaceAttri     .Free;
        tmpDirecAttri     .Free;
      end;
    finally s.Free; end;
  end; { ReadCPPBSettings }
  {$ENDIF}

begin
  {$IFNDEF FPC}
  Result := ReadCPPBSettings(settingIndex);
  {$ELSE}
  Result := False;
  {$ENDIF}
end; { TSynCSSyn.UseUserSettings }

function TSynCSSyn.GetIdentChars: TSynIdentChars;
begin
  Result := ['_', '0'..'9', 'a'..'z', 'A'..'Z'];
end;

{$IFNDEF SYN_CPPB_1} class {$ENDIF}                                             //mh 2000-07-14
function TSynCSSyn.GetLanguageName: string;
begin
  Result := 'C#';
end;

{$IFNDEF SYN_CPPB_1} class {$ENDIF}                                             //mh 2000-07-14
function TSynCSSyn.GetCapabilities: TSynHighlighterCapabilities;
begin
  Result := inherited GetCapabilities + [hcUserSettings];
end;

function TSynCSSyn.GetSampleSource: string;
begin
  Result := '// Syntax Highlighting'#13#10+
            'using System;'#13#10+
            '#define DEF_NUM 0'#13#10+
            'class HelloWorld'#13#10+
            '{'#13#10+
            ' public static void Main()'#13#10+
            ' {'#13#10+
            '  Console.WriteLine("Hello World");'#13#10+
            ' }'#13#10+
            ' public void DoSomething()'#13#10+
            ' {'#13#10+
            '   int number = 123456;'#13#10+
            '   for (int i = 0; i <= number; i++)'#13#10+
            '   {'#13#10+
            '     x += 1.0;'#13#10+
            '     x += @; /* illegal character */'#13#10+
            '   }'#13#10+
            ' }'#13#10+
            '}';
end;

initialization
  MakeIdentTable;
{$IFNDEF SYN_CPPB_1}                                                            //mh 2000-07-14
  RegisterPlaceableHighlighter(TSynCSSyn);
{$ENDIF}
end.

