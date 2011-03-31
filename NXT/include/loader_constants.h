/** \file loader_constants.h
 * \brief NXC loader module constants
 *
 * loader_constants.h contains NXC loader module constants
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
 * Portions created by John Hansen are Copyright (C) 2009-2010 John Hansen.
 * All Rights Reserved.
 *
 * ----------------------------------------------------------------------------
 *
 * \author John Hansen (bricxcc_at_comcast.net)
 * \date 2011-03-17
 * \version 1
 */

#ifndef LOADER_CONSTANTS_H
#define LOADER_CONSTANTS_H

/** @addtogroup LoaderModule
 * @{
 */
/** @defgroup LoaderModuleConstants Loader module constants
 * Constants that are part of the NXT firmware's Loader module.
 * @{
 */
/** @defgroup LoaderIOMAP Loader module IOMAP offsets
 * Constant offsets into the Loader module IOMAP structure.
 * @{
 */
#define LoaderOffsetPFunc         0 /*!< Offset to the Loader module function pointer */
#define LoaderOffsetFreeUserFlash 4 /*!< Offset to the amount of free user flash */
/** @} */  // end of LoaderIOMAP group

#define EOF -1 /*!< A constant representing end of file */
#define NULL 0 /*!< A constant representing NULL */

/** @defgroup LoaderErrors Loader module error codes
 * Error codes returned by functions in the Loader module (file access).
 * @{
 */
#define LDR_SUCCESS             0x0000 /*!< The function completed successfully. */
#define LDR_INPROGRESS          0x0001 /*!< The function is executing but has not yet completed. */
#define LDR_REQPIN              0x0002 /*!< A PIN exchange request is in progress. */
#define LDR_NOMOREHANDLES       0x8100 /*!< All available file handles are in use. */
#define LDR_NOSPACE             0x8200 /*!< Not enough free flash memory for the specified file size. */
#define LDR_NOMOREFILES         0x8300 /*!< The maximum number of files has been reached. */
#define LDR_EOFEXPECTED         0x8400 /*!< EOF expected. */
#define LDR_ENDOFFILE           0x8500 /*!< The end of the file has been reached. */
#define LDR_NOTLINEARFILE       0x8600 /*!< The specified file is not linear. */
#define LDR_FILENOTFOUND        0x8700 /*!< No files matched the search criteria. */
#define LDR_HANDLEALREADYCLOSED 0x8800 /*!< The file handle has already been closed. */
#define LDR_NOLINEARSPACE       0x8900 /*!< Not enough linear flash memory is available. */
#define LDR_UNDEFINEDERROR      0x8A00 /*!< An undefined error has occurred. */
#define LDR_FILEISBUSY          0x8B00 /*!< The file is already being used. */
#define LDR_NOWRITEBUFFERS      0x8C00 /*!< No more write buffers are available. */
#define LDR_APPENDNOTPOSSIBLE   0x8D00 /*!< Only datafiles can be appended to. */
#define LDR_FILEISFULL          0x8E00 /*!< The allocated file size has been filled. */
#define LDR_FILEEXISTS          0x8F00 /*!< A file with the same name already exists. */
#define LDR_MODULENOTFOUND      0x9000 /*!< No modules matched the specified search criteria. */
#define LDR_OUTOFBOUNDARY       0x9100 /*!< Specified IOMap offset is outside the bounds of the IOMap. */
#define LDR_ILLEGALFILENAME     0x9200 /*!< Filename length to long or attempted open a system file (*.rxe, *.rtm, or *.sys) for writing as a datafile. */
#define LDR_ILLEGALHANDLE       0x9300 /*!< Invalid file handle. */
#define LDR_BTBUSY              0x9400 /*!< The bluetooth system is busy. */
#define LDR_BTCONNECTFAIL       0x9500 /*!< Bluetooth connection attempt failed. */
#define LDR_BTTIMEOUT           0x9600 /*!< A timeout in the bluetooth system has occurred. */
#define LDR_FILETX_TIMEOUT      0x9700 /*!< Error transmitting file: a timeout occurred. */
#define LDR_FILETX_DSTEXISTS    0x9800 /*!< Error transmitting file: destination file exists. */
#define LDR_FILETX_SRCMISSING   0x9900 /*!< Error transmitting file: source file is missing. */
#define LDR_FILETX_STREAMERROR  0x9A00 /*!< Error transmitting file: a stream error occurred. */
#define LDR_FILETX_CLOSEERROR   0x9B00 /*!< Error transmitting file: attempt to close file failed. */

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
#define LDR_INVALIDSEEK         0x9C00 /*!< Invalid file seek operation. */
#endif
/** @} */  // end of LoaderErrors group

