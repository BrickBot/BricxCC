{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

Code template generated with SynGen.
The original code is: SynHighlighterForth.pas, released 2002-03-04.
Description: Forth Syntax Parser/Highlighter
The initial author of this file is John Hansen.
Copyright (c) 2002, all rights reserved.

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

$Id: SynHighlighterForth.pas,v 1.1.1.1 2009/01/12 02:30:07 jhansen Exp $

You may retrieve the latest version of this file at the SynEdit home page,
located at http://SynEdit.SourceForge.net

-------------------------------------------------------------------------------}

unit SynHighlighterForth;

{$I BricxCCSynEdit.inc}

interface

uses
  SysUtils,
  Classes,
{$IFNDEF FPC}
  Windows,
{$ENDIF}
  Controls,
  Graphics,
  SynEditTypes,
  SynEditHighlighter;

type
  TtkTokenKind = (
    tkBlock,
    tkBlockExt,
    tkComment,
    tkCore,
    tkCoreExt,
    tkCustom,
    tkDouble,
    tkDoubleExt,
    tkException,
    tkFacility,
    tkFacilityExt,
    tkFile,
    tkFileExt,
    tkFloating,
    tkFloatingExt,
    tkIdentifier,
    tkKey,
    tkLocal,
    tkLocalExt,
    tkMemory,
    tkNull,
    tkNumber,
    tkOther,
    tkRCX,
    tkSearch,
    tkSearchExt,
    tkSpace,
    tkString,
    tkStringWord,
    tkSymbol,
    tkTools,
    tkToolsExt,
    tkUnknown);

  TRangeState = (rsUnKnown, rsForthStyleComment, rsForthSlashStyleComment, rsString);

  TProcTableProc = procedure of object;

  PIdentFuncTableFunc = ^TIdentFuncTableFunc;
  TIdentFuncTableFunc = function: TtkTokenKind of object;

const
  MaxKey = 187;

type
  TSynForthSyn = class(TSynCustomHighlighter)
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
    fCustomWords: TStrings;
    fBlockAttri: TSynHighlighterAttributes;
    fBlockExtAttri: TSynHighlighterAttributes;
    fCommentAttri: TSynHighlighterAttributes;
    fCoreAttri: TSynHighlighterAttributes;
    fCoreExtAttri: TSynHighlighterAttributes;
    fCustomAttri: TSynHighlighterAttributes;
    fDoubleAttri: TSynHighlighterAttributes;
    fDoubleExtAttri: TSynHighlighterAttributes;
    fExceptionAttri: TSynHighlighterAttributes;
    fFacilityAttri: TSynHighlighterAttributes;
    fFacilityExtAttri: TSynHighlighterAttributes;
    fFileAttri: TSynHighlighterAttributes;
    fFileExtAttri: TSynHighlighterAttributes;
    fFloatingAttri: TSynHighlighterAttributes;
    fFloatingExtAttri: TSynHighlighterAttributes;
    fIdentifierAttri: TSynHighlighterAttributes;
    fKeyAttri: TSynHighlighterAttributes;
    fLocalAttri: TSynHighlighterAttributes;
    fLocalExtAttri: TSynHighlighterAttributes;
    fMemoryAttri: TSynHighlighterAttributes;
    fNumberAttri: TSynHighlighterAttributes;
    fOtherAttri: TSynHighlighterAttributes;
    fRCXAttri: TSynHighlighterAttributes;
    fSearchAttri: TSynHighlighterAttributes;
    fSearchExtAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;
    fSymbolAttri: TSynHighlighterAttributes;
    fStringAttri: TSynHighlighterAttributes;
    fStringWordAttri: TSynHighlighterAttributes;
    fToolsAttri: TSynHighlighterAttributes;
    fToolsExtAttri: TSynHighlighterAttributes;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: string): Boolean;
    function Func0: TtkTokenKind;
    function Func3: TtkTokenKind;
    function Func4: TtkTokenKind;
    function Func6: TtkTokenKind;
    function Func9: TtkTokenKind;
    function Func10: TtkTokenKind;
    function Func11: TtkTokenKind;
    function Func13: TtkTokenKind;
    function Func14: TtkTokenKind;
    function Func15: TtkTokenKind;
    function Func18: TtkTokenKind;
    function Func19: TtkTokenKind;
    function Func21: TtkTokenKind;
    function Func22: TtkTokenKind;
    function Func23: TtkTokenKind;
    function Func25: TtkTokenKind;
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
    function Func36: TtkTokenKind;
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
    function Func60: TtkTokenKind;
    function Func61: TtkTokenKind;
    function Func62: TtkTokenKind;
    function Func63: TtkTokenKind;
    function Func64: TtkTokenKind;
    function Func65: TtkTokenKind;
    function Func66: TtkTokenKind;
    function Func67: TtkTokenKind;
    function Func68: TtkTokenKind;
    function Func69: TtkTokenKind;
    function Func70: TtkTokenKind;
    function Func71: TtkTokenKind;
    function Func72: TtkTokenKind;
    function Func73: TtkTokenKind;
    function Func74: TtkTokenKind;
    function Func76: TtkTokenKind;
    function Func77: TtkTokenKind;
    function Func78: TtkTokenKind;
    function Func79: TtkTokenKind;
    function Func80: TtkTokenKind;
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
    function Func98: TtkTokenKind;
    function Func99: TtkTokenKind;
    function Func100: TtkTokenKind;
    function Func104: TtkTokenKind;
    function Func106: TtkTokenKind;
    function Func107: TtkTokenKind;
    function Func108: TtkTokenKind;
    function Func112: TtkTokenKind;
    function Func114: TtkTokenKind;
    function Func115: TtkTokenKind;
    function Func120: TtkTokenKind;
    function Func124: TtkTokenKind;
    function Func125: TtkTokenKind;
    function Func127: TtkTokenKind;
    function Func131: TtkTokenKind;
    function Func132: TtkTokenKind;
    function Func143: TtkTokenKind;
    function Func149: TtkTokenKind;
    function Func152: TtkTokenKind;
    function Func156: TtkTokenKind;
    function Func172: TtkTokenKind;
    function Func174: TtkTokenKind;
    function Func180: TtkTokenKind;
    function Func187: TtkTokenKind;
    function Func102: TtkTokenKind;
    function Func105: TtkTokenKind;
    function Func109: TtkTokenKind;
    function Func118: TtkTokenKind;
    function Func122: TtkTokenKind;
    function Func123: TtkTokenKind;
    function Func129: TtkTokenKind;
    function Func134: TtkTokenKind;
    function Func137: TtkTokenKind;
    function Func139: TtkTokenKind;
    function Func151: TtkTokenKind;
    function Func20: TtkTokenKind;
    function Func95: TtkTokenKind;
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
    procedure IntegerProc;
    procedure ForthStyleCommentOpenProc;
    procedure ForthStyleCommentProc;
    procedure ForthSlashStyleCommentOpenProc;
    procedure ForthSlashStyleCommentProc;
    procedure StringOpenProc;
    procedure StringProc;
    procedure SetCustomWords(const Value: TStrings);
  protected
    function GetIdentChars: TSynIdentChars; override;
    function GetSampleSource: string; override;
    function IsFilterStored: Boolean; override;
    function IsCustomWord(const AToken: string): boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
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
    property CustomWords: TStrings read fCustomWords write SetCustomWords;
    property BlockAttri: TSynHighlighterAttributes read fBlockAttri write fBlockAttri;
    property BlockExtAttri: TSynHighlighterAttributes read fBlockExtAttri write fBlockExtAttri;
    property CommentAttri: TSynHighlighterAttributes read fCommentAttri write fCommentAttri;
    property CoreAttri: TSynHighlighterAttributes read fCoreAttri write fCoreAttri;
    property CoreExtAttri: TSynHighlighterAttributes read fCoreExtAttri write fCoreExtAttri;
    property CustomAttri: TSynHighlighterAttributes read fCustomAttri write fCustomAttri;
    property DoubleAttri: TSynHighlighterAttributes read fDoubleAttri write fDoubleAttri;
    property DoubleExtAttri: TSynHighlighterAttributes read fDoubleExtAttri write fDoubleExtAttri;
    property ExceptionAttri: TSynHighlighterAttributes read fExceptionAttri write fExceptionAttri;
    property FacilityAttri: TSynHighlighterAttributes read fFacilityAttri write fFacilityAttri;
    property FacilityExtAttri: TSynHighlighterAttributes read fFacilityExtAttri write fFacilityExtAttri;
    property FileAttri: TSynHighlighterAttributes read fFileAttri write fFileAttri;
    property FileExtAttri: TSynHighlighterAttributes read fFileExtAttri write fFileExtAttri;
    property FloatingAttri: TSynHighlighterAttributes read fFloatingAttri write fFloatingAttri;
    property FloatingExtAttri: TSynHighlighterAttributes read fFloatingExtAttri write fFloatingExtAttri;
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri write fIdentifierAttri;
    property KeyAttri: TSynHighlighterAttributes read fKeyAttri write fKeyAttri;
    property LocalAttri: TSynHighlighterAttributes read fLocalAttri write fLocalAttri;
    property LocalExtAttri: TSynHighlighterAttributes read fLocalExtAttri write fLocalExtAttri;
    property MemoryAttri: TSynHighlighterAttributes read fMemoryAttri write fMemoryAttri;
    property NumberAttri: TSynHighlighterAttributes read fNumberAttri write fNumberAttri;
    property OtherAttri: TSynHighlighterAttributes read fOtherAttri write fOtherAttri;
    property RCXAttri: TSynHighlighterAttributes read fRCXAttri write fRCXAttri;
    property SearchAttri: TSynHighlighterAttributes read fSearchAttri write fSearchAttri;
    property SearchExtAttri: TSynHighlighterAttributes read fSearchExtAttri write fSearchExtAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri write fSpaceAttri;
    property StringAttri: TSynHighlighterAttributes read fStringAttri write fStringAttri;
    property StringWordAttri: TSynHighlighterAttributes read fStringWordAttri write fStringWordAttri;
    property SymbolAttri: TSynHighlighterAttributes read fSymbolAttri write fSymbolAttri;
    property ToolsAttri: TSynHighlighterAttributes read fToolsAttri write fToolsAttri;
    property ToolsExtAttri: TSynHighlighterAttributes read fToolsExtAttri write fToolsExtAttri;
  end;

