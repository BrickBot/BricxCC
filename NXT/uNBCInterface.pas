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
unit uNBCInterface;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes,
{$IFDEF CAN_DOWNLOAD}
  uSpirit,
  FantomSpirit,
{$ENDIF}
  uNXTClasses,
  uNBCCommon,
  uRPGComp,
  uNXCComp,
  uRICComp,
  uSPCComp;

type
  TDeviceTarget = (dtNXT, dtSPRO);
  TWriteMessages = procedure(aStrings : TStrings);

  TNBCCompiler = class
  private
    fFilename : string;
    fQuiet: boolean;
    fWriteSymbolTable: boolean;
    fSymbolTableFilename: string;
    fWriteIntermediateCode: boolean;
    fIntermediateCodeFilename: string;
    fWriteOutput: boolean;
    fOutputFilename: string;
    fNXTName : string;
    fUseSpecialName: boolean;
    fSpecialName: string;
    fOptLevel: integer;
    fBinaryInput: boolean;
    fDownload: boolean;
    fRunProgram: boolean;
    fDefaultIncludeDir: string;
    fMoreIncludes: boolean;
    fIncludePaths: string;
    fOnWriteMessages: TWriteMessages;
    fWarningsAreOff: boolean;
    fEnhancedFirmware: boolean;
    fWriteCompilerOutput: boolean;
    fCompilerOutputFilename: string;
    fExtraDefines: TStrings;
    fMessages : TStrings;
    fCommandLine: string;
    fWriteCompilerMessages: boolean;
    fCompilerMessagesFilename: string;
    fIgnoreSystemFile: boolean;
    fSafeCalls: boolean;
    fMaxErrors: word;
    fFirmwareVersion: word;
    fMaxPreProcDepth: word;
    fTarget: TDeviceTarget;
  protected
    fOnCompilerStatusChange : TCompilerStatusChangeEvent;
    fDump : TStrings;
    fBCCreated : boolean;
    fUsePort: boolean;
    fPortName: string;
    fDownloadList : string;
{$IFDEF CAN_DOWNLOAD}
    fBC : TBrickComm;
    function GetBrickComm : TBrickComm;
    procedure SetBrickComm(Value : TBrickComm);
    procedure DoBeep;
    procedure DownloadRequestedFiles;
    function CheckFirmwareVersion : boolean;
{$ENDIF}
    procedure DoWriteCompilerOutput(aStrings: TStrings);
    procedure DoWriteSymbolTable(C : TRXEProgram);
    procedure DoWriteIntermediateCode(aStrings : TStrings);
    procedure DoWriteMessages(aStrings : TStrings);
    procedure DoWriteMessage(const aString : String);
    function GetCurrentFilename : string;
    procedure SetCommandLine(const Value: string);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute : integer;
    procedure Decompile;
    class procedure DumpAPI(const idx : integer);
    procedure HandleOnCompilerStatusChange(Sender : TObject; const StatusMsg : string; const bDone : boolean);
    property CommandLine : string read fCommandLine write SetCommandLine;
    property InputFilename : string read fFilename write fFilename;
    property IgnoreSystemFile : boolean read fIgnoreSystemFile write fIgnoreSystemFile;
    property Quiet : boolean read fQuiet write fQuiet;
    property MaxErrors : word read fMaxErrors write fMaxErrors;
    property MaxPreprocessorDepth : word read fMaxPreProcDepth write fMaxPreProcDepth;
    property WriteCompilerOutput : boolean read fWriteCompilerOutput write fWriteCompilerOutput;
    property CompilerOutputFilename : string read fCompilerOutputFilename write fCompilerOutputFilename;
    property WriteSymbolTable : boolean read fWriteSymbolTable write fWriteSymbolTable;
    property SymbolTableFilename : string read fSymbolTableFilename write fSymbolTableFilename;
    property WriteIntermediateCode : boolean read fWriteIntermediateCode write fWriteIntermediateCode;
    property IntermediateCodeFilename : string read fIntermediateCodeFilename write fIntermediateCodeFilename;
    property WriteOutput : boolean read fWriteOutput write fWriteOutput;
    property OutputFilename : string read fOutputFilename write fOutputFilename;
    property WriteCompilerMessages : boolean read fWriteCompilerMessages write fWriteCompilerMessages;
    property CompilerMessagesFilename : string read fCompilerMessagesFilename write fCompilerMessagesFilename;
    property Decompilation : TStrings read fDump;
    property ExtraDefines : TStrings read fExtraDefines;
    property Messages : TStrings read fMessages;
    property NXTName : string read fNXTName write fNXTName;
    property UseSpecialName : boolean read fUseSpecialName write fUseSpecialName;
    property SpecialName : string read fSpecialName write fSpecialName;
    property OptimizationLevel : integer read fOptLevel write fOptLevel;
    property UsePort : boolean read fUsePort write fUsePort;
    property PortName : string read fPortName write fPortName;
    property BinaryInput : boolean read fBinaryInput write fBinaryInput;
    property Download : boolean read fDownload write fDownload;
    property RunProgram : boolean read fRunProgram write fRunProgram;
    property DefaultIncludeDir : string read fDefaultIncludeDir write fDefaultIncludeDir;
    property MoreIncludes : boolean read fMoreIncludes write fMoreIncludes;
    property IncludePaths : string read fIncludePaths write fIncludePaths;
    property WarningsAreOff : boolean read fWarningsAreOff write fWarningsAreOff;
    property EnhancedFirmware : boolean read fEnhancedFirmware write fEnhancedFirmware;
    property FirmwareVersion : word read fFirmwareVersion write fFirmwareVersion;
    property SafeCalls : boolean read fSafeCalls write fSafeCalls;
    property Target : TDeviceTarget read fTarget write fTarget;
    property OnWriteMessages : TWriteMessages read fOnWriteMessages write fOnWriteMessages;
    property OnCompilerStatusChange : TCompilerStatusChangeEvent read fOnCompilerStatusChange write fOnCompilerStatusChange;
{$IFDEF CAN_DOWNLOAD}
    property BrickComm : TBrickComm read GetBrickComm write SetBrickComm;
{$ENDIF}
  end;

