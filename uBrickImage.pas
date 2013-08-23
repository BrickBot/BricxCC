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
unit uBrickImage;

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

  TfrmBrickImage = class(TForm)
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
    dlgSavePic: TSaveDialog;
    actSave: TAction;
    actPrefs: TAction;
    imgEV3: TImage;
    procedure tmrRefreshTimer(Sender: TObject);
    procedure mniExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
    procedure RefreshRateClick(Sender: TObject);
    procedure shpEnterClick(Sender: TObject);
    procedure shpExitClick(Sender: TObject);
    procedure shpLeft2Click(Sender: TObject);
    procedure shpRight2Click(Sender: TObject);
  private
    pmuMain: TOfficePopupMenu;
    mniAbout: TOfficeMenuItem;
    mniUtils: TOfficeMenuItem;
    mniSetNXTName: TOfficeMenuItem;
//    mniBootSAMBA: TOfficeMenuItem;
//    mniBTReset: TOfficeMenuItem;
    mniSep1: TOfficeMenuItem;
    mniSave: TOfficeMenuItem;
    mniSaveAs: TOfficeMenuItem;
    mniCopy: TOfficeMenuItem;
    mniSep2: TOfficeMenuItem;
    mniPollNow: TOfficeMenuItem;
    mniPoll: TOfficeMenuItem;
    mniRefreshRate: TOfficeMenuItem;
//    mni50ms: TOfficeMenuItem;
//    mni100ms: TOfficeMenuItem;
//    mni200ms: TOfficeMenuItem;
//    mni500ms: TOfficeMenuItem;
    mni1sec: TOfficeMenuItem;
    mni2sec: TOfficeMenuItem;
    mni5sec: TOfficeMenuItem;
    mni10sec: TOfficeMenuItem;
    mni20sec: TOfficeMenuItem;
    mni1min: TOfficeMenuItem;
    mniCaptureAVI: TOfficeMenuItem;
    mniPreferences: TOfficeMenuItem;
//    mniSep3: TOfficeMenuItem;
//    mniDisplay: TOfficeMenuItem;
//    mniDisplayNormal: TOfficeMenuItem;
//    mniDisplayPopup: TOfficeMenuItem;
//    mniSep5: TOfficeMenuItem;
//    mniPlayClicks: TOfficeMenuItem;
    mniSep6: TOfficeMenuItem;
    mniExit: TOfficeMenuItem;
    procedure CreatePopupMenu;
  private
    { Private declarations }
    fBytes : array of byte;
    fBusy : boolean;
    fDisplayNormal : boolean;
    fGoodRead : boolean;
    fGC : TGraphicClass;
    fClickStream : TMemoryStream;
    fCurrentName : string;
    fMovieWriter : TNXTImageMovie;
    procedure SetImageSizeByBrickType;
    function ImageBufferSize : integer;
    procedure RefreshImage;
    procedure RetrieveScreenBytes;
    procedure DrawImage;
    procedure ExecuteButton(const btn : integer);
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
  frmBrickImage: TfrmBrickImage;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

uses
  SysUtils, Themes, Clipbrd, Math,
  {$IFNDEF FPC}
  JPEG, MMSystem, pngimage, GIFImage, uRICImage,
  {$ENDIF}
  uGuiUtils, uSpirit, uGlobals,
  brick_common, uNXTConstants, rcx_constants, uDebugLogging,
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

procedure TfrmBrickImage.tmrRefreshTimer(Sender: TObject);
begin
  if not fBusy and Visible and (WindowState <> wsMinimized) then
    RefreshImage;
end;

procedure TfrmBrickImage.RefreshImage;
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

procedure TfrmBrickImage.DrawImage;
var
  b : byte;
  i, x, line : integer;
  bmp : TBitmap;
begin
  bmp := TBitmap.Create;
  try
    if IsNXT then
    begin
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
    end
    else if IsEV3 then
    begin
      bmp.Width  := 178;
      bmp.Height := 128;
      for line := 0 to 127 do
      begin
        for x := 0 to 22 do
        begin
          b := fBytes[line*23 + x];
          for i := 0 to 7 do
          begin
            bmp.Canvas.Pixels[x*8+i, line] := GetPixelColor(b, i);
          end;
        end;
        // last 2 bits of each line
        x := 23;
        b := fBytes[line*23 + x];
        for i := 0 to 1 do
        begin
          bmp.Canvas.Pixels[x*8+i, line] := GetPixelColor(b, i);
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

