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
unit DataAnalysis;

interface

uses
  Classes, Controls, Forms, Dialogs,
  ExtCtrls, TeeProcs, TeEngine, Chart, Series, StdCtrls, Menus, ActnList,
  ImgList, ToolWin, ComCtrls, Buttons;

type
  TfrmDataAnalysis = class(TForm)
    chtData: TChart;
    aclMain: TActionList;
    imlButtons: TImageList;
    actPrint: TAction;
    actConfig: TAction;
    actExport: TAction;
    actCopy: TAction;
    actClose: TAction;
    dlgPrint: TPrintDialog;
    pnlToolbar: TPanel;
    pnlLeft: TPanel;
    pnlVCR: TPanel;
    tbrMain: TToolBar;
    btnPrint: TToolButton;
    btnConfig: TToolButton;
    btnCopy: TToolButton;
    btnExport: TToolButton;
    btnClose: TToolButton;
    bvlVCR: TBevel;
    btnFirst: TSpeedButton;
    btnPrev: TSpeedButton;
    btnNext: TSpeedButton;
    btnLast: TSpeedButton;
    btnSelSeries: TToolButton;
    actSeries: TAction;
    actAddCalcSeries: TAction;
    btnSep2: TToolButton;
    btnAddCalcSeries: TToolButton;
    btnSep1: TToolButton;
    btnSep4: TToolButton;
    btnHelp: TToolButton;
    actHelp: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actConfigExecute(Sender: TObject);
    procedure actCopyExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure chtDataMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnFirstClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnLastClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actSeriesExecute(Sender: TObject);
    procedure actAddCalcSeriesExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
  private
    { Private declarations }
    fData: TStrings;
    fDataIsXY: Boolean;
    FChartType: Integer;
    fFromWatch: Boolean;
    fWatchPoints: Byte;
    fSyncSeries: Boolean;
    fNextX : Integer;
    fRelTime: Boolean;
    fFromNewWatch: Boolean;
    procedure ConfigureSeries(S : TChartSeries);
    procedure SetData(const Value: TStrings);
    procedure PrepareChartXY;
    procedure PrepareChartNormal;
    procedure SetChartType(const Value: integer);
    procedure UpdateVCRButtons;
    function  PromptForSeries : TChartSeries;
    procedure ProcessValue(valStr: string; bTrimSeries : Boolean = false);
    function CreateSeries: TChartSeries;
    function FindValue(valStr: string): Single;
    function FindType(valStr: string): string;
    function GetXValue(s : TChartSeries): integer;
    function MaxXValue: double;
    procedure TrimSeries;
    function GetSeriesIndexByName(name: string): integer;
  public
    { Public declarations }
    procedure AddNewData(aValues : TStrings);
    procedure PrepareChart;
    property  Data : TStrings read fData write SetData;
    property  DataIsXY : Boolean read fDataIsXY write fDataIsXY;
    property  UseChartType : Integer read FChartType write SetChartType;
    property  FromWatch : Boolean read fFromWatch write fFromWatch;
    property  FromNewWatch : Boolean read fFromNewWatch write fFromNewWatch;
    property  WatchPoints : Byte read fWatchPoints write fWatchPoints;
    property  SyncSeries : Boolean read fSyncSeries write fSyncSeries;
    property  RelativeTime : Boolean read fRelTime write fRelTime;
  end;

implementation

{$R *.DFM}

uses
  SysUtils, Printers, Clipbrd, uChartExport, uChartConfig, uSeriesConfig,
  uPromptSeries, Watch, uNewWatch;

{ TfrmDataAnalysis }

procedure TfrmDataAnalysis.SetData(const Value: TStrings);
begin
  fData.Clear;
  fData.Assign(Value);
  PrepareChart;
end;

procedure TfrmDataAnalysis.FormCreate(Sender: TObject);
begin
  fWatchPoints  := 10;
  fFromWatch    := False;
  fFromNewWatch := False;
  fChartType    := 0;
  fDataIsXY     := False;
  fData         := TStringList.Create;
  fNextX        := 0;
  fSyncSeries   := False;
  fRelTime      := False;
