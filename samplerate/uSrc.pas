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
unit uSrc;

interface

uses
  uSrcCommon;

function src_new(converter_type : integer; channels : integer;
  error : PInteger) : PSRC_STATE;
function src_delete (state : PSRC_STATE) : PSRC_STATE;
function src_set_ratio(state : PSRC_STATE; new_ratio : double) : integer;
function src_reset(state : PSRC_STATE) : integer;

function src_get_name(converter_type : integer) : string;
function src_get_description(converter_type : integer) : string;
function src_get_version(converter_type : integer) : string;
function src_is_valid_ratio(ratio : double) : boolean;

function src_error(state : PSRC_STATE) : integer;
function src_strerror(error : integer) : string;

function src_simple(src_data : PSRC_DATA; converter, channels : integer) : integer;

implementation

uses
  SysUtils, uSrcZoh, uSrcLinear, uSrcSinc;

function psrc_set_converter(psrc : PSRC_PRIVATE; converter_type : integer) : integer;
begin
	if sinc_set_converter(psrc, converter_type) = SRC_ERR_NO_ERROR then
    Result := SRC_ERR_NO_ERROR
  else if zoh_set_converter(psrc, converter_type) = SRC_ERR_NO_ERROR then
    Result := SRC_ERR_NO_ERROR
  else if linear_set_converter(psrc, converter_type) = SRC_ERR_NO_ERROR then
		Result := SRC_ERR_NO_ERROR
  else
    Result := SRC_ERR_BAD_CONVERTER;
end;

function src_new(converter_type : integer; channels : integer;
  error : PInteger) : PSRC_STATE;
var
  psrc : PSRC_PRIVATE;
begin
  if error <> nil then
    error^ := SRC_ERR_NO_ERROR;
  if channels < 1 then
  begin
    if error <> nil then
      error^ := SRC_ERR_BAD_CHANNEL_COUNT;
    Result := nil;
    Exit;
  end;
  psrc := AllocMem(SizeOf(SRC_PRIVATE));
  if psrc = nil then
  begin
    if error <> nil then
      error^ := SRC_ERR_MALLOC_FAILED;
    Result := nil;
    Exit;
  end;

  psrc^.channels := channels;
  psrc^.mode := SRC_MODE_PROCESS;

  if psrc_set_converter(psrc, converter_type) <> SRC_ERR_NO_ERROR then
  begin
    if error <> nil then
      error^ := SRC_ERR_BAD_CONVERTER;
    FreeMem(psrc, SizeOf(SRC_PRIVATE));
    psrc := nil;
  end;

  src_reset(psrc);

  Result := psrc;
end;

function src_delete (state : PSRC_STATE) : PSRC_STATE;
var
  psrc : PSRC_PRIVATE;
begin
  psrc := PSRC_PRIVATE(state);
  if psrc <> nil then
  begin
    if psrc^.private_data <> nil then
      FreeMem(psrc^.private_data);
    // memset (psrc, 0, sizeof(SRC_PRIVATE));
    FreeMem(psrc);
  end;
  Result := nil;
end;

function src_process(state : PSRC_STATE; data : PSRC_DATA) : integer;
var
  psrc : PSRC_PRIVATE;
  p : PChar;
begin
  psrc := PSRC_PRIVATE(state);
  if psrc = nil then
  begin
    Result := SRC_ERR_BAD_STATE;
    Exit;
  end;
  if @psrc^.process = nil then
  begin
    Result := SRC_ERR_BAD_PROC_PTR;
    Exit;
  end;
  if psrc^.mode <> SRC_MODE_PROCESS then
  begin
    Result := SRC_ERR_BAD_MODE;
    Exit;
  end;
  // check for valid src_data first.
  if data = nil then
  begin
    Result := SRC_ERR_BAD_DATA;
    Exit;
  end;
  // check src_ration is in range.
  if (data^.src_ratio < (1.0 / SRC_MAX_RATIO)) or
     (data^.src_ratio > (1.0 * SRC_MAX_RATIO)) then
  begin
    Result := SRC_ERR_BAD_SRC_RATIO;
    Exit;
  end;
  // and that data_in and data_out are valid
  if (data^.data_in = nil) or (data^.data_out = nil) then
  begin
    Result := SRC_ERR_BAD_DATA_PTR;
    Exit;
  end;
  if data^.input_frames < 0 then
    data^.input_frames := 0;
  if data^.output_frames < 0 then
    data^.output_frames := 0;
  if PChar(data^.data_in) < PChar(data^.data_out) then
  begin
    p := PChar(data^.data_in);
    inc(p, data^.input_frames * psrc^.channels * SizeOf(Double));
    if p > PChar(data^.data_out) then
    begin
      Result := SRC_ERR_DATA_OVERLAP;
      Exit;
    end;
  end
  else
  begin
    p := PChar(data^.data_out);
    inc(p, data^.output_frames * psrc^.channels * SizeOf(Double));
    if p > PChar(data^.data_in) then
    begin
      Result := SRC_ERR_DATA_OVERLAP;
      Exit;
    end;
  end;
  // set the input and output counts to zero.
  data^.input_frames_used := 0;
  data^.output_frames_gen := 0;
  // special case for when last_ration has not been set.
  if psrc^.last_ratio < (1.0 / SRC_MAX_RATIO) then
    psrc^.last_ratio := data^.src_ratio;
  // now process
  Result := psrc^.process(psrc, data);
