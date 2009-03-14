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
unit SynHighlighterMindScript;

{$I BricxCCSynEdit.inc}

interface

uses
  Classes,
  SynEditTypes,
  SynEditHighlighter;

type
  TtkTokenKind = (tkCommand, tkComment, tkConstant, tkDirective,
    tkIdentifier, tkKey, tkNull, tkNumber, tkProperty, tkSpace, tkSymbol,
    tkHex, tkString, tkUnknown);

  TRangeState = (rsUnKnown, rsCStyle, rsString);

  TProcTableProc = procedure of object;

  PIdentFuncTableFunc = ^TIdentFuncTableFunc;
  TIdentFuncTableFunc = function: TtkTokenKind of object;

const
  MaxKey = 157;

type
  TSynMindScriptSyn = class(TSynCustomHighlighter)
  private
    fLine: PChar;
    fLineNumber: Integer;
    fProcTable: array[#0..#255] of TProcTableProc;
    fRange: TRangeState;
    Run: LongInt;
    fStringLen: Integer;
    fToIdent: PChar;
    fTokenPos: Integer;
    fTokenID: TtkTokenKind;
    fIdentFuncTable: array[0 .. MaxKey] of TIdentFuncTableFunc;
    fCommandAttri: TSynHighlighterAttributes;
    fCommentAttri: TSynHighlighterAttributes;
    fConstantAttri: TSynHighlighterAttributes;
    fDirecAttri: TSynHighlighterAttributes;
    fIdentifierAttri: TSynHighlighterAttributes;
    fKeyAttri: TSynHighlighterAttributes;
    fPropertyAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;
    fNumberAttri: TSynHighlighterAttributes;
    fHexAttri: TSynHighlighterAttributes;
    fSymbolAttri: TSynHighlighterAttributes;
    fStringAttri: TSynHighlighterAttributes;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: string): Boolean;
    function Func10: TtkTokenKind;
    function Func13: TtkTokenKind;
    function Func15: TtkTokenKind;
    function Func20: TtkTokenKind;
    function Func21: TtkTokenKind;
    function Func22: TtkTokenKind;
    function Func23: TtkTokenKind;
    function Func26: TtkTokenKind;
    function Func27: TtkTokenKind;
    function Func28: TtkTokenKind;
    function Func29: TtkTokenKind;
    function Func30: TtkTokenKind;
    function Func31: TtkTokenKind;
    function Func32: TtkTokenKind;
    function Func33: TtkTokenKind;
    function Func34: TtkTokenKind;
    function Func35: TtkTokenKind;
    function Func37: TtkTokenKind;
    function Func38: TtkTokenKind;
    function Func39: TtkTokenKind;
    function Func40: TtkTokenKind;
    function Func41: TtkTokenKind;
    function Func42: TtkTokenKind;
    function Func43: TtkTokenKind;
    function Func44: TtkTokenKind;
    function Func45: TtkTokenKind;
    function Func46: TtkTokenKind;
    function Func47: TtkTokenKind;
    function Func48: TtkTokenKind;
    function Func49: TtkTokenKind;
    function Func50: TtkTokenKind;
    function Func51: TtkTokenKind;
    function Func52: TtkTokenKind;
    function Func53: TtkTokenKind;
    function Func54: TtkTokenKind;
    function Func55: TtkTokenKind;
    function Func56: TtkTokenKind;
    function Func57: TtkTokenKind;
    function Func58: TtkTokenKind;
    function Func59: TtkTokenKind;
    function Func61: TtkTokenKind;
    function Func62: TtkTokenKind;
    function Func63: TtkTokenKind;
    function Func64: TtkTokenKind;
    function Func65: TtkTokenKind;
    function Func66: TtkTokenKind;
    function Func69: TtkTokenKind;
    function Func70: TtkTokenKind;
    function Func71: TtkTokenKind;
    function Func72: TtkTokenKind;
    function Func73: TtkTokenKind;
    function Func76: TtkTokenKind;
    function Func77: TtkTokenKind;
    function Func78: TtkTokenKind;
    function Func79: TtkTokenKind;
    function Func81: TtkTokenKind;
    function Func82: TtkTokenKind;
    function Func83: TtkTokenKind;
    function Func84: TtkTokenKind;
    function Func85: TtkTokenKind;
    function Func86: TtkTokenKind;
    function Func87: TtkTokenKind;
    function Func88: TtkTokenKind;
    function Func89: TtkTokenKind;
    function Func90: TtkTokenKind;
    function Func91: TtkTokenKind;
    function Func92: TtkTokenKind;
    function Func93: TtkTokenKind;
    function Func94: TtkTokenKind;
    function Func96: TtkTokenKind;
    function Func97: TtkTokenKind;
    function Func100: TtkTokenKind;
    function Func101: TtkTokenKind;
    function Func102: TtkTokenKind;
    function Func104: TtkTokenKind;
    function Func105: TtkTokenKind;
    function Func112: TtkTokenKind;
    function Func130: TtkTokenKind;
    function Func139: TtkTokenKind;
    function Func142: TtkTokenKind;
    function Func147: TtkTokenKind;
    function Func157: TtkTokenKind;
    procedure IdentProc;
    procedure UnknownProc;
    function AltFunc: TtkTokenKind;
    procedure InitIdent;
    function IdentKind(MayBe: PChar): TtkTokenKind;
    procedure MakeMethodTables;
    procedure NullProc;
    procedure SpaceProc;
    procedure CRProc;
    procedure LFProc;
    procedure NumberProc;
