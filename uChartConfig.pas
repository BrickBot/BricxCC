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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uChartConfig;

interface

uses
  Classes, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls, Chart,
  TeeProcs, TeEngine, Series;

type
  TfrmChartConfig = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pagConfig: TPageControl;
    shtGeneral: TTabSheet;
    shtTitles: TTabSheet;
    shtLegend: TTabSheet;
    btnOK: TButton;
    shtPanel: TTabSheet;
    mmoTitle: TMemo;
    cboTitle: TComboBox;
    chkTitleVisible: TCheckBox;
    btnTitleFont: TButton;
    grpTitleAlign: TGroupBox;
    radTitleLeft: TRadioButton;
    radTitleCenter: TRadioButton;
    radTitleRight: TRadioButton;
    chkTitleAdjustFrame: TCheckBox;
    grpChartType: TGroupBox;
    radTypeLine: TRadioButton;
    radTypeBar: TRadioButton;
    radTypeHBar: TRadioButton;
    radTypeArea: TRadioButton;
    radTypePoint: TRadioButton;
    dlgFont: TFontDialog;
    btnCancel: TButton;
    chkLegendVisible: TCheckBox;
    btnLegendBackColor: TButton;
    btnLegendFont: TButton;
    cboLegendStyle: TComboBox;
    cboTextStyle: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    chkResizeChart: TCheckBox;
    chkInverted: TCheckBox;
    grpLegFrame: TGroupBox;
    chkLegFrameVisible: TCheckBox;
    Label3: TLabel;
    edtLegFrameWidth: TEdit;
    udLegFrameWidth: TUpDown;
    grpLegendPosition: TGroupBox;
    radLegendTop: TRadioButton;
    radLegendLeft: TRadioButton;
    radLegendRight: TRadioButton;
    radLegendBottom: TRadioButton;
    Label4: TLabel;
    edtLegendMargin: TEdit;
    udLegMargin: TUpDown;
    grpLegendShadow: TGroupBox;
    btnLegShadowColor: TButton;
    Label5: TLabel;
    edtLegShadowSize: TEdit;
    udShadowSize: TUpDown;
    grpLegDivLine: TGroupBox;
    Label6: TLabel;
    chkDivLineVisible: TCheckBox;
    edtLegDivWidth: TEdit;
    udLegDivWidth: TUpDown;
    btnPanelColor: TButton;
    chkPanelBorder: TCheckBox;
    grpGradient: TGroupBox;
    chkGradVisible: TCheckBox;
    btnStartColor: TButton;
    btnEndColor: TButton;
    grpDirection: TGroupBox;
    radGDirTopBot: TRadioButton;
    radGDirBotTop: TRadioButton;
    radGDirLeftRight: TRadioButton;
    radGDirFromBotLeft: TRadioButton;
    radGDirFromCenter: TRadioButton;
    radGDirRightLeft: TRadioButton;
    sht3D: TTabSheet;
    grp3D: TGroupBox;
    chk3D: TCheckBox;
    Label7: TLabel;
    edt3DPct: TEdit;
    ud3DPct: TUpDown;
    chkOrthogonal: TCheckBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    barZoom: TScrollBar;
    lblZoom: TLabel;
    barRotation: TScrollBar;
    barElevation: TScrollBar;
    barHorizOffset: TScrollBar;
    barVertOffset: TScrollBar;
    lblRotation: TLabel;
    lblElevation: TLabel;
    lblHorizOffset: TLabel;
    lblVertOffset: TLabel;
    dlgColor: TColorDialog;
    mmoFoot: TMemo;
    chkFootVisible: TCheckBox;
    chkFootAdjustFrame: TCheckBox;
    btnFootFont: TButton;
    grpFootAlign: TGroupBox;
    radFootLeft: TRadioButton;
    radFootCenter: TRadioButton;
    radFootRight: TRadioButton;
    pnlLegend: TPanel;
    pnlPanelColor: TPanel;
    barTilt: TScrollBar;
    Label15: TLabel;
    lblTilt: TLabel;
    chtPreview: TChart;
    Series1: TLineSeries;
    Label16: TLabel;
    radGDirFromTopLeft: TRadioButton;
    shtWalls: TTabSheet;
    chkWallsVisible: TCheckBox;
    pagWalls: TPageControl;
    shtLeftWall: TTabSheet;
    shtBottomWall: TTabSheet;
    shtBackWall: TTabSheet;
    btnLeftBack: TButton;
    grpBorder: TGroupBox;
    chkLeftWallBVis: TCheckBox;
    Label17: TLabel;
    edtLeftWallWidth: TEdit;
    udLeftWallWidth: TUpDown;
    GroupBox2: TGroupBox;
    Label18: TLabel;
    chkBotWallBVis: TCheckBox;
    edtBotWallWidth: TEdit;
    udBotWallWidth: TUpDown;
    GroupBox5: TGroupBox;
    Label19: TLabel;
    chkBackWallBVis: TCheckBox;
    edtBackWallWidth: TEdit;
    udBackWallWidth: TUpDown;
    btnBotBack: TButton;
    btnBackBack: TButton;
    chkLeftWallTrans: TCheckBox;
    chkBotWallTrans: TCheckBox;
    chkBackWallTrans: TCheckBox;
    Label20: TLabel;
    edtLeftWallSize: TEdit;
    udLeftWallSize: TUpDown;
    udBotWallSize: TUpDown;
    edtBotWallSize: TEdit;
    Label21: TLabel;
    udBackWallSize: TUpDown;
    edtBackWallSize: TEdit;
    Label22: TLabel;
    grpPaging: TGroupBox;
    Label13: TLabel;
    edtPointsPerPage: TEdit;
    udPointsPerPage: TUpDown;
    chkScaleLastPage: TCheckBox;
    grpMargins: TGroupBox;
    edtMarginTop: TEdit;
    edtMarginLeft: TEdit;
    edtMarginRight: TEdit;
    edtMarginBot: TEdit;
    udMarginRight: TUpDown;
    udMarginTop: TUpDown;
    udMarginBot: TUpDown;
    udMarginLeft: TUpDown;
    pnlShadowColor: TPanel;
    btnLegFrameColor: TButton;
    btnLegDLColor: TButton;
    Label14: TLabel;
    cboLegFrameStyle: TComboBox;
    pnlLegFrameColor: TPanel;
    cboLegDLStyle: TComboBox;
    Label23: TLabel;
    pnlLegDLColor: TPanel;
    btnLeftWallBdrColor: TButton;
    pnlLeftWallBdrColor: TPanel;
    cboLeftWallBdrStyle: TComboBox;
    Label26: TLabel;
    btnBotWallBdrColor: TButton;
    pnlBotWallBdrColor: TPanel;
    cboBotWallBdrStyle: TComboBox;
    Label24: TLabel;
    btnBackWallBdrColor: TButton;
    pnlBackWallBdrColor: TPanel;
    Label25: TLabel;
    cboBackWallBdrStyle: TComboBox;
    grpTitleFrame: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    chkTitleFrameVis: TCheckBox;
    edtTitleFrameWidth: TEdit;
    udTitleFrameWidth: TUpDown;
    btnTitleFrameColor: TButton;
    cboTitleFrameStyle: TComboBox;
    pnlTitleFrameColor: TPanel;
    grpFootFrame: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    chkFootFrameVis: TCheckBox;
    edtFootFrameWidth: TEdit;
    udFootFrameWidth: TUpDown;
    btnFootFrameColor: TButton;
    cboFootFrameStyle: TComboBox;
    pnlFootFrameColor: TPanel;
    pnlGEndColor: TShape;
    pnlGStartColor: TShape;
    pnlLeftWallColor: TShape;
    pnlBotWallColor: TShape;
    pnlBackWallColor: TShape;
    btnHelp: TButton;
    procedure btnTitleFontClick(Sender: TObject);
    procedure cboTitleChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLegShadowColorClick(Sender: TObject);
    procedure btnLegendBackColorClick(Sender: TObject);
    procedure btnLegendFontClick(Sender: TObject);
    procedure barZoomChange(Sender: TObject);
    procedure barRotationChange(Sender: TObject);
    procedure barElevationChange(Sender: TObject);
    procedure barTiltChange(Sender: TObject);
    procedure barHorizOffsetChange(Sender: TObject);
    procedure barVertOffsetChange(Sender: TObject);
    procedure chkOrthogonalClick(Sender: TObject);
    procedure chk3DClick(Sender: TObject);
    procedure edt3DPctChange(Sender: TObject);
    procedure btnPanelColorClick(Sender: TObject);
    procedure btnStartColorClick(Sender: TObject);
    procedure btnEndColorClick(Sender: TObject);
    procedure btnLeftBackClick(Sender: TObject);
    procedure btnBotBackClick(Sender: TObject);
    procedure btnBackBackClick(Sender: TObject);
    procedure radTypeAreaClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure btnTitleFrameColorClick(Sender: TObject);
    procedure btnFootFrameColorClick(Sender: TObject);
    procedure btnLegDLColorClick(Sender: TObject);
    procedure btnLegFrameColorClick(Sender: TObject);
    procedure btnLeftWallBdrColorClick(Sender: TObject);
    procedure btnBotWallBdrColorClick(Sender: TObject);
    procedure btnBackWallBdrColorClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    FChart: TChart;
    FChartType: integer;
    procedure SetChart(const Value: TChart);
    procedure RefreshTitleControls;
    procedure InitializeValues;
    procedure InitializeGeneralControls;
    procedure InitializeTitleControls;
    procedure InitializeLegendControls;
    procedure InitializePanelControls;
    procedure Initialize3DControls;
    procedure InitializeWallControls;
    procedure SaveGeneralSettings;
    procedure SaveTitleSettings;
    procedure SaveLegendSettings;
    procedure SavePanelSettings;
    procedure Save3DSettings;
    procedure SaveWallSettings;
    procedure SetChartType(const Value: integer);
    procedure ReverseGradientColors;
  public
    { Public declarations }
    property  TheChart : TChart read FChart write SetChart;
    procedure CopySettings;
    property  ChartType : integer read FChartType write SetChartType;
  end;

