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
 * The Initial Developer of this code is Mark Overmars.
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit Controller;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows,
{$ELSE}
  LResources,
{$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Buttons;

type
  TDirectForm = class(TForm)
    grpMotors: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    grpTasks: TGroupBox;
    TL0: TLabel;
    TL1: TLabel;
    TL2: TLabel;
    TL3: TLabel;
    TL4: TLabel;
    TL5: TLabel;
    TL6: TLabel;
    TL7: TLabel;
    TL8: TLabel;
    TL9: TLabel;
    StartAllBtn: TButton;
    StopAllBtn: TButton;
    SensorGroup: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    lblSensor2: TLabel;
    SensorType0: TComboBox;
    SensorMode0: TComboBox;
    SensorType1: TComboBox;
    SensorMode1: TComboBox;
    SensorType2: TComboBox;
    SensorMode2: TComboBox;
    grpVariables: TGroupBox;
    VariableBox: TComboBox;
    OperatorBox: TComboBox;
    ValueEdit: TEdit;
    SetBtn: TButton;
    ValueUpDown: TUpDown;
    FwdABtn: TSpeedButton;
    RevABtn: TSpeedButton;
    OffABtn: TSpeedButton;
    FloatABtn: TSpeedButton;
    SpeedA: TTrackBar;
    FwdBBtn: TSpeedButton;
    RevBBtn: TSpeedButton;
    OffBBtn: TSpeedButton;
    FloatBBtn: TSpeedButton;
    SpeedB: TTrackBar;
    FwdCBtn: TSpeedButton;
    RevCBtn: TSpeedButton;
    OffCBtn: TSpeedButton;
    FloatCBtn: TSpeedButton;
    SpeedC: TTrackBar;
    cboSource: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    btnHelp: TButton;
    RunTask0: TBitBtn;
    StopTask0: TBitBtn;
    StopTask1: TBitBtn;
    RunTask1: TBitBtn;
    StopTask2: TBitBtn;
    RunTask2: TBitBtn;
    StopTask3: TBitBtn;
    RunTask3: TBitBtn;
    StopTask4: TBitBtn;
    RunTask4: TBitBtn;
    StopTask5: TBitBtn;
    RunTask5: TBitBtn;
    StopTask6: TBitBtn;
    RunTask6: TBitBtn;
    StopTask7: TBitBtn;
    RunTask7: TBitBtn;
    StopTask8: TBitBtn;
    RunTask8: TBitBtn;
    StopTask9: TBitBtn;
    RunTask9: TBitBtn;
    lblSensor3: TLabel;
    SensorType3: TComboBox;
    SensorMode3: TComboBox;
    procedure SpeedChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RunTask0Click(Sender: TObject);
    procedure StopTask0Click(Sender: TObject);
    procedure StartAllBtnClick(Sender: TObject);
    procedure StopAllBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SensorTypeChange(Sender: TObject);
    procedure SensorModeChange(Sender: TObject);
    procedure SetBtnClick(Sender: TObject);
    procedure FwdABtnClick(Sender: TObject);
    procedure RevABtnClick(Sender: TObject);
    procedure OffABtnClick(Sender: TObject);
    procedure FloatABtnClick(Sender: TObject);
    procedure ValueEditKeyPress(Sender: TObject; var Key: Char);
    procedure ValueEditExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    procedure InitForm;
  public
    { Public declarations }
  end;

var
  DirectForm: TDirectForm;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  brick_common, rcx_constants, uSources, uLocalizedStrings, uGlobals;

var
  V_HEIGHT, V_MOTORS_TOP, V_VARS_TOP, V_TASKS_TOP, V_FUDGE,
  V_SENS_H, V_SENS_DELTA : Integer;

const
{$IFDEF FPC}
{$IFDEF Darwin}
  K_FUDGE      = -40;
  K_HEIGHT     = 530+80; //498;
  K_MOTORS_TOP = 146+40; //118;
  K_VARS_TOP   = 262+40; //234;
  K_TASKS_TOP  = 338+40; //310;
  K_SENS_DELTA = 32;
  K_SENS_H     = 140+40;
{$ENDIF}
{$IFNDEF Darwin}
  K_FUDGE      = 4;
  K_HEIGHT     = 530; //498;
  K_MOTORS_TOP = 146; //118;
  K_VARS_TOP   = 262; //234;
  K_TASKS_TOP  = 338; //310;
  K_SENS_DELTA = 32;
  K_SENS_H     = 140;
{$ENDIF}
{$ELSE}
  K_FUDGE      = 4;
  K_HEIGHT     = 530; //498;
  K_MOTORS_TOP = 146; //118;
  K_VARS_TOP   = 262; //234;
  K_TASKS_TOP  = 338; //310;
  K_SENS_DELTA = 32;
  K_SENS_H     = 140;
{$ENDIF}

{Dealing with the Sensors}

procedure TDirectForm.SensorTypeChange(Sender: TObject);
begin
  if Sender = nil then Exit;
  if TComboBox(Sender).ItemIndex >= 0 then
  begin
    BrickComm.SetSensorType(TComboBox(Sender).Tag, TComboBox(Sender).ItemIndex);
    SensorModeChange(FindComponent('SensorMode' + IntToStr(TComboBox(Sender).Tag)));
  end;
end;

procedure TDirectForm.SensorModeChange(Sender: TObject);
begin
  if Sender = nil then Exit;
  if TComboBox(Sender).ItemIndex >= 0 then
  begin
    BrickComm.SetSensorMode(TComboBox(Sender).Tag, TComboBox(Sender).ItemIndex, 0);
  end;
end;


{Dealing with the Motors}

function GetMotorNum(tag : integer) : Byte;
begin
  case tag of
    0 : result := 1;
    1 : result := 2;
  else
    result := 4;
  end;
end;

procedure TDirectForm.FwdABtnClick(Sender: TObject);
var
  n : integer;
begin
  if Sender = nil then Exit;
  n := GetMotorNum(TComponent(Sender).Tag);
  BrickComm.SetFwd(n);
  BrickComm.MotorsOn(n);
end;

procedure TDirectForm.RevABtnClick(Sender: TObject);
var
  n : integer;
begin
  if Sender = nil then Exit;
  n := GetMotorNum(TComponent(Sender).Tag);
  BrickComm.SetRwd(n);
  BrickComm.MotorsOn(n);
end;

procedure TDirectForm.OffABtnClick(Sender: TObject);
begin
  if Sender = nil then Exit;
  BrickComm.MotorsOff(GetMotorNum(TComponent(Sender).Tag));
end;

procedure TDirectForm.FloatABtnClick(Sender: TObject);
begin
  if Sender = nil then Exit;
  BrickComm.MotorsFloat(GetMotorNum(TComponent(Sender).Tag));
end;

procedure TDirectForm.SpeedChange(Sender: TObject);
begin
  if Sender = nil then Exit;
  BrickComm.SetMotorPower(GetMotorNum(TComponent(Sender).Tag), kRCX_ConstantType,
                        TTrackBar(Sender).Position);
end;


{Dealing with the Variables}

procedure TDirectForm.SetBtnClick(Sender: TObject);
var
  vnumb,
  val : integer;
  stype : byte;
begin
  stype := cboSource.ItemIndex;
  if IsScout and not ((stype = 0) or (stype = 2)) then
  begin
    stype := 2;
    cboSource.ItemIndex := stype;
    MessageDlg(sScoutSourceError, mtError, [mbOK], 0);
    Exit;
  end;
  // get the source type from the selected item.
  vnumb := VariableBox.ItemIndex;
  val   := ValueUpDown.Position;
  case OperatorBox.ItemIndex of
    0: BrickComm.SetVar(vnumb,stype,val);
    1: BrickComm.SumVar(vnumb,stype,val);
    2: BrickComm.SubVar(vnumb,stype,val);
    3: BrickComm.MulVar(vnumb,stype,val);
    4: BrickComm.DivVar(vnumb,stype,val);
    5: BrickComm.AndVar(vnumb,stype,val);
    6: BrickComm.OrVar(vnumb,stype,val);
    7: BrickComm.AbsVar(vnumb,stype,val);
    8: BrickComm.SgnVar(vnumb,stype,val);
  end;
end;

{Dealing with the Tasks}

procedure TDirectForm.RunTask0Click(Sender: TObject);
begin
  BrickComm.StartTask(TSpeedButton(Sender).Tag);
end;

procedure TDirectForm.StopTask0Click(Sender: TObject);
begin
  BrickComm.StopTask(TSpeedButton(Sender).Tag);
end;

procedure TDirectForm.StartAllBtnClick(Sender: TObject);
var
  i:integer;
  c : TCursor;
begin
  if Screen.Cursor = crHourGlass then Exit;
  c := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    if IsRCX then
    begin
      for i := 0 to 9 do BrickComm.StartTask(i);
    end else if IsScout then
    begin
      for i := 0 to 5 do BrickComm.StartTask(i);
    end else if IsSpybotic then
    begin
      for i := 8 to 15 do BrickComm.StartTask(i);
    end else begin // cybermaster
      for i := 0 to 3 do BrickComm.StartTask(i);
    end;
  finally
    Screen.Cursor := c;
  end;
end;

procedure TDirectForm.StopAllBtnClick(Sender: TObject);
begin
  BrickComm.StopAllTasks();
end;

procedure TDirectForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  if IsRCX then
//  begin
//    if (Key >='0') and (Key <='9') then
//      BrickComm.StartTask(Ord(Key)-Ord('0'));
//  end else begin
//    if (Key >='0') and (Key <='3') then
//      BrickComm.StartTask(Ord(Key)-Ord('0'));
//  end;
end;


{Handling the Window}

procedure TDirectForm.FormShow(Sender: TObject);
var
  c : TCursor;
begin
  c := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    InitForm;
  finally
    Screen.Cursor := c;
  end;
end;

procedure TDirectForm.ValueEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in  [#8, #16, '-', '0'..'9']) then
    Key := #0;
end;

procedure TDirectForm.ValueEditExit(Sender: TObject);
var
  val : integer;
begin
// ensure value is within range
  val := StrToInt(ValueEdit.Text);
  if val < ValueUpDown.Min then
    ValueEdit.Text := IntToStr(ValueUpDown.Min)
  else if val > ValueUpDown.Max then
    ValueEdit.Text := IntToStr(ValueUpDown.Max);
end;

procedure TDirectForm.InitForm;
var
  ttt, h, i, delta : integer;
  bVisible : boolean;
  tmpSL : TStrings;
  C : TComponent;
  WS : WatchSources;
const
  SPY_MODES : array[0..4] of Integer = (0, 1, -1, -1, 2);
begin
  tmpSL := TStringList.Create;
  try
    // load the source combobox
    WS := BrickWatchSources[LocalBrickType];
    for i := low(WS) to high(WS) do
    begin
      if WS[i].Has then
        cboSource.Items.AddObject(WS[i].Name, TObject(i));
    end;

    {Adapt to RCX type}
    for i:= 0 to 9 do
    begin
      bVisible := IsRCX or
                  (IsScout and (i in [0..5])) or
                  (IsSpybotic and (i in [0..7]));
      C := FindComponent('RunTask'+IntToStr(i));
      TSpeedButton(C).Visible := bVisible;
      if IsSpybotic then
        C.Tag := i + 8
      else
        C.Tag := i;
      C := FindComponent('StopTask'+IntToStr(i));
      if IsSpybotic then
        C.Tag := i + 8
      else
        C.Tag := i;
      TSpeedButton(C).Visible := bVisible;
      C := FindComponent('TL'+IntToStr(i));
      TLabel(C).Visible := bVisible;
      if IsSpybotic then
        TLabel(C).Caption := IntToStr(i+8)
      else
        TLabel(C).Caption := IntToStr(i);
    end;
    Height               := V_HEIGHT;
    SensorGroup.Visible  := True;
    grpVariables.Visible := True;
    grpTasks.Visible     := True;
    grpMotors.Top        := V_MOTORS_TOP;
    grpVariables.Top     := V_VARS_TOP;
    grpTasks.Top         := V_TASKS_TOP;
    SensorType2.Visible  := not IsSpybotic;
    SensorMode2.Visible  := not IsSpybotic;
    lblSensor2.Visible   := not IsSpybotic;
    SensorType3.Visible  := IsNXT;
    SensorMode3.Visible  := IsNXT;
    lblSensor3.Visible   := IsNXT;
    if IsRCX then
    begin
      SensorGroup.Height  := V_SENS_H - V_SENS_DELTA;
      grpMotors.Top       := V_MOTORS_TOP - V_SENS_DELTA - V_FUDGE;
      grpVariables.Top    := V_VARS_TOP - V_SENS_DELTA - V_FUDGE;
      grpTasks.Top        := V_TASKS_TOP - V_SENS_DELTA - V_FUDGE;
      Height              := V_HEIGHT  - V_SENS_DELTA - V_FUDGE;
      SensorType0.Enabled := true;
      SensorType1.Enabled := true;
      SensorType2.Enabled := true;
      tmpSL.Clear;
      tmpSL.Append(sRaw);
      tmpSL.Append(sBoolean);
      tmpSL.Append(sTransCount);
      tmpSL.Append(sPeriodCount);
      tmpSL.Append(sPercent);
      tmpSL.Append(sCelsius);
      tmpSL.Append(sFahrenheit);
      tmpSL.Append(sAngle);
      SensorMode0.Items.Assign(tmpSL);
      SensorMode1.Items.Assign(tmpSL);
      SensorMode2.Items.Assign(tmpSL);
      tmpSL.Clear;
      tmpSL.Append(sNone);
      tmpSL.Append(sSwitch);
      tmpSL.Append(sTemperature);
      tmpSL.Append(sLight);
      tmpSL.Append(sAngle);
      SensorType0.Items.Assign(tmpSL);
      SensorType1.Items.Assign(tmpSL);
      SensorType2.Items.Assign(tmpSL);
    end else if IsScout then begin
      // scout
      SensorGroup.Visible := False;
      grpMotors.Top       := V_MOTORS_TOP - SensorGroup.Height - V_FUDGE;
      grpVariables.Top    := V_VARS_TOP - SensorGroup.Height - V_FUDGE;
      grpTasks.Top        := V_TASKS_TOP - SensorGroup.Height - V_FUDGE;
      Height              := V_HEIGHT  - SensorGroup.Height - V_FUDGE;
    end else if IsNXT then begin
      Height               := V_HEIGHT - grpVariables.Height - grpTasks.Height - V_FUDGE;
      SensorGroup.Height   := V_SENS_H;
      grpVariables.Visible := False;
      grpTasks.Visible     := False;
      SensorGroup.Visible  := True;
      SensorType0.Enabled  := true;
      SensorType1.Enabled  := true;
      SensorType2.Enabled  := true;
      SensorType3.Enabled  := true;
      tmpSL.Clear;
      tmpSL.Append(sRaw);
      tmpSL.Append(sBoolean);
      tmpSL.Append(sTransCount);
      tmpSL.Append(sPeriodCount);
      tmpSL.Append(sPercent);
      tmpSL.Append(sCelsius);
      tmpSL.Append(sFahrenheit);
      tmpSL.Append(sAngle);
      SensorMode0.Items.Assign(tmpSL);
      SensorMode1.Items.Assign(tmpSL);
      SensorMode2.Items.Assign(tmpSL);
      SensorMode3.Items.Assign(tmpSL);
      tmpSL.Clear;
      tmpSL.Append(sNone);
      tmpSL.Append(sSwitch);
      tmpSL.Append(sTemperature);
      tmpSL.Append(sLight);
      tmpSL.Append(sAngle);
      tmpSL.Append(sLightActiv);
      tmpSL.Append(sLightInact);
      tmpSL.Append(sSoundDB);
      tmpSL.Append(sSoundDBA);
      tmpSL.Append(sCustom);
      tmpSL.Append(sLowspeed);
      tmpSL.Append(sLowspeed9v);
      tmpSL.Append(sHighspeed);
      tmpSL.Append(sColorFull);
      tmpSL.Append(sColorRed);
      tmpSL.Append(sColorGreen);
      tmpSL.Append(sColorBlue);
      tmpSL.Append(sColorNone);
      SensorType0.Items.Assign(tmpSL);
      SensorType1.Items.Assign(tmpSL);
      SensorType2.Items.Assign(tmpSL);
      SensorType3.Items.Assign(tmpSL);
    end else begin
      // cybermaster or spybot (sensor mode only)
      delta := V_SENS_DELTA;
      if IsSpybotic then
        delta := delta * 2;
      SensorGroup.Height  := V_SENS_H - delta;
      grpMotors.Top       := V_MOTORS_TOP - delta - V_FUDGE;
      grpVariables.Top    := V_VARS_TOP - delta - V_FUDGE;
      grpTasks.Top        := V_TASKS_TOP - delta - V_FUDGE;
      Height              := V_HEIGHT  - delta - V_FUDGE;
      SensorGroup.Visible := True;
      SensorType0.Enabled := false;
      SensorType1.Enabled := false;
      SensorType2.Enabled := false;
      tmpSL.Clear;
      if IsSpybotic then
      begin
        tmpSL.Append(sRaw);
        tmpSL.Append(sBoolean);
        tmpSL.Append(sPercent);
      end
      else
      begin
        tmpSL.Append(sRaw);
        tmpSL.Append(sBoolean);
        tmpSL.Append(sTransCount);
        tmpSL.Append(sPeriodCount);
        tmpSL.Append(sPercent);
      end;
      SensorMode0.Items.Assign(tmpSL);
      SensorMode1.Items.Assign(tmpSL);
      SensorMode2.Items.Assign(tmpSL);
      tmpSL.Clear;
      SensorType0.Items.Assign(tmpSL);
      SensorType1.Items.Assign(tmpSL);
      SensorType2.Items.Assign(tmpSL);
    end;
  finally
    tmpSL.Free;
  end;

  // variables
  if grpVariables.Visible then
  begin
    h := 31;
    if IsScout then
      h := 9;
    VariableBox.Items.Clear;
    for i := 0 to h do
      VariableBox.Items.Add(Format('Var %2d',[i]));
    VariableBox.ItemIndex := 0;
    OperatorBox.ItemIndex := 0;
    cboSource.ItemIndex   := 2;
  end;

  try
    {Set the motor items}
    ttt := BrickComm.GetOutputStatus(0);
    FwdABtn.Down    :=  (ttt div 128 = 1) and ((ttt mod 16) div 8 = 1);
    RevABtn.Down    :=  (ttt div 128 = 1) and ((ttt mod 16) div 8 = 0);
    OffABtn.Down    :=  (ttt div 128 = 0) and ((ttt mod 128) div 64 = 1);
    FloatABtn.Down  :=  (ttt div 128 = 0) and ((ttt mod 128) div 64 = 0);
    SpeedA.Position := ttt mod 8;

    ttt := BrickComm.GetOutputStatus(1);
    FwdBBtn.Down    :=  (ttt div 128 = 1) and ((ttt mod 16) div 8 = 1);
    RevBBtn.Down    :=  (ttt div 128 = 1) and ((ttt mod 16) div 8 = 0);
    OffBBtn.Down    :=  (ttt div 128 = 0) and ((ttt mod 128) div 64 = 1);
    FloatBBtn.Down  :=  (ttt div 128 = 0) and ((ttt mod 128) div 64 = 0);
    SpeedB.Position := ttt mod 8;

    ttt := BrickComm.GetOutputStatus(2);
    FwdCBtn.Down    :=  (ttt div 128 = 1) and ((ttt mod 16) div 8 = 1);
    RevCBtn.Down    :=  (ttt div 128 = 1) and ((ttt mod 16) div 8 = 0);
    OffCBtn.Down    :=  (ttt div 128 = 0) and ((ttt mod 128) div 64 = 1);
    FloatCBtn.Down  :=  (ttt div 128 = 0) and ((ttt mod 128) div 64 = 0);
    SpeedC.Position := ttt mod 8;

    if not IsScout then
    begin
      { Set the sensor Items }
      if IsRCX then
      begin
        SensorType0.ItemIndex := BrickComm.Poll(kRCX_InputTypeType,0);
        SensorType1.ItemIndex := BrickComm.Poll(kRCX_InputTypeType,1);
        SensorType2.ItemIndex := BrickComm.Poll(kRCX_InputTypeType,2);
      end
      else if IsNXT then
      begin
        SensorType0.ItemIndex := BrickComm.Poll(kRCX_InputTypeType,0);
        SensorType1.ItemIndex := BrickComm.Poll(kRCX_InputTypeType,1);
        SensorType2.ItemIndex := BrickComm.Poll(kRCX_InputTypeType,2);
        SensorType3.ItemIndex := BrickComm.Poll(kRCX_InputTypeType,3);
      end;

      ttt := BrickComm.Poll(kRCX_InputModeType,0);
      if IsSpybotic then
        SensorMode0.ItemIndex := SPY_MODES[ttt]
      else
        SensorMode0.ItemIndex := ttt div 32;
      ttt := BrickComm.Poll(kRCX_InputModeType,1);
      if IsSpybotic then
        SensorMode1.ItemIndex := SPY_MODES[ttt]
      else
        SensorMode1.ItemIndex := ttt div 32;
      if not IsSpybotic then
        SensorMode2.ItemIndex := BrickComm.Poll(kRCX_InputModeType,2) div 32;
      if IsNXT then
        SensorMode3.ItemIndex := BrickComm.Poll(kRCX_InputModeType,3) div 32;
    end;
  except
    ;
  end;
end;

procedure TDirectForm.FormCreate(Sender: TObject);
var
  scale_amount : double;
begin
  scale_amount := Screen.PixelsPerInch / 96;
  V_HEIGHT     := Trunc(K_HEIGHT * scale_amount);
  V_MOTORS_TOP := Trunc(K_MOTORS_TOP * scale_amount);
  V_VARS_TOP   := Trunc(K_VARS_TOP * scale_amount);
  V_TASKS_TOP  := Trunc(K_TASKS_TOP * scale_amount);
  V_FUDGE      := Trunc(K_FUDGE * scale_amount);
  V_SENS_DELTA := Trunc(K_SENS_DELTA * scale_amount);
  V_SENS_H     := Trunc(K_SENS_H * scale_amount);
end;

procedure TDirectForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

{$IFDEF FPC}
initialization
  {$i Controller.lrs}
{$ENDIF}

end.