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
program evc;

{$APPTYPE CONSOLE}

uses
{$IFNDEF FPC}
  FastMM4 in '..\FastMM4.pas',
  FastMM4Messages in '..\FastMM4Messages.pas',
  FastMove in '..\FastMove.pas',
{$ENDIF}
{$IFDEF CAN_DOWNLOAD}
  uGlobals in '..\uGlobals.pas',
{$ENDIF}
  Classes,
  SysUtils,
  uCmdLineUtils in '..\uCmdLineUtils.pas',
  uLocalizedStrings in '..\uLocalizedStrings.pas',
  ParamUtils in '..\ParamUtils.pas',
  uVersionInfo in '..\uVersionInfo.pas',
  mwGenericLex in '..\mwGenericLex.pas',
  uCommonUtils in '..\uCommonUtils.pas',
  uGenLexer in '..\uGenLexer.pas',
  uEVCLexer in '..\uEVCLexer.pas',
  uEVALexer in '..\uEVALexer.pas',
  uEVCInterface in 'uEVCInterface.pas',
  uEVAClasses in 'uEVAClasses.pas',
  uEVCComp in 'uEVCComp.pas';

{$IFNDEF FPC}
{$R *.RES}
{$ENDIF}

{$I evc_preproc.inc}

procedure PrintUsage;
begin
  PrintVersion(COMPILATION_TIMESTAMP);
  WriteLn(Format(UsageSyntax, [progName]));
  WriteLn('');
  WriteLn('   -T=<target>: target can be EV3');
{$IFDEF CAN_DOWNLOAD}
  WriteLn(UsagePort);
  Writeln(UsageDownload);
  Writeln(UsageRunProg);
  Writeln(UsageBinary);
  Writeln(UsageQuiet);
{$ENDIF}
  Writeln(UsageDefine);
//  Writeln('   -U=<sym>: undefine macro <sym>');
  Writeln(UsageDecompile);
  Writeln(UsageOptimize);
  Writeln(UsageMaxErrors);
  Writeln(UsageMaxDepth);
  Writeln(UsageOutput);
  Writeln(UsageErrors);
  Writeln(UsageIncludes);
  Writeln(UsageASMOutput);
  Writeln(UsageListing);
  Writeln(UsageSymbols);
  Writeln(UsageWarnings);
  Writeln(UsageStatusMsg);
  Writeln(UsageEnhanced);
  Writeln(UsageEV3FirmVer);
  Writeln(UsageHelp);
  // compiler also takes an undocumented "ev3 name" parameter which is
  // used to tell the compiler what the downloaded program should be called
  // on the EV3: -N=<ev3name>
end;

type
  TStatusChangeHandler = class
  public
    procedure HandleCompilerStatusChange(Sender : TObject; const StatusMsg : string; const bDone : boolean);
  end;

var
  C : TEVCCompiler;
  F : TextFile;
  i : integer;
  Filename : string;
  TheErrorCode : integer;
  SCH : TStatusChangeHandler;
  gNoStatusMessages : Boolean;

procedure HandleWriteMessages(aStrings : TStrings);
var
  i : integer;
begin
  // write compiler messages to output
  if redirectErrorsToFile then
  begin
    for i := 0 to aStrings.Count - 1 do
      WriteLn(F, aStrings[i]);
  end
  else
  begin
    for i := 0 to aStrings.Count - 1 do
      WriteLn(ErrOutput, aStrings[i]);
  end;
end;

{ TStatusChangeHandler }

procedure TStatusChangeHandler.HandleCompilerStatusChange(Sender: TObject;
  const StatusMsg: string; const bDone : boolean);
var
  msg : string;
begin
  if gNoStatusMessages then Exit;
  msg := '# Status: ' + StatusMsg;
  WriteLn(Output, msg);
end;

begin
  TheErrorCode := 0;

SCH := TStatusChangeHandler.Create;
try
  if ParamSwitch('-help', False) then
  begin
    PrintUsage;
    Exit;
  end;

  if ParamCount = 0 then
  begin
    PrintUsageError(COMPILATION_TIMESTAMP);
    TheErrorCode := 1;
    Exit;
  end;

