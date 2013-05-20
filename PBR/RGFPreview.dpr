program RGFPreview;

uses
  Forms,
  uRGFPreview in 'uRGFPreview.pas' {frmRGFPreview};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'RGF Preview/Import';
  Application.CreateForm(TfrmRGFPreview, frmRGFPreview);
  Application.Run;
end.
