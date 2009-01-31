library FakeSpiritLib;

uses
  FastMM4,
  FastMove,
  ComServ,
  FakeSpiritLib_TLB in 'FakeSpiritLib_TLB.pas',
  uFakeSpirit in 'uFakeSpirit.pas' {FakeSpirit: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
