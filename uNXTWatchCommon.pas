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
 * Portions created by John Hansen are Copyright (C) 2010 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uNXTWatchCommon;

interface

uses
  Classes;

type
  TWatchType = (wtCharacter, wtString, wtDecimal, wtHexadecimal, wtFloatingPoint,
    wtPointer, wtRecord, wtDefault, wtMemoryDump);

  TWatchList = class;

  TWatchInfo = class(TCollectionItem)
  private
    fExpression: string;
    fGroupName: string;
    fEnabled : boolean;
    fAllowFunc : boolean;
    fWatchType : TWatchType;
    fRepeatCount: integer;
    fDigits: integer;
  protected
    fValue : string;
    procedure AssignTo(Dest: TPersistent); override;
    function IsProcessAccessible : boolean;
    function GetValue: string;
    function GetWatchList: TWatchList;
  public
    constructor Create(ACollection: TCollection); override;
    procedure Refresh(bCheckProcess : boolean = false);
    property Expression : string read fExpression write fExpression;
    property GroupName : string read fGroupName write fGroupName;
    property Enabled : boolean read fEnabled write fEnabled;
    property AllowFunctionCalls : boolean read fAllowFunc write fAllowFunc;
    property WatchType : TWatchType read fWatchType write fWatchType;
    property RepeatCount : integer read fRepeatCount write fRepeatCount;
    property Digits : integer read fDigits write fDigits;
    property Value : string read GetValue;
    property WatchList: TWatchList read GetWatchList;
  end;

  TIsProcessAccessibleEvent = procedure(Sender : TObject; var Accessible : boolean) of Object;
  TGetWatchValueEvent = procedure(Info : TWatchInfo; var Value : string) of Object;

  TWatchList = class(TCollection)
  private
    fOnIsProcessAccessible: TIsProcessAccessibleEvent;
    fOnGetWatchValueEvent: TGetWatchValueEvent;
    function GetItem(Index: Integer): TWatchInfo;
    procedure SetItem(Index: Integer; const Value: TWatchInfo);
  protected
    procedure DoIsProcessAccessible(Sender : TObject; var Accessible : boolean);
    procedure DoGetWatchValue(Info : TWatchInfo; var Value : string);
  public
    constructor Create; virtual;
    function  Add: TWatchInfo;
    function  Insert(Index: Integer): TWatchInfo;
    procedure DisableAllWatches;
    procedure EnableAllWatches;
    procedure Refresh;
    function  IndexOf(const groupname, expression : string) : integer;
    property  Items[Index: Integer]: TWatchInfo read GetItem write SetItem; default;
    property  OnIsProcessAccessible : TIsProcessAccessibleEvent read fOnIsProcessAccessible write fOnIsProcessAccessible;
    property  OnGetWatchValue : TGetWatchValueEvent read fOnGetWatchValueEvent write fOnGetWatchValueEvent;
  end;

  function TheWatchList : TWatchList;

const
  DEFAULT_GROUP  = 'Watches';

implementation

uses
  SysUtils, uMiscDefines, uROPS, uGlobals, uProgram, brick_common, uPSRuntime;

var
  fWatchList : TWatchList;

const
  DISABLED_VALUE = '<disabled>';
  NOPROC_VALUE   = '(process not accessible)';

function TheWatchList : TWatchList;
begin
  if not Assigned(fWatchList) then
  begin
    fWatchList := TWatchList.Create;
  end;
  Result := fWatchList;
end;

{ TWatchInfo }

procedure TWatchInfo.AssignTo(Dest: TPersistent);
var
  wi : TWatchInfo;
begin
  if Dest is TWatchInfo then
  begin
    wi := TWatchInfo(Dest);
    wi.GroupName          := GroupName;
    wi.Expression         := Expression;
    wi.Enabled            := Enabled;
    wi.AllowFunctionCalls := AllowFunctionCalls;
    wi.WatchType          := WatchType;
    wi.RepeatCount        := RepeatCount;
    wi.Digits             := Digits;
  end
  else
    inherited;
end;

constructor TWatchInfo.Create(ACollection: TCollection);
begin
  inherited;
  fExpression  := '';
  fGroupName   := DEFAULT_GROUP;
  fRepeatCount := 0;
  fDigits      := 18;
  fWatchType   := wtDefault;
  fEnabled     := False;
  fAllowFunc   := False;
  fValue       := DISABLED_VALUE;
