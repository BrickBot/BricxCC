unit uNXTScreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BricxccSpin, ExtCtrls, Menus, ExtDlgs, uOfficeComp;

type
  TfrmNXTScreen = class(TForm)
    imgScreen: TImage;
    tmrRefresh: TTimer;
    dlgSavePic: TSavePictureDialog;
    mnuMain: TOfficeMainMenu;
    mniFile: TOfficeMenuItem;
    mniEdit: TOfficeMenuItem;
    mniCopy: TOfficeMenuItem;
    mniSave: TOfficeMenuItem;
    mniOptions: TOfficeMenuItem;
    mniScale: TOfficeMenuItem;
    mni1x: TOfficeMenuItem;
    mni2x: TOfficeMenuItem;
    mni3x: TOfficeMenuItem;
    mni4x: TOfficeMenuItem;
    mniSep4: TOfficeMenuItem;
    mniExit: TOfficeMenuItem;
    mniPoll: TOfficeMenuItem;
    mniSep2: TOfficeMenuItem;
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
    cbrScreenTop: TOfficeControlBar;
    ogpNXTScreen: TOfficeGradientPanel;
    osbCopy: TOfficeSpeedButton;
    osbSave: TOfficeSpeedButton;
    bvlFile2: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    osbPolling: TOfficeSpeedButton;
    pmuMain: TOfficePopupMenu;
    pnlRates: TPanel;
    cboRates: TComboBox;
    Bevel4: TBevel;
    pnlScale: TPanel;
    cboScale: TComboBox;
    Bevel1: TBevel;
    mniPopCopy: TOfficeMenuItem;
    mniPopSave: TOfficeMenuItem;
    btnLeft: TButton;
    btnEnter: TButton;
    btnRight: TButton;
    btnExit: TButton;
    mniPollNow: TOfficeMenuItem;
    osbPollNow: TOfficeSpeedButton;
    mniSep1: TOfficeMenuItem;
    mniDisplay: TOfficeMenuItem;
    mniDisplayNormal: TOfficeMenuItem;
    mniPopup: TOfficeMenuItem;
    lblNXTOff: TLabel;
    mniSep3: TOfficeMenuItem;
    mniPlayClicks: TOfficeMenuItem;
    procedure tmrRefreshTimer(Sender: TObject);
    procedure chk1xClick(Sender: TObject);
    procedure mniCopyClick(Sender: TObject);
    procedure mniSaveClick(Sender: TObject);
    procedure RefreshRateClick(Sender: TObject);
    procedure mniPollClick(Sender: TObject);
    procedure ScaleClick(Sender: TObject);
    procedure mniExitClick(Sender: TObject);
    procedure cboScaleChange(Sender: TObject);
    procedure cboRatesChange(Sender: TObject);
    procedure mniRefreshRateClick(Sender: TObject);
    procedure mniScaleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NXTbuttonClick(Sender: TObject);
    procedure mniPopupClick(Sender: TObject);
    procedure dlgSavePicTypeChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fBytes : array[0..799] of byte;
    fBusy : boolean;
    fDisplayNormal : boolean;
    fGoodRead : boolean;
    fGC : TGraphicClass;
    fCustomClick : boolean;
    fClickStream : TMemoryStream;
    procedure RefreshImage;
    procedure RetrieveScreenBytes;
    procedure DrawImage;
    function GetPixelColor(b : byte; bit : integer) : TColor;
    procedure ResizeImage;
    function IndexToInterval(const idx : integer) : integer;
    procedure UpdateControls;
    function ScaleToIndex : integer;
    function RateToIndex : integer;
    procedure UpdateMenuItems;
    procedure SetColorScheme;
    procedure ExecuteButton(const btn: integer);
    procedure DoClick;
    function  GraphicClassFromExt(const ext : string) : TGraphicClass;
    procedure CheckForCustomClick;
  public
    { Public declarations }
  end;

var
  frmNXTScreen: TfrmNXTScreen;

implementation

{$R *.dfm}

uses
  Themes, uGuiUtils, uSpirit, brick_common, uNXTConstants, rcx_constants,
  Clipbrd, jpeg, pngimage, uRICImage, MMSystem;

procedure TfrmNXTScreen.tmrRefreshTimer(Sender: TObject);
begin
  if not fBusy and Visible and (WindowState <> wsMinimized) then
    RefreshImage;
