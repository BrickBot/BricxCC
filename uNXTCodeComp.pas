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
unit uNXTCodeComp;

interface

uses
  Classes;

function NBCCodeCompIndex(aName : string) : Integer;
procedure AddNBCCodeCompParams(aStrings : TStrings; Index : integer);
procedure SaveNBCCodeCompToFile(const aname : string);
procedure LoadNBCCodeCompFromFile(const aname : string);

implementation

uses
  SysUtils, uCppCode;

type
  TNBCCodeComp = record
    Name : string;
    Params : string;
  end;

var
  NBCCodeCompDataSize : integer = 0;
  NBCCodeCompData : array of TNBCCodeComp;

procedure AddNBCCodeCompParams(aStrings : TStrings; Index : integer);
begin
  if (Index < 0) or (Index >= NBCCodeCompDataSize) then Exit;
  AddCodeCompParamsHelper(aStrings, NBCCodeCompData[Index].Params, 'void', ',');
end;

function NBCCodeCompIndex(aName : string) : Integer;
var
  i : Integer;
begin
  Result := -1;
  for i := 0 to NBCCodeCompDataSize - 1 do begin
    if NBCCodeCompData[i].Name = aName then begin
      Result := i;
      Exit;
    end;
  end;
end;

procedure SaveNBCCodeCompToFile(const aname : string);
var
  i : Integer;
  SL : TStringList;
  cc : TNBCCodeComp;
begin
  SL := TStringList.Create;
  try
    for i := 0 to NBCCodeCompDataSize - 1 do begin
      cc := NBCCodeCompData[i];
      SL.Add(cc.Name + cc.Params);
    end;
    SL.SaveToFile(aname);
  finally
    SL.Free;
  end;
end;

procedure LoadNBCCodeCompFromFile(const aname : string);
var
  SL : TStringList;
  i, p : integer;
  tmp, funcParams : string;
  cc : TNBCCodeComp;
begin
  NBCCodeCompDataSize := 0;
  SetLength(NBCCodeCompData, 0);
  if FileExists(aname) then
  begin
    SL := TStringList.Create;
    try
      SL.LoadFromFile(aname);
      NBCCodeCompDataSize := SL.Count;
      SetLength(NBCCodeCompData, NBCCodeCompDataSize);
      for i := 0 to SL.Count - 1 do
      begin
        tmp := SL[i];
        p := Pos('(', tmp);
        funcParams := Copy(tmp, p, MaxInt);
        System.Delete(tmp, p, MaxInt);
        cc.Name   := tmp;
        cc.Params := funcParams;
        NBCCodeCompData[i] := cc;
      end;
    finally
      SL.Free;
    end;
  end;
end;

end.
