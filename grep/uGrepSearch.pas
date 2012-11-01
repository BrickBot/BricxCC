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
 * Portions of this code are covered under the GExperts license
 * http://www.gexperts.org/license.html
 *
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uGrepSearch;

interface

uses
  Classes, Controls, Forms, StdCtrls, uGrepExpert, uGrepBackend;

type
  TfmGrepSearch = class(TForm)
    lblFind: TLabel;
    cbText: TComboBox;
    gbxOptions: TGroupBox;
    cbCaseSensitive: TCheckBox;
    cbNoComments: TCheckBox;
    gbxWhere: TGroupBox;
    rbOpenFiles: TRadioButton;
    rbDirectories: TRadioButton;
    gbxDirectories: TGroupBox;
    lblMasks: TLabel;
    cbMasks: TComboBox;
    cbInclude: TCheckBox;
    btnOK: TButton;
    btnCancel: TButton;
    cbWholeWord: TCheckBox;
    rbCurrentOnly: TRadioButton;
    btnHelp: TButton;
    cbRegEx: TCheckBox;
    cbDirectory: TComboBox;
    btnBrowse: TButton;
    lblDirectory: TLabel;
    rbResults: TRadioButton;
    procedure btnBrowseClick(Sender: TObject);
    procedure rbDirectoriesClick(Sender: TObject);
    procedure cbDirectoryDropDown(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FGrepExpert: TGrepExpert;
    procedure EnableDirectoryControls(New: Boolean);
    procedure LoadFormSettings;
    procedure SaveFormSettings;
  public
    constructor Create(AOwner: TComponent); override;
    procedure RetrieveSettings(var Value: TGrepSettings);
    property GrepExpert: TGrepExpert read FGrepExpert;
  end;

  TGrepDlgExpert = class(TObject)
  public
    constructor Create; virtual;
    function GetActionCaption: string; virtual;
    class function GetName: string; virtual;
    procedure Click(Sender: TObject); virtual;
    procedure Configure; virtual;
  end;

implementation

{$R *.dfm}

uses
  SysUtils, Windows, Messages, Graphics, Menus, Math, Dialogs,
  uGrepResults, uGrepOptions, uGrepRegExSearch, RegExpr,
  uGrepCommonUtils;

resourcestring
  SGrepResultsNotActive = 'The Grep Results window is not active';

procedure TfmGrepSearch.btnBrowseClick(Sender: TObject);
var
  Temp: string;
begin
  Temp := cbDirectory.Text;
  if GetDirectory(Temp) then
    cbDirectory.Text := Temp;
end;

procedure TfmGrepSearch.EnableDirectoryControls(New: Boolean);
begin
  cbDirectory.Enabled := New;
  cbMasks.Enabled := New;
  cbInclude.Enabled := New;
  btnBrowse.Enabled := New;
  if not New then
  begin
    cbDirectory.Color := clBtnface;
    cbMasks.Color := clBtnface;
  end
  else
  begin
    cbDirectory.Color := clWindow;
    cbMasks.Color := clWindow;
  end
end;

procedure TfmGrepSearch.rbDirectoriesClick(Sender: TObject);
begin
  EnableDirectoryControls(rbDirectories.Checked);
end;

procedure TfmGrepSearch.cbDirectoryDropDown(Sender: TObject);
var
  i: Integer;
  MaxWidth: Integer;
  Bitmap: Graphics.TBitmap;
begin
  MaxWidth := cbDirectory.Width;
  Bitmap := Graphics.TBitmap.Create;
  try
    Bitmap.Canvas.Font.Assign(cbDirectory.Font);
    for i := 0 to cbDirectory.Items.Count - 1 do
      MaxWidth := Max(MaxWidth, Bitmap.Canvas.TextWidth(cbDirectory.Items[i]) + 10);
  finally;
    FreeAndNil(Bitmap);
  end;
  if cbDirectory.Items.Count > cbDirectory.DropDownCount then
    Inc(MaxWidth, GetScrollbarWidth);
  MaxWidth := Min(400, MaxWidth);
  if MaxWidth > cbDirectory.Width then
    SendMessage(cbDirectory.Handle, CB_SETDROPPEDWIDTH, MaxWidth, 0)
  else
    SendMessage(cbDirectory.Handle, CB_SETDROPPEDWIDTH, 0, 0)
end;

{ TGrepDlgExpert }

constructor TGrepDlgExpert.Create;
begin
  inherited Create;
end;

function TGrepDlgExpert.GetActionCaption: string;
resourcestring
  SActionCaption = '&Grep Search...';
begin
  Result := SActionCaption;
end;

class function TGrepDlgExpert.GetName: string;
begin
  Result := 'GrepSearch'; // Do not localize.
end;

procedure TGrepDlgExpert.Click(Sender: TObject);
begin
  if Assigned(fmGrepResults) then
    fmGrepResults.Execute(False)
  else
    raise Exception.Create(SGrepResultsNotActive);
end;

procedure TGrepDlgExpert.Configure;
var
  Dialog: TfmGrepOptions;
  GrepExpert: TGrepExpert;
begin
  if not Assigned(fmGrepResults) then
    raise Exception.Create(SGrepResultsNotActive);

   GrepExpert := fmGrepResults.GrepExpert;
   Assert(Assigned(GrepExpert));

  Dialog := TfmGrepOptions.Create(nil);
  try
    Dialog.chkGrepUseCurrentIdent.Checked := GrepExpert.GrepUseCurrentIdent;
    if Dialog.ShowModal = mrOk then
    begin
      GrepExpert.GrepUseCurrentIdent := Dialog.chkGrepUseCurrentIdent.Checked;
    end;
  finally
    FreeAndNil(Dialog);
  end;
end;

procedure TfmGrepSearch.btnOKClick(Sender: TObject);
resourcestring
  SSpecifiedDirectoryDoesNotExist = 'The search directory %s does not exist';
var
  i: Integer;
  Dirs: TStringList;
begin
  if rbDirectories.Checked then
  begin
    if Trim(cbDirectory.Text) = '' then
      cbDirectory.Text := GetCurrentDir;
    Dirs := TStringList.Create;
    try
      AnsiStrTok(cbDirectory.Text, ';', Dirs);
      for i := 0 to Dirs.Count - 1 do
      begin
        Dirs[i] := ExpandFileName(IncludeTrailingPathDelimiter(Dirs[i]));
        if not DirectoryExists(Dirs[i]) then
          raise Exception.CreateFmt(SSpecifiedDirectoryDoesNotExist, [Dirs[i]]);
        if i < Dirs.Count - 1 then
          Dirs[i] := Dirs[i] + ';'
      end;
      cbDirectory.Text := StringReplace(Dirs.Text, #13#10, '', [rfReplaceAll]);
    finally
      FreeAndNil(Dirs);
    end;
  end;

  SaveFormSettings;

  if cbRegEx.Checked then
  try
    ExecRegExpr(cbText.Text, '');
  except
    on E: ERegExpr do begin
      ShowError(E.Message);
      TryFocusControl(cbText);
      cbText.SelStart := E.CompilerErrorPos;
      cbText.SelLength := 0;
      Abort;
    end;
  end;

  ModalResult := mrOk;
end;

constructor TfmGrepSearch.Create(AOwner: TComponent);
begin
  inherited;
  LoadFormSettings;
end;

procedure TfmGrepSearch.SaveFormSettings;
begin
  AddMRUString(cbText.Text, FGrepExpert.SearchList, False);
  AddMRUString(cbDirectory.Text, FGrepExpert.DirList, True);
  AddMRUString(cbMasks.Text, FGrepExpert.MaskList, False);

  FGrepExpert.GrepCaseSensitive := cbCaseSensitive.Checked;
  FGrepExpert.GrepComments := not cbNoComments.Checked;
  FGrepExpert.GrepSub := cbInclude.Checked;
  FGrepExpert.GrepWholeWord := cbWholeWord.Checked;
  FGrepExpert.GrepRegEx := cbRegEx.Checked;

  if rbCurrentOnly.Checked then
    FGrepExpert.GrepSearch := 0
  else if rbOpenFiles.Checked then
    FGrepExpert.GrepSearch := 1
  else if rbDirectories.Checked then
    FGrepExpert.GrepSearch := 2
  else if rbResults.Checked then
    FGrepExpert.GrepSearch := 3;
end;

procedure TfmGrepSearch.LoadFormSettings;

  function RetrieveEditorBlockSelection: string;
  var
    Temp: string;
    i: Integer;
  begin
    Temp := GxOtaGetCurrentSelection;
    // Only use the currently selected text if the length is between 1 and 80
    if (Length(Trim(Temp)) >= 1) and (Length(Trim(Temp)) <= 80) then
    begin
      i := Min(Pos(#13, Temp), Pos(#10, Temp));
      if i > 0 then
        Temp := Copy(Temp, 1, i - 1);
      Temp := Temp;
    end else
      Temp := '';
    Result := Temp;
  end;

  procedure SetSearchPattern(Str: string);
  begin
    cbText.Text := Str;
    cbText.SelectAll;
  end;

  procedure SetDefaultSearchPattern;
  var
    Selection: string;
  begin
    Selection := RetrieveEditorBlockSelection;
    if (Trim(Selection) = '') and FGrepExpert.GrepUseCurrentIdent then
      Selection := GxOtaGetCurrentIdent;
    if (Selection = '') and (cbText.Items.Count > 0) then
      Selection := cbText.Items[0];
    SetSearchPattern(Selection);
  end;

begin
  if not Assigned(fmGrepResults) then
    raise Exception.Create(SGrepResultsNotActive);

  FGrepExpert := fmGrepResults.GrepExpert;
  cbText.Items.Assign(FGrepExpert.SearchList);
  cbDirectory.Items.Assign(FGrepExpert.DirList);
  cbMasks.Items.Assign(FGrepExpert.MaskList);
  rbResults.Enabled := fmGrepResults.lbResults.Count > 0;

  cbCaseSensitive.Checked := FGrepExpert.GrepCaseSensitive;
  cbNoComments.Checked := not FGrepExpert.GrepComments;
  cbInclude.Checked := FGrepExpert.GrepSub;
  cbWholeWord.Checked := FGrepExpert.GrepWholeWord;
  cbRegEx.Checked := FGrepExpert.GrepRegEx;
  case FGrepExpert.GrepSearch of
    0: rbCurrentOnly.Checked := True;
    1: rbOpenFiles.Checked := True;
    2: rbDirectories.Checked := True;
    3: begin
        if rbResults.Enabled then
          rbResults.Checked := True
        else
          rbDirectories.Checked := True;
      end;
  else
    rbDirectories.Checked := True;
  end;

  if cbText.Items.Count > 0 then
    cbText.Text := cbText.Items[0];
  if cbDirectory.Items.Count > 0 then
    cbDirectory.Text := cbDirectory.Items[0];
  if cbMasks.Items.Count > 0 then
    cbMasks.Text := cbMasks.Items[0];

  SetDefaultSearchPattern;
  rbCurrentOnly.Enabled := Trim(GxOtaGetFileNameOfCurrentModule) <> '';
  rbOpenFiles.Enabled := Trim(GxOtaGetOpenFilenames) <> '';
  EnableDirectoryControls(rbDirectories.Checked);
end;

procedure TfmGrepSearch.RetrieveSettings(var Value: TGrepSettings);
begin
  Value.IncludeComments := not cbNoComments.Checked;
  Value.CaseSensitive := cbCaseSensitive.Checked;
  Value.WholeWord := cbWholeWord.Checked;
  Value.RegEx := cbRegEx.Checked;
  Value.Pattern := cbText.Text;
  Value.IncludeSubdirs := cbInclude.Checked;
  Value.Mask := '';
  Value.Directories := '';

  if rbCurrentOnly.Checked then
    Value.GrepAction := gaCurrentOnlyGrep
  else if rbOpenFiles.Checked then
    Value.GrepAction := gaOpenFilesGrep
  else if rbResults.Checked then
    Value.GrepAction := gaResults
  else
  begin
    Value.GrepAction := gaDirGrep;
    Value.Mask := cbMasks.Text;
    Value.Directories := cbDirectory.Text;
  end;
end;

procedure TfmGrepSearch.FormShow(Sender: TObject);
begin
  Constraints.MaxHeight := Height;
  Constraints.MinHeight := Height;
  Constraints.MinWidth := Width;
end;

end.