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
    actEditCut: TEditCut;
    actEditCopy: TEditCopy;
    actEditPaste: TEditPaste;
    actEditDelete: TEditDelete;
    actEditSelectAll: TEditSelectAll;
    actPolling: TAction;
    actLabelLines: TAction;
    actEchoSends: TAction;
    actNXTUseMailbox: TAction;
    actMB1: TAction;
    actMB2: TAction;
    actMB3: TAction;
    actMB4: TAction;
    actMB5: TAction;
    actMB6: TAction;
    actMB7: TAction;
    actMB8: TAction;
    actMB9: TAction;
    actMB10: TAction;
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
    procedure actNXTUseMailboxExecute(Sender: TObject);
    procedure actMBExecute(Sender: TObject);
  private
    { Private declarations }
    fBusy : boolean;
    mnuMain: TOfficeMainMenu;
    mniEdit: TOfficeMenuItem;
    mniPreferences: TOfficeMenuItem;
    mniCut: TOfficeMenuItem;
    mniCopy: TOfficeMenuItem;
    mniPaste: TOfficeMenuItem;
    mniDelete: TOfficeMenuItem;
    mniSelectAll: TOfficeMenuItem;
    mniPolling: TOfficeMenuItem;
    mniLabelLines: TOfficeMenuItem;
    mniEchoSends: TOfficeMenuItem;
    mniNXTUseMailbox: TOfficeMenuItem;
    mniMailboxNum: TOfficeMenuItem;
    mniMB1: TOfficeMenuItem;
    mniMB2: TOfficeMenuItem;
    mniMB3: TOfficeMenuItem;
    mniMB4: TOfficeMenuItem;
    mniMB5: TOfficeMenuItem;
    mniMB6: TOfficeMenuItem;
    mniMB7: TOfficeMenuItem;
    mniMB8: TOfficeMenuItem;
    mniMB9: TOfficeMenuItem;
    mniMB10: TOfficeMenuItem;
    fOldDataSending : TDataSendReceiveEvent;
    fOldDataReceiving : TDataSendReceiveEvent;
    procedure HandleDataSendingAndReceiving(Sender : TObject; const Sending : boolean; const Data : array of byte);
    procedure CreateMenus;
    procedure UpdateBrickComm;
  public
    { Public declarations }
  end;

var
  frmSimpleTerm: TfrmSimpleTerm;

implementation

{$R *.dfm}

uses
  brick_common, uSimpleTerminalGlobals, uGlobals;

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
  UpdateBrickComm;
end;

procedure TfrmSimpleTerm.HandleDataSendingAndReceiving(Sender: TObject;
  const Sending: boolean; const Data: array of byte);
var
  tmp : string;
  len, j : integer;
  bIsNumeric : boolean;
