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
unit uSeriesConfig;

interface

uses
  Classes, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  TeEngine, Series, Buttons, Chart, ActnList;

type
  TSeriesConfigMode = (scmEdit, scmAdd);

  TfrmSeriesConfig = class(TForm)
    pnlOuter: TPanel;
    pnlInner: TPanel;
    pagSeries: TPageControl;
    shtLine: TTabSheet;
    Label24: TLabel;
    cboLinePattern: TComboBox;
    chkLineColorEach: TCheckBox;
    chkLineDark3D: TCheckBox;
    grpLineMode: TGroupBox;
    chkLineStairs: TCheckBox;
    chkLineInverted: TCheckBox;
    shtBar: TTabSheet;
    Label29: TLabel;
    cboBarStyle: TComboBox;
    grpBarMBar: TGroupBox;
    radMBNone: TRadioButton;
    radMBSide: TRadioButton;
    radMBStacked: TRadioButton;
    radMBStackedPct: TRadioButton;
    grpBarOpts: TGroupBox;
    chkDB3DSides: TCheckBox;
    chkBarSideMargins: TCheckBox;
    chkAutoMarkPos: TCheckBox;
    chkBarColorEach: TCheckBox;
    shtArea: TTabSheet;
    Label28: TLabel;
    cboAreaPattern: TComboBox;
    chkAreaStairs: TCheckBox;
    grpMultipleAreas: TGroupBox;
    radMANone: TRadioButton;
    radMAStacked: TRadioButton;
    radMAStackedPct: TRadioButton;
    chkAreaColorEach: TCheckBox;
    shtPoint: TTabSheet;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    cboPointStyle: TComboBox;
    chkPointVis: TCheckBox;
    chkPoint3D: TCheckBox;
    edtPointWidth: TEdit;
    udPointWidth: TUpDown;
    edtPointHeight: TEdit;
    udPointHeight: TUpDown;
    chkPointInfMargin: TCheckBox;
    shtMarks: TTabSheet;
    chkMarkVisible: TCheckBox;
    grpMarkFormat: TGroupBox;
    btnMarkBackColor: TButton;
    btnMarkFont: TButton;
    chkMarkTrans: TCheckBox;
    chkMarkClip: TCheckBox;
    grpMarkBorder: TGroupBox;
    Label14: TLabel;
    chkMarkBVis: TCheckBox;
    edtMarkBWidth: TEdit;
    udMarkBWidth: TUpDown;
    grpArrows: TGroupBox;
    Label13: TLabel;
    btnArrowColor: TButton;
    edtArrowLen: TEdit;
    udArrowLen: TUpDown;
    grpMarkStyle: TGroupBox;
    radMarkVal: TRadioButton;
    radMarkPct: TRadioButton;
    radMarkLbl: TRadioButton;
    radMarkLblPct: TRadioButton;
    radMarkLblVal: TRadioButton;
    radMarkLegend: TRadioButton;
    radMarkPctTot: TRadioButton;
    radMarkLblPctTot: TRadioButton;
    radMarkXVal: TRadioButton;
    pnlMark: TPanel;
    pnlArrowColor: TPanel;
    btnLineColor: TButton;
    dlgColor: TColorDialog;
    btnBarColor: TButton;
    btnAreaColor: TButton;
    chkBarUseOrigin: TCheckBox;
    edtBarYOrigin: TEdit;
    udBarYOrigin: TUpDown;
    Label2: TLabel;
    edtBarWidthPct: TEdit;
    udBarWidthPct: TUpDown;
    Label3: TLabel;
    edtBarOffsetPct: TEdit;
    udBarOffsetPct: TUpDown;
    dlgFont: TFontDialog;
    pnlTitle: TPanel;
    Label4: TLabel;
    edtTitle: TEdit;
    pnlBottom: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    grpBorder: TGroupBox;
    chkLineBVis: TCheckBox;
    Label23: TLabel;
    edtLineBWidth: TEdit;
    udLineBWidth: TUpDown;
    btnLineBdrColor: TButton;
    cboLineBdrStyle: TComboBox;
    Label5: TLabel;
    pnlLineBdrColor: TPanel;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    pnlBarBdrColor: TPanel;
    btnBarBdrColor: TButton;
    cboBarBdrStyle: TComboBox;
    chkBarBVis: TCheckBox;
    udBarBWidth: TUpDown;
    edtBarBWidth: TEdit;
    Label25: TLabel;
    grpAreaBorder: TGroupBox;
    Label7: TLabel;
    pnlAreaBdrColor: TPanel;
    btnAreaBdrColor: TButton;
    cboAreaBdrStyle: TComboBox;
    Label27: TLabel;
    chkAreaBVis: TCheckBox;
    edtAreaBWidth: TEdit;
    udAreaBWidth: TUpDown;
    grpAreaLines: TGroupBox;
    Label8: TLabel;
    pnlAreaALColor: TPanel;
    btnAreaALColor: TButton;
    cboAreaALStyle: TComboBox;
    chkAreaLinesVis: TCheckBox;
    Label1: TLabel;
    edtAreaALWidth: TEdit;
    udAreaALWidth: TUpDown;
    grpPointBorder: TGroupBox;
    Label9: TLabel;
    pnlPointBdrColor: TPanel;
    btnPointBdrColor: TButton;
    cboPointBdrStyle: TComboBox;
    Label26: TLabel;
    edtPointBWidth: TEdit;
    udPointBWidth: TUpDown;
    chkPointBVis: TCheckBox;
    btnHelp: TButton;
    shtFunction: TTabSheet;
    cboFunctions: TComboBox;
    grpFuncSeries: TGroupBox;
    lstFuncSeriesAvail: TListBox;
    lstFuncSeriesSelected: TListBox;
    btnSelOne: TBitBtn;
    btnSelAll: TBitBtn;
    btnDesOne: TBitBtn;
    btnDesAll: TBitBtn;
    lblFunctions: TLabel;
    btnEditFunction: TButton;
    lblAvailable: TLabel;
    lblSelected: TLabel;
    aclFuncButtons: TActionList;
    actSelOne: TAction;
    actSellAll: TAction;
    actDesOne: TAction;
    actDesAll: TAction;
    pnlLineColor: TShape;
    pnlBarColor: TShape;
    pnlAreaColor: TShape;
    procedure FormCreate(Sender: TObject);
    procedure btnLineColorClick(Sender: TObject);
    procedure btnBarColorClick(Sender: TObject);
    procedure btnMarkFontClick(Sender: TObject);
    procedure btnMarkBackColorClick(Sender: TObject);
    procedure btnArrowColorClick(Sender: TObject);
    procedure btnAreaColorClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure btnLineBdrColorClick(Sender: TObject);
    procedure btnBarBdrColorClick(Sender: TObject);
    procedure btnAreaBdrColorClick(Sender: TObject);
    procedure btnAreaALColorClick(Sender: TObject);
    procedure btnPointBdrColorClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEditFunctionClick(Sender: TObject);
    procedure actSelOneExecute(Sender: TObject);
    procedure actSellAllExecute(Sender: TObject);
    procedure actDesOneExecute(Sender: TObject);
    procedure actDesAllExecute(Sender: TObject);
    procedure aclFuncButtonsUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FChartType: integer;
    FSeries: TChartSeries;
    fCaption : string;
    fChart: TChart;
    fMode: TSeriesConfigMode;
    procedure SetChartType(const Value: integer);
    procedure ConfigureForm;
    procedure SetSeries(const Value: TChartSeries);
    procedure InitializeValues;
    procedure InitializeLineValues;
    procedure InitializeBarValues;
    procedure InitializeAreaValues;
    procedure InitializeLinePointValues;
    procedure InitializePointPointValues;
    procedure InitializePointValues(P : TSeriesPointer);
    procedure InitializeMarkValues;
    procedure InitializeFunctionValues;
    procedure SaveLineValues;
    procedure SaveBarValues;
    procedure SaveAreaValues;
    procedure SaveLinePointValues;
    procedure SavePointPointValues;
    procedure SaveMarkValues;
    procedure SavePointValues(P : TSeriesPointer);
    procedure SaveFunctionValues;
    procedure SetMode(const Value: TSeriesConfigMode);
    function  CreateNewSeries : TChartSeries;
    function  GetFunctionIndex(X : TTeeFunction) : integer;
  public
    { Public declarations }
    procedure CopySeriesSettings;
    property  TheSeries : TChartSeries read FSeries write SetSeries;
    property  ChartType : integer read FChartType write SetChartType;
    property  Chart : TChart read fChart write fChart;
    property  Mode : TSeriesConfigMode read fMode write SetMode;
  end;

