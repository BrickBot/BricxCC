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
 * The Initial Developer of this code is Andreas Dreier.
 *
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit ev3RGFedit_Basis;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  ExtCtrls, Types, Graphics;

const
  ZOOM = 4;

  RGFWidth  = 178;
  RGFHeight = 128;

  EDT_BASE_WIDTH  = 980;
  EDT_BASE_HEIGHT = 628;

  IMG_BASE_WIDTH  = 713; // image width is RGFWidth*ScaleFactor
  IMG_BASE_HEIGHT = 513; // image height is RGFHeight*ScaleFactor

  ORIGIN_X = 240;
  ORIGIN_Y = 24;

  BASE_DELTA_X = 40; // label delta is 10* scale factor
  BASE_DELTA_Y = 40;

  MAX_UNDO  = 100;

  CL_BACKGROUND = clWhite;
  CL_FRONT      = clBlack;
  CL_RASTER_1   = clLtGray;
  CL_RASTER_10  = clGray;
  CL_MARKED     = clRed;

var
  ScaleFactor : integer = ZOOM;

function LoadImage(filename : string; image : TImage;
                   var width, height : Integer;
                   cl_front, cl_back  : TColor ) : Boolean;

function SaveImage( image : TImage; area : TRect;
                    cl_front, cl_back  : TColor; filename : String ) : Boolean;

function SaveImageAddBorder( image : TImage; area, addborder : TRect;
                             fill_dark : Boolean;
                             cl_front, cl_back   : TColor;
                             filename  : string ) : Boolean;


procedure FindBorders( image : TImage; cl_front, cl_back : TColor;
                       var border : TRect );

function LoadRICImage(filename : string; image : TImage;
                      var width, height : Integer;
                      cl_front, cl_back  : TColor ) : Boolean;

function LoadRGFImage(filename : string; image : TImage;
                      var width, height : Integer;
                      cl_front, cl_back  : TColor ) : Boolean;

procedure ImageClear( image : TImage );

var
  base_path : string;

implementation

uses
  Classes, SysUtils;

type
  TBytes = array of Byte;

function GetBitValue(bSet : boolean; bitPos : byte) : byte;
const
   bit_values : array[0..7] of byte = (1, 2, 4, 8, 16, 32, 64, 128);
begin
  result := 0;
  if bSet then
    result := bit_values[bitPos];
end;

function GetEV3Bits(aX0, aY0, aWidth, aHeight : integer; ev3Image : TImage;
  cl_front : TColor) : TBits;
var
  x, y, i : integer;
  bit : boolean;
begin
  result := TBits.Create;
  result.Size := aWidth*aHeight;
  i := 0;
  for y := aY0 to aY0 + (aHeight - 1) do
  begin
    for x := aX0 to aX0 + (aWidth - 1) do
    begin
      bit := False;
      if ev3Image.Canvas.Pixels[x, y] = cl_front then
        bit := True;
      result.Bits[i] := bit;
      Inc(i);
    end;
  end;
end;

procedure SavePixelsToFile(w, h : byte; bits : TBits; filename : string);
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

procedure DLcdDrawBitmap(X0, Y0, scr_width, scr_height : integer;
                         bytes : TBytes; bits : TBits;
                         var rgf_width, rgf_height : integer);
var
  b : byte;
  i,
  row_pixel, col_pixel, num_col_pixel,
  row_byte, col_byte, num_col_byte : integer;
const
  SkipHeader = 2;
begin
  if Length(bytes) > 0 then
  begin
    rgf_width  := bytes[0]; // RGF width
    rgf_height := bytes[1]; // RGF height
    num_col_pixel := X0 + rgf_width;
    if (rgf_width >= 0) and (rgf_height >= 0) then
    begin
      row_pixel := Y0;
      num_col_byte := ((rgf_width + 7) shr 3 shl 3) div 8;
      for row_byte := 0 to rgf_height - 1 do
      begin
        col_pixel := X0;
        for col_byte := 0 to (num_col_byte - 1) do
        begin
          b := bytes[SkipHeader + (row_byte * num_col_byte) + col_byte];
          for i := 0 to 7 do
          begin
            if ((b and $01) <> 0) then
            begin
              if (col_pixel >= 0) and (col_pixel < scr_width) and
                 (row_pixel >= 0) and (row_pixel < scr_height) then
              begin
                bits[col_pixel + row_pixel * rgf_width] := true;
              end;
            end;
            b := Byte(b shr 1);
            Inc(col_pixel);
            if col_pixel >= num_col_pixel then break;
          end;
        end;
        Inc(row_pixel);
      end;
    end;
  end;
