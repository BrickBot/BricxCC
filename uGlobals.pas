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
unit uGlobals;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

const
  // remote commands
  kRemoteKeysReleased = $0000;
  kRemotePBMessage1   = $0100;
  kRemotePBMessage2   = $0200;
  kRemotePBMessage3   = $0400;
  kRemoteOutAForward  = $0800;
  kRemoteOutBForward  = $1000;
  kRemoteOutCForward  = $2000;
  kRemoteOutABackward = $4000;
  kRemoteOutBBackward = $8000;
  kRemoteOutCBackward = $0001;
  kRemoteSelProgram1  = $0002;
  kRemoteSelProgram2  = $0004;
  kRemoteSelProgram3  = $0008;
  kRemoteSelProgram4  = $0010;
  kRemoteSelProgram5  = $0020;
  kRemoteStopOutOff   = $0040;
  kRemotePlayASound   = $0080;

{$IFDEF FPC}
const
  MB_ICONASTERISK = $00000040;
{$ENDIF}

const
  K_RCX   = 'RCX';
  K_CYBER = 'CyberMaster';
  K_SCOUT = 'Scout';
  K_RCX2  = 'RCX2';
  K_SPY   = 'Spybot';
  K_SWAN  = 'Swan';
  K_NXT   = 'NXT';
  K_SPRO  = 'SuperPro';

const
  rtRCX         = 0;
  rtCybermaster = 1;
  rtScout       = 2;
  rtRCX2        = 3;
  rtSpy         = 4;
  rtSwan        = 5;
  rtNXT         = 6;
  rtSPro        = 7;
  rtFoo         = 8;

const
  SU_RCX         = rtRCX;
  SU_CYBERMASTER = rtCybermaster;
  SU_SCOUT       = rtScout;
  SU_RCX2        = rtRCX2;
  SU_SPYBOTIC    = rtSpy;
  SU_SWAN        = rtSwan;
  SU_NXT         = rtNXT;
  SU_SPRO        = rtSPro;
  SU_FOO         = rtFoo;

var
  UserDataLocalPath : string;
  SymFileLibraryPath : string;
  
var
  LocalBrickType : integer;
  LocalStandardFirmware : Boolean;

var
  GlobalAbort : boolean;

function IsNXT : boolean;
function IsSwan : boolean;
function IsRCX2 : boolean;
function IsRCX : boolean;
function IsScout : boolean;
function IsSpybotic : boolean;
function IsSuperPro : boolean;
function IsFoo : boolean;

{$IFNDEF FPC}
function GetSpecialFolderPath(folder : integer) : string;
{$ENDIF}

implementation

uses
{$IFNDEF FPC}
  SHFolder,
  Windows,
{$ENDIF}
  SysUtils;

function IsNXT : boolean;
begin
  result := (LocalBrickType = SU_NXT);
end;

function IsSwan : boolean;
begin
  result := (LocalBrickType = SU_SWAN);
end;

function IsRCX2 : boolean;
begin
  result := (LocalBrickType = SU_RCX2) or (LocalBrickType = SU_SWAN);
end;

function IsRCX : boolean;
begin
  result := (LocalBrickType = SU_RCX) or (LocalBrickType = SU_RCX2) or (LocalBrickType = SU_SWAN);
end;

function IsScout : boolean;
begin
  result := (LocalBrickType = SU_SCOUT);
end;

function IsSpybotic : boolean;
begin
  result := (LocalBrickType = SU_SPYBOTIC);
end;

function IsSuperPro : boolean;
begin
  result := (LocalBrickType = SU_SPRO);
end;

function IsFoo : boolean;
begin
  result := (LocalBrickType = SU_FOO);
end;

{$IFNDEF FPC}
function GetSpecialFolderPath(folder : integer) : string;
const
  SHGFP_TYPE_CURRENT = 0;
var
  path: array [0..MAX_PATH] of char;
begin
  if SUCCEEDED(SHGetFolderPath(0,folder,0,SHGFP_TYPE_CURRENT,@path[0])) then
    Result := path
  else
    Result := '';
end;
{$ENDIF}

initialization

{$IFNDEF FPC}
  UserDataLocalPath := GetSpecialFolderPath(CSIDL_APPDATA{CSIDL_LOCAL_APPDATA})+'\JoCar Consulting\BricxCC\3.3\';
  SymFileLibraryPath := UserDataLocalPath + 'sym\';
{$ELSE}
  UserDataLocalPath := IncludeTrailingPathDelimiter(ExpandFilename('~')) +
                       IncludeTrailingPathDelimiter('bricxcc');
  SymFileLibraryPath := UserDataLocalPath + IncludeTrailingPathDelimiter('sym');
{$ENDIF}

end.