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

interface

uses
  Classes,
{$IFDEF CAN_DOWNLOAD}
  uSpirit,
  FantomSpirit,
{$ENDIF}
  uNXTClasses,
  uRPGComp,
  uNXCComp,
  uRICComp;

type
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
    fUseBluetooth: boolean;
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
  protected
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
{$ENDIF}
    procedure DoWriteCompilerOutput(aStrings: TStrings);
    procedure DoWriteSymbolTable(C : TRXEProgram);
    procedure DoWriteIntermediateCode(NC : TNXCComp);
    procedure DoWriteMessages(aStrings : TStrings);
    function GetCurrentFilename : string;
    procedure SetCommandLine(const Value: string);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute : integer;
    procedure Decompile;
    procedure DumpAPI(const idx : integer);
    property CommandLine : string read fCommandLine write SetCommandLine;
    property InputFilename : string read fFilename write fFilename;
    property IgnoreSystemFile : boolean read fIgnoreSystemFile write fIgnoreSystemFile;
    property Quiet : boolean read fQuiet write fQuiet;
    property MaxErrors : word read fMaxErrors write fMaxErrors;
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
    property UseBluetooth : boolean read fUseBluetooth write fUseBluetooth;
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
    property OnWriteMessages : TWriteMessages read fOnWriteMessages write fOnWriteMessages;
{$IFDEF CAN_DOWNLOAD}
    property BrickComm : TBrickComm read GetBrickComm write SetBrickComm;
{$ENDIF}
  end;

implementation

uses
  SysUtils, Math, uVersionInfo, ParamUtils,
  NBCCommonData, NXTDefsData, NXCDefsData;

{ TNBCCompiler }

constructor TNBCCompiler.Create;
begin
  inherited;
  fMaxErrors := 0;
  fIgnoreSystemFile := False;
  fEnhancedFirmware := False;
  fFirmwareVersion := 105; // 1.05 NXT 1.1 firmware
  fWarningsAreOff := False;
  fMoreIncludes := False;
  fBinaryInput := False;
  fDownload := False;
  fRunProgram := False;
  fUsePort := False;
  fUseBluetooth := False;
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

procedure TNBCCompiler.DoWriteIntermediateCode(NC : TNXCComp);
var
  dir, logFilename : string;
