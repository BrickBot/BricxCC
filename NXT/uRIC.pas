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
unit uRIC;

interface

const
  IMG_DESCRIPTION_ID = 0; // Ignored at this time
  IMG_SPRITE_ID      = 1;
  IMG_VARMAP_ID      = 2;
  IMG_COPYBITS_ID    = 3;
  IMG_PIXEL_ID       = 4;
  IMG_LINE_ID        = 5;
  IMG_RECTANGLE_ID   = 6;
  IMG_CIRCLE_ID      = 7;
  IMG_NUMBOX_ID      = 8;
  IMG_ELLIPSE_ID     = 9;
  IMG_POLYGON_ID     = 10;

const
  USEARGS_MASK = $1000;

function IMG_SYMB_USEARGS(v : cardinal) : cardinal;
function IMG_SYMB_MAP(v : cardinal) : cardinal;
function IMG_SYMB_ARG(v : cardinal) : cardinal;

const
  DRAW_OPT_CLEAR_WHOLE_SCREEN = $0001;
  DRAW_OPT_CLEAR_EXCEPT_STATUS_SCREEN = $0002;

function DRAW_OPT_CLEAR_MODE(v : cardinal) : cardinal;

const
  DO_NOT_CLEAR  = 0;
  CLEAR_B4_DRAW = 1;
  RESTORE_NXT_SCREEN = 0;
  DISPLAY_HEIGHT = 64;
  DISPLAY_WIDTH  = 100;
  DISPLAY_REALWIDTH = DISPLAY_WIDTH;

function TRANSLATE_Y(y : integer) : integer;

type
  IMG_PT = record
    X : SmallInt;
    Y : SmallInt;
  end;
  PIMG_PT = ^IMG_PT;

  IMG_RECT = record
    Pt : IMG_PT;
    Width : SmallInt;
    Height : SmallInt;
  end;
  PIMG_RECT = ^IMG_RECT;

  IMG_OP_CORE = record
    OpSize : Word;
    OpCode : Word;
  end;
  PIMG_OP_CORE = ^IMG_OP_CORE;

  IMG_OP_DESCRIPTION = record
    OpSize : Word;
    OpCode : Word;
    Options : Word;
    Width : Word;
    Height : Word;
  end;
  PIMG_OP_DESCRIPTION = ^IMG_OP_DESCRIPTION;

  IMG_OP_SPRITE = record
    OpSize : Word;
    OpCode : Word;
    DataAddr : Word; //Address sprite handle will be stored in.
    Rows : Word;     //Second dimension of the array below.
    RowBytes : Word; //The actual size of the following array. Must be even.
    Bytes : array[0..1] of Byte; // Minimum of two for alignment purposes
  end;
  PIMG_OP_SPRITE = ^IMG_OP_SPRITE;

  IOV_MAPELT = record
    Domain : Word;
    Range : Word;
  end;
  PIOV_MAPELT = ^IOV_MAPELT;

  IMG_OP_VARMAP = record
    OpSize : Word;
    OpCode : Word;
    DataAddr : Word; //Address sprite handle will be stored in.
    MapCount : Word; //The actual size of the following array. Must be even.
    MapElt : array[0..1] of IOV_MAPELT; //Minimum of two for alignment purposes
  end;
  PIMG_OP_VARMAP = ^IMG_OP_VARMAP;

  IMG_OP_COPYBITS = record
    OpSize : Word;
    OpCode : Word;
    CopyOptions : Word; // Copy, CopyNot, Or, BitClear, And, Xor;
    DataAddr : Word; // Address of an already defined sprite
    Src : IMG_RECT; // Source rectangle
    Dst : IMG_PT; // Destination left top
  end;
  PIMG_OP_COPYBITS = ^IMG_OP_COPYBITS;

  IMG_OP_PIXEL = record
    OpSize : Word;
    OpCode : Word;
    CopyOptions : Word;
    Pt : IMG_PT;
    Value : Word; // typically mapped to an argument
  end;
  PIMG_OP_PIXEL = ^IMG_OP_PIXEL;

  IMG_OP_LINE = record
    OpSize : Word;
    OpCode : Word;
    CopyOptions : Word;
    Pt1 : IMG_PT;
    Pt2 : IMG_PT;
  end;
  PIMG_OP_LINE = ^IMG_OP_LINE;

  IMG_OP_RECT = record
    OpSize : Word;
    OpCode : Word;
    CopyOptions : Word;
    Pt : IMG_PT;
    Width : SmallInt;
    Height : SmallInt;
  end;
  PIMG_OP_RECT = ^IMG_OP_RECT;

  IMG_OP_CIRCLE = record
    OpSize : Word;
    OpCode : Word;
    CopyOptions : Word;
    Pt : IMG_PT;
    Radius : Word;
  end;
  PIMG_OP_CIRCLE = ^IMG_OP_CIRCLE;

  IMG_OP_NUMBOX = record
    OpSize : Word;
    OpCode : Word;
    CopyOptions : Word;
    Pt : IMG_PT;
    Value : Word; // typically mapped to an argument
  end;
  PIMG_OP_NUMBOX = ^IMG_OP_NUMBOX;

  IMG_OP_ELLIPSE = record
    OpSize : Word;
    OpCode : Word;
    CopyOptions : Word;
    Pt : IMG_PT;
    Radius1 : Word;
    Radius2 : Word;
  end;
  PIMG_OP_ELLIPSE = ^IMG_OP_ELLIPSE;

  IMG_OP_POLYGON = record
    OpSize : Word;
    OpCode : Word;
    CopyOptions : Word;
    Count : Word;
    Points : array[0..2] of IMG_PT; // at least 3 points per polygon
  end;
  PIMG_OP_POLYGON = ^IMG_OP_POLYGON;

  FONT_REC = record
    FormatMsb : Byte;
    FormatLsb : Byte;
    DataBytesMsb : Byte;
    DataBytesLsb : Byte;
    ItemsX : Byte;
    ItemsY : Byte;
    ItemsPixelsX : Byte;
    ItemsPixelsY : Byte;
    Data : array[0..1] of Byte;
  end;
  P_FONT = ^FONT_REC;

  TOpTypes = (otCore, otDescr, otSprite, otVarmap, otCopyBits, otPixel,
    otLine, otRect, otCircle, otNumBox, otEllipse, otPolygon);

  IMG_OP_UNION = record
    case TOpTypes of
      otCore: (Core : IMG_OP_CORE);
      otDescr: (Desc : IMG_OP_DESCRIPTION);
      otSprite: (Sprite : IMG_OP_SPRITE);
      otVarmap: (VarMap : IMG_OP_VARMAP);
      otCopyBits: (CopyBits : IMG_OP_COPYBITS);
      otPixel: (Pixel : IMG_OP_PIXEL);
      otLine: (Line : IMG_OP_LINE);
      otRect: (Rect : IMG_OP_RECT);
      otCircle: (Circle : IMG_OP_CIRCLE);
      otNumBox: (NumBox : IMG_OP_NUMBOX);
      otEllipse: (Ellipse : IMG_OP_ELLIPSE);
      otPolygon: (Polygon : IMG_OP_POLYGON);
  end;
  PIMG_OP_UNION = ^IMG_OP_UNION;

