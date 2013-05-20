/** \file loader.h
 * \brief The NXC loader module API
 *
 * loader.h contains the NXC loader module API
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
 * \date 2013-03-03
 * \version 3
 */

#ifndef LOADER_H
#define LOADER_H

#include "loader_constants.h"

#ifndef __DOXYGEN_DOCS
asm { asminclude "nbc_loader.h" }
#endif

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// LOADER MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup LoaderModule
 * @{
 */
/** @defgroup LoaderModuleTypes Loader module types
 * Types used by various Loader module functions.
 * @{
 */
/**
 * Parameters for the FileOpen system call.
 * This structure is used when calling the \ref SysFileOpenAppend, \ref
 * SysFileOpenRead, \ref SysFileOpenWrite, \ref SysFileOpenReadLinear,
 * \ref SysFileOpenWriteLinear and \ref SysFileOpenWriteNonLinear system call
 * functions.
 * \sa SysFileOpenAppend(), SysFileOpenRead(), SysFileOpenWrite(),
 * SysFileOpenReadLinear(), SysFileOpenWriteLinear()
 */
struct FileOpenType {
  unsigned int Result;    /*!< The function call result. Possible values
                            include \ref LoaderErrors. */
  byte FileHandle;        /*!< The returned file handle to use for subsequent
                            file operations. */
  string Filename;        /*!< The name of the file to open or create. */
  unsigned long Length;   /*!< For SysFileOpenWrite(),
                            SysFileOpenWriteLinear() and
                            SysFileOpenWriteNonLinear(): the desired maximum
                            file capacity.

                            For SysFileOpenAppend(), SysFileOpenRead() and
                            SysFileOpenReadLinear(): the returned available
                            length in the file. */
};

/**
 * Parameters for the FileReadWrite system call.
 * This structure is used when calling the \ref SysFileRead and \ref SysFileWrite
 * system call functions.
 * \sa SysFileRead() and SysFileWrite()
 */
struct FileReadWriteType {
  unsigned int Result;    /*!< The function call result. Possible values
                            include \ref LoaderErrors. */
  byte FileHandle;        /*!< The file handle to access. */
  string Buffer;          /*!< The buffer to store read bytes or containing
                            bytes to write. */
  unsigned long Length;   /*!< The number of bytes to read or the returned
                            number of bytes written. */
};

/**
 * Parameters for the FileClose system call.
 * This structure is used when calling the \ref SysFileClose system call function.
 * \sa SysFileClose()
 */
struct FileCloseType {
  unsigned int Result;   /*!< The function call result. Possible values
                           include \ref LoaderErrors. */
  byte FileHandle;       /*!< The file handle to close. */
};

/**
 * Parameters for the FileResolveHandle system call.
 * This structure is used when calling the \ref SysFileResolveHandle system
 * call function.
 * \sa SysFileResolveHandle()
 */
struct FileResolveHandleType {
  unsigned int Result;   /*!< The function call result. Possible values
                           include \ref LDR_HANDLEALREADYCLOSED and \ref LDR_SUCCESS. */
  byte FileHandle;       /*!< The returned resolved file handle. */
  bool WriteHandle;      /*!< True if the returned handle is a write handle. */
  string Filename;       /*!< The name of the file for which to resolve a handle. */
};

/**
 * Parameters for the FileRename system call.
 * This structure is used when calling the \ref SysFileRename system call
 * function.
 * \sa SysFileRename()
 */
struct FileRenameType {
  unsigned int Result;   /*!< The function call result. Possible values
                           include \ref LoaderErrors. */
  string OldFilename;    /*!< The name of the file to be renamed. */
  string NewFilename;    /*!< The new name to give to the file. */
};

/**
 * Parameters for the FileDelete system call.
 * This structure is used when calling the \ref SysFileDelete system call
 * function.
 * \sa SysFileDelete()
 */
struct FileDeleteType {
  unsigned int Result;   /*!< The function call result. Possible values
                           include \ref LoaderErrors. */
  string Filename;       /*!< The name of the file to delete. */
};

#ifdef __ENHANCED_FIRMWARE
/**
 * Parameters for the LoaderExecuteFunction system call.
 * This structure is used when calling the \ref SysLoaderExecuteFunction
 * system call function.
 *
 * The fields usage depends on the requested command and are documented in the
 * table below.
 *
 * <table>
 * <tr><td>Cmd</td>
 *     <td>Meaning</td><td>Expected Parameters</td></tr>
 * <tr><td>LDR_CMD_OPENREAD</td>
 *     <td>Open a file for reading</td><td>(Filename, Length)</td></tr>
 * <tr><td>LDR_CMD_OPENWRITE</td>
 *     <td>Create a file</td><td>(Filename, Length)</td></tr>
 * <tr><td>LDR_CMD_READ</td>
 *     <td>Read from a file</td><td>(Filename, Buffer, Length)</td></tr>
 * <tr><td>LDR_CMD_WRITE</td>
 *     <td>Write to a file</td><td>(Filename, Buffer, Length)</td></tr>
 * <tr><td>LDR_CMD_CLOSE</td>
 *     <td>Close a file</td><td>(Filename)</td></tr>
 * <tr><td>LDR_CMD_DELETE</td>
 *     <td>Delete a file</td><td>(Filename)</td></tr>
 * <tr><td>LDR_CMD_FINDFIRST</td>
 *     <td>Start iterating files</td><td>(Filename, Buffer, Length)</td></tr>
 * <tr><td>LDR_CMD_FINDNEXT</td>
 *     <td>Continue iterating files</td><td>(Filename, Buffer, Length)</td></tr>
 * <tr><td>LDR_CMD_OPENWRITELINEAR</td>
 *     <td>Create a linear file</td><td>(Filename, Length)</td></tr>
 * <tr><td>LDR_CMD_OPENREADLINEAR</td>
 *     <td>Read a linear file</td><td>(Filename, Buffer, Length)</td></tr>
 * <tr><td>LDR_CMD_OPENAPPENDDATA</td>
 *     <td>Open a file for writing</td><td>(Filename, Length)</td></tr>
 * <tr><td>LDR_CMD_FINDFIRSTMODULE</td>
 *     <td>Start iterating modules</td><td>(Filename, Buffer)</td></tr>
 * <tr><td>LDR_CMD_FINDNEXTMODULE</td>
 *     <td>Continue iterating modules</td><td>(Buffer)</td></tr>
 * <tr><td>LDR_CMD_CLOSEMODHANDLE</td>
 *     <td>Close module handle</td><td>()</td></tr>
 * <tr><td>LDR_CMD_IOMAPREAD</td>
 *     <td>Read IOMap data</td><td>(Filename, Buffer, Length)</td></tr>
 * <tr><td>LDR_CMD_IOMAPWRITE</td>
 *     <td>Write IOMap data</td><td>(Filename, Buffer, Length)</td></tr>
 * <tr><td>LDR_CMD_DELETEUSERFLASH</td>
 *     <td>Delete all files</td><td>()</td></tr>
 * <tr><td>LDR_CMD_RENAMEFILE</td>
 *     <td>Rename file</td><td>(Filename, Buffer, Length)</td></tr>
 * </table>
 *
 * \sa SysLoaderExecuteFunction()
 */
struct LoaderExecuteFunctionType {
  unsigned int Result;    /*!< The function call result. Possible values
                            include \ref LoaderErrors. */
  byte Cmd;               /*!< The command to execute. */
  string Filename;        /*!< The Filename parameter, see table. */
  byte Buffer[];          /*!< The Buffer parameter, see table. */
  unsigned long Length;   /*!< The Length parameter, see table. */
};

/**
 * Parameters for the FileFind system call.
 * This structure is used when calling the \ref SysFileFindFirst and \ref
 * SysFileFindNext system call functions.
 * \sa SysFileFindFirst() and SysFileFindNext()
 */
struct FileFindType {
  unsigned int Result;    /*!< The function call result. Possible values
                            include \ref LoaderErrors. */
  byte FileHandle;        /*!< The returned file handle to be used to continue
                            iterations. Close it after usage. */
  string Filename;        /*!< The pattern to match file name, then the
                            returned found file name. */
  unsigned long Length;   /*!< The found file length. */
};

#if __FIRMWARE_VERSION > 107
/**
 * Parameters for the FileSeek system call.
 * This structure is used when calling the \ref SysFileSeek system call function.
 * \sa SysFileSeek()
 */
struct FileSeekType {
 unsigned int Result; /*!< The function call result. Possible values include
                        \ref LoaderErrors. */
 byte FileHandle;     /*!< The handle of the file to seek in. */
 byte Origin;         /*!< The origin of the file seek operation. See \ref fseekConstants. */
 long Length;         /*!< The offset from the origin to seek to. */
};

/**
 * Parameters for the FileResize system call.
 * This structure is used when calling the \ref SysFileResize system call function.
 * \sa SysFileResize()
 */
struct FileResizeType {
 unsigned int Result;   /*!< The function call result. Possible values include
                         \ref LoaderErrors. */
 byte FileHandle;       /*!< The handle of the file to resize. */
 unsigned int NewSize;  /*!< The new file size. */
};

/**
 * Parameters for the FileTell system call.
 * This structure is used when calling the \ref SysFileTell system call function.
 * \sa SysFileTell()
 */
struct FileTellType {
 unsigned int Result;     /*!< The function call result. Possible values include
                           \ref LoaderErrors. */
 byte FileHandle;         /*!< The handle of the open file. */
 unsigned long Position;  /*!< The current file position in the open file. */
};

#endif
#endif
#if __FIRMWARE_VERSION > 107
/**
 * Parameters for the ListFiles system call.
 * This structure is used when calling the \ref SysListFiles system call function.
 * \sa SysListFiles()
 */
struct ListFilesType {
 char Result;       /*!< The function call result. Possible values include
                         \ref LoaderErrors. */
 string Pattern;    /*!< The file search pattern. */
 string FileList[]; /*!< An array of strings containing the list of filenames
                         that matched the file search pattern. */
};
#endif
/** @} */ // end of LoaderModuleTypes group
/** @defgroup LoaderModuleFunctions Loader module functions
 * Functions for accessing and modifying Loader module features.
 * @{
 */
#ifdef __DOXYGEN_DOCS

/**
 * Get free flash memory.
 * Get the number of bytes of flash memory that are available for use.
 * \return The number of bytes of unused flash memory.
 */
inline unsigned int FreeMemory(void);

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
 * \param fname The name of the file to create.
 * \param fsize The size of the file.
 * \param handle The file handle output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int CreateFile(string fname, unsigned int fsize, byte & handle);

/**
 * Open a file for appending.
 * Open an existing file with the specified filename for writing. The file
 * size is returned in the second parameter, which must be a variable. The
 * file handle is returned in the last parameter, which must be a variable.
 * The loader result code is returned as the value of the function call.
 * The filename parameter must be a constant or a variable.
 *
 * \param fname The name of the file to open.
 * \param fsize The size of the file returned by the function.
 * \param handle The file handle output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int OpenFileAppend(string fname, unsigned int & fsize, byte & handle);

/**
 * Open a file for reading.
 * Open an existing file with the specified filename for reading. The file
 * size is returned in the second parameter, which must be a variable. The
 * file handle is returned in the last parameter, which must be a variable.
 * The loader result code is returned as the value of the function call. The
 * filename parameter must be a constant or a variable.
 *
 * \param fname The name of the file to open.
 * \param fsize The size of the file returned by the function.
 * \param handle The file handle output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int OpenFileRead(string fname, unsigned int & fsize, byte & handle);

/**
 * Close a file.
 * Close the file associated with the specified file handle. The loader
 * result code is returned as the value of the function call. The handle
 * parameter must be a constant or a variable.
 *
 * \param handle The file handle.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int CloseFile(byte handle);

/**
 * Resolve a handle.
 * Resolve a file handle from the specified filename. The file handle is
 * returned in the second parameter, which must be a variable. A boolean
 * value indicating whether the handle can be used to write to the file or
 * not is returned in the last parameter, which must be a variable. The
 * loader result code is returned as the value of the function call. The
 * filename parameter must be a constant or a variable.
 *
 * \param filename The name of the file for which to resolve a handle.
 * \param handle The file handle output from the function call.
 * \param writable A boolean flag indicating whether the handle is
 * to a file open for writing (true) or reading (false).
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int ResolveHandle(string filename, byte & handle, bool & writable);

/**
 * Rename a file.
 * Rename a file from the old filename to the new filename. The loader
 * result code is returned as the value of the function call. The filename
 * parameters must be constants or variables.
 *
 * \param oldname The old filename.
 * \param newname The new filename.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int RenameFile(string oldname, string newname);

/**
 * Delete a file.
 * Delete the specified file. The loader result code is returned as the
 * value of the function call. The filename parameter must be a constant or a
 * variable.
 *
 * \param fname The name of the file to delete.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int DeleteFile(string fname);

/**
 * Resize a file.
 * Resize the specified file. The loader result code is returned as the
 * value of the function call. The filename parameter must be a constant or a
 * variable.
 *
 * \param fname The name of the file to resize.
 * \param newsize The new size for the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int ResizeFile(string fname, const unsigned int newsize);

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
 * \param fname The name of the file to create.
 * \param fsize The size of the file.
 * \param handle The file handle output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline unsigned int CreateFileLinear(string fname, unsigned int fsize, byte & handle);

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
 * \param fname The name of the file to create.
 * \param fsize The size of the file.
 * \param handle The file handle output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline unsigned int CreateFileNonLinear(string fname, unsigned int fsize, byte & handle);

/**
 * Open a linear file for reading.
 * Open an existing linear file with the specified filename for reading. The file
 * size is returned in the second parameter, which must be a variable. The
 * file handle is returned in the last parameter, which must be a variable.
 * The loader result code is returned as the value of the function call. The
 * filename parameter must be a constant or a variable.
 *
 * \param fname The name of the file to open.
 * \param fsize The size of the file returned by the function.
 * \param handle The file handle output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline unsigned int OpenFileReadLinear(string fname, unsigned int & fsize, byte & handle);

/**
 * Start searching for files.
 * This function lets you begin iterating through files stored on the NXT.
 *
 * \param fname On input this contains the filename pattern you are searching
 * for. On output this contains the name of the first file found that matches
 * the pattern.
 * \param handle The search handle input to and output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline unsigned int FindFirstFile(string & fname, byte & handle);

/**
 * Continue searching for files.
 * This function lets you continue iterating through files stored on the NXT.
 *
 * \param fname On output this contains the name of the next file found that
 * matches the pattern used when the search began by calling \ref FindFirstFile.
 * \param handle The search handle input to and output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline unsigned int FindNextFile(string & fname, byte & handle);

#endif

/**
 * Calculate the size of a variable.
 * Calculate the number of bytes required to store the contents of the
 * variable passed into the function.
 *
 * \param value The variable.
 * \return The number of bytes occupied by the variable.
 */
inline unsigned int SizeOf(variant & value);

/**
 * Return the type of a variable.
 * Return the type of the variable passed into the function.
 * See \ref VariableTypeConstants for a list of possible return values.
 *
 * \param value The variable.
 * \return The variable type.
 */
inline unsigned int TypeOf(variant & value);

/**
 * Read a value from a file.
 * Read a value from the file associated with the specified handle.
 * The handle parameter must be a variable. The value parameter must be a
 * variable. The type of the value parameter determines the number of bytes of
 * data read.
 *
 * \param handle The file handle. 
 * \param value The variable to store the data read from the file.
 * \return The function call result. See \ref LoaderErrors. 
 */
inline unsigned int Read(byte handle, variant & value);

/**
 * Read a value from a file plus line ending.
 * Read a value from the file associated with the specified handle.
 * The handle parameter must be a variable. The value parameter must be a
 * variable. The type of the value parameter determines the number of bytes
 * of data read. The ReadLn function reads two additional bytes from the
 * file which it assumes are a carriage return and line feed pair.
 *
 * \param handle The file handle.
 * \param value The variable to store the data read from the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int ReadLn(byte handle, variant & value);

/**
 * Read bytes from a file.
 * Read the specified number of bytes from the file associated with the
 * specified handle. The handle parameter must be a variable. The length
 * parameter must be a variable. The buf parameter must be an array or a
 * string variable. The actual number of bytes read is returned in the
 * length parameter.
 *
 * \param handle The file handle.
 * \param length The number of bytes to read. Returns the number of bytes actually read.
 * \param buf The byte array where the data is stored on output.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int ReadBytes(byte handle, unsigned int & length, byte & buf[]);

/**
 * Read a string from a file plus line ending.
 * Read a string from the file associated with the specified handle.
 * The handle parameter must be a variable. The output parameter must be a
 * variable. Appends bytes to the output variable until a line ending (CRLF)
 * is reached. The line ending is also read but it is not appended to the
 * output parameter.
 *
 * \param handle The file handle.
 * \param output The variable to store the string read from the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int ReadLnString(byte handle, string & output);

/**
 * Write value to file.
 * Write a value to the file associated with the specified handle.
 * The handle parameter must be a variable. The value parameter must be a
 * constant, a constant expression, or a variable. The type of the value
 * parameter determines the number of bytes of data written.
 *
 * \param handle The file handle.
 * \param value The value to write to the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int Write(byte handle, const variant & value);

/**
 * Write bytes to file.
 * Write the contents of the data array to the file associated with the
 * specified handle. The handle parameter must be a variable. The cnt
 * parameter must be a variable. The data parameter must be a byte array. The
 * actual number of bytes written is returned in the cnt parameter.
 *
 * \param handle The file handle.
 * \param buf The byte array or string containing the data to write.
 * \param cnt The number of bytes actually written to the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int WriteBytes(byte handle, const byte & buf[], unsigned int & cnt);

/**
 * Write bytes to a file with limit.
 * Write the specified number of bytes to the file associated with the
 * specified handle. The handle parameter must be a variable. The len
 * parameter must be a variable. The buf parameter must be a byte array or a
 * string variable or string constant. The actual number of bytes written is
 * returned in the len parameter.
 *
 * \param handle The file handle.
 * \param len The maximum number of bytes to write on input.  Returns the
 * actual number of bytes written.
 * \param buf The byte array or string containing the data to write.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int WriteBytesEx(byte handle, unsigned int & len, const byte & buf[]);

/**
 * Write a value and new line to a file.
 * Write a value to the file associated with the specified handle. The
 * handle parameter must be a variable. The value parameter must be a constant,
 * a constant expression, or a variable. The type of the value parameter
 * determines the number of bytes of data written. This function also
 * writes a carriage return and a line feed to the file following the numeric
 * data.
 *
 * \param handle The file handle.
 * \param value The value to write to the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int WriteLn(byte handle, const variant & value);

/**
 * Write string and new line to a file.
 * Write the string to the file associated with the specified handle. The
 * handle parameter must be a variable. The count parameter must be a variable.
 * The str parameter must be a string variable or string constant. This
 * function also writes a carriage return and a line feed to the file following
 * the string data. The total number of bytes written is returned in the
 * cnt parameter.
 *
 * \param handle The file handle.
 * \param str The string to write to the file.
 * \param cnt The number of bytes actually written to the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int WriteLnString(byte handle, const string & str, unsigned int & cnt);

/**
 * Write string to a file.
 * Write the string to the file associated with the specified handle. The
 * handle parameter must be a variable. The count parameter must be a variable.
 * The str parameter must be a string variable or string constant. The actual
 * number of bytes written is returned in the cnt parameter.
 *
 * \param handle The file handle.
 * \param str The string to write to the file.
 * \param cnt The number of bytes actually written to the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int WriteString(byte handle, const string & str, unsigned int & cnt);

/**
 * Open file for reading.
 * This function lets you open an existing file for reading using the values
 * specified via the \ref FileOpenType structure.
 *
 * The number of bytes that can be read from the file is returned via the
 * Length member.
 *
 * \param args The FileOpenType structure containing the needed parameters.
 */
inline void SysFileOpenRead(FileOpenType & args);

/**
 * Open and create file for writing.
 * This function lets you create a file that you can write to using the values
 * specified via the \ref FileOpenType structure.
 *
 * The desired maximum file capacity in bytes is specified via the Length
 * member.
 *
 * \param args The FileOpenType structure containing the needed parameters.
 */
inline void SysFileOpenWrite(FileOpenType & args);

/**
 * Open file for writing at end of file.
 * This function lets you open an existing file that you can write to using
 * the values specified via the \ref FileOpenType structure.
 *
 * The available length remaining in the file is returned via the Length
 * member.
 *
 * \param args The FileOpenType structure containing the needed parameters.
 */
inline void SysFileOpenAppend(FileOpenType & args);

/**
 * Read from file.
 * This function lets you read from a file using the values specified via the
 * \ref FileReadWriteType structure.
 *
 * \param args The FileReadWriteType structure containing the needed
 * parameters.
 */
inline void SysFileRead(FileReadWriteType & args);

/**
 * File write.
 * This function lets you write to a file using the values specified via the
 * \ref FileReadWriteType structure.
 *
 * \param args The FileReadWriteType structure containing the needed
 * parameters.
 */
inline void SysFileWrite(FileReadWriteType & args);

/**
 * Close file handle.
 * This function lets you close a file using the values specified via the \ref
 * FileCloseType structure.
 *
 * \param args The FileCloseType structure containing the needed parameters.
 */
inline void SysFileClose(FileCloseType & args);

/**
 * File resolve handle.
 * This function lets you resolve the handle of a file using the values
 * specified via the \ref FileResolveHandleType structure.  This will find a
 * previously opened file handle.
 *
 * \param args The FileResolveHandleType structure containing the needed
 * parameters.
 */
inline void SysFileResolveHandle(FileResolveHandleType & args);

/**
 * Rename file.
 * This function lets you rename a file using the values specified via the
 * \ref FileRenameType structure.
 *
 * \param args The FileRenameType structure containing the needed parameters.
 */
inline void SysFileRename(FileRenameType & args);

/**
 * Delete file.
 * This function lets you delete a file using the values specified via the
 * \ref FileDeleteType structure.
 *
 * \param args The FileDeleteType structure containing the needed parameters.
 */
inline void SysFileDelete(FileDeleteType & args);

#ifdef __ENHANCED_FIRMWARE
/**
 * Execute any Loader module command.
 * This function lets you directly execute the Loader module's primary
 * function using the values specified via the \ref LoaderExecuteFunctionType
 * structure.
 *
 * \param args The LoaderExecuteFunctionType structure containing the needed
 * parameters.
 *
 * \warning This function requires the extended firmware.
 */
inline void SysLoaderExecuteFunction(LoaderExecuteFunctionType & args);

/**
 * Start finding files.
 * This function lets you begin iterating through files stored on the NXT.
 *
 * \param args The FileFindType structure containing the needed parameters.
 *
 * \warning This function requires the extended firmware.
 */
inline void SysFileFindFirst(FileFindType & args);

/**
 * Continue finding files.
 * This function lets you continue iterating through files stored on the NXT.
 *
 * \param args The FileFindType structure containing the needed parameters.
 *
 * \warning This function requires the extended firmware.
 */
inline void SysFileFindNext(FileFindType & args);

/**
 * Open and create linear file for writing.
 * This function lets you create a linear file that you can write to using the
 * values specified via the \ref FileOpenType structure.
 *
 * \param args The FileOpenType structure containing the needed parameters.
 *
 * \warning This function requires the extended firmware.
 */
inline void SysFileOpenWriteLinear(FileOpenType & args);

/**
 * Open and create non-linear file for writing.
 * This function lets you create a non-linear linear file that you can write
 * to using the values specified via the \ref FileOpenType structure.
 *
 * \param args The FileOpenType structure containing the needed parameters.
 *
 * \warning This function requires the extended firmware.
 */
inline void SysFileOpenWriteNonLinear(FileOpenType & args);

/**
 * Open linear file for reading.
 * This function lets you open an existing linear file for reading using the
 * values specified via the \ref FileOpenType structure.
 *
 * \param args The FileOpenType structure containing the needed parameters.
 *
 * \warning This function requires the extended firmware.
 */
inline void SysFileOpenReadLinear(FileOpenType & args);

#if __FIRMWARE_VERSION > 107
/**
 * Seek to file position.
 * This function lets you seek to a specific file position using the
 * values specified via the \ref FileSeekType structure.
 *
 * \param args The FileSeekType structure containing the needed parameters.
 *
 * \warning This function requires the extended firmware.
 */
inline void SysFileSeek(FileSeekType & args);

/**
 * Resize a file.
 * This function lets you resize a file using the
 * values specified via the \ref FileResizeType structure.
 *
 * \param args The FileResizeType structure containing the needed parameters.
 *
 * \warning This function requires the extended firmware.
 * It has not yet been implemented at the firmware level.
 */
inline void SysFileResize(FileResizeType & args);

/**
 * Return the file position.
 * This function returns the current file position in the open file
 * specified via the \ref FileTellType structure.
 *
 * \param args The FileTellType structure containing the needed parameters.
 *
 * \warning This function requires the extended firmware.
 */
inline void SysFileTell(FileTellType & args);

#endif
#endif
#if __FIRMWARE_VERSION > 107
/**
 * List files.
 * This function lets you retrieve a list of files on the NXT using the
 * values specified via the \ref ListFilesType structure.
 *
 * \param args The ListFilesType structure containing the needed parameters.
 */
inline void SysListFiles(ListFilesType & args);

#endif

#else

#define FreeMemory() asm { GetFreeMemory(__RETVAL__) }

#define CreateFile(_fname, _fsize, _handle) asm { __createFile(_fname, _fsize, _handle, __RETVAL__) }
#define OpenFileAppend(_fname, _fsize, _handle) asm { __openFileAppend(_fname, _fsize, _handle, __RETVAL__) }
#define OpenFileRead(_fname, _fsize, _handle) asm { __openFileRead(_fname, _fsize, _handle, __RETVAL__) }
#define CloseFile(_handle) asm { __closeFile(_handle, __RETVAL__) }
#define ResolveHandle(_fname, _handle, _writable) asm { __resolveHandle(_fname, _handle, _writable, __RETVAL__) }
#define RenameFile(_oldname, _newname) asm { __renameFile(_oldname, _newname, __RETVAL__) }
#define DeleteFile(_fname) asm { __deleteFile(_fname, __RETVAL__) }
#define ResizeFile(_fname, _newsize) asm { __fileResize(_fname, _newsize, __RETVAL__) }

#ifdef __ENHANCED_FIRMWARE
#define CreateFileLinear(_fname, _fsize, _handle) asm { __createFileLinear(_fname, _fsize, _handle, __RETVAL__) }
#define CreateFileNonLinear(_fname, _fsize, _handle) asm { __createFileNonLinear(_fname, _fsize, _handle, __RETVAL__) }
#define OpenFileReadLinear(_fname, _fsize, _handle) asm { __openFileReadLinear(_fname, _fsize, _handle, __RETVAL__) }
#define FindFirstFile(_fname, _handle) asm { __findFirstFile(_fname, _handle, __RETVAL__) }
#define FindNextFile(_fname, _handle) asm { __findNextFile(_fname, _handle, __RETVAL__) }
#endif

#define SizeOf(_n) asm { __sizeOF(_n, __RETVAL__) }
#define TypeOf(_n) asm { set __RETVAL__, typeof(_n) }
#define Read(_handle, _n) asm { __readValue(_handle, _n, __RETVAL__) }
#define ReadLn(_handle, _n) asm { __readLnValue(_handle, _n, __RETVAL__) }
#define ReadBytes(_handle, _len, _buf) asm { __readBytes(_handle, _len, _buf, __RETVAL__) }
#define ReadLnString(_handle, _output) asm { __readLnString(_handle, _output, __RETVAL__) }

#define Write(_handle, _n) asm { __writeValue(_handle, _n, __RETVAL__) }
#define WriteLn(_handle, _n) asm { __writeLnValue(_handle, _n, __RETVAL__) }
#define WriteString(_handle, _str, _cnt) asm { __writeString(_handle, _str, _cnt, __RETVAL__) }
#define WriteLnString(_handle, _str, _cnt) asm { __writeLnString(_handle, _str, _cnt, __RETVAL__) }
#define WriteBytes(_handle, _buf, _cnt) asm { __writeBytes(_handle, _buf, _cnt, __RETVAL__) }
#define WriteBytesEx(_handle, _len, _buf) asm { __writeBytesEx(_handle, _len, _buf, __RETVAL__) }

#define SysFileOpenRead(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenRead, _args \
}
#define SysFileOpenWrite(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenWrite, _args \
}
#define SysFileOpenAppend(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenAppend, _args \
}
#define SysFileRead(_args) asm { \
  compchktype _args, FileReadWriteType \
  syscall FileRead, _args \
}
#define SysFileWrite(_args) asm { \
  compchktype _args, FileReadWriteType \
  syscall FileWrite, _args \
}
#define SysFileClose(_args) asm { \
  compchktype _args, FileCloseType \
  syscall FileClose, _args \
}
#define SysFileResolveHandle(_args) asm { \
  compchktype _args, FileResolveHandleType \
  syscall FileResolveHandle, _args \
}
#define SysFileRename(_args) asm { \
  compchktype _args, FileRenameType \
  syscall FileRename, _args \
}
#define SysFileDelete(_args) asm { \
  compchktype _args, FileDeleteType \
  syscall FileDelete, _args \
}

