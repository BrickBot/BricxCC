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
unit libnxt;

interface

uses
  libusb;

const
  VENDOR_LEGO   = $0694;
  VENDOR_AMTEL  = $03EB;
  PRODUCT_NXT   = $0002;
  PRODUCT_SAMBA = $6124;

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
    is_in_reset_mode : Boolean;
  end;

function nxt_init(nxt : PPNxt) : integer;
function nxt_find(nxt : PNxt) : integer;
function nxt_open(nxt : PNxt) : integer;
function nxt_close(nxt : PNxt) : integer;
function nxt_in_reset_mode(nxt : PNxt) : boolean;
function nxt_send_buf(nxt : PNxt; buf : PChar; len : integer) : integer;
function nxt_send_str(nxt : PNxt; str : PChar) : integer;
function nxt_recv_buf(nxt : PNxt; buf : PChar; len : integer) : integer;
function nxt_str_error(err : integer) : string;

implementation

uses
  SysUtils;

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

function nxt_str_error(err : integer) : string;
begin
  Result := err_str[err];
end;

function nxt_init(nxt : PPNxt) : integer;
begin
  usb_init();
  GetMem(nxt^, SizeOf(TNxt));
  Result := NXT_OK;
end;

function nxt_find(nxt : PNxt) : integer;
var
  bus, busses : PUSBBus;
  dev : PUSBDevice;
begin
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
        nxt^.is_in_reset_mode := True;
        Result := NXT_OK;
        Exit;
      end
      else if (dev^.descriptor.idVendor = VENDOR_LEGO) and
              (dev^.descriptor.idProduct = PRODUCT_NXT) then
      begin
        nxt^.dev := dev;
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
//  buf : array[0..1] of Char;
begin
  nxt^.hdl := usb_open(nxt^.dev);

  ret := usb_set_configuration(nxt^.hdl, 1);
  if ret < 0 then
  begin
    usb_close(nxt^.hdl);
    Result := NXT_CONFIGURATION_ERROR;
    Exit;
  end;

  ret := usb_claim_interface(nxt^.hdl, 1);
  if ret < 0 then
  begin
    usb_close(nxt^.hdl);
    Result := NXT_IN_USE;
    Exit;
  end;

(*
  //* NXT handshake */
  nxt_send_str(nxt, "N#");
  nxt_recv_buf(nxt, buf, 2);
  if (memcmp(buf, "\n\r", 2) != 0)
    {
      usb_release_interface(nxt->hdl, 1);
      usb_close(nxt->hdl);
      return NXT_HANDSHAKE_FAILED;
    }
*)
  Result := NXT_OK;
end;

function nxt_close(nxt : PNxt) : integer;
begin
  usb_release_interface(nxt^.hdl, 1);
  usb_close(nxt^.hdl);
  FreeMem(nxt);
  Result := NXT_OK;
end;

function nxt_in_reset_mode(nxt : PNxt) : boolean;
begin
  Result := nxt^.is_in_reset_mode;
end;

function nxt_send_buf(nxt : PNxt; buf : PChar; len : integer) : integer;
var
  ret : integer;
begin
  ret := usb_bulk_write(nxt^.hdl, $1, buf, len, 0);
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
  ret := usb_bulk_read(nxt^.hdl, $82, buf, len, 0);
  if ret < 0 then
  begin
    Result := NXT_USB_READ_ERROR;
    Exit;
  end;
  Result := NXT_OK;
end;

end.
