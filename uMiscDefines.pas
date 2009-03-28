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
unit uMiscDefines;

interface

uses
  uParseCommon, Editor;

type
  TProgramNames = array[0..5] of string;
  TFirmwareType = (ftStandard, ftBrickOS, ftPBForth, ftLeJOS, ftOther);

const
  SU_SHOWFORM = 0;
  SU_CONNECT = 1;
  SU_NOCONNECT = 2;

var
  LocalPort : string;    // Name of the port to use for this instance
  LocalStartupAction : integer; // action to take at startup for this instance
  LocalStandardFirmware : Boolean;
  LocalUseBluetooth : Boolean;
  LocalFirmwareType : TFirmwareType;

function Min(const v1, v2: Integer): Integer;
function Max(const v1, v2: Integer): Integer;
function ExploredLanguageType : TExploredLanguage;
function FileCanBeCompiled: Boolean;
function FileCanBeProcessed: Boolean;
function FileIsCPPOrPascalOrJava(AEF : TEditorForm = nil): Boolean;
function FileIsMindScriptOrLASM(AEF : TEditorForm = nil): Boolean;
function FileIsNBCOrNXCOrNPGOrRICScript(AEF : TEditorForm = nil): Boolean;
function FileIsNBCOrNXC(AEF : TEditorForm = nil): Boolean;
function FileIsPascal(AEF : TEditorForm = nil): Boolean;
function FileIsCPP(AEF : TEditorForm = nil): Boolean;
function FileIsLASM(AEF : TEditorForm = nil): Boolean;
function FileIsNBC(AEF : TEditorForm = nil): Boolean;
function FileIsNXC(AEF : TEditorForm = nil): Boolean;
function FileIsNPG(AEF : TEditorForm = nil): Boolean;
function FileIsRICScript(AEF : TEditorForm = nil): Boolean;
function FileIsMindScript(AEF : TEditorForm = nil): Boolean;
function FileIsNQC(AEF : TEditorForm = nil): Boolean;
function FileIsJava(AEF : TEditorForm = nil): Boolean;
function FileIsForth(AEF : TEditorForm = nil): Boolean;
function FileIsROPS(AEF : TEditorForm = nil): Boolean;

implementation

uses
  MainUnit;

function Min(const v1, v2: Integer): Integer;
begin
  if v1 < v2 then
    Result := v1
  else
    Result := v2;
end;

function Max(const v1, v2: Integer): Integer;
begin
  if v1 > v2 then
    Result := v1
  else
    Result := v2;
end;

function ExploredLanguageType : TExploredLanguage;
var
  AEF : TEditorForm;
begin
  result := elNQC;
  AEF := nil;
  if Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  if FileIsCPP(AEF) then
    result := elCpp
  else if FileIsPascal(AEF) then
    result := elPas
  else if FileIsROPS(AEF) then
    result := elPas
  else if FileIsJava(AEF) then
    result := elJava
  else if FileIsForth(AEF) then
    result := elForth
  else if FileIsLASM(AEF) then
    result := elLASM
  else if FileIsNBC(AEF) then
    result := elNBC
  else if FileIsNXC(AEF) then
    result := elNXC
  else if FileIsMindScript(AEF) then
    result := elMindScript;
end;

function FileCanBeCompiled: Boolean;
var
  AEF : TEditorForm;
begin
  Result := False;
  AEF := nil;
  if Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := FileIsNQC(AEF) or
            FileIsMindScript(AEF) or
            FileIsLASM(AEF) or
            FileIsNBC(AEF) or
            FileIsNXC(AEF) or
            FileIsNPG(AEF) or
            FileIsRICScript(AEF) or
            FileIsCPP(AEF) or
            FileIsPascal(AEF) or
            FileIsROPS(AEF) or
            FileIsJava(AEF);
end;

function FileCanBeProcessed: Boolean;
var
  AEF : TEditorForm;
begin
  Result := False;
  AEF := nil;
  if Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := FileIsNQC(AEF) or
            FileIsMindScript(AEF) or
            FileIsNBC(AEF) or
            FileIsNXC(AEF) or
            FileIsLASM(AEF) or
            FileIsCPP(AEF) or
            FileIsJava(AEF) or
            FileIsForth(AEF) or
            FileIsROPS(AEF) or
            FileIsPascal(AEF);
end;

function FileIsCPPOrPascalOrJava(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := FileIsCPP(AEF) or FileIsPascal(AEF) or FileIsJava(AEF);
end;

function FileIsMindScriptOrLASM(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := FileIsMindScript(AEF) or FileIsLASM(AEF);
end;

function FileIsNBCOrNXCOrNPGOrRICScript(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := FileIsNBC(AEF) or FileIsNXC(AEF) or FileIsNPG(AEF) or FileIsRICScript(AEF);
end;

function FileIsNBCOrNXC(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := FileIsNBC(AEF) or FileIsNXC(AEF);
end;

function FileIsPascal(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynPasSyn;
end;

function FileIsCPP(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynCppSyn;
end;

function FileIsLASM(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynLASMSyn;
end;

function FileIsNBC(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynNBCSyn;
end;

function FileIsNXC(AEF : TEditorForm = nil): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynNXCSyn;
end;

function FileIsNPG(AEF : TEditorForm = nil): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynNPGSyn;
end;

function FileIsRICScript(AEF : TEditorForm = nil): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynRSSyn;
end;

function FileIsMindScript(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynMindScriptSyn;
end;

function FileIsNQC(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynNQCSyn;
end;

function FileIsJava(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynJavaSyn;
end;

function FileIsForth(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynForthSyn;
end;

function FileIsROPS(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynROPSSyn;
end;

end.
