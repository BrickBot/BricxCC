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
unit FANTOMFPC;

interface

uses
  {$IFDEF WIN32}Windows,{$ENDIF}FantomDefs;

{$I FANTOM_CONST.INC}

function createNXT(resString : PChar; var status : integer; checkFWversion : byte) : FantomHandle;
function createNXTIterator(searchBluetooth : byte; bluetoothSearchTimeout : Cardinal; var status : integer) : FantomHandle;
function iFile_getAvailableSize(fileHandle : FantomHandle; var status : integer) : Cardinal;
function iFile_getSize(fileHandle : FantomHandle; var status : integer) : Cardinal;
function iFileIterator_getFile(iterHandle : FantomHandle; var status : integer) : FantomHandle;
function iFileIterator_getSize(fileIterHandle : FantomHandle; var status : integer) : Cardinal;
function iModule_getIOMapSize(moduleHandle : FantomHandle; var status : integer) : Cardinal;
function iModule_getModuleID(moduleHandle : FantomHandle; var status : integer) : Cardinal;
function iModule_getModuleSize(moduleHandle : FantomHandle; var status : integer) : Cardinal;
function iModule_readIOMap(moduleHandle : FantomHandle; offset : Cardinal; numberBytesToRead : Cardinal; dataBuffer : PByte; var status : integer) : Cardinal;
function iModule_writeIOMap(moduleHandle : FantomHandle; offset : Cardinal; numberBytesToWrite : Cardinal; dataBuffer : PByte; var status : integer) : Cardinal;
function iModuleIterator_getModule(modIterHandle : FantomHandle; var status : integer) : FantomHandle;
function iNXT_createFile(nxtHandle : FantomHandle; const filename : PChar; var status : integer) : FantomHandle;
function iNXT_createFileIterator(nxtHandle : FantomHandle; filePattern : PChar; var status : integer) : FantomHandle;
function iNXT_createModule(nxtHandle : FantomHandle; moduleName : PChar; moduleID : Cardinal; moduleSize : Cardinal; IOMapSize : Cardinal; var status : integer) : FantomHandle;
function iNXT_createModuleIterator(nxtHandle : FantomHandle; moduleNamePattern : PChar; var status : integer) : FantomHandle;
function iNXT_pollAvailableLength(nxtHandle : FantomHandle; bufferSelector : Cardinal; var status : integer) : Cardinal;
function iNXT_readBufferData(nxtHandle : FantomHandle; dataBuffer : PByte; bufferSelector : Cardinal; numberOfBytesToRead : Cardinal; var status : integer) : Cardinal;
function iNXT_write(nxtHandle : FantomHandle; writeBuffer : PByte; writeBufferSize : Cardinal; var status : integer) : Cardinal;
function iNXTIterator_getNXT(nxtIterHandle : FantomHandle; var status : integer) : FantomHandle;

procedure destroyNXT(nxtHandle : FantomHandle; var status : integer);
procedure destroyNXTIterator(nxtIteratorHandle : FantomHandle; var status : integer);
procedure iFile_close(fileHandle : FantomHandle; var status : integer);
procedure iFile_getName(fileHandle : FantomHandle; filename : PChar; var status : integer);
procedure iFile_openForDataAppend(fileHandle : FantomHandle; var status : integer);
procedure iFile_openForDataWrite(fileHandle : FantomHandle; sizeInBytes : Cardinal; var status : integer);
procedure iFile_openForLinearWrite(fileHandle : FantomHandle; sizeInBytes : Cardinal; var status : integer);
procedure iFile_openForRead(fileHandle : FantomHandle; var status : integer);
procedure iFile_openForWrite(fileHandle : FantomHandle; fileSize : Cardinal; var status : integer);
procedure iFile_read(fileHandle : FantomHandle; fileDataBuffer : PByte; bufferSize : Cardinal; var status : integer);
procedure iFile_remove(fileHandle : FantomHandle; var status : integer);
procedure iFile_write(fileHandle : FantomHandle; writeBuffer : PByte; writeBufferLength : Cardinal; var status : integer);
procedure iFileIterator_advance(iterHandle : FantomHandle; var status : integer);
procedure iFileIterator_getName(iterHandle : FantomHandle; filename : PChar; var status : integer);
procedure iModule_getName(moduleHandle : FantomHandle; moduleName : PChar; var status : integer);
procedure iModuleIterator_advance(modIterHandle : FantomHandle; var status : integer);
procedure iModuleIterator_getName(modIterHandle : FantomHandle; moduleName : PChar; var status : integer);
procedure iNXT_bluetoothFactoryReset(nxtHandle : FantomHandle; var status : integer);
procedure iNXT_bootIntoFirmwareDownloadMode(resourceName : PChar; var status : integer);
procedure iNXT_destroyFile(nxtHandle : FantomHandle; fileHandle : FantomHandle; var status : integer);
procedure iNXT_destroyFileIterator(nxtHandle : FantomHandle; iterHandle : FantomHandle; var status : integer);
procedure iNXT_destroyModule(nxtHandle : FantomHandle; moduleHandle : FantomHandle; var status : integer);
procedure iNXT_destroyModuleIterator(nxtHandle : FantomHandle; modIterHandle : FantomHandle; var status : integer);
procedure iNXT_downloadFirmware(nxtHandle : FantomHandle; firmwareBuffer : PByte; firmwareBufferSize : Cardinal; var status : integer);
procedure iNXT_eraseUserFlash(nxtHandle : FantomHandle; var status : integer);
procedure iNXT_findDeviceInFirmwareDownloadMode(resString : PChar; var status : integer);
procedure iNXT_getDeviceInfo(nxtHandle : FantomHandle; name : PChar; address : PByte; signalStrength : PByte; var availableFlash : Cardinal; var status : integer);
procedure iNXT_getFirmwareVersion(nxtHandle : FantomHandle; var protocolVersionMajor, protocolVersionMinor, firmwareVersionMajor, firmwareVersionMinor : byte; var status : integer);
procedure iNXT_getResourceString(nxtHandle : FantomHandle; resString : PChar; var status : integer);
procedure iNXT_read(nxtHandle : FantomHandle; readBuffer : PByte; readBufferSize : Cardinal; var status : integer);
procedure iNXT_sendDirectCommand(nxtHandle : FantomHandle; requireResponse : byte; inputBufferPtr : Pbyte; inputBufferSize : Cardinal; outputBufferPtr : PByte; outputBufferSize : Cardinal; var status : integer);
procedure iNXT_setName(nxtHandle : FantomHandle; newName : PChar; var status : integer);
procedure iNXTIterator_advance(NXTIterHandle : FantomHandle; var status : integer);
procedure iNXTIterator_getName(NXTIterHandle : FantomHandle; resString : PChar; var status : integer);
procedure pairBluetooth(resourceName : PChar; passkey : PChar; pairedResourceName : PChar; var status : integer);
procedure unpairBluetooth(resourceName : PChar; var status : integer);
procedure FantomSDKClose;
procedure FantomSDKInit;

var
  FantomAPILoaded: Boolean = False;

procedure UnloadFantomAPI;

implementation

uses
  Classes, SysUtils, Math, libusb, rcx_cmd, rcx_constants, uCommonUtils, uSerial;

const USB_ID_VENDOR_LEGO = $0694;
const USB_ID_PRODUCT_NXT = $0002;
const USB_ID_VENDOR_ATMEL = $03EB;
const USB_ID_PRODUCT_SAMBA = $6124;

const USB_INTERFACE = 0;
const USB_OUT_ENDPOINT = $01;
const USB_IN_ENDPOINT  = $82;
const USB_TIMEOUT = 1000;
const DIRECT_COMMAND = 0;
const NO_RESP0NSE = $80;

function NXTSerialWrite(Handle: LongInt; Buffer : Pointer; Count: LongInt): LongInt;
var
  header : array[0..1] of Byte;
begin
  Result := 0;
  header[0] := Byte(Count and $FF);
  header[1] := Byte(Count shr 8);
  SerialWrite(Handle, header, 2);
  Result := SerialWrite(Handle, Buffer^, Count);
end;

function NXTSerialOpen(const DeviceName: String): LongInt;
begin
  Result := SerialOpen(DeviceName);
  if Result > 0 then
    SerialSetParams(Result, 460800, 8, 0, 1);
end;

function NXTSerialRead(Handle: LongInt; Buffer : Pointer; Count: LongInt; ms : LongInt): LongInt;
var
  header : array[0..1] of Byte;
  packetSize : integer;
  actual : integer;
begin
  Result := -1;
  if SerialRead(Handle, @header[0], 2, ms) <> 2 then
    Exit;

  packetSize := Integer(header[0]) + Integer(header[1]*256);
  if packetSize > Count then
    Exit;

  actual := SerialRead(Handle, Buffer, packetSize, ms);
  if actual <> packetSize then
    Exit;

  Result := actual;
end;

function is_nxt_fw_device(dev : PUSBDevice) : boolean;
begin
  Result :=
    (dev^.descriptor.idVendor = USB_ID_VENDOR_ATMEL) and
    (dev^.descriptor.idProduct = USB_ID_PRODUCT_SAMBA);
end;

function is_nxt_device(dev : PUSBDevice) : boolean;
begin
  Result :=
    (dev^.descriptor.idVendor = USB_ID_VENDOR_LEGO) and
    (dev^.descriptor.idProduct = USB_ID_PRODUCT_NXT);
end;

function is_nxt_serial_device(tmpHandle : LongInt; ms : integer) : boolean;
var
  cmd : TBaseCmd;
  len : integer;
  b : array[0..5] of Byte;
begin
  Result := False;
  // device is an NXT if it responds to a simple system or direct command
  if tmpHandle <> 0 then begin
    cmd := TBaseCmd.Create;
    try
      cmd.SetVal(kNXT_DirectCmd, kNXT_DCGetBatteryLevel);
      len := cmd.GetLength;
      if NXTSerialWrite(tmpHandle, cmd.GetBody, len) = len then
      begin
        if NXTSerialRead(tmpHandle, @b[0], 5, ms) = 5 then
          Result := True;
      end;
    finally
      cmd.Free;
    end;
  end;
