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
unit uCppCode;

interface

uses
  SynCompletionProposal, Classes;

type
  TCodeKind = (ckKeyword, ckAPIConst, ckAPIVar, ckAPIFunc, ckAPIType);
  TAlphaType = (atNumeric, atNumeric1, atNumeric2, atUpper, atLower, atNumeric1Upper);
  TCppCodeComp = record
    Kind : TCodeKind;
    Name : string;
    Location : Byte;
    Params : string;
    Count : Byte;
    Alpha : TAlphaType;
  end;

procedure PopulateCppCompProp(aCP : TSynCompletionProposal);
function CppCodeCompIndex(aName : string) : Integer;
procedure AddCppCodeCompParams(aStrings : TStrings; Index : integer);
procedure PopulatePasCompProp(aCP : TSynCompletionProposal);
function PasCodeCompIndex(aName : string) : Integer;
procedure AddPasCodeCompParams(aStrings : TStrings; Index : integer);
procedure PopulateROPSCompProp(aCP : TSynCompletionProposal);
function ROPSCodeCompIndex(aName : string) : Integer;
procedure AddROPSCodeCompParams(aStrings : TStrings; Index : integer);
function MSCodeCompIndex(aName : string) : Integer;
procedure AddMSCodeCompParams(aStrings : TStrings; Index : integer);

procedure AddCodeCompParamsHelper(aStrings : TStrings; s, empty, sep : string);

implementation

uses
  SysUtils, uPasCode, uCppCodeComp, uROPSCodeComp;

const
  CodeKindNames: array[TCodeKind] of String = (
    'keyword', 'constant', 'variable', 'function', 'type'
  );

var
  theCppNameList : TStringList;
  thePasNameList : TStringList;
  theROPSNameList : TStringList;

procedure PopulateCompPropHelper(aCP : TSynCompletionProposal;
  CCC : array of TCppCodeComp; MaxSize : Integer; NL : TStrings;
  UN : array of String; bCase : Boolean);
var
  i, j, k : Integer;
  X : TCppCodeComp;
  s : string;

  procedure DoListAdding;
  begin
    if bCase then
      NL.AddObject(s, TObject(i))
    else
      NL.AddObject(LowerCase(s), TObject(i));
    aCP.InsertList.Add(s);
    s := CodeKindNames[X.Kind] + '\column{}' + s + ' ' + X.Params;
    if X.Location <> 0 then
      s := s + ' - ' + UN[X.Location];
    aCP.ItemList.Add(s);
  end;

begin
  // populate this item
  aCP.ItemList.Clear;
  aCP.InsertList.Clear;
  for i := 0 to MaxSize - 1 do begin
    X := CCC[i];
    if X.Count > 1 then begin
      if X.Alpha = atNumeric1Upper then begin
        for j := 0 to X.Count - 1 do begin
          for k := 0 to X.Count - 1 do begin
            // number then alpha
            s := StringReplace(X.Name, '%', IntToStr(j+1) + Chr(k + Ord('A')), [rfReplaceAll]);
            DoListAdding;
          end;
        end;
      end
      else begin
        for j := 0 to X.Count - 1 do begin
          case X.Alpha of
            atNumeric, atNumeric1, atNumeric2 : begin
              // depends on the ordinal values being 0, 1, & 2
              s := StringReplace(X.Name, '%', IntToStr(j + Ord(X.Alpha)), [rfReplaceAll]);
            end;
            atUpper : begin
              s := StringReplace(X.Name, '%', Chr(j + Ord('A')), [rfReplaceAll]);
            end;
            atLower : begin
              s := StringReplace(X.Name, '%', Chr(j + Ord('a')), [rfReplaceAll]);
            end;
          end;
          DoListAdding;
        end;
      end;
    end
    else begin
      s := X.Name;
      DoListAdding;
    end;
  end;
end;

procedure PopulateCppCompProp(aCP : TSynCompletionProposal);
begin
  PopulateCompPropHelper(aCP, CppCodeCompData, CppCodeCompDataSize,
    theCppNameList, UnitNames, True);
end;

