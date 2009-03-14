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
unit uPromptSeries;

interface

uses
  Classes, Controls, Forms, StdCtrls, Chart;

type
  TfrmSeriesPrompt = class(TForm)
    lstSeries: TListBox;
    lblSeries: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    procedure btnHelpClick(Sender: TObject);
    procedure lstSeriesDblClick(Sender: TObject);
  private
    { Private declarations }
    FTheChart: TChart;
    procedure SetTheChart(const Value: TChart);
  public
    { Public declarations }
    property TheChart : TChart read FTheChart write SetTheChart;
    class function PromptForSeries(aChart : TChart) : integer;
  end;

implementation

{$R *.DFM}

{ TfrmSeriesPrompt }

class function TfrmSeriesPrompt.PromptForSeries(aChart: TChart): integer;
var
  F : TfrmSeriesPrompt;
begin
  result := -1;
  F := TfrmSeriesPrompt.Create(nil);
  try
    F.TheChart := aChart;
    if F.ShowModal = mrOK then
    begin
      result := F.lstSeries.ItemIndex;
    end;
  finally
    F.Free;
  end;
end;

procedure TfrmSeriesPrompt.SetTheChart(const Value: TChart);
var
  i : integer;
begin
  if FTheChart <> Value then
  begin
    FTheChart := Value;
    lstSeries.Items.Clear;
    for i := 0 to FTheChart.SeriesCount - 1 do
    begin
      lstSeries.Items.Add(FTheChart.Series[i].Title);
    end;
    if lstSeries.Items.Count > 0 then
      lstSeries.ItemIndex := 0;
  end;
end;

procedure TfrmSeriesPrompt.lstSeriesDblClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfrmSeriesPrompt.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
