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
unit BricxccSynEdit;

interface

uses
{$IFNDEF FPC}
  Windows,
{$ELSE}
  Types,
{$ENDIF}
  SynEditEx, SynEditTypes;

type

  { TBricxccSynEdit }

  TBricxccSynEdit = class(TSynEditEx)
  private
  protected
  public
    function DelimitedEnd(DelimChars: TSynIdentChars): TPoint;
    function DelimitedStart(DelimChars: TSynIdentChars): TPoint;
    function DelimitedStartEx(XY: TPoint; DelimChars: TSynIdentChars): TPoint;
    function DelimitedEndEx(XY: TPoint; DelimChars: TSynIdentChars): TPoint;
    procedure SelectDelimited(const aStartDelim : string = '"'; const AStopDelim: string = '"');
    procedure GotoLineNumber(aLine : Integer);
    function FindString(const ASearch : string; bIgnoreComments : Boolean; bBackward : Boolean) : TPoint;
    function TextAtCursor : string;
    function TextWithinDelimiters(DelimChars : TSynIdentChars) : string;
    procedure ToggleBookMark(BookMark: Integer);
    procedure SetCaretAndSel(const ptCaret, ptBefore, ptAfter: TPoint);
  end;

implementation

uses
  Classes, SynEditSearch, SynEdit, SynEditMiscProcs, Math;

function TBricxccSynEdit.FindString(const ASearch: string; bIgnoreComments,
  bBackward: Boolean): TPoint;
var
  ptStart, ptEnd: TPoint; // start and end of the search range
  ptCurrent: TPoint; // current search position
  n, nInLine, nSearchLen: integer;
  fTSearch: TSynEditSearch;

  function InValidSearchRange(First, Last: integer): boolean;
  begin
    Result := TRUE;
    case SelectionMode of
      smNormal:
        if ((ptCurrent.Y = ptStart.Y) and (First < ptStart.X)) or
          ((ptCurrent.Y = ptEnd.Y) and (Last > ptEnd.X)) then Result := FALSE;
      smColumn:                                                                 //EK 10/16/01
        // solves bug in search/replace when smColumn mode active and no selection
        Result := (First >= ptStart.X) and (Last <= ptEnd.X) or (ptEnd.X-ptStart.X<1); //jcr 2002-04-13 This needs to be <1 not <2
    end;
  end;

begin
  fTSearch := TSynEditSearch.Create{$IFNDEF FPC}(nil){$ENDIF};
  try
    Result := Point(0, 0);
    // can't search for an empty string
    nSearchLen := Length(ASearch);
    if nSearchLen = 0 then exit;
    // get the text range to search in, ignore the "Search in selection only"
    // option if nothing is selected
    ptStart := Point(1, 1);
    ptEnd.Y := Lines.Count;
    ptEnd.X := Length(Lines[ptEnd.Y - 1]) + 1;
    if bBackward then ptEnd := CaretXY else ptStart := CaretXY;
    if bBackward then ptCurrent := ptEnd else ptCurrent := ptStart;
    // initialize the search engine
    fTSearch.Sensitive := True;
    fTSearch.Whole := False;
    fTSearch.Pattern := ASearch;
    while (ptCurrent.Y >= ptStart.Y) and (ptCurrent.Y <= ptEnd.Y) do begin
      nInLine := fTSearch.FindAll(Lines[ptCurrent.Y - 1]);
      if bBackward then n := Pred(fTSearch.ResultCount) else n := 0;
      if nInLine > 0 then begin
        // Operate on all results in this line.
        ptCurrent.X := fTSearch.Results[n];
        // Is the search result entirely in the search range?
        if InValidSearchRange(ptCurrent.X, ptCurrent.X + nSearchLen) then begin
          Result := ptCurrent;
          Exit;
        end;
      end;
      // search next / previous line
      if bBackward then Dec(ptCurrent.Y) else Inc(ptCurrent.Y);
    end;
  finally
    fTSearch.Free
  end;
end;

procedure TBricxccSynEdit.GotoLineNumber(aLine: Integer);
var
  p : TPoint;
begin
  p := Point(1, aLine);
  BlockBegin := p;
  BlockEnd   := p;
  CaretXY    := p;
  EnsureCursorPosVisibleEx(True);
end;

procedure TBricxccSynEdit.SelectDelimited(const aStartDelim : string = '"'; const AStopDelim: string = '"');
var
  ptStart, ptEnd: TPoint; // start and end of the search range
  ptCurrent: TPoint; // current search position
  nSearchLen, nFound, n: integer;
  nInLine: integer;
  bFoundFirst : boolean;
  fTSearch: TSynEditSearch;

  function WithinValidSearchRange(First, Last: integer): boolean;
  begin
    Result := TRUE;
    case SelectionMode of
      smNormal:
        if ((ptCurrent.Y = ptStart.Y) and (First < ptStart.X)) or
          ((ptCurrent.Y = ptEnd.Y) and (Last > ptEnd.X)) then Result := FALSE;
      smColumn:
        Result := (First >= ptStart.X) and (Last <= ptEnd.X) or (ptEnd.X-ptStart.X<2);
    end;
  end;
