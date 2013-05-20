unit uBasicPrefs;

interface

uses
  Classes, ExtCtrls, Graphics, Registry, Menus, SynEditHighlighter,
  uParseCommon, SynHighlighterNQC;

type
  TMenuItemType = class of TMenuItem;
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

{ Other Shortcuts }
var
  TheMenuItemType : TMenuItemType = TMenuItem;
  CodeCompShortCut : TShortCut;
  ParamCompShortCut : TShortCut;
  RecMacroShortCut : TShortCut;
  PlayMacroShortCut : TShortCut;

var
  SaveBackup:boolean;        // Whether to save backups of existing files
  AutoSaveFiles : Boolean;
  AutoSaveDesktop : Boolean;
  MultiFormatCopy : Boolean;
  DroppedRecent : Boolean;
  CompilerTimeout : Integer;

{Macros}
const
  MAXMACRO = 200;
var
  macros:array[1..MAXMACRO] of string;
  macronumb:integer;
  MacrosChanged:boolean;

{Editor}
var
  ColorsChanged : boolean;   // Whether color scheme was changed
  ColorCoding:boolean;       // Whether to use color coding
//  ColorCodingChanged:boolean;// Whether ColorCoding was changed
  FontName:string;           // Name of the font
  FontSize:integer;          // Size of the font
//  FontChanged:boolean;       // Whether the font changed
  AutoIndentCode:boolean;    // Whether to automatically indent code
  MacrosOn:boolean;          // Whether macros can be used
  RICDecompAsData:boolean;
  RICDecompNameFormat : string;
  MaxEditWindows : Boolean;
  HideSelection : boolean;
  CCInsensitive : boolean;
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
  BracketHighlightForeground : TColor;
  BracketHighlightBackground : TColor;
  HighlightBrackets : Boolean;

{ Gutter }
var
  GutterColor : TColor;
  GutterWidth : integer;
  DigitCount : integer;
  LeftOffset : integer;
  RightOffset : integer;
  ShowLeadingZeros : boolean;
  AutoSizeGutter : boolean;
  GutterVisible : boolean;
  UseFontStyle : boolean;
  SelectOnClick : boolean;

var
  dockPanel : TPanel = nil;
  panelSplitter : TSplitter = nil;
  WatchPoints : Byte = 10;
  ShowStatusbar:boolean;     // Whether to show the statusbar
  DefaultMacroLibrary : string;

var
  CodeExplorerSettings : TCodeExplorerProperties;
  ParseTimeout : Integer;
  LocalCompilerTimeout : integer;
  ProcedureListSettings : TProcedureListProperties;
  ZeroStart : boolean;
  ShowLineNumbers : boolean;
  CompilerDebug : boolean;
  ShowCompilerStatus : boolean;
  GutterLNMultiple : integer;

var
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

{Templates}
const
  NUM_LANGS = 17;
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

var
  CurrentProgramSlot : Integer = 0;
  CurrentLNPAddress : Integer = 0;
  CurrentLNPPort : Integer = 0;
  PreferredLanguage : Integer;
  CompilerSwitches : string;
  NQCSwitches : string;
  LCCSwitches : string;
  NBCSwitches : string;
  CPPSwitches : string;
  JavaSwitches : string;
  NQCIncludePath : string;
  OldNQCIncPaths : string;
  LCCIncludePath : string;
  OldLCCIncPaths : string;
  NBCIncludePath : string;
  OldNBCIncPaths : string;
  JavaCompilerPath : string;
  LeJOSRoot :  string;
  CygwinDir :  string;
  BrickOSRoot :  string;
  BrickOSMakefileTemplate : string;
  PascalCompilerPrefix : string;
  LeJOSMakefileTemplate : string;
  KeepBrickOSMakefile : Boolean;
  KeepLeJOSMakefile : Boolean;
  IgnoreSysFiles : Boolean;
  IncludeSrcInList : Boolean;
  SaveBinaryOutput : Boolean;
  ProgramDir : string;
  DefaultDir : string;
  ShowRecent:boolean;        // Whether to show recent files
//  ShowRecentChanged:boolean; // Whether ShowRecent was changed
  MaxRecent : Byte = 4;
  

var
  NQCExePath : string;
  LCCExePath : string;
  NBCExePath : string;
  NBCOptLevel : byte;
  NBCMaxErrors : word;
  UseInternalNBC : Boolean;
  NXT2Firmware : Boolean;
  EnhancedFirmware : Boolean;
  NXTAutoFWVersion : Boolean;

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

var RecentFiles : array of string = nil;

function DefaultPath : string;
function NQCPath : string;
function LCCPath : string;
function NBCPath : string;

function GetHighlighterForFile(AFileName: string): TSynCustomHighlighter;
function CompXferList : Tlist;
function TransferList : Tlist;
function Highlighters : TStringList;
function PrecompileSteps : Tlist;
function PostcompileSteps : Tlist;
procedure CleanupTransferList(aList : TList);

{Recent Files}
procedure ShowRecentFiles(parent : TMenuItem; handler : TNotifyEvent);
function GetRecentFileName(i : Byte) : string;
procedure AddRecentFile(str:string);
procedure ResetRecentValues(reg : TRegistry);
procedure SaveRecentValues(reg : TRegistry);
procedure LoadRecentValues(reg : TRegistry);
procedure SetMaxRecent(val : Byte);