const
  IMG_MAX_DATA = 11;

type
  TRICVariables = array[0..255] of Integer;

var
  gpImgData : array[0..IMG_MAX_DATA-1] of PIMG_OP_UNION;
  gpPassedImgVars : TRICVariables;
  gPassedVarsCount : SmallInt;

function cCmdWrapSetScreenMode(var Status : Integer; ScreenMode : Cardinal) : integer;
function cCmdWrapDrawPoint(var Status : Integer; Location : PIMG_PT;
  Options : Cardinal) : Integer;
function cCmdWrapDrawLine(var Status : Integer; StartLoc, EndLoc : PIMG_PT;
  Options : Cardinal) : Integer;
function cCmdWrapDrawCircle(var Status : Integer; StartLoc : PIMG_PT;
  Radius : Integer; Options : Cardinal) : Integer;
function cCmdWrapDrawRect(var Status : Integer; TopLeft, BotRight : PIMG_PT;
  Options : Cardinal) : Integer;
function cCmdWrapDrawPicture(var Status : Integer; TopLeft : PIMG_PT;
  Filename : string; Variables : TRICVariables; Options : Cardinal) : Integer;

procedure cCmdRestoreDefaultScreen;

implementation

uses
  Classes, Math, SysUtils, uNXTConstants;

procedure pMapDisplayUpdateMask(mask : cardinal);
begin
  case mask of
  SCREENBIT shl SCREEN_BACKGROUND :
    begin
    end;
  SCREENBIT shl SCREEN_LARGE :
    begin
    end;
  else
  end;
end;

procedure pMapDisplayPFunc(funcID, p1, p2, p3, p4, p5 : byte);
begin
  if (funcID =0) or
     (p1 = 0) or (p2 = 0) or (p3 = 0) or (p4 = 0) or (p5 = 0) then
  begin
  end;
end;


