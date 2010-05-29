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
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uReplace;

interface

uses Classes, uGrepBackend;

// Replace all matches in all files
function ReplaceAll(ResultList: TStrings; GrepSettings: TGrepSettings): Integer;
// Replace all matches in a single file
function ReplaceAllInFiles(FileResult: TFileResult; GrepSettings: TGrepSettings): Integer;
// Replace all matches on a single line
function ReplaceLine(LineResult: TLineResult; GrepSettings: TGrepSettings): Integer;

implementation

uses SysUtils, Controls, Dialogs, uGrepCommonUtils;

type
  ESkipFileReplaceException = class(Exception);

resourcestring
  SFileChangedAbort = '%s' + sLineBreak + 'has changed since it was searched.  Replacement aborted.'
    + sLineBreak + 'Expected: %s' + sLineBreak + 'Found: %s';
  SUnableToOpen  = 'Unable to open ';
  SNoOpenForms   = 'Replacing strings in open forms is not possible.  Please close the form first.';
  SFileSkipped   = 'The following file will be skipped:';

// Replaces the string between SPos and EPos with the replace string from TGrepSettings
function ReplacePatternInString(CurrentLine: TLineResult; GrepSettings: TGrepSettings): string;
var
  i: Integer;
  FindPos: Integer;
  FindLen: Integer;
  CurrentMatch: TMatchResult;
begin
  Result := CurrentLine.Line;
  for i := CurrentLine.Matches.Count - 1 downto 0 do
  begin
    CurrentMatch := CurrentLine.Matches.Items[i];
    FindPos := CurrentMatch.SPos;
    FindLen := CurrentMatch.EPos - CurrentMatch.SPos + 1;
    Delete(Result, FindPos, FindLen);
    Insert(GrepSettings.Replace, Result, FindPos);
    CurrentMatch.ShowBold := False;
  end;
end;

function ReplaceAll(ResultList: TStrings; GrepSettings: TGrepSettings): Integer;
var
  i: Integer;
  Replaced: Integer;
begin
  Result := 0;
  for i := 0 to ResultList.Count - 1 do
  begin
    if ResultList.Objects[i] is TFileResult then
     begin
       Replaced := ReplaceAllInFiles(ResultList.Objects[i] as TFileResult, GrepSettings);
       Inc(Result, Replaced);
     end;
  end;
end;

function InternalReplace(LineMode: Boolean; ALineResult: TLineResult; AFileResult: TFileResult; GrepSettings: TGrepSettings): Integer;
var
  TempString: string;
  MatchFile: string;
  TempFile: TStringList;
  LineResult : TLineResult;

  procedure GetFileLines;
  begin
    LoadDiskFileToStrings(MatchFile, TempFile);
  end;

  procedure DoReplacement;
  var
    i: Integer;
    FileLine: string;
  begin
    if LineMode then
    begin
      i := ALineResult.LineNo;
      Assert(TempFile.Count >= (LineResult.LineNo - 1));
      FileLine := TempFile.Strings[LineResult.LineNo - 1];
      if LineResult.Line <> FileLine then
        raise Exception.CreateFmt(SFileChangedAbort, [MatchFile, LineResult.Line, FileLine]);

      TempString := ReplacePatternInString(LineResult, GrepSettings);
      TempFile.Strings[i -1] := TempString;
      Inc(Result, LineResult.Matches.Count);
    end
    else
    begin
      for i := AFileResult.Count - 1 downto 0 do
      begin
        LineResult := AFileResult.Items[i];
        Inc(Result, LineResult.Matches.Count);
        Assert(TempFile.Count >= (LineResult.LineNo - 1));
        FileLine := TempFile.Strings[LineResult.LineNo - 1];
        if LineResult.Line <> FileLine then
          raise Exception.CreateFmt(SFileChangedAbort, [MatchFile, LineResult.Line, FileLine]);

        TempString := ReplacePatternInString(LineResult, GrepSettings);
        TempFile.Strings[LineResult.LineNo - 1] := TempString;
      end;
    end;
  end;

  procedure WriteResults;
  begin
    TempFile.SaveToFile(MatchFile);
  end;

begin
  Result := 0;
  if LineMode then
  begin
    LineResult := ALineResult;
    MatchFile := TFileResult(LineResult.Collection).FileName;
  end
  else
    MatchFile := AFileResult.FileName;

  TempFile := TStringList.Create;
  try
    try
      GetFileLines;
    except on E: ESkipFileReplaceException do
      begin
        E.Message := E.Message + sLineBreak + SFileSkipped +sLineBreak+ MatchFile;
        if MessageDlg(E.Message, mtWarning, [mbOK, mbCancel], 0) = mrCancel then
          Abort
        else
          Exit;
      end;
    end;
    DoReplacement;
    WriteResults;
  finally
    FreeAndNil(TempFile);
  end;
end;

function ReplaceAllInFiles(FileResult: TFileResult; GrepSettings: TGrepSettings): Integer;
begin
  Result := InternalReplace(False, nil, FileResult, GrepSettings);
end;

function ReplaceLine(LineResult: TLineResult; GrepSettings: TGrepSettings): Integer;
begin
  Result := InternalReplace(True, LineResult, nil, GrepSettings);
end;

end.