function BricxCCIntToStr(const val : integer) : string;
function PreferredLanguageName : string;

const
{$IFDEF FPC}
{$IFDEF LCLcarbon}
  K_EDITOR_FONTNAME_DEFAULT = 'Monaco';
{$ELSE}
  K_EDITOR_FONTNAME_DEFAULT = 'Courier 10 Pitch';
{$ENDIF}
  K_EDITOR_COLOR_DEFAULT    = clWhite;
  K_SEL_FG_COLOR_DEFAULT    = clWhite;
  K_SEL_BG_COLOR_DEFAULT    = clNavy;
  K_ALINE_COLOR_DEFAULT     = clWhite;
  K_REDGE_COLOR_DEFAULT     = clSilver;
  K_STRUCT_COLOR_DEFAULT    = clNone;
  K_GUTTER_COLOR_DEFAULT    = clSilver;
  K_BH_FG_COLOR_DEFAULT     = clNone;
  K_BH_BG_COLOR_DEFAULT     = clSilver;
{$ELSE}
  K_EDITOR_FONTNAME_DEFAULT = 'Courier New';
  K_EDITOR_COLOR_DEFAULT    = clWindow;
  K_SEL_FG_COLOR_DEFAULT    = clHighlightText;
  K_SEL_BG_COLOR_DEFAULT    = clHighlight;
  K_ALINE_COLOR_DEFAULT     = clWindow;
  K_REDGE_COLOR_DEFAULT     = clSilver;
  K_STRUCT_COLOR_DEFAULT    = clNone;
  K_GUTTER_COLOR_DEFAULT    = clBtnFace;
  K_BH_FG_COLOR_DEFAULT     = clNone;
  K_BH_BG_COLOR_DEFAULT     = clMenu;
{$ENDIF}

procedure ResetProcListValues(reg : TRegistry);
procedure SaveProcListValues(reg : TRegistry);
procedure LoadProcListValues(reg : TRegistry);
procedure ResetExplorerValues(reg : TRegistry);
procedure SaveExplorerValues(reg : TRegistry);
procedure LoadExplorerValues(reg : TRegistry);
function ExePath : string;
function StrToBool(aStr : string) : boolean;
function BoolToStr(aVal : boolean) : string;

procedure ResetTemplateValues(reg : TRegistry);
procedure SaveTemplateValues(const aLang : integer; reg : TRegistry);
procedure LoadTemplateValues(const aLang : integer; reg : TRegistry);

function CreateSortedStringList(bCaseSensitive : boolean = false): TStringList;
procedure PutAPIValuesInSyntaxHighlighter(key, com, con : TStringList;
  aPrefHL, aMainHL : TSynBaseNCSyn);
procedure LoadNXCAPIValues(reg : TRegistry; aPrefHL, aMainHL : TSynBaseNCSyn);
procedure SaveNXCAPIValues(reg : TRegistry);
procedure ResetNXCAPIValues(reg : TRegistry; aPrefHL, aMainHL : TSynBaseNCSyn);
procedure LoadSPCAPIValues(reg : TRegistry; aPrefHL, aMainHL : TSynBaseNCSyn);
procedure SaveSPCAPIValues(reg : TRegistry);
procedure ResetSPCAPIValues(reg : TRegistry; aPrefHL, aMainHL : TSynBaseNCSyn);
procedure LoadBasicGeneralValues(reg : TRegistry);
procedure ResetEditorValues(reg : TRegistry);
procedure LoadBasicCompilerValues(reg : TRegistry);
procedure ResetGutterValues(reg : TRegistry);
procedure ResetShortcutValues(reg : TRegistry);
procedure ResetCodeTemplateValues(reg : TRegistry; S : TStrings);
procedure LoadBasicValues(reg : TRegistry; S : TStrings);
procedure SaveBasicValues(reg : TRegistry; S : TStrings);
procedure ResetBasicValues(reg : TRegistry; S : TStrings);

procedure RememberOtherOptionValues;
procedure RememberGutterValues;
procedure RememberAPIValues;
procedure RememberCompilerValues;
procedure RememberEditorValues;
procedure RememberGeneralValues;
procedure RememberTemplateValues;
procedure RememberShortcutValues;

function ColorCodingChanged : boolean;
function FontChanged : boolean;
function ShowRecentChanged : boolean;

var
  cc_nxc_keywords: TStringList;
  cc_nxc_commands: TStringList;
  cc_nxc_constants: TStringList;

var
  cc_spc_commands: TStringList;
  cc_spc_constants: TStringList;

var
  UseHTMLHelp : boolean;
  DeleteSymFileAfterLoading : boolean;

implementation

uses
  SysUtils, Forms, ComCtrls, uRegUtils, uHighlighterProcs, uMiscDefines,
  uNXTExplorerSettings, uEditorExperts, uJoyGlobals, uRemoteGlobals,
  uWatchGlobals, uNXTImageGlobals, uGlobals, uSimpleTerminalGlobals;

const
  K_DEF_MACRO_LIB = 'bricxcc.mlb';

var
  fHighlighters : TStringList;
  fCompXferList : TList;
  fTransferList : TList;
  fPrecompileSteps : TList;
  fPostcompileSteps : TList;