function APIAsText(const idx : integer) : string;

implementation

uses
  SysUtils, Math, uVersionInfo, ParamUtils, uNXTConstants,
  NBCCommonData, NXTDefsData, NXCDefsData, SPCDefsData, SPMemData,
  uGlobals, uLocalizedStrings, uSProObjUtils;

{ TNBCCompiler }

constructor TNBCCompiler.Create;
begin
  inherited;
  fMaxPreprocDepth := 10;
  fMaxErrors := 0;
  fIgnoreSystemFile := False;
  fEnhancedFirmware := False;
  fFirmwareVersion := 128; // 1.28 NXT 2.0 firmware
  fWarningsAreOff := False;
  fMoreIncludes := False;
  fBinaryInput := False;
  fDownload := False;
  fRunProgram := False;
  fUsePort := False;
  fBCCreated := False;
  fQuiet := False;
  fWriteSymbolTable := False;
  fWriteIntermediateCode := False;
  fUseSpecialName := False;
  fOptLevel := 0;
  fDump := TStringList.Create;
  fExtraDefines := TStringList.Create;
  fMessages := TStringList.Create;
{$IFDEF CAN_DOWNLOAD}
  fBC := nil;
{$ENDIF}
end;

destructor TNBCCompiler.Destroy;
begin
  FreeAndNil(fDump);
  FreeAndNil(fExtraDefines);
  FreeAndNil(fMessages);
{$IFDEF CAN_DOWNLOAD}
  if fBCCreated then
    FreeAndNil(fBC);
{$ENDIF}
  inherited;
end;

{$IFDEF CAN_DOWNLOAD}

function TNBCCompiler.GetBrickComm : TBrickComm;
begin
  if not Assigned(fBC) then
  begin
    fBC := TFantomSpirit.Create();
    fBCCreated := True;
    fBC.BrickType := rtNXT;
  end;
  Result := fBC;
end;

