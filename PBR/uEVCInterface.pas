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
unit uEVCInterface;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes,
  uCompCommon,
  uEVAClasses,
  uEVCComp;

type
{$IFNDEF CAN_DOWNLOAD}
  TBrickComm = class
    Port : string;
  end;
{$ENDIF}
  TDeviceTarget = (dtEV3);
  TWriteMessages = procedure(aStrings : TStrings);

  TEVCCompiler = class
  private
    fFilename : string;
    fQuiet: boolean;
    fWriteSymbolTable: boolean;
    fSymbolTableFilename: string;
    fWriteIntermediateCode: boolean;
    fIntermediateCodeFilename: string;
    fWriteOutput: boolean;
    fOutputFilename: string;
    fEV3Name : string;
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
    fBC : TBrickComm;
    function GetBrickComm : TBrickComm;
    procedure SetBrickComm(Value : TBrickComm);
    procedure DoBeep;
    procedure DownloadRequestedFiles;
    function CheckFirmwareVersion : boolean;
    procedure DoWriteCompilerOutput(aStrings: TStrings);
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
    property EV3Name : string read fEV3Name write fEV3Name;
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
    property Target : TDeviceTarget read fTarget write fTarget;
    property OnWriteMessages : TWriteMessages read fOnWriteMessages write fOnWriteMessages;
    property OnCompilerStatusChange : TCompilerStatusChangeEvent read fOnCompilerStatusChange write fOnCompilerStatusChange;
    property BrickComm : TBrickComm read GetBrickComm write SetBrickComm;
  end;

implementation

uses
  SysUtils, Math, uVersionInfo, ParamUtils, uGlobals, uLocalizedStrings;

{ TEVCCompiler }

constructor TEVCCompiler.Create;
begin
  inherited;
  fMaxPreprocDepth := 10;
  fMaxErrors := 0;
  fIgnoreSystemFile := False;
  fEnhancedFirmware := False;
  fFirmwareVersion := 105; // 1.05 EV3 firmware
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
  fBC := nil;
end;

destructor TEVCCompiler.Destroy;
begin
  FreeAndNil(fDump);
  FreeAndNil(fExtraDefines);
  FreeAndNil(fMessages);
  if fBCCreated then
    FreeAndNil(fBC);
  inherited;
end;

procedure TEVCCompiler.DoWriteCompilerOutput(aStrings : TStrings);
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

procedure TEVCCompiler.DoWriteIntermediateCode(aStrings : TStrings);
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

procedure TEVCCompiler.Decompile;
var
  D : TRBFDumper;
  ext : string;
begin
  ext := Lowercase(ExtractFileExt(fFilename));
  if (ext = '.rbf') {or (ext = '.sys') or (ext = '.rtm')} then
  begin
    D := TRBFDumper.Create;
    try
      D.FirmwareVersion := FirmwareVersion;
      D.LoadFromFile(fFilename);
      D.Decompile(fDump);
    finally
      D.Free;
    end;
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

function TEVCCompiler.GetCurrentFilename : string;
var
  ext : string;
begin
  ext := ExtractFileExt(InputFilename);
  Result := ChangeFileExt(EV3Name, ext);
  // add a path if there isn't one already
  if ExtractFilename(Result) = Result then
    Result := GetDefaultPath + Result;
end;

