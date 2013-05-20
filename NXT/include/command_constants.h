/** \file command_constants.h
 * \brief NXC Command module constants
 *
 * command_constants.h contains NXC Command module constants
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

#ifndef COMMAND_CONSTANTS_H
#define COMMAND_CONSTANTS_H

/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup ModuleNameConstants
 * @{
 */
#define CommandModuleName  "Command.mod"   /*!< The command module name */
#define IOCtrlModuleName   "IOCtrl.mod"    /*!< The IOCtrl module name */
#define LoaderModuleName   "Loader.mod"    /*!< The Loader module name */
#define SoundModuleName    "Sound.mod"     /*!< The sound module name */
#define ButtonModuleName   "Button.mod"    /*!< The button module name */
#define UIModuleName       "Ui.mod"        /*!< The Ui module name */
#define InputModuleName    "Input.mod"     /*!< The input module name. */
#define OutputModuleName   "Output.mod"    /*!< The output module name */
#define LowSpeedModuleName "Low Speed.mod" /*!< The low speed module name */
#define DisplayModuleName  "Display.mod"   /*!< The display module name */
#define CommModuleName     "Comm.mod"      /*!< The Comm module name */
/** @} */  // end of ModuleNameConstants group

/** @addtogroup ModuleIDConstants
 * @{
 */
#define CommandModuleID  0x00010001 /*!< The command module ID */
#define IOCtrlModuleID   0x00060001 /*!< The IOCtrl module ID */
#define LoaderModuleID   0x00090001 /*!< The Loader module ID */
#define SoundModuleID    0x00080001 /*!< The sound module ID */
#define ButtonModuleID   0x00040001 /*!< The button module ID */
#define UIModuleID       0x000C0001 /*!< The Ui module ID */
#define InputModuleID    0x00030001 /*!< The input module ID */
#define OutputModuleID   0x00020001 /*!< The output module ID */
#define LowSpeedModuleID 0x000B0001 /*!< The low speed module ID */
#define DisplayModuleID  0x000A0001 /*!< The display module ID */
#define CommModuleID     0x00050001 /*!< The Comm module ID */
/** @} */  // end of ModuleIDConstants group
/** @} */ // end of NXTFirmwareModules group

/** @addtogroup CommandModule
 * @{
 */

/** @addtogroup CommandModuleConstants
 * @{
 */

#ifdef __ENHANCED_FIRMWARE
/** @defgroup ArrayOpConstants Array operation constants
 * Constants for use with the NXC ArrayOp function and the NBC arrop statement.
 * @{
 */
// array operation definitions
#define OPARR_SUM     0x00 /*!< Calculate the sum of the elements in the numeric input array */
#define OPARR_MEAN    0x01 /*!< Calculate the mean value for the elements in the numeric input array */
#define OPARR_SUMSQR  0x02 /*!< Calculate the sum of the squares of the elements in the numeric input array */
#define OPARR_STD     0x03 /*!< Calculate the standard deviation of the elements in the numeric input array */
#define OPARR_MIN     0x04 /*!< Calculate the minimum value of the elements in the numeric input array */
#define OPARR_MAX     0x05 /*!< Calculate the maximum value of the elements in the numeric input array */
#define OPARR_SORT    0x06 /*!< Sort the elements in the numeric input array */
#define OPARR_TOUPPER 0x07 /*!< Uppercase the input string */
#define OPARR_TOLOWER 0x08 /*!< Lowercase the input string */
/** @} */  // end of ArrayOpConstants group
#endif

/** @defgroup SysCallConstants System Call function constants
 * Constants for use in the SysCall() function or NBC syscall statement.
 * @{
 */