function DefaultPath : string;
begin
  case PreferredLanguage of
    1 : Result := LCCPath;
    2 : Result := LCCPath;
    3 : Result := NBCPath;
    4 : Result := NBCPath;
    5 : Result := NBCPath;
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

{ The Recent Files Information}

function GetRecentFileName(i : Byte) : string;
begin
  Result := RecentFiles[i];
end;

procedure ShowRecentFiles(parent : TMenuItem; handler : TNotifyEvent);
var
  i, j, sepIdx : Integer;
  MI : TMenuItem;
  sep : TMenuItem;
begin
  for i := parent.Count - 1 downto 0 do
  begin
    MI := TMenuItem(parent.Items[i]);
    if Pos('Recent', MI.Name) = 1 then
      MI.Free;
  end;

  if not ShowRecent then Exit;

  sepIdx := -1;
  for i := parent.Count - 1 downto 0 do
  begin
    MI := TMenuItem(parent.Items[i]);
    if MI.Name = 'mniSepFiles' then
      sepIdx := i;
  end;
  // if we didn't find the separator then bail out
  if sepIdx = -1 then Exit;

  sep := TMenuItem(parent.Items[sepIdx]);
  sep.Visible := False;

  j := sepIdx + 1;
  for i := Low(RecentFiles) to High(RecentFiles) do
  begin
    if RecentFiles[i] <> '' then
    begin
      sep.Visible := True;
      // create new
      MI := TheMenuItemType.Create(parent);
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
      RecentFiles[i] := Reg_ReadString(reg, 'RecentFiles'+BricxCCIntToStr(i+1),'');
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
      reg.WriteString('RecentFiles'+BricxCCIntToStr(i+1),RecentFiles[i]);
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

function BricxCCIntToStr(const val : integer) : string;
begin
  Result := IntToStr(val div 100) +
            IntToStr((val mod 100) div 10) +
            IntToStr(val mod 10);
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
          5 : Result := 'SPC';
          6 : Result := 'EVC';
        else
          if LocalBrickType = SU_NXT then
            Result := 'NXC'
          else if LocalBrickType = SU_EV3 then
            Result := 'EVC'
          else
            Result := 'NQC';
        end;
        if LocalBrickType = SU_SPRO then
          Result := 'SPC'
        else if (LocalBrickType = SU_NXT) and (PreferredLanguage <> 3) then
          Result := 'NXC';
      end;
    ftBrickOS : Result := 'C++';
    ftPBForth : Result := 'Forth';
    ftLeJOS   : Result := 'Java';
  end;
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

function ExePath : string;
begin
  Result := ExtractFilePath(Application.ExeName);
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

{Templates}

function LanguageIndexToName(const aLang : integer) : string;
begin
  if (aLang >= 0) and (aLang < Highlighters.Count) then
    Result := Highlighters[aLang]
  else
    Result := BricxCCIntToStr(aLang);
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
    fName := ProgramDir+DefaultDir+LanguageIndexToName(aLang)+'_templates.txt';
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
        if Pos(BricxCCIntToStr(aLang)+'_Template', SL[i]) = 1 then
          inc(templatenumb[aLang]);
      end;
    finally
      SL.Free;
    end;
    SetLength(templates[aLang], templatenumb[aLang]);
    i := 1;
    idx := 1;
    valName := BricxCCIntToStr(aLang)+'_Template'+BricxCCIntToStr(idx);
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
      valName := BricxCCIntToStr(aLang)+'_Template'+BricxCCIntToStr(idx);
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
    reg.WriteString(BricxCCIntToStr(aLang)+'_Template'+BricxCCIntToStr(i),templates[aLang][i-1]);
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

function CreateSortedStringList(bCaseSensitive : boolean): TStringList;
begin
  Result := TStringList.Create;
  Result.CaseSensitive := bCaseSensitive;
  Result.Sorted := True;
  Result.Duplicates := dupIgnore;
end;

procedure PutAPIValuesInSyntaxHighlighter(key, com, con : TStringList;
  aPrefHL, aMainHL : TSynBaseNCSyn);
begin
  if Assigned(aPrefHL) then
  begin
    if Assigned(key) then
      aPrefHL.KeyWords.Assign(key);
    if Assigned(com) then
      aPrefHL.Commands.Assign(com);
    if Assigned(con) then
      aPrefHL.Constants.Assign(con);
  end;
  if Assigned(aMainHL) then
  begin
    if Assigned(key) then
      aMainHL.KeyWords.Assign(key);
    if Assigned(com) then
      aMainHL.Commands.Assign(com);
    if Assigned(con) then
      aMainHL.Constants.Assign(con);
  end;
end;

procedure LoadNXCAPIValues(reg : TRegistry; aPrefHL, aMainHL : TSynBaseNCSyn);
var
  i:integer;
  SL : TStringList;
  tmpStr : string;
