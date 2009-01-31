program RmdPlayer;

uses
  Forms,
  XPMan,
  uRmdPlayer in 'uRmdPlayer.pas' {frmRmdPlayer};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'NXT Melody Player';
  Application.CreateForm(TfrmRmdPlayer, frmRmdPlayer);
  Application.Run;
end.
