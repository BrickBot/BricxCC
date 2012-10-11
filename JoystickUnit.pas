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
    procedure FormDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
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
  MainUnit,
{$ENDIF}
  SysUtils, Dialogs, Math, brick_common, uLocalizedStrings, uJoyGlobals, uGlobals,
  uROPS, uJoyActions, uUtilities;

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
    oldWBtns : Cardinal = 0;

    ldirA:array[1..9] of integer =
               ( 0,-1,-1,-1, 0, 1, 0, 1, 1);
    rdirA:array[1..9] of integer =
               (-1,-1, 0, 1, 0,-1, 1, 1, 0);
    ldirB:array[1..9] of integer =
               (-1,-1,-1, 0, 0, 0, 1, 1, 1);
    rdirB:array[1..9] of integer =
               (-1, 0, 1,-1, 0, 1,-1, 0, 1);

function GetJoystickButtonScript(const i : byte; bPress : boolean) : string;
const
  name_postfix : array[boolean] of string = ('r', 'p');
begin
  Result := UserDataLocalPath+Format('joybtn%2.2d%s.rops', [i, name_postfix[bPress]]);
end;

procedure ExecuteScript(const fname : string);
begin
  if FileExists(fname) then begin
    ce.MainFileName := fname;
    ce.Script.LoadFromFile(fname);
    if ce.Compile then
      ce.Execute
    else
      ShowMessage(ce.CompilerMessages[0].MessageToString);
  end;
end;

procedure ExecuteJoyButtonScript(const i: byte; bPress : boolean);
begin
  ExecuteScript(GetJoystickButtonScript(i, bPress));
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

function GetCAScript(dir : integer; l, r, lr : byte; ldir, rdir, speed : ShortInt; btns : Cardinal) : string;
begin
  Result := UserDataLocalPath+Format('joyca%d%d%d%d%d%d%d.rops', [dir, l, r, lr, ldir+1, rdir+1, speed]);
end;

procedure ExecuteCAScript(dir : integer; l, r, lr : byte; ldir, rdir, speed : ShortInt; btns : Cardinal);
begin
  ExecuteScript(GetCAScript(dir, l, r, lr, ldir, rdir, speed, btns));
end;

function FlattenCardinal(aValue : Cardinal) : string;
begin
  Result := Chr(Lo(Word(aValue))) + Chr(Hi(Word(aValue))) +
            Chr(Lo(HiWord(aValue))) + Chr(Hi(HiWord(aValue)));
end;

procedure SendCAMessage(dir : integer; l, r, lr : byte; ldir, rdir, speed : ShortInt; btns : Cardinal);
var
  msg : string;
begin
  if IsNXT then
  begin
    // the NXT message format will be a flattened structure of 7 fields
    // get left and right motor speed values
    ldir := speed * ldir;
    rdir := speed * rdir;
    SetLength(msg, 10); // 10 bytes when flattened
    msg := Chr(dir) + Chr(l) + Chr(r) + Chr(lr) + Chr(ldir) + Chr(rdir) +
           FlattenCardinal(btns);
  end
  else
  begin
    msg := Format('%1.1d%1.1d%1.1d%1.1d%1.1d%1.1d%d', [dir, l, r, lr, ldir+1, rdir+1, speed]);
  end;
  BrickComm.NXTMessageWrite(CAInBox, msg);
end;

procedure SendCAMessageEx(XPos, YPos, ZPos, RPos, UPos, VPos, btns, BtnNum, POV : Cardinal);
var
  msg : string;
begin
  if IsNXT then
  begin
    // the NXT message format will be a flattened structure of 7 fields
    // get left and right motor speed values
    SetLength(msg, 36); // 36 bytes when flattened
    msg := FlattenCardinal(XPos) + FlattenCardinal(YPos) + FlattenCardinal(ZPos) +
           FlattenCardinal(RPos) + FlattenCardinal(UPos) + FlattenCardinal(VPos) +
           FlattenCardinal(btns) + FlattenCardinal(BtnNum) + FlattenCardinal(POV);
  end
  else
  begin
    msg := Format('%d|%d|%d|%d|%d|%d|%d|%d|%d', [XPos, YPos, ZPos, RPos, UPos, VPos, btns, BtnNum, POV]);
  end;
  BrickComm.NXTMessageWrite(CAInBox, msg);
