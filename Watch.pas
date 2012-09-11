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
unit Watch;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
  LCLIntf,
{$ENDIF}
  Classes, Controls, Forms, StdCtrls, ExtCtrls, Buttons, ComCtrls,
{$IFNDEF FPC}
{$IFNDEF NXT_ONLY}
  DataAnalysis,
{$ENDIF}
{$ENDIF}
  uSpirit, uProgram, BricxccSpin, Dialogs, Menus;

type
  TVarControls = record
    CheckBox : TCheckBox;
    Edit : TEdit;
  end;

  TWatchForm = class(TForm)
    Timer1: TTimer;
    pagWatch: TPageControl;
    shtNXT: TTabSheet;
    shtCommon: TTabSheet;
    shtCybermaster: TTabSheet;
    grpVar: TGroupBox;
    VVar0: TEdit;
    CVar0: TCheckBox;
    CVar1: TCheckBox;
    VVar1: TEdit;
    CVar2: TCheckBox;
    VVar2: TEdit;
    VVar3: TEdit;
    CVar3: TCheckBox;
    CVar4: TCheckBox;
    VVar4: TEdit;
    CVar5: TCheckBox;
    VVar5: TEdit;
    VVar6: TEdit;
    CVar6: TCheckBox;
    CVar7: TCheckBox;
    VVar7: TEdit;
    CVar8: TCheckBox;
    VVar8: TEdit;
    VVar9: TEdit;
    CVar9: TCheckBox;
    CVar10: TCheckBox;
    VVar10: TEdit;
    CVar11: TCheckBox;
    VVar11: TEdit;
    VVar12: TEdit;
    CVar12: TCheckBox;
    CVar13: TCheckBox;
    VVar13: TEdit;
    CVar14: TCheckBox;
    VVar14: TEdit;
    VVar15: TEdit;
    CVar15: TCheckBox;
    VVar16: TEdit;
    CVar16: TCheckBox;
    CVar17: TCheckBox;
    VVar17: TEdit;
    CVar18: TCheckBox;
    VVar18: TEdit;
    VVar19: TEdit;
    CVar19: TCheckBox;
    CVar20: TCheckBox;
    VVar20: TEdit;
    CVar21: TCheckBox;
    VVar21: TEdit;
    VVar22: TEdit;
    CVar22: TCheckBox;
    CVar23: TCheckBox;
    VVar23: TEdit;
    VVar24: TEdit;
    CVar24: TCheckBox;
    CVar25: TCheckBox;
    VVar25: TEdit;
    CVar26: TCheckBox;
    VVar26: TEdit;
    VVar27: TEdit;
    CVar27: TCheckBox;
    CVar28: TCheckBox;
    VVar28: TEdit;
    CVar29: TCheckBox;
    VVar29: TEdit;
    VVar30: TEdit;
    CVar30: TCheckBox;
    CVar31: TCheckBox;
    VVar31: TEdit;
    grpMotor: TGroupBox;
    CheckMotorA: TCheckBox;
    ValueMotorA: TEdit;
    CheckMotorB: TCheckBox;
    ValueMotorB: TEdit;
    CheckMotorC: TCheckBox;
    ValueMotorC: TEdit;
    grpSensor: TGroupBox;
    CheckSensor1: TCheckBox;
    ValueSensor1: TEdit;
    CheckSensor2: TCheckBox;
    ValueSensor2: TEdit;
    CheckSensor3: TCheckBox;
    ValueSensor3: TEdit;
    ValueSensor4: TEdit;
    CheckSensor4: TCheckBox;
    grpTimer: TGroupBox;
    CheckTimer0: TCheckBox;
    ValueTimer0: TEdit;
    CheckTimer1: TCheckBox;
    ValueTImer1: TEdit;
    CheckTimer2: TCheckBox;
    ValueTimer2: TEdit;
    ValueTimer3: TEdit;
    CheckTimer3: TCheckBox;
    grpTacho: TGroupBox;
    CheckTCounterL: TCheckBox;
    ValueTCounterL: TEdit;
    CheckTSpeedR: TCheckBox;
    ValueTSpeedR: TEdit;
    CheckMCurrent: TCheckBox;
    ValueMCurrent: TEdit;
    ValueTCounterR: TEdit;
    CheckTCounterR: TCheckBox;
    ValueTSpeedL: TEdit;
    CheckTSpeedL: TCheckBox;
    grpCounter: TGroupBox;
    CheckCounter0: TCheckBox;
    ValueCounter0: TEdit;
    CheckCounter1: TCheckBox;
    ValueCounter1: TEdit;
    CheckCounter2: TCheckBox;
    ValueCounter2: TEdit;
    grpMessage: TGroupBox;
    CheckMessage: TCheckBox;
    ValueMessage: TEdit;
    Panel1: TPanel;
    btnPollRegular: TSpeedButton;
    btnGraph: TSpeedButton;
    btnPollNow: TButton;
    btnCheckAll: TButton;
    btnCheckNone: TButton;
    cboTimes: TComboBox;
    chkIfActive: TCheckBox;
    chkSyncSeries: TCheckBox;
    btnClear: TButton;
    btnHelp: TButton;
    grpNXTMotors: TGroupBox;
    chkPortA: TCheckBox;
    edtPAPower: TEdit;
    chkPortB: TCheckBox;
    edtPBPower: TEdit;
    chkPortC: TCheckBox;
    edtPCPower: TEdit;
    edtPAMode: TEdit;
    edtPBMode: TEdit;
    edtPCMode: TEdit;
    edtPARegMode: TEdit;
    edtPBRegMode: TEdit;
    edtPCRegMode: TEdit;
    edtPATurnRatio: TEdit;
    edtPBTurnRatio: TEdit;
    edtPCTurnRatio: TEdit;
    edtPARunState: TEdit;
    edtPBRunState: TEdit;
    edtPCRunState: TEdit;
    edtPATachoLimit: TEdit;
    edtPBTachoLimit: TEdit;
    edtPCTachoLimit: TEdit;
    edtPATachoCount: TEdit;
    edtPBTachoCount: TEdit;
    edtPCTachoCount: TEdit;
    edtPABlockTachoCount: TEdit;
    edtPBBlockTachoCount: TEdit;
    edtPCBlockTachoCount: TEdit;
    edtPARotationCount: TEdit;
    edtPBRotationCount: TEdit;
    edtPCRotationCount: TEdit;
    chkNXTPower: TCheckBox;
    chkNXTMode: TCheckBox;
    chkNXTRegMode: TCheckBox;
    chkNXTTurnRatio: TCheckBox;
    chkNXTRunState: TCheckBox;
    chkNXTTachoLimit: TCheckBox;
    chkNXTTachoCount: TCheckBox;
    chkNXTBlockTachoCount: TCheckBox;
    chkNXTRotationCount: TCheckBox;
    menuPopup: TPopupMenu;
    dlgOpen: TOpenDialog;
    mniOpenSym: TMenuItem;
    shtNXTMailboxes: TTabSheet;
    grpNXTMailboxes: TGroupBox;
    chkResponseMB: TCheckBox;
    chkNXTMB1: TCheckBox;
    chkNXTMB2: TCheckBox;
    chkNXTMB3: TCheckBox;
    chkNXTMB4: TCheckBox;
    chkNXTMB5: TCheckBox;
    chkNXTMB6: TCheckBox;
    chkNXTMB7: TCheckBox;
    chkNXTMB8: TCheckBox;
    chkNXTMB9: TCheckBox;
    chkNXTMB10: TCheckBox;
    edtNXTMB1: TEdit;
    edtNXTMB2: TEdit;
    edtNXTMB3: TEdit;
    edtNXTMB4: TEdit;
    edtNXTMB5: TEdit;
    edtNXTMB6: TEdit;
    edtNXTMB7: TEdit;
    edtNXTMB8: TEdit;
    edtNXTMB9: TEdit;
    edtNXTMB10: TEdit;
    shtNXTI2C: TTabSheet;
    grpI2C: TGroupBox;
    lblI2CPort: TLabel;
    lblI2CResponse: TLabel;
    lblI2CUltra: TLabel;
    lblI2CBuffer: TLabel;
    lblI2CLen: TLabel;
    chkI2C1: TCheckBox;
    edtI2CVal1: TEdit;
    chkI2C2: TCheckBox;
    edtI2CVal2: TEdit;
    chkI2C3: TCheckBox;
    edtI2CVal3: TEdit;
    edtI2CVal4: TEdit;
    chkI2C4: TCheckBox;
    chkUltra1: TCheckBox;
    chkUltra2: TCheckBox;
    chkUltra3: TCheckBox;
    chkUltra4: TCheckBox;
    edtI2CBuf1: TEdit;
    edtI2CBuf2: TEdit;
    edtI2CBuf3: TEdit;
    edtI2CBuf4: TEdit;
    edtI2CLen1: TBricxccSpinEdit;
    edtI2CLen2: TBricxccSpinEdit;
    edtI2CLen4: TBricxccSpinEdit;
    edtI2CLen3: TBricxccSpinEdit;
    grpPI2C: TGroupBox;
    lblPPort: TLabel;
    chkPI2C1: TCheckBox;
    chkPI2C2: TCheckBox;
    chkPI2C3: TCheckBox;
    chkPI2C4: TCheckBox;
    cboPI2CType1: TComboBox;
    lblPType: TLabel;
    lblPResponse: TLabel;
    edtPI2CVal1: TEdit;
    cboPI2CType2: TComboBox;
    edtPI2CVal2: TEdit;
    cboPI2CType3: TComboBox;
    edtPI2CVal3: TEdit;
    cboPI2CType4: TComboBox;
    edtPI2CVal4: TEdit;
    btnConfigI2CTypes: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPollNowClick(Sender: TObject);
    procedure btnCheckAllClick(Sender: TObject);
    procedure btnCheckNoneClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnPollRegularClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboTimesChange(Sender: TObject);
    procedure btnGraphClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure chkUltra1Click(Sender: TObject);
    procedure chkUltra2Click(Sender: TObject);
    procedure chkUltra3Click(Sender: TObject);
    procedure chkUltra4Click(Sender: TObject);
    procedure mniOpenSymClick(Sender: TObject);
    procedure btnConfigI2CTypesClick(Sender: TObject);
  private
    { Private declarations }
{$IFNDEF FPC}
{$IFNDEF NXT_ONLY}
    fGraph : TfrmDataAnalysis;
{$ENDIF}
{$ENDIF}
    fNewData : TStrings;
    fVarArray : array[0..31] of TVarControls;
    fWatchedProgram : TProgram;
    fOldProgram : TProgram;
    procedure RestoreSettings;
    procedure SaveSettings;
    procedure UpdateGraph;
    procedure PopulateVarArray;
    procedure LoadI2CTypes;
    procedure ProcessI2C(port: byte; edtLen: TBricxCCSpinEdit; edtBuf, edtVal: TEdit);
    procedure PollProcessedI2C(port : byte; pitype : integer; edtVal: TEdit);
    procedure LoadWatchedProgram;
    function IndexToID(const idx : integer) : integer;
    procedure SetVariableHints;
    procedure PollMessage(num: byte; edtValue: TEdit);
    procedure ConfigureRawI2C(chk: TCheckBox; edtBuf : TEdit; edtLen : TBricxCCSpinEdit);
  public
    { Public declarations }
    procedure GraphDestroyed;
  end;