implementation

{$R *.DFM}

uses
  SysUtils, Graphics, TeCanvas;

{ TfrmChartConfig }

procedure TfrmChartConfig.SetChart(const Value: TChart);
begin
  FChart := Value;
  InitializeValues;
end;

procedure TfrmChartConfig.btnTitleFontClick(Sender: TObject);
begin
  if Sender = btnTitleFont then
    dlgFont.Font.Assign(mmoTitle.Font)
  else
    dlgFont.Font.Assign(mmoFoot.Font);
  if dlgFont.Execute then
  begin
    if Sender = btnTitleFont then
      mmoTitle.Font.Assign(dlgFont.Font)
    else
      mmoTitle.Font.Assign(dlgFont.Font);
  end;
end;

procedure TfrmChartConfig.cboTitleChange(Sender: TObject);
begin
  RefreshTitleControls;
end;

procedure TfrmChartConfig.RefreshTitleControls;
var
  bVis : boolean;
begin
  bVis := cboTitle.ItemIndex = 0; // title (not foot)
  btnTitleFont.Visible        := bVis;
  btnFootFont.Visible         := not bVis;
  chkTitleVisible.Visible     := bVis;
  chkFootVisible.Visible      := not bVis;
  chkTitleAdjustFrame.Visible := bVis;
  chkFootAdjustFrame.Visible  := not bVis;
  grpTitleAlign.Visible       := bVis;
  grpFootAlign.Visible        := not bVis;
  mmoTitle.Visible            := bVis;
  mmoFoot.Visible             := not bVis;
  grpTitleFrame.Visible       := bVis;
  grpFootFrame.Visible        := not bVis;
