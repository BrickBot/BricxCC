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
unit uRICView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmRICView = class(TForm)
    grpPreview: TGroupBox;
    grpAsText: TGroupBox;
    mmoText: TMemo;
    pnlImage: TPanel;
    imgRIC: TImage;
    pnlBottom: TPanel;
    btnCompile: TButton;
    dlgSave: TSaveDialog;
    procedure btnCompileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRICView: TfrmRICView;

implementation

{$R *.dfm}

uses
  uRICComp;

procedure TfrmRICView.btnCompileClick(Sender: TObject);
var
  RC : TRICComp;
begin
  if dlgSave.Execute then
  begin
    RC := TRICComp.Create;
    try
      RC.AsText := mmoText.Lines.Text;
      RC.SaveToFile(dlgSave.FileName);
    finally
      RC.Free;
    end;
  end;
end;

end.