begin
  {first we populate our dynamic arrays from the highlighter if it exists}
  if Assigned(aPrefHL) then
  begin
    // nxc
    cc_nxc_keywords.Assign(aPrefHL.KeyWords);
    cc_nxc_commands.Assign(aPrefHL.Commands);
    cc_nxc_constants.Assign(aPrefHL.Constants);
  end;
  {Loads the NXC keyword values from the registry}
  if not Reg_KeyExists(reg, 'NXC_Keywords') then
  begin
    // no registry key so load from file instead
    tmpStr := ProgramDir+DefaultDir+'nxc_keywords.txt';
    if FileExists(tmpStr) then
      cc_nxc_keywords.LoadFromFile(tmpStr);
    tmpStr := ProgramDir+DefaultDir+'nxc_constants.txt';
    if FileExists(tmpStr) then
      cc_nxc_constants.LoadFromFile(tmpStr);
    SL := TStringList.Create;
    try
      tmpStr := ProgramDir+DefaultDir+'nxc_api.txt';
      if FileExists(tmpStr) then
      begin
        SL.LoadFromFile(tmpStr);
        for i := 0 to SL.Count - 1 do
        begin
          tmpStr := SL[i];
          SL[i] := Copy(tmpStr, 1, Pos('(', tmpStr)-1);
        end;
        cc_nxc_commands.Assign(SL);
      end;
    finally
      SL.Free;
    end;
  end
  else
  begin
    Reg_OpenKey(reg, 'NXC_Keywords');
    try
      cc_nxc_keywords.Text := Reg_ReadString(reg, 'Keywords', '');
    finally
      reg.CloseKey;
    end;

    Reg_OpenKey(reg, 'NXC_Commands');
    try
      cc_nxc_commands.Text := Reg_ReadString(reg, 'Commands', '');
    finally
      reg.CloseKey;
    end;

    Reg_OpenKey(reg, 'NXC_Constants');
    try
      cc_nxc_constants.Text := Reg_ReadString(reg, 'Constants', '');
    finally
      reg.CloseKey;
    end;
  end;
  PutAPIValuesInSyntaxHighlighter(cc_nxc_keywords, cc_nxc_commands, cc_nxc_constants, aPrefHL, aMainHL);
end;

procedure SaveNXCAPIValues(reg : TRegistry);
begin
  {Saves the keyword values to the registry}
  // NXC
  Reg_DeleteKey(reg, 'NXC_Keywords');
  Reg_OpenKey(reg, 'NXC_Keywords');
  try
    reg.WriteString('Keywords', cc_nxc_keywords.Text);
  finally
    reg.CloseKey;
  end;

  Reg_DeleteKey(reg, 'NXC_Commands');
  Reg_OpenKey(reg, 'NXC_Commands');
  try
    reg.WriteString('Commands', cc_nxc_commands.Text);
  finally
    reg.CloseKey;
  end;

  Reg_DeleteKey(reg, 'NXC_Constants');
  Reg_OpenKey(reg, 'NXC_Constants');
  try
    reg.WriteString('Constants', cc_nxc_constants.Text);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetNXCAPIValues(reg : TRegistry; aPrefHL, aMainHL : TSynBaseNCSyn);
begin
{Resets the keyword values to default}
  Reg_DeleteKey(reg, 'NXC_Keywords');
  Reg_DeleteKey(reg, 'NXC_Commands');
  Reg_DeleteKey(reg, 'NXC_Constants');
  LoadNXCAPIValues(reg, aPrefHL, aMainHL);
end;

procedure LoadSPCAPIValues(reg : TRegistry; aPrefHL, aMainHL : TSynBaseNCSyn);
var
  i:integer;
  SL : TStringList;
  tmpStr : string;
begin
  {first we populate our dynamic arrays from the highlighter if it exists}
  if Assigned(aPrefHL) then
  begin
    // spc
    cc_spc_commands.Assign(aPrefHL.Commands);
    cc_spc_constants.Assign(aPrefHL.Constants);
  end;
  {Loads the SPC commands and constants from the registry}
  if not Reg_KeyExists(reg, 'SPC_Commands') then
  begin
    // no registry key so load from file instead
    tmpStr := ProgramDir+DefaultDir+'spc_constants.txt';
    if FileExists(tmpStr) then
      cc_spc_constants.LoadFromFile(tmpStr);
    SL := TStringList.Create;
    try
      tmpStr := ProgramDir+DefaultDir+'spc_api.txt';
      if FileExists(tmpStr) then
      begin
        SL.LoadFromFile(tmpStr);
        for i := 0 to SL.Count - 1 do
        begin
          tmpStr := SL[i];
          // skip the return type ?
          SL[i] := Copy(tmpStr, 1, Pos('(', tmpStr)-1);
        end;
        cc_spc_commands.Assign(SL);
      end;
    finally
      SL.Free;
    end;
  end
  else
  begin
    Reg_OpenKey(reg, 'SPC_Commands');
    try
      cc_spc_commands.Text := Reg_ReadString(reg, 'Commands', '');
    finally
      reg.CloseKey;
    end;

    Reg_OpenKey(reg, 'SPC_Constants');
    try
      cc_spc_constants.Text := Reg_ReadString(reg, 'Constants', '');
    finally
      reg.CloseKey;
    end;
  end;
  PutAPIValuesInSyntaxHighlighter(nil, cc_spc_commands, cc_spc_constants, aPrefHL, aMainHL);
end;

