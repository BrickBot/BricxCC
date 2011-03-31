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
unit GX_IDECodeTemplates;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes;

type
  TIDECodeTemplateList = class;
  TIDECodeTemplate = class
  private
    FOwner : TIDECodeTemplateList;
    FDescription: String;
    FName: String;
    FCode: TStrings;
    procedure SetCode(const Value: TStrings);
    procedure SetDescription(const Value: String);
    procedure SetName(const Value: String);
  public
    constructor Create(aOwner : TIDECodeTemplateList); virtual;
    destructor  Destroy; override;
    property Name : String read FName write SetName;
    property Description : String read FDescription write SetDescription;
    property Code : TStrings read FCode write SetCode;
  end;

  TIDECodeTemplateList = class
  private
    FList : TList;
    fStrings : TStrings;
    function  GetTemplates(aIndex: integer): TIDECodeTemplate;
    function  GetStrings: TStrings;
    procedure SetStrings(const Value: TStrings);
  public
    constructor Create; virtual;
    destructor  Destroy; override;
    procedure ClearTemplates;
    function  Add : TIDECodeTemplate;
    function  Count : integer;
    function  IndexOf(const aName : string) : integer;
    procedure LoadFromFile(const aFilename : string);
    procedure SaveToFile(const aFilename : string);
    procedure Sort;
    procedure Delete(aIndex : integer);
    property  Templates[aIndex : integer] : TIDECodeTemplate read GetTemplates;
    property  AsStrings : TStrings read GetStrings write SetStrings;
  end;

implementation

uses
  SysUtils;

function CompareTemplatesByName(Item1, Item2: Pointer): Integer;
begin
  Result := AnsiCompareText(TIDECodeTemplate(Item1).Name,
                            TIDECodeTemplate(Item2).Name);
end;

{ TIDECodeTemplate }

constructor TIDECodeTemplate.Create(aOwner : TIDECodeTemplateList);
begin
  inherited Create;
  FOwner := aOwner;
  FCode := TStringList.Create;
  FOwner.FList.Add(self);
end;

destructor TIDECodeTemplate.Destroy;
begin
  FCode.Free;
  inherited Destroy;
end;

procedure TIDECodeTemplate.SetCode(const Value: TStrings);
begin
  FCode.Assign(Value);
end;

procedure TIDECodeTemplate.SetDescription(const Value: String);
begin
  FDescription := Value;
end;

procedure TIDECodeTemplate.SetName(const Value: String);
begin
  FName := Value;
end;

{ TIDECodeTemplateList }

function TIDECodeTemplateList.Add: TIDECodeTemplate;
begin
  result := TIDECodeTemplate.Create(self);
end;

procedure TIDECodeTemplateList.ClearTemplates;
var
  i : integer;
begin
  for i := 0 to FList.Count - 1 do
  begin
    TIDECodeTemplate(FList[i]).Free;
  end;
  FList.Clear;
end;

function TIDECodeTemplateList.Count: integer;
begin
  result := FList.Count;
end;

constructor TIDECodeTemplateList.Create;
begin
  inherited Create;
  FList := TList.Create;
  FStrings := TStringList.Create;
end;

procedure TIDECodeTemplateList.Delete(aIndex: integer);
begin
  TIDECodeTemplate(FList[aIndex]).Free;
  FList.Delete(aIndex);
end;

destructor TIDECodeTemplateList.Destroy;
begin
  FStrings.Free;
  ClearTemplates;
  inherited Destroy;
end;

function TIDECodeTemplateList.GetStrings: TStrings;
var
  i, j : integer;
  ICT : TIDECodeTemplate;
begin
  FStrings.Clear;
  for i := 0 to Count - 1 do
  begin
    ICT := Templates[i];
    FStrings.Add('[' + ICT.Name + ' | ' + ICT.Description + ']');
    for j := 0 to ICT.Code.Count - 1 do
    begin
      FStrings.Add(ICT.Code[j]);
    end;
    FStrings.Add('');
  end;
  Result := FStrings;
end;

function TIDECodeTemplateList.GetTemplates(aIndex: integer): TIDECodeTemplate;
begin
  result := TIDECodeTemplate(FList[aIndex]);
end;

function TIDECodeTemplateList.IndexOf(const aName: string): integer;
var
  i : integer;
begin
  result := -1;
  for i := 0 to Count - 1 do
  begin
    if AnsiCompareText(aName, Templates[i].Name) = 0 then
    begin
      result := i;
      break;
    end;
  end;
end;

procedure TIDECodeTemplateList.LoadFromFile(const aFilename: string);
var
  tmpSL : TStringList;
begin
  tmpSL := TStringList.Create;
  try
    tmpSL.LoadFromFile(aFilename);
    SetStrings(tmpSL);
  finally
    tmpSL.Free;
  end;
end;

procedure TIDECodeTemplateList.SaveToFile(const aFilename: string);
begin
  Self.AsStrings.SaveToFile(aFilename);
end;

procedure TIDECodeTemplateList.SetStrings(const Value: TStrings);
var
  i : integer;
  ICT : TIDECodeTemplate;
  tmpStr, tmpDesc : string;
begin
  ClearTemplates;
  if not Assigned(Value) then Exit;
  // now create our templates from this file
  i := 0;
  ICT := nil;
  while i < Value.Count do
  begin
    tmpStr := Value[i];
    // we've found a template if the line starts with '['
    if Pos('[', tmpStr) = 1 then
    begin
      // we've found the next template so add one to our list
      // before we do that delete the blank line (if there is one) from
      // the previous template
      if assigned(ICT) then
      begin
        if ICT.Code[ICT.Code.Count-1] = '' then
          ICT.Code.Delete(ICT.Code.Count-1);
      end;
      ICT := Self.Add;
      ICT.Name := Trim(Copy(tmpStr, 2, Pos('|', tmpStr)-2));
      tmpDesc  := Trim(Copy(tmpStr, Pos('|', tmpStr)+1, Length(tmpStr)));
      System.Delete(tmpDesc, Length(tmpDesc), 1);
      ICT.Description := tmpDesc;
      inc(i);
    end;
    tmpStr := Value[i];
    if assigned(ICT) then
    begin
      ICT.Code.Add(tmpStr);
    end;
    inc(i);
  end;
end;

procedure TIDECodeTemplateList.Sort;
begin
  FList.Sort(CompareTemplatesByName);
end;

end.
