unit uEditorExperts;

interface

uses
  SynEdit, SynEditKeyCmds;

const
  K_USER_PREVIDENT      = ecUserFirst + 1;
  K_USER_NEXTIDENT      = ecUserFirst + 2;
  K_USER_COMMENTBLOCK   = ecUserFirst + 3;
  K_USER_UNCOMMENTBLOCK = ecUserFirst + 4;

procedure AddEditorExpertCommands(aEditor : TCustomSynEdit);
function FindIdentAtPos(const Source: string; CurPos: Integer; Prev: Boolean;
  var Pos: Integer; var Ident: string): Boolean;

implementation

uses
  uNBCCommon, Classes, SysUtils, Menus, Windows;

const
  VK_OEM_PERIOD = $BE; // '.' any country
  VK_OEM_COMMA  = $BC; // ',' any country

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

end.