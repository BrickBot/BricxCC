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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit libusb;

interface

{$IFNDEF WIN32}

{$MODE OBJFPC}

{$LINKLIB usb}
{$LINKLIB c}
{$PACKRECORDS C}

const
  LIBUSB_PATH_MAX = 4097;

{$ELSE}

{$A1}
const
  LIBUSB_PATH_MAX = 512;

{$ENDIF}

const
  ENOSTAT = 4001;
  ENOPOOL = 4002;
  ENOFILE = 4003;
  EINVAL  = 22;

{
   USB spec information

   This is all stuff grabbed from various USB specs and is pretty much
   not subject to change
}
{  Device and/or Interface Class codes }

{ for DeviceClass  }

const
  USB_CLASS_PER_INTERFACE = 0;
  USB_CLASS_AUDIO         = 1;
  USB_CLASS_COMM          = 2;
  USB_CLASS_HID           = 3;
  USB_CLASS_PRINTER       = 7;
  USB_CLASS_MASS_STORAGE  = 8;
  USB_CLASS_HUB           = 9;
  USB_CLASS_DATA          = 10;
  USB_CLASS_VENDOR_SPEC   = $ff;

  { Descriptor types }

  USB_DT_DEVICE           = $01;
  USB_DT_CONFIG           = $02;
  USB_DT_STRING           = $03;
  USB_DT_INTERFACE        = $04;
  USB_DT_ENDPOINT         = $05;
  USB_DT_HID              = $21;
  USB_DT_REPORT           = $22;
  USB_DT_PHYSICAL         = $23;
  USB_DT_HUB              = $29;

{ Descriptor sizes per descriptor type }

  USB_DT_DEVICE_SIZE      = 18;
  USB_DT_CONFIG_SIZE      = 9;
  USB_DT_INTERFACE_SIZE   = 9;
  USB_DT_ENDPOINT_SIZE    = 7;

{ Audio extension  }
  USB_DT_ENDPOINT_AUDIO_SIZE = 9;
  USB_DT_HUB_NONVAR_SIZE     = 7;

{  Standard requests  }
  USB_REQ_GET_STATUS        = $00;
  USB_REQ_CLEAR_FEATURE     = $01;
{ 0x02 is reserved  }
  USB_REQ_SET_FEATURE       = $03;
{ 0x04 is reserved  }
  USB_REQ_SET_ADDRESS       = $05;
  USB_REQ_GET_DESCRIPTOR    = $06;
  USB_REQ_SET_DESCRIPTOR    = $07;
  USB_REQ_GET_CONFIGURATION = $08;
  USB_REQ_SET_CONFIGURATION = $09;
  USB_REQ_GET_INTERFACE     = $0A;
  USB_REQ_SET_INTERFACE     = $0B;
  USB_REQ_SYNCH_FRAME       = $0C;

  USB_TYPE_STANDARD         = $00 shl 5;
  USB_TYPE_CLASS            = $01 shl 5;
  USB_TYPE_VENDOR           = $02 shl 5;
  USB_TYPE_RESERVED         = $03 shl 5;

  USB_RECIP_DEVICE          = $00;
  USB_RECIP_INTERFACE       = $01;
  USB_RECIP_ENDPOINT        = $02;
  USB_RECIP_OTHER           = $03;

{ Various libusb API related stuff  }
  USB_ENDPOINT_IN           = $80;
  USB_ENDPOINT_OUT          = $00;

{ Error codes  }
  USB_ERROR_BEGIN           = 500000;

  USB_MAXINTERFACES         = 32;
  USB_MAXENDPOINTS          = 32;

{ in bEndpointAddress  }
  USB_ENDPOINT_ADDRESS_MASK     = $0f;
  USB_ENDPOINT_DIR_MASK         = $80;

{ in bmAttributes  }
  USB_ENDPOINT_TYPE_MASK        = $03;
  USB_ENDPOINT_TYPE_CONTROL     = 0;
  USB_ENDPOINT_TYPE_ISOCHRONOUS = 1;
  USB_ENDPOINT_TYPE_BULK        = 2;
  USB_ENDPOINT_TYPE_INTERRUPT   = 3;

  USB_MAXALTSETTING = 128; // hard limit

  USB_MAXCONFIG = 8;