(*

void      cDisplayString(FONT *pFont,UBYTE X,UBYTE Y,UBYTE *pString)
{
  UBYTE   *pSource;
  UBYTE   *pDestination;
  UBYTE   FontWidth;
  UBYTE   Line;
  UBYTE   Items;
  UBYTE   Item;


  Line         = (Y & 0xF8) / 8;
  Items        = pFont->ItemsX * pFont->ItemsY;
  pDestination = (UBYTE* )&IOMapDisplay.Display[Line * DISPLAY_WIDTH + X];

  while ( *pString)
  {
    Item           = *pString - ' ';
    if (Item < Items)
    {
      FontWidth    = pFont->ItemPixelsX;
      pSource      = (UBYTE* )&pFont->Data[Item * FontWidth];
      while (FontWidth--)
      {
        *pDestination = *pSource;
        pDestination++;
        pSource++;
      }
    }
    pString++;
  }
}


void      cDisplayUpdateScreen(SCREEN_CORDINATE *pCord,BMPMAP *pBitmap)
{
  UBYTE   *pSource;
  UBYTE   *pDestination;
  UBYTE   Line;
  UBYTE   Lines;

  if (pBitmap)
  {
    if ((((pBitmap->StartY + pCord->StartY) & 0x07) == 0) && ((pBitmap->PixelsY & 0x07) == 0))
    {
      pSource = pBitmap->Data;
      Line    = (pBitmap->StartY + pCord->StartY) / 8;
      Lines   = Line + pBitmap->PixelsY / 8;
      while (Line < Lines)
      {
        pDestination = &IOMapDisplay.Display[Line * DISPLAY_WIDTH + pBitmap->StartX + pCord->StartX];
        memcpy(pDestination,pSource,(size_t)pBitmap->PixelsX);
        pSource += pBitmap->PixelsX;
        Line++;
      }
    }
  }
}


void      cDisplayCenterString(FONT *pFont,UBYTE *pString,UBYTE Line)
{
  UWORD   Chars;
  UBYTE   Column;

  if (pString)
  {
    Chars = 0;
    while (pString[Chars])
    {
      Chars++;
    }
    Column = (DISPLAY_WIDTH - Chars * pFont->ItemPixelsX) / 2;
    cDisplayString(pFont,Column,Line * 8,pString);
  }
}


void      cDisplayUpdateMenuIcon(UBYTE *pIcon,SCREEN_CORDINATE *pCord)
{
  UBYTE   *pDestination;
  UBYTE   Line;
  UBYTE   Column;
  UBYTE   Lines;
  UBYTE   Columns;

  if (((pCord->StartY & 0x07) == 0) && ((pCord->PixelsY & 0x07) == 0))
  {
    Line    = pCord->StartY / 8;
    Lines   = Line + pCord->PixelsY / 8;
    Columns = pCord->StartX + pCord->PixelsX;
    if (pIcon != NULL)
    {
      while (Line < Lines)
      {
        Column   = pCord->StartX;
        pDestination = &IOMapDisplay.Display[Line * DISPLAY_WIDTH + Column];

        while (Column < Columns)
        {
          *pDestination |= *pIcon;
          pIcon++;
          pDestination++;
          Column++;
        }
        Line++;
      }
    }
    else
    {
      while (Line < Lines)
      {
        pDestination = &IOMapDisplay.Display[Line * DISPLAY_WIDTH + pCord->StartX];
        memset(pDestination,0,(size_t)pCord->PixelsX);
        Line++;
      }
    }
  }
}


void      cDisplayUpdateIcon(ICON *pIcons,UBYTE Index,SCREEN_CORDINATE *pCord)
{
  UBYTE   *pSource;
  UBYTE   *pDestination;
  UBYTE   Line;
  UBYTE   Lines;

  if (pIcons)
  {
    if ((Index > 0) && (Index <= (pIcons->ItemsX * pIcons->ItemsY)))
    {
      Index--;
      if (((pCord->StartY & 0x07) == 0) && ((pCord->PixelsY & 0x07) == 0))
      {
        Line    = pCord->StartY / 8;
        Lines   = Line + pCord->PixelsY / 8;
        pSource = &pIcons->Data[((Index / pIcons->ItemsX) * pIcons->ItemsX * pIcons->ItemPixelsX * pIcons->ItemPixelsY / 8) + ((Index % pIcons->ItemsX) * pIcons->ItemPixelsX)];
        while (Line < Lines)
        {
          pDestination = &IOMapDisplay.Display[Line * DISPLAY_WIDTH + pCord->StartX];
          memcpy(pDestination,pSource,(size_t)pCord->PixelsX);
          pSource += (pIcons->ItemPixelsX * pIcons->ItemsX);
          Line++;
        }
      }
    }
    else
    {
      if (((pCord->StartY & 0x07) == 0) && ((pCord->PixelsY & 0x07) == 0))
      {
        Line    = pCord->StartY / 8;
        Lines   = Line + pCord->PixelsY / 8;
        while (Line < Lines)
        {
          pDestination = &IOMapDisplay.Display[Line * DISPLAY_WIDTH + pCord->StartX];
          memset(pDestination,0,(size_t)pCord->PixelsX);
          Line++;
        }
      }
    }
  }
}


void      cDisplayFrame(SCREEN_CORDINATE *pCord)
{
  cDisplayLineX(pCord->StartX,pCord->StartX + pCord->PixelsX - 1,pCord->StartY);
  cDisplayLineY(pCord->StartX,pCord->StartY,pCord->StartY + pCord->PixelsY - 1);
  cDisplayLineY(pCord->StartX + pCord->PixelsX - 1,pCord->StartY,pCord->StartY + pCord->PixelsY - 1);
}


void      cDisplayEraseScreen(SCREEN_CORDINATE *pCord)
{
  UBYTE   *pDestination;
  UBYTE   Line;
  UBYTE   Lines;

  if (((pCord->StartY & 0x07) == 0) && ((pCord->PixelsY & 0x07) == 0))
  {
    Line    = pCord->StartY / 8;
    Lines   = Line + pCord->PixelsY / 8;

    while (Line < Lines)
    {
      pDestination = &IOMapDisplay.Display[Line * DISPLAY_WIDTH + pCord->StartX];
      memset(pDestination,0,(size_t)pCord->PixelsX);
      Line++;
    }
  }
}

*)

const
  OP_CLR = 0;
  OP_SET = 1;
  OP_OR  = 2;
  OP_AND = 3;
  OP_XOR = 4;
  OP_NOT = 5;

procedure SetDisplayByte(addr : Word; op : Byte; val : Byte);
begin
  if (addr = 0) or (val = 0) then Exit;
  case op of
    OP_CLR : begin
    end;
    OP_SET : begin
    end;
    OP_OR : begin
    end;
    OP_AND : begin
    end;
    OP_XOR : begin
    end;
    OP_NOT : begin
    end;
  end;
