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
 * Portions created by John Hansen are Copyright (C) 2011 John Hansen.
 * All Rights Reserved.
 *
 *)
unit libnxt;

interface

uses
  libusb;

const
  NXT_OK                   = 0;
  NXT_NOT_PRESENT          = 1;
  NXT_CONFIGURATION_ERROR  = 2;
  NXT_IN_USE               = 3;
  NXT_USB_WRITE_ERROR      = 4;
  NXT_USB_READ_ERROR       = 5;
  NXT_SAMBA_PROTOCOL_ERROR = 6;
  NXT_HANDSHAKE_FAILED     = 7;
  NXT_FILE_ERROR           = 8;
  NXT_INVALID_FIRMWARE     = 9;

type
  PPNxt = ^PNxt;
  PNxt = ^TNxt;
  TNxt = record
    dev : PUSBDevice;
    hdl : PUSBDevHandle;
    is_in_samba_mode : Boolean;
  end;

function nxt_init(var nxt : PNxt) : integer;
function nxt_finalize(var nxt : PNxt) : integer;
function nxt_find(nxt : PNxt) : integer;
function nxt_open(nxt : PNxt) : integer;
function nxt_close(nxt : PNxt) : integer;
function nxt_in_samba_mode(nxt : PNxt) : boolean;
function nxt_boot_into_samba(nxt : PNxt) : integer;
function nxt_send_buf(nxt : PNxt; buf : PChar; len : integer) : integer;
function nxt_send_str(nxt : PNxt; str : PChar) : integer;
function nxt_recv_buf(nxt : PNxt; buf : PChar; len : integer) : integer;
function nxt_str_error(err : integer) : string;

function nxt_write_byte(nxt : PNxt; addr : Cardinal; b : byte) : integer;
function nxt_write_hword(nxt : PNxt; addr : Cardinal; hw : word) : integer;
function nxt_write_word(nxt : PNxt; addr, w : Cardinal) : integer;
function nxt_read_byte(nxt : PNxt; addr : Cardinal; var b : byte) : integer;
function nxt_read_hword(nxt : PNxt; addr : Cardinal; var hw : word) : integer;
function nxt_read_word(nxt : PNxt; addr : Cardinal; var w : Cardinal) : integer;

function nxt_send_file(nxt : PNxt; addr : Cardinal; nfile : PChar; len : word) : integer;
function nxt_recv_file(nxt : PNxt; addr : Cardinal; nfile : PChar; len : word) : integer;
function nxt_jump(nxt : PNxt; addr : Cardinal) : integer;
function nxt_samba_version(nxt : PNxt; version : PChar) : integer;

function nxt_flash_wait_ready(nxt : PNxt) : integer;
function nxt_flash_lock_region(nxt : PNxt; region_num : integer) : integer;
function nxt_flash_unlock_region(nxt : PNxt; region_num : integer) : integer;
function nxt_flash_lock_all_regions(nxt : PNxt) : integer;
function nxt_flash_unlock_all_regions(nxt : PNxt) : integer;

function nxt_firmware_flash(nxt : PNxt; fw_path : string) : integer;
function nxt_firmware_validate(fw_path : string) : integer;

implementation

uses
  Classes, SysUtils{$IFDEF WIN32}, Windows{$ENDIF};

const
  VENDOR_LEGO   = $0694;
  VENDOR_AMTEL  = $03EB;
  PRODUCT_NXT   = $0002;
  PRODUCT_SAMBA = $6124;
  USB_INTERFACE = 0; // was 1
  USB_OUT_ENDPOINT = $01;
  USB_IN_ENDPOINT  = $82;

