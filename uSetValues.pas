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
unit uSetValues;

interface

uses
  Classes, Controls, Forms, ComCtrls, StdCtrls;

type
  TfrmSetValues = class(TForm)
    grpDest: TGroupBox;
    cboSource: TComboBox;
    lblSource: TLabel;
    lblValue: TLabel;
    edtValue: TEdit;
    udValue: TUpDown;
    grpOrigin: TGroupBox;
    edtValue2: TEdit;
    udValue2: TUpDown;
    cboSource2: TComboBox;
    lblSource2: TLabel;
    lblValue2: TLabel;
    btnSet: TButton;
    btnHelp: TButton;
    procedure cboSourceChange(Sender: TObject);
    procedure edtValueExit(Sender: TObject);
    procedure edtValueKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnSetClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    function GetIdx(Sender : TObject) : Integer;
    function GetUpDown(Sender : TObject) : TUpDown;
    function GetSourceIndex(idx : Integer = 0): Integer;
    procedure InitSources;
    procedure AdjustRangeOfValueSlider(source: Integer; ud : TUpDown);
    procedure UpdateControls;
  public
    { Public declarations }
  end;

var
  frmSetValues: TfrmSetValues;

implementation

{$R *.DFM}

uses
  SysUtils, Preferences, uSources, brick_common, uMiscDefines;

procedure TfrmSetValues.cboSourceChange(Sender: TObject);
begin
  AdjustRangeOfValueSlider(GetSourceIndex(GetIdx(Sender)), GetUpDown(Sender));
  UpdateControls;
end;

procedure TfrmSetValues.AdjustRangeOfValueSlider(source: Integer; ud : TUpDown);
var
  WS : WatchSources;
begin
  WS := BrickWatchSources[LocalBrickType];
  if ud = udValue then
  begin
    ud.Position := Max(WS[source].VMin, 0);
    ud.Min      := Max(WS[source].VMin, 0);
    ud.Max      := Min(WS[source].VMax, 255);
  end
  else
  begin
    ud.Position := WS[source].VMin;
    ud.Min      := WS[source].VMin;
    ud.Max      := WS[source].VMax;
  end;
end;

procedure TfrmSetValues.edtValueExit(Sender: TObject);
var
  i : Integer;
  ud : TUpDown;
begin
  // make sure text is valid
  ud := GetUpDown(Sender);
  i := StrToIntDef(TEdit(Sender).Text, -32768);
  if i > ud.Max then
    ud.Position := ud.Max
  else if i < ud.Min then
    ud.Position := ud.Min;
  TEdit(Sender).Text := IntToStr(ud.Position);
end;

procedure TfrmSetValues.edtValueKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, #16, '0'..'9']) then
    Key := #0;
end;

procedure TfrmSetValues.InitSources;
var
  i : Integer;
  WS : WatchSources;
begin
  WS := BrickWatchSources[LocalBrickType];
  cboSource.Items.Clear;
  cboSource2.Items.Clear;
  for i := low(WS) to high(WS) do
  begin
    if WS[i].Has then
    begin
      if not WS[i].RO then
        cboSource.Items.AddObject(WS[i].Name, TObject(i));
      cboSource2.Items.AddObject(WS[i].Name, TObject(i));
    end;
  end;
end;

function TfrmSetValues.GetSourceIndex(idx : Integer): Integer;
begin
  case idx of
    0 : Result := Integer(cboSource.Items.Objects[cboSource.ItemIndex]);
  else
    Result := Integer(cboSource2.Items.Objects[cboSource2.ItemIndex]);
  end;
end;

procedure TfrmSetValues.FormShow(Sender: TObject);
begin
  InitSources;
  UpdateControls;
end;

function TfrmSetValues.GetIdx(Sender: TObject): Integer;
begin
  Result := 0;
  if Sender = cboSource2 then
    Result := 1;
end;

function TfrmSetValues.GetUpDown(Sender: TObject): TUpDown;
begin
  Result := udValue;
  if (Sender = edtValue2) or (Sender = cboSource2) then
    Result := udValue2;
end;

procedure TfrmSetValues.btnSetClick(Sender: TObject);
begin
  BrickComm.SetSourceValue(GetSourceIndex(0),
                         udValue.Position,
                         GetSourceIndex(1),
                         udValue2.Position);
end;

procedure TfrmSetValues.UpdateControls;
begin
  btnSet.Enabled := (cboSource.ItemIndex <> -1) and (cboSource2.ItemIndex <> -1);
end;

procedure TfrmSetValues.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
