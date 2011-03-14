/** \file NBCCommon.h
 * \brief Constants and macros common to both NBC and NXC
 *
 * NBCCommon.h contains declarations for the NBC and NXC NXT API functions.
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
 * \date 2011-03-13
 * \version 63
 */

#ifndef NBCCOMMON_H
#define NBCCOMMON_H

/** @addtogroup MiscConstants
 * @{
 */
#define TRUE  1 /*!< A true value */
#define FALSE 0 /*!< A false value */

#define NA 0xFFFF /*!< The specified argument does not apply (aka unwired) */

/** @defgroup RCPropertyConstants Property constants
 * Use these constants for specifying the property for the GetProperty
 * and SetProperty direct commands.
 * @{
 */
#define RC_PROP_BTONOFF       0x0  /*!< Set/get whether bluetooth is on or off */
#define RC_PROP_SOUND_LEVEL   0x1  /*!< Set/get the NXT sound level */
#define RC_PROP_SLEEP_TIMEOUT 0x2  /*!< Set/get the NXT sleep timeout value (times 60000) */
#define RC_PROP_DEBUGGING     0xF  /*!< Set/get enhanced firmware debugging information */
/** @} */  // end of RCPropertyConstants group

/** @} */  // end of MiscConstants group

#ifdef __ENHANCED_FIRMWARE
/** @addtogroup CommandModuleConstants
 * @{
 */
/** @defgroup ArrayOpConstants Array operation constants
 * Constants for use with the NXC ArrayOp function and the NBC arrop statement.
 * @{
 */
// array operation definitions
#define OPARR_SUM    0x00 /*!< Calculate the sum of the elements in the numeric input array */
#define OPARR_MEAN   0x01 /*!< Calculate the mean value for the elements in the numeric input array */
#define OPARR_SUMSQR 0x02 /*!< Calculate the sum of the squares of the elements in the numeric input array */
#define OPARR_STD    0x03 /*!< Calculate the standard deviation of the elements in the numeric input array */
#define OPARR_MIN    0x04 /*!< Calculate the minimum value of the elements in the numeric input array */
#define OPARR_MAX    0x05 /*!< Calculate the maximum value of the elements in the numeric input array */
#define OPARR_SORT   0x06 /*!< Sort the elements in the numeric input array */
/** @} */  // end of ArrayOpConstants group
/** @} */  // end of CommandModuleConstants group
#endif

/** @addtogroup MiscConstants
 * @{
 */
#if __FIRMWARE_VERSION > 107
#define PI 3.141593               /*!< A constant for PI */
#define RADIANS_PER_DEGREE PI/180 /*!< Used for converting from degrees to radians */
#define DEGREES_PER_RADIAN 180/PI /*!< Used for converting from radians to degrees */
#endif
/** @} */  // end of MiscConstants group

#if __FIRMWARE_VERSION <= 107
/** @defgroup IOMapAddressConstants Direct IOMap data addresses
 * Constants for use in direct IOMap addressing (1.0x only).
 * @{
 */
#define IO_BASE    0xC000
#define MOD_INPUT  0x0000
#define MOD_OUTPUT 0x0200
#define IO_IN_FPP  6
#define IO_OUT_FPP 15

#define InputIOType(p)            (IO_BASE+MOD_INPUT+TypeField+((p)*IO_IN_FPP))
#define InputIOInputMode(p)       (IO_BASE+MOD_INPUT+InputModeField+((p)*IO_IN_FPP))
#define InputIORawValue(p)        (IO_BASE+MOD_INPUT+RawValueField+((p)*IO_IN_FPP))
#define InputIONormalizedValue(p) (IO_BASE+MOD_INPUT+NormalizedValueField+((p)*IO_IN_FPP))
#define InputIOScaledValue(p)     (IO_BASE+MOD_INPUT+ScaledValueField+((p)*IO_IN_FPP))
#define InputIOInvalidData(p)     (IO_BASE+MOD_INPUT+InvalidDataField+((p)*IO_IN_FPP))

#define OutputIOUpdateFlags(p)     (IO_BASE+MOD_OUTPUT+UpdateFlagsField+((p)*IO_OUT_FPP))
#define OutputIOOutputMode(p)      (IO_BASE+MOD_OUTPUT+OutputModeField+((p)*IO_OUT_FPP))
#define OutputIOPower(p)           (IO_BASE+MOD_OUTPUT+PowerField+((p)*IO_OUT_FPP))
#define OutputIOActualSpeed(p)     (IO_BASE+MOD_OUTPUT+ActualSpeedField+((p)*IO_OUT_FPP))
#define OutputIOTachoCount(p)      (IO_BASE+MOD_OUTPUT+TachoCountField+((p)*IO_OUT_FPP))
#define OutputIOTachoLimit(p)      (IO_BASE+MOD_OUTPUT+TachoLimitField+((p)*IO_OUT_FPP))
#define OutputIORunState(p)        (IO_BASE+MOD_OUTPUT+RunStateField+((p)*IO_OUT_FPP))
#define OutputIOTurnRatio(p)       (IO_BASE+MOD_OUTPUT+TurnRatioField+((p)*IO_OUT_FPP))
#define OutputIORegMode(p)         (IO_BASE+MOD_OUTPUT+RegModeField+((p)*IO_OUT_FPP))
#define OutputIOOverload(p)        (IO_BASE+MOD_OUTPUT+OverloadField+((p)*IO_OUT_FPP))
#define OutputIORegPValue(p)       (IO_BASE+MOD_OUTPUT+RegPValueField+((p)*IO_OUT_FPP))
#define OutputIORegIValue(p)       (IO_BASE+MOD_OUTPUT+RegIValueField+((p)*IO_OUT_FPP))
#define OutputIORegDValue(p)       (IO_BASE+MOD_OUTPUT+RegDValueField+((p)*IO_OUT_FPP))
#define OutputIOBlockTachoCount(p) (IO_BASE+MOD_OUTPUT+BlockTachoCountField+((p)*IO_OUT_FPP))
#define OutputIORotationCount(p)   (IO_BASE+MOD_OUTPUT+RotationCountField+((p)*IO_OUT_FPP))

#define InputIOType0             0xc000
#define InputIOInputMode0        0xc001
#define InputIORawValue0         0xc002
#define InputIONormalizedValue0  0xc003
#define InputIOScaledValue0      0xc004
#define InputIOInvalidData0      0xc005
#define InputIOType1             0xc006
#define InputIOInputMode1        0xc007
#define InputIORawValue1         0xc008
#define InputIONormalizedValue1  0xc009
#define InputIOScaledValue1      0xc00a
#define InputIOInvalidData1      0xc00b
#define InputIOType2             0xc00c
#define InputIOInputMode2        0xc00d
#define InputIORawValue2         0xc00e
#define InputIONormalizedValue2  0xc00f
#define InputIOScaledValue2      0xc010
#define InputIOInvalidData2      0xc011
#define InputIOType3             0xc012
#define InputIOInputMode3        0xc013
#define InputIORawValue3         0xc014
#define InputIONormalizedValue3  0xc015
#define InputIOScaledValue3      0xc016
#define InputIOInvalidData3      0xc017
// output IO Map addresses
#define OutputIOUpdateFlags0     0xc200
#define OutputIOOutputMode0      0xc201
#define OutputIOPower0           0xc202
#define OutputIOActualSpeed0     0xc203
#define OutputIOTachoCount0      0xc204
#define OutputIOTachoLimit0      0xc205
#define OutputIORunState0        0xc206
#define OutputIOTurnRatio0       0xc207
#define OutputIORegMode0         0xc208
#define OutputIOOverload0        0xc209
#define OutputIORegPValue0       0xc20a
#define OutputIORegIValue0       0xc20b
#define OutputIORegDValue0       0xc20c
#define OutputIOBlockTachoCount0 0xc20d
#define OutputIORotationCount0   0xc20e
#define OutputIOUpdateFlags1     0xc20f
#define OutputIOOutputMode1      0xc210
#define OutputIOPower1           0xc211
#define OutputIOActualSpeed1     0xc212
#define OutputIOTachoCount1      0xc213
#define OutputIOTachoLimit1      0xc214
#define OutputIORunState1        0xc215
#define OutputIOTurnRatio1       0xc216
#define OutputIORegMode1         0xc217
#define OutputIOOverload1        0xc218
#define OutputIORegPValue1       0xc219
#define OutputIORegIValue1       0xc21a
#define OutputIORegDValue1       0xc21b
#define OutputIOBlockTachoCount1 0xc21c
#define OutputIORotationCount1   0xc21d
#define OutputIOUpdateFlags2     0xc21e
#define OutputIOOutputMode2      0xc21f
#define OutputIOPower2           0xc220
#define OutputIOActualSpeed2     0xc221
#define OutputIOTachoCount2      0xc222
#define OutputIOTachoLimit2      0xc223
#define OutputIORunState2        0xc224
#define OutputIOTurnRatio2       0xc225
#define OutputIORegMode2         0xc226
#define OutputIOOverload2        0xc227
#define OutputIORegPValue2       0xc228
#define OutputIORegIValue2       0xc229
#define OutputIORegDValue2       0xc22a
#define OutputIOBlockTachoCount2 0xc22b
#define OutputIORotationCount2   0xc22c
/** @} */  // end of IOMapAddressConstants group
#endif

/** @addtogroup CommandModuleConstants
 * @{
 */
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
#endif
#endif
/** @} */  // end of SysCallConstants group
/** @} */  // end of CommandModuleConstants group

/** @addtogroup DisplayModuleConstants
 * @{
 */
/** @defgroup LineConstants Line number constants
 * Line numbers for use with DrawText system function.
 * \sa SysDrawText(), TextOut(), NumOut()
 * @{
 */
#define LCD_LINE8  0 /*!< The 8th line of the LCD screen */
#define LCD_LINE7  8 /*!< The 7th line of the LCD screen */
#define LCD_LINE6 16 /*!< The 6th line of the LCD screen */
#define LCD_LINE5 24 /*!< The 5th line of the LCD screen */
#define LCD_LINE4 32 /*!< The 4th line of the LCD screen */
#define LCD_LINE3 40 /*!< The 3rd line of the LCD screen */
#define LCD_LINE2 48 /*!< The 2nd line of the LCD screen */
#define LCD_LINE1 56 /*!< The 1st line of the LCD screen */
/** @} */  // end of LineConstants group
/** @} */  // end of DisplayModuleConstants group

/** @addtogroup CommandModuleConstants
 * @{
 */
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
/** @} */  // end of TimeConstants group
/** @} */ // end of CommandModuleConstants group

/** @addtogroup CommModuleConstants
 * @{
 */
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
/** @} */ // end of CommModuleConstants group

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

/** @} */  // end of CommandModuleConstants group
/** @} */  // end of CommandModule group


/** @addtogroup IOCtrlModule
 * @{
 */
/** @defgroup IOCtrlModuleConstants IOCtrl module constants
 * Constants that are part of the NXT firmware's IOCtrl module.
 * @{
 */
/** @defgroup IOCtrlPO PowerOn constants
 * Use these constants to power down the NXT or boot it into SAMBA
 * (aka firmware download) mode.
 * @{
 */
#define IOCTRL_POWERDOWN  0x5A00 /*!< Power down the NXT */
#define IOCTRL_BOOT       0xA55A /*!< Reboot the NXT into SAMBA mode */
/** @} */  // end of IOCtrlPO group

/** @defgroup IOCtrlIOMAP IOCtrl module IOMAP offsets
 * Constant offsets into the IOCtrl module IOMAP structure.
 * @{
 */
#define IOCtrlOffsetPowerOn 0 /*!< Offset to power on field */
/** @} */  // end of IOCtrlIOMAP group

/** @} */  // end of IOCtrlModuleConstants group
/** @} */  // end of IOCtrlModule group


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


/** @addtogroup SoundModule
 * @{
 */
/** @defgroup SoundModuleConstants Sound module constants
 * Constants that are part of the NXT firmware's Sound module.
 * @{
 */
/** @defgroup SoundFlagsConstants SoundFlags constants
 * Constants for use with the SoundFlags() function.
 * \sa SoundFlags()
 * @{
 */
#define SOUND_FLAGS_IDLE    0x00 /*!< R  - Sound is idle */
#define SOUND_FLAGS_UPDATE  0x01 /*!< W  - Make changes take effect */
#define SOUND_FLAGS_RUNNING 0x02 /*!< R  - Currently processing a tone or file */
/** @} */  // end of SoundFlagsConstants group

/** @defgroup SoundStateConstants SoundState constants
 * Constants for use with the SoundState() function.
 * \sa SoundState()
 * @{
 */
#define SOUND_STATE_IDLE 0x00 /*!< R  - Idle, ready for start sound (SOUND_UPDATE) */
#define SOUND_STATE_FILE 0x02 /*!< R  - Processing a file of sound/melody data */
#define SOUND_STATE_TONE 0x03 /*!< R  - Processing a play tone request */
#define SOUND_STATE_STOP 0x04 /*!< W  - Stop sound immediately and close hardware */
/** @} */  // end of SoundStateConstants group

/** @defgroup SoundModeConstants SoundMode constants
 * Constants for use with the SoundMode() function.
 * \sa SoundMode()
 * @{
 */
#define SOUND_MODE_ONCE 0x00 /*!< W  - Only play file once */
#define SOUND_MODE_LOOP 0x01 /*!< W  - Play file until writing SOUND_STATE_STOP into SoundState */
#define SOUND_MODE_TONE 0x02 /*!< W  - Play tone specified in Frequency for Duration ms */
/** @} */  // end of SoundModeConstants group

/** @defgroup SoundIOMAP Sound module IOMAP offsets
 * Constant offsets into the Sound module IOMAP structure.
 * @{
 */
#define SoundOffsetFreq           0 /*!< RW - Tone frequency [Hz] (2 bytes) */
#define SoundOffsetDuration       2 /*!< RW - Tone duration  [mS] (2 bytes) */
#define SoundOffsetSampleRate     4 /*!< RW - Sound file sample rate [2000..16000] (2 bytes) */
#define SoundOffsetSoundFilename  6 /*!< RW - Sound/melody filename (20 bytes) */
#define SoundOffsetFlags         26 /*!< RW - Play flag  - described above (1 byte) \ref SoundFlagsConstants */
#define SoundOffsetState         27 /*!< RW - Play state - described above (1 byte) \ref SoundStateConstants */
#define SoundOffsetMode          28 /*!< RW - Play mode  - described above (1 byte) \ref SoundModeConstants */
#define SoundOffsetVolume        29 /*!< RW - Sound/melody volume [0..4] 0 = off (1 byte) */
/** @} */  // end of SoundIOMAP group

/** @defgroup SoundMisc Sound module miscellaneous constants
 * Constants defining miscellaneous sound module aspects.
 * @{
 */
#define FREQUENCY_MIN       220       /*!< Minimum frequency [Hz] */
#define FREQUENCY_MAX       14080     /*!< Maximum frequency [Hz] */

#define SAMPLERATE_MIN      2000      /*!< Min sample rate [sps] */
#define SAMPLERATE_DEFAULT  8000      /*!< Default sample rate [sps] */
#define SAMPLERATE_MAX      16000     /*!< Max sample rate [sps] */
/** @} */  // end of SoundMisc group

/** @defgroup ToneConstants Tone constants
 * Constants for use in the  SoundPlayTone() API function.
 * \sa SoundPlayTone()
 * @{
 */
#define TONE_A3               220 /*!< Third octave A */
#define TONE_AS3              233 /*!< Third octave A sharp */
#define TONE_B3               247 /*!< Third octave B */
#define TONE_C4               262 /*!< Fourth octave C */
#define TONE_CS4              277 /*!< Fourth octave C sharp */
#define TONE_D4               294 /*!< Fourth octave D */
#define TONE_DS4              311 /*!< Fourth octave D sharp */
#define TONE_E4               330 /*!< Fourth octave E */
#define TONE_F4               349 /*!< Fourth octave F */
#define TONE_FS4              370 /*!< Fourth octave F sharp */
#define TONE_G4               392 /*!< Fourth octave G */
#define TONE_GS4              415 /*!< Fourth octave G sharp */
#define TONE_A4               440 /*!< Fourth octave A */
#define TONE_AS4              466 /*!< Fourth octave A sharp */
#define TONE_B4               494 /*!< Fourth octave B */
#define TONE_C5               523 /*!< Fifth octave C */
#define TONE_CS5              554 /*!< Fifth octave C sharp */
#define TONE_D5               587 /*!< Fifth octave D */
#define TONE_DS5              622 /*!< Fifth octave D sharp */
#define TONE_E5               659 /*!< Fifth octave E */
#define TONE_F5               698 /*!< Fifth octave F */
#define TONE_FS5              740 /*!< Fifth octave F sharp */
#define TONE_G5               784 /*!< Fifth octave G */
#define TONE_GS5              831 /*!< Fifth octave G sharp */
#define TONE_A5               880 /*!< Fifth octave A */
#define TONE_AS5              932 /*!< Fifth octave A sharp */
#define TONE_B5               988 /*!< Fifth octave B */
#define TONE_C6               1047 /*!< Sixth octave C */
#define TONE_CS6              1109 /*!< Sixth octave C sharp */
#define TONE_D6               1175 /*!< Sixth octave D */
#define TONE_DS6              1245 /*!< Sixth octave D sharp */
#define TONE_E6               1319 /*!< Sixth octave E */
#define TONE_F6               1397 /*!< Sixth octave F */
#define TONE_FS6              1480 /*!< Sixth octave F sharp */
#define TONE_G6               1568 /*!< Sixth octave G */
#define TONE_GS6              1661 /*!< Sixth octave G sharp */
#define TONE_A6               1760 /*!< Sixth octave A */
#define TONE_AS6              1865 /*!< Sixth octave A sharp */
#define TONE_B6               1976 /*!< Sixth octave B */
#define TONE_C7               2093 /*!< Seventh octave C */
#define TONE_CS7              2217 /*!< Seventh octave C sharp */
#define TONE_D7               2349 /*!< Seventh octave D */
#define TONE_DS7              2489 /*!< Seventh octave D sharp */
#define TONE_E7               2637 /*!< Seventh octave E */
#define TONE_F7               2794 /*!< Seventh octave F */
#define TONE_FS7              2960 /*!< Seventh octave F sharp */
#define TONE_G7               3136 /*!< Seventh octave G */
#define TONE_GS7              3322 /*!< Seventh octave G sharp */
#define TONE_A7               3520 /*!< Seventh octave A */
#define TONE_AS7              3729 /*!< Seventh octave A sharp */
#define TONE_B7               3951 /*!< Seventh octave B */
/** @} */  // end of ToneConstants group

/** @} */  // end of SoundModuleConstants group
/** @} */  // end of SoundModule group


/** @addtogroup ButtonModule
 * @{
 */
/** @defgroup ButtonModuleConstants Button module constants
 * Constants that are part of the NXT firmware's Button module.
 * @{
 */
/** @defgroup ButtonNameConstants Button name constants
 * Constants to specify which button to use with button module functions.
 * \sa ButtonPressed(), ButtonState(), ButtonCount(), ReadButtonEx(),
 * SysReadButton(), ReadButtonType
 * @{
 */
#define BTN1 0 /*!< The exit button. */
#define BTN2 1 /*!< The right button. */
#define BTN3 2 /*!< The left button. */
#define BTN4 3 /*!< The enter button. */

#define BTNEXIT   BTN1 /*!< The exit button. */
#define BTNRIGHT  BTN2 /*!< The right button. */
#define BTNLEFT   BTN3 /*!< The left button. */
#define BTNCENTER BTN4 /*!< The enter button. */

#define NO_OF_BTNS 4 /*!< The number of NXT buttons. */
/** @} */  // end of ButtonNameConstants group

/** @defgroup ButtonStateConstants ButtonState constants
 * Constants for use with the ButtonState() function. The _EV values can be
 * combined together using a bitwise OR operation.
 * \sa ButtonState()
 * @{
 */
#define BTNSTATE_PRESSED_EV         0x01 /*!< Button is in the pressed state. */
#define BTNSTATE_SHORT_RELEASED_EV  0x02 /*!< Button is in the short released state. */
#define BTNSTATE_LONG_PRESSED_EV    0x04 /*!< Button is in the long pressed state. */
#define BTNSTATE_LONG_RELEASED_EV   0x08 /*!< Button is in the long released state. */
#define BTNSTATE_PRESSED_STATE      0x80 /*!< A bitmask for the button pressed state */
#define BTNSTATE_NONE               0x10 /*!< The default button state. */
/** @} */  // end of ButtonStateConstants group

/** @defgroup ButtonIOMAP Button module IOMAP offsets
 * Constant offsets into the Button module IOMAP structure.
 * @{
 */
#define ButtonOffsetPressedCnt(b)   (((b)*8)+0) /*!< Offset to the PressedCnt field. This field stores the press count. */
#define ButtonOffsetLongPressCnt(b) (((b)*8)+1) /*!< Offset to the LongPressCnt field. This field stores the long press count.*/
#define ButtonOffsetShortRelCnt(b)  (((b)*8)+2) /*!< Offset to the ShortRelCnt field. This field stores the short release count. */
#define ButtonOffsetLongRelCnt(b)   (((b)*8)+3) /*!< Offset to the LongRelCnt field. This field stores the long release count. */
#define ButtonOffsetRelCnt(b)       (((b)*8)+4) /*!< Offset to the RelCnt field. This field stores the release count. */
#define ButtonOffsetState(b)        ((b)+32)    /*!< Offset to the State field. This field stores the current button state. */
/** @} */  // end of ButtonIOMAP group
/** @} */  // end of ButtonModuleConstants group
/** @} */  // end of ButtonModule group


/** @addtogroup UiModule
 * @{
 */
/** @defgroup UiModuleConstants Ui module constants
 * Constants that are part of the NXT firmware's Ui module.
 * @{
 */
/** @defgroup UiFlagsConstants CommandFlags constants
 * Constants for use with the CommandFlags() function.
 * \sa CommandFlags()
 * @{
 */
#define UI_FLAGS_UPDATE                   0x01 /*!< W  - Make changes take effect */
#define UI_FLAGS_DISABLE_LEFT_RIGHT_ENTER 0x02 /*!< RW - Disable left, right and enter button */
#define UI_FLAGS_DISABLE_EXIT             0x04 /*!< RW - Disable exit button */
#define UI_FLAGS_REDRAW_STATUS            0x08 /*!< W  - Redraw entire status line */
#define UI_FLAGS_RESET_SLEEP_TIMER        0x10 /*!< W  - Reset sleep timeout timer */
#define UI_FLAGS_EXECUTE_LMS_FILE         0x20 /*!< W  - Execute LMS file in "LMSfilename" (Try It) */
#define UI_FLAGS_BUSY                     0x40 /*!< R  - UI busy running or datalogging (popup disabled) */
#define UI_FLAGS_ENABLE_STATUS_UPDATE     0x80 /*!< W  - Enable status line to be updated */
/** @} */  // end of UiFlagsConstants group

/** @defgroup UiStateConstants UIState constants
 * Constants for use with the UIState() function.
 * \sa UIState()
 * @{
 */