end;

procedure cDisplayChar(pFont : P_FONT; bOn, X, Y, Ch : Byte);
begin
  if not Assigned(pFont) or (bOn = 0) or
     (X = 0) or (Y = 0) or (Ch = 0) then
    Exit;
(*
  UBYTE   *pSource;
  UBYTE   FontWidth;
  UBYTE   FontHeight;
  UBYTE   Items;
  UBYTE   Item;
  UBYTE   TmpY;


  Items          := pFont^.ItemsX * pFont^.ItemsY;
  Item           := Ch - Ord(' ');
  if (Item < Items) then
  begin
    FontWidth    := pFont^.ItemPixelsX;
    pSource      = (UBYTE* )&pFont->Data[Item * FontWidth];
    while (FontWidth--)
    begin
      TmpY       = 0;
      FontHeight = pFont->ItemPixelsY;
      while (FontHeight--)
      begin
        if (bOn = 1) then
        begin
          if ((( *pSource) & (1 << TmpY))) then
          begin
            cDisplaySetPixel(X,Y + TmpY);
          end
          else
          begin
            cDisplayClrPixel(X,Y + TmpY);
          end;
        end
        else
        begin
          if ((( *pSource) & (1 << TmpY))) then
          begin
            cDisplayClrPixel(X,Y + TmpY);
          end
          else
          begin
            cDisplaySetPixel(X,Y + TmpY);
          end;
        end;
        TmpY++;
      end;
      X++;
      pSource++;
    end;
  end;
*)
end;

procedure cDisplayLineX(X1, X2, Y : Byte);
var
  X, M : Byte;
begin
  M   := Byte(1 shl Byte((Y mod 8)));
  Y   := Byte(Y shr 3);
  for X := X1 to Byte(X2 - 1) do
  begin
    SetDisplayByte(Word(Y * DISPLAY_WIDTH + X), OP_OR, M);
//    IOMapDisplay.Display[Y * DISPLAY_WIDTH + X] |= M;
  end;
end;

procedure cDisplayLineY(X, Y1, Y2 : Byte);
var
  Y : Byte;
begin
  for Y := Y1 to Byte(Y2 - 1) do
  begin
    SetDisplayByte(Word((Y div 8) * DISPLAY_WIDTH + X), OP_OR, Byte(1 shl (Y mod 8)));
//    IOMapDisplay.Display[(Y / 8) * DISPLAY_WIDTH + X] |= (1 << (Y % 8));
  end;                                                
end;

procedure cDisplaySetPixel(X, Y : Byte);
begin
  if ((X < DISPLAY_WIDTH) and (Y < DISPLAY_HEIGHT)) then
  begin
    SetDisplayByte(Word((Y div 8) * DISPLAY_WIDTH + X), OP_OR, Byte(1 shl (Y mod 8)));
  end;
end;


procedure cDisplayClrPixel(X, Y : Byte);
begin
  if ((X < DISPLAY_WIDTH) and (Y < DISPLAY_HEIGHT)) then
  begin
    SetDisplayByte(Word((Y div 8) * DISPLAY_WIDTH + X), OP_AND, Byte(not (1 shl (Y mod 8))));
//    IOMapDisplay.Display[(Y div 8) * DISPLAY_WIDTH + X] &= ~(1 shl (Y % 8));
  end;
end;

procedure cDisplayEraseLine(Line : Byte);
var
  Tmp : Byte;
begin
  for Tmp := 0 to DISPLAY_WIDTH - 1 do
    SetDisplayByte(Word(Line * DISPLAY_WIDTH + Tmp), OP_SET, $00);
end;

procedure cDisplayErase;
var
  Tmp : Byte;
begin
  for Tmp := 0 to (DISPLAY_HEIGHT div 8) - 1 do
    cDisplayEraseLine(Tmp);
end;

procedure cDisplayDraw(Cmd, bOn, X1, Y1, X2, Y2 : Byte);
var
  IOMapDisplayPFont : P_FONT;
begin
  IOMapDisplayPFont := nil;
  case Cmd of
    DISPLAY_ERASE_ALL :
    begin
      cDisplayErase();
    end;
    DISPLAY_PIXEL :
    begin
      if bOn = 1 then
      begin
        cDisplaySetPixel(X1,Y1);
      end
      else
      begin
        cDisplayClrPixel(X1,Y1);
      end;
    end;
    DISPLAY_HORIZONTAL_LINE :
    begin
      if bOn = 1 then
      begin
        if (X1 > X2) then
        begin
          cDisplayLineX(X2,X1,Y1);
        end
        else
        begin
          cDisplayLineX(X1,X2,Y1);
        end;
      end;
    end;
    DISPLAY_VERTICAL_LINE :
    begin
      if bOn = 1 then
      begin
        if (Y1 > Y2) then
        begin
          cDisplayLineY(X1,Y2,Y1);
        end
        else
        begin
          cDisplayLineY(X1,Y1,Y2);
        end;
      end;
    end;
    DISPLAY_CHAR :
    begin
      cDisplayChar(IOMapDisplayPFont,bOn,X1,Y1,X2);
    end;
  end;
