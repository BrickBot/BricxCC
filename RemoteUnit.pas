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

interface

uses
  Classes, Controls, Graphics, Forms, StdCtrls, ExtCtrls, Buttons;

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
    procedure tmrMainTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure ButtonClicked(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RemoteForm: TRemoteForm;

implementation

{$R *.DFM}

uses
  uSpirit, brick_common;

procedure TRemoteForm.tmrMainTimer(Sender: TObject);
var
  msg : Word;
begin
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
  tmrMain.Enabled := True;
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

procedure TRemoteForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
