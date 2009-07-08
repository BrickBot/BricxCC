program NeXTExplorer;

{$MODE Delphi}

uses
  {$IFDEF FPC}
  cthreads,
  LDockTree,
  Interfaces, // this includes the LCL widgetset
  {$ENDIF}
  Forms,
  {XPMan,}
  Dialogs,
  brick_common in 'bricktools/brick_common.pas',
  uSpirit in 'bricktools/uSpirit.pas',
  uNXTExplorer in 'uNXTExplorer.pas' {frmNXTExplorer},
  uPortPrompt in 'uPortPrompt.pas' {frmPortPrompt};

begin
  LocalBrickType := rtNXT;
  BrickComm.BrickType := rtNXT;
  Application.Initialize;
  Application.Title := 'NeXT Explorer';
  // prompt for port and use BT.
  with TfrmPortPrompt.Create(nil) do
  try
    ShowModal;
    BrickComm.Port := Port;
    BrickComm.UseBluetooth := UseBT;
  finally
    Free;
  end;
  if BrickComm.Open then
  begin
    BrickComm.Ping;
    Application.CreateForm(TfrmNXTExplorer, frmNXTExplorer);
    Application.Run;
  end
  else
    ShowMessage('Unable to connect to NXT');
end.
