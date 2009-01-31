unit CPDReg;

interface

procedure Register;

implementation

uses
  // Delphi units
  Classes,
  // ComDrv32 units
  CPDrv,
  // syn edit terminal
  SynTerm;

{$R ComDrv32.dcr}

const
  TargetTab = 'Communication';

procedure Register;
begin
  RegisterComponents( TargetTab, [CPDrv.TCommPortDriver, CPDrv.TUSBPortDriver, SynTerm.TSynTerm]);
end;

end.
