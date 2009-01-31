unit uPromptSeries;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Chart;

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