implementation

{$R *.DFM}

uses
  SysUtils, Graphics, TeeFunci;

type
  TCopyTeeFunction = class(TTeeFunction)
  protected
    function Calculate(SourceSeries : TChartSeries; First, Last: Integer) : Double; override;
    function CalculateMany(SourceSeriesList : TList; ValueIndex : Integer) : Double; override;
  end;

  TSumOfSquaresTeeFunction = class(TTeeFunction)
  protected
    function Calculate(SourceSeries : TChartSeries; First, Last: Integer) : Double; override;
    function CalculateMany(SourceSeriesList : TList; ValueIndex : Integer) : Double; override;
  end;

{ TCopyTeeFunction }

function TCopyTeeFunction.Calculate(SourceSeries: TChartSeries; First,
  Last: Integer): Double;
begin
  if First = -1 then First := 0;
  Result := SourceSeries.MandatoryValueList[First];
end;

function TCopyTeeFunction.CalculateMany(SourceSeriesList: TList;
  ValueIndex: Integer): Double;
begin
  Result := TChartSeries(SourceSeriesList[0]).MandatoryValueList[ValueIndex];
end;

{ TSumOfSquaresTeeFunction }

function TSumOfSquaresTeeFunction.Calculate(SourceSeries: TChartSeries; First,
  Last: Integer): Double;
