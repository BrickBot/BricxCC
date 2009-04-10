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
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uEditorExperts;

interface

uses
  Classes, SynEdit, SynEditKeyCmds;

type
  TGXAlignMode = (gamRightmost, gamFirstToken);
  TCommentType = (ctSlash, ctCpp);

var
  CommentType: TCommentType = ctSlash;
  InsertRemoveSpace: Boolean = False;
  AlignMinWhitespace : integer = 0;
  AlignMode: TGXAlignMode = gamFirstToken;
  AlignToken: string = '=';
  AlignTokenList : string = '==,=,//,{,/*,"""",:,+';

const
  K_USER_PREVIDENT      = ecUserFirst + 1;
  K_USER_NEXTIDENT      = ecUserFirst + 2;
  K_USER_COMMENTBLOCK   = ecUserFirst + 3;
  K_USER_UNCOMMENTBLOCK = ecUserFirst + 4;
  K_USER_REVERSE        = ecUserFirst + 5;
  K_USER_ALIGN          = ecUserFirst + 6;

procedure AddEditorExpertCommands(aEditor : TCustomSynEdit);
function FindIdentAtPos(const Source: string; CurPos: Integer; Prev: Boolean;
  var Pos: Integer; var Ident: string): Boolean;
function ReverseStatements(Lines: TStrings): Boolean;
function CommentLines(Lines: TStrings): Boolean;
function UncommentLines(Lines: TStrings): Boolean;
function SortLines(Lines: TStrings): Boolean;
function AlignSelectedLines(Lines: TStrings): Boolean;

implementation

uses
  uNBCCommon, Preferences, uEEAlignOpt, SysUtils, Menus, Math, Controls;

//const
//  DEFAULT_WHITESPACE = 0;
//  DEFAULT_TOKENS: array[0..7] of string = ('==', '=', '//', '{', '/*', '"', ':', '+');

const
  VK_OEM_PERIOD = $BE; // '.' any country
  VK_OEM_COMMA  = $BC; // ',' any country
  VK_LEFT       = 37;
  VK_UP         = 38;
  VK_RIGHT      = 39;
  VK_DOWN       = 40;
  VK_END        = 35;
  VK_HOME       = 36;

procedure AddEditorExpertCommands(aEditor : TCustomSynEdit);
var
  KS : TSynEditKeystroke;
begin
  // add in the keystrokes for Editor Experts
  KS := aEditor.Keystrokes.Add;
  KS.Command := K_USER_PREVIDENT;
  KS.ShortCut := ShortCut(VK_UP, [ssCtrl, ssAlt]);
  KS := aEditor.Keystrokes.Add;
  KS.Command := K_USER_NEXTIDENT;
  KS.ShortCut := ShortCut(VK_DOWN, [ssCtrl, ssAlt]);
  KS := aEditor.Keystrokes.Add;
  KS.Command := K_USER_COMMENTBLOCK;
  KS.ShortCut := ShortCut(VK_OEM_PERIOD, [ssCtrl, ssAlt]);
  KS := aEditor.Keystrokes.Add;
  KS.Command := K_USER_UNCOMMENTBLOCK;
  KS.ShortCut := ShortCut(VK_OEM_COMMA, [ssCtrl, ssAlt]);
  KS := aEditor.Keystrokes.Add;
  KS.Command := K_USER_REVERSE;
  KS.ShortCut := ShortCut(VK_HOME, [ssCtrl, ssAlt]);
  KS := aEditor.Keystrokes.Add;
  KS.Command := K_USER_ALIGN;
  KS.ShortCut := ShortCut(VK_END, [ssCtrl, ssAlt]);
end;

