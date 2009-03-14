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
unit uPortPrompt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmPortPrompt = class(TForm)
    lblPort: TLabel;
    chkUseBluetooth: TCheckBox;
    btnOK: TButton;
    btnCancel: TButton;
    cboPort: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    function GetPort: string;
    function GetUseBT: Boolean;
    { Private declarations }
  public
    { Public declarations }
    property Port : string read GetPort;
    property UseBT : Boolean read GetUseBT;
  end;

var
  frmPortPrompt: TfrmPortPrompt;

implementation

{$R *.dfm}

uses
  brick_common, uSpirit, uGuiUtils;

{ TfrmPortPrompt }

function TfrmPortPrompt.GetPort: string;
begin
  Result := cboPort.Text;
end;

function TfrmPortPrompt.GetUseBT: Boolean;
begin
  Result := chkUseBluetooth.Checked;
end;

procedure TfrmPortPrompt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
  begin
    chkUseBluetooth.Checked := False;
    cboPort.Text := 'usb';
  end;
end;

procedure TfrmPortPrompt.FormCreate(Sender: TObject);
begin
  if not FileExists(GetInitFilename) then
    CreateInitFile;
  cboPort.Items.Add('usb');
  LoadNXTPorts(cboPort.Items);
  SizeComboboxDropdown(cboPort);
  cboPort.Text := 'usb';
end;

end.