procedure SaveSPCAPIValues(reg : TRegistry);
begin
  {Saves the keyword values to the registry}
  // SPC
  Reg_DeleteKey(reg, 'SPC_Commands');
  Reg_OpenKey(reg, 'SPC_Commands');
  try
    reg.WriteString('Commands', cc_spc_commands.Text);
  finally
    reg.CloseKey;
  end;

  Reg_DeleteKey(reg, 'SPC_Constants');
  Reg_OpenKey(reg, 'SPC_Constants');
  try
    reg.WriteString('Constants', cc_spc_constants.Text);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetSPCAPIValues(reg : TRegistry; aPrefHL, aMainHL : TSynBaseNCSyn);
begin
{Resets the keyword values to default}
  Reg_DeleteKey(reg, 'SPC_Commands');
  Reg_DeleteKey(reg, 'SPC_Constants');
  LoadSPCAPIValues(reg, aPrefHL, aMainHL);
end;

var
  OldShowRecent : boolean;   // For saving the old version

procedure RememberGeneralValues;
begin
{Remember current settings such that we know whether changed}
  OldShowRecent := ShowRecent;
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

procedure RememberCompilerValues;
begin
end;

{ The API information }

procedure RememberAPIValues;
begin
end;

{The Gutter Information}

procedure RememberGutterValues;
begin
end;

{Other Options Information}

procedure RememberOtherOptionValues;
begin
end;

procedure RememberTemplateValues;
begin
  {Remember current settings such that we know whether changed}
  TemplatesChanged := false;
end;

procedure RememberShortcutValues;
begin
end;

function ColorCodingChanged : boolean;
begin
  Result := (ColorCoding <> OldColorCoding);
end;

function FontChanged : boolean;
begin
  Result := (FontName <> OldFontName) or (FontSize <> OldFontSize);
end;

function ShowRecentChanged : boolean;
begin
  Result := (ShowRecent <> OldShowRecent);
end;

procedure LoadBasicGeneralValues(reg : TRegistry);
begin
  {Loads the general values from the registry}
  Reg_OpenKey(reg, 'General');
  try
    ShowRecent         := Reg_ReadBool(reg, 'ShowRecent',True);
    SaveBackup         := Reg_ReadBool(reg, 'SaveBackup',True);
    ShowStatusbar      := Reg_ReadBool(reg, 'ShowStatusbar',True);
    ShowCompilerStatus := Reg_ReadBool(reg, 'ShowCompilerStatus', False);
    AutoSaveFiles      := Reg_ReadBool(reg, 'AutoSaveFiles', False);
    SaveBinaryOutput   := Reg_ReadBool(reg, 'SaveBinaryOutput', False);
    MultiFormatCopy    := Reg_ReadBool(reg, 'MultiFormatCopy', False);
    DroppedRecent      := Reg_ReadBool(reg, 'DroppedRecent', False);
    TemplatesUseDblClick := Reg_ReadBool(reg, 'TemplatesUseDoubleClick', False);
    // NXT Explorer settings
    NXTFilesViewStyle  := TViewStyle(Reg_ReadInteger(reg, 'NXTFilesViewStyle', Ord(vsIcon)));
    PCFilesViewStyle   := TViewStyle(Reg_ReadInteger(reg, 'PCFilesViewStyle', Ord(vsIcon)));
    NXTExplorerMaskIndex := Reg_ReadInteger(reg, 'NXTExplorerMaskIndex', 0);
    NXTExplorerPath      := Reg_ReadString(reg, 'NXTExplorerPath', 'c:\');

    DefaultMacroLibrary := Reg_ReadString(reg, 'DefaultMacroLibrary', ExePath + K_DEF_MACRO_LIB);
    ParseTimeout        := Reg_ReadInteger(reg, 'ParseTimeout', 2000);

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

    UseHTMLHelp               := Reg_ReadBool(reg, 'UseHTMLHelp', true);
    DeleteSymFileAfterLoading := Reg_ReadBool(reg, 'DeleteSymFileAfterLoading', false);
    UserDataLocalPath         := Reg_ReadString(reg, 'UserDataLocalPath', UserDataLocalPath);
    SymFileLibraryPath        := Reg_ReadString(reg, 'SymFileLibraryPath', SymFileLibraryPath);
    
  finally
    reg.CloseKey;
  end;
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
    FontSize            := Reg_ReadInteger(reg, 'FontSize', 12);
    AutoIndentCode      := Reg_ReadBool(reg, 'AutoIndentCode', true);
    MacrosOn            := Reg_ReadBool(reg, 'MacrosOn', false);
    RICDecompAsData     := Reg_ReadBool(reg, 'RICDecompAsData', false);
    RICDecompNameFormat := Reg_ReadString(reg, 'RICDecompNameFormat', '%s');
    HideSelection       := Reg_ReadBool(reg, 'HideSelection', false);
    CCInsensitive       := Reg_ReadBool(reg, 'CCInsensitive', false);
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
    BracketHighlightForeground := Reg_ReadColor(reg, 'BracketHighlightFG', K_BH_FG_COLOR_DEFAULT);
    BracketHighlightBackground := Reg_ReadColor(reg, 'BracketHighlightBG', K_BH_BG_COLOR_DEFAULT);
    HighlightBrackets   := Reg_ReadBool(reg, 'HighlightBrackets', true);
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

procedure LoadBasicCompilerValues(reg : TRegistry);
begin
  {Loads the compiler values from the registry}
  Reg_OpenKey(reg, 'Compiler');
  try
    CompilerTimeout         := Reg_ReadInteger(reg, 'CompilerTimeout', 60000);
    LocalCompilerTimeout    := CompilerTimeout;
    CompilerSwitches        := Reg_ReadString(reg, 'CompilerSwitches', '');
    PreferredLanguage       := Reg_ReadInteger(reg, 'PreferredLanguage', 4);
    NBCSwitches             := Reg_ReadString(reg, 'NBCSwitches', '');
    NBCOptLevel             := Reg_ReadInteger(reg, 'NBCOptLevel', 2);
    NBCMaxErrors            := Reg_ReadInteger(reg, 'NBCMaxErrors', 0);
    NBCIncludePath          := Reg_ReadString(reg, 'NBCIncludePath', '');
    OldNBCIncPaths          := Reg_ReadString(reg, 'OldNBCIncPaths', '');
    NBCExePath              := Reg_ReadString(reg, 'NBCExePath', '');
    UseInternalNBC          := Reg_ReadBool(reg, 'UseInternalNBC', True);
    EnhancedFirmware        := Reg_ReadBool(reg, 'EnhancedFirmware', True);
    NXT2Firmware            := Reg_ReadBool(reg, 'NXT2Firmware', True);
    NXTAutoFWVersion        := Reg_ReadBool(reg, 'NXTAutoFWVersion', True); 
    IgnoreSysFiles          := Reg_ReadBool(reg, 'IgnoreSysFiles', False);
  finally
    reg.CloseKey;
  end;
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
    ShowLineNumbers  := Reg_ReadBool(reg, 'ShowLineNumbers', true);
    GutterLNMultiple := Reg_ReadInteger(reg, 'GutterLNMultiple', 5);
    ShowLeadingZeros := Reg_ReadBool(reg, 'ShowLeadingZeros', false);
    ZeroStart        := Reg_ReadBool(reg, 'ZeroStart', false);
    AutoSizeGutter   := Reg_ReadBool(reg, 'AutoSizeGutter', true);
    GutterVisible    := Reg_ReadBool(reg, 'GutterVisible', true);
    UseFontStyle     := Reg_ReadBool(reg, 'UseFontStyle', false);
    SelectOnClick    := Reg_ReadBool(reg, 'SelectOnClick', false);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetGutterValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'Gutter');
  LoadGutterValues(reg);