//  line : string;

  procedure BuildDefaultOutput;
  var
    i : integer;
  begin
    for i := 0 to len - 1 do
    begin
      if Char(Data[i]) in [#13, #10, ' '..'~'] then
        tmp := tmp + Chr(Data[i])
      else
        tmp := tmp + ' 0x' + IntToHex(Data[i], 2) + ' ';
    end;
  end;
begin
  fBusy := True;
  try
    if Sending and not SimpleTermEchoSends then Exit;
    len := Length(Data);
    if len = 0 then Exit;
    if Sending then
      tmp := 'S: '
    else
      tmp := 'R: ';

    if not SimpleTermLabelLines then
      tmp := '';

    if IsNXT and SimpleTermNXTUseMailbox then
    begin
      if ((len = 1) and ((Data[0] = 0) or (Data[0] = 1))) then
      begin
        // boolean value
        tmp := tmp + IntToStr(Data[0]);
      end
      else if (len = 4) then
      begin
        // maybe a numeric value
        bIsNumeric := False;
        for j := 0 to len - 1 do
        begin
          if not (Char(Data[j]) in [' '..'~']) then
          begin
            bIsNumeric := True;
            break;
          end;
        end;
        if bIsNumeric then
        begin
          Move(PByte(@Data[0])^, j, 4);
          tmp := tmp + IntToStr(j);
        end
        else
          BuildDefaultOutput;
      end
      else
        BuildDefaultOutput;
    end
    else
      BuildDefaultOutput;
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
  finally
    fBusy := False;
  end;
end;

procedure TfrmSimpleTerm.tmrPollTimer(Sender: TObject);
begin
  if not fBusy and Visible and (WindowState <> wsMinimized) then
  begin
    if SimpleTermPolling and BrickComm.IsOpen then
      BrickComm.FlushReceiveBuffer;
  end;
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

procedure TfrmSimpleTerm.actNXTUseMailboxExecute(Sender: TObject);
begin
  SimpleTermNXTUseMailbox := not actNXTUseMailbox.Checked;
  UpdateBrickComm;
end;

procedure TfrmSimpleTerm.actMBExecute(Sender: TObject);
begin
  if Sender is TAction then
    TAction(Sender).Checked := True
  else if Sender is TOfficeMenuItem then
    TOfficeMenuItem(Sender).Checked := True;
  SimpleTermNXTMailboxNum := TAction(Sender).Tag;
  UpdateBrickComm;
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

  mniCut := TOfficeMenuItem.Create(Self);
  mniCopy := TOfficeMenuItem.Create(Self);
  mniPaste := TOfficeMenuItem.Create(Self);
  mniDelete := TOfficeMenuItem.Create(Self);
  mniSelectAll := TOfficeMenuItem.Create(Self);

  // add menu items to edit menu
  mniEdit.Add([mniCut, mniCopy, mniPaste, mniDelete, mniSelectAll]);

  // create preferences menu
  mniPreferences := TOfficeMenuItem.Create(mnuMain);

  // add it to main menu
  mnuMain.Items.Add(mniPreferences);

  mniPolling       := TOfficeMenuItem.Create(mniPreferences);
  mniLabelLines    := TOfficeMenuItem.Create(mniPreferences);
  mniEchoSends     := TOfficeMenuItem.Create(mniPreferences);
  mniNXTUseMailbox := TOfficeMenuItem.Create(mniPreferences);
  mniMailboxNum    := TOfficeMenuItem.Create(mniPreferences);

  // add menu items to edit menu
  mniPreferences.Add([mniPolling, mniLabelLines, mniEchoSends, mniNXTUseMailbox, mniMailboxNum]);

  mniMB1  := TOfficeMenuItem.Create(mniMailboxNum);
  mniMB2  := TOfficeMenuItem.Create(mniMailboxNum);
  mniMB3  := TOfficeMenuItem.Create(mniMailboxNum);
  mniMB4  := TOfficeMenuItem.Create(mniMailboxNum);
  mniMB5  := TOfficeMenuItem.Create(mniMailboxNum);
  mniMB6  := TOfficeMenuItem.Create(mniMailboxNum);
  mniMB7  := TOfficeMenuItem.Create(mniMailboxNum);
  mniMB8  := TOfficeMenuItem.Create(mniMailboxNum);
  mniMB9  := TOfficeMenuItem.Create(mniMailboxNum);
  mniMB10 := TOfficeMenuItem.Create(mniMailboxNum);

  mniMailboxNum.Add([mniMB1, mniMB2, mniMB3, mniMB4, mniMB5, mniMB6, mniMB7, mniMB8, mniMB9, mniMB10]);

  with mniEdit do
  begin
    Name := 'mniEdit';
    Caption := '&Edit';
  end;
  with mniCut do
  begin
    Name := 'mniCut';
    Action := actEditCut;
  end;
  with mniCopy do
  begin
    Name := 'mniCopy';
    Action := actEditCopy;
  end;
  with mniPaste do
  begin
    Name := 'mniPaste';
    Action := actEditPaste;
  end;
  with mniDelete do
  begin
    Name := 'mniDelete';
    Action := actEditDelete;
  end;
  with mniSelectAll do
  begin
    Name := 'mniSelectAll';
    Action := actEditSelectAll;
  end;

  with mniPreferences do
  begin
    Name := 'mniPreferences';
    Caption := '&Preferences';
  end;
  with mniPolling do
  begin
    Name := 'mniPolling';
    Action := actPolling;
  end;
  with mniLabelLines do
  begin
    Name := 'mniLabelLines';
    Action := actLabelLines;
  end;
  with mniEchoSends do
  begin
    Name := 'mniEchoSends';
    Action := actEchoSends;
  end;
  with mniNXTUseMailbox do
  begin
    Name := 'mniNXTUseMailbox';
    Action := actNXTUseMailbox;
  end;
  with mniMailboxNum do
  begin
    Name := 'mniMailboxNum';
    Caption := 'NXT Mailbox';
  end;

  with mniMB1 do
  begin
    Name := 'mniMB1';
    Action := actMB1;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mniMB2 do
  begin
    Name := 'mniMB2';
    Action := actMB2;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mniMB3 do
  begin
    Name := 'mniMB3';
    Action := actMB3;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mniMB4 do
  begin
    Name := 'mniMB4';
    Action := actMB4;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mniMB5 do
  begin
    Name := 'mniMB5';
    Action := actMB5;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mniMB6 do
  begin
    Name := 'mniMB6';
    Action := actMB6;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mniMB7 do
  begin
    Name := 'mniMB7';
    Action := actMB7;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mniMB8 do
  begin
    Name := 'mniMB8';
    Action := actMB8;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mniMB9 do
  begin
    Name := 'mniMB9';
    Action := actMB9;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mniMB10 do
  begin
    Name := 'mniMB10';
    Action := actMB10;
    GroupIndex := 2;
    RadioItem := True;
  end;
end;

procedure TfrmSimpleTerm.alSimpleTermUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  actLabelLines.Checked    := SimpleTermLabelLines;
  actPolling.Checked       := SimpleTermPolling;
  actEchoSends.Checked     := SimpleTermEchoSends;
  actNXTUseMailbox.Checked := SimpleTermNXTUseMailbox;
  case SimpleTermNXTMailboxNum of
    0 : actMB1.Checked := True;
    1 : actMB2.Checked := True;
    2 : actMB3.Checked := True;
    3 : actMB4.Checked := True;
    4 : actMB5.Checked := True;
    5 : actMB6.Checked := True;
    6 : actMB7.Checked := True;
    7 : actMB8.Checked := True;
    8 : actMB9.Checked := True;
    9 : actMB10.Checked := True;
  end;
end;

procedure TfrmSimpleTerm.UpdateBrickComm;
begin
  BrickComm.NXTUseMailbox := SimpleTermNXTUseMailbox;
  BrickComm.NXTMailboxNum := SimpleTermNXTMailboxNum;
end;

initialization
{$IFDEF FPC}
  {$i uSimpleTerm.lrs}
{$ENDIF}

end.
