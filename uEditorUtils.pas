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
unit uEditorUtils;

interface

uses
  Classes, StdCtrls, SynEdit, SynEditMiscClasses, uNBCCommon, uBasicPrefs,
  uPSComponent, uProgram, uCompCommon;

type
  TDisplayErrorsProc = procedure(aShow : boolean) of object;
  TExecTransferProc = procedure(TI: TTransferItem) of object;

function GetLineNumber(const aY : integer) : integer;
procedure GenerateEV3Makefile(aPath : string);
procedure GenerateRCXMakefile(aPath : string; run : Boolean; node : Integer = -1);
function ProcessEV3MakeCommand(const sFilename, sTempDir, commandstr : string) : string;
function ProcessRCXMakeCommand(const sFilename, sTempDir, commandstr : string) : string;
function GetTarget : string;
function DoExecuteCommand(const aCmd : string; const aParams : string;
  aTimeOut : integer; const aDir : string; const bWait : boolean) : integer;

procedure ShowSearchReplaceDialog(aEditor : TSynEdit; AReplace: boolean);
procedure DoSearchReplaceText(aEditor : TSynEdit; AReplace, ABackwards: boolean);

function CompileIt(DisplayErrorsProc : TDisplayErrorsProc; theCode : TStrings;
  lstErrors : TStrings; const fName, fCaption : string;
  download : Boolean; run : Boolean; sceHandler : TCompilerStatusChangeEvent;
  osHandler : TNotifyEvent): boolean;
procedure ReadSymbolFile(aProg : TProgram; const sFilename : string);

procedure AddPaths(aPath : string; aPaths : TStrings);

var
  localSearchFromCaret: boolean;

var
  seRegex : TSynEditSearchCustom;
  seNormal : TSynEditSearchCustom;
  DoExecuteTransferItem : TExecTransferProc;
  theROPSCompiler : TPSScriptDebugger;

implementation

uses
{$IFNDEF FPC}
  Windows, ExecProgram,
{$ENDIF}
  Controls, SysUtils, Dialogs,
  SynEditTypes, SynEditHighlighter,
  uGlobals, dlgConfirmReplace, dlgSearchText, rcx_constants, uSpirit,
  dlgReplaceText, uMiscDefines, brick_common, CodeUnit, uLocalizedStrings,
  uNBCInterface, ParamUtils,
  uPSDisassembly, uCompStatus, uDebugLogging;

function GetLineNumber(const aY : integer) : integer;
begin
  Result := aY;
  if ZeroStart and ShowLineNumbers then
    dec(Result);
end;

function GetTarget : string;
begin
  case LocalBrickType of
    SU_CYBERMASTER : Result := 'CM';
    SU_SCOUT       : Result := 'Scout';
    SU_RCX2        : Result := 'RCX2';
    SU_SPYBOTIC    : Result := 'Spy';
    SU_SWAN        : Result := 'Swan';
    SU_NXT         : Result := 'NXT';
    SU_SPRO        : Result := 'SPC';
    SU_EV3         : Result := 'EV3';
  else
                     Result := 'RCX';
  end;
end;

procedure DoSearchReplaceText(aEditor : TSynEdit; AReplace, ABackwards: boolean);
var
  Options: TSynSearchOptions;
begin
  if AReplace then
    Options := [ssoPrompt, ssoReplace, ssoReplaceAll]
  else
    Options := [];
  if ABackwards then
    Include(Options, ssoBackwards);
  if gbSearchCaseSensitive then
    Include(Options, ssoMatchCase);
  if not localSearchFromCaret then
    Include(Options, ssoEntireScope);
  if gbSearchSelectionOnly then
    Include(Options, ssoSelectedOnly);
  if gbSearchWholeWords then
    Include(Options, ssoWholeWord);
{$IFNDEF FPC}
  if gbSearchRegex then
    aEditor.SearchEngine := seRegex
  else
    aEditor.SearchEngine := seNormal;
{$ENDIF}
  if aEditor.SearchReplace(gsSearchText, gsReplaceText, Options) = 0 then
  begin
    DoBeep(MB_ICONASTERISK);
    if ssoBackwards in Options then
      aEditor.BlockEnd := aEditor.BlockBegin
    else
      aEditor.BlockBegin := aEditor.BlockEnd;
    aEditor.CaretXY := aEditor.BlockBegin;
  end;

  if ConfirmReplaceDialog <> nil then
    ConfirmReplaceDialog.Free;
end;

procedure ShowSearchReplaceDialog(aEditor : TSynEdit; AReplace: boolean);
var
  dlg: TTextSearchDialog;
