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
{$B-}
unit Editor;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
  LMessages,
  LCLType,
  LCLIntf,
  LCLProc,
  SynEditMarks,
{$ENDIF}
  Messages, Classes, Graphics, Controls, Forms,
  StdCtrls, ComCtrls, Menus, ImgList, SynEdit, ExtCtrls, BricxccSynEdit,
  SynEditHighlighter, SynEditRegexSearch, SynEditMiscClasses, SynEditSearch,
  SynEditEx, SynEditKeyCmds, uOfficeComp;

type
  TEditorForm = class(TForm)
    TheErrors: TListBox;
    ilBookmarkImages: TImageList;
    splErrors: TSplitter;
    procedure TheErrorsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TheErrorsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TheEditorProcessUserCommand(Sender: TObject;
      var Command: TSynEditorCommand; var AChar: Char; Data: Pointer);
  private
    { Private declarations }
    fFileName : string;
    fHighlighter: TSynCustomHighlighter;
    procedure UpdateModeOnStatusBar;
    procedure UpdateModifiedOnStatusBar;
    procedure UpdateStatusBar;
//    procedure InsertOptionInfo;
    procedure WMMDIActivate(var Message: TWMMDIActivate); message WM_MDIACTIVATE;
    procedure SetFilename(const Value: string);
    procedure OpenFileAtCursor;
    procedure FindDeclaration(const aIdent : string);
    procedure CreatePopupMenu;
    procedure CreateTheEditor;
    function GetPosition: integer;
    function GetSource: string;
    procedure SetPosition(const Value: integer);
  protected
    function MDI : Boolean;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure HookCompProp;
    procedure SetActiveHelpFile;
    procedure SetCaption(const fname : string);
  public
    // menu and synedit components
    TheEditor: TBricxccSynEdit;
    pmnuEditor: TOfficePopupMenu;
    mniFindDeclaration: TOfficeMenuItem;
    N5: TOfficeMenuItem;
    mniClosePage: TOfficeMenuItem;
    mniOpenFileAtCursor: TOfficeMenuItem;
    mnTopicSearch: TOfficeMenuItem;
    N3: TOfficeMenuItem;
    lmiEditUndo: TOfficeMenuItem;
    lmiEditRedo: TOfficeMenuItem;
    N2: TOfficeMenuItem;
    lmiEditCut: TOfficeMenuItem;
    lmiEditCopy: TOfficeMenuItem;
    lmiEditPaste: TOfficeMenuItem;
    lmiEditDelete: TOfficeMenuItem;
    N1: TOfficeMenuItem;
    lmiEditSelectAll: TOfficeMenuItem;
    lmiCopySpecial: TOfficeMenuItem;
    lmiCopyHTML: TOfficeMenuItem;
    lmiCopyRTF: TOfficeMenuItem;
    N4: TOfficeMenuItem;
    mniToggleBookmarks: TOfficeMenuItem;
    mniTBookmark0: TOfficeMenuItem;
    mniTBookmark1: TOfficeMenuItem;
    mniTBookmark2: TOfficeMenuItem;
    mniTBookmark3: TOfficeMenuItem;
    mniTBookmark4: TOfficeMenuItem;
    mniTBookmark5: TOfficeMenuItem;
    mniTBookmark6: TOfficeMenuItem;
    mniTBookmark7: TOfficeMenuItem;
    mniTBookmark8: TOfficeMenuItem;
    mniTBookmark9: TOfficeMenuItem;
    mniGotoBookmarks: TOfficeMenuItem;
    mniGBookmark0: TOfficeMenuItem;
    mniGBookmark1: TOfficeMenuItem;
    mniGBookmark2: TOfficeMenuItem;
    mniGBookmark3: TOfficeMenuItem;
    mniGBookmark4: TOfficeMenuItem;
    mniGBookmark5: TOfficeMenuItem;
    mniGBookmark6: TOfficeMenuItem;
    mniGBookmark7: TOfficeMenuItem;
    mniGBookmark8: TOfficeMenuItem;
    mniGBookmark9: TOfficeMenuItem;
    N6: TOfficeMenuItem;
    mniViewExplorer: TOfficeMenuItem;
    mniToggleBreakpoint: TOfficeMenuItem;
  public
    // event handlers
    procedure pmnuEditorPopup(Sender: TObject);
    procedure lmiEditUndoClick(Sender: TObject);
    procedure lmiEditRedoClick(Sender: TObject);
    procedure lmiEditCutClick(Sender: TObject);
    procedure lmiEditCopyClick(Sender: TObject);
    procedure lmiEditDeleteClick(Sender: TObject);
    procedure lmiEditSelectAllClick(Sender: TObject);
    procedure lmiEditPasteClick(Sender: TObject);
    procedure DoCopyRTF(Sender: TObject);
    procedure DoCopyHTML(Sender: TObject);
    procedure mniOpenFileAtCursorClick(Sender: TObject);
    procedure mniClosePageClick(Sender: TObject);
    procedure mniViewExplorerClick(Sender: TObject);
    procedure mniFindDeclarationClick(Sender: TObject);
    procedure mnTopicSearchClick(Sender: TObject);
    procedure ToggleBookmark(Sender: TObject);
    procedure GotoBookmark(Sender: TObject);
    procedure mniToggleBreakpointClick(Sender: TObject);
    procedure TheEditorKeyPress(Sender: TObject; var Key: Char);
    procedure TheEditorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TheEditorReplaceText(Sender: TObject; const ASearch,
      AReplace: String; Line, Column: Integer;
      var Action: TSynReplaceAction);
    procedure TheEditorStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure TheEditorGutterClick(Sender: TObject; X, Y, Line: Integer;
      mark: TSynEditMark);
    procedure TheEditorPlaceBookmark(Sender: TObject;
      var Mark: TSynEditMark);
    procedure TheEditorClearBookmark(Sender: TObject;
      var Mark: TSynEditMark);
    procedure TheEditorChange(Sender: TObject);
    procedure TheEditorMouseOverToken(Sender: TObject; const Token: String;
      TokenType: Integer; Attri: TSynHighlighterAttributes;
      var Highlight: Boolean);
    procedure TheEditorProcessCommand(Sender: TObject;
      var Command: TSynEditorCommand; var AChar: Char; Data: Pointer);
    procedure TheEditorDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TheEditorDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TheEditorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TheEditorSpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);
  public
    {File handling}
    IsNew:boolean;                     // Whether it is a new file
    procedure NewFile(fname:string);   // Create a new file in the editor
    procedure OpenFile(fname:string; lineNo : integer = -1);  // Open an existing file
    procedure SaveFile;                // Saves the file
    procedure SaveFileAs(fname:string);// Saves the file as fname
    procedure InsertFile(fname:string);// Insert file at cursor
    function  OpenFileOnPath(const fname : string) : boolean;
    {Editing}
    function  CanUndo: boolean;         // Whether you can undo something
    function  CanRedo: boolean;         // Whether you can redo something
    function  Selected: boolean;        // Whether something is selected
    function  CanFind : boolean;
    function  CanFindNext : boolean;
    function  CanReplace : boolean;
    function  CanCut: Boolean;
    function  CanPaste: Boolean;
    function  CanFindDeclaration : Boolean;
    procedure Undo;
    procedure Redo;
    procedure CutSel;
    procedure CopySel;
    procedure Paste;
    procedure DeleteSel;
    procedure SelectAll;
    procedure GotoLine;
    procedure ProcedureList;
    procedure NextField;
    procedure AddConstructString(constr:string; x : integer = -1; y :integer = -1);