#define UI_STATE_INIT_DISPLAY       0 /*!< RW - Init display and load font, menu etc. */
#define UI_STATE_INIT_LOW_BATTERY   1 /*!< R  - Low battery voltage at power on */
#define UI_STATE_INIT_INTRO         2 /*!< R  - Display intro */
#define UI_STATE_INIT_WAIT          3 /*!< RW - Wait for initialization end */
#define UI_STATE_INIT_MENU          4 /*!< RW - Init menu system */
#define UI_STATE_NEXT_MENU          5 /*!< RW - Next menu icons ready for drawing */
#define UI_STATE_DRAW_MENU          6 /*!< RW - Execute function and draw menu icons */
#define UI_STATE_TEST_BUTTONS       7 /*!< RW - Wait for buttons to be pressed */
#define UI_STATE_LEFT_PRESSED       8 /*!< RW - Load selected function and next menu id */
#define UI_STATE_RIGHT_PRESSED      9 /*!< RW - Load selected function and next menu id */
#define UI_STATE_ENTER_PRESSED     10 /*!< RW - Load selected function and next menu id */
#define UI_STATE_EXIT_PRESSED      11 /*!< RW - Load selected function and next menu id */
#define UI_STATE_CONNECT_REQUEST   12 /*!< RW - Request for connection accept */
#define UI_STATE_EXECUTE_FILE      13 /*!< RW - Execute file in "LMSfilename" */
#define UI_STATE_EXECUTING_FILE    14 /*!< R  - Executing file in "LMSfilename" */
#define UI_STATE_LOW_BATTERY       15 /*!< R  - Low battery at runtime */
#define UI_STATE_BT_ERROR          16 /*!< R  - BT error */
/** @} */  // end of UiStateConstants group

/** @defgroup UiButtonConstants UIButton constants
 * Constants for use with the UIButton() function.
 * \sa UIButton()
 * @{
 */
#define UI_BUTTON_NONE             0 /*!< R  - Button inserted are executed */
#define UI_BUTTON_LEFT             1 /*!< W  - Insert left arrow button */
#define UI_BUTTON_ENTER            2 /*!< W  - Insert enter button */
#define UI_BUTTON_RIGHT            3 /*!< W  - Insert right arrow button */
#define UI_BUTTON_EXIT             4 /*!< W  - Insert exit button */
/** @} */  // end of UiButtonConstants group

/** @defgroup UiBluetoothStateConstants BluetoothState constants
 * Constants for use with the BluetoothState() function.
 * \sa BluetoothState()
 * @{
 */
#define UI_BT_STATE_VISIBLE        0x01 /*!< RW - BT visible */
#define UI_BT_STATE_CONNECTED      0x02 /*!< RW - BT connected to something */
#define UI_BT_STATE_OFF            0x04 /*!< RW - BT power off */
#define UI_BT_ERROR_ATTENTION      0x08 /*!< W  - BT error attention */
#define UI_BT_CONNECT_REQUEST      0x40 /*!< RW - BT get connect accept in progress */
#define UI_BT_PIN_REQUEST          0x80 /*!< RW - BT get pin code */
/** @} */  // end of UiBluetoothStateConstants group

/** @defgroup UiVMRunStateConstants VM run state constants
 * Constants for use with the VMRunState() function.
 * \sa VMRunState()
 * @{
 */
#define UI_VM_IDLE        0 /*!< VM_IDLE: Just sitting around.  Request to run program will lead to ONE of the VM_RUN* states. */
#define UI_VM_RUN_FREE    1 /*!< VM_RUN_FREE: Attempt to run as many instructions as possible within our timeslice */
#define UI_VM_RUN_SINGLE  2 /*!< VM_RUN_SINGLE: Run exactly one instruction per timeslice */
#define UI_VM_RUN_PAUSE   3 /*!< VM_RUN_PAUSE: Program still "active", but someone has asked us to pause */
#define UI_VM_RESET1      4 /*!< VM_RESET1: Initialize state variables and some I/O devices -- executed when programs end */
#define UI_VM_RESET2      5 /*!< VM_RESET2: Final clean up and return to IDLE */
/** @} */  // end of UiVMRunStateConstants group

/** @defgroup UiIOMAP Ui module IOMAP offsets
 * Constant offsets into the Ui module IOMAP structure.
 * @{
 */
#define UIOffsetPMenu            0 /*!< W  - Pointer to menu file (4 bytes) */
#define UIOffsetBatteryVoltage   4 /*!< R  - Battery voltage in millivolts (2 bytes) */
#define UIOffsetLMSfilename      6 /*!< W  - LMS filename to execute (Try It) (20 bytes) */
#define UIOffsetFlags           26 /*!< RW - Update command flags  (flags enumerated above) (1 byte) */
#define UIOffsetState           27 /*!< RW - UI state              (states enumerated above) (1 byte) */
#define UIOffsetButton          28 /*!< RW - Insert button         (buttons enumerated above) (1 byte) */
#define UIOffsetRunState        29 /*!< W  - VM Run state          (0 = stopped, 1 = running) (1 byte) */
#define UIOffsetBatteryState    30 /*!< W  - Battery state         (0..4 capacity) (1 byte) */
#define UIOffsetBluetoothState  31 /*!< W  - Bluetooth state       (0=on, 1=visible, 2=conn, 3=conn.visible, 4=off, 5=dfu) (1 byte) */
#define UIOffsetUsbState        32 /*!< W  - Usb state             (0=disconnected, 1=connected, 2=working) (1 byte) */
#define UIOffsetSleepTimeout    33 /*!< RW - Sleep timeout time    (min) (1 byte) */
#define UIOffsetSleepTimer      34 /*!< RW - Sleep timer           (min) (1 byte) */
#define UIOffsetRechargeable    35 /*!< R  - Rechargeable battery  (0 = no, 1 = yes) (1 byte) */
#define UIOffsetVolume          36 /*!< RW - Volume used in UI     (0 - 4) (1 byte) */
#define UIOffsetError           37 /*!< W  - Error code (1 byte) */
#define UIOffsetOBPPointer      38 /*!< W  - Actual OBP step       (0 - 4) (1 byte) */
#define UIOffsetForceOff        39 /*!< W  - Force off             (> 0 = off) (1 byte) */
#define UIOffsetAbortFlag       40 /*!< RW - Long Abort            (true == use long press to abort) (1 byte) */
/** @} */  // end of UiIOMAP group

/** @} */  // end of UiModuleConstants group
/** @} */  // end of UiModule group


/** @addtogroup InputModule
 * @{
 */
/** @addtogroup InputModuleConstants
 * @{
 */

/** @defgroup NBCInputPortConstants NBC Input port constants
 * Input port constants are used when calling sensor control API functions.
 * These constants are intended for use in NBC.
 * \sa SetSensorType(), SetSensorMode(), S1, S2, S3, S4
 * @{
 */
#define IN_1 0x00 /*!< Input port 1 */
#define IN_2 0x01 /*!< Input port 2 */
#define IN_3 0x02 /*!< Input port 3 */
#define IN_4 0x03 /*!< Input port 4 */
/** @} */  // end of InputPortConstants group

/** @addtogroup InputModuleTypesAndModes
 * @{
 */
/** @defgroup NBCSensorTypeConstants NBC sensor type constants
 * Use sensor type constants to configure an input port for a specific type
 * of sensor. These constants are intended for use in NBC.
 * \sa SetSensorType()
 * @{
 */
#define IN_TYPE_NO_SENSOR      0x00 /*!< No sensor configured */
#define IN_TYPE_SWITCH         0x01 /*!< NXT or RCX touch sensor */
#define IN_TYPE_TEMPERATURE    0x02 /*!< RCX temperature sensor */
#define IN_TYPE_REFLECTION     0x03 /*!< RCX light sensor */
#define IN_TYPE_ANGLE          0x04 /*!< RCX rotation sensor */
#define IN_TYPE_LIGHT_ACTIVE   0x05 /*!< NXT light sensor with light */
#define IN_TYPE_LIGHT_INACTIVE 0x06 /*!< NXT light sensor without light */
#define IN_TYPE_SOUND_DB       0x07 /*!< NXT sound sensor with dB scaling */
#define IN_TYPE_SOUND_DBA      0x08 /*!< NXT sound sensor with dBA scaling */
#define IN_TYPE_CUSTOM         0x09 /*!< NXT custom sensor */
#define IN_TYPE_LOWSPEED       0x0A /*!< NXT I2C digital sensor */
#define IN_TYPE_LOWSPEED_9V    0x0B /*!< NXT I2C digital sensor with 9V power */
#define IN_TYPE_HISPEED        0x0C /*!< NXT Hi-speed port (only S4) */
#if __FIRMWARE_VERSION > 107
#define IN_TYPE_COLORFULL      0x0D /*!< NXT 2.0 color sensor in full color mode */
#define IN_TYPE_COLORRED       0x0E /*!< NXT 2.0 color sensor with red light */
#define IN_TYPE_COLORGREEN     0x0F /*!< NXT 2.0 color sensor with green light */
#define IN_TYPE_COLORBLUE      0x10 /*!< NXT 2.0 color sensor with blue light */
#define IN_TYPE_COLORNONE      0x11 /*!< NXT 2.0 color sensor with no light */
#define IN_TYPE_COLOREXIT      0x12 /*!< NXT 2.0 color sensor internal state */
#endif
/** @} */  // end of NBCSensorTypeConstants group

/** @defgroup NBCSensorModeConstants NBC sensor mode constants
 * Use sensor mode constants to configure an input port for the desired
 * sensor mode. The constants are intended for use in NBC.
 * \sa SetSensorMode()
 * @{
 */
#define IN_MODE_RAW           0x00 /*!< Raw value from 0 to 1023 */
#define IN_MODE_BOOLEAN       0x20 /*!< Boolean value (0 or 1) */
#define IN_MODE_TRANSITIONCNT 0x40 /*!< Counts the number of boolean transitions */
#define IN_MODE_PERIODCOUNTER 0x60 /*!< Counts the number of boolean periods */
#define IN_MODE_PCTFULLSCALE  0x80 /*!< Scaled value from 0 to 100 */
#define IN_MODE_CELSIUS       0xA0 /*!< RCX temperature sensor value in degrees celcius */
#define IN_MODE_FAHRENHEIT    0xC0 /*!< RCX temperature sensor value in degrees fahrenheit */
#define IN_MODE_ANGLESTEP     0xE0 /*!< RCX rotation sensor (16 ticks per revolution) */
#define IN_MODE_SLOPEMASK     0x1F /*!< Mask for slope parameter added to mode */
#define IN_MODE_MODEMASK      0xE0 /*!< Mask for the mode without any slope value */
/** @} */  // end of NBCSensorModeConstants group
/** @} */  // end of InputModuleTypesAndModes group

/** @defgroup InputFieldConstants Input field constants
 * Constants for use with SetInput() and GetInput().
 * Each sensor has six fields that are used to define its state.
 * @{
 */
#define TypeField            0 /*!< Type field. Contains one of the sensor type constants. Read/write. */
#define InputModeField       1 /*!< Input mode field. Contains one of the sensor mode constants. Read/write. */
#define RawValueField        2 /*!< Raw value field. Contains the current raw analog sensor value. Read only. */
#define NormalizedValueField 3 /*!< Normalized value field. Contains the current normalized analog sensor value. Read only. */
#define ScaledValueField     4 /*!< Scaled value field. Contains the current scaled analog sensor value. Read/write. */
#define InvalidDataField     5 /*!< Invalid data field. Contains a boolean value indicating whether the sensor data is valid or not. Read/write. */
/** @} */  // end of InputFieldConstants group

/** @defgroup InputDigiPinConstants Input port digital pin constants
 * Constants for use when directly controlling or reading a port's digital pin
 * state.
 * @{
 */
#define INPUT_DIGI0    0x01 /*!< Digital pin 0 */
#define INPUT_DIGI1    0x02 /*!< Digital pin 1*/
/** @} */  // end of InputDigiPinConstants group

#define INPUT_CUSTOMINACTIVE 0x00 /*!< Custom sensor inactive */
#define INPUT_CUSTOM9V       0x01 /*!< Custom sensor 9V */
#define INPUT_CUSTOMACTIVE   0x02 /*!< Custom sensor active */

#define INPUT_INVALID_DATA   0x01 /*!< Invalid data flag */

#if __FIRMWARE_VERSION > 107

/** @defgroup InputColorIdxConstants Color sensor array indices
 * Constants for use with color sensor value arrays to index RGB and blank
 * return values.
 * \sa ReadSensorColorEx(), ReadSensorColorRaw(), SysColorSensorRead(),
 * ColorSensorReadType
 * @{
 */
#define INPUT_RED          0 /*!< Access the red value from color sensor value arrays */
#define INPUT_GREEN        1 /*!< Access the green value from color sensor value arrays */
#define INPUT_BLUE         2 /*!< Access the blue value from color sensor value arrays */
#define INPUT_BLANK        3 /*!< Access the blank value from color sensor value arrays */
#define INPUT_NO_OF_COLORS 4 /*!< The number of entries in the color sensor value arrays */
/** @} */  // end of InputColorIdxConstants group

/** @defgroup InputColorValueConstants Color values
 * Constants for use with the ColorValue returned by the color sensor in full
 * color mode.
 * \sa SensorValue(), SysColorSensorRead(), ColorSensorReadType
 * @{
 */
#define INPUT_BLACKCOLOR  1 /*!< The color value is black */
#define INPUT_BLUECOLOR   2 /*!< The color value is blue */
#define INPUT_GREENCOLOR  3 /*!< The color value is green */
#define INPUT_YELLOWCOLOR 4 /*!< The color value is yellow */
#define INPUT_REDCOLOR    5 /*!< The color value is red */
#define INPUT_WHITECOLOR  6 /*!< The color value is white */
/** @} */  // end of InputColorIdxConstants group

/** @defgroup InputColorCalibrationStateConstants Color calibration state constants
 * Constants for use with the color calibration state function.
 * \sa ColorCalibrationState()
 * @{
 */
#define INPUT_SENSORCAL  0x01 /*!< The state returned while the color sensor is calibrating */
#define INPUT_SENSOROFF  0x02 /*!< The state returned once calibration has completed */
#define INPUT_RUNNINGCAL 0x20 /*!< Unused calibration state constant */
#define INPUT_STARTCAL   0x40 /*!< Unused calibration state constant */
#define INPUT_RESETCAL   0x80 /*!< Unused calibration state constant */
/** @} */  // end of InputColorCalibrationStateConstants group

/** @defgroup InputColorCalibrationConstants Color calibration constants
 * Constants for use with the color calibration functions.
 * \sa ColorCalibration(), ColorCalLimits()
 * @{
 */
#define INPUT_CAL_POINT_0  0 /*!< Calibration point 0 */
#define INPUT_CAL_POINT_1  1 /*!< Calibration point 1 */
#define INPUT_CAL_POINT_2  2 /*!< Calibration point 2 */
#define INPUT_NO_OF_POINTS 3 /*!< The number of calibration points */
/** @} */  // end of InputColorCalibrationConstants group

#endif

/** @defgroup InputIOMAP Input module IOMAP offsets
 * Constant offsets into the Input module IOMAP structure.
 * @{
 */
#define InputOffsetCustomZeroOffset(p)   (((p)*20)+0)  /*!< Read/write the zero offset of a custom sensor (2 bytes) uword */
#define InputOffsetADRaw(p)              (((p)*20)+2)  /*!< Read the AD raw sensor value (2 bytes) uword */
#define InputOffsetSensorRaw(p)          (((p)*20)+4)  /*!< Read the raw sensor value (2 bytes) uword */
#define InputOffsetSensorValue(p)        (((p)*20)+6)  /*!< Read/write the scaled sensor value (2 bytes) sword */
#define InputOffsetSensorType(p)         (((p)*20)+8)  /*!< Read/write the sensor type */
#define InputOffsetSensorMode(p)         (((p)*20)+9)  /*!< Read/write the sensor mode */
#define InputOffsetSensorBoolean(p)      (((p)*20)+10) /*!< Read the sensor boolean value */
#define InputOffsetDigiPinsDir(p)        (((p)*20)+11) /*!< Read/write the direction of the Digital pins (1 is output, 0 is input) */
#define InputOffsetDigiPinsIn(p)         (((p)*20)+12) /*!< Read/write the status of the digital pins */
#define InputOffsetDigiPinsOut(p)        (((p)*20)+13) /*!< Read/write the output level of the digital pins */
#define InputOffsetCustomPctFullScale(p) (((p)*20)+14) /*!< Read/write the Pct full scale of the custom sensor */
#define InputOffsetCustomActiveStatus(p) (((p)*20)+15) /*!< Read/write the active or inactive state of the custom sensor */
#define InputOffsetInvalidData(p)        (((p)*20)+16) /*!< Indicates whether data is invalid (1) or valid (0) */

#if __FIRMWARE_VERSION > 107
#define InputOffsetColorCalibration(p, np, nc) (80+((p)*84)+0+((np)*16)+((nc)*4)) /*!< Read/write color calibration point values */
#define InputOffsetColorCalLimits(p, np)       (80+((p)*84)+48+((np)*2)) /*!< Read/write color calibration limits */
#define InputOffsetColorADRaw(p, nc)           (80+((p)*84)+52+((nc)*2)) /*!< Read AD raw color sensor values */
#define InputOffsetColorSensorRaw(p, nc)       (80+((p)*84)+60+((nc)*2)) /*!< Read raw color sensor values */
#define InputOffsetColorSensorValue(p, nc)     (80+((p)*84)+68+((nc)*2)) /*!< Read scaled color sensor values */
#define InputOffsetColorBoolean(p, nc)         (80+((p)*84)+76+((nc)*2)) /*!< Read color sensor boolean values */
#define InputOffsetColorCalibrationState(p)    (80+((p)*84)+80)          /*!< Read color sensor calibration state */
#endif
/** @} */  // end of InputIOMap group
/** @} */  // end of InputModuleConstants group
/** @} */  // end of InputModule group


/** @addtogroup OutputModule
 * @{
 */
/** @addtogroup OutputModuleConstants
 * @{
 */
/** @defgroup OutputPortConstants Output port constants
 * Output port constants are used when calling motor control API functions.
 * @{
 */
#define OUT_A   0x00 /*!< Output port A */
#define OUT_B   0x01 /*!< Output port B */
#define OUT_C   0x02 /*!< Output port C */
#define OUT_AB  0x03 /*!< Output ports A and B */
#define OUT_AC  0x04 /*!< Output ports A and C */
#define OUT_BC  0x05 /*!< Output ports B and C */
#define OUT_ABC 0x06 /*!< Output ports A, B, and C */
/** @} */  // end of OutputPortConstants group

/** @defgroup PIDConstants PID constants
 * PID constants are for adjusting the Proportional, Integral, and Derivative
 * motor controller parameters.
 * \sa RotateMotorExPID(), RotateMotorPID(), OnFwdExPID(), OnRevExPID(),
 * \sa OnFwdRegExPID(), OnRevRegExPID(), OnFwdRegPID(), OnRevRegPID(),
 * \sa OnFwdSyncExPID(), OnRevSyncExPID(), OnFwdSyncPID(), OnRevSyncPID()
 * @{
 */
#define PID_0   0 /*!< PID zero */
#define PID_1  32 /*!< PID one */
#define PID_2  64 /*!< PID two */
#define PID_3  96 /*!< PID three */
#define PID_4 128 /*!< PID four */
#define PID_5 160 /*!< PID five */
#define PID_6 192 /*!< PID six */
#define PID_7 224 /*!< PID seven */
/** @} */  // end of PIDConstants group

/** @defgroup OutUFConstants Output port update flag constants
 * Use these constants to specify which motor values need to be updated.
 * Update flag constants can be combined with bitwise OR.
 * \sa SetOutput()
 * @{
 */
#define UF_UPDATE_MODE                 0x01 /*!< Commits changes to the \ref OutputModeField output property */
#define UF_UPDATE_SPEED                0x02 /*!< Commits changes to the \ref PowerField output property */
#define UF_UPDATE_TACHO_LIMIT          0x04 /*!< Commits changes to the \ref TachoLimitField output property */
#define UF_UPDATE_RESET_COUNT          0x08 /*!< Resets all rotation counters, cancels the current goal, and resets the rotation error-correction system */
#define UF_UPDATE_PID_VALUES           0x10 /*!< Commits changes to the PID motor regulation properties */
#define UF_UPDATE_RESET_BLOCK_COUNT    0x20 /*!< Resets the NXT-G block-relative rotation counter */
#define UF_UPDATE_RESET_ROTATION_COUNT 0x40 /*!< Resets the program-relative (user) rotation counter */
#define UF_PENDING_UPDATES             0x80 /*!< Are there any pending motor updates? */
/** @} */  // end of OutUFConstants group

/** @defgroup TachoResetConstants Tachometer counter reset flags
 * Use these constants to specify which of the three tachometer counters
 * should be reset. Reset constants can be combined with bitwise OR.
 * \sa OnFwdEx(), OnRevEx(), etc...
 * @{
 */
#define RESET_NONE           0x00 /*!< No counters will be reset */
#define RESET_COUNT          0x08 /*!< Reset the internal tachometer counter */
#define RESET_BLOCK_COUNT    0x20 /*!< Reset the NXT-G block tachometer counter */
#define RESET_ROTATION_COUNT 0x40 /*!< Reset the rotation counter */
#define RESET_BLOCKANDTACHO  0x28 /*!< Reset both the internal counter and the NXT-G block counter */
#define RESET_ALL            0x68 /*!< Reset all three tachometer counters */
/** @} */  // end of TachoResetConstants group

/** @defgroup OutModeConstants Output port mode constants
 * Use these constants to configure the desired mode for the
 * specified motor(s): coast, motoron, brake, or regulated. Mode constants
 * can be combined with bitwise OR.
 * \sa SetOutput()
 * @{
 */
#define OUT_MODE_COAST     0x00 /*!< No power and no braking so motors rotate freely. */
#define OUT_MODE_MOTORON   0x01 /*!< Enables PWM power to the outputs given the power setting */
#define OUT_MODE_BRAKE     0x02 /*!< Uses electronic braking to outputs */
#define OUT_MODE_REGULATED 0x04 /*!< Enables active power regulation using the regulation mode value */
#define OUT_MODE_REGMETHOD 0xF0 /*!< Mask for unimplemented regulation mode */
/** @} */  // end of OutModeConstants group

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/** @defgroup OutOptionConstants Output port option constants
 * Use these constants to configure the desired options for the
 * specified motor(s): hold at limit and ramp down to limit. Option constants
 * can be combined with bitwise OR.
 * \sa SetOutput()
 * @{
 */
#define OUT_OPTION_HOLDATLIMIT     0x10 /*!< Option to have the firmware hold the motor when it reaches the tachometer limit */
#define OUT_OPTION_RAMPDOWNTOLIMIT 0x20 /*!< Option to have the firmware rampdown the motor power as it approaches the tachometer limit */
/** @} */  // end of OutOptionConstants group

/** @defgroup OutRegOptionConstants Output regulation option constants
 * Use these constants to configure the desired options for
 * position regulation.
 * @{
 */
#define OUT_REGOPTION_NO_SATURATION 0x01 /*!< Do not limit intermediary regulation results */
/** @} */  // end of OutRegOptionConstants group
#endif

/** @defgroup OutRunStateConstants Output port run state constants
 * Use these constants to configure the desired run state for the
 * specified motor(s): idle, rampup, running, rampdown, or hold.
 * \sa SetOutput()
 * @{
 */
