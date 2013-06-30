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
program sprobin2obj;

{$APPTYPE CONSOLE}

uses
  Classes,
  SysUtils, 
  uSProObjUtils in 'uSProObjUtils.pas',
  ParamUtils in '..\ParamUtils.pas',
  uCmdLineUtils in '..\uCmdLineUtils.pas';

{$IFNDEF FPC}
{$R *.RES}
{$ENDIF}

procedure PrintUsage;
begin
  PrintVersion;
  Writeln('Usage: ' + progName + ' filename.bin');
  Writeln('   -help : display command line options');
end;

var
  filename : string;
  inStr : TFileStream;
  outStr : TMemoryStream;
  b : Byte;
  i, oldSize : integer;

begin

  if ParamCount = 0 then
  begin
    PrintUsageError;
    Exit;
  end;

  if ParamSwitch('-help') then
  begin
    PrintUsage;
    Exit;
  end;

  filename := ParamStr(1);

  if FileExists(filename) then
  begin
    inStr := TFileStream.Create(filename, fmOpenRead);
    try
      outStr := TMemoryStream.Create;
      try
        SProBinToObj(inStr, outStr);
        outStr.SaveToFile(ChangeFileExt(filename, '.obj'));
      finally
        outStr.Free;
      end;
    finally
      inStr.Free;
    end;
  end;

end.