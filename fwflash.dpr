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
program fwflash;

{$APPTYPE CONSOLE}

uses
{$IFNDEF FPC}
  FastMM4 in 'FastMM4.pas',
  FastMM4Messages in 'FastMM4Messages.pas',
  FastMove in 'FastMove.pas',
  Windows,
{$ENDIF}
  SysUtils,
  Classes,
  uCmdLineUtils in 'uCmdLineUtils.pas',
  uVersionInfo in 'uVersionInfo.pas',
  ParamUtils in 'ParamUtils.pas',
  uCommonUtils in 'uCommonUtils.pas',
  libnxt in 'bricktools\libnxt.pas';


{$IFDEF WIN32}
{$R *.RES}
{$ENDIF}

var
  filename : string;
  res, RetryCount : integer;
  nxt : PNxt;


{$I fwflash_preproc.inc}

procedure PrintUsage;
begin
  PrintVersion(COMPILATION_TIMESTAMP);
  WriteLn('Syntax: ' + progName + ' <firmware image to write>');
  WriteLn('');
  WriteLn('Example: ' + progName + ' lms.rfw');
end;

procedure handle_error(nxt : PNxt; msg : string; err : integer);
begin
  WriteLn(Format('%s: %s', [msg, nxt_str_error(err)]));
  if nxt <> nil then
    nxt_close(nxt);
  Halt(err);
end;


begin

{$IFDEF FPC}
  VerCompanyName      := 'JoCar Consulting';
  VerFileDescription  := '';
  VerFileVersion      := '0.1.0.0';
  VerInternalName     := 'fwflash';
  VerLegalCopyright   := 'Copyright (c) 2011, John Hansen';
  VerOriginalFileName := 'fwflash';
  VerProductName      := 'NXT Firmware Flash';
  VerProductVersion   := '0.1';
  VerComments         := '';
{$ENDIF}

  if ParamSwitch('-help', False) then
  begin
    PrintUsage;
    Exit;
  end;

  if ParamCount = 0 then
  begin
    PrintUsageError(COMPILATION_TIMESTAMP);
    Exit;
  end;

  filename := getFilenameParam();
  if Trim(filename) = '' then
  begin
    PrintUsageError(COMPILATION_TIMESTAMP);
    Exit;
  end;

  WriteLn('Checking firmware... ');

  res := nxt_firmware_validate(filename);
  if res <> NXT_OK then
    handle_error(nil, 'Error', res);

  WriteLn('OK.');

  res := nxt_init(nxt);
  try
    if res <> NXT_OK then
      handle_error(nil, 'Error during library initialization', res);

    res := nxt_find(nxt);
    if res <> NXT_OK then
    begin
      if res = NXT_NOT_PRESENT then
        WriteLn('NXT not found. Is it properly plugged in via USB?')
      else
        handle_error(nil, 'Error while scanning for NXT', res);
      Halt(1);
    end;

    if not nxt_in_samba_mode(nxt) then
    begin
      WriteLn('NXT found, but not running in reset mode.  Rebooting it into SAMBA mode.');
      res := nxt_open(nxt);
      if res <> NXT_OK then
        handle_error(nil, 'Error while connecting to NXT', res);
      res := nxt_boot_into_samba(nxt);
      if res = NXT_OK then
      begin
        nxt_close(nxt);
        RetryCount := 0;
        repeat
          Write('.');
          Sleep(500);
          res := nxt_find(nxt);
          Inc(RetryCount);
        until nxt_in_samba_mode(nxt) or (RetryCount > 60);
        WriteLn('');
        WriteLn('Hopefully that was long enough...');
        if res <> NXT_OK then
        begin
          if res = NXT_NOT_PRESENT then
            WriteLn('NXT not found. Is it properly plugged in via USB?')
          else
            handle_error(nil, 'Error while scanning for NXT', res);
          Halt(1);
        end;
      end;
    end;

    if not nxt_in_samba_mode(nxt) then
    begin
      WriteLn('NXT found, but not running in reset mode.');
      WriteLn('Please reset your NXT manually and restart this program.');
      Halt(2);
    end;

    res := nxt_open(nxt);
    if res <> NXT_OK then
      handle_error(nil, 'Error while connecting to NXT', res);

    WriteLn('NXT device in reset mode located and opened.');
    WriteLn('Starting firmware flash procedure now...');

    res := nxt_firmware_flash(nxt, filename);
    if res <> NXT_OK then
      handle_error(nxt, 'Error flashing firmware', res);

    WriteLn('Firmware flash complete.');

    res := nxt_jump(nxt, $00100000);
    if res <> NXT_OK then
      handle_error(nxt, 'Error booting new firmware', res);

    WriteLn('New firmware started!');

    res := nxt_close(nxt);
    if res <> NXT_OK then
      handle_error(nil, 'Error while closing connection to NXT', res);
  finally
    nxt_finalize(nxt);
  end;
end.
