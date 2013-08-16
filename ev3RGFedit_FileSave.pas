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
unit ev3RGFedit_FileSave;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, Controls, Forms, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  Dialogs, BricxccSpin;

type
  TfrmFileSave = class(TForm)
    BitBtn_Abort: TBitBtn;
    BitBtn_Save: TBitBtn;
    Edit_Filename: TEdit;
    Label_Filename: TLabel;
    Label_InfoImageWidth: TLabel;
    Label_InfoImageHeight: TLabel;
    Label_ImageWidth: TLabel;
    Label_ImageHeight: TLabel;
    GroupBox_Borders: TGroupBox;
    Label_FillBorder: TLabel;
    RadioButton_Dark: TRadioButton;
    RadioButton_Bright: TRadioButton;
    dlgSave: TSaveDialog;
    SpinEdit_BorderTop: TBricxccSpinEdit;
    SpinEdit_BorderLeft: TBricxccSpinEdit;
    SpinEdit_BorderRight: TBricxccSpinEdit;
    SpinEdit_BorderBottom: TBricxccSpinEdit;
    procedure BitBtn_SaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    basepath  : String;
    imagename : String;
  public
    filename      : String;
    image_width   : Integer;
    image_height  : Integer;
    border_left   : Integer;
    border_right  : Integer;
    border_top    : Integer;
    border_bottom : integer;
    fill_dark     : Boolean;
    convert_to_ric : Boolean;
  end;

var
  frmFileSave: TfrmFileSave;

implementation

{$R *.dfm}

uses
  SysUtils;

procedure TfrmFileSave.BitBtn_SaveClick(Sender: TObject);
begin
  dlgSave.FileName := Edit_Filename.Text;
  if dlgSave.Execute then
  begin
    Edit_Filename.Text := dlgSave.FileName;
    border_left    := SpinEdit_BorderLeft.Value;
    border_right   := SpinEdit_BorderRight.Value;
    border_top     := SpinEdit_BorderTop.Value;
    border_bottom  := SpinEdit_BorderBottom.Value;
    fill_dark      := RadioButton_Dark.Checked;
    filename       := Edit_Filename.Text;
    convert_to_ric := dlgSave.FilterIndex = 2;
    ModalResult    := mrOK;
  end;
end;

//------------------------------------------------------------------------------

procedure TfrmFileSave.FormShow(Sender: TObject);
begin
  Label_ImageWidth.Caption  := IntToStr( image_width )+' Pixels';
  Label_ImageHeight.Caption := IntToStr( image_height )+' Pixels';

  basepath  := ExtractFilePath( filename );
  imagename := ExtractFileName( filename );

  Edit_Filename.Text := basepath+imagename;
  dlgSave.InitialDir := basepath;
  dlgSave.FilterIndex := 1;
end;

end.