end;


procedure cCmdSetPixel(x, y, Val : Integer);
begin
  y := TRANSLATE_Y(y);
  // draw the pixel
  pMapDisplayPFunc(DISPLAY_PIXEL, Byte(Val), Byte(x), Byte(y), 0, 0);
end;

procedure cCmdDrawLine(x1, y1, x2, y2 : Integer);
var
  d, x, y, ax, ay, sx, sy, dx, dy : integer;
begin
  dx := x2-x1;
  ax := Abs(dx) shl 1;
  sx := Sign(dx);
  dy := y2-y1;
  ay := Abs(dy) shl 1;
  sy := Sign(dy);
  x := x1;
  y := y1;
  if ax > ay then begin  // x dominant
    d := ay - (ay shr 1);
    while true do begin
      cCmdSetPixel(x, y, 1);
      if x = x2 then
        Exit;
      if d >= 0 then begin
        inc(y, sy);
        dec(d, ax);
      end;
      inc(x, sx);
      inc(d, ay);
    end;
  end
  else begin // y dominant
    d := ax - (ay shr 1);
    while true do begin
      cCmdSetPixel(x, y, 1);
      if (y = y2) then
        Exit;
      if d >= 0 then begin
        inc(x, sx);
        dec(d, ay);
      end;
      inc(y, sy);
      inc(d, ax);
    end;
  end;
end;

procedure cCmdDrawRect(left, bottom, width, height : integer);
var
  right, top : integer;
begin
  right := left + width;
  top   := bottom + height;
  // Draw the four line segments
  cCmdDrawLine(left, top, right, top);
  cCmdDrawLine(right, top, right, bottom);
  cCmdDrawLine(right, bottom, left, bottom);
  cCmdDrawLine(left, bottom, left, top);
end;

procedure cCmdDrawCircle(cx, cy, radius : integer);
var
  x, x1, y, y1, dp, delta : integer;
begin
  x1 := cx;
  y1 := cy;
  x := 0;
  y := radius;
  dp := 2 * (1-radius);
  while y >= 0 do
  begin
    cCmdSetPixel(x+x1, y+y1, 1);
    cCmdSetPixel(-x+x1, -y+y1, 1);
    cCmdSetPixel(x+x1, -y+y1, 1);
    cCmdSetPixel(-x+x1, y+y1, 1);
    if dp < 0 then
    begin
      delta := 2*dp + 2*y - 1;
      if delta > 0 then
      begin
        inc(x);
        dec(y);
        inc(dp, 2*x - 2*y + 2);
      end
      else
      begin
        inc(x);
        inc(dp, 2*x + 1);
      end;
    end
    else if dp > 0 then
    begin
      delta := 2*dp - 2*x - 1;
      if delta > 0 then
      begin
        dec(y);
        inc(dp, 1 - 2*y);
      end
      else
      begin
        inc(x);
        dec(y);
        inc(dp, 2*x - 2*y + 2);
      end;
    end
    else
    begin
      inc(x);
      dec(y);
      inc(dp, 2*x - 2*y + 2);
    end;
  end;
end;

procedure cCmdRestoreDefaultScreen;
begin
(*
  //If this program has taken over the display, reset it for the UI
  if (VarsCmd.DirtyDisplay == TRUE)
  {
    VarsCmd.DirtyDisplay = FALSE;

    pMapDisplay->pFunc(DISPLAY_ERASE_ALL, 0, 0, 0, 0, 0);
    pMapDisplay->UpdateMask = SCREEN_BIT(SCREEN_BACKGROUND);

    pMapUi->Flags |= UI_ENABLE_STATUS_UPDATE | UI_REDRAW_STATUS;
  }
*)
end;

procedure cCmdClearScreenIfNeeded(DrawOptions : Cardinal);
begin
  if DRAW_OPT_CLEAR_MODE(DrawOptions) <> 0 then
  begin
  end;
(*
  //If we are the first drawing command, clear the screen and record that we've done so
  if (VarsCmd.DirtyDisplay == FALSE)
  {
    VarsCmd.DirtyDisplay = TRUE;
    pMapUi->Flags &= ~UI_ENABLE_STATUS_UPDATE;

    //Override DrawOptions because we have to clear anyway
    DrawOptions = DRAW_OPT_CLEAR_WHOLE_SCREEN;
  }

  if (DRAW_OPT_CLEAR_MODE(DrawOptions))
  {
    pMapDisplay->pFunc(DISPLAY_ERASE_ALL, 0, 0, 0, 0, 0);

    //Clear UpdateMask to kill any pending updates
    pMapDisplay->UpdateMask = 0;
  }

  return;
*)
end;

function cCmdWrapSetScreenMode(var Status : Integer; ScreenMode : Cardinal) : integer;
begin
  if ScreenMode = RESTORE_NXT_SCREEN then
    cCmdRestoreDefaultScreen;
  Status := NO_ERR;
  Result := NO_ERR;
end;

function cCmdWrapDrawPoint(var Status : Integer; Location : PIMG_PT;
  Options : Cardinal) : Integer;
var
  pPt : PIMG_PT;
begin
  pPt := Location;
  cCmdClearScreenIfNeeded(Options);
  cCmdSetPixel(pPt^.X, pPt^.Y, 1);
  pMapDisplayUpdateMask(SCREEN_BIT(SCREEN_BACKGROUND));
  Status := NO_ERR;
  Result := NO_ERR;