procedure TNBCCompiler.SetBrickComm(Value: TBrickComm);
begin
  if fBCCreated then
    FreeAndNil(fBC);
  fBC := Value;
  fBCCreated := False;
end;

procedure TNBCCompiler.DoBeep;
begin
  if not fQuiet then
  begin
    BrickComm.PlayTone(440, 100);
  end;
end;

{$ENDIF}

procedure TNBCCompiler.DoWriteCompilerOutput(aStrings : TStrings);
var
  dir, logFilename : string;
begin
  if WriteCompilerOutput then
  begin
    logFilename := CompilerOutputFilename;
    dir := ExtractFilePath(logFilename);
    if dir <> '' then
      ForceDirectories(dir);
    // the code listing is the source code (since it is assembler)
    aStrings.SaveToFile(logFilename);
  end;
end;

procedure TNBCCompiler.DoWriteSymbolTable(C : TRXEProgram);
var
  dir, logFilename : string;
begin
  if WriteSymbolTable then
  begin
    logFilename := SymbolTableFilename;
    dir := ExtractFilePath(logFilename);
    if dir <> '' then
      ForceDirectories(dir);
    C.SymbolTable.SaveToFile(logFilename);
  end;
end;

procedure TNBCCompiler.DoWriteIntermediateCode(aStrings : TStrings);
var
  dir, logFilename : string;
begin
  if WriteIntermediateCode then
  begin
    logFilename := IntermediateCodeFilename;
    dir := ExtractFilePath(logFilename);
    if dir <> '' then
      ForceDirectories(dir);
    aStrings.SaveToFile(logFilename);
  end;
end;

procedure TNBCCompiler.Decompile;
var
  D : TRXEDumper;
  ext : string;
begin
  ext := Lowercase(ExtractFileExt(fFilename));
  if (ext = '.rxe') or (ext = '.sys') or (ext = '.rtm') then
  begin
    D := TRXEDumper.Create;
    try
      D.FirmwareVersion := FirmwareVersion;
      D.LoadFromFile(fFilename);
      D.Decompile(fDump);
    finally
      D.Free;
    end;
  end
  else if (ext = '.ric') then
  begin
    fDump.Text := TRICComp.RICToText(fFilename);
  end
  else if (ext = '.bin') then
  begin
    fDump.Text := TSPCComp.BinToText(fFilename);
  end
  else
    Exit; // do nothing
  if WriteOutput then
  begin
    // write the contents of fDump to the file
    fDump.SaveToFile(OutputFilename);
  end;
end;

function GetDefaultPath : string;
begin
//  Result := ExtractFilePath(ParamStr(0));
  Result := IncludeTrailingPathDelimiter(GetCurrentDir);
end;

function TNBCCompiler.GetCurrentFilename : string;
var
  ext : string;
begin
  ext := ExtractFileExt(InputFilename);
  Result := ChangeFileExt(NXTName, ext);
  // add a path if there isn't one already
  if ExtractFilename(Result) = Result then
    Result := GetDefaultPath + Result;
end;

function TNBCCompiler.Execute : integer;
var
  sIn : TMemoryStream;
  sOut : TMemoryStream;
  sObj : TMemoryStream;
  tmpIncDirs : TStringList;
  C : TRXEProgram;
  NC : TNXCComp;
  RC : TRPGComp;
  RIC : TRICComp;
  SC : TSPCComp;
  SL : TStringList;
{$IFDEF CAN_DOWNLOAD}
  theType : TNXTFileType;
  tmpName : string;
{$ENDIF}
  i : integer;
  incDirs : string;
  ext : string;
  bNXCErrors : boolean;
  bSPCErrors : boolean;
  bDownloadOK : boolean;
begin
  fDownloadList := '';
  Result := 0;
  if WriteOutput then
    NXTName := OutputFilename
  else if UseSpecialName then
    NXTName := SpecialName
  else
    NXTName := InputFilename;

