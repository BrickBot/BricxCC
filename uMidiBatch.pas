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
unit uMidiBatch;

interface

uses
  Classes, Controls, Forms, StdCtrls, Menus, ComCtrls, uSpin,
  uOfficeComp, uMidi2MS;

type
  TfrmMidiBatch = class(TForm)
    lblInputDirs: TLabel;
    lstDirs: TListBox;
    btnExecute: TButton;
    edtDir: TEdit;
    mmoLog: TMemo;
    lblOutputDir: TLabel;
    edtOutputDir: TEdit;
    btnAdd: TButton;
    btnDelete: TButton;
    btnClear: TButton;
    grpTracks: TGroupBox;
    radAllTracks: TRadioButton;
    radFirstTrack: TRadioButton;
    grpTempo: TGroupBox;
    grpParameters: TGroupBox;
    lblGap: TLabel;
    lblTranspose: TLabel;
    lblPBS: TLabel;
    barTranspose: TTrackBar;
    chkUsePB: TCheckBox;
    edtGap: TSpinEdit;
    edtPBS: TSpinEdit;
    edtTempo: TSpinEdit;
    procedure btnExecuteClick(Sender: TObject);
    procedure edtOutputDirChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtDirChange(Sender: TObject);
    procedure chkUsePBClick(Sender: TObject);
  private
    pumDirs: TOfficePopupMenu;
    mniAdd: TOfficeMenuItem;
    mniDelete: TOfficeMenuItem;
    mniSep1: TOfficeMenuItem;
    mniClear: TOfficeMenuItem;
    procedure pumDirsPopup(Sender: TObject);
    procedure mniClearClick(Sender: TObject);
    procedure mniDeleteClick(Sender: TObject);
    procedure mniAddClick(Sender: TObject);
    procedure CreatePopupMenu;
    function GetOutputDir: string;
    procedure HandleConversionError(const trk: integer;
      const filename: string);
  private
    { Private declarations }
    procedure ConvertMIDIFilesInDir(const dir : string);
    procedure ConvertOneFile(const filename : string; const outputdir : string);
    procedure UpdateButtonState;
    property OutputDir : string read GetOutputDir;
  public
    { Public declarations }
  end;

var
  frmMidiBatch: TfrmMidiBatch;

implementation

{$R *.dfm}

uses
  uCommonUtils;

{ TfrmMidiBatch }

procedure TfrmMidiBatch.btnExecuteClick(Sender: TObject);
var
  i : integer;
begin
  mmoLog.Clear;
  for i := 0 to lstDirs.Items.Count - 1 do
  begin
    ConvertMIDIFilesInDir(lstDirs.Items[i]);
  end;
end;

procedure TfrmMidiBatch.ConvertMIDIFilesInDir(const dir: string);
var
  List : TStringList;
  i : integer;
begin
  // process any .MID files at this directory level and any below this level
  // (recursively)
  List := TStringList.Create;
  try
    GetFileList(dir, '*.mid', List);
    for i := 0 to List.Count - 1 do
    begin
      // convert each file
      ConvertOneFile(dir + List[i], OutputDir);
    end;
    // now recurse into any subdirectories
    List.Clear;
    GetSubDirectories(dir, List);
    for i := 0 to List.Count - 1 do
      ConvertMIDIFilesInDir(IncludeTrailingPathDelimiter(dir + List[i]));
  finally
    List.Free;
  end;
end;

procedure TfrmMidiBatch.edtOutputDirChange(Sender: TObject);
begin
  UpdateButtonState;
end;

procedure TfrmMidiBatch.mniClearClick(Sender: TObject);
begin
  lstDirs.Clear;
  UpdateButtonState;
end;

procedure LBDeleteSelected(lb : TCustomListBox);
var
  I: Integer;
begin
  if lb.MultiSelect then
  begin
    for I := lb.Items.Count - 1 downto 0 do
      if lb.Selected[I] then
        lb.Items.Delete(I);
  end
  else
    if lb.ItemIndex <> -1 then
      lb.Items.Delete(lb.ItemIndex);
end;

procedure TfrmMidiBatch.mniDeleteClick(Sender: TObject);
begin
  LBDeleteSelected(lstDirs);
  UpdateButtonState;
end;

procedure TfrmMidiBatch.mniAddClick(Sender: TObject);
begin
  if lstDirs.Items.IndexOf(edtDir.Text) = -1 then
    lstDirs.Items.Add(IncludeTrailingPathDelimiter(edtDir.Text));
  UpdateButtonState;
end;

