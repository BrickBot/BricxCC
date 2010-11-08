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
unit uNXTImage;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows,
{$ELSE}
  LResources,
  LCLType,
{$ENDIF}
  Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, Menus,
  ExtDlgs, ActnList, StdCtrls, uOfficeComp, uNXTImageMovie;

type

  { TfrmNXTImage }

  TfrmNXTImage = class(TForm)
    imgNXT: TImage;
    shpEnter: TShape;
    shpExit: TShape;
    imgScreen: TImage;
    tmrRefresh: TTimer;
    ActionList1: TActionList;
    actSaveAs: TAction;
    actCopy: TAction;
    actPollNow: TAction;
    actPolling: TAction;
    act50ms: TAction;
    act100ms: TAction;
    act200ms: TAction;
    act500ms: TAction;
    act1sec: TAction;
    act10sec: TAction;
    lblInfo: TLabel;
    lblNXTOff: TLabel;
    act2sec: TAction;
    act5sec: TAction;
    act20sec: TAction;
    act1min: TAction;
    actCaptureAVI: TAction;
    dlgSaveAVI: TSaveDialog;
    shpRight2: TShape;
    shpRight1: TShape;
    shpRight3: TShape;
    shpLeft1: TShape;
    shpLeft2: TShape;
    shpLeft3: TShape;
    dlgSavePic: TSaveDialog;
    actSave: TAction;
    actPrefs: TAction;
    procedure shpLeftMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shpRightMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tmrRefreshTimer(Sender: TObject);
    procedure mniExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure shpEnterMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shpExitMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RescaleClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mniAboutClick(Sender: TObject);
    procedure actSaveAsExecute(Sender: TObject);
    procedure actCopyExecute(Sender: TObject);
    procedure actPollNowExecute(Sender: TObject);
    procedure actPollingExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure HandleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mniDisplayPopupClick(Sender: TObject);
    procedure dlgSavePicTypeChange(Sender: TObject);
    procedure mniPlayClicksClick(Sender: TObject);
    procedure mniSetNXTNameClick(Sender: TObject);
    procedure mniBootSAMBAClick(Sender: TObject);
    procedure mniBTResetClick(Sender: TObject);
    procedure mniUtilsClick(Sender: TObject);
    procedure actCaptureAVIExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actPrefsExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ScaleClick(Sender: TObject);
    procedure RefreshRateClick(Sender: TObject);
  private
    pmuMain: TOfficePopupMenu;
    mniAbout: TOfficeMenuItem;
    mniUtils: TOfficeMenuItem;
    mniSetNXTName: TOfficeMenuItem;
    mniBootSAMBA: TOfficeMenuItem;
    mniBTReset: TOfficeMenuItem;
    mniSep1: TOfficeMenuItem;
    mniSave: TOfficeMenuItem;
    mniSaveAs: TOfficeMenuItem;
    mniCopy: TOfficeMenuItem;
    mniSep2: TOfficeMenuItem;
    mniPollNow: TOfficeMenuItem;
    mniPoll: TOfficeMenuItem;
    mniRefreshRate: TOfficeMenuItem;
    mni50ms: TOfficeMenuItem;
    mni100ms: TOfficeMenuItem;
    mni200ms: TOfficeMenuItem;
    mni500ms: TOfficeMenuItem;
    mni1sec: TOfficeMenuItem;
    mni2sec: TOfficeMenuItem;
    mni5sec: TOfficeMenuItem;
    mni10sec: TOfficeMenuItem;
    mni20sec: TOfficeMenuItem;
    mni1min: TOfficeMenuItem;
    mniCaptureAVI: TOfficeMenuItem;
    mniPreferences: TOfficeMenuItem;
    mniSep3: TOfficeMenuItem;
    mniScale: TOfficeMenuItem;
    mni10x: TOfficeMenuItem;
    mni12x: TOfficeMenuItem;
    mni15x: TOfficeMenuItem;
    mni18x: TOfficeMenuItem;
    mni20x: TOfficeMenuItem;
    mni22x: TOfficeMenuItem;
    mni25x: TOfficeMenuItem;
    mni28x: TOfficeMenuItem;
    mni30x: TOfficeMenuItem;
    mni32x: TOfficeMenuItem;
    mni35x: TOfficeMenuItem;
    mni38x: TOfficeMenuItem;
    mni40x: TOfficeMenuItem;
    mniSep4: TOfficeMenuItem;
    mniDisplay: TOfficeMenuItem;
    mniDisplayNormal: TOfficeMenuItem;
    mniDisplayPopup: TOfficeMenuItem;
    mniSep5: TOfficeMenuItem;
    mniPlayClicks: TOfficeMenuItem;
    mniSep6: TOfficeMenuItem;
    mniExit: TOfficeMenuItem;
    procedure CreatePopupMenu;
  private
    { Private declarations }
    fBytes : array[0..799] of byte;
    fBusy : boolean;
    fDisplayNormal : boolean;
    fGoodRead : boolean;
    fGC : TGraphicClass;
    fClickStream : TMemoryStream;
    fCurrentName : string;
    fMovieWriter : TNXTImageMovie;
    procedure RefreshImage;
    procedure RetrieveScreenBytes;
    procedure DrawImage;
    function GetPixelColor(b : byte; bit : integer) : TColor;
    procedure ExecuteButton(const btn : integer);
    procedure ScaleForm(const i : integer);
    procedure ResizeImage;
    procedure DoClick;
    function GraphicClassFromExt(ext: string): TGraphicClass;
    function GraphicClassFromFilterIndex(const idx: integer): TGraphicClass;
    function GetFilterIndexFromExt(ext: string): integer;
    function GetExtFromFilterIndex(const idx: integer): string;
    procedure CheckForCustomClick;
    function GetCurrentName: string;
    procedure SetCurrentName(const Value: string);
  protected
    function GetAutomaticFilename : string;
    property CurrentName : string read GetCurrentName write SetCurrentName;
  public
    { Public declarations }
  end;

