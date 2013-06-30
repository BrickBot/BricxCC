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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uHexViewer;

interface

uses
  Messages, Classes, Controls, Forms, Dialogs, Menus,
  StdCtrls, ComCtrls, uOfficeComp;

type
  TfrmHexView = class(TForm)
    OpenDlg: TOpenDialog;
    SaveDlg: TSaveDialog;
    Rich: TRichEdit;
    StatusBar: TStatusBar;
    MenuPopup: TPopupMenu;
    MenuSelectAll: TMenuItem;
    MenuCopy: TMenuItem;
    N1: TMenuItem;
    MenuOpen: TMenuItem;
    MenuSaveAs: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure MenuOpenClick(Sender: TObject);
    procedure MenuSaveAsClick(Sender: TObject);
    procedure MenuPopupPopup(Sender: TObject);
    procedure MenuSelectAllClick(Sender: TObject);
    procedure MenuCopyClick(Sender: TObject);
  private
    procedure Progress(Address:LongInt);
  protected
    procedure WMDROPFILES(var Message: TWMDROPFILES); message WM_DROPFILES;
  public
    procedure OpenFile(const aFilename : string);
    procedure ShowStreamData(const aFilename : string; aStream : TStream);
  end;

var
  frmHexView: TfrmHexView;

implementation

{$R *.dfm}

uses
  Windows, SysUtils, ShellAPI;

type
  THexConversion = class(TConversion)
  public
    function ConvertReadStream(Stream:TStream; Buffer:PChar;
                               BufSize:integer): integer; override;
  end;


// This implements a callback procedure used by TRichEdit when loading
// a file.  Gets called repeatedly until stream is empty.
//
function THexConversion.ConvertReadStream(Stream:TStream; Buffer:PChar;
                                          BufSize:integer): integer;
var s:string;
    buf:array[1..16] of char;
    i,n:integer;