//    procedure AddConstruct(const aLang, numb : integer; x : integer = -1; y :integer = -1);
    procedure SetSyntaxHighlighter;
    procedure SetValuesFromPreferences;
    procedure ExecFind;
    procedure ExecFindNext;
    procedure ExecFindPrev;
    procedure ExecReplace;
    procedure AddErrorMessage(const errMsg : string);
    procedure ShowTheErrors;
    procedure SelectLine(lineNo : integer);
    function  IsMaximized : Boolean;
    procedure UpdatePositionOnStatusBar;
    property  Filename : string read fFilename write SetFilename;
    property  Highlighter : TSynCustomHighlighter read fHighlighter write fHighlighter;
    property  Source : string read GetSource;
    property  Position : integer read GetPosition write SetPosition;
  end;

var
  EditorForm: TEditorForm;

function HelpALink(keyword: string; bNQC : Boolean = True): Boolean;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}


uses
{$IFNDEF FPC}
  Windows,
  MainUnit,
{$ENDIF}
  SysUtils, Dialogs, ClipBrd,
  Preferences, GotoLine, ConstructUnit, dlgSearchText,
  dlgReplaceText, dlgConfirmReplace, DTestPrintPreview, Translate,
  CodeUnit, ExecProgram, brick_common, FakeSpirit, uCodeExplorer, uMacroForm,
  GX_ProcedureList, SynEditTypes, uLegoSDKUtils, uParseCommon, uRICComp,
  uMiscDefines, uNXTClasses, uNBCInterface, ParamUtils, uNXTConstants,
  uPSDisassembly, uLocalizedStrings, uNBCCommon, rcx_constants, uEditorUtils,
  uEditorExperts, uProgram, uNXTExplorer, uCompStatus, uGlobals, uBasicPrefs,
  uHTMLHelp, uNXCHTMLTopics, uNQCHTMLTopics, uNBCHTMLTopics, uPSComponent,
  uPSDebugger, uROPS;

function HelpALink(keyword: string; bNQC : Boolean): Boolean;
var
  MacroStr: array[0..255] of Char;
const
  MACRO_ARRAY : array[Boolean] of PChar =
  (
     'IE( KL('#96'%0:s'#39', 4), '#96'KL('#96'%0:s'#39', 1)'#39', '#96'IE( AL('#96'%0:s'#39', 4), '#96'AL('#96'%0:s'#39', 1)'#39', '#96'JK("", '#96'%0:s'#39')'#39' )'#39' )',
     'IE( AL('#96'%0:s'#39', 4), '#96'AL('#96'%0:s'#39', 1)'#39', '#96'IE( KL('#96'%0:s'#39', 4), '#96'KL('#96'%0:s'#39', 1)'#39', '#96'JK("", '#96'%0:s'#39')'#39' )'#39' )'
   );
begin
{$IFNDEF FPC}
  if UseHTMLHelp then
  begin
    keyword := LookupHTMLTopic(keyword);
    Result := Application.HelpCommand(HELP_COMMAND, Integer(PChar(keyword)));
  end
  else
  begin
    if FileIsMindScriptOrLASM then
    begin
      Result := Application.HelpCommand(HELP_KEY, Integer(PChar(keyword)));
    end
    else
    begin
      StrLFmt(MacroStr, SizeOf(MacroStr) - 1, MACRO_ARRAY[bNQC], [keyword]);
      Result := Application.HelpCommand(HELP_COMMAND, Longint(@MacroStr));
    end;
  end;
{$ENDIF}
end;

{File Handling routines}

