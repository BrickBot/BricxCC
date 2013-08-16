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
 * Portions created by John Hansen are Copyright (C) 2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit hidapi;

interface

uses
  HidApiDefs;

{$IFNDEF WIN32}
{$ELSE}
{$A1}
{$ENDIF}

type
  PHidDeviceInfo = ^THidDeviceInfo;
	THidDeviceInfo = {packed} record
    path : PChar;
    vendor_id : word;
    product_id : word;
    serial_number : PWideChar;
    release_number : word;
    dummy1 : word;
    manufacturer_string : PWideChar;
    product_string : PWideChar;
    usage_page : word;
    usage : word;
    interface_number : integer;
    next : PHidDeviceInfo;
  end;

  THidDevice = record
		device_handle : THandle;
		blocking : Cardinal;
		output_report_length : word;
		input_report_length : word;
		last_error_str : Pointer;
		last_error_num : Cardinal;
		read_pending : Cardinal;
		read_buf : PChar;
//		OVERLAPPED ol;
  end;


var
	hid_init : function() : integer; cdecl;
  hid_exit : function() : integer; cdecl;
  hid_enumerate : function(vendor_id, product_id : word) : PHidDeviceInfo; cdecl;
  hid_free_enumeration : procedure(devs : PHidDeviceInfo); cdecl;
  hid_open : function(vendor_id, produc_id : word; serial_number : PWideChar) : PHidDeviceHandle; cdecl;
  hid_open_path : function(const path : PChar) : PHidDeviceHandle; cdecl;
  hid_write : function(device : PHidDeviceHandle; const data : PByte; length : cardinal) : integer; cdecl;
  hid_read_timeout : function(dev : PHidDeviceHandle; data : PByte; length : cardinal; milliseconds : integer) : integer; cdecl;
  hid_read : function(dev : PHidDeviceHandle; data : PByte; length : cardinal) : integer; cdecl;
  hid_set_nonblocking : function(device : PHidDeviceHandle; nonblock : integer) : integer; cdecl;
  hid_send_feature_report : function(device : PHidDeviceHandle; const data : PByte; length : integer) : integer; cdecl;
  hid_get_feature_report : function(device : PHidDeviceHandle; data : PByte; length : integer) : integer; cdecl;
  hid_close : procedure(device : PHidDeviceHandle); cdecl;
  hid_get_manufacturer_string : function(device : PHidDeviceHandle; str : PWideChar; maxlen : cardinal) : integer; cdecl;
  hid_get_product_string : function(device : PHidDeviceHandle; str : PWideChar; maxlen : cardinal) : integer; cdecl;
  hid_get_serial_number_string : function(device : PHidDeviceHandle; str : PWideChar; maxlen : cardinal) : integer; cdecl;
  hid_get_indexed_string : function(device : PHidDeviceHandle; str_index : integer; str : PWideChar; maxlen : cardinal) : integer; cdecl;
  hid_error : function(device : PHidDeviceHandle) : PWideChar; cdecl;

function InvalidHidDeviceHandle(device : PHidDeviceHandle) : boolean;

var
  HidAPILoaded: Boolean = False;

procedure UnloadHidAPI;

implementation

uses
  Windows;

function InvalidHidDeviceHandle(device : PHidDeviceHandle) : boolean;
begin
  Result := device = nil;
  if not Result then
    Result := device^ = INVALID_HANDLE_VALUE;
end;

var
  DLLHandle: THandle;
  ErrorMode: Integer;

procedure UnloadHidAPI;
begin
  if HidAPILoaded then
  begin
    if DLLHandle >= 32 then
      FreeLibrary(DLLHandle);
    HidAPILoaded := False;
  end;
end;

procedure LoadDLL;
begin
  if HidAPILoaded then Exit;
  ErrorMode := SetErrorMode($8000);
  DLLHandle := LoadLibrary('HIDAPI.DLL');
  if DLLHandle >= 32 then
  begin
    HidAPILoaded := True;
    @hid_init := GetProcAddress(DLLHandle, 'hid_init');
    Assert(@hid_init <> nil);
    @hid_exit := GetProcAddress(DLLHandle, 'hid_exit');
    Assert(@hid_exit <> nil);
    @hid_enumerate := GetProcAddress(DLLHandle, 'hid_enumerate');
    Assert(@hid_enumerate <> nil);
    @hid_free_enumeration := GetProcAddress(DLLHandle, 'hid_free_enumeration');
    Assert(@hid_free_enumeration <> nil);
    @hid_open := GetProcAddress(DLLHandle, 'hid_open');
    Assert(@hid_open <> nil);
    @hid_open_path := GetProcAddress(DLLHandle, 'hid_open_path');
    Assert(@hid_open_path <> nil);
    @hid_write := GetProcAddress(DLLHandle, 'hid_write');
    Assert(@hid_write <> nil);
    @hid_read_timeout := GetProcAddress(DLLHandle, 'hid_read_timeout');
    Assert(@hid_read_timeout <> nil);
    @hid_read := GetProcAddress(DLLHandle, 'hid_read');
    Assert(@hid_read <> nil);
    @hid_set_nonblocking := GetProcAddress(DLLHandle, 'hid_set_nonblocking');
    Assert(@hid_set_nonblocking <> nil);
    @hid_send_feature_report := GetProcAddress(DLLHandle, 'hid_send_feature_report');
    Assert(@hid_send_feature_report <> nil);
    @hid_get_feature_report := GetProcAddress(DLLHandle, 'hid_get_feature_report');
    Assert(@hid_get_feature_report <> nil);
    @hid_close := GetProcAddress(DLLHandle, 'hid_close');
    Assert(@hid_close <> nil);
    @hid_get_manufacturer_string := GetProcAddress(DLLHandle, 'hid_get_manufacturer_string');
    Assert(@hid_get_manufacturer_string <> nil);
    @hid_get_product_string := GetProcAddress(DLLHandle, 'hid_get_product_string');
    Assert(@hid_get_product_string <> nil);
    @hid_get_serial_number_string := GetProcAddress(DLLHandle, 'hid_get_serial_number_string');
    Assert(@hid_get_serial_number_string <> nil);
    @hid_get_indexed_string := GetProcAddress(DLLHandle, 'hid_get_indexed_string');
    Assert(@hid_get_indexed_string <> nil);
    @hid_error := GetProcAddress(DLLHandle, 'hid_error');
    Assert(@hid_error <> nil);
  end
  else
  begin
    HidAPILoaded := False;
    { Error: hidapi.DLL could not be loaded !! }
  end;
  SetErrorMode(ErrorMode)
end;


initialization
  LoadDLL;

finalization
  UnloadHidAPI;

end.