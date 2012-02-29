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
 * Copyright (C) 2011 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uSimpleTerm;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows,
{$ELSE}
  LResources,
  LMessages,
  LCLType,
  LCLIntf,
{$ENDIF}
  Messages, SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls, uSpirit,
  Menus, uOfficeComp, StdActns, ActnList;

type
  TfrmSimpleTerm = class(TForm)
    mmoTerm: TMemo;
    tmrPoll: TTimer;
    alSimpleTerm: TActionList;
    actEditCut1: TEditCut;
    actEditCopy1: TEditCopy;
    actEditPaste1: TEditPaste;
    actEditDelete1: TEditDelete;
    actEditSelectAll1: TEditSelectAll;
    actPolling: TAction;
    actLabelLines: TAction;
    actEchoSends: TAction;
    procedure mmoTermKeyPress(Sender: TObject; var Key: Char);
//    procedure mmoTermKeyDown(Sender: TObject; var Key: Word;
//      Shift: TShiftState);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrPollTimer(Sender: TObject);
    procedure actLabelLinesExecute(Sender: TObject);
    procedure actPollingExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure alSimpleTermUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure actEchoSendsExecute(Sender: TObject);
  private
    { Private declarations }
    mnuMain: TOfficeMainMenu;
    mniEdit: TOfficeMenuItem;
    mniPreferences: TOfficeMenuItem;
    Cut1: TOfficeMenuItem;
    Copy1: TOfficeMenuItem;
    Paste1: TOfficeMenuItem;
    Delete1: TOfficeMenuItem;
    SelectAll1: TOfficeMenuItem;
    Polling1: TOfficeMenuItem;
    LabelLines1: TOfficeMenuItem;
    EchoSends1: TOfficeMenuItem;
    fOldDataSending : TDataSendReceiveEvent;
    fOldDataReceiving : TDataSendReceiveEvent;
    procedure HandleDataSendingAndReceiving(Sender : TObject; const Sending : boolean; const Data : array of byte);
    procedure CreateMenus;
  public
    { Public declarations }
  end;

var
  frmSimpleTerm: TfrmSimpleTerm;

implementation

{$R *.dfm}

uses
  brick_common, uSimpleTerminalGlobals;

procedure TfrmSimpleTerm.mmoTermKeyPress(Sender: TObject; var Key: Char);
var
  Data : array of byte;
begin
  if BrickComm.IsOpen then
  begin
    SetLength(Data, 1);
    Data[0] := Byte(Key);
    BrickComm.SendRawData(Data);
    BrickComm.FlushReceiveBuffer;
{
    if Key in [' '..'~'] then
      mmoTerm.Lines.Text := mmoTerm.Lines.Text + Key
    else if Key = #13 then
      mmoTerm.Lines.Add('');
}
  end;
  mmoTerm.SelStart := Length(mmoTerm.Lines.Text);
  Key := #0;
end;

(*
procedure TfrmSimpleTerm.mmoTermKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Data : array of byte;
begin
  if BrickComm.IsOpen then
  begin
    if (Key in [Ord('A')..Ord('Z')]) and ([ssCtrl] = Shift) then
    begin
      SetLength(Data, 1);
      Data[0] := Key-$40;
      BrickComm.SendRawData(Data);
      BrickComm.FlushReceiveBuffer;
//      mmoTerm.Lines.Text := mmoTerm.Lines.Text + '<Ctrl+' + Chr(Key) + '>';
      Key := 0;
    end;
  end;
end;
*)

procedure TfrmSimpleTerm.FormHide(Sender: TObject);
begin
  tmrPoll.Enabled := False;
  BrickComm.OnDataSending := fOldDataSending;
  BrickComm.OnDataReceiving := fOldDataReceiving;
end;

procedure TfrmSimpleTerm.FormShow(Sender: TObject);
begin
  tmrPoll.Enabled := True;
  fOldDataSending := BrickComm.OnDataSending;
  fOldDataReceiving := BrickComm.OnDataReceiving;
  BrickComm.OnDataSending := HandleDataSendingAndReceiving;
  BrickComm.OnDataReceiving := HandleDataSendingAndReceiving;
end;

procedure TfrmSimpleTerm.HandleDataSendingAndReceiving(Sender: TObject;
  const Sending: boolean; const Data: array of byte);
var
  tmp : string;
//  line : string;
  i : integer;
