unit uImageImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, JPEG, Math, ExtDlgs;

type
  TfrmImageImport = class(TForm)
    lblPreview: TLabel;
    lblPreview2: TLabel;
    imgEV3: TImage;
    lblContrast: TLabel;
    bvlEV3: TBevel;
    btnSelect: TButton;
    btnSave: TButton;
    dlgSelect: TOpenPictureDialog;
    dlgSave: TSaveDialog;
    barBrightness: TTrackBar;
    chkStretch: TCheckBox;
    chkCenter: TCheckBox;
    chkProportional: TCheckBox;
    imgOriginal: TImage;
    Bevel1: TBevel;
    procedure barBrightnessChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure imgEV3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgEV3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgEV3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure chkCenterClick(Sender: TObject);
  private
    origX : integer;
    origY : integer;
    newX : integer;
    newY : integer;
    lastX : integer;
    lastY : integer;
    bSelecting : boolean;
    procedure ShowImage;
    procedure TranslateToEv3Picture;
    function GetEV3Bits : TBits;
    function GetWidth : byte;
    function GetHeight : byte;
    function GetX0 : byte;
    function GetY0 : byte;
    procedure ResetSelection;
  public
  end;

var
  frmImageImport: TfrmImageImport;

implementation

{$R *.dfm}

uses
  pngimage, GIFImage;

type
  TRGBColor = record
    red   : Byte;
    green : Byte;
    blue  : Byte;
  end;

  THSBColor = record
    Hue        : Double;
    Saturation : Double;
    Brightness : Double;
  end;

function RGB2HSB( rgb:TRGBColor ) : THSBColor;
var
  minRGB : Double;
  maxRGB : Double;
  delta  : Double;
  h      : Double;
  s      : Double;
  b      : Double;
begin
  h      := 0.0;
  minRGB := Min( Min( rgb.Red,rgb.Green ),rgb.Blue );
  maxRGB := Max( Max( rgb.Red,rgb.Green ),rgb.Blue );
  delta  := maxRGB - minRGB;
  b      := maxRGB ;

  if maxRGB <> 0.0 then
    s := 255.0 * delta / maxRGB
  else
    s := 0.0;

  if s <> 0.0 then
  begin
    if rgb.Red = maxRGB then
      h := (rgb.Green - rgb.Blue) / delta
    else if rgb.Green = minRGB then
      h := 2.0 + (rgb.Blue - rgb.Red) / delta
    else if rgb.Blue = maxRGB then
      h := 4.0 + (rgb.Red - rgb.Green) / delta
  end
  else
    h := -1.0;

  h := h * 60;
  if h < 0.0 then
    h := h + 360.0;

  with result do
  begin
    Hue        := h;
    Saturation := s * 100 / 255;
    Brightness := b * 100 / 255;
  end;
end;

function GetBitValue(bSet : boolean; bitPos : byte) : byte;
const
   bit_values : array[0..7] of byte = (1, 2, 4, 8, 16, 32, 64, 128);
//   bit_values : array[0..7] of byte = (128, 64, 32, 16, 8, 4, 2, 1);
begin
  result := 0;
  if bSet then
    result := bit_values[bitPos];
end;

procedure SavePixelsToRGF(w, h : byte; bits : TBits; filename : string);
var
  MS : TMemoryStream;
  row_pixel, col_pixel : integer;
  b, i : byte;
begin
  if Assigned(bits) then
  try
    MS := TMemoryStream.Create;
    try
      MS.Write(w, 1);
      MS.Write(h, 1);
      // write bits to stream
      // pad width to multiple of 8
      for row_pixel := 0 to h - 1 do
      begin
        i := 0;
        b := 0;
        for col_pixel := 0 to w - 1 do
        begin
          b := b + GetBitValue(bits[col_pixel + row_pixel * w], i);
          Inc(i);
          if i = 8 then
          begin
            MS.Write(b, 1);
            i := 0;
            b := 0;
          end;
        end;
        if i <> 0 then
        begin
          MS.Write(b, 1);
        end;
      end;
      MS.SaveToFile(filename);
    finally
      MS.Free;
    end;
  finally
    bits.Free;
  end;
