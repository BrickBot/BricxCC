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
unit Unlock;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows,
{$ELSE}
  LResources,
  LMessages,
  LCLIntf,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

const
  CM_DOWNLOADFIRMWARE = WM_USER + 234;

type
  TUnlockForm = class(TForm)
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    btnCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    fFile : string;
    fFast : boolean;
    fComp : boolean;
    fUnlock : Boolean;
    fTotal : integer;
    fCur : integer;
    fAbort : boolean;
    procedure HandleDownloadDone(Sender : TObject);
    procedure HandleDownloadStatus(Sender : TObject; cur, total : Integer; var Abort : boolean);
    procedure SetTotal(const Value: integer);
    procedure SetCurrent(const Value: integer);
    procedure CMDownloadFirmware(var Message: TMessage); message CM_DOWNLOADFIRMWARE;
  protected
    property ProgressTotal : integer read fTotal write SetTotal;
    property Current : integer read fCur write SetCurrent;
  public
    { Public declarations }
    class function DownloadFirmware(aFile : string; bFast, bComp, bUnlock : Boolean) : integer;
  end;

var
  UnlockForm: TUnlockForm;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses MainUnit, FakeSpirit, Preferences, uSpirit, brick_common;

procedure TUnlockForm.FormShow(Sender: TObject);
begin
  fAbort := False;
  fCur := -1;
  fTotal := -1;
  ProgressBar1.Position := 0;
end;

class function TUnlockForm.DownloadFirmware(aFile: string;
  bFast, bComp, bUnlock: boolean) : integer;
var
  frm : TUnlockForm;
  DD : TNotifyEvent;
  DS : TDownloadStatusEvent;
begin
  DD := BrickComm.OnDownloadDone;
  DS := BrickComm.OnDownloadStatus;
  try
    frm := TUnlockForm.Create(nil);
    try
      frm.fFile := aFile;
      frm.fFast := bFast;
      frm.fComp := bComp;
      frm.fUnlock := bUnlock;
      BrickComm.OnDownloadDone := frm.HandleDownloadDone;
      BrickComm.OnDownloadStatus := frm.HandleDownloadStatus;
      try
        Result := frm.ShowModal;
      finally
        BrickComm.OnDownloadDone := nil;
        BrickComm.OnDownloadStatus := nil;
      end;
    finally
      frm.Free;
    end;
  finally
    BrickComm.OnDownloadDone := DD;
    BrickComm.OnDownloadStatus := DS;
  end;
end;

procedure TUnlockForm.HandleDownloadDone(Sender: TObject);
begin
{
  if fCur >= fTotal then
    ModalResult := mrOK
  else if fAbort then
    ModalResult := mrCancel
  else
    ModalResult := mrNo;
}
end;

procedure TUnlockForm.HandleDownloadStatus(Sender: TObject; cur,
  total: Integer; var Abort: boolean);
begin
  ProgressTotal := total;
  Current := cur;
  Abort := fAbort;
end;

procedure TUnlockForm.btnCancelClick(Sender: TObject);
begin
  fAbort := True;
end;

procedure TUnlockForm.SetTotal(const Value: integer);
begin
  if fTotal = -1 then
  begin
    ProgressBar1.Min := 0;
    ProgressBar1.Max := Value;
    fTotal := Value;
  end;
end;

procedure TUnlockForm.SetCurrent(const Value: integer);
begin
  fCur := Value;
  ProgressBar1.Position := Value;
  Application.ProcessMessages;
end;

procedure TUnlockForm.CMDownloadFirmware(var Message: TMessage);
begin
  if BrickComm.DownloadFirmware(fFile, fFast, fComp, fUnlock) then
    ModalResult := mrOK
  else if fAbort then
    ModalResult := mrCancel
  else
    ModalResult := mrNo;
end;

procedure TUnlockForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  PostMessage(Handle, CM_DownloadFirmware, 0, 0);
end;

{$IFDEF FPC}
initialization
  {$i Unlock.lrs}
{$ENDIF}

end.
