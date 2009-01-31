unit MainUnitLaz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, ExtCtrls, Buttons, uPSComponent, uPSComponent_Default,
  uPSComponent_Forms, uPSComponent_Controls, uPSComponent_StdCtrls,
  Messages, Editor, Preferences;

type

  { TMainForm }

  TMainForm = class(TForm)
    aeApplicationEvents: TApplicationProperties;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    bvlEdit2: TBevel;
    bvlEdit1: TBevel;
    bvlFile1: TBevel;
    bvlFile2: TBevel;
    mniAbout: TMenuItem;
    N13: TMenuItem;
    mniWebpage: TMenuItem;
    mniContents: TMenuItem;
    mniIndex: TMenuItem;
    mniNqcGuide: TMenuItem;
    mniHowTo: TMenuItem;
    N12: TMenuItem;
    mniPosLoad: TMenuItem;
    mniPosSave: TMenuItem;
    mniPositions: TMenuItem;
    N11: TMenuItem;
    mniArrangeIcons: TMenuItem;
    mniCascade: TMenuItem;
    mniTileVertical: TMenuItem;
    mniTileHorizontal: TMenuItem;
    mniSepTools: TMenuItem;
    mniConfigureTools: TMenuItem;
    mniUnlockFirmware: TMenuItem;
    mniFirmware: TMenuItem;
    N10: TMenuItem;
    mniSoundConvert: TMenuItem;
    mniMIDIConversion: TMenuItem;
    mniClearMemory: TMenuItem;
    mniMemoryMap: TMenuItem;
    mniDatalog: TMenuItem;
    mniSendMessage: TMenuItem;
    N9: TMenuItem;
    mniNXTScreen: TMenuItem;
    mniNXTExplorer: TMenuItem;
    mniSpybotEEPROM: TMenuItem;
    mniSetvalues: TMenuItem;
    mniNewWatch: TMenuItem;
    mniRemote: TMenuItem;
    mniRCXJoystick: TMenuItem;
    mniRCXPiano: TMenuItem;
    mniWatch: TMenuItem;
    mniDiagnostics: TMenuItem;
    mniDirectControl: TMenuItem;
    mniStepOver: TMenuItem;
    mniTraceInto: TMenuItem;
    mniStop: TMenuItem;
    mniRun: TMenuItem;
    N8: TMenuItem;
    mniDownloadAndRun: TMenuItem;
    mniDownload: TMenuItem;
    mniCompileProgram: TMenuItem;
    mniFileToolbar1: TMenuItem;
    mniSearchToolbar1: TMenuItem;
    mniCompileToolbar1: TMenuItem;
    mniHelpToolbar1: TMenuItem;
    mniEditToolbar1: TMenuItem;
    mniToolsToolbar1: TMenuItem;
    mniToolbars: TMenuItem;
    mniMacroManager: TMenuItem;
    mniPBForthConsole: TMenuItem;
    mniWindowList: TMenuItem;
    N7: TMenuItem;
    mniProjectManager: TMenuItem;
    mniCodeExplorer: TMenuItem;
    mniStatusbar: TMenuItem;
    mniShowTemplates: TMenuItem;
    mniShowCodeListing: TMenuItem;
    mniHideErrors: TMenuItem;
    mniViewToolWindows: TMenuItem;
    mniGotoLineNumber: TMenuItem;
    mniProcedureList: TMenuItem;
    mniFindNext: TMenuItem;
    mniFindPrevious: TMenuItem;
    mniReplace: TMenuItem;
    N5: TMenuItem;
    mniFind: TMenuItem;
    mniPreferences: TMenuItem;
    N4: TMenuItem;
    mniNextField: TMenuItem;
    N3: TMenuItem;
    mniCopyRTF: TMenuItem;
    mniCopyHTML: TMenuItem;
    mniCopySpecial: TMenuItem;
    mniSelectAll: TMenuItem;
    mniCut: TMenuItem;
    mniCopy: TMenuItem;
    mniPaste: TMenuItem;
    mniDelete: TMenuItem;
    N2: TMenuItem;
    N1: TMenuItem;
    mniRedo: TMenuItem;
    mniUndo: TMenuItem;
    mnuMain: TMainMenu;
    cbrTop: TPanel;
    barStatus: TStatusBar;
    mniSepFiles: TMenuItem;
    mniSep3: TMenuItem;
    mniExit: TMenuItem;
    mniPrint: TMenuItem;
    mniPrintPreview: TMenuItem;
    mniPageSetup: TMenuItem;
    mniSep2: TMenuItem;
    mniInsertFile: TMenuItem;
    mniSep1: TMenuItem;
    mniClose: TMenuItem;
    mniCloseAll: TMenuItem;
    mniSaveAll: TMenuItem;
    mniSaveAs: TMenuItem;
    mniSave: TMenuItem;
    mniNew: TMenuItem;
    mniOpen: TMenuItem;
    mniHelp: TMenuItem;
    mniWindow: TMenuItem;
    mniTools: TMenuItem;
    mniCompile: TMenuItem;
    mniView: TMenuItem;
    mniSearch: TMenuItem;
    mniEdit: TMenuItem;
    mniFile: TMenuItem;
    dlgOpen: TOpenDialog;
    dlgOpenINI: TOpenDialog;
    pagMain: TPageControl;
    ogpFile: TPanel;
    ogpEdit: TPanel;
    ogpSearch: TPanel;
    pnlSep: TPanel;
    pnlPageControl: TPanel;
    pnlCodeExplorer: TPanel;
    osbNew: TSpeedButton;
    osbOpen: TSpeedButton;
    osbSave: TSpeedButton;
    osbClose: TSpeedButton;
    osbCloseAll: TSpeedButton;
    osbPreview: TSpeedButton;
    osbPrint: TSpeedButton;
    osbUndo: TSpeedButton;
    osbRedo: TSpeedButton;
    osbCut: TSpeedButton;
    osbCopy: TSpeedButton;
    osbPaste: TSpeedButton;
    osbDelete: TSpeedButton;
    osbPreferences: TSpeedButton;
    osbFind: TSpeedButton;
    osbReplace: TSpeedButton;
    osbGoto: TSpeedButton;
    osbProcList: TSpeedButton;
    ce: TPSScriptDebugger;
    PSDllPlugin: TPSDllPlugin;
    PSImport_Classes: TPSImport_Classes;
    PSImport_Controls: TPSImport_Controls;
    PSImport_DateUtils: TPSImport_DateUtils;
    PSImport_Forms: TPSImport_Forms;
    PSImport_StdCtrls: TPSImport_StdCtrls;
    dlgSaveINI: TSaveDialog;
    dlgSave: TSaveDialog;
    splCodeExplorer: TSplitter;
    procedure ceAfterExecute(Sender: TPSScript);
    procedure ceBreakpoint(Sender: TObject; const FileName: string; aPosition,
      Row, Col: Cardinal);
    procedure ceCompile(Sender: TPSScript);
    procedure ceExecute(Sender: TPSScript);
    procedure ceIdle(Sender: TObject);
    procedure ceLineInfo(Sender: TObject; const FileName: string; aPosition,
      Row, Col: Cardinal);
    function ceNeedFile(Sender: TObject; const OrginFileName: string;
      var FileName, Output: string): Boolean;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function HandleOnHelp(Command: Word; Data: Longint; var CallHelp: Boolean
      ): Boolean;
    procedure mniCompileClick(Sender: TObject);
    procedure pnlCodeExplorerDockOver(Sender: TObject; Source: TDragDockObject;
      X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure pnlCodeExplorerGetSiteInfo(Sender: TObject; DockClient: TControl;
      var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
  private
    { private declarations }
    newcount : integer;
    fMDI : Boolean;
    FResume : boolean;
    procedure WMClose(var Message: TWMClose); message WM_CLOSE;
    procedure CreateSpiritPlugins;
    procedure CloseAllEditors;
    procedure CloseEditor(E : TEditorForm; bAll : Boolean = False);
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
    function  SwitchToFile(fname: string): Boolean;
    procedure ConfigureOtherFirmwareOptions;
    function DoCompileAction(E : TEditorForm; bDown, bRun : Boolean) : boolean;
//    procedure DoToolbarExecute(act: TCustomAction; bar: TOfficeGradientPanel);
    procedure SetFilterIndexFromLanguage;
    procedure SetColorScheme;
    procedure ShowNXTTools;
    function  ProcessParams(aParams: string): string;
    procedure ConfigureTransferMenuItemVisibility(aList: TList;
      aMenuItem: TMenuItem; const aPrefix: string);
  public
    { public declarations }
    FActiveLine : integer;
    procedure ExecuteTransferItem(TI: TTransferItem);
    procedure UpdateProgramSlotMenuItems(index : Integer);
    procedure ChangeActiveEditor;
    procedure ShowCodeExplorer;
    procedure ShowTemplates;
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
    procedure OpenFile(aPath : string);
    procedure SaveDesktop(aFile : string);
    procedure LoadDesktop(aFile : string);
    property EditorFormCount : integer read GetEditorFormCount;
    property EditorForms[index : integer] : TEditorForm read GetEditorForm;
  end;

var
  MainForm: TMainForm;

implementation

{ TMainForm }

procedure TMainForm.pnlCodeExplorerDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState; var Accept: Boolean
  );
begin
  Accept := False;
//  Accept := (Source.Control is TfrmCodeExplorer) or
//            (Source.Control is TConstructForm);
end;

procedure TMainForm.mniCompileClick(Sender: TObject);
begin

end;

procedure TMainForm.ceAfterExecute(Sender: TPSScript);
begin
  FActiveLine := 0;
end;

procedure TMainForm.ceBreakpoint(Sender: TObject; const FileName: string;
  aPosition, Row, Col: Cardinal);
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

procedure TMainForm.ceCompile(Sender: TPSScript);
begin
//  Sender.AddMethod(Self, @TEditor.Writeln, 'procedure Writeln(s: string)');
//  Sender.AddMethod(Self, @TEditor.Readln, 'procedure readln(var s: string)');
  Sender.AddRegisteredVariable('Self', 'TForm');
  Sender.AddRegisteredVariable('Application', 'TApplication');
end;

procedure TMainForm.ceExecute(Sender: TPSScript);
begin
  ce.SetVarToInstance('SELF', Self);
  ce.SetVarToInstance('APPLICATION', Application);
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

procedure TMainForm.ceLineInfo(Sender: TObject; const FileName: string;
  aPosition, Row, Col: Cardinal);
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

function TMainForm.ceNeedFile(Sender: TObject; const OrginFileName: string;
  var FileName, Output: string): Boolean;
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

procedure TMainForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  // 9/13/2002 - JCH added code here to fix an Access Violation that would
  // occur if you closed the main window with an Editor window open.
  CloseAllEditors;
  SaveTemplateTree;
  SaveToolbars;
  MainWindowState := Integer(WindowState);
  WindowState := wsNormal;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  tmpSL : TStringList;
begin
  CreateSpiritPlugins;
  SetColorScheme;
  pnlCodeExplorer.DockOrientation := doVertical;
  AppIsClosing := False;
  pnlPageControl.Align := alClient;
  pnlPageControl.Visible := True;
  newcount := 0;
{
  ProgramBox.ItemIndex := 0;
  mniAddress0.Checked  := True; // default to LNP address 0
  mniPort0.Checked     := True; // default to LNP port 0
  {Let Windows know we accept dropped files}
  DragAcceptFiles(Handle,true);
}
  // set help file
  Application.HelpFile := ProgramDir + 'Help\BricxCC.HLP';
  HelpFile := Application.HelpFile;
  // initialize the highlighter data
  GetHighlighters(Self, Highlighters, False);
  dlgOpen.Filter := GetHighlightersFilter(Highlighters) + SFilterAllFiles;
  dlgSave.Filter := dlgOpen.Filter;
{
  SynForthCompProp.EndOfTokenChr := '';
  PopulateMindscriptWordList('', SynMindScriptCompProp.ItemList);
  PopulateCppCompProp(SynCppCompProp);
  PopulatePasCompProp(SynPasCompProp);
  LoadLASMCodeComplete(SynLASMCompProp.ItemList);
}
  LoadNBCCodeComplete(SynNBCCompProp.ItemList);
  LoadNPGCodeComplete(SynNPGCompProp.ItemList);
  LoadRSCodeComplete(SynRSCompProp.ItemList);
  LoadNXCConstants(SynNXCSyn.Constants);
  tmpSL := TStringList.Create;
  try
    tmpSL.AddStrings(SynNXCSyn.Commands);
    tmpSL.AddStrings(SynNXCSyn.Constants);
    tmpSL.AddStrings(SynNXCSyn.Keywords);
    tmpSL.Sort;
    SynNXCCompProp.ItemList := tmpSL;
  finally
    tmpSL.Free;
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if BrickComm.VerboseMode then
    Clipboard.AsText := BrickComm.LinkLog;
  BrickComm.OnOpenStateChanged := nil;
  MainForm := nil;
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  i : Integer;
  aParam : string;
  F : TEditorForm;
begin
  {Find the RCX}
  FindRCX(true);
  {Show statusbar}
  barStatus.Visible := ShowStatusbar;
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
  if CodeExplorerSettings.AutoShowExplorer then
    ShowCodeExplorer;
  {Add the Templates}
  ConstructForm.CreateConstructPanel;
  RestoreTemplateTree;
  if ShowTemplateForm then
    ShowTemplates;
  ConstructForm.CreateConstructPopup;
  ConstructForm.ConstructMenu.AutoPopup := ShowTemplatePopup;
  // process the toolbars
  RestoreToolbars;
  WindowState := TWindowState(MainWindowState);
  TogglingFormStyle := False;
  UpdateCompilerMenu;
  UpdateToolsMenu;
{
  // hook macro manager
  frmMacroManager.MacroLibrary.MacroRecorder := SynMacroRec;
  if FileExists(DefaultMacroLibrary) then
    frmMacroManager.CurrentLibraryPath := DefaultMacroLibrary;
}
  ConfigureOtherFirmwareOptions;
end;

function TMainForm.HandleOnHelp(Command: Word; Data: Longint;
  var CallHelp: Boolean): Boolean;
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
  else
    HelpFile := PChar(Application.HelpFile);
  Result := WinHelp(Handle, HelpFile, Command, Data);
  CallHelp := False;
end;

procedure TMainForm.pnlCodeExplorerGetSiteInfo(Sender: TObject;
  DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint;
  var CanDock: Boolean);
begin
  CanDock := False;
//  CanDock := (DockClient is TfrmCodeExplorer) or (DockClient is TConstructForm);
end;

procedure TMainForm.WMClose(var Message: TWMClose);
begin

end;

procedure TMainForm.CreateSpiritPlugins;
begin

end;

procedure TMainForm.CloseAllEditors;
begin

end;

procedure TMainForm.CloseEditor(E: TEditorForm; bAll: Boolean);
begin

end;

function TMainForm.GetEditorFormCount: integer;
begin

end;

function TMainForm.GetEditorForm(index: integer): TEditorForm;
begin

end;

function TMainForm.DoCreateEditorForm: TEditorForm;
begin

end;

procedure TMainForm.UpdateStatusBar;
begin

end;

procedure TMainForm.UpdateCompilerMenu;
begin

end;

procedure TMainForm.UpdateToolsMenu;
begin

end;

procedure TMainForm.HandleCompXferClick(Sender: TObject);
begin

end;

procedure TMainForm.HandleTransferClick(Sender: TObject);
begin

end;

procedure TMainForm.DoSaveAll;
begin

end;

function TMainForm.IsStandardFirmware(aFile: string): Boolean;
begin

end;

function TMainForm.SwitchToFile(fname: string): Boolean;
begin

end;

procedure TMainForm.ConfigureOtherFirmwareOptions;
begin

end;

function TMainForm.DoCompileAction(E: TEditorForm; bDown, bRun: Boolean
  ): boolean;
begin

end;

procedure TMainForm.SetFilterIndexFromLanguage;
begin

end;

procedure TMainForm.SetColorScheme;
begin

end;

procedure TMainForm.ShowNXTTools;
begin

end;

function TMainForm.ProcessParams(aParams: string): string;
begin

end;

procedure TMainForm.ConfigureTransferMenuItemVisibility(aList: TList;
  aMenuItem: TMenuItem; const aPrefix: string);
begin

end;

procedure TMainForm.ExecuteTransferItem(TI: TTransferItem);
begin

end;

procedure TMainForm.UpdateProgramSlotMenuItems(index: Integer);
begin

end;

procedure TMainForm.ChangeActiveEditor;
begin

end;

procedure TMainForm.ShowCodeExplorer;
begin

end;

procedure TMainForm.ShowTemplates;
begin

end;

procedure TMainForm.HandleOpenStateChanged(Sender: TObject);
begin

end;

procedure TMainForm.DoSaveAs(EdFrm: TEditorForm);
begin

end;

procedure TMainForm.DoSave(EdFrm: TEditorForm);
begin

end;

procedure TMainForm.DoPrint(EdFrm: TEditorForm);
begin

end;

procedure TMainForm.DoPrintPreview(EdFrm: TEditorForm);
begin

end;

procedure TMainForm.SelectProgram(idx: integer);
begin

end;

procedure TMainForm.StartTask(idx: integer);
begin

end;

procedure TMainForm.ClearMemory;
begin

end;

procedure TMainForm.DownloadFirmware;
begin

end;

procedure TMainForm.SaveModifiedFiles;
begin

end;

procedure TMainForm.UpdateSynComponents;
begin

end;

function TMainForm.ActiveEditorForm: TEditorForm;
begin

end;

function TMainForm.ActiveLanguageIndex: integer;
begin

end;

function TMainForm.ActiveLanguageName: string;
begin

end;

procedure TMainForm.ActivateEditorForm(index: Integer);
begin

end;

procedure TMainForm.ActivateEditorForm(E: TEditorForm);
begin

end;

procedure TMainForm.OpenFile(aPath: string);
begin

end;

procedure TMainForm.SaveDesktop(aFile: string);
begin

end;

procedure TMainForm.LoadDesktop(aFile: string);
begin

end;

initialization
  {$I mainunitlaz.lrs}

end.

