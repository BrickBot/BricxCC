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
unit uChartExport;

interface

uses
  Classes, Controls, Forms, Dialogs, StdCtrls, Chart;

type
  TfrmChartExport = class(TForm)
    GroupBox1: TGroupBox;
    radBmp: TRadioButton;
    radWMF: TRadioButton;
    radEMF: TRadioButton;
    btnClipboard: TButton;
    btnSave: TButton;
    btnClose: TButton;
    dlgSave: TSaveDialog;
    btnHelp: TButton;
    procedure btnClipboardClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormatClicked(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    FChart: TChart;
    procedure SetChart(const Value: TChart);
  public
    { Public declarations }
    property Chart : TChart read FChart write SetChart;
    class procedure DoExport(aChart : TChart);
  end;

implementation

{$R *.DFM}

procedure TfrmChartExport.btnClipboardClick(Sender: TObject);
begin
  if radBMP.Checked then
  begin
    Chart.CopyToClipboardBitmap;
  end
  else
  begin
    Chart.CopyToClipboardMetafile(radEMF.Checked);
  end;
end;

procedure TfrmChartExport.btnSaveClick(Sender: TObject);
begin
  if dlgSave.Execute then
  begin
    if radBMP.Checked then
    begin
      Chart.SaveToBitmapFile(dlgSave.FileName);
    end
    else if radWMF.Checked then
    begin
      Chart.SaveToMetafile(dlgSave.FileName);
    end
    else
    begin
      Chart.SaveToMetafileEnh(dlgSave.FileName);
    end;
  end;
end;

class procedure TfrmChartExport.DoExport(aChart: TChart);
begin
  with TfrmChartExport.Create(nil) do
  try
    Chart := aChart;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmChartExport.FormatClicked(Sender: TObject);
const
  fname : array[1..3] of string = ('Chart.BMP', 'Chart.WMF', 'Chart.EMF');
begin
  if Sender is TRadioButton then
  begin
    dlgSave.FileName := fname[TRadioButton(Sender).Tag];
    dlgSave.FilterIndex := TRadioButton(Sender).Tag;
  end;
end;

procedure TfrmChartExport.SetChart(const Value: TChart);
begin
  FChart := Value;
end;

procedure TfrmChartExport.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.