#define FileOpenRead       0 /*!< Open a file for reading */
#define FileOpenWrite      1 /*!< Open a file for writing (creates a new file) */
#define FileOpenAppend     2 /*!< Open a file for appending to the end of the file */
#define FileRead           3 /*!< Read from the specified file */
#define FileWrite          4 /*!< Write to the specified file */
#define FileClose          5 /*!< Close the specified file */
#define FileResolveHandle  6 /*!< Get a file handle for the specified filename if it is already open */
#define FileRename         7 /*!< Rename a file */
#define FileDelete         8 /*!< Delete a file */
#define SoundPlayFile      9 /*!< Play a sound or melody file */
#define SoundPlayTone     10 /*!< Play a simple tone with the specified frequency and duration */
#define SoundGetState     11 /*!< Get the current sound module state */
#define SoundSetState     12 /*!< Set the sound module state */
#define DrawText          13 /*!< Draw text to one of 8 LCD lines */
#define DrawPoint         14 /*!< Draw a single pixel on the LCD screen */
#define DrawLine          15 /*!< Draw a line on the LCD screen */
#define DrawCircle        16 /*!< Draw a circle on the LCD screen */
#define DrawRect          17 /*!< Draw a rectangle on the LCD screen */
#define DrawGraphic       18 /*!< Draw a graphic image on the LCD screen */
#define SetScreenMode     19 /*!< Set the screen mode */
#define ReadButton        20 /*!< Read the current button state */
#define CommLSWrite       21 /*!< Write to a lowspeed (aka I2C) device */
#define CommLSRead        22 /*!< Read from a lowspeed (aka I2C) device */
#define CommLSCheckStatus 23 /*!< Check the status of a lowspeed (aka I2C) device */
#define RandomNumber      24 /*!< Generate a random number */
#define GetStartTick      25 /*!< Get the current system tick count */
#define MessageWrite      26 /*!< Write a message to a mailbox */
#define MessageRead       27 /*!< Read a message from a mailbox */
#define CommBTCheckStatus 28 /*!< Check the bluetooth status */
#define CommBTWrite       29 /*!< Write to a bluetooth connections */
#define CommBTRead        30 /*!< Read from a bluetooth connection */
#define KeepAlive         31 /*!< Reset the NXT sleep timer */
#define IOMapRead         32 /*!< Read data from one of the firmware module's IOMap structures using the module's name */
#define IOMapWrite        33 /*!< Write data to one of the firmware module's IOMap structures using the module's name */

#if __FIRMWARE_VERSION <= 107
#ifdef __ENHANCED_FIRMWARE
#define IOMapReadByID          34
#define IOMapWriteByID         35
#define DisplayExecuteFunction 36
#define CommExecuteFunction    37
#define LoaderExecuteFunction  38
#define FileFindFirst          39
#define FileFindNext           40
#define FileOpenWriteLinear    41
#define FileOpenWriteNonLinear 42
#define FileOpenReadLinear     43
#define CommHSControl          44
#define CommHSCheckStatus      45
#define CommHSWrite            46
#define CommHSRead             47 
#endif
#else
// NXT 2.0 firmwares
#define ColorSensorRead        34 /*!< Read data from the NXT 2.0 color sensor */
#define CommBTOnOff            35 /*!< Turn the bluetooth radio on or off */
#define CommBTConnection       36 /*!< Connect or disconnect to a known bluetooth device */
#define CommHSWrite            37 /*!< Write data to the hi-speed port */
#define CommHSRead             38 /*!< Read data from the hi-speed port */
#define CommHSCheckStatus      39 /*!< Check the status of the hi-speed port */
#define ReadSemData            40 /*!< Read motor semaphore data */
#define WriteSemData           41 /*!< Write motor semaphore data */
#define ComputeCalibValue      42 /*!< Compute a calibration value */
#define UpdateCalibCacheInfo   43 /*!< Update sensor calibration cache information */
#define DatalogWrite           44 /*!< Write to the datalog */
#define DatalogGetTimes        45 /*!< Get datalog timing information */
#define SetSleepTimeoutVal     46 /*!< Set the NXT sleep timeout value */
#define ListFiles              47 /*!< List files that match the specified filename pattern */

