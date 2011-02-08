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
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit JoystickUnit;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
  LCLType,
{$ENDIF}
  Classes, Controls, Forms, ExtCtrls, StdCtrls, ComCtrls, Buttons;

type
  TJoystickForm = class(TForm)
    JoyTimer: TTimer;
    grpLeftMotor: TGroupBox;
    LMotorA: TRadioButton;
    LMotorB: TRadioButton;
    LMotorC: TRadioButton;
    LReversed: TCheckBox;
    grpRightMotor: TGroupBox;
    RMotorA: TRadioButton;
    RMotorB: TRadioButton;
    RMotorC: TRadioButton;
    RReversed: TCheckBox;
    grpSpeed: TGroupBox;
    SpeedBar: TTrackBar;
    grpDriveMode: TGroupBox;
    LeftRightBtn: TRadioButton;
    DriveSteerBtn: TRadioButton;
    grpMovement: TGroupBox;
    DirBtn7: TSpeedButton;
    DirBtn8: TSpeedButton;
    DirBtn9: TSpeedButton;
    DirBtn4: TSpeedButton;
    DirBtn5: TSpeedButton;
    DirBtn6: TSpeedButton;
    DirBtn1: TSpeedButton;
    DirBtn2: TSpeedButton;
    DirBtn3: TSpeedButton;
    Task1Btn: TBitBtn;
    Task2Btn: TBitBtn;
    btnHelp: TButton;
    procedure JoyTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure LReversedClick(Sender: TObject);
    procedure RReversedClick(Sender: TObject);
    procedure SpeedBarChange(Sender: TObject);
    procedure RMotorClick(Sender: TObject);
    procedure LMotorClick(Sender: TObject);
    procedure LeftRightBtnClick(Sender: TObject);
    procedure DriveSteerBtnClick(Sender: TObject);
    procedure DirBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DirBtnClick(Sender: TObject);
    procedure TaskBtnClick(Sender: TObject);
    procedure DirBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
{$IFNDEF NXT_ONLY}
    function GetTaskOffset : integer;
{$ENDIF}
    procedure DoJoyButton(const i : byte; bPress : boolean);
    procedure SetSpeed(const val : word);
  public
    { Public declarations }
  end;

var
  JoystickForm: TJoystickForm;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
{$IFNDEF FPC}
  Windows,
  MMSystem,
{$ENDIF}
{$IFNDEF NXT_ONLY}
  MainUnit, Dialogs,
{$ENDIF}
  SysUtils, brick_common, uLocalizedStrings, uJoyGlobals, uGlobals;

var oldldir:integer =100;                   // previous left motor direction
    oldrdir:integer =100;                   // previous right motor direction
    oldspeed:integer = 100;                 // previous motor speed
    oldbuttons:array[1..32] of boolean =    // previous status of buttons
               (false,false,false,false,
                false,false,false,false,
                false,false,false,false,
                false,false,false,false,
                false,false,false,false,
                false,false,false,false,
                false,false,false,false,
                false,false,false,false);

    ldirA:array[1..9] of integer =
               ( 0,-1,-1,-1, 0, 1, 0, 1, 1);
    rdirA:array[1..9] of integer =
               (-1,-1, 0, 1, 0,-1, 1, 1, 0);
    ldirB:array[1..9] of integer =
               (-1,-1,-1, 0, 0, 0, 1, 1, 1);
    rdirB:array[1..9] of integer =
               (-1, 0, 1,-1, 0, 1,-1, 0, 1);

procedure ExecuteScript(const i: byte; bPress : boolean);
{$IFDEF NXT_ONLY}
begin
{$ELSE}
var
  fname : string;
begin
  fname := GetJoystickButtonScript(i, bPress);
  if FileExists(fname) then begin
    MainForm.ce.MainFileName := fname;
    MainForm.ce.Script.LoadFromFile(fname);
    if MainForm.ce.Compile then
      MainForm.ce.Execute
    else
      ShowMessage(MainForm.ce.CompilerMessages[0].MessageToString);
  end;
{$ENDIF}
end;

function GetMotorList(m1 : integer; m2 : integer = -1) : Byte;
var
  b1, b2 : Byte;
begin
  case m1 of
     0 : b1 := 1;
     1 : b1 := 2;
     2 : b1 := 4;
  else
    b1 := 0;
  end;
  case m2 of
     0 : b2 := 1;
     1 : b2 := 2;
     2 : b2 := 4;
  else
    b2 := 0;
  end;
  result := b1 + b2;
end;

procedure MoveRCX(dir:integer);
{Computes the correct directions and set the motors}
var
  ldir,rdir:integer;
  l, r, lr : Byte;
  sp : TSpeedButton;
