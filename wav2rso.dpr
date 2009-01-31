program wav2rso;

uses
  FastMM4,
  FastMove,
  Forms,
  XPMan,
  uWav2RSO in 'uWav2RSO.pas' {frmWave2RSO},
  uSrcZoh in 'samplerate\uSrcZoh.pas',
  uSrcLinear in 'samplerate\uSrcLinear.pas',
  uSrcSinc in 'samplerate\uSrcSinc.pas',
  uSrcCommon in 'samplerate\uSrcCommon.pas',
  uSrc in 'samplerate\uSrc.pas',
  uCommonUtils in 'uCommonUtils.pas',
  uWav2RsoCvt in 'uWav2RsoCvt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'WAV 2 RSO';
  Application.CreateForm(TfrmWave2RSO, frmWave2RSO);
  Application.Run;
end.