#ifdef __ENHANCED_FIRMWARE
#define InputPinFunction       77 /*!< Execute the Input module's pin function */
#define IOMapReadByID          78 /*!< Read data from one of the firmware module's IOMap structures using the module's ID */
#define IOMapWriteByID         79 /*!< Write data to one of the firmware module's IOMap structures using the module's ID */
#define DisplayExecuteFunction 80 /*!< Execute one of the Display module's internal functions */
#define CommExecuteFunction    81 /*!< Execute one of the Comm module's internal functions */
#define LoaderExecuteFunction  82 /*!< Execute one of the Loader module's internal functions */
#define FileFindFirst          83 /*!< Start a search for a file using a filename pattern */
#define FileFindNext           84 /*!< Continue searching for a file */
#define FileOpenWriteLinear    85 /*!< Open a linear file for writing */
#define FileOpenWriteNonLinear 86 /*!< Open a non-linear file for writing */
#define FileOpenReadLinear     87 /*!< Open a linear file for reading */
#define CommHSControl          88 /*!< Control the hi-speed port */
#define CommLSWriteEx          89 /*!< Write to a lowspeed (aka I2C) device with optional restart on read */
#define FileSeek               90 /*!< Seek to a specific position in an open file */
#define FileResize             91 /*!< Resize a file (not yet implemented) */
#define DrawGraphicArray       92 /*!< Draw a graphic image from a byte array to the LCD screen */
#define DrawPolygon            93 /*!< Draw a polygon on the LCD screen */
#define DrawEllipse            94 /*!< Draw an ellipse on the LCD screen */
#define DrawFont               95 /*!< Draw text using a custom RIC-based font to the LCD screen */
#define MemoryManager          96 /*!< Read memory manager information, optionally compacting the dataspace first */
#define ReadLastResponse       97 /*!< Read the last response packet received by the NXT.  Optionally clear the value after reading it. */
#define FileTell               98 /*!< Return the current file position in an open file */
#define RandomEx               99 /*!< Generate a random number or seed the RNG. */
#endif
#endif
/** @} */  // end of SysCallConstants group


/** @defgroup TimeConstants Time constants
 * Constants for use with the Wait() function.
 * \sa Wait()
 * @{
 */
#define MS_1        1 /*!< 1 millisecond */
#define MS_2        2 /*!< 2 milliseconds */
#define MS_3        3 /*!< 3 milliseconds */
#define MS_4        4 /*!< 4 milliseconds */
#define MS_5        5 /*!< 5 milliseconds */
#define MS_6        6 /*!< 6 milliseconds */
#define MS_7        7 /*!< 7 milliseconds */
#define MS_8        8 /*!< 8 milliseconds */
#define MS_9        9 /*!< 9 milliseconds */
#define MS_10      10 /*!< 10 milliseconds */
#define MS_20      20 /*!< 20 milliseconds */
#define MS_30      30 /*!< 30 milliseconds */
#define MS_40      40 /*!< 40 milliseconds */
#define MS_50      50 /*!< 50 milliseconds */
#define MS_60      60 /*!< 60 milliseconds */
#define MS_70      70 /*!< 70 milliseconds */
#define MS_80      80 /*!< 80 milliseconds */
#define MS_90      90 /*!< 90 milliseconds */
#define MS_100    100 /*!< 100 milliseconds */
#define MS_150    150 /*!< 150 milliseconds */
#define MS_200    200 /*!< 200 milliseconds */
#define MS_250    250 /*!< 250 milliseconds */
#define MS_300    300 /*!< 300 milliseconds */
#define MS_350    350 /*!< 350 milliseconds */
#define MS_400    400 /*!< 400 milliseconds */
#define MS_450    450 /*!< 450 milliseconds */
#define MS_500    500 /*!< 500 milliseconds */
#define MS_600    600 /*!< 600 milliseconds */
#define MS_700    700 /*!< 700 milliseconds */
#define MS_800    800 /*!< 800 milliseconds */
#define MS_900    900 /*!< 900 milliseconds */
#define SEC_1    1000 /*!< 1 second */
#define SEC_2    2000 /*!< 2 seconds */
#define SEC_3    3000 /*!< 3 seconds */
#define SEC_4    4000 /*!< 4 seconds */
#define SEC_5    5000 /*!< 5 seconds */
#define SEC_6    6000 /*!< 6 seconds */
#define SEC_7    7000 /*!< 7 seconds */
#define SEC_8    8000 /*!< 8 seconds */
#define SEC_9    9000 /*!< 9 seconds */
#define SEC_10  10000 /*!< 10 seconds */
#define SEC_15  15000 /*!< 15 seconds */
#define SEC_20  20000 /*!< 20 seconds */
#define SEC_30  30000 /*!< 30 seconds */
#define MIN_1   60000 /*!< 1 minute */

#define NOTE_WHOLE   1000            /*!< The duration of a whole note (ms) */
#define NOTE_HALF    (NOTE_WHOLE/2)  /*!< The duration of a half note (ms) */
#define NOTE_QUARTER (NOTE_WHOLE/4)  /*!< The duration of a quarter note (ms) */
#define NOTE_EIGHT   (NOTE_WHOLE/8)  /*!< The duration of an eighth note (ms) */
#define NOTE_SIXTEEN (NOTE_WHOLE/16) /*!< The duration of an sixteenth note (ms) */
/** @} */  // end of TimeConstants group