{$IFDEF CAN_DOWNLOAD}
  if Download or RunProgram then
  begin
    if BrickComm.Port = '' then
    begin
      if UsePort then
      begin
        BrickComm.Port := PortName;
      end
      else
        BrickComm.Port := 'usb'; // if no port is specified then default to usb
    end;
  end;
{$ENDIF}

  sIn := TMemoryStream.Create;
  try
    if FileExists(InputFilename) then
      sIn.LoadFromFile(InputFilename)
    else
    begin
      // can't find input file
      Result := 1; // compiler error
      DoWriteMessage('# Error: ' + Format(sCannotFindFile, [InputFilename]));
      Exit;
    end;
    ext := LowerCase(ExtractFileExt(InputFilename));
    if BinaryInput and (Download or RunProgram) then
    begin
{$IFDEF CAN_DOWNLOAD}
      // just download the already compiled binary file
      if not BrickComm.IsOpen then
        BrickComm.Open;
      theType := NameToNXTFileType(InputFilename);
      BrickComm.NXTStopProgram;
      if Download then
      begin
        if Target = dtSPRO then
        begin
          sObj := TMemoryStream.Create;
          try
            SProBinToObj(sIn, sObj);
            bDownloadOK := BrickComm.NXTDownloadStream(sObj, InputFilename, theType);
          finally
            sObj.Free;
          end;
        end
        else
        begin
          bDownloadOK := BrickComm.NXTDownloadStream(sIn, InputFilename, theType);
        end;
        if bDownloadOK then
          DoBeep
        else begin
          Result := 2;
          HandleOnCompilerStatusChange(Self, sDownloadFailed, True);
        end;
      end;
      if RunProgram then
        BrickComm.NXTStartProgram(InputFilename);
{$ENDIF}
    end
    else
    begin
      tmpIncDirs := TStringList.Create;
      try
        tmpIncDirs.Sorted := True;
        tmpIncDirs.Duplicates := dupIgnore;
        // add the default include directory
        tmpIncDirs.Add(IncludeTrailingPathDelimiter(DefaultIncludeDir));
        if MoreIncludes then
        begin
          incDirs := IncludePaths;
          // does the path contain ';'?  If so parse
          i := Pos(';', incDirs);
          while i > 0 do begin
            tmpIncDirs.Add(IncludeTrailingPathDelimiter(Copy(incDirs, 1, i-1)));
            Delete(incDirs, 1, i);
            i := Pos(';', incDirs);
          end;
          tmpIncDirs.Add(IncludeTrailingPathDelimiter(incDirs));
        end;
        if ext = '.npg' then
        begin
          // RPG compiler
          RC := TRPGComp.Create;
          try
            RC.CurrentFile := GetCurrentFilename;
            RC.MaxErrors := MaxErrors;
            try
              RC.Parse(sIn);
              sOut := TMemoryStream.Create;
              try
                if RC.SaveToStream(sOut) then
                begin
{$IFDEF CAN_DOWNLOAD}
                  if Download then
                  begin
                    // download the compiled code to the brick
                    if not BrickComm.IsOpen then
                      BrickComm.Open;
                    BrickComm.NXTStopProgram;
                    if BrickComm.NXTDownloadStream(sOut, ChangeFileExt(nxtName, '.rpg'), nftOther) then
                      DoBeep
                    else
                      Result := 2;
                  end;
{$ENDIF}
                  if WriteOutput then
                    sOut.SaveToFile(nxtName);
                end
                else
                  Result := 1;
              finally
                sOut.Free;
              end;
            finally
              DoWriteMessages(RC.CompilerMessages);
            end;
          finally
            RC.Free;
          end;
        end
        else if ext = '.rs' then
        begin
          // RIC compiler
          RIC := TRICComp.Create;
          try
            RIC.IncludeDirs.AddStrings(tmpIncDirs);
            RIC.CurrentFile := GetCurrentFilename;
            RIC.EnhancedFirmware := EnhancedFirmware;
            RIC.FirmwareVersion  := FirmwareVersion;
            RIC.MaxErrors := MaxErrors;
            try
              RIC.Parse(sIn);
              if RIC.CompilerMessages.Count = 0 then
              begin
                sOut := TMemoryStream.Create;
                try
                  RIC.SaveToStream(sOut);
{$IFDEF CAN_DOWNLOAD}
                  if Download then
                  begin
                    // download the compiled code to the brick
                    if not BrickComm.IsOpen then
                      BrickComm.Open;
                    if CheckFirmwareVersion then
                    begin
                      BrickComm.NXTStopProgram;
                      if BrickComm.NXTDownloadStream(sOut, ChangeFileExt(nxtName, '.ric'), nftGraphics) then
                        DoBeep
                      else
                        Result := 2;
                    end
                    else
                      Result := 3;
                  end;
{$ENDIF}
                  if WriteOutput then
                    sOut.SaveToFile(nxtName);
                finally
                  sOut.Free;
                end;
              end
              else
                Result := 1;
            finally
              DoWriteMessages(RIC.CompilerMessages);
            end;
          finally
            RIC.Free;
          end;
        end
        else if (ext = '.spc') or (ext = '.spasm') then
        begin
          // SPC compiler
          SC := TSPCComp.Create;
          try
            SC.OnCompilerStatusChange := HandleOnCompilerStatusChange;
            SC.Defines.AddStrings(ExtraDefines);
            SC.OptimizeLevel := OptimizationLevel;
            SC.IncludeDirs.AddStrings(tmpIncDirs);
            SC.CurrentFile := GetCurrentFilename;
            SC.WarningsOff := WarningsAreOff;
            SC.IgnoreSystemFile := IgnoreSystemFile;
            SC.EnhancedFirmware := EnhancedFirmware;
            SC.FirmwareVersion  := FirmwareVersion;
            SC.MaxErrors := MaxErrors;
            SC.MaxPreprocessorDepth := MaxPreprocessorDepth;
            try
              if (ext = '.spc') then
              begin
                SC.Parse(sIn);
                DoWriteIntermediateCode(SC.ASMSource);
              end
              else
              begin
                // spasm code
                SL := TStringList.Create;
                try
                  SL.LoadFromStream(sIn);
                  SC.ParseASM(SL);
                  DoWriteIntermediateCode(SL);
                finally
                  SL.Free;
                end;
              end;
            finally
              DoWriteMessages(SC.CompilerMessages);
            end;
            bSPCErrors := SC.ErrorCount > 0;
            if not bSPCErrors then
            begin
              sOut := TMemoryStream.Create;
              try
                SC.CompilerMessages.Clear;
                if SC.SaveToStream(sOut) then
                begin
