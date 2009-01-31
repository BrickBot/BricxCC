library NBCAutoLib;

uses
  FastMM4 in '..\FastMM4.pas',
  FastMM4Messages in '..\FastMM4Messages.pas',
  FastMove in '..\FastMove.pas',
  ComServ,
  NBCAutoLib_TLB in 'NBCAutoLib_TLB.pas',
  uNBCAuto in 'uNBCAuto.pas' {NBCAuto: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
