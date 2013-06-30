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
unit uWatchGlobals;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

{$I bricxcc.inc}

interface

uses
  Registry;

var
  WatchOnlyIfActive : boolean;
  WatchSyncSeries : boolean;
  WatchNXTResponseMB : boolean;
  WatchPI2CType1 : integer;
  WatchPI2CType2 : integer;
  WatchPI2CType3 : integer;
  WatchPI2CType4 : integer;

procedure LoadWatchValues(reg : TRegistry);
procedure SaveWatchValues(reg : TRegistry);
procedure ResetWatchValues(reg : TRegistry);

implementation

uses
  uRegUtils;

procedure LoadWatchValues(reg : TRegistry);
begin
  Reg_OpenKey(reg, 'WatchValues');
  try
    WatchOnlyIfActive  := Reg_ReadBool(reg, 'OnlyIfActive', False);
    WatchSyncSeries    := Reg_ReadBool(reg, 'SyncSeries', True);
    WatchNXTResponseMB := Reg_ReadBool(reg, 'NXTResponseMB', True);
    WatchPI2CType1     := Reg_ReadInteger(reg, 'PI2CType1', 0);
    WatchPI2CType2     := Reg_ReadInteger(reg, 'PI2CType2', 0);
    WatchPI2CType3     := Reg_ReadInteger(reg, 'PI2CType3', 0);
    WatchPI2CType4     := Reg_ReadInteger(reg, 'PI2CType4', 0);
  finally
    reg.CloseKey;
  end;
end;

procedure SaveWatchValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'WatchValues');
  Reg_OpenKey(reg, 'WatchValues');
  try
    reg.WriteBool('OnlyIfActive', WatchOnlyIfActive);
    reg.WriteBool('SyncSeries', WatchSyncSeries);
    reg.WriteBool('NXTResponseMB', WatchNXTResponseMB);
    reg.WriteInteger('PI2CType1', WatchPI2CType1);
    reg.WriteInteger('PI2CType2', WatchPI2CType2);
    reg.WriteInteger('PI2CType3', WatchPI2CType3);
    reg.WriteInteger('PI2CType4', WatchPI2CType4);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetWatchValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'WatchValues');
  LoadWatchValues(reg);
end;

end.