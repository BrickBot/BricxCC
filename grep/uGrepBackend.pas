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
 * Portions of this code are covered under the GExperts license
 * http://www.gexperts.org/license.html
 *
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uGrepBackend;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes,
  uGrepRegExSearch;

type
  TGrepAction = (gaCurrentOnlyGrep, gaOpenFilesGrep, gaDirGrep, gaResults);

  // Saved grep settings (used for refresh)
  TGrepSettings = record
    IncludeComments: Boolean;
    CaseSensitive: Boolean;
    WholeWord: Boolean;
    RegEx: Boolean;
    IncludeSubdirs: Boolean;
    Directories: string;
    Mask: string;
    Pattern: string;
    Replace: string;
    GrepAction: TGrepAction;
    CanRefresh: Boolean;
  end;

type
  // Individual grep match in a line
  TMatchResult = class(TCollectionItem)
  private
    FSPos: Integer;
    FEPos: Integer;
    FShowBold: Boolean;
  public
    property SPos: Integer read FSPos write FSPos;
    property EPos: Integer read FEPos write FEPos;
    property ShowBold: Boolean read FShowBold write FShowBold;
    constructor Create(aCollection: TCollection); override;
    function Length: Integer;
  end;

  // Collection of TMatchResult
  // Collection of all matches in a line
  TLineMatches = class(TCollection)
  private
    function GetItem(Index: Integer): TMatchResult;
    procedure SetItem(Index: Integer; Value: TMatchResult);
  public
    constructor Create;
    function Add: TMatchResult;
    property Items[Index: Integer]: TMatchResult read GetItem write SetItem; default;
  end;

  // A single line that has a match from a file
  // One collection item per line with any number of matches
  TLineResult = class(TCollectionItem)
  private
    FLine: string;
    FLineNo: Integer; // 1-based
    FMatches: TLineMatches;
  public
    constructor Create(aCollection: TCollection); override;
    destructor Destroy; override;
    function Add: TMatchResult;
  public
    property Line: string read FLine write FLine;
    property LineNo: Integer read FLineNo write FLineNo; // 1-based
    // Collection of all matches in a line
    property Matches: TLineMatches read FMatches;
  end;

  TMatchArray = array of TMatchResult;

  // Contains collection of all lines in a single source file that match.
  TFileResult = class(TCollection)
  private
    FExpanded: Boolean;
    FFileName: string;
    FRelativeFileName: string;
    FLastLineResult: Integer; // Last LineNo added to result set
    FLastIndex: Integer;      // Index of last added result
    FTotalMatches: Integer;   // Total matches in file
    function GetItem(Index: Integer): TLineResult;
    procedure SetItem(Index: Integer; Value: TLineResult);
  public
    constructor Create;
    function Add: TLineResult;
    procedure GetMatchesOnLine(Line: Integer; var Matches: TMatchArray);
    property Expanded: Boolean read FExpanded write FExpanded;
    property FileName: string read FFileName write FFileName;
    property RelativeFileName: string read FRelativeFileName write FRelativeFileName;
    property LastIndex: Integer read FLastIndex write FLastIndex;
    property LastLineResult: Integer read FLastLineResult write FLastLineResult;
    property Items[Index: Integer]: TLineResult read GetItem write SetItem; default;
    property TotalMatches: Integer read FTotalMatches write FTotalMatches;
  end;

type
  TOnHitMatch = procedure(Sender: TObject; LineNo: Integer; const Line: string;
      SPos, EPos: Integer) of object;
  TOnSearchFile = procedure(Sender: TObject; const FileName: string) of object;

  TGrepSearchRunner = class(TObject)
  private
    FOnHitMatch: TOnHitMatch;
    FOnSearchFile: TOnSearchFile;
    FStorageTarget: TStrings;
    FDupeFileList: TStringList;
    FAbortSignalled: Boolean;
    FFileSearchCount: Integer;
    FMatchCount: Integer;
    FFileResult: TFileResult;
    FSearcher: TSearcher;
    FSearchRoot: string;
    FFilesInResults : TStrings;
    procedure FoundIt(LineNo, StartCol, EndCol: Integer; const Line: string);
    procedure StartFileSearch(const FileName: string);
    procedure ExecuteSearchOnFile(const FileName: string; FromProject: Boolean = False);
  private
    FGrepSettings: TGrepSettings;
