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
unit uCommonUtils;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils;

const
  DEFAULT_CHARSET = 1;
  SW_SHOWMINNOACTIVE = 7;
  HKEY_CLASSES_ROOT  = LongWord($80000000);
  HKEY_CURRENT_USER  = LongWord($80000001);
  HKEY_LOCAL_MACHINE = LongWord($80000002);

type
  HWND = type LongWord;

type
  TWaveFormatEx = packed record
    wFormatTag: Word;         { format type }
    nChannels: Word;          { number of channels (i.e. mono, stereo, etc.) }
    nSamplesPerSec: Cardinal;  { sample rate }
    nAvgBytesPerSec: Cardinal; { for buffer estimation }
    nBlockAlign: Word;      { block size of data }
    wBitsPerSample: Word;   { number of bits per sample of mono data }
    cbSize: Word;           { the count in bytes of the size of }
  end;

type
  _mthd = record
    id : array[0..3] of Char;
    len : Cardinal;
    fmt : Word;
    track : Word;
    div_ : Word;
  end;
  MTHD = _mthd;

type
  _mtrk = record
    id : array[0..3] of Char;
    len : Cardinal;
  end;
  MTRK = _mtrk;


procedure WriteWaveFormat(aStream : TStream; fmt : TWaveFormatEx);
function ReadMIDIMTHD(aStream : TStream; var head : MTHD) : boolean;
function ReadMIDIMTRK(aStream : TStream; var head : MTRK) : boolean;
procedure GetFileList(const Directory : string; const Pattern : string; List : TStringlist);
procedure GetSubDirectories(const Directory : string; List : TStringlist);
procedure OSSleep(const ms : Cardinal);
procedure PostWindowMessage(aHwnd : HWND; aMsg : Cardinal; wParam, lParam : Integer);
function MulDiv(const x, num, den : integer) : integer;
function StripTrailingZeros(const aNum : string) : string;
function StripQuotes(const str : string) : string;
function StripBraces(const str : string) : string;
function StripParens(const str : string) : string;
function Replace(const str : string; const src, rep : string) : string;
function CommasToSpaces(const line : string) : string;
procedure TrimComments(var line : string; p : integer; const sub : string);
function JCHExtractStrings(Separators, WhiteSpace: TSysCharSet; Content: PChar;
  Strings: TStrings): Integer;
function BinToInt(const aValue: String): Cardinal;
function BinToIntDef(const aValue: String; const aDefault : Cardinal): Cardinal;

implementation

uses
  uStreamRW
{$IFNDEF FPC}
  {$IFDEF FAST_MM}
  ,FastStrings
  {$ENDIF}
  ,Windows
{$ENDIF}
  ;


procedure WriteWaveFormat(aStream : TStream; fmt : TWaveFormatEx);
begin
  WriteWord(aStream, fmt.wFormatTag);
  WriteWord(aStream, fmt.nChannels);
  WriteCardinal(aStream, fmt.nSamplesPerSec);
  WriteCardinal(aStream, fmt.nAvgBytesPerSec);
  WriteWord(aStream, fmt.nBlockAlign);
  WriteWord(aStream, fmt.wBitsPerSample);
  WriteWord(aStream, fmt.cbSize);
end;

function ReadMIDIMTHD(aStream : TStream; var head : MTHD) : boolean;
begin
  try
    aStream.Read(head.id, 4);
    ReadCardinal(aStream, head.len, False);
    ReadWord(aStream, head.fmt, False);
    ReadWord(aStream, head.track, False);
    ReadWord(aStream, head.div_, False);
    Result := True;
  except
    Result := False;
  end;
end;

function ReadMIDIMTRK(aStream : TStream; var head : MTRK) : boolean;
begin
  try
    aStream.Read(head.id, 4);
    ReadCardinal(aStream, head.len, False);
    Result := True;
  except
    Result := False;
  end;
end;

procedure OSSleep(const ms : Cardinal);
begin
  Sleep(ms);
end;

procedure PostWindowMessage(aHwnd : HWND; aMsg : Cardinal; wParam, lParam : Integer);
begin
{$IFDEF FPC}
  //  do nothing
  if (aHwnd = 0) and (aMsg = 0) and (wParam = 0) and (lParam = 0) then
    ;
{$ELSE}
  PostMessage(aHwnd, aMsg, wParam, lParam);
{$ENDIF}
end;

function MulDiv(const x, num, den : integer) : integer;
begin
  Result := (x * num) div den;
end;

function StripTrailingZeros(const aNum : string) : string;
begin
  Result := aNum;
  while Result[Length(Result)] = '0' do
    System.Delete(Result, Length(Result), 1);
  if Result[Length(Result)] in ['.', ','] then
    System.Delete(Result, Length(Result), 1);
end;

function StripQuotes(const str : string) : string;
begin
  Result := Copy(str, 2, Length(str)-2);
end;

function StripBraces(const str : string) : string;
begin
  Result := Copy(str, 2, Length(str)-2);
end;

function StripParens(const str : string) : string;
begin
  Result := Copy(str, 2, Length(str)-2);
end;

procedure GetFileList(const Directory : string; const Pattern : string; List : TStringlist);
var
  SearchRec : TSearchRec;
  iRes : Integer;
