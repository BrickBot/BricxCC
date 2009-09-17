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
{$ELSE}
  LResources,
  LMessages,
  LCLType,
  LCLIntf,
  SynEditMarks,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin,
  uCodeExplorer, GX_ProcedureList, GotoLine, ConstructUnit, CodeUnit,
{


  GX_IDECodeTemplates, EditCodeTemplate, CodeTemplates,
  uMacroLib, uMacroForm, uMacroEditor,
}
//  uPSComponent_StdCtrls, uPSComponent_Controls, uPSComponent_Forms,
//  uPSComponent_Default, uPSComponent,
  SynEdit, SynEditEx, BricxccSynEdit, SynMacroRecorder, SynEditHighlighter,
  SynHighlighterNQC, SynHighlighterNBC, SynHighlighterNPG, SynHighlighterRS,
  SynEditAutoComplete, SynCompletionProposal, SynEditPlugins, SynEditTypes,
  SynEditRegexSearch, SynEditMiscClasses, SynEditSearch, {SynEditPrintTypes,}
  SynExportRTF, SynEditExport, SynExportHTML, SynEditKeyCmds;

type
  TfrmCodeEdit = class(TForm)
    BricxccSynEdit1: TBricxccSynEdit;
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
  private
    { Private declarations }
(*
    // synedit highlighters
    SynNXCSyn: TSynNXCSyn;
    SynNPGSyn: TSynNPGSyn;
    SynNBCSyn: TSynNBCSyn;
    SynRSSyn: TSynRSSyn;
    // completion proposal components
    SynNBCCompProp: TSynCompletionProposal;
    SynNXCCompProp: TSynCompletionProposal;
    SynNPGCompProp: TSynCompletionProposal;
    SynRSCompProp: TSynCompletionProposal;
    scpParams: TSynCompletionProposal;
    // misc synedit components
    SynMacroRec: TSynMacroRecorder;
    SynAutoComp: TSynEditAutoComplete;
    SynEditSearch: TSynEditSearch;
    SynEditRegexSearch: TSynEditRegexSearch;
    expRTF: TSynExporterRTF;
    expHTML: TSynExporterHTML;
    SynEditPrint: TSynEditPrint;
    procedure LoadNXCCompProp;
    procedure DoLoadAPI(cp: TSynCompletionProposal; aStrings: TStrings);
    procedure AddUserDefinedFunctions(aStrings : TStrings);
*)
  public
    { Public declarations }
  end;

var
  frmCodeEdit: TfrmCodeEdit;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

{
uses
  uNXTCodeComp, uNXCCodeComp, uRICCodeComp, uProgram, uCompStatus, uRICComp,
  uNXTClasses, uNBCInterface, uNBCCommon, uEditorExperts, ParamUtils,
//  uPSI_brick_common, uPSI_uSpirit, uPSI_FantomSpirit, uPSRuntime,
//  uPSDisassembly, uPSDebugger,
  uGlobals, uBasicPrefs, uHighlighterProcs, brick_common, FantomSpirit,
  dlgSearchText, dlgReplaceText, dlgConfirmReplace, DTestPrintPreview,
  ;
}


(*

var
  localSearchFromCaret: boolean;

function GetLineNumber(const aY : integer) : integer;
begin
  Result := aY;
  if ZeroStart and ShowLineNumbers then
    dec(Result);
end;


procedure TfrmCodeEdit.CreateMiscSynEditComponents;
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

procedure TfrmCodeEdit.CreateCompPropComponents;
begin
  SynNBCCompProp := TSynCompletionProposal.Create(Self);
  SynROPSCompProp := TSynCompletionProposal.Create(Self);
  scpParams := TSynCompletionProposal.Create(Self);
  SynNXCCompProp := TSynCompletionProposal.Create(Self);
  SynNPGCompProp := TSynCompletionProposal.Create(Self);
  SynRSCompProp := TSynCompletionProposal.Create(Self);
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
end;

procedure TfrmCodeEdit.CreateMainFormHighlighters;
begin
  SynNXCSyn := TSynNXCSyn.Create(Self);
  SynNPGSyn := TSynNPGSyn.Create(Self);
  SynNBCSyn := TSynNBCSyn.Create(Self);
  SynRSSyn := TSynRSSyn.Create(Self);
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
end;

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

procedure TfrmCodeEdit.LoadNXCCompProp;
begin
  DoLoadAPI(SynNXCCompProp, fNXCAPIBase);
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

procedure TfrmCodeEdit.UpdateSynComponents;
var
  i : Integer;
  C : TComponent;
  TmpOptions : TSynCompletionOptions;
begin
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

procedure TfrmCodeEdit.SynMacroRecStateChange(Sender: TObject);
begin
  case SynMacroRec.State of
    msRecording :
      barStatus.Panels[1].Text := sRecording;
  else
    barStatus.Panels[1].Text := '';
  end;
end;

procedure TfrmCodeEdit.mniFileClick(Sender: TObject);
begin
  {Show the recent files}
  ShowRecentFiles(Sender as TOfficeMenuItem, RecentFileClick);
end;

procedure TfrmCodeEdit.RecentFileClick(Sender: TObject);
begin
  OpenFile(GetRecentFileName(TOfficeMenuItem(Sender).Tag));
end;

procedure TfrmCodeEdit.mniShowTemplatesClick(Sender: TObject);
begin
  mniShowTemplates.Checked := not mniShowTemplates.Checked;
  ShowTemplateForm := mniShowTemplates.Checked;
  if ShowTemplateForm then
    ShowTemplates
  else
    ConstructForm.Close;
//  ConstructForm.Visible := ShowTemplateForm;
end;

procedure TfrmCodeEdit.mniShowCodeListingClick(Sender: TObject);
begin
  CodeForm.Visible := not CodeForm.Visible;
end;

procedure TfrmCodeEdit.DoHideErrors;
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

procedure TfrmCodeEdit.mniHideErrorsClick(Sender: TObject);
begin
  DoHideErrors;
end;

procedure TfrmCodeEdit.FormCreate(Sender: TObject);
begin
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
end;

procedure TfrmCodeEdit.FormShow(Sender: TObject);
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

procedure TfrmCodeEdit.StartTask(idx : integer);
var
  AEF : TEditorForm;
  binext : string;
begin
  if LocalStandardFirmware then
  begin
    AEF := ActiveEditorForm;
    if Assigned(AEF) and FileIsROPS(AEF) then
    begin
      if ce.Running then
      begin
        FResume := True;
      end
      else
      begin
        if DoCompileAction(AEF, False, False) then
          ce.Execute;
      end;
    end
    else if IsSpybotic then
      BrickComm.StartTask(8)
    else if IsNXT then
    begin
      if Assigned(AEF) and not FileIsRICScript(AEF) then
      begin
        if FileIsNPG(AEF) then
          binext := '.rpg'
        else
          binext := '.rxe';
        fNXTCurrentOffset := nil;
        if (binext = '.rxe') and not CurrentProgram.Loaded(AEF.Filename) then
          DoCompileAction(ActiveEditorForm, False, False);

        BrickComm.StartProgram(ChangeFileExt(ExtractFileName(AEF.Filename), binext));
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

procedure TfrmCodeEdit.mniViewClick(Sender: TObject);
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
  mniProjectManager.Enabled := FileIsCPPOrPascalOrJava(F);
end;

procedure TfrmCodeEdit.mniStatusbarClick(Sender: TObject);
begin
  mniStatusbar.Checked := not mniStatusbar.Checked;
  ShowStatusbar := mniStatusbar.Checked;
  barStatus.Visible := ShowStatusbar;
end;

procedure TfrmCodeEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fNQCAPIBase);
  FreeAndNil(fNXCAPIBase);
  if BrickComm.VerboseMode then
    Clipboard.AsText := BrickComm.LinkLog;
  BrickComm.OnOpenStateChanged := nil;
  MainForm := nil;
end;

procedure TfrmCodeEdit.DoSaveAs(EdFrm: TEditorForm);
begin
  dlgSave.FileName := EdFrm.FileName;
  if dlgSave.Execute then
  begin
    EdFrm.SaveFileAs(dlgSave.FileName);
    AddRecentFile(dlgSave.FileName);
  end;
end;

procedure TfrmCodeEdit.DoSave(EdFrm: TEditorForm);
begin
  if not Assigned(EdFrm) then Exit;
  if EdFrm.IsNew then
    DoSaveAs(EdFrm)
  else
    EdFrm.SaveFile;
end;

procedure TfrmCodeEdit.DoPrintPreview(EdFrm: TEditorForm);
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

procedure TfrmCodeEdit.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmCodeEdit.UpdateStatusBar;
begin
  if BrickComm.Port <> '' then
    barStatus.Panels[2].Text := BrickComm.NicePortName
  else
    barStatus.Panels[2].Text := sNoPort;

  barStatus.Panels[3].Text := BrickComm.BrickTypeName;
end;

procedure TfrmCodeEdit.HandleOnCompilerStatusChange(Sender: TObject;
  const StatusMsg: string);
begin
  frmCompStatus.AddMessage(StatusMsg);
end;

procedure TfrmCodeEdit.mniCodeExplorerClick(Sender: TObject);
begin
  ShowCodeExplorer;
end;

procedure TfrmCodeEdit.ShowCodeExplorer;
begin
  frmCodeExplorer.Show;
  pnlCodeExplorer.Visible := True;
  splCodeExplorer.Visible := True;
  frmCodeExplorer.FormShow(Self);
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

const
  K_COMP_TRANSFER_PREFIX = 'mniCompilerXfer';
  
procedure TfrmCodeEdit.UpdateCompilerMenu;
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

procedure TfrmCodeEdit.UpdateToolsMenu;
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

procedure TfrmCodeEdit.HandleCompXferClick(Sender: TObject);
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

procedure TfrmCodeEdit.HandleTransferClick(Sender: TObject);
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

procedure TfrmCodeEdit.ExecuteTransferItem(TI : TTransferItem);
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

function TfrmCodeEdit.ProcessParams(aParams : string) : string;
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

