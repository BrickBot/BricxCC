/** \file nbc_command.h
 * \brief The NBC command module API
 *
 * nbc_command.h contains the NBC command module API
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

#ifndef NBC_COMMAND_H
#define NBC_COMMAND_H

#include "command_constants.h"

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// COMMAND MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup CommandModule
 * @{
 */
/** @defgroup CommandModuleFunctions Command module functions
 * Functions for accessing and modifying Command module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

dseg segment
// GetStartTick
TGetStartTick	struct
 Result		dword
TGetStartTick	ends

// KeepAlive
TKeepAlive	struct
 Result		dword
TKeepAlive	ends

  __GSTArgs TGetStartTick
  __KeepAliveArgs TKeepAlive
  __GSTMutex mutex
  __KeepAliveMutex mutex
ends

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

dseg segment
// MemoryManager
TMemoryManager struct
 Result        sbyte
 Compact       byte
 PoolSize      word
 DataspaceSize word
TMemoryManager ends

  __MemMgrArgs TMemoryManager
  __MemMgrMutex mutex
dseg ends

#endif


#define __GetFirstTick(_value) \
  compchk EQ, sizeof(_value), 4 \
  acquire __GSTMutex \
  syscall GetStartTick, __GSTArgs \
  mov _value, __GSTArgs.Result \
  release __GSTMutex

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

#define __GetMemoryInfo(_Compact,_PoolSize,_DataspaceSize,_Result) \
  acquire __MemMgrMutex \
  mov __MemMgrArgs.Compact,_Compact \
  syscall MemoryManager,__MemMgrArgs \
  mov _PoolSize, __MemMgrArgs.PoolSize \
  mov _DataspaceSize, __MemMgrArgs.DataspaceSize \
  mov _Result, __MemMgrArgs.Result \
  release __MemMgrMutex

#endif

#ifdef __ENHANCED_FIRMWARE

#define __spawnProgram(_fname) \
  acquire __IOMWMutex \
  mov __IOMWBIArgs.ModuleID, CommandModuleID \
  mov __IOMWBIArgs.Offset, CommandOffsetActivateFlag \
  arrsubset __IOMWFlattenBuf, _fname, NA, 20 \
  arrbuild __IOMWBIArgs.Buffer, 1, 0, __IOMWFlattenBuf \
  syscall IOMapWriteByID, __IOMWBIArgs \
  release __IOMWMutex \
  stop NA

#else

#define __spawnProgram(_fname) \
  acquire __IOMWMutex \
  mov __IOMWArgs.ModuleName, CommandModuleName \
  mov __IOMWArgs.Offset, CommandOffsetActivateFlag \
  arrsubset __IOMWFlattenBuf, _fname, NA, 20 \
  arrbuild __IOMWArgs.Buffer, 1, 0, __IOMWFlattenBuf \
  syscall IOMapWrite, __IOMWArgs \
  release __IOMWMutex \
  stop NA

#endif

// not ready to be documented
#define SpawnProgram(_fname) __spawnProgram(_fname)

dseg segment
// IOMapRead
TIOMapRead	struct
 Result		sbyte
 ModuleName	byte[]
 Offset		word
 Count		word
 Buffer		byte[]
TIOMapRead	ends

// IOMapWrite
TIOMapWrite	struct
 Result		sbyte
 ModuleName	byte[]
 Offset		word
 Buffer		byte[]
TIOMapWrite	ends

  __IOMWArgs TIOMapWrite
  __IOMRArgs TIOMapRead
  __IOMWMutex mutex
  __IOMRMutex mutex
  __IOMWFlattenBuf byte[]
  __IOMRUnflattenErr byte
  __IOMRUnflattenBuf byte[]
dseg ends

#ifdef __ENHANCED_FIRMWARE
dseg segment
TIOMapReadByID struct
  Result    sbyte
  ModuleID  long
  Offset    word
  Count     word
  Buffer    byte[]
TIOMapReadByID ends

TIOMapWriteByID struct
  Result   sbyte
  ModuleID long
  Offset   word
  Buffer   byte[]
TIOMapWriteByID ends

  __IOMRBIArgs TIOMapReadByID
  __IOMWBIArgs TIOMapWriteByID
dseg ends
#endif

#define __getIOMapBytes(_modName, _offset, _cnt, _arrOut) \
  acquire __IOMRMutex \
  mov __IOMRArgs.ModuleName, _modName \
  mov __IOMRArgs.Offset, _offset \
  mov __IOMRArgs.Count, _cnt \
  syscall IOMapRead, __IOMRArgs \
  mov _arrOut, __IOMRArgs.Buffer \
  release __IOMRMutex

#define __getIOMapValue(_modName, _offset, _n) \
  acquire __IOMRMutex \
  mov __IOMRArgs.ModuleName, _modName \
  mov __IOMRArgs.Offset, _offset \
  set __IOMRArgs.Count, sizeof(_n) \
  syscall IOMapRead, __IOMRArgs \
  arrtostr __IOMRUnflattenBuf, __IOMRArgs.Buffer \
  unflatten _n, __IOMRUnflattenErr, __IOMRUnflattenBuf, _n \
  release __IOMRMutex

#ifdef __ENHANCED_FIRMWARE

#define __getIOMapBytesByID(_modID, _offset, _cnt, _arrOut) \
  acquire __IOMRMutex \
  mov __IOMRBIArgs.ModuleID, _modID \
  mov __IOMRBIArgs.Offset, _offset \
  mov __IOMRBIArgs.Count, _cnt \
  syscall IOMapReadByID, __IOMRBIArgs \
  mov _arrOut, __IOMRBIArgs.Buffer \
  release __IOMRMutex

#define __getIOMapValueByID(_modID, _offset, _n) \
  acquire __IOMRMutex \
  mov __IOMRBIArgs.ModuleID, _modID \
  mov __IOMRBIArgs.Offset, _offset \
  set __IOMRBIArgs.Count, sizeof(_n) \
  syscall IOMapReadByID, __IOMRBIArgs \
  arrtostr __IOMRUnflattenBuf, __IOMRBIArgs.Buffer \
  unflatten _n, __IOMRUnflattenErr, __IOMRUnflattenBuf, _n \
  release __IOMRMutex

#define __getLowSpeedModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytesByID(LowSpeedModuleID, _offset, _cnt, _arrOut)
#define __getDisplayModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytesByID(DisplayModuleID, _offset, _cnt, _arrOut)
#define __getCommModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytesByID(CommModuleID, _offset, _cnt, _arrOut)
#define __getCommandModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytesByID(CommandModuleID, _offset, _cnt, _arrOut)

#define __getCommandModuleValue(_offset, _n) __getIOMapValueByID(CommandModuleID, _offset, _n)
#define __getIOCtrlModuleValue(_offset, _n) __getIOMapValueByID(IOCtrlModuleID, _offset, _n)
#define __getLoaderModuleValue(_offset, _n) __getIOMapValueByID(LoaderModuleID, _offset, _n)
#define __getUIModuleValue(_offset, _n) __getIOMapValueByID(UIModuleID, _offset, _n)
#define __getSoundModuleValue(_offset, _n) __getIOMapValueByID(SoundModuleID, _offset, _n)
#define __getButtonModuleValue(_offset, _n) __getIOMapValueByID(ButtonModuleID, _offset, _n)
#define __getInputModuleValue(_offset, _n) __getIOMapValueByID(InputModuleID, _offset, _n)
#define __getOutputModuleValue(_offset, _n) __getIOMapValueByID(OutputModuleID, _offset, _n)
#define __getLowSpeedModuleValue(_offset, _n) __getIOMapValueByID(LowSpeedModuleID, _offset, _n)
#define __getDisplayModuleValue(_offset, _n) __getIOMapValueByID(DisplayModuleID, _offset, _n)
#define __getCommModuleValue(_offset, _n) __getIOMapValueByID(CommModuleID, _offset, _n)

#else

#define __getLowSpeedModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytes(LowSpeedModuleName, _offset, _cnt, _arrOut)
#define __getDisplayModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytes(DisplayModuleName, _offset, _cnt, _arrOut)
#define __getCommModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytes(CommModuleName, _offset, _cnt, _arrOut)
#define __getCommandModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytes(CommandModuleName, _offset, _cnt, _arrOut)

#define __getCommandModuleValue(_offset, _n) __getIOMapValue(CommandModuleName, _offset, _n)
#define __getIOCtrlModuleValue(_offset, _n) __getIOMapValue(IOCtrlModuleName, _offset, _n)
#define __getLoaderModuleValue(_offset, _n) __getIOMapValue(LoaderModuleName, _offset, _n)
#define __getUIModuleValue(_offset, _n) __getIOMapValue(UIModuleName, _offset, _n)
#define __getSoundModuleValue(_offset, _n) __getIOMapValue(SoundModuleName, _offset, _n)
#define __getButtonModuleValue(_offset, _n) __getIOMapValue(ButtonModuleName, _offset, _n)
#define __getInputModuleValue(_offset, _n) __getIOMapValue(InputModuleName, _offset, _n)
#define __getOutputModuleValue(_offset, _n) __getIOMapValue(OutputModuleName, _offset, _n)
#define __getLowSpeedModuleValue(_offset, _n) __getIOMapValue(LowSpeedModuleName, _offset, _n)
#define __getDisplayModuleValue(_offset, _n) __getIOMapValue(DisplayModuleName, _offset, _n)
#define __getCommModuleValue(_offset, _n) __getIOMapValue(CommModuleName, _offset, _n)

#endif

#define __SetIOMapBytes(_modName, _offset, _cnt, _arrIn) \
  acquire __IOMWMutex \
  mov __IOMWArgs.ModuleName, _modName \
  mov __IOMWArgs.Offset, _offset \
  arrsubset __IOMWArgs.Buffer, _arrIn, NA, _cnt \
  syscall IOMapWrite, __IOMWArgs \
  release __IOMWMutex

#define __SetIOMapValue(_modName, _offset, _n) \
  acquire __IOMWMutex \
  mov __IOMWArgs.ModuleName, _modName \
  mov __IOMWArgs.Offset, _offset \
  flatten __IOMWFlattenBuf, _n \
  strtoarr __IOMWArgs.Buffer, __IOMWFlattenBuf \
  syscall IOMapWrite, __IOMWArgs \
  release __IOMWMutex

#ifdef __ENHANCED_FIRMWARE

#define __SetIOMapBytesByID(_modID, _offset, _cnt, _arrIn) \
  acquire __IOMWMutex \
  mov __IOMWBIArgs.ModuleID, _modID \
  mov __IOMWBIArgs.Offset, _offset \
  arrsubset __IOMWBIArgs.Buffer, _arrIn, NA, _cnt \
  syscall IOMapWriteByID, __IOMWBIArgs \
  release __IOMWMutex

#define __SetIOMapValueByID(_modID, _offset, _n) \
  acquire __IOMWMutex \
  mov __IOMWBIArgs.ModuleID, _modID \
  mov __IOMWBIArgs.Offset, _offset \
  flatten __IOMWFlattenBuf, _n \
  strtoarr __IOMWBIArgs.Buffer, __IOMWFlattenBuf \
  syscall IOMapWriteByID, __IOMWBIArgs \
  release __IOMWMutex

#endif

#ifdef __ENHANCED_FIRMWARE

#define __SetCommandModuleValue(_offset, _n) __SetIOMapValueByID(CommandModuleID, _offset, _n)
#define __SetIOCtrlModuleValue(_offset, _n) __SetIOMapValueByID(IOCtrlModuleID, _offset, _n)
#define __SetLoaderModuleValue(_offset, _n) __SetIOMapValueByID(LoaderModuleID, _offset, _n)
#define __SetUIModuleValue(_offset, _n) __SetIOMapValueByID(UIModuleID, _offset, _n)
#define __SetSoundModuleValue(_offset, _n) __SetIOMapValueByID(SoundModuleID, _offset, _n)
#define __SetButtonModuleValue(_offset, _n) __SetIOMapValueByID(ButtonModuleID, _offset, _n)
#define __SetInputModuleValue(_offset, _n) __SetIOMapValueByID(InputModuleID, _offset, _n)
#define __SetOutputModuleValue(_offset, _n) __SetIOMapValueByID(OutputModuleID, _offset, _n)
#define __SetLowSpeedModuleValue(_offset, _n) __SetIOMapValueByID(LowSpeedModuleID, _offset, _n)
#define __SetDisplayModuleValue(_offset, _n) __SetIOMapValueByID(DisplayModuleID, _offset, _n)
#define __SetCommModuleValue(_offset, _n) __SetIOMapValueByID(CommModuleID, _offset, _n)

#define __SetCommandModuleBytes(_offset, _cnt, _arrIn) __SetIOMapBytesByID(CommandModuleID, _offset, _cnt, _arrIn)
#define __SetLowSpeedModuleBytes(_offset, _cnt, _arrIn) __SetIOMapBytesByID(LowSpeedModuleID, _offset, _cnt, _arrIn)
#define __SetDisplayModuleBytes(_offset, _cnt, _arrIn) __SetIOMapBytesByID(DisplayModuleID, _offset, _cnt, _arrIn)
#define __SetCommModuleBytes(_offset, _cnt, _arrIn) __SetIOMapBytesByID(CommModuleID, _offset, _cnt, _arrIn)
#define __SetSoundModuleBytes(_offset, _cnt, _arrIn) __SetIOMapBytesByID(SoundModuleID, _offset, _cnt, _arrIn)

#else

#define __SetCommandModuleValue(_offset, _n) __SetIOMapValue(CommandModuleName, _offset, _n)
#define __SetIOCtrlModuleValue(_offset, _n) __SetIOMapValue(IOCtrlModuleName, _offset, _n)
#define __SetLoaderModuleValue(_offset, _n) __SetIOMapValue(LoaderModuleName, _offset, _n)
#define __SetUIModuleValue(_offset, _n) __SetIOMapValue(UIModuleName, _offset, _n)
#define __SetSoundModuleValue(_offset, _n) __SetIOMapValue(SoundModuleName, _offset, _n)
#define __SetButtonModuleValue(_offset, _n) __SetIOMapValue(ButtonModuleName, _offset, _n)
#define __SetInputModuleValue(_offset, _n) __SetIOMapValue(InputModuleName, _offset, _n)
#define __SetOutputModuleValue(_offset, _n) __SetIOMapValue(OutputModuleName, _offset, _n)
#define __SetLowSpeedModuleValue(_offset, _n) __SetIOMapValue(LowSpeedModuleName, _offset, _n)
#define __SetDisplayModuleValue(_offset, _n) __SetIOMapValue(DisplayModuleName, _offset, _n)
#define __SetCommModuleValue(_offset, _n) __SetIOMapValue(CommModuleName, _offset, _n)

#define __SetCommandModuleBytes(_offset, _cnt, _arrIn) __SetIOMapBytes(CommandModuleName, _offset, _cnt, _arrIn)
#define __SetLowSpeedModuleBytes(_offset, _cnt, _arrIn) __SetIOMapBytes(LowSpeedModuleName, _offset, _cnt, _arrIn)
#define __SetDisplayModuleBytes(_offset, _cnt, _arrIn) __SetIOMapBytes(DisplayModuleName, _offset, _cnt, _arrIn)
#define __SetCommModuleBytes(_offset, _cnt, _arrIn) __SetIOMapBytes(CommModuleName, _offset, _cnt, _arrIn)
#define __SetSoundModuleBytes(_offset, _cnt, _arrIn) __SetIOMapBytes(SoundModuleName, _offset, _cnt, _arrIn)

#endif

#endif

/**
 * Set IOMap bytes by name.
 * Modify one or more bytes of data in an IOMap structure. The IOMap
 * structure is specified by its module name. You also provide the offset into
 * the IOMap structure where you want to start writing, the number of bytes to
 * write at that location, and a byte array containing the new data.
 * \param _modName The module name of the IOMap to modify. See \ref ModuleNameConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the data should be written
 * \param _cnt The number of bytes to write at the specified IOMap
 * offset.
 * \param _arrIn The byte array containing the data to write to the IOMap
 */
