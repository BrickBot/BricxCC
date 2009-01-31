unit srecord;

interface

uses
  Windows, sysutils;

type
  TSRecClass = class
  private
    fLength : integer;
    fStart : integer;
    fData : PByte;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    function GetLength : integer;
    function GetStart : integer;
    function GetData : PByte;
    function Read(var F : TextFile; maxLength : Integer; numimage_def : integer = 2) : boolean;

	  class function ReadHexByte(const ptr : PChar) : integer;
  end;

implementation

{ TSRecClass }

const
  kMaxLine = 256;

constructor TSRecClass.Create;
begin
  inherited Create;
  fLength := 0;
  fStart  := 0;
  fData   := nil;
end;

destructor TSRecClass.Destroy;
begin
  if fData <> nil then
    FreeMem(fData, fLength);
  inherited Destroy;
end;

function TSRecClass.GetData: PByte;
begin
  result := fData;
end;

function TSRecClass.GetLength: integer;
begin
  result := fLength;
end;

function TSRecClass.GetStart: integer;
begin
  result := fStart;
end;

const
  BUFFERSIZE      = 4096;
  RETRIES         = 5;
  WAKEUP_TIMEOUT  = 4000;
  IMAGE_START     = $8000;
  IMAGE_MAXLEN    = $8000;
  TRANSFER_SIZE   = 200;
  SEGMENT_BREAK	  = 1024;
  SREC_DATA_SIZE  = 80;

  SREC_OK              =  0;
  SREC_NULL            = -1;
  SREC_INVALID_HDR     = -2;
  SREC_INVALID_CHAR    = -3;
  SREC_INVALID_TYPE    = -4;
  SREC_TOO_SHORT       = -5;
  SREC_TOO_LONG        = -6;
  SREC_INVALID_LEN     = -7;
  SREC_INVALID_CKSUM   = -8;

type
  PSegment = ^TSegment;
  TSegment = record
    length : integer;
    offset : integer;
  end;

  TSRecImage = record
    entry : word;
    segments : PSegment;
  end;

  TSRec = record
    type_ : Byte;
    addr : integer;
    count : Byte;
    data : array[0..SREC_DATA_SIZE-1] of Byte;
  end;

const
  ctab : array[Byte] of Byte = (
    255,255,255,255,255,255,255,255,  255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255,  255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255,  255,255,255,255,255,255,255,255,
      0,  1,  2,  3,  4,  5,  6,  7,    8,  9,255,255,255,255,255,255,
    255, 10, 11, 12, 13, 14, 15,255,  255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255,  255,255,255,255,255,255,255,255,
    255, 10, 11, 12, 13, 14, 15,255,  255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255,  255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255,  255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255,  255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255,  255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255,  255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255,  255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255,  255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255,  255,255,255,255,255,255,255,255,
    255,255,255,255,255,255,255,255,  255,255,255,255,255,255,255,255
  );
  ltab : array[0..9] of Integer = (
    4,4,6,8,0,4,0,8,6,4
  );

function C1(l : PChar; p : Integer) : Byte;
var
  p2 : PChar;
begin
//#define C1(l,p)    (ctab[l[p]])
  p2 := l;
  Inc(p2, p);
  Result := ctab[Byte(p2^)];
end;

function C2(l : PChar; p : Integer) : Byte;
begin
//#define C2(l,p)    ((C1(l,p)<<4)|C1(l,p+1))
  Result := (C1(l, p) shl 4) or C1(l, p+1);
end;

function srec_decode(var srec : TSRec; _line : PChar) : Integer;
var
  len, pos, count, alen, sum : Integer;
  line, p2 : PChar;
  value : Byte;
