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
unit uRemoteProgMap;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

{$I bricxcc.inc}

interface

uses
{$IFDEF FPC}
  LResources,
{$ENDIF}
  Classes, Controls, Forms, StdCtrls, uRemoteGlobals;

type
  TfrmRemoteProgMap = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    lblP1: TLabel;
    lblP2: TLabel;
    lblP3: TLabel;
    lblP4: TLabel;
    lblP5: TLabel;
    edtP1: TComboBox;
    edtP2: TComboBox;
    edtP3: TComboBox;
    edtP4: TComboBox;
    edtP5: TComboBox;
    lblTone: TLabel;
    edtTone: TComboBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function GetAName(index: integer): string;
    procedure SetAName(index: integer; const Value: string);
    function GetSelected: integer;
    procedure SetSelected(const Value: integer);
  public
    { Public declarations }
    procedure SetProgramNames(ProgNames : TProgramNames);
    property ProgramName[index : integer] : string read GetAName write SetAName;
    function Count : integer;
    property Selected : integer read GetSelected write SetSelected;
  end;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

uses
  brick_common, uGlobals;

{ TfrmRemoteProgMap }

function TfrmRemoteProgMap.Count: integer;
begin
  Result := 6;
end;

function TfrmRemoteProgMap.GetAName(index: integer): string;
begin
  case index of
    0 : Result := edtP1.Text;
    1 : Result := edtP2.Text;
    2 : Result := edtP3.Text;
    3 : Result := edtP4.Text;
    4 : Result := edtP5.Text;
    5 : Result := edtTone.Text;
  else
    Result := '';
  end;
end;

procedure TfrmRemoteProgMap.SetAName(index: integer; const Value: string);
begin
  case index of
    0 : edtP1.Text := Value;
    1 : edtP2.Text := Value;
    2 : edtP3.Text := Value;
    3 : edtP4.Text := Value;
    4 : edtP5.Text := Value;
    5 : edtTone.Text := Value;
  end;
end;

procedure TfrmRemoteProgMap.SetProgramNames(ProgNames : TProgramNames);
var
  i : integer;
begin
  for I := Low(ProgNames) to High(ProgNames) do
    ProgramName[I] := ProgNames[I];
end;

procedure TfrmRemoteProgMap.FormCreate(Sender: TObject);
var
  SL : TStringList;
  i : integer;
  tmp : string;
begin
  if BrickComm.BrickType = SU_NXT then
  begin
    SL := TStringList.Create;
    try
      BrickComm.NXTListFiles('*.rxe', SL);
      for i := 0 to SL.Count - 1 do
      begin
        tmp := SL.Names[i];
        edtP1.Items.Add(tmp);
        edtP2.Items.Add(tmp);
        edtP3.Items.Add(tmp);
        edtP4.Items.Add(tmp);
        edtP5.Items.Add(tmp);
      end;
      SL.Clear;
      BrickComm.NXTListFiles('*.rso', SL);
      BrickComm.NXTListFiles('*.rmd', SL);
      edtTone.Items.Add('default');
      for i := 0 to SL.Count - 1 do
      begin
        tmp := SL.Names[i];
        edtTone.Items.Add(tmp);
      end;
    finally
      SL.Free;
    end;
  end;
end;

function TfrmRemoteProgMap.GetSelected: integer;
begin
  if ActiveControl = edtP1 then
    Result := 4
  else if ActiveControl = edtP2 then
    Result := 5
  else if ActiveControl = edtP3 then
    Result := 6
  else if ActiveControl = edtP4 then
    Result := 7
  else if ActiveControl = edtP5 then
    Result := 8
  else if ActiveControl = edtTone then
    Result := 10
  else
    Result := 0;
end;

procedure TfrmRemoteProgMap.SetSelected(const Value: integer);
begin
  case Value of
     4 : ActiveControl := edtP1;
     5 : ActiveControl := edtP2;
     6 : ActiveControl := edtP3;
     7 : ActiveControl := edtP4;
     8 : ActiveControl := edtP5;
    10 : ActiveControl := edtTone;
  end;
end;

{$IFDEF FPC}
initialization
  {$i uRemoteProgMap.lrs}
{$ENDIF}

end.