var
  WatchForm: TWatchForm;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  SysUtils, Variants, brick_common, rcx_constants,
  uLocalizedStrings, uGuiUtils, uBasicPrefs, uEditorUtils,
  uGlobals, uMiscDefines, uCommonUtils, uNXTConstants, uWatchGlobals,
  uVTConfig;

function GetMotorData(numb : integer) : string;
var
  ttt : integer;
  str : string;
begin
  ttt := BrickComm.GetOutputStatus(numb);
  str := '';
  // is bit 7 set (On|Off)
  if (ttt div 128) = 1 then
    str := str + ' On '
  else
    str := str + 'Off ';
  // is bit 6 set (Brake|Float)
  if ((ttt mod 128) div 64) = 1 then
    str := str + 'Brake '
  else
    str := str + 'Float ';
  // is bit 3 set (Brake|Float)
  if ((ttt mod 16) div 8) = 1 then
    str := str + 'Fwd '
  else
    str := str + 'Rev ';
  // power level
  str:=str+Format('  %d', [ttt mod 8]);
  Result := str;
end;

var busy:boolean = false;

procedure TWatchForm.PollMessage(num : byte; edtValue : TEdit);
var
  msg : NXTMessage;
  logStr, valStr : string;
  bIsNumeric : boolean;
  j, val : integer;
