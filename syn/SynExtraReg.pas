unit SynExtraReg;

interface

uses
  Classes,
  LResources,
  SynEditPrint,
  SynCompletionProposal,
  SynExportRTF;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('SynEdit Extras', [TSynEditPrint, TSynCompletionProposal, TSynExporterRTF]);
end;

end.

