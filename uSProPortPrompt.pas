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
 * Portions created by John Hansen are Copyright (C) 2011 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uSProPortPrompt;

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
  SysUtils, Classes, Controls, Forms, StdCtrls;

type
  TfrmSProPortPrompt = class(TForm)
    lblPort: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    cboPort: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function GetPort: string;
  public
    { Public declarations }
    property Port : string read GetPort;
  end;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

uses
  brick_common, uSpirit;

{ TfrmPortPrompt }

function TfrmSProPortPrompt.GetPort: string;
begin
  Result := cboPort.Text;
end;

procedure TfrmSProPortPrompt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
  begin
    cboPort.Text := 'usb';
  end;
end;

procedure TfrmSProPortPrompt.FormCreate(Sender: TObject);
var
  i : integer;
begin
  cboPort.Items.Clear;
  for i := 1 to 8 do
    cboPort.Items.Add('COM'+IntToStr(i));
  cboPort.Text := 'COM1';
end;

{$IFDEF FPC}
initialization
  {$i uSProPortPrompt.lrs}
{$ENDIF}

end.