var
  frmNXTImage: TfrmNXTImage;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

uses
  SysUtils, Themes, Clipbrd,
  {$IFNDEF FPC}
  JPEG, MMSystem, pngimage, GIFImage, uRICImage,
  {$ENDIF}
  uGuiUtils, uSpirit,
  brick_common, uNXTConstants, rcx_constants,
  uNXTName, uLocalizedStrings, uNXTImageGlobals, uNXTImagePrefs;

{$IFNDEF FPC}
type
  TPortableNetworkGraphic = TPNGObject;
{$ENDIF}

function StripPeriod(const ext : string) : string;
begin
  Result := LowerCase(ext);
  if Pos('.', ext) = 1 then
    System.Delete(Result, 1, 1);
end;

procedure TfrmNXTImage.tmrRefreshTimer(Sender: TObject);
begin
  if not fBusy and Visible and (WindowState <> wsMinimized) then
    RefreshImage;
end;

procedure TfrmNXTImage.shpLeftMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    ExecuteButton(1);
end;

procedure TfrmNXTImage.shpRightMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    ExecuteButton(3);
end;

procedure TfrmNXTImage.RefreshImage;
begin
  fBusy := True;
  try
    RetrieveScreenBytes;
    lblNXTOff.Visible := not fGoodRead;
    DrawImage;
  finally
    fBusy := False;
  end;
end;

procedure TfrmNXTImage.DrawImage;
var
  b : byte;
  i, x, line : integer;
  bmp : TBitmap;
begin
  bmp := TBitmap.Create;
  try
    bmp.Width  := 100;
    bmp.Height := 64;
    for line := 0 to 7 do
    begin
      for x := 0 to 99 do
      begin
        b := fBytes[line*100 + x];
        for i := 0 to 7 do
        begin
          bmp.Canvas.Pixels[x, line*8+i] := GetPixelColor(b, i);
        end;
      end;
    end;
    imgScreen.Canvas.StretchDraw(Rect(0, 0, imgScreen.Width, imgScreen.Height), bmp);
    if actCaptureAVI.Checked then
    begin
      fMovieWriter.AddPicture(imgScreen.Picture);
    end;
  finally
    bmp.Free;
  end;
end;

function TfrmNXTImage.GetPixelColor(b: byte; bit: integer): TColor;
var
  val : byte;
begin
  Result := LCDBackgroundColor;
  val := 1 shl bit;
  if (b and val) = val then
    Result := clBlack;
end;

procedure TfrmNXTImage.RetrieveScreenBytes;
var
  idx, i : integer;
  offset, count : word;
  modID : Cardinal;
  b : NXTDataBuffer;
begin
  FillChar(fBytes[0], 800, 0); // clear the array of bytes
  idx := 0;
  if fDisplayNormal then
    offset := DisplayOffsetNormal(0, 0)
  else
    offset := DisplayOffsetPopup(0, 0);
  modID := kNXT_ModuleDisplay;
  for i := 0 to 15 do
  begin
    count := 50;
    fGoodRead := BrickComm.NXTReadIOMap(modID, offset, count, b);
    if not fGoodRead then
      break;
    Move(b.Data[0], fBytes[idx], count);
    inc(offset, count);
    inc(idx, count);
  end;
end;