procedure TfrmBrickImage.RetrieveScreenBytes;
var
  idx, i, totalBytes, iterations, bytesPerIteration : integer;
  offset, count : word;
  modID : Cardinal;
  b : PBRDataBuffer;
begin
  totalBytes := ImageBufferSize;
  if IsEV3 then
  begin
    iterations := 4;
  end
  else
  begin
    // NXT
    iterations := 16;
  end;
  bytesPerIteration := totalBytes div iterations;
  FillChar(fBytes[0], totalBytes, 0); // clear the array of bytes
  idx := 0;
  if fDisplayNormal then
    offset := DisplayOffsetNormal(0, 0)
  else
    offset := DisplayOffsetPopup(0, 0);
  modID := kNXT_ModuleDisplay;
  for i := 0 to iterations - 1 do
  begin
    count := bytesPerIteration;
    fGoodRead := BrickComm.SCReadIOMap(modID, offset, count, b);
    if not fGoodRead then
      break;
    Move(b.Data[0], fBytes[idx], count);
    inc(offset, count);
    inc(idx, count);
  end;
end;

procedure TfrmBrickImage.mniExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBrickImage.FormCreate(Sender: TObject);
begin
  SetLength(fBytes, ImageBufferSize);
  CreatePopupMenu;
  PopupMenu := pmuMain;
  imgScreen.PopupMenu := pmuMain;
  lblInfo.PopupMenu   := pmuMain;
  imgEV3.PopupMenu    := pmuMain;
  fMovieWriter := TNXTImageMovie.Create(Self);
  fMovieWriter.MaxFramesPerMovie := NXTImageMaxFramesPerMovie;
  fCurrentName := '';
  fDisplayNormal := True;
  Self.DoubleBuffered := True;
  tmrRefresh.Interval := Max(NXTImageDefaultRefreshRate, 1000);
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

procedure TfrmBrickImage.ExecuteButton(const btn: integer);
var
  offset : word;
  modID : Cardinal;
  count : word;
  b : PBRDataBuffer;
begin
  modID  := kNXT_ModuleUI;
  offset := UIOffsetButton;
  count  := 1;
  b.Data[0] := btn;
  BrickComm.SCWriteIOMap(modID, offset, count, b);
  DoClick;
end;

procedure TfrmBrickImage.RefreshRateClick(Sender: TObject);
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

procedure TfrmBrickImage.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fClickStream);
end;

