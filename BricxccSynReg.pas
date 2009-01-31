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

