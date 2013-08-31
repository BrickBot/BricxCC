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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uportsedit;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows,
  ImgList, ToolWin,
{$ELSE}
  LResources, FileUtil,
{$ENDIF}
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  ComCtrls, StdCtrls, ActnList, StdActns;

type

  { TfrmPortsEdit }

  TfrmPortsEdit = class(TForm)
    Save1: TAction;
    AddNXT1: TAction;
    ActionList1: TActionList;
    EditCopy1: TEditCopy;
    EditCut1: TEditCut;
    EditDelete1: TEditDelete;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    lstImages: TImageList;
    mmoPorts: TMemo;
    barMain: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton5: TToolButton;
    StatusBar1: TStatusBar;
    lstDisabled: TImageList;
    procedure AddNXT1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Save1Execute(Sender: TObject);
    procedure mmoPortsChange(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    fChanges: boolean;
    procedure SetChanges(const Value: boolean);
  private
    { private declarations }
    property Changes : boolean read fChanges write SetChanges;
  public
    { public declarations }
  end;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

uses
  brick_common, uSpirit, uLocalizedStrings, uGlobals;

const
  STATUS : array[boolean] of string = ('', S_Modified);

function GetUSBProductId : integer;
begin
  Result := 2;
  if BrickComm.BrickType = SU_EV3 then
    Result := 5;
end;

procedure GetBrickResourceStrings(aStrings : TStrings);
var
  name, addr : string;
  btsig, memfree : cardinal;
begin
  if BrickComm.SCGetDeviceInfo(name, addr, btsig, memfree) then
  begin
    aStrings.Add(Format('BTH::%s=BTH::%s::%s::1', [name, name, addr]));
    addr := StringReplace(addr, ':', '', [rfReplaceAll]);
    aStrings.Add(Format('%s=USB0::0X0694::0X000%d::%s::RAW', [addr, GetUSBProductId, addr]));
  end;
end;

{ TfrmPortsEdit }

procedure TfrmPortsEdit.AddNXT1Execute(Sender: TObject);
var
  SL : TStringList;
  oldContent : string;
begin
  if BrickComm.Open then
  begin
    oldContent := mmoPorts.Lines.Text;
    SL := TStringList.Create;
    try
      SL.Sorted := True;
      SL.Duplicates := dupIgnore;
      SL.AddStrings(mmoPorts.Lines);
      GetBrickResourceStrings(SL);
      mmoPorts.Lines.Assign(SL);
    finally
      SL.Free;
    end;
    Changes := oldContent <> mmoPorts.Lines.Text;
  end;
end;

procedure TfrmPortsEdit.FormCreate(Sender: TObject);
begin
  if FileExists(GetInitFilename) then
  begin
    mmoPorts.Lines.LoadFromFile(GetInitFilename);
  end;
  Changes := False;
end;

procedure TfrmPortsEdit.FormShow(Sender: TObject);
begin
  Changes := False;
end;

procedure TfrmPortsEdit.Save1Execute(Sender: TObject);
var
  SL : TStringList;
begin
  SL := TStringList.Create;
  try
    SL.Sorted := True;
    SL.Duplicates := dupIgnore;
    SL.AddStrings(mmoPorts.Lines);
    Sl.SaveToFile(GetInitFilename);
    mmoPorts.Lines.Assign(SL);
  finally
    SL.Free;
  end;
  Changes := False;
end;

procedure TfrmPortsEdit.mmoPortsChange(Sender: TObject);
begin
  Changes := True;
end;

procedure TfrmPortsEdit.SetChanges(const Value: boolean);
begin
  fChanges := Value;
  StatusBar1.SimpleText := STATUS[Changes];
end;

procedure TfrmPortsEdit.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  Save1.Enabled := Changes;
end;

procedure TfrmPortsEdit.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  res : integer;
begin
  CanClose := True;
  if Changes then
  begin
    res := MessageDlg(sSaveNXTDATChanges, mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if res = mrYes then
      Save1.Execute;
    CanClose := res <> mrCancel;
  end;
end;

{$IFDEF FPC}
initialization
  {$I uportsedit.lrs}
{$ENDIF}

end.