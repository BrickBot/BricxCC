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
unit uCommonUtils;

interface

uses
  Classes;

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


procedure WriteSmallIntToStream(aStream : TStream; value : SmallInt; bLittleEndian : Boolean = True);
procedure ReadSmallIntFromStream(aStream : TStream; var value : SmallInt; bLittleEndian : Boolean = True);
procedure WriteWordToStream(aStream : TStream; value : Word; bLittleEndian : Boolean = True);
procedure ReadWordFromStream(aStream : TStream; var value : Word; bLittleEndian : Boolean = True);
procedure WriteCardinalToStream(aStream : TStream; value : Cardinal; bLittleEndian : Boolean = True);
procedure ReadCardinalFromStream(aStream : TStream; var value : Cardinal; bLittleEndian : Boolean = True);
procedure WriteWaveFormatToStream(aStream : TStream; fmt : TWaveFormatEx);
function ReadMIDIMTHDFromStream(aStream : TStream; var head : MTHD) : boolean;
function ReadMIDIMTRKFromStream(aStream : TStream; var head : MTRK) : boolean;
function HiWord(L: Cardinal): Word;
function HiByte(W: Word): Byte;
function GetByte(val : Cardinal; idx : integer) : Byte;
function BytesToCardinal(b1 : byte; b2 : byte = 0; b3 : byte = 0; b4 : Byte = 0) : Cardinal; {overload;}
//function BytesToCardinal(b : array of byte) : Cardinal; overload;
procedure GetFileList(const Directory : string; const Pattern : string; List : TStringlist);
procedure GetSubDirectories(const Directory : string; List : TStringlist);
procedure OSSleep(const ms : Cardinal);
procedure PostWindowMessage(aHwnd : HWND; aMsg : Cardinal; wParam, lParam : Integer);
function MulDiv(const x, num, den : integer) : integer;
function CardinalToSingle(const cVal : Cardinal) : Single;
function SingleToCardinal(const sVal : Single) : Cardinal;
function StripTrailingZeros(const aNum : string) : string;

implementation

uses
{$IFNDEF FPC}
  Windows,
{$ENDIF}
  SysUtils;

procedure WriteWordToStream(aStream : TStream; value : Word; bLittleEndian : Boolean);
var
  B1, B2 : byte;
begin
  if bLittleEndian then
  begin
    B1 := Lo(value);
    B2 := Hi(value);
  end
  else
  begin
    B1 := Hi(value);
    B2 := Lo(value);
  end;
  aStream.Write(B1, 1);
  aStream.Write(B2, 1);
end;

procedure WriteSmallIntToStream(aStream : TStream; value : SmallInt; bLittleEndian : Boolean);
begin
  WriteWordToStream(aStream, Word(value), bLittleEndian);
end;

procedure ReadWordFromStream(aStream : TStream; var value : Word; bLittleEndian : Boolean);
var
  B1, B2 : byte;
begin
  B1 := 0;
  B2 := 0;
  aStream.Read(B1, 1);
  aStream.Read(B2, 1);
  if bLittleEndian then
  begin
    value := Word(Word(B1) + (Word(B2) shl 8));
  end
  else
  begin
    value := Word(Word(B2) + (Word(B1) shl 8));
  end;
end;

procedure ReadSmallIntFromStream(aStream : TStream; var value : SmallInt; bLittleEndian : Boolean);
var
  w : word;
begin
  w := 0;
  ReadWordFromStream(aStream, w, bLittleEndian);
  value := SmallInt(w);
end;

procedure WriteCardinalToStream(aStream : TStream; value : Cardinal; bLittleEndian : Boolean);
var
  b1, b2, b3, b4 : byte;
begin
  if bLittleEndian then
  begin
    b1 := GetByte(value, 0);
    b2 := GetByte(value, 1);
    b3 := GetByte(value, 2);
    b4 := GetByte(value, 3);
  end
  else
  begin
    b1 := GetByte(value, 3);
    b2 := GetByte(value, 2);
    b3 := GetByte(value, 1);
    b4 := GetByte(value, 0);
  end;
  aStream.Write(b1, 1);
  aStream.Write(b2, 1);
  aStream.Write(b3, 1);
  aStream.Write(b4, 1);
end;

procedure ReadCardinalFromStream(aStream : TStream; var value : Cardinal; bLittleEndian : Boolean);
var
  b1, b2, b3, b4 : byte;
