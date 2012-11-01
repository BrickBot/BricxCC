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
unit uSrcSinc;

interface

uses
  uSrcCommon;

function sinc_set_converter(psrc : PSRC_PRIVATE; src_enum : integer) : integer;
function sinc_get_name(src_enum : integer) : string;
function sinc_get_description(src_enum : integer) : string;

implementation

uses
  SysUtils, Math;

function SINC_MAGIC_MARKER : integer;
begin
  Result := MAKE_MAGIC(' ', 's', 'i', 'n', 'c', ' ');
end;

type
  fixedpoint = Integer;

const
  SHIFT_BITS = 16;
  FP_ONE = (Integer(1) shl SHIFT_BITS) * 1.0;

function DOUBLE_TO_FP(x : Double) : fixedpoint;
begin
  Result := Round(x * FP_ONE);
end;

function INT_TO_FP(x : Integer) : fixedpoint;
begin
  Result := x shl SHIFT_BITS;
end;

function FP_FRACTION_PART(x : fixedpoint) : Integer;
begin
  Result := x and ((Integer(1) shl SHIFT_BITS) - 1);
end;

function FP_INTEGER_PART(x : fixedpoint) : Integer;
begin
  Result := x and (Integer(-1) shl SHIFT_BITS);
end;

function FP_TO_INT(x : fixedpoint) : Integer;
begin
  Result := x shr SHIFT_BITS;
end;

function FP_TO_DOUBLE(x : fixedpoint) : Double;
begin
  Result := FP_FRACTION_PART(x) / FP_ONE;
end;

const
	STATE_BUFFER_START	= 101;
	STATE_DATA_CONTINUE	= 102;
	STATE_BUFFER_END	  = 103;
	STATE_FINISHED      = 104;

type
  PSINC_FILTER = ^SINC_FILTER;
  SINC_FILTER = record
    sinc_magic_marker : integer;
    channels : integer;
    in_count : integer;
    in_used : integer;
    out_count : integer;
    out_gen : integer;
    coeff_half_len : integer;
    index_inc : integer;
    has_diffs : boolean;
    src_ratio : double;
    input_index : double;
    coeff_len : integer;
    coeffs : PDouble;
    b_current : integer;
    b_end : integer;
    b_real_end : integer;
    b_len : integer;
    buffer : PDouble;
  end;

{$I 'HighQualCoeff.inc'}

{$I 'MidQualCoeff.inc'}

{$I 'FastestCoeff.inc'}

function fmod(Const aX, aY: Extended): Extended;
begin
  if (aY <= 0) then
    Result := 0
  else
    Result := aX-aY*Floor(aX/aY);
end;

procedure prepare_data(filter : PSINC_FILTER; data : PSRC_DATA;
  half_filter_chan_len : integer);
var
  len : integer;
