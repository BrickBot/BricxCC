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
unit MessageUnit;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
{$ENDIF}
  Classes, Controls, Forms, ComCtrls, StdCtrls, ExtCtrls, BricxccSpin;

type
  TMessageForm = class(TForm)
    btnHelp: TButton;
    grpSingleDigit: TGroupBox;
    Button2: TButton;
    Button0: TButton;
    Button1: TButton;
    Button3: TButton;
    Button6: TButton;
    Button5: TButton;
    Button4: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    grpMultiDigit: TGroupBox;
    SendButton: TButton;
    GroupBox1: TGroupBox;
    cboMailbox: TComboBox;
    lblMailbox: TLabel;
    mmoMessage: TMemo;
    lblMemo: TLabel;
    btnSendString: TButton;
    chkBoolValue: TCheckBox;
    btnSendBool: TButton;
    btnSendNum: TButton;
    chkResponse: TCheckBox;
    edtMessageNum: TBricxccSpinEdit;
    edtNum: TBricxccSpinEdit;
    procedure Button0Click(Sender: TObject);
    procedure SendButtonClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSendNXTClick(Sender: TObject);
  private
    { Private declarations }
    function GetInBox : byte;
    function GetMessage(Sender: TObject) : string;
  public
    { Public declarations }
  end;

var
  MessageForm: TMessageForm;

implementation

uses
  SysUtils, Preferences, brick_common, uSpirit, uCommonUtils;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TMessageForm.Button0Click(Sender: TObject);
begin
  if LocalBrickType <> SU_NXT then
    BrickComm.SendMessage(TButton(Sender).Tag)
  else
    BrickComm.MessageWrite(GetInBox, GetMessage(Sender));
end;

procedure TMessageForm.SendButtonClick(Sender: TObject);
begin
  if LocalBrickType <> SU_NXT then
    BrickComm.SendMessage(edtMessageNum.Value)
  else
    BrickComm.MessageWrite(GetInBox, GetMessage(Sender));
end;

procedure TMessageForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TMessageForm.FormShow(Sender: TObject);
begin
  if LocalBrickType = SU_NXT then
  begin
    edtMessageNum.MaxLength := 0;
    edtMessageNum.MaxValue  := 0;
    Width := 304;
  end
  else
  begin
    edtMessageNum.MaxLength := 3;
    edtMessageNum.MaxValue  := 255;
    Width := 152;
  end;
end;

function TMessageForm.GetInBox: byte;
begin
  Result := cboMailbox.ItemIndex;
  if chkResponse.Checked then
    Inc(Result, 10);
end;

function TMessageForm.GetMessage(Sender: TObject): string;
var
  tag : integer;
begin
  tag := TButton(Sender).Tag;
  case tag of
    0..9 : Result := IntToStr(tag);
    100 : Result := IntToStr(edtMessageNum.Value);
    200 : Result := mmoMessage.Lines.Text;
    300 : begin
      SetLength(Result, 1);
      if chkBoolValue.Checked then
        Result := #1
      else
        Result := #0;
    end;
    400 : begin
      SetLength(Result, 4);
      tag := edtNum.Value;
      Result := Chr(Lo(Word(tag))) +
                Chr(Hi(Word(tag))) +
                Chr(Lo(HiWord(tag))) +
                Chr(Hi(HiWord(tag)));
    end;
  else
    Result := 'bad tag';
  end;
end;

procedure TMessageForm.btnSendNXTClick(Sender: TObject);
begin
  BrickComm.MessageWrite(GetInBox, GetMessage(Sender));
end;

{$IFDEF FPC}
initialization
  {$i MessageUnit.lrs}
{$ENDIF}

end.
