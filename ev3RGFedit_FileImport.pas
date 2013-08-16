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
unit ev3RGFedit_FileImport;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Types, Classes, Controls, Forms, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls, Buttons, ExtDlgs;

type
  TfrmImageImport = class(TForm)
    imgOriginal: TImage;
    Bevel1: TBevel;
    lblPreview: TLabel;
    lblPreview2: TLabel;
    bvlEV3: TBevel;
    imgEV3: TImage;
    dlgSelect: TOpenPictureDialog;
    dlgSave: TSaveDialog;
    chkStretch: TCheckBox;
    chkCenter: TCheckBox;
    chkProportional: TCheckBox;
    barBrightness: TTrackBar;
    lblContrast: TLabel;
    btnSelect: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure barBrightnessChange(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure chkCenterClick(Sender: TObject);
    procedure imgEV3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgEV3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgEV3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnOKClick(Sender: TObject);
  private
    origX : integer;
    origY : integer;
    newX : integer;
    newY : integer;
    lastX : integer;
    lastY : integer;
    bSelecting : boolean;
    fFilename: String;
    procedure ResetSelection;
    procedure RemoveSelectionRectangle;
    procedure ShowImage(fn: String);
    procedure TranslateToEv3Picture;
    function GetHeight: byte;
    function GetWidth: byte;
    function GetX0: byte;
    function GetY0: byte;
    function GetSourceRect: TRect;
  public
    property SourceRect : TRect read GetSourceRect;
    property FileName : String read fFilename write fFilename;
  end;

var
  frmImageImport: TfrmImageImport;

implementation

{$R *.dfm}

uses
{$IFNDEF FPC}
  JPEG, pngimage, GIFImage,
{$ELSE}
{$ENDIF}
  SysUtils, Graphics, Math, ev3RGFedit_Basis;

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

procedure TfrmImageImport.TranslateToEv3Picture;
var
  x, y, c : Integer;
  rgb : TRGBColor;
  hsb : THSBColor;
  tb, bx, by  : Integer;
begin
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
           imgEV3.Canvas.Pixels[ x,y ] := CL_BACKGROUND
         else
           imgEV3.Canvas.Pixels[ x,y ] := CL_FRONT;
     end;
  end;
  Application.ProcessMessages;
end;

procedure TfrmImageImport.ShowImage( fn:String );
begin
  if FileExists(fn) then
  begin
    filename := fn;
    imgOriginal.Picture.LoadFromFile( fn );
    imgOriginal.Center := chkCenter.Checked;
    imgOriginal.Proportional := chkProportional.Checked;
    imgOriginal.Stretch := chkStretch.Checked;{ and
                         (( imgOriginal.Picture.Width  > imgOriginal.Width  ) or
                          ( imgOriginal.Picture.Height > imgOriginal.Height ));}
    TranslateToEv3Picture;
  end;
end;

procedure TfrmImageImport.FormCreate(Sender: TObject);
begin
  ResetSelection;

  {$IFNDEF FPC}
  dlgSelect.Filter := 'All Image Files|*.jpg;*.jpeg;*.bmp;*.png;*.gif|' +
                      'JPEG Image File (*.jpg,*.jpeg)|*.jpg;*.jpeg|' +
                      'Bitmaps (*.bmp)|*.bmp|' +
                      'PNG Image File (*.png)|*.png|' +
                      'GIF Image File (*.gif)|*.gif';
  {$ELSE}
  dlgSelect.Filter := 'All Image Files|*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.pnm;*.tiff|' +
                      'JPEG Image File (*.jpg,*.jpeg)|*.jpg;*.jpeg|' +
                      'Bitmaps (*.bmp)|*.bmp|' +
                      'PNG Image File (*.png)|*.png|' +
                      'PNM Image File (*.pnm)|*.pnm|' +
                      'TIFF Image File (*.tiff)|*.tiff';
  {$ENDIF}

  ImageClear(imgOriginal);
  ImageClear(imgEV3);
end;

procedure TfrmImageImport.barBrightnessChange(Sender: TObject);
begin
  btnOK.SetFocus;
  Application.ProcessMessages;
  TranslateToEv3Picture;
end;

procedure TfrmImageImport.btnSelectClick(Sender: TObject);
begin
  ResetSelection;
  if dlgSelect.Execute then
  begin
    ShowImage(dlgSelect.FileName);
    btnOK.Enabled := True;
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

procedure TfrmImageImport.imgEV3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  newX := -1;
  newY := -1;
  lastX := X;
  lastY := Y;
  bSelecting := False;
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
  ShowImage(filename);
end;

function TfrmImageImport.GetSourceRect: TRect;
begin
  Result.Left := GetX0;
  Result.Right := Result.Left + GetWidth;
  Result.Top := GetY0;
  Result.Bottom := Result.Top + GetHeight;
end;

procedure TfrmImageImport.btnOKClick(Sender: TObject);
begin
  RemoveSelectionRectangle;
//  ResetSelection;
end;

procedure TfrmImageImport.RemoveSelectionRectangle;
begin
  if (lastX <> -1) and (lastY <> -1) and (origX <> -1) and (origY <> -1) then
    imgEV3.Canvas.DrawFocusRect(Rect(origX, origY, lastX, lastY));
end;

end.
