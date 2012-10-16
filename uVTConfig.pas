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
 * Portions created by John Hansen are Copyright (C) 2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uVTConfig;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
  LCLIntf,
{$ENDIF}
  Classes, Controls, Forms, StdCtrls, BricxccSpin;

type
  TfrmVTConfig = class(TForm)
    lstValueTypes: TListBox;
    Label1: TLabel;
    grpVTDef: TGroupBox;
    lblVTName: TLabel;
    edtName: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    edtIRxCount: TBricxccSpinEdit;
    lblRxCount: TLabel;
    cboValueType: TComboBox;
    lblValue: TLabel;
    edtSend: TMemo;
    lblSend: TLabel;
    edtAddress: TEdit;
    lblAddress: TLabel;
    edtScript: TMemo;
    lblScript: TLabel;
    btnAdd: TButton;
    btnRemove: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure edtAddressKeyPress(Sender: TObject; var Key: Char);
    procedure edtSendKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TfrmVTConfig.btnOKClick(Sender: TObject);
begin
//
end;

procedure TfrmVTConfig.edtAddressKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['a'..'f'] then
    Key := Char(Ord(Key) - 32);
  if not (Key in [#8, '0'..'9', 'A'..'F']) then
    Key := #0;
end;

procedure TfrmVTConfig.edtSendKeyPress(Sender: TObject; var Key: Char);
begin
  // hex digits, space, comma, and <CR>
  if Key in ['a'..'f'] then
    Key := Char(Ord(Key) - 32);
  if not (Key in [#8, #13, ' ', ',', '0'..'9', 'A'..'F']) then
    Key := #0;
end;

procedure TfrmVTConfig.btnAddClick(Sender: TObject);
begin
//
end;

procedure TfrmVTConfig.btnRemoveClick(Sender: TObject);
begin
//
end;

initialization
{$IFDEF FPC}
  {$i uVTConfig.lrs}
{$ENDIF}

end.