begin
  if chkResponseMB.Checked then
    num := num + 10;
  if BrickComm.NXTMessageRead(num, 0, true, msg) then
  begin
    if msg.Size = 0 then Exit;
    logStr := '';
    valStr := '';
    if (msg.Size = 2) and (msg.Data[0] in [0,1]) then
    begin
      logStr := Format('Mailbox %d: %d', [num+1, msg.Data[0]]);
      valStr := Format('%d', [msg.Data[0]]);
    end
    else if (msg.Size = 5) and (msg.Data[4] = 0) then
    begin
      bIsNumeric := False;
      for j := 0 to msg.Size - 2 do
      begin
        if not (Char(msg.Data[j]) in [' '..'~']) then
        begin
          bIsNumeric := True;
          break;
        end;
      end;
      if bIsNumeric then
      begin
        Move(PByte(@msg.Data[0])^, val, 4);
        logStr := Format('Mailbox %d: %d', [num+1, val]);
        valStr := Format('%d', [val]);
      end;
    end;
    if (logStr = '') and (valStr = '') then
    begin
      logStr := Format('Mailbox %d: %s', [num+1, PChar(@msg.Data[0])]);
      valStr := PChar(@msg.Data[0]);
    end;
    fNewData.Add(logStr);
    edtValue.Text := valStr;
  end;
end;

procedure TWatchForm.ProcessI2C(port : byte; edtLen : TBricxCCSpinEdit;
  edtBuf : TEdit; edtVal : TEdit);
var
  tmpStr, tmpI2CStr : string;
  LSBlock : NXTLSBlock;
  i : integer;
  addr : byte;
begin
  if edtLen.Value > 0 then
    LSBlock := BrickComm.NXTLowSpeed[port];
  tmpStr := '$' + Copy(Trim(edtBuf.Text), 1, 2);
  // first byte is address
  addr := StrToIntDef(tmpStr, 0);
  tmpStr := Trim(Copy(Trim(edtBuf.Text), 3, MaxInt));
  LoadLSBlock(LSBlock, addr, tmpStr, edtLen.Value);
  BrickComm.NXTLowSpeed[port] := LSBlock;
  if edtLen.Value > 0 then
  begin
    LSBlock := BrickComm.NXTLowSpeed[port];
    tmpI2CStr := '';
    for i := 0 to LSBlock.RXCount - 1 do
    begin
      tmpStr := Format('I2C Result %d[%d]: %d', [port+1, i, LSBlock.Data[i]]);
      fNewData.Add(tmpStr);
      tmpI2CStr := tmpI2CStr + Format('%d ', [LSBlock.Data[i]]);
    end;
    edtVal.Text := tmpI2CStr;
  end;
end;

procedure TWatchForm.btnPollNowClick(Sender: TObject);
var
  i, ival : integer;
  val : variant;
  fval : Single;
  tmpStr, tmpStr2 : string;
  power: integer;
  mode, regmode: byte;
  turnratio: integer;
  runstate: byte;
  tacholimit: cardinal;
  tachocount, blockcount, rotcount: Integer;
{  valid, calibrated: boolean;
  stype, smode: byte;
  raw, normalized: word;
  scaled, calvalue: smallint; }
