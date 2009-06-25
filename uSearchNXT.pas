unit uSearchNXT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TfrmSearchNXT = class(TForm)
    barProgress: TProgressBar;
    tmrMain: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure tmrMainTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    function GetText: string;
    procedure SetText(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    procedure Done;
    property Text : string read GetText write SetText;
  end;

implementation

{$R *.dfm}

uses
  Math;

{ TfrmSearchNXT }

function TfrmSearchNXT.GetText: string;
begin
  Result := Caption;
end;

procedure TfrmSearchNXT.SetText(const Value: string);
begin
  Caption := Value;
end;

procedure TfrmSearchNXT.FormCreate(Sender: TObject);
begin
  barProgress.Position := barProgress.Min;
end;

procedure TfrmSearchNXT.tmrMainTimer(Sender: TObject);
begin
  barProgress.Position := Min(barProgress.Position + 1, barProgress.Max);
  if barProgress.Position = barProgress.Max then
    barProgress.Position := barProgress.Min;
end;

procedure TfrmSearchNXT.Done;
begin
  barProgress.Position := barProgress.Max;
  Application.ProcessMessages;
  Sleep(100);
end;

procedure TfrmSearchNXT.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := False;
end;

end.
