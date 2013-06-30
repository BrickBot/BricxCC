program PBRTest;

uses
  Forms,
  uPBRTest in 'uPBRTest.pas' {Form1},
  uTransport in '..\bricktools\uTransport.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
