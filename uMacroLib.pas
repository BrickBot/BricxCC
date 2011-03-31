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
unit uMacroLib;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, ActnList, SynMacroRecorder, SynEdit;

type
  TMacroItem = class(TCollectionItem)
  private
    fAction : TCustomAction;
    FName: string;
    FTimeStamp: TDateTime;
    FCode: TStrings;
    FDescription: string;
    procedure SetCode(const Value: TStrings);
    procedure SetName(const Value: string);
    procedure SetTimeStamp(const Value: TDateTime);
    procedure SetDescription(const Value: string);
    procedure SetShortCut(const Value: TShortCut);
    function  GetShortCut: TShortCut;
    procedure HandleActionExecute(Sender: TObject);
  public
    constructor Create(aCollection: TCollection); override;
    destructor Destroy; override;
    property Name : string read FName write SetName;
    property Description : string read FDescription write SetDescription;
    property TimeStamp : TDateTime read FTimeStamp write SetTimeStamp;
    property Code : TStrings read FCode write SetCode;
    property ShortCut : TShortCut read GetShortCut write SetShortCut;
  end;

  TMacroLibrary = class(TCollection)
  private
    fActList : TCustomActionList;
    fRecording : Boolean;
    FMacroRecorder: TSynMacroRecorder;
    fChainStateChanged : TNotifyEvent;
    FSuspended: Boolean;
    fOwner : TComponent;
    FActiveEditor: TCustomSynEdit;
    FOnMacroAdded: TNotifyEvent;
    procedure HandleMacroRecStateChange(Sender: TObject);
    procedure SetMacroRecorder(const Value: TSynMacroRecorder);
    procedure DoFinishedMacroRecording; virtual;
    procedure DoOnMacroAdded; virtual;
    procedure SetRecording(const Value: Boolean); virtual;
    procedure SetSuspended(const Value: Boolean); virtual;
    procedure SetActiveEditor(const Value: TCustomSynEdit);
    function GetItem(Index: Integer): TMacroItem;
    procedure SetItem(Index: Integer; const Value: TMacroItem);
  protected
    procedure InternalPlaybackMacro(aIndex : Integer);
    property Recording : Boolean read fRecording write SetRecording;
  public
    constructor Create(aOwner : TComponent);
    function Add: TMacroItem;
    procedure SaveToFile(aFilename : string);
    procedure LoadFromFile(aFilename : string);
    procedure SaveToStream(aStream : TStream); virtual;
    procedure LoadFromStream(aStream : TStream); virtual;
    procedure Suspend;
    procedure Resume;
    procedure Playback(aIndex : Integer);
    function Insert(Index: Integer): TMacroItem;
    property Items[Index: Integer]: TMacroItem read GetItem write SetItem;
    property ActiveEditor : TCustomSynEdit read FActiveEditor write SetActiveEditor;
    property MacroRecorder : TSynMacroRecorder read FMacroRecorder write SetMacroRecorder;
    property Suspended : Boolean read FSuspended write SetSuspended;
    property OnMacroAdded : TNotifyEvent read FOnMacroAdded write FOnMacroAdded;
  end;

implementation

uses
  SysUtils, uLocalizedStrings;

{ TMacroItem }

constructor TMacroItem.Create(aCollection: TCollection);
begin
  if not (aCollection is TMacroLibrary) then
    raise Exception.Create('Macro Items can only be contained in a Macro Library container');
  inherited Create(aCollection);
  FName        := Format('Macro%d', [aCollection.Count]);
  FDescription := '';
  FTimeStamp   := Now;
  FCode        := TStringList.Create;
  fAction      := TCustomAction.Create(nil);
  fAction.OnExecute  := HandleActionExecute;
  fAction.ActionList := TMacroLibrary(aCollection).fActList;
end;

destructor TMacroItem.Destroy;
begin
  FCode.Free;
  fAction.Free;
  inherited;
end;

function TMacroItem.GetShortCut: TShortCut;
begin
  Result := fAction.ShortCut;
end;

procedure TMacroItem.HandleActionExecute(Sender: TObject);
begin
  TMacroLibrary(Collection).InternalPlaybackMacro(Index);
end;

procedure TMacroItem.SetCode(const Value: TStrings);
begin
  FCode.Assign(Value);
end;

procedure TMacroItem.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

procedure TMacroItem.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TMacroItem.SetShortCut(const Value: TShortCut);
begin
  fAction.ShortCut := Value;
end;

procedure TMacroItem.SetTimeStamp(const Value: TDateTime);
begin
  FTimeStamp := Value;
end;

{ TMacroLibrary }

constructor TMacroLibrary.Create(aOwner : TComponent);
begin
  inherited Create(TMacroItem);
  FMacroRecorder := nil;
  FActiveEditor  := nil;
  fOwner     := aOwner;
  fRecording := False;
  FSuspended := False;
  fActList   := TCustomActionList.Create(aOwner);
end;

procedure TMacroLibrary.DoFinishedMacroRecording;
var
  MI : TMacroItem;
begin
  if Suspended then Exit;
  // add a macro item
  MI := TMacroItem(Add);
  if Assigned(MacroRecorder) then
  begin
    MacroRecorder.MacroName := MI.Name;
    MI.Code.Text := MacroRecorder.AsString;
  end;
  DoOnMacroAdded;
end;

procedure TMacroLibrary.HandleMacroRecStateChange(Sender: TObject);
begin
  // do the regular event first
  if Assigned(fChainStateChanged) then
    fChainStateChanged(Sender);
  // now handle the event ourself
  if Sender is TSynMacroRecorder then
  begin
    case TSynMacroRecorder(Sender).State of
      msRecording :
        Recording := True;
    else
      Recording := False;
    end;
  end;