begin
  if busy then exit;     // Avoid polling while polling
  busy:=true;
  try
    fNewData.Clear;
    for i := Low(fVarArray) to High(fVarArray) do
    begin
      if fVarArray[i].CheckBox.Checked then
      begin
        val := BrickComm.GetVariableValue(IndexToID(i));
        if VarType(val) in [varSingle, varDouble] then begin
          fVal := val;
          tmpStr2 := StripTrailingZeros(Format('%.4f', [fval]));
          tmpStr  := Format('Var %d: ', [i]) + tmpStr2;
        end
        else if VarType(val) = varString then
        begin
          tmpStr2 := val;
          tmpStr := Format('Var %d: ', [i]) + tmpStr2;
        end
        else begin
          // assuming a variant of integer type
          ival := val;
          tmpStr  := Format('Var %d: %d', [i, ival]);
          tmpStr2 := Format('%6d',[ival]);
        end;
        fNewData.Add(tmpStr);
        fVarArray[i].Edit.Text := tmpStr2;
      end;
    end;
    if CheckSensor1.Checked then
    begin
      ival := BrickComm.GetInputValue(0);
      tmpStr := Format('Sensor %d: %d', [1, ival]);
      fNewData.Add(tmpStr);
      ValueSensor1.Text := Format('%6d',[ival]);
    end;
    if CheckSensor2.Checked then
    begin
      ival := BrickComm.GetInputValue(1);
      tmpStr := Format('Sensor %d: %d', [2, ival]);
      fNewData.Add(tmpStr);
      ValueSensor2.Text := Format('%6d',[ival]);
    end;
    if CheckSensor3.Checked then
    begin
      ival := BrickComm.GetInputValue(2);
      tmpStr := Format('Sensor %d: %d', [3, ival]);
      fNewData.Add(tmpStr);
      ValueSensor3.Text := Format('%6d',[ival]);
    end;
    if IsNXT and CheckSensor4.Checked then
    begin
      ival := BrickComm.GetInputValue(3);
      tmpStr := Format('Sensor %d: %d', [4, ival]);
      fNewData.Add(tmpStr);
      ValueSensor4.Text := Format('%6d',[ival]);
    end;

    if CheckMotorA.Checked then
      ValueMotorA.Text := GetMotorData(0);
    if CheckMotorB.Checked then
      ValueMotorB.Text := GetMotorData(1);
    if CheckMotorC.Checked then
      ValueMotorC.Text := GetMotorData(2);

    if CheckTimer0.Checked then
    begin
      ival := BrickComm.GetTimerValue(0);
      tmpStr := Format('Timer %d: %d', [0, ival]);
      fNewData.Add(tmpStr);
      ValueTimer0.Text := Format('%6d',[ival]);
    end;
    if CheckTimer1.Checked then
    begin
      ival := BrickComm.GetTimerValue(1);
      tmpStr := Format('Timer %d: %d', [1, ival]);
      fNewData.Add(tmpStr);
      ValueTimer1.Text := Format('%6d',[ival]);
    end;
    if CheckTimer2.Checked then
    begin
      ival := BrickComm.GetTimerValue(2);
      tmpStr := Format('Timer %d: %d', [2, ival]);
      fNewData.Add(tmpStr);
      ValueTimer2.Text := Format('%6d',[ival]);
    end;
    // timer 3 is only Cybermaster, Spybotic, RCX, & RCX2
    if CheckTimer3.Checked then
    begin
      ival := BrickComm.GetTimerValue(3);
      tmpStr := Format('Timer %d: %d', [3, ival]);
      fNewData.Add(tmpStr);
      ValueTimer3.Text := Format('%6d',[ival]);
    end;

    // counters only apply to RCX2 & Scout
    if CheckCounter0.Checked then
    begin
      ival := BrickComm.GetCounterValue(0);
      tmpStr := Format('Counter %d: %d', [0, ival]);
      fNewData.Add(tmpStr);
      ValueCounter0.Text := Format('%6d',[ival]);
    end;
    if CheckCounter1.Checked then
    begin
      ival := BrickComm.GetCounterValue(1);
      tmpStr := Format('Counter %d: %d', [1, ival]);
      fNewData.Add(tmpStr);
      ValueCounter1.Text := Format('%6d',[ival]);
    end;
    // counter 2 is only RCX2/Spybot
    if CheckCounter2.Checked then
    begin
      ival := BrickComm.GetCounterValue(2);
      tmpStr := Format('Counter %d: %d', [2, ival]);
      fNewData.Add(tmpStr);
      ValueCounter2.Text := Format('%6d',[ival]);
    end;

    // this is RCX & Scout only
    if CheckMessage.Checked then
    begin
      ival := BrickComm.GetMessageValue(0);
      tmpStr := Format('Message : %d', [ival]);
      fNewData.Add(tmpStr);
      ValueMessage.Text := Format('%6d',[ival]);
    end;

    // these only apply to NXT
    if chkPortA.Checked then
    begin
      BrickComm.GetNXTOutputState(0, power, mode, regmode, turnratio,
        runstate, tacholimit, tachocount, blockcount, rotcount);
      if chkNXTPower.Checked then
      begin
        tmpStr := Format('Power A: %d', [power]);
        fNewData.Add(tmpStr);
        edtPAPower.Text := Format('%d', [power]);
      end;
      if chkNXTMode.Checked then
      begin
        tmpStr := Format('Mode A: %d', [mode]);
        fNewData.Add(tmpStr);
        edtPAMode.Text := Format('%d', [mode]);
      end;
      if chkNXTRegMode.Checked then
      begin
        tmpStr := Format('RegMode A: %d', [regmode]);
        fNewData.Add(tmpStr);
        edtPARegMode.Text := Format('%d', [regmode]);
      end;
      if chkNXTTurnRatio.Checked then
      begin
        tmpStr := Format('TurnRatio A: %d', [turnratio]);
        fNewData.Add(tmpStr);
        edtPATurnRatio.Text := Format('%d', [turnratio]);
      end;
      if chkNXTRunState.Checked then
      begin
        tmpStr := Format('RunState A: %d', [runstate]);
        fNewData.Add(tmpStr);
        edtPARunState.Text := Format('%d', [runstate]);
      end;
      if chkNXTTachoLimit.Checked then
      begin
        tmpStr := Format('TachoLimit A: %d', [tacholimit]);
        fNewData.Add(tmpStr);
        edtPATachoLimit.Text := Format('%d', [tacholimit]);
      end;
      if chkNXTTachoCount.Checked then
      begin
        tmpStr := Format('Tacho A: %d', [tachocount]);
        fNewData.Add(tmpStr);
        edtPATachoCount.Text := Format('%d', [tachocount]);
      end;
      if chkNXTBlockTachoCount.Checked then
      begin
        tmpStr := Format('BlockTacho A: %d', [blockcount]);
        fNewData.Add(tmpStr);
        edtPABlockTachoCount.Text := Format('%d', [blockcount]);
      end;
      if chkNXTRotationCount.Checked then
      begin
        tmpStr := Format('Rotation A: %d', [rotcount]);
        fNewData.Add(tmpStr);
        edtPARotationCount.Text := Format('%d', [rotcount]);
      end;
    end;
    if chkPortB.Checked then
    begin
      BrickComm.GetNXTOutputState(1, power, mode, regmode, turnratio,
        runstate, tacholimit, tachocount, blockcount, rotcount);
      if chkNXTPower.Checked then
      begin
        tmpStr := Format('Power B: %d', [power]);
        fNewData.Add(tmpStr);
        edtPBPower.Text := Format('%d', [power]);
      end;
      if chkNXTMode.Checked then
      begin
        tmpStr := Format('Mode B: %d', [mode]);
        fNewData.Add(tmpStr);
        edtPBMode.Text := Format('%d', [mode]);
      end;
      if chkNXTRegMode.Checked then
      begin
        tmpStr := Format('RegMode B: %d', [regmode]);
        fNewData.Add(tmpStr);
        edtPBRegMode.Text := Format('%d', [regmode]);
      end;
      if chkNXTTurnRatio.Checked then
      begin
        tmpStr := Format('TurnRatio B: %d', [turnratio]);
        fNewData.Add(tmpStr);
        edtPBTurnRatio.Text := Format('%d', [turnratio]);
      end;
      if chkNXTRunState.Checked then
      begin
        tmpStr := Format('RunState B: %d', [runstate]);
        fNewData.Add(tmpStr);
        edtPBRunState.Text := Format('%d', [runstate]);
      end;
      if chkNXTTachoLimit.Checked then
      begin
        tmpStr := Format('TachoLimit B: %d', [tacholimit]);
        fNewData.Add(tmpStr);
        edtPBTachoLimit.Text := Format('%d', [tacholimit]);
      end;
      if chkNXTTachoCount.Checked then
      begin
        tmpStr := Format('Tacho B: %d', [tachocount]);
        fNewData.Add(tmpStr);
        edtPBTachoCount.Text := Format('%d', [tachocount]);
      end;
      if chkNXTBlockTachoCount.Checked then
      begin
        tmpStr := Format('BlockTacho B: %d', [blockcount]);
        fNewData.Add(tmpStr);
        edtPBBlockTachoCount.Text := Format('%d', [blockcount]);
      end;
      if chkNXTRotationCount.Checked then
      begin
        tmpStr := Format('Rotation B: %d', [rotcount]);
        fNewData.Add(tmpStr);
        edtPBRotationCount.Text := Format('%d', [rotcount]);
      end;
    end;
    if chkPortC.Checked then
    begin
      BrickComm.GetNXTOutputState(2, power, mode, regmode, turnratio,
        runstate, tacholimit, tachocount, blockcount, rotcount);
      if chkNXTPower.Checked then
      begin
        tmpStr := Format('Power C: %d', [power]);
        fNewData.Add(tmpStr);
        edtPCPower.Text := Format('%d', [power]);
      end;
      if chkNXTMode.Checked then
      begin
        tmpStr := Format('Mode C: %d', [mode]);
        fNewData.Add(tmpStr);
        edtPCMode.Text := Format('%d', [mode]);
      end;
      if chkNXTRegMode.Checked then
      begin
        tmpStr := Format('RegMode C: %d', [regmode]);
        fNewData.Add(tmpStr);
        edtPCRegMode.Text := Format('%d', [regmode]);
      end;
      if chkNXTTurnRatio.Checked then
      begin
        tmpStr := Format('TurnRatio C: %d', [turnratio]);
        fNewData.Add(tmpStr);
        edtPCTurnRatio.Text := Format('%d', [turnratio]);
      end;
      if chkNXTRunState.Checked then
      begin
        tmpStr := Format('RunState C: %d', [runstate]);
        fNewData.Add(tmpStr);
        edtPCRunState.Text := Format('%d', [runstate]);
      end;
      if chkNXTTachoLimit.Checked then
      begin
        tmpStr := Format('TachoLimit C: %d', [tacholimit]);
        fNewData.Add(tmpStr);
        edtPCTachoLimit.Text := Format('%d', [tacholimit]);
      end;
      if chkNXTTachoCount.Checked then
      begin
        tmpStr := Format('Tacho C: %d', [tachocount]);
        fNewData.Add(tmpStr);
        edtPCTachoCount.Text := Format('%d', [tachocount]);
      end;
      if chkNXTBlockTachoCount.Checked then
      begin
        tmpStr := Format('BlockTacho C: %d', [blockcount]);
        fNewData.Add(tmpStr);
        edtPCBlockTachoCount.Text := Format('%d', [blockcount]);
      end;
      if chkNXTRotationCount.Checked then
      begin
        tmpStr := Format('Rotation C: %d', [rotcount]);
        fNewData.Add(tmpStr);
        edtPCRotationCount.Text := Format('%d', [rotcount]);
      end;
    end;

    // raw I2C
    if chkI2C1.Checked then
      ProcessI2C(0, edtI2CLen1, edtI2CBuf1, edtI2CVal1);
    if chkI2C2.Checked then
      ProcessI2C(1, edtI2CLen2, edtI2CBuf2, edtI2CVal2);
    if chkI2C3.Checked then
      ProcessI2C(2, edtI2CLen3, edtI2CBuf3, edtI2CVal3);
    if chkI2C4.Checked then
      ProcessI2C(3, edtI2CLen4, edtI2CBuf4, edtI2CVal4);

    // processed I2C
    if chkPI2C1.Checked then
      PollProcessedI2C(0, cboPI2CType1.ItemIndex, edtPI2CVal1);
    if chkPI2C2.Checked then
      PollProcessedI2C(0, cboPI2CType2.ItemIndex, edtPI2CVal2);
    if chkPI2C3.Checked then
      PollProcessedI2C(0, cboPI2CType3.ItemIndex, edtPI2CVal3);
    if chkPI2C4.Checked then
      PollProcessedI2C(0, cboPI2CType4.ItemIndex, edtPI2CVal4);

    // handle mailbox polling for NXT
    if chkNXTMB1.Checked then
      PollMessage(chkNXTMB1.Tag, edtNXTMB1);
    if chkNXTMB2.Checked then
      PollMessage(chkNXTMB2.Tag, edtNXTMB2);
    if chkNXTMB3.Checked then
      PollMessage(chkNXTMB3.Tag, edtNXTMB3);
    if chkNXTMB4.Checked then
      PollMessage(chkNXTMB4.Tag, edtNXTMB4);
    if chkNXTMB5.Checked then
      PollMessage(chkNXTMB5.Tag, edtNXTMB5);
    if chkNXTMB6.Checked then
      PollMessage(chkNXTMB6.Tag, edtNXTMB6);
    if chkNXTMB7.Checked then
      PollMessage(chkNXTMB7.Tag, edtNXTMB7);
    if chkNXTMB8.Checked then
      PollMessage(chkNXTMB8.Tag, edtNXTMB8);
    if chkNXTMB9.Checked then
      PollMessage(chkNXTMB9.Tag, edtNXTMB9);
    if chkNXTMB10.Checked then
      PollMessage(chkNXTMB10.Tag, edtNXTMB10);

    // these only apply to Cybermaster
    if CheckTCounterL.Checked then
    begin
      ival := BrickComm.Poll(kRCX_TachCounterType,0);
      tmpStr := Format('Tacho Counter Left: %d', [ival]);
      fNewData.Add(tmpStr);
      ValueTCounterL.Text := Format('%6d', [ival]);
    end;
    if CheckTCounterR.Checked then
    begin
      ival := BrickComm.Poll(kRCX_TachCounterType,1);
      tmpStr := Format('Tacho Counter Right: %d', [ival]);
      fNewData.Add(tmpStr);
      ValueTCounterR.Text := Format('%6d', [ival]);
    end;
    if CheckTSpeedL.Checked then
    begin
      ival  := BrickComm.Poll(kRCX_TachSpeedType,0);
      tmpStr := Format('Tacho Speed Left: %d', [ival]);
      fNewData.Add(tmpStr);
      ValueTSpeedL.Text := Format('%6d', [ival]);
    end;
    if CheckTSpeedR.Checked then
    begin
      ival  := BrickComm.Poll(kRCX_TachSpeedType,1);
      tmpStr := Format('Tacho Speed Right: %d', [ival]);
      fNewData.Add(tmpStr);
      ValueTSpeedR.Text := Format('%6d', [ival]);
    end;
    if CheckMCurrent.Checked then
    begin
      ival := BrickComm.Poll(kRCX_OutputCurrentType,2);
      tmpStr := Format('Motor Current: %d', [ival]);
      fNewData.Add(tmpStr);
      ValueMCurrent.Text := Format('%6d',[ival]);
    end;
    // end of Cybermaster-only watch elements
    UpdateGraph;
    busy:=false;
  except
    ShowMessage(sWatchError);
    Timer1.Enabled := false;
    btnPollRegular.Down := false;
    busy:=false;
  end;