#define OUT_RUNSTATE_IDLE     0x00 /*!< Disable all power to motors. */
#define OUT_RUNSTATE_RAMPUP   0x10 /*!< Enable ramping up from a current power to a new (higher) power over a specified \ref TachoLimitField goal. */
#define OUT_RUNSTATE_RUNNING  0x20 /*!< Enable power to motors at the specified power level. */
#define OUT_RUNSTATE_RAMPDOWN 0x40 /*!< Enable ramping down from a current power to a new (lower) power over a specified \ref TachoLimitField goal. */
#define OUT_RUNSTATE_HOLD     0x60 /*!< Set motor run state to hold at the current position. */
/** @} */  // end of OutRunStateConstants group

/** @defgroup OutRegModeConstants Output port regulation mode constants
 * Use these constants to configure the desired regulation mode for the
 * specified motor(s): none, speed regulation, multi-motor synchronization,
 * or position regulation (requires the enhanced NBC/NXC firmware version 1.31+).
 * \sa SetOutput()
 * @{
 */
#define OUT_REGMODE_IDLE  0 /*!< No motor regulation. */
#define OUT_REGMODE_SPEED 1 /*!< Regulate a motor's speed (aka power). */
#define OUT_REGMODE_SYNC  2 /*!< Synchronize the rotation of two motors. */
#define OUT_REGMODE_POS   4 /*!< Regulate a motor's position. */
/** @} */  // end of OutRegModeConstants group

/** @defgroup OutputFieldConstants Output field constants
 * Constants for use with SetOutput() and GetOutput().
 * \sa SetOutput(), GetOutput()
 * @{
 */
/** Update flags field. Contains a combination of the update flag constants. Read/write.
 *  Use \ref UF_UPDATE_MODE, \ref UF_UPDATE_SPEED, \ref UF_UPDATE_TACHO_LIMIT, and \ref UF_UPDATE_PID_VALUES
 *  along with other fields to commit changes to the state of outputs. Set the appropriate
 *  flags after setting one or more of the output fields in order for the changes to actually
 *  go into affect. */
#define UpdateFlagsField     0
/** Mode field. Contains a combination of the output mode constants. Read/write.
 *  The \ref OUT_MODE_MOTORON bit must be set in order for power to be applied to the motors.
 *  Add \ref OUT_MODE_BRAKE to enable electronic braking. Braking means that the output voltage
 *  is not allowed to float between active PWM pulses. It improves the accuracy of motor
 *  output but uses more battery power.
 *  To use motor regulation include \ref OUT_MODE_REGULATED in the \ref OutputModeField value. Use
 *  \ref UF_UPDATE_MODE with \ref UpdateFlagsField to commit changes to this field. */
#define OutputModeField      1
/** Power field. Contains the desired power level (-100 to 100). Read/write.
 *  Specify the power level of the output. The absolute value of PowerField is a percentage of the
 *  full power of the motor. The sign of PowerField controls the rotation direction. Positive values
 *  tell the firmware to turn the motor forward, while negative values turn the motor backward.
 *  Use \ref UF_UPDATE_SPEED with \ref UpdateFlagsField to commit changes to this field. */
#define PowerField           2
/** Actual speed field. Contains the actual power level (-100 to 100). Read only.
 *  Return the percent of full power the firmware is applying to the output. This may vary from the
 *  PowerField value when auto-regulation code in the firmware responds to a load on the output. */
#define ActualSpeedField     3
/** Internal tachometer count field. Contains the current internal tachometer count. Read only.
 *  Return the internal position counter value for the specified output. The internal count is reset
 *  automatically when a new goal is set using the \ref TachoLimitField and the \ref UF_UPDATE_TACHO_LIMIT flag.
 *  Set the \ref UF_UPDATE_RESET_COUNT flag in \ref UpdateFlagsField to reset TachoCountField and cancel any \ref TachoLimitField.
 *  The sign of TachoCountField indicates the motor rotation direction. */
#define TachoCountField      4
/** Tachometer limit field. Contains the current tachometer limit. Read/write.
 *  Specify the number of degrees the motor should rotate.
 *  Use \ref UF_UPDATE_TACHO_LIMIT with the \ref UpdateFlagsField field to commit changes to the TachoLimitField.
 *  The value of this field is a relative distance from the current motor position at the moment when
 *  the \ref UF_UPDATE_TACHO_LIMIT flag is processed. */
#define TachoLimitField      5
/** Run state field. Contains one of the run state constants. Read/write.
 *  Use this field to specify the running state of an output. Set the RunStateField to \ref OUT_RUNSTATE_RUNNING
 *  to enable power to any output. Use \ref OUT_RUNSTATE_RAMPUP to enable automatic ramping to a new \ref PowerField
 *  level greater than the current \ref PowerField level. Use \ref OUT_RUNSTATE_RAMPDOWN to enable automatic ramping
 *  to a new \ref PowerField level less than the current \ref PowerField level.
 *  Both the rampup and rampdown bits must be used in conjunction with appropriate \ref TachoLimitField and \ref PowerField
 *  values. In this case the firmware smoothly increases or decreases the actual power to the new \ref PowerField
 *  level over the total number of degrees of rotation specified in \ref TachoLimitField. */
#define RunStateField        6
/** Turn ratio field. Contains the current turn ratio. Only applicable when synchronizing multiple motors. Read/write.
 *  Use this field to specify a proportional turning ratio. This field must be used in conjunction with other
 *  field values: \ref OutputModeField must include \ref OUT_MODE_MOTORON and \ref OUT_MODE_REGULATED, \ref RegModeField must be set to
 *  \ref OUT_REGMODE_SYNC, \ref RunStateField must not be \ref OUT_RUNSTATE_IDLE, and \ref PowerField must be non-zero.
 *  There are only three valid combinations of left and right motors for use with TurnRatioField: \ref OUT_AB, \ref OUT_BC,
 *  and \ref OUT_AC. In each of these three options the first motor listed is considered to be the left motor and
 *  the second motor is the right motor, regardless of the physical configuration of the robot.
 *  Negative turn ratio values shift power toward the left motor while positive values shift power toward the
 *  right motor. An absolute value of 50 usually results in one motor stopping. An absolute value of 100 usually
 *  results in two motors turning in opposite directions at equal power. */
#define TurnRatioField       7
/** Regulation mode field. Contains one of the regulation mode constants. Read/write.
 *  This field specifies the regulation mode to use with the specified port(s). It is ignored if
 *  the \ref OUT_MODE_REGULATED bit is not set in the \ref OutputModeField field. Unlike \ref OutputModeField, RegModeField is
 *  not a bitfield. Only one regulation mode value can be set at a time.
 *  Speed regulation means that the firmware tries to maintain a certain speed based on the \ref PowerField setting. The
 *  firmware adjusts the PWM duty cycle if the motor is affected by a physical load. This adjustment is
 *  reflected by the value of the \ref ActualSpeedField property. When using speed regulation, do not set \ref PowerField to its
 *  maximum value since the firmware cannot adjust to higher power levels in that situation.
 *  Synchronization means the firmware tries to keep two motors in sync regardless of physical loads. Use
 *  this mode to maintain a straight path for a mobile robot automatically. Also use this mode with the
 *  \ref TurnRatioField property to provide proportional turning.
 *  Set \ref OUT_REGMODE_SYNC on at least two motor ports in order for synchronization to function. Setting
 *  \ref OUT_REGMODE_SYNC on all three motor ports will result in only the first two (\ref OUT_A and \ref OUT_B) being
 *  synchronized. */
#define RegModeField         8
/** Overload field. Contains a boolean value which is TRUE if the motor is overloaded. Read only.
 *  This field will have a value of 1 (true) if the firmware speed regulation cannot overcome a physical
 *  load on the motor. In other words, the motor is turning more slowly than expected.
 *  If the motor speed can be maintained in spite of loading then this field value is zero (false).
 *  In order to use this field the motor must have a non-idle \ref RunStateField, an \ref OutputModeField which includes
 *  \ref OUT_MODE_MOTORON and \ref OUT_MODE_REGULATED, and its \ref RegModeField must be set to \ref OUT_REGMODE_SPEED. */
#define OverloadField        9
/** Proportional field. Contains the proportional constant for the PID motor controller. Read/write.
 *  This field specifies the proportional term used in the internal proportional-integral-derivative
 *  (PID) control algorithm.
 *  Set \ref UF_UPDATE_PID_VALUES to commit changes to RegPValue, RegIValue, and RegDValue simultaneously. */
#define RegPValueField       10
/** Integral field. Contains the integral constant for the PID motor controller. Read/write.
 *  This field specifies the integral term used in the internal proportional-integral-derivative
 *  (PID) control algorithm.
 *  Set \ref UF_UPDATE_PID_VALUES to commit changes to RegPValue, RegIValue, and RegDValue simultaneously. */
#define RegIValueField       11
/** Derivative field. Contains the derivative constant for the PID motor controller. Read/write.
 *  This field specifies the derivative term used in the internal proportional-integral-derivative
 *  (PID) control algorithm.
 *  Set \ref UF_UPDATE_PID_VALUES to commit changes to RegPValue, RegIValue, and RegDValue simultaneously. */
#define RegDValueField       12
/** NXT-G block tachometer count field. Contains the current NXT-G block tachometer count. Read only.
 *  Return the block-relative position counter value for the specified port.
 *  Refer to the \ref UpdateFlagsField description for information about how to use block-relative
 *  position counts.
 *  Set the \ref UF_UPDATE_RESET_BLOCK_COUNT flag in \ref UpdateFlagsField to request that the firmware
 *  reset the BlockTachoCountField.
 *  The sign of BlockTachoCountField indicates the direction of rotation. Positive values indicate
 *  forward rotation and negative values indicate reverse rotation. Forward and reverse depend on
 *  the orientation of the motor. */
#define BlockTachoCountField 13
/** Rotation counter field. Contains the current rotation count. Read only.
 *  Return the program-relative position counter value for the specified port.
 *  Refer to the \ref UpdateFlagsField description for information about how to use program-relative
 *  position counts.
 *  Set the \ref UF_UPDATE_RESET_ROTATION_COUNT flag in \ref UpdateFlagsField to request that the firmware reset
 *  the RotationCountField.
 *  The sign of RotationCountField indicates the direction of rotation. Positive values indicate forward
 *  rotation and negative values indicate reverse rotation. Forward and reverse depend on the
 *  orientation of the motor. */
#define RotationCountField   14
#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/** Options field. Contains a combination of the output options constants. Read/write.
 *  Set options for how the output module will act when a tachometer limit is reached. Option
 *  constants can be combined with bitwise OR.  Use OUT_OPTION_HOLDATLIMIT to have the output
 *  module hold the motor when it reaches the tachometer limit.  Use OUT_OPTION_RAMPDOWNTOLIMIT
 *  to have the output module ramp down the motor power as it approaches the tachometer limit.
 */
#define OutputOptionsField   15
/** MaxSpeed field. Contains the current max speed value. Read/write.
 *  Set the maximum speed to be used during position regulation.
 */
#define MaxSpeedField   16
/** MaxAcceleration field. Contains the current max acceleration value. Read/write.
 *  Set the maximum acceleration to be used during position regulation.
 */
#define MaxAccelerationField   17
#endif
/** @} */  // end of OutputFieldConstants group

/** @defgroup OutputIOMAP Output module IOMAP offsets
 * Constant offsets into the Output module IOMAP structure.
 * @{
 */
#define OutputOffsetTachoCount(p)        (((p)*32)+0)  /*!< R  - Holds current number of counts, since last reset, updated every 1 mS (4 bytes) slong */
#define OutputOffsetBlockTachoCount(p)   (((p)*32)+4)  /*!< R  - Holds current number of counts for the current output block (4 bytes) slong */
#define OutputOffsetRotationCount(p)     (((p)*32)+8)  /*!< R  - Holds current number of counts for the rotation counter to the output (4 bytes) slong */
#define OutputOffsetTachoLimit(p)        (((p)*32)+12) /*!< RW - Holds number of counts to travel, 0 => Run forever (4 bytes) ulong */
#define OutputOffsetMotorRPM(p)          (((p)*32)+16) /*!< Not updated, will be removed later !! (2 bytes) sword */
#define OutputOffsetFlags(p)             (((p)*32)+18) /*!< RW - Holds flags for which data should be updated (1 byte) ubyte */
#define OutputOffsetMode(p)              (((p)*32)+19) /*!< RW - Holds motor mode: Run, Break, regulated, ... (1 byte) ubyte */
#define OutputOffsetSpeed(p)             (((p)*32)+20) /*!< RW - Holds the wanted speed (1 byte) sbyte */
#define OutputOffsetActualSpeed(p)       (((p)*32)+21) /*!< R  - Holds the current motor speed (1 byte) sbyte */
#define OutputOffsetRegPParameter(p)     (((p)*32)+22) /*!< RW - Holds the P-constant used in the regulation (1 byte) ubyte */
#define OutputOffsetRegIParameter(p)     (((p)*32)+23) /*!< RW - Holds the I-constant used in the regulation (1 byte) ubyte */
#define OutputOffsetRegDParameter(p)     (((p)*32)+24) /*!< RW - Holds the D-constant used in the regulation (1 byte) ubyte */
#define OutputOffsetRunState(p)          (((p)*32)+25) /*!< RW - Holds the current motor run state in the output module (1 byte) ubyte */
#define OutputOffsetRegMode(p)           (((p)*32)+26) /*!< RW - Tells which regulation mode should be used (1 byte) ubyte */
#define OutputOffsetOverloaded(p)        (((p)*32)+27) /*!< R  - True if the motor has been overloaded within speed control regulation (1 byte) ubyte */
#define OutputOffsetSyncTurnParameter(p) (((p)*32)+28) /*!< RW - Holds the turning parameter need within MoveBlock (1 byte) sbyte */
#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
#define OutputOffsetOptions(p)           (((p)*32)+29) /*!< RW - holds extra motor options related to the tachometer limit (1 byte) ubyte  (NBC/NXC) */
#define OutputOffsetMaxSpeed(p)          (((p)*32)+30) /*!< RW - holds the maximum speed for position regulation (1 byte) sbyte  (NBC/NXC) */
#define OutputOffsetMaxAccel(p)          (((p)*32)+31) /*!< RW - holds the maximum acceleration for position regulation (1 byte) sbyte  (NBC/NXC) */
#endif
#define OutputOffsetRegulationTime       96 /*!< use for frequency of checking regulation mode (1 byte) ubyte (NBC/NXC) */
#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
#define OutputOffsetRegulationOptions    97 /*!< use for position regulation options (1 byte) ubyte (NBC/NXC) */
#endif
/** @} */  // end of OutputIOMAP group
/** @} */  // end of OutputModuleConstants group
/** @} */  // end of OutputModule group


/** @addtogroup LowSpeedModule
 * @{
 */
/** @defgroup LowSpeedModuleConstants LowSpeed module constants
 * Constants that are part of the NXT firmware's LowSpeed module.
 * @{
 */
/** @defgroup LowSpeedStateConstants LSState constants
 * Constants for the low speed module LSState function. These values are
 * combined together using a bitwise OR operation.
 * \sa LSState()
 * @{
 */
#define COM_CHANNEL_NONE_ACTIVE  0x00 /*!< None of the low speed channels are active */
#define COM_CHANNEL_ONE_ACTIVE   0x01 /*!< Low speed channel 1 is active */
#define COM_CHANNEL_TWO_ACTIVE   0x02 /*!< Low speed channel 2 is active */
#define COM_CHANNEL_THREE_ACTIVE 0x04 /*!< Low speed channel 3 is active */
#define COM_CHANNEL_FOUR_ACTIVE  0x08 /*!< Low speed channel 4 is active */
/** @} */  // end of LowSpeedStateConstants group

/** @defgroup LowSpeedChannelStateConstants LSChannelState constants
 * Constants for the low speed module LSChannelState function.
 * \sa LSChannelState()
 * @{
 */
#define LOWSPEED_IDLE          0 /*!< Channel is idle */
#define LOWSPEED_INIT          1 /*!< Channel is being initialized */
#define LOWSPEED_LOAD_BUFFER   2 /*!< Channel buffer is loading */
#define LOWSPEED_COMMUNICATING 3 /*!< Channel is actively communicating */
#define LOWSPEED_ERROR         4 /*!< Channel is in an error state */
#define LOWSPEED_DONE          5 /*!< Channel is done communicating */
/** @} */  // end of LowSpeedChannelStateConstants group

/** @defgroup LowSpeedModeConstants LSMode constants
 * Constants for the low speed module LSMode function.
 * \sa LSMode()
 * @{
 */
#define LOWSPEED_TRANSMITTING   1 /*!< Lowspeed port is in transmitting mode */
#define LOWSPEED_RECEIVING      2 /*!< Lowspeed port is in receiving mode */
#define LOWSPEED_DATA_RECEIVED  3 /*!< Lowspeed port is in data received mode */
/** @} */  // end of LowSpeedModeConstants group

/** @defgroup LowSpeedErrorTypeConstants LSErrorType constants
 * Constants for the low speed module LSErrorType function.
 * \sa LSErrorType()
 * @{
 */
#define LOWSPEED_NO_ERROR     0 /*!< Lowspeed port has no error */
#define LOWSPEED_CH_NOT_READY 1 /*!< Lowspeed port is not ready */
#define LOWSPEED_TX_ERROR     2 /*!< Lowspeed port encountered an error while transmitting data */
#define LOWSPEED_RX_ERROR     3 /*!< Lowspeed port encountered an error while receiving data */
/** @} */  // end of LowSpeedErrorTypeConstants group

/** @defgroup LowSpeedIOMAP Low speed module IOMAP offsets
 * Constant offsets into the low speed module IOMAP structure.
 * @{
 */
#define LowSpeedOffsetInBufBuf(p)       (((p)*19)+0)  /*!< RW - Input buffer data buffer field offset (16 bytes) */
#define LowSpeedOffsetInBufInPtr(p)     (((p)*19)+16) /*!< RW - Input buffer in pointer field offset (1 byte) */
#define LowSpeedOffsetInBufOutPtr(p)    (((p)*19)+17) /*!< RW - Input buffer out pointer field offset (1 byte) */
#define LowSpeedOffsetInBufBytesToRx(p) (((p)*19)+18) /*!< RW - Input buffer bytes to receive field offset (1 byte) */

#define LowSpeedOffsetOutBufBuf(p)       (((p)*19)+76) /*!< RW - Output buffer data buffer field offset (16 bytes) */
#define LowSpeedOffsetOutBufInPtr(p)     (((p)*19)+92) /*!< RW - Output buffer in pointer field offset (1 byte) */
#define LowSpeedOffsetOutBufOutPtr(p)    (((p)*19)+93) /*!< RW - Output buffer out pointer field offset (1 byte) */
#define LowSpeedOffsetOutBufBytesToRx(p) (((p)*19)+94) /*!< RW - Output buffer bytes to receive field offset (1 byte) */

#define LowSpeedOffsetMode(p)            ((p)+152) /*!< R - Lowspeed port mode (1 byte) */
#define LowSpeedOffsetChannelState(p)    ((p)+156) /*!< R - Lowspeed channgel state (1 byte) */
#define LowSpeedOffsetErrorType(p)       ((p)+160) /*!< R - Lowspeed port error type (1 byte) */

#define LowSpeedOffsetState            164 /*!< R - Lowspeed state (all channels) */
#define LowSpeedOffsetSpeed            165 /*!< R - Lowspeed speed (unused) */

#ifdef __ENHANCED_FIRMWARE
#define LowSpeedOffsetNoRestartOnRead  166 /*!< RW - Lowspeed option for no restart on read (all channels) (NBC/NXC) */
#endif
/** @} */  // end of LowSpeedIOMAP group

/** @defgroup LowSpeedNoRestartConstants LSNoRestartOnRead constants
 * Constants for the low speed module LSNoRestartOnRead and
 * SetLSNoRestartOnRead functions. These values are combined with a bitwise
 * OR operation.
 * \sa LSNoRestartOnRead(), SetLSNoRestartOnRead()
 * @{
 */
#ifdef __ENHANCED_FIRMWARE
#define LSREAD_RESTART_ALL     0x00 /*!< Restart on read for all channels (default) */
#define LSREAD_NO_RESTART_1    0x01 /*!< No restart on read for channel 1 */
#define LSREAD_NO_RESTART_2    0x02 /*!< No restart on read for channel 2 */
#define LSREAD_NO_RESTART_3    0x04 /*!< No restart on read for channel 3 */
#define LSREAD_NO_RESTART_4    0x08 /*!< No restart on read for channel 4 */
#define LSREAD_RESTART_NONE    0x0F /*!< No restart on read for all channels */
#define LSREAD_NO_RESTART_MASK 0x10 /*!< No restart mask */
#endif
/** @} */  // end of LowSpeedNoRestartConstants group

/** @defgroup GenericI2CConstants Standard I2C constants
 * Constants for use with standard I2C devices.
 * @{
 */
#define I2C_ADDR_DEFAULT  0x02 /*!< Standard NXT I2C device address */
#define I2C_REG_VERSION   0x00 /*!< Standard NXT I2C version register */
#define I2C_REG_VENDOR_ID 0x08 /*!< Standard NXT I2C vendor ID register */
#define I2C_REG_DEVICE_ID 0x10 /*!< Standard NXT I2C device ID register */
#define I2C_REG_CMD       0x41 /*!< Standard NXT I2C device command register */
/** @} */  // end of GenericI2CConstants group

/** @defgroup LEGOI2CAddressConstants LEGO I2C address constants
 * Constants for LEGO I2C device addresses.
 * @{
 */
#define LEGO_ADDR_US         0x02 /*!< The LEGO ultrasonic sensor's I2C address */
#define LEGO_ADDR_TEMP       0x98 /*!< The LEGO temperature sensor's I2C address */
#define LEGO_ADDR_EMETER     0x04 /*!< The LEGO e-meter sensor's I2C address */
/** @} */  // end of LEGOI2CAddressConstants group

/** @defgroup USI2CConstants Ultrasonic sensor constants
 * Constants for use with the ultrasonic sensor.
 * @{
 */
#define US_CMD_OFF           0x00 /*!< Command to turn off the ultrasonic sensor */
#define US_CMD_SINGLESHOT    0x01 /*!< Command to put the ultrasonic sensor into single shot mode */
#define US_CMD_CONTINUOUS    0x02 /*!< Command to put the ultrasonic sensor into continuous polling mode (default) */
#define US_CMD_EVENTCAPTURE  0x03 /*!< Command to put the ultrasonic sensor into event capture mode */
#define US_CMD_WARMRESET     0x04 /*!< Command to warm reset the ultrasonic sensor */

#define US_REG_CM_INTERVAL   0x40 /*!< The register address used to store the CM interval */
#define US_REG_ACTUAL_ZERO   0x50 /*!< The register address used to store the actual zero value */
#define US_REG_SCALE_FACTOR  0x51 /*!< The register address used to store the scale factor value */
#define US_REG_SCALE_DIVISOR 0x52 /*!< The register address used to store the scale divisor value */

#define US_REG_FACTORY_ACTUAL_ZERO   0x11 /*!< The register address containing the factory setting for the actual zero value */
#define US_REG_FACTORY_SCALE_FACTOR  0x12 /*!< The register address containing the factory setting for the scale factor value */
#define US_REG_FACTORY_SCALE_DIVISOR 0x13 /*!< The register address containing the factory setting for the scale divisor value */
#define US_REG_MEASUREMENT_UNITS     0x14 /*!< The register address containing the measurement units (degrees C or F) */
/** @} */  // end of USI2CConstants group