end;

{$IFNDEF NXT_ONLY}
function GetTaskOffset: integer;
begin
  Result := 0;
  if IsSpybotic then
    Result := 8;
end;
{$ENDIF}

procedure DoJoyButton(const i: byte; bPress : boolean);
begin
  if IsNxt then begin
    ExecuteJoyButtonScript(i, bPress);
  end
  else begin
{$IFNDEF NXT_ONLY}
    if RCXTasks and ((i < 5) and bPress) then
      BrickComm.StartTask(i+GetTaskOffset)
    else
      ExecuteJoyButtonScript(i, bPress);
{$ENDIF}
  end;
end;

procedure MotorChanged(dir : integer; l, r, lr : byte;
  ldir, rdir, speed : ShortInt; btns : Cardinal);
var
  buttons : array [1..32] of boolean;
  i : integer;
begin
  case ChangeAction of
    mcaScript : ExecuteCAScript(dir, l, r, lr, ldir, rdir, speed, btns);
    mcaMessage : SendCAMessage(dir, l, r, lr, ldir, rdir, speed, btns);
  else // mdcaDefault
    if IsNXT then
    begin
      speed := Min(speed div 14, 7);
    end;
    BrickComm.SetMotorPower(lr, 2, speed);
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
    else // if ldir = 0 then
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

    {Handle the buttons}
    for i := 1 to 32 do
      buttons[i] := ((1 shl (i-1)) and btns) > 0;
    for i := 1 to 32 do
    begin
      if buttons[i] <> oldbuttons[i] then
      begin
        // a press or release event
        oldbuttons[i] := buttons[i];
        DoJoyButton(byte(i), buttons[i]);
      end;
    end;
    
  end;
end;

procedure MoveBrick(dir:integer; btns : Cardinal);
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
  if (MotorSpeed <> oldspeed) or (ldir <> oldldir) or
     (rdir <> oldrdir) or (btns <> oldWBtns) then
  begin
    MotorChanged(dir, l, r, lr, ldir, rdir, MotorSpeed, btns);
  end;

  {Save the values}
  oldldir := ldir;
  oldrdir := rdir;
  oldspeed := MotorSpeed;
end;

var
  oldjoydir : integer = 5;
  oldrudder : Cardinal;
{$IFNDEF FPC}
  oldjoyinfo : TJoyInfoEx;
{$ENDIF}

{$IFNDEF FPC}
function JoyInfoDiffers(j1, j2 : PJoyInfoEx) : boolean;
begin
  Result := (j1^.wXpos <> j2^.wXpos) or
            (j1^.wYpos <> j2^.wYpos) or
            (j1^.wZpos <> j2^.wZpos) or
            (j1^.dwRpos <> j2^.dwRpos) or
            (j1^.dwUpos <> j2^.dwUpos) or
            (j1^.dwVpos <> j2^.dwVpos) or
            (j1^.wButtons <> j2^.wButtons) or
            (j1^.dwButtonNumber <> j2^.dwButtonNumber) or
            (j1^.dwPOV <> j2^.dwPOV);
end;
{$ENDIF}

procedure TJoystickForm.JoyTimerTimer(Sender: TObject);
{ The timer callback that does the actual work}
{$IFDEF FPC}
begin
{$ELSE}
var
  joyinfo : TJoyInfoEx;
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

  if joyinfo.wZpos <> oldrudder then begin
    oldrudder := joyinfo.wZpos;
    SetSpeed(oldrudder);
  end;

  if (ChangeAction = mcaMessageEx) and JoyInfoDiffers(@oldjoyinfo,@joyinfo) then
  begin
    SendCAMessageEx(joyinfo.wXpos, joyinfo.wYpos, joyinfo.wZpos,
                    joyinfo.dwRpos, joyinfo.dwUpos, joyinfo.dwVpos,
                    joyinfo.wButtons, joyinfo.dwButtonNumber, joyinfo.dwPOV);
  end
  else if (dir <> oldjoydir) or (joyinfo.wButtons <> oldWBtns) or (joyinfo.wZpos <> oldrudder) then
    MoveBrick(dir, joyinfo.wButtons);

  oldjoydir := dir;
  oldWBtns := joyinfo.wButtons;
  oldjoyinfo := joyinfo;
{$ENDIF}
end;

