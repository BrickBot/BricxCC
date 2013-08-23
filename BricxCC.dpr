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
program BricxCC;

{$R 'ToolbarBackground.res' 'ToolbarBackground.rc'}
{$R 'NXTSound.res' 'NXTSound.rc'}
{$R 'VistaManifest.res' 'VistaManifest.rc'}

uses
  FastMM4,
  FastMove,
  Forms,
  SysUtils,
  Dialogs,
  Controller in 'Controller.pas' {DirectForm},
  MainUnit in 'MainUnit.pas' {MainForm},
  Diagnose in 'Diagnose.pas' {DiagForm},
  Unlock in 'Unlock.pas' {UnlockForm},
  Watch in 'Watch.pas' {WatchForm},
  uNewWatch in 'uNewWatch.pas' {frmNewWatch},
  About in 'About.pas' {AboutBox},
  GotoLine in 'GotoLine.pas' {GotoForm},
  SearchRCX in 'SearchRCX.pas' {SearchBrickForm},
  Piano in 'Piano.pas' {PianoForm},
  ExecProgram in 'ExecProgram.pas',
  Preferences in 'Preferences.pas' {PrefForm},
  Editor in 'Editor.pas' {EditorForm},
  ConstructUnit in 'ConstructUnit.pas' {ConstructForm},
  JoystickUnit in 'JoystickUnit.pas' {JoystickForm},
  PuzzleUnit in 'PuzzleUnit.pas' {PuzzleForm},
  DatalogUnit in 'DatalogUnit.pas' {DatalogForm},
  MemoryUnit in 'MemoryUnit.pas' {MemoryForm},
  CodeUnit in 'CodeUnit.pas' {CodeForm},
  Translate in 'Translate.pas',
  uLocalizedStrings in 'uLocalizedStrings.pas',
  MessageUnit in 'MessageUnit.pas' {MessageForm},
  DPageSetup in 'DPageSetup.pas' {PageSetupDlg},
  DTestPrintPreview in 'DTestPrintPreview.pas' {TestPrintPreviewDlg},
  ParamUtils in 'ParamUtils.pas',
  GX_IDECodeTemplates in 'GX_IDECodeTemplates.pas',
  RemoteUnit in 'RemoteUnit.pas' {RemoteForm},
  DataAnalysis in 'DataAnalysis.pas' {frmDataAnalysis},
  uChartExport in 'uChartExport.pas' {frmChartExport},
  uChartConfig in 'uChartConfig.pas' {frmChartConfig},
  uSeriesConfig in 'uSeriesConfig.pas' {frmSeriesConfig},
  uPromptSeries in 'uPromptSeries.pas' {frmSeriesPrompt},
  EditCodeTemplate in 'EditCodeTemplate.pas' {frmEditCodeTemplate},
  CodeTemplates in 'CodeTemplates.pas' {frmCodeTemplates},
  uVersionInfo in 'uVersionInfo.pas',
  uOfficeComp in 'uOfficeComp.pas',
  srecord in 'bricktools\srecord.pas',
  NQCStream in 'bricktools\NQCStream.pas',
  rcx_cmd in 'bricktools\rcx_cmd.pas',
  rcx_constants in 'bricktools\rcx_constants.pas',
  rcx_link in 'bricktools\rcx_link.pas',
  RcxLog in 'bricktools\RcxLog.pas',
  scout_def in 'bricktools\scout_def.pas',
  FakeSpirit in 'bricktools\FakeSpirit.pas',
  TOWERAPI in 'bricktools\TOWERAPI.PAS',
  uCodeExplorer in 'uCodeExplorer.pas' {frmCodeExplorer},
  Transfer in 'Transfer.pas' {frmTransferDlg},
  Transdlg in 'Transdlg.pas' {frmTransEdit},
  uExplorerOptions in 'uExplorerOptions.pas' {frmExplorerOptions},
  uMacroLib in 'uMacroLib.pas',
  uMacroForm in 'uMacroForm.pas' {frmMacroManager},
  uMacroEditor in 'uMacroEditor.pas' {frmMacroEditor},
  uWindowList in 'uWindowList.pas' {frmWindowList},
  uHighlighterProcs in 'uHighlighterProcs.pas',
  uLASMProcLexer in 'uLASMProcLexer.pas',
  uMindScriptProcLexer in 'uMindScriptProcLexer.pas',
  uCppProcLexer in 'uCppProcLexer.pas',
  uBricxCCProcLexer in 'uBricxCCProcLexer.pas',
  uExtensionDlg in 'uExtensionDlg.pas' {frmExtensionDlg},
  uMindScript in 'uMindScript.pas',
  GX_ProcedureList in 'GX_ProcedureList.pas' {fmProcedureList},
  uPasProcLexer in 'uPasProcLexer.pas',
  uParseCommon in 'uParseCommon.pas',
  uProjectManager in 'uProjectManager.pas' {frmProjectManager},
  uCppCode in 'uCppCode.pas',
  uNXCCodeComp in 'uNXCCodeComp.pas',
  uSPCCodeComp in 'uSPCCodeComp.pas',
  uNXTCodeComp in 'uNXTCodeComp.pas',
  uRICCodeComp in 'uRICCodeComp.pas',
  uPasCode in 'uPasCode.pas',
  uMidi2MS in 'uMidi2MS.pas',
  uMIDIConversion in 'uMIDIConversion.pas' {frmMIDIConversion},
  uNewHotKey in 'uNewHotKey.pas',
  uSetLNPAddress in 'uSetLNPAddress.pas' {frmSetLNPAddress},
  uLegoSDKUtils in 'uLegoSDKUtils.pas',
  uForthProcLexer in 'uForthProcLexer.pas',
  uForthConsole in 'uForthConsole.pas' {frmForthConsole},
  uSources in 'uSources.pas',
  uRegUtils in 'uRegUtils.pas',
  uGlobals in 'uGlobals.pas',
  uBasicPrefs in 'uBasicPrefs.pas',
  uSetValues in 'uSetValues.pas' {frmSetValues},
  uEEPROM in 'uEEPROM.pas' {frmSpybotEEPROM},
  uWav2RSO in 'uWav2RSO.pas' {frmWave2RSO},
  uNXTExplorer in 'uNXTExplorer.pas' {frmNXTExplorer},
  uMiscDefines in 'uMiscDefines.pas',
  rcx_pipe in 'bricktools\rcx_pipe.pas',
  uSpirit in 'bricktools\uSpirit.pas',
  brick_common in 'bricktools\brick_common.pas',
  uNXTConstants in 'NXT\uNXTConstants.pas',
  uNXTController in 'uNXTController.pas' {frmNXTController},
  uCompStatus in 'uCompStatus.pas' {frmCompStatus},
  uHexViewer in 'uHexViewer.pas' {frmHexView},
  uTextViewer in 'uTextViewer.pas' {frmTextView},
  uNXTWatchList in 'uNXTWatchList.pas' {frmNXTWatchList},
  uSimpleTerm in 'uSimpleTerm.pas' {frmSimpleTerm},
  uNXTImage in 'uNXTImage.pas' {frmNXTImage},
  uLiveSensors in 'uLiveSensors.pas' {frmLiveSensors},
  ev3RGFedit_MainForm in 'ev3RGFedit_MainForm.pas' {frmEV3RGFEDIT},
  ev3RGFedit_AddText in 'ev3RGFedit_AddText.pas' {frmAddText},
  ev3RGFedit_Basis in 'ev3RGFedit_Basis.pas',
  ev3RGFedit_FileImport in 'ev3RGFedit_FileImport.pas' {frmImageImport},
  ev3RGFEdit_FileOpen in 'ev3RGFEdit_FileOpen.pas' {frmFileOpen},
  ev3RGFedit_FileSave in 'ev3RGFedit_FileSave.pas' {frmFileSave};