/** @defgroup TempI2CConstants LEGO temperature sensor constants
 * Constants for use with the LEGO temperature sensor.
 * @{
 */
// R1/R0
#define TEMP_RES_9BIT      0x00 /*!< Set the temperature conversion resolution to 9 bit */
#define TEMP_RES_10BIT     0x20 /*!< Set the temperature conversion resolution to 10 bit */
#define TEMP_RES_11BIT     0x40 /*!< Set the temperature conversion resolution to 11 bit */
#define TEMP_RES_12BIT     0x60 /*!< Set the temperature conversion resolution to 12 bit */
// SD (shutdown mode)
#define TEMP_SD_CONTINUOUS 0x00 /*!< Set the sensor mode to continuous */
#define TEMP_SD_SHUTDOWN   0x01 /*!< Set the sensor mode to shutdown. The device will shut down after the current conversion is completed. */
// TM (thermostat mode)
#define TEMP_TM_COMPARATOR 0x00 /*!< Set the thermostat mode to comparator */
#define TEMP_TM_INTERRUPT  0x02 /*!< Set the thermostat mode to interrupt */
// OS (one shot)
#define TEMP_OS_ONESHOT    0x80 /*!< Set the sensor into oneshot mode. When the device is in shutdown mode this will start a single temperature conversion. The device returns to shutdown mode when it completes. */
// F1/F0 (fault queue)
#define TEMP_FQ_1          0x00 /*!< Set fault queue to 1 fault before alert */
#define TEMP_FQ_2          0x08 /*!< Set fault queue to 2 faults before alert */
#define TEMP_FQ_4          0x10 /*!< Set fault queue to 4 faults before alert */
#define TEMP_FQ_6          0x18 /*!< Set fault queue to 6 faults before alert */
// POL (polarity)
#define TEMP_POL_LOW       0x00 /*!< Set polarity of ALERT pin to be active LOW */
#define TEMP_POL_HIGH      0x04 /*!< Set polarity of ALERT pin to be active HIGH */

#define TEMP_REG_TEMP      0x00 /*!< The register where temperature values can be read */
#define TEMP_REG_CONFIG    0x01 /*!< The register for reading/writing sensor configuration values */
#define TEMP_REG_TLOW      0x02 /*!< The register for reading/writing a user-defined low temperature limit */
#define TEMP_REG_THIGH     0x03 /*!< The register for reading/writing a user-defined high temperature limit */
/** @} */  // end of TempI2CConstants group

/** @defgroup EMeterI2CConstants E-Meter sensor constants
 * Constants for use with the e-meter sensor.
 * @{
 */
#define EMETER_REG_VIN    0x0a /*!< The register address for voltage in */
#define EMETER_REG_AIN    0x0c /*!< The register address for amps in */
#define EMETER_REG_VOUT   0x0e /*!< The register address for voltage out */
#define EMETER_REG_AOUT   0x10 /*!< The register address for amps out */
#define EMETER_REG_JOULES 0x12 /*!< The register address for joules */
#define EMETER_REG_WIN    0x14 /*!< The register address for watts in */
#define EMETER_REG_WOUT   0x16 /*!< The register address for watts out */
/** @} */  // end of EMeterI2CConstants group

/** @} */  // end of LowSpeedModuleConstants group
/** @} */  // end of LowSpeedModule group


/** @addtogroup DisplayModule
 * @{
 */
/** @defgroup DisplayModuleConstants Display module constants
 * Constants that are part of the NXT firmware's Display module.
 * @{
 */
/** @defgroup DisplayExecuteFunctionConstants DisplayExecuteFunction constants
 * Constants that are for use with the DisplayExecuteFunction system call.
 * @{
 */
#define DISPLAY_ERASE_ALL       0x00     /*!< W - erase entire screen     (CMD,x,x,x,x,x) */
#define DISPLAY_PIXEL           0x01     /*!< W - set pixel (on/off)      (CMD,TRUE/FALSE,X,Y,x,x) */
#define DISPLAY_HORIZONTAL_LINE 0x02     /*!< W - draw horizontal line    (CMD,TRUE/FALSE,X1,Y1,X2,x) */
#define DISPLAY_VERTICAL_LINE   0x03     /*!< W - draw vertical line      (CMD,TRUE/FALSE,X1,Y1,x,Y2) */
#define DISPLAY_CHAR            0x04     /*!< W - draw char (actual font) (CMD,TRUE,X1,Y1,Char,x) */
#define DISPLAY_ERASE_LINE      0x05     /*!< W - erase a single line     (CMD,x,LINE,x,x,x) */
#define DISPLAY_FILL_REGION     0x06     /*!< W - fill screen region      (CMD,TRUE/FALSE,X1,Y1,X2,Y2) */
#define DISPLAY_FRAME           0x07     /*!< W - draw a frame (on/off)   (CMD,TRUE/FALSE,X1,Y1,X2,Y2) */
/** @} */  // end of DisplayExecuteFunctionConstants group

/** @defgroup DisplayDrawOptionConstants Drawing option constants
 * Constants that are for specifying drawing options in several display module API functions.
 * Bits 0 & 1 (values 0,1,2,3) control screen clearing behaviour (Not within RIC files).
 * Bit 2 (value 4) controls the NOT operation, i.e. draw in white or invert text/graphics.
 * Bits 3 & 4 (values 0,8,16,24) control pixel logical combinations (COPY/AND/OR/XOR).
 * Bit 5 (value 32) controls shape filling, or overrides text/graphic bitmaps with set pixels.
 * These may be ORed together for the full instruction
 * (e.g., DRAW_OPT_NORMAL|DRAW_OPT_LOGICAL_XOR)
 * These operations are resolved into the separate, common parameters
 * defined in 'c_display.iom' before any drawing function is called.
 * Note that when drawing a RIC file, the initial 'DrawingOptions' parameter
 * supplied in the drawing instruction controls screen clearing, but nothing else.
 * The 'CopyOptions' parameter from each instruction in the RIC file then controls
 * graphic operations, but the screen-clearing bits are ignored.
 * \sa TextOut(), NumOut(), PointOut(), LineOut(), CircleOut(), RectOut(),
 * PolyOut(), EllipseOut(), FontTextOut(), FontNumOut(), GraphicOut(),
 * GraphicArrayOut()
 * @{
 */
#define DRAW_OPT_NORMAL                     (0x0000) /*!< Normal drawing */
#define DRAW_OPT_CLEAR_WHOLE_SCREEN         (0x0001) /*!< Clear the entire screen before drawing */
#define DRAW_OPT_CLEAR_EXCEPT_STATUS_SCREEN (0x0002) /*!< Clear the screen except for the status line before drawing */

#define DRAW_OPT_CLEAR_PIXELS               (0x0004) /*!< Clear pixels while drawing (aka draw in white) */
#define DRAW_OPT_CLEAR                      (0x0004) /*!< Clear pixels while drawing (aka draw in white) */
#define DRAW_OPT_INVERT                     (0x0004) /*!< Invert text or graphics */

#define DRAW_OPT_LOGICAL_COPY               (0x0000) /*!< Draw pixels using a logical copy operation */
#define DRAW_OPT_LOGICAL_AND                (0x0008) /*!< Draw pixels using a logical AND operation */
#define DRAW_OPT_LOGICAL_OR                 (0x0010) /*!< Draw pixels using a logical OR operation */
#define DRAW_OPT_LOGICAL_XOR                (0x0018) /*!< Draw pixels using a logical XOR operation */

#define DRAW_OPT_FILL_SHAPE                 (0x0020) /*!< Fill the shape while drawing (rectangle, circle, ellipses, and polygon) */

#define DRAW_OPT_CLEAR_SCREEN_MODES         (0x0003) /*!< Bit mask for the clear screen modes */
#define DRAW_OPT_LOGICAL_OPERATIONS         (0x0018) /*!< Bit mask for the logical drawing operations */

#define DRAW_OPT_POLYGON_POLYLINE           (0x0400) /*!< When drawing polygons, do not close (i.e., draw a polyline instead) */

/** @defgroup DisplayFontDrawOptionConstants Font drawing option constants
 * These addition drawing option constants are only for use when drawing
 * text and numbers on the LCD using an RIC-based font.
 * \sa FontTextOut(), FontNumOut()
 * @{
 */
#define DRAW_OPT_FONT_DIRECTIONS            (0x01C0) /*!< Bit mask for the font direction bits */

#define DRAW_OPT_FONT_WRAP       (0x0200) /*!< Option to have text wrap in \ref FontNumOut and \ref FontTextOut calls */

#define DRAW_OPT_FONT_DIR_L2RB   (0x0000) /*!< Font left to right bottom align */
#define DRAW_OPT_FONT_DIR_L2RT   (0x0040) /*!< Font left to right top align */
#define DRAW_OPT_FONT_DIR_R2LB   (0x0080) /*!< Font right to left bottom align */
#define DRAW_OPT_FONT_DIR_R2LT   (0x00C0) /*!< Font right to left top align */
#define DRAW_OPT_FONT_DIR_B2TL   (0x0100) /*!< Font bottom to top left align */
#define DRAW_OPT_FONT_DIR_B2TR   (0x0140) /*!< Font bottom to top right align */
#define DRAW_OPT_FONT_DIR_T2BL   (0x0180) /*!< Font top to bottom left align */
#define DRAW_OPT_FONT_DIR_T2BR   (0x01C0) /*!< Font top to bottom right align */
/** @} */  // end of DisplayFontDrawOptionConstants group
/** @} */  // end of DisplayDrawOptionConstants group

/** @defgroup DisplayFlagsGroup Display flags
 * Constants that are for use with the display flags functions.
 * \sa SetDisplayFlags(), DisplayFlags()
 * @{
 */
#define DISPLAY_ON               0x01     /*!< W  - Display on */
#define DISPLAY_REFRESH          0x02     /*!< W  - Enable refresh */
#define DISPLAY_POPUP            0x08     /*!< W  - Use popup display memory */
#define DISPLAY_REFRESH_DISABLED 0x40     /*!< R  - Refresh disabled */
#define DISPLAY_BUSY             0x80     /*!< R  - Refresh in progress */
/** @} */  // end of DisplayFlagsGroup group

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/** @defgroup DisplayContrastConstants Display contrast constants
 * Constants that are for use with the display contrast API functions.
 * \sa SetDisplayContrast(), DisplayContrast()
 * @{
 */
#define DISPLAY_CONTRAST_DEFAULT 0x5A /*!< Default display contrast value */
#define DISPLAY_CONTRAST_MAX     0x7F /*!< Maximum display contrast value */
/** @} */  // end of DisplayContrastConstants group
#endif

#define SCREEN_MODE_RESTORE 0x00 /*!< Restore the screen \sa SetScreenMode() */
#define SCREEN_MODE_CLEAR   0x01 /*!< Clear the screen \sa SetScreenMode() */

#define DISPLAY_HEIGHT 64  /*!< The height of the LCD screen in pixels */
#define DISPLAY_WIDTH  100 /*!< The width of the LCD screen in pixels */

#define DISPLAY_MENUICONS_Y       40 /*!< */
#define DISPLAY_MENUICONS_X_OFFS  7  /*!< */
#define DISPLAY_MENUICONS_X_DIFF  31 /*!< */

/** @defgroup DisplayTextLineConstants Text line constants
 * Constants that are for use with getting/setting display data.
 * \sa SetDisplayNormal(), GetDisplayNormal(), SetDisplayPopup(), GetDisplayPopup()
 * @{
 */
#define TEXTLINE_1 0 /*!< Text line 1 */
#define TEXTLINE_2 1 /*!< Text line 2 */
#define TEXTLINE_3 2 /*!< Text line 3 */
#define TEXTLINE_4 3 /*!< Text line 4 */
#define TEXTLINE_5 4 /*!< Text line 5 */
#define TEXTLINE_6 5 /*!< Text line 6 */
#define TEXTLINE_7 6 /*!< Text line 7 */
#define TEXTLINE_8 7 /*!< Text line 8 */
#define TEXTLINES  8 /*!< The number of text lines on the LCD */
/** @} */  // end of DisplayTextLineConstants group

// Used in macro "MENUICON_BIT"
#define MENUICON_LEFT   0 /*!< Left icon */
#define MENUICON_CENTER 1 /*!< Center icon */
#define MENUICON_RIGHT  2 /*!< Right icon */
#define MENUICONS       3 /*!< The number of menu icons */

// Used in macro "SPECIAL_BIT"
#define FRAME_SELECT 0   /*!< Center icon select frame */
#define STATUSTEXT   1   /*!< Status text (BT name) */
#define MENUTEXT     2   /*!< Center icon text */
#define STEPLINE     3   /*!< Step collection lines */
#define TOPLINE      4   /*!< Top status underline */
#define SPECIALS     5   /*!< The number of special bit values */

// Used in macro "STATUSICON_BIT"
#define STATUSICON_BLUETOOTH 0 /*!< BlueTooth status icon collection */
#define STATUSICON_USB       1 /*!< USB status icon collection */
#define STATUSICON_VM        2 /*!< VM status icon collection */
#define STATUSICON_BATTERY   3 /*!< Battery status icon collection */
#define STATUSICONS          4 /*!< The number of status icons */

// Used in macro "SCREEN_BIT"
#define SCREEN_BACKGROUND 0 /*!< Entire screen */
#define SCREEN_LARGE      1 /*!< Entire screen except status line */
#define SCREEN_SMALL      2 /*!< Screen between menu icons and status line */
#define SCREENS           3 /*!< The number of screen bits */

// Used in macro "BITMAP_BIT"
#define BITMAP_1 0 /*!< Bitmap 1 */
#define BITMAP_2 1 /*!< Bitmap 2 */
#define BITMAP_3 2 /*!< Bitmap 3 */
#define BITMAP_4 3 /*!< Bitmap 4 */
#define BITMAPS  4 /*!< The number of bitmap bits */

// Used in macro "STEPICON_BIT"
#define STEPICON_1 0 /*!< Left most step icon */
#define STEPICON_2 1 /*!< */
#define STEPICON_3 2 /*!< */
#define STEPICON_4 3 /*!< */
#define STEPICON_5 4 /*!< Right most step icon */
#define STEPICONS  5 /*!< */

/** @defgroup DisplayIOMAP Display module IOMAP offsets
 * Constant offsets into the display module IOMAP structure.
 * @{
 */
#define DisplayOffsetPFunc          0             /*!< Simple draw entry */
#define DisplayOffsetEraseMask      4             /*!< Section erase mask   (executed first) */
#define DisplayOffsetUpdateMask     8             /*!< Section update mask  (executed next) */
#define DisplayOffsetPFont          12            /*!< Pointer to font file */
#define DisplayOffsetPTextLines(p)  (((p)*4)+16)  /*!< Pointer to text strings */
#define DisplayOffsetPStatusText    48            /*!< Pointer to status text string */
#define DisplayOffsetPStatusIcons   52            /*!< Pointer to status icon collection file */
#define DisplayOffsetPScreens(p)    (((p)*4)+56)  /*!< Pointer to screen bitmap file */
#define DisplayOffsetPBitmaps(p)    (((p)*4)+68)  /*!< Pointer to free bitmap files */
#define DisplayOffsetPMenuText      84            /*!< Pointer to menu icon text (NULL == none) */
#define DisplayOffsetPMenuIcons(p)  (((p)*4)+88)  /*!< Pointer to menu icon images (NULL == none) */
#define DisplayOffsetPStepIcons     100           /*!< Pointer to step icon collection file */
#define DisplayOffsetDisplay        104           /*!< Display content copied to physical display every 17 mS */
#define DisplayOffsetStatusIcons(p) ((p)+108)     /*!< Index in status icon collection file (index = 0 -> none) */
#define DisplayOffsetStepIcons(p)   ((p)+112)     /*!< Index in step icon collection file (index = 0 -> none) */
#define DisplayOffsetFlags          117           /*!< Update flags enumerated above */
#define DisplayOffsetTextLinesCenterFlags 118     /*!< Mask to center TextLines */
#define DisplayOffsetNormal(l,w)    (((l)*100)+(w)+119) /*!< Raw display memory for normal screen */
#define DisplayOffsetPopup(l,w)     (((l)*100)+(w)+919) /*!< Raw display memory for popup screen */

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
#define DisplayOffsetContrast       1719 /*!< Adjust the display contrast with this field */
#endif
/** @} */  // end of DisplayIOMAP group
/** @} */  // end of DisplayModuleConstants group
/** @} */  // end of DisplayModule group


/** @addtogroup CommModule
 * @{
 */
/** @defgroup CommModuleConstants Comm module constants
 * Constants that are part of the NXT firmware's Comm module.
 * @{
 */
/** @defgroup CommMiscConstants Miscellaneous Comm module constants
 * Miscellaneous constants related to the Comm module.
 * @{
 */
#define SIZE_OF_USBBUF                64  /*!< Size of USB Buffer in bytes */
#define USB_PROTOCOL_OVERHEAD         2   /*!< Size of USB Overhead in bytes -- Command type byte + Command*/
#define SIZE_OF_USBDATA               62  /*!< Size of USB Buffer available for data */
#define SIZE_OF_HSBUF                 128 /*!< Size of High Speed Port 4 buffer */
#define SIZE_OF_BTBUF                 128 /*!< Size of Bluetooth buffer*/

#define BT_CMD_BYTE                   1  /*!< Size of Bluetooth command*/
#define SIZE_OF_BT_DEVICE_TABLE       30 /*!< Size of Bluetooth device table */
#define SIZE_OF_BT_CONNECT_TABLE      4  /*!< Size of Bluetooth connection table -- Index 0 is always incoming connection */
#define SIZE_OF_BT_NAME               16 /*!< Size of Bluetooth name */
#define SIZE_OF_BRICK_NAME            8  /*!< Size of NXT Brick name */
#define SIZE_OF_CLASS_OF_DEVICE       4  /*!< Size of class of device */
#define SIZE_OF_BT_PINCODE            16 /*!< Size of Bluetooth PIN */
#define SIZE_OF_BDADDR                7  /*!< Size of Bluetooth Address*/
#define MAX_BT_MSG_SIZE               60000 /*!< Max Bluetooth Message Size */

#define BT_DEFAULT_INQUIRY_MAX        0   /*!< Bluetooth default inquiry Max (0 == unlimited)*/
#define BT_DEFAULT_INQUIRY_TIMEOUT_LO 15  /*!< Bluetooth inquiry timeout (15*1.28 sec = 19.2 sec) */
/** @} */  // end of CommMiscConstants group

/** @defgroup CommBtStateConstants Bluetooth State constants
 * Constants related to the bluetooth state.
 * @{
 */
#define BT_ARM_OFF              0 /*!< BtState constant bluetooth off */
#define BT_ARM_CMD_MODE         1 /*!< BtState constant bluetooth command mode */
#define BT_ARM_DATA_MODE        2 /*!< BtState constant bluetooth data mode */
/** @} */  // end of CommBtStateConstants group

/** @defgroup CommDataModeConstants Data mode constants
 * Constants related to the bluetooth and hi-speed data modes.
 * @{
 */
#define DATA_MODE_NXT    0x00 /*!< Use NXT data mode */
#define DATA_MODE_GPS    0x01 /*!< Use GPS data mode */
#define DATA_MODE_RAW    0x02 /*!< Use RAW data mode */
#define DATA_MODE_MASK   0x07 /*!< A mask for the data mode bits. */
#define DATA_MODE_UPDATE 0x08 /*!< Indicates that the data mode has been changed. */
/** @} */  // end of CommDataModeConstants group

/** @defgroup CommBtStateStatusConstants Bluetooth state status constants
 * Constants related to the bluetooth state status.
 * @{
 */
#define BT_BRICK_VISIBILITY     0x01 /*!< BtStateStatus brick visibility bit */
#define BT_BRICK_PORT_OPEN      0x02 /*!< BtStateStatus port open bit */
#define BT_CONNECTION_0_ENABLE  0x10 /*!< BtStateStatus connection 0 enable/disable bit */
#define BT_CONNECTION_1_ENABLE  0x20 /*!< BtStateStatus connection 1 enable/disable bit */
#define BT_CONNECTION_2_ENABLE  0x40 /*!< BtStateStatus connection 2 enable/disable bit */
#define BT_CONNECTION_3_ENABLE  0x80 /*!< BtStateStatus connection 3 enable/disable bit */
/** @} */  // end of CommBtStateStatusConstants group

/** @defgroup CommConnectionConstants Remote connection constants
 * Constants for specifying remote connection slots.
 * @{
 */
#define CONN_BT0    0x0 /*!< Bluetooth connection 0 */
#define CONN_BT1    0x1 /*!< Bluetooth connection 1 */
#define CONN_BT2    0x2 /*!< Bluetooth connection 2 */
#define CONN_BT3    0x3 /*!< Bluetooth connection 3 */
#define CONN_HS4    0x4 /*!< RS485 (hi-speed) connection (port 4, all devices) */
#define CONN_HS_ALL 0x4 /*!< RS485 (hi-speed) connection (port 4, all devices) */
#define CONN_HS_1   0x5 /*!< RS485 (hi-speed) connection (port 4, device address 1) */
#define CONN_HS_2   0x6 /*!< RS485 (hi-speed) connection (port 4, device address 2) */
#define CONN_HS_3   0x7 /*!< RS485 (hi-speed) connection (port 4, device address 3) */
#define CONN_HS_4   0x8 /*!< RS485 (hi-speed) connection (port 4, device address 4) */
#define CONN_HS_5   0x9 /*!< RS485 (hi-speed) connection (port 4, device address 5) */
#define CONN_HS_6   0xa /*!< RS485 (hi-speed) connection (port 4, device address 6) */
#define CONN_HS_7   0xb /*!< RS485 (hi-speed) connection (port 4, device address 7) */
#define CONN_HS_8   0xc /*!< RS485 (hi-speed) connection (port 4, device address 8) */
/** @} */  // end of CommConnectionConstants group

/** @defgroup CommBtHwStatusConstants Bluetooth hardware status constants
 * Constants related to the bluetooth hardware status.
 * @{
 */
#define BT_ENABLE               0x00 /*!< BtHwStatus bluetooth enable */
#define BT_DISABLE              0x01 /*!< BtHwStatus bluetooth disable */
/** @} */  // end of CommBtHwStatusConstants group

/** @defgroup CommHiSpeedConstants Hi-speed port constants
 * Constants related to the hi-speed port.
 * @{
 */
/** @defgroup CommHiSpeedFlagsConstants Hi-speed port flags constants
 * Constants related to the hi-speed port flags.
 * @{
 */
#define HS_UPDATE        1 /*!< HsFlags high speed update required */
/** @} */  // end of CommHiSpeedFlagsConstants group

/** @defgroup CommHiSpeedStateConstants Hi-speed port state constants
 * Constants related to the hi-speed port state.
 * @{
 */
#define HS_INITIALISE    1 /*!< HsState initialize */
#define HS_INIT_RECEIVER 2 /*!< HsState initialize receiver */
#define HS_SEND_DATA     3 /*!< HsState send data */
#define HS_DISABLE       4 /*!< HsState disable */
#define HS_ENABLE        5 /*!< HsState enable */
/** @} */  // end of CommHiSpeedStateConstants group

#ifdef __ENHANCED_FIRMWARE