{$IFDEF CAN_DOWNLOAD}
  if ParamSwitch('/UserPath', False) then
    UserDataLocalPath := IncludeTrailingPathDelimiter(ParamValue('/UserPath', False));
{$ENDIF}

  Filename := getFilenameParam();
  if Trim(Filename) = '' then
  begin
    PrintUsageError(COMPILATION_TIMESTAMP);
    TheErrorCode := 1;
    Exit;
  end;

  try
    C := TEVCCompiler.Create;
    try
      LoadParamDefinitions(C.ExtraDefines);
      C.OnCompilerStatusChange   := SCH.HandleCompilerStatusChange;
      C.OnWriteMessages          := HandleWriteMessages;
      C.InputFilename            := Filename;
      C.DefaultIncludeDir        := DEFAULT_INCLUDE_DIR;
      C.Quiet                    := ParamSwitch('-q', False);
      C.MaxErrors                := ParamIntValue('-ER', 0, False);
      C.MaxPreprocessorDepth     := ParamIntValue('-PD', 10, False);
      C.FirmwareVersion          := ParamIntValue('-v', 105, False);
      C.WriteCompilerOutput      := ParamSwitch('-L', False);
      C.CompilerOutputFilename   := ParamValue('-L', False);
      C.WriteSymbolTable         := ParamSwitch('-Y', False);
      C.SymbolTableFilename      := ParamValue('-Y', False);
      C.WriteIntermediateCode    := ParamSwitch('-asm', False);
      C.IntermediateCodeFilename := ParamValue('-asm', False);
      C.WriteOutput              := ParamSwitch('-O', False);
      C.OutputFilename           := ParamValue('-O', False);
      C.UseSpecialName           := ParamSwitch('-N', False);
      C.SpecialName              := ParamValue('-N', False);
      C.OptimizationLevel        := 1;
      if ParamValue('-T', False) = 'EV3' then
        C.Target := dtEV3
      else
        C.Target := dtEV3;
      if ParamSwitch('-Z', False) then
        C.OptimizationLevel      := 2
      else if ParamSwitch('-Z6', False) then
        C.OptimizationLevel      := 6
      else if ParamSwitch('-Z5', False) then
        C.OptimizationLevel      := 5
      else if ParamSwitch('-Z4', False) then
        C.OptimizationLevel      := 4
      else if ParamSwitch('-Z3', False) then
        C.OptimizationLevel      := 3
      else if ParamSwitch('-Z2', False) then
        C.OptimizationLevel      := 2
      else if ParamSwitch('-Z1', False) then
        C.OptimizationLevel      := 1
      else if ParamSwitch('-Z0', False) then
        C.OptimizationLevel      := 0;
      C.UsePort                  := ParamSwitch('-S', False);
      C.PortName                 := ParamValue('-S', False);
      C.BinaryInput              := ParamSwitch('-b', False);
      C.Download                 := ParamSwitch('-d', False) or ParamSwitch('-r', False);
      C.RunProgram               := ParamSwitch('-r', False);
      C.MoreIncludes             := ParamSwitch('-I', False);
      C.IncludePaths             := ParamValue('-I', False);
      C.WarningsAreOff           := ParamSwitch('-w-', False);
      C.EnhancedFirmware         := ParamSwitch('-EF', False);
      C.WriteCompilerMessages    := ParamSwitch('-E', False);
      C.CompilerMessagesFilename := ParamValue('-E', False);
      gNoStatusMessages          := ParamSwitch('-sm-', False);
      if Filename <> '' then
      begin
        if ParamSwitch('-x', False) then
        begin
          C.Decompile;
          for i := 0 to C.Decompilation.Count - 1 do
            WriteLn(C.Decompilation[i]);
        end
        else
        begin
          setErrorOutputFile(F);
          try
            TheErrorCode := C.Execute;
          finally
            CloseFile(F);
          end;
        end;
      end;
    finally
      C.Free;
    end;
  except
    TheErrorCode := 1;
  end;

finally
  SCH.Free;
  if TheErrorCode <> 0 then
    Halt(TheErrorCode);
end;

end.
