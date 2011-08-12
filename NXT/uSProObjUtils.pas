unit uSProObjUtils;

interface

uses
  Classes;

function SProBinToObjStr(aStream : TStream) : string;
procedure SProBinToObj(inStream, outStream : TStream);
procedure SProObjToBin(inStream, outStream : TStream);
procedure SProObjStrToBin(aObjStr : string; outStream : TStream);

implementation

uses
  SysUtils;

function SProBinToObjStr(aStream : TStream) : string;
var
  DL, AL1, AL2 : byte;
  BP : Word;
  I : integer;
begin
  Result := #13#10;
  // process the input stream and generate a .obj text string
  BP := 0;
  while BP < aStream.Size do
  begin
    DL := 0;
    // start to process the next line
    // line type is 0
    Result := Result + Format(':%2.2x%2.2x%2.2x%2.2x', [128, Hi(BP), Lo(BP), 0]);
    DL := DL + 128 + Hi(BP) + Lo(BP) + 0;
    for i := 0 to 63 do
    begin
      // process 128 bytes (2 at a time)
      if (BP + (i*2)) > aStream.Size then
      begin
        AL1 := $FF;
        AL2 := $FF;
      end
      else
      begin
        aStream.Read(AL1, 1);
        aStream.Read(AL2, 1);
      end;
      DL := DL + AL1 + AL2;
      // add AL1 and AL2 to the stream
      Result := Result + Format('%2.2x%2.2x', [AL1, AL2]);
    end;
    DL := 0 - DL;
    Result := Result + Format('%2.2x'#13#10, [DL]);
    inc(BP, 128);
    if (AL1 = $FF) and (AL2 = $FF) then
      break;
  end;
  Result := Result + ':00000001FF'#13#10#$1a;
end;

procedure SProBinToObj(inStream, outStream : TStream);
var
  objStr : string;
  tmp : TStringStream;
begin
  objStr := SProBinToObjStr(inStream);
  tmp := TStringStream.Create(objStr);
  try
    outStream.CopyFrom(tmp, 0);
    outStream.Position := 0; // reset the output stream back to the beginning
  finally
    tmp.Free;
  end;
end;

procedure SProObjToBin(inStream, outStream : TStream);
var
  AL : byte;
  I : integer;
  SL : TStringList;
  tmp, b1, b2 : string;
begin
  SL := TStringList.Create;
  try
    SL.LoadFromStream(inStream);
    for i := 0 to SL.Count - 1 do
    begin
      tmp := SL[i];
      if ((i = 0) and (tmp <> '')) or
         ((i = (SL.Count - 2)) and (tmp <> ':00000001FF')) or
         ((i = (SL.Count - 1)) and (tmp[1] <> #$1a)) then
        raise Exception.Create('Invalid object file format');
      if (tmp = '') or (tmp = ':00000001FF') or (tmp[1] = #$1a) then
        Continue;
      // each line in the obj file contains 128 bytes of binary program data
      // the line should start with :80XXXX00 (9 characters) that can be discarded
      System.Delete(tmp, 1, 9);
      // line has a checksum byte at the end which can be ignored (2 characters)
      System.Delete(tmp, Length(tmp)-1, 2);
      // length should be 256
      if Length(tmp) <> 256 then
        raise Exception.Create('Invalid object file format');
      while tmp <> '' do
      begin
        b1 := Copy(tmp, 1, 2);
        b2 := Copy(tmp, 3, 2);
        System.Delete(tmp, 1, 4);
        if (b1 = 'FF') and (b2 = 'FF') then
          break;
        AL := StrToIntDef('$'+b1, $FF);
        outStream.Write(AL, 1);
        AL := StrToIntDef('$'+b2, $FF);
        outStream.Write(AL, 1);
      end;
    end;
  finally
    SL.Free;
  end;
end;

procedure SProObjStrToBin(aObjStr : string; outStream : TStream);
var
  tmp : TStringStream;
begin
  tmp := TStringStream.Create(aObjStr);
  try
    SProObjToBin(tmp, outStream);
    outStream.Position := 0; // reset the output stream back to the beginning
  finally
    tmp.Free;
  end;
end;

end.
