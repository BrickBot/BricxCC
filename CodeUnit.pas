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
unit CodeUnit;

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
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, SynEdit, Menus, uOfficeComp;

type
  TCodeForm = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    pmnuCodeView: TOfficePopupMenu;
    lmiEditCopy: TOfficeMenuItem;
    lmiEditSelectAll: TOfficeMenuItem;
    N1: TOfficeMenuItem;
    mniCodeFind: TOfficeMenuItem;
    mniCodeFindNext: TOfficeMenuItem;
    mniCodeFindPrev: TOfficeMenuItem;
    N2: TOfficeMenuItem;
    mniStayOnTop: TOfficeMenuItem;
    procedure lmiEditCopyClick(Sender: TObject);
    procedure lmiEditSelectAllClick(Sender: TObject);
    procedure mniStayOnTopClick(Sender: TObject);
    procedure mniCodeFindClick(Sender: TObject);
    procedure mniCodeFindNextClick(Sender: TObject);
    procedure mniCodeFindPrevClick(Sender: TObject);
    procedure CreatePopupMenu;
    procedure CreateSynEditComponents;
  public
    { Public declarations }
    CodeEdit: TSynEdit;
  end;

var
  CodeForm: TCodeForm;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  uLocalizedStrings, uGuiUtils, uEditorUtils;

procedure TCodeForm.lmiEditCopyClick(Sender: TObject);
begin
  CodeEdit.CopyToClipboard();
end;

procedure TCodeForm.lmiEditSelectAllClick(Sender: TObject);
begin
  CodeEdit.SelectAll();
end;

procedure TCodeForm.mniStayOnTopClick(Sender: TObject);
const
  FS : array[Boolean] of TFormStyle = (fsNormal, fsStayOnTop);
begin
  mniStayOnTop.Checked := not mniStayOnTop.Checked;
  FormStyle := FS[mniStayOnTop.Checked];
end;

procedure TCodeForm.mniCodeFindClick(Sender: TObject);
begin
  ShowSearchReplaceDialog(CodeEdit, False);
end;

procedure TCodeForm.mniCodeFindNextClick(Sender: TObject);
begin
  DoSearchReplaceText(CodeEdit, False, False);
end;

procedure TCodeForm.mniCodeFindPrevClick(Sender: TObject);
begin
  DoSearchReplaceText(CodeEdit, False, True);
end;

procedure TCodeForm.FormCreate(Sender: TObject);
begin
  CreateSynEditComponents;
  CreatePopupMenu;
  CodeEdit.PopupMenu := pmnuCodeView;
end;

procedure TCodeForm.CreatePopupMenu;
begin
  pmnuCodeView := TOfficePopupMenu.Create(Self);
  pmnuCodeView.Name := 'pmnuCodeView';
  lmiEditCopy := TOfficeMenuItem.Create(pmnuCodeView);
  lmiEditSelectAll := TOfficeMenuItem.Create(pmnuCodeView);
  N1 := TOfficeMenuItem.Create(pmnuCodeView);
  mniCodeFind := TOfficeMenuItem.Create(pmnuCodeView);
  mniCodeFindNext := TOfficeMenuItem.Create(pmnuCodeView);
  mniCodeFindPrev := TOfficeMenuItem.Create(pmnuCodeView);
  N2 := TOfficeMenuItem.Create(pmnuCodeView);
  mniStayOnTop := TOfficeMenuItem.Create(pmnuCodeView);
  pmnuCodeView.Items.Add([lmiEditCopy, lmiEditSelectAll, N1, mniCodeFind,
                          mniCodeFindNext, mniCodeFindPrev, N2,
                          mniStayOnTop]);
  with lmiEditCopy do
  begin
    Name := 'lmiEditCopy';
    Caption := sCopy;
    ShortCut := 16451;
    OnClick := lmiEditCopyClick;
  end;
  with lmiEditSelectAll do
  begin
    Name := 'lmiEditSelectAll';
    Caption := sSelectAll;
    ShortCut := 16449;
    OnClick := lmiEditSelectAllClick;
  end;
  with N1 do
  begin
    Name := 'N1';
    Caption := '-';
  end;
  with mniCodeFind do
  begin
    Name := 'mniCodeFind';
    Caption := sFind + '...';
    ShortCut := 16454;
    OnClick := mniCodeFindClick;
  end;
  with mniCodeFindNext do
  begin
    Name := 'mniCodeFindNext';
    Caption := sFindNext;
    ShortCut := 114;
    OnClick := mniCodeFindNextClick;
  end;
  with mniCodeFindPrev do
  begin
    Name := 'mniCodeFindPrev';
    Caption := sFindPrevious;
    ShortCut := 8306;
    OnClick := mniCodeFindPrevClick;
  end;
  with N2 do
  begin
    Name := 'N2';
    Caption := '-';
  end;
  with mniStayOnTop do
  begin
    Name := 'mniStayOnTop';
    Caption := sStayOnTop;
    RadioItem := True;
    OnClick := mniStayOnTopClick;
  end;
end;

procedure TCodeForm.CreateSynEditComponents;
begin
  CodeEdit := TSynEdit.Create(Self);
  with CodeEdit do
  begin
    Name := 'CodeEdit';
    Parent := Self;
    Left := 0;
    Top := 0;
    Width := 536;
    Height := 341;
    Cursor := crIBeam;
    Align := alClient;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'Courier New';
    Font.Pitch := fpFixed;
    Font.Style := [];
    ParentColor := False;
    ParentFont := False;
    TabOrder := 0;
    Gutter.Font.Charset := DEFAULT_CHARSET;
    Gutter.Font.Color := clWindowText;
    Gutter.Font.Height := -11;
    Gutter.Font.Name := 'Terminal';
    Gutter.Font.Style := [];
    ReadOnly := True;
    MaxLeftChar := 8192;
  end;
end;

{$IFDEF FPC}
initialization
  {$i CodeUnit.lrs}
{$ENDIF}

end.
