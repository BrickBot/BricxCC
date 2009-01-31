unit umidibatchlaz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, ComCtrls, Buttons, uMidi2MS, Menus;

type

  { TfrmMidiBatch }

  TfrmMidiBatch = class(TForm)
    btnAdd: TButton;
    btnDelete: TButton;
    btnClear: TButton;
    btnExecute: TButton;
    chkUsePB: TCheckBox;
    edtDir: TEdit;
    edtOutputDir: TEdit;
    grpTracks: TGroupBox;
    grpParameters: TGroupBox;
    grpTempo: TGroupBox;
    lblGap: TLabel;
    lblTranspose: TLabel;
    lblPBS: TLabel;
    lblInputDirs: TLabel;
    lblOutDir: TLabel;
    lstDirs: TListBox;
    mniDelete: TMenuItem;
    mniClear: TMenuItem;
    mniSep1: TMenuItem;
    mniAdd: TMenuItem;
    mmoLog: TMemo;
    pumDirs: TPopupMenu;
    radAllTracks: TRadioButton;
    radFirstTrack: TRadioButton;
    edtTempo: TSpinEdit;
    edtGap: TSpinEdit;
    edtPBS: TSpinEdit;
    barTranspose: TTrackBar;
    dlgSelectDirectory: TSelectDirectoryDialog;
    btnSelectDir: TSpeedButton;
    procedure btnExecuteClick(Sender: TObject);
    procedure btnSelectDirClick(Sender: TObject);
    procedure chkUsePBClick(Sender: TObject);
    procedure edtDirChange(Sender: TObject);
    procedure edtOutputDirChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mniAddClick(Sender: TObject);
    procedure mniClearClick(Sender: TObject);
    procedure mniDeleteClick(Sender: TObject);
    procedure pumDirsPopup(Sender: TObject);
  private
    { private declarations }
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
    { public declarations }
  end; 

var
  frmMidiBatch: TfrmMidiBatch;

implementation

uses
  uCommonUtils;

{ TfrmMidiBatch }

procedure TfrmMidiBatch.btnExecuteClick(Sender: TObject);
var
  i : integer;
begin
  mmoLog.Clear;
  for i := 0 to lstDirs.Items.Count  - 1 do
  begin
    ConvertMIDIFilesInDir(lstDirs.Items[i]);
  end;
end;

procedure TfrmMidiBatch.btnSelectDirClick(Sender: TObject);
begin
  if dlgSelectDirectory.Execute then
    edtOutputDir.Text := dlgSelectDirectory.FileName;
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

initialization
  {$I umidibatchlaz.lrs}

end.

