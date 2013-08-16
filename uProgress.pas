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
unit uProgress;

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
  Messages, SysUtils, Classes, Graphics, Controls, Forms, 
  StdCtrls, ExtCtrls, ComCtrls;

type
  TfrmProgress = class(TForm)
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    btnCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    fFile : string;
    fTotal : integer;
    fCur : integer;
    fAbort : boolean;
    procedure SetTotal(const Value: integer);
    procedure SetCurrent(const Value: integer);
  protected
  public
    { Public declarations }
    property ProgressTotal : integer read fTotal write SetTotal;
    property Current : integer read fCur write SetCurrent;
    procedure HandleDownloadDone(Sender : TObject);
    procedure HandleDownloadStatus(Sender : TObject; cur, total : Integer; var Abort : boolean);
  end;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TfrmProgress.FormShow(Sender: TObject);
begin
  fAbort := False;
  fCur := -1;
  fTotal := -1;
  ProgressBar1.Position := 0;
end;

procedure TfrmProgress.HandleDownloadDone(Sender: TObject);
begin
  if fCur >= fTotal then
    ModalResult := mrOK
  else if fAbort then
    ModalResult := mrCancel
  else
    ModalResult := mrNo;
end;

procedure TfrmProgress.HandleDownloadStatus(Sender: TObject; cur,
  total: Integer; var Abort: boolean);
begin
  ProgressTotal := total;
  Current := cur;
  Abort := fAbort;
end;

procedure TfrmProgress.btnCancelClick(Sender: TObject);
begin
  fAbort := True;
end;

procedure TfrmProgress.SetTotal(const Value: integer);
begin
  if fTotal = -1 then
  begin
    ProgressBar1.Min := 0;
    ProgressBar1.Max := Value;
    fTotal := Value;
  end;
end;

procedure TfrmProgress.SetCurrent(const Value: integer);
begin
  fCur := Value;
  ProgressBar1.Position := Value;
  Application.ProcessMessages;
end;

{$IFDEF FPC}
initialization
  {$i uProgress.lrs}
{$ENDIF}

end.