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
unit fantom;

interface

uses
  FantomDefs;

{$I FANTOM_CONST.INC}

var
  nFANTOM100_createNXT : function(resString : PChar; var status : integer; checkFWversion : byte) : FantomHandle; cdecl;
  nFANTOM100_createNXTIterator : function(searchBluetooth : byte; bluetoothSearchTimeout : Cardinal; var status : integer) : FantomHandle; cdecl;
  nFANTOM100_iFile_getAvailableSize : function(fileHandle : FantomHandle; var status : integer) : Cardinal; cdecl;
  nFANTOM100_iFile_getSize : function(fileHandle : FantomHandle; var status : integer) : Cardinal; cdecl;
  nFANTOM100_iFileIterator_getFile : function(iterHandle : FantomHandle; var status : integer) : FantomHandle; cdecl;
  nFANTOM100_iFileIterator_getSize : function(fileIterHandle : FantomHandle; var status : integer) : Cardinal; cdecl;
  nFANTOM100_iModule_getIOMapSize : function(moduleHandle : FantomHandle; var status : integer) : Cardinal; cdecl;
  nFANTOM100_iModule_getModuleID : function(moduleHandle : FantomHandle; var status : integer) : Cardinal; cdecl;
  nFANTOM100_iModule_getModuleSize : function(moduleHandle : FantomHandle; var status : integer) : Cardinal; cdecl;
  nFANTOM100_iModule_readIOMap : function(moduleHandle : FantomHandle; offset : Cardinal; numberBytesToRead : Cardinal; dataBuffer : PByte; var status : integer) : Cardinal; cdecl;
  nFANTOM100_iModule_writeIOMap : function(moduleHandle : FantomHandle; offset : Cardinal; numberBytesToWrite : Cardinal; dataBuffer : PByte; var status : integer) : Cardinal; cdecl;
  nFANTOM100_iModuleIterator_getModule : function(modIterHandle : FantomHandle; var status : integer) : FantomHandle; cdecl;
  nFANTOM100_iNXT_createFile : function(nxtHandle : FantomHandle; const filename : PChar; var status : integer) : FantomHandle; cdecl;
  nFANTOM100_iNXT_createFileIterator : function(nxtHandle : FantomHandle; filePattern : PChar; var status : integer) : FantomHandle; cdecl;
  nFANTOM100_iNXT_createModule : function(nxtHandle : FantomHandle; moduleName : PChar; moduleID : Cardinal; moduleSize : Cardinal; IOMapSize : Cardinal; var status : integer) : FantomHandle; cdecl;
  nFANTOM100_iNXT_createModuleIterator : function(nxtHandle : FantomHandle; moduleNamePattern : PChar; var status : integer) : FantomHandle; cdecl;
  nFANTOM100_iNXT_pollAvailableLength : function(nxtHandle : FantomHandle; bufferSelector : Cardinal; var status : integer) : Cardinal; cdecl;
  nFANTOM100_iNXT_readBufferData : function(nxtHandle : FantomHandle; dataBuffer : PByte; bufferSelector : Cardinal; numberOfBytesToRead : Cardinal; var status : integer) : Cardinal; cdecl;
  nFANTOM100_iNXT_write : function(nxtHandle : FantomHandle; writeBuffer : PByte; writeBufferSize : Cardinal; var status : integer) : Cardinal; cdecl;
  nFANTOM100_iNXTIterator_getNXT : function(nxtIterHandle : FantomHandle; var status : integer) : FantomHandle; cdecl;
  nFANTOM100_isPaired : function(resourceName : PChar; var status : integer) : boolean; cdecl;

  nFANTOM100_destroyNXT : procedure(nxtHandle : FantomHandle; var status : integer); cdecl;
  nFANTOM100_destroyNXTIterator : procedure(nxtIteratorHandle : FantomHandle; var status : integer); cdecl;
  nFANTOM100_iFile_close : procedure(fileHandle : FantomHandle; var status : integer); cdecl;
  nFANTOM100_iFile_getName : procedure(fileHandle : FantomHandle; filename : PChar; var status : integer); cdecl;
  nFANTOM100_iFile_openForDataAppend : procedure(fileHandle : FantomHandle; var status : integer); cdecl;
  nFANTOM100_iFile_openForDataWrite : procedure(fileHandle : FantomHandle; sizeInBytes : Cardinal; var status : integer); cdecl;
  nFANTOM100_iFile_openForLinearWrite : procedure(fileHandle : FantomHandle; sizeInBytes : Cardinal; var status : integer); cdecl;
  nFANTOM100_iFile_openForRead : procedure(fileHandle : FantomHandle; var status : integer); cdecl;
  nFANTOM100_iFile_openForWrite : procedure(fileHandle : FantomHandle; fileSize : Cardinal; var status : integer); cdecl;
  nFANTOM100_iFile_read : procedure(fileHandle : FantomHandle; fileDataBuffer : PByte; bufferSize : Cardinal; var status : integer); cdecl;
  nFANTOM100_iFile_remove : procedure(fileHandle : FantomHandle; var status : integer); cdecl;
  nFANTOM100_iFile_write : procedure(fileHandle : Cardinal; writeBuffer : PByte; writeBufferLength : Cardinal; var status : integer); cdecl;
  nFANTOM100_iFileIterator_advance : procedure(iterHandle : FantomHandle; var status : integer); cdecl;
  nFANTOM100_iFileIterator_getName : procedure(iterHandle : FantomHandle; filename : PChar; var status : integer); cdecl;
  nFANTOM100_iModule_getName : procedure(moduleHandle : FantomHandle; moduleName : PChar; var status : integer); cdecl;// 20 bytes
  nFANTOM100_iModuleIterator_advance : procedure(modIterHandle : FantomHandle; var status : integer); cdecl;
  nFANTOM100_iModuleIterator_getName : procedure(modIterHandle : FantomHandle; moduleName : PChar; var status : integer); cdecl;// 256 bytes
  nFANTOM100_iNXT_bluetoothFactoryReset : procedure(nxtHandle : FantomHandle; var status : integer); cdecl;
  nFANTOM100_iNXT_bootIntoFirmwareDownloadMode : procedure(resourceName : PChar; var status : integer); cdecl;
  nFANTOM100_iNXT_destroyFile : procedure(nxtHandle : FantomHandle; fileHandle : Cardinal; var status : integer); cdecl;
  nFANTOM100_iNXT_destroyFileIterator : procedure(nxtHandle : FantomHandle; iterHandle : FantomHandle; var status : integer); cdecl;
  nFANTOM100_iNXT_destroyModule : procedure(nxtHandle : FantomHandle; moduleHandle : FantomHandle; var status : integer); cdecl;
  nFANTOM100_iNXT_destroyModuleIterator : procedure(nxtHandle : FantomHandle; modIterHandle : FantomHandle; var status : integer); cdecl;
  nFANTOM100_iNXT_downloadFirmware : procedure(nxtHandle : FantomHandle; firmwareBuffer : PByte; firmwareBufferSize : Cardinal; var status : integer); cdecl;
  nFANTOM100_iNXT_eraseUserFlash : procedure(nxtHandle : FantomHandle; var status : integer); cdecl;
  nFANTOM100_iNXT_findDeviceInFirmwareDownloadMode : procedure(resString : PChar; var status : integer); cdecl;
  nFANTOM100_iNXT_getDeviceInfo : procedure(nxtHandle : FantomHandle; name : PChar; address : PByte; signalStrength : PByte; var availableFlash : Cardinal; var status : integer); cdecl;
  nFANTOM100_iNXT_getFirmwareVersion : procedure(nxtHandle : FantomHandle; var protocolVersionMajor, protocolVersionMinor, firmwareVersionMajor, firmwareVersionMinor : byte; var status : integer); cdecl;
  nFANTOM100_iNXT_getResourceString : procedure(nxtHandle : FantomHandle; resString : PChar; var status : integer); cdecl;// 55 bytes
  nFANTOM100_iNXT_read : procedure(nxtHandle : FantomHandle; readBuffer : PByte; readBufferSize : Cardinal; var status : integer); cdecl;
  nFANTOM100_iNXT_sendDirectCommand : procedure(nxtHandle : FantomHandle; requireResponse : byte; inputBufferPtr : Pbyte; inputBufferSize : Cardinal; outputBufferPtr : PByte; outputBufferSize : Cardinal; var status : integer); cdecl;
  nFANTOM100_iNXT_setName : procedure(nxtHandle : FantomHandle; newName : PChar; var status : integer); cdecl;
  nFANTOM100_iNXTIterator_advance : procedure(NXTIterHandle : FantomHandle; var status : integer); cdecl;
  nFANTOM100_iNXTIterator_getName : procedure(NXTIterHandle : FantomHandle; resString : PChar; var status : integer); cdecl;// 256 bytes
  nFANTOM100_pairBluetooth : procedure(resourceName : PChar; passkey : PChar; pairedResourceName : PChar; var status : integer); cdecl;// 256 bytes
  nFANTOM100_unpairBluetooth : procedure(resourceName : PChar; var status : integer); cdecl;

  FantomSDKClose : procedure; cdecl;
  FantomSDKInit : procedure; cdecl;

