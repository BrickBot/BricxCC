/** \file nbc_loader.h
 * \brief The NBC loader module API
 *
 * nbc_loader.h contains the NBC loader module API
 *
 * License:
 *
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
 * ----------------------------------------------------------------------------
 *
 * \author John Hansen (bricxcc_at_comcast.net)
 * \date 2013-02-21
 * \version 2
 */

#ifndef NBC_LOADER_H
#define NBC_LOADER_H

#include "loader_constants.h"
#include "command_constants.h"
#include "nbc_command.h"

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// LOADER MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup LoaderModule
 * @{
 */
/** @defgroup LoaderModuleFunctions Loader module functions
 * Functions for accessing and modifying Loader module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

dseg segment

// FileOpenRead, FileOpenWrite, FileOpenAppend, FileOpenWriteLinear, FileOpenWriteNonLinear, FileOpenReadLinear
TFileOpen	struct
 Result		word
 FileHandle	byte
 Filename	byte[]
 Length		dword
TFileOpen	ends

// FileRead, FileWrite
TFileReadWrite	struct
 Result		word
 FileHandle	byte
 Buffer		byte[]
 Length		dword
TFileReadWrite	ends

// FileClose
TFileClose	struct
 Result		word
 FileHandle	byte
TFileClose	ends

// FileResolveHandle
TFileResolveHandle	struct
 Result		word
 FileHandle	byte
 WriteHandle	byte
 Filename	byte[]
TFileResolveHandle	ends

// FileRename
TFileRename	struct
 Result		word
 OldFilename	byte[]
 NewFilename	byte[]
TFileRename	ends

// FileDelete
TFileDelete	struct
 Result		word
 Filename	byte[]
TFileDelete	ends

  __FOArgs TFileOpen
  __FCArgs TFileClose
  __FRHArgs TFileResolveHandle
  __FRArgs TFileRename
  __FDArgs TFileDelete
  __FReadArgs TFileReadWrite
  __FWriteArgs TFileReadWrite

  __FOMutex mutex
  __FCMutex mutex
  __FRHMutex mutex
  __FRMutex mutex
  __FDMutex mutex
  __FFMutex mutex
  __FReadMutex mutex
  __FWriteMutex mutex
  __soMutex mutex

  __FReadTmpByte byte
  __RLSBuffer byte[]
  __RLSOutput byte[]
  __RLSReturn word
  __RLSReturnAddress byte
  __RLSMaxBytes word
  __RLSByteCount word
  __soTmpBuf byte[]
  __FWriteFlattenBuf byte[]
  __FWriteLn byte[] {0x0D, 0x0A}
dseg ends



#ifdef __ENHANCED_FIRMWARE
dseg segment
// FileFindFirst, FileFindNext
TFileFind	struct
 Result		word
 FileHandle	byte
 Filename	byte[]
 Length		dword
TFileFind	ends

  __FFArgs TFileFind
dseg ends

#if __FIRMWARE_VERSION > 107
dseg segment
//FileSeek
TFileSeek	struct
 Result		word
 FileHandle	byte
 Origin		byte
 Length		sdword
TFileSeek	ends

//FileResize
TFileResize	struct
 Result		word
 FileHandle	byte
 NewSize	word
TFileResize	ends

// FileTell
TFileTell struct
 Result     sbyte
 FileHandle byte
 Position   dword
TFileTell ends

dseg ends
#endif

#endif

subroutine __fileResizeSub
  dseg segment
    __frsMutex mutex
    __frsNewSize dword
    __frsOldName byte[]
    __frsTmpName byte[]
    __frsFOReadArgs TFileOpen
    __frsFOWriteArgs TFileOpen
    __frsFReadArgs TFileReadWrite
    __frsFWriteArgs TFileReadWrite
    __frsFRArgs TFileRename
    __frsFCArgs TFileClose
    __frsFDArgs TFileDelete
    __frsResult word
  dseg ends
  strcat __frsFRArgs.NewFilename, '_tmp', __frsOldName
  mov __frsFRArgs.OldFilename, __frsOldName
  syscall FileRename, __frsFRArgs
  mov __frsResult, __frsFRArgs.Result
  brtst NEQ, __frsEnd, __frsResult
  // old file has been renamed successfully
  mov __frsFOReadArgs.Filename, __frsFRArgs.NewFilename
  syscall FileOpenRead, __frsFOReadArgs
  mov __frsResult, __frsFOReadArgs.Result
  brtst NEQ, __frsOpenReadFailed, __frsResult
  // renamed file is open for reading
  mov __frsFOWriteArgs.Filename, __frsOldName
  mov __frsFOWriteArgs.Length, __frsNewSize
  syscall FileOpenWrite, __frsFOWriteArgs
  mov __frsResult, __frsFOWriteArgs.Result
  brtst NEQ, __frsOpenWriteFailed, __frsResult
  // both files are open
  mov __frsFReadArgs.FileHandle, __frsFOReadArgs.FileHandle
  mov __frsFWriteArgs.FileHandle, __frsFOWriteArgs.FileHandle
__frsCopyLoop:
  set __frsFReadArgs.Length, 1024
  syscall FileRead, __frsFReadArgs
  brtst LTEQ, __frsEndLoop, __frsFReadArgs.Length
  mov __frsFWriteArgs.Buffer, __frsFReadArgs.Buffer
  mov __frsFWriteArgs.Length, __frsFReadArgs.Length
  syscall FileWrite, __frsFWriteArgs
  brtst NEQ, __frsEndLoop, __frsFWriteArgs.Result
  brtst NEQ, __frsEndLoop, __frsFReadArgs.Result
  jmp __frsCopyLoop
__frsEndLoop:
  // close read file
  mov __frsFCArgs.FileHandle, __frsFOReadArgs.FileHandle
  syscall FileClose, __frsFCArgs
  // close write file
  mov __frsFCArgs.FileHandle, __frsFOWriteArgs.FileHandle
  syscall FileClose, __frsFCArgs
  // delete read file
  mov __frsFDArgs.Filename, __frsFOReadArgs.Filename
  syscall FileDelete, __frsFDArgs
  jmp __frsEnd
__frsOpenWriteFailed:
  // close read file
  mov __frsFCArgs.FileHandle, __frsFOReadArgs.FileHandle
  syscall FileClose, __frsFCArgs
  jmp __frsEnd
__frsOpenReadFailed:
  // if the open read failed rename tmp back to original and exit
  mov __frsFRArgs.OldFilename, __frsFRArgs.NewFilename
  mov __frsFRArgs.NewFilename, __frsOldName
  syscall FileRename, __frsFRArgs
__frsEnd:
  return
ends

subroutine __readStringLine
  arrinit __RLSOutput, 0, 1
  set __RLSByteCount, 0
  __RLSStringLoop:
  set __FReadArgs.Length, 1
  mov __RLSBuffer, __RLSOutput
  syscall FileRead, __FReadArgs
  mov __RLSReturn, __FReadArgs.Result
  brtst NEQ, __RLSStringDone, __RLSReturn
  index __FReadTmpByte, __FReadArgs.Buffer, NA
  brcmp EQ, __RLSStringDone, __FReadTmpByte, 0x0A
  brcmp EQ, __RLSStringSkip, __FReadTmpByte, 0x0D
  strcat __RLSOutput, __RLSBuffer, __FReadArgs.Buffer
  add __RLSByteCount, __RLSByteCount, 1
  brcmp GTEQ, __RLSStringDone, __RLSByteCount, __RLSMaxBytes
  __RLSStringSkip:
  jmp __RLSStringLoop
  __RLSStringDone:
  subret __RLSReturnAddress
ends

#define __fileResize(_fname, _newsize, _result) \
  acquire __frsMutex \
  mov __frsOldName, _fname \
  mov __frsNewSize, _newsize \
  call __fileResizeSub \
  mov _result, __frsResult \
  release __frsMutex 

#define __createFile(_fname, _fsize, _handle, _result) \
  acquire __FOMutex \
  mov __FOArgs.Filename, _fname \
  mov __FOArgs.Length, _fsize \
  syscall FileOpenWrite, __FOArgs \
  mov _handle, __FOArgs.FileHandle \
  mov _result, __FOArgs.Result \
  release __FOMutex

#define __createFileLinear(_fname, _fsize, _handle, _result) \
  acquire __FOMutex \
  mov __FOArgs.Filename, _fname \
  mov __FOArgs.Length, _fsize \
  syscall FileOpenWriteLinear, __FOArgs \
  mov _handle, __FOArgs.FileHandle \
  mov _result, __FOArgs.Result \
  release __FOMutex

#define __createFileNonLinear(_fname, _fsize, _handle, _result) \
  acquire __FOMutex \
  mov __FOArgs.Filename, _fname \
  mov __FOArgs.Length, _fsize \
  syscall FileOpenWriteNonLinear, __FOArgs \
  mov _handle, __FOArgs.FileHandle \
  mov _result, __FOArgs.Result \
  release __FOMutex

#define __openFileAppend(_fname, _fsize, _handle, _result) \
  acquire __FOMutex \
  mov __FOArgs.Filename, _fname \
  syscall FileOpenAppend, __FOArgs \
  mov _fsize, __FOArgs.Length \
  mov _handle, __FOArgs.FileHandle \
  mov _result, __FOArgs.Result \
  release __FOMutex

#define __openFileRead(_fname, _fsize, _handle, _result) \
  acquire __FOMutex \
  mov __FOArgs.Filename, _fname \
  syscall FileOpenRead, __FOArgs \
  mov _fsize, __FOArgs.Length \
  mov _handle, __FOArgs.FileHandle \
  mov _result, __FOArgs.Result \
  release __FOMutex

#define __openFileReadLinear(_fname, _fsize, _handle, _result) \
  acquire __FOMutex \
  mov __FOArgs.Filename, _fname \
  syscall FileOpenReadLinear, __FOArgs \
  mov _fsize, __FOArgs.Length \
  mov _handle, __FOArgs.FileHandle \
  mov _result, __FOArgs.Result \
  release __FOMutex

#define __closeFile(_handle, _result) \
  acquire __FCMutex \
  mov __FCArgs.FileHandle, _handle \
  syscall FileClose, __FCArgs \
  mov _result, __FCArgs.Result \
  release __FCMutex

#define __resolveHandle(_fname, _handle, _writable, _result) \
  acquire __FRHMutex \
  mov __FRHArgs.Filename, _fname \
  syscall FileResolveHandle, __FRHArgs \
  mov _handle, __FRHArgs.FileHandle \
  mov _writable, __FRHArgs.WriteHandle \
  mov _result, __FRHArgs.Result \
  release __FRHMutex

#define __renameFile(_oldname, _newname, _result) \
  acquire __FRMutex \
  mov __FRArgs.OldFilename, _oldname \
  mov __FRArgs.NewFilename, _newname \
  syscall FileRename, __FRArgs \
  mov _result, __FRArgs.Result \
  release __FRMutex

#define __deleteFile(_fname, _result) \
  acquire __FDMutex \
  mov __FDArgs.Filename, _fname \
  syscall FileDelete, __FDArgs \
  mov _result, __FDArgs.Result \
  release __FDMutex

#ifdef __ENHANCED_FIRMWARE

#define __findFirstFile(_fname, _handle, _result) \
  acquire __FFMutex \
  mov __FFArgs.Filename, _fname \
  syscall FileFindFirst, __FFArgs \
  mov _result, __FFArgs.Result \
  mov _handle, __FFArgs.FileHandle \
  mov _fname, __FFArgs.Filename \
  release __FFMutex

#define __findNextFile(_fname, _handle, _result) \
  acquire __FFMutex \
  mov __FFArgs.FileHandle, _handle \
  syscall FileFindNext, __FFArgs \
  mov _result, __FFArgs.Result \
  mov _handle, __FFArgs.FileHandle \
  mov _fname, __FFArgs.Filename \
  release __FFMutex

#endif

#define __sizeOF(_n, _result) \
  compif EQ, ((typeof(_n)>=1)&&(typeof(_n)<=6))||(typeof(_n)==10), TRUE \
  set _result, sizeof(_n) \
  compelse \
  acquire __soMutex \
  flatten __soTmpBuf, _n \
  arrsize _result, __soTmpBuf \
  sub _result, _result, 1 \
  release __soMutex \
  compend

#define __readBytes(_handle, _len, _buf, _result) \
  acquire __FReadMutex \
  mov __FReadArgs.FileHandle, _handle \
  mov __FReadArgs.Length, _len \
  syscall FileRead, __FReadArgs \
  mov _result, __FReadArgs.Result \
  strtoarr _buf, __FReadArgs.Buffer \
  mov _len, __FReadArgs.Length \
  release __FReadMutex

#define __readValue(_handle, _n, _result) \
  acquire __FReadMutex \
  mov __FReadArgs.FileHandle, _handle \
  __sizeOF(_n, __FReadArgs.Length) \
  syscall FileRead, __FReadArgs \
  mov _result, __FReadArgs.Result \
  unflatten _n, __FReadTmpByte, __FReadArgs.Buffer, _n \
  release __FReadMutex

#define __readLnValue(_handle, _n, _result) \
  acquire __FReadMutex \
  mov __FReadArgs.FileHandle, _handle \
  __sizeOF(_n, __FReadArgs.Length) \
  syscall FileRead, __FReadArgs \
  unflatten _n, __FReadTmpByte, __FReadArgs.Buffer, _n \
  set __FReadArgs.Length, 2 \
  syscall FileRead, __FReadArgs \
  mov _result, __FReadArgs.Result \
  release __FReadMutex

#define __readLnStringEx(_handle, _output, _max, _result) \
  acquire __FReadMutex \
  mov __FReadArgs.FileHandle, _handle \
  mov __RLSMaxBytes, _max \
  subcall __readStringLine, __RLSReturnAddress \
  mov _result, __RLSReturn \
  mov _output, __RLSOutput \
  release __FReadMutex \

#define __readLnString(_handle, _output, _result) \
  __readLnStringEx(_handle, _output, 0xFFFF, _result)

#define __writeBytes(_handle, _buf, _len, _result) \
  acquire __FWriteMutex \
  mov __FWriteArgs.FileHandle, _handle \
  mov __FWriteArgs.Buffer, _buf \
  arrsize __FWriteArgs.Length, __FWriteArgs.Buffer \
  syscall FileWrite, __FWriteArgs \
  mov _result, __FWriteArgs.Result \
  mov _len, __FWriteArgs.Length \
  release __FWriteMutex

#define __writeString(_handle, _str, _len, _result) \
  acquire __FWriteMutex \
  mov __FWriteArgs.FileHandle, _handle \
  strtoarr __FWriteArgs.Buffer, _str \
  arrsize __FWriteArgs.Length, __FWriteArgs.Buffer \
  syscall FileWrite, __FWriteArgs \
  mov _result, __FWriteArgs.Result \
  mov _len, __FWriteArgs.Length \
  release __FWriteMutex

#define __writeLnString(_handle, _str, _len, _result) \
  acquire __FWriteMutex \
  mov __FWriteArgs.FileHandle, _handle \
  strtoarr __FWriteFlattenBuf, _str \
  arrbuild __FWriteArgs.Buffer, __FWriteFlattenBuf, __FWriteLn \
  arrsize __FWriteArgs.Length, __FWriteArgs.Buffer \
  syscall FileWrite, __FWriteArgs \
  mov _result, __FWriteArgs.Result \
  mov _len, __FWriteArgs.Length \
  release __FWriteMutex

#define __writeBytesEx(_handle, _len, _buf, _result) \
  acquire __FWriteMutex \
  mov __FWriteArgs.FileHandle, _handle \
  mov __FWriteArgs.Length, _len \
  mov __FWriteArgs.Buffer, _buf \
  syscall FileWrite, __FWriteArgs \
  mov _result, __FWriteArgs.Result \
  mov _len, __FWriteArgs.Length \
  release __FWriteMutex

#define __writeValue(_handle, _n, _result) \
  acquire __FWriteMutex \
  mov __FWriteArgs.FileHandle, _handle \
  flatten __FWriteFlattenBuf, _n \
  strtoarr __FWriteArgs.Buffer, __FWriteFlattenBuf \
  arrsize __FWriteArgs.Length, __FWriteArgs.Buffer \
  syscall FileWrite, __FWriteArgs \
  mov _result, __FWriteArgs.Result \
  release __FWriteMutex

#define __writeLnValue(_handle, _n, _result) \
  acquire __FWriteMutex \
  mov __FWriteArgs.FileHandle, _handle \
  flatten __FWriteFlattenBuf, _n \
  strtoarr __FWriteArgs.Buffer, __FWriteFlattenBuf \
  arrbuild __FWriteFlattenBuf, __FWriteArgs.Buffer, __FWriteLn \
  mov __FWriteArgs.Buffer, __FWriteFlattenBuf \
  arrsize __FWriteArgs.Length, __FWriteArgs.Buffer \
  syscall FileWrite, __FWriteArgs \
  mov _result, __FWriteArgs.Result \
  release __FWriteMutex

#define __GetFreeMemory(_value) \
  compchk EQ, sizeof(_value), 4 \
  __getLoaderModuleValue(LoaderOffsetFreeUserFlash, _value)

#endif

/**
 * Get free flash memory.
 * Get the number of bytes of flash memory that are available for use.
 *
 * \param _value The number of bytes of unused flash memory.
 */
#define GetFreeMemory(_value) __GetFreeMemory(_value)

/**
 * Create a file.
 * Create a new file with the specified filename and size and open it for
 * writing. The file handle is returned in the last parameter, which must be a
 * variable. The loader result code is returned as the value of the function
 * call. The filename and size parameters must be constants, constant
 * expressions, or variables. A file created with a size of zero bytes cannot
 * be written to since the NXC file writing functions do not grow the file if
 * its capacity is exceeded during a write attempt.
 *
 * \param _fname The name of the file to create.
 * \param _fsize The size of the file.
 * \param _handle The file handle output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define CreateFile(_fname, _fsize, _handle, _result) __createFile(_fname, _fsize, _handle, _result)

/**
 * Open a file for appending.
 * Open an existing file with the specified filename for writing. The file
 * size is returned in the second parameter, which must be a variable. The
 * file handle is returned in the last parameter, which must be a variable.
 * The loader result code is returned as the value of the function call.
 * The filename parameter must be a constant or a variable.
 *
 * \param _fname The name of the file to open.
 * \param _fsize The size of the file returned by the function.
 * \param _handle The file handle output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define OpenFileAppend(_fname, _fsize, _handle, _result) __openFileAppend(_fname, _fsize, _handle, _result)

/**
 * Open a file for reading.
 * Open an existing file with the specified filename for reading. The file
 * size is returned in the second parameter, which must be a variable. The
 * file handle is returned in the last parameter, which must be a variable.
 * The loader result code is returned as the value of the function call. The
 * filename parameter must be a constant or a variable.
 *
 * \param _fname The name of the file to open.
 * \param _fsize The size of the file returned by the function.
 * \param _handle The file handle output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define OpenFileRead(_fname, _fsize, _handle, _result) __openFileRead(_fname, _fsize, _handle, _result)

/**
 * Close a file.
 * Close the file associated with the specified file handle. The loader
 * result code is returned as the value of the function call. The handle
 * parameter must be a constant or a variable.
 *
 * \param _handle The file handle.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define CloseFile(_handle, _result) __closeFile(_handle, _result)

/**
 * Resolve a handle.
 * Resolve a file handle from the specified filename. The file handle is
 * returned in the second parameter, which must be a variable. A boolean
 * value indicating whether the handle can be used to write to the file or
 * not is returned in the last parameter, which must be a variable. The
 * loader result code is returned as the value of the function call. The
 * filename parameter must be a constant or a variable.
 *
 * \param _fname The name of the file for which to resolve a handle.
 * \param _handle The file handle output from the function call.
 * \param _writable A boolean flag indicating whether the handle is
 * to a file open for writing (true) or reading (false).
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define ResolveHandle(_fname, _handle, _writable, _result) \
  __resolveHandle(_fname, _handle, _writable, _result)

/**
 * Rename a file.
 * Rename a file from the old filename to the new filename. The loader
 * param _result code is returned as the value of the function call. The filename
 * parameters must be constants or variables.
 *
 * \param _oldname The old filename.
 * \param _newname The new filename.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define RenameFile(_oldname, _newname, _result) __renameFile(_oldname, _newname, _result)

/**
 * Delete a file.
 * Delete the specified file. The loader result code is returned as the
 * value of the function call. The filename parameter must be a constant or a
 * variable.
 *
 * \param _fname The name of the file to delete.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define DeleteFile(_fname, _result) __deleteFile(_fname, _result)

/**
 * Resize a file.
 * Resize the specified file. The loader result code is returned as the
 * value of the function call. The filename parameter must be a constant or a
 * variable.
 *
 * \param _fname The name of the file to resize.
 * \param _newsize The new size for the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define ResizeFile(_fname, _newsize, _result) __fileResize(_fname, _newsize, _result)

#ifdef __ENHANCED_FIRMWARE

/**
 * Create a linear file.
 * Create a new linear file with the specified filename and size and open it for
 * writing. The file handle is returned in the last parameter, which must be a
 * variable. The loader result code is returned as the value of the function
 * call. The filename and size parameters must be constants, constant
 * expressions, or variables. A file created with a size of zero bytes cannot
 * be written to since the NXC file writing functions do not grow the file if
 * its capacity is exceeded during a write attempt.
 *
 * \param _fname The name of the file to create.
 * \param _fsize The size of the file.
 * \param _handle The file handle output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define CreateFileLinear(_fname, _fsize, _handle, _result) \
  __createFileLinear(_fname, _fsize, _handle, _result)

/**
 * Create a non-linear file.
 * Create a new non-linear file with the specified filename and size and open it for
 * writing. The file handle is returned in the last parameter, which must be a
 * variable. The loader result code is returned as the value of the function
 * call. The filename and size parameters must be constants, constant
 * expressions, or variables. A file created with a size of zero bytes cannot
 * be written to since the NXC file writing functions do not grow the file if
 * its capacity is exceeded during a write attempt.
 *
 * \param _fname The name of the file to create.
 * \param _fsize The size of the file.
 * \param _handle The file handle output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define CreateFileNonLinear(_fname, _fsize, _handle, _result) \
  __createFileNonLinear(_fname, _fsize, _handle, _result)

/**
 * Open a linear file for reading.
 * Open an existing linear file with the specified filename for reading. The file
 * size is returned in the second parameter, which must be a variable. The
 * file handle is returned in the last parameter, which must be a variable.
 * The loader result code is returned as the value of the function call. The
 * filename parameter must be a constant or a variable.
 *
 * \param _fname The name of the file to open.
 * \param _fsize The size of the file returned by the function.
 * \param _handle The file handle output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define OpenFileReadLinear(_fname, _fsize, _handle, _result) \
  __openFileReadLinear(_fname, _fsize, _handle, _result)

/**
 * Start searching for files.
 * This function lets you begin iterating through files stored on the NXT.
 *
 * \param _fname On input this contains the filename pattern you are searching
 * for. On output this contains the name of the first file found that matches
 * the pattern.
 * \param _handle The search handle input to and output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define FindFirstFile(_fname, _handle, _result) __findFirstFile(_fname, _handle, _result)

/**
 * Continue searching for files.
 * This function lets you continue iterating through files stored on the NXT.
 *
 * \param _fname On output this contains the name of the next file found that
 * matches the pattern used when the search began by calling \ref FindFirstFile.
 * \param _handle The search handle input to and output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define FindNextFile(_fname, _handle, _result) __findNextFile(_fname, _handle, _result)
#endif

/**
 * Calculate the size of a variable.
 * Calculate the number of bytes required to store the contents of the
 * variable passed into the function.
 *
 * \param _n The variable.
 * \param _result The number of bytes occupied by the variable.
 */
#define SizeOf(_n, _result) __sizeOF(_n, _result)

/**
 * Read a value from a file.
 * Read a value from the file associated with the specified handle.
 * The handle parameter must be a variable. The value parameter must be a
 * variable. The type of the value parameter determines the number of bytes of
 * data read.
 *
 * \param _handle The file handle.
 * \param _n The variable to store the data read from the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define Read(_handle, _n, _result) __readValue(_handle, _n, _result)

/**
 * Read a value from a file plus line ending.
 * Read a value from the file associated with the specified handle.
 * The handle parameter must be a variable. The value parameter must be a
 * variable. The type of the value parameter determines the number of bytes
 * of data read. The ReadLn function reads two additional bytes from the
 * file which it assumes are a carriage return and line feed pair.
 *
 * \param _handle The file handle.
 * \param _n The variable to store the data read from the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define ReadLn(_handle, _n, _result) __readLnValue(_handle, _n, _result)

/**
 * Read bytes from a file.
 * Read the specified number of bytes from the file associated with the
 * specified handle. The handle parameter must be a variable. The length
 * parameter must be a variable. The buf parameter must be an array or a
 * string variable. The actual number of bytes read is returned in the
 * length parameter.
 *
 * \param _handle The file handle.
 * \param _len The number of bytes to read. Returns the number of bytes actually read.
 * \param _buf The byte array where the data is stored on output.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define ReadBytes(_handle, _len, _buf, _result) __readBytes(_handle, _len, _buf, _result)

/**
 * Read a string from a file plus line ending.
 * Read a string from the file associated with the specified handle.
 * The handle parameter must be a variable. The output parameter must be a
 * variable. Appends bytes to the output variable until a line ending (CRLF)
 * is reached. The line ending is also read but it is not appended to the
 * output parameter.
 *
 * \param _handle The file handle.
 * \param _output The variable to store the string read from the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define ReadLnString(_handle, _output, _result) __readLnString(_handle, _output, _result)

/**
 * Write value to file.
 * Write a value to the file associated with the specified handle.
 * The handle parameter must be a variable. The value parameter must be a
 * constant, a constant expression, or a variable. The type of the value
 * parameter determines the number of bytes of data written.
 *
 * \param _handle The file handle.
 * \param _n The value to write to the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define Write(_handle, _n, _result) __writeValue(_handle, _n, _result)

/**
 * Write a value and new line to a file.
 * Write a value to the file associated with the specified handle. The
 * handle parameter must be a variable. The value parameter must be a constant,
 * a constant expression, or a variable. The type of the value parameter
 * determines the number of bytes of data written. This function also
 * writes a carriage return and a line feed to the file following the numeric
 * data.
 *
 * \param _handle The file handle.
 * \param _n The value to write to the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define WriteLn(_handle, _n, _result) __writeLnValue(_handle, _n, _result)

/**
 * Write string to a file.
 * Write the string to the file associated with the specified handle. The
 * handle parameter must be a variable. The count parameter must be a variable.
 * The str parameter must be a string variable or string constant. The actual
 * number of bytes written is returned in the cnt parameter.
 *
 * \param _handle The file handle.
 * \param _str The string to write to the file.
 * \param _cnt The number of bytes actually written to the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define WriteString(_handle, _str, _cnt, _result) __writeString(_handle, _str, _cnt, _result)

/**
 * Write string and new line to a file.
 * Write the string to the file associated with the specified handle. The
 * handle parameter must be a variable. The count parameter must be a variable.
 * The str parameter must be a string variable or string constant. This
 * function also writes a carriage return and a line feed to the file following
 * the string data. The total number of bytes written is returned in the
 * cnt parameter.
 *
 * \param _handle The file handle.
 * \param _str The string to write to the file.
 * \param _cnt The number of bytes actually written to the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define WriteLnString(_handle, _str, _cnt, _result) __writeLnString(_handle, _str, _cnt, _result)

/**
 * Write bytes to file.
 * Write the contents of the data array to the file associated with the
 * specified handle. The handle parameter must be a variable. The cnt
 * parameter must be a variable. The data parameter must be a byte array. The
 * actual number of bytes written is returned in the cnt parameter.
 *
 * \param _handle The file handle.
 * \param _buf The byte array or string containing the data to write.
 * \param _cnt The number of bytes actually written to the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define WriteBytes(_handle, _buf, _cnt, _result) __writeBytes(_handle, _buf, _cnt, _result)

/**
 * Write bytes to a file with limit.
 * Write the specified number of bytes to the file associated with the
 * specified handle. The handle parameter must be a variable. The len
 * parameter must be a variable. The buf parameter must be a byte array or a
 * string variable or string constant. The actual number of bytes written is
 * returned in the len parameter.
 *
 * \param _handle The file handle.
 * \param _len The maximum number of bytes to write on input.  Returns the
 * actual number of bytes written.
 * \param _buf The byte array or string containing the data to write.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define WriteBytesEx(_handle, _len, _buf, _result) __writeBytesEx(_handle, _len, _buf, _result)

/** @} */ // end of LoaderModuleFunctions group
/** @} */ // end of LoaderModule group
/** @} */ // end of NXTFirmwareModules group

#endif // NBC_LOADER_H