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
 * The Initial Developer of this code is Andreas Dreier.
 *
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit ev3RGFEdit_FileOpen;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, Controls, Forms, Graphics, ComCtrls, ExtCtrls,
  StdCtrls, Buttons, Dialogs;

type

  { TfrmFileOpen }

  TfrmFileOpen = class(TForm)
    btnAbort: TBitBtn;
    btnLoad: TBitBtn;
    Label_ImageWidth: TLabel;
    Label_ImageHeight: TLabel;
    Label_InfoImageHeight: TLabel;
    Label_InfoImageWidth: TLabel;
    Label_Preview: TLabel;
    Image_Preview: TImage;
    Bevel1: TBevel;
    dlgOpen: TOpenDialog;
    Label1: TLabel;
    Label_Filename: TLabel;
    btnBrowse: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
  private
    procedure PreviewImage( filename : String );
    procedure Preview;
  public
    filename : String;
  end;

var
  frmFileOpen: TfrmFileOpen;

implementation

{$R *.dfm}

uses
  SysUtils, ev3RGFedit_Basis;

procedure TfrmFileOpen.PreviewImage( filename : String );
var
  image_width  : Integer;
  image_height : Integer;
begin
  Label_Filename.Caption := '';
  Label_ImageWidth.Caption  := '';
  Label_ImageHeight.Caption := '';

  with Image_Preview, Image_Preview.Canvas do
  begin
    Brush.Color := clBtnFace;
    Pen.Color   := clBtnFace;
    Image_Preview.Canvas.FillRect( Rect( 0, 0, Width, Height ) );
  end;

  if filename <> '' then
  begin
    if LoadImage(filename, Image_preview,
                 image_width, image_height, clBlack, clWhite ) then
    begin
      Label_ImageWidth.Caption  := IntToStr( image_width  )+' pixels';
      Label_ImageHeight.Caption := IntToStr( image_height )+' pixels';
      Label_Filename.Caption    := ExtractFilename(filename);
    end;
  end
  else
  begin
    ImageClear(Image_preview);
  end;
end;

procedure TfrmFileOpen.Preview;
var
  filename, ext : string;
begin
  filename := dlgOpen.FileName;
  ext := UpperCase(ExtractFileExt(filename));
  if (ext = '.RGF') or (ext = '.RIC') then
    PreviewImage( filename )
  else
    PreviewImage( '' );
end;

procedure TfrmFileOpen.FormShow(Sender: TObject);
begin
  btnLoad.Enabled := False;
  if base_path <> '' then
    dlgOpen.InitialDir := base_path;
  PreviewImage( '' );
end;

procedure TfrmFileOpen.btnLoadClick(Sender: TObject);
begin
  filename    := dlgOpen.FileName;
  ModalResult := mrOK;
end;

procedure TfrmFileOpen.btnBrowseClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
    Preview;
    btnLoad.Enabled := true;
  end;
end;

end.
