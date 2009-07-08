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
unit brick_common;

interface

uses
  uSpirit;

var
  LocalBrickType : integer;      // Brick type to use for this instance

function BrickComm : TBrickComm;
procedure ReleaseBrickComm;
procedure CreateInitFile;

implementation

uses
  SysUtils, FakeSpirit, FantomSpirit;

var
  BC : TBrickComm;

function BrickComm : TBrickComm;
begin
  if not Assigned(BC) then
  begin
    if LocalBrickType = SU_NXT then
      BC := TFantomSpirit.Create()
    else
      BC := TFakeSpirit.Create();
  end;
  Result := BC;
end;

procedure ReleaseBrickComm;
begin
  if Assigned(BC) then
    FreeAndNil(BC);
end;

procedure CreateInitFile;
var
  oldbt : integer;
begin
  if FantomAPIAvailable then
  begin
    oldbt := LocalBrickType;
    try
      LocalBrickType := rtNXT;
      BrickComm.NXTInitializeResourceNames;
    finally
      ReleaseBrickComm;
      LocalBrickType := oldbt;
    end;
  end;
end;

initialization
  LocalBrickType := SU_RCX;
  BC := nil;

finalization
  BC.Free;

end.