implementation

uses
  SynEditStrConst;

type
  TCSStringList = class(TStringList)
  private
    fCaseSensitive : boolean;
    procedure CSQuickSort(L, R: Integer);
  protected
    procedure SetCaseSensitive(const Value: boolean);
  public
    function Find(const S: string; var Index: Integer): Boolean; override;
    procedure Sort; override;
    property CaseSensitive : boolean read fCaseSensitive write SetCaseSensitive;
  end;

{$IFDEF SYN_COMPILER_3_UP}
resourcestring
{$ELSE}
const
{$ENDIF}
  SYNS_FilterForth = 'Forth Files (*.4th, *.f, *.fr, *.fth)|*.4th;*.f;*.fr;*.fth';
  SYNS_LangForth = 'Forth';
  SYNS_AttrCore = 'Core word';
  SYNS_AttrCoreExt = 'Core word Ext';
  SYNS_AttrBlock = 'Block word';
  SYNS_AttrBlockExt = 'Block word Ext';
  SYNS_AttrDouble = 'Double word';
  SYNS_AttrDoubleExt = 'Double word Ext';
  SYNS_AttrFacility = 'Facility word';
  SYNS_AttrFacilityExt = 'Facility word Ext';
  SYNS_AttrFile = 'File word';
  SYNS_AttrFileExt = 'File word Ext';
  SYNS_AttrFloating = 'Floating word';
  SYNS_AttrFloatingExt = 'Floating word Ext';
  SYNS_AttrLocal = 'Local word';
  SYNS_AttrLocalExt = 'Local word Ext';
  SYNS_AttrSearch = 'Search word';
  SYNS_AttrSearchExt = 'Search word Ext';
  SYNS_AttrTools = 'Tools word';
  SYNS_AttrToolsExt = 'Tools word Ext';
  SYNS_AttrRCX = 'RCX word';
  SYNS_AttrCustom = 'Custom word';
  SYNS_AttrException = 'Exception word';
  SYNS_AttrMemory = 'Memory word';
  SYNS_AttrOther = 'Other word';
  SYNS_AttrStringword = 'String word';

