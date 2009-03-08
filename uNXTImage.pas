unit uNXTImage;

interface

uses
  Windows, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, Menus,
  uOfficeComp, ExtDlgs, ActnList, StdCtrls, AviWriter;

type
  TfrmNXTImage = class(TForm)
    imgNXT: TImage;
    shpEnter: TShape;
    shpExit: TShape;
    imgScreen: TImage;
    tmrRefresh: TTimer;
    dlgSavePic: TSavePictureDialog;
    ActionList1: TActionList;
    actSave: TAction;
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
    procedure tmrRefreshTimer(Sender: TObject);
    procedure mniExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure shpEnterMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shpExitMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgNXTMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RescaleClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mniAboutClick(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
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
  private
    pmuMain: TOfficePopupMenu;
    mniAbout: TOfficeMenuItem;
    mniUtils: TOfficeMenuItem;
    mniSetNXTName: TOfficeMenuItem;
    mniBootSAMBA: TOfficeMenuItem;
    mniBTReset: TOfficeMenuItem;
    mniSep1: TOfficeMenuItem;
    mniSave: TOfficeMenuItem;
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
    fLeftRegion : HRGN;
    fRightRegion : HRGN;
    LeftPoints : array[0..2] of TPoint;
    RightPoints : array[0..2] of TPoint;
    fDisplayNormal : boolean;
    fGoodRead : boolean;
    fGC : TGraphicClass;
    fClickStream : TMemoryStream;
    fCurrentName : string;
    fAviWriter : TAviWriter;
    procedure RefreshImage;
    procedure RetrieveScreenBytes;
    procedure DrawImage;
    function GetPixelColor(b : byte; bit : integer) : TColor;
    procedure ExecuteButton(const btn : integer);
    procedure ScaleForm(const i : integer);
    procedure FreeRegions;
    procedure CreateRegions(const factor : double);
    procedure ResizeImage;
    procedure DoClick;
    function GraphicClassFromExt(const ext: string): TGraphicClass;
    procedure CheckForCustomClick;
    function GetCurrentName: string;
    procedure SetCurrentName(const Value: string);
  protected
    property CurrentName : string read GetCurrentName write SetCurrentName;
  public
    { Public declarations }
  end;

var
  frmNXTImage: TfrmNXTImage;

implementation

{$R *.dfm}

uses
  SysUtils, Themes, Math, Clipbrd, JPEG, MMSystem, uGuiUtils, uSpirit,
  brick_common, uNXTConstants, rcx_constants, pngimage, GIFImage, uRICImage,
  uNXTName, uLocalizedStrings;

procedure TfrmNXTImage.tmrRefreshTimer(Sender: TObject);
begin
  if not fBusy and Visible and (WindowState <> wsMinimized) then
    RefreshImage;
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
  bmp, aviBmp : TBitmap;
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
      aviBmp := TBitmap.Create;
      aviBmp.Assign(imgScreen.Picture.Bitmap);
      fAviWriter.Bitmaps.Add(aviBmp);
    end;
  finally
    bmp.Free;
  end;
end;

function TfrmNXTImage.GetPixelColor(b: byte; bit: integer): TColor;
var
  val : byte;
begin
  Result := clWhite;
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
  imgNXT.PopupMenu := pmuMain;
  fAviWriter := TAviWriter.Create(Self);
  fCurrentName := '';
  fDisplayNormal := True;
  imgNXT.Picture.Bitmap.FreeImage;
  Self.DoubleBuffered := True;
  fLeftRegion := 0;
  fRightRegion := 0;
  ScaleForm(6);    // 2.5x
  dlgSavePic.Filter :=
    'All (*.ric;*.png;*.jpg;*.jpeg;*.gif;*.bmp)|*.ric;*.png;*.jpg;*.jpeg;*.gif;*.bmp|' +
    'NXT Icon File (*.ric)|*.ric|' +
    'Portable Network Graphics (*.png)|*.png|' +
    'JPEG Image File (*.jpg)|*.jpg|' +
    'JPEG Image File (*.jpeg)|*.jpeg|' +
    'GIF Image File (*.gif)|*.gif|' +
    'Bitmaps (*.bmp)|*.bmp';
  dlgSavePic.FilterIndex := 7;
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

procedure TfrmNXTImage.imgNXTMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    if PtInRegion(fLeftRegion, X, Y) then
      ExecuteButton(1)
    else if PtInRegion(fRightRegion, X, Y) then
      ExecuteButton(3);
  end;
end;

procedure TfrmNXTImage.RescaleClick(Sender: TObject);
begin
  TOfficeMenuItem(Sender).Checked := True;
  ScaleForm(TOfficeMenuItem(Sender).Tag);
end;

const
  NxtWidth    = 429;
  NxtHeight   = 662;
  ScrnLeft    = 89;
  ScrnTop     = 129;
  ScrnWidth   = 250;
  ScrnHeight  = 160;
  EnterLeft   = 182;
  EnterTop    = 363;
  EnterWidth  = 62;
  EnterHeight = 62;
  ExitLeft    = 182;
  ExitTop     = 451;
  ExitWidth   = 62;
  ExitHeight  = 38;

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
  imgNXT.Height    := Trunc(NxtHeight * factor);
  ClientWidth      := imgNXT.Width;
  ClientHeight     := imgNXT.Height;
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
  FreeRegions;
  CreateRegions(factor);
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
  FreeRegions;
end;

const
  LX1 = 100;
  LX2 = 154;
  RX1 = 324;
  RX2 = 274;
  Y1 = 392;
  Y2 = 360;
  Y3 = 426;

procedure TfrmNXTImage.CreateRegions(const factor: double);
begin
  LeftPoints[0] := Point(Trunc(LX1*factor), Trunc(Y1*factor));
  LeftPoints[1] := Point(Trunc(LX2*factor), Trunc(Y2*factor));
  LeftPoints[2] := Point(Trunc(LX2*factor), Trunc(Y3*factor));
  RightPoints[0] := Point(Trunc(RX1*factor), Trunc(Y1*factor));
  RightPoints[1] := Point(Trunc(RX2*factor), Trunc(Y2*factor));
  RightPoints[2] := Point(Trunc(RX2*factor), Trunc(Y3*factor));
  fLeftRegion  := CreatePolygonRgn(LeftPoints, 3, WINDING);
  fRightRegion := CreatePolygonRgn(RightPoints, 3, WINDING);
end;

procedure TfrmNXTImage.FreeRegions;
begin
  if fLeftRegion <> 0 then
  begin
    DeleteObject(fLeftRegion);
    fLeftRegion := 0;
  end;
  if fRightRegion <> 0 then
  begin
    DeleteObject(fRightRegion);
    fRightRegion := 0;
  end;
end;

procedure TfrmNXTImage.mniAboutClick(Sender: TObject);
begin
  ShowMessage('NeXT Screen'#13#10'Copyright 2007, John C. Hansen');
end;

procedure TfrmNXTImage.actSaveExecute(Sender: TObject);
var
  G : TGraphic;
  ext : string;
begin
  fBusy := True;
  try
    fGC := TBitmap;
    if dlgSavePic.Execute then
    begin
      ext := LowerCase(ExtractFileExt(dlgSavePic.FileName));
      if dlgSavePic.FilterIndex = 1 then
        fGC := GraphicClassFromExt(ext);
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
var
  fmt : Word;
  data : THandle;
  palette : HPALETTE;
begin
  imgScreen.Picture.Bitmap.SaveToClipboardFormat(fmt, data, palette);
  Clipboard.SetAsHandle(fmt, data);
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
  tmrRefresh.Interval := TControl(Sender).Tag;
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
  if mniPlayClicks.Checked then
  begin
    GetMem(buf, fClickStream.Size);
    try
      MoveMemory(buf, fClickStream.Memory, fClickStream.Size);
      PlaySound(buf, Application.Handle, SND_MEMORY);
    finally
      FreeMem(buf);
    end;
  end;
end;

procedure TfrmNXTImage.dlgSavePicTypeChange(Sender: TObject);
begin
  case dlgSavePic.FilterIndex of
    2    : fGC := TRICObject;
    3    : fGC := TPNGObject;
    4, 5 : fGC := TJPEGImage;
    6    : fGC := TGIFImage;
    7    : fGC := TBitmap;
  else
    fGC := TBitmap;
  end;
end;

function TfrmNXTImage.GraphicClassFromExt(const ext: string): TGraphicClass;
begin
  if (ext = '.jpg') or (ext = '.jpeg') then
    Result := TJPEGImage
  else if (ext = '.gif') then
    Result := TGIFImage
  else if (ext = '.ric') then
    Result := TRICObject
  else if (ext = '.png') then
    Result := TPNGObject
  else
    Result := TBitmap;
end;

procedure TfrmNXTImage.CheckForCustomClick;
var
  RS : TResourceStream;
begin
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
      fAviWriter.Bitmaps.Clear;
      fAviWriter.FileName  := dlgSaveAVI.FileName;
      fAviWriter.FrameTime := tmrRefresh.Interval;
      fAviWriter.Height    := imgScreen.Height;
      fAviWriter.Width     := imgScreen.Width;
      fAviWriter.Stretch   := True;
    end
    else
    begin
      // finished recording
      fAviWriter.Write;
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
  pmuMain.Items.Add([mniAbout, mniUtils, mniSep1, mniSave, mniCopy, mniSep2,
                     mniPollNow, mniPoll, mniRefreshRate, mniCaptureAVI,
                     mniSep3, mniScale, mniSep4, mniDisplay, mniSep5,
                     mniPlayClicks, mniSep6, mniExit]);
  mniUtils.Add([mniSetNXTName, mniBootSAMBA, mniBTReset]);
  mniRefreshRate.Add([mni50ms, mni100ms, mni200ms, mni500ms, mni1sec, mni2sec,
                      mni5sec, mni10sec, mni20sec, mni1min]);
  mniScale.Add([mni10x, mni12x, mni15x, mni18x, mni20x, mni22x, mni25x, mni28x,
                mni30x, mni32x, mni35x, mni38x, mni40x]);
  mniDisplay.Add([mniDisplayNormal, mniDisplayPopup]);
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
  with mniSep3 do
  begin
    Name := 'mniSep3';
    Caption := '-';
  end;
  with mniScale do
  begin
    Name := 'mniScale';
    Caption := sScale;
  end;
  with mni10x do
  begin
    Name := 'mni10x';
    Caption := '1x';
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni12x do
  begin
    Name := 'mni12x';
    Tag := 1;
    Caption := '1.25x';
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni15x do
  begin
    Name := 'mni15x';
    Tag := 2;
    Caption := '1.5x';
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni18x do
  begin
    Name := 'mni18x';
    Tag := 3;
    Caption := '1.75x';
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni20x do
  begin
    Name := 'mni20x';
    Tag := 4;
    Caption := '2x';
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni22x do
  begin
    Name := 'mni22x';
    Tag := 5;
    Caption := '2.25x';
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni25x do
  begin
    Name := 'mni25x';
    Tag := 6;
    Caption := '2.5x';
    Checked := True;
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni28x do
  begin
    Name := 'mni28x';
    Tag := 7;
    Caption := '2.75x';
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni30x do
  begin
    Name := 'mni30x';
    Tag := 8;
    Caption := '3x';
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni32x do
  begin
    Name := 'mni32x';
    Tag := 9;
    Caption := '3.25x';
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni35x do
  begin
    Name := 'mni35x';
    Tag := 10;
    Caption := '3.5x';
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni38x do
  begin
    Name := 'mni38x';
    Tag := 11;
    Caption := '3.75x';
    RadioItem := True;
    OnClick := RescaleClick;
  end;
  with mni40x do
  begin
    Name := 'mni40x';
    Tag := 12;
    Caption := '4x';
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
    RadioItem := True;
    OnClick := mniDisplayPopupClick;
  end;
  with mniDisplayPopup do
  begin
    Name := 'mniDisplayPopup';
    Caption := sPopup;
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
end;

end.
