unit uBinaryRW;

interface

uses
  Classes;

type
  TBytes = array of byte;
  TCharArray = array of Char;
  
  TBinaryReader = class
  private
    FStream: TStream;
    FOwnsStream: Boolean;
    FTwoBytesPerChar: Boolean;
    FCharBytes: TBytes;
    FOneChar: TCharArray;
    FMaxCharsSize: Integer;
    function InternalReadChar: Integer;
    function InternalReadChars(const Chars: TCharArray; Index, Count: Integer): Integer;
  protected
    function GetBaseStream: TStream; virtual;
    function Read7BitEncodedInt: Integer; virtual;
  public
    constructor Create(Stream: TStream); overload;
    constructor Create(Stream: TStream; AOwnsStream: Boolean = False); overload;
    constructor Create(const Filename: string); overload;
    destructor Destroy; override;
    procedure Close; virtual;
    function PeekChar: Integer; virtual;
    function Read: Integer; overload; virtual;
    function Read(var Buffer: TCharArray; Index, Count: Integer): Integer; overload; virtual;
    function Read(const Buffer: TBytes; Index, Count: Integer): Integer; overload; virtual;
    function ReadBoolean: Boolean; virtual;
    function ReadByte: Byte; virtual;
    function ReadBytes(Count: Integer): TBytes; virtual;
    function ReadChar: Char; virtual;
    function ReadChars(Count: Integer): TCharArray; virtual;
    function ReadDouble: Double; virtual;
    function ReadSByte: ShortInt;
    function ReadShortInt: ShortInt; virtual;
    function ReadSmallInt: SmallInt; virtual;
    function ReadInt16: SmallInt; 
    function ReadInteger: Integer; virtual;
    function ReadInt32: Integer;
    function ReadInt64: Int64; virtual;
    function ReadSingle: Single; virtual;
    function ReadString: string; virtual;
    function ReadWord: Word; virtual;
    function ReadUInt16: Word;
    function ReadCardinal: Cardinal; virtual;
    function ReadUInt32: Cardinal;
    function ReadUInt64: UInt64; virtual;
    property BaseStream: TStream read GetBaseStream;
  end;

  TBinaryWriter = class
  private
    FStream: TStream;
    FOwnsStream: Boolean;
  protected
    function GetBaseStream: TStream; virtual;
    procedure Write7BitEncodedInt(Value: Integer); virtual;
    constructor Create; overload;
  public
    constructor Create(Stream: TStream); overload;
    constructor Create(Stream: TStream; AOwnsStream: Boolean); overload;
    constructor Create(const Filename: string; Append: Boolean = False); overload;
    destructor Destroy; override;
    procedure Close; virtual;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; virtual;
    procedure Write(Value: Byte); overload; virtual;
    procedure Write(Value: Boolean); overload; virtual;
    procedure Write(Value: Char); overload; virtual;
    procedure Write(const Value: TCharArray); overload; virtual;
    procedure Write(const Value: TBytes); overload; virtual;
    procedure Write(Value: Double); overload; virtual;
    procedure Write(Value: Integer); overload; virtual;
    procedure Write(Value: SmallInt); overload; virtual;
    procedure Write(Value: ShortInt); overload; virtual;
    procedure Write(Value: Word); overload; virtual;
    procedure Write(Value: Cardinal); overload; virtual;
    procedure Write(Value: Int64); overload; virtual;
    procedure Write(Value: Single); overload; virtual;
    procedure Write(const Value: string); overload; virtual;
    procedure Write(Value: UInt64); overload; virtual;
    procedure Write(const Value: TCharArray; Index, Count: Integer); overload; virtual;
    procedure Write(const Value: TBytes; Index, Count: Integer); overload; virtual;
    property BaseStream: TStream read GetBaseStream;
  end;

implementation

uses
  SysUtils;

{ TBinaryReader }

procedure TBinaryReader.Close;
begin
  if FOwnsStream then
    FreeAndNil(FStream);
end;

