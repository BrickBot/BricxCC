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
unit ucodeedit;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows,
  SynCompletionProposal,
{$ELSE}
  LResources,
  LMessages,
  LCLType,
  LCLIntf,
  SynEditMarks,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls,
  ComCtrls, ToolWin, StdCtrls, ImgList, ActnList, Menus, uCodeExplorer,
  GX_ProcedureList, GotoLine, ConstructUnit, CodeUnit, GX_IDECodeTemplates,
  EditCodeTemplate, CodeTemplates, uBasicPrefs, uMacroLib, uMacroForm,
  {uNXTWatchList, uGrepExpert, uGrepSearch, }
  uMacroEditor, uPSComponent_StdCtrls, uPSComponent_Controls,
  uPSComponent_Forms, uPSComponent_Default, uPSComponent, SynEdit, SynEditEx,
  BricxccSynEdit, SynMacroRecorder, SynEditHighlighter, SynHighlighterNQC,
  SynHighlighterNBC, SynHighlighterNPG, SynHighlighterRS, SynHighlighterROPS,
  SynEditAutoComplete, uTreeSaver, SynEditPlugins, SynEditTypes,
  SynEditRegexSearch, SynEditMiscClasses, SynEditSearch, {SynEditPrintTypes,}
  SynExportRTF,
  SynEditExport, SynExportHTML, SynEditKeyCmds;