procedure PopulatePasCompProp(aCP : TSynCompletionProposal);
begin
  PopulateCompPropHelper(aCP, PasCodeCompData, PasCodeCompDataSize,
    thePasNameList, PasUnitNames, False);
end;


function CppCodeCompIndex(aName : string) : Integer;
var
  i : Integer;
begin
  Result := -1;
  i := theCppNameList.IndexOf(aName);
  if i <> -1 then
    Result := Integer(theCppNameList.Objects[i]);
end;

function PasCodeCompIndex(aName : string) : Integer;
var
  i : Integer;
begin
  Result := -1;
  i := thePasNameList.IndexOf(LowerCase(aName));
  if i <> -1 then
    Result := Integer(thePasNameList.Objects[i]);
end;

procedure PopulateROPSCompProp(aCP : TSynCompletionProposal);
begin
  PopulateCompPropHelper(aCP, ROPSCodeCompData, ROPSCodeCompDataSize,
    theROPSNameList, ROPSUnitNames, False);
end;

function ROPSCodeCompIndex(aName : string) : Integer;
var
  i : Integer;
begin
  Result := -1;
  i := theROPSNameList.IndexOf(LowerCase(aName));
  if i <> -1 then
    Result := Integer(theROPSNameList.Objects[i]);
end;

procedure AddROPSCodeCompParams(aStrings : TStrings; Index : integer);
var
  X : TCppCodeComp;
begin
  if (Index < 0) or (Index >= ROPSCodeCompDataSize) then Exit;
  X := ROPSCodeCompData[Index];
  if X.Kind = ckAPIFunc then
    AddCodeCompParamsHelper(aStrings, X.Params, '*none*', ';');
end;

procedure AddCodeCompParamsHelper(aStrings : TStrings; s, empty, sep : string);
var
  i : Integer;
  tmpStr : string;

  procedure AddToList(tmp : string);
  begin
    if Pos(' ', tmp) = 0 then tmp := tmp + ' ';
    tmpStr := tmpStr + '"' + tmp + '",';
  end;

begin
  if s = '' then Exit;
  tmpStr := '';
  // s = (stuff) parameters are separated by sep
  Delete(s, 1, 1); // remove '('
  Delete(s, Length(s), 1); // remove ')'
  // if s is now empty then add the word <empty>
  if s = '' then s := empty;
  i := Pos(sep, s);
  while i > 0 do begin
    AddToList(Copy(s, 1, i-1));
    Delete(s, 1, i+Length(sep)-1);
    i := Pos(sep, s);
  end;
  // add last item to parameter list
  AddToList(s);
  // add one item only with the format: "param1","param2","param3"
  Delete(tmpStr, Length(tmpStr), 1);
  aStrings.Add(tmpStr);
end;

procedure AddCppCodeCompParams(aStrings : TStrings; Index : integer);
var
  X : TCppCodeComp;
begin
  if (Index < 0) or (Index >= CppCodeCompDataSize) then Exit;
  X := CppCodeCompData[Index];
  if X.Kind = ckAPIFunc then
    AddCodeCompParamsHelper(aStrings, X.Params, 'void', ',');
end;

procedure AddPasCodeCompParams(aStrings : TStrings; Index : integer);
var
  X : TCppCodeComp;
begin
  if (Index < 0) or (Index >= PasCodeCompDataSize) then Exit;
  X := PasCodeCompData[Index];
  if X.Kind = ckAPIFunc then
    AddCodeCompParamsHelper(aStrings, X.Params, '*none*', ';');
end;

function MSCodeCompIndex(aName : string) : Integer;
begin
  Result := -1;
end;

procedure AddMSCodeCompParams(aStrings : TStrings; Index : integer);
begin
  aStrings.Clear;
end;

initialization
  theCppNameList := TStringList.Create;
  theCppNameList.Sorted := True;
  thePasNameList := TStringList.Create;
  thePasNameList.Sorted := True;
  theROPSNameList := TStringList.Create;
  theROPSNameList.Sorted := True;

finalization
  theCppNameList.Free;
  thePasNameList.Free;
  theROPSNameList.Free;

end.
