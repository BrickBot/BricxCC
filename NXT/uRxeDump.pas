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
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uRxeDump;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, StdActns, ActnList, ImgList,
  ComCtrls, ToolWin, AppEvnts, uNXTClasses, uOfficeComp;

type
  TfrmNXTDumper = class(TForm)
    dlgOpen: TOpenDialog;
    aclMain: TActionList;
    actFileSaveAs: TFileSaveAs;
    actFileExit: TFileExit;
    actFileDump: TAction;
    barStatus: TStatusBar;
    actSearchFind: TSearchFind;
    actSearchFindNext: TSearchFindNext;
    actEditCut: TEditCut;
    actEditCopy: TEditCopy;
    actEditPaste: TEditPaste;
    actEditSelectAll: TEditSelectAll;
    actSearchReplace: TSearchReplace;
    dlgSave: TSaveDialog;
    actFileOpen: TFileOpen;
    actCompile: TAction;
    actPrint: TPrintDlg;
    actFileSave: TAction;
    actFileNew: TAction;
    pnlTop: TPanel;
    pag1: TPageControl;
    shtSource: TTabSheet;
    splMain: TSplitter;
    grpMessages: TGroupBox;
    mmoTest: TMemo;
    mmoDump: TMemo;
    mnuMain: TMainMenu;
    mniFile: TMenuItem;
    mniNew: TMenuItem;
    mniOpen: TMenuItem;
    mniFileSave: TMenuItem;
    mniSaveAs: TMenuItem;
    mniSep3: TMenuItem;
    mniCompile: TMenuItem;
    mniDump: TMenuItem;
    mniSep2: TMenuItem;
    mniPrint: TMenuItem;
    mniSep1: TMenuItem;
    mniExit: TMenuItem;
    mniEdit: TMenuItem;
    mniCut: TMenuItem;
    mniCopy: TMenuItem;
    mniPaste: TMenuItem;
    mniSelectAll: TMenuItem;
    mniSearch: TMenuItem;
    mniFind: TMenuItem;
    mniFindNext: TMenuItem;
    mniReplace: TMenuItem;
    mniHelp: TMenuItem;
    mniAbout: TMenuItem;
    popMain: TPopupMenu;
    mniPopCompile: TMenuItem;
    mniPopDump: TMenuItem;
    mniPopSep1: TMenuItem;
    mniPopCut: TMenuItem;
    mniPopCopy: TMenuItem;
    mniPopPaste: TMenuItem;
    mniPopSelectAll: TMenuItem;
    procedure actFileSaveAsAccept(Sender: TObject);
    procedure actFileSaveAsBeforeExecute(Sender: TObject);
    procedure actFileDumpExecute(Sender: TObject);
    procedure mniAboutClick(Sender: TObject);
    procedure aclMainUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actFileOpenAccept(Sender: TObject);
    procedure actCompileExecute(Sender: TObject);
    procedure actPrintAccept(Sender: TObject);
    procedure actFileSaveExecute(Sender: TObject);
    procedure actFileNewExecute(Sender: TObject);
    procedure mmoDumpChange(Sender: TObject);
    procedure mniSaveAsClick(Sender: TObject);
    procedure mniOpenClick(Sender: TObject);
  private
    { Private declarations }
    fProg : TRXEProgram;
    fCurrentFilename : string;
    fStoredCaption : string;
    fChanges : boolean;
    procedure DoSave;
    function FixFileExtension(const filename : string) : string;
    procedure SetCurrentFilename(const Value: string);
    procedure SetColorScheme;
  private
    ogp: TOfficeGradientPanel;
    osbOpen: TOfficeSpeedButton;
    osbNew: TOfficeSpeedButton;
    osbSaveAs: TOfficeSpeedButton;
    bvlSepPrint: TBevel;
    osbPrint: TOfficeSpeedButton;
    bvlSep1: TBevel;
    osbCut: TOfficeSpeedButton;
    osbCopy: TOfficeSpeedButton;
    osbPaste: TOfficeSpeedButton;
    bvlSep2: TBevel;
    osbFind: TOfficeSpeedButton;
    osbReplace: TOfficeSpeedButton;
    bvlSep3: TBevel;
    osbCompile: TOfficeSpeedButton;
    osbDump: TOfficeSpeedButton;
    bvlSep4: TBevel;
    osbAbout: TOfficeSpeedButton;
    procedure CreateToolbar;
  protected
    property CurrentFilename : string read fCurrentFilename write SetCurrentFilename;
  public
  end;