type

  { TfrmCodeEdit }

  TfrmCodeEdit = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    splCodeExplorer: TSplitter;
    pnlCodeExplorer: TPanel;
    barStatus: TStatusBar;
    pnlRight: TPanel;
    splErrors: TSplitter;
    TheErrors: TListBox;
    ilBookmarkImages: TImageList;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    alMain: TActionList;
    actFileNew: TAction;
    actFileOpen: TAction;
    actFileSave: TAction;
    actFileSaveAs: TAction;
    actFilePageSetup: TAction;
    actFilePrinterSetup: TAction;
    actFilePrintPreview: TAction;
    actFilePrint: TAction;
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
    actHelpHelp: TAction;
    actHelpInfo: TAction;
    actEditCopyHTML: TAction;
    actEditCopyRTF: TAction;
    actCompileTraceInto: TAction;
    actCompileStepOver: TAction;
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
    mnuMain: TMainMenu;
    mniFile: TMenuItem;
    pmnuEditor: TPopupMenu;
    mniEdit: TMenuItem;
    mniSearch: TMenuItem;
    mniView: TMenuItem;
    mniCompile: TMenuItem;
    mniCompileProgram: TMenuItem;
    mniDownload: TMenuItem;
    mniDownloadandRun: TMenuItem;
    N15: TMenuItem;
    mniRun: TMenuItem;
    mniStop: TMenuItem;
    mniPause: TMenuItem;
    mniRunToCursor: TMenuItem;
    mniRunUntilReturn: TMenuItem;
    mniSingleStep: TMenuItem;
    mniStepOver: TMenuItem;
    mniTraceInto: TMenuItem;
    mniTraceToLine: TMenuItem;
    mniCompSep: TMenuItem;
    mniCodeExplorer: TMenuItem;
    mniStatusbar: TMenuItem;
    mniShowTemplates: TMenuItem;
    mniShowCodeListing: TMenuItem;
    mniHideErrors: TMenuItem;
    mniMacroManager: TMenuItem;
    mniFindDeclaration: TMenuItem;
    N5: TMenuItem;
    mniOpenFileAtCursor: TMenuItem;
    mniTopicSearch: TMenuItem;
    N3: TMenuItem;
    lmiEditUndo: TMenuItem;
    lmiEditRedo: TMenuItem;
    N2: TMenuItem;
    lmiEditCut: TMenuItem;
    lmiEditCopy: TMenuItem;
    lmiEditPaste: TMenuItem;
    lmiEditDelete: TMenuItem;
    N1: TMenuItem;
    lmiEditSelectAll: TMenuItem;
    lmiCopySpecial: TMenuItem;
    N4: TMenuItem;
    mniToggleBookmarks: TMenuItem;
    mniGotoBookmarks: TMenuItem;
    N6: TMenuItem;
    mniViewExplorer: TMenuItem;
    mniToggleBreakpoint: TMenuItem;
    mniTBookmark0: TMenuItem;
    mniTBookmark1: TMenuItem;
    mniTBookmark2: TMenuItem;
    mniTBookmark3: TMenuItem;
    mniTBookmark4: TMenuItem;
    mniTBookmark5: TMenuItem;
    mniTBookmark6: TMenuItem;
    mniTBookmark7: TMenuItem;
    mniTBookmark8: TMenuItem;
    mniTBookmark9: TMenuItem;
    mniGBookmark0: TMenuItem;
    mniGBookmark1: TMenuItem;
    mniGBookmark2: TMenuItem;
    mniGBookmark3: TMenuItem;
    mniGBookmark4: TMenuItem;
    mniGBookmark5: TMenuItem;
    mniGBookmark6: TMenuItem;
    mniGBookmark7: TMenuItem;
    mniGBookmark8: TMenuItem;
    mniGBookmark9: TMenuItem;
    lmiCopyHTML: TMenuItem;
    lmiCopyRTF: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    N11: TMenuItem;
    PageSetup1: TMenuItem;
    PrinterSetup1: TMenuItem;
    PrintPreview1: TMenuItem;
    Print1: TMenuItem;
    mniSepFiles: TMenuItem;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
    N12: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    N26: TMenuItem;
    SelectAll1: TMenuItem;
    mniCopySpecial: TMenuItem;
    N8: TMenuItem;
    NextField1: TMenuItem;
    N16: TMenuItem;
    Preferences1: TMenuItem;
    HTML1: TMenuItem;
    RTF1: TMenuItem;
    Find1: TMenuItem;
    FindNext1: TMenuItem;
    FindPrevious1: TMenuItem;
    Replace1: TMenuItem;
    N13: TMenuItem;
    GotoLineNumber1: TMenuItem;
    ProcedureList1: TMenuItem;
    procedure actCompileCompileExecute(Sender: TObject);
    procedure actCompileDownloadExecute(Sender: TObject);
    procedure actCompileDownloadRunExecute(Sender: TObject);
    procedure actCompileRunExecute(Sender: TObject);
    procedure actCompileRunToCursorExecute(Sender: TObject);
    procedure actCompileStepOutExecute(Sender: TObject);
    procedure actCompileStepOverExecute(Sender: TObject);
    procedure actCompileStopExecute(Sender: TObject);
    procedure actCompileTraceIntoExecute(Sender: TObject);
    procedure actCompileTraceToLineExecute(Sender: TObject);
    procedure actEditCopyExecute(Sender: TObject);
    procedure actEditCopyHTMLExecute(Sender: TObject);
    procedure actEditCopyRTFExecute(Sender: TObject);
    procedure actEditCutExecute(Sender: TObject);
    procedure actEditDeleteExecute(Sender: TObject);
    procedure actEditNextFieldExecute(Sender: TObject);
    procedure actEditPasteExecute(Sender: TObject);
    procedure actEditPreferencesExecute(Sender: TObject);
    procedure actEditRedoExecute(Sender: TObject);
    procedure actEditSelectAllExecute(Sender: TObject);
    procedure actEditUndoExecute(Sender: TObject);
    procedure actFileNewExecute(Sender: TObject);
    procedure actFileOpenExecute(Sender: TObject);
    procedure actFileSaveAsExecute(Sender: TObject);
    procedure actFileSaveExecute(Sender: TObject);
    procedure actSearchFindExecute(Sender: TObject);
    procedure actSearchFindNextExecute(Sender: TObject);
    procedure actSearchFindPrevExecute(Sender: TObject);
    procedure actSearchGotoLineExecute(Sender: TObject);
    procedure actSearchProcListExecute(Sender: TObject);
    procedure actSearchReplaceExecute(Sender: TObject);
    procedure actCompilePauseExecute(Sender: TObject);
    procedure actCompileSingleStepExecute(Sender: TObject);
    procedure actHelpNBCGuidePDFExecute(Sender: TObject);
    procedure actHelpNBCTutorialPDFExecute(Sender: TObject);
    procedure actHelpNXCGuidePDFExecute(Sender: TObject);
    procedure actHelpNXCTutorialPDFExecute(Sender: TObject);
    procedure alMainUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure mniCodeExplorerClick(Sender: TObject);
    procedure mniCompileClick(Sender: TObject);
    procedure mniExitClick(Sender: TObject);
    procedure mniFileClick(Sender: TObject);
    procedure mniFindDeclarationClick(Sender: TObject);
    procedure mniHideErrorsClick(Sender: TObject);
    procedure mniMacroManagerClick(Sender: TObject);
    procedure mniOpenFileAtCursorClick(Sender: TObject);
    procedure mniShowCodeListingClick(Sender: TObject);
    procedure mniShowTemplatesClick(Sender: TObject);
    procedure mniStatusbarClick(Sender: TObject);
    procedure mniToggleBreakpointClick(Sender: TObject);
    procedure mniViewClick(Sender: TObject);
    procedure mniViewExplorerClick(Sender: TObject);
    procedure mnTopicSearchClick(Sender: TObject);
    procedure pmnuEditorPopup(Sender: TObject);
    procedure Preferences1Click(Sender: TObject);
    procedure RecentFileClick(Sender: TObject);
    procedure TheErrorsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToggleBookmark(Sender: TObject);
    procedure GotoBookmark(Sender: TObject);
    procedure pnlCodeExplorerDockOver(Sender: TObject;
      Source: TDragDockObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);
    procedure pnlCodeExplorerGetSiteInfo(Sender: TObject;
      DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint;
      var CanDock: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure mniEditClick(Sender: TObject);
    procedure mniSearchClick(Sender: TObject);
    procedure TheErrorsClick(Sender: TObject);
    procedure actSearchGrepResultsExecute(Sender: TObject);
    procedure actSearchGrepSearchExecute(Sender: TObject);
    procedure actToolsNXTWatchListExecute(Sender: TObject);
  private
    { Private declarations }
    IsNew:boolean;
    fFilename: string;
    fHighlighter: TSynCustomHighlighter;
    FResume : boolean;
    fNXCAPIBase : TStringList;
    fSPCAPIBase : TStringList;
    newcount : integer;
    FActiveLine : integer;
    procedure HandleGetExpressions(Sender: TObject; aStrings: TStrings);
//    procedure HandleGetWatchValue(Info: TWatchInfo; var Value: string);
    procedure HandleIsProcessAccessible(Sender: TObject; var Accessible: boolean);
    procedure CreateTheEditor;
    procedure CreateCompPropComponents;
    procedure CreateMainFormHighlighters;
    procedure CreateMiscSynEditComponents;
    procedure FindDeclaration(const aIdent: string);
    function OkayToCloseCurrentFile: boolean;
    procedure OpenFileAtCursor;
    procedure OpenFile(fname:string; lineNo : integer = -1);
    function OpenFileOnPath(const fname: string): boolean;
    procedure NewFile(fname: string);
    procedure SetActiveHelpFile;
    function GetPosition: integer;
    function GetSource: string;
    procedure SetFilename(const Value: string);
    procedure SetPosition(const Value: integer);
    procedure UpdateModeOnStatusBar;
    procedure UpdateModifiedOnStatusBar;
    procedure UpdatePositionOnStatusBar;
    function DoCompileAction(bDown, bRun: Boolean): Boolean;
    procedure StartTask(idx: integer);
    procedure UpdateEditorPosition;
    function CanCut: Boolean;
    function CanPaste: Boolean;
    function CanUndo: Boolean;
    procedure CopySel;
    procedure CutSel;
    procedure DeleteSel;
    procedure GotoLine;
    procedure NextField;
    procedure Paste;
    procedure Redo;
    procedure SelectAll;
    function Selected: Boolean;
    procedure Undo;
    procedure DoSave;
    procedure DoSaveAs;
    function CanFind: boolean;
    function CanFindNext: boolean;
    function CanRedo: boolean;
    function CanReplace: boolean;
    procedure ExecFind;
    procedure ExecFindNext;
    procedure ExecFindPrev;
    procedure ExecReplace;
    procedure UpdateStatusBar;
    procedure DoCopyHTML(Sender: TObject);
    procedure DoCopyRTF(Sender: TObject);
    procedure ProcedureList;
    procedure SetCaption(const fname: string);
    procedure SetSyntaxHighlighter;
    procedure HookCompProp;
    procedure SelectLine(lineNo: integer);
    procedure SaveModifiedFiles;
    procedure DoDisplayErrors(aShow: boolean);
    procedure HandleOnCompilerStatusChange(Sender: TObject;
      const aStatusMsg: string; const bDone : boolean);
    procedure HandleOpenStateChanged(Sender: TObject);
    procedure HandleOnGetVarInfoByID(Sender: TObject; const ID: integer;
      var offset, size, vartype: integer);
    procedure HandleOnGetVarInfoByName(Sender: TObject; const name: string;
      var offset, size, vartype: integer);
    procedure ShowNXTTools;
    procedure SaveFile;
    procedure SaveFileAs(fname: string);
    procedure ShowTheErrors;
    procedure DoHideErrors;
    procedure SynMacroRecStateChange(Sender: TObject);
{$IFNDEF FPC}
    procedure scpParamsExecute(Kind: SynCompletionType; Sender: TObject;
      var CurrentInput: String; var x, y: Integer;
      var CanExecute: Boolean);
{$ENDIF}
    procedure CreatePascalScriptComponents;
    procedure ceAfterExecute(Sender: TPSScript);
    procedure ceBreakpoint(Sender: TObject; const FileName: String;
      Position, Row, Col: Cardinal);
    procedure ceCompile(Sender: TPSScript);
    procedure ceExecute(Sender: TPSScript);
    procedure ceIdle(Sender: TObject);
    procedure ceLineInfo(Sender: TObject; const FileName: String; Position,
      Row, Col: Cardinal);
    function ceNeedFile(Sender: TObject; const OrginFileName: String;
      var FileName, Output: String): Boolean;
    procedure CreateSpiritPlugins;
    function HandleOnHelp(Command: Word; Data: Integer;
      var CallHelp: Boolean): Boolean;
    procedure SetValuesFromPreferences;
    procedure HandleExplorerFinished(Sender: TObject);
    procedure HandleOnAddConstruct(Sender : TObject; const aTemplate : string; const aX : integer = -1; const aY : integer = -1);
    procedure ShowCodeExplorer;
    procedure ShowTemplates(bSave: boolean = true);
    procedure UpdateCompilerMenu;
    procedure ConfigureOtherFirmwareOptions;
    procedure AddConstructString(constr: string; x, y: integer);
    function ActiveLanguageIndex: integer;
    function ActiveLanguageName: string;
    procedure HandleCompXferClick(Sender: TObject);
    procedure SetFilterIndexFromLanguage;
    procedure ExecuteTransferItem(TI: TTransferItem);
    function ProcessParams(aParams: string): string;
    procedure ChangeActiveEditor;
    procedure UpdateSynComponents;
    procedure AddErrorMessage(const errMsg: string);
    function CanFindDeclaration: Boolean;
    procedure ConfigureTransferMenuItemVisibility(aList: TList;
      aMenuItem: TMenuItem; const aPrefix: string);
    procedure DoPrintPreview;
    procedure DragDropHelper(Sender, Source: TObject; X, Y: Integer);
    procedure DragOverHelper(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    function IsMaximized: Boolean;
  private
    procedure LoadNXCCompProp;
    procedure LoadSPCCompProp;
{$IFNDEF FPC}
    procedure DoLoadAPI(cp: TSynCompletionProposal; aStrings: TStrings);
{$ENDIF}
    procedure AddUserDefinedFunctions(aStrings : TStrings);
  private
    // synedit highlighters
    SynNXCSyn: TSynNXCSyn;
    SynNPGSyn: TSynNPGSyn;
    SynNBCSyn: TSynNBCSyn;
    SynRSSyn: TSynRSSyn;
    SynROPSSyn: TSynROPSSyn;
    SynSPCSyn: TSynSPCSyn;
{$IFNDEF FPC}
    // completion proposal components
    SynNBCCompProp: TSynCompletionProposal;
    SynNXCCompProp: TSynCompletionProposal;
    SynNPGCompProp: TSynCompletionProposal;
    SynRSCompProp: TSynCompletionProposal;
    SynROPSCompProp: TSynCompletionProposal;
    SynSPCCompProp: TSynCompletionProposal;
    scpParams: TSynCompletionProposal;
{$ENDIF}
    // misc synedit components
    SynMacroRec: TSynMacroRecorder;
    SynAutoComp: TSynEditAutoComplete;
    SynEditSearch: TSynEditSearch;
    SynEditRegexSearch: TSynEditRegexSearch;
    expRTF: TSynExporterRTF;
    expHTML: TSynExporterHTML;
//    SynEditPrint: TSynEditPrint;
    // pascal script components
    PSImport_Controls: TPSImport_Controls;
    PSImport_StdCtrls: TPSImport_StdCtrls;
    PSImport_Forms: TPSImport_Forms;
    PSImport_DateUtils: TPSImport_DateUtils;
    PSImport_Classes: TPSImport_Classes;
    ce: TPSScriptDebugger;
//    fGE : TGrepExpert;
//    fGDE : TGrepDlgExpert;
    procedure TheEditorDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TheEditorDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TheEditorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TheEditorKeyPress(Sender: TObject; var Key: Char);
    procedure TheEditorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TheEditorChange(Sender: TObject);
    procedure TheEditorClearBookmark(Sender: TObject;
      var Mark: TSynEditMark);
    procedure TheEditorGutterClick(Sender: TObject; X, Y, Line: Integer;
      mark: TSynEditMark);
    procedure TheEditorPlaceBookmark(Sender: TObject;
      var Mark: TSynEditMark);
    procedure TheEditorProcessCommand(Sender: TObject;
      var Command: TSynEditorCommand; var AChar: {$IFDEF FPC}TUTF8Char{$ELSE}Char{$ENDIF};
      Data: Pointer);
    procedure TheEditorProcessUserCommand(Sender: TObject;
      var Command: TSynEditorCommand; var AChar: {$IFDEF FPC}TUTF8Char{$ELSE}Char{$ENDIF};
      Data: Pointer);
    procedure TheEditorReplaceText(Sender: TObject; const ASearch,
      AReplace: String; Line, Column: Integer;
      var Action: TSynReplaceAction);
    procedure TheEditorStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure TheEditorSpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);
    procedure TheEditorMouseOverToken(Sender: TObject; const Token: String;
      TokenType: Integer; Attri: TSynHighlighterAttributes;
      var Highlight: Boolean);
  public
    { Public declarations }
    TheEditor: TBricxccSynEdit;
  public
    { Public declarations }
    property  Filename : string read fFilename write SetFilename;
    property  Highlighter : TSynCustomHighlighter read fHighlighter write fHighlighter;
    property  Source : string read GetSource;
    property  Position : integer read GetPosition write SetPosition;
  end;

var
  frmCodeEdit: TfrmCodeEdit;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  Clipbrd, Registry,
  uNXTCodeComp, uNXCCodeComp, uRICCodeComp, uProgram, uCompStatus,
  uRICComp, uCppCode, Transdlg, uSPCCodeComp, 
  uNXTClasses, uNBCInterface, uNBCCommon, uEditorExperts, ParamUtils,
  uPSI_brick_common, uPSI_uSpirit, uPSI_FantomSpirit, uPSRuntime,
  uPSDisassembly, uPSDebugger, 
  uGlobals, uHighlighterProcs, brick_common, FantomSpirit,
  dlgSearchText, dlgReplaceText, dlgConfirmReplace,// DTestPrintPreview,
  uEditorUtils, uMiscDefines, rcx_constants, uLocalizedStrings,
  uParseCommon, uNXTExplorer
  ;


procedure TfrmCodeEdit.CreateTheEditor;
var
  tmp : string;
begin
  TheEditor := TBricxccSynEdit.Create(Self);
  with TheEditor do
  begin
    Name := 'TheEditor';
    Parent := pnlRight;
    Lines.Clear;
    Left := 0;
    Top := 0;
//    Width := 464;
//    Height := 285;
    Cursor := crIBeam;
    Align := alClient;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
{$IFDEF FPC}
{$IFDEF LCLCarbon}
    Font.Name := 'Monaco';
    Font.Size := 12;
    Font.Quality := fqDefault;
{$ELSE}
    Font.Name := 'Courier New';
{$ENDIF}
{$ELSE}
    Font.Name := 'Courier New';
{$ENDIF}
    Font.Pitch := fpFixed;
    Font.Style := [];
    ParentColor := False;
    ParentFont := False;
    if ConstructForm <> nil then
      PopupMenu := ConstructForm.ConstructMenu;
    TabOrder := 1;
    BookMarkOptions.BookmarkImages := ilBookmarkImages;
{$IFNDEF FPC}
    Gutter.Font.Charset := DEFAULT_CHARSET;
    Gutter.Font.Color := clWindowText;
    Gutter.Font.Height := -11;
    Gutter.Font.Name := 'Terminal';
    Gutter.Font.Style := [];
    ScrollHintFormat := shfTopToBottom;
    OnMouseOverToken := TheEditorMouseOverToken;
{$ENDIF}
    MaxUndo := 10;
    Options := [eoAutoIndent, eoDragDropEditing, eoScrollPastEol,
                eoShowScrollHint, eoSmartTabDelete, eoSmartTabs,
                eoTabsToSpaces, eoTrimTrailingSpaces];
    TabWidth := 2;
    WantTabs := True;
    OnDragDrop := TheEditorDragDrop;
    OnDragOver := TheEditorDragOver;
    OnKeyDown := TheEditorKeyDown;
    OnKeyPress := TheEditorKeyPress;
    OnMouseDown := TheEditorMouseDown;
    OnChange := TheEditorChange;
    OnClearBookmark := TheEditorClearBookmark;
    OnGutterClick := TheEditorGutterClick;
    OnPlaceBookmark := TheEditorPlaceBookmark;
    OnProcessCommand := TheEditorProcessCommand;
    OnProcessUserCommand := TheEditorProcessUserCommand;
    OnReplaceText := TheEditorReplaceText;
    OnSpecialLineColors := TheEditorSpecialLineColors;
    OnStatusChange := TheEditorStatusChange;
    StructureLineColor := clNone;
  end;
end;

procedure TfrmCodeEdit.CreateMiscSynEditComponents;
begin
  SynMacroRec := TSynMacroRecorder.Create(Self);
  SynAutoComp := TSynEditAutoComplete.Create(Self);
  SynEditSearch := TSynEditSearch.Create({$IFNDEF FPC}Self{$ENDIF});
  SynEditRegexSearch := TSynEditRegexSearch.Create(Self);
  expRTF := TSynExporterRTF.Create(Self);
  expHTML := TSynExporterHTML.Create(Self);
//  SynEditPrint := TSynEditPrint.Create(Self);
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
(*
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
*)
end;

procedure TfrmCodeEdit.CreateCompPropComponents;
begin
{$IFNDEF FPC}
  SynNBCCompProp := TSynCompletionProposal.Create(Self);
  SynROPSCompProp := TSynCompletionProposal.Create(Self);
  scpParams := TSynCompletionProposal.Create(Self);
  SynNXCCompProp := TSynCompletionProposal.Create(Self);
  SynNPGCompProp := TSynCompletionProposal.Create(Self);
  SynRSCompProp := TSynCompletionProposal.Create(Self);
  SynSPCCompProp := TSynCompletionProposal.Create(Self);
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
  with SynSPCCompProp do
  begin
    Name := 'SynSPCCompProp';
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
{$ENDIF}
end;

procedure TfrmCodeEdit.CreateMainFormHighlighters;
begin
  SynNXCSyn  := TSynNXCSyn.Create(Self);
  SynNPGSyn  := TSynNPGSyn.Create(Self);
  SynNBCSyn  := TSynNBCSyn.Create(Self);
  SynRSSyn   := TSynRSSyn.Create(Self);
  SynROPSSyn := TSynROPSSyn.Create(Self);
  SynSPCSyn  := TSynSPCSyn.Create(Self);
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
  with SynNBCSyn do
  begin
    Name := 'SynNBCSyn';
    DefaultFilter := 'Next Byte Code Files (*.nbc)|*.nbc';
  end;
  with SynRSSyn do
  begin
    Name := 'SynRSSyn';
    DefaultFilter := 'RICScript Files (*.rs)|*.rs';
  end;
  with SynROPSSyn do
  begin
    Name := 'SynROPSSyn';
//    PackageSource := False;
  end;
  with SynSPCSyn do
  begin
    Name := 'SynSPCSyn';
    DefaultFilter := 'SPC Files (*.spc)|*.spc';
    Comments := [csCStyle];
    DetectPreprocessor := True;
    IdentifierChars := '#0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz';
    Keywords.Clear;
    Commands.Clear;
    Constants.Clear;
  end;
end;

procedure TfrmCodeEdit.CreatePascalScriptComponents;
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
end;

procedure TfrmCodeEdit.CreateSpiritPlugins;
var
  Plugin : TPSPlugin;
begin
  Plugin := TPSImport_uSpirit.Create(Self);
  TPSPluginItem(ce.Plugins.Add).Plugin := Plugin;
  Plugin := TPSImport_brick_common.Create(Self);
  TPSPluginItem(ce.Plugins.Add).Plugin := Plugin;
{$IFNDEF NXT_ONLY}
  Plugin := TPSImport_FakeSpirit.Create(Self);
  TPSPluginItem(ce.Plugins.Add).Plugin := Plugin;
{$ENDIF}
  Plugin := TPSImport_FantomSpirit.Create(Self);
  TPSPluginItem(ce.Plugins.Add).Plugin := Plugin;
end;

procedure TfrmCodeEdit.FindDeclaration(const aIdent : string);
begin
  // try to find where aIdent is declared.  Check in this file first,
  // searching backward from the current location.  If found, make sure
  // it is not just another usage of the identifier rather than the
  // actual declaration of the identifier.  If NOT found in this
  // file then check any include files, starting at the end of the file
  // in each case.  Recurse through include files
  ShowMessage(aIdent);
end;

procedure TfrmCodeEdit.OpenFileAtCursor;
var
  fName : string;
  bFound : boolean;
begin
  fName := TheEditor.TextWithinDelimiters(['"', ' ']);
  if FileExists(fName) then
    OpenFile(fName)
  else
  begin
    bFound := OpenFileOnPath(fName);
    if not bFound then
    begin
      dlgOpen.FileName := fName;
      actFileOpenExecute(nil);
    end;
  end;
end;

procedure TfrmCodeEdit.TheEditorDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if Source = ConstructForm.treTemplates then
    ConstructForm.DoTemplateInsert(X, Y);
end;

procedure TfrmCodeEdit.TheEditorDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Source = ConstructForm.treTemplates then
  begin
    Accept := True;
    TheEditor.CaretXY := TheEditor.PixelsToRowColumn(Point(X, Y));
  end
  else
    Accept := False;
end;

procedure TfrmCodeEdit.TheEditorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = $0D) then
    OpenFileAtCursor;