/** @defgroup CommHiSpeedCtrlConstants Hi-speed port SysCommHSControl constants
 * Constants for use with the SysCommHSControl API function.
 * \sa SysCommHSControl() 
 * @{
 */
#define HS_CTRL_INIT 0 /*!< Enable the high speed port */
#define HS_CTRL_UART 1 /*!< Setup the high speed port UART configuration */
#define HS_CTRL_EXIT 2 /*!< Ddisable the high speed port */
/** @} */  // end of CommHiSpeedCtrlConstants group

#if __FIRMWARE_VERSION > 107

/** @defgroup CommHiSpeedBaudConstants Hi-speed port baud rate constants
 * Constants for configuring the hi-speed port baud rate (HsSpeed).
 * @{
 */
#define HS_BAUD_1200     0 /*!< HsSpeed 1200 Baud */
#define HS_BAUD_2400     1 /*!< HsSpeed 2400 Baud */
#define HS_BAUD_3600     2 /*!< HsSpeed 3600 Baud */
#define HS_BAUD_4800     3 /*!< HsSpeed 4800 Baud */
#define HS_BAUD_7200     4 /*!< HsSpeed 7200 Baud */
#define HS_BAUD_9600     5 /*!< HsSpeed 9600 Baud */
#define HS_BAUD_14400    6 /*!< HsSpeed 14400 Baud */
#define HS_BAUD_19200    7 /*!< HsSpeed 19200 Baud */
#define HS_BAUD_28800    8 /*!< HsSpeed 28800 Baud */
#define HS_BAUD_38400    9 /*!< HsSpeed 38400 Baud */
#define HS_BAUD_57600   10 /*!< HsSpeed 57600 Baud */
#define HS_BAUD_76800   11 /*!< HsSpeed 76800 Baud */
#define HS_BAUD_115200  12 /*!< HsSpeed 115200 Baud */
#define HS_BAUD_230400  13 /*!< HsSpeed 230400 Baud */
#define HS_BAUD_460800  14 /*!< HsSpeed 460800 Baud */
#define HS_BAUD_921600  15 /*!< HsSpeed 921600 Baud */
#define HS_BAUD_DEFAULT 15 /*!< HsSpeed default Baud (921600) */
/** @} */  // end of CommHiSpeedBaudConstants group

/** @defgroup CommHiSpeedModeConstants Hi-speed port UART mode constants
 * Constants referring to HsMode UART configuration settings
 * @{
 */
#define HS_MODE_DEFAULT HS_MODE_8N1 /*!< HsMode default mode (8 data bits, no parity, 1 stop bit) */

/** @defgroup CommHiSpeedDataBitsConstants Hi-speed port data bits constants
 * Constants referring to HsMode (number of data bits)
 * @{
 */
#define HS_MODE_5_DATA 0x0000 /*!< HsMode 5 data bits */
#define HS_MODE_6_DATA 0x0040 /*!< HsMode 6 data bits */
#define HS_MODE_7_DATA 0x0080 /*!< HsMode 7 data bits */
#define HS_MODE_8_DATA 0x00C0 /*!< HsMode 8 data bits */
/** @} */  // end of CommHiSpeedDataBitsConstants group

/** @defgroup CommHiSpeedStopBitsConstants Hi-speed port stop bits constants
 * Constants referring to HsMode (number of stop bits)
 * @{
 */
#define HS_MODE_10_STOP 0x0000 /*!< HsMode 1 stop bit */
#define HS_MODE_15_STOP 0x1000 /*!< HsMode 1.5 stop bits */
#define HS_MODE_20_STOP 0x2000 /*!< HsMode 2 stop bits */
/** @} */  // end of CommHiSpeedStopBitsConstants group

/** @defgroup CommHiSpeedParityConstants Hi-speed port parity constants
 * Constants referring to HsMode (parity)
 * @{
 */
#define HS_MODE_E_PARITY 0x0000 /*!< HsMode Even parity */
#define HS_MODE_O_PARITY 0x0200 /*!< HsMode Odd parity */
#define HS_MODE_S_PARITY 0x0400 /*!< HsMode Space parity */
#define HS_MODE_M_PARITY 0x0600 /*!< HsMode Mark parity */
#define HS_MODE_N_PARITY 0x0800 /*!< HsMode No parity */
/** @} */  // end of CommHiSpeedParityConstants group

/** @defgroup CommHiSpeedCombinedConstants Hi-speed port combined UART constants
 * Constants that combine data bits, parity, and stop bits into a single value.
 * @{
 */
#define HS_MODE_8N1 (HS_MODE_8_DATA|HS_MODE_N_PARITY|HS_MODE_10_STOP) /*!< HsMode 8 data bits, no parity, 1 stop bit */
#define HS_MODE_7E1 (HS_MODE_7_DATA|HS_MODE_E_PARITY|HS_MODE_10_STOP) /*!< HsMode 7 data bits, even parity, 1 stop bit */
/** @} */  // end of CommHiSpeedCombinedConstants group
/** @} */  // end of CommHiSpeedModeConstants group


/** @defgroup CommHiSpeedAddressConstants Hi-speed port address constants
 * Constants that are used to specify the Hi-speed (RS-485) port device address.
 * @{
 */
#define HS_ADDRESS_ALL 0 /*!< HsAddress all devices */
#define HS_ADDRESS_1   1 /*!< HsAddress device address 1 */
#define HS_ADDRESS_2   2 /*!< HsAddress device address 2 */
#define HS_ADDRESS_3   3 /*!< HsAddress device address 3 */
#define HS_ADDRESS_4   4 /*!< HsAddress device address 4 */
#define HS_ADDRESS_5   5 /*!< HsAddress device address 5 */
#define HS_ADDRESS_6   6 /*!< HsAddress device address 6 */
#define HS_ADDRESS_7   7 /*!< HsAddress device address 7 */
#define HS_ADDRESS_8   8 /*!< HsAddress device address 8 */
/** @} */  // end of CommHiSpeedAddressConstants group

#endif
#endif
/** @} */  // end of CommHiSpeedConstants group

/** @defgroup CommDeviceStatusConstants Device status constants
 * Constants refering to DeviceStatus within DeviceTable
 * @{
 */
#define BT_DEVICE_EMPTY   0x00 /*!< Bluetooth device table empty */
#define BT_DEVICE_UNKNOWN 0x01 /*!< Bluetooth device unknown */
#define BT_DEVICE_KNOWN   0x02 /*!< Bluetooth device known */
#define BT_DEVICE_NAME    0x40 /*!< Bluetooth device name */
#define BT_DEVICE_AWAY    0x80 /*!< Bluetooth device away */
/** @} */  // end of CommDeviceStatusConstants group

/** @defgroup CommInterfaceConstants Comm module interface function constants
 * Constants for all the Comm module interface functions executable via SysCommExecuteFunction.
 * \sa SysCommExecuteFunction()
 * @{
 */
#define INTF_SENDFILE      0 /*!< Send a file via bluetooth to another device */
#define INTF_SEARCH        1 /*!< Search for bluetooth devices */
#define INTF_STOPSEARCH    2 /*!< Stop searching for bluetooth devices */
#define INTF_CONNECT       3 /*!< Connect to one of the known devices */
#define INTF_DISCONNECT    4 /*!< Disconnect from one of the connected devices */
#define INTF_DISCONNECTALL 5 /*!< Disconnect all devices */
#define INTF_REMOVEDEVICE  6 /*!< Remove a device from the known devices table */
#define INTF_VISIBILITY    7 /*!< Set the bluetooth visibility on or off */
#define INTF_SETCMDMODE    8 /*!< Set bluetooth into command mode */
#define INTF_OPENSTREAM    9 /*!< Open a bluetooth stream */
#define INTF_SENDDATA      10 /*!< Send data over a bluetooth connection */
#define INTF_FACTORYRESET  11 /*!< Reset bluetooth settings to factory values */
#define INTF_BTON          12 /*!< Turn on the bluetooth radio */
#define INTF_BTOFF         13 /*!< Turn off the bluetooth radio */
#define INTF_SETBTNAME     14 /*!< Set the bluetooth name */
#define INTF_EXTREAD       15 /*!< External read request */
#define INTF_PINREQ        16 /*!< Bluetooth PIN request */
#define INTF_CONNECTREQ    17 /*!< Connection request from another device */

#if __FIRMWARE_VERSION > 107
#define INTF_CONNECTBYNAME 18 /*!< Connect to a bluetooth device by name */
#endif
/** @} */  // end of CommInterfaceConstants group

/** @defgroup CommStatusCodesConstants Comm module status code constants
 * Constants for Comm module status codes.
 * @{
 */
#define LR_SUCCESS        0x50 /*!< Bluetooth list result success */
#define LR_COULD_NOT_SAVE 0x51 /*!< Bluetooth list result could not save */
#define LR_STORE_IS_FULL  0x52 /*!< Bluetooth list result store is full */
#define LR_ENTRY_REMOVED  0x53 /*!< Bluetooth list result entry removed */
#define LR_UNKNOWN_ADDR   0x54 /*!< Bluetooth list result unknown address */

#define USB_CMD_READY     0x01 /*!< A constant representing usb direct command */
#define BT_CMD_READY      0x02 /*!< A constant representing bluetooth direct command */
#define HS_CMD_READY      0x04 /*!< A constant representing high speed direct command */
/** @} */  // end of CommStatusCodesConstants group

/** @defgroup CommIOMAP Comm module IOMAP offsets
 * Constant offsets into the Comm module IOMAP structure.
 * @{
 */
#define CommOffsetPFunc    0 /*!< Offset to the Comm module first function pointer (4 bytes) */
#define CommOffsetPFuncTwo 4 /*!< Offset to the Comm module second function pointer (4 bytes) */
// BtDeviceTable[30] (930 bytes)
#define CommOffsetBtDeviceTableName(p)           (((p)*31)+8) /*!< Offset to BT device table name (16 bytes) */
#define CommOffsetBtDeviceTableClassOfDevice(p)  (((p)*31)+24) /*!< Offset to Bluetooth device table device class (4 bytes) */
#define CommOffsetBtDeviceTableBdAddr(p)         (((p)*31)+28) /*!< Offset to Bluetooth device table address (7 bytes) */
#define CommOffsetBtDeviceTableDeviceStatus(p)   (((p)*31)+35) /*!< Offset to Bluetooth device table status (1 byte) */
//  BDCONNECTTABLE BtConnectTable[4]; (188 bytes)
#define CommOffsetBtConnectTableName(p)          (((p)*47)+938) /*!< Offset to Bluetooth connect table name (16 bytes) */
#define CommOffsetBtConnectTableClassOfDevice(p) (((p)*47)+954) /*!< Offset to Bluetooth connect table device class (4 bytes) */
#define CommOffsetBtConnectTablePinCode(p)       (((p)*47)+958) /*!< Offset to Bluetooth connect table pin code (16 bytes) */
#define CommOffsetBtConnectTableBdAddr(p)        (((p)*47)+974) /*!< Offset to Bluetooth connect table address (7 bytes) */
#define CommOffsetBtConnectTableHandleNr(p)      (((p)*47)+981) /*!< Offset to Bluetooth connect table handle (1 byte) */
#define CommOffsetBtConnectTableStreamStatus(p)  (((p)*47)+982) /*!< Offset to Bluetooth connect table stream status (1 byte) */
#define CommOffsetBtConnectTableLinkQuality(p)   (((p)*47)+983) /*!< Offset to Bluetooth connect table link quality (1 byte) */
//General brick data
//  BRICKDATA      BrickData; (31 bytes)
#define CommOffsetBrickDataName            1126 /*!< Offset to brick name (16 bytes) */
#define CommOffsetBrickDataBluecoreVersion 1142 /*!< Offset to Bluecore version (2 bytes) */
#define CommOffsetBrickDataBdAddr          1144 /*!< Offset to Bluetooth address (7 bytes) */
#define CommOffsetBrickDataBtStateStatus   1151 /*!< Offset to BtStateStatus (1 byte) */
#define CommOffsetBrickDataBtHwStatus      1152 /*!< Offset to BtHwStatus (1 byte) */
#define CommOffsetBrickDataTimeOutValue    1153 /*!< Offset to data timeout value (1 byte) */
//  BTBUF          BtInBuf; (132 bytes)
#define CommOffsetBtInBufBuf       1157 /*!< Offset to Bluetooth input buffer data (128 bytes) */
#define CommOffsetBtInBufInPtr     1285 /*!< Offset to Bluetooth input buffer front pointer (1 byte) */
#define CommOffsetBtInBufOutPtr    1286 /*!< Offset to Bluetooth output buffer back pointer (1 byte) */
//  BTBUF          BtOutBuf; (132 bytes)
#define CommOffsetBtOutBufBuf      1289 /*!< Offset to Bluetooth output buffer offset data (128 bytes) */
#define CommOffsetBtOutBufInPtr    1417 /*!< Offset to Bluetooth output buffer front pointer (1 byte) */
#define CommOffsetBtOutBufOutPtr   1418 /*!< Offset to Bluetooth output buffer back pointer (1 byte) */
// HI Speed related entries
//  HSBUF          HsInBuf; (132 bytes)
#define CommOffsetHsInBufBuf       1421 /*!< Offset to High Speed input buffer data (128 bytes) */
#define CommOffsetHsInBufInPtr     1549 /*!< Offset to High Speed input buffer front pointer (1 byte) */
#define CommOffsetHsInBufOutPtr    1550 /*!< Offset to High Speed input buffer back pointer (1 byte) */
//  HSBUF          HsOutBuf; (132 bytes)
#define CommOffsetHsOutBufBuf      1553 /*!< Offset to High Speed output buffer data (128 bytes) */
#define CommOffsetHsOutBufInPtr    1681 /*!< Offset to High Speed output buffer front pointer (1 byte) */
#define CommOffsetHsOutBufOutPtr   1682 /*!< Offset to High Speed output buffer back pointer (1 byte) */
// USB related entries
//  USBBUF         UsbInBuf; (68 bytes)
#define CommOffsetUsbInBufBuf        1685 /*!< Offset to Usb input buffer data (64 bytes) */
#define CommOffsetUsbInBufInPtr      1749 /*!< Offset to Usb input buffer front pointer (1 byte) */
#define CommOffsetUsbInBufOutPtr     1750 /*!< Offset to Usb input buffer back pointer (1 byte) */
//  USBBUF         UsbOutBuf; (68 bytes)
#define CommOffsetUsbOutBufBuf       1753 /*!< Offset to Usb output buffer data (64 bytes) */
#define CommOffsetUsbOutBufInPtr     1817 /*!< Offset to Usb output buffer front pointer (1 byte) */
#define CommOffsetUsbOutBufOutPtr    1818 /*!< Offset to Usb output buffer back pointer (1 byte) */
//  USBBUF         UsbPollBuf; (68 bytes)
#define CommOffsetUsbPollBufBuf      1821 /*!< Offset to Usb Poll buffer data (64 bytes) */
#define CommOffsetUsbPollBufInPtr    1885 /*!< Offset to Usb Poll buffer front pointer (1 byte) */
#define CommOffsetUsbPollBufOutPtr   1886 /*!< Offset to Usb Poll buffer back pointer (1 byte) */

#define CommOffsetBtDeviceCnt      1889 /*!< Offset to Bluetooth device count (1 byte) */
#define CommOffsetBtDeviceNameCnt  1890 /*!< Offset to Bluetooth device name count (1 byte) */
#define CommOffsetHsFlags          1891 /*!< Offset to High Speed flags (1 byte) */
#define CommOffsetHsSpeed          1892 /*!< Offset to High Speed speed (1 byte) */
#define CommOffsetHsState          1893 /*!< Offset to High Speed state (1 byte) */
#define CommOffsetUsbState         1894 /*!< Offset to Usb State (1 byte) */
#ifdef __ENHANCED_FIRMWARE
#define CommOffsetHsMode           1896 /*!< Offset to High Speed mode (2 bytes) */
#define CommOffsetBtDataMode       1898 /*!< Offset to Bluetooth data mode (1 byte) */
#define CommOffsetHsDataMode       1899 /*!< Offset to High Speed data mode (1 byte) */
#endif
/** @} */  // end of CommIOMAP group
/** @} */  // end of CommModuleConstants group
/** @} */  // end of CommModule group


/** @addtogroup ThirdPartyDevices
 * @{
 */
/** @defgroup RCXAPIConstants RCX constants
 * Constants that are for use with devices that communicate with the RCX or
 * Scout programmable bricks via IR such as the HiTechnic IRLink or the
 * MindSensors nRLink.
 * @{
 */
/** @defgroup RCXOutputConstants RCX output constants
 * Constants for use when choosing RCX outputs.
 * @{
 */
#define RCX_OUT_A   0x01 /*!< RCX Output A */
#define RCX_OUT_B   0x02 /*!< RCX Output B */
#define RCX_OUT_C   0x04 /*!< RCX Output C */
#define RCX_OUT_AB  0x03 /*!< RCX Outputs A and B */
#define RCX_OUT_AC  0x05 /*!< RCX Outputs A and C */
#define RCX_OUT_BC  0x06 /*!< RCX Outputs B and C */
#define RCX_OUT_ABC 0x07 /*!< RCX Outputs A, B, and C */
/** @} */  // end of RCXOutputConstants group

/** @defgroup RCXOutputMode RCX output mode constants
 * Constants for use when configuring RCX output mode.
 * @{
 */
#define RCX_OUT_FLOAT 0    /*!< Set RCX output to float */
#define RCX_OUT_OFF   0x40 /*!< Set RCX output to off */
#define RCX_OUT_ON    0x80 /*!< Set RCX output to on */
/** @} */  // end of RCXOutputMode group

/** @defgroup RCXOutputDirection RCX output direction constants
 * Constants for use when configuring RCX output direction.
 * @{
 */
#define RCX_OUT_REV    0    /*!< Set RCX output direction to reverse */
#define RCX_OUT_TOGGLE 0x40 /*!< Set RCX output direction to toggle */
#define RCX_OUT_FWD    0x80 /*!< Set RCX output direction to forward */
/** @} */  // end of RCXOutputConstants group

/** @defgroup RCXOutputPower RCX output power constants
 * Constants for use when configuring RCX output power.
 * @{
 */
#define RCX_OUT_LOW  0 /*!< Set RCX output power level to low */
#define RCX_OUT_HALF 3 /*!< Set RCX output power level to half */
#define RCX_OUT_FULL 7 /*!< Set RCX output power level to full */
/** @} */  // end of RCXOutputPower group

/** @defgroup RCXRemoteConstants RCX IR remote constants
 * Constants for use when simulating RCX IR remote messages.
 * @{
 */
#define RCX_RemoteKeysReleased 0x0000 /*!< All remote keys have been released */
#define RCX_RemotePBMessage1   0x0100 /*!< Send PB message 1 */
#define RCX_RemotePBMessage2   0x0200 /*!< Send PB message 2 */
#define RCX_RemotePBMessage3   0x0400 /*!< Send PB message 3 */
#define RCX_RemoteOutAForward  0x0800 /*!< Set output A forward */
#define RCX_RemoteOutBForward  0x1000 /*!< Set output B forward */
#define RCX_RemoteOutCForward  0x2000 /*!< Set output C forward */
#define RCX_RemoteOutABackward 0x4000 /*!< Set output A backward */
#define RCX_RemoteOutBBackward 0x8000 /*!< Set output B backward */
#define RCX_RemoteOutCBackward 0x0001 /*!< Set output C backward */
#define RCX_RemoteSelProgram1  0x0002 /*!< Select program 1 */
#define RCX_RemoteSelProgram2  0x0004 /*!< Select program 2 */
#define RCX_RemoteSelProgram3  0x0008 /*!< Select program 3 */
#define RCX_RemoteSelProgram4  0x0010 /*!< Select program 4 */
#define RCX_RemoteSelProgram5  0x0020 /*!< Select program 5 */
#define RCX_RemoteStopOutOff   0x0040 /*!< Stop and turn off outputs */
#define RCX_RemotePlayASound   0x0080 /*!< Play a sound */
/** @} */  // end of RCXRemoteConstants group

/** @defgroup RCXSoundConstants RCX and Scout sound constants
 * Constants for use when playing standard RCX and Scout sounds.
 * @{
 */
#define SOUND_CLICK       0 /*!< Play the standard key click sound */
#define SOUND_DOUBLE_BEEP 1 /*!< Play the standard double beep sound */
#define SOUND_DOWN        2 /*!< Play the standard sweep down sound */
#define SOUND_UP          3 /*!< Play the standard sweep up sound */
#define SOUND_LOW_BEEP    4 /*!< Play the standard low beep sound */
#define SOUND_FAST_UP     5 /*!< Play the standard fast up sound */
/** @} */  // end of RCXSoundConstants group

/** @defgroup ScoutConstants Scout constants
 * Constants for use when controlling the Scout brick.
 * @{
 */
/** @defgroup ScoutLightConstants Scout light constants
 * Constants for use when controlling the Scout light settings.
 * @{
 */
#define SCOUT_LIGHT_ON        0x80 /*!< Turn on the scout light */
#define SCOUT_LIGHT_OFF       0    /*!< Turn off the scout light */
/** @} */  // end of ScoutLightConstants group

/** @defgroup ScoutSoundConstants Scout sound constants
 * Constants for use when playing standard Scout sounds.
 * @{
 */
#define SCOUT_SOUND_REMOTE           6 /*!< Play the Scout remote sound */
#define SCOUT_SOUND_ENTERSA          7 /*!< Play the Scout enter standalone sound */
#define SCOUT_SOUND_KEYERROR         8 /*!< Play the Scout key error sound */
#define SCOUT_SOUND_NONE             9 /*!< Play the Scout none sound */
#define SCOUT_SOUND_TOUCH1_PRES     10 /*!< Play the Scout touch 1 pressed sound */
#define SCOUT_SOUND_TOUCH1_REL      11 /*!< Play the Scout touch 1 released sound */
#define SCOUT_SOUND_TOUCH2_PRES     12 /*!< Play the Scout touch 2 pressed sound */
#define SCOUT_SOUND_TOUCH2_REL      13 /*!< Play the Scout touch 2 released sound */
#define SCOUT_SOUND_ENTER_BRIGHT    14 /*!< Play the Scout enter bright sound */
#define SCOUT_SOUND_ENTER_NORMAL    15 /*!< Play the Scout enter normal sound */
#define SCOUT_SOUND_ENTER_DARK      16 /*!< Play the Scout enter dark sound */
#define SCOUT_SOUND_1_BLINK         17 /*!< Play the Scout 1 blink sound */
#define SCOUT_SOUND_2_BLINK         18 /*!< Play the Scout 2 blink sound */
#define SCOUT_SOUND_COUNTER1        19 /*!< Play the Scout counter 1 sound */
#define SCOUT_SOUND_COUNTER2        20 /*!< Play the Scout counter 2 sound */
#define SCOUT_SOUND_TIMER1          21 /*!< Play the Scout timer 1 sound */
#define SCOUT_SOUND_TIMER2          22 /*!< Play the Scout timer 2 sound */
#define SCOUT_SOUND_TIMER3          23 /*!< Play the Scout timer 3 sound */
#define SCOUT_SOUND_MAIL_RECEIVED   24 /*!< Play the Scout mail received sound */
#define SCOUT_SOUND_SPECIAL1        25 /*!< Play the Scout special 1 sound */
#define SCOUT_SOUND_SPECIAL2        26 /*!< Play the Scout special 2 sound */
#define SCOUT_SOUND_SPECIAL3        27 /*!< Play the Scout special 3 sound */
/** @} */  // end of ScoutSoundConstants group