var
  frmNXTDumper: TfrmNXTDumper;

implementation

{$R *.dfm}

uses
  StrUtils, uAbout, Printers, Themes, FastStrings;

const
  NO_NAME = 'noname.nbc';
  
{ TfrmNXTDumper }

procedure TfrmNXTDumper.actFileDumpExecute(Sender: TObject);
var
  D : TRXEDumper;
begin
  if dlgOpen.Execute then
  begin
    CurrentFilename := dlgOpen.FileName;
    Application.ProcessMessages;
    Screen.Cursor := crHourGlass;
    try
      D := TRXEDumper.Create;
      try
//        D.OnlyDumpCode := chkOnlyCode.Checked;
        D.LoadFromFile(fCurrentFilename);
        D.DumpRXE(mmoDump.Lines);
        fChanges := False;
      finally
        D.Free;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
    mmoTest.Clear;
  end;
end;

procedure TfrmNXTDumper.actFileSaveAsAccept(Sender: TObject);
begin
  CurrentFilename := actFileSaveAs.Dialog.FileName;
  DoSave;
end;

procedure TfrmNXTDumper.actFileSaveAsBeforeExecute(Sender: TObject);
begin
  if fCurrentFilename <> '' then
    actFileSaveAs.Dialog.FileName := FixFileExtension(fCurrentFilename);
end;

procedure TfrmNXTDumper.mniAboutClick(Sender: TObject);
begin
  with TfrmAboutRXE.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmNXTDumper.aclMainUpdate(Action: TBasicAction;
  var Handled: Boolean);
var
  bNotEmpty : Boolean;
begin
  bNotEmpty := (mmoDump.Lines.Count <> 0);
  actFileSaveAs.Enabled := bNotEmpty;
  actFileSave.Enabled   := bNotEmpty and fChanges;
  actPrint.Enabled      := bNotEmpty;
  actCompile.Enabled    := bNotEmpty;
{
  osbSaveAs.Enabled     := actFileSaveAs.Enabled;
  osbPrint.Enabled      := actPrint.Enabled;
  osbCompile.Enabled    := actCompile.Enabled;
  osbCut.Enabled        := actEditCut.Enabled;
  osbCopy.Enabled       := actEditCopy.Enabled;
  osbPaste.Enabled      := actEditPaste.Enabled;
  osbFind.Enabled       := actSearchFind.Enabled;
  osbFindNext.Enabled   := actSearchFindNext.Enabled;
  osbReplace.Enabled    := actSearchReplace.Enabled;
}
end;

procedure TfrmNXTDumper.FormCreate(Sender: TObject);
begin
  CreateToolbar;
  Application.ShowHint := True;
  SetColorScheme;
  fStoredCaption := Caption;
  fProg := TRXEProgram.Create;
  dlgSave.Filter := dlgOpen.Filter;
  CurrentFilename := NO_NAME;
end;

procedure TfrmNXTDumper.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fProg);
end;

procedure TfrmNXTDumper.actFileOpenAccept(Sender: TObject);
begin
  CurrentFilename := actFileOpen.Dialog.FileName;
  mmoDump.Lines.LoadFromFile(fCurrentFilename);
  mmoTest.Clear;
  fChanges := False;
end;

procedure TfrmNXTDumper.actCompileExecute(Sender: TObject);
var
  ms : TMemoryStream;
  SL : TStringList;
