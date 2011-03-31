unit SynExtraReg;

interface

uses
  Classes,
  LResources,
  SynEditPrint,
  SynEditPrintPreview,
  syncompprop,
  SynExportRTF;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('SynEdit Extras',
    [TSynEditPrint, TSynEditPrintPreview,
     TSynCompletionProposal, TSynExporterRTF]);
end;

end.

