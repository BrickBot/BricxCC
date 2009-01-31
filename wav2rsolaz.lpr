program wav2rsolaz;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { add your units here }, uwav2rsolaz;

{$IFDEF WINDOWS}{$R manifest.rc}{$ENDIF}

begin
  Application.Initialize;
  Application.CreateForm(TfrmWave2RSO, frmWave2RSO);
  Application.Run;
end.