function IsStrCaseIns(const Str: string; Pos: Integer; const SubStr: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  if Pos + Length(SubStr) - 1 <= Length(Str) then
  begin
    for i := 1 to Length(SubStr) do
      if AnsiUpperCase(Str[Pos + i - 1]) <> AnsiUpperCase(SubStr[i]) then
        Exit;
  end
  else
    Exit;
  Result := True;
end;

function FindTextIdent(Id: string; const Source: string;
  LastPos: Integer; Prev: Boolean; var Pos: Integer): Boolean;
var
  StartPos: Integer;

  function GoNext: Boolean;
  begin
    if Prev then
      Dec(StartPos)
    else
      Inc(StartPos);
    Result := (StartPos >= 1) and (StartPos <= Length(Source));
  end;

var
  PrevChar: Char;
  NextChar: Char;
begin
  Result := False;
  if Id = '' then
    Exit;

  Id := AnsiUpperCase(Id);
  StartPos := LastPos;

  while GoNext do
    if AnsiUpperCase(Source[StartPos]) = Id[1] then
      if IsStrCaseIns(Source, StartPos, Id) then
      begin
        if (StartPos - 1) < 1 then
          PrevChar := ' '
        else
          PrevChar := Source[StartPos - 1];
        if (StartPos + Length(Id)) > Length(Source) then
          NextChar := ' '
        else
          NextChar := Source[StartPos + Length(Id)];

        if (not IsAlpha(PrevChar)) and (not IsAlpha(NextChar)) then
        begin
          Pos := StartPos;
          Result := True;
          Break;
        end;
      end;
end;

function CurrentIdent(const Source: string; CurPos: Integer;
  var Pos, Len: Integer): Boolean;
begin
  Result := False;

  while CurPos >= 1 do
    if IsAlpha(Source[CurPos]) then
    begin
      Dec(CurPos);
      Result := True;
    end
    else if (not Result) and (CurPos >= 2) then
      if IsAlpha(Source[CurPos - 1]) then
      begin
        Dec(CurPos, 2);
        Result := True;
      end
      else
        Break
    else
      Break;

  if Result then
  begin
    Pos := CurPos + 1;
    Inc(CurPos, 2);
    while (CurPos >= 1) and (CurPos <= Length(Source)) do
      if IsAlpha(Source[CurPos]) then
        Inc(CurPos)
      else
        Break;

    Len := CurPos - Pos;
  end;
end;

function FindIdentAtPos(const Source: string; CurPos: Integer; Prev: Boolean;
  var Pos: Integer; var Ident: string): Boolean;
var
  StartPos: Integer;
  Id: string;
  Len: Integer;
begin
  Result := False;

  if CurrentIdent(Source, CurPos, StartPos, Len) then
  begin
    Id := Copy(Source, StartPos, Len);
    Result := FindTextIdent(Id, Source, StartPos, Prev, Pos);
    Ident := Id;
  end;
end;

function ExpandTabsInLine(AText: string; ATabSize: Integer): string;
var
  i: Integer;
  ResultLen, SpaceLen: Integer;
begin
  Result := '';
  ResultLen := 0;

  for i := 1 to Length(AText) do
  begin
    if AText[i] <> #9 then
    begin
      Result := Result + AText[i];
      Inc(ResultLen);
    end
    else
    begin
      SpaceLen := ATabSize - (ResultLen mod ATabSize);
      Result := Result + StringOfChar(' ', SpaceLen);
      Inc(ResultLen, SpaceLen);
    end;
  end;
end;

function QueryUserForAlignToken(var Token: string; var Mode: TGXAlignMode): Boolean;
var
  Dialog: TfmAlign;
const
  AM_IDX : array[TGXAlignMode] of integer = (0, 1);
begin
  Result := False;
  Mode := gamRightmost;

  Dialog := TfmAlign.Create(nil);
  try
    Dialog.lstTokens.Items.CommaText := AlignTokenList;
    Dialog.lstTokens.ItemIndex := Dialog.lstTokens.Items.IndexOf(AlignToken);
    Dialog.cbxMode.ItemIndex := AM_IDX[AlignMode];
    if Dialog.ShowModal = mrOk then
    begin
      Token := Dialog.lstTokens.Items[Dialog.lstTokens.ItemIndex];
      if Dialog.cbxMode.ItemIndex > 0 then
        Mode := gamFirstToken;
      Result := True;
    end;
  finally
    FreeAndNil(Dialog);
  end;
end;

resourcestring
  SNoTokens = 'No tokens found to align on.';

function AlignSelectedLines(Lines: TStrings): Boolean;
var
  i: Integer;
  FirstIndex, PosIndex: Integer;
  RowLength, MaxRowLength: Integer;
  AlignIndex: Integer;
  Temp: string;
  MaxPos: Integer;
  LineSuffix: string;
begin
  Assert(Assigned(Lines));
  Result := False;

  if Lines.Count < 2 then
    Exit;

  if not QueryUserForAlignToken(AlignToken, AlignMode) then
    Exit;

  FirstIndex := 0;
  RowLength := 0;
  MaxRowLength := 0;

  // Decide at what column to align by
  for i := 0 to Lines.Count - 1 do
  begin
    Temp := ExpandTabsInLine(Lines[i], TabWidth);

    PosIndex := Pos(AlignToken, Temp);

    if (PosIndex > 0) and (FirstIndex = 0) then
    begin
      FirstIndex := PosIndex;
      // If first line contains token, only align based on that token
      if AlignMode = gamFirstToken then
        Break;
    end;

    if PosIndex > 0 then
      RowLength := Length(TrimRight(Copy(Temp, 1, PosIndex - 1))) + AlignMinWhitespace;

    if RowLength > MaxRowLength then
      MaxRowLength := RowLength;
  end;

  // Exit if nothing to align
  if FirstIndex = 0 then
    raise Exception.Create(SNoTokens);

  // Try to align at column of first found otherwise
  // align after the maximum length of a row
  if FirstIndex > MaxRowLength then
    AlignIndex  := FirstIndex - 1
  else
    AlignIndex := MaxRowLength;

  // Perform alignment
  for i := 0 to Lines.Count - 1 do
  begin
    PosIndex := Pos(AlignToken, Lines[i]);

    if PosIndex > 0 then
    begin
      Temp := TrimRight(Copy(Lines[i], 1, PosIndex - 1));
      MaxPos := Max(AlignIndex - Length(ExpandTabsInLine(Temp, TabWidth)), AlignMinWhitespace);
      LineSuffix := Copy(Lines[i], PosIndex, Length(Lines[i]));
      Lines[i] := Temp + StringOfChar(' ', MaxPos) + LineSuffix;
    end;
  end;

  Result := True;
end;

function ReverseAssignment(var S: string): Boolean;
var
  i: Integer;
  AssignOp: string;
  AssignPos: Integer;
  SemPos: Integer;
  StringBefore: string;
  StringAfter: string;
  TrailingString: string;
  SpaceBefore: string;
  SpaceAfter: string;
  LeadingSpace: string;
begin
  AssignOp := '=';
  Result := False;
  if S = '' then
    Exit;
  AssignPos := Pos(AssignOp, S);
  SemPos := LastDelimiter(';', S);
  TrailingString := Copy(S, SemPos + 1, 9999);

  if (AssignPos > 1) and (SemPos > 3) and (Length(S) > AssignPos + 1) then
  begin
    if StrContains('//', S) then
      if Pos('//', S) < AssignPos then
        Exit;
    if StrContains('/*', S) then
      if Pos('/*', S) < AssignPos then
        Exit;
    if Pos(S, '==') = AssignPos then
      Exit;
    i := 1;
    while IsCharWhitespace(S[i]) do
    begin
      LeadingSpace := LeadingSpace + S[i];
      Inc(i);
    end;
    StringBefore := Copy(S, i, AssignPos - i);
    i := AssignPos - 1;
    if StringBefore <> '' then
    begin
      while IsCharWhitespace(S[i]) do
      begin
        SpaceBefore := S[i] + SpaceBefore;
        SetLength(StringBefore, Length(StringBefore) - 1);
        Dec(i)
      end;
    end;
    i := AssignPos + Length(AssignOp);
    while IsCharWhitespace(S[i]) do
    begin
      SpaceAfter := SpaceAfter + S[i];
      Inc(i);
    end;
    StringAfter := Copy(S, i, SemPos - i);
    S := LeadingSpace + StringAfter + SpaceAfter + AssignOp +
      SpaceBefore + StringBefore + ';' + TrailingString;
    Result := True;
  end;
end;

function ReverseOneLine(const S: string; var Changed : boolean): string;
begin
  Result := S;
  Changed := ReverseAssignment(Result) or Changed;
end;

function ReverseStatements(Lines: TStrings): Boolean;
var
  i: Integer;
  FMadeChanges : boolean;
begin
  Assert(Assigned(Lines));
  FMadeChanges := False;
  for i := 0 to Lines.Count - 1 do
    Lines[i] := ReverseOneLine(Lines[i], FMadeChanges);
  Result := FMadeChanges;
end;

procedure AddBracketing(const CodeList: TStrings; const LeftBracket, RightBracket: string);
begin
  if InsertRemoveSpace then
  begin
    CodeList[0] := LeftBracket + ' ' + CodeList[0];
    CodeList[CodeList.Count - 1] := CodeList[CodeList.Count - 1] + ' ' + RightBracket;
  end
  else
  begin
    CodeList[0] := LeftBracket + CodeList[0];
    CodeList[CodeList.Count - 1] := CodeList[CodeList.Count - 1] + RightBracket;
  end;
end;

function CommentLines(Lines: TStrings): Boolean;
var
  i: Integer;
  CommentPrefix: string;
begin
  Assert(Assigned(Lines));

  // Do not localize any of the below lines.
  case CommentType of
    ctSlash:
      begin
        if InsertRemoveSpace then
          CommentPrefix := '// '
        else
          CommentPrefix := '//';

        for i := 0 to Lines.Count - 1 do
          Lines[i] := CommentPrefix + Lines[i];
      end;

    ctCpp:
      AddBracketing(Lines, '/*', '*/');

  else
    Assert(False);
  end;
  Result := True;
end;

function UncommentLines(Lines: TStrings): Boolean;

  function RemoveFirstString(const SubString, InString: string): string;
  var
    Success: Boolean;

    function RemoveFirstInternal(const SubString, InString: string): string;
    var
      SubStringPos: Integer;
    begin
      if StrLComp(PChar(Trim(InString)), PChar(SubString), Length(SubString)) = 0 then
      begin
        SubStringPos := Pos(SubString, InString);
        if SubStringPos > 1 then
        begin
          Result := Copy(InString, 1, SubStringPos - 1) +
            Copy(InString, SubStringPos + Length(SubString), MaxInt)
        end
        else
          Result := Copy(InString, Length(SubString) + 1, MaxInt);

        Success := True;
      end
      else
        Result := InString;
    end;

  begin
    Success := False;
    // If spaces are to be removed, try to first kill
    // WITH space, otherwise continue with default
    // comment removal.
    if InsertRemoveSpace then
    begin
      Result := RemoveFirstInternal(SubString + ' ', InString);
      if Success then
        Exit;
    end;

    Result := RemoveFirstInternal(SubString, InString);
  end;

  function RemoveLastString(const SubString, InString: string): string;
  var
    Success: Boolean;

    function RemoveLastInternal(const SubString, InString: string): string;
    var
      SubStringStartPos: Integer;
      TempString: string;
    begin
      TempString := TrimRight(InString);

      SubStringStartPos := Length(TempString) - Length(SubString) + 1;

      if SubString = Copy(TempString, SubStringStartPos, Length(SubString)) then
      begin
        Result := Copy(TempString, 1, SubStringStartPos - 1);
        Success := True;
      end
      else
        Result := InString;
    end;

  begin
    Success := False;
    // If spaces are to be removed, try to first kill
    // WITH space, otherwise continue with default
    // comment removal.
    if InsertRemoveSpace then
    begin
      Result := RemoveLastInternal(' ' + SubString, InString);
      if Success then
        Exit;
    end;

    Result := RemoveLastInternal(SubString, InString);
  end;

var
  i: Integer;
begin
  Assert(Assigned(Lines));

  case CommentType of
    ctSlash:
      for i := 0 to Lines.Count - 1 do
        Lines[i] := RemoveFirstString('//', Lines[i]);
    ctCpp:
      begin
        Lines[0] := RemoveFirstString('/*', Lines[0]);
        Lines[Lines.Count - 1] := RemoveLastString('*/', Lines[Lines.Count - 1]);
      end;
  end;
  Result := True;
end;

function SortLines(Lines: TStrings): Boolean;
var
  TrimList, SortedList: TStringList;
  i: Integer;
begin
  Result := False;
  if Lines.Count > 1 then
  begin
   // The trim mess here is so we can ignore whitespace when sorting
    TrimList := TStringList.Create;
    try
      SortedList := TStringList.Create;
      try
        for i := 0 to Lines.Count - 1 do
          TrimList.AddObject(TrimLeft(Lines[i]), TObject(i));
        TrimList.Sort;
        for i := 0 to TrimList.Count - 1 do
          SortedList.Add(Lines[Integer(TrimList.Objects[i])]);
        Lines.Clear;
        Lines.AddStrings(SortedList);
      finally
        FreeAndNil(SortedList);
      end;
    finally
      FreeAndNil(TrimList);
    end;
    Result := True;
  end;
end;

end.