end;

procedure TWatchForm.btnCheckAllClick(Sender: TObject);
var
  i: Integer;
  temp: TComponent;
  bChk : boolean;
begin
  for i := ComponentCount - 1 downto 0 do
  begin
    temp := Components[i];
    if (temp is TCheckBox) and TCheckBox(temp).Visible and
       not ((temp = chkIfActive) or
            (temp = chkSyncSeries) or
            (temp = chkResponseMB) or
            (Pos('chkUltra', temp.Name) = 1)) then
      TCheckBox(temp).Checked := true;
  end;
  if IsRCX or IsScout or IsSpybotic or IsNXT then
  begin
    CheckTCounterL.Checked := false;
    CheckTSpeedL.Checked   := false;
    CheckTCounterR.Checked := false;
    CheckTSpeedR.Checked   := false;
    CheckMCurrent.Checked  := false;
    bChk                   := IsScout or IsRCX2 or IsSpybotic;
    chkPortA.Checked       := not bChk;
    chkPortB.Checked       := not bChk;
    chkPortC.Checked       := not bChk;
    chkI2C1.Checked        := not bChk;
    chkI2C2.Checked        := not bChk;
    chkI2C3.Checked        := not bChk;
    chkI2C4.Checked        := not bChk;
    CheckCounter0.Checked  := bChk;
    CheckCounter1.Checked  := bChk;
    CheckCounter2.Checked  := IsRCX2 or IsSpybotic;
    CheckMessage.Checked   := not IsSpybotic;
  end
  else
  begin
    chkPortA.Checked     := false;
    chkPortB.Checked     := false;
    chkPortC.Checked     := false;
    chkI2C1.Checked      := false;
    chkI2C2.Checked      := false;
    chkI2C3.Checked      := false;
    chkI2C4.Checked      := false;
    CheckMessage.Checked := false;
  end;