procedure TEditorForm.NewFile(fname:string);
begin
  IsNew    := True;
  Filename := fname;
  SetCaption(ExtractFileName(fname));
  TheEditor.Modified := False;
  if TheEditor.CanFocus then
    TheEditor.SetFocus;
  MainForm.actFileSave.Enabled := False;
  SetSyntaxHighlighter;
  UpdateStatusBar;
  HookCompProp;
  frmCodeExplorer.RefreshEntireTree;
end;

procedure TEditorForm.OpenFile(fname:string; lineNo : integer);
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
          if NXT2Firmware then
            D.FirmwareVersion := MIN_FW_VER2X;
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
    if TheEditor.CanFocus then
      TheEditor.SetFocus;
    MainForm.LoadDesktop(fname);
    SetSyntaxHighlighter;
    UpdateStatusBar;
    HookCompProp;
    frmCodeExplorer.ProcessFile(fname, TheEditor.Lines.Text);
    frmCodeExplorer.RefreshEntireTree;
    if FileIsROPS(Highlighter) then
      ce.Script.Assign(TheEditor.Lines);
    SelectLine(lineNo);
  end;
end;

procedure TEditorForm.SaveFile;
begin
  SaveFileAs(Filename);
end;

procedure TEditorForm.SaveFileAs(fname:string);
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

procedure TEditorForm.InsertFile(fname:string);
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

function TEditorForm.CanUndo : Boolean;
begin
  Result := TheEditor.CanUndo;
end;

function TEditorForm.CanCut : Boolean;
begin
  Result := not TheEditor.ReadOnly and Selected;
end;

function TEditorForm.CanPaste : Boolean;
begin
  Result := TheEditor.CanPaste;
end;

function TEditorForm.Selected : Boolean;
begin
  Result := TheEditor.SelAvail;
end;

procedure TEditorForm.Undo;
begin
  TheEditor.Undo;
end;

procedure TEditorForm.Redo;
begin
  TheEditor.Redo;
end;

procedure TEditorForm.CutSel;
begin
  TheEditor.CutToClipboard;
end;

procedure TEditorForm.CopySel;
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

procedure TEditorForm.Paste;
begin
  TheEditor.PasteFromClipboard;
end;

procedure TEditorForm.DeleteSel;
begin
  TheEditor.ClearSelection;
end;

procedure TEditorForm.SelectAll;
begin
  TheEditor.SelectAll;
end;

procedure TEditorForm.GotoLine;
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

procedure TEditorForm.NextField;
begin
  TheEditor.SelectDelimited;
end;

procedure TEditorForm.AddConstructString(constr:string; x, y : integer);
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

(*
procedure TEditorForm.AddConstruct(const aLang, numb : integer; x, y:integer);
begin
  AddConstructString(templates[aLang][numb-1], x, y);
end;
*)

{Event Handlers}

procedure TEditorForm.TheErrorsClick(Sender: TObject);
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
    if FileIsNBCOrNXCOrNPGOrRICScript(Highlighter) then
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

procedure TEditorForm.TheEditorKeyPress(Sender: TObject; var Key: Char);
begin
  {Ignore <Ctr><Alt> combinations when a macro was added}
  if Key = Chr(27) then
    GlobalAbort := True;
end;

