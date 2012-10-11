unit uStreamRW;

interface

uses
  Classes, uUtilities;

procedure ReadByte(aStream : TStream; var value : Byte); overload;
function ReadByte(aStream : TStream) : byte; overload;

procedure ReadShortInt(aStream : TStream; var value : ShortInt); overload;
function ReadShortInt(aStream : TStream) : ShortInt; overload;

procedure ReadWord(aStream : TStream; var value : Word; bLittleEndian : Boolean = True); overload;
function ReadWord(aStream : TStream; bLittleEndian : Boolean = True) : Word; overload;

procedure ReadSmallInt(aStream : TStream; var value : SmallInt; bLittleEndian : Boolean = True); overload;
function ReadSmallInt(aStream : TStream; bLittleEndian : Boolean = True) : SmallInt; overload;

procedure ReadCardinal(aStream : TStream; var value : Cardinal; bLittleEndian : Boolean = True); overload;
function ReadCardinal(aStream : TStream; bLittleEndian : Boolean = True) : Cardinal; overload;

procedure ReadInteger(aStream : TStream; var value : Integer; bLittleEndian : Boolean = True); overload;
function ReadInteger(aStream : TStream; bLittleEndian : Boolean = True) : Integer; overload;


procedure WriteByte(aStream : TStream; value : byte);
procedure WriteShortInt(aStream : TStream; value : ShortInt);
procedure WriteWord(aStream : TStream; value : Word; bLittleEndian : Boolean = True);
procedure WriteSmallInt(aStream : TStream; value : SmallInt; bLittleEndian : Boolean = True);
procedure WriteCardinal(aStream : TStream; value : Cardinal; bLittleEndian : Boolean = True);
procedure WriteInteger(aStream : TStream; value : Integer; bLittleEndian : Boolean = True);
procedure WriteString(aStream : TStream; aString : string; bWriteLength : Boolean = False);
procedure WriteSingle(aStream : TStream; value : single; bLittleEndian : Boolean = True);
procedure WriteBytes(aStream : TStream; value : TBytes);

implementation

procedure ReadByte(aStream : TStream; var value : Byte);
begin
  aStream.Read(value, 1);
end;

function ReadByte(aStream : TStream) : byte;
begin
  Result := 0;
  ReadByte(aStream, Result);
end;

procedure ReadShortInt(aStream : TStream; var value : ShortInt);
var
  b : byte;
begin
  b := 0;
  ReadByte(aStream, b);
  value := ShortInt(b);
end;

function ReadShortInt(aStream : TStream) : ShortInt;
begin
  Result := 0;
  ReadShortInt(aStream, Result);
end;

procedure ReadWord(aStream : TStream; var value : Word; bLittleEndian : Boolean);
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

function ReadWord(aStream : TStream; bLittleEndian : Boolean) : Word;
begin
  Result := 0;
  ReadWord(aStream, Result, bLittleEndian);
end;

procedure ReadSmallInt(aStream : TStream; var value : SmallInt; bLittleEndian : Boolean);
var
  w : word;
begin
  w := 0;
  ReadWord(aStream, w, bLittleEndian);
  value := SmallInt(w);
end;

function ReadSmallInt(aStream : TStream; bLittleEndian : Boolean) : SmallInt;
begin
  Result := 0;
  ReadSmallInt(aStream, Result, bLittleEndian);
end;

procedure ReadCardinal(aStream : TStream; var value : Cardinal; bLittleEndian : Boolean);
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

function ReadCardinal(aStream : TStream; bLittleEndian : Boolean) : Cardinal;
begin
  Result := 0;
  ReadCardinal(aStream, Result, bLittleEndian);
end;

procedure ReadInteger(aStream : TStream; var value : Integer; bLittleEndian : Boolean);
var
  c : Cardinal;
begin
  c := 0;
  ReadCardinal(aStream, c, bLittleEndian);
  value := Integer(c);
end;

function ReadInteger(aStream : TStream; bLittleEndian : Boolean) : Integer;
begin
  Result := 0;
  ReadInteger(aStream, Result, bLittleEndian);
end;

procedure WriteByte(aStream : TStream; value : byte);
begin
  aStream.Write(value, 1);
end;

procedure WriteShortInt(aStream : TStream; value : ShortInt);
begin
  WriteByte(aStream, Byte(value));
end;

procedure WriteWord(aStream : TStream; value : Word; bLittleEndian : Boolean);
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

procedure WriteSmallInt(aStream : TStream; value : SmallInt; bLittleEndian : Boolean);
begin
  WriteWord(aStream, Word(value), bLittleEndian);
end;

procedure WriteCardinal(aStream : TStream; value : Cardinal; bLittleEndian : Boolean);
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

procedure WriteInteger(aStream : TStream; value : Integer; bLittleEndian : Boolean);
begin
  WriteCardinal(aStream, Cardinal(value), bLittleEndian);
end;

procedure WriteString(aStream : TStream; aString : string; bWriteLength : Boolean);
begin
  if bWriteLength then
  begin
    WriteWord(aStream, Length(aString));
  end;
  aStream.Write(Pointer(aString)^, Length(aString));
end;

procedure WriteSingle(aStream : TStream; value : single; bLittleEndian : Boolean);
begin
  aStream.Write(value, SizeOf(value));
end;

procedure WriteBytes(aStream : TStream; value : TBytes);
begin
  aStream.Write(value, Length(value));
end;

end.
