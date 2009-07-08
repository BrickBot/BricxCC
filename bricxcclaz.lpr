program bricxcclaz;

{$mode objfpc}{$H+}

uses
  {$IFDEF FPC}
  cthreads,
  LDockTree,
  Interfaces, // this includes the LCL widgetset
  {$ENDIF}
  Forms
  { you can add units after this },
  SysUtils,
  Dialogs,
  Controller,
  MainUnit,
  Diagnose,
  Unlock,
  Watch,
  uNewWatch,
  About,
  GotoLine,
  SearchRCX,
  Piano,
  ExecProgram,
  Preferences,
  Editor,
  ConstructUnit,
  JoystickUnit,
  PuzzleUnit,
  DatalogUnit,
  MemoryUnit,
  CodeUnit,
  Translate,
  MessageUnit,
  DTestPrintPreview,
  ParamUtils,
  GX_IDECodeTemplates,
  RemoteUnit,
  EditCodeTemplate,
  CodeTemplates,
  uVersionInfo,
  uCodeExplorer,
  Transfer,
  Transdlg,
  uExplorerOptions,
  uMacroLib,
  uMacroForm,
  uMacroEditor,
  uWindowList,
  uHighlighterProcs,
  uLASMProcLexer,
  uMindScriptProcLexer,
  uCppProcLexer,
  uBricxCCProcLexer,
  uExtensionDlg,
  uMindScript,
  GX_ProcedureList,
  uPasProcLexer,
  uParseCommon,
  uProjectManager,
  uCppCode,
  uPasCode,
  uMidi2MS,
  uMIDIConversion,
  uNewHotKey,
  uSetLNPAddress,
  uLegoSDKUtils,
  uForthProcLexer,
  uSources,
  uSetValues,
  uEEPROM,
  uWav2RSO,
  uNXTExplorer,
  uMiscDefines,
  uNXTController,
  uNXTImage,
  brick_common,
  uSpirit,
  pascalscript;

{$IFDEF WINDOWS}
{$R manifest.rc}
{$ENDIF}

const
  K_RCXINFO = '(RCX = 0, Cybermaster = 1, Scout = 2, RCX2 = 3, Spybot = 4, Swan = 5, and NXT = 6)';

resourcestring
  S_RESET = 'reload defaults from Default directory';
  S_COM   = 'use the named port for this instance (COM1..COMnnn, usb)';
  S_RCX   = 'use brick type N for this instance';
  S_AUTO  = 'auto connect using default or specified port and type';
  S_NONE  = 'do not connect to brick at startup';
  S_POS   = 'position windows using values in INI file';
  S_HELP  = 'display this message before starting up';
  S_NT    = 'use compiler timeout specified for this instance (in seconds)';
  S_DEBUG = 'display debug message when launching compiler';

begin
  Application.Title:='Bricx Command Center';
  Application.Initialize;

  {Find the program directory}
  ProgramDir := ExtractFilePath(Application.ExeName);

  if ParamSwitch('/NoNewMenuItems') then
    AddMenuItemsToNewMenu := False;

  RegisterApp;

  // we need to check this switch first before we create the preferences form
  if ParamSwitch('/RESET') then
    DeleteMainKey;

  if ParamSwitch('/PTO') then
    PingTimeout := StrToIntDef(ParamValue('/PTO'), K_DEFAULT_PING_TIMEOUT);

  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDirectForm, DirectForm);
  Application.CreateForm(TDiagForm, DiagForm);
  Application.CreateForm(TWatchForm, WatchForm);
  Application.CreateForm(TfrmNewWatch, frmNewWatch);
  Application.CreateForm(TSearchRCXForm, SearchRCXForm);
  Application.CreateForm(TPianoForm, PianoForm);
  Application.CreateForm(TConstructForm, ConstructForm);
  Application.CreateForm(TJoystickForm, JoystickForm);
  Application.CreateForm(TDatalogForm, DatalogForm);
  Application.CreateForm(TMemoryForm, MemoryForm);
  Application.CreateForm(TCodeForm, CodeForm);
  Application.CreateForm(TMessageForm, MessageForm);
  Application.CreateForm(TRemoteForm, RemoteForm);
  Application.CreateForm(TfrmProjectManager, frmProjectManager);
  Application.CreateForm(TfrmSetValues, frmSetValues);
  Application.CreateForm(TfrmSpybotEEPROM, frmSpybotEEPROM);
  Application.CreateForm(TfrmNXTExplorer, frmNXTExplorer);
  Application.CreateForm(TfrmNXTController, frmNXTController);
  Application.CreateForm(TfrmNXTImage, frmNXTImage);
  if not ParamSwitch('/RESET') then
    UpgradeRegistry; // must be done before creating preferences form
  if ParamSwitch('-EMBEDDING') or ParamSwitch('-AUTOMATION') then
  begin
    RunningAsCOMServer := True;
    LocalStartupAction := SU_NOCONNECT;
    Application.ShowMainForm := False;
  end;
  Application.CreateForm(TPrefForm, PrefForm);
  Application.CreateForm(TfrmCodeExplorer, frmCodeExplorer);
  Application.CreateForm(TfrmMacroManager, frmMacroManager);

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
                '/? or /HELP ' + #9 + '= ' + S_HELP);
  end;
  Application.Run;
end.

