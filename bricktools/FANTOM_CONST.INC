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

const
  kBufferStandard = 0;
  kBufferHighSpeed = 1;
  kStatusNoError = 0;
  kStatusOffset = -142000; // 0x550
  kStatusFirst                        = (kStatusOffset + 0);     // 0x550
  kStatusPairingFailed                = (kStatusOffset + -5);    // 0x54B
  kStatusBluetoothSearchFailed        = (kStatusOffset + -6);    // 0x54A
  kStatusSystemLibraryNotFound        = (kStatusOffset + -7);    // 0x549
  kStatusUnpairingFailed              = (kStatusOffset + -8);    // 0x548
  kStatusInvalidFilename              = (kStatusOffset + -9);    // 0x547
  kStatusInvalidIteratorDereference   = (kStatusOffset + -10);   // 0x546
  kStatusLockOperationFailed          = (kStatusOffset + -11);   // 0x545
  kStatusSizeUnknown                  = (kStatusOffset + -12);   // 0x544
  kStatusDuplicateOpen                = (kStatusOffset + -13);   // 0x543
  kStatusEmptyFile                    = (kStatusOffset + -14);   // 0x542
  kStatusFirmwareDownloadFailed       = (kStatusOffset + -15);   // 0x541
  kStatusPortNotFound                 = (kStatusOffset + -16);   // 0x540
  kStatusNoMoreItemsFound             = (kStatusOffset + -17);   // 0x53F
  kStatusTooManyUnconfiguredDevices   = (kStatusOffset + -18);   // 0x53E
  kStatusCommandMismatch              = (kStatusOffset + -19);   // 0x53D
  kStatusIllegalOperation             = (kStatusOffset + -20);   // 0x53C
  kStatusBluetoothCacheUpdateFailed   = (kStatusOffset + -21);   // 0x53B
  kStatusNonNXTDeviceSelected         = (kStatusOffset + -22);   // 0x53A

  kStatusFeatureNotImplemented        = (kStatusOffset + -99);   // 0x4ED

  kStatusFWIllegalHandle              = (kStatusOffset + -189);  // 0x493
  kStatusFWIllegalFileName            = (kStatusOffset + -190);  // 0x492
  kStatusFWOutOfBounds                = (kStatusOffset + -191);  // 0x491
  kStatusFWModuleNotFound             = (kStatusOffset + -192);  // 0x490
  kStatusFWFileExists                 = (kStatusOffset + -193);  // 0x48F
  kStatusFWFileIsFull                 = (kStatusOffset + -194);  // 0x48E
  kStatusFWAppendNotPossible          = (kStatusOffset + -195);  // 0x48D
  kStatusFWNoWriteBuffers             = (kStatusOffset + -196);  // 0x48C
  kStatusFWFileIsBusy                 = (kStatusOffset + -197);  // 0x48B
  kStatusFWUndefinedError             = (kStatusOffset + -198);  // 0x48A
  kStatusFWNoLinearSpace              = (kStatusOffset + -199);  // 0x489
  kStatusFWHandleAlreadyClosed        = (kStatusOffset + -200);  // 0x488
  kStatusFWFileNotFound               = (kStatusOffset + -201);  // 0x487
  kStatusFWNotLinearFile              = (kStatusOffset + -202);  // 0x486
  kStatusFWEndOfFile                  = (kStatusOffset + -203);  // 0x485
  kStatusFWEndOfFileExpected          = (kStatusOffset + -204);  // 0x484
  kStatusFWNoMoreFiles                = (kStatusOffset + -205);  // 0x483
  kStatusFWNoSpace                    = (kStatusOffset + -206);  // 0x482
  kStatusFWNoMoreHandles              = (kStatusOffset + -207);  // 0x481
  kStatusFWUnknownErrorCode           = (kStatusOffset + -208);  // 0x480

  kStatusFWNXTNotPresent          = (kStatusOffset + -301);
  kStatusFWConfigurationError     = (kStatusOffset + -302);
  kStatusFWNXTInUse               = (kStatusOffset + -303);
  kStatusFWUSBWriteError          = (kStatusOffset + -304);
  kStatusFWUSBReadError           = (kStatusOffset + -305);
  kStatusFWSAMBAProtocolError     = (kStatusOffset + -306);
  kStatusFWHandshakeFailed        = (kStatusOffset + -307);
  kStatusFWFileError              = (kStatusOffset + -308);
  kStatusFWInvalidFirmware        = (kStatusOffset + -309);

  kStatusLast                         = (kStatusOffset + -999);