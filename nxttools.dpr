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
program nxttools;

{$IFNDEF FPC}
{$R 'ToolbarBackground.res' 'ToolbarBackground.rc'}
{$ENDIF}

uses
{$IFNDEF FPC}
  XPMan,
{$ELSE}
  Interfaces,
{$ENDIF}
  Forms,
  Dialogs,
  Controls,
  Registry,
{$IFNDEF FPC}
  uHexViewer in 'uHexViewer.pas' {frmHexView},
{$ENDIF}
  brick_common in 'bricktools\brick_common.pas',
  uGlobals in 'uGlobals.pas',
  uJoyGlobals in 'uJoyGlobals.pas',
  uRemoteGlobals in 'uRemoteGlobals.pas',
  uLocalizedStrings in 'uLocalizedStrings.pas',
  uportsedit in 'uportsedit.pas' {frmPortsEdit},
  uPortPrompt in 'uPortPrompt.pas' {frmPortPrompt},
  uToolPalette in 'uToolPalette.pas' {frmNXTTools},
  Controller in 'Controller.pas' {DirectForm},
  Diagnose in 'Diagnose.pas' {DiagForm},
  JoystickUnit in 'JoystickUnit.pas' {JoystickForm},
  MessageUnit in 'MessageUnit.pas' {MessageForm},
  Piano in 'Piano.pas' {PianoForm},
  RemoteUnit in 'RemoteUnit.pas' {RemoteForm},
  uNXTExplorer in 'uNXTExplorer.pas' {frmNXTExplorer},
  uNXTImage in 'uNXTImage.pas' {frmNXTImage},
  Watch in 'Watch.pas' {WatchForm},
  uMIDIConversion in 'uMIDIConversion.pas' {frmMIDIConversion},
  uWav2RSO in 'uWav2RSO.pas' {frmWave2RSO},
  MemoryUnit in 'MemoryUnit.pas';

{$IFNDEF FPC}
{$R *.res}
{$ENDIF}

var
  reg : TRegistry;

begin
  reg := TRegistry.Create;
  try
    LoadJoystickValues(reg);
    LoadRemoteValues(reg);
    LocalBrickType := rtNXT;
    BrickComm.BrickType := rtNXT;
    Application.Initialize;
    Application.Title := 'NeXT Tools';
    Application.CreateForm(TfrmNXTTools, frmNXTTools);
    Application.CreateForm(TDirectForm, DirectForm);
    Application.CreateForm(TDiagForm, DiagForm);
    Application.CreateForm(TJoystickForm, JoystickForm);
    Application.CreateForm(TMessageForm, MessageForm);
    Application.CreateForm(TPianoForm, PianoForm);
    Application.CreateForm(TRemoteForm, RemoteForm);
    Application.CreateForm(TfrmNXTExplorer, frmNXTExplorer);
    Application.CreateForm(TfrmNXTImage, frmNXTImage);
    Application.CreateForm(TWatchForm, WatchForm);
    Application.CreateForm(TfrmWave2RSO, frmWave2RSO);
    Application.CreateForm(TMemoryForm, MemoryForm);
{$IFNDEF FPC}
    Application.CreateForm(TfrmHexView, frmHexView);
{$ENDIF}
  // prompt for port.
    with TfrmPortPrompt.Create(nil) do
    try
      if ShowModal = mrOK then
      begin
        BrickComm.Port := Port;
        if BrickComm.Open then
          BrickComm.Ping
        else
          ShowMessage(sUnableToConnect);
      end;  
    finally
      Free;
    end;
    Application.Run;
    SaveRemoteValues(reg);
    SaveJoystickValues(reg);
  finally
    reg.Free;
  end;
end.