{ All standard descriptors have these 2 fields in common  }

type
  PUSBDescriptorHeader = ^USBDescriptorHeader;
  USBDescriptorHeader = {$IFDEF WIN32}packed{$ENDIF} record
    bLength : Byte;
    bDescriptorType : Byte;
  end;

{ String descriptor  }
  PUSBStringDescriptor = ^USBStringDescriptor;
  USBStringDescriptor = {$IFDEF WIN32}packed{$ENDIF} record
    bLength : Byte;
    bDescriptorType : Byte;
    wData : {$IFDEF WIN32}packed{$ENDIF} array[0..0] of Word;
  end;

{ HID descriptor  }
  PUSBHIDDescriptor = ^USBHIDDescriptor;
  USBHIDDescriptor = {$IFDEF WIN32}packed{$ENDIF} record
    bLength : Byte;
    bDescriptorType : Byte;
    bcdHID : Word;
    bCountryCode : Byte;
    bNumDescriptors : Byte;
  end;

{ Endpoint descriptor  }
  PUSBEndpointDescriptor = ^USBEndpointDescriptor;
  USBEndpointDescriptor = {$IFDEF WIN32}packed{$ENDIF} record
    bLength : Byte;
    bDescriptorType : Byte;
    bEndpointAddress : Byte;
    bmAttributes : Byte;
    wMaxPacketSize : Word;
    bInterval : Byte;
    bRefresh : Byte;
    bSynchAddress : Byte;
    extra : PByte;
    extralen : Longint;
  end;

{ Interface descriptor  }
  PUSBInterfaceDescriptor = ^USBInterfaceDescriptor;
  USBInterfaceDescriptor = {$IFDEF WIN32}packed{$ENDIF} record
    bLength : Byte;
    bDescriptorType : Byte;
    bInterfaceNumber : Byte;
    bAlternateSetting : Byte;
    bNumEndpoints : Byte;
    bInterfaceClass : Byte;
    bInterfaceSubClass : Byte;
    bInterfaceProtocol : Byte;
    iInterface : Byte;
    endpoint : PUSBEndpointDescriptor;
    extra : Pbyte;  // extra descriptors
    extralen : Longint;
  end;

  PUSBInterface = ^USBInterface;
  USBInterface = {$IFDEF WIN32}packed{$ENDIF} record
    altsetting : PUSBInterfaceDescriptor;
    num_altsetting : Longint;
  end;

{ Configuration descriptor information..  }
  PUSBConfigDescriptor = ^USBConfigDescriptor;
  USBConfigDescriptor = {$IFDEF WIN32}packed{$ENDIF} record
    bLength : Byte;
    bDescriptorType : Byte;
    wTotalLength : Word;
    bNumInterfaces : Byte;
    bConfigurationValue : Byte;
    iConfiguration : Byte;
    bmAttributes : Byte;
    MaxPower : Byte;
    iInterface : PUSBInterface;
    extra : Pbyte; { Extra descriptors  }
    extralen : Longint;
  end;