end;

procedure DrawScreenToWriteableBitmap(bits : TBits; bmp : TBitmap;
  colored : boolean; cl_front, cl_back : TColor);
var
  i, num : integer;
  color : TColor;
begin
  if colored then
    num := $DDDDDD // light grey
  else
    num := $FFFFFF; // black;
  for i := 0 to bmp.Width*bmp.Height - 1 do
  begin
    if bits[i] then
      color := $000000 // white
    else
      color := num; // black or light grey
    bmp.Canvas.Pixels[i mod bmp.Width, i div bmp.Width] := color;
  end;
end;

procedure DrawImage(rgfBytes : TBytes; imgScreen : TImage;
  cl_front, cl_back : TColor);
var
  bmp : TBitmap;
  w, h : integer;
  fBits : TBits;
begin
  fBits := TBits.Create;
  try
    w := rgfBytes[0];
    h := rgfBytes[1];
    fBits.Size := w*h;

    bmp := TBitmap.Create;
    try
      bmp.Width  := w;
      bmp.Height := h;

      DLcdDrawBitmap(0, 0, w, h, rgfBytes, fBits, w, h);
      DrawScreenToWriteableBitmap(fBits, bmp, false, cl_front, cl_back);
      imgScreen.Canvas.Draw(0, 0, bmp);
    finally
      bmp.Free;
    end;
  finally
    fBits.Free;
  end;
end;

function GetPixelColor(b: byte; bit: integer; cl_front, cl_back : TColor): TColor;
var
  val : byte;
begin
  Result := cl_back;
  val := 1 shl bit;
  if (b and val) = val then
    Result := cl_front;
end;

function LoadImage(filename : string; image : TImage;
                   var width, height : Integer;
                   cl_front, cl_back : TColor):Boolean;
begin
  if UpperCase(ExtractFileExt(filename)) = '.RIC' then
  begin
    Result := LoadRICImage(filename, image, width, height, cl_front, cl_back);
  end
  else
  begin
    Result := LoadRGFImage(filename, image, width, height, cl_front, cl_back);
  end;
end;

//------------------------------------------------------------------------------

function SaveImage( image : TImage; area : TRect;
                    cl_front, cl_back : TColor; filename : string ) : Boolean;
var
  x0, y0, w, h : integer;
begin
  w  := image.Width;
  h  := image.Height;
  x0 := area.Left;
  y0 := area.Top;
  SavePixelsToFile(w, h, GetEV3Bits(x0, y0, w, h, image, cl_front), filename);
  Result := FileExists(filename);
end;

//------------------------------------------------------------------------------

function SaveImageAddBorder( image : TImage; area, addborder : TRect;
                             fill_dark : Boolean;
                             cl_front, cl_back : TColor;
                             filename  : string ) : Boolean;
var
  tmp_image : TImage;
  cp_width  : Integer;
  cp_height : Integer;
begin
  tmp_image := TImage.Create( nil );
  try
    cp_width  := area.Right-area.Left+1;
    cp_height := area.Bottom-area.Top+1;

    tmp_image.Width  := cp_width  + addborder.Right  + addborder.Left;
    tmp_image.Height := cp_height + addborder.Bottom + addborder.Top;

    with tmp_image.Canvas do
    begin
      If fill_dark then
      begin
        Brush.Color := cl_Front;
        Pen.Color   := cl_Front;
      end
      else
      begin
        Brush.Color := cl_back;
        Pen.Color   := cl_back;
      end;

      FillRect( Rect( 0,0,tmp_image.Width,tmp_image.Height ) );

      CopyRect( Rect( addborder.Left,          addborder.Top,
                      addborder.Left+cp_width, addborder.Top+cp_height ),
                image.Canvas,
                Rect( area.left,area.top, area.right+1,area.bottom+1 ) );

      Result := SaveImage( tmp_image,
                           Rect( 0,0,tmp_image.Width, tmp_image.Height ),
                           cl_front,
                           cl_back,
                           filename );
    end;
  finally
    tmp_image.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure FindBorders(     image    : TImage;
                           cl_front : TColor;
                           cl_back  : TColor;
                       var border   : TRect );