end;

procedure TfrmImageImport.TranslateToEv3Picture;
var
  x, y, c : Integer;
  rgb : TRGBColor;
  hsb : THSBColor;
  tb, bx, by  : Integer;
Begin
(*
  img := TBitmap.Create;
  try
    pic := TPicture.Create;
    try
      pic.LoadFromFile(fname);
      w := pic.Graphic.Width;
      h := pic.Graphic.Height;
      img.Width  := w;
      img.Height := h;
      img.Canvas.Draw( 0,0, pic.Graphic );
    finally
      pic.Free;
    end;
    // now generate the pixel bytes for the NXT sprite
    nw := Min(width, w);
    nh := Min(height, h);
    op.Rows := nh;
    x := nw div 8;
    if (nw mod 8) <> 0 then
      inc(x);
    op.RowBytes := x;
    for y := 0 to nh-1 do begin
      row := '';
      for x := 0 to nw-1 do begin
        c := img.Canvas.Pixels[ x,y ];
        rgb.red   := Byte( ( c and $00FF0000 ) shr 16 );
        rgb.green := Byte( ( c and $0000FF00 ) shr  8 );
        rgb.blue  := Byte(   c and $000000FF          );
        hsb := RGB2HSB( rgb );
        if ( hsb.Brightness > threshold ) then
          row := row + '0'
        else
          row := row + '1';
      end;
      op.AddBytes(row);
    end;
  finally
    img.Free;
  end;
*)
     Application.ProcessMessages;
     tb := barBrightness.Position;

     bx := imgOriginal.Left;
     by := imgOriginal.Top;

     for x := 0 To imgOriginal.Width-1 do
     begin
         for y := 0 To imgOriginal.Height-1 do
         begin
             c := Canvas.Pixels[ bx+x,by+y ];

             rgb.red   := Byte( ( c and $00FF0000 ) shr 16 );
             rgb.green := Byte( ( c and $0000FF00 ) shr  8 );
             rgb.blue  := Byte(   c and $000000FF          );

             hsb := RGB2HSB( rgb );

             if ( hsb.Brightness > tb ) then
               imgEV3.Canvas.Pixels[ x,y ] := clWhite
             else
               imgEV3.Canvas.Pixels[ x,y ] := clBlack
         end;
     end;
     Application.ProcessMessages;
end;

procedure TfrmImageImport.ShowImage;
begin
  imgOriginal.Picture.LoadFromFile( dlgSelect.FileName );
  imgOriginal.Center := chkCenter.Checked;
  imgOriginal.Proportional := chkProportional.Checked;
  imgOriginal.Stretch := chkStretch.Checked;{ and
                         (( imgOriginal.Picture.Width  > imgOriginal.Width  ) or
                          ( imgOriginal.Picture.Height > imgOriginal.Height ));}
  TranslateToEv3Picture;
end;

procedure TfrmImageImport.barBrightnessChange(Sender: TObject);
begin
  TranslateToEv3Picture;
  btnSave.SetFocus;
end;

procedure TfrmImageImport.FormCreate(Sender: TObject);
begin
  ResetSelection;

  with imgOriginal, imgOriginal.Canvas do
  begin
    Brush.Color := clWhite;
    Pen.Color   := clWhite;
    FillRect( Rect( 0,0, Width, Height ) );
  end;

  with imgEV3, imgEV3.Canvas do
  begin
    Brush.Color := clWhite;
    Pen.Color   := clWhite;
    FillRect( Rect( 0,0, Width, Height ) )
  end;
end;

procedure TfrmImageImport.btnSelectClick(Sender: TObject);
begin
  ResetSelection;
  if dlgSelect.Execute then
  begin
    ShowImage;
    btnSave.Enabled := True;
  end;