end;

procedure TfrmNXTScreen.RefreshImage;
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

procedure TfrmNXTScreen.DrawImage;
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
  finally
    bmp.Free;
  end;
end;

procedure TfrmNXTScreen.RetrieveScreenBytes;
var
  idx, i : integer;
  offset : word;
  modID : Cardinal;
  count : word;
  b : NXTDataBuffer;
begin
  FillChar(fBytes[0], 800, 0); // clear the array of bytes
  idx := 0;
  if fDisplayNormal then
    offset := DisplayOffsetNormal(0, 0)
  else
    offset := DisplayOffsetPopup(0, 0);
  modID := kNXT_ModuleDisplay;
  for i := 0 to 19 do
  begin
    count := 40;
    fGoodRead := BrickComm.NXTReadIOMap(modID, offset, count, b);
    if not fGoodRead then
      break;
    Move(b.Data[0], fBytes[idx], count);
    inc(offset, count);
    inc(idx, count);
  end;
end;

function TfrmNXTScreen.GetPixelColor(b: byte; bit: integer): TColor;
var
  val : byte;
begin
  Result := clWhite;
  val := 1 shl bit;
  if (b and val) = val then
    Result := clBlack;
end;

procedure TfrmNXTScreen.chk1xClick(Sender: TObject);
begin
  ResizeImage;
end;

procedure TfrmNXTScreen.ResizeImage;
var
  scale : integer;
  bmp : TBitmap;
begin
  if mni4x.Checked then
  begin
    scale := 4;
  end
  else if mni3x.Checked then
  begin
    scale := 3;
  end
  else if mni2x.Checked then
  begin
    scale := 2;
  end
  else
  begin
    scale := 1;
  end;
  bmp := TBitmap.Create;
  bmp.Width  := scale * 100;
  bmp.Height := scale * 64;
  imgScreen.Picture.Bitmap := bmp;
  imgScreen.Width  := scale * 100;
  imgScreen.Height := scale * 64;
  DrawImage;
end;

procedure TfrmNXTScreen.mniCopyClick(Sender: TObject);
var
  fmt : Word;
  data : THandle;
  palette : HPALETTE;
begin
  imgScreen.Picture.Bitmap.SaveToClipboardFormat(fmt, data, palette);
  Clipboard.SetAsHandle(fmt, data);
end;

procedure TfrmNXTScreen.mniSaveClick(Sender: TObject);
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

procedure TfrmNXTScreen.RefreshRateClick(Sender: TObject);
begin
  TOfficeMenuItem(Sender).Checked := True;
  tmrRefresh.Interval := TOfficeMenuItem(Sender).Tag;
  UpdateControls;
end;

procedure TfrmNXTScreen.mniPollClick(Sender: TObject);
begin
  mniPoll.Checked := not mniPoll.Checked;
  tmrRefresh.Enabled := mniPoll.Checked;
  osbPolling.Down := tmrRefresh.Enabled;
end;

procedure TfrmNXTScreen.ScaleClick(Sender: TObject);
begin
  TOfficeMenuItem(Sender).Checked := True;
  ResizeImage;
  UpdateControls;
end;

procedure TfrmNXTScreen.mniExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmNXTScreen.cboScaleChange(Sender: TObject);
begin
  UpdateMenuItems;
  ResizeImage;
end;

procedure TfrmNXTScreen.cboRatesChange(Sender: TObject);
begin
  UpdateMenuItems;
  tmrRefresh.Interval := IndexToInterval(cboRates.ItemIndex);
end;

function TfrmNXTScreen.IndexToInterval(const idx: integer): integer;
const
  Intervals : array[0..9] of integer = (50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 60000);
begin
  if (idx >= Low(Intervals)) and (idx <= High(Intervals)) then
    Result := Intervals[idx]
  else
    Result := 1000;
end;

procedure TfrmNXTScreen.UpdateControls;
begin
  cboScale.ItemIndex := ScaleToIndex;
  cboRates.ItemIndex := RateToIndex;
end;

function TfrmNXTScreen.ScaleToIndex: integer;
begin
  if mni1x.Checked then
    Result := 0
  else if mni2x.Checked then
    Result := 1
  else if mni3x.Checked then
    Result := 2
  else
    Result := 3;
end;

