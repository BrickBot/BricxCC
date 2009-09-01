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
unit uToolPalette;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
  LCLIntf,
{$ENDIF}
  Classes, Graphics, Controls, Forms, ComCtrls, ToolWin, ActnList, ImgList,
  Dialogs, Menus;

type

  { TfrmNXTTools }

  TfrmNXTTools = class(TForm)
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    ToolBar3: TToolBar;
    ToolButton1: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton2: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ToolButton3: TToolButton;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    ToolButton32: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    imgList: TImageList;
    alMain: TActionList;
    actControl: TAction;
    actDiagnose: TAction;
    actWatch: TAction;
    actPiano: TAction;
    actJoystick: TAction;
    actRemote: TAction;
    actMessage: TAction;
    actMemory: TAction;
    actFindBrick: TAction;
    actTurnOff: TAction;
    actCloseComm: TAction;
    actExplorer: TAction;
    actScreen: TAction;
    actMIDIConvert: TAction;
    actRSOConvert: TAction;
    actFirmware: TAction;
    actCode: TAction;
    actClear: TAction;
    dlgOpenFirmware: TOpenDialog;
    MainMenu1: TMainMenu;
    ools1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Directcontrol1: TMenuItem;
    Diagnostics1: TMenuItem;
    Watchingthebrick1: TMenuItem;
    Brickpiano1: TMenuItem;
    Brickjoystick1: TMenuItem;
    Remote1: TMenuItem;
    NXTExplorer1: TMenuItem;
    NXTScreen1: TMenuItem;
    N1: TMenuItem;
    Sendmessages1: TMenuItem;
    Memorymap1: TMenuItem;
    Clearmemory1: TMenuItem;
    MIDIConversion1: TMenuItem;
    SoundConversion1: TMenuItem;
    N2: TMenuItem;
    Findbrick1: TMenuItem;
    urnbrickoff1: TMenuItem;
    Closecommunication1: TMenuItem;
    N3: TMenuItem;
    Downloadfirmware1: TMenuItem;
    N4: TMenuItem;
    Codeeditor1: TMenuItem;
    procedure actControlExecute(Sender: TObject);
    procedure actDiagnoseExecute(Sender: TObject);
    procedure actWatchExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actJoystickExecute(Sender: TObject);
    procedure actRemoteExecute(Sender: TObject);
    procedure actMessageExecute(Sender: TObject);
    procedure actMemoryExecute(Sender: TObject);
    procedure actFindBrickExecute(Sender: TObject);
    procedure actTurnOffExecute(Sender: TObject);
    procedure actCloseCommExecute(Sender: TObject);
    procedure actExplorerExecute(Sender: TObject);
    procedure actMIDIConvertExecute(Sender: TObject);
    procedure actRSOConvertExecute(Sender: TObject);
    procedure actFirmwareExecute(Sender: TObject);
    procedure actCodeExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure alMainUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actPianoExecute(Sender: TObject);
    procedure actScreenExecute(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
  private
    { Private declarations }
    procedure DownloadFirmware;
    procedure HandleOnHint(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmNXTTools: TfrmNXTTools;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  uMIDIConversion, uWav2RSO, Watch, uNXTImage, uNXTExplorer,
  Piano, MessageUnit, JoystickUnit, Diagnose, Controller, brick_common,
  uSpirit, MemoryUnit, uPortPrompt, uLocalizedStrings, RemoteUnit,
  Unlock;

procedure TfrmNXTTools.FormCreate(Sender: TObject);
begin
  Application.OnHint := HandleOnHint;
end;

procedure TfrmNXTTools.actControlExecute(Sender: TObject);
begin
  DirectForm.Show;
end;

procedure TfrmNXTTools.actDiagnoseExecute(Sender: TObject);
begin
  DiagForm.Show;
end;

procedure TfrmNXTTools.actWatchExecute(Sender: TObject);
begin
  WatchForm.Show;
end;

procedure TfrmNXTTools.actJoystickExecute(Sender: TObject);
begin
  JoystickForm.Show;
end;

procedure TfrmNXTTools.actRemoteExecute(Sender: TObject);
begin
  RemoteForm.Show;
end;

procedure TfrmNXTTools.actPianoExecute(Sender: TObject);
begin
  PianoForm.Show;
end;

procedure TfrmNXTTools.actScreenExecute(Sender: TObject);
begin
  frmNXTImage.Show;
end;

procedure TfrmNXTTools.actMessageExecute(Sender: TObject);
begin
  MessageForm.Show;
end;

procedure TfrmNXTTools.actMemoryExecute(Sender: TObject);
begin
  MemoryForm.Show;
end;

procedure TfrmNXTTools.actFindBrickExecute(Sender: TObject);
begin
  with TfrmPortPrompt.Create(nil) do
  try
    if ShowModal = mrOK then
    begin
      BrickComm.Port := Port;
      if BrickComm.Open then
      begin
        BrickComm.Ping;
      end
      else
        ShowMessage(sUnableToConnect);
    end;
  finally
    Free;
  end;
end;

procedure TfrmNXTTools.actTurnOffExecute(Sender: TObject);
begin
  BrickComm.Shutdown;
end;

procedure TfrmNXTTools.actCloseCommExecute(Sender: TObject);
begin
  BrickComm.Close;
end;

procedure TfrmNXTTools.actExplorerExecute(Sender: TObject);
begin
  frmNXTExplorer.Show;
end;

procedure TfrmNXTTools.actMIDIConvertExecute(Sender: TObject);
begin
  TfrmMIDIConversion.DoConversion(PianoForm.dlgSave);
end;

procedure TfrmNXTTools.actRSOConvertExecute(Sender: TObject);
begin
  with TfrmWave2RSO.Create(nil) do
  try
    btnCancel.Visible := False;
    btnHelp.Visible   := False;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmNXTTools.actFirmwareExecute(Sender: TObject);
begin
  if dlgOpenFirmware.Execute then
  begin
    DirectForm.Close;
    DiagForm.Close;
    WatchForm.Close;
    JoystickForm.Close;
    PianoForm.Close;
    MemoryForm.Close;
    MessageForm.Close;
    RemoteForm.Close;
    frmNXTExplorer.Close;
    frmNXTImage.Close;
    DownloadFirmware;
  end;
end;

procedure TfrmNXTTools.actCodeExecute(Sender: TObject);
begin
//
end;

procedure TfrmNXTTools.actClearExecute(Sender: TObject);
begin
  if (MessageDlg(sClearMemConfirm, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    BrickComm.ClearMemory;
end;

procedure TfrmNXTTools.alMainUpdate(Action: TBasicAction;
  var Handled: Boolean);
var
  bOpen : boolean;
begin
  bOpen := BrickComm.IsOpen;
  actFindBrick.Enabled := not bOpen;
  actControl.Enabled   := bOpen;
  actDiagnose.Enabled  := bOpen;
  actWatch.Enabled     := bOpen;
  actPiano.Enabled     := bOpen;
  actJoystick.Enabled  := bOpen;
  actRemote.Enabled    := bOpen;
  actMessage.Enabled   := bOpen;
  actMemory.Enabled    := bOpen;
  actTurnOff.Enabled   := bOpen;
  actCloseComm.Enabled := bOpen;
  actExplorer.Enabled  := bOpen;
  actScreen.Enabled    := bOpen;
  actFirmware.Enabled  := bOpen;
  actClear.Enabled     := bOpen;
  // no connection required
  actMIDIConvert.Enabled := True;
  actRSOConvert.Enabled  := True;
  actCode.Enabled        := False;
end;

procedure TfrmNXTTools.DownloadFirmware;
var
  val : integer;
begin
  val := TUnlockForm.DownloadFirmware(dlgOpenFirmware.FileName, False, False, False);
  if val = mrCancel then
    MessageDlg(sWarnCancelFD, mtWarning,[mbOK],0)
  else if val = mrNo then
  begin
    MessageDlg(sFirmDwnldFailed, mtError,[mbOK],0);
  end;
end;

procedure TfrmNXTTools.About1Click(Sender: TObject);
begin
  ShowMessage('NeXT Tools' + #13#10 + 'Copyright 2009, John Hansen');
end;

procedure TfrmNXTTools.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmNXTTools.HandleOnHint(Sender: TObject);
begin
  StatusBar1.SimpleText := Application.Hint;
end;

{$IFDEF FPC}
initialization
  {$i uToolPalette.lrs}
{$ENDIF}

end.