//    procedure GrepProjectFile(const FileName: string);
  protected
    procedure DoHitMatch(LineNo: Integer; const Line: string;
      SPos, EPos: Integer); virtual;
    procedure GrepCurrentSourceEditor;
    procedure GrepOpenFiles;
    procedure GrepDirectory(Dir, Mask: string);
    procedure GrepDirectories(const Dir, Mask: string);
    procedure GrepResults;
  public
    constructor Create(const Settings: TGrepSettings; StorageTarget, FilesInResults: TStrings);
    procedure Execute;
    property OnSearchFile: TOnSearchFile read FOnSearchFile write FOnSearchFile;
    property FileSearchCount: Integer read FFileSearchCount;
    property MatchCount: Integer read FMatchCount;
    property AbortSignalled: Boolean read FAbortSignalled write FAbortSignalled;
  end;

implementation

uses
  SysUtils, Forms, Dialogs, Controls, uGrepCommonUtils;

const
  AllFilesWildCard = '*.*';
  
procedure AnsiStrTok(const Source, Delimiter: string; Dest: TStrings);
var
  i: Integer;
  SubString: string;
  Temp: string;
begin
  if (Source = '') or (Delimiter = '') or (Dest = nil) then
    Exit;

  Dest.Clear;
  SubString := Source;
  repeat
    i := AnsiPos(Delimiter, SubString);

    if i = 0 then
      Temp := SubString
    else
      Temp := Copy(SubString, 1, i - 1);

    if Temp <> '' then
      Dest.Add(Temp);

    SubString := Copy(SubString, i + Length(Delimiter), Length(SubString) - i);
  until i = 0;
end;

{ TLineMatches }

constructor TLineMatches.Create;
begin
  inherited Create(TMatchResult);
end;

function TLineMatches.Add: TMatchResult;
begin
  Result := TMatchResult(inherited Add);
end;

function TLineMatches.GetItem(Index: Integer): TMatchResult;
begin
  Result := TMatchResult(inherited GetItem(Index));
end;

procedure TLineMatches.SetItem(Index: Integer; Value: TMatchResult);
begin
  inherited SetItem(Index, Value);
end;

{ TLineResult }

constructor TLineResult.Create(aCollection: TCollection);
begin
  inherited Create(aCollection);
  FMatches := TLineMatches.Create;
end;

destructor TLineResult.Destroy;
begin
  if Assigned(FMatches) then
  begin
    FMatches.Clear;
    FreeAndNil(FMatches);
  end;
  inherited Destroy;
end;

function TLineResult.Add: TMatchResult;
begin
  Result := Matches.Add;
end;

{ TFileResult }

constructor TFileResult.Create;
begin
  inherited Create(TLineResult);
  FLastLineResult := -1;
  FTotalMatches := 0;
end;

function TFileResult.Add: TLineResult;
begin
  Result := TLineResult(inherited Add);
end;

function TFileResult.GetItem(Index: Integer): TLineResult;
begin
  Result := TLineResult(inherited GetItem(Index));
end;

procedure TFileResult.SetItem(Index: Integer; Value: TLineResult);
begin
  inherited SetItem(Index, Value);
end;

procedure TFileResult.GetMatchesOnLine(Line: Integer; var Matches: TMatchArray);
var
  i, j: Integer;
  LineMatches: TLineResult;
  MR: TMatchResult;
begin
  SetLength(Matches, 0);
  for i := 0 to Count - 1 do
  begin
    LineMatches := GetItem(i);
    if LineMatches.FLineNo = Line then
    begin
      for j := 0 to LineMatches.Matches.Count - 1 do
      begin
        SetLength(Matches, Length(Matches) + 1);
        MR := LineMatches.Matches.GetItem(j);
        Matches[Length(Matches) - 1] := MR;
      end;
    end;
  end;
end;

{ TGrepSearchRunner }

constructor TGrepSearchRunner.Create(const Settings: TGrepSettings; StorageTarget, FilesInResults: TStrings);
begin
  inherited Create;

  Assert(Assigned(StorageTarget));
  Assert(Assigned(FilesInResults));
  FStorageTarget := StorageTarget;
  FFilesInResults := FilesInResults;
  FGrepSettings := Settings;
