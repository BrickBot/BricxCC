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

{$I bricxcc.inc}

interface

uses
  Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ComCtrls, ExtCtrls, Buttons, ColorGrd, Registry,
  SynEditHighlighter, SynHighlighterNQC, SynEdit, SynEditKeyCmds,
  SynHighlighterForth, SynHighlighterCpp, SynHighlighterJava,
  SynHighlighterCS, SynHighlighterMindScript, SynHighlighterLua,
  SynHighlighterLASM, SynHighlighterPas, uParseCommon, uNewHotKey,
  uMiscDefines, SynHighlighterNBC, uOfficeComp,
  SynHighlighterRuby, SynHighlighterNPG, SynHighlighterRS,
  SynHighlighterROPS, DirectoryEdit, uSpin;

type
  TTransferItem = class
  private
  protected
    FWorkingDir: string;
    FTitle: string;
    FParams: string;
    FPath: string;
    fWait: boolean;
    fClose: boolean;
    fExtension: string;
    fRestrict : boolean;
  public
    procedure Assign(TI : TTransferItem);
    property Title : string read FTitle write FTitle;
    property Path : string read FPath write FPath;
    property WorkingDir : string read FWorkingDir write FWorkingDir;
    property Params : string read FParams write FParams;
    property Wait : boolean read fWait write fWait;
    property Close : boolean read fClose write fClose;
    property Extension : string read fExtension write fExtension;
    property Restrict : boolean read fRestrict write fRestrict;
  end;

  TActiveHighlighterReason = (ahColors, ahTemplates);

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
    Label2: TLabel;
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
    edtMaxRecent: TSpinEdit;
    edtFirmwareChunkSize: TSpinEdit;
    edtWaitTime: TSpinEdit;
    edtMaxLeftChar: TSpinEdit;
    inpTabWidth: TSpinEdit;
    inpMaxUndo: TSpinEdit;
    inpExtraLineSpacing: TSpinEdit;
    inpRightEdge: TSpinEdit;
    edtCompilerTimeout: TSpinEdit;
    edtMaxErrors: TSpinEdit;
    edtConsoleReadFirstTimeout: TSpinEdit;
    edtConsoleReadICTimeout: TSpinEdit;
    edtConsoleWriteTimeout: TSpinEdit;
    edtICDelay: TSpinEdit;
    edtILDelay: TSpinEdit;
    inpRightOffset: TSpinEdit;
    inpLeftOffset: TSpinEdit;
    inpDigitCount: TSpinEdit;
    inpGutterWidth: TSpinEdit;
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
    GroupBox1: TGroupBox;
    radRICDecompScript: TRadioButton;
    radRICDecompArray: TRadioButton;
    Label6: TLabel;
    edtRICDecompArrayFmt: TEdit;
    shtExperts: TTabSheet;
    btnCommentConfig: TButton;
    lblBlockComment: TLabel;
    lblAlignLines: TLabel;
    btnAlignLinesConfig: TButton;
    Button1: TButton;
    Label7: TLabel;
    Button2: TButton;
    Label8: TLabel;
    chkIncludeSrcInList: TCheckBox;
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
  private
    { Private declarations }
    cc_keywords: TStringList;
    cc_commands: TStringList;
    cc_constants: TStringList;
    cc_nxc_keywords: TStringList;
    cc_nxc_commands: TStringList;
    cc_nxc_constants: TStringList;
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
    SynNXCSyn: TSynNQCSyn;
    SynRSSyn: TSynRSSyn;
    SynROPSSyn: TSynROPSSyn;
    SynLASMSyn: TSynLASMSyn;
    SynLuaSyn: TSynLuaSyn;
    SynRubySyn: TSynRubySyn;
    SynPasSyn: TSynPasSyn;
    SynNBCSyn: TSynNBCSyn;
    SynCSSyn: TSynCSSyn;
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
    function CreateSortedStringList : TStringList;
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
    NewTemplatesList: TSynEdit;
    SynEditColors: TSynEdit;
    property ColorsChanged : boolean read fColorsChanged;
    property Keystrokes : TSynEditKeyStrokes read fKeystrokes write SetKeystrokes;
    property CodeTemplates : TStrings read fCodeTemplates write SetCodeTemplates;
    property PreferredLanguage : Integer read GetPrefLang write SetPrefLang;
  end;

var
  PrefForm: TPrefForm;
  ProgramDir : string;
  CodeExplorerSettings : TCodeExplorerProperties;
  ProcedureListSettings : TProcedureListProperties;
  AddMenuItemsToNewMenu : boolean = True;

{Remote settings}
var
  RemotePrograms : TProgramNames;

{Joystick settings}
var LeftRight:boolean;              // Whether in left-right mode
    LeftMotor:integer;              // the left motor
    RightMotor:integer;             // the right motor
    LeftReversed:boolean;           // whether left must be reversed
    RightReversed:boolean;          // whether right must be reversed
    MotorSpeed:integer;             // speed of the motors
    RCXTasks:boolean;               // use tasks or scripts

{Macros}
const
  MAXMACRO = 200;
var
  macros:array[1..MAXMACRO] of string;
  macronumb:integer;
  MacrosChanged:boolean;

{Templates}
const
  NUM_LANGS = 15;
  LANG_CS = 0;
  LANG_CPP = 1;
  LANG_PAS = 2;

type
  TemplateArray = array[0..NUM_LANGS-1] of array of string;
  TemplateCount = array[0..NUM_LANGS-1] of integer;

var
  templates : TemplateArray;
  templatenumb : TemplateCount;
  ShowTemplateForm:boolean;
  ShowTemplatePopup:boolean;
  TemplatesChanged:boolean;
  TemplatesUseDblClick : Boolean;
  TemplateLanguageName : string = 'NQC';

{Recent Files}
procedure ShowRecentFiles(parent : TOfficeMenuItem; handler : TNotifyEvent);
function GetRecentFileName(i : Byte) : string;
procedure AddRecentFile(str:string);

procedure FillLockedProgramArray;

{Startup}
const
  K_MSTOSEC = 1000;
  K_DEFAULT_PING_TIMEOUT = 400;
  K_DEFAULT_TOWER_EXISTS_SLEEP = 30;

var
  MainWindowState : integer; // main form window state (normal, minimized, maximized)
  LocalCompilerTimeout : integer;
  RunningAsCOMServer : Boolean = False;
  CompilerDebug : boolean;
  FBAlwaysPrompt : Boolean;
  StandardFirmwareDefault : Boolean;
  UseBluetoothDefault : Boolean;
  FirmwareTypeDefault : TFirmwareType;
  FirmwareFast : boolean;
  FirmwareComp : boolean;
  QuietFirmware : Boolean;
  DroppedRecent : Boolean;
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
  CurrentProgramSlot : Integer = 0;
  ParseTimeout : Integer;
  PingTimeout : Word = K_DEFAULT_PING_TIMEOUT;
  TowerExistsSleep : Word = K_DEFAULT_TOWER_EXISTS_SLEEP;
  WatchPoints : Byte = 10;
  MaxRecent : Byte = 4;
  CurrentLNPAddress : Integer = 0;
  CurrentLNPPort : Integer = 0;

{Editor}
var
  ColorsChanged : boolean;   // Whether color scheme was changed
  ColorCoding:boolean;       // Whether to use color coding
  ColorCodingChanged:boolean;// Whether ColorCoding was changed
  FontName:string;           // Name of the font
  FontSize:integer;          // Size of the font
  FontChanged:boolean;       // Whether the font changed
  AutoIndentCode:boolean;    // Whether to automatically indent code
  MacrosOn:boolean;          // Whether macros can be used
  RICDecompAsData:boolean;
  RICDecompNameFormat : string;

  HideSelection : boolean;
  ScrollPastEOL : boolean;
  HalfPageScroll : boolean;
  DragAndDropEditing : boolean;
  AltSetsSelMode : Boolean;
  MoveCursorRight : Boolean;
  KeepBlanks : Boolean;
  UseSmartTabs : Boolean;
  EnhanceHomeKey : Boolean;
  GroupUndo : Boolean;
  TabWidth : integer;
  MaxUndo : integer;
  MaxLeftChar : integer;
  ExtraLineSpacing : integer;
  RightEdgePosition : integer;
  RightEdgeColor : TColor;
  ScrollBars : integer;
  EditorColor : TColor;
  SelectionForeground : TColor;
  SelectionBackground : TColor;
  StructureColor : TColor;
  ActiveLineColor : TColor;
  AppIsClosing : Boolean;
  TabIndent : Boolean;
  ConvertTabs : Boolean;
  ShowSpecialChars : Boolean;
  HighlightCurLine : Boolean;
  KeepCaretX : Boolean;
  AutoMaxLeft : Boolean;

{ Gutter }
var
  GutterColor : TColor;
  GutterWidth : integer;
  DigitCount : integer;
  LeftOffset : integer;
  RightOffset : integer;
  ShowLineNumbers : boolean;
  ShowLeadingZeros : boolean;
  ZeroStart : boolean;
  AutoSizeGutter : boolean;
  GutterVisible : boolean;
  UseFontStyle : boolean;
  SelectOnClick : boolean;

{ Other Shortcuts }
var
  CodeCompShortCut : TShortCut;
  ParamCompShortCut : TShortCut;
  RecMacroShortCut : TShortCut;
  PlayMacroShortCut : TShortCut;

{General}
var
  SaveWindowPos:boolean;     // Whether to save window positions
  ShowRecent:boolean;        // Whether to show recent files
  ShowRecentChanged:boolean; // Whether ShowRecent was changed
  SaveBackup:boolean;        // Whether to save backups of existing files
  ShowStatusbar:boolean;     // Whether to show the statusbar
  ShowCompilerStatus : boolean;
  AutoSaveFiles : Boolean;
  AutoSaveDesktop : Boolean;
  SaveBinaryOutput : Boolean;
  IncludeSrcInList : Boolean;
  PreferredLanguage : Integer;
  CompilerSwitches : string;
  NQCSwitches : string;
  LCCSwitches : string;
  NBCSwitches : string;
  CPPSwitches : string;
  JavaSwitches : string;
  NBCOptLevel : byte;
  NBCMaxErrors : word;
  DefaultMacroLibrary : string;
  NQCIncludePath : string;
  OldNQCIncPaths : string;
  LCCIncludePath : string;
  OldLCCIncPaths : string;
  NBCIncludePath : string;
  OldNBCIncPaths : string;
  LockToolbars : Boolean;
  MaxEditWindows : Boolean;
  MultiFormatCopy : Boolean;
  CygwinDir :  string;
  BrickOSRoot :  string;
  BrickOSMakefileTemplate : string;
  PascalCompilerPrefix : string;
  KeepBrickOSMakefile : Boolean;
  LeJOSMakefileTemplate : string;
  KeepLeJOSMakefile : Boolean;
  NQCExePath : string;
  LCCExePath : string;
  NBCExePath : string;
  UseInternalNBC : Boolean;
  NXT2Firmware : Boolean;
  EnhancedFirmware : Boolean;
  IgnoreSysFiles : Boolean;
  JavaCompilerPath : string;
  LeJOSRoot :  string;
  // forth console settings
  ShowAllConsoleOutput : Boolean;
  StopScriptDLOnErrors : Boolean;
  StripScriptComments : Boolean;
  SkipBlankScriptLines : Boolean;
  SyntaxHighlightConsole : Boolean;
  ConsoleOutputSeparate : Boolean;
  ShowConsoleLineNumbers : Boolean;
  ConsoleCodeCompletion : Boolean;
  ConsoleICDelay : Word;
  ConsoleILDelay : Word;
  ConsoleUSBFirstTimeout : Word;
  ConsoleUSBICTimeout : Word;
  ConsoleUSBWriteTimeout : Word;


function  PreferredLanguageName : string;
procedure DeleteMainKey;
procedure SaveDesktopMiscToFile(aFilename : string);
procedure LoadDesktopMiscFromFile(aFilename : string);
procedure SaveWindowValuesToFile(aFilename : string);
procedure LoadWindowValuesFromFile(aFilename : string);
procedure UpgradeRegistry;
procedure RegisterApp;
procedure SetToolbarDragging(bAuto : Boolean);
procedure RestoreToolbars;
procedure SaveToolbars;
procedure SaveTemplateTree;
procedure RestoreTemplateTree;
function GetHighlighterForFile(AFileName: string): TSynCustomHighlighter;

var
  gbSearchBackwards: boolean;
  gbSearchCaseSensitive: boolean;
  gbSearchFromCaret: boolean;
  gbSearchSelectionOnly: boolean;
  gbSearchTextAtCaret: boolean = true;
  gbSearchWholeWords: boolean;
  gbSearchRegex: boolean;

  gsSearchText: string;
  gsSearchTextHistory: string;
  gsReplaceText: string;
  gsReplaceTextHistory: string;

procedure UpdateTransferList(aSrcList, aDestList : TList);
function CompXferList : Tlist;
function TransferList : Tlist;
function PrecompileSteps : Tlist;
function PostcompileSteps : Tlist;
function Highlighters : TStringList;
procedure CenterForm(const Form: TCustomForm);
procedure EnsureFormVisible(const Form: TCustomForm);
function GetUseMDIMode : Boolean;

function DefaultPath : string;
function NQCPath : string;
function LCCPath : string;
function NBCPath : string;

{$IFNDEF VER_D7_UP}
type
  EOSError = class(EWin32Error);

function IncludeTrailingPathDelimiter(const S: string): string;
function ExcludeTrailingPathDelimiter(const S: string): string;

{$ENDIF}

const
  K_PASCAL_PREFIX = '/usr/local/bin/h8300-hitachi-hms-';
  K_PASCAL_TAIL =
    'LIBS=-loogpc -lgpc -lc -lmint -lfloat -lc++' + #13#10 +
    'PFLAGS=$(CFLAGS) --extended-syntax --unit-path=$(BRICKOS_ROOT)/lib/p --automake' + #13#10 +
    #13#10 +
    'PTOOLPREFIX=' + K_PASCAL_PREFIX + #13#10 +
    'GPC=$(PTOOLPREFIX)gpc' + #13#10 +
    #13#10 +
    '# how to compile pas source' + #13#10 +
    '%.o: %.pas' + #13#10 +
    #9'$(GPC) $(PFLAGS) -c $< -o $@' + #13#10 +
    #13#10 +
    '# how to generate an assembly listing of pascal source' + #13#10 +
    '%.s: %.pas' + #13#10 +
    #9'$(GPC) $(PFLAGS) -c $< -S' + #13#10;


implementation

