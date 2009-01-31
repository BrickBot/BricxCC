unit GX_ProcedureList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Menus, ImgList, ActnList, ToolWin,
  mPasLex, uParseCommon;

const
  UM_RESIZECOLS = WM_USER + 523;

type
  TProcInfo = class(TObject)
  private
    FLineNo: Integer;
    FName: string;
    FDisplayName: string;
    FProcedureType: string;
    FProcArgs: string;
    FProcClass: string;
    FProcReturnType: string;
    FProcName: string;
    FProcIndex: Integer;
  public
    property LineNo: Integer read FLineNo write FLineNo;
    property Name: string read FName write FName;
    property DisplayName: string read FDisplayName write FDisplayName;
    property ProcedureType: string read FProcedureType write FProcedureType;
    property ProcArgs: string read FProcArgs write FProcArgs;
    property ProcName: string read FProcName write FProcName;
    property ProcClass: string read FProcClass write FProcClass;
    property ProcReturnType: string read FProcReturnType write FProcReturnType;
    property ProcIndex: Integer read FProcIndex write FProcIndex;
  end;

type
  TfmProcedureList = class(TForm)
    ilImages: TImageList;
    pnHolder: TPanel;
    lvProcs: TListView;
    StatusBar: TStatusBar;
    pnlHeader: TPanel;
    dlgProcFont: TFontDialog;
    pnlHeaderLeft: TPanel;
    lblMethods: TLabel;
    edtMethods: TEdit;
    pnlHeaderRight: TPanel;
    cbxObjects: TComboBox;
    lblObjects: TLabel;
    Actions: TActionList;
    ilActions: TImageList;
    ToolBar1: TToolBar;
    tbnCopy: TToolButton;
    tbnSep1: TToolButton;
    tbnFont: TToolButton;
    tbnSep2: TToolButton;
    tbnStart: TToolButton;
    tbnAny: TToolButton;
    tbnSep3: TToolButton;
    tbnGoto: TToolButton;
    actEditCopy: TAction;
    actOptionsFont: TAction;
    actViewStart: TAction;
    actViewAny: TAction;
    actViewGoto: TAction;
    actHelpHelp: TAction;
    tbnSep4: TToolButton;
    tbnHelp: TToolButton;
    procedure lvProcsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lvProcsColumnClick(Sender: TObject; Column: TListColumn);
    procedure edtMethodsChange(Sender: TObject);
    procedure edtMethodsKeyPress(Sender: TObject; var Key: Char);
    procedure edtMethodsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbxObjectsChange(Sender: TObject);
    procedure pnlHeaderResize(Sender: TObject);
    procedure actEditCopyExecute(Sender: TObject);
    procedure actHelpHelpExecute(Sender: TObject);
    procedure actOptionsFontExecute(Sender: TObject);
    procedure actViewStartExecute(Sender: TObject);
    procedure actViewAnyExecute(Sender: TObject);
    procedure actViewGotoExecute(Sender: TObject);
    procedure ActionsUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    FSortOnColumn: Integer;
    FSearchAll: Boolean;
    FProcList: TStringList;
    FObjectStrings: TStringList;
    FLanguage: TExploredLanguage;
    fStrings : TStrings;
    fLineNum: Integer;
    procedure QuickSort(L, R: Integer);
    function SetIndex(ProcName: string): Integer;
    procedure LoadProcs;
    procedure FillListBox;
    procedure ResizeCols;
    procedure GotoCurrentlySelectedProcedure;
    procedure UMResizeCols(var Msg: TMessage); message UM_RESIZECOLS;
    function GetMethodName(const ProcName: string): string;
    procedure ClearObjectStrings;
    procedure LoadObjectCombobox;
    procedure InitializeForm;
    procedure AddProcedure(ProcedureInfo: TProcInfo);
    procedure HandlePasProcFound(pline : string; ptype : TTokenKind;
      lineNo : integer; isClass : Boolean);
    procedure HandleCppProcFound(pidx, lineNo : Integer;
      pline, ptype, pname, pclass, pargs, retType : string);
    procedure HandleMindscriptProcFound(lineNo : Integer; pname, ptype : string);
    procedure HandleForthProcFound(lineNo : Integer; pname, ptype : string);
    procedure HandleLASMProcFound(lineNo : Integer; pname, ptype : string);
    procedure HandleNBCProcFound(lineNo : Integer; pname, ptype : string);
  public
    constructor CreateWithLangAndStrings(AOwner: TComponent; aLang : TExploredLanguage; aStrings : TStrings);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SaveSettings;
    procedure LoadSettings;
    property Language: TExploredLanguage read FLanguage write FLanguage;
    property LineNumber : Integer read fLineNum;
    class function ShowForm(aLang : TExploredLanguage; aStrings : TStrings) : integer;
  end;