begin
  {Show direction}
  sp := TSpeedButton(JoystickForm.FindComponent('DirBtn'+IntToStr(dir)));
  if not Assigned(sp) then Exit;

  sp.Down := True;

  {Convert dir to directions for the motors}
  if LeftRight then
  begin
    ldir := ldirA[dir];
    rdir := rdirA[dir];
  end
  else
  begin
    ldir := ldirB[dir];
    rdir := rdirB[dir];
  end;

  if LeftReversed then
    ldir := -ldir;
  if RightReversed then
    rdir := -rdir;

  l  := GetMotorList(LeftMotor);
  r  := GetMotorList(RightMotor);
  lr := GetMotorList(LeftMotor, RightMotor);

  {Execute the motions}
  if MotorSpeed <> oldspeed then
  begin
    BrickComm.SetMotorPower(lr, 2, MotorSpeed);
  end;

  if (ldir <> oldldir) or (rdir <> oldrdir) then
  begin
    if ldir < 0 then
    begin
      if rdir = 0 then
      begin
        BrickComm.MotorsOff(r);
        BrickComm.SetRwd(l);
        BrickComm.MotorsOn(l);
      end
      else if rdir > 0 then
      begin
        BrickComm.SetRwd(l);
        BrickComm.SetFwd(r);
        BrickComm.MotorsOn(lr);
      end
      else // if rdir < 0 then
      begin
        BrickComm.SetRwd(lr);
        BrickComm.MotorsOn(lr);
      end;
    end
    else if ldir > 0 then
    begin
      if rdir = 0 then
      begin
        BrickComm.MotorsOff(r);
        BrickComm.SetFwd(l);
        BrickComm.MotorsOn(l);
      end
      else if rdir > 0 then
      begin
        BrickComm.SetFwd(lr);
        BrickComm.MotorsOn(lr);
      end
      else // if rdir < 0 then
      begin
        BrickComm.SetFwd(l);
        BrickComm.SetRwd(r);
        BrickComm.MotorsOn(lr);
      end;
    end
    else
    begin
      if rdir = 0 then
      begin
        BrickComm.MotorsOff(lr);
      end
      else if rdir > 0 then
      begin
        BrickComm.MotorsOff(l);
        BrickComm.SetFwd(r);
        BrickComm.MotorsOn(r);
      end
      else // if rdir < 0 then
      begin
        BrickComm.MotorsOff(l);
        BrickComm.SetRwd(r);
        BrickComm.MotorsOn(r);
      end;
    end;
  end;

  {Save the values}
  oldldir := ldir;
  oldrdir := rdir;
  oldspeed := MotorSpeed;
end;

var
  oldjoydir : integer = 5;
  oldrudder : Cardinal;

procedure TJoystickForm.JoyTimerTimer(Sender: TObject);
{ The timer callback that does the actual work}
{$IFDEF FPC}
begin
{$ELSE}
var
  joyinfo : TJoyInfoEx;
  buttons : array [1..32] of boolean;
  i : integer;
  dir : integer;
begin
  {Get the joystick value and check for errors}
//  FillChar(joyinfo, SizeOf(TJoyInfoEx), 0);
  joyinfo.dwSize := SizeOf(TJoyInfoEx);
  joyinfo.dwFlags := JOY_RETURNALL;
  if joyGetPosEx(JOYSTICKID1,@joyinfo) <> JOYERR_NOERROR then
    Exit;

  {Handle the position}
  if (joyinfo.wYpos<20000) then      dir:=6
  else if (joyinfo.wYpos>44000) then dir:=0
  else                               dir:=3;
  if (joyinfo.wXpos<20000) then      dir:=dir+1
  else if (joyinfo.wXpos>44000) then dir:=dir+3
  else                               dir:=dir+2;

  if dir <> oldjoydir then
    MoveRCX(dir);
  oldjoydir := dir;

  if joyinfo.wZpos <> oldrudder then begin
    oldrudder := joyinfo.wZpos;
    SetSpeed(oldrudder);
  end;


  {Handle the buttons}
  for i := 1 to 32 do
    buttons[i] := ((1 shl (i-1)) and joyinfo.wButtons) > 0;
  for i := 1 to 32 do
  begin
    if buttons[i] <> oldbuttons[i] then
    begin
      // a press or release event
      oldbuttons[i] := buttons[i];
      DoJoyButton(byte(i), buttons[i]);
    end;
  end;
{$ENDIF}
end;

procedure TJoystickForm.DirBtnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MoveRCX(TSpeedButton(Sender).Tag);
end;

procedure TJoystickForm.DirBtnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button <> mbRight then MoveRCX(5);
end;

procedure TJoystickForm.DirBtnClick(Sender: TObject);
begin
  MoveRCX(5);