begin
  Result := 0;
  if BufSize <= 82 then Exit;
  s := Format('%.5x  ',[Stream.Position]);
  n := Stream.Read(buf,16);
  if n = 0 then Exit;
  for i := 1 to n do
    begin
      s := s + IntToHex(ord(buf[i]),2)+' ';
      if i mod 4 = 0 then
        s := s + ' ';
    end;
  s := s + StringOfChar(' ',62-length(s));
  for i := 1 to n do
    begin
      if (buf[i] < #32) or (buf[i] > #126) then
        buf[i] := '.';
      s := s + buf[i];
    end;
  s := s + #13#10;
  StrPCopy(Buffer,s);
  Result := length(s);
  if Stream.Position and $FFF = 0 then
    frmHexView.Progress(Stream.Position);
end;

procedure TfrmHexView.Progress(Address:LongInt);
begin
  StatusBar.SimpleText := 'Reading...  $'+IntToHex(Address,5);
  StatusBar.Update;
end;

procedure TfrmHexView.FormCreate(Sender: TObject);
begin
  {Let Windows know we accept dropped files}
  DragAcceptFiles(Handle,true);
  // register conversion formats
  Rich.RegisterConversionFormat('bin',THexConversion);
  Rich.RegisterConversionFormat('obj',THexConversion);
  Rich.RegisterConversionFormat('exe',THexConversion);
  // nxt files
  Rich.RegisterConversionFormat('ric',THexConversion);
  Rich.RegisterConversionFormat('rxe',THexConversion);
  Rich.RegisterConversionFormat('rtm',THexConversion);
  Rich.RegisterConversionFormat('rso',THexConversion);
  Rich.RegisterConversionFormat('rmd',THexConversion);
  Rich.RegisterConversionFormat('rpg',THexConversion);
  Rich.RegisterConversionFormat('sys',THexConversion);
  Rich.RegisterConversionFormat('rdt',THexConversion);
  Rich.RegisterConversionFormat('rms',THexConversion);
  // configure open dialog filter
  OpenDlg.Filter :=
    'Binary (*.bin; *.obj; *.exe)|*.bin;*.obj;*.exe|' +
    'Text (*.txt)|*.txt|' +
    'All NXT files (*.rxe; *.rtm; *.rpg; *.rso; *.ric; *.rmd; *.rdt; *.sys)|' +
      '*.rxe;*.rtm;*.rpg;*.rso;*.ric;*.rmd;*.rdt;*.sys|' +
    'NXT Executable files (*.rxe; *.rtm)|*.rxe;*.rtm|' +
    'NXT Program files (*.rpg)|*.rpg|' +
    'NXT Sound files (*.rso)|*.rso|' +
    'NXT Icon files (*.ric)|*.ric|' +
    'NXT Melody files (*.rmd)|*.rmd|' +
    'NXT Datalog files (*.rdt)|*.rdt|' +
    'NXT System files (*.sys)|*.sys|' +
    'NXT Menu files (*.rms)|*.rms|' +
    'All files (*.*)|*.*';
end;

procedure TfrmHexView.MenuOpenClick(Sender: TObject);
begin
 if OpenDlg.Execute then
   OpenFile(OpenDlg.Filename);
end;


procedure TfrmHexView.MenuSaveAsClick(Sender: TObject);
begin
  SaveDlg.Filename := ChangeFileExt(OpenDlg.FileName,'.txt');
  if SaveDlg.Execute then
    Rich.Lines.SaveToFile(SaveDlg.FileName);
end;

procedure TfrmHexView.MenuPopupPopup(Sender: TObject);
var SelStart,SelEnd:LongInt;
begin
  Rich.Perform(EM_GETSEL,WPARAM(@SelStart),WPARAM(@SelEnd));
  MenuCopy.Enabled := SelStart <> SelEnd;
end;

procedure TfrmHexView.MenuSelectAllClick(Sender: TObject);
begin
  Rich.Perform(EM_SETSEL,0,-1);
end;

procedure TfrmHexView.MenuCopyClick(Sender: TObject);
begin
  Rich.Perform(WM_COPY,0,0);
end;

procedure TfrmHexView.WMDROPFILES(var Message: TWMDROPFILES);
var
  buffer:array[0..255] of char;
  cnt : Integer;
begin
  cnt := DragQueryFile(Message.Drop, $FFFFFFFF, @buffer, sizeof(buffer));
  if cnt = 1 then
  begin
    DragQueryFile(Message.Drop,0,@buffer,sizeof(buffer));
    OpenFile(buffer);
  end;
  DragFinish(Message.Drop);
end;

procedure TfrmHexView.OpenFile(const aFilename: string);
var
  fname : string;
begin
  Screen.Cursor := crHourglass;
  try
    fname := ExtractFileName(aFilename);
    StatusBar.SimpleText := 'Reading...';
    Rich.Lines.Clear;
    Application.ProcessMessages;
    try
      Rich.Lines.LoadFromFile(aFilename);
      StatusBar.SimpleText := fname;
    except
      on E:EFOpenError do
      begin
        StatusBar.SimpleText := '';
        MessageDlg(Format('Can''t open file %s.',[fname]),mtError,[mbOk],0);
      end;
    end;
  finally
   Screen.Cursor := crDefault;
  end;
end;

procedure TfrmHexView.ShowStreamData(const aFilename : string; aStream: TStream);
var
  CC : TConversionClass;
begin
  Show;
  Screen.Cursor := crHourglass;
  try
    StatusBar.SimpleText := 'Reading...';
    Rich.Lines.Clear;
    Application.ProcessMessages;
    try
      aStream.Position := 0;
      CC := Rich.DefaultConverter;
      try
        Rich.DefaultConverter := THexConversion;
        Rich.Lines.LoadFromStream(aStream);
      finally
        Rich.DefaultConverter := CC;
      end;
      StatusBar.SimpleText := aFilename;
    except
      on E:EFOpenError do
      begin
        StatusBar.SimpleText := '';
        MessageDlg(Format('Can''t open file %s.',[aFilename]),mtError,[mbOk],0);
      end;
    end;
  finally
   Screen.Cursor := crDefault;
  end;
end;

end.