end;

procedure TGrepSearchRunner.GrepDirectories(const Dir, Mask: string);
var
  i: Integer;
  DirList: TStringList;
begin
  DirList := TStringList.Create;
  try
    AnsiStrTok(Dir, ';', DirList);
    for i := 0 to DirList.Count - 1 do
    begin
      if FAbortSignalled then
        Break;
      FSearchRoot := DirList[i];
      GrepDirectory(DirList[i], Mask);
    end;
  finally
    FreeAndNil(DirList);
  end;
end;

resourcestring
  SSpecifiedDirectoryDoesNotExist = 'The search directory %s does not exist';

procedure TGrepSearchRunner.GrepDirectory(Dir, Mask: string);
var
  Search: TSearchRec;
  Result: Integer;
  Masks: TStrings;
  i: Integer;
  SearchFile: string;
begin
  Dir := IncludeTrailingPathDelimiter(Dir);
  if not DirectoryExists(Dir) then
    raise Exception.CreateFmt(SSpecifiedDirectoryDoesNotExist, [Dir]);

  Masks := TStringList.Create;
  try
    for i := 1 to Length(Mask) do
      if Mask[i] in [';', ','] then
        Mask[i] := #13;

    Masks.Text := Mask;

    if FGrepSettings.IncludeSubdirs then
    begin
      Result := FindFirst(Dir + AllFilesWildCard, faAnyFile, Search);
      try
        while Result = 0 do
        begin
          if (Search.Attr and faDirectory) <> 0 then
          begin
            if (Search.Name <> '.') and (Search.Name <> '..') then
              GrepDirectory(Dir + Search.Name, Mask);
          end;
          if FAbortSignalled then
            Exit;
          Result := FindNext(Search);
        end;
      finally
        FindClose(Search);
      end;
    end;

    for i := 0 to Masks.Count-1 do
    begin
      if FAbortSignalled then
        Break;

      Result := FindFirst(Dir + Trim(Masks.Strings[i]), faAnyFile, Search);
      try
        while Result = 0 do
        begin
          if (Search.Attr and faDirectory) <> 0 then
            Result := FindNext(Search)
          else
          begin
            Assert(FFileResult = nil, 'FFileResult leak');
            FFileResult := nil;

            SearchFile := Dir + Search.Name;
            ExecuteSearchOnFile(SearchFile);
            FFileResult := nil;

            if FAbortSignalled then
              Break;

            Result := FindNext(Search);
          end;
        end;
      finally
        FindClose(Search);
      end;
    end;
  finally
    FreeAndNil(Masks);
  end;
end;

resourcestring
  SNoFileOpen = 'No file is currently open';

procedure TGrepSearchRunner.GrepCurrentSourceEditor;
var
  CurrentFile: string;
begin
  CurrentFile := GxOtaGetFileNameOfCurrentModule;

  Assert(FFileResult = nil, 'FFileResult leak');
  FFileResult := nil;

  FSearchRoot := ExtractFilePath(CurrentFile);
  if NotEmpty(CurrentFile) then
    ExecuteSearchOnFile(CurrentFile)
  else
    raise Exception.Create(SNoFileOpen);
end;

procedure TGrepSearchRunner.GrepResults;
var
  i: Integer;
begin
  for i := 0 to FFilesInResults.Count - 1 do
  begin
    if FileExists(FFilesInResults[i]) then
    begin
      ExecuteSearchOnFile(FFilesInResults[i]);
    end;
  end;
end;

procedure TGrepSearchRunner.GrepOpenFiles;
var
  i: Integer;
  SL : TStringList;
begin
  SL := TStringList.Create;
  try
    SL.CommaText := GxOtaGetOpenFilenames;
    for i := 0 to SL.Count - 1 do
    begin
      if FileExists(SL[i]) then
      begin
        ExecuteSearchOnFile(SL[i]);
      end;
    end;
  finally
    FreeAndNil(SL);
  end;
end;

