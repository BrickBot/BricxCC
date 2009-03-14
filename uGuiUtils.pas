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
  Controls, StdCtrls, DirectoryEdit, uNewHotKey, uOfficeComp, SynEdit;

procedure ConfigBar(ogp : TOfficeGradientPanel);
procedure SizeComboboxDropdown( cb: TCustomCombobox );
procedure CloneDE(aDest : TDirectoryEdit; aSrc : TEdit);
procedure CloneSynEdit(aDest : TSynEdit; aSrc : TMemo);
procedure CloneHotKey(aDest : TBricxCCHotKey; aSrc : TEdit);
procedure SetWindowFocus(WC : TWinControl);

implementation

uses
  Themes, Graphics, Classes, Windows, Messages, SysUtils, ComCtrls;

procedure ConfigBar(ogp : TOfficeGradientPanel);
begin
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
end;

function CalcMaxWidthOfStrings( aList: TStrings; aFont: TFont ): integer;
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
end;

procedure SizeComboboxDropdown( cb: TCustomCombobox );
var
  max: Integer;
begin
  max:= CalcMaxWidthOfStrings( cb.Items, TCombobox(cb).Font );
  if max > cb.Width Then
    cb.Perform( CB_SETDROPPEDWIDTH, max+6, 0 );
end;

procedure CloneDE(aDest: TDirectoryEdit; aSrc: TEdit);
begin
  aDest.Name        := Copy(aSrc.Name, 1, Length(aSrc.Name)-1);
  aDest.Parent      := aSrc.Parent;
  aDest.Left        := aSrc.Left;
  aDest.Top         := aSrc.Top;
  aDest.Width       := aSrc.Width;
  aDest.Height      := aSrc.Height;
  aDest.AutoSize    := aSrc.AutoSize;
  aDest.TabOrder    := aSrc.TabOrder;
  aDest.SetHint     := False;
  aDest.HelpContext := aSrc.HelpContext;
  FreeAndNil(aSrc);
end;

procedure CloneSynEdit(aDest: TSynEdit; aSrc: TMemo);
begin
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
  aDest.ParentColor := aSrc.ParentColor;
  aDest.ParentFont  := aSrc.ParentFont;
  aDest.ReadOnly    := aSrc.ReadOnly;
  aDest.Font.Assign(aSrc.Font);
  aDest.ScrollHintFormat := shfTopToBottom;
  FreeAndNil(aSrc);
end;

procedure CloneHotKey(aDest: TBricxCCHotKey; aSrc: TEdit);
begin
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
  aDest.InvalidKeys := [hcNone, hcShift];
  FreeAndNil(aSrc);
end;

procedure SetWindowFocus(WC : TWinControl);
begin
{$IFDEF FPC}
  Result := 0;
{$ELSE}
  Windows.SetFocus(WC.Handle);
{$ENDIF}
end;

end.