constructor TBinaryReader.Create(Stream: TStream; AOwnsStream: Boolean);
begin
  inherited Create;
  FStream := Stream;
  FOwnsStream := AOwnsStream;
  FTwoBytesPerChar := False;
  FMaxCharsSize := 1;
end;

constructor TBinaryReader.Create(Stream: TStream);
begin
  Create(Stream, False);
end;

constructor TBinaryReader.Create(const Filename: string);
begin
  Create(TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite), True);
end;

destructor TBinaryReader.Destroy;
begin
  if FOwnsStream then
    FStream.Free;
  inherited;
end;

function TBinaryReader.GetBaseStream: TStream;
begin
  Result := FStream;
end;

function TBinaryReader.InternalReadChar: Integer;
var
  CharCount: Integer;
  ByteCount: Integer;
  Index: Integer;
  Position: Int64;
  CharByte: Byte;
begin
  if FCharBytes = nil then
    SetLength(FCharBytes, $80);
  if FOneChar = nil then
    SetLength(FOneChar, 1);
  Index := 0;
  Position := FStream.Position;
  try
    CharCount := 0;
    if FTwoBytesPerChar then
      ByteCount := 2
    else
      ByteCount := 1;
    while (CharCount = 0) and (Index < Length(FCharBytes)) do
    begin
      if FStream.Read(CharByte, SizeOf(CharByte)) = 0 then
        ByteCount := 0;
      FCharBytes[Index] := CharByte;
      Inc(Index);
      if ByteCount = 2 then
      begin
        if FStream.Read(CharByte, SizeOf(CharByte)) = 0 then
          ByteCount := 1;
        FCharBytes[Index] := CharByte;
        Inc(Index);
      end;
      if ByteCount = 0 then
      begin
        Result := -1;
        Exit;
      end;
//      CharCount := FEncoding.GetChars(FCharBytes, 0, Index, FOneChar, 0);
    end;
  except
    FStream.Position := Position;
    raise;
  end;
  if CharCount > 0 then
    Result := Integer(FOneChar[0])
  else
    Result := -1;
end;

function TBinaryReader.InternalReadChars(const Chars: TCharArray; Index, Count: Integer): Integer;
var
  BytesToRead, RemainingChars, CharCount: Integer;
begin
  if FCharBytes = nil then
    SetLength(FCharBytes, $80);
  RemainingChars := Count;
  while RemainingChars > 0 do
  begin
    BytesToRead := RemainingChars;
    if FTwoBytesPerChar then
      BytesToRead := BytesToRead shl 1;
    if BytesToRead > Length(FCharBytes) then
      BytesToRead := Length(FCharBytes);
    BytesToRead := FStream.Read(FCharBytes[0], BytesToRead);
    if BytesToRead = 0 then
      Break;
//    CharCount := FEncoding.GetChars(FCharBytes, 0, BytesToRead, Chars, Index);
    Dec(RemainingChars, CharCount);
    Inc(Index, CharCount);
  end;
  Result := Count - RemainingChars;
end;

function TBinaryReader.PeekChar: Integer;
var
  Position: Int64;
begin
  Position := FStream.Position;
  try
    Result := InternalReadChar;
  finally
    FStream.Position := Position;
  end;
end;

function TBinaryReader.Read(var Buffer: TCharArray; Index, Count: Integer): Integer;
begin
  Result := InternalReadChars(Buffer, Index, Count);
end;

function TBinaryReader.Read: Integer;
begin
  Result := InternalReadChar;
end;

function TBinaryReader.Read(const Buffer: TBytes; Index, Count: Integer): Integer;
begin
  Result := FStream.Read(Buffer[Index], Count);
end;

function TBinaryReader.Read7BitEncodedInt: Integer;
var
  Shift: Integer;
  Value: Integer;
begin
  Shift := 0;
  Result := 0;
  repeat
    if Shift = 35 then
      raise Exception.Create('Invalid 7bit shift');
    Value := ReadByte;
    Result := Result or ((Value and $7F) shl Shift);
    Inc(Shift, 7);
  until Value and $80 = 0;