begin
  if AReplace then
    dlg := TTextReplaceDialog.Create(nil)
  else
    dlg := TTextSearchDialog.Create(nil);
  with dlg do
  try
    // assign search options
    SearchBackwards := gbSearchBackwards;
    SearchCaseSensitive := gbSearchCaseSensitive;
    SearchFromCursor := gbSearchFromCaret;
    SearchInSelectionOnly := gbSearchSelectionOnly;
    // start with last search text
    SearchText := gsSearchText;
    if gbSearchTextAtCaret then begin
      // if something is selected search for that text
      if aEditor.SelAvail and (aEditor.BlockBegin.Y = aEditor.BlockEnd.Y)
      then
        SearchText := aEditor.SelText
      else
        SearchText := aEditor.GetWordAtRowCol(aEditor.CaretXY);
    end;
    SearchTextHistory := gsSearchTextHistory;
    if AReplace then with dlg as TTextReplaceDialog do begin
      ReplaceText := gsReplaceText;
      ReplaceTextHistory := gsReplaceTextHistory;
    end;
    SearchWholeWords := gbSearchWholeWords;
    SearchRegularExpression := gbSearchRegex;
    if ShowModal = mrOK then begin
      gbSearchBackwards := SearchBackwards;
      gbSearchCaseSensitive := SearchCaseSensitive;
      gbSearchFromCaret := SearchFromCursor;
      gbSearchSelectionOnly := SearchInSelectionOnly;
      gbSearchWholeWords := SearchWholeWords;
      gbSearchRegex := SearchRegularExpression;
      gsSearchText := SearchText;
      gsSearchTextHistory := SearchTextHistory;
      if AReplace then with dlg as TTextReplaceDialog do begin
        gsReplaceText := ReplaceText;
        gsReplaceTextHistory := ReplaceTextHistory;
      end;
      localSearchFromCaret := gbSearchFromCaret;
      if gsSearchText <> '' then begin
        DoSearchReplaceText(aEditor, AReplace, gbSearchBackwards);
        localSearchFromCaret := True;
      end;
    end;
  finally
    dlg.Free;
  end;
end;

function GetNBCErrorString(iErrCode : Integer) : string;
begin
  case iErrCode of
    -1 : Result := 'Compile failure.';
    -2 : Result := 'Download to the NXT failed.';
    -3 : Result := 'Firmware version on NXT does not match targetted firmware version';
  else
    Result := 'Unknown NBC error code (' + IntToStr(iErrCode) + ')';
  end;
end;

function GetLASMErrorString(iErrCode : Integer) : string;
begin
  case iErrCode of
    -2 : Result := 'vpbcom.dll not registered or unable to load its DLLs';
    -3 : Result := 'serial port could not be opened and/or configured';
    -4 : Result := 'tower not connected';
    -5 : Result := 'tower not alive';
    -6 : Result := 'no (or invalid) PBrick response';
    -7 : Result := 'no firmware in PBrick';
    -8 : Result := 'battery level too low';
    -9 : Result := 'wrong brick type';
    -11 : Result := 'PBrick comms failed';
    -12 : Result := 'compiler was too busy';
    -13 : Result := 'no driver found';
    -14 : Result := 'failed to unlock PBrick';
  else
    Result := 'Unknown LCC32 error code (' + IntToStr(iErrCode) + ')';
  end;
end;

function GetRCXErrorString(iErrCode : Integer) : string;
begin
  case iErrCode of
    kRCX_OpenSerialError : Result := 'serial port could not be opened and/or configured';
    kRCX_IREchoError     : Result := 'no echo received from IR tower';
    kRCX_ReplyError      : Result := 'no (or invalid) reply from RCX';
    kRCX_RequestError    : Result := 'attempt to send too much data';
    kRCX_FileError       : Result := 'could not open/read/write file';
    kRCX_FormatError     : Result := 'unknown file format';
    kRCX_AbortError      : Result := 'canceled by RCX_Link::DownloadProgress()';
    kRCX_MemFullError    : Result := 'not enough room in RCX program memory';
  else
    Result := '';
  end;
end;

function GetGNUErrorString(iErrCode : Integer) : string;
begin
  case iErrCode of
    -2 : Result := 'Errors found during compilation';
  else
    Result := 'Unknown GNU error code (' + IntToStr(iErrCode) + ')';
  end;
end;

function OptionalEquals : string;
begin
  Result := '';
  if not FileIsNQC then
    Result := '=';
end;

function TempPath: string;
var
  i: integer;
begin
  SetLength(Result, MAX_PATH);
{$IFNDEF FPC}
  i := GetTempPath(Length(Result), PChar(Result));
  SetLength(Result, i);
{$ELSE}
  Result := '~';
{$ENDIF}
  IncludeTrailingPathDelimiter(Result);
end;

function GetIncludeDirectives(aPath : string) : string;
var
  p : Integer;
  s : string;
  OE : string;
begin
  Result := '';
  OE := OptionalEquals;
  if FileIsNQC then
  begin
    p := Pos(';', aPath);
    while p > 0 do
    begin
      s := Copy(aPath, 1, p - 1);
      Delete(aPath, 1, p);
      Result := Result + ' -I' + OE + '"' + s + '"';
      p := Pos(';', aPath);
    end;
  end;
  Result := Result + ' -I' + OE + '"' + aPath + '"';
end;

function GetCompilerSwitches : string;
begin
  Result := CompilerSwitches;
  if FileIsNQC then
    Result := Result + ' ' + NQCSwitches
  else if FileIsMindScriptOrLASM then
    Result := Result + ' ' + LCCSwitches
  else if UseNBCCompiler then
    Result := Result + ' ' + NBCSwitches
  else if FileIsJava then
    Result := Result + ' ' + JavaSwitches
  else if FileIsCPP or FileIsPascal then
    Result := Result + ' ' + CPPSwitches;
end;

function ProcessEV3MakeCommand(const sFilename, sTempDir, commandstr : string) : string;
var
  cmdFile : string;
  redir : string;
begin
  Result := commandstr;
  redir := ' > ';
  if FileIsCPP then
    redir := ' 2> ';
  if sTempDir <> '' then
    Result := Result + redir + '"' + sTempdir + 'temp.log"';
  cmdFile := ChangeFileExt(sFilename, '.bat');
  if FileExists(cmdFile) then
    DeleteFile(cmdFile);
  with TFileStream.Create(cmdFile, fmCreate) do
  try
    Write(PChar(Result)^, Length(Result));
  finally
    Free;
  end;
  Result := '"' + cmdFile + '"';
end;

