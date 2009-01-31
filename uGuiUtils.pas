unit uGuiUtils;

interface

uses
  uOfficeComp, StdCtrls;

procedure ConfigBar(ogp : TOfficeGradientPanel);
procedure SizeComboboxDropdown( cb: TCustomCombobox );

implementation

uses
  Themes, Graphics, Classes, Windows, Messages;

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


end.