var
  Identifiers: array[#0..#255] of ByteBool;
  mHashTable : array[#0..#255] of Integer;

procedure MakeIdentTable;
var
  I: Char;
begin
  for I := #0 to #255 do
  begin
    case I of
      '_', '0'..'9', 'a'..'z', 'A'..'Z': Identifiers[I] := True;
      #0..#32, #127..#255 : Identifiers[I] := False;  
    else
      Identifiers[I] := True;
    end;
    case I in ['_', '0'..'9', 'A'..'Z', 'a'..'z'] of
      True:
        begin
          if (I > #64) and (I < #91) then
            mHashTable[I] := Ord(I) - 64
          else if (I > #96) then
            mHashTable[I] := Ord(I) - 95;
        end;
    else
      mHashTable[I] := 0;
    end;
  end;
end;

{ TCSStringList }

procedure TCSStringList.CSQuickSort(L, R: Integer);
var
  I, J: Integer;
  P: string;
begin
  repeat
    I := L;
    J := R;
    P := Get((L + R) shr 1);
    repeat
      while AnsiCompareStr(Get(I), P) < 0 do Inc(I);
      while AnsiCompareStr(Get(J), P) > 0 do Dec(J);
      if I <= J then
      begin
        Exchange(I, J);
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then CSQuickSort(L, J);
    L := I;
  until I >= R;
end;

function TCSStringList.Find(const S: string; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  if CaseSensitive then begin
    Result := False;
    L := 0;
    H := Count - 1;
    while L <= H do
    begin
      I := (L + H) shr 1;
      C := AnsiCompareStr(Get(I), S);
      if C < 0 then L := I + 1 else
      begin
        H := I - 1;
        if C = 0 then
        begin
          Result := True;
          if Duplicates <> dupAccept then L := I;
        end;
      end;
    end;
    Index := L;
  end
  else begin
    Result := inherited Find(S, Index);
  end;
end;

procedure TCSStringList.SetCaseSensitive(const Value: boolean);
begin
  if Value <> fCaseSensitive then begin
    fCaseSensitive := Value;
    Sorted := False;
  end;
end;

procedure TCSStringList.Sort;
begin
  if CaseSensitive then begin
    if not Sorted and (Count > 1) then
    begin
      Changing;
      CSQuickSort(0, Count - 1);
      Changed;
    end;
  end
  else begin
    inherited Sort;
  end;
end;

{ TSynForthSyn }

procedure TSynForthSyn.InitIdent;
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
  fIdentFuncTable[0] := {$IFDEF FPC}@{$ENDIF}Func0;
  fIdentFuncTable[3] := {$IFDEF FPC}@{$ENDIF}Func3;
  fIdentFuncTable[4] := {$IFDEF FPC}@{$ENDIF}Func4;
  fIdentFuncTable[6] := {$IFDEF FPC}@{$ENDIF}Func6;
  fIdentFuncTable[9] := {$IFDEF FPC}@{$ENDIF}Func9;
  fIdentFuncTable[10] := {$IFDEF FPC}@{$ENDIF}Func10;
  fIdentFuncTable[11] := {$IFDEF FPC}@{$ENDIF}Func11;
  fIdentFuncTable[13] := {$IFDEF FPC}@{$ENDIF}Func13;
  fIdentFuncTable[14] := {$IFDEF FPC}@{$ENDIF}Func14;
  fIdentFuncTable[15] := {$IFDEF FPC}@{$ENDIF}Func15;
  fIdentFuncTable[18] := {$IFDEF FPC}@{$ENDIF}Func18;
  fIdentFuncTable[19] := {$IFDEF FPC}@{$ENDIF}Func19;
  fIdentFuncTable[20] := {$IFDEF FPC}@{$ENDIF}Func20;
  fIdentFuncTable[21] := {$IFDEF FPC}@{$ENDIF}Func21;
  fIdentFuncTable[22] := {$IFDEF FPC}@{$ENDIF}Func22;
  fIdentFuncTable[23] := {$IFDEF FPC}@{$ENDIF}Func23;
  fIdentFuncTable[25] := {$IFDEF FPC}@{$ENDIF}Func25;
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
  fIdentFuncTable[36] := {$IFDEF FPC}@{$ENDIF}Func36;
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
  fIdentFuncTable[60] := {$IFDEF FPC}@{$ENDIF}Func60;
  fIdentFuncTable[61] := {$IFDEF FPC}@{$ENDIF}Func61;
  fIdentFuncTable[62] := {$IFDEF FPC}@{$ENDIF}Func62;
  fIdentFuncTable[63] := {$IFDEF FPC}@{$ENDIF}Func63;
  fIdentFuncTable[64] := {$IFDEF FPC}@{$ENDIF}Func64;
  fIdentFuncTable[65] := {$IFDEF FPC}@{$ENDIF}Func65;
  fIdentFuncTable[66] := {$IFDEF FPC}@{$ENDIF}Func66;
  fIdentFuncTable[67] := {$IFDEF FPC}@{$ENDIF}Func67;
  fIdentFuncTable[68] := {$IFDEF FPC}@{$ENDIF}Func68;
  fIdentFuncTable[69] := {$IFDEF FPC}@{$ENDIF}Func69;
  fIdentFuncTable[70] := {$IFDEF FPC}@{$ENDIF}Func70;
  fIdentFuncTable[71] := {$IFDEF FPC}@{$ENDIF}Func71;
  fIdentFuncTable[72] := {$IFDEF FPC}@{$ENDIF}Func72;
  fIdentFuncTable[73] := {$IFDEF FPC}@{$ENDIF}Func73;
  fIdentFuncTable[74] := {$IFDEF FPC}@{$ENDIF}Func74;
  fIdentFuncTable[76] := {$IFDEF FPC}@{$ENDIF}Func76;
  fIdentFuncTable[77] := {$IFDEF FPC}@{$ENDIF}Func77;
  fIdentFuncTable[78] := {$IFDEF FPC}@{$ENDIF}Func78;
  fIdentFuncTable[79] := {$IFDEF FPC}@{$ENDIF}Func79;
  fIdentFuncTable[80] := {$IFDEF FPC}@{$ENDIF}Func80;
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
  fIdentFuncTable[95] := {$IFDEF FPC}@{$ENDIF}Func95;
  fIdentFuncTable[96] := {$IFDEF FPC}@{$ENDIF}Func96;
  fIdentFuncTable[97] := {$IFDEF FPC}@{$ENDIF}Func97;
  fIdentFuncTable[98] := {$IFDEF FPC}@{$ENDIF}Func98;
  fIdentFuncTable[99] := {$IFDEF FPC}@{$ENDIF}Func99;
  fIdentFuncTable[100] := {$IFDEF FPC}@{$ENDIF}Func100;
  fIdentFuncTable[102] := {$IFDEF FPC}@{$ENDIF}Func102;
  fIdentFuncTable[105] := {$IFDEF FPC}@{$ENDIF}Func105;
  fIdentFuncTable[104] := {$IFDEF FPC}@{$ENDIF}Func104;
  fIdentFuncTable[106] := {$IFDEF FPC}@{$ENDIF}Func106;
  fIdentFuncTable[107] := {$IFDEF FPC}@{$ENDIF}Func107;
  fIdentFuncTable[108] := {$IFDEF FPC}@{$ENDIF}Func108;
  fIdentFuncTable[109] := {$IFDEF FPC}@{$ENDIF}Func109;
  fIdentFuncTable[112] := {$IFDEF FPC}@{$ENDIF}Func112;
  fIdentFuncTable[114] := {$IFDEF FPC}@{$ENDIF}Func114;
  fIdentFuncTable[115] := {$IFDEF FPC}@{$ENDIF}Func115;
  fIdentFuncTable[118] := {$IFDEF FPC}@{$ENDIF}Func118;
  fIdentFuncTable[120] := {$IFDEF FPC}@{$ENDIF}Func120;
  fIdentFuncTable[122] := {$IFDEF FPC}@{$ENDIF}Func122;
  fIdentFuncTable[123] := {$IFDEF FPC}@{$ENDIF}Func123;
  fIdentFuncTable[124] := {$IFDEF FPC}@{$ENDIF}Func124;
  fIdentFuncTable[125] := {$IFDEF FPC}@{$ENDIF}Func125;
  fIdentFuncTable[127] := {$IFDEF FPC}@{$ENDIF}Func127;
  fIdentFuncTable[129] := {$IFDEF FPC}@{$ENDIF}Func129;
  fIdentFuncTable[131] := {$IFDEF FPC}@{$ENDIF}Func131;
  fIdentFuncTable[132] := {$IFDEF FPC}@{$ENDIF}Func132;
  fIdentFuncTable[134] := {$IFDEF FPC}@{$ENDIF}Func134;
  fIdentFuncTable[137] := {$IFDEF FPC}@{$ENDIF}Func137;
  fIdentFuncTable[139] := {$IFDEF FPC}@{$ENDIF}Func139;
  fIdentFuncTable[143] := {$IFDEF FPC}@{$ENDIF}Func143;
  fIdentFuncTable[149] := {$IFDEF FPC}@{$ENDIF}Func149;
  fIdentFuncTable[151] := {$IFDEF FPC}@{$ENDIF}Func151;
  fIdentFuncTable[152] := {$IFDEF FPC}@{$ENDIF}Func152;
  fIdentFuncTable[156] := {$IFDEF FPC}@{$ENDIF}Func156;
  fIdentFuncTable[172] := {$IFDEF FPC}@{$ENDIF}Func172;
  fIdentFuncTable[174] := {$IFDEF FPC}@{$ENDIF}Func174;
  fIdentFuncTable[180] := {$IFDEF FPC}@{$ENDIF}Func180;
  fIdentFuncTable[187] := {$IFDEF FPC}@{$ENDIF}Func187;
end;

function TSynForthSyn.KeyHash(ToHash: PChar): Integer;
begin
  Result := 0;
  while ToHash^ in ['0'..'9', 'a'..'z', 'A'..'Z',
                    '!'..'/', ':'..'@', '['..'`', '{'..'~'] do
  begin
    inc(Result, mHashTable[ToHash^]);
    inc(ToHash);
  end;
  fStringLen := ToHash - fToIdent;
end;

function TSynForthSyn.KeyComp(const aKey: String): Boolean;
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
end;

function TSynForthSyn.Func0: TtkTokenKind;
begin
  if KeyComp('.(') then Result := tkSymbol else
  if KeyComp('?') then Result := tkSymbol else
  if KeyComp('0<>') then Result := tkSymbol else
  if KeyComp('0=') then Result := tkSymbol else
  if KeyComp('0<') then Result := tkSymbol else
  if KeyComp('2/') then Result := tkSymbol else
  if KeyComp('!') then Result := tkSymbol else
  if KeyComp('#>') then Result := tkSymbol else
  if KeyComp('-') then Result := tkSymbol else
  if KeyComp('''') then Result := tkSymbol else
  if KeyComp('0>') then Result := tkSymbol else
  if KeyComp(']') then Result := tkSymbol else
  if KeyComp('1+') then Result := tkSymbol else
  if KeyComp('2*') then Result := tkSymbol else
  if KeyComp('1-') then Result := tkSymbol else
  if KeyComp('2@') then Result := tkSymbol else
  if KeyComp('['']') then Result := tkSymbol else
  if KeyComp('2!') then Result := tkSymbol else
  if KeyComp('#') then Result := tkSymbol else
  if KeyComp('+!') then Result := tkSymbol else
  if KeyComp(',') then Result := tkSymbol else
  if KeyComp('.') then Result := tkSymbol else
  if KeyComp('+') then Result := tkSymbol else
  if KeyComp(';') then Result := tkSymbol else
  if KeyComp('@') then Result := tkSymbol else
  if KeyComp('*/') then Result := tkSymbol else
  if KeyComp('[') then Result := tkSymbol else
  if KeyComp('<>') then Result := tkSymbol else
  if KeyComp('>') then Result := tkSymbol else
  if KeyComp('<#') then Result := tkSymbol else
  if KeyComp('<') then Result := tkSymbol else
  if KeyComp('/') then Result := tkSymbol else
  if KeyComp(':') then Result := tkSymbol else
  if KeyComp('=') then Result := tkSymbol else
  if KeyComp('*') then Result := tkSymbol else Result := tkIdentifier;
end;

function TSynForthSyn.Func3: TtkTokenKind;
begin
  if KeyComp('C!') then Result := tkCore else
    if KeyComp('C@') then Result := tkCore else
      if KeyComp('C,') then Result := tkCore else
        if KeyComp('C"') then Result := tkString else Result := tkIdentifier;
end;

function TSynForthSyn.Func4: TtkTokenKind;
begin
  if KeyComp('D2*') then Result := tkDouble else
    if KeyComp('D2/') then Result := tkDouble else
      if KeyComp('D-') then Result := tkDouble else
        if KeyComp('D=') then Result := tkDouble else
          if KeyComp('D<') then Result := tkDouble else
            if KeyComp('D+') then Result := tkDouble else
              if KeyComp('D0=') then Result := tkDouble else
                if KeyComp('D0<') then Result := tkDouble else
                  if KeyComp('D.') then Result := tkDouble else Result := tkIdentifier;
end;

function TSynForthSyn.Func9: TtkTokenKind;
begin
  if KeyComp('I') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func10: TtkTokenKind;
begin
  if KeyComp('F>D') then Result := tkFloating else
    if KeyComp('J') then Result := tkCore else
      if KeyComp('D>F') then Result := tkFloating else
        if KeyComp('DF!') then Result := tkFloatingExt else
          if KeyComp('DF@') then Result := tkFloatingExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func13: TtkTokenKind;
begin
  if KeyComp('M*/') then Result := tkDouble else
    if KeyComp('M*') then Result := tkCore else
      if KeyComp('M+') then Result := tkDouble else Result := tkIdentifier;
end;

function TSynForthSyn.Func14: TtkTokenKind;
begin
  if KeyComp('BL') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func15: TtkTokenKind;
begin
  if KeyComp('[IF]') then Result := tkToolsExt else
    if KeyComp('IF') then Result := tkKey else Result := tkIdentifier;
end;

function TSynForthSyn.Func18: TtkTokenKind;
begin
  if KeyComp('2>R') then Result := tkCoreExt else
    if KeyComp('2R>') then Result := tkCoreExt else
      if KeyComp('R@') then Result := tkCore else
        if KeyComp('2R@') then Result := tkCoreExt else
          if KeyComp('R>') then Result := tkCore else
            if KeyComp('>R') then Result := tkCore else
              if KeyComp('.R') then Result := tkCoreExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func19: TtkTokenKind;
begin
  if KeyComp('#S') then Result := tkCore else
    if KeyComp('S"') then Result := tkString else
      if KeyComp('AND') then Result := tkCore else
        if KeyComp('.S') then Result := tkTools else
          if KeyComp('AHEAD') then Result := tkToolsExt else
            if KeyComp('?DO') then Result := tkCoreExt else
              if KeyComp('DO') then Result := tkKey else
                if KeyComp('<S">') then Result := tkOther else Result := tkIdentifier;
end;

function TSynForthSyn.Func20: TtkTokenKind;
begin
  if KeyComp('DP') then Result := tkOther else Result := tkIdentifier;
end;

function TSynForthSyn.Func21: TtkTokenKind;
begin
  if KeyComp('U<') then Result := tkCore else
    if KeyComp('U.') then Result := tkCore else
      if KeyComp('U>') then Result := tkCoreExt else
        if KeyComp('PAD') then Result := tkCoreExt else
          if KeyComp('OF') then Result := tkKey else
            if KeyComp('CR') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func22: TtkTokenKind;
begin
  if KeyComp('D.R') then Result := tkDouble else
    if KeyComp('ABS') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func23: TtkTokenKind;
begin
  if KeyComp('S>D') then Result := tkCore else
    if KeyComp('D>S') then Result := tkDouble else
      if KeyComp('>IN') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func25: TtkTokenKind;
begin
  if KeyComp('DU<') then Result := tkDoubleExt else
    if KeyComp('FS.') then Result := tkFloatingExt else
      if KeyComp('SF!') then Result := tkFloatingExt else
        if KeyComp('SF@') then Result := tkFloatingExt else
          if KeyComp('BIN') then Result := tkFile else
            if KeyComp('BLK') then Result := tkBlock else Result := tkIdentifier;
end;

function TSynForthSyn.Func26: TtkTokenKind;
begin
  if KeyComp('DABS') then Result := tkDouble else Result := tkIdentifier;
end;

function TSynForthSyn.Func27: TtkTokenKind;
begin
  if KeyComp('CODE') then Result := tkToolsExt else
    if KeyComp(';CODE') then Result := tkToolsExt else
      if KeyComp('BASE') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func30: TtkTokenKind;
begin
  if KeyComp('CHAR+') then Result := tkCore else
    if KeyComp('CHAR') then Result := tkCore else
      if KeyComp('[CHAR]') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func31: TtkTokenKind;
begin
  if KeyComp('TIB') then Result := tkCoreExt else
    if KeyComp('#TIB') then Result := tkCoreExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func32: TtkTokenKind;
begin
  if KeyComp('BYE') then Result := tkToolsExt else
    if KeyComp('MOD') then Result := tkCore else
      if KeyComp('*/MOD') then Result := tkCore else
        if KeyComp('FLN') then Result := tkFloatingExt else
          if KeyComp('MS') then Result := tkFacilityExt else
            if KeyComp('/MOD') then Result := tkCore else
              if KeyComp('CELL+') then Result := tkCore else
                if KeyComp('AGAIN') then Result := tkCoreExt else
                  if KeyComp('LOAD') then Result := tkBlock else Result := tkIdentifier;
end;

function TSynForthSyn.Func33: TtkTokenKind;
begin
  if KeyComp('FIND') then Result := tkCore else
    if KeyComp('OR') then Result := tkCore else
      if KeyComp('R/O') then Result := tkFile else Result := tkIdentifier;
end;

function TSynForthSyn.Func34: TtkTokenKind;
begin
  if KeyComp('UM*') then Result := tkCore else
    if KeyComp('FREE') then Result := tkMemory else
      if KeyComp('MU*') then Result := tkOther else
        if KeyComp('COLD') then Result := tkOther else Result := tkIdentifier;
end;

function TSynForthSyn.Func35: TtkTokenKind;
begin
  if KeyComp('CATCH') then Result := tkException else
    if KeyComp('TO') then Result := tkCoreExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func36: TtkTokenKind;
begin
  if KeyComp('HERE') then Result := tkCore else
    if KeyComp('MIN') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func37: TtkTokenKind;
begin
  if KeyComp('HEX') then Result := tkCoreExt else
    if KeyComp('BEGIN') then Result := tkKey else Result := tkIdentifier;
end;

function TSynForthSyn.Func38: TtkTokenKind;
begin
  if KeyComp('W/O') then Result := tkFile else
    if KeyComp('MAX') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func39: TtkTokenKind;
begin
  if KeyComp('NIP') then Result := tkCoreExt else
    if KeyComp('FILL') then Result := tkCore else
      if KeyComp('PICK') then Result := tkCoreExt else
        if KeyComp('U.R') then Result := tkCoreExt else
          if KeyComp('HOLD') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func41: TtkTokenKind;
begin
  if KeyComp('ELSE') then Result := tkKey else
    if KeyComp('?DUP') then Result := tkCore else
      if KeyComp('2DUP') then Result := tkCore else
        if KeyComp('KEY?') then Result := tkFacility else
          if KeyComp('FTAN') then Result := tkFloatingExt else
            if KeyComp('FALOG') then Result := tkFloatingExt else
              if KeyComp('R/W') then Result := tkFile else
                if KeyComp('[ELSE]') then Result := tkToolsExt else
                  if KeyComp('KEY') then Result := tkCore else
                    if KeyComp('DUP') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func43: TtkTokenKind;
begin
  if KeyComp('ALIGN') then Result := tkCore else
    if KeyComp('(LOCAL)') then Result := tkLocal else
      if KeyComp('BLOCK') then Result := tkBlock else
        if KeyComp('DOES>') then Result := tkCore else
          if KeyComp('FCOS') then Result := tkFloatingExt else
            if KeyComp('FALSE') then Result := tkKey else Result := tkIdentifier;
end;

function TSynForthSyn.Func44: TtkTokenKind;
begin
  if KeyComp('FACOS') then Result := tkFloatingExt else
    if KeyComp('SPACE') then Result := tkCore else
      if KeyComp('ENDOF') then Result := tkKey else
        if KeyComp('FMAX') then Result := tkFloating else
          if KeyComp('UD>S') then Result := tkOther else
            if KeyComp('US>D') then Result := tkOther else Result := tkIdentifier;
end;

function TSynForthSyn.Func45: TtkTokenKind;
begin
  if KeyComp('LCD_HIDE') then Result := tkRCX else
    if KeyComp('LEAVE') then Result := tkKey else Result := tkIdentifier;
end;

function TSynForthSyn.Func46: TtkTokenKind;
begin
  if KeyComp('>BODY') then Result := tkCore else
    if KeyComp('EKEY?') then Result := tkFacilityExt else
      if KeyComp('EKEY') then Result := tkFacilityExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func47: TtkTokenKind;
begin
  if KeyComp('FDUP') then Result := tkFloating else
    if KeyComp('THEN') then Result := tkKey else
      if KeyComp('EMIT?') then Result := tkFacilityExt else
        if KeyComp('EMIT') then Result := tkCore else
          if KeyComp('[THEN]') then Result := tkToolsExt else
            if KeyComp('DECIMAL') then Result := tkCore else
              if KeyComp('ALSO') then Result := tkSearchExt else
                if KeyComp('LCD_4TH') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func48: TtkTokenKind;
begin
  if KeyComp('FSIN') then Result := tkFloatingExt else
    if KeyComp('FLNP1') then Result := tkFloatingExt else
      if KeyComp('ACCEPT') then Result := tkCore else
        if KeyComp('ERASE') then Result := tkCoreExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func49: TtkTokenKind;
begin
  if KeyComp('SIGN') then Result := tkCore else
    if KeyComp('CHARS') then Result := tkCore else
      if KeyComp('FTANH') then Result := tkFloatingExt else
        if KeyComp('FASIN') then Result := tkFloatingExt else
          if KeyComp('FALIGN') then Result := tkFloating else Result := tkIdentifier;
end;

function TSynForthSyn.Func51: TtkTokenKind;
begin
  if KeyComp('FEXP') then Result := tkFloatingExt else
    if KeyComp('FM/MOD') then Result := tkCore else
      if KeyComp('ENDCASE') then Result := tkKey else
        if KeyComp('CELLS') then Result := tkCore else
          if KeyComp('FCOSH') then Result := tkFloatingExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func52: TtkTokenKind;
begin
  if KeyComp('FACOSH') then Result := tkFloatingExt else
    if KeyComp('CREATE') then Result := tkCore else
      if KeyComp('ALIGNED') then Result := tkCore else
        if KeyComp('NEGATE') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func53: TtkTokenKind;
begin
  if KeyComp('DEPTH') then Result := tkCore else
    if KeyComp('2ROT') then Result := tkDoubleExt else
      if KeyComp('DFALIGN') then Result := tkFloatingExt else
        if KeyComp('2DROP') then Result := tkCore else
          if KeyComp('ROT') then Result := tkCore else
            if KeyComp('DROP') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func55: TtkTokenKind;
begin
  if KeyComp('MOVE') then Result := tkCore else
    if KeyComp('TUCK') then Result := tkCoreExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func56: TtkTokenKind;
begin
  if KeyComp('DNEGATE') then Result := tkDouble else
    if KeyComp('FSINH') then Result := tkFloatingExt else
      if KeyComp('ABORT') then Result := tkCore else
        if KeyComp('ABORT"') then Result := tkString else Result := tkIdentifier;
end;

function TSynForthSyn.Func57: TtkTokenKind;
begin
  if KeyComp('ROLL') then Result := tkCoreExt else
    if KeyComp('WHILE') then Result := tkKey else
      if KeyComp('XOR') then Result := tkCore else
        if KeyComp('FASINH') then Result := tkFloatingExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func58: TtkTokenKind;
begin
  if KeyComp('BUFFER') then Result := tkBlock else
    if KeyComp('CMOVE') then Result := tkStringWord else
      if KeyComp('FNEGATE') then Result := tkFloating else
        if KeyComp('LOOP') then Result := tkKey else
          if KeyComp('+LOOP') then Result := tkKey else
            if KeyComp('FALIGNED') then Result := tkFloating else
              if KeyComp('EXIT') then Result := tkKey else
                if KeyComp('CMOVE>') then Result := tkStringWord else
                  if KeyComp('LCD_CLEAR') then Result := tkRCX else
                    if KeyComp('DFLOAT+') then Result := tkFloatingExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func59: TtkTokenKind;
begin
  if KeyComp('SWAP') then Result := tkCore else
    if KeyComp('PARSE') then Result := tkCoreExt else
      if KeyComp('FROT') then Result := tkFloating else
        if KeyComp('FDROP') then Result := tkFloating else
          if KeyComp('FDEPTH') then Result := tkFloating else
            if KeyComp('2SWAP') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func60: TtkTokenKind;
begin
  if KeyComp('LIST') then Result := tkBlockExt else
    if KeyComp('WORD') then Result := tkCore else
      if KeyComp('ALLOT') then Result := tkCore else
        if KeyComp('2OVER') then Result := tkCore else
          if KeyComp('READ-FILE') then Result := tkFile else
            if KeyComp('ORDER') then Result := tkSearchExt else
              if KeyComp('OVER') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func61: TtkTokenKind;
begin
  if KeyComp('CS-PICK') then Result := tkToolsExt else
    if KeyComp('VALUE') then Result := tkCoreExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func62: TtkTokenKind;
begin
  if KeyComp('REFILL') then Result := tkCoreExt else
    if KeyComp('LOCALS|') then Result := tkLocalExt else
      if KeyComp(':NONAME') then Result := tkCoreExt else
        if KeyComp('DFALIGNED') then Result := tkFloatingExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func63: TtkTokenKind;
begin
  if KeyComp('SPACES') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func64: TtkTokenKind;
begin
  if KeyComp('FEXPM1') then Result := tkFloatingExt else
    if KeyComp('TRUE') then Result := tkKey else Result := tkIdentifier;
end;

function TSynForthSyn.Func65: TtkTokenKind;
begin
  if KeyComp('STATE') then Result := tkCore else
    if KeyComp('REPEAT') then Result := tkKey else
      if KeyComp('FSWAP') then Result := tkFloating else Result := tkIdentifier;
end;

function TSynForthSyn.Func66: TtkTokenKind;
begin
  if KeyComp('ONLY') then Result := tkSearchExt else
    if KeyComp('UM/MOD') then Result := tkCore else
      if KeyComp('TYPE') then Result := tkCore else
        if KeyComp('FOVER') then Result := tkFloating else
          if KeyComp('FLUSH') then Result := tkBlock else
            if KeyComp('MARKER') then Result := tkCoreExt else
              if KeyComp('FLOOR') then Result := tkFloating else Result := tkIdentifier;
end;

function TSynForthSyn.Func67: TtkTokenKind;
begin
  if KeyComp('THRU') then Result := tkBlockExt else
    if KeyComp('UPDATE') then Result := tkBlock else
      if KeyComp('QUIT') then Result := tkKey else
        if KeyComp('''next') then Result := tkOther else
          if KeyComp('FORTH') then Result := tkSearchExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func68: TtkTokenKind;
begin
  if KeyComp('SFALIGN') then Result := tkFloatingExt else
    if KeyComp('READ-LINE') then Result := tkFile else
      if KeyComp('SM/REM') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func70: TtkTokenKind;
begin
  if KeyComp('AT-XY') then Result := tkFacility else
    if KeyComp('VARIABLE') then Result := tkKey else
      if KeyComp('2VARIABLE') then Result := tkDouble else Result := tkIdentifier;
end;

function TSynForthSyn.Func73: TtkTokenKind;
begin
  if KeyComp('>NUMBER') then Result := tkCore else
    if KeyComp('SFLOAT+') then Result := tkFloatingExt else
      if KeyComp('EXPECT') then Result := tkCoreExt else
        if KeyComp('COUNT') then Result := tkCore else
          if KeyComp('[COMPILE]') then Result := tkCoreExt else
            if KeyComp('FLOATS') then Result := tkFloating else
              if KeyComp('COMPILE,') then Result := tkCoreExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func74: TtkTokenKind;
begin
  if KeyComp('LSHIFT') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func76: TtkTokenKind;
begin
  if KeyComp('UNTIL') then Result := tkKey else
    if KeyComp('EKEY>CHAR') then Result := tkFacilityExt else
      if KeyComp('FVARIABLE') then Result := tkFloating else Result := tkIdentifier;
end;

function TSynForthSyn.Func77: TtkTokenKind;
begin
  if KeyComp('2LITERAL') then Result := tkDouble else
    if KeyComp('TIME&DATE') then Result := tkFacilityExt else
      if KeyComp('LITERAL') then Result := tkCore else
        if KeyComp('SFALIGNED') then Result := tkFloatingExt else
          if KeyComp('DFLOATS') then Result := tkFloatingExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func79: TtkTokenKind;
begin
  if KeyComp('CS-ROLL') then Result := tkToolsExt else
    if KeyComp('IMMEDIATE') then Result := tkCore else
      if KeyComp('WORDS') then Result := tkTools else Result := tkIdentifier;
end;

function TSynForthSyn.Func80: TtkTokenKind;
begin
  if KeyComp('FSQRT') then Result := tkFloatingExt else
    if KeyComp('RSHIFT') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func81: TtkTokenKind;
begin
  if KeyComp('SOURCE') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func82: TtkTokenKind;
begin
  if KeyComp('OPEN-FILE') then Result := tkFile else
    if KeyComp('RESIZE') then Result := tkMemory else
      if KeyComp('DLShift') then Result := tkOther else Result := tkIdentifier;
end;

function TSynForthSyn.Func83: TtkTokenKind;
begin
  if KeyComp('DELETE-FILE') then Result := tkFile else
    if KeyComp('EXECUTE') then Result := tkCore else
      if KeyComp('WITHIN') then Result := tkCoreExt else
        if KeyComp('FLITERAL') then Result := tkFloating else
          if KeyComp('Num>Char') then Result := tkOther else Result := tkIdentifier;
end;

function TSynForthSyn.Func84: TtkTokenKind;
begin
  if KeyComp('UNUSED') then Result := tkCoreExt else
    if KeyComp('CREATE-FILE') then Result := tkFile else
      if KeyComp('THROW') then Result := tkException else
        if KeyComp('LCD_SHOW') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func86: TtkTokenKind;
begin
  if KeyComp('CLOSE-FILE') then Result := tkFile else
    if KeyComp('QUERY') then Result := tkCoreExt else
      if KeyComp('&Source') then Result := tkOther else Result := tkIdentifier;
end;

function TSynForthSyn.Func87: TtkTokenKind;
begin
  if KeyComp('/STRING') then Result := tkStringWord else
    if KeyComp('EVALUATE') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func88: TtkTokenKind;
begin
  if KeyComp('RENAME-FILE') then Result := tkFileExt else
    if KeyComp('INVERT') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func89: TtkTokenKind;
begin
  if KeyComp('RANGE_SET') then Result := tkRCX else
    if KeyComp('RECURSE') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func92: TtkTokenKind;
begin
  if KeyComp('GET-ORDER') then Result := tkSearch else
    if KeyComp('SFLOATS') then Result := tkFloatingExt else
      if KeyComp('LCD_NUMBER') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func93: TtkTokenKind;
begin
  if KeyComp('UNLOOP') then Result := tkKey else Result := tkIdentifier;
end;

function TSynForthSyn.Func94: TtkTokenKind;
begin
  if KeyComp('SOURCE-ID') then Result := tkCoreExt else
    if KeyComp('ASSEMBLER') then Result := tkToolsExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func95: TtkTokenKind;
begin
  if KeyComp('TibSize') then Result := tkOther else Result := tkIdentifier;
end;

function TSynForthSyn.Func96: TtkTokenKind;
begin
  if KeyComp('SLITERAL') then Result := tkStringWord else Result := tkIdentifier;
end;

function TSynForthSyn.Func97: TtkTokenKind;
begin
  if KeyComp('CONVERT') then Result := tkCoreExt else
    if KeyComp('TIMER_GET') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func98: TtkTokenKind;
begin
  if KeyComp('FLUSH-FILE') then Result := tkFileExt else
    if KeyComp('LCD_REFRESH') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func99: TtkTokenKind;
begin
  if KeyComp('''UserIdle') then Result := tkOther else Result := tkIdentifier;
end;

function TSynForthSyn.Func102: TtkTokenKind;
begin
  if KeyComp('timer_GET') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func104: TtkTokenKind;
begin
  if KeyComp('SET-ORDER') then Result := tkSearch else
    if KeyComp('POWER_OFF') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func105: TtkTokenKind;
begin
  if KeyComp('SOUND_GET') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func106: TtkTokenKind;
begin
  if KeyComp('CONSTANT') then Result := tkKey else
    if KeyComp('2CONSTANT') then Result := tkDouble else Result := tkIdentifier;
end;

function TSynForthSyn.Func109: TtkTokenKind;
begin
  if KeyComp('TIMER_SET') then Result := tkRCX else
    if KeyComp('POWER_GET') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func114: TtkTokenKind;
begin
  if KeyComp('RESIZE-FILE') then Result := tkFile else
    if KeyComp('timer_SET') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func118: TtkTokenKind;
begin
  if KeyComp('SENSOR_READ') then Result := tkRCX else
    if KeyComp('RCX_SOUND') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func120: TtkTokenKind;
begin
  if KeyComp('REPRESENT') then Result := tkFloating else
    if KeyComp('WORDLIST') then Result := tkSearch else
      if KeyComp('POSTPONE') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func122: TtkTokenKind;
begin
  if KeyComp('RCX_POWER') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func123: TtkTokenKind;
begin
  if KeyComp('SERVO_SET') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func124: TtkTokenKind;
begin
  if KeyComp('SAVE-BUFFERS') then Result := tkBlock else
    if KeyComp('DEFINITIONS') then Result := tkSearch else
      if KeyComp('BUTTON_GET') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func125: TtkTokenKind;
begin
  if KeyComp('PREVIOUS') then Result := tkSearchExt else
    if KeyComp('MOTOR_SET') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func127: TtkTokenKind;
begin
  if KeyComp('SAVE-INPUT') then Result := tkCoreExt else
    if KeyComp('SOUND_PLAY') then Result := tkRCX else
      if KeyComp('SOUND_TONE') then Result := tkRCX else
        if KeyComp('SENSOR_MODE') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func129: TtkTokenKind;
begin
  if KeyComp('SENSOR_CLEAR') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func132: TtkTokenKind;
begin
  if KeyComp('FILE-STATUS') then Result := tkFileExt else
    if KeyComp('SENSOR_RAW') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func134: TtkTokenKind;
begin
  if KeyComp('SENSOR_BOOL') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func137: TtkTokenKind;
begin
  if KeyComp('RCX_BUTTON') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func139: TtkTokenKind;
begin
  if KeyComp('COMPILE-ONLY') then Result := tkOther else Result := tkIdentifier;
end;

function TSynForthSyn.Func149: TtkTokenKind;
begin
  if KeyComp('FILE-POSITION') then Result := tkFile else
    if KeyComp('ENVIRONMENT?') then Result := tkCore else Result := tkIdentifier;
end;

function TSynForthSyn.Func151: TtkTokenKind;
begin
  if KeyComp('SENSOR_VALUE') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.Func156: TtkTokenKind;
begin
  if KeyComp('EMPTY-BUFFERS') then Result := tkBlockExt else
    if KeyComp('SENSOR_TYPE') then Result := tkRCX else Result := tkIdentifier;
end;

function TSynForthSyn.AltFunc: TtkTokenKind;
begin
  Result := tkIdentifier;
end;

function TSynForthSyn.IdentKind(MayBe: PChar): TtkTokenKind;
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

procedure TSynForthSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      #0: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NullProc;
      #10: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LFProc;
      #13: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}CRProc;
      '(': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}ForthStyleCommentOpenProc;
      '\': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}ForthSlashStyleCommentOpenProc;
      '.': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}StringOpenProc;
      #1..#9,
      #11,
      #12,
      #14..#32 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SpaceProc;
      'A'..'Z', 'a'..'z', '_',
      '!'..'''', ')'..',', '/', ':'..'@', '[',
      ']'..'^', '`', '{'..'~' : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}IdentProc;
      '-', '0'..'9' : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}IntegerProc;
    else
      fProcTable[I] := {$IFDEF FPC}@{$ENDIF}UnknownProc;
    end;
end;

procedure TSynForthSyn.SpaceProc;
begin
  fTokenID := tkSpace;
  repeat
    inc(Run);
  until not (fLine[Run] in [#1..#32]);
end;

procedure TSynForthSyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TSynForthSyn.CRProc;
begin
  fTokenID := tkSpace;
  inc(Run);
  if fLine[Run] = #10 then
    inc(Run);
end;

procedure TSynForthSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TSynForthSyn.ForthStyleCommentOpenProc;
begin
  Inc(Run);
  if (fLine[Run] in [#0, #9, #10, #13, #32]) then
  begin
    fRange := rsForthStyleComment;
    ForthStyleCommentProc;
    fTokenID := tkComment;
  end
  else
  begin
    IdentProc;
  end;
end;

procedure TSynForthSyn.ForthStyleCommentProc;
begin
  case fLine[Run] of
     #0: NullProc;
    #10: LFProc;
    #13: CRProc;
  else
    begin
      fTokenID := tkComment;
      repeat
        if (fLine[Run] = ')') then
        begin
          Inc(Run, 1);
          fRange := rsUnKnown;
          Break;
        end;
        if not (fLine[Run] in [#0, #10, #13]) then
          Inc(Run);
      until fLine[Run] in [#0, #10, #13];
    end;
  end;
end;

procedure TSynForthSyn.ForthSlashStyleCommentOpenProc;
begin
  Inc(Run);
  if (fLine[Run] in [#0, #9, #32]) then
  begin
    fRange := rsForthSlashStyleComment;
    ForthSlashStyleCommentProc;
    fTokenID := tkComment;
  end
  else
  begin
    IdentProc;
  end;
end;

procedure TSynForthSyn.ForthSlashStyleCommentProc;
begin
  fTokenID := tkComment;
  repeat
    if not (fLine[Run] in [#0, #10, #13]) then
      Inc(Run);
  until fLine[Run] in [#0, #10, #13];
end;

procedure TSynForthSyn.StringOpenProc;
begin
  Inc(Run);
  if (fLine[Run] = '"') then
  begin
    Inc(Run);
    if (fLine[Run] in [#0, #9, #32]) then
    begin
      fRange := rsString;
      StringProc;
      fTokenID := tkString;
      Exit;
    end;
    Dec(Run);
  end;
  Dec(Run);
  IdentProc;
end;

procedure TSynForthSyn.StringProc;
begin
  fTokenID := tkString;
  repeat
    if (fLine[Run] = '"') then
    begin
      Inc(Run, 1);
      fRange := rsUnKnown;
      Break;
    end;
    if not (fLine[Run] in [#0, #10, #13]) then
      Inc(Run);
  until fLine[Run] in [#0, #10, #13];
end;

constructor TSynForthSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fCustomWords := TCSStringList.Create;
  TCSStringList(fCustomWords).CaseSensitive := True;
  TCSStringList(fCustomWords).Sorted        := True;
  TCSStringList(fCustomWords).Duplicates    := dupIgnore;

  fCommentAttri := TSynHighLighterAttributes.Create(SYNS_AttrComment);
  fCommentAttri.Style := [fsItalic];
  fCommentAttri.Foreground := clGray;
  AddAttribute(fCommentAttri);

  fIdentifierAttri := TSynHighLighterAttributes.Create(SYNS_AttrIdentifier);
  AddAttribute(fIdentifierAttri);

  fCoreAttri := TSynHighLighterAttributes.Create(SYNS_AttrCore);
  fCoreAttri.Foreground := clNavy;
  AddAttribute(fCoreAttri);

  fCoreExtAttri := TSynHighLighterAttributes.Create(SYNS_AttrCoreExt);
  fCoreExtAttri.Foreground := clBlue;
  AddAttribute(fCoreExtAttri);

  fKeyAttri := TSynHighLighterAttributes.Create(SYNS_AttrReservedWord);
  fKeyAttri.Foreground := clNavy;
  AddAttribute(fKeyAttri);

  fRCXAttri := TSynHighLighterAttributes.Create(SYNS_AttrRCX);
  fRCXAttri.Foreground := clBlue;
  AddAttribute(fRCXAttri);

  fSpaceAttri := TSynHighLighterAttributes.Create(SYNS_AttrSpace);
  AddAttribute(fSpaceAttri);

  fNumberAttri := TSynHighlighterAttributes.Create(SYNS_AttrNumber);
  fNumberAttri.Foreground := clRed;
  AddAttribute(fNumberAttri);

  fStringAttri := TSynHighlighterAttributes.Create(SYNS_AttrString);
  fStringAttri.Foreground := clMaroon;
  AddAttribute(fStringAttri);

  fSymbolAttri := TSynHighLighterAttributes.Create(SYNS_AttrSymbol);
  fSymbolAttri.Foreground := clTeal;
  AddAttribute(fSymbolAttri);

  fCustomAttri := TSynHighLighterAttributes.Create(SYNS_AttrCustom);
  fCustomAttri.Foreground := clBlue;
  AddAttribute(fCustomAttri);

  fBlockAttri := TSynHighLighterAttributes.Create(SYNS_AttrBlock);
  fBlockAttri.Foreground := clBlue;
  AddAttribute(fBlockAttri);

  fBlockExtAttri := TSynHighLighterAttributes.Create(SYNS_AttrBlockExt);
  fBlockExtAttri.Foreground := clBlue;
  AddAttribute(fBlockExtAttri);

  fDoubleAttri := TSynHighLighterAttributes.Create(SYNS_AttrDouble);
  fDoubleAttri.Foreground := clBlue;
  AddAttribute(fDoubleAttri);

  fDoubleExtAttri := TSynHighLighterAttributes.Create(SYNS_AttrDoubleExt);
  fDoubleExtAttri.Foreground := clBlue;
  AddAttribute(fDoubleExtAttri);

  fFacilityAttri := TSynHighLighterAttributes.Create(SYNS_AttrFacility);
  fFacilityAttri.Foreground := clBlue;
  AddAttribute(fFacilityAttri);

  fFacilityExtAttri := TSynHighLighterAttributes.Create(SYNS_AttrFacilityExt);
  fFacilityExtAttri.Foreground := clBlue;
  AddAttribute(fFacilityExtAttri);

  fFileAttri := TSynHighLighterAttributes.Create(SYNS_AttrFile);
  fFileAttri.Foreground := clBlue;
  AddAttribute(fFileAttri);

  fFileExtAttri := TSynHighLighterAttributes.Create(SYNS_AttrFileExt);
  fFileExtAttri.Foreground := clBlue;
  AddAttribute(fFileExtAttri);

  fFloatingAttri := TSynHighLighterAttributes.Create(SYNS_AttrFloating);
  fFloatingAttri.Foreground := clBlue;
  AddAttribute(fFloatingAttri);

  fFloatingExtAttri := TSynHighLighterAttributes.Create(SYNS_AttrFloatingExt);
  fFloatingExtAttri.Foreground := clBlue;
  AddAttribute(fFloatingExtAttri);

  fLocalAttri := TSynHighLighterAttributes.Create(SYNS_AttrLocal);
  fLocalAttri.Foreground := clBlue;
  AddAttribute(fLocalAttri);

  fLocalExtAttri := TSynHighLighterAttributes.Create(SYNS_AttrLocalExt);
  fLocalExtAttri.Foreground := clBlue;
  AddAttribute(fLocalExtAttri);

  fSearchAttri := TSynHighLighterAttributes.Create(SYNS_AttrSearch);
  fSearchAttri.Foreground := clBlue;
  AddAttribute(fSearchAttri);

  fSearchExtAttri := TSynHighLighterAttributes.Create(SYNS_AttrSearchExt);
  fSearchExtAttri.Foreground := clBlue;
  AddAttribute(fSearchExtAttri);

  fToolsAttri := TSynHighLighterAttributes.Create(SYNS_AttrTools);
  fToolsAttri.Foreground := clBlue;
  AddAttribute(fToolsAttri);

  fToolsExtAttri := TSynHighLighterAttributes.Create(SYNS_AttrToolsExt);
  fToolsExtAttri.Foreground := clBlue;
  AddAttribute(fToolsExtAttri);

  fExceptionAttri := TSynHighLighterAttributes.Create(SYNS_AttrException);
  fExceptionAttri.Foreground := clBlue;
  AddAttribute(fExceptionAttri);

  fMemoryAttri := TSynHighLighterAttributes.Create(SYNS_AttrMemory);
  fMemoryAttri.Foreground := clBlue;
  AddAttribute(fMemoryAttri);

  fOtherAttri := TSynHighLighterAttributes.Create(SYNS_AttrOther);
  fOtherAttri.Foreground := clBlue;
  AddAttribute(fOtherAttri);

  fStringWordAttri := TSynHighLighterAttributes.Create(SYNS_AttrStringWord);
  fStringWordAttri.Foreground := clBlue;
  AddAttribute(fStringWordAttri);

  SetAttributesOnChange({$IFDEF FPC}@{$ENDIF}DefHighlightChange);
  InitIdent;
  MakeMethodTables;
  fDefaultFilter := SYNS_FilterForth;
  fRange := rsUnknown;
end;

destructor TSynForthSyn.Destroy;
begin
  fCustomWords.Free;
  inherited;
end;

procedure TSynForthSyn.SetLine({$IFDEF FPC}const {$ENDIF}NewValue: String; LineNumber: Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end;

procedure TSynForthSyn.IdentProc;
begin
  fTokenID := IdentKind((fLine + Run));
  if fTokenID = tkString then
  begin
    Inc(Run, fStringLen - 2);
    StringOpenProc;
  end
  else begin
    Inc(Run, fStringLen);
    while Identifiers[fLine[Run]] do Inc(Run);
    if IsCustomWord(GetToken) then fTokenId := tkCustom;
  end;
end;

procedure TSynForthSyn.UnknownProc;
begin
{$IFDEF SYN_MBCSSUPPORT}
  if FLine[Run] in LeadBytes then
    Inc(Run,2)
  else
{$ENDIF}
  inc(Run);
  fTokenID := tkUnknown;
end;

procedure TSynForthSyn.Next;
begin
  fTokenPos := Run;
  case fRange of
    rsForthStyleComment: ForthStyleCommentProc;
  else
    begin
      fRange := rsUnknown;
      fProcTable[fLine[Run]];
    end;
  end;
end;

function TSynForthSyn.GetDefaultAttribute(Index: integer): TSynHighLighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT    : Result := fCommentAttri;
    SYN_ATTR_IDENTIFIER : Result := fIdentifierAttri;
    SYN_ATTR_KEYWORD    : Result := fKeyAttri;
    SYN_ATTR_WHITESPACE : Result := fSpaceAttri;
  else
    Result := nil;
  end;
end;

function TSynForthSyn.GetEOL: Boolean;
begin
  Result := fTokenID = tkNull;
end;

function TSynForthSyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TSynForthSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TSynForthSyn.GetTokenAttribute: TSynHighLighterAttributes;
begin
  case GetTokenID of
    tkBlock: Result := fBlockAttri;
    tkBlockExt: Result := fBlockExtAttri;
    tkComment: Result := fCommentAttri;
    tkCore: Result := fCoreAttri;
    tkCoreExt: Result := fCoreExtAttri;
    tkCustom: Result := fCustomAttri;
    tkDouble: Result := fDoubleAttri;
    tkDoubleExt: Result := fDoubleExtAttri;
    tkException: Result := fExceptionAttri;
    tkFacility: Result := fFacilityAttri;
    tkFacilityExt: Result := fFacilityExtAttri;
    tkFile: Result := fFileAttri;
    tkFileExt: Result := fFileExtAttri;
    tkFloating: Result := fFloatingAttri;
    tkFloatingExt: Result := fFloatingExtAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkLocal: Result := fLocalAttri;
    tkLocalExt: Result := fLocalExtAttri;
    tkMemory: Result := fMemoryAttri;
    tkNumber: Result := fNumberAttri;
    tkOther: Result := fOtherAttri;
    tkRCX: Result := fRCXAttri;
    tkSearch: Result := fSearchAttri;
    tkSearchExt: Result := fSearchExtAttri;
    tkSpace: Result := fSpaceAttri;
    tkString: Result := fStringAttri;
    tkStringWord: Result := fStringWordAttri;
    tkSymbol: Result := fSymbolAttri;
    tkTools: Result := fToolsAttri;
    tkToolsExt: Result := fToolsExtAttri;
    tkUnknown: Result := fIdentifierAttri;
  else
    Result := nil;
  end;
end;

function TSynForthSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TSynForthSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

function TSynForthSyn.GetIdentChars: TSynIdentChars;
begin
  Result := [#33..#126];
end;

function TSynForthSyn.GetSampleSource: string;
begin
  Result := '\ sample word'#13#10 +
            ': .S ( ... -- ... )'#13#10 +
            '  DEPTH ?DUP '#13#10 +
            '  IF 0 DO I PICK . LOOP THEN ;'#13#10 +
            'RCX_BUTTON DUP BUTTON_GET @ U.'#13#10 +
            ': HW ." Hello World " ;';
end;

function TSynForthSyn.IsFilterStored: Boolean;
begin
  Result := fDefaultFilter <> SYNS_FilterForth;
end;

{$IFNDEF SYN_CPPB_1} class {$ENDIF}
function TSynForthSyn.GetLanguageName: string;
begin
  Result := SYNS_LangForth;
end;

procedure TSynForthSyn.ResetRange;
begin
  fRange := rsUnknown;
end;

procedure TSynForthSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

function TSynForthSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

procedure TSynForthSyn.IntegerProc;
var
  i : integer;
begin
  inc(Run);
  i := 1;
  fTokenID := tkNumber;
  while FLine[Run] in ['0'..'9', 'A'..'F'] do
  begin
    inc(i);
    inc(Run);
  end;
  // if the next character isn't whitespace then this isn't really
  // a number.
  if not (FLine[Run] in [#0, #10, #13, #32]) or
     ((i = 1) and (fLine[Run-i] = '-')) then
  begin
    dec(Run, i);
    fTokenID := tkUnknown; // it might have been a keyword ?
    IdentProc;
  end;
end;

procedure TSynForthSyn.SetCustomWords(const Value: TStrings);
begin
  fCustomWords.Assign(Value);
  DefHighLightChange(nil);
end;

function TSynForthSyn.IsCustomWord(const AToken: string): boolean;
var
  i : integer;
begin
  Result := TCSStringList(fCustomWords).Find(AToken, i);
end;

function TSynForthSyn.Func6: TtkTokenKind;
begin
  if KeyComp('F-') then Result := tkFloating else
    if KeyComp('F0=') then Result := tkFloating else
      if KeyComp('F~') then Result := tkFloatingExt else
        if KeyComp('F+') then Result := tkFloating else
          if KeyComp('F0<') then Result := tkFloating else
            if KeyComp('F<') then Result := tkFloating else
              if KeyComp('F@') then Result := tkFloating else
                if KeyComp('F*') then Result := tkFloating else
                  if KeyComp('F!') then Result := tkFloating else
                    if KeyComp('F**') then Result := tkFloatingExt else
                      if KeyComp('F/') then Result := tkFloating else
                        if KeyComp('F.') then Result := tkFloating else Result := tkIdentifier;
end;

function TSynForthSyn.Func11: TtkTokenKind;
begin
  if KeyComp('FE.') then Result := tkFloatingExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func28: TtkTokenKind;
begin
  if KeyComp('CASE') then Result := tkKey else
    if KeyComp('FABS') then Result := tkFloatingExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func29: TtkTokenKind;
begin
  if KeyComp('SEE') then Result := tkTools else
    if KeyComp('PAGE') then Result := tkFacility else Result := tkIdentifier;
end;

function TSynForthSyn.Func40: TtkTokenKind;
begin
  if KeyComp('BLANK') then Result := tkStringWord else
    if KeyComp('SCR') then Result := tkBlockExt else
      if KeyComp('FLOG') then Result := tkFloatingExt else
        if KeyComp('DMIN') then Result := tkDouble else Result := tkIdentifier;
end;

function TSynForthSyn.Func42: TtkTokenKind;
begin
  if KeyComp('FMIN') then Result := tkFloating else
    if KeyComp('FATAN2') then Result := tkFloatingExt else
      if KeyComp('FATAN') then Result := tkFloatingExt else
        if KeyComp('DMAX') then Result := tkDouble else Result := tkIdentifier;
end;

function TSynForthSyn.Func50: TtkTokenKind;
begin
  if KeyComp('SPAN') then Result := tkCoreExt else
    if KeyComp('FATANH') then Result := tkFloatingExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func54: TtkTokenKind;
begin
  if KeyComp('DUMP') then Result := tkTools else
    if KeyComp('SEARCH') then Result := tkStringWord else
      if KeyComp('>FLOAT') then Result := tkFloating else
        if KeyComp('FLOAT+') then Result := tkFloating else Result := tkIdentifier;
end;

function TSynForthSyn.Func69: TtkTokenKind;
begin
  if KeyComp('ALLOCATE') then Result := tkMemory else
    if KeyComp('''ato4th') then Result := tkOther else Result := tkIdentifier;
end;

function TSynForthSyn.Func71: TtkTokenKind;
begin
  if KeyComp('FORGET') then Result := tkToolsExt else
    if KeyComp('EDITOR') then Result := tkToolsExt else
      if KeyComp('COMPARE') then Result := tkStringWord else Result := tkIdentifier;
end;

function TSynForthSyn.Func72: TtkTokenKind;
begin
  if KeyComp('INCLUDED') then Result := tkFile else Result := tkIdentifier;
end;

function TSynForthSyn.Func78: TtkTokenKind;
begin
  if KeyComp('FROUND') then Result := tkFloating else Result := tkIdentifier;
end;

function TSynForthSyn.Func85: TtkTokenKind;
begin
  if KeyComp('FSINCOS') then Result := tkFloatingExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func90: TtkTokenKind;
begin
  if KeyComp('-TRAILING') then Result := tkStringWord else Result := tkIdentifier;
end;

function TSynForthSyn.Func91: TtkTokenKind;
begin
  if KeyComp('FILE-SIZE') then Result := tkFile else Result := tkIdentifier;
end;

function TSynForthSyn.Func100: TtkTokenKind;
begin
  if KeyComp('INCLUDE-FILE') then Result := tkFile else Result := tkIdentifier;
end;

function TSynForthSyn.Func107: TtkTokenKind;
begin
  if KeyComp('WRITE-FILE') then Result := tkFile else Result := tkIdentifier;
end;

function TSynForthSyn.Func108: TtkTokenKind;
begin
  if KeyComp('PRECISION') then Result := tkFloatingExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func112: TtkTokenKind;
begin
  if KeyComp('FCONSTANT') then Result := tkFloating else
    if KeyComp('''UserISR') then Result := tkOther else Result := tkIdentifier;
end;

function TSynForthSyn.Func115: TtkTokenKind;
begin
  if KeyComp('WRITE-LINE') then Result := tkFile else Result := tkIdentifier;
end;

function TSynForthSyn.Func131: TtkTokenKind;
begin
  if KeyComp('GET-CURRENT') then Result := tkSearch else Result := tkIdentifier;
end;

function TSynForthSyn.Func143: TtkTokenKind;
begin
  if KeyComp('SET-CURRENT') then Result := tkSearch else Result := tkIdentifier;
end;

function TSynForthSyn.Func152: TtkTokenKind;
begin
  if KeyComp('SET-PRECISION') then Result := tkFloatingExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func172: TtkTokenKind;
begin
  if KeyComp('REPOSITION-FILE') then Result := tkFile else Result := tkIdentifier;
end;

function TSynForthSyn.Func174: TtkTokenKind;
begin
  if KeyComp('SEARCH-WORDLIST') then Result := tkSearch else Result := tkIdentifier;
end;

function TSynForthSyn.Func180: TtkTokenKind;
begin
  if KeyComp('RESTORE-INPUT') then Result := tkCoreExt else Result := tkIdentifier;
end;

function TSynForthSyn.Func187: TtkTokenKind;
begin
  if KeyComp('FORTH-WORDLIST') then Result := tkSearch else Result := tkIdentifier;
end;

initialization
  MakeIdentTable;
{$IFNDEF SYN_CPPB_1}
  RegisterPlaceableHighlighter(TSynForthSyn);
{$ENDIF}
end.
