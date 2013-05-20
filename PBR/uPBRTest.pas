unit uPBRTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPBRMiscTypes, uPBRSimpleTypes, uBinaryRW, uHidDeviceTransport;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  x : TLeadByte;
begin
  x := lbNullTerminatedStringToFollow;
end;

end.
