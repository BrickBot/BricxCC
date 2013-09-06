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
unit uEV3TypeData;

interface

uses
  Classes;

type
  EV3TypeData = record
    TypeName : string;
    ModeCount : byte; // up to 8
    Modes : array[0..7] of string[11];
  end;

procedure InitializeTypeData;
function  TypeDataCount : integer;
function  TypeDataByID(ID : byte) : EV3TypeData;
procedure LoadTypeNames(aStrings : TStrings);
procedure LoadTypeModes(aType : Integer; aStrings : TStrings);

implementation

uses
  SysUtils, uGlobals;

var
  gTypeData : array of EV3TypeData;

type
  PEV3TypeData = ^EV3TypeData;

const
  TYPE_THIRD_PARTY_START = 50;
  TYPE_THIRD_PARTY_END   = 99;

procedure InitializeTypeData;
var
  i, j : integer;
  name, tmpPath : string;
  SL : TStringList;

  procedure ProcessTypeNameFile(aPath : string);
  var
    line : string;
    k, p, id : integer;
    pTD : PEV3TypeData;
  begin
    SL.LoadFromFile(aPath);
    for k := 0 to SL.Count - 1 do
    begin
      line := SL[k];
      if (line = '') or (line[1] = '/') then Continue;
      line := Trim(line);
      // first is the type ID
      p := Pos(' ', line);
      if p = 0 then Continue;
      id := StrToIntDef(Copy(line, 1, p-1), 0);
      if id = 0 then Continue; // skip lines with invalid Type IDs
      System.Delete(line, 1, p);
      pTD := @(gTypeData[id]);
      pTD^.TypeName := Trim(line);
    end;
  end;

  procedure ProcessTypeDataFile(aPath : string);
  var
    line, tmp : string;
    k, p, id, mode : integer;
    pTD : PEV3TypeData;
  begin
    SL.LoadFromFile(aPath);
    for k := 0 to SL.Count - 1 do
    begin
      line := SL[k];
      if (line = '') or (line[1] = '/') then Continue;
      line := Trim(line);

      // there might be a * and/or a # ahead of the type
      if (Length(line) > 0) and (line[1] = '*') then
        System.Delete(line, 1, 2); // remove * and space after it
      line := Trim(line);
      if (Length(line) > 0) and (line[1] = '#') then
        System.Delete(line, 1, 2); // remove * and space after it
      line := Trim(line);

      // next is the type ID
      p := Pos(' ', line);
      if p = 0 then Continue;

      tmp := Copy(line, 1, p-1);
      System.Delete(line, 1, p);
      line := Trim(line);

      id := StrToIntDef(tmp, 0);
      if id = 0 then Continue; // skip lines with invalid Type IDs

      pTD := @(gTypeData[id]);
      if pTD^.ModeCount = 8 then Continue; // skip lines if we already have all 8 modes for this type

      Inc(pTD^.ModeCount); // if we have fewer than 8 modes already then increment our count

      // next is the mode number
      p := Pos(' ', line);
      if p = 0 then Continue;

      tmp := Copy(line, 1, p-1);
      System.Delete(line, 1, p);
      line := Trim(line);

      mode := StrToIntDef(tmp, -1);
      if mode = -1 then Continue; // skip lines with invalid modes

      // next is the mode name
      p := Pos(' ', line);
      if p = 0 then Continue;

      tmp := Copy(line, 1, p-1);

      pTD^.Modes[mode] := tmp;
    end;
  end;
begin
  SetLength(gTypeData, 128);
  for i := 0 to 127 do
  begin
    if i = 0 then
      name := 'None'
    else
      name := 'Unknown';
    gTypeData[i].TypeName := name;
    gTypeData[i].ModeCount := 0;
    for j := 0 to 7 do
      gTypeData[i].Modes[j] := '';
  end;
  SL := TStringList.Create;
  try
    tmpPath := ProgramDir+IncludeTrailingPathDelimiter('Default')+'typedata.rcf';
    if FileExists(tmpPath) then
    begin
      ProcessTypeDataFile(tmpPath);
    end;
    tmpPath := ProgramDir+IncludeTrailingPathDelimiter('Default')+'typename.rcf';
    if FileExists(tmpPath) then
    begin
      ProcessTypeNameFile(tmpPath);
    end;
    for i := TYPE_THIRD_PARTY_START to TYPE_THIRD_PARTY_END do
    begin
      tmpPath := ProgramDir+IncludeTrailingPathDelimiter('Default')+Format('typedata%d.rcf', [i]);
      if FileExists(tmpPath) then
      begin
        ProcessTypeDataFile(tmpPath);
      end;
      tmpPath := ProgramDir+IncludeTrailingPathDelimiter('Default')+Format('typename%d.rcf', [i]);
      if FileExists(tmpPath) then
      begin
        ProcessTypeNameFile(tmpPath);
      end;
    end;
  finally
    SL.Free;
  end;
(*
// Reserved device types
typedef   enum
{
//  TYPE_KEEP                     =   0,  //!< Type value that won't change type in byte codes
  TYPE_NXT_TOUCH                =   1,  //!< Device is NXT touch sensor
  TYPE_NXT_LIGHT                =   2,  //!< Device is NXT light sensor
  TYPE_NXT_SOUND                =   3,  //!< Device is NXT sound sensor
  TYPE_NXT_COLOR                =   4,  //!< Device is NXT color sensor

  TYPE_TACHO                    =   7,  //!< Device is a tacho motor
  TYPE_MINITACHO                =   8,  //!< Device is a mini tacho motor
  TYPE_NEWTACHO                 =   9,  //!< Device is a new tacho motor

  TYPE_THIRD_PARTY_START        =  50,
  TYPE_THIRD_PARTY_END          =  99,

  TYPE_IIC_UNKNOWN              = 100,

  TYPE_NXT_TEST                 = 101,  //!< Device is a NXT ADC test sensor

  TYPE_NXT_IIC                  = 123,  //!< Device is NXT IIC sensor
  TYPE_TERMINAL                 = 124,  //!< Port is connected to a terminal
  TYPE_UNKNOWN                  = 125,  //!< Port not empty but type has not been determined
  TYPE_NONE                     = 126,  //!< Port empty or not available
  TYPE_ERROR                    = 127,  //!< Port not empty and type is invalid
}
TYPE;
*)
end;

function  TypeDataCount : integer;
begin
  Result := Length(gTypeData);
end;

function  TypeDataByID(ID : byte) : EV3TypeData;
begin
  Result.TypeName := 'None';
  Result.ModeCount := 0;
  if ID < Length(gTypeData) then
  begin
    Result := gTypeData[ID];
  end;
end;

procedure LoadTypeNames(aStrings : TStrings);
var
  i : integer;
begin
  aStrings.Clear;
  for i := 0 to Length(gTypeData) - 1 do
  begin
    aStrings.Add(gTypeData[i].TypeName);
  end;
end;

procedure LoadTypeModes(aType : Integer; aStrings : TStrings);
var
  pTD : PEV3TypeData;
  i : integer;
begin
  aStrings.Clear;
  if (aType >= 0) and (aType < Length(gTypeData)) then
  begin
    pTD := @(gTypeData[aType]);
    if pTD^.ModeCount = 0 then
    begin
      // put in a Default mode
      aStrings.Add('Default');
    end
    else
    begin
      for i := 0 to pTD^.ModeCount - 1 do
      begin
        aStrings.Add(pTD^.Modes[i]);
      end;
    end;
  end;
end;

end.