begin
  iRes := FindFirst(IncludeTrailingPathDelimiter(Directory) + Pattern, faAnyFile, SearchRec);
  try
    while iRes = 0 do
    begin
      if (SearchRec.Attr and faDirectory) <> faDirectory then
        List.Add(SearchRec.Name);
      iRes := FindNext(SearchRec);
    end;

  finally
    SysUtils.FindClose(SearchRec);
  end;
end;

procedure GetSubDirectories(const Directory : string; List : TStringlist);
var
  SearchRec : TSearchRec;
  iRes : Integer;
begin
  iRes := FindFirst(IncludeTrailingPathDelimiter(Directory) + '*.*', faDirectory, SearchRec);
  try
    while iRes = 0 do
    begin
      if (SearchRec.Attr and faDirectory) = faDirectory then
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
          List.Add(SearchRec.Name);
      iRes := FindNext(SearchRec);
    end;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;

function Replace(const str : string; const src, rep : string) : string;
begin
{$IFDEF FAST_MM}
  Result := FastReplace(str, src, rep, True);
{$ELSE}
  Result := StringReplace(str, src, rep, [rfReplaceAll]);
{$ENDIF}
end;

function CommasToSpaces(const line : string) : string;
var
  i, len : integer;
  bInString : boolean;
  ch : Char;
begin
  i := Pos('''', line); // is there a string initializer on this line?
  if i > 0 then
  begin
    // if there is a string on this line then process a character at a time
    bInString := False;
    Result := '';
    len := Length(line);
    for i := 1 to len do begin
      ch := line[i];
      if (ch = ',') and not bInString then
        ch := ' '
      else if ch = '''' then
        bInString := not bInString;
      Result := Result + ch;
    end;
  end
  else
    Result := Replace(line, ',', ' ');
end;

procedure TrimComments(var line : string; p : integer; const sub : string);
var
  tmp : string;
  i, j : integer;
begin
  if p = 0 then exit;
  tmp := line;
  i := Pos('''', tmp);
  while i > 0 do
  begin
    System.Delete(tmp, 1, i); // trim up to and including open quote
    // find the close quote, if it exists
    j := Pos('''', tmp);
    if j = 0 then
    begin
      // if no close quote exists then we assume the string
      // continues to the end
      tmp := '';
      break;
    end;
    System.Delete(tmp, 1, j); // trim up to and including close quote
    i := Pos('''', tmp);
  end;
  // if the copy of our line is not empty then we may need to trim our line
  i := Pos(sub, tmp);
  if i > 0 then
  begin
    System.Delete(tmp, 1, i-1); // trim up to but not including the comment token
    System.Delete(line, Length(line)-Length(tmp)+1, MaxInt); // now trim our line
  end;
end;

{$IFDEF FPC}
function JCHExtractStrings(Separators, WhiteSpace: TSysCharSet; Content: PChar;
  Strings: TStrings): Integer;
var
  Head, Tail: PChar;
  EOS, InQuote: Boolean;
  QuoteChar: Char;
  Item: string;
begin
  Item := '';
  Result := 0;
  if (Content = nil) or (Content^=#0) or (Strings = nil) then Exit;
  Tail := Content;
  InQuote := False;
  QuoteChar := #0;
  Strings.BeginUpdate;
  try
    repeat
      while Tail^ in WhiteSpace + [#13, #10] do inc(Tail);
      Head := Tail;
      while True do
      begin
        while (InQuote and not (Tail^ in [QuoteChar, #0])) or
          not (Tail^ in Separators + [#0, #13, #10, '''', '"']) do
            inc(Tail);
        if Tail^ in ['''', '"'] then
        begin
          if (QuoteChar <> #0) and (QuoteChar = Tail^) then
            QuoteChar := #0
          else if QuoteChar = #0 then
            QuoteChar := Tail^;
          InQuote := QuoteChar <> #0;
          inc(Tail);
        end else Break;
      end;
      EOS := Tail^ = #0;
      if (Head <> Tail) and (Head^ <> #0) then
      begin
        if Strings <> nil then
        begin
          SetString(Item, Head, Tail - Head);
          Strings.Add(Item);
        end;
        Inc(Result);
      end;
      inc(Tail);
    until EOS;
  finally
    Strings.EndUpdate;
  end;
end;
{$ELSE}
function JCHExtractStrings(Separators, WhiteSpace: TSysCharSet; Content: PChar;
  Strings: TStrings): Integer;
begin
  Result := ExtractStrings(Separators, WhiteSpace, Content, Strings);
end;
{$ENDIF}

function BinToInt(const aValue: String): Cardinal;
begin
  Result := BinToIntDef(aValue, 0);
end;

function BinToIntDef(const aValue: String; const aDefault : Cardinal): Cardinal;
var
  i, len : Integer;
  Ch : Char;
begin
  Result := 0;
  len := Length(aValue);
  for i := len downto 1 do begin
    Ch := aValue[i];
    if Ch = '1' then
      Result := Result + Cardinal(1 shl (len-i))
    else if Ch = '0' then
      continue
    else begin
      Result := aDefault;
      break;
    end;
  end;
end;

end.