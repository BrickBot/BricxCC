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
 * The Initial Developer of this code is Mark Overmars.
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit About;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows,
{$ELSE}
  LResources,
{$ENDIF}
  SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox = class(TForm)
    pnlMain: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    lblOrigAuth: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    lblAuthor: TLabel;
    lblBuild: TLabel;
    lblMaint: TLabel;
    lblMaintainer: TLabel;
    lblCopyright: TLabel;
    procedure ProgramIconClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure LoadVersionData;
  public
    { Public declarations }
  end;

implementation

uses
  PuzzleUnit, uVersionInfo, uLocalizedStrings;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TAboutBox.ProgramIconClick(Sender: TObject);
begin
  with TPuzzleForm.Create(nil) do
  try
    ShowModal();
  finally
    Free;
  end;
end;

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  LoadVersionData;
end;

procedure TAboutBox.LoadVersionData;
var
  S, tmpVer : String;
  TFS : TFileStream;
  V : TVersionInfo;
begin
  tmpVer := sVersion + ' ';
  // first get file date
  S := Application.ExeName;
  TFS := TFileStream.Create(S, fmOpenRead or fmShareDenyNone);
  try
    lblBuild.Caption := DateTimeToStr(FileDateToDateTime(FileGetDate(TFS.Handle)));
  finally
    TFS.Free;
  end;

  V := GetVersionInfo(S);
  Version.Caption      := tmpVer + V.ProductVersion;
  Version.Caption      := Version.Caption + ' (' + sBuild + ' ' + V.FileVersion + ')';
  ProductName.Caption  := V.ProductName;
  Comments.Caption     := V.Comments;
  lblCopyright.Caption := V.LegalCopyright;
end;

{$IFDEF FPC}
initialization
  {$i About.lrs}
{$ENDIF}

end.