end;

procedure TfrmImageImport.btnSaveClick(Sender: TObject);
begin
  ResetSelection;
  if dlgSave.Execute then
  begin
    SavePixelsToRGF(GetWidth, GetHeight, GetEV3Bits, dlgSave.FileName);
  end;
end;

function TfrmImageImport.GetEV3Bits: TBits;
var
  x, y, i : integer;
  bit : boolean;
begin
  result := TBits.Create;
  result.Size := GetWidth*GetHeight;
  i := 0;
  for y := GetY0 to GetY0 + (GetHeight - 1) do
  begin
    for x := GetX0 to GetX0 + (GetWidth - 1) do
    begin
      bit := False;
      if imgEV3.Canvas.Pixels[x, y] = clBlack then
        bit := True;
      result.Bits[i] := bit;
      Inc(i);
    end;
  end;
end;

procedure TfrmImageImport.imgEV3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // clear previous selection rect, if any
  if (lastX <> -1) and (lastY <> -1) and (origX <> -1) and (origY <> -1) then
    imgEV3.Canvas.DrawFocusRect(Rect(origX, origY, lastX, lastY));

  origX := X;
  newX  := X;
  origY := Y;
  newY  := Y;
  lastX := -1;
  lastY := -1;
  bSelecting := True;
  imgEV3.Canvas.DrawFocusRect(Rect(origX, origY, newX, newY));
end;

procedure TfrmImageImport.imgEV3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  newX := -1;
  newY := -1;
  lastX := X;
  lastY := Y;
  bSelecting := False;
end;

procedure TfrmImageImport.imgEV3MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if bSelecting then
  begin
    // get rid of previous rectangle
    imgEV3.Canvas.DrawFocusRect(Rect(origX, origY, newX, newY));
    // draw new rectangle
    imgEV3.Canvas.DrawFocusRect(Rect(origX, origY, X, Y));
    // update newX and newY
    newX := X;
    newY := Y;
  end;
end;

function TfrmImageImport.GetHeight: byte;
begin
  Result := imgEV3.Height;
  if (origY <> -1) and (lastY <> -1) then
  begin
    Result := Abs(lastY-origY);
  end;
end;

function TfrmImageImport.GetWidth: byte;
begin
  Result := imgEV3.Width;
  if (origX <> -1) and (lastX <> -1) then
  begin
    Result := Abs(lastX-origX);
  end;
end;

function TfrmImageImport.GetX0: byte;
begin
  Result := 0;
  if origX <> -1 then
    Result := origX;
end;

function TfrmImageImport.GetY0: byte;
begin
  Result := 0;
  if origY <> -1 then
    Result := origY;
end;

procedure TfrmImageImport.ResetSelection;
begin
  if (lastX <> -1) and (lastY <> -1) and (origX <> -1) and (origY <> -1) then
    imgEV3.Canvas.DrawFocusRect(Rect(origX, origY, lastX, lastY));
  origX := -1;
  origY := -1;
  newX  := -1;
  newY  := -1;
  lastX := -1;
  lastY := -1;
  bSelecting := False;
end;

procedure TfrmImageImport.chkCenterClick(Sender: TObject);
begin
  ShowImage;
end;

