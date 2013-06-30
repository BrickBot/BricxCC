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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uMacroForm;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
{$ENDIF}
  Classes, Controls, Forms, Dialogs, StdCtrls, ComCtrls, uNewHotKey, uMacroLib;

type
  TfrmMacroManager = class(TForm)
    lblMacroName: TLabel;
    edtName: TEdit;
    lstMacros: TListBox;
    btnRun: TButton;
    btnEdit: TButton;
    btnCreate: TButton;
    btnDelete: TButton;
    btnCancel: TButton;
    lblMacrosIn: TLabel;
    cboLibrary: TComboBox;
    btnBrowse: TButton;
    lblDescription: TLabel;
    mmoDescription: TMemo;
    dlgOpen: TOpenDialog;
    btnOK: TButton;
    lblHotKey: TLabel;
    chkSuspend: TCheckBox;
    btnHelp: TButton;
    hkMacro2: TEdit;
    procedure btnBrowseClick(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure lstMacrosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtNameChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cboLibraryClick(Sender: TObject);
    procedure cboLibraryExit(Sender: TObject);
    procedure mmoDescriptionChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkSuspendClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure hkMacroExit(Sender: TObject);
  private
    { Private declarations }
    FMacroLibrary: TMacroLibrary;
    fUpdateCount : Integer;
    FChangesMade: Boolean;
    procedure HandleMacroAdded(Sender: TObject);
    procedure SetChangesMade(const Value: Boolean);
    procedure UpdateButtonState;
    procedure UpdateMacroControls;
    function  GetMacroDescription(i : Integer) : string;
    function  GetMacroHotKey(i : Integer) : TShortCut;
    procedure LoadLibrary(aFilename : string);
    procedure SetCurrentLibraryPath(const Value: string);
    function  GetCurrentLibraryPath: string;
    procedure AddLibrary(aPath : string);
    procedure LibraryChanged;
    procedure RefreshMacroList;
    procedure BeginUpdates;
    procedure EndUpdates;
    function InUpdatingState : Boolean;
    procedure SaveLibrary;
    procedure CreateHotKeyEdit;
    property ChangesMade : Boolean read FChangesMade write SetChangesMade;
  public
    hkMacro: TBricxCCHotKey;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property MacroLibrary : TMacroLibrary read FMacroLibrary;
    property CurrentLibraryPath : string read GetCurrentLibraryPath write SetCurrentLibraryPath;
  end;

var
  frmMacroManager: TfrmMacroManager;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  SysUtils, uMacroEditor, uLocalizedStrings, uGuiUtils;

procedure TfrmMacroManager.btnBrowseClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
    CurrentLibraryPath := dlgOpen.FileName;
  end;
end;

procedure TfrmMacroManager.btnRunClick(Sender: TObject);
var
  i : Integer;
begin
  // run macro
  if not btnRun.Enabled then Exit;
  i := lstMacros.ItemIndex;
  if i <> -1 then
    FMacroLibrary.Playback(i);
end;

procedure TfrmMacroManager.btnEditClick(Sender: TObject);
var
  i : Integer;
begin
  // edit macro
  i := lstMacros.ItemIndex;
  if i <> -1 then
    with TfrmMacroEditor.Create(nil) do
    try
      MacroText := FMacroLibrary.Items[i].Code.Text;
      if ShowModal = mrOK then
      begin
        FMacroLibrary.Items[i].Code.Text := MacroText;
        FMacroLibrary.Items[i].Name := MacroName;
        ChangesMade := True;
        RefreshMacroList;
      end;
    finally
      Free;
    end;
end;

procedure TfrmMacroManager.btnCreateClick(Sender: TObject);
var
  MI : TMacroItem;
begin
  // create macro (edit new macro)
  with TfrmMacroEditor.Create(nil) do
  try
    if ShowModal = mrOK then
    begin
      MI := FMacroLibrary.Add;
      MI.Code.Text := MacroText;
      MI.Name := MacroName;
      ChangesMade := True;
      RefreshMacroList;
    end;
  finally
    Free;
  end;
end;

procedure TfrmMacroManager.btnDeleteClick(Sender: TObject);
var
  i : Integer;
begin
  // delete macro
  i := lstMacros.ItemIndex;
  if i <> -1 then
  begin
    if MessageDlg(sConfirmDeleteMM,
                  mtConfirmation, [mbOK,mbCancel], 0) = mrOk then
    begin
      BeginUpdates;
      try
        edtName.Text := '';
        FMacroLibrary.Delete(i);
        RefreshMacroList;
        ChangesMade := True;
      finally
        EndUpdates;
      end;
      UpdateButtonState;
    end;
  end;
end;

procedure TfrmMacroManager.lstMacrosClick(Sender: TObject);
begin
  UpdateMacroControls;
end;

procedure TfrmMacroManager.FormCreate(Sender: TObject);
begin
  CreateHotKeyEdit;
  UpdateButtonState;
end;

procedure TfrmMacroManager.UpdateButtonState;
begin
  btnDelete.Enabled := lstMacros.ItemIndex <> -1;
  btnEdit.Enabled   := btnDelete.Enabled;
  btnRun.Enabled    := btnDelete.Enabled and Assigned(MacroLibrary.ActiveEditor);
  btnCreate.Enabled := Trim(edtName.Text) <> '';
  mmoDescription.ReadOnly := not btnDelete.Enabled;
end;

procedure TfrmMacroManager.edtNameChange(Sender: TObject);
begin
  if not InUpdatingState then
    UpdateButtonState;
end;

function TfrmMacroManager.GetMacroDescription(i: Integer): string;
begin
  Result := FMacroLibrary.Items[i].Description;
end;

constructor TfrmMacroManager.Create(AOwner: TComponent);
begin
  inherited;
  fUpdateCount := 0;
  FChangesMade := False;
  FMacroLibrary := TMacroLibrary.Create(Application.MainForm);
  FMacroLibrary.OnMacroAdded := HandleMacroAdded;
end;

destructor TfrmMacroManager.Destroy;
begin
  FMacroLibrary.Free;
  inherited;
end;

procedure TfrmMacroManager.LoadLibrary(aFilename: string);
begin
  FMacroLibrary.LoadFromFile(aFilename);
  RefreshMacroList;
  FChangesMade := False;
end;

procedure TfrmMacroManager.UpdateMacroControls;
begin
  BeginUpdates;
  try
    edtName.Text := '';
    mmoDescription.Text := '';
    hkMacro.HotKey := 0;
    if lstMacros.ItemIndex <> -1 then
    begin
      edtName.Text := lstMacros.Items[lstMacros.ItemIndex];
      mmoDescription.Text := GetMacroDescription(lstMacros.ItemIndex);
      hkMacro.HotKey := GetMacroHotKey(lstMacros.ItemIndex);
    end;
  finally
    EndUpdates;
  end;
  UpdateButtonState;
end;

procedure TfrmMacroManager.SetCurrentLibraryPath(const Value: string);
begin
  if FileExists(Value) then
    AddLibrary(Value);
end;

function TfrmMacroManager.GetCurrentLibraryPath: string;
begin
  Result := cboLibrary.Text;
end;

procedure TfrmMacroManager.AddLibrary(aPath: string);
var
  i : Integer;
begin
  i := cboLibrary.Items.IndexOf(aPath);
  if i = -1 then
  begin
    i := cboLibrary.Items.Add(aPath);
  end;
  if cboLibrary.ItemIndex <> i then
  begin
    cboLibrary.ItemIndex := i;
    LibraryChanged;
  end;
end;

procedure TfrmMacroManager.LibraryChanged;
begin
  // reload macro library from selected file and populate list box
  if FileExists(cboLibrary.Text) then
  begin
    LoadLibrary(cboLibrary.Text);
  end;
end;

procedure TfrmMacroManager.btnCancelClick(Sender: TObject);
begin
  if ChangesMade then
  begin
    // revert changes by clearing library and reloading (if possible)
    FMacroLibrary.Clear;
    LibraryChanged;
  end;
end;

procedure TfrmMacroManager.btnOKClick(Sender: TObject);
begin
  // attempt to save changes
  if ChangesMade then
    SaveLibrary;
end;

procedure TfrmMacroManager.cboLibraryClick(Sender: TObject);
begin
  LibraryChanged;
end;

procedure TfrmMacroManager.cboLibraryExit(Sender: TObject);
begin
  CurrentLibraryPath := ChangeFileExt(cboLibrary.Text, '.mlb');
end;

procedure TfrmMacroManager.RefreshMacroList;
var
  i, oldIdx : Integer;
begin
  oldIdx := lstMacros.ItemIndex;
  lstMacros.Clear;
  for i := 0 to FMacroLibrary.Count - 1 do
  begin
    lstMacros.Items.Add(FMacroLibrary.Items[i].Name);
  end;
  if lstMacros.Items.Count > 0 then
  begin
    if (oldIdx <> -1) and (oldIdx < lstMacros.Items.Count) then
      lstMacros.ItemIndex := oldIdx
    else
      lstMacros.ItemIndex := 0;
  end;
  UpdateMacroControls;
end;

procedure TfrmMacroManager.mmoDescriptionChange(Sender: TObject);
var
  i : Integer;
begin
  if not InUpdatingState then
  begin
    i := lstMacros.ItemIndex;
    if i <> -1 then
    begin
      FMacroLibrary.Items[i].Description := mmoDescription.Text;
    end;
    ChangesMade := True;
  end;
end;

procedure TfrmMacroManager.BeginUpdates;
begin
  Inc(fUpdateCount);
end;

procedure TfrmMacroManager.EndUpdates;
begin
  Dec(fUpdateCount);
end;

function TfrmMacroManager.InUpdatingState: Boolean;
begin
  Result := fUpdateCount > 0;
end;

procedure TfrmMacroManager.SetChangesMade(const Value: Boolean);
begin
  FChangesMade := Value;
end;

procedure TfrmMacroManager.SaveLibrary;
begin
  try
    FMacroLibrary.SaveToFile(ChangeFileExt(cboLibrary.Text, '.mlb'));
  except
  end;
  ChangesMade := False;
end;

procedure TfrmMacroManager.HandleMacroAdded(Sender: TObject);
begin
  ChangesMade := True;
end;

procedure TfrmMacroManager.FormShow(Sender: TObject);
begin
  RefreshMacroList;
end;

procedure TfrmMacroManager.hkMacroExit(Sender: TObject);
var
  i : Integer;
begin
  if not InUpdatingState then
  begin
    i := lstMacros.ItemIndex;
    if i <> -1 then
    begin
      FMacroLibrary.Items[i].ShortCut := hkMacro.HotKey;
    end;
    ChangesMade := True;
  end;
end;

function TfrmMacroManager.GetMacroHotKey(i: Integer): TShortCut;
begin
  Result := FMacroLibrary.Items[i].ShortCut;
end;

procedure TfrmMacroManager.chkSuspendClick(Sender: TObject);
begin
  MacroLibrary.Suspended := chkSuspend.Checked;
end;

procedure TfrmMacroManager.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TfrmMacroManager.CreateHotKeyEdit;
begin
  hkMacro := TBricxCCHotKey.Create(Self);
  CloneHotKey(hkMacro, hkMacro2);
  hkMacro.OnExit := hkMacroExit;
end;

{$IFDEF FPC}
initialization
  {$i uMacroForm.lrs}
{$ENDIF}

end.