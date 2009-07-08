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
unit uProjectManager;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
{$ENDIF}
  Classes, Controls, Forms, Dialogs, Menus, StdCtrls, uOfficeComp;

type
  TfrmProjectManager = class(TForm)
    lstFiles: TListBox;
    lblFiles: TLabel;
    dlgOpen: TOpenDialog;
    lblProject: TLabel;
    btnHelp: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lstFilesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lstFilesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lstFilesDblClick(Sender: TObject);
    procedure lstFilesClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    mnuPopup: TOfficePopupMenu;
    mniAdd: TOfficeMenuItem;
    mniRemove: TOfficeMenuItem;
    mniOpen: TOfficeMenuItem;
    procedure CreatePopupMenu;
    procedure mniAddClick(Sender: TObject);
    procedure mniRemoveClick(Sender: TObject);
    procedure mniOpenClick(Sender: TObject);
  private
    { Private declarations }
    fProjFile : string;
    function GetProjFile: string;
    procedure SetProjFile(const Value: string);
    procedure UpdateMenuItems;
    procedure Show; reintroduce;
  public
    { Public declarations }
    property ProjectFile : string read GetProjFile write SetProjFile;
    procedure ShowProjectManager(aFile : string);
  end;

var
  frmProjectManager: TfrmProjectManager;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  SysUtils, MainUnit, Preferences, SynEditHighlighter, uLocalizedStrings;

procedure TfrmProjectManager.mniAddClick(Sender: TObject);
var
  i : Integer;
  f : string;
begin
  if dlgOpen.Execute then begin
    for i := 0 to dlgOpen.Files.Count - 1 do begin
      f := ExtractFileName(dlgOpen.Files[i]);
      if (lstFiles.Items.Indexof(f) = -1) and (f <> ProjectFile) then
        lstFiles.Items.Add(f);
    end;
    UpdateMenuItems;
  end;
end;

procedure TfrmProjectManager.mniRemoveClick(Sender: TObject);
var
  i : Integer;
begin
  if MessageDlg(sRemoveConfirm, mtConfirmation, [mbYes,mbNo], 0) = mrYes then
  begin
    for i := lstFiles.Items.Count - 1 downto 0 do begin
      if lstFiles.Selected[i] then
        lstFiles.Items.Delete(i);
    end;
    UpdateMenuItems;
  end;
end;

procedure TfrmProjectManager.mniOpenClick(Sender: TObject);
var
  i : Integer;
begin
  Close;
  i := lstFiles.ItemIndex;
  if i <> -1 then
    MainForm.OpenFile(ExtractFilePath(fProjFile)+lstFiles.Items[i]);
end;

procedure TfrmProjectManager.lstFilesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = Sender;
end;

procedure TfrmProjectManager.lstFilesDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  i, s : integer;
begin
  s := lstFiles.ItemIndex;
  i := lstFiles.ItemAtPos(Point(X, Y), True);
  if i <> -1 then
  begin
    lstFiles.Items.Move(s, i);
    lstFiles.ItemIndex := i;
  end;
end;

procedure TfrmProjectManager.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // save project file
  lstFiles.Items.SaveToFile(fProjFile);
end;

procedure TfrmProjectManager.FormCreate(Sender: TObject);
begin
  CreatePopupMenu;
  lstFiles.PopupMenu := mnuPopup;
  lblProject.Caption := '';
  dlgOpen.Filter := MainForm.dlgOpen.Filter;
end;

function TfrmProjectManager.GetProjFile: string;
begin
  Result := lblProject.Caption;
end;

procedure TfrmProjectManager.SetProjFile(const Value: string);
var
  SCH : TSynCustomHighlighter;
begin
  lblProject.Caption := ExtractFileName(Value);
  // attempt to open the project file and load it into lblFiles.
  fProjFile := ChangeFileExt(Value, '.prj');
  dlgOpen.InitialDir := ExtractFilePath(fProjFile);
  SCH := GetHighlighterForFile(Value);
  dlgOpen.FilterIndex := Highlighters.IndexOf(SCH.LanguageName)+1;
  lstFiles.Clear; // empty the list of files
  if FileExists(fProjFile) then
    lstFiles.Items.LoadFromFile(fProjFile);
  UpdateMenuItems;
end;

procedure TfrmProjectManager.lstFilesDblClick(Sender: TObject);
begin
  mniOpenClick(Sender);
end;

procedure TfrmProjectManager.UpdateMenuItems;
begin
  mniAdd.Enabled    := True;
  mniRemove.Enabled := (lstFiles.Items.Count > 0) and (lstFiles.ItemIndex <> -1);
  mniOpen.Enabled   := mniRemove.Enabled;
end;

procedure TfrmProjectManager.lstFilesClick(Sender: TObject);
begin
  UpdateMenuItems;
end;

procedure TfrmProjectManager.ShowProjectManager(aFile: string);
begin
  ProjectFile := aFile;
  Show;
end;

procedure TfrmProjectManager.Show;
begin
  inherited Show;
end;

procedure TfrmProjectManager.FormShow(Sender: TObject);
begin
  UpdateMenuItems;
end;

procedure TfrmProjectManager.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TfrmProjectManager.CreatePopupMenu;
begin
  mnuPopup := TOfficePopupMenu.Create(Self);
  mnuPopup.Name := 'mnuPopup';
  mniAdd := TOfficeMenuItem.Create(mnuPopup);
  mniRemove := TOfficeMenuItem.Create(mnuPopup);
  mniOpen := TOfficeMenuItem.Create(mnuPopup);
  mnuPopup.Items.Add([mniAdd, mniRemove, mniOpen]);
  with mniAdd do
  begin
    Name := 'mniAdd';
    Caption := 'Add...';
    ShortCut := 16429;
    OnClick := mniAddClick;
  end;
  with mniRemove do
  begin
    Name := 'mniRemove';
    Caption := 'Remove from Project';
    ShortCut := 16430;
    OnClick := mniRemoveClick;
  end;
  with mniOpen do
  begin
    Name := 'mniOpen';
    Caption := 'Open';
    ShortCut := 16463;
    OnClick := mniOpenClick;
  end;
end;

{$IFDEF FPC}
initialization
  {$i uProjectManager.lrs}
{$ENDIF}

end.