uses
  Windows, SysUtils, MainUnit, Diagnose, Controller, Watch, Piano, ConstructUnit,
  JoystickUnit, DatalogUnit, MemoryUnit, CodeUnit, Editor,
  MessageUnit, SynEditKeyCmdsEditor, IniFiles, CodeTemplates,
  uVersionInfo, uHighlighterProcs, uExtensionDlg, {ActiveX, ShlObj,}
  uSetValues, uEEPROM, uNewWatch, uForthConsole, Themes,
  uSpirit, brick_common, Transfer, uNXTExplorer, uNXTController,
  uNXTExplorerSettings, uLocalizedStrings, uGuiUtils, uEditorExperts,
  uEECommentConfig, uEEAlignConfig;

{$R *.DFM}

var RecentFiles : array of string = nil;


var
  fHighlighters : TStringList;
  fCompXferList : TList;
  fTransferList : TList;
  fPrecompileSteps : TList;
  fPostcompileSteps : TList;
  StartupAction : Integer;     // Action to take at startup
  BrickType : Integer;           // RCX (0), Cybermaster (1), Scout (2), or RCX2 (3)
  COMPort : string;           // default COM port (''=automatic)
  CompilerTimeout : Integer;
  UseMDIMode : Boolean;

const
  K_PID           = 'BricxCC.1';
  K_MAINKEY       = '\Software\BricxCC';
  K_VERSION       = '3.3';
  K_OLDMAINKEY    = '\Software\RcxCC';
  K_OLDVERSION    = 'version 3.2';
  K_WINDOWSECTION = 'BricxCC_Windows';
  K_MISCSECTION   = 'BricxCC_Misc';
  K_DEF_MACRO_LIB = 'bricxcc.mlb';
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

const
{$IFDEF FPC}
  K_EDITOR_FONTNAME_DEFAULT = 'Courier 10 Pitch';
  K_EDITOR_COLOR_DEFAULT    = clWhite;
  K_SEL_FG_COLOR_DEFAULT    = clWhite;
  K_SEL_BG_COLOR_DEFAULT    = clNavy;
  K_ALINE_COLOR_DEFAULT     = clWhite;
  K_REDGE_COLOR_DEFAULT     = clSilver;
  K_STRUCT_COLOR_DEFAULT    = clNone;
  K_GUTTER_COLOR_DEFAULT    = clSilver;
  K_USEINTERNALNBC_DEFAULT  = True;
{$ELSE}
  K_EDITOR_FONTNAME_DEFAULT = 'Courier New';
  K_EDITOR_COLOR_DEFAULT    = clWindow;
  K_SEL_FG_COLOR_DEFAULT    = clHighlightText;
  K_SEL_BG_COLOR_DEFAULT    = clHighlight;
  K_ALINE_COLOR_DEFAULT     = clWindow;
  K_REDGE_COLOR_DEFAULT     = clSilver;
  K_STRUCT_COLOR_DEFAULT    = clNone;
  K_GUTTER_COLOR_DEFAULT    = clBtnFace;
  K_USEINTERNALNBC_DEFAULT  = False;
{$ENDIF}

var
  fMainKey : string = K_MAINKEY;
  fVersion : string = K_VERSION;
  fVerDbl : Double;

function ExePath : string;
begin
  Result := ExtractFilePath(Application.ExeName);
end;

procedure CenterForm(const Form: TCustomForm);
var
  Rect: TRect;
begin
  if Form = nil then
    Exit;

  SystemParametersInfo(SPI_GETWORKAREA, 0, @Rect, 0);

  with Form do
  begin
    SetBounds((Rect.Right - Rect.Left - Width) div 2,
      (Rect.Bottom - Rect.Top - Height) div 2, Width, Height);
  end;
end;

procedure EnsureFormVisible(const Form: TCustomForm);
var
  Rect: TRect;
begin
  Rect.Top := 0;
  Rect.Left := 0;
  Rect.Right := Screen.Width;
  Rect.Bottom := Screen.Height;
  SystemParametersInfo(SPI_GETWORKAREA, 0, @Rect, 0);
  if (Form.Left + Form.Width > Rect.Right) then
    Form.Left := Form.Left - ((Form.Left + Form.Width) - Rect.Right);
  if (Form.Top + Form.Height > Rect.Bottom) then
    Form.Top := Form.Top - ((Form.Top + Form.Height) - Rect.Bottom);
  if Form.Left < 0 then
    Form.Left := 0;
  if Form.Top < 0 then
    Form.Top := 0;
end;

function DefaultPath : string;
begin
  case PreferredLanguage of
    1 : Result := LCCPath;
    2 : Result := LCCPath;
    3 : Result := NBCPath;
    4 : Result := NBCPath;
  else
    Result := NQCPath;
  end;
end;

function NQCPath : string;
begin
  if Trim(NQCExePath) <> '' then
    Result := IncludeTrailingPathDelimiter(NQCExePath);
  Result := Result + 'nqc.exe';
end;

function LCCPath : string;
begin
  if Trim(LCCExePath) <> '' then
    Result := IncludeTrailingPathDelimiter(LCCExePath);
  Result := Result + 'lcc32.exe';
end;

function NBCPath : string;
begin
  if Trim(NBCExePath) <> '' then
    Result := IncludeTrailingPathDelimiter(NBCExePath);
  Result := Result + 'nbc.exe';
end;

function Highlighters : TStringList;
begin
  if not Assigned(fHighlighters) then
    fHighlighters := TStringList.Create;
  Result := fHighlighters;
end;

function GetHighlighterForFile(AFileName: string): TSynCustomHighlighter;
begin
  if AFileName <> '' then
    Result := GetHighlighterFromFileExt(fHighlighters, ExtractFileExt(AFileName))
  else
    Result := nil;
end;

function CompXferList : Tlist;
begin
  if not Assigned(fCompXferList) then
    fCompXferList := TList.Create;
  result := fCompXferList;
end;

function TransferList : Tlist;
begin
  if not Assigned(fTransferList) then
    fTransferList := TList.Create;
  result := fTransferList;
end;

function PrecompileSteps : Tlist;
begin
  if not Assigned(fPrecompileSteps) then
    fPrecompileSteps := TList.Create;
  result := fPrecompileSteps;
end;

function PostcompileSteps : Tlist;
begin
  if not Assigned(fPostcompileSteps) then
    fPostcompileSteps := TList.Create;
  result := fPostcompileSteps;
end;

function BoolToStr(aVal : boolean) : string;
begin
  Result := 'F';
  if aVal then
    Result := 'T';
end;

function StrToBool(aStr : string) : boolean;
var
  U : string;
begin
  U := UpperCase(aStr);
  result := (U = 'T') or (U = 'TRUE');
end;

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

procedure RestoreTemplateTree;
var
  R : TRegistry;
begin
  if Assigned(ConstructForm) then
  begin
    R := TRegistry.Create;
    try
      R.RootKey := HKEY_CURRENT_USER;
      if R.OpenKey(fMainKey+'\'+fVersion+'\TemplateTree', false) then
      begin
        ConstructForm.tsvTemplates.RestoreFromRegistry(R);
      end;
    finally
      R.Free;
    end;
  end;
end;

procedure SaveTemplateTree;
var
  R : TRegistry;
  keyName : string;
begin
  if Assigned(ConstructForm) then
  begin
    R := TRegistry.Create;
    try
      R.RootKey := HKEY_CURRENT_USER;
      keyName := fMainKey+'\'+fVersion+'\TemplateTree';
      if R.OpenKey(keyName, true) then
      begin
        ConstructForm.tsvTemplates.SaveToRegistry(R);
      end;
    finally
      R.Free;
    end;
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
    theFile.WriteInteger(K_WINDOWSECTION, 'XForthConsoleWindow', frmForthConsole.Left);
    theFile.WriteInteger(K_WINDOWSECTION, 'YForthConsoleWindow', frmForthConsole.Top);
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
    frmForthConsole.Left := theFile.ReadInteger(K_WINDOWSECTION, 'XForthConsoleWindow', frmForthConsole.Left);
    frmForthConsole.Top  := theFile.ReadInteger(K_WINDOWSECTION, 'YForthConsoleWindow', frmForthConsole.Top);
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
  Registry stuff
 **************************************************}

procedure DeleteMainKey;
var
  tmpReg : TRegistry;
