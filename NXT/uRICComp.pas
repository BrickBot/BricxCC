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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uRICComp;

interface

uses
  Classes, uRICCompBase;

type
  TRICComp = class(TRICCompBase)
  protected
    procedure DoImportKeyword(op: TRICSprite); override;
  end;

implementation

uses
  SysUtils, Math, uCommonUtils, uLocalizedStrings, uCompTokens,
  {$IFNDEF FPC}
  Graphics, JPEG, pngimage, GIFImage
  {$ELSE}
  FPImage, FPCanvas,
  FPReadBMP, {FPReadGIF, }FPReadJpeg,
  FPReadPCX, FPReadPNG, FPReadPNM,
  FPReadTGA, {FPReadTiff, }FPReadXPM
  {$ENDIF};

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

{$IFNDEF FPC}
procedure ImportImage(op : TRICSprite; const fname : string;
  threshold, width, height : integer);
var
  pic : TPicture;
  img : TBitmap;
  w, h, nw, nh, x, y, c : Integer;
  rgb : TRGBColor;
  hsb : THSBColor;
  row : string;
begin
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
end;
{$ELSE}
procedure ImportImage(op : TRICSprite; const fname : string;
  threshold, width, height : integer);
var
  img : TFPMemoryImage;
  w, h, nw, nh, x, y : Integer;
  c : TFPColor;
  rgb : TRGBColor;
  hsb : THSBColor;
  row : string;
begin
  img := TFPMemoryImage.Create(0, 0);
  try
    img.LoadFromFile(fname);
    w := img.Width;
    h := img.Height;
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
        c := img.Colors[ x,y ];
        rgb.red   := c.red;
        rgb.green := c.green;
        rgb.blue  := c.blue;
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
end;
{$ENDIF}

procedure TRICComp.DoImportKeyword(op : TRICSprite);
var
  i : integer;
  bFileFound : boolean;
  fname, usePath : string;
  thresh, width, height : integer;
const
  DEF_SPRITE_IMPORT_THRESHOLD = 50;
  DEF_SPRITE_IMPORT_WIDTH     = 100;
  DEF_SPRITE_IMPORT_HEIGHT    = 64;
begin
  // support "import" keyword
  thresh := DEF_SPRITE_IMPORT_THRESHOLD;
  width  := DEF_SPRITE_IMPORT_WIDTH;
  height := DEF_SPRITE_IMPORT_HEIGHT;
  Next;
  OpenParen;
  CheckStringConst;
  fname := Value;
  Next;
  if Token = TOK_COMMA then begin
    MatchString(TOK_COMMA);
    // optional threshold value
    CheckNumeric;
    thresh := StrToIntDef(Value, thresh);
    Next;
    if Token = TOK_COMMA then begin
      MatchString(TOK_COMMA);
      // optional width & height
      CheckNumeric;
      width := StrToIntDef(Value, width);
      Next;
      MatchString(TOK_COMMA);
      CheckNumeric;
      height := StrToIntDef(Value, height);
      Next;
    end;
  end;
  CloseParen;
  CloseParen;
  // build sprite bytes using fname and thresh
  // find sprite file
  fName := StripQuotes(fName);
  usePath := '';
  bFileFound := FileExists(fname);
  if not bFileFound then
  begin
    for i := 0 to IncludeDirs.Count - 1 do
    begin
      usePath := IncludeTrailingPathDelimiter(IncludeDirs[i]);
      bFileFound := FileExists(usePath+fname);
      if bFileFound then Break;
    end;
  end;
  if bFileFound then
  begin
    ImportImage(op, usePath+fname, thresh, width, height);
  end
  else
    AbortMsg(Format(sUnableToFindImage, [fname]));
end;

end.