var
  StartPoint, EndPoint, t : integer;
begin
  StartPoint := 0;
  EndPoint := SourceSeries.Count - 1;
  if First <> -1 then StartPoint := First;
  if Last <> -1 then EndPoint := Last;
  Result := 0;
  for t := StartPoint to EndPoint do
    Result := Result + Sqr(SourceSeries.MandatoryValueList[t]);
end;

function TSumOfSquaresTeeFunction.CalculateMany(SourceSeriesList: TList;
  ValueIndex: Integer): Double;
var
  t : integer;
  CS : TChartSeries;
begin
  Result := 0;
  for t := 0 to SourceSeriesList.Count - 1 do
  begin
    CS := TChartSeries(SourceSeriesList[t]);
    if ValueIndex < CS.Count then
      Result := Result + Sqr(CS.MandatoryValueList[ValueIndex]);
  end;
end;

{ TfrmSeriesConfig }

procedure TfrmSeriesConfig.ConfigureForm;
begin
  if Mode = scmEdit then
  begin
    shtFunction.TabVisible := Assigned(FSeries) and
      ((FSeries.DataSources.Count > 0) or (FSeries.FunctionType <> nil));
  end
  else
  begin
    shtFunction.TabVisible := True;
  end;
  case ChartType of
    0 : begin
      shtLine.TabVisible  := True;
      shtBar.TabVisible   := False;
      shtArea.TabVisible  := False;
      shtPoint.TabVisible := True;
      shtMarks.TabVisible := True;
    end;
    1, 2 : begin
      shtLine.TabVisible  := False;
      shtBar.TabVisible   := True;
      shtArea.TabVisible  := False;
      shtPoint.TabVisible := False;
      shtMarks.TabVisible := True;
    end;
    3 : begin
      shtLine.TabVisible  := False;
      shtBar.TabVisible   := False;
      shtArea.TabVisible  := True;
      shtPoint.TabVisible := False;
      shtMarks.TabVisible := True;
    end;
    4 : begin
      shtLine.TabVisible  := False;
      shtBar.TabVisible   := False;
      shtArea.TabVisible  := False;
      shtPoint.TabVisible := True;
      shtMarks.TabVisible := True;
    end;
  end;
  InitializeValues;
end;

procedure TfrmSeriesConfig.CopySeriesSettings;
begin
  TheSeries.Title := edtTitle.Text;
  case ChartType of
    0 : begin
      SaveLineValues;
      SaveLinePointValues;
    end;
    1, 2 : begin
      SaveBarValues;
    end;
    3 : begin
      SaveAreaValues;
    end;
    4 : begin
      SavePointPointValues;
    end;
  end;
  SaveMarkValues;
  SaveFunctionValues;
end;

procedure TfrmSeriesConfig.FormCreate(Sender: TObject);
begin
  pagSeries.ActivePage := shtLine;
  fCaption := Caption;
  fMode := scmEdit;
end;

procedure TfrmSeriesConfig.InitializeAreaValues;
var
  S : TAreaSeries;