/** @defgroup ScoutSndSetConstants Scout sound set constants
 * Constants for use when choosing standard Scout sound sets.
 * @{
 */
#define SCOUT_SNDSET_NONE           0 /*!< Set sound set to none */
#define SCOUT_SNDSET_BASIC          1 /*!< Set sound set to basic */
#define SCOUT_SNDSET_BUG            2 /*!< Set sound set to bug */
#define SCOUT_SNDSET_ALARM          3 /*!< Set sound set to alarm */
#define SCOUT_SNDSET_RANDOM         4 /*!< Set sound set to random */
#define SCOUT_SNDSET_SCIENCE        5 /*!< Set sound set to science */
/** @} */  // end of ScoutSndSetConstants group

/** @defgroup ScoutModeConstants Scout mode constants
 * Constants for use when setting the scout mode.
 * @{
 */
#define SCOUT_MODE_STANDALONE       0 /*!< Enter stand alone mode */
#define SCOUT_MODE_POWER            1 /*!< Enter power mode */
/** @} */  // end of ScoutModeConstants group

/** @defgroup ScoutMotionRuleConstants Scout motion rule constants
 * Constants for use when setting the scout motion rule.
 * @{
 */
#define SCOUT_MR_NO_MOTION          0 /*!< Motion rule none */
#define SCOUT_MR_FORWARD            1 /*!< Motion rule forward */
#define SCOUT_MR_ZIGZAG             2 /*!< Motion rule zigzag */
#define SCOUT_MR_CIRCLE_RIGHT       3 /*!< Motion rule circle right */
#define SCOUT_MR_CIRCLE_LEFT        4 /*!< Motion rule circle left */
#define SCOUT_MR_LOOP_A             5 /*!< Motion rule loop A */
#define SCOUT_MR_LOOP_B             6 /*!< Motion rule loop B */
#define SCOUT_MR_LOOP_AB            7 /*!< Motion rule loop A then B */
/** @} */  // end of ScoutMotionRuleConstants group

/** @defgroup ScoutTouchRuleConstants Scout touch rule constants
 * Constants for use when setting the scout touch rule.
 * @{
 */
#define SCOUT_TR_IGNORE             0 /*!< Touch rule ignore */
#define SCOUT_TR_REVERSE            1 /*!< Touch rule reverse */
#define SCOUT_TR_AVOID              2 /*!< Touch rule avoid */
#define SCOUT_TR_WAIT_FOR           3 /*!< Touch rule wait for */
#define SCOUT_TR_OFF_WHEN           4 /*!< Touch rule off when */
/** @} */  // end of ScoutTouchRuleConstants group

/** @defgroup ScoutLightRuleConstants Scout light rule constants
 * Constants for use when setting the scout light rule.
 * @{
 */
#define SCOUT_LR_IGNORE             0 /*!< Light rule ignore */
#define SCOUT_LR_SEEK_LIGHT         1 /*!< Light rule seek light */
#define SCOUT_LR_SEEK_DARK          2 /*!< Light rule seek dark */
#define SCOUT_LR_AVOID              3 /*!< Light rule avoid */
#define SCOUT_LR_WAIT_FOR           4 /*!< Light rule wait for */
#define SCOUT_LR_OFF_WHEN           5 /*!< Light rule off when */
/** @} */  // end of ScoutLightRuleConstants group

/** @defgroup ScoutTransmitRuleConstants Scout transmit rule constants
 * Constants for use when setting the scout transmit rule.
 * @{
 */
#define SCOUT_TGS_SHORT             0 /*!< Transmit level short */
#define SCOUT_TGS_MEDIUM            1 /*!< Transmit level medium */
#define SCOUT_TGS_LONG              2 /*!< Transmit level long */
/** @} */  // end of ScoutTransmitRuleConstants group

/** @defgroup ScoutSpecialEffectConstants Scout special effect constants
 * Constants for use when setting the scout special effect.
 * @{
 */
#define SCOUT_FXR_NONE              0 /*!< No special effects */
#define SCOUT_FXR_BUG               1 /*!< Bug special effects */
#define SCOUT_FXR_ALARM             2 /*!< Alarm special effects */
#define SCOUT_FXR_RANDOM            3 /*!< Random special effects */
#define SCOUT_FXR_SCIENCE           4 /*!< Science special effects */
/** @} */  // end of ScoutSpecialEffectConstants group
/** @} */  // end of ScoutConstants group

/** @defgroup RCXSourceConstants RCX and Scout source constants
 * Constants for use when specifying RCX and Scout sources.
 * @{
 */
#define RCX_VariableSrc             0  /*!< The RCX variable source */
#define RCX_TimerSrc                1  /*!< The RCX timer source */
#define RCX_ConstantSrc             2  /*!< The RCX constant value source */
#define RCX_OutputStatusSrc         3  /*!< The RCX output status source */
#define RCX_RandomSrc               4  /*!< The RCX random number source */
#define RCX_ProgramSlotSrc          8  /*!< The RCX program slot source */
#define RCX_InputValueSrc           9  /*!< The RCX input value source */
#define RCX_InputTypeSrc            10 /*!< The RCX input type source */
#define RCX_InputModeSrc            11 /*!< The RCX input mode source */
#define RCX_InputRawSrc             12 /*!< The RCX input raw source */
#define RCX_InputBooleanSrc         13 /*!< The RCX input boolean source */
#define RCX_WatchSrc                14 /*!< The RCX watch source */
#define RCX_MessageSrc              15 /*!< The RCX message source */
#define RCX_GlobalMotorStatusSrc    17 /*!< The RCX global motor status source */
#define RCX_ScoutRulesSrc           18 /*!< The Scout rules source */
#define RCX_ScoutLightParamsSrc     19 /*!< The Scout light parameters source */
#define RCX_ScoutTimerLimitSrc      20 /*!< The Scout timer limit source */
#define RCX_CounterSrc              21 /*!< The RCX counter source */
#define RCX_ScoutCounterLimitSrc    22 /*!< The Scout counter limit source */
#define RCX_TaskEventsSrc           23 /*!< The RCX task events source */
#define RCX_ScoutEventFBSrc         24 /*!< The Scout event feedback source */
#define RCX_EventStateSrc           25 /*!< The RCX event static source */
#define RCX_TenMSTimerSrc           26 /*!< The RCX 10ms timer source */
#define RCX_ClickCounterSrc         27 /*!< The RCX event click counter source */
#define RCX_UpperThresholdSrc       28 /*!< The RCX event upper threshold source */
#define RCX_LowerThresholdSrc       29 /*!< The RCX event lower threshold source */
#define RCX_HysteresisSrc           30 /*!< The RCX event hysteresis source */
#define RCX_DurationSrc             31 /*!< The RCX event duration source */
#define RCX_UARTSetupSrc            33 /*!< The RCX UART setup source */
#define RCX_BatteryLevelSrc         34 /*!< The RCX battery level source */
#define RCX_FirmwareVersionSrc      35 /*!< The RCX firmware version source */
#define RCX_IndirectVarSrc          36 /*!< The RCX indirect variable source */
#define RCX_DatalogSrcIndirectSrc   37 /*!< The RCX indirect datalog source source */
#define RCX_DatalogSrcDirectSrc     38 /*!< The RCX direct datalog source source */
#define RCX_DatalogValueIndirectSrc 39 /*!< The RCX indirect datalog value source */
#define RCX_DatalogValueDirectSrc   40 /*!< The RCX direct datalog value source */
#define RCX_DatalogRawIndirectSrc   41 /*!< The RCX indirect datalog raw source */
#define RCX_DatalogRawDirectSrc     42 /*!< The RCX direct datalog raw source */
/** @} */  // end of RCXSourceConstants group

/** @defgroup RCXOpcodeConstants RCX and Scout opcode constants
 * Constants for use when specifying RCX and Scout opcodes.
 * @{
 */
#define RCX_PingOp           0x10 /*!< Ping the brick */
#define RCX_BatteryLevelOp   0x30 /*!< Read the battery level */
#define RCX_DeleteTasksOp    0x40 /*!< Delete tasks */
#define RCX_StopAllTasksOp   0x50 /*!< Stop all tasks */
#define RCX_PBTurnOffOp      0x60 /*!< Turn off the brick */
#define RCX_DeleteSubsOp     0x70 /*!< Delete subroutines */
#define RCX_ClearSoundOp     0x80 /*!< Clear sound */
#define RCX_ClearMsgOp       0x90 /*!< Clear message */
#define RCX_LSCalibrateOp    0xc0 /*!< Calibrate the light sensor */
#define RCX_MuteSoundOp      0xd0 /*!< Mute sound */
#define RCX_UnmuteSoundOp    0xe0 /*!< Unmute sound */
#define RCX_ClearAllEventsOp 0x06 /*!< Clear all events */
#define RCX_OnOffFloatOp     0x21 /*!< Control motor state - on, off, float */
#define RCX_IRModeOp         0x31 /*!< Set the IR transmit mode */
#define RCX_PlaySoundOp      0x51 /*!< Play a sound */
#define RCX_DeleteTaskOp     0x61 /*!< Delete a task */
#define RCX_StartTaskOp      0x71 /*!< Start a task */
#define RCX_StopTaskOp       0x81 /*!< Stop a task */
#define RCX_SelectProgramOp  0x91 /*!< Select a program slot */
#define RCX_ClearTimerOp     0xa1 /*!< Clear a timer */
#define RCX_AutoOffOp        0xb1 /*!< Set auto off timer */
#define RCX_DeleteSubOp      0xc1 /*!< Delete a subroutine */
#define RCX_ClearSensorOp    0xd1 /*!< Clear a sensor */
#define RCX_OutputDirOp      0xe1 /*!< Set the motor direction */
#define RCX_PlayToneVarOp    0x02 /*!< Play a tone using a variable */
#define RCX_PollOp           0x12 /*!< Poll a source/value combination */
#define RCX_SetWatchOp       0x22 /*!< Set the watch source/value */
#define RCX_InputTypeOp      0x32 /*!< Set the input type */
#define RCX_InputModeOp      0x42 /*!< Set the input mode */
#define RCX_SetDatalogOp     0x52 /*!< Set the datalog size */
#define RCX_DatalogOp        0x62 /*!< Datalog the specified source/value*/
#define RCX_SendUARTDataOp   0xc2 /*!< Send data via IR using UART settings */
#define RCX_RemoteOp         0xd2 /*!< Execute simulated remote control buttons */
#define RCX_VLLOp            0xe2 /*!< Send visual light link (VLL) data */
#define RCX_DirectEventOp    0x03 /*!< Fire an event */
#define RCX_OutputPowerOp    0x13 /*!< Set the motor power level */
#define RCX_PlayToneOp       0x23 /*!< Play a tone */
#define RCX_DisplayOp        0x33 /*!< Set LCD display value */
#define RCX_PollMemoryOp     0x63 /*!< Poll a memory location */
#define RCX_SetFeedbackOp    0x83 /*!< Set Scout feedback */
#define RCX_SetEventOp       0x93 /*!< Set an event */
#define RCX_GOutputPowerOp   0xa3 /*!< Set global motor power levels */
#define RCX_LSUpperThreshOp  0xb3 /*!< Set the light sensor upper threshold */
#define RCX_LSLowerThreshOp  0xc3 /*!< Set the light sensor lower threshold */
#define RCX_LSHysteresisOp   0xd3 /*!< Set the light sensor hysteresis */
#define RCX_LSBlinkTimeOp    0xe3 /*!< Set the light sensor blink time */
#define RCX_CalibrateEventOp 0x04 /*!< Calibrate event */
#define RCX_SetVarOp         0x14 /*!< Set function */
#define RCX_SumVarOp         0x24 /*!< Sum function */
#define RCX_SubVarOp         0x34 /*!< Subtract function */
#define RCX_DivVarOp         0x44 /*!< Divide function */
#define RCX_MulVarOp         0x54 /*!< Multiply function */
#define RCX_SgnVarOp         0x64 /*!< Sign function */
#define RCX_AbsVarOp         0x74 /*!< Absolute value function */
#define RCX_AndVarOp         0x84 /*!< AND function */
#define RCX_OrVarOp          0x94 /*!< OR function */
#define RCX_UploadDatalogOp  0xa4 /*!< Upload datalog contents */
#define RCX_SetTimerLimitOp  0xc4 /*!< Set timer limit */
#define RCX_SetCounterOp     0xd4 /*!< Set counter value */
#define RCX_SetSourceValueOp 0x05 /*!< Set a source/value*/
#define RCX_UnlockOp         0x15 /*!< Unlock the brick */
#define RCX_BootModeOp       0x65 /*!< Set into book mode */
#define RCX_UnlockFirmOp     0xa5 /*!< Unlock the firmware */
#define RCX_ScoutRulesOp     0xd5 /*!< Set Scout rules */
#define RCX_ViewSourceValOp  0xe5 /*!< View a source/value */
#define RCX_ScoutOp          0x47 /*!< Scout opcode */
#define RCX_SoundOp          0x57 /*!< Sound opcode */
#define RCX_GOutputModeOp    0x67 /*!< Set global motor mode */
#define RCX_GOutputDirOp     0x77 /*!< Set global motor direction */
#define RCX_LightOp          0x87 /*!< Light opcode */
#define RCX_IncCounterOp     0x97 /*!< Increment a counter */
#define RCX_DecCounterOp     0xa7 /*!< Decrement a counter */
#define RCX_ClearCounterOp   0xb7 /*!< Clear a counter */
#define RCX_SetPriorityOp    0xd7 /*!< Set task priority */
#define RCX_MessageOp        0xf7 /*!< Set message */
/** @} */  // end of RCXOpcodeConstants group
/** @} */  // end of RCXAPIConstants group

/** @defgroup HTIRLinkPFConstants HiTechnic/mindsensors Power Function/IR Train constants
 * Constants that are for use with the HiTechnic IRLink or mindsensors nRLink
 * in Power Function or IR Train mode.
 * @{
 */
/** @defgroup PFCmdConstants Power Function command constants
 * Constants that are for sending Power Function commands.
 * @{
 */
#define PF_CMD_STOP  0 /*!< Power function command stop */
#define PF_CMD_FLOAT 0 /*!< Power function command float (same as stop) */
#define PF_CMD_FWD   1 /*!< Power function command forward */
#define PF_CMD_REV   2 /*!< Power function command reverse */
#define PF_CMD_BRAKE 3 /*!< Power function command brake */
/** @} */  // end of PFCmdConstants group

/** @defgroup PFChannelConstants Power Function channel constants
 * Constants that are for specifying Power Function channels.
 * @{
 */
#define PF_CHANNEL_1 0 /*!< Power function channel 1 */
#define PF_CHANNEL_2 1 /*!< Power function channel 2 */
#define PF_CHANNEL_3 2 /*!< Power function channel 3 */
#define PF_CHANNEL_4 3 /*!< Power function channel 4 */
/** @} */  // end of PFChannelConstants group

/** @defgroup PFModeConstants Power Function mode constants
 * Constants that are for choosing Power Function modes.
 * @{
 */
#define PF_MODE_TRAIN             0 /*!< Power function mode IR Train */
#define PF_MODE_COMBO_DIRECT      1 /*!< Power function mode combo direct */
#define PF_MODE_SINGLE_PIN_CONT   2 /*!< Power function mode single pin continuous */
#define PF_MODE_SINGLE_PIN_TIME   3 /*!< Power function mode single pin timed */
#define PF_MODE_COMBO_PWM         4 /*!< Power function mode combo pulse width modulation (PWM) */
#define PF_MODE_SINGLE_OUTPUT_PWM 4 /*!< Power function mode single output pulse width modulation (PWM) */
#define PF_MODE_SINGLE_OUTPUT_CST 6 /*!< Power function mode single output clear, set, toggle (CST) */
/** @} */  // end of PFModeConstants group

/** @defgroup IRTrainFuncs PF/IR Train function constants
 * Constants that are for sending PF/IR Train functions.
 * @{
 */
#define TRAIN_FUNC_STOP         0 /*!< PF/IR Train function stop */
#define TRAIN_FUNC_INCR_SPEED   1 /*!< PF/IR Train function increment speed */
#define TRAIN_FUNC_DECR_SPEED   2 /*!< PF/IR Train function decrement speed */
#define TRAIN_FUNC_TOGGLE_LIGHT 4 /*!< PF/IR Train function toggle light */
/** @} */  // end of IRTrainFuncs group

/** @defgroup IRTrainChannels IR Train channel constants
 * Constants that are for specifying IR Train channels.
 * @{
 */
#define TRAIN_CHANNEL_1   0 /*!< IR Train channel 1 */
#define TRAIN_CHANNEL_2   1 /*!< IR Train channel 2 */
#define TRAIN_CHANNEL_3   2 /*!< IR Train channel 3 */
#define TRAIN_CHANNEL_ALL 3 /*!< IR Train channel all */
/** @} */  // end of IRTrainChannels group

/** @defgroup PFOutputs Power Function output constants
 * Constants that are for choosing a Power Function output.
 * @{
 */
#define PF_OUT_A 0 /*!< Power function output A */
#define PF_OUT_B 1 /*!< Power function output B */
/** @} */  // end of PFOutputs group

/** @defgroup PFPinConstants Power Function pin constants
 * Constants that are for choosing a Power Function pin.
 * @{
 */
#define PF_PIN_C1 0 /*!< Power function pin C1 */
#define PF_PIN_C2 1 /*!< Power function pin C2 */
/** @} */  // end of PFOutputs group

/** @defgroup PFPinFuncs Power Function single pin function constants
 * Constants that are for sending Power Function single pin functions.
 * @{
 */
#define PF_FUNC_NOCHANGE 0 /*!< Power function single pin - no change */
#define PF_FUNC_CLEAR    1 /*!< Power function single pin - clear */
#define PF_FUNC_SET      2 /*!< Power function single pin - set */
#define PF_FUNC_TOGGLE   3 /*!< Power function single pin - toggle */
/** @} */  // end of PFCSTFuncs group

/** @defgroup PFCSTOptions Power Function CST options constants
 * Constants that are for specifying Power Function CST options.
 * @{
 */
#define PF_CST_CLEAR1_CLEAR2 0 /*!< Power function CST clear 1 and clear 2 */
#define PF_CST_SET1_CLEAR2   1 /*!< Power function CST set 1 and clear 2*/
#define PF_CST_CLEAR1_SET2   2 /*!< Power function CST clear 1 and set 2 */
#define PF_CST_SET1_SET2     3 /*!< Power function CST set 1 and set 2 */
#define PF_CST_INCREMENT_PWM 4 /*!< Power function CST increment PWM */
#define PF_CST_DECREMENT_PWM 5 /*!< Power function CST decrement PWM */
#define PF_CST_FULL_FWD      6 /*!< Power function CST full forward */
#define PF_CST_FULL_REV      7 /*!< Power function CST full reverse */
#define PF_CST_TOGGLE_DIR    8 /*!< Power function CST toggle direction*/
/** @} */  // end of PFCSTOptions group

/** @defgroup PFPWMOptions Power Function PWM option constants
 * Constants that are for specifying Power Function PWM options.
 * @{
 */
#define PF_PWM_FLOAT 0  /*!< Power function PWM float */
#define PF_PWM_FWD1  1  /*!< Power function PWM foward level 1 */
#define PF_PWM_FWD2  2  /*!< Power function PWM foward level 2 */
#define PF_PWM_FWD3  3  /*!< Power function PWM foward level 3 */
#define PF_PWM_FWD4  4  /*!< Power function PWM foward level 4 */
#define PF_PWM_FWD5  5  /*!< Power function PWM foward level 5 */
#define PF_PWM_FWD6  6  /*!< Power function PWM foward level 6 */
#define PF_PWM_FWD7  7  /*!< Power function PWM foward level 7 */
#define PF_PWM_BRAKE 8  /*!< Power function PWM brake */
#define PF_PWM_REV7  9  /*!< Power function PWM reverse level 7  */
#define PF_PWM_REV6  10 /*!< Power function PWM reverse level 6 */
#define PF_PWM_REV5  11 /*!< Power function PWM reverse level 5 */
#define PF_PWM_REV4  12 /*!< Power function PWM reverse level 4 */
#define PF_PWM_REV3  13 /*!< Power function PWM reverse level 3 */
#define PF_PWM_REV2  14 /*!< Power function PWM reverse level 2 */
#define PF_PWM_REV1  15 /*!< Power function PWM reverse level 1 */
/** @} */  // end of PFPWMOptions group
/** @} */  // end of HTIRLinkPFConstants group

/** @addtogroup HiTechnicAPI
 * @{
 */
/** @defgroup HiTechnicConstants HiTechnic device constants
 * Constants that are for use with HiTechnic devices.
 * @{
 */

#define HT_ADDR_IRSEEKER   0x02 /*!< HiTechnic IRSeeker I2C address */
#define HT_ADDR_IRSEEKER2  0x10 /*!< HiTechnic IRSeeker2 I2C address */
#define HT_ADDR_IRRECEIVER 0x02 /*!< HiTechnic IRReceiver I2C address */
#define HT_ADDR_COMPASS    0x02 /*!< HiTechnic Compass I2C address */
#define HT_ADDR_ACCEL      0x02 /*!< HiTechnic Accel I2C address */
#define HT_ADDR_COLOR      0x02 /*!< HiTechnic Color I2C address */
#define HT_ADDR_COLOR2     0x02 /*!< HiTechnic Color2 I2C address */
#define HT_ADDR_IRLINK     0x02 /*!< HiTechnic IRLink I2C address */
#define HT_ADDR_ANGLE      0x02 /*!< HiTechnic Angle I2C address */

/** @defgroup HTIRSeeker2Constants HiTechnic IRSeeker2 constants
 * Constants that are for use with the HiTechnic IRSeeker2 device.
 * @{
 */
#define HTIR2_MODE_1200 0 /*!< Set IRSeeker2 to 1200 mode */
#define HTIR2_MODE_600  1 /*!< Set IRSeeker2 to 600 mode */

#define HTIR2_REG_MODE  0x41 /*!< IRSeeker2 mode register */
#define HTIR2_REG_DCDIR 0x42 /*!< IRSeeker2 DC direction register */
#define HTIR2_REG_DC01  0x43 /*!< IRSeeker2 DC 01 register */
#define HTIR2_REG_DC02  0x44 /*!< IRSeeker2 DC 02 register */
#define HTIR2_REG_DC03  0x45 /*!< IRSeeker2 DC 03 register */
#define HTIR2_REG_DC04  0x46 /*!< IRSeeker2 DC 04 register */
#define HTIR2_REG_DC05  0x47 /*!< IRSeeker2 DC 05 register */
#define HTIR2_REG_DCAVG 0x48 /*!< IRSeeker2 DC average register */
#define HTIR2_REG_ACDIR 0x49 /*!< IRSeeker2 AC direction register */
#define HTIR2_REG_AC01  0x4A /*!< IRSeeker2 AC 01 register */
#define HTIR2_REG_AC02  0x4B /*!< IRSeeker2 AC 02 register */
#define HTIR2_REG_AC03  0x4C /*!< IRSeeker2 AC 03 register */
#define HTIR2_REG_AC04  0x4D /*!< IRSeeker2 AC 04 register */
#define HTIR2_REG_AC05  0x4E /*!< IRSeeker2 AC 05 register */
/** @} */  // end of HTIRSeeker2Constants group