procedure TfrmMidiBatch.UpdateButtonState;
begin
  btnExecute.Enabled := (lstDirs.Items.Count > 0) and (OutputDir <> '') and DirectoryExists(OutputDir);
  mniAdd.Enabled     := (Trim(edtDir.Text) <> '') and DirectoryExists(edtDir.Text);
  mniDelete.Enabled  := lstDirs.ItemIndex <> -1;
  mniClear.Enabled   := lstDirs.Items.Count > 0;
  btnAdd.Enabled     := mniAdd.Enabled;
  btnDelete.Enabled  := mniDelete.Enabled;
  btnClear.Enabled   := mniClear.Enabled;
end;

function TfrmMidiBatch.GetOutputDir: string;
begin
  Result := edtOutputDir.Text;
  if Result <> '' then
    Result := IncludeTrailingPathDelimiter(Result);
end;

function ExtractFilePathNoDrive(const FileName: string): string;
begin
  Result := ExtractFilePath(FileName);
  Delete(Result, 1, Length(ExtractFileDrive(FileName)));
end;

procedure TfrmMidiBatch.HandleConversionError(const trk : integer; const filename : string);
begin
  mmoLog.Lines.Add(Format('Error converting track %d of %s', [trk, filename]));
  Application.ProcessMessages;
end;

procedure TfrmMidiBatch.ConvertOneFile(const filename, outputdir: string);
var
  tc, i : integer;
  C : TMIDIFileToRCX;
  outputFilename : string;
  curTempo : Double;
begin
  // count the number of tracks
  tc := TrackCount(filename);
  // log
  mmoLog.Lines.Add(Format('Converting %d tracks of "%s"', [tc, filename]));
  Application.ProcessMessages;
  curTempo := edtTempo.Value;
  for i := 0 to tc - 1 do
  begin
    outputFilename := ExcludeTrailingPathDelimiter(outputdir) +
      ExtractFilePathNoDrive(filename) +
        ChangeFileExt(ExtractFilename(filename), '') +
          Format('_%3.3d.rmd', [i]);
    if ForceDirectories(ExtractFileDir(outputFilename)) then
    begin
      if FileExists(outputFilename) then
        DeleteFile(outputFilename);
      C := TMIDIFileToRCX.Create;
      try
        C.Track          := i;
        C.Tempo          := curTempo;
        C.Gap            := edtGap.Value;
        C.PBS            := edtPBS.Value;
        C.ConversionType := mctNXTMelody;
        C.PitchBend      := chkUsePB.Checked;
        C.Transpose      := barTranspose.Position;
        try
          C.Convert(filename, outputFilename);
        except
          on EInvalidSMFFormat do
          begin
            // if the format is not valid then delete it
            DeleteFile(filename);
            HandleConversionError(i, filename);
            Break;
          end
        else
          HandleConversionError(i, filename);
        end;
        curTempo := C.CurrentTempo;
      finally
        C.Free;
      end;
    end;
    if FileExists(outputFilename) and radFirstTrack.Checked then
      Break;
  end;
end;

procedure TfrmMidiBatch.FormCreate(Sender: TObject);
begin
  CreatePopupMenu;
  lstDirs.PopupMenu := pumDirs;
  UpdateButtonState;
end;

procedure TfrmMidiBatch.pumDirsPopup(Sender: TObject);
begin
  UpdateButtonState;
end;

procedure TfrmMidiBatch.edtDirChange(Sender: TObject);
begin
  UpdateButtonState;
end;

procedure TfrmMidiBatch.chkUsePBClick(Sender: TObject);
begin
  edtPBS.Enabled := chkUsePB.Checked;
end;

procedure TfrmMidiBatch.CreatePopupMenu;
begin
  pumDirs := TOfficePopupMenu.Create(Self);
  mniAdd := TOfficeMenuItem.Create(Self);
  mniDelete := TOfficeMenuItem.Create(Self);
  mniSep1 := TOfficeMenuItem.Create(Self);
  mniClear := TOfficeMenuItem.Create(Self);
  with pumDirs do
  begin
    Name := 'pumDirs';
    OnPopup := pumDirsPopup;
  end;
  with mniAdd do
  begin
    Name := 'mniAdd';
    Caption := 'Add';
    OnClick := mniAddClick;
  end;
  with mniDelete do
  begin
    Name := 'mniDelete';
    Caption := 'Delete';
    OnClick := mniDeleteClick;
  end;
  with mniSep1 do
  begin
    Name := 'mniSep1';
    Caption := '-';
  end;
  with mniClear do
  begin
    Name := 'mniClear';
    Caption := 'Clear';
    OnClick := mniClearClick;
  end;
end;

end.