end;

function src_set_ratio(state : PSRC_STATE; new_ratio : double) : integer;
var
  psrc : PSRC_PRIVATE;
begin
  psrc := PSRC_PRIVATE(state);
  if psrc = nil then
  begin
    Result := SRC_ERR_BAD_STATE;
    Exit;
  end;
  if @psrc^.process = nil then
  begin
    Result := SRC_ERR_BAD_PROC_PTR;
    Exit;
  end;

	psrc^.last_ratio := new_ratio;

	Result := SRC_ERR_NO_ERROR;
end;

function src_reset(state : PSRC_STATE) : integer;
var
  psrc : PSRC_PRIVATE;
begin
  if state = nil then
  begin
    Result := SRC_ERR_BAD_STATE;
    Exit;
  end;
  psrc := PSRC_PRIVATE(state);

  if @psrc^.reset <> nil then
    psrc^.reset(psrc);

	psrc^.last_position := 0.0;
	psrc^.last_ratio    := 0.0;
	psrc^.error         := SRC_ERR_NO_ERROR;

	Result := SRC_ERR_NO_ERROR;
end;

function src_get_name(converter_type : integer) : string;
begin
  Result := sinc_get_name(converter_type);
  if Result <> '' then
     Exit;
  Result := zoh_get_name(converter_type);
  if Result <> '' then
     Exit;
  Result := linear_get_name(converter_type);
end;

function src_get_description(converter_type : integer) : string;
begin
  Result := sinc_get_description(converter_type);
  if Result <> '' then
     Exit;
  Result := zoh_get_description(converter_type);
  if Result <> '' then
     Exit;
  Result := linear_get_description(converter_type);
end;

const
  PACKAGE = 'libsamplerate';
  VERSION = '0.1.2';

function src_get_version(converter_type : integer) : string;
begin
  Result := PACKAGE + '-' + VERSION;
end;

function src_is_valid_ratio(ratio : double) : boolean;
begin
  Result:= (ratio < (1.0 / SRC_MAX_RATIO)) or (ratio > (1.0 * SRC_MAX_RATIO));
end;

function src_error(state : PSRC_STATE) : integer;
begin
  if state <> nil then
    Result := PSRC_PRIVATE(state)^.error
  else
    Result := SRC_ERR_NO_ERROR;
end;

function src_strerror(error : integer) : string;
begin
  case error of
    SRC_ERR_NO_ERROR : Result := 'No error.';
		SRC_ERR_MALLOC_FAILED : Result := 'Malloc failed.';
		SRC_ERR_BAD_STATE : Result := 'SRC_STATE pointer is NULL.';
		SRC_ERR_BAD_DATA : Result := 'SRC_DATA pointer is NULL.';
		SRC_ERR_BAD_DATA_PTR : Result := 'SRC_DATA->data_out is NULL.';
		SRC_ERR_NO_PRIVATE : Result := 'Internal error. No private data.';
		SRC_ERR_BAD_SRC_RATIO : Result := 'SRC ratio outside [1/12, 12] range.';
		SRC_ERR_BAD_SINC_STATE : Result := 'src_process() called without reset after end_of_input.';
		SRC_ERR_BAD_PROC_PTR : Result := 'Internal error. No process pointer.';
		SRC_ERR_SHIFT_BITS : Result := 'Internal error. SHIFT_BITS too large.';
		SRC_ERR_FILTER_LEN : Result := 'Internal error. Filter length too large.';
		SRC_ERR_BAD_CONVERTER : Result := 'Bad converter number.';
		SRC_ERR_BAD_CHANNEL_COUNT : Result := 'Channel count must be >= 1.';
		SRC_ERR_SINC_BAD_BUFFER_LEN : Result := 'Internal error. Bad buffer length. Please report this.';
		SRC_ERR_SIZE_INCOMPATIBILITY : Result := 'Internal error. Input data / internal buffer size difference. Please report this.';
		SRC_ERR_BAD_PRIV_PTR : Result := 'Internal error. Private pointer is NULL. Please report this.';
		SRC_ERR_DATA_OVERLAP : Result := 'Input and output data arrays overlap.';
		SRC_ERR_BAD_CALLBACK : Result := 'Supplied callback function pointer is NULL.';
		SRC_ERR_BAD_MODE : Result := 'Calling mode differs from initialisation mode (ie process v callback).';
		SRC_ERR_NULL_CALLBACK : Result := 'Callback function pointer is NULL in src_callback_read ().';
		SRC_ERR_MAX_ERROR : Result := 'Placeholder. No error defined for this error number.';
  else
    Result := '';
  end;
end;

(*
**	Simple interface for performing a single conversion from input buffer to
**	output buffer at a fixed conversion ratio.
*)

function src_simple(src_data : PSRC_DATA; converter, channels : integer) : integer;
var
  src_state : PSRC_STATE;
begin
  src_state := src_new(converter, channels, @Result);
  if src_state = nil then
    Exit;
  src_data^.end_of_input := 1; // only one buffer worth of input.
  Result := src_process(src_state, src_data);
  src_state := src_delete(src_state);
end;

end.