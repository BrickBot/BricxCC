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
unit BricxccSynReg;

interface

uses
  Classes,
  {$IFDEF FPC}
   LResources,
  {$ENDIF}
  uNewHotKey,
  uOfficeComp,
  uTreeSaver,
{$IFNDEF FPC}
  uInstanceControl,
  SynEditAutoComplete,
  DirectoryEdit,
{$ENDIF}
  BricxccSynEdit,
  BricxccSpin,
  uSpin,
  SynHighlighterNQC,
  SynHighlighterH8,
  SynHighlighterForth,
  SynHighlighterMindScript,
  SynHighlighterLASM,
  SynHighlighterNBC,
  SynHighlighterNPG,
  SynHighlighterRS,
  SynHighlighterCS,
  SynHighlighterLua,
  SynHighlighterRuby,
  SynHighlighterROPS,
  SynEditEx;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('BricxCC', [TBricxCCHotKey, TBricxccSynEdit,
    TSynEditEx, TBricxccSpinEdit
    {$IFNDEF FPC}, TSpinEdit, TSynEditAutoComplete, TInstanceControl, TDirectoryEdit{$ENDIF}
  ]);
  RegisterComponents('BricxCC', [
    TSynNQCSyn, TSynForthSyn, TSynH8Syn, TSynMindScriptSyn, TSynLASMSyn,
    TSynNBCSyn, TSynNPGSyn, TSynRSSyn, TSynCSSyn, TSynLuaSyn, TSynRubySyn,
    TSynROPSSyn]);

  RegisterClasses([TOfficeMenuItem, TOfficeToolButton]);
  
  RegisterComponents('BricxCC', [TOfficeControlBar, TOfficeToolBar,
    TOfficeGradientPanel, TOfficePopupMenu, TOfficeMainMenu,
    TOfficeSpeedButton, TBricxCCTreeSave]);

end;

end.

