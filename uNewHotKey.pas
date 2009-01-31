unit uNewHotKey;

interface

uses
  Classes, Controls, StdCtrls,
  {$IFNDEF FPC}Windows, Messages,{$ENDIF}
  ComCtrls;

type
  TBricxCCHotKey = class(TEdit)
{$IFNDEF FPC}
  private
    FInvalidKeys: THKInvalidKeys;
    procedure SetInvalidKeys(Value: THKInvalidKeys);
    function GetHotKey: TShortcut;
    procedure SetHotKey(const Value: TShortcut);
  protected
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure DoExit; override;
    procedure CheckInvalidKeys(var Key : Word; Shift : TShiftState);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property HotKey: TShortcut read GetHotKey write SetHotKey;
    property InvalidKeys: THKInvalidKeys read FInvalidKeys write SetInvalidKeys;
{$ENDIF}
  end;

implementation

{$IFNDEF FPC}

uses
  Consts, SysUtils;

function RemoveStates(St: string): string;
begin
  if Copy(St, 1, 5) = 'Ctrl+' then
    Delete(St, 1, 5);

  if Copy(St, 1, 4) = 'Alt+' then
    Delete(St, 1, 4);

  if Copy(St, 1, 6) = 'Shift+' then
    Delete(St, 1, 6);

  Result := St;
end;

type
  TMenuKeyCap = (mkcBkSp, mkcTab, mkcEsc, mkcEnter, mkcSpace, mkcPgUp,
    mkcPgDn, mkcEnd, mkcHome, mkcLeft, mkcUp, mkcRight, mkcDown, mkcIns,
    mkcDel, mkcShift, mkcCtrl, mkcAlt);

var
  MenuKeyCaps: array[TMenuKeyCap] of string = (
    SmkcBkSp, SmkcTab, SmkcEsc, SmkcEnter, SmkcSpace, SmkcPgUp,
    SmkcPgDn, SmkcEnd, SmkcHome, SmkcLeft, SmkcUp, SmkcRight,
    SmkcDown, SmkcIns, SmkcDel, SmkcShift, SmkcCtrl, SmkcAlt);

function GetSpecialName(ShortCut: TShortCut): string;
var
  ScanCode: Integer;
  KeyName: array[0..255] of Char;
begin
  Result := '';
  ScanCode := MapVirtualKey(WordRec(ShortCut).Lo, 0) shl 16;
  if ScanCode <> 0 then
  begin
    GetKeyNameText(ScanCode, KeyName, SizeOf(KeyName));
    GetSpecialName := KeyName;
  end;
end;

function ShortCutToText(ShortCut: TShortCut): string;
var
  Name: string;
begin
  case WordRec(ShortCut).Lo of
    $08, $09:
      Name := MenuKeyCaps[TMenuKeyCap(Ord(mkcBkSp) + WordRec(ShortCut).Lo - $08)];
    $0D: Name := MenuKeyCaps[mkcEnter];
    $1B: Name := MenuKeyCaps[mkcEsc];
    $20..$28:
      Name := MenuKeyCaps[TMenuKeyCap(Ord(mkcSpace) + WordRec(ShortCut).Lo - $20)];
    $2D..$2E:
      Name := MenuKeyCaps[TMenuKeyCap(Ord(mkcIns) + WordRec(ShortCut).Lo - $2D)];
    $30..$39: Name := Chr(WordRec(ShortCut).Lo - $30 + Ord('0'));
    $41..$5A: Name := Chr(WordRec(ShortCut).Lo - $41 + Ord('A'));
//    $60..$69: Name := Chr(WordRec(ShortCut).Lo - $60 + Ord('0'));
    $70..$87: Name := 'F' + IntToStr(WordRec(ShortCut).Lo - $6F);
  else
    Name := GetSpecialName(ShortCut);
  end;
  if Name <> '' then
  begin
    Result := '';
    if ShortCut and scShift <> 0 then Result := Result + MenuKeyCaps[mkcShift];
    if ShortCut and scCtrl <> 0 then Result := Result + MenuKeyCaps[mkcCtrl];
    if ShortCut and scAlt <> 0 then Result := Result + MenuKeyCaps[mkcAlt];
    Result := Result + Name;
  end
  else Result := '';
end;