end;

function cCmdWrapDrawLine(var Status : Integer; StartLoc, EndLoc : PIMG_PT;
  Options : Cardinal) : Integer;
var
  pPt1, pPt2 : PIMG_PT;
begin
  pPt1 := StartLoc;
  pPt2 := EndLoc;
  cCmdClearScreenIfNeeded(Options);
  cCmdDrawLine(pPt1^.X, pPt1^.Y, pPt2^.X, pPt2^.Y);
  pMapDisplayUpdateMask(SCREEN_BIT(SCREEN_BACKGROUND));
  Status := NO_ERR;
  Result := NO_ERR;
end;

function cCmdWrapDrawCircle(var Status : Integer; StartLoc : PIMG_PT;
  Radius : Integer; Options : Cardinal) : Integer;
var
  pPt : PIMG_PT;
begin
  pPt := StartLoc;
  cCmdClearScreenIfNeeded(Options);
  cCmdDrawCircle(pPt^.X, pPt^.Y, Radius);
  pMapDisplayUpdateMask(SCREEN_BIT(SCREEN_BACKGROUND));
  Status := NO_ERR;
  Result := NO_ERR;
end;

function cCmdWrapDrawRect(var Status : Integer; TopLeft, BotRight : PIMG_PT;
  Options : Cardinal) : Integer;
var
  pPt1, pPt2 : PIMG_PT;
begin
  pPt1 := TopLeft;
  pPt2 := BotRight; // actually width, height
  cCmdClearScreenIfNeeded(Options);
  cCmdDrawRect(pPt1^.X, pPt1^.Y, pPt2^.X, pPt2^.Y);
  pMapDisplayUpdateMask(SCREEN_BIT(SCREEN_BACKGROUND));
  Status := NO_ERR;
  Result := NO_ERR;
end;

function cCmdGetIMGData(DataAddr : Cardinal) : PIMG_OP_UNION;
begin
  if DataAddr >= IMG_MAX_DATA then
    Result := nil
  else
    Result := gpImgData[DataAddr];
end;

procedure cCmdSetIMGData(DataAddr : Cardinal; pSprite : PIMG_OP_UNION);
begin
  if (DataAddr >= 1) and (DataAddr < IMG_MAX_DATA) then
    gpImgData[DataAddr] := pSprite;
end;

function cCmdResolveValue(Value : SmallInt) : Integer;
var
  pVarMap : PIMG_OP_VARMAP;
  Arg, i, DCur, RCur, DSpread, VSpread, RSpread : Integer;
  Count, DPrev, RPrev : Integer;
begin
  if IMG_SYMB_USEARGS(Value) = 0 then
    Result := Value
  else
  begin
    pVarMap := PIMG_OP_VARMAP(cCmdGetIMGData(IMG_SYMB_MAP(Value)));
    Arg := gpPassedImgVars[IMG_SYMB_ARG(Value)];
    if pVarMap = nil then
      Result := Arg
    else
    begin
      // Scan through the list finding the pair the Arg lies between
      // Then linearly interpolate the mapping.
      Count := pVarMap^.MapCount;
      DPrev := pVarMap^.MapElt[0].Domain;
      RPrev := pVarMap^.MapElt[0].Range;
      RCur  := 0;
      if Arg <= DPrev then
      begin
        Result := RPrev;
        Exit;
      end;
      for i := 1 to Count - 1 do begin
        DCur := pVarMap^.MapElt[i].Domain;
        RCur := pVarMap^.MapElt[i].Range;
        if Arg < DCur then
        begin
          DSpread := DCur - DPrev;
          VSpread := Arg - DPrev;
          RSpread := RCur - RPrev;
          Result := RPrev + ((VSpread*RSpread) div DSpread);
          Exit;
        end;
        DPrev := DCur;
        RPrev := RCur;
      end;
      // If we get this far then it is too large, map it to the last point.
      Result := RCur;
    end;
  end;
end;

//#define DISP_BUFFER_P (( UBYTE* ) &(pMapDisplay->Normal))
var
  DISP_BUFFER_P : PByte = nil;
  masks : array[0..7] of byte = ($80, $40, $20, $10, $08, $04, $02, $01);

procedure cCmdCopyBitMapBits(dst_x, dst_y, src_x, src_y, src_width,
  src_height : integer; pSprite : PIMG_OP_SPRITE);
var
  dy, sx, sy, _trim, last_x, last_y, rowbytes : integer;
  pSrcByte, pDstBytes, pDstByte, pFirstDstByte, pLastDstByte : PByte;
  bit_y, not_bit_y : Byte;
