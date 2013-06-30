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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uSrcLinear;

interface

uses
  uSrcCommon;

function linear_set_converter(psrc : PSRC_PRIVATE; src_enum : integer) : integer;
function linear_get_name(src_enum : integer) : string;
function linear_get_description(src_enum : integer) : string;

implementation

uses
  SysUtils, Math;

type
  PLINEAR_DATA = ^LINEAR_DATA;
  LINEAR_DATA = record
    linear_magic_marker : integer;
    channels : integer;
    in_count : integer;
    in_used : integer;
    out_count : integer;
    out_gen : integer;
    last_value : PDouble;
  end;

function LINEAR_MAGIC_MARKER : integer;
begin
  Result := MAKE_MAGIC('l', 'i', 'n', 'e', 'a', 'r');
end;

function linear_get_name(src_enum : integer) : string;
begin
	case src_enum of
	  SRC_LINEAR : Result := 'Linear Interpolator';
  else
    Result := '';
  end;
end;

function linear_get_description(src_enum : integer) : string;
begin
	case src_enum of
	  SRC_LINEAR : Result := 'Linear interpolator, very fast, poor quality.';
  else
    Result := '';
  end;
end;

function linear_process(psrc : PSRC_PRIVATE; data : PSRC_DATA) : integer;
var
  linear : PLINEAR_DATA;
  src_ratio, input_index, d1, d2 : double;
  ch : integer;
  p, q : PChar;
begin
  if psrc^.private_data = nil then
  begin
    Result := SRC_ERR_NO_PRIVATE;
    Exit;
  end;
  linear := PLINEAR_DATA(psrc^.private_data);
  linear^.in_count := data^.input_frames * linear^.channels;
  linear^.out_count := data^.output_frames * linear^.channels;
  linear^.in_used := 0;
  linear^.out_gen := 0;
  src_ratio := psrc^.last_ratio;
  input_index := psrc^.last_position;
  // calculate samples before first sample in input array.
  while (input_index < 1.0) and (linear^.out_gen < linear^.out_count) do
  begin
    if (linear^.in_used + (linear^.channels * input_index)) > linear^.in_count then
      Break;
    if abs(psrc^.last_ratio - data^.src_ratio) > SRC_MIN_RATIO_DIFF then
      src_ratio := psrc^.last_ratio + (linear^.out_gen * (data^.src_ratio - psrc^.last_ratio) / (linear^.out_count - 1));
    for ch := 0 to linear^.channels - 1 do
    begin
      p := Pointer(data^.data_out);
      inc(p, SizeOf(Double)*linear^.out_gen);
      q := Pointer(linear^.last_value);
      inc(q, SizeOf(Double)*ch);
      d1 := PDouble(q)^;
      q := Pointer(data^.data_in);
      inc(q, SizeOf(Double)*ch);
      d2 := PDouble(q)^;
      PDouble(p)^ := d1 + (input_index * (d2 - d1));
      inc(linear^.out_gen);
    end;
    // figure out the next index
    input_index := input_index + (1.0 / src_ratio);
  end;
  linear^.in_used := linear^.in_used + (linear^.channels * floor(input_index));
  input_index := input_index - floor(input_index);
  // main processing loop
  while (linear^.out_gen < linear^.out_count) and
        ((linear^.in_used + linear^.channels * input_index) <= linear^.in_count) do
  begin
    if abs(psrc^.last_ratio - data^.src_ratio) > SRC_MIN_RATIO_DIFF then
      src_ratio := psrc^.last_ratio + (linear^.out_gen * (data^.src_ratio - psrc^.last_ratio) / (linear^.out_count - 1));
    for ch := 0 to linear^.channels - 1 do
    begin
      p := Pointer(data^.data_out);
      inc(p, SizeOf(Double)*linear^.out_gen);
      q := Pointer(data^.data_in);
      inc(q, SizeOf(Double)*(linear^.in_used - linear^.channels + ch));
      d1 := PDouble(q)^;
      q := Pointer(data^.data_in);
      inc(q, SizeOf(Double)*(linear^.in_used + ch));
      d2 := PDouble(q)^;
      PDouble(p)^ := d1 + (input_index * (d2 - d1));
      inc(linear^.out_gen);
    end;
    // figure out the next index
    input_index := input_index + (1.0 / src_ratio);
    linear^.in_used := linear^.in_used + (linear^.channels * floor(input_index));
    input_index := input_index - floor(input_index);
  end;
  if linear^.in_used > linear^.in_count then
  begin
    input_index := input_index + (linear^.in_used - linear^.in_count);
    linear^.in_used := linear^.in_count;
  end;
  psrc^.last_position := input_index;
  if linear^.in_used > 0 then
  begin
    for ch := 0 to linear^.channels - 1 do
    begin
      p := Pointer(linear^.last_value);
      inc(p, SizeOf(Double)*ch);
      q := Pointer(data^.data_in);
      inc(q, SizeOf(Double)*(linear^.in_used - linear^.channels + ch));
      PDouble(p)^ := PDouble(q)^;
    end;
  end;
  // save current ratio rather than target ratio
  psrc^.last_ratio := src_ratio;
  data^.input_frames_used := linear^.in_used div linear^.channels;
  data^.output_frames_gen := linear^.out_gen div linear^.channels;
  Result := SRC_ERR_NO_ERROR;
end;

procedure linear_reset(psrc : PSRC_PRIVATE);
var
  linear : PLINEAR_DATA;
begin
  linear := nil;
  linear := PLINEAR_DATA(psrc^.private_data);
  if linear = nil then
    Exit;
  FillChar(linear^.last_value^, SizeOf(Double) * linear^.channels, 0);
end;

function linear_set_converter(psrc : PSRC_PRIVATE; src_enum : integer) : integer;
var
  linear : PLINEAR_DATA;
begin
  linear := nil;
  if src_enum <> SRC_LINEAR then
  begin
    Result := SRC_ERR_BAD_CONVERTER;
    Exit;
  end;
  if psrc^.private_data <> nil then
  begin
    linear := PLINEAR_DATA(psrc^.private_data);
    if linear^.linear_magic_marker <> LINEAR_MAGIC_MARKER then
    begin
      FreeMem(psrc^.private_data);
      psrc^.private_data := nil;
    end;
  end;
  if psrc^.private_data = nil then
  begin
    linear := AllocMem(SizeOf(LINEAR_DATA));
    if linear = nil then
    begin
      Result := SRC_ERR_MALLOC_FAILED;
      Exit;
    end;
    linear^.last_value := AllocMem(SizeOf(Double)*psrc^.channels);
    psrc^.private_data := linear;
  end;
  linear^.linear_magic_marker := LINEAR_MAGIC_MARKER;
  linear^.channels := psrc^.channels;
  psrc^.process := @linear_process;
  psrc^.reset   := @linear_reset;
  linear_reset(psrc);
  Result := SRC_ERR_NO_ERROR;
end;

end.