#ifdef __ENHANCED_FIRMWARE
#define SysLoaderExecuteFunction(_args) asm { \
  compchktype _args, LoaderExecuteFunctionType \
  syscall LoaderExecuteFunction, _args \
}
#define SysFileFindFirst(_args) asm { \
  compchktype _args, FileFindType \
  syscall FileFindFirst, _args \
}
#define SysFileFindNext(_args) asm { \
  compchktype _args, FileFindType \
  syscall FileFindNext, _args \
}
#define SysFileOpenWriteLinear(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenWriteLinear, _args \
}
#define SysFileOpenWriteNonLinear(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenWriteNonLinear, _args \
}
#define SysFileOpenReadLinear(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenReadLinear, _args \
}
#if __FIRMWARE_VERSION > 107
#define SysFileSeek(_args) asm { \
  compchktype _args, FileSeekType \
  syscall FileSeek, _args \
}
#define SysFileResize(_args) asm { \
  compchktype _args, FileResizeType \
  syscall FileResize, _args \
}
#define SysFileTell(_args) asm { \
  compchktype _args, FileTellType \
  syscall FileTell, _args \
}
#endif
#endif
#if __FIRMWARE_VERSION > 107
#define SysListFiles(_args) asm { \
  compchktype _args, ListFilesType \
  syscall ListFiles, _args \
}
#endif

#endif

/** @} */ // end of LoaderModuleFunctions group
/** @} */ // end of LoaderModule group

/** @} */ // end of NXTFirmwareModules group

#endif // LOADER_H
