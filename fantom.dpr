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
 * Copyright (C) 2011 John Hansen.
 * All Rights Reserved.
 *
 *)
library fantom;

{$mode delphi}
{$H+}

uses
  fantomfpc;

exports

  createNXT,
  createNXTIterator,
  iFile_getAvailableSize,
  iFile_getSize,
  iFileIterator_getFile,
  iFileIterator_getSize,
  iModule_getIOMapSize,
  iModule_getModuleID,
  iModule_getModuleSize,
  iModule_readIOMap,
  iModule_writeIOMap,
  iModuleIterator_getModule,
  iNXT_createFile,
  iNXT_createFileIterator,
  iNXT_createModule,
  iNXT_createModuleIterator,
  iNXT_pollAvailableLength,
  iNXT_readBufferData,
  iNXT_write,
  iNXTIterator_getNXT,

  destroyNXT,
  destroyNXTIterator,
  iFile_close,
  iFile_getName,
  iFile_openForDataAppend,
  iFile_openForDataWrite,
  iFile_openForLinearWrite,
  iFile_openForRead,
  iFile_openForWrite,
  iFile_read,
  iFile_remove,
  iFile_write,
  iFileIterator_advance,
  iFileIterator_getName,
  iModule_getName,
  iModuleIterator_advance,
  iModuleIterator_getName,
  iNXT_bluetoothFactoryReset,
  iNXT_bootIntoFirmwareDownloadMode,
  iNXT_destroyFile,
  iNXT_destroyFileIterator,
  iNXT_destroyModule,
  iNXT_destroyModuleIterator,
  iNXT_downloadFirmware,
  iNXT_eraseUserFlash,
  iNXT_findDeviceInFirmwareDownloadMode,
  iNXT_getDeviceInfo,
  iNXT_getFirmwareVersion,
  iNXT_getResourceString,
  iNXT_read,
  iNXT_sendDirectCommand,
  iNXT_setName,
  iNXTIterator_advance,
  iNXTIterator_getName,
  pairBluetooth,
  unpairBluetooth,
  FantomSDKClose,
  FantomSDKInit;

end.

