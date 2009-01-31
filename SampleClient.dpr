program SampleClient;

uses
  Forms,
  uSampleClient in 'uSampleClient.pas' {frmJoystick};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmJoystick, frmJoystick);
  Application.Run;
end.