implementation

{$R *.dfm}

uses
  Clipbrd,
  uMiscDefines,
  Preferences,
  mwBCBTokenList,
  uMindScriptProcLexer,
  uLASMProcLexer,
  uNBCLexer,
  uNBCProcLexer,
  uForthProcLexer,
  uLocalizedStrings;

const
  K_TIMEOUT = 10000;

procedure TfmProcedureList.LoadProcs;
var
  Parser: TmwPasLex;
  CParser: TBCBTokenList;
  MLexer: TMindScriptLexer;
  FLexer: TForthLexer;
  LLexer: TLASMLexer;
  NLexer: TNBCSimpleLexer;

  procedure FindProcs;
  begin
    FProcList.Capacity := 200;
    FProcList.BeginUpdate;
    try
      case Language of
        elPas:
          begin
            FindPascalProcs(K_TIMEOUT, Parser, HandlePasProcFound);
          end;
        elNQC, elCpp, elJava, elNXC:
          begin
            FindCppProcs(K_TIMEOUT, CParser, Language, HandleCppProcFound, False);
          end;
        elMindscript:
          begin
            FindMindscriptProcs(K_TIMEOUT, MLexer, HandleMindscriptProcFound);
          end;
        elForth:
          begin
            FindForthProcs(K_TIMEOUT, FLexer, HandleForthProcFound);
          end;
        elLASM:
          begin
            FindLASMProcs(K_TIMEOUT, LLexer, HandleLASMProcFound);
          end;
        elNBC:
          begin
            FindNBCProcs(K_TIMEOUT, NLexer, HandleNBCProcFound);
          end;
      end; //case Language
    finally
      FProcList.EndUpdate;
    end;
  end;

var
  MemStream: TMemoryStream;
begin
  case Language of
    elPas:        Parser := TmwPasLex.Create;
    elNQC, elCpp, elJava,
    elNXC:        CParser := TBCBTokenList.Create;
    elMindscript: MLexer := TMindScriptLexer.CreateLexer;
    elForth:      FLexer := TForthLexer.CreateLexer;
    elLASM:       LLexer := TLASMLexer.CreateLexer;
    elNBC:        NLexer := TNBCSimpleLexer.CreateLexer;
  end;
  try
    MemStream := TMemoryStream.Create;
    try
      fStrings.SaveToStream(MemStream);
      if MemStream.Memory <> nil then
      begin
        case Language of
          elPas: Parser.Origin := MemStream.Memory;
          elNQC, elCpp, elJava, elNXC: CParser.SetOrigin(MemStream.Memory, MemStream.Size);
          elMindscript: begin
            MLexer.Origin := MemStream.Memory;
            MLexer.EndPos := MemStream.Size;
          end;
          elForth: begin
            FLexer.Origin := MemStream.Memory;
            FLexer.EndPos := MemStream.Size;
          end;
          elLASM: begin
            LLexer.Origin := MemStream.Memory;
            LLexer.EndPos := MemStream.Size;
          end;
          elNBC: begin
            NLexer.Origin := MemStream.Memory;
            NLexer.EndPos := MemStream.Size;
          end;
        end;

        Screen.Cursor := crHourGlass;
        try
          ClearObjectStrings;
          try
            FindProcs;
          finally
            LoadObjectCombobox;
          end;
          QuickSort(0, FProcList.Count - 1);
        finally
          Screen.Cursor := crDefault;
        end;
      end;
      StatusBar.Panels[1].Text := Trim(IntToStr(lvProcs.Items.Count));
    finally
      MemStream.Free;
    end;
  finally
    case Language of
      elPas: Parser.Free;
      elNQC, elCpp, elJava, elNXC: CParser.Free;
      elMindscript: MLexer.Free;
      elForth: FLexer.Free;
      elLASM: LLexer.Free;
      elNBC: NLexer.Free;
    end;
  end;