procedure TGrepSearchRunner.Execute;
begin
  FFileSearchCount := 0;
  FMatchCount := 0;

  // empty the list of files unless we are searching the results
  if FGrepSettings.GrepAction <> gaResults then
    FStorageTarget.Clear;

  FSearcher := TSearcher.Create;
  try
    FSearcher.OnFound := FoundIt;
    //FSearcher.NoComments := FGrepSettings.NoComments;
    //FSearcher.IncludeForms := FGrepSettings.IncludeForms;
    FSearcher.CaseSensitive := FGrepSettings.CaseSensitive;
    FSearcher.WholeWord := FGrepSettings.WholeWord;
    FSearcher.RegularExpression := FGrepSettings.RegEx;
    FSearcher.Pattern := FGrepSettings.Pattern;

    FDupeFileList := TStringList.Create;
    try
      FDupeFileList.Sorted := True;
      case FGrepSettings.GrepAction of
        gaCurrentOnlyGrep:
          GrepCurrentSourceEditor;
        gaOpenFilesGrep:
          GrepOpenFiles;
        gaDirGrep:
          begin
            if Length(Trim(FGrepSettings.Mask)) = 0 then
            begin
              GrepDirectories(FGrepSettings.Directories, '*.nxc;*.h')
            end
            else
              GrepDirectories(FGrepSettings.Directories, AnsiUpperCase(FGrepSettings.Mask));
          end;
        gaResults:
          GrepResults;
      end;	// end case
    finally
      FreeAndNil(FDupeFileList);
    end;

  finally
    FreeAndNil(FSearcher);
  end;
end;

procedure TGrepSearchRunner.ExecuteSearchOnFile(const FileName: string; FromProject: Boolean);
begin
  Assert(Assigned(FDupeFileList));
  if FDupeFileList.IndexOf(FileName) = -1 then
  begin
    StartFileSearch(FileName);
    try
      FSearcher.FileName := FileName;
      FDupeFileList.Add(FileName);
      FSearcher.Execute;
    except
      on E: Exception do
      begin
        if MessageDlg(E.Message, mtError, [mbOK, mbCancel], 0) = mrCancel then
          Abort;
      end;
    end;
  end;
end;

procedure TGrepSearchRunner.FoundIt(LineNo, StartCol, EndCol: Integer; const Line: string);
var
  ALineResult: TLineResult;
  AMatchResult: TMatchResult;
begin
  Inc(FMatchCount);

  // If this is the first match or the match is on a
  // different file then add a new TFileResult.
  if (FFileResult = nil) or (FFileResult.FileName <> FSearcher.FileName) then
  begin
    FFileResult := TFileResult.Create;
    FFileResult.FileName := FSearcher.FileName;
    FFileResult.RelativeFileName := StringReplace(FSearcher.FileName, FSearchRoot, '', [rfIgnoreCase]);
    FStorageTarget.AddObject(FSearcher.FileName, FFileResult);
  end;

  // If the match is not on the same line number as the
  // last match then add another TLineResult to the file's
  // result set.
  if FFileResult.LastLineResult <> LineNo then
  begin
    ALineResult := FFileResult.Add;
    ALineResult.Line := Line;
    ALineResult.LineNo := LineNo;

    // Save Index number and line number for next match
    FFileResult.LastIndex := FFileResult.Count-1;
    FFileResult.LastLineResult := LineNo;
  end
  else
  begin
    // If the match is on the same line then add the
    // match to the previous match line
    ALineResult := FFileResult[FFileResult.LastIndex];
  end;

  AMatchResult := ALineResult.Add;
  AMatchResult.SPos := StartCol;
  AMatchResult.EPos := EndCol;
  FFileResult.TotalMatches := FFileResult.TotalMatches + 1;
end;

procedure TGrepSearchRunner.StartFileSearch(const FileName: string);
begin
  Inc(FFileSearchCount);
  if Assigned(FOnSearchFile) then
    FOnSearchFile(Self, FileName);
end;

procedure TGrepSearchRunner.DoHitMatch(LineNo: Integer; const Line: string;
  SPos, EPos: Integer);
begin
  if Assigned(FOnHitMatch) then
    FOnHitMatch(Self, LineNo, Line, SPos, EPos);
end;

{ TMatchResult }

constructor TMatchResult.Create(aCollection: TCollection);
begin
  inherited;
  ShowBold := True;
end;

function TMatchResult.Length: Integer;
begin
  Result := EPos - SPos + 1;
end;

end.