//                  DoWriteSymbolTable(SC);
{$IFDEF CAN_DOWNLOAD}
                  if Download then
                  begin
                    // download the compiled code to the brick
                    if not BrickComm.IsOpen then
                      BrickComm.Open;
                    BrickComm.NXTStopProgram;
                    sObj := TMemoryStream.Create;
                    try
                      SProBinToObj(sOut, sObj);
                      if BrickComm.NXTDownloadStream(sObj, '', nftProgram) then
                        DoBeep
                      else begin
                        Result := 2;
                        HandleOnCompilerStatusChange(Self, sDownloadFailed, True);
                      end;
                    finally
                      sObj.Free;
                    end;
                  end;
                  if RunProgram then
                    BrickComm.NXTStartProgram(tmpName);
{$ENDIF}
                  if WriteOutput then
                    sOut.SaveToFile(NXTName);
                end
                else
                begin
                  DoWriteMessages(SC.CompilerMessages);
                  Result := 1;
                  HandleOnCompilerStatusChange(Self, sSPCCompilationFailed, True);
                end;
              finally
                sOut.Free;
              end;
              DoWriteCompilerOutput(SC.CompilerOutput);
            end
            else
            begin
              Result := 1;
              HandleOnCompilerStatusChange(Self, sSPCCompilationFailed, True);
            end;
          finally
            SC.Free;
          end;
        end
        else if (ext = '.nxc') or (ext = '.nbc') then
        begin
          // .nbc or .nxc files
          bNXCErrors := False;
          if ext = '.nxc' then
          begin
            NC := TNXCComp.Create;
            try
              NC.OnCompilerStatusChange := HandleOnCompilerStatusChange;
              NC.Defines.AddStrings(ExtraDefines);
              NC.OptimizeLevel := OptimizationLevel;
              NC.IncludeDirs.AddStrings(tmpIncDirs);
              NC.CurrentFile := GetCurrentFilename;
              NC.WarningsOff := WarningsAreOff;
              NC.IgnoreSystemFile := IgnoreSystemFile;
              NC.EnhancedFirmware := EnhancedFirmware;
              NC.FirmwareVersion  := FirmwareVersion;
              NC.SafeCalls := SafeCalls;
              NC.MaxErrors := MaxErrors;
              NC.MaxPreprocessorDepth := MaxPreprocessorDepth;
              try
                NC.Parse(sIn);
                DoWriteIntermediateCode(NC.NBCSource);
                sIn.Clear;
                NC.NBCSource.SaveToStream(sIn);
                // this used to pass at least 1 as the optimization level
                // but if a user says no optimizations then the compiler
                // really should respect that and do no optimizations whatsoever
                OptimizationLevel := Max(OptimizationLevel, 0);
                sIn.Position := 0;
              finally
                DoWriteMessages(NC.CompilerMessages);
              end;
              bNXCErrors := NC.ErrorCount > 0;
            finally
              NC.Free;
            end;
          end;
          if not bNXCErrors then
          begin
            // compile the nbc file
            C := TRXEProgram.Create;
            try
              C.Defines.AddStrings(ExtraDefines);
              C.ReturnRequiredInSubroutine := True;
              C.OptimizeLevel := OptimizationLevel;
              C.WarningsOff   := WarningsAreOff;
              C.EnhancedFirmware := EnhancedFirmware;
              C.FirmwareVersion  := FirmwareVersion;
              C.IgnoreSystemFile := IgnoreSystemFile;
              C.MaxErrors        := MaxErrors;
              C.MaxPreprocessorDepth := MaxPreprocessorDepth;
              C.OnCompilerStatusChange := HandleOnCompilerStatusChange;
              try
                C.IncludeDirs.AddStrings(tmpIncDirs);
                C.CurrentFile := GetCurrentFilename;
                fDownloadList := C.Parse(sIn);
                sOut := TMemoryStream.Create;
                try
                  if C.SaveToStream(sOut) then
                  begin
                    DoWriteSymbolTable(C);
{$IFDEF CAN_DOWNLOAD}
                    tmpName := ChangeFileExt(MakeValidNXTFilename(NXTName), '.rxe');
                    if Download then
                    begin
                      // download the compiled code to the brick
                      if not BrickComm.IsOpen then
                        BrickComm.Open;
                      if CheckFirmwareVersion then
                      begin
                        BrickComm.NXTStopProgram;
                        if BrickComm.NXTDownloadStream(sOut, tmpName, nftProgram) then
                          DoBeep
                        else begin
                          Result := 2;
                          HandleOnCompilerStatusChange(Self, sDownloadFailed, True);
                        end;
                      end
                      else begin
                        Result := 3;
                        HandleOnCompilerStatusChange(Self, sVersionCheckFailed, True);
                      end;
                    end;
                    if RunProgram then
                      BrickComm.NXTStartProgram(tmpName);
{$ENDIF}
                    if WriteOutput then
                      sOut.SaveToFile(NXTName);
                  end
                  else
                  begin
                    Result := 1;
                    HandleOnCompilerStatusChange(Self, sNBCCompilationFailed, True);
                  end;
                finally
                  sOut.Free;
                end;
                DoWriteCompilerOutput(C.CompilerOutput);
              finally
                DoWriteMessages(C.CompilerMessages);
              end;
            finally
              C.Free;
            end;
          end
          else
          begin
            Result := 1;
            HandleOnCompilerStatusChange(Self, sNXCCompilationFailed, True);
          end;
        end
        else
          DoWriteMessage('# Error: ' + Format(sInvalidFileType, [ext]));
      finally
        tmpIncDirs.Free;
      end;
    end;
  finally
    sIn.Free;
  end;
{$IFDEF CAN_DOWNLOAD}
  DownloadRequestedFiles;
{$ENDIF}
end;

