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
unit uFSTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FakeSpiritLib_TLB, StdCtrls, FileCtrl, Buttons;

type
  TForm1 = class(TForm)
    NXTFiles: TListBox;
    chkBluetooth: TCheckBox;
    edtComPort: TEdit;
    btnListFiles: TButton;
    btnOpen: TButton;
    sbUpload: TSpeedButton;
    sbDownload: TSpeedButton;
    lstFiles: TFileListBox;
    dlbDirectories: TDirectoryListBox;
    dcbDrives: TDriveComboBox;
    lblDir: TLabel;
    edtFile: TEdit;
    btnClose: TButton;
    edtMask: TEdit;
    btnDelete: TButton;
    edtBatteryLevel: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtFreeMem: TEdit;
    btnListModules: TButton;
    procedure sbUploadClick(Sender: TObject);
    procedure sbDownloadClick(Sender: TObject);
    procedure btnListFilesClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure NXTFilesClick(Sender: TObject);
    procedure btnListModulesClick(Sender: TObject);
  private
    { Private declarations }
    FS : IFakeSpirit;
    procedure UpdateButtonState;
    procedure GetBrickInfo;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.sbUploadClick(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to NXTFiles.Items.Count - 1 do
    if NXTFiles.Selected[i] then
      FS.NXTUploadFile(NXTFiles.Items.Names[i], lblDir.Caption);
  lstFiles.Update;
end;

function NameToNXTFileType(name : string) : integer;
var
  ext : string;
begin
  Result := anftOther;
  ext := Lowercase(ExtractFileExt(name));
  if ext = '.rso' then
    Result := anftSound
  else if ext = '.rdt' then
    Result := anftData
  else if ext = '.ric' then
    Result := anftGraphics
  else if (ext = '.rxe') or (ext = '.sys') or (ext = '.rtm') then
    Result := anftProgram
end;

procedure TForm1.sbDownloadClick(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to lstFiles.Items.Count - 1 do
    if lstFiles.Selected[i] then
      FS.NXTDownloadFile(lstFiles.Items[i], NameToNXTFileType(lstFiles.Items[i]));
  btnListFilesClick(Sender);
end;

procedure TForm1.btnListFilesClick(Sender: TObject);
var
  tmpStr : widestring;
begin
  FS.NXTListFiles(edtMask.Text, tmpStr);
  NXTFiles.Items.Text := tmpStr;
end;

procedure TForm1.btnOpenClick(Sender: TObject);
begin
  FS.BrickType := 6;
  FS.UseBluetooth := chkBluetooth.Checked;
  FS.Port      := edtComPort.Text;
  FS.Open;
  if FS.IsOpen then
    GetBrickInfo;
  UpdateButtonState;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FS := CoFakeSpirit.Create;

end;

procedure TForm1.btnCloseClick(Sender: TObject);
begin
  FS.Close;
  UpdateButtonState;
end;

procedure TForm1.btnDeleteClick(Sender: TObject);
var
  i : integer;
  filename : widestring;
begin
  if FS.IsOpen then
    if (MessageDlg('Delete all the selected files?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      for i := 0 to NXTFiles.Items.Count - 1 do
        if NXTFiles.Selected[i] then
        begin
          filename := NXTFiles.Items.Names[i];
          FS.NXTDeleteFile(filename, False);
        end;
      btnListFilesClick(Sender);
    end;
end;

procedure TForm1.UpdateButtonState;
begin
  btnOpen.Enabled  := not FS.IsOpen;
  btnClose.Enabled := FS.IsOpen;
  btnListFiles.Enabled := btnClose.Enabled;
  sbUpload.Enabled     := btnClose.Enabled;
  sbDownload.Enabled   := btnClose.Enabled;
  btnDelete.Enabled    := btnClose.Enabled and (NXTFiles.SelCount > 0);
end;

procedure TForm1.NXTFilesClick(Sender: TObject);
begin
  UpdateButtonState;
end;

procedure TForm1.GetBrickInfo;
var
  name : widestring;
  b1, b2 : byte;
  memfree : cardinal;
  blevel : integer;
begin
  blevel := FS.BatteryLevel;
  edtBatteryLevel.Text := Format('%f', [blevel / 1000.0]);
{
// this is not working for some reason
  FS.NXTGetDeviceInfo(name, b1, b2, memfree);
  edtBrickName.Text := name;
  edtFreeMem.Text := IntToStr(memfree);
}
end;

procedure TForm1.btnListModulesClick(Sender: TObject);
var
  tmpStr : widestring;
begin
  FS.NXTListModules(edtMask.Text, tmpStr);
  NXTFiles.Items.Text := tmpStr;
end;

end.
