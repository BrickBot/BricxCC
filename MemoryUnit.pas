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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit MemoryUnit;

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
  TPointerFormat = (pfHex, pfDecimal);
  TMemoryForm = class(TForm)
    MemoryMemo: TMemo;
    RefreshBtn: TButton;
    chkUseHex: TCheckBox;
    btnHelp: TButton;
    procedure RefreshBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkUseHexClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    function GetPointerFormat: TPointerFormat;
  private
    { Private declarations }
    procedure RedrawMap;
    property PointerFormat : TPointerFormat read GetPointerFormat;
  public
    { Public declarations }
  end;

var
  MemoryForm: TMemoryForm;

implementation

uses
  SysUtils, Dialogs, brick_common, uLocalizedStrings, uGlobals;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

const
  K_SPY_TOP = $8FFF;
  K_FMTS : array[TPointerFormat] of string = (' 0x%4.4x', '%6d');
  K_NXTFMTS : array[TPointerFormat] of string = ('0x%8.8x', '%10d');

procedure TMemoryForm.RefreshBtnClick(Sender: TObject);
var
  c : TCursor;
begin
  if not BrickComm.BrickAlive then Exit;
  MemoryMemo.Lines.Clear;
  Application.ProcessMessages;
  c := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    BrickComm.DownloadMemoryMap;
  finally
    Screen.Cursor := c;
  end;
  RedrawMap;
end;

procedure TMemoryForm.FormShow(Sender: TObject);
begin
  RefreshBtnClick(Self);
end;

function TMemoryForm.GetPointerFormat: TPointerFormat;
begin
  Result := pfDecimal;
  if chkUseHex.Checked then
    Result := pfHex;
end;

procedure TMemoryForm.chkUseHexClick(Sender: TObject);
begin
  RedrawMap;
end;

procedure TMemoryForm.RedrawMap;
var
  i, j : integer;
  str, tmp : string;
  memdata : TStrings;
  PF : TPointerFormat;