procedure TNBCCompiler.DoWriteMessages(aStrings: TStrings);
begin
  fMessages.AddStrings(aStrings);
//  fMessages.Assign(aStrings);
  if Assigned(fOnWriteMessages) then
    fOnWriteMessages(aStrings);
end;

procedure TNBCCompiler.SetCommandLine(const Value: string);
begin
  fCommandLine := Value;
  // set properties given command line switches
  if ParamValue('-T', False, Value) = 'SPRO' then
    Target := dtSPRO
  else
    Target := dtNXT;
  IgnoreSystemFile         := ParamSwitch('-n', False, Value);
  Quiet                    := ParamSwitch('-q', False, Value);
  MaxErrors                := ParamIntValue('-ER', 0, False, Value);
  MaxPreprocessorDepth     := ParamIntValue('-PD', 10, False, Value);
  FirmwareVersion          := ParamIntValue('-v', 128, False, Value);
  WriteCompilerOutput      := ParamSwitch('-L', False, Value);
  CompilerOutputFilename   := ParamValue('-L', False, Value);
  WriteSymbolTable         := ParamSwitch('-Y', False, Value);
  SymbolTableFilename      := ParamValue('-Y', False, Value);
  WriteIntermediateCode    := ParamSwitch('-asm', False, Value);
  IntermediateCodeFilename := ParamValue('-asm', False, Value);
  WriteOutput              := ParamSwitch('-O', False, Value);
  OutputFilename           := ParamValue('-O', False, Value);
  UseSpecialName           := ParamSwitch('-N', False, Value);
  SpecialName              := ParamValue('-N', False, Value);
  OptimizationLevel        := 1;
  if ParamSwitch('-Z', False, Value) then
    OptimizationLevel      := 2
  else if ParamSwitch('-Z6', False, Value) then
    OptimizationLevel      := 6
  else if ParamSwitch('-Z5', False, Value) then
    OptimizationLevel      := 5
  else if ParamSwitch('-Z4', False, Value) then
    OptimizationLevel      := 4
  else if ParamSwitch('-Z3', False, Value) then
    OptimizationLevel      := 3
  else if ParamSwitch('-Z2', False, Value) then
    OptimizationLevel      := 2
  else if ParamSwitch('-Z1', False, Value) then
    OptimizationLevel      := 1
  else if ParamSwitch('-Z0', False, Value) then
    OptimizationLevel      := 0;
  UsePort                  := ParamSwitch('-S', False, Value);
  PortName                 := ParamValue('-S', False, Value);
  BinaryInput              := ParamSwitch('-b', False, Value);
  Download                 := ParamSwitch('-d', False, Value);
  RunProgram               := ParamSwitch('-r', False, Value);
  MoreIncludes             := ParamSwitch('-I', False, Value);
  IncludePaths             := ParamValue('-I', False, Value);
  WarningsAreOff           := ParamSwitch('-w-', False, Value);
  EnhancedFirmware         := ParamSwitch('-EF', False, Value);
  SafeCalls                := ParamSwitch('-safecall', False, Value);
  WriteCompilerMessages    := ParamSwitch('-E', False, Value);
  CompilerMessagesFilename := ParamValue('-E', False, Value);