end;

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

procedure LoadEditorExpertValues(reg : TRegistry);
var
  ee : TEditorExpert;
begin
  Reg_OpenKey(reg, 'EditorExpertShortcuts');
  try
    for ee := Low(TEditorExpert) to High(TEditorExpert) do
      EditorExpertShortcuts[ee] := Reg_ReadInteger(reg, ExpertName(ee), DefaultEditorExpertShortcuts[ee]);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetShortcutValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'Shortcuts');
  LoadShortcutValues(reg);
end;

procedure ResetEditorExpertValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'EditorExpertShortcuts');
  LoadEditorExpertValues(reg);
end;

procedure LoadCodeTemplateValues(reg : TRegistry; S : TStrings);
var
  tmpSL : TStringList;
  tmpPath : string;
begin
  if not Assigned(S) then Exit;
  tmpSL := TStringList.Create;
  try
    if not Reg_KeyExists(reg, 'CodeTemplates') then
    begin
      tmpPath := ProgramDir + DefaultDir + 'code.dci';
      if FileExists(tmpPath) then
        tmpSL.LoadFromFile(tmpPath);
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

procedure ResetCodeTemplateValues(reg : TRegistry; S : TStrings);
begin
  Reg_DeleteKey(reg, 'CodeTemplates');
  LoadCodeTemplateValues(reg, S);
end;

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

procedure ResetTransferValues(const aKey : string; aList : TList; reg : TRegistry);
begin
  Reg_DeleteKey(reg, aKey);
  LoadTransferValues(aKey, aList, reg);
end;

procedure LoadBasicValues(reg : TRegistry; S : TStrings);
var
  i : integer;
begin
  LoadBasicGeneralValues(reg);
  LoadEditorValues(reg);
  LoadBasicCompilerValues(reg);
  LoadJoystickValues(reg);
  LoadRemoteValues(reg);
  LoadSimpleTerminalValues(reg);
  LoadRecentValues(reg);
  for i := 0 to NUM_LANGS - 1 do
    LoadTemplateValues(i, reg);
  LoadGutterValues(reg);
  LoadShortcutValues(reg);
  LoadCodeTemplateValues(reg, S);
  LoadWatchValues(reg);
  LoadNXTImageValues(reg);
  LoadTransferValues('Transfer', TransferList, reg);
  LoadTransferValues('CompXfer', CompXferList, reg);
  LoadTransferValues('PrecompileSteps', PrecompileSteps, reg);
  LoadTransferValues('PostcompileSteps', PostcompileSteps, reg);
  LoadExplorerValues(reg);
  LoadProcListValues(reg);
  LoadEditorExpertValues(reg);
end;

