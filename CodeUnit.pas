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
  LCLType,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, SynEdit, Menus, uOfficeComp;

type

  { TCodeForm }

  TCodeForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    pmnuCodeView: TOfficePopupMenu;
    lmiEditCopy: TOfficeMenuItem;
    lmiEditSelectAll: TOfficeMenuItem;
    N1: TOfficeMenuItem;
    mniCodeFind: TOfficeMenuItem;
    mniCodeFindNext: TOfficeMenuItem;
    mniCodeFindPrev: TOfficeMenuItem;
    mniCodeGotoLine: TOfficeMenuItem;
    N2: TOfficeMenuItem;
    mniStayOnTop: TOfficeMenuItem;
    barStatus : TStatusBar;
    procedure lmiEditCopyClick(Sender: TObject);
    procedure lmiEditSelectAllClick(Sender: TObject);
    procedure mniStayOnTopClick(Sender: TObject);
    procedure mniCodeFindClick(Sender: TObject);
    procedure mniCodeFindNextClick(Sender: TObject);
    procedure mniCodeFindPrevClick(Sender: TObject);
    procedure mniGotoLineClick(Sender: TObject);
    procedure CreateStatusBar;
    procedure CreatePopupMenu;
    procedure CreateSynEditComponents;
    procedure UpdatePositionOnStatusBar;
    procedure TheEditorStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure GotoLine;
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
  uLocalizedStrings, uGuiUtils, uEditorUtils, GotoLine, SynEditTypes;

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
  CreateStatusBar;
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
  mniCodeGotoLine := TOfficeMenuItem.Create(pmnuCodeView);
  N2 := TOfficeMenuItem.Create(pmnuCodeView);
  mniStayOnTop := TOfficeMenuItem.Create(pmnuCodeView);
  AddMenuItems(pmnuCodeView.Items,[lmiEditCopy, lmiEditSelectAll, N1, mniCodeFind,
                          mniCodeFindNext, mniCodeFindPrev, mniCodeGotoLine, N2,
                          mniStayOnTop]);
//  pmnuCodeView.Items.Add([lmiEditCopy, lmiEditSelectAll, N1, mniCodeFind,
//                          mniCodeFindNext, mniCodeFindPrev, mniCodeGotoLine, N2,
//                          mniStayOnTop]);
  with lmiEditCopy do
  begin
    Name := 'lmiEditCopy';
    Caption := sCopy;
    ShortCut := 16451; // Ctrl+C
    OnClick := lmiEditCopyClick;
  end;
  with lmiEditSelectAll do
  begin
    Name := 'lmiEditSelectAll';
    Caption := sSelectAll;
    ShortCut := 16449; // Ctrl+A
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
    ShortCut := 16454; // Ctrl+F
    OnClick := mniCodeFindClick;
  end;
  with mniCodeFindNext do
  begin
    Name := 'mniCodeFindNext';
    Caption := sFindNext;
    ShortCut := 114; // F3
    OnClick := mniCodeFindNextClick;
  end;
  with mniCodeFindPrev do
  begin
    Name := 'mniCodeFindPrev';
    Caption := sFindPrevious;
    ShortCut := 8306; // Shift+F3
    OnClick := mniCodeFindPrevClick;
  end;
  with mniCodeGotoLine do
  begin
    Name := 'mniCodeGotoLine';
    Caption := sGotoLine;
    ShortCut := 16455; // Ctrl+G
    OnClick := mniGotoLineClick;
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
{$IFNDEF FPC}
    Gutter.Font.Charset := DEFAULT_CHARSET;
    Gutter.Font.Color := clWindowText;
    Gutter.Font.Height := -11;
    Gutter.Font.Name := 'Terminal';
    Gutter.Font.Style := [];
{$ENDIF}
    Lines.Clear;
    ReadOnly := True;
    MaxLeftChar := 8192;
    OnStatusChange := TheEditorStatusChange;
  end;
end;

procedure TCodeForm.TheEditorStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  // Note: scAll for new file loaded
  // caret position has changed
  if Changes * [{$IFNDEF FPC}scAll, {$ENDIF}scCaretX, scCaretY] <> [] then begin
    UpdatePositionOnStatusBar;
  end;
end;

procedure TCodeForm.UpdatePositionOnStatusBar;
var
  p: TPoint;
begin
  p := CodeEdit.CaretXY;
  barStatus.Panels[0].Text := Format('%6d:%3d', [p.Y, p.X]);
end;

procedure TCodeForm.FormShow(Sender: TObject);
begin
  UpdatePositionOnStatusBar;
end;

procedure TCodeForm.CreateStatusBar;
begin
  barStatus := TStatusBar.Create(Self);
  with barStatus do
  begin
    Name := 'barStatus';
    Parent := Self;
    Left := 0;
    Top := 319;
    Width := 536;
    Height := 22;
    Hint := 'Copy';
    with Panels.Add do begin
      Alignment := taCenter;
      Width := 80;
    end;
    with Panels.Add do begin
      Width := 80;
    end;
    with Panels.Add do begin
      Width := 80;
    end;
    with Panels.Add do begin
      Width := 80;
    end;
    with Panels.Add do begin
      Width := 80;
    end;
    with Panels.Add do begin
      Width := 50;
    end;
    SimplePanel := False;
  end;
end;

procedure TCodeForm.GotoLine;
var
  G : TGotoForm;
begin
  G := TGotoForm.Create(nil);
  try
    G.MaxLine := CodeEdit.Lines.Count;
    G.TheLine := CodeEdit.CaretY;
    if G.ShowModal = mrOK then
    begin
      with CodeEdit do begin
        SetFocus;
        CaretXY := Point(0, G.TheLine);
        BlockBegin := CaretXY;
        BlockEnd   := BlockBegin;
        EnsureCursorPosVisible;
      end;
    end;
  finally
    G.Free;
  end;
end;

procedure TCodeForm.mniGotoLineClick(Sender: TObject);
begin
  GotoLine;
end;

{$IFDEF FPC}
initialization
  {$i CodeUnit.lrs}
{$ENDIF}

end.