end;

procedure WriteBytes(data : array of byte);
var
  i : integer;
begin
  for i := Low(data) to High(data) do
    Write(Char(data[i]));
end;

class procedure TNBCCompiler.DumpAPI(const idx : integer);
begin
  case idx of
    0 :
      begin
        WriteBytes(nbc_common_data);
        WriteBytes(nxt_defs_data);
        WriteBytes(nxc_defs_data);
      end;
    1 : WriteBytes(nbc_common_data);
    2 : WriteBytes(nxt_defs_data);
    3 : WriteBytes(nxc_defs_data);
  end;
end;

function APIAsText(const idx: integer): string;
var
  X : TStringStream;
  tmp : string;
begin
  X := TStringStream.Create(tmp);
  try
    case idx of
      0 :
        begin
          X.Write(nbc_common_data, SizeOf(nbc_common_data));
          X.Write(nxt_defs_data, SizeOf(nxt_defs_data));
          X.Write(nxc_defs_data, SizeOf(nxc_defs_data));
        end;
      1 : X.Write(nbc_common_data, SizeOf(nbc_common_data));
      2 : X.Write(nxt_defs_data, SizeOf(nxt_defs_data));
      3 : X.Write(nxc_defs_data, SizeOf(nxc_defs_data));
      4 : X.Write(spc_defs_data, SizeOf(spc_defs_data));
      5 : X.Write(spmem_data, SizeOf(spmem_data));
    end;
    Result := Copy(X.DataString, 1, MaxInt);
  finally
    X.Free;
  end;