begin
  // Data in the image file is row major 8 pixels per byte.top row first.
  // src and dst coordinates treat the bottom left most pixel as (0,0)
  if (pSprite = nil) or (pSprite^.OpCode <> IMG_SPRITE_ID) then
    Exit;
  pDstBytes := DISP_BUFFER_P;
  GetMem(pDstBytes, src_width*src_height);
  try
    // Clip the edges. Modify the source and width as well.
    if dst_x < 0 then begin // bounds check start of x
      _trim := (0 - dst_x);
      dst_x := 0;
      inc(src_x, _trim);
      dec(src_width, _trim);
    end;
    last_x := dst_x + src_width;
    if last_x > DISPLAY_WIDTH then // bounds check end of x
      last_x := DISPLAY_WIDTH;
    if dst_y < 0 then begin // bounds check start of y
      _trim := (0 - dst_y);
      dst_y := 0;
      inc(src_y, _trim);
      dec(src_height, _trim);
    end;
    last_y := dst_y + src_height;
    if last_y > DISPLAY_HEIGHT then // bound check end of y
      last_y := DISPLAY_HEIGHT;
    // Convert the 0,0 bottom left origin to the top left 0,0 used by the actual
    // buffer
    last_y := TRANSLATE_Y(last_y);
    dst_y  := TRANSLATE_Y(dst_y);
    // The last row is the top most scan line in the LCD Buffer
    // so limit if the copy would copy into memory before the buffer.
    // The first row copied will be the one closest to the bottom of the LCD
    // If that is off screen then limit as well and adjust the start point on the start

    // Copy bits top to top moving down.
    sy := src_y;
    rowbytes := pSprite^.RowBytes;

    pSrcByte := PByte(PChar(@(pSprite^.Bytes[0])) + ((pSprite^.Rows - 1 - sy) * rowbytes));
    pFirstDstByte := PByte(PChar(pDstBytes) + ((dst_y shr 3) * DISPLAY_REALWIDTH) + dst_x);

    for dy := dst_y downto (last_y + 1) do begin
      sx := src_x;
      bit_y := masks[7 - (dy and $07)];
      not_bit_y := not bit_y;
      pDstByte := pFirstDstByte;
      pLastDstByte := PByte(PChar(pDstByte) + (last_x - dst_x));
      while PChar(pDstByte) < PChar(pLastDstByte) do begin
        if (PByte(PChar(pSrcByte) + (sx shr 3))^ and masks[sx and $07]) <> 0 then
          pDstByte^ := pDstByte^ or bit_y
        else
          pDstByte^ := pDstByte^ and not_bit_y;
        inc(sx);
        inc(pDstByte);
      end;
      dec(pSrcByte, rowbytes);
//      inc(sy);
      if (dy and $07) = 0 then // bump back the scan line start point at rollover
        dec(pFirstDstByte, DISPLAY_REALWIDTH);
    end;
    // actually draw pDstBytes to NXT here ...
  finally
    FreeMem(pDstBytes);
  end;
end;

procedure cCmdDrawString(txt : string; X, Y : Cardinal);
begin
  if (txt = '') or (X = Y) then Exit;
(*
  UBYTE   *pSource;
  UBYTE   *pDestination;
  FONT    *pFont;
  ULONG   FontWidth;
  ULONG   Items;
  ULONG   Item;
  ULONG   Line;

  //Get current font information
  pFont = pMapDisplay->pFont;
  Items = pFont->ItemsX * pFont->ItemsY;

  //Invert Y coordinate to match display buffer
  Y = TRANSLATE_Y(Y);
  Line = (Y & 0xF8) / 8;

  //If text line is out of bounds, do nothing.
  if (Line >= TEXTLINES)
    return;

  //Calculate pointer to first byte of drawing destination
  pDestination = &(DISP_BUFFER_P[Line * DISPLAY_WIDTH + X]);

  while ( *pString )
  {
    FontWidth = pFont->ItemPixelsX;
    //Calculate X coordinate of the right edge of this character.
    //If it will extend past the right edge, clip the string.
    X += FontWidth;
    if (X >= DISPLAY_WIDTH)
      break;

    //If item is defined by the font, display it.  Else, ignore it.
    Item = *pString - ' ';
    if (Item < Items)
    {
      pSource      = (UBYTE* )&(pFont->Data[Item * FontWidth]);
      while (FontWidth--)
      {
        *pDestination = *pSource;
        pDestination++;
        pSource++;
      }
    }
    pString++;
  }
*)
end;

function cCmdWrapDrawPicture(var Status : Integer; TopLeft : PIMG_PT;
  Filename : string; Variables : TRICVariables; Options : Cardinal) : Integer;
var
  DStatus, i, OpSize : integer;
  DataSize : Cardinal;
  Pt : IMG_PT; // Where to draw the picture at (up and to the right)
//  ImageHandle : Byte;
  pImage : PIMG_OP_UNION;
  pCB : PIMG_OP_COPYBITS;
  pL : PIMG_OP_LINE;
  pR : PIMG_OP_RECT;
  pC : PIMG_OP_CIRCLE;
  pNB : PIMG_OP_NUMBOX;
  NumStr : string;
  MS : TMemoryStream;
