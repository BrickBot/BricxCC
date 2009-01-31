unit Unlock;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
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

{$R *.DFM}

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

end.