procedure SaveBasicGeneralValues(reg : TRegistry);
begin
  {Saves the general values to the registry}
  Reg_DeleteKey(reg, 'General');
  Reg_OpenKey(reg, 'General');
  try
    reg.WriteBool('ShowRecent', ShowRecent);
    reg.WriteBool('SaveBackup', SaveBackup);
    reg.WriteBool('ShowStatusbar', ShowStatusbar);
    reg.WriteBool('ShowCompilerStatus', ShowCompilerStatus);
    reg.WriteBool('AutoSaveFiles', AutoSaveFiles);
    reg.WriteBool('SaveBinaryOutput', SaveBinaryOutput);
    reg.WriteBool('MultiFormatCopy', MultiFormatCopy);
    reg.WriteBool('DroppedRecent', DroppedRecent);
    reg.WriteBool('TemplatesUseDoubleClick', TemplatesUseDblClick);
    // NXT Explorer settings
    reg.WriteInteger('NXTFilesViewStyle', Ord(NXTFilesViewStyle));
    reg.WriteInteger('PCFilesViewStyle', Ord(PCFilesViewStyle));
    reg.WriteInteger('NXTExplorerMaskIndex', NXTExplorerMaskIndex);
    reg.WriteString('NXTExplorerPath', NXTExplorerPath);

    reg.WriteString('DefaultMacroLibrary', DefaultMacroLibrary);
    reg.WriteInteger('ParseTimeout', ParseTimeout);

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

    reg.WriteBool('UseHTMLHelp', UseHTMLHelp);
    reg.WriteBool('DeleteSymFileAfterLoading', DeleteSymFileAfterLoading);
    reg.WriteString('UserDataLocalPath', UserDataLocalPath);
    reg.WriteString('SymFileLibraryPath', SymFileLibraryPath);

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
    reg.WriteBool('CCInsensitive', CCInsensitive);
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
    Reg_WriteColor(reg, 'BracketHighlightFG', BracketHighlightForeground);
    Reg_WriteColor(reg, 'BracketHighlightBG', BracketHighlightBackground);
    reg.WriteBool('HighlightBrackets', HighlightBrackets);
  finally
    reg.CloseKey;
  end;
end;

procedure SaveBasicCompilerValues(reg : TRegistry);
begin
  {Saves the compiler values to the registry}
  Reg_DeleteKey(reg, 'Compiler');
  Reg_OpenKey(reg, 'Compiler');
  try
    reg.WriteInteger('CompilerTimeout', CompilerTimeout);
    reg.WriteString('CompilerSwitches', CompilerSwitches);
    reg.WriteInteger('PreferredLanguage', PreferredLanguage);
    reg.WriteString('NBCSwitches', NBCSwitches);
    reg.WriteInteger('NBCOptLevel', NBCOptLevel);
    reg.WriteInteger('NBCMaxErrors', NBCMaxErrors);
    reg.WriteString('NBCIncludePath', NBCIncludePath);
    reg.WriteString('OldNBCIncPaths', OldNBCIncPaths);
    reg.WriteString('NBCExePath', NBCExePath);
    reg.WriteBool('UseInternalNBC', UseInternalNBC);
    reg.WriteBool('EnhancedFirmware', EnhancedFirmware);
    reg.WriteBool('NXT2Firmware', NXT2Firmware);
    reg.WriteBool('NXTAutoFWVersion', NXTAutoFWVersion);
    reg.WriteBool('IgnoreSysFiles', IgnoreSysFiles);
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

procedure SaveCodeTemplateValues(reg : TRegistry; S : TStrings);
begin
  if not Assigned(S) then Exit;
  Reg_DeleteKey(reg, 'CodeTemplates');
  Reg_OpenKey(reg, 'CodeTemplates');
  try
    reg.WriteString('Data',S.Text);
  finally
    reg.CloseKey;
  end;
end;

procedure SaveEditorExpertValues(reg : TRegistry);
var
  ee : TEditorExpert;
begin
  Reg_DeleteKey(reg, 'EditorExpertShortcuts');
  Reg_OpenKey(reg, 'EditorExpertShortcuts');
  try
    for ee := Low(TEditorExpert) to High(TEditorExpert) do
      reg.WriteInteger(ExpertName(ee), EditorExpertShortcuts[ee]);
  finally
    reg.CloseKey;
  end;
end;



{ Transfer }
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

procedure SaveBasicValues(reg : TRegistry; S : TStrings);
var
  i : integer;
begin
  SaveBasicGeneralValues(reg);
  SaveEditorValues(reg);
  SaveBasicCompilerValues(reg);
  SaveJoystickValues(reg);
  SaveRemoteValues(reg);
  SaveSimpleTerminalValues(reg);
  SaveRecentValues(reg);
  SaveNXCAPIValues(reg);
  SaveSPCAPIValues(reg);
  for i := 0 to NUM_LANGS - 1 do
    SaveTemplateValues(i, reg);
  SaveGutterValues(reg);
  SaveShortcutValues(reg);
  SaveCodeTemplateValues(reg, S);
  SaveWatchValues(reg);
  SaveNXTImageValues(reg);
  SaveTransferValues('Transfer', TransferList, reg);
  SaveTransferValues('PrecompileSteps', PrecompileSteps, reg);
  SaveTransferValues('PostcompileSteps', PostcompileSteps, reg);
  SaveExplorerValues(reg);
  SaveProcListValues(reg);
  SaveEditorExpertValues(reg);
end;