begin
  Screen.Cursor := crHourGlass;
  try
    fProg.Clear;
    try
      fProg.CurrentFile := fCurrentFilename;
      SL := TStringList.Create;
      try
        SL.AddStrings(mmoDump.Lines);
        fProg.Parse(SL);
      finally
        SL.Free;
      end;
      ms := TMemoryStream.Create;
      try
        if fProg.SaveToStream(ms) then
        begin
          dlgSave.FileName := ChangeFileExt(fCurrentFilename, '.rxe');
          Screen.Cursor := crDefault;
          if dlgSave.Execute then
            ms.SaveToFile(dlgSave.FileName);
        end;
      finally
        ms.Free;
      end;
    finally
      mmoTest.Lines.Assign(fProg.CompilerMessages);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmNXTDumper.actPrintAccept(Sender: TObject);
var
  printtext : string;
  SL : TStringList;
  i, lines, H : integer;
begin
  SL := TStringList.Create;
  try
    if actPrint.Dialog.PrintRange = prSelection then
      printtext := mmoDump.SelText
    else
      printtext := mmoDump.Lines.Text;
    if Trim(printtext) = '' then Exit;
    SL.Text := FastReplace(printtext, #9, '  ');
    Printer.Copies := actPrint.Dialog.Copies;
    with Printer do
    begin
      BeginDoc;
      try
        H := Canvas.TextHeight('W');
        Canvas.Brush.Style := bsClear;
        lines := 0;
        for i := 0 to SL.Count - 1 do
        begin
          if 200 + (lines*H) > PageHeight then
          begin
            NewPage;
            lines := 0;
          end;
          Canvas.TextOut(200, 200 + (lines * H), SL[i]);
          inc(lines);
        end;
      finally
        EndDoc;
      end;
    end;
  finally
    SL.Free;
  end;
end;

procedure TfrmNXTDumper.actFileSaveExecute(Sender: TObject);
begin
  if fCurrentFilename = NO_NAME then
    actFileSaveAs.Execute
  else
    DoSave;
end;

procedure TfrmNXTDumper.DoSave;
begin
  if fCurrentFilename <> '' then
  begin
    CurrentFilename := FixFileExtension(fCurrentFilename);
    mmoDump.Lines.SaveToFile(fCurrentFilename);
    fChanges := False;
  end;
end;

procedure TfrmNXTDumper.SetCurrentFilename(const Value: string);
begin
  fCurrentFilename := Value;
  Caption := fStoredCaption + ' (' + ExtractFilename(fCurrentFilename) + ')';
end;

function TfrmNXTDumper.FixFileExtension(const filename : string) :  string;
var
  ext : string;
begin
  Result := filename;
  ext := LowerCase(ExtractFileExt(Result));
  if (ext <> '.txt') and (ext <> '.nbc') then
    Result := ChangeFileExt(Result, '.nbc');
end;

procedure TfrmNXTDumper.actFileNewExecute(Sender: TObject);
begin
  if fChanges then
  begin
    if (MessageDlg('Do you want to save your changes first?', mtWarning, [mbYes,mbNo], 0) = mrYes) then
      actFileSaveExecute(Sender);
  end;
  CurrentFilename := NO_NAME;
  mmoDump.Clear;
  mmoTest.Clear;
  fChanges := False;
end;

procedure TfrmNXTDumper.mmoDumpChange(Sender: TObject);
begin
  fChanges := True;
end;

procedure TfrmNXTDumper.SetColorScheme;
begin
  if ThemeServices.ThemesEnabled then
  begin
    Self.Color       := dxOffice11DockColor2;
    ogp.GradientFrom := dxOffice11ToolbarsColor1;
    ogp.GradientTo   := dxOffice11ToolbarsColor2;
    ogp.BorderColor  := ogp.GradientTo;
  end
  else
  begin
    Self.Color       := clBtnFace;
    ogp.GradientFrom := clBtnFace;
    ogp.GradientTo   := clBtnFace;
    ogp.BorderColor  := ogp.GradientTo;
  end;
end;

procedure TfrmNXTDumper.mniSaveAsClick(Sender: TObject);
begin
  actFileSaveAs.Execute;
end;

procedure TfrmNXTDumper.mniOpenClick(Sender: TObject);
begin
  actFileOpen.Execute;
end;

procedure TfrmNXTDumper.CreateToolbar;
begin
  ogp := TOfficeGradientPanel.Create(Self);
  osbOpen := TOfficeSpeedButton.Create(Self);
  osbNew := TOfficeSpeedButton.Create(Self);
  osbSaveAs := TOfficeSpeedButton.Create(Self);
  bvlSepPrint := TBevel.Create(Self);
  osbPrint := TOfficeSpeedButton.Create(Self);
  bvlSep1 := TBevel.Create(Self);
  osbCut := TOfficeSpeedButton.Create(Self);
  osbCopy := TOfficeSpeedButton.Create(Self);
  osbPaste := TOfficeSpeedButton.Create(Self);
  bvlSep2 := TBevel.Create(Self);
  osbFind := TOfficeSpeedButton.Create(Self);
  osbReplace := TOfficeSpeedButton.Create(Self);
  bvlSep3 := TBevel.Create(Self);
  osbCompile := TOfficeSpeedButton.Create(Self);
  osbDump := TOfficeSpeedButton.Create(Self);
  bvlSep4 := TBevel.Create(Self);
  osbAbout := TOfficeSpeedButton.Create(Self);
  with ogp do
  begin
    Name := 'ogp';
    Parent := Self;
    Caption := '';
    Left := 0;
    Top := 0;
    Width := 446;
    Height := 22;
    GradientFrom := clBtnFace;
    GradientTo := clBtnFace;
    BorderColor := clBlack;
    Horizontal := False;
    Align := alTop;
    TabOrder := 0;
  end;
  with osbOpen do
  begin
    Name := 'osbOpen';
    Parent := ogp;
    Left := 23;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileOpen;
    ResourceName := 'OPEN';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with osbNew do
  begin
    Name := 'osbNew';
    Parent := ogp;
    Left := 0;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileNew;
    ResourceName := 'FILENEW';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with osbSaveAs do
  begin
    Name := 'osbSaveAs';
    Parent := ogp;
    Left := 46;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileSave;
    ResourceName := 'SAVE';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with bvlSepPrint do
  begin
    Name := 'bvlSepPrint';
    Parent := ogp;
    Left := 69;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with osbPrint do
  begin
    Name := 'osbPrint';
    Parent := ogp;
    Left := 77;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actPrint;
    ResourceName := 'PRINT';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with bvlSep1 do
  begin
    Name := 'bvlSep1';
    Parent := ogp;
    Left := 100;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with osbCut do
  begin
    Name := 'osbCut';
    Parent := ogp;
    Left := 108;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actEditCut;
    ResourceName := 'CUT';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with osbCopy do
  begin
    Name := 'osbCopy';
    Parent := ogp;
    Left := 131;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actEditCopy;
    ResourceName := 'COPY';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with osbPaste do
  begin
    Name := 'osbPaste';
    Parent := ogp;
    Left := 154;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actEditPaste;
    ResourceName := 'PASTE';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with bvlSep2 do
  begin
    Name := 'bvlSep2';
    Parent := ogp;
    Left := 177;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with osbFind do
  begin
    Name := 'osbFind';
    Parent := ogp;
    Left := 185;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actSearchFind;
    ResourceName := 'FIND';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with osbReplace do
  begin
    Name := 'osbReplace';
    Parent := ogp;
    Left := 208;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actSearchReplace;
    ResourceName := 'REPLACE';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with bvlSep3 do
  begin
    Name := 'bvlSep3';
    Parent := ogp;
    Left := 231;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with osbCompile do
  begin
    Name := 'osbCompile';
    Parent := ogp;
    Left := 239;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actCompile;
    ResourceName := 'COMPILE';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with osbDump do
  begin
    Name := 'osbDump';
    Parent := ogp;
    Left := 262;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileDump;
    ResourceName := 'DECOMPILE';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with bvlSep4 do
  begin
    Name := 'bvlSep4';
    Parent := ogp;
    Left := 285;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with osbAbout do
  begin
    Name := 'osbAbout';
    Parent := ogp;
    Left := 293;
    Top := 0;
    Width := 23;
    Height := 22;
    ResourceName := 'ABOUT';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
end;

end.
