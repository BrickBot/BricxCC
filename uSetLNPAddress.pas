unit uSetLNPAddress;

interface

uses
  Classes, Controls, Forms, StdCtrls, uSpin;

type
  TfrmSetLNPAddress = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    Label1: TLabel;
    edtAddress: TSpinEdit;
    procedure edtAddressKeyPress(Sender: TObject; var Key: Char);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure SetLNPAddress;
  end;

implementation

{$R *.DFM}

uses
  SysUtils, Dialogs, Editor, brick_common, ExecProgram, Preferences, MainUnit,
  uLocalizedStrings, uCommonUtils;

const
  M_NAME = 'SetLNP.mak';

procedure SetAddress(i : Integer);
var
  commandstr, wd, fname : string;
  TheResult : Longint;
begin
  try
    wd := ExcludeTrailingPathDelimiter(GetCurrentDir);
    fname := wd + '\' + M_NAME;
    GenerateMakefile(fname, False, i);
    commandstr := '/bin/make set_addr -f"' + fname + '" -s';
    commandstr := ProcessMakeCommand(fname, '', commandstr);
    {Execute the command, and wait}
    BrickComm.Close;
    try
      TheResult := ExecuteAndWait(PChar(commandstr), SW_SHOWMINNOACTIVE, LocalCompilerTimeout, PChar(wd));
      if TheResult <> 0 then
        ShowMessage(sFailedToSetLNPAddr)
      else
        ShowMessage(Format(sSuccessfulSetLNPAddr, [i]));
    finally
      BrickComm.Open;
      // make sure the toolbar refreshes no matter what
      MainForm.HandleOpenStateChanged(nil);
    end;
  finally
    DeleteFile(fname);
    DeleteFile(ChangeFileExt(fname, '.cmd'));
  end;
end;

{ TfrmSetLNPAddress }

class procedure TfrmSetLNPAddress.SetLNPAddress;
begin
  with TfrmSetLNPAddress.Create(nil) do
  try
    if ShowModal = mrOK then
    begin
      SetAddress(edtAddress.Value);
    end;
  finally
    Free;
  end;
end;

procedure TfrmSetLNPAddress.edtAddressKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure TfrmSetLNPAddress.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