#define SetIOMapBytes(_modName, _offset, _cnt, _arrIn) __SetIOMapBytes(_modName, _offset, _cnt, _arrIn)

/**
 * Set IOMap value by name.
 * Set one of the fields of an IOMap structure to a new value.  The IOMap
 * structure is specified by its module name. You also provide the offset into
 * the IOMap structure where you want to write the value along with a variable
 * containing the new value.
 * \param _modName The module name of the IOMap to modify. See \ref ModuleNameConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the new value should be written
 * \param _n A variable containing the new value to write to the IOMap
 */
#define SetIOMapValue(_modName, _offset, _n) __SetIOMapValue(_modName, _offset, _n)

#ifdef __ENHANCED_FIRMWARE

/**
 * Set IOMap bytes by ID.
 * Modify one or more bytes of data in an IOMap structure. The IOMap
 * structure is specified by its Module ID. You also provide the offset into
 * the IOMap structure where you want to start writing, the number of bytes to
 * write at that location, and a byte array containing the new data.
 * \param _modID The module ID of the IOMap to modify. See \ref ModuleIDConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the data should be written.
 * \param _cnt The number of bytes to write at the specified IOMap
 * offset.
 * \param _arrIn The byte array containing the data to write to the IOMap.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define SetIOMapBytesByID(_modID, _offset, _cnt, _arrIn) __SetIOMapBytesByID(_modID, _offset, _cnt, _arrIn)

/**
 * Set IOMap value by ID.
 * Set one of the fields of an IOMap structure to a new value.  The IOMap
 * structure is specified by its Module ID. You also provide the offset into
 * the IOMap structure where you want to write the value along with a variable
 * containing the new value.
 * \param _modID The module ID of the IOMap to modify. See \ref ModuleIDConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the new value should be written.
 * \param _n A variable containing the new value to write to the IOMap.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define SetIOMapValueByID(_modID, _offset, _n) __SetIOMapValueByID(_modID, _offset, _n)

#endif

/**
 * Set Command module IOMap value.
 * Set one of the fields of the Command module IOMap structure to a new value.
 * You provide the offset into the Command module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Command
 * module IOMap structure where the new value should be written. See \ref CommandIOMAP.
 * \param _n A variable containing the new value to write to the Command
 * module IOMap.
 */