end;

function TBinaryReader.ReadBoolean: Boolean;
begin
  FStream.ReadBuffer(Result, SizeOf(Result));
end;

function TBinaryReader.ReadByte: Byte;
begin
  FStream.ReadBuffer(Result, SizeOf(Result));
end;

function TBinaryReader.ReadBytes(Count: Integer): TBytes;
var
  BytesRead: Integer;
begin
  SetLength(Result, Count);
  BytesRead := FStream.Read(Result[0], Count);
  if BytesRead <> Count then
    SetLength(Result, BytesRead);
end;

function TBinaryReader.ReadCardinal: Cardinal;
begin
  FStream.ReadBuffer(Result, SizeOf(Result));
end;

function TBinaryReader.ReadChar: Char;
var
  Value: Integer;
begin
  Value := Read;
  if Value = -1 then
    raise Exception.Create('Read past end of stream');
  Result := Char(Value);
end;

function TBinaryReader.ReadChars(Count: Integer): TCharArray;
var
  CharsRead: Integer;
begin
  SetLength(Result, Count);
  CharsRead := InternalReadChars(Result, 0, Count);
  if CharsRead <> Count then
    SetLength(Result, CharsRead);
end;

function TBinaryReader.ReadDouble: Double;
begin
  FStream.ReadBuffer(Result, SizeOf(Result));
end;

function TBinaryReader.ReadInt64: Int64;
begin
  FStream.ReadBuffer(Result, SizeOf(Result));
end;

function TBinaryReader.ReadInteger: Integer;
begin
  FStream.ReadBuffer(Result, SizeOf(Result));
end;

function TBinaryReader.ReadInt32: Integer;
begin
  Result := ReadInteger;
end;

function TBinaryReader.ReadShortInt: ShortInt;
begin
  FStream.ReadBuffer(Result, SizeOf(Result));
end;

function TBinaryReader.ReadSByte: ShortInt;
begin
  Result := ReadShortInt;
end;

function TBinaryReader.ReadSmallInt: SmallInt;
begin
  FStream.ReadBuffer(Result, SizeOf(Result));
end;

function TBinaryReader.ReadInt16: SmallInt;
begin
  Result := ReadSmallInt;
end;

function TBinaryReader.ReadSingle: Single;
begin
  FStream.ReadBuffer(Result, SizeOf(Result));
end;

function TBinaryReader.ReadString: string;
var
  Bytes: TBytes;
  ByteCount, BytesRead: Integer;
begin
  ByteCount := Read7BitEncodedInt;
  if ByteCount < 0 then
    raise Exception.Create('Invalid string length');
  if ByteCount > 0 then
  begin
    SetLength(Bytes, ByteCount);
    BytesRead := FStream.Read(Bytes[0], ByteCount);
    if BytesRead <> ByteCount then
      raise Exception.Create('Read past end of stream');
    Result := string(PChar(Bytes[0]));
  end else
    Result := '';
end;

function TBinaryReader.ReadUInt32: Cardinal;
begin
  Result := ReadCardinal;
end;

function TBinaryReader.ReadUInt64: UInt64;
begin
  FStream.ReadBuffer(Result, SizeOf(Result));
end;

function TBinaryReader.ReadWord: Word;
begin
  FStream.ReadBuffer(Result, SizeOf(Result));
end;

function TBinaryReader.ReadUInt16: Word;
begin
  Result := ReadWord;
end;

{ TNullStream }

type
  TNullStream = class(TStream)
  public
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; overload; override;
  end;

{ TNullStream }

function TNullStream.Read(var Buffer; Count: Integer): Longint;
begin
  Result := 0;
end;

function TNullStream.Seek(Offset: Integer; Origin: Word): Longint;
begin
  Result := 0;
end;

function TNullStream.Write(const Buffer; Count: Integer): Longint;
begin
  Result := 0;
end;

{ TBinaryWriter }

