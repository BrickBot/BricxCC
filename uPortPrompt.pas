unit uPortPrompt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmPortPrompt = class(TForm)
    lblPort: TLabel;
    chkUseBluetooth: TCheckBox;
    btnOK: TButton;
    btnCancel: TButton;
    cboPort: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    function GetPort: string;
    function GetUseBT: Boolean;
    { Private declarations }
  public
    { Public declarations }
    property Port : string read GetPort;
    property UseBT : Boolean read GetUseBT;
  end;

var
  frmPortPrompt: TfrmPortPrompt;

implementation

{$R *.dfm}

uses
  brick_common, uSpirit, uGuiUtils;

{ TfrmPortPrompt }

function TfrmPortPrompt.GetPort: string;
begin
  Result := cboPort.Text;
end;

function TfrmPortPrompt.GetUseBT: Boolean;
begin
  Result := chkUseBluetooth.Checked;
end;

procedure TfrmPortPrompt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
  begin
    chkUseBluetooth.Checked := False;
    cboPort.Text := 'usb';
  end;
end;

procedure TfrmPortPrompt.FormCreate(Sender: TObject);
begin
  if not FileExists(GetInitFilename) then
    CreateInitFile;
  cboPort.Items.Add('usb');
  LoadNXTPorts(cboPort.Items);
  SizeComboboxDropdown(cboPort);
  cboPort.Text := 'usb';
end;

end.
