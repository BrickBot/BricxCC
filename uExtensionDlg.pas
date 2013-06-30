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
unit uExtensionDlg;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
{$ENDIF}
  Classes, Controls, Forms, StdCtrls;

type
  TfrmExtensionDlg = class(TForm)
    lblClaimThese: TLabel;
    chkNQC: TCheckBox;
    chkRCX2: TCheckBox;
    chkLSC: TCheckBox;
    chkLASM: TCheckBox;
    btnOK: TButton;
    btnCancel: TButton;
    chkCpp: TCheckBox;
    chkPas: TCheckBox;
    chkC: TCheckBox;
    chkJava: TCheckBox;
    chkForth: TCheckBox;
    btnHelp: TButton;
    chkNBC: TCheckBox;
    chkRICScript: TCheckBox;
    chkNXC: TCheckBox;
    chkNPG: TCheckBox;
    chkLua: TCheckBox;
    chkPascalScript: TCheckBox;
    chkSPC: TCheckBox;
    chkSPASM: TCheckBox;
  private
    { Private declarations }
    function GetLASM: Boolean;
    function GetLSC: Boolean;
    function GetNQC: Boolean;
    function GetRCX2: Boolean;
    function GetCpp: Boolean;
    function GetPas: Boolean;
    function GetC: Boolean;
    function GetForth: Boolean;
    function GetJava: Boolean;
    procedure SetLASM(const Value: Boolean);
    procedure SetC(const Value: Boolean);
    procedure SetCpp(const Value: Boolean);
    procedure SetForth(const Value: Boolean);
    procedure SetJava(const Value: Boolean);
    procedure SetLSC(const Value: Boolean);
    procedure SetNQC(const Value: Boolean);
    procedure SetPas(const Value: Boolean);
    procedure SetRCX2(const Value: Boolean);
    function GetNBC: Boolean;
    procedure SetNBC(const Value: Boolean);
    function GetLua: Boolean;
    procedure SetLua(const Value: Boolean);
    function GetNPG: Boolean;
    function GetNXC: Boolean;
    procedure SetNPG(const Value: Boolean);
    procedure SetNXC(const Value: Boolean);
    function GetRS: Boolean;
    procedure SetRS(const Value: Boolean);
    function GetROPS: Boolean;
    procedure SetROPS(const Value: Boolean);
    function GetSPC: Boolean;
    procedure SetSPC(const Value: Boolean);
    function GetSPASM: Boolean;
    procedure SetSPASM(const Value: Boolean);
  public
    { Public declarations }
    property ClaimNQC : Boolean read GetNQC write SetNQC;
    property ClaimRCX2 : Boolean read GetRCX2 write SetRCX2;
    property ClaimLSC : Boolean read GetLSC write SetLSC;
    property ClaimLASM : Boolean read GetLASM write SetLASM;
    property ClaimCpp : Boolean read GetCpp write SetCpp;
    property ClaimC : Boolean read GetC write SetC;
    property ClaimPas : Boolean read GetPas write SetPas;
    property ClaimJava : Boolean read GetJava write SetJava;
    property ClaimForth : Boolean read GetForth write SetForth;
    property ClaimNBC : Boolean read GetNBC write SetNBC;
    property ClaimNXC : Boolean read GetNXC write SetNXC;
    property ClaimNPG : Boolean read GetNPG write SetNPG;
    property ClaimRS : Boolean read GetRS write SetRS;
    property ClaimLua : Boolean read GetLua write SetLua;
    property ClaimROPS : Boolean read GetROPS write SetROPS;
    property ClaimSPC : Boolean read GetSPC write SetSPC;
    property ClaimSPASM : Boolean read GetSPASM write SetSPASM;
  end;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

{ TfrmExtensionDlg }

function TfrmExtensionDlg.GetLASM: Boolean;
begin
  Result := chkLASM.Checked;
end;

function TfrmExtensionDlg.GetC: Boolean;
begin
  Result := chkC.Checked;
end;

