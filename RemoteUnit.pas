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
    tmrMain: TTimer;
    barASpeed: TTrackBar;
    barBSpeed: TTrackBar;
    barCSpeed: TTrackBar;
    grpMotorD: TGroupBox;
    btnMotorDFwd: TSpeedButton;
    btnMotorDRwd: TSpeedButton;
    barDSpeed: TTrackBar;
    lblMotorD: TStaticText;
    pnlTop: TPanel;
    lblMsg1: TLabel;
    btnMsg1: TButton;
    lblMsg2: TLabel;
    btnMsg2: TButton;
    lblMsg3: TLabel;
    btnMsg3: TButton;
    bclMessage: TBevel;
    lblMessage: TLabel;
    imgIcon: TImage;
    pnlBottom: TPanel;
    Shape1: TShape;
    lblProgram: TLabel;
    lblP1: TLabel;
    lblP2: TLabel;
    lblP3: TLabel;
    lblP4: TLabel;
    lblP5: TLabel;
    lblStop: TLabel;
    lblBeep: TLabel;
    btnProg1: TButton;
    btnProg5: TButton;
    btnProg4: TButton;
    btnProg3: TButton;
    btnProg2: TButton;
    btnBeep: TButton;
    btnHelp: TButton;
    btnStop: TButton;
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
  uRemoteGlobals;

const
  BASE_WIDTH = 190;
  EV3_DELTA = 58;

procedure TRemoteForm.tmrMainTimer(Sender: TObject);
var
  msg : Word;
begin
  if BrickComm.BrickType in [SU_NXT, SU_EV3] then
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
  Width := BASE_WIDTH;
  grpMotorD.Visible := False;
  lblMotorD.Visible := False;
  if BrickComm.BrickType = SU_EV3 then
  begin
    lblMotorD.Visible := True;
    grpMotorD.Visible := True;
    Width := BASE_WIDTH + EV3_DELTA;
    pnlBottom.Left := EV3_DELTA div 2;
    pnlTop.Left    := EV3_DELTA div 2;
  end;
  barASpeed.Visible := BrickComm.BrickType in [SU_NXT, SU_EV3];
  barBSpeed.Visible := barASpeed.Visible;
  barCSpeed.Visible := barASpeed.Visible;
  tmrMain.Enabled   := not barASpeed.Visible;
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
    btnMotorDFwd.GroupIndex := 0;
    btnMotorDRwd.GroupIndex := 0;
  end;
end;

procedure TRemoteForm.FormHide(Sender: TObject);
begin
  tmrMain.Enabled := False;
end;

procedure TRemoteForm.ButtonClicked(Sender: TObject);
var
  val : integer;
  filename : string;
begin
  val := TSpeedButton(Sender).Tag;
  if BrickComm.BrickType in [SU_NXT, SU_EV3] then
  begin
    case val of
      1 : BrickComm.SendMessage(1);
      2 : BrickComm.SendMessage(2);
      3 : BrickComm.SendMessage(3);
      4..8 :
        begin
          BrickComm.DCStopProgram;
          BrickComm.DCStartProgram(RemotePrograms[val-4]);
        end;
      9 : begin
            BrickComm.DCStopProgram;
            BrickComm.MotorsOff(7); // stop all motors
            BrickComm.MuteSound;
          end;
     10 : begin
            if (Lowercase(RemotePrograms[5]) = 'default') or (RemotePrograms[5] = '') then
              BrickComm.PlayTone(1760,10)
            else
            begin
              filename := RemotePrograms[5];
              BrickComm.DCPlaySoundFile(filename, False);
            end;
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
  dir : TMotorDirection;
begin
  if BrickComm.BrickType in [SU_NXT, SU_EV3] then
  begin
    if Button = mbLeft then
    begin
      mtr := TSpeedButton(Sender).Tag;
      if mtr > 8 then
      begin
        dec(mtr, 8);
        dir := mdReverse;
//        BrickComm.SetRwd(mtr);
      end
      else
      begin
        dir := mdForward;
//        BrickComm.SetFwd(mtr);
      end;
//      BrickComm.SetMotorPower(mtr, kRCX_ConstantType, GetPower(mtr));
//      BrickComm.MotorsOn(mtr);
      BrickComm.ControlMotors(mtr, GetPower(mtr), dir, msOn);
    end;
  end;
end;

procedure TRemoteForm.MotorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  mtr : byte;
begin
  if BrickComm.BrickType in [SU_NXT, SU_EV3] then
  begin
    if Button = mbLeft then
    begin
      mtr := TSpeedButton(Sender).Tag;
      if mtr > 8 then
        dec(mtr, 8);
      BrickComm.ControlMotors(mtr, 0, mdForward, msOff);
//      BrickComm.MotorsOff(mtr);
    end;
  end;
end;

function TRemoteForm.GetPower(const mtr: byte): byte;
begin
  case mtr of
    1 : Result := 7-barASpeed.Position;
    2 : Result := 7-barBSpeed.Position;
    4 : Result := 7-barCSpeed.Position;
    8 : Result := 7-barDSpeed.Position;
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
  if (BrickComm.BrickType in [SU_NXT, SU_EV3]) and (Button = mbRight) then
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