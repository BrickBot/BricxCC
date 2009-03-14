(*
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * The Initial Developer of this code is John Hansen.
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uWav2RSO;

interface

uses
  Classes, Controls, Forms, StdCtrls, Dialogs, Menus, 
  Buttons, DirectoryEdit, uSpin;

type
  TfrmWave2RSO = class(TForm)
    btnConvert: TButton;
    mmoMessages: TMemo;
    btnSelect: TButton;
    dlgOpen: TOpenDialog;
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
    chkUseCompression: TCheckBox;
    edtRate: TSpinEdit;
    edtPath2: TEdit;
    procedure btnSelectClick(Sender: TObject);
    procedure btnConvertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mniClearClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure OnPathChange(Sender: TObject);
  private
    function GetResampleMethod: integer;
    function GetSampleRate: integer;
    function GetUseCompression: boolean;
    procedure CreateDirectoryEdit;
  private
    { Private declarations }
    edtPath: TDirectoryEdit;
    property ResampleMethod : integer read GetResampleMethod;
    property SampleRate : integer read GetSampleRate;
    property UseCompression : boolean read GetUseCompression;
  public
    { Public declarations }
  end;

var
  frmWave2RSO: TfrmWave2RSO;

implementation

{$R *.dfm}

uses
  SysUtils, uSrcCommon, uWav2RsoCvt, uGuiUtils;

procedure TfrmWave2RSO.btnSelectClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
    lstWavFiles.Items.Assign(dlgOpen.Files);
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
      ConvertWave2RSO(filename, edtPath.Text, SampleRate, ResampleMethod, UseCompression, mmoMessages.Lines);
    Application.ProcessMessages;
  end;
end;

procedure TfrmWave2RSO.FormCreate(Sender: TObject);
begin
  CreateDirectoryEdit;
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

function TfrmWave2RSO.GetUseCompression: boolean;
begin
  Result := chkUseCompression.Checked;
end;

procedure TfrmWave2RSO.OnPathChange(Sender: TObject);
begin
  dlgOpen.InitialDir := edtPath.Text;
end;

procedure TfrmWave2RSO.CreateDirectoryEdit;
begin
  edtPath := TDirectoryEdit.Create(Self);
  CloneDE(edtPath, edtPath2);
  with edtPath do
  begin
    Name := 'edtPath';
    Parent := Self;
    Left := 104;
    Top := 8;
    Width := 337;
    Height := 21;
    Cursor := crNo;
    Hint := 'The specified output directory';
    AutoSize := False;
    ReadOnly := True;
    TabOrder := 9;
    OnChange := OnPathChange;
    SetHint := False;
  end;
end;

end.