end;

procedure TfrmChartConfig.CopySettings;
begin
  SaveGeneralSettings;
  SaveTitleSettings;
  SaveLegendSettings;
  SavePanelSettings;
  Save3DSettings;
  SaveWallSettings;
end;

procedure TfrmChartConfig.FormCreate(Sender: TObject);
var
  i : integer;
begin
  fChartType := 0;
  pagConfig.ActivePage := shtGeneral;
  pagWalls.ActivePage  := shtLeftWall;
  for i := 0 to 10 do
  begin
    chtPreview.Series[0].Add(random(50), '', clTeeColor);
  end;
end;

procedure TfrmChartConfig.InitializeLegendControls;
begin
  with TheChart.Legend do
  begin
    pnlLegend.Font.Assign(Font);
    pnlLegend.Color            := Color;
    pnlShadowColor.Color       := ShadowColor;
    chkLegendVisible.Checked   := Visible;
    cboLegendStyle.ItemIndex   := Ord(LegendStyle);
    cboTextStyle.ItemIndex     := Ord(TextStyle);
    chkResizeChart.Checked     := ResizeChart;
    chkInverted.Checked        := Inverted;
    chkLegFrameVisible.Checked := Frame.Visible;
    udLegFrameWidth.Position   := Frame.Width;
    pnlLegFrameColor.Color     := Frame.Color;
    cboLegFrameStyle.ItemIndex := Ord(Frame.Style);
    chkDivLineVisible.Checked  := DividingLines.Visible;
    udLegDivWidth.Position     := DividingLines.Width;
    pnlLegDLColor.Color        := DividingLines.Color;
    cboLegDLStyle.ItemIndex    := Ord(DividingLines.Style);
    udShadowSize.Position      := ShadowSize;
    udLegMargin.Position       := HorizMargin;
    case Alignment of
      laLeft  : radLegendLeft.Checked  := True;
      laRight : radLegendRight.Checked := True;
      laTop   : radLegendTop.Checked   := True;
    else
      radLegendBottom.Checked := True;
    end;
  end;
