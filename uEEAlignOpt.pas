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
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uEEAlignOpt;

interface

uses
  Classes, Controls, StdCtrls, Forms, Menus;

type
  TfmAlign = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    lstTokens: TListBox;
    lblToken: TLabel;
    cbxMode: TComboBox;
    pmuTokens: TPopupMenu;
    mitConfiguration: TMenuItem;
    procedure lstTokensDblClick(Sender: TObject);
    procedure mitConfigurationClick(Sender: TObject);
  end;

implementation

{$R *.dfm}

uses
  SysUtils, uEEAlignConfig, uEditorExperts;

procedure TfmAlign.lstTokensDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfmAlign.mitConfigurationClick(Sender: TObject);
var
  Dialog : TfrmAlignOptions;
  oldSel : string;
begin
  Dialog := TfrmAlignOptions.Create(nil);
  try
    Dialog.mmoTokens.Lines.CommaText := AlignTokenList;
    Dialog.edtWhitespace.Value       := AlignMinWhitespace;
    if Dialog.ShowModal = mrOK then
    begin
      AlignTokenList     := Dialog.mmoTokens.Lines.CommaText;
      AlignMinWhitespace := Dialog.edtWhitespace.Value;
      if lstTokens.ItemIndex <> -1 then
        oldSel := lstTokens.Items[lstTokens.ItemIndex]
      else
        oldSel := '';
      lstTokens.Items.CommaText := AlignTokenList;
      lstTokens.ItemIndex := lstTokens.Items.IndexOf(oldSel);
    end;
  finally
    FreeAndNil(Dialog);
  end;
end;

end.