end;

procedure TWatchForm.btnCheckNoneClick(Sender: TObject);
var i: Integer;
    temp: TComponent;
begin
  for i := ComponentCount - 1 downto 0 do
  begin
    temp := Components[i];
    if (temp is TCheckBox) and not
       ((Pos('chkUltra', temp.Name) = 1) or
        (temp = chkResponseMB) or
        (temp = chkIfActive) or
        (temp = chkSyncSeries)) then
      TCheckBox(temp).Checked := false;
  end;
end;

procedure TWatchForm.Timer1Timer(Sender: TObject);
begin
  btnPollNowClick(Self);
end;

procedure TWatchForm.btnPollRegularClick(Sender: TObject);
begin
  Timer1.Enabled := btnPollRegular.Down;
end;

procedure TWatchForm.FormShow(Sender: TObject);
const
  NEW_FORM_HEIGHT = 412 - 77;
  NEW_VAR_HEIGHT  = 220;
var
  i : integer;
  bVis : boolean;
  cb : TCheckBox;
begin
  RestoreSettings;
  LoadWatchedProgram;
  grpVar.Visible   := True;
  grpMotor.Visible := not IsNXT;
  if grpVar.Visible then
  begin
    for i := Low(fVarArray) to High(fVarArray) do
    begin
      bVis := (i in [0..9]) or not IsScout;
      cb := fVarArray[i].CheckBox;
      cb.Visible := bVis;
      if not cb.Visible then
        cb.Checked := False;
      fVarArray[i].Edit.Visible := bVis;
    end;
    if IsNXT then
      SetVariableHints;
  end;
  CheckSensor4.Visible := IsNXT;
  ValueSensor4.Visible := IsNXT;
  if IsNXT then
  begin
    grpSensor.Height := 90;
    grpTimer.Top     := 96;
    grpMessage.Top   := 190;
  end
  else
  begin
    grpSensor.Height := 78;
    grpTimer.Top := 84;
    grpMessage.Top := 178;
  end;
  CheckTimer3.Visible := not IsScout;
  ValueTimer3.Visible := not IsScout;
  // sensor 3 is not visible for Spybot
  CheckSensor3.Visible  := not IsSpybotic;
  ValueSensor3.Visible  := not IsSpybotic;
  // counter 2 only visible if RCX2 or Spybot
  CheckCounter2.Visible := IsRCX2 or IsSpybotic;
  ValueCounter2.Visible := IsRCX2 or IsSpybotic;
  btnPollRegular.Down := false;
  Timer1.Enabled := false;
  busy := false;
  if IsRCX or IsScout or IsSpybotic or IsNXT then
  begin
    grpMessage.Visible         := not IsSpybotic and not IsNXT;
    shtCybermaster.TabVisible  := False;
    grpTacho.Visible           := False;
    shtNXT.TabVisible          := IsNXT;
    shtNXTMailboxes.TabVisible := IsNXT;
    shtNXTI2C.TabVisible       := IsNXT;
    grpNXTMotors.Visible       := IsNXT;
    grpI2C.Visible             := grpNXTMotors.Visible;
    grpPI2C.Visible            := grpNXTMotors.Visible;
    CheckTCounterL.Checked     := False;
    CheckTSpeedL.Checked       := False;
    CheckTCounterR.Checked     := False;
    CheckTSpeedR.Checked       := False;
    CheckMCurrent.Checked      := False;
    grpCounter.Visible         := not IsNXT;
    if IsRCX or IsScout or IsSpybotic then
    begin