constructor TBinaryWriter.Create(Stream: TStream);
begin
  Create(Stream, False);
end;

constructor TBinaryWriter.Create(Stream: TStream; AOwnsStream: Boolean);
begin
  inherited Create;
  FStream := Stream;
  FOwnsStream := AOwnsStream;
end;

procedure TBinaryWriter.Close;
begin
  if FOwnsStream then
    FreeAndNil(FStream);
end;

constructor TBinaryWriter.Create(const Filename: string; Append: Boolean);
begin
  if (not FileExists(Filename)) or (not Append) then
    FStream := TFileStream.Create(Filename, fmCreate)
  else
  begin
    FStream := TFileStream.Create(Filename, fmOpenWrite);
    FStream.Seek(0, soEnd);
  end;
  Create(FStream, True);
end;

constructor TBinaryWriter.Create;
begin
  Create(TNullStream.Create, True);
end;

destructor TBinaryWriter.Destroy;
begin
  if FOwnsStream then
    FStream.Free;
  inherited;
end;

function TBinaryWriter.GetBaseStream: TStream;
begin
  Result := FStream;
end;

function TBinaryWriter.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  Result := FStream.Seek(Offset, Origin);
end;

procedure TBinaryWriter.Write(Value: Char);
var
  Bytes: TBytes;
begin
//  Bytes := FEncoding.GetBytes(Value);
  FStream.WriteBuffer(Bytes, Length(Bytes));
end;

procedure TBinaryWriter.Write(Value: Byte);
begin
  FStream.Write(Value, SizeOf(Value));
end;

procedure TBinaryWriter.Write(Value: Boolean);
begin
  FStream.Write(Value, SizeOf(Value));
end;

procedure TBinaryWriter.Write(const Value: TCharArray);
begin
  FStream.WriteBuffer(Value, Length(Value));
end;

procedure TBinaryWriter.Write(const Value: string);
begin
  Write7BitEncodedInt(Length(Value));
  FStream.WriteBuffer(PChar(Value)^, Length(Value));
end;

procedure TBinaryWriter.Write(Value: Single);
begin
  FStream.Write(Value, SizeOf(Value));
end;

procedure TBinaryWriter.Write(Value: Int64);
begin
  FStream.Write(Value, SizeOf(Value));
end;

procedure TBinaryWriter.Write(const Value: TBytes; Index, Count: Integer);
begin
  FStream.WriteBuffer(Value, Count);
end;

procedure TBinaryWriter.Write(const Value: TBytes);
begin
  FStream.WriteBuffer(Value, Length(Value));
end;

procedure TBinaryWriter.Write(const Value: TCharArray; Index, Count: Integer);
var
  Bytes: TBytes;
begin
//  Bytes := FEncoding.GetBytes(Value, Index, Count);
  FStream.WriteBuffer(Bytes, Length(Bytes));
end;

procedure TBinaryWriter.Write(Value: UInt64);
begin
  FStream.Write(Value, SizeOf(Value));
end;

procedure TBinaryWriter.Write(Value: Double);
begin
  FStream.Write(Value, SizeOf(Value));
end;

procedure TBinaryWriter.Write(Value: SmallInt);
begin
  FStream.Write(Value, SizeOf(Value));
end;

procedure TBinaryWriter.Write(Value: Integer);
begin
  FStream.Write(Value, SizeOf(Value));
end;

procedure TBinaryWriter.Write(Value: Cardinal);
begin
  FStream.Write(Value, SizeOf(Value));
end;

procedure TBinaryWriter.Write(Value: Word);
begin
  FStream.Write(Value, SizeOf(Value));
end;

procedure TBinaryWriter.Write(Value: ShortInt);
begin
  FStream.Write(Value, SizeOf(Value));
end;

procedure TBinaryWriter.Write7BitEncodedInt(Value: Integer);
begin
  repeat
    if Value > $7f then
      Write(Byte((Value and $7f) or $80))
    else
      Write(Byte(Value));
    Value := Value shr 7;
  until Value = 0;
end;

end.
