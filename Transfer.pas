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
unit Transfer;

interface

uses
  Classes, Controls, Forms, StdCtrls, Buttons;

type
  TfrmTransferDlg = class(TForm)
    lblTools: TLabel;
    ItemList: TListBox;
    DnBtn: TBitBtn;
    UpBtn: TBitBtn;
    AddButton: TButton;
    DelButton: TButton;
    EditButton: TButton;
    CloseButton: TButton;
    btnHelp: TButton;
    procedure FormCreate(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure ItemListClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure DelButtonClick(Sender: TObject);
    procedure MoveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure ItemListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  private
    { Private declarations }
    fPrivateList : TList;
    procedure UpdateButtonState;
    function GetPrivateList: TList;
    procedure SetPrivateList(const Value: TList);
    procedure RefreshItemList;
    procedure ClearPrivateList;
  public
    { Public declarations }
    property PrivateTransferList : TList read GetPrivateList write SetPrivateList;
  end;

var
  frmTransferDlg: TfrmTransferDlg;


implementation

{$R *.DFM}

uses
  SysUtils, Dialogs, Transdlg, Preferences, uLocalizedStrings;

procedure TfrmTransferDlg.FormCreate(Sender: TObject);
begin
  fPrivateList := TList.Create;
  UpdateButtonState;
end;

procedure TfrmTransferDlg.EditButtonClick(Sender: TObject);
var
  i : integer;
  TI : TTransferItem;
begin
  i := ItemList.ItemIndex;
  if i = -1 then Exit;
  TI := TTransferItem(fPrivateList[i]);
  with TfrmTransEdit.Create(nil) do
  try
    edTitle.Text        := TI.Title;
    edProgram.Text      := TI.Path;
    edWorkingDir.Text   := TI.WorkingDir;
    edParameters.Text   := TI.Params;
    chkWait.Checked     := TI.Wait;
    chkClose.Checked    := TI.Close;
    chkRestrict.Checked := TI.Restrict;
    edtExt.Text         := TI.Extension;
    if ShowModal = mrOk then
    begin
      TI.Title      := edTitle.Text;
      TI.Path       := edProgram.Text;
      TI.WorkingDir := edWorkingDir.Text;
      TI.Params     := edParameters.Text;
      TI.Wait       := chkWait.Checked;
      TI.Close      := chkClose.Checked;
      TI.Restrict   := chkRestrict.Checked;
      TI.Extension  := edtExt.Text;
    end;
  finally
    Free;
  end;
end;

procedure TfrmTransferDlg.ItemListClick(Sender: TObject);
begin
  UpdateButtonState;
end;

procedure TfrmTransferDlg.AddButtonClick(Sender: TObject);
var
  TI : TTransferItem;
begin
  with TfrmTransEdit.Create(nil) do
  try
    if ShowModal = mrOk then
    begin
      TI := TTransferItem.Create;
      try
        fPrivateList.Add(TI);
        TI.Title      := edTitle.Text;
        TI.Path       := edProgram.Text;
        TI.WorkingDir := edWorkingDir.Text;
        TI.Params     := edParameters.Text;
        TI.Wait       := chkWait.Checked;
        TI.Close      := chkClose.Checked;
        TI.Restrict   := chkRestrict.Checked;
        TI.Extension  := edtExt.Text;
        ItemList.Items.Add(TI.Title);
      except
        TI.Free;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TfrmTransferDlg.DelButtonClick(Sender: TObject);
var
  i : integer;
  TI : TTransferItem;
begin
  i := ItemList.ItemIndex;
  if i = -1 then Exit;
  TI := TTransferItem(fPrivateList[i]);
  if MessageDlg(Format(sConfirm, [TI.Title]), mtConfirmation, [mbOK, mbCancel], 0) = mrOk then
  begin
    ItemList.Items.Delete(i);
    fPrivateList.Delete(i);
    TI.Free;
  end;
end;

procedure TfrmTransferDlg.MoveClick(Sender: TObject);
var
  i : integer;
begin
  i := ItemList.ItemIndex;
  if i = -1 then Exit;
  if Sender = UpBtn then begin
    if i > 0 then begin
      ItemList.Items.Move(i, i-1);
      fPrivateList.Move(i, i-1);
      ItemList.ItemIndex := i-1;
    end;
  end
  else begin
    if i < ItemList.Items.Count - 1 then begin
      ItemList.Items.Move(i, i+1);
      fPrivateList.Move(i, i+1);
      ItemList.ItemIndex := i+1;
    end;
  end;
end;

procedure TfrmTransferDlg.UpdateButtonState;
var
  bEnabled : boolean;
begin
  bEnabled := ItemList.ItemIndex <> -1;
  DelButton.Enabled := bEnabled;
  EditButton.Enabled := bEnabled;
end;

function TfrmTransferDlg.GetPrivateList: TList;
begin
  result := fPrivateList;
end;

procedure TfrmTransferDlg.SetPrivateList(const Value: TList);
var
  i : integer;
  T : TTransferItem;
begin
  ClearPrivateList;
  for i := 0 to Value.Count - 1 do
  begin
    if TObject(Value[i]) is TTransferItem then
    begin
      T := TTransferItem.Create;
      try
        fPrivateList.Add(T);
        T.Assign(TTransferItem(Value[i]));
      except
        T.Free;
      end
    end;
  end;
  RefreshItemList;
end;

procedure TfrmTransferDlg.RefreshItemList;
var
  i : integer;
begin
  ItemList.Clear;
  for i := 0 to fPrivateList.Count - 1 do
  begin
    ItemList.Items.Add(TTransferItem(fPrivateList[i]).Title);
  end;
end;

procedure TfrmTransferDlg.FormDestroy(Sender: TObject);
begin
  ClearPrivateList;
  fPrivateList.Free;
end;

procedure TfrmTransferDlg.ClearPrivateList;
var
  i : integer;
begin
  for i := 0 to fPrivateList.Count - 1 do
  begin
    TTransferItem(fPrivateList[i]).Free;
  end;
  fPrivateList.Clear;
end;

procedure TfrmTransferDlg.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TfrmTransferDlg.ItemListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = ItemList;
end;

end.