end;

function FindNXTFirmwareDevice() : PUSBDevice;
var
  busses : PUSBBus;
  bus : PUSBBus;
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
      if is_nxt_fw_device(dev) then
      begin
        Result := dev;
        Exit;
      end;
      dev := dev^.next;
    end;
    bus := bus^.next;
  end;
  Result := nil;
end;

function UseUSB(const resStr : string) : boolean;
begin
  // resource string for USB has certain format
  // bluetooth version must always start with BTH::
  // USB version must always start with USB
  Result := Pos('USB', resStr) = 1;
{
  BTH::NXT=BTH::NXT::00:16:53:01:E2:CB::5
  NI-VISA-0::1=USB0::0X03EB::0X6124::NI-VISA-0::1::RAW
  NXT=USB0::0X0694::0X0002::00165301E2CB::RAW
}
end;

type
  TNxt = class;

  TNxtFile = class
  protected
    fNXT : TNxt;
    fFilename : string;
    fSize : integer;
    fAvailableSize : integer;
    fHandle : byte;
    fOpen : boolean;
  public
    constructor Create(aNXT : TNxt; const aFilename : string); virtual;
    destructor Destroy; override;
    procedure getName(var fileName : string);
    function  getSize(var status : integer) : Cardinal;
    function  getAvailableSize(var status : integer) : Cardinal;
    procedure openForRead(var status : integer);
    procedure openForWrite(sizeInBytes : Cardinal; var status : integer);
    procedure openForLinearWrite(sizeInBytes : Cardinal; var status : integer);
    procedure openForDataWrite(sizeInBytes : Cardinal; var status : integer);
    procedure openForDataAppend(var status : integer);
    procedure close(var status : integer);
    function  read(bufferPtr : PByte; numberOfBytes : Cardinal; var status : integer) : Cardinal;
    function  write(bufferPtr : PByte; numberOfBytes : Cardinal; var status : integer) : Cardinal;
    procedure remove(var status : integer);
  end;

  TNxtFileIterator = class
  protected
    fNXT : TNxt;
    fPattern : string;
    fFileName : string;
    fSize : Cardinal;
    fValid : boolean;
    fFirstTime : boolean;
    fHandle : byte;
    procedure CloseFileHandle(var status : integer);
  public
    constructor Create(aNXT : TNxt; const aPattern : string); virtual;
    destructor Destroy; override;
    function  getFile(var status : integer) : TNxtFile;
    procedure advance(var status : integer);
    procedure getName(var filename : string; var status : integer);
    function  getSize(var status : integer) : Cardinal;
  end;

  TNxtIModule = class
  protected
    fNXT : TNxt;
    fModuleName : string;
    fModuleID : Cardinal;
    fSize : Cardinal;
    fIOMapSize : Cardinal;
  public
    constructor Create(aNXT : TNxt); virtual;
    destructor Destroy; override;
    procedure getName(var moduleName : string);
    function  getModuleID : Cardinal;
    function  getModuleSize : Cardinal;
    function  getModuleIOMapSize : Cardinal;
    function  readIOMap(offsetInBytes, numberOfBytes : Cardinal; dataBufferPtr : PByte; var status : integer) : Cardinal;
    function  writeIOMap(offsetInBytes, numberOfBytes : Cardinal; dataBufferPtr : PByte; var status : integer) : Cardinal;
  end;

  TNxtIModuleIterator = class
  protected
    fNXT : TNxt;
    fPattern : string;
    fModuleName : string;
    fModuleID : Cardinal;
    fSize : Cardinal;
    fIOMapSize : Cardinal;
    fValid : boolean;
    fFirstTime : boolean;
    fHandle : byte;
    procedure CloseModuleHandle(var status : integer);
  public
    constructor Create(aNXT : TNxt; const aPattern : string); virtual;
    destructor Destroy; override;
    function  getModule(var status : integer) : TNxtIModule;
    procedure advance(var status : integer);
    procedure getName(var moduleName : string; var status : integer);
  end;

  TNxtIterator = class
  protected
    fBusses : PUSBBus;
    fBus : PUSBBus;
    fDev : PUSBDevice;
    fDevHandle : PUSBDevHandle;
    fSerialHandle : LongInt;
    fNXTViaUSB : boolean;
    fCurSerialIdx : integer;
    fSearchBT : boolean;
    fBTTimeout : Cardinal;
    fBTSeconds : Cardinal;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function  getNXT(var status : integer) : TNxt;
    procedure advance(var status : integer);
    procedure getName(var resourceName : string; var status : integer);
  end;

  TNxt = class
  protected
    fDev : PUSBDevice;
    fDevHandle : PUSBDevHandle;
    fSerialHandle : LongInt;
    fNXTViaUSB : boolean;
    fPort : string;
    fCheckver : boolean;
    fTimeout : integer;
    function SetResourceString(resStr : string) : integer;
    function CorrectDeviceFound : boolean;
    procedure IgnoreResponse(n : integer; var status : integer);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function createFile(const fileName : string; var status : integer) : TNxtFile;
    procedure destroyFile(var filePtr : TNxtFile);
    function createFileIterator(const fileNamePattern : string; var status : integer) : TNxtFileIterator;
    procedure destroyFileIterator(var fileIteratorPtr : TNxtFileIterator);
    function createModule(const moduleName : string;
      moduleID, moduleSizeInBytes, ioMapSizeInBytes : Cardinal; var status : integer) : TNxtIModule;
    procedure destroyModule(var modulePtr : TNxtIModule);
    function createModuleIterator(const moduleNamePattern : string; var status : integer) : TNxtIModuleIterator;
    procedure destroyModuleIterator(var moduleIteratorPtr : TNxtIModuleIterator);
    // API
    procedure getFirmwareVersion(var protocolVersionMajorRef : Byte;
          var protocolVersionMinorRef : Byte; var firmwareVersionMajorRef : Byte;
          var firmwareVersionMinorRef : Byte; var status : integer);
    function sendDirectCommand(requireResponse : boolean; const commandBufferPtr : PByte;
          commandBufferSizeInBytes : Cardinal; responseBufferPtr : PByte;
          responseBufferSizeInBytes : Cardinal; var status : integer) : Cardinal;
    procedure downloadFirmware(const firmwareBufferPtr : PByte;
          firmwareBufferSizeInBytes : Cardinal; var status : integer);
    function write(const bufferPtr : PByte; numberOfBytes : Cardinal;
          var status : integer) : Cardinal;
    function read(bufferPtr : PByte; numberOfBytes : Cardinal; var status : integer) : Cardinal;
    procedure bootIntoFirmwareDownloadMode(var status : integer);
    procedure setName(const newName : string; var status : integer);
    procedure getDeviceInfo(var name : string; bluetoothAddress : PByte;
          signalStrength : PByte; var availableFlash : Cardinal; var status : integer);
    procedure eraseUserFlash(var status : integer);
    function pollAvailableLength(bufferSelector : byte; var status : integer) : Cardinal;
    function readBufferData(dataBuffer : PByte; bufferSelector : byte;
          numberOfBytesToRead : Cardinal; var status : integer) : Cardinal;
    procedure getResourceString(var resString : string; var status : integer);
    procedure bluetoothFactoryReset(var status : integer);
    class function createNXT(const resString : string;
          var status : integer; checkFirmwareVersion : boolean = true) : TNxt;
    class procedure destroyNXT(var nxtPtr : TNxt);
    class function createNXTIterator(searchBluetooth : boolean;
          bluetoothSearchTimeoutInSeconds : cardinal; var status : integer) : TNxtIterator;
    class procedure destroyNXTIterator(iterPtr : TNxtIterator);
    class procedure pairBluetooth(const resourceName : string;
          const passkey : string; var pairedResourceName : string; var status : integer);
    class procedure unpairBluetooth(const resourceName : string; var status : integer);
    class function isPaired(const resourceName : string; var status : integer) : boolean;
    class procedure findDeviceInFirmwareDownloadMode(var resourceName : string;
          var status : integer);
  end;

function ConvertStatus(const fwStatus : byte) : integer;
begin
  case fwStatus of
    // each of these cases corresponds to a unique status code returned by the firmware
    $00 : Result := kStatusNoError;
    $81 : Result := kStatusFWNoMoreHandles; // No more available handles
    $82 : Result := kStatusFWNoSpace;   // No space
    $83 : Result := kStatusFWNoMoreFiles; // No more files
    $84 : Result := kStatusFWEndOfFileExpected; // End of file expected
    $85 : Result := kStatusFWEndOfFile; // End of file reached
    $86 : Result := kStatusFWNotLinearFile; // Not a linear file
    $87 : Result := kStatusFWFileNotFound; // File not found
    $88 : Result := kStatusFWHandleAlreadyClosed; // Handle is already closed
    $89 : Result := kStatusFWNoLinearSpace; // No linear space available
    $8A : Result := kStatusFWUndefinedError; // Undefined error
    $8B : Result := kStatusFWFileIsBusy; // File is busy
    $8C : Result := kStatusFWNoWriteBuffers; // No write buffers available
    $8D : Result := kStatusFWAppendNotPossible; // Append not possible
    $8E : Result := kStatusFWFileIsFull; // File is full
    $8F : Result := kStatusFWFileExists; // File already exists
    $90 : Result := kStatusFWModuleNotFound; // Module not found
    $91 : Result := kStatusFWOutOfBounds; // Out of module I/O map boundary
    $92 : Result := kStatusFWIllegalFileName; // Illegal file name
    $93 : Result := kStatusFWIllegalHandle; // Illegal handle
  else
    Result := kStatusFWUnknownErrorCode;
  end;
end;

