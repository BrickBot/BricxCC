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
unit Preferences;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

{$I bricxcc.inc}

interface

uses
{$IFNDEF FPC}
  ColorGrd,
  DirectoryEdit,
{$ELSE}
  LResources,
  ColorBox,
  EditBtn,
{$ENDIF}
  Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ComCtrls, ExtCtrls, Buttons, SynEditHighlighter,
  SynHighlighterNQC, SynEdit, SynEditKeyCmds, Registry,
  SynHighlighterForth, SynHighlighterCpp, SynHighlighterJava,
  SynHighlighterCS, SynHighlighterMindScript, SynHighlighterLua,
  SynHighlighterLASM, SynHighlighterPas, uParseCommon, uNewHotKey,
  uMiscDefines, SynHighlighterNBC, uOfficeComp, BricxccSpin,
  SynHighlighterRuby, SynHighlighterNPG, SynHighlighterRS,
  SynHighlighterROPS;

type
  TActiveHighlighterReason = (ahColors, ahTemplates);

  { TPrefForm }

  TPrefForm = class(TForm)
    dlgFont: TFontDialog;
    Panel3: TPanel;
    btnDefault: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    Panel1: TPanel;
    pagPrefs: TPageControl;
    shtGeneral: TTabSheet;
    CheckSavePos: TCheckBox;
    CheckSaveBackup: TCheckBox;
    CheckShowRecent: TCheckBox;
    shtEditor: TTabSheet;
    shtStartup: TTabSheet;
    CheckShowForm: TRadioButton;
    CheckNoConnect: TRadioButton;
    CheckConnect: TRadioButton;
    grpDefValues: TGroupBox;
    shtTemplates: TTabSheet;
    InsertBtn: TButton;
    ChangeBtn: TButton;
    DeleteBtn: TButton;
    UpBtn: TBitBtn;
    DownBtn: TBitBtn;
    shtMacros: TTabSheet;
    ShiftMacrosList: TListBox;
    MacrosList: TListBox;
    MChange: TButton;
    MDelete: TButton;
    shtColors: TTabSheet;
    lblElement: TLabel;
    lblColor: TLabel;
    lbElements: TListBox;
    grpTextAttributes: TGroupBox;
    chkBold: TCheckBox;
    chkItalic: TCheckBox;
    chkUnderline: TCheckBox;
    grpFGBG: TGroupBox;
    chkFG: TCheckBox;
    chkBG: TCheckBox;
    shtOptions: TTabSheet;
    grpGutter: TGroupBox;
    lblGutterRightOffset: TLabel;
    lblGutterLeftOffset: TLabel;
    lblGutterDigCnt: TLabel;
    lblGutterWidth: TLabel;
    lblGutterColor: TLabel;
    cbUseFontStyle: TCheckBox;
    cbGutterVisible: TCheckBox;
    cbAutoSize: TCheckBox;
    cbLineNumbers: TCheckBox;
    cbLeadingZeros: TCheckBox;
    cbZeroStart: TCheckBox;
    btnKeystrokes: TButton;
    chkShowCompileStatus: TCheckBox;
    MShift: TSpeedButton;
    chkFirmfast: TCheckBox;
    grpLockedProgs: TGroupBox;
    cbProg1: TCheckBox;
    cbProg2: TCheckBox;
    cbProg3: TCheckBox;
    cbProg4: TCheckBox;
    cbProg5: TCheckBox;
    btnEditCodeTemplates: TButton;
    btnClaimExt: TButton;
    shtAPI: TTabSheet;
    btnAddAPI: TButton;
    btnDeleteAPI: TButton;
    grpAutoSave: TGroupBox;
    chkAutoSave: TCheckBox;
    chkSaveDesktop: TCheckBox;
    chkSaveBinaryOutput: TCheckBox;
    chkFBAlwaysPrompt: TCheckBox;
    lblLanguages: TLabel;
    cboLanguages: TComboBox;
    lblMaxRecent: TLabel;
    shtCompiler: TTabSheet;
    pagCompiler: TPageControl;
    shtCompilerCommon: TTabSheet;
    lblCompilerTimeout: TLabel;
    lblCompilerSwitches: TLabel;
    edtCompilerSwitches: TEdit;
    shtCompilerNQC: TTabSheet;
    lblNQCIncludePath: TLabel;
    shtCompilerLCC: TTabSheet;
    lblLCCIncludePath: TLabel;
    shtCompilerBrickOS: TTabSheet;
    edtNQCSwitches: TEdit;
    lblNQCSwitches: TLabel;
    lblLCCSwitches: TLabel;
    edtLCCSwitches: TEdit;
    lblOSRoot: TLabel;
    edtOSRoot: TEdit;
    edtCPPSwitches: TEdit;
    lblCPPSwitches: TLabel;
    lblCommonSeconds: TLabel;
    lblBrickOSMakefileTemplate: TLabel;
    edtBrickOSMakefileTemplate: TMemo;
    edtLCCIncludePath: TComboBox;
    edtNQCIncludePath: TComboBox;
    lblCygwin: TLabel;
    chkKeepBrickOSMakefile: TCheckBox;
    grpHotKeys: TGroupBox;
    lblCodeComp: TLabel;
    lblParamComp: TLabel;
    lblRecMacro: TLabel;
    lblPlayMacro: TLabel;
    chkLockToolbars: TCheckBox;
    cbProg6: TCheckBox;
    cbProg7: TCheckBox;
    cbProg8: TCheckBox;
    lblNQCPath: TLabel;
    lblLCCExePath: TLabel;
    btnGetNQCVersion: TButton;
    btnGetLCCVersion: TButton;
    shtCompilerLeJOS: TTabSheet;
    lblJavaSwitches: TLabel;
    edtJavaSwitches: TEdit;
    lblLeJOSMakefileTemplate: TLabel;
    edtLeJOSMakefileTemplate: TMemo;
    chkKeepLeJOSMakefile: TCheckBox;
    Label1: TLabel;
    lblLeJOSRoot: TLabel;
    shtForth: TTabSheet;
    chkShowAllOutput: TCheckBox;
    chkStopOnAborted: TCheckBox;
    chkSkipBlankLines: TCheckBox;
    chkStripComments: TCheckBox;
    lblInterCharacterDelay: TLabel;
    lblInterLineDelay: TLabel;
    chkConsoleSyntaxHL: TCheckBox;
    chkOutputSeparate: TCheckBox;
    chkShowConsoleLineNumbers: TCheckBox;
    grpUSB: TGroupBox;
    lblReadFirstTimeout: TLabel;
    lblReadICTimeout: TLabel;
    lblWriteTimeout: TLabel;
    chkConsoleCompProp: TCheckBox;
    edtPascalCompilerPrefix: TEdit;
    lblPascalCompilerPrefix: TLabel;
    chkMaxEditWindows: TCheckBox;
    chkMultiFormatCopy: TCheckBox;
    chkUseMDI: TCheckBox;
    chkQuietFirmware: TCheckBox;
    lblFirmChunk: TLabel;
    grpDefLanguage: TGroupBox;
    radPrefNQC: TRadioButton;
    radPrefMindScript: TRadioButton;
    radPrefLASM: TRadioButton;
    chkFirmComp: TCheckBox;
    btnHelp: TButton;
    lblWaitTime: TLabel;
    radPrefNBC: TRadioButton;
    shtNBC: TTabSheet;
    btnGetNBCVersion: TButton;
    edtNBCSwitches: TEdit;
    edtNBCIncludePath: TComboBox;
    lblNBCIncludePath: TLabel;
    lblNBCSwitches: TLabel;
    lblNBCExePath: TLabel;
    grpBrickType: TGroupBox;
    cboBrickType: TComboBox;
    grpPorts: TGroupBox;
    cboPort: TComboBox;
    grpFirmware: TGroupBox;
    radStandard: TRadioButton;
    radBrickOS: TRadioButton;
    radPBForth: TRadioButton;
    radLejos: TRadioButton;
    radOtherFirmware: TRadioButton;
    lblLangTemp: TLabel;
    cboLangTemp: TComboBox;
    btnSaveTemplates: TButton;
    btnLoadTemplates: TButton;
    dlgLoadTemplates: TOpenDialog;
    dlgSaveTemplates: TSaveDialog;
    btnPrecompile: TButton;
    btnPostcompile: TButton;
    radPrefNXC: TRadioButton;
    cbSelectOnClick: TCheckBox;
    grpOther: TGroupBox;
    chkDroppedRecent: TCheckBox;
    chkUseIntNBCComp: TCheckBox;
    cboOptLevel: TComboBox;
    lblOptLevel: TLabel;
    chkEnhancedFirmware: TCheckBox;
    chkIgnoreSysFiles: TCheckBox;
    pagEditor: TPageControl;
    shtEditorOptions: TTabSheet;
    btnFont: TButton;
    cbxScrollBars: TComboBox;
    lblScrollBars: TLabel;
    chkGroupUndo: TCheckBox;
    chkEnhHomeKey: TCheckBox;
    chkKeepBlanks: TCheckBox;
    chkSmartTab: TCheckBox;
    chkDragDrop: TCheckBox;
    cbHalfPageScroll: TCheckBox;
    cbScrollPastEOL: TCheckBox;
    cbHideSelection: TCheckBox;
    chkMoveRight: TCheckBox;
    chkAltSelMode: TCheckBox;
    CheckMacrosOn: TCheckBox;
    CheckAutoIndentCode: TCheckBox;
    CheckShowTemplates: TCheckBox;
    CheckColorCoding: TCheckBox;
    shtEditorColors: TTabSheet;
    lblRightEdgeColor: TLabel;
    lblSelFore: TLabel;
    lblSelBack: TLabel;
    lblEditorColor: TLabel;
    lblStructureColor: TLabel;
    chkTabIndent: TCheckBox;
    chkShowSpecialChars: TCheckBox;
    chkConvertTabs: TCheckBox;
    Label3: TLabel;
    lblTabWidth: TLabel;
    lblMaxUndo: TLabel;
    lblExtraSpace: TLabel;
    lblRightEdge: TLabel;
    chkHighlightCurLine: TCheckBox;
    chkKeepCaretX: TCheckBox;
    chkAutoMaxLeft: TCheckBox;
    Label4: TLabel;
    chkNewMenu: TCheckBox;
    cbxREColor: TColorBox;
    cbxForeground: TColorBox;
    cbxBackground: TColorBox;
    cbxColor: TColorBox;
    cbxStructureColor: TColorBox;
    cbxActiveLineColor: TColorBox;
    cbxGutterColor: TColorBox;
    cbxFGColor: TColorBox;
    cbxBGColor: TColorBox;
    Label5: TLabel;
    lblMaxErrors: TLabel;
    edtNQCExePath2: TEdit;
    edtLCCExePath2: TEdit;
    edtNBCExePath2: TEdit;
    edtCygwin2: TEdit;
    edtJavaPath2: TEdit;
    edtLeJOSRoot2: TEdit;
    pagAPILang: TPageControl;
    shtNQCAPI: TTabSheet;
    pagNQCAPI: TPageControl;
    shtAPIKeywords: TTabSheet;
    lstKeywords: TListBox;
    edtKeyword: TEdit;
    shtAPICommands: TTabSheet;
    lstCommands: TListBox;
    edtCommand: TEdit;
    shtAPIConstants: TTabSheet;
    lstConstants: TListBox;
    edtConstant: TEdit;
    shtNXCAPI: TTabSheet;
    pagNXCAPI: TPageControl;
    shtNXCKeywords: TTabSheet;
    lstNXCKeywords: TListBox;
    edtNXCKeyword: TEdit;
    shtNXCCommands: TTabSheet;
    lstNXCCommands: TListBox;
    edtNXCCommand: TEdit;
    shtNXCConstants: TTabSheet;
    lstNXCConstants: TListBox;
    edtNXCConstant: TEdit;
    NewTemplatesList2: TMemo;
    SynEditColors2: TMemo;
    hkCodeComp2: TEdit;
    hkParamComp2: TEdit;
    hkRecMacro2: TEdit;
    hkPlayMacro2: TEdit;
    chkNXT2Firmare: TCheckBox;
    grpRICComp: TGroupBox;
    radRICDecompScript: TRadioButton;
    radRICDecompArray: TRadioButton;
    lblArrayNameFormat: TLabel;
    edtRICDecompArrayFmt: TEdit;
    shtExperts: TTabSheet;
    btnEditorExpertsConfig: TButton;
    chkIncludeSrcInList: TCheckBox;
    pnlAPIRight: TPanel;
    grpAPIHeaders: TGroupBox;
    btnShowNQCDefs: TButton;
    btnShowNBCCommon: TButton;
    btnShowNXTDefs: TButton;
    btnShowNXCDefs: TButton;
    chkCCInsensitive: TCheckBox;
    edtMaxLeftChar: TBricxccSpinEdit;
    inpTabWidth: TBricxccSpinEdit;
    inpMaxUndo: TBricxccSpinEdit;
    inpExtraLineSpacing: TBricxccSpinEdit;
    inpRightEdge: TBricxccSpinEdit;
    edtMaxRecent: TBricxccSpinEdit;
    edtFirmwareChunkSize: TBricxccSpinEdit;
    edtWaitTime: TBricxccSpinEdit;
    edtCompilerTimeout: TBricxccSpinEdit;
    edtMaxErrors: TBricxccSpinEdit;
    edtConsoleReadFirstTimeout: TBricxccSpinEdit;
    edtConsoleReadICTimeout: TBricxccSpinEdit;
    edtConsoleWriteTimeout: TBricxccSpinEdit;
    edtICDelay: TBricxccSpinEdit;
    edtILDelay: TBricxccSpinEdit;
    inpRightOffset: TBricxccSpinEdit;
    inpLeftOffset: TBricxccSpinEdit;
    inpDigitCount: TBricxccSpinEdit;
    inpGutterWidth: TBricxccSpinEdit;
    lbEditorExperts: TListBox;
    btnEditorExpertsShortcut: TButton;
    mmoEditorExpertsHelp: TMemo;
    chkNXTAutoFW: TCheckBox;
    chkUseHTMLHelp: TCheckBox;
    shtPaths: TTabSheet;
    edtUserDataPath2: TEdit;
    Label2: TLabel;
    Label6: TLabel;
    edtSymLibPath2: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CheckConnectClick(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure DownBtnClick(Sender: TObject);
    procedure ChangeBtnClick(Sender: TObject);
    procedure InsertBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure TemplatesListDblClick(Sender: TObject);
    procedure MShiftClick(Sender: TObject);
    procedure MDeleteClick(Sender: TObject);
    procedure MChangeClick(Sender: TObject);
    procedure ShiftMacrosListDblClick(Sender: TObject);
    procedure lbElementsClick(Sender: TObject);
    procedure chkBoldClick(Sender: TObject);
    procedure chkItalicClick(Sender: TObject);
    procedure chkUnderlineClick(Sender: TObject);
    procedure chkFGClick(Sender: TObject);
    procedure chkBGClick(Sender: TObject);
    procedure btnKeystrokesClick(Sender: TObject);
    procedure btnEditCodeTemplatesClick(Sender: TObject);
    procedure btnClaimExtClick(Sender: TObject);
    procedure btnAddAPIClick(Sender: TObject);
    procedure btnDeleteAPIClick(Sender: TObject);
    procedure lstAPIClick(Sender: TObject);
    procedure edtAPIChange(Sender: TObject);
    procedure pagPrefsChange(Sender: TObject);
    procedure pagNQCAPIChange(Sender: TObject);
    procedure cboLanguagesChange(Sender: TObject);
    procedure edtLCCIncludePathExit(Sender: TObject);
    procedure edtNQCIncludePathExit(Sender: TObject);
    procedure chkFirmfastClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnGetNQCVersionClick(Sender: TObject);
    procedure btnGetLCCVersionClick(Sender: TObject);
    procedure btnGetNBCVersionClick(Sender: TObject);
    procedure edtNBCIncludePathExit(Sender: TObject);
    procedure cboLangTempChange(Sender: TObject);
    procedure NewTemplatesList2Change(Sender: TObject);
    procedure btnSaveTemplatesClick(Sender: TObject);
    procedure btnLoadTemplatesClick(Sender: TObject);
    procedure btnPrecompileClick(Sender: TObject);
    procedure btnPostcompileClick(Sender: TObject);
    procedure cbxFGColorChange(Sender: TObject);
    procedure cbxBGColorChange(Sender: TObject);
    procedure radRICDecompScriptClick(Sender: TObject);
    procedure btnCommentConfigClick(Sender: TObject);
    procedure btnAlignLinesConfigClick(Sender: TObject);
    procedure btnShowNQCDefsClick(Sender: TObject);
    procedure btnShowNBCCommonClick(Sender: TObject);
    procedure btnShowNXTDefsClick(Sender: TObject);
    procedure btnShowNXCDefsClick(Sender: TObject);
    procedure btnGrepSearchConfigClick(Sender: TObject);
    procedure lbEditorExpertsClick(Sender: TObject);
    procedure btnEditorExpertsConfigClick(Sender: TObject);
    procedure btnEditorExpertsShortcutClick(Sender: TObject);
  private
    { Private declarations }
    fColorsChanged : boolean;
    fKeystrokes : TSynEditKeyStrokes;
    fCodeTemplates: TStrings;
    fLocalHighlighters : TStringList;
    fReg: TRegistry;
    fDefBGColors : array of array of TColor;
    fDefFGColors : array of array of TColor;
    fDefStyles : array of array of TFontStyles;
    SynCppSyn: TSynCppSyn;
    SynMindScriptSyn: TSynMindScriptSyn;
    SynNPGSyn: TSynNPGSyn;
    SynForthSyn: TSynForthSyn;
    SynJavaSyn: TSynJavaSyn;
    SynNQCSyn: TSynNQCSyn;
    SynNXCSyn: TSynNXCSyn;
    SynRSSyn: TSynRSSyn;
    SynROPSSyn: TSynROPSSyn;
    SynLASMSyn: TSynLASMSyn;
    SynLuaSyn: TSynLuaSyn;
    SynRubySyn: TSynRubySyn;
    SynPasSyn: TSynPasSyn;
    SynNBCSyn: TSynNBCSyn;
    SynCSSyn: TSynCSSyn;
    SynSPCSyn: TSynSPCSyn;
    procedure SetHelpContext;
    procedure UpdateEditorExperts;
    procedure UpdateCheckState;
    function GetCustomHighlighter(index: Integer): TSynCustomHighlighter;
    function GetActiveHighlighter(reason : TActiveHighlighterReason = ahColors) : TSynCustomHighlighter;
    procedure StoreDefaultAttributes;
    procedure LoadAttributeNames;
    procedure ShowSampleSource;
    procedure ShowItemInEditor(i : Integer);
    procedure UncheckStyles;
    procedure CheckStyles;
    procedure UncheckDefaults;
    procedure CheckDefaults;
    function GetFGColor(idx : integer) : TColor;
    procedure SetFGColor(idx : integer; aColor : TColor);
    function GetBGColor(idx : integer) : TColor;
    procedure SetBGColor(idx : integer; aColor : TColor);
    function GetStyles(idx : integer) : TFontStyles;
    procedure SetStyles(idx : integer; aStyle : TFontStyles);
    procedure DisplayColorValues;
    procedure UpdateGlobalColorsAndStyles;
    function UsingFGDefault(idx : integer) : boolean;
    function UsingBGDefault(idx : integer) : boolean;
    function GetFGDefault(idx : integer) : TColor;
    function GetBGDefault(idx : integer) : TColor;
    procedure DisplayShortcutValues;
    procedure UpdateGlobalShortcutValues;
    procedure DisplayGutterValues;
    procedure UpdateGlobalGutterValues;
    procedure DisplayOtherOptionValues;
    procedure UpdateGlobalOtherOptionValues;
    procedure SetKeystrokes(const Value: TSynEditKeyStrokes);
    procedure DisplayKeystrokeValues;
    procedure UpdateGlobalKeystrokeValues;
    procedure DisplayCodeTemplateValues;
    procedure SetCodeTemplates(const Value: TStrings);
    function GetActiveAPIListBox : TListBox;
    function GetActiveAPIEdit : TEdit;
    procedure UpdateAPIButtonState;
    procedure ResetColorGrid;
//    function ActiveLanguageName(reason : TActiveHighlighterReason = ahColors) : String;
    function ActiveLanguageIndex(reason: TActiveHighlighterReason = ahColors): Integer;
    function LocalHighlighters : TStringList;
    function LanguageCount : Integer;
    property LanguageHighlighter[index : Integer] : TSynCustomHighlighter read GetCustomHighlighter;
    procedure ConfigureOtherFirmwareOptions;
    procedure ShowVersion(aPath : string);
    function GetFirmwareTypeDefault: TFirmwareType;
    procedure SetFirmwareType(ft: TFirmwareType);
    function GetPrefLang: Integer;
    procedure SetPrefLang(const Value: Integer);
    procedure CreatePrefFormHighlighters;
    procedure CreateHotKeyEdits;
    procedure CreateSynEditComponents;
    procedure CreateDirectoryEdits;
    procedure DisplayAPIValues;
    procedure GetAPIValues;
    procedure DisplayCompilerValues;
    procedure DisplayEditorValues;
    procedure DisplayGeneralValues;
    procedure DisplayMacroValues;
    procedure DisplayStartupValues;
    procedure DisplayTemplateValues(const aLang : integer);
    procedure GetCompilerValues;
    procedure GetEditorValues;
    procedure GetGeneralValues;
    procedure GetMacroValues;
    procedure GetStartupValues;
    procedure GetTemplateValues(const aLang : integer);
  public
    { Public declarations }
    hkCodeComp: TBricxCCHotKey;
    hkParamComp: TBricxCCHotKey;
    hkRecMacro: TBricxCCHotKey;
    hkPlayMacro: TBricxCCHotKey;
    edtNQCExePath: TDirectoryEdit;
    edtLCCExePath: TDirectoryEdit;
    edtNBCExePath: TDirectoryEdit;
    edtCygwin: TDirectoryEdit;
    edtJavaPath: TDirectoryEdit;
    edtLeJOSRoot: TDirectoryEdit;
    edtUserDataPath: TDirectoryEdit;
    edtSymLibPath: TDirectoryEdit;
    NewTemplatesList: TSynEdit;
    SynEditColors: TSynEdit;
//    property ColorsChanged : boolean read fColorsChanged;
    property Keystrokes : TSynEditKeyStrokes read fKeystrokes write SetKeystrokes;
    property CodeTemplates : TStrings read fCodeTemplates write SetCodeTemplates;
    property GUIPreferredLanguage : Integer read GetPrefLang write SetPrefLang;
  end;

var
  PrefForm: TPrefForm;
  AddMenuItemsToNewMenu : boolean = True;

procedure FillLockedProgramArray;

{Startup}
const
  K_MSTOSEC = 1000;
  K_DEFAULT_PING_TIMEOUT = 400;
  K_DEFAULT_TOWER_EXISTS_SLEEP = 30;

var
  MainWindowState : integer; // main form window state (normal, minimized, maximized)
  RunningAsCOMServer : Boolean = False;
  FBAlwaysPrompt : Boolean;
  StandardFirmwareDefault : Boolean;
  UseBluetoothDefault : Boolean;
  FirmwareTypeDefault : TFirmwareType;
  FirmwareFast : boolean;
  FirmwareComp : boolean;
  QuietFirmware : Boolean;
  FirmwareChunkSize : Integer;
  DownloadWaitTime : Integer;
  Prog1Locked : boolean;
  Prog2Locked : boolean;
  Prog3Locked : boolean;
  Prog4Locked : boolean;
  Prog5Locked : boolean;
  Prog6Locked : boolean;
  Prog7Locked : boolean;
  Prog8Locked : boolean;
  LockedProgArray : array[0..7] of Boolean;
  PingTimeout : Word = K_DEFAULT_PING_TIMEOUT;
  TowerExistsSleep : Word = K_DEFAULT_TOWER_EXISTS_SLEEP;

{General}
var
  SaveWindowPos:boolean;     // Whether to save window positions
  LockToolbars : Boolean;


procedure SaveDesktopMiscToFile(aFilename : string);
procedure LoadDesktopMiscFromFile(aFilename : string);
procedure SaveWindowValuesToFile(aFilename : string);
procedure LoadWindowValuesFromFile(aFilename : string);
procedure UpgradeRegistry(aPrefHLNXC, aMainHLNXC, aPrefHLNQC, aMainHLNQC : TSynBaseNCSyn);
procedure RegisterApp;
procedure SetToolbarDragging(bAuto : Boolean);
procedure RestoreToolbars;
procedure SaveToolbars;

procedure UpdateTransferList(aSrcList, aDestList : TList);
function GetUseMDIMode : Boolean;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

uses
{$IFNDEF FPC}
  Windows,
  SynEditKeyCmdsEditor,
  uForthConsole,
{$ENDIF}
  SysUtils, MainUnit, Diagnose, Controller, Watch, Piano, ConstructUnit,
  JoystickUnit, DatalogUnit, MemoryUnit, CodeUnit, Editor,
  MessageUnit, IniFiles, CodeTemplates,
  uVersionInfo, uHighlighterProcs, uExtensionDlg,
  uSetValues, uEEPROM, uNewWatch, Themes,
  uSpirit, brick_common, Transfer, uNXTExplorer, uNXTController,
  uNXTExplorerSettings, uLocalizedStrings, uGuiUtils, uEditorExperts,
  uEECommentConfig, uEEAlignConfig, uNBCInterface, uJoyGlobals,
  uRemoteGlobals, uRegUtils, uGlobals, uBasicPrefs, uEditorShortcut;


var
  cc_keywords: TStringList;
  cc_commands: TStringList;
  cc_constants: TStringList;

var
  StartupAction : Integer;     // Action to take at startup
  BrickType : Integer;           // RCX (0), Cybermaster (1), Scout (2), or RCX2 (3)
  COMPort : string;           // default COM port (''=automatic)
  UseMDIMode : Boolean;

const
  K_PID           = 'BricxCC.1';
  K_OLDMAINKEY    = '\Software\RcxCC';
  K_OLDVERSION    = 'version 3.2';
  K_WINDOWSECTION = 'BricxCC_Windows';
  K_MISCSECTION   = 'BricxCC_Misc';
  K_CYGWIN_DIR    = 'c:\cygwin';
  K_BRICKOS_ROOT  = '/brickos';
  K_BRICKOS_MAKE_TEMPLATE =
    'ROOT=%os_root%' + #13#10 +
    'KERNEL=$(ROOT)/boot/brickOS' + #13#10 +
    'PROGRAMS=%project%.lx' + #13#10 +
    'DOBJECTS=%project_files%' + #13#10 +
    #13#10 +
    'all:: $(DOBJECTS) $(PROGRAMS)' + #13#10 +
    #13#10 +
    'download:: all' + #13#10 +
    #9'$(ROOT)/util/dll %prog% %tty% %exec% %addr% $(PROGRAMS)' + #13#10 +
    #13#10 +
    'set_addr::' + #13#10 +
    #9'$(ROOT)/util/dll %tty% %addr% %set_addr%' + #13#10 +
    #13#10 +
    'include $(ROOT)/Makefile.common' + #13#10 +
    'include $(ROOT)/Makefile.user' + #13#10 +
    #13#10;
  K_LEJOS_ROOT  = '/lejos';
  K_LEJOS_MAKE_TEMPLATE =
    'ROOT=%os_root%' + #13#10 +
    'LEJOSC=$(ROOT)/bin/lejosc' + #13#10 +
    'LEJOS=$(ROOT)/bin/lejos' + #13#10 +
    'LEJOSRUN=$(ROOT)/bin/lejosrun' + #13#10 +
    'CLASSPATH=.' + #13#10 +
    'JAVAC=%jdk_dir%/bin/javac' + #13#10 +
    'DOBJECTS=%project_files%' + #13#10 +
    'PROGRAMS=%project%' + #13#10 +
    #13#10 +
    '.EXPORT_ALL_VARIABLES :' + #13#10 +
    #13#10 +
    'all:: $(DOBJECTS) $(PROGRAMS).bin' + #13#10 +
    #13#10 +
    'download:: all' + #13#10 +
    #9'$(LEJOSRUN) %tty% $(PROGRAMS).bin' + #13#10 +
    '' + #13#10 +
    '# how to compile Java source' + #13#10 +
    '%.class: %.java' + #13#10 +
    #9'$(LEJOSC) -target 1.1 $<' + #13#10 +
    #13#10 +
    '# how to link Java class files' + #13#10 +
    '%.bin: %.class $(DOBJECTS)' + #13#10 +
    #9'$(LEJOS) $* -o $@' + #13#10;
  K_MAX_OLD_PATHS = 4;

procedure SavePositions(R : TRegistry; aComp : TComponent);
var
  C : TControl;
  S : string;
  bVisible : boolean;
begin
  if aComp is TControl then begin
    C := TControl(aComp);
    S := C.Name;
    if C.Floating and Assigned(C.Parent) then begin
      R.WriteInteger(S + '_Left', C.Parent.Left);
      R.WriteInteger(S + '_Top', C.Parent.Top);
    end
    else begin
      R.WriteInteger(S + '_Left', C.Left);
      R.WriteInteger(S + '_Top', C.Top);
    end;
    R.WriteInteger(S + '_Width', C.Width);
    R.WriteInteger(S + '_Height', C.Height);
    R.WriteBool(S + '_Float', C.Floating);
    if Assigned(C.HostDockSite) then
      R.WriteString(S + '_HostDockSiteName', C.HostDockSite.Name)
    else
      R.WriteString(S + '_HostDockSiteName', 'cbrTop');
    if C.Floating then
      bVisible := C.HostDockSite.Visible
    else
      bVisible := C.Visible;
    R.WriteBool(S + '_Visible', bVisible);
  end;
end;

procedure LoadPositions(R : TRegistry; aComp : TComponent);
var
  M : TComponent;
  t, l, w, h : integer;
  C : TControl;
  S, dockName : string;
  bFloat, bVisible : boolean;
  P1, P2 : TPoint;
begin
  if not Assigned(aComp) then Exit;
  if aComp is TControl then begin
    C := TControl(aComp);
    S := C.Name;
    l := C.Left;
    t := C.Top;
    w := C.Width;
    h := C.Height;
    bFloat := False;
    bVisible := True;
    if R.ValueExists(S + '_Float') then begin
      bFloat := R.ReadBool(S + '_Float');
    end;
    if R.ValueExists(S + '_Visible') then begin
      bVisible := R.ReadBool(S + '_Visible');
    end;
    if R.ValueExists(S + '_HostDockSiteName') then begin
      dockName := R.ReadString(S + '_HostDockSiteName');
    end;
    if R.ValueExists(S + '_Left') then begin
      l := R.ReadInteger(S + '_Left');
    end;
    if R.ValueExists(S + '_Top') then begin
      t := R.ReadInteger(S + '_Top');
    end;
    if R.ValueExists(S + '_Width') then begin
      w := R.ReadInteger(S + '_Width');
    end;
    if R.ValueExists(S + '_Height') then begin
      h := R.ReadInteger(S + '_Height');
    end;
    if bFloat then begin
      P1 := Point(l, t);
      P2 := Point(l+w, t+h);
      C.ManualFloat(Rect(P1.x, P1.y, P2.x, P2.y));
      C.HostDockSite.Visible := bVisible;
    end
    else begin
      if dockName <> '' then begin
        M := MainForm.FindComponent(dockName);
        if Assigned(M) and (M is TWinControl) then begin
          C.ManualDock(TWinControl(M));
          C.Visible := bVisible;
        end;
      end;
      C.Left   := l;
      C.Top    := t;
      C.Width  := w;
      C.Height := h;
    end;
  end;
end;

procedure SetToolbarDragging(bAuto : Boolean);
const
  DM : array[Boolean] of TDragMode = (dmManual, dmAutomatic);
begin
{$IFNDEF FPC}
  with MainForm do begin
    cbrTop.AutoDrag    := bAuto;
    // set the toolbar dragmode also
    ogpHelp.DragMode    := DM[bAuto];
    ogpCompile.DragMode := DM[bAuto];
    ogpSearch.DragMode  := DM[bAuto];
    ogpTools.DragMode   := DM[bAuto];
    ogpFile.DragMode    := DM[bAuto];
    ogpEdit.DragMode    := DM[bAuto];
  end;
{$ENDIF}
end;

procedure RestoreToolbars;
var
  R : TRegistry;
begin
  SetToolbarDragging(not LockToolbars);
  if LockToolbars then Exit; // do not restore toolbars
  R := TRegistry.Create;
  try
    R.RootKey := HKEY_CURRENT_USER;
    if R.OpenKey(fMainKey+'\'+fVersion+'\Toolbars', false) then begin
      LoadPositions(R, MainForm.ogpFile);
      LoadPositions(R, MainForm.ogpSearch);
      LoadPositions(R, MainForm.ogpCompile);
      LoadPositions(R, MainForm.ogpHelp);
      LoadPositions(R, MainForm.ogpEdit);
      LoadPositions(R, MainForm.ogpTools);
    end;
  finally
    R.Free;
  end;
end;

procedure SaveToolbars;
var
  R : TRegistry;
  keyName : string;
begin
  R := TRegistry.Create;
  try
    R.RootKey := HKEY_CURRENT_USER;
    keyName := fMainKey+'\'+fVersion+'\Toolbars';
    if LockToolbars then begin
      if R.KeyExists(keyName) then
        R.DeleteKey(keyName);
    end
    else begin
      if R.OpenKey(keyName, true) then
      begin
        SavePositions(R, MainForm.ogpFile);
        SavePositions(R, MainForm.ogpSearch);
        SavePositions(R, MainForm.ogpCompile);
        SavePositions(R, MainForm.ogpHelp);
        SavePositions(R, MainForm.ogpEdit);
        SavePositions(R, MainForm.ogpTools);
      end;
    end;
  finally
    R.Free;
  end;
end;

procedure FillLockedProgramArray;
begin
  LockedProgArray[0] := Prog1Locked;
  LockedProgArray[1] := Prog2Locked;
  LockedProgArray[2] := Prog3Locked;
  LockedProgArray[3] := Prog4Locked;
  LockedProgArray[4] := Prog5Locked;
  LockedProgArray[5] := Prog6Locked;
  LockedProgArray[6] := Prog7Locked;
  LockedProgArray[7] := Prog8Locked;
end;

procedure SaveDesktopMiscToFile(aFilename : string);
var
  theFile : TMemIniFile;
begin
  theFile := TMemIniFile.Create(aFilename);
  try
    theFile.WriteString(K_MISCSECTION, 'Port', LocalPort);
    theFile.WriteInteger(K_MISCSECTION, 'BrickType', LocalBrickType);
    theFile.WriteInteger(K_MISCSECTION, 'SlotNum', CurrentProgramSlot);
    theFile.WriteInteger(K_MISCSECTION, 'Firmware', Ord(LocalFirmwareType));
    theFile.WriteBool(K_MISCSECTION, 'UseBluetooth', LocalUseBluetooth);
    theFile.UpdateFile;
  finally
    theFile.Free;
  end;
end;

procedure LoadDesktopMiscFromFile(aFilename : string);
var
  theFile : TMemIniFile;
begin
  theFile := TMemIniFile.Create(aFilename);
  try
    LocalPort      := theFile.ReadString(K_MISCSECTION, 'Port', LocalPort);
    LocalBrickType := theFile.ReadInteger(K_MISCSECTION, 'BrickType', LocalBrickType);
    CurrentProgramSlot := theFile.ReadInteger(K_MISCSECTION, 'SlotNum', CurrentProgramSlot);
    LocalFirmwareType  := TFirmwareType(theFile.ReadInteger(K_MISCSECTION, 'Firmware', Ord(LocalFirmwareType)));
    LocalStandardFirmware := LocalFirmwareType = ftStandard;
    LocalUseBluetooth  := theFile.ReadBool(K_MISCSECTION, 'UseBluetooth', LocalUseBluetooth);
  finally
    theFile.Free;
  end;
end;

procedure SaveWindowValuesToFile(aFilename : string);
var
  theFile : TMemIniFile;
begin
  theFile := TMemIniFile.Create(aFilename);
  try
    theFile.WriteInteger(K_WINDOWSECTION, 'XMainWindow', MainForm.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YMainWindow', MainForm.Top);
    theFile.WriteInteger(K_WINDOWSECTION, 'WMainWindow', MainForm.Width);
    theFile.WriteInteger(K_WINDOWSECTION, 'HMainWindow', MainForm.Height);
    theFile.WriteInteger(K_WINDOWSECTION, 'CodeExplorerWidth', MainForm.pnlCodeExplorer.Width);
    theFile.WriteInteger(K_WINDOWSECTION, 'XDiagWindow', DiagForm.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YDiagWindow', DiagForm.Top);
    theFile.WriteInteger(K_WINDOWSECTION, 'XDirectWindow', DirectForm.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YDirectWindow', DirectForm.Top);
    theFile.WriteInteger(K_WINDOWSECTION, 'XWatchWindow', WatchForm.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YWatchWindow', WatchForm.Top);
    theFile.WriteInteger(K_WINDOWSECTION, 'XPianoWindow', PianoForm.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YPianoWindow', PianoForm.Top);
    theFile.WriteInteger(K_WINDOWSECTION, 'XTemplateWindow', ConstructForm.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YTemplateWindow', ConstructForm.Top);
    theFile.WriteInteger(K_WINDOWSECTION, 'WTemplateWindow', ConstructForm.Width);
    theFile.WriteInteger(K_WINDOWSECTION, 'HTemplateWindow', ConstructForm.Height);
    theFile.WriteInteger(K_WINDOWSECTION, 'XJoystickWindow', JoystickForm.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YJoystickWindow', JoystickForm.Top);
    theFile.WriteInteger(K_WINDOWSECTION, 'XDatalogWindow', DatalogForm.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YDatalogWindow', DatalogForm.Top);
    theFile.WriteInteger(K_WINDOWSECTION, 'XMemoryWindow', MemoryForm.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YMemoryWindow', MemoryForm.Top);
    theFile.WriteInteger(K_WINDOWSECTION, 'XCodeWindow', CodeForm.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YCodeWindow', CodeForm.Top);
    theFile.WriteInteger(K_WINDOWSECTION, 'WCodeWindow', CodeForm.Width);
    theFile.WriteInteger(K_WINDOWSECTION, 'HCodeWindow', CodeForm.Height);
    theFile.WriteInteger(K_WINDOWSECTION, 'XMessageWindow', MessageForm.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YMessageWindow', MessageForm.Top);
    theFile.WriteInteger(K_WINDOWSECTION, 'XSetValuesWindow', frmSetValues.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YSetValuesWindow', frmSetValues.Top);
    theFile.WriteInteger(K_WINDOWSECTION, 'XEEPROMWindow', frmSpybotEEPROM.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YEEPROMWindow', frmSpybotEEPROM.Top);
    theFile.WriteInteger(K_WINDOWSECTION, 'XNewWatchWindow', frmNewWatch.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YNewWatchWindow', frmNewWatch.Top);
{$IFNDEF FPC}
    theFile.WriteInteger(K_WINDOWSECTION, 'XForthConsoleWindow', frmForthConsole.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YForthConsoleWindow', frmForthConsole.Top);
{$ENDIF}
    theFile.WriteInteger(K_WINDOWSECTION, 'XNXTExplorerWindow', frmNXTExplorer.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YNXTExplorerWindow', frmNXTExplorer.Top);
    theFile.WriteInteger(K_WINDOWSECTION, 'WNXTExplorerWindow', frmNXTExplorer.Width);
    theFile.WriteInteger(K_WINDOWSECTION, 'HNXTExplorerWindow', frmNXTExplorer.Height);
    theFile.WriteInteger(K_WINDOWSECTION, 'XNXTControllerWindow', frmNXTController.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YNXTControllerWindow', frmNXTController.Top);
    theFile.UpdateFile;
  finally
    theFile.Free;
  end;
end;

procedure LoadWindowValuesFromFile(aFilename : string);
var
  theFile : TMemIniFile;
begin
  theFile := TMemIniFile.Create(aFilename);
  try
    MainForm.Left        := theFile.ReadInteger(K_WINDOWSECTION, 'XMainWindow', MainForm.Left);
    MainForm.Top         := theFile.ReadInteger(K_WINDOWSECTION, 'YMainWindow', MainForm.Top);
    MainForm.Width       := theFile.ReadInteger(K_WINDOWSECTION, 'WMainWindow', MainForm.Width);
    MainForm.Height      := theFile.ReadInteger(K_WINDOWSECTION, 'HMainWindow', MainForm.Height);
    MainForm.pnlCodeExplorer.Width := theFile.ReadInteger(K_WINDOWSECTION, 'CodeExplorerWidth', MainForm.pnlCodeExplorer.Width);
    DiagForm.Left        := theFile.ReadInteger(K_WINDOWSECTION, 'XDiagWindow', DiagForm.Left);
    DiagForm.Top         := theFile.ReadInteger(K_WINDOWSECTION, 'YDiagWindow', DiagForm.Top);
    DirectForm.Left      := theFile.ReadInteger(K_WINDOWSECTION, 'XDirectWindow', DirectForm.Left);
    DirectForm.Top       := theFile.ReadInteger(K_WINDOWSECTION, 'YDirectWindow', DirectForm.Top);
    WatchForm.Left       := theFile.ReadInteger(K_WINDOWSECTION, 'XWatchWindow', WatchForm.Left);
    WatchForm.Top        := theFile.ReadInteger(K_WINDOWSECTION, 'YWatchWindow', WatchForm.Top);
    PianoForm.Left       := theFile.ReadInteger(K_WINDOWSECTION, 'XPianoWindow', PianoForm.Left);
    PianoForm.Top        := theFile.ReadInteger(K_WINDOWSECTION, 'YPianoWindow', PianoForm.Top);
    ConstructForm.Left   := theFile.ReadInteger(K_WINDOWSECTION, 'XTemplateWindow', ConstructForm.Left);
    ConstructForm.Top    := theFile.ReadInteger(K_WINDOWSECTION, 'YTemplateWindow', ConstructForm.Top);
    ConstructForm.Width  := theFile.ReadInteger(K_WINDOWSECTION, 'WTemplateWindow', ConstructForm.Width);
    ConstructForm.Height := theFile.ReadInteger(K_WINDOWSECTION, 'HTemplateWindow', ConstructForm.Height);
    JoystickForm.Left    := theFile.ReadInteger(K_WINDOWSECTION, 'XJoystickWindow', JoystickForm.Left);
    JoystickForm.Top     := theFile.ReadInteger(K_WINDOWSECTION, 'YJoystickWindow', JoystickForm.Top);
    DatalogForm.Left     := theFile.ReadInteger(K_WINDOWSECTION, 'XDatalogWindow', DatalogForm.Left);
    DatalogForm.Top      := theFile.ReadInteger(K_WINDOWSECTION, 'YDatalogWindow', DatalogForm.Top);
    MemoryForm.Left      := theFile.ReadInteger(K_WINDOWSECTION, 'XMemoryWindow', MemoryForm.Left);
    MemoryForm.Top       := theFile.ReadInteger(K_WINDOWSECTION, 'YMemoryWindow', MemoryForm.Top);
    CodeForm.Left        := theFile.ReadInteger(K_WINDOWSECTION, 'XCodeWindow', CodeForm.Left);
    CodeForm.Top         := theFile.ReadInteger(K_WINDOWSECTION, 'YCodeWindow', CodeForm.Top);
    CodeForm.Width       := theFile.ReadInteger(K_WINDOWSECTION, 'WCodeWindow', CodeForm.Width);
    CodeForm.Height      := theFile.ReadInteger(K_WINDOWSECTION, 'HCodeWindow', CodeForm.Height);
    MessageForm.Left     := theFile.ReadInteger(K_WINDOWSECTION, 'XMessageWindow', MessageForm.Left);
    MessageForm.Top      := theFile.ReadInteger(K_WINDOWSECTION, 'YMessageWindow', MessageForm.Top);
    frmSetValues.Left    := theFile.ReadInteger(K_WINDOWSECTION, 'XSetValuesWindow', frmSetValues.Left);
    frmSetValues.Top     := theFile.ReadInteger(K_WINDOWSECTION, 'YSetValuesWindow', frmSetValues.Top);
    frmSpybotEEPROM.Left := theFile.ReadInteger(K_WINDOWSECTION, 'XEEPROMWindow', frmSpybotEEPROM.Left);
    frmSpybotEEPROM.Top  := theFile.ReadInteger(K_WINDOWSECTION, 'YEEPROMWindow', frmSpybotEEPROM.Top);
    frmNewWatch.Left     := theFile.ReadInteger(K_WINDOWSECTION, 'XNewWatchWindow', frmNewWatch.Left);
    frmNewWatch.Top      := theFile.ReadInteger(K_WINDOWSECTION, 'YNewWatchWindow', frmNewWatch.Top);
{$IFNDEF FPC}
    frmForthConsole.Left := theFile.ReadInteger(K_WINDOWSECTION, 'XForthConsoleWindow', frmForthConsole.Left);
    frmForthConsole.Top  := theFile.ReadInteger(K_WINDOWSECTION, 'YForthConsoleWindow', frmForthConsole.Top);
{$ENDIF}
    frmNXTExplorer.Left  := theFile.ReadInteger(K_WINDOWSECTION, 'XNXTExplorerWindow', frmNXTExplorer.Left);
    frmNXTExplorer.Top   := theFile.ReadInteger(K_WINDOWSECTION, 'YNXTExplorerWindow', frmNXTExplorer.Top);
    frmNXTExplorer.Width := theFile.ReadInteger(K_WINDOWSECTION, 'WNXTExplorerWindow', frmNXTExplorer.Width);
    frmNXTExplorer.Height := theFile.ReadInteger(K_WINDOWSECTION, 'HNXTExplorerWindow', frmNXTExplorer.Height);
    frmNXTController.Left := theFile.ReadInteger(K_WINDOWSECTION, 'XNXTControllerWindow', frmNXTController.Left);
    frmNXTController.Top  := theFile.ReadInteger(K_WINDOWSECTION, 'YNXTControllerWindow', frmNXTController.Top);
  finally
    theFile.Free;
  end;
end;

{**************************************************
  Reading and writing the registry
 **************************************************}

{Macros}

{Loads the macro values from the registry}
procedure LoadMacroValues(reg : TRegistry);
var
  i:integer;
  SL : TStringList;
  tmpPath : string;
begin
  if not Reg_KeyExists(reg, 'Macros') then
  begin
    tmpPath := ProgramDir+IncludeTrailingPathDelimiter('Default')+'macros.txt';
    if FileExists(tmpPath) then
    begin
      SL := TStringList.Create;
      try
        SL.LoadFromFile(tmpPath);
        macronumb := SL.Count;
        for i := 0 to SL.Count - 1 do
        begin
          macros[i+1] := SL[i];
        end;
      finally
        SL.Free;
      end;
    end;
  end
  else
  begin
    Reg_OpenKey(reg, 'Macros');
    i:=1;
    while reg.ValueExists('Macro'+BricxCCIntToStr(i)) do
    begin
      macros[i] := Reg_ReadString(reg, 'Macro'+BricxCCIntToStr(i),'');
      i := i+1;
    end;
    macronumb := i-1;
    reg.CloseKey;
  end;
end;

procedure SaveMacroValues(reg : TRegistry);
{Saves the macro values to the registry}
var i:integer;
begin
  Reg_DeleteKey(reg, 'Macros');
  Reg_OpenKey(reg, 'Macros');
  for i:=1 to macronumb do
    reg.WriteString('Macro'+BricxCCIntToStr(i),macros[i]);
  reg.CloseKey;
end;

procedure ResetMacroValues(reg : TRegistry);
{Resets the macro values to default}
begin
  Reg_DeleteKey(reg, 'Macros');
  LoadMacroValues(reg);
end;

{Keywords for Colorcoding}

procedure LoadNQCAPIValues(reg : TRegistry; aPrefHL, aMainHL : TSynBaseNCSyn);
var
  i:integer;
begin
  {first we populate our dynamic arrays from the highlighter if it exists}
  if Assigned(aPrefHL) then
  begin
    cc_keywords.Assign(aPrefHL.KeyWords);
    cc_commands.Assign(aPrefHL.Commands);
    cc_constants.Assign(aPrefHL.Constants);
  end;
  {Loads the keyword values from the registry}
  if not Reg_KeyExists(reg, 'Keywords') then
  begin
    // no registry key so load from file instead
    if FileExists(ProgramDir+'Default\keywords.txt') then
      cc_keywords.LoadFromFile(ProgramDir+'Default\keywords.txt');
    if FileExists(ProgramDir+'Default\commands.txt') then
      cc_commands.LoadFromFile(ProgramDir+'Default\commands.txt');
    if FileExists(ProgramDir+'Default\constants.txt') then
      cc_constants.LoadFromFile(ProgramDir+'Default\constants.txt');
  end
  else
  begin
    Reg_OpenKey(reg, 'Keywords');
    try
      i:=1;
      if reg.ValueExists('Keyword'+BricxCCIntToStr(i)) then
      begin
        // old style
        cc_keywords.Clear;
        while reg.ValueExists('Keyword'+BricxCCIntToStr(i)) do
        begin
          cc_keywords.Add(Reg_ReadString(reg, 'Keyword'+BricxCCIntToStr(i),''));
          reg.DeleteValue('Keyword'+BricxCCIntToStr(i));
          i := i+1;
        end;
      end
      else
      begin
        // new style
        cc_keywords.Text := Reg_ReadString(reg, 'Keywords', '');
      end;
    finally
      reg.CloseKey;
    end;

    Reg_OpenKey(reg, 'Commands');
    try
      i:=1;
      if reg.ValueExists('Command'+BricxCCIntToStr(i)) then
      begin
        // old style
        cc_commands.Clear;
        while reg.ValueExists('Command'+BricxCCIntToStr(i)) do
        begin
          cc_commands.Add(Reg_ReadString(reg, 'Command'+BricxCCIntToStr(i),''));
          reg.DeleteValue('Command'+BricxCCIntToStr(i));
          i := i+1;
        end;
      end
      else
      begin
        // new style
        cc_commands.Text := Reg_ReadString(reg, 'Commands', '');
      end;
    finally
      reg.CloseKey;
    end;

    Reg_OpenKey(reg, 'Constants');
    try
      i:=1;
      if reg.ValueExists('Constant'+BricxCCIntToStr(i)) then
      begin
        // old style
        cc_constants.Clear;
        while reg.ValueExists('Constant'+BricxCCIntToStr(i)) do
        begin
          cc_constants.Add(Reg_ReadString(reg, 'Constant'+BricxCCIntToStr(i),''));
          reg.DeleteValue('Constant'+BricxCCIntToStr(i));
          i := i+1;
        end;
      end
      else
      begin
        // new style
        cc_constants.Text := Reg_ReadString(reg, 'Constants', '');
      end;
    finally
      reg.CloseKey;
    end;
  end;
  PutAPIValuesInSyntaxHighlighter(cc_keywords, cc_commands, cc_constants, aPrefHL, aMainHL);
end;

procedure SaveNQCAPIValues(reg : TRegistry);
begin
  {Saves the keyword values to the registry}
  // NQC
  Reg_DeleteKey(reg, 'Keywords');
  Reg_OpenKey(reg, 'Keywords');
  try
    reg.WriteString('Keywords',cc_keywords.Text);
  finally
    reg.CloseKey;
  end;

  Reg_DeleteKey(reg, 'Commands');
  Reg_OpenKey(reg, 'Commands');
  try
    reg.WriteString('Commands',cc_commands.Text);
  finally
    reg.CloseKey;
  end;

  Reg_DeleteKey(reg, 'Constants');
  Reg_OpenKey(reg, 'Constants');
  try
    reg.WriteString('Constants',cc_constants.Text);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetNQCAPIValues(reg : TRegistry; aPrefHL, aMainHL : TSynBaseNCSyn);
begin
{Resets the keyword values to default}
  Reg_DeleteKey(reg, 'Keywords');
  Reg_DeleteKey(reg, 'Commands');
  Reg_DeleteKey(reg, 'Constants');
  LoadNQCAPIValues(reg, aPrefHL, aMainHL);
end;

procedure LoadWindowsValues(reg : TRegistry);
begin
  {Loads the windows values from the registry}
  if not SaveWindowPos then Exit;
  Reg_OpenKey(reg, 'Windows');
  try
    MainWindowState      := Reg_ReadInteger(reg, 'WSMainWindow', Integer(wsNormal));
    MainForm.Left        := Reg_ReadInteger(reg, 'XMainWindow', 100);
    MainForm.Top         := Reg_ReadInteger(reg, 'YMainWindow', 10);
    MainForm.Width       := Reg_ReadInteger(reg, 'WMainWindow', 600);
    MainForm.Height      := Reg_ReadInteger(reg, 'HMainWindow', 450);
    MainForm.pnlCodeExplorer.Width := Reg_ReadInteger(reg, 'CodeExplorerWidth', 105);
    DiagForm.Left        := Reg_ReadInteger(reg, 'XDiagWindow', 30);
    DiagForm.Top         := Reg_ReadInteger(reg, 'YDiagWindow', 30);
    DirectForm.Left      := Reg_ReadInteger(reg, 'XDirectWindow', 50);
    DirectForm.Top       := Reg_ReadInteger(reg, 'YDirectWindow', 50);
    WatchForm.Left       := Reg_ReadInteger(reg, 'XWatchWindow', 70);
    WatchForm.Top        := Reg_ReadInteger(reg, 'YWatchWindow', 70);
    PianoForm.Left       := Reg_ReadInteger(reg, 'XPianoWindow', 90);
    PianoForm.Top        := Reg_ReadInteger(reg, 'YPianoWindow', 90);
    ConstructForm.Left   := Reg_ReadInteger(reg, 'XTemplateWindow', 10);
    ConstructForm.Top    := Reg_ReadInteger(reg, 'YTemplateWindow', 10);
    ConstructForm.Width  := Reg_ReadInteger(reg, 'WTemplateWindow', 148);
    ConstructForm.Height := Reg_ReadInteger(reg, 'HTemplateWindow', 250);
    ConstructForm.DockMe := Reg_ReadBool(reg, 'TemplateWindowDocked', False);
    JoystickForm.Left    := Reg_ReadInteger(reg, 'XJoystickWindow', 100);
    JoystickForm.Top     := Reg_ReadInteger(reg, 'YJoyStickWindow', 100);
    DatalogForm.Left     := Reg_ReadInteger(reg, 'XDatalogWindow', 110);
    DatalogForm.Top      := Reg_ReadInteger(reg, 'YDatalogWindow', 110);
    MemoryForm.Left      := Reg_ReadInteger(reg, 'XMemoryWindow', 130);
    MemoryForm.Top       := Reg_ReadInteger(reg, 'YMemoryWindow', 130);
    CodeForm.Left        := Reg_ReadInteger(reg, 'XCodeWindow', 140);
    CodeForm.Top         := Reg_ReadInteger(reg, 'YCodeWindow', 140);
    CodeForm.Width       := Reg_ReadInteger(reg, 'WCodeWindow', 500);
    CodeForm.Height      := Reg_ReadInteger(reg, 'HCodeWindow', 340);
    MessageForm.Left     := Reg_ReadInteger(reg, 'XMessageWindow', 150);
    MessageForm.Top      := Reg_ReadInteger(reg, 'YMessageWindow', 150);
    frmSetValues.Left    := Reg_ReadInteger(reg, 'XSetValuesWindow', 160);
    frmSetValues.Top     := Reg_ReadInteger(reg, 'YSetValuesWindow', 160);
    frmSpybotEEPROM.Left := Reg_ReadInteger(reg, 'XEEPROMWindow', 170);
    frmSpybotEEPROM.Top  := Reg_ReadInteger(reg, 'YEEPROMWindow', 170);
    frmNewWatch.Left     := Reg_ReadInteger(reg, 'XNewWatchWindow', 180);
    frmNewWatch.Top      := Reg_ReadInteger(reg, 'YNewWatchWindow', 180);
{$IFNDEF FPC}
    frmForthConsole.Left := Reg_ReadInteger(reg, 'XForthConsoleWindow', 190);
    frmForthConsole.Top  := Reg_ReadInteger(reg, 'YForthConsoleWindow', 190);
{$ENDIF}
    frmNXTExplorer.Left  := Reg_ReadInteger(reg, 'XNXTExplorerWindow', 190);
    frmNXTExplorer.Top   := Reg_ReadInteger(reg, 'YNXTExplorerWindow', 190);
    frmNXTExplorer.Width := Reg_ReadInteger(reg, 'WNXTExplorerWindow', 580);
    frmNXTExplorer.Height := Reg_ReadInteger(reg, 'HNXTExplorerWindow', 480);
    frmNXTController.Left := Reg_ReadInteger(reg, 'XNXTControllerWindow', 190);
    frmNXTController.Top  := Reg_ReadInteger(reg, 'YNXTControllerWindow', 190);
    if Assigned(PrefForm) then
    begin
      PrefForm.Left      := Reg_ReadInteger(reg, 'XPrefWindow', 90);
      PrefForm.Top       := Reg_ReadInteger(reg, 'YPrefWindow', 90);
    end;
  finally
    reg.CloseKey;
  end;
end;

procedure SaveWindowsValues(reg : TRegistry);
var
  w : Integer;
begin
  {Saves the windows values in the registry}
  if not SaveWindowPos then Exit;
  Reg_DeleteKey(reg, 'Windows');
  Reg_OpenKey(reg, 'Windows');
  try
    reg.WriteInteger('WSMainWindow', MainWindowState);
    reg.WriteInteger('XMainWindow', MainForm.Left);
    reg.WriteInteger('YMainWindow', MainForm.Top);
    reg.WriteInteger('WMainWindow', MainForm.Width);
    reg.WriteInteger('HMainWindow', MainForm.Height);
    w := MainForm.pnlCodeExplorer.Width;
    if w = 0 then w := 105;
    reg.WriteInteger('CodeExplorerWidth', w);
    reg.WriteInteger('XDiagWindow', DiagForm.Left);
    reg.WriteInteger('YDiagWindow', DiagForm.Top);
    reg.WriteInteger('XDirectWindow', DirectForm.Left);
    reg.WriteInteger('YDirectWindow', DirectForm.Top);
    reg.WriteInteger('XWatchWindow', WatchForm.Left);
    reg.WriteInteger('YWatchWindow', WatchForm.Top);
    reg.WriteInteger('XPianoWindow', PianoForm.Left);
    reg.WriteInteger('YPianoWindow', PianoForm.Top);
    reg.WriteInteger('XTemplateWindow', ConstructForm.Left);
    reg.WriteInteger('YTemplateWindow', ConstructForm.Top);
    reg.WriteInteger('WTemplateWindow', ConstructForm.Width);
    reg.WriteInteger('HTemplateWindow', ConstructForm.Height);
    reg.WriteBool('TemplateWindowDocked', ConstructForm.Parent <> nil);
    reg.WriteInteger('XJoystickWindow', JoystickForm.Left);
    reg.WriteInteger('YJoystickWindow', JoystickForm.Top);
    reg.WriteInteger('XDatalogWindow', DatalogForm.Left);
    reg.WriteInteger('YDatalogWindow', DatalogForm.Top);
    reg.WriteInteger('XMemoryWindow', MemoryForm.Left);
    reg.WriteInteger('YMemoryWindow', MemoryForm.Top);
    reg.WriteInteger('XCodeWindow', CodeForm.Left);
    reg.WriteInteger('YCodeWindow', CodeForm.Top);
    reg.WriteInteger('WCodeWindow', CodeForm.Width);
    reg.WriteInteger('HCodeWindow', CodeForm.Height);
    reg.WriteInteger('XMessageWindow', MessageForm.Left);
    reg.WriteInteger('YMessageWindow', MessageForm.Top);
    reg.WriteInteger('XSetValuesWindow', frmSetValues.Left);
    reg.WriteInteger('YSetValuesWindow', frmSetValues.Top);
    reg.WriteInteger('XEEPROMWindow', frmSpybotEEPROM.Left);
    reg.WriteInteger('YEEPROMWindow', frmSpybotEEPROM.Top);
    reg.WriteInteger('XNewWatchWindow', frmNewWatch.Left);
    reg.WriteInteger('YNewWatchWindow', frmNewWatch.Top);
{$IFNDEF FPC}
    reg.WriteInteger('XForthConsoleWindow', frmForthConsole.Left);
    reg.WriteInteger('YForthConsoleWindow', frmForthConsole.Top);
{$ENDIF}
    reg.WriteInteger('XNXTExplorerWindow', frmNXTExplorer.Left);
    reg.WriteInteger('YNXTExplorerWindow', frmNXTExplorer.Top);
    reg.WriteInteger('WNXTExplorerWindow', frmNXTExplorer.Width);
    reg.WriteInteger('HNXTExplorerWindow', frmNXTExplorer.Height);
    reg.WriteInteger('XNXTControllerWindow', frmNXTController.Left);
    reg.WriteInteger('YNXTControllerWindow', frmNXTController.Top);
    if Assigned(PrefForm) then
    begin
      reg.WriteInteger('XPrefWindow', PrefForm.Left);
      reg.WriteInteger('YPrefWindow', PrefForm.Top);
    end;
  finally
    reg.CloseKey;
  end;
end;

procedure ResetWindowsValues(reg : TRegistry);
begin
  {Resets the windows values to default}
  Reg_DeleteKey(reg, 'Windows');
  LoadWindowsValues(reg);
end;

procedure LoadColorValues(reg : TRegistry);
var
  j, i : Integer;
  SCH : TSynCustomHighlighter;
  A : TSynHighlighterAttributes;
begin
  if not Assigned(PrefForm) then Exit;
  // load color and style values into global syntax highlighters
  for j := 0 to Highlighters.Count - 1 do
  begin
    SCH := TSynCustomHighlighter(Highlighters.Objects[j]);
    if Assigned(SCH) then
      Reg_OpenKey(reg, SCH.LanguageName + 'Colors');
      try
        for i := 0 to SCH.AttrCount - 1 do
        begin
          A := SCH.Attribute[i];
          if Assigned(A) then
          begin
            A.Background := Reg_ReadColor(reg, A.Name + 'BGColor', PrefForm.fDefBGColors[j][i]);
            A.Foreground := Reg_ReadColor(reg, A.Name + 'FGColor', PrefForm.fDefFGColors[j][i]);
            A.Style      := Reg_ReadStyle(reg, A.Name + 'Style', PrefForm.fDefStyles[j][i]);
          end;
        end;
      finally
        reg.CloseKey;
      end;
  end;
end;

procedure DeleteAllColorKeys(reg : TRegistry);
var
  j : Integer;
  SCH : TSynCustomHighlighter;
begin
  for j := 0 to Highlighters.Count - 1 do
  begin
    SCH := TSynCustomHighlighter(Highlighters.Objects[j]);
    Reg_DeleteKey(reg, SCH.LanguageName + 'Colors');
  end;
end;

procedure SaveColorValues(reg : TRegistry);
var
  j, i : Integer;
  SCH : TSynCustomHighlighter;
  A : TSynHighlighterAttributes;
begin
  {Saves the color values in the registry}
  DeleteAllColorKeys(reg);
  for j := 0 to Highlighters.Count - 1 do
  begin
    SCH := TSynCustomHighlighter(Highlighters.Objects[j]);
    Reg_OpenKey(reg, SCH.LanguageName + 'Colors');
    try
      for i := 0 to SCH.AttrCount - 1 do
      begin
        A := SCH.Attribute[i];
        Reg_WriteColor(reg, A.Name + 'BGColor', A.Background);
        Reg_WriteColor(reg, A.Name + 'FGColor', A.Foreground);
        Reg_WriteStyle(reg, A.Name + 'Style', A.Style);
      end;
    finally
      reg.CloseKey;
    end;
  end;
end;

procedure ResetColorValues(reg : TRegistry);
begin
  {Resets the color values to default}
  DeleteAllColorKeys(reg);
  LoadColorValues(reg);
end;

procedure LoadStartupValues(reg : TRegistry);
begin
  {Loads the startup values from the registry}
  Reg_OpenKey(reg, 'Startup');
  try
    StartupAction := Reg_ReadInteger(reg, 'StartupAction', SU_SHOWFORM);
    // initialize the "this instance" startup action
    LocalStartupAction := StartupAction;

    BrickType := Reg_ReadInteger(reg, 'BrickType', SU_RCX);
    // initialize the "this instance" BrickType to be the default BrickType
    LocalBrickType := BrickType;

    COMPort := Reg_ReadString(reg, 'COMPortName', '');
    // initialize the "this instance" COMPort to be the default COMPort
    if COMPort = '' then
      LocalPort := 'COM1'
    else
      LocalPort := COMPort;

    FBAlwaysPrompt := Reg_ReadBool(reg, 'FBAlwaysPrompt', True);
    UseBluetoothDefault := Reg_ReadBool(reg, 'UseBluetooth', False);
    LocalUseBluetooth   := UseBluetoothDefault;

    StandardFirmwareDefault := Reg_ReadBool(reg, 'StandardFirmwareDefault', True);
    LocalStandardFirmware   := StandardFirmwareDefault;
    FirmwareTypeDefault := TFirmwareType(Reg_ReadInteger(reg, 'FirmwareTypeDefault', Ord(ftStandard)));
    LocalFirmwareType   := FirmwareTypeDefault;
  finally
    reg.CloseKey;
  end;
end;

procedure SaveStartupValues(reg : TRegistry);
begin
  {Saves the startup values from the registry}
  Reg_DeleteKey(reg, 'Startup');
  Reg_OpenKey(reg, 'Startup');
  try
    reg.WriteInteger('StartupAction',StartupAction);
    reg.WriteInteger('BrickType',BrickType);
    reg.WriteString('COMPortName',COMPort);
    reg.WriteBool('FBAlwaysPrompt', FBAlwaysPrompt);
    reg.WriteBool('StandardFirmwareDefault', StandardFirmwareDefault);
    reg.WriteBool('UseBluetooth', UseBluetoothDefault);
    reg.WriteInteger('FirmwareTypeDefault', Ord(FirmwareTypeDefault));
  finally
    reg.CloseKey;
  end;
end;

procedure ResetStartupValues(reg : TRegistry);
begin
  {Resets the startup values to default}
  Reg_DeleteKey(reg, 'Startup');
  LoadStartupValues(reg);
end;

procedure LoadExtraGeneralValues(reg : TRegistry);
begin
  {Loads the general values from the registry}
  Reg_OpenKey(reg, 'ExtraGeneral');
  try
    SaveWindowPos      := Reg_ReadBool(reg, 'SaveWindowPos',True);
    AutoSaveDesktop    := Reg_ReadBool(reg, 'AutoSaveDesktop', False);
    LockToolbars       := Reg_ReadBool(reg, 'LockToolbars', True);
    MaxEditWindows     := Reg_ReadBool(reg, 'MaxEditWindows', False);
    MultiFormatCopy    := Reg_ReadBool(reg, 'MultiFormatCopy', False);
    UseMDIMode         := Reg_ReadBool(reg, 'UseMDIMode', True);
    QuietFirmware      := Reg_ReadBool(reg, 'QuietFirmware', False);
    FirmwareFast       := Reg_ReadBool(reg, 'FirmwareFast', False);
    FirmwareComp       := Reg_ReadBool(reg, 'FirmwareComp', False);
    FirmwareChunkSize  := Reg_ReadInteger(reg, 'FirmwareChunkSize', 200);
    DownloadWaitTime   := Reg_ReadInteger(reg, 'DownloadWaitTime', 100);

    Prog1Locked        := Reg_ReadBool(reg, 'Prog1Locked', False);
    Prog2Locked        := Reg_ReadBool(reg, 'Prog2Locked', False);
    Prog3Locked        := Reg_ReadBool(reg, 'Prog3Locked', False);
    Prog4Locked        := Reg_ReadBool(reg, 'Prog4Locked', False);
    Prog5Locked        := Reg_ReadBool(reg, 'Prog5Locked', False);
    Prog6Locked        := Reg_ReadBool(reg, 'Prog6Locked', False);
    Prog7Locked        := Reg_ReadBool(reg, 'Prog7Locked', False);
    Prog8Locked        := Reg_ReadBool(reg, 'Prog8Locked', False);

    PingTimeout         := Reg_ReadInteger(reg, 'PingTimeout', PingTimeout);
    TowerExistsSleep    := Reg_ReadInteger(reg, 'TowerExistsSleep', TowerExistsSleep);
  finally
    reg.CloseKey;
  end;
  FillLockedProgramArray;
end;

procedure SaveExtraGeneralValues(reg : TRegistry);
begin
  {Saves the general values to the registry}
  Reg_DeleteKey(reg, 'ExtraGeneral');
  Reg_OpenKey(reg, 'ExtraGeneral');
  try
    reg.WriteBool('SaveWindowPos', SaveWindowPos);
    reg.WriteBool('AutoSaveDesktop', AutoSaveDesktop);
    reg.WriteBool('LockToolbars', LockToolbars);
    reg.WriteBool('MaxEditWindows', MaxEditWindows);
    reg.WriteBool('UseMDIMode', UseMDIMode);
    reg.WriteBool('QuietFirmware', QuietFirmware);
    reg.WriteBool('FirmwareFast', FirmwareFast);
    reg.WriteBool('FirmwareComp', FirmwareComp);
    reg.WriteInteger('FirmwareChunkSize', FirmwareChunkSize);
    reg.WriteInteger('DownloadWaitTime', DownloadWaitTime);

    reg.WriteBool('Prog1Locked', Prog1Locked);
    reg.WriteBool('Prog2Locked', Prog2Locked);
    reg.WriteBool('Prog3Locked', Prog3Locked);
    reg.WriteBool('Prog4Locked', Prog4Locked);
    reg.WriteBool('Prog5Locked', Prog5Locked);
    reg.WriteBool('Prog6Locked', Prog6Locked);
    reg.WriteBool('Prog7Locked', Prog7Locked);
    reg.WriteBool('Prog8Locked', Prog8Locked);

    reg.WriteInteger('PingTimeout', PingTimeout);
    reg.WriteInteger('TowerExistsSleep', TowerExistsSleep);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetGeneralValues(reg : TRegistry);
begin
  {Resets the general values to default}
  Reg_DeleteKey(reg, 'General');
  Reg_DeleteKey(reg, 'ExtraGeneral');
  LoadBasicGeneralValues(reg);
  LoadExtraGeneralValues(reg);
end;

{compiler values}
procedure LoadExtraCompilerValues(reg : TRegistry);
begin
  {Loads the compiler values from the registry}
  Reg_OpenKey(reg, 'ExtraCompiler');
  try
    NQCSwitches             := Reg_ReadString(reg, 'NQCSwitches', '');
    LCCSwitches             := Reg_ReadString(reg, 'LCCSwitches', '');
    CPPSwitches             := Reg_ReadString(reg, 'CPPSwitches', '');
    JavaSwitches            := Reg_ReadString(reg, 'JavaSwitches', '');
    NQCIncludePath          := Reg_ReadString(reg, 'NQCIncludePath', '');
    LCCIncludePath          := Reg_ReadString(reg, 'LCCIncludePath', '');
    OldNQCIncPaths          := Reg_ReadString(reg, 'OldNQCIncPaths', '');
    OldLCCIncPaths          := Reg_ReadString(reg, 'OldLCCIncPaths', '');
    CygwinDir               := Reg_ReadString(reg, 'CygwinDir', K_CYGWIN_DIR);
    BrickOSRoot             := Reg_ReadString(reg, 'BrickOSRoot', K_BRICKOS_ROOT);
    BrickOSMakefileTemplate := Reg_ReadString(reg, 'BrickOSMakefileTemplate', K_BRICKOS_MAKE_TEMPLATE);
    PascalCompilerPrefix    := Reg_ReadString(reg, 'PascalCompilerPrefix', K_PASCAL_PREFIX);
    KeepBrickOSMakefile     := Reg_ReadBool(reg, 'KeepBrickOSMakefile', False);
    LeJOSMakefileTemplate   := Reg_ReadString(reg, 'LeJOSMakefileTemplate', K_LEJOS_MAKE_TEMPLATE);
    KeepLeJOSMakefile       := Reg_ReadBool(reg, 'KeepLeJOSMakefile', False);
    NQCExePath              := Reg_ReadString(reg, 'NQCExePath', '');
    LCCExePath              := Reg_ReadString(reg, 'LCCExePath', '');
    IncludeSrcInList        := Reg_ReadBool(reg, 'IncludeSrcInList', False);
    LeJOSRoot               := Reg_ReadString(reg, 'LeJOSRoot', K_LEJOS_ROOT);
    JavaCompilerPath        := Reg_ReadString(reg, 'JavaCompilerPath', '');
    // forth console settings
    ShowAllConsoleOutput    := Reg_ReadBool(reg, 'ShowAllConsoleOutput', False);
    StopScriptDLOnErrors    := Reg_ReadBool(reg, 'StopScriptDLOnErrors', False);
    StripScriptComments     := Reg_ReadBool(reg, 'StripScriptComments', False);
    SkipBlankScriptLines    := Reg_ReadBool(reg, 'SkipBlankScriptLines', True);
    SyntaxHighlightConsole  := Reg_ReadBool(reg, 'SyntaxHighlightConsole', True);
    ConsoleOutputSeparate   := Reg_ReadBool(reg, 'ConsoleOutputSeparate', False);
    ShowConsoleLineNumbers  := Reg_ReadBool(reg, 'ShowConsoleLineNumbers', False);
    ConsoleCodeCompletion   := Reg_ReadBool(reg, 'ConsoleCodeCompletion', True);
    ConsoleICDelay          := Reg_ReadInteger(reg, 'ConsoleICDelay', 0);
    ConsoleILDelay          := Reg_ReadInteger(reg, 'ConsoleILDelay', 0);
    ConsoleUSBFirstTimeout  := Reg_ReadInteger(reg, 'ConsoleUSBFirstTimeout', 10);
    ConsoleUSBICTimeout     := Reg_ReadInteger(reg, 'ConsoleUSBICTimeout', 0);
    ConsoleUSBWriteTimeout  := Reg_ReadInteger(reg, 'ConsoleUSBWriteTimeout', 0);
  finally
    reg.CloseKey;
  end;
end;

procedure SaveExtraCompilerValues(reg : TRegistry);
begin
  {Saves the compiler values to the registry}
  Reg_DeleteKey(reg, 'ExtraCompiler');
  Reg_OpenKey(reg, 'ExtraCompiler');
  try
    reg.WriteString('NQCSwitches', NQCSwitches);
    reg.WriteString('LCCSwitches', LCCSwitches);
    reg.WriteString('JavaSwitches', JavaSwitches);
    reg.WriteString('NQCIncludePath', NQCIncludePath);
    reg.WriteString('LCCIncludePath', LCCIncludePath);
    reg.WriteString('OldNQCIncPaths', OldNQCIncPaths);
    reg.WriteString('OldLCCIncPaths', OldLCCIncPaths);
    reg.WriteString('CygwinDir', CygwinDir);
    reg.WriteString('BrickOSRoot', BrickOSRoot);
    reg.WriteString('BrickOSMakefileTemplate', BrickOSMakefileTemplate);
    reg.WriteString('PascalCompilerPrefix', PascalCompilerPrefix);
    reg.WriteBool('KeepBrickOSMakefile', KeepBrickOSMakefile);
    reg.WriteString('LeJOSMakefileTemplate', LeJOSMakefileTemplate);
    reg.WriteBool('KeepLeJOSMakefile', KeepLeJOSMakefile);
    reg.WriteString('NQCExePath', NQCExePath);
    reg.WriteString('LCCExePath', LCCExePath);
    reg.WriteBool('IncludeSrcInList', IncludeSrcInList);
    reg.WriteString('LeJOSRoot', LeJOSRoot);
    reg.WriteString('JavaCompilerPath', JavaCompilerPath);
    reg.WriteBool('ShowAllConsoleOutput', ShowAllConsoleOutput);
    reg.WriteBool('StopScriptDLOnErrors', StopScriptDLOnErrors);
    reg.WriteBool('StripScriptComments', StripScriptComments);
    reg.WriteBool('SkipBlankScriptLines', SkipBlankScriptLines);
    reg.WriteBool('SyntaxHighlightConsole', SyntaxHighlightConsole);
    reg.WriteBool('ConsoleOutputSeparate', ConsoleOutputSeparate);
    reg.WriteBool('ShowConsoleLineNumbers', ShowConsoleLineNumbers);
    reg.WriteBool('ConsoleCodeCompletion', ConsoleCodeCompletion);
    reg.WriteInteger('ConsoleICDelay', ConsoleICDelay);
    reg.WriteInteger('ConsoleILDelay', ConsoleILDelay);
    reg.WriteInteger('ConsoleUSBFirstTimeout', ConsoleUSBFirstTimeout);
    reg.WriteInteger('ConsoleUSBICTimeout', ConsoleUSBICTimeout);
    reg.WriteInteger('ConsoleUSBWriteTimeout', ConsoleUSBWriteTimeout);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetCompilerValues(reg : TRegistry);
begin
{Resets the compiler values to default}
  Reg_DeleteKey(reg, 'Compiler');
  Reg_DeleteKey(reg, 'ExtraCompiler');
  LoadBasicCompilerValues(reg);
  LoadExtraCompilerValues(reg);
end;

procedure LoadOtherOptionValues(reg : TRegistry);
begin
  Reg_OpenKey(reg, 'OtherOption');
  try
    AddMenuItemsToNewMenu := Reg_ReadBool(reg, 'AddMenuItemsToNewMenu', True);
  finally
    reg.CloseKey;
  end;
end;

procedure SaveOtherOptionValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'OtherOption');
  Reg_OpenKey(reg, 'OtherOption');
  try
    reg.WriteBool('AddMenuItemsToNewMenu', AddMenuItemsToNewMenu);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetOtherOptionValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'OtherOption');
  LoadOtherOptionValues(reg);
end;

{ keystrokes }
procedure LoadKeystrokeValues(reg : TRegistry; k : TSynEditKeyStrokes);
var
  tmpStream : TMemoryStream;
  bufSize : integer;
  buffer : PChar;
begin
  if not Reg_KeyExists(reg, 'Keystrokes') then
  begin
    k.ResetDefaults;
  end
  else
  begin
    Reg_OpenKey(reg, 'Keystrokes');
    try
      bufSize := Reg_ReadInteger(reg, 'ValueSize', 0);
      if bufSize > 0 then
      begin
        GetMem(buffer, bufSize);
        try
          reg.ReadBinaryData('Values', buffer^, bufSize);
          tmpStream := TMemoryStream.Create;
          try
            tmpStream.Write(buffer^, bufSize);
            tmpStream.Position := 0;
            k.LoadFromStream(tmpStream);
          finally
            tmpStream.Free;
          end;
        finally
          FreeMem(buffer, bufSize);
        end;
      end;
    finally
      reg.CloseKey;
    end;
  end;
  if Assigned(PrefForm) then
    PrefForm.SynEditColors.Keystrokes.Assign(k);
end;

procedure SaveKeystrokeValues(reg : TRegistry; k : TSynEditKeyStrokes);
var
  tmpStream : TMemoryStream;
begin
  Reg_DeleteKey(reg, 'Keystrokes');
  Reg_OpenKey(reg, 'Keystrokes');
  try
    tmpStream := TMemoryStream.Create;
    try
      k.SaveToStream(tmpStream);
      tmpStream.Position := 0;
      reg.WriteInteger('ValueSize', tmpStream.Size);
      reg.WriteBinaryData('Values', tmpStream.Memory^, tmpStream.Size);
    finally
      tmpStream.Free;
    end;
  finally
    reg.CloseKey;
  end;
end;

procedure ResetKeystrokeValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'Keystrokes');
  if Assigned(PrefForm.Keystrokes) then
    LoadKeystrokeValues(reg, PrefForm.Keystrokes);
end;

{ code templates }

procedure LoadPageSetupValues(reg : TRegistry);
var
  tmpStream : TMemoryStream;
  bufSize : integer;
  buffer : PChar;
begin
  if not Assigned(MainForm) then Exit;
  Reg_OpenKey(reg, 'PageSetup');
  try
    bufSize := Reg_ReadInteger(reg, 'ValueSize', 0);
    if bufSize > 0 then
    begin
      GetMem(buffer, bufSize);
      try
        reg.ReadBinaryData('Values', buffer^, bufSize);
        tmpStream := TMemoryStream.Create;
        try
          tmpStream.Write(buffer^, bufSize);
          tmpStream.Position := 0;
          MainForm.SynEditPrint.LoadFromStream(tmpStream);
        finally
          tmpStream.Free;
        end;
      finally
        FreeMem(buffer, bufSize);
      end;
    end;
  finally
    reg.CloseKey;
  end;
end;

procedure SavePageSetupValues(reg : TRegistry);
var
  tmpStream : TMemoryStream;
begin
  Reg_DeleteKey(reg, 'PageSetup');
  Reg_OpenKey(reg, 'PageSetup');
  try
    tmpStream := TMemoryStream.Create;
    try
      MainForm.SynEditPrint.SaveToStream(tmpStream);
      tmpStream.Position := 0;
      reg.WriteInteger('ValueSize', tmpStream.Size);
      reg.WriteBinaryData('Values', tmpStream.Memory^, tmpStream.Size);
    finally
      tmpStream.Free;
    end;
  finally
    reg.CloseKey;
  end;
end;

procedure ResetPageSetupValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'PageSetup');
  LoadPageSetupValues(reg);
end;

procedure LoadDatalogValues(reg : TRegistry);
begin
  if not Assigned(DatalogForm) then Exit;
  Reg_OpenKey(reg, 'DatalogValues');
  try
    DatalogForm.chkRelativeTime.Checked := Reg_ReadBool(reg, 'RelativeTime', False);
  finally
    reg.CloseKey;
  end;
end;

procedure SaveDatalogValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'DatalogValues');
  Reg_OpenKey(reg, 'DatalogValues');
  try
    reg.WriteBool('RelativeTime', DatalogForm.chkRelativeTime.Checked);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetDatalogValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'DatalogValues');
  LoadDatalogValues(reg);
end;

{ all }
procedure LoadAllValues(reg : TRegistry; k : TSynEditKeyStrokes; S : TStrings;
  aPrefHLNXC, aMainHLNXC, aPrefHLNQC, aMainHLNQC : TSynBaseNCSyn);
begin
  LoadBasicValues(reg, S);
  LoadNXCAPIValues(reg, aPrefHLNXC, aMainHLNXC);
  LoadExtraGeneralValues(reg);
  LoadExtraCompilerValues(reg);
  LoadNQCAPIValues(reg, aPrefHLNQC, aMainHLNQC);
  LoadStartupValues(reg);
  LoadColorValues(reg);
  LoadOtherOptionValues(reg);
  LoadWindowsValues(reg);
  LoadMacroValues(reg);
  LoadKeystrokeValues(reg, k);
  LoadPageSetupValues(reg);
  LoadDatalogValues(reg);
end;

procedure SaveAllValues(reg : TRegistry; k : TSynEditKeyStrokes; S : TStrings);
begin
  SaveBasicValues(reg, S);
  SaveExtraGeneralValues(reg);
  SaveExtraCompilerValues(reg);
  SaveNQCAPIValues(reg);
  SaveStartupValues(reg);
  SaveColorValues(reg);
  SaveOtherOptionValues(reg);
  SaveWindowsValues(reg);
  SaveMacroValues(reg);
  SaveKeystrokeValues(reg, k);
  SavePageSetupValues(reg);
  SaveDatalogValues(reg);
end;

procedure ResetAllValues(reg : TRegistry; S : TStrings;
  aPrefHLNXC, aMainHLNXC, aPrefHLNQC, aMainHLNQC : TSynBaseNCSyn);
begin
  ResetGeneralValues(reg);
  ResetCompilerValues(reg);
  ResetBasicValues(reg, S);
  ResetNXCAPIValues(reg, aPrefHLNXC, aMainHLNXC);
  ResetNQCAPIValues(reg, aPrefHLNQC, aMainHLNQC);
  ResetStartupValues(reg);
  ResetColorValues(reg);
  ResetOtherOptionValues(reg);
  ResetWindowsValues(reg);
  ResetMacroValues(reg);
  ResetKeystrokeValues(reg);
  ResetPageSetupValues(reg);
  ResetDatalogValues(reg);
end;

procedure UpgradeRegistry(aPrefHLNXC, aMainHLNXC, aPrefHLNQC, aMainHLNQC : TSynBaseNCSyn);
const
  K_MINVER = 3.2;
var
  R : TRegistry;
  mkStr, vStr, sVer : string;
  K : TSynEditKeyStrokes;
  S : TStringList;
  dVer : Double;
  bLoaded : boolean;
begin
  dVer := StrToFloatDef(fVersion, K_MINVER);
  R := TRegistry.Create;
  try
    bLoaded := False;
    // if our key doesn't exist then
    if not R.OpenKey(fMainKey+'\'+fVersion, false) then begin
      // store old values of fMainKey & fVersion
      K := TSynEditKeyStrokes.Create(nil);
      try
        S := TStringList.Create;
        try
          mkStr := fMainKey;
          vStr  := fVersion;
          try
            while dVer > (K_MINVER - 0.1) do begin
              sVer := FloatToStr(dVer);
              if R.OpenKey(K_MAINKEY+'\version ' + sVer, false) then begin
                fMainKey := K_MAINKEY;
                fVersion := 'version ' + sVer;
                // load values from old version
                LoadAllValues(R, K, S, aPrefHLNXC, aMainHLNXC, aPrefHLNQC, aMainHLNQC);
                bLoaded := True;
              end
              else if R.OpenKey(K_MAINKEY+'\'+sVer, false) then begin
                fMainKey := K_MAINKEY;
                fVersion := sVer;
                // load values from old version
                LoadAllValues(R, K, S, aPrefHLNXC, aMainHLNXC, aPrefHLNQC, aMainHLNQC);
                bLoaded := True;
              end;
              dVer := dVer - 0.1;
            end;
            if not bLoaded and R.OpenKey(K_OLDMAINKEY+'\'+K_OLDVERSION, false) then begin
              fMainKey := K_OLDMAINKEY;
              fVersion := K_OLDVERSION;
              // load values from old version
              LoadAllValues(R, K, S, aPrefHLNXC, aMainHLNXC, aPrefHLNQC, aMainHLNQC);
              bLoaded := True;
            end;
          finally
            fMainKey := mkStr;
            fVersion := vStr;
          end;
          // save values to new key
          if bLoaded then
            SaveAllValues(R, K, S);
        finally
          S.Free;
        end;
      finally
        K.Free;
      end;
    end;
  finally
    R.Free;
  end;
end;

function IsExtensionClaimed(const ext, pid : string) : Boolean;
var
  R : TRegistry;
begin
  Result := False;
  R := TRegistry.Create;
  try
    R.RootKey := HKEY_CURRENT_USER;
    if R.OpenKeyReadOnly('\Software\Classes\' + ext) then begin
      Result := R.ReadString('') = pid;
    end;
  finally
    R.Free;
  end;
end;

const
  SAVED_PID = 'BricxCCSavedPID';

procedure UnclaimExtension(const ext, pid : string);
var
  R : TRegistry;
  oldPID : string;
begin
  // unclaim extension
  R := TRegistry.Create;
  try
    R.RootKey := HKEY_CURRENT_USER;
    if R.OpenKey('\Software\Classes\' + ext, false) then begin
      if R.ValueExists(SAVED_PID) then
      begin
        oldPID := R.ReadString(SAVED_PID);
        R.DeleteValue(SAVED_PID);
      end;
      R.WriteString('', oldPID);
      if R.KeyExists(pid) then
        R.DeleteKey(pid);
      R.CloseKey;
    end;
    R.DeleteKey('\Software\Classes\' + pid);
  finally
    R.Free;
  end;
end;

procedure ClaimExtension(const ext, docName, pid : string; bClaim : Boolean);
var
  R : TRegistry;
  prog, oldPID : string;
begin
  if not bClaim then
    UnclaimExtension(ext, pid)
  else
  begin
    prog := ParamStr(0);
    // claim extension
    R := TRegistry.Create;
    try
      R.RootKey := HKEY_CURRENT_USER;
      if R.OpenKey('\Software\Classes\' + ext, true) then begin
        oldPID := R.ReadString('');
        R.WriteString('', pid);
        if oldPID <> '' then
          R.WriteString(SAVED_PID, oldPID);
        if AddMenuItemsToNewMenu then
        begin
          // create ShellNew subkey
          if R.OpenKey('ShellNew', true) then begin
            // do nothing
            R.CloseKey;
          end;
          if R.OpenKey('\Software\Classes\' + ext + '\' + pid + '\ShellNew', true) then begin
            R.WriteString('FileName', 'New ' + docName + ext);
            R.CloseKey;
          end;
        end;
        if R.OpenKey('\Software\Classes\' + pid, true) then begin
          R.WriteString('', docName);
          // default icon
          if R.OpenKey('DefaultIcon', true) then begin
            R.WriteString('', '"' + prog + '",0');
          end;
          R.CloseKey;
        end;
        if AddMenuItemsToNewMenu then
        begin
          if R.OpenKey('\Software\Classes\' + pid + '\shell\New', true) then begin
            // shell New
            R.WriteString('', '&New');
            if R.OpenKey('command', true) then begin
              R.WriteString('', '"' + prog + '" "/New"');
            end;
            R.CloseKey;
          end;
        end;
        if R.OpenKey('\Software\Classes\' + pid + '\shell\Open', true) then begin
          // shell Open
          R.WriteString('', '&Open');
          if R.OpenKey('command', true) then begin
            R.WriteString('', '"' + prog + '" "/NOCONNECT" "%1"');
          end;
          R.CloseKey;
        end;
        if R.OpenKey('\Software\Classes\' + pid + '\shell\Print', true) then begin
          // shell Print
          R.WriteString('', '&Print');
          if R.OpenKey('command', true) then begin
            R.WriteString('', '"' + prog + '" "/Print" "%1"');
          end;
          R.CloseKey;
        end;
        if R.OpenKey('\Software\Classes\' + pid + '\shell\printto\command', true) then begin
          // shell PrintTo
          R.WriteString('', '"' + prog + '" "/Print" "%1"');
          R.CloseKey;
        end;
      end;
    finally
      R.Free;
    end;
  end;
end;

procedure ClaimNQCExtension(bClaim : Boolean);
begin
  ClaimExtension('.nqc', 'NQC Document', 'NQCDocument', bClaim);
end;

procedure ClaimNQHExtension(bClaim : Boolean);
begin
  ClaimExtension('.nqh', 'NQC Header', 'NQCHeader', bClaim);
end;

procedure ClaimNBCExtension(bClaim : Boolean);
begin
  ClaimExtension('.nbc', 'NBC Document', 'NBC_Document', bClaim);
end;

procedure ClaimNXCExtension(bClaim : Boolean);
begin
  ClaimExtension('.nxc', 'NXC Document', 'NXC_Document', bClaim);
end;

procedure ClaimNPGExtension(bClaim : Boolean);
begin
  ClaimExtension('.npg', 'NPG Document', 'NPG_Document', bClaim);
end;

procedure ClaimRSExtension(bClaim : Boolean);
begin
  ClaimExtension('.rs', 'RICScript Document', 'RS_Document', bClaim);
end;

procedure ClaimROPSExtension(bClaim : Boolean);
begin
  ClaimExtension('.rops', 'PascalScript Document', 'ROPS_Document', bClaim);
end;

procedure RegisterApp;
var
  R : TRegistry;
  V : TVersionInfo;
  S : string;
begin
{$IFNDEF FPC}
  R := TRegistry.Create;
  try
    V := GetVersionInfo(Application.ExeName);
    S := ExtractFileName(Application.ExeName);
    // register NoOpenWith
    R.RootKey := HKEY_CURRENT_USER;
    if R.OpenKey('\Software\Classes\Applications\' + S, true) then begin
      R.WriteString('NoOpenWith', '');
    end;
    R.CloseKey;
    // claim NQC extension if it isn't registered already
    if not R.OpenKeyReadOnly('\Software\Classes\.nqc') then
      ClaimNQCExtension(True);
    R.CloseKey;
    // claim NQH extension if it isn't registered already
    if not R.OpenKeyReadOnly('\Software\Classes\.nqh') then
      ClaimNQHExtension(True);
    // claim NBC extension if it isn't registered already
    if not R.OpenKeyReadOnly('\Software\Classes\.nbc') then
      ClaimNBCExtension(True);
    // claim NXC extension if it isn't registered already
    if not R.OpenKeyReadOnly('\Software\Classes\.nxc') then
      ClaimNXCExtension(True);
    // claim NPG extension if it isn't registered already
    if not R.OpenKeyReadOnly('\Software\Classes\.npg') then
      ClaimNPGExtension(True);
    // claim RS extension if it isn't registered already
    if not R.OpenKeyReadOnly('\Software\Classes\.rs') then
      ClaimRSExtension(True);
    // claim ROPS extension if it isn't registered already
    if not R.OpenKeyReadOnly('\Software\Classes\.rops') then
      ClaimROPSExtension(True);
    R.CloseKey;
    // register product version under HKCU\Software\BricxCC
    R.RootKey := HKEY_CURRENT_USER;
    R.OpenKey(K_MAINKEY + '\' + V.ProductVersion, true);
    R.CloseKey;
  finally
    R.Free;
  end;
  R := TRegistry.Create;
  try
    R.RootKey := HKEY_CURRENT_USER;
    // register app paths
    if R.OpenKey('Software\Microsoft\Windows\CurrentVersion\App Paths', true) then begin
      if R.OpenKey(S, true) then begin
        R.WriteString('', Application.ExeName);
        R.WriteString('Path', ExePath);
      end;
    end;
    R.CloseKey;
  finally
    R.Free;
  end;
{$ENDIF}
end;

{********************************************
 Handling the preferences form
 ********************************************}

{The keystroke Information}

procedure RememberKeystrokeValues;
begin
end;

{ The Startup Information}

procedure RememberStartupValues;
begin
  {Remember current settings such that we know whether changed}
  {Nothing to be done yet}
end;

procedure GroupEnable(aCtrl : TWinControl; bEnable : boolean);
var
  i : integer;
  tmpCtrl : TControl;
begin
  for i := 0 to aCtrl.ControlCount - 1 do
  begin
    tmpCtrl := aCtrl.Controls[i];
    if tmpCtrl is TWinControl then
      GroupEnable(TWinControl(tmpCtrl), bEnable);
    tmpCtrl.Enabled := bEnable;
  end;
  aCtrl.Enabled := bEnable;
end;

{The Macros Information}

procedure RememberMacroValues;
begin
{Remember current settings such that we know whether changed}
  // Nothing to be done
end;

{ TPrefForm }

procedure TPrefForm.CheckConnectClick(Sender: TObject);
begin
//  GroupEnable(ComBox, CheckConnect.Checked);
end;

procedure TPrefForm.btnDefaultClick(Sender: TObject);
begin
  if pagPrefs.ActivePage = shtGeneral then
  begin
    ResetGeneralValues(fReg);
    DisplayGeneralValues;
  end
  else if pagPrefs.ActivePage = shtEditor then
  begin
    ResetEditorValues(fReg);
    DisplayEditorValues;
  end
  else if pagPrefs.ActivePage = shtCompiler then
  begin
    ResetCompilerValues(fReg);
    DisplayCompilerValues;
  end
  else if pagPrefs.ActivePage = shtAPI then
  begin
    ResetNQCAPIValues(fReg, SynNQCSyn, MainForm.SynNQCSyn);
    ResetNXCAPIValues(fReg, SynNXCSyn, MainForm.SynNXCSyn);
    DisplayAPIValues;
  end
  else if pagPrefs.ActivePage = shtStartup then
  begin
    ResetStartupValues(fReg);
    DisplayStartupValues;
  end
  else if pagPrefs.ActivePage = shtTemplates then
  begin
    ResetTemplateValues(fReg);
    DisplayTemplateValues(ActiveLanguageIndex(ahTemplates));
    TemplatesChanged := True;
  end
  else if pagPrefs.ActivePage = shtMacros then
  begin
    ResetMacroValues(fReg);
    DisplayMacroValues;
  end
  else if pagPrefs.ActivePage = shtColors then
  begin
    ResetColorValues(fReg);
    DisplayColorValues;
  end
  else if pagPrefs.ActivePage = shtOptions then
  begin
    ResetGutterValues(fReg);
    DisplayGutterValues;
    ResetOtherOptionValues(fReg);
    DisplayOtherOptionValues;
    ResetShortcutValues(fReg);
    DisplayShortcutValues;
    ResetKeystrokeValues(fReg);
    DisplayKeystrokeValues;
    ResetCodeTemplateValues(fReg, CodeTemplates);
    DisplayCodeTemplateValues;
  end;
end;

procedure TPrefForm.btnFontClick(Sender: TObject);
begin
  dlgFont.Font.Name := FontName;
  dlgFont.Font.Size := FontSize;
  if dlgFont.Execute then
  begin
    FontName := dlgFont.Font.Name;
    FontSize := dlgFont.Font.Size;
  end;
end;

procedure TPrefForm.UpBtnClick(Sender: TObject);
begin
  with NewTemplatesList do
  begin
    if CaretY <= 1 then Exit;
    Lines.Exchange(CaretY-2, CaretY-1);
    CaretY := CaretY-1;
    Invalidate;
    if CanFocus then SetFocus;
  end;
end;

procedure TPrefForm.DownBtnClick(Sender: TObject);
begin
  with NewTemplatesList do
  begin
    if CaretY < 1 then Exit;
    if CaretY-1 = Lines.Count-1 then Exit;
    Lines.Exchange(CaretY-1, CaretY);
    CaretY := CaretY+1;
    Invalidate;
    if CanFocus then SetFocus;
  end;
end;

procedure TPrefForm.InsertBtnClick(Sender: TObject);
var
  str : string;
begin
  with NewTemplatesList do
  begin
    if CaretY < 1 then Exit;
    str := InputBox(S_InsertTemplateCaption, S_InsertTemplatePrompt, '');
    if str <> '' then
    begin
      Lines.Insert(CaretY-1, str);
      TemplatesChanged := true;
    end;
    Invalidate;
    if CanFocus then SetFocus;
  end;
end;

procedure TPrefForm.ChangeBtnClick(Sender: TObject);
var
  str : string;
begin
  with NewTemplatesList do
  begin
  if CaretY < 1 then Exit;
    str := InputBox(S_ChangeTemplateCaption,
                    S_ChangeTemplatePrompt,
                    Lines[CaretY-1]);
    Lines[CaretY-1] := str;
    TemplatesChanged := true;
    Invalidate;
    if CanFocus then SetFocus;
  end;
end;

procedure TPrefForm.DeleteBtnClick(Sender: TObject);
var
  ttt : integer;
begin
  with NewTemplatesList do
  begin
    ttt := CaretY-1;
    if ttt < 0 then Exit;
    Lines.Delete(ttt);
    if ttt< Lines.Count-1 then
      CaretY := ttt+1
    else
      CaretY := ttt;
    TemplatesChanged := true;
    Invalidate;
    if CanFocus then SetFocus;
  end;
end;

procedure TPrefForm.TemplatesListDblClick(Sender: TObject);
begin
  ChangeBtnClick(Self);
end;

procedure TPrefForm.MShiftClick(Sender: TObject);
var lb:TListBox;
begin
  MacrosList.Visible:= not MShift.Down;
  ShiftMacrosList.Visible:= MShift.Down;
  if shtMacros = pagPrefs.ActivePage then
  begin
    if MShift.Down then lb:=ShiftMacrosList else lb := MacrosList;
    lb.SetFocus;
  end;
end;

procedure TPrefForm.MDeleteClick(Sender: TObject);
var lb:TListBox;
begin
  if MShift.Down then lb:=ShiftMacrosList else lb := MacrosList;
  lb.Items[lb.ItemIndex] := Copy(lb.Items[lb.ItemIndex],1,3);
  lb.SetFocus;
end;

procedure TPrefForm.MChangeClick(Sender: TObject);
var str:string;
    lb:TListBox;
begin
  if MShift.Down then lb:=ShiftMacrosList else lb := MacrosList;
  str := InputBox(S_ChangeMacroCaption,
                  Format(S_ChangeMacroPrompt, [lb.Items[lb.ItemIndex][1]]),
                  Copy(lb.Items[lb.ItemIndex],4,1000));
  MDeleteClick(Self);
  lb.Items[lb.ItemIndex]:=lb.Items[lb.ItemIndex]+str;
  lb.SetFocus;
end;

procedure TPrefForm.ShiftMacrosListDblClick(Sender: TObject);
begin
  MChangeClick(Self);
end;

procedure TPrefForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOk then
  begin
    GetGeneralValues;
    GetEditorValues;
    GetCompilerValues;
    GetStartupValues;
    if TemplatesChanged then
      GetTemplateValues(ActiveLanguageIndex(ahTemplates));
    GetMacroValues;
    UpdateGlobalColorsAndStyles;
    UpdateGlobalGutterValues;
    UpdateGlobalOtherOptionValues;
    UpdateGlobalShortcutValues;
    UpdateGlobalKeystrokeValues;
    GetAPIValues;
  end;
// when we close the form we should focus the first control on the general page
  pagPrefs.ActivePage := shtGeneral;
  ActiveControl       := CheckSavePos;
end;

procedure TPrefForm.FormShow(Sender: TObject);
begin
  SetHelpContext;
  NewTemplatesList.Font.Name := FontName;
  NewTemplatesList.Font.Size := FontSize;
  SynEditColors.Font.Name := FontName;
  SynEditColors.Font.Size := FontSize;

  fColorsChanged := False;
  pagPrefs.ActivePage    := shtGeneral;
  pagAPILang.ActivePage  := shtNQCAPI;
  pagNQCAPI.ActivePage   := shtAPIKeywords;
  pagNXCAPI.ActivePage   := shtNXCKeywords;
  pagCompiler.ActivePage := shtCompilerCommon;
  pagEditor.ActivePage   := shtEditorOptions;
  // load values
  RememberGeneralValues;
  DisplayGeneralValues;
  RememberEditorValues;
  DisplayEditorValues;
  RememberCompilerValues;
  DisplayCompilerValues;
  RememberAPIValues;
  DisplayAPIValues;
  RememberStartupValues;
  DisplayStartupValues;
  RememberTemplateValues;
  DisplayTemplateValues(MainForm.ActiveLanguageIndex);
  RememberMacroValues;
  DisplayMacroValues;
  DisplayColorValues;
  RememberGutterValues;
  DisplayGutterValues;
  RememberShortcutValues;
  DisplayShortcutValues;
  RememberKeystrokeValues;
  DisplayKeystrokeValues;
  RememberOtherOptionValues;
  DisplayOtherOptionValues;
  ConfigureOtherFirmwareOptions;
  UpdateCheckState;
  UpdateEditorExperts;
end;

procedure TPrefForm.FormCreate(Sender: TObject);
var
  i : integer;
begin
  CreateDirectoryEdits;
  CreateSynEditComponents;
  CreateHotKeyEdits;
  CreatePrefFormHighlighters;
  LoadNXTPorts(cboPort.Items);
  for i := 1 to 8 do
  begin
    cboPort.Items.Add('COM'+IntToStr(i));
  end;
//  CreateHotKeyComponents;
  {Create the Registry}
  fReg := TRegistry.Create;
  // create global keystrokes list
  fKeystrokes := TSynEditKeyStrokes.Create(nil);
  fKeystrokes.ResetDefaults;
  // create global code template list
  fCodeTemplates := TStringList.Create;
  // create local highlighters list
  fLocalHighlighters := TStringList.Create;
  // populate local highlighters list
  GetSortedHighlighters(Self, LocalHighlighters, False);
  cboLanguages.Items.Assign(LocalHighlighters);
  cboLanguages.ItemIndex := LocalHighlighters.IndexOf('NQC');
  cboLangTemp.Items.Assign(LocalHighlighters);
  cboLangTemp.ItemIndex := LocalHighlighters.IndexOf('NQC');
  LoadNXCConstants(SynNXCSyn.Constants);
  LoadAttributeNames;
  StoreDefaultAttributes;
  ShowSampleSource;
  SynEditColors.Highlighter := GetActiveHighlighter(ahColors);
  NewTemplatesList.Highlighter := GetActiveHighlighter(ahTemplates);
  {Load the settings}
  LoadAllValues(fReg, Keystrokes, CodeTemplates, SynNXCSyn, MainForm.SynNXCSyn,
    SynNQCSyn, MainForm.SynNQCSyn);
  MainForm.UpdateSynComponents;
end;

procedure TPrefForm.FormDestroy(Sender: TObject);
begin
  if not RunningAsCOMServer then
    SaveAllValues(fReg, Keystrokes, CodeTemplates);
  FreeAndNil(fReg);
  FreeAndNil(fKeystrokes);
  FreeAndNil(fCodeTemplates);
  FreeAndNil(fLocalHighlighters);
end;

procedure TPrefForm.DisplayColorValues;
var
  j, i : Integer;
  SCH : TSynCustomHighlighter;
begin
  for j := 0 to Highlighters.Count - 1 do
  begin
    SCH := TSynCustomHighlighter(Highlighters.Objects[j]);
    // copy global values into local syntax highlighters
    for i := 0 to SCH.AttrCount - 1 do
    begin
      LanguageHighlighter[j].Attribute[i].Assign(SCH.Attribute[i]);
    end;
  end;
  // set listbox selection
  lbElements.ItemIndex := 0;
  lbElementsClick(lbElements);
end;

procedure TPrefForm.UpdateGlobalColorsAndStyles;
var
  j, i : Integer;
  SCH : TSynCustomHighlighter;
begin
  for j := 0 to Highlighters.Count - 1 do
  begin
    SCH := TSynCustomHighlighter(Highlighters.Objects[j]);
    // copy local values into global syntax highlighter
    for i := 0 to SCH.AttrCount - 1 do
    begin
      SCH.Attribute[i].Assign(LanguageHighlighter[j].Attribute[i]);
    end;
  end;
end;

procedure TPrefForm.lbElementsClick(Sender: TObject);
var
  i : Integer;
begin
  // show color and style
  i := lbElements.ItemIndex;
  UncheckStyles;
  UncheckDefaults;
  ResetColorGrid;
  if UsingFGDefault(i) then
  begin
    cbxFGColor.Selected := clNone;
  end
  else
  begin
    cbxFGColor.Selected := GetFGColor(i);
  end;
  if UsingBGDefault(i) then
  begin
    cbxBGColor.Selected := clNone;
  end
  else
  begin
    cbxBGColor.Selected := GetBGColor(i);
  end;
  CheckStyles;
  CheckDefaults;
  ShowItemInEditor(i);
end;

procedure TPrefForm.cbxFGColorChange(Sender: TObject);
var
  i : integer;
begin
  i := lbElements.ItemIndex;
  if i = -1 then Exit;
  // change color
  if cbxFGColor.Selected <> clNone then
    SetFGColor(i, cbxFGColor.Selected)
  else
    SetFGColor(i, GetFGDefault(lbElements.ItemIndex));

  fColorsChanged := True;
  CheckDefaults;
end;

procedure TPrefForm.cbxBGColorChange(Sender: TObject);
var
  i : integer;
begin
  i := lbElements.ItemIndex;
  if i = -1 then Exit;
  // change color
  if cbxBGColor.Selected <> clNone then
    SetBGColor(i, cbxBGColor.Selected)
  else
    SetBGColor(i, GetBGDefault(lbElements.ItemIndex));

  fColorsChanged := True;
  CheckDefaults;
end;

procedure TPrefForm.chkBoldClick(Sender: TObject);
var
  idx : integer;
begin
  // add bold to style
  idx := lbElements.ItemIndex;
  if idx = -1 then Exit;
  if chkBold.Checked then
  begin
    SetStyles(idx, GetStyles(idx) + [fsBold]);
  end
  else
  begin
    SetStyles(idx, GetStyles(idx) - [fsBold]);
  end;
  fColorsChanged := True;
end;

procedure TPrefForm.chkItalicClick(Sender: TObject);
var
  idx : integer;
begin
  // add italic to style
  idx := lbElements.ItemIndex;
  if idx = -1 then Exit;
  if chkItalic.Checked then
  begin
    SetStyles(idx, GetStyles(idx) + [fsItalic]);
  end
  else
  begin
    SetStyles(idx, GetStyles(idx) - [fsItalic]);
  end;
  fColorsChanged := True;
end;

procedure TPrefForm.chkUnderlineClick(Sender: TObject);
var
  idx : integer;
begin
 // add underline to style
  idx := lbElements.ItemIndex;
  if idx = -1 then Exit;
  if chkUnderline.Checked then
  begin
    SetStyles(idx, GetStyles(idx) + [fsUnderline]);
  end
  else
  begin
    SetStyles(idx, GetStyles(idx) - [fsUnderline]);
  end;
  fColorsChanged := True;
end;

procedure SilentCheck(aCB : TCheckBox; bCheck : boolean);
var
  evt : TNotifyEvent;
begin
  evt := aCB.OnClick;
  aCB.OnClick := nil;
  try
    aCB.Checked := bCheck;
  finally
    aCB.OnClick := evt;
  end;
end;

procedure TPrefForm.UncheckStyles;
begin
  SilentCheck(chkBold, False);
  SilentCheck(chkItalic, False);
  SilentCheck(chkUnderline, False);
end;

procedure TPrefForm.CheckStyles;
var
  tmpStyles : TFontStyles;
begin
  tmpStyles := GetStyles(lbElements.ItemIndex);
  SilentCheck(chkBold, fsBold in tmpStyles);
  SilentCheck(chkItalic, fsItalic in tmpStyles);
  SilentCheck(chkUnderline, fsUnderline in tmpStyles);
end;

function TPrefForm.GetBGColor(idx: integer): TColor;
begin
  Result := GetActiveHighlighter(ahColors).Attribute[idx].Background;
end;

function TPrefForm.GetFGColor(idx: integer): TColor;
begin
  Result := GetActiveHighlighter(ahColors).Attribute[idx].Foreground;
end;

function TPrefForm.GetStyles(idx: integer): TFontStyles;
begin
  Result := GetActiveHighlighter(ahColors).Attribute[idx].Style;
end;

procedure TPrefForm.SetStyles(idx: integer; aStyle: TFontStyles);
begin
  GetActiveHighlighter(ahColors).Attribute[idx].Style := aStyle;
end;

procedure TPrefForm.SetBGColor(idx: integer; aColor: TColor);
begin
  GetActiveHighlighter(ahColors).Attribute[idx].Background := aColor;
end;

procedure TPrefForm.SetFGColor(idx: integer; aColor: TColor);
begin
  GetActiveHighlighter(ahColors).Attribute[idx].Foreground := aColor;
end;

procedure TPrefForm.chkFGClick(Sender: TObject);
begin
  if chkFG.Checked then
  begin
    cbxFGColor.Selected := clNone;
  end;
end;

procedure TPrefForm.chkBGClick(Sender: TObject);
begin
  if chkBG.Checked then
  begin
    cbxBGColor.Selected := clNone;
  end;
end;

procedure TPrefForm.CheckDefaults;
var
  i : integer;
begin
  i := lbElements.ItemIndex;
  SilentCheck(chkFG, UsingFGDefault(i));
  SilentCheck(chkBG, UsingBGDefault(i));
end;

procedure TPrefForm.UncheckDefaults;
begin
  SilentCheck(chkFG, False);
  SilentCheck(chkBG, False);
end;

function TPrefForm.UsingBGDefault(idx: integer): boolean;
begin
  Result := GetActiveHighlighter(ahColors).Attribute[idx].Background = GetBGDefault(idx);
end;

function TPrefForm.UsingFGDefault(idx: integer): boolean;
begin
  Result := GetActiveHighlighter(ahColors).Attribute[idx].Foreground = GetFGDefault(idx);
end;

function TPrefForm.GetBGDefault(idx: integer): TColor;
begin
  Result := fDefBGColors[ActiveLanguageIndex(ahColors)][idx];
end;

function TPrefForm.GetFGDefault(idx: integer): TColor;
begin
  Result := fDefFGColors[ActiveLanguageIndex(ahColors)][idx];
end;

procedure TPrefForm.StoreDefaultAttributes;
var
  j, i : Integer;
  SCH : TSynCustomHighlighter;
begin
  SetLength(fDefBGColors, LanguageCount);
  SetLength(fDefFGColors, LanguageCount);
  SetLength(fDefStyles, LanguageCount);
  for j := 0 to LanguageCount - 1 do
  begin
    SCH := LanguageHighlighter[j];
    SetLength(fDefBGColors[j], SCH.AttrCount);
    SetLength(fDefFGColors[j], SCH.AttrCount);
    SetLength(fDefStyles[j], SCH.AttrCount);
    for i := 0 to SCH.AttrCount - 1 do
    begin
      fDefBGColors[j][i] := SCH.Attribute[i].Background;
      fDefFGColors[j][i] := SCH.Attribute[i].Foreground;
      fDefStyles[j][i]   := SCH.Attribute[i].Style;
    end;
  end;
end;

procedure TPrefForm.DisplayOtherOptionValues;
begin
  chkNewMenu.Checked := AddMenuItemsToNewMenu;
  chkUseHTMLHelp.Checked := UseHTMLHelp;
end;

procedure TPrefForm.UpdateGlobalOtherOptionValues;
begin
  AddMenuItemsToNewMenu := chkNewMenu.Checked;
  UseHTMLHelp           := chkUseHTMLHelp.Checked;
end;

procedure TPrefForm.DisplayGutterValues;
begin
  cbGutterVisible.Checked  := GutterVisible;
  cbLineNumbers.Checked    := ShowLineNumbers;
  cbLeadingZeros.Checked   := ShowLeadingZeros;
  cbAutoSize.Checked       := AutoSizeGutter;
  cbUseFontStyle.Checked   := UseFontStyle;
  cbZeroStart.Checked      := ZeroStart;
  inpDigitCount.Value      := DigitCount;
  inpLeftOffset.Value      := LeftOffset;
  inpRightOffset.Value     := RightOffset;
  inpGutterWidth.Value     := GutterWidth;
  cbSelectOnClick.Checked  := SelectOnClick;
  cbxGutterColor.Selected  := GutterColor;
end;

procedure TPrefForm.UpdateGlobalGutterValues;
begin
  GutterVisible    := cbGutterVisible.Checked;
  ShowLineNumbers  := cbLineNumbers.Checked;
  ShowLeadingZeros := cbLeadingZeros.Checked;
  AutoSizeGutter   := cbAutoSize.Checked;
  UseFontStyle     := cbUseFontStyle.Checked;
  ZeroStart        := cbZeroStart.Checked;
  DigitCount       := inpDigitCount.Value;
  LeftOffset       := inpLeftOffset.Value;
  RightOffset      := inpRightOffset.Value;
  GutterWidth      := inpGutterWidth.Value;
  SelectOnClick    := cbSelectOnClick.Checked;
  GutterColor      := cbxGutterColor.Selected;
end;

procedure TPrefForm.DisplayKeystrokeValues;
begin
  SynEditColors.Keystrokes := Keystrokes;
end;

procedure TPrefForm.DisplayCodeTemplateValues;
begin
end;

procedure TPrefForm.UpdateGlobalKeystrokeValues;
begin
  Keystrokes := SynEditColors.Keystrokes;
end;

{$IFDEF FPC}
procedure TPrefForm.btnKeystrokesClick(Sender: TObject);
begin
end;
{$ELSE}
procedure TPrefForm.btnKeystrokesClick(Sender: TObject);
var
  Dlg: TSynEditKeystrokesEditorForm;
begin
  Dlg := TSynEditKeystrokesEditorForm.Create(Self);
  try
    Dlg.Caption := S_KeystrokeCaption;
    Dlg.Keystrokes := SynEditColors.Keystrokes;
    if Dlg.ShowModal = mrOk then begin
      SynEditColors.Keystrokes := Dlg.Keystrokes;
    end;
  finally
    Dlg.Free;
  end;
end;
{$ENDIF}

procedure TPrefForm.SetKeystrokes(const Value: TSynEditKeyStrokes);
begin
  if Value = nil then
    fKeystrokes.Clear
  else
    fKeystrokes.Assign(Value);
end;

procedure TPrefForm.SetCodeTemplates(const Value: TStrings);
begin
  if Value = nil then
    fCodeTemplates.Clear
  else
    fCodeTemplates.Assign(Value);
end;

procedure TPrefForm.btnEditCodeTemplatesClick(Sender: TObject);
begin
  with TfrmCodeTemplates.Create(nil) do
  try
    Caption := S_CodeTemplatesCaption;
    CodeTemplates := Self.CodeTemplates;
    if ShowModal = mrOk then begin
      Self.CodeTemplates := CodeTemplates;
    end;
  finally
    Free;
  end;
end;

procedure TPrefForm.btnClaimExtClick(Sender: TObject);
begin
  with TfrmExtensionDlg.Create(self) do
  try
    ClaimNQC   := IsExtensionClaimed('.nqc', 'NQCDocument') and
                  IsExtensionClaimed('.nqh', 'NQCHeader');
    ClaimRCX2  := IsExtensionClaimed('.rcx2', 'MindScriptDocument1');
    ClaimLSC   := IsExtensionClaimed('.lsc', 'MindScriptDocument2');
    ClaimASM   := IsExtensionClaimed('.lasm', 'LASMDocument');
    ClaimC     := IsExtensionClaimed('.c', 'BrickOS_CDocument');
    ClaimCpp   := IsExtensionClaimed('.cpp', 'BrickOS_CppDocument');
    ClaimPas   := IsExtensionClaimed('.pas', 'BrickOS_PasDocument');
    ClaimJava  := IsExtensionClaimed('.java', 'leJOS_Document');
    ClaimNBC   := IsExtensionClaimed('.nbc', 'NBC_Document');
    ClaimNXC   := IsExtensionClaimed('.nxc', 'NXC_Document');
    ClaimNPG   := IsExtensionClaimed('.npg', 'NPG_Document');
    ClaimRS    := IsExtensionClaimed('.rs', 'RS_Document');
    ClaimForth := IsExtensionClaimed('.4th', 'Forth_4thDocument') and
                  IsExtensionClaimed('.fr', 'Forth_FrDocument') and
                  IsExtensionClaimed('.f', 'Forth_FDocument') and
                  IsExtensionClaimed('.fth', 'Forth_FthDocument');
    ClaimLua   := IsExtensionClaimed('.lua', 'Forth_LuaDocument') and
                  IsExtensionClaimed('.lpr', 'Forth_LprDocument');
    ClaimROPS  := IsExtensionClaimed('.rops', 'ROPS_Document');
    if ShowModal = mrOK then
    begin
      ClaimNQCExtension(ClaimNQC);
      ClaimNQHExtension(ClaimNQC);
      ClaimExtension('.rcx2', 'MindScript Document', 'MindScriptDocument1', ClaimRCX2);
      ClaimExtension('.lsc', 'MindScript Document', 'MindScriptDocument2', ClaimLSC);
      ClaimExtension('.lasm', 'LASM Document', 'LASMDocument', ClaimASM);
      ClaimExtension('.c', 'BrickOS C Document', 'BrickOS_CDocument', ClaimC);
      ClaimExtension('.cpp', 'BrickOS C++ Document', 'BrickOS_CppDocument', ClaimCpp);
      ClaimExtension('.pas', 'BrickOS Pascal Document', 'BrickOS_PasDocument', ClaimPas);
      ClaimExtension('.java', 'Java Document', 'leJOS_Document', ClaimJava);
      ClaimExtension('.4th', 'Forth Document', 'Forth_4thDocument', ClaimForth);
      ClaimExtension('.fr', 'Forth Document', 'Forth_FrDocument', ClaimForth);
      ClaimExtension('.f', 'Forth Document', 'Forth_FDocument', ClaimForth);
      ClaimExtension('.fth', 'Forth Document', 'Forth_FthDocument', ClaimForth);
      ClaimNBCExtension(ClaimNBC);
      ClaimNXCExtension(ClaimNXC);
      ClaimNPGExtension(ClaimNPG);
      ClaimRSExtension(ClaimRS);
      ClaimROPSExtension(ClaimROPS);
      ClaimExtension('.lua', 'Lua Document', 'Forth_LuaDocument', ClaimLua);
      ClaimExtension('.lpr', 'Lua Document', 'Forth_LprDocument', ClaimLua);
    end;
  finally
    Free;
  end;
end;

function TPrefForm.GetActiveAPIEdit: TEdit;
begin
  if pagAPILang.ActivePage = shtNQCAPI then
  begin
    if pagNQCAPI.ActivePage = shtAPIKeywords then
      Result := edtKeyword
    else if pagNQCAPI.ActivePage = shtAPICommands then
      Result := edtCommand
    else
      Result := edtConstant;
  end
  else
  begin
    if pagNXCAPI.ActivePage = shtNXCKeywords then
      Result := edtNXCKeyword
    else if pagNXCAPI.ActivePage = shtNXCCommands then
      Result := edtNXCCommand
    else
      Result := edtNXCConstant;
  end;
end;

function TPrefForm.GetActiveAPIListBox: TListBox;
begin
  if pagAPILang.ActivePage = shtNQCAPI then
  begin
    if pagNQCAPI.ActivePage = shtAPIKeywords then
      Result := lstKeywords
    else if pagNQCAPI.ActivePage = shtAPICommands then
      Result := lstCommands
    else
      Result := lstConstants;
  end
  else
  begin
    if pagNXCAPI.ActivePage = shtNXCKeywords then
      Result := lstNXCKeywords
    else if pagNXCAPI.ActivePage = shtNXCCommands then
      Result := lstNXCCommands
    else
      Result := lstNXCConstants;
  end;
end;

procedure TPrefForm.btnAddAPIClick(Sender: TObject);
var
  LB : TListBox;
  ED : TEdit;
begin
  LB := GetActiveAPIListBox;
  ED := GetActiveAPIEdit;
  if ED.Text = '' then Exit;
  if LB.Items.IndexOf(ED.Text) = -1 then
    LB.Items.Add(ED.Text);
  UpdateAPIButtonState;
end;

procedure TPrefForm.btnDeleteAPIClick(Sender: TObject);
var
  LB : TListBox;
begin
  LB := GetActiveAPIListBox;
  if LB.ItemIndex = -1 then Exit;
  if MessageDlg(S_ConfirmAPIDelete, mtConfirmation, [mbYes,mbNo], 0) = mrYes then
    LB.Items.Delete(LB.ItemIndex);
  UpdateAPIButtonState;
end;

procedure TPrefForm.lstAPIClick(Sender: TObject);
var
  LB : TListBox;
  ED : TEdit;
begin
  LB := GetActiveAPIListBox;
  ED := GetActiveAPIEdit;
  if LB.ItemIndex <> -1 then
    ED.Text := LB.Items[LB.ItemIndex];
  UpdateAPIButtonState;
end;

procedure TPrefForm.edtAPIChange(Sender: TObject);
begin
  UpdateAPIButtonState;
end;

procedure TPrefForm.pagPrefsChange(Sender: TObject);
begin
  SetHelpContext;
  if pagPrefs.ActivePage = shtAPI then
    UpdateAPIButtonState;
end;

procedure TPrefForm.pagNQCAPIChange(Sender: TObject);
begin
  UpdateAPIButtonState;
end;

procedure TPrefForm.UpdateAPIButtonState;
var
  ED : TEdit;
  LB : TListBox;
begin
  LB := GetActiveAPIListBox;
  ED := GetActiveAPIEdit;
  btnAddAPI.Enabled := ED.Text <> '';
  btnDeleteAPI.Enabled := LB.ItemIndex <> -1;
end;

procedure UpdateTransferList(aSrcList, aDestList : TList);
var
  i : integer;
  T : TTransferItem;
begin
  for i := 0 to aDestList.Count - 1 do
  begin
    TTransferItem(aDestList[i]).Free;
  end;
  aDestList.Clear;
  for i := 0 to aSrcList.Count - 1 do
  begin
    T := TTransferItem.Create;
    try
      aDestList.Add(T);
      T.Assign(TTransferItem(aSrcList[i]));
    except
      T.Free;
    end
  end;
end;

procedure TPrefForm.ShowItemInEditor(i: Integer);
var
  y : Integer;
begin
  if ActiveLanguageIndex(ahColors) <> LocalHighlighters.IndexOf('NQC') then
    Exit;
  case i of
    0 : y := 10; // command
    1 : y := 2;  // comment
    2 : y := 13; // constant
    3 : y := 11; // field
    4 : y := 7;  // identifier
    5 : y := 5;  // keyword
    6 : y := 15; // number
    7 : y := 3;  // preprocessor
    8 : y := 8;  // space
    9 : y := 6;  // symbol
  else
    y := 1; // other
  end;
  SynEditColors.CaretXY := Point(1, y);
  if pagPrefs.ActivePage = shtColors then
    SynEditColors.SetFocus;
end;

procedure TPrefForm.LoadAttributeNames;
var
  i : Integer;
  H : TSynCustomHighlighter;
begin
  lbElements.Items.Clear;
  H := GetActiveHighlighter(ahColors);
  for i := 0 to H.AttrCount - 1 do
  begin
    lbElements.Items.Add(H.Attribute[i].Name);
  end;
end;

function TPrefForm.GetActiveHighlighter(reason : TActiveHighlighterReason): TSynCustomHighlighter;
begin
  Result := LanguageHighlighter[ActiveLanguageIndex(reason)];
end;

procedure TPrefForm.ShowSampleSource;
begin
  SynEditColors.Text := GetActiveHighlighter(ahColors).SampleSource;
end;

{
function TPrefForm.ActiveLanguageName(reason : TActiveHighlighterReason): String;
begin
  case reason of
    ahColors : Result := cboLanguages.Items[cboLanguages.ItemIndex];
  else // ahTemplates
    Result := cboLangTemp.Items[cboLangTemp.ItemIndex];
  end;
end;
}

function TPrefForm.ActiveLanguageIndex(reason : TActiveHighlighterReason): Integer;
begin
  case reason of
    ahColors : Result := cboLanguages.ItemIndex;
  else // ahTemplates
    Result := cboLangTemp.ItemIndex;
  end;
end;

function TPrefForm.LanguageCount: Integer;
begin
  Result := LocalHighlighters.Count;
end;

function TPrefForm.GetCustomHighlighter(index: Integer): TSynCustomHighlighter;
begin
  Result := TSynCustomHighlighter(LocalHighlighters.Objects[index]);
end;

function TPrefForm.LocalHighlighters: TStringList;
begin
  Result := fLocalHighlighters;
end;

procedure TPrefForm.cboLanguagesChange(Sender: TObject);
begin
  LoadAttributeNames;
  ShowSampleSource;
  SynEditColors.Highlighter := GetActiveHighlighter(ahColors);
end;

procedure TPrefForm.ResetColorGrid;
var
  OC : TNotifyEvent;
begin
  OC := cbxFGColor.OnChange;
  try
    cbxFGColor.OnChange := nil;
    cbxFGColor.Selected := clNone;
  finally
    cbxFGColor.OnChange := OC;
  end;
  OC := cbxBGColor.OnChange;
  try
    cbxBGColor.OnChange := nil;
    cbxBGColor.Selected := clNone;
  finally
    cbxBGColor.OnChange := OC;
  end;
end;

procedure TPrefForm.edtLCCIncludePathExit(Sender: TObject);
var
  path : String;
begin
  path := Trim(edtLCCIncludePath.Text);
  if LCCIncludePath <> path then
  begin
    // add old path to combo box if it isn't already there
    if (LCCIncludePath <> '') and
       (edtLCCIncludePath.Items.IndexOf(LCCIncludePath) = -1) then
      edtLCCIncludePath.Items.Insert(0, LCCIncludePath);
    if (path <> '') and
       (edtLCCIncludePath.Items.IndexOf(path) = -1) then
      edtLCCIncludePath.Items.Insert(0, path);
    while edtLCCIncludePath.Items.Count > K_MAX_OLD_PATHS do
      edtLCCIncludePath.Items.Delete(edtLCCIncludePath.Items.Count-1);
  end;
end;

procedure TPrefForm.edtNBCIncludePathExit(Sender: TObject);
var
  path : String;
begin
  path := Trim(edtNBCIncludePath.Text);
  if NBCIncludePath <> path then
  begin
    // add old path to combo box if it isn't already there
    if (NBCIncludePath <> '') and
       (edtNBCIncludePath.Items.IndexOf(NBCIncludePath) = -1) then
      edtNBCIncludePath.Items.Insert(0, NBCIncludePath);
    if (path <> '') and
       (edtNBCIncludePath.Items.IndexOf(path) = -1) then
      edtNBCIncludePath.Items.Insert(0, path);
    while edtNBCIncludePath.Items.Count > K_MAX_OLD_PATHS do
      edtNBCIncludePath.Items.Delete(edtNBCIncludePath.Items.Count-1);
  end;
end;

procedure TPrefForm.edtNQCIncludePathExit(Sender: TObject);
var
  path : string;
begin
  path := Trim(edtNQCIncludePath.Text);
  if NQCIncludePath <> path then
  begin
    // add old path to combo box if it isn't already there
    if (NQCIncludePath <> '') and
       (edtNQCIncludePath.Items.IndexOf(NQCIncludePath) = -1) then
      edtNQCIncludePath.Items.Insert(0, NQCIncludePath);
    if (path <> '') and
       (edtNQCIncludePath.Items.IndexOf(path) = -1) then
      edtNQCIncludePath.Items.Insert(0, path);
    while edtNQCIncludePath.Items.Count > K_MAX_OLD_PATHS do
      edtNQCIncludePath.Items.Delete(edtNQCIncludePath.Items.Count-1);
  end;
end;

procedure TPrefForm.DisplayShortcutValues;
begin
  PrefForm.hkCodeComp.HotKey  := CodeCompShortCut;
  PrefForm.hkParamComp.HotKey := ParamCompShortCut;
  PrefForm.hkRecMacro.HotKey  := RecMacroShortCut;
  PrefForm.hkPlayMacro.HotKey := PlayMacroShortCut;
end;

procedure TPrefForm.UpdateGlobalShortcutValues;
begin
  CodeCompShortCut  := PrefForm.hkCodeComp.HotKey;
  ParamCompShortCut := PrefForm.hkParamComp.HotKey;
  RecMacroShortCut  := PrefForm.hkRecMacro.HotKey;
  PlayMacroShortCut := PrefForm.hkPlayMacro.HotKey;
end;

procedure TPrefForm.ConfigureOtherFirmwareOptions;
const
  LockedProgsHeights : array[Boolean] of Integer = (114, 168);
var
  bBrickOS : Boolean;
begin
  bBrickOS := LocalFirmwareType = ftBrickOS;
  cbProg6.Visible := bBrickOS;
  cbProg7.Visible := bBrickOS;
  cbProg8.Visible := bBrickOS;
  grpLockedProgs.Height := Trunc(LockedProgsHeights[bBrickOS] * (Screen.PixelsPerInch / 96));
end;

procedure TPrefForm.btnGetNQCVersionClick(Sender: TObject);
begin
  ShowVersion(NQCPath);
end;

procedure TPrefForm.btnGetLCCVersionClick(Sender: TObject);
begin
  ShowVersion(LCCPath);
end;

procedure TPrefForm.btnGetNBCVersionClick(Sender: TObject);
begin
  if chkUseIntNBCComp.Checked then
  begin
    ShowMessage(sVersion + ' ' + VerFileVersion);
  end
  else
    ShowVersion(NBCPath);
end;

procedure TPrefForm.ShowVersion(aPath: string);
var
  V : TVersionInfo;
begin
  if FileExists(aPath) then
  begin
    V := GetVersionInfo(aPath);
    if V.FileVersion <> '' then
      ShowMessage(sVersion + ' ' + V.FileVersion);
  end;
end;

function TPrefForm.GetFirmwareTypeDefault : TFirmwareType;
begin
  if radBrickOS.Checked then
    Result := ftBrickOS
  else if radPBForth.Checked then
    Result := ftPBForth
  else if radLejos.Checked then
    Result := ftLeJOS
  else if radOtherFirmware.Checked then
    Result := ftOther
  else
    Result := ftStandard;
end;

procedure TPrefForm.SetFirmwareType(ft: TFirmwareType);
begin
  case ft of
    ftBrickOS : radBrickOS.Checked := True;
    ftPBForth : radPBForth.Checked := True;
    ftLeJOS   : radLejos.Checked   := True;
    ftOther   : radOtherFirmware.Checked := True;
  else
    // assume standard
    radStandard.Checked := True;
  end;
end;

function GetUseMDIMode : Boolean;
var
  R : TRegistry;
begin
  R := TRegistry.Create;
  try
    Reg_OpenKey(R, 'ExtraGeneral');
    try
      Result := Reg_ReadBool(R, 'UseMDIMode', True);
    finally
      R.CloseKey;
    end;
  finally
    R.Free;
  end;
end;

function TPrefForm.GetPrefLang: Integer;
begin
  if radPrefMindScript.Checked then
    Result := 1
  else if radPrefLASM.Checked then
    Result := 2
  else if radPrefNBC.Checked then
    Result := 3
  else if radPrefNXC.Checked then
    Result := 4
  else
    Result := 0;
end;

procedure TPrefForm.SetPrefLang(const Value: Integer);
begin
  radPrefNQC.Checked        := Value = 0;
  radPrefMindScript.Checked := Value = 1;
  radPrefLASM.Checked       := Value = 2;
  radPrefNBC.Checked        := Value = 3;
  radPrefNXC.Checked        := Value = 4;
end;

procedure TPrefForm.chkFirmfastClick(Sender: TObject);
begin
  UpdateCheckState;
end;

procedure TPrefForm.UpdateCheckState;
begin
  chkFirmComp.Enabled := chkFirmFast.Checked;
end;

procedure TPrefForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TPrefForm.cboLangTempChange(Sender: TObject);
var
  idx : integer;
begin
// save and reload the templates list
  if TemplatesChanged then
  begin
    // save templates
    idx := Highlighters.IndexOf(NewTemplatesList.Highlighter.LanguageName);
    GetTemplateValues(idx);
  end;
  // reload
  DisplayTemplateValues(ActiveLanguageIndex(ahTemplates));
  NewTemplatesList.Highlighter := GetActiveHighlighter(ahTemplates);
end;

procedure TPrefForm.NewTemplatesList2Change(Sender: TObject);
begin
  TemplatesChanged := True;
end;

procedure TPrefForm.btnSaveTemplatesClick(Sender: TObject);
begin
  if dlgSaveTemplates.Execute then
    NewTemplatesList.Lines.SaveToFile(dlgSaveTemplates.FileName);
end;

procedure TPrefForm.btnLoadTemplatesClick(Sender: TObject);
begin
  if dlgLoadTemplates.Execute then
  begin
    NewTemplatesList.Lines.LoadFromFile(dlgLoadTemplates.FileName);
    TemplatesChanged := True;
  end;
end;

procedure TPrefForm.btnPrecompileClick(Sender: TObject);
begin
  with TfrmTransferDlg.Create(nil) do
  try
    PrivateTransferList := PrecompileSteps;
    if ShowModal = mrOk then
    begin
      UpdateTransferList(PrivateTransferList, PrecompileSteps);
    end;
  finally
    Free;
  end;
end;

procedure TPrefForm.btnPostcompileClick(Sender: TObject);
begin
  with TfrmTransferDlg.Create(nil) do
  try
    PrivateTransferList := PostcompileSteps;
    if ShowModal = mrOk then
    begin
      UpdateTransferList(PrivateTransferList, PostcompileSteps);
    end;
  finally
    Free;
  end;
end;

procedure TPrefForm.CreatePrefFormHighlighters;
begin
  SynCppSyn        := TSynCppSyn.Create(Self);
  SynMindScriptSyn := TSynMindScriptSyn.Create(Self);
  SynNPGSyn        := TSynNPGSyn.Create(Self);
  SynForthSyn      := TSynForthSyn.Create(Self);
  SynJavaSyn       := TSynJavaSyn.Create(Self);
  SynNQCSyn        := TSynNQCSyn.Create(Self);
  SynNXCSyn        := TSynNXCSyn.Create(Self);
  SynRSSyn         := TSynRSSyn.Create(Self);
  SynROPSSyn       := TSynROPSSyn.Create(Self);
  SynLASMSyn       := TSynLASMSyn.Create(Self);
  SynLuaSyn        := TSynLuaSyn.Create(Self);
  SynRubySyn       := TSynRubySyn.Create(Self);
  SynPasSyn        := TSynPasSyn.Create(Self);
  SynNBCSyn        := TSynNBCSyn.Create(Self);
  SynCSSyn         := TSynCSSyn.Create(Self);
  SynSPCSyn        := TSynSPCSyn.Create(Self);
  with SynCppSyn do
  begin
    Name := 'SynCppSyn';
    DefaultFilter := 'C++ Files (*.c,*.cpp,*.h,*.hpp)|*.c;*.cpp;*.h;*.hpp';
  end;
  with SynMindScriptSyn do
  begin
    Name := 'SynMindScriptSyn';
  end;
  with SynNPGSyn do
  begin
    Name := 'SynNPGSyn';
    DefaultFilter := 'NPG Files (*.npg)|*.npg';
  end;
  with SynForthSyn do
  begin
    Name := 'SynForthSyn';
  end;
  with SynJavaSyn do
  begin
    Name := 'SynJavaSyn';
    DefaultFilter := 'Java Files (*.java)|*.java';
  end;
  with SynNQCSyn do
  begin
    Name := 'SynNQCSyn';
    DefaultFilter := 'NQC files (*.nqc)|*.nqc';
    Comments := [csCStyle];
    DetectPreprocessor := True;
    IdentifierChars := '#0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz';
    KeyWords.Clear;
    Commands.Clear;
    Constants.Clear;
    if FileExists(ProgramDir + 'Default\nqc_samplesource.txt') then
      SampleSourceStrings.LoadFromFile(ProgramDir + 'Default\nqc_samplesource.txt');
  end;
  with SynNXCSyn do
  begin
    Name := 'SynNXCSyn';
    DefaultFilter := 'NXC Files (*.nxc)|*.nxc';
    Comments := [csCStyle];
    DetectPreprocessor := True;
    IdentifierChars := '#0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz';
    KeyWords.Clear;
    Commands.Clear;
    Constants.Clear;
    if FileExists(ProgramDir + 'Default\nxc_samplesource.txt') then
      SampleSourceStrings.LoadFromFile(ProgramDir + 'Default\nxc_samplesource.txt');
  end;
  with SynRSSyn do
  begin
    Name := 'SynRSSyn';
    DefaultFilter := 'RICScript Files (*.rs)|*.rs';
  end;
  with SynROPSSyn do
  begin
    Name := 'SynROPSSyn';
  end;
  with SynLASMSyn do
  begin
    Name := 'SynLASMSyn';
    DefaultFilter := 'LASM Assembler Files (*.asm)|*.asm';
  end;
  with SynLuaSyn do
  begin
    Name := 'SynLuaSyn';
  end;
  with SynRubySyn do
  begin
    Name := 'SynRubySyn';
  end;
  with SynPasSyn do
  begin
    Name := 'SynPasSyn';
  end;
  with SynNBCSyn do
  begin
    Name := 'SynNBCSyn';
    DefaultFilter := 'NXT Byte Code Files (*.nbc)|*.nbc';
  end;
  with SynCSSyn do
  begin
    Name := 'SynCSSyn';
    DefaultFilter := 'C# Files (*.cs)|*.cs';
  end;
  with SynSPCSyn do
  begin
    Name := 'SynSPCSyn';
    DefaultFilter := 'SPC Files (*.spc)|*.spc';
    Comments := [csCStyle];
    DetectPreprocessor := True;
    IdentifierChars := '#0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz';
    Keywords.CommaText := 'asm, bool, break, case, const, continue, default, ' +
                          'do, else, enum, false, for, goto, if, inline, int, ' +
                          'long, repeat, return, static, struct, sub, switch, ' +
                          'task, true, typedef, until, void, while';
    Commands.Clear;
    Constants.Clear;
    if FileExists(ProgramDir + 'Default\spc_samplesource.txt') then
      SampleSourceStrings.LoadFromFile(ProgramDir + 'Default\spc_samplesource.txt');
  end;
end;

procedure TPrefForm.CreateHotKeyEdits;
begin
  hkCodeComp  := TBricxCCHotKey.Create(Self);
  hkParamComp := TBricxCCHotKey.Create(Self);
  hkRecMacro  := TBricxCCHotKey.Create(Self);
  hkPlayMacro := TBricxCCHotKey.Create(Self);
  CloneHotKey(hkCodeComp, hkCodeComp2);
  CloneHotKey(hkParamComp, hkParamComp2);
  CloneHotKey(hkRecMacro, hkRecMacro2);
  CloneHotKey(hkPlayMacro, hkPlayMacro2);
end;

procedure TPrefForm.CreateDirectoryEdits;
begin
  edtNQCExePath   := TDirectoryEdit.Create(Self);
  edtLCCExePath   := TDirectoryEdit.Create(Self);
  edtNBCExePath   := TDirectoryEdit.Create(Self);
  edtCygwin       := TDirectoryEdit.Create(Self);
  edtJavaPath     := TDirectoryEdit.Create(Self);
  edtLeJOSRoot    := TDirectoryEdit.Create(Self);
  edtUserDataPath := TDirectoryEdit.Create(Self);
  edtSymLibPath   := TDirectoryEdit.Create(Self);
  CloneDE(edtNQCExePath, edtNQCExePath2);
  CloneDE(edtLCCExePath, edtLCCExePath2);
  CloneDE(edtNBCExePath, edtNBCExePath2);
  CloneDE(edtCygwin, edtCygwin2);
  CloneDE(edtJavaPath, edtJavaPath2);
  CloneDE(edtLeJOSRoot, edtLeJOSRoot2);
  CloneDE(edtUserDataPath, edtUserDataPath2);
  CloneDE(edtSymLibPath, edtSymLibPath2);
end;

procedure TPrefForm.CreateSynEditComponents;
begin
  NewTemplatesList := TSynEdit.Create(Self);
  SynEditColors    := TSynEdit.Create(Self);
  CloneSynEdit(NewTemplatesList, NewTemplatesList2);
  CloneSynEdit(SynEditColors, SynEditColors2);
  NewTemplatesList.Gutter.Visible := False;
end;

procedure TPrefForm.radRICDecompScriptClick(Sender: TObject);
begin
  edtRICDecompArrayFmt.Enabled := radRICDecompArray.Checked;
end;

procedure TPrefForm.btnCommentConfigClick(Sender: TObject);
begin
  CommentConfigure;
end;

procedure TPrefForm.btnAlignLinesConfigClick(Sender: TObject);
var
  Dialog : TfrmAlignOptions;
begin
  Dialog := TfrmAlignOptions.Create(nil);
  try
    Dialog.mmoTokens.Lines.CommaText := AlignTokenList;
    Dialog.edtWhitespace.Value       := AlignMinWhitespace;
    if Dialog.ShowModal = mrOK then
    begin
      AlignTokenList     := Dialog.mmoTokens.Lines.CommaText;
      AlignMinWhitespace := Dialog.edtWhitespace.Value;
    end;
  finally
    FreeAndNil(Dialog);
  end;
end;

procedure TPrefForm.btnShowNQCDefsClick(Sender: TObject);
begin
  ShowMessage('Not yet implemented');
end;

procedure TPrefForm.btnShowNBCCommonClick(Sender: TObject);
var
  C : TCodeForm;
begin
  if UseInternalNBC then
  begin
    C := TCodeForm.Create(Application);
    C.Width := 640;
    C.CodeEdit.Highlighter := MainForm.SynCppSyn;
    C.CodeEdit.Lines.Text := APIAsText(1);
    C.Show;
  end
  else
  begin
    ShowMessage('Not yet implemented');
  end;
end;

procedure TPrefForm.btnShowNXTDefsClick(Sender: TObject);
var
  C : TCodeForm;
begin
  if UseInternalNBC then
  begin
    C := TCodeForm.Create(Application);
    C.Width := 640;
    C.CodeEdit.Highlighter := MainForm.SynCppSyn;
    C.CodeEdit.Lines.Text := APIAsText(2);
    C.Show;
  end
  else
  begin
    ShowMessage('Not yet implemented');
  end;
end;

procedure TPrefForm.btnShowNXCDefsClick(Sender: TObject);
var
  C : TCodeForm;
begin
  if UseInternalNBC then
  begin
    C := TCodeForm.Create(Application);
    C.Width := 640;
    C.CodeEdit.Highlighter := MainForm.SynCppSyn;
    C.CodeEdit.Lines.Text := APIAsText(3);
    C.Show;
  end
  else
  begin
    ShowMessage('Not yet implemented');
  end;
end;

procedure TPrefForm.DisplayAPIValues;
begin
  // NQC API
  edtKeyword.Text := '';
  edtCommand.Text := '';
  edtConstant.Text := '';
  lstKeywords.Items.Clear;
  lstCommands.Items.Clear;
  lstConstants.Items.Clear;

  lstKeywords.Items.Assign(cc_keywords);
  lstCommands.Items.Assign(cc_commands);
  lstConstants.Items.Assign(cc_constants);

  // NXC API
  edtNXCKeyword.Text := '';
  edtNXCCommand.Text := '';
  edtNXCConstant.Text := '';
  lstNXCKeywords.Items.Clear;
  lstNXCCommands.Items.Clear;
  lstNXCConstants.Items.Clear;

  lstNXCKeywords.Items.Assign(cc_nxc_keywords);
  lstNXCCommands.Items.Assign(cc_nxc_commands);
  lstNXCConstants.Items.Assign(cc_nxc_constants);
end;

procedure TPrefForm.GetAPIValues;
begin
  // NQC API
  cc_keywords.Assign(lstKeywords.Items);
  cc_commands.Assign(lstCommands.Items);
  cc_constants.Assign(lstConstants.Items);
  // NXC API
  cc_nxc_keywords.Assign(lstNXCKeywords.Items);
  cc_nxc_commands.Assign(lstNXCCommands.Items);
  cc_nxc_constants.Assign(lstNXCConstants.Items);
  PutAPIValuesInSyntaxHighlighter(cc_keywords, cc_commands, cc_constants,
    SynNQCSyn, MainForm.SynNQCSyn);
  PutAPIValuesInSyntaxHighlighter(cc_nxc_keywords, cc_nxc_commands, cc_nxc_constants,
    SynNXCSyn, MainForm.SynNXCSyn);
end;

procedure TPrefForm.DisplayCompilerValues;
begin
  edtCompilerTimeout.Value       := CompilerTimeout div K_MSTOSEC;
  edtCompilerSwitches.Text       := CompilerSwitches;
  GUIPreferredLanguage           := PreferredLanguage;
  edtNQCSwitches.Text            := NQCSwitches;
  edtLCCSwitches.Text            := LCCSwitches;
  edtNBCSwitches.Text            := NBCSwitches;
  edtCPPSwitches.Text            := CPPSwitches;
  cboOptLevel.ItemIndex          := NBCOptLevel;
  edtMaxErrors.Value             := NBCMaxErrors;
  edtJavaSwitches.Text           := JavaSwitches;
  edtNQCIncludePath.Text         := NQCIncludePath;
  edtLCCIncludePath.Text         := LCCIncludePath;
  edtNBCIncludePath.Text         := NBCIncludePath;
  edtCygwin.Text                 := CygwinDir;
  edtOSRoot.Text                 := BrickOSRoot;
  edtBrickOSMakefileTemplate.Lines.Text := BrickOSMakefileTemplate;
  edtPascalCompilerPrefix.Text   := PascalCompilerPrefix;
  chkKeepBrickOSMakefile.Checked := KeepBrickOSMakefile;
  edtLeJOSMakefileTemplate.Lines.Text := LeJOSMakefileTemplate;
  chkKeepLeJOSMakefile.Checked   := KeepLeJOSMakefile;
  edtNQCExePath.Text             := NQCExePath;
  edtLCCExePath.Text             := LCCExePath;
  edtNBCExePath.Text             := NBCExePath;
  chkIncludeSrcInList.Checked    := IncludeSrcInList;
  chkUseIntNBCComp.Checked       := UseInternalNBC;
  chkEnhancedFirmware.Checked    := EnhancedFirmware;
  chkNXT2Firmare.Checked         := NXT2Firmware;
  chkNXTAutoFW.Checked           := NXTAutoFWVersion;
  chkIgnoreSysFiles.Checked      := IgnoreSysFiles;
  edtLeJOSRoot.Text              := LeJOSRoot;
  edtJavaPath.Text               := JavaCompilerPath;
  // forth console settings
  chkShowAllOutput.Checked          := ShowAllConsoleOutput;
  chkStopOnAborted.Checked          := StopScriptDLOnErrors;
  chkStripComments.Checked          := StripScriptComments;
  chkSkipBlankLines.Checked         := SkipBlankScriptLines;
  chkConsoleSyntaxHL.Checked        := SyntaxHighlightConsole;
  chkOutputSeparate.Checked         := ConsoleOutputSeparate;
  chkShowConsoleLineNumbers.Checked := ShowConsoleLineNumbers;
  chkConsoleCompProp.Checked        := ConsoleCodeCompletion;
  edtICDelay.Value                  := ConsoleICDelay;
  edtILDelay.Value                  := ConsoleILDelay;
  edtConsoleReadFirstTimeout.Value  := ConsoleUSBFirstTimeout;
  edtConsoleReadICTimeout.Value     := ConsoleUSBICTimeout;
  edtConsoleWriteTimeout.Value      := ConsoleUSBWriteTimeout;

  edtNQCIncludePath.Items.CommaText := OldNQCIncPaths;
  edtLCCIncludePath.Items.CommaText := OldLCCIncPaths;
end;

procedure TPrefForm.DisplayEditorValues;
begin
  {Displays the values in the form}
  CheckColorCoding.Checked    := ColorCoding;
  CheckShowTemplates.Checked  := ShowTemplatePopup;
  CheckAutoIndentCode.Checked := AutoIndentCode;
  CheckMacrosOn.Checked       := MacrosOn;
  radRICDecompArray.Checked   := RICDecompAsData;
  edtRICDecompArrayFmt.Text   := RICDecompNameFormat;
  cbHideSelection.Checked     := HideSelection;
  chkCCInsensitive.Checked    := CCInsensitive;
  cbScrollPastEOL.Checked     := ScrollPastEOL;
  cbHalfPageScroll.Checked    := HalfPageScroll;
  chkDragDrop.Checked         := DragAndDropEditing;
  inpTabWidth.Value           := TabWidth;
  inpMaxUndo.Value            := MaxUndo;
  edtMaxLeftChar.Value        := MaxLeftChar;
  inpExtraLineSpacing.Value   := ExtraLineSpacing;
  cbxScrollBars.ItemIndex     := ScrollBars;
  inpRightEdge.Value          := RightEdgePosition;
  cbxREColor.Selected         := RightEdgeColor;
  cbxColor.Selected           := EditorColor;
  cbxForeground.Selected      := SelectionForeground;
  cbxBackground.Selected      := SelectionBackground;
  cbxStructureColor.Selected  := StructureColor;
  cbxActiveLineColor.Selected := ActiveLineColor;
  chkAltSelMode.Checked       := AltSetsSelMode;
  chkMoveRight.Checked        := MoveCursorRight;
  chkKeepBlanks.Checked       := KeepBlanks;
  chkSmartTab.Checked         := UseSmartTabs;
  chkEnhHomeKey.Checked       := EnhanceHomeKey;
  chkGroupUndo.Checked        := GroupUndo;
  chkTabIndent.Checked        := TabIndent;
  chkConvertTabs.Checked      := ConvertTabs;
  chkShowSpecialChars.Checked := ShowSpecialChars;
  chkHighlightCurLine.Checked := HighlightCurLine;
  chkKeepCaretX.Checked       := KeepCaretX;
  chkAutoMaxLeft.Checked      := AutoMaxLeft;

  edtUserDataPath.Text        := UserDataLocalPath;
  edtSymLibPath.Text          := SymFileLibraryPath;
end;

procedure TPrefForm.DisplayGeneralValues;
begin
{Displays the values in the form}
  CheckShowRecent.Checked      := ShowRecent;
  CheckSavePos.Checked         := SaveWindowPos;
  CheckSaveBackup.Checked      := SaveBackup;
  chkShowCompileStatus.Checked := ShowCompilerStatus;
  chkAutoSave.Checked          := AutoSaveFiles;
  chkSaveDesktop.Checked       := AutoSaveDesktop;
  chkSaveBinaryOutput.Checked  := SaveBinaryOutput;
  chkLockToolbars.Checked      := LockToolbars;
  chkMaxEditWindows.Checked    := MaxEditWindows;
  chkMultiFormatCopy.Checked   := MultiFormatCopy;
  chkUseMDI.Checked            := UseMDIMode;
  chkQuietFirmware.Checked     := QuietFirmware;
  chkDroppedRecent.Checked     := DroppedRecent;
  chkFirmfast.Checked          := FirmwareFast;
  chkFirmComp.Checked          := FirmwareComp;
  edtFirmwareChunkSize.Value   := FirmwareChunkSize;
  edtWaitTime.Value            := DownloadWaitTime;
  edtMaxRecent.Value           := MaxRecent;
  cbProg1.Checked              := Prog1Locked;
  cbProg2.Checked              := Prog2Locked;
  cbProg3.Checked              := Prog3Locked;
  cbProg4.Checked              := Prog4Locked;
  cbProg5.Checked              := Prog5Locked;
  cbProg6.Checked              := Prog6Locked;
  cbProg7.Checked              := Prog7Locked;
  cbProg8.Checked              := Prog8Locked;
end;

procedure TPrefForm.DisplayMacroValues;
var
  i, numb : integer;
begin
  {Displays the values in the form}
  MacrosList.Items.Clear;
  ShiftMacrosList.Items.Clear;
  for i:=1 to 26 do MacrosList.Items.Add(Chr(Ord('A')+i-1)+': ');
  for i:=1 to 10 do MacrosList.Items.Add(Chr(Ord('0')+i-1)+': ');
  for i:=1 to 26 do ShiftMacrosList.Items.Add(Chr(Ord('A')+i-1)+': ');
  for i:=1 to 10 do ShiftMacrosList.Items.Add(Chr(Ord('0')+i-1)+': ');
  for i:= 1 to macronumb do
  begin
    if Pos('<Shift>',macros[i]) = 12 then
    begin
      numb:=Ord(macros[i][19])-Ord('A');
      if (numb<0) or (numb>25) then numb:=Ord(macros[i][19])-Ord('0')+26;
      ShiftMacrosList.Items[numb] := macros[i][19]+': '+ Copy(macros[i],21,1000);
    end else begin
      numb:=Ord(macros[i][12])-Ord('A');
      if (numb<0) or (numb>25) then numb:=Ord(macros[i][12])-Ord('0')+26;
      MacrosList.Items[numb] := macros[i][12]+': '+ Copy(macros[i],14,1000);
    end;
  end;
  MacrosList.ItemIndex:=0;
  ShiftMacrosList.ItemIndex:=0;
  MacrosList.Visible:=true;
  ShiftMacrosList.Visible:=false;
  MShift.Down := false;
end;

procedure TPrefForm.DisplayStartupValues;
begin
  {Display the values in the form}
  CheckShowForm.Checked  := (StartupAction = SU_SHOWFORM);
  CheckConnect.Checked   := (StartupAction = SU_CONNECT);
  CheckNoConnect.Checked := (StartupAction = SU_NOCONNECT);

  cboBrickType.ItemIndex := BrickType;

  cboPort.ItemIndex := cboPort.Items.IndexOf(COMPort);
  if cboPort.ItemIndex = -1 then
    cboPort.Text := COMPort;

//  chkUseBluetooth.Checked := UseBluetoothDefault;
  radStandard.Checked     := StandardFirmwareDefault;
  SetFirmwareType(FirmwareTypeDefault);
  chkFBAlwaysPrompt.Checked := FBAlwaysPrompt;
end;

procedure TPrefForm.DisplayTemplateValues(const aLang : integer);
var
  i : integer;
begin
  {Displays the values in the form}
  with NewTemplatesList do
  begin
    Lines.Clear;
    for i:= 1 to templatenumb[aLang] do
      Lines.Add(templates[aLang][i-1]);
    CaretY := 1;
    EnsureCursorPosVisible;
  end;
  cboLangTemp.OnChange := nil;
  try
    cboLangTemp.ItemIndex := aLang;
  finally
    cboLangTemp.OnChange := cboLangTempChange;
  end;
end;

procedure TPrefForm.GetCompilerValues;
begin
  CompilerTimeout         := edtCompilerTimeout.Value * K_MSTOSEC;
  LocalCompilerTimeout    := CompilerTimeout;
  CompilerSwitches        := edtCompilerSwitches.Text;
  PreferredLanguage       := GUIPreferredLanguage;
  NQCSwitches             := edtNQCSwitches.Text;
  LCCSwitches             := edtLCCSwitches.Text;
  NBCSwitches             := edtNBCSwitches.Text;
  CPPSwitches             := edtCPPSwitches.Text;
  JavaSwitches            := edtJavaSwitches.Text;
  NBCOptLevel             := cboOptLevel.ItemIndex;
  NBCMaxErrors            := edtMaxErrors.Value;
  NQCIncludePath          := edtNQCIncludePath.Text;
  OldNQCIncPaths          := edtNQCIncludePath.Items.CommaText;
  LCCIncludePath          := edtLCCIncludePath.Text;
  OldLCCIncPaths          := edtLCCIncludePath.Items.CommaText;
  NBCIncludePath          := edtNBCIncludePath.Text;
  OldNBCIncPaths          := edtNBCIncludePath.Items.CommaText;
  CygwinDir               := edtCygwin.Text;
  BrickOSRoot             := edtOSRoot.Text;
  BrickOSMakefileTemplate := edtBrickOSMakefileTemplate.Lines.Text;
  PascalCompilerPrefix    := edtPascalCompilerPrefix.Text;
  KeepBrickOSMakefile     := chkKeepBrickOSMakefile.Checked;
  LeJOSMakefileTemplate   := edtLeJOSMakefileTemplate.Lines.Text;
  KeepLeJOSMakefile       := chkKeepLeJOSMakefile.Checked;
  NQCExePath              := edtNQCExePath.Text;
  LCCExePath              := edtLCCExePath.Text;
  NBCExePath              := edtNBCExePath.Text;
  IncludeSrcInList        := chkIncludeSrcInList.Checked;
  UseInternalNBC          := chkUseIntNBCComp.Checked;
  EnhancedFirmware        := chkEnhancedFirmware.Checked;
  NXT2Firmware            := chkNXT2Firmare.Checked;
  NXTAutoFWVersion        := chkNXTAutoFW.Checked;
  IgnoreSysFiles          := chkIgnoreSysFiles.Checked;
  LeJOSRoot               := edtLeJOSRoot.Text;
  JavaCompilerPath        := edtJavaPath.Text;
  ShowAllConsoleOutput    := chkShowAllOutput.Checked;
  StopScriptDLOnErrors    := chkStopOnAborted.Checked;
  StripScriptComments     := chkStripComments.Checked;
  SkipBlankScriptLines    := chkSkipBlankLines.Checked;
  SyntaxHighlightConsole  := chkConsoleSyntaxHL.Checked;
  ConsoleOutputSeparate   := chkOutputSeparate.Checked;
  ShowConsoleLineNumbers  := chkShowConsoleLineNumbers.Checked;
  ConsoleCodeCompletion   := chkConsoleCompProp.Checked;
  ConsoleICDelay          := edtICDelay.Value;
  ConsoleILDelay          := edtILDelay.Value;
  ConsoleUSBFirstTimeout  := edtConsoleReadFirstTimeout.Value;
  ConsoleUSBICTimeout     := edtConsoleReadICTimeout.Value;
  ConsoleUSBWriteTimeout  := edtConsoleWriteTimeout.Value;
end;

procedure TPrefForm.GetEditorValues;
begin
  {Gets the values from the form}
  ColorsChanged       := fColorsChanged;
  ColorCoding         := CheckColorCoding.Checked;
  ShowTemplatePopup   := CheckShowTemplates.Checked;
  AutoIndentCode      := CheckAutoIndentCode.Checked;
  MacrosOn            := CheckMacrosOn.Checked;
  RICDecompAsData     := radRICDecompArray.Checked;
  RICDecompNameFormat := edtRICDecompArrayFmt.Text;
  HideSelection       := cbHideSelection.Checked;
  CCInsensitive       := chkCCInsensitive.Checked;
  ScrollPastEOL       := cbScrollPastEOL.Checked;
  HalfPageScroll      := cbHalfPageScroll.Checked;
  DragAndDropEditing  := chkDragDrop.Checked;
  TabWidth            := inpTabWidth.Value;
  MaxUndo             := inpMaxUndo.Value;
  MaxLeftChar         := edtMaxLeftChar.Value;
  ExtraLineSpacing    := inpExtraLineSpacing.Value;
  ScrollBars          := cbxScrollBars.ItemIndex;
  RightEdgePosition   := inpRightEdge.Value;
  RightEdgeColor      := cbxREColor.Selected;
  EditorColor         := cbxColor.Selected;
  SelectionForeground := cbxForeground.Selected;
  SelectionBackground := cbxBackground.Selected;
  StructureColor      := cbxStructureColor.Selected;
  ActiveLineColor     := cbxActiveLineColor.Selected;
  AltSetsSelMode      := chkAltSelMode.Checked;
  MoveCursorRight     := chkMoveRight.Checked;
  KeepBlanks          := chkKeepBlanks.Checked;
  UseSmartTabs        := chkSmartTab.Checked;
  EnhanceHomeKey      := chkEnhHomeKey.Checked;
  GroupUndo           := chkGroupUndo.Checked;
  TabIndent           := chkTabIndent.Checked;
  ConvertTabs         := chkConvertTabs.Checked;
  ShowSpecialChars    := chkShowSpecialChars.Checked;
  HighlightCurLine    := chkHighlightCurLine.Checked;
  KeepCaretX          := chkKeepCaretX.Checked;
  AutoMaxLeft         := chkAutoMaxLeft.Checked;

  UserDataLocalPath   := edtUserDataPath.Text;
  SymFileLibraryPath  := edtSymLibPath.Text;
end;

procedure TPrefForm.GetGeneralValues;
begin
{Gets the values from the form}
  ShowRecent         := CheckShowRecent.Checked;
  SaveWindowPos      := CheckSavePos.Checked;
  SaveBackup         := CheckSaveBackup.Checked;
  ShowCompilerStatus := chkShowCompileStatus.Checked;
  AutoSaveFiles      := chkAutoSave.Checked;
  AutoSaveDesktop    := chkSaveDesktop.Checked;
  SaveBinaryOutput   := chkSaveBinaryOutput.Checked;
  LockToolbars       := chkLockToolbars.Checked;
  MaxEditWindows     := chkMaxEditWindows.Checked;
  MultiFormatCopy    := chkMultiFormatCopy.Checked;
  UseMDIMode         := chkUseMDI.Checked;
  QuietFirmware      := chkQuietFirmware.Checked;
  DroppedRecent      := chkDroppedRecent.Checked;
  FirmwareFast       := chkFirmfast.Checked;
  FirmwareComp       := chkFirmComp.Checked;
  FirmwareChunkSize  := edtFirmwareChunkSize.Value;
  DownloadWaitTime   := edtWaitTime.Value;
  Prog1Locked        := cbProg1.Checked;
  Prog2Locked        := cbProg2.Checked;
  Prog3Locked        := cbProg3.Checked;
  Prog4Locked        := cbProg4.Checked;
  Prog5Locked        := cbProg5.Checked;
  Prog6Locked        := cbProg6.Checked;
  Prog7Locked        := cbProg7.Checked;
  Prog8Locked        := cbProg8.Checked;

  SetMaxRecent(edtMaxRecent.Value);
end;

procedure TPrefForm.GetMacroValues;
var
  i : integer;
  str : string;
begin
  {Gets the values from the form}
  MacrosChanged := false;
  macronumb:=0;
  for i:=0 to MacrosList.Items.Count-1 do
  begin
    str:='<Ctrl><Alt>';
    str:=str+ MacrosList.Items[i][1]+':';
    str:=str+Copy(MacrosList.Items[i],4,1000);
    if (Length(str)>13) then
    begin
      macronumb:=macronumb+1;
      if (str <> macros[macronumb]) then MacrosChanged := true;
      macros[macronumb] := str;
    end
  end;
  for i:=0 to ShiftMacrosList.Items.Count-1 do
  begin
    str:='<Ctrl><Alt><Shift>';
    str:=str+ ShiftMacrosList.Items[i][1]+':';
    str:=str+Copy(ShiftMacrosList.Items[i],4,1000);
    if (Length(str)>20) then
    begin
      macronumb:=macronumb+1;
      if (str <> macros[macronumb]) then MacrosChanged := true;
      macros[macronumb] := str;
    end
  end;
end;

procedure TPrefForm.GetStartupValues;
begin
  {Gets the values from the form}
  if CheckShowForm.Checked then StartupAction := SU_SHOWFORM;
  if CheckConnect.Checked then StartupAction := SU_CONNECT;
  if CheckNoConnect.Checked then StartupAction := SU_NOCONNECT;

  BrickType := cboBrickType.ItemIndex;
  if BrickType = -1 then
    BrickType := SU_RCX;

  COMPort := cboPort.Text;

  StandardFirmwareDefault := radStandard.Checked;
  UseBluetoothDefault     := False;
  FirmwareTypeDefault     := GetFirmwareTypeDefault;
  FBAlwaysPrompt          := chkFBAlwaysPrompt.Checked;
end;

procedure TPrefForm.GetTemplateValues(const aLang : integer);
var
  i : integer;
begin
  {Gets the values from the form}
  with NewTemplatesList do
  begin
    templatenumb[aLang] := Lines.Count;
    SetLength(templates[aLang], templatenumb[aLang]);
    for i:=0 to Lines.Count-1 do
      templates[aLang][i] := Lines[i];
  end;
end;

procedure TPrefForm.btnGrepSearchConfigClick(Sender: TObject);
begin
  MainForm.GrepDlgExpert.Configure;
end;

procedure TPrefForm.lbEditorExpertsClick(Sender: TObject);
var
  ee : TEditorExpert;
begin
  if lbEditorExperts.ItemIndex <> -1 then
  begin
    ee := TeditorExpert(lbEditorExperts.ItemIndex);
    btnEditorExpertsConfig.Enabled := ExpertIsConfigurable(ee);
    mmoEditorExpertsHelp.Text      := ExpertHelp(ee)
  end;
end;

procedure TPrefForm.btnEditorExpertsConfigClick(Sender: TObject);
var
  ee : TEditorExpert;
begin
  if lbEditorExperts.ItemIndex <> -1 then
  begin
    ee := TEditorExpert(lbEditorExperts.ItemIndex);
    case ee of
      eeCommentCode : btnCommentConfigClick(Sender);
      eeAlignLines  : btnAlignLinesConfigClick(Sender);
      eeGrepSearch  : btnGrepSearchConfigClick(Sender);
    end;
  end;
end;

procedure TPrefForm.btnEditorExpertsShortcutClick(Sender: TObject);
var
  ee : TEditorExpert;
  E : TfmEditorShortcut;
  oldIdx : integer;
begin
  if lbEditorExperts.ItemIndex <> -1 then
  begin
    ee := TEditorExpert(lbEditorExperts.ItemIndex);
    E := TfmEditorShortcut.Create(nil);
    try
      E.gbxShortCut.Caption := ExpertName(ee);
      E.ShortCut := EditorExpertShortcuts[ee];
      if E.ShowModal = mrOK then
      begin
        EditorExpertShortcuts[ee] := E.ShortCut;
        oldIdx := lbEditorExperts.ItemIndex;
        try
          PopulateEditorExpertsList(lbEditorExperts.Items);
        finally
          lbEditorExperts.ItemIndex := oldIdx;
        end;
      end;
    finally
      E.Free;
    end;
  end;
end;

procedure TPrefForm.UpdateEditorExperts;
begin
  PopulateEditorExpertsList(lbEditorExperts.Items);
  if lbEditorExperts.Items.Count > 0 then
  begin
    lbEditorExperts.ItemIndex := 0;
    lbEditorExpertsClick(Self);
  end;
end;

procedure TPrefForm.SetHelpContext;
begin
  case pagPrefs.ActivePageIndex of
    0 : HelpContext := 110; // general
    1 : HelpContext := 120; // editor
    2 : HelpContext := 130; // compiler
    3 : HelpContext := 140; // api
    4 : HelpContext := 150; // startup
    5 : HelpContext := 160; // templates
    6 : HelpContext := 170; // macros
    7 : HelpContext := 180; // color
    8 : HelpContext := 190; // options
  else
    HelpContext := 11;
  end;
end;

initialization
{$IFDEF FPC}
  {$i Preferences.lrs}

  VerCompanyName      := 'JoCar Consulting';
  VerFileDescription  := '';
  VerFileVersion      := '3.3.8.5';
  VerInternalName     := 'BricxCC';
  VerLegalCopyright   := 'Copyright (c) 2010, John Hansen';
  VerOriginalFileName := 'BricxCC';
  VerProductName      := 'BricxCC';
  VerProductVersion   := '3.3';
  VerComments         := '';
{$ENDIF}
  fVersion := GetVersionInfo(Application.ExeName).ProductVersion;

  cc_keywords := CreateSortedStringList(true);
  cc_commands := CreateSortedStringList(true);
  cc_constants := CreateSortedStringList(true);

finalization
  FreeAndNil(cc_keywords);
  FreeAndNil(cc_commands);
  FreeAndNil(cc_constants);

end.
