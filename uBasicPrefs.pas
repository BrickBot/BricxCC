unit uBasicPrefs;

interface

uses
  Classes, ExtCtrls, Graphics, SynEditHighlighter, uParseCommon;

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

var
  SaveBackup:boolean;        // Whether to save backups of existing files
  AutoSaveFiles : Boolean;
  AutoSaveDesktop : Boolean;
  MultiFormatCopy : Boolean;

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
  ColorCodingChanged:boolean;// Whether ColorCoding was changed
  FontName:string;           // Name of the font
  FontSize:integer;          // Size of the font
  FontChanged:boolean;       // Whether the font changed
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

var
  CodeExplorerSettings : TCodeExplorerProperties;
  ParseTimeout : Integer;
  LocalCompilerTimeout : integer;
  ProcedureListSettings : TProcedureListProperties;
  ZeroStart : boolean;
  ShowLineNumbers : boolean;
  CompilerDebug : boolean;
  ShowCompilerStatus : boolean;

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

var
  NQCExePath : string;
  LCCExePath : string;
  NBCExePath : string;
  NBCOptLevel : byte;
  NBCMaxErrors : word;
  UseInternalNBC : Boolean;
  NXT2Firmware : Boolean;
  EnhancedFirmware : Boolean;

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

implementation

uses
  SysUtils, uHighlighterProcs;

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
// do nothing

finalization
  CleanupTransferList(fCompXferList);
  CleanupTransferList(fTransferList);
  CleanupTransferList(fPrecompileSteps);
  CleanupTransferList(fPostcompileSteps);
  FreeAndNil(fHighlighters);

end.
