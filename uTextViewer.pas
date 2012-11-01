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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uTextViewer;

interface

uses
  Messages, Classes, Controls, Forms, Dialogs, Menus,
  StdCtrls, ComCtrls, uOfficeComp;

type
  TfrmTextView = class(TForm)
    OpenDlg: TOpenDialog;
    SaveDlg: TSaveDialog;
    StatusBar: TStatusBar;
    MenuPopup: TPopupMenu;
    MenuSelectAll: TMenuItem;
    MenuCopy: TMenuItem;
    N1: TMenuItem;
    MenuOpen: TMenuItem;
    MenuSaveAs: TMenuItem;
    Memo: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure MenuOpenClick(Sender: TObject);
    procedure MenuSaveAsClick(Sender: TObject);
    procedure MenuPopupPopup(Sender: TObject);
    procedure MenuSelectAllClick(Sender: TObject);
    procedure MenuCopyClick(Sender: TObject);
  private
//    procedure Progress(Address:LongInt);
  protected
  public
    procedure OpenFile(const aFilename : string);
    procedure ShowStreamData(const aFilename : string; aStream : TStream);
  end;

var
  frmTextView: TfrmTextView;

implementation

{$R *.dfm}

uses
  SysUtils;

{
procedure TfrmTextView.Progress(Address:LongInt);
begin
  StatusBar.SimpleText := 'Reading...  $'+IntToHex(Address,5);
  StatusBar.Update;
end;
}

procedure TfrmTextView.FormCreate(Sender: TObject);
begin
  // configure open dialog filter
  OpenDlg.Filter :=
    'Text (*.txt)|*.txt|' +
    'All files (*.*)|*.*';
end;

procedure TfrmTextView.MenuOpenClick(Sender: TObject);
begin
 if OpenDlg.Execute then
   OpenFile(OpenDlg.Filename);
end;


procedure TfrmTextView.MenuSaveAsClick(Sender: TObject);
begin
  SaveDlg.Filename := OpenDlg.FileName;
  if SaveDlg.Execute then
    Memo.Lines.SaveToFile(SaveDlg.FileName);
end;

procedure TfrmTextView.MenuPopupPopup(Sender: TObject);
begin
  MenuCopy.Enabled := Memo.SelLength > 0;
end;

procedure TfrmTextView.MenuSelectAllClick(Sender: TObject);
begin
  Memo.SelectAll;
end;

procedure TfrmTextView.MenuCopyClick(Sender: TObject);
begin
  Memo.CopyToClipboard;
end;

procedure TfrmTextView.OpenFile(const aFilename: string);
var
  fname : string;
begin
  Screen.Cursor := crHourglass;
  try
    fname := ExtractFileName(aFilename);
    StatusBar.SimpleText := 'Reading...';
    Memo.Lines.Clear;
    Application.ProcessMessages;
    try
      Memo.Lines.LoadFromFile(aFilename);
      StatusBar.SimpleText := fname;
    except
      on E:EFOpenError do
      begin
        StatusBar.SimpleText := '';
        MessageDlg(Format('Can''t open file %s.',[fname]),mtError,[mbOk],0);
      end;
    end;
  finally
   Screen.Cursor := crDefault;
  end;
end;

procedure TfrmTextView.ShowStreamData(const aFilename : string; aStream: TStream);
begin
  Show;
  Screen.Cursor := crHourglass;
  try
    StatusBar.SimpleText := 'Reading...';
    Memo.Lines.Clear;
    Application.ProcessMessages;
    try
      aStream.Position := 0;
      Memo.Lines.LoadFromStream(aStream);
      StatusBar.SimpleText := aFilename;
    except
      on E:EFOpenError do
      begin
        StatusBar.SimpleText := '';
        MessageDlg(Format('Can''t open file %s.',[aFilename]),mtError,[mbOk],0);
      end;
    end;
  finally
   Screen.Cursor := crDefault;
  end;
end;

end.