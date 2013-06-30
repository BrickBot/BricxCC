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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit ExecProgram;

{ This unit contains two routines to execute a program
  from a Delpi application. The first one immediately
  returns, the second waits for completion of the program.
  Both get two arguments, the string to execute, and the
  window type of the program (use SW_NORMAL in most cases).
}

interface

uses
{$IFNDEF FPC}
  Windows, ShellApi,
{$ENDIF}
  Messages, SysUtils;

function ExecuteAndContinue(Path, Params, WorkDir: Pchar; Visibility: word ): boolean;

function ExecuteAndWait( Path: PChar; Visibility: Word; aTimeoutMS : Integer; WD : PChar = nil; pEnv : Pointer = nil): Longint;
{
function ExecuteAndWait( Path: Pchar; Visibility: word; aTimeoutMS : Integer;
  var outStr : string; var errStr : string; bUsePipes : Boolean = false): LongInt;
}

implementation

uses
  Forms, uLocalizedStrings, uGlobals;

function ExecuteAndContinue(Path, Params, WorkDir: Pchar; Visibility: word ): boolean;
{$IFDEF FPC}
begin
{$ELSE}
var
  pi: TProcessInformation;
  si: TStartupInfo;
begin
  // prepare the startup info record
  FillMemory( @si, sizeof( TStartupInfo ), 0 );
  with si do
  begin
    cb := sizeof( TStartupInfo );
    wShowWindow := Visibility;
    dwFlags := STARTF_USESHOWWINDOW;
  end;
  // try to create the process
  result := CreateProcess(Path, Params, nil, nil, False, NORMAL_PRIORITY_CLASS, nil, WorkDir, si, pi);
  CloseHandle( pi.hProcess );
  CloseHandle( pi.hThread );
{$ENDIF}
end;

function ExecuteAndWait( Path: PChar; Visibility: Word; aTimeoutMS : Integer; WD : PChar; pEnv : Pointer): Longint;
{$IFDEF FPC}
begin
{$ELSE}
var
  bStat: BOOL;
  pi: TProcessInformation;
  si: TStartupInfo;
  Apprunning, iExit, LastError, saveMS, curMS, tmpMS : Cardinal;
  bTimeout : boolean;
  Error: EOSError;
  tmpStr : string;
begin
  GlobalAbort := False;
  Result := -1;
  tmpStr := Path;
  bTimeout := aTimeoutMS > 0;
  tmpMS := abs(aTimeoutMS);
  FillMemory( @si, sizeof( TStartupInfo ), 0 );
  with si do
  begin
    cb := sizeof( TStartupInfo );
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := Visibility;
  end;

  bStat := CreateProcess
    (
    nil,                    // address of module name
    Path,                   // address of command line
    nil,                    // address of process security attributes
    nil,                    // address of thread security attributes
    false,                  // new process inherits handles
    NORMAL_PRIORITY_CLASS,  // creation flags
    pEnv,                   // address of new environment block
    WD,                     // address of current directory name
    si,                     // address of STARTUPINFO
    pi                      // address of PROCESS_INFORMATION
    );
  try
    if not bStat then
    begin
      // handle the process creation failure
      LastError := GetLastError;
      if LastError = ERROR_FILE_NOT_FOUND then begin
        tmpStr := ExtractFileName(Copy(tmpStr, 1, Pos('.exe', tmpStr)+3));
        Error := EOSError.CreateFmt(sUnableToExecute, [Path, tmpStr, ExtractFilePath(Application.ExeName)]);
        Error.ErrorCode := LastError;
        raise Error;
      end
      else begin
        RaiseLastOSError;
      end;
      Result := 0;
      Exit;
    end;
    saveMS := GetTickCount;
{
    repeat
      GetExitCodeProcess( pi.hProcess, iExit );
    until (iExit <> STILL_ACTIVE);
}
    repeat
      Apprunning := WaitForSingleObject(pi.hProcess, 100);
      Application.ProcessMessages;
      curMS := GetTickCount;
    until GlobalAbort or (Apprunning <> WAIT_TIMEOUT) or (bTimeout and (curMS > saveMS + tmpMS));
    if Apprunning <> WAIT_TIMEOUT then
    begin
      if not GetExitCodeProcess( pi.hProcess, iExit ) then
        RaiseLastOSError;
    end;
{
    repeat
      Win32Check(GetExitCodeProcess( pi.hProcess, iExit ));
      Application.ProcessMessages;
      Sleep(100); // wait 1/10 of a second each time through this loop
      curMS := GetTickCount;
    until GlobalAbort or (iExit <> STILL_ACTIVE) or (bTimeout and (curMS > saveMS + tmpMS));
}
    Result := iExit;
    if GlobalAbort then begin
      GlobalAbort := False;
      // try to kill process
      TerminateProcess(pi.hProcess, CONTROL_C_EXIT);
      raise Exception.Create(sAborted);
    end
    else if iExit = STILL_ACTIVE then begin
      // try to kill process
      TerminateProcess(pi.hProcess, CONTROL_C_EXIT);
      raise Exception.Create(sTimeout);
    end;
  finally
    CloseHandle( pi.hProcess );
    CloseHandle( pi.hThread );
  end;
{$ENDIF}
end;