{$IFNDEF FPC}
{.$R *.TLB}

{$R *.RES}
{$R 'macro_img.res'}
{$ENDIF}

const
  K_RCXINFO = '(RCX = 0, Cybermaster = 1, Scout = 2, RCX2 = 3, Spybot = 4, Swan = 5, NXT = 6, SPRO = 7, and EV3 = 8)';

begin
  TheMenuItemType := TOfficeMenuItem;
  Application.Initialize;
  Application.Title := 'Bricx Command Center';

  {Find the program directory}
  ProgramDir := ExtractFilePath(Application.ExeName);

  LoadNXCCodeCompFromFile(ProgramDir + 'Default\nxc_api.txt', True);
  LoadNBCCodeCompFromFile(ProgramDir + 'Default\nbc_api.txt', True);
  LoadRICScriptCodeCompFromFile(ProgramDir + 'Default\ricscript_api.txt');
  LoadSPCCodeCompFromFile(ProgramDir + 'Default\spc_api.txt', True);

  if ParamSwitch('/NoNewMenuItems') then
    AddMenuItemsToNewMenu := False;

  RegisterApp;

  // we need to check this switch first before we create the preferences form
  if ParamSwitch('/RESET') then
    DeleteMainKey;

  if ParamSwitch('/PTO') then
    PingTimeout := StrToIntDef(ParamValue('/PTO'), K_DEFAULT_PING_TIMEOUT);
    
  //must be read before creating the SearchBrickForm
  if ParamSwitch('/UserPath') then
    UserDataLocalPath := IncludeTrailingPathDelimiter(ParamValue('/UserPath'));

  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDirectForm, DirectForm);
  Application.CreateForm(TDiagForm, DiagForm);
  Application.CreateForm(TWatchForm, WatchForm);
  Application.CreateForm(TfrmNewWatch, frmNewWatch);
  Application.CreateForm(TSearchBrickForm, SearchBrickForm);
  Application.CreateForm(TPianoForm, PianoForm);
  Application.CreateForm(TConstructForm, ConstructForm);
  Application.CreateForm(TJoystickForm, JoystickForm);
  Application.CreateForm(TDatalogForm, DatalogForm);
  Application.CreateForm(TMemoryForm, MemoryForm);
  Application.CreateForm(TCodeForm, CodeForm);
  Application.CreateForm(TMessageForm, MessageForm);
  Application.CreateForm(TRemoteForm, RemoteForm);
  Application.CreateForm(TfrmProjectManager, frmProjectManager);
  Application.CreateForm(TfrmForthConsole, frmForthConsole);
  Application.CreateForm(TfrmSetValues, frmSetValues);
  Application.CreateForm(TfrmSpybotEEPROM, frmSpybotEEPROM);
  Application.CreateForm(TfrmNXTExplorer, frmNXTExplorer);
  Application.CreateForm(TfrmNXTController, frmNXTController);
  Application.CreateForm(TfrmNXTImage, frmNXTImage);
  Application.CreateForm(TfrmNXTWatchList, frmNXTWatchList);
  Application.CreateForm(TfrmLiveSensors, frmLiveSensors);
  Application.CreateForm(TfrmSimpleTerm, frmSimpleTerm);
  Application.CreateForm(TfrmEV3RGFEDIT, frmEV3RGFEDIT);
  Application.CreateForm(TfrmAddText, frmAddText);
  Application.CreateForm(TfrmFileSave, frmFileSave);
  if not ParamSwitch('/RESET') then
    UpgradeRegistry(nil, nil, nil, nil, nil, nil); // must be done before creating preferences form
  if ParamSwitch('-EMBEDDING') or ParamSwitch('-AUTOMATION') then
  begin
    RunningAsCOMServer := True;
    LocalStartupAction := SU_NOCONNECT;
    Application.ShowMainForm := False;
  end;
  Application.CreateForm(TPrefForm, PrefForm);
  // set the dock panel
  uBasicPrefs.dockPanel     := MainForm.pnlCodeExplorer;
  uBasicPrefs.panelSplitter := MainForm.splCodeExplorer;
  Application.CreateForm(TfrmCodeExplorer, frmCodeExplorer);
  Application.CreateForm(TfrmMacroManager, frmMacroManager);
  Application.CreateForm(TfrmHexView, frmHexView);
  Application.CreateForm(TfrmTextView, frmTextView);
  Application.CreateForm(TfrmCompStatus, frmCompStatus);

  if ParamSwitch('/COM') then
    LocalPort := ParamValue('/COM');
  if ParamSwitch('/RCX') then
    LocalBrickType := ParamIntValue('/RCX', SU_RCX);
  if ParamSwitch('/BT') then
    LocalUseBluetooth := True;
  if ParamSwitch('/AUTO') then
    LocalStartupAction := SU_CONNECT;
  if ParamSwitch('/NOCONNECT') then
    LocalStartupAction := SU_NOCONNECT;
  // if shell passes the /Print switch (undocumented) then do not connect
  if ParamSwitch('/Print') then
    LocalStartupAction := SU_NOCONNECT;
  if ParamSwitch('/POS') then
    LoadWindowValuesFromFile(ParamValue('/POS'));
  CompilerDebug := ParamSwitch('/DEBUG');
  if ParamSwitch('/NT') then
    LocalCompilerTimeout := ParamIntValue('/NT', LocalCompilerTimeout) * K_MSTOSEC;
  if ParamSwitch('/HELP') or ParamSwitch('/?') then
  begin
    ShowMessage('/RESET ' + #9#9 + '= ' + S_RESET + #13#10 +
                '/COM=PORT ' + #9 + '= ' + S_COM + #13#10 +
                '/RCX=N ' + #9 + '= ' + S_RCX + #13#10 +
                ' '       + #9#9 + '   ' + K_RCXINFO + #13#10 +
                '/AUTO '  + #9#9 + '= ' + S_AUTO + #13#10 +
                '/NOCONNECT ' + #9#9 + '= ' + S_NONE + #13#10 +
                '/POS=filename ' + #9 + '= ' + S_POS + #13#10 +
                '/NT=timeout ' + #9 + '= ' + S_NT + #13#10 +
                '/DEBUG ' + #9#9 + '= ' + S_DEBUG + #13#10 +
                '/UserPath=path ' + #9#9 + '= ' + S_USERPATH + #13#10 +
                '/? or /HELP ' + #9 + '= ' + S_HELP);
  end;
  Application.Run;
end.