/** @defgroup MailboxConstants Mailbox constants
 * Mailbox number constants should be used to avoid confusing NXT-G users.
 * \sa SysMessageWrite(), SysMessageRead(), SendMessage(), ReceiveMessage(),
 * SendRemoteBool(), SendRemoteNumber(), SendRemoteString(),
 * SendResponseBool(), SendResponseNumber(), SendResponseString(),
 * ReceiveRemoteBool(), ReceiveRemoteNumber(), ReceiveRemoteString(),
 * ReceiveRemoteMessageEx(), RemoteMessageRead(), RemoteMessageWrite()
 * @{
 */
#define MAILBOX1  0 /*!< Mailbox number 1 */
#define MAILBOX2  1 /*!< Mailbox number 2 */
#define MAILBOX3  2 /*!< Mailbox number 3 */
#define MAILBOX4  3 /*!< Mailbox number 4 */
#define MAILBOX5  4 /*!< Mailbox number 5 */
#define MAILBOX6  5 /*!< Mailbox number 6 */
#define MAILBOX7  6 /*!< Mailbox number 7 */
#define MAILBOX8  7 /*!< Mailbox number 8 */
#define MAILBOX9  8 /*!< Mailbox number 9 */
#define MAILBOX10 9 /*!< Mailbox number 10 */
/** @} */  // end of MailboxConstants group

//Status/error codes for the VM internal code and bytecodes
#define STAT_MSG_EMPTY_MAILBOX 64 /*!< Specified mailbox contains no new messages */
#define STAT_COMM_PENDING 32      /*!< Pending setup operation in progress */

#define POOL_MAX_SIZE 32768      /*!< Maximum size of memory pool, in bytes */

/** @defgroup CommandVMState VM state constants
 * Constants defining possible VM states.
 * @{
 */
#define TIMES_UP      6 /*!< VM time is up */
#define ROTATE_QUEUE  5 /*!< VM should rotate queue */
#define STOP_REQ      4 /*!< VM should stop executing program */
#define BREAKOUT_REQ  3 /*!< VM should break out of current thread */
#define CLUMP_SUSPEND 2 /*!< VM should suspend thread */
#define CLUMP_DONE    1 /*!< VM has finished executing thread */
/** @} */  // end of CommandVMState group

#define NO_ERR        0 /*!< Successful execution of the specified command */

/** @defgroup CommandFatalErrors Fatal errors
 * Constants defining various fatal error conditions.
 * @{
 */
#define ERR_ARG             -1 /*!< 0xFF Bad arguments */
#define ERR_INSTR           -2 /*!< 0xFE Illegal bytecode instruction */
#define ERR_FILE            -3 /*!< 0xFD Malformed file contents */
#define ERR_VER             -4 /*!< 0xFC Version mismatch between firmware and compiler */
#define ERR_MEM             -5 /*!< 0xFB Insufficient memory available */
#define ERR_BAD_PTR         -6 /*!< 0xFA Someone passed us a bad pointer! */
#define ERR_CLUMP_COUNT     -7 /*!< 0xF9 (FileClumpCount == 0 || FileClumpCount >= NOT_A_CLUMP) */
#define ERR_NO_CODE         -8 /*!< 0xF8 VarsCmd.CodespaceCount == 0 */
#define ERR_INSANE_OFFSET   -9 /*!< 0xF7 CurrOffset != (DataSize - VarsCmd.CodespaceCount * 2) */
#define ERR_BAD_POOL_SIZE   -10 /*!< 0xF6 VarsCmd.PoolSize > POOL_MAX_SIZE */
#define ERR_LOADER_ERR      -11 /*!< 0xF5 LOADER_ERR(LStatus) != SUCCESS || pData == NULL || DataSize == 0 */
#define ERR_SPOTCHECK_FAIL  -12 /*!< 0xF4 ((UBYTE*)(VarsCmd.pCodespace) < pData) (c_cmd.c 1893) */
#define ERR_NO_ACTIVE_CLUMP -13 /*!< 0xF3 VarsCmd.RunQ.Head == NOT_A_CLUMP */
#define ERR_DEFAULT_OFFSETS -14 /*!< 0xF2 (DefaultsOffset != FileOffsets.DynamicDefaults) || (DefaultsOffset + FileOffsets.DynamicDefaultsSize != FileOffsets.DSDefaultsSize) */
#define ERR_MEMMGR_FAIL     -15 /*!< 0xF1 (UBYTE *)VarsCmd.MemMgr.pDopeVectorArray != VarsCmd.pDataspace + DV_ARRAY[0].Offset */