procedure ResetBasicValues(reg : TRegistry; S : TStrings);
begin
  ResetEditorValues(reg);
  ResetJoystickValues(reg);
  ResetRemoteValues(reg);
  ResetRecentValues(reg);
  ResetTemplateValues(reg);
  ResetGutterValues(reg);
  ResetShortcutValues(reg);
  ResetCodeTemplateValues(reg, S);
  ResetWatchValues(reg);
  ResetNXTImageValues(reg);
  ResetTransferValues('Transfer', TransferList, reg);
  ResetTransferValues('PrecompileSteps', PrecompileSteps, reg);
  ResetTransferValues('PostcompileSteps', PostcompileSteps, reg);
  ResetExplorerValues(reg);
  ResetProcListValues(reg);
  ResetEditorExpertValues(reg);
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

initialization
  cc_nxc_keywords := CreateSortedStringList(true);
  cc_nxc_commands := CreateSortedStringList(true);
  cc_nxc_constants := CreateSortedStringList(true);
  cc_spc_commands := CreateSortedStringList(true);
  cc_spc_constants := CreateSortedStringList(true);
  // general defaults
  SetMaxRecent(MaxRecent);
  ShowRecent            := True;
  SaveBackup            := True;
  ShowStatusbar         := True;
  ShowCompilerStatus    := False;
  AutoSaveFiles         := False;
  AutoSaveDesktop       := False;
  SaveBinaryOutput      := False;
  MaxEditWindows        := False;
  MultiFormatCopy       := False;
  TemplatesUseDblClick  := False;
  ParseTimeout          := 2000;
  gbSearchBackwards     := false;
  gbSearchCaseSensitive := false;
  gbSearchFromCaret     := false;
  gbSearchSelectionOnly := false;
  gbSearchTextAtCaret   := true;
  gbSearchWholeWords    := false;
  gbSearchRegex         := false;
  gsSearchText          := '';
  gsSearchTextHistory   := '';
  gsReplaceText         := '';
  gsReplaceTextHistory  := '';

  // editor defaults
  ColorCoding         := true;
  ShowTemplateForm    := true;
  ShowTemplatePopup   := false;
  FontName            := K_EDITOR_FONTNAME_DEFAULT;
  RightEdgeColor      := K_REDGE_COLOR_DEFAULT;
  EditorColor         := K_EDITOR_COLOR_DEFAULT;
  SelectionForeground := K_SEL_FG_COLOR_DEFAULT;
  SelectionBackground := K_SEL_BG_COLOR_DEFAULT;
  StructureColor      := K_STRUCT_COLOR_DEFAULT;
  ActiveLineColor     := K_ALINE_COLOR_DEFAULT;
  FontSize            := 12;
  AutoIndentCode      := true;
  MacrosOn            := false;
  RICDecompAsData     := false;
  RICDecompNameFormat := '%s';
  HideSelection       := false;
  CCInsensitive       := false;
  ScrollPastEOL       := true;
  HalfPageScroll      := false;
  DragAndDropEditing  := true;
  TabWidth            := 2;
  MaxUndo             := 10;
  MaxLeftChar         := 8192;
  ExtraLineSpacing    := 0;
  RightEdgePosition   := 80;
  ScrollBars          := 0;
  AltSetsSelMode      := false;
  MoveCursorRight     := false;
  KeepBlanks          := false;
  UseSmartTabs        := true;
  EnhanceHomeKey      := false;
  GroupUndo           := false;
  TabIndent           := false;
  ConvertTabs         := true;
  ShowSpecialChars    := false;
  HighlightCurLine    := false;
  KeepCaretX          := false;
  AutoMaxLeft         := false;
  BracketHighlightForeground := K_BH_FG_COLOR_DEFAULT;
  BracketHighlightBackground := K_BH_BG_COLOR_DEFAULT;
  HighlightBrackets   := true;

  // compiler defaults
  CompilerSwitches        := '';
  PreferredLanguage       := 4; // NXC
  NQCSwitches             := '';
  LCCSwitches             := '';
  NBCSwitches             := '';
  CPPSwitches             := '';
  JavaSwitches            := '';
  NBCOptLevel             := 2;
  NBCMaxErrors            := 0;
  NQCIncludePath          := '';
  LCCIncludePath          := '';
  NBCIncludePath          := '';
  OldNQCIncPaths          := '';
  OldLCCIncPaths          := '';
  OldNBCIncPaths          := '';
  NBCExePath              := '';
  UseInternalNBC          := True;
  EnhancedFirmware        := True;
  NXT2Firmware            := True;
  NXTAutoFWVersion        := True;
  IgnoreSysFiles          := False;

  UseHTMLHelp               := True;
  DeleteSymFileAfterLoading := False;

  DefaultDir := IncludeTrailingPathDelimiter('Default');

finalization
  CleanupTransferList(fCompXferList);
  CleanupTransferList(fTransferList);
  CleanupTransferList(fPrecompileSteps);
  CleanupTransferList(fPostcompileSteps);
  FreeAndNil(fHighlighters);
  RecentFiles := nil;
  FreeAndNil(cc_nxc_keywords);
  FreeAndNil(cc_nxc_commands);
  FreeAndNil(cc_nxc_constants);
  FreeAndNil(cc_spc_commands);
  FreeAndNil(cc_spc_constants);

end.