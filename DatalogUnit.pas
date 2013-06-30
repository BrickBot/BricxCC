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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit DatalogUnit;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
  LCLType,
{$ENDIF}
  Classes, Controls, Forms, Dialogs, StdCtrls;

type
  TDatalogForm = class(TForm)
    DatalogMemo: TMemo;
    UploadBtn: TButton;
    ClearBtn: TButton;
    SizeBox: TComboBox;
    Label1: TLabel;
    SaveBtn: TButton;
    dlgSave: TSaveDialog;
    btnAnalyze: TButton;
    btnAnalyzeXY: TButton;
    btnLoad: TButton;
    dlgOpen: TOpenDialog;
    chkRelativeTime: TCheckBox;
    btnHelp: TButton;
    procedure UploadBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure SizeBoxChange(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure btnAnalyzeClick(Sender: TObject);
    procedure btnAnalyzeXYClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateButtonState;
    procedure LaunchAnalysis(bXY : boolean = false);
  public
    { Public declarations }
  end;

var
  DatalogForm: TDatalogForm;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  SysUtils, brick_common{$IFNDEF FPC}, DataAnalysis{$ENDIF};

procedure TDatalogForm.UploadBtnClick(Sender: TObject);
var
  d : TStrings;
  c : TCursor;
begin
  DatalogMemo.Lines.Clear;
  c := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    d := BrickComm.UploadDatalog(True);
    DatalogMemo.Lines.Assign(d);
    SizeBox.Text := IntToStr(d.Count);
    UpdateButtonState;
  finally
    Screen.Cursor := c;
  end;
end;

procedure TDatalogForm.ClearBtnClick(Sender: TObject);
begin
  BrickComm.SetDatalog(0);
  SizeBox.Text := '0';
end;

procedure TDatalogForm.SizeBoxChange(Sender: TObject);
begin
  BrickComm.SetDatalog(StrToIntDef(SizeBox.Text, 0));
end;

procedure TDatalogForm.SaveBtnClick(Sender: TObject);
begin
  if dlgSave.Execute() then
  begin
    DatalogMemo.Lines.SaveToFile(dlgSave.FileName);
  end;
end;

procedure TDatalogForm.btnAnalyzeClick(Sender: TObject);
begin
  LaunchAnalysis;
end;

procedure TDatalogForm.UpdateButtonState;
var
  bEnable : boolean;
begin
  bEnable := DatalogMemo.Lines.Count > 0;
  btnAnalyze.Enabled   := bEnable;
  btnAnalyzeXY.Enabled := bEnable;
end;

procedure TDatalogForm.LaunchAnalysis(bXY: boolean);
{$IFDEF FPC}
begin
{$ELSE}
var
  F : TfrmDataAnalysis;
begin
  // create and show analysis form here
  F := TfrmDataAnalysis.Create(Application);
  F.DataIsXY     := bXY;
  F.RelativeTime := chkRelativeTime.Checked;
  F.Data         := DatalogMemo.Lines;
  F.Show;
{$ENDIF}
end;

procedure TDatalogForm.btnAnalyzeXYClick(Sender: TObject);
begin
  LaunchAnalysis(True);
end;

procedure TDatalogForm.btnLoadClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
    DatalogMemo.Lines.LoadFromFile(dlgOpen.FileName);
    SizeBox.Text := IntToStr(DatalogMemo.Lines.Count);
    UpdateButtonState;
  end;
end;

procedure TDatalogForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

{$IFDEF FPC}
initialization
  {$i DatalogUnit.lrs}
{$ENDIF}

end.