begin
  // delimiters must be a single character
  if Length(AStartDelim) <> 1 then exit;
  if Length(AStopDelim) <> 1 then exit;
  // search forward from current position
  ptStart := CaretXY;
  ptEnd.Y := Lines.Count;
  ptEnd.X := Length(Lines[ptEnd.Y - 1]) + 1;
  ptCurrent := ptStart;
  // initialize the search engine to find the starting delimiter
  fTSearch := TSynEditSearch.Create{$IFNDEF FPC}(nil){$ENDIF};
  try
    fTSearch.Sensitive := true;
    fTSearch.Whole := false;
    fTSearch.Pattern := AStartDelim;
    nSearchLen := Length(AStartDelim);
    bFoundFirst := False;
    while (ptCurrent.Y >= ptStart.Y) and (ptCurrent.Y <= ptEnd.Y) do begin
      nInLine := fTSearch.FindAll(Lines[ptCurrent.Y - 1]);
      // Operate on all results in this line
      n := 0;
      while nInLine > 0 do begin
        nFound := fTSearch.Results[n];
        inc(n);
        dec(nInLine);
        // Is the search result entirely in the search range?
        if not WithinValidSearchRange(nFound, nFound + nSearchLen) then continue;
        // Select the text, so the user can see it in the OnReplaceText event
        // handler or as the search result.
        ptCurrent.X := nFound;
        BlockBegin := ptCurrent;
        Inc(ptCurrent.X, nSearchLen);
        BlockEnd := ptCurrent;
        CaretXY := ptCurrent;
        bFoundFirst := True;
        break;
      end;
      if bFoundFirst then break;
      // search next line
      Inc(ptCurrent.Y);
    end;
    if bFoundFirst then
    begin
      // update the valid search range start
      ptStart := CaretXY;
      // now try to find the second delimiter
      fTSearch.Pattern := AStopDelim;
      nSearchLen := Length(AStopDelim);
      while (ptCurrent.Y >= ptStart.Y) and (ptCurrent.Y <= ptEnd.Y) do begin
        nInLine := fTSearch.FindAll(Lines[ptCurrent.Y - 1]);
        // Operate on all results in this line
        n := 0;
        while nInLine > 0 do begin
          nFound := fTSearch.Results[n];
          inc(n);
          dec(nInLine);
          // Is the search result entirely in the search range?
          if not WithinValidSearchRange(nFound, nFound + nSearchLen) then continue;
          // now we've found the second delimiter.
          // so we extend the block to end after the second delimiter
          ptCurrent.X := nFound;
          Inc(ptCurrent.X, nSearchLen);
          BlockEnd := ptCurrent;
          CaretXY := ptCurrent;
          // we're done now
          Exit;
        end;
        // search next line
        Inc(ptCurrent.Y);
      end;
    end;
  finally
    fTSearch.Free;
  end;
end;

function TBricxccSynEdit.TextAtCursor: string;
var
  p1, p2, c : TPoint;
begin
  Result := WordAtCursor;
  if Result = '' then
  begin
    p1 := BlockBegin;
    p2 := BlockEnd;
    c  := CaretXY;
    try
      SetWordBlock(CaretXY);
      Result := SelText;
    finally
      BlockBegin := p1;
      BlockEnd   := p2;
      CaretXY    := c;
    end;
  end;
end;

function TBricxccSynEdit.DelimitedStartEx(XY: TPoint; DelimChars: TSynIdentChars): TPoint;
var
  CX, CY: integer;
  Line: string;
begin
  CX := XY.X;
  CY := XY.Y;
  // valid line?
  if (CY >= 1) and (CY <= Lines.Count) then begin
    Line := Lines[CY - 1];
    CX := Min(CX, Length(Line) + 1);

    if CX > 1 then begin  // only find previous char, if not already on start of line
      // if previous char isn't a delimiter search for the last delimiter
      if not (Line[CX - 1] in DelimChars) then
        CX := StrRScanForCharInSet(Line, CX - 1, DelimChars) + 1;
    end;
  end;
  Result := Point(CX, CY);
end;

function TBricxccSynEdit.DelimitedEndEx(XY: TPoint; DelimChars : TSynIdentChars): TPoint;
var
  CX, CY: integer;
  Line: string;
begin
  CX := XY.X;
  CY := XY.Y;
  // valid line?
  if (CY >= 1) and (CY <= Lines.Count) then
  begin
    Line := Lines[CY - 1];

    CX := StrScanForCharInSet(Line, CX, DelimChars);
    // if no "whitespace" is found just position at the end of the line
    if CX = 0 then
      CX := Length(Line) + 1;
  end;
  Result := Point(CX,CY);
end;

function TBricxccSynEdit.DelimitedStart(DelimChars: TSynIdentChars): TPoint;
begin
  Result := DelimitedStartEx(CaretXY, DelimChars);
end;

function TBricxccSynEdit.DelimitedEnd(DelimChars: TSynIdentChars): TPoint;
begin
  Result := DelimitedEndEx(CaretXY, DelimChars);
end;

function TBricxccSynEdit.TextWithinDelimiters(DelimChars: TSynIdentChars): string;
var
  bBegin: TPoint;
  bEnd: TPoint;
begin
  bBegin := BlockBegin;
  bEnd := BlockEnd;
  BlockBegin := DelimitedStart(DelimChars);
  BlockEnd   := DelimitedEnd(DelimChars);
  Result := SelText;
  BlockBegin := bBegin;
  BlockEnd   := bEnd;
end;

procedure TBricxccSynEdit.ToggleBookMark(BookMark: Integer);
var
  bMarkIsSet : boolean;
  X, Y : integer;
begin
  bMarkIsSet := GetBookMark(BookMark, X, Y);
  // is the mark set on the current line?
  if bMarkIsSet and (CaretY = Y) then
    ClearBookMark(BookMark)
  else
    SetBookMark(BookMark, CaretX, CaretY);
end;

procedure TBricxccSynEdit.SetCaretAndSel(const ptCaret, ptBefore, ptAfter: TPoint);
begin
{$IFDEF FPC}
  CaretXY := ptCaret;
  BlockBegin := ptBefore;
  BlockEnd := ptAfter;
{$ELSE}
  SetCaretAndSelection(ptCaret, ptBefore, ptAfter);
{$ENDIF}
end;

end.
