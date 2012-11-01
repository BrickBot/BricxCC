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
unit uRICCodeComp;

interface

uses
  Classes;

function RICScriptCodeCompIndex(aName : string) : Integer;
procedure AddRICScriptCodeCompParams(aStrings : TStrings; Index : integer);
procedure SaveRICScriptCodeCompToFile(const aname : string);
procedure LoadRICScriptCodeCompFromFile(const aname : string);

implementation

uses
  SysUtils, uCppCode;

type
  TRICCodeComp = record
    Name : string;
    Params : string;
  end;

var
  RICScriptCodeCompDataSize : integer = 0;
  RICScriptCodeCompData : array of TRICCodeComp;

function RICScriptCodeCompIndex(aName : string) : Integer;
var
  i : Integer;
begin
  Result := -1;
  for i := 0 to RICScriptCodeCompDataSize - 1 do begin
    if RICScriptCodeCompData[i].Name = aName then begin
      Result := i;
      Exit;
    end;
  end;
end;

procedure AddRICScriptCodeCompParams(aStrings : TStrings; Index : integer);
begin
  if (Index < 0) or (Index >= RICScriptCodeCompDataSize) then Exit;
  AddCodeCompParamsHelper(aStrings, RICScriptCodeCompData[Index].Params, 'void', ',');
end;

procedure SaveRICScriptCodeCompToFile(const aname : string);
var
  i : Integer;
  SL : TStringList;
  cc : TRICCodeComp;
begin
  SL := TStringList.Create;
  try
    for i := 0 to RICScriptCodeCompDataSize - 1 do begin
      cc := RICScriptCodeCompData[i];
      SL.Add(cc.Name + cc.Params);
    end;
    SL.SaveToFile(aname);
  finally
    SL.Free;
  end;
end;

procedure LoadRICScriptCodeCompFromFile(const aname : string);
var
  SL : TStringList;
  i, p : integer;
  tmp, funcParams : string;
  cc : TRICCodeComp;
begin
  RICScriptCodeCompDataSize := 0;
  SetLength(RICScriptCodeCompData, 0);
  if FileExists(aname) then
  begin
    SL := TStringList.Create;
    try
      SL.LoadFromFile(aname);
      RICScriptCodeCompDataSize := SL.Count;
      SetLength(RICScriptCodeCompData, RICScriptCodeCompDataSize);
      for i := 0 to SL.Count - 1 do
      begin
        tmp := SL[i];
        p := Pos('(', tmp);
        funcParams := Copy(tmp, p, MaxInt);
        System.Delete(tmp, p, MaxInt);
        cc.Name   := tmp;
        cc.Params := funcParams;
        RICScriptCodeCompData[i] := cc;
      end;
    finally
      SL.Free;
    end;
  end;
end;

end.