function GetUSBResString(dev : PUSBDevice; handle : PUSBDevHandle) : string;
var
  buf : PChar;
begin
  buf := nil;
  GetMem(buf, 256);
  try
    with dev^.descriptor, dev^.config^ do
    begin
      if handle <> nil then
        usb_get_string_simple(handle, iSerialNumber, buf, 255)
      else
        StrPCopy(buf, 'NI-VISA-1::1'); // firmware mode
      Result := Format('USB%d::0X%4.4X::0X%4.4X::%s::RAW', [iConfiguration, idVendor, idProduct, buf]);
    end;
  finally
    FreeMem(buf);
  end;
// USB0::0X03EB::0X6124::NI-VISA-1::1::RAW
// USB0::0X0694::0X0002::001653FF0156::RAW
end;

function GetSerialResString(handle : LongInt; ms : integer) : string;
var
  name : string;
  b : array[0..5] of byte;
  cmd : TBaseCmd;
  buf : array[0..32] of Byte;
  p : PByte;
  len, size, i : integer;
begin
  result := '';
  b[0] := 0;
  // send a GetDeviceInfo system command to the device on this port
  // and see if you get back a valid response.
  // if so, then build a resource string using the values in the response.
  cmd := TBaseCmd.Create;
  try
    cmd.SetVal(kNXT_SystemCmd, kNXT_SCGetDeviceInfo);
    len := cmd.GetLength;
    if NXTSerialWrite(handle, cmd.GetBody, len) = len then
    begin
      size := 33;
      len := NXTSerialRead(handle, @buf[0], size, ms);
      if (len = size) and (buf[2] = 0) then
      begin
        name := '';
        for i := 3 to 17 do
          if buf[i] <> 0 then
            name := name + Char(buf[i]);
        p := @buf[18];
        Move(p^, b, 6);
      end
      else
        Exit;
    end;
  finally
    cmd.Free;
  end;
  Result := Format('BTH::%s::%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x::%d',
                   [name, b[0], b[1], b[2], b[3], b[4], b[5], 5]);
//BTH::NXT::00:16:53:01:E2:CB::5
end;

procedure UnloadFantomAPI;
begin
  if FantomAPILoaded then
  begin
    // unload something ?
    FantomAPILoaded := False;
  end;
end;

function createNXT(resString : PChar; var status : integer;
  checkFWversion : byte) : FantomHandle;
var
  tmp : TNxt;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  tmp := TNxt.createNXT(resString, status, Boolean(checkFWversion));
  Result := FantomHandle(tmp);
end;

function createNXTIterator(searchBluetooth : byte; bluetoothSearchTimeout : Cardinal;
  var status : integer) : FantomHandle;
var
  tmp : TNxtIterator;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  tmp := TNxt.createNXTIterator(Boolean(searchBluetooth), bluetoothSearchtimeout, status);
  Result := FantomHandle(tmp);
end;