#define SetCommandModuleValue(_offset, _n) __SetCommandModuleValue(_offset, _n)

/**
 * Set IOCtrl module IOMap value.
 * Set one of the fields of the IOCtrl module IOMap structure to a new value.
 * You provide the offset into the IOCtrl module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the IOCtrl
 * module IOMap structure where the new value should be written. See \ref IOCtrlIOMAP.
 * \param _n A variable containing the new value to write to the IOCtrl
 * module IOMap.
 */
#define SetIOCtrlModuleValue(_offset, _n) __SetIOCtrlModuleValue(_offset, _n)

/**
 * Set Loader module IOMap value.
 * Set one of the fields of the Loader module IOMap structure to a new value.
 * You provide the offset into the Loader module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Loader
 * module IOMap structure where the new value should be written. See \ref LoaderIOMAP.
 * \param _n A variable containing the new value to write to the Loader
 * module IOMap.
 */
#define SetLoaderModuleValue(_offset, _n) __SetLoaderModuleValue(_offset, _n)

/**
 * Set Ui module IOMap value.
 * Set one of the fields of the Ui module IOMap structure to a new value.
 * You provide the offset into the Ui module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Ui
 * module IOMap structure where the new value should be written. See \ref UiIOMAP.
 * \param _n A variable containing the new value to write to the Ui
 * module IOMap.
 */