begin
	if filter^.b_real_end >= 0 then
		Exit;	(* This doesn't make sense, so return. *)

	if filter^.b_current = 0 then
  begin
		(* Initial state. Set up zeros at the start of the buffer and
		** then load new data after that.
		*)
		len := filter^.b_len - (2 * half_filter_chan_len);
    
		filter^.b_current := half_filter_chan_len;
    filter^.b_end     := half_filter_chan_len;
	end
	else if (filter^.b_end + half_filter_chan_len + filter^.channels) < filter^.b_len then
  begin
	  (*  Load data at current end position. *)
		len := Max(filter^.b_len - filter^.b_current - half_filter_chan_len, 0);
  end
	else
	begin
  	(* Move data at end of buffer back to the start of the buffer. *)
		len := filter^.b_end - filter^.b_current;
    Move(Pointer(PChar(filter^.buffer) + (SizeOf(Double)*(filter^.b_current - half_filter_chan_len)))^,
         filter^.buffer^,
         (half_filter_chan_len + len) * SizeOf(Double));

		filter^.b_current := half_filter_chan_len;
		filter^.b_end     := filter^.b_current + len;

		(* Now load data at current end of buffer. *)
		len := Max(filter^.b_len - filter^.b_current - half_filter_chan_len, 0);
  end;

	len := Min(filter^.in_count - filter^.in_used, len);
	len := len - (len mod filter^.channels);

  Move(Pointer(PChar(data^.data_in) + (SizeOf(Double)*filter^.in_used))^,
       Pointer(PChar(filter^.buffer) + (SizeOf(Double)*filter^.b_end))^,
       len * SizeOf(Double));

	filter^.b_end   := filter^.b_end + len;
	filter^.in_used := filter^.in_used + len;

	if (filter^.in_used = filter^.in_count) and
		 ((filter^.b_end - filter^.b_current) < (2 * half_filter_chan_len)) and
     (data^.end_of_input <> 0) then
  begin
		(* Handle the case where all data in the current buffer has been
		** consumed and this is the last buffer.
		*)

		if (filter^.b_len - filter^.b_end) < (half_filter_chan_len + 5) then
		begin
    	(* If necessary, move data down to the start of the buffer. *)
			len := filter^.b_end - filter^.b_current;
      Move(Pointer(PChar(filter^.buffer) + (SizeOf(Double)*(filter^.b_current - half_filter_chan_len)))^,
           filter^.buffer^,
           (half_filter_chan_len + len) * SizeOf(Double));

			filter^.b_current := half_filter_chan_len;
			filter^.b_end     := filter^.b_current + len;
		end;

		filter^.b_real_end := filter^.b_end;
		len := half_filter_chan_len + 5;

    FillChar(Pointer(PChar(filter^.buffer) + (SizeOf(Double)*filter^.b_end))^, len*SizeOf(Double), 0);
		filter^.b_end := filter^.b_end + len;
  end;
end;

function calc_output(filter : PSINC_FILTER; increment, start_filter_index, ch : integer) : Double;
var
  fraction, left, right, icoeff : double;
  filter_index, max_filter_index : integer;
  data_index, coeff_count, indx : integer;
  p, q : PChar;
begin
	(* Convert input parameters into fixed point. *)
	max_filter_index := INT_TO_FP(filter^.coeff_half_len);

	(* First apply the left half of the filter. *)
	filter_index := start_filter_index;
	coeff_count  := (max_filter_index - filter_index) div increment;
	filter_index := filter_index + coeff_count * increment;
	data_index   := filter^.b_current - filter^.channels * coeff_count;

	left := 0.0;
	repeat
		fraction := FP_TO_DOUBLE(filter_index);
		indx := FP_TO_INT(filter_index);

    p := PChar(filter^.coeffs);
    inc(p, SizeOf(Double)*indx);
    q := p;
    inc(q, SizeOf(Double)*1);
		icoeff := PDouble(p)^ + fraction * (PDouble(q)^ - PDouble(p)^);

    p := PChar(filter^.buffer);
    inc(p, SizeOf(Double)*(data_index + ch));
		left := left + (icoeff * PDouble(p)^);

		filter_index := filter_index - increment;
		data_index := data_index + filter^.channels;
	until (filter_index < 0);

	(* Now apply the right half of the filter. *)
	filter_index := increment - start_filter_index;
	coeff_count  := (max_filter_index - filter_index) div increment;
	filter_index := filter_index + coeff_count * increment;
	data_index   := filter^.b_current + filter^.channels * (1 + coeff_count);

	right := 0.0;
	repeat
		fraction := FP_TO_DOUBLE(filter_index);
		indx := FP_TO_INT(filter_index);

    p := PChar(filter^.coeffs);
    inc(p, SizeOf(Double)*indx);
    q := p;
    inc(q, SizeOf(Double)*1);
		icoeff := PDouble(p)^ + fraction * (PDouble(q)^ - PDouble(p)^);

    p := PChar(filter^.buffer);
    inc(p, SizeOf(Double)*(data_index + ch));
		right := right + (icoeff * PDouble(p)^);

		filter_index := filter_index - increment;
		data_index := data_index - filter^.channels;
	until (filter_index <= 0);

	Result := (left + right);
end;

function sinc_process(psrc : PSRC_PRIVATE; data : PSRC_DATA) : integer;
var
  filter : PSINC_FILTER;
  input_index, src_ratio, count, float_increment, terminate, rem : Double;
  increment, start_filter_index : integer;
  half_filter_chan_len, samples_in_hand, ch : integer;
  p : PChar;
begin
	if psrc^.private_data = nil then
  begin
		Result := SRC_ERR_NO_PRIVATE;
    Exit;
  end;

	filter := PSINC_FILTER(psrc^.private_data);

	filter^.in_count  := data^.input_frames * filter^.channels;
	filter^.out_count := data^.output_frames * filter^.channels;
	filter^.in_used   := 0;
  filter^.out_gen   := 0;

	src_ratio := psrc^.last_ratio;

	(* Check the sample rate ratio wrt the buffer len. *)
	count := (filter^.coeff_half_len + 2.0) / filter^.index_inc;
	if Min(psrc^.last_ratio, data^.src_ratio) < 1.0 then
		count := count / Min(psrc^.last_ratio, data^.src_ratio);

	(* Maximum coefficientson either side of center point. *)
	half_filter_chan_len := filter^.channels * (Round(count) + 1);

	input_index := psrc^.last_position;
//	float_increment := filter^.index_inc;

	rem := fmod(input_index, 1.0);
	filter^.b_current := (filter^.b_current + filter^.channels * Round(input_index - rem)) mod filter^.b_len;
	input_index := rem;

	terminate := 1.0 / src_ratio + 1e-20;

	(* Main processing loop. *)
	while (filter^.out_gen < filter^.out_count) do
  begin
		(* Need to reload buffer? *)
		samples_in_hand := (filter^.b_end - filter^.b_current + filter^.b_len) mod filter^.b_len;

		if samples_in_hand <= half_filter_chan_len then
    begin
		  prepare_data(filter, data, half_filter_chan_len);

			samples_in_hand := (filter^.b_end - filter^.b_current + filter^.b_len) mod filter^.b_len;
			if samples_in_hand <= half_filter_chan_len then
				Break;
    end;

		(* This is the termination condition. *)
		if filter^.b_real_end >= 0 then
    begin
		  if (filter^.b_current + input_index + terminate) >= filter^.b_real_end then
				Break;
		end;

		if abs(psrc^.last_ratio - data^.src_ratio) > 1e-10 then
			src_ratio := psrc^.last_ratio +
        (filter^.out_gen * (data^.src_ratio - psrc^.last_ratio) / (filter^.out_count - 1));

		float_increment := filter^.index_inc * 1.0;
		if src_ratio < 1.0 then
			float_increment := filter^.index_inc * src_ratio;

		increment := DOUBLE_TO_FP(float_increment);

		start_filter_index := DOUBLE_TO_FP(input_index * float_increment);

    for ch := 0 to filter^.channels - 1 do
    begin
      p := Pointer(data^.data_out);
      inc(p, SizeOf(Double)*filter^.out_gen);
      // data^.data_out[filter^.out_gen] = ...;
      PDouble(p)^ := (float_increment / filter^.index_inc) *
        calc_output(filter, increment, start_filter_index, ch);
      inc(filter^.out_gen);
    end;

		(* Figure out the next index. *)
		input_index := input_index + (1.0 / src_ratio);
		rem := fmod(input_index, 1.0);

		filter^.b_current := (filter^.b_current + filter^.channels * Round(input_index - rem)) mod filter^.b_len;
		input_index := rem;
	end;

	psrc^.last_position := input_index;

	(* Save current ratio rather then target ratio. *)
	psrc^.last_ratio := src_ratio;

	data^.input_frames_used := filter^.in_used div filter^.channels;
	data^.output_frames_gen := filter^.out_gen div filter^.channels;

	Result := SRC_ERR_NO_ERROR;
end;

procedure sinc_reset(psrc : PSRC_PRIVATE);
var
  filter : PSINC_FILTER;
begin
	filter := PSINC_FILTER(psrc^.private_data);
	if filter = nil then
		Exit;

	filter^.b_current   := 0;
  filter^.b_end       := 0;
	filter^.b_real_end  := -1;
	filter^.src_ratio   := 0.0;
  filter^.input_index := 0.0;

  FillChar(filter^.buffer^, SizeOf(Double)*filter^.b_len, 0);

	(* Set this for a sanity check *)
  FillChar(Pointer(PChar(filter^.buffer)+(SizeOf(Double)*filter^.b_len))^, SizeOf(Double)*filter^.channels, $AA);
end;

function sinc_set_converter(psrc : PSRC_PRIVATE; src_enum : integer) : integer;
var
  filter : PSINC_FILTER;
  temp_filter : SINC_FILTER;
  count, bits : integer;
begin
  if SHIFT_BITS >= (SizeOf(integer) * 8 - 1) then
  begin
    Result := SRC_ERR_SHIFT_BITS;
    Exit;
  end;
  if psrc^.private_data <> nil then
  begin
    filter := PSINC_FILTER(psrc^.private_data);
    if filter^.sinc_magic_marker <> SINC_MAGIC_MARKER then
    begin
      FreeMem(psrc^.private_data);
      psrc^.private_data := nil;
    end;
  end;
  FillChar(temp_filter, SizeOf(SINC_FILTER), 0);
  temp_filter.sinc_magic_marker := SINC_MAGIC_MARKER;
  temp_filter.channels := psrc^.channels;
  psrc^.process := @sinc_process;
  psrc^.reset   := @sinc_reset;

  case src_enum of
    SRC_SINC_BEST_QUALITY : begin
      temp_filter.coeffs := @high_qual_coeffs[0];
      temp_filter.coeff_half_len := high_qual_coeffs_half_len;
      temp_filter.index_inc := 128;
      temp_filter.has_diffs := false;
      temp_filter.coeff_len := high_qual_coeffs_half_len + 1;
    end;
    SRC_SINC_MEDIUM_QUALITY : begin
      temp_filter.coeffs := @mid_qual_coeffs[0];
      temp_filter.coeff_half_len := mid_qual_coeffs_half_len;
      temp_filter.index_inc := 128;
      temp_filter.has_diffs := false;
      temp_filter.coeff_len := mid_qual_coeffs_half_len + 1;
    end;
    SRC_SINC_FASTEST : begin
      temp_filter.coeffs := @fastest_coeffs[0];
      temp_filter.coeff_half_len := fastest_coeffs_half_len;
      temp_filter.index_inc := 128;
      temp_filter.has_diffs := false;
      temp_filter.coeff_len := fastest_coeffs_half_len + 1;
    end;
  else
    Result := SRC_ERR_BAD_CONVERTER;
    Exit;
  end;

	(*
	** FIXME : This needs to be looked at more closely to see if there is
	** a better way. Need to look at prepare_data () at the same time.
	*)

	temp_filter.b_len := 1000 + 2 * Round(0.5 + temp_filter.coeff_len / (temp_filter.index_inc * 1.0) * SRC_MAX_RATIO);
	temp_filter.b_len := temp_filter.b_len * temp_filter.channels;

  filter := AllocMem(SizeOf(SINC_FILTER));
  if filter = nil then
  begin
    Result := SRC_ERR_MALLOC_FAILED;
    Exit;
  end;
  temp_filter.buffer := AllocMem(SizeOf(Double)*(temp_filter.b_len + temp_filter.channels));
  if temp_filter.buffer = nil then
  begin
    Result := SRC_ERR_MALLOC_FAILED;
    Exit;
  end;

  filter^ := temp_filter;
  FillChar(temp_filter, SizeOf(SINC_FILTER), $EE);

	psrc^.private_data := filter;

	sinc_reset(psrc);

	count := filter^.coeff_half_len;
  bits := 0;
  while (1 shl bits) < count do
  begin
    count := count or (1 shl bits);
    inc(bits);
  end;

  if (bits + SHIFT_BITS - 1) >= (SizeOf(Integer) * 8) then
  begin
    Result := SRC_ERR_FILTER_LEN;
    Exit;
  end;

	Result := SRC_ERR_NO_ERROR;
end;

function sinc_get_name(src_enum : integer) : string;
begin
	case src_enum of
	  SRC_SINC_BEST_QUALITY   : Result := 'Best Sinc Interpolator';
		SRC_SINC_MEDIUM_QUALITY : Result := 'Medium Sinc Interpolator';
		SRC_SINC_FASTEST        : Result := 'Fastest Sinc Interpolator';
  else
    Result := '';
  end;
end;

function sinc_get_description(src_enum : integer) : string;
begin
	case src_enum of
	  SRC_SINC_BEST_QUALITY   : Result := 'Band limited sinc interpolation, best quality, 97dB SNR, 96% BW.';
		SRC_SINC_MEDIUM_QUALITY : Result := 'Band limited sinc interpolation, medium quality, 97dB SNR, 90% BW.';
		SRC_SINC_FASTEST        : Result := 'Band limited sinc interpolation, fastest, 97dB SNR, 80% BW.';
  else
    Result := '';
  end;
end;

end.