const
  flash_len = 136;
  flash_bin : array[0..flash_len-1] of Byte = (
    $21, $D8, $A0, $E3, $00, $40, $2D, $E9, $00, $00, $00, $EB,
    $00, $80, $BD, $E8, $00, $20, $E0, $E3, $97, $30, $12, $E5,
    $01, $00, $13, $E3, $FC, $FF, $FF, $0A, $02, $C6, $A0, $E3,
    $0C, $00, $A0, $E1, $21, $0C, $80, $E2, $02, $CA, $8C, $E2,
    $00, $10, $A0, $E3, $00, $33, $9C, $E5, $03, $33, $81, $E0,
    $01, $21, $90, $E7, $03, $31, $A0, $E1, $01, $10, $81, $E2,
    $01, $36, $83, $E2, $40, $00, $51, $E3, $00, $20, $83, $E5,
    $F6, $FF, $FF, $1A, $00, $33, $9C, $E5, $03, $3B, $A0, $E1,
    $23, $3B, $A0, $E1, $03, $34, $A0, $E1, $5A, $34, $83, $E2,
    $01, $30, $83, $E2, $00, $20, $E0, $E3, $9B, $30, $02, $E5,
    $97, $30, $12, $E5, $01, $00, $13, $E3, $FC, $FF, $FF, $0A,
    $1E, $FF, $2F, $E1
  );

const
  ERR_MAX = 9;
  err_str : array[0..ERR_MAX] of string = (
    'Success',
    'NXT not found on USB bus',
    'Error trying to configure the NXT USB link',
    'NXT USB interface is already claimed by another program',
    'USB write error',
    'USB read error',
    'SAM-BA protocol error',
    'NXT handshake failed',
    'File open/handling error',
    'Invalid firmware image'
  );

const
  FLASH_CMD_LOCK = $2;
  FLASH_CMD_UNLOCK = $4;

function nxt_str_error(err : integer) : string;
begin
  Result := err_str[err];
end;

function nxt_init(var nxt : PNxt) : integer;
begin
  usb_init();
  nxt := AllocMem(SizeOf(TNxt));
  Result := NXT_OK;
end;

function nxt_finalize(var nxt : PNxt) : integer;
begin
  if nxt^.hdl <> nil then
    nxt_close(nxt);
  FreeMem(nxt);
  nxt := nil;
  Result := NXT_OK;
end;

function nxt_find(nxt : PNxt) : integer;
var
  bus, busses : PUSBBus;
  dev : PUSBDevice;
begin
  nxt^.is_in_samba_mode := False;
  usb_find_busses();
  usb_find_devices();
  busses := usb_get_busses();
  bus := busses;
  while bus <> nil do
  begin
    dev := bus^.devices;
    while dev <> nil do
    begin
      if (dev^.descriptor.idVendor = VENDOR_AMTEL) and
         (dev^.descriptor.idProduct = PRODUCT_SAMBA) then
      begin
        nxt^.dev := dev;
        nxt^.hdl := nil;
        nxt^.is_in_samba_mode := True;
        Result := NXT_OK;
        Exit;
      end
      else if (dev^.descriptor.idVendor = VENDOR_LEGO) and
              (dev^.descriptor.idProduct = PRODUCT_NXT) then
      begin
        nxt^.dev := dev;
        nxt^.hdl := nil;
        nxt^.is_in_samba_mode := False;
        Result   := NXT_OK;
        Exit;
      end;
      dev := dev^.next;
    end;
    bus := bus^.next;
  end;
  Result := NXT_NOT_PRESENT;
end;

function nxt_open(nxt : PNxt) : integer;
var
  ret : integer;
  buf : PChar;
  tmp1, tmp2 : string;
begin
  Result := NXT_OK;
  nxt^.hdl := usb_open(nxt^.dev);

{$IFDEF Linux}
  //detach possible kernel driver bound to interface
  usb_detach_kernel_driver_np(nxt^.hdl, USB_INTERFACE);
{$ENDIF}
{
  ret := usb_set_configuration(nxt^.hdl, 1);
  if ret < 0 then
  begin
    usb_close(nxt^.hdl);
    Result := NXT_CONFIGURATION_ERROR;
    Exit;
  end;
}
  ret := usb_claim_interface(nxt^.hdl, USB_INTERFACE);
  if ret < 0 then
  begin
    usb_close(nxt^.hdl);
    Result := NXT_IN_USE;
    Exit;
  end;

  if nxt^.is_in_samba_mode then
  begin
    // NXT handshake (only works in SAMBA mode)
    buf := AllocMem(3);
    try
      nxt_send_str(nxt, 'N#');
      nxt_recv_buf(nxt, buf, 2);
      tmp1 := ''#$A#$D'';
      tmp2 := string(buf);
      if tmp1 <> tmp2 then
      begin
        usb_release_interface(nxt^.hdl, USB_INTERFACE);
        usb_close(nxt^.hdl);
        Result := NXT_HANDSHAKE_FAILED;
        Exit;
      end;
    finally
      FreeMem(buf, 3);
    end;
  end;