begin
  DStatus := NO_ERR;
  cCmdClearScreenIfNeeded(Options);
  //Open the file in memory map mode. return if failure.
  MS := TMemoryStream.Create;
  try
    if FileExists(Filename) then
    begin
      MS.LoadFromFile(Filename);
      DataSize := Cardinal(MS.Size);
      MS.Position := 0;
      pImage := MS.Memory;
      // Read the ArgV params, Clear the data table.
      Pt := TopLeft^;
      gpPassedImgVars := Variables;
      for i := 0 to IMG_MAX_DATA - 1 do
        gpImgData[i] := nil;
      // Run through the op codes.
      while not IS_ERR(DStatus) do begin
        // Setup to look at an opcode, make sure it looke reasonable.
        if DataSize < SizeOf(IMG_OP_CORE) then
        begin
          DStatus := ERR_FILE;
          Break; // Too small to look at, somethings wrong.
        end;
        OpSize := pImage^.Core.OpSize + SizeOf(Word);
        if (OpSize and $01) <> 0 then begin
          DStatus := ERR_FILE;
          Break; // Odd sizes not allowed.
        end;
        case pImage^.Core.OpCode of
          IMG_DESCRIPTION_ID : begin
            // no-op
          end;
          IMG_SPRITE_ID : begin
            if OpSize >= SizeOf(IMG_OP_SPRITE) then
              cCmdSetIMGData(pImage^.Sprite.DataAddr, pImage);
          end;
          IMG_VARMAP_ID : begin
            if OpSize >= SizeOf(IMG_OP_VARMAP) then
              cCmdSetIMGData(pImage^.VarMap.DataAddr, pImage);
          end;
          IMG_COPYBITS_ID : begin
            if OpSize >= SizeOf(IMG_OP_COPYBITS) then
            begin
              pCB := @(pImage^.CopyBits);
              cCmdCopyBitMapBits(
                (cCmdResolveValue(pCB^.Dst.X) + Pt.Y),
                (cCmdResolveValue(pCB^.Dst.Y) + Pt.Y),
                cCmdResolveValue((pCB^.Src.Pt.X)),
                cCmdResolveValue((pCB^.Src.Pt.Y)),
                cCmdResolveValue((pCB^.Src.Width)),
                cCmdResolveValue((pCB^.Src.Height)),
                PIMG_OP_SPRITE(cCmdGetIMGData(cCmdResolveValue(pCB^.DataAddr))));
            end;
          end;
          IMG_PIXEL_ID : begin
            if OpSize >= SizeOf(IMG_OP_PIXEL) then begin
              cCmdSetPixel(
                (cCmdResolveValue(pImage^.Pixel.Pt.X)+Pt.X),
                (cCmdResolveValue(pImage^.Pixel.Pt.Y)+Pt.Y),
                cCmdResolveValue(pImage^.Pixel.Value));
            end;
          end;
          IMG_LINE_ID : begin
            if OpSize >= SizeOf(IMG_OP_LINE) then begin
              pL := @(pImage^.Line);
              cCmdDrawLine(
                (cCmdResolveValue(pL^.Pt1.X)+Pt.X),
                (cCmdResolveValue(pL^.Pt1.Y)+Pt.Y),
                (cCmdResolveValue(pL^.Pt2.X)+Pt.X),
                (cCmdResolveValue(pL^.Pt2.Y)+Pt.Y)
              );
            end;
          end;
          IMG_RECTANGLE_ID : begin
            if OpSize >= SizeOf(IMG_OP_RECT) then begin
              pR := @(pImage^.Rect);
              cCmdDrawRect(
                (cCmdResolveValue(pR^.Pt.X)+Pt.X),
                (cCmdResolveValue(pR^.Pt.Y)+Pt.Y),
                (cCmdResolveValue(pR^.Width)+Pt.X),
                (cCmdResolveValue(pR^.Height)+Pt.Y)
              );
            end;
          end;
          IMG_CIRCLE_ID : begin
            if OpSize >= SizeOf(IMG_OP_CIRCLE) then begin
              pC := @(pImage^.Circle);
              cCmdDrawCircle(
                (cCmdResolveValue(pC^.Pt.X)+Pt.X),
                (cCmdResolveValue(pC^.Pt.Y)+Pt.Y),
                cCmdResolveValue(pC^.Radius)
              );
            end;
          end;
          IMG_NUMBOX_ID : begin
            if OpSize >= SizeOf(IMG_OP_NUMBOX) then begin
              pNB := @(pImage^.NumBox);
              NumStr := Format('%d', [cCmdResolveValue(pNB^.Value)]);
              cCmdDrawString(
                NumStr,
                (cCmdResolveValue(pNB^.Pt.X) + Pt.X),
                (cCmdResolveValue(pNB^.Pt.Y) + Pt.Y));
            end;
          end;
        else
          //Unrecognized opcode, pass an error back to the diagram.
          DStatus := ERR_FILE;
          Break;
        end;
        dec(DataSize, OpSize);
        pImage := PIMG_OP_UNION(PChar(pImage) + OpSize);
      end;
      pMapDisplayUpdateMask(SCREEN_BIT(SCREEN_BACKGROUND));
    end;
  finally
    MS.Free;
  end;
  // Set return value and return
  Status := DStatus;
  Result := NO_ERR;
end;

function IMG_SYMB_USEARGS(v : cardinal) : cardinal;
begin
  Result := v and $F000;
end;

function IMG_SYMB_MAP(v : cardinal) : cardinal;
begin
  Result := (v and $0F00) shr 8;
end;

function IMG_SYMB_ARG(v : cardinal) : cardinal;
begin
  Result := v and $00FF;
end;

function DRAW_OPT_CLEAR_MODE(v : cardinal) : cardinal;
begin
  Result := v and $0003;
end;

function TRANSLATE_Y(y : integer) : integer;
begin
  Result := (DISPLAY_HEIGHT-1) - y;
end;

end.