end;

procedure TNBCCompiler.HandleOnCompilerStatusChange(Sender: TObject;
  const StatusMsg: string; const bDone : boolean);
begin
  if Assigned(fOnCompilerStatusChange) then
    fOnCompilerStatusChange(Sender, StatusMsg, bDone);
end;

{$IFDEF CAN_DOWNLOAD}
procedure TNBCCompiler.DownloadRequestedFiles;
var
  tmpSL : TStringList;
  i : integer;
  tmpFilename, ext : string;
begin
  if Download and (fDownloadList <> '') then
  begin
    tmpSL := TStringList.Create;
    try
      tmpSL.Text := fDownloadList;
      for i := 0 to tmpSL.Count - 1 do
      begin
        tmpFilename := tmpSL[i];
        ext := AnsiLowercase(ExtractFileExt(tmpFilename));
        // all files other than .npg, .rs, .nxc, and .nbc should
        // just be downloaded and not compiled first.
        BinaryInput := not ((ext = '.npg') or (ext = '.rs') or
                            (ext = '.nxc') or (ext = '.nbc'));
        InputFilename := tmpFilename;
        // never write any output for these files
        WriteOutput           := False;
        WriteCompilerOutput   := False;
        WriteSymbolTable      := False;
        WriteIntermediateCode := False;
        WriteCompilerMessages := False;
        // don't use a special name either
        UseSpecialName        := False;
        // and do not run these either
        RunProgram            := False;
        Execute;
      end;
    finally
      tmpSL.Free;
    end;
  end;
end;

function TNBCCompiler.CheckFirmwareVersion: boolean;
var
  fwVer : word;
begin
  fwVer := BrickComm.NXTFirmwareVersion;
  if fwVer <> 0 then
  begin
    // if we say we are targetting a 1.0x firmware then the actual
    // firmware version needs to be a 1.0x firmware.  If we are targetting
    // the 1.2x firmware thne the actual firmware version is a 1.2x firmware.
    if FirmwareVersion <= MAX_FW_VER1X then
    begin
      // 1.0x
      Result := fwVer <= MAX_FW_VER1X;
    end
    else
    begin
      // 1.2x
      Result := fwVer >= MIN_FW_VER2X;
    end;
  end
  else
  begin
    // if, for some reason, this function returns false then we will go ahead
    // and assume that the correct version is installed
    Result := True;
  end;
end;
{$ENDIF}

procedure TNBCCompiler.DoWriteMessage(const aString: String);
var
  SL : TStringList;
begin
  fMessages.Add(aString);
  if Assigned(fOnWriteMessages) then
  begin
    SL := TStringList.Create;
    try
      SL.Add(aString);
      fOnWriteMessages(SL);
    finally
      SL.Free;
    end;
  end;
end;

initialization
  VerCompanyName      := 'JoCar Consulting';
  VerFileDescription  := '';
  VerFileVersion      := '1.2.1.r5';
  VerInternalName     := 'NBC';
  VerLegalCopyright   := 'Copyright (c) 2006-2011, John Hansen';
  VerOriginalFileName := 'NBC';
  VerProductName      := 'Next Byte Codes Compiler';
  VerProductVersion   := '1.2';
  VerComments         := '';

end.