end;

function nxt_close(nxt : PNxt) : integer;
begin
  usb_release_interface(nxt^.hdl, USB_INTERFACE);
  usb_close(nxt^.hdl);
  nxt^.hdl := nil;
  Result := NXT_OK;
end;

function nxt_in_samba_mode(nxt : PNxt) : boolean;
begin
  Result := nxt^.is_in_samba_mode;
end;

function nxt_boot_into_samba(nxt : PNxt) : integer;
const
  boot : array[0..20] of byte = (
    $01, $97, $4c, $65, $74, $27, $73,
    $20, $64, $61, $6e, $63, $65, $3a,
    $20, $53, $41, $4d, $42, $41, $00
  );
begin
  Result := NXT_OK;
  if nxt = nil then Exit;
  if nxt^.is_in_samba_mode then Exit;
  Result := nxt_send_buf(nxt, PChar(@boot[0]), 21);
end;

function nxt_send_buf(nxt : PNxt; buf : PChar; len : integer) : integer;
var
  ret : integer;
begin
  ret := usb_bulk_write(nxt^.hdl, USB_OUT_ENDPOINT, buf, len, 0);
  if ret < 0 then
  begin
    Result := NXT_USB_WRITE_ERROR;
    Exit;
  end;
  Result := NXT_OK;
end;

function nxt_send_str(nxt : PNxt; str : PChar) : integer;
begin
  Result := nxt_send_buf(nxt, str, StrLen(str));
end;

function nxt_recv_buf(nxt : PNxt; buf : PChar; len : integer) : integer;
var
  ret : integer;
begin
  ret := usb_bulk_read(nxt^.hdl, USB_IN_ENDPOINT, buf, len, 0);
  if ret < 0 then
  begin
    Result := NXT_USB_READ_ERROR;
    Exit;
  end;
  Result := NXT_OK;
end;


function nxt_format_command2(buf : PChar; cmd : Char; addr, nword : Cardinal) : integer;
var
  tmp : string;
begin
  tmp := cmd + UpperCase(Format('%8.8x,%8.8x#', [addr, nword]));
  StrCopy(buf, PChar(tmp));
  Result := NXT_OK;
end;

function nxt_format_command(buf : PChar; cmd : Char; addr : Cardinal) : integer;
var
  tmp : string;
begin
  tmp := cmd + UpperCase(Format('%8.8x#', [addr]));
  StrCopy(buf, PChar(tmp));
  Result := NXT_OK;
end;

function nxt_write_common(nxt : PNxt; ntype : Char; addr, w : Cardinal) : integer;
var
  buf : PChar;
begin
  buf := AllocMem(21);
  try
    Result := nxt_format_command2(buf, ntype, addr, w);
    if Result <> NXT_OK then Exit;
    Result := nxt_send_str(nxt, buf);
  finally
    FreeMem(buf, 21);
  end;
end;

function nxt_write_byte(nxt : PNxt; addr : Cardinal; b : Byte) : integer;
begin
  Result := nxt_write_common(nxt, 'O', addr, b);
end;

function nxt_write_hword(nxt : PNxt; addr : Cardinal; hw : Word) : integer;
begin
  Result := nxt_write_common(nxt, 'H', addr, hw);
end;

function nxt_write_word(nxt : PNxt; addr, w : Cardinal) : integer;
begin
  Result := nxt_write_common(nxt, 'W', addr, w);
end;

function nxt_read_common(nxt : PNxt; cmd : Char; len : integer; addr : Cardinal; var nword : Cardinal) : integer;
var
  buf : PChar;
  w : Cardinal;
begin
  buf := AllocMem(20);
  try
    Result := nxt_format_command2(buf, cmd, addr, len);
    if Result <> NXT_OK then Exit;

    Result := nxt_send_str(nxt, buf);
    if Result <> NXT_OK then Exit;

    Result := nxt_recv_buf(nxt, buf, len);
    if Result <> NXT_OK then Exit;

    w := (PCardinal(buf))^;

