object MainForm: TMainForm
  Left = 443
  Top = 249
  Width = 592
  Height = 416
  Caption = 'Bricx Command Center'
  Color = clBtnFace
  Constraints.MinHeight = 370
  Constraints.MinWidth = 370
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDragDrop = FormDragDrop
  OnDragOver = FormDragOver
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object splCodeExplorer: TSplitter
    Left = 105
    Top = 2
    Width = 4
    Height = 354
  end
  object barStatus: TStatusBar
    Left = 0
    Top = 356
    Width = 576
    Height = 22
    Hint = 'Copy'
    Panels = <
      item
        Alignment = taCenter
        Width = 80
      end
      item
        Width = 80
      end
      item
        Width = 80
      end
      item
        Width = 80
      end
      item
        Width = 80
      end
      item
        Width = 50
      end>
  end
  object pnlCodeExplorer: TPanel
    Left = 0
    Top = 2
    Width = 105
    Height = 354
    Align = alLeft
    BevelOuter = bvNone
    BevelWidth = 0
    DockSite = True
    TabOrder = 1
    OnDockOver = pnlCodeExplorerDockOver
    OnGetSiteInfo = pnlCodeExplorerGetSiteInfo
  end
  object pnlPageControl: TPanel
    Left = 312
    Top = 288
    Width = 73
    Height = 41
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    OnDragDrop = pnlPageControlDragDrop
    OnDragOver = pnlPageControlDragOver
    object pagMain: TPageControl
      Left = 0
      Top = 0
      Width = 73
      Height = 41
      Align = alClient
      TabOrder = 0
      OnChange = pagMainChange
      OnDragDrop = pagMainDragDrop
      OnDragOver = pagMainDragOver
    end
  end
  object pnlSep: TPanel
    Left = 0
    Top = 0
    Width = 576
    Height = 2
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
  end
  object dlgOpen: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Open'
    Left = 208
    Top = 24
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'nqc'
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Title = 'Save Current File'
    Left = 304
    Top = 24
  end
  object dlgPrint: TPrintDialog
    Options = [poPrintToFile, poWarning]
    Left = 144
    Top = 24
  end
  object dlgOpenFirmware: TOpenDialog
    DefaultExt = 'lgo'
    FileName = 'firm0309.lgo'
    Filter = 
      'Lego RCX Firmware (*.lgo)|*.lgo|Alternate RCX Firmware files (*.' +
      'srec)|*.srec|Lego NXT Firmware (*.rfw)|*.rfw|Alternate NXT Firmw' +
      'are files (*.a79)|*.a79|All Firmware files (*.lgo;*.srec;*.rfw;*' +
      '.a79)|*.lgo;*.srec;*.rfw;*.a79|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Choose the Firmware file'
    Left = 176
    Top = 24
  end
  object dlgPrinterSetup: TPrinterSetupDialog
    Left = 144
    Top = 56
  end
  object dlgOpenINI: TOpenDialog
    DefaultExt = 'ini'
    Filter = 'INI files|*.ini|All files|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Open file'
    Left = 272
    Top = 24
  end
  object dlgSaveINI: TSaveDialog
    DefaultExt = 'ini'
    Filter = 'INI files|*.ini|All files|*.*'
    Title = 'Save file'
    Left = 336
    Top = 24
  end
  object alMain: TActionList
    OnUpdate = alMainUpdate
    Left = 176
    Top = 56
    object actFileToolbar: TAction
      Category = 'Toolbars'
      Caption = 'File'
      OnExecute = actFileToolbarExecute
    end
    object actSearchToolbar: TAction
      Category = 'Toolbars'
      Caption = 'Search'
      OnExecute = actSearchToolbarExecute
    end
    object actCompileToolbar: TAction
      Category = 'Toolbars'
      Caption = 'Compile'
      OnExecute = actCompileToolbarExecute
    end
    object actHelpToolbar: TAction
      Category = 'Toolbars'
      Caption = 'Help'
      OnExecute = actHelpToolbarExecute
    end
    object actEditToolbar: TAction
      Category = 'Toolbars'
      Caption = 'Edit'
      OnExecute = actEditToolbarExecute
    end
    object actToolsToolbar: TAction
      Category = 'Toolbars'
      Caption = 'Tools'
      OnExecute = actToolsToolbarExecute
    end
    object actFileNew: TAction
      Category = 'File'
      Caption = '&New'
      Hint = 'New file'
      ShortCut = 16462
      OnExecute = actFileNewExecute
    end
    object actFileOpen: TAction
      Category = 'File'
      Caption = '&Open...'
      HelpContext = 5
      Hint = 'Open file'
      OnExecute = actFileOpenExecute
    end
    object actFileSave: TAction
      Category = 'File'
      Caption = '&Save'
      HelpContext = 5
      Hint = 'Save file'
      ShortCut = 16467
      OnExecute = actFileSaveExecute
    end
    object actFileSaveAs: TAction
      Category = 'File'
      Caption = 'Save &As...'
      HelpContext = 5
      OnExecute = actFileSaveAsExecute
    end
    object actFileClose: TAction
      Category = 'File'
      Caption = '&Close'
      Hint = 'Close file'
      ShortCut = 16499
      OnExecute = actFileCloseExecute
    end
    object actFileCloseAll: TAction
      Category = 'File'
      Caption = 'C&lose All'
      Hint = 'Close all files'
      OnExecute = actFileCloseAllExecute
    end
    object actFileInsertFile: TAction
      Category = 'File'
      Caption = '&Insert File...'
      OnExecute = actFileInsertFileExecute
    end
    object actFilePageSetup: TAction
      Category = 'File'
      Caption = 'Page Setup...'
      HelpContext = 13000
      HelpType = htContext
      Hint = 'Page setup'
      OnExecute = actFilePageSetupExecute
    end
    object actFilePrinterSetup: TAction
      Category = 'File'
      Caption = 'Printer Setup...'
      OnExecute = actFilePrinterSetupExecute
    end
    object actFilePrintPreview: TAction
      Category = 'File'
      Caption = 'Print Preview...'
      HelpContext = 19000
      HelpType = htContext
      Hint = 'Preview'
      OnExecute = actFilePrintPreviewExecute
    end
    object actFilePrint: TAction
      Category = 'File'
      Caption = '&Print...'
      Hint = 'Print'
      ShortCut = 16464
      OnExecute = actFilePrintExecute
    end
    object actFileExit: TAction
      Category = 'File'
      Caption = 'E&xit'
      OnExecute = actFileExitExecute
    end
    object actEditUndo: TAction
      Category = 'Edit'
      Caption = '&Undo'
      Hint = 'Undo'
      OnExecute = actEditUndoExecute
    end
    object actEditRedo: TAction
      Category = 'Edit'
      Caption = '&Redo'
      Hint = 'Redo'
      OnExecute = actEditRedoExecute
    end
    object actEditCut: TAction
      Category = 'Edit'
      Caption = 'Cu&t'
      Hint = 'Cut'
      OnExecute = actEditCutExecute
    end
    object actEditCopy: TAction
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy'
      OnExecute = actEditCopyExecute
    end
    object actEditPaste: TAction
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste'
      OnExecute = actEditPasteExecute
    end
    object actEditDelete: TAction
      Category = 'Edit'
      Caption = '&Delete'
      Hint = 'Delete'
      OnExecute = actEditDeleteExecute
    end
    object actEditSelectAll: TAction
      Category = 'Edit'
      Caption = 'Select &All'
      OnExecute = actEditSelectAllExecute
    end
    object actEditNextField: TAction
      Category = 'Edit'
      Caption = 'N&ext Field'
      ShortCut = 121
      OnExecute = actEditNextFieldExecute
    end
    object actEditPreferences: TAction
      Category = 'Edit'
      Caption = '&Preferences...'
      HelpContext = 11
      Hint = 'Edit preferences'
      OnExecute = actEditPreferencesExecute
    end
    object actSearchFind: TAction
      Category = 'Search'
      Caption = '&Find...'
      HelpContext = 7
      Hint = 'Find ...'
      ShortCut = 16454
      OnExecute = actSearchFindExecute
    end
    object actSearchFindNext: TAction
      Category = 'Search'
      Caption = 'Find &Next'
      HelpContext = 7
      ShortCut = 114
      OnExecute = actSearchFindNextExecute
    end
    object actSearchFindPrev: TAction
      Category = 'Search'
      Caption = 'Find &Previous'
      HelpContext = 7
      ShortCut = 8306
      OnExecute = actSearchFindPrevExecute
    end
    object actSearchReplace: TAction
      Category = 'Search'
      Caption = '&Replace...'
      HelpContext = 7
      Hint = 'Find and replace ...'
      ShortCut = 16466
      OnExecute = actSearchReplaceExecute
    end
    object actSearchGotoLine: TAction
      Category = 'Search'
      Caption = '&Go to Line Number...'
      Hint = 'Go to line number'
      ShortCut = 16455
      OnExecute = actSearchGotoLineExecute
    end
    object actSearchProcList: TAction
      Category = 'Search'
      Caption = 'Procedure &List...'
      Hint = 'Procedure list'
      ShortCut = 24647
      OnExecute = actSearchProcListExecute
    end
    object actCompileCompile: TAction
      Category = 'Compile'
      Caption = '&Compile'
      HelpContext = 10
      Hint = 'Compile program'
      ShortCut = 116
      OnExecute = actCompileCompileExecute
    end
    object actCompileDownload: TAction
      Category = 'Compile'
      Caption = 'Down&load'
      HelpContext = 10
      Hint = 'Download program'
      ShortCut = 117
      OnExecute = actCompileDownloadExecute
    end
    object actCompileDownloadRun: TAction
      Category = 'Compile'
      Caption = '&Download and Run'
      HelpContext = 10
      ShortCut = 16500
      OnExecute = actCompileDownloadRunExecute
    end
    object actCompileRun: TAction
      Category = 'Compile'
      Caption = '&Run'
      HelpContext = 10
      Hint = 'Run program'
      ShortCut = 118
      OnExecute = actCompileRunExecute
    end
    object actCompileStop: TAction
      Category = 'Compile'
      Caption = '&Stop'
      HelpContext = 10
      Hint = 'Stop program'
      ShortCut = 119
      OnExecute = actCompileStopExecute
    end
    object actToolsDirect: TAction
      Category = 'Tools'
      Caption = 'Direct &Control'
      HelpContext = 12
      Hint = 'Direct control'
      OnExecute = actToolsDirectExecute
    end
    object actToolsDiag: TAction
      Category = 'Tools'
      Caption = '&Diagnostics'
      HelpContext = 13
      Hint = 'Diagnostics'
      OnExecute = actToolsDiagExecute
    end
    object actToolsWatch: TAction
      Category = 'Tools'
      Caption = '&Watching the Brick'
      HelpContext = 14
      Hint = 'Watching the brick'
      OnExecute = actToolsWatchExecute
    end
    object actToolsPiano: TAction
      Category = 'Tools'
      Caption = 'Brick &Piano'
      HelpContext = 15
      Hint = 'Brick piano'
      OnExecute = actToolsPianoExecute
    end
    object actToolsJoystick: TAction
      Category = 'Tools'
      Caption = 'Brick &Joystick'
      HelpContext = 16
      Hint = 'Brick joystick'
      OnExecute = actToolsJoystickExecute
    end
    object actToolsRemote: TAction
      Category = 'Tools'
      Caption = 'Rem&ote'
      HelpContext = 17
      Hint = 'Remote'
      OnExecute = actToolsRemoteExecute
    end
    object actToolsSendMsg: TAction
      Category = 'Tools'
      Caption = '&Send Messages'
      HelpContext = 18
      Hint = 'Send messages'
      OnExecute = actToolsSendMsgExecute
    end
    object actToolsDatalog: TAction
      Category = 'Tools'
      Caption = 'D&atalog'
      HelpContext = 19
      Hint = 'Datalog'
      OnExecute = actToolsDatalogExecute
    end
    object actToolsMemory: TAction
      Category = 'Tools'
      Caption = 'M&emory Map'
      HelpContext = 21
      Hint = 'Memory map'
      OnExecute = actToolsMemoryExecute
    end
    object actToolsClearMem: TAction
      Category = 'Tools'
      Caption = 'Clear &Memory'
      HelpContext = 20
      Hint = 'Clear memory'
      OnExecute = actToolsClearMemExecute
    end
    object actToolsFindBrick: TAction
      Category = 'Tools'
      Caption = 'Find B&rick'
      HelpContext = 22
      Hint = 'Find brick'
      ShortCut = 24690
      OnExecute = actToolsFindBrickExecute
    end
    object actToolsTurnBrickOff: TAction
      Category = 'Tools'
      Caption = 'T&urn Brick Off'
      Hint = 'Turn brick off'
      OnExecute = actToolsTurnBrickOffExecute
    end
    object actToolsCloseComm: TAction
      Category = 'Tools'
      Caption = 'Close Commu&nication'
      Hint = 'Close communication'
      ShortCut = 24691
      OnExecute = actToolsCloseCommExecute
    end
    object actToolsFirmware: TAction
      Category = 'Tools'
      Caption = 'Download &Firmware'
      HelpContext = 23
      Hint = 'Download firmware'
      OnExecute = actToolsFirmwareExecute
    end
    object actToolsUnlockFirm: TAction
      Category = 'Tools'
      Caption = 'Unloc&k Firmware'
      Hint = 'Unlock firmware'
      OnExecute = actToolsUnlockFirmExecute
    end
    object actToolsConfigureTools: TAction
      Category = 'Tools'
      Caption = 'Configure &Tools...'
      Hint = 'Configure tools'
      ImageIndex = 34
      OnExecute = actToolsConfigureToolsExecute
    end
    object actHelpHelp: TAction
      Category = 'Help'
      Caption = '&Contents'
      Hint = 'Help'
      OnExecute = actHelpHelpExecute
    end
    object actHelpInfo: TAction
      Category = 'Help'
      Caption = '&About...'
      Hint = 'About BricxCC'
      OnExecute = actHelpInfoExecute
    end
    object actFileSaveAll: TAction
      Category = 'File'
      Caption = 'Sa&ve All'
      HelpContext = 5
      OnExecute = actFileSaveAllExecute
    end
    object actToolsMIDI: TAction
      Category = 'Tools'
      Caption = 'MIDI Con&version...'
      Hint = 'MIDI conversion'
      OnExecute = actToolsMIDIExecute
    end
    object actToolsNewWatch: TAction
      Category = 'Tools'
      Caption = 'Confi&gurable Watch'
      Hint = 'Configurable watch'
      OnExecute = actToolsNewWatchExecute
    end
    object actToolsSetValues: TAction
      Category = 'Tools'
      Caption = 'Set va&lues'
      Hint = 'Set source values'
      OnExecute = actToolsSetValuesExecute
    end
    object actToolsSpybotEEPROM: TAction
      Category = 'Tools'
      Caption = 'Sp&ybot EEPROM'
      Hint = 'Spybot EEPROM'
      OnExecute = actToolsSpybotEEPROMExecute
    end
    object actEditCopyHTML: TAction
      Category = 'Edit'
      Caption = '&HTML'
      OnExecute = actEditCopyHTMLExecute
    end
    object actEditCopyRTF: TAction
      Category = 'Edit'
      Caption = '&RTF'
      OnExecute = actEditCopyRTFExecute
    end
    object actToolsNXTExplorer: TAction
      Category = 'Tools'
      Caption = 'N&XT Explorer'
      Hint = 'NXT Explorer'
      OnExecute = actToolsNXTExplorerExecute
    end
    object actToolsWav2Rso: TAction
      Category = 'Tools'
      Caption = 'Sound Convers&ion...'
      Hint = 'Sound conversion'
      OnExecute = actToolsWav2RsoExecute
    end
    object actToolsSyncMotors: TAction
      Category = 'Tools'
      Caption = 'S&ync Motors'
      Hint = 'Sync Motors'
      OnExecute = actToolsSyncMotorsExecute
    end
    object actToolsNXTScreen: TAction
      Category = 'Tools'
      Caption = 'N&XT Screen'
      Hint = 'NXT Screen'
      OnExecute = actToolsNXTScreenExecute
    end
    object actCompileTraceInto: TAction
      Category = 'Compile'
      Caption = 'Trace Into'
      Hint = 'Trace into'
      ShortCut = 122
      OnExecute = actCompileTraceIntoExecute
    end
    object actCompileStepOver: TAction
      Category = 'Compile'
      Caption = 'Step Over'
      Hint = 'Step over'
      ShortCut = 8313
      OnExecute = actCompileStepOverExecute
    end
    object actCompilePause: TAction
      Category = 'Compile'
      Caption = 'Break all'
      Hint = 'Pause program'
      ShortCut = 16503
      OnExecute = actCompilePauseExecute
    end
    object actCompileSingleStep: TAction
      Category = 'Compile'
      Caption = 'Single Step'
      Enabled = False
      Hint = 'Single step'
      ShortCut = 16502
      Visible = False
      OnExecute = actCompileSingleStepExecute
    end
    object actCompileStepOut: TAction
      Category = 'Compile'
      Caption = 'Step Out'
      Hint = 'Run until return'
      ShortCut = 8314
      OnExecute = actCompileStepOutExecute
    end
    object actCompileTraceToLine: TAction
      Category = 'Compile'
      Caption = 'Trace to Next Source Line'
      Hint = 'Trace to next source line'
      ShortCut = 8310
      OnExecute = actCompileTraceToLineExecute
    end
    object actCompileRunToCursor: TAction
      Category = 'Compile'
      Caption = 'Run to Cursor'
      Hint = 'Run to cursor'
      ShortCut = 115
      OnExecute = actCompileRunToCursorExecute
    end
    object actHelpNXCGuidePDF: TAction
      Category = 'Help'
      Caption = 'NXC'
      Hint = 'View NXC Guide'
      OnExecute = actHelpNXCGuidePDFExecute
    end
    object actHelpNQCGuidePDF: TAction
      Category = 'Help'
      Caption = 'NQC'
      Hint = 'View NQC Guide'
      OnExecute = actHelpNQCGuidePDFExecute
    end
    object actHelpNBCGuidePDF: TAction
      Category = 'Help'
      Caption = 'NBC'
      Hint = 'View NBC Guide'
      OnExecute = actHelpNBCGuidePDFExecute
    end
    object actHelpNXCTutorialPDF: TAction
      Category = 'Help'
      Caption = 'NXC'
      Hint = 'View NXC Tutorial'
      OnExecute = actHelpNXCTutorialPDFExecute
    end
    object actHelpNQCTutorialPDF: TAction
      Category = 'Help'
      Caption = 'NQC'
      Hint = 'View NQC Tutorial'
      OnExecute = actHelpNQCTutorialPDFExecute
    end
    object actHelpNBCTutorialPDF: TAction
      Category = 'Help'
      Caption = 'NBC'
      Hint = 'View NBC Tutorial'
      OnExecute = actHelpNBCTutorialPDFExecute
    end
    object actSearchGrepSearch: TAction
      Category = 'Search'
      Caption = 'Grep search...'
      Hint = 'Grep search'
      ShortCut = 41043
      OnExecute = actSearchGrepSearchExecute
    end
    object actSearchGrepResults: TAction
      Category = 'Search'
      Caption = 'Grep results'
      Hint = 'Grep results'
      ShortCut = 49234
      OnExecute = actSearchGrepResultsExecute
    end
    object actToolsNXTWatchList: TAction
      Category = 'Tools'
      Caption = 'NXT Watch List'
      OnExecute = actToolsNXTWatchListExecute
    end
    object actHelpSPCGuidePDF: TAction
      Category = 'Help'
      Caption = 'SPC'
      OnExecute = actHelpSPCGuidePDFExecute
    end
    object actToolsSimpleTerm: TAction
      Category = 'Tools'
      Caption = 'Simple Terminal'
      OnExecute = actToolsSimpleTermExecute
    end
  end
  object dlgInsertFile: TOpenDialog
    DefaultExt = 'nqc'
    Filter = 'NQC files|*.nqc|All files|*.*'
    Title = 'Insert a File'
    Left = 240
    Top = 24
  end
end
