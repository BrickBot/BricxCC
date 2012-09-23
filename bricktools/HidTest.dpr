program HidTest;

uses
  Forms,
  hidapi in 'hidapi.pas',
  uHidTest in 'uHidTest.pas' {frmHIDDevices};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHIDDevices, frmHIDDevices);
  Application.Run;
end.