begin
  if not (TheSeries is TAreaSeries) then Exit;
  S := TAreaSeries(TheSeries);
  cboAreaPattern.ItemIndex  := Ord(S.AreaBrush);
  chkAreaStairs.Checked     := S.Stairs;
  pnlAreaColor.Brush.Color  := S.SeriesColor;
  chkAreaColorEach.Checked  := S.ColorEachPoint;
  chkAreaBVis.Checked       := S.LinePen.Visible;
  udAreaBWidth.Position     := S.LinePen.Width;
  pnlAreaBdrColor.Color     := S.LinePen.Color;
  cboAreaBdrStyle.ItemIndex := Ord(S.LinePen.Style);
  chkAreaLinesVis.Checked   := S.AreaLinesPen.Visible;
  udAreaALWidth.Position    := S.AreaLinesPen.Width;
  pnlAreaALColor.Color      := S.AreaLinesPen.Color;
  cboAreaALStyle.ItemIndex  := Ord(S.AreaLinesPen.Style);
  case S.MultiArea of
    maNone : radMANone.Checked := True;
    maStacked : radMAStacked.Checked := True;
  else
    radMAStackedPct.Checked := True;
  end;
end;

procedure TfrmSeriesConfig.InitializeBarValues;
var
  S : TBarSeries;
begin
  if not ((TheSeries is TBarSeries) or
          (TheSeries is THorizBarSeries)) then Exit;
  S := TBarSeries(TheSeries);
  chkBarBVis.Checked        := S.BarPen.Visible;
  udBarBWidth.Position      := S.BarPen.Width;
  pnlBarBdrColor.Color      := S.BarPen.Color;
  cboBarBdrStyle.ItemIndex  := Ord(S.BarPen.Style);
  cboBarStyle.ItemIndex     := Ord(S.BarStyle);
  udBarWidthPct.Position    := S.BarWidthPercent;
  chkBarColorEach.Checked   := S.ColorEachPoint;
  pnlBarColor.Brush.Color   := S.SeriesColor;
  chkBarUseOrigin.Checked   := S.UseYOrigin;
  udBarYOrigin.Position     := Trunc(S.YOrigin);
  udBarOffsetPct.Position   := S.OffsetPercent;
  chkDB3DSides.Checked      := S.Dark3D;
  chkBarSideMargins.Checked := S.SideMargins;
  chkAutoMarkPos.Checked    := S.AutoMarkPosition;
  case S.MultiBar of
    mbNone : radMBNone.Checked := True;
    mbSide : radMBSide.Checked := True;
    mbStacked : radMBStacked.Checked := True;
  else
    radMBStackedPct.Checked := True;
  end;
end;

procedure TfrmSeriesConfig.InitializeLineValues;
var
  S : TLineSeries;
begin
  if not (TheSeries is TLineSeries) then Exit;
  S := TLineSeries(TheSeries);
  chkLineBVis.Checked       := S.LinePen.Visible;
  udLineBWidth.Position     := S.LinePen.Width;
  pnlLineBdrColor.Color     := S.LinePen.Color;
  cboLineBdrStyle.ItemIndex := Ord(S.LinePen.Style);
  cboLinePattern.ItemIndex  := Ord(S.LineBrush);
  chkLineColorEach.Checked  := S.ColorEachPoint;
  chkLineDark3D.Checked     := S.Dark3D;
  chkLineStairs.Checked     := S.Stairs;
  chkLineInverted.Checked   := S.InvertedStairs;
  pnlLineColor.Brush.Color  := S.SeriesColor;
end;

procedure TfrmSeriesConfig.InitializeMarkValues;
var
  M : TSeriesMarks;
begin
  M := TheSeries.Marks;
  chkMarkVisible.Checked := M.Visible;
  pnlArrowColor.Color    := M.Arrow.Color;
  pnlMark.Color          := M.BackColor;
  pnlMark.Font.Assign(M.Font);
  chkMarkTrans.Checked   := M.Transparent;
  chkMarkClip.Checked    := M.Clip;
  chkMarkBVis.Checked    := M.Frame.Visible;
  udMarkBWidth.Position  := M.Frame.Width;
  udArrowLen.Position    := M.ArrowLength;
  case M.Style of
    smsValue   : radMarkVal.Checked := True;
    smsPercent : radMarkPct.Checked := True;
    smsLabel   : radMarkLbl.Checked := True;
    smsLabelPercent : radMarkLblPct.Checked := True;
    smsLabelValue   : radMarkLblVal.Checked := True;
    smsLegend       : radMarkLegend.Checked := True;
    smsPercentTotal : radMarkPctTot.Checked := True;
    smsLabelPercentTotal : radMarkLblPctTot.Checked := True;
  else
    radMarkXVal.Checked := True;
  end;