end;

procedure TMacroLibrary.LoadFromFile(aFilename: string);
var
  FS : TFileStream;
begin
  FS := TFileStream.Create(aFilename, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(FS);
  finally
    FS.Free;
  end;
end;

procedure TMacroLibrary.LoadFromStream(aStream: TStream);

  function ReadString : string;
  var
    Buf : PChar;
    Len : Integer;
  begin
    aStream.Read(Len, sizeof(Len));
    GetMem(Buf, Len+1);
    try
      FillChar(Buf^, Len+1, 0);
      aStream.Read(Buf^, Len);
      Result := Buf;
    finally
      FreeMem(Buf);
    end;
  end;

var
  SMR : TSynMacroRecorder;
  cnt, i : Integer;
  MI : TMacroItem;
  sName, sDescr : string;
  dTS : TDateTime;
  SC : TShortCut;
begin
  Clear;
  try
    aStream.Read(cnt, sizeof(cnt));
    if cnt > 0 then
    begin
      SMR := TSynMacroRecorder.Create(nil);
      try
        i := 0;
        while (aStream.Position < aStream.Size) and (i < cnt) do
        begin
          sName := ReadString;
          sDescr := ReadString;
          aStream.Read(dTS, sizeof(TDateTime));
          aStream.Read(SC, sizeof(TShortCut));
          SMR.LoadFromStream(aStream);
          SMR.MacroName := sName;

          MI := TMacroItem(Add);
          MI.Name        := sName;
          MI.Description := sDescr;
          MI.TimeStamp   := dTS;
          MI.ShortCut    := SC;
          MI.Code.Text   := SMR.AsString;
        end;
      finally
        SMR.Free;
      end;
    end;
  except
    raise Exception.Create(sMacroLibFormatError);
  end;
end;

procedure TMacroLibrary.SaveToFile(aFilename: string);
var
  FS : TFileStream;
begin
  FS := TFileStream.Create(aFilename, fmCreate);
  try
    SaveToStream(FS);
  finally
    FS.Free;
  end;
end;

procedure TMacroLibrary.SaveToStream(aStream: TStream);

  procedure WriteString(aStr : string);
  var
    Len : Integer;
  begin
    Len := Length(aStr);
    aStream.Write(Len, sizeof(Len));
    aStream.Write(PChar(aStr)^, Len);
  end;

var
  SMR : TSynMacroRecorder;
  cnt, i : Integer;
  MI : TMacroItem;
  SC : TShortCut;
begin
  cnt := Count;
  if cnt > 0 then
  begin
    aStream.Write(cnt, sizeof(cnt));
    SMR := TSynMacroRecorder.Create(nil);
    try
      for i := 0 to cnt - 1 do
      begin
        MI := Items[i];
        SMR.MacroName := MI.Name;
        SMR.AsString  := MI.Code.Text;
        WriteString(MI.Name);
        WriteString(MI.Description);
        aStream.Write(MI.TimeStamp, sizeof(TDateTime));
        SC := MI.ShortCut;
        aStream.Write(SC, sizeof(TShortCut));
        SMR.SaveToStream(aStream);
      end;
    finally
      SMR.Free;
    end;
  end;
end;

procedure TMacroLibrary.SetMacroRecorder(const Value: TSynMacroRecorder);
begin
  if Value <> FMacroRecorder then
  begin
    if Assigned(FMacroRecorder) then
    begin
      // put back the chained event handler because we are switching macro recorders
      FMacroRecorder.OnStateChange := fChainStateChanged;
    end;
    fChainStateChanged := nil;
    if Assigned(Value) then
    begin
      // get the event handler to chain
      fChainStateChanged := Value.OnStateChange;
      // hook to our event handler instead
      Value.OnStateChange := HandleMacroRecStateChange;
    end;
    FMacroRecorder := Value;
  end;
end;

procedure TMacroLibrary.SetSuspended(const Value: Boolean);
begin
  FSuspended := Value;
end;

procedure TMacroLibrary.SetRecording(const Value: Boolean);
begin
  if Value = fRecording then Exit;
  if fRecording then
    DoFinishedMacroRecording;
  fRecording := Value;
end;

procedure TMacroLibrary.Resume;
begin
  Suspended := False;
end;

procedure TMacroLibrary.Suspend;
begin
  Suspended := True;
end;

procedure TMacroLibrary.InternalPlaybackMacro(aIndex: Integer);
var
  MI : TMacroItem;
begin
  if Assigned(MacroRecorder) and Assigned(ActiveEditor) then
  begin
    MI := Items[aIndex];
    MacroRecorder.MacroName := MI.Name;
    MacroRecorder.AsString  := MI.Code.Text;
    MacroRecorder.PlaybackMacro(ActiveEditor);
  end;
end;

procedure TMacroLibrary.SetActiveEditor(const Value: TCustomSynEdit);
begin
  FActiveEditor := Value;
end;

function TMacroLibrary.GetItem(Index: Integer): TMacroItem;
begin
  Result := TMacroItem(inherited GetItem(Index));
end;

procedure TMacroLibrary.SetItem(Index: Integer; const Value: TMacroItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TMacroLibrary.Playback(aIndex: Integer);
begin
  InternalPlaybackMacro(aIndex);
end;

procedure TMacroLibrary.DoOnMacroAdded;
begin
  if Assigned(FOnMacroAdded) then
    FOnMacroAdded(Self);
end;

function TMacroLibrary.Add: TMacroItem;
begin
  Result := TMacroItem(inherited Add);
end;

function TMacroLibrary.Insert(Index: Integer): TMacroItem;
begin
  Result := TMacroItem(inherited Insert(Index));
end;

end.