var
  FantomAPILoaded: Boolean = False;

procedure UnloadFantomAPI;

implementation

uses
  Windows;

var
  DLLHandle: THandle;
  ErrorMode: Integer;

procedure UnloadFantomAPI;
begin
  if FantomAPILoaded then
  begin
    if DLLHandle >= 32 then
      FreeLibrary(DLLHandle);
    FantomAPILoaded := False;
  end;
end;

procedure LoadDLL;
begin
  if FantomAPILoaded then Exit;
  ErrorMode := SetErrorMode($8000);
  DLLHandle := LoadLibrary('FANTOM.DLL');
  if DLLHandle >= 32 then
  begin
    FantomAPILoaded := True;
    @nFANTOM100_createNXT := GetProcAddress(DLLHandle, 'nFANTOM100_createNXT');
    Assert(@nFANTOM100_createNXT <> nil);
    @nFANTOM100_createNXTIterator := GetProcAddress(DLLHandle, 'nFANTOM100_createNXTIterator');
    Assert(@nFANTOM100_createNXTIterator <> nil);
    @nFANTOM100_iFile_getAvailableSize := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_getAvailableSize');
    Assert(@nFANTOM100_iFile_getAvailableSize <> nil);
    @nFANTOM100_iFile_getSize := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_getSize');
    Assert(@nFANTOM100_iFile_getSize <> nil);
    @nFANTOM100_iFileIterator_getFile := GetProcAddress(DLLHandle, 'nFANTOM100_iFileIterator_getFile');
    Assert(@nFANTOM100_iFileIterator_getFile <> nil);
    @nFANTOM100_iFileIterator_getSize := GetProcAddress(DLLHandle, 'nFANTOM100_iFileIterator_getSize');
    Assert(@nFANTOM100_iFileIterator_getSize <> nil);
    @nFANTOM100_iModule_getIOMapSize := GetProcAddress(DLLHandle, 'nFANTOM100_iModule_getIOMapSize');
    Assert(@nFANTOM100_iModule_getIOMapSize <> nil);
    @nFANTOM100_iModule_getModuleID := GetProcAddress(DLLHandle, 'nFANTOM100_iModule_getModuleID');
    Assert(@nFANTOM100_iModule_getModuleID <> nil);
    @nFANTOM100_iModule_getModuleSize := GetProcAddress(DLLHandle, 'nFANTOM100_iModule_getModuleSize');
    Assert(@nFANTOM100_iModule_getModuleSize <> nil);
    @nFANTOM100_iModule_readIOMap := GetProcAddress(DLLHandle, 'nFANTOM100_iModule_readIOMap');
    Assert(@nFANTOM100_iModule_readIOMap <> nil);
    @nFANTOM100_iModule_writeIOMap := GetProcAddress(DLLHandle, 'nFANTOM100_iModule_writeIOMap');
    Assert(@nFANTOM100_iModule_writeIOMap <> nil);
    @nFANTOM100_iModuleIterator_getModule := GetProcAddress(DLLHandle, 'nFANTOM100_iModuleIterator_getModule');
    Assert(@nFANTOM100_iModuleIterator_getModule <> nil);
    @nFANTOM100_iNXT_createFile := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_createFile');
    Assert(@nFANTOM100_iNXT_createFile <> nil);
    @nFANTOM100_iNXT_createFileIterator := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_createFileIterator');
    Assert(@nFANTOM100_iNXT_createFileIterator <> nil);
    @nFANTOM100_iNXT_createModule := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_createModule');
    Assert(@nFANTOM100_iNXT_createModule <> nil);
    @nFANTOM100_iNXT_createModuleIterator := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_createModuleIterator');
    Assert(@nFANTOM100_iNXT_createModuleIterator <> nil);
    @nFANTOM100_iNXT_pollAvailableLength := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_pollAvailableLength');
    Assert(@nFANTOM100_iNXT_pollAvailableLength <> nil);
    @nFANTOM100_iNXT_readBufferData := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_readBufferData');
    Assert(@nFANTOM100_iNXT_readBufferData <> nil);
    @nFANTOM100_iNXT_write := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_write');
    Assert(@nFANTOM100_iNXT_write <> nil);
    @nFANTOM100_iNXTIterator_getNXT := GetProcAddress(DLLHandle, 'nFANTOM100_iNXTIterator_getNXT');
    Assert(@nFANTOM100_iNXTIterator_getNXT <> nil);
    @nFANTOM100_destroyNXT := GetProcAddress(DLLHandle, 'nFANTOM100_destroyNXT');
    Assert(@nFANTOM100_destroyNXT <> nil);
    @nFANTOM100_destroyNXTIterator := GetProcAddress(DLLHandle, 'nFANTOM100_destroyNXTIterator');
    Assert(@nFANTOM100_destroyNXTIterator <> nil);
    @nFANTOM100_iFile_close := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_close');
    Assert(@nFANTOM100_iFile_close <> nil);
    @nFANTOM100_iFile_getName := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_getName');
    Assert(@nFANTOM100_iFile_getName <> nil);
    @nFANTOM100_iFile_openForDataAppend := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_openForDataAppend');
    Assert(@nFANTOM100_iFile_openForDataAppend <> nil);
    @nFANTOM100_iFile_openForDataWrite := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_openForDataWrite');
    Assert(@nFANTOM100_iFile_openForDataWrite <> nil);
    @nFANTOM100_iFile_openForLinearWrite := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_openForLinearWrite');
    Assert(@nFANTOM100_iFile_openForLinearWrite <> nil);
    @nFANTOM100_iFile_openForRead := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_openForRead');
    Assert(@nFANTOM100_iFile_openForRead <> nil);
    @nFANTOM100_iFile_openForWrite := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_openForWrite');
    Assert(@nFANTOM100_iFile_openForWrite <> nil);
    @nFANTOM100_iFile_read := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_read');
    Assert(@nFANTOM100_iFile_read <> nil);
    @nFANTOM100_iFile_remove := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_remove');
    Assert(@nFANTOM100_iFile_remove <> nil);
    @nFANTOM100_iFile_write := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_write');
    Assert(@nFANTOM100_iFile_write <> nil);
    @nFANTOM100_iFileIterator_advance := GetProcAddress(DLLHandle, 'nFANTOM100_iFileIterator_advance');
    Assert(@nFANTOM100_iFileIterator_advance <> nil);
    @nFANTOM100_iFileIterator_getName := GetProcAddress(DLLHandle, 'nFANTOM100_iFileIterator_getName');
    Assert(@nFANTOM100_iFileIterator_getName <> nil);
    @nFANTOM100_iModule_getName := GetProcAddress(DLLHandle, 'nFANTOM100_iModule_getName');
    Assert(@nFANTOM100_iModule_getName <> nil);
    @nFANTOM100_iModuleIterator_advance := GetProcAddress(DLLHandle, 'nFANTOM100_iModuleIterator_advance');
    Assert(@nFANTOM100_iModuleIterator_advance <> nil);
    @nFANTOM100_iModuleIterator_getName := GetProcAddress(DLLHandle, 'nFANTOM100_iModuleIterator_getName');
    Assert(@nFANTOM100_iModuleIterator_getName <> nil);
    @nFANTOM100_iNXT_bluetoothFactoryReset := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_bluetoothFactoryReset');
    Assert(@nFANTOM100_iNXT_bluetoothFactoryReset <> nil);
    @nFANTOM100_iNXT_bootIntoFirmwareDownloadMode := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_bootIntoFirmwareDownloadMode');
    Assert(@nFANTOM100_iNXT_bootIntoFirmwareDownloadMode <> nil);
    @nFANTOM100_iNXT_destroyFile := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_destroyFile');
    Assert(@nFANTOM100_iNXT_destroyFile <> nil);
    @nFANTOM100_iNXT_destroyFileIterator := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_destroyFileIterator');
    Assert(@nFANTOM100_iNXT_destroyFileIterator <> nil);
    @nFANTOM100_iNXT_destroyModule := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_destroyModule');
    Assert(@nFANTOM100_iNXT_destroyModule <> nil);
    @nFANTOM100_iNXT_destroyModuleIterator := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_destroyModuleIterator');
    Assert(@nFANTOM100_iNXT_destroyModuleIterator <> nil);
    @nFANTOM100_iNXT_downloadFirmware := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_downloadFirmware');
    Assert(@nFANTOM100_iNXT_downloadFirmware <> nil);
    @nFANTOM100_iNXT_eraseUserFlash := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_eraseUserFlash');
    Assert(@nFANTOM100_iNXT_eraseUserFlash <> nil);
    @nFANTOM100_iNXT_findDeviceInFirmwareDownloadMode := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_findDeviceInFirmwareDownloadMode');
    Assert(@nFANTOM100_iNXT_findDeviceInFirmwareDownloadMode <> nil);
    @nFANTOM100_iNXT_getDeviceInfo := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_getDeviceInfo');
    Assert(@nFANTOM100_iNXT_getDeviceInfo <> nil);
    @nFANTOM100_iNXT_getFirmwareVersion := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_getFirmwareVersion');
    Assert(@nFANTOM100_iNXT_getFirmwareVersion <> nil);
    @nFANTOM100_iNXT_getResourceString := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_getResourceString');
    Assert(@nFANTOM100_iNXT_getResourceString <> nil);
    @nFANTOM100_iNXT_read := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_read');
    Assert(@nFANTOM100_iNXT_read <> nil);
    @nFANTOM100_iNXT_sendDirectCommand := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_sendDirectCommand');
    Assert(@nFANTOM100_iNXT_sendDirectCommand <> nil);
    @nFANTOM100_iNXT_setName := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_setName');
    Assert(@nFANTOM100_iNXT_setName <> nil);
    @nFANTOM100_iNXTIterator_advance := GetProcAddress(DLLHandle, 'nFANTOM100_iNXTIterator_advance');
    Assert(@nFANTOM100_iNXTIterator_advance <> nil);
    @nFANTOM100_iNXTIterator_getName := GetProcAddress(DLLHandle, 'nFANTOM100_iNXTIterator_getName');
    Assert(@nFANTOM100_iNXTIterator_getName <> nil);
    @nFANTOM100_isPaired := GetProcAddress(DLLHandle, 'nFANTOM100_isPaired');
    Assert(@nFANTOM100_isPaired <> nil);
    @nFANTOM100_pairBluetooth := GetProcAddress(DLLHandle, 'nFANTOM100_pairBluetooth');
    Assert(@nFANTOM100_pairBluetooth <> nil);
    @nFANTOM100_unpairBluetooth := GetProcAddress(DLLHandle, 'nFANTOM100_unpairBluetooth');
    Assert(@nFANTOM100_unpairBluetooth <> nil);

    @FantomSDKClose := GetProcAddress(DLLHandle, 'sdk_close');
    Assert(@FantomSDKClose <> nil);
    @FantomSDKInit := GetProcAddress(DLLHandle, 'sdk_init');
    Assert(@FantomSDKInit <> nil);
  end
  else
  begin
    FantomAPILoaded := False;
    { Error: fantom.DLL could not be loaded !! }
  end;
  SetErrorMode(ErrorMode)
end;


initialization
  LoadDLL;

finalization
  UnloadFantomAPI;

end.