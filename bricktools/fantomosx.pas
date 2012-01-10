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
unit fantomosx;

interface

uses
  FantomDefs;

{$I FANTOM_CONST.INC}

function nFANTOM100_createNXT(resString : PChar; var status : integer; checkFWversion : byte) : FantomHandle; cdecl; external;
function nFANTOM100_createNXTIterator(searchBluetooth : byte; bluetoothSearchTimeout : Cardinal; var status : integer) : FantomHandle; cdecl; external;
function nFANTOM100_iFile_getAvailableSize(fileHandle : FantomHandle; var status : integer) : Cardinal; cdecl; external;
function nFANTOM100_iFile_getSize(fileHandle : FantomHandle; var status : integer) : Cardinal; cdecl; external;
function nFANTOM100_iFileIterator_getFile(iterHandle : FantomHandle; var status : integer) : FantomHandle; cdecl; external;
function nFANTOM100_iFileIterator_getSize(fileIterHandle : FantomHandle; var status : integer) : Cardinal; cdecl; external;
function nFANTOM100_iModule_getIOMapSize(moduleHandle : FantomHandle; var status : integer) : Cardinal; cdecl; external;
function nFANTOM100_iModule_getModuleID(moduleHandle : FantomHandle; var status : integer) : Cardinal; cdecl; external;
function nFANTOM100_iModule_getModuleSize(moduleHandle : FantomHandle; var status : integer) : Cardinal; cdecl; external;
function nFANTOM100_iModule_readIOMap(moduleHandle : FantomHandle; offset : Cardinal; numberBytesToRead : Cardinal; dataBuffer : PByte; var status : integer) : Cardinal; cdecl; external;
function nFANTOM100_iModule_writeIOMap(moduleHandle : FantomHandle; offset : Cardinal; numberBytesToWrite : Cardinal; dataBuffer : PByte; var status : integer) : Cardinal; cdecl; external;
function nFANTOM100_iModuleIterator_getModule(modIterHandle : FantomHandle; var status : integer) : FantomHandle; cdecl; external;
function nFANTOM100_iNXT_createFile(nxtHandle : FantomHandle; const filename : PChar; var status : integer) : FantomHandle; cdecl; external;
function nFANTOM100_iNXT_createFileIterator(nxtHandle : FantomHandle; filePattern : PChar; var status : integer) : FantomHandle; cdecl; external;
function nFANTOM100_iNXT_createModule(nxtHandle : FantomHandle; moduleName : PChar; moduleID : Cardinal; moduleSize : Cardinal; IOMapSize : Cardinal; var status : integer) : FantomHandle; cdecl; external;
function nFANTOM100_iNXT_createModuleIterator(nxtHandle : FantomHandle; moduleNamePattern : PChar; var status : integer) : FantomHandle; cdecl; external;
function nFANTOM100_iNXT_pollAvailableLength(nxtHandle : FantomHandle; bufferSelector : Cardinal; var status : integer) : Cardinal; cdecl; external;
function nFANTOM100_iNXT_readBufferData(nxtHandle : FantomHandle; dataBuffer : PByte; bufferSelector : Cardinal; numberOfBytesToRead : Cardinal; var status : integer) : Cardinal; cdecl; external;
function nFANTOM100_iNXT_write(nxtHandle : FantomHandle; writeBuffer : PByte; writeBufferSize : Cardinal; var status : integer) : Cardinal; cdecl; external;
function nFANTOM100_iNXTIterator_getNXT(nxtIterHandle : FantomHandle; var status : integer) : FantomHandle; cdecl; external;
function nFANTOM100_isPaired(resourceName : PChar; var status : integer) : boolean; cdecl; external;