end;

procedure TfrmChartConfig.btnLegShadowColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlShadowColor.Color;
  if dlgColor.Execute then
  begin
    pnlShadowColor.Color := dlgColor.Color;
  end;
end;

procedure TfrmChartConfig.btnLegendBackColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlLegend.Color;
  if dlgColor.Execute then
  begin
    pnlLegend.Color := dlgColor.Color;
  end;
end;

procedure TfrmChartConfig.btnLegendFontClick(Sender: TObject);
begin
  dlgFont.Font.Assign(pnlLegend.Font);
  if dlgFont.Execute then
  begin
    pnlLegend.Font.Assign(dlgFont.Font);
  end;
end;

procedure TfrmChartConfig.InitializeValues;
begin
  InitializeGeneralControls;
  InitializeTitleControls;
  InitializeLegendControls;
  InitializePanelControls;
  Initialize3DControls;
  InitializeWallControls;
end;

procedure TfrmChartConfig.InitializeTitleControls;
begin
  cboTitle.ItemIndex := 0;
  with TheChart.Title do
  begin
    mmoTitle.Lines.Assign(Text);
    mmoTitle.Font.Assign(Font);
    chkTitleVisible.Checked      := Visible;
    chkTitleAdjustFrame.Checked  := AdjustFrame;
    chkTitleFrameVis.Checked     := Frame.Visible;
    udTitleFrameWidth.Position   := Frame.Width;
    pnlTitleFrameColor.Color     := Frame.Color;
    cboTitleFrameStyle.ItemIndex := Ord(Frame.Style);
    case Alignment of
      taLeftJustify : radTitleLeft.Checked   := True;
      taCenter      : radTitleCenter.Checked := True;
    else
      radTitleRight.Checked := True;
    end;
  end;
  with TheChart.Foot do
  begin
    mmoFoot.Lines.Assign(Text);
    mmoFoot.Font.Assign(Font);
    chkFootVisible.Checked      := Visible;
    chkFootAdjustFrame.Checked  := AdjustFrame;
    chkFootFrameVis.Checked     := Frame.Visible;
    udFootFrameWidth.Position   := Frame.Width;
    pnlFootFrameColor.Color     := Frame.Color;
    cboFootFrameStyle.ItemIndex := Ord(Frame.Style);
    case Alignment of
      taLeftJustify : radFootLeft.Checked   := True;
      taCenter      : radFootCenter.Checked := True;
    else
      radFootRight.Checked := True;
    end;
  end;
end;

procedure TfrmChartConfig.Save3DSettings;
begin
  TheChart.View3D         := chk3D.Checked;
  TheChart.Chart3DPercent := ud3DPct.Position;
  with TheChart.View3DOptions do
  begin
    Orthogonal  := chkOrthogonal.Checked;
    Zoom        := barZoom.Position;
    Rotation    := barRotation.Position;
    Tilt        := barTilt.Position;
    Elevation   := barElevation.Position;
    HorizOffset := barHorizOffset.Position;
    VertOffset  := barVertOffset.Position;
  end;
end;

procedure TfrmChartConfig.SaveGeneralSettings;
begin
  TheChart.ScaleLastPage    := chkScaleLastPage.Checked;
  TheChart.MaxPointsPerPage := udPointsPerPage.Position;
  TheChart.MarginTop        := udMarginTop.Position;
  TheChart.MarginLeft       := udMarginLeft.Position;
  TheChart.MarginRight      := udMarginRight.Position;
  TheChart.MarginBottom     := udMarginBot.Position;