end;

procedure TfrmCodeEdit.TheEditorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(27) then
    GlobalAbort := True;
end;

procedure TfrmCodeEdit.TheEditorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  if (ssCtrl in Shift) and (Button = mbLeft) then
//    FindDeclaration(TheEditor.WordAtMouse);
end;

procedure TfrmCodeEdit.TheEditorChange(Sender: TObject);
begin
  frmCodeExplorer.CurrentSource := TheEditor.Lines.Text;
end;

procedure TfrmCodeEdit.TheEditorGutterClick(Sender: TObject; X, Y,
  Line: Integer; mark: TSynEditMark);
begin
  if mark <> nil then
    TheEditor.ClearBookMark(mark.BookmarkNumber);
end;

procedure TfrmCodeEdit.TheEditorPlaceBookmark(Sender: TObject;
  var Mark: TSynEditMark);
begin
//
end;

procedure TfrmCodeEdit.TheEditorClearBookmark(Sender: TObject;
  var Mark: TSynEditMark);
begin
//
end;

const
  ecContextHelp = 490;  // Help on Word, Data = Word

procedure TfrmCodeEdit.TheEditorProcessCommand(Sender: TObject;
  var Command: TSynEditorCommand; var AChar: {$IFDEF FPC}TUTF8Char{$ELSE}Char{$ENDIF}; Data: Pointer);
var
  word : string;
  FoundPos: Integer;
  Ident: string;
begin
  case Command of
    ecContextHelp : begin
      SetActiveHelpFile;
      if TheEditor.SelAvail then
        word := TheEditor.SelText
      else
        word := TheEditor.TextAtCursor;
      if FileIsForth then
      begin
        if word = ';' then word := 'semicolon'
        else if word = '\' then word := 'backslash'
        else if word = '."' then word := 'dot-quote'
        else if word = 'S"' then word := 's-quote';
      end;
//      HelpALink(word, FileIsNQC);
      Command := ecNone;
    end;
    K_USER_PREVIDENT, K_USER_NEXTIDENT : begin
      if FindIdentAtPos(Source, Position, (Command = K_USER_PREVIDENT), FoundPos, Ident) then
        Position := FoundPos
      else
        DoBeep($FFFFFFFF);
    end;
  end;
end;

procedure TfrmCodeEdit.TheEditorProcessUserCommand(Sender: TObject;
  var Command: TSynEditorCommand; var AChar: {$IFDEF FPC}TUTF8Char{$ELSE}Char{$ENDIF};
  Data: Pointer);
var
  FoundPos: Integer;
  Ident: string;
  Lines : TStrings;
begin
  case Command of
    K_USER_PREVIDENT, K_USER_NEXTIDENT : begin
      if FindIdentAtPos(Source, Position, (Command = K_USER_PREVIDENT), FoundPos, Ident) then
        Position := FoundPos
      else
        Beep;
    end;
    K_USER_COMMENTBLOCK : begin
      Lines := TStringList.Create;
      try
        Lines.Text := TheEditor.SelText;
        if CommentLines(Lines) then
          TheEditor.SelText := Lines.Text;
      finally
        Lines.Free;
      end;
    end;
    K_USER_UNCOMMENTBLOCK : begin
      Lines := TStringList.Create;
      try
        Lines.Text := TheEditor.SelText;
        if UncommentLines(Lines) then
          TheEditor.SelText := Lines.Text;
      finally
        Lines.Free;
      end;
    end;
    K_USER_REVERSE : begin
      Lines := TStringList.Create;
      try
        Lines.Text := TheEditor.SelText;
        if ReverseStatements(Lines) then
          TheEditor.SelText := Lines.Text;
      finally
        Lines.Free;
      end;
    end;
    K_USER_ALIGN : begin
      Lines := TStringList.Create;
      try
        Lines.Text := TheEditor.SelText;
        if AlignSelectedLines(Lines) then
          TheEditor.SelText := Lines.Text;
      finally
        Lines.Free;
      end;
    end;
  end;
end;

procedure TfrmCodeEdit.TheEditorReplaceText(Sender: TObject; const ASearch,
  AReplace: String; Line, Column: Integer; var Action: TSynReplaceAction);
var
  APos: TPoint;
  EditRect: TRect;
begin
  if ASearch = AReplace then
    Action := raSkip
  else begin
    APos := Point(Column, Line);
    APos := TheEditor.ClientToScreen(TheEditor.RowColumnToPixels(APos));
    EditRect := ClientRect;
    EditRect.TopLeft := ClientToScreen(EditRect.TopLeft);
    EditRect.BottomRight := ClientToScreen(EditRect.BottomRight);

    if ConfirmReplaceDialog = nil then
      ConfirmReplaceDialog := TConfirmReplaceDialog.Create(Application);
    ConfirmReplaceDialog.PrepareShow(EditRect, APos.X, APos.Y,
      APos.Y + TheEditor.LineHeight, ASearch);
    case ConfirmReplaceDialog.ShowModal of
      mrYes: Action := raReplace;
      mrYesToAll: Action := raReplaceAll;
      mrNo: Action := raSkip;
      else Action := raCancel;
    end;
  end;
end;

procedure TfrmCodeEdit.TheEditorStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  // Note: scAll for new file loaded
  // caret position has changed
  if Changes * [scCaretX, scCaretY] <> [] then begin
    UpdatePositionOnStatusBar;
  end;
  // InsertMode property has changed
  if Changes * [scInsertMode, scReadOnly] <> [] then begin
    UpdateModeOnStatusBar;
  end;
  // Modified property has changed
  if Changes * [scModified] <> [] then
    UpdateModifiedOnStatusBar;
end;

procedure TfrmCodeEdit.TheEditorSpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
begin
  Special := False;
  if FileIsROPS then
  begin
    if theROPSCompiler.HasBreakPoint(Filename, Line) then
    begin
      Special := True;
      if Line = FActiveLine then
      begin
        FG := clRed;
        BG := clWhite;
      end else
      begin
        FG := clWhite;
        BG := clRed;
      end;
    end
    else if Line = FActiveLine then
    begin
      Special := True;
      FG := clWhite;
      BG := clBlue;
    end;
  end
  else if Assigned(fNXTCurrentOffset) and FileIsNBCOrNXC then
  begin
    Special := (Line = fNXTCurrentOffset.LineNumber) and
               (fNXTVMState = kNXT_VMState_Pause);
    if Special then
    begin
      FG := clWhite;
      BG := clBlue;
    end;
  end;
end;

procedure TfrmCodeEdit.TheEditorMouseOverToken(Sender: TObject;
  const Token: String; TokenType: Integer;
  Attri: TSynHighlighterAttributes; var Highlight: Boolean);