procedure TfrmCodeEdit.mniMacroManagerClick(Sender: TObject);
begin
  frmMacroManager.ShowModal;
end;

procedure TfrmCodeEdit.alMainUpdate(Action: TBasicAction; var Handled: Boolean);
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
  bROPS       := FileIsROPS(E);

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

  actCompileCompile.Enabled     := bAssigned and FileCanBeCompiled;
  actCompileDownload.Enabled    := bAssigned and ((bBrickAlive or FileIsForth(E)) and not bROPS);
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

procedure TfrmCodeEdit.scpParamsExecute(Kind: SynCompletionType; Sender: TObject;
  var CurrentInput: String; var x, y: Integer; var CanExecute: Boolean);
var
  locLine, lookup: String;
  TmpX, savepos, StartX, ParenCounter, NameIdx, TmpLocation : Integer;
  FoundMatch : Boolean;
  p, BB, BE : TPoint;
  SCP : TSynCompletionProposal;
  AEF : TEditorForm;
begin
  AEF := ActiveEditorForm;
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
          if FileIsMindScriptOrLASM(AEF) or FileIsPascal(AEF) then
            lookup := Uppercase(Copy(locLine, TmpX, SavePos - TmpX + 1))
          else
            lookup := Copy(locLine, TmpX, SavePos - TmpX + 1);
          if FileIsCPP(AEF) then
            NameIdx := CppCodeCompIndex(lookup)
          else if FileIsPascal(AEF) then
            NameIdx := PasCodeCompIndex(lookup)
          else if FileIsNQC(AEF) then
            NameIdx := NQCCodeCompIndex(lookup)
          else if FileIsNXC(AEF) then
            NameIdx := NXCCodeCompIndex(lookup)
          else if FileIsNBC(AEF) then
            NameIdx := NBCCodeCompIndex(lookup)
          else if FileIsRICScript(AEF) then
            NameIdx := RICScriptCodeCompIndex(lookup)
          else if FileIsROPS(AEF) then
            NameIdx := ROPSCodeCompIndex(lookup)
          else if FileIsMindScript(AEF) then
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
      if FileIsCPP(AEF) then begin
        AddCppCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := ', ';
      end
      else if FileIsPascal(AEF) then begin
        AddPasCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := '; ';
      end
      else if FileIsNQC(AEF) then begin
        AddNQCCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := ', ';
      end
      else if FileIsNXC(AEF) then begin
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
      else if FileIsMindScript(AEF) then begin
        AddMSCodeCompParams(SCP.ItemList, NameIdx);
        SCP.ParamSepString := ', ';
      end;
    end;
  end
  else
    SCP.ItemList.Clear;
end;

procedure TfrmCodeEdit.ConfigureOtherFirmwareOptions;
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

function TfrmCodeEdit.DoCompileAction(E : TEditorForm; bDown, bRun: Boolean) : Boolean;
begin
  Result := False;
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
       FileIsNBCOrNXCOrNPGOrRICScript(E) then
      frmCompStatus.Show;
    Application.ProcessMessages;
    Result := CompileIt(bDown, bRun);
  end;
end;

procedure TfrmCodeEdit.actFileNewExecute(Sender: TObject);
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

procedure TfrmCodeEdit.actFileOpenExecute(Sender: TObject);
var
  i : integer;
begin
  if dlgOpen.Execute then
  begin
    for i := 0 to dlgOpen.Files.Count - 1 do
      OpenFile(dlgOpen.Files[i]);
  end;
end;

procedure TfrmCodeEdit.actCompileCompileExecute(Sender: TObject);
begin
  DoCompileAction(ActiveEditorForm, False, False);
end;

procedure TfrmCodeEdit.actCompileDownloadExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  // download using forth console
  E := ActiveEditorForm;
  if FileIsForth(E) then
  begin
{$IFNDEF FPC}
    if Assigned(E) then
      frmForthConsole.DownloadScript(E.TheEditor.Lines);
{$ENDIF}
  end
  else
    DoCompileAction(E, True, False);
end;

procedure TfrmCodeEdit.actCompileDownloadRunExecute(Sender: TObject);
begin
  if DoCompileAction(ActiveEditorForm, True, True) then
    StartTask(0);
end;

procedure TfrmCodeEdit.actCompileRunExecute(Sender: TObject);
begin
  if IsRCX then
  begin
    SelectProgram(ProgramBox.ItemIndex);
  end;
  StartTask(0);
end;

procedure TfrmCodeEdit.actCompileStopExecute(Sender: TObject);
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

procedure TfrmCodeEdit.actCompileStepOverExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) and FileIsROPS(E) then
  begin
    if ce.Exec.Status = isRunning then
      ce.StepOver
    else
    begin
      if DoCompileAction(E, False, False) then
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

procedure TfrmCodeEdit.actCompileTraceIntoExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) and FileIsROPS(E) then
  begin
    if ce.Exec.Status = isRunning then
      ce.StepInto
    else
    begin
      if DoCompileAction(E, False, False) then
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

procedure TfrmCodeEdit.actCompileRunToCursorExecute(Sender: TObject);
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

procedure TfrmCodeEdit.actEditUndoExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.Undo;
end;

procedure TfrmCodeEdit.actEditRedoExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.Redo;
end;

procedure TfrmCodeEdit.actEditCutExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.CutSel;
end;

procedure TfrmCodeEdit.actEditCopyExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.CopySel;
end;

procedure TfrmCodeEdit.actEditPasteExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.Paste;
end;

procedure TfrmCodeEdit.actEditDeleteExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.DeleteSel;
end;

procedure TfrmCodeEdit.actEditSelectAllExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.SelectAll;
end;

procedure TfrmCodeEdit.actEditNextFieldExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.NextField;
end;

procedure TfrmCodeEdit.actEditPreferencesExecute(Sender: TObject);
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

procedure TfrmCodeEdit.actFileSaveExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    DoSave(E);
end;

procedure TfrmCodeEdit.actFileSaveAsExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    DoSaveAs(E);
end;

procedure TfrmCodeEdit.actFileCloseExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    CloseEditor(E);
end;

procedure TfrmCodeEdit.actFileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmCodeEdit.actSearchFindExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.ExecFind;
end;

procedure TfrmCodeEdit.actSearchFindNextExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.ExecFindNext;
end;

procedure TfrmCodeEdit.actSearchFindPrevExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.ExecFindPrev;
end;

procedure TfrmCodeEdit.actSearchReplaceExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.ExecReplace;
end;

procedure TfrmCodeEdit.actSearchGotoLineExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.GotoLine;
end;

procedure TfrmCodeEdit.actSearchProcListExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.ProcedureList;
end;

procedure TfrmCodeEdit.actEditCopyHTMLExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.DoCopyHTML(Sender);
end;

procedure TfrmCodeEdit.actEditCopyRTFExecute(Sender: TObject);
var
  E : TEditorForm;
begin
  E := ActiveEditorForm;
  if Assigned(E) then
    E.DoCopyRTF(Sender);
end;

procedure TfrmCodeEdit.SetFilterIndexFromLanguage;
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

procedure TfrmCodeEdit.ShowTemplates(bSave : boolean);
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

function TfrmCodeEdit.ActiveLanguageName : string;
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

function TfrmCodeEdit.ActiveLanguageIndex: integer;
begin
  Result := Highlighters.IndexOf(ActiveLanguageName);
end;

procedure TfrmCodeEdit.ConfigureTransferMenuItemVisibility(aList : TList; aMenuItem : TOfficeMenuItem; const aPrefix : string);
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

procedure TfrmCodeEdit.mniCompileClick(Sender: TObject);
begin
  ConfigureTransferMenuItemVisibility(CompXferList, mniCompile, K_COMP_TRANSFER_PREFIX);
end;

procedure TfrmCodeEdit.mniToolsClick(Sender: TObject);
begin
  ConfigureTransferMenuItemVisibility(TransferList, mniTools, K_TRANSFER_PREFIX);
end;

procedure TfrmCodeEdit.CreateSpiritPlugins;
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

procedure TfrmCodeEdit.ceAfterExecute(Sender: TPSScript);
begin
  FActiveLine := 0;
end;