end;

procedure TfrmChartConfig.SaveLegendSettings;
begin
  with TheChart.Legend do
  begin
    Font.Assign(pnlLegend.Font);
    Color       := pnlLegend.Color;
    Visible     := chkLegendVisible.Checked;
    LegendStyle := TLegendStyle(cboLegendStyle.ItemIndex);
    TextStyle   := TLegendTextStyle(cboTextStyle.ItemIndex);
    ResizeChart := chkResizeChart.Checked;
    Inverted    := chkInverted.Checked;
    ShadowSize  := udShadowSize.Position;
    ShadowColor := pnlShadowColor.Color;
    HorizMargin := udLegMargin.Position;
    Frame.Visible := chkLegFrameVisible.Checked;
    Frame.Width   := udLegFrameWidth.Position;
    Frame.Color   := pnlLegFrameColor.Color;
    Frame.Style   := TPenStyle(cboLegFrameStyle.ItemIndex);
    DividingLines.Visible := chkDivLineVisible.Checked;
    DividingLines.Width   := udLegDivWidth.Position;
    DividingLines.Color   := pnlLegDLColor.Color;
    DividingLines.Style   := TPenStyle(cboLegDLStyle.ItemIndex);
    if radLegendLeft.Checked then
      Alignment := laLeft
    else if radLegendRight.Checked then
      Alignment := laRight
    else if radLegendTop.Checked then
      Alignment := laTop
    else
      Alignment := laBottom;
  end;
end;

procedure TfrmChartConfig.ReverseGradientColors;
var
  tmp : TColor;
begin
  tmp := TheChart.Gradient.StartColor;
  TheChart.Gradient.StartColor := TheChart.Gradient.EndColor;
  TheChart.Gradient.EndColor   := tmp;
end;

procedure TfrmChartConfig.SavePanelSettings;
begin
  TheChart.Color := pnlPanelColor.Color;
  if chkPanelBorder.Checked then
    TheChart.BorderStyle := bsSingle
  else
    TheChart.BorderStyle := bsNone;
  TheChart.Gradient.Visible := chkGradVisible.Checked;
  TheChart.Gradient.StartColor := pnlGStartColor.Brush.Color;
  TheChart.Gradient.EndColor   := pnlGEndColor.Brush.Color;
  if radGDirTopBot.Checked then
    TheChart.Gradient.Direction := gdTopBottom
  else if radGDirBotTop.Checked then
    TheChart.Gradient.Direction := gdBottomTop
  else if radGDirLeftRight.Checked then
    TheChart.Gradient.Direction := gdLeftRight
  else if radGDirRightLeft.Checked then
    TheChart.Gradient.Direction := gdRightLeft
  else if radGDirFromCenter.Checked then
    TheChart.Gradient.Direction := gdFromCenter
  else if radGDirFromBotLeft.Checked then
    TheChart.Gradient.Direction := gdFromBottomLeft
  else
    TheChart.Gradient.Direction := gdFromTopLeft;
  if TheChart.Gradient.Direction in [gdTopBottom, gdLeftRight, gdFromCenter] then
    ReverseGradientColors;
end;

procedure TfrmChartConfig.SaveTitleSettings;
begin
  with TheChart.Title do
  begin
    Text.Assign(mmoTitle.Lines);
    Font.Assign(mmoTitle.Font);
    Visible       := chkTitleVisible.Checked;
    AdjustFrame   := chkTitleAdjustFrame.Checked;
    Frame.Visible := chkTitleFrameVis.Checked;
    Frame.Width   := udTitleFrameWidth.Position;
    Frame.Color   := pnlTitleFrameColor.Color;
    Frame.Style   := TPenStyle(cboTitleFrameStyle.ItemIndex);
    if radTitleLeft.Checked then
      Alignment := taLeftJustify
    else if radTitleCenter.Checked then
      Alignment := taCenter
    else
      Alignment := taRightJustify;
  end;
  with TheChart.Foot do
  begin
    Text.Assign(mmoFoot.Lines);
    Font.Assign(mmoFoot.Font);
    Visible       := chkFootVisible.Checked;
    AdjustFrame   := chkFootAdjustFrame.Checked;
    Frame.Visible := chkFootFrameVis.Checked;
    Frame.Width   := udFootFrameWidth.Position;
    Frame.Color   := pnlFootFrameColor.Color;
    Frame.Style   := TPenStyle(cboFootFrameStyle.ItemIndex);
    if radFootLeft.Checked then
      Alignment := taLeftJustify
    else if radFootCenter.Checked then
      Alignment := taCenter
    else
      Alignment := taRightJustify;
  end;