end.
(*
	internal class DisplayScreen
	{
		private const int LightGrayBG = -2236963;
		private const int LightGreyGrid = -5592406;
		private const int Black = -16777216;
		private const int White = -1;
		private BitArray _imageBits;
		private int _screenWidth;
		private int _screenHeight;
		private static Dictionary<DisplayFont, DisplayAdornerFont> _fontInfo;
		internal DisplayScreen(int width, int height)
		{
			this._screenWidth = width;
			this._screenHeight = height;
			this._imageBits = new BitArray(this._screenWidth * this._screenHeight, false);
		}
		internal void DLcdPlotPoints(int X0, int Y0, int X1, int Y1)
		{
			this.DLcdDrawPixel(X0 + X1, Y0 + Y1);
			this.DLcdDrawPixel(X0 - X1, Y0 + Y1);
			this.DLcdDrawPixel(X0 + X1, Y0 - Y1);
			this.DLcdDrawPixel(X0 - X1, Y0 - Y1);
			this.DLcdDrawPixel(X0 + Y1, Y0 + X1);
			this.DLcdDrawPixel(X0 - Y1, Y0 + X1);
			this.DLcdDrawPixel(X0 + Y1, Y0 - X1);
			this.DLcdDrawPixel(X0 - Y1, Y0 - X1);
		}
		internal void DLcdDrawCircle(int X0, int Y0, int R)
		{
			int i = 0;
			int num = R;
			int num2 = 3 - 2 * R;
			while (i < num)
			{
				this.DLcdPlotPoints(X0, Y0, i, num);
				if (num2 < 0)
				{
					num2 = num2 + 4 * i + 6;
				}
				else
				{
					num2 = num2 + 4 * (i - num) + 10;
					num--;
				}
				i++;
			}
			this.DLcdPlotPoints(X0, Y0, i, num);
		}
		internal void DLcdPlotLines(int X0, int Y0, int X1, int Y1)
		{
			this.DLcdDrawLine(X0 - X1, Y0 + Y1, X0 + X1, Y0 + Y1);
			this.DLcdDrawLine(X0 - X1, Y0 - Y1, X0 + X1, Y0 - Y1);
			this.DLcdDrawLine(X0 - Y1, Y0 + X1, X0 + Y1, Y0 + X1);
			this.DLcdDrawLine(X0 - Y1, Y0 - X1, X0 + Y1, Y0 - X1);
		}
		internal void DLcdFillCircle(int X0, int Y0, int R)
		{
			int i = 0;
			int num = R;
			int num2 = 3 - 2 * R;
			while (i < num)
			{
				this.DLcdPlotLines(X0, Y0, i, num);
				if (num2 < 0)
				{
					num2 = num2 + 4 * i + 6;
				}
				else
				{
					num2 = num2 + 4 * (i - num) + 10;
					num--;
				}
				i++;
			}
			this.DLcdPlotLines(X0, Y0, i, num);
		}
		internal void DLcdDrawLine(int X0, int Y0, int X1, int Y1)
		{
			int num;
			int num2;
			if (X0 < X1)
			{
				num = X1 - X0;
				num2 = 1;
			}
			else
			{
				num = X0 - X1;
				num2 = -1;
			}
			int num3;
			int num4;
			if (Y0 < Y1)
			{
				num3 = Y1 - Y0;
				num4 = 1;
			}
			else
			{
				num3 = Y0 - Y1;
				num4 = -1;
			}
			int num5 = num - num3;
			this.DLcdDrawPixel(X0, Y0);
			while (X0 != X1 || Y0 != Y1)
			{
				int num6 = num5 << 1;
				if (num6 > -num3)
				{
					num5 -= num3;
					X0 += num2;
				}
				if (num6 < num)
				{
					num5 += num;
					Y0 += num4;
				}
				this.DLcdDrawPixel(X0, Y0);
			}
		}
		internal void DLcdRect(int X0, int Y0, int X1, int Y1)
		{
			X1--;
			Y1--;
			this.DLcdDrawLine(X0, Y0, X0 + X1, Y0);
			this.DLcdDrawLine(X0 + X1, Y0, X0 + X1, Y0 + Y1);
			this.DLcdDrawLine(X0 + X1, Y0 + Y1, X0, Y0 + Y1);
			this.DLcdDrawLine(X0, Y0 + Y1, X0, Y0);
		}
		internal void DLcdFillRect(int X0, int Y0, int X1, int Y1)
		{
			int num = X0;
			int num2 = X0 + X1;
			int num3 = Y0 + Y1;
			while (Y0 < num3)
			{
				for (X0 = num; X0 < num2; X0++)
				{
					this.DLcdDrawPixel(X0, Y0);
				}
				Y0++;
			}
		}
		private bool DLcdCheckPixel(int X0, int Y0)
		{
			bool result = false;
			if (X0 >= 0 && X0 < this._screenWidth && Y0 >= 0 && Y0 < this._screenHeight)
			{
				result = this._imageBits.get_Item(X0 + Y0 * this._screenWidth);
			}
			return result;
		}
		private void DLcdDrawChar(bool Color, int X0, int Y0, DisplayFont Font, int Char)
		{
			int fontWidth = DisplayScreen._fontInfo.get_Item(Font).FontWidth;
			int fontHeight = DisplayScreen._fontInfo.get_Item(Font).FontHeight;
			if (Char >= (int)DisplayScreen._fontInfo.get_Item(Font).FontFirst && Char <= (int)DisplayScreen._fontInfo.get_Item(Font).FontLast)
			{
				Char -= (int)DisplayScreen._fontInfo.get_Item(Font).FontFirst;
				int num = Char % DisplayScreen._fontInfo.get_Item(Font).FontHorz * ((fontWidth + 7) / 8);
				num += Char / DisplayScreen._fontInfo.get_Item(Font).FontHorz * ((fontWidth + 7) / 8) * fontHeight * DisplayScreen._fontInfo.get_Item(Font).FontHorz;
				int num2 = X0 + fontWidth;
				if (Color)
				{
					for (int i = 0; i < fontHeight; i++)
					{
						int num3 = X0;
						for (int j = 0; j < (fontWidth + 7) / 8; j++)
						{
							byte b = DisplayScreen._fontInfo.get_Item(Font).FontBits[num + j];
							int num4 = 0;
							while (num4 < 8 && num3 < num2)
							{
								if ((b & 1) == 0)
								{
									this.DLcdDrawPixel(num3, Y0);
								}
								b = (byte)(b >> 1);
								num3++;
								num4++;
							}
						}
						Y0++;
						num += (fontWidth + 7) / 8 * DisplayScreen._fontInfo.get_Item(Font).FontHorz;
					}
				}
				else
				{
					for (int i = 0; i < fontHeight; i++)
					{
						int num3 = X0;
						for (int j = 0; j < (fontWidth + 7) / 8; j++)
						{
							byte b = DisplayScreen._fontInfo.get_Item(Font).FontBits[num + j];
							int num4 = 0;
							while (num4 < 8 && num3 < num2)
							{
								if ((b & 1) != 0)
								{
									this.DLcdDrawPixel(num3, Y0);
								}
								b = (byte)(b >> 1);
								num3++;
								num4++;
							}
						}
						Y0++;
						num += (fontWidth + 7) / 8 * DisplayScreen._fontInfo.get_Item(Font).FontHorz;
					}
				}
			}
		}
		internal void DLcdDrawText(bool Color, int X0, int Y0, DisplayFont Font, string text)
		{
			char[] array = text.ToCharArray();
			for (int i = 0; i < array.Length; i++)
			{
				char @char = array[i];
				if (X0 < this._screenWidth - DisplayScreen._fontInfo.get_Item(Font).FontWidth)
				{
					this.DLcdDrawChar(Color, X0, Y0, Font, (int)@char);
					X0 += DisplayScreen._fontInfo.get_Item(Font).FontWidth;
				}
			}
		}
		static DisplayScreen()
		{
			// Note: this type is marked as 'beforefieldinit'.
			Dictionary<DisplayFont, DisplayAdornerFont> dictionary = new Dictionary<DisplayFont, DisplayAdornerFont>();
			dictionary.Add(DisplayFont.Normal, new NormalFont());
			dictionary.Add(DisplayFont.Small, new SmallFont());
			dictionary.Add(DisplayFont.Large, new LargeFont());
			dictionary.Add(DisplayFont.Tiny, new TinyFont());
			DisplayScreen._fontInfo = dictionary;
		}

*)