{ Device descriptor  }
  PUSBDeviceDescriptor = ^USBDeviceDescriptor;
  USBDeviceDescriptor = {$IFDEF WIN32}packed{$ENDIF} record
    bLength : Byte;
    bDescriptorType : Byte;
    bcdUSB : Word;
    bDeviceClass : Byte;
    bDeviceSubClass : Byte;
    bDeviceProtocol : Byte;
    bMaxPacketSize0 : Byte;
    idVendor : Word;
    idProduct : Word;
    bcdDevice : Word;
    iManufacturer : Byte;
    iProduct : Byte;
    iSerialNumber : Byte;
    bNumConfigurations : Byte;
  end;

  USBCtrlSetup = {$IFDEF WIN32}packed{$ENDIF} record
    bRequestType : Byte;
    bRequest : Byte;
    wValue : Word;
    wIndex : Word;
    wLength : Word;
  end;

  PUSBBus = ^USBBus;

  PPUSBDevice = ^PUSBDevice;
  PUSBDevice = ^USBDevice;
  USBDevice = {$IFDEF WIN32}packed{$ENDIF} record
    next : PUSBDevice;
    prev : PUSBDevice;
    filename : {$IFDEF WIN32}packed{$ENDIF} array[0..LIBUSB_PATH_MAX-1] of Char;
    bus : PUSBBus;
    descriptor : USBDeviceDescriptor;
    config : PUSBConfigDescriptor;
    dev : Pointer;
{$IFNDEF WIN32}
    devnum : Byte;
    num_children : Byte;
    children : PPUSBDevice;
{$ENDIF}
  end;

  USBBus = {$IFDEF WIN32}packed{$ENDIF} record
    next : PUSBBus;
    prev : PUSBBus;
    dirname : {$IFDEF WIN32}packed{$ENDIF} array[0..LIBUSB_PATH_MAX-1] of Char;
    devices : PUSBDevice;
    location : Cardinal;
{$IFNDEF WIN32}
    root_dev : PUSBDevice;
{$ENDIF}
  end;

  PUSBDevHandle = ^USBDevHandle;
  USBDevHandle = {$IFDEF WIN32}packed{$ENDIF} record
    fd: Integer;
    bus: PUSBBus;
    dev: PUSBDevice;
    cfg: Integer;
    intfac: Integer;
    altset: Integer;
    impl_info: Pointer;
  end;

{$IFNDEF WIN32}
{$linklib usb}
{ Variables  }

var USBBusses : PUSBBus; cvar; external;

{ Function prototypes  }

function usb_open(dev:PUSBDevice):PUSBDevHandle; cdecl; external;
function usb_close(dev:PUSBDevHandle):Longint; cdecl; external;
function usb_get_string(dev : PUSBDevHandle; index : LongInt;
  langid : LongInt; buf : PChar; buflen : Integer) : LongInt; cdecl; external;
function usb_get_string_simple(dev : PUSBDevHandle; index : LongInt;
  buf : PChar; buflen : Integer) : LongInt; cdecl; external;
function usb_get_descriptor_by_endpoint(dev : PUSBDevHandle; ep : LongInt;
  _type : Byte; index : Byte; buf : Pointer; size : Integer) : LongInt; cdecl; external;
function usb_get_descriptor(dev : PUSBDevHandle; _type : Byte; index : Byte;
  buf : Pointer; size : Integer) : LongInt; cdecl; external;