end;

procedure TfrmChartConfig.Initialize3DControls;
begin
  chk3D.Checked             := TheChart.View3D;
  ud3DPct.Position          := TheChart.Chart3DPercent;
  chtPreview.View3D         := TheChart.View3D;
  chtPreview.Chart3DPercent := TheChart.Chart3DPercent;
  with TheChart.View3DOptions do
  begin
    chkOrthogonal.Checked   := Orthogonal;
    barZoom.Position        := Zoom;
    lblZoom.Caption         := IntToStr(Zoom) + '%';
    barRotation.Position    := Rotation;
    lblRotation.Caption     := IntToStr(Rotation);
    barElevation.Position   := Elevation;
    lblElevation.Caption    := IntToStr(Elevation);
    barTilt.Position        := Tilt;
    lblTilt.Caption         := IntToStr(Tilt);
    barHorizOffset.Position := HorizOffset;
    lblHorizOffset.Caption  := IntToStr(HorizOffset);
    barVertOffset.Position  := VertOffset;
    lblVertOffset.Caption   := IntToStr(VertOffset);
    chtPreview.View3DOptions.Orthogonal  := Orthogonal;
    chtPreview.View3DOptions.Zoom        := Zoom;
    chtPreview.View3DOptions.Rotation    := Rotation;
    chtPreview.View3DOptions.Elevation   := Elevation;
    chtPreview.View3DOptions.Tilt        := Tilt;
    chtPreview.View3DOptions.HorizOffset := HorizOffset;
    chtPreview.View3DOptions.VertOffset  := VertOffset;
  end;
  barRotation.Enabled  := not chkOrthogonal.Checked;
  barElevation.Enabled := not chkOrthogonal.Checked;
  barTilt.Enabled      := not chkOrthogonal.Checked;
end;

procedure TfrmChartConfig.InitializeGeneralControls;
begin
  chkScaleLastPage.Checked := TheChart.ScaleLastPage;
  udPointsPerPage.Position := TheChart.MaxPointsPerPage;
  udMarginTop.Position     := TheChart.MarginTop;
  udMarginLeft.Position    := TheChart.MarginLeft;
  udMarginRight.Position   := TheChart.MarginRight;
  udMarginBot.Position     := TheChart.MarginBottom;
end;

procedure TfrmChartConfig.InitializePanelControls;
begin
  pnlPanelColor.Color := TheChart.Color;
  chkPanelBorder.Checked := TheChart.BorderStyle = bsSingle;
  chkGradVisible.Checked := TheChart.Gradient.Visible;
  case TheChart.Gradient.Direction of
    gdTopBottom   : radGDirTopBot.Checked      := True;
    gdBottomTop   : radGDirBotTop.Checked      := True;
    gdLeftRight   : radGDirLeftRight.Checked   := True;
    gdRightLeft   : radGDirRightLeft.Checked   := True;
    gdFromCenter  : radGDirFromCenter.Checked  := True;
    gdFromTopLeft : radGDirFromTopLeft.Checked := True;
  else
    radGDirFromBotLeft.Checked := True;
  end;
  if TheChart.Gradient.Direction in [gdTopBottom, gdLeftRight, gdFromCenter] then
    ReverseGradientColors;
  pnlGStartColor.Brush.Color := TheChart.Gradient.StartColor;
  pnlGEndColor.Brush.Color   := TheChart.Gradient.EndColor;
end;

procedure TfrmChartConfig.SetChartType(const Value: integer);
begin
  FChartType := Value;
  case Value of
    0 : radTypeLine.Checked := True;
    1 : radTypeBar.Checked  := True;
    2 : radTypeHBar.Checked := True;
    3 : radTypeArea.Checked := True;
  else
    radTypePoint.Checked := True;
  end;
end;

procedure TfrmChartConfig.barZoomChange(Sender: TObject);
begin
  lblZoom.Caption := IntToStr(barZoom.Position) + '%';
  chtPreview.View3DOptions.Zoom := barZoom.Position;
