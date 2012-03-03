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
 * Portions created by John Hansen are Copyright (C) 2011 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uSimpleTerminalGlobals;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

{$I bricxcc.inc}

interface

uses
  Registry;

{SimpleTerminal settings}
var
  SimpleTermPolling : boolean;
  SimpleTermLabelLines : boolean;
  SimpleTermEchoSends : boolean;
  SimpleTermNXTUseMailbox : boolean;
  SimpleTermNXTMailboxNum : byte;

procedure LoadSimpleTerminalValues(reg : TRegistry);
procedure SaveSimpleTerminalValues(reg : TRegistry);
procedure ResetSimpleTerminalValues(reg : TRegistry);

implementation

uses
  uRegUtils;

procedure LoadSimpleTerminalValues(reg : TRegistry);
begin
  {Loads the simple terminal values from the registry}
  Reg_OpenKey(reg, 'SimpleTerminal');
  try
    SimpleTermPolling       := Reg_ReadBool(reg, 'SimpleTermPolling', true);
    SimpleTermLabelLines    := Reg_ReadBool(reg, 'SimpleTermLabelLines', false);
    SimpleTermEchoSends     := Reg_ReadBool(reg, 'SimpleTermEchoSends', false);
    SimpleTermNXTUseMailbox := Reg_ReadBool(reg, 'SimpleTermNXTUseMailbox', false);
    SimpleTermNXTMailboxNum := Reg_ReadInteger(reg, 'SimpleTermNXTMailboxNum', 9);
  finally
    reg.CloseKey;
  end;
end;

procedure SaveSimpleTerminalValues(reg : TRegistry);
begin
  {Saves the simple terminal values to the registry}
  Reg_DeleteKey(reg, 'SimpleTerminal');
  Reg_OpenKey(reg, 'SimpleTerminal');
  try
    reg.WriteBool('SimpleTermPolling',SimpleTermPolling);
    reg.WriteBool('SimpleTermLabelLines',SimpleTermLabelLines);
    reg.WriteBool('SimpleTermEchoSends',SimpleTermEchoSends);
    reg.WriteBool('SimpleTermNXTUseMailbox',SimpleTermNXTUseMailbox);
    reg.WriteInteger('SimpleTermNXTMailboxNum', SimpleTermNXTMailboxNum);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetSimpleTerminalValues(reg : TRegistry);
begin
  {Resets the simple terminal values to default}
  Reg_DeleteKey(reg, 'SimpleTerminal');
  LoadSimpleTerminalValues(reg);
end;

initialization

  SimpleTermPolling := True;
  SimpleTermLabelLines := False;
  SimpleTermEchoSends := False;
  SimpleTermNXTUseMailbox := False;
  SimpleTermNXTMailboxNum := 9;

end.