function ProcessRCXMakeCommand(const sFilename, sTempDir, commandstr : string) : string;
var
  cmdFile : string;
begin
  // switch to unix-style slash for log file path
  Result := commandstr;
  if sTempDir <> '' then
    Result := Result + ' >& "' +
      StringReplace(sTempdir, '\', '/', [rfReplaceAll]) + 'temp.log"';
  cmdFile := ChangeFileExt(sFilename, '.cmd');
  if FileExists(cmdFile) then
    DeleteFile(cmdFile);
  with TFileStream.Create(cmdFile, fmCreate) do
  try
    Write(PChar(Result)^, Length(Result));
  finally
    Free;
  end;
  Result := {IncludeTrailingPathDelimiter(CygwinDir) + 'bin\' + }'bash "' + cmdFile + '"';
end;

function GetProperExtension(aFile : string) : string;
begin
  result := ExtractFileExt(aFile);
  if result = '' then
  begin
    case PreferredLanguage of
      1 : Result := '.lsc';
      2 : Result := '.asm';
      3 : Result := '.nbc';
      4 : Result := '.nxc';
      5 : Result := '.spc';
      6 : Result := '.evc';
    else
      if LocalBrickType = SU_NXT then
        Result := '.nxc'
      else if LocalBrickType = SU_EV3 then
        Result := '.evc'
      else
        Result := '.nqc';
    end;
  end;
end;

function GetCompilerCommandLine(bDownload : Boolean;
  sTempdir, sIncludePath, sFilename : string;
  sceHandler : TCompilerStatusChangeEvent) : string;
var
  ext, extbin, commandstr, extraSwitches, OE : string;
  H : TSynCustomHighlighter;
  fwVer : word;
  ifw : TInstalledFirmware;
begin
  H := GetActiveEditorHighlighter;
  OE := OptionalEquals;
  ext := GetProperExtension(sFilename);
  {Create the command}
  // default compiler is NQC.
  if FileIsMindScriptOrLASM(H) then
    commandstr := LCCPath
  else if UseNBCCompiler(H) then
    commandstr := NBCPath
  else if FileIsCPPOrPascalOrJava(H) then
  begin
    if IsRCX then
      commandstr := '/bin/make'
    else if IsNXT then
      commandstr := 'make'
    else if IsEV3 then
      commandstr := 'make';
  end
  else if FileIsNQC(H) then
    commandstr := NQCPath
  else
    commandstr := DefaultPath;

  if UseNBCCompiler(H) then
  begin
    commandstr := commandstr + ' -Y="' + ChangeFileExt(sFilename, '.sym') + '"';
    commandstr := commandstr + Format(' -Z%d', [NBCOptLevel]);
    if NBCMaxErrors > 0 then
      commandstr := commandstr + Format(' -ER=%d', [NBCMaxErrors]);
    ifw := ifUnknown;
    fwVer := 0;
    if NXTAutoFWVersion then
    begin
      fwVer := BrickComm.NXTFirmwareVersion;
      ifw   := BrickComm.NXTInstalledFirmware;
    end;
    if NXTAutoFWVersion and (ifw <> ifUnknown) then
    begin
      sceHandler(nil, Format('Automatically setting firmware to %s', [InstalledFirmwareAsString(ifw)]), False);
      if ifw = ifEnhanced then
        commandstr := commandstr + ' -EF';
    end
    else if EnhancedFirmware then
      commandstr := commandstr + ' -EF';
    if NXTAutoFWVersion and (fwVer <> 0) then
    begin
      sceHandler(nil, Format('Automatically setting firmware version to %d', [fwVer]), False);
      commandStr := commandstr + ' -v=' + IntToStr(fwVer);
    end
    else
    begin
      if NXT2Firmware then
        commandstr := commandstr + ' -v=128'
      else
        commandstr := commandstr + ' -v=105';
    end;
    if IgnoreSysFiles then
      commandstr := commandstr + ' -n';
    sIncludePath := sIncludePath + ';' + ExtractFilePath(sFilename);
  end;

  if FileIsNQC(H) and IncludeSrcInList then
    commandstr := commandstr + ' -s';

  if not FileIsCPPOrPascalOrJava(H) then
  begin
    commandstr := commandstr + ' -E' + OE + '"' + sTempdir + 'temp.log"';
    commandstr := commandstr + ' -L' + OE + '"' + sTempdir + 'temp.lst"';
  end;

  if not FileIsCPPOrPascalOrJava(H) then
    commandstr := commandstr + GetIncludeDirectives(sIncludePath);

  extraSwitches := Trim(GetCompilerSwitches);
  if extraSwitches <> '' then
    commandstr := commandstr + ' ' + extraSwitches + ' ';

  if not FileIsCPPOrPascalOrJava(H) then
    commandstr := commandstr + ' -T' + OE + GetTarget;

  if (FileIsNQC(H) or UseNBCCompiler(H)) and SaveBinaryOutput then
  begin
    extbin := '.rcx';
    if FileIsNBC(H) or FileIsNXC(H) then
      extbin := '.rxe'
    else if FileIsNPG(H) then
      extbin := '.rpg'
    else if FileIsSPC(H) then
      extbin := '.bin'
    else if FileIsRICScript(H) then
      extbin := '.ric';
    commandstr := commandstr + ' -O' + OE + '"' + ChangeFileExt(sFilename, extbin) + '"';
  end;

  if bDownload then
  begin
    if not FileIsCPPOrPascalOrJava(H) then
    begin
      commandstr := commandstr + ' -d';
      // the internal NBC compiler does not need the port
      if not (UseNBCCompiler(H) and UseInternalNBC) then
        commandstr := commandstr + ' -S' + OptionalEquals + LocalPort;
      if UseNBCCompiler(H) then
      begin
//        if BrickComm.UseBluetooth then
//          commandstr := commandstr + ' -BT';
        commandstr := commandstr + ' -N="' + sFilename{ExtractFileName(sFilename)} + '"';
      end;
    end
    else
      commandstr := commandstr + ' download ';
  end;

  if not FileIsCPPOrPascalOrJava(H) then
    commandstr := commandstr + ' "' + sTempdir + 'temp' + ext + '"'
  else
    commandstr := commandstr + ' -f"' + ChangeFileExt(sFilename, '.mak') + '" -s';

  if FileIsCPPOrPascalOrJava(H) then
  begin
    if IsRCX then
    begin
      commandstr := ProcessRCXMakeCommand(sFilename, sTempdir, commandstr);
    end
    else if IsNXT then
    begin
    end
    else if IsEV3 then
    begin
      commandstr := ProcessEV3MakeCommand(sFilename, sTempdir, commandstr);
    end;
  end;

  result := commandstr;
end;

function GetIncludePath(sSaveDir : string) : string;
var
  H : TSynCustomHighlighter;
begin
  Result := '';
  H := GetActiveEditorHighlighter;
  if FileIsNQC(H) then
  begin
    if NQCIncludePath <> '' then
      Result := NQCIncludePath + ';' + sSaveDir
    else
      Result := sSaveDir;
  end
  else if FileIsMindScriptOrLASM(H) then
  begin
    if LCCIncludePath <> '' then
      Result := IncludeTrailingPathDelimiter(LCCIncludePath)
    else
      Result := IncludeTrailingPathDelimiter(sSaveDir);
  end
  else if UseNBCCompiler(H) then
  begin
    if NBCIncludePath <> '' then
      Result := NBCIncludePath + ';' + sSaveDir
    else
      Result := sSaveDir
  end;
end;

function GetProjectFiles(aPath : string; ext : string) : string;
var
  p : string;
  i : Integer;
begin
  Result := '';
  p := ChangeFileExt(aPath, '.prj');
  if FileExists(p) then begin
    with TStringList.Create do
    try
      LoadFromFile(p);
      for i := 0 to Count - 1 do begin
        Result := Result + ChangeFileExt(Strings[i], ext) + ' ';
      end;
    finally
      Free;
    end;
  end;
end;

procedure GenerateEV3Makefile(aPath : string);
var
  SL : TStringList;
  H : TSynCustomHighlighter;
  MainSource, ext, mfStr, dobjects : string;
begin
  MainSource := ExtractFileName(aPath);
  ext := ExtractFileExt(MainSource);
  dobjects := GetProjectFiles(aPath, '.o');
  H := GetActiveEditorHighlighter;
  SL := TStringList.Create;
  try
    if not FileIsCPP(H) then
    begin
      // FPC makefile for EV3
      mfStr := StringReplace(EV3MakefileTemplate, '%PROGRAM%', ChangeFileExt(MainSource, ''), [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%DOBJECTS%', dobjects, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%TOOLPREFIX%', EV3FPCPrefix, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%FLAGS%', EV3FPCFlags, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%CCNAME%', 'fpc', [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%MAINSRC%', MainSource, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%LINKONLY%', '', [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%LINKOBJS%', '', [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%EXT%', '.pas', [rfReplaceAll]);
    end
    else
    begin
      // is this a C file or a CPP file?
      // GCC makefile for EV3
      mfStr := StringReplace(EV3MakefileTemplate, '%PROGRAM%', ChangeFileExt(MainSource, ''), [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%DOBJECTS%', dobjects, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%TOOLPREFIX%', EV3GCCPrefix, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%FLAGS%', EV3GCCFlags, [rfReplaceAll]);
      if ext = '.cpp' then
        mfStr := StringReplace(mfStr, '%CCNAME%', 'g++', [rfReplaceAll])
      else
        mfStr := StringReplace(mfStr, '%CCNAME%', 'gcc', [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%MAINSRC%', MainSource, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%LINKONLY%', '-c', [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%LINKOBJS%', dobjects, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%EXT%', ext, [rfReplaceAll]);
    end;
    SL.Text := mfStr;
    SL.SaveToFile(ChangeFileExt(aPath, '.mak'));
  finally
    SL.Free;
  end;
end;

procedure GenerateRCXMakefile(aPath : string; run : Boolean; node : Integer);
var
  SL : TStringList;
  mfStr, tower, prog, exec, addr, port, set_addr : string;
  H : TSynCustomHighlighter;
begin
  H := GetActiveEditorHighlighter;
  SL := TStringList.Create;
  try
    tower := '--tty=';
    tower := tower + LocalPort;
    prog := '--program=' + IntToStr(CurrentProgramSlot+1);
    addr := '--rcxaddr=' + IntToStr(CurrentLNPAddress);
    port := '--srcport=' + IntToStr(CurrentLNPPort);
    set_addr := '--node=' + IntToStr(node);
    if run then
      exec := '--execute'
    else
      exec := '';
    if not FileIsJava(H) then
    begin
      // process BrickOSMakefileTemplate
      mfStr := StringReplace(BrickOSMakefileTemplate, '%os_root%', BrickOSRoot, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%project%', ChangeFileExt(ExtractFileName(aPath), ''), [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%project_files%', GetProjectFiles(aPath, '.o'), [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%prog%', prog, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%tty%', tower, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%exec%', exec, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%addr%', addr, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%port%', port, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%set_addr%', set_addr, [rfReplaceAll]);

      // if file is pascal then add the pascal tail to the end
      if FileIsPascal(H) then
        mfStr := mfStr + K_PASCAL_TAIL;
    end
    else
    begin
      // process LeJOSMakefileTemplate
      mfStr := StringReplace(LeJOSMakefileTemplate, '%project%', ChangeFileExt(ExtractFileName(aPath), ''), [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%project_files%', GetProjectFiles(aPath, '.class'), [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%tty%', tower, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%jdk_dir%', JavaCompilerPath, [rfReplaceAll]);
      mfStr := StringReplace(mfStr, '%os_root%', LeJOSRoot, [rfReplaceAll]);
    end;
    SL.Text := mfStr;
    SL.SaveToFile(ChangeFileExt(aPath, '.mak'));
  finally
    SL.Free;
  end;
end;

function HandleROPSErrors(fname : string; tmpSL : TStrings; lstErrors : TStrings) : boolean;
var
  i, p, lineNo : integer;
  tmpStr, errMsg : string;
begin
  Result := True;
  for i := 0 to tmpSL.Count - 1 do
  begin
    if Pos('[Error]', tmpSL[i]) <> 0 then
    begin
      tmpStr := tmpSL[i];
      System.Delete(tmpStr, 1, 8);
      p := Pos('(', tmpStr);
      if p <> 0 then begin
        errMsg := Copy(tmpStr, 1, p-1);
        if Pos(fname, errMsg) <> 0 then
        begin
          System.Delete(tmpStr, 1, p);
          errMsg := Copy(tmpStr, 1, Pos(':', tmpStr)-1);
          lineNo := StrToIntDef(errMsg, -1);
          if lineNo <> -1 then
          begin
            lineNo := GetLineNumber(lineNo);
            errMsg := 'line ' + IntToStr(lineNo) + ': ';
            p := Pos('):', tmpStr);
            if p <> 0 then begin
              System.Delete(tmpStr, 1, p+1);
              errMsg := errMsg + Trim(tmpStr);
              if lstErrors.IndexOf(errMsg) = -1 then
                lstErrors.Append(errMsg);
              Result := False; // errors exist
            end;
          end;
        end;
      end;
    end;
  end;
end;

function HandleGCCErrors(fname : string; tmpSL : TStrings; lstErrors : TStrings) : boolean;
var
  i, p, j, lineNo : integer;
  tmpstr, errMsg : string;
begin
  Result := True;
  for i := 0 to tmpSL.Count - 1 do
  begin
    // cpp and java
    if Pos('warning:', tmpSL[i]) = 0 then
    begin
      // not a warning.
      p := Pos(':', tmpSL[i]);
      tmpstr := Copy(tmpSL[i], 1, p-1);
      if (Pos(tmpstr, fname) <> 0) or
         (Pos(ChangeFileExt(ExtractFileName(fname), '.o'), tmpstr) <> 0) then
      begin
        tmpstr := Copy(tmpSL[i], p+1, Length(tmpSL[i]));
        j := i;
        while (j < tmpSL.Count-1) do begin
          p := Pos(':', tmpSL[j+1]);
          if Pos(Copy(tmpSL[j+1], 1, p-1), ChangeFileExt(fname, '.o')) = 0 then
          begin
            // linker error
            Break;
          end
          else if Pos(Copy(tmpSL[j+1], 1, p-1), fname) = 0 then
          begin
            // the line following the current line is not a new error message
            // but, rather, a continuation of this error message
            // unless - that is - it starts with the word "make"
            if Pos('make', LowerCase(tmpSL[j+1])) <> 1 then
              tmpstr := tmpstr + ' ' + tmpSL[j+1];
          end
          else begin
            // the next line is a new error message so break
            Break;
          end;
          Inc(j);
        end;
        // tmpstr should be ###: error message
        // if it doesn't start with a number then ignore the line
        errMsg := Copy(tmpstr, 1, Pos(':', tmpstr)-1);
        Delete(tmpstr, 1, Length(errMsg));
        lineNo := StrToIntDef(errMsg, -1);
        if lineNo <> -1 then
        begin
          lineNo := GetLineNumber(lineNo);
          errMsg := 'line ' + IntToStr(lineNo) + tmpstr;
          if lstErrors.IndexOf(errMsg) = -1 then
            lstErrors.Append(errMsg);
          Result := False;
        end
        else begin
          // is this a linker error?
          p := Pos(':', tmpstr);
          if (Pos(Copy(tmpstr, 1, p-1), fName) <> 0) then
          begin
            errMsg := 'linker error:' + Copy(tmpstr, p+1, Length(tmpstr));
            if lstErrors.IndexOf(errMsg) = -1 then
              lstErrors.Append(errMsg);
            Result := False;
          end;
        end;
      end;
    end;
  end;
end;

function HandleLMSErrors(fname : string; tmpSL : TStrings;
  lstErrors : TStrings; ext : string) : boolean;
var
  i, p, q, lineNo : integer;
  tmpstr, testStr, errMsg, tmpName : string;
begin
  Result := True;
  // NQC, LASM, MindScript, NBC, & NXC
  for i := 0 to tmpSL.Count - 1 do
  begin
    // NQC, LASM, MindScript, NBC, & NXC
    if (Pos('# Error:',tmpSL[i])>0) or
       (Pos('# Warning:',tmpSL[i])>0) then
    begin
      tmpstr := Copy(tmpSL[i], 2, MaxInt);
      // show error with line number of following line matches either temp.ext
      // or the filename of the active editor form
      errMsg := tmpstr;
      if i < (tmpSL.Count - 1) then
      begin
        testStr := tmpSL[i+1];
        // modified approach to error/warning output (2009-03-14 JCH)
        tmpName := '';
        // pattern is File "filaname" ; line NNNN
        // (optionally followed by , position NNNN)
        p := Pos('File "', testStr);
        if p > 0 then
        begin
          Delete(testStr, 1, p+5);
          p := Pos('"', testStr);
          if p > 0 then
          begin
            tmpName := Copy(testStr, 1, p-1);
            Delete(testStr, 1, p);
          end;
        end;
        p := Pos('temp'+ext, tmpName);
        if p > 0 then
        begin
          // replace temporary filename with actual filename
          tmpName := fName;
        end;
        p := Pos('; line ', testStr);
{
        tmpName := 'temp' + ext;
        p := Pos(tmpName+'" ; line', testStr);
        if p = 0 then
        begin
          p := Pos(fName+'" ; line', testStr);
          if p > 0 then
            tmpName := fName;
        end;
}
        if p > 0 then
        begin
          // get the line number
          p := p + 7;
//          p := p + Length(tmpName) + 4 + 5;
          q := Pos(', position ', testStr);
          if q > 0 then
            errMsg := Copy(testStr, p, q-p)
          else
            errMsg := Copy(testStr, p, MaxInt);
          lineNo := StrToIntDef(errMsg, -1);
//          linePos := -1;
          if q > 0 then
          begin
            System.Delete(testStr, 1, q+10);
//            linePos := StrToIntDef(testStr, -1);
          end;
          if lineNo <> -1 then
          begin
            lineNo := GetLineNumber(lineNo);
            errMsg := 'line ' + IntToStr(lineNo);
//            if linePos <> -1 then
//              errMsg := errMsg + ', position ' + IntToStr(linePos);
            if AnsiUppercase(tmpName) = AnsiUppercase(fName) then
              errMsg := errMsg + ':' + tmpstr
            else
              errMsg := errMsg + ', file "' + tmpName + '":' + tmpstr;
          end;
        end;
      end;
      Result := Result and (Pos(': Error:', errMsg) = 0);
      if lstErrors.IndexOf(errMsg) = -1 then
        lstErrors.Append(errMsg);
    end;
  end;
end;

function HandleFPCErrors(fname : string; tmpSL : TStrings; lstErrors : TStrings) : boolean;
begin
  Result := HandleGCCErrors(fname, tmpSL, lstErrors);
end;

function HandleGPPErrors(fname : string; tmpSL : TStrings; lstErrors : TStrings) : boolean;
begin
  Result := HandleGCCErrors(fname, tmpSL, lstErrors);
end;

function HandleJavaErrors(fname : string; tmpSL : TStrings; lstErrors : TStrings) : boolean;
begin
  Result := HandleGCCErrors(fname, tmpSL, lstErrors);
end;

function ReadAndShowErrorFile(DisplayErrorsProc : TDisplayErrorsProc;
  lstErrors : TStrings; const fName, aCaption, tempDir, ext : string) : boolean;
var
  tmpSL : TStrings;
  i : integer;
  tmpstr, errMsg, tmpName, testStr : string;
  bErrorsOrWarnings : boolean;
begin
  Result := True;
  {Read the error file and show it}
  tmpSL := TStringList.Create;
  try
    bErrorsOrWarnings := False;
    if FileExists(tempDir + 'temp.log') then
    begin
      tmpSL.LoadFromFile(tempDir + 'temp.log');
      if (tmpSL.Count > 0) then
      begin
        bErrorsOrWarnings := True;
        {Show the error listing}
        if FileExists(tempDir + 'temp.log') then
        begin
          CodeForm.CodeEdit.Lines.LoadFromFile(tempDir + 'temp.log');
          CodeForm.Caption := sFullErrors + ' ' + aCaption;
        end;
        {Show the short errors}
        lstErrors.Clear;
        if FileIsROPS then
        begin
          Result := HandleROPSErrors(fname, tmpSL, lstErrors);
        end
        else if FileIsPascal then
        begin
          if IsEV3 then
            Result := HandleFPCErrors(fname, tmpSL, lstErrors)
          else
            Result := HandleGPPErrors(fname, tmpSL, lstErrors);
        end
        else if FileIsCPP then
        begin
          Result := HandleGCCErrors(fname, tmpSL, lstErrors);
        end
        else if FileIsJava then
        begin
          Result := HandleJavaErrors(fname, tmpSL, lstErrors);
        end
        else
        begin
          Result := HandleLMSErrors(fname, tmpSL, lstErrors, ext);
        end;
        {show the errors}
        Result := Result or (lstErrors.Count = 0);
        DisplayErrorsProc(true);
      end;
    end;
    {Show the code listing}
    if not bErrorsOrWarnings then
    begin
      if FileExists(tempDir + 'temp.lst') then
      begin
        tmpSL.LoadFromFile(tempDir + 'temp.lst');
        CodeForm.CodeEdit.Lines.BeginUpdate;
        try
          CodeForm.CodeEdit.Lines.Clear;
          for i := 0 to tmpSL.Count - 1 do
          begin
            tmpstr := tmpSL[i];
            if (tmpstr <> '') and (Pos('#line', tmpstr) <> 1) and (Pos('#pragma', tmpstr) <> 1) then
              CodeForm.CodeEdit.Lines.Add(tmpstr);
          end;
  //        CodeForm.CodeEdit.Lines.LoadFromFile(tempDir + 'temp.lst')
        finally
          CodeForm.CodeEdit.Lines.EndUpdate;
        end;
      end
      else
        CodeForm.CodeEdit.Lines.Clear;
      CodeForm.Caption := sCodeListing + ' ' + aCaption;
      {Hide the short errors}
      DisplayErrorsProc(false);
      Result := true;
    end;
  finally
    tmpSL.Free;
  end;
end;

function LocateSymFile(symName : string; var symPath : string) : boolean;
begin
  Result := False;
  symPath := '';
  if FileExists(symName) then
  begin
    symPath := ExtractFilePath(symName);
    result := True;
  end
  else
  begin
    // check UserDataLocalPath
    symName := UserDataLocalPath + ExtractFileName(symName);
    if FileExists(symName) then
    begin
      symPath := UserDataLocalPath;
      result := True;
    end
    else
    begin
      // check SymFileLibraryPath
      symName := SymFileLibraryPath + ExtractFileName(symName);
      if FileExists(symName) then
      begin
        symPath := SymFileLibraryPath;
        result := True;
      end;
    end;
  end;
end;

procedure ReadSymbolFile(aProg : TProgram; const sFilename : string);
var
  symName, symPath : string;
begin
  aProg.ClearAll;
  symName := ChangeFileExt(sFilename, '.sym');
  if LocateSymFile(symName, symPath) then
  begin
    aProg.IsNXC := LowerCase(ExtractFileExt(sFilename)) = '.nxc';
    symName := symPath + ExtractFileName(symName);
    aProg.LoadFromFile(symName);
    if DeleteSymFileAfterLoading then
      DeleteFile(symName);
  end;
end;

function InternalNBCCompile(cmdLine : string;
  sceHandler : TCompilerStatusChangeEvent) : integer;
var
  C : TNBCCompiler;
  i : integer;
begin
  // first trim off the executable at the start of the command line
  i := Pos('nbc.exe', cmdLine);
  if i > 0 then
    System.Delete(cmdLine, 1, i-1);
  Result := 0;
  C := TNBCCompiler.Create;
  try
    C.OnCompilerStatusChange := sceHandler;
    try
      LoadParamDefinitions(C.ExtraDefines, cmdLine);
{$IFDEF CAN_DOWNLOAD}
      C.BrickComm         := BrickComm;
{$ENDIF}
      C.InputFilename     := getFilenameParam(cmdLine);
      C.DefaultIncludeDir := '.';
      C.CommandLine       := cmdLine;
      if ParamSwitch('-x', False, cmdLine) then
      begin
        C.Decompile;
      end
      else
      begin
        Result := C.Execute * -1;
        if C.WriteCompilerMessages then
          C.Messages.SaveToFile(C.CompilerMessagesFilename);
      end;
    except
      Result := -1;
    end;
  finally
    C.Free;
  end;
end;

function DoExecuteCommand(const aCmd : string; const aParams : string;
  aTimeOut : integer; const aDir : string; const bWait : boolean) : integer;
begin
{$IFNDEF FPC}
  if bWait then
    Result := ExecuteAndWait(PChar(aCmd), SW_SHOWMINNOACTIVE, aTimeOut, PChar(aDir))
  else
    Result := Ord(ExecuteAndContinue(PChar(aCmd), PChar('"' + aCmd + '" ' + aParams), PChar(aDir), SW_SHOWNORMAL));
{$ENDIF}
end;

function CompileIt(DisplayErrorsProc : TDisplayErrorsProc;
  theCode : TStrings; lstErrors : TStrings; const fName, fCaption : string;
  download : Boolean; run : Boolean; sceHandler : TCompilerStatusChangeEvent;
  osHandler : TNotifyEvent): boolean;
var
  ext, SaveDir, tempDir, newDir, commandstr : string;
  wd, statusStr, outStr, cmdname : string;
  i : Integer;
  NQC_Result : Longint;
  execError : Boolean;
  H : TSynCustomHighlighter;
  SL : TStringList;
  TI : TTransferItem;
begin
  outStr := '';
  H := GetActiveEditorHighlighter;
  DebugFmt('CompileIt: ActiveEditorHighlighter name = %s', [H.LanguageName]);

  // first off we should hide any previous errors
  DisplayErrorsProc(false);

// switch to modal form to prevent doing other things in
// the GUI while downloading/compiling
  tempDir := TempPath;
  DebugFmt('CompileIt: temp directory = %s', [tempDir]);
  {Save current directory}
  SaveDir:= GetCurrentDir;
  DebugFmt('CompileIt: saved directory = %s', [SaveDir]);
  if not FileIsCPPOrPascalOrJava(H) then
    newDir := ProgramDir
  else
    newDir := ExtractFilePath(fName);
  SetCurrentDir(newDir);
  DebugFmt('CompileIt: SetCurrentDir = %s', [newDir]);
  try
    if FileIsCPPOrPascalOrJava(H) then
    begin
      if IsRCX then
      begin
        // generate the Makefile
        GenerateRCXMakefile(fName, run);
        DebugLog('CompileIt: GenerateRCXMakefile called');
      end
      else if IsNXT then
      begin
        // support leJOS with the NXT
      end
      else if IsEV3 then
      begin
        // support native Linux ARM applications for the EV3
        GenerateEV3Makefile(fName);
        DebugLog('CompileIt: GenerateEV3Makefile called');
      end;
    end
    else if not FileIsROPS(H) then
    begin
      // Save the file
      ext := GetProperExtension(fName);
      theCode.SaveToFile(tempDir + 'temp' + ext);
    end;

    // execute Precompile Tools
    if Assigned(DoExecuteTransferItem) then
      for i := 0 to PrecompileSteps.Count - 1 do
      begin
        TI := TTransferItem(PrecompileSteps[i]);
        DebugFmt('CompileIt: executing precompile step %d = %s', [i, TI.Title]);
        DoExecuteTransferItem(TI);
      end;

    commandstr := GetCompilerCommandLine(download, tempDir, GetIncludePath(SaveDir), fName, sceHandler);
    DebugFmt('CompileIt: command line = %s', [commandstr]);

    wd := ExcludeTrailingPathDelimiter(ExtractFilePath(fName));
    if wd = '' then
      wd := ProgramDir;

    if CompilerDebug then
      ShowMessage('DEBUG: launching compiler with commandline = ' + commandstr);

    if FileIsROPS(H) then
    begin
      theROPSCompiler.Script.Assign(theCode);
      theROPSCompiler.MainFileName := fName;
      if not theROPSCompiler.Compile then
      begin
        execError := True;
        NQC_Result := -1;
        SL := TStringList.Create;
        try
          for i := 0 to theROPSCompiler.CompilerMessageCount - 1 do
            SL.Add(theROPSCompiler.CompilerMessages[i].MessageToString);
          SL.SaveToFile(tempDir + 'temp.log');
        finally
          SL.Free;
        end;
      end
      else
      begin
        execError := False;
        NQC_Result := 0;
        SL := TStringList.Create;
        try
          theROPSCompiler.GetCompiled(commandstr);
          if SaveBinaryOutput then
          begin
            SL.Text := commandstr;
            SL.SaveToFile(ChangeFileExt(fName, '.psb'));
          end;
          IFPS3DataToText(commandstr, commandstr);
          SL.Text := commandstr;
          SL.SaveToFile(tempDir + 'temp.lst');
        finally
          SL.Free;
        end;
      end;
    end
    else if UseNBCCompiler(H) and UseInternalNBC then
    begin
      DebugLog('CompileIt: launching internal NBC compiler');
      NQC_Result := InternalNBCCompile(commandstr, sceHandler);
      execError  := NQC_Result < 0;
    end
    else
    begin
      {Execute the command, and wait}
      DebugLog('CompileIt: launching an external compiler');
      if download then begin
        BrickComm.Ping;
        DebugLog('CompileIt: closing connection so that external compiler can use it');
        BrickComm.Close;
      end;
      try
        NQC_Result := DoExecuteCommand(commandstr, '', LocalCompilerTimeout, wd, True);
        if not FileIsNQC(H) then
          NQC_Result := NQC_Result * -1;
        execError := NQC_Result < 0;
      finally
        if download then
        begin
          DebugLog('CompileIt: reopening connection now that the external compiler is finished with it');
          BrickComm.Open;
        end;
        // make sure the toolbar refreshes no matter what
        osHandler(nil);
      end;
    end;

    // execute post compile steps
    if Assigned(DoExecuteTransferItem) then
      for i := 0 to PostcompileSteps.Count - 1 do
      begin
        TI := TTransferItem(PostcompileSteps[i]);
        DebugFmt('CompileIt: executing postcompile step %d = %s', [i, TI.Title]);
        DoExecuteTransferItem(TI);
      end;

    DebugLog('CompileIt: calling ReadAndShowErrorFile');
    Result := ReadAndShowErrorFile(DisplayErrorsProc, lstErrors, fName, fCaption, tempDir, ext);

    if FileIsNBCOrNXC(H) then
    begin
      DebugLog('CompileIt: calling ReadSymbolFile');
      ReadSymbolFile(CurrentProgram, fName);
    end;

    if (not execError) and ShowCompilerStatus then
    begin
      if Result and download then
        statusStr := sCompileDownloadSuccess
      else if Result then
        statusStr := sCompileSuccess
      else if download then
        statusStr := sCompileDownloadErrors
      else
        statusStr := sCompileErrors;
      frmCompStatus.AddMessage(statusStr);
    end
    else if execError then
    begin
      if outStr <> '' then
        outStr := outStr + #13#10;
{$IFNDEF FPC}
      if FileIsNQC(H) then
        outStr := outStr + GetRCXErrorString(NQC_Result)
      else
{$ENDIF}
      if FileIsMindScriptOrLASM(H) then
        outStr := outStr + GetLASMErrorString(NQC_Result)
      else if UseNBCCompiler(H) or FileIsROPS(H) then
        outStr := outStr + GetNBCErrorString(NQC_Result)
      else
        outStr := outStr + GetGNUErrorString(NQC_Result);
      if outStr <> '' then
      begin
        MessageDlg('Compile/Download Failed' + #13#10 + outStr, mtError, [mbOK], 0);
      end;
    end;
  finally
    {Clean up}
    if not KeepMakefiles then
      DeleteFile(ChangeFileExt(fName, '.mak'));
    cmdname := ChangeFileExt(fName, '.cmd');
    if FileExists(cmdname) then
      DeleteFile(cmdname);
    cmdname := ChangeFileExt(fName, '.bat');
    if FileExists(cmdname) then
      DeleteFile(cmdname);
    DeleteFile(tempDir + 'temp.log');
    DeleteFile(tempDir + 'temp.lst');
    DeleteFile(tempDir + 'temp' + ext);
    SetCurrentDir(SaveDir);
  end;
end;

procedure AddPaths(aPath : string; aPaths : TStrings);
var
  p : Integer;
  s : string;
begin
  p := Pos(';', aPath);
  while p > 0 do
  begin
    s := Copy(aPath, 1, p - 1);
    Delete(aPath, 1, p);
    aPaths.Add(s);
    p := Pos(';', aPath);
  end;
  if aPath <> '' then
    aPaths.Add(aPath);
end;

end.