function usb_bulk_write(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl; external;
function usb_bulk_read(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl; external;
function usb_interrupt_write(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl; external;
function usb_interrupt_read(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl; external;
function usb_control_msg(dev:PUSBDevHandle; requestType:Longint; request:Longint; value:Longint; index:Longint;
  bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl; external;
function usb_set_configuration(dev:PUSBDevHandle; configuration:Longint):Longint; cdecl; external;
function usb_claim_interface(dev:PUSBDevHandle; TheInterface:Longint):Longint; cdecl; external;
function usb_release_interface(dev:PUSBDevHandle; TheInterface:Longint):Longint; cdecl; external;
function usb_set_altinterface(dev:PUSBDevHandle; alternate:Longint):Longint; cdecl; external;
function usb_resetep(dev:PUSBDevHandle; ep:Cardinal):Longint; cdecl; external;
function usb_clear_halt(dev:PUSBDevHandle; ep:Cardinal):Longint; cdecl; external;
function usb_reset(dev:PUSBDevHandle):Longint; cdecl; external;
function usb_strerror:PChar; cdecl; external;
procedure usb_init; cdecl; external;
procedure usb_set_debug(level:Longint); cdecl; external;
function usb_find_busses:Longint; cdecl; external;
function usb_find_devices:Longint; cdecl; external;
function usb_device(dev:PUSBDevHandle):PUSBDevice; cdecl; external;
function usb_get_busses : PUSBBus; cdecl; external;
function usb_detach_kernel_driver_np(dev:PUSBDevHandle; TheInterface:integer):Longint; cdecl; external;

(*
function usb_install_service_np(); LongInt; cdecl; external;
function usb_uninstall_service_np(); LongInt; cdecl; external;
function usb_install_driver_np(inf_file : PChar) : LongInt; cdecl; external;
function usb_get_version() : PUSBVersion; cdecl; external;
typedef int ( *usb_isochronous_setup_async_t)(usb_dev_handle *dev,
                                             void **context,
                                             unsigned char ep, int pktsize);
typedef int ( *usb_bulk_setup_async_t)(usb_dev_handle *dev, void **context,
                                      unsigned char ep);
typedef int ( *usb_interrupt_setup_async_t)(usb_dev_handle *dev, void **context,
                                           unsigned char ep);
typedef int ( *usb_submit_async_t)(void *context, char *bytes, int size);
typedef int ( *usb_reap_async_t)(void *context, int timeout);
typedef int ( *usb_free_async_t)(void **context);
*)

{$ELSE}
function usb_open(dev:PUSBDevice):PUSBDevHandle; cdecl;
function usb_close(dev:PUSBDevHandle):Longint; cdecl;
function usb_get_string(dev : PUSBDevHandle; index : LongInt;
  langid : LongInt; buf : PChar; buflen : Integer) : LongInt; cdecl;
function usb_get_string_simple(dev : PUSBDevHandle; index : LongInt;
  buf : PChar; buflen : Integer) : LongInt; cdecl;
function usb_get_descriptor_by_endpoint(dev : PUSBDevHandle; ep : LongInt;
  _type : Byte; index : Byte; buf : Pointer; size : Integer) : LongInt; cdecl;
function usb_get_descriptor(dev : PUSBDevHandle; _type : Byte; index : Byte;
  buf : Pointer; size : Integer) : LongInt; cdecl;
function usb_bulk_write(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl;
function usb_bulk_read(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl;
function usb_interrupt_write(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl;
function usb_interrupt_read(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl;
function usb_control_msg(dev:PUSBDevHandle; requestType:Longint; request:Longint; value:Longint; index:Longint;
  bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl;
function usb_set_configuration(dev:PUSBDevHandle; configuration:Longint):Longint; cdecl;
function usb_claim_interface(dev:PUSBDevHandle; TheInterface:Longint):Longint; cdecl;
function usb_release_interface(dev:PUSBDevHandle; TheInterface:Longint):Longint; cdecl;
function usb_set_altinterface(dev:PUSBDevHandle; alternate:Longint):Longint; cdecl;
function usb_resetep(dev:PUSBDevHandle; ep:Cardinal):Longint; cdecl;
function usb_clear_halt(dev:PUSBDevHandle; ep:Cardinal):Longint; cdecl;
function usb_reset(dev:PUSBDevHandle):Longint; cdecl;
function usb_strerror:PChar; cdecl;
procedure usb_init; cdecl;
procedure usb_set_debug(level:Longint); cdecl;
function usb_find_busses:Longint; cdecl;
function usb_find_devices:Longint; cdecl;
function usb_device(Dev:PUSBDevHandle):PUSBDevice; cdecl;
function usb_get_busses : PUSBBus; cdecl;

var
  LibUSBLoaded: Boolean = False;

procedure UnloadLibUSB;

{$ENDIF}

implementation

{$IFDEF WIN32}
uses
  Windows;

var
  _usb_open : function(dev:PUSBDevice):PUSBDevHandle; cdecl;
  _usb_close : function(dev:PUSBDevHandle):Longint; cdecl;
  _usb_get_string : function(dev : PUSBDevHandle; index : LongInt;
    langid : LongInt; buf : PChar; buflen : Integer) : LongInt; cdecl;
  _usb_get_string_simple : function(dev : PUSBDevHandle; index : LongInt;
    buf : PChar; buflen : Integer) : LongInt; cdecl;
  _usb_get_descriptor_by_endpoint : function(dev : PUSBDevHandle; ep : LongInt;
    _type : Byte; index : Byte; buf : Pointer; size : Integer) : LongInt; cdecl;
  _usb_get_descriptor : function(dev : PUSBDevHandle; _type : Byte; index : Byte;
    buf : Pointer; size : Integer) : LongInt; cdecl;
  _usb_bulk_write : function(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl;
  _usb_bulk_read : function(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl;
  _usb_interrupt_write : function(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl;
  _usb_interrupt_read : function(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl;
  _usb_control_msg : function(dev:PUSBDevHandle; requestType:Longint; request:Longint; value:Longint; index:Longint;
    bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl;
  _usb_set_configuration : function(dev:PUSBDevHandle; configuration:Longint):Longint; cdecl;
  _usb_claim_interface : function(dev:PUSBDevHandle; TheInterface:Longint):Longint; cdecl;
  _usb_release_interface : function(dev:PUSBDevHandle; TheInterface:Longint):Longint; cdecl;
  _usb_set_altinterface : function(dev:PUSBDevHandle; alternate:Longint):Longint; cdecl;
  _usb_resetep : function(dev:PUSBDevHandle; ep:Cardinal):Longint; cdecl;
  _usb_clear_halt : function(dev:PUSBDevHandle; ep:Cardinal):Longint; cdecl;
  _usb_reset : function(dev:PUSBDevHandle):Longint; cdecl;
  _usb_strerror : function : PChar; cdecl;
  _usb_init : procedure; cdecl;
  _usb_set_debug : procedure(level:Longint); cdecl;
  _usb_find_busses : function : Longint; cdecl;
  _usb_find_devices : function : Longint; cdecl;
  _usb_device : function(Dev:PUSBDevHandle):PUSBDevice; cdecl;
  _usb_get_busses : function : PUSBBus; cdecl;


function usb_open(dev : PUSBDevice):PUSBDevHandle; cdecl;
begin
  if Assigned(_usb_open) then
    Result := _usb_open(dev)
  else
    Result := nil;
end;

function usb_close(dev:PUSBDevHandle):Longint; cdecl;
begin
  if Assigned(_usb_close) then
    Result := _usb_close(dev)
  else
    Result := -ENOFILE;
end;

function usb_get_string(dev : PUSBDevHandle; index : LongInt;
  langid : LongInt; buf : PChar; buflen : Integer) : LongInt; cdecl;
begin
  if Assigned(_usb_get_string) then
    Result := _usb_get_string(dev, index, langid, buf, buflen)
  else
    Result := -ENOFILE;
end;

function usb_get_string_simple(dev : PUSBDevHandle; index : LongInt;
  buf : PChar; buflen : Integer) : LongInt; cdecl;
begin
  if Assigned(_usb_get_string_simple) then
    Result := _usb_get_string_simple(dev, index, buf, buflen)
  else
    Result := -ENOFILE;
end;

function usb_get_descriptor_by_endpoint(dev : PUSBDevHandle; ep : LongInt;
  _type : Byte; index : Byte; buf : Pointer; size : Integer) : LongInt; cdecl;
begin
  if Assigned(_usb_get_descriptor_by_endpoint) then
    Result := _usb_get_descriptor_by_endpoint(dev, ep, _type, index, buf, size)
  else
    Result := -ENOFILE;
end;

function usb_get_descriptor(dev : PUSBDevHandle; _type : Byte; index : Byte;
  buf : Pointer; size : Integer) : LongInt; cdecl;
begin
  if Assigned(_usb_get_descriptor) then
    Result := _usb_get_descriptor(dev, _type, index, buf, size)
  else
    Result := -ENOFILE;
end;

function usb_bulk_write(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl;
begin
  if Assigned(_usb_bulk_write) then
    Result := _usb_bulk_write(dev, ep, bytes, size, timeout)
  else
    Result := -ENOFILE;
end;

function usb_bulk_read(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl;
begin
  if Assigned(_usb_bulk_read) then
    Result := _usb_bulk_read(dev, ep, bytes, size, timeout)
  else
    Result := -ENOFILE;
end;

function usb_interrupt_write(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl;
begin
  if Assigned(_usb_interrupt_write) then
    Result := _usb_interrupt_write(dev, ep, bytes, size, timeout)
  else
    Result := -ENOFILE;
end;

function usb_interrupt_read(dev:PUSBDevHandle; ep:Longint; bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl;
begin
  if Assigned(_usb_interrupt_read) then
    Result := _usb_interrupt_read(dev, ep, bytes, size, timeout)
  else
    Result := -ENOFILE;
end;

function usb_control_msg(dev:PUSBDevHandle; requestType:Longint; request:Longint; value:Longint; index:Longint;
  bytes:PChar; size:Longint; timeout:Longint):Longint; cdecl;
begin
  if Assigned(_usb_control_msg) then
    Result := _usb_control_msg(dev, requestType, request, value, index, bytes, size, timeout)
  else
    Result := -ENOFILE;
end;

function usb_set_configuration(dev:PUSBDevHandle; configuration:Longint):Longint; cdecl;
begin
  if Assigned(_usb_set_configuration) then
    Result := _usb_set_configuration(dev, configuration)
  else
    Result := -ENOFILE;
end;

function usb_claim_interface(dev:PUSBDevHandle; TheInterface:Longint):Longint; cdecl;
begin
  if Assigned(_usb_claim_interface) then
    Result := _usb_claim_interface(dev, TheInterface)
  else
    Result := -ENOFILE;
end;

function usb_release_interface(dev:PUSBDevHandle; TheInterface:Longint):Longint; cdecl;
begin
  if Assigned(_usb_release_interface) then
    Result := _usb_release_interface(dev, TheInterface)
  else
    Result := -ENOFILE;
end;

function usb_set_altinterface(dev:PUSBDevHandle; alternate:Longint):Longint; cdecl;
begin
  if Assigned(_usb_set_altinterface) then
    Result := _usb_set_altinterface(dev, alternate)
  else
    Result := -ENOFILE;
end;

function usb_resetep(dev:PUSBDevHandle; ep:Cardinal):Longint; cdecl;
begin
  if Assigned(_usb_resetep) then
    Result := _usb_resetep(dev, ep)
  else
    Result := -ENOFILE;
end;

function usb_clear_halt(dev:PUSBDevHandle; ep:Cardinal):Longint; cdecl;
begin
  if Assigned(_usb_clear_halt) then
    Result := _usb_clear_halt(dev, ep)
  else
    Result := -ENOFILE;
end;

function usb_reset(dev:PUSBDevHandle):Longint; cdecl;
begin
  if Assigned(_usb_reset) then
    Result := _usb_reset(dev)
  else
    Result := -ENOFILE;
end;

function usb_strerror:PChar; cdecl;
begin
  if Assigned(_usb_strerror) then
    Result := _usb_strerror()
  else
    Result := nil;
end;

procedure usb_init; cdecl;
begin
  if Assigned(_usb_init) then
    _usb_init();
end;

procedure usb_set_debug(level:Longint); cdecl;
begin
  if Assigned(_usb_set_debug) then
    _usb_set_debug(level);
end;

function usb_find_busses : Longint; cdecl;
begin
  if Assigned(_usb_find_busses) then
    Result := _usb_find_busses()
  else
    Result := -ENOFILE;
end;

function usb_find_devices : Longint; cdecl;
begin
  if Assigned(_usb_find_devices) then
    Result := _usb_find_devices()
  else
    Result := -ENOFILE;
end;

function usb_device(dev:PUSBDevHandle):PUSBDevice; cdecl;
begin
  if Assigned(_usb_device) then
    Result := _usb_device(dev)
  else
    Result := nil;
end;

function usb_get_busses : PUSBBus; cdecl;
begin
  if Assigned(_usb_get_busses) then
    Result := _usb_get_busses()
  else
    Result := nil;
end;

var
  SaveExit: pointer;
  DLLHandle: THandle;
  ErrorMode: Integer;

procedure UnloadLibUSB;
begin
  if LibUSBLoaded then
  begin
    if DLLHandle >= 32 then
      FreeLibrary(DLLHandle);
    LibUSBLoaded := False;
  end;
end;

procedure NewExit; //far;
begin
  ExitProc := SaveExit;
  UnloadLibUSB;
end;

procedure LoadDLL;
begin
  if LibUSBLoaded then Exit;
  ErrorMode := SetErrorMode($8000{SEM_NoOpenFileErrorBox});
  DLLHandle := LoadLibrary('libusb0.dll');
  if DLLHandle >= 32 then
  begin
    LibUSBLoaded := True;
    SaveExit := ExitProc;
    ExitProc := @NewExit;
    @_usb_open := GetProcAddress(DLLHandle, 'usb_open');
    Assert(@_usb_open <> nil);
    @_usb_close := GetProcAddress(DLLHandle, 'usb_close');
    Assert(@_usb_close <> nil);
    @_usb_get_string := GetProcAddress(DLLHandle, 'usb_get_string');
    Assert(@_usb_get_string <> nil);
    @_usb_get_string_simple := GetProcAddress(DLLHandle, 'usb_get_string_simple');
    Assert(@_usb_get_string_simple <> nil);
    @_usb_get_descriptor_by_endpoint := GetProcAddress(DLLHandle, 'usb_get_descriptor_by_endpoint');
    Assert(@_usb_get_descriptor_by_endpoint <> nil);
    @_usb_get_descriptor := GetProcAddress(DLLHandle, 'usb_get_descriptor');
    Assert(@_usb_get_descriptor <> nil);
    @_usb_bulk_write := GetProcAddress(DLLHandle, 'usb_bulk_write');
    Assert(@_usb_bulk_write <> nil);
    @_usb_bulk_read := GetProcAddress(DLLHandle, 'usb_bulk_read');
    Assert(@_usb_bulk_read <> nil);
    @_usb_interrupt_write := GetProcAddress(DLLHandle, 'usb_interrupt_write');
    Assert(@_usb_interrupt_write <> nil);
    @_usb_interrupt_read := GetProcAddress(DLLHandle, 'usb_interrupt_read');
    Assert(@_usb_interrupt_read <> nil);
    @_usb_control_msg := GetProcAddress(DLLHandle, 'usb_control_msg');
    Assert(@_usb_control_msg <> nil);
    @_usb_set_configuration := GetProcAddress(DLLHandle, 'usb_set_configuration');
    Assert(@_usb_set_configuration <> nil);
    @_usb_claim_interface := GetProcAddress(DLLHandle, 'usb_claim_interface');
    Assert(@_usb_claim_interface <> nil);
    @_usb_release_interface := GetProcAddress(DLLHandle, 'usb_release_interface');
    Assert(@_usb_release_interface <> nil);
    @_usb_set_altinterface := GetProcAddress(DLLHandle, 'usb_set_altinterface');
    Assert(@_usb_set_altinterface <> nil);
    @_usb_resetep := GetProcAddress(DLLHandle, 'usb_resetep');
    Assert(@_usb_resetep <> nil);
    @_usb_clear_halt := GetProcAddress(DLLHandle, 'usb_clear_halt');
    Assert(@_usb_clear_halt <> nil);
    @_usb_reset := GetProcAddress(DLLHandle, 'usb_reset');
    Assert(@_usb_reset <> nil);
    @_usb_strerror := GetProcAddress(DLLHandle, 'usb_strerror');
    Assert(@_usb_strerror <> nil);
    @_usb_init := GetProcAddress(DLLHandle, 'usb_init');
    Assert(@_usb_init <> nil);
    @_usb_set_debug := GetProcAddress(DLLHandle, 'usb_set_debug');
    Assert(@_usb_set_debug <> nil);
    @_usb_find_busses := GetProcAddress(DLLHandle, 'usb_find_busses');
    Assert(@_usb_find_busses <> nil);
    @_usb_find_devices := GetProcAddress(DLLHandle, 'usb_find_devices');
    Assert(@_usb_find_devices <> nil);
    @_usb_device := GetProcAddress(DLLHandle, 'usb_device');
    Assert(@_usb_device <> nil);
    @_usb_get_busses := GetProcAddress(DLLHandle, 'usb_get_busses');
    Assert(@_usb_get_busses <> nil);
  end
  else
  begin
    LibUSBLoaded := False;
    { Error: libusb0.dll could not be loaded !! }
  end;
  SetErrorMode(ErrorMode)
end;


initialization
  LoadDLL;
{$ENDIF}

end.