begin
  if Sending and not SimpleTermEchoSends then Exit;
  if Length(Data) = 0 then Exit;
  if Sending then
    tmp := 'S: '
  else
    tmp := 'R: ';

  if not SimpleTermLabelLines then
    tmp := '';

  for i := 0 to Length(Data) - 1 do
  begin
    if Char(Data[i]) in [#13, #10, ' '..'~'] then
      tmp := tmp + Chr(Data[i])
    else
      tmp := tmp + ' 0x' + IntToHex(Data[i], 2) + ' ';
  end;
  tmp := TrimRight(tmp); // remove trailing whitespace
  mmoTerm.Lines.Add(tmp);
(*
  // special handling for single byte receiving
  if not Sending and (Length(Data) = 1) then
  begin
    // append to the last line unless content is <CR> or <LF>
    if Data[0] in [$0A, $0D] then
      mmoTerm.Lines.Add('')
    else
    begin
      line := mmoTerm.Lines[mmoTerm.Lines.Count - 1];
      if (line <> '') and (Pos('R: ', tmp) = 1) and (Chr(Data[0]) <> ':') then
        System.Delete(tmp, 1, 3);
      if Chr(Data[0]) = ':' then
      begin
        mmoTerm.Lines.Add(tmp);
      end
      else
      begin
        line := line + tmp;
        mmoTerm.Lines[mmoTerm.Lines.Count - 1] := line;
      end;
    end;
  end
  else
    mmoTerm.Lines.Add(tmp);
*)
end;

procedure TfrmSimpleTerm.tmrPollTimer(Sender: TObject);
begin
  if SimpleTermPolling and BrickComm.IsOpen then
    BrickComm.FlushReceiveBuffer;
end;

procedure TfrmSimpleTerm.actLabelLinesExecute(Sender: TObject);
begin
  SimpleTermLabelLines := not actLabelLines.Checked;
end;

procedure TfrmSimpleTerm.actPollingExecute(Sender: TObject);
begin
  SimpleTermPolling := not actPolling.Checked;
end;

procedure TfrmSimpleTerm.actEchoSendsExecute(Sender: TObject);
begin
  SimpleTermEchoSends := not actEchoSends.Checked;
end;

procedure TfrmSimpleTerm.FormCreate(Sender: TObject);
begin
  tmrPoll.Enabled := False;
  CreateMenus;
end;

procedure TfrmSimpleTerm.CreateMenus;
begin
  mnuMain := TOfficeMainMenu.Create(Self);
  mnuMain.Name := 'mnuMain';
  Self.Menu := mnuMain;

  // create edit menu
  mniEdit := TOfficeMenuItem.Create(mnuMain);
  // add it to main menu
  mnuMain.Items.Add(mniEdit);

  Cut1 := TOfficeMenuItem.Create(Self);
  Copy1 := TOfficeMenuItem.Create(Self);
  Paste1 := TOfficeMenuItem.Create(Self);
  Delete1 := TOfficeMenuItem.Create(Self);
  SelectAll1 := TOfficeMenuItem.Create(Self);

  // add menu items to edit menu
  mniEdit.Add([Cut1, Copy1, Paste1, Delete1, SelectAll1]);

  // create preferences menu
  mniPreferences := TOfficeMenuItem.Create(mnuMain);

  // add it to main menu
  mnuMain.Items.Add(mniPreferences);

  Polling1 := TOfficeMenuItem.Create(mniPreferences);
  LabelLines1 := TOfficeMenuItem.Create(mniPreferences);
  EchoSends1 := TOfficeMenuItem.Create(mniPreferences);

  // add menu items to edit menu
  mniPreferences.Add([Polling1, LabelLines1, EchoSends1]);

  with mniEdit do
  begin
    Name := 'mniEdit';
    Caption := '&Edit';
  end;
  with Cut1 do
  begin
    Name := 'Cut1';
    Action := actEditCut1;
  end;
  with Copy1 do
  begin
    Name := 'Copy1';
    Action := actEditCopy1;
  end;
  with Paste1 do
  begin
    Name := 'Paste1';
    Action := actEditPaste1;
  end;
  with Delete1 do
  begin
    Name := 'Delete1';
    Action := actEditDelete1;
  end;
  with SelectAll1 do
  begin
    Name := 'SelectAll1';
    Action := actEditSelectAll1;
  end;

  with mniPreferences do
  begin
    Name := 'mniPreferences';
    Caption := '&Preferences';
  end;
  with Polling1 do
  begin
    Name := 'Polling1';
    Action := actPolling;
  end;
  with LabelLines1 do
  begin
    Name := 'LabelLines1';
    Action := actLabelLines;
  end;
  with EchoSends1 do
  begin
    Name := 'EchoSends1';
    Action := actEchoSends;
  end;
end;

procedure TfrmSimpleTerm.alSimpleTermUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  actLabelLines.Checked := SimpleTermLabelLines;
  actPolling.Checked    := SimpleTermPolling;
  actEchoSends.Checked  := SimpleTermEchoSends;
end;

initialization
{$IFDEF FPC}
  {$i uSimpleTerm.lrs}
{$ENDIF}

end.