var  h             : Integer;
     w             : Integer;
     x             : Integer;
     y             : Integer;
     empty         : Boolean;
     border_left   : Integer;
     border_right  : Integer;
     border_top    : Integer;
     border_bottom : Integer;


     function BitSum( x1,y1,x2,y2:Integer ):Boolean;
     var  x : Integer;
          y : Integer;
          b : Boolean;
     begin
          b := False;

          for x := x1 to x2 do
              for y := y1 to y2 do
                  b := b or ( image.Canvas.Pixels[ x,y ] = cl_front );

          Result := b;
     end;


begin
   h := Image.Height-1;
   w := Image.Width-1;

   //--- Special condition: Complete picture is empty ...
   If BitSum( 0,0,w,h ) = FALSE
      Then Begin
                border_left   :=  0;
                border_right  := -1;
                border_top    :=  0;
                border_bottom := -1;
           End
      Else Begin
                //--- Find left border
                empty        := TRUE;
                border_left  := 0;
                For x := 0 To w Do
                    If empty
                       Then If BitSum( x,0,x,h) = TRUE
                               Then Begin
                                         border_left   := x;
                                         empty         := FALSE
                                    End;

                //--- Find right border
                empty         := TRUE;
                border_right  := w;
                For x := w DownTo 0 Do
                    If empty
                       Then If BitSum( x,0,x,h ) = TRUE
                               Then Begin
                                         border_right  := x;
                                         empty         := FALSE
                                    End;

                //--- Find upper border
                empty         := TRUE;
                border_top    := 0;
                For y := 0 To h Do
                    If empty
                       Then If BitSum( 0,y,w,y ) = TRUE
                               Then Begin
                                         border_top    := y;
                                         empty         := FALSE
                                    End;

                //--- Find bottom border
                empty         := TRUE;
                border_bottom := h;
                For y := h DownTo 0 Do
                    If empty
                       Then If BitSum( 0,y,w,y ) = TRUE
                               Then Begin
                                         border_bottom := y;
                                         empty         := FALSE
                                    End
           End;

   border := Rect( border_left, border_top, border_right, border_bottom );
end;

function LoadRICImage(filename : string; image : TImage;
                      var width, height : Integer;
                      cl_front, cl_back  : TColor ) : Boolean;
var
  ms : TMemoryStream;
  bpLine, line, byte_of_line : Integer;
  byte_index, b, bit : Integer;
  cl : TColor;
  buffer : array of byte;
begin
  Result := False;
  if FileExists(filename) and (UpperCase(ExtractFileExt(filename)) = '.RIC') then
  begin
    ms := TMemoryStream.Create;
    try
      ms.LoadFromFile(filename);
      ms.Position := 0;
      SetLength(buffer, ms.Size);
      Move(ms.Memory^, buffer[0], ms.Size);
      width  := buffer[  7 ]*256 + buffer[  6 ];
      height := buffer[  9 ]*256 + buffer[  8 ];
      bpLine := buffer[ 19 ]*256 + buffer[ 18 ];

      byte_index := 20;
      for line := 0 to height-1 do
        for byte_of_line := 0 to bpLine-1 do
        begin
          b := buffer[ byte_index ];
          for bit := 0 to 7 do
          begin
            if ( b and $80 ) <> 0 then
              cl := cl_front
            eLse
              cl := cl_back;

            image.Canvas.Pixels[ 8*byte_of_line+bit, line ] := cl;

            b := b shl 1;
          end;

          Inc( byte_index );
        end;

      Result := True;
    finally
      ms.Free;
    end;
  end;
end;

function LoadRGFImage(filename : string; image : TImage;
                      var width, height : Integer;
                      cl_front, cl_back  : TColor ) : Boolean;
var
  ms : TMemoryStream;
  rgfBytes : TBytes;
begin
  Result := False;
  if FileExists(filename) and (UpperCase(ExtractFileExt(filename)) = '.RGF') then
  begin
    ms := TMemoryStream.Create;
    try
      ms.LoadFromFile(filename);
      SetLength(rgfBytes, Integer(ms.Size));
      ms.Position := 0;
      ms.Read(rgfBytes[0], Length(rgfBytes));
    finally
      ms.free;
    end;
    width  := rgfBytes[0];
    height := rgfBytes[1];
    DrawImage(rgfBytes, image, cl_front, cl_back);
    Result := True;
  end;
end;

procedure ImageClear( image : TImage );
begin
  with image.Canvas do
  begin
    Brush.Color := CL_BACKGROUND;
    Pen.Color   := CL_BACKGROUND;
  end;
  image.Canvas.FillRect( Rect( 0,0,image.Width+1,image.Height+1 ) );
end;

end.
