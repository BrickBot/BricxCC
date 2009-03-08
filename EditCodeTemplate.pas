unit EditCodeTemplate;

interface

uses
  Classes, Controls, Forms, StdCtrls;

type
  TfrmEditCodeTemplate = class(TForm)
    lblName: TLabel;
    edtName: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    lblDesc: TLabel;
    edtDesc: TEdit;
    btnHelp: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    fIsNew : boolean;
    function GetDesc: string;
    function GetTemplateName: string;
    procedure SetDesc(const Value: string);
    procedure SetTemplateName(const Value: string);
    function GetNew: boolean;
    procedure SetNew(const Value: boolean);
    procedure RefreshCaption;
  public
    { Public declarations }
    property TemplateName : string read GetTemplateName write SetTemplateName;
    property Description : string read GetDesc write SetDesc;
    property NewTemplate : boolean read GetNew write SetNew;
  end;

implementation

uses
  uLocalizedStrings;

{$R *.DFM}

{ TfrmEditCodeTemplate }

function TfrmEditCodeTemplate.GetDesc: string;
begin
  Result := edtDesc.Text;
end;

function TfrmEditCodeTemplate.GetNew: boolean;
begin
  Result := fIsNew;
end;

function TfrmEditCodeTemplate.GetTemplateName: string;
begin
  Result := edtName.Text;
end;

procedure TfrmEditCodeTemplate.SetDesc(const Value: string);
begin
  edtDesc.Text := Value;
end;

procedure TfrmEditCodeTemplate.SetNew(const Value: boolean);
begin
  fIsNew := Value;
  RefreshCaption;
end;

procedure TfrmEditCodeTemplate.SetTemplateName(const Value: string);
begin
  edtName.Text := Value;
end;

procedure TfrmEditCodeTemplate.FormCreate(Sender: TObject);
begin
  fIsNew := False;
  RefreshCaption;
end;

procedure TfrmEditCodeTemplate.RefreshCaption;
begin
  if NewTemplate then
    Caption := sNewTemplate
  else
    Caption := sEditTemplate;
end;

procedure TfrmEditCodeTemplate.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