function TfrmNXTScreen.RateToIndex: integer;
begin
  if mni50ms.Checked then
    Result := 0
  else if mni100ms.Checked then
    Result := 1
  else if mni200ms.Checked then
    Result := 2
  else if mni500ms.Checked then
    Result := 3
  else if mni1sec.Checked then
    Result := 4
  else if mni2sec.Checked then
    Result := 5
  else if mni5sec.Checked then
    Result := 6
  else if mni10sec.Checked then
    Result := 7
  else if mni20sec.Checked then
    Result := 8
  else
    Result := 9;
end;

procedure TfrmNXTScreen.mniRefreshRateClick(Sender: TObject);
begin
  UpdateMenuItems;
end;

procedure TfrmNXTScreen.mniScaleClick(Sender: TObject);
begin
  UpdateMenuItems;
end;

procedure TfrmNXTScreen.UpdateMenuItems;
begin
  // scale factor
  mni1x.Checked := cboScale.ItemIndex = 0;
  mni2x.Checked := cboScale.ItemIndex = 1;
  mni3x.Checked := cboScale.ItemIndex = 2;
  mni4x.Checked := cboScale.ItemIndex = 3;

  // rates
  mni50ms.Checked  := cboRates.ItemIndex = 0;
  mni100ms.Checked := cboRates.ItemIndex = 1;
  mni200ms.Checked := cboRates.ItemIndex = 2;
  mni500ms.Checked := cboRates.ItemIndex = 3;
  mni1sec.Checked  := cboRates.ItemIndex = 4;
  mni2sec.Checked  := cboRates.ItemIndex = 5;
  mni5sec.Checked  := cboRates.ItemIndex = 6;
  mni10sec.Checked := cboRates.ItemIndex = 7;
  mni20sec.Checked := cboRates.ItemIndex = 8;
  mni1min.Checked  := cboRates.ItemIndex = 9;
end;

procedure TfrmNXTScreen.FormCreate(Sender: TObject);
begin
  fDisplayNormal := True;
  SetColorScheme;
  dlgSavePic.Filter :=
    'All (*.ric;*.png;*.jpg;*.jpeg;*.bmp)|*.ric;*.png;*.jpg;*.jpeg;*.bmp|' +
    'NXT Icon File (*.ric)|*.ric|' +
    'Portable Network Graphics (*.png)|*.png|' +
    'JPEG Image File (*.jpg)|*.jpg|' +
    'JPEG Image File (*.jpeg)|*.jpeg|' +
    'Bitmaps (*.bmp)|*.bmp';
  dlgSavePic.FilterIndex := 6;
  fClickStream := TMemoryStream.Create;
  CheckForCustomClick;
end;

procedure TfrmNXTScreen.SetColorScheme;
begin
  if ThemeServices.ThemesEnabled then
    Self.Color := dxOffice11DockColor2
  else
    Self.Color := clBtnFace;
  ConfigBar(ogpNXTScreen);
end;

procedure TfrmNXTScreen.ExecuteButton(const btn: integer);
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

procedure TfrmNXTScreen.NXTbuttonClick(Sender: TObject);
begin
  ExecuteButton(TButton(Sender).Tag);
end;

procedure TfrmNXTScreen.mniPopupClick(Sender: TObject);
begin
  TOfficeMenuItem(Sender).Checked := True;
  fDisplayNormal := mniDisplayNormal.Checked;
end;

procedure TfrmNXTScreen.DoClick;
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

procedure TfrmNXTScreen.dlgSavePicTypeChange(Sender: TObject);
begin
  case dlgSavePic.FilterIndex of
    2    : fGC := TRICObject;
    3    : fGC := TPNGObject;
    4, 5 : fGC := TJPEGImage;
    6    : fGC := TBitmap;
  else
    fGC := TBitmap;
  end;
end;

function TfrmNXTScreen.GraphicClassFromExt(const ext: string): TGraphicClass;
begin
  if (ext = '.jpg') or (ext = '.jpeg') then
    Result := TJPEGImage
  else if (ext = '.ric') then
    Result := TRICObject
  else if (ext = '.png') then
    Result := TPNGObject
  else
    Result := TBitmap;
end;

procedure TfrmNXTScreen.CheckForCustomClick;
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

procedure TfrmNXTScreen.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fClickStream);
end;

end.
