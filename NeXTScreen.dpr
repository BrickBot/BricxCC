program NeXTScreen;

{$R 'ToolbarBackground.res' 'ToolbarBackground.rc'}
{$R 'NXTSound.res' 'NXTSound.rc'}

uses
  Forms,
  XPMan,
  Dialogs,
  brick_common in 'bricktools\brick_common.pas',
  uSpirit in 'bricktools\uSpirit.pas',
  uPortPrompt in 'uPortPrompt.pas' {frmPortPrompt},
  uNXTImage in 'uNXTImage.pas' {frmNXTImage};

{$R *.res}

begin
  LocalBrickType := rtNXT;
  BrickComm.BrickType := rtNXT;
  Application.Initialize;
  Application.Title := 'NeXT Screen';
  // prompt for port and use BT.
  Application.CreateForm(TfrmNXTImage, frmNXTImage);
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
    Application.Run;
  end
  else
    ShowMessage('Unable to connect to the selected NXT brick.');
end.
