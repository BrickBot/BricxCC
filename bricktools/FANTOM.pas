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
unit FANTOM;

interface

uses
  FantomDefs;

{$I FANTOM_CONST.INC}

var
  createNXT : function(resString : PChar; var status : integer; checkFWversion : byte) : FantomHandle; cdecl;
  createNXTIterator : function(searchBluetooth : byte; bluetoothSearchTimeout : Cardinal; var status : integer) : FantomHandle; cdecl;
  iFile_getAvailableSize : function(fileHandle : FantomHandle; var status : integer) : Cardinal; cdecl;
  iFile_getSize : function(fileHandle : FantomHandle; var status : integer) : Cardinal; cdecl;
  iFileIterator_getFile : function(iterHandle : FantomHandle; var status : integer) : FantomHandle; cdecl;
  iFileIterator_getSize : function(fileIterHandle : FantomHandle; var status : integer) : Cardinal; cdecl;
  iModule_getIOMapSize : function(moduleHandle : FantomHandle; var status : integer) : Cardinal; cdecl;
  iModule_getModuleID : function(moduleHandle : FantomHandle; var status : integer) : Cardinal; cdecl;
  iModule_getModuleSize : function(moduleHandle : FantomHandle; var status : integer) : Cardinal; cdecl;
  iModule_readIOMap : function(moduleHandle : FantomHandle; offset : Cardinal; numberBytesToRead : Cardinal; dataBuffer : PByte; var status : integer) : Cardinal; cdecl;
  iModule_writeIOMap : function(moduleHandle : FantomHandle; offset : Cardinal; numberBytesToWrite : Cardinal; dataBuffer : PByte; var status : integer) : Cardinal; cdecl;
  iModuleIterator_getModule : function(modIterHandle : FantomHandle; var status : integer) : FantomHandle; cdecl;
  iNXT_createFile : function(nxtHandle : FantomHandle; const filename : PChar; var status : integer) : FantomHandle; cdecl;
  iNXT_createFileIterator : function(nxtHandle : FantomHandle; filePattern : PChar; var status : integer) : FantomHandle; cdecl;
  iNXT_createModule : function(nxtHandle : FantomHandle; moduleName : PChar; moduleID : Cardinal; moduleSize : Cardinal; IOMapSize : Cardinal; var status : integer) : FantomHandle; cdecl;
  iNXT_createModuleIterator : function(nxtHandle : FantomHandle; moduleNamePattern : PChar; var status : integer) : FantomHandle; cdecl;
  iNXT_pollAvailableLength : function(nxtHandle : FantomHandle; bufferSelector : Cardinal; var status : integer) : Cardinal; cdecl;
  iNXT_readBufferData : function(nxtHandle : FantomHandle; dataBuffer : PByte; bufferSelector : Cardinal; numberOfBytesToRead : Cardinal; var status : integer) : Cardinal; cdecl;
  iNXT_write : function(nxtHandle : FantomHandle; writeBuffer : PByte; writeBufferSize : Cardinal; var status : integer) : Cardinal; cdecl;
  iNXTIterator_getNXT : function(nxtIterHandle : FantomHandle; var status : integer) : FantomHandle; cdecl;

  destroyNXT : procedure(nxtHandle : FantomHandle; var status : integer); cdecl;
  destroyNXTIterator : procedure(nxtIteratorHandle : FantomHandle; var status : integer); cdecl;
  iFile_close : procedure(fileHandle : FantomHandle; var status : integer); cdecl;
  iFile_getName : procedure(fileHandle : FantomHandle; filename : PChar; var status : integer); cdecl;
  iFile_openForDataAppend : procedure(fileHandle : FantomHandle; var status : integer); cdecl;
  iFile_openForDataWrite : procedure(fileHandle : FantomHandle; sizeInBytes : Cardinal; var status : integer); cdecl;
  iFile_openForLinearWrite : procedure(fileHandle : FantomHandle; sizeInBytes : Cardinal; var status : integer); cdecl;
  iFile_openForRead : procedure(fileHandle : FantomHandle; var status : integer); cdecl;
  iFile_openForWrite : procedure(fileHandle : FantomHandle; fileSize : Cardinal; var status : integer); cdecl;
  iFile_read : procedure(fileHandle : FantomHandle; fileDataBuffer : PByte; bufferSize : Cardinal; var status : integer); cdecl;
  iFile_remove : procedure(fileHandle : FantomHandle; var status : integer); cdecl;
  iFile_write : procedure(fileHandle : Cardinal; writeBuffer : PByte; writeBufferLength : Cardinal; var status : integer); cdecl;
  iFileIterator_advance : procedure(iterHandle : FantomHandle; var status : integer); cdecl;
  iFileIterator_getName : procedure(iterHandle : FantomHandle; filename : PChar; var status : integer); cdecl;
  iModule_getName : procedure(moduleHandle : FantomHandle; moduleName : PChar; var status : integer); cdecl;// 20 bytes
  iModuleIterator_advance : procedure(modIterHandle : FantomHandle; var status : integer); cdecl;
  iModuleIterator_getName : procedure(modIterHandle : FantomHandle; moduleName : PChar; var status : integer); cdecl;// 256 bytes
  iNXT_bluetoothFactoryReset : procedure(nxtHandle : FantomHandle; var status : integer); cdecl;
  iNXT_bootIntoFirmwareDownloadMode : procedure(resourceName : PChar; var status : integer); cdecl;
  iNXT_destroyFile : procedure(nxtHandle : FantomHandle; fileHandle : Cardinal; var status : integer); cdecl;
  iNXT_destroyFileIterator : procedure(nxtHandle : FantomHandle; iterHandle : FantomHandle; var status : integer); cdecl;
  iNXT_destroyModule : procedure(nxtHandle : FantomHandle; moduleHandle : FantomHandle; var status : integer); cdecl;
  iNXT_destroyModuleIterator : procedure(nxtHandle : FantomHandle; modIterHandle : FantomHandle; var status : integer); cdecl;
  iNXT_downloadFirmware : procedure(nxtHandle : FantomHandle; firmwareBuffer : PByte; firmwareBufferSize : Cardinal; var status : integer); cdecl;
  iNXT_eraseUserFlash : procedure(nxtHandle : FantomHandle; var status : integer); cdecl;
  iNXT_findDeviceInFirmwareDownloadMode : procedure(resString : PChar; var status : integer); cdecl;
  iNXT_getDeviceInfo : procedure(nxtHandle : FantomHandle; name : PChar; address : PByte; signalStrength : PByte; var availableFlash : Cardinal; var status : integer); cdecl;
  iNXT_getFirmwareVersion : procedure(nxtHandle : FantomHandle; var protocolVersionMajor, protocolVersionMinor, firmwareVersionMajor, firmwareVersionMinor : byte; var status : integer); cdecl;
  iNXT_getResourceString : procedure(nxtHandle : FantomHandle; resString : PChar; var status : integer); cdecl;// 55 bytes
  iNXT_read : procedure(nxtHandle : FantomHandle; readBuffer : PByte; readBufferSize : Cardinal; var status : integer); cdecl;
  iNXT_sendDirectCommand : procedure(nxtHandle : FantomHandle; requireResponse : byte; inputBufferPtr : Pbyte; inputBufferSize : Cardinal; outputBufferPtr : PByte; outputBufferSize : Cardinal; var status : integer); cdecl;
  iNXT_setName : procedure(nxtHandle : FantomHandle; newName : PChar; var status : integer); cdecl;
  iNXTIterator_advance : procedure(NXTIterHandle : FantomHandle; var status : integer); cdecl;
  iNXTIterator_getName : procedure(NXTIterHandle : FantomHandle; resString : PChar; var status : integer); cdecl;// 256 bytes
  pairBluetooth : procedure(resourceName : PChar; passkey : PChar; pairedResourceName : PChar; var status : integer); cdecl;// 256 bytes
  unpairBluetooth : procedure(resourceName : PChar; var status : integer); cdecl;
  FantomSDKClose : procedure; cdecl;
  FantomSDKInit : procedure; cdecl;

