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
  cmem,
  fantomfpc;

exports

  nFANTOM100_createNXT,
  nFANTOM100_createNXTIterator,
  nFANTOM100_iFile_getAvailableSize,
  nFANTOM100_iFile_getSize,
  nFANTOM100_iFileIterator_getFile,
  nFANTOM100_iFileIterator_getSize,
  nFANTOM100_iModule_getIOMapSize,
  nFANTOM100_iModule_getModuleID,
  nFANTOM100_iModule_getModuleSize,
  nFANTOM100_iModule_readIOMap,
  nFANTOM100_iModule_writeIOMap,
  nFANTOM100_iModuleIterator_getModule,
  nFANTOM100_iNXT_createFile,
  nFANTOM100_iNXT_createFileIterator,
  nFANTOM100_iNXT_createModule,
  nFANTOM100_iNXT_createModuleIterator,
  nFANTOM100_iNXT_pollAvailableLength,
  nFANTOM100_iNXT_readBufferData,
  nFANTOM100_iNXT_write,
  nFANTOM100_iNXTIterator_getNXT,
  nFANTOM100_isPaired,

  nFANTOM100_destroyNXT,
  nFANTOM100_destroyNXTIterator,
  nFANTOM100_iFile_close,
  nFANTOM100_iFile_getName,
  nFANTOM100_iFile_openForDataAppend,
  nFANTOM100_iFile_openForDataWrite,
  nFANTOM100_iFile_openForLinearWrite,
  nFANTOM100_iFile_openForRead,
  nFANTOM100_iFile_openForWrite,
  nFANTOM100_iFile_read,
  nFANTOM100_iFile_remove,
  nFANTOM100_iFile_write,
  nFANTOM100_iFileIterator_advance,
  nFANTOM100_iFileIterator_getName,
  nFANTOM100_iModule_getName,
  nFANTOM100_iModuleIterator_advance,
  nFANTOM100_iModuleIterator_getName,
  nFANTOM100_iNXT_bluetoothFactoryReset,
  nFANTOM100_iNXT_bootIntoFirmwareDownloadMode,
  nFANTOM100_iNXT_destroyFile,
  nFANTOM100_iNXT_destroyFileIterator,
  nFANTOM100_iNXT_destroyModule,
  nFANTOM100_iNXT_destroyModuleIterator,
  nFANTOM100_iNXT_downloadFirmware,
  nFANTOM100_iNXT_eraseUserFlash,
  nFANTOM100_iNXT_findDeviceInFirmwareDownloadMode,
  nFANTOM100_iNXT_getDeviceInfo,
  nFANTOM100_iNXT_getFirmwareVersion,
  nFANTOM100_iNXT_getResourceString,
  nFANTOM100_iNXT_read,
  nFANTOM100_iNXT_sendDirectCommand,
  nFANTOM100_iNXT_setName,
  nFANTOM100_iNXTIterator_advance,
  nFANTOM100_iNXTIterator_getName,
  nFANTOM100_pairBluetooth,
  nFANTOM100_unpairBluetooth,
  FantomSDKClose,
  FantomSDKInit;

end.