/** @defgroup HTIRReceiverConstants HiTechnic IRReceiver constants
 * Constants that are for use with the HiTechnic IRReceiver device.
 * @{
 */
#define HT_CH1_A 0 /*!< Use IRReceiver channel 1 output A */
#define HT_CH1_B 1 /*!< Use IRReceiver channel 1 output B */
#define HT_CH2_A 2 /*!< Use IRReceiver channel 2 output A */
#define HT_CH2_B 3 /*!< Use IRReceiver channel 2 output B */
#define HT_CH3_A 4 /*!< Use IRReceiver channel 3 output A */
#define HT_CH3_B 5 /*!< Use IRReceiver channel 3 output B */
#define HT_CH4_A 6 /*!< Use IRReceiver channel 4 output A */
#define HT_CH4_B 7 /*!< Use IRReceiver channel 4 output B */
/** @} */  // end of HTIRSeeker2Constants group

/** @defgroup HTColor2Constants HiTechnic Color2 constants
 * Constants that are for use with the HiTechnic Color2 device.
 * @{
 */
#define HT_CMD_COLOR2_ACTIVE  0x00 /*!< Set the Color2 sensor to active mode */
#define HT_CMD_COLOR2_PASSIVE 0x01 /*!< Set the Color2 sensor to passive mode */
#define HT_CMD_COLOR2_RAW     0x03 /*!< Set the Color2 sensor to raw mode */
#define HT_CMD_COLOR2_50HZ    0x35 /*!< Set the Color2 sensor to 50Hz mode */
#define HT_CMD_COLOR2_60HZ    0x36 /*!< Set the Color2 sensor to 60Hz mode */
#define HT_CMD_COLOR2_BLCAL   0x42 /*!< Set the Color2 sensor to black level calibration mode */
#define HT_CMD_COLOR2_WBCAL   0x43 /*!< Set the Color2 sensor to white level calibration mode */
#define HT_CMD_COLOR2_FAR     0x46 /*!< Set the Color2 sensor to far mode */
#define HT_CMD_COLOR2_LED_HI  0x48 /*!< Set the Color2 sensor to LED high mode */
#define HT_CMD_COLOR2_LED_LOW 0x4C /*!< Set the Color2 sensor to LED low mode */
#define HT_CMD_COLOR2_NEAR    0x4E /*!< Set the Color2 sensor to near mode */
/** @} */  // end of HTColor2Constants group

/** @defgroup HTAngleConstants HiTechnic Angle sensor constants
 * Constants that are for use with the HiTechnic Angle sensor device.
 * @{
 */
#define HTANGLE_MODE_NORMAL    0x00 /*!< Normal angle measurement mode */
#define HTANGLE_MODE_CALIBRATE 0x43 /*!< Resets 0 degree position to current shaft angle */
#define HTANGLE_MODE_RESET     0x52 /*!< Resets the accumulated angle */

#define HTANGLE_REG_MODE  0x41 /*!< Angle mode register */
#define HTANGLE_REG_DCDIR 0x42 /*!< Angle current angle (2 degree increments) register */
#define HTANGLE_REG_DC01  0x43 /*!< Angle current angle (1 degree adder) register */
#define HTANGLE_REG_DC02  0x44 /*!< Angle 32 bit accumulated angle, high byte register */
#define HTANGLE_REG_DC03  0x45 /*!< Angle 32 bit accumulated angle, mid byte register */
#define HTANGLE_REG_DC04  0x46 /*!< Angle 32 bit accumulated angle, mid byte register */
#define HTANGLE_REG_DC05  0x47 /*!< Angle 32 bit accumulated angle, low byte register */
#define HTANGLE_REG_DCAVG 0x48 /*!< Angle 16 bit revolutions per minute, high byte register */
#define HTANGLE_REG_ACDIR 0x49 /*!< Angle 16 bit revolutions per minute, low byte register */
/** @} */  // end of HTAngleConstants group


/** @} */  // end of HiTechnicConstants group
/** @} */  // end of HiTechnicAPI group


/** @addtogroup MindSensorsAPI
 * @{
 */
/** @defgroup MindSensorsConstants MindSensors device constants
 * Constants that are for use with MindSensors devices.
 * @{
 */
// MindSensors constants
#define MS_CMD_ENERGIZED   0x45 /*!< Energize the MindSensors device */
#define MS_CMD_DEENERGIZED 0x44 /*!< De-energize the MindSensors device */
#define MS_CMD_ADPA_ON     0x4E /*!< Turn MindSensors ADPA mode on */
#define MS_CMD_ADPA_OFF    0x4F /*!< Turn MindSensors ADPA mode off */

#define MS_ADDR_RTCLOCK     0xD0 /*!< MindSensors RTClock I2C address */
#define MS_ADDR_DISTNX      0x02 /*!< MindSensors DIST-Nx I2C address */
#define MS_ADDR_NRLINK      0x02 /*!< MindSensors NRLink I2C address */
#define MS_ADDR_ACCLNX      0x02 /*!< MindSensors ACCL-Nx I2C address */
#define MS_ADDR_CMPSNX      0x02 /*!< MindSensors CMPS-Nx I2C address */
#define MS_ADDR_PSPNX       0x02 /*!< MindSensors PSP-Nx I2C address */
#define MS_ADDR_LINELDR     0x02 /*!< MindSensors LineLdr I2C address */
#define MS_ADDR_NXTCAM      0x02 /*!< MindSensors NXTCam I2C address */
#define MS_ADDR_NXTHID      0x04 /*!< MindSensors NXTHID I2C address */
#define MS_ADDR_NXTSERVO    0xB0 /*!< MindSensors NXTServo I2C address */
#define MS_ADDR_NXTSERVO_EM 0x40 /*!< MindSensors NXTServo in edit macro mode I2C address */
#define MS_ADDR_PFMATE      0x48 /*!< MindSensors PFMate I2C address */
#define MS_ADDR_MTRMUX      0xB4 /*!< MindSensors MTRMux I2C address */
#define MS_ADDR_NXTMMX      0x06 /*!< MindSensors NXTMMX I2C address */
#define MS_ADDR_IVSENS      0x12 /*!< MindSensors IVSens (NXTPowerMeter) I2C address */
#define MS_ADDR_RXMUX       0x7E /*!< MindSensors RXMux I2C address */

/** @defgroup MSDistNX MindSensors DIST-Nx constants
 * Constants that are for use with the MindSensors DIST-Nx device.
 * @{
 */
// DIST-Nx Commands
#define DIST_CMD_GP2D12      0x31 /*!< Set the DIST-Nx to GP2D12 mode */
#define DIST_CMD_GP2D120     0x32 /*!< Set the DIST-Nx to GP2D120 mode */
#define DIST_CMD_GP2YA21     0x33 /*!< Set the DIST-Nx to GP2YA21 mode */
#define DIST_CMD_GP2YA02     0x34 /*!< Set the DIST-Nx to GP2YA02 mode */
#define DIST_CMD_CUSTOM      0x35 /*!< Set the DIST-Nx to a custom mode */

// DIST-Nx Registers
#define DIST_REG_DIST          0x42 /*!< The DIST-Nx distance register */
#define DIST_REG_VOLT          0x44 /*!< The DIST-Nx voltage register */
#define DIST_REG_MODULE_TYPE   0x50 /*!< The DIST-Nx module type register */
#define DIST_REG_NUM_POINTS    0x51 /*!< The DIST-Nx number of data points in Custom curve register */
#define DIST_REG_DIST_MIN      0x52 /*!< The DIST-Nx minimum distance register */
#define DIST_REG_DIST_MAX      0x54 /*!< The DIST-Nx maximum distance register */
#define DIST_REG_VOLT1         0x56 /*!< The DIST-Nx voltage 1 register */
#define DIST_REG_DIST1         0x58 /*!< The DIST-Nx distance 1 register */
/** @} */  // end of MSDistNX group

/** @defgroup MSPSPNX MindSensors PSP-Nx constants
 * Constants that are for use with the MindSensors PSP-Nx device.
 * @{
 */
// PSP-Nx commands
#define PSP_CMD_DIGITAL 0x41 /*!< Set the PSP-Nx to digital mode */
#define PSP_CMD_ANALOG  0x73 /*!< Set the PSP-Nx to analog mode */

// PSP-Nx registers
#define PSP_REG_BTNSET1 0x42 /*!< The PSP-Nx button set 1 register */
#define PSP_REG_BTNSET2 0x43 /*!< The PSP-Nx button set 2 register */
#define PSP_REG_XLEFT   0x44 /*!< The PSP-Nx X left register */
#define PSP_REG_YLEFT   0x45 /*!< The PSP-Nx Y left register */
#define PSP_REG_XRIGHT  0x46 /*!< The PSP-Nx X right register */
#define PSP_REG_YRIGHT  0x47 /*!< The PSP-Nx Y right register */

/** @defgroup MSPSPNXBtnSet1 MindSensors PSP-Nx button set 1 constants
 * Constants that are for interpretting MindSensors PSP-Nx button set 1 values.
 * @{
 */
#define PSP_BTNSET1_LEFT     0x01 /*!< The PSP-Nx button set 1 left arrow */
#define PSP_BTNSET1_DOWN     0x02 /*!< The PSP-Nx button set 1 down arrow */
#define PSP_BTNSET1_RIGHT    0x04 /*!< The PSP-Nx button set 1 right arrow */
#define PSP_BTNSET1_UP       0x08 /*!< The PSP-Nx button set 1 up arrow */
#define PSP_BTNSET1_R3       0x20 /*!< The PSP-Nx button set 1 R3 */
#define PSP_BTNSET1_L3       0x40 /*!< The PSP-Nx button set 1 L3 */
/** @} */  // end of MSPSPNXBtnSet1 group

/** @defgroup MSPSPNXBtnSet2 MindSensors PSP-Nx button set 2 constants
 * Constants that are for interpretting MindSensors PSP-Nx button set 2 values.
 * @{
 */
#define PSP_BTNSET2_SQUARE   0x01 /*!< The PSP-Nx button set 2 square */
#define PSP_BTNSET2_CROSS    0x02 /*!< The PSP-Nx button set 2 cross */
#define PSP_BTNSET2_CIRCLE   0x04 /*!< The PSP-Nx button set 2 circle */
#define PSP_BTNSET2_TRIANGLE 0x08 /*!< The PSP-Nx button set 2 triangle */
#define PSP_BTNSET2_R1       0x10 /*!< The PSP-Nx button set 2 R1 */
#define PSP_BTNSET2_L1       0x20 /*!< The PSP-Nx button set 2 L1 */
#define PSP_BTNSET2_R2       0x40 /*!< The PSP-Nx button set 2 R2 */
#define PSP_BTNSET2_L2       0x80 /*!< The PSP-Nx button set 2 L2 */
/** @} */  // end of MSPSPNXBtnSet2 group
/** @} */  // end of MSPSPNX group

/** @defgroup MSNRLink MindSensors nRLink constants
 * Constants that are for use with the MindSensors nRLink device.
 * @{
 */
// NRLink commands
#define NRLINK_CMD_2400      0x44 /*!< Set NRLink to 2400 baud */
#define NRLINK_CMD_FLUSH     0x46 /*!< Flush the NRLink */
#define NRLINK_CMD_4800      0x48 /*!< Set NRLink to 4800 baud */
#define NRLINK_CMD_IR_LONG   0x4C /*!< Set the NRLink to long range IR */
#define NRLINK_CMD_IR_SHORT  0x53 /*!< Set the NRLink to short range IR */
#define NRLINK_CMD_RUN_MACRO 0x52 /*!< Run an NRLink macro */
#define NRLINK_CMD_TX_RAW    0x55 /*!< Set the NRLink to transmit raw bytes */
#define NRLINK_CMD_SET_RCX   0x58 /*!< Set the NRLink to RCX mode */
#define NRLINK_CMD_SET_TRAIN 0x54 /*!< Set the NRLink to IR Train mode */
#define NRLINK_CMD_SET_PF    0x50 /*!< Set the NRLink to Power Function mode */

// NRLink registers
#define NRLINK_REG_BYTES  0x40 /*!< The NRLink bytes register */
#define NRLINK_REG_DATA   0x42 /*!< The NRLink data register */
#define NRLINK_REG_EEPROM 0x50 /*!< The NRLink eeprom register */

/** @} */  // end of MSNRLink group

/** @defgroup MSACCLNx MindSensors ACCL-Nx constants
 * Constants that are for use with the MindSensors ACCL-Nx device.
 * @{
 */
// ACCL-Nx commands
#define ACCL_CMD_X_CAL      0x58 /*!< Acquire X-axis calibration point */
#define ACCL_CMD_Y_CAL      0x59 /*!< Acquire Y-axis calibration point */
#define ACCL_CMD_Z_CAL      0x5a /*!< Acquire Z-axis calibration point */
#define ACCL_CMD_X_CAL_END  0x78 /*!< Acquire X-axis calibration point and end calibration */
#define ACCL_CMD_Y_CAL_END  0x79 /*!< Acquire Y-axis calibration point and end calibration */
#define ACCL_CMD_Z_CAL_END  0x7a /*!< Acquire Z-axis calibration point and end calibration */
#define ACCL_CMD_RESET_CAL  0x52 /*!< Reset to factory calibration */

// ACCL-Nx registers
#define ACCL_REG_SENS_LVL 0x19 /*!< The current sensitivity */
#define ACCL_REG_X_TILT   0x42 /*!< The X-axis tilt data */
#define ACCL_REG_Y_TILT   0x43 /*!< The Y-axis tilt data */
#define ACCL_REG_Z_TILT   0x44 /*!< The Z-axis tilt data */
#define ACCL_REG_X_ACCEL  0x45 /*!< The X-axis acceleration data */
#define ACCL_REG_Y_ACCEL  0x47 /*!< The Y-axis acceleration data */
#define ACCL_REG_Z_ACCEL  0x49 /*!< The Z-axis acceleration data */
#define ACCL_REG_X_OFFSET 0x4b /*!< The X-axis offset */
#define ACCL_REG_X_RANGE  0x4d /*!< The X-axis range */
#define ACCL_REG_Y_OFFSET 0x4f /*!< The Y-axis offset */
#define ACCL_REG_Y_RANGE  0x51 /*!< The Y-axis range */
#define ACCL_REG_Z_OFFSET 0x53 /*!< The Z-axis offset */
#define ACCL_REG_Z_RANGE  0x55 /*!< The Z-axis range */

/** @defgroup MSACCLNxSLevel MindSensors ACCL-Nx sensitivity level constants
 * Constants that are for setting the MindSensors ACCL-Nx sensitivity level.
 * @{
 */
#define ACCL_SENSITIVITY_LEVEL_1 0x31 /*!< The ACCL-Nx sensitivity level 1 */
#define ACCL_SENSITIVITY_LEVEL_2 0x32 /*!< The ACCL-Nx sensitivity level 2 */
#define ACCL_SENSITIVITY_LEVEL_3 0x33 /*!< The ACCL-Nx sensitivity level 3 */
#define ACCL_SENSITIVITY_LEVEL_4 0x34 /*!< The ACCL-Nx sensitivity level 4 */
/** @} */  // end of MSACCLNxSLevel group

/** @} */  // end of MSACCLNx group

/** @defgroup PFMateConstants MindSensors PFMate constants
 * Constants that are for use with the MindSensors PFMate device.
 * @{
 */
#define PFMATE_REG_CMD     0x41 /*!< PFMate command */
#define PFMATE_REG_CHANNEL 0x42 /*!< PF channel? 1, 2, 3, or 4 */
#define PFMATE_REG_MOTORS  0x43 /*!< PF motors? (0 = both, 1 = A, 2 = B) */
#define PFMATE_REG_A_CMD   0x44 /*!< PF command for motor A? (PF_CMD_FLOAT, PF_CMD_FWD, PF_CMD_REV, PF_CMD_BRAKE) */
#define PFMATE_REG_A_SPEED 0x45 /*!< PF speed for motor A? (0-7) */
#define PFMATE_REG_B_CMD   0x46 /*!< PF command for motor B? (PF_CMD_FLOAT, PF_CMD_FWD, PF_CMD_REV, PF_CMD_BRAKE) */
#define PFMATE_REG_B_SPEED 0x47 /*!< PF speed for motor B? (0-7) */

#define PFMATE_CMD_GO      0x47 /*!< Send IR signal to IR receiver */
#define PFMATE_CMD_RAW     0x52 /*!< Send raw IR signal to IR receiver */

/** @defgroup PFMateMotorConstants PFMate motor constants
 * Constants that are for specifying PFMate motors.
 * @{
 */
#define PFMATE_MOTORS_BOTH 0x00 /*!< Control both motors */
#define PFMATE_MOTORS_A    0x01 /*!< Control only motor A */
#define PFMATE_MOTORS_B    0x02 /*!< Control only motor B */
/** @} */  // end of PFMateMotorConstants group

/** @defgroup PFMateChannelConstants PFMate channel constants
 * Constants that are for specifying PFMate channels.
 * @{
 */
#define PFMATE_CHANNEL_1 1 /*!< Power function channel 1 */
#define PFMATE_CHANNEL_2 2 /*!< Power function channel 2 */
#define PFMATE_CHANNEL_3 3 /*!< Power function channel 3 */
#define PFMATE_CHANNEL_4 4 /*!< Power function channel 4 */
/** @} */  // end of PFMateChannelConstants group

/** @} */  // end of PFMateConstants group

/** @defgroup NXTServoConstants MindSensors NXTServo constants
 * Constants that are for use with the MindSensors NXTServo device.
 * @{
 */
/** @defgroup NXTServoRegisters MindSensors NXTServo registers
 * NXTServo device register constants.
 * @{
 */
#define NXTSERVO_REG_VOLTAGE   0x41 /*!< Battery voltage register. (read only) */
#define NXTSERVO_REG_CMD       0x41 /*!< NXTServo command register.  See \ref NXTServoCommands group. (write only) */
// position registers (2 bytes little endian)
#define NXTSERVO_REG_S1_POS    0x42 /*!< NXTServo servo 1 position register. */
#define NXTSERVO_REG_S2_POS    0x44 /*!< NXTServo servo 2 position register. */
#define NXTSERVO_REG_S3_POS    0x46 /*!< NXTServo servo 3 position register. */
#define NXTSERVO_REG_S4_POS    0x48 /*!< NXTServo servo 4 position register. */
#define NXTSERVO_REG_S5_POS    0x4A /*!< NXTServo servo 5 position register. */
#define NXTSERVO_REG_S6_POS    0x4C /*!< NXTServo servo 6 position register. */
#define NXTSERVO_REG_S7_POS    0x4E /*!< NXTServo servo 7 position register. */
#define NXTSERVO_REG_S8_POS    0x50 /*!< NXTServo servo 8 position register. */
// speed registers
#define NXTSERVO_REG_S1_SPEED  0x52 /*!< NXTServo servo 1 speed register. */
#define NXTSERVO_REG_S2_SPEED  0x53 /*!< NXTServo servo 2 speed register. */
#define NXTSERVO_REG_S3_SPEED  0x54 /*!< NXTServo servo 3 speed register. */
#define NXTSERVO_REG_S4_SPEED  0x55 /*!< NXTServo servo 4 speed register. */
#define NXTSERVO_REG_S5_SPEED  0x56 /*!< NXTServo servo 5 speed register. */
#define NXTSERVO_REG_S6_SPEED  0x57 /*!< NXTServo servo 6 speed register. */
#define NXTSERVO_REG_S7_SPEED  0x58 /*!< NXTServo servo 7 speed register. */
#define NXTSERVO_REG_S8_SPEED  0x59 /*!< NXTServo servo 8 speed register. */
// quick position registers
#define NXTSERVO_REG_S1_QPOS   0x5A /*!< NXTServo servo 1 quick position register. (write only) */
#define NXTSERVO_REG_S2_QPOS   0x5B /*!< NXTServo servo 2 quick position register. (write only) */
#define NXTSERVO_REG_S3_QPOS   0x5C /*!< NXTServo servo 3 quick position register. (write only) */
#define NXTSERVO_REG_S4_QPOS   0x5D /*!< NXTServo servo 4 quick position register. (write only) */
#define NXTSERVO_REG_S5_QPOS   0x5E /*!< NXTServo servo 5 quick position register. (write only) */
#define NXTSERVO_REG_S6_QPOS   0x5F /*!< NXTServo servo 6 quick position register. (write only) */
#define NXTSERVO_REG_S7_QPOS   0x60 /*!< NXTServo servo 7 quick position register. (write only) */
#define NXTSERVO_REG_S8_QPOS   0x61 /*!< NXTServo servo 8 quick position register. (write only) */

#define NXTSERVO_EM_REG_CMD          0x00 /*!< NXTServo in macro edit mode command register. */
#define NXTSERVO_EM_REG_EEPROM_START 0x21 /*!< NXTServo in macro edit mode EEPROM start register. */
#define NXTSERVO_EM_REG_EEPROM_END   0xFF /*!< NXTServo in macro edit mode EEPROM end register. */
/** @} */  // end of NXTServoRegisters group

/** @defgroup NXTServoPos MindSensors NXTServo position constants
 * NXTServo device position constants.
 * @{
 */
#define NXTSERVO_POS_CENTER 1500 /*!< Center position for 1500us servos. */
#define NXTSERVO_POS_MIN     500 /*!< Minimum position for 1500us servos. */
#define NXTSERVO_POS_MAX    2500 /*!< Maximum position for 1500us servos. */
/** @} */  // end of NXTServoPos group

/** @defgroup NXTServoQPos MindSensors NXTServo quick position constants
 * NXTServo device quick position constants.
 * @{
 */
#define NXTSERVO_QPOS_CENTER 150 /*!< Center quick position for 1500us servos. */
#define NXTSERVO_QPOS_MIN     50 /*!< Minimum quick position for 1500us servos. */
#define NXTSERVO_QPOS_MAX    250 /*!< Maximum quick position for 1500us servos. */
/** @} */  // end of NXTServoQPos group

/** @defgroup NXTServoNumbers MindSensors NXTServo servo numbers
 * NXTServo device servo number constants.
 * @{
 */
#define NXTSERVO_SERVO_1 0 /*!< NXTServo server number 1. */
#define NXTSERVO_SERVO_2 1 /*!< NXTServo server number 2. */
#define NXTSERVO_SERVO_3 2 /*!< NXTServo server number 3. */
#define NXTSERVO_SERVO_4 3 /*!< NXTServo server number 4. */
#define NXTSERVO_SERVO_5 4 /*!< NXTServo server number 5. */
#define NXTSERVO_SERVO_6 5 /*!< NXTServo server number 6. */
#define NXTSERVO_SERVO_7 6 /*!< NXTServo server number 7. */
#define NXTSERVO_SERVO_8 7 /*!< NXTServo server number 8. */
/** @} */  // end of NXTServoNumbers group

/** @defgroup NXTServoCommands MindSensors NXTServo commands
 * NXTServo device command constants. These are written to the command register
 * to control the device.
 * @{
 */
