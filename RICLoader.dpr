program RICLoader;

uses
  Forms,
  XPMan,
  uRICLoader in 'uRICLoader.pas' {frmRICLoader},
  uRICView in 'uRICView.pas' {frmRICView},
  uRIC in 'nxt\uRIC.pas',
  uRICComp in 'nxt\uRICComp.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'RIC Loader';
  Application.CreateForm(TfrmRICLoader, frmRICLoader);
  Application.CreateForm(TfrmRICView, frmRICView);
  Application.Run;
end.
