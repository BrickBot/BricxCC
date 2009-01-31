program RXEDumper;

{$R 'RXEDumpImages.res' 'RXEDumpImages.rc'}

uses
  FastMM4,
  FastMove,
  Forms,
  XPMan,
  uRxeDump in 'uRxeDump.pas' {frmNXTDumper},
  uAbout in 'uAbout.pas' {frmAboutRXE},
  uNXTClasses in 'uNXTClasses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'NXT Program Dumper';
  Application.CreateForm(TfrmNXTDumper, frmNXTDumper);
  Application.Run;
end.
