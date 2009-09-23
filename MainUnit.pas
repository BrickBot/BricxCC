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
 * The Initial Developer of this code is Mark Overmars.
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
{$B-}
unit MainUnit;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows,
  OleCtrls,
{$ELSE}
  LResources,
  LMessages,
  LCLType,
  LCLIntf,
{$ENDIF}
  Messages, Classes, Controls, Forms, Dialogs, ImgList, ActnList,
  StdCtrls, Menus, ComCtrls, ToolWin, Buttons, ExtCtrls,
  Preferences, uOfficeComp, uMiscDefines, Editor, uBasicPrefs,
  SynEditHighlighter, SynEditPrint, SynMacroRecorder,
  SynEditAutoComplete, SynCompletionProposal, SynEditPlugins,
  SynEditRegexSearch, SynEditMiscClasses, SynEditSearch,
  SynExportRTF, SynEditExport, SynExportHTML,
  SynHighlighterNQC, SynHighlighterForth, SynHighlighterJava,
  SynHighlighterCpp, SynHighlighterNBC, SynHighlighterCS,
  SynHighlighterMindScript, SynHighlighterLASM, SynHighlighterPas,
  SynHighlighterROPS, SynHighlighterLua, SynHighlighterRuby,
  SynHighlighterNPG, SynHighlighterRS,
  uPSComponent_StdCtrls, uPSComponent_Controls, uPSComponent_Forms,
  uPSComponent_Default, uPSComponent, uGrepExpert, uGrepSearch;

{$IFNDEF FPC}
const
  WM_BRICXCC_CMDLINE = WM_USER + 150;
{$ENDIF}

type

{$IFDEF FPC}
  tagMSG = TMessage;
{$ENDIF}

  { TMainForm }

  TMainForm = class(TForm)
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    dlgPrint: TPrintDialog;
    dlgOpenFirmware: TOpenDialog;
    dlgPrinterSetup: TPrinterSetupDialog;
    dlgOpenINI: TOpenDialog;
    dlgSaveINI: TSaveDialog;
    barStatus: TStatusBar;
    splCodeExplorer: TSplitter;
    pnlCodeExplorer: TPanel;
    alMain: TActionList;
    actFileToolbar: TAction;
    actSearchToolbar: TAction;
    actCompileToolbar: TAction;
    actHelpToolbar: TAction;
    actEditToolbar: TAction;
    actToolsToolbar: TAction;
    dlgInsertFile: TOpenDialog;
    actFileNew: TAction;
    actFileOpen: TAction;
    actFileSave: TAction;
    actFileSaveAs: TAction;
    actFileClose: TAction;
    actFileCloseAll: TAction;
    actFileInsertFile: TAction;
    actFilePageSetup: TAction;
    actFilePrinterSetup: TAction;
    actFilePrintPreview: TAction;
    actFilePrint: TAction;
    actFileExit: TAction;
    actEditUndo: TAction;
    actEditRedo: TAction;
    actEditCut: TAction;
    actEditCopy: TAction;
    actEditPaste: TAction;
    actEditDelete: TAction;
    actEditSelectAll: TAction;
    actEditNextField: TAction;
    actEditPreferences: TAction;
    actSearchFind: TAction;
    actSearchFindNext: TAction;
    actSearchFindPrev: TAction;
    actSearchReplace: TAction;
    actSearchGotoLine: TAction;
    actSearchProcList: TAction;
    actCompileCompile: TAction;
    actCompileDownload: TAction;
    actCompileDownloadRun: TAction;
    actCompileRun: TAction;
    actCompileStop: TAction;
    actToolsDirect: TAction;
    actToolsDiag: TAction;
    actToolsWatch: TAction;
    actToolsPiano: TAction;
    actToolsJoystick: TAction;
    actToolsRemote: TAction;
    actToolsSendMsg: TAction;
    actToolsDatalog: TAction;
    actToolsMemory: TAction;
    actToolsClearMem: TAction;
    actToolsFindBrick: TAction;
    actToolsTurnBrickOff: TAction;
    actToolsCloseComm: TAction;
    actToolsFirmware: TAction;
    actToolsUnlockFirm: TAction;
    actToolsConfigureTools: TAction;
    actHelpHelp: TAction;
    actHelpInfo: TAction;
    actFileSaveAll: TAction;
    actToolsMIDI: TAction;
    actToolsNewWatch: TAction;
    actToolsSetValues: TAction;
    actToolsSpybotEEPROM: TAction;
    actEditCopyHTML: TAction;
    actEditCopyRTF: TAction;
    pnlPageControl: TPanel;
    pagMain: TPageControl;
    pnlSep: TPanel;
    actToolsNXTExplorer: TAction;
    actToolsWav2Rso: TAction;
    actToolsSyncMotors: TAction;
    actToolsNXTScreen: TAction;
    actCompileStepOver: TAction;
    actCompileTraceInto: TAction;
    actCompilePause: TAction;
    actCompileSingleStep: TAction;
    actCompileStepOut: TAction;
    actCompileTraceToLine: TAction;
    actCompileRunToCursor: TAction;
    actHelpNXCGuidePDF: TAction;
    actHelpNQCGuidePDF: TAction;
    actHelpNBCGuidePDF: TAction;
    actHelpNXCTutorialPDF: TAction;
    actHelpNQCTutorialPDF: TAction;
    actHelpNBCTutorialPDF: TAction;
    actSearchGrepSearch: TAction;
    actSearchGrepResults: TAction;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlCodeExplorerDockOver(Sender: TObject;
      Source: TDragDockObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);
    procedure pnlCodeExplorerGetSiteInfo(Sender: TObject;
      DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint;
      var CanDock: Boolean);
    procedure actFileToolbarExecute(Sender: TObject);
    procedure actSearchToolbarExecute(Sender: TObject);
    procedure actCompileToolbarExecute(Sender: TObject);
    procedure actHelpToolbarExecute(Sender: TObject);
    procedure actEditToolbarExecute(Sender: TObject);
    procedure actToolsToolbarExecute(Sender: TObject);
    procedure alMainUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure actFileNewExecute(Sender: TObject);
    procedure actFileOpenExecute(Sender: TObject);
    procedure actCompileCompileExecute(Sender: TObject);
    procedure actCompileDownloadExecute(Sender: TObject);
    procedure actCompileDownloadRunExecute(Sender: TObject);
    procedure actCompileRunExecute(Sender: TObject);
    procedure actCompileStopExecute(Sender: TObject);
    procedure actEditUndoExecute(Sender: TObject);
    procedure actEditRedoExecute(Sender: TObject);
    procedure actEditCutExecute(Sender: TObject);
    procedure actEditCopyExecute(Sender: TObject);
    procedure actEditPasteExecute(Sender: TObject);
    procedure actEditDeleteExecute(Sender: TObject);
    procedure actEditSelectAllExecute(Sender: TObject);
    procedure actEditNextFieldExecute(Sender: TObject);
    procedure actEditPreferencesExecute(Sender: TObject);
    procedure actFileSaveExecute(Sender: TObject);
    procedure actFileSaveAsExecute(Sender: TObject);
    procedure actFileCloseExecute(Sender: TObject);
    procedure actFileCloseAllExecute(Sender: TObject);
    procedure actFileInsertFileExecute(Sender: TObject);
    procedure actFilePageSetupExecute(Sender: TObject);
    procedure actFilePrinterSetupExecute(Sender: TObject);
    procedure actFilePrintPreviewExecute(Sender: TObject);
    procedure actFilePrintExecute(Sender: TObject);
    procedure actFileExitExecute(Sender: TObject);
    procedure actSearchFindExecute(Sender: TObject);
    procedure actSearchFindNextExecute(Sender: TObject);
    procedure actSearchFindPrevExecute(Sender: TObject);
    procedure actSearchReplaceExecute(Sender: TObject);
    procedure actSearchGotoLineExecute(Sender: TObject);
    procedure actSearchProcListExecute(Sender: TObject);
    procedure actToolsDirectExecute(Sender: TObject);
    procedure actToolsDiagExecute(Sender: TObject);
    procedure actToolsWatchExecute(Sender: TObject);
    procedure actToolsPianoExecute(Sender: TObject);
    procedure actToolsJoystickExecute(Sender: TObject);
    procedure actToolsRemoteExecute(Sender: TObject);
    procedure actToolsSendMsgExecute(Sender: TObject);
    procedure actToolsDatalogExecute(Sender: TObject);
    procedure actToolsMemoryExecute(Sender: TObject);
    procedure actToolsClearMemExecute(Sender: TObject);
    procedure actToolsFindBrickExecute(Sender: TObject);
    procedure actToolsTurnBrickOffExecute(Sender: TObject);
    procedure actToolsCloseCommExecute(Sender: TObject);
    procedure actToolsFirmwareExecute(Sender: TObject);
    procedure actToolsUnlockFirmExecute(Sender: TObject);
    procedure actToolsConfigureToolsExecute(Sender: TObject);
    procedure actHelpHelpExecute(Sender: TObject);
    procedure actHelpInfoExecute(Sender: TObject);
    procedure actFileSaveAllExecute(Sender: TObject);
    procedure actToolsMIDIExecute(Sender: TObject);
    procedure actToolsNewWatchExecute(Sender: TObject);
    procedure actToolsSetValuesExecute(Sender: TObject);
    procedure actToolsSpybotEEPROMExecute(Sender: TObject);
    procedure actEditCopyHTMLExecute(Sender: TObject);
    procedure actEditCopyRTFExecute(Sender: TObject);
    procedure pagMainChange(Sender: TObject);
    procedure actToolsNXTExplorerExecute(Sender: TObject);
    procedure actToolsWav2RsoExecute(Sender: TObject);
    function  HandleOnHelp(Command: Word; Data: Longint; var CallHelp: Boolean): Boolean;
    procedure actToolsSyncMotorsExecute(Sender: TObject);
    procedure actToolsNXTScreenExecute(Sender: TObject);
    procedure actCompileStepOverExecute(Sender: TObject);
    procedure actCompileTraceIntoExecute(Sender: TObject);
    procedure actCompilePauseExecute(Sender: TObject);
    procedure actCompileSingleStepExecute(Sender: TObject);
    procedure actCompileStepOutExecute(Sender: TObject);
    procedure actCompileTraceToLineExecute(Sender: TObject);
    procedure actCompileRunToCursorExecute(Sender: TObject);
    procedure pagMainDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure pagMainDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure pnlPageControlDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure pnlPageControlDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure actHelpNXCGuidePDFExecute(Sender: TObject);
    procedure actHelpNQCGuidePDFExecute(Sender: TObject);
    procedure actHelpNBCGuidePDFExecute(Sender: TObject);
    procedure actHelpNXCTutorialPDFExecute(Sender: TObject);
    procedure actHelpNQCTutorialPDFExecute(Sender: TObject);
    procedure actHelpNBCTutorialPDFExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actSearchGrepSearchExecute(Sender: TObject);
    procedure actSearchGrepResultsExecute(Sender: TObject);
  public
    // menu components
    mnuMain: TOfficeMainMenu;
    mniFile: TOfficeMenuItem;
    mniNew: TOfficeMenuItem;
    mniOpen: TOfficeMenuItem;
    mniSave: TOfficeMenuItem;
    mniSaveAs: TOfficeMenuItem;
    mniSaveAll: TOfficeMenuItem;
    mniClose: TOfficeMenuItem;
    mniCloseAll: TOfficeMenuItem;
    N11: TOfficeMenuItem;
    mniInsertFile: TOfficeMenuItem;
    N2: TOfficeMenuItem;
    mniPageSetup: TOfficeMenuItem;
    mniPrinterSetup: TOfficeMenuItem;
    mniPrintPreview: TOfficeMenuItem;
    mniPrint: TOfficeMenuItem;
    mniSepFiles: TOfficeMenuItem;
    N1: TOfficeMenuItem;
    mniExit: TOfficeMenuItem;
    mniEdit: TOfficeMenuItem;
    mniUndo: TOfficeMenuItem;
    mniRedo: TOfficeMenuItem;
    N12: TOfficeMenuItem;
    mniCut: TOfficeMenuItem;
    mniCopy: TOfficeMenuItem;
    mniPaste: TOfficeMenuItem;
    mniDelete: TOfficeMenuItem;
    N6: TOfficeMenuItem;
    mniSelectAll: TOfficeMenuItem;
    mniCopySpecial: TOfficeMenuItem;
    mniCopyHTML: TOfficeMenuItem;
    mniCopyRTF: TOfficeMenuItem;
    N8: TOfficeMenuItem;
    mniNextField: TOfficeMenuItem;
    N16: TOfficeMenuItem;
    mniPreferences: TOfficeMenuItem;
    mniSearch: TOfficeMenuItem;
    mniFind: TOfficeMenuItem;
    mniFindNext: TOfficeMenuItem;
    mniFindPrevious: TOfficeMenuItem;
    mniReplace: TOfficeMenuItem;
    N13: TOfficeMenuItem;
    mniGotoLineNumber: TOfficeMenuItem;
    mniProcedureList: TOfficeMenuItem;
    N13a : TOfficeMenuItem;
    mniGrepSearch : TOfficeMenuItem;
    mniGrepResults : TOfficeMenuItem;
    mniView: TOfficeMenuItem;
    mniProjectManager: TOfficeMenuItem;
    mniCodeExplorer: TOfficeMenuItem;
    mniStatusbar: TOfficeMenuItem;
    mniShowTemplates: TOfficeMenuItem;
    mniShowCodeListing: TOfficeMenuItem;
    mniHideErrors: TOfficeMenuItem;
    mniViewToolWindows: TOfficeMenuItem;
    mniMacroManager: TOfficeMenuItem;
    mniPBForthConsole: TOfficeMenuItem;
    mniWindowList: TOfficeMenuItem;
    N18: TOfficeMenuItem;
    mniToolbars: TOfficeMenuItem;
    mniFileToolbar1: TOfficeMenuItem;
    mniSearchToolbar1: TOfficeMenuItem;
    mniCompileToolbar1: TOfficeMenuItem;
    mniHelpToolbar1: TOfficeMenuItem;
    mniEditToolbar1: TOfficeMenuItem;
    mniToolsToolbar1: TOfficeMenuItem;
    mniCompile: TOfficeMenuItem;
    mniCompileProgram: TOfficeMenuItem;
    mniDownload: TOfficeMenuItem;
    mniDownloadandRun: TOfficeMenuItem;
    mniProgramNumber: TOfficeMenuItem;
    mniProgram1: TOfficeMenuItem;
    mniProgram2: TOfficeMenuItem;
    mniProgram3: TOfficeMenuItem;
    mniProgram4: TOfficeMenuItem;
    mniProgram5: TOfficeMenuItem;
    mniProgram6: TOfficeMenuItem;
    mniProgram7: TOfficeMenuItem;
    mniProgram8: TOfficeMenuItem;
    N15: TOfficeMenuItem;
    mniRun: TOfficeMenuItem;
    mniStop: TOfficeMenuItem;
    mniPause: TOfficeMenuItem;
    mniSingleStep: TOfficeMenuItem;
    mniStepOver: TOfficeMenuItem;
    mniTraceInto: TOfficeMenuItem;
    mniRunToCursor: TOfficeMenuItem;
    mniRunUntilReturn: TOfficeMenuItem;
    mniTraceToLine: TOfficeMenuItem;
    mniCompSep: TOfficeMenuItem;
    mniTools: TOfficeMenuItem;
    mniDirectControl: TOfficeMenuItem;
    mniDiagnose: TOfficeMenuItem;
    mniWatch: TOfficeMenuItem;
    mniRCXPiano: TOfficeMenuItem;
    mniRCXJoystick: TOfficeMenuItem;
    mniRemote: TOfficeMenuItem;
    mniNewWatch: TOfficeMenuItem;
    mniSetvalues: TOfficeMenuItem;
    mniSpybotEEPROM: TOfficeMenuItem;
    mniNXTExplorer: TOfficeMenuItem;
    mniNXTScreen: TOfficeMenuItem;
    mniSyncMotors: TOfficeMenuItem;
    N7: TOfficeMenuItem;
    mniSendMessage: TOfficeMenuItem;
    mniDatalog: TOfficeMenuItem;
    mniMemoryMap: TOfficeMenuItem;
    mniClearMemory: TOfficeMenuItem;
    mniMIDIConversion: TOfficeMenuItem;
    mniSoundConvert: TOfficeMenuItem;
    N9: TOfficeMenuItem;
    mniFindRCX: TOfficeMenuItem;
    mniTurnRCXOff: TOfficeMenuItem;
    mniCloseComm: TOfficeMenuItem;
    N3: TOfficeMenuItem;
    mniFirmware: TOfficeMenuItem;
    mniUnlockFirmware: TOfficeMenuItem;
    mniConfigureTools: TOfficeMenuItem;
    N4: TOfficeMenuItem;
    mniBrickOS: TOfficeMenuItem;
    mniSetLNPAddress: TOfficeMenuItem;
    mniDownloadAddress: TOfficeMenuItem;
    mniAddress0: TOfficeMenuItem;
    mniAddress1: TOfficeMenuItem;
    mniAddress2: TOfficeMenuItem;
    mniAddress3: TOfficeMenuItem;
    mniAddress4: TOfficeMenuItem;
    mniAddress5: TOfficeMenuItem;
    mniAddress6: TOfficeMenuItem;
    mniAddress7: TOfficeMenuItem;
    mniAddress8: TOfficeMenuItem;
    mniAddress9: TOfficeMenuItem;
    mniAddress10: TOfficeMenuItem;
    mniAddress11: TOfficeMenuItem;
    mniAddress12: TOfficeMenuItem;
    mniAddress13: TOfficeMenuItem;
    mniAddress14: TOfficeMenuItem;
    mniAddress15: TOfficeMenuItem;
    mniLNPPort: TOfficeMenuItem;
    mniPort0: TOfficeMenuItem;
    mniPort1: TOfficeMenuItem;
    mniPort2: TOfficeMenuItem;
    mniPort3: TOfficeMenuItem;
    mniPort4: TOfficeMenuItem;
    mniPort5: TOfficeMenuItem;
    mniPort6: TOfficeMenuItem;
    mniPort7: TOfficeMenuItem;
    mniPort8: TOfficeMenuItem;
    mniPort9: TOfficeMenuItem;
    mniPort10: TOfficeMenuItem;
    mniPort11: TOfficeMenuItem;
    mniPort12: TOfficeMenuItem;
    mniPort13: TOfficeMenuItem;
    mniPort14: TOfficeMenuItem;
    mniPort15: TOfficeMenuItem;
    mniWindow: TOfficeMenuItem;
    mniTileHorizontal: TOfficeMenuItem;
    mniTileVertical: TOfficeMenuItem;
    mniCascade: TOfficeMenuItem;
    mniArrange: TOfficeMenuItem;
    N10: TOfficeMenuItem;
    mniPositions: TOfficeMenuItem;
    mniPosSave: TOfficeMenuItem;
    mniPosLoad: TOfficeMenuItem;
    mniHelp: TOfficeMenuItem;
    mniContents: TOfficeMenuItem;
    mniIndex: TOfficeMenuItem;
    mniNqcGuide: TOfficeMenuItem;
    mniHowTo: TOfficeMenuItem;
    N5: TOfficeMenuItem;
    mniWebpage: TOfficeMenuItem;
    mniNXCGuidePDF : TOfficeMenuItem;
    mniNQCGuidePDF : TOfficeMenuItem;
    mniNBCGuidePDF : TOfficeMenuItem;
    mniGuidePDFs : TOfficeMenuItem;
    mniTutorialPDFs : TOfficeMenuItem;
    mniNXCTutorialPDF : TOfficeMenuItem;
    mniNQCTutorialPDF : TOfficeMenuItem;
    mniNBCTutorialPDF : TOfficeMenuItem;
    N14: TOfficeMenuItem;
    mniAbout: TOfficeMenuItem;
    // popup menus
    mnuToolbars: TOfficePopupMenu;
    mniFileToolbar: TOfficeMenuItem;
    mniSearchToolbar: TOfficeMenuItem;
    mniCompileToolbar: TOfficeMenuItem;
    mniHelpToolbar: TOfficeMenuItem;
    mniEditToolbar: TOfficeMenuItem;
    mniToolsToolbar: TOfficeMenuItem;
    // page control popup menu
    mnuPageControl: TOfficePopupMenu;
    mniTabClose: TOfficeMenuItem;
    mniTabCloseAll: TOfficeMenuItem;
    N17: TOfficeMenuItem;
    mniNextWindow: TOfficeMenuItem;
    // synedit highlighters
    SynNXCSyn: TSynNXCSyn;
    SynNPGSyn: TSynNPGSyn;
    SynRubySyn: TSynRubySyn;
    SynNBCSyn: TSynNBCSyn;
    SynJavaSyn: TSynJavaSyn;
    SynLASMSyn: TSynLASMSyn;
    SynNQCSyn: TSynNQCSyn;
    SynPasSyn: TSynPasSyn;
    SynMindScriptSyn: TSynMindScriptSyn;
    SynCSSyn: TSynCSSyn;
    SynLuaSyn: TSynLuaSyn;
    SynRSSyn: TSynRSSyn;
    SynCppSyn: TSynCppSyn;
    SynForthSyn: TSynForthSyn;
    SynROPSSyn: TSynROPSSyn;
    // pascal script components
    PSImport_Controls: TPSImport_Controls;
    PSImport_StdCtrls: TPSImport_StdCtrls;
    PSImport_Forms: TPSImport_Forms;
    PSImport_DateUtils: TPSImport_DateUtils;
    PSImport_Classes: TPSImport_Classes;
    ce: TPSScriptDebugger;
    // toolbar components
    cbrTop: TOfficeControlBar;
    ogpHelp: TOfficeGradientPanel;
    ogpEdit: TOfficeGradientPanel;
    ogpTools: TOfficeGradientPanel;
    ogpCompile: TOfficeGradientPanel;
    ogpSearch: TOfficeGradientPanel;
    ogpFile: TOfficeGradientPanel;
    // toolbar buttons and separators
    osbNew: TOfficeSpeedButton;
    osbOpen: TOfficeSpeedButton;
    osbSave: TOfficeSpeedButton;
    osbClose: TOfficeSpeedButton;
    osbCloseAll: TOfficeSpeedButton;
    bvlFile2: TBevel;
    osbPreview: TOfficeSpeedButton;
    osbPrint: TOfficeSpeedButton;
    osbFind: TOfficeSpeedButton;
    osbReplace: TOfficeSpeedButton;
    bvlSearch: TBevel;
    osbGoto: TOfficeSpeedButton;
    osbProcList: TOfficeSpeedButton;
    osbCompileBtn: TOfficeSpeedButton;
    osbDownloadBtn: TOfficeSpeedButton;
    bvlSep1: TBevel;
    osbStopBtn: TOfficeSpeedButton;
    osbRunBtn: TOfficeSpeedButton;
    bvlSep2: TBevel;
    pnlProgBox: TPanel;
    ProgramBox: TComboBox;
    osbPreferences: TOfficeSpeedButton;
    bvlSep4: TBevel;
    osbDelete: TOfficeSpeedButton;
    osbPaste: TOfficeSpeedButton;
    osbCopy: TOfficeSpeedButton;
    osbCut: TOfficeSpeedButton;
    bvlSep3: TBevel;
    osbRedo: TOfficeSpeedButton;
    osbUndo: TOfficeSpeedButton;
    osbCloseComm: TOfficeSpeedButton;
    osbTurnBrickOff: TOfficeSpeedButton;
    osbFindBrick: TOfficeSpeedButton;
    bvlSep6: TBevel;
    osbMemoryMap: TOfficeSpeedButton;
    osbDatalog: TOfficeSpeedButton;
    osbSendMessage: TOfficeSpeedButton;
    bvlSep5: TBevel;
    osbSpybotEEPROM: TOfficeSpeedButton;
    osbSetValues: TOfficeSpeedButton;
    osbNewWatch: TOfficeSpeedButton;
    osbRemote: TOfficeSpeedButton;
    osbJoystick: TOfficeSpeedButton;
    osbPiano: TOfficeSpeedButton;
    osbWatch: TOfficeSpeedButton;
    osbDiagnostics: TOfficeSpeedButton;
    osbDirectControl: TOfficeSpeedButton;
    osbContents: TOfficeSpeedButton;
    osbInfo: TOfficeSpeedButton;
    // completion proposal components
    SynForthCompProp: TSynCompletionProposal;
    SynCppCompProp: TSynCompletionProposal;
    SynNQCCompProp: TSynCompletionProposal;
    SynNBCCompProp: TSynCompletionProposal;
    SynMindScriptCompProp: TSynCompletionProposal;
    SynLASMCompProp: TSynCompletionProposal;
    SynPasCompProp: TSynCompletionProposal;
    SynROPSCompProp: TSynCompletionProposal;
    scpParams: TSynCompletionProposal;
    SynNXCCompProp: TSynCompletionProposal;
    SynNPGCompProp: TSynCompletionProposal;
    SynRSCompProp: TSynCompletionProposal;
    // misc synedit components
    SynMacroRec: TSynMacroRecorder;
    SynAutoComp: TSynEditAutoComplete;
    SynEditSearch: TSynEditSearch;
    SynEditRegexSearch: TSynEditRegexSearch;
    expRTF: TSynExporterRTF;
    expHTML: TSynExporterHTML;
    SynEditPrint: TSynEditPrint;
  protected