end;

procedure TfrmDataAnalysis.FormDestroy(Sender: TObject);
begin
  if FromWatch and Assigned(WatchForm) then
    WatchForm.GraphDestroyed;
  if FromNewWatch and Assigned(frmNewWatch) then
    frmNewWatch.GraphDestroyed;
  fData.Free;
end;

procedure TfrmDataAnalysis.PrepareChart;
begin
  // delete any existing series first
  while chtData.SeriesCount > 0 do
    chtData.Series[0].Free;

  // now load new series
  if DataIsXY then
    PrepareChartXY
  else
    PrepareChartNormal;
end;

procedure TfrmDataAnalysis.actPrintExecute(Sender: TObject);
begin
  if dlgPrint.Execute then
  begin
    if Printer.Orientation = poLandscape then
      chtData.PrintLandscape
    else
      chtData.Print;
  end;
end;

procedure TfrmDataAnalysis.actConfigExecute(Sender: TObject);
begin
  with TfrmChartConfig.Create(nil) do
  try
    ChartType := UseChartType;
    TheChart := chtData;
    if ShowModal = mrOK then
    begin
      CopySettings;
      UseChartType := ChartType;
      chtData.Refresh;
      UpdateVCRButtons;
      pnlVCR.Visible := chtData.MaxPointsPerPage > 0;
    end;
  finally
    Free;
  end;
end;

function TfrmDataAnalysis.GetSeriesIndexByName(name : string) : integer;
var
  i : Integer;
begin
  Result := -1;
  for i := 0 to chtData.SeriesCount - 1 do
  begin
    if chtData.Series[i].Title = name then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

procedure TfrmDataAnalysis.actCopyExecute(Sender: TObject);
var
  i, j, n : integer;
  tmpStr, valStr : string;
  dataArray : array of array of string;
begin
  if chtData.SeriesCount = 0 then Exit;
  // copy to clipboard
  tmpStr := '';
  for j := 0 to chtData.SeriesCount - 1 do
  begin
    tmpStr := tmpStr + chtData.Series[j].Title;
    if j < chtData.SeriesCount - 1 then
      tmpStr := tmpStr + #9;
  end;
  tmpStr := tmpStr + #13#10;
  if DataIsXY then
  begin
    j := 0;
    while j < (fData.Count - 1) do
    begin
      valStr := fData[j];
      // should be only one series and X, Y pairs of data
      // so output (x, y)
      tmpStr := tmpStr + '(' +
        FloatToStr(FindValue(valStr)) + ', ' +
        FloatToStr(FindValue(fData[j+1])) + ')'#13#10;
      Inc(j, 2);
    end;
  end
  else
  begin
    // initialize array dimensions
    SetLength(dataArray, chtData.SeriesCount);

    for i := 0 to chtData.SeriesCount - 1 do
      SetLength(dataArray[i], 0);

    for j := 0 to fData.Count - 1 do
    begin
      valStr := fData[j];
      i := GetSeriesIndexByName(FindType(valStr));
      if i = -1 then Continue;
      n := Length(dataArray[i]);
      SetLength(dataArray[i], n + 1);
      dataArray[i][n] := FloatToStr(FindValue(valStr));
    end;
    for j := 0 to Length(dataArray[0]) - 1 do
    begin
      for i := 0 to chtData.SeriesCount - 1 do
      begin
        if j < Length(dataArray[i]) then
          tmpStr := tmpStr + dataArray[i][j];
        if i < chtData.SeriesCount - 1 then
          tmpStr := tmpStr + #9;
      end;
      tmpStr := tmpStr + #13#10;
    end;
  end;
  ClipBoard.AsText := tmpStr;
end;

procedure TfrmDataAnalysis.actExportExecute(Sender: TObject);
begin
  TfrmChartExport.DoExport(chtData);
