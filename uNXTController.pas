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
unit uNXTController;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
{$ENDIF}
  Classes, Graphics, Controls, Forms, ExtCtrls, StdCtrls, ComCtrls, BricxccSpin;

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
    edtPower: TBricxccSpinEdit;
    edtDuration: TBricxccSpinEdit;
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

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

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

{$IFDEF FPC}
initialization
  {$i uNXTController.lrs}
{$ENDIF}

end.