end;

procedure TfmProcedureList.AddProcedure(ProcedureInfo: TProcInfo);
var
  TempStr: string;
begin
  ProcedureInfo.Name := CompressWhiteSpace(ProcedureInfo.Name);
  case Language of
    elPas:
      begin
        TempStr := ProcessPascalName(ProcedureInfo.Name);
        // Check for an implementation procedural type
        if Length(TempStr) = 0 then
        begin
          ProcedureInfo.Free;
          Exit;
        end;
        TempStr := RemoveTrailingSemicolon(TempStr);
        ProcedureInfo.DisplayName := TempStr;
        // Add to the object combobox and set the object name in ProcedureInfo
        if Pos('.', TempStr) = 0 then
          FObjectStrings.Add(SNoneString)
        else
        begin
          ProcedureInfo.ProcClass := Copy(TempStr, 1, Pos('.', TempStr) - 1);
          FObjectStrings.Add(ProcedureInfo.ProcClass);
        end;
        FProcList.AddObject(#9 + TempStr + #9 + ProcedureInfo.ProcedureType + #9 + IntToStr(ProcedureInfo.LineNo), ProcedureInfo);
      end; //elPas
    elNQC, elMindScript, elCpp, elJava, elForth, elLASM, elNBC, elNXC:
      begin
        if Length(ProcedureInfo.ProcClass) > 0 then
          ProcedureInfo.DisplayName := ProcedureInfo.ProcClass + '::';
        // Should be the return type and args displayed, they are now in the status bar ?
        ProcedureInfo.DisplayName := ProcedureInfo.DisplayName + ProcedureInfo.ProcName;
        FProcList.AddObject(#9 + ProcedureInfo.DisplayName + #9 + ProcedureInfo.ProcedureType + #9 + IntToStr(ProcedureInfo.LineNo), ProcedureInfo);
        if Length(ProcedureInfo.ProcClass) = 0 then
          FObjectStrings.Add(SNoneString)
        else
          FObjectStrings.Add(ProcedureInfo.ProcClass);
      end; //elNQC, elMindScript, elCpp, elJava, elForth, elLASM, elNBC, elNXC
  end; //case Language
end;

function TfmProcedureList.GetMethodName(const ProcName: string): string;
var
  CharPos: Integer;
  TempStr: string;
begin
  Result := ProcName;
  Delete(Result, 1, 1);

  CharPos := Pos(#9, Result);
  if CharPos <> 0 then
    Delete(Result, CharPos, Length(Result));

  CharPos := Pos(' ', Result);
  TempStr := Copy(Result, CharPos + 1, Length(Result));

  CharPos := Pos('.', TempStr);
  if CharPos = 0 then
    Result := TempStr
  else
    TempStr := Copy(TempStr, CharPos + 1, Length(TempStr));

  CharPos := Pos('(', TempStr);
  if CharPos = 0 then
    Result := TempStr
  else
    Result := Copy(TempStr, 1, CharPos - 1);

  Result := Trim(Result);
end;

function TfmProcedureList.SetIndex(ProcName: string): Integer;
begin
  ProcName := UpperCase(ProcName);
  if Pos('.', ProcName) <> 0 then
    Result := 0
  else
    Result := 1;
  if Pos('CONSTRUCTOR', ProcName) <> 0 then // Do not localize.
    Result := 2;
  if Pos('DESTRUCTOR', ProcName) <> 0 then // Do not localize.
    Result := 3;
end;

procedure TfmProcedureList.lvProcsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  ProcInfo: TProcInfo;
begin
  ProcInfo := nil;
  if lvProcs.Selected <> nil then
    ProcInfo := lvProcs.Selected.Data;
  if ProcInfo <> nil then
  begin
    StatusBar.Panels[0].Text := ProcInfo.Name;
    StatusBar.Panels[1].Text := Format('%d/%d', [lvProcs.Selected.Index + 1, lvProcs.Items.Count]);
    actViewGoto.Enabled := (lvProcs.Selected <> nil);
  end;
end;

procedure TfmProcedureList.FillListBox;
var
  i: Integer;
  ProcName: string;
  IsObject: Boolean;
  ProcInfo: TProcInfo;

  procedure AddListItem(ProcInfo: TProcInfo);
  var
    ListItem: TListItem;
  begin
    ListItem := lvProcs.Items.Add;
    ListItem.Caption := '';
    case Language of
      elPas: ListItem.ImageIndex := SetIndex(ProcInfo.Name);
      elNQC, elMindScript,
      elCpp, elJava, elForth,
      elLASM, elNBC, elNXC: ListItem.ImageIndex := ProcInfo.ProcIndex;
    end;
    ListItem.SubItems.Add(ProcInfo.DisplayName);
    ListItem.SubItems.Add(ProcInfo.ProcedureType);
    ListItem.SubItems.Add(IntToStr(ProcInfo.LineNo));
    ListItem.Data := ProcInfo;
  end;

  procedure FocusAndSelectFirstItem;
  begin
    if lvProcs.Items.Count > 0 then
    begin
      lvProcs.Selected := lvProcs.Items[0];
      lvProcs.ItemFocused := lvProcs.Selected;
    end;
  end;

begin
  lvProcs.Items.BeginUpdate;
  try
    lvProcs.Items.Clear;
    if (Length(edtMethods.Text) = 0) and (cbxObjects.Text = SAllString) then
    begin
      for i := 0 to FProcList.Count - 1 do
        AddListItem(TProcInfo(FProcList.Objects[i]));
      FocusAndSelectFirstItem;
      Exit;
    end;

    for i := 0 to FProcList.Count - 1 do
    begin
      ProcInfo := TProcInfo(FProcList.Objects[i]);
      case Language of
        elPas: ProcName := ProcInfo.Name;
        elNQC, elMindScript,
        elCpp, elJava, elForth,
        elLASM, elNBC, elNXC: ProcName := ProcInfo.ProcClass;
      end;
      IsObject := Length(ProcInfo.ProcClass) > 0;

      // Is it the object we want?
      if cbxObjects.Text <> SAllString then
      begin
        if cbxObjects.Text = SNoneString then
        begin
          if IsObject then // Does it have an object?
            Continue;
          if Length(edtMethods.Text) = 0 then // If no filter is active, add
          begin
            AddListItem(ProcInfo);
            Continue;
          end;
        end // if/then
        else if not SameText(cbxObjects.Text, ProcInfo.ProcClass) then
          Continue;
      end;

      case Language of
        elPas: ProcName := GetMethodName(ProcName);
        elNQC, elMindScript,
        elCpp, elJava, elForth,
        elLASM, elNBC, elNXC: ProcName := ProcInfo.ProcName;
      end;

      if Length(edtMethods.Text) = 0 then
        AddListItem(ProcInfo)
      else if not FSearchAll and
        SameText(edtMethods.Text, Copy(ProcName, 1, Length(edtMethods.Text))) then
      begin
        AddListItem(ProcInfo);
      end
      else if FSearchAll and
        (Pos(UpperCase(edtMethods.Text), UpperCase(ProcName)) <> 0) then
      begin
        AddListItem(ProcInfo);
      end;
    end;
    FocusAndSelectFirstItem;
  finally
    lvProcs.Items.EndUpdate;
  end;
  ResizeCols;
end;

procedure TfmProcedureList.FormResize(Sender: TObject);
begin
  with StatusBar do
  begin
    if Width > 80 then
    begin
      Panels[1].Width := 80;
      Panels[0].Width := Width - 80;
    end;
  end;

  ResizeCols;
end;

// This is just a nasty hack to be sure the scroll bar is set right
// before playing with the column widths. We should fix this somehow.
procedure TfmProcedureList.ResizeCols;
begin
  PostMessage(Self.Handle, UM_RESIZECOLS, 0, 0);
end;

procedure TfmProcedureList.UMResizeCols(var Msg: TMessage);
begin
  Application.ProcessMessages;
  lvProcs.Columns[1].Width := Max(0, lvProcs.ClientWidth - lvProcs.Columns[2].Width
    - lvProcs.Columns[3].Width - lvProcs.Columns[0].Width);
end;

procedure TfmProcedureList.SaveSettings;
begin
  ProcedureListSettings.Left := Left;
  ProcedureListSettings.Top := Top;
  ProcedureListSettings.Width := Width;
  ProcedureListSettings.Height := Height;
  ProcedureListSettings.SearchAll := FSearchAll;
  ProcedureListSettings.SortColumn := FSortOnColumn;
  ProcedureListSettings.FontName := lvProcs.Font.Name;
  ProcedureListSettings.FontSize := lvProcs.Font.Size;
end;

procedure TfmProcedureList.LoadSettings;
begin
  if ProcedureListSettings.Left <> -1 then
    Left := ProcedureListSettings.Left;
  if ProcedureListSettings.Top <> -1 then
    Top := ProcedureListSettings.Top;
  if ProcedureListSettings.Width <> -1 then
    Width := ProcedureListSettings.Width;
  if ProcedureListSettings.Height <> -1 then
    Height := ProcedureListSettings.Height;
  if ProcedureListSettings.FontName <> '' then
    lvProcs.Font.Name := ProcedureListSettings.FontName;
  if ProcedureListSettings.FontSize <> -1 then
    lvProcs.Font.Size := ProcedureListSettings.FontSize;
  FSortOnColumn := ProcedureListSettings.SortColumn;
  FSearchAll := ProcedureListSettings.SearchAll;
  ResizeCols;
  EnsureFormVisible(Self);
end;

procedure TfmProcedureList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveSettings;
end;

procedure TfmProcedureList.QuickSort(L, R: Integer);

  function GetValue(idx: Integer): string;
  var
    i: Integer;
    TabPos: Integer;
  begin
    if idx >= FProcList.Count then
      raise Exception.Create(SInvalidIndex);
    Result := FProcList.Strings[idx];
    for i := 0 to FSortOnColumn - 1 do
    begin
      TabPos := Pos(#9, Result);
      if TabPos > 0 then
        Delete(Result, 1, TabPos)
      else
        Exit;
    end;
    if FSortOnColumn = 3 then
    begin
      for i := Length(Result) to 5 do
        Result := ' ' + Result;
    end;
  end;

var
  I, J: Integer;
  P: string;
begin
  if FProcList.Count = 0 then
    Exit;
  repeat
    I := L;
    J := R;
    P := GetValue((L + R) shr 1);
    repeat
      while AnsiCompareText(GetValue(I), P) < 0 do
        Inc(I);
      while AnsiCompareText(GetValue(J), P) > 0 do
        Dec(J);
      if I <= J then
      begin
        FProcList.Exchange(I, J);
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(L, J);
    L := I;
  until I >= R;
end;

procedure TfmProcedureList.lvProcsColumnClick(Sender: TObject; Column: TListColumn);
var
  i: Integer;
begin
  i := Column.Index;
  if i <> 0 then
  begin
    Self.Cursor := crHourglass;
    try
      FSortOnColumn := i;
      QuickSort(0, FProcList.Count - 1);
      FillListBox;
    finally
      Self.Cursor := crDefault;
    end;
  end;
end;

procedure TfmProcedureList.edtMethodsChange(Sender: TObject);
begin
  FillListBox;
end;

procedure TfmProcedureList.edtMethodsKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    #13:
      begin
        GotoCurrentlySelectedProcedure;
        Key := #0;
      end;
    #27:
      begin
        Close;
        Key := #0;
      end;
  end;
end;

procedure TfmProcedureList.edtMethodsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not (((Key = VK_F4) and (ssAlt in Shift)) or
           (Key in [VK_DELETE, VK_LEFT, VK_RIGHT]) or
           ((Key in [VK_INSERT]) and ((ssShift in Shift) or (ssCtrl in Shift))) or
           ((Key in [VK_HOME, VK_END]) and (ssShift in Shift))) then
  begin
    SendMessage(lvProcs.Handle, WM_KEYDOWN, Key, 0);
    Key := 0;
  end;
end;

procedure TfmProcedureList.cbxObjectsChange(Sender: TObject);
begin
  FillListBox;
  ResizeCols;
end;

procedure TfmProcedureList.pnlHeaderResize(Sender: TObject);
begin
  pnlHeaderLeft.Width := (pnlHeader.ClientWidth div 2);
  edtMethods.Width := pnlHeaderLeft.ClientWidth - edtMethods.Left - 8;
  cbxObjects.Width := pnlHeaderRight.ClientWidth - cbxObjects.Left - 8;
end;

procedure TfmProcedureList.ClearObjectStrings;
begin
  FObjectStrings.Clear;
  FObjectStrings.Add(SAllString);
end;

procedure TfmProcedureList.LoadObjectCombobox;
begin
  cbxObjects.Items.Assign(FObjectStrings);
  cbxObjects.ItemIndex := cbxObjects.Items.IndexOf(SAllString);
end;

procedure TfmProcedureList.actEditCopyExecute(Sender: TObject);
var
  i: Integer;
  Procs: TStringList;
  ProcInfo: TProcInfo;
begin
  Procs := TStringList.Create;
  try
    for i := 0 to lvProcs.Items.Count - 1 do
    begin
      ProcInfo := TProcInfo(lvProcs.Items[i].Data);
      if ProcInfo <> nil then
        Procs.Add(ProcInfo.Name);
    end;
  finally
    if Procs.Count > 0 then
      Clipboard.AsText := Procs.Text;
    Procs.Free;
  end;
end;

procedure TfmProcedureList.actHelpHelpExecute(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TfmProcedureList.actOptionsFontExecute(Sender: TObject);
begin
  dlgProcFont.Font.Assign(lvProcs.Font);
  if dlgProcFont.Execute then
    lvProcs.Font.Assign(dlgProcFont.Font);
end;

procedure TfmProcedureList.actViewStartExecute(Sender: TObject);
begin
  FSearchAll := False;

  FillListBox;
end;

procedure TfmProcedureList.actViewAnyExecute(Sender: TObject);
begin
  FSearchAll := True;

  FillListBox;
end;

procedure TfmProcedureList.actViewGotoExecute(Sender: TObject);
begin
  GotoCurrentlySelectedProcedure;
end;

procedure TfmProcedureList.GotoCurrentlySelectedProcedure;
var
  ProcInfo: TProcInfo;
begin
  if lvProcs.Selected <> nil then
  begin
    ProcInfo := lvProcs.Selected.Data;
    if ProcInfo <> nil then
    begin
      fLineNum := ProcInfo.LineNo;
      ModalResult := mrOk;
    end;
  end;
end;

constructor TfmProcedureList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  InitializeForm;
end;

destructor TfmProcedureList.Destroy;
var
  i: Integer;
begin
  FreeAndNil(FObjectStrings);

  if FProcList <> nil then
  begin
    for i := 0 to FProcList.Count - 1 do
      FProcList.Objects[i].Free;
    FreeAndNil(FProcList);
  end;

  inherited Destroy;
end;

procedure TfmProcedureList.InitializeForm;
begin
  FObjectStrings := TStringList.Create;
  FObjectStrings.Sorted := True;
  FObjectStrings.Duplicates := dupIgnore;
  ClearObjectStrings;

  FSortOnColumn := 1;

  FProcList := TStringList.Create;

  CenterForm(Self);
  
  LoadSettings;
  LoadProcs;

  FillListBox;
end;

procedure TfmProcedureList.ActionsUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  actViewGoto.Enabled := (lvProcs.Selected <> nil);
  actViewStart.Checked := not FSearchAll;
  actViewAny.Checked := FSearchAll;
end;

constructor TfmProcedureList.CreateWithLangAndStrings(AOwner: TComponent;
  aLang: TExploredLanguage; aStrings: TStrings);
var
  LoadTime: DWORD;
begin
  inherited Create(AOwner);

  fStrings := aStrings;
  Language := aLang;

  LoadTime := GetTickCount;
  InitializeForm;
  LoadTime := GetTickCount - LoadTime;
  StatusBar.Panels[0].Text := Format(SParseStatistics, [LoadTime / 1000]);
end;

class function TfmProcedureList.ShowForm(aLang: TExploredLanguage;
  aStrings: TStrings) : integer;
begin
  Result := -1;
  with TfmProcedureList.CreateWithLangAndStrings(nil, aLang, aStrings) do
  try
    if ShowModal = mrOK then
    begin
      Result := LineNumber;
    end;
  finally
    Free;
  end;
end;

procedure TfmProcedureList.HandlePasProcFound(pline: string; ptype: TTokenKind;
  lineNo : integer; isClass: Boolean);
var
  ProcedureInfo : TProcInfo;
begin
  ProcedureInfo := TProcInfo.Create;
  ProcedureInfo.Name := pline;
  ProcedureInfo.ProcedureType := GetProperProcName(ptype, isClass, False);
  ProcedureInfo.LineNo := lineNo;
  AddProcedure(ProcedureInfo);
end;

procedure TfmProcedureList.HandleCppProcFound(pidx, lineNo: Integer;
  pline, ptype, pname, pclass, pargs, retType: string);
var
  ProcedureInfo : TProcInfo;
begin
  ProcedureInfo := TProcInfo.Create;
  ProcedureInfo.Name := pline;
  ProcedureInfo.ProcedureType := ptype;
  ProcedureInfo.LineNo := lineNo;
  ProcedureInfo.ProcClass := pclass;
  ProcedureInfo.ProcArgs := pargs;
  ProcedureInfo.ProcReturnType := retType;
  ProcedureInfo.ProcIndex := pidx;
  ProcedureInfo.ProcName := pname;
  AddProcedure(ProcedureInfo);
end;

procedure TfmProcedureList.HandleMindscriptProcFound(lineNo: Integer;
  pname, ptype: string);
var
  ProcedureInfo : TProcInfo;
begin
  ProcedureInfo := TProcInfo.Create;
  ProcedureInfo.LineNo := lineNo;
  ProcedureInfo.Name := pname;
  ProcedureInfo.ProcedureType := ptype;
  ProcedureInfo.ProcIndex := 1;
  ProcedureInfo.ProcName := pname;
  AddProcedure(ProcedureInfo);
end;

procedure TfmProcedureList.HandleForthProcFound(lineNo: Integer; pname,
  ptype: string);
var
  ProcedureInfo : TProcInfo;
begin
  ProcedureInfo := TProcInfo.Create;
  ProcedureInfo.LineNo := lineNo;
  ProcedureInfo.Name := pname;
  ProcedureInfo.ProcedureType := 'word';
  ProcedureInfo.ProcIndex := 1;
  ProcedureInfo.ProcName := pname;
  AddProcedure(ProcedureInfo);
end;

procedure TfmProcedureList.HandleLASMProcFound(lineNo: Integer; pname,
  ptype: string);
var
  ProcedureInfo : TProcInfo;
begin
  ProcedureInfo := TProcInfo.Create;
  ProcedureInfo.LineNo := lineNo;
  ProcedureInfo.Name := pname;
  ProcedureInfo.ProcedureType := ptype;
  ProcedureInfo.ProcIndex := 1;
  ProcedureInfo.ProcName := pname;
  AddProcedure(ProcedureInfo);
end;

procedure TfmProcedureList.HandleNBCProcFound(lineNo: Integer; pname,
  ptype: string);
var
  ProcedureInfo : TProcInfo;
begin
  ProcedureInfo := TProcInfo.Create;
  ProcedureInfo.LineNo := lineNo;
  ProcedureInfo.Name := pname;
  ProcedureInfo.ProcedureType := ptype;
  ProcedureInfo.ProcIndex := 1;
  ProcedureInfo.ProcName := pname;
  AddProcedure(ProcedureInfo);
end;

end.