procedure nFANTOM100_destroyNXT(nxtHandle : FantomHandle; var status : integer); cdecl; external;
procedure nFANTOM100_destroyNXTIterator(nxtIteratorHandle : FantomHandle; var status : integer); cdecl; external;
procedure nFANTOM100_iFile_close(fileHandle : FantomHandle; var status : integer); cdecl; external;
procedure nFANTOM100_iFile_getName(fileHandle : FantomHandle; filename : PChar; var status : integer); cdecl; external;
procedure nFANTOM100_iFile_openForDataAppend(fileHandle : FantomHandle; var status : integer); cdecl; external;
procedure nFANTOM100_iFile_openForDataWrite(fileHandle : FantomHandle; sizeInBytes : Cardinal; var status : integer); cdecl; external;
procedure nFANTOM100_iFile_openForLinearWrite(fileHandle : FantomHandle; sizeInBytes : Cardinal; var status : integer); cdecl; external;
procedure nFANTOM100_iFile_openForRead(fileHandle : FantomHandle; var status : integer); cdecl; external;
procedure nFANTOM100_iFile_openForWrite(fileHandle : FantomHandle; fileSize : Cardinal; var status : integer); cdecl; external;
procedure nFANTOM100_iFile_read(fileHandle : FantomHandle; fileDataBuffer : PByte; bufferSize : Cardinal; var status : integer); cdecl; external;
procedure nFANTOM100_iFile_remove(fileHandle : FantomHandle; var status : integer); cdecl; external;
procedure nFANTOM100_iFile_write(fileHandle : FantomHandle; writeBuffer : PByte; writeBufferLength : Cardinal; var status : integer); cdecl; external;
procedure nFANTOM100_iFileIterator_advance(iterHandle : FantomHandle; var status : integer); cdecl; external;
procedure nFANTOM100_iFileIterator_getName(iterHandle : FantomHandle; filename : PChar; var status : integer); cdecl; external;
procedure nFANTOM100_iModule_getName(moduleHandle : FantomHandle; moduleName : PChar; var status : integer); cdecl; external;
procedure nFANTOM100_iModuleIterator_advance(modIterHandle : FantomHandle; var status : integer); cdecl; external;
procedure nFANTOM100_iModuleIterator_getName(modIterHandle : FantomHandle; moduleName : PChar; var status : integer); cdecl; external;
procedure nFANTOM100_iNXT_bluetoothFactoryReset(nxtHandle : FantomHandle; var status : integer); cdecl; external;
procedure nFANTOM100_iNXT_bootIntoFirmwareDownloadMode(resourceName : PChar; var status : integer); cdecl; external;
procedure nFANTOM100_iNXT_destroyFile(nxtHandle : FantomHandle; fileHandle : FantomHandle; var status : integer); cdecl; external;
procedure nFANTOM100_iNXT_destroyFileIterator(nxtHandle : FantomHandle; iterHandle : FantomHandle; var status : integer); cdecl; external;
procedure nFANTOM100_iNXT_destroyModule(nxtHandle : FantomHandle; moduleHandle : FantomHandle; var status : integer); cdecl; external;
procedure nFANTOM100_iNXT_destroyModuleIterator(nxtHandle : FantomHandle; modIterHandle : FantomHandle; var status : integer); cdecl; external;
procedure nFANTOM100_iNXT_downloadFirmware(nxtHandle : FantomHandle; firmwareBuffer : PByte; firmwareBufferSize : Cardinal; var status : integer); cdecl; external;
procedure nFANTOM100_iNXT_eraseUserFlash(nxtHandle : FantomHandle; var status : integer); cdecl; external;
procedure nFANTOM100_iNXT_findDeviceInFirmwareDownloadMode(resString : PChar; var status : integer); cdecl; external;
procedure nFANTOM100_iNXT_getDeviceInfo(nxtHandle : FantomHandle; name : PChar; address : PByte; signalStrength : PByte; var availableFlash : Cardinal; var status : integer); cdecl; external;
procedure nFANTOM100_iNXT_getFirmwareVersion(nxtHandle : FantomHandle; var protocolVersionMajor, protocolVersionMinor, firmwareVersionMajor, firmwareVersionMinor : byte; var status : integer); cdecl; external;
procedure nFANTOM100_iNXT_getResourceString(nxtHandle : FantomHandle; resString : PChar; var status : integer); cdecl; external;
procedure nFANTOM100_iNXT_read(nxtHandle : FantomHandle; readBuffer : PByte; readBufferSize : Cardinal; var status : integer); cdecl; external;
procedure nFANTOM100_iNXT_sendDirectCommand(nxtHandle : FantomHandle; requireResponse : byte; inputBufferPtr : Pbyte; inputBufferSize : Cardinal; outputBufferPtr : PByte; outputBufferSize : Cardinal; var status : integer); cdecl; external;
procedure nFANTOM100_iNXT_setName(nxtHandle : FantomHandle; newName : PChar; var status : integer); cdecl; external;
procedure nFANTOM100_iNXTIterator_advance(NXTIterHandle : FantomHandle; var status : integer); cdecl; external;
procedure nFANTOM100_iNXTIterator_getName(NXTIterHandle : FantomHandle; resString : PChar; var status : integer); cdecl; external;
procedure nFANTOM100_pairBluetooth(resourceName : PChar; passkey : PChar; pairedResourceName : PChar; var status : integer); cdecl; external;
procedure nFANTOM100_unpairBluetooth(resourceName : PChar; var status : integer); cdecl; external;
procedure nFANTOM100_FantomSDKClose; cdecl; external;
procedure nFANTOM100_FantomSDKInit; cdecl; external;

var
  FantomAPILoaded: Boolean = False;

implementation

initialization
  FantomAPILoaded := True;

end.
