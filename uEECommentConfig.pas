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
unit uEECommentConfig;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
{$ENDIF}
  Classes, StdCtrls, Controls, Forms;

type
  TfrmCommentConfig = class(TForm)
    GroupBox1: TGroupBox;
    rbSlash: TRadioButton;
    btnOK: TButton;
    btnCancel: TButton;
    rbCpp: TRadioButton;
    chkInsertSpace: TCheckBox;
  end;

procedure CommentConfigure;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

uses
  SysUtils, uEditorExperts;

procedure CommentConfigure;
var
  Dlg: TfrmCommentConfig;
begin
  Dlg := TfrmCommentConfig.Create(nil);
  try
    case CommentType of
      ctSlash: Dlg.rbSlash.Checked := True;
      ctCpp: Dlg.rbCpp.Checked := True;
    end;
    Dlg.chkInsertSpace.Checked := InsertRemoveSpace;

    if Dlg.ShowModal = mrOk then
    begin
      if Dlg.rbSlash.Checked then
        CommentType := ctSlash
      else
        CommentType := ctCpp;
      InsertRemoveSpace := Dlg.chkInsertSpace.Checked;
    end;
  finally
    FreeAndNil(Dlg);
  end;
end;

{$IFDEF FPC}
initialization
  {$i uEECommentConfig.lrs}
{$ENDIF}

end.