#define ERR_NON_FATAL -16 /*!< Fatal errors are greater than this value */
/** @} */  // end of CommandFatalErrors group

/** @defgroup CommandGenErrors General errors
 * Constants defining general error conditions.
 * @{
 */
#define ERR_INVALID_PORT   -16 /*!< 0xF0 Bad input or output port specified */
#define ERR_INVALID_FIELD  -17 /*!< 0xEF Attempted to access invalid field of a structure */
#define ERR_INVALID_QUEUE  -18 /*!< 0xEE Illegal queue ID specified */
#define ERR_INVALID_SIZE   -19 /*!< 0xED Illegal size specified */
#define ERR_NO_PROG        -20 /*!< 0xEC No active program */
/** @} */  // end of CommandGenErrors group

/** @defgroup CommandCommErrors Communications specific errors
 * Constants defining communication error conditions.
 * @{
 */
#define ERR_COMM_CHAN_NOT_READY -32 /*!< 0xE0 Specified channel/connection not configured or busy */
#define ERR_COMM_CHAN_INVALID   -33 /*!< 0xDF Specified channel/connection is not valid */
#define ERR_COMM_BUFFER_FULL    -34 /*!< 0xDE No room in comm buffer */
#define ERR_COMM_BUS_ERR        -35 /*!< 0xDD Something went wrong on the communications bus */
/** @} */  // end of CommandCommErrors group

/** @defgroup CommandRCErrors Remote control (direct commands) errors
 * Constants defining errors that can occur during remote control (RC) direct
 * command operations.
 * @{
 */
#define ERR_RC_ILLEGAL_VAL -64 /*!< 0xC0 Data contains out-of-range values */
#define ERR_RC_BAD_PACKET  -65 /*!< 0xBF Clearly insane packet */
#define ERR_RC_UNKNOWN_CMD -66 /*!< 0xBE Unknown command opcode */
#define ERR_RC_FAILED      -67 /*!< 0xBD Request failed (i.e. specified file not found) */
/** @} */  // end of CommandRCErrors group

/** @defgroup CommandProgStatus Program status constants
 * Constants defining various states of the command module virtual machine.
 * @{
 */
#define PROG_IDLE     0 /*!< Program state is idle */
#define PROG_OK       1 /*!< Program state is okay */
#define PROG_RUNNING  2 /*!< Program is running */
#define PROG_ERROR    3 /*!< A program error has occurred */
#define PROG_ABORT    4 /*!< Program has been aborted */
#define PROG_RESET    5 /*!< Program has been reset */
/** @} */  // end of CommandProgStatus group

/** @defgroup CommandIOMAP Command module IOMAP offsets
 * Constant offsets into the Command module IOMAP structure.
 * @{
 */
#define CommandOffsetFormatString   0 /*!< Offset to the format string */
#define CommandOffsetPRCHandler     16 /*!< Offset to the RC Handler function pointer */
#define CommandOffsetTick           20 /*!< Offset to the VM's current tick */
#define CommandOffsetOffsetDS       24 /*!< Offset to the running program's data space (DS) */
#define CommandOffsetOffsetDVA      26 /*!< Offset to the running program's DOPE vector address (DVA) */
#define CommandOffsetProgStatus     28 /*!< Offset to the running program's status */
#define CommandOffsetAwake          29 /*!< Offset to the VM's awake state */
#define CommandOffsetActivateFlag   30 /*!< Offset to the activate flag */
#define CommandOffsetDeactivateFlag 31 /*!< Offset to the deactivate flag */
#define CommandOffsetFileName       32 /*!< Offset to the running program's filename */
#define CommandOffsetMemoryPool     52 /*!< Offset to the VM's memory pool */
#if __FIRMWARE_VERSION > 107
#define CommandOffsetSyncTime       32820 /*!< Offset to the VM sync time */
#define CommandOffsetSyncTick       32824 /*!< Offset to the VM sync tick */
#endif
/** @} */  // end of CommandIOMAP group

/** @} */ // end of CommModuleConstants group

/** @} */ // end of CommModule group

#endif // COMMAND_CONSTANTS_H
