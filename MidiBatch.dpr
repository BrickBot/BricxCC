program MidiBatch;

uses
  Forms,
  XPMan,
  uMidiBatch in 'uMidiBatch.pas' {frmMidiBatch};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MIDI -> RMD Batch Converter';
  Application.CreateForm(TfrmMidiBatch, frmMidiBatch);
  Application.Run;
end.
