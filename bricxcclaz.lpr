program bricxcclaz;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { you can add units after this }, MainUnitLaz, pascalscript;

{$IFDEF WINDOWS}{$R manifest.rc}{$ENDIF}

begin
  Application.Title:='Bricx Command Center';
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

