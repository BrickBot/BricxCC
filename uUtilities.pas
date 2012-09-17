unit uUtilities;

interface

uses
  Classes;

function HiWord(L: Cardinal): Word;
function HiByte(W: Word): Byte;
function GetByte(val : Cardinal; idx : integer) : Byte;
function BytesToCardinal(b1 : byte; b2 : byte = 0; b3 : byte = 0; b4 : Byte = 0) : Cardinal; {overload;}

function CardinalToSingle(const cVal : Cardinal) : Single;
function SingleToCardinal(const sVal : Single) : Cardinal;

implementation

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

function BytesToCardinal(b1 : byte; b2 : byte = 0; b3 : byte = 0; b4 : Byte = 0) : Cardinal;
begin
  Result := Cardinal(b1) + (Cardinal(b2) shl 8) + (Cardinal(b3) shl 16) + (Cardinal(b4) shl 24);
end;

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

end.