#define SetUIModuleValue(_offset, _n) __SetUIModuleValue(_offset, _n)

/**
 * Set Sound module IOMap value.
 * Set one of the fields of the Sound module IOMap structure to a new value.
 * You provide the offset into the Sound module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Sound
 * module IOMap structure where the new value should be written. See \ref SoundIOMAP.
 * \param _n A variable containing the new value to write to the Sound
 * module IOMap.
 */
#define SetSoundModuleValue(_offset, _n) __SetSoundModuleValue(_offset, _n)

/**
 * Set Button module IOMap value.
 * Set one of the fields of the Button module IOMap structure to a new value.
 * You provide the offset into the Button module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Button
 * module IOMap structure where the new value should be written. See \ref ButtonIOMAP.
 * \param _n A variable containing the new value to write to the Button
 * module IOMap.
 */
#define SetButtonModuleValue(_offset, _n) __SetButtonModuleValue(_offset, _n)

/**
 * Set Input module IOMap value.
 * Set one of the fields of the Input module IOMap structure to a new value.
 * You provide the offset into the Input module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Input
 * module IOMap structure where the new value should be written. See \ref InputIOMAP.
 * \param _n A variable containing the new value to write to the Input
 * module IOMap.
 */
#define SetInputModuleValue(_offset, _n) __SetInputModuleValue(_offset, _n)