function TextToShortCut(Text: string): TShortCut;

  function CompareFront(var Text: string; const Front: string): Boolean;
  begin
    Result := False;
    if (Length(Text) >= Length(Front)) and
      (AnsiStrLIComp(PChar(Text), PChar(Front), Length(Front)) = 0) then
    begin
      Result := True;
      Delete(Text, 1, Length(Front));
    end;
  end;

var
  Key: TShortCut;
  Shift: TShortCut;
begin
  Result := 0;
  Shift := 0;
  while True do
  begin
    if CompareFront(Text, MenuKeyCaps[mkcShift]) then Shift := Shift or scShift
    else if CompareFront(Text, '^') then Shift := Shift or scCtrl
    else if CompareFront(Text, MenuKeyCaps[mkcCtrl]) then Shift := Shift or scCtrl
    else if CompareFront(Text, MenuKeyCaps[mkcAlt]) then Shift := Shift or scAlt
    else Break;
  end;
  if Text = '' then Exit;
  for Key := $08 to $255 do { Copy range from table in ShortCutToText }
    if AnsiCompareText(Text, ShortCutToText(Key)) = 0 then
    begin
      Result := Key or Shift;
      Exit;
    end;
end;

{ TBricxCCHotKey }

procedure TBricxCCHotKey.CheckInvalidKeys(var Key: Word; Shift: TShiftState);
begin
  if ((hcNone in InvalidKeys) and (Shift = [])) or
     ((hcShift in InvalidKeys) and (Shift = [ssShift])) or
     ((hcCtrl in InvalidKeys) and (Shift = [ssCtrl])) or
     ((hcAlt in InvalidKeys) and (Shift = [ssAlt])) or
     ((hcShiftCtrl in InvalidKeys) and (Shift = [ssShift,ssCtrl])) or
     ((hcShiftAlt in InvalidKeys) and (Shift = [ssShift,ssAlt])) or
     ((hcCtrlAlt in InvalidKeys) and (Shift = [ssAlt,ssCtrl])) or
     ((hcShiftCtrlAlt in InvalidKeys) and (Shift = [ssShift,ssAlt,ssCtrl])) then
    Key := 0;
end;

constructor TBricxCCHotKey.Create(AOwner: TComponent);
begin
  inherited;
  FInvalidKeys := [hcNone, hcShift];
end;

procedure TBricxCCHotKey.DoExit;
begin
  inherited;
  if (length(Text) > 0) and (RemoveStates(Text) = '') then
  begin
    Text := 'None';
    SelStart := length(Text);
  end;
end;

function TBricxCCHotKey.GetHotKey: TShortcut;
begin
  Result := TextToShortCut(Text);
end;

procedure TBricxCCHotKey.KeyDown(var Key: Word; Shift: TShiftState);
var
  TmpString : String;
begin
  // require certain modifiers
  CheckInvalidKeys(Key, Shift);
  if Key <> 0 then
  begin
    TmpString := '';
    if ssCtrl in Shift then
      TmpString := TmpString + 'Ctrl+';
    if ssAlt in Shift then
      TmpString := TmpString + 'Alt+';
    if ssShift in Shift then
      TmpString := TmpString + 'Shift+';

    if (key = VK_CONTROL) or (key = VK_MENU) or (key = VK_SHIFT) then
    begin
      //Nothing, the Shift state takes care of it
    end else begin
      TmpString := TmpString + ShortCutToText(Key);
    end;

    if Text <> TmpString then
      Text := TmpString;

    SelStart := length(Text);
  end;
end;

procedure TBricxCCHotKey.KeyPress(var Key: Char);
begin
  if (length(Text) > 0) and (RemoveStates(Text) <> '') then
    Key := #0;
end;

procedure TBricxCCHotKey.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if (length(Text) > 0) and (RemoveStates(Text) = '') then
  begin
    Text := 'None';
    SelStart := length(Text);
  end;
end;

procedure TBricxCCHotKey.SetHotKey(const Value: TShortcut);
begin
  if Value = 0 then
    Text := 'None'
  else
    Text := ShortCutToText(Value);
  SelStart := length(Text);
end;

procedure TBricxCCHotKey.SetInvalidKeys(Value: THKInvalidKeys);
begin
  if Value <> FInvalidKeys then
    FInvalidKeys := Value;
end;

procedure TBricxCCHotKey.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTTAB;  //This is causing an invalid pointer op right now.
end;

{$ENDIF}

end.