end;

procedure TfrmChartConfig.barRotationChange(Sender: TObject);
begin
  lblRotation.Caption := IntToStr(barRotation.Position);
  chtPreview.View3DOptions.Rotation := barRotation.Position;
end;

procedure TfrmChartConfig.barElevationChange(Sender: TObject);
begin
  lblElevation.Caption := IntToStr(barElevation.Position);
  chtPreview.View3DOptions.Elevation := barElevation.Position;
end;

procedure TfrmChartConfig.barTiltChange(Sender: TObject);
begin
  lblTilt.Caption := IntToStr(barTilt.Position);
  chtPreview.View3DOptions.Tilt := barTilt.Position;
end;

procedure TfrmChartConfig.barHorizOffsetChange(Sender: TObject);
begin
  lblHorizOffset.Caption := IntToStr(barHorizOffset.Position);
  chtPreview.View3DOptions.HorizOffset := barHorizOffset.Position;
end;

procedure TfrmChartConfig.barVertOffsetChange(Sender: TObject);
begin
  lblVertOffset.Caption := IntToStr(barVertOffset.Position);
  chtPreview.View3DOptions.VertOffset := barVertOffset.Position;
end;

procedure TfrmChartConfig.chkOrthogonalClick(Sender: TObject);
begin
  chtPreview.View3DOptions.Orthogonal := chkOrthogonal.Checked;
  barRotation.Enabled  := not chkOrthogonal.Checked;
  barElevation.Enabled := not chkOrthogonal.Checked;
  barTilt.Enabled      := not chkOrthogonal.Checked;
end;

procedure TfrmChartConfig.chk3DClick(Sender: TObject);
begin
  chtPreview.View3D := chk3D.Checked;
end;

procedure TfrmChartConfig.edt3DPctChange(Sender: TObject);
begin
  chtPreview.Chart3DPercent := ud3DPct.Position;
end;

procedure TfrmChartConfig.btnPanelColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlPanelColor.Color;
  if dlgColor.Execute then
    pnlPanelColor.Color := dlgColor.Color;
end;

procedure TfrmChartConfig.btnStartColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlGStartColor.Brush.Color;
  if dlgColor.Execute then
    pnlGStartColor.Brush.Color := dlgColor.Color;
end;

procedure TfrmChartConfig.btnEndColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlGEndColor.Brush.Color;
  if dlgColor.Execute then
    pnlGEndColor.Brush.Color := dlgColor.Color;
end;

procedure TfrmChartConfig.btnLeftBackClick(Sender: TObject);
begin
  dlgColor.Color := pnlLeftWallColor.Brush.Color;
  if dlgColor.Execute then
    pnlLeftWallColor.Brush.Color := dlgColor.Color;
end;

procedure TfrmChartConfig.btnBotBackClick(Sender: TObject);
begin
  dlgColor.Color := pnlBotWallColor.Brush.Color;
  if dlgColor.Execute then
    pnlBotWallColor.Brush.Color := dlgColor.Color;
end;

procedure TfrmChartConfig.btnBackBackClick(Sender: TObject);
begin
  dlgColor.Color := pnlBackWallColor.Brush.Color;
  if dlgColor.Execute then
    pnlBackWallColor.Brush.Color := dlgColor.Color;
end;

procedure TfrmChartConfig.InitializeWallControls;
begin
  chkWallsVisible.Checked  := TheChart.View3DWalls;

  with TheChart.LeftWall do
  begin
    pnlLeftWallColor.Brush.Color := Color;
    chkLeftWallTrans.Checked  := Brush.Style = bsClear;
    udLeftWallSize.Position   := Size;
    chkLeftWallBVis.Checked   := Pen.Visible;
    udLeftWallWidth.Position  := Pen.Width;
    pnlLeftWallBdrColor.Color := Pen.Color;
    cboLeftWallBdrStyle.ItemIndex := Ord(Pen.Style);
  end;

  with TheChart.BottomWall do
  begin
    pnlBotWallColor.Brush.Color := Color;
    chkBotWallTrans.Checked  := Brush.Style = bsClear;
    udBotWallSize.Position   := Size;
    chkBotWallBVis.Checked   := Pen.Visible;
    udBotWallWidth.Position  := Pen.Width;
    pnlBotWallBdrColor.Color := Pen.Color;
    cboBotWallBdrStyle.ItemIndex := Ord(Pen.Style);
  end;

  with TheChart.BackWall do
  begin
    pnlBackWallColor.Brush.Color := Color;
    chkBackWallTrans.Checked  := Brush.Style = bsClear;
    udBackWallSize.Position   := Size;
    chkBackWallBVis.Checked   := Pen.Visible;
    udBackWallWidth.Position  := Pen.Width;
    pnlBackWallBdrColor.Color := Pen.Color;
    cboBackWallBdrStyle.ItemIndex := Ord(Pen.Style);
  end;
