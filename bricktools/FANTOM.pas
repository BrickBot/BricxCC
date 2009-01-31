unit FANTOM;

interface

{$I FANTOM_CONST.INC}

var
  createNXT : function(resString : PChar; var status : integer; checkFWversion : byte) : Cardinal; cdecl;
  createNXTIterator : function(searchBluetooth : byte; bluetoothSearchTimeout : Cardinal; var status : integer) : Cardinal; cdecl;
  iFile_getAvailableSize : function(fileHandle : Cardinal; var status : integer) : Cardinal; cdecl;
  iFile_getSize : function(fileHandle : Cardinal; var status : integer) : Cardinal; cdecl;
  iFileIterator_getFile : function(iterHandle : Cardinal; var status : integer) : Cardinal; cdecl;
  iFileIterator_getSize : function(fileIterHandle : Cardinal; var status : integer) : Cardinal; cdecl;
  iModule_getIOMapSize : function(moduleHandle : Cardinal; var status : integer) : Cardinal; cdecl;
  iModule_getModuleID : function(moduleHandle : Cardinal; var status : integer) : Cardinal; cdecl;
  iModule_getModuleSize : function(moduleHandle : Cardinal; var status : integer) : Cardinal; cdecl;
  iModule_readIOMap : function(moduleHandle : Cardinal; offset : Cardinal; numberBytesToRead : Cardinal; dataBuffer : PByte; var status : integer) : Cardinal; cdecl;
  iModule_writeIOMap : function(moduleHandle : Cardinal; offset : Cardinal; numberBytesToWrite : Cardinal; dataBuffer : PByte; var status : integer) : Cardinal; cdecl;
  iModuleIterator_getModule : function(modIterHandle : Cardinal; var status : integer) : Cardinal; cdecl;
  iNXT_createFile : function(nxtHandle : Cardinal; const filename : PChar; var status : integer) : Cardinal; cdecl;
  iNXT_createFileIterator : function(nxtHandle : Cardinal; filePattern : PChar; var status : integer) : Cardinal; cdecl;
  iNXT_createModule : function(nxtHandle : Cardinal; moduleName : PChar; moduleID : Cardinal; moduleSize : Cardinal; IOMapSize : Cardinal; var status : integer) : Cardinal; cdecl;
  iNXT_createModuleIterator : function(nxtHandle : Cardinal; moduleNamePattern : PChar; var status : integer) : Cardinal; cdecl;
  iNXT_pollAvailableLength : function(nxtHandle : Cardinal; bufferSelector : Cardinal; var status : integer) : Cardinal; cdecl;
  iNXT_readBufferData : function(nxtHandle : Cardinal; dataBuffer : PByte; bufferSelector : Cardinal; numberOfBytesToRead : Cardinal; var status : integer) : Cardinal; cdecl;
  iNXT_write : function(nxtHandle : Cardinal; writeBuffer : PByte; writeBufferSize : Cardinal; var status : integer) : Cardinal; cdecl;
  iNXTIterator_getNXT : function(nxtIterHandle : Cardinal; var status : integer) : Cardinal; cdecl;

  destroyNXT : procedure(nxtHandle : Cardinal; var status : integer); cdecl;
  destroyNXTIterator : procedure(nxtIteratorHandle : Cardinal; var status : integer); cdecl;
  iFile_close : procedure(fileHandle : Cardinal; var status : integer); cdecl;
  iFile_getName : procedure(fileHandle : Cardinal; filename : PChar; var status : integer); cdecl;
  iFile_openForDataAppend : procedure(fileHandle : Cardinal; var status : integer); cdecl;
  iFile_openForDataWrite : procedure(fileHandle : Cardinal; sizeInBytes : Cardinal; var status : integer); cdecl;
  iFile_openForLinearWrite : procedure(fileHandle : Cardinal; sizeInBytes : Cardinal; var status : integer); cdecl;
  iFile_openForRead : procedure(fileHandle : Cardinal; var status : integer); cdecl;
  iFile_openForWrite : procedure(fileHandle : Cardinal; fileSize : Cardinal; var status : integer); cdecl;
  iFile_read : procedure(fileHandle : Cardinal; fileDataBuffer : PByte; bufferSize : Cardinal; var status : integer); cdecl;
  iFile_remove : procedure(fileHandle : Cardinal; var status : integer); cdecl;
  iFile_write : procedure(fileHandle : Cardinal; writeBuffer : PByte; writeBufferLength : Cardinal; var status : integer); cdecl;
  iFileIterator_advance : procedure(iterHandle : Cardinal; var status : integer); cdecl;
  iFileIterator_getName : procedure(iterHandle : Cardinal; filename : PChar; var status : integer); cdecl;
  iModule_getName : procedure(moduleHandle : Cardinal; moduleName : PChar; var status : integer); cdecl;// 20 bytes
  iModuleIterator_advance : procedure(modIterHandle : Cardinal; var status : integer); cdecl;
  iModuleIterator_getName : procedure(modIterHandle : Cardinal; moduleName : PChar; var status : integer); cdecl;// 256 bytes
  iNXT_bluetoothFactoryReset : procedure(nxtHandle : Cardinal; var status : integer); cdecl;
  iNXT_bootIntoFirmwareDownloadMode : procedure(resourceName : PChar; var status : integer); cdecl;
  iNXT_destroyFile : procedure(nxtHandle : Cardinal; fileHandle : Cardinal; var status : integer); cdecl;
  iNXT_destroyFileIterator : procedure(nxtHandle : Cardinal; iterHandle : Cardinal; var status : integer); cdecl;
  iNXT_destroyModule : procedure(nxtHandle : Cardinal; moduleHandle : Cardinal; var status : integer); cdecl;
  iNXT_destroyModuleIterator : procedure(nxtHandle : Cardinal; modIterHandle : Cardinal; var status : integer); cdecl;
  iNXT_downloadFirmware : procedure(nxtHandle : Cardinal; firmwareBuffer : PByte; firmwareBufferSize : Cardinal; var status : integer); cdecl;
  iNXT_eraseUserFlash : procedure(nxtHandle : Cardinal; var status : integer); cdecl;
  iNXT_findDeviceInFirmwareDownloadMode : procedure(resString : PChar; var status : integer); cdecl;
  iNXT_getDeviceInfo : procedure(nxtHandle : Cardinal; name : PChar; address : PByte; signalStrength : PByte; var availableFlash : Cardinal; var status : integer); cdecl;
  iNXT_getFirmwareVersion : procedure(nxtHandle : Cardinal; var protocolVersionMajor, protocolVersionMinor, firmwareVersionMajor, firmwareVersionMinor : byte; var status : integer); cdecl;
  iNXT_getResourceString : procedure(nxtHandle : Cardinal; resString : PChar; var status : integer); cdecl;// 55 bytes
  iNXT_read : procedure(nxtHandle : Cardinal; readBuffer : PByte; readBufferSize : Cardinal; var status : integer); cdecl;
  iNXT_sendDirectCommand : procedure(nxtHandle : Cardinal; requireResponse : byte; inputBufferPtr : Pbyte; inputBufferSize : Cardinal; outputBufferPtr : PByte; outputBufferSize : Cardinal; var status : integer); cdecl;
  iNXT_setName : procedure(nxtHandle : Cardinal; newName : PChar; var status : integer); cdecl;
  iNXTIterator_advance : procedure(NXTIterHandle : Cardinal; var status : integer); cdecl;
  iNXTIterator_getName : procedure(NXTIterHandle : Cardinal; resString : PChar; var status : integer); cdecl;// 256 bytes
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