/**
 * Set Output module IOMap value.
 * Set one of the fields of the Output module IOMap structure to a new value.
 * You provide the offset into the Output module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Output
 * module IOMap structure where the new value should be written. See \ref OutputIOMAP.
 * \param _n A variable containing the new value to write to the Output
 * module IOMap.
 */
#define SetOutputModuleValue(_offset, _n) __SetOutputModuleValue(_offset, _n)

/**
 * Set Lowspeed module IOMap value.
 * Set one of the fields of the Lowspeed module IOMap structure to a new value.
 * You provide the offset into the Lowspeed module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Lowspeed
 * module IOMap structure where the new value should be written. See \ref LowSpeedIOMAP.
 * \param _n A variable containing the new value to write to the Lowspeed
 * module IOMap.
 */
#define SetLowSpeedModuleValue(_offset, _n) __SetLowSpeedModuleValue(_offset, _n)

/**
 * Set Display module IOMap value.
 * Set one of the fields of the Display module IOMap structure to a new value.
 * You provide the offset into the Display module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Display
 * module IOMap structure where the new value should be written. See \ref DisplayIOMAP.
 * \param _n A variable containing the new value to write to the Display
 * module IOMap.
 */
#define SetDisplayModuleValue(_offset, _n) __SetDisplayModuleValue(_offset, _n)