//      // move counter box on top of tacho box
//      grpCounter.Top := grpTacho.Top;
      if IsScout then
      begin
        // move up the motors and shorten the height of the variable box
        // also shorten the form
        grpVar.Height := NEW_VAR_HEIGHT;
        grpMotor.Top  := grpCounter.Top;
        Self.Height   := NEW_FORM_HEIGHT;
      end;
      chkPortA.Checked   := False;
      chkPortB.Checked   := False;
      chkPortC.Checked   := False;
      chkI2C1.Checked    := False;
      chkI2C2.Checked    := False;
      chkI2C3.Checked    := False;
      chkI2C4.Checked    := False;
      chkNXTMB1.Checked  := False;
      chkNXTMB2.Checked  := False;
      chkNXTMB3.Checked  := False;
      chkNXTMB4.Checked  := False;
      chkNXTMB5.Checked  := False;
      chkNXTMB6.Checked  := False;
      chkNXTMB7.Checked  := False;
      chkNXTMB8.Checked  := False;
      chkNXTMB9.Checked  := False;
      chkNXTMB10.Checked := False;
    end;
    if IsNXT then
      CheckMessage.Checked := False;
  end
  else
  begin
    // cybermaster
    shtNXT.TabVisible          := False;
    shtNXTMailboxes.TabVisible := False;
    shtCybermaster.TabVisible  := True;
    grpTacho.Visible           := True;
    grpNXTMotors.Visible       := False;
    grpI2C.Visible             := False;
    grpMessage.Visible         := False;
    CheckMessage.Checked       := False;
    grpCounter.Visible         := False;
    CheckCounter0.Checked      := False;
    CheckCounter1.Checked      := False;
    CheckCounter2.Checked      := False;
    chkPortA.Checked           := False;
    chkPortB.Checked           := False;
    chkPortC.Checked           := False;
    chkI2C1.Checked            := False;
    chkI2C2.Checked            := False;
    chkI2C3.Checked            := False;
    chkI2C4.Checked            := False;
    chkNXTMB1.Checked          := False;
    chkNXTMB2.Checked          := False;
    chkNXTMB3.Checked          := False;
    chkNXTMB4.Checked          := False;
    chkNXTMB5.Checked          := False;
    chkNXTMB6.Checked          := False;
    chkNXTMB7.Checked          := False;
    chkNXTMB8.Checked          := False;
    chkNXTMB9.Checked          := False;
    chkNXTMB10.Checked         := False;
//    // move the grpTacho on top of the message box
//    grpTacho.Top := grpMessage.Top;
  end;
  pagWatch.ActivePage := shtCommon;
end;

procedure TWatchForm.FormCreate(Sender: TObject);
begin
  fWatchedProgram := TProgram.Create;
  fNewData := TStringList.Create;
{$IFNDEF FPC}
{$IFNDEF NXT_ONLY}
  fGraph := nil;
{$ENDIF}
{$ENDIF}
{$IFDEF FPC}
  chkSyncSeries.Visible := False;
  btnGraph.Visible := False;
{$ENDIF}
  cboTimes.ItemIndex := 3;
  PopulateVarArray;
  LoadI2CTypes;
end;

procedure TWatchForm.cboTimesChange(Sender: TObject);
begin
  case cboTimes.ItemIndex of
    0: Timer1.Interval := 100;
    1: Timer1.Interval := 200;
    2: Timer1.Interval := 500;
    3: Timer1.Interval := 1000;
    4: Timer1.Interval := 2000;
    5: Timer1.Interval := 5000;
    6: Timer1.Interval := 10000;
  end;
end;

procedure TWatchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := false;
  SaveSettings;
end;

procedure TWatchForm.btnGraphClick(Sender: TObject);
begin
{$IFNDEF FPC}
{$IFNDEF NXT_ONLY}
  if not btnGraph.Down then
  begin
    // close graph form and nil our pointer
    if Assigned(fGraph) then
    begin
      fGraph.Close;
      fGraph := nil;
    end;
  end
  else
  begin
    // create graph form and show it
    fGraph := TfrmDataAnalysis.Create(Application);
    fGraph.FromWatch   := True;
    fGraph.WatchPoints := WatchPoints;
    fGraph.SyncSeries  := chkSyncSeries.Checked;
    fGraph.DataIsXY    := False;
    fGraph.Show;
  end;
{$ENDIF}
{$ENDIF}
end;

procedure TWatchForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fWatchedProgram);
  fNewData.Free;
end;

procedure TWatchForm.UpdateGraph;
begin
{$IFNDEF FPC}
{$IFNDEF NXT_ONLY}
  if Assigned(fGraph) then
  begin
    fGraph.AddNewData(fNewData);
  end;
{$ENDIF}
{$ENDIF}
end;

procedure TWatchForm.GraphDestroyed;
begin
{$IFNDEF FPC}
{$IFNDEF NXT_ONLY}
  // called by data analysis form when it closes
  if Assigned(fGraph) then
  begin
    fGraph := nil;
    btnGraph.Down := False;
  end;
{$ENDIF}
{$ENDIF}
end;

procedure TWatchForm.FormActivate(Sender: TObject);
begin
  fOldProgram := BrickComm.TheProgram;
  // make sure the variable watch event handlers are hooked up
  BrickComm.TheProgram := fWatchedProgram;
  if chkIfActive.Checked then
    Timer1.Enabled := btnPollRegular.Down;
end;

