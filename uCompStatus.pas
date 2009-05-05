unit uCompStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmCompStatus = class(TForm)
    edtMemo: TMemo;
    btnClose: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Clear;
    procedure AddMessage(const msg : string);
  end;

var
  frmCompStatus: TfrmCompStatus;

implementation

{$R *.dfm}

procedure TfrmCompStatus.FormShow(Sender: TObject);
begin
  Clear;
end;

procedure TfrmCompStatus.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCompStatus.AddMessage(const msg: string);
begin
  edtMemo.Lines.Add(TimeToStr(Now) + ' ' + msg);
end;

procedure TfrmCompStatus.Clear;
begin
  edtMemo.Lines.Clear;
end;

end.