//    procedure CStyleCommentOpenProc;
    procedure CStyleProc;
    procedure DirectiveProc;
    procedure SlashProc;
    procedure StringProc;
    procedure BlockStringProc;
  protected
    function GetIdentChars: TSynIdentChars; override;
    function GetSampleSource: string; override;
    function IsFilterStored: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    {$IFNDEF SYN_CPPB_1} class {$ENDIF}
    function GetLanguageName: string; override;
    function GetRange: Pointer; override;
    procedure ResetRange; override;
    procedure SetRange(Value: Pointer); override;
    function GetDefaultAttribute(Index: integer): TSynHighlighterAttributes; override;
    function GetEOL: Boolean; override;
    function GetTokenID: TtkTokenKind;
    procedure SetLine({$IFDEF FPC}const {$ENDIF}NewValue: String; LineNumber: Integer); override;
    function GetToken: String; override;
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;
    procedure Next; override;
  published
    property CommandAttri: TSynHighlighterAttributes read fCommandAttri write fCommandAttri;
    property CommentAttri: TSynHighlighterAttributes read fCommentAttri write fCommentAttri;
    property ConstantAttri: TSynHighlighterAttributes read fConstantAttri write fConstantAttri;
    property DirectiveAttri: TSynHighlighterAttributes read fDirecAttri write fDirecAttri;
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri write fIdentifierAttri;
    property KeyAttri: TSynHighlighterAttributes read fKeyAttri write fKeyAttri;
    property NumberAttri: TSynHighlighterAttributes read fNumberAttri write fNumberAttri;
    property HexAttri: TSynHighlighterAttributes read fHexAttri write fHexAttri;
    property PropertyAttri: TSynHighlighterAttributes read fPropertyAttri write fPropertyAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri write fSpaceAttri;
    property SymbolAttri: TSynHighlighterAttributes read fSymbolAttri write fSymbolAttri;
    property StringAttri: TSynHighlighterAttributes read fStringAttri write fStringAttri;
  end;

implementation

uses
  SysUtils,
  Graphics,
  SynEditStrConst;

{$IFDEF SYN_COMPILER_3_UP}
resourcestring
{$ELSE}
const
{$ENDIF}
  SYNS_FilterMindScript = 'MindScript files (*.rcx2;*.lsc)|*.rcx2;*.lsc';
  SYNS_LangMindScript = 'MindScript';
  SYNS_AttrCommand = 'Command';
  SYNS_AttrConstant = 'Constant';
  SYNS_AttrProperty = 'Property';

