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
program wavrsocvt;

{$APPTYPE CONSOLE}

uses
{$IFNDEF FPC}
  FastMM4 in 'FastMM4.pas',
  FastMM4Messages in 'FastMM4Messages.pas',
  FastMove in 'FastMove.pas',
{$ENDIF}
  SysUtils,
  Classes,
  uCmdLineUtils in 'uCmdLineUtils.pas',
  uVersionInfo in 'uVersionInfo.pas',
  ParamUtils in 'ParamUtils.pas',
  uSrcZoh in 'samplerate\uSrcZoh.pas',
  uSrcLinear in 'samplerate\uSrcLinear.pas',
  uSrcSinc in 'samplerate\uSrcSinc.pas',
  uSrcCommon in 'samplerate\uSrcCommon.pas',
  uSrc in 'samplerate\uSrc.pas',
  uCommonUtils in 'uCommonUtils.pas',
  uWav2RsoCvt in 'uWav2RsoCvt.pas';


{$IFDEF WIN32}
{$R *.RES}
{$ENDIF}

var
  SL : TStringList;
  filename : string;
  outputdir : string;
  i : integer;

{$I wavrsocvt_preproc.inc}

function UseCompression : boolean;
begin
  Result := ParamSwitch('-c', false);
end;

function SampleRate : Cardinal;
begin
  Result := ParamIntValue('-r', RSO_DEFAULT_RATE, false);
end;

function ResampleMethod : integer;
begin
  Result := ParamIntValue('-m', SRC_NONE, false);
  if (Result > SRC_NONE) or (Result < SRC_SINC_BEST_QUALITY) then
    Result := SRC_NONE;
end;

function GetOutputDir : string;
begin
  Result := ParamValue('-O', false);
  if Result = '' then
    Result := DEFAULT_INCLUDE_DIR;
  if Result = '' then
    Result := ExtractFilePath(filename);
  if Result = '' then
    Result := ExtractFilePath(ParamStr(0));
end;

procedure PrintUsage;
begin
  PrintVersion(COMPILATION_TIMESTAMP);
  WriteLn('Syntax: ' + progName + ' [options] filename [options]');
  WriteLn('');
  Writeln('   -r=<rate> : output sample rate (wav->rso only)');
  WriteLn('   -m=<method> : resample method (0|1|2=sinc 96%|90%|80%, 3=zoh, 4=linear)');
  Writeln('   -c : use compression (wav->rso only)');
  Writeln('   -O=<path> : specify output directory');
  Writeln('   -help : display command line options');
end;

begin

{$IFDEF FPC}
  VerCompanyName      := 'JoCar Consulting';
  VerFileDescription  := '';
  VerFileVersion      := '1.1.3.2';
  VerInternalName     := 'wavrsocvt';
  VerLegalCopyright   := 'Copyright (c) 2006, John Hansen';
  VerOriginalFileName := 'wavrsocvt';
  VerProductName      := 'WAV/RSO Converter';
  VerProductVersion   := '1.1';
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

  outputdir := GetOutputDir;
  SL := TStringList.Create;
  try
    if LowerCase(ExtractFileExt(filename)) = '.rso' then
      ConvertRSO2Wave(filename, outputdir, SL)
    else
      ConvertWave2RSO(filename, outputdir, SampleRate, ResampleMethod, UseCompression, SL);
    for i := 0 to SL.Count - 1 do
      WriteLn(SL[i]);
  finally
    SL.Free;
  end;
end.
