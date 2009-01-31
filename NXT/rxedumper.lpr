program rxedumper;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { add your units here }, urxedumplaz, mwGenericLex;

begin
  Application.Title:='NBC Program Dumper';
  Application.Initialize;
  Application.CreateForm(TfrmRxeDumpLaz, frmRxeDumpLaz);
  Application.Run;
end.