procedure TfrmNXTImage.mniExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmNXTImage.FormCreate(Sender: TObject);
begin
  CreatePopupMenu;
  imgNXT.PopupMenu    := pmuMain;
  imgScreen.PopupMenu := pmuMain;
  lblInfo.PopupMenu   := pmuMain;
  fMovieWriter := TNXTImageMovie.Create(Self);
  fMovieWriter.MaxFramesPerMovie := NXTImageMaxFramesPerMovie;
  fCurrentName := '';
  fDisplayNormal := True;
  imgNXT.Picture.Bitmap.FreeImage;
  Self.DoubleBuffered := True;
  ScaleForm(NXTImageScale);    // 2.5x
  tmrRefresh.Interval := NXTImageDefaultRefreshRate;
{$IFNDEF FPC}
  dlgSavePic.Filter :=
    'All (*.png;*.jpg;*.jpeg;*.gif;*.bmp)|*.png;*.jpg;*.jpeg;*.gif;*.bmp|' +
    'Portable Network Graphics (*.png)|*.png|' +
    'JPEG Image File (*.jpg)|*.jpg|' +
    'JPEG Image File (*.jpeg)|*.jpeg|' +
    'GIF Image File (*.gif)|*.gif|' +
    'Bitmaps (*.bmp)|*.bmp';
  dlgSavePic.FilterIndex := 6;
{$ELSE}
  dlgSavePic.Filter :=
    'All (*.png;*.jpg;*.jpeg;*.xpm;*.bmp)|*.png;*.jpg;*.jpeg;*.xpm;*.bmp|' +
    'Portable Network Graphics (*.png)|*.png|' +
    'JPEG Image File (*.jpg)|*.jpg|' +
    'JPEG Image File (*.jpeg)|*.jpeg|' +
    'Pixmap File (*.xpm)|*.xpm|' +
    'Bitmaps (*.bmp)|*.bmp';
  dlgSavePic.FilterIndex := 6;
{$ENDIF}
  dlgSavePic.InitialDir := DefaultNXTImageDirectory;
  fClickStream := TMemoryStream.Create;
  CheckForCustomClick;
end;

procedure TfrmNXTImage.ExecuteButton(const btn: integer);
var
  offset : word;
  modID : Cardinal;
  count : word;
  b : NXTDataBuffer;
begin
  modID  := kNXT_ModuleUI;
  offset := UIOffsetButton;
  count  := 1;
  b.Data[0] := btn;
  BrickComm.NXTWriteIOMap(modID, offset, count, b);
  DoClick;
end;

procedure TfrmNXTImage.shpEnterMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    ExecuteButton(2);
end;

procedure TfrmNXTImage.shpExitMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    ExecuteButton(4);
end;

procedure TfrmNXTImage.RescaleClick(Sender: TObject);
begin
  TOfficeMenuItem(Sender).Checked := True;
  NXTImageScale := TOfficeMenuItem(Sender).Tag;
  ScaleForm(NXTImageScale);
end;

procedure TfrmNXTImage.ScaleClick(Sender: TObject);
var
  i : integer;
  M : TOfficeMenuItem;
begin
  for i := 0 to mniScale.Count - 1 do
  begin
    M := TOfficeMenuItem(mniScale.Items[i]);
    M.Checked := M.Tag = NXTImageScale;
  end;
end;

procedure TfrmNXTImage.RefreshRateClick(Sender: TObject);
var
  i : integer;
  M : TOfficeMenuItem;
begin
  for i := 0 to mniRefreshRate.Count - 1 do
  begin
    M := TOfficeMenuItem(mniRefreshRate.Items[i]);
    M.Checked := M.Tag = NXTImageDefaultRefreshRate;
  end;
end;

const
  NxtWidth     = 429.0;
  NxtHeight    = 662.0;
  AspectRatio  = NxtHeight/NxtWidth;
  ScrnLeft     = 89;
  ScrnTop      = 129;
  ScrnWidth    = 250;
  ScrnHeight   = 160;
  EnterLeft    = 182;
  EnterTop     = 363;
  EnterWidth   = 62;
  EnterHeight  = 62;
  ExitLeft     = 182;
  ExitTop      = 451;
  ExitWidth    = 62;
  ExitHeight   = 38;
  Left1Left    = 124;
  Left1Top     = 364;
  Left1Width   = 32;
  Left1Height  = 17;
  Left2Left    = 102;
  Left2Top     = 380;
  Left2Width   = 54;
  Left2Height  = 27;
  Left3Left    = 124;
  Left3Top     = 406;
  Left3Width   = 32;
  Left3Height  = 17;
  Right1Left   = 269;
  Right1Top    = 364;
  Right1Width  = 32;
  Right1Height = 17;
  Right2Left   = 269;
  Right2Top    = 380;
  Right2Width  = 54;
  Right2Height = 27;
  Right3Left   = 269;
  Right3Top    = 406;
  Right3Width  = 32;
  Right3Height = 17;

procedure TfrmNXTImage.ScaleForm(const i: integer);
var
  factor : double;
begin
  case i of
    0 : factor := 0.4; // 1x
    1 : factor := 0.5; // 1.25x
    2 : factor := 0.6; // 1.5x
    3 : factor := 0.7; // 1.75x
    4 : factor := 0.8; // 2x
    5 : factor := 0.9; // 2.2x
    6 : factor := 1.0; // 2.5x
    7 : factor := 1.1; // 2.8x
    8 : factor := 1.2; // 3x
    9 : factor := 1.3; // 3.2x
   10 : factor := 1.4; // 3.5x
   11 : factor := 1.5; // 3.8x
   12 : factor := 1.6; // 4x
  else
    factor := 1.0;
  end;
  // every control gets its top, left, width, and height multiplied by factor
  imgNXT.Width     := Trunc(NxtWidth * factor);
  imgNXT.Height    := Trunc(imgNXT.Width * AspectRatio);
