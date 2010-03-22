program RICFont;

uses
  Forms,
  uRICFont in 'uRICFont.pas' {frmRICFont};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'RIC Font Creator';
  Application.CreateForm(TfrmRICFont, frmRICFont);
  Application.Run;
end.
