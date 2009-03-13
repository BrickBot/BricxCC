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
unit urxedumplaz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, ExtCtrls, Menus, uNXTClasses, Buttons;

type

  { TfrmRxeDumpLaz }

  TfrmRxeDumpLaz = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    grpMessages: TGroupBox;
    MenuItem1: TMenuItem;
    mniAbout: TMenuItem;
    mniHelp: TMenuItem;
    mniFindNext: TMenuItem;
    mniReplace: TMenuItem;
    mniFind: TMenuItem;
    mniCopy: TMenuItem;
    mniPaste: TMenuItem;
    mniSelectAll: TMenuItem;
    mniCut: TMenuItem;
    mniEdit: TMenuItem;
    mniExit: TMenuItem;
    mniSep3: TMenuItem;
    mniDecompile: TMenuItem;
    mniPrint: TMenuItem;
    mniSep2: TMenuItem;
    mniFile: TMenuItem;
    mniNew: TMenuItem;
    mniOpen: TMenuItem;
    mniSave: TMenuItem;
    mniSaveAs: TMenuItem;
    mniSep1: TMenuItem;
    mniCompile: TMenuItem;
    mnuMain: TMainMenu;
    mmoDump: TMemo;
    mmoTest: TMemo;
    dlgOpen: TOpenDialog;
    PageControl1: TPageControl;
    dlgSave: TSaveDialog;
    btnNew: TSpeedButton;
    btnOpen: TSpeedButton;
    btnSaveAs: TSpeedButton;
    btnPrint: TSpeedButton;
    btnCut: TSpeedButton;
    btnCopy: TSpeedButton;
    btnPaste: TSpeedButton;
    btnFind: TSpeedButton;
    btnReplace: TSpeedButton;
    btnCompile: TSpeedButton;
    btnDump: TSpeedButton;
    btnAbout: TSpeedButton;
    Splitter1: TSplitter;
    barStatus: TStatusBar;
    shtSource: TTabSheet;
    ToolBar1: TToolBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mniAboutClick(Sender: TObject);
    procedure mniCompileClick(Sender: TObject);
    procedure mniDecompileClick(Sender: TObject);
    procedure mniExitClick(Sender: TObject);
    procedure mniNewClick(Sender: TObject);
    procedure mniOpenClick(Sender: TObject);
    procedure mniPrintClick(Sender: TObject);
    procedure mniSaveAsClick(Sender: TObject);
    procedure mniSaveClick(Sender: TObject);
  private
    { private declarations }
    fProg : TRXEProgram;
    fCurrentFilename : string;
    fStoredCaption : string;
    fChanges : boolean;
    procedure DoSave;
    function FixFileExtension(const filename : string) : string;
    procedure SetCurrentFilename(const Value: string);
  protected
    property CurrentFilename : string read fCurrentFilename write SetCurrentFilename;
  public
    { public declarations }
  end; 

var
  frmRxeDumpLaz: TfrmRxeDumpLaz;

implementation

const
  NO_NAME = 'noname.nbc';
  
{ TfrmRxeDumpLaz }

procedure TfrmRxeDumpLaz.mniExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRxeDumpLaz.mniAboutClick(Sender: TObject);
begin
  ShowMessage('NBC Program Dumper'#13#10'Copyright (c) 2006, John Hansen');
end;

procedure TfrmRxeDumpLaz.mniCompileClick(Sender: TObject);
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

procedure TfrmRxeDumpLaz.mniDecompileClick(Sender: TObject);
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

procedure TfrmRxeDumpLaz.FormCreate(Sender: TObject);
begin
  Application.ShowHint := True;
  fStoredCaption := Caption;
  fProg := TRXEProgram.Create;
  dlgSave.Filter := dlgOpen.Filter;
  CurrentFilename := NO_NAME;
end;

procedure TfrmRxeDumpLaz.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fProg);
end;

procedure TfrmRxeDumpLaz.mniNewClick(Sender: TObject);
begin
  if fChanges then
  begin
    if (MessageDlg('Do you want to save your changes first?', mtWarning, [mbYes,mbNo], 0) = mrYes) then
      mniSaveClick(Sender);
  end;
  CurrentFilename := NO_NAME;
  mmoDump.Clear;
  mmoTest.Clear;
  fChanges := False;
end;

procedure TfrmRxeDumpLaz.mniOpenClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
    CurrentFilename := dlgOpen.FileName;
    mmoDump.Lines.LoadFromFile(fCurrentFilename);
    mmoTest.Clear;
    fChanges := False;
  end;
end;

procedure TfrmRxeDumpLaz.mniPrintClick(Sender: TObject);
begin
//
end;

procedure TfrmRxeDumpLaz.mniSaveAsClick(Sender: TObject);
begin
  if fCurrentFilename <> '' then
    dlgSave.FileName := FixFileExtension(fCurrentFilename);
  if dlgSave.Execute then
  begin
    CurrentFilename := dlgSave.FileName;
    DoSave;
  end;
end;

procedure TfrmRxeDumpLaz.mniSaveClick(Sender: TObject);
begin
  if fCurrentFilename = NO_NAME then
    mniSaveAsClick(Sender)
  else
    DoSave;
end;

procedure TfrmRxeDumpLaz.DoSave;
begin
  if fCurrentFilename <> '' then
  begin
    CurrentFilename := FixFileExtension(fCurrentFilename);
    mmoDump.Lines.SaveToFile(fCurrentFilename);
    fChanges := False;
  end;
end;

function TfrmRxeDumpLaz.FixFileExtension(const filename: string): string;
var
  ext : string;
begin
  Result := filename;
  ext := LowerCase(ExtractFileExt(Result));
  if (ext <> '.txt') and (ext <> '.nbc') then
    Result := ChangeFileExt(Result, '.nbc');
end;

procedure TfrmRxeDumpLaz.SetCurrentFilename(const Value: string);
begin
  fCurrentFilename := Value;
  Caption := fStoredCaption + ' (' + ExtractFilename(fCurrentFilename) + ')';
end;

initialization
  {$I urxedumplaz.lrs}

end.