(*
function ExecuteAndWait( Path: Pchar; Visibility: word; aTimeoutMS : Integer;
  var outStr : string; var errStr : string; bUsePipes : Boolean): LongInt;
const
  BUF_SIZE = 1024;
var
  bStat: BOOL;
  pi: TProcessInformation;
  si: TStartupInfo;
  sa : SECURITY_ATTRIBUTES;
  hReadOutPipe, hWriteOutPipe, hDupWriteOutPipe : THandle;
  hReadErrPipe, hWriteErrPipe, hDupWriteErrPipe : THandle;
  hCP : THandle;
  Buffer : PChar;
  {Apprunning, }dwRead, LastError, iExit, saveMS, curMS, tmpMS : Cardinal;
  bTimeout : boolean;
  Error: EWin32Error;
  tmpStr : string;
  bReadDone : Boolean;
begin
  Result := -1;
  outStr := '';
  errStr := '';
  tmpStr := Path;
  GlobalAbort := False;
  bTimeout := aTimeoutMS > 0;
  tmpMS := abs(aTimeoutMS);
  hCP := GetCurrentProcess;
  // prepare the security attributes record
  FillMemory(@sa, sizeof( SECURITY_ATTRIBUTES ), 0 );
  with sa do
  begin
    nLength := sizeof(SECURITY_ATTRIBUTES);
    lpSecurityDescriptor := nil;
    bInheritHandle := True;
  end;
  //create pipe handles
  if CreatePipe(hReadOutPipe, hWriteOutPipe, @sa, 1024) and
     DuplicateHandle(hCP, hWriteOutPipe, hCP, @hDupWriteOutPipe, 0, True,
       DUPLICATE_CLOSE_SOURCE or DUPLICATE_SAME_ACCESS) then
  try
    if CreatePipe(hReadErrPipe, hWriteErrPipe, @sa, 1024) and
       DuplicateHandle(hCP, hWriteErrPipe, hCP, @hDupWriteErrPipe, 0, True,
         DUPLICATE_CLOSE_SOURCE or DUPLICATE_SAME_ACCESS) then
    try
      // prepare the startup info record
      FillMemory( @si, sizeof( TStartupInfo ), 0 );
      with si do
      begin
        cb := sizeof( TStartupInfo );
        wShowWindow := Visibility;
        if bUsePipes then
        begin
          dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
          hStdError := hDupWriteErrPipe;
//          hStdOutput := GetStdHandle(STD_OUTPUT_HANDLE);
          hStdOutput := hDupWriteOutPipe;
          hStdInput := GetStdHandle(STD_INPUT_HANDLE);
        end
        else
        begin
          dwFlags := STARTF_USESHOWWINDOW;
        end;
      end;
      // try to create the process
      bStat := CreateProcess(nil, Path, nil, nil, bUsePipes, NORMAL_PRIORITY_CLASS, nil, nil, si, pi);
      try
        if not bstat then
        begin
          // handle the process creation failure
          LastError := GetLastError;
          if LastError = ERROR_FILE_NOT_FOUND then begin
            tmpStr := Copy(tmpStr, 1, Pos(' ', tmpStr));
            Error := EWin32Error.CreateFmt(sUnableToExecute, [Path, tmpStr, ExtractFilePath(Application.ExeName)]);
            Error.ErrorCode := LastError;
            raise Error;
          end
          else begin
            RaiseLastWin32Error;
          end;
          Result := 0;
          Exit;
        end;
        // okay, now do something with the newly created process
        CloseHandle(hDupWriteOutPipe);
        CloseHandle(hDupWriteErrPipe);
        saveMS := GetTickCount;
{
        repeat
          Apprunning := WaitForSingleObject(pi.hProcess,100);
          Application.ProcessMessages;
          curMS := GetTickCount;
        until GlobalAbort or (Apprunning <> WAIT_TIMEOUT) or (bTimeout and (curMS > saveMS + tmpMS));
        if Apprunning <> WAIT_TIMEOUT then
        begin
          Win32Check(GetExitCodeProcess( pi.hProcess, iExit ));
        end;
}

        repeat
          Win32Check(GetExitCodeProcess( pi.hProcess, iExit ));
          Application.ProcessMessages;
          Sleep(100); // wait half a second each time through this loop
          curMS := GetTickCount;
        until GlobalAbort or (iExit <> STILL_ACTIVE) or (bTimeout and (curMS > saveMS + tmpMS));

        Result := iExit;
        if GlobalAbort then begin
          // try to kill process
          TerminateProcess(pi.hProcess, CONTROL_C_EXIT);
          raise Exception.Create(sAborted);
        end
        else if iExit = STILL_ACTIVE then begin
          // try to kill process
          TerminateProcess(pi.hProcess, CONTROL_C_EXIT);
          raise Exception.Create(sTimeout);
        end
        else begin
          if bUsePipes then
          begin
            // try now to collect stdout and stderr information
            GetMem(Buffer, BUF_SIZE);
            try

              bReadDone := False;
              while not bReadDone do
              begin
                FillMemory(Buffer, BUF_SIZE, 0);
                ReadFile(hReadOutPipe, Buffer^, BUF_SIZE, dwRead, nil);
                outStr := outStr + String(Buffer);
                bReadDone := dwRead < BUF_SIZE;
              end;

              bReadDone := False;
              while not bReadDone do
              begin
                FillMemory(Buffer, BUF_SIZE, 0);
                ReadFile(hReadErrPipe, Buffer^, BUF_SIZE, dwRead, nil);
                errStr := errStr + String(Buffer);
                bReadDone := dwRead < BUF_SIZE;
              end;
            finally
              FreeMem(Buffer);
            end;
          end;
        end;
      finally
        CloseHandle( pi.hProcess );
        CloseHandle( pi.hThread );
      end;
    finally
      CloseHandle(hReadErrPipe);
    end;
  finally
    CloseHandle(hReadOutPipe);
  end;
end;
*)

end.