begin
  if WriteIntermediateCode then
  begin
    logFilename := IntermediateCodeFilename;
    dir := ExtractFilePath(logFilename);
    if dir <> '' then
      ForceDirectories(dir);
    NC.NBCSource.SaveToFile(logFilename);
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
  tmpIncDirs : TStringList;
  C : TRXEProgram;
  NC : TNXCComp;
  RC : TRPGComp;
  RIC : TRICComp;
{$IFDEF CAN_DOWNLOAD}
  theType : TNXTFileType;
  tmpName : string;
{$ENDIF}
  i : integer;
  incDirs : string;
  bNXCErrors : boolean;
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
    BrickComm.UseBluetooth := UseBluetooth;
  end;
{$ENDIF}

  sIn := TMemoryStream.Create;
  try
    sIn.LoadFromFile(InputFilename);
    if BinaryInput and (Download or RunProgram) then
    begin
{$IFDEF CAN_DOWNLOAD}
      // just download the already compiled binary file
      if not BrickComm.IsOpen then
        BrickComm.Open;
      theType := NameToNXTFileType(InputFilename);
      if LowerCase(ExtractFileExt(InputFilename)) = '.rpg' then
        theType := nftOther;
      BrickComm.StopProgram;
      if Download then
      begin
        if BrickComm.NXTDownloadStream(sIn, InputFilename, theType) then
          DoBeep
        else
          Result := 2;
      end;
      if RunProgram then
        BrickComm.StartProgram(InputFilename);
{$ENDIF}
    end
    else
    begin
      tmpIncDirs := TStringList.Create;
      try
        // add the default include directory
        tmpIncDirs.Add(DefaultIncludeDir);
        if MoreIncludes then
        begin
          incDirs := IncludePaths;
          // does the path contain ';'?  If so parse
          i := Pos(';', incDirs);
          while i > 0 do begin
            tmpIncDirs.Add(Copy(incDirs, 1, i-1));
            Delete(incDirs, 1, i);
            i := Pos(';', incDirs);
          end;
          tmpIncDirs.Add(incDirs);
        end;
        if LowerCase(ExtractFileExt(InputFilename)) = '.npg' then
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
                    BrickComm.StopProgram;
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
        else if LowerCase(ExtractFileExt(InputFilename)) = '.rs' then
        begin
          // RIC compiler
          RIC := TRICComp.Create;
          try
            RIC.IncludeDirs.AddStrings(tmpIncDirs);
            RIC.CurrentFile := GetCurrentFilename;
            RIC.EnhancedFirmware := EnhancedFirmware;
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
                    BrickComm.StopProgram;
                    if BrickComm.NXTDownloadStream(sOut, ChangeFileExt(nxtName, '.ric'), nftGraphics) then
                      DoBeep
                    else
                      Result := 2;
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
        else
        begin
          bNXCErrors := False;
          if LowerCase(ExtractFileExt(InputFilename)) = '.nxc' then
          begin
            NC := TNXCComp.Create;
            try
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
              try
                NC.Parse(sIn);
                DoWriteIntermediateCode(NC);
                sIn.Clear;
                NC.NBCSource.SaveToStream(sIn);
                OptimizationLevel := Max(OptimizationLevel, 1);
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
                      BrickComm.StopProgram;
                      if BrickComm.NXTDownloadStream(sOut, tmpName, nftProgram) then
                        DoBeep
                      else
                        Result := 2;
                    end;
                    if RunProgram then
                      BrickComm.StartProgram(tmpName);
{$ENDIF}
                    if WriteOutput then
                      sOut.SaveToFile(NXTName);
                  end
                  else
                    Result := 1;
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
            Result := 1;
        end;
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
  MaxErrors                := ParamIntValue('-ER', 0, False, Value);
  Quiet                    := ParamSwitch('-q', False, Value);
  WriteCompilerOutput      := ParamSwitch('-L', False, Value);
  CompilerOutputFilename   := ParamValue('-L', False, Value);
  WriteSymbolTable         := ParamSwitch('-Y', False, Value);
  SymbolTableFilename      := ParamValue('-Y', False, Value);
  WriteIntermediateCode    := ParamSwitch('-nbc', False, Value);
  IntermediateCodeFilename := ParamValue('-nbc', False, Value);
  WriteOutput              := ParamSwitch('-O', False, Value);
  OutputFilename           := ParamValue('-O', False, Value);
  UseSpecialName           := ParamSwitch('-N', False, Value);
  SpecialName              := ParamValue('-N', False, Value);
  OptimizationLevel        := 1;
  if ParamSwitch('-Z', False, Value) or ParamSwitch('-Z2', False, Value) then
    OptimizationLevel      := 2
  else if ParamSwitch('-Z1', False, Value) then
    OptimizationLevel      := 1
  else if ParamSwitch('-Z0', False, Value) then
    OptimizationLevel      := 0;
  UsePort                  := ParamSwitch('-S', False, Value);
  PortName                 := ParamValue('-S', False, Value);
  UseBluetooth             := ParamSwitch('-BT', False, Value);
  BinaryInput              := ParamSwitch('-b', False, Value);
  Download                 := ParamSwitch('-d', False, Value);
  RunProgram               := ParamSwitch('-r', False, Value);
  MoreIncludes             := ParamSwitch('-I', False, Value);
  IncludePaths             := ParamValue('-I', False, Value);
  WarningsAreOff           := ParamSwitch('-w-', False, Value);
  EnhancedFirmware         := ParamSwitch('-EF', False, Value);
  FirmwareVersion          := ParamIntValue('-v', 105, False, Value);
  SafeCalls                := ParamSwitch('-safecall', False, Value);
  WriteCompilerMessages    := ParamSwitch('-E', False, Value);
  CompilerMessagesFilename := ParamValue('-E', False, Value);
  IgnoreSystemFile         := ParamSwitch('-n', False, Value);
end;

procedure WriteBytes(data : array of byte);
var
  i : integer;
begin
  for i := Low(data) to High(data) do
    Write(Char(data[i]));
end;

procedure TNBCCompiler.DumpAPI(const idx : integer);
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
{$ENDIF}

initialization
  VerCompanyName      := 'JoCar Consulting';
  VerFileDescription  := '';
  VerFileVersion      := '1.0.1.36';
  VerInternalName     := 'NBC';
  VerLegalCopyright   := 'Copyright (c) 2006, John Hansen';
  VerOriginalFileName := 'NBC';
  VerProductName      := 'Next Byte Codes Compiler';
  VerProductVersion   := '1.0.1.b36';
  VerComments         := '';

end.