begin
  b1 := 0; b2 := 0; b3 := 0; b4 := 0;
  aStream.Read(b1, 1);
  aStream.Read(b2, 1);
  aStream.Read(b3, 1);
  aStream.Read(b4, 1);
  if bLittleEndian then
  begin
    value := BytesToCardinal(b1, b2, b3, b4);
  end
  else
  begin
    value := BytesToCardinal(b4, b3, b2, b1);
  end;
end;

procedure WriteWaveFormatToStream(aStream : TStream; fmt : TWaveFormatEx);
begin
  WriteWordToStream(aStream, fmt.wFormatTag);
  WriteWordToStream(aStream, fmt.nChannels);
  WriteCardinalToStream(aStream, fmt.nSamplesPerSec);
  WriteCardinalToStream(aStream, fmt.nAvgBytesPerSec);
  WriteWordToStream(aStream, fmt.nBlockAlign);
  WriteWordToStream(aStream, fmt.wBitsPerSample);
  WriteWordToStream(aStream, fmt.cbSize);
end;

function ReadMIDIMTHDFromStream(aStream : TStream; var head : MTHD) : boolean;
begin
  try
    aStream.Read(head.id, 4);
    ReadCardinalFromStream(aStream, head.len, False);
    ReadWordFromStream(aStream, head.fmt, False);
    ReadWordFromStream(aStream, head.track, False);
    ReadWordFromStream(aStream, head.div_, False);
    Result := True;
  except
    Result := False;
  end;
end;

function ReadMIDIMTRKFromStream(aStream : TStream; var head : MTRK) : boolean;
begin
  try
    aStream.Read(head.id, 4);
    ReadCardinalFromStream(aStream, head.len, False);
    Result := True;
  except
    Result := False;
  end;
end;

function HiWord(L: Cardinal): Word;
begin
  Result := Word(L shr 16);
end;

function HiByte(W: Word): Byte;
begin
  Result := Byte(W shr 8);
end;

function GetByte(val : Cardinal; idx : integer) : Byte;
begin
  case idx of
    0 : Result := Lo(Word(val));
    1 : Result := Hi(Word(val));
    2 : Result := Lo(HiWord(val));
    3 : Result := Hi(HiWord(val));
  else
    Result := 0;
  end;
end;

procedure OSSleep(const ms : Cardinal);
begin
{$IFDEF FPC}
// not sure what to do here yet
{$ELSE}
  Windows.Sleep(ms);
{$ENDIF}
end;

procedure PostWindowMessage(aHwnd : HWND; aMsg : Cardinal; wParam, lParam : Integer);
begin
{$IFDEF FPC}
//  ;
{$ELSE}
  PostMessage(aHwnd, aMsg, wParam, lParam);
{$ENDIF}
end;

function MulDiv(const x, num, den : integer) : integer;
begin
  Result := (x * num) div den;
end;

function BytesToCardinal(b1 : byte; b2 : byte = 0; b3 : byte = 0; b4 : Byte = 0) : Cardinal;
begin
  Result := Cardinal(b1) + (Cardinal(b2) shl 8) + (Cardinal(b3) shl 16) + (Cardinal(b4) shl 24);
end;

{
function BytesToCardinal(b : array of byte) : Cardinal;
var
  i : integer;
begin
  Result := 0;
  for i := Low(b) to High(b) do
    Result := (Result shl 8) + b[i];
end;
}

{$ifdef FPC}
function CardinalToSingle(const cVal : Cardinal) : Single;
begin
  Result := Single(cVal);
end;

function SingleToCardinal(const sVal : Single) : Cardinal;
begin
  Result := Cardinal(sVal);
end;
{$else}
function CardinalToSingle(const cVal : Cardinal) : Single;
begin
  Result := Single(Pointer(cVal));
end;

function SingleToCardinal(const sVal : Single) : Cardinal;
begin
  Result := Cardinal(Pointer(sVal));
end;
{$endif}

function StripTrailingZeros(const aNum : string) : string;
begin
  Result := aNum;
  while Result[Length(Result)] = '0' do
    System.Delete(Result, Length(Result), 1);
  if Result[Length(Result)] in ['.', ','] then
    System.Delete(Result, Length(Result), 1);
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
    FindClose(SearchRec);
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
    FindClose(SearchRec);
  end;
end;

end.