/**
 * Set Comm module IOMap value.
 * Set one of the fields of the Comm module IOMap structure to a new value.
 * You provide the offset into the Comm module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Comm
 * module IOMap structure where the new value should be written. See \ref CommIOMAP.
 * \param _n A variable containing the new value to write to the Comm
 * module IOMap.
 */
#define SetCommModuleValue(_offset, _n) __SetCommModuleValue(_offset, _n)

/**
 * Set Command module IOMap bytes.
 * Modify one or more bytes of data in the Command module IOMap structure. You
 * provide the offset into the Command module IOMap structure where you want
 * to start writing, the number of bytes to write at that location, and a byte
 * array containing the new data.
 * \param _offset The number of bytes offset from the start of the Command module
 * IOMap structure where the data should be written. See \ref CommandIOMAP.
 * \param _cnt The number of bytes to write at the specified Command module
 * IOMap offset.
 * \param _arrIn The byte array containing the data to write to the Command
 * module IOMap.
 */
#define SetCommandModuleBytes(_offset, _cnt, _arrIn) __SetCommandModuleBytes(_offset, _cnt, _arrIn)

/**
 * Set Lowspeed module IOMap bytes.
 * Modify one or more bytes of data in the Lowspeed module IOMap structure. You
 * provide the offset into the Lowspeed module IOMap structure where you want
 * to start writing, the number of bytes to write at that location, and a byte
 * array containing the new data.
 * \param _offset The number of bytes offset from the start of the Lowspeed
 * module IOMap structure where the data should be written. See \ref LowSpeedIOMAP.
 * \param _cnt The number of bytes to write at the specified Lowspeed module
 * IOMap offset.
 * \param _arrIn The byte array containing the data to write to the Lowspeed
 * module IOMap.
 */
#define SetLowSpeedModuleBytes(_offset, _cnt, _arrIn) __SetLowSpeedModuleBytes(_offset, _cnt, _arrIn)

/**
 * Set Display module IOMap bytes.
 * Modify one or more bytes of data in the Display module IOMap structure. You
 * provide the offset into the Display module IOMap structure where you want to
 * start writing, the number of bytes to write at that location, and a byte
 * array containing the new data.
 * \param _offset The number of bytes offset from the start of the Display module
 * IOMap structure where the data should be written. See \ref DisplayIOMAP.
 * \param _cnt The number of bytes to write at the specified Display module
 * IOMap offset.
 * \param _arrIn The byte array containing the data to write to the Display
 * module IOMap.
 */
#define SetDisplayModuleBytes(_offset, _cnt, _arrIn) __SetDisplayModuleBytes(_offset, _cnt, _arrIn)

/**
 * Set Comm module IOMap bytes.
 * Modify one or more bytes of data in an IOMap structure. You provide the
 * offset into the Comm module IOMap structure where you want to start writing,
 * the number of bytes to write at that location, and a byte array containing
 * the new data.
 * \param _offset The number of bytes offset from the start of the Comm module
 * IOMap structure where the data should be written. See \ref CommIOMAP.
 * \param _cnt The number of bytes to write at the specified Comm module IOMap
 * offset.
 * \param _arrIn The byte array containing the data to write to the Comm module
 * IOMap.
 */
#define SetCommModuleBytes(_offset, _cnt, _arrIn) __SetCommModuleBytes(_offset, _cnt, _arrIn)

/**
 * Set Sound module IOMap bytes.
 * Set one one or more bytes of data in an IOMap structure. You provide the
 * offset into the Sound module IOMap structure where you want to start writing,
 * the number of bytes to write at that location, and a byte array containing
 * the new data.
 * \param _offset The number of bytes offset from the start of the Sound module
 * IOMap structure where the data should be written. See \ref SoundIOMAP.
 * \param _cnt The number of bytes to write at the specified Sound module IOMap
 * offset.
 * \param _arrIn The byte array containing the data to write to the Sound module
 * IOMap.
 */
#define SetSoundModuleBytes(_offset, _cnt, _arrIn) __SetSoundModuleBytes(_offset, _cnt, _arrIn)

/**
 * Get IOMap bytes by name.
 * Read one or more bytes of data from an IOMap structure. The IOMap
 * structure is specified by its module name. You also provide the offset into
 * the IOMap structure where you want to start reading, the number of bytes to
 * read from that location, and a byte array where the data will be stored.
 * \param _modName The module name of the IOMap. See \ref ModuleNameConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the data should be read
 * \param _cnt The number of bytes to read from the specified IOMap
 * offset.
 * \param _arrOut A byte array that will contain the data read from the IOMap
 */