end;

procedure TfrmSeriesConfig.InitializePointValues(P : TSeriesPointer);
begin
  chkPointVis.Checked        := P.Visible;
  udPointHeight.Position     := P.VertSize;
  udPointWidth.Position      := P.HorizSize;
  chkPoint3D.Checked         := P.Draw3D;
  chkPointInfMargin.Checked  := P.InflateMargins;
  cboPointStyle.ItemIndex    := Ord(P.Style);
  chkPointBVis.Checked       := P.Pen.Visible;
  udPointBWidth.Position     := P.Pen.Width;
  pnlPointBdrColor.Color     := P.Pen.Color;
  cboPointBdrStyle.ItemIndex := Ord(P.Pen.Style);
end;

procedure TfrmSeriesConfig.InitializeValues;
begin
  if ChartType = -1 then Exit;
  if TheSeries = nil then Exit;
  case ChartType of
    0 : begin
      InitializeLineValues;
      InitializeLinePointValues;
    end;
    1, 2 : begin
      InitializeBarValues;
    end;
    3 : begin
      InitializeAreaValues;
    end;
    4 : begin
      InitializePointPointValues;
    end;
  end;
  InitializeMarkValues;
  InitializeFunctionValues;
  edtTitle.Text := FSeries.Title;
end;

procedure TfrmSeriesConfig.SetChartType(const Value: integer);
begin
  FChartType := Value;
end;

procedure TfrmSeriesConfig.SetSeries(const Value: TChartSeries);
begin
  FSeries := Value;
end;

procedure TfrmSeriesConfig.btnLineColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlLineColor.Brush.Color;
  if dlgColor.Execute then
    pnlLineColor.Brush.Color := dlgColor.Color;
end;

procedure TfrmSeriesConfig.btnBarColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlBarColor.Brush.Color;
  if dlgColor.Execute then
    pnlBarColor.Brush.Color := dlgColor.Color;
end;

procedure TfrmSeriesConfig.SaveAreaValues;
var
  S : TAreaSeries;
begin
  if not (TheSeries is TAreaSeries) then Exit;
  S := TAreaSeries(TheSeries);
  S.AreaBrush := TBrushStyle(cboAreaPattern.ItemIndex);
  S.Stairs    := chkAreaStairs.Checked;
  S.SeriesColor     := pnlAreaColor.Brush.Color;
  S.ColorEachPoint  := chkAreaColorEach.Checked;
  S.LinePen.Visible := chkAreaBVis.Checked;
  S.LinePen.Width   := udAreaBWidth.Position;
  S.LinePen.Color   := pnlAreaBdrColor.Color;
  S.LinePen.Style   := TPenStyle(cboAreaBdrStyle.ItemIndex);
  S.AreaLinesPen.Visible := chkAreaLinesVis.Checked;
  S.AreaLinesPen.Width   := udAreaALWidth.Position;
  S.AreaLinesPen.Color   := pnlAreaALColor.Color;
  S.AreaLinesPen.Style   := TPenStyle(cboAreaALStyle.ItemIndex);
  if radMANone.Checked then
    S.MultiArea := maNone
  else if radMAStacked.Checked then
    S.MultiArea := maStacked
  else
    S.MultiArea := maStacked100;
end;

procedure TfrmSeriesConfig.SaveBarValues;
var
  S : TBarSeries;
begin
  if not ((TheSeries is TBarSeries) or
          (TheSeries is THorizBarSeries)) then Exit;
  S := TBarSeries(TheSeries);
  S.BarPen.Visible   := chkBarBVis.Checked;
  S.BarPen.Width     := udBarBWidth.Position;
  S.BarPen.Color     := pnlBarBdrColor.Color;
  S.BarPen.Style     := TPenStyle(cboBarBdrStyle.ItemIndex);
  S.BarStyle         := TBarStyle(cboBarStyle.ItemIndex);
  S.BarWidthPercent  := udBarWidthPct.Position;
  S.ColorEachPoint   := chkBarColorEach.Checked;
  S.SeriesColor      := pnlBarColor.Brush.Color;
  S.UseYOrigin       := chkBarUseOrigin.Checked;
  S.YOrigin          := udBarYOrigin.Position;
  S.OffsetPercent    := udBarOffsetPct.Position;
  S.Dark3D           := chkDB3DSides.Checked;
  S.SideMargins      := chkBarSideMargins.Checked;
  S.AutoMarkPosition := chkAutoMarkPos.Checked;
  if radMBNone.Checked then
    S.MultiBar := mbNone
  else if radMBSide.Checked then
    S.MultiBar := mbSide
  else if radMBStacked.Checked then
    S.MultiBar := mbStacked
  else
    S.MultiBar := mbStacked100;