function TfrmExtensionDlg.GetCpp: Boolean;
begin
  Result := chkCpp.Checked;
end;

function TfrmExtensionDlg.GetForth: Boolean;
begin
  Result := chkForth.Checked; 
end;

function TfrmExtensionDlg.GetJava: Boolean;
begin
  Result := chkJava.Checked;
end;

function TfrmExtensionDlg.GetLSC: Boolean;
begin
  Result := chkLSC.Checked;
end;

function TfrmExtensionDlg.GetLua: Boolean;
begin
  Result := chkLua.Checked;
end;

function TfrmExtensionDlg.GetNBC: Boolean;
begin
  Result := chkNBC.Checked;
end;

function TfrmExtensionDlg.GetNPG: Boolean;
begin
  Result := chkNPG.Checked;
end;

function TfrmExtensionDlg.GetNQC: Boolean;
begin
  Result := chkNQC.Checked;
end;

function TfrmExtensionDlg.GetNXC: Boolean;
begin
  Result := chkNXC.Checked;
end;

function TfrmExtensionDlg.GetPas: Boolean;
begin
  Result := chkPas.Checked;
end;

function TfrmExtensionDlg.GetSPC: Boolean;
begin
  Result := chkSPC.Checked;
end;

function TfrmExtensionDlg.GetRCX2: Boolean;
begin
  Result := chkRCX2.Checked;
end;

function TfrmExtensionDlg.GetROPS: Boolean;
begin
  Result := chkPascalScript.Checked;
end;

function TfrmExtensionDlg.GetRS: Boolean;
begin
  Result := chkRICScript.Checked;
end;

procedure TfrmExtensionDlg.SetLASM(const Value: Boolean);
begin
  chkLASM.Checked := Value;
end;

procedure TfrmExtensionDlg.SetC(const Value: Boolean);
begin
  chkC.Checked := Value;
end;

procedure TfrmExtensionDlg.SetCpp(const Value: Boolean);
begin
  chkCpp.Checked := Value;
end;

procedure TfrmExtensionDlg.SetForth(const Value: Boolean);
begin
  chkForth.Checked := Value;
end;

procedure TfrmExtensionDlg.SetJava(const Value: Boolean);
begin
  chkJava.Checked := Value;
end;

procedure TfrmExtensionDlg.SetLSC(const Value: Boolean);
begin
  chkLSC.Checked := Value;
end;

procedure TfrmExtensionDlg.SetLua(const Value: Boolean);
begin
  chkLua.Checked := Value;
end;

procedure TfrmExtensionDlg.SetNBC(const Value: Boolean);
begin
  chkNBC.Checked := Value;
end;

procedure TfrmExtensionDlg.SetNPG(const Value: Boolean);
begin
  chkNPG.Checked := Value;
end;

procedure TfrmExtensionDlg.SetNQC(const Value: Boolean);
begin
  chkNQC.Checked := Value;
end;

procedure TfrmExtensionDlg.SetNXC(const Value: Boolean);
begin
  chkNXC.Checked := Value;
end;

procedure TfrmExtensionDlg.SetPas(const Value: Boolean);
begin
  chkPas.Checked := Value;
end;

procedure TfrmExtensionDlg.SetSPC(const Value: Boolean);
begin
  chkSPC.Checked := Value;
end;

procedure TfrmExtensionDlg.SetRCX2(const Value: Boolean);
begin
  chkRCX2.Checked := Value;
end;

procedure TfrmExtensionDlg.SetROPS(const Value: Boolean);
begin
  chkPascalScript.Checked := Value;
end;

procedure TfrmExtensionDlg.SetRS(const Value: Boolean);
begin
  chkRICScript.Checked := Value;
end;

function TfrmExtensionDlg.GetSPASM: Boolean;
begin
  Result := chkSPASM.Checked;
end;

procedure TfrmExtensionDlg.SetSPASM(const Value: Boolean);
begin
  chkSPASM.Checked := Value;
end;

{$IFDEF FPC}
initialization
  {$i uExtensionDlg.lrs}
{$ENDIF}

end.