//  imgNXT.Height    := Trunc(NxtHeight * factor);
  Width      := imgNXT.Width + 2;
  Height     := imgNXT.Height + 2;
  imgScreen.Left   := Trunc(ScrnLeft * factor);
  imgScreen.Top    := Trunc(ScrnTop * factor);
  imgScreen.Width  := Trunc(ScrnWidth * factor);
  imgScreen.Height := Trunc(ScrnHeight * factor);
  ResizeImage;
  shpEnter.Left    := Trunc(EnterLeft * factor);
  shpEnter.Top     := Trunc(EnterTop * factor);
  shpEnter.Width   := Trunc(EnterWidth * factor);
  shpEnter.Height  := Trunc(EnterHeight * factor);
  shpExit.Left     := Trunc(ExitLeft * factor);
  shpExit.Top      := Trunc(ExitTop * factor);
  shpExit.Width    := Trunc(ExitWidth * factor);
  shpExit.Height   := Trunc(ExitHeight * factor);
  shpLeft1.Left     := Trunc(Left1Left * factor);
  shpLeft1.Top      := Trunc(Left1Top * factor);
  shpLeft1.Width    := Trunc(Left1Width * factor);
  shpLeft1.Height   := Trunc(Left1Height * factor);
  shpLeft2.Left     := Trunc(Left2Left * factor);
  shpLeft2.Top      := Trunc(Left2Top * factor);
  shpLeft2.Width    := Trunc(Left2Width * factor);
  shpLeft2.Height   := Trunc(Left2Height * factor);
  shpLeft3.Left     := Trunc(Left3Left * factor);
  shpLeft3.Top      := Trunc(Left3Top * factor);
  shpLeft3.Width    := Trunc(Left3Width * factor);
  shpLeft3.Height   := Trunc(Left3Height * factor);
  shpRight1.Left    := Trunc(Right1Left * factor);
  shpRight1.Top     := Trunc(Right1Top * factor);
  shpRight1.Width   := Trunc(Right1Width * factor);
  shpRight1.Height  := Trunc(Right1Height * factor);
  shpRight2.Left    := Trunc(Right2Left * factor);
  shpRight2.Top     := Trunc(Right2Top * factor);
  shpRight2.Width   := Trunc(Right2Width * factor);
  shpRight2.Height  := Trunc(Right2Height * factor);
  shpRight3.Left    := Trunc(Right3Left * factor);
  shpRight3.Top     := Trunc(Right3Top * factor);
  shpRight3.Width   := Trunc(Right3Width * factor);
  shpRight3.Height  := Trunc(Right3Height * factor);
end;

procedure TfrmNXTImage.ResizeImage;
var
  bmp : TBitmap;
begin
  bmp := TBitmap.Create;
  bmp.Width  := imgScreen.Width;
  bmp.Height := imgScreen.Height;
  imgScreen.Picture.Bitmap := bmp;
  DrawImage;
end;

procedure TfrmNXTImage.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fClickStream);
end;