var
  Identifiers: array[#0..#255] of ByteBool;
  mHashTable : array[#0..#255] of Integer;

procedure MakeIdentTable;
var
  I, J: Char;
begin
  for I := #0 to #255 do
  begin
    Case I of
      '_', '0'..'9', 'A'..'Z', 'a'..'z': Identifiers[I] := True;
    else Identifiers[I] := False;
    end;
    J := UpCase(I);
    Case I in ['_', 'A'..'Z', 'a'..'z'] of
      True: mHashTable[I] := Ord(J) - 64
    else mHashTable[I] := 0;
    end;
  end;
end;

procedure TSynMindScriptSyn.InitIdent;
var
  I: Integer;
  pF: PIdentFuncTableFunc;
begin
  pF := PIdentFuncTableFunc(@fIdentFuncTable);
  for I := Low(fIdentFuncTable) to High(fIdentFuncTable) do
  begin
    pF^ := {$IFDEF FPC}@{$ENDIF}AltFunc;
    Inc(pF);
  end;
  fIdentFuncTable[10] := {$IFDEF FPC}@{$ENDIF}Func10;
  fIdentFuncTable[13] := {$IFDEF FPC}@{$ENDIF}Func13;
  fIdentFuncTable[15] := {$IFDEF FPC}@{$ENDIF}Func15;
  fIdentFuncTable[20] := {$IFDEF FPC}@{$ENDIF}Func20;
  fIdentFuncTable[21] := {$IFDEF FPC}@{$ENDIF}Func21;
  fIdentFuncTable[22] := {$IFDEF FPC}@{$ENDIF}Func22;
  fIdentFuncTable[23] := {$IFDEF FPC}@{$ENDIF}Func23;
  fIdentFuncTable[26] := {$IFDEF FPC}@{$ENDIF}Func26;
  fIdentFuncTable[27] := {$IFDEF FPC}@{$ENDIF}Func27;
  fIdentFuncTable[28] := {$IFDEF FPC}@{$ENDIF}Func28;
  fIdentFuncTable[29] := {$IFDEF FPC}@{$ENDIF}Func29;
  fIdentFuncTable[30] := {$IFDEF FPC}@{$ENDIF}Func30;
  fIdentFuncTable[31] := {$IFDEF FPC}@{$ENDIF}Func31;
  fIdentFuncTable[32] := {$IFDEF FPC}@{$ENDIF}Func32;
  fIdentFuncTable[33] := {$IFDEF FPC}@{$ENDIF}Func33;
  fIdentFuncTable[34] := {$IFDEF FPC}@{$ENDIF}Func34;
  fIdentFuncTable[35] := {$IFDEF FPC}@{$ENDIF}Func35;
  fIdentFuncTable[37] := {$IFDEF FPC}@{$ENDIF}Func37;
  fIdentFuncTable[38] := {$IFDEF FPC}@{$ENDIF}Func38;
  fIdentFuncTable[39] := {$IFDEF FPC}@{$ENDIF}Func39;
  fIdentFuncTable[40] := {$IFDEF FPC}@{$ENDIF}Func40;
  fIdentFuncTable[41] := {$IFDEF FPC}@{$ENDIF}Func41;
  fIdentFuncTable[42] := {$IFDEF FPC}@{$ENDIF}Func42;
  fIdentFuncTable[43] := {$IFDEF FPC}@{$ENDIF}Func43;
  fIdentFuncTable[44] := {$IFDEF FPC}@{$ENDIF}Func44;
  fIdentFuncTable[45] := {$IFDEF FPC}@{$ENDIF}Func45;
  fIdentFuncTable[46] := {$IFDEF FPC}@{$ENDIF}Func46;
  fIdentFuncTable[47] := {$IFDEF FPC}@{$ENDIF}Func47;
  fIdentFuncTable[48] := {$IFDEF FPC}@{$ENDIF}Func48;
  fIdentFuncTable[49] := {$IFDEF FPC}@{$ENDIF}Func49;
  fIdentFuncTable[50] := {$IFDEF FPC}@{$ENDIF}Func50;
  fIdentFuncTable[51] := {$IFDEF FPC}@{$ENDIF}Func51;
  fIdentFuncTable[52] := {$IFDEF FPC}@{$ENDIF}Func52;
  fIdentFuncTable[53] := {$IFDEF FPC}@{$ENDIF}Func53;
  fIdentFuncTable[54] := {$IFDEF FPC}@{$ENDIF}Func54;
  fIdentFuncTable[55] := {$IFDEF FPC}@{$ENDIF}Func55;
  fIdentFuncTable[56] := {$IFDEF FPC}@{$ENDIF}Func56;
  fIdentFuncTable[57] := {$IFDEF FPC}@{$ENDIF}Func57;
  fIdentFuncTable[58] := {$IFDEF FPC}@{$ENDIF}Func58;
  fIdentFuncTable[59] := {$IFDEF FPC}@{$ENDIF}Func59;
  fIdentFuncTable[61] := {$IFDEF FPC}@{$ENDIF}Func61;
  fIdentFuncTable[62] := {$IFDEF FPC}@{$ENDIF}Func62;
  fIdentFuncTable[63] := {$IFDEF FPC}@{$ENDIF}Func63;
  fIdentFuncTable[64] := {$IFDEF FPC}@{$ENDIF}Func64;
  fIdentFuncTable[65] := {$IFDEF FPC}@{$ENDIF}Func65;
  fIdentFuncTable[66] := {$IFDEF FPC}@{$ENDIF}Func66;
  fIdentFuncTable[69] := {$IFDEF FPC}@{$ENDIF}Func69;
  fIdentFuncTable[70] := {$IFDEF FPC}@{$ENDIF}Func70;
  fIdentFuncTable[71] := {$IFDEF FPC}@{$ENDIF}Func71;
  fIdentFuncTable[72] := {$IFDEF FPC}@{$ENDIF}Func72;
  fIdentFuncTable[73] := {$IFDEF FPC}@{$ENDIF}Func73;
  fIdentFuncTable[76] := {$IFDEF FPC}@{$ENDIF}Func76;
  fIdentFuncTable[77] := {$IFDEF FPC}@{$ENDIF}Func77;
  fIdentFuncTable[78] := {$IFDEF FPC}@{$ENDIF}Func78;
  fIdentFuncTable[79] := {$IFDEF FPC}@{$ENDIF}Func79;
  fIdentFuncTable[81] := {$IFDEF FPC}@{$ENDIF}Func81;
  fIdentFuncTable[82] := {$IFDEF FPC}@{$ENDIF}Func82;
  fIdentFuncTable[83] := {$IFDEF FPC}@{$ENDIF}Func83;
  fIdentFuncTable[84] := {$IFDEF FPC}@{$ENDIF}Func84;
  fIdentFuncTable[85] := {$IFDEF FPC}@{$ENDIF}Func85;
  fIdentFuncTable[86] := {$IFDEF FPC}@{$ENDIF}Func86;
  fIdentFuncTable[87] := {$IFDEF FPC}@{$ENDIF}Func87;
  fIdentFuncTable[88] := {$IFDEF FPC}@{$ENDIF}Func88;
  fIdentFuncTable[89] := {$IFDEF FPC}@{$ENDIF}Func89;
  fIdentFuncTable[90] := {$IFDEF FPC}@{$ENDIF}Func90;
  fIdentFuncTable[91] := {$IFDEF FPC}@{$ENDIF}Func91;
  fIdentFuncTable[92] := {$IFDEF FPC}@{$ENDIF}Func92;
  fIdentFuncTable[93] := {$IFDEF FPC}@{$ENDIF}Func93;
  fIdentFuncTable[94] := {$IFDEF FPC}@{$ENDIF}Func94;
  fIdentFuncTable[96] := {$IFDEF FPC}@{$ENDIF}Func96;
  fIdentFuncTable[97] := {$IFDEF FPC}@{$ENDIF}Func97;
  fIdentFuncTable[100] := {$IFDEF FPC}@{$ENDIF}Func100;
  fIdentFuncTable[101] := {$IFDEF FPC}@{$ENDIF}Func101;
  fIdentFuncTable[102] := {$IFDEF FPC}@{$ENDIF}Func102;
  fIdentFuncTable[104] := {$IFDEF FPC}@{$ENDIF}Func104;
  fIdentFuncTable[105] := {$IFDEF FPC}@{$ENDIF}Func105;
  fIdentFuncTable[112] := {$IFDEF FPC}@{$ENDIF}Func112;
  fIdentFuncTable[130] := {$IFDEF FPC}@{$ENDIF}Func130;
  fIdentFuncTable[139] := {$IFDEF FPC}@{$ENDIF}Func139;
  fIdentFuncTable[142] := {$IFDEF FPC}@{$ENDIF}Func142;
  fIdentFuncTable[147] := {$IFDEF FPC}@{$ENDIF}Func147;
  fIdentFuncTable[157] := {$IFDEF FPC}@{$ENDIF}Func157;
end;

function TSynMindScriptSyn.KeyHash(ToHash: PChar): Integer;
begin
  Result := 0;
  while ToHash^ in ['_', '0'..'9', 'a'..'z', 'A'..'Z'] do
  begin
    inc(Result, mHashTable[ToHash^]);
    inc(ToHash);
  end;
  fStringLen := ToHash - fToIdent;
end;

function TSynMindScriptSyn.KeyComp(const aKey: String): Boolean;
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
      if mHashTable[Temp^] <> mHashTable[aKey[i]] then
      begin
        Result := False;
        break;
      end;
      inc(Temp);
    end;
  end
  else
    Result := False;
end;

function TSynMindScriptSyn.Func10: TtkTokenKind;
begin
  if KeyComp('fd') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func13: TtkTokenKind;
begin
  if KeyComp('bk') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func15: TtkTokenKind;
begin
  if KeyComp('if') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func20: TtkTokenKind;
begin
  if KeyComp('as') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func21: TtkTokenKind;
begin
  if KeyComp('led') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func22: TtkTokenKind;
begin
  if KeyComp('abs') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func23: TtkTokenKind;
begin
  if KeyComp('in') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func26: TtkTokenKind;
begin
  if KeyComp('data') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func27: TtkTokenKind;
begin
  if KeyComp('off') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func28: TtkTokenKind;
begin
  if KeyComp('is') then Result := tkKey else
    if KeyComp('fail') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func29: TtkTokenKind;
begin
  if KeyComp('on') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func30: TtkTokenKind;
begin
  if KeyComp('map') then Result := tkConstant else
    if KeyComp('fx') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func31: TtkTokenKind;
begin
  if KeyComp('dir') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func32: TtkTokenKind;
begin
  if KeyComp('get') then Result := tkCommand else
    if KeyComp('high') then Result := tkProperty else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func33: TtkTokenKind;
begin
  if KeyComp('find') then Result := tkCommand else
    if KeyComp('gate') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func34: TtkTokenKind;
begin
  if KeyComp('log') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func35: TtkTokenKind;
begin
  if KeyComp('to') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func37: TtkTokenKind;
begin
  if KeyComp('glide') then Result := tkCommand else
    if KeyComp('mode') then Result := tkCommand else
      if KeyComp('main') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func38: TtkTokenKind;
begin
  if KeyComp('fire') then Result := tkCommand else
    if KeyComp('change') then Result := tkProperty else
      if KeyComp('click') then Result := tkProperty else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func39: TtkTokenKind;
begin
  if KeyComp('angle') then Result := tkConstant else
    if KeyComp('clear') then Result := tkCommand else
      if KeyComp('for') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func40: TtkTokenKind;
begin
  if KeyComp('sgn') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func41: TtkTokenKind;
begin
  if KeyComp('var') then Result := tkKey else
    if KeyComp('else') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func42: TtkTokenKind;
begin
  if KeyComp('raw') then Result := tkConstant else
    if KeyComp('send') then Result := tkCommand else
      if KeyComp('sub') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func43: TtkTokenKind;
begin
  if KeyComp('brick') then Result := tkCommand else
    if KeyComp('local') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func44: TtkTokenKind;
begin
  if KeyComp('tx') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func45: TtkTokenKind;
begin
  if KeyComp('rcx') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func46: TtkTokenKind;
begin
  if KeyComp('vll') then Result := tkKey else
    if KeyComp('link') then Result := tkKey else
      if KeyComp('ping') then Result := tkKey else
        if KeyComp('rom') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func47: TtkTokenKind;
begin
  if KeyComp('time') then Result := tkProperty else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func48: TtkTokenKind;
begin
  if KeyComp('fixed') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func49: TtkTokenKind;
begin
  if KeyComp('not') then Result := tkKey else
    if KeyComp('global') then Result := tkKey else
      if KeyComp('alive') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func50: TtkTokenKind;
begin
  if KeyComp('macro') then Result := tkKey else
    if KeyComp('low') then Result := tkProperty else
      if KeyComp('when') then Result := tkKey else
        if KeyComp('after') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func51: TtkTokenKind;
begin
  if KeyComp('task') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func52: TtkTokenKind;
begin
  if KeyComp('boot') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func53: TtkTokenKind;
begin
  if KeyComp('wait') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func54: TtkTokenKind;
begin
  if KeyComp('tone') then Result := tkCommand else
    if KeyComp('float') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func55: TtkTokenKind;
begin
  if KeyComp('watch') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func56: TtkTokenKind;
begin
  if KeyComp('light') then Result := tkConstant else
    if KeyComp('abort') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func57: TtkTokenKind;
begin
  if KeyComp('sleep') then Result := tkCommand else
    if KeyComp('while') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func58: TtkTokenKind;
begin
  if KeyComp('closed') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func59: TtkTokenKind;
begin
  if KeyComp('opened') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func61: TtkTokenKind;
begin
  if KeyComp('subs') then Result := tkConstant else
    if KeyComp('value') then Result := tkProperty else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func62: TtkTokenKind;
begin
  if KeyComp('enter') then Result := tkProperty else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func63: TtkTokenKind;
begin
  if KeyComp('try') then Result := tkKey else
    if KeyComp('backward') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func64: TtkTokenKind;
begin
  if KeyComp('select') then Result := tkKey else
    if KeyComp('boolean') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func65: TtkTokenKind;
begin
  if KeyComp('random') then Result := tkCommand else
    if KeyComp('repeat') then Result := tkKey else
      if KeyComp('timer') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func66: TtkTokenKind;
begin
  if KeyComp('slot') then Result := tkCommand else
    if KeyComp('event') then Result := tkKey else
      if KeyComp('type') then Result := tkProperty else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func69: TtkTokenKind;
begin
  if KeyComp('message') then Result := tkKey else
    if KeyComp('released') then Result := tkProperty else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func70: TtkTokenKind;
begin
  if KeyComp('stop') then Result := tkCommand else
    if KeyComp('tasks') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func71: TtkTokenKind;
begin
  if KeyComp('target') then Result := tkKey else
    if KeyComp('calibrate') then Result := tkCommand else
      if KeyComp('const') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func72: TtkTokenKind;
begin
  if KeyComp('world') then Result := tkKey else
    if KeyComp('eeprom') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func73: TtkTokenKind;
begin
  if KeyComp('sound') then Result := tkCommand else
    if KeyComp('normal') then Result := tkProperty else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func76: TtkTokenKind;
begin
  if KeyComp('until') then Result := tkKey else
    if KeyComp('remote') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func77: TtkTokenKind;
begin
  if KeyComp('power') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func78: TtkTokenKind;
begin
  if KeyComp('start') then Result := tkKey else
    if KeyComp('watcher') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func79: TtkTokenKind;
begin
  if KeyComp('periodic') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func81: TtkTokenKind;
begin
  if KeyComp('percent') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func82: TtkTokenKind;
begin
  if KeyComp('assert') then Result := tkCommand else
    if KeyComp('switch') then Result := tkConstant else
      if KeyComp('undefined') then Result := tkProperty else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func83: TtkTokenKind;
begin
  if KeyComp('comment') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func84: TtkTokenKind;
begin
  if KeyComp('fragment') then Result := tkKey else
    if KeyComp('trigger') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func85: TtkTokenKind;
begin
  if KeyComp('forward') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func86: TtkTokenKind;
begin
  if KeyComp('pressed') then Result := tkProperty else
    if KeyComp('retry') then Result := tkCommand else
      if KeyComp('display') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func87: TtkTokenKind;
begin
  if KeyComp('vibrato') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func88: TtkTokenKind;
begin
  if KeyComp('program') then Result := tkKey else
    if KeyComp('celsius') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func89: TtkTokenKind;
begin
  if KeyComp('forever') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func90: TtkTokenKind;
begin
  if KeyComp('sensor') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func91: TtkTokenKind;
begin
  if KeyComp('battery') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func92: TtkTokenKind;
begin
  if KeyComp('reverse') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func93: TtkTokenKind;
begin
  if KeyComp('firmware') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func94: TtkTokenKind;
begin
  if KeyComp('fahrenheit') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func96: TtkTokenKind;
begin
  if KeyComp('counter') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func97: TtkTokenKind;
begin
  if KeyComp('doubleclick') then Result := tkProperty else
    if KeyComp('direction') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func100: TtkTokenKind;
begin
  if KeyComp('status') then Result := tkProperty else
    if KeyComp('semaphore') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func101: TtkTokenKind;
begin
  if KeyComp('restart') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func102: TtkTokenKind;
begin
  if KeyComp('version') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func104: TtkTokenKind;
begin
  if KeyComp('monitor') then Result := tkKey else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func105: TtkTokenKind;
begin
  if KeyComp('standalone') then Result := tkCommand else
    if KeyComp('randomize') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func112: TtkTokenKind;
begin
  if KeyComp('unknown') then Result := tkConstant else
    if KeyComp('rotation') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func130: TtkTokenKind;
begin
  if KeyComp('priority') then Result := tkCommand else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func139: TtkTokenKind;
begin
  if KeyComp('transition') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func142: TtkTokenKind;
begin
  if KeyComp('temperature') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func147: TtkTokenKind;
begin
  if KeyComp('hysteresis') then Result := tkProperty else Result := tkIdentifier;
end;

function TSynMindScriptSyn.Func157: TtkTokenKind;
begin
  if KeyComp('transmitter') then Result := tkConstant else Result := tkIdentifier;
end;

function TSynMindScriptSyn.AltFunc: TtkTokenKind;
begin
  Result := tkIdentifier;
end;

function TSynMindScriptSyn.IdentKind(MayBe: PChar): TtkTokenKind;
var
  HashKey: Integer;
begin
  fToIdent := MayBe;
  HashKey := KeyHash(MayBe);
  if HashKey <= MaxKey then
    Result := fIdentFuncTable[HashKey]()
  else
    Result := tkIdentifier;
end;

procedure TSynMindScriptSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      '#': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}DirectiveProc;
      #0 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NullProc;
      #10: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LFProc;
      #13: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}CRProc;
      '/': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SlashProc;
      #1..#9,
      #11,
      #12,
      #14..#32 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SpaceProc;
      #34: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}StringProc;
      'A'..'Z', 'a'..'z', '_': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}IdentProc;
      '0'..'9': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NumberProc;
    else
      fProcTable[I] := {$IFDEF FPC}@{$ENDIF}UnknownProc;
    end;
