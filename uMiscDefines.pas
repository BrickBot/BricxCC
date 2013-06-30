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
unit uMiscDefines;

interface

uses
  Classes, Forms, uParseCommon, SynEditHighlighter, 
  BricxccSynEdit;

type
  TFirmwareType = (ftStandard, ftBrickOS, ftPBForth, ftLeJOS, ftLinux, ftOther);

const
  SU_SHOWFORM = 0;
  SU_CONNECT = 1;
  SU_NOCONNECT = 2;

var
  LocalPort : string;    // Name of the port to use for this instance
  LocalStartupAction : integer; // action to take at startup for this instance
  LocalUseBluetooth : Boolean;
  LocalFirmwareType : TFirmwareType;

function GetActiveEditor : TBricxCCSynEdit;
function GetActiveEditorHighlighter : TSynCustomHighlighter;
function GetActiveEditorFilename : string;
function GetUsingMDI : boolean;
procedure DoBeep(const aBeep : Cardinal);

{$IFDEF NXT_ONLY}
procedure SetActiveEditor(aEditor : TBricxCCSynEdit);
procedure SetActiveEditorFilename(const aName : string);
{$ENDIF}

function FileCanBeCompiled: Boolean;
function FileCanBeProcessed: Boolean;
function FileIsCPPOrPascalOrJava(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsMindScriptOrLASM(AEH : TSynCustomHighlighter = nil): Boolean;
function UseNBCCompiler(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsNBCOrNXC(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsPascal(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsCPP(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsLASM(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsNBC(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsNXC(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsNPG(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsRICScript(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsMindScript(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsNQC(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsJava(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsForth(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsROPS(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsSPC(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsSPASM(AEH : TSynCustomHighlighter = nil): Boolean;
function FileIsSPCOrSPASM(AEH : TSynCustomHighlighter = nil): Boolean;

function CheckAlive : boolean;

implementation

uses
  SysUtils, Controls, Dialogs,
{$IFNDEF NXT_ONLY}
  Windows, MainUnit, Editor,
{$ENDIF}
  SynHighlighterPas, SynHighlighterCpp, SynHighlighterLASM, SynHighlighterSPASM,
  SynHighlighterForth, SynHighlighterJava, SynHighlighterMindScript,
  SynHighlighterNBC, SynHighlighterNQC, SynHighlighterNPG, SynHighlighterRS,
  SynHighlighterROPS, brick_common, uGlobals, uLocalizedStrings;

{$IFNDEF NXT_ONLY}
procedure DoBeep(const aBeep : Cardinal);
begin
  MessageBeep(aBeep);
end;

function GetActiveEditor : TBricxCCSynEdit;
var
  AEF : TEditorForm;
begin
  Result := nil;
  if Assigned(MainForm) then
  begin
    AEF := MainForm.ActiveEditorForm;
    if Assigned(AEF) then
      Result := AEF.TheEditor;
  end;
end;

function GetActiveEditorHighlighter : TSynCustomHighlighter;
var
  AEF : TEditorForm;
begin
  Result := nil;
  if Assigned(MainForm) then
  begin
    AEF := MainForm.ActiveEditorForm;
    if Assigned(AEF) then
      Result := AEF.Highlighter;
  end;
end;

function GetActiveEditorFilename : string;
var
  AEF : TEditorForm;
begin
  Result := '';
  if Assigned(MainForm) then
  begin
    AEF := MainForm.ActiveEditorForm;
    if Assigned(AEF) then
      Result := AEF.Filename;
  end;
end;

function GetUsingMDI : boolean;
begin
  Result := MainForm.MDI;
end;

{$ELSE}

var
  fActiveEditor : TBricxCCSynEdit = nil;
  fActiveEditorFilename : string = '';

procedure SetActiveEditor(aEditor : TBricxCCSynEdit);
begin
  fActiveEditor := aEditor;
end;

procedure SetActiveEditorFilename(const aName : string);
begin
  fActiveEditorFilename := aName;
end;

function GetActiveEditor : TBricxCCSynEdit;
begin
  Result := fActiveEditor;
end;

function GetActiveEditorHighlighter : TSynCustomHighlighter;
begin
  Result := nil;
  if Assigned(fActiveEditor) then
    Result := fActiveEditor.Highlighter;
end;

function GetActiveEditorFilename : string;
begin
  Result := fActiveEditorFilename;
end;

function GetUsingMDI : boolean;
begin
  Result := False;
end;

procedure DoBeep(const aBeep : Cardinal);
begin
//  MessageBeep(aBeep);
end;

{$ENDIF}

function FileCanBeCompiled: Boolean;
var
  AEH : TSynCustomHighlighter;
begin
  AEH := GetActiveEditorHighlighter;
  Result := FileIsNQC(AEH) or
            FileIsMindScript(AEH) or
            FileIsLASM(AEH) or
            FileIsNBC(AEH) or
            FileIsNXC(AEH) or
            FileIsNPG(AEH) or
            FileIsRICScript(AEH) or
            FileIsCPP(AEH) or
            FileIsPascal(AEH) or
            FileIsROPS(AEH) or
            FileIsSPC(AEH) or
            FileIsSPASM(AEH) or
            FileIsJava(AEH);
end;

function FileCanBeProcessed: Boolean;
var
  AEH : TSynCustomHighlighter;
begin
  AEH := GetActiveEditorHighlighter;
  Result := FileIsNQC(AEH) or
            FileIsMindScript(AEH) or
            FileIsNBC(AEH) or
            FileIsNXC(AEH) or
            FileIsLASM(AEH) or
            FileIsCPP(AEH) or
            FileIsJava(AEH) or
            FileIsForth(AEH) or
            FileIsROPS(AEH) or
            FileIsSPC(AEH) or
            FileIsPascal(AEH);
end;

function FileIsCPPOrPascalOrJava(AEH : TSynCustomHighlighter): Boolean;
begin
  Result := False;
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if not Assigned(AEH) then Exit;
  Result := FileIsCPP(AEH) or FileIsPascal(AEH) or FileIsJava(AEH);
end;

function FileIsMindScriptOrLASM(AEH : TSynCustomHighlighter): Boolean;
begin
  Result := False;
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if not Assigned(AEH) then Exit;
  Result := FileIsMindScript(AEH) or FileIsLASM(AEH);
end;

function UseNBCCompiler(AEH : TSynCustomHighlighter): Boolean;
begin
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  Result := FileIsNBC(AEH) or FileIsNXC(AEH) or FileIsNPG(AEH) or
            FileIsRICScript(AEH) or FileIsSPC(AEH) or FileIsSPASM(AEH);
end;

function FileIsNBCOrNXC(AEH : TSynCustomHighlighter): Boolean;
begin
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  Result := FileIsNBC(AEH) or FileIsNXC(AEH);
end;

function FileIsPascal(AEH : TSynCustomHighlighter): Boolean;
begin
  Result := False;
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if not Assigned(AEH) then Exit;
  Result := AEH is TSynPasSyn;
end;

function FileIsCPP(AEH : TSynCustomHighlighter): Boolean;
begin
  Result := False;
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if not Assigned(AEH) then Exit;
  Result := AEH is TSynCppSyn;
end;

function FileIsLASM(AEH : TSynCustomHighlighter): Boolean;
begin
  Result := False;
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if not Assigned(AEH) then Exit;
  Result := AEH is TSynLASMSyn;
end;

function FileIsNBC(AEH : TSynCustomHighlighter): Boolean;
begin
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if AEH <> nil then
    Result := AEH is TSynNBCSyn
  else
    Result := LowerCase(ExtractFileExt(GetActiveEditorFilename)) = '.nbc';
end;

function FileIsNXC(AEH : TSynCustomHighlighter = nil): Boolean;
begin
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if AEH <> nil then
    Result := AEH is TSynNXCSyn
  else
    Result := LowerCase(ExtractFileExt(GetActiveEditorFilename)) = '.nxc';
end;

function FileIsNPG(AEH : TSynCustomHighlighter = nil): Boolean;
begin
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if AEH <> nil then
    Result := AEH is TSynNPGSyn
  else
    Result := LowerCase(ExtractFileExt(GetActiveEditorFilename)) = '.npg';
end;

function FileIsRICScript(AEH : TSynCustomHighlighter = nil): Boolean;
begin
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if AEH <> nil then
    Result := AEH is TSynRSSyn
  else
    Result := LowerCase(ExtractFileExt(GetActiveEditorFilename)) = '.rs';
end;

function FileIsMindScript(AEH : TSynCustomHighlighter): Boolean;
begin
  Result := False;
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if not Assigned(AEH) then Exit;
  Result := AEH is TSynMindScriptSyn;
end;

function FileIsNQC(AEH : TSynCustomHighlighter): Boolean;
begin
  Result := False;
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if not Assigned(AEH) then Exit;
  Result := AEH is TSynNQCSyn;
end;

function FileIsJava(AEH : TSynCustomHighlighter): Boolean;
begin
  Result := False;
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if not Assigned(AEH) then Exit;
  Result := AEH is TSynJavaSyn;
end;

function FileIsForth(AEH : TSynCustomHighlighter): Boolean;
begin
  Result := False;
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if not Assigned(AEH) then Exit;
  Result := AEH is TSynForthSyn;
end;

function FileIsROPS(AEH : TSynCustomHighlighter): Boolean;
begin
  Result := False;
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if not Assigned(AEH) then Exit;
  Result := AEH is TSynROPSSyn;
end;

function FileIsSPC(AEH : TSynCustomHighlighter = nil): Boolean;
begin
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if AEH <> nil then
    Result := AEH is TSynSPCSyn
  else
    Result := LowerCase(ExtractFileExt(GetActiveEditorFilename)) = '.spc';
end;

function FileIsSPASM(AEH : TSynCustomHighlighter = nil): Boolean;
begin
  if not Assigned(AEH) then
    AEH := GetActiveEditorHighlighter;
  if AEH <> nil then
    Result := AEH is TSynSPASMSyn
  else
    Result := LowerCase(ExtractFileExt(GetActiveEditorFilename)) = '.spasm';
end;

function FileIsSPCOrSPASM(AEH : TSynCustomHighlighter = nil): Boolean;
begin
  Result := FileIsSPC(AEH) or FileIsSPASM(AEH);
end;

{Checks whether the brick is (still) alive}
function CheckAlive : boolean;
begin
  Result := False;
  // always start with a closed BrickComm
  if not BrickComm.UseBluetooth then
    BrickComm.Close;
  while True do
  begin
    if not LocalStandardFirmware then begin
      // leave BrickComm open
      BrickComm.Open;
      Break;
    end
    else begin
      if BrickComm.BrickAlive then
        Break
      else if MessageDlg(S_CANNOT_FIND_BRICK, mtWarning, [mbOK, mbCancel], 0) = mrCancel then
        Exit;
    end;
    if not BrickComm.UseBluetooth then
      BrickComm.Close;
  end;
  Result := True;
end;

end.