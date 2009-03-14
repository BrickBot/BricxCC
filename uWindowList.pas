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
unit uWindowList;

interface

uses
  Classes, Controls, Forms, StdCtrls, ExtCtrls;

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

{$R *.DFM}

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
  F : TEditorForm;
begin
  i := lstWindows.ItemIndex;
  if i <> -1 then
  begin
    F := TEditorForm(lstWindows.Items.Objects[i]);
    MainForm.ActivateEditorForm(F);
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
    if F.Visible and (F is TEditorForm) then
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

end.