procedure TEditorForm.TheEditorKeyDown(Sender: TObject; var Key: Word;
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


procedure TEditorForm.FormActivate(Sender: TObject);
begin
  UpdateStatusBar;
  if TheErrors.Visible then
    MainForm.barStatus.Panels[1].Text := sErrors
  else
    MainForm.barStatus.Panels[1].Text := '';
  MainForm.ChangeActiveEditor;
end;

procedure TEditorForm.FormCloseQuery(Sender: TObject;
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

procedure TEditorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(MainForm) then
  begin
    MainForm.barStatus.Panels[0].Text := '';
    MainForm.barStatus.Panels[4].Text := '';
    MainForm.barStatus.Panels[5].Text := '';
  end;
  Action := caFree;
end;

procedure TEditorForm.FormShow(Sender: TObject);
begin
//  PopupMenu := ConstructForm.ConstructMenu;
  TheEditor.Font.Name := FontName;
  TheEditor.Font.Size := FontSize;
end;

procedure TEditorForm.FormCreate(Sender: TObject);
begin
  CreatePopupMenu;
  CreateTheEditor;
  SetValuesFromPreferences;
  SetSyntaxHighlighter;
  MainForm.SynAutoComp.AddEditor(TheEditor);
  MainForm.SynMacroRec.AddEditor(TheEditor);
end;

procedure TEditorForm.SetSyntaxHighlighter;
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

procedure TEditorForm.ExecFind;
begin
  ShowSearchReplaceDialog(TheEditor, FALSE);
end;

procedure TEditorForm.ExecFindNext;
begin
  DoSearchReplaceText(TheEditor, FALSE, FALSE);
End;

procedure TEditorForm.ExecFindPrev;
begin
  DoSearchReplaceText(TheEditor, FALSE, TRUE);
end;

procedure TEditorForm.ExecReplace;
begin
  ShowSearchReplaceDialog(TheEditor, TRUE);
end;

procedure TEditorForm.TheEditorReplaceText(Sender: TObject; const ASearch,
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

procedure TEditorForm.TheEditorStatusChange(Sender: TObject;
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

procedure TEditorForm.UpdateStatusBar;
begin
  UpdatePositionOnStatusBar;
  UpdateModeOnStatusBar;
  UpdateModifiedOnStatusBar;
end;

procedure TEditorForm.UpdatePositionOnStatusBar;
var
  p: TPoint;
begin
  p := TheEditor.CaretXY;
  MainForm.barStatus.Panels[0].Text := Format('%6d:%3d', [GetLineNumber(p.Y), p.X]);
end;

procedure TEditorForm.UpdateModeOnStatusBar;
const
  InsertModeStrs: array[boolean] of string = (S_Overwrite, S_Insert);
begin
  if TheEditor.ReadOnly then
    MainForm.barStatus.Panels[4].Text := S_ReadOnly
  else
    MainForm.barStatus.Panels[4].Text := InsertModeStrs[TheEditor.InsertMode];
end;

procedure TEditorForm.UpdateModifiedOnStatusBar;
const
  ModifiedStrs: array[boolean] of string = ('', S_Modified);
begin
  MainForm.barStatus.Panels[5].Text := ModifiedStrs[TheEditor.Modified];
end;

function TEditorForm.CanRedo: boolean;
begin
  Result := TheEditor.CanRedo;
end;

function TEditorForm.CanFind: boolean;
begin
  Result := TheEditor.Lines.Count > 0;
end;

function TEditorForm.CanFindNext: boolean;
begin
  Result := CanFind and (gsSearchText <> '');
end;

function TEditorForm.CanReplace: boolean;
begin
  Result := CanFind and not TheEditor.ReadOnly;
end;

procedure TEditorForm.SetValuesFromPreferences;
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

procedure TEditorForm.TheEditorGutterClick(Sender: TObject; X, Y,
  Line: Integer; mark: TSynEditMark);
begin
  if mark <> nil then
    TheEditor.ClearBookMark(mark.BookmarkNumber);
end;

procedure TEditorForm.TheEditorPlaceBookmark(Sender: TObject;
  var Mark: TSynEditMark);
begin
//
end;

procedure TEditorForm.TheEditorClearBookmark(Sender: TObject;
  var Mark: TSynEditMark);
begin
//
end;

procedure TEditorForm.pmnuEditorPopup(Sender: TObject);
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
  mniToggleBreakpoint.Enabled :=
    FileIsROPS(Highlighter) or
    (IsNXT and EnhancedFirmware and
     FileIsNBCOrNXC(Highlighter) and
     CurrentProgram.Loaded(Filename));
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

procedure TEditorForm.lmiEditUndoClick(Sender: TObject);
begin
  Undo;
end;

procedure TEditorForm.lmiEditRedoClick(Sender: TObject);
begin
  Redo;
end;

procedure TEditorForm.lmiEditCutClick(Sender: TObject);
begin
  CutSel;
end;

procedure TEditorForm.lmiEditCopyClick(Sender: TObject);
begin
  CopySel;
end;

procedure TEditorForm.lmiEditPasteClick(Sender: TObject);
begin
  Paste;
end;

procedure TEditorForm.lmiEditDeleteClick(Sender: TObject);
begin
  DeleteSel;
end;

procedure TEditorForm.lmiEditSelectAllClick(Sender: TObject);
begin
  SelectAll;
end;

procedure TEditorForm.FormDestroy(Sender: TObject);
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

{$IFNDEF FPC}
procedure TEditorForm.CreateParams(var Params: TCreateParams);
begin
  Visible := False;
  if MDI then begin
    FormStyle := fsMDIChild;
  end
  else begin
    BorderStyle := bsNone;
    BorderIcons := [];
  end;
  inherited;
  if MDI and MaxEditWindows then
    Params.Style := Params.Style or WS_MAXIMIZE;
end;

function TEditorForm.MDI: Boolean;
begin
  if Assigned(MainForm) then
    Result := MainForm.MDI
  else
    Result := False;
end;

procedure TEditorForm.WMMDIActivate(var Message: TWMMDIActivate);
var
  IsActive : Boolean;
  Style: Longint;
begin
  if (Message.ActiveWnd = Handle) and (biSystemMenu in BorderIcons) then begin
    Style:= GetWindowLong(Handle, GWL_STYLE);
    if (Style and WS_MAXIMIZE <> 0) and (Style and WS_SYSMENU = 0) then
      SendMessage(Handle, WM_SIZE, SIZE_RESTORED, 0);
  end;
  inherited;
  if AppIsClosing then Exit;
  IsActive := Message.ActiveWnd = Handle;
  if IsActive then
  begin
    // hack to update program slot menu checked state
    MainForm.UpdateProgramSlotMenuItems(CurrentProgramSlot);
    if Assigned(frmCodeExplorer) then
    begin
      frmCodeExplorer.ActiveEditor := TheEditor;
      frmCodeExplorer.ProcessFile(Filename, TheEditor.Lines.Text);
      frmCodeExplorer.RefreshEntireTree;
    end;
  end;
end;

{$ENDIF}

{
procedure TEditorForm.InsertOptionInfo;
begin
  TheEditor.Lines.Insert(0,
    Format('// Port:%s, RCXType:%s, Slot:Program %d',
      [BrickComm.NicePortName, BrickComm.RCXTypeName, CurrentProgramSlot+1]));
  TheEditor.CaretY := TheEditor.CaretY + 1;
  TheEditor.Modified := True;
end;
}

procedure TEditorForm.TheEditorChange(Sender: TObject);
begin
  frmCodeExplorer.CurrentSource := TheEditor.Lines.Text;
end;

procedure TEditorForm.SetFilename(const Value: string);
begin
  fFilename := Value;
//  AddRecentFile(Value);
end;

procedure TEditorForm.HookCompProp;
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

procedure TEditorForm.ProcedureList;
var
  line : Integer;
  SL : TExploredLanguage;
  AEH : TSynCustomHighlighter;
begin
  AEH := nil;
  SL := elNQC;
  if FileIsCPP(AEH) then
    SL := elCpp
  else if FileIsROPS(AEH) then
    SL := elPas
  else if FileIsPascal(AEH) then
    SL := elPas
  else if FileIsJava(AEH) then
    SL := elJava
  else if FileIsMindScript(AEH) then
    SL := elMindScript
  else if FileIsLASM(AEH) then
    SL := elLASM
  else if FileIsNBC(AEH) then
    SL := elNBC
  else if FileIsNXC(AEH) then
    SL := elNXC
  else if FileIsForth(AEH) then
    SL := elForth;
  line := TfmProcedureList.ShowForm(SL, TheEditor.Lines);
  if line <> -1 then
  begin
    TheEditor.GotoLineNumber(line);
    if TheEditor.CanFocus then
      TheEditor.SetFocus;
  end;
end;

procedure TEditorForm.TheEditorMouseOverToken(Sender: TObject;
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

procedure TEditorForm.SetActiveHelpFile;
var
  AEH : TSynCustomHighlighter;
begin
  AEH := GetActiveEditorHighlighter;
  Self.HelpFile := Application.HelpFile;
  if FileIsMindScriptOrLASM(AEH) then
  begin
    Self.HelpFile := GetSDKRootPath + 'vpb.hlp';
  end
  else if FileIsNQC(AEH) then
  begin
    Self.HelpFile := ProgramDir + 'Help\nqc.hlp';
    if UseHTMLHelp then
      LoadHTMLTopicMap(uNQCHTMLTopicsData);
  end
  else if FileIsJava(AEH) then
  begin
    Self.HelpFile := ProgramDir + 'Help\LeJOS.hlp';
  end
  else if FileIsForth(AEH) then
  begin
    Self.HelpFile := ProgramDir + 'Help\pbForth.hlp';
  end
  else if FileIsNBC(AEH) then
  begin
    Self.HelpFile := ProgramDir + 'Help\nbc.hlp';
    if UseHTMLHelp then
      LoadHTMLTopicMap(uNBCHTMLTopicsData);
  end
  else if FileIsNXC(AEH) then
  begin
    Self.HelpFile := ProgramDir + 'Help\nxc.hlp';
    if UseHTMLHelp then
      LoadHTMLTopicMap(uNXCHTMLTopicsData);
  end
  else if FileIsNPG(AEH) then
  begin
    Self.HelpFile := ProgramDir + 'Help\npg.hlp';
  end
  else if FileIsRICScript(AEH) then
  begin
    Self.HelpFile := ProgramDir + 'Help\ricscript.hlp';
  end
  else if FileIsCPP(AEH) then
  begin
    Self.HelpFile := ProgramDir + 'Help\brickOS.hlp';
  end
  else if FileIsROPS(AEH) then
  begin
    Self.HelpFile := ProgramDir + 'Help\rops.hlp';
  end
  else if FileIsPascal(AEH) then
  begin
    Self.HelpFile := ProgramDir + 'Help\brickOSPas.hlp';
  end;
end;

procedure TEditorForm.TheEditorProcessCommand(Sender: TObject;
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

procedure TEditorForm.TheEditorProcessUserCommand(Sender: TObject;
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

procedure TEditorForm.DoCopyHTML(Sender: TObject);
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

procedure TEditorForm.DoCopyRTF(Sender: TObject);
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

procedure TEditorForm.SetCaption(const fname : string);
begin
  Caption  := fname;
  if Assigned(Parent) then
    TTabSheet(Parent).Caption := fname;
end;

function TEditorForm.IsMaximized: Boolean;
begin
  Result := (WindowState = wsMaximized) or ((Left < 0) and (Top < 0));
end;

procedure TEditorForm.TheEditorDragOver(Sender, Source: TObject; X,
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

procedure TEditorForm.TheEditorDragDrop(Sender, Source: TObject; X, Y: Integer);
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

procedure TEditorForm.AddErrorMessage(const errMsg: string);
begin
  if TheErrors.Items.IndexOf(errMsg) = -1 then
    TheErrors.Items.Append(errMsg);
end;

procedure TEditorForm.ShowTheErrors;
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

procedure TEditorForm.TheEditorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
{$IFNDEF FPC}
  if ((ssCtrl in Shift) and (Button = mbLeft)) and not Selected then
    FindDeclaration(TheEditor.WordAtMouse);
  if (ssShift in Shift) and (Button = mbLeft) then
  begin
    if theROPSCompiler.Exec.DebugMode <> dmRun then
    begin
      ShowMessage(theROPSCompiler.GetVarContents(TheEditor.WordAtMouse));
    end;
  end;

{$ENDIF}
end;

procedure TEditorForm.FindDeclaration(const aIdent : string);
begin
  // try to find where aIdent is declared.  Check in this file first,
  // searching backward from the current location.  If found, make sure
  // it is not just another usage of the identifier rather than the
  // actual declaration of the identifier.  If NOT found in this
  // file then check any include files, starting at the end of the file
  // in each case.  Recurse through include files
  ShowMessage(aIdent);
end;

procedure TEditorForm.OpenFileAtCursor;
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

procedure TEditorForm.mniOpenFileAtCursorClick(Sender: TObject);
begin
  OpenFileAtCursor;
end;

procedure TEditorForm.mniClosePageClick(Sender: TObject);
begin
  MainForm.actFileCloseExecute(Sender);
end;

procedure TEditorForm.mniViewExplorerClick(Sender: TObject);
begin
  MainForm.ShowCodeExplorer;
end;

procedure TEditorForm.mniFindDeclarationClick(Sender: TObject);
begin
//
end;

procedure TEditorForm.mnTopicSearchClick(Sender: TObject);
var
  Cmd : TSynEditorCommand;
  Ch : Char;
begin
{$IFNDEF FPC}
  Cmd := ecContextHelp;
  TheEditorProcessCommand(Sender, Cmd, Ch, nil);
{$ENDIF}
end;

procedure TEditorForm.ToggleBookmark(Sender: TObject);
begin
  TheEditor.ToggleBookmark(TOfficeMenuItem(Sender).Tag);
end;

procedure TEditorForm.GotoBookmark(Sender: TObject);
begin
  TheEditor.GotoBookMark(TOfficeMenuItem(Sender).Tag);
end;

function TEditorForm.CanFindDeclaration: Boolean;
begin
  Result := False;
end;

procedure TEditorForm.TheEditorSpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
begin
  Special := False;
  if FileIsROPS(Highlighter) then
  begin
    if ce.HasBreakPoint(Filename, Line) then
    begin
      Special := True;
      if Line = MainForm.ActiveLine then
      begin
        FG := clRed;
        BG := clWhite;
      end else
      begin
        FG := clWhite;
        BG := clRed;
      end;
    end
    else if Line = MainForm.ActiveLine then
    begin
      Special := True;
      FG := clWhite;
      BG := clBlue;
    end;
  end
  else if IsNXT and EnhancedFirmware and FileIsNBCOrNXC(Highlighter) then
  begin
    if CurrentProgram.Loaded(Filename) and CurrentProgram.HasBreakPoint(Line) then
    begin
      Special := True;
      if Assigned(fNXTCurrentOffset) and
         (Line = fNXTCurrentOffset.LineNumber) and
         (fNXTVMState = kNXT_VMState_Pause) then
      begin
        FG := clRed;
        BG := clWhite;
      end else
      begin
        FG := clWhite;
        BG := clRed;
      end;
    end
    else if Assigned(fNXTCurrentOffset) then
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
end;

procedure TEditorForm.mniToggleBreakpointClick(Sender: TObject);
var
  Line: Longint;
begin
  Line := TheEditor.CaretY;
  if FileIsROPS(Highlighter) then
  begin
    if ce.HasBreakPoint(Filename, Line) then
      ce.ClearBreakPoint(Filename, Line)
    else
      ce.SetBreakPoint(Filename, Line);
  end
  else if IsNXT and EnhancedFirmware and
          FileIsNBCOrNXC(Highlighter) and
          CurrentProgram.Loaded(Filename) then
  begin
    if CurrentProgram.HasBreakPoint(Line) then
      CurrentProgram.ClearBreakPoint(Line)
    else
      CurrentProgram.SetBreakPoint(Line);
  end;
  TheEditor.Refresh;
end;

procedure TEditorForm.SelectLine(lineNo: integer);
begin
  if lineNo > -1 then
  begin
    TheEditor.BlockBegin := Point(1, lineNo);
    TheEditor.BlockEnd   := Point(Length(TheEditor.Lines[lineNo-1])+1, lineNo);
    TheEditor.CaretXY    := TheEditor.BlockBegin;
  end;
end;

procedure TEditorForm.CreatePopupMenu;
begin
  pmnuEditor := TOfficePopupMenu.Create(Self);
  mniFindDeclaration := TOfficeMenuItem.Create(pmnuEditor);
  N5 := TOfficeMenuItem.Create(pmnuEditor);
  mniClosePage := TOfficeMenuItem.Create(pmnuEditor);
  mniOpenFileAtCursor := TOfficeMenuItem.Create(pmnuEditor);
  mnTopicSearch := TOfficeMenuItem.Create(pmnuEditor);
  N3 := TOfficeMenuItem.Create(pmnuEditor);
  lmiEditUndo := TOfficeMenuItem.Create(pmnuEditor);
  lmiEditRedo := TOfficeMenuItem.Create(pmnuEditor);
  N2 := TOfficeMenuItem.Create(pmnuEditor);
  lmiEditCut := TOfficeMenuItem.Create(pmnuEditor);
  lmiEditCopy := TOfficeMenuItem.Create(pmnuEditor);
  lmiEditPaste := TOfficeMenuItem.Create(pmnuEditor);
  lmiEditDelete := TOfficeMenuItem.Create(pmnuEditor);
  N1 := TOfficeMenuItem.Create(pmnuEditor);
  lmiEditSelectAll := TOfficeMenuItem.Create(pmnuEditor);
  lmiCopySpecial := TOfficeMenuItem.Create(pmnuEditor);
  lmiCopyHTML := TOfficeMenuItem.Create(lmiCopySpecial);
  lmiCopyRTF := TOfficeMenuItem.Create(lmiCopySpecial);
  N4 := TOfficeMenuItem.Create(pmnuEditor);
  mniToggleBookmarks := TOfficeMenuItem.Create(pmnuEditor);
  mniTBookmark0 := TOfficeMenuItem.Create(mniToggleBookmarks);
  mniTBookmark1 := TOfficeMenuItem.Create(mniToggleBookmarks);
  mniTBookmark2 := TOfficeMenuItem.Create(mniToggleBookmarks);
  mniTBookmark3 := TOfficeMenuItem.Create(mniToggleBookmarks);
  mniTBookmark4 := TOfficeMenuItem.Create(mniToggleBookmarks);
  mniTBookmark5 := TOfficeMenuItem.Create(mniToggleBookmarks);
  mniTBookmark6 := TOfficeMenuItem.Create(mniToggleBookmarks);
  mniTBookmark7 := TOfficeMenuItem.Create(mniToggleBookmarks);
  mniTBookmark8 := TOfficeMenuItem.Create(mniToggleBookmarks);
  mniTBookmark9 := TOfficeMenuItem.Create(mniToggleBookmarks);
  mniGotoBookmarks := TOfficeMenuItem.Create(pmnuEditor);
  mniGBookmark0 := TOfficeMenuItem.Create(mniGotoBookmarks);
  mniGBookmark1 := TOfficeMenuItem.Create(mniGotoBookmarks);
  mniGBookmark2 := TOfficeMenuItem.Create(mniGotoBookmarks);
  mniGBookmark3 := TOfficeMenuItem.Create(mniGotoBookmarks);
  mniGBookmark4 := TOfficeMenuItem.Create(mniGotoBookmarks);
  mniGBookmark5 := TOfficeMenuItem.Create(mniGotoBookmarks);
  mniGBookmark6 := TOfficeMenuItem.Create(mniGotoBookmarks);
  mniGBookmark7 := TOfficeMenuItem.Create(mniGotoBookmarks);
  mniGBookmark8 := TOfficeMenuItem.Create(mniGotoBookmarks);
  mniGBookmark9 := TOfficeMenuItem.Create(mniGotoBookmarks);
  N6 := TOfficeMenuItem.Create(pmnuEditor);
  mniViewExplorer := TOfficeMenuItem.Create(pmnuEditor);
  mniToggleBreakpoint := TOfficeMenuItem.Create(pmnuEditor);
  // now add children
  pmnuEditor.Items.Add([mniFindDeclaration, N5, mniClosePage, mniOpenFileAtCursor,
                        mnTopicSearch, N3, lmiEditUndo, lmiEditRedo, N2,
                        lmiEditCut, lmiEditCopy, lmiEditPaste, lmiEditDelete,
                        N1, lmiEditSelectAll, lmiCopySpecial, N4,
                        mniToggleBookmarks, mniGotoBookmarks, N6,
                        mniViewExplorer, mniToggleBreakpoint]);
  lmiCopySpecial.Add([lmiCopyHTML, lmiCopyRTF]);
  mniToggleBookmarks.Add([mniTBookmark0, mniTBookmark1, mniTBookmark2,
                          mniTBookmark3, mniTBookmark4, mniTBookmark5,
                          mniTBookmark6, mniTBookmark7, mniTBookmark8,
                          mniTBookmark9]);
  mniGotoBookmarks.Add([mniGBookmark0, mniGBookmark1, mniGBookmark2,
                        mniGBookmark3, mniGBookmark4, mniGBookmark5,
                        mniGBookmark6, mniGBookmark7, mniGBookmark8,
                        mniGBookmark9]);
  with pmnuEditor do
  begin
    Name := 'pmnuEditor';
    OnPopup := pmnuEditorPopup;
  end;
  with mniFindDeclaration do
  begin
    Name := 'mniFindDeclaration';
    Caption := sFindDeclaration;
    OnClick := mniFindDeclarationClick;
  end;
  with N5 do
  begin
    Name := 'N5';
    Caption := '-';
  end;
  with mniClosePage do
  begin
    Name := 'mniClosePage';
    Caption := sClosePage;
    ShortCut := 16499;
    OnClick := mniClosePageClick;
  end;
  with mniOpenFileAtCursor do
  begin
    Name := 'mniOpenFileAtCursor';
    Caption := sOpenFileAtCursor;
    ShortCut := 16397;
    OnClick := mniOpenFileAtCursorClick;
  end;
  with mnTopicSearch do
  begin
    Name := 'mnTopicSearch';
    Caption := sTopicSearch;
    OnClick := mnTopicSearchClick;
  end;
  with N3 do
  begin
    Name := 'N3';
    Caption := '-';
  end;
  with lmiEditUndo do
  begin
    Name := 'lmiEditUndo';
    Caption := sUndo;
    ShortCut := 16474;
    OnClick := lmiEditUndoClick;
  end;
  with lmiEditRedo do
  begin
    Name := 'lmiEditRedo';
    Caption := sRedo;
    ShortCut := 24666;
    OnClick := lmiEditRedoClick;
  end;
  with N2 do
  begin
    Name := 'N2';
    Caption := '-';
  end;
  with lmiEditCut do
  begin
    Name := 'lmiEditCut';
    Caption := sCut;
    ShortCut := 16472;
    OnClick := lmiEditCutClick;
  end;
  with lmiEditCopy do
  begin
    Name := 'lmiEditCopy';
    Caption := sCopy;
    ShortCut := 16451;
    OnClick := lmiEditCopyClick;
  end;
  with lmiEditPaste do
  begin
    Name := 'lmiEditPaste';
    Caption := sPaste;
    ShortCut := 16470;
    OnClick := lmiEditPasteClick;
  end;
  with lmiEditDelete do
  begin
    Name := 'lmiEditDelete';
    Caption := sDelete;
    OnClick := lmiEditDeleteClick;
  end;
  with N1 do
  begin
    Name := 'N1';
    Caption := '-';
  end;
  with lmiEditSelectAll do
  begin
    Name := 'lmiEditSelectAll';
    Caption := sSelectAll;
    ShortCut := 16449;
    OnClick := lmiEditSelectAllClick;
  end;
  with lmiCopySpecial do
  begin
    Name := 'lmiCopySpecial';
    Caption := sCopySpecialMenu;
  end;
  with lmiCopyHTML do
  begin
    Name := 'lmiCopyHTML';
    Caption := '&HTML'; // do not translate
    OnClick := DoCopyHTML;
  end;
  with lmiCopyRTF do
  begin
    Name := 'lmiCopyRTF';
    Caption := '&RTF'; // do not translate
    OnClick := DoCopyRTF;
  end;
  with N4 do
  begin
    Name := 'N4';
    Caption := '-';
  end;
  with mniToggleBookmarks do
  begin
    Name := 'mniToggleBookmarks';
    Caption := sToggleBookmarksMenu;
  end;
  with mniTBookmark0 do
  begin
    Name := 'mniTBookmark0';
    Caption := sBookmark + ' &0';
    OnClick := ToggleBookmark;
  end;
  with mniTBookmark1 do
  begin
    Name := 'mniTBookmark1';
    Tag := 1;
    Caption := sBookmark + ' &1';
    OnClick := ToggleBookmark;
  end;
  with mniTBookmark2 do
  begin
    Name := 'mniTBookmark2';
    Tag := 2;
    Caption := sBookmark + ' &2';
    OnClick := ToggleBookmark;
  end;
  with mniTBookmark3 do
  begin
    Name := 'mniTBookmark3';
    Tag := 3;
    Caption := sBookmark + ' &3';
    OnClick := ToggleBookmark;
  end;
  with mniTBookmark4 do
  begin
    Name := 'mniTBookmark4';
    Tag := 4;
    Caption := sBookmark + ' &4';
    OnClick := ToggleBookmark;
  end;
  with mniTBookmark5 do
  begin
    Name := 'mniTBookmark5';
    Tag := 5;
    Caption := sBookmark + ' &5';
    OnClick := ToggleBookmark;
  end;
  with mniTBookmark6 do
  begin
    Name := 'mniTBookmark6';
    Tag := 6;
    Caption := sBookmark + ' &6';
    OnClick := ToggleBookmark;
  end;
  with mniTBookmark7 do
  begin
    Name := 'mniTBookmark7';
    Tag := 7;
    Caption := sBookmark + ' &7';
    OnClick := ToggleBookmark;
  end;
  with mniTBookmark8 do
  begin
    Name := 'mniTBookmark8';
    Tag := 8;
    Caption := sBookmark + ' &8';
    OnClick := ToggleBookmark;
  end;
  with mniTBookmark9 do
  begin
    Name := 'mniTBookmark9';
    Tag := 9;
    Caption := sBookmark + ' &9';
    OnClick := ToggleBookmark;
  end;
  with mniGotoBookmarks do
  begin
    Name := 'mniGotoBookmarks';
    Caption := sGotoBookmarksMenu;
  end;
  with mniGBookmark0 do
  begin
    Name := 'mniGBookmark0';
    Caption := sBookmark + ' &0';
    OnClick := GotoBookmark;
  end;
  with mniGBookmark1 do
  begin
    Name := 'mniGBookmark1';
    Tag := 1;
    Caption := sBookmark + ' &1';
    OnClick := GotoBookmark;
  end;
  with mniGBookmark2 do
  begin
    Name := 'mniGBookmark2';
    Tag := 2;
    Caption := sBookmark + ' &2';
    OnClick := GotoBookmark;
  end;
  with mniGBookmark3 do
  begin
    Name := 'mniGBookmark3';
    Tag := 3;
    Caption := sBookmark + ' &3';
    OnClick := GotoBookmark;
  end;
  with mniGBookmark4 do
  begin
    Name := 'mniGBookmark4';
    Tag := 4;
    Caption := sBookmark + ' &4';
    OnClick := GotoBookmark;
  end;
  with mniGBookmark5 do
  begin
    Name := 'mniGBookmark5';
    Tag := 5;
    Caption := sBookmark + ' &5';
    OnClick := GotoBookmark;
  end;
  with mniGBookmark6 do
  begin
    Name := 'mniGBookmark6';
    Tag := 6;
    Caption := sBookmark + ' &6';
    OnClick := GotoBookmark;
  end;
  with mniGBookmark7 do
  begin
    Name := 'mniGBookmark7';
    Tag := 7;
    Caption := sBookmark + ' &7';
    OnClick := GotoBookmark;
  end;
  with mniGBookmark8 do
  begin
    Name := 'mniGBookmark8';
    Tag := 8;
    Caption := sBookmark + ' &8';
    OnClick := GotoBookmark;
  end;
  with mniGBookmark9 do
  begin
    Name := 'mniGBookmark9';
    Tag := 9;
    Caption := sBookmark + ' &9';
    OnClick := GotoBookmark;
  end;
  with N6 do
  begin
    Name := 'N6';
    Caption := '-';
  end;
  with mniViewExplorer do
  begin
    Name := 'mniViewExplorer';
    Caption := sViewExplorer;
    ShortCut := 24645;
    OnClick := mniViewExplorerClick;
    ResourceName := 'IMG_CODEEXPLORER';
    NumGlyphs := 4;
  end;
  with mniToggleBreakpoint do
  begin
    Name := 'mniToggleBreakpoint';
    Caption := sToggleBreakpoint;
    ShortCut := 8308;
    OnClick := mniToggleBreakpointClick;
  end;
end;

//    ssShift, ssAlt, ssCtrl,
//    ssLeft, ssRight, ssMiddle, ssDouble
procedure TEditorForm.CreateTheEditor;
begin
  TheEditor := TBricxccSynEdit.Create(Self);
  TheEditor.DoubleBuffered := True;
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
//    PopupMenu := ConstructForm.ConstructMenu;
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

procedure TEditorForm.TheErrorsMouseMove(Sender: TObject;
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


function TEditorForm.GetPosition: integer;
begin
  Result := TheEditor.RowColToCharIndex(TheEditor.CaretXY);
end;

function TEditorForm.GetSource: string;
begin
  Result := TheEditor.Text;
end;

procedure TEditorForm.SetPosition(const Value: integer);
begin
  TheEditor.CaretXY := TheEditor.CharIndexToRowCol(Value-1);
end;

function TEditorForm.OpenFileOnPath(const fname: string): boolean;
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

{$IFDEF FPC}
initialization
  {$i Editor.lrs}
{$ENDIF}

end.
