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
program nxtmessage;

uses
{$IFNDEF FPC}
  XPMan,
{$ELSE}
  Interfaces,
{$ENDIF}
  Forms,
  Dialogs,
  brick_common in 'bricktools\brick_common.pas',
  uGlobals in 'uGlobals.pas',
  uLocalizedStrings in 'uLocalizedStrings.pas',
  uPortPrompt in 'uPortPrompt.pas' {frmPortPrompt},
  MessageUnit in 'MessageUnit.pas' {MessageForm};

{$IFNDEF FPC}
{$R *.res}
{$ENDIF}

begin
  LocalBrickType := rtNXT;
  BrickComm.BrickType := rtNXT;
  Application.Initialize;
  Application.Title := 'NeXT Message';
  Application.CreateForm(TMessageForm, MessageForm);
  // prompt for port.
  with TfrmPortPrompt.Create(nil) do
  try
    ShowModal;
    BrickComm.Port := Port;
  finally
    Free;
  end;
  if BrickComm.Open then
  begin
    BrickComm.Ping;
    Application.Run;
  end
  else
    ShowMessage(sUnableToConnect);
end.