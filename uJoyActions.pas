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
unit uJoyActions;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
  LCLType,
{$ENDIF}
  Classes, Controls, Forms, StdCtrls, uJoyGlobals;

type
  TfrmJoyActions = class(TForm)
    grpChangeActions: TGroupBox;
    btnOK: TButton;
    btnCancel: TButton;
    radCADefault: TRadioButton;
    radCAScript: TRadioButton;
    radCAMessage: TRadioButton;
    lblMailbox: TLabel;
    cboMailbox: TComboBox;
    procedure ActionsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function GetCA: TMotorChangedAction;
    function GetInbox: integer;
    procedure SetCA(const Value: TMotorChangedAction);
    procedure SetInbox(const Value: integer);
    { Private declarations }
  public
    { Public declarations }
    property ChangeAction : TMotorChangedAction read GetCA write SetCA;
    property Inbox : integer read GetInbox write SetInbox;
  end;

var
  frmJoyActions: TfrmJoyActions;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

{ TfrmJoyActions }

function TfrmJoyActions.GetCA: TMotorChangedAction;
begin
  if radCADefault.Checked then
    Result := mcaDefault
  else if radCAScript.Checked then
    Result := mcaScript
  else
    Result := mcaMessage;
end;

function TfrmJoyActions.GetInbox: integer;
begin
  Result := cboMailbox.ItemIndex;
end;

procedure TfrmJoyActions.SetCA(const Value: TMotorChangedAction);
begin
  case Value of
    mcaDefault : radCADefault.Checked := True;
    mcaScript  : radCAScript.Checked  := True;
  else
    radCAMessage.Checked := True;
  end;
end;

procedure TfrmJoyActions.SetInbox(const Value: integer);
begin
  cboMailbox.ItemIndex := Value;
end;

procedure TfrmJoyActions.ActionsClick(Sender: TObject);
begin
  cboMailbox.Enabled := radCAMessage.Checked;
end;

procedure TfrmJoyActions.FormCreate(Sender: TObject);
begin
  ActionsClick(Sender);
end;

{$IFDEF FPC}
initialization
  {$i uJoyActions.lrs}
{$ENDIF}

end.