#define NXTSERVO_CMD_INIT    0x49 /*!< Store the initial speed and position properties of the servo motor 'n'. Current speed and position values of the nth servo is read from the servo speed register and servo position register and written to permanent memory. */
#define NXTSERVO_CMD_RESET   0x53 /*!< Reset servo properties to factory default.  Initial Position of servos to 1500, and speed to 0. */
#define NXTSERVO_CMD_HALT    0x48 /*!< Halt Macro. This command re-initializes the macro environment. */
#define NXTSERVO_CMD_RESUME  0x52 /*!< Resume macro Execution. This command resumes macro where it was paused last, using the same environment. */
#define NXTSERVO_CMD_GOTO    0x47 /*!< Goto EEPROM position x. This command re-initializes the macro environment. */
#define NXTSERVO_CMD_PAUSE   0x50 /*!< Pause Macro. This command will pause the macro, and save the environment for subsequent resumption. */
#define NXTSERVO_CMD_EDIT1   0x45 /*!< Edit Macro (part 1 of 2 character command sequence) */
#define NXTSERVO_CMD_EDIT2   0x4D /*!< Edit Macro (part 2 of 2 character command sequence) */
#define NXTSERVO_EM_CMD_QUIT 0x51 /*!< Exit edit macro mode */
/** @} */  // end of NXTServoCommands group
/** @} */  // end of NXTServoConstants group

/** @defgroup NXTHIDConstants MindSensors NXTHID constants
 * Constants that are for use with the MindSensors NXTHID device.
 * @{
 */
/** @defgroup NXTHIDRegisters MindSensors NXTHID registers
 * NXTHID device register constants.
 * @{
 */
#define NXTHID_REG_CMD       0x41 /*!< NXTHID command register.  See \ref NXTHIDCommands group. */
#define NXTHID_REG_MODIFIER  0x42 /*!< NXTHID modifier register.  See \ref NXTHIDModifiers group. */
#define NXTHID_REG_DATA      0x43 /*!< NXTHID data register. */
/** @} */  // end of NXTHIDRegisters group

/** @defgroup NXTHIDModifiers MindSensors NXTHID modifier keys
 * NXTHID device modifier key constants.
 * @{
 */
#define NXTHID_MOD_NONE        0x00 /*!< NXTHID no modifier. */
#define NXTHID_MOD_LEFT_CTRL   0x01 /*!< NXTHID left control modifier. */
#define NXTHID_MOD_LEFT_SHIFT  0x02 /*!< NXTHID left shift modifier. */
#define NXTHID_MOD_LEFT_ALT    0x04 /*!< NXTHID left alt modifier. */
#define NXTHID_MOD_LEFT_GUI    0x08 /*!< NXTHID left gui modifier. */
#define NXTHID_MOD_RIGHT_CTRL  0x10 /*!< NXTHID right control modifier. */
#define NXTHID_MOD_RIGHT_SHIFT 0x20 /*!< NXTHID right shift modifier. */
#define NXTHID_MOD_RIGHT_ALT   0x40 /*!< NXTHID right alt modifier. */
#define NXTHID_MOD_RIGHT_GUI   0x80 /*!< NXTHID right gui modifier. */
/** @} */  // end of NXTHIDModifiers group

/** @defgroup NXTHIDCommands MindSensors NXTHID commands
 * NXTHID device command constants. These are written to the command register
 * to control the device.
 * @{
 */
#define NXTHID_CMD_ASCII    0x41 /*!< Use ASCII data mode. In ASCII mode no non-printable characters can be sent. */
#define NXTHID_CMD_DIRECT   0x44 /*!< Use direct data mode In direct mode any character can be sent. */
#define NXTHID_CMD_TRANSMIT 0x54 /*!< Transmit data to the host computer. */
/** @} */  // end of NXTHIDCommands group
/** @} */  // end of NXTHIDConstants group

/** @defgroup NXTPowerMeterConstants MindSensors NXTPowerMeter constants
 * Constants that are for use with the MindSensors NXTPowerMeter device.
 * @{
 */
/** @defgroup NXTPowerMeterRegisters MindSensors NXTPowerMeter registers
 * NXTPowerMeter device register constants.
 * @{
 */
#define NXTPM_REG_CMD        0x41 /*!< NXTPowerMeter command register.  See the \ref NXTPowerMeterCommands group. */
#define NXTPM_REG_CURRENT    0x42 /*!< NXTPowerMeter present current in mA register. (2 bytes) */
#define NXTPM_REG_VOLTAGE    0x44 /*!< NXTPowerMeter present voltage in mV register. (2 bytes) */
#define NXTPM_REG_CAPACITY   0x46 /*!< NXTPowerMeter capacity used since last reset register. (2 bytes) */
#define NXTPM_REG_POWER      0x48 /*!< NXTPowerMeter present power register. (2 bytes) */
#define NXTPM_REG_TOTALPOWER 0x4A /*!< NXTPowerMeter total power consumed since last reset register. (4 bytes) */
#define NXTPM_REG_MAXCURRENT 0x4E /*!< NXTPowerMeter max current register. (2 bytes) */
#define NXTPM_REG_MINCURRENT 0x50 /*!< NXTPowerMeter min current register. (2 bytes) */
#define NXTPM_REG_MAXVOLTAGE 0x52 /*!< NXTPowerMeter max voltage register. (2 bytes) */
#define NXTPM_REG_MINVOLTAGE 0x54 /*!< NXTPowerMeter min voltage register. (2 bytes) */
#define NXTPM_REG_TIME       0x56 /*!< NXTPowerMeter time register. (4 bytes) */
#define NXTPM_REG_USERGAIN   0x5A /*!< NXTPowerMeter user gain register. Not yet implemented. (4 bytes) */
#define NXTPM_REG_GAIN       0x5E /*!< NXTPowerMeter gain register. (1 byte) */
#define NXTPM_REG_ERRORCOUNT 0x5F /*!< NXTPowerMeter error count register. (2 bytes) */
/** @} */  // end of NXTPowerMeterRegisters group

/** @defgroup NXTPowerMeterCommands MindSensors NXTPowerMeter commands
 * NXTPowerMeter device command constants. These are written to the command register
 * to control the device.
 * @{
 */
#define NXTPM_CMD_RESET    0x52 /*!< Reset counters. */
/** @} */  // end of NXTPowerMeterCommands group
/** @} */  // end of NXTPowerMeterConstants group

/** @defgroup NXTSumoEyesConstants MindSensors NXTSumoEyes constants
 * Constants that are for use with the MindSensors NXTSumoEyes device.
 * @{
 */
#define NXTSE_ZONE_NONE  0 /*!< Obstacle zone none. */
#define NXTSE_ZONE_FRONT 1 /*!< Obstacle zone front. */
#define NXTSE_ZONE_LEFT  2 /*!< Obstacle zone left. */
#define NXTSE_ZONE_RIGHT 3 /*!< Obstacle zone right. */
/** @} */  // end of NXTSumoEyesConstants group

/** @defgroup NXTLineLeaderConstants MindSensors NXTLineLeader constants
 * Constants that are for use with the MindSensors NXTLineLeader device.
 * @{
 */
/** @defgroup NXTLineLeaderRegisters MindSensors NXTLineLeader registers
 * NXTLineLeader device register constants.
 * @{
 */
#define NXTLL_REG_CMD         0x41 /*!< NXTLineLeader command register.  See the \ref NXTLineLeaderCommands group. */
#define NXTLL_REG_STEERING    0x42 /*!< NXTLineLeader steering register. */
#define NXTLL_REG_AVERAGE     0x43 /*!< NXTLineLeader average result register. */
#define NXTLL_REG_RESULT      0x44 /*!< NXTLineLeader result register (sensor bit values). */
#define NXTLL_REG_SETPOINT    0x45 /*!< NXTLineLeader user settable average (setpoint) register. Default = 45. */
#define NXTLL_REG_KP_VALUE    0x46 /*!< NXTLineLeader Kp value register. Default = 25. */
#define NXTLL_REG_KI_VALUE    0x47 /*!< NXTLineLeader Ki value register. Default = 0. */
#define NXTLL_REG_KD_VALUE    0x48 /*!< NXTLineLeader Kd value register. Default = 8. */
#define NXTLL_REG_CALIBRATED  0x49 /*!< NXTLineLeader calibrated sensor reading registers. 8 bytes. */
#define NXTLL_REG_WHITELIMITS 0x51 /*!< NXTLineLeader white limit registers. 8 bytes. */
#define NXTLL_REG_BLACKLIMITS 0x59 /*!< NXTLineLeader black limit registers. 8 bytes. */
#define NXTLL_REG_KP_FACTOR   0x61 /*!< NXTLineLeader Kp factor register. Default = 32. */
#define NXTLL_REG_KI_FACTOR   0x62 /*!< NXTLineLeader Ki factor register. Default = 32. */
#define NXTLL_REG_KD_FACTOR   0x63 /*!< NXTLineLeader Kd factor register. Default = 32. */
#define NXTLL_REG_WHITEDATA   0x64 /*!< NXTLineLeader white calibration data registers. 8 bytes. */
#define NXTLL_REG_BLACKDATA   0x6C /*!< NXTLineLeader black calibration data registers. 8 bytes. */
#define NXTLL_REG_RAWVOLTAGE  0x74 /*!< NXTLineLeader uncalibrated sensor voltage registers. 16 bytes. */
/** @} */  // end of NXTLineLeaderRegisters group

/** @defgroup NXTLineLeaderCommands MindSensors NXTLineLeader commands
 * NXTLineLeader device command constants. These are written to the command register
 * to control the device.
 * @{
 */
#define NXTLL_CMD_USA       0x41 /*!< USA power frequency. (60hz) */
#define NXTLL_CMD_BLACK     0x42 /*!< Black calibration. */
#define NXTLL_CMD_POWERDOWN 0x44 /*!< Power down the device. */
#define NXTLL_CMD_EUROPEAN  0x45 /*!< European power frequency. (50hz) */
#define NXTLL_CMD_INVERT    0x49 /*!< Invert color. */
#define NXTLL_CMD_POWERUP   0x50 /*!< Power up the device. */
#define NXTLL_CMD_RESET     0x52 /*!< Reset inversion. */
#define NXTLL_CMD_SNAPSHOT  0x53 /*!< Setpoint based on snapshot (automatically sets invert if needed). */
#define NXTLL_CMD_UNIVERSAL 0x55 /*!< Universal power frequency. The sensor auto adjusts for any frequency. This is the default mode. */
#define NXTLL_CMD_WHITE     0x57 /*!< White balance calibration. */
/** @} */  // end of NXTLineLeaderCommands group
/** @} */  // end of NXTLineLeaderConstants group

/** @} */  // end of MindSensorsConstants group
/** @} */  // end of MindSensorsAPI group


/** @addtogroup CodatexAPI
 * @{
 */
/** @defgroup CodatexConstants Codatex device constants
 * Constants that are for use with Codatex devices.
 * @{
 */
/** @defgroup CTRFIDConstants Codatex RFID sensor constants
 * Constants that are for use with the Codatex RFID sensor device.
 * @{
 */
/** @defgroup CTRFIDModeConstants Codatex RFID sensor modes
 * Constants that are for configuring the Codatex RFID sensor mode.
 * @{
 */
#define RFID_MODE_STOP       0  /*!< Stop the RFID device */
#define RFID_MODE_SINGLE     1  /*!< Configure the RFID device for a single reading */
#define RFID_MODE_CONTINUOUS 2  /*!< Configure the RFID device for continuous reading */
/** @} */  // end of CTRFIDModeConstants group

#define CT_ADDR_RFID     0x04   /*!< RFID I2C address */

#define CT_REG_STATUS    0x32   /*!< RFID status register */
#define CT_REG_MODE      0x41   /*!< RFID mode register */
#define CT_REG_DATA      0x42   /*!< RFID data register */

/** @} */  // end of CTRFIDConstants group
/** @} */  // end of CodatexConstants group
/** @} */  // end of CodatexAPI group

/** @} */  // end of ThirdPartyDevices group


/** @addtogroup RICMacros
 * @{
 */
/**
 * Output an RIC ImgPoint structure
 * \param _X The X coordinate.
 * \param _Y The Y coordinate.
 */
#define RICImgPoint(_X, _Y) (_X)&0xFF, (_X)>>8, (_Y)&0xFF, (_Y)>>8

/**
 * Output an RIC ImgRect structure
 * \param _Pt An ImgPoint. See \ref RICImgPoint.
 * \param _W The rectangle width.
 * \param _H The rectangle height.
 */
#define RICImgRect(_Pt, _W, _H) _Pt, (_W)&0xFF, (_W)>>8, (_H)&0xFF, (_H)>>8

/**
 * Output an RIC Description opcode
 * \param _Options RIC options.
 * \param _Width The total RIC width.
 * \param _Height The total RIC height.
 */
#define RICOpDescription(_Options, _Width, _Height) 8, 0, 0, 0, (_Options)&0xFF, (_Options)>>8, (_Width)&0xFF, (_Width)>>8, (_Height)&0xFF, (_Height)>>8

/**
 * Output an RIC CopyBits opcode
 * \param _CopyOptions CopyBits copy options.  See \ref DisplayDrawOptionConstants.
 * \param _DataAddr The address of the sprite from which to copy data.
 * \param _SrcRect The rectangular portion of the sprite to copy.  See \ref RICImgRect.
 * \param _DstPoint The LCD coordinate to which to copy the data.  See \ref RICImgPoint.
 */
#define RICOpCopyBits(_CopyOptions, _DataAddr, _SrcRect, _DstPoint) 18, 0, 3, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, (_DataAddr)&0xFF, (_DataAddr)>>8, _SrcRect, _DstPoint

/**
 * Output an RIC Pixel opcode
 * \param _CopyOptions Pixel copy options.  See \ref DisplayDrawOptionConstants.
 * \param _Point The pixel coordinate. See \ref RICImgPoint.
 * \param _Value The pixel value (unused).
 */
#define RICOpPixel(_CopyOptions, _Point, _Value) 10, 0, 4, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, _Point, (_Value)&0xFF, (_Value)>>8

/**
 * Output an RIC Line opcode
 * \param _CopyOptions Line copy options.  See \ref DisplayDrawOptionConstants.
 * \param _Point1 The starting point of the line.  See \ref RICImgPoint.
 * \param _Point2 The ending point of the line.  See \ref RICImgPoint.
 */
#define RICOpLine(_CopyOptions, _Point1, _Point2) 12, 0, 5, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, _Point1, _Point2

/**
 * Output an RIC Rect opcode
 * \param _CopyOptions Rect copy options.  See \ref DisplayDrawOptionConstants.
 * \param _Point The rectangle's top left corner.  See \ref RICImgPoint.
 * \param _Width The rectangle's width.
 * \param _Height The rectangle's height.
 */
#define RICOpRect(_CopyOptions, _Point, _Width, _Height) 12, 0, 6, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, _Point, (_Width)&0xFF, (_Width)>>8, (_Height)&0xFF, (_Height)>>8

/**
 * Output an RIC Circle opcode
 * \param _CopyOptions Circle copy options.  See \ref DisplayDrawOptionConstants.
 * \param _Point The circle's center point.  See \ref RICImgPoint.
 * \param _Radius The circle's radius.
 */
#define RICOpCircle(_CopyOptions, _Point, _Radius) 10, 0, 7, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, _Point, (_Radius)&0xFF, (_Radius)>>8

/**
 * Output an RIC NumBox opcode
 * \param _CopyOptions NumBox copy options.  See \ref DisplayDrawOptionConstants.
 * \param _Point The numbox bottom left corner.  See \ref RICImgPoint.
 * \param _Value The number to draw.
 */
#define RICOpNumBox(_CopyOptions, _Point, _Value) 10, 0, 8, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, _Point, (_Value)&0xFF, (_Value)>>8

/**
 * Output an RIC Sprite opcode
 * \param _DataAddr The address of the sprite.
 * \param _Rows The number of rows of data.
 * \param _BytesPerRow The number of bytes per row.
 * \param _SpriteData The actual sprite data. See \ref RICSpriteData.
 */
#define RICOpSprite(_DataAddr, _Rows, _BytesPerRow, _SpriteData) ((_Rows*_BytesPerRow)+((_Rows*_BytesPerRow)%2)+8)&0xFF, ((_Rows*_BytesPerRow)+((_Rows*_BytesPerRow)%2)+8)>>8, 1, 0, (_DataAddr)&0xFF, (_DataAddr)>>8, (_Rows)&0xFF, (_Rows)>>8, (_BytesPerRow)&0xFF, (_BytesPerRow)>>8, _SpriteData

/**
 * Output RIC sprite data
 */
#define RICSpriteData(...) __VA_ARGS__

/**
 * Output an RIC VarMap opcode
 * \param _DataAddr The address of the varmap.
 * \param _MapCount The number of points in the function.
 * \param _MapFunction The definition of the varmap function.  See \ref RICMapFunction.
 */
#define RICOpVarMap(_DataAddr, _MapCount, _MapFunction) ((_MapCount*4)+6)&0xFF, ((_MapCount*4)+6)>>8, 2, 0, (_DataAddr)&0xFF, (_DataAddr)>>8, (_MapCount)&0xFF, (_MapCount)>>8, _MapFunction

/**
 * Output an RIC map element
 * \param _Domain The map element domain.
 * \param _Range The map element range.
 */
#define RICMapElement(_Domain, _Range) (_Domain)&0xFF, (_Domain)>>8, (_Range)&0xFF, (_Range)>>8

/**
 * Output an RIC VarMap function
 * \param _MapElement An entry in the varmap function.  At least 2 elements are
 * required.  See \ref RICMapElement.
 */
#define RICMapFunction(_MapElement, ...) _MapElement, __VA_ARGS__

/**
 * Output an RIC parameterized argument
 * \param _arg The argument that you want to parameterize.
 */
#define RICArg(_arg) ((_arg)|0x1000)

/**
 * Output an RIC parameterized and mapped argument
 * \param _mapidx The varmap data address.
 * \param _arg The parameterized argument you want to pass through a varmap.
 */
#define RICMapArg(_mapidx, _arg) ((_arg)|0x1000|(((_mapidx)&0xF)<<8))

/**
 * Output an RIC Polygon opcode
 * \param _CopyOptions Polygon copy options.  See \ref DisplayDrawOptionConstants.
 * \param _Count The number of points in the polygon.
 * \param _ThePoints The list of polygon points.  See \ref RICPolygonPoints.
 */
#define RICOpPolygon(_CopyOptions, _Count, _ThePoints)  ((_Count*4)+6)&0xFF, ((_Count*4)+6)>>8, 10, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, (_Count)&0xFF, (_Count)>>8, _ThePoints

/**
 * Output RIC polygon points
 * \param _pPoint1 The first polygon point.  See \ref RICImgPoint.
 * \param _pPoint2 The second polygon point (at least 3 points are required).
 * See \ref RICImgPoint.
 */
#define RICPolygonPoints(_pPoint1, _pPoint2, ...) _pPoint1, _pPoint2, __VA_ARGS__

/**
 * Output an RIC Ellipse opcode
 * \param _CopyOptions Ellipse copy options.  See \ref DisplayDrawOptionConstants.
 * \param _Point The center of the ellipse. See \ref RICImgPoint.
 * \param _RadiusX The x-axis radius of the ellipse.
 * \param _RadiusY The y-axis radius of the ellipse.
 */
#define RICOpEllipse(_CopyOptions, _Point, _RadiusX, _RadiusY) 12, 0, 9, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, _Point, (_RadiusX)&0xFF, (_RadiusX)>>8, (_RadiusY)&0xFF, (_RadiusY)>>8

/** @} */  // end of RICMacros group

/** @addtogroup MiscConstants
 * @{
 */
/** @defgroup NXTLimits Data type limits
 * Constants that define various data type limits.
 * @{
 */
#define CHAR_BIT   8           /*!< The number of bits in the char type */
#define SCHAR_MIN  -128        /*!< The minimum value of the signed char type */
#define SCHAR_MAX  127         /*!< The maximum value of the signed char type */
#define UCHAR_MAX  255         /*!< The maximum value of the unsigned char type */
#define CHAR_MIN   -128        /*!< The minimum value of the char type */
#define CHAR_MAX   127         /*!< The maximum value of the char type */
#define SHRT_MIN   -32768      /*!< The minimum value of the short type */
#define SHRT_MAX   32767       /*!< The maximum value of the short type */
#define USHRT_MAX  65535       /*!< The maximum value of the unsigned short type */
#define INT_MIN    -32768      /*!< The minimum value of the int type */
#define INT_MAX    32767       /*!< The maximum value of the int type */
#define UINT_MAX   65535       /*!< The maximum value of the unsigned int type */
#define LONG_MIN   -2147483648 /*!< The minimum value of the long type */
#define LONG_MAX   2147483647  /*!< The maximum value of the long type */
#define ULONG_MAX  4294967295  /*!< The maximum value of the unsigned long type */
#define RAND_MAX   32768       /*!< The maximum unsigned int random number returned by rand */
/** @} */  // end of NXTLimits group
/** @} */  // end of MiscConstants group


/** @addtogroup GraphicsLibrary
 * @{
 */
/*------------------------------------------------------------------------------
; File          : nbcGL.nbc
; Description   : Data and subroutines for a very simple 3D engine.
; Programmed by : Arno van der Vegt, avandervegt@home.nl
;-----------------------------------------------------------------------------*/

/** @defgroup GLConstantsBeginModes Graphics library begin modes
 * Constants that are used to specify the polygon surface begin mode.
 * @{
 */
#define GL_POLYGON             1 /*!< Use polygon mode. */
#define GL_LINE                2 /*!< Use line mode. */
#define GL_POINT               3 /*!< Use point mode. */
#define GL_CIRCLE              4 /*!< Use circle mode. */
/** @} */  // end of GLConstantsBeginModes group

/** @defgroup GLConstantsActions Graphics library actions
 * Constants that are used to specify a graphics library action.
 * @{
 */
#define GL_TRANSLATE_X       1 /*!< Translate along the X axis. */
#define GL_TRANSLATE_Y       2 /*!< Translate along the Y axis. */
#define GL_TRANSLATE_Z       3 /*!< Translate along the Z axis. */
#define GL_ROTATE_X          4 /*!< Rotate around the X axis. */
#define GL_ROTATE_Y          5 /*!< Rotate around the Y axis. */
#define GL_ROTATE_Z          6 /*!< Rotate around the Z axis. */
#define GL_SCALE_X           7 /*!< Scale along the X axis. */
#define GL_SCALE_Y           8 /*!< Scale along the Y axis. */
#define GL_SCALE_Z           9 /*!< Scale along the Z axis. */
/** @} */  // end of GLConstantsSettings group

/** @defgroup GLConstantsSettings Graphics library settings
 * Constants that are used to configure the graphics library settings.
 * @{
 */
#define GL_CIRCLE_SIZE          1 /*!< Set the circle size. */
#define GL_CULL_MODE            2 /*!< Set the cull mode.  */
#define GL_CAMERA_DEPTH         3 /*!< Set the camera depth. */
#define GL_ZOOM_FACTOR          4 /*!< Set the zoom factor. */
/** @} */  // end of GLConstantsSettings group

/** @defgroup GLConstantsCullMode Graphics library cull mode
 * Constants to use when setting the graphics library cull mode.
 * @{
 */
#define GL_CULL_BACK           2 /*!< Cull lines in back. */
#define GL_CULL_FRONT          3 /*!< Cull lines in front. */
#define GL_CULL_NONE           4 /*!< Do not cull any lines. */
/** @} */  // end of GLConstantsCullMode group

/** @} */  // end of GraphicsLibrary group

#endif // NBCCOMMON_H