procedure TfrmCodeEdit.ceBreakpoint(Sender: TObject; const FileName: String;
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

procedure TfrmCodeEdit.ceLineInfo(Sender: TObject; const FileName: String;
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

function TfrmCodeEdit.ceNeedFile(Sender: TObject; const OrginFileName: String;
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

procedure TfrmCodeEdit.actCompilePauseExecute(Sender: TObject);
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

procedure TfrmCodeEdit.UpdateEditorPosition;
var
  CD : TClumpData;
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
//  ce.Comp.on
end;

procedure TfrmCodeEdit.pagMainDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  DragOverHelper(Sender, Source, X, Y, State, Accept);
end;

procedure TfrmCodeEdit.pagMainDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  DragDropHelper(Sender, Source, X, Y);
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

procedure TfrmCodeEdit.pnlPageControlDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  DragOverHelper(Sender, Source, X, Y, State, Accept);
end;

procedure TfrmCodeEdit.pnlPageControlDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  DragDropHelper(Sender, Source, X, Y);
end;

procedure TfrmCodeEdit.DragDropHelper(Sender, Source: TObject; X, Y: Integer);
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

procedure TfrmCodeEdit.DragOverHelper(Sender, Source: TObject; X, Y: Integer;
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

procedure TfrmCodeEdit.actHelpNXCGuidePDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NXC_Guide.pdf'));
end;

procedure TfrmCodeEdit.actHelpNQCGuidePDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NQC_Guide.pdf'));
end;

procedure TfrmCodeEdit.actHelpNBCGuidePDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NBC_Guide.pdf'));
end;

procedure TfrmCodeEdit.actHelpNXCTutorialPDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NXC_Tutorial.pdf'));
end;

procedure TfrmCodeEdit.actHelpNQCTutorialPDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NQC_Tutorial.pdf'));
end;

procedure TfrmCodeEdit.actHelpNBCTutorialPDFExecute(Sender: TObject);
begin
  HandleResponse(StartDoc(ProgramDir + 'Documentation\NBC_Tutorial.pdf'));
end;

procedure TfrmCodeEdit.HandleExplorerFinished(Sender: TObject);
var
  AEF : TEditorForm;
begin
  AEF := ActiveEditorForm;
  if Assigned(AEF) then
  begin
    if FileIsNXC(AEF) then
      LoadNXCCompProp
    else if FileIsNQC(AEF) then
      LoadNQCCompProp;
  end;
end;

procedure TfrmCodeEdit.HandleOnAddConstruct(Sender : TObject; const aTemplate : string; const aX : integer = -1; const aY : integer = -1);
var
  AEF : TEditorForm;
begin
  AEF := ActiveEditorForm;
  if Assigned(AEF) then
    AEF.AddConstructString(aTemplate, aX, aY);
end;

procedure TfrmCodeEdit.NewFile(fname:string);
begin
  IsNew    := True;
  Filename := fname;
  SetCaption(ExtractFileName(fname));
  TheEditor.Modified := False;
  MainForm.actFileSave.Enabled := False;
  SetSyntaxHighlighter;
  UpdateStatusBar;
  HookCompProp;
  frmCodeExplorer.RefreshEntireTree;
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
      Screen.Cursor := crHourGlass;
      try
        D := TRXEDumper.Create;
        try
          D.LoadFromFile(fname);
          D.DumpRXE(TheEditor.Lines);
          TheEditor.Modified := True;
        finally
          D.Free;
        end;
      finally
        Screen.Cursor := crDefault;
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
      Screen.Cursor := crHourGlass;
      try
        if RICDecompAsData then
          TheEditor.Lines.Text := TRICComp.RICToDataArray(fname, RICDecompNameFormat, lnNXCHeader)
        else
          TheEditor.Lines.Text := TRICComp.RICToText(fname);
        TheEditor.Modified := True;
      finally
        Screen.Cursor := crDefault;
      end;
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
      MainForm.actFileSave.Enabled := False;
    end;
    MainForm.LoadDesktop(fname);
    SetSyntaxHighlighter;
    UpdateStatusBar;
    HookCompProp;
    frmCodeExplorer.ProcessFile(fname, TheEditor.Lines.Text);
    frmCodeExplorer.RefreshEntireTree;
    if FileIsROPS(Self) then
      MainForm.ce.Script.Assign(TheEditor.Lines);
    SelectLine(lineNo);
  end;
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
  MainForm.actFileSave.Enabled := False;
  if AutoSaveDesktop then
    MainForm.SaveDesktop(Filename);
  SetSyntaxHighlighter;
  HookCompProp;
end;

procedure TfrmCodeEdit.InsertFile(fname:string);
var
  tmpSL : TStringlist;
begin
  tmpSL := TStringList.Create;
  try
    tmpSL.LoadFromFile(fname);
    TheEditor.SelText := tmpSL.Text;
  finally
    tmpSL.Free;
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
      MainForm.expHTML.ExportAsText := False;
      MainForm.expHTML.ExportRange(TheEditor.Lines, TheEditor.BlockBegin, TheEditor.BlockEnd);
      MainForm.expHTML.CopyToClipboard;
      // put on the clipboard as RTF
      MainForm.expRTF.ExportAsText := False;
      MainForm.expRTF.ExportRange(TheEditor.Lines, TheEditor.BlockBegin, TheEditor.BlockEnd);
      MainForm.expRTF.CopyToClipboard;
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
    TheEditor.SetCaretAndSelection(p, p, p);
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
  MainForm.SetFocus;
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

{Event Handlers}

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
     tmp := Copy(str,epos+4,6); // up to 6 digit line numbers
     Val(tmp,lnumb,c);
     break;
    end;
    if FileIsNBCOrNXCOrNPGOrRICScript(Self) then
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
      MainForm.OpenFile(str, lnumb);
    end;
  end;
  if bThisFile then
    TheEditor.SetFocus;
end;

procedure TfrmCodeEdit.TheEditorKeyPress(Sender: TObject; var Key: Char);
begin
  {Ignore <Ctr><Alt> combinations when a macro was added}
  if Key = Chr(27) then
    GlobalAbort := True;
end;

procedure TfrmCodeEdit.TheEditorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ctrldown,altdown,shiftdown : boolean;
  ch : char;
  i : integer;
  str,constr : string;
begin
  ctrldown  := (ssCtrl in Shift);
  altdown   := (ssAlt in Shift);
  shiftdown := (ssShift in Shift);
  {Handle <Ctr><Alt> Combinations as macro's}
{$IFNDEF FPC}
  ch:=Char(MapVirtualKey(Key,2));
{$ELSE}
  ch := #0;
{$ENDIF}
  if MacrosOn and ctrldown and altdown and
     (((ch>='A') and (ch<='Z')) or ((ch>='0') and (ch<='9'))) then
  begin
    str:='';
    if ctrldown then str:=str+'<Ctrl>';
    if altdown then str:=str+'<Alt>';
    if shiftdown then str:=str+'<Shift>';
    str:=str+ch;
    for i:=1 to macronumb do
    begin
      if Pos(str,Macros[i]) = 1 then
      begin
        constr:=Copy(Macros[i],Length(str)+2,1000);
        AddConstructString(constr);
        Key:=0;
        break;
      end;
    end;
  end
  else if ctrldown and (Key = $0D) then begin
    OpenFileAtCursor;
  end;
end;


procedure TfrmCodeEdit.FormActivate(Sender: TObject);
begin
  UpdateStatusBar;
  if TheErrors.Visible then
    MainForm.barStatus.Panels[1].Text := sErrors
  else
    MainForm.barStatus.Panels[1].Text := '';
  MainForm.ChangeActiveEditor;
end;

procedure TfrmCodeEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  // 9/13/2001 JCH added id_No case to fix problems when closing main form
  // while files are modified.  Added check for assigned(MainForm) to protect
  // against access violations
  if TheEditor.Modified then
  begin
    BringToFront;
    case MessageDlg(Format(S_FileChanged, [Caption]),
            mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      id_Yes: if Assigned(MainForm) then MainForm.DoSave(Self);
      id_No: TheEditor.Modified := False;
      id_Cancel: CanClose:=false;
    end;
  end;
  if AppIsClosing and not CanClose then
    AppIsClosing := False;
end;

procedure TfrmCodeEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(MainForm) then
  begin
    MainForm.barStatus.Panels[0].Text := '';
    MainForm.barStatus.Panels[4].Text := '';
    MainForm.barStatus.Panels[5].Text := '';
  end;
  Action := caFree;
end;

procedure TfrmCodeEdit.FormShow(Sender: TObject);
begin
  PopupMenu := ConstructForm.ConstructMenu;
  TheEditor.Font.Name := FontName;
  TheEditor.Font.Size := FontSize;
end;

procedure TfrmCodeEdit.FormCreate(Sender: TObject);
begin
  CreatePopupMenu;
  CreateTheEditor;
  SetValuesFromPreferences;
  SetSyntaxHighlighter;
  MainForm.SynAutoComp.AddEditor(TheEditor);
  MainForm.SynMacroRec.AddEditor(TheEditor);
end;

procedure TfrmCodeEdit.SetSyntaxHighlighter;
begin
  if IsNew then
  begin
    if LocalFirmwareType = ftStandard then
    begin
      if PreferredLanguage = 0 then
      begin
        if LocalBrickType = SU_NXT then
          Self.Highlighter := MainForm.SynNXCSyn
        else
          Self.Highlighter := MainForm.SynNQCSyn;
      end
      else if PreferredLanguage = 1 then
        Self.Highlighter := MainForm.SynMindScriptSyn
      else if PreferredLanguage = 2 then
        Self.Highlighter := MainForm.SynLASMSyn
      else if PreferredLanguage = 3 then
        Self.Highlighter := MainForm.SynNBCSyn
      else
        Self.Highlighter := MainForm.SynNXCSyn;
    end
    else if LocalFirmwareType = ftBrickOS then
      Self.Highlighter := MainForm.SynCppSyn
    else if LocalFirmwareType = ftPBForth then
      Self.Highlighter := MainForm.SynForthSyn
    else if LocalFirmwareType = ftLeJOS then
      Self.Highlighter := MainForm.SynJavaSyn;
  end
  else
    Self.Highlighter := GetHighlighterForFile(Filename);
  if ColorCoding then
  begin
    TheEditor.Highlighter := Self.Highlighter;
  end
  else
    TheEditor.Highlighter := nil;
  MainForm.expHTML.Highlighter := Self.Highlighter;
  MainForm.expRTF.Highlighter  := Self.Highlighter;
  SetActiveHelpFile;
end;

procedure DoSearchReplaceText(aEditor : TSynEdit; AReplace, ABackwards: boolean);
var
  Options: TSynSearchOptions;
begin
  if AReplace then
    Options := [ssoPrompt, ssoReplace, ssoReplaceAll]
  else
    Options := [];
  if ABackwards then
    Include(Options, ssoBackwards);
  if gbSearchCaseSensitive then
    Include(Options, ssoMatchCase);
  if not localSearchFromCaret then
    Include(Options, ssoEntireScope);
  if gbSearchSelectionOnly then
    Include(Options, ssoSelectedOnly);
  if gbSearchWholeWords then
    Include(Options, ssoWholeWord);
{$IFNDEF FPC}
  if gbSearchRegex then
    aEditor.SearchEngine := MainForm.SynEditRegexSearch
  else
    aEditor.SearchEngine := MainForm.SynEditSearch;
{$ENDIF}
  if aEditor.SearchReplace(gsSearchText, gsReplaceText, Options) = 0 then
  begin
{$IFNDEF FPC}
    MessageBeep(MB_ICONASTERISK);
{$ENDIF}
    if ssoBackwards in Options then
      aEditor.BlockEnd := aEditor.BlockBegin
    else
      aEditor.BlockBegin := aEditor.BlockEnd;
    aEditor.CaretXY := aEditor.BlockBegin;
  end;

  if ConfirmReplaceDialog <> nil then
    ConfirmReplaceDialog.Free;
end;

procedure ShowSearchReplaceDialog(aEditor : TSynEdit; AReplace: boolean);
var
  dlg: TTextSearchDialog;
begin
  if AReplace then
    dlg := TTextReplaceDialog.Create(nil)
  else
    dlg := TTextSearchDialog.Create(nil);
  with dlg do
  try
    // assign search options
    SearchBackwards := gbSearchBackwards;
    SearchCaseSensitive := gbSearchCaseSensitive;
    SearchFromCursor := gbSearchFromCaret;
    SearchInSelectionOnly := gbSearchSelectionOnly;
    // start with last search text
    SearchText := gsSearchText;
    if gbSearchTextAtCaret then begin
      // if something is selected search for that text
      if aEditor.SelAvail and (aEditor.BlockBegin.Y = aEditor.BlockEnd.Y)
      then
        SearchText := aEditor.SelText
      else
        SearchText := aEditor.GetWordAtRowCol(aEditor.CaretXY);
    end;
    SearchTextHistory := gsSearchTextHistory;
    if AReplace then with dlg as TTextReplaceDialog do begin
      ReplaceText := gsReplaceText;
      ReplaceTextHistory := gsReplaceTextHistory;
    end;
    SearchWholeWords := gbSearchWholeWords;
    SearchRegularExpression := gbSearchRegex;
    if ShowModal = mrOK then begin
      gbSearchBackwards := SearchBackwards;
      gbSearchCaseSensitive := SearchCaseSensitive;
      gbSearchFromCaret := SearchFromCursor;
      gbSearchSelectionOnly := SearchInSelectionOnly;
      gbSearchWholeWords := SearchWholeWords;
      gbSearchRegex := SearchRegularExpression;
      gsSearchText := SearchText;
      gsSearchTextHistory := SearchTextHistory;
      if AReplace then with dlg as TTextReplaceDialog do begin
        gsReplaceText := ReplaceText;
        gsReplaceTextHistory := ReplaceTextHistory;
      end;
      localSearchFromCaret := gbSearchFromCaret;
      if gsSearchText <> '' then begin
        DoSearchReplaceText(aEditor, AReplace, gbSearchBackwards);
        localSearchFromCaret := True;
      end;
    end;
  finally
    dlg.Free;
  end;
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
  if Changes * [scAll, scCaretX, scCaretY] <> [] then begin
    UpdatePositionOnStatusBar;
  end;
  // InsertMode property has changed
  if Changes * [scAll, scInsertMode, scReadOnly] <> [] then begin
    UpdateModeOnStatusBar;
  end;
  // Modified property has changed
  if Changes * [scAll, scModified] <> [] then
    UpdateModifiedOnStatusBar;
end;

procedure TfrmCodeEdit.UpdateStatusBar;
begin
  UpdatePositionOnStatusBar;
  UpdateModeOnStatusBar;
  UpdateModifiedOnStatusBar;
end;

procedure TfrmCodeEdit.UpdatePositionOnStatusBar;
var
  p: TPoint;
begin
  p := TheEditor.CaretXY;
  MainForm.barStatus.Panels[0].Text := Format('%6d:%3d', [GetLineNumber(p.Y), p.X]);
end;

procedure TfrmCodeEdit.UpdateModeOnStatusBar;
const
  InsertModeStrs: array[boolean] of string = (S_Overwrite, S_Insert);
begin
  if TheEditor.ReadOnly then
    MainForm.barStatus.Panels[4].Text := S_ReadOnly
  else
    MainForm.barStatus.Panels[4].Text := InsertModeStrs[TheEditor.InsertMode];
end;

procedure TfrmCodeEdit.UpdateModifiedOnStatusBar;
const
  ModifiedStrs: array[boolean] of string = ('', S_Modified);
begin
  MainForm.barStatus.Panels[5].Text := ModifiedStrs[TheEditor.Modified];
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
  TheEditor.Color            := EditorColor;
  TheEditor.SelectedColor.Foreground := SelectionForeground;
  TheEditor.SelectedColor.Background := SelectionBackground;
  TheEditor.StructureLineColor       := StructureColor;
  with TheEditor.Gutter do
  begin
    Color := GutterColor;
    Width := GutterWidth;
    AutoSize := AutoSizeGutter;
    Visible  := GutterVisible;
    LeadingZeros := ShowLeadingZeros;
  end;
  TheEditor.Gutter.DigitCount      := DigitCount;
  TheEditor.Gutter.LeftOffset      := LeftOffset;
  TheEditor.Gutter.RightOffset     := RightOffset;
  TheEditor.Gutter.ShowLineNumbers := ShowLineNumbers;
  TheEditor.Gutter.ZeroStart       := ZeroStart;
  TheEditor.Gutter.UseFontStyle    := UseFontStyle;
  TheEditor.Keystrokes.Assign(PrefForm.Keystrokes);
  AddEditorExpertCommands(TheEditor);
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
  mniToggleBreakpoint.Enabled := FileIsROPS(Self);
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

procedure TfrmCodeEdit.lmiEditUndoClick(Sender: TObject);
begin
  Undo;
end;

procedure TfrmCodeEdit.lmiEditRedoClick(Sender: TObject);
begin
  Redo;
end;

procedure TfrmCodeEdit.lmiEditCutClick(Sender: TObject);
begin
  CutSel;
end;

procedure TfrmCodeEdit.lmiEditCopyClick(Sender: TObject);
begin
  CopySel;
end;

procedure TfrmCodeEdit.lmiEditPasteClick(Sender: TObject);
begin
  Paste;
end;

procedure TfrmCodeEdit.lmiEditDeleteClick(Sender: TObject);
begin
  DeleteSel;
end;

procedure TfrmCodeEdit.lmiEditSelectAllClick(Sender: TObject);
begin
  SelectAll;
end;

procedure TfrmCodeEdit.FormDestroy(Sender: TObject);
begin
{$IFDEF FPC}
  if Assigned(MainForm) then
  begin
    MainForm.SynAutoComp.RemoveEditor(TheEditor);
    MainForm.SynMacroRec.RemoveEditor(TheEditor);
    MainForm.SynNQCCompProp.RemoveEditor(TheEditor);
    MainForm.SynMindScriptCompProp.RemoveEditor(TheEditor);
    MainForm.SynLASMCompProp.RemoveEditor(TheEditor);
    MainForm.SynNBCCompProp.RemoveEditor(TheEditor);
    MainForm.SynNXCCompProp.RemoveEditor(TheEditor);
    MainForm.SynNPGCompProp.RemoveEditor(TheEditor);
    MainForm.SynRSCompProp.RemoveEditor(TheEditor);
    MainForm.SynForthCompProp.RemoveEditor(TheEditor);
    MainForm.SynCppCompProp.RemoveEditor(TheEditor);
    MainForm.SynPasCompProp.RemoveEditor(TheEditor);
    MainForm.SynROPSCompProp.RemoveEditor(TheEditor);
//    MainForm.SynJavaCompProp.RemoveEditor(TheEditor);
    MainForm.scpParams.RemoveEditor(TheEditor);
  end;
{$ENDIF}
  if Assigned(frmCodeExplorer) then
  begin
    frmCodeExplorer.ClearTree;
  end;
  if Assigned(frmMacroManager) and Assigned(frmMacroManager.MacroLibrary) then
    frmMacroManager.MacroLibrary.ActiveEditor := nil;
end;

function GetNBCErrorString(iErrCode : Integer) : string;
begin
  case iErrCode of
    -1 : Result := 'Compile failure.';
    -2 : Result := 'Download to the NXT failed.';
    -3 : Result := 'Firmware version on NXT does not match targetted firmware version';
  else
    Result := 'Unknown NBC error code (' + IntToStr(iErrCode) + ')';
  end;
end;

function GetLASMErrorString(iErrCode : Integer) : string;
begin
  case iErrCode of
    -2 : Result := 'vpbcom.dll not registered or unable to load its DLLs';
    -3 : Result := 'serial port could not be opened and/or configured';
    -4 : Result := 'tower not connected';
    -5 : Result := 'tower not alive';
    -6 : Result := 'no (or invalid) PBrick response';
    -7 : Result := 'no firmware in PBrick';
    -8 : Result := 'battery level too low';
    -9 : Result := 'wrong brick type';
    -11 : Result := 'PBrick comms failed';
    -12 : Result := 'compiler was too busy';
    -13 : Result := 'no driver found';
    -14 : Result := 'failed to unlock PBrick';
  else
    Result := 'Unknown LCC32 error code (' + IntToStr(iErrCode) + ')';
  end;
end;

function GetGNUErrorString(iErrCode : Integer) : string;
begin
  case iErrCode of
    -2 : Result := 'Errors found during compilation';
  else
    Result := 'Unknown GNU error code (' + IntToStr(iErrCode) + ')';
  end;
end;

function OptionalEquals : string;
begin
  Result := '';
  if not FileIsNQC then
    Result := '=';
end;

function TempPath: string;
var
  i: integer;
begin
  SetLength(Result, MAX_PATH);
{$IFNDEF FPC}
  i := GetTempPath(Length(Result), PChar(Result));
  SetLength(Result, i);
{$ELSE}
  Result := '~';
{$ENDIF}
  IncludeTrailingPathDelimiter(Result);
end;

function GetIncludeDirectives(aPath : string) : string;
var
  p : Integer;
  s : string;
  OE : string;
begin
  Result := '';
  OE := OptionalEquals;
  if FileIsNQC then
  begin
    p := Pos(';', aPath);
    while p > 0 do
    begin
      s := Copy(aPath, 1, p - 1);
      Delete(aPath, 1, p);
      Result := Result + ' -I' + OE + '"' + s + '"';
      p := Pos(';', aPath);
    end;
  end;
  Result := Result + ' -I' + OE + '"' + aPath + '"';
end;

function GetTarget : string;
begin
  case LocalBrickType of
    SU_CYBERMASTER : Result := 'CM';
    SU_SCOUT       : Result := 'Scout';
    SU_RCX2        : Result := 'RCX2';
    SU_SPYBOTIC    : Result := 'Spy';
    SU_SWAN        : Result := 'Swan';
    SU_NXT         : Result := 'NXT';
  else
                     Result := 'RCX';
  end;
end;

function GetCompilerSwitches : string;
begin
  Result := CompilerSwitches;
  if FileIsNQC then
    Result := Result + ' ' + NQCSwitches
  else if FileIsMindScriptOrLASM then
    Result := Result + ' ' + LCCSwitches
  else if FileIsNBCOrNXCOrNPGOrRICScript then
    Result := Result + ' ' + NBCSwitches
  else if FileIsJava then
    Result := Result + ' ' + JavaSwitches
  else if FileIsCPP or FileIsPascal then
    Result := Result + ' ' + CPPSwitches;
end;

function ProcessMakeCommand(const sFilename, sTempDir, commandstr : string) : string;
var
  cmdFile : string;
begin
  // switch to unix-style slash for log file path
  Result := commandstr;
  if sTempDir <> '' then
    Result := Result + ' >& "' +
      StringReplace(sTempdir, '\', '/', [rfReplaceAll]) + 'temp.log"';
  cmdFile := ChangeFileExt(sFilename, '.cmd');
  if FileExists(cmdFile) then
    DeleteFile(cmdFile);
  with TFileStream.Create(cmdFile, fmCreate) do
  try
    Write(PChar(Result)^, Length(Result));
  finally
    Free;
  end;
  Result := {IncludeTrailingPathDelimiter(CygwinDir) + 'bin\' + }'bash "' + cmdFile + '"';
end;

function GetProperExtension(aFile : string) : string;
begin
  result := ExtractFileExt(aFile);
  if result = '' then
  begin
    case PreferredLanguage of
      1 : Result := '.lsc';
      2 : Result := '.asm';
      3 : Result := '.nbc';
      4 : Result := '.nxc';
    else
      if LocalBrickType = SU_NXT then
        Result := '.nxc'
      else
        Result := '.nqc';
    end;
  end;
end;

function GetCompilerCommandLine(bDownload : Boolean; sTempdir, sIncludePath, sFilename : string) : string;
var
  ext, extbin, commandstr, extraSwitches, OE : string;
  E : TfrmCodeEdit;
begin
  E := MainForm.ActiveEditorForm;
  OE := OptionalEquals;
  ext := GetProperExtension(sFilename);
  {Create the command}
  // default compiler is NQC.
  if FileIsMindScriptOrLASM(E) then
    commandstr := LCCPath
  else if FileIsNBCOrNXCOrNPGOrRICScript(E) then
    commandstr := NBCPath
  else if FileIsCPPOrPascalOrJava(E) then
    commandstr := '/bin/make'
  else if FileIsNQC(E) then
    commandstr := NQCPath
  else
    commandstr := DefaultPath;

  if FileIsNBCOrNXCOrNPGOrRICScript(E) then
  begin
    commandstr := commandstr + ' -Y="' + ChangeFileExt(sFilename, '.sym') + '"';
    commandstr := commandstr + Format(' -Z%d', [NBCOptLevel]);
    if NBCMaxErrors > 0 then
      commandstr := commandstr + Format(' -ER=%d', [NBCMaxErrors]);
    if EnhancedFirmware then
      commandstr := commandstr + ' -EF';
    if NXT2Firmware then
      commandstr := commandstr + ' -v=120';
    if IgnoreSysFiles then
      commandstr := commandstr + ' -n';
    sIncludePath := sIncludePath + ';' + ExtractFilePath(sFilename);
  end;

  if FileIsNQC(E) and IncludeSrcInList then
    commandstr := commandstr + ' -s';

  if not FileIsCPPOrPascalOrJava(E) then
  begin
    commandstr := commandstr + ' -E' + OE + '"' + sTempdir + 'temp.log"';
    commandstr := commandstr + ' -L' + OE + '"' + sTempdir + 'temp.lst"';
  end;

  if not FileIsCPPOrPascalOrJava(E) then
    commandstr := commandstr + GetIncludeDirectives(sIncludePath);

  extraSwitches := Trim(GetCompilerSwitches);
  if extraSwitches <> '' then
    commandstr := commandstr + ' ' + extraSwitches + ' ';

  if not FileIsCPPOrPascalOrJava(E) then
    commandstr := commandstr + ' -T' + OE + GetTarget;

  if (FileIsNQC(E) or FileIsNBCOrNXCOrNPGOrRICScript(E)) and SaveBinaryOutput then
  begin
    extbin := '.rcx';
    if FileIsNBC or FileIsNXC then
      extbin := '.rxe'
    else if FileIsNPG then
      extbin := '.rpg'
    else if FileIsRICScript then
      extbin := '.ric';
    commandstr := commandstr + ' -O' + OE + '"' + ChangeFileExt(sFilename, extbin) + '"';
  end;

  if bDownload then
  begin
    if not FileIsCPPOrPascalOrJava(E) then
    begin
      commandstr := commandstr + ' -d';
      // the internal NBC compiler does not need the port
      if not (FileIsNBCOrNXCOrNPGOrRICScript(E) and UseInternalNBC) then
        commandstr := commandstr + ' -S' + OptionalEquals + LocalPort;
      if FileIsNBCOrNXCOrNPGOrRICScript(E) then
      begin
        if BrickComm.UseBluetooth then
          commandstr := commandstr + ' -BT';
        commandstr := commandstr + ' -N="' + sFilename{ExtractFileName(sFilename)} + '"';
      end;
    end
    else
      commandstr := commandstr + ' download ';
  end;

  if not FileIsCPPOrPascalOrJava(E) then
    commandstr := commandstr + ' "' + sTempdir + 'temp' + ext + '"'
  else
    commandstr := commandstr + ' -f"' + ChangeFileExt(sFilename, '.mak') + '" -s';

  if FileIsCPPOrPascalOrJava(E) then
    commandstr := ProcessMakeCommand(sFilename, sTempdir, commandstr);

  result := commandstr;
end;

function GetIncludePath(sSaveDir : string) : string;
var
  E : TfrmCodeEdit;
begin
  Result := '';
  E := MainForm.ActiveEditorForm;
  if FileIsNQC(E) then
  begin
    if NQCIncludePath <> '' then
      Result := NQCIncludePath + ';' + sSaveDir
    else
      Result := sSaveDir;
  end
  else if FileIsMindScriptOrLASM(E) then
  begin
    if LCCIncludePath <> '' then
      Result := IncludeTrailingPathDelimiter(LCCIncludePath)
    else
      Result := IncludeTrailingPathDelimiter(sSaveDir);
  end
  else if FileIsNBCOrNXCOrNPGOrRICScript(E) then
  begin
    if NBCIncludePath <> '' then
      Result := NBCIncludePath + ';' + sSaveDir
    else
      Result := sSaveDir
  end;
end;

function GetProjectFiles(aPath : string; ext : string) : string;
var
  p : string;
  i : Integer;
begin
  Result := '';
  p := ChangeFileExt(aPath, '.prj');
  if FileExists(p) then begin
    with TStringList.Create do
    try
      LoadFromFile(p);
      for i := 0 to Count - 1 do begin
        Result := Result + ChangeFileExt(Strings[i], ext) + ' ';
      end;
    finally
      Free;
    end;
  end;
end;

procedure GenerateMakefile(aPath : string; run : Boolean; node : Integer);
var
  SL : TStringList;
  mfStr, tower, prog, exec, addr, port, set_addr : string;
  E : TfrmCodeEdit;
begin
  E := MainForm.ActiveEditorForm;
  SL := TStringList.Create;
  try
    tower := '--tty=';
    tower := tower + LocalPort;
    prog := '--program=' + IntToStr(CurrentProgramSlot+1);
    addr := '--rcxaddr=' + IntToStr(CurrentLNPAddress);
    port := '--srcport=' + IntToStr(CurrentLNPPort);
    set_addr := '--node=' + IntToStr(node);
    if run then
      exec := '--execute'
    else
      exec := '';
    if not FileIsJava(E) then
    begin
      // process BrickOSMakefileTemplate
      mfStr := StringReplace(BrickOSMakefileTemplate, '%os_root%', BrickOSRoot, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%project%', ChangeFileExt(ExtractFileName(aPath), ''), [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%project_files%', GetProjectFiles(aPath, '.o'), [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%prog%', prog, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%tty%', tower, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%exec%', exec, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%addr%', addr, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%port%', port, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%set_addr%', set_addr, [rfReplaceAll]);

      // if file is pascal then add the pascal tail to the end
      if FileIsPascal(E) then
        mfStr := mfStr + K_PASCAL_TAIL;
    end
    else
    begin
      // process LeJOSMakefileTemplate
      mfStr := StringReplace(LeJOSMakefileTemplate, '%project%', ChangeFileExt(ExtractFileName(aPath), ''), [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%project_files%', GetProjectFiles(aPath, '.class'), [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%tty%', tower, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%jdk_dir%', JavaCompilerPath, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%os_root%', LeJOSRoot, [rfReplaceAll]);
    end;
    SL.Text := mfStr;
    SL.SaveToFile(ChangeFileExt(aPath, '.mak'));
  finally
    SL.Free;
  end;
end;

function ReadAndShowErrorFile(EdFrm : TfrmCodeEdit; const tempDir, ext : string) : boolean;
var
  tmpSL : TStrings;
  i, j, p, lineNo : integer;
  tmpstr, errMsg, fName, tmpName, testStr : string;
  bErrorsOrWarnings : boolean;
begin
  Result := True;
  if not (Assigned(MainForm) and Assigned(EdFrm)) then Exit;
  fName := EdFrm.Filename;
  {Read the error file and show it}
  tmpSL := TStringList.Create;
  try
    bErrorsOrWarnings := False;
    if FileExists(tempDir + 'temp.log') then
    begin
      tmpSL.LoadFromFile(tempDir + 'temp.log');
      if (tmpSL.Count > 0) then
      begin
        bErrorsOrWarnings := True;
        {Show the error listing}
        if FileExists(tempDir + 'temp.log') then
        begin
          CodeForm.CodeEdit.Lines.LoadFromFile(tempDir + 'temp.log');
          CodeForm.Caption := sFullErrors + ' ' + EdFrm.Caption;
        end;
        {Show the short errors}
        EdFrm.TheErrors.Items.Clear;
        for i := 0 to tmpSL.Count - 1 do
        begin
          if FileIsROPS then begin
            if Pos('[Error]', tmpSL[i]) <> 0 then
            begin
              tmpStr := tmpSL[i];
              System.Delete(tmpStr, 1, 8);
              p := Pos('(', tmpStr);
              if p <> 0 then begin
                errMsg := Copy(tmpStr, 1, p-1);
                if Pos(fname, errMsg) <> 0 then
                begin
                  System.Delete(tmpStr, 1, p);
                  errMsg := Copy(tmpStr, 1, Pos(':', tmpStr)-1);
                  lineNo := StrToIntDef(errMsg, -1);
                  if lineNo <> -1 then
                  begin
                    lineNo := GetLineNumber(lineNo);
                    errMsg := 'line ' + IntToStr(lineNo) + ': ';
                    p := Pos('):', tmpStr);
                    if p <> 0 then begin
                      System.Delete(tmpStr, 1, p+1);
                      errMsg := errMsg + Trim(tmpStr);
                      EdFrm.AddErrorMessage(errMsg);
                      Result := False; // errors exist
                    end;
                  end;
                end;
              end;
            end;
          end
          else if FileIsCPPOrPascalOrJava then begin
            // pascal, cpp, and java
            if Pos('warning:', tmpSL[i]) = 0 then
            begin
              // not a warning.
              p := Pos(':', tmpSL[i]);
              tmpstr := Copy(tmpSL[i], 1, p-1);
              if (Pos(tmpstr, fName) <> 0) or
                 (Pos(ChangeFileExt(ExtractFileName(fName), '.o'), tmpstr) <> 0) then
              begin
                tmpstr := Copy(tmpSL[i], p+1, Length(tmpSL[i]));
                j := i;
                while (j < tmpSL.Count-1) do begin
                  p := Pos(':', tmpSL[j+1]);
                  if Pos(Copy(tmpSL[j+1], 1, p-1), ChangeFileExt(fName, '.o')) = 0 then
                  begin
                    // linker error
                    Break;
                  end
                  else if Pos(Copy(tmpSL[j+1], 1, p-1), fName) = 0 then
                  begin
                    // the line following the current line is not a new error message
                    // but, rather, a continuation of this error message
                    // unless - that is - it starts with the word "make"
                    if Pos('make', LowerCase(tmpSL[j+1])) <> 1 then
                      tmpstr := tmpstr + ' ' + tmpSL[j+1];
                  end
                  else begin
                    // the next line is a new error message so break
                    Break;
                  end;
                  Inc(j);
                end;
                // tmpstr should be ###: error message
                // if it doesn't start with a number then ignore the line
                errMsg := Copy(tmpstr, 1, Pos(':', tmpstr)-1);
                Delete(tmpstr, 1, Length(errMsg));
                lineNo := StrToIntDef(errMsg, -1);
                if lineNo <> -1 then
                begin
                  lineNo := GetLineNumber(lineNo);
                  errMsg := 'line ' + IntToStr(lineNo) + tmpstr;
                  EdFrm.AddErrorMessage(errMsg);
                  Result := False;
                end
                else begin
                  // is this a linker error?
                  p := Pos(':', tmpstr);
                  if (Pos(Copy(tmpstr, 1, p-1), fName) <> 0) then
                  begin
                    errMsg := 'linker error:' + Copy(tmpstr, p+1, Length(tmpstr));
                    EdFrm.AddErrorMessage(errMsg);
                    Result := False;
                  end;
                end;
              end;
            end;
          end
          else begin
            // NQC, LASM, MindScript, NBC, & NXC
            if (Pos('# Error:',tmpSL[i])>0) or
               (Pos('# Warning:',tmpSL[i])>0) then
            begin
              tmpstr := Copy(tmpSL[i], 2, MaxInt);
              // show error with line number of following line matches either temp.ext
              // or the filename of the active editor form
              errMsg := tmpstr;
              if i < (tmpSL.Count - 1) then
              begin
                testStr := tmpSL[i+1];
                // modified approach to error/warning output (2009-03-14 JCH)
                tmpName := '';
                // pattern is File "filaname" ; line NNNN
                p := Pos('File "', testStr);
                if p > 0 then
                begin
                  Delete(testStr, 1, p+5);
                  p := Pos('"', testStr);
                  if p > 0 then
                  begin
                    tmpName := Copy(testStr, 1, p-1);
                    Delete(testStr, 1, p);
                  end;
                end;
                p := Pos('temp'+ext, tmpName);
                if p > 0 then
                begin
                  // replace temporary filename with actual filename
                  tmpName := fName;
                end;
                p := Pos('; line ', testStr);
{
                tmpName := 'temp' + ext;
                p := Pos(tmpName+'" ; line', testStr);
                if p = 0 then
                begin
                  p := Pos(fName+'" ; line', testStr);
                  if p > 0 then
                    tmpName := fName;
                end;
}
                if p > 0 then
                begin
                  // get the line number
                  p := p + 7;
//                  p := p + Length(tmpName) + 4 + 5;
                  errMsg := Copy(testStr, p, MaxInt);
                  lineNo := StrToIntDef(errMsg, -1);
                  if lineNo <> -1 then
                  begin
                    lineNo := GetLineNumber(lineNo);
                    if AnsiUppercase(tmpName) = AnsiUppercase(fName) then
                      errMsg := 'line ' + IntToStr(lineNo) + ':' + tmpstr
                    else
                      errMsg := 'line ' + IntToStr(lineNo) + ', file "' + tmpName + '":' + tmpstr;
//                    errMsg := 'line ' + IntToStr(lineNo) + ':' + tmpstr;
                  end;
                end;
              end;
              Result := Result and (Pos(': Error:', errMsg) = 0);
              EdFrm.AddErrorMessage(errMsg);
            end;
          end;
        end;
        {show the errors}
        Result := Result or (EdFrm.TheErrors.Items.Count = 0);
        EdFrm.ShowTheErrors;
      end;
    end;
    {Show the code listing}
    if not bErrorsOrWarnings then
    begin
      if FileExists(tempDir + 'temp.lst') then
      begin
        tmpSL.LoadFromFile(tempDir + 'temp.lst');
        CodeForm.CodeEdit.Lines.BeginUpdate;
        try
          CodeForm.CodeEdit.Lines.Clear;
          for i := 0 to tmpSL.Count - 1 do
          begin
            tmpstr := tmpSL[i];
            if (tmpstr <> '') and (Pos('#line', tmpstr) <> 1) then
              CodeForm.CodeEdit.Lines.Add(tmpstr);
          end;
  //        CodeForm.CodeEdit.Lines.LoadFromFile(tempDir + 'temp.lst')
        finally
          CodeForm.CodeEdit.Lines.EndUpdate;
        end;
      end
      else
        CodeForm.CodeEdit.Lines.Clear;
      CodeForm.Caption := sCodeListing + ' ' + EdFrm.Caption;
      {Hide the short errors}
      MainForm.DoHideErrors;
      Result := true;
    end;
  finally
    tmpSL.Free;
  end;
end;

procedure ReadSymbolFile(const sFilename : string);
var
  symName : string;
begin
  symName := ChangeFileExt(sFilename, '.sym');
  if FileExists(symName) then
  begin
    CurrentProgram.IsNXC := FileIsNXC;
    CurrentProgram.LoadFromFile(symName);
    DeleteFile(symName);
  end;
end;

function InternalNBCCompile(const cmdLine : string) : integer;
var
  C : TNBCCompiler;
begin
  Result := 0;
  C := TNBCCompiler.Create;
  try
    if Assigned(MainForm) then
      C.OnCompilerStatusChange := MainForm.HandleOnCompilerStatusChange;
    try
      LoadParamDefinitions(C.ExtraDefines, cmdLine);
{$IFDEF CAN_DOWNLOAD}
      C.BrickComm         := BrickComm;
{$ENDIF}
      C.InputFilename     := getFilenameParam(cmdLine);
      C.DefaultIncludeDir := '.';
      C.CommandLine       := cmdLine;
      if ParamSwitch('-x', False, cmdLine) then
      begin
        C.Decompile;
      end
      else
      begin
        Result := C.Execute * -1;
        if C.WriteCompilerMessages then
          C.Messages.SaveToFile(C.CompilerMessagesFilename);
      end;
    except
      Result := -1;
    end;
  finally
    C.Free;
  end;
end;

function CompileIt(download : Boolean; run : Boolean): boolean;
var
  SaveCursor : TCursor;
  ext, SaveDir, tempDir, commandstr : string;
  wd, statusStr, outStr : string;
  i : Integer;
  NQC_Result : Longint;
  execError : Boolean;
  EdFrm : TfrmCodeEdit;
  fName, fCaption : string;
  SL : TStringList;
begin
  outStr := '';
  Result := False;
  if not Assigned(MainForm) then Exit;

  EdFrm := MainForm.ActiveEditorForm;
  if not Assigned(EdFrm) then Exit;

  // first off we should hide any previous errors
  MainForm.barStatus.Panels[1].Text := '';
  EdFrm.TheErrors.Visible := False;
  EdFrm.splErrors.Visible := False;

  // now proceed with compilation
  fName    := EdFrm.Filename;
  fCaption := EdFrm.Caption;

// switch to modal form to prevent doing other things in
// the GUI while downloading/compiling
  tempDir := TempPath;
  {Save cursor}
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  {Save current directory}
  SaveDir:= GetCurrentDir;
  if not FileIsCPPOrPascalOrJava(EdFrm) then
    SetCurrentDir(ProgramDir)
  else
    SetCurrentDir(ExtractFilePath(fName));
  try
    // check for auto save
    if AutoSaveFiles then
      MainForm.SaveModifiedFiles;
    if AutoSaveDesktop then
      MainForm.SaveDesktop(fName);

    if FileIsCPPOrPascalOrJava(EdFrm) then
    begin
      // generate the Makefile
      GenerateMakefile(fName, run);
    end
    else if not FileIsROPS(EdFrm) then
    begin
      // Save the file
      ext := GetProperExtension(fName);
      EdFrm.TheEditor.Lines.SaveToFile(tempDir + 'temp' + ext);
    end;

    // execute Precompile Tools
    for i := 0 to PrecompileSteps.Count - 1 do
    begin
      MainForm.ExecuteTransferItem(PrecompileSteps[i]);
    end;

    commandstr := GetCompilerCommandLine(download, tempDir, GetIncludePath(SaveDir), fName);

    wd := ExcludeTrailingPathDelimiter(ExtractFilePath(fName));
    if wd = '' then
      wd := ProgramDir;

    if CompilerDebug then
      ShowMessage('DEBUG: launching compiler with commandline = ' + commandstr);

    if FileIsROPS(EdFrm) then
    begin
      MainForm.ce.Script.Assign(EdFrm.TheEditor.Lines);
      MainForm.ce.MainFileName := fName;
      if not MainForm.ce.Compile then
      begin
        execError := True;
        NQC_Result := -1;
        SL := TStringList.Create;
        try
          for i := 0 to MainForm.ce.CompilerMessageCount - 1 do
            SL.Add(MainForm.ce.CompilerMessages[i].MessageToString);
          SL.SaveToFile(tempDir + 'temp.log');
        finally
          SL.Free;
        end;
      end
      else
      begin
        execError := False;
        NQC_Result := 0;
        SL := TStringList.Create;
        try
          MainForm.ce.GetCompiled(commandstr);
          if SaveBinaryOutput then
          begin
            SL.Text := commandstr;
            SL.SaveToFile(ChangeFileExt(fName, '.psb'));
          end;
          IFPS3DataToText(commandstr, commandstr);
          SL.Text := commandstr;
          SL.SaveToFile(tempDir + 'temp.lst');
        finally
          SL.Free;
        end;
      end;
    end
    else if FileIsNBCOrNXCOrNPGOrRICScript and UseInternalNBC then
    begin
      NQC_Result := InternalNBCCompile(commandstr);
      execError  := NQC_Result < 0;
    end
    else
    begin
      {Execute the command, and wait}
      if download then begin
        BrickComm.Ping;
        BrickComm.Close;
      end;
      try
        NQC_Result := ExecuteAndWait(PChar(commandstr), SW_SHOWMINNOACTIVE, LocalCompilerTimeout, PChar(wd));
        if not FileIsNQC(EdFrm) then
          NQC_Result := NQC_Result * -1;
        execError := NQC_Result < 0;
      finally
        if download then
          BrickComm.Open;
        // make sure the toolbar refreshes no matter what
        MainForm.HandleOpenStateChanged(nil);
      end;
    end;

    // execute post compile steps
    for i := 0 to PostcompileSteps.Count - 1 do
    begin
      MainForm.ExecuteTransferItem(PostcompileSteps[i]);
    end;

    Result := ReadAndShowErrorFile(EdFrm, tempDir, ext);
    
    if FileIsNBCOrNXC(EdFrm) then
      ReadSymbolFile(fName);

    if (not execError) and ShowCompilerStatus then
    begin
      if Result and download then
        statusStr := sCompileDownloadSuccess
      else if Result then
        statusStr := sCompileSuccess
      else if download then
        statusStr := sCompileDownloadErrors
      else
        statusStr := sCompileErrors;
      frmCompStatus.AddMessage(statusStr);
    end
    else if execError then
    begin
      if outStr <> '' then
        outStr := outStr + #13#10;
{$IFNDEF FPC}
      if FileIsNQC(EdFrm) then
        outStr := outStr + GetRCXErrorString(NQC_Result)
      else
{$ENDIF}
      if FileIsMindScriptOrLASM(EdFrm) then
        outStr := outStr + GetLASMErrorString(NQC_Result)
      else if FileIsNBCOrNXCOrNPGOrRICScript(EdFrm) or FileIsROPS(EdFrm) then
        outStr := outStr + GetNBCErrorString(NQC_Result)
      else
        outStr := outStr + GetGNUErrorString(NQC_Result);
      if outStr <> '' then
      begin
        MessageDlg('Compile/Download Failed' + #13#10 + outStr, mtError, [mbOK], 0);
      end;
    end;
  finally
    {Clean up}
    if not KeepBrickOSMakefile then
      DeleteFile(ChangeFileExt(fName, '.mak'));
    DeleteFile(ChangeFileExt(fName, '.cmd'));
    DeleteFile(tempDir + 'temp.log');
    DeleteFile(tempDir + 'temp.lst');
    DeleteFile(tempDir + 'temp' + ext);
    Screen.Cursor := SaveCursor;
    SetCurrentDir(SaveDir);
  end;
end;

{
procedure TfrmCodeEdit.InsertOptionInfo;
begin
  TheEditor.Lines.Insert(0,
    Format('// Port:%s, RCXType:%s, Slot:Program %d',
      [BrickComm.NicePortName, BrickComm.RCXTypeName, CurrentProgramSlot+1]));
  TheEditor.CaretY := TheEditor.CaretY + 1;
  TheEditor.Modified := True;
end;
}

procedure TfrmCodeEdit.TheEditorChange(Sender: TObject);
begin
  frmCodeExplorer.CurrentSource := TheEditor.Lines.Text;
end;

procedure TfrmCodeEdit.SetFilename(const Value: string);
begin
  fFilename := Value;
//  AddRecentFile(Value);
end;

procedure TfrmCodeEdit.HookCompProp;
var
  HL : TSynCustomHighlighter;
begin
  MainForm.SynNQCCompProp.RemoveEditor(TheEditor);
  MainForm.SynMindScriptCompProp.RemoveEditor(TheEditor);
  MainForm.SynLASMCompProp.RemoveEditor(TheEditor);
  MainForm.SynNBCCompProp.RemoveEditor(TheEditor);
  MainForm.SynNXCCompProp.RemoveEditor(TheEditor);
  MainForm.SynNPGCompProp.RemoveEditor(TheEditor);
  MainForm.SynRSCompProp.RemoveEditor(TheEditor);
  MainForm.SynForthCompProp.RemoveEditor(TheEditor);
  MainForm.SynCppCompProp.RemoveEditor(TheEditor);
  MainForm.SynPasCompProp.RemoveEditor(TheEditor);
  MainForm.SynROPSCompProp.RemoveEditor(TheEditor);
//  MainForm.SynJavaCompProp.RemoveEditor(TheEditor);
  MainForm.scpParams.RemoveEditor(TheEditor);

  HL := Self.Highlighter;
//  HL := GetHighlighterForFile(Filename);
  if (HL = MainForm.SynNQCSyn) or (HL = nil) then begin
    MainForm.SynNQCCompProp.AddEditor(TheEditor);
    MainForm.scpParams.AddEditor(TheEditor);
  end
  else if HL = MainForm.SynMindScriptSyn then
    MainForm.SynMindScriptCompProp.AddEditor(TheEditor)
  else if HL = MainForm.SynLASMSyn then
    MainForm.SynLASMCompProp.AddEditor(TheEditor)
  else if HL = MainForm.SynNBCSyn then begin
    MainForm.SynNBCCompProp.AddEditor(TheEditor);
    MainForm.scpParams.AddEditor(TheEditor);
  end
  else if HL = MainForm.SynNXCSyn then begin
    MainForm.SynNXCCompProp.AddEditor(TheEditor);
    MainForm.scpParams.AddEditor(TheEditor);
  end
  else if HL = MainForm.SynNPGSyn then
    MainForm.SynNPGCompProp.AddEditor(TheEditor)
  else if HL = MainForm.SynRSSyn then begin
    MainForm.SynRSCompProp.AddEditor(TheEditor);
    MainForm.scpParams.AddEditor(TheEditor);
  end
  else if HL = MainForm.SynCppSyn then begin
    MainForm.SynCppCompProp.AddEditor(TheEditor);
    MainForm.scpParams.AddEditor(TheEditor);
  end
  else if HL = MainForm.SynPasSyn then begin
    MainForm.SynPasCompProp.AddEditor(TheEditor);
    MainForm.scpParams.AddEditor(TheEditor);
  end
  else if HL = MainForm.SynROPSSyn then begin
    MainForm.SynROPSCompProp.AddEditor(TheEditor);
    MainForm.scpParams.AddEditor(TheEditor);
  end
{
  else if HL = MainForm.SynJavaSyn then begin
    MainForm.SynJavaCompProp.AddEditor(TheEditor);
    MainForm.scpParams.AddEditor(TheEditor);
  end
}
  else if HL = MainForm.SynForthSyn then
    MainForm.SynForthCompProp.AddEditor(TheEditor);
end;

procedure TfrmCodeEdit.ProcedureList;
var
  line : Integer;
  SL : TExploredLanguage;
  AEF : TfrmCodeEdit;
begin
  AEF := nil;
  if Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
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

procedure TfrmCodeEdit.SetActiveHelpFile;
var
  AEF : TfrmCodeEdit;
begin
  AEF := nil;
  if Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  Self.HelpFile := Application.HelpFile;
  if FileIsMindScriptOrLASM(AEF) then
  begin
    Self.HelpFile := GetSDKRootPath + 'vpb.hlp';
  end
  else if FileIsNQC(AEF) then
  begin
    Self.HelpFile := ProgramDir + 'Help\nqc.hlp';
  end
  else if FileIsJava(AEF) then
  begin
    Self.HelpFile := ProgramDir + 'Help\LeJOS.hlp';
  end
  else if FileIsForth(AEF) then
  begin
    Self.HelpFile := ProgramDir + 'Help\pbForth.hlp';
  end
  else if FileIsNBC(AEF) then
  begin
    Self.HelpFile := ProgramDir + 'Help\nbc.hlp';
  end
  else if FileIsNXC(AEF) then
  begin
    Self.HelpFile := ProgramDir + 'Help\nxc.hlp';
  end
  else if FileIsNPG(AEF) then
  begin
    Self.HelpFile := ProgramDir + 'Help\npg.hlp';
  end
  else if FileIsRICScript(AEF) then
  begin
    Self.HelpFile := ProgramDir + 'Help\ricscript.hlp';
  end
  else if FileIsCPP(AEF) then
  begin
    Self.HelpFile := ProgramDir + 'Help\brickOS.hlp';
  end
  else if FileIsPascal(AEF) then
  begin
    Self.HelpFile := ProgramDir + 'Help\brickOSPas.hlp';
  end;
end;

procedure TfrmCodeEdit.TheEditorProcessCommand(Sender: TObject;
  var Command: TSynEditorCommand; var AChar: Char; Data: Pointer);
var
  word : string;
  FoundPos: Integer;
  Ident: string;
begin
  case Command of
{$IFNDEF FPC}
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
      HelpALink(word, FileIsNQC);
      Command := ecNone;
    end;
{$ENDIF}
    K_USER_PREVIDENT, K_USER_NEXTIDENT : begin
      if FindIdentAtPos(Source, Position, (Command = K_USER_PREVIDENT), FoundPos, Ident) then
        Position := FoundPos
      else
        MessageBeep($FFFFFFFF);
    end;
  end;
end;

procedure TfrmCodeEdit.TheEditorProcessUserCommand(Sender: TObject;
  var Command: TSynEditorCommand; var AChar: Char; Data: Pointer);
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
    MainForm.expHTML.ExportAsText := True;
    MainForm.expHTML.ExportRange(TheEditor.Lines, bb, be);
    MainForm.expHTML.CopyToClipboard;
    // put on the clipboard as HTML
    MainForm.expHTML.ExportAsText := False;
    MainForm.expHTML.ExportRange(TheEditor.Lines, bb, be);
    MainForm.expHTML.CopyToClipboard;
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
    MainForm.expRTF.ExportAsText := True;
    MainForm.expRTF.ExportRange(TheEditor.Lines, bb, be);
    MainForm.expRTF.CopyToClipboard;
    // put on the clipboard as RTF
    MainForm.expRTF.ExportAsText := False;
    MainForm.expRTF.ExportRange(TheEditor.Lines, bb, be);
    MainForm.expRTF.CopyToClipboard;
  finally
    Clipboard.Close;
  end;
end;

procedure TfrmCodeEdit.SetCaption(const fname : string);
begin
  Caption  := fname;
  if Assigned(Parent) then
    TTabSheet(Parent).Caption := fname;
end;

function TfrmCodeEdit.IsMaximized: Boolean;
begin
  Result := (WindowState = wsMaximized) or ((Left < 0) and (Top < 0));
end;

procedure TfrmCodeEdit.TheEditorDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Source = ConstructForm.treTemplates then
  begin
    Accept := True;
    TheEditor.CaretXY := TheEditor.PixelsToRowColumn(Point(X, Y));
  end
  else if Source = frmNXTExplorer.lstFiles then
  begin
    Accept := True;
  end
  else
    Accept := False;
end;

procedure TfrmCodeEdit.TheEditorDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  i : integer;
begin
  if Source = ConstructForm.treTemplates then
  begin
    ConstructForm.DoTemplateInsert(X, Y);
  end
  else if Source = frmNXTExplorer.lstFiles then
  begin
    // drop file(s)
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

procedure TfrmCodeEdit.AddErrorMessage(const errMsg: string);
begin
  if TheErrors.Items.IndexOf(errMsg) = -1 then
    TheErrors.Items.Append(errMsg);
end;

procedure TfrmCodeEdit.ShowTheErrors;
begin
  if TheErrors.Items.Count > 0 then
  begin
    MainForm.barStatus.Panels[1].Text := sErrors;
    TheErrors.Visible := True;
    splErrors.Visible := True;
    TheErrors.ItemIndex:=0;
    TheErrorsClick(TheErrors);
  end
  else
  begin
    MainForm.barStatus.Panels[1].Text := '';
    TheErrors.Visible := False;
    splErrors.Visible := False;
  end;
end;

procedure TfrmCodeEdit.TheEditorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
{$IFNDEF FPC}
  if (ssCtrl in Shift) and (Button = mbLeft) then
    FindDeclaration(TheEditor.WordAtMouse);
{$ENDIF}
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

procedure AddPaths(aPath : string; aPaths : TStrings);
var
  p : Integer;
  s : string;
begin
  p := Pos(';', aPath);
  while p > 0 do
  begin
    s := Copy(aPath, 1, p - 1);
    Delete(aPath, 1, p);
    aPaths.Add(s);
    p := Pos(';', aPath);
  end;
  if aPath <> '' then
    aPaths.Add(aPath);
end;

procedure TfrmCodeEdit.OpenFileAtCursor;
var
  fName : string;
  bFound : boolean;
begin
  fName := TheEditor.TextWithinDelimiters(['"', ' ']);
  if FileExists(fName) then
    MainForm.OpenFile(fName)
  else
  begin
    bFound := OpenFileOnPath(fName);
    if not bFound then
    begin
      MainForm.dlgOpen.FileName := fName;
      MainForm.actFileOpenExecute(nil);
    end;
  end;
end;

procedure TfrmCodeEdit.mniOpenFileAtCursorClick(Sender: TObject);
begin
  OpenFileAtCursor;
end;

procedure TfrmCodeEdit.mniClosePageClick(Sender: TObject);
begin
  MainForm.actFileCloseExecute(Sender);
end;

procedure TfrmCodeEdit.mniViewExplorerClick(Sender: TObject);
begin
  MainForm.ShowCodeExplorer;
end;

procedure TfrmCodeEdit.mniFindDeclarationClick(Sender: TObject);
begin
//
end;

procedure TfrmCodeEdit.mnTopicSearchClick(Sender: TObject);
var
  Cmd : TSynEditorCommand;
  Ch : Char;
begin
{$IFNDEF FPC}
  Cmd := ecContextHelp;
  TheEditorProcessCommand(Sender, Cmd, Ch, nil);
{$ENDIF}
end;

procedure TfrmCodeEdit.ToggleBookmark(Sender: TObject);
begin
  TheEditor.ToggleBookmark(TOfficeMenuItem(Sender).Tag);
end;

procedure TfrmCodeEdit.GotoBookmark(Sender: TObject);
begin
  TheEditor.GotoBookMark(TOfficeMenuItem(Sender).Tag);
end;

function TfrmCodeEdit.CanFindDeclaration: Boolean;
begin
  Result := False;
end;

procedure TfrmCodeEdit.TheEditorSpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
begin
  Special := False;
  if FileIsROPS(Self) then
  begin
    if MainForm.ce.HasBreakPoint(Filename, Line) then
    begin
      Special := True;
      if Line = MainForm.FActiveLine then
      begin
        FG := clRed;
        BG := clWhite;
      end else
      begin
        FG := clWhite;
        BG := clRed;
      end;
    end
    else if Line = MainForm.FActiveLine then
    begin
      Special := True;
      FG := clWhite;
      BG := clBlue;
    end;
  end
  else if Assigned(fNXTCurrentOffset) and FileIsNBCOrNXC(Self) then
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

procedure TfrmCodeEdit.mniToggleBreakpointClick(Sender: TObject);
var
  Line: Longint;
begin
  if not FileIsROPS(Self) then Exit;
  Line := TheEditor.CaretY;
  if MainForm.ce.HasBreakPoint(Filename, Line) then
    MainForm.ce.ClearBreakPoint(Filename, Line)
  else
    MainForm.ce.SetBreakPoint(Filename, Line);
  TheEditor.Refresh;
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

procedure TfrmCodeEdit.CreatePopupMenu;
begin
end;

//    ssShift, ssAlt, ssCtrl,
//    ssLeft, ssRight, ssMiddle, ssDouble
procedure TfrmCodeEdit.CreateTheEditor;
begin
  TheEditor := TBricxccSynEdit.Create(Self);
  with TheEditor do
  begin
    Name := 'TheEditor';
    Parent := Self;
    Left := 0;
    Top := 0;
    Width := 464;
    Height := 285;
    Cursor := crIBeam;
    Align := alClient;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'Courier New';
    Font.Pitch := fpFixed;
    Font.Style := [];
    ParentColor := False;
    ParentFont := False;
    PopupMenu := ConstructForm.ConstructMenu;
    TabOrder := 1;
    BookMarkOptions.BookmarkImages := ilBookmarkImages;
    Gutter.Font.Charset := DEFAULT_CHARSET;
    Gutter.Font.Color := clWindowText;
    Gutter.Font.Height := -11;
    Gutter.Font.Name := 'Terminal';
    Gutter.Font.Style := [];
    MaxUndo := 10;
    Options := [eoAutoIndent, eoDragDropEditing, eoScrollPastEol,
                eoShowScrollHint, eoSmartTabDelete, eoSmartTabs,
                eoTabsToSpaces, eoTrimTrailingSpaces];
    ScrollHintFormat := shfTopToBottom;
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
    OnMouseOverToken := TheEditorMouseOverToken;
  end;
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


function TfrmCodeEdit.GetPosition: integer;
begin
  Result := TheEditor.RowColToCharIndex(TheEditor.CaretXY);
end;

function TfrmCodeEdit.GetSource: string;
begin
  Result := TheEditor.Text;
end;

procedure TfrmCodeEdit.SetPosition(const Value: integer);
begin
  TheEditor.CaretXY := TheEditor.CharIndexToRowCol(Value-1);
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
        MainForm.OpenFile(pName);
        Exit;
      end;
    end;
  finally
    fPaths.Free;
  end;
end;


*)

{$IFDEF FPC}
initialization
  {$i ucodeedit.lrs}
{$ENDIF}

end.
