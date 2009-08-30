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
unit RemoteUnit;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
{$ENDIF}
  Classes, Controls, Graphics, Forms, StdCtrls, ExtCtrls, Buttons, ComCtrls;

type
  TRemoteForm = class(TForm)
    bclMessage: TBevel;
    lblMessage: TLabel;
    lblMsg1: TLabel;
    lblMsg2: TLabel;
    lblMsg3: TLabel;
    grpMotorA: TGroupBox;
    grpMotorB: TGroupBox;
    grpMotorC: TGroupBox;
    lblMotorA: TStaticText;
    lblMotorB: TStaticText;
    lblMotorC: TStaticText;
    btnMotorAFwd: TSpeedButton;
    btnMotorARwd: TSpeedButton;
    btnMotorBFwd: TSpeedButton;
    btnMotorBRwd: TSpeedButton;
    btnMotorCFwd: TSpeedButton;
    btnMotorCRwd: TSpeedButton;
    lblProgram: TLabel;
    lblP1: TLabel;
    lblP2: TLabel;
    lblP3: TLabel;
    lblP4: TLabel;
    lblP5: TLabel;
    lblStop: TLabel;
    lblBeep: TLabel;
    imgIcon: TImage;
    tmrMain: TTimer;
    btnProg1: TButton;
    btnProg5: TButton;
    btnProg4: TButton;
    btnProg3: TButton;
    btnProg2: TButton;
    btnBeep: TButton;
    btnMsg1: TButton;
    btnMsg2: TButton;
    btnMsg3: TButton;
    btnHelp: TButton;
    Shape1: TShape;
    btnStop: TButton;
    barASpeed: TTrackBar;
    barBSpeed: TTrackBar;
    barCSpeed: TTrackBar;
    procedure tmrMainTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure ButtonClicked(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure MotorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MotorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ProgramMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    function GetPower(const mtr : byte) : byte;
  public
    { Public declarations }
  end;

var
  RemoteForm: TRemoteForm;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  SysUtils, uGlobals, brick_common, rcx_constants, uRemoteProgMap,
  uGuiUtils, uRemoteGlobals;

procedure TRemoteForm.tmrMainTimer(Sender: TObject);
var
  msg : Word;
begin
  if BrickComm.BrickType = SU_NXT then
    Exit;
  msg := kRemoteKeysReleased;

  if btnMotorAFwd.Down then
    msg := msg or kRemoteOutAForward;
  if btnMotorARwd.Down then
    msg := msg or kRemoteOutABackward;
  if btnMotorBFwd.Down then
    msg := msg or kRemoteOutBForward;
  if btnMotorBRwd.Down then
    msg := msg or kRemoteOutBBackward;
  if btnMotorCFwd.Down then
    msg := msg or kRemoteOutCForward;
  if btnMotorCRwd.Down then
    msg := msg or kRemoteOutCBackward;

  if msg <> kRemoteKeysReleased then
  begin
    BrickComm.SendRemote(msg);
  end;
end;

procedure TRemoteForm.FormShow(Sender: TObject);
begin
  tmrMain.Enabled := BrickComm.BrickType <> SU_NXT;
  barASpeed.Visible := BrickComm.BrickType = SU_NXT;
  barBSpeed.Visible := barASpeed.Visible;
  barCSpeed.Visible := barASpeed.Visible;
  if tmrMain.Enabled then
  begin
    btnMotorAFwd.GroupIndex := 4;
    btnMotorARwd.GroupIndex := 4;
    btnMotorBFwd.GroupIndex := 5;
    btnMotorBRwd.GroupIndex := 5;
    btnMotorCFwd.GroupIndex := 6;
    btnMotorCRwd.GroupIndex := 6;
  end
  else
  begin
    btnMotorAFwd.GroupIndex := 0;
    btnMotorARwd.GroupIndex := 0;
    btnMotorBFwd.GroupIndex := 0;
    btnMotorBRwd.GroupIndex := 0;
    btnMotorCFwd.GroupIndex := 0;
    btnMotorCRwd.GroupIndex := 0;
  end;
end;

procedure TRemoteForm.FormHide(Sender: TObject);
begin
  tmrMain.Enabled := False;
end;

procedure TRemoteForm.ButtonClicked(Sender: TObject);
var
  val : integer;
begin
  val := TSpeedButton(Sender).Tag;
  if BrickComm.BrickType = SU_NXT then
  begin
    case val of
      1 : BrickComm.SendMessage(1);
      2 : BrickComm.SendMessage(2);
      3 : BrickComm.SendMessage(3);
      4..8 :
        begin
          BrickComm.StopProgram;
          BrickComm.StartProgram(RemotePrograms[val-4]);
        end;
      9 : begin
            BrickComm.StopProgram;
            BrickComm.MotorsOff(7); // stop all motors
            BrickComm.MuteSound;
          end;
     10 : begin
            if (Lowercase(RemotePrograms[5]) = 'default') or (RemotePrograms[5] = '') then
              BrickComm.PlayTone(1760,10)
            else
              BrickComm.PlaySoundFile(RemotePrograms[5], False);
          end;
    end;
  end
  else
  begin
    case val of
      1 : BrickComm.SendRemote(kRemotePBMessage1);
      2 : BrickComm.SendRemote(kRemotePBMessage2);
      3 : BrickComm.SendRemote(kRemotePBMessage3);
      4 : BrickComm.SendRemote(kRemoteSelProgram1);
      5 : BrickComm.SendRemote(kRemoteSelProgram2);
      6 : BrickComm.SendRemote(kRemoteSelProgram3);
      7 : BrickComm.SendRemote(kRemoteSelProgram4);
      8 : BrickComm.SendRemote(kRemoteSelProgram5);
      9 : BrickComm.SendRemote(kRemoteStopOutOff);
     10 : BrickComm.SendRemote(kRemotePlayASound);
    end;
    BrickComm.SendRemote(kRemoteKeysReleased);
  end;
end;

procedure TRemoteForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TRemoteForm.MotorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  mtr : byte;
begin
  if BrickComm.BrickType = SU_NXT then
  begin
    if Button = mbLeft then
    begin
      mtr := TSpeedButton(Sender).Tag;
      if mtr > 4 then
      begin
        dec(mtr, 4);
        BrickComm.SetRwd(mtr);
      end
      else
        BrickComm.SetFwd(mtr);
      BrickComm.SetMotorPower(mtr, kRCX_ConstantType, GetPower(mtr));
      BrickComm.MotorsOn(mtr);
    end;
  end;
end;

procedure TRemoteForm.MotorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  mtr : byte;
begin
  if BrickComm.BrickType = SU_NXT then
  begin
    if Button = mbLeft then
    begin
      mtr := TSpeedButton(Sender).Tag;
      if mtr > 4 then
        dec(mtr, 4);
      BrickComm.MotorsOff(mtr);
    end;
  end;
end;

function TRemoteForm.GetPower(const mtr: byte): byte;
begin
  case mtr of
    1 : Result := 7-barASpeed.Position;
    2 : Result := 7-barBSpeed.Position;
    4 : Result := 7-barCSpeed.Position;
  else
    Result := 4;
  end;
end;

procedure TRemoteForm.ProgramMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  F : TfrmRemoteProgMap;
  i : integer;
begin
  if (BrickComm.BrickType = SU_NXT) and (Button = mbRight) then
  begin
    // right click a program button and display the configuration form.
    F := TfrmRemoteProgMap.Create(nil);
    try
      F.SetProgramNames(RemotePrograms);
      F.Selected := TButton(Sender).Tag;
      if F.ShowModal = mrOK then
      begin
        for i := Low(RemotePrograms) to High(RemotePrograms) do
          RemotePrograms[i] := F.ProgramName[i];
      end;
    finally
      F.Free;
    end;
  end;
end;

{$IFDEF FPC}
initialization
  {$i RemoteUnit.lrs}
{$ENDIF}

end.
