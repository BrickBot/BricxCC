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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
program fantomtalk;

{$APPTYPE CONSOLE}

uses
{$IFNDEF FPC}
  FastMM4,
  FastMove,
{$ENDIF}
  Classes,
  SysUtils,
  Math,
{$IFDEF FPC}
{$IFDEF WIN32}
  serial in 'fpc\serial.pp',
{$ENDIF}
{$ENDIF}
  ParamUtils in 'ParamUtils.pas',
  uVersionInfo in 'uVersionInfo.pas',
  uNXTConstants in 'NXT\uNXTConstants.pas',
  uSpirit in 'bricktools\uSpirit.pas',
  FantomSpirit in 'bricktools\FantomSpirit.pas',
  uCommonUtils in 'uCommonUtils.pas',
  uCmdLineUtils in 'uCmdLineUtils.pas';

{$IFDEF WIN32}
{$R *.RES}
{$ENDIF}

var
  SL : TStrings;
  i : Integer;
  tmpStr : string;
  BC : TBrickComm;

function BrickComm : TBrickComm;
begin
  if not Assigned(BC) then
  begin
    BC := TFantomSpirit.Create();
  end;
  Result := BC;
end;

{$I fantomtalk_preproc.inc}

begin
{$IFDEF FPC}
  VerCompanyName      := 'JoCar Consulting';
  VerFileDescription  := '';
  VerFileVersion      := '1.0.0.0';
  VerInternalName     := 'fantomtalk';
  VerLegalCopyright   := 'Copyright (c) 2010, John Hansen';
  VerOriginalFileName := 'fantomtalk';
  VerProductName      := 'fantomtalk';
  VerProductVersion   := '1.0';
  VerComments         := '';
{$ENDIF}

  if ParamSwitch('/COM') then
    BrickComm.Port := ParamValue('/COM')
  else
    BrickComm.Port := 'usb';
  if BrickComm.Open then
  begin
    while not Eof do
    begin
      Readln(tmpStr);
      tmpStr := StringReplace(tmpStr, ' ', ',', [rfReplaceAll]);
      WriteLn(BC.SendRawCommand(tmpStr, False));
    end;
    BrickComm.Close;
  end;
  BrickComm.Free;
end.