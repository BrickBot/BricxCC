program MidiBatchMac;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { add your units here }, umidibatchlaz;

{$IFDEF WINDOWS}{$R manifest.rc}{$ENDIF}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMidiBatch, frmMidiBatch);
  Application.Run;
end.

