unit uwav2rsolaz;

{$MODE Delphi}

interface

uses
  Classes, Controls, Forms, StdCtrls, Dialogs, Menus,
  LResources, Buttons, ComCtrls, Spin;

type

  { TfrmWave2RSO }

  TfrmWave2RSO = class(TForm)
    btnConvert: TButton;
    chkUseCompression: TCheckBox;
    edtRate: TSpinEdit;
    mmoMessages: TMemo;
    btnSelect: TButton;
    dlgOpen: TOpenDialog;
    btnOutputDir: TButton;
    edtPath: TEdit;
    lblMessages: TLabel;
    lstWavFiles: TListBox;
    pumFiles: TPopupMenu;
    mniClear: TMenuItem;
    grpResample: TGroupBox;
    radSinc1: TRadioButton;
    radSinc2: TRadioButton;
    radSinc3: TRadioButton;
    radZoh: TRadioButton;
    radLinear: TRadioButton;
    radNone: TRadioButton;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    lblRate: TLabel;
    procedure btnSelectClick(Sender: TObject);
    procedure btnOutputDirClick(Sender: TObject);
    procedure btnConvertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mniClearClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    function GetResampleMethod: integer;
    function GetSampleRate: integer;
  private
    { Private declarations }
    property ResampleMethod : integer read GetResampleMethod;
    property SampleRate : integer read GetSampleRate;
  public
    { Public declarations }
  end;

var
  frmWave2RSO: TfrmWave2RSO;

implementation


uses
  SysUtils, FileCtrl, uSrcCommon, uWav2RsoCvt;

procedure TfrmWave2RSO.btnSelectClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
    lstWavFiles.Items.Assign(dlgOpen.Files);
  end;
end;

procedure TfrmWave2RSO.btnOutputDirClick(Sender: TObject);
var
  Path : string;
begin
  Path := edtPath.Text;
  if SelectDirectory('Select output directory', '', Path) then
  begin
    edtPath.Text := Path;
    dlgOpen.InitialDir := Path;
  end;
end;

procedure TfrmWave2RSO.btnConvertClick(Sender: TObject);
var
  i : integer;
  filename : string;
begin
  mmoMessages.Clear;
  for i := 0 to lstWavFiles.Items.Count - 1 do
  begin
    filename := lstWavFiles.Items[i];
    if LowerCase(ExtractFileExt(filename)) = '.rso' then
      ConvertRSO2Wave(filename, edtPath.Text, mmoMessages.Lines)
    else
      ConvertWave2RSO(filename, edtPath.Text, SampleRate, ResampleMethod, chkUseCompression.Checked, mmoMessages.Lines);
    Application.ProcessMessages;
  end;
end;

procedure TfrmWave2RSO.FormCreate(Sender: TObject);
begin
  edtPath.Text := ExcludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  dlgOpen.InitialDir := edtPath.Text;
end;

procedure TfrmWave2RSO.mniClearClick(Sender: TObject);
begin
  lstWavFiles.Items.Clear;
end;

function TfrmWave2RSO.GetResampleMethod: integer;
begin
  if radSinc1.Checked then
    Result := SRC_SINC_BEST_QUALITY
  else if radSinc2.Checked then
    Result := SRC_SINC_MEDIUM_QUALITY
  else if radSinc3.Checked then
    Result := SRC_SINC_FASTEST
  else if radZoh.Checked then
    Result := SRC_ZERO_ORDER_HOLD
  else if radLinear.Checked then
    Result := SRC_LINEAR
  else
    Result := SRC_NONE;
end;

procedure TfrmWave2RSO.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

function TfrmWave2RSO.GetSampleRate: integer;
begin
  if radNone.Checked then
    Result := RSO_DEFAULT_RATE
  else
    Result := edtRate.Value;
end;

procedure TfrmWave2RSO.btnOKClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmWave2RSO.btnCancelClick(Sender: TObject);
begin
  Close;
end;

initialization
  {$i uwav2rsolaz.lrs}
  {$i uWav2RSO.lrs}

end.