end;

procedure TJoystickForm.TaskBtnClick(Sender: TObject);
begin
  DoJoyButton(TBitBtn(Sender).Tag, True);
end;

procedure TJoystickForm.LeftRightBtnClick(Sender: TObject);
begin
  grpLeftMotor.Caption := sLeftMotor;
  grpRightMotor.Caption := sRightMotor;
  LeftRight := true;
end;

procedure TJoystickForm.DriveSteerBtnClick(Sender: TObject);
begin
  grpLeftMotor.Caption := sDriveMotor;
  grpRightMotor.Caption := sSteerMotor;
  LeftRight := false;
end;

procedure TJoystickForm.LMotorClick(Sender: TObject);
begin
  {Left motor selection}
  LeftMotor := TRadioButton(Sender).Tag;
end;

procedure TJoystickForm.LReversedClick(Sender: TObject);
begin
  {Left Reverse selection}
  LeftReversed := LReversed.Checked;
end;

procedure TJoystickForm.RMotorClick(Sender: TObject);
begin
  {Right motor selection}
  RightMotor := TRadioButton(Sender).Tag;
end;

procedure TJoystickForm.RReversedClick(Sender: TObject);
begin
  {Right reverse selection}
  RightReversed := RReversed.Checked;
end;

procedure TJoystickForm.SpeedBarChange(Sender: TObject);
begin
  {Speed selection}
  MotorSpeed := SpeedBar.Position;
  MoveRCX(oldjoydir);
end;

procedure TJoystickForm.FormShow(Sender: TObject);
begin
  {Form becomes visible}
  {Fill in values}
  if LeftRight then
    LeftRightBtn.Checked := True
  else
    DriveSteerBtn.Checked := True;
  LMotorA.Checked := (LeftMotor = 0);
  LMotorB.Checked := (LeftMotor = 1);
  LMotorC.Checked := (LeftMotor = 2);
  RMotorA.Checked := (RightMotor = 0);
  RMotorB.Checked := (RightMotor = 1);
  RMotorC.Checked := (RightMotor = 2);
  LReversed.Checked := LeftReversed;
  RReversed.Checked := RightReversed;
  SpeedBar.Position := MotorSpeed;
  {Start the timer}
  JoyTimer.Enabled := true;
end;

procedure TJoystickForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {Form stops from being visible}
  {Stop the timer}
  JoyTimer.Enabled := false;
end;

const
  VK_0 = 48;
  VK_1 = 49;
  VK_9 = 57;

procedure TJoystickForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key >= VK_NUMPAD1) and (Key <= VK_NUMPAD9) then
    MoveRCX(Key - VK_NUMPAD0)
  else if (Key >= VK_1) and (Key <= VK_9) then
    MoveRCX(Key - VK_0)
  else begin
    case Key of
      VK_END   : MoveRCX(1);
      VK_DOWN  : MoveRCX(2);
      VK_NEXT  : MoveRCX(3);
      VK_LEFT  : MoveRCX(4);
      VK_CLEAR : MoveRCX(5);
      VK_RIGHT : MoveRCX(6);
      VK_HOME  : MoveRCX(7);
      VK_UP    : MoveRCX(8);
      VK_PRIOR : MoveRCX(9);
    end;
  end;
end;

procedure TJoystickForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Key >= VK_NUMPAD1) and (Key <= VK_NUMPAD9)) or
     ((Key >= VK_1) and (Key <= VK_9)) or
     (Key in [VK_END,   VK_DOWN, VK_NEXT, VK_LEFT,
              VK_RIGHT, VK_HOME, VK_UP,   VK_PRIOR]) then
    MoveRCX(5);
end;

{$IFNDEF NXT_ONLY}
function TJoystickForm.GetTaskOffset: integer;
begin
  Result := 0;
  if IsSpybotic then
    Result := 8;
end;
{$ENDIF}

procedure TJoystickForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TJoystickForm.DoJoyButton(const i: byte; bPress : boolean);
begin
{$IFNDEF NXT_ONLY}
  if IsNxt then begin
    ExecuteScript(i, bPress);
  end
  else begin
    if RCXTasks and ((i < 5) and bPress) then
      BrickComm.StartTask(i+GetTaskOffset)
    else
      ExecuteScript(i, bPress);
  end;
{$ENDIF}
end;

procedure TJoystickForm.SetSpeed(const val: word);
var
  speed : byte;
begin
  // scale 0..65535 to 0..7
  speed := val div 9362;
  if SpeedBar.Position <> speed then
    SpeedBar.Position := speed;
end;

{$IFDEF FPC}
initialization
  {$i JoystickUnit.lrs}
{$ENDIF}

end.
