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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit RcxLog;

interface

uses
  Classes, FakeSpirit, rcx_link;

type
  TRcxLog = class
  private
    fLength : integer;
    fData : array of smallint;
    fTypes : array of Byte;
  protected
    function GetLength : integer;
    procedure SetLength(aLen : integer);
    function GetType(aIndex : integer) : Byte;
    function GetData(aIndex : integer) : smallint;
  public
    constructor Create;
    destructor Destroy; override;
    function Upload(aLink : TRcxLink) : integer;
    function SPrintEntry(aIndex : integer; bVerbose : boolean) : string;
    property Length : integer read GetLength write SetLength;
  end;

implementation

uses
  SysUtils, rcx_cmd, rcx_constants;

{ TRcxLog }

constructor TRcxLog.Create;
begin
  inherited Create;
  fLength := 0;
  fData := nil;
  fTypes := nil;
end;

destructor TRcxLog.Destroy;
begin
  fData := nil;
  fTypes := nil;
  inherited Destroy;
end;

function TRcxLog.GetData(aIndex: integer): smallint;
begin
  result := fData[aIndex];
end;

function TRcxLog.GetLength: integer;
begin
  result := fLength;
end;

function TRcxLog.GetType(aIndex: integer): Byte;
begin
  result := fTypes[aIndex];
end;

procedure TRcxLog.SetLength(aLen: integer);
begin
  if fLength > 0 then
  begin
    fData := nil;
    fTypes := nil;
  end;
  if aLen > 0 then
  begin
    System.SetLength(fData, aLen);
    System.SetLength(fTypes, aLen);
  end;
  fLength := aLen;
end;

function TRcxLog.SPrintEntry(aIndex: integer; bVerbose: boolean): string;
var
  aType : Byte;
begin
  result := '';
  if bVerbose then
  begin
    aType := GetType(aIndex);
    case aType and $e0 of
      $00 :  result := result + Format('Variable %d: ', [aType and $1f]);
      $20 :  result := result + Format('Timer %d: ', [aType and $1f]);
      $40 :  result := result + Format('Sensor %d: ', [(aType and $1f) + 1]);
      $80 :  result := result + 'Watch: ';
    else
      result := result + Format('%02x: ', [aType]);
    end;
  end;
  result := result + Format('%d', [GetData(aIndex)]);
end;

function TRcxLog.Upload(aLink: TRcxLink): integer;
var
  cmd : TRcxCmd;
  length, i, pos, n : integer;
const
  kPointsPerUpload = 10;
begin
  cmd := TRcxCmd.Create;
  try
    aLink.Sync;
    result := aLink.Send(cmd.MakeUploadDatalog(0, 1));
    if result < 0 then Exit;
    if result <> 3 then
    begin
      result := kRCX_ReplyError;
      Exit;
    end;
    length := (aLink.GetReplyByte(1) + (aLink.GetReplyByte(2) shl 8)) - 1;
    SetLength(length);
    pos := 0;
    while pos < length do
    begin
      // how many points to upload
      n := length - pos;
      if n > kPointsPerUpload then n := kPointsPerUpload;
      result := aLink.Send(cmd.MakeUploadDatalog(pos+1, n));
      if result < 0 then Exit;
      if result <> (n * 3) then
      begin
        result := kRCX_ReplyError;
        Exit;
      end;

      for i := 0 to n - 1 do
      begin
        fTypes[pos+i] := aLink.GetReplyByte(i*3);
        fData[pos+i]  := smallint((aLink.GetReplyByte(i*3+1)) + (Word(aLink.GetReplyByte(i*3+2)) shl 8));
      end;
      inc(pos, n);
      if not aLink.DownloadProgress(pos, length) then break;
    end;
  finally
    cmd.Free;
  end;
end;

end.