begin
  tmpReg := TRegistry.Create;
  try
    tmpReg.DeleteKey(fMainKey + '\' + fVersion);
  finally
    tmpReg.Free;
  end;
end;

procedure Reg_OpenKey(r : TRegistry; name:string);
begin
  {Opens the registry key}
  r.OpenKey(fMainKey+'\'+fVersion+'\'+name,true);
end;

procedure Reg_DeleteKey(r : TRegistry; name:string);
begin
  {Deletes the registry key}
  r.DeleteKey(fMainKey+'\'+fVersion+'\'+name);
end;

function Reg_KeyExists(r : TRegistry; name:string):boolean;
begin
  Result := r.KeyExists(fMainKey+'\'+fVersion+'\'+name);
end;

{-- Booleans --}

function Reg_ReadBool(r: TRegistry; name:string; def:boolean):boolean;
begin
  {Read a boolean value from the registry. Returns the
   default when it does not exist.}
  if r.ValueExists(name) then
    Result := r.ReadBool(name)
  else
    Result := def;
end;

{-- Integers --}

function Reg_ReadInteger(r: TRegistry; name:string; def:integer):integer;
begin
  {Read a integer value from the registry. Returns the
   default when it does not exist.}
  if r.ValueExists(name) then
    Result := r.ReadInteger(name)
  else
    Result := def;
end;

{-- Strings --}

function Reg_ReadString(r: TRegistry; name:string; def:string):string;
begin
  {Read a string value from the registry. Returns the
   default when it does not exist.}
  if r.ValueExists(name) then
    Result := r.ReadString(name)
  else
    Result := def;
end;

{-- Styles --}

procedure Reg_WriteStyle(r : TRegistry; name:string; val:TFontStyles);
var
  tt : integer;
begin
{Writes a style value to the registry}
  tt := 0;
  if fsBold in val then tt := tt+1;
  if fsItalic in val then tt := tt+2;
  r.WriteInteger(name,tt);
end;

function Reg_ReadStyle(r : TRegistry; name:string; def:TFontStyles):TFontStyles;
var
  tt : integer;
begin
  {Read a style value from the registry. Returns the default when it does not exist.}
  if r.ValueExists(name) then
  begin
    tt := r.ReadInteger(name);
    Result := [];
    if (tt and 1) > 0 then Result := Result + [fsBold];
    if (tt and 2) > 0 then Result := Result + [fsItalic];
  end
  else
    Result := def;
end;

{-- Colors --}

procedure Reg_WriteColor(r : TRegistry; name:string; val:TColor);
begin
  {Writes a color value to the registry}
  r.WriteInteger(name,integer(val));
end;

function Reg_ReadColor(r : TRegistry; name:string; def:TColor) : TColor;
begin
//  Read a color value from the registry. Returns the default when it does not exist.
  if r.ValueExists(name) then
  begin
    Result := TColor(r.ReadInteger(name));
{$IFDEF VER_D7_UP}
    // handle D7/D5 differences
    //  clSystemColor = $FF000000 in D7, $80000000 in D5
    if (Result and not $80000000) in [0..COLOR_ENDCOLORS] then
      Result := (Result and not $80000000) or TColor(clSystemColor);
{$ENDIF}
  end
  else
    Result := def;
end;

{**************************************************
  Reading and writing the registry
 **************************************************}

function MyIntToStr(val:integer):string;
begin
//  Result := Format('%3.3d', [val]);
  Result := IntToStr(val div 100) +
            IntToStr((val mod 100) div 10) +
            IntToStr(val mod 10);
end;

{Macros}

{Loads the macro values from the registry}
procedure LoadMacroValues(reg : TRegistry);
var
  i:integer;
  SL : TStringList;
begin
  if not Reg_KeyExists(reg, 'Macros') then
  begin
    if FileExists(ProgramDir+'Default\macros.txt') then
    begin
      SL := TStringList.Create;
      try
        SL.LoadFromFile(ProgramDir+'Default\macros.txt');
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
    while reg.ValueExists('Macro'+MyIntToStr(i)) do
    begin
      macros[i] := Reg_ReadString(reg, 'Macro'+MyIntToStr(i),'');
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
    reg.WriteString('Macro'+MyIntToStr(i),macros[i]);
  reg.CloseKey;
end;

procedure ResetMacroValues(reg : TRegistry);
{Resets the macro values to default}
begin
  Reg_DeleteKey(reg, 'Macros');
  LoadMacroValues(reg);
end;

{Templates}

function LanguageIndexToName(const aLang : integer) : string;
begin
  if (aLang >= 0) and (aLang < Highlighters.Count) then
    Result := Highlighters[aLang]
  else
    Result := MyIntToStr(aLang);
end;

{Loads the template values from the registry}
procedure LoadTemplateValues(const aLang : integer; reg : TRegistry);
var
  i, idx : integer;
  tmpStr, valName, fName : String;
  SL : TStringList;
begin
  if not Reg_KeyExists(reg, 'Templates') then
  begin
    fName := ProgramDir+'Default\'+LanguageIndexToName(aLang)+'_templates.txt';
    if FileExists(fName) then
    begin
      SL := TStringList.Create;
      try
        SL.LoadFromFile(fName);
        templatenumb[aLang] := SL.Count;
        SetLength(templates[aLang], templatenumb[aLang]);
        idx := 0;
        for i := 0 to SL.Count - 1 do
        begin
          inc(idx);
          tmpStr := SL[i];
          if (idx = 1) and
             (tmpStr <> '') and not (tmpStr[1] in ['-', '|']) then
          begin
            // first line should be a '-' or '|' line.  If it isn't then add one
            templates[aLang][idx-1] := '-';
            inc(idx);
          end;
          templates[aLang][idx-1] := tmpStr;
        end;
      finally
        SL.Free;
      end;
    end;
//    if Assigned(ConstructForm) then
//      ConstructForm.CreateConstructPanel;
  end
  else
  begin
    Reg_OpenKey(reg, 'Templates');

    templatenumb[aLang] := 0;
    SL := TStringList.Create;
    try
      reg.GetValueNames(SL);
      for i := 0 to SL.Count - 1 do
      begin
        if Pos(MyIntToStr(aLang)+'_Template', SL[i]) = 1 then
          inc(templatenumb[aLang]);
      end;
    finally
      SL.Free;
    end;
    SetLength(templates[aLang], templatenumb[aLang]);
    i := 1;
    idx := 1;
    valName := MyIntToStr(aLang)+'_Template'+MyIntToStr(idx);
    while reg.ValueExists(valName) do
    begin
      tmpStr := Reg_ReadString(reg, valName, '');
      if (i = 1) and
         (tmpStr <> '') and not (tmpStr[1] in ['-', '|']) then
      begin
        // first line should be a '-' or '|' line.  If it isn't then add one
        templates[aLang][i-1] := '-';
        inc(i);
      end;
      templates[aLang][i-1] := tmpStr;
      inc(idx);
      inc(i);
      valName := MyIntToStr(aLang)+'_Template'+MyIntToStr(idx);
    end;
    templatenumb[aLang] := i-1;
    reg.CloseKey;
  end;
end;

{Saves the template values to the registry}
procedure SaveTemplateValues(const aLang : integer; reg : TRegistry);
var
  i : integer;
begin
  // only delete the key on the very first language
  if aLang = 0 then
    Reg_DeleteKey(reg, 'Templates');
  Reg_OpenKey(reg, 'Templates');
  for i:=1 to templatenumb[aLang] do
    reg.WriteString(MyIntToStr(aLang)+'_Template'+MyIntToStr(i),templates[aLang][i-1]);
  reg.CloseKey;
end;

{Resets the template values to default}
procedure ResetTemplateValues(reg : TRegistry);
var
  i : integer;
begin
  Reg_DeleteKey(reg, 'Templates');
  for i := 0 to NUM_LANGS - 1 do
    LoadTemplateValues(i, reg);
end;

procedure PutValuesInSyntaxHighlighter;
begin
  if not Assigned(PrefForm) then Exit;
  // NQC API
  // keywords
  PrefForm.SynNQCSyn.KeyWords.Assign(PrefForm.cc_keywords);
  // commands
  PrefForm.SynNQCSyn.Commands.Assign(PrefForm.cc_commands);
  // constants
  PrefForm.SynNQCSyn.Constants.Assign(PrefForm.cc_constants);
  // now copy to main form
  MainForm.SynNQCSyn.KeyWords.Assign(PrefForm.SynNQCSyn.KeyWords);
  MainForm.SynNQCSyn.Commands.Assign(PrefForm.SynNQCSyn.Commands);
  MainForm.SynNQCSyn.Constants.Assign(PrefForm.SynNQCSyn.Constants);
  // NXC API
  // nxc keywords
  PrefForm.SynNXCSyn.KeyWords.Assign(PrefForm.cc_nxc_keywords);
  // commands
  PrefForm.SynNXCSyn.Commands.Assign(PrefForm.cc_nxc_commands);
  // constants
  PrefForm.SynNXCSyn.Constants.Assign(PrefForm.cc_nxc_constants);
  // now copy to main form
  MainForm.SynNXCSyn.KeyWords.Assign(PrefForm.SynNXCSyn.KeyWords);
  MainForm.SynNXCSyn.Commands.Assign(PrefForm.SynNXCSyn.Commands);
  MainForm.SynNXCSyn.Constants.Assign(PrefForm.SynNXCSyn.Constants);
end;

{Keywords for Colorcoding}

procedure LoadAPIValues(reg : TRegistry);
var
  i:integer;
  SL : TStringList;
begin
  {first we populate our dynamic arrays from the highlighter if it exists}
  if Assigned(PrefForm) then
  begin
    // nqc
    PrefForm.cc_keywords.Assign(PrefForm.SynNQCSyn.KeyWords);
    PrefForm.cc_commands.Assign(PrefForm.SynNQCSyn.Commands);
    PrefForm.cc_constants.Assign(PrefForm.SynNQCSyn.Constants);
    // nxc
    PrefForm.cc_nxc_keywords.Assign(PrefForm.SynNXCSyn.KeyWords);
    PrefForm.cc_nxc_commands.Assign(PrefForm.SynNXCSyn.Commands);
    PrefForm.cc_nxc_constants.Assign(PrefForm.SynNXCSyn.Constants);
  end;
  {Loads the keyword values from the registry}
  if not Reg_KeyExists(reg, 'Keywords') then
  begin
    // no registry key so load from file instead
    SL := TStringList.Create;
    try
      if FileExists(ProgramDir+'Default\keywords.txt') then
      begin
        PrefForm.cc_keywords.LoadFromFile(ProgramDir+'Default\keywords.txt');
      end;

      if FileExists(ProgramDir+'Default\commands.txt') then
      begin
        PrefForm.cc_commands.LoadFromFile(ProgramDir+'Default\commands.txt');
      end;

      if FileExists(ProgramDir+'Default\constants.txt') then
      begin
        PrefForm.cc_constants.LoadFromFile(ProgramDir+'Default\constants.txt');
      end;
    finally
      SL.Free;
    end;
  end
  else
  begin
    Reg_OpenKey(reg, 'Keywords');
    try
      i:=1;
      if reg.ValueExists('Keyword'+MyIntToStr(i)) then
      begin
        // old style
        PrefForm.cc_keywords.Clear;
        while reg.ValueExists('Keyword'+MyIntToStr(i)) do
        begin
          PrefForm.cc_keywords.Add(Reg_ReadString(reg, 'Keyword'+MyIntToStr(i),''));
          reg.DeleteValue('Keyword'+MyIntToStr(i));
          i := i+1;
        end;
      end
      else
      begin
        // new style
        PrefForm.cc_keywords.Text := Reg_ReadString(reg, 'Keywords', '');
      end;
    finally
      reg.CloseKey;
    end;

    Reg_OpenKey(reg, 'Commands');
    try
      i:=1;
      if reg.ValueExists('Command'+MyIntToStr(i)) then
      begin
        // old style
        PrefForm.cc_commands.Clear;
        while reg.ValueExists('Command'+MyIntToStr(i)) do
        begin
          PrefForm.cc_commands.Add(Reg_ReadString(reg, 'Command'+MyIntToStr(i),''));
          reg.DeleteValue('Command'+MyIntToStr(i));
          i := i+1;
        end;
      end
      else
      begin
        // new style
        PrefForm.cc_commands.Text := Reg_ReadString(reg, 'Commands', '');
      end;
    finally
      reg.CloseKey;
    end;

    Reg_OpenKey(reg, 'Constants');
    try
      i:=1;
      if reg.ValueExists('Constant'+MyIntToStr(i)) then
      begin
        // old style
        PrefForm.cc_constants.Clear;
        while reg.ValueExists('Constant'+MyIntToStr(i)) do
        begin
          PrefForm.cc_constants.Add(Reg_ReadString(reg, 'Constant'+MyIntToStr(i),''));
          reg.DeleteValue('Constant'+MyIntToStr(i));
          i := i+1;
        end;
      end
      else
      begin
        // new style
        PrefForm.cc_constants.Text := Reg_ReadString(reg, 'Constants', '');
      end;
    finally
      reg.CloseKey;
    end;
  end;
  {Loads the NXC keyword values from the registry}
  if not Reg_KeyExists(reg, 'NXC_Keywords') then
  begin
    // no registry key so load from file instead
    SL := TStringList.Create;
    try
      if FileExists(ProgramDir+'Default\nxc_keywords.txt') then
      begin
        PrefForm.cc_nxc_keywords.LoadFromFile(ProgramDir+'Default\nxc_keywords.txt');
      end;

      if FileExists(ProgramDir+'Default\nxc_commands.txt') then
      begin
        PrefForm.cc_nxc_commands.LoadFromFile(ProgramDir+'Default\nxc_commands.txt');
      end;

      if FileExists(ProgramDir+'Default\nxc_constants.txt') then
      begin
        PrefForm.cc_nxc_constants.LoadFromFile(ProgramDir+'Default\nxc_constants.txt');
      end;
    finally
      SL.Free;
    end;
  end
  else
  begin
    Reg_OpenKey(reg, 'NXC_Keywords');
    try
      PrefForm.cc_nxc_keywords.Text := Reg_ReadString(reg, 'Keywords', '');
    finally
      reg.CloseKey;
    end;

    Reg_OpenKey(reg, 'NXC_Commands');
    try
      PrefForm.cc_nxc_commands.Text := Reg_ReadString(reg, 'Commands', '');
    finally
      reg.CloseKey;
    end;

    Reg_OpenKey(reg, 'NXC_Constants');
    try
      PrefForm.cc_nxc_constants.Text := Reg_ReadString(reg, 'Constants', '');
    finally
      reg.CloseKey;
    end;
  end;
  PutValuesInSyntaxHighlighter;
end;

procedure SaveAPIValues(reg : TRegistry);
begin
  {Saves the keyword values to the registry}
  // NQC
  Reg_DeleteKey(reg, 'Keywords');
  Reg_OpenKey(reg, 'Keywords');
  try
    reg.WriteString('Keywords',PrefForm.cc_keywords.Text);
  finally
    reg.CloseKey;
  end;

  Reg_DeleteKey(reg, 'Commands');
  Reg_OpenKey(reg, 'Commands');
  try
    reg.WriteString('Commands',PrefForm.cc_commands.Text);
  finally
    reg.CloseKey;
  end;

  Reg_DeleteKey(reg, 'Constants');
  Reg_OpenKey(reg, 'Constants');
  try
    reg.WriteString('Constants',PrefForm.cc_constants.Text);
  finally
    reg.CloseKey;
  end;
  // NXC
  Reg_DeleteKey(reg, 'NXC_Keywords');
  Reg_OpenKey(reg, 'NXC_Keywords');
  try
    reg.WriteString('Keywords', PrefForm.cc_nxc_keywords.Text);
  finally
    reg.CloseKey;
  end;

  Reg_DeleteKey(reg, 'NXC_Commands');
  Reg_OpenKey(reg, 'NXC_Commands');
  try
    reg.WriteString('Commands', PrefForm.cc_nxc_commands.Text);
  finally
    reg.CloseKey;
  end;

  Reg_DeleteKey(reg, 'NXC_Constants');
  Reg_OpenKey(reg, 'NXC_Constants');
  try
    reg.WriteString('Constants', PrefForm.cc_nxc_constants.Text);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetAPIValues(reg : TRegistry);
begin
{Resets the keyword values to default}
  Reg_DeleteKey(reg, 'Keywords');
  Reg_DeleteKey(reg, 'Commands');
  Reg_DeleteKey(reg, 'Constants');
  Reg_DeleteKey(reg, 'NXC_Keywords');
  Reg_DeleteKey(reg, 'NXC_Commands');
  Reg_DeleteKey(reg, 'NXC_Constants');
  LoadAPIValues(reg);
end;

{ The Recent Files Information}

function GetRecentFileName(i : Byte) : string;
begin
  Result := RecentFiles[i];
end;

procedure ShowRecentFiles(parent : TOfficeMenuItem; handler : TNotifyEvent);
var
  i, j, sepIdx : Integer;
  MI : TOfficeMenuItem;
  sep : TOfficeMenuItem;
begin
  for i := parent.Count - 1 downto 0 do
  begin
    MI := TOfficeMenuItem(parent.Items[i]);
    if Pos('Recent', MI.Name) = 1 then
      MI.Free;
  end;

  if not ShowRecent then Exit;

  sepIdx := -1;
  for i := parent.Count - 1 downto 0 do
  begin
    MI := TOfficeMenuItem(parent.Items[i]);
    if MI.Name = 'mniSepFiles' then
      sepIdx := i;
  end;
  // if we didn't find the separator then bail out
  if sepIdx = -1 then Exit;

  sep := TOfficeMenuItem(parent.Items[sepIdx]);
  sep.Visible := False;

  j := sepIdx + 1;
  for i := Low(RecentFiles) to High(RecentFiles) do
  begin
    if RecentFiles[i] <> '' then
    begin
      sep.Visible := True;
      // create new
      MI := TOfficeMenuItem.Create(parent);
      try
        MI.Name    := 'Recent' + IntToStr(i);
        MI.OnClick := handler;
        MI.Tag     := i;
        MI.Caption := '&' + IntToStr(i+1) + ' ' + RecentFiles[i];
        parent.Insert(j, MI);
      except
        MI.Free;
        raise;
      end;
      inc(j);
    end;
  end;
end;

procedure AddRecentFile(str:string);
var
  i, j : integer;
begin
  j := High(RecentFiles);
  for i := Low(RecentFiles) to High(RecentFiles) do
  begin
    if RecentFiles[i] = str then
    begin
      j := i;
      Break;
    end;
  end;
  // move all the items above j down one and leave the
  // items below it where they are
  for i := j downto Low(RecentFiles) + 1 do
    RecentFiles[i] := RecentFiles[i-1];
  RecentFiles[Low(RecentFiles)] := str;
end;

procedure LoadRecentValues(reg : TRegistry);
var
  i : integer;
begin
  {Loads the recent files values from the registry}
  Reg_OpenKey(reg, 'Recent Files');
  try
    for i := Low(RecentFiles) to High(RecentFiles) do
      RecentFiles[i] := Reg_ReadString(reg, 'RecentFiles'+MyIntToStr(i+1),'');
  finally
    reg.CloseKey;
  end;
end;

procedure SaveRecentValues(reg : TRegistry);
var
  i : integer;
begin
  {Saves the recent files values in the registry}
  Reg_DeleteKey(reg, 'Recent Files');
  Reg_OpenKey(reg, 'Recent Files');
  try
    for i := Low(RecentFiles) to High(RecentFiles) do
      reg.WriteString('RecentFiles'+MyIntToStr(i+1),RecentFiles[i]);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetRecentValues(reg : TRegistry);
begin
  {Resets the recent values to default}
  Reg_DeleteKey(reg, 'Recent Files');
  LoadRecentValues(reg);
end;

procedure SetMaxRecent(val : Byte);
begin
  if (val <> MaxRecent) or (RecentFiles = nil) then
  begin
    MaxRecent := val;
    SetLength(RecentFiles, MaxRecent);
  end;
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
    frmForthConsole.Left := Reg_ReadInteger(reg, 'XForthConsoleWindow', 190);
    frmForthConsole.Top  := Reg_ReadInteger(reg, 'YForthConsoleWindow', 190);
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
    reg.WriteInteger('XForthConsoleWindow', frmForthConsole.Left);
    reg.WriteInteger('YForthConsoleWindow', frmForthConsole.Top);
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

procedure LoadJoystickValues(reg : TRegistry);
begin
  {Loads the joystick values from the registry}
  Reg_OpenKey(reg, 'Joystick');
  try
    LeftRight     := Reg_ReadBool(reg, 'LeftRight', true);
    LeftMotor     := Reg_ReadInteger(reg, 'LeftMotor', 0);
    RightMotor    := Reg_ReadInteger(reg, 'RightMotor', 2);
    LeftReversed  := Reg_ReadBool(reg, 'LeftReversed', false);
    RightReversed := Reg_ReadBool(reg, 'RightReversed', false);
    MotorSpeed    := Reg_ReadInteger(reg, 'MotorSpeed', 4);
    RCXTasks      := Reg_ReadBool(reg, 'RCXTasks', true);
  finally
    reg.CloseKey;
  end;
end;

procedure SaveJoystickValues(reg : TRegistry);
{Saves the joystick values to the registry}
begin
  Reg_DeleteKey(reg, 'Joystick');
  Reg_OpenKey(reg, 'Joystick');
  try
    reg.WriteBool('LeftRight',LeftRight);
    reg.WriteInteger('LeftMotor',LeftMotor);
    reg.WriteInteger('RightMotor',RightMotor);
    reg.WriteBool('LeftReversed',LeftReversed);
    reg.WriteBool('RightReversed',RightReversed);
    reg.WriteInteger('MotorSpeed',MotorSpeed);
    reg.WriteBool('RCXTasks', RCXTasks);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetJoystickValues(reg : TRegistry);
begin
  {Resets the joystick values to default}
  Reg_DeleteKey(reg, 'Joystick');
  LoadJoystickValues(reg);
end;

procedure LoadRemoteValues(reg : TRegistry);
var
  i : integer;
begin
  Reg_OpenKey(reg, 'Remote');
  try
    for i := Low(RemotePrograms) to High(RemotePrograms)-1 do
      RemotePrograms[i] := Reg_ReadString(reg, 'Program'+IntToStr(i), Format('remote%d.rxe', [i]));
    i := High(RemotePrograms);
    RemotePrograms[i] := Reg_ReadString(reg, 'Program'+IntToStr(i), 'default');
  finally
    reg.CloseKey;
  end;
end;

procedure SaveRemoteValues(reg : TRegistry);
var
  i : integer;
begin
  Reg_DeleteKey(reg, 'Remote');
  Reg_OpenKey(reg, 'Remote');
  try
    for i := Low(RemotePrograms) to High(RemotePrograms) do
      reg.WriteString('Program'+IntToStr(i),RemotePrograms[i]);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetRemoteValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'Remote');
  LoadRemoteValues(reg);
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

procedure LoadGeneralValues(reg : TRegistry);
begin
  {Loads the general values from the registry}
  Reg_OpenKey(reg, 'General');
  try
    ShowRecent         := Reg_ReadBool(reg, 'ShowRecent',True);
    SaveBackup         := Reg_ReadBool(reg, 'SaveBackup',True);
    SaveWindowPos      := Reg_ReadBool(reg, 'SaveWindowPos',True);
    ShowStatusbar      := Reg_ReadBool(reg, 'ShowStatusbar',True);
    ShowCompilerStatus := Reg_ReadBool(reg, 'ShowCompilerStatus', False);
    AutoSaveFiles      := Reg_ReadBool(reg, 'AutoSaveFiles', False);
    AutoSaveDesktop    := Reg_ReadBool(reg, 'AutoSaveDesktop', False);
    SaveBinaryOutput   := Reg_ReadBool(reg, 'SaveBinaryOutput', False);
    LockToolbars       := Reg_ReadBool(reg, 'LockToolbars', True);
    MaxEditWindows     := Reg_ReadBool(reg, 'MaxEditWindows', False);
    MultiFormatCopy    := Reg_ReadBool(reg, 'MultiFormatCopy', False);
    UseMDIMode         := Reg_ReadBool(reg, 'UseMDIMode', True);
    QuietFirmware      := Reg_ReadBool(reg, 'QuietFirmware', False);
    DroppedRecent      := Reg_ReadBool(reg, 'DroppedRecent', False);
    FirmwareFast       := Reg_ReadBool(reg, 'FirmwareFast', False);
    FirmwareComp       := Reg_ReadBool(reg, 'FirmwareComp', False);
    FirmwareChunkSize  := Reg_ReadInteger(reg, 'FirmwareChunkSize', 200);
    DownloadWaitTime   := Reg_ReadInteger(reg, 'DownloadWaitTime', 100);
    TemplatesUseDblClick := Reg_ReadBool(reg, 'TemplatesUseDoubleClick', False);
    // NXT Explorer settings
    NXTFilesViewStyle  := TViewStyle(Reg_ReadInteger(reg, 'NXTFilesViewStyle', Ord(vsIcon)));
    PCFilesViewStyle   := TViewStyle(Reg_ReadInteger(reg, 'PCFilesViewStyle', Ord(vsIcon)));
    NXTExplorerMaskIndex := Reg_ReadInteger(reg, 'NXTExplorerMaskIndex', 0);
    NXTExplorerPath      := Reg_ReadString(reg, 'NXTExplorerPath', 'c:\');

    Prog1Locked        := Reg_ReadBool(reg, 'Prog1Locked', False);
    Prog2Locked        := Reg_ReadBool(reg, 'Prog2Locked', False);
    Prog3Locked        := Reg_ReadBool(reg, 'Prog3Locked', False);
    Prog4Locked        := Reg_ReadBool(reg, 'Prog4Locked', False);
    Prog5Locked        := Reg_ReadBool(reg, 'Prog5Locked', False);
    Prog6Locked        := Reg_ReadBool(reg, 'Prog6Locked', False);
    Prog7Locked        := Reg_ReadBool(reg, 'Prog7Locked', False);
    Prog8Locked        := Reg_ReadBool(reg, 'Prog8Locked', False);

    DefaultMacroLibrary := Reg_ReadString(reg, 'DefaultMacroLibrary', ExePath + K_DEF_MACRO_LIB);
    ParseTimeout        := Reg_ReadInteger(reg, 'ParseTimeout', 2000);
    PingTimeout         := Reg_ReadInteger(reg, 'PingTimeout', PingTimeout);
    TowerExistsSleep    := Reg_ReadInteger(reg, 'TowerExistsSleep', TowerExistsSleep);

    SetMaxRecent(Reg_ReadInteger(reg, 'MaxRecent', MaxRecent));

    WatchPoints         := Reg_ReadInteger(reg, 'WatchPoints', WatchPoints);

    gbSearchBackwards     := Reg_ReadBool(reg, 'SearchBackwards', false);
    gbSearchCaseSensitive := Reg_ReadBool(reg, 'SearchCaseSensitive', false);
    gbSearchFromCaret     := Reg_ReadBool(reg, 'SearchFromCaret', false);
    gbSearchSelectionOnly := Reg_ReadBool(reg, 'SearchSelectionOnly', false);
    gbSearchTextAtCaret   := Reg_ReadBool(reg, 'SearchTextAtCaret', true);
    gbSearchWholeWords    := Reg_ReadBool(reg, 'SearchWholeWords', false);
    gbSearchRegex         := Reg_ReadBool(reg, 'SearchRegex', false);

    gsSearchText          := Reg_ReadString(reg, 'SearchText', '');
    gsSearchTextHistory   := Reg_ReadString(reg, 'SearchTextHistory', '');
    gsReplaceText         := Reg_ReadString(reg, 'ReplaceText', '');
    gsReplaceTextHistory  := Reg_ReadString(reg, 'ReplaceTextHistory', '');

  finally
    reg.CloseKey;
  end;
  FillLockedProgramArray;
end;

procedure SaveGeneralValues(reg : TRegistry);
begin
  {Saves the general values to the registry}
  Reg_DeleteKey(reg, 'General');
  Reg_OpenKey(reg, 'General');
  try
    reg.WriteBool('ShowRecent', ShowRecent);
    reg.WriteBool('SaveBackup', SaveBackup);
    reg.WriteBool('SaveWindowPos', SaveWindowPos);
    reg.WriteBool('ShowStatusbar', ShowStatusbar);
    reg.WriteBool('ShowCompilerStatus', ShowCompilerStatus);
    reg.WriteBool('AutoSaveFiles', AutoSaveFiles);
    reg.WriteBool('AutoSaveDesktop', AutoSaveDesktop);
    reg.WriteBool('SaveBinaryOutput', SaveBinaryOutput);
    reg.WriteBool('LockToolbars', LockToolbars);
    reg.WriteBool('MaxEditWindows', MaxEditWindows);
    reg.WriteBool('MultiFormatCopy', MultiFormatCopy);
    reg.WriteBool('UseMDIMode', UseMDIMode);
    reg.WriteBool('QuietFirmware', QuietFirmware);
    reg.WriteBool('DroppedRecent', DroppedRecent);
    reg.WriteBool('FirmwareFast', FirmwareFast);
    reg.WriteBool('FirmwareComp', FirmwareComp);
    reg.WriteInteger('FirmwareChunkSize', FirmwareChunkSize);
    reg.WriteInteger('DownloadWaitTime', DownloadWaitTime);
    reg.WriteBool('TemplatesUseDoubleClick', TemplatesUseDblClick);
    // NXT Explorer settings
    reg.WriteInteger('NXTFilesViewStyle', Ord(NXTFilesViewStyle));
    reg.WriteInteger('PCFilesViewStyle', Ord(PCFilesViewStyle));
    reg.WriteInteger('NXTExplorerMaskIndex', NXTExplorerMaskIndex);
    reg.WriteString('NXTExplorerPath', NXTExplorerPath);

    reg.WriteBool('Prog1Locked', Prog1Locked);
    reg.WriteBool('Prog2Locked', Prog2Locked);
    reg.WriteBool('Prog3Locked', Prog3Locked);
    reg.WriteBool('Prog4Locked', Prog4Locked);
    reg.WriteBool('Prog5Locked', Prog5Locked);
    reg.WriteBool('Prog6Locked', Prog6Locked);
    reg.WriteBool('Prog7Locked', Prog7Locked);
    reg.WriteBool('Prog8Locked', Prog8Locked);

    reg.WriteString('DefaultMacroLibrary', DefaultMacroLibrary);
    reg.WriteInteger('ParseTimeout', ParseTimeout);
    reg.WriteInteger('PingTimeout', PingTimeout);
    reg.WriteInteger('TowerExistsSleep', TowerExistsSleep);

    reg.WriteInteger('MaxRecent', MaxRecent);
    reg.WriteInteger('WatchPoints', WatchPoints);

    reg.WriteBool('SearchBackwards', gbSearchBackwards);
    reg.WriteBool('SearchCaseSensitive', gbSearchCaseSensitive);
    reg.WriteBool('SearchFromCaret', gbSearchFromCaret);
    reg.WriteBool('SearchSelectionOnly', gbSearchSelectionOnly);
    reg.WriteBool('SearchTextAtCaret', gbSearchTextAtCaret);
    reg.WriteBool('SearchWholeWords', gbSearchWholeWords);
    reg.WriteBool('SearchRegex', gbSearchRegex);

    reg.WriteString('SearchText', gsSearchText);
    reg.WriteString('SearchTextHistory', gsSearchTextHistory);
    reg.WriteString('ReplaceText', gsReplaceText);
    reg.WriteString('ReplaceTextHistory', gsReplaceTextHistory);

  finally
    reg.CloseKey;
  end;
end;

procedure ResetGeneralValues(reg : TRegistry);
begin
  {Resets the general values to default}
  Reg_DeleteKey(reg, 'General');
  LoadGeneralValues(reg);
end;

procedure LoadEditorValues(reg : TRegistry);
begin
  {Loads the editor values from the registry}
  Reg_OpenKey(reg, 'Editor');
  try
    ColorCoding         := Reg_ReadBool(reg, 'ColorCoding', true);
    ShowTemplateForm    := Reg_ReadBool(reg, 'ShowTemplateForm', true);
    ShowTemplatePopup   := Reg_ReadBool(reg, 'ShowTemplatePopup', false);
    FontName            := Reg_ReadString(reg, 'FontName', K_EDITOR_FONTNAME_DEFAULT);
    FontSize            := Reg_ReadInteger(reg, 'FontSize', 9);
    AutoIndentCode      := Reg_ReadBool(reg, 'AutoIndentCode', true);
    MacrosOn            := Reg_ReadBool(reg, 'MacrosOn', false);
    RICDecompAsData     := Reg_ReadBool(reg, 'RICDecompAsData', false);
    RICDecompNameFormat := Reg_ReadString(reg, 'RICDecompNameFormat', '%s');
    HideSelection       := Reg_ReadBool(reg, 'HideSelection', false);
    ScrollPastEOL       := Reg_ReadBool(reg, 'ScrollPastEOL', true);
    HalfPageScroll      := Reg_ReadBool(reg, 'HalfPageScroll', false);
    DragAndDropEditing  := Reg_ReadBool(reg, 'DragDropEdit', true);
    TabWidth            := Reg_ReadInteger(reg, 'TabWidth', 2);
    MaxUndo             := Reg_ReadInteger(reg, 'MaxUndo', 10);
    MaxLeftChar         := Reg_ReadInteger(reg, 'MaxLeftChar', 8192);
    ExtraLineSpacing    := Reg_ReadInteger(reg, 'ExtraLineSpacing', 0);
    RightEdgePosition   := Reg_ReadInteger(reg, 'RightEdgePosition', 80);
    ScrollBars          := Reg_ReadInteger(reg, 'ScrollBars', 0);
    AltSetsSelMode      := Reg_ReadBool(reg, 'AltSetsSelMode', false);
    MoveCursorRight     := Reg_ReadBool(reg, 'MoveCursorRight', false);
    KeepBlanks          := Reg_ReadBool(reg, 'KeepBlanks', false);
    UseSmartTabs        := Reg_ReadBool(reg, 'UseSmartTabs', true);
    EnhanceHomeKey      := Reg_ReadBool(reg, 'EnhanceHomeKey', false);
    GroupUndo           := Reg_ReadBool(reg, 'GroupUndo', false);
    TabIndent           := Reg_ReadBool(reg, 'TabIndent', false);
    ConvertTabs         := Reg_ReadBool(reg, 'ConvertTabs', true);
    ShowSpecialChars    := Reg_ReadBool(reg, 'ShowSpecialChars', false);
    HighlightCurLine    := Reg_ReadBool(reg, 'HighlightCurLine', false);
    KeepCaretX          := Reg_ReadBool(reg, 'KeepCaretX', false);
    AutoMaxLeft         := Reg_ReadBool(reg, 'AutoMaxLeft', false);
    RightEdgeColor      := Reg_ReadColor(reg, 'RightEdgeColor', K_REDGE_COLOR_DEFAULT);
    EditorColor         := Reg_ReadColor(reg, 'EditorColor', K_EDITOR_COLOR_DEFAULT);
    SelectionForeground := Reg_ReadColor(reg, 'SelectionFG', K_SEL_FG_COLOR_DEFAULT);
    SelectionBackground := Reg_ReadColor(reg, 'SelectionBG', K_SEL_BG_COLOR_DEFAULT);
    StructureColor      := Reg_ReadColor(reg, 'StructureColor', K_STRUCT_COLOR_DEFAULT);
    ActiveLineColor     := Reg_ReadColor(reg, 'ActiveLineColor', K_ALINE_COLOR_DEFAULT);
    CommentType         := TCommentType(Reg_ReadInteger(reg, 'CommentType', Ord(ctSlash)));
    InsertRemoveSpace   := Reg_ReadBool(reg, 'InsertRemoveSpace', false);
    AlignMinWhitespace  := Reg_ReadInteger(reg, 'AlignMinWhitespace', 0);
    AlignMode           := TGXAlignMode(Reg_ReadInteger(reg, 'AlignMode', Ord(gamFirstToken)));
    AlignToken          := Reg_ReadString(reg, 'AlignToken', '=');
    AlignTokenList      := Reg_ReadString(reg, 'AlignTokenList', '==,=,//,{,/*,"""",:,+');
  finally
    reg.CloseKey;
  end;
end;

procedure SaveEditorValues(reg : TRegistry);
begin
  {Saves the editor values to the registry}
  Reg_DeleteKey(reg, 'Editor');
  Reg_OpenKey(reg, 'Editor');
  try
    reg.WriteBool('ColorCoding', ColorCoding);
    reg.WriteBool('ShowTemplateForm', ShowTemplateForm);
    reg.WriteBool('ShowTemplatePopup', ShowTemplatePopup);
    reg.WriteString('FontName', FontName);
    reg.WriteInteger('FontSize', FontSize);
    reg.WriteBool('AutoIndentCode', AutoIndentCode);
    reg.WriteBool('MacrosOn', MacrosOn);
    reg.WriteBool('RICDecompAsData', RICDecompAsData);
    reg.WriteString('RICDecompNameFormat', RICDecompNameFormat);
    reg.WriteBool('HideSelection', HideSelection);
    reg.WriteBool('ScrollPastEOL', ScrollPastEOL);
    reg.WriteBool('HalfPageScroll', HalfPageScroll);
    reg.WriteBool('DragDropEdit', DragAndDropEditing);
    reg.WriteInteger('TabWidth', TabWidth);
    reg.WriteInteger('MaxUndo', MaxUndo);
    reg.WriteInteger('MaxLeftChar', MaxLeftChar);
    reg.WriteInteger('ExtraLineSpacing', ExtraLineSpacing);
    reg.WriteInteger('RightEdgePosition', RightEdgePosition);
    Reg_WriteColor(reg, 'RightEdgeColor', RightEdgeColor);
    reg.WriteInteger('ScrollBars', ScrollBars);
    Reg_WriteColor(reg, 'EditorColor', EditorColor);
    Reg_WriteColor(reg, 'SelectionFG', SelectionForeground);
    Reg_WriteColor(reg, 'SelectionBG', SelectionBackground);
    Reg_WriteColor(reg, 'StructureColor', StructureColor);
    Reg_WriteColor(reg, 'ActiveLineColor', ActiveLineColor);
    reg.WriteBool('AltSetsSelMode', AltSetsSelMode);
    reg.WriteBool('MoveCursorRight', MoveCursorRight);
    reg.WriteBool('KeepBlanks', KeepBlanks);
    reg.WriteBool('UseSmartTabs', UseSmartTabs);
    reg.WriteBool('EnhanceHomeKey', EnhanceHomeKey);
    reg.WriteBool('GroupUndo', GroupUndo);
    reg.WriteBool('TabIndent', TabIndent);
    reg.WriteBool('ConvertTabs', ConvertTabs);
    reg.WriteBool('ShowSpecialChars', ShowSpecialChars);
    reg.WriteBool('HighlightCurLine', HighlightCurLine);
    reg.WriteBool('KeepCaretX', KeepCaretX);
    reg.WriteBool('AutoMaxLeft', AutoMaxLeft);
    reg.WriteInteger('CommentType', Ord(CommentType));
    reg.WriteBool('InsertRemoveSpace', InsertRemoveSpace);
    reg.WriteInteger('AlignMinWhitespace', AlignMinWhitespace);
    reg.WriteInteger('AlignMode', Ord(AlignMode));
    reg.WriteString('AlignToken', AlignToken);
    reg.WriteString('AlignTokenList', AlignTokenList);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetEditorValues(reg : TRegistry);
{Resets the editor values to default}
begin
  Reg_DeleteKey(reg, 'Editor');
  LoadEditorValues(reg);
end;

{compiler values}
procedure LoadCompilerValues(reg : TRegistry);
begin
  {Loads the compiler values from the registry}
  Reg_OpenKey(reg, 'Compiler');
  try
    CompilerTimeout         := Reg_ReadInteger(reg, 'CompilerTimeout', 60000);
    LocalCompilerTimeout    := CompilerTimeout;
    CompilerSwitches        := Reg_ReadString(reg, 'CompilerSwitches', '');
    PreferredLanguage       := Reg_ReadInteger(reg, 'PreferredLanguage', 0);
    NQCSwitches             := Reg_ReadString(reg, 'NQCSwitches', '');
    LCCSwitches             := Reg_ReadString(reg, 'LCCSwitches', '');
    NBCSwitches             := Reg_ReadString(reg, 'NBCSwitches', '');
    CPPSwitches             := Reg_ReadString(reg, 'CPPSwitches', '');
    JavaSwitches            := Reg_ReadString(reg, 'JavaSwitches', '');
    NBCOptLevel             := Reg_ReadInteger(reg, 'NBCOptLevel', 1);
    NBCMaxErrors            := Reg_ReadInteger(reg, 'NBCMaxErrors', 0);
    NQCIncludePath          := Reg_ReadString(reg, 'NQCIncludePath', '');
    LCCIncludePath          := Reg_ReadString(reg, 'LCCIncludePath', '');
    NBCIncludePath          := Reg_ReadString(reg, 'NBCIncludePath', '');
    OldNQCIncPaths          := Reg_ReadString(reg, 'OldNQCIncPaths', '');
    OldLCCIncPaths          := Reg_ReadString(reg, 'OldLCCIncPaths', '');
    OldNBCIncPaths          := Reg_ReadString(reg, 'OldNBCIncPaths', '');
    CygwinDir               := Reg_ReadString(reg, 'CygwinDir', K_CYGWIN_DIR);
    BrickOSRoot             := Reg_ReadString(reg, 'BrickOSRoot', K_BRICKOS_ROOT);
    BrickOSMakefileTemplate := Reg_ReadString(reg, 'BrickOSMakefileTemplate', K_BRICKOS_MAKE_TEMPLATE);
    PascalCompilerPrefix    := Reg_ReadString(reg, 'PascalCompilerPrefix', K_PASCAL_PREFIX);
    KeepBrickOSMakefile     := Reg_ReadBool(reg, 'KeepBrickOSMakefile', False);
    LeJOSMakefileTemplate   := Reg_ReadString(reg, 'LeJOSMakefileTemplate', K_LEJOS_MAKE_TEMPLATE);
    KeepLeJOSMakefile       := Reg_ReadBool(reg, 'KeepLeJOSMakefile', False);
    NQCExePath              := Reg_ReadString(reg, 'NQCExePath', '');
    LCCExePath              := Reg_ReadString(reg, 'LCCExePath', '');
    NBCExePath              := Reg_ReadString(reg, 'NBCExePath', '');
    IncludeSrcInList        := Reg_ReadBool(reg, 'IncludeSrcInList', False);
    UseInternalNBC          := Reg_ReadBool(reg, 'UseInternalNBC', K_USEINTERNALNBC_DEFAULT);
    EnhancedFirmware        := Reg_ReadBool(reg, 'EnhancedFirmware', False);
    NXT2Firmware            := Reg_ReadBool(reg, 'NXT2Firmware', False);
    IgnoreSysFiles          := Reg_ReadBool(reg, 'IgnoreSysFiles', False);
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

procedure SaveCompilerValues(reg : TRegistry);
begin
  {Saves the compiler values to the registry}
  Reg_DeleteKey(reg, 'Compiler');
  Reg_OpenKey(reg, 'Compiler');
  try
    reg.WriteInteger('CompilerTimeout', CompilerTimeout);
    reg.WriteString('CompilerSwitches', CompilerSwitches);
    reg.WriteInteger('PreferredLanguage', PreferredLanguage);
    reg.WriteString('NQCSwitches', NQCSwitches);
    reg.WriteString('LCCSwitches', LCCSwitches);
    reg.WriteString('NBCSwitches', NBCSwitches);
    reg.WriteString('JavaSwitches', JavaSwitches);
    reg.WriteInteger('NBCOptLevel', NBCOptLevel);
    reg.WriteInteger('NBCMaxErrors', NBCMaxErrors);
    reg.WriteString('NQCIncludePath', NQCIncludePath);
    reg.WriteString('LCCIncludePath', LCCIncludePath);
    reg.WriteString('NBCIncludePath', NBCIncludePath);
    reg.WriteString('OldNQCIncPaths', OldNQCIncPaths);
    reg.WriteString('OldLCCIncPaths', OldLCCIncPaths);
    reg.WriteString('OldNBCIncPaths', OldNBCIncPaths);
    reg.WriteString('CygwinDir', CygwinDir);
    reg.WriteString('BrickOSRoot', BrickOSRoot);
    reg.WriteString('BrickOSMakefileTemplate', BrickOSMakefileTemplate);
    reg.WriteString('PascalCompilerPrefix', PascalCompilerPrefix);
    reg.WriteBool('KeepBrickOSMakefile', KeepBrickOSMakefile);
    reg.WriteString('LeJOSMakefileTemplate', LeJOSMakefileTemplate);
    reg.WriteBool('KeepLeJOSMakefile', KeepLeJOSMakefile);
    reg.WriteString('NQCExePath', NQCExePath);
    reg.WriteString('LCCExePath', LCCExePath);
    reg.WriteString('NBCExePath', NBCExePath);
    reg.WriteBool('IncludeSrcInList', IncludeSrcInList);
    reg.WriteBool('UseInternalNBC', UseInternalNBC);
    reg.WriteBool('EnhancedFirmware', EnhancedFirmware);
    reg.WriteBool('NXT2Firmware', NXT2Firmware);
    reg.WriteBool('IgnoreSysFiles', IgnoreSysFiles);
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
  LoadCompilerValues(reg);
end;

{ gutter }
procedure LoadGutterValues(reg : TRegistry);
begin
  Reg_OpenKey(reg, 'Gutter');
  try
    GutterColor      := Reg_ReadColor(reg, 'GutterColor', K_GUTTER_COLOR_DEFAULT);
    GutterWidth      := Reg_ReadInteger(reg, 'GutterWidth', 30);
    DigitCount       := Reg_ReadInteger(reg, 'DigitCount', 4);
    LeftOffset       := Reg_ReadInteger(reg, 'LeftOffset', 16);
    RightOffset      := Reg_ReadInteger(reg, 'RightOffset', 2);
    ShowLineNumbers  := Reg_ReadBool(reg, 'ShowLineNumbers', false);
    ShowLeadingZeros := Reg_ReadBool(reg, 'ShowLeadingZeros', false);
    ZeroStart        := Reg_ReadBool(reg, 'ZeroStart', false);
    AutoSizeGutter   := Reg_ReadBool(reg, 'AutoSizeGutter', false);
    GutterVisible    := Reg_ReadBool(reg, 'GutterVisible', true);
    UseFontStyle     := Reg_ReadBool(reg, 'UseFontStyle', false);
    SelectOnClick    := Reg_ReadBool(reg, 'SelectOnClick', false);
  finally
    reg.CloseKey;
  end;
end;

procedure SaveGutterValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'Gutter');
  Reg_OpenKey(reg, 'Gutter');
  try
    Reg_WriteColor(reg, 'GutterColor', GutterColor);
    reg.WriteInteger('GutterWidth', GutterWidth);
    reg.WriteInteger('DigitCount', DigitCount);
    reg.WriteInteger('LeftOffset', LeftOffset);
    reg.WriteInteger('RightOffset', RightOffset);
    reg.WriteBool('ShowLineNumbers', ShowLineNumbers);
    reg.WriteBool('ShowLeadingZeros', ShowLeadingZeros);
    reg.WriteBool('ZeroStart', ZeroStart);
    reg.WriteBool('AutoSizeGutter', AutoSizeGutter);
    reg.WriteBool('GutterVisible', GutterVisible);
    reg.WriteBool('UseFontStyle', UseFontStyle);
    reg.WriteBool('SelectOnClick', SelectOnClick);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetGutterValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'Gutter');
  LoadGutterValues(reg);
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

{ Other shortcuts }
procedure LoadShortcutValues(reg : TRegistry);
begin
  Reg_OpenKey(reg, 'Shortcuts');
  try
    CodeCompShortCut  := Reg_ReadInteger(reg, 'CodeCompShortCut', ShortCut(Word(' '), [ssCtrl]));
    ParamCompShortCut := Reg_ReadInteger(reg, 'ParamCompShortCut', ShortCut(Word(' '), [ssShift, ssCtrl]));
    RecMacroShortCut  := Reg_ReadInteger(reg, 'RecMacroShortCut', ShortCut(Word('R'), [ssShift, ssCtrl]));
    PlayMacroShortCut := Reg_ReadInteger(reg, 'PlayMacroShortCut', ShortCut(Word('P'), [ssShift, ssCtrl]));
  finally
    reg.CloseKey;
  end;
end;

procedure SaveShortcutValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'Shortcuts');
  Reg_OpenKey(reg, 'Shortcuts');
  try
    reg.WriteInteger('CodeCompShortCut', CodeCompShortCut);
    reg.WriteInteger('ParamCompShortCut', ParamCompShortCut);
    reg.WriteInteger('RecMacroShortCut', RecMacroShortCut);
    reg.WriteInteger('PlayMacroShortCut', PlayMacroShortCut);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetShortcutValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'Shortcuts');
  LoadShortcutValues(reg);
