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
program a792rfw;

{$APPTYPE CONSOLE}

uses
  Classes, SysUtils, ParamUtils, uCmdLineUtils;

{$R *.RES}

procedure PrintUsage;
begin
  PrintVersion;
  Writeln('Usage: ' + progName + ' filename.a79');
  Writeln('   -help : display command line options');
end;

var
  filename : string;
  inStr : TFileStream;
  outStr : TMemoryStream;
  b : Byte;
  i, oldSize : integer;

const
  SIZEOFFLASH = 262144;

begin
  { TODO -oUser -cConsole Main : Insert code here }
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

  inStr := TFileStream.Create(filename, fmOpenRead);
  try
    outStr := TMemoryStream.Create;
    try
      outStr.CopyFrom(inStr, 0);
      oldSize := inStr.Size;
      if oldSize < SIZEOFFLASH then
      begin
        outStr.Size := SIZEOFFLASH;
        b := $FF;
        for i := 1 to SIZEOFFLASH - oldSize do
          outStr.Write(b, 1);
      end;
      outStr.SaveToFile(ChangeFileExt(filename, '.rfw'));
    finally
      outStr.Free;
    end;
  finally
    inStr.Free;
  end;

end.