function iFile_getAvailableSize(fileHandle : FantomHandle; var status : integer) : Cardinal;
var
  tmp : TNxtFile;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFile(fileHandle);
    Result := tmp.getAvailableSize(status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iFile_getSize(fileHandle : FantomHandle; var status : integer) : Cardinal;
var
  tmp : TNxtFile;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFile(fileHandle);
    Result := tmp.getSize(status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iFileIterator_getFile(iterHandle : FantomHandle; var status : integer) : FantomHandle;
var
  tmp : TNxtFileIterator;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFileIterator(iterHandle);
    Result := FantomHandle(tmp.getFile(status));
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iFileIterator_getSize(fileIterHandle : FantomHandle; var status : integer) : Cardinal;
var
  tmp : TNxtFileIterator;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFileIterator(fileIterHandle);
    Result := tmp.getSize(status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iModule_getIOMapSize(moduleHandle : FantomHandle; var status : integer) : Cardinal;
var
  tmp : TNxtIModule;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtIModule(moduleHandle);
    Result := tmp.getModuleIOMapSize();
    status := kStatusNoError;
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iModule_getModuleID(moduleHandle : FantomHandle; var status : integer) : Cardinal;
var
  tmp : TNxtIModule;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtIModule(moduleHandle);
    Result := tmp.getModuleID();
    status := kStatusNoError;
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iModule_getModuleSize(moduleHandle : FantomHandle; var status : integer) : Cardinal;
var
  tmp : TNxtIModule;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtIModule(moduleHandle);
    Result := tmp.getModuleSize();
    status := kStatusNoError;
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iModule_readIOMap(moduleHandle : FantomHandle; offset : Cardinal;
  numberBytesToRead : Cardinal; dataBuffer : PByte; var status : integer) : Cardinal;
var
  tmp : TNxtIModule;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtIModule(moduleHandle);
    Result := tmp.readIOMap(offset, numberBytesToRead, dataBuffer, status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iModule_writeIOMap(moduleHandle : FantomHandle; offset : Cardinal;
  numberBytesToWrite : Cardinal; dataBuffer : PByte; var status : integer) : Cardinal;
var
  tmp : TNxtIModule;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtIModule(moduleHandle);
    Result := tmp.writeIOMap(offset, numberBytesToWrite, dataBuffer, status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iModuleIterator_getModule(modIterHandle : FantomHandle;
  var status : integer) : FantomHandle;
var
  tmp : TNxtIModuleIterator;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtIModuleIterator(modIterHandle);
    Result := FantomHandle(tmp.getModule(status));
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iNXT_createFile(nxtHandle : FantomHandle; const filename : PChar;
  var status : integer) : FantomHandle;
var
  tmp : TNxt;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    Result := FantomHandle(tmp.createFile(filename, status));
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iNXT_createFileIterator(nxtHandle : FantomHandle; filePattern : PChar;
  var status : integer) : FantomHandle;
var
  tmp : TNxt;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    Result := FantomHandle(tmp.createFileIterator(filePattern, status));
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iNXT_createModule(nxtHandle : FantomHandle; moduleName : PChar;
  moduleID : Cardinal; moduleSize : Cardinal; IOMapSize : Cardinal;
  var status : integer) : FantomHandle;
var
  tmp : TNxt;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    Result := FantomHandle(tmp.createModule(moduleName, moduleID, moduleSize, IOMapSize, status));
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iNXT_createModuleIterator(nxtHandle : FantomHandle;
  moduleNamePattern : PChar; var status : integer) : FantomHandle;
var
  tmp : TNxt;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    Result := FantomHandle(tmp.createModuleIterator(moduleNamePattern, status));
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iNXT_pollAvailableLength(nxtHandle : FantomHandle;
  bufferSelector : Cardinal; var status : integer) : Cardinal;
var
  tmp : TNxt;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    Result := tmp.pollAvailableLength(Byte(bufferSelector), status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iNXT_readBufferData(nxtHandle : FantomHandle; dataBuffer : PByte;
  bufferSelector : Cardinal; numberOfBytesToRead : Cardinal; var status : integer) : Cardinal;
var
  tmp : TNxt;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    Result := tmp.readBufferData(dataBuffer, Byte(bufferSelector), numberOfBytesToRead, status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iNXT_write(nxtHandle : FantomHandle; writeBuffer : PByte;
  writeBufferSize : Cardinal; var status : integer) : Cardinal;
var
  tmp : TNxt;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    Result := tmp.write(writeBuffer, writeBufferSize, status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

function iNXTIterator_getNXT(nxtIterHandle : FantomHandle; var status : integer) : FantomHandle;
var
  tmp : TNxtIterator;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtIterator(nxtIterHandle);
    Result := FantomHandle(tmp.getNXT(status));
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure destroyNXT(nxtHandle : FantomHandle; var status : integer);
var
  tmp : TNxt;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    FreeAndNil(tmp);
    status := kStatusNoError;
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure destroyNXTIterator(nxtIteratorHandle : FantomHandle; var status : integer);
var
  tmp : TNxtIterator;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtIterator(nxtIteratorHandle);
    FreeAndNil(tmp);
    status := kStatusNoError;
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iFile_close(fileHandle : FantomHandle; var status : integer);
var
  tmp : TNxtFile;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFile(fileHandle);
    tmp.close(status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iFile_getName(fileHandle : FantomHandle; filename : PChar;
  var status : integer);
var
  tmp : TNxtFile;
  tmpName : string;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFile(fileHandle);
    tmpName := '';
    tmp.getName(tmpName);
    StrPCopy(filename, tmpName);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iFile_openForDataAppend(fileHandle : FantomHandle; var status : integer);
var
  tmp : TNxtFile;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFile(fileHandle);
    tmp.openForDataAppend(status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iFile_openForDataWrite(fileHandle : FantomHandle; sizeInBytes : Cardinal;
  var status : integer);
var
  tmp : TNxtFile;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFile(fileHandle);
    tmp.openForDataWrite(sizeInBytes, status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iFile_openForLinearWrite(fileHandle : FantomHandle; sizeInBytes : Cardinal;
  var status : integer);
var
  tmp : TNxtFile;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFile(fileHandle);
    tmp.openForLinearWrite(sizeInBytes, status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iFile_openForRead(fileHandle : FantomHandle; var status : integer);
var
  tmp : TNxtFile;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFile(fileHandle);
    tmp.openForRead(status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iFile_openForWrite(fileHandle : FantomHandle; fileSize : Cardinal;
  var status : integer);
var
  tmp : TNxtFile;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFile(fileHandle);
    tmp.openForWrite(fileSize, status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iFile_read(fileHandle : FantomHandle; fileDataBuffer : PByte;
  bufferSize : Cardinal; var status : integer);
var
  tmp : TNxtFile;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFile(fileHandle);
    tmp.read(fileDataBuffer, bufferSize, status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iFile_remove(fileHandle : FantomHandle; var status : integer);
var
  tmp : TNxtFile;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFile(fileHandle);
    tmp.remove(status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iFile_write(fileHandle : FantomHandle; writeBuffer : PByte;
  writeBufferLength : Cardinal; var status : integer);
var
  tmp : TNxtFile;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFile(fileHandle);
    tmp.write(writeBuffer, writeBufferLength, status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iFileIterator_advance(iterHandle : FantomHandle; var status : integer);
var
  tmp : TNxtFileIterator;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFileIterator(iterHandle);
    tmp.advance(status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iFileIterator_getName(iterHandle : FantomHandle; filename : PChar;
  var status : integer);
var
  tmp : TNxtFileIterator;
  tmpName : string;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtFileIterator(iterHandle);
    tmpName := '';
    tmp.getName(tmpName, status);
    StrPCopy(filename, tmpName);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iModule_getName(moduleHandle : FantomHandle; moduleName : PChar;
  var status : integer);
var
  tmp : TNxtIModule;
  tmpName : string;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtIModule(moduleHandle);
    tmpName := '';
    tmp.getName(tmpName);
    StrPCopy(moduleName, tmpName);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iModuleIterator_advance(modIterHandle : FantomHandle; var status : integer);
var
  tmp : TNxtIModuleIterator;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtIModuleIterator(modIterHandle);
    tmp.advance(status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iModuleIterator_getName(modIterHandle : FantomHandle; moduleName : PChar;
  var status : integer);
var
  tmp : TNxtIModuleIterator;
  tmpName : string;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtIModuleIterator(modIterHandle);
    tmpName := '';
    tmp.getName(tmpName, status);
    StrPCopy(moduleName, tmpName);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXT_bluetoothFactoryReset(nxtHandle : FantomHandle; var status : integer);
var
  tmp : TNxt;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    tmp.bluetoothFactoryReset(status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXT_bootIntoFirmwareDownloadMode(resourceName : PChar;
  var status : integer);
var
  tmp : TNxt;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt.createNXT(resourceName, status, False);
    tmp.bootIntoFirmwareDownloadMode(status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXT_destroyFile(nxtHandle : FantomHandle; fileHandle : FantomHandle;
  var status : integer);
var
  tmp : TNxt;
  tmpFile : TNxtFile;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    tmpFile := TNxtFile(fileHandle);
    tmp.destroyFile(tmpFile);
    status := kStatusNoError;
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXT_destroyFileIterator(nxtHandle : FantomHandle; iterHandle : FantomHandle;
  var status : integer);
var
  tmp : TNxt;
  tmpFileIter : TNxtFileIterator;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    tmpFileIter := TNxtFileIterator(iterHandle);
    tmp.destroyFileIterator(tmpFileIter);
    status := kStatusNoError;
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXT_destroyModule(nxtHandle : FantomHandle; moduleHandle : FantomHandle;
  var status : integer);
var
  tmp : TNxt;
  tmpMod : TNxtIModule;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    tmpMod := TNxtIModule(moduleHandle);
    tmp.destroyModule(tmpMod);
    status := kStatusNoError;
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXT_destroyModuleIterator(nxtHandle : FantomHandle;
  modIterHandle : FantomHandle; var status : integer);
var
  tmp : TNxt;
  tmpModIter : TNxtIModuleIterator;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    tmpModIter := TNxtIModuleIterator(modIterHandle);
    tmp.destroyModuleIterator(tmpModIter);
    status := kStatusNoError;
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXT_downloadFirmware(nxtHandle : FantomHandle; firmwareBuffer : PByte;
  firmwareBufferSize : Cardinal; var status : integer);
var
  tmp : TNxt;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    tmp.downloadFirmware(firmwareBuffer, firmwareBufferSize, status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXT_eraseUserFlash(nxtHandle : FantomHandle; var status : integer);
var
  tmp : TNxt;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    tmp.eraseUserFlash(status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXT_findDeviceInFirmwareDownloadMode(resString : PChar;
  var status : integer);
var
  tmpStr : string;
begin
  if status < kStatusNoError then Exit;
  try
    tmpStr := '';
    TNxt.findDeviceInFirmwareDownloadMode(tmpStr, status);
    StrPCopy(resString, tmpStr);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXT_getDeviceInfo(nxtHandle : FantomHandle; name : PChar; address : PByte;
  signalStrength : PByte; var availableFlash : Cardinal; var status : integer);
var
  tmp : TNxt;
  tmpName : string;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    tmpName := '';
    tmp.getDeviceInfo(tmpName, address, signalStrength, availableFlash, status);
    StrPCopy(name, tmpName);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXT_getFirmwareVersion(nxtHandle : FantomHandle; var protocolVersionMajor,
  protocolVersionMinor, firmwareVersionMajor, firmwareVersionMinor : byte;
  var status : integer);
var
  tmp : TNxt;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    tmp.getFirmwareVersion(protocolVersionMajor, protocolVersionMinor,
                           firmwareVersionMajor, firmwareVersionMinor, status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXT_getResourceString(nxtHandle : FantomHandle; resString : PChar;
  var status : integer);
var
  tmp : TNxt;
  tmpResString : string;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    tmpResString := '';
    tmp.getResourceString(tmpResString, status);
    StrPCopy(resString, tmpResString);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXT_read(nxtHandle : FantomHandle; readBuffer : PByte;
  readBufferSize : Cardinal; var status : integer);
var
  tmp : TNxt;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    tmp.read(readBuffer, readBufferSize, status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXT_sendDirectCommand(nxtHandle : FantomHandle; requireResponse : byte;
  inputBufferPtr : Pbyte; inputBufferSize : Cardinal; outputBufferPtr : PByte;
  outputBufferSize : Cardinal; var status : integer);
var
  tmp : TNxt;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    tmp.sendDirectCommand(Boolean(requireResponse),
      inputBufferPtr, inputBufferSize,
      outputBufferPtr, outputBufferSize, status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXT_setName(nxtHandle : FantomHandle; newName : PChar; var status : integer);
var
  tmp : TNxt;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxt(nxtHandle);
    tmp.setName(newName, status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXTIterator_advance(NXTIterHandle : FantomHandle; var status : integer);
var
  tmp : TNxtIterator;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtIterator(NXTIterHandle);
    tmp.advance(status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure iNXTIterator_getName(NXTIterHandle : FantomHandle; resString : PChar;
  var status : integer);
var
  tmp : TNxtIterator;
  tmpResName : string;
begin
  if status < kStatusNoError then Exit;
  try
    tmp := TNxtIterator(NXTIterHandle);
    tmpResName := '';
    tmp.getName(tmpResName, status);
    StrPCopy(resString, tmpResName);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure pairBluetooth(resourceName : PChar; passkey : PChar;
  pairedResourceName : PChar; var status : integer);
var
  tmpPRN : string;
begin
  if status < kStatusNoError then Exit;
  try
    tmpPRN := '';
    TNxt.pairBluetooth(resourceName, passkey, tmpPRN, status);
    StrPCopy(pairedResourceName, tmpPRN);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure unpairBluetooth(resourceName : PChar; var status : integer);
begin
  if status < kStatusNoError then Exit;
  try
    TNxt.unpairBluetooth(resourceName, status);
  except
    status := kStatusFWIllegalHandle;
  end;
end;

procedure FantomSDKClose;
begin
// uninitialize usb stuff
end;

procedure FantomSDKInit;
begin
// initialize USB stuff
  usb_init();
//  usb_set_debug(5);
  FantomAPILoaded := True;
end;

{ TNxt }

procedure TNxt.bluetoothFactoryReset(var status: integer);
var
  cmd : TBaseCmd;
begin
  if status < kStatusNoError then Exit;
  // TODO: do I need to check the response or not?
  cmd := TBaseCmd.Create;
  try
    cmd.SetVal(kNXT_SystemCmdNoReply, kNXT_SCBTFactoryReset);
    write(cmd.GetBody, cmd.GetLength, status);
  finally
    cmd.Free;
  end;
end;

procedure TNxt.bootIntoFirmwareDownloadMode(var status: integer);
var
  cmd : TNxtCmd;
begin
  if status < kStatusNoError then Exit;
  cmd := TNxtCmd.Create;
  try
    cmd.MakeBoot(True);
    write(cmd.GetBody, cmd.GetLength, status);
    IgnoreResponse(7, status);
  finally
    cmd.Free;
  end;
end;

function TNxt.CorrectDeviceFound: boolean;
var
  tmpStr : string;
begin
  if fNXTViaUSB then
    tmpStr := GetUSBResString(fDev, fDevHandle)
  else
    tmpStr := GetSerialResString(fSerialHandle, fTimeout);
  Result := AnsiCompareText(fPort, tmpStr) = 0;
end;

constructor TNxt.Create;
begin
  inherited Create;
  fDev          := nil;
  fDevHandle    := nil;
  fSerialHandle := 0;
  fNXTViaUSB 	:= True;
  fPort      	:= '';
  fCheckver  	:= False;
  fTimeout   	:= USB_TIMEOUT;
end;

function TNxt.createFile(const fileName: string; var status: integer): TNxtFile;
begin
  Result := nil;
  if status < kStatusNoError then Exit;
  Result := TNxtFile.Create(self, fileName);
  status := kStatusNoError;
end;

function TNxt.createFileIterator(const fileNamePattern: string;
  var status: integer): TNxtFileIterator;
begin
  Result := nil;
  if status < kStatusNoError then Exit;
  Result := TNxtFileIterator.Create(self, fileNamePattern);
  Result.advance(status);
end;

function TNxt.createModule(const moduleName: string; moduleID,
  moduleSizeInBytes, ioMapSizeInBytes: Cardinal;
  var status: integer): TNxtIModule;
begin
  Result := nil;
  if status < kStatusNoError then Exit;
  Result := TNxtIModule.Create(self);
  Result.fModuleName := moduleName;
  Result.fModuleID   := moduleID;
  Result.fSize       := moduleSizeInBytes;
  Result.fIOMapSize  := ioMapSizeInBytes;
  status := kStatusNoError;
end;

function TNxt.createModuleIterator(const moduleNamePattern: string;
  var status: integer): TNxtIModuleIterator;
begin
  Result := nil;
  if status < kStatusNoError then Exit;
  Result := TNxtIModuleIterator.Create(self, moduleNamePattern);
  Result.advance(status);
end;

class function TNxt.createNXT(const resString: string; var status: integer;
  checkFirmwareVersion: boolean): TNxt;
begin
  Result := nil;
  if status < kStatusNoError then Exit;
  Result := TNxt.Create;
  Result.fCheckver := checkFirmwareVersion;
  status := Result.SetResourceString(resString);
end;

class function TNxt.createNXTIterator(searchBluetooth: boolean;
  bluetoothSearchTimeoutInSeconds: cardinal;
  var status: integer): TNxtIterator;
begin
  Result := nil;
  if status < kStatusNoError then Exit;
  Result := TNxtIterator.Create;
  Result.fSearchBT := searchBluetooth;
  Result.fBTSeconds := bluetoothSearchTimeoutInSeconds;
  usb_find_busses();
  usb_find_devices();
  Result.fBusses := usb_get_busses();
  Result.fDev := nil;
  Result.fBus := nil;
  Result.advance(status);
end;

destructor TNxt.Destroy;
begin
  if fDevHandle <> nil then begin
    usb_release_interface(fDevHandle, USB_INTERFACE);
    usb_close(fDevHandle);
    fDevHandle := nil;
  end;
  if fSerialHandle <> 0 then begin
    SerialClose(fSerialHandle);
    fSerialHandle := 0;
  end;
  inherited;
end;

procedure TNxt.destroyFile(var filePtr: TNxtFile);
begin
  FreeAndNil(filePtr);
end;

procedure TNxt.destroyFileIterator(var fileIteratorPtr: TNxtFileIterator);
begin
  FreeAndNil(fileIteratorPtr);
end;

procedure TNxt.destroyModule(var modulePtr: TNxtIModule);
begin
  FreeAndNil(modulePtr);
end;

procedure TNxt.destroyModuleIterator(var moduleIteratorPtr: TNxtIModuleIterator);
begin
  FreeAndNil(moduleIteratorPtr);
end;

class procedure TNxt.destroyNXT(var nxtPtr: TNxt);
begin
  FreeAndNil(nxtPtr);
end;

class procedure TNxt.destroyNXTIterator(iterPtr: TNxtIterator);
begin
  FreeAndNil(iterPtr);
end;

procedure TNxt.downloadFirmware(const firmwareBufferPtr: PByte;
  firmwareBufferSizeInBytes: Cardinal; var status: integer);
begin
  // TODO: Firmware download is not currently supported.
  if not Assigned(firmwareBufferPtr) then Exit;
  if firmwareBufferSizeInBytes = 0 then Exit;
  if status < kStatusNoError then Exit;
  status := kStatusFirmwareDownloadFailed;
end;

procedure TNxt.eraseUserFlash(var status: integer);
var
  cmd : TBaseCmd;
  buf : array[0..2] of Byte;
  len, size, oldTimeout : integer;
begin
  if status < kStatusNoError then Exit;
  cmd := TBaseCmd.Create;
  try
    cmd.SetVal(kNXT_SystemCmd, kNXT_SCDeleteUserFlash);
    write(cmd.GetBody, cmd.GetLength, status);
    size := 3;
    oldTimeout := fTimeout;
    try
      fTimeout := 3000;
      len := read(@buf[0], size, status);
    finally
      fTimeout := oldTimeout;
    end;
    if (len = size) and (buf[2] = 0) then
    begin
      status := kStatusNoError;
    end
    else
      status := ConvertStatus(buf[2]);
  finally
    cmd.Free;
  end;
end;

class procedure TNxt.findDeviceInFirmwareDownloadMode(
  var resourceName: string; var status: integer);
var
  dev : PUSBDevice;
begin
  // this always uses USB mode
  if status < kStatusNoError then Exit;
  resourceName := '';
  status := kStatusNoMoreItemsFound;
  dev := FindNXTFirmwareDevice;
  if dev <> nil then
  begin
    resourceName := GetUSBResString(dev, nil); // nil means Firmware Mode
    status := kStatusNoError;
  end;
end;

procedure TNxt.getDeviceInfo(var name: string; bluetoothAddress,
  signalStrength: PByte; var availableFlash: Cardinal;
  var status: integer);
var
  cmd : TBaseCmd;
  buf : array[0..32] of Byte;
  p : PByte;
  len, size, i : integer;
begin
  if status < kStatusNoError then Exit;
  cmd := TBaseCmd.Create;
  try
    cmd.SetVal(kNXT_SystemCmd, kNXT_SCGetDeviceInfo);
    write(cmd.GetBody, cmd.GetLength, status);
    size := 33;
    len := read(@buf[0], size, status);
    if (len = size) and (buf[2] = 0) then
    begin
      name := '';
      for i := 3 to 17 do
        name := name + Char(buf[i]);
      p := @buf[18];
      Move(p^, bluetoothAddress^, 6);
      inc(p, 7);
      Move(p^, signalStrength^, 4);
      availableFlash := BytesToCardinal(buf[29], buf[30], buf[31], buf[32]);
      status := kStatusNoError;
    end
    else
      status := ConvertStatus(buf[2]);
  finally
    cmd.Free;
  end;
end;

procedure TNxt.getFirmwareVersion(var protocolVersionMajorRef,
  protocolVersionMinorRef, firmwareVersionMajorRef,
  firmwareVersionMinorRef: Byte; var status: integer);
var
  cmd : TBaseCmd;
  buf : array[0..6] of Byte;
  len, size : integer;
begin
  if status < kStatusNoError then Exit;
  cmd := TBaseCmd.Create;
  try
    cmd.SetVal(kNXT_SystemCmd, kNXT_SCGetVersions);
    write(cmd.GetBody, cmd.GetLength, status);
    size := 7;
    len := read(@buf[0], size, status);
    if (len = size) and (buf[2] = 0) then
    begin
      protocolVersionMajorRef := buf[4];
      protocolVersionMinorRef := buf[3];
      firmwareVersionMajorRef := buf[6];
      firmwareVersionMinorRef := buf[5];
      status := kStatusNoError;
    end
    else
      status := ConvertStatus(buf[2]);
  finally
    cmd.Free;
  end;
end;

procedure TNxt.getResourceString(var resString: string;
  var status: integer);
begin
  if status < kStatusNoError then Exit;
  resString := fPort;
  status := kStatusNoError;
end;

procedure TNxt.IgnoreResponse(n: integer; var status : integer);
var
  buf : PByte;
begin
  buf := nil;
  GetMem(buf, n);
  try
    read(buf, n, status);
  finally
    FreeMem(buf);
  end;
end;

class function TNxt.isPaired(const resourceName: string;
  var status: integer): boolean;
begin
  Result := False;
  if resourceName = '' then Exit;
  if status < kStatusNoError then Exit;
  status := kStatusNoError;
end;

class procedure TNxt.pairBluetooth(const resourceName, passkey: string;
  var pairedResourceName: string; var status: integer);
begin
  if resourceName = '' then Exit;
  if passKey = '' then Exit;
  if status < kStatusNoError then Exit;
  pairedResourceName := resourceName;
//  status := kStatusPairingFailed;
  status := kStatusNoError;
end;

function TNxt.pollAvailableLength(bufferSelector: byte;
  var status: integer): Cardinal;
var
  cmd : TBaseCmd;
  buf : array[0..4] of Byte;
  len, size : integer;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  cmd := TBaseCmd.Create;
  try
    cmd.SetVal(kNXT_SystemCmd, kNXT_SCPollCommandLen, bufferSelector);
    write(cmd.GetBody, cmd.GetLength, status);
    size := 5;
    len := read(@buf[0], size, status);
    if len = size then
    begin
      Result := buf[4];
      status := kStatusNoError;
    end;
  finally
    cmd.Free;
  end;
end;

function TNxt.read(bufferPtr: PByte; numberOfBytes: Cardinal;
  var status: integer): Cardinal;
var
  ret : integer;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  if fNXTViaUSB then
  begin
    ret := usb_bulk_read(fDevHandle, USB_IN_ENDPOINT, PChar(bufferPtr),
      numberOfBytes, fTimeout);
  end
  else
  begin
    ret := NXTSerialRead(fSerialHandle, bufferPtr, numberOfBytes, fTimeout);
  end;
  if ret < 0 then
    status := ret
  else
  begin
    status := kStatusNoError;
    Result := ret;
  end;
end;

function TNxt.readBufferData(dataBuffer: PByte; bufferSelector: byte;
  numberOfBytesToRead: Cardinal; var status: integer): Cardinal;
var
  cmd : TBaseCmd;
  buf : array[0..63] of Byte;
  p : PByte;
  len, size : integer;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  cmd := TBaseCmd.Create;
  try
    cmd.SetVal(kNXT_SystemCmd, kNXT_SCPollCommand, bufferSelector, Byte(numberOfBytesToRead));
    write(cmd.GetBody, cmd.GetLength, status);
    size := 64;
    len := read(@buf[0], size, status);
    if len = size then
    begin
      Result := buf[4];
      p := @buf[5];
      Move(p^, dataBuffer^, 59);
      status := kStatusNoError;
    end;
  finally
    cmd.Free;
  end;
end;

function TNxt.sendDirectCommand(requireResponse: boolean;
  const commandBufferPtr: PByte; commandBufferSizeInBytes: Cardinal;
  responseBufferPtr: PByte; responseBufferSizeInBytes: Cardinal;
  var status: integer): Cardinal;
var
  ret : integer;
  BufOut, BufIn : PByte;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  BufOut := nil;
  GetMem(BufOut, commandBufferSizeInBytes+1);
  try
    BufOut^ := DIRECT_COMMAND;
    if not requireResponse then
      BufOut^ := BufOut^ or NO_RESP0NSE;
    inc(BufOut);
    Move(commandBufferPtr^, BufOut^, commandBufferSizeInBytes);
    dec(BufOut);
    ret := write(BufOut, commandBufferSizeInBytes+1, status);
    if requireResponse and (ret >= 0) then
    begin
      BufIn := nil;
      GetMem(BufIn, responseBufferSizeInBytes+1);
      try
        Result := read(BufIn, responseBufferSizeInBytes+1, status);
        inc(BufIn);
        Move(BufIn^, responseBufferPtr^, responseBufferSizeInBytes);
        dec(BufIn);
      finally
        FreeMem(BufIn);
      end;
    end;
  finally
    FreeMem(BufOut);
  end;
end;

procedure TNxt.setName(const newName: string; var status: integer);
var
  cmd : TNxtCmd;
begin
  if status < kStatusNoError then Exit;
  cmd := TNxtCmd.Create;
  try
    cmd.MakeSetName(newName, False);
    write(cmd.GetBody, cmd.GetLength, status);
//    IgnoreResponse(3, status);
  finally
    cmd.Free;
  end;
end;

function TNxt.SetResourceString(resStr: string): integer;
var
  bDone : boolean;
  Busses : PUSBBus;
  Bus : PUSBBus;
  i : integer;
begin
  Result := kStatusNoError;
  if AnsiCompareText(resStr, fPort) <> 0 then
  begin
    fPort := resStr;
    // find the device and open it
    bDone := False;

    // the resource string tells us whether to
    // use USB or Serial to find the NXT
    fNXTViaUSB := UseUSB(resStr);
    if fNXTViaUSB then begin
      if fDevHandle <> nil then begin
        usb_close(fDevHandle);
        fDevHandle := nil;
       end;

      usb_find_busses();
      usb_find_devices();
      Busses := usb_get_busses();

      Bus := Busses;
      while (Bus <> nil) and not bDone do
      begin
        fDev := Bus^.devices;
        while (fDev <> nil) and not bDone do
        begin
          if is_nxt_device(fDev) then
          begin
            // open if it is an NXT
            fDevHandle := usb_open(fDev);
            usb_reset(fDevHandle);
            bDone := CorrectDeviceFound;
            if not bDone then
            begin
              usb_close(fDevHandle);
              fDevHandle := nil;
            end;
          end;
          if bDone then Break;
          fDev := fDev^.next;
        end;
        if bDone then Break;
        Bus := Bus^.next;
      end;
      if bDone then
      begin
        Result := kStatusNoError;
  //      usb_set_configuration(fDevHandle, 1);
        usb_claim_interface(fDevHandle, USB_INTERFACE);
      end
      else
        Result := kStatusNoMoreItemsFound;
    end
    else begin
      Result := kStatusNoError;
      // start with current serial port index
      // close any open port
      if fSerialHandle <> 0 then begin
        SerialClose(fSerialHandle);
        fDevHandle := nil;
      end;
      i := 0;
      while (i < MAX_SERIAL_IDX) and not bDone do
      begin
        fSerialHandle := NXTSerialOpen(GetSerialDeviceName(i));
        SerialFlush(fSerialHandle);
        if is_nxt_serial_device(fSerialHandle, fTimeout) then
        begin
          bDone := CorrectDeviceFound;
          if not bDone then
          begin
            SerialClose(fSerialHandle);
            fSerialHandle := 0;
          end;
        end
        else
        begin
          SerialClose(fSerialHandle);
          fSerialHandle := 0;
        end;
        if bDone then Break;
        inc(i);
        Sleep(100);
      end;
      if bDone then
      begin
        Result := kStatusNoError;
      end
      else begin
        Result := kStatusNoMoreItemsFound;
      end;
    end;
  end;
end;

class procedure TNxt.unpairBluetooth(const resourceName: string;
  var status: integer);
begin
  if resourceName = '' then Exit;
  if status < kStatusNoError then Exit;
  status := kStatusNoError;
end;

function TNxt.write(const bufferPtr: PByte; numberOfBytes: Cardinal;
  var status: integer): Cardinal;
var
  ret, chunkRet, size : integer;
  buf, p : PByte;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  if fNXTViaUSB then
  begin
    if numberOfBytes > 64 then
    begin
      // size could be greater than 64.  If so, divide up the write
      // into smaller chunks
      buf := nil;
      GetMem(buf, 64);
      try
        p := bufferPtr;
        ret := 0;
        while numberOfBytes > 0 do
        begin
          size := Integer(Min(numberOfBytes, 64));
          Move(p^, buf^, size);
          chunkRet := usb_bulk_write(fDevHandle, USB_OUT_ENDPOINT,
            PChar(buf), size, fTimeout);
          if chunkRet < 0 then
          begin
            ret := chunkRet;
            Break;
          end;
          inc(p, chunkRet);
          inc(ret, chunkRet);
          dec(numberOfBytes, chunkRet);
        end;
      finally
        FreeMem(buf);
      end;
    end
    else
    begin
      ret := usb_bulk_write(fDevHandle, USB_OUT_ENDPOINT, PChar(bufferPtr),
        numberOfBytes, fTimeout);
    end;
  end
  else
  begin
    ret := NXTSerialWrite(fSerialHandle, bufferPtr, numberOfBytes);
  end;
  if ret < 0 then
    status := ret
  else
  begin
    status := kStatusNoError;
    Result := ret;
  end;
end;

{ TNxtFile }

procedure TNxtFile.close(var status: integer);
var
  cmd : TBaseCmd;
//  buf : array[0..3] of Byte;
//  len, size : integer;
begin
  if status < kStatusNoError then Exit;
  if not fOpen then Exit;
  cmd := TBaseCmd.Create;
  try
    // TODO: do I have to check the response?
    cmd.SetVal(kNXT_SystemCmdNoReply, kNXT_SCClose, fHandle);
    fNXT.write(cmd.GetBody, cmd.GetLength, status);
{
    size := 4;
    len := read(@buf[0], size, status);
    if (len = size) and (buf[2] = 0) then
    begin
      fHandle := buf[3];
      status  := kStatusNoError;
    end
    else
      status := ConvertStatus(buf[2]);
}
  finally
    cmd.Free;
  end;
end;

constructor TNxtFile.Create(aNXT : TNxt; const aFilename : string);
begin
  inherited Create;
  fNXT      := aNXT;
  fFilename := aFilename;
  fHandle   := 0;
  fOpen     := False;
  fSize     := 0;
  fAvailableSize := 0;
end;

destructor TNxtFile.Destroy;
begin

  inherited;
end;

function TNxtFile.getAvailableSize(var status: integer): Cardinal;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  if not fOpen then
  begin
    openForDataAppend(status);
    if status = kStatusNoError then
      close(status);
  end
  else
    status := kStatusDuplicateOpen;
  Result := fAvailableSize;
end;

procedure TNxtFile.getName(var fileName: string);
begin
  fileName := fFilename;
end;

function TNxtFile.getSize(var status: integer): Cardinal;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  if fOpen then
    Result := fSize
  else
    status := kStatusFWUndefinedError;
end;

procedure TNxtFile.openForDataAppend(var status: integer);
var
  cmd : TNxtCmd;
  buf : array[0..7] of Byte;
  len, size : integer;
begin
  if status < kStatusNoError then Exit;
  cmd := TNxtCmd.Create;
  try
    cmd.MakeCmdWithFilename(kNXT_SystemCmd, kNXT_SCOpenAppendData, fFilename);
    fNXT.write(cmd.GetBody, cmd.GetLength, status);
    size := 8;
    len := fNXT.read(@buf[0], size, status);
    if (len = size) and (buf[2] = 0) then
    begin
      fHandle := buf[3];
      fAvailableSize := BytesToCardinal(buf[4], buf[5], buf[6], buf[7]);
      fOpen   := True;
      status  := kStatusNoError;
    end
    else
    begin
      status  := ConvertStatus(buf[2]);
      fOpen   := False;
      fHandle := 0;
      fAvailableSize := 0;
    end;
  finally
    cmd.Free;
  end;
end;

procedure TNxtFile.openForDataWrite(sizeInBytes: Cardinal;
  var status: integer);
var
  cmd : TNxtCmd;
  buf : array[0..3] of Byte;
  len, size : integer;
begin
  if status < kStatusNoError then Exit;
  cmd := TNxtCmd.Create;
  try
    cmd.MakeCmdWithFilename(kNXT_SystemCmd, kNXT_SCOpenWriteData, fFilename, sizeInBytes);
    fNXT.write(cmd.GetBody, cmd.GetLength, status);
    size := 4;
    len := fNXT.read(@buf[0], size, status);
    if (len = size) and (buf[2] = 0) then
    begin
      fHandle := buf[3];
      fSize   := sizeInBytes;
      fOpen   := True;
      status  := kStatusNoError;
    end
    else
    begin
      status  := ConvertStatus(buf[2]);
      fOpen   := False;
      fHandle := 0;
      fSize   := 0;
    end;
  finally
    cmd.Free;
  end;
end;

procedure TNxtFile.openForLinearWrite(sizeInBytes: Cardinal;
  var status: integer);
var
  cmd : TNxtCmd;
  buf : array[0..3] of Byte;
  len, size : integer;
begin
  if status < kStatusNoError then Exit;
  cmd := TNxtCmd.Create;
  try
    cmd.MakeCmdWithFilename(kNXT_SystemCmd, kNXT_SCOpenWriteLinear, fFilename, sizeInBytes);
    fNXT.write(cmd.GetBody, cmd.GetLength, status);
    size := 4;
    len := fNXT.read(@buf[0], size, status);
    if (len = size) and (buf[2] = 0) then
    begin
      fHandle := buf[3];
      fSize   := sizeInBytes;
      fOpen   := True;
      status  := kStatusNoError;
    end
    else
    begin
      status  := ConvertStatus(buf[2]);
      fOpen   := False;
      fHandle := 0;
      fSize   := 0;
    end;
  finally
    cmd.Free;
  end;
end;

procedure TNxtFile.openForRead(var status: integer);
var
  cmd : TNxtCmd;
  buf : array[0..7] of Byte;
  len, size : integer;
begin
  if status < kStatusNoError then Exit;
  cmd := TNxtCmd.Create;
  try
    cmd.MakeCmdWithFilename(kNXT_SystemCmd, kNXT_SCOpenRead, fFilename);
    fNXT.write(cmd.GetBody, cmd.GetLength, status);
    size := 8;
    len := fNXT.read(@buf[0], size, status);
    if (len = size) and (buf[2] = 0) then
    begin
      fHandle := buf[3];
      fSize   := BytesToCardinal(buf[4], buf[5], buf[6], buf[7]);
      fOpen   := True;
      status  := kStatusNoError;
    end
    else
    begin
      status  := ConvertStatus(buf[2]);
      fHandle := 0;
      fSize   := 0;
      fOpen   := False;
    end;
  finally
    cmd.Free;
  end;
end;

procedure TNxtFile.openForWrite(sizeInBytes: Cardinal;
  var status: integer);
var
  cmd : TNxtCmd;
  buf : array[0..3] of Byte;
  len, size : integer;
begin
  if status < kStatusNoError then Exit;
  cmd := TNxtCmd.Create;
  try
    cmd.MakeCmdWithFilename(kNXT_SystemCmd, kNXT_SCOpenWrite, fFilename, sizeInBytes);
    fNXT.write(cmd.GetBody, cmd.GetLength, status);
    size := 4;
    len := fNXT.read(@buf[0], size, status);
    if (len = size) and (buf[2] = 0) then
    begin
      fHandle := buf[3];
      fSize   := sizeInBytes;
      fOpen   := True;
      status  := kStatusNoError;
    end
    else
    begin
      status  := ConvertStatus(buf[2]);
      fOpen   := False;
      fHandle := 0;
      fSize   := 0;
    end;
  finally
    cmd.Free;
  end;
end;

function TNxtFile.read(bufferPtr: PByte; numberOfBytes: Cardinal;
  var status: integer): Cardinal;
var
  size : Cardinal;
  cmd : TBaseCmd;
  cnt : SmallInt;
  rbuf : array[0..63] of Byte;
  len, rsize : integer;
  p, buf : PByte;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  size := numberOfBytes;
  p := bufferPtr;
  cmd := TBaseCmd.Create;
  try
    while Result < size do
    begin
      cnt := SmallInt(Min(size-Result, kNXT_MaxBytes-6));
      cmd.SetVal(kNXT_SystemCmd, kNXT_SCRead, fHandle, Lo(cnt), Hi(cnt));
      fNXT.write(cmd.GetBody, cmd.GetLength, status);
      rsize := cnt + 6;
      len := fNXT.read(@rbuf[0], rsize, status);
      if (len = rsize) and (rbuf[2] = 0) then
      begin
        status  := kStatusNoError;
        fHandle := rbuf[3];
        cnt := SmallInt(BytesToCardinal(rbuf[4], rbuf[5]));
        buf := @rbuf[6];
        Move(buf^, p^, cnt);
      end
      else
      begin
        status := ConvertStatus(rbuf[2]);
        break;
      end;
      inc(p, cnt);
      inc(Result, cnt);
    end;
  finally
    cmd.Free;
  end;
end;

procedure TNxtFile.remove(var status: integer);
var
  cmd : TNxtCmd;
  buf : array[0..22] of Byte;
  len, size : integer;
begin
  if status < kStatusNoError then Exit;
  cmd := TNxtCmd.Create;
  try
    cmd.MakeCmdWithFilename(kNXT_SystemCmd, kNXT_SCDelete, fFilename);
    fNXT.write(cmd.GetBody, cmd.GetLength, status);
    size := 23;
    len := fNXT.read(@buf[0], size, status);
    if (len = size) and (buf[2] = 0) then
    begin
      fHandle := 0;
      fSize   := 0;
      fOpen   := False;
      status  := kStatusNoError;
    end
    else
      status := ConvertStatus(buf[2]);
  finally
    cmd.Free;
  end;
end;

function TNxtFile.write(bufferPtr: PByte; numberOfBytes: Cardinal;
  var status: integer): Cardinal;
var
  cmd : TNxtCmd;
  p, buf : PByte;
  size : Cardinal;
  cnt : Word;
  Data : array[0..kNXT_MaxBytes-1] of Byte;
  b : Byte;
  rbuf : array[0..5] of Byte;
  len, rsize : integer;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  // write in < 64 byte chunks
  size := numberOfBytes;
  p := bufferPtr; // start at the beginning
  buf := @Data[0];
  cmd := TNxtCmd.Create;
  try
    while Result < size do
    begin
      cnt := Word(Min(size - Result, kNXT_MaxBytes-3));
      // fill our buffer with the right number of bytes
      Move(p^, buf^, cnt);
      // write these bytes to the NXT
      if cnt = (size - Result) then
        b := kNXT_SystemCmd
      else
        b := kNXT_SystemCmdNoReply;
      cmd.MakeCmdWriteFile(b, kNXT_SCWrite, fHandle, cnt, Data);
      fNXT.write(cmd.GetBody, cmd.GetLength, status);
      if b = kNXT_SystemCmd then
      begin
        rsize := 6;
        len := fNXT.read(@rbuf[0], rsize, status);
        if (len = rsize) and (rbuf[2] = 0) then
        begin
          status  := kStatusNoError;
          cnt     := Word(BytesToCardinal(rbuf[4], rbuf[5]));
        end
        else
        begin
          status  := ConvertStatus(rbuf[2]);
          break;
        end;
      end;
      inc(p, cnt);
      inc(Result, cnt);
    end;
  finally
    cmd.Free;
  end;
end;

{ TNxtFileIterator }

procedure TNxtFileIterator.advance(var status: integer);
var
  cmd : TNxtCmd;
  buf : array[0..27] of Byte;
  len, size, i : integer;
  oldHandle : Byte;
begin
  if status < kStatusNoError then Exit;
  oldHandle := $FF;
  cmd := TNxtCmd.Create;
  try
    if fFirstTime or fValid then
    begin
      if fFirstTime then
      begin
        // call findfirstmodule
        fFirstTime := False;
        cmd.MakeCmdWithFilename(kNXT_SystemCmd, kNXT_SCFindFirst, fPattern);
      end
      else
      begin
        // call findnextmodule
        oldHandle := fHandle;
        cmd.SetVal(kNXT_SystemCmd, kNXT_SCFindNext, fHandle);
      end;
      fNXT.write(cmd.GetBody, cmd.GetLength, status);
      size := 28;
      len := fNXT.read(@buf[0], size, status);
      if (len = size) and (buf[2] = 0) then
      begin
        fFileName := '';
        fHandle := buf[3];
        for i := 4 to 23 do
          fFileName := fFileName + Char(buf[i]);
        fSize  := BytesToCardinal(buf[24], buf[25], buf[26], buf[27]);
        status := kStatusNoError;
      end
      else
      begin
        // close the previous handle (if there was one)
        if oldHandle = fHandle then
          CloseFileHandle(status);
        status  := ConvertStatus(buf[2]);
        fValid  := False;
        fHandle := 0;
      end;
    end
    else
      status := kStatusNoMoreItemsFound;
  finally
    cmd.Free;
  end;
end;

procedure TNxtFileIterator.CloseFileHandle(var status: integer);
var
  cmd : TBaseCmd;
begin
  if status < kStatusNoError then Exit;
  cmd := TBaseCmd.Create;
  try
    cmd.SetVal(kNXT_SystemCmdNoReply, kNXT_SCClose, fHandle);
    fNXT.write(cmd.GetBody, cmd.GetLength, status);
  finally
    cmd.Free;
  end;
end;

constructor TNxtFileIterator.Create(aNXT : TNxt; const aPattern : string);
begin
  inherited Create;
  fNXT := aNXT;
  fPattern := aPattern;
  fValid := True;
  fFirstTime := True;
  fFileName := '';
  fSize       := 0;
  fHandle     := 0;
end;

destructor TNxtFileIterator.Destroy;
begin

  inherited;
end;

function TNxtFileIterator.getFile(var status: integer): TNxtFile;
begin
  Result := nil;
  if status < kStatusNoError then Exit;
  if fValid then
  begin
    Result := TNxtFile.Create(fNXT, fFileName);
    Result.fSize     := fSize;
    status := kStatusNoError;
  end
  else
    status := kStatusNoMoreItemsFound;
end;

procedure TNxtFileIterator.getName(var filename: string; var status: integer);
begin
  if status < kStatusNoError then Exit;
  if fValid then
  begin
    filename := fFileName;
    status   := kStatusNoError;
  end
  else
  begin
    filename := '';
    status   := kStatusNoMoreItemsFound;
  end;
end;

function TNxtFileIterator.getSize(var status: integer): Cardinal;
begin
  Result := 0;
  if status < kStatusNoError then Exit;
  if fValid then
  begin
    Result := fSize;
    status := kStatusNoError;
  end
  else
  begin
    Result := 0;
    status := kStatusNoMoreItemsFound;
  end;
end;

{ TNxtIModule }

constructor TNxtIModule.Create(aNXT : TNxt);
begin
  inherited Create;
  fNXT := aNXT;
end;

destructor TNxtIModule.Destroy;
begin

  inherited;
end;

function TNxtIModule.getModuleID: Cardinal;
begin
  Result := fModuleID;
end;

function TNxtIModule.getModuleIOMapSize: Cardinal;
begin
  Result := fIOMapSize;
end;

function TNxtIModule.getModuleSize: Cardinal;
begin
  Result := fSize;
end;

procedure TNxtIModule.getName(var moduleName: string);
begin
  moduleName := fModuleName;
end;

function TNxtIModule.readIOMap(offsetInBytes, numberOfBytes: Cardinal;
  dataBufferPtr: PByte; var status: integer): Cardinal;
var
  cmd : TNxtCmd;
  buf : PByte;
  ret : cardinal;
begin
  Result := 0;
  if numberOfBytes > 64 then Exit;
  if not Assigned(dataBufferPtr) then Exit;
  if status < kStatusNoError then Exit;
  cmd := TNxtCmd.Create;
  try
    cmd.MakeCmdReadIOMap(kNXT_SystemCmd, kNXT_SCIOMapRead, fModuleID,
      offsetInBytes, numberOfBytes);
    fNXT.write(cmd.GetBody, cmd.GetLength, status);
    if status = kStatusNoError then
    begin
      GetMem(buf, 64);
      try
        ret := fNXT.read(buf, 64, status);
        if status = kStatusNoError then
          Result := ret;
      finally
        FreeMem(buf);
      end;
    end;
  finally
    cmd.Free;
  end;
end;

function TNxtIModule.writeIOMap(offsetInBytes, numberOfBytes: Cardinal;
  dataBufferPtr: PByte; var status: integer): Cardinal;
begin
  Result := 0;
  if offsetInBytes > 64 then Exit;
  if numberOfBytes > 64 then Exit;
  if not Assigned(dataBufferPtr) then Exit;
  if status < kStatusNoError then Exit;
(*
var
  cmd : TNxtCmd;
  b : byte;
  len : integer;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    if chkResponse then
      b := kNXT_SystemCmd
    else
      b := kNXT_SystemCmdNoReply;
    len := fLink.Send(cmd.MakeCmdWriteIOMap(b, kNXT_SCIOMapWrite, ModID, offset, count, buffer.Data));
    if chkResponse then
    begin
      if len <> 6 then
      begin
        Result := False;
        Exit;
      end;
      ModID := fLink.GetReplyCardinal(0); // first 4 bytes
      count  := fLink.GetReplyWord(4); // bytes 5 & 6
    end;
    Result := len >= kRCX_OK;
  finally
    cmd.Free;
    if fAutoClose then Close;
  end;
*)
end;

{ TNxtIModuleIterator }

procedure TNxtIModuleIterator.advance(var status: integer);
var
  cmd : TNxtCmd;
  buf : array[0..33] of Byte;
  len, size, i : integer;
  oldHandle : Byte;
begin
  if status < kStatusNoError then Exit;
  oldHandle := $FF;
  cmd := TNxtCmd.Create;
  try
    if fFirstTime or fValid then
    begin
      if fFirstTime then
      begin
        // call findfirstmodule
        fFirstTime := False;
        cmd.MakeCmdWithFilename(kNXT_SystemCmd, kNXT_SCFindFirstModule, fPattern);
      end
      else
      begin
        // call findnextmodule
        oldHandle := fHandle;
        cmd.SetVal(kNXT_SystemCmd, kNXT_SCFindNextModule, fHandle);
      end;
      fNXT.write(cmd.GetBody, cmd.GetLength, status);
      size := 34;
      len := fNXT.read(@buf[0], size, status);
      if (len = size) and (buf[2] = 0) then
      begin
        fModuleName := '';
        fHandle := buf[3];
        for i := 4 to 23 do
          fModuleName := fModuleName + Char(buf[i]);
        fModuleID  := BytesToCardinal(buf[24], buf[25], buf[26], buf[27]);
        fSize      := BytesToCardinal(buf[28], buf[29], buf[30], buf[31]);
        fIOMapSize := BytesToCardinal(buf[32], buf[33]);
        status     := kStatusNoError;
      end
      else
      begin
        // close the previous handle
        if oldHandle = fHandle then
          CloseModuleHandle(status);
        status  := ConvertStatus(buf[2]);
        fValid  := False;
        fHandle := 0;
      end;
    end
    else
      status := kStatusNoMoreItemsFound;
  finally
    cmd.Free;
  end;
end;

procedure TNxtIModuleIterator.CloseModuleHandle(var status: integer);
var
  cmd : TBaseCmd;
begin
  if status < kStatusNoError then Exit;
  cmd := TBaseCmd.Create;
  try
    cmd.SetVal(kNXT_SystemCmdNoReply, kNXT_SCCloseModuleHandle, fHandle);
    fNXT.write(cmd.GetBody, cmd.GetLength, status);
  finally
    cmd.Free;
  end;
end;

constructor TNxtIModuleIterator.Create(aNXT : TNxt; const aPattern : string);
begin
  inherited Create;
  fNXT := aNXT;
  fPattern := aPattern;
  fValid := True;
  fFirstTime := True;
  fModuleName := '';
  fModuleID   := 0;
  fSize       := 0;
  fIOMapSize  := 0;
  fHandle     := 0;
end;

destructor TNxtIModuleIterator.Destroy;
begin

  inherited;
end;

function TNxtIModuleIterator.getModule(var status: integer): TNxtIModule;
begin
  Result := nil;
  if status < kStatusNoError then Exit;
  if fValid then
  begin
    Result := TNxtIModule.Create(fNXT);
    Result.fModuleName := fModuleName;
    Result.fModuleID   := fModuleID;
    Result.fSize       := fSize;
    Result.fIOMapSize  := fIOMapSize;
    status := kStatusNoError;
  end
  else
    status := kStatusNoMoreItemsFound;
end;

procedure TNxtIModuleIterator.getName(var moduleName: string;
  var status: integer);
begin
  if status < kStatusNoError then Exit;
  if fValid then
  begin
    moduleName := fModuleName;
    status     := kStatusNoError;
  end
  else
  begin
    moduleName := '';
    status     := kStatusNoMoreItemsFound;
  end;
end;

{ TNxtIterator }

procedure TNxtIterator.advance(var status: integer);
var
  bDone : boolean;
begin
  if status < kStatusNoError then Exit;
  bDone := False;

  // iterate first through USB devices to find next NXT
  // and if we reach the end of that list then
  // iterate through serial ports to find the next if searchBluetooth is true
  if fNXTViaUSB then
  begin
    if fDevHandle <> nil then begin
      usb_close(fDevHandle);
      fDevHandle := nil;
    end;

    if fBus = nil then
      fBus := fBusses;
    while (fBus <> nil) and not bDone do
    begin
      if fDev = nil then
        fDev := fBus^.devices // start at first if nil
      else
        fDev := fDev^.next; // advance if not nil
      while (fDev <> nil) and not bDone do
      begin
        bDone := is_nxt_device(fDev);
        if bDone then Break;
        fDev := fDev^.next;
      end;
      if bDone then Break;
      fBus := fBus^.next;
    end;
    if bDone then
    begin
      status := kStatusNoError;
      fDevHandle := usb_open(fDev);
      usb_reset(fDevHandle);
    end
    else begin
      status := kStatusNoMoreItemsFound;
      fNXTViaUSB := False;
    end;
  end;
  if not fNXTViaUSB and fSearchBT then
  begin
    status := kStatusNoError;
    // start with current serial port index
    // close any open port
    if fSerialHandle <> 0 then begin
      SerialClose(fSerialHandle);
      fDevHandle := nil;
    end;
    while (fCurSerialIdx < MAX_SERIAL_IDX) and not bDone do
    begin
      fSerialHandle := NXTSerialOpen(GetSerialDeviceName(fCurSerialIdx));
      SerialFlush(fSerialHandle);
      bDone := is_nxt_serial_device(fSerialHandle, fBTTimeout);
      if bDone then Break;
      SerialClose(fSerialHandle);
      fSerialHandle := 0;
      Sleep(100);
      inc(fCurSerialIdx);
    end;
    if bDone then
    begin
      status := kStatusNoError;
    end
    else begin
      status := kStatusNoMoreItemsFound;
      SerialClose(fSerialHandle);
      fSerialHandle := 0;
    end;
  end;
end;

constructor TNxtIterator.Create;
begin
  inherited Create;
  fBusses := nil;
  fBus 	  := nil;
  fDev 	  := nil;
  fDevHandle := nil;
  fNXTViaUSB := True;
  fSearchBT  := False;
  fBTTimeout := 1000;
  fCurSerialIdx := 0;
  fSerialHandle := 0;
end;

destructor TNxtIterator.Destroy;
begin
  if fDevHandle <> nil then begin
    usb_close(fDevHandle);
    fDevHandle := nil;
  end;
  if fSerialHandle <> 0 then begin
    SerialClose(fSerialHandle);
    fSerialHandle := 0;
  end;

  inherited;
end;

procedure TNxtIterator.getName(var resourceName: string; var status: integer);
begin
  if status < kStatusNoError then Exit;
  if fNXTViaUSB then
    resourceName := GetUSBResString(fDev, fDevHandle)
  else
    resourceName := GetSerialResString(fSerialHandle, fBTTimeout);
  if resourceName <> '' then
    status := kStatusNoError
  else
    status := kStatusNonNXTDeviceSelected;
end;

function TNxtIterator.getNXT(var status: integer): TNxt;
begin
  Result := nil;
  if status < kStatusNoError then Exit;
  Result := TNxt.Create;
  if fNXTViaUSB then
  begin
    Result.fPort := GetUSBResString(fDev, fDevHandle);
    Result.fCheckver := False;
    Result.fDev := fDev;
    Result.fDevHandle := fDevHandle;
  //  usb_set_configuration(fDevHandle, 1);
    usb_claim_interface(fDevHandle, USB_INTERFACE);
    fDevHandle := nil;
  end
  else
  begin
    Result.fPort := GetSerialResString(fSerialHandle, fBTTimeout);
    Result.fCheckver := False;
    Result.fSerialHandle := fSerialHandle;
    fSerialHandle := 0;
  end;
  status := kStatusNoError;
end;

initialization

  FantomSDKInit;


finalization

  FantomSDKClose;

end.