begin
  sum := 0;
  line := _line;
  if (line = nil) then
  begin
    Result := SREC_NULL;
    Exit;
  end;

  len := 0;
  p2 := line;
  while p2 <> nil do
  begin
    if (p2^ = #13) or (p2^ = #10) or (p2^ = #0) then Break;
    Inc(len);
    Inc(p2);
  end;
  if (len < 4) or (line^ <> 'S') then
  begin
    Result := SREC_INVALID_HDR;
    Exit;
  end;

  for pos := 1 to len - 1 do begin
    if C1(line, pos) = $FF then
    begin
      Result := SREC_INVALID_CHAR;
      Exit;
    end;
  end;

  srec.type_ := C1(line, 1);
  count := C2(line, 2);

  if srec.type_ > 9 then
  begin
	  Result := SREC_INVALID_TYPE;
    Exit;
  end;
  alen := ltab[srec.type_];
  if alen = 0 then
  begin
	  Result := SREC_INVALID_TYPE;
    Exit;
  end;
  if len < (alen + 6) then
  begin
	  Result := SREC_TOO_SHORT;
    Exit;
  end;
  if count > (alen + SREC_DATA_SIZE + 2) then
  begin
	  Result := SREC_TOO_LONG;
    Exit;
  end;
  if len <> ((count * 2) + 4) then
  begin
	  Result := SREC_INVALID_LEN;
    Exit;
  end;

  Inc(sum, count);
  Dec(len, 4);
  Inc(line, 4);
  srec.addr := 0;
  pos := 0;
  while pos < alen do begin
    value := C2(line, pos);
    srec.addr := (srec.addr shl 8) or value;
    Inc(sum, value);
    Inc(pos, 2);
  end;

  Dec(len, alen);
  Inc(line, alen);
  pos := 0;
  while pos < (len - 2) do begin
    value := C2(line, pos);
    srec.data[pos div 2] := value;
    Inc(sum, value);
    Inc(pos, 2);
  end;

  srec.count := count - (alen div 2) - 1;
  Inc(sum, C2(line, pos));

  if ((sum and $ff) <> $ff) then
  begin
    Result := SREC_INVALID_CKSUM;
    Exit;
  end;

  Result := SREC_OK;
end;

function TSRecClass.Read(var F : TextFile; maxLength: LongInt; numimage_def : integer): boolean;
var
  line : array[0..kMaxLine-1] of Char;
  ptr : PChar;
  srec : TSRec;
  bStrip : Boolean;
  image_def : TSRecImage;
  segIndex, segStartAddr, prevCount, imageIndex : Integer;
  prevAddr : LongInt;
  segments : array[0..1] of TSegment;
  pSeg : PSegment;
begin
  image_def.entry := 0;
  image_def.segments := @segments[0];
  segStartAddr := 0;
  prevAddr := -SEGMENT_BREAK;
  prevCount := SEGMENT_BREAK;
  imageIndex := -SEGMENT_BREAK;
  segIndex := -1;
  bStrip := False;
  result := False;
  if fData <> nil then
    FreeMem(fData, fLength);

  fData := AllocMem(maxLength * sizeof(Byte));
  FillChar(fData^, maxLength * sizeof(Byte), #0);
	fLength := 0;

  while not Eof(F) do
  begin
    System.ReadLn(F, line);
		ptr := line;
    // hack for DOS line endings
		if (ptr^ = Chr(10)) or (ptr^ = Chr(13)) then
			inc(ptr);

		if ptr^ = Chr(0) then Continue;

		if ptr^ <> 'S' then Exit;

    if srec_decode(srec, ptr) <> SREC_OK then Exit;

    if srec.type_ = 0 then
    begin
      if (srec.count = 16) then
        if StrLComp(@srec.data[0], '?LIB_VERSION_L00', 16) = 0 then
          bStrip := true;
    end
		else if srec.type_ = 1 then
		begin
      if (srec.addr - prevAddr) >= SEGMENT_BREAK then
      begin
        Inc(segIndex);
        if segIndex >= numimage_def then Exit;

        pSeg := image_def.segments;
        Inc(pSeg, segIndex); // array offset

     // image_def.segments[segIndex].length := 0;
        pSeg^.length := 0;
        segStartAddr := srec.addr;
        prevAddr := srec.addr - prevCount;
     // image_def.segments[segIndex].length := 0;
        pSeg^.offset := imageIndex + prevCount;
      end;
      if (srec.addr < IMAGE_START) or ((srec.addr + srec.count) > (IMAGE_START + maxLength)) then
        Exit;
      // Data is not necessarily contiguous so can't just accumulate srec.counts.
      pSeg := image_def.segments;
      Inc(pSeg, segIndex); // array offset

   // image_def.segments[segIndex].length := srec.addr - segStartAddr + srec.count;
      pSeg^.length := srec.addr - segStartAddr + srec.count;
      imageIndex := imageIndex + srec.addr - prevAddr;

      // copy data from srec.data to fData
      System.Move(srec.Data, PByte(LongInt(fData) + imageIndex)^, srec.count);

      prevAddr := srec.addr;
      prevCount := srec.count;
		end
		else if srec.type_ = 9 then
		begin
      if (srec.addr < IMAGE_START) or (srec.addr > IMAGE_START + maxLength) then
        Exit;
      fStart := srec.addr;
      image_def.entry := srec.addr;
		end;
	end;
  if bStrip then
  begin
{
    for pos := maxLength - 1 downto 0 do
    begin
      if PByte(LongInt(fData) + pos)^ <> 0 then
        Break;
      pSeg := image_def.segments;
      Inc(pSeg, segIndex); // move to desired array item
      Dec(pSeg^.length);
    end;
}
  end;
  pSeg := image_def.segments;
  Inc(pSeg, segIndex); // array offset
  // image_len = image_def.segments[segIndex].offset+image_def.segments[segIndex].length;
  fLength := pSeg^.offset+pSeg^.length;
	result := true;
end;

class function TSRecClass.ReadHexByte(const ptr: PChar): integer;
var
  i, v, n : integer;
  c : Char;
  tmpP : PChar;
begin
  v := 0;
  tmpP := ptr;
  for i := 0 to 1 do
  begin
    c := tmpP^;
		inc(tmpP);

		if (c >= '0') and (c <= '9') then
    begin
			n := Ord(c) - Ord('0');
    end
		else if (c >= 'A') and (c <= 'F') then
    begin
			n := Ord(c) - Ord('A') + 10;
    end
		else if (c >= 'a') and (c <= 'f') then
    begin
			n := Ord(c) - Ord('a') + 10;
    end
		else
    begin
      result := -1;
      Exit;
    end;
		v := (v shl 4) + n;
	end;
	result := v;
end;

end.
