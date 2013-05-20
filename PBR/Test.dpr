program Test;

uses
  Forms,
  uTest in 'uTest.pas' {Form1},
  uCompilerEmit in 'uCompilerEmit.pas',
  uStreamRW in '..\uStreamRW.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