end;

procedure TfrmDataAnalysis.actCloseExecute(Sender: TObject);
begin
  Close;
end;

function TfrmDataAnalysis.CreateSeries : TChartSeries;
begin
  case UseChartType of
    0 : Result := TLineSeries.Create( Self );
    1 : Result := TBarSeries.Create( Self );
    2 : Result := THorizBarSeries.Create( Self );
    3 : Result := TAreaSeries.Create( Self );
  else
    Result := TPointSeries.Create( Self );
  end;
  Result.ParentChart   := chtData;
  Result.Marks.Visible := False;
end;

function TfrmDataAnalysis.FindType(valStr : string) : string;
begin
  Result := Copy(valStr, 1, Pos(':', valStr)-1);
end;

function TfrmDataAnalysis.FindValue(valStr : string) : Single;
begin
  Delete(valStr, 1, Pos(':', valStr));
  Result := StrToFloatDef(Trim(valStr), 0.0);
end;

function TfrmDataAnalysis.GetXValue(s : TChartSeries) : integer;
var
  x1, x2 : Double;
begin
  if RelativeTime then
  begin
    // The desired X value should be either
    // 1) one greater than the max X value in this series
    // OR
    // 2) the maximum X value of any series other than this series
    // (whichever is greater)
    x1 := MaxXValue;
    x2 := s.Count;
    if x2 > 0 then
      x2 := s.MaxXValue + 1;
    if x2 > x1 then
      Result := Trunc(x2)
    else
      Result := Trunc(x1);
  end
  else if SyncSeries then
  begin
    Result := fNextX;
  end
  else
  begin
    Result := s.Count;
    if Result > 0 then
      Result := Trunc(s.MaxXValue) + 1;
  end;
end;

function TfrmDataAnalysis.MaxXValue : double;
var
  j : Integer;
  s : TChartSeries;
  tmp : Double;
begin
  Result := 0;
  for j := 0 to chtData.SeriesCount - 1 do
  begin
    s := chtData.Series[j];
    if s.Count > 0 then
    begin
      tmp := s.MaxXValue;
      if tmp > Result then
        Result := tmp;
    end;
  end;
end;

procedure TfrmDataAnalysis.ProcessValue(valStr : string; bTrimSeries : boolean);
var
  j, xVal : integer;
  val : Single;
  sType : string;
  s, sTmp : TChartSeries;
begin
  sType := FindType(valStr);
  val   := FindValue(valStr);
  s := nil;
  for j := 0 to chtData.SeriesCount - 1 do
  begin
    sTmp := chtData.Series[j];
    if sTmp.Title = sType then
    begin
      s := sTmp;
      Break;
    end;
  end;
  if not Assigned(s) then
  begin
    // create a new series
    s := CreateSeries;
    s.Title         := sType;
    s.XValues.Order := loNone;
  end;
  if bTrimSeries then TrimSeries;
  // now add a data point
  xVal := GetXValue(s);
  s.AddXY(xVal, val);
end;

procedure TfrmDataAnalysis.TrimSeries;
var
  x, maxX : Double;
  i : Integer;
  cs : TChartSeries;
begin
  // delete all data points where X is less than MaxXValue - WatchPoints
  for i := 0 to chtData.SeriesCount - 1 do
  begin
    cs := chtData.Series[i];
    if cs.Count > 0 then
    begin
      maxX := MaxXValue;
      x := cs.XValue[0];
      while x < (Trunc(maxX) - WatchPoints) do
      begin
        cs.Delete(0);
        if cs.Count = 0 then Break;
        x := cs.XValue[0];
      end;
    end;
  end;
end;

procedure TfrmDataAnalysis.PrepareChartNormal;
var
  i : integer;
begin
  for i := 0 to fData.Count - 1 do
  begin
    ProcessValue(fData[i]);
  end;
end;

procedure TfrmDataAnalysis.PrepareChartXY;
var
  i : integer;
  s : TChartSeries;
