unit rcx_pipe;

interface

type
  TScaleFactor = 0..200;
  TRcxPipe = class
  private
    fScaleFactor: TScaleFactor;
    fFastMode: boolean;
    fCompMode: boolean;
  protected
    procedure DoSleep(ms : Cardinal); virtual;
  public
    constructor Create;
    procedure Wait(const cmd : Byte; const len, tryCnt : integer; const bFirst : boolean); virtual;
    property ScaleFactor : TScaleFactor read fScaleFactor write fScaleFactor;
    property FastMode : boolean read fFastMode write fFastMode;
    property CompMode : boolean read fCompMode write fCompMode;
  end;

  TRcxUsbPipe = class(TRcxPipe)
  protected
    procedure DoSleep(ms : Cardinal); override;
  public
    procedure Wait(const cmd : Byte; const len, tryCnt : integer; const bFirst : boolean); override;
  end;

implementation

uses
  Windows, Math;

{ TRcxPipe }

constructor TRcxPipe.Create;
begin
  fScaleFactor := 100;
  fFastMode    := False;
  fCompMode    := True;
end;

procedure TRcxPipe.DoSleep(ms: Cardinal);
begin
  // do nothing
end;

procedure TRcxPipe.Wait(const cmd: Byte; const len, tryCnt: integer;
  const bFirst: boolean);
begin
  // do nothing
end;

{ TRcxUsbPipe }

procedure TRcxUsbPipe.DoSleep(ms: Cardinal);
begin
  Sleep(ms);
end;

procedure TRcxUsbPipe.Wait(const cmd: Byte; const len, tryCnt : integer; const bFirst : boolean);
var
  ms : Integer;
begin
  inherited;
  if bFirst then
  begin
    // depending on the command we wait a certain period of time
    case (cmd and $F7) of
      $10 : ms := 200; // kRCX_PingOp
      $15 : ms := 300; // kRCX_UnlockPBrickOp
      $23 : ms := 300; // kRCX_PlayToneOp
      $30 : ms := 150; // kRCX_BatteryLevelOp
      $45 : begin      // kRCX_DownloadOp
        ms := Min(400, 200 + Trunc(0.50 * len));
      end;
      $63 : ms := 150; // kRCX_PollMemoryOp
      $65 : ms := 200; // kRCX_BootModeOp
      $75 : ms := 200; // kRCX_BeginFirmwareOp
      $91 : ms := 150; // kRCX_SelectProgramOp
      $a4 : ms := 150; // kRCX_UploadDatalogOp
      $a5 : ms := 200; // kRCX_UnlockFirmOp
    else
      ms := 120;
    end;
  end
  else
  begin
    // depending on the command we wait a certain period of time
    case (cmd and $F7) of
      $10 : ms := 5;  // kRCX_PingOp
      $11 : ms := 5;  // kRCX_UploadEepromOp
      $12 : ms := 5;  // kRCX_PollOp
      $13 : ms := 5;  // kRCX_OutputPowerOp
      $15 : ms := 5;  // kRCX_UnlockPBrickOp
      $20 : ms := 5;  // kRCX_MemMapOp
      $71 : ms := 5;  // kRCX_StartTaskOp
      $a4 : ms := 5;  // kRCX_UploadDatalogOp
      $a5 : ms := 5;  // kRCX_UnlockFirmOp
    else
      ms := 1;
    end;
  end;
  // scale ms by a factor to speed it up or slow it down
  ms := Trunc(ms * (ScaleFactor / 100.0));
  if ms > 0 then
    DoSleep(ms + Trunc(ms * (0.1 * (tryCnt-1))));
end;

end.
