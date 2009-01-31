program ExpTest;

uses
  Forms,
  XPMan,
  uExpTest in 'uExpTest.pas' {frmExpTester},
  mwGenericLex in '..\mwGenericLex.pas',
  uCommonUtils in '..\uCommonUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmExpTester, frmExpTester);
  Application.Run;
end.
