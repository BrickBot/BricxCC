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
unit uSetLNPAddress;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
{$ENDIF}
  Classes, Graphics, Controls, Forms, StdCtrls, BricxccSpin;

type
  TfrmSetLNPAddress = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    Label1: TLabel;
    edtAddress: TBricxccSpinEdit;
    procedure edtAddressKeyPress(Sender: TObject; var Key: Char);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure SetLNPAddress;
  end;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  SysUtils, Dialogs, brick_common, ExecProgram, MainUnit,
  uLocalizedStrings, uCommonUtils, uEditorUtils, uBasicPrefs;

const
  M_NAME = 'SetLNP.mak';

procedure SetAddress(i : Integer);
var
  commandstr, wd, fname : string;
  TheResult : Longint;
begin
  try
    wd := ExcludeTrailingPathDelimiter(GetCurrentDir);
    fname := wd + '\' + M_NAME;
    GenerateRCXMakefile(fname, False, i);
    commandstr := '/bin/make set_addr -f"' + fname + '" -s';
    commandstr := ProcessRCXMakeCommand(fname, '', commandstr);
    {Execute the command, and wait}
    BrickComm.Close;
    try
      TheResult := DoExecuteCommand(commandstr, '', LocalCompilerTimeout, wd, True);
      if TheResult <> 0 then
        ShowMessage(sFailedToSetLNPAddr)
      else
        ShowMessage(Format(sSuccessfulSetLNPAddr, [i]));
    finally
      BrickComm.Open;
      // make sure the toolbar refreshes no matter what
      MainForm.HandleOpenStateChanged(nil);
    end;
  finally
    DeleteFile(fname);
    DeleteFile(ChangeFileExt(fname, '.cmd'));
  end;
end;

{ TfrmSetLNPAddress }

class procedure TfrmSetLNPAddress.SetLNPAddress;
begin
  with TfrmSetLNPAddress.Create(nil) do
  try
    if ShowModal = mrOK then
    begin
      SetAddress(edtAddress.Value);
    end;
  finally
    Free;
  end;
end;

procedure TfrmSetLNPAddress.edtAddressKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure TfrmSetLNPAddress.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

{$IFDEF FPC}
initialization
  {$i uSetLNPAddress.lrs}
{$ENDIF}

end.