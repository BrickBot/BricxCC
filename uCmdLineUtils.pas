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
unit uCmdLineUtils;

interface

uses
  Classes;

function progName : string;
procedure PrintVersion(const ts : string = '');
procedure PrintUsageError(const ts : string = '');
function redirectErrorsToFile : boolean;
procedure setErrorOutputFile(var F : TextFile);
function getIncludePath : string;

implementation

uses
  SysUtils, ParamUtils, uVersionInfo, uLocalizedStrings;

function progName : string;
begin
  Result := ExtractFileName(ParamStr(0));
  Result := ChangeFileExt(Result, '');
end;

procedure PrintVersion(const ts : string);
var
  V : TVersionInfo;
  app, tmp : string;
begin
  app := ParamStr(0);
  V := GetVersionInfo(app);
  tmp := V.ProductName + VersionString + V.ProductVersion + ' (' +  V.FileVersion;
  if ts <> '' then
    tmp := tmp + ',' + BuiltString + ts;
  tmp := tmp + ')';
  Writeln(tmp);
  Writeln('     ' + V.LegalCopyright);
end;

procedure PrintUsageError(const ts : string);
begin
  PrintVersion(ts);
  Writeln(Format(UsageErrorMessage, [progName]));
end;

function redirectErrorsToFile : boolean;
begin
  Result := ParamSwitch('-E', false);
end;

procedure setErrorOutputFile(var F : TextFile);
var
  val, dir : string;
begin
  val := '';
  if ParamSwitch('-E', false) then
  begin
    val := ParamValue('-E', false);
    dir := ExtractFilePath(val);
    if dir <> '' then
      ForceDirectories(dir);
  end;
  AssignFile(F, val);
  Rewrite(F);
end;

function getIncludePath : string;
begin
  Result := ExtractFilePath(ParamStr(0));
  if ParamSwitch('-I', false) then
  begin
    Result := ParamValue('-I', false);
  end;
end;

end.
