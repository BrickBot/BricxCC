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
unit uSrcCommon;

interface

const
  SRC_MAX_RATIO = 256;
  SRC_MIN_RATIO_DIFF = 1e-20;

function MAKE_MAGIC(a, b, c, d, e, f : Char) : Cardinal;

type
//  PDouble = ^Double;
  PSRC_DATA = ^SRC_DATA;
  SRC_DATA = record
    data_in : PDouble;
    data_out : PDouble;
    input_frames : Integer;
    output_frames : Integer;
    input_frames_used : Integer;
    output_frames_gen : Integer;
    end_of_input : Integer;
    src_ratio : Double;
  end;

const
  SRC_SINC_BEST_QUALITY   = 0;
  SRC_SINC_MEDIUM_QUALITY = 1;
  SRC_SINC_FASTEST        = 2;
  SRC_ZERO_ORDER_HOLD     = 3;
  SRC_LINEAR              = 4;
  SRC_NONE                = 5;

  SRC_FALSE = 0;
  SRC_TRUE  = 1;
  SRC_MODE_PROCESS  = 555;
  SRC_MODE_CALLBACK = 556;

	SRC_ERR_NO_ERROR       = 0;
	SRC_ERR_MALLOC_FAILED  = 1;
	SRC_ERR_BAD_STATE      = 2;
	SRC_ERR_BAD_DATA       = 3;
	SRC_ERR_BAD_DATA_PTR   = 4;
	SRC_ERR_NO_PRIVATE     = 5;
	SRC_ERR_BAD_SRC_RATIO  = 6;
	SRC_ERR_BAD_PROC_PTR   = 7;
	SRC_ERR_SHIFT_BITS     = 8;
	SRC_ERR_FILTER_LEN     = 9;
	SRC_ERR_BAD_CONVERTER  = 10;
	SRC_ERR_BAD_CHANNEL_COUNT    = 11;
	SRC_ERR_SINC_BAD_BUFFER_LEN  = 12;
	SRC_ERR_SIZE_INCOMPATIBILITY = 13;
	SRC_ERR_BAD_PRIV_PTR   = 14;
	SRC_ERR_BAD_SINC_STATE = 15;
	SRC_ERR_DATA_OVERLAP   = 16;
	SRC_ERR_BAD_CALLBACK   = 17;
	SRC_ERR_BAD_MODE       = 18;
	SRC_ERR_NULL_CALLBACK  = 19;
	SRC_ERR_MAX_ERROR      = 20;

type
  PSRC_STATE = Pointer;
  PSRC_PRIVATE = ^SRC_PRIVATE;
  SrcProcessProc = function (psrc : PSRC_PRIVATE; data : PSRC_DATA) : integer;
  SrcResetProc = procedure(psrc : PSRC_PRIVATE);
  SRC_PRIVATE = record
    last_ratio : double;
    last_position : double;
    error : integer;
    channels : integer;
    mode : integer;
    private_data : pointer;
    process : SrcProcessProc;
    reset : SrcResetProc;
  end;

implementation

function MAKE_MAGIC(a, b, c, d, e, f : Char) : Cardinal;
begin
  Result := Ord(a) + (Ord(b) shl 4) + (Ord(c) shl 8) +
            (Ord(d) shl 12) + (Ord(e) shl 16) + (Ord(f) shl 20);
end;

end.
