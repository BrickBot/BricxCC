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
unit uGuiUtils;

interface

uses
  Controls, StdCtrls, Menus, Forms,
{$IFNDEF FPC}
  DirectoryEdit, Messages, 
{$ELSE}
  EditBtn,
{$ENDIF}
  uNewHotKey, uOfficeComp, SynEdit;

//procedure AdjustGroupBox(gb : TGroupBox);
procedure ConfigBar(ogp : TOfficeGradientPanel);
procedure SizeComboboxDropdown( cb: TCustomCombobox );
procedure CloneDE(aDest : TDirectoryEdit; aSrc : TEdit);
procedure CloneSynEdit(aDest : TSynEdit; aSrc : TMemo);
procedure CloneHotKey(aDest : TBricxCCHotKey; aSrc : TEdit);
procedure SetWindowFocus(WC : TWinControl);
function GetTick : Cardinal;
function GetWindowTitleBarHeight : integer;
procedure AddMenuItems(m : TMenuItem; a : array of TMenuItem);
procedure CenterForm(const Form: TCustomForm);
procedure EnsureFormVisible(const Form: TCustomForm);

implementation

uses
  Themes, Graphics, Classes,
{$IFNDEF FPC}
  Windows,
{$ELSE}
  LCLIntf,
{$ENDIF}
  SysUtils, ComCtrls;


const
{$IFDEF FPC}
{$IFDEF Darwin}
  GB_VOFFSET = 14;
  GB_HOFFSET = 2;
{$ENDIF}
{$IFNDEF Darwin}
  GB_VOFFSET = 16;
  GB_HOFFSET = 0;
{$ENDIF}
{$ELSE}
  GB_VOFFSET = 0;
  GB_HOFFSET = 0;
{$ENDIF}

(*
procedure AdjustGroupBox(gb : TGroupBox);
var
  C : TControl;
  i : integer;
begin
{$IFDEF FPC}
  // move children up (recursively)
  for i := 0 to gb.ControlCount - 1 do
  begin
    C := gb.Controls[i];
    if C is TGroupBox then
      AdjustGroupBox(TGroupBox(C))
    else
    begin
      C.Top  := C.Top - GB_VOFFSET;
      C.Left := C.Left - GB_HOFFSET;
    end;
  end;
{$ENDIF}
end;
*)

procedure ConfigBar(ogp : TOfficeGradientPanel);
begin
{$IFNDEF FPC}
  if ThemeServices.ThemesEnabled then
  begin
    ogp.GradientFrom := dxOffice11ToolbarsColor1;
    ogp.GradientTo   := dxOffice11ToolbarsColor2;
    ogp.BorderColor  := ogp.GradientTo;
  end
  else
  begin
    ogp.GradientFrom := clBtnFace;
    ogp.GradientTo   := clBtnFace;
    ogp.BorderColor  := ogp.GradientTo;
  end;
{$ENDIF}
end;

function CalcMaxWidthOfStrings( aList: TStrings; aFont: TFont ): integer;
{$IFDEF FPC}
begin
  Result := 40;
{$ELSE}
var
  max, n, i, extra: Integer;
  canvas: TCanvas;
begin
  Assert( Assigned( aList ));
  Assert( Assigned( aFont ));
  canvas:= TCanvas.Create;
  try
    canvas.Handle := CreateDC('DISPLAY', nil, nil, nil );
    try
      extra := GetSystemMetrics(SM_CXVSCROLL);
      Canvas.Font := aFont;
      max := 0;
      for i := 0 to aList.Count-1 do
      begin
        n:= Canvas.TextWidth( aList[i] );
        if n > max then
          max := n;
      end;
      Result := max + extra;
    finally
      DeleteDC( canvas.Handle );
      canvas.Handle := 0;
    end;
  finally
    canvas.free;
  end;
{$ENDIF}
end;

procedure SizeComboboxDropdown( cb: TCustomCombobox );
{$IFDEF FPC}
begin
{$ELSE}
var
  max: Integer;
begin
  max:= CalcMaxWidthOfStrings( cb.Items, TCombobox(cb).Font );
  if max > cb.Width Then
    cb.Perform( CB_SETDROPPEDWIDTH, max+6, 0 );
{$ENDIF}
end;

procedure CloneDE(aDest: TDirectoryEdit; aSrc: TEdit);
begin
  if (aSrc = nil) or (aDest = nil) then Exit;
  aDest.Name        := Copy(aSrc.Name, 1, Length(aSrc.Name)-1);
  aDest.Parent      := aSrc.Parent;
  aDest.Top         := aSrc.Top;
  aDest.Width       := aSrc.Width;
  aDest.Height      := aSrc.Height;
  aDest.AutoSize    := aSrc.AutoSize;
  aDest.TabOrder    := aSrc.TabOrder;
  aDest.Hint        := aSrc.Hint;
  aDest.OnChange    := aSrc.OnChange;
{$IFNDEF FPC}
  aDest.Left        := aSrc.Left;
  aDest.Cursor      := aSrc.Cursor;
  aDest.ReadOnly    := aSrc.ReadOnly;
  aDest.SetHint     := False;
{$ELSE}
  aDest.Left        := aSrc.Left + 4;
  aDest.Width       := aDest.Width - 28;
{$ENDIF}
  aDest.HelpContext := aSrc.HelpContext;
  FreeAndNil(aSrc);