procedure TJoystickForm.DirBtnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MoveBrick(TSpeedButton(Sender).Tag, oldWBtns);
end;

procedure TJoystickForm.DirBtnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button <> mbRight then MoveBrick(5, oldWBtns);
end;

procedure TJoystickForm.DirBtnClick(Sender: TObject);
begin
  MoveBrick(5, oldWBtns);
end;

procedure TJoystickForm.TaskBtnClick(Sender: TObject);
begin
  MoveBrick(5, TBitBtn(Sender).Tag);
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
  MoveBrick(5, oldWBtns);
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
  if IsNXT then
  begin
    if MotorSpeed < 7 then
      MotorSpeed := MotorSpeed * 14
    else if MotorSpeed = 7 then
      MotorSpeed := 100;
    SpeedBar.Frequency := 14;
    SpeedBar.Max := 100;
  end
  else
  begin
    if MotorSpeed > 7 then
      MotorSpeed := MotorSpeed div 14;
    if MotorSpeed > 7 then
      MotorSpeed := 7;
    SpeedBar.Frequency := 1;
    SpeedBar.Max := 7;
  end;
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
var
  dir : byte;
begin
  dir := 255;
  if (Key >= VK_NUMPAD1) and (Key <= VK_NUMPAD9) then
    dir := Key - VK_NUMPAD0
  else if (Key >= VK_1) and (Key <= VK_9) then
    dir := Key - VK_0
  else begin
    case Key of
      VK_END   : dir := 1;
      VK_DOWN  : dir := 2;
      VK_NEXT  : dir := 3;
      VK_LEFT  : dir := 4;
      VK_CLEAR : dir := 5;
      VK_RIGHT : dir := 6;
      VK_HOME  : dir := 7;
      VK_UP    : dir := 8;
      VK_PRIOR : dir := 9;
    end;
  end;
  if dir <> 255 then
    MoveBrick(dir, oldWBtns);
end;

procedure TJoystickForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Key >= VK_NUMPAD1) and (Key <= VK_NUMPAD9)) or
     ((Key >= VK_1) and (Key <= VK_9)) or
     (Key in [VK_END,   VK_DOWN, VK_NEXT, VK_LEFT,
              VK_RIGHT, VK_HOME, VK_UP,   VK_PRIOR]) then
    MoveBrick(5, oldWBtns);
end;

procedure TJoystickForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TJoystickForm.SetSpeed(const val: word);
var
  speed : byte;
begin
  if IsNXT then
  begin
    // scale 0..65535 to 0..100
    speed := (65535 - val) div 655;
  end
  else
  begin
    // scale 0..65535 to 0..7
    speed := (65535 - val) div 9362;
  end;
  if SpeedBar.Position <> speed then
    SpeedBar.Position := speed;
end;

procedure TJoystickForm.FormDblClick(Sender: TObject);
var
  F : TfrmJoyActions;
begin
  F := TfrmJoyActions.Create(Self);
  try
    F.ChangeAction := ChangeAction;
    F.Inbox        := CAInBox;
    if F.ShowModal = mrOK then
    begin
      ChangeAction := F.ChangeAction;
      CAInBox      := F.Inbox;
    end;
  finally
    F.Free;
  end;
end;

procedure TJoystickForm.FormCreate(Sender: TObject);
begin
  grpLeftMotor.DoubleBuffered := True;
  grpRightMotor.DoubleBuffered := True;
  grpSpeed.DoubleBuffered := True;
  grpDriveMode.DoubleBuffered := True;
  grpMovement.DoubleBuffered := True;
end;

{$IFDEF FPC}
initialization
  {$i JoystickUnit.lrs}
{$ENDIF}

end.
