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
unit uDebugLogging;

interface

uses
  SysUtils;

procedure DebugLog(const aMsg : string); overload;
procedure DebugLog(E : EAccessViolation); overload;
procedure DebugFmt(const aFormat: string; const Args: array of const);

implementation

{$IFNDEF FPC}
uses
  Windows;
{$ELSE}
//uses
//  dbugintf;
{$ENDIF}

procedure WriteToLog(const aMsg : string);
begin
{$IFNDEF FPC}
  OutputDebugString(PChar(aMsg));
{$ELSE}
  if aMsg <> '' then
    ;
//  WriteLn(aMsg);
//  SendDebug(aMsg);
{$ENDIF}
end;

procedure DebugLog(const aMsg : string);
begin
  WriteToLog(aMsg);
end;

procedure DebugLog(E: EAccessViolation);
begin
  WriteToLog(E.Message);
{$IFNDEF FPC}
//  if Assigned(E.ExceptionRecord) then
//  begin
//    E.ExceptionRecord^.ExceptionCode
//    E.ExceptionRecord^.ExceptionFlags
//    E.ExceptionRecord^.ExceptionAddress
//    E.ExceptionRecord^.NumberParameters
//  end;
{$ENDIF}
end;

procedure DebugFmt(const aFormat: string; const Args: array of const);
var
  msg : string;
begin
  msg := Format(aFormat, Args);
  WriteToLog(msg);
end;

end.