end;

procedure RememberShortcutValues;
begin
end;

procedure GetShortcutValues;
begin
  PrefForm.UpdateGlobalShortcutValues;
end;

procedure DisplayShortcutValues;
begin
  PrefForm.DisplayShortcutValues;
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

procedure LoadCodeTemplateValues(reg : TRegistry; S : TStrings);
var
  tmpSL : TStringList;
begin
  tmpSL := TStringList.Create;
  try
    if not Reg_KeyExists(reg, 'CodeTemplates') then
    begin
      if FileExists(ProgramDir + 'Default\code.dci') then
        tmpSL.LoadFromFile(ProgramDir + 'Default\code.dci');
    end
    else
    begin
      Reg_OpenKey(reg, 'CodeTemplates');
      try
        tmpSL.Text := Reg_ReadString(reg, 'Data', '');
      finally
        reg.CloseKey;
      end;
    end;
    S.Assign(tmpSL);
  finally
    tmpSL.Free;
  end;
end;

procedure SaveCodeTemplateValues(reg : TRegistry; S : TStrings);
begin
  Reg_DeleteKey(reg, 'CodeTemplates');
  Reg_OpenKey(reg, 'CodeTemplates');
  try
    reg.WriteString('Data',S.Text);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetCodeTemplateValues(reg : TRegistry; S : TStrings);
