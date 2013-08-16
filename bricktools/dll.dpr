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
  UseSpecialName : boolean;
  SpecialName : string;
  RemoteFolder : string;
  PortName : string;
  MS : TMemoryStream;
  data : array of byte;
  BC : TBrickComm;
  EHO : TEventHandlerObject;
  
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
  Writeln(UsageRunProg);
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
  VerFileVersion      := '0.1.0.1';
  VerInternalName     := 'dll';
  VerLegalCopyright   := 'Copyright (c) 2006-2013, John Hansen';
  VerOriginalFileName := 'dll';
  VerProductName      := 'EV3 Downloader';
  VerProductVersion   := '0.1';
  VerComments         := '';
{$ENDIF}

  TheErrorCode := 0;
  Quiet := False;
  UseSpecialName := False;
  SpecialName := '';
  
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

  Filename := getFilenameParam();
  if Trim(Filename) = '' then
  begin
    PrintUsageError(COMPILATION_TIMESTAMP);
    TheErrorCode := 1;
    Exit;
  end;

  Quiet          := ParamSwitch('-q', False);
  UseSpecialName := ParamSwitch('-N', False);
  SpecialName    := ParamValue('-N', False);

  RemoteFolder   := ParamValue('-F', False);
  if RemoteFolder = '' then
    RemoteFolder := '/media/card/';

  PortName       := ParamValue('-S', False);
  if PortName = '' then
    PortName := 'usb';

  if FileExists(filename) then
  begin
    EHO := TEventHandlerObject.Create;
    try
      BrickComm.OnDownloadStart  := EHO.HandleDownloadStart;
      BrickComm.OnDownloadDone   := EHO.HandleDownloadDone;
      BrickComm.OnDownloadStatus := EHO.HandleDownloadStatus;

      LocalBrickType := SU_EV3;
      BrickComm.Port := PortName;
      if BrickComm.Open then
      begin
        BrickComm.BrickFolder := RemoteFolder;
        if UseSpecialName then
        begin
          MS := TMemoryStream.Create;
          try
            MS.LoadFromFile(filename);
            if not BrickComm.DownloadStream(MS, SpecialName, nftProgram) then
              TheErrorCode := 1;
          finally
            MS.Free;
          end;
        end
        else
        begin
          if not BrickComm.DownloadFile(filename, nftProgram) then
            TheErrorCode := 1;
        end;

        if not Quiet and (TheErrorCode = 0) then
        begin
          BrickComm.PlayDownloadCompletedSound();
        end;

        BrickComm.Close;
      end
      else
        TheErrorCode := 1;
    finally
      EHO.Free;
    end;
  end
  else
    TheErrorCode := 1;
  if TheErrorCode <> 0 then
    Halt(TheErrorCode);
end.
