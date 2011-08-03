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
unit uSPCCodeComp;

interface

uses
  Classes;

function SPCCodeCompIndex(aName : string) : Integer;
procedure AddSPCCodeCompParams(aStrings : TStrings; Index : integer);
procedure SaveSPCCodeCompToFile(const aname : string);
procedure LoadSPCCodeCompFromFile(const aname : string; bIncludeExtras : boolean = false);

implementation

uses
  SysUtils, uCppCode, uBasicPrefs, uGlobals;

type
  TSPCCodeComp = record
    Name : string;
    Params : string;
  end;

var
  SPCCodeCompDataSize : integer = 0;
  SPCCodeCompData : array of TSPCCodeComp;

function SPCCodeCompIndex(aName : string) : Integer;
var
  i : Integer;
begin
  Result := -1;
  for i := 0 to SPCCodeCompDataSize - 1 do begin
    if SPCCodeCompData[i].Name = aName then begin
      Result := i;
      Exit;
    end;
  end;
end;

procedure AddSPCCodeCompParams(aStrings : TStrings; Index : integer);
begin
  if (Index < 0) or (Index >= SPCCodeCompDataSize) then Exit;
  AddCodeCompParamsHelper(aStrings, SPCCodeCompData[Index].Params, 'void', ',');
end;

procedure SaveSPCCodeCompToFile(const aname : string);
var
  i : Integer;
  SL : TStringList;
  cc : TSPCCodeComp;
begin
  SL := TStringList.Create;
  try
    for i := 0 to SPCCodeCompDataSize-1 do begin
      cc := SPCCodeCompData[i];
      SL.Add(cc.Name + cc.Params);
    end;
    SL.SaveToFile(aname);
  finally
    SL.Free;
  end;
end;

procedure LoadSPCCodeCompFromFile(const aname : string; bIncludeExtras : boolean);
var
  SL, tmpSL : TStringList;
  i, p : integer;
  tmp, funcParams : string;
  cc : TSPCCodeComp;
begin
  SL := CreateSortedStringList(True);
  try
    SPCCodeCompDataSize := 0;
    SetLength(SPCCodeCompData, 0);
    // standard default SPC api file
    if FileExists(aname) then
    begin
      tmpSL := CreateSortedStringList(True);
      try
        tmpSL.LoadFromFile(aname);
        SL.AddStrings(tmpSL);
      finally
        tmpSL.Free;
      end;
    end;
    if bIncludeExtras then
    begin
      // extra api in same folder as spc_api.txt
      tmp := ExtractFilePath(aname) + 'spc_api_extra.txt';
      if FileExists(tmp) then
      begin
        tmpSL := CreateSortedStringList(True);
        try
          tmpSL.LoadFromFile(tmp);
          SL.AddStrings(tmpSL);
        finally
          tmpSL.Free;
        end;
      end;
      // extra api in UserDataLocalPath folder
      tmp := UserDataLocalPath + 'spc_api_extra.txt';
      if FileExists(tmp) then
      begin
        tmpSL := CreateSortedStringList(True);
        try
          tmpSL.LoadFromFile(tmp);
          SL.AddStrings(tmpSL);
        finally
          tmpSL.Free;
        end;
      end;
    end;
    SPCCodeCompDataSize := SL.Count;
    SetLength(SPCCodeCompData, SPCCodeCompDataSize);
    for i := 0 to SL.Count - 1 do
    begin
      tmp := SL[i];
      p := Pos('(', tmp);
      funcParams := Copy(tmp, p, MaxInt);
      System.Delete(tmp, p, MaxInt);
      cc.Name   := tmp;
      cc.Params := funcParams;
      SPCCodeCompData[i] := cc;
    end;
  finally
    SL.Free;
  end;
end;

end.