#define GetIOMapBytes(_modName, _offset, _cnt, _arrOut) __getIOMapBytes(_modName, _offset, _cnt, _arrOut)

/**
 * Get IOMap value by name.
 * Read a value from an IOMap structure.  The IOMap
 * structure is specified by its module name. You also provide the offset into
 * the IOMap structure where you want to read the value along with a variable
 * that will contain the IOMap value.
 * \param _modName The module name of the IOMap. See \ref ModuleNameConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read
 * \param _n A variable that will contain the value read from the IOMap
 */
#define GetIOMapValue(_modName, _offset, _n) __getIOMapValue(_modName, _offset, _n)

#ifdef __ENHANCED_FIRMWARE

/**
 * Get IOMap bytes by ID.
 * Read one or more bytes of data from an IOMap structure. The IOMap
 * structure is specified by its Module ID. You also provide the offset into
 * the IOMap structure where you want to start reading, the number of bytes to
 * read from that location, and a byte array where the data will be stored.
 * \param _modID The module ID of the IOMap. See \ref ModuleIDConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the data should be read.
 * \param _cnt The number of bytes to read from the specified IOMap
 * offset.
 * \param _arrOut A byte array that will contain the data read from the IOMap.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define GetIOMapBytesByID(_modID, _offset, _cnt, _arrOut) __getIOMapBytesByID(_modID, _offset, _cnt, _arrOut)

/**
 * Get IOMap value by ID.
 * Read a value from an IOMap structure.  The IOMap
 * structure is specified by its Module ID. You also provide the offset into
 * the IOMap structure where you want to read the value along with a variable
 * that will contain the IOMap value.
 * \param _modID The module ID of the IOMap. See \ref ModuleIDConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read.
 * \param _n A variable that will contain the value read from the IOMap.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define GetIOMapValueByID(_modID, _offset, _n) __getIOMapValueByID(_modID, _offset, _n)

#endif

/**
 * Get Command module IOMap value.
 * Read a value from the Command module IOMap structure.  You provide the
 * offset into the Command module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref CommandIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetCommandModuleValue(_offset, _n) __getCommandModuleValue(_offset, _n)

/**
 * Get Loader module IOMap value.
 * Read a value from the Loader module IOMap structure.  You provide the
 * offset into the Loader module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref LoaderIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetLoaderModuleValue(_offset, _n) __getLoaderModuleValue(_offset, _n)

/**
 * Get Sound module IOMap value.
 * Read a value from the Sound module IOMap structure.  You provide the
 * offset into the Sound module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref SoundIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetSoundModuleValue(_offset, _n) __getSoundModuleValue(_offset, _n)

/**
 * Get Button module IOMap value.
 * Read a value from the Button module IOMap structure.  You provide the
 * offset into the Button module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref ButtonIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetButtonModuleValue(_offset, _n) __getButtonModuleValue(_offset, _n)

/**
 * Get Ui module IOMap value.
 * Read a value from the Ui module IOMap structure.  You provide the
 * offset into the Ui module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref UiIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetUIModuleValue(_offset, _n) __getUIModuleValue(_offset, _n)

/**
 * Get Input module IOMap value.
 * Read a value from the Input module IOMap structure.  You provide the
 * offset into the Input module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref InputIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetInputModuleValue(_offset, _n) __getInputModuleValue(_offset, _n)

/**
 * Get Output module IOMap value.
 * Read a value from the Output module IOMap structure.  You provide the
 * offset into the Output module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref OutputIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetOutputModuleValue(_offset, _n) __getOutputModuleValue(_offset, _n)

/**
 * Get LowSpeed module IOMap value.
 * Read a value from the LowSpeed module IOMap structure.  You provide the
 * offset into the Command module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref LowSpeedIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetLowSpeedModuleValue(_offset, _n) __getLowSpeedModuleValue(_offset, _n)

/**
 * Get Display module IOMap value.
 * Read a value from the Display module IOMap structure.  You provide the
 * offset into the Display module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref DisplayIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetDisplayModuleValue(_offset, _n) __getDisplayModuleValue(_offset, _n)

/**
 * Get Comm module IOMap value.
 * Read a value from the Comm module IOMap structure.  You provide the
 * offset into the Comm module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref CommIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetCommModuleValue(_offset, _n) __getCommModuleValue(_offset, _n)

/**
 * Get Lowspeed module IOMap bytes.
 * Read one or more bytes of data from Lowspeed module IOMap structure.
 * You provide the offset into the Lowspeed module IOMap structure where you
 * want to start reading, the number of bytes to read from that location, and
 * a byte array where the data will be stored.
 * \param _offset The number of bytes offset from the start of the Lowspeed
 * module IOMap structure where the data should be read. See \ref LowSpeedIOMAP.
 * \param _cnt The number of bytes to read from the specified Lowspeed module
 * IOMap offset.
 * \param _arrOut A byte array that will contain the data read from the Lowspeed
 * module IOMap.
 */