begin
  Reg_DeleteKey(reg, 'CodeTemplates');
  LoadCodeTemplateValues(reg, S);
end;

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

procedure LoadWatchValues(reg : TRegistry);
begin
  if not Assigned(WatchForm) then Exit;
  Reg_OpenKey(reg, 'WatchValues');
  try
    WatchForm.chkIfActive.Checked := Reg_ReadBool(reg, 'OnlyIfActive', False);
    WatchForm.chkSyncSeries.Checked := Reg_ReadBool(reg, 'SyncSeries', True);
  finally
    reg.CloseKey;
  end;
end;

procedure SaveWatchValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'WatchValues');
  Reg_OpenKey(reg, 'WatchValues');
  try
    reg.WriteBool('OnlyIfActive', WatchForm.chkIfActive.Checked);
    reg.WriteBool('SyncSeries', WatchForm.chkSyncSeries.Checked);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetWatchValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'WatchValues');
  LoadWatchValues(reg);
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

{ Transfer }
procedure LoadTransferValues(const aKey : string; aList : TList; reg : TRegistry);
var
  i, cnt : integer;
  T : TTransferItem;
begin
  Reg_OpenKey(reg, aKey);
  try
    // load transfer items from registry
    cnt := Reg_ReadInteger(reg, 'Count', 0);
    for i := 0 to cnt - 1 do
    begin
      T := TTransferItem.Create;
      try
        aList.Add(T);
        T.Title := Reg_ReadString(reg, 'Title' + IntToStr(i), '');
        T.Path := Reg_ReadString(reg, 'Path' + IntToStr(i), '');
        T.WorkingDir := Reg_ReadString(reg, 'WorkingDir' + IntToStr(i), '');
        T.Params := Reg_ReadString(reg, 'Params' + IntToStr(i), '');
        T.Wait   := Reg_ReadBool(reg, 'Wait' + IntToStr(i), false);
        T.Close  := Reg_ReadBool(reg, 'Close' + IntToStr(i), false);
        T.Restrict := Reg_ReadBool(reg, 'Restrict' + IntToStr(i), false);
        T.Extension := Reg_ReadString(reg, 'Extension' + IntToStr(i), '');
      except
        T.Free;
      end;
    end;
  finally
    reg.CloseKey;
  end;
