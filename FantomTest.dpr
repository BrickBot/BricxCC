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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
program FantomTest;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  System,
  FantomSpirit,
  FANTOM;

var
  i : integer;
  iNXTIteratorHandle : Cardinal = 0;
  iNXTHandle : Cardinal = 0;
  iFileHandle : Cardinal = 0;
  iFileIteratorHandle : Cardinal = 0;
  tStatus : integer = 0;
  tStatus2 : integer = 0;
  protocolVersionMajor : byte = 0;
  protocolVersionMinor : byte = 0;
  firmwareVersionMajor : byte = 0;
  firmwareVersionMinor : byte = 0;
  // This is a direct command to play a tone.
  directCommandBuffer : array[0..4] of byte = ( $03, $00, $18, $10, $00 );
  fileBuffer : array[0..99] of byte;
  fileSizeInBytes : integer = sizeof(fileBuffer);
  fileName : array[0..19] of Char;
  dcBatteryLevel : array[0..0] of byte = ( $0B );
  dcResponse : array[0..63] of byte;
begin

  if FantomAPILoaded then
  begin
    FantomSDKInit;
    // Create an NXT iterator object which is used to find all accessible NXT devices.
    iNXTIteratorHandle := createNXTIterator(0, // don't search over bluetooth (only USB)
                                            0, // timeout for Bluetooth discovery ignored
                                            tStatus);
    // Creating the NXT iterator object could fail, better check status
    // before dereferencing a potentially NULL pointer.
    if tStatus = kStatusNoError then
    begin
      // Create an NXT object for the first NXT that was found.
      // Note that if a NXT is found over BT, the computer and
      // the NXT must be paired before an NXT object can be
      // created.  This can be done programatically using the
      // iNXT::pairBluetooth method.
      iNXTHandle := iNXTIterator_getNXT(iNXTIteratorHandle, tStatus);
      // Destroy the NXT iterator object which we no longer need
      destroyNXTIterator(iNXTIteratorHandle, tStatus2);
    end;
    // Creating the NXT object could fail, better check status
    // before dereferencing a potentially NULL pointer.
    if tStatus = kStatusNoError then
    begin
      // Query the version numbers for the protocol and firmware installed on the NXT.
      iNXT_getFirmwareVersion(iNXTHandle, protocolVersionMajor, protocolVersionMinor,
        firmwareVersionMajor, firmwareVersionMinor, tStatus );
      Writeln(Format('%d %d %d %d',
        [protocolVersionMajor, protocolVersionMinor,
         firmwareVersionMajor, firmwareVersionMinor]));
(*
      // Send the direct command to the NXT.
      iNXT_sendDirectCommand(iNXTHandle, 0 { a response is not required for this direct command },
        @directCommandBuffer[0], sizeof( directCommandBuffer ),
        nil { no response buffer }, 0 { no response buffer, specify 0 for size },
        tStatus );
*)
      // send another direct command
      iNXT_sendDirectCommand(iNXTHandle,
        1 { a response is required for this direct command },
        @dcBatteryLevel[0], { direct command request buffer }
        sizeof(dcBatteryLevel), { request buffer size }
        @dcResponse[0] { response buffer },
        4 { response buffer size },
        tStatus );
      Writeln(Format('%d', [dcResponse[2] + (dcResponse[3] shl 8)]));

      // Create a file object
      iFileHandle := iNXT_createFile(iNXTHandle, 'example.log', tStatus );
    end;
    // Creating the file object could fail, better check status
    // before dereferencing a potentially NULL pointer.
    if tStatus = kStatusNoError then
    begin
      for i := 0 to fileSizeInBytes - 1 do
        fileBuffer[i] := i+1;
      // Open the file for writing, this will also create this file on the NXT.
      iFile_openForWrite(iFileHandle, fileSizeInBytes, tStatus);
      // Write the file contents.
      iFile_write(iFileHandle, @fileBuffer[0], fileSizeInBytes, tStatus);
      // Close the file.
      iFile_close(iFileHandle, tStatus);
      // Destroy the file object.  Note that this does not affect the file on the NXT.
      iNXT_destroyFile(iNXTHandle, iFileHandle, tStatus);
      // Create a file iterator object which is used to find files on the NXT.
      iFileIteratorHandle := iNXT_createFileIterator(iNXTHandle,
        '*.*' { find all files on the NXT }, tStatus);
    end;
    // Creating the file iterator object could fail, better check status
    // before dereferencing a potentially NULL pointer.
    if tStatus = kStatusNoError then
    begin
      // Iterate through all of the files on the NXT until we find our
      // log file.  Obviously, this isn't necessary in this simple example
      // but is for illustrative purposes.
      while tStatus = kStatusNoError do
      begin
        iFileIterator_getName(iFileIteratorHandle, fileName, tStatus);
        if StrComp(fileName, 'example.log') = 0 then
          Break;
        iFileIterator_advance(iFileIteratorHandle, tStatus);
      end;
      // Now that we have found our log file, create a file object that corresponds to it.
      iFileHandle := iFileIterator_getFile(iFileIteratorHandle, tStatus);
      iNXT_destroyFileIterator(iNXTHandle, iFileIteratorHandle, tStatus2);
    end;
    // Creating the file object could fail, better check status
    // before dereferencing a potentially NULL pointer.
    if tStatus = kStatusNoError then
    begin
      // Open the file for reading.
      iFile_openForRead(iFileHandle, tStatus);

      // Read the file contents.
      iFile_read(iFileHandle, @fileBuffer[0], fileSizeInBytes, tStatus);

      // Close the file.
      iFile_close(iFileHandle, tStatus);

      // Remove the file.  This deletes the file from the NXT.
      iFile_remove(iFileHandle, tStatus);

      // Destroy the file object.
      iNXT_destroyFile(iNXTHandle, iFileHandle, tStatus2);
    end;
    destroyNXT(iNXTHandle, tStatus2);

    FantomSDKClose;
    UnloadFantomAPI;
  end;
end.