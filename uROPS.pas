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
unit uROPS;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, 
  uPSComponent_StdCtrls, uPSComponent_Controls, uPSComponent_Forms,
  uPSComponent_Default, uPSComponent;

function ce : TPSScriptDebugger;

implementation

uses
  SysUtils,
{$IFNDEF FPC}
  uPSI_FakeSpirit,
{$ENDIF}
  uPSI_brick_common, uPSI_uSpirit, uPSI_FantomSpirit, uPSI_uGlobals,
  uPSI_rcx_constants;


type
  TPSOwner = class(TComponent)
  private
  public
  end;

var
  fPSOwner : TPSOwner;
  fCE : TPSScriptDebugger;
  // pascal script components
  PSImport_Controls: TPSImport_Controls;
  PSImport_StdCtrls: TPSImport_StdCtrls;
  PSImport_Forms: TPSImport_Forms;
  PSImport_DateUtils: TPSImport_DateUtils;
  PSImport_Classes: TPSImport_Classes;

procedure CreateSpiritPlugins;
var
  Plugin : TPSPlugin;
begin
  if Assigned(fCE) and Assigned(fPSOwner) then
  begin
    Plugin := TPSImport_uGlobals.Create(fPSOwner);
    TPSPluginItem(fCE.Plugins.Add).Plugin := Plugin;
    Plugin := TPSImport_rcx_constants.Create(fPSOwner);
    TPSPluginItem(fCE.Plugins.Add).Plugin := Plugin;
    Plugin := TPSImport_uSpirit.Create(fPSOwner);
    TPSPluginItem(fCE.Plugins.Add).Plugin := Plugin;
    Plugin := TPSImport_brick_common.Create(fPSOwner);
    TPSPluginItem(fCE.Plugins.Add).Plugin := Plugin;
{$IFNDEF FPC}
    Plugin := TPSImport_FakeSpirit.Create(fPSOwner);
    TPSPluginItem(fCE.Plugins.Add).Plugin := Plugin;
{$ENDIF}
    Plugin := TPSImport_FantomSpirit.Create(fPSOwner);
    TPSPluginItem(fCE.Plugins.Add).Plugin := Plugin;
  end;
end;

procedure CreatePascalScriptComponents;
begin
  fPSOwner := TPSOwner.Create(nil);
  PSImport_Controls  := TPSImport_Controls.Create(fPSOwner);
  PSImport_StdCtrls  := TPSImport_StdCtrls.Create(fPSOwner);
  PSImport_Forms     := TPSImport_Forms.Create(fPSOwner);
  PSImport_DateUtils := TPSImport_DateUtils.Create(fPSOwner);
  PSImport_Classes   := TPSImport_Classes.Create(fPSOwner);
  fCE                := TPSScriptDebugger.Create(fPSOwner);
  with PSImport_Controls do
  begin
    Name := 'PSImport_Controls';
    EnableStreams := True;
    EnableGraphics := True;
    EnableControls := True;
  end;
  with PSImport_StdCtrls do
  begin
    Name := 'PSImport_StdCtrls';
    EnableExtCtrls := True;
    EnableButtons := True;
  end;
  with PSImport_Forms do
  begin
    Name := 'PSImport_Forms';
    EnableForms := True;
    EnableMenus := True;
  end;
  with PSImport_DateUtils do
  begin
    Name := 'PSImport_DateUtils';
  end;
  with PSImport_Classes do
  begin
    Name := 'PSImport_Classes';
    EnableStreams := True;
    EnableClasses := True;
  end;
  with fCE do
  begin
    Name := 'ce';
    CompilerOptions := [];
    TPSPluginItem(Plugins.Add).Plugin := PSImport_DateUtils;
    TPSPluginItem(Plugins.Add).Plugin := PSImport_Classes;
    TPSPluginItem(Plugins.Add).Plugin := PSImport_Controls;
    TPSPluginItem(Plugins.Add).Plugin := PSImport_StdCtrls;
    TPSPluginItem(Plugins.Add).Plugin := PSImport_Forms;
    MainFileName := 'Unnamed';
    UsePreProcessor := True;
  end;
  CreateSpiritPlugins;
end;

function ce : TPSScriptDebugger;
begin
  if not Assigned(fCE) then
  begin
    CreatePascalScriptComponents;
  end;
  Result := fCE;
end;

procedure FreePascalScriptComponents;
begin
  FreeAndNil(fPSOwner); // frees all the PS components
end;

initialization
  fCE := nil;

finalization
  if Assigned(fPSOwner) then
    FreePascalScriptComponents;

end.