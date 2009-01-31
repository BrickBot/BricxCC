unit uSrcZoh;

interface

uses
  uSrcCommon;

function zoh_set_converter(psrc : PSRC_PRIVATE; src_enum : integer) : integer;
function zoh_get_name(src_enum : integer) : string;
function zoh_get_description(src_enum : integer) : string;

implementation

uses
  SysUtils, Math;

type
  PZOH_DATA = ^ZOH_DATA;
  ZOH_DATA = record
    zoh_magic_marker : integer;
    channels : integer;
    in_count : integer;
    in_used : integer;
    out_count : integer;
    out_gen : integer;
    last_value : PDouble;
  end;

function ZOH_MAGIC_MARKER : integer;
begin
  Result := MAKE_MAGIC('s', 'r', 'c', 'z', 'o', 'h');
end;

function zoh_get_name(src_enum : integer) : string;
begin
	case src_enum of
	  SRC_ZERO_ORDER_HOLD : Result := 'ZOH Interpolator';
  else
    Result := '';
  end;
end;

function zoh_get_description(src_enum : integer) : string;
begin
	case src_enum of
	  SRC_ZERO_ORDER_HOLD : Result := 'Zero order hold interpolator, very fast, poor quality.';
  else
    Result := '';
  end;
end;

function zoh_process(psrc : PSRC_PRIVATE; data : PSRC_DATA) : integer;
var
  zoh : PZOH_DATA;
  src_ratio, input_index : double;
  ch : integer;
  p, q : PChar;
begin
  if psrc^.private_data = nil then
  begin
    Result := SRC_ERR_NO_PRIVATE;
    Exit;
  end;
  zoh := PZOH_DATA(psrc^.private_data);
  zoh^.in_count := data^.input_frames * zoh^.channels;
  zoh^.out_count := data^.output_frames * zoh^.channels;
  zoh^.in_used := 0;
  zoh^.out_gen := 0;
  src_ratio := psrc^.last_ratio;
  input_index := psrc^.last_position;
  // calculate samples before first sample in input array.
  while (input_index < 1.0) and (zoh^.out_gen < zoh^.out_count) do
  begin
    if (zoh^.in_used + (zoh^.channels * input_index)) > zoh^.in_count then
      Break;
    if abs(psrc^.last_ratio - data^.src_ratio) > SRC_MIN_RATIO_DIFF then
      src_ratio := psrc^.last_ratio + (zoh^.out_gen * (data^.src_ratio - psrc^.last_ratio) / (zoh^.out_count - 1));
    for ch := 0 to zoh^.channels - 1 do
    begin
      p := Pointer(data^.data_out);
      inc(p, SizeOf(Double)*zoh^.out_gen);
      q := Pointer(zoh^.last_value);
      inc(q, SizeOf(Double)*ch);
      PDouble(p)^ := PDouble(q)^;
      inc(zoh^.out_gen);
    end;
    // figure out the next index
    input_index := input_index + (1.0 / src_ratio);
  end;
  zoh^.in_used := zoh^.in_used + (zoh^.channels * floor(input_index));
  input_index := input_index - floor(input_index);
  // main processing loop
  while (zoh^.out_gen < zoh^.out_count) and
        ((zoh^.in_used + zoh^.channels * input_index) <= zoh^.in_count) do
  begin
    if abs(psrc^.last_ratio - data^.src_ratio) > SRC_MIN_RATIO_DIFF then
      src_ratio := psrc^.last_ratio + (zoh^.out_gen * (data^.src_ratio - psrc^.last_ratio) / (zoh^.out_count - 1));
    for ch := 0 to zoh^.channels - 1 do
    begin
      p := Pointer(data^.data_out);
      inc(p, SizeOf(Double)*zoh^.out_gen);
      q := Pointer(data^.data_in);
      inc(q, SizeOf(Double)*(zoh^.in_used - zoh^.channels + ch));
      PDouble(p)^ := PDouble(q)^;
      inc(zoh^.out_gen);
    end;
    // figure out the next index
    input_index := input_index + (1.0 / src_ratio);
    zoh^.in_used := zoh^.in_used + (zoh^.channels * floor(input_index));
    input_index := input_index - floor(input_index);
  end;
  if zoh^.in_used > zoh^.in_count then
  begin
    input_index := input_index + (zoh^.in_used - zoh^.in_count);
    zoh^.in_used := zoh^.in_count;
  end;
  psrc^.last_position := input_index;
  if zoh^.in_used > 0 then
  begin
    for ch := 0 to zoh^.channels - 1 do
    begin
      p := Pointer(zoh^.last_value);
      inc(p, SizeOf(Double)*ch);
      q := Pointer(data^.data_in);
      inc(q, SizeOf(Double)*(zoh^.in_used - zoh^.channels + ch));
      PDouble(p)^ := PDouble(q)^;
    end;
  end;
  // save current ratio rather than target ratio
  psrc^.last_ratio := src_ratio;
  data^.input_frames_used := zoh^.in_used div zoh^.channels;
  data^.output_frames_gen := zoh^.out_gen div zoh^.channels;
  Result := SRC_ERR_NO_ERROR;
end;

procedure zoh_reset(psrc : PSRC_PRIVATE);
var
  zoh : PZOH_DATA;
begin
  zoh := nil;
  zoh := PZOH_DATA(psrc^.private_data);
  if zoh = nil then
    Exit;
  FillChar(zoh^.last_value^, SizeOf(Double) * zoh^.channels, 0);
end;

function zoh_set_converter(psrc : PSRC_PRIVATE; src_enum : integer) : integer;
var
  zoh : PZOH_DATA;
begin
  zoh := nil;
  if src_enum <> SRC_ZERO_ORDER_HOLD then
  begin
    Result := SRC_ERR_BAD_CONVERTER;
    Exit;
  end;
  if psrc^.private_data <> nil then
  begin
    zoh := PZOH_DATA(psrc^.private_data);
    if zoh^.zoh_magic_marker <> ZOH_MAGIC_MARKER then
    begin
      FreeMem(psrc^.private_data);
      psrc^.private_data := nil;
    end;
  end;
  if psrc^.private_data = nil then
  begin
    zoh := AllocMem(SizeOf(ZOH_DATA));
    if zoh = nil then
    begin
      Result := SRC_ERR_MALLOC_FAILED;
      Exit;
    end;
    zoh^.last_value := AllocMem(SizeOf(Double)*psrc^.channels);
    psrc^.private_data := zoh;
  end;
  zoh^.zoh_magic_marker := ZOH_MAGIC_MARKER;
  zoh^.channels := psrc^.channels;
  psrc^.process := @zoh_process;
  psrc^.reset   := @zoh_reset;
  zoh_reset(psrc);
  Result := SRC_ERR_NO_ERROR;
end;

end.