procedure TfrmNXTImage.mniAboutClick(Sender: TObject);
begin
  ShowMessage('NeXT Screen'#13#10'Copyright 2007-2009, John C. Hansen');
end;

procedure TfrmNXTImage.actSaveExecute(Sender: TObject);
var
  G : TGraphic;
begin
  fBusy := True;
  try
    fGC := GraphicClassFromExt(DefaultNXTImageFileExt);
    G := fGC.Create;
    try
      G.Assign(imgScreen.Picture.Graphic);
      G.SaveToFile(DefaultNXTImageDirectory + GetAutomaticFilename);
//      if G is TPortableNetworkGraphic then
//        TPortableNetworkGraphic(G).TransparentColor := LCDBackgroundColor;
//      TJPegImage(G).Transparent := True;
    finally
      G.Free;
    end;
  finally
    inc(NXTImageIndex);
    fBusy := False;
  end;
end;

procedure TfrmNXTImage.actSaveAsExecute(Sender: TObject);
var
  G : TGraphic;
  ext : string;
begin
  fBusy := True;
  try
    fGC := GraphicClassFromExt(DefaultNXTImageFileExt);
    dlgSavePic.DefaultExt := StripPeriod(DefaultNXTImageFileExt);
    dlgSavePic.FilterIndex := GetFilterIndexFromExt(DefaultNXTImageFileExt);
    if dlgSavePic.Execute then
    begin
      ext := LowerCase(ExtractFileExt(dlgSavePic.FileName));
      if dlgSavePic.FilterIndex = 1 then
        fGC := GraphicClassFromExt(ext)
      else
        fGC := GraphicClassFromFilterIndex(dlgSavePic.FilterIndex);
      G := fGC.Create;
      try
        G.Assign(imgScreen.Picture.Graphic);
        G.SaveToFile(dlgSavePic.FileName);
      finally
        G.Free;
      end;
    end;
  finally
    fBusy := False;
  end;
end;

procedure TfrmNXTImage.actCopyExecute(Sender: TObject);
{$IFDEF FPC}
begin
{$ELSE}
var
  fmt : Word;
  data : THandle;
  palette : HPALETTE;
begin
  imgScreen.Picture.Bitmap.SaveToClipboardFormat(fmt, data, palette);
  Clipboard.SetAsHandle(fmt, data);
{$ENDIF}
end;

procedure TfrmNXTImage.actPollNowExecute(Sender: TObject);
begin
  tmrRefreshTimer(Sender);
end;

procedure TfrmNXTImage.actPollingExecute(Sender: TObject);
begin
  actPolling.Checked := not actPolling.Checked;
  tmrRefresh.Enabled := actPolling.Checked;
end;

procedure TfrmNXTImage.actRefreshExecute(Sender: TObject);
begin
  if Sender is TAction then
    TAction(Sender).Checked := True
  else if Sender is TOfficeMenuItem then
    TOfficeMenuItem(Sender).Checked := True;
  NXTImageDefaultRefreshRate := TControl(Sender).Tag;
  tmrRefresh.Interval := NXTImageDefaultRefreshRate;
end;

procedure TfrmNXTImage.HandleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
  begin
    if Key = VK_LEFT then
      ExecuteButton(1)
    else if Key = VK_UP then
      ExecuteButton(2)
    else if Key = VK_RIGHT then
      ExecuteButton(3)
    else if Key = VK_DOWN then
      ExecuteButton(4)
    else if Key =  VK_MENU then
      pmuMain.Popup(0, 0);
  end;
end;

procedure TfrmNXTImage.mniDisplayPopupClick(Sender: TObject);
begin
  TOfficeMenuItem(Sender).Checked := True;
  fDisplayNormal := mniDisplayNormal.Checked;
end;

procedure TfrmNXTImage.DoClick;
var
  buf : PChar;
begin
{$IFNDEF FPC}
  if mniPlayClicks.Checked then
  begin
    GetMem(buf, fClickStream.Size);
    try
      Move(fClickStream.Memory^, buf^, fClickStream.Size);
//      MoveMemory(buf, fClickStream.Memory, fClickStream.Size);
      PlaySound(buf, Application.Handle, SND_MEMORY);
    finally
      FreeMem(buf);
    end;
  end;
{$ENDIF}
end;

procedure TfrmNXTImage.dlgSavePicTypeChange(Sender: TObject);
begin
  fGC := GraphicClassFromFilterIndex(dlgSavePic.FilterIndex);
  dlgSavePic.DefaultExt := GetExtFromFilterIndex(dlgSavePic.FilterIndex);
end;

function TfrmNXTImage.GraphicClassFromExt(ext: string): TGraphicClass;
begin
  ext := StripPeriod(ext);
{$IFNDEF FPC}
  if (ext = 'gif') then
    Result := TGIFImage
{$ELSE}
  if (ext = 'xpm') then
    Result := TPixmap
{$ENDIF}
  else if (ext = 'jpg') or (ext = 'jpeg') then
    Result := TJPEGImage
  else if (ext = 'png') then
    Result := TPortableNetworkGraphic
  else
    Result := TBitmap;
end;

function TfrmNXTImage.GraphicClassFromFilterIndex(const idx: integer): TGraphicClass;
begin
  case idx of
    2 : Result := TPortableNetworkGraphic;
    3 : Result := TJPEGImage;
    4 : Result := TJPEGImage;
{$IFNDEF FPC}
    5 : Result := TGIFImage;
{$ELSE}
    5 : Result := TPixmap;
{$ENDIF}
    6 : Result := TBitmap;
  else
    Result := TBitmap;
  end;
end;

function TfrmNXTImage.GetFilterIndexFromExt(ext: string): integer;
begin
  ext := StripPeriod(ext);
{$IFNDEF FPC}
  if (ext = 'gif') then
    Result := 5
{$ELSE}
  if (ext = 'xpm') then
    Result := 5
{$ENDIF}
  else if (ext = 'jpg') then
    Result := 3
  else if (ext = 'jpeg') then
    Result := 4
  else if (ext = 'png') then
    Result := 2
  else
    Result := 6;
end;

function TfrmNXTImage.GetExtFromFilterIndex(const idx: integer): string;
begin
  case dlgSavePic.FilterIndex of
    2 : Result := 'png';
    3 : Result := 'jpg';
    4 : Result := 'jpeg';
{$IFNDEF FPC}
    5 : Result := 'gif';
{$ELSE}
    5 : Result := 'xpm';
{$ENDIF}
    6 : Result := 'bmp';
  else
    Result := 'bmp';
  end;
end;

procedure TfrmNXTImage.CheckForCustomClick;
{$IFNDEF FPC}
var
  RS : TResourceStream;
{$ENDIF}
begin
{$IFNDEF FPC}
  if FileExists('click.wav') then
  begin
    fClickStream.LoadFromFile('click.wav');
  end
  else
  begin
    RS := TResourceStream.Create(HInstance, 'CLICK', 'WAVE');
    try
      fClickStream.LoadFromStream(RS);
    finally
      RS.Free;
    end;
  end;
{$ENDIF}
end;

procedure TfrmNXTImage.mniPlayClicksClick(Sender: TObject);
begin
  mniPlayClicks.Checked := not mniPlayClicks.Checked;
end;

procedure TfrmNXTImage.mniSetNXTNameClick(Sender: TObject);
var
  F : TfrmNXTName;
begin
  F := TfrmNXTName.Create(self);
  try
    F.edtNXTName.Text := CurrentName;
    if F.ShowModal = mrOK then
    begin
      BrickComm.NXTSetBrickName(F.edtNXTName.Text, True);
      CurrentName := F.edtNXTName.Text;
    end;
  finally
    F.Free;
  end;
end;

procedure TfrmNXTImage.mniBootSAMBAClick(Sender: TObject);
begin
  if MessageDlg(sBootSAMBAConfirm, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    BrickComm.NXTBootCommand(True);
  end;
end;

procedure TfrmNXTImage.mniBTResetClick(Sender: TObject);
begin
  if MessageDlg(sBTResetConfirm, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    BrickComm.NXTBTFactoryReset(True);
  end;
end;

procedure TfrmNXTImage.mniUtilsClick(Sender: TObject);
begin
  mniBootSAMBA.Enabled := not BrickComm.UseBluetooth;
  mniBTReset.Enabled   := mniBootSAMBA.Enabled;
end;

function TfrmNXTImage.GetCurrentName: string;
begin
  if fCurrentName = '' then
    fCurrentName := BrickComm.NXTGetBrickName;
  Result := fCurrentName;
end;

procedure TfrmNXTImage.SetCurrentName(const Value: string);
begin
  fCurrentName := Value;
end;

procedure TfrmNXTImage.actCaptureAVIExecute(Sender: TObject);
begin
  // capturing a video requires that polling be enabled.
  actCaptureAVI.Checked := not actCaptureAVI.Checked;
  try
    if actCaptureAVI.Checked then
    begin
      // starting to record
      if not dlgSaveAVI.Execute then
      begin
        actCaptureAVI.Checked := False;
        Exit;
      end;
      fMovieWriter.Clear;
      fMovieWriter.FileName  := dlgSaveAVI.FileName;
      fMovieWriter.FrameTime := tmrRefresh.Interval;
      fMovieWriter.Height    := imgScreen.Height;
      fMovieWriter.Width     := imgScreen.Width;
      fMovieWriter.Stretch   := True;
    end
    else
    begin
      // finished recording
      fMovieWriter.Write;
      fMovieWriter.Clear;
    end;
  finally
    actPolling.Checked := actCaptureAVI.Checked;
    tmrRefresh.Enabled := actPolling.Checked;
  end;
end;

procedure TfrmNXTImage.CreatePopupMenu;
begin
  pmuMain := TOfficePopupMenu.Create(Self);
  pmuMain.Name := 'pmuMain';
  mniAbout := TOfficeMenuItem.Create(pmuMain);
  mniUtils := TOfficeMenuItem.Create(pmuMain);
  mniSetNXTName := TOfficeMenuItem.Create(mniUtils);
  mniBootSAMBA := TOfficeMenuItem.Create(mniUtils);
  mniBTReset := TOfficeMenuItem.Create(mniUtils);
  mniSep1 := TOfficeMenuItem.Create(pmuMain);
  mniSave := TOfficeMenuItem.Create(pmuMain);
  mniSaveAs := TOfficeMenuItem.Create(pmuMain);
  mniCopy := TOfficeMenuItem.Create(pmuMain);
  mniSep2 := TOfficeMenuItem.Create(pmuMain);
  mniPollNow := TOfficeMenuItem.Create(pmuMain);
  mniPoll := TOfficeMenuItem.Create(pmuMain);
  mniRefreshRate := TOfficeMenuItem.Create(pmuMain);
  mni50ms := TOfficeMenuItem.Create(mniRefreshRate);
  mni100ms := TOfficeMenuItem.Create(mniRefreshRate);
  mni200ms := TOfficeMenuItem.Create(mniRefreshRate);
  mni500ms := TOfficeMenuItem.Create(mniRefreshRate);
  mni1sec := TOfficeMenuItem.Create(mniRefreshRate);
  mni2sec := TOfficeMenuItem.Create(mniRefreshRate);
  mni5sec := TOfficeMenuItem.Create(mniRefreshRate);
  mni10sec := TOfficeMenuItem.Create(mniRefreshRate);
  mni20sec := TOfficeMenuItem.Create(mniRefreshRate);
  mni1min := TOfficeMenuItem.Create(mniRefreshRate);
  mniCaptureAVI := TOfficeMenuItem.Create(pmuMain);
  mniPreferences := TOfficeMenuItem.Create(pmuMain);
  mniSep3 := TOfficeMenuItem.Create(pmuMain);
  mniScale := TOfficeMenuItem.Create(pmuMain);
  mni10x := TOfficeMenuItem.Create(mniScale);
  mni12x := TOfficeMenuItem.Create(mniScale);
  mni15x := TOfficeMenuItem.Create(mniScale);
  mni18x := TOfficeMenuItem.Create(mniScale);
  mni20x := TOfficeMenuItem.Create(mniScale);
  mni22x := TOfficeMenuItem.Create(mniScale);
  mni25x := TOfficeMenuItem.Create(mniScale);
  mni28x := TOfficeMenuItem.Create(mniScale);
  mni30x := TOfficeMenuItem.Create(mniScale);
  mni32x := TOfficeMenuItem.Create(mniScale);
  mni35x := TOfficeMenuItem.Create(mniScale);
  mni38x := TOfficeMenuItem.Create(mniScale);
  mni40x := TOfficeMenuItem.Create(mniScale);
  mniSep4 := TOfficeMenuItem.Create(pmuMain);
  mniDisplay := TOfficeMenuItem.Create(pmuMain);
  mniDisplayNormal := TOfficeMenuItem.Create(mniDisplay);
  mniDisplayPopup := TOfficeMenuItem.Create(mniDisplay);
  mniSep5 := TOfficeMenuItem.Create(pmuMain);
  mniPlayClicks := TOfficeMenuItem.Create(pmuMain);
  mniSep6 := TOfficeMenuItem.Create(pmuMain);
  mniExit := TOfficeMenuItem.Create(pmuMain);
  with mniAbout do
  begin
    Name := 'mniAbout';
    Caption := sAbout + '...';
    OnClick := mniAboutClick;
  end;
  with mniUtils do
  begin
    Name := 'mniUtils';
    Caption := sUtilitiesMenu;
    OnClick := mniUtilsClick;
  end;
  with mniSetNXTName do
  begin
    Name := 'mniSetNXTName';
    Caption := sSetNXTName + '...';
    OnClick := mniSetNXTNameClick;
  end;
  with mniBootSAMBA do
  begin
    Name := 'mniBootSAMBA';
    Caption := sBootSAMBA + '...';
    OnClick := mniBootSAMBAClick;
  end;
  with mniBTReset do
  begin
    Name := 'mniBTReset';
    Caption := sResetBluetooth;
    OnClick := mniBTResetClick;
  end;
  with mniSep1 do
  begin
    Name := 'mniSep1';
    Caption := '-';
  end;
  with mniSave do
  begin
    Name := 'mniSave';
    Action := actSave;
  end;
  with mniSaveAs do
  begin
    Name := 'mniSaveAs';
    Action := actSaveAs;
  end;
  with mniCopy do
  begin
    Name := 'mniCopy';
    Action := actCopy;
  end;
  with mniSep2 do
  begin
    Name := 'mniSep2';
    Caption := '-';
  end;
  with mniPollNow do
  begin
    Name := 'mniPollNow';
    Action := actPollNow;
  end;
  with mniPoll do
  begin
    Name := 'mniPoll';
    Action := actPolling;
  end;
  with mniRefreshRate do
  begin
    Name := 'mniRefreshRate';
    Caption := sRefreshRate;
    OnClick := RefreshRateClick;
  end;
  with mni50ms do
  begin
    Name := 'mni50ms';
    Tag := 50;
    Action := act50ms;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mni100ms do
  begin
    Name := 'mni100ms';
    Tag := 100;
    Action := act100ms;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mni200ms do
  begin
    Name := 'mni200ms';
    Tag := 200;
    Action := act200ms;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mni500ms do
  begin
    Name := 'mni500ms';
    Tag := 500;
    Action := act500ms;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mni1sec do
  begin
    Name := 'mni1sec';
    Tag := 1000;
    Action := act1sec;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mni2sec do
  begin
    Name := 'mni2sec';
    Tag := 20;
    Action := act2sec;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mni5sec do
  begin
    Name := 'mni5sec';
    Tag := 30;
    Action := act5sec;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mni10sec do
  begin
    Name := 'mni10sec';
    Tag := 10000;
    Action := act10sec;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mni20sec do
  begin
    Name := 'mni20sec';
    Tag := 10;
    Action := act20sec;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mni1min do
  begin
    Name := 'mni1min';
    Tag := 40;
    Action := act1min;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mniCaptureAVI do
  begin
    Name := 'mniCaptureAVI';
    Action := actCaptureAVI;
  end;
  with mniPreferences do
  begin
    Name := 'mniPreferences';
    Action := actPrefs;
  end;
  with mniSep3 do
  begin
    Name := 'mniSep3';
    Caption := '-';
  end;
  with mniScale do
  begin
    Name := 'mniScale';
    Caption := sScale;
    OnClick := ScaleClick;
  end;
  with mni10x do
  begin
    Name := 'mni10x';
    Caption := '1x';
    GroupIndex := 3;
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni12x do
  begin
    Name := 'mni12x';
    Tag := 1;
    Caption := '1.25x';
    GroupIndex := 3;
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni15x do
  begin
    Name := 'mni15x';
    Tag := 2;
    Caption := '1.5x';
    GroupIndex := 3;
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni18x do
  begin
    Name := 'mni18x';
    Tag := 3;
    Caption := '1.75x';
    GroupIndex := 3;
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni20x do
  begin
    Name := 'mni20x';
    Tag := 4;
    Caption := '2x';
    GroupIndex := 3;
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni22x do
  begin
    Name := 'mni22x';
    Tag := 5;
    Caption := '2.25x';
    GroupIndex := 3;
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni25x do
  begin
    Name := 'mni25x';
    Tag := 6;
    Caption := '2.5x';
    Checked := True;
    GroupIndex := 3;
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni28x do
  begin
    Name := 'mni28x';
    Tag := 7;
    Caption := '2.75x';
    GroupIndex := 3;
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni30x do
  begin
    Name := 'mni30x';
    Tag := 8;
    Caption := '3x';
    GroupIndex := 3;
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni32x do
  begin
    Name := 'mni32x';
    Tag := 9;
    Caption := '3.25x';
    GroupIndex := 3;
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni35x do
  begin
    Name := 'mni35x';
    Tag := 10;
    Caption := '3.5x';
    GroupIndex := 3;
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni38x do
  begin
    Name := 'mni38x';
    Tag := 11;
    Caption := '3.75x';
    GroupIndex := 3;
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni40x do
  begin
    Name := 'mni40x';
    Tag := 12;
    Caption := '4x';
    GroupIndex := 3;
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mniSep4 do
  begin
    Name := 'mniSep4';
    Caption := '-';
  end;
  with mniDisplay do
  begin
    Name := 'mniDisplay';
    Caption := sDisplay;
  end;
  with mniDisplayNormal do
  begin
    Name := 'mniDisplayNormal';
    Caption := sNormal;
    Checked := True;
    GroupIndex := 4;
    RadioItem := True;
    OnClick := mniDisplayPopupClick;
  end;
  with mniDisplayPopup do
  begin
    Name := 'mniDisplayPopup';
    Caption := sPopup;
    GroupIndex := 4;
    RadioItem := True;
    OnClick := mniDisplayPopupClick;
  end;
  with mniSep5 do
  begin
    Name := 'mniSep5';
    Caption := '-';
  end;
  with mniPlayClicks do
  begin
    Name := 'mniPlayClicks';
    Caption := sPlayClicks;
    Checked := True;
    OnClick := mniPlayClicksClick;
  end;
  with mniSep6 do
  begin
    Name := 'mniSep6';
    Caption := '-';
  end;
  with mniExit do
  begin
    Name := 'mniExit';
    Caption := sExit;
    OnClick := mniExitClick;
  end;
  AddMenuItems(pmuMain.Items,
               [mniAbout, mniUtils, mniPreferences,
                mniSep1, mniSave, mniSaveAs, {$IFNDEF FPC}mniCopy, {$ENDIF}
                mniSep2, mniPollNow, mniPoll, mniRefreshRate, {$IFNDEF FPC}mniCaptureAVI, {$ENDIF}
                mniSep3, mniScale, mniSep4, mniDisplay,
                mniSep5, mniPlayClicks, mniSep6, mniExit]);
  AddMenuItems(mniUtils,[mniSetNXTName, mniBootSAMBA, mniBTReset]);
  AddMenuItems(mniRefreshRate, [mni50ms, mni100ms, mni200ms, mni500ms, mni1sec, mni2sec,
                      mni5sec, mni10sec, mni20sec, mni1min]);
  AddMenuItems(mniScale, [mni10x, mni12x, mni15x, mni18x, mni20x, mni22x, mni25x, mni28x,
                mni30x, mni32x, mni35x, mni38x, mni40x]);
  AddMenuItems(mniDisplay, [mniDisplayNormal, mniDisplayPopup]);
end;

function TfrmNXTImage.GetAutomaticFilename : string;
begin
  if NXTImageUseIndex then
    Result := Format(BaseNXTImageFilenameFormat + '%2.2d', [NXTImageIndex])
  else
    Result := BaseNXTImageFilenameFormat + FormatDateTime('yyyy-mm-dd''T''hh-mm-ss-zzz', Now);
  Result := Result + DefaultNXTImageFileExt;
end;

procedure TfrmNXTImage.actPrefsExecute(Sender: TObject);
var
  F : TfrmNXTImagePrefs;
begin
  F := TfrmNXTImagePrefs.Create(nil);
  try
    F.BackgroundColor := LCDBackgroundColor;
    F.BaseFilename    := BaseNXTImageFilenameFormat;
    F.ImageDirectory  := DefaultNXTImageDirectory;
    F.ImageExt        := DefaultNXTImageFileExt;
    F.UseIndex        := NXTImageUseIndex;
    F.CurrentIndex    := NXTImageIndex;
    if F.ShowModal = mrOK then
    begin
      LCDBackgroundColor         := F.BackgroundColor;
      BaseNXTImageFilenameFormat := F.BaseFilename;
      DefaultNXTImageDirectory   := F.ImageDirectory;
      DefaultNXTImageFileExt     := F.ImageExt;
      NXTImageUseIndex           := F.UseIndex;
      NXTImageIndex              := F.CurrentIndex;
    end;
  finally
    F.Free;
  end;
end;

procedure TfrmNXTImage.FormShow(Sender: TObject);
begin
  ScaleForm(NXTImageScale);
  tmrRefresh.Interval := NXTImageDefaultRefreshRate;
  fMovieWriter.MaxFramesPerMovie := NXTImageMaxFramesPerMovie;
  dlgSavePic.InitialDir := DefaultNXTImageDirectory;
end;

{$IFDEF FPC}
initialization
  {$i uNXTImage.lrs}
{$ENDIF}

end.