end;

function TWatchInfo.GetValue: string;
begin
  if Enabled then
    Result := fValue
  else
    Result := DISABLED_VALUE;
end;

function TWatchInfo.GetWatchList: TWatchList;
begin
  Result := TWatchList(Collection);
end;

function TWatchInfo.IsProcessAccessible: boolean;
begin
  Result := False;
  WatchList.DoIsProcessAccessible(Self, Result);
end;

procedure TWatchInfo.Refresh(bCheckProcess : boolean);
var
  bCanCalc : boolean;
begin
  if Enabled then
  begin
    // attempt to get the current watch value using the
    // watch type, expression, repeat count, and digits settings
    bCanCalc := True;
    if bCheckProcess then
      bCanCalc := IsProcessAccessible;
    if bCanCalc then
    begin
      fValue := '';
      WatchList.DoGetWatchValue(Self, fValue);
    end
    else
      fValue := NOPROC_VALUE;
  end
  else
    fValue := DISABLED_VALUE;
end;

{ TWatchList }

function TWatchList.Add: TWatchInfo;
begin
  Result := TWatchInfo(inherited Add);
end;

constructor TWatchList.Create;
begin
  inherited Create(TWatchInfo);
end;

procedure TWatchList.DisableAllWatches;
var
  i : integer;
begin
  // disable all watches in our list
  for i := 0 to Count - 1 do
  begin
    Items[i].Enabled := False;
  end;
end;

procedure TWatchList.DoGetWatchValue(Info: TWatchInfo; var Value: string);
var
  i : integer;
begin
  Value := '';
  if Assigned(fOnGetWatchValueEvent) then
    fOnGetWatchValueEvent(Info, Value)
  else
  begin
    if IsNXT then
    begin
      if FileIsROPS then
      begin
        Value := ce.GetVarContents(Info.Expression);
      end
      else if FileIsNBCOrNXC then
      begin
        i := CurrentProgram.Dataspace.IndexOfName(Info.Expression);
        if i <> -1 then
          Value := BrickComm.GetVariableValue(i);
      end;
    end;
  end;
end;

procedure TWatchList.DoIsProcessAccessible(Sender: TObject; var Accessible: boolean);
var
  name : string;
begin
  Accessible := False;
  if Assigned(fOnIsProcessAccessible) then
    fOnIsProcessAccessible(Sender, Accessible)
  else
  begin
    if IsNXT then
    begin
      if FileIsROPS then
      begin
        Accessible := ce.Exec.Status in [isRunning, isPaused];
      end
      else if FileIsNBCOrNXC then
      begin
        if BrickComm.DCGetCurrentProgramName(name) then
        begin
          Accessible := CurrentProgram.Loaded(name);
        end;
      end;
    end;
  end;
end;

procedure TWatchList.EnableAllWatches;
var
  i : integer;
begin
  // enable all watches in our list
  for i := 0 to Count - 1 do
  begin
    Items[i].Enabled := True;
  end;
end;

function TWatchList.GetItem(Index: Integer): TWatchInfo;
begin
  Result := TWatchInfo(inherited GetItem(Index));
end;

function TWatchList.IndexOf(const groupname, expression: string): integer;
var
  i : integer;
  wi : TWatchInfo;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    wi := Items[i];
    if (wi.GroupName = groupname) and (wi.Expression = expression) then
    begin
      Result := i;
      break;
    end;
  end;
end;

function TWatchList.Insert(Index: Integer): TWatchInfo;
begin
  result := TWatchInfo(inherited Insert(Index));
end;

procedure TWatchList.Refresh;
var
  i : integer;
  bProcAccessible : boolean;
  WI : TWatchInfo;
begin
  // refresh all watches in our list
  bProcAccessible := False;
  DoIsProcessAccessible(Self, bProcAccessible);
  for i := 0 to Count - 1 do
  begin
    WI := Items[i];
    if bProcAccessible then
      WI.Refresh(false)
    else
      WI.fValue := NOPROC_VALUE;
  end;
end;

procedure TWatchList.SetItem(Index: Integer; const Value: TWatchInfo);
begin
  inherited SetItem(Index, Value);
end;

initialization
  fWatchList := nil;

finalization
  FreeAndNil(fWatchList);

end.