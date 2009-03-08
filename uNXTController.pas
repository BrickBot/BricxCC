unit uNXTController;

interface

uses
  Classes, Graphics, Controls, Forms, ExtCtrls, StdCtrls, ComCtrls, uSpin;

type
  TfrmNXTController = class(TForm)
    grpPorts: TGroupBox;
    chkPortA: TCheckBox;
    chkPortB: TCheckBox;
    chkPortC: TCheckBox;
    grpDirection: TGroupBox;
    rbFwd: TRadioButton;
    rbRev: TRadioButton;
    rbStop: TRadioButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    btnHelp: TButton;
    grpSteering: TGroupBox;
    tbSteering: TTrackBar;
    cboTRLeft: TComboBox;
    cboTRRight: TComboBox;
    grpPower: TGroupBox;
    tbPower: TTrackBar;
    grpDuration: TGroupBox;
    cboDurType: TComboBox;
    GroupBox1: TGroupBox;
    radBrake: TRadioButton;
    radCoast: TRadioButton;
    btnRun: TButton;
    edtPower: TSpinEdit;
    edtDuration: TSpinEdit;
    procedure edtPowerChange(Sender: TObject);
    procedure tbPowerChange(Sender: TObject);
    procedure PortClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure cboDurTypeChange(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateControls;
  public
    { Public declarations }
  end;

var
  frmNXTController: TfrmNXTController;

implementation

{$R *.dfm}

uses
  Dialogs;

procedure TfrmNXTController.edtPowerChange(Sender: TObject);
begin
  tbPower.OnChange := nil;
  try
    tbPower.Position := edtPower.Value;
  finally
    tbPower.OnChange := tbPowerChange;
  end;
end;

procedure TfrmNXTController.tbPowerChange(Sender: TObject);
begin
  edtPower.OnChange := nil;
  try
    edtPower.Value := tbPower.Position;
  finally
    edtPower.OnChange := edtPowerChange;
  end;
end;

procedure TfrmNXTController.PortClick(Sender: TObject);
begin
  UpdateControls;
end;

procedure TfrmNXTController.FormCreate(Sender: TObject);
begin
  cboDurType.ItemIndex := 2;
  edtDuration.Value := 1;
end;

procedure TfrmNXTController.btnRunClick(Sender: TObject);
begin
  ShowMessage('Not implemented yet');
end;

procedure TfrmNXTController.UpdateControls;
var
  i : integer;
  tmpSL : TStringList;
begin
  // populate steering combos and select default values.
  // disable steering combos if 1 or 3 ports are selected.
  i := 0;
  tmpSL := TStringList.Create;
  try
    if chkPortA.Checked then begin
      inc(i);
      tmpSL.Add('A');
    end;
    if chkPortB.Checked then begin
      inc(i);
      tmpSL.Add('B');
    end;
    if chkPortC.Checked then begin
      inc(i);
      tmpSL.Add('C');
    end;
    cboTRLeft.Items.Assign(tmpSL);
    cboTRRight.Items.Assign(tmpSL);
    cboTRLeft.Enabled  := i=2;
    cboTRRight.Enabled := i=2;
    tbSteering.Enabled := i=2;
    cboTRLeft.ItemIndex := 0;
    cboTRRight.ItemIndex := 1;
  finally
    tmpSL.Free;
  end;
end;

procedure TfrmNXTController.cboDurTypeChange(Sender: TObject);
begin
  case cboDurType.ItemIndex of
    1 : edtDuration.Value := 360;
    0, 2, 3 : edtDuration.Value := 1;
  end;
  edtDuration.Enabled := cboDurType.ItemIndex <> 0;
  radBrake.Enabled    := edtDuration.Enabled;
  radCoast.Enabled    := radBrake.Enabled;
end;

end.
