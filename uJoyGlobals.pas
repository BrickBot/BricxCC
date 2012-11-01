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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uJoyGlobals;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

{$I bricxcc.inc}

interface

uses
  Registry;

type
  TMotorChangedAction = (mcaDefault, mcaScript, mcaMessage, mcaMessageEx);

{Joystick settings}
var
  LeftRight:boolean;              // Whether in left-right mode
  LeftMotor:integer;              // the left motor
  RightMotor:integer;             // the right motor
  LeftReversed:boolean;           // whether left must be reversed
  RightReversed:boolean;          // whether right must be reversed
  MotorSpeed:integer;             // speed of the motors
  RCXTasks:boolean;               // use tasks or scripts
  ChangeAction: TMotorChangedAction;
  CAInBox: integer;

procedure LoadJoystickValues(reg : TRegistry);
procedure SaveJoystickValues(reg : TRegistry);
procedure ResetJoystickValues(reg : TRegistry);

implementation

uses
  uRegUtils;

procedure LoadJoystickValues(reg : TRegistry);
begin
  {Loads the joystick values from the registry}
  Reg_OpenKey(reg, 'Joystick');
  try
    LeftRight     := Reg_ReadBool(reg, 'LeftRight', true);
    LeftMotor     := Reg_ReadInteger(reg, 'LeftMotor', 0);
    RightMotor    := Reg_ReadInteger(reg, 'RightMotor', 2);
    LeftReversed  := Reg_ReadBool(reg, 'LeftReversed', false);
    RightReversed := Reg_ReadBool(reg, 'RightReversed', false);
    MotorSpeed    := Reg_ReadInteger(reg, 'MotorSpeed', 4);
    RCXTasks      := Reg_ReadBool(reg, 'RCXTasks', true);
    ChangeAction  := TMotorChangedAction(Reg_ReadInteger(reg, 'ChangeAction', Ord(mcaDefault)));
    CAInBox       := Reg_ReadInteger(reg, 'CAInBox', 0);
  finally
    reg.CloseKey;
  end;
end;

procedure SaveJoystickValues(reg : TRegistry);
begin
  {Saves the joystick values to the registry}
  Reg_DeleteKey(reg, 'Joystick');
  Reg_OpenKey(reg, 'Joystick');
  try
    reg.WriteBool('LeftRight',LeftRight);
    reg.WriteInteger('LeftMotor',LeftMotor);
    reg.WriteInteger('RightMotor',RightMotor);
    reg.WriteBool('LeftReversed',LeftReversed);
    reg.WriteBool('RightReversed',RightReversed);
    reg.WriteInteger('MotorSpeed',MotorSpeed);
    reg.WriteBool('RCXTasks', RCXTasks);
    reg.WriteInteger('ChangeAction',Ord(ChangeAction));
    reg.WriteInteger('CAInBox', CAInBox);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetJoystickValues(reg : TRegistry);
begin
  {Resets the joystick values to default}
  Reg_DeleteKey(reg, 'Joystick');
  LoadJoystickValues(reg);
end;

end.