end;

procedure TfrmChartConfig.SaveWallSettings;
begin
  TheChart.View3DWalls := chkWallsVisible.Checked;

  with TheChart.LeftWall do
  begin
    Color       := pnlLeftWallColor.Brush.Color;
    Size        := udLeftWallSize.Position;
    if chkLeftWallTrans.Checked then
      Brush.Style := bsClear
    else
      Brush.Style := bsSolid;
    Pen.Visible := chkLeftWallBVis.Checked;
    Pen.Width   := udLeftWallWidth.Position;
    Pen.Color   := pnlLeftWallBdrColor.Color;
    Pen.Style   := TPenStyle(cboLeftWallBdrStyle.ItemIndex);
  end;

  with TheChart.BottomWall do
  begin
    Color       := pnlBotWallColor.Brush.Color;
    Size        := udbotWallSize.Position;
    if chkBotWallTrans.Checked then
      Brush.Style := bsClear
    else
      Brush.Style := bsSolid;
    Pen.Visible := chkBotWallBVis.Checked;
    Pen.Width   := udBotWallWidth.Position;
    Pen.Color   := pnlBotWallBdrColor.Color;
    Pen.Style   := TPenStyle(cboBotWallBdrStyle.ItemIndex);
  end;

  with TheChart.BackWall do
  begin
    Color       := pnlBackWallColor.Brush.Color;
    Size        := udBackWallSize.Position;
    if chkBackWallTrans.Checked then
      Brush.Style := bsClear
    else
      Brush.Style := bsSolid;
    Pen.Visible := chkBackWallBVis.Checked;
    Pen.Width   := udBackWallWidth.Position;
    Pen.Color   := pnlBackWallBdrColor.Color;
    Pen.Style   := TPenStyle(cboBackWallBdrStyle.ItemIndex);
  end;

end;

procedure TfrmChartConfig.radTypeAreaClick(Sender: TObject);
begin
  if Sender = radTypeLine then
    fChartType := 0
  else if Sender = radTypeBar then
    fChartType := 1
  else if Sender = radTypeHBar then
    fChartType := 2
  else if Sender = radTypeArea then
    fChartType := 3
  else
    fChartType := 4;
end;

procedure TfrmChartConfig.EditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in [#8, #16, '0'..'9']) then
    Key := #0;
end;

procedure TfrmChartConfig.btnTitleFrameColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlTitleFrameColor.Color;
  if dlgColor.Execute then
    pnlTitleFrameColor.Color := dlgColor.Color;
end;

procedure TfrmChartConfig.btnFootFrameColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlFootFrameColor.Color;
  if dlgColor.Execute then
    pnlFootFrameColor.Color := dlgColor.Color;
end;

procedure TfrmChartConfig.btnLegDLColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlLegDLColor.Color;
  if dlgColor.Execute then
    pnlLegDLColor.Color := dlgColor.Color;
end;

procedure TfrmChartConfig.btnLegFrameColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlLegFrameColor.Color;
  if dlgColor.Execute then
    pnlLegFrameColor.Color := dlgColor.Color;
end;

procedure TfrmChartConfig.btnLeftWallBdrColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlLeftWallBdrColor.Color;
  if dlgColor.Execute then
    pnlLeftWallBdrColor.Color := dlgColor.Color;
end;

procedure TfrmChartConfig.btnBotWallBdrColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlBotWallBdrColor.Color;
  if dlgColor.Execute then
    pnlBotWallBdrColor.Color := dlgColor.Color;
end;

procedure TfrmChartConfig.btnBackWallBdrColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlBackWallBdrColor.Color;
  if dlgColor.Execute then
    pnlBackWallBdrColor.Color := dlgColor.Color;
end;

procedure TfrmChartConfig.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.