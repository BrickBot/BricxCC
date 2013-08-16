unit uDerpy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer,
  IdSocketHandle;

type
  TForm1 = class(TForm)
    IdUDPServer1: TIdUDPServer;
    Memo1: TMemo;
    procedure IdUDPServer1UDPRead(Sender: TObject; AData: TStream;
      ABinding: TIdSocketHandle);
    procedure IdUDPServer1Status(ASender: TObject;
      const AStatus: TIdStatus; const AStatusText: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.IdUDPServer1UDPRead(Sender: TObject; AData: TStream;
  ABinding: TIdSocketHandle);
begin
  Memo1.Lines.LoadFromStream(AData);
end;

procedure TForm1.IdUDPServer1Status(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: String);
begin
  Caption := AStatusText;
end;

end.