/** @defgroup LoaderFunctionConstants Loader module function constants
 * Constants defining the functions provided by the Loader module.
 * @{
 */
#define LDR_CMD_OPENREAD        0x80 /*!< Open a file for reading */
#define LDR_CMD_OPENWRITE       0x81 /*!< Open a file for writing */
#define LDR_CMD_READ            0x82 /*!< Read from a file */
#define LDR_CMD_WRITE           0x83 /*!< Write to a file */
#define LDR_CMD_CLOSE           0x84 /*!< Close a file handle */
#define LDR_CMD_DELETE          0x85 /*!< Delete a file */
#define LDR_CMD_FINDFIRST       0x86 /*!< Find the first file matching the specified pattern */
#define LDR_CMD_FINDNEXT        0x87 /*!< Find the next file matching the specified pattern */
#define LDR_CMD_VERSIONS        0x88 /*!< Read firmware version information */
#define LDR_CMD_OPENWRITELINEAR 0x89 /*!< Open a linear file for writing */
#define LDR_CMD_OPENREADLINEAR  0x8A /*!< Open a linear file for reading */
#define LDR_CMD_OPENWRITEDATA   0x8B /*!< Open a data file for writing */
#define LDR_CMD_OPENAPPENDDATA  0x8C /*!< Open a data file for appending */
#if __FIRMWARE_VERSION > 107
#define LDR_CMD_CROPDATAFILE    0x8D /*!< Crop a data file to its used space */
#endif
#define LDR_CMD_FINDFIRSTMODULE 0x90 /*!< Find the first module matching the specified pattern */
#define LDR_CMD_FINDNEXTMODULE  0x91 /*!< Find the next module matching the specified pattern */
#define LDR_CMD_CLOSEMODHANDLE  0x92 /*!< Close a module handle */
#define LDR_CMD_IOMAPREAD       0x94 /*!< Read data from a module IOMAP */
#define LDR_CMD_IOMAPWRITE      0x95 /*!< Write data to a module IOMAP */
#define LDR_CMD_BOOTCMD         0x97 /*!< Reboot the NXT into SAMBA mode */
#define LDR_CMD_SETBRICKNAME    0x98 /*!< Set the NXT's brick name */
#define LDR_CMD_BTGETADR        0x9A /*!< Get the NXT's bluetooth brick address */
#define LDR_CMD_DEVICEINFO      0x9B /*!< Read device information */
#define LDR_CMD_DELETEUSERFLASH 0xA0 /*!< Delete all files from user flash memory */
#define LDR_CMD_POLLCMDLEN      0xA1 /*!< Read poll command length */
#define LDR_CMD_POLLCMD         0xA2 /*!< Poll command */
#define LDR_CMD_RENAMEFILE      0xA3 /*!< Rename a file */
#define LDR_CMD_BTFACTORYRESET  0xA4 /*!< Reset bluetooth configuration to factory defaults */
#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
#define LDR_CMD_RESIZEDATAFILE  0xD0 /*!< Resize a data file */
#define LDR_CMD_SEEKFROMSTART   0xD1 /*!< Seek from the start of the file */
#define LDR_CMD_SEEKFROMCURRENT 0xD2 /*!< Seek from the current position */
#define LDR_CMD_SEEKFROMEND     0xD3 /*!< Seek from the end of the file */
#endif
/** @} */  // end of LoaderFunctionConstants group

/** @} */  // end of LoaderModuleConstants group
/** @} */  // end of LoaderModule group

#endif // LOADER_CONSTANTS_H