end;

procedure CloneSynEdit(aDest: TSynEdit; aSrc: TMemo);
begin
  if (aSrc = nil) or (aDest = nil) then Exit;
  aDest.Name        := Copy(aSrc.Name, 1, Length(aSrc.Name)-1);
  aDest.Parent      := aSrc.Parent;
  aDest.Left        := aSrc.Left;
  aDest.Top         := aSrc.Top;
  aDest.Width       := aSrc.Width;
  aDest.Height      := aSrc.Height;
  aDest.Align       := aSrc.Align;
  aDest.HelpContext := aSrc.HelpContext;
  aDest.TabOrder    := aSrc.TabOrder;
  aDest.TabStop     := aSrc.TabStop;
  aDest.Cursor      := aSrc.Cursor;
  aDest.OnDblClick  := aSrc.OnDblClick;
  aDest.OnChange    := aSrc.OnChange;
  aDest.ParentFont  := aSrc.ParentFont;
  aDest.ReadOnly    := aSrc.ReadOnly;
  aDest.Font.Assign(aSrc.Font);
{$IFNDEF FPC}
  aDest.ParentColor := aSrc.ParentColor;
  aDest.ScrollHintFormat := shfTopToBottom;
{$ENDIF}
  FreeAndNil(aSrc);
end;

procedure CloneHotKey(aDest: TBricxCCHotKey; aSrc: TEdit);
begin
  if (aSrc = nil) or (aDest = nil) then Exit;
  aDest.Name        := Copy(aSrc.Name, 1, Length(aSrc.Name)-1);
  aDest.Parent      := aSrc.Parent;
  aDest.Left        := aSrc.Left;
  aDest.Top         := aSrc.Top;
  aDest.Width       := aSrc.Width;
  aDest.Height      := aSrc.Height;
  aDest.HelpContext := aSrc.HelpContext;
  aDest.TabOrder    := aSrc.TabOrder;
  aDest.Text        := aSrc.Text;
  aDest.HotKey      := 0;
{$IFNDEF FPC}
  aDest.InvalidKeys := [hcNone, hcShift];
{$ENDIF}
  FreeAndNil(aSrc);
end;

procedure SetWindowFocus(WC : TWinControl);
begin
{$IFDEF FPC}
  // not sure what to do here
{$ELSE}
  Windows.SetFocus(WC.Handle);
{$ENDIF}
end;

function GetTick : Cardinal;
begin
{$IFDEF FPC}
  Result := GetTickCount;
{$ELSE}
  Result := GetTickCount;
{$ENDIF}
end;

function GetWindowTitleBarHeight : integer;
begin
{$IFDEF FPC}
  Result := 16;
{$ELSE}
  Result := GetSystemMetrics(SM_CYCAPTION);
{$ENDIF}
end;

procedure AddMenuItems(m : TMenuItem; a : array of TMenuItem);
{$IFDEF FPC}
var
  i : integer;
begin
  for i := Low(a) to High(a) do
    m.Add(a[i]);
{$ELSE}
begin
  m.Add(a);
{$ENDIF}
end;

procedure CenterForm(const Form: TCustomForm);
var
  Rect: TRect;
begin
  if Form = nil then
    Exit;
{$IFNDEF FPC}
  SystemParametersInfo(SPI_GETWORKAREA, 0, @Rect, 0);

  with Form do
  begin
    SetBounds((Rect.Right - Rect.Left - Width) div 2,
      (Rect.Bottom - Rect.Top - Height) div 2, Width, Height);
  end;
{$ENDIF}
end;

procedure EnsureFormVisible(const Form: TCustomForm);
var
  Rect: TRect;
begin
  Rect.Top := 0;
  Rect.Left := 0;
  Rect.Right := Screen.Width;
  Rect.Bottom := Screen.Height;
{$IFNDEF FPC}
  SystemParametersInfo(SPI_GETWORKAREA, 0, @Rect, 0);
  if (Form.Left + Form.Width > Rect.Right) then
    Form.Left := Form.Left - ((Form.Left + Form.Width) - Rect.Right);
  if (Form.Top + Form.Height > Rect.Bottom) then
    Form.Top := Form.Top - ((Form.Top + Form.Height) - Rect.Bottom);
  if Form.Left < 0 then
    Form.Left := 0;
  if Form.Top < 0 then
    Form.Top := 0;
{$ENDIF}
end;

end.
