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
 * Portions created by John Hansen are Copyright (C) 2010 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uNXTWatchProperties;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  SysUtils, Classes, Controls, Forms, StdCtrls, uNXTWatchCommon;

type
  TfrmNXTWatchProperties = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    Label1: TLabel;
    cboExpression: TComboBox;
    cboGroupName: TComboBox;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    radCharacter: TRadioButton;
    radString: TRadioButton;
    radDecimal: TRadioButton;
    radHexadecimal: TRadioButton;
    radFloatingPoint: TRadioButton;
    radPointer: TRadioButton;
    radRecStruct: TRadioButton;
    radDefault: TRadioButton;
    radMemoryDump: TRadioButton;
    chkEnabled: TCheckBox;
    chkAllowFunctionCalls: TCheckBox;
  private
    { Private declarations }
    function GetAllowFuncs: boolean;
    function GetDigits: integer;
    function GetWatchEnabled: boolean;
    function GetExpression: string;
    function GetGroupName: string;
    function GetRepeatCount: integer;
    function GetWatchType: TWatchType;
    procedure SetAllowFuncs(const Value: boolean);
    procedure SetDigits(const Value: integer);
    procedure SetWatchEnabled(const Value: boolean);
    procedure SetExpression(const Value: string);
    procedure SetGroupName(const Value: string);
    procedure SetRepeatCount(const Value: integer);
    procedure SetWatchType(const Value: TWatchType);
  public
    { Public declarations }
    procedure InitDialog(wi : TWatchInfo);
    procedure UpdateWatchInfo(var wi : TWatchInfo);
    property Expression : string read GetExpression write SetExpression;
    property GroupName : string read GetGroupName write SetGroupName;
    property WatchEnabled : boolean read GetWatchEnabled write SetWatchEnabled;
    property AllowFunctionCalls : boolean read GetAllowFuncs write SetAllowFuncs;
    property RepeatCount : integer read GetRepeatCount write SetRepeatCount;
    property Digits : integer read GetDigits write SetDigits;
    property WatchType : TWatchType read GetWatchType write SetWatchType;
  end;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

{ TfrmNXTWatchProperties }

function TfrmNXTWatchProperties.GetAllowFuncs: boolean;
begin
  Result := chkAllowFunctionCalls.Checked;
end;

function TfrmNXTWatchProperties.GetDigits: integer;
begin
  Result := 18;
end;

function TfrmNXTWatchProperties.GetWatchEnabled: boolean;
begin
  Result := chkEnabled.Checked;
end;

function TfrmNXTWatchProperties.GetExpression: string;
begin
  Result := cboExpression.Text;
end;

function TfrmNXTWatchProperties.GetGroupName: string;
begin
  Result := cboGroupName.Text;
end;

function TfrmNXTWatchProperties.GetRepeatCount: integer;
begin
  Result := 0;
end;

function TfrmNXTWatchProperties.GetWatchType: TWatchType;
begin
  if radCharacter.Checked then
    Result := wtCharacter
  else if radString.Checked then
    Result := wtString
  else if radDecimal.Checked then
    Result := wtDecimal
  else if radHexadecimal.Checked then
    Result := wtHexadecimal
  else if radFloatingPoint.Checked then
    Result := wtFloatingPoint
  else if radPointer.Checked then
    Result := wtPointer
  else if radRecStruct.Checked then
    Result := wtRecord
  else if radMemoryDump.Checked then
    Result := wtMemoryDump
  else
    Result := wtDefault;
end;

procedure TfrmNXTWatchProperties.SetAllowFuncs(const Value: boolean);
begin
  if chkAllowFunctionCalls.Enabled then
    chkAllowFunctionCalls.Checked := Value;
end;

procedure TfrmNXTWatchProperties.SetDigits(const Value: integer);
begin
  // do nothing for now
end;

procedure TfrmNXTWatchProperties.SetWatchEnabled(const Value: boolean);
begin
  chkEnabled.Checked := Value;
end;

procedure TfrmNXTWatchProperties.SetExpression(const Value: string);
begin
  cboExpression.Text := Value;
end;

procedure TfrmNXTWatchProperties.SetGroupName(const Value: string);
begin
  cboGroupName.Text := Value;
end;

procedure TfrmNXTWatchProperties.SetRepeatCount(const Value: integer);
begin
  // do nothing for now
end;

procedure TfrmNXTWatchProperties.SetWatchType(const Value: TWatchType);
begin
  case Value of
    wtCharacter     : radCharacter.Checked     := True;
    wtString        : radString.Checked        := True;
    wtDecimal       : radDecimal.Checked       := True;
    wtHexadecimal   : radHexadecimal.Checked   := True;
    wtFloatingPoint : radFloatingPoint.Checked := True;
    wtPointer       : radPointer.Checked       := True;
    wtRecord        : radRecStruct.Checked     := True;
    wtDefault       : radDefault.Checked       := True;
    wtMemoryDump    : radMemoryDump.Checked    := True;
  else
    radDefault.Checked := True;
  end;
end;

procedure TfrmNXTWatchProperties.InitDialog(wi: TWatchInfo);
begin
  Expression         := wi.Expression;
  GroupName          := wi.GroupName;
  WatchEnabled       := wi.Enabled;
  AllowFunctionCalls := wi.AllowFunctionCalls;
  RepeatCount        := wi.RepeatCount;
  Digits             := wi.Digits;
  WatchType          := wi.WatchType;
end;

procedure TfrmNXTWatchProperties.UpdateWatchInfo(var wi: TWatchInfo);
begin
  wi.Expression         := Expression;
  wi.GroupName          := GroupName;
  wi.Enabled            := WatchEnabled;
  wi.AllowFunctionCalls := AllowFunctionCalls;
  wi.RepeatCount        := RepeatCount;
  wi.Digits             := Digits;
  wi.WatchType          := WatchType;
end;

{$IFDEF FPC}
initialization
  {$i uNXTWatchProperties.lrs}
{$ENDIF}

end.