#define GetLowSpeedModuleBytes(_offset, _cnt, _arrOut) __getLowSpeedModuleBytes(_offset, _cnt, _arrOut)

/**
 * Get Display module IOMap bytes.
 * Read one or more bytes of data from Display module IOMap structure.
 * You provide the offset into the Display module IOMap structure where you
 * want to start reading, the number of bytes to read from that location, and
 * a byte array where the data will be stored.
 * \param _offset The number of bytes offset from the start of the Display
 * module IOMap structure where the data should be read. See \ref DisplayIOMAP.
 * \param _cnt The number of bytes to read from the specified Display module
 * IOMap offset.
 * \param _arrOut A byte array that will contain the data read from the Display
 * module IOMap.
 */
#define GetDisplayModuleBytes(_offset, _cnt, _arrOut) __getDisplayModuleBytes(_offset, _cnt, _arrOut)

/**
 * Get Comm module IOMap bytes.
 * Read one or more bytes of data from Comm module IOMap structure.
 * You provide the offset into the Comm module IOMap structure where you
 * want to start reading, the number of bytes to read from that location, and
 * a byte array where the data will be stored.
 * \param _offset The number of bytes offset from the start of the Comm module
 * IOMap structure where the data should be read. See \ref CommIOMAP.
 * \param _cnt The number of bytes to read from the specified Comm module
 * IOMap offset.
 * \param _arrOut A byte array that will contain the data read from the Comm
 * module IOMap.
 */
#define GetCommModuleBytes(_offset, _cnt, _arrOut) __getCommModuleBytes(_offset, _cnt, _arrOut)

/**
 * Get Command module IOMap bytes.
 * Read one or more bytes of data from Command module IOMap structure.
 * You provide the offset into the Command module IOMap structure where you
 * want to start reading, the number of bytes to read from that location, and
 * a byte array where the data will be stored.
 * \param _offset The number of bytes offset from the start of the Command module
 * IOMap structure where the data should be read. See \ref CommandIOMAP.
 * \param _cnt The number of bytes to read from the specified Command module
 * IOMap offset.
 * \param _arrOut A byte array that will contain the data read from the Command
 * module IOMap.
 */
#define GetCommandModuleBytes(_offset, _cnt, _arrOut) __getCommandModuleBytes(_offset, _cnt, _arrOut)

/**
 * Reset the sleep timer.
 * This function lets you reset the sleep timer.
 *
 */
#define ResetSleepTimer syscall KeepAlive, __KeepAliveArgs

/**
 * Get the first tick.
 * Return an unsigned 32-bit value, which is the system timing value
 * (called a "tick") in milliseconds at the time that the program began
 * running.
 *
 * \param _value The tick count at the start of program execution.
 */
#define GetFirstTick(_value) __GetFirstTick(_value)

/**
 * Wait some milliseconds.
 * Make a task sleep for specified amount of time (in 1000ths of a second).
 *
 * \param _n The number of milliseconds to sleep.
 */
#define Wait(_n) waitv _n

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/**
 * Read memory information.
 * Read the current pool size and dataspace size.  Optionally compact the
 * dataspace before returning the information. Running programs have a maximum
 * of 32k bytes of memory available.  The amount of free RAM can be calculated
 * by subtracting the value returned by this function from \ref POOL_MAX_SIZE.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _Compact A boolean value indicating whether to compact the dataspace or not.
 * \param _PoolSize The current pool size.
 * \param _DataspaceSize The current dataspace size.
 * \param _Result The function call result. It will be \ref NO_ERR if the compact
 * operation is not performed.  Otherwise it will be the result of the compact
 * operation.
 */
#define GetMemoryInfo(_Compact,_PoolSize,_DataspaceSize,_Result) __GetMemoryInfo(_Compact,_PoolSize,_DataspaceSize,_Result)

#endif


/** @} */ // end of CommandModuleFunctions group
/** @} */ // end of CommandModule group
/** @} */ // end of NXTFirmwareModules group

#endif // NBC_COMMAND_H