end;

procedure SaveTransferValues(const aKey : string; aList : TList; reg : TRegistry);
var
  i : integer;
  T : TTransferItem;
begin
  Reg_DeleteKey(reg, aKey);
  Reg_OpenKey(reg, aKey);
  try
    // save transfer items to registry
    reg.WriteInteger('Count', aList.Count);
    for i := 0 to aList.Count - 1 do
    begin
      T := TTransferItem(aList[i]);
      reg.WriteString('Title' + IntToStr(i), T.Title);
      reg.WriteString('Path' + IntToStr(i), T.Path);
      reg.WriteString('WorkingDir' + IntToStr(i), T.WorkingDir);
      reg.WriteString('Params' + IntToStr(i), T.Params);
      reg.WriteBool('Wait' + IntToStr(i), T.Wait);
      reg.WriteBool('Close' + IntToStr(i), T.Close);
      reg.WriteBool('Restrict' + IntToStr(i), T.Restrict);
      reg.WriteString('Extension' + IntToStr(i), T.Extension);
    end;
  finally
    reg.CloseKey;
  end;
end;

procedure ResetTransferValues(const aKey : string; aList : TList; reg : TRegistry);
begin
  Reg_DeleteKey(reg, aKey);
  LoadTransferValues(aKey, aList, reg);
end;

{ Code Explorer }
procedure LoadExplorerValues(reg : TRegistry);
var
  PT : TProcType;
begin
  Reg_OpenKey(reg, 'Code Explorer');
  try
    // load code explorer settings from registry
    CodeExplorerSettings.CategorySort := Reg_ReadString(reg, 'CategorySort', '');
    CodeExplorerSettings.AutoShowExplorer := Reg_ReadBool(reg, 'Show Mod Exp', True);
    CodeExplorerSettings.DeclarationSyntax := Reg_ReadBool(reg, 'DeclarationSyntax', False);
    CodeExplorerSettings.UseAlphaSort := Reg_ReadBool(reg, 'UseAlphaSort', True);
    for PT := Low(TProcType) to High(TProcType) do
    begin
      CodeExplorerSettings.Visible[PT] := Reg_ReadBool(reg, PROC_TYPES[PT]+'Visible', True);
      CodeExplorerSettings.Expand[PT]  := Reg_ReadBool(reg, PROC_TYPES[PT]+'Expand', False);
    end;
  finally
    reg.CloseKey;
  end;
end;

procedure SaveExplorerValues(reg : TRegistry);
var
  PT : TProcType;
begin
  Reg_DeleteKey(reg, 'Code Explorer');
  Reg_OpenKey(reg, 'Code Explorer');
  try
    reg.WriteString('CategorySort', CodeExplorerSettings.CategorySort);
    reg.WriteBool('Show Mod Exp', CodeExplorerSettings.AutoShowExplorer);
    reg.WriteBool('DeclarationSyntax', CodeExplorerSettings.DeclarationSyntax);
    reg.WriteBool('UseAlphaSort', CodeExplorerSettings.UseAlphaSort);
    for PT := Low(TProcType) to High(TProcType) do
    begin
      reg.WriteBool(PROC_TYPES[PT]+'Visible', CodeExplorerSettings.Visible[PT]);
      reg.WriteBool(PROC_TYPES[PT]+'Expand', CodeExplorerSettings.Expand[PT]);
    end;
  finally
    reg.CloseKey;
  end;
end;

procedure ResetExplorerValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'Code Explorer');
  LoadExplorerValues(reg);
end;

{ Procedure List }
procedure LoadProcListValues(reg : TRegistry);
begin
  Reg_OpenKey(reg, 'Procedure List');
  try
    // load procedure list settings from registry
    ProcedureListSettings.SearchAll  := Reg_ReadBool(reg, 'SearchAll', false);
    ProcedureListSettings.Left       := Reg_ReadInteger(reg, 'Left', -1);
    ProcedureListSettings.Top        := Reg_ReadInteger(reg, 'Top', -1);
    ProcedureListSettings.Width      := Reg_ReadInteger(reg, 'Width', -1);
    ProcedureListSettings.Height     := Reg_ReadInteger(reg, 'Height', -1);
    ProcedureListSettings.SortColumn := Reg_ReadInteger(reg, 'SortColumn', -1);
    ProcedureListSettings.FontName   := Reg_ReadString(reg, 'FontName', '');
    ProcedureListSettings.FontSize   := Reg_ReadInteger(reg, 'FontSize', -1);
  finally
    reg.CloseKey;
  end;
end;

procedure SaveProcListValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'Procedure List');
  Reg_OpenKey(reg, 'Procedure List');
  try
    reg.WriteBool('SearchAll', ProcedureListSettings.SearchAll);
    if ProcedureListSettings.Left <> -1 then
      reg.WriteInteger('Left', ProcedureListSettings.Left);
    if ProcedureListSettings.Top <> -1 then
      reg.WriteInteger('Top', ProcedureListSettings.Top);
    if ProcedureListSettings.Width <> -1 then
      reg.WriteInteger('Width', ProcedureListSettings.Width);
    if ProcedureListSettings.Height <> -1 then
      reg.WriteInteger('Height', ProcedureListSettings.Height);
    if ProcedureListSettings.FontName <> '' then
      reg.WriteString('FontName', ProcedureListSettings.FontName);
    if ProcedureListSettings.FontSize <> -1 then
      reg.WriteInteger('FontSize', ProcedureListSettings.FontSize);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetProcListValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'Procedure List');
  LoadProcListValues(reg);
end;

{ all }
procedure LoadAllValues(reg : TRegistry; k : TSynEditKeyStrokes; S : TStrings);
var
  i : integer;
begin
  LoadGeneralValues(reg);
  LoadEditorValues(reg);
  LoadCompilerValues(reg);
  LoadStartupValues(reg);
  LoadColorValues(reg);
  LoadJoystickValues(reg);
  LoadRemoteValues(reg);
  LoadRecentValues(reg);
  LoadWindowsValues(reg);
  LoadAPIValues(reg);
  for i := 0 to NUM_LANGS - 1 do
    LoadTemplateValues(i, reg);
  LoadMacroValues(reg);
  LoadGutterValues(reg);
  LoadOtherOptionValues(reg);
  LoadShortcutValues(reg);
  LoadKeystrokeValues(reg, k);
  LoadPageSetupValues(reg);
  LoadCodeTemplateValues(reg, S);
  LoadWatchValues(reg);
  LoadDatalogValues(reg);
  LoadTransferValues('CompXfer', CompXferList, reg);
  LoadTransferValues('Transfer', TransferList, reg);
  LoadTransferValues('PrecompileSteps', PrecompileSteps, reg);
  LoadTransferValues('PostcompileSteps', PostcompileSteps, reg);
  LoadExplorerValues(reg);
  LoadProcListValues(reg);
end;

procedure SaveAllValues(reg : TRegistry; k : TSynEditKeyStrokes; S : TStrings);
var
  i : integer;
begin
  SaveGeneralValues(reg);
  SaveEditorValues(reg);
  SaveCompilerValues(reg);
  SaveStartupValues(reg);
  SaveColorValues(reg);
  SaveJoystickValues(reg);
  SaveRemoteValues(reg);
  SaveRecentValues(reg);
  SaveWindowsValues(reg);
  SaveAPIValues(reg);
  for i := 0 to NUM_LANGS - 1 do
    SaveTemplateValues(i, reg);
  SaveMacroValues(reg);
  SaveGutterValues(reg);
  SaveOtherOptionValues(reg);
  SaveShortcutValues(reg);
  SaveKeystrokeValues(reg, k);
  SavePageSetupValues(reg);
  SaveCodeTemplateValues(reg, S);
  SaveWatchValues(reg);
  SaveDatalogValues(reg);
  SaveTransferValues('Transfer', TransferList, reg);
  SaveTransferValues('PrecompileSteps', PrecompileSteps, reg);
  SaveTransferValues('PostcompileSteps', PostcompileSteps, reg);
  SaveExplorerValues(reg);
  SaveProcListValues(reg);
end;

procedure ResetAllValues(reg : TRegistry; S : TStrings);
begin
  ResetGeneralValues(reg);
  ResetEditorValues(reg);
  ResetCompilerValues(reg);
  ResetStartupValues(reg);
  ResetColorValues(reg);
  ResetJoystickValues(reg);
  ResetRemoteValues(reg);
  ResetRecentValues(reg);
  ResetWindowsValues(reg);
  ResetAPIValues(reg);
  ResetTemplateValues(reg);
  ResetMacroValues(reg);
  ResetGutterValues(reg);
  ResetOtherOptionValues(reg);
  ResetKeystrokeValues(reg);
  ResetPageSetupValues(reg);
  ResetCodeTemplateValues(reg, S);
  ResetWatchValues(reg);
  ResetDatalogValues(reg);
  ResetTransferValues('Transfer', TransferList, reg);
  ResetTransferValues('PrecompileSteps', PrecompileSteps, reg);
  ResetTransferValues('PostcompileSteps', PostcompileSteps, reg);
  ResetExplorerValues(reg);
  ResetProcListValues(reg);
end;


