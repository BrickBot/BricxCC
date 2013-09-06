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
program dll;

{$APPTYPE CONSOLE}

uses
  Classes,
  SysUtils,
  uGlobals in '..\uGlobals.pas',
  uCmdLineUtils in '..\uCmdLineUtils.pas',
  uLocalizedStrings in '..\uLocalizedStrings.pas',
  ParamUtils in '..\ParamUtils.pas',
  uVersionInfo in '..\uVersionInfo.pas',
  uCommonUtils in '..\uCommonUtils.pas',
  uCompCommon in '..\uCompCommon.pas',
  uSpirit,
  EV3Spirit;

{$IFNDEF FPC}
{$R *.RES}
{$ENDIF}

{$I dll_preproc.inc}

type
  TEventHandlerObject = class
  public
    procedure HandleDownloadStart(Sender : TObject);
    procedure HandleDownloadDone(Sender : TObject);
    procedure HandleDownloadStatus(Sender : TObject; cur, total : Integer; var Abort : boolean);
  end;

var
  Filename : string;
  TheErrorCode : integer;
  Quiet : boolean;
  Download : boolean;
  Upload : boolean;
  ListFiles : boolean;
  DeleteFile : boolean;
  Run : boolean;
  UseSpecialName : boolean;
  SpecialName : string;
  DestinationFolder : string;
  PortName : string;
  MS : TMemoryStream;
  BC : TBrickComm;
  EHO : TEventHandlerObject;
  SL : TStringList;
  i : integer;
  
function BrickComm : TBrickComm;
begin
  if not Assigned(BC) then
  begin
    BC := TEV3Spirit.Create();
  end;
  Result := BC;
end;

procedure PrintUsage;
begin
  PrintVersion(COMPILATION_TIMESTAMP);
  WriteLn(Format(UsageSyntax, [progName]));
  WriteLn('');
  WriteLn(UsagePort);
  WriteLn(UsageFolder);
  Writeln(UsageListFiles);
  Writeln(UsageUpload);
  Writeln(UsageDownload);
  Writeln(UsageRunProg);
  Writeln(UsageDelete);
  Writeln(UsageQuiet);
  Writeln(UsageHelp);
  // also takes an undocumented "ev3 name" parameter which is
  // used to tell the compiler what the downloaded program should be called
  // on the EV3: -N=<ev3name>
end;

{ TEventHandlerObject }

procedure TEventHandlerObject.HandleDownloadDone(Sender: TObject);
begin
  WriteLn('Download finished');
end;

procedure TEventHandlerObject.HandleDownloadStart(Sender: TObject);
begin
  WriteLn('Download starting');
end;

procedure TEventHandlerObject.HandleDownloadStatus(Sender: TObject; cur,
  total: Integer; var Abort: boolean);
begin
  Write('.');
  if cur >= total then
    WriteLn('');
end;

begin
{$IFDEF FPC}
  VerCompanyName      := 'JoCar Consulting';
  VerFileDescription  := 'EV3 Downloader';
  VerFileVersion      := '1.0.0.1';
  VerInternalName     := 'dll';
  VerLegalCopyright   := 'Copyright (c) 2006-2013, John Hansen';
  VerOriginalFileName := 'dll';
  VerProductName      := 'EV3 Downloader';
  VerProductVersion   := '1.0';
  VerComments         := '';
{$ENDIF}

  TheErrorCode := 0;
  
  if ParamSwitch('-help', False) then
  begin
    PrintUsage;
    Exit;
  end;

  if ParamCount = 0 then
  begin
    PrintUsageError(COMPILATION_TIMESTAMP);
    TheErrorCode := 1;
    Halt(TheErrorCode);
  end;

  ListFiles := ParamSwitch('-l', False);

  Filename := getFilenameParam();
  if not ListFiles and (Trim(Filename) = '') then
  begin
    PrintUsageError(COMPILATION_TIMESTAMP);
    TheErrorCode := 1;
    Halt(TheErrorCode);
  end;

  Quiet          := ParamSwitch('-q', False);
  UseSpecialName := ParamSwitch('-N', False);
  SpecialName    := ParamValue('-N', False);
  Download       := ParamSwitch('-d', False) or ParamSwitch('-r', False);
  Run            := ParamSwitch('-r', False);
  Upload         := ParamSwitch('-u', not Download);
  DeleteFile     := ParamSwitch('-x', False);

  if not ListFiles and not DeleteFile and ((Upload and Download) or not (Upload or Download)) then
  begin
    PrintUsageError(COMPILATION_TIMESTAMP);
    TheErrorCode := 1;
    Halt(TheErrorCode);
  end;

  DestinationFolder := ParamValue('-F', False);

  PortName := ParamValue('-S', False);
  if PortName = '' then
    PortName := 'usb';

  EHO := TEventHandlerObject.Create;
  try
    BrickComm.OnDownloadStart  := EHO.HandleDownloadStart;
    BrickComm.OnDownloadDone   := EHO.HandleDownloadDone;
    BrickComm.OnDownloadStatus := EHO.HandleDownloadStatus;

    LocalBrickType := SU_EV3;
    BrickComm.Port := PortName;
    if BrickComm.Open then
    begin
      if ListFiles then
      begin
        if DestinationFolder = '' then
          DestinationFolder := BrickComm.BrickFolder;
        SL := TStringList.Create;
        try
          BrickComm.ListFiles(DestinationFolder + '*.*', SL);
          for i := 0 to SL.Count - 1 do
            WriteLn(SL[i]);
        finally
          SL.Free;
        end;
      end
      else if DeleteFile then
      begin
        if DestinationFolder = '' then
          DestinationFolder := BrickComm.BrickFolder;
        filename := DestinationFolder + filename;
        BrickComm.SCDeleteFile(filename, true);
      end
      else if Download then
      begin
        if FileExists(filename) then
        begin
          if DestinationFolder <> '' then
            BrickComm.BrickFolder := DestinationFolder;
          if UseSpecialName then
          begin
            MS := TMemoryStream.Create;
            try
              MS.LoadFromFile(filename);
              if not BrickComm.DownloadStream(MS, SpecialName, nftProgram) then
                TheErrorCode := 3;
            finally
              MS.Free;
            end;
          end
          else
          begin
            if not BrickComm.DownloadFile(filename, nftProgram) then
              TheErrorCode := 3;
          end;

          if not Quiet and (TheErrorCode = 0) then
          begin
            BrickComm.PlayDownloadCompletedSound();
          end;

          if Run and (TheErrorCode = 0) then
          begin
            if not BrickComm.DCStartProgram(ExtractFilename(filename)) then
              TheErrorCode := 4;
          end;
        end
        else
          TheErrorCode := 2;
      end
      else
      begin
        // upload
        if DestinationFolder = '' then
          DestinationFolder := GetCurrentDir;
        if not BrickComm.UploadFile(filename, DestinationFolder) then
          TheErrorCode := 5;
      end;

      BrickComm.Close;
    end
    else
      TheErrorCode := 6;
  finally
    EHO.Free;
  end;

  if TheErrorCode <> 0 then
    Halt(TheErrorCode);
end.
