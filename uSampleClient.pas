unit uSampleClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BricxCC_TLB, ExtCtrls, StdCtrls, Buttons, ComCtrls, ActnList;

type
  TfrmJoystick = class(TForm)
    pnlLeft: TPanel;
    pnlMain: TPanel;
    grpLeftMotor: TGroupBox;
    LMotorA: TRadioButton;
    LMotorB: TRadioButton;
    LMotorC: TRadioButton;
    LReversed: TCheckBox;
    grpRightMotor: TGroupBox;
    RMotorA: TRadioButton;
    RMotorB: TRadioButton;
    RmotorC: TRadioButton;
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
    JoyTimer: TTimer;
    grpBrickType: TGroupBox;
    radRCX: TRadioButton;
    radRCX2: TRadioButton;
    radSpy: TRadioButton;
    radCM: TRadioButton;
    radScout: TRadioButton;
    grpPort: TGroupBox;
    radCOM1: TRadioButton;
    radCOM2: TRadioButton;
    radCOM3: TRadioButton;
    radCOM4: TRadioButton;
    radUSB: TRadioButton;
    ActionList1: TActionList;
    btnOpen: TButton;
    btnClose: TButton;
    actOpen: TAction;
    actClose: TAction;
    procedure FormCreate(Sender: TObject);
    procedure DirButtonClick(Sender: TObject);
    procedure DirButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DirButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LeftRightBtnClick(Sender: TObject);
    procedure DriveSteerBtnClick(Sender: TObject);
    procedure LMotorClick(Sender: TObject);
    procedure LReversedClick(Sender: TObject);
    procedure RMotorClick(Sender: TObject);
    procedure RReversedClick(Sender: TObject);
    procedure SpeedBarChange(Sender: TObject);
    procedure TaskBtnClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure JoyTimerTimer(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure RCXTypeClick(Sender: TObject);
    procedure PortClick(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
  private
    { Private declarations }
    fPortNum : integer;
    fRCXType : integer;
    function GetTaskOffset : integer;
    procedure MoveRCX(dir:integer);
    procedure RefreshForm;
  public
    { Public declarations }
    Spirit : IBricxCCSpirit;
  end;

var
  frmJoystick: TfrmJoystick;

implementation

{$R *.dfm}

uses
  MMSystem;

{Joystick settings}
var
  LeftRight:boolean;              // Whether in left-right mode
  LeftMotor:integer;              // the left motor
  RightMotor:integer;             // the right motor
  LeftReversed:boolean;           // whether left must be reversed
  RightReversed:boolean;          // whether right must be reversed
  MotorSpeed:integer;             // speed of the motors

var
  oldldir:integer =100;                   // previous left motor direction
  oldrdir:integer =100;                   // previous right motor direction
  oldspeed:integer = 100;                 // previous motor speed
  oldbuttons:array[1..4] of boolean=      // previous status of buttons
             (false,false,false,false) ;

  ldirA:array[1..9] of integer =
             ( 0,-1,-1,
              -1, 0, 1,
               0, 1, 1);
  rdirA:array[1..9] of integer =
             (-1,-1, 0,
               1, 0,-1,
               1, 1, 0);
  ldirB:array[1..9] of integer =
             (-1,-1,-1,
               0, 0, 0,
               1, 1, 1);
  rdirB:array[1..9] of integer =
             (-1, 0, 1,
              -1, 0, 1,
              -1, 0, 1);

resourcestring
  sDriveMotor = 'Drive Motor';
  sSteerMotor = 'Steer Motor';
  sLeftMotor  = 'Left Motor';
  sRightMotor = 'Right Motor';

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

procedure TfrmJoystick.MoveRCX(dir:integer);
var
  ldir,rdir:integer;
  l, r, lr : Byte;
begin
  {Show direction}
  TSpeedButton(FindComponent('DirBtn'+IntToStr(dir))).Down:=true;

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
    Spirit.SetMotorPower(lr, 2, MotorSpeed);
  end;

  if (ldir <> oldldir) or (rdir <> oldrdir) then
  begin
    if ldir < 0 then
    begin
      if rdir = 0 then
      begin
        Spirit.MotorsOff(r);
        Spirit.SetRwd(l);
        Spirit.MotorsOn(l);
      end
      else if rdir > 0 then
      begin
        Spirit.SetRwd(l);
        Spirit.SetFwd(r);
        Spirit.MotorsOn(lr);
      end
      else // if rdir < 0 then
      begin
        Spirit.SetRwd(lr);
        Spirit.MotorsOn(lr);
      end;
    end
    else if ldir > 0 then
    begin
      if rdir = 0 then
      begin
        Spirit.MotorsOff(r);
        Spirit.SetFwd(l);
        Spirit.MotorsOn(l);
      end
      else if rdir > 0 then
      begin
        Spirit.SetFwd(lr);
        Spirit.MotorsOn(lr);
      end
      else // if rdir < 0 then
      begin
        Spirit.SetFwd(l);
        Spirit.SetRwd(r);
        Spirit.MotorsOn(lr);
      end;
    end
    else
    begin
      if rdir = 0 then
      begin
        Spirit.MotorsOff(lr);
      end
      else if rdir > 0 then
      begin
        Spirit.MotorsOff(l);
        Spirit.SetFwd(r);
        Spirit.MotorsOn(r);
      end
      else // if rdir < 0 then
      begin
        Spirit.MotorsOff(l);
        Spirit.SetRwd(r);
        Spirit.MotorsOn(r);
      end;
    end;
  end;

  {Save the values}
  oldldir := ldir;
  oldrdir := rdir;
  oldspeed := MotorSpeed;
end;

var oldjoydir:integer;

procedure TfrmJoystick.FormCreate(Sender: TObject);
begin
  Spirit := CoBricxCCSpirit.Create;
  LeftRight := True;
  LeftMotor := 0;
  RightMotor := 2;
  LeftReversed := False;
  RightReversed := False;
  MotorSpeed := 7;
  fRCXType := artRCX2;
  fPortNum := radUSB.Tag;
end;

procedure TfrmJoystick.DirButtonClick(Sender: TObject);
begin
  MoveRCX(5);
end;

procedure TfrmJoystick.DirButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MoveRCX(TSpeedButton(Sender).Tag);
end;

procedure TfrmJoystick.DirButtonMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button <> mbRight then MoveRCX(5);
end;

procedure TfrmJoystick.LeftRightBtnClick(Sender: TObject);
begin
  LeftRightBtn.Checked := true;
  grpLeftMotor.Caption := sLeftMotor;
  grpRightMotor.Caption := sRightMotor;
  LeftRight := true;
end;

procedure TfrmJoystick.DriveSteerBtnClick(Sender: TObject);
begin
  DriveSteerBtn.Checked := true;
  grpLeftMotor.Caption := sDriveMotor;
  grpRightMotor.Caption := sSteerMotor;
  LeftRight := false;
end;

procedure TfrmJoystick.LMotorClick(Sender: TObject);
begin
  LeftMotor := TRadioButton(Sender).Tag;
end;

procedure TfrmJoystick.LReversedClick(Sender: TObject);
begin
  LeftReversed := LReversed.Checked;
end;

procedure TfrmJoystick.RMotorClick(Sender: TObject);
begin
  RightMotor := TRadioButton(Sender).Tag;
end;

procedure TfrmJoystick.RReversedClick(Sender: TObject);
begin
  RightReversed := RReversed.Checked;
end;

procedure TfrmJoystick.SpeedBarChange(Sender: TObject);
begin
  MotorSpeed := SpeedBar.Position;
end;

procedure TfrmJoystick.TaskBtnClick(Sender: TObject);
begin
  Spirit.StartTask(TBitBtn(Sender).Tag);
end;

function TfrmJoystick.GetTaskOffset: integer;
begin
  Result := 0;
  if Spirit.BrickType = artSpy then
    Result := 8;
end;

procedure TfrmJoystick.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
const
  VK_0 = 48;
  VK_1 = 49;
  VK_9 = 57;
begin
  if (Key >= VK_NUMPAD1) and (Key <= VK_NUMPAD9) then
    MoveRCX(Key - VK_NUMPAD0)
  else if (Key >= VK_1) and (Key <= VK_9) then
    MoveRCX(Key - VK_0);
end;

procedure TfrmJoystick.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key >= VK_NUMPAD1) and (Key <= VK_NUMPAD9) then
    MoveRCX(5);
end;

procedure TfrmJoystick.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  JoyTimer.Enabled := false;
end;

procedure TfrmJoystick.FormShow(Sender: TObject);
begin
  RefreshForm;
end;

procedure TfrmJoystick.JoyTimerTimer(Sender: TObject);
var
  joyinfo : TJoyInfo;
  buttons : array [1..4] of boolean;
  i : integer;
  dir : integer;
begin
  {Get the joystick value and check for errors}
  if joyGetPos(JOYSTICKID1,@joyinfo) <> JOYERR_NOERROR then
    Exit;

  {Handle the position}
  if (joyinfo.wYpos<20000) then      dir:=6
  else if (joyinfo.wYpos>44000) then dir:=0
  else                               dir:=3;
  if (joyinfo.wXpos<20000) then      dir:=dir+1
  else if (joyinfo.wXpos>44000) then dir:=dir+3
  else                               dir:=dir+2;
  if dir <> oldjoydir then MoveRCX(dir);
  oldjoydir := dir;

  {Handle the buttons}
  buttons[1] := (JOY_BUTTON1 and joyinfo.wButtons) > 0;
  buttons[2] := (JOY_BUTTON2 and joyinfo.wButtons) > 0;
  buttons[3] := (JOY_BUTTON3 and joyinfo.wButtons) > 0;
  buttons[4] := (JOY_BUTTON4 and joyinfo.wButtons) > 0;
  for i:=1 to 4 do
    if buttons[i] <> oldbuttons[i] then
    begin
      oldbuttons[i] := buttons[i];
      if buttons[i] then
      begin
        Spirit.StartTask(i+GetTaskOffset);
      end;
    end;
end;

procedure TfrmJoystick.RefreshForm;
begin
  if not Spirit.IsOpen then Exit;
  if LeftRight then
    LeftRightBtnClick(Self)
  else
    DriveSteerBtnClick(Self);
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

procedure TfrmJoystick.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  actOpen.Enabled := not Spirit.IsOpen;
  actClose.Enabled := not actOpen.Enabled;
end;

procedure TfrmJoystick.RCXTypeClick(Sender: TObject);
begin
  fRCXType := TRadioButton(Sender).Tag;
end;

procedure TfrmJoystick.PortClick(Sender: TObject);
begin
  fPortNum := TRadioButton(Sender).Tag;
end;

function PortNumToName(num : integer) : string;
begin
  Result := IntToStr(num); // TODO: fix this
end;

procedure TfrmJoystick.actOpenExecute(Sender: TObject);
begin
  Spirit.Close;
  Spirit.BrickType := fRCXType;
  Spirit.Port := PortNumToName(fPortNum);
  Spirit.Open;
end;

procedure TfrmJoystick.actCloseExecute(Sender: TObject);
begin
  Spirit.Close;
end;

end.