procedure TWatchForm.FormDeactivate(Sender: TObject);
begin
  BrickComm.TheProgram := fOldProgram;
  if chkIfActive.Checked then
    Timer1.Enabled := False;
end;

procedure TWatchForm.PopulateVarArray;
var
  i : integer;
begin
  for i := Low(fVarArray) to High(fVarArray) do
  begin
    fVarArray[i].CheckBox := TCheckBox(FindComponent(Format('CVar%d',[i])));
    fVarArray[i].Edit     := TEdit(FindComponent(Format('VVar%d',[i])));
  end;
end;

procedure TWatchForm.btnClearClick(Sender: TObject);
var
  i, j, k : Integer;
  Grp : TGroupBox;
  sht : TTabSheet;
begin
  for k := 0 to pagWatch.PageCount - 1 do
  begin
    sht := pagWatch.Pages[k];
    for i := 0 to sht.ControlCount - 1 do
    begin
      if sht.Controls[i] is TGroupBox then
      begin
        Grp := TGroupBox(sht.Controls[i]);
        for j := 0 to Grp.ControlCount - 1 do
          if (Grp.Controls[j] is TEdit) and (Pos('edtI2CBuf', TEdit(Grp.Controls[j]).Name) = 0) then
            TEdit(Grp.Controls[j]).Text := '';
      end;
    end;
  end;
end;

procedure TWatchForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TWatchForm.ConfigureRawI2C(chk : TCheckBox; edtBuf : TEdit; edtLen : TBricxCCSpinEdit);
begin
  edtBuf.Enabled := not chk.Checked;
  edtBuf.Text := '02 42';
  edtLen.Enabled := not chk.Checked;
  edtLen.Value := 1;
end;

procedure TWatchForm.chkUltra1Click(Sender: TObject);
begin
  ConfigureRawI2C(chkUltra1, edtI2CBuf1, edtI2CLen1);
end;

procedure TWatchForm.chkUltra2Click(Sender: TObject);
begin
  ConfigureRawI2C(chkUltra2, edtI2CBuf2, edtI2CLen2);
end;

procedure TWatchForm.chkUltra3Click(Sender: TObject);
begin
  ConfigureRawI2C(chkUltra3, edtI2CBuf3, edtI2CLen3);
end;

procedure TWatchForm.chkUltra4Click(Sender: TObject);
begin
  ConfigureRawI2C(chkUltra4, edtI2CBuf4, edtI2CLen4);
end;

procedure TWatchForm.LoadWatchedProgram;
var
  fname, name, tmp : string;
begin
  fname := GetActiveEditorFilename;
  // is there a program running on the NXT?
  if BrickComm.NXTGetCurrentProgramName(name) and (name <> '') then
  begin
    tmp := ExtractFileName(fname);
    if Pos(ChangeFileExt(name, ''), tmp) > 0 then
      name := tmp;
    fname := ExtractFilePath(fname) + name;
  end;
  ReadSymbolFile(fWatchedProgram, fname);
end;

procedure TWatchForm.mniOpenSymClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
    ReadSymbolFile(fWatchedProgram, dlgOpen.Filename);
    SetVariableHints;
  end;
end;

procedure TWatchForm.SetVariableHints;
var
  i : integer;
  tmp : string;
begin
  for i := Low(fVarArray) to High(fVarArray) do
  begin
    if fWatchedProgram.Dataspace.Count > i then
    begin
      tmp := fWatchedProgram.Dataspace[i].PrettyName;
      fVarArray[i].CheckBox.Hint := tmp;
      fVarArray[i].Edit.Hint     := tmp;
    end;
  end;
end;

procedure TWatchForm.RestoreSettings;
begin
  chkIfActive.Checked    := WatchOnlyIfActive;
  chkSyncSeries.Checked  := WatchSyncSeries;
  chkResponseMB.Checked  := WatchNXTResponseMB;
  if WatchPI2CType1 < cboPI2CType1.Items.Count then
    cboPI2CType1.ItemIndex := WatchPI2CType1;
  if WatchPI2CType2 < cboPI2CType2.Items.Count then
    cboPI2CType2.ItemIndex := WatchPI2CType2;
  if WatchPI2CType3 < cboPI2CType3.Items.Count then
    cboPI2CType3.ItemIndex := WatchPI2CType3;
  if WatchPI2CType4 < cboPI2CType4.Items.Count then
    cboPI2CType4.ItemIndex := WatchPI2CType4;
end;

procedure TWatchForm.SaveSettings;
begin
  WatchOnlyIfActive  := chkIfActive.Checked;
  WatchSyncSeries    := chkSyncSeries.Checked;
  WatchNXTResponseMB := chkResponseMB.Checked;
  WatchPI2CType1     := cboPI2CType1.ItemIndex;
  WatchPI2CType2     := cboPI2CType2.ItemIndex;
  WatchPI2CType3     := cboPI2CType3.ItemIndex;
  WatchPI2CType4     := cboPI2CType4.ItemIndex;
end;

procedure TWatchForm.PollProcessedI2C(port: byte; pitype: integer;
  edtVal: TEdit);
begin
  if pitype > -1 then
    edtVal.Text := BrickComm.Poll(kNXT_I2CBaseValueType+pitype, port);
end;

procedure TWatchForm.LoadI2CTypes;
var
  tmp : string;
begin
  tmp := GetI2CValueTypes;
  cboPI2CType1.Items.Text := tmp;
  cboPI2CType2.Items.Text := tmp;
  cboPI2CType3.Items.Text := tmp;
  cboPI2CType4.Items.Text := tmp;
end;

procedure TWatchForm.btnConfigI2CTypesClick(Sender: TObject);
var
  f : TfrmVTConfig;
begin
// TODO: implement I2C configuration dialog
  f := TfrmVTConfig.Create(nil);
  try
    if f.ShowModal = mrOK then
    begin
    end;
  finally
    f.Free;
  end;
end;

function TWatchForm.IndexToID(const idx: integer): integer;
begin
  Result := idx;
  if IsNXT then
  begin
    // TODO: allow the user to map variables to different variable numbers
  end;
end;

initialization
{$IFDEF FPC}
  {$i Watch.lrs}
{$ENDIF}

end.
