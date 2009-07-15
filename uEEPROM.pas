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
unit uEEPROM;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
{$ENDIF}
  Classes, Controls, Forms, ComCtrls, StdCtrls, ExtCtrls, Dialogs, BricxccSpin;

type
  TSpybotSpecies = (ssGigamesh, ssSnapTrax, ssShadowStrike, ssTechnoJaw);
  TfrmSpybotEEPROM = class(TForm)
    pagMain: TPageControl;
    shtGameItems: TTabSheet;
    shtRawData: TTabSheet;
    pnlGameBottom: TPanel;
    btnRead: TButton;
    btnWrite: TButton;
    pnlGameItems: TPanel;
    pagGameItems: TPageControl;
    shtGame1: TTabSheet;
    lblSpecies: TLabel;
    lblLongID: TLabel;
    lblUserLevel: TLabel;
    lblPingRate: TLabel;
    lblRuns: TLabel;
    lblWins: TLabel;
    lblLosses: TLabel;
    lblPoints: TLabel;
    lblPlaySeconds: TLabel;
    lblTotalPlayTime: TLabel;
    lblMaxBots: TLabel;
    lblMissionID: TLabel;
    lblMissionPoints: TLabel;
    lblHighScore: TLabel;
    lblRobotName: TLabel;
    lblBirthDate: TLabel;
    lblBotData: TLabel;
    lblStatus: TLabel;
    grpMotorControl: TGroupBox;
    lblMCNormal: TLabel;
    lblMCSlow: TLabel;
    grpLeftDir: TGroupBox;
    radLeftFwd: TRadioButton;
    radLeftRev: TRadioButton;
    grpRightDir: TGroupBox;
    radRightFwd: TRadioButton;
    radRightRev: TRadioButton;
    cboSpecies: TComboBox;
    edtRobotName: TEdit;
    shtGame2: TTabSheet;
    grpMissionsPlayed: TGroupBox;
    grpTokens: TGroupBox;
    btnSave: TButton;
    btnLoad: TButton;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
{$IFNDEF FPC}
    dtpBirthdate: TDateTimePicker;
{$ENDIF}
    btnHelp: TButton;
    shtCustom: TTabSheet;
    edtData: TMemo;
    lblBlockNum: TLabel;
    btnBlockRead: TButton;
    btnBlockClear: TButton;
    lblBlockCnt: TLabel;
    edtMCNormal: TBricxccSpinEdit;
    edtMCSlow: TBricxccSpinEdit;
    edtUserLevel: TBricxccSpinEdit;
    edtDefaultPingRate: TBricxccSpinEdit;
    edtRuns: TBricxccSpinEdit;
    edtWins: TBricxccSpinEdit;
    edtLosses: TBricxccSpinEdit;
    edtPoints: TBricxccSpinEdit;
    edtPlaySeconds: TBricxccSpinEdit;
    edtTotalPlayTime: TBricxccSpinEdit;
    edtMaxBots: TBricxccSpinEdit;
    edtMissionID: TBricxccSpinEdit;
    edtMissionPoints: TBricxccSpinEdit;
    edtHighScore: TBricxccSpinEdit;
    edtBotData: TBricxccSpinEdit;
    edtStatus: TBricxccSpinEdit;
    edtLongID: TBricxccSpinEdit;
    edtBlock: TBricxccSpinEdit;
    edtBlockCount: TBricxccSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure RawKeyPress(Sender: TObject; var Key: Char);
    procedure UpdateRawData(Sender: TObject);
    procedure UpdateTokenRawData(Sender: TObject);
    procedure pagMainChange(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnBlockReadClick(Sender: TObject);
    procedure btnBlockClearClick(Sender: TObject);
  private
    function GetMotorControl: Byte;
    procedure SetMotorControl(const Value: Byte);
    function GetSpecies: Byte;
    procedure SetSpecies(const Value: Byte);
    function GetLongID: Cardinal;
    procedure SetLongID(const Value: Cardinal);
    function GetDefaultPingRate: Byte;
    procedure SetDefaultPingRate(const Value: Byte);
    function GetUserLevel: Byte;
    procedure SetUserLevel(const Value: Byte);
    function GetLosses: Word;
    function GetPlaySeconds: Word;
    function GetPoints: Word;
    function GetRuns: Word;
    function GetTotalPlayTime: Integer;
    function GetWins: Word;
    procedure SetLosses(const Value: Word);
    procedure SetPlaySeconds(const Value: Word);
    procedure SetPoints(const Value: Word);
    procedure SetRuns(const Value: Word);
    procedure SetTotalPlayTime(const Value: Integer);
    procedure SetWins(const Value: Word);
    function GetMaxBots: Byte;
    procedure SetMaxBots(const Value: Byte);
    function GetMissionID: Byte;
    procedure SetMissionID(const Value: Byte);
    function GetMissionsPlayed: Cardinal;
    procedure SetMissionsPlayed(const Value: Cardinal);
    function GetHighScore: Word;
    function GetMissionPoints: Word;
    function GetRobotName: string;
    procedure SetHighScore(const Value: Word);
    procedure SetMissionPoints(const Value: Word);
    procedure SetRobotName(const Value: string);
    function GetBotData: Byte;
    procedure SetBotData(const Value: Byte);
    function GetStatus: Byte;
    procedure SetStatus(const Value: Byte);
    function GetToken(index: Byte): Word;
    procedure SetToken(index: Byte; const Value: Word);
    function GetRawData(index: Byte): Byte;
    procedure SetRawData(index: Byte; const Value: Byte);
    function GetBirthDate: TDate;
    procedure SetBirthDate(const Value: TDate);
  private
    { Private declarations }
    procedure SetupForm;
    procedure ReadValues;
    procedure WriteValues;
    procedure SaveData;
    procedure LoadData;
    procedure UpdateGameDataFromRawData;
    property MotorControl : Byte read GetMotorControl write SetMotorControl;
    property Species : Byte read GetSpecies write SetSpecies;
    property LongID : Cardinal read GetLongID write SetLongID;
    property UserLevel : Byte read GetUserLevel write SetUserLevel;
    property DefaultPingRate : Byte read GetDefaultPingRate write SetDefaultPingRate;
    property Runs : Word read GetRuns write SetRuns;
    property Wins : Word read GetWins write SetWins;
    property Losses : Word read GetLosses write SetLosses;
    property Points : Word read GetPoints write SetPoints;
    property PlaySeconds : Word read GetPlaySeconds write SetPlaySeconds;
    property TotalPlayTime : Integer read GetTotalPlayTime write SetTotalPlayTime;
    property MaxBots : Byte read GetMaxBots write SetMaxBots;
    property MissionID : Byte read GetMissionID write SetMissionID;
    property MissionsPlayed : Cardinal read GetMissionsPlayed write SetMissionsPlayed;
    property MissionPoints : Word read GetMissionPoints write SetMissionPoints;
    property HighScore : Word read GetHighScore write SetHighScore;
    property RobotName : string read GetRobotName write SetRobotName;
    property BirthDate : TDate read GetBirthDate write SetBirthDate;
    property BotData : Byte read GetBotData write SetBotData;
    property Status : Byte read GetStatus write SetStatus;
    property Token[index : Byte] : Word read GetToken write SetToken;
    property RawData[index : Byte] : Byte read GetRawData write SetRawData;
  public
    { Public declarations }
  end;

var
  frmSpybotEEPROM: TfrmSpybotEEPROM;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  SysUtils, Math, uSpirit, brick_common, uLocalizedStrings;

const
  eMotorControl    = $00; //1 byte
  eSpecies         = $01; //1 byte
  eLongID          = $02; //4 bytes
  eUserLevel       = $06; //1 byte
  eDefaultPingRate = $07; //1 byte
  eRuns            = $08; //2 bytes (lo/hi)
  eWins            = $0a; //2 bytes
  eLosses          = $0c; //2 bytes
  ePoints          = $0e; //2 bytes
  ePlaySeconds     = $10; //2 bytes
  eTotalPlayTime   = $12; //4 bytes (lo..hi)
  eMaxBots         = $16; //1 byte
  eMissionID       = $17; //1 byte
  eMissionsPlayed  = $18; //4 bytes (1 bit per mission)
  eMissionPoints   = $1c; //2 bytes (lo/hi)
  eHighScore       = $1e; //2 bytes (lo/hi)
  eRobotName       = $20; //32 bytes
  eBirthDate       = $40; //6 bytes (dd/mm/yy)
  eBotData         = $46; //1 byte
  eStatus          = $47; //1 byte
  eFirstToken      = $48; //2 bytes per token (hi/lo)
  eLastToken       = $80 - 2;

const
  cMaxTokens       = 1 + (eLastToken - eFirstToken) / 2; // 28 tokens total

const
  cNormalSpeedMask = $07;
  cSlowSpeedMask   = $38;
  cLeftMotorDir    = $40;
  cRightMotorDir   = $80;

const
  cStatusInitializing = $01;
  cStatusDownloading  = $02;
  cStatusLocked       = $04;

const
  cNormalSpeeds : array[TSpybotSpecies] of Integer = (7, 7, 7, 6);
  cSlowSpeeds : array[TSpybotSpecies] of Integer = (5, 5, 4, 3);
  cMotorControlDefaults : array[TSpybotSpecies] of Integer = ($26, $e6, $1e, $15);

type
  TRawEdit = class(TEdit)
  private
    function GetValue: Byte;
    procedure SetValue(const Value: Byte);
  public
    property Value : Byte read GetValue write SetValue;
  end;

{ TRawEdit }

function TRawEdit.GetValue: Byte;
begin
  Result := StrToIntDef(Text, 0);
end;

procedure TRawEdit.SetValue(const Value: Byte);
begin
  Text := IntToStr(Value);
end;

{ TfrmSpybotEEPROM }

procedure TfrmSpybotEEPROM.FormCreate(Sender: TObject);
begin
  SetupForm;
end;

procedure TfrmSpybotEEPROM.SetupForm;
var
  scale_amount : double;
  R : TEdit;
  CB : TCheckBox;
  L : TLabel;
  E : TBricxCCSpinEdit;
  i : Integer;
begin
  scale_amount := Screen.PixelsPerInch / 96;
  for i := 0 to 31 do begin
    CB := TCheckBox.Create(Self);
    with CB do
    begin
      Name     := Format('chkMission_%2.2d', [i]);
      Parent   := grpMissionsPlayed;
      Left     := Trunc(8 + (40 * (i div 16)) * scale_amount);
      Top      := Trunc(16 + (i * 16) - (256 * (i div 16)) * scale_amount);
      Width    := Trunc(36 * scale_amount);
      Height   := Trunc(17 * scale_amount);
      Caption  := Format('%2.2d', [i+1]);
      TabOrder := i;
      Tag      := eMissionsPlayed;
      OnClick  := UpdateRawData;
    end;
  end;
  for i := 0 to 27 do begin
    L := TLabel.Create(Self);
    with L do
    begin
      Name    := Format('lblToken_%2.2d', [i]);
      Parent  := grpTokens;
      Left    := Trunc(6 + 114 * (i div 10) * scale_amount);
      Top     := Trunc(24 + (i*24) - (240 * (i div 10)) * scale_amount);
      Width   := Trunc(23 * scale_amount);
      Height  := Trunc(13 * scale_amount);
      Caption := Format('0x%2.2x', [eFirstToken + 2*i]);
    end;
    E := TBricxCCSpinEdit.Create(Self);
    with E do
    begin
      Name      := Format('edtToken_%2.2d', [i]);
      Parent    := grpTokens;
      Left      := Trunc(36 + 114 * (i div 10) * scale_amount);
      Top       := Trunc(19 + (i*24) - (240 * (i div 10)) * scale_amount);
      Width     := Trunc(58 * scale_amount);
      Height    := Trunc(22 * scale_amount);
      MaxLength := 5;
      MaxValue  := 65535;
      MinValue  := 0;
      TabOrder  := i;
      Value     := 0;
      Tag       := i;
      OnChange  := UpdateTokenRawData;
    end;
  end;
  for i := 0 to 255 do begin
    R := TEdit.Create(Self);
    with R do
    begin
      Name       := Format('edtRaw_%2.2d', [i]);
      Parent     := shtRawData;
      Left       := Trunc(16 + (i*26) - (416 * (i div 16)) * scale_amount);
      Top        := Trunc(16 + 20 * (i div 16) * scale_amount);
      Width      := Trunc(22 * scale_amount);
      Height     := Trunc(16 * scale_amount);
      Font.Name  := 'Arial';
      Font.Size  := 6;
      MaxLength  := 3;
      ParentFont := False;
      TabOrder   := i;
      Text       := '0';
      Tag        := i;
      OnKeyPress := RawKeyPress;
    end;
  end;
  // set initial tab sheets
  pagMain.ActivePage      := shtGameItems;
  pagGameItems.ActivePage := shtGame1;
end;

procedure TfrmSpybotEEPROM.btnWriteClick(Sender: TObject);
begin
  if MessageDlg(sConfirmEEPROMWrite, mtConfirmation,
                [mbOK,mbCancel], 0) = mrOk then
    WriteValues;
end;

procedure TfrmSpybotEEPROM.btnReadClick(Sender: TObject);
begin
  ReadValues;
end;

procedure TfrmSpybotEEPROM.btnSaveClick(Sender: TObject);
begin
  SaveData;
end;

procedure TfrmSpybotEEPROM.btnLoadClick(Sender: TObject);
begin
  LoadData;
end;

procedure TfrmSpybotEEPROM.ReadValues;
var
  i, j : Integer;
  block : EEPROMBlock;
begin
  Screen.Cursor := crHourGlass;
  try
    for i := 0 to 15 do begin
      block := BrickComm.EEPROMBlock[i];
      for j := 0 to 15 do
        RawData[i*16+j] := block.Data[j];
    end;
    UpdateGameDataFromRawData;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TfrmSpybotEEPROM.GetSpecies: Byte;
begin
  Result := cboSpecies.ItemIndex + 1;
end;

procedure TfrmSpybotEEPROM.SetSpecies(const Value: Byte);
begin
  cboSpecies.ItemIndex := Value - 1;
end;

function TfrmSpybotEEPROM.GetLongID: Cardinal;
begin
  Result := Cardinal(edtLongID.Value);
end;

procedure TfrmSpybotEEPROM.SetLongID(const Value: Cardinal);
begin
  edtLongID.Value := Integer(Value);
end;

function TfrmSpybotEEPROM.GetDefaultPingRate: Byte;
begin
  Result := edtDefaultPingRate.Value;
end;

procedure TfrmSpybotEEPROM.SetDefaultPingRate(const Value: Byte);
begin
  edtDefaultPingRate.Value := Value;
end;

function TfrmSpybotEEPROM.GetUserLevel: Byte;
begin
  Result := edtUserLevel.Value;
end;

procedure TfrmSpybotEEPROM.SetUserLevel(const Value: Byte);
begin
  edtUserLevel.Value := Value;
end;

function TfrmSpybotEEPROM.GetLosses: Word;
begin
  Result := edtLosses.Value;
end;

function TfrmSpybotEEPROM.GetPlaySeconds: Word;
begin
  Result := edtPlaySeconds.Value;
end;

function TfrmSpybotEEPROM.GetPoints: Word;
begin
  Result := edtPoints.Value;
end;

function TfrmSpybotEEPROM.GetRuns: Word;
begin
  Result := edtRuns.Value;
end;

function TfrmSpybotEEPROM.GetTotalPlayTime: Integer;
begin
  Result := edtTotalPlayTime.Value;
end;

function TfrmSpybotEEPROM.GetWins: Word;
begin
  Result := edtWins.Value;
end;

procedure TfrmSpybotEEPROM.SetLosses(const Value: Word);
begin
  edtLosses.Value := Value;
end;

procedure TfrmSpybotEEPROM.SetPlaySeconds(const Value: Word);
begin
  edtPlaySeconds.Value := Value;
end;

procedure TfrmSpybotEEPROM.SetPoints(const Value: Word);
begin
  edtPoints.Value := Value;
end;

procedure TfrmSpybotEEPROM.SetRuns(const Value: Word);
begin
  edtRuns.Value := Value;
end;

procedure TfrmSpybotEEPROM.SetTotalPlayTime(const Value: Integer);
begin
  edtTotalPlayTime.Value := Value;
end;

procedure TfrmSpybotEEPROM.SetWins(const Value: Word);
begin
  edtWins.Value := Value;
end;

function TfrmSpybotEEPROM.GetMaxBots: Byte;
begin
  Result := edtMaxBots.Value;
end;

procedure TfrmSpybotEEPROM.SetMaxBots(const Value: Byte);
begin
  edtMaxBots.Value := Value;
end;

function TfrmSpybotEEPROM.GetMissionID: Byte;
begin
  Result := edtMissionID.Value;
end;

procedure TfrmSpybotEEPROM.SetMissionID(const Value: Byte);
begin
  edtMissionID.Value := Value;
end;

function TfrmSpybotEEPROM.GetHighScore: Word;
begin
  Result := edtHighScore.Value;
end;

function TfrmSpybotEEPROM.GetMissionPoints: Word;
begin
  Result := edtMissionPoints.Value;
end;

function TfrmSpybotEEPROM.GetRobotName: string;
begin
  Result := edtRobotName.Text;
end;

procedure TfrmSpybotEEPROM.SetHighScore(const Value: Word);
begin
  edtHighScore.Value := Value;
end;

procedure TfrmSpybotEEPROM.SetMissionPoints(const Value: Word);
begin
  edtMissionPoints.Value := Value;
end;

procedure TfrmSpybotEEPROM.SetRobotName(const Value: string);
begin
  edtRobotName.Text := Value;
end;

function TfrmSpybotEEPROM.GetBotData: Byte;
begin
  Result := edtBotData.Value;
end;

procedure TfrmSpybotEEPROM.SetBotData(const Value: Byte);
begin
  edtBotData.Value := Value;
end;

function TfrmSpybotEEPROM.GetStatus: Byte;
begin
  Result := edtStatus.Value;
end;

procedure TfrmSpybotEEPROM.SetStatus(const Value: Byte);
begin
  edtStatus.Value := Value;
end;

function TfrmSpybotEEPROM.GetToken(index: Byte): Word;
var
  E : TBricxCCSpinEdit;
begin
  E := TBricxCCSpinEdit(grpTokens.FindChildControl(Format('edtToken_%2.2d', [index])));
  if Assigned(E) then
    Result := E.Value
  else
    Result := 0;
end;

procedure TfrmSpybotEEPROM.SetToken(index: Byte; const Value: Word);
var
  E : TBricxCCSpinEdit;
begin
  E := TBricxCCSpinEdit(grpTokens.FindChildControl(Format('edtToken_%2.2d', [index])));
  if Assigned(E) then
    E.Value := Value;
end;

function TfrmSpybotEEPROM.GetMotorControl: Byte;
begin
  Result := ((edtMCNormal.Value - 1) and cNormalSpeedMask) +
            (((edtMCSlow.Value - 1) shl 3) and cSlowSpeedMask);
  if radLeftFwd.Checked then Result := Result or cLeftMotorDir;
  if radRightFwd.Checked then Result := Result or cRightMotorDir;
end;

procedure TfrmSpybotEEPROM.SetMotorControl(const Value: Byte);
begin
  edtMCNormal.Value   := (Value and cNormalSpeedMask) + 1;
  edtMCSlow.Value     := ((Value and cSlowSpeedMask) shr 3) + 1;
  radLeftFwd.Checked  := (Value and cLeftMotorDir) = cLeftMotorDir;
  radLeftRev.Checked  := (Value and cLeftMotorDir) = 0;
  radRightFwd.Checked := (Value and cRightMotorDir) = cRightMotorDir;
  radRightRev.Checked := (Value and cRightMotorDir) = 0;
end;

function TfrmSpybotEEPROM.GetMissionsPlayed: Cardinal;
var
  i : Integer;
  C : TCheckBox;
begin
  Result := 0;
  for i := 0 to 31 do begin
    C := TCheckBox(grpMissionsPlayed.FindChildControl(Format('chkMission_%2.2d', [i])));
    if Assigned(C) then
    begin
      if C.Checked then
        Result := Result or (Cardinal(1) shl i);
    end;
  end;
end;

procedure TfrmSpybotEEPROM.SetMissionsPlayed(const Value: Cardinal);
var
  i : Integer;
  C : TCheckBox;
begin
  for i := 0 to 31 do begin
    C := TCheckBox(grpMissionsPlayed.FindChildControl(Format('chkMission_%2.2d', [i])));
    if Assigned(C) then
      C.Checked := (Value and (Cardinal(1) shl i)) = (Cardinal(1) shl i);
  end;
end;

procedure TfrmSpybotEEPROM.RawKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, #16, '0'..'9']) then
    Key := #0;
end;

function TfrmSpybotEEPROM.GetRawData(index: Byte): Byte;
var
  E : TRawEdit;
begin
  E := TRawEdit(shtRawData.FindChildControl(Format('edtRaw_%2.2d', [index])));
  if Assigned(E) then
    Result := E.Value
  else
    Result := 0;
end;

procedure TfrmSpybotEEPROM.SetRawData(index: Byte; const Value: Byte);
var
  E : TRawEdit;
begin
  E := TRawEdit(shtRawData.FindChildControl(Format('edtRaw_%2.2d', [index])));
  if Assigned(E) then
    E.Value := Value;
end;

procedure TfrmSpybotEEPROM.WriteValues;
var
  i : Integer;
begin
  Screen.Cursor := crHourGlass;
  try
    for i := 0 to 255 do begin
      BrickComm.EEPROM[i] := RawData[i];
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function WordFromBytes(h, l : Byte) : Word;
begin
  Result := (Cardinal(h) shl 8) or Cardinal(l);
end;

function DWordFromBytes(b1, b2, b3, b4 : Byte) : Cardinal;
begin
  Result := (Cardinal(b4) shl 24) or (Cardinal(b3) shl 16) or
            (Cardinal(b2) shl  8) or (Cardinal(b1));
end;

procedure TfrmSpybotEEPROM.UpdateGameDataFromRawData;
var
  dd, mm, yy : Word;
  i : Integer;
  nameBuf : array[0..32] of Char;
begin
  MotorControl := RawData[eMotorControl];
  Species      := RawData[eSpecies];
  LongID       := DWordFromBytes(RawData[eLongID+0],
                                 RawData[eLongID+1],
                                 RawData[eLongID+2],
                                 RawData[eLongID+3]);
  UserLevel       := RawData[eUserLevel];
  DefaultPingRate := RawData[eDefaultPingRate];
  Runs            := WordFromBytes(RawData[eRuns+1], RawData[eRuns]);
  Wins            := WordFromBytes(RawData[eWins+1], RawData[eWins]);
  Losses          := WordFromBytes(RawData[eLosses+1], RawData[eLosses]);
  Points          := WordFromBytes(RawData[ePoints+1], RawData[ePoints]);
  PlaySeconds     := WordFromBytes(RawData[ePlaySeconds+1], RawData[ePlaySeconds]);
  TotalPlayTime   := DWordFromBytes(RawData[eTotalPlayTime+0],
                                    RawData[eTotalPlayTime+1],
                                    RawData[eTotalPlayTime+2],
                                    RawData[eTotalPlayTime+3]);
  MaxBots       := RawData[eMaxBots];
  MissionID     := RawData[eMissionID];
  MissionPoints := WordFromBytes(RawData[eMissionPoints+1], RawData[eMissionPoints]);
  HighScore     := WordFromBytes(RawData[eHighScore+1], RawData[eHighScore]);
  for i := 0 to 31 do begin
    nameBuf[i] := Char(RawData[eRobotName+i]);
  end;
  nameBuf[32] := #0;
  RobotName   := nameBuf;
  // calculate dd, mm, and yy portions of date
  dd := Min(Min(RawData[eBirthDate+0], 3) * 10 + Min(RawData[eBirthDate+1], 9), 31);
  mm := Min(Min(RawData[eBirthDate+2], 1) * 10 + Min(RawData[eBirthDate+3], 9), 12);
  yy := Min(Min(RawData[eBirthDate+4], 9) * 10 + Min(RawData[eBirthDate+5], 9), 99);
  if yy < 80 then yy := 2000 + yy else yy := 1900 + yy;
  if mm < 1  then mm := 1;
  if dd < 1  then dd := 1;
  BirthDate := EncodeDate(yy, mm, dd);
  BotData   := RawData[eBotData];
  Status    := RawData[eStatus];
  MissionsPlayed := DWordFromBytes(RawData[eMissionsPlayed+0],
                                   RawData[eMissionsPlayed+1],
                                   RawData[eMissionsPlayed+2],
                                   RawData[eMissionsPlayed+3]);
  for i := 0 to 27 do begin
    Token[i] := WordFromBytes(RawData[eFirstToken+(i*2)], RawData[eFirstToken+(i*2)+1]);
  end;
end;

procedure TfrmSpybotEEPROM.pagMainChange(Sender: TObject);
begin
  if pagMain.ActivePage = shtGameItems then
    UpdateGameDataFromRawData;
end;

procedure TfrmSpybotEEPROM.LoadData;
var
  SL : TStringList;
  i : Integer;
  b : Byte;
begin
  if dlgOpen.Execute then begin
    SL := TStringList.Create;
    try
      SL.LoadFromFile(dlgOpen.FileName);
      if SL.Count <> 256 then begin
        MessageDlg(sEEPROMLoadError, mtError, [mbOK], 0);
        Exit;
      end;
      for i := 0 to SL.Count - 1 do begin
        b := StrToIntDef(SL[i], 0);
        RawData[i] := b;
      end;
      UpdateGameDataFromRawData;
    finally
      SL.Free;
    end;
  end;
end;

procedure TfrmSpybotEEPROM.SaveData;
var
  SL : TStringList;
  i : Integer;
begin
  if dlgSave.Execute then begin
    // save data from RawData[i]
    SL := TStringList.Create;
    try
      for i := 0 to 255 do begin
        SL.Add(IntToStr(RawData[i]));
      end;
      SL.SaveToFile(dlgSave.FileName);
    finally
      SL.Free;
    end;
  end;
end;

procedure TfrmSpybotEEPROM.UpdateTokenRawData(Sender: TObject);
var
  E : TBricxCCSpinEdit;
  i : Integer;
begin
  if Sender is TBricxCCSpinEdit then
  begin
    E := TBricxCCSpinEdit(Sender);
    i := E.Tag;
    RawData[eFirstToken+(i*2)+1] := E.Value and $FF; // lo byte
    RawData[eFirstToken+(i*2)+0] := E.Value shr 8;   // hi byte
  end;
end;

procedure TfrmSpybotEEPROM.UpdateRawData(Sender: TObject);
var
  Value : Cardinal;
  i : Integer;
  name : string[32];
  d, m, y : word;
begin
  case TControl(Sender).Tag of
    eMotorControl : RawData[eMotorControl] := MotorControl;
    eSpecies : RawData[eSpecies] := Species;
    eUserLevel : RawData[eUserLevel] := UserLevel;
    eDefaultPingRate : RawData[eDefaultPingRate] := DefaultPingRate;
    eMaxBots : RawData[eMaxBots] := MaxBots;
    eMissionID : RawData[eMissionID] := MissionID;
    eBotData : RawData[eBotData] := BotData;
    eStatus : RawData[eStatus] := Status;
    eRuns : begin
      RawData[eRuns+0] := Runs and $FF;
      RawData[eRuns+1] := Runs shr 8;
    end;
    eWins : begin
      RawData[eWins+0] := Wins and $FF;
      RawData[eWins+1] := Wins shr 8;
    end;
    eLosses : begin
      RawData[eLosses+0] := Losses and $FF;
      RawData[eLosses+1] := Losses shr 8;
    end;
    ePoints : begin
      RawData[ePoints+0] := Points and $FF;
      RawData[ePoints+1] := Points shr 8;
    end;
    ePlaySeconds : begin
      RawData[ePlaySeconds+0] := PlaySeconds and $FF;
      RawData[ePlaySeconds+1] := PlaySeconds shr 8;
    end;
    eMissionPoints : begin
      RawData[eMissionPoints+0] := MissionPoints and $FF;
      RawData[eMissionPoints+1] := MissionPoints shr 8;
    end;
    eHighScore : begin
      RawData[eHighScore+0] := HighScore and $FF;
      RawData[eHighScore+1] := HighScore shr 8;
    end;
    eLongID : begin
      Value := LongID;
      RawData[eLongID+0] := Value and $FF;
      RawData[eLongID+1] := (Value shr  8) and $FF;
      RawData[eLongID+2] := (Value shr 16) and $FF;
      RawData[eLongID+3] := (Value shr 24) and $FF;
    end;
    eMissionsPlayed : begin
      Value := MissionsPlayed;
      RawData[eMissionsPlayed+0] := Value and $FF;
      RawData[eMissionsPlayed+1] := (Value shr  8) and $FF;
      RawData[eMissionsPlayed+2] := (Value shr 16) and $FF;
      RawData[eMissionsPlayed+3] := (Value shr 24) and $FF;
    end;
    eTotalPlayTime : begin
      Value := TotalPlayTime;
      RawData[eTotalPlayTime+0] := Value and $FF;
      RawData[eTotalPlayTime+1] := (Value shr  8) and $FF;
      RawData[eTotalPlayTime+2] := (Value shr 16) and $FF;
      RawData[eTotalPlayTime+3] := (Value shr 24) and $FF;
    end;
    eRobotName : begin
      name := RobotName;
      for i := 0 to 31 do begin
        if (i+1) <= Length(name) then
          RawData[eRobotName+i] := Ord(name[i+1])
        else
          RawData[eRobotName+i] := 0;
      end;
    end;
    eBirthDate : begin
      DecodeDate(BirthDate, y, m, d);
      // is the year stored as just 2 digits (yy)???
      y := y mod 100;
      RawData[eBirthDate+0] := d div 10;
      RawData[eBirthDate+1] := d mod 10;
      RawData[eBirthDate+2] := m div 10;
      RawData[eBirthDate+3] := m mod 10;
      RawData[eBirthDate+4] := y div 10;
      RawData[eBirthDate+5] := y mod 10;
    end;
  end;
end;

function TfrmSpybotEEPROM.GetBirthDate: TDate;
begin
{$IFNDEF FPC}
  Result := dtpBirthdate.Date;
{$ELSE}
  Result := Now;
{$ENDIF}
end;

procedure TfrmSpybotEEPROM.SetBirthDate(const Value: TDate);
begin
{$IFNDEF FPC}
  dtpBirthdate.Date := Value;
{$ENDIF}
end;

procedure TfrmSpybotEEPROM.btnBlockReadClick(Sender: TObject);
var
  i, j : Integer;
  block : EEPROMBlock;
  s, c : integer;
  tmp : string;
begin
  Screen.Cursor := crHourGlass;
  try
    s := Min(edtBlock.Value, 255);
    c := Min(edtBlockCount.Value, 256-s);
    for i := s to s+c-1 do begin
      block := BrickComm.EEPROMBlock[i];
      tmp := Format('%3.3d 0x%4.4x: ', [i, i*16]);
      for j := 0 to 15 do
        tmp := tmp + Format('%2.2x ', [block.Data[j]]);
      edtData.Lines.Add(tmp);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmSpybotEEPROM.btnBlockClearClick(Sender: TObject);
begin
  edtData.Clear;
end;

procedure TfrmSpybotEEPROM.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

{$IFDEF FPC}
initialization
  {$i uEEPROM.lrs}
{$ENDIF}

end.
