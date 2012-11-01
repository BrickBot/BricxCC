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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uNXTImagePrefs;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  DirectoryEdit,  
{$ELSE}
  LResources,
  EditBtn,
  ColorBox,
{$ENDIF}
  Classes, Controls, Graphics, Forms, StdCtrls, BricxccSpin, ExtCtrls;

type
  TfrmNXTImagePrefs = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    lblBackgroundColor: TLabel;
    cbxBackgroundColor: TColorBox;
    edtBaseFilename: TEdit;
    lblBaseFilename: TLabel;
    lblNQCPath: TLabel;
    edtDefaultDir2: TEdit;
    grpAutoFilenames: TGroupBox;
    rbUseIndex: TRadioButton;
    rbUseTimestamp: TRadioButton;
    edtCurrentIndex: TBricxccSpinEdit;
    lblCurrentIndex: TLabel;
    cboImageTypes: TComboBox;
    lblImageTypes: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure rbUseIndexClick(Sender: TObject);
  private
    { Private declarations }
    edtDefaultDir: TDirectoryEdit;
    procedure CreateDirectoryEdits;
    function GetBackColor: TColor;
    function GetBaseFilename: string;
    function GetCurrentIndex: integer;
    function GetImageDir: string;
    function GetImageExt: string;
    function GetUseIndex: boolean;
    procedure SetBackColor(const aValue: TColor);
    procedure SetBaseFilename(const aValue: string);
    procedure SetCurrentIndex(const aValue: integer);
    procedure SetImageDir(const aValue: string);
    procedure SetImageExt(const aValue: string);
    procedure SetUseIndex(const aValue: boolean);
  public
    { Public declarations }
    property BackgroundColor : TColor read GetBackColor write SetBackColor;
    property BaseFilename : string read GetBaseFilename write SetBaseFilename;
    property ImageDirectory : string read GetImageDir write SetImageDir;
    property ImageExt : string read GetImageExt write SetImageExt;
    property UseIndex : boolean read GetUseIndex write SetUseIndex;
    property CurrentIndex : integer read GetCurrentIndex write SetCurrentIndex;
  end;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

uses
  SysUtils, uGuiUtils;

const
  ImageTypeExt : array[0..3] of string =
    ('.jpg',
     '.png',
     '.bmp',
{$IFDEF FPC}
     '.xpm');
{$ELSE}
     '.gif');
{$ENDIF}

function ExtToIndex(const aExt : string) : integer;
var
  i : integer;
begin
  // default is PNG if invalid index is passed into this function
  Result := 1;
  for i := Low(ImageTypeExt) to High(ImageTypeExt) do
  begin
    if ImageTypeExt[i] = LowerCase(aExt) then
    begin
      Result := i;
      break;
    end;
  end;
end;

{ TfrmNXTImagePrefs }

procedure TfrmNXTImagePrefs.CreateDirectoryEdits;
begin
  edtDefaultDir  := TDirectoryEdit.Create(Self);
  CloneDE(edtDefaultDir, edtDefaultDir2);
end;

procedure TfrmNXTImagePrefs.FormCreate(Sender: TObject);
begin
  CreateDirectoryEdits;
{$IFDEF FPC}
  cboImageTypes.Items.Add('XPM');
{$ELSE}
  cboImageTypes.Items.Add('GIF');
{$ENDIF}
end;

function TfrmNXTImagePrefs.GetBackColor: TColor;
begin
  Result := cbxBackgroundColor.Selected;
end;

function TfrmNXTImagePrefs.GetBaseFilename: string;
begin
  Result := edtBaseFilename.Text;
end;

function TfrmNXTImagePrefs.GetCurrentIndex: integer;
begin
  Result := edtCurrentIndex.Value;
end;

function TfrmNXTImagePrefs.GetImageDir: string;
begin
  Result := IncludeTrailingPathDelimiter(edtDefaultDir.Text);
end;

function TfrmNXTImagePrefs.GetImageExt: string;
begin
  Result := ImageTypeExt[cboImageTypes.ItemIndex];
end;

function TfrmNXTImagePrefs.GetUseIndex: boolean;
begin
  Result := rbUseIndex.Checked;
end;

procedure TfrmNXTImagePrefs.rbUseIndexClick(Sender: TObject);
begin
  edtCurrentIndex.Enabled := rbUseIndex.Checked;
end;

procedure TfrmNXTImagePrefs.SetBackColor(const aValue: TColor);
begin
  cbxBackgroundColor.Selected := aValue;
end;

procedure TfrmNXTImagePrefs.SetBaseFilename(const aValue: string);
begin
  edtBaseFilename.Text := aValue;
end;

procedure TfrmNXTImagePrefs.SetCurrentIndex(const aValue: integer);
begin
  edtCurrentIndex.Value := aValue;
end;

procedure TfrmNXTImagePrefs.SetImageDir(const aValue: string);
begin
  edtDefaultDir.Text := aValue;
end;

procedure TfrmNXTImagePrefs.SetImageExt(const aValue: string);
begin
  cboImageTypes.ItemIndex := ExtToIndex(aValue);
end;

procedure TfrmNXTImagePrefs.SetUseIndex(const aValue: boolean);
begin
  if aValue then
    rbUseIndex.Checked := True
  else
    rbUseTimestamp.Checked := True;
end;

{$IFDEF FPC}
initialization
  {$i uNXTImagePrefs.lrs}
{$ENDIF}

end.