end;

procedure TfrmSeriesConfig.SaveLineValues;
var
  S : TLineSeries;
begin
  if not (TheSeries is TLineSeries) then Exit;
  S := TLineSeries(TheSeries);
  S.LinePen.Visible := chkLineBVis.Checked;
  S.LinePen.Width   := udLineBWidth.Position;
  S.LinePen.Color   := pnlLineBdrColor.Color;
  S.LinePen.Style   := TPenStyle(cboLineBdrStyle.ItemIndex);
  S.LineBrush       := TBrushStyle(cboLinePattern.ItemIndex);
  S.ColorEachPoint  := chkLineColorEach.Checked;
  S.Dark3D          := chkLineDark3D.Checked;
  S.Stairs          := chkLineStairs.Checked;
  S.InvertedStairs  := chkLineInverted.Checked;
  S.SeriesColor     := pnlLineColor.Brush.Color;
end;

procedure TfrmSeriesConfig.SaveMarkValues;
var
  M : TSeriesMarks;
begin
  M := TheSeries.Marks;
  M.Visible := chkMarkVisible.Checked;
  M.Arrow.Color := pnlArrowColor.Color;
  M.BackColor   := pnlMark.Color;
  M.Font.Assign(pnlMark.Font);
  M.Transparent := chkMarkTrans.Checked;
  M.Clip        := chkMarkClip.Checked;
  M.Frame.Visible := chkMarkBVis.Checked;
  M.Frame.Width   := udMarkBWidth.Position;
  M.ArrowLength   := udArrowLen.Position;
  if radMarkVal.Checked then
    M.Style := smsValue
  else if radMarkPct.Checked then
    M.Style := smsPercent
  else if radMarkLbl.Checked then
    M.Style := smsLabel
  else if radMarkLblPct.Checked then
    M.Style := smsLabelPercent
  else if radMarkLblVal.Checked then
    M.Style := smsLabelValue
  else if radMarkLegend.Checked then
    M.Style := smsLegend
  else if radMarkPctTot.Checked then
    M.Style := smsPercentTotal
  else if radMarkLblPctTot.Checked then
    M.Style := smsLabelPercentTotal
  else
    M.Style := smsXValue;
end;

procedure TfrmSeriesConfig.SavePointValues(P : TSeriesPointer);
begin
  P.Visible   := chkPointVis.Checked;
  P.VertSize  := udPointHeight.Position;
  P.HorizSize := udPointWidth.Position;
  P.Draw3D    := chkPoint3D.Checked;
  P.InflateMargins := chkPointInfMargin.Checked;
  P.Style          := TSeriesPointerStyle(cboPointStyle.ItemIndex);
  P.Pen.Visible    := chkPointBVis.Checked;
  P.Pen.Width      := udLineBWidth.Position;
  P.Pen.Color      := pnlPointBdrColor.Color;
  P.Pen.Style      := TPenStyle(cboPointBdrStyle.ItemIndex);
end;

procedure TfrmSeriesConfig.btnMarkFontClick(Sender: TObject);
begin
  dlgFont.Font.Assign(pnlMark.Font);
  if dlgFont.Execute then
    pnlMark.Font.Assign(dlgFont.Font);
end;

procedure TfrmSeriesConfig.btnMarkBackColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlMark.Color;
  if dlgColor.Execute then
    pnlMark.Color := dlgColor.Color;
end;

procedure TfrmSeriesConfig.btnArrowColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlArrowColor.Color;
  if dlgColor.Execute then
    pnlArrowColor.Color := dlgColor.Color;
end;

procedure TfrmSeriesConfig.SaveLinePointValues;
var
  S : TLineSeries;
begin
  if not (TheSeries is TLineSeries) then Exit;
  S := TLineSeries(TheSeries);
  SavePointValues(S.Pointer);
end;

procedure TfrmSeriesConfig.SavePointPointValues;
var
  S : TPointSeries;
begin
  if not (TheSeries is TPointSeries) then Exit;
  S := TPointSeries(TheSeries);
  SavePointValues(S.Pointer);
end;

procedure TfrmSeriesConfig.InitializeLinePointValues;
var
  S : TLineSeries;
