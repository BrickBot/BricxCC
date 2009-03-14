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
program NeXTExplorer;

{$R 'ToolbarBackground.res' 'ToolbarBackground.rc'}

uses
  Forms,
  XPMan,
  Dialogs,
  brick_common in 'bricktools\brick_common.pas',
  uSpirit in 'bricktools\uSpirit.pas',
  uNXTExplorer in 'uNXTExplorer.pas' {frmNXTExplorer},
  uPortPrompt in 'uPortPrompt.pas' {frmPortPrompt},
  uHexViewer in 'uHEXViewer.pas' {frmHexView};

{$R *.res}

begin
  LocalBrickType := rtNXT;
  BrickComm.BrickType := rtNXT;
  Application.Initialize;
  Application.Title := 'NeXT Explorer';
  // prompt for port and use BT.
  with TfrmPortPrompt.Create(nil) do
  try
    ShowModal;
    BrickComm.Port := Port;
    BrickComm.UseBluetooth := UseBT;
  finally
    Free;
  end;
  if BrickComm.Open then
  begin
    BrickComm.Ping;
    Application.CreateForm(TfrmNXTExplorer, frmNXTExplorer);
    Application.CreateForm(TfrmHexView, frmHexView);
    Application.Run;
  end
  else
    ShowMessage('Unable to connect to NXT');
end.