procedure UpgradeRegistry;
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
  try
    dVer := StrToFloat(fVersion);
  except
    dVer := K_MINVER;
  end;
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
                LoadAllValues(R, K, S);
                bLoaded := True;
              end
              else if R.OpenKey(K_MAINKEY+'\'+sVer, false) then begin
                fMainKey := K_MAINKEY;
                fVersion := sVer;
                // load values from old version
                LoadAllValues(R, K, S);
                bLoaded := True;
              end;
              dVer := dVer - 0.1;
            end;
            if not bLoaded and R.OpenKey(K_OLDMAINKEY+'\'+K_OLDVERSION, false) then begin
              fMainKey := K_OLDMAINKEY;
              fVersion := K_OLDVERSION;
              // load values from old version
              LoadAllValues(R, K, S);
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
end;

{********************************************
 Handling the preferences form
 ********************************************}

var OldShowRecent:boolean;   // For saving the old version

procedure RememberGeneralValues;
begin
{Remember current settings such that we know whether changed}
  OldShowRecent := ShowRecent;
end;

procedure GetGeneralValues;
begin
{Gets the values from the form}
  ShowRecent         := PrefForm.CheckShowRecent.Checked;
  ShowRecentChanged  := (ShowRecent <> OldShowRecent);
  SaveWindowPos      := PrefForm.CheckSavePos.Checked;
  SaveBackup         := PrefForm.CheckSaveBackup.Checked;
  ShowCompilerStatus := PrefForm.chkShowCompileStatus.Checked;
  AutoSaveFiles      := PrefForm.chkAutoSave.Checked;
  AutoSaveDesktop    := PrefForm.chkSaveDesktop.Checked;
  SaveBinaryOutput   := PrefForm.chkSaveBinaryOutput.Checked;
  LockToolbars       := PrefForm.chkLockToolbars.Checked;
  MaxEditWindows     := PrefForm.chkMaxEditWindows.Checked;
  MultiFormatCopy    := PrefForm.chkMultiFormatCopy.Checked;
  UseMDIMode         := PrefForm.chkUseMDI.Checked;
  QuietFirmware      := PrefForm.chkQuietFirmware.Checked;
  DroppedRecent      := PrefForm.chkDroppedRecent.Checked;
  FirmwareFast       := PrefForm.chkFirmfast.Checked;
  FirmwareComp       := PrefForm.chkFirmComp.Checked;
  FirmwareChunkSize  := PrefForm.edtFirmwareChunkSize.Value;
  DownloadWaitTime   := PrefForm.edtWaitTime.Value;
  Prog1Locked        := PrefForm.cbProg1.Checked;
  Prog2Locked        := PrefForm.cbProg2.Checked;
  Prog3Locked        := PrefForm.cbProg3.Checked;
  Prog4Locked        := PrefForm.cbProg4.Checked;
  Prog5Locked        := PrefForm.cbProg5.Checked;
  Prog6Locked        := PrefForm.cbProg6.Checked;
  Prog7Locked        := PrefForm.cbProg7.Checked;
  Prog8Locked        := PrefForm.cbProg8.Checked;

  SetMaxRecent(PrefForm.edtMaxRecent.Value);
end;

procedure DisplayGeneralValues;
begin
{Displays the values in the form}
  PrefForm.CheckShowRecent.Checked      := ShowRecent;
  PrefForm.CheckSavePos.Checked         := SaveWindowPos;
  PrefForm.CheckSaveBackup.Checked      := SaveBackup;
  PrefForm.chkShowCompileStatus.Checked := ShowCompilerStatus;
  PrefForm.chkAutoSave.Checked          := AutoSaveFiles;
  PrefForm.chkSaveDesktop.Checked       := AutoSaveDesktop;
  PrefForm.chkSaveBinaryOutput.Checked  := SaveBinaryOutput;
  PrefForm.chkLockToolbars.Checked      := LockToolbars;
  PrefForm.chkMaxEditWindows.Checked    := MaxEditWindows;
  PrefForm.chkMultiFormatCopy.Checked   := MultiFormatCopy;
  PrefForm.chkUseMDI.Checked            := UseMDIMode;
  PrefForm.chkQuietFirmware.Checked     := QuietFirmware;
  PrefForm.chkDroppedRecent.Checked     := DroppedRecent;
  PrefForm.chkFirmfast.Checked          := FirmwareFast;
  PrefForm.chkFirmComp.Checked          := FirmwareComp;
  PrefForm.edtFirmwareChunkSize.Value   := FirmwareChunkSize;
  PrefForm.edtWaitTime.Value            := DownloadWaitTime;
  PrefForm.edtMaxRecent.Value           := MaxRecent;
  PrefForm.cbProg1.Checked              := Prog1Locked;
  PrefForm.cbProg2.Checked              := Prog2Locked;
  PrefForm.cbProg3.Checked              := Prog3Locked;
  PrefForm.cbProg4.Checked              := Prog4Locked;
  PrefForm.cbProg5.Checked              := Prog5Locked;
  PrefForm.cbProg6.Checked              := Prog6Locked;
  PrefForm.cbProg7.Checked              := Prog7Locked;
  PrefForm.cbProg8.Checked              := Prog8Locked;
end;

{The Editor Information}

var OldColorCoding:boolean;  // For saving the old version
    OldFontName:string;
    OldFontSize:integer;

procedure RememberEditorValues;
begin
{Remember current settings such that we know whether changed}
  OldColorCoding := ColorCoding;
  OldFontName := FontName;
  OldFontSize := FontSize;
end;

procedure GetEditorValues;
begin
  {Gets the values from the form}
  ColorsChanged       := PrefForm.ColorsChanged;
  ColorCoding         := PrefForm.CheckColorCoding.Checked;
  ColorCodingChanged  := (ColorCoding <> OldColorCoding);
  ShowTemplatePopup   := PrefForm.CheckShowTemplates.Checked;
  FontChanged         := (FontName <> OldFontName) or (FontSize <> OldFontSize);
  AutoIndentCode      := PrefForm.CheckAutoIndentCode.Checked;
  MacrosOn            := PrefForm.CheckMacrosOn.Checked;
  RICDecompAsData     := PrefForm.radRICDecompArray.Checked;
  RICDecompNameFormat := PrefForm.edtRICDecompArrayFmt.Text;
  HideSelection       := PrefForm.cbHideSelection.Checked;
  ScrollPastEOL       := PrefForm.cbScrollPastEOL.Checked;
  HalfPageScroll      := PrefForm.cbHalfPageScroll.Checked;
  DragAndDropEditing  := PrefForm.chkDragDrop.Checked;
  TabWidth            := PrefForm.inpTabWidth.Value;
  MaxUndo             := PrefForm.inpMaxUndo.Value;
  MaxLeftChar         := PrefForm.edtMaxLeftChar.Value;
  ExtraLineSpacing    := PrefForm.inpExtraLineSpacing.Value;
  ScrollBars          := PrefForm.cbxScrollBars.ItemIndex;
  RightEdgePosition   := PrefForm.inpRightEdge.Value;
  RightEdgeColor      := PrefForm.cbxREColor.Selected;
  EditorColor         := PrefForm.cbxColor.Selected;
  SelectionForeground := PrefForm.cbxForeground.Selected;
  SelectionBackground := PrefForm.cbxBackground.Selected;
  StructureColor      := PrefForm.cbxStructureColor.Selected;
  ActiveLineColor     := PrefForm.cbxActiveLineColor.Selected;
  AltSetsSelMode      := PrefForm.chkAltSelMode.Checked;
  MoveCursorRight     := PrefForm.chkMoveRight.Checked;
  KeepBlanks          := PrefForm.chkKeepBlanks.Checked;
  UseSmartTabs        := PrefForm.chkSmartTab.Checked;
  EnhanceHomeKey      := PrefForm.chkEnhHomeKey.Checked;
  GroupUndo           := PrefForm.chkGroupUndo.Checked;
  TabIndent           := PrefForm.chkTabIndent.Checked;
  ConvertTabs         := PrefForm.chkConvertTabs.Checked;
  ShowSpecialChars    := PrefForm.chkShowSpecialChars.Checked;
  HighlightCurLine    := PrefForm.chkHighlightCurLine.Checked;
  KeepCaretX          := PrefForm.chkKeepCaretX.Checked;
  AutoMaxLeft         := PrefForm.chkAutoMaxLeft.Checked;
end;

procedure DisplayEditorValues;
begin
  {Displays the values in the form}
  PrefForm.CheckColorCoding.Checked    := ColorCoding;
  PrefForm.CheckShowTemplates.Checked  := ShowTemplatePopup;
  PrefForm.CheckAutoIndentCode.Checked := AutoIndentCode;
  PrefForm.CheckMacrosOn.Checked       := MacrosOn;
  PrefForm.radRICDecompArray.Checked   := RICDecompAsData;
  PrefForm.edtRICDecompArrayFmt.Text   := RICDecompNameFormat;
  PrefForm.cbHideSelection.Checked     := HideSelection;
  PrefForm.cbScrollPastEOL.Checked     := ScrollPastEOL;
  PrefForm.cbHalfPageScroll.Checked    := HalfPageScroll;
  PrefForm.chkDragDrop.Checked         := DragAndDropEditing;
  PrefForm.inpTabWidth.Value           := TabWidth;
  PrefForm.inpMaxUndo.Value            := MaxUndo;
  PrefForm.edtMaxLeftChar.Value        := MaxLeftChar;
  PrefForm.inpExtraLineSpacing.Value   := ExtraLineSpacing;
  PrefForm.cbxScrollBars.ItemIndex     := ScrollBars;
  PrefForm.inpRightEdge.Value          := RightEdgePosition;
  PrefForm.cbxREColor.Selected         := RightEdgeColor;
  PrefForm.cbxColor.Selected           := EditorColor;
  PrefForm.cbxForeground.Selected      := SelectionForeground;
  PrefForm.cbxBackground.Selected      := SelectionBackground;
  PrefForm.cbxStructureColor.Selected  := StructureColor;
  PrefForm.cbxActiveLineColor.Selected := ActiveLineColor;
  PrefForm.chkAltSelMode.Checked       := AltSetsSelMode;
  PrefForm.chkMoveRight.Checked        := MoveCursorRight;
  PrefForm.chkKeepBlanks.Checked       := KeepBlanks;
  PrefForm.chkSmartTab.Checked         := UseSmartTabs;
  PrefForm.chkEnhHomeKey.Checked       := EnhanceHomeKey;
  PrefForm.chkGroupUndo.Checked        := GroupUndo;
  PrefForm.chkTabIndent.Checked        := TabIndent;
  PrefForm.chkConvertTabs.Checked      := ConvertTabs;
  PrefForm.chkShowSpecialChars.Checked := ShowSpecialChars;
  PrefForm.chkHighlightCurLine.Checked := HighlightCurLine;
  PrefForm.chkKeepCaretX.Checked       := KeepCaretX;
  PrefForm.chkAutoMaxLeft.Checked      := AutoMaxLeft;
end;

procedure RememberCompilerValues;
begin
end;

procedure GetCompilerValues;
begin
  CompilerTimeout         := PrefForm.edtCompilerTimeout.Value * K_MSTOSEC;
  LocalCompilerTimeout    := CompilerTimeout;
  CompilerSwitches        := PrefForm.edtCompilerSwitches.Text;
  PreferredLanguage       := PrefForm.PreferredLanguage;
  NQCSwitches             := PrefForm.edtNQCSwitches.Text;
  LCCSwitches             := PrefForm.edtLCCSwitches.Text;
  NBCSwitches             := PrefForm.edtNBCSwitches.Text;
  CPPSwitches             := PrefForm.edtCPPSwitches.Text;
  JavaSwitches            := PrefForm.edtJavaSwitches.Text;
  NBCOptLevel             := PrefForm.cboOptLevel.ItemIndex;
  NBCMaxErrors            := PrefForm.edtMaxErrors.Value;
  NQCIncludePath          := PrefForm.edtNQCIncludePath.Text;
  OldNQCIncPaths          := PrefForm.edtNQCIncludePath.Items.CommaText;
  LCCIncludePath          := PrefForm.edtLCCIncludePath.Text;
  OldLCCIncPaths          := PrefForm.edtLCCIncludePath.Items.CommaText;
  NBCIncludePath          := PrefForm.edtNBCIncludePath.Text;
  OldNBCIncPaths          := PrefForm.edtNBCIncludePath.Items.CommaText;
  CygwinDir               := PrefForm.edtCygwin.Text;
  BrickOSRoot             := PrefForm.edtOSRoot.Text;
  BrickOSMakefileTemplate := PrefForm.edtBrickOSMakefileTemplate.Lines.Text;
  PascalCompilerPrefix    := PrefForm.edtPascalCompilerPrefix.Text;
  KeepBrickOSMakefile     := PrefForm.chkKeepBrickOSMakefile.Checked;
  LeJOSMakefileTemplate   := PrefForm.edtLeJOSMakefileTemplate.Lines.Text;
  KeepLeJOSMakefile       := PrefForm.chkKeepLeJOSMakefile.Checked;
  NQCExePath              := PrefForm.edtNQCExePath.Text;
  LCCExePath              := PrefForm.edtLCCExePath.Text;
  NBCExePath              := PrefForm.edtNBCExePath.Text;
  IncludeSrcInList        := PrefForm.chkIncludeSrcInList.Checked;
  UseInternalNBC          := PrefForm.chkUseIntNBCComp.Checked;
  EnhancedFirmware        := PrefForm.chkEnhancedFirmware.Checked;
  NXT2Firmware            := PrefForm.chkNXT2Firmare.Checked;
  IgnoreSysFiles          := PrefForm.chkIgnoreSysFiles.Checked;
  LeJOSRoot               := PrefForm.edtLeJOSRoot.Text;
  JavaCompilerPath        := PrefForm.edtJavaPath.Text;
  ShowAllConsoleOutput    := PrefForm.chkShowAllOutput.Checked;
  StopScriptDLOnErrors    := PrefForm.chkStopOnAborted.Checked;
  StripScriptComments     := PrefForm.chkStripComments.Checked;
  SkipBlankScriptLines    := PrefForm.chkSkipBlankLines.Checked;
  SyntaxHighlightConsole  := PrefForm.chkConsoleSyntaxHL.Checked;
  ConsoleOutputSeparate   := PrefForm.chkOutputSeparate.Checked;
  ShowConsoleLineNumbers  := PrefForm.chkShowConsoleLineNumbers.Checked;
  ConsoleCodeCompletion   := PrefForm.chkConsoleCompProp.Checked;
  ConsoleICDelay          := PrefForm.edtICDelay.Value;
  ConsoleILDelay          := PrefForm.edtILDelay.Value;
  ConsoleUSBFirstTimeout  := PrefForm.edtConsoleReadFirstTimeout.Value;
  ConsoleUSBICTimeout     := PrefForm.edtConsoleReadICTimeout.Value;
  ConsoleUSBWriteTimeout  := PrefForm.edtConsoleWriteTimeout.Value;
end;

procedure DisplayCompilerValues;
begin
  PrefForm.edtCompilerTimeout.Value       := CompilerTimeout div K_MSTOSEC;
  PrefForm.edtCompilerSwitches.Text       := CompilerSwitches;
  PrefForm.PreferredLanguage              := PreferredLanguage;
  PrefForm.edtNQCSwitches.Text            := NQCSwitches;
  PrefForm.edtLCCSwitches.Text            := LCCSwitches;
  PrefForm.edtNBCSwitches.Text            := NBCSwitches;
  PrefForm.edtCPPSwitches.Text            := CPPSwitches;
  PrefForm.cboOptLevel.ItemIndex          := NBCOptLevel;
  PrefForm.edtMaxErrors.Value             := NBCMaxErrors;
  PrefForm.edtJavaSwitches.Text           := JavaSwitches;
  PrefForm.edtNQCIncludePath.Text         := NQCIncludePath;
  PrefForm.edtLCCIncludePath.Text         := LCCIncludePath;
  PrefForm.edtNBCIncludePath.Text         := NBCIncludePath;
  PrefForm.edtCygwin.Text                 := CygwinDir;
  PrefForm.edtOSRoot.Text                 := BrickOSRoot;
  PrefForm.edtBrickOSMakefileTemplate.Lines.Text := BrickOSMakefileTemplate;
  PrefForm.edtPascalCompilerPrefix.Text   := PascalCompilerPrefix;
  PrefForm.chkKeepBrickOSMakefile.Checked := KeepBrickOSMakefile;
  PrefForm.edtLeJOSMakefileTemplate.Lines.Text := LeJOSMakefileTemplate;
  PrefForm.chkKeepLeJOSMakefile.Checked   := KeepLeJOSMakefile;
  PrefForm.edtNQCExePath.Text             := NQCExePath;
  PrefForm.edtLCCExePath.Text             := LCCExePath;
  PrefForm.edtNBCExePath.Text             := NBCExePath;
  PrefForm.chkIncludeSrcInList.Checked    := IncludeSrcInList;
  PrefForm.chkUseIntNBCComp.Checked       := UseInternalNBC;
  PrefForm.chkEnhancedFirmware.Checked    := EnhancedFirmware;
  PrefForm.chkNXT2Firmare.Checked         := NXT2Firmware;
  PrefForm.chkIgnoreSysFiles.Checked      := IgnoreSysFiles;
  PrefForm.edtLeJOSRoot.Text              := LeJOSRoot;
  PrefForm.edtJavaPath.Text               := JavaCompilerPath;
  // forth console settings
  PrefForm.chkShowAllOutput.Checked          := ShowAllConsoleOutput;
  PrefForm.chkStopOnAborted.Checked          := StopScriptDLOnErrors;
  PrefForm.chkStripComments.Checked          := StripScriptComments;
  PrefForm.chkSkipBlankLines.Checked         := SkipBlankScriptLines;
  PrefForm.chkConsoleSyntaxHL.Checked        := SyntaxHighlightConsole;
  PrefForm.chkOutputSeparate.Checked         := ConsoleOutputSeparate;
  PrefForm.chkShowConsoleLineNumbers.Checked := ShowConsoleLineNumbers;
  PrefForm.chkConsoleCompProp.Checked        := ConsoleCodeCompletion;
  PrefForm.edtICDelay.Value                  := ConsoleICDelay;
  PrefForm.edtILDelay.Value                  := ConsoleILDelay;
  PrefForm.edtConsoleReadFirstTimeout.Value  := ConsoleUSBFirstTimeout;
  PrefForm.edtConsoleReadICTimeout.Value     := ConsoleUSBICTimeout;
  PrefForm.edtConsoleWriteTimeout.Value      := ConsoleUSBWriteTimeout;

  PrefForm.edtNQCIncludePath.Items.CommaText := OldNQCIncPaths;
  PrefForm.edtLCCIncludePath.Items.CommaText := OldLCCIncPaths;
end;

{ The API information }

procedure DisplayAPIValues;
begin
  if not Assigned(PrefForm) then Exit;
  // NQC API
  PrefForm.edtKeyword.Text := '';
  PrefForm.edtCommand.Text := '';
  PrefForm.edtConstant.Text := '';
  PrefForm.lstKeywords.Items.Clear;
  PrefForm.lstCommands.Items.Clear;
  PrefForm.lstConstants.Items.Clear;

  PrefForm.lstKeywords.Items.Assign(PrefForm.cc_keywords);
  PrefForm.lstCommands.Items.Assign(PrefForm.cc_commands);
  PrefForm.lstConstants.Items.Assign(PrefForm.cc_constants);

  // NXC API
  PrefForm.edtNXCKeyword.Text := '';
  PrefForm.edtNXCCommand.Text := '';
  PrefForm.edtNXCConstant.Text := '';
  PrefForm.lstNXCKeywords.Items.Clear;
  PrefForm.lstNXCCommands.Items.Clear;
  PrefForm.lstNXCConstants.Items.Clear;

  PrefForm.lstNXCKeywords.Items.Assign(PrefForm.cc_nxc_keywords);
  PrefForm.lstNXCCommands.Items.Assign(PrefForm.cc_nxc_commands);
  PrefForm.lstNXCConstants.Items.Assign(PrefForm.cc_nxc_constants);
end;

procedure RememberAPIValues;
begin
end;

procedure GetAPIValues;
begin
  if not Assigned(PrefForm) then Exit;
  // NQC API
  PrefForm.cc_keywords.Assign(PrefForm.lstKeywords.Items);
  PrefForm.cc_commands.Assign(PrefForm.lstCommands.Items);
  PrefForm.cc_constants.Assign(PrefForm.lstConstants.Items);
  // NXC API
  PrefForm.cc_nxc_keywords.Assign(PrefForm.lstNXCKeywords.Items);
  PrefForm.cc_nxc_commands.Assign(PrefForm.lstNXCCommands.Items);
  PrefForm.cc_nxc_constants.Assign(PrefForm.lstNXCConstants.Items);
  PutValuesInSyntaxHighlighter;
end;

{The Gutter Information}

procedure RememberGutterValues;
begin
end;

procedure GetGutterValues;
begin
  PrefForm.UpdateGlobalGutterValues;
end;

procedure DisplayGutterValues;
begin
  PrefForm.DisplayGutterValues;
end;

{Other Options Information}

procedure RememberOtherOptionValues;
begin
end;

procedure GetOtherOptionValues;
begin
  PrefForm.UpdateGlobalOtherOptionValues;
end;

procedure DisplayOtherOptionValues;
begin
  PrefForm.DisplayOtherOptionValues;
end;

{The keystroke Information}

procedure RememberKeystrokeValues;
begin
end;

procedure GetKeystrokeValues;
begin
  PrefForm.UpdateGlobalKeystrokeValues;
end;

procedure DisplayKeystrokeValues;
begin
  PrefForm.DisplayKeystrokeValues;
end;

procedure DisplayCodeTemplateValues;
begin
  PrefForm.DisplayCodeTemplateValues;
end;

{ The Startup Information}

procedure RememberStartupValues;
begin
  {Remember current settings such that we know whether changed}
  {Nothing to be done yet}
end;

procedure GetStartupValues;
begin
  {Gets the values from the form}
  if PrefForm.CheckShowForm.Checked then StartupAction := SU_SHOWFORM;
  if PrefForm.CheckConnect.Checked then StartupAction := SU_CONNECT;
  if PrefForm.CheckNoConnect.Checked then StartupAction := SU_NOCONNECT;

  BrickType := PrefForm.cboBrickType.ItemIndex;
  if BrickType = -1 then
    BrickType := SU_RCX;

  COMPort := PrefForm.cboPort.Text;

  StandardFirmwareDefault := PrefForm.radStandard.Checked;
  UseBluetoothDefault     := False;
  FirmwareTypeDefault     := PrefForm.GetFirmwareTypeDefault;
  FBAlwaysPrompt          := PrefForm.chkFBAlwaysPrompt.Checked;
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

procedure DisplayStartupValues;
begin
  {Display the values in the form}
  PrefForm.CheckShowForm.Checked  := (StartupAction = SU_SHOWFORM);
  PrefForm.CheckConnect.Checked   := (StartupAction = SU_CONNECT);
  PrefForm.CheckNoConnect.Checked := (StartupAction = SU_NOCONNECT);

  PrefForm.cboBrickType.ItemIndex := BrickType;

  PrefForm.cboPort.ItemIndex := PrefForm.cboPort.Items.IndexOf(COMPort);
  if PrefForm.cboPort.ItemIndex = -1 then
    PrefForm.cboPort.Text := COMPort;

//  PrefForm.chkUseBluetooth.Checked := UseBluetoothDefault;
  PrefForm.radStandard.Checked     := StandardFirmwareDefault;
  PrefForm.SetFirmwareType(FirmwareTypeDefault);
  PrefForm.chkFBAlwaysPrompt.Checked := FBAlwaysPrompt;
end;

{The Templates Information}

procedure RememberTemplateValues;
begin
  {Remember current settings such that we know whether changed}
  TemplatesChanged := false;
end;

procedure GetTemplateValues(const aLang : integer);
var
  i : integer;
begin
  {Gets the values from the form}
  with PrefForm.NewTemplatesList do
  begin
    templatenumb[aLang] := Lines.Count;
    SetLength(templates[aLang], templatenumb[aLang]);
    for i:=0 to Lines.Count-1 do
      templates[aLang][i] := Lines[i];
  end;
end;

procedure DisplayTemplateValues(const aLang : integer);
var
  i : integer;
begin
  {Displays the values in the form}
  with PrefForm.NewTemplatesList do
  begin
    Lines.Clear;
    for i:= 1 to templatenumb[aLang] do
      Lines.Add(templates[aLang][i-1]);
    CaretY := 1;
    EnsureCursorPosVisible;
  end;
  with PrefForm do
  begin
    cboLangTemp.OnChange := nil;
    try
      cboLangTemp.ItemIndex := aLang;
    finally
      cboLangTemp.OnChange := cboLangTempChange;
    end;
  end;
end;

{The Macros Information}

procedure RememberMacroValues;
begin
{Remember current settings such that we know whether changed}
  // Nothing to be done
end;

procedure GetMacroValues;
var
  i : integer;
  str : string;
begin
  {Gets the values from the form}
  MacrosChanged := false;
  macronumb:=0;
  for i:=0 to PrefForm.MacrosList.Items.Count-1 do
  begin
    str:='<Ctrl><Alt>';
    str:=str+ PrefForm.MacrosList.Items[i][1]+':';
    str:=str+Copy(PrefForm.MacrosList.Items[i],4,1000);
    if (Length(str)>13) then
    begin
      macronumb:=macronumb+1;
      if (str <> macros[macronumb]) then MacrosChanged := true;
      macros[macronumb] := str;
    end
  end;
  for i:=0 to PrefForm.ShiftMacrosList.Items.Count-1 do
  begin
    str:='<Ctrl><Alt><Shift>';
    str:=str+ PrefForm.ShiftMacrosList.Items[i][1]+':';
    str:=str+Copy(PrefForm.ShiftMacrosList.Items[i],4,1000);
    if (Length(str)>20) then
    begin
      macronumb:=macronumb+1;
      if (str <> macros[macronumb]) then MacrosChanged := true;
      macros[macronumb] := str;
    end
  end;
end;

procedure DisplayMacroValues;
var
  i, numb : integer;
begin
  {Displays the values in the form}
  PrefForm.MacrosList.Items.Clear;
  PrefForm.ShiftMacrosList.Items.Clear;
  for i:=1 to 26 do PrefForm.MacrosList.Items.Add(Chr(Ord('A')+i-1)+': ');
  for i:=1 to 10 do PrefForm.MacrosList.Items.Add(Chr(Ord('0')+i-1)+': ');
  for i:=1 to 26 do PrefForm.ShiftMacrosList.Items.Add(Chr(Ord('A')+i-1)+': ');
  for i:=1 to 10 do PrefForm.ShiftMacrosList.Items.Add(Chr(Ord('0')+i-1)+': ');
  for i:= 1 to macronumb do
  begin
    if Pos('<Shift>',macros[i]) = 12 then
    begin
      numb:=Ord(macros[i][19])-Ord('A');
      if (numb<0) or (numb>25) then numb:=Ord(macros[i][19])-Ord('0')+26;
      PrefForm.ShiftMacrosList.Items[numb] := macros[i][19]+': '+ Copy(macros[i],21,1000);
    end else begin
      numb:=Ord(macros[i][12])-Ord('A');
      if (numb<0) or (numb>25) then numb:=Ord(macros[i][12])-Ord('0')+26;
      PrefForm.MacrosList.Items[numb] := macros[i][12]+': '+ Copy(macros[i],14,1000);
    end;
  end;
  PrefForm.MacrosList.ItemIndex:=0;
  PrefForm.ShiftMacrosList.ItemIndex:=0;
  PrefForm.MacrosList.Visible:=true;
  PrefForm.ShiftMacrosList.Visible:=false;
  PrefForm.MShift.Down := false;
end;

{ TTransferItem }

procedure TTransferItem.Assign(TI: TTransferItem);
begin
  Title      := TI.Title;
  Path       := TI.Path;
  WorkingDir := TI.WorkingDir;
  Params     := TI.Params;
  Wait       := TI.Wait;
  Close      := TI.Close;
  Restrict   := TI.Restrict;
  Extension  := TI.Extension;
end;

function PreferredLanguageName : string;
begin
  case LocalFirmwareType of
    ftStandard :
      begin
        case PreferredLanguage of
          1 : Result := 'MindScript';
          2 : Result := 'LEGO Assembler';
          3 : Result := 'Next Byte Codes';
          4 : Result := 'NXC';
        else
          Result := 'NQC';
        end;
      end;
    ftBrickOS : Result := 'C++';
    ftPBForth : Result := 'Forth';
    ftLeJOS   : Result := 'Java';
  end;
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
    ResetAPIValues(fReg);
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
    GetGutterValues;
    GetOtherOptionValues;
    GetShortcutValues;
    GetKeystrokeValues;
    GetAPIValues;
  end;
// when we close the form we should focus the first control on the general page
  pagPrefs.ActivePage := shtGeneral;
  ActiveControl       := CheckSavePos;
end;

procedure TPrefForm.FormShow(Sender: TObject);
begin
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
end;

procedure TPrefForm.FormCreate(Sender: TObject);
var
  i : integer;
begin
  cc_keywords := CreateSortedStringList;
  cc_commands := CreateSortedStringList;
  cc_constants := CreateSortedStringList;
  cc_nxc_keywords := CreateSortedStringList;
  cc_nxc_commands := CreateSortedStringList;
  cc_nxc_constants := CreateSortedStringList;
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
  GetHighlighters(Self, LocalHighlighters, False);
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
  LoadAllValues(fReg, Keystrokes, CodeTemplates);
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
  FreeAndNil(cc_keywords);
  FreeAndNil(cc_commands);
  FreeAndNil(cc_constants);
  FreeAndNil(cc_nxc_keywords);
  FreeAndNil(cc_nxc_commands);
  FreeAndNil(cc_nxc_constants);
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
end;

procedure TPrefForm.UpdateGlobalOtherOptionValues;
begin
  AddMenuItemsToNewMenu := chkNewMenu.Checked;
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

procedure CleanupTransferList(aList : TList);
var
  i : integer;
begin
  if Assigned(aList) then
  begin
    for i := 0 to aList.Count - 1 do
    begin
      TObject(aList[i]).Free;
    end;
    FreeAndNil(aList);
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


{$IFNDEF VER_D7_UP}
function IncludeTrailingPathDelimiter(const S: string): string;
begin
  result := IncludeTrailingBackslash(S);
end;

function ExcludeTrailingPathDelimiter(const S: string): string;
begin
  result := ExcludeTrailingBackslash(S);
end;
{$ENDIF}

function GetUseMDIMode : Boolean;
var
  R : TRegistry;
begin
  R := TRegistry.Create;
  try
    Reg_OpenKey(R, 'General');
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
  SynNXCSyn        := TSynNQCSyn.Create(Self);
  SynRSSyn         := TSynRSSyn.Create(Self);
  SynROPSSyn       := TSynROPSSyn.Create(Self);
  SynLASMSyn       := TSynLASMSyn.Create(Self);
  SynLuaSyn        := TSynLuaSyn.Create(Self);
  SynRubySyn       := TSynRubySyn.Create(Self);
  SynPasSyn        := TSynPasSyn.Create(Self);
  SynNBCSyn        := TSynNBCSyn.Create(Self);
  SynCSSyn         := TSynCSSyn.Create(Self);
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
    LanguageName := 'NQC';
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
    LanguageName := 'NXC';
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
  edtNQCExePath := TDirectoryEdit.Create(Self);
  edtLCCExePath := TDirectoryEdit.Create(Self);
  edtNBCExePath := TDirectoryEdit.Create(Self);
  edtCygwin     := TDirectoryEdit.Create(Self);
  edtJavaPath   := TDirectoryEdit.Create(Self);
  edtLeJOSRoot  := TDirectoryEdit.Create(Self);
  CloneDE(edtNQCExePath, edtNQCExePath2);
  CloneDE(edtLCCExePath, edtLCCExePath2);
  CloneDE(edtNBCExePath, edtNBCExePath2);
  CloneDE(edtCygwin, edtCygwin2);
  CloneDE(edtJavaPath, edtJavaPath2);
  CloneDE(edtLeJOSRoot, edtLeJOSRoot2);
end;

procedure TPrefForm.CreateSynEditComponents;
begin
  NewTemplatesList := TSynEdit.Create(Self);
  SynEditColors    := TSynEdit.Create(Self);
  CloneSynEdit(NewTemplatesList, NewTemplatesList2);
  CloneSynEdit(SynEditColors, SynEditColors2);
  NewTemplatesList.Gutter.Visible := False;
end;

function TPrefForm.CreateSortedStringList: TStringList;
begin
  Result := TStringList.Create;
  Result.Sorted := True;
  Result.Duplicates := dupIgnore;
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

initialization
  fVersion := GetVersionInfo(Application.ExeName).ProductVersion;

finalization
  CleanupTransferList(fCompXferList);
  CleanupTransferList(fTransferList);
  CleanupTransferList(fPrecompileSteps);
  CleanupTransferList(fPostcompileSteps);
  FreeAndNil(fHighlighters);
  RecentFiles := nil;
end.