//    procedure icInstanceCtrlMaxInstancesReached(Sender: TObject;
//      const LastInstanceHandle: Cardinal);
    procedure DragDropHelper(Sender, Source: TObject; X, Y: Integer);
    procedure DragOverHelper(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ceExecute(Sender: TPSScript);
    procedure ceCompile(Sender: TPSScript);
    procedure ceIdle(Sender: TObject);
    procedure ceAfterExecute(Sender: TPSScript);
    procedure ceBreakpoint(Sender: TObject; const FileName: String;
      Position, Row, Col: Cardinal);
    procedure ceLineInfo(Sender: TObject; const FileName: String; Position,
      Row, Col: Cardinal);
    function ceNeedFile(Sender: TObject; const OrginFileName: String;
      var FileName, Output: String): Boolean;
    procedure BarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbrTopDockOver(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ProgramBoxChange(Sender: TObject);
    procedure RecentFileClick(Sender: TObject);
    procedure mniSetLNPAddressClick(Sender: TObject);
    procedure mniAddress0Click(Sender: TObject);
    procedure mniPort0Click(Sender: TObject);
    procedure mniNextWindowClick(Sender: TObject);
    procedure mniCompileClick(Sender: TObject);
    procedure mniToolsClick(Sender: TObject);
    procedure mniHowToClick(Sender: TObject);
    procedure mniFileClick(Sender: TObject);
    procedure mniTileHorizontalClick(Sender: TObject);
    procedure mniCascadeClick(Sender: TObject);
    procedure mniArrangeClick(Sender: TObject);
    procedure mniHideErrorsClick(Sender: TObject);
    procedure mniTileVerticalClick(Sender: TObject);
    procedure mniShowTemplatesClick(Sender: TObject);
    procedure mniProgram1Click(Sender: TObject);
    procedure mniShowCodeListingClick(Sender: TObject);
    procedure mniWebpageClick(Sender: TObject);
    procedure mniWindowClick(Sender: TObject);
    procedure mniPosLoadClick(Sender: TObject);
    procedure mniPosSaveClick(Sender: TObject);
    procedure mniViewClick(Sender: TObject);
    procedure mniStatusbarClick(Sender: TObject);
    procedure mniNqcGuideClick(Sender: TObject);
    procedure IndexClick(Sender: TObject);
    procedure SynMacroRecStateChange(Sender: TObject);
    procedure mniViewToolWindowsClick(Sender: TObject);
    procedure mniCodeExplorerClick(Sender: TObject);
    procedure mniMacroManagerClick(Sender: TObject);
    procedure mniWindowListClick(Sender: TObject);
    procedure mniPBForthConsoleClick(Sender: TObject);
    procedure mniProjectManagerClick(Sender: TObject);
    procedure scpParamsExecute(Kind: SynCompletionType; Sender: TObject;
      var CurrentInput: String; var x, y: Integer;
      var CanExecute: Boolean);
    procedure SynMindScriptCompPropExecute(Kind: SynCompletionType;
      Sender: TObject; var CurrentInput: String; var x, y: Integer;
      var CanExecute: Boolean);
    procedure HandleExplorerFinished(Sender: TObject);
    procedure HandleOnAddConstruct(Sender : TObject; const aTemplate : string; const aX : integer = -1; const aY : integer = -1);
  private
    { Private declarations }
    fGE : TGrepExpert;
    fGDE : TGrepDlgExpert;
    newcount : integer;
    FActiveLine : integer;
    fOldActiveEditorForm : TEditorForm;
    fMDI : Boolean;
    FResume : boolean;
    fNQCAPIBase : TStringList;
    fNXCAPIBase : TStringList;
{$IFNDEF FPC}
    procedure WMClose(var Message: TWMClose); message WM_CLOSE;
    procedure WMDROPFILES(var Message: TWMDROPFILES); message WM_DROPFILES;
    procedure HandleOnMessage(var Msg: tagMSG; var Handled: Boolean);
{$ENDIF}
    procedure CreateSpiritPlugins;
    function  CloseAllEditors : boolean;
    function  CloseEditor(E : TEditorForm; bAll : Boolean = False) : boolean;
    function  GetEditorFormCount: integer;
    function  GetEditorForm(index: integer): TEditorForm;
    function  DoCreateEditorForm : TEditorForm;
    procedure UpdateStatusBar;
    procedure UpdateCompilerMenu;
    procedure UpdateToolsMenu;
    procedure HandleCompXferClick(Sender: TObject);
    procedure HandleTransferClick(Sender: TObject);
    procedure DoSaveAll;
    function  IsStandardFirmware(aFile : string) : Boolean;
    function  SwitchToFile(fname: string; lineNo : integer = -1): Boolean;
    procedure ConfigureOtherFirmwareOptions;
    function DoCompileAction(bDown, bRun : Boolean) : boolean;
    procedure DoToolbarExecute(act: TCustomAction; bar: TOfficeGradientPanel);
    procedure SetFilterIndexFromLanguage;
    procedure SetColorScheme;
    procedure ShowNXTTools;
    function  ProcessParams(aParams: string): string;
    procedure ConfigureTransferMenuItemVisibility(aList: TList;
      aMenuItem: TOfficeMenuItem; const aPrefix: string);
    procedure CreateCompPropComponents;
    procedure CreateMainFormHighlighters;
    procedure CreatePascalScriptComponents;
    procedure CreateMenus;
    procedure CreateToolbars;
    procedure CreateFileToolbar;
    procedure CreateEditToolbar;
    procedure CreateSearchToolbar;
    procedure CreateCompileToolbar;
    procedure CreateHelpToolbar;
    procedure CreateToolsToolbar;
    procedure CreateMiscSynEditComponents;
    procedure HandleOnGetVarInfoByID(Sender : TObject; const ID : integer; var offset, size, vartype : integer);
    procedure HandleOnGetVarInfoByName(Sender : TObject; const name : string; var offset, size, vartype : integer);
    procedure UpdateEditorPosition;
    procedure LoadNQCCompProp;
    procedure LoadNXCCompProp;
    procedure DoLoadAPI(cp: TSynCompletionProposal; aStrings: TStrings);
    procedure AddUserDefinedFunctions(aStrings : TStrings);
  public
    { Public declarations }
    procedure HandleOnCompilerStatusChange(Sender: TObject; const StatusMsg: string);
    procedure DoDisplayErrors(aShow : boolean);
    procedure DoHideErrors;
    procedure ExecuteTransferItem(TI: TTransferItem);
//    function CloseQuery: Boolean; override;
    procedure UpdateProgramSlotMenuItems(index : Integer);
    procedure ChangeActiveEditor;
    procedure ShowCodeExplorer;
    procedure ShowTemplates(bSave : boolean = true);
    procedure HandleOpenStateChanged(Sender : TObject);
    procedure DoSaveAs(EdFrm : TEditorForm);
    procedure DoSave(EdFrm : TEditorForm);
    procedure DoPrint(EdFrm : TEditorForm);
    procedure DoPrintPreview(EdFrm : TEditorForm);
    procedure SelectProgram(idx : integer);
    procedure StartTask(idx : integer);
    procedure ClearMemory;
    procedure DownloadFirmware;
    procedure SaveModifiedFiles;
    procedure UpdateSynComponents;
    function ActiveEditorForm : TEditorForm;
    function ActiveLanguageIndex : integer;
    function ActiveLanguageName : string;
    procedure ActivateEditorForm(index : Integer); overload;
    procedure ActivateEditorForm(E : TEditorForm); overload;
    procedure OpenFile(aPath : string; lineNo : integer = -1);
    procedure SaveDesktop(aFile : string);
    procedure LoadDesktop(aFile : string);
    property EditorFormCount : integer read GetEditorFormCount;
    property EditorForms[index : integer] : TEditorForm read GetEditorForm;
    property MDI : Boolean read fMDI write fMDI;
    property ActiveLine : integer read fActiveLine;
    property GrepDlgExpert : TGrepDlgExpert read fGDE;
  end;

var
  MainForm: TMainForm;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  SysUtils, Graphics,
  ClipBrd, GotoLine, SearchRCX, Piano,
  About, Controller, Diagnose, Unlock, Watch,
  ExecProgram, ConstructUnit,
  JoystickUnit, DatalogUnit, MemoryUnit, RemoteUnit,
  CodeUnit, MessageUnit, SynEdit,
{$IFNDEF FPC}
  ShellApi, uForthConsole, DPageSetup, uPSI_FakeSpirit,
{$ENDIF}
  DTestPrintPreview,
  ParamUtils, uCodeExplorer,
  Transfer, Transdlg, uMacroForm, uWindowList,
  uHighlighterProcs, uMindScript, uCppCode,
  BricxccSynEdit, SynEditTypes, uProjectManager, uMIDIConversion,
  uSetLNPAddress, uNewWatch, uSetValues, uEEPROM,
  Themes, brick_common, uWav2RSO, uNXTExplorer, uGuiUtils,
  uNXTController, uNXTImage, Math, uPSI_brick_common, uPSI_uSpirit,
  uPSI_FantomSpirit, uPSRuntime, uPSDebugger,
  SynEditPrintTypes, rcx_constants, uLocalizedStrings,
  uNQCCodeComp, uNXTCodeComp, uNXCCodeComp, uRICCodeComp,
  uProgram, uCompStatus, uGlobals, uEditorUtils;

const
  K_NQC_GUIDE = 24;
  HELP_TAB    = 15;
  K_DESKTOP_EXT = '.dsk';

var
  TogglingFormStyle : Boolean = false;

procedure SetupSpirit;
begin
  BrickComm.BrickType            := LocalBrickType;
  BrickComm.Port                 := LocalPort;
  BrickComm.UseBluetooth         := LocalUseBluetooth;
  BrickComm.RCXFirmwareChunkSize := FirmwareChunkSize;
  BrickComm.DownloadWaitTime     := DownloadWaitTime;
  BrickComm.VerboseMode          := ParamSwitch('/Verbose');
  BrickComm.RxTimeout            := PingTimeout;
  BrickComm.TowerExistsSleep     := TowerExistsSleep;
//  BrickComm.OnOpenStateChanged := HandleOpenStateChanged;
end;

procedure TMainForm.mniFileClick(Sender: TObject);
begin
  {Show the recent files}
  ShowRecentFiles(Sender as TOfficeMenuItem, RecentFileClick);
end;

procedure TMainForm.RecentFileClick(Sender: TObject);
begin
  OpenFile(GetRecentFileName(TOfficeMenuItem(Sender).Tag));
end;

procedure TMainForm.mniShowTemplatesClick(Sender: TObject);
begin
  mniShowTemplates.Checked := not mniShowTemplates.Checked;
  ShowTemplateForm := mniShowTemplates.Checked;
  if ShowTemplateForm then
    ShowTemplates
  else
    ConstructForm.Close;
//  ConstructForm.Visible := ShowTemplateForm;
end;

procedure TMainForm.mniProgram1Click(Sender: TObject);
begin
  if not Assigned(Sender) then Exit;
  if not CheckAlive then Exit;
  TOfficeMenuItem(Sender).Checked := true;
  SelectProgram(TOfficeMenuItem(Sender).Tag);
  ProgramBox.ItemIndex := TOfficeMenuItem(Sender).Tag;
  CurrentProgramSlot := ProgramBox.ItemIndex;
end;

procedure TMainForm.mniShowCodeListingClick(Sender: TObject);
begin
  CodeForm.Visible := not CodeForm.Visible;
end;

procedure TMainForm.DoHideErrors;
var
  F : TEditorForm;
begin
  F := ActiveEditorForm;
  if F <> nil then
  begin
    barStatus.Panels[1].Text := '';
    F.TheErrors.Items.Clear;
    F.TheErrors.Visible := False;
    F.splErrors.Visible := False;
  end;
end;

procedure TMainForm.mniHideErrorsClick(Sender: TObject);
begin
  DoHideErrors;
end;

procedure PostSearchSetup(bTalkToBrick : Boolean; bBrickAlive : Boolean);
begin
  // make sure our Fake Spirit has the correct RCXType and COMPort
  SetupSpirit;
  {Change setting and give warnings based on the outcome}
  MainForm.barStatus.Panels[2].Text := BrickComm.NicePortName;
  if not IRExists then
  begin
    if LocalStartupAction <> SU_NOCONNECT then
      MessageDlg(sNoRCX,mtInformation,[mbOK], 0);
    MainForm.barStatus.Panels[2].Text := sNoPort;
    MainForm.barStatus.Panels[3].Text := '';
    // make sure the port is not held open here
    BrickComm.Close;
  end
  else if LocalStandardFirmware and
          (bTalkToBrick and not bBrickAlive) then
  begin
    if LocalStartupAction <> SU_NOCONNECT then
      MessageDlg(sNoRCX,mtInformation,[mbOK], 0);
    MainForm.barStatus.Panels[3].Text := sNoRobot;
    // make sure the port is not held open here
    BrickComm.Close;
  end
  else if not (IsRCX or IsSpybotic or IsNXT) then
  begin
    // scout or cybermaster
    if bTalkToBrick then
      MainForm.actToolsUnlockFirmExecute(nil);
    if LocalBrickType = SU_SCOUT then
    begin
      MainForm.barStatus.Panels[3].Text := K_SCOUT;
    end
    else
    begin
      MainForm.barStatus.Panels[3].Text := K_CYBER;
    end;
  end
  else if IsSpybotic then
  begin
    // spybot
    MainForm.barStatus.Panels[3].Text := K_SPY;
  end
  else if IsNXT then
  begin
    // NXT
    MainForm.barStatus.Panels[3].Text := K_NXT;
  end
  else
  begin
    // RCX compatible
    if LocalBrickType = SU_RCX2 then
      MainForm.barStatus.Panels[3].Text := K_RCX2
    else if LocalBrickType = SU_SWAN then
      MainForm.barStatus.Panels[3].Text := K_SWAN
    else
      MainForm.barStatus.Panels[3].Text := K_RCX;
    if bTalkToBrick then
    begin
      MainForm.SelectProgram(0);
      MainForm.ProgramBox.ItemIndex := 0;
    end;
  end;
end;

procedure FindRCX(atstartup:boolean);
var
  bAlive : Boolean;
begin
  bAlive := SearchForRCX(atstartup, FBAlwaysPrompt);
  if bAlive then
    bAlive := BrickComm.Ping;
  PostSearchSetup(True, bAlive);
end;

procedure TMainForm.mniTileHorizontalClick(Sender: TObject);
begin
{$IFNDEF FPC}
  TileMode := tbHorizontal;
  Tile;
{$ENDIF}
end;

procedure TMainForm.mniTileVerticalClick(Sender: TObject);
begin
{$IFNDEF FPC}
  TileMode := tbVertical;
  Tile;
{$ENDIF}
end;

procedure TMainForm.mniCascadeClick(Sender: TObject);
begin
{$IFNDEF FPC}
 Cascade;
{$ENDIF}
end;

procedure TMainForm.mniArrangeClick(Sender: TObject);
begin
{$IFNDEF FPC}
  ArrangeIcons;
{$ENDIF}
end;

procedure TMainForm.mniHowToClick(Sender: TObject);
begin
{$IFNDEF FPC}
  Application.HelpCommand(HELP_HELPONHELP, 0);
{$ENDIF}
end;

procedure TMainForm.mniWebpageClick(Sender: TObject);
const
  K_WEBPAGE = 'http://bricxcc.sourceforge.net/';
begin
{$IFNDEF FPC}
  ShellExecute(Handle, 'open', K_WEBPAGE, '', '', SW_NORMAL);
{$ENDIF}
end;

procedure TMainForm.ProgramBoxChange(Sender: TObject);
var
  i : integer;
begin
  if not Assigned(Sender) then Exit;
  if not CheckAlive then Exit;
  i := TComboBox(Sender).ItemIndex;
  SelectProgram(i);
  UpdateProgramSlotMenuItems(i);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  fGE := TGrepExpert.Create;
  fGDE := TGrepDlgExpert.Create;
  fNQCAPIBase := TStringList.Create;
  fNXCAPIBase := TStringList.Create;
  CreateMenus;
  CreateCompPropComponents;
  CreateMainFormHighlighters;
  CreatePascalScriptComponents;
  CreateToolbars;
  CreateMiscSynEditComponents;
  Application.OnHelp := HandleOnHelp;
{$IFNDEF FPC}
  Application.OnMessage := HandleOnMessage;
{$ENDIF}
  CreateSpiritPlugins;
  SetColorScheme;
  fOldActiveEditorForm := nil;
  pnlCodeExplorer.DockOrientation := doVertical;
  AppIsClosing := False;
{$IFNDEF FPC}
  if GetUseMDIMode then
    FormStyle := fsMDIForm
  else
    FormStyle := fsNormal;
  fMDI := FormStyle = fsMDIForm;
  pnlPageControl.Align := alClient;
  pnlPageControl.Visible := not MDI;
  {Let Windows know we accept dropped files}
  DragAcceptFiles(Handle,true);
{$ELSE}
  pnlPageControl.Align := alClient;
  pnlPageControl.Visible := True;
{$ENDIF}
  newcount := 0;
  ProgramBox.ItemIndex := 0;
  mniAddress0.Checked  := True; // default to LNP address 0
  mniPort0.Checked     := True; // default to LNP port 0
  // set help file
  Application.HelpFile := ProgramDir + 'Help\BricxCC.HLP';
  HelpFile := Application.HelpFile;
  // initialize the highlighter data
  GetSortedHighlighters(Self, Highlighters, False);
  dlgOpen.Filter := GetHighlightersFilter(Highlighters) + SFilterAllFiles;
  dlgSave.Filter := dlgOpen.Filter;
  SynForthCompProp.EndOfTokenChr := '';
  PopulateMindscriptWordList('', SynMindScriptCompProp.ItemList);
  PopulateCppCompProp(SynCppCompProp);
  PopulatePasCompProp(SynPasCompProp);
  PopulateROPSCompProp(SynROPSCompProp);
  LoadLASMCodeComplete(SynLASMCompProp.ItemList);
  LoadNBCCodeComplete(SynNBCCompProp.ItemList);
  LoadNPGCodeComplete(SynNPGCompProp.ItemList);
  LoadRSCodeComplete(SynRSCompProp.ItemList);
  // hook up transfer item execution proc
  DoExecuteTransferItem := Self.ExecuteTransferItem;
  // hook up the ROPS compiler
  theROPSCompiler := Self.ce;
  // hook up the search engines
  seRegex  := Self.SynEditRegexSearch;
  seNormal := Self.SynEditSearch;
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  i : Integer;
  aParam : string;
  F : TEditorForm;
begin
  {Find the RCX}
  if not (TogglingFormStyle or RunningAsCOMServer) then
    FindRCX(true);
  {Show statusbar}
  barStatus.Visible  := ShowStatusbar;
  {Open argument file, if any }
  for i := 1 to ParamCount do
  begin
    aParam := ParamStr(i);
    if (Pos('/', aParam) = 1) or (Pos('-', aParam) = 1) then
      continue; // a switch - not a file
    F := DoCreateEditorForm;
    if Assigned(F) then
      F.OpenFile(ParamStr(i));
  end;
  // process shell New and Print switches
  if ParamSwitch('/New') then
    actFileNewExecute(Self);
  if ParamSwitch('/Print') then begin
    actFilePrintExecute(Self);
    // form flashes briefly then closes.  Good enough for now
    Close;
  end;
  frmCodeExplorer.OnFinishedProcessing := HandleExplorerFinished;
{
  ShowCodeExplorer;
  if not CodeExplorerSettings.AutoShowExplorer then
    frmCodeExplorer.Close;
}
  if CodeExplorerSettings.AutoShowExplorer then
    ShowCodeExplorer;
  // hook up the template form event handler
  if Assigned(ConstructForm) then
    ConstructForm.OnAddConstruct := HandleOnAddConstruct;
  {Add the Templates}
  if ShowTemplateForm then
    ShowTemplates(False);
  // process the toolbars
  RestoreToolbars;
  WindowState := TWindowState(MainWindowState);
  TogglingFormStyle := False;
  UpdateCompilerMenu;
  UpdateToolsMenu;
  // hook macro manager
  frmMacroManager.MacroLibrary.MacroRecorder := SynMacroRec;
  if not (TogglingFormStyle or RunningAsCOMServer) and
     FileExists(DefaultMacroLibrary) then
    frmMacroManager.CurrentLibraryPath := DefaultMacroLibrary;
  ConfigureOtherFirmwareOptions;
end;

{Reacting on dropping a file on the form}
{$IFNDEF FPC}
procedure TMainForm.WMDROPFILES(var Message: TWMDROPFILES);
var
  buffer:array[0..255] of char;
  F : TEditorForm;
  cnt, i : Integer;
begin
  cnt := DragQueryFile(Message.Drop, $FFFFFFFF, @buffer, sizeof(buffer));
  for i := 0 to cnt - 1 do
  begin
    DragQueryFile(Message.Drop,i,@buffer,sizeof(buffer));
    F := DoCreateEditorForm;
    if Assigned(F) then
    begin
      F.OpenFile(buffer);
      if DroppedRecent then
        AddRecentFile(buffer);
    end;
    if not MDI then
      pagMainChange(nil);
  end;
  DragFinish(Message.Drop);
end;
{$ENDIF}

procedure TMainForm.SelectProgram(idx : integer);
begin
  if LocalStandardFirmware then
    BrickComm.SelectProgram(idx+1);
end;

procedure TMainForm.StartTask(idx : integer);
var
  H : TSynCustomHighlighter;
  Fname : string;
  binext : string;
begin
  if LocalStandardFirmware then
  begin
    H := GetActiveEditorHighlighter;
    Fname := GetActiveEditorFilename;
    if Assigned(H) and FileIsROPS(H) then
    begin
      if ce.Running then
      begin
        FResume := True;
      end
      else
      begin
        if DoCompileAction(False, False) then
          ce.Execute;
      end;
    end
    else if IsSpybotic then
      BrickComm.StartTask(8)
    else if IsNXT then
    begin
      if Assigned(H) and not FileIsRICScript(H) then
      begin
        if FileIsNPG(H) then
          binext := '.rpg'
        else
          binext := '.rxe';
        fNXTCurrentOffset := nil;
        if (binext = '.rxe') and not CurrentProgram.Loaded(Fname) then
          DoCompileAction(False, False);

        BrickComm.StartProgram(ChangeFileExt(ExtractFileName(Fname), binext));
        fNXTVMState := kNXT_VMState_RunFree;
        actCompilePause.Caption := sBreakAll;
        // make sure the variable watch event handlers are hooked up
        BrickComm.OnGetVarInfoByID := HandleOnGetVarInfoByID;
        BrickComm.OnGetVarInfoByName := HandleOnGetVarInfoByName;
      end
      else
        ShowNXTTools;
    end
    else
      BrickComm.StartTask(idx);
  end;
end;

procedure TMainForm.mniWindowClick(Sender: TObject);
var
  bEnabled : boolean;
begin
// set enabled state of menu items
  bEnabled := MDI and (ActiveEditorForm <> nil);
  mniTileHorizontal.Enabled := bEnabled;
  mniTileVertical.Enabled   := bEnabled;
  mniCascade.Enabled        := bEnabled;
  mniArrange.Enabled        := bEnabled;
end;

procedure TMainForm.ClearMemory;
begin
  if (MessageDlg(sClearMemConfirm, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    BrickComm.ClearMemory;
    // Set program number back
    ProgramBoxChange(ProgramBox);
  end;
end;

procedure TMainForm.DownloadFirmware;
var
  val : integer;
  bUnlock : Boolean;
begin
  BrickComm.Quiet := QuietFirmware;
  bUnlock := IsStandardFirmware(dlgOpenFirmware.FileName);
  val := TUnlockForm.DownloadFirmware(dlgOpenFirmware.FileName, FirmwareFast, FirmwareComp, bUnlock);
  if val = mrCancel then
    MessageDlg(sWarnCancelFD, mtWarning,[mbOK],0)
  else if val = mrNo then
  begin
    MessageDlg(sFirmDwnldFailed, mtError,[mbOK],0);
  end;
end;

procedure TMainForm.mniPosLoadClick(Sender: TObject);
begin
  if dlgOpenINI.Execute then
  begin
    LoadWindowValuesFromFile(dlgOpenINI.FileName);
  end;
end;

procedure TMainForm.mniPosSaveClick(Sender: TObject);
begin
  if dlgSaveINI.Execute then
  begin
    SaveWindowValuesToFile(dlgSaveINI.FileName);
  end;
end;

procedure TMainForm.SaveModifiedFiles;
var
  i : integer;
  EdFrm : TEditorForm;
begin
  for i := 0 to EditorFormCount - 1 do
  begin
    EdFrm := TEditorForm(EditorForms[i]);
    if EdFrm.TheEditor.Modified then
    begin
      if EdFrm.IsNew then
      begin
        DoSaveAs(EdFrm);
      end
      else
        EdFrm.SaveFile;
    end;
  end;
end;

procedure TMainForm.mniViewClick(Sender: TObject);
var
  F : TEditorForm;
begin
  mniShowTemplates.Checked := ConstructForm.Visible;
  mniStatusbar.Checked := barStatus.Visible;
{$IFNDEF FPC}
  mniPBForthConsole.Checked := frmForthConsole.Visible;
{$ELSE}
  mniPBForthConsole.Visible := False;
{$ENDIF}
  if CodeForm.Visible then
    mniShowCodeListing.Caption := sHideCodeError
  else
    mniShowCodeListing.Caption := sShowCodeError;
  mniCodeExplorer.Checked := frmCodeExplorer.Visible;

  F := ActiveEditorForm;
  mniHideErrors.Enabled := (F <> nil) and F.TheErrors.Visible;
  mniProjectManager.Enabled := FileIsCPPOrPascalOrJava;
end;

procedure TMainForm.mniStatusbarClick(Sender: TObject);
begin
  mniStatusbar.Checked := not mniStatusbar.Checked;
  ShowStatusbar := mniStatusbar.Checked;
  barStatus.Visible := ShowStatusbar;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fGE);
  FreeAndNil(fGDE);
  FreeAndNil(fNQCAPIBase);
  FreeAndNil(fNXCAPIBase);
  if BrickComm.VerboseMode then
    Clipboard.AsText := BrickComm.LinkLog;
  BrickComm.OnOpenStateChanged := nil;
  MainForm := nil;
end;

procedure TMainForm.DoSaveAs(EdFrm: TEditorForm);
begin
  dlgSave.FileName := EdFrm.FileName;
  if dlgSave.Execute then
  begin
    EdFrm.SaveFileAs(dlgSave.FileName);
    AddRecentFile(dlgSave.FileName);
  end;
end;

procedure TMainForm.DoSave(EdFrm: TEditorForm);
begin
  if not Assigned(EdFrm) then Exit;
  if EdFrm.IsNew then
    DoSaveAs(EdFrm)
  else
    EdFrm.SaveFile;
end;

procedure TMainForm.DoPrint(EdFrm: TEditorForm);
begin
{$IFNDEF FPC}
  if dlgPrint.Execute then
  begin
    SynEditPrint.SynEdit := EdFrm.TheEditor;
    SynEditPrint.Title   := EdFrm.Caption;
    SynEditPrint.Print;
  end;
{$ENDIF}
end;

procedure TMainForm.DoPrintPreview(EdFrm: TEditorForm);
begin
  SynEditPrint.SynEdit := EdFrm.TheEditor;
  SynEditPrint.Title   := EdFrm.Caption;
  with TTestPrintPreviewDlg.Create(nil) do
  try
    SynEditPrintPreview.SynEditPrint := SynEditPrint;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // 9/13/2002 - JCH added code here to fix an Access Violation that would
  // occur if you closed the main window with an Editor window open.
  // 2009-06-24 - JCH editor windows are now closed in FormCloseQuery
  if Assigned(ConstructForm) then
    ConstructForm.SaveTemplateTree;
  SaveToolbars;
  MainWindowState := Integer(WindowState);
  WindowState := wsNormal;
end;

function TMainForm.CloseAllEditors : boolean;
var
  i : Integer;
begin
  Result := True;
  for i := EditorFormCount - 1 downto 0 do
  begin
    Result := CloseEditor(EditorForms[i], True);
    if not Result then
      break;
  end;
end;

procedure TMainForm.UpdateSynComponents;
var
  i : Integer;
  C : TComponent;
  TmpOptions : TSynCompletionOptions;
begin
  // load NQC syntax completion proposal component
  fNQCAPIBase.Clear;
  fNQCAPIBase.AddStrings(SynNQCSyn.Commands);
  fNQCAPIBase.AddStrings(SynNQCSyn.Constants);
  fNQCAPIBase.AddStrings(SynNQCSyn.Keywords);
  fNQCAPIBase.Sort;
  LoadNQCCompProp;
  // load NXC syntax completion proposal component
  fNXCAPIBase.Clear;
  fNXCAPIBase.AddStrings(SynNXCSyn.Commands);
  fNXCAPIBase.AddStrings(SynNXCSyn.Constants);
  fNXCAPIBase.AddStrings(SynNXCSyn.Keywords);
  fNXCAPIBase.Sort;
  SynNXCCompProp.ItemList := fNXCAPIBase;
  // configure code completion options for NQC, NBC, NXC, and RICScript
  if CCInsensitive then
    TmpOptions := [scoAnsiStrings, scoLimitToMatchedText, scoEndCharCompletion]
  else
    TmpOptions := [scoAnsiStrings, scoCaseSensitive, scoLimitToMatchedText, scoEndCharCompletion];
  SynNQCCompProp.Options := TmpOptions;
  SynNBCCompProp.Options := TmpOptions;
  SynNXCCompProp.Options := TmpOptions;
  SynRSCompProp.Options  := TmpOptions;
  SynAutoComp.AutoCompleteList.Assign(PrefForm.CodeTemplates);
  // also copy shortcut settings
  SynMacroRec.PlaybackShortCut := PlayMacroShortCut;
  SynMacroRec.RecordShortCut   := RecMacroShortCut;
  scpParams.ShortCut           := ParamCompShortCut;
  for i := 0 to ComponentCount - 1 do begin
    C := Components[i];
    if C = scpParams then Continue;
    if C is TSynCompletionProposal then begin
      TSynCompletionProposal(C).ShortCut := CodeCompShortCut;
    end;
  end;
  // also set font pref for exporters
  expHTML.Font.Name := FontName;
  expHTML.Font.Size := FontSize;
  expRTF.Font.Name  := FontName;
  expRTF.Font.Size  := FontSize;
end;

procedure TMainForm.SynMacroRecStateChange(Sender: TObject);
begin
  case SynMacroRec.State of
    msRecording :
      barStatus.Panels[1].Text := sRecording;
  else
    barStatus.Panels[1].Text := '';
  end;
end;

procedure TMainForm.mniViewToolWindowsClick(Sender: TObject);
var
  i : integer;
  F : TForm;
begin
  for i := 0 to Screen.FormCount - 1 do
  begin
    F := Screen.Forms[i];
    if F.Visible and (F <> Self) then
      F.BringToFront;
    if F.WindowState = wsMinimized then
      F.WindowState := wsNormal;
  end;
{
  for i := 0 to Application.ComponentCount - 1 do
  begin
    if Application.Components[i] is TForm then
    begin
      F := TForm(Application.Components[i]);
      if F.Visible and (F <> Self) and
         (F.BorderStyle in [bsSizeToolWin, bsToolWindow]) then
        F.BringToFront;
    end;
  end;
}
end;

function TMainForm.ActiveEditorForm: TEditorForm;
var
  i : Integer;
  F : TForm;
begin
  Result := nil;
{$IFNDEF FPC}
  if MDI then begin
    if Assigned(ActiveMDIChild) then
      Result := TEditorForm(ActiveMDIChild);
  end
  else begin
{$ENDIF}
    for i := 0 to Screen.FormCount - 1 do
    begin
      F := Screen.Forms[i];
      if F is TEditorForm then
      begin
        if Assigned(F.Parent) and (TTabSheet(F.Parent) = pagMain.ActivePage) then
        begin
          Result := TEditorForm(F);
          Break;
        end;
      end;
    end;
{$IFNDEF FPC}
  end;
{$ENDIF}
end;

function TMainForm.GetEditorFormCount: integer;
var
  i : Integer;
begin
{$IFNDEF FPC}
  if MDI then
    Result := MDIChildCount
  else
  begin
{$ENDIF}
    Result := 0;
    for i := 0 to Screen.FormCount - 1 do
      if Screen.Forms[i] is TEditorForm then
        Inc(Result);
{$IFNDEF FPC}
  end;
{$ENDIF}
end;

function TMainForm.GetEditorForm(index: integer): TEditorForm;
var
  i : Integer;
  F : TForm;
begin
  Result := nil;
{$IFNDEF FPC}
  if MDI then
    Result := TEditorForm(MDIChildren[index])
  else
  begin
{$ENDIF}
    for i := 0 to Screen.FormCount - 1 do
    begin
      F := Screen.Forms[i];
      if F is TEditorForm then
      begin
        if index = 0 then
        begin
          Result := TEditorForm(F);
          Break;
        end;
        Dec(index);
      end;
    end;
{$IFNDEF FPC}
  end;
{$ENDIF}
end;

function TMainForm.DoCreateEditorForm: TEditorForm;
var
  BorderAdjust : Integer;
  w, h : Integer;
  TS : TTabSheet;
begin
  Result := TEditorForm.Create(Self);
{$IFNDEF FPC}
  if MDI then
  begin
    if not (Result.IsMaximized) then
    begin
      BorderAdjust := Integer(GetWindowLong(Self.Handle, GWL_STYLE) and
        (WS_BORDER or WS_THICKFRAME) <> 0);

      w := Self.ClientWidth;
      if pnlCodeExplorer.Visible then
        w := w - pnlCodeExplorer.Width - GetSystemMetrics(SM_CXEDGE);
      if Self.VertScrollBar.IsScrollBarVisible then
        w := w - GetSystemMetrics(SM_CYVSCROLL);
      w := w - BorderAdjust - GetSystemMetrics(SM_CXEDGE)*2;
//      if ThemeServices.ThemesEnabled then
        dec(w);
      Result.Width := w - Result.Left;

      h := Self.ClientHeight - cbrTop.Height;
      if barStatus.Visible then
        h := h - barStatus.Height;
      if Self.HorzScrollBar.IsScrollBarVisible then
        h := h - GetSystemMetrics(SM_CXHSCROLL);
      h := h - BorderAdjust - GetSystemMetrics(SM_CYEDGE)*2;
//      if ThemeServices.ThemesEnabled then
        dec(h);
      Result.Height := h - Result.Top;
    end;
  end
  else
  begin
{$ENDIF}
    // parent form to new tabsheet...
    TS := TTabSheet.Create(Self);
    TS.Parent := pagMain;
    TS.PageControl := pagMain;
    Result.Parent := TS;
    Result.Align := alClient;
    pagMain.ActivePage := TS;
{$IFNDEF FPC}
  end;
{$ENDIF}
  Result.Visible := True;
end;

procedure TMainForm.HandleOpenStateChanged(Sender: TObject);
begin
  if Assigned(MainForm) then
  begin
    UpdateStatusBar;
  end;
end;

procedure TMainForm.ActivateEditorForm(index: Integer);
begin
  ActivateEditorForm(EditorForms[index]);
end;

procedure TMainForm.ActivateEditorForm(E : TEditorForm);
begin
  if not Assigned(E) then Exit;
  if E.WindowState = wsMinimized then
    E.WindowState := wsNormal;
  E.Show;
  E.BringToFront;
  SetWindowFocus(E);
  if Assigned(E.Parent) then
  begin
    pagMain.ActivePage := TTabSheet(E.Parent);
    pagMainChange(nil);
  end;
end;

procedure TMainForm.OpenFile(aPath: string; lineNo : integer);
var
  F : TEditorForm;
begin
  if not FileExists(aPath) then Exit;
  if not SwitchToFile(aPath, lineNo) then
  begin
    F := DoCreateEditorForm;
    if Assigned(F) then
    begin
      F.OpenFile(aPath, lineNo);
      AddRecentFile(aPath);
    end;
  end;
  if not MDI then
    pagMainChange(nil);
end;

procedure TMainForm.UpdateStatusBar;
begin
  if BrickComm.Port <> '' then
    barStatus.Panels[2].Text := BrickComm.NicePortName
  else
    barStatus.Panels[2].Text := sNoPort;

  barStatus.Panels[3].Text := BrickComm.BrickTypeName;
end;

procedure TMainForm.SaveDesktop(aFile : string);
var
  sDesktopPath : string;
begin
  if FileExists(aFile) then
  begin
    sDesktopPath := ChangeFileExt(aFile, K_DESKTOP_EXT);
    SaveWindowValuesToFile(sDesktopPath);
    SaveDesktopMiscToFile(sDesktopPath);
  end;
end;

procedure TMainForm.LoadDesktop(aFile: string);
var
  sDesktopPath : string;
begin
  sDesktopPath := ChangeFileExt(aFile, K_DESKTOP_EXT);
  if FileExists(sDesktopPath) then
  begin
    Application.ProcessMessages;
    LoadWindowValuesFromFile(sDesktopPath);
    LoadDesktopMiscFromFile(sDesktopPath);
    PostSearchSetup(False, False);
    ProgramBox.ItemIndex := CurrentProgramSlot;
    ConfigureOtherFirmwareOptions;
  end;
end;

procedure TMainForm.HandleOnCompilerStatusChange(Sender: TObject;
  const StatusMsg: string);
begin
  frmCompStatus.AddMessage(StatusMsg);
end;

procedure TMainForm.DoDisplayErrors(aShow : boolean);
var
  AEF : TEditorForm;
begin
  if aShow then
  begin
    AEF := ActiveEditorForm;
    if Assigned(AEF) then
      AEF.ShowTheErrors;
  end
  else
    Self.DoHideErrors;
end;

procedure TMainForm.mniCodeExplorerClick(Sender: TObject);
begin
  ShowCodeExplorer;
end;

procedure TMainForm.ShowCodeExplorer;
begin
  frmCodeExplorer.Show;
  pnlCodeExplorer.Visible := True;
  splCodeExplorer.Visible := True;
  frmCodeExplorer.FormShow(Self);
end;

procedure TMainForm.pnlCodeExplorerDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  Accept := (Source.Control is TfrmCodeExplorer) or
            (Source.Control is TConstructForm);
end;

procedure TMainForm.pnlCodeExplorerGetSiteInfo(Sender: TObject;
  DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint;
  var CanDock: Boolean);
begin
  CanDock := (DockClient is TfrmCodeExplorer) or (DockClient is TConstructForm);
end;

const
  K_COMP_TRANSFER_PREFIX = 'mniCompilerXfer';
  
procedure TMainForm.UpdateCompilerMenu;
var
  i : integer;
  MI : TOfficeMenuItem;
  TI : TTransferItem;
begin
  // remove all compile menu transfer menu items first
  for i := mniCompile.Count - 1 downto 0 do
  begin
    MI := TOfficeMenuItem(mniCompile.Items[i]);
    if Pos(K_COMP_TRANSFER_PREFIX, MI.Name) = 1 then
    begin
      MI.Free;
    end;
  end;
  mniCompSep.Visible := CompXferList.Count > 0;
  // now add new ones
  for i := 0 to CompXferList.Count - 1 do
  begin
    TI := TTransferItem(CompXferList[i]);
    MI := TOfficeMenuItem.Create(mniCompile);
    MI.Name := K_COMP_TRANSFER_PREFIX + IntToStr(i);
    MI.OnClick := HandleCompXferClick;
    MI.Caption := TI.Title;
    MI.Tag := i;
    mniCompile.Add(MI);
  end;
end;

const
  K_TRANSFER_PREFIX = 'mniTransfer';

procedure TMainForm.UpdateToolsMenu;
var
  i : integer;
  MI : TOfficeMenuItem;
  TI : TTransferItem;
begin
  // remove all transfer menu items first
  for i := mniTools.Count - 1 downto 0 do
  begin
    MI := TOfficeMenuItem(mniTools.Items[i]);
    if Pos(K_TRANSFER_PREFIX, MI.Name) = 1 then
    begin
      MI.Free;
    end;
  end;
  // now add new ones
  for i := 0 to TransferList.Count - 1 do
  begin
    TI := TTransferItem(TransferList[i]);
    MI := TOfficeMenuItem.Create(mniTools);
    MI.Name := K_TRANSFER_PREFIX + IntToStr(i);
    MI.OnClick := HandleTransferClick;
    MI.Caption := TI.Title;
    MI.Tag := i;
    mniTools.Add(MI);
  end;
end;

procedure TMainForm.HandleCompXferClick(Sender: TObject);
var
  i : integer;
  TI : TTransferItem;
begin
  if Sender is TOfficeMenuItem then
  begin
    i := TOfficeMenuItem(Sender).Tag;
    if (i >= 0) and (i < CompXferList.Count) then
    begin
      TI := CompXferList[i];
      ExecuteTransferItem(TI);
    end;
  end;
end;

procedure TMainForm.HandleTransferClick(Sender: TObject);
var
  i : integer;
  TI : TTransferItem;
begin
  if Sender is TOfficeMenuItem then
  begin
    i := TOfficeMenuItem(Sender).Tag;
    if (i >= 0) and (i < TransferList.Count) then
    begin
      TI := TransferList[i];
      ExecuteTransferItem(TI);
    end;
  end;
end;

procedure TMainForm.ExecuteTransferItem(TI : TTransferItem);
var
  paramStr : string;
  BadParam : Boolean;
  F : TEditorForm;
begin
  F := ActiveEditorForm;
  if not TI.Restrict or
    (Assigned(F) and
     (LowerCase(TI.Extension) = LowerCase(ExtractFileExt(F.Filename)))) then
  begin
    try
      BadParam := False;
      paramStr := ProcessParams(TI.Params);
    except
      // silently eat the exception
      BadParam := True;
    end;
    if not BadParam then
    begin
      if TI.Close then BrickComm.Close;
      try
{$IFNDEF FPC}
        if TI.Wait then
          ExecuteAndWait(PChar('"' + TI.Path + '" ' + paramStr), SW_SHOWNORMAL, LocalCompilerTimeout, PChar(TI.WorkingDir))
        else
          ExecuteAndContinue(PChar(TI.Path), PChar('"' + TI.Path + '" ' + paramStr), PChar(TI.WorkingDir), SW_SHOWNORMAL);
{$ENDIF}
      finally
        if TI.Close then BrickComm.Open;
      end;
    end;
  end;
end;

function TMainForm.ProcessParams(aParams : string) : string;
var
  sTmp, sArg : string;
  F : TEditorForm;
  cPos, oPos, dPos : Integer;
  bFoundMacro : Boolean;
begin
  F := ActiveEditorForm;
  Result := aParams;
  if Pos(TransferMacros[M_SAVEALL], Result) > 0 then // $SAVEALL
  begin
    Result := StringReplace(Result, TransferMacros[M_SAVEALL], '', [rfReplaceAll]);
    // save all modified editors
    SaveModifiedFiles;
  end;
  if Pos(TransferMacros[M_SAVE], Result) > 0 then // $SAVE
  begin
    Result := StringReplace(Result, TransferMacros[M_SAVE], '', [rfReplaceAll]);
    // save current editor
    if F.TheEditor.Modified or F.IsNew then
      DoSave(F);
  end;
  if Pos(TransferMacros[M_COL], Result) > 0 then // $COL
  begin
    sTmp := '';
    if Assigned(F) then
      sTmp := IntToStr(F.TheEditor.CaretX);
    Result := StringReplace(Result, TransferMacros[M_COL], sTmp, [rfReplaceAll]);
  end;
  if Pos(TransferMacros[M_ROW], Result) > 0 then // $ROW
  begin
    sTmp := '';
    if Assigned(F) then
      sTmp := IntToStr(F.TheEditor.CaretY);
    Result := StringReplace(Result, TransferMacros[M_ROW], sTmp, [rfReplaceAll]);
  end;
  if Pos(TransferMacros[M_CURTOKEN], Result) > 0 then // $CURTOKEN
  begin
    sTmp := '';
    if Assigned(F) then
      sTmp := F.TheEditor.WordAtCursor;
    Result := StringReplace(Result, TransferMacros[M_CURTOKEN], sTmp, [rfReplaceAll]);
  end;
  if Pos(TransferMacros[M_EDNAME], Result) > 0 then // $EDNAME
  begin
    sTmp := '';
    if Assigned(F) then
      sTmp := F.FileName;
    Result := StringReplace(Result, TransferMacros[M_EDNAME], sTmp, [rfReplaceAll]);
  end;
  if Pos(TransferMacros[M_PORT], Result) > 0 then // $PORT
  begin
//    sTmp := LocalPort;
    sTmp := BrickComm.FullPortName;
    Result := StringReplace(Result, TransferMacros[M_PORT], sTmp, [rfReplaceAll]);
  end;
  if Pos(TransferMacros[M_TARGET], Result) > 0 then // $TARGET
  begin
    sTmp := GetTarget;
    Result := StringReplace(Result, TransferMacros[M_TARGET], sTmp, [rfReplaceAll]);
  end;
  // process macros that take arguments
  repeat
    bFoundMacro := False;
    cPos := Pos(')', Result);
    if cPos > 0 then
    begin
      sTmp := Copy(Result, 1, cPos-1);
      oPos := LastDelimiter('(', sTmp);
      if oPos > 0 then
      begin
        sTmp := Copy(sTmp, 1, oPos-1);
        dPos := LastDelimiter('$', sTmp);
        if dPos > 0 then
        begin
          // check for Macro
          sTmp := Copy(sTmp, dPos, oPos-dPos) + '()';
          sArg := Copy(Result, oPos+1, cPos-oPos-1); // argument
          if sTmp = TransferMacros[M_PATH] then // $PATH()
          begin
            bFoundMacro := True;
            sTmp := ExtractFilePath(sArg);
          end
          else if sTmp = TransferMacros[M_NAME] then // $NAME()
          begin
            bFoundMacro := True;
            sTmp := ExtractFileName(sArg);
          end
          else if sTmp = TransferMacros[M_NAMEONLY] then // $NAMEONLY()
          begin
            bFoundMacro := True;
            sTmp := ChangeFileExt(ExtractFileName(sArg), '');
          end
          else if sTmp = TransferMacros[M_EXT] then // $EXT()
          begin
            bFoundMacro := True;
            sTmp := ExtractFileExt(sArg);
          end
          else if sTmp = TransferMacros[M_PROMPT] then // $PROMPT()
          begin
            bFoundMacro := True;
            sTmp := sArg;
            if not InputQuery(sEnterData, sEnterRunParams, sTmp) then
              Abort;
          end;
          if bFoundMacro then
            Result := Copy(Result, 1, dPos-1) + sTmp + Copy(Result, cPos+1, Length(Result));
        end;
      end;
    end;
  until not bFoundMacro;
end;

procedure TMainForm.ChangeActiveEditor;
var
  F : TEditorForm;
begin
  F := ActiveEditorForm;
  if fOldActiveEditorForm <> F then
  begin
    frmMacroManager.MacroLibrary.ActiveEditor := nil;
    if Assigned(F) then begin
      frmMacroManager.MacroLibrary.ActiveEditor := F.TheEditor;
      // hook up the correct popup menu
      if ShowTemplatePopup then
        F.TheEditor.PopupMenu := ConstructForm.ConstructMenu
      else
        F.TheEditor.PopupMenu := F.pmnuEditor;
    end;
    ConstructForm.ActiveLanguageIndex := ActiveLanguageIndex;
    ConstructForm.Rebuild;
    // always close the project manager if it was open
    if frmProjectManager.Visible then
      frmProjectManager.Close;
    fOldActiveEditorForm := F;
  end;
end;

procedure TMainForm.mniMacroManagerClick(Sender: TObject);
begin
  frmMacroManager.ShowModal;
end;

procedure TMainForm.DoSaveAll;
var
  i : integer;
begin
  for i := 0 to EditorFormCount - 1 do
  begin
    DoSave(EditorForms[i]);
  end;
end;

procedure TMainForm.DoToolbarExecute(act : TCustomAction; bar : TOfficeGradientPanel);
var
  bVis : Boolean;
begin
  act.Checked := not act.Checked;
  bVis := act.Checked;
  if bar.Floating then
    bar.HostDockSite.Visible := bVis
  else
    bar.Visible := bVis;
end;

procedure TMainForm.actFileToolbarExecute(Sender: TObject);
begin
  DoToolbarExecute(actFileToolbar, ogpFile);
end;

procedure TMainForm.actSearchToolbarExecute(Sender: TObject);
begin
  DoToolbarExecute(actSearchToolbar, ogpSearch);
end;

procedure TMainForm.actCompileToolbarExecute(Sender: TObject);
begin
  DoToolbarExecute(actCompileToolbar, ogpCompile);
end;

procedure TMainForm.actHelpToolbarExecute(Sender: TObject);
begin
  DoToolbarExecute(actHelpToolbar, ogpHelp);
end;

procedure TMainForm.actEditToolbarExecute(Sender: TObject);
begin
  DoToolbarExecute(actEditToolbar, ogpEdit);
end;

procedure TMainForm.actToolsToolbarExecute(Sender: TObject);
begin
  DoToolbarExecute(actToolsToolbar, ogpTools);
end;

procedure TMainForm.alMainUpdate(Action: TBasicAction; var Handled: Boolean);
var
  E : TEditorForm;
  bAssigned, bBrickAlive, bBALSF, bROPS : Boolean;
  procedure UpdateBars(act : TCustomAction; bar : TControl);
  begin
    if bar.Floating then
      act.Checked := bar.HostDockSite.Visible
    else
      act.Checked := bar.Visible;
  end;
begin
  UpdateBars(actFileToolbar, ogpFile);
  UpdateBars(actCompileToolbar, ogpCompile);
  UpdateBars(actSearchToolbar, ogpSearch);
  UpdateBars(actHelpToolbar, ogpHelp);
  UpdateBars(actEditToolbar, ogpEdit);
  UpdateBars(actToolsToolbar, ogpTools);

  // update all other actions here as well
  E           := ActiveEditorForm;
  bAssigned   := Assigned(E);
  bBrickAlive := BrickComm.IsOpen;
  bBALSF      := bBrickAlive and LocalStandardFirmware;
  bROPS       := FileIsROPS;

  actFileSave.Enabled           := bAssigned and E.TheEditor.Modified;
  actFileSaveAs.Enabled         := bAssigned;
  actFileSaveAll.Enabled        := bAssigned;
  actFileClose.Enabled          := bAssigned;
  actFileCloseAll.Enabled       := bAssigned;
  actFileInsertFile.Enabled     := bAssigned and not E.TheEditor.ReadOnly;
  actFilePrintPreview.Enabled   := bAssigned;
  actFilePrint.Enabled          := bAssigned;

  actEditUndo.Enabled           := bAssigned and E.CanUndo;
  actEditRedo.Enabled           := bAssigned and E.CanRedo;
  actEditCut.Enabled            := bAssigned and E.CanCut;
  actEditCopy.Enabled           := bAssigned and E.Selected;
  actEditPaste.Enabled          := bAssigned and E.CanPaste;
  actEditDelete.Enabled         := actEditCut.Enabled;
  actEditSelectAll.Enabled      := bAssigned;
  actEditNextField.Enabled      := bAssigned;
  actEditCopyHTML.Enabled       := bAssigned;
  actEditCopyRTF.Enabled        := bAssigned;

  actSearchFind.Enabled         := bAssigned and E.CanFind;
  actSearchFindNext.Enabled     := bAssigned and E.CanFindNext;
  actSearchFindPrev.Enabled     := bAssigned and E.CanFindNext;
  actSearchReplace.Enabled      := bAssigned and E.CanReplace;
  actSearchGotoLine.Enabled     := bAssigned;
  actSearchProcList.Enabled     := bAssigned;
  actSearchGrepSearch.Enabled   := true;
  actSearchGrepResults.Enabled  := true;

  actCompileCompile.Enabled     := bAssigned and FileCanBeCompiled;
  actCompileDownload.Enabled    := bAssigned and ((bBrickAlive or FileIsForth) and not bROPS);
  actCompileDownloadRun.Enabled := bAssigned and bBrickAlive and not bROPS;
  actCompileRun.Enabled         := bBALSF or bROPS;
  actCompileStop.Enabled        := bBALSF or bROPS;
  // ROPS/Enhanced NXT firmware support
  actCompileStepOver.Visible    := bROPS or (bBALSF and IsNXT and EnhancedFirmware);
  actCompileStepOver.Enabled    := bROPS or (bBALSF and (fNXTVMState <> kNXT_VMState_Idle));
  actCompileTraceInto.Visible   := bROPS or (bBALSF and IsNXT and EnhancedFirmware);
  actCompileTraceInto.Enabled   := bROPS or (bBALSF and (fNXTVMState <> kNXT_VMState_Idle));

  // NXT enhanced firmware support
//  actCompileSingleStep.Visible  := bBALSF and IsNXT and EnhancedFirmware;
//  actCompileSingleStep.Enabled  := bBALSF and (fNXTVMState <> kNXT_VMState_Idle);
  actCompilePause.Visible       := bBALSF and IsNXT and EnhancedFirmware;
  actCompilePause.Enabled       := bBALSF and (fNXTVMState <> kNXT_VMState_Idle);
  actCompileStepOut.Visible     := bBALSF and IsNXT and EnhancedFirmware;
  actCompileStepOut.Enabled     := bBALSF and (fNXTVMState <> kNXT_VMState_Idle);
  actCompileRunToCursor.Visible := bBALSF and IsNXT and EnhancedFirmware;
  actCompileRunToCursor.Enabled := bBALSF and (fNXTVMState <> kNXT_VMState_Idle);
  actCompileTraceToLine.Visible := bBALSF and IsNXT and EnhancedFirmware;
  actCompileTraceToLine.Enabled := bBALSF and (fNXTVMState <> kNXT_VMState_Idle);

  actToolsDirect.Checked        := DirectForm.Visible;
  actToolsDiag.Checked          := DiagForm.Visible;
  actToolsWatch.Checked         := WatchForm.Visible;
  actToolsPiano.Checked         := PianoForm.Visible;
  actToolsJoystick.Checked      := JoystickForm.Visible;
  actToolsRemote.Checked        := RemoteForm.Visible;
  actToolsSendMsg.Checked       := MessageForm.Visible;
  actToolsDatalog.Checked       := DatalogForm.Visible;
  actToolsMemory.Checked        := MemoryForm.Visible;
  actToolsNewWatch.Checked      := frmNewWatch.Visible;
  actToolsSetValues.Checked     := frmSetValues.Visible;
  actToolsSpybotEEPROM.Checked  := frmSpybotEEPROM.Visible;
  actToolsNXTExplorer.Checked   := frmNXTExplorer.Visible;
  actToolsSyncMotors.Checked    := frmNXTController.Visible;

  actToolsDirect.Enabled         := bBALSF;
  actToolsDiag.Enabled           := bBALSF;
  actToolsWatch.Enabled          := bBALSF;
  actToolsPiano.Enabled          := bBALSF;
  actToolsJoystick.Enabled       := bBALSF;
  actToolsRemote.Enabled         := bBALSF and (IsRCX or IsScout or IsNXT);
  actToolsSendMsg.Enabled        := bBALSF and (IsRCX or IsScout or IsNXT);
  actToolsDatalog.Enabled        := bBALSF and IsRCX;
  actToolsMemory.Enabled         := bBALSF;
  actToolsClearMem.Enabled       := bBALSF and not IsSpybotic;
  actToolsNewWatch.Enabled       := bBALSF and (IsRCX2 or IsSpybotic or IsNXT);
  actToolsSetValues.Enabled      := bBALSF and (IsRCX2 or IsSpybotic);
  actToolsSpybotEEPROM.Enabled   := bBALSF and IsSpybotic;
  actToolsNXTExplorer.Enabled    := bBALSF and IsNXT;
  actToolsNXTScreen.Enabled      := bBALSF and IsNXT;
  actToolsSyncMotors.Enabled     := bBALSF and IsNXT;
  actToolsFindBrick.Enabled      := not bBrickAlive;
  actToolsTurnBrickOff.Enabled   := bBALSF;
  actToolsCloseComm.Enabled      := bBrickAlive;
  actToolsFirmware.Enabled       := {bBrickAlive and }(IsRCX or IsNXT);
  actToolsUnlockFirm.Enabled     := bBALSF and IsRCX;

  mniProgramNumber.Enabled       := bBrickAlive and IsRCX;
  ProgramBox.Enabled             := bBrickAlive and IsRCX;
  mniBrickOS.Visible             := LocalFirmwareType = ftBrickOS;
  mniSetLNPAddress.Enabled       := mniBrickOS.Visible and bBrickAlive;
//  mniDownloadAddress.Enabled     := mniBrickOS.Visible and bBrickAlive;
//  mniLNPPort.Enabled             := mniBrickOS.Visible and bBrickAlive;
end;

{$IFNDEF FPC}
procedure TMainForm.WMClose(var Message: TWMClose);
begin
  AppIsClosing := True;
  inherited;
end;
{$ENDIF}

procedure TMainForm.mniWindowListClick(Sender: TObject);
begin
  with TfrmWindowList.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

function TMainForm.IsStandardFirmware(aFile: string): Boolean;
begin
  Result := UpperCase(ExtractFileExt(aFile)) = '.LGO';
end;

procedure TMainForm.mniPBForthConsoleClick(Sender: TObject);
begin
{$IFNDEF FPC}
  frmForthConsole.Show;
{$ENDIF}
end;

function TMainForm.SwitchToFile(fname: string; lineNo : integer): Boolean;
var
  i : Integer;
  EdFrm : TEditorForm;
begin
  Result := False;
  // is the file already open and unmodified?
  for i := 0 to EditorFormCount - 1 do
  begin
    EdFrm := TEditorForm(EditorForms[i]);
    if (EdFrm.Filename = fname) and not EdFrm.TheEditor.Modified then
    begin
      Result := True;
      ActivateEditorForm(i);
      EdFrm.SelectLine(lineNo);
      Break;
    end;
  end;
end;

procedure TMainForm.mniProjectManagerClick(Sender: TObject);
var
  F : TEditorForm;
begin
  F := ActiveEditorForm;
  if not FileIsCPPOrPascalOrJava then Exit;
  if Assigned(F) then
    frmProjectManager.ShowProjectManager(F.Filename);
end;

procedure TMainForm.scpParamsExecute(Kind: SynCompletionType; Sender: TObject;
  var CurrentInput: String; var x, y: Integer; var CanExecute: Boolean);
var
  locLine, lookup: String;
  TmpX, savepos, StartX, ParenCounter, NameIdx, TmpLocation : Integer;
  FoundMatch : Boolean;
  p, BB, BE : TPoint;
  SCP : TSynCompletionProposal;
  AEH : TSynCustomHighlighter;
begin
  AEH := GetActiveEditorHighlighter;
  NameIdx := -1;
  SCP := TSynCompletionProposal(Sender);
  with TBricxccSynEdit(SCP.Editor) do
  begin
    // get text all the way back to semi-colon from current location
    p := FindString(';', True, True);
    BB := BlockBegin;
    BE := BlockEnd;
    try
      BlockBegin := p;
      BlockEnd   := CaretXY;
      locline := SelText;
    finally
      BlockBegin := BB;
      BlockEnd := BE;
    end;

    //go back from the cursor and find the first open paren
    TmpX := Length(locLine);
    FoundMatch := False;
    TmpLocation := 0;
    while (TmpX > 0) and not(FoundMatch) do
    begin
      if locLine[TmpX] = ',' then
      begin
        inc(TmpLocation);
        dec(TmpX);
      end else if locLine[TmpX] = ')' then
      begin
        //We found a close, go till it's opening paren
        ParenCounter := 1;
        dec(TmpX);
        while (TmpX > 0) and (ParenCounter > 0) do
        begin
          if locLine[TmpX] = ')' then inc(ParenCounter)
          else if locLine[TmpX] = '(' then dec(ParenCounter);
          dec(TmpX);
        end;
        if TmpX > 0 then dec(TmpX);  //eat the open paren
      end else if locLine[TmpX] = '(' then
      begin
        //we have a valid open paren, lets see what the word before it is
        StartX := TmpX;
        while (TmpX > 0) and not(locLine[TmpX] in TSynValidStringChars) do
          Dec(TmpX);
        if TmpX > 0 then
        begin
          SavePos := TmpX;
          while (TmpX > 0) and (locLine[TmpX] in TSynValidStringChars) do
            dec(TmpX);
          inc(TmpX);
          if FileIsMindScriptOrLASM(AEH) or FileIsPascal(AEH) then
            lookup := Uppercase(Copy(locLine, TmpX, SavePos - TmpX + 1))
          else
            lookup := Copy(locLine, TmpX, SavePos - TmpX + 1);
          if FileIsCPP(AEH) then
            NameIdx := CppCodeCompIndex(lookup)
          else if FileIsPascal(AEH) then
            NameIdx := PasCodeCompIndex(lookup)
          else if FileIsNQC(AEH) then
            NameIdx := NQCCodeCompIndex(lookup)
          else if FileIsNXC(AEH) then
            NameIdx := NXCCodeCompIndex(lookup)
          else if FileIsNBC(AEH) then
            NameIdx := NBCCodeCompIndex(lookup)
          else if FileIsRICScript(AEH) then
            NameIdx := RICScriptCodeCompIndex(lookup)
          else if FileIsROPS(AEH) then
            NameIdx := ROPSCodeCompIndex(lookup)
          else if FileIsMindScript(AEH) then
            NameIdx := MSCodeCompIndex(lookup);
          FoundMatch := NameIdx > -1;
          if not(FoundMatch) then
          begin
            TmpX := StartX;
            dec(TmpX);
          end;
        end;
      end else dec(TmpX)
    end;
  end;

  CanExecute := FoundMatch;

  if CanExecute then
  begin
    SCP.Form.CurrentIndex := TmpLocation;
    if lookup <> SCP.CurrentString then
    begin
      SCP.ItemList.Clear;
      // add params
      if FileIsCPP(AEH) then begin
        AddCppCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := ', ';
      end
      else if FileIsPascal(AEH) then begin
        AddPasCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := '; ';
      end
      else if FileIsNQC(AEH) then begin
        AddNQCCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := ', ';
      end
      else if FileIsNXC(AEH) then begin
        AddNXCCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := ', ';
      end
      else if FileIsNBC(AEH) then begin
        AddNBCCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := ', ';
      end
      else if FileIsRICScript(AEH) then begin
        AddRICScriptCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := ', ';
      end
      else if FileIsROPS(AEH) then begin
        AddROPSCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := '; ';
      end
      else if FileIsMindScript(AEH) then begin
        AddMSCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := ', ';
      end;
    end;
  end
  else
    SCP.ItemList.Clear;
end;

procedure TMainForm.SynMindScriptCompPropExecute(Kind: SynCompletionType;
  Sender: TObject; var CurrentInput: String; var x, y: Integer;
  var CanExecute: Boolean);
var
  E : TCustomSynEdit;
  CP : TSynCompletionProposal;
  S : string;
  BB, BE : TPoint;
  SL : TStringList;
begin
  // find out if character to left of cursor is a period before doing anything else
  CP := TSynCompletionProposal(Sender);
  E := CP.Editor;

  BB := E.BlockBegin;
  BE := E.BlockEnd;
  try
    E.BlockBegin := Point(E.CaretX-1, E.CaretY);
    E.BlockEnd   := E.CaretXY;
    S := E.SelText;
  finally
    E.BlockBegin := BB;
    E.BlockEnd := BE;
  end;
  if S <> '.' then
    S := E.GetWordAtRowCol(E.PrevWordPos);
  SL := TStringList.Create;
  try
    PopulateMindscriptWordList(S, SL);
    CP.ItemList := SL;
  finally
    SL.Free;
  end;
end;

procedure TMainForm.ConfigureOtherFirmwareOptions;
var
  i : Integer;
  bBrickOS : Boolean;
begin
  bBrickOS := LocalFirmwareType = ftBrickOS;
  if LocalStandardFirmware then begin
    with ProgramBox.Items do begin
      i := IndexOf(sProgram + ' 6');
      if i <> -1 then Delete(i);
      i := IndexOf(sProgram + ' 7');
      if i <> -1 then Delete(i);
      i := IndexOf(sProgram + ' 8');
      if i <> -1 then Delete(i);
    end;
  end
  else if bBrickOS then begin
    // brickOS has 8 program slots
    with ProgramBox.Items do begin
      if IndexOf(sProgram + ' 6') = -1 then Add(sProgram + ' 6');
      if IndexOf(sProgram + ' 7') = -1 then Add(sProgram + ' 7');
      if IndexOf(sProgram + ' 8') = -1 then Add(sProgram + ' 8');
    end;
  end;
  mniProgram6.Visible := bBrickOS;
  mniProgram7.Visible := bBrickOS;
  mniProgram8.Visible := bBrickOS;
  mniPBForthConsole.Visible := False;
  mniPBForthConsole.Enabled := False;
  dlgOpenFirmware.FilterIndex := 2;
  if bBrickOS then
  begin
    dlgOpenFirmware.FileName := 'brickOS.srec';
    dlgOpen.FilterIndex      := Highlighters.IndexOf('C++')+1;
    dlgSave.FilterIndex      := dlgOpen.FilterIndex;
  end
  else if LocalFirmwareType = ftPBForth then
  begin
    mniPBForthConsole.Visible := True;
    mniPBForthConsole.Enabled := True;
    dlgOpenFirmware.FileName  := 'pbForth.srec';
    dlgOpen.FilterIndex       := Highlighters.IndexOf('Forth')+1;
    dlgSave.FilterIndex       := dlgOpen.FilterIndex;
  end
  else if LocalFirmwareType = ftLeJOS then
  begin
    dlgOpenFirmware.FileName := 'lejos.srec';
    dlgOpen.FilterIndex      := Highlighters.IndexOf('Java')+1;
    dlgSave.FilterIndex      := dlgOpen.FilterIndex;
  end
  else
  begin
    if LocalBrickType = SU_NXT then
    begin
      dlgOpenFirmware.FileName    := '';
      dlgOpenFirmware.FilterIndex := 3;
    end
    else
    begin
      dlgOpenFirmware.FileName    := 'firm0328.lgo';
      dlgOpenFirmware.FilterIndex := 1;
    end;
    SetFilterIndexFromLanguage;
  end;
end;

function TMainForm.DoCompileAction(bDown, bRun: Boolean) : Boolean;
var
  SaveCursor : TCursor;
  E : TEditorForm;
begin
  Result := False;
  E := ActiveEditorForm;
  if Assigned(E) then begin
    if bDown then begin
      if not CheckAlive then Exit;
      if IsRCX then
      begin
        if LockedProgArray[ProgramBox.ItemIndex] then
        begin
          MessageDlg(sProgramLocked, mtError, [mbOK], 0);
          Exit;
        end;
        SelectProgram(ProgramBox.ItemIndex);
      end;
    end;
    if ShowCompilerStatus and UseInternalNBC and
       FileIsNBCOrNXCOrNPGOrRICScript then
      frmCompStatus.Show;
    Application.ProcessMessages;

    {Save cursor}
    SaveCursor := Screen.Cursor;
    Screen.Cursor := crHourglass;
    try
      // check for auto save
      if AutoSaveFiles then
        SaveModifiedFiles;
      if AutoSaveDesktop then
        SaveDesktop(E.Filename);

      Result := CompileIt(DoDisplayErrors, E.TheEditor.Lines, E.TheErrors,
        E.Filename, E.Caption, bDown, bRun, HandleOnCompilerStatusChange,
        HandleOpenStateChanged);
    finally
      Screen.Cursor := SaveCursor;
    end;
  end;
end;

procedure TMainForm.UpdateProgramSlotMenuItems(index: Integer);
begin
  case index of
    0: mniProgram1.Checked := true;
    1: mniProgram2.Checked := true;
    2: mniProgram3.Checked := true;
    3: mniProgram4.Checked := true;
    4: mniProgram5.Checked := true;
    5: mniProgram6.Checked := true;
    6: mniProgram7.Checked := true;
    7: mniProgram8.Checked := true;
  end;
  CurrentProgramSlot := index;
end;

procedure TMainForm.actFileNewExecute(Sender: TObject);
var
  F : TEditorForm;
begin
  newcount := newcount + 1;
  F := DoCreateEditorForm;
  if Assigned(F) then
    F.NewFile(sUntitled + IntToStr(newcount));
  if not MDI then
    pagMainChange(nil);
end;

procedure TMainForm.actFileOpenExecute(Sender: TObject);
var
  i : integer;
begin
  if dlgOpen.Execute then
  begin
    for i := 0 to dlgOpen.Files.Count - 1 do
      OpenFile(dlgOpen.Files[i]);
  end;
end;

procedure TMainForm.actCompileCompileExecute(Sender: TObject);
begin
  DoCompileAction(False, False);
end;

procedure TMainForm.actCompileDownloadExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  // download using forth console
  E := ActiveEditorForm;
  if FileIsForth then
  begin
{$IFNDEF FPC}
    if Assigned(E) then
      frmForthConsole.DownloadScript(E.TheEditor.Lines);
{$ENDIF}
  end
  else
    DoCompileAction(True, False);
end;

procedure TMainForm.actCompileDownloadRunExecute(Sender: TObject);
begin
  if DoCompileAction(True, True) then
    StartTask(0);
end;

procedure TMainForm.actCompileRunExecute(Sender: TObject);
begin
  if IsRCX then
  begin
    SelectProgram(ProgramBox.ItemIndex);
  end;
  StartTask(0);
end;

procedure TMainForm.actCompileStopExecute(Sender: TObject);
begin
  if FileIsROPS then begin
    if ce.Exec.Status = isRunning then
      ce.Stop;
  end
  else if IsNXT then
  begin
    if CurrentProgram.ProgramReset(EnhancedFirmware) then
      actCompilePause.Caption := sBreakAll;
  end
  else
  begin
    BrickComm.StopAllTasks;
    BrickComm.MotorsOff(7); // 7 == 111 binary == all 3 motors
  end;
end;

procedure TMainForm.actCompileStepOverExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) and FileIsROPS then
  begin
    if ce.Exec.Status = isRunning then
      ce.StepOver
    else
    begin
      if DoCompileAction(False, False) then
      begin
        ce.StepInto;
        ce.Execute;
      end;
    end;
  end
  else if IsNXT and EnhancedFirmware then
  begin
    if CurrentProgram.StepOver then
    begin
      actCompilePause.Caption := sContinue;
      UpdateEditorPosition;
    end;
  end;
end;

procedure TMainForm.actCompileTraceIntoExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) and FileIsROPS then
  begin
    if ce.Exec.Status = isRunning then
      ce.StepInto
    else
    begin
      if DoCompileAction(False, False) then
      begin
        ce.StepInto;
        ce.Execute;
      end;
    end;
  end
  else if IsNXT and EnhancedFirmware then
  begin
    if CurrentProgram.TraceInto then
    begin
      actCompilePause.Caption := sContinue;
      UpdateEditorPosition;
    end;
  end;
end;

procedure TMainForm.actCompileStepOutExecute(Sender: TObject);
begin
  if IsNXT and EnhancedFirmware then
  begin
    if CurrentProgram.RunUntilReturn then
    begin
      actCompilePause.Caption := sContinue;
      UpdateEditorPosition;
    end;
  end;
end;

procedure TMainForm.actCompileTraceToLineExecute(Sender: TObject);
var
  nextLine : integer;
  E : TEditorForm;
begin
  if IsNXT and EnhancedFirmware then
  begin
    E := ActiveEditorForm;
    if Assigned(E) then
    begin
      // figure out the next source line using CurrentProgram???
      nextLine := 10;
      if CurrentProgram.TraceToNextSourceLine(nextLine) then
      begin
        actCompilePause.Caption := sContinue;
        UpdateEditorPosition;
      end;
    end;
  end;
end;

procedure TMainForm.actCompileRunToCursorExecute(Sender: TObject);
var
  cursorLine : integer;
  E : TEditorForm;
begin
  if IsNXT and EnhancedFirmware then
  begin
    E := ActiveEditorForm;
    if Assigned(E) then
    begin
      cursorLine := E.TheEditor.CaretY;
      if CurrentProgram.RunToCursor(cursorLine) then
      begin
        actCompilePause.Caption := sContinue;
        UpdateEditorPosition;
      end;
    end;
  end;
end;

procedure TMainForm.actEditUndoExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.Undo;
end;

procedure TMainForm.actEditRedoExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.Redo;
end;

procedure TMainForm.actEditCutExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.CutSel;
end;

procedure TMainForm.actEditCopyExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.CopySel;
end;

procedure TMainForm.actEditPasteExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.Paste;
end;

procedure TMainForm.actEditDeleteExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.DeleteSel;
end;

procedure TMainForm.actEditSelectAllExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.SelectAll;
end;

procedure TMainForm.actEditNextFieldExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.NextField;
end;

procedure TMainForm.actEditPreferencesExecute(Sender: TObject);
var
  i : integer;
  F : TEditorForm;
  oldShowTempPopup : boolean;
begin
  oldShowTempPopup := ShowTemplatePopup;
  if PrefForm.ShowModal = mrOK then
  begin
    // fill locked program array
    FillLockedProgramArray;
    // make sure our Fake Spirit has the correct RCXType and COMPort
    SetupSpirit;
    // process the rest of the preference changes
    ConstructForm.Visible := ShowTemplateForm;
    ConstructForm.ConstructMenu.AutoPopup := ShowTemplatePopup;

    F := ActiveEditorForm;
    for i:=0 to EditorFormCount-1 do
    begin
      if EditorForms[i] = F then continue;
      EditorForms[i].SetValuesFromPreferences;
    end;
    if F <> nil then
    begin
      F.SetValuesFromPreferences;
      F.UpdatePositionOnStatusBar;
    end;

    if ColorCodingChanged then
    begin
      for i:=0 to EditorFormCount-1 do
      begin
        if EditorForms[i] = F then continue;
        TEditorForm(EditorForms[i]).SetSyntaxHighlighter;
      end;
      if F <> nil then
        F.SetSyntaxHighlighter;
    end;

    if TemplatesChanged or (ShowTemplatePopup <> oldShowTempPopup) then
    begin
      // if the templates have changed save state, rebuild tree, restore state
      ConstructForm.ActiveLanguageIndex := ActiveLanguageIndex;
      ConstructForm.Rebuild;
    end;

    // copy over Code Templates
    UpdateSynComponents;

    // update dragmode on toolbars
    SetToolbarDragging(not LockToolbars);

{$IFNDEF FPC}
    // update forth console settings
    frmForthConsole.UpdateSettings;
{$ENDIF}

    // set filter index
    SetFilterIndexFromLanguage;
  end;
end;

procedure TMainForm.actFileSaveExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    DoSave(E);
end;

procedure TMainForm.actFileSaveAsExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    DoSaveAs(E);
end;

procedure TMainForm.actFileSaveAllExecute(Sender: TObject);
begin
  DoSaveAll;
end;

procedure TMainForm.actFileCloseExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    CloseEditor(E);
end;

procedure TMainForm.actFileCloseAllExecute(Sender: TObject);
begin
  CloseAllEditors;
end;

procedure TMainForm.actFileInsertFileExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then begin
    if E.TheEditor.ReadOnly then Exit;
    if dlgInsertFile.Execute then
      E.InsertFile(dlgInsertFile.FileName);
  end;
end;

procedure TMainForm.actFilePageSetupExecute(Sender: TObject);
begin
{$IFNDEF FPC}
  with TPageSetupDlg.Create(nil) do
  try
    SetValues(SynEditPrint);
    if ShowModal = mrOK then
      GetValues(SynEditPrint);
  finally
    Free;
  end;
{$ENDIF}
end;

procedure TMainForm.actFilePrinterSetupExecute(Sender: TObject);
begin
{$IFNDEF FPC}
  dlgPrinterSetup.Execute;
{$ENDIF}
end;

procedure TMainForm.actFilePrintPreviewExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    DoPrintPreview(E);
end;

procedure TMainForm.actFilePrintExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    DoPrint(E);
end;

procedure TMainForm.actFileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.actSearchFindExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.ExecFind;
end;

procedure TMainForm.actSearchFindNextExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.ExecFindNext;
end;

procedure TMainForm.actSearchFindPrevExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.ExecFindPrev;
end;

procedure TMainForm.actSearchReplaceExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.ExecReplace;
end;

procedure TMainForm.actSearchGotoLineExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.GotoLine;
end;

procedure TMainForm.actSearchProcListExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.ProcedureList;
end;

procedure TMainForm.actToolsDirectExecute(Sender: TObject);
begin
  DirectForm.Visible := not DirectForm.Visible;
end;

procedure TMainForm.actToolsDiagExecute(Sender: TObject);
begin
  DiagForm.Visible := not DiagForm.Visible;
end;

procedure TMainForm.actToolsWatchExecute(Sender: TObject);
begin
  WatchForm.Visible := not WatchForm.Visible;
end;

procedure TMainForm.actToolsPianoExecute(Sender: TObject);
begin
  PianoForm.Visible := not PianoForm.Visible;
end;

procedure TMainForm.actToolsJoystickExecute(Sender: TObject);
begin
  JoystickForm.Visible := not JoystickForm.Visible;
end;

procedure TMainForm.actToolsRemoteExecute(Sender: TObject);
begin
  RemoteForm.Visible := not TOfficeMenuItem(Sender).Checked;
end;

procedure TMainForm.actToolsSendMsgExecute(Sender: TObject);
begin
  MessageForm.Visible := not MessageForm.Visible;
end;

procedure TMainForm.actToolsDatalogExecute(Sender: TObject);
begin
  DatalogForm.Visible := not DatalogForm.Visible;
end;

procedure TMainForm.actToolsMemoryExecute(Sender: TObject);
begin
  MemoryForm.Visible := not MemoryForm.Visible;
end;

procedure TMainForm.actToolsSyncMotorsExecute(Sender: TObject);
begin
  frmNXTController.Visible := not frmNXTController.Visible;
end;

procedure TMainForm.actToolsClearMemExecute(Sender: TObject);
begin
  if CheckAlive then
    ClearMemory;
end;

procedure TMainForm.actToolsFindBrickExecute(Sender: TObject);
var
  oldCursor : TCursor;
begin
  oldCursor := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    FindRCX(false);
    ConfigureOtherFirmwareOptions;
  finally
    Screen.Cursor := oldCursor;
  end;
end;

procedure TMainForm.actToolsTurnBrickOffExecute(Sender: TObject);
begin
  BrickComm.Shutdown;
end;

procedure TMainForm.actToolsCloseCommExecute(Sender: TObject);
begin
  BrickComm.Close;
  barStatus.Panels[2].Text := '';
  barStatus.Panels[3].Text := '';
end;

procedure TMainForm.actToolsFirmwareExecute(Sender: TObject);
begin
//  if not CheckAlive then Exit;
  if dlgOpenFirmware.Execute then
  begin
    DirectForm.Close;
    WatchForm.Close;
    DiagForm.Close;
    JoystickForm.Close;
    PianoForm.Close;
    DatalogForm.Close;
    MemoryForm.Close;
    DownloadFirmware;
  end;
end;

procedure TMainForm.actToolsUnlockFirmExecute(Sender: TObject);
begin
  if not BrickComm.PrepareBrick then
  begin
    MessageDlg(sBrickCommError, mtError, [mbOK], 0);
  end;
end;

procedure TMainForm.actToolsConfigureToolsExecute(Sender: TObject);
begin
  with TfrmTransferDlg.Create(nil) do
  try
    PrivateTransferList := TransferList;
    if ShowModal = mrOk then
    begin
      UpdateTransferList(PrivateTransferList, TransferList);
      UpdateToolsMenu;
    end;
  finally
    Free;
  end;
end;

procedure TMainForm.actHelpInfoExecute(Sender: TObject);
begin
  with TAboutBox.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TMainForm.mniSetLNPAddressClick(Sender: TObject);
begin
  TfrmSetLNPAddress.SetLNPAddress;
end;

procedure TMainForm.mniAddress0Click(Sender: TObject);
begin
  if not Assigned(Sender) then Exit;
  TOfficeMenuItem(Sender).Checked := true;
  CurrentLNPAddress := TOfficeMenuItem(Sender).Tag;
end;

procedure TMainForm.mniPort0Click(Sender: TObject);
begin
  if not Assigned(Sender) then Exit;
  TOfficeMenuItem(Sender).Checked := true;
  CurrentLNPPort := TOfficeMenuItem(Sender).Tag;
end;

procedure TMainForm.actToolsMIDIExecute(Sender: TObject);
begin
  TfrmMIDIConversion.DoConversion(dlgSave);
end;

procedure TMainForm.actHelpHelpExecute(Sender: TObject);
begin
{$IFNDEF FPC}
  if FileIsMindScriptOrLASM then
    Application.HelpCommand(HELP_KEY, Integer(PChar('Contents')))
  else
    Application.HelpCommand(HELP_TAB, -3);
{$ENDIF}
end;

procedure TMainForm.IndexClick(Sender: TObject);
var
  str : PChar;
  F : TEditorForm;
begin
  str := '';
  F := ActiveEditorForm;
  if F <> nil then
  begin
    with F.TheEditor do
    begin
      str := PChar(GetWordAtRowCol(CaretXY));
    end;
  end;
{$IFNDEF FPC}
  Application.HelpCommand(HELP_KEY, Integer(str));
{$ENDIF}
end;

procedure TMainForm.mniNqcGuideClick(Sender: TObject);
var
  old : string;
  AEF : TEditorForm;
begin
  AEF := ActiveEditorForm;
  if Assigned(AEF) then
    old := AEF.HelpFile;
  try
    if Assigned(AEF) then
      AEF.HelpFile := Application.HelpFile;
    Application.HelpContext(K_NQC_GUIDE);
  finally
    if Assigned(AEF) then
      AEF.HelpFile := old;
  end;
end;

procedure TMainForm.actToolsNewWatchExecute(Sender: TObject);
begin
  frmNewWatch.Visible := not frmNewWatch.Visible;
end;

procedure TMainForm.actToolsSetValuesExecute(Sender: TObject);
begin
  frmSetValues.Visible := not frmSetValues.Visible;
end;

procedure TMainForm.actToolsSpybotEEPROMExecute(Sender: TObject);
begin
  frmSpybotEEPROM.Visible := not frmSpybotEEPROM.Visible;
end;

procedure TMainForm.actEditCopyHTMLExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.DoCopyHTML(Sender);
end;

procedure TMainForm.actEditCopyRTFExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.DoCopyRTF(Sender);
end;

procedure TMainForm.pagMainChange(Sender: TObject);
var
  F : TEditorForm;
begin
  // hack to update program slot menu checked state
  UpdateProgramSlotMenuItems(CurrentProgramSlot);
  F := ActiveEditorForm;
  if Assigned(F) then
    if Assigned(frmCodeExplorer) then
    begin
      frmCodeExplorer.ActiveEditor := F.TheEditor;
      frmCodeExplorer.ProcessFile(F.FileName, F.TheEditor.Lines.Text);
      frmCodeExplorer.RefreshEntireTree;
    end;
  ChangeActiveEditor;
end;

function TMainForm.CloseEditor(E: TEditorForm; bAll : boolean) : boolean;
var
  TS : TTabSheet;
begin
  Result := True;
  TS := nil;
  if E = nil then Exit;
  if Assigned(E.Parent) then
    TS := TTabSheet(E.Parent);
  Result := E.CloseQuery;
  if Result then
  begin
    E.Close;
    if Assigned(TS) then
    begin
      if TS.TabIndex > 0 then
        pagMain.ActivePage := pagMain.Pages[TS.TabIndex - 1];
      TS.Free;
      if not bAll then
        pagMainChange(nil);
    end;
  end;
end;

procedure TMainForm.mniNextWindowClick(Sender: TObject);
begin
  pagMain.SelectNextPage(True);
  pagMainChange(nil);
end;

{$IFNDEF FPC}
type
  TCrackControlBar = class(TControlBar);
{$ENDIF}

procedure TMainForm.BarMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
{$IFNDEF FPC}
  if LockToolbars then
    TCrackControlBar(Sender).MouseCapture := False;
{$ENDIF}
end;

procedure TMainForm.BarMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
{$IFNDEF FPC}
  if LockToolbars then
    TCrackControlBar(Sender).MouseCapture := False;
{$ENDIF}
end;

procedure TMainForm.SetFilterIndexFromLanguage;
begin
  if LocalFirmwareType = ftStandard then
  begin
    if PreferredLanguage = 0 then
    begin
      if LocalBrickType = SU_NXT then
        dlgOpen.FilterIndex := Highlighters.IndexOf('NXC')+1
      else
        dlgOpen.FilterIndex := Highlighters.IndexOf('NQC')+1;
    end
    else if PreferredLanguage = 1 then
      dlgOpen.FilterIndex   := Highlighters.IndexOf('MindScript')+1
    else if PreferredLanguage = 2 then
      dlgOpen.FilterIndex   := Highlighters.IndexOf('LEGO Assembler')+1
    else if PreferredLanguage = 3 then
      dlgOpen.FilterIndex   := Highlighters.IndexOf('Next Byte Codes')+1
    else
      dlgOpen.FilterIndex   := Highlighters.IndexOf('NXC')+1;
    dlgSave.FilterIndex     := dlgOpen.FilterIndex;
  end;
end;

function TMainForm.HandleOnHelp(Command: Word; Data: Integer;
  var CallHelp: Boolean): Boolean;
{$IFDEF FPC}
begin
{$ELSE}
var
  i : integer;
  F : TForm;
  AEF : TEditorForm;
  SAF : TForm;
  HelpFile : PChar;
begin
  // possibly the command is set to HELP_CONTEXTPOPUP and we
  // really want it to be HELP_CONTEXT instead.  This is the case if
  // the Data == the help context of any form.
  if Command = HELP_CONTEXTPOPUP then
  begin
    for i := 0 to Screen.FormCount - 1 do
    begin
      F := Screen.Forms[i];
      if F.HelpContext = Data then
      begin
        Command := HELP_CONTEXT;
        break;
      end;
    end;
  end;
  SAF := Screen.ActiveForm;
  AEF := ActiveEditorForm;
  if not ((Command = HELP_CONTEXTPOPUP) or (Command = HELP_SETPOPUP_POS)) and
     Assigned(SAF) and Assigned(AEF) and
     ((SAF = Self) or (SAF = Self.ActiveMDIChild)) and
     (AEF.HelpFile <> Application.HelpFile) then
    HelpFile := PChar(AEF.HelpFile)
  else begin
    if Data = K_NQC_GUIDE then
      HelpFile := PChar(ProgramDir + 'help\nqc.hlp')
    else
      HelpFile := PChar(Application.HelpFile);
  end;
  Result := WinHelp(Handle, HelpFile, Command, Data);
  CallHelp := False;
{$ENDIF}
end;

{
function TMainForm.CloseQuery: Boolean;
var
  I, Cnt : Integer;
begin
  Cnt := EditorFormCount;
  if Cnt > 0 then
  begin
    Result := False;
    for I := 0 to Cnt - 1 do
    begin
      if not EditorForms[I].CloseQuery then Exit;
    end;
  end;
  Result := True;
  if Assigned(OnCloseQuery) then OnCloseQuery(Self, Result);
end;
}

procedure TMainForm.SetColorScheme;
begin
{$IFNDEF FPC}
  if ThemeServices.ThemesEnabled then
    Self.Color := dxOffice11DockColor2
  else
    Self.Color := clBtnFace;
  ConfigBar(ogpHelp);
  ConfigBar(ogpFile);
  ConfigBar(ogpSearch);
  ConfigBar(ogpCompile);
  ConfigBar(ogpEdit);
  ConfigBar(ogpTools);
{$ENDIF}
end;

procedure TMainForm.ShowTemplates(bSave : boolean);
var
  bVisible : boolean;
begin
  ConstructForm.ActiveLanguageIndex := ActiveLanguageIndex;
  ConstructForm.Rebuild(bSave);
  ConstructForm.Show;
  ConstructForm.FormShow(Self);
  bVisible := pnlCodeExplorer.VisibleDockClientCount > 0;
  pnlCodeExplorer.Visible := bVisible;
  splCodeExplorer.Visible := bVisible;
end;

procedure TMainForm.cbrTopDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  Accept := (Source.Control is TOfficeGradientPanel);
end;

procedure TMainForm.ShowNXTTools;
begin
  frmNXTExplorer.Show;
end;

procedure TMainForm.actToolsNXTExplorerExecute(Sender: TObject);
begin
  with frmNXTExplorer do begin
    Visible := not Visible;
    if Visible and (WindowState = wsMinimized) then
      WindowState := wsNormal;
  end;
end;

procedure TMainForm.actToolsWav2RsoExecute(Sender: TObject);
begin
  with TfrmWave2RSO.Create(nil) do
  try
    btnCancel.Visible := True;
    btnHelp.Visible   := True;
    ShowModal;
  finally
    Free;
  end;
end;

function TMainForm.ActiveLanguageName : string;
var
  AEF : TEditorForm;
  SCH : TSynCustomHighlighter;
begin
  Result := PreferredLanguageName;
  AEF := ActiveEditorForm;
  if Assigned(AEF) then
  begin
    SCH := AEF.TheEditor.Highlighter;
    if not Assigned(SCH) then
      SCH := GetHighlighterForFile(AEF.Filename);
    if Assigned(SCH) then
      Result := SCH.LanguageName;
  end;
end;

function TMainForm.ActiveLanguageIndex: integer;
begin
  Result := Highlighters.IndexOf(ActiveLanguageName);
end;

(*
Receiver:
var
  str: Pchar;
begin
  GetMem(Str, 255);
  if GlobalGetAtomName(Msg.WParam, str, 255) > 0 then
    StatusCaption := Strpas(str);
  GlobalDeleteAtom(Msg.WParam);
  FreeMem(Str);
end;

Sender:
var
  wParam: Word;
begin
  wParam := GlobalAddAtom('string...');
  PostMessage(StrToInt(Edit1.Text), WM_STATUS_WINDOW_STATUSCHANGE, wParam, 0);
end;
*)

(*
procedure TMainForm.icInstanceCtrlMaxInstancesReached(Sender: TObject;
  const LastInstanceHandle: Cardinal);
var
  wParam : Word;
  cmdline : string;
begin
//  cmdline := GetCommandLine;
  if ParamCount > 1 then
    cmdline := ParamStr(ParamCount)
  else
    cmdline := '.nothing';
  wParam := GlobalAddAtom(PChar(cmdline));
  PostMessage(LastInstanceHandle, WM_BRICXCC_CMDLINE, wParam, Length(cmdline));
end;
*)

{$IFNDEF FPC}
procedure TMainForm.HandleOnMessage(var Msg: tagMSG; var Handled: Boolean);
var
  str: Pchar;
  res : Cardinal;
begin
  if Msg.message = WM_BRICXCC_CMDLINE then
  begin
    GetMem(Str, Msg.lParam+1);
    try
      res := GlobalGetAtomName(Msg.WParam, str, Msg.lParam+1);
      if res > 0 then
      begin
        OpenFile(str);
      end;
      GlobalDeleteAtom(Msg.WParam);
    finally
      FreeMem(Str);
    end;
  end;
end;
{$ENDIF}

procedure TMainForm.ConfigureTransferMenuItemVisibility(aList : TList; aMenuItem : TOfficeMenuItem; const aPrefix : string);
var
  i : integer;
  TI : TTransferItem;
  MI : TOfficeMenuItem;
  AEF : TEditorForm;
  ext : string;
begin
  AEF := ActiveEditorForm;
  if Assigned(AEF) then
    ext := LowerCase(ExtractFileExt(AEF.Filename))
  else
    ext := '.@$%';
  for i := 0 to aList.Count - 1 do
  begin
    TI := TTransferItem(aList[i]);
    MI := TOfficeMenuItem(aMenuItem.FindComponent(aPrefix + IntToStr(i)));
    if Assigned(MI) then
    begin
      MI.Visible := (not TI.Restrict) or
                    (Pos(ext, LowerCase(TI.Extension)) > 0);
    end;
  end;
end;

procedure TMainForm.mniCompileClick(Sender: TObject);
begin
  ConfigureTransferMenuItemVisibility(CompXferList, mniCompile, K_COMP_TRANSFER_PREFIX);
end;

procedure TMainForm.mniToolsClick(Sender: TObject);
begin
  ConfigureTransferMenuItemVisibility(TransferList, mniTools, K_TRANSFER_PREFIX);
end;

procedure TMainForm.actToolsNXTScreenExecute(Sender: TObject);
begin
  with frmNXTImage do begin
    Visible := not Visible;
    if Visible and (WindowState = wsMinimized) then
      WindowState := wsNormal;
  end;
end;

procedure TMainForm.CreateSpiritPlugins;
var
  Plugin : TPSPlugin;
begin
  Plugin := TPSImport_uSpirit.Create(Self);
  TPSPluginItem(ce.Plugins.Add).Plugin := Plugin;
  Plugin := TPSImport_brick_common.Create(Self);
  TPSPluginItem(ce.Plugins.Add).Plugin := Plugin;
{$IFNDEF FPC}
  Plugin := TPSImport_FakeSpirit.Create(Self);
  TPSPluginItem(ce.Plugins.Add).Plugin := Plugin;
{$ENDIF}
  Plugin := TPSImport_FantomSpirit.Create(Self);
  TPSPluginItem(ce.Plugins.Add).Plugin := Plugin;
end;

procedure TMainForm.ceExecute(Sender: TPSScript);
begin
  ce.SetVarToInstance('SELF', Self);
  ce.SetVarToInstance('APPLICATION', Application);
end;

procedure TMainForm.ceCompile(Sender: TPSScript);
begin
  //  Sender.AddMethod(Self, @TEditor.Writeln, 'procedure Writeln(s: string)');
  //  Sender.AddMethod(Self, @TEditor.Readln, 'procedure readln(var s: string)');
    Sender.AddRegisteredVariable('Self', 'TForm');
    Sender.AddRegisteredVariable('Application', 'TApplication');
end;

procedure TMainForm.ceIdle(Sender: TObject);
var
  E : TEditorForm;
begin
  Application.HandleMessage;
  if FResume then
  begin
    FResume := False;
    ce.Resume;
    FActiveLine := 0;
    E := ActiveEditorForm;
    if Assigned(E) then
      E.TheEditor.Refresh;
  end;
end;

procedure TMainForm.ceAfterExecute(Sender: TPSScript);
begin
  FActiveLine := 0;
end;

procedure TMainForm.ceBreakpoint(Sender: TObject; const FileName: String;
  Position, Row, Col: Cardinal);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if not Assigned(E) then Exit;
  FActiveLine := Row;
  if (FActiveLine < E.TheEditor.TopLine + 2) or
     (FActiveLine > E.TheEditor.TopLine + E.TheEditor.LinesInWindow - 2) then
  begin
    E.TheEditor.TopLine := FActiveLine - (E.TheEditor.LinesInWindow div 2);
  end;
  E.TheEditor.CaretY := FActiveLine;
  E.TheEditor.CaretX := 1;
  E.TheEditor.Refresh;
end;

procedure TMainForm.ceLineInfo(Sender: TObject; const FileName: String;
  Position, Row, Col: Cardinal);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if not Assigned(E) then Exit;
  if ce.Exec.DebugMode <> dmRun then
  begin
    FActiveLine := Row;
    if (FActiveLine < E.TheEditor.TopLine + 2) or
       (FActiveLine > E.TheEditor.TopLine + E.TheEditor.LinesInWindow - 2) then
    begin
      E.TheEditor.TopLine := FActiveLine - (E.TheEditor.LinesInWindow div 2);
    end;
    E.TheEditor.CaretY := FActiveLine;
    E.TheEditor.CaretX := 1;
    E.TheEditor.Refresh;
  end;
end;

function TMainForm.ceNeedFile(Sender: TObject; const OrginFileName: String;
  var FileName, Output: String): Boolean;
var
  Path: string;
  F: TFileStream;
  E : TEditorForm;
begin
  Result := False;
  E := ActiveEditorForm;
  if not Assigned(E) then Exit;
  if E.Filename <> '' then
    Path := ExtractFilePath(E.Filename)
  else
    Path := ExtractFilePath(ParamStr(0));
  Path := Path + FileName;
  F := TFileStream.Create(Path, fmOpenRead or fmShareDenyWrite);
  try
    SetLength(Output, F.Size);
    F.Read(Output[1], Length(Output));
  finally
    F.Free;
  end;
  Result := True;
end;

procedure TMainForm.actCompilePauseExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if not Assigned(E) or
     not (IsNXT and EnhancedFirmware) or
     not CurrentProgram.Loaded(E.Filename) then
    Exit;
  if CurrentProgram.VMState in [kNXT_VMState_Pause, kNXT_VMState_Single] then
  begin
    if CurrentProgram.Run then
      actCompilePause.Caption := sBreakAll;
  end
  else if fNXTVMState = kNXT_VMState_RunFree then
  begin
    if CurrentProgram.ProgramPause then
    begin
      actCompilePause.Caption := sContinue;
      UpdateEditorPosition;
    end;
  end;
end;

procedure TMainForm.actCompileSingleStepExecute(Sender: TObject);
begin
(*
  if not (IsNXT and EnhancedFirmware) then
    Exit;
  if CurrentProgram.SingleStep(True) then
  begin
    actCompilePause.Caption := sContinue;
    UpdateEditorPosition;
  end;
*)
end;

procedure TMainForm.UpdateEditorPosition;
var
  CD : TProgClumpData;
  CO : TOffset;
  AEF : TEditorForm;
  i : integer;
begin
  fNXTCurrentOffset := nil;
  if (fNXTClump < CurrentProgram.Count) then
  begin
    CD := CurrentProgram[fNXTClump];
    AEF := ActiveEditorForm;
    if Assigned(AEF) and (Pos(Lowercase(AEF.Filename), LowerCase(CD.Filename)) > 0) then
    begin
      i := CD.Offsets.IndexOfPC(fNXTProgramCounter);
      if i <> -1 then
      begin
        CO := CD.Offsets[i];
        if LowerCase(ExtractFileName(CO.Filename)) = LowerCase(ExtractFilename(CD.Filename)) then
        begin
          fNXTCurrentOffset := CO;
          AEF.TheEditor.GotoLineAndCenter(CO.LineNumber);
        end
        else
        begin
          // if the filenames are different then open the new file
          if AEF.OpenFileOnPath(CO.Filename) then
          begin
            AEF := ActiveEditorForm;
            AEF.TheEditor.GotoLineAndCenter(CO.LineNumber);
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.HandleOnGetVarInfoByID(Sender: TObject;
  const ID: integer; var offset, size, vartype: integer);
var
  DSE : TDSTocEntry;
begin
  // read offset, size, and vartype from compiler symbol table output
  if CurrentProgram.Dataspace.Count > ID then
  begin
    DSE     := CurrentProgram.Dataspace[ID];
    offset  := DSE.Offset;
    size    := DSE.Size;
    vartype := Ord(DSE.DataType);
  end;
end;

procedure TMainForm.HandleOnGetVarInfoByName(Sender: TObject;
  const name: string; var offset, size, vartype: integer);
var
  DSE : TDSTocEntry;
  ID : integer;
begin
  // read offset, size, and vartype from compiler symbol table output
  if CurrentProgram.Dataspace.Count > 0 then
  begin
    ID := CurrentProgram.Dataspace.IndexOfName(name);
    if ID <> -1 then
    begin
      DSE     := CurrentProgram.Dataspace[ID];
      offset  := DSE.Offset;
      size    := DSE.Size;
      vartype := Ord(DSE.DataType);
    end;
  end;
end;

procedure TMainForm.CreatePascalScriptComponents;
begin
  PSImport_Controls := TPSImport_Controls.Create(Self);
  PSImport_StdCtrls := TPSImport_StdCtrls.Create(Self);
  PSImport_Forms := TPSImport_Forms.Create(Self);
  PSImport_DateUtils := TPSImport_DateUtils.Create(Self);
  PSImport_Classes := TPSImport_Classes.Create(Self);
  ce := TPSScriptDebugger.Create(Self);
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
  with ce do
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
    OnCompile := ceCompile;
    OnExecute := ceExecute;
    OnAfterExecute := ceAfterExecute;
    OnNeedFile := ceNeedFile;
    OnIdle := ceIdle;
    OnLineInfo := ceLineInfo;
    OnBreakpoint := ceBreakpoint;
  end;
//  ce.Comp.on
end;

procedure TMainForm.CreateMainFormHighlighters;
begin
  SynNXCSyn := TSynNXCSyn.Create(Self);
  SynNPGSyn := TSynNPGSyn.Create(Self);
  SynRubySyn := TSynRubySyn.Create(Self);
  SynNBCSyn := TSynNBCSyn.Create(Self);
  SynJavaSyn := TSynJavaSyn.Create(Self);
  SynLASMSyn := TSynLASMSyn.Create(Self);
  SynNQCSyn := TSynNQCSyn.Create(Self);
  SynPasSyn := TSynPasSyn.Create(Self);
  SynMindScriptSyn := TSynMindScriptSyn.Create(Self);
  SynCSSyn := TSynCSSyn.Create(Self);
  SynLuaSyn := TSynLuaSyn.Create(Self);
  SynRSSyn := TSynRSSyn.Create(Self);
  SynCppSyn := TSynCppSyn.Create(Self);
  SynForthSyn := TSynForthSyn.Create(Self);
  SynROPSSyn := TSynROPSSyn.Create(Self);
  with SynNXCSyn do
  begin
    Name := 'SynNXCSyn';
    DefaultFilter := 'NXC Files (*.nxc)|*.nxc';
    Comments := [csCStyle];
    DetectPreprocessor := True;
    IdentifierChars := '#0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz';
    Keywords.Clear;
    Commands.Clear;
    Constants.Clear;
    SampleSourceStrings.Clear;
  end;
  with SynNPGSyn do
  begin
    Name := 'SynNPGSyn';
    DefaultFilter := 'NPG Files (*.npg)|*.npg';
  end;
  with SynRubySyn do
  begin
    Name := 'SynRubySyn';
  end;
  with SynNBCSyn do
  begin
    Name := 'SynNBCSyn';
    DefaultFilter := 'Next Byte Code Files (*.nbc)|*.nbc';
  end;
  with SynJavaSyn do
  begin
    Name := 'SynJavaSyn';
    DefaultFilter := 'Java Files (*.java)|*.java';
  end;
  with SynLASMSyn do
  begin
    Name := 'SynLASMSyn';
    DefaultFilter := 'LASM Assembler Files (*.asm)|*.asm';
  end;
  with SynNQCSyn do
  begin
    Name := 'SynNQCSyn';
    DefaultFilter := 'NQC Files (*.nqc,*.nqh)|*.nqc;*.nqh';
    Comments := [csCStyle];
    DetectPreprocessor := True;
    IdentifierChars := '#0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz';
    KeyWords.Clear;
    Commands.Clear;
    Constants.Clear;
    SampleSourceStrings.Clear;
  end;
  with SynPasSyn do
  begin
    Name := 'SynPasSyn';
  end;
  with SynMindScriptSyn do
  begin
    Name := 'SynMindScriptSyn';
  end;
  with SynCSSyn do
  begin
    Name := 'SynCSSyn';
    DefaultFilter := 'C# Files (*.cs)|*.cs';
  end;
  with SynLuaSyn do
  begin
    Name := 'SynLuaSyn';
  end;
  with SynRSSyn do
  begin
    Name := 'SynRSSyn';
    DefaultFilter := 'RICScript Files (*.rs)|*.rs';
  end;
  with SynCppSyn do
  begin
    Name := 'SynCppSyn';
    DefaultFilter := 'C++ Files (*.c,*.cpp,*.h,*.hpp)|*.c;*.cpp;*.h;*.hpp';
  end;
  with SynForthSyn do
  begin
    Name := 'SynForthSyn';
  end;
  with SynROPSSyn do
  begin
    Name := 'SynROPSSyn';
    PackageSource := False;
  end;
end;

procedure TMainForm.CreateMenus;
begin
  mnuMain := TOfficeMainMenu.Create(Self);
  mnuMain.Name := 'mnuMain';
  Self.Menu := mnuMain;
  // create file menu
  mniFile := TOfficeMenuItem.Create(mnuMain);
  // add it to main menu
  mnuMain.Items.Add(mniFile);
  // create its children
  mniNew := TOfficeMenuItem.Create(mniFile);
  mniOpen := TOfficeMenuItem.Create(mniFile);
  mniSave := TOfficeMenuItem.Create(mniFile);
  mniSaveAs := TOfficeMenuItem.Create(mniFile);
  mniSaveAll := TOfficeMenuItem.Create(mniFile);
  mniClose := TOfficeMenuItem.Create(mniFile);
  mniCloseAll := TOfficeMenuItem.Create(mniFile);
  N11 := TOfficeMenuItem.Create(mniFile);
  mniInsertFile := TOfficeMenuItem.Create(mniFile);
  N2 := TOfficeMenuItem.Create(mniFile);
  mniPageSetup := TOfficeMenuItem.Create(mniFile);
  mniPrinterSetup := TOfficeMenuItem.Create(mniFile);
  mniPrintPreview := TOfficeMenuItem.Create(mniFile);
  mniPrint := TOfficeMenuItem.Create(mniFile);
  mniSepFiles := TOfficeMenuItem.Create(mniFile);
  N1 := TOfficeMenuItem.Create(mniFile);
  mniExit := TOfficeMenuItem.Create(mniFile);
  // add menu items to file menu
  mniFile.Add([mniNew, mniOpen, mniSave, mniSaveAs, mniSaveAll, mniClose,
               mniCloseAll, N11, mniInsertFile, N2, mniPageSetup,
               mniPrinterSetup, mniPrintPreview, mniPrint, mniSepFiles,
               N1, mniExit]);
  // create edit menu
  mniEdit := TOfficeMenuItem.Create(mnuMain);
  // add it to main menu
  mnuMain.Items.Add(mniEdit);
  // create its children
  mniUndo := TOfficeMenuItem.Create(mniEdit);
  mniRedo := TOfficeMenuItem.Create(mniEdit);
  N12 := TOfficeMenuItem.Create(mniEdit);
  mniCut := TOfficeMenuItem.Create(mniEdit);
  mniCopy := TOfficeMenuItem.Create(mniEdit);
  mniPaste := TOfficeMenuItem.Create(mniEdit);
  mniDelete := TOfficeMenuItem.Create(mniEdit);
  N6 := TOfficeMenuItem.Create(mniEdit);
  mniSelectAll := TOfficeMenuItem.Create(mniEdit);
  mniCopySpecial := TOfficeMenuItem.Create(mniEdit);
  mniCopyHTML := TOfficeMenuItem.Create(mniCopySpecial);
  mniCopyRTF := TOfficeMenuItem.Create(mniCopySpecial);
  N8 := TOfficeMenuItem.Create(mniEdit);
  mniNextField := TOfficeMenuItem.Create(mniEdit);
  N16 := TOfficeMenuItem.Create(mniEdit);
  mniPreferences := TOfficeMenuItem.Create(mniEdit);
  // add menu items to edit menu
  mniEdit.Add([mniUndo, mniRedo, N12, mniCut, mniCopy, mniPaste,
               mniDelete, N6, mniSelectAll, mniCopySpecial, N8,
               mniNextField, N16, mniPreferences]);
  mniCopySpecial.Add([mniCopyHTML, mniCopyRTF]);

  // create search menu
  mniSearch := TOfficeMenuItem.Create(Self);
  // add it to main menu
  mnuMain.Items.Add(mniSearch);
  // create its children
  mniFind := TOfficeMenuItem.Create(Self);
  mniFindNext := TOfficeMenuItem.Create(Self);
  mniFindPrevious := TOfficeMenuItem.Create(Self);
  mniReplace := TOfficeMenuItem.Create(Self);
  N13 := TOfficeMenuItem.Create(Self);
  mniGotoLineNumber := TOfficeMenuItem.Create(Self);
  mniProcedureList := TOfficeMenuItem.Create(Self);
  N13a := TOfficeMenuItem.Create(Self);
  mniGrepSearch := TOfficeMenuItem.Create(Self);
  mniGrepResults := TOfficeMenuItem.Create(Self);
  // add menu items to search menu
  mniSearch.Add([mniFind, mniFindNext, mniFindPrevious, mniReplace,
                 N13, mniGotoLineNumber, mniProcedureList,
                 N13a, mniGrepSearch, mniGrepResults]);

  // create view menu
  mniView := TOfficeMenuItem.Create(Self);
  // add it to main menu
  mnuMain.Items.Add(mniView);
  // create its children
  mniProjectManager := TOfficeMenuItem.Create(mniView);
  mniCodeExplorer := TOfficeMenuItem.Create(mniView);
  mniStatusbar := TOfficeMenuItem.Create(mniView);
  mniShowTemplates := TOfficeMenuItem.Create(mniView);
  mniShowCodeListing := TOfficeMenuItem.Create(mniView);
  mniHideErrors := TOfficeMenuItem.Create(mniView);
  mniViewToolWindows := TOfficeMenuItem.Create(mniView);
  mniMacroManager := TOfficeMenuItem.Create(mniView);
  mniPBForthConsole := TOfficeMenuItem.Create(mniView);
  mniWindowList := TOfficeMenuItem.Create(mniView);
  N18 := TOfficeMenuItem.Create(mniView);
  mniToolbars := TOfficeMenuItem.Create(mniView);
  mniFileToolbar1 := TOfficeMenuItem.Create(mniToolbars);
  mniSearchToolbar1 := TOfficeMenuItem.Create(mniToolbars);
  mniCompileToolbar1 := TOfficeMenuItem.Create(mniToolbars);
  mniHelpToolbar1 := TOfficeMenuItem.Create(mniToolbars);
  mniEditToolbar1 := TOfficeMenuItem.Create(mniToolbars);
  mniToolsToolbar1 := TOfficeMenuItem.Create(mniToolbars);
  // add menu items to view menu
  mniView.Add([mniProjectManager, mniCodeExplorer, mniStatusbar,
               mniShowTemplates, mniShowCodeListing, mniHideErrors,
               mniViewToolWindows, mniMacroManager, mniPBForthConsole,
               mniWindowList, N18, mniToolbars]);
  mniToolbars.Add([mniFileToolbar1, mniSearchToolbar1, mniCompileToolbar1,
                   mniHelpToolbar1, mniEditToolbar1, mniToolsToolbar1]);

  // create compile menu
  mniCompile := TOfficeMenuItem.Create(Self);
  // add it to main menu
  mnuMain.Items.Add(mniCompile);
  // create its children
  mniCompileProgram := TOfficeMenuItem.Create(mniCompile);
  mniDownload := TOfficeMenuItem.Create(mniCompile);
  mniDownloadandRun := TOfficeMenuItem.Create(mniCompile);
  mniProgramNumber := TOfficeMenuItem.Create(mniCompile);
  mniProgram1 := TOfficeMenuItem.Create(mniProgramNumber);
  mniProgram2 := TOfficeMenuItem.Create(mniProgramNumber);
  mniProgram3 := TOfficeMenuItem.Create(mniProgramNumber);
  mniProgram4 := TOfficeMenuItem.Create(mniProgramNumber);
  mniProgram5 := TOfficeMenuItem.Create(mniProgramNumber);
  mniProgram6 := TOfficeMenuItem.Create(mniProgramNumber);
  mniProgram7 := TOfficeMenuItem.Create(mniProgramNumber);
  mniProgram8 := TOfficeMenuItem.Create(mniProgramNumber);
  N15 := TOfficeMenuItem.Create(mniCompile);
  mniRun := TOfficeMenuItem.Create(mniCompile);
  mniStop := TOfficeMenuItem.Create(mniCompile);
  mniPause := TOfficeMenuItem.Create(mniCompile);
  mniSingleStep := TOfficeMenuItem.Create(mniCompile);
  mniStepOver := TOfficeMenuItem.Create(mniCompile);
  mniTraceInto := TOfficeMenuItem.Create(mniCompile);
  mniRunToCursor:= TOfficeMenuItem.Create(mniCompile);
  mniRunUntilReturn := TOfficeMenuItem.Create(mniCompile);
  mniTraceToLine := TOfficeMenuItem.Create(mniCompile);

  mniCompSep := TOfficeMenuItem.Create(mniCompile);
  // add menu items to compile menu
  mniCompile.Add([mniCompileProgram, mniDownload, mniDownloadandRun,
                  mniProgramNumber, N15, mniRun, mniStop, mniPause,
                  mniSingleStep, mniStepOver, mniTraceInto, mniRunToCursor,
                  mniRunUntilReturn, mniTraceToLine, mniCompSep]);
  mniProgramNumber.Add([mniProgram1, mniProgram2, mniProgram3, mniProgram4,
                        mniProgram5, mniProgram6, mniProgram7, mniProgram8]);

  // create tools menu
  mniTools := TOfficeMenuItem.Create(Self);
  // add it to main menu
  mnuMain.Items.Add(mniTools);
  // create its children
  mniDirectControl := TOfficeMenuItem.Create(mniTools);
  mniDiagnose := TOfficeMenuItem.Create(mniTools);
  mniWatch := TOfficeMenuItem.Create(mniTools);
  mniRCXPiano := TOfficeMenuItem.Create(mniTools);
  mniRCXJoystick := TOfficeMenuItem.Create(mniTools);
  mniRemote := TOfficeMenuItem.Create(mniTools);
  mniNewWatch := TOfficeMenuItem.Create(mniTools);
  mniSetvalues := TOfficeMenuItem.Create(mniTools);
  mniSpybotEEPROM := TOfficeMenuItem.Create(mniTools);
  mniNXTExplorer := TOfficeMenuItem.Create(mniTools);
  mniNXTScreen := TOfficeMenuItem.Create(mniTools);
  mniSyncMotors := TOfficeMenuItem.Create(mniTools);
  N7 := TOfficeMenuItem.Create(mniTools);
  mniSendMessage := TOfficeMenuItem.Create(mniTools);
  mniDatalog := TOfficeMenuItem.Create(mniTools);
  mniMemoryMap := TOfficeMenuItem.Create(mniTools);
  mniClearMemory := TOfficeMenuItem.Create(mniTools);
  mniMIDIConversion := TOfficeMenuItem.Create(mniTools);
  mniSoundConvert := TOfficeMenuItem.Create(mniTools);
  N9 := TOfficeMenuItem.Create(mniTools);
  mniFindRCX := TOfficeMenuItem.Create(mniTools);
  mniTurnRCXOff := TOfficeMenuItem.Create(mniTools);
  mniCloseComm := TOfficeMenuItem.Create(mniTools);
  N3 := TOfficeMenuItem.Create(mniTools);
  mniFirmware := TOfficeMenuItem.Create(mniTools);
  mniUnlockFirmware := TOfficeMenuItem.Create(mniTools);
  mniConfigureTools := TOfficeMenuItem.Create(mniTools);
  N4 := TOfficeMenuItem.Create(mniTools);
  // add menu items to tools menu
  mniTools.Add([mniDirectControl, mniDiagnose, mniWatch, mniRCXPiano,
                mniRCXJoystick, mniRemote, mniNewWatch, mniSetvalues,
                mniSpybotEEPROM, mniNXTExplorer, mniNXTScreen, mniSyncMotors,
                N7, mniSendMessage, mniDatalog, mniMemoryMap, mniClearMemory,
                mniMIDIConversion, mniSoundConvert, N9, mniFindRCX,
                mniTurnRCXOff, mniCloseComm, N3, mniFirmware,
                mniUnlockFirmware, mniConfigureTools, N4]);

  // create brickOS menu
  mniBrickOS := TOfficeMenuItem.Create(Self);
  // add it to main menu
  mnuMain.Items.Add(mniBrickOS);
  // create its children
  mniSetLNPAddress := TOfficeMenuItem.Create(mniBrickOS);
  mniDownloadAddress := TOfficeMenuItem.Create(mniBrickOS);
  mniAddress0 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniAddress1 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniAddress2 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniAddress3 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniAddress4 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniAddress5 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniAddress6 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniAddress7 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniAddress8 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniAddress9 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniAddress10 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniAddress11 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniAddress12 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniAddress13 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniAddress14 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniAddress15 := TOfficeMenuItem.Create(mniDownloadAddress);
  mniLNPPort := TOfficeMenuItem.Create(mniBrickOS);
  mniPort0 := TOfficeMenuItem.Create(mniLNPPort);
  mniPort1 := TOfficeMenuItem.Create(mniLNPPort);
  mniPort2 := TOfficeMenuItem.Create(mniLNPPort);
  mniPort3 := TOfficeMenuItem.Create(mniLNPPort);
  mniPort4 := TOfficeMenuItem.Create(mniLNPPort);
  mniPort5 := TOfficeMenuItem.Create(mniLNPPort);
  mniPort6 := TOfficeMenuItem.Create(mniLNPPort);
  mniPort7 := TOfficeMenuItem.Create(mniLNPPort);
  mniPort8 := TOfficeMenuItem.Create(mniLNPPort);
  mniPort9 := TOfficeMenuItem.Create(mniLNPPort);
  mniPort10 := TOfficeMenuItem.Create(mniLNPPort);
  mniPort11 := TOfficeMenuItem.Create(mniLNPPort);
  mniPort12 := TOfficeMenuItem.Create(mniLNPPort);
  mniPort13 := TOfficeMenuItem.Create(mniLNPPort);
  mniPort14 := TOfficeMenuItem.Create(mniLNPPort);
  mniPort15 := TOfficeMenuItem.Create(mniLNPPort);
  // add menu items to brickOS menu
  mniBrickOS.Add([mniSetLNPAddress, mniDownloadAddress, mniLNPPort]);
  mniDownloadAddress.Add([mniAddress0,  mniAddress1,  mniAddress2,  mniAddress3,
                          mniAddress4,  mniAddress5,  mniAddress6,  mniAddress7,
                          mniAddress8,  mniAddress9,  mniAddress10, mniAddress11,
                          mniAddress12, mniAddress13, mniAddress14, mniAddress15 ]);
  mniLNPPort.Add([mniPort0,  mniPort1,  mniPort2,  mniPort3,
                  mniPort4,  mniPort5,  mniPort6,  mniPort7,
                  mniPort8,  mniPort9,  mniPort10, mniPort11,
                  mniPort12, mniPort13, mniPort14, mniPort15 ]);

  // create Window menu
  mniWindow := TOfficeMenuItem.Create(Self);
  Self.WindowMenu := mniWindow;
  // add it to main menu
  mnuMain.Items.Add(mniWindow);
  // create its children
  mniTileHorizontal := TOfficeMenuItem.Create(mniWindow);
  mniTileVertical := TOfficeMenuItem.Create(mniWindow);
  mniCascade := TOfficeMenuItem.Create(mniWindow);
  mniArrange := TOfficeMenuItem.Create(mniWindow);
  N10 := TOfficeMenuItem.Create(mniWindow);
  mniPositions := TOfficeMenuItem.Create(mniWindow);
  mniPosSave := TOfficeMenuItem.Create(mniPositions);
  mniPosLoad := TOfficeMenuItem.Create(mniPositions);
  // add menu items to brickOS menu
  mniWindow.Add([mniTileHorizontal, mniTileVertical, mniCascade,
                 mniArrange, N10, mniPositions]);
  mniPositions.Add([mniPosSave, mniPosLoad]);

  // create help menu
  mniHelp := TOfficeMenuItem.Create(Self);
  // add it to main menu
  mnuMain.Items.Add(mniHelp);
  // create its children
  mniContents := TOfficeMenuItem.Create(mniHelp);
  mniIndex := TOfficeMenuItem.Create(mniHelp);
  mniNqcGuide := TOfficeMenuItem.Create(mniHelp);
  mniHowTo := TOfficeMenuItem.Create(mniHelp);
  N5 := TOfficeMenuItem.Create(mniHelp);
  mniWebpage := TOfficeMenuItem.Create(mniHelp);
  mniGuidePDFs := TOfficeMenuItem.Create(mniHelp);
  mniNXCGuidePDF := TOfficeMenuItem.Create(mniGuidePDFs);
  mniNQCGuidePDF := TOfficeMenuItem.Create(mniGuidePDFs);
  mniNBCGuidePDF := TOfficeMenuItem.Create(mniGuidePDFs);
  mniTutorialPDFs := TOfficeMenuItem.Create(mniHelp);
  mniNXCTutorialPDF := TOfficeMenuItem.Create(mniTutorialPDFs);
  mniNQCTutorialPDF := TOfficeMenuItem.Create(mniTutorialPDFs);
  mniNBCTutorialPDF := TOfficeMenuItem.Create(mniTutorialPDFs);
  N14 := TOfficeMenuItem.Create(mniHelp);
  mniAbout := TOfficeMenuItem.Create(mniHelp);
  // add menu items to help menu
  mniHelp.Add([mniContents, mniIndex, mniNqcGuide, mniHowTo,
               N5, mniWebpage, mniGuidePDFs, mniTutorialPDFs, N14, mniAbout]);
  mniGuidePDFs.Add([mniNQCGuidePDF, mniNXCGuidePDF, mniNBCGuidePDF]);
  mniTutorialPDFs.Add([mniNQCTutorialPDF, mniNXCTutorialPDF, mniNBCTutorialPDF]);

  with mniFile do
  begin
    Name := 'mniFile';
    Caption := sFileMenu;
    OnClick := mniFileClick;
  end;
  with mniNew do
  begin
    Name := 'mniNew';
    Action := actFileNew;
  end;
  with mniOpen do
  begin
    Name := 'mniOpen';
    Action := actFileOpen;
  end;
  with mniSave do
  begin
    Name := 'mniSave';
    Action := actFileSave;
  end;
  with mniSaveAs do
  begin
    Name := 'mniSaveAs';
    Action := actFileSaveAs;
    ResourceName := 'IMG_SAVEAS';
    NumGlyphs := 4;
  end;
  with mniSaveAll do
  begin
    Name := 'mniSaveAll';
    Action := actFileSaveAll;
    ResourceName := 'IMG_SAVEALL';
    NumGlyphs := 4;
  end;
  with mniClose do
  begin
    Name := 'mniClose';
    Action := actFileClose;
  end;
  with mniCloseAll do
  begin
    Name := 'mniCloseAll';
    Action := actFileCloseAll;
  end;
  with N11 do
  begin
    Name := 'N11';
    Caption := '-';
  end;
  with mniInsertFile do
  begin
    Name := 'mniInsertFile';
    Action := actFileInsertFile;
    ResourceName := 'IMG_INSERTDOC';
    NumGlyphs := 4;
  end;
  with N2 do
  begin
    Name := 'N2';
    Caption := '-';
  end;
  with mniPageSetup do
  begin
    Name := 'mniPageSetup';
    Action := actFilePageSetup;
  end;
  with mniPrinterSetup do
  begin
    Name := 'mniPrinterSetup';
    Action := actFilePrinterSetup;
    Hint := 'Printer setup';
    ResourceName := 'IMG_PRINTSETUP';
    NumGlyphs := 4;
  end;
  with mniPrintPreview do
  begin
    Name := 'mniPrintPreview';
    Action := actFilePrintPreview;
  end;
  with mniPrint do
  begin
    Name := 'mniPrint';
    Action := actFilePrint;
  end;
  with mniSepFiles do
  begin
    Name := 'mniSepFiles';
    Caption := '-';
  end;
  with N1 do
  begin
    Name := 'N1';
    Caption := '-';
  end;
  with mniExit do
  begin
    Name := 'mniExit';
    Action := actFileExit;
    ResourceName := 'IMG_EXIT';
    NumGlyphs := 4;
  end;
  with mniEdit do
  begin
    Name := 'mniEdit';
    Caption := sEditMenu;
    GroupIndex := 1;
  end;
  with mniUndo do
  begin
    Name := 'mniUndo';
    Action := actEditUndo;
    ShortCut := 16474;
  end;
  with mniRedo do
  begin
    Name := 'mniRedo';
    Action := actEditRedo;
    ShortCut := 24666;
  end;
  with N12 do
  begin
    Name := 'N12';
    Caption := '-';
  end;
  with mniCut do
  begin
    Name := 'mniCut';
    Action := actEditCut;
    ShortCut := 16472;
  end;
  with mniCopy do
  begin
    Name := 'mniCopy';
    Action := actEditCopy;
    ShortCut := 16451;
  end;
  with mniPaste do
  begin
    Name := 'mniPaste';
    Action := actEditPaste;
    ShortCut := 16470;
  end;
  with mniDelete do
  begin
    Name := 'mniDelete';
    Action := actEditDelete;
    ShortCut := 16430;
  end;
  with N6 do
  begin
    Name := 'N6';
    Caption := '-';
  end;
  with mniSelectAll do
  begin
    Name := 'mniSelectAll';
    Action := actEditSelectAll;
    ShortCut := 16449;
    ResourceName := 'IMG_SELECTALL';
    NumGlyphs := 4;
  end;
  with mniCopySpecial do
  begin
    Name := 'mniCopySpecial';
    Caption := sCopySpecialMenu;
  end;
  with mniCopyHTML do
  begin
    Name := 'mniCopyHTML';
    Action := actEditCopyHTML;
  end;
  with mniCopyRTF do
  begin
    Name := 'mniCopyRTF';
    Action := actEditCopyRTF;
  end;
  with N8 do
  begin
    Name := 'N8';
    Caption := '-';
  end;
  with mniNextField do
  begin
    Name := 'mniNextField';
    Action := actEditNextField;
    ResourceName := 'IMG_FIELD';
    NumGlyphs := 4;
  end;
  with N16 do
  begin
    Name := 'N16';
    Caption := '-';
  end;
  with mniPreferences do
  begin
    Name := 'mniPreferences';
    Action := actEditPreferences;
  end;
  with mniSearch do
  begin
    Name := 'mniSearch';
    Caption := sSearchMenu;
    GroupIndex := 2;
  end;
  with mniFind do
  begin
    Name := 'mniFind';
    Action := actSearchFind;
  end;
  with mniFindNext do
  begin
    Name := 'mniFindNext';
    Action := actSearchFindNext;
    ResourceName := 'IMG_FINDNEXT';
    NumGlyphs := 4;
  end;
  with mniFindPrevious do
  begin
    Name := 'mniFindPrevious';
    Action := actSearchFindPrev;
    ResourceName := 'IMG_FINDPREV';
    NumGlyphs := 4;
  end;
  with mniReplace do
  begin
    Name := 'mniReplace';
    Action := actSearchReplace;
  end;
  with N13 do
  begin
    Name := 'N13';
    Caption := '-';
  end;
  with mniGotoLineNumber do
  begin
    Name := 'mniGotoLineNumber';
    Action := actSearchGotoLine;
    HelpContext := 46000;
  end;
  with mniProcedureList do
  begin
    Name := 'mniProcedureList';
    Action := actSearchProcList;
    HelpContext := 22000;
  end;
  with N13a do
  begin
    Name := 'N13a';
    Caption := '-';
  end;
  with mniGrepSearch do
  begin
    Name := 'mniGrepSearch';
    Action := actSearchGrepSearch;
  end;
  with mniGrepResults do
  begin
    Name := 'mniGrepResults';
    Action := actSearchGrepResults;
  end;
  with mniView do
  begin
    Name := 'mniView';
    Caption := sViewMenu;
    GroupIndex := 3;
    OnClick := mniViewClick;
  end;
  with mniProjectManager do
  begin
    Name := 'mniProjectManager';
    Caption := sProjectManager;
    HelpContext := 37000;
    ShortCut := 49274;
    OnClick := mniProjectManagerClick;
    ResourceName := 'IMG_PROJMGR';
    NumGlyphs := 4;
  end;
  with mniCodeExplorer do
  begin
    Name := 'mniCodeExplorer';
    Caption := sCodeExplorer;
    OnClick := mniCodeExplorerClick;
    ResourceName := 'IMG_CODEEXPLORER';
    NumGlyphs := 4;
  end;
  with mniStatusbar do
  begin
    Name := 'mniStatusbar';
    Caption := sStatusbar;
    OnClick := mniStatusbarClick;
  end;
  with mniShowTemplates do
  begin
    Name := 'mniShowTemplates';
    Caption := sTemplates;
    HelpContext := 8;
    ShortCut := 120;
    OnClick := mniShowTemplatesClick;
  end;
  with mniShowCodeListing do
  begin
    Name := 'mniShowCodeListing';
    Caption := sShowCodeError;
    HelpContext := 10;
    ShortCut := 123;
    OnClick := mniShowCodeListingClick;
  end;
  with mniHideErrors do
  begin
    Name := 'mniHideErrors';
    Caption := sHideErrors;
    HelpContext := 10;
    ShortCut := 16456;
    OnClick := mniHideErrorsClick;
  end;
  with mniViewToolWindows do
  begin
    Name := 'mniViewToolWindows';
    Caption := sToolWindows;
    Hint := sToolWindows;
    ShortCut := TextToShortCut('F9');
    OnClick := mniViewToolWindowsClick;
  end;
  with mniMacroManager do
  begin
    Name := 'mniMacroManager';
    Caption := sMacroManager;
    HelpContext := 34000;
    Hint := sMacroManager;
    OnClick := mniMacroManagerClick;
    ResourceName := 'IMG_MACRORECORD';
    NumGlyphs := 4;
  end;
  with mniPBForthConsole do
  begin
    Name := 'mniPBForthConsole';
    Caption := spbForthConsole;
    HelpContext := 32000;
    Hint := spbForthConsole;
    ShortCut := 113;
    OnClick := mniPBForthConsoleClick;
    ResourceName := 'IMG_FORTHCONSOLE';
    NumGlyphs := 4;
  end;
  with mniWindowList do
  begin
    Name := 'mniWindowList';
    Caption := sWindowList + '...';
    HelpContext := 45000;
    Hint := sWindowList;
    ShortCut := 32816;
    OnClick := mniWindowListClick;
    ResourceName := 'IMG_WINDOWLIST';
    NumGlyphs := 4;
  end;
  with N18 do
  begin
    Name := 'N18';
    Caption := '-';
  end;
  with mniToolbars do
  begin
    Name := 'mniToolbars';
    Caption := sToolbarsMenu;
  end;
  with mniFileToolbar1 do
  begin
    Name := 'mniFileToolbar1';
    Action := actFileToolbar;
  end;
  with mniSearchToolbar1 do
  begin
    Name := 'mniSearchToolbar1';
    Action := actSearchToolbar;
  end;
  with mniCompileToolbar1 do
  begin
    Name := 'mniCompileToolbar1';
    Action := actCompileToolbar;
  end;
  with mniHelpToolbar1 do
  begin
    Name := 'mniHelpToolbar1';
    Action := actHelpToolbar;
  end;
  with mniEditToolbar1 do
  begin
    Name := 'mniEditToolbar1';
    Action := actEditToolbar;
  end;
  with mniToolsToolbar1 do
  begin
    Name := 'mniToolsToolbar1';
    Action := actToolsToolbar;
  end;
  with mniCompile do
  begin
    Name := 'mniCompile';
    Caption := sCompileMenu;
    GroupIndex := 4;
    OnClick := mniCompileClick;
  end;
  with mniCompileProgram do
  begin
    Name := 'mniCompileProgram';
    Action := actCompileCompile;
  end;
  with mniDownload do
  begin
    Name := 'mniDownload';
    Action := actCompileDownload;
  end;
  with mniDownloadandRun do
  begin
    Name := 'mniDownloadandRun';
    Action := actCompileDownloadRun;
    ResourceName := 'IMG_DOWNLOADRUN';
    NumGlyphs := 4;
  end;
  with mniProgramNumber do
  begin
    Name := 'mniProgramNumber';
    Caption := sProgramNumberMenu;
    HelpContext := 10;
  end;
  with mniProgram1 do
  begin
    Name := 'mniProgram1';
    Caption := sProgram + ' &1';
    Checked := True;
    GroupIndex := 1;
    RadioItem := True;
    OnClick := mniProgram1Click;
  end;
  with mniProgram2 do
  begin
    Name := 'mniProgram2';
    Tag := 1;
    Caption := sProgram + ' &2';
    GroupIndex := 1;
    RadioItem := True;
    OnClick := mniProgram1Click;
  end;
  with mniProgram3 do
  begin
    Name := 'mniProgram3';
    Tag := 2;
    Caption := sProgram + ' &3';
    GroupIndex := 1;
    RadioItem := True;
    OnClick := mniProgram1Click;
  end;
  with mniProgram4 do
  begin
    Name := 'mniProgram4';
    Tag := 3;
    Caption := sProgram + ' &4';
    GroupIndex := 1;
    RadioItem := True;
    OnClick := mniProgram1Click;
  end;
  with mniProgram5 do
  begin
    Name := 'mniProgram5';
    Tag := 4;
    Caption := sProgram + ' &5';
    GroupIndex := 1;
    RadioItem := True;
    OnClick := mniProgram1Click;
  end;
  with mniProgram6 do
  begin
    Name := 'mniProgram6';
    Tag := 5;
    Caption := sProgram + ' &6';
    GroupIndex := 1;
    RadioItem := True;
    OnClick := mniProgram1Click;
  end;
  with mniProgram7 do
  begin
    Name := 'mniProgram7';
    Tag := 6;
    Caption := sProgram + ' &7';
    GroupIndex := 1;
    RadioItem := True;
    OnClick := mniProgram1Click;
  end;
  with mniProgram8 do
  begin
    Name := 'mniProgram8';
    Tag := 7;
    Caption := sProgram + ' &8';
    GroupIndex := 1;
    RadioItem := True;
    OnClick := mniProgram1Click;
  end;
  with N15 do
  begin
    Name := 'N15';
    Caption := '-';
  end;
  with mniRun do
  begin
    Name := 'mniRun';
    Action := actCompileRun;
    GroupIndex := 1;
  end;
  with mniStop do
  begin
    Name := 'mniStop';
    Action := actCompileStop;
//    GroupIndex := 1;
  end;
  with mniPause do
  begin
    Name := 'mniPause';
    Action := actCompilePause;
//    GroupIndex := 1;
  end;
  with mniSingleStep do
  begin
    Name := 'mniSingleStep';
    Action := actCompileSingleStep;
//    GroupIndex := 1;
  end;
  with mniStepOver do
  begin
    Name := 'mniStepOver';
    Action := actCompileStepOver;
//    GroupIndex := 1;
  end;
  with mniTraceInto do
  begin
    Name := 'mniTraceInto';
    Action := actCompileTraceInto;
//    GroupIndex := 1;
  end;
  with mniRunUntilReturn do
  begin
    Name := 'mniRunUntilReturn';
    Action := actCompileStepOut;
//    GroupIndex := 1;
  end;
  with mniRunToCursor do
  begin
    Name := 'mniRunToCursor';
    Action := actCompileRunToCursor;
//    GroupIndex := 1;
  end;
  with mniTraceToLine do
  begin
    Name := 'mniTraceToLine';
    Action := actCompileTraceToLine;
//    GroupIndex := 1;
  end;
  with mniCompSep do
  begin
    Name := 'mniCompSep';
    Caption := '-';
//    GroupIndex := 1;
  end;
  with mniTools do
  begin
    Name := 'mniTools';
    Caption := sToolsMenu;
    GroupIndex := 5;
    OnClick := mniToolsClick;
  end;
  with mniDirectControl do
  begin
    Name := 'mniDirectControl';
    Action := actToolsDirect;
  end;
  with mniDiagnose do
  begin
    Name := 'mniDiagnose';
    Action := actToolsDiag;
  end;
  with mniWatch do
  begin
    Name := 'mniWatch';
    Action := actToolsWatch;
  end;
  with mniRCXPiano do
  begin
    Name := 'mniRCXPiano';
    Action := actToolsPiano;
  end;
  with mniRCXJoystick do
  begin
    Name := 'mniRCXJoystick';
    Action := actToolsJoystick;
  end;
  with mniRemote do
  begin
    Name := 'mniRemote';
    Action := actToolsRemote;
  end;
  with mniNewWatch do
  begin
    Name := 'mniNewWatch';
    Action := actToolsNewWatch;
    HelpContext := 36000;
  end;
  with mniSetvalues do
  begin
    Name := 'mniSetvalues';
    Action := actToolsSetValues;
    HelpContext := 41000;
  end;
  with mniSpybotEEPROM do
  begin
    Name := 'mniSpybotEEPROM';
    Action := actToolsSpybotEEPROM;
    HelpContext := 42000;
  end;
  with mniNXTExplorer do
  begin
    Name := 'mniNXTExplorer';
    Action := actToolsNXTExplorer;
  end;
  with mniNXTScreen do
  begin
    Name := 'mniNXTScreen';
    Action := actToolsNXTScreen;
  end;
  with mniSyncMotors do
  begin
    Name := 'mniSyncMotors';
    Action := actToolsSyncMotors;
    Visible := False;
  end;
  with N7 do
  begin
    Name := 'N7';
    Caption := '-';
  end;
  with mniSendMessage do
  begin
    Name := 'mniSendMessage';
    Action := actToolsSendMsg;
  end;
  with mniDatalog do
  begin
    Name := 'mniDatalog';
    Action := actToolsDatalog;
  end;
  with mniMemoryMap do
  begin
    Name := 'mniMemoryMap';
    Action := actToolsMemory;
  end;
  with mniClearMemory do
  begin
    Name := 'mniClearMemory';
    Action := actToolsClearMem;
    ResourceName := 'IMG_CLEARMEM';
    NumGlyphs := 4;
  end;
  with mniMIDIConversion do
  begin
    Name := 'mniMIDIConversion';
    Action := actToolsMIDI;
    HelpContext := 35000;
    ResourceName := 'IMG_MIDICONVERT';
    NumGlyphs := 4;
  end;
  with mniSoundConvert do
  begin
    Name := 'mniSoundConvert';
    Action := actToolsWav2Rso;
    ResourceName := 'IMG_SOUNDCONVERT';
    NumGlyphs := 4;
  end;
  with N9 do
  begin
    Name := 'N9';
    Caption := '-';
  end;
  with mniFindRCX do
  begin
    Name := 'mniFindRCX';
    Action := actToolsFindBrick;
  end;
  with mniTurnRCXOff do
  begin
    Name := 'mniTurnRCXOff';
    Action := actToolsTurnBrickOff;
  end;
  with mniCloseComm do
  begin
    Name := 'mniCloseComm';
    Action := actToolsCloseComm;
  end;
  with N3 do
  begin
    Name := 'N3';
    Caption := '-';
  end;
  with mniFirmware do
  begin
    Name := 'mniFirmware';
    Action := actToolsFirmware;
    ResourceName := 'IMG_FIRMWARE';
    NumGlyphs := 4;
  end;
  with mniUnlockFirmware do
  begin
    Name := 'mniUnlockFirmware';
    Action := actToolsUnlockFirm;
    ResourceName := 'IMG_UNLOCK';
    NumGlyphs := 4;
  end;
  with mniConfigureTools do
  begin
    Name := 'mniConfigureTools';
    Action := actToolsConfigureTools;
    HelpContext := 44000;
    ResourceName := 'IMG_CFGTOOLS';
    NumGlyphs := 4;
  end;
  with N4 do
  begin
    Name := 'N4';
    Caption := '-';
  end;
  with mniBrickOS do
  begin
    Name := 'mniBrickOS';
    Caption := sbrickOSMenu;
    GroupIndex := 5;
  end;
  with mniSetLNPAddress do
  begin
    Name := 'mniSetLNPAddress';
    Caption := sSetLNPAddress;
    HelpContext := 40000;
    OnClick := mniSetLNPAddressClick;
  end;
  with mniDownloadAddress do
  begin
    Name := 'mniDownloadAddress';
    Caption := sLNPAddress;
  end;
  with mniAddress0 do
  begin
    Name := 'mniAddress0';
    Caption := sAddress + ' 0x&0';
    Checked := True;
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniAddress1 do
  begin
    Name := 'mniAddress1';
    Tag := 1;
    Caption := sAddress + ' 0x&1';
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniAddress2 do
  begin
    Name := 'mniAddress2';
    Tag := 2;
    Caption := sAddress + ' 0x&2';
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniAddress3 do
  begin
    Name := 'mniAddress3';
    Tag := 3;
    Caption := sAddress + ' 0x&3';
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniAddress4 do
  begin
    Name := 'mniAddress4';
    Tag := 4;
    Caption := sAddress + ' 0x&4';
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniAddress5 do
  begin
    Name := 'mniAddress5';
    Tag := 5;
    Caption := sAddress + ' 0x&5';
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniAddress6 do
  begin
    Name := 'mniAddress6';
    Tag := 6;
    Caption := sAddress + ' 0x&6';
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniAddress7 do
  begin
    Name := 'mniAddress7';
    Tag := 7;
    Caption := sAddress + ' 0x&7';
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniAddress8 do
  begin
    Name := 'mniAddress8';
    Tag := 8;
    Caption := sAddress + ' 0x&8';
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniAddress9 do
  begin
    Name := 'mniAddress9';
    Tag := 9;
    Caption := sAddress + ' 0x&9';
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniAddress10 do
  begin
    Name := 'mniAddress10';
    Tag := 10;
    Caption := sAddress + ' 0x&a';
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniAddress11 do
  begin
    Name := 'mniAddress11';
    Tag := 11;
    Caption := sAddress + ' 0x&b';
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniAddress12 do
  begin
    Name := 'mniAddress12';
    Tag := 12;
    Caption := sAddress + ' 0x&c';
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniAddress13 do
  begin
    Name := 'mniAddress13';
    Tag := 13;
    Caption := sAddress + ' 0x&d';
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniAddress14 do
  begin
    Name := 'mniAddress14';
    Tag := 14;
    Caption := sAddress + ' 0x&e';
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniAddress15 do
  begin
    Name := 'mniAddress15';
    Tag := 15;
    Caption := sAddress + ' 0x&f';
    RadioItem := True;
    OnClick := mniAddress0Click;
  end;
  with mniLNPPort do
  begin
    Name := 'mniLNPPort';
    Caption := sLNPPort;
  end;
  with mniPort0 do
  begin
    Name := 'mniPort0';
    Caption := sPort + ' 0x&0';
    Checked := True;
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniPort1 do
  begin
    Name := 'mniPort1';
    Tag := 1;
    Caption := sPort + ' 0x&1';
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniPort2 do
  begin
    Name := 'mniPort2';
    Tag := 2;
    Caption := sPort + ' 0x&2';
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniPort3 do
  begin
    Name := 'mniPort3';
    Tag := 3;
    Caption := sPort + ' 0x&3';
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniPort4 do
  begin
    Name := 'mniPort4';
    Tag := 4;
    Caption := sPort + ' 0x&4';
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniPort5 do
  begin
    Name := 'mniPort5';
    Tag := 5;
    Caption := sPort + ' 0x&5';
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniPort6 do
  begin
    Name := 'mniPort6';
    Tag := 6;
    Caption := sPort + ' 0x&6';
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniPort7 do
  begin
    Name := 'mniPort7';
    Tag := 7;
    Caption := sPort + ' 0x&7';
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniPort8 do
  begin
    Name := 'mniPort8';
    Tag := 8;
    Caption := sPort + ' 0x&8';
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniPort9 do
  begin
    Name := 'mniPort9';
    Tag := 9;
    Caption := sPort + ' 0x&9';
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniPort10 do
  begin
    Name := 'mniPort10';
    Tag := 10;
    Caption := sPort + ' 0x&a';
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniPort11 do
  begin
    Name := 'mniPort11';
    Tag := 11;
    Caption := sPort + ' 0x&b';
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniPort12 do
  begin
    Name := 'mniPort12';
    Tag := 12;
    Caption := sPort + ' 0x&c';
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniPort13 do
  begin
    Name := 'mniPort13';
    Tag := 13;
    Caption := sPort + ' 0x&d';
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniPort14 do
  begin
    Name := 'mniPort14';
    Tag := 14;
    Caption := sPort + ' 0x&e';
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniPort15 do
  begin
    Name := 'mniPort15';
    Tag := 15;
    Caption := sPort + ' 0x&f';
    RadioItem := True;
    OnClick := mniPort0Click;
  end;
  with mniWindow do
  begin
    Name := 'mniWindow';
    Caption := sWindowMenu;
    GroupIndex := 6;
    OnClick := mniWindowClick;
  end;
  with mniTileHorizontal do
  begin
    Name := 'mniTileHorizontal';
    Caption := sTileHorizontal;
    OnClick := mniTileHorizontalClick;
    ResourceName := 'IMG_TILEHORZ';
    NumGlyphs := 4;
  end;
  with mniTileVertical do
  begin
    Name := 'mniTileVertical';
    Caption := sTileVertical;
    OnClick := mniTileVerticalClick;
    ResourceName := 'IMG_TILEVERT';
    NumGlyphs := 4;
  end;
  with mniCascade do
  begin
    Name := 'mniCascade';
    Caption := sCascade;
    OnClick := mniCascadeClick;
    ResourceName := 'IMG_CASCADE';
    NumGlyphs := 4;
  end;
  with mniArrange do
  begin
    Name := 'mniArrange';
    Caption := sArrangeIcons;
    OnClick := mniArrangeClick;
  end;
  with N10 do
  begin
    Name := 'N10';
    Caption := '-';
  end;
  with mniPositions do
  begin
    Name := 'mniPositions';
    Caption := sPositionsMenu;
  end;
  with mniPosSave do
  begin
    Name := 'mniPosSave';
    Caption := sSave + '...';
    OnClick := mniPosSaveClick;
  end;
  with mniPosLoad do
  begin
    Name := 'mniPosLoad';
    Caption := sLoad + '...';
    OnClick := mniPosLoadClick;
  end;
  with mniHelp do
  begin
    Name := 'mniHelp';
    Caption := sHelpMenu;
    GroupIndex := 7;
  end;
  with mniContents do
  begin
    Name := 'mniContents';
    Action := actHelpHelp;
  end;
  with mniIndex do
  begin
    Name := 'mniIndex';
    Caption := sIndex;
    OnClick := IndexClick;
  end;
  with mniNqcGuide do
  begin
    Name := 'mniNqcGuide';
    Caption := sNQCGuide;
    OnClick := mniNqcGuideClick;
  end;
  with mniHowTo do
  begin
    Name := 'mniHowTo';
    Caption := sHowToUseHelp;
    OnClick := mniHowToClick;
  end;
  with N5 do
  begin
    Name := 'N5';
    Caption := '-';
  end;
  with mniWebpage do
  begin
    Name := 'mniWebpage';
    Caption := sWebPage;
    OnClick := mniWebpageClick;
  end;
  with mniGuidePDFs do
  begin
    Name := 'mniGuidePDFs';
    Caption := sGuidePDFs;
  end;
  with mniNXCGuidePDF do
  begin
    Name := 'mniNXCGuidePDF';
    Action := actHelpNXCGuidePDF;
  end;
  with mniNQCGuidePDF do
  begin
    Name := 'mniNQCGuidePDF';
    Action := actHelpNQCGuidePDF;
  end;
  with mniNBCGuidePDF do
  begin
    Name := 'mniNBCGuidePDF';
    Action := actHelpNBCGuidePDF;
  end;
  with mniTutorialPDFs do
  begin
    Name := 'mniTutorialPDFs';
    Caption := sTutorialPDFs;
  end;
  with mniNXCTutorialPDF do
  begin
    Name := 'mniNXCTutorialPDF';
    Action := actHelpNXCTutorialPDF;
  end;
  with mniNQCTutorialPDF do
  begin
    Name := 'mniNQCTutorialPDF';
    Action := actHelpNQCTutorialPDF;
  end;
  with mniNBCTutorialPDF do
  begin
    Name := 'mniNBCTutorialPDF';
    Action := actHelpNBCTutorialPDF;
  end;
  with N14 do
  begin
    Name := 'N14';
    Caption := '-';
  end;
  with mniAbout do
  begin
    Name := 'mniAbout';
    Action := actHelpInfo;
  end;

  // create popup menus also
  mnuToolbars := TOfficePopupMenu.Create(Self);
  mnuToolbars.Name := 'mnuToolbars';
  mniFileToolbar := TOfficeMenuItem.Create(mnuToolbars);
  mniSearchToolbar := TOfficeMenuItem.Create(mnuToolbars);
  mniCompileToolbar := TOfficeMenuItem.Create(mnuToolbars);
  mniHelpToolbar := TOfficeMenuItem.Create(mnuToolbars);
  mniEditToolbar := TOfficeMenuItem.Create(mnuToolbars);
  mniToolsToolbar := TOfficeMenuItem.Create(mnuToolbars);
  mnuToolbars.Items.Add([mniFileToolbar, mniSearchToolbar, mniCompileToolbar,
                         mniHelpToolbar, mniEditToolbar, mniToolsToolbar]);
  with mniFileToolbar do
  begin
    Name := 'mniFileToolbar';
    Action := actFileToolbar;
  end;
  with mniSearchToolbar do
  begin
    Name := 'mniSearchToolbar';
    Action := actSearchToolbar;
  end;
  with mniCompileToolbar do
  begin
    Name := 'mniCompileToolbar';
    Action := actCompileToolbar;
  end;
  with mniHelpToolbar do
  begin
    Name := 'mniHelpToolbar';
    Action := actHelpToolbar;
  end;
  with mniEditToolbar do
  begin
    Name := 'mniEditToolbar';
    Action := actEditToolbar;
  end;
  with mniToolsToolbar do
  begin
    Name := 'mniToolsToolbar';
    Action := actToolsToolbar;
  end;
  // page control popup menu
  mnuPageControl := TOfficePopupMenu.Create(Self);
  mnuPageControl.Name := 'mnuPageControl';
  pagMain.PopupMenu := mnuPageControl;
  mniTabClose := TOfficeMenuItem.Create(mnuPageControl);
  mniTabCloseAll := TOfficeMenuItem.Create(mnuPageControl);
  N17 := TOfficeMenuItem.Create(mnuPageControl);
  mniNextWindow := TOfficeMenuItem.Create(mnuPageControl);
  mnuPageControl.Items.Add([mniTabClose, mniTabCloseAll, N17, mniNextWindow]);
  with mniTabClose do
  begin
    Name := 'mniTabClose';
    Action := actFileClose;
  end;
  with mniTabCloseAll do
  begin
    Name := 'mniTabCloseAll';
    Action := actFileCloseAll;
  end;
  with N17 do
  begin
    Name := 'N17';
    Caption := '-';
  end;
  with mniNextWindow do
  begin
    Name := 'mniNextWindow';
    Caption := sNextWindow;
    ShortCut := 16393;
    OnClick := mniNextWindowClick;
  end;
end;

procedure TMainForm.CreateToolbars;
begin
  // create the toolbar container panel
  cbrTop := TOfficeControlBar.Create(Self);
  with cbrTop do
  begin
    Name := 'cbrTop';
    Parent := Self;
    Left := 0;
    Top := 0;
    Width := 584;
    Height := 54;
    Align := alTop;
    Color := clBtnFace;
    PopupMenu := mnuToolbars;
    TabOrder := 1;
    OnDockOver := cbrTopDockOver;
    OnMouseDown := BarMouseDown;
    OnMouseMove := BarMouseMove;
    BorderColor := clBlack;
  end;
  // now create the toolbars
  CreateFileToolbar;
  CreateSearchToolbar;
  CreateCompileToolbar;
  CreateHelpToolbar;
  CreateToolsToolbar;
  CreateEditToolbar;
end;

procedure TMainForm.CreateToolsToolbar;
begin
  // create tools toolbar first
  ogpTools := TOfficeGradientPanel.Create(Self);
  with ogpTools do
  begin
    Name := 'ogpTools';
    Parent := cbrTop;
    Caption := '';
    Left := 202;
    Top := 28;
    Width := 364;
    Height := 22;
    GradientFrom := clBtnFace;
    GradientTo := clBtnFace;
    BorderColor := clBlack;
    Horizontal := False;
    Constraints.MinWidth := 22;
    TabOrder := 5;
  end;
  // now create tools toolbar buttons
  osbCloseComm := TOfficeSpeedButton.Create(Self);
  osbTurnBrickOff := TOfficeSpeedButton.Create(Self);
  osbFindBrick := TOfficeSpeedButton.Create(Self);
  bvlSep6 := TBevel.Create(Self);
  osbMemoryMap := TOfficeSpeedButton.Create(Self);
  osbDatalog := TOfficeSpeedButton.Create(Self);
  osbSendMessage := TOfficeSpeedButton.Create(Self);
  bvlSep5 := TBevel.Create(Self);
  osbSpybotEEPROM := TOfficeSpeedButton.Create(Self);
  osbSetValues := TOfficeSpeedButton.Create(Self);
  osbNewWatch := TOfficeSpeedButton.Create(Self);
  osbRemote := TOfficeSpeedButton.Create(Self);
  osbJoystick := TOfficeSpeedButton.Create(Self);
  osbPiano := TOfficeSpeedButton.Create(Self);
  osbWatch := TOfficeSpeedButton.Create(Self);
  osbDiagnostics := TOfficeSpeedButton.Create(Self);
  osbDirectControl := TOfficeSpeedButton.Create(Self);
  with osbCloseComm do
  begin
    Name := 'osbCloseComm';
    Parent := ogpTools;
    Left := 338;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actToolsCloseComm;
    MenuItem := mniCloseComm;
    ResourceName := 'IMG_CLOSECOMM';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbTurnBrickOff do
  begin
    Name := 'osbTurnBrickOff';
    Parent := ogpTools;
    Left := 315;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actToolsTurnBrickOff;
    MenuItem := mniTurnRCXOff;
    ResourceName := 'IMG_TURNOFF';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbFindBrick do
  begin
    Name := 'osbFindBrick';
    Parent := ogpTools;
    Left := 292;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actToolsFindBrick;
    MenuItem := mniFindRCX;
    ResourceName := 'IMG_FINDBRICK';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with bvlSep6 do
  begin
    Name := 'bvlSep6';
    Parent := ogpTools;
    Left := 284;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with osbMemoryMap do
  begin
    Name := 'osbMemoryMap';
    Parent := ogpTools;
    Left := 261;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actToolsMemory;
    MenuItem := mniMemoryMap;
    ResourceName := 'IMG_MEMMAP';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbDatalog do
  begin
    Name := 'osbDatalog';
    Parent := ogpTools;
    Left := 238;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actToolsDatalog;
    MenuItem := mniDatalog;
    ResourceName := 'IMG_DATALOG';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbSendMessage do
  begin
    Name := 'osbSendMessage';
    Parent := ogpTools;
    Left := 215;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actToolsSendMsg;
    MenuItem := mniSendMessage;
    ResourceName := 'IMG_SENDMSG';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with bvlSep5 do
  begin
    Name := 'bvlSep5';
    Parent := ogpTools;
    Left := 207;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with osbSpybotEEPROM do
  begin
    Name := 'osbSpybotEEPROM';
    Parent := ogpTools;
    Left := 184;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actToolsSpybotEEPROM;
    MenuItem := mniSpybotEEPROM;
    ResourceName := 'IMG_SPYEEPROM';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbSetValues do
  begin
    Name := 'osbSetValues';
    Parent := ogpTools;
    Left := 161;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actToolsSetValues;
    MenuItem := mniSetvalues;
    ResourceName := 'IMG_SETVALUES';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbNewWatch do
  begin
    Name := 'osbNewWatch';
    Parent := ogpTools;
    Left := 138;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actToolsNewWatch;
    MenuItem := mniNewWatch;
    ResourceName := 'IMG_NEWWATCH';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbRemote do
  begin
    Name := 'osbRemote';
    Parent := ogpTools;
    Left := 115;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actToolsRemote;
    MenuItem := mniRemote;
    ResourceName := 'IMG_REMOTE';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbJoystick do
  begin
    Name := 'osbJoystick';
    Parent := ogpTools;
    Left := 92;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actToolsJoystick;
    MenuItem := mniRCXJoystick;
    ResourceName := 'IMG_JOYSTICK';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbPiano do
  begin
    Name := 'osbPiano';
    Parent := ogpTools;
    Left := 69;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actToolsPiano;
    MenuItem := mniRCXPiano;
    ResourceName := 'IMG_PIANO';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbWatch do
  begin
    Name := 'osbWatch';
    Parent := ogpTools;
    Left := 46;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actToolsWatch;
    MenuItem := mniWatch;
    ResourceName := 'IMG_WATCH';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbDiagnostics do
  begin
    Name := 'osbDiagnostics';
    Parent := ogpTools;
    Left := 23;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actToolsDiag;
    MenuItem := mniDiagnose;
    ResourceName := 'IMG_DIAGNOSTICS';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbDirectControl do
  begin
    Name := 'osbDirectControl';
    Parent := ogpTools;
    Left := 0;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actToolsDirect;
    MenuItem := mniDirectControl;
    ResourceName := 'IMG_DIRECTCTRL';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
end;

procedure TMainForm.CreateCompileToolbar;
begin
  ogpCompile := TOfficeGradientPanel.Create(Self);
  with ogpCompile do
  begin
    Name := 'ogpCompile';
    Parent := cbrTop;
    Caption := '';
    Left := 308;
    Top := 2;
    Width := 198;
    Height := 22;
    GradientFrom := clBtnFace;
    GradientTo := clBtnFace;
    BorderColor := clBlack;
    Horizontal := False;
    Constraints.MinWidth := 82;
    TabOrder := 2;
  end;
  osbCompileBtn := TOfficeSpeedButton.Create(Self);
  osbDownloadBtn := TOfficeSpeedButton.Create(Self);
  bvlSep1 := TBevel.Create(Self);
  pnlProgBox := TPanel.Create(Self);
  ProgramBox := TComboBox.Create(Self);
  bvlSep2 := TBevel.Create(Self);
  osbRunBtn := TOfficeSpeedButton.Create(Self);
  osbStopBtn := TOfficeSpeedButton.Create(Self);
  with osbCompileBtn do
  begin
    Name := 'osbCompileBtn';
    Parent := ogpCompile;
    Left := 0;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actCompileCompile;
    MenuItem := mniCompileProgram;
    ResourceName := 'IMG_COMPILE';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbDownloadBtn do
  begin
    Name := 'osbDownloadBtn';
    Parent := ogpCompile;
    Left := 23;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actCompileDownload;
    MenuItem := mniDownload;
    ResourceName := 'IMG_DOWNLOAD';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with bvlSep1 do
  begin
    Name := 'bvlSep1';
    Parent := ogpCompile;
    Left := 46;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with pnlProgBox do
  begin
    Name := 'pnlProgBox';
    Parent := ogpCompile;
    Left := 54;
    Top := 0;
    Width := 88;
    Height := 22;
    Align := alLeft;
    AutoSize := True;
    BevelOuter := bvNone;
    Caption := '';
    TabOrder := 0;
  end;
  with ProgramBox do
  begin
    Name := 'ProgramBox';
    Parent := pnlProgBox;
    Left := 0;
    Top := 0;
    Width := 88;
    Height := 21;
    Hint := 'Select program';
    Style := csDropDownList;
    Ctl3D := False;
    ItemHeight := 13;
    ParentCtl3D := False;
    TabOrder := 0;
    OnChange := ProgramBoxChange;
    Items.Clear;
    Items.Add('Program 1');
    Items.Add('Program 2');
    Items.Add('Program 3');
    Items.Add('Program 4');
    Items.Add('Program 5');
  end;
  with bvlSep2 do
  begin
    Name := 'bvlSep2';
    Parent := ogpCompile;
    Left := 142;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with osbRunBtn do
  begin
    Name := 'osbRunBtn';
    Parent := ogpCompile;
    Left := 150;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actCompileRun;
    MenuItem := mniRun;
    ResourceName := 'IMG_RUN';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbStopBtn do
  begin
    Name := 'osbStopBtn';
    Parent := ogpCompile;
    Left := 175;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actCompileStop;
    MenuItem := mniStop;
    ResourceName := 'IMG_STOP';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
end;

procedure TMainForm.CreateEditToolbar;
begin
  ogpEdit := TOfficeGradientPanel.Create(Self);
  with ogpEdit do
  begin
    Name := 'ogpEdit';
    Parent := cbrTop;
    Caption := '';
    Left := 11;
    Top := 28;
    Width := 178;
    Height := 22;
    GradientFrom := clBtnFace;
    GradientTo := clBtnFace;
    BorderColor := clBlack;
    Horizontal := False;
    Constraints.MinWidth := 22;
    TabOrder := 4;
  end;
  // now create edit toolbar buttons
  osbPreferences := TOfficeSpeedButton.Create(Self);
  bvlSep4 := TBevel.Create(Self);
  osbDelete := TOfficeSpeedButton.Create(Self);
  osbPaste := TOfficeSpeedButton.Create(Self);
  osbCopy := TOfficeSpeedButton.Create(Self);
  osbCut := TOfficeSpeedButton.Create(Self);
  bvlSep3 := TBevel.Create(Self);
  osbRedo := TOfficeSpeedButton.Create(Self);
  osbUndo := TOfficeSpeedButton.Create(Self);
  with osbPreferences do
  begin
    Name := 'osbPreferences';
    Parent := ogpEdit;
    Left := 154;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actEditPreferences;
    MenuItem := mniPreferences;
    ResourceName := 'IMG_PREFS';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with bvlSep4 do
  begin
    Name := 'bvlSep4';
    Parent := ogpEdit;
    Left := 146;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with osbDelete do
  begin
    Name := 'osbDelete';
    Parent := ogpEdit;
    Left := 123;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actEditDelete;
    MenuItem := mniDelete;
    ResourceName := 'IMG_DELETE';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbPaste do
  begin
    Name := 'osbPaste';
    Parent := ogpEdit;
    Left := 100;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actEditPaste;
    MenuItem := mniPaste;
    ResourceName := 'IMG_PASTE';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbCopy do
  begin
    Name := 'osbCopy';
    Parent := ogpEdit;
    Left := 77;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actEditCopy;
    MenuItem := mniCopy;
    ResourceName := 'IMG_COPY';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbCut do
  begin
    Name := 'osbCut';
    Parent := ogpEdit;
    Left := 54;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actEditCut;
    MenuItem := mniCut;
    ResourceName := 'IMG_CUT';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with bvlSep3 do
  begin
    Name := 'bvlSep3';
    Parent := ogpEdit;
    Left := 46;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with osbRedo do
  begin
    Name := 'osbRedo';
    Parent := ogpEdit;
    Left := 23;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actEditRedo;
    MenuItem := mniRedo;
    ResourceName := 'IMG_REDO';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbUndo do
  begin
    Name := 'osbUndo';
    Parent := ogpEdit;
    Left := 0;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actEditUndo;
    MenuItem := mniUndo;
    ResourceName := 'IMG_UNDO';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
end;

procedure TMainForm.CreateFileToolbar;
begin
  ogpFile := TOfficeGradientPanel.Create(Self);
  with ogpFile do
  begin
    Name := 'ogpFile';
    Parent := cbrTop;
    Caption := '';
    Left := 11;
    Top := 2;
    Width := 170;
    Height := 22;
    GradientFrom := clBtnFace;
    GradientTo := clBtnFace;
    BorderColor := clBlack;
    Horizontal := False;
    Constraints.MinWidth := 22;
    ParentShowHint := False;
    ShowHint := True;
    TabOrder := 0;
  end;
  osbNew := TOfficeSpeedButton.Create(Self);
  osbOpen := TOfficeSpeedButton.Create(Self);
  osbSave := TOfficeSpeedButton.Create(Self);
  osbClose := TOfficeSpeedButton.Create(Self);
  osbCloseAll := TOfficeSpeedButton.Create(Self);
  bvlFile2 := TBevel.Create(Self);
  osbPreview := TOfficeSpeedButton.Create(Self);
  osbPrint := TOfficeSpeedButton.Create(Self);
  with osbNew do
  begin
    Name := 'osbNew';
    Parent := ogpFile;
    Left := 0;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileNew;
    MenuItem := mniNew;
    ResourceName := 'IMG_NEW';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbOpen do
  begin
    Name := 'osbOpen';
    Parent := ogpFile;
    Left := 23;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileOpen;
    MenuItem := mniOpen;
    ResourceName := 'IMG_OPEN';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbSave do
  begin
    Name := 'osbSave';
    Parent := ogpFile;
    Left := 46;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileSave;
    MenuItem := mniSave;
    ResourceName := 'IMG_SAVE';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbClose do
  begin
    Name := 'osbClose';
    Parent := ogpFile;
    Left := 69;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileClose;
    MenuItem := mniClose;
    ResourceName := 'IMG_CLOSE';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbCloseAll do
  begin
    Name := 'osbCloseAll';
    Parent := ogpFile;
    Left := 92;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileCloseAll;
    MenuItem := mniCloseAll;
    ResourceName := 'IMG_CLOSEALL';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with bvlFile2 do
  begin
    Name := 'bvlFile2';
    Parent := ogpFile;
    Left := 115;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with osbPreview do
  begin
    Name := 'osbPreview';
    Parent := ogpFile;
    Left := 123;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFilePrintPreview;
    MenuItem := mniPrintPreview;
    ResourceName := 'IMG_PREVIEW';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbPrint do
  begin
    Name := 'osbPrint';
    Parent := ogpFile;
    Left := 146;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFilePrint;
    MenuItem := mniPrint;
    ResourceName := 'IMG_PRINT';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
end;

procedure TMainForm.CreateHelpToolbar;
begin
  ogpHelp := TOfficeGradientPanel.Create(Self);
  with ogpHelp do
  begin
    Name := 'ogpHelp';
    Parent := cbrTop;
    Caption := '';
    Left := 519;
    Top := 2;
    Width := 47;
    Height := 22;
    GradientFrom := clBtnFace;
    GradientTo := clBtnFace;
    BorderColor := clBlack;
    Horizontal := False;
    Constraints.MinHeight := 22;
    Constraints.MinWidth := 22;
    TabOrder := 0;
  end;
  osbContents := TOfficeSpeedButton.Create(Self);
  osbInfo := TOfficeSpeedButton.Create(Self);
  with osbContents do
  begin
    Name := 'osbContents';
    Parent := ogpHelp;
    Left := 23;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actHelpHelp;
    MenuItem := mniContents;
    ResourceName := 'IMG_HELP';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbInfo do
  begin
    Name := 'osbInfo';
    Parent := ogpHelp;
    Left := 0;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actHelpInfo;
    MenuItem := mniAbout;
    ResourceName := 'IMG_ABOUT';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
end;

procedure TMainForm.CreateSearchToolbar;
begin
  ogpSearch := TOfficeGradientPanel.Create(Self);
  with ogpSearch do
  begin
    Name := 'ogpSearch';
    Parent := cbrTop;
    Caption := '';
    Left := 194;
    Top := 2;
    Width := 101;
    Height := 22;
    GradientFrom := clBtnFace;
    GradientTo := clBtnFace;
    BorderColor := clBlack;
    Horizontal := False;
    Constraints.MinWidth := 22;
    TabOrder := 1;
  end;
  osbFind := TOfficeSpeedButton.Create(Self);
  osbReplace := TOfficeSpeedButton.Create(Self);
  bvlSearch := TBevel.Create(Self);
  osbGoto := TOfficeSpeedButton.Create(Self);
  osbProcList := TOfficeSpeedButton.Create(Self);
  with osbFind do
  begin
    Name := 'osbFind';
    Parent := ogpSearch;
    Left := 0;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actSearchFind;
    MenuItem := mniFind;
    ResourceName := 'IMG_FIND';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbReplace do
  begin
    Name := 'osbReplace';
    Parent := ogpSearch;
    Left := 23;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actSearchReplace;
    MenuItem := mniReplace;
    ResourceName := 'IMG_REPLACE';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with bvlSearch do
  begin
    Name := 'bvlSearch';
    Parent := ogpSearch;
    Left := 46;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with osbGoto do
  begin
    Name := 'osbGoto';
    Parent := ogpSearch;
    Left := 54;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actSearchGotoLine;
    MenuItem := mniGotoLineNumber;
    ResourceName := 'IMG_GOTOLINE';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbProcList do
  begin
    Name := 'osbProcList';
    Parent := ogpSearch;
    Left := 77;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actSearchProcList;
    MenuItem := mniProcedureList;
    ResourceName := 'IMG_PROCLIST';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
end;

procedure TMainForm.CreateCompPropComponents;
begin
  SynForthCompProp := TSynCompletionProposal.Create(Self);
  SynCppCompProp := TSynCompletionProposal.Create(Self);
  SynNQCCompProp := TSynCompletionProposal.Create(Self);
  SynNBCCompProp := TSynCompletionProposal.Create(Self);
  SynMindScriptCompProp := TSynCompletionProposal.Create(Self);
  SynLASMCompProp := TSynCompletionProposal.Create(Self);
  SynPasCompProp := TSynCompletionProposal.Create(Self);
  SynROPSCompProp := TSynCompletionProposal.Create(Self);
  scpParams := TSynCompletionProposal.Create(Self);
  SynNXCCompProp := TSynCompletionProposal.Create(Self);
  SynNPGCompProp := TSynCompletionProposal.Create(Self);
  SynRSCompProp := TSynCompletionProposal.Create(Self);
  with SynForthCompProp do
  begin
    Name := 'SynForthCompProp';
    Options := [scoAnsiStrings, scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText];
    ItemList.Clear;
    if FileExists(ProgramDir + 'Default\form_item.txt') then
      ItemList.LoadFromFile(ProgramDir + 'Default\form_item.txt');
    InsertList.Clear;
    if FileExists(ProgramDir + 'Default\form_insert.txt') then
      InsertList.LoadFromFile(ProgramDir + 'Default\form_insert.txt');
    Width := 262;
    EndOfTokenChr := '}';
    TriggerChars := '.';
    Title := 'Forth Words';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'Arial';
    Font.Style := [];
    TitleFont.Charset := ANSI_CHARSET;
    TitleFont.Color := clBtnText;
    TitleFont.Height := -11;
    TitleFont.Name := 'Arial';
    TitleFont.Style := [fsBold];
    with Columns.Add do begin 
      BiggestWord := 'CONSTRUCTOR';
    end;
    with Columns.Add do begin 
      BiggestWord := 'CONSTRUCTOR';
      DefaultFontStyle := [fsBold];
    end;
    with Columns.Add do begin 
      BiggestWord := 'CONSTRUCTOR';
    end;
    ParamSepString := ' ';
    ShortCut := 16416;
  end;
  with SynCppCompProp do
  begin
    Name := 'SynCppCompProp';
    Options := [scoAnsiStrings, scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText, scoEndCharCompletion];
    Width := 300;
    EndOfTokenChr := '()[]. ';
    TriggerChars := '.';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    TitleFont.Charset := DEFAULT_CHARSET;
    TitleFont.Color := clBtnText;
    TitleFont.Height := -11;
    TitleFont.Name := 'MS Sans Serif';
    TitleFont.Style := [fsBold];
    with Columns.Add do begin 
      BiggestWord := 'procedure';
    end;
    ParamSepString := ' ';
    ShortCut := 16416;
  end;
  with SynNQCCompProp do
  begin
    Name := 'SynNQCCompProp';
    Options := [scoAnsiStrings, scoLimitToMatchedText, scoEndCharCompletion];
    NbLinesInWindow := 6;
    Width := 262;
    EndOfTokenChr := '()[].';
    TriggerChars := '.';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    TitleFont.Charset := DEFAULT_CHARSET;
    TitleFont.Color := clBtnText;
    TitleFont.Height := -11;
    TitleFont.Name := 'MS Sans Serif';
    TitleFont.Style := [fsBold];
    ParamSepString := ' ';
    ShortCut := 16416;
  end;
  with SynNBCCompProp do
  begin
    Name := 'SynNBCCompProp';
    Options := [scoAnsiStrings, scoLimitToMatchedText, scoEndCharCompletion];
    NbLinesInWindow := 6;
    Width := 262;
    EndOfTokenChr := '()[].';
    TriggerChars := '.';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    TitleFont.Charset := ANSI_CHARSET;
    TitleFont.Color := clBtnText;
    TitleFont.Height := -11;
    TitleFont.Name := 'Arial';
    TitleFont.Style := [fsBold];
    ParamSepString := ' ';
    ShortCut := 16416;
  end;
  with SynMindScriptCompProp do
  begin
    Name := 'SynMindScriptCompProp';
    Options := [scoAnsiStrings, scoLimitToMatchedText, scoUseBuiltInTimer, scoEndCharCompletion];
    ItemList.Clear;
    ItemList.Add('');
    NbLinesInWindow := 6;
    Width := 262;
    EndOfTokenChr := '()[].';
    TriggerChars := '.';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    TitleFont.Charset := ANSI_CHARSET;
    TitleFont.Color := clBtnText;
    TitleFont.Height := -11;
    TitleFont.Name := 'Arial';
    TitleFont.Style := [fsBold];
    ParamSepString := ' ';
    OnExecute := SynMindScriptCompPropExecute;
    ShortCut := 16416;
  end;
  with SynLASMCompProp do
  begin
    Name := 'SynLASMCompProp';
    Options := [scoAnsiStrings, scoLimitToMatchedText];
    NbLinesInWindow := 6;
    Width := 262;
    EndOfTokenChr := '()[].';
    TriggerChars := '.';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    TitleFont.Charset := ANSI_CHARSET;
    TitleFont.Color := clBtnText;
    TitleFont.Height := -11;
    TitleFont.Name := 'Arial';
    TitleFont.Style := [fsBold];
    ParamSepString := ' ';
    ShortCut := 16416;
  end;
  with SynPasCompProp do
  begin
    Name := 'SynPasCompProp';
    Options := [scoAnsiStrings, scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText, scoEndCharCompletion];
    Width := 262;
    EndOfTokenChr := '()[]. ';
    TriggerChars := '.';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    TitleFont.Charset := DEFAULT_CHARSET;
    TitleFont.Color := clBtnText;
    TitleFont.Height := -11;
    TitleFont.Name := 'MS Sans Serif';
    TitleFont.Style := [fsBold];
    with Columns.Add do begin
      BiggestWord := 'procedure';
    end;
    ParamSepString := ' ';
    ShortCut := 16416;
  end;
  with SynROPSCompProp do
  begin
    Name := 'SynROPSCompProp';
    Options := [scoAnsiStrings, scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText, scoEndCharCompletion];
    NbLinesInWindow := 6;
    Width := 262;
    EndOfTokenChr := '()[]. ';
    TriggerChars := '.';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    TitleFont.Charset := ANSI_CHARSET;
    TitleFont.Color := clBtnText;
    TitleFont.Height := -11;
    TitleFont.Name := 'Arial';
    TitleFont.Style := [fsBold];
    with Columns.Add do begin
      BiggestWord := 'procedure';
    end;
    ParamSepString := ' ';
    ShortCut := 16416;
  end;
  with scpParams do
  begin
    Name := 'scpParams';
    DefaultType := ctParams;
    Options := [scoLimitToMatchedText, scoUsePrettyText, scoUseBuiltInTimer];
    ClBackground := clInfoBk;
    Width := 262;
    EndOfTokenChr := '()[]. ';
    TriggerChars := '(';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    TitleFont.Charset := DEFAULT_CHARSET;
    TitleFont.Color := clBtnText;
    TitleFont.Height := -11;
    TitleFont.Name := 'MS Sans Serif';
    TitleFont.Style := [fsBold];
    ParamSepString := ' ';
    OnExecute := scpParamsExecute;
    ShortCut := 24608;
    TimerInterval := 1200;
  end;
  with SynNXCCompProp do
  begin
    Name := 'SynNXCCompProp';
    Options := [scoAnsiStrings, scoLimitToMatchedText, scoEndCharCompletion];
    NbLinesInWindow := 6;
    Width := 262;
    EndOfTokenChr := '()[].';
    TriggerChars := '.';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    TitleFont.Charset := ANSI_CHARSET;
    TitleFont.Color := clBtnText;
    TitleFont.Height := -11;
    TitleFont.Name := 'Arial';
    TitleFont.Style := [fsBold];
    ParamSepString := ' ';
    ShortCut := 16416;
  end;
  with SynNPGCompProp do
  begin
    Name := 'SynNPGCompProp';
    Options := [scoAnsiStrings, scoLimitToMatchedText, scoEndCharCompletion];
    NbLinesInWindow := 6;
    Width := 262;
    EndOfTokenChr := '()[].';
    TriggerChars := '.';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    TitleFont.Charset := ANSI_CHARSET;
    TitleFont.Color := clBtnText;
    TitleFont.Height := -11;
    TitleFont.Name := 'Arial';
    TitleFont.Style := [fsBold];
    ParamSepString := ' ';
    ShortCut := 16416;
  end;
  with SynRSCompProp do
  begin
    Name := 'SynRSCompProp';
    Options := [scoAnsiStrings, scoLimitToMatchedText, scoEndCharCompletion];
    NbLinesInWindow := 6;
    Width := 262;
    EndOfTokenChr := '()[].';
    TriggerChars := '.';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    TitleFont.Charset := ANSI_CHARSET;
    TitleFont.Color := clBtnText;
    TitleFont.Height := -11;
    TitleFont.Name := 'Arial';
    TitleFont.Style := [fsBold];
    ParamSepString := ' ';
    ShortCut := 16416;
  end;
end;

procedure TMainForm.CreateMiscSynEditComponents;
begin
  SynMacroRec := TSynMacroRecorder.Create(Self);
  SynAutoComp := TSynEditAutoComplete.Create(Self);
  SynEditSearch := TSynEditSearch.Create(Self);
  SynEditRegexSearch := TSynEditRegexSearch.Create(Self);
  expRTF := TSynExporterRTF.Create(Self);
  expHTML := TSynExporterHTML.Create(Self);
  SynEditPrint := TSynEditPrint.Create(Self);
  with SynMacroRec do
  begin
    Name := 'SynMacroRec';
    RecordShortCut := 24658;
    PlaybackShortCut := 24656;
    OnStateChange := SynMacroRecStateChange;
  end;
  with SynAutoComp do
  begin
    Name := 'SynAutoComp';
    CaseSensitive := False;
    EndOfTokenChr := '()[]{}.';
  end;
  with SynEditSearch do
  begin
    Name := 'SynEditSearch';
  end;
  with SynEditRegexSearch do
  begin
    Name := 'SynEditRegexSearch';
  end;
  with expRTF do
  begin
    Name := 'expRTF';
    Color := clWindow;
    DefaultFilter := 'Rich Text Format Documents (*.rtf)|*.rtf';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBlack;
    Font.Height := -13;
    Font.Name := 'Courier New';
    Font.Style := [];
    Title := 'Untitled';
    UseBackground := False;
  end;
  with expHTML do
  begin
    Name := 'expHTML';
    Color := clWindow;
    DefaultFilter := 'HTML Documents (*.htm,*.html)|*.htm;*.html';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBlack;
    Font.Height := -13;
    Font.Name := 'Courier New';
    Font.Style := [];
    HTMLFontSize := fs03;
    Title := 'Untitled';
    UseBackground := False;
  end;
  with SynEditPrint do
  begin
    Name := 'SynEditPrint';
    Copies := 1;
    Header.FrameTypes := [ftBox, ftShaded];
    Header.DefaultFont.Charset := DEFAULT_CHARSET;
    Header.DefaultFont.Color := clBlack;
    Header.DefaultFont.Height := -13;
    Header.DefaultFont.Name := 'Arial';
    Header.DefaultFont.Style := [];
    Footer.DefaultFont.Charset := DEFAULT_CHARSET;
    Footer.DefaultFont.Color := clBlack;
    Footer.DefaultFont.Height := -13;
    Footer.DefaultFont.Name := 'Arial';
    Footer.DefaultFont.Style := [];
    Margins.Left := 25.000000000000000000;
    Margins.Right := 15.000000000000000000;
    Margins.Top := 25.000000000000000000;
    Margins.Bottom := 25.000000000000000000;
    Margins.Header := 15.000000000000000000;
    Margins.Footer := 15.000000000000000000;
    Margins.LeftHFTextIndent := 2.000000000000000000;
    Margins.RightHFTextIndent := 2.000000000000000000;
    Margins.HFInternalMargin := 0.500000000000000000;
    Margins.MirrorMargins := False;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    Colors := True;
    TabWidth := 8;
    Color := clWhite;
  end;
end;

procedure TMainForm.pagMainDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  DragOverHelper(Sender, Source, X, Y, State, Accept);
end;

procedure TMainForm.pagMainDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  DragDropHelper(Sender, Source, X, Y);
end;

procedure TMainForm.FormDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  DragOverHelper(Sender, Source, X, Y, State, Accept);
end;

procedure TMainForm.FormDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  DragDropHelper(Sender, Source, X, Y);
end;

procedure TMainForm.pnlPageControlDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  DragOverHelper(Sender, Source, X, Y, State, Accept);
end;

procedure TMainForm.pnlPageControlDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  DragDropHelper(Sender, Source, X, Y);
end;

procedure TMainForm.DragDropHelper(Sender, Source: TObject; X, Y: Integer);
var
  i : integer;
begin
  if Source = frmNXTExplorer.lstFiles then
  begin
    with frmNXTExplorer.lstFiles do
    begin
      for i := 0 to Items.Count - 1 do
      begin
        if Items[i].Selected then
          if FileExists(Folders[i].PathName) then
            MainForm.OpenFile(Folders[i].PathName);
      end;
    end;
  end;
end;

procedure TMainForm.DragOverHelper(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if Source = frmNXTExplorer.lstFiles then
  begin
    Accept := True;
  end
  else
    Accept := False;
end;

function StartDoc(const DocName : String) : Integer;
begin
  Result := ShellExecute(GetDesktopWindow(), 'open', PChar(DocName), '', '', SW_SHOWNORMAL);
end;

procedure HandleResponse(const res : integer);
var
  msg : string;
begin
  if res <= 32 then
  begin
    case res of
      SE_ERR_FNF : msg := 'File not found';
      SE_ERR_PNF : msg := 'Path not found';
      SE_ERR_ACCESSDENIED : msg := 'Access denied';
      SE_ERR_OOM : msg := 'Out of memory';
      SE_ERR_DLLNOTFOUND : msg := 'DLL not found';
      SE_ERR_SHARE : msg := 'A sharing violation occurred';
      SE_ERR_ASSOCINCOMPLETE : msg := 'Incomplete or invalid file association';
      SE_ERR_DDETIMEOUT : msg := 'DDE time out';
      SE_ERR_DDEFAIL : msg := 'DDE transaction failed';
      SE_ERR_DDEBUSY : msg := 'DDE busy';
      SE_ERR_NOASSOC : msg := 'No association for file extension';
      ERROR_BAD_FORMAT : msg := 'Invalid EXE file or error in EXE image';
    else
      msg := 'Unknown error';
    end;
    ShowMessage(msg);
  end;
end;

procedure TMainForm.actHelpNXCGuidePDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NXC_Guide.pdf'));
end;

procedure TMainForm.actHelpNQCGuidePDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NQC_Guide.pdf'));
end;

procedure TMainForm.actHelpNBCGuidePDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NBC_Guide.pdf'));
end;

procedure TMainForm.actHelpNXCTutorialPDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NXC_Tutorial.pdf'));
end;

procedure TMainForm.actHelpNQCTutorialPDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NQC_Tutorial.pdf'));
end;

procedure TMainForm.actHelpNBCTutorialPDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NBC_Tutorial.pdf'));
end;

procedure TMainForm.HandleExplorerFinished(Sender: TObject);
begin
  if FileIsNXC then
    LoadNXCCompProp
  else if FileIsNQC then
    LoadNQCCompProp;
end;

procedure TMainForm.DoLoadAPI(cp : TSynCompletionProposal; aStrings : TStrings);
var
  SL : TStrings;
begin
  SL := TStringList.Create;
  try
    TStringList(SL).Sorted := True;
    TStringList(SL).Duplicates := dupIgnore;
    SL.AddStrings(aStrings);
    AddUserDefinedFunctions(SL);
    cp.ItemList := SL;
  finally
    SL.Free;
  end;
end;

procedure TMainForm.LoadNQCCompProp;
begin
  DoLoadAPI(SynNQCCompProp, fNQCAPIBase);
end;

procedure TMainForm.LoadNXCCompProp;
begin
  DoLoadAPI(SynNXCCompProp, fNXCAPIBase);
end;

procedure TMainForm.AddUserDefinedFunctions(aStrings: TStrings);
var
  i, idx : integer;
  tmpStr : string;
begin
  if Assigned(frmCodeExplorer) then
  begin
    for i := 0 to frmCodeExplorer.ProcessedResults.Count - 1 do
    begin
      tmpStr := frmCodeExplorer.ProcessedResults[i];
      idx := Pos('|', tmpStr);
      Delete(tmpStr, 1, idx);
      idx := Pos('|', tmpStr);
      Delete(tmpStr, 1, idx);
      aStrings.Add(tmpStr);
    end;
  end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CloseAllEditors;
end;

procedure TMainForm.HandleOnAddConstruct(Sender : TObject; const aTemplate : string; const aX : integer = -1; const aY : integer = -1);
var
  AEF : TEditorForm;
begin
  AEF := ActiveEditorForm;
  if Assigned(AEF) then
    AEF.AddConstructString(aTemplate, aX, aY);
end;

procedure TMainForm.actSearchGrepSearchExecute(Sender: TObject);
begin
  fGDE.Click(Sender);
end;

procedure TMainForm.actSearchGrepResultsExecute(Sender: TObject);
begin
  fGE.Click(Sender);
end;

{$IFDEF FPC}
initialization
  {$i MainUnit.lrs}
{$ENDIF}

end.