begin
{
  if not ((Pos(#9, Token) = 0) and (Pos(#32, Token) = 0)) then Exit;
  if TheEditor.Highlighter = nil then Exit;
  with TheEditor.Highlighter do begin
    Highlight := (Attri <> CommentAttribute) and
                 (Attri <> KeywordAttribute) and
                 (Attri <> StringAttribute) and
                 (Attri <> SymbolAttribute) and
                 (Attri <> WhitespaceAttribute);
  end;
}
end;

function TfrmCodeEdit.OkayToCloseCurrentFile : boolean;
begin
  Result := True;
  if TheEditor.Modified then
  begin
    Result := False;
    case MessageDlg(Format(S_FileChanged, [Caption]),
            mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      id_Yes: DoSave;
      id_No: TheEditor.Modified := False;
      id_Cancel: Exit; // bail out of this method
    end;
    Result := not TheEditor.Modified;
  end;
end;

procedure TfrmCodeEdit.actFileNewExecute(Sender: TObject);
begin
  if not OkayToCloseCurrentFile then Exit;
  newcount := newcount + 1;
  NewFile(sUntitled + IntToStr(newcount));
end;

procedure TfrmCodeEdit.actFileOpenExecute(Sender: TObject);
var
  i : integer;
begin
  if not OkayToCloseCurrentFile then Exit;
  if dlgOpen.Execute then
  begin
    OpenFile(dlgOpen.Filename);
  end;
end;

procedure TfrmCodeEdit.actCompileCompileExecute(Sender: TObject);
begin
  DoCompileAction(False, False);
end;

procedure TfrmCodeEdit.actCompileDownloadExecute(Sender: TObject);
begin
  DoCompileAction(True, False);
end;

procedure TfrmCodeEdit.actCompileDownloadRunExecute(Sender: TObject);
begin
  if DoCompileAction(True, True) then
    StartTask(0);
end;

procedure TfrmCodeEdit.actCompileRunExecute(Sender: TObject);
begin
  StartTask(0);
end;

procedure TfrmCodeEdit.actCompileStopExecute(Sender: TObject);
begin
  if FileIsROPS then begin
    if theROPSCompiler.Exec.Status = isRunning then
      theROPSCompiler.Stop;
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

procedure TfrmCodeEdit.actCompileStepOverExecute(Sender: TObject);
begin
  if FileIsROPS then
  begin
    if theROPSCompiler.Exec.Status = isRunning then
      theROPSCompiler.StepOver
    else
    begin
      if DoCompileAction(False, False) then
      begin
        theROPSCompiler.StepInto;
        theROPSCompiler.Execute;
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

procedure TfrmCodeEdit.actCompileTraceIntoExecute(Sender: TObject);
begin
  if FileIsROPS then
  begin
    if theROPSCompiler.Exec.Status = isRunning then
      theROPSCompiler.StepInto
    else
    begin
      if DoCompileAction(False, False) then
      begin
        theROPSCompiler.StepInto;
        theROPSCompiler.Execute;
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

procedure TfrmCodeEdit.actCompileStepOutExecute(Sender: TObject);
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

procedure TfrmCodeEdit.actCompileTraceToLineExecute(Sender: TObject);
var
  nextLine : integer;
begin
  if IsNXT and EnhancedFirmware then
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

procedure TfrmCodeEdit.actCompileRunToCursorExecute(Sender: TObject);
var
  cursorLine : integer;
begin
  if IsNXT and EnhancedFirmware then
  begin
    cursorLine := TheEditor.CaretY;
    if CurrentProgram.RunToCursor(cursorLine) then
    begin
      actCompilePause.Caption := sContinue;
      UpdateEditorPosition;
    end;
  end;
end;

procedure TfrmCodeEdit.actEditUndoExecute(Sender: TObject);
begin
  Undo;
end;

procedure TfrmCodeEdit.actEditRedoExecute(Sender: TObject);
begin
  Redo;
end;

procedure TfrmCodeEdit.actEditCutExecute(Sender: TObject);
begin
  CutSel;
end;

procedure TfrmCodeEdit.actEditCopyExecute(Sender: TObject);
begin
  CopySel;
end;

procedure TfrmCodeEdit.actEditPasteExecute(Sender: TObject);
begin
  Paste;
end;

procedure TfrmCodeEdit.actEditDeleteExecute(Sender: TObject);
begin
  DeleteSel;
end;

procedure TfrmCodeEdit.actEditSelectAllExecute(Sender: TObject);
begin
  SelectAll;
end;

procedure TfrmCodeEdit.actEditNextFieldExecute(Sender: TObject);
begin
  NextField;
end;

procedure TfrmCodeEdit.actEditPreferencesExecute(Sender: TObject);
{
var
  i : integer;
  F : TEditorForm;
  oldShowTempPopup : boolean;
}
begin
(*
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
*)
end;

procedure TfrmCodeEdit.actFileSaveExecute(Sender: TObject);
begin
  DoSave;
end;

procedure TfrmCodeEdit.actFileSaveAsExecute(Sender: TObject);
begin
  DoSaveAs;
end;

procedure TfrmCodeEdit.actSearchFindExecute(Sender: TObject);
begin
  ExecFind;
end;

procedure TfrmCodeEdit.actSearchFindNextExecute(Sender: TObject);
begin
  ExecFindNext;
end;

procedure TfrmCodeEdit.actSearchFindPrevExecute(Sender: TObject);
begin
  ExecFindPrev;
end;

procedure TfrmCodeEdit.actSearchReplaceExecute(Sender: TObject);
begin
  ExecReplace;
end;

procedure TfrmCodeEdit.actSearchGotoLineExecute(Sender: TObject);
begin
  GotoLine;
end;

procedure TfrmCodeEdit.actSearchProcListExecute(Sender: TObject);
begin
  ProcedureList;
end;

procedure TfrmCodeEdit.actEditCopyHTMLExecute(Sender: TObject);
begin
  DoCopyHTML(Sender);
end;

procedure TfrmCodeEdit.actEditCopyRTFExecute(Sender: TObject);
begin
  DoCopyRTF(Sender);
end;

procedure TfrmCodeEdit.mniFileClick(Sender: TObject);
begin
  {Show the recent files}
  ShowRecentFiles(Sender as TMenuItem, RecentFileClick);
end;

procedure TfrmCodeEdit.RecentFileClick(Sender: TObject);
begin
  OpenFile(GetRecentFileName(TMenuItem(Sender).Tag));
end;

procedure TfrmCodeEdit.mniShowTemplatesClick(Sender: TObject);
begin
  mniShowTemplates.Checked := not mniShowTemplates.Checked;
  ShowTemplateForm := mniShowTemplates.Checked;
  if ShowTemplateForm then
    ShowTemplates
  else
    ConstructForm.Close;
end;

procedure TfrmCodeEdit.mniShowCodeListingClick(Sender: TObject);
begin
  CodeForm.Visible := not CodeForm.Visible;
end;

procedure TfrmCodeEdit.mniHideErrorsClick(Sender: TObject);
begin
  DoHideErrors;
end;

(*
{Reacting on dropping a file on the form}
{$IFNDEF FPC}
procedure TfrmCodeEdit.WMDROPFILES(var Message: TWMDROPFILES);
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
*)

procedure TfrmCodeEdit.mniViewClick(Sender: TObject);
begin
  mniShowTemplates.Checked := ConstructForm.Visible;
  mniStatusbar.Checked     := barStatus.Visible;
  if CodeForm.Visible then
    mniShowCodeListing.Caption := sHideCodeError
  else
    mniShowCodeListing.Caption := sShowCodeError;
  mniCodeExplorer.Checked  := frmCodeExplorer.Visible;
  mniHideErrors.Enabled    := TheErrors.Visible;
end;

procedure TfrmCodeEdit.mniStatusbarClick(Sender: TObject);
begin
  mniStatusbar.Checked := not mniStatusbar.Checked;
  ShowStatusbar := mniStatusbar.Checked;
  barStatus.Visible := ShowStatusbar;
end;

procedure TfrmCodeEdit.DoPrintPreview;
begin
{
  SynEditPrint.SynEdit := TheEditor;
  SynEditPrint.Title   := Caption;
  with TTestPrintPreviewDlg.Create(nil) do
  try
    SynEditPrintPreview.SynEditPrint := SynEditPrint;
    ShowModal;
  finally
    Free;
  end;
}
end;

procedure TfrmCodeEdit.UpdateStatusBar;
begin
  if BrickComm.Port <> '' then
    barStatus.Panels[2].Text := BrickComm.NicePortName
  else
    barStatus.Panels[2].Text := sNoPort;

  barStatus.Panels[3].Text := BrickComm.BrickTypeName;
end;

procedure TfrmCodeEdit.mniCodeExplorerClick(Sender: TObject);
begin
  ShowCodeExplorer;
end;

procedure TfrmCodeEdit.pnlCodeExplorerDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  Accept := (Source.Control is TfrmCodeExplorer) or
            (Source.Control is TConstructForm);
end;

procedure TfrmCodeEdit.pnlCodeExplorerGetSiteInfo(Sender: TObject;
  DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint;
  var CanDock: Boolean);
begin
  CanDock := (DockClient is TfrmCodeExplorer) or (DockClient is TConstructForm);
end;

procedure TfrmCodeEdit.mniMacroManagerClick(Sender: TObject);
begin
  frmMacroManager.ShowModal;
end;

procedure TfrmCodeEdit.alMainUpdate(Action: TBasicAction; var Handled: Boolean);
var
  bAssigned, bBrickAlive, bBALSF, bROPS : Boolean;
begin
  // update all other actions here as well
  bAssigned   := True;
  bBrickAlive := BrickComm.IsOpen;
  bBALSF      := bBrickAlive and LocalStandardFirmware;
  bROPS       := FileIsROPS;

  actFileSave.Enabled           := bAssigned and TheEditor.Modified;
  actFileSaveAs.Enabled         := bAssigned;
  actFilePrintPreview.Enabled   := bAssigned;
  actFilePrint.Enabled          := bAssigned;

  actEditUndo.Enabled           := bAssigned and CanUndo;
  actEditRedo.Enabled           := bAssigned and CanRedo;
  actEditCut.Enabled            := bAssigned and CanCut;
  actEditCopy.Enabled           := bAssigned and Selected;
  actEditPaste.Enabled          := bAssigned and CanPaste;
  actEditDelete.Enabled         := actEditCut.Enabled;
  actEditSelectAll.Enabled      := bAssigned;
  actEditNextField.Enabled      := bAssigned;
  actEditCopyHTML.Enabled       := bAssigned;
  actEditCopyRTF.Enabled        := bAssigned;

  actSearchFind.Enabled         := bAssigned and CanFind;
  actSearchFindNext.Enabled     := bAssigned and CanFindNext;
  actSearchFindPrev.Enabled     := bAssigned and CanFindNext;
  actSearchReplace.Enabled      := bAssigned and CanReplace;
  actSearchGotoLine.Enabled     := bAssigned;
  actSearchProcList.Enabled     := bAssigned;

  actCompileCompile.Enabled     := bAssigned and FileCanBeCompiled;
  actCompileDownload.Enabled    := bAssigned and bBrickAlive and not bROPS;
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
end;

procedure TfrmCodeEdit.ConfigureTransferMenuItemVisibility(aList : TList;
  aMenuItem : TMenuItem; const aPrefix : string);
var
  i : integer;
  TI : TTransferItem;
  MI : TMenuItem;
  ext : string;
begin
  ext := LowerCase(ExtractFileExt(Filename));
  for i := 0 to aList.Count - 1 do
  begin
    TI := TTransferItem(aList[i]);
    MI := TMenuItem(aMenuItem.FindComponent(aPrefix + IntToStr(i)));
    if Assigned(MI) then
    begin
      MI.Visible := (not TI.Restrict) or
                    (Pos(ext, LowerCase(TI.Extension)) > 0);
    end;
  end;
end;

procedure TfrmCodeEdit.actCompilePauseExecute(Sender: TObject);
begin
  if not (IsNXT and EnhancedFirmware) or
     not CurrentProgram.Loaded(Filename) then
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

procedure TfrmCodeEdit.actCompileSingleStepExecute(Sender: TObject);
begin
{
  if not (IsNXT and EnhancedFirmware) then
    Exit;
  if CurrentProgram.SingleStep(True) then
  begin
    actCompilePause.Caption := sContinue;
    UpdateEditorPosition;
  end;
}
end;

procedure TfrmCodeEdit.FormDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  DragOverHelper(Sender, Source, X, Y, State, Accept);
end;

procedure TfrmCodeEdit.FormDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  DragDropHelper(Sender, Source, X, Y);
end;

procedure TfrmCodeEdit.DragDropHelper(Sender, Source: TObject; X, Y: Integer);
//var
//  i : integer;
begin
(*
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
*)
end;

procedure TfrmCodeEdit.DragOverHelper(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
{
if Source = frmNXTExplorer.lstFiles then
  begin
    Accept := True;
  end
  else
    Accept := False;
}
end;

function StartDoc(const DocName : String) : Integer;
begin
  Result := 40;
//  Result := ShellExecute(GetDesktopWindow(), 'open', PChar(DocName), '', '', SW_SHOWNORMAL);
end;

procedure HandleResponse(const res : integer);
var
  msg : string;
begin
  if res <= 32 then
  begin
{
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
}
    msg := 'Unknown error';
    ShowMessage(msg);
  end;
end;

procedure TfrmCodeEdit.actHelpNXCGuidePDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NXC_Guide.pdf'));
end;

procedure TfrmCodeEdit.actHelpNBCGuidePDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NBC_Guide.pdf'));
end;

procedure TfrmCodeEdit.actHelpNXCTutorialPDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NXC_Tutorial.pdf'));
end;

procedure TfrmCodeEdit.actHelpNBCTutorialPDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NBC_Tutorial.pdf'));
end;

{Event Handlers}

procedure TfrmCodeEdit.pmnuEditorPopup(Sender: TObject);
var
  i, j : integer;
  M : TMenuItem;
begin
  mniFindDeclaration.Visible := CanFindDeclaration;
  mniOpenFileAtCursor.Enabled := True;
  lmiEditUndo.Enabled      := CanUndo;
  lmiEditRedo.Enabled      := CanRedo;
  lmiEditCut.Enabled       := CanCut;
  lmiEditCopy.Enabled      := Selected;
  lmiEditPaste.Enabled     := CanPaste;
  lmiEditDelete.Enabled    := lmiEditCut.Enabled;
  lmiEditSelectAll.Enabled := True;
  lmiCopySpecial.Enabled   := True;
  lmiCopyHTML.Enabled      := True;
  lmiCopyRTF.Enabled       := True;
  mniToggleBreakpoint.Enabled := FileIsROPS;
  if Assigned(TheEditor.Marks) then
  begin
    for i := 0 to mniToggleBookmarks.Count - 1 do
    begin
      M := mniToggleBookmarks.Items[i];
      M.Checked := False;
      for j := 0 to TheEditor.Marks.Count - 1 do
      begin
        if TheEditor.Marks[j].BookmarkNumber = M.Tag then
        begin
          M.Checked := True;
          Break;
        end;
      end;
    end;
    for i := 0 to mniGotoBookmarks.Count - 1 do
    begin
      M := mniGotoBookmarks.Items[i];
      M.Checked := False;
      for j := 0 to TheEditor.Marks.Count - 1 do
      begin
        if TheEditor.Marks[j].BookmarkNumber = M.Tag then
        begin
          M.Checked := True;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TfrmCodeEdit.Preferences1Click(Sender: TObject);
begin
  //
end;

function TfrmCodeEdit.IsMaximized: Boolean;
begin
  Result := (WindowState = wsMaximized) or ((Left < 0) and (Top < 0));
end;

procedure TfrmCodeEdit.AddErrorMessage(const errMsg: string);
begin
  if TheErrors.Items.IndexOf(errMsg) = -1 then
    TheErrors.Items.Append(errMsg);
end;

procedure TfrmCodeEdit.mniOpenFileAtCursorClick(Sender: TObject);
begin
  OpenFileAtCursor;
end;

procedure TfrmCodeEdit.mniViewExplorerClick(Sender: TObject);
begin
  ShowCodeExplorer;
end;

procedure TfrmCodeEdit.mniFindDeclarationClick(Sender: TObject);
begin
//
end;

procedure TfrmCodeEdit.mnTopicSearchClick(Sender: TObject);
{$IFNDEF NXT_ONLY}
var
  Cmd : TSynEditorCommand;
  Ch : Char;
{$ENDIF}
begin
{$IFNDEF NXT_ONLY}
  Cmd := ecContextHelp;
  TheEditorProcessCommand(Sender, Cmd, Ch, nil);
{$ENDIF}
end;

procedure TfrmCodeEdit.ToggleBookmark(Sender: TObject);
begin
  TheEditor.ToggleBookmark(TMenuItem(Sender).Tag);
end;

procedure TfrmCodeEdit.GotoBookmark(Sender: TObject);
begin
  TheEditor.GotoBookMark(TMenuItem(Sender).Tag);
end;

function TfrmCodeEdit.CanFindDeclaration: Boolean;
begin
  Result := False;
end;

procedure TfrmCodeEdit.mniToggleBreakpointClick(Sender: TObject);
var
  Line: Longint;
begin
  if not FileIsROPS then Exit;
  Line := TheEditor.CaretY;
  if ce.HasBreakPoint(Filename, Line) then
    ce.ClearBreakPoint(Filename, Line)
  else
    ce.SetBreakPoint(Filename, Line);
  TheEditor.Refresh;
end;

procedure TfrmCodeEdit.TheErrorsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  i : integer;
  tmpStr : string;
  P : TPoint;
begin
  P := Point(X, Y);
  i := TheErrors.ItemAtPos(P, True);
  if i <> -1 then
  begin
    tmpStr := TheErrors.Items[i];
    if tmpStr <> TheErrors.Hint then
    begin
      TheErrors.Hint := TheErrors.Items[i];
      Application.ActivateHint(P);
    end;
  end;
end;

procedure TfrmCodeEdit.OpenFile(fname:string; lineNo : integer);
var
  ext : string;
  D : TRXEDumper;
begin
  if FileExists(fname) then
  begin
    ext := Lowercase(ExtractFileExt(fname));
    if (ext = '.rxe') or (ext = '.sys') or (ext = '.rtm') then
    begin
      IsNew := False;
      Filename := ChangeFileExt(fname, '.nbc');
      SetCaption(ExtractFileName(Filename));
      Application.ProcessMessages;
      D := TRXEDumper.Create;
      try
        D.LoadFromFile(fname);
        D.DumpRXE(TheEditor.Lines);
        TheEditor.Modified := True;
      finally
        D.Free;
      end;
      fname := Filename;
    end
    else if (ext = '.ric') then
    begin
      IsNew := False;
      if RICDecompAsData then
        Filename := ChangeFileExt(fname, '.h')
      else
        Filename := ChangeFileExt(fname, '.rs');
      SetCaption(ExtractFileName(Filename));
      Application.ProcessMessages;
      if RICDecompAsData then
        TheEditor.Lines.Text := TRICComp.RICToDataArray(fname, RICDecompNameFormat, lnNXCHeader)
      else
        TheEditor.Lines.Text := TRICComp.RICToText(fname);
      TheEditor.Modified := True;
      fname := Filename;
    end
    else
    begin
      IsNew    := False;
      Filename := fname;
      SetCaption(ExtractFileName(fname));
      TheEditor.Lines.LoadFromFile(fname);
      TheEditor.ReadOnly := FileIsReadOnly(fname);
      TheEditor.Modified := False;
      actFileSave.Enabled := False;
    end;
    SetSyntaxHighlighter;
    UpdateStatusBar;
    HookCompProp;
    SetActiveEditorFilename(fname);
    frmCodeExplorer.ProcessFile(fname, TheEditor.Lines.Text);
    frmCodeExplorer.RefreshEntireTree;
    if FileIsROPS then
      theROPSCompiler.Script.Assign(TheEditor.Lines);
    SelectLine(lineNo);
    AddRecentFile(fname);
  end;
end;

function TfrmCodeEdit.OpenFileOnPath(const fname: string): boolean;
var
  pName : string;
  fPaths : TStringList;
  i : integer;
begin
  Result := False;
  fPaths := TStringList.Create;
  try
    fPaths.Sorted := True;
    fPaths.Duplicates := dupIgnore;
    fPaths.Add(ExtractFilePath(Application.ExeName));
    fPaths.Add(GetCurrentDir);
    fPaths.Add(ExtractFilePath(FileName));
    if FileIsNQC then
      AddPaths(NQCIncludePath, fPaths)
    else if FileIsNBCOrNXC then
      AddPaths(NBCIncludePath, fPaths)
    else if FileIsMindScriptOrLASM then
      AddPaths(LCCIncludePath, fPaths);
    for i := 0 to fPaths.Count - 1 do begin
      pName := IncludeTrailingPathDelimiter(fPaths[i]) + fName;
      if FileExists(pName) then
      begin
        Result := True;
        OpenFile(pName);
        Exit;
      end;
    end;
  finally
    fPaths.Free;
  end;
end;

procedure TfrmCodeEdit.NewFile(fname:string);
begin
  IsNew    := True;
  Filename := fname;
  SetCaption(ExtractFileName(fname));
  TheEditor.Lines.Clear;
  TheEditor.Modified := False;
  actFileSave.Enabled := False;
  SetSyntaxHighlighter;
  UpdateStatusBar;
  HookCompProp;
  frmCodeExplorer.ProcessFile(fname, '');
  frmCodeExplorer.RefreshEntireTree;
end;

procedure TfrmCodeEdit.SetActiveHelpFile;
var
  AEF : TSynCustomHighlighter;
begin
  AEF := GetActiveEditorHighlighter;
  Self.HelpFile := Application.HelpFile;
  if FileIsNBC(AEF) then
  begin
    Self.HelpFile := ProgramDir + 'Help\nbc.hlp';
  end
  else if FileIsNXC(AEF) then
  begin
    Self.HelpFile := ProgramDir + 'Help\nxc.hlp';
  end
  else if FileIsSPC(AEF) then
  begin
    Self.HelpFile := ProgramDir + 'Help\spc.hlp';
  end
  else if FileIsNPG(AEF) then
  begin
    Self.HelpFile := ProgramDir + 'Help\npg.hlp';
  end
  else if FileIsRICScript(AEF) then
  begin
    Self.HelpFile := ProgramDir + 'Help\ricscript.hlp';
  end;
end;

procedure TfrmCodeEdit.SetFilename(const Value: string);
begin
  fFilename := Value;
//  AddRecentFile(Value);
end;

function TfrmCodeEdit.GetPosition: integer;
begin
//  Result := TheEditor.RowColToCharIndex(TheEditor.CaretXY);
end;

function TfrmCodeEdit.GetSource: string;
begin
  Result := TheEditor.Text;
end;

procedure TfrmCodeEdit.SetPosition(const Value: integer);
begin
//  TheEditor.CaretXY := TheEditor.CharIndexToRowCol(Value-1);
end;

procedure TfrmCodeEdit.UpdatePositionOnStatusBar;
var
  p: TPoint;
begin
  p := TheEditor.CaretXY;
  barStatus.Panels[0].Text := Format('%6d:%3d', [GetLineNumber(p.Y), p.X]);
end;

procedure TfrmCodeEdit.UpdateModeOnStatusBar;
const
  InsertModeStrs: array[boolean] of string = (S_Overwrite, S_Insert);
begin
  if TheEditor.ReadOnly then
    barStatus.Panels[4].Text := S_ReadOnly
  else
    barStatus.Panels[4].Text := InsertModeStrs[TheEditor.InsertMode];
end;

procedure TfrmCodeEdit.UpdateModifiedOnStatusBar;
const
  ModifiedStrs: array[boolean] of string = ('', S_Modified);
begin
  barStatus.Panels[5].Text := ModifiedStrs[TheEditor.Modified];
end;

function TfrmCodeEdit.DoCompileAction(bDown, bRun: Boolean) : Boolean;
var
  SaveCursor : TCursor;
begin
  if ShowCompilerStatus and UseInternalNBC and
     FileIsNBCOrNXCOrNPGOrRICScriptOrSPC then
    frmCompStatus.Show;
  Application.ProcessMessages;

  {Save cursor}
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    // check for auto save
    if AutoSaveFiles then
      SaveModifiedFiles;

    Result := CompileIt(DoDisplayErrors, TheEditor.Lines, TheErrors,
      Filename, Caption, bDown, bRun, HandleOnCompilerStatusChange,
      HandleOpenStateChanged);
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TfrmCodeEdit.StartTask(idx : integer);
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
      if theROPSCompiler.Running then
      begin
        FResume := True;
      end
      else
      begin
        if DoCompileAction(False, False) then
          theROPSCompiler.Execute;
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

procedure TfrmCodeEdit.UpdateEditorPosition;
var
  CD : TProgClumpData;
  CO : TOffset;
  i : integer;
begin
  fNXTCurrentOffset := nil;
  if (fNXTClump < CurrentProgram.Count) then
  begin
    CD := CurrentProgram[fNXTClump];
    if (Pos(Lowercase(Filename), LowerCase(CD.Filename)) > 0) then
    begin
      i := CD.Offsets.IndexOfPC(fNXTProgramCounter);
      if i <> -1 then
      begin
        CO := CD.Offsets[i];
        if LowerCase(ExtractFileName(CO.Filename)) = LowerCase(ExtractFilename(CD.Filename)) then
        begin
          fNXTCurrentOffset := CO;
          TheEditor.GotoLineNumber(CO.LineNumber);
        end
        else
        begin
          // if the filenames are different then open the new file
          if OpenFileOnPath(CO.Filename) then
          begin
            TheEditor.GotoLineNumber(CO.LineNumber);
          end;
        end;
      end;
    end;
  end;
end;

{Edit routines}

function TfrmCodeEdit.CanUndo : Boolean;
begin
  Result := TheEditor.CanUndo;
end;

function TfrmCodeEdit.CanCut : Boolean;
begin
  Result := not TheEditor.ReadOnly and Selected;
end;

function TfrmCodeEdit.CanPaste : Boolean;
begin
  Result := TheEditor.CanPaste;
end;

function TfrmCodeEdit.Selected : Boolean;
begin
  Result := TheEditor.SelAvail;
end;

procedure TfrmCodeEdit.Undo;
begin
  TheEditor.Undo;
end;

procedure TfrmCodeEdit.Redo;
begin
  TheEditor.Redo;
end;

procedure TfrmCodeEdit.CutSel;
begin
  TheEditor.CutToClipboard;
end;

procedure TfrmCodeEdit.CopySel;
begin
  if MultiFormatCopy then
  begin
    Clipboard.Open;
    try
      // put on the clipboard as plain text
      Clipboard.AsText := TheEditor.SelText;
      // put on the clipboard as HTML
      expHTML.ExportAsText := False;
      expHTML.ExportRange(TheEditor.Lines, TheEditor.BlockBegin, TheEditor.BlockEnd);
      expHTML.CopyToClipboard;
      // put on the clipboard as RTF
      expRTF.ExportAsText := False;
      expRTF.ExportRange(TheEditor.Lines, TheEditor.BlockBegin, TheEditor.BlockEnd);
      expRTF.CopyToClipboard;
    finally
      Clipboard.Close;
    end;
  end
  else
    TheEditor.CopyToClipboard;
end;

procedure TfrmCodeEdit.Paste;
begin
  TheEditor.PasteFromClipboard;
end;

procedure TfrmCodeEdit.DeleteSel;
begin
  TheEditor.ClearSelection;
end;

procedure TfrmCodeEdit.SelectAll;
begin
  TheEditor.SelectAll;
end;

procedure TfrmCodeEdit.GotoLine;
var
  G : TGotoForm;
begin
  G := TGotoForm.Create(nil);
  try
    G.MaxLine := GetLineNumber(TheEditor.Lines.Count);
    G.TheLine := GetLineNumber(TheEditor.CaretY);
    if G.ShowModal = mrOK then
    begin
      with TheEditor do begin
        SetFocus;
        CaretXY := Point(0, G.TheLine);
        BlockBegin := CaretXY;
        BlockEnd   := BlockBegin;
        EnsureCursorPosVisible;
      end;
    end;
  finally
    G.Free;
  end;
end;

procedure TfrmCodeEdit.NextField;
begin
  TheEditor.SelectDelimited;
end;

procedure TfrmCodeEdit.DoSaveAs;
begin
  dlgSave.FileName := FileName;
  if dlgSave.Execute then
  begin
    SaveFileAs(dlgSave.FileName);
    AddRecentFile(dlgSave.FileName);
  end;
end;

procedure TfrmCodeEdit.DoSave;
begin
  if IsNew then
    DoSaveAs
  else
    SaveFile;
end;

procedure TfrmCodeEdit.ExecFind;
begin
  ShowSearchReplaceDialog(TheEditor, FALSE);
end;

procedure TfrmCodeEdit.ExecFindNext;
begin
  DoSearchReplaceText(TheEditor, FALSE, FALSE);
End;

procedure TfrmCodeEdit.ExecFindPrev;
begin
  DoSearchReplaceText(TheEditor, FALSE, TRUE);
end;

procedure TfrmCodeEdit.ExecReplace;
begin
  ShowSearchReplaceDialog(TheEditor, TRUE);
end;

function TfrmCodeEdit.CanRedo: boolean;
begin
  Result := TheEditor.CanRedo;
end;

function TfrmCodeEdit.CanFind: boolean;
begin
  Result := TheEditor.Lines.Count > 0;
end;

function TfrmCodeEdit.CanFindNext: boolean;
begin
  Result := CanFind and (gsSearchText <> '');
end;

function TfrmCodeEdit.CanReplace: boolean;
begin
  Result := CanFind and not TheEditor.ReadOnly;
end;

procedure TfrmCodeEdit.ProcedureList;
var
  line : Integer;
  SL : TExploredLanguage;
  AEF : TSynCustomHighlighter;
begin
  AEF := GetActiveEditorHighlighter;
  SL := elNQC;
  if FileIsCPP(AEF) then
    SL := elCpp
  else if FileIsPascal(AEF) then
    SL := elPas
  else if FileIsROPS(AEF) then
    SL := elPas
  else if FileIsJava(AEF) then
    SL := elJava
  else if FileIsMindScript(AEF) then
    SL := elMindScript
  else if FileIsLASM(AEF) then
    SL := elLASM
  else if FileIsNBC(AEF) then
    SL := elNBC
  else if FileIsNXC(AEF) then
    SL := elNXC
  else if FileIsSPC(AEF) then
    SL := elSPC
  else if FileIsForth(AEF) then
    SL := elForth;
  line := TfmProcedureList.ShowForm(SL, TheEditor.Lines);
  if line <> -1 then
  begin
    TheEditor.GotoLineNumber(line);
    if TheEditor.CanFocus then
      TheEditor.SetFocus;
  end;
end;

procedure TfrmCodeEdit.DoCopyHTML(Sender: TObject);
var
  bb, be : TPoint;
begin
  if Selected then
  begin
    bb := TheEditor.BlockBegin;
    be := TheEditor.BlockEnd;
  end
  else
  begin
    bb := Point(1, 1);
    be := Point(MaxInt, MaxInt);
  end;
  Clipboard.Open;
  try
    // put on the clipboard as HTML in text format
    expHTML.ExportAsText := True;
    expHTML.ExportRange(TheEditor.Lines, bb, be);
    expHTML.CopyToClipboard;
    // put on the clipboard as HTML
    expHTML.ExportAsText := False;
    expHTML.ExportRange(TheEditor.Lines, bb, be);
    expHTML.CopyToClipboard;
  finally
    Clipboard.Close;
  end;
end;

procedure TfrmCodeEdit.DoCopyRTF(Sender: TObject);
var
  bb, be : TPoint;
begin
  if Selected then
  begin
    bb := TheEditor.BlockBegin;
    be := TheEditor.BlockEnd;
  end
  else
  begin
    bb := Point(1, 1);
    be := Point(MaxInt, MaxInt);
  end;
  Clipboard.Open;
  try
    // put on the clipboard as RTF in text format
    expRTF.ExportAsText := True;
    expRTF.ExportRange(TheEditor.Lines, bb, be);
    expRTF.CopyToClipboard;
    // put on the clipboard as RTF
    expRTF.ExportAsText := False;
    expRTF.ExportRange(TheEditor.Lines, bb, be);
    expRTF.CopyToClipboard;
  finally
    Clipboard.Close;
  end;
end;

procedure TfrmCodeEdit.SetCaption(const fname : string);
begin
  Caption  := fname;
end;

procedure TfrmCodeEdit.SetSyntaxHighlighter;
begin
  if IsNew then
  begin
    if PreferredLanguage = 0 then
      Self.Highlighter := SynNXCSyn
    else if PreferredLanguage = 1 then
      Self.Highlighter := SynNBCSyn;
  end
  else
    Self.Highlighter := GetHighlighterForFile(Filename);
  if ColorCoding then
  begin
    TheEditor.Highlighter := Self.Highlighter;
  end
  else
    TheEditor.Highlighter := nil;
  expHTML.Highlighter := Self.Highlighter;
  expRTF.Highlighter  := Self.Highlighter;
  SetActiveHelpFile;
end;

procedure TfrmCodeEdit.HookCompProp;
var
  HL : TSynCustomHighlighter;
begin
{$IFNDEF FPC}
  SynNBCCompProp.RemoveEditor(TheEditor);
  SynNXCCompProp.RemoveEditor(TheEditor);
  SynNPGCompProp.RemoveEditor(TheEditor);
  SynRSCompProp.RemoveEditor(TheEditor);
  SynROPSCompProp.RemoveEditor(TheEditor);
  SynSPCCompProp.RemoveEditor(TheEditor);
  scpParams.RemoveEditor(TheEditor);

  HL := Self.Highlighter;
  if HL = SynNBCSyn then begin
    SynNBCCompProp.AddEditor(TheEditor);
    scpParams.AddEditor(TheEditor);
  end
  else if HL = SynNXCSyn then begin
    SynNXCCompProp.AddEditor(TheEditor);
    scpParams.AddEditor(TheEditor);
  end
  else if HL = SynSPCSyn then begin
    SynSPCCompProp.AddEditor(TheEditor);
    scpParams.AddEditor(TheEditor);
  end
  else if HL = SynNPGSyn then
    SynNPGCompProp.AddEditor(TheEditor)
  else if HL = SynRSSyn then begin
    SynRSCompProp.AddEditor(TheEditor);
    scpParams.AddEditor(TheEditor);
  end
  else if HL = SynROPSSyn then begin
    SynROPSCompProp.AddEditor(TheEditor);
    scpParams.AddEditor(TheEditor);
  end;
{$ENDIF}
end;

{$IFNDEF FPC}
procedure TfrmCodeEdit.DoLoadAPI(cp : TSynCompletionProposal; aStrings : TStrings);
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
{$ENDIF}


procedure TfrmCodeEdit.LoadNXCCompProp;
begin
{$IFNDEF FPC}
  DoLoadAPI(SynNXCCompProp, fNXCAPIBase);
{$ENDIF}
end;

procedure TfrmCodeEdit.LoadSPCCompProp;
begin
{$IFNDEF FPC}
  DoLoadAPI(SynSPCCompProp, fSPCAPIBase);
{$ENDIF}
end;

procedure TfrmCodeEdit.AddUserDefinedFunctions(aStrings: TStrings);
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

procedure TfrmCodeEdit.SelectLine(lineNo: integer);
begin
  if lineNo > -1 then
  begin
    TheEditor.BlockBegin := Point(1, lineNo);
    TheEditor.BlockEnd   := Point(Length(TheEditor.Lines[lineNo-1])+1, lineNo);
    TheEditor.CaretXY    := TheEditor.BlockBegin;
  end;
end;

procedure TfrmCodeEdit.SaveModifiedFiles;
begin
  if TheEditor.Modified then
  begin
    if IsNew then
      DoSaveAs
    else
      SaveFile;
  end;
end;

procedure TfrmCodeEdit.DoDisplayErrors(aShow : boolean);
begin
  if aShow then
    ShowTheErrors
  else
    DoHideErrors;
end;

procedure TfrmCodeEdit.HandleOnCompilerStatusChange(Sender: TObject;
  const aStatusMsg: string; const bDone : boolean);
begin
  frmCompStatus.AddMessage(aStatusMsg);
end;

procedure TfrmCodeEdit.HandleOpenStateChanged(Sender: TObject);
begin
  UpdateStatusBar;
end;

procedure TfrmCodeEdit.HandleOnGetVarInfoByID(Sender: TObject;
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

procedure TfrmCodeEdit.HandleOnGetVarInfoByName(Sender: TObject;
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

procedure TfrmCodeEdit.ShowNXTTools;
begin
  frmNXTExplorer.Show;
end;

procedure TfrmCodeEdit.SaveFile;
begin
  SaveFileAs(Filename);
end;

procedure TfrmCodeEdit.SaveFileAs(fname:string);
var
  backfname : string;
begin
  Filename := fname;
  IsNew    := false;
  SetCaption(ExtractFileName(fname));
  if SaveBackup and FileExists(fname) then
  begin
    backfname := ChangeFileExt(fname,'.bak');
    DeleteFile(backfname);
    RenameFile(fname,backfname);
  end;
  TheEditor.Lines.SaveToFile(fname);
  TheEditor.Modified := False;
  actFileSave.Enabled := False;
  SetSyntaxHighlighter;
  HookCompProp;
end;

procedure TfrmCodeEdit.ShowTheErrors;
begin
  if TheErrors.Items.Count > 0 then
  begin
    barStatus.Panels[1].Text := sErrors;
    TheErrors.Visible := True;
    splErrors.Visible := True;
    TheErrors.ItemIndex:=0;
    TheErrorsClick(TheErrors);
  end
  else
  begin
    barStatus.Panels[1].Text := '';
    TheErrors.Visible := False;
    splErrors.Visible := False;
  end;
end;

procedure TfrmCodeEdit.DoHideErrors;
begin
  barStatus.Panels[1].Text := '';
  TheErrors.Items.Clear;
  TheErrors.Visible := False;
  splErrors.Visible := False;
end;

procedure TfrmCodeEdit.TheErrorsClick(Sender: TObject);
var
  i, epos, lnumb, c : integer;
  str, tmp : string;
  bThisFile : boolean;
begin
  if TheErrors.ItemIndex <> -1 then
    TheErrors.Hint := TheErrors.Items[TheErrors.ItemIndex];
  lnumb := -1;
  for i := TheErrors.ItemIndex downto 0 do
  begin
    str := TheErrors.Items[i];
    epos := Pos('line ',str);
    if epos > 0 then
    begin
     tmp := Copy(str,epos+5,6); // up to 6 digit line numbers
     epos := Pos(':', tmp); // should be a colon after the line number
     if epos > 0 then
     begin
       System.Delete(tmp, epos, MaxInt);
       Val(tmp,lnumb,c);
       break;
     end;
    end;
    if FileIsNBCOrNXCOrNPGOrRICScriptOrSPC then
      break;
  end;
  bThisFile := True;
  if lnumb >= 0 then
  begin
    if ZeroStart and ShowLineNumbers then
      inc(lnumb);
    // if there is a filename on this line and it does not match
    // the current filename then open that file in a new editor window at the
    // specified line
    i := Pos('file "', str);
    if i > 0 then
    begin
      str := Copy(str, i+6, MaxInt);
      i := Pos('":', str);
      Delete(str, i, MaxInt);
      bThisFile := AnsiUpperCase(str) = AnsiUpperCase(Filename);
    end;
    if bThisFile then
    begin
      SelectLine(lnumb);
    end
    else
    begin
      OpenFile(str, lnumb);
    end;
  end;
  if bThisFile then
    TheEditor.SetFocus;
end;

procedure TfrmCodeEdit.SynMacroRecStateChange(Sender: TObject);
begin
  case SynMacroRec.State of
    msRecording :
      barStatus.Panels[1].Text := sRecording;
  else
    barStatus.Panels[1].Text := '';
  end;
end;

{$IFNDEF FPC}
procedure TfrmCodeEdit.scpParamsExecute(Kind: SynCompletionType; Sender: TObject;
  var CurrentInput: String; var x, y: Integer; var CanExecute: Boolean);
var
  locLine, lookup: String;
  TmpX, savepos, StartX, ParenCounter, NameIdx, TmpLocation : Integer;
  FoundMatch : Boolean;
  p, BB, BE : TPoint;
  SCP : TSynCompletionProposal;
  AEF : TSynCustomHighlighter;
begin
  AEF := GetActiveEditorHighlighter;
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
          lookup := Copy(locLine, TmpX, SavePos - TmpX + 1);
          if FileIsNXC(AEF) then
            NameIdx := NXCCodeCompIndex(lookup)
          else if FileIsNBC(AEF) then
            NameIdx := NBCCodeCompIndex(lookup)
          else if FileIsRICScript(AEF) then
            NameIdx := RICScriptCodeCompIndex(lookup)
          else if FileIsROPS(AEF) then
            NameIdx := ROPSCodeCompIndex(lookup)
          else if FileIsSPC(AEF) then
            NameIdx := SPCCodeCompIndex(lookup);
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
      if FileIsNXC(AEF) then begin
        AddNXCCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := ', ';
      end
      else if FileIsNBC(AEF) then begin
        AddNBCCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := ', ';
      end
      else if FileIsRICScript(AEF) then begin
        AddRICScriptCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := ', ';
      end
      else if FileIsROPS(AEF) then begin
        AddROPSCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := '; ';
      end
      else if FileIsSPC(AEF) then begin
        AddSPCCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := ', ';
      end;
    end;
  end
  else
    SCP.ItemList.Clear;
end;
{$ENDIF}

procedure TfrmCodeEdit.FormCreate(Sender: TObject);
var
  R : TRegistry;
  S : TStringList;
begin
  IsNew := True;
  fFilename := sUntitled + '.nxc';
  fNXCAPIBase := TStringList.Create;
  fSPCAPIBase := TStringList.Create;
  CreateCompPropComponents;
  CreateMainFormHighlighters;
  CreatePascalScriptComponents;
  CreateMiscSynEditComponents;
  Application.OnHelp := HandleOnHelp;
  CreateSpiritPlugins;
  pnlCodeExplorer.DockOrientation := doVertical;
  AppIsClosing := False;
  newcount := 0;
  // set help file
  Application.HelpFile := ProgramDir + 'Help\BricxCC.HLP';
  HelpFile := Application.HelpFile;
  // load registry values
  R := TRegistry.Create;
  try
    LoadNXCAPIValues(R, nil, SynNXCSyn);
    LoadSPCAPIValues(R, nil, SynSPCSyn);
  finally
    R.Free;
  end;
  // initialize the highlighter data
  GetSortedHighlighters(Self, Highlighters, False);
  dlgOpen.Filter := GetHighlightersFilter(Highlighters) + SFilterAllFiles;
  dlgSave.Filter := dlgOpen.Filter;
{$IFNDEF FPC}
  PopulateROPSCompProp(SynROPSCompProp.InsertList, SynROPSCompProp.ItemList);
  LoadNBCCodeComplete(SynNBCCompProp.ItemList);
  LoadNPGCodeComplete(SynNPGCompProp.ItemList);
  LoadRSCodeComplete(SynRSCompProp.ItemList);
{$ENDIF}
  // hook up the ROPS compiler
  theROPSCompiler := Self.ce;
  CreateTheEditor;
  SetValuesFromPreferences;
  SetSyntaxHighlighter;
  SynAutoComp.AddEditor(TheEditor);
  SynMacroRec.AddEditor(TheEditor);
  // set the active (only) editor
  SetActiveEditor(TheEditor);
end;

procedure TfrmCodeEdit.FormShow(Sender: TObject);
begin
  {Show statusbar}
  barStatus.Visible  := ShowStatusbar;
  frmCodeExplorer.OnFinishedProcessing := HandleExplorerFinished;
  if CodeExplorerSettings.AutoShowExplorer then
    ShowCodeExplorer;
  // hook up the template form event handler
  if Assigned(ConstructForm) then
    ConstructForm.OnAddConstruct := HandleOnAddConstruct;
  {Add the Templates}
  if ShowTemplateForm then
    ShowTemplates(False);
  UpdateCompilerMenu;
  // hook macro manager
  frmMacroManager.MacroLibrary.MacroRecorder := SynMacroRec;
  if FileExists(DefaultMacroLibrary) then
    frmMacroManager.CurrentLibraryPath := DefaultMacroLibrary;
  ConfigureOtherFirmwareOptions;
  PopupMenu := ConstructForm.ConstructMenu;
  TheEditor.Font.Name := 'Monaco';//FontName;
  TheEditor.Font.Size := FontSize;
  Application.ProcessMessages;
end;

procedure TfrmCodeEdit.ceExecute(Sender: TPSScript);
begin
  ce.SetVarToInstance('SELF', Self);
  ce.SetVarToInstance('APPLICATION', Application);
end;

procedure TfrmCodeEdit.ceCompile(Sender: TPSScript);
begin
  //  Sender.AddMethod(Self, @TEditor.Writeln, 'procedure Writeln(s: string)');
  //  Sender.AddMethod(Self, @TEditor.Readln, 'procedure readln(var s: string)');
    Sender.AddRegisteredVariable('Self', 'TForm');
    Sender.AddRegisteredVariable('Application', 'TApplication');
end;

procedure TfrmCodeEdit.ceIdle(Sender: TObject);
begin
  Application.HandleMessage;
  if FResume then
  begin
    FResume := False;
    ce.Resume;
    FActiveLine := 0;
    TheEditor.Refresh;
  end;
end;

procedure TfrmCodeEdit.ceAfterExecute(Sender: TPSScript);
begin
  FActiveLine := 0;
end;

procedure TfrmCodeEdit.ceBreakpoint(Sender: TObject; const FileName: String;
  Position, Row, Col: Cardinal);
begin
  FActiveLine := Row;
  if (FActiveLine < TheEditor.TopLine + 2) or
     (FActiveLine > TheEditor.TopLine + TheEditor.LinesInWindow - 2) then
  begin
    TheEditor.TopLine := FActiveLine - (TheEditor.LinesInWindow div 2);
  end;
  TheEditor.CaretY := FActiveLine;
  TheEditor.CaretX := 1;
  TheEditor.Refresh;
end;

procedure TfrmCodeEdit.ceLineInfo(Sender: TObject; const FileName: String;
  Position, Row, Col: Cardinal);
begin
  if ce.Exec.DebugMode <> dmRun then
  begin
    FActiveLine := Row;
    if (FActiveLine < TheEditor.TopLine + 2) or
       (FActiveLine > TheEditor.TopLine + TheEditor.LinesInWindow - 2) then
    begin
      TheEditor.TopLine := FActiveLine - (TheEditor.LinesInWindow div 2);
    end;
    TheEditor.CaretY := FActiveLine;
    TheEditor.CaretX := 1;
    TheEditor.Refresh;
  end;
end;

function TfrmCodeEdit.ceNeedFile(Sender: TObject; const OrginFileName: String;
  var FileName, Output: String): Boolean;
var
  Path: string;
  F: TFileStream;
begin
  Result := False;
  if Filename <> '' then
    Path := ExtractFilePath(Filename)
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

function TfrmCodeEdit.HandleOnHelp(Command: Word; Data: Integer;
  var CallHelp: Boolean): Boolean;
begin
end;

procedure TfrmCodeEdit.SetValuesFromPreferences;
begin
  with TheEditor do
  begin
    if ShowTemplatePopup then
      PopupMenu := ConstructForm.ConstructMenu
    else
      PopupMenu := pmnuEditor;
    Font.Name := FontName;
    Font.Size := FontSize;
    if AltSetsSelMode then
      Options := Options + [eoAltSetsColumnMode]
    else
      Options := Options - [eoAltSetsColumnMode];
    if AutoIndentCode then
      Options := Options + [eoAutoIndent]
    else
      Options := Options - [eoAutoIndent];
{$IFNDEF FPC}
    if AutoMaxLeft then
      Options := Options + [eoAutoSizeMaxLeftChar]
    else
      Options := Options - [eoAutoSizeMaxLeftChar];
    if HighlightCurLine then
      Options := Options + [eoHighlightCurrentLine]
    else
      Options := Options - [eoHighlightCurrentLine];
{$ENDIF}
    // disable scroll arrows
    if DragAndDropEditing then
      Options := Options + [eoDragDropEditing]
    else
      Options := Options - [eoDragDropEditing];
    // drop files
    if EnhanceHomeKey then
      Options := Options + [eoEnhanceHomeKey]
    else
      Options := Options - [eoEnhanceHomeKey];
    if GroupUndo then
      Options := Options + [eoGroupUndo]
    else
      Options := Options - [eoGroupUndo];
    if HalfPageScroll then
      Options := Options + [eoHalfPageScroll]
    else
      Options := Options - [eoHalfPageScroll];
    // hide/show scrollbars
    if KeepCaretX then
      Options := Options + [eoKeepCaretX]
    else
      Options := Options - [eoKeepCaretX];
    // no caret
    // no selection
    if MoveCursorRight then
      Options := Options + [eoRightMouseMovesCursor]
    else
      Options := Options - [eoRightMouseMovesCursor];
    // scroll by one less
    // scroll hint follows
    // scroll past EOF
    if ScrollPastEOL then
      Options := Options + [eoScrollPastEol]
    else
      Options := Options - [eoScrollPastEol];
    // show scroll hint
    if ShowSpecialChars then
      Options := Options + [eoShowSpecialChars]
    else
      Options := Options - [eoShowSpecialChars];
    if UseSmartTabs then
      Options := Options + [eoSmartTabs, eoSmartTabDelete]
    else
      Options := Options - [eoSmartTabs, eoSmartTabDelete];
    // special line default FG
    if TabIndent then
      Options := Options + [eoTabIndent]
    else
      Options := Options - [eoTabIndent];
    if ConvertTabs then
      Options := Options + [eoTabsToSpaces]
    else
      Options := Options - [eoTabsToSpaces];
    if not KeepBlanks then
      Options := Options + [eoTrimTrailingSpaces]
    else
      Options := Options - [eoTrimTrailingSpaces];
  end;
  TheEditor.HideSelection    := HideSelection;
  TheEditor.TabWidth         := TabWidth;
  TheEditor.MaxUndo          := MaxUndo;
  TheEditor.MaxLeftChar      := MaxLeftChar;
  TheEditor.ExtraLineSpacing := ExtraLineSpacing;
  TheEditor.RightEdge        := RightEdgePosition;
  TheEditor.RightEdgeColor   := RightEdgeColor;
{$IFNDEF FPC}
  TheEditor.ActiveLineColor  := ActiveLineColor;
{$ENDIF}
  case ScrollBars of
    0 : TheEditor.ScrollBars := ssBoth;
    1 : TheEditor.ScrollBars := ssHorizontal;
    2 : TheEditor.ScrollBars := ssNone;
  else
    TheEditor.ScrollBars := ssVertical;
  end;
  TheEditor.Color                    := EditorColor;
  TheEditor.SelectedColor.Foreground := SelectionForeground;
  TheEditor.SelectedColor.Background := SelectionBackground;
  TheEditor.StructureLineColor       := StructureColor;
  with TheEditor.Gutter do
  begin
    Width := GutterWidth;
    AutoSize := AutoSizeGutter;
    Visible  := GutterVisible;
{$IFNDEF FPC}
    Color := GutterColor;
    LeadingZeros := ShowLeadingZeros;
{$ENDIF}
  end;
  TheEditor.Gutter.LeftOffset      := LeftOffset;
  TheEditor.Gutter.RightOffset     := RightOffset;
{$IFNDEF FPC}
  TheEditor.Gutter.DigitCount      := DigitCount;
  TheEditor.Gutter.ShowLineNumbers := ShowLineNumbers;
  TheEditor.Gutter.ZeroStart       := ZeroStart;
  TheEditor.Gutter.UseFontStyle    := UseFontStyle;
  TheEditor.Keystrokes.Assign(PrefForm.Keystrokes);
{$ELSE} // FPC
  TheEditor.Gutter.LineNumberPart.Visible := ShowLineNumbers;
  TheEditor.Gutter.LineNumberPart(0).ShowOnlyLineNumbersMultiplesOf := GutterLNMultiple;

  TheEditor.Gutter.CodeFoldPart.Visible := False;

  TheEditor.Gutter.SeparatorPart.Visible := True;
  TheEditor.Gutter.SeparatorPart(0).Index := 3;
{$ENDIF}
  AddEditorExpertCommands(TheEditor);
end;

procedure TfrmCodeEdit.HandleExplorerFinished(Sender: TObject);
begin
  if FileIsNXC then
    LoadNXCCompProp;
  if FileIsSPC then
    LoadSPCCompProp;
end;

procedure TfrmCodeEdit.HandleOnAddConstruct(Sender: TObject;
  const aTemplate: string; const aX: integer; const aY: integer);
begin
  AddConstructString(aTemplate, aX, aY);
end;

procedure TfrmCodeEdit.ShowCodeExplorer;
begin
  frmCodeExplorer.Show;
  pnlCodeExplorer.Visible := True;
  splCodeExplorer.Visible := True;
  frmCodeExplorer.FormShow(Self);
  frmCodeExplorer.Dock(pnlCodeExplorer, Rect(0, 0, pnlCodeExplorer.Width, pnlCodeExplorer.Height));
  frmCodeExplorer.Align := alClient;
end;

procedure TfrmCodeEdit.ShowTemplates(bSave : boolean);
var
  bVisible : boolean;
begin
  ConstructForm.ActiveLanguageIndex := ActiveLanguageIndex;
  ConstructForm.Rebuild(bSave);
  ConstructForm.Show;
  ConstructForm.FormShow(Self);
  ConstructForm.Dock(pnlCodeExplorer, Rect(0, pnlCodeExplorer.Height div 2, pnlCodeExplorer.Width, pnlCodeExplorer.Height div 2));
  ConstructForm.Align := alClient;
  bVisible := pnlCodeExplorer.VisibleDockClientCount > 0;
  pnlCodeExplorer.Visible := bVisible;
  splCodeExplorer.Visible := bVisible;
end;

const
  K_COMP_TRANSFER_PREFIX = 'mniCompilerXfer';

procedure TfrmCodeEdit.mniCompileClick(Sender: TObject);
begin
  ConfigureTransferMenuItemVisibility(CompXferList, mniCompile, K_COMP_TRANSFER_PREFIX);
end;

procedure TfrmCodeEdit.mniExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCodeEdit.UpdateCompilerMenu;
var
  i : integer;
  MI : TMenuItem;
  TI : TTransferItem;
begin
  // remove all compile menu transfer menu items first
  for i := mniCompile.Count - 1 downto 0 do
  begin
    MI := TMenuItem(mniCompile.Items[i]);
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
    MI := TMenuItem.Create(mniCompile);
    MI.Name := K_COMP_TRANSFER_PREFIX + IntToStr(i);
    MI.OnClick := HandleCompXferClick;
    MI.Caption := TI.Title;
    MI.Tag := i;
    mniCompile.Add(MI);
  end;
end;

procedure TfrmCodeEdit.ConfigureOtherFirmwareOptions;
begin
  SetFilterIndexFromLanguage;
end;

procedure TfrmCodeEdit.AddConstructString(constr:string; x, y : integer);
var
  str:string;
  i,j,tt,curposy,curposx:integer;
  escaped,fieldexists:boolean;
  p : TPoint;
begin
  if TheEditor.ReadOnly then Exit;
  if (x <> -1) and (y <> -1) then
  begin
    // drag and drop
    p := TheEditor.PixelsToRowColumn(Point(X, Y));
//    p.X := 0;
//    TheEditor.SetCaretAndSelection(p, p, p);
  end;
  if TheEditor.SelAvail then
    tt := TheEditor.BlockBegin.x - 1
  else
    tt := TheEditor.CaretXY.x - 1; // make it a zero-based column number
  fieldexists:=false;
  escaped:=false;
  str:='';
  for i:=1 to Length(constr) do
  begin
    if escaped then
    begin
      if constr[i] = '\' then str := str + '\';
      if constr[i] = '<' then tt := tt - TheEditor.TabWidth;
      if constr[i] = '>' then tt := tt + TheEditor.TabWidth;
      if constr[i] in ['=','<','>'] then
      begin
        str := str + #13#10;
        for j:= 1 to tt do str := str + ' ';
      end;
      escaped := false;
    end else begin
      if constr[i] = '"' then fieldexists := true;
      if constr[i] = '\' then
        escaped := true
      else
        str:=str+constr[i];
    end;
  end;
//  MainForm.SetFocus;
  TheEditor.SetFocus;
  curposy := TheEditor.CaretXY.Y;
  curposx := tt;
  TheEditor.SelText := str;
  if fieldexists then
  begin
    TheEditor.CaretXY := Point(curposx, curposy);
//    TheEditor.CaretXY := Point(TheEditor.CaretXY.X, curposy);
    NextField;
  end;
end;

function TfrmCodeEdit.ActiveLanguageName : string;
var
  SCH : TSynCustomHighlighter;
begin
  Result := PreferredLanguageName;
  SCH := TheEditor.Highlighter;
  if not Assigned(SCH) then
    SCH := GetHighlighterForFile(Filename);
  if Assigned(SCH) then
    Result := SCH.LanguageName;
end;

function TfrmCodeEdit.ActiveLanguageIndex: integer;
begin
  Result := Highlighters.IndexOf(ActiveLanguageName);
end;

procedure TfrmCodeEdit.HandleCompXferClick(Sender: TObject);
var
  i : integer;
  TI : TTransferItem;
begin
  if Sender is TMenuItem then
  begin
    i := TMenuItem(Sender).Tag;
    if (i >= 0) and (i < CompXferList.Count) then
    begin
      TI := CompXferList[i];
      ExecuteTransferItem(TI);
    end;
  end;
end;

procedure TfrmCodeEdit.SetFilterIndexFromLanguage;
begin
  if LocalFirmwareType = ftStandard then
  begin
    if PreferredLanguage = 0 then
      dlgOpen.FilterIndex := Highlighters.IndexOf('NXC')+1
    else if PreferredLanguage = 1 then
      dlgOpen.FilterIndex := Highlighters.IndexOf('Next Byte Codes')+1;
    dlgSave.FilterIndex   := dlgOpen.FilterIndex;
  end;
end;

procedure TfrmCodeEdit.ExecuteTransferItem(TI : TTransferItem);
var
  paramStr : string;
  BadParam : Boolean;
begin
  if not TI.Restrict or
    (LowerCase(TI.Extension) = LowerCase(ExtractFileExt(Filename))) then
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
        DoExecuteCommand(TI.Path, paramStr, LocalCompilerTimeout, TI.WorkingDir, TI.Wait);
      finally
        if TI.Close then BrickComm.Open;
      end;
    end;
  end;
end;

function TfrmCodeEdit.ProcessParams(aParams : string) : string;
var
  sTmp, sArg : string;
  cPos, oPos, dPos : Integer;
  bFoundMacro : Boolean;
begin
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
    if TheEditor.Modified or IsNew then
      DoSave;
  end;
  if Pos(TransferMacros[M_COL], Result) > 0 then // $COL
  begin
    sTmp := IntToStr(TheEditor.CaretX);
    Result := StringReplace(Result, TransferMacros[M_COL], sTmp, [rfReplaceAll]);
  end;
  if Pos(TransferMacros[M_ROW], Result) > 0 then // $ROW
  begin
    sTmp := IntToStr(TheEditor.CaretY);
    Result := StringReplace(Result, TransferMacros[M_ROW], sTmp, [rfReplaceAll]);
  end;
  if Pos(TransferMacros[M_CURTOKEN], Result) > 0 then // $CURTOKEN
  begin
    sTmp := TheEditor.WordAtCursor;
    Result := StringReplace(Result, TransferMacros[M_CURTOKEN], sTmp, [rfReplaceAll]);
  end;
  if Pos(TransferMacros[M_EDNAME], Result) > 0 then // $EDNAME
  begin
    sTmp := FileName;
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

procedure TfrmCodeEdit.FormActivate(Sender: TObject);
begin
  UpdateStatusBar;
  if TheErrors.Visible then
    barStatus.Panels[1].Text := sErrors
  else
    barStatus.Panels[1].Text := '';
  ChangeActiveEditor;
end;

procedure TfrmCodeEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if TheEditor.Modified then
  begin
    BringToFront;
    case MessageDlg(Format(S_FileChanged, [Caption]),
            mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      id_Yes: DoSave;
      id_No: TheEditor.Modified := False;
      id_Cancel: CanClose := False;
    end;
  end;
  if AppIsClosing and not CanClose then
    AppIsClosing := False;
end;

procedure TfrmCodeEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(ConstructForm) then
    ConstructForm.SaveTemplateTree;
//  Action := caFree;
end;

procedure TfrmCodeEdit.FormDestroy(Sender: TObject);
begin
  alMain.OnUpdate := nil;
  SynAutoComp.RemoveEditor(TheEditor);
{$IFNDEF FPC}
  SynMacroRec.RemoveEditor(TheEditor);
  SynNBCCompProp.RemoveEditor(TheEditor);
  SynNXCCompProp.RemoveEditor(TheEditor);
  SynNPGCompProp.RemoveEditor(TheEditor);
  SynRSCompProp.RemoveEditor(TheEditor);
  SynROPSCompProp.RemoveEditor(TheEditor);
  SynSPCCompProp.RemoveEditor(TheEditor);
  scpParams.RemoveEditor(TheEditor);
{$ENDIF}
{$IFNDEF FPC}
  if Assigned(frmCodeExplorer) then
  begin
    frmCodeExplorer.ClearTree;
  end;
  if Assigned(frmMacroManager) and Assigned(frmMacroManager.MacroLibrary) then
    frmMacroManager.MacroLibrary.ActiveEditor := nil;
{$ENDIF}
  FreeAndNil(fNXCAPIBase);
  FreeAndNil(fSPCAPIBase);
  if BrickComm.VerboseMode then
    Clipboard.AsText := BrickComm.LinkLog;
  BrickComm.OnOpenStateChanged := nil;
end;

procedure TfrmCodeEdit.ChangeActiveEditor;
begin
  frmMacroManager.MacroLibrary.ActiveEditor := TheEditor;
  // hook up the correct popup menu
  if ShowTemplatePopup then
    TheEditor.PopupMenu := ConstructForm.ConstructMenu
  else
    TheEditor.PopupMenu := pmnuEditor;
  ConstructForm.ActiveLanguageIndex := ActiveLanguageIndex;
  ConstructForm.Rebuild;
end;

procedure TfrmCodeEdit.UpdateSynComponents;
var
  i : Integer;
  C : TComponent;
{$IFNDEF FPC}
  TmpOptions : TSynCompletionOptions;
{$ENDIF}
begin
  // load NXC syntax completion proposal component
  fNXCAPIBase.Clear;
  fNXCAPIBase.AddStrings(SynNXCSyn.Commands);
  fNXCAPIBase.AddStrings(SynNXCSyn.Constants);
  fNXCAPIBase.AddStrings(SynNXCSyn.Keywords);
  fNXCAPIBase.Sort;
  // load SPC syntax completion proposal component
  fSPCAPIBase.Clear;
  fSPCAPIBase.AddStrings(SynSPCSyn.Commands);
  fSPCAPIBase.AddStrings(SynSPCSyn.Constants);
  fSPCAPIBase.AddStrings(SynSPCSyn.Keywords);
  fSPCAPIBase.Sort;
{$IFNDEF FPC}
  SynNXCCompProp.ItemList := fNXCAPIBase;
  SynSPCCompProp.ItemList := fSPCAPIBase;
  // configure code completion options for NQC, NBC, NXC, and RICScript
  if CCInsensitive then
    TmpOptions := [scoAnsiStrings, scoLimitToMatchedText, scoEndCharCompletion]
  else
    TmpOptions := [scoAnsiStrings, scoCaseSensitive, scoLimitToMatchedText, scoEndCharCompletion];
  SynNBCCompProp.Options := TmpOptions;
  SynNXCCompProp.Options := TmpOptions;
  SynSPCCompProp.Options := TmpOptions;
  SynRSCompProp.Options  := TmpOptions;
{$ENDIF}
//  SynAutoComp.AutoCompleteList.Assign(PrefForm.CodeTemplates);
  // also copy shortcut settings
  SynMacroRec.PlaybackShortCut := PlayMacroShortCut;
  SynMacroRec.RecordShortCut   := RecMacroShortCut;
{$IFNDEF FPC}
  scpParams.ShortCut           := ParamCompShortCut;
  for i := 0 to ComponentCount - 1 do begin
    C := Components[i];
    if C = scpParams then Continue;
    if C is TSynCompletionProposal then begin
      TSynCompletionProposal(C).ShortCut := CodeCompShortCut;
    end;
  end;
{$ENDIF}
// also set font pref for exporters
  expHTML.Font.Name := FontName;
  expHTML.Font.Size := FontSize;
  expRTF.Font.Name  := FontName;
  expRTF.Font.Size  := FontSize;
end;

procedure TfrmCodeEdit.mniEditClick(Sender: TObject);
begin
//
end;

procedure TfrmCodeEdit.mniSearchClick(Sender: TObject);
begin
//
end;

procedure TfrmCodeEdit.actSearchGrepSearchExecute(Sender: TObject);
begin
//  fGDE.Click(Sender);
end;

procedure TfrmCodeEdit.actSearchGrepResultsExecute(Sender: TObject);
begin
//  fGE.Click(Sender);
end;

procedure TfrmCodeEdit.actToolsNXTWatchListExecute(Sender: TObject);
begin
//  frmNXTWatchList.Visible := not frmNXTWatchList.Visible;
end;

procedure TfrmCodeEdit.HandleGetExpressions(Sender: TObject; aStrings: TStrings);
var
  i : integer;
begin
  aStrings.Clear;
  if IsNXT then
  begin
    if FileIsROPS then
    begin
      if ce.Exec.Status in [isRunning, isPaused] then
        for i := 0 to ce.Exec.GlobalVarNames.Count - 1 do
          aStrings.Add(ce.Exec.GlobalVarNames[i]);
      if ce.Exec.Status in [isRunning, isPaused] then
      begin
        for i := 0 to ce.Exec.CurrentProcVars.Count - 1 do
          aStrings.Add(ce.Exec.CurrentProcVars[i]);
        for i := 0 to ce.Exec.CurrentProcParams.Count -1 do
          aStrings.Add(ce.Exec.CurrentProcParams[i]);
      end;
    end
    else if FileIsNBCOrNXC then
    begin
      for i := 0 to CurrentProgram.Dataspace.Count - 1 do
        aStrings.Add(CurrentProgram.Dataspace[i].Name); // ?? PrettyName
    end;
  end;
end;

(*
procedure TfrmCodeEdit.HandleGetWatchValue(Info: TWatchInfo; var Value: string);
var
  i : integer;
begin
  if IsNXT then
  begin
    if FileIsROPS then
    begin
      Value := ce.GetVarContents(Info.Expression);
    end
    else if FileIsNBCOrNXC then
    begin
      i := CurrentProgram.Dataspace.IndexOfName(Info.Expression);
      if i <> -1 then
        Value := BrickComm.GetVariableValue(i);
    end;
  end;
end;
*)

procedure TfrmCodeEdit.HandleIsProcessAccessible(Sender: TObject; var Accessible: boolean);
var
  name : string;
begin
  if IsNXT then
  begin
    if FileIsROPS then
    begin
      Accessible := ce.Exec.Status in [isRunning, isPaused];
    end
    else if FileIsNBCOrNXC then
    begin
      Accessible := False;
      if BrickComm.GetCurrentProgramName(name) then
      begin
        Accessible := CurrentProgram.Loaded(name);
      end;
    end;
  end;
end;


{$IFDEF FPC}
initialization
  {$i ucodeedit.lrs}
{$ENDIF}

end.