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
unit uScoutMem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    Label1: TLabel;
    cboPort: TComboBox;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    SelectAll1: TMenuItem;
    CopyToClipboard1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure CopyToClipboard1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure cboPortChange(Sender: TObject);
  private
    { Private declarations }
    fMarkMem : TStrings;
    fCompareMem : TStrings;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses
  Clipbrd, brick_common, FakeSpirit;

procedure TForm1.Button1Click(Sender: TObject);
var
  addr : integer;
begin
  Screen.Cursor := crHourGlass;
  try
    fMarkMem.Clear;
    // we can only get 150 bytes at a time
    addr := $0040;
    while addr < $0440 do
    begin
      fMarkMem.AddStrings(BrickComm.PollMemory(addr, 128));
      inc(addr, 128);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  cboPort.ItemIndex := 0;
  fMarkMem    := TStringList.Create;
  fCompareMem := TStringList.Create;
  BrickComm.Port := 'COM1';
  BrickComm.BrickType := 2; // scout
  BrickComm.AutoClose := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  fMarkMem.Free;
  fCompareMem.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i : integer;
  addr : integer;
  tmpStr, diffStr : string;
begin
  Screen.Cursor := crHourGlass;
  try
    fCompareMem.Clear;
    // we can only get 150 bytes at a time
    addr := $0040;
    while addr < $0440 do
    begin
      fCompareMem.AddStrings(BrickComm.PollMemory(addr, 128));
      inc(addr, 128);
    end;
    if fMarkMem.Count <> fCompareMem.Count then
    begin
      ShowMessage('count differs');
      Exit;
    end;
    addr := $0040;
    Memo1.Lines.Clear;
    Memo1.Lines.Add('Address  Before  After  Different');
    Memo1.Lines.Add('-------  ------  -----  ---------');
    // show data in memo and mark different lines
    for i := 0 to fCompareMem.Count - 1 do
    begin
      if fCompareMem[i] <> fMarkMem[i] then
        diffStr := '*'
      else
        diffStr := '';
      tmpStr := Format('%7.7s  %6.6s  %5.5s      %s', [IntToHex(addr, 4), fMarkMem[i], fCompareMem[i], diffStr]);
      Memo1.Lines.Add(tmpStr);
      inc(addr);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.SelectAll1Click(Sender: TObject);
begin
  Memo1.SelectAll;
end;

procedure TForm1.Copy1Click(Sender: TObject);
begin
  Memo1.CopyToClipboard;
end;

procedure TForm1.CopyToClipboard1Click(Sender: TObject);
var
  i : integer;
  addr : integer;
  tmpStr, diffStr : string;
begin
  tmpStr := '';
  addr := $040;
  for i := 0 to fCompareMem.Count - 1 do
  begin
    if fCompareMem[i] <> fMarkMem[i] then
      diffStr := '*'
    else
      diffStr := '';
    tmpStr := tmpStr + Format('%s' + #9 + '%s' + #9 + '%s' + #9 + '%s', [IntToHex(addr, 4), fMarkMem[i], fCompareMem[i], diffStr]);
    tmpStr := tmpStr + #13#10;
    inc(addr);
  end;
  Clipboard.AsText := tmpStr;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
//
end;

procedure TForm1.cboPortChange(Sender: TObject);
begin
  BrickComm.Port := IntToStr(cboPort.ItemIndex + 1); // TODO: fix this
end;

end.
