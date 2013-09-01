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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uLiveSensorGlobals;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Registry;

var
  LiveSensorDefaultRefreshRate : integer = 1000;

procedure LoadLiveSensorValues(reg : TRegistry);
procedure SaveLiveSensorValues(reg : TRegistry);
procedure ResetLiveSensorValues(reg : TRegistry);

implementation

uses
{$IFNDEF FPC}
  Windows,
{$ENDIF}
  SysUtils, uRegUtils;

procedure LoadLiveSensorValues(reg : TRegistry);
begin
  Reg_OpenKey(reg, 'LiveSensorValues');
  try
    LiveSensorDefaultRefreshRate := Reg_ReadInteger(reg, 'LiveSensorDefaultRefreshRate', LiveSensorDefaultRefreshRate);
  finally
    reg.CloseKey;
  end;
end;

procedure SaveLiveSensorValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'LiveSensorValues');
  Reg_OpenKey(reg, 'LiveSensorValues');
  try
    reg.WriteInteger('LiveSensorDefaultRefreshRate', LiveSensorDefaultRefreshRate);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetLiveSensorValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'LiveSensorValues');
  LoadLiveSensorValues(reg);
end;

end.
