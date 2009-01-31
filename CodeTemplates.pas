unit CodeTemplates;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  GX_IDECodeTemplates, StdCtrls, Grids, Math;

type
  TfrmCodeTemplates = class(TForm)
    dlgOpen: TOpenDialog;
    grpTemplates: TGroupBox;
    grdTemplates: TStringGrid;
    btnAdd: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    lblTemplate: TLabel;
    lblCode: TLabel;
    mmoCode: TMemo;
    dlgSave: TSaveDialog;
    btnOK: TButton;
    btnCancel: TButton;
    btnLoad: TButton;
    btnSave: TButton;
    btnHelp: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure grdTemplatesSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure mmoCodeChange(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    FTemplates : TIDECodeTemplateList;
    procedure RefreshTemplates;
    procedure RefreshCode(const aRow : integer);
    procedure RefreshButtons;
    function CurrentTemplate : integer;
    procedure SetCurrentTemplate(i : integer);
    function GetCodeTemplates: TStrings;
    procedure SetCodeTemplates(const Value: TStrings);
  public
    { Public declarations }
    property CodeTemplates : TStrings read GetCodeTemplates write SetCodeTemplates;
  end;

var
  frmCodeTemplates: TfrmCodeTemplates;

implementation

{$R *.DFM}

uses
  EditCodeTemplate;

procedure TfrmCodeTemplates.FormCreate(Sender: TObject);
begin
  fTemplates := TIDECodeTemplateList.Create;
  grdTemplates.Cells[0,0] := 'Name';
  grdTemplates.Cells[1,0] := 'Description';
  RefreshTemplates;
end;

procedure TfrmCodeTemplates.FormDestroy(Sender: TObject);
begin
  FTemplates.Free;
end;

procedure TfrmCodeTemplates.btnLoadClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
    FTemplates.LoadFromFile(dlgOpen.FileName);
  end;
  RefreshTemplates;
end;

procedure TfrmCodeTemplates.RefreshTemplates;
var
  i : integer;
begin
  grdTemplates.RowCount := Max(FTemplates.Count + 1, 2);
  if FTemplates.Count = 0 then begin
    grdTemplates.Cells[0, 1] := '';
    grdTemplates.Cells[1, 1] := '';
  end
  else begin
    for i := 0 to FTemplates.Count - 1 do begin
      grdTemplates.Cells[0, i+1] := FTemplates.Templates[i].Name;
      grdTemplates.Cells[1, i+1] := FTemplates.Templates[i].Description;
    end;
  end;
  if FTemplates.Count > 0 then begin
    SetCurrentTemplate(0);
  end;
  RefreshButtons;
end;

procedure TfrmCodeTemplates.grdTemplatesSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  RefreshCode(ARow);
end;

procedure TfrmCodeTemplates.btnSaveClick(Sender: TObject);
begin
  if dlgSave.Execute then begin
    FTemplates.SaveToFile(dlgSave.Filename);
  end;
end;

procedure TfrmCodeTemplates.btnDeleteClick(Sender: TObject);
var
  i : integer;
begin
  i := CurrentTemplate;
  if i < FTemplates.Count then begin
    FTemplates.Delete(i);
    RefreshTemplates;
    grdTemplates.Row := Min(i+1, grdTemplates.RowCount-1);
  end;
end;

procedure TfrmCodeTemplates.RefreshCode(const aRow : integer);
var
  e : TNotifyEvent;
begin
  e := mmoCode.OnChange;
  try
    mmoCode.OnChange := nil;
    mmoCode.Lines.Clear;
    if FTemplates.Count >= aRow then
      mmoCode.Lines.Assign(FTemplates.Templates[aRow-1].Code);
    mmoCode.ReadOnly := FTemplates.Count = 0;
  finally
    mmoCode.OnChange := e;
  end;
end;

procedure TfrmCodeTemplates.RefreshButtons;
var
  bEnabled : boolean;
begin
  bEnabled := FTemplates.Count > 0;
  btnDelete.Enabled := bEnabled;
  btnEdit.Enabled   := bEnabled;
end;

procedure TfrmCodeTemplates.btnEditClick(Sender: TObject);
var
  i : integer;
begin
  i := CurrentTemplate;
  if i < FTemplates.Count then begin
    with TfrmEditCodeTemplate.Create(nil) do
    try
      TemplateName := FTemplates.Templates[i].Name;
      Description  := FTemplates.Templates[i].Description;
      if ShowModal = mrOK then begin
        FTemplates.Templates[i].Name := TemplateName;
        FTemplates.Templates[i].Description := Description;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TfrmCodeTemplates.btnAddClick(Sender: TObject);
var
  t : TIDECodeTemplate;
  i : integer;
begin
  with TfrmEditCodeTemplate.Create(nil) do
  try
    NewTemplate := True;
    if ShowModal = mrOK then begin
      t := FTemplates.Add;
      t.Name        := TemplateName;
      t.Description := Description;
      t.Code.Text   := '';
      FTemplates.Sort;
      i := FTemplates.IndexOf(TemplateName);
      RefreshTemplates;
      SetCurrentTemplate(i);
    end;
  finally
    Free;
  end;
end;

function TfrmCodeTemplates.CurrentTemplate: integer;
begin
  Result := grdTemplates.Row - 1;
end;

procedure TfrmCodeTemplates.mmoCodeChange(Sender: TObject);
var
  i : integer;
begin
  i := CurrentTemplate;
  if i < FTemplates.Count then begin
    if FTemplates.Templates[i].Code.Text <> mmoCode.Lines.Text then begin
      FTemplates.Templates[i].Code.Text := mmoCode.Lines.Text;
    end;
  end;
end;

procedure TfrmCodeTemplates.SetCurrentTemplate(i: integer);
begin
  grdTemplates.Row := i + 1;
  RefreshCode(grdTemplates.Row);
end;

function TfrmCodeTemplates.GetCodeTemplates: TStrings;
begin
  Result := FTemplates.AsStrings;
end;

procedure TfrmCodeTemplates.SetCodeTemplates(const Value: TStrings);
begin
  FTemplates.AsStrings := Value;
  RefreshTemplates;
end;

procedure TfrmCodeTemplates.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