{$ifdef _NXT_BIG_ENDIAN}
  (* The value returned is in little-endian byte ordering, so swap
     bytes on a big-endian architecture. *)
    w := (((w and $000000FF) shl 24) +
          ((w and $0000FF00) shl 8)  +
          ((w and $00FF0000) shr 8)  +
          ((w and $FF000000) shr 24));
{$endif}
    nword := w;
  finally
    FreeMem(buf, 20);
  end;
end;

function nxt_read_byte(nxt : PNxt; addr : Cardinal; var b : byte) : integer;
var
  w : Cardinal;
begin
  Result := nxt_read_common(nxt, 'o', 1, addr, w);
  if Result <> NXT_OK then Exit;
  b := Byte(w);
end;

function nxt_read_hword(nxt : PNxt; addr : Cardinal; var hw : word) : integer;
var
  w : Cardinal;
begin
  Result := nxt_read_common(nxt, 'h', 2, addr, w);
  if Result <> NXT_OK then Exit;
  hw := Word(w);
end;

function nxt_read_word(nxt : PNxt; addr : Cardinal; var w : Cardinal) : integer;
begin
  Result := nxt_read_common(nxt, 'w', 4, addr, w);
end;

function nxt_send_file(nxt : PNxt; addr : Cardinal; nfile : PChar; len : word) : integer;
var
  buf : PChar;
begin
  GetMem(buf, 20);
  try
    Result := nxt_format_command2(buf, 'S', addr, len);
    if Result <> NXT_OK then Exit;

    Result := nxt_send_str(nxt, buf);
    if Result <> NXT_OK then Exit;

    Result := nxt_send_buf(nxt, nfile, len);
  finally
    FreeMem(buf, 20);
  end;
end;

function nxt_recv_file(nxt : PNxt; addr : Cardinal; nfile : PChar; len : word) : integer;
var
  buf : PChar;
begin
  GetMem(buf, 20);
  try
    Result := nxt_format_command2(buf, 'R', addr, len);
    if Result <> NXT_OK then Exit;

    Result := nxt_send_str(nxt, buf);
    if Result <> NXT_OK then Exit;

    Result := nxt_recv_buf(nxt, nfile, len+1);
  finally
    FreeMem(buf, 20);
  end;
end;

function nxt_jump(nxt : PNxt; addr : Cardinal) : integer;
var
  buf : PChar;
begin
  GetMem(buf, 20);
  try
    Result := nxt_format_command(buf, 'G', addr);
    if Result <> NXT_OK then Exit;

    Result := nxt_send_str(nxt, buf);
  finally
    FreeMem(buf, 20);
  end;
end;

function nxt_samba_version(nxt : PNxt; version : PChar) : integer;
var
  buf : PChar;
begin
  GetMem(buf, 3);
  try
    StrCopy(buf, 'V#');
    Result := nxt_send_str(nxt, buf);
    if Result <> NXT_OK then Exit;

    Result := nxt_recv_buf(nxt, version, 4);
    if Result <> NXT_OK then Exit;

    version[4] := #0;

  finally
    FreeMem(buf, 3);
  end;
end;

function nxt_flash_wait_ready(nxt : PNxt) : integer;
var
  flash_status : Cardinal;
begin
  repeat
    Result := nxt_read_word(nxt, $FFFFFF68, flash_status);
    if Result <> NXT_OK then Exit;
    (* Bit 0 is the FRDY field. Set to 1 if the flash controller is
     * ready to run a new command.
     *)
  until (flash_status and $1 = $1);
end;

function nxt_flash_alter_lock(nxt : PNxt; region_num : integer; cmd : byte) : integer;
var
  w : Cardinal;
begin
  w := $5A000000 or ((64 * region_num) shl 8);
  w := w + cmd;
  Result := nxt_flash_wait_ready(nxt);
  if Result <> NXT_OK then Exit;

  (* Flash mode register: FCMN 0x5, FWS 0x1
   * Flash command register: KEY 0x5A, FCMD = clear-lock-bit (0x4)
   * Flash mode register: FCMN 0x34, FWS 0x1
   *)
  Result := nxt_write_word(nxt, $FFFFFF60, $00050100);
  if Result <> NXT_OK then Exit;

  Result := nxt_write_word(nxt, $FFFFFF64, w);
  if Result <> NXT_OK then Exit;

  Result := nxt_write_word(nxt, $FFFFFF60, $00340100);