procedure TfrmBrickImage.mniAboutClick(Sender: TObject);
begin
  ShowMessage('Brick Screen'#13#10'Copyright 2007-2013, John C. Hansen');
end;

procedure TfrmBrickImage.actSaveExecute(Sender: TObject);
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

procedure TfrmBrickImage.actSaveAsExecute(Sender: TObject);
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

procedure TfrmBrickImage.actCopyExecute(Sender: TObject);
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

procedure TfrmBrickImage.actPollNowExecute(Sender: TObject);
begin
  tmrRefreshTimer(Sender);
end;

procedure TfrmBrickImage.actPollingExecute(Sender: TObject);
begin
  actPolling.Checked := not actPolling.Checked;
  tmrRefresh.Enabled := actPolling.Checked;
end;

procedure TfrmBrickImage.actRefreshExecute(Sender: TObject);
begin
  if Sender is TAction then
    TAction(Sender).Checked := True
  else if Sender is TOfficeMenuItem then
    TOfficeMenuItem(Sender).Checked := True;
  NXTImageDefaultRefreshRate := TControl(Sender).Tag;
  tmrRefresh.Interval := NXTImageDefaultRefreshRate;
end;

procedure TfrmBrickImage.HandleKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmBrickImage.mniDisplayPopupClick(Sender: TObject);
begin
  TOfficeMenuItem(Sender).Checked := True;
//  fDisplayNormal := mniDisplayNormal.Checked;
end;

procedure TfrmBrickImage.DoClick;
//var
//  buf : PChar;
begin
{$IFNDEF FPC}
{
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
}
{$ENDIF}
end;

procedure TfrmBrickImage.dlgSavePicTypeChange(Sender: TObject);
begin
  fGC := GraphicClassFromFilterIndex(dlgSavePic.FilterIndex);
  dlgSavePic.DefaultExt := GetExtFromFilterIndex(dlgSavePic.FilterIndex);
end;

function TfrmBrickImage.GraphicClassFromExt(ext: string): TGraphicClass;
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

function TfrmBrickImage.GraphicClassFromFilterIndex(const idx: integer): TGraphicClass;
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

function TfrmBrickImage.GetFilterIndexFromExt(ext: string): integer;
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

function TfrmBrickImage.GetExtFromFilterIndex(const idx: integer): string;
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

procedure TfrmBrickImage.CheckForCustomClick;
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

procedure TfrmBrickImage.mniPlayClicksClick(Sender: TObject);
begin
//  mniPlayClicks.Checked := not mniPlayClicks.Checked;
end;

procedure TfrmBrickImage.mniSetNXTNameClick(Sender: TObject);
var
  F : TfrmNXTName;
begin
  F := TfrmNXTName.Create(self);
  try
    F.edtNXTName.Text := CurrentName;
    if F.ShowModal = mrOK then
    begin
      BrickComm.SCSetBrickName(F.edtNXTName.Text, True);
      CurrentName := F.edtNXTName.Text;
    end;
  finally
    F.Free;
  end;
end;

procedure TfrmBrickImage.mniBootSAMBAClick(Sender: TObject);
begin
  if MessageDlg(sBootSAMBAConfirm, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    BrickComm.SCBootCommand(True);
  end;
end;

procedure TfrmBrickImage.mniBTResetClick(Sender: TObject);
begin
  if MessageDlg(sBTResetConfirm, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    BrickComm.SCBTFactoryReset(True);
  end;
end;

procedure TfrmBrickImage.mniUtilsClick(Sender: TObject);
begin
//  mniBootSAMBA.Enabled := not BrickComm.UseBluetooth;
//  mniBTReset.Enabled   := mniBootSAMBA.Enabled;
end;

function TfrmBrickImage.GetCurrentName: string;
begin
  if fCurrentName = '' then
    fCurrentName := BrickComm.SCGetBrickName;
  Result := fCurrentName;
end;

procedure TfrmBrickImage.SetCurrentName(const Value: string);
begin
  fCurrentName := Value;
end;

procedure TfrmBrickImage.actCaptureAVIExecute(Sender: TObject);
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

procedure TfrmBrickImage.CreatePopupMenu;
begin
  pmuMain := TOfficePopupMenu.Create(Self);
  pmuMain.Name := 'pmuMain';
  mniAbout := TOfficeMenuItem.Create(pmuMain);
  mniUtils := TOfficeMenuItem.Create(pmuMain);
  mniSetNXTName := TOfficeMenuItem.Create(mniUtils);
//  mniBootSAMBA := TOfficeMenuItem.Create(mniUtils);
//  mniBTReset := TOfficeMenuItem.Create(mniUtils);
  mniSep1 := TOfficeMenuItem.Create(pmuMain);
  mniSave := TOfficeMenuItem.Create(pmuMain);
  mniSaveAs := TOfficeMenuItem.Create(pmuMain);
  mniCopy := TOfficeMenuItem.Create(pmuMain);
  mniSep2 := TOfficeMenuItem.Create(pmuMain);
  mniPollNow := TOfficeMenuItem.Create(pmuMain);
  mniPoll := TOfficeMenuItem.Create(pmuMain);
  mniRefreshRate := TOfficeMenuItem.Create(pmuMain);
//  mni50ms := TOfficeMenuItem.Create(mniRefreshRate);
//  mni100ms := TOfficeMenuItem.Create(mniRefreshRate);
//  mni200ms := TOfficeMenuItem.Create(mniRefreshRate);
//  mni500ms := TOfficeMenuItem.Create(mniRefreshRate);
  mni1sec := TOfficeMenuItem.Create(mniRefreshRate);
  mni2sec := TOfficeMenuItem.Create(mniRefreshRate);
  mni5sec := TOfficeMenuItem.Create(mniRefreshRate);
  mni10sec := TOfficeMenuItem.Create(mniRefreshRate);
  mni20sec := TOfficeMenuItem.Create(mniRefreshRate);
  mni1min := TOfficeMenuItem.Create(mniRefreshRate);
  mniCaptureAVI := TOfficeMenuItem.Create(pmuMain);
  mniPreferences := TOfficeMenuItem.Create(pmuMain);
//  mniSep3 := TOfficeMenuItem.Create(pmuMain);
//  mniDisplay := TOfficeMenuItem.Create(pmuMain);
//  mniDisplayNormal := TOfficeMenuItem.Create(mniDisplay);
//  mniDisplayPopup := TOfficeMenuItem.Create(mniDisplay);
//  mniSep5 := TOfficeMenuItem.Create(pmuMain);
//  mniPlayClicks := TOfficeMenuItem.Create(pmuMain);
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
{
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
}
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
{
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
}
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
{
  with mniCaptureAVI do
  begin
    Name := 'mniCaptureAVI';
    Action := actCaptureAVI;
  end;
}
  with mniPreferences do
  begin
    Name := 'mniPreferences';
    Action := actPrefs;
  end;
{
  with mniSep3 do
  begin
    Name := 'mniSep3';
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
}
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
                {mniSep3, mniDisplay,
                mniSep5, mniPlayClicks,} mniSep6, mniExit]);
  AddMenuItems(mniUtils,[mniSetNXTName{, mniBootSAMBA, mniBTReset}]);
  AddMenuItems(mniRefreshRate, [{mni50ms, mni100ms, mni200ms, mni500ms, }mni1sec, mni2sec,
                      mni5sec, mni10sec, mni20sec, mni1min]);
//  AddMenuItems(mniDisplay, [mniDisplayNormal, mniDisplayPopup]);
end;

function TfrmBrickImage.GetAutomaticFilename : string;
begin
  if NXTImageUseIndex then
    Result := Format(BaseNXTImageFilenameFormat + '%2.2d', [NXTImageIndex])
  else
    Result := BaseNXTImageFilenameFormat + FormatDateTime('yyyy-mm-dd''T''hh-mm-ss-zzz', Now);
  Result := Result + DefaultNXTImageFileExt;
end;

procedure TfrmBrickImage.actPrefsExecute(Sender: TObject);
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

procedure TfrmBrickImage.SetImageSizeByBrickType;
begin
  imgScreen.Picture.Assign(nil);
{
  if IsEV3 then
  begin
    imgScreen.Width  := 356;
    imgScreen.Height := 256;
  end
  else
  begin
    imgScreen.Width  := 300;
    imgScreen.Height := 192;
  end;
  imgScreen.Left := (Width - imgScreen.Width) div 2;
  imgScreen.Top  := shpBack.Top + ((shpBack.Height - imgScreen.Height) div 2);
}
end;

procedure TfrmBrickImage.FormShow(Sender: TObject);
var
  len : integer;
begin
//  pnlNXTButtons.Visible := IsNXT;
  len := ImageBufferSize;
  if Length(fBytes) <> len then
    SetLength(fBytes, ImageBufferSize);
  SetImageSizeByBrickType;
  tmrRefresh.Interval := NXTImageDefaultRefreshRate;
  fMovieWriter.MaxFramesPerMovie := NXTImageMaxFramesPerMovie;
  dlgSavePic.InitialDir := DefaultNXTImageDirectory;
end;

procedure TfrmBrickImage.shpEnterClick(Sender: TObject);
begin
  ExecuteButton(2);
end;

procedure TfrmBrickImage.shpExitClick(Sender: TObject);
begin
  ExecuteButton(4);
end;

procedure TfrmBrickImage.shpLeft2Click(Sender: TObject);
begin
  ExecuteButton(1);
end;

procedure TfrmBrickImage.shpRight2Click(Sender: TObject);
begin
  ExecuteButton(3);
end;

function TfrmBrickImage.ImageBufferSize : integer;
begin
  if IsEV3 then
    Result := 2944
  else
    Result := 800;
end;

initialization
{$IFDEF FPC}
  {$i uBrickImage.lrs}
{$ENDIF}

end.