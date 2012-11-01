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
unit uRemoteGlobals;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

{$I bricxcc.inc}

interface

uses
  Registry;

type
  TProgramNames = array[0..5] of string;

var
  RemotePrograms : TProgramNames;

procedure LoadRemoteValues(reg : TRegistry);
procedure SaveRemoteValues(reg : TRegistry);
procedure ResetRemoteValues(reg : TRegistry);

implementation

uses
  SysUtils, uRegUtils;

procedure LoadRemoteValues(reg : TRegistry);
var
  i : integer;
begin
  Reg_OpenKey(reg, 'Remote');
  try
    for i := Low(RemotePrograms) to High(RemotePrograms)-1 do
      RemotePrograms[i] := Reg_ReadString(reg, 'Program'+IntToStr(i), Format('remote%d.rxe', [i]));
    i := High(RemotePrograms);
    RemotePrograms[i] := Reg_ReadString(reg, 'Program'+IntToStr(i), 'default');
  finally
    reg.CloseKey;
  end;
end;

procedure SaveRemoteValues(reg : TRegistry);
var
  i : integer;
begin
  Reg_DeleteKey(reg, 'Remote');
  Reg_OpenKey(reg, 'Remote');
  try
    for i := Low(RemotePrograms) to High(RemotePrograms) do
      reg.WriteString('Program'+IntToStr(i),RemotePrograms[i]);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetRemoteValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'Remote');
  LoadRemoteValues(reg);
end;

end.