end;

procedure TSynMindScriptSyn.SpaceProc;
begin
  fTokenID := tkSpace;
  repeat
    inc(Run);
  until not (fLine[Run] in [#1..#32]);
end;

procedure TSynMindScriptSyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TSynMindScriptSyn.CRProc;
begin
  fTokenID := tkSpace;
  inc(Run);
  if fLine[Run] = #10 then
    inc(Run);
end;

procedure TSynMindScriptSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TSynMindScriptSyn.SlashProc;
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

procedure TSynMindScriptSyn.CStyleProc;
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

constructor TSynMindScriptSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fCommandAttri := TSynHighLighterAttributes.Create(SYNS_AttrCommand);
  fCommandAttri.Foreground := clBlue;
  AddAttribute(fCommandAttri);

  fCommentAttri := TSynHighLighterAttributes.Create(SYNS_AttrComment);
  fCommentAttri.Style := [fsItalic];
  fCommentAttri.Foreground := clGray;
  AddAttribute(fCommentAttri);

  fConstantAttri := TSynHighLighterAttributes.Create(SYNS_AttrConstant);
  fConstantAttri.Foreground := clTeal;
  AddAttribute(fConstantAttri);

  fDirecAttri := TSynHighlighterAttributes.Create(SYNS_AttrPreprocessor);
  fDirecAttri.Foreground := clPurple;
  AddAttribute(fDirecAttri);

  fIdentifierAttri := TSynHighLighterAttributes.Create(SYNS_AttrIdentifier);
  AddAttribute(fIdentifierAttri);

  fKeyAttri := TSynHighLighterAttributes.Create(SYNS_AttrReservedWord);
  fKeyAttri.Style := [fsBold];
  AddAttribute(fKeyAttri);

  fNumberAttri := TSynHighlighterAttributes.Create(SYNS_AttrNumber);
  fNumberAttri.Foreground := clRed;
  AddAttribute(fNumberAttri);

  fHexAttri := TSynHighlighterAttributes.Create(SYNS_AttrHexadecimal);
  fHexAttri.Foreground := fNumberAttri.Foreground;
  AddAttribute(fHexAttri);

  fPropertyAttri := TSynHighLighterAttributes.Create(SYNS_AttrProperty);
  fPropertyAttri.Foreground := clGreen;
  AddAttribute(fPropertyAttri);

  fSpaceAttri := TSynHighLighterAttributes.Create(SYNS_AttrSpace);
  AddAttribute(fSpaceAttri);

  fSymbolAttri := TSynHighlighterAttributes.Create(SYNS_AttrSymbol);
  AddAttribute(fSymbolAttri);

  fStringAttri := TSynHighlighterAttributes.Create(SYNS_AttrString);
  AddAttribute(fStringAttri);

  SetAttributesOnChange({$IFDEF FPC}@{$ENDIF}DefHighlightChange);
  InitIdent;
  MakeMethodTables;
  fDefaultFilter := SYNS_FilterMindScript;
  fRange := rsUnknown;
end;

procedure TSynMindScriptSyn.SetLine({$IFDEF FPC}const {$ENDIF}NewValue: String; LineNumber: Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end;

procedure TSynMindScriptSyn.IdentProc;
begin
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do
    Inc(Run);
end;

procedure TSynMindScriptSyn.UnknownProc;
begin
{$IFDEF SYN_MBCSSUPPORT}
  if FLine[Run] in LeadBytes then
    Inc(Run,2)
  else
{$ENDIF}
  inc(Run);
  fTokenID := tkUnknown;
end;

procedure TSynMindScriptSyn.Next;
begin
  fTokenPos := Run;
  case fRange of
    rsCStyle: CStyleProc;
    rsString: BlockStringProc;
  else
    begin
      fRange := rsUnknown;
      fProcTable[fLine[Run]];
    end;
  end;
end;

function TSynMindScriptSyn.GetDefaultAttribute(Index: integer): TSynHighLighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT    : Result := fCommentAttri;
    SYN_ATTR_IDENTIFIER : Result := fIdentifierAttri;
    SYN_ATTR_KEYWORD    : Result := fKeyAttri;
    SYN_ATTR_WHITESPACE : Result := fSpaceAttri;
    SYN_ATTR_SYMBOL     : Result := fSymbolAttri;
    SYN_ATTR_STRING     : Result := fStringAttri;
  else
    Result := nil;
  end;
end;

function TSynMindScriptSyn.GetEOL: Boolean;
begin
  Result := fTokenID = tkNull;
end;

function TSynMindScriptSyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TSynMindScriptSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TSynMindScriptSyn.GetTokenAttribute: TSynHighLighterAttributes;
begin
  case GetTokenID of
    tkCommand   : Result := fCommandAttri;
    tkComment   : Result := fCommentAttri;
    tkConstant  : Result := fConstantAttri;
    tkDirective : Result := fDirecAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey       : Result := fKeyAttri;
    tkNumber    : Result := fNumberAttri;
    tkHex       : Result := fHexAttri;
    tkProperty  : Result := fPropertyAttri;
    tkSpace     : Result := fSpaceAttri;
    tkSymbol    : Result := fSymbolAttri;
    tkString    : Result := fStringAttri;
    tkUnknown   : Result := fSymbolAttri;
  else
    Result := nil;
  end;
end;

procedure TSynMindScriptSyn.StringProc;
begin
  fTokenID := tkString;
  fRange := rsString;
  inc(Run);
  while fLine[Run] <> #0 do
    case fLine[Run] of
      #92: begin
        Inc(Run);  // Backslash, if we have an escaped charcter it can be skipped
        if fLine[Run + 1] <> #0 then
          Inc(Run);
      end;
      '"':
        begin
          fRange := rsUnKnown;
          inc(Run);
          break;
        end;
      #10: break;
      #13: break;
    else inc(Run);
    end;
end;

function TSynMindScriptSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TSynMindScriptSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

function TSynMindScriptSyn.GetIdentChars: TSynIdentChars;
begin
  Result := TSynValidStringChars;
end;

function TSynMindScriptSyn.GetSampleSource: string;
begin
  Result := '// Syntax Highlighting'#13#10 +
            'program TestRCX2 {'#13#10 +
            '  #include "RCX2.h"'#13#10 +
            '  SENSOR Opto on 2'#13#10 +
            '  Opto is light as percent'#13#10 +
            ''#13#10 +
            '  event LeftPressed when LeftTouch.pressed'#13#10 +
            ''#13#10 +
            '  main {'#13#10 +
            '    forever {'#13#10 +
            '      tone 0x1a * random 20 to 40 for 10'#13#10 +
            '      wait 5'#13#10 +
            '    }'#13#10 +
            '  }'#13#10 +
            '}';
end;

function TSynMindScriptSyn.IsFilterStored: Boolean;
begin
  Result := fDefaultFilter <> SYNS_FilterMindScript;
end;

{$IFNDEF SYN_CPPB_1} class {$ENDIF}
function TSynMindScriptSyn.GetLanguageName: string;
begin
  Result := SYNS_LangMindScript;
end;

procedure TSynMindScriptSyn.ResetRange;
begin
  fRange := rsUnknown;
end;

procedure TSynMindScriptSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

function TSynMindScriptSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

procedure TSynMindScriptSyn.NumberProc;
var
  idx1: Integer; // token[1]
begin
  idx1 := Run;
  Inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in
    ['0'..'9', 'A'..'F', 'a'..'f', 'x', 'X'] do
  begin
    case FLine[Run] of
      'a'..'f', 'A'..'F':
        if fTokenID <> tkHex then // invalid char
          Break;
      'x', 'X':
        if (Run = Succ(idx1)) and   // 0x... 'x' must be second char
           (FLine[idx1] = '0') and  // 0x...
           (FLine[Succ(Run)] in ['0'..'9', 'a'..'f', 'A'..'F']) then // 0x... must be continued with a number
             fTokenID := tkHex
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

procedure TSynMindScriptSyn.DirectiveProc;
begin
  fTokenID := tkDirective;
  repeat
    inc(Run);
  until fLine[Run] in [#0, #10, #13];
end;

procedure TSynMindScriptSyn.BlockStringProc;
begin
  case fLine[Run] of
     #0: NullProc;
    #10: LFProc;
    #13: CRProc;
  else
    fTokenID := tkString;
    repeat
      if (fLine[Run] = '\') and (fLine[Run + 1] = '"') then begin
        Inc(Run);
      end
      else if fLine[Run] = '"' then begin
        fRange := rsUnKnown;
        Inc(Run);
        break;
      end;
      Inc(Run);
    until fLine[Run] in [#0, #10, #13];
  end;
end;

initialization
  MakeIdentTable;
{$IFNDEF SYN_CPPB_1}
  RegisterPlaceableHighlighter(TSynMindScriptSyn);
{$ENDIF}
end.