begin
  PF := PointerFormat;
  MemoryMemo.Lines.BeginUpdate;
  try
    MemoryMemo.Lines.Clear;
    memdata := BrickComm.MemoryMap;
    if IsRCX then
    begin
      if memdata.Count < 93 then
      begin
        MessageDlg(sDownloadMemMapFailed, mtError, [mbOK], 0);
        Exit;
      end;
      MemoryMemo.Lines.Add(sSubroutinePointers);
      for i := 0 to 4 do
      begin
        str := Format('P%d:',[i+1]);
        for j := 0 to 7 do
          str := str + Format(K_FMTS[PF],[StrToIntDef(memdata[(8 * i) + j], 0)]);
        MemoryMemo.Lines.Add(str);
      end;
      MemoryMemo.Lines.Add('');
      MemoryMemo.Lines.Add(sTaskPointers);
      for i := 0 to 4 do
      begin
        str := Format('P%d:',[i+1]);
        for j := 0 to 9 do
          str := str + Format(K_FMTS[PF],[StrToIntDef(memdata[40+10*i+j], 0)]);
        MemoryMemo.Lines.Add(str);
      end;
      MemoryMemo.Lines.Add('');
      MemoryMemo.Lines.Add(Format(sDatalogStart   + K_FMTS[PF],[StrToIntDef(memdata[90], 0)]));
      MemoryMemo.Lines.Add(Format(sDatalogCurrent + K_FMTS[PF],[StrToIntDef(memdata[91], 0)]));
      MemoryMemo.Lines.Add(Format(sTotalUsed      + K_FMTS[PF],[StrToIntDef(memdata[92], 0)]));
      MemoryMemo.Lines.Add(Format(sTopOfMemory    + K_FMTS[PF],[StrToIntDef(memdata[93], 0)]));
      MemoryMemo.Lines.Add(Format(sFreeMemLeft    + K_FMTS[pfDecimal],[StrToIntDef(memdata[93], 0)-StrToIntDef(memdata[92], 0)]));
    end else if IsScout then begin
      // scout
      if memdata.Count < 11 then
      begin
        MessageDlg(sDownloadMemMapFailed, mtError, [mbOK], 0);
        Exit;
      end;
      MemoryMemo.Lines.Add(sSubroutinePointers);
      str := '';
      for j := 0 to 2 do
        str := str + Format(K_FMTS[PF], [StrToIntDef(memdata[j], 0)]);
      MemoryMemo.Lines.Add(str);
      MemoryMemo.Lines.Add('');
      MemoryMemo.Lines.Add(sTaskPointers);
      str := '';
      for j := 0 to 3 do
        str := str + Format(K_FMTS[PF], [StrToIntDef(memdata[3+j], 0)]);
      MemoryMemo.Lines.Add(str);
      MemoryMemo.Lines.Add('');
      MemoryMemo.Lines.Add(Format(sTotalUsed + K_FMTS[PF],[StrToIntDef(memdata[9], 0)]));
      MemoryMemo.Lines.Add(Format(sTopOfMemory + K_FMTS[PF],[StrToIntDef(memdata[10], 0)]));
      MemoryMemo.Lines.Add(Format(sFreeMemLeft + K_FMTS[pfDecimal],[StrToIntDef(memdata[10], 0)-StrToIntDef(memdata[9], 0)]));
    end else if IsSpybotic then begin
      // spybot
      if memdata.Count < 66 then
      begin
        MessageDlg(sDownloadMemMapFailed, mtError, [mbOK], 0);
        Exit;
      end;
      MemoryMemo.Lines.Add(sSubroutinePointers);
      str := '';
      for i := 0 to 3 do
      begin
        for j := 0 to 7 do
          str := str + Format(K_FMTS[PF], [StrToIntDef(memdata[(8*i)+j], 0)]);
        MemoryMemo.Lines.Add(str);
        str := '';
      end;
      MemoryMemo.Lines.Add('');
      MemoryMemo.Lines.Add(sTaskPointers);
      str := '';
      for j := 0 to 7 do
        str := str + Format(K_FMTS[PF], [StrToIntDef(memdata[32+j], 0)]);
      MemoryMemo.Lines.Add(str);
      MemoryMemo.Lines.Add('');
      MemoryMemo.Lines.Add(sSoundPointers);
      str := '';
      for i := 0 to 1 do
      begin
        for j := 0 to 7 do
          str := str + Format(K_FMTS[PF], [StrToIntDef(memdata[40+(8*i)+j], 0)]);
        MemoryMemo.Lines.Add(str);
        str := '';
      end;
      MemoryMemo.Lines.Add('');
      MemoryMemo.Lines.Add(sAnimationPointers);
      str := '';
      for j := 0 to 7 do
        str := str + Format(K_FMTS[PF], [StrToIntDef(memdata[56+j], 0)]);
      MemoryMemo.Lines.Add(str);
      MemoryMemo.Lines.Add('');
      MemoryMemo.Lines.Add(Format(sDataPointer + K_FMTS[PF],[StrToIntDef(memdata[64], 0)]));
      MemoryMemo.Lines.Add(Format(sTotalUsed   + K_FMTS[PF],[StrToIntDef(memdata[65], 0)]));
      MemoryMemo.Lines.Add(Format(sTopOfMemory + K_FMTS[PF],[K_SPY_TOP]));
      MemoryMemo.Lines.Add(Format(sFreeMemLeft + K_FMTS[pfDecimal],[K_SPY_TOP-StrToIntDef(memdata[65], 0)]));
    end else if IsNXT then begin
      // NXT memory map == very different from other bricks
      j := 0;
      while j < memdata.Count do
      begin
        str := Format('%-22s', [memdata[j]]);
        tmp := memdata[j+1];
        if tmp <> '' then
        begin
          i := Pos('|', tmp);
          if i <> 0 then
          begin
            str := str + Format(K_NXTFMTS[PF], [StrToIntDef(Copy(tmp, 1, i-1), 0)]);
            Delete(tmp, 1, i);
            str := str + ' ' + Format(K_NXTFMTS[PF], [StrToIntDef(tmp, 0)]);
          end
          else
            str := str + Format(K_NXTFMTS[PF], [StrToIntDef(tmp, 0)]);
        end;
        MemoryMemo.Lines.Add(str);
        inc(j, 2);
      end;
    end else begin
      // cybermaster
      if memdata.Count < 10 then
      begin
        MessageDlg(sDownloadMemMapFailed, mtError, [mbOK], 0);
        Exit;
      end;
      MemoryMemo.Lines.Add(sSubroutinePointers);
      str:='';
      for j := 0 to 3 do
        str := str + Format(K_FMTS[PF],[StrToIntDef(memdata[j], 0)]);
      MemoryMemo.Lines.Add(str);
      MemoryMemo.Lines.Add('');
      MemoryMemo.Lines.Add(sTaskPointers);
      str:='';
      for j := 0 to 3 do
        str := str + Format(K_FMTS[PF],[StrToIntDef(memdata[4+j], 0)]);
      MemoryMemo.Lines.Add(str);
      MemoryMemo.Lines.Add('');
      MemoryMemo.Lines.Add(Format(sTotalUsed   + K_FMTS[PF],[StrToIntDef(memdata[8], 0)]));
      MemoryMemo.Lines.Add(Format(sTopOfMemory + K_FMTS[PF],[StrToIntDef(memdata[9], 0)]));
      MemoryMemo.Lines.Add(Format(sFreeMemLeft + K_FMTS[pfDecimal],[StrToIntDef(memdata[9], 0)-StrToIntDef(memdata[8], 0)]));
    end;
  finally
    MemoryMemo.Lines.EndUpdate;
  end;
end;

procedure TMemoryForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

{$IFDEF FPC}
initialization
  {$i MemoryUnit.lrs}
{$ENDIF}

end.