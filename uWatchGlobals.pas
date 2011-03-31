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
unit uWatchGlobals;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

{$I bricxcc.inc}

interface

uses
  Registry;

procedure LoadWatchValues(reg : TRegistry);
procedure SaveWatchValues(reg : TRegistry);
procedure ResetWatchValues(reg : TRegistry);

implementation

uses
  Watch, uRegUtils;

procedure LoadWatchValues(reg : TRegistry);
begin
  if not Assigned(WatchForm) then Exit;
  Reg_OpenKey(reg, 'WatchValues');
  try
    WatchForm.chkIfActive.Checked := Reg_ReadBool(reg, 'OnlyIfActive', False);
    WatchForm.chkSyncSeries.Checked := Reg_ReadBool(reg, 'SyncSeries', True);
  finally
    reg.CloseKey;
  end;
end;

procedure SaveWatchValues(reg : TRegistry);
begin
  if not Assigned(WatchForm) then Exit;
  Reg_DeleteKey(reg, 'WatchValues');
  Reg_OpenKey(reg, 'WatchValues');
  try
    reg.WriteBool('OnlyIfActive', WatchForm.chkIfActive.Checked);
    reg.WriteBool('SyncSeries', WatchForm.chkSyncSeries.Checked);
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