function TEVCCompiler.Execute : integer;
var
  sIn : TMemoryStream;
  sOut : TMemoryStream;
  tmpIncDirs : TStringList;
  SC : TEVCComp;
  SL : TStringList;
  i : integer;
  incDirs : string;
  ext : string;
  bEVCErrors : boolean;
{$IFDEF CAN_DOWNLOAD}
  sObj : TMemoryStream;
  theType : TEV3FileType;
  tmpName : string;
  bDownloadOK : boolean;
{$ENDIF}
begin
  fDownloadList := '';
  Result := 0;
  if WriteOutput then
    EV3Name := OutputFilename
  else if UseSpecialName then
    EV3Name := SpecialName
  else
    EV3Name := InputFilename;

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
      theType := EV3NameToPBRFileType(InputFilename);
      BrickComm.DCStopProgram;
      if Download then
      begin
        bDownloadOK := BrickComm.DownloadStream(sIn, InputFilename, theType);
        if bDownloadOK then
          DoBeep
        else begin
          Result := 2;
          HandleOnCompilerStatusChange(Self, sDownloadFailed, True);
        end;
      end;
      if RunProgram then
        BrickComm.DCStartProgram(InputFilename);
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
        if (ext = '.evc') or (ext = '.eva') then
        begin
          // EVC compiler
          SC := TEVCComp.Create;
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
              if (ext = '.evc') then
              begin
                SC.Parse(sIn);
                DoWriteIntermediateCode(SC.ASMSource);
              end
              else
              begin
                // eva code
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
            bEVCErrors := SC.ErrorCount > 0;
            if not bEVCErrors then
            begin
              sOut := TMemoryStream.Create;
              try
                SC.CompilerMessages.Clear;
                if SC.SaveToStream(sOut) then
                begin
{$IFDEF CAN_DOWNLOAD}
                  tmpName := ChangeFileExt(MakeValidNXTFilename(EV3Name), '.rbf');
                  if Download then
                  begin
                    // download the compiled code to the brick
                    if not BrickComm.IsOpen then
                      BrickComm.Open;
                    BrickComm.DCStopProgram;
                    sObj := TMemoryStream.Create;
                    try
                      SProBinToObj(sOut, sObj);
                      if BrickComm.DownloadStream(sObj, '', nftProgram) then
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
                    BrickComm.DCStartProgram(tmpName);
{$ENDIF}
                  if WriteOutput then
                    sOut.SaveToFile(EV3Name);
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
        else
          DoWriteMessage('# Error: ' + Format(sInvalidFileType, [ext]));
      finally
        tmpIncDirs.Free;
      end;
    end;
  finally
    sIn.Free;
  end;
  DownloadRequestedFiles;
end;

procedure TEVCCompiler.DoWriteMessages(aStrings: TStrings);
begin
  fMessages.AddStrings(aStrings);
//  fMessages.Assign(aStrings);
  if Assigned(fOnWriteMessages) then
    fOnWriteMessages(aStrings);
end;

procedure TEVCCompiler.SetCommandLine(const Value: string);
begin
  fCommandLine := Value;
  // set properties given command line switches
  if ParamValue('-T', False, Value) = 'EV3' then
    Target := dtEV3
  else
    Target := dtEV3;
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

procedure TEVCCompiler.HandleOnCompilerStatusChange(Sender: TObject;
  const StatusMsg: string; const bDone : boolean);
begin
  if Assigned(fOnCompilerStatusChange) then
    fOnCompilerStatusChange(Sender, StatusMsg, bDone);
end;

procedure TEVCCompiler.DoWriteMessage(const aString: String);
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

function TEVCCompiler.GetBrickComm : TBrickComm;
begin
  if not Assigned(fBC) then
  begin
{$IFDEF CAN_DOWNLOAD}
    fBC := TFantomSpirit.Create();
    fBCCreated := True;
    fBC.BrickType := rtNXT;
{$ELSE}
    fBC := TBrickComm.Create;
{$ENDIF}
  end;
  Result := fBC;
end;

procedure TEVCCompiler.SetBrickComm(Value: TBrickComm);
begin
  if fBCCreated then
    FreeAndNil(fBC);
  fBC := Value;
  fBCCreated := False;
end;

procedure TEVCCompiler.DoBeep;
begin
  if not fQuiet then
  begin
{$IFDEF CAN_DOWNLOAD}
    BrickComm.PlayTone(440, 100);
{$ENDIF}
  end;
end;

procedure TEVCCompiler.DownloadRequestedFiles;
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
        // all files other than .evc, and .eva should
        // just be downloaded and not compiled first.
        BinaryInput := not ((ext = '.evc') or (ext = '.eva'));
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

function TEVCCompiler.CheckFirmwareVersion: boolean;
//var
//  fwVer : word;
begin
{$IFDEF CAN_DOWNLOAD}
  fwVer := BrickComm.SCFirmwareVersion;
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
{$ELSE}
  Result := True;
{$ENDIF}
end;

initialization
  VerCompanyName      := 'JoCar Consulting';
  VerFileDescription  := '';
  VerFileVersion      := '0.1.0.a1';
  VerInternalName     := 'EVC';
  VerLegalCopyright   := 'Copyright (c) 2006-2013, John Hansen';
  VerOriginalFileName := 'EVC';
  VerProductName      := 'EV3 Compiler';
  VerProductVersion   := '0.1';
  VerComments         := '';

end.