begin
  // only one series
  s := CreateSeries;
  s.Title := 'Datalog';
  i := 0;
  while i < fData.Count - 1 do
  begin
    s.AddXY(FindValue(fData[i]), FindValue(fData[i+1]));
    inc(i, 2);
  end;
end;

procedure TfrmDataAnalysis.SetChartType(const Value: integer);
begin
  if FChartType <> Value then
  begin
    FChartType := Value;
    PrepareChart;
  end;
end;

procedure TfrmDataAnalysis.chtDataMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  p : TChartClickedPart;
  S : TChartSeries;
begin
  if (ssCtrl in Shift) and (Button = mbLeft) then
  begin
    S := nil;
    chtData.CalcClickedPart(Point(X, Y), p);
    if p.Part = cpSeries then
    begin
      S := p.ASeries;
    end
    else if p.Part = cpChartRect then
    begin
      // prompt for series
      S := PromptForSeries;
    end;
    ConfigureSeries(S);
  end;
end;

procedure TfrmDataAnalysis.btnFirstClick(Sender: TObject);
begin
  chtData.UndoZoom;
  chtData.Page := 1;
  UpdateVCRButtons;
end;

procedure TfrmDataAnalysis.btnPrevClick(Sender: TObject);
begin
  chtData.UndoZoom;
  chtData.PreviousPage;
  UpdateVCRButtons;
end;

procedure TfrmDataAnalysis.btnNextClick(Sender: TObject);
begin
  chtData.UndoZoom;
  chtData.NextPage;
  UpdateVCRButtons;
end;

procedure TfrmDataAnalysis.btnLastClick(Sender: TObject);
begin
  chtData.UndoZoom;
  chtData.Page := chtData.NumPages;
  UpdateVCRButtons;
end;

procedure TfrmDataAnalysis.UpdateVCRButtons;
var
  p, n : integer;
begin
  p := chtData.Page;
  n := chtData.NumPages;
  btnFirst.Enabled := p > 1;
  btnPrev.Enabled  := p > 1;
  btnNext.Enabled  := p < n;
  btnLast.Enabled  := p < n;
end;

procedure TfrmDataAnalysis.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmDataAnalysis.AddNewData(aValues: TStrings);
var
  i : integer;
begin
  // create series if needed and add data points
  for i := 0 to aValues.Count - 1 do
  begin
    ProcessValue(aValues[i], True);
  end;
  fNextX := Trunc(MaxXValue) + 1;
  // add data in aValues to fData
  fData.AddStrings(aValues);
end;

function TfrmDataAnalysis.PromptForSeries: TChartSeries;
var
  i : integer;
begin
  result := nil;
  i := TfrmSeriesPrompt.PromptForSeries(chtData);
  if i <> -1 then
    result := chtData.Series[i];
end;

procedure TfrmDataAnalysis.actSeriesExecute(Sender: TObject);
begin
  ConfigureSeries(PromptForSeries);
end;

procedure TfrmDataAnalysis.ConfigureSeries(S: TChartSeries);
begin
  if not Assigned(S) then Exit;
  with TfrmSeriesConfig.Create(nil) do
  try
    Chart := chtData;
    ChartType := UseChartType;
    Mode := scmEdit;
    TheSeries := S;
    if ShowModal = mrOK then
    begin
      CopySeriesSettings;
      chtData.Refresh;
    end;
  finally
    Free;
  end;
end;

procedure TfrmDataAnalysis.actAddCalcSeriesExecute(Sender: TObject);
begin
  with TfrmSeriesConfig.Create(nil) do
  try
    Chart := chtData;
    ChartType := UseChartType;
    Mode := scmAdd;
    if ShowModal = mrOK then
    begin
      // do something here
      CopySeriesSettings;
      chtData.AddSeries(TheSeries);
      chtData.Refresh;
    end;
  finally
    Free;
  end;
end;

procedure TfrmDataAnalysis.actHelpExecute(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.