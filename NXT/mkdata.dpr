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
program mkdata;

{$APPTYPE CONSOLE}

uses
  Classes,
  SysUtils,
  uCmdLineUtils in '..\uCmdLineUtils.pas',
  ParamUtils in '..\ParamUtils.pas',
  uVersionInfo in '..\uVersionInfo.pas';

procedure PrintUsage;
begin
  WriteLn('Usage: ' + progName + ' sourceFile destFile arrayName');
end;

var
  srcFile, destFile, arrayName : string;
  MS : TMemoryStream;
  destMS : TMemoryStream;
  tmp : string;

const
  ENDING = #13#10;
  HEADER = 'unit %s;'+ ENDING +
           ENDING +
           'interface' + ENDING +
           ENDING +
           'const' + ENDING +
           '  %s : array[0..%d] of byte = (' + ENDING;
  FOOTER = '  );' + ENDING +
           ENDING +
           'implementation' + ENDING +
           ENDING +
           'end.' + ENDING;
  SPACES = '  ';

procedure WriteBytes(src, dest : TStream);
var
  val : string;
  i : integer;
  b : byte;
begin
// write the contents of src to dest as a stream of
// comma-separated hexadecimal byte values.
{
  $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e,$0f,
  $10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1a,$1b,$1c,$1d,$1e,$1f,
  etc
}
  src.Position := 0;
  i := 0;
  b := 0;
  val := SPACES;
  dest.Write(PChar(val)^, Length(val));
  while src.Read(b, 1) = 1 do
  begin
    val := Format('$%2.2x', [b]);
    if src.Position < src.Size then
      val := val + ',';
    inc(i);
    dest.Write(PChar(val)^, Length(val));
    if i mod 16 = 0 then
    begin
      val := ENDING;
      dest.Write(PChar(val)^, Length(val));
      val := SPACES;
      dest.Write(PChar(val)^, Length(val));
    end;
  end;
  val := ENDING;
  dest.Write(PChar(val)^, Length(val));
end;

begin
  if ParamCount <> 3 then
  begin
    PrintUsage;
    Exit;
  end;

  srcFile := ParamStr(1);
  destFile := ParamStr(2);
  arrayName := ParamStr(3);
  MS := TMemoryStream.Create;
  try
    MS.LoadFromFile(srcFile);
    destMS := TMemoryStream.Create;
    try
      tmp := Format(HEADER, [ChangeFileExt(destFile, ''), arrayName, MS.Size-1]);
      destMS.Write(PChar(tmp)^, Length(tmp));
      WriteBytes(MS, destMS);
      tmp := FOOTER;
      destMS.Write(PChar(tmp)^, Length(tmp));
      destMS.SaveToFile(destFile);
    finally
      destMS.Free;
    end;

  finally
    MS.Free;
  end;
end.