begin
  if not (TheSeries is TLineSeries) then Exit;
  S := TLineSeries(TheSeries);
  InitializePointValues(S.Pointer);
end;

procedure TfrmSeriesConfig.InitializePointPointValues;
var
  S : TPointSeries;
begin
  if not (TheSeries is TPointSeries) then Exit;
  S := TPointSeries(TheSeries);
  InitializePointValues(S.Pointer);
end;

procedure TfrmSeriesConfig.btnAreaColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlAreaColor.Brush.Color;
  if dlgColor.Execute then
    pnlAreaColor.Brush.Color := dlgColor.Color;
end;

procedure TfrmSeriesConfig.EditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in [#8, #16, '0'..'9']) then
    Key := #0;
end;

procedure TfrmSeriesConfig.btnLineBdrColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlLineBdrColor.Color;
  if dlgColor.Execute then
    pnlLineBdrColor.Color := dlgColor.Color;
end;

procedure TfrmSeriesConfig.btnBarBdrColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlBarBdrColor.Color;
  if dlgColor.Execute then
    pnlBarBdrColor.Color := dlgColor.Color;
end;

procedure TfrmSeriesConfig.btnAreaBdrColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlAreaBdrColor.Color;
  if dlgColor.Execute then
    pnlAreaBdrColor.Color := dlgColor.Color;
end;

procedure TfrmSeriesConfig.btnAreaALColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlAreaALColor.Color;
  if dlgColor.Execute then
    pnlAreaALColor.Color := dlgColor.Color;
end;

procedure TfrmSeriesConfig.btnPointBdrColorClick(Sender: TObject);
begin
  dlgColor.Color := pnlPointBdrColor.Color;
  if dlgColor.Execute then
    pnlPointBdrColor.Color := dlgColor.Color;
end;

procedure TfrmSeriesConfig.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TfrmSeriesConfig.InitializeFunctionValues;
var
  C : TChart;
  i : integer;
  CS : TChartSeries;
begin
  if not Assigned(FSeries) then Exit;
  if shtFunction.TabVisible then
  begin
    // select function from combobox
    cboFunctions.ItemIndex := GetFunctionIndex(FSeries.FunctionType);
    // populate series list boxes
    C := FSeries.ParentChart as TChart;
    for i := 0 to C.SeriesCount - 1 do
    begin
      CS := C.Series[i];
      if CS = FSeries then Continue;
      if (FSeries.DataSources.IndexOf(CS) = -1) and (FSeries.DataSource <> CS) then
        lstFuncSeriesAvail.AddItem(CS.Title, CS)
      else
        lstFuncSeriesSelected.AddItem(CS.Title, CS);
    end;
  end;
end;

procedure TfrmSeriesConfig.SetMode(const Value: TSeriesConfigMode);
begin
  fMode := Value;
  if Value = scmAdd then
  begin
    // create a new series
    FSeries := CreateNewSeries;
  end;
end;

procedure TfrmSeriesConfig.FormShow(Sender: TObject);
begin
  ConfigureForm;
end;

function TfrmSeriesConfig.CreateNewSeries: TChartSeries;
begin
  case ChartType of
    0 : Result := TLineSeries.Create( Chart.Owner );
    1 : Result := TBarSeries.Create( Chart.Owner );
    2 : Result := THorizBarSeries.Create( Chart.Owner );
    3 : Result := TAreaSeries.Create( Chart.Owner );
  else
    Result := TPointSeries.Create( Chart.Owner );
  end;
  Result.ParentChart := Chart;
  Result.Title := 'Series ' + IntToStr(Result.ParentChart.SeriesCount);
end;

procedure TfrmSeriesConfig.btnEditFunctionClick(Sender: TObject);
begin
//
end;

procedure TfrmSeriesConfig.actSelOneExecute(Sender: TObject);
var
  i : integer;
  CS : TChartSeries;
begin
  if not Assigned(FSeries) then Exit;
  for i := 0 to lstFuncSeriesAvail.Count - 1 do
  begin
    if lstFuncSeriesAvail.Selected[i] then
    begin
      CS := TChartSeries(lstFuncSeriesAvail.Items.Objects[i]);
      lstFuncSeriesSelected.AddItem(CS.Title, CS);
      if FSeries.DataSources.IndexOf(CS) = -1 then
        FSeries.DataSources.Add(CS);
    end;
  end;
  for i := lstFuncSeriesAvail.Count - 1 downto 0 do
  begin
    if lstFuncSeriesAvail.Selected[i] then
      lstFuncSeriesAvail.Items.Delete(i);
  end;
end;

procedure TfrmSeriesConfig.actSellAllExecute(Sender: TObject);
var
  i : integer;
  CS : TChartSeries;
begin
  if not Assigned(FSeries) then Exit;
  for i := 0 to lstFuncSeriesAvail.Count - 1 do
  begin
    CS := TChartSeries(lstFuncSeriesAvail.Items.Objects[i]);
    lstFuncSeriesSelected.AddItem(CS.Title, CS);
    if FSeries.DataSources.IndexOf(CS) = -1 then
      FSeries.DataSources.Add(CS);
  end;
  lstFuncSeriesAvail.Clear;
end;

procedure TfrmSeriesConfig.actDesOneExecute(Sender: TObject);
var
  i, idx : integer;
  CS : TChartSeries;
begin
  if not Assigned(FSeries) then Exit;
  for i := 0 to lstFuncSeriesSelected.Count - 1 do
  begin
    if lstFuncSeriesSelected.Selected[i] then
    begin
      CS := TChartSeries(lstFuncSeriesSelected.Items.Objects[i]);
      lstFuncSeriesAvail.AddItem(CS.Title, CS);
      idx := FSeries.DataSources.IndexOf(CS);
      if idx <> -1 then
        FSeries.DataSources.Delete(idx);
    end;
  end;
  for i := lstFuncSeriesSelected.Count - 1 downto 0 do
  begin
    if lstFuncSeriesSelected.Selected[i] then
      lstFuncSeriesSelected.Items.Delete(i);
  end;
end;

procedure TfrmSeriesConfig.actDesAllExecute(Sender: TObject);
var
  i : integer;
  CS : TChartSeries;
begin
  if not Assigned(FSeries) then Exit;
  for i := 0 to lstFuncSeriesSelected.Count - 1 do
  begin
    CS := TChartSeries(lstFuncSeriesSelected.Items.Objects[i]);
    lstFuncSeriesAvail.AddItem(CS.Title, CS);
  end;
  lstFuncSeriesSelected.Clear;
  FSeries.DataSources.Clear;
end;

procedure TfrmSeriesConfig.aclFuncButtonsUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  btnSelOne.Enabled := lstFuncSeriesAvail.SelCount > 0;
  btnSelAll.Enabled := lstFuncSeriesAvail.Count > 0;
  btnDesOne.Enabled := lstFuncSeriesSelected.SelCount > 0;
  btnDesAll.Enabled := lstFuncSeriesSelected.Count > 0;
end;

procedure TfrmSeriesConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (ModalResult <> mrOK) and (Mode = scmAdd) then
  begin
    FreeAndNil(FSeries);
  end;
end;

procedure TfrmSeriesConfig.SaveFunctionValues;
var
  X : TTeeFunction;
  i : integer;
begin
  if shtFunction.TabVisible then
  begin
    i := cboFunctions.ItemIndex;
    case i of
      1 : X := TAverageTeeFunction.Create(Chart.Owner);
      2 : X := TLowTeeFunction.Create(Chart.Owner);
      3 : X := THighTeeFunction.Create(Chart.Owner);
      4 : X := TDivideTeeFunction.Create(Chart.Owner);
      5 : X := TMultiplyTeeFunction.Create(Chart.Owner);
      6 : X := TSubtractTeeFunction.Create(Chart.Owner);
      7 : X := TAddTeeFunction.Create(Chart.Owner);
      8 : X := TSumOfSquaresTeeFunction.Create(Chart.Owner);
    else
      X := nil; //TCopyTeeFunction.Create(Chart.Owner);
    end;
    FSeries.SetFunction(X);
    FSeries.CheckDataSource;
  end;
end;

function TfrmSeriesConfig.GetFunctionIndex(X: TTeeFunction): integer;
begin
  Result := -1;
  if X = nil then Result := 0
  else if X is TAverageTeeFunction then Result := 1
  else if X is TLowTeeFunction then Result := 2
  else if X is THighTeeFunction then Result := 3
  else if X is TDivideTeeFunction then Result := 4
  else if X is TMultiplyTeeFunction then Result := 5
  else if X is TSubtractTeeFunction then Result := 6
  else if X is TAddTeeFunction then Result := 7
  else if X is TSumOfSquaresTeeFunction then Result := 8
//  else if X is TCopyTeeFunction then Result := 0;
end;

end.