end;

function nxt_flash_lock_region(nxt : PNxt; region_num : integer) : integer;
begin
  Result := nxt_flash_alter_lock(nxt, region_num, FLASH_CMD_LOCK);
end;

function nxt_flash_lock_all_regions(nxt : PNxt) : integer;
var
  i : integer;
begin
  for i := 0 to 15 do
  begin
    Result := nxt_flash_lock_region(nxt, i);
    if Result <> NXT_OK then Exit;
  end;
end;

function nxt_flash_unlock_region(nxt : PNxt; region_num : integer) : integer;
begin
  Result := nxt_flash_alter_lock(nxt, region_num, FLASH_CMD_UNLOCK);
end;

function nxt_flash_unlock_all_regions(nxt : PNxt) : integer;
var
  i : integer;
begin
  for i := 0 to 15 do
  begin
    Result := nxt_flash_unlock_region(nxt, i);
    if Result <> NXT_OK then Exit;
  end;
end;

function nxt_flash_prepare(nxt : PNxt) : integer;
begin
  // Put the clock in PLL/2 mode
  Result := nxt_write_word(nxt, $FFFFFC30, $7);
  if Result <> NXT_OK then Exit;

  // Unlock the flash chip
  Result := nxt_flash_unlock_all_regions(nxt);
  if Result <> NXT_OK then Exit;

  // Send the flash writing routine
  Result := nxt_send_file(nxt, $202000, PChar(@flash_bin[0]), flash_len);
end;

function nxt_flash_block(nxt : PNxt; block_num : Cardinal; buf : PChar) : integer;
begin
  // Set the target block number
  Result := nxt_write_word(nxt, $202300, block_num);
  if Result <> NXT_OK then Exit;

  // Send the block to flash
  Result := nxt_send_file(nxt, $202100, buf, 256);
  if Result <> NXT_OK then Exit;

  // Jump into the flash writing routine
  Result := nxt_jump(nxt, $202000);
end;

function nxt_flash_finish(nxt : PNxt) : integer;
begin
  Result := nxt_flash_wait_ready(nxt);
end;

function nxt_firmware_validate_fs(fs : TFileStream) : integer;
begin
  Result := NXT_OK;
  if fs.Size > 256*1024 then
    Result := NXT_INVALID_FIRMWARE;
end;

function nxt_firmware_validate(fw_path : string) : integer;
var
  fs : TFileStream;
begin
  if not FileExists(fw_path) then
  begin
    Result := NXT_FILE_ERROR;
    Exit;
  end;

  try
    fs := TFileStream.Create(fw_path, fmOpenRead or fmShareExclusive);
    try
      Result := nxt_firmware_validate_fs(fs);
    finally
      fs.Free;
    end;
  except
    on E : EFOpenError do
      Result := NXT_FILE_ERROR;
  end;
end;

function nxt_firmware_flash(nxt : PNxt; fw_path : string) : integer;
var
  fs : TFileStream;
  i, ret : integer;
  buf : PChar;
begin
  if not FileExists(fw_path) then
  begin
    Result := NXT_FILE_ERROR;
    Exit;
  end;

  try
    fs := TFileStream.Create(fw_path, fmOpenRead or fmShareExclusive);
    try
      Result := nxt_firmware_validate_fs(fs);
      if Result <> NXT_OK then Exit;

      Result := nxt_flash_prepare(nxt);
      if Result <> NXT_OK then Exit;

      GetMem(buf, 256);
      try
        for i := 0 to 1023 do
        begin
          FillChar(buf^, 256, 0);
          ret := fs.Read(buf^, 256);
          if ret > 0 then
          begin
            Result := nxt_flash_block(nxt, i, buf);
            if Result <> NXT_OK then Exit;
          end;

          if ret < 256 then
          begin
            Result := nxt_flash_finish(nxt);
            if Result <> NXT_OK then Exit;
            if ret = -1 then
              Result := NXT_FILE_ERROR
            else
              Result := NXT_OK;
            Exit;
          end;
        end;
      finally
        FreeMem(buf, 256);
      end;
      Result := nxt_flash_finish(nxt);
    finally
      fs.Free;
    end;
  except
    on E : EFOpenError do
      Result := NXT_FILE_ERROR;
  end;
end;

end.