var
  FantomAPILoaded: Boolean = False;

procedure UnloadFantomAPI;

implementation

uses
  Windows;

var
  SaveExit: pointer;
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

procedure NewExit; far;
begin
  ExitProc := SaveExit;
  UnloadFantomAPI;
end;

procedure LoadDLL;
begin
  if FantomAPILoaded then Exit;
  ErrorMode := SetErrorMode($8000{SEM_NoOpenFileErrorBox});
  DLLHandle := LoadLibrary('FANTOM.DLL');
  if DLLHandle >= 32 then
  begin
    FantomAPILoaded := True;
    SaveExit := ExitProc;
    ExitProc := @NewExit;
    @createNXT := GetProcAddress(DLLHandle, 'nFANTOM100_createNXT');
    Assert(@createNXT <> nil);
    @createNXTIterator := GetProcAddress(DLLHandle, 'nFANTOM100_createNXTIterator');
    Assert(@createNXTIterator <> nil);
    @iFile_getAvailableSize := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_getAvailableSize');
    Assert(@iFile_getAvailableSize <> nil);
    @iFile_getSize := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_getSize');
    Assert(@iFile_getSize <> nil);
    @iFileIterator_getFile := GetProcAddress(DLLHandle, 'nFANTOM100_iFileIterator_getFile');
    Assert(@iFileIterator_getFile <> nil);
    @iFileIterator_getSize := GetProcAddress(DLLHandle, 'nFANTOM100_iFileIterator_getSize');
    Assert(@iFileIterator_getSize <> nil);
    @iModule_getIOMapSize := GetProcAddress(DLLHandle, 'nFANTOM100_iModule_getIOMapSize');
    Assert(@iModule_getIOMapSize <> nil);
    @iModule_getModuleID := GetProcAddress(DLLHandle, 'nFANTOM100_iModule_getModuleID');
    Assert(@iModule_getModuleID <> nil);
    @iModule_getModuleSize := GetProcAddress(DLLHandle, 'nFANTOM100_iModule_getModuleSize');
    Assert(@iModule_getModuleSize <> nil);
    @iModule_readIOMap := GetProcAddress(DLLHandle, 'nFANTOM100_iModule_readIOMap');
    Assert(@iModule_readIOMap <> nil);
    @iModule_writeIOMap := GetProcAddress(DLLHandle, 'nFANTOM100_iModule_writeIOMap');
    Assert(@iModule_writeIOMap <> nil);
    @iModuleIterator_getModule := GetProcAddress(DLLHandle, 'nFANTOM100_iModuleIterator_getModule');
    Assert(@iModuleIterator_getModule <> nil);
    @iNXT_createFile := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_createFile');
    Assert(@iNXT_createFile <> nil);
    @iNXT_createFileIterator := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_createFileIterator');
    Assert(@iNXT_createFileIterator <> nil);
    @iNXT_createModule := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_createModule');
    Assert(@iNXT_createModule <> nil);
    @iNXT_createModuleIterator := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_createModuleIterator');
    Assert(@iNXT_createModuleIterator <> nil);
    @iNXT_pollAvailableLength := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_pollAvailableLength');
    Assert(@iNXT_pollAvailableLength <> nil);
    @iNXT_readBufferData := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_readBufferData');
    Assert(@iNXT_readBufferData <> nil);
    @iNXT_write := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_write');
    Assert(@iNXT_write <> nil);
    @iNXTIterator_getNXT := GetProcAddress(DLLHandle, 'nFANTOM100_iNXTIterator_getNXT');
    Assert(@iNXTIterator_getNXT <> nil);
    @destroyNXT := GetProcAddress(DLLHandle, 'nFANTOM100_destroyNXT');
    Assert(@destroyNXT <> nil);
    @destroyNXTIterator := GetProcAddress(DLLHandle, 'nFANTOM100_destroyNXTIterator');
    Assert(@destroyNXTIterator <> nil);
    @iFile_close := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_close');
    Assert(@iFile_close <> nil);
    @iFile_getName := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_getName');
    Assert(@iFile_getName <> nil);
    @iFile_openForDataAppend := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_openForDataAppend');
    Assert(@iFile_openForDataAppend <> nil);
    @iFile_openForDataWrite := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_openForDataWrite');
    Assert(@iFile_openForDataWrite <> nil);
    @iFile_openForLinearWrite := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_openForLinearWrite');
    Assert(@iFile_openForLinearWrite <> nil);
    @iFile_openForRead := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_openForRead');
    Assert(@iFile_openForRead <> nil);
    @iFile_openForWrite := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_openForWrite');
    Assert(@iFile_openForWrite <> nil);
    @iFile_read := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_read');
    Assert(@iFile_read <> nil);
    @iFile_remove := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_remove');
    Assert(@iFile_remove <> nil);
    @iFile_write := GetProcAddress(DLLHandle, 'nFANTOM100_iFile_write');
    Assert(@iFile_write <> nil);
    @iFileIterator_advance := GetProcAddress(DLLHandle, 'nFANTOM100_iFileIterator_advance');
    Assert(@iFileIterator_advance <> nil);
    @iFileIterator_getName := GetProcAddress(DLLHandle, 'nFANTOM100_iFileIterator_getName');
    Assert(@iFileIterator_getName <> nil);
    @iModule_getName := GetProcAddress(DLLHandle, 'nFANTOM100_iModule_getName');
    Assert(@iModule_getName <> nil);
    @iModuleIterator_advance := GetProcAddress(DLLHandle, 'nFANTOM100_iModuleIterator_advance');
    Assert(@iModuleIterator_advance <> nil);
    @iModuleIterator_getName := GetProcAddress(DLLHandle, 'nFANTOM100_iModuleIterator_getName');
    Assert(@iModuleIterator_getName <> nil);
    @iNXT_bluetoothFactoryReset := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_bluetoothFactoryReset');
    Assert(@iNXT_bluetoothFactoryReset <> nil);
    @iNXT_bootIntoFirmwareDownloadMode := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_bootIntoFirmwareDownloadMode');
    Assert(@iNXT_bootIntoFirmwareDownloadMode <> nil);
    @iNXT_destroyFile := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_destroyFile');
    Assert(@iNXT_destroyFile <> nil);
    @iNXT_destroyFileIterator := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_destroyFileIterator');
    Assert(@iNXT_destroyFileIterator <> nil);
    @iNXT_destroyModule := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_destroyModule');
    Assert(@iNXT_destroyModule <> nil);
    @iNXT_destroyModuleIterator := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_destroyModuleIterator');
    Assert(@iNXT_destroyModuleIterator <> nil);
    @iNXT_downloadFirmware := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_downloadFirmware');
    Assert(@iNXT_downloadFirmware <> nil);
    @iNXT_eraseUserFlash := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_eraseUserFlash');
    Assert(@iNXT_eraseUserFlash <> nil);
    @iNXT_findDeviceInFirmwareDownloadMode := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_findDeviceInFirmwareDownloadMode');
    Assert(@iNXT_findDeviceInFirmwareDownloadMode <> nil);
    @iNXT_getDeviceInfo := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_getDeviceInfo');
    Assert(@iNXT_getDeviceInfo <> nil);
    @iNXT_getFirmwareVersion := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_getFirmwareVersion');
    Assert(@iNXT_getFirmwareVersion <> nil);
    @iNXT_getResourceString := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_getResourceString');
    Assert(@iNXT_getResourceString <> nil);
    @iNXT_read := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_read');
    Assert(@iNXT_read <> nil);
    @iNXT_sendDirectCommand := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_sendDirectCommand');
    Assert(@iNXT_sendDirectCommand <> nil);
    @iNXT_setName := GetProcAddress(DLLHandle, 'nFANTOM100_iNXT_setName');
    Assert(@iNXT_setName <> nil);
    @iNXTIterator_advance := GetProcAddress(DLLHandle, 'nFANTOM100_iNXTIterator_advance');
    Assert(@iNXTIterator_advance <> nil);
    @iNXTIterator_getName := GetProcAddress(DLLHandle, 'nFANTOM100_iNXTIterator_getName');
    Assert(@iNXTIterator_getName <> nil);
    @pairBluetooth := GetProcAddress(DLLHandle, 'nFANTOM100_pairBluetooth');
    Assert(@pairBluetooth <> nil);
    @unpairBluetooth := GetProcAddress(DLLHandle, 'nFANTOM100_unpairBluetooth');
    Assert(@unpairBluetooth <> nil);
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

end.
