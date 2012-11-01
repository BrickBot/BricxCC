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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uWindowList;

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
  StdCtrls, ExtCtrls;

type
  TfrmWindowList = class(TForm)
    pnlTop: TPanel;
    pnlBottom: TPanel;
    lstWindows: TListBox;
    pnlBotRight: TPanel;
    btnHelp: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    pnlBotLeft: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure lstWindowsDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure GotoSelectedWindow;
    procedure PopulateWindowList;
  public
    { Public declarations }
  end;

var
  frmWindowList: TfrmWindowList;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  MainUnit, Editor;

procedure TfrmWindowList.FormCreate(Sender: TObject);
begin
  PopulateWindowList;
end;

procedure TfrmWindowList.btnOKClick(Sender: TObject);
begin
  GotoSelectedWindow;
end;

procedure TfrmWindowList.GotoSelectedWindow;
var
  i : Integer;
  F : TForm;
begin
  i := lstWindows.ItemIndex;
  if i <> -1 then
  begin
    F := TForm(lstWindows.Items.Objects[i]);
    if F is TEditorForm then
    begin
      MainForm.ActivateEditorForm(TEditorForm(F));
    end
    else
    begin
      if F.Visible then
        F.BringToFront;
      if F.WindowState = wsMinimized then
        F.WindowState := wsNormal;
    end;
  end;
  ModalResult := mrOk;
end;

procedure TfrmWindowList.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TfrmWindowList.PopulateWindowList;
var
  i : Integer;
  C : string;
  F : TForm;
begin
  lstWindows.Clear;
  for i := 0 to Screen.FormCount - 1 do
  begin
    F := Screen.Forms[i];
    if F.Visible and (F <> MainForm) and (F <> Self) then
    begin
      C := F.Caption;
      lstWindows.Items.AddObject(C, F);
    end;
  end;
  if lstWindows.Items.Count > 0 then
    lstWindows.ItemIndex := 0;
end;

procedure TfrmWindowList.lstWindowsDblClick(Sender: TObject);
begin
  GotoSelectedWindow;
end;

{$IFDEF FPC}
initialization
  {$i uWindowList.lrs}
{$ENDIF}

end.