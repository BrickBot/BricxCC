/** \file command.h
 * \brief The NXC command module API
 *
 * command.h contains the NXC command module API
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

#ifndef COMMAND_H
#define COMMAND_H

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// COMMAND MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup CommandModule
 * @{
 */
/** @defgroup CommandModuleTypes Command module types
 * Types used by various Command module functions.
 * @{
 */

/**
 * Parameters for the GetStartTick system call.
 * This structure is used when calling the \ref SysGetStartTick system call
 * function.
 * \sa SysGetStartTick()
 */
struct GetStartTickType {
  unsigned long Result;   /*!< The returned tick value. */
};

/**
 * Parameters for the KeepAlive system call.
 * This structure is used when calling the \ref SysKeepAlive system call
 * function.
 * \sa SysKeepAlive()
 */
struct KeepAliveType {
  unsigned long Result;   /*!< The current sleep timeout in milliseconds. */
};

/**
 * Parameters for the IOMapRead system call.
 * This structure is used when calling the \ref SysIOMapRead system call
 * function.
 * \sa SysIOMapRead()
 */
struct IOMapReadType {
  char Result;           /*!< The function call result. \ref NO_ERR means it succeeded. */
  string ModuleName;     /*!< The name of the module to read from. See the \ref ModuleNameConstants group. */
  unsigned int Offset;   /*!< The offset in the module IOMap where to start reading. */
  unsigned int Count;    /*!< The number of bytes to read. */
  byte Buffer[];         /*!< The buffer used to store read bytes. */
};

/**
 * Parameters for the IOMapWrite system call.
 * This structure is used when calling the \ref SysIOMapWrite system call
 * function.
 * \sa SysIOMapWrite()
 */
struct IOMapWriteType {
  char Result;           /*!< The function call result. \ref NO_ERR means it succeeded. */
  string ModuleName;     /*!< The name of the module to write to. See the \ref ModuleNameConstants group. */
  unsigned int Offset;   /*!< The offset in the module IOMap where to start writing. */
  byte Buffer[];         /*!< The buffer containing bytes to write. */
};

#ifdef __ENHANCED_FIRMWARE
/**
 * Parameters for the IOMapReadByID system call.
 * This structure is used when calling the \ref SysIOMapReadByID system call
 * function.
 * \sa SysIOMapReadByID()
 */
struct IOMapReadByIDType {
  char Result;            /*!< The function call result. \ref NO_ERR means it succeeded. */
  unsigned long ModuleID; /*!< The identifier of the module to read from. See the \ref ModuleIDConstants group. */
  unsigned int Offset;    /*!< The offset in the module IOMap where to start reading. */
  unsigned int Count;     /*!< The number of bytes to read. */
  byte Buffer[];          /*!< The buffer used to store read bytes. */
};

/**
 * Parameters for the IOMapWriteByID system call.
 * This structure is used when calling the \ref SysIOMapWriteByID system call
 * function.
 * \sa SysIOMapWriteByID()
 */
struct IOMapWriteByIDType {
  char Result;            /*!< The function call result. \ref NO_ERR means it succeeded. */
  unsigned long ModuleID; /*!< The identifier of the module to write to. See the \ref ModuleIDConstants group. */
  unsigned int Offset;    /*!< The offset in the module IOMap where to start writing. */
  byte Buffer[];          /*!< The buffer containing bytes to write. */
};

#endif

#if __FIRMWARE_VERSION > 107

/**
 * Parameters for the DatalogWrite system call.
 * This structure is used when calling the \ref SysDatalogWrite system call
 * function.
 * \sa SysDatalogWrite()
 */
struct DatalogWriteType {
 char Result;     /*!< The function call result. \ref NO_ERR means it succeeded. */
 byte Message[];  /*!< A buffer containing data to write to the datalog. */
};

/**
 * Parameters for the DatalogGetTimes system call.
 * This structure is used when calling the \ref SysDatalogGetTimes system call
 * function.
 * \sa SysDatalogGetTimes()
 */
struct DatalogGetTimesType {
 unsigned long SyncTime;  /*!< The datalog synchronized time. */
 unsigned long SyncTick;  /*!< The datalog synchronized tick. */
};

/**
 * Parameters for the ReadSemData system call.
 * This structure is used when calling the \ref SysReadSemData system call
 * function.
 * \sa SysReadSemData()
 */
struct ReadSemDataType {
  byte SemData;  /*!< The semaphore data returned by the function call. */
  bool Request;  /*!< Which semaphore am I reading from, usage or request? */
};

/**
 * Parameters for the WriteSemData system call.
 * This structure is used when calling the \ref SysWriteSemData system call
 * function.
 * \sa SysWriteSemData()
 */
struct WriteSemDataType {
  byte SemData;   /*!< The modified semaphore data returned by the function call. */
  bool Request;   /*!< Which semaphore am I writing to, usage or request? */
  byte NewVal;    /*!< The new semaphore data. */
  bool ClearBits; /*!< Should I clear existing bits? */
};

/**
 * Parameters for the UpdateCalibCacheInfo system call.
 * This structure is used when calling the \ref SysUpdateCalibCacheInfo system call
 * function.
 * \sa SysUpdateCalibCacheInfo()
 */
struct UpdateCalibCacheInfoType {
  byte Result;          /*!< The function call result. \todo ?. */
  string Name;          /*!< The name of the sensor calibration cache. \todo ?. */
  unsigned int MinVal;  /*!< The minimum calibrated value. */
  unsigned int MaxVal;  /*!< The maximum calibrated value. */
};

/**
 * Parameters for the ComputeCalibValue system call.
 * This structure is used when calling the \ref SysComputeCalibValue system call
 * function.
 * \sa SysComputeCalibValue()
 */
struct ComputeCalibValueType {
  byte Result;          /*!< The function call result. \todo ?. */
  string Name;          /*!< The name of the sensor calibration cache. \todo ?. */
  unsigned int RawVal;  /*!< The raw value. \todo ?. */
};

#ifdef __ENHANCED_FIRMWARE
/**
 * Parameters for the MemoryManager system call.
 * This structure is used when calling the \ref SysMemoryManager system call
 * function.
 * \sa SysMemoryManager()
 */
struct MemoryManagerType {
  char Result;                /*!< The returned status value. */
  bool Compact;               /*!< Should the dataspace be compacted or not. */
  unsigned int PoolSize;      /*!< The returned pool size. */
  unsigned int DataspaceSize; /*!< The returned dataspace size. */
};

/**
 * Parameters for the ReadLastResponse system call.
 * This structure is used when calling the \ref SysReadLastResponse system call
 * function.
 * \sa SysReadLastResponse()
 */
struct ReadLastResponseType {
  char Result;   /*!< The response packet status value. */
  bool Clear;    /*!< Clear the response after reading it or not. */
  byte Length;   /*!< The response packet length. */
  byte Command;  /*!< The response packet command byte. */
  byte Buffer[]; /*!< The response packet buffer. */
};
#endif

#endif
/** @} */ // end of CommandModuleTypes group

/** @defgroup CommandModuleFunctions Command module functions
 * Functions for accessing and modifying Command module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Read the current system tick.
 * This function lets you current system tick count.
 *
 * \return The current system tick count.
 */
inline unsigned long CurrentTick();

/**
 * Get the first tick.
 * Return an unsigned 32-bit value, which is the system timing value
 * (called a "tick") in milliseconds at the time that the program began
 * running.
 *
 * \return The tick count at the start of program execution.
 */
inline unsigned long FirstTick();

/**
 * Reset the sleep timer.
 * This function lets you reset the sleep timer.
 *
 * \return The result of resetting the sleep timer.
 */
inline long ResetSleepTimer();

//inline void SpawnProgram(string fname); // not ready to be documented

/**
 * Call any system function.
 * This generic macro can be used to call any system function. No type
 * checking is performed so you need to make sure you use the correct
 * structure type given the selected system function ID. This is, however, the
 * fastest possible way to call a system function in NXC.
 *
 * Valid function ID constants are defined in the \ref SysCallConstants group.
 *
 * \param funcID The function ID constant corresponding to the function to be
 * called.
 * \param args The structure containing the needed parameters.
 */
inline void SysCall(byte funcID, variant & args);

/**
 * Get start tick.
 * This function lets you obtain the tick value at the time your program began
 * executing via the \ref GetStartTickType structure.
 *
 * \param args The GetStartTickType structure receiving results.
 */
inline void SysGetStartTick(GetStartTickType & args);

/**
 * Keep alive.
 * This function lets you reset the sleep timer via the \ref KeepAliveType
 * structure.
 *
 * \param args The KeepAliveType structure receiving results.
 */
inline void SysKeepAlive(KeepAliveType & args);

/**
 * Read from IOMap by name.
 * This function lets you read data from a firmware module's IOMap using the
 * values specified via the \ref IOMapReadType structure.
 *
 * \param args The IOMapReadType structure containing the needed parameters.
 */
inline void SysIOMapRead(IOMapReadType & args);

/**
 * Write to IOMap by name.
 * This function lets you write data to a firmware module's IOMap using the
 * values specified via the \ref IOMapWriteType structure.
 *
 * \param args The IOMapWriteType structure containing the needed parameters.
 */
inline void SysIOMapWrite(IOMapWriteType & args);

#ifdef __ENHANCED_FIRMWARE
/**
 * Read from IOMap by identifier.
 * This function lets you read data from a firmware module's IOMap using the
 * values specified via the \ref IOMapReadByIDType structure. This function
 * can be as much as three times faster than using SysIOMapRead since it does
 * not have to do a string lookup using the ModuleName.
 *
 * \param args The IOMapReadByIDType structure containing the needed
 * parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SysIOMapReadByID(IOMapReadByIDType & args);

/**
 * Write to IOMap by identifier.
 * This function lets you write data to a firmware module's IOMap using the
 * values specified via the \ref IOMapWriteByIDType structure. This function
 * can be as much as three times faster than using SysIOMapWrite since it does
 * not have to do a string lookup using the ModuleName.
 *
 * \param args The IOMapWriteByIDType structure containing the needed
 * parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SysIOMapWriteByID(IOMapWriteByIDType & args);

#endif

#if __FIRMWARE_VERSION > 107

/**
 * Write to the datalog.
 * This function lets you write to the datalog using the
 * values specified via the \ref DatalogWriteType structure.
 *
 * \todo figure out what this function is intended for
 * \param args The DatalogWriteType structure containing the needed parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysDatalogWrite(DatalogWriteType & args);

/**
 * Get datalog times.
 * This function lets you get datalog times using the
 * values specified via the \ref DatalogGetTimesType structure.
 *
 * \todo figure out what this function is intended for
 * \param args The DatalogGetTimesType structure containing the needed parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysDatalogGetTimes(DatalogGetTimesType & args);

/**
 * Read semaphore data.
 * This function lets you read global motor semaphore data using the
 * values specified via the \ref ReadSemDataType structure.
 *
 * \param args The ReadSemDataType structure containing the needed parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysReadSemData(ReadSemDataType & args);

/**
 * Write semaphore data.
 * This function lets you write global motor semaphore data using the
 * values specified via the \ref WriteSemDataType structure.
 *
 * \param args The WriteSemDataType structure containing the needed parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysWriteSemData(WriteSemDataType & args);

/**
 * Update calibration cache information.
 * This function lets you update calibration cache information using the
 * values specified via the \ref UpdateCalibCacheInfoType structure.
 *
 * \todo figure out what this function is intended for
 * \param args The UpdateCalibCacheInfoType structure containing the needed parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysUpdateCalibCacheInfo(UpdateCalibCacheInfoType & args);

/**
 * Compute calibration values.
 * This function lets you compute calibration values using the
 * values specified via the \ref ComputeCalibValueType structure.
 *
 * \todo figure out what this function is intended for
 * \param args The ComputeCalibValueType structure containing the needed parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysComputeCalibValue(ComputeCalibValueType & args);

#endif

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
 * \param Compact A boolean value indicating whether to compact the dataspace or not.
 * \param PoolSize The current pool size.
 * \param DataspaceSize The current dataspace size.
 * \return The function call result. It will be \ref NO_ERR if the compact
 * operation is not performed.  Otherwise it will be the result of the compact
 * operation.
 */
inline char GetMemoryInfo(bool Compact, unsigned int & PoolSize, unsigned int & DataspaceSize);

/**
 * Read memory information.
 * This function lets you read memory information using the
 * values specified via the \ref MemoryManagerType structure.
 *
 * \param args The MemoryManagerType structure containing the required parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void SysMemoryManager(MemoryManagerType & args);

/**
 * Read last response information.
 * Read the last direct or system command response packet received by the NXT.
 * Optionally clear the response after retrieving the information.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+.
 *
 * \param Clear A boolean value indicating whether to clear the response or not.
 * \param Length The response packet length.
 * \param Command The original command byte.
 * \param Buffer The response packet buffer.
 * \return The response status code.
 */
inline char GetLastResponseInfo(bool Clear, byte & Length, byte & Command, byte & Buffer[]);

/**
 * Read last response information.
 * This function lets you read the last system or direct command response
 * received by the NXT using the values specified via the
 * \ref ReadLastResponseType structure.
 *
 * \param args The ReadLastResponseType structure containing the required parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+.
 */
inline void SysReadLastResponse(ReadLastResponseType & args);

#endif


#else

#define CurrentTick() asm { gettick __URETVAL__ }
#define FirstTick() asm { GetFirstTick(__URETVAL__) }
#define ResetSleepTimer() asm { acquire __KeepAliveMutex \
  syscall KeepAlive, __KeepAliveArgs \
  mov __RETVAL__, __KeepAliveArgs.Result \
  release __KeepAliveMutex }

#define SpawnProgram(_fname) asm { __spawnProgram(_fname) }

#define SysCall(_func, _args) asm { syscall _func, _args }

#define SysGetStartTick(_args) asm { \
  compchktype _args, GetStartTickType \
  syscall GetStartTick, _args \
}

#define SysKeepAlive(_args) asm { \
  compchktype _args, KeepAliveType \
  syscall KeepAlive, _args \
}

#define SysIOMapRead(_args) asm { \
  compchktype _args, IOMapReadType \
  syscall IOMapRead, _args \
}
#define SysIOMapWrite(_args) asm { \
  compchktype _args, IOMapWriteType \
  syscall IOMapWrite, _args \
}

#ifdef __ENHANCED_FIRMWARE
#define SysIOMapReadByID(_args) asm { \
  compchktype _args, IOMapReadByIDType \
  syscall IOMapReadByID, _args \
}
#define SysIOMapWriteByID(_args) asm { \
  compchktype _args, IOMapWriteByIDType \
  syscall IOMapWriteByID, _args \
}
#endif
#if __FIRMWARE_VERSION > 107

#define SysDatalogWrite(_args) asm { \
  compchktype _args, DatalogWriteType \
  syscall DatalogWrite, _args \
}
#define SysDatalogGetTimes(_args) asm { \
  compchktype _args, DatalogGetTimesType \
  syscall DatalogGetTimes, _args \
}
#define SysReadSemData(_args) asm { \
  compchktype _args, ReadSemDataType \
  syscall ReadSemData, _args \
}
#define SysWriteSemData(_args) asm { \
  compchktype _args, WriteSemDataType \
  syscall WriteSemData, _args \
}
#define SysUpdateCalibCacheInfo(_args) asm { \
  compchktype _args, UpdateCalibCacheInfoType \
  syscall UpdateCalibCacheInfo, _args \
}
#define SysComputeCalibValue(_args) asm { \
  compchktype _args, ComputeCalibValueType \
  syscall ComputeCalibValue, _args \
}
#endif

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

#define GetMemoryInfo(_Compact,_PoolSize,_DataspaceSize) asm { __GetMemoryInfo(_Compact,_PoolSize,_DataspaceSize,__RETVAL__) }

#define SysMemoryManager(_args) asm { \
  compchktype _args, MemoryManagerType \
  syscall MemoryManager, _args \
}

#define GetLastResponseInfo(_Clear,_Length,_Command,_Buffer) asm { __GetLastResponseInfo(_Clear,_Length,_Command,_Buffer,__RETVAL__) }

#define SysReadLastResponse(_args) asm { \
  compchktype _args, ReadLastResponseType \
  syscall ReadLastResponse, _args \
}

#endif

#define until(_c) while(!(_c))

#endif

/**
 * Wait some milliseconds.
 * Make a task sleep for specified amount of time (in 1000ths of a second).
 *
 * \param ms The number of milliseconds to sleep.
 */
inline void Wait(unsigned long ms) { asm { waitv ms } }

/**
 * Yield to another task.
 * Make a task yield to another concurrently running task.
 */
inline void Yield() { asm { wait 1 } }

/**
 * Stop all tasks.
 * Stop all currently running tasks. This will halt the program completely,
 * so any code following this command will be ignored.
 */
inline void StopAllTasks() { Stop(true); }


#ifdef __DOXYGEN_DOCS
/**
 * Stop the running program.
 * Stop the running program if bvalue is true. This will halt the program
 * completely, so any code following this command will be ignored.
 * \param bvalue If this value is true the program will stop executing.
 */
inline void Stop(bool bvalue);

/**
 * Exit to another task.
 * Immediately exit the current task and start executing the specified task.
 * \param newTask The task to start executing after exiting the current task.
 */
inline void ExitTo(task newTask);

/**
 * Declare tasks that this task precedes.
 * Schedule the listed tasks for execution once the current task has
 * completed executing. The tasks will all execute simultaneously unless other
 * dependencies prevent them from doing so. This statement should be used once
 * within a task - preferably at the start of the task definition. Any number
 * of tasks may be listed in the Precedes statement.
 * \param task1 The first task to start executing after the current task ends.
 * \param task2 The second task to start executing after the current task ends.
 * \param taskN The last task to start executing after the current task ends.
 */
inline void Precedes(task task1, task task2, ..., task taskN);

/**
 * Declare tasks that this task follows.
 * Schedule this task to follow the specified tasks so that it will execute
 * once any of the specified tasks has completed executing. This statement
 * should occur once within a task - preferably at the start of the task
 * definition. If multiple tasks declare that they follow the same task then
 * they will all execute simultaneously unless other dependencies prevent them
 * from doing so. Any number of tasks may be listed in the Follows statement.
 * \param task1 The first task that this task follows.
 * \param task2 The second task that this task follows.
 * \param taskN The last task that this task follows.
 */
inline void Follows(task task1, task task2, ..., task taskN);

/**
 * Acquire a mutex.
 * Acquire the specified mutex variable. If another task already has acquired
 * the mutex then the current task will be suspended until the mutex is
 * released by the other task. This function is used to ensure that the current
 * task has exclusive access to a shared resource, such as the display or a
 * motor. After the current task has finished using the shared resource the
 * program should call Release to allow other tasks to acquire the mutex.
 * \param m The mutex to acquire.
 */
inline void Acquire(mutex m);

/**
 * Acquire a mutex.
 * Release the specified mutex variable. Use this to relinquish a mutex so
 * that it can be acquired by another task. Release should always be called
 * after a matching call to Acquire and as soon as possible after a shared
 * resource is no longer needed.
 * \param m The mutex to release.
 */
inline void Release(mutex m);

/**
 * Start a task.
 * Start the specified task.
 * \param t The task to start.
 */
inline void StartTask(task t);

/**
 * Stop a task.
 * Stop the specified task.
 * \param t The task to stop.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void StopTask(task t);

/** @defgroup ArrayFunctions Array API functions
 * Functions for use with NXC array types.
 * @{
 */

/**
 * Build an array.
 * Build a new array from the specified source(s). The sources can be of any
 * type so long as the number of dimensions is equal to or one less than the
 * number of dimensions in the output array and the type is compatible with
 * the type of the output array. If a source is an array with the same number
 * of dimensions as the output array then all of its elements are added to
 * the output array.
 * \param aout The output array to build.
 * \param src1 The first source to build into the output array.
 * \param src2 The second source to build into the output array.
 * \param srcN The first source to build into the output array.
 */
inline void ArrayBuild(variant & aout[], variant src1, variant src2, ..., variant srcN);

/**
 * Get array length.
 * Return the length of the specified array. Any type of array of up to four
 * dimensions can be passed into this function.
 * \param data The array whose length you need to read.
 * \return The length of the specified array.
 */
inline unsigned int ArrayLen(variant data[]);

/**
 * Initialize an array.
 * Initialize the array to contain count elements with each element equal to
 * the value provided. To initialize a multi-dimensional array, the value
 * should be an array of N-1 dimensions, where N is the number of dimensions
 * in the array being initialized.
 * \param aout The output array to initialize.
 * \param value The value to initialize each element to.
 * \param count The number of elements to create in the output array.
 */
inline void ArrayInit(variant & aout[], variant value, unsigned int count);

/**
 * Copy an array subset.
 * Copy a subset of the source array starting at the specified index and
 * containing the specified number of elements into the destination array.
 * \param aout The output array containing the subset.
 * \param asrc The input array from which to copy a subset.
 * \param idx The start index of the array subset.
 * \param len The length of the array subset.
 */
inline void ArraySubset(variant & aout[], variant asrc[], unsigned int idx, unsigned int len);

#ifdef __ENHANCED_FIRMWARE

/**
 * Calculate the sum of the elements in a numeric array.
 * This function calculates the sum of all or a subset of the elements in the
 * numeric src array.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 *
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the calculation. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 * \return The sum of len elements from the src numeric array (starting from idx).
 */
inline variant ArraySum(const variant & src[], unsigned int idx, unsigned int len);

/**
 * Calculate the mean of the elements in a numeric array.
 * This function calculates the mean of all or a subset of the elements in the
 * numeric src array.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 *
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the calculation. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 * \return The mean value of len elements from the src numeric array (starting from idx).
 */
inline variant ArrayMean(const variant & src[], unsigned int idx, unsigned int len);

/**
 * Calculate the sum of the squares of the elements in a numeric array.
 * This function calculates the sum of the squares of all or a subset of the elements in the
 * numeric src array.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 *
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the calculation. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 * \return The sum of the squares of len elements from the src numeric array (starting from idx).
 */
inline variant ArraySumSqr(const variant & src[], unsigned int idx, unsigned int len);

/**
 * Calculate the standard deviation of the elements in a numeric array.
 * This function calculates the standard deviation of all or a subset of the elements in the
 * numeric src array.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 *
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the calculation. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 * \return The standard deviation of len elements from the src numeric array (starting from idx).
 */
inline variant ArrayStd(const variant & src[], unsigned int idx, unsigned int len);

/**
 * Calculate the minimum of the elements in a numeric array.
 * This function calculates the minimum of all or a subset of the elements in the
 * numeric src array.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 *
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the calculation. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 * \return The minimum of len elements from the src numeric array (starting from idx).
 */
inline variant ArrayMin(const variant & src[], unsigned int idx, unsigned int len);

/**
 * Calculate the maximum of the elements in a numeric array.
 * This function calculates the maximum of all or a subset of the elements in the
 * numeric src array.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 *
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the calculation. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 * \return The maximum of len elements from the src numeric array (starting from idx).
 */
inline variant ArrayMax(const variant & src[], unsigned int idx, unsigned int len);

/**
 * Sort the elements in a numeric array.
 * This function sorts all or a subset of the elements in the
 * numeric src array in ascending order and saves the results in the
 * numeric dest array.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 *
 * \param dest The destination numeric array.
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the sorting process. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 */
inline void ArraySort(variant & dest[], const variant & src[], unsigned int idx, unsigned int len);

/**
 * Operate on numeric arrays.
 * This function lets you perform various operations on numeric arrays.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 *
 * \param op  The array operation. See \ref ArrayOpConstants.
 * \param dest The destination variant type (scalar or array, depending on the operation).
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the specified process. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 */
inline void ArrayOp(const byte op, variant & dest, const variant & src[], unsigned int idx, unsigned int len);

#endif

/** @} */ // end of ArrayFunctions group

#else

#define StartTask(_t) start _t
#define StopTask(_t) stop _t

#if __FIRMWARE_VERSION <= 107
#define IOMA(_n) asm { mov __RETVAL__, _n }
#define SetIOMA(_n, _val) asm { mov _n, _val }
#endif

#define ArrayBuild(_aout, ...) asm { arrbuild _aout, __VA_ARGS__ }
#define ArrayLen(_asrc) asm { arrsize __RETVAL__, _asrc }
#define ArrayInit(_aout, _val, _cnt) asm { arrinit _aout, _val, _cnt }
#define ArraySubset(_aout, _asrc, _idx, _len) asm { arrsubset _aout, _asrc, _idx, _len }

#ifdef __ENHANCED_FIRMWARE
#define ArraySum(_src, _idx, _len) asm { arrop OPARR_SUM, __RETVAL__, _src, _idx, _len }
#define ArrayMean(_src, _idx, _len) asm { arrop OPARR_MEAN, __RETVAL__, _src, _idx, _len }
#define ArraySumSqr(_src, _idx, _len) asm { arrop OPARR_SUMSQR, __RETVAL__, _src, _idx, _len }
#define ArrayStd(_src, _idx, _len) asm { arrop OPARR_STD, __RETVAL__, _src, _idx, _len }
#define ArrayMin(_src, _idx, _len) asm { arrop OPARR_MIN, __RETVAL__, _src, _idx, _len }
#define ArrayMax(_src, _idx, _len) asm { arrop OPARR_MAX, __RETVAL__, _src, _idx, _len }
#define ArraySort(_dest, _src, _idx, _len) asm { arrop OPARR_SORT, _dest, _src, _idx, _len }
#define ArrayOp(_op, _dest, _src, _idx, _len) asm { arrop _op, _dest, _src, _idx, _len }
#endif

#endif


#ifdef __DOXYGEN_DOCS

/**
 * Set IOMap bytes by name.
 * Modify one or more bytes of data in an IOMap structure. The IOMap
 * structure is specified by its module name. You also provide the offset into
 * the IOMap structure where you want to start writing, the number of bytes to
 * write at that location, and a byte array containing the new data.
 * \param moduleName The module name of the IOMap to modify. See \ref ModuleNameConstants.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the data should be written
 * \param count The number of bytes to write at the specified IOMap
 * offset.
 * \param data The byte array containing the data to write to the IOMap
 */
inline void SetIOMapBytes(string moduleName, unsigned int offset, unsigned int count, byte data[]);

/**
 * Set IOMap value by name.
 * Set one of the fields of an IOMap structure to a new value.  The IOMap
 * structure is specified by its module name. You also provide the offset into
 * the IOMap structure where you want to write the value along with a variable
 * containing the new value.
 * \param moduleName The module name of the IOMap to modify. See \ref ModuleNameConstants.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the new value should be written
 * \param value A variable containing the new value to write to the IOMap
 */
inline void SetIOMapValue(string moduleName, unsigned int offset, variant value);

/**
 * Get IOMap bytes by name.
 * Read one or more bytes of data from an IOMap structure. The IOMap
 * structure is specified by its module name. You also provide the offset into
 * the IOMap structure where you want to start reading, the number of bytes to
 * read from that location, and a byte array where the data will be stored.
 * \param moduleName The module name of the IOMap. See \ref ModuleNameConstants.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the data should be read
 * \param count The number of bytes to read from the specified IOMap
 * offset.
 * \param data A byte array that will contain the data read from the IOMap
 */
inline void GetIOMapBytes(string moduleName, unsigned int offset, unsigned int count, byte & data[]);

/**
 * Get IOMap value by name.
 * Read a value from an IOMap structure.  The IOMap
 * structure is specified by its module name. You also provide the offset into
 * the IOMap structure where you want to read the value along with a variable
 * that will contain the IOMap value.
 * \param moduleName The module name of the IOMap. See \ref ModuleNameConstants.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read
 * \param value A variable that will contain the value read from the IOMap
 */
inline void GetIOMapValue(string moduleName, unsigned int offset, variant & value);

/**
 * Get Lowspeed module IOMap bytes.
 * Read one or more bytes of data from Lowspeed module IOMap structure.
 * You provide the offset into the Lowspeed module IOMap structure where you
 * want to start reading, the number of bytes to read from that location, and
 * a byte array where the data will be stored.
 * \param offset The number of bytes offset from the start of the Lowspeed
 * module IOMap structure where the data should be read. See \ref LowSpeedIOMAP.
 * \param count The number of bytes to read from the specified Lowspeed module
 * IOMap offset.
 * \param data A byte array that will contain the data read from the Lowspeed
 * module IOMap.
 */
inline void GetLowSpeedModuleBytes(unsigned int offset, unsigned int count, byte & data[]);

/**
 * Get Display module IOMap bytes.
 * Read one or more bytes of data from Display module IOMap structure.
 * You provide the offset into the Display module IOMap structure where you
 * want to start reading, the number of bytes to read from that location, and
 * a byte array where the data will be stored.
 * \param offset The number of bytes offset from the start of the Display
 * module IOMap structure where the data should be read. See \ref DisplayIOMAP.
 * \param count The number of bytes to read from the specified Display module
 * IOMap offset.
 * \param data A byte array that will contain the data read from the Display
 * module IOMap.
 */
inline void GetDisplayModuleBytes(unsigned int offset, unsigned int count, byte & data[]);

/**
 * Get Comm module IOMap bytes.
 * Read one or more bytes of data from Comm module IOMap structure.
 * You provide the offset into the Comm module IOMap structure where you
 * want to start reading, the number of bytes to read from that location, and
 * a byte array where the data will be stored.
 * \param offset The number of bytes offset from the start of the Comm module
 * IOMap structure where the data should be read. See \ref CommIOMAP.
 * \param count The number of bytes to read from the specified Comm module
 * IOMap offset.
 * \param data A byte array that will contain the data read from the Comm
 * module IOMap.
 */
inline void GetCommModuleBytes(unsigned int offset, unsigned int count, byte & data[]);

/**
 * Get Command module IOMap bytes.
 * Read one or more bytes of data from Command module IOMap structure.
 * You provide the offset into the Command module IOMap structure where you
 * want to start reading, the number of bytes to read from that location, and
 * a byte array where the data will be stored.
 * \param offset The number of bytes offset from the start of the Command module
 * IOMap structure where the data should be read. See \ref CommandIOMAP.
 * \param count The number of bytes to read from the specified Command module
 * IOMap offset.
 * \param data A byte array that will contain the data read from the Command
 * module IOMap.
 */
inline void GetCommandModuleBytes(unsigned int offset, unsigned int count, byte & data[]);

/**
 * Set Command module IOMap bytes.
 * Modify one or more bytes of data in the Command module IOMap structure. You
 * provide the offset into the Command module IOMap structure where you want
 * to start writing, the number of bytes to write at that location, and a byte
 * array containing the new data.
 * \param offset The number of bytes offset from the start of the Command module
 * IOMap structure where the data should be written. See \ref CommandIOMAP.
 * \param count The number of bytes to write at the specified Command module
 * IOMap offset.
 * \param data The byte array containing the data to write to the Command
 * module IOMap.
 */
inline void SetCommandModuleBytes(unsigned int offset, unsigned int count, byte data[]);

/**
 * Set Lowspeed module IOMap bytes.
 * Modify one or more bytes of data in the Lowspeed module IOMap structure. You
 * provide the offset into the Lowspeed module IOMap structure where you want
 * to start writing, the number of bytes to write at that location, and a byte
 * array containing the new data.
 * \param offset The number of bytes offset from the start of the Lowspeed
 * module IOMap structure where the data should be written. See \ref LowSpeedIOMAP.
 * \param count The number of bytes to write at the specified Lowspeed module
 * IOMap offset.
 * \param data The byte array containing the data to write to the Lowspeed
 * module IOMap.
 */
inline void SetLowSpeedModuleBytes(unsigned int offset, unsigned int count, byte data[]);

/**
 * Set Display module IOMap bytes.
 * Modify one or more bytes of data in the Display module IOMap structure. You
 * provide the offset into the Display module IOMap structure where you want to
 * start writing, the number of bytes to write at that location, and a byte
 * array containing the new data.
 * \param offset The number of bytes offset from the start of the Display module
 * IOMap structure where the data should be written. See \ref DisplayIOMAP.
 * \param count The number of bytes to write at the specified Display module
 * IOMap offset.
 * \param data The byte array containing the data to write to the Display
 * module IOMap.
 */
inline void SetDisplayModuleBytes(unsigned int offset, unsigned int count, byte data[]);

/**
 * Set Comm module IOMap bytes.
 * Modify one or more bytes of data in an IOMap structure. You provide the
 * offset into the Comm module IOMap structure where you want to start writing,
 * the number of bytes to write at that location, and a byte array containing
 * the new data.
 * \param offset The number of bytes offset from the start of the Comm module
 * IOMap structure where the data should be written. See \ref CommIOMAP.
 * \param count The number of bytes to write at the specified Comm module IOMap
 * offset.
 * \param data The byte array containing the data to write to the Comm module
 * IOMap.
 */
inline void SetCommModuleBytes(unsigned int offset, unsigned int count, byte data[]);


#ifdef __ENHANCED_FIRMWARE
/**
 * Set IOMap bytes by ID.
 * Modify one or more bytes of data in an IOMap structure. The IOMap
 * structure is specified by its Module ID. You also provide the offset into
 * the IOMap structure where you want to start writing, the number of bytes to
 * write at that location, and a byte array containing the new data.
 * \param moduleId The module ID of the IOMap to modify. See \ref ModuleIDConstants.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the data should be written.
 * \param count The number of bytes to write at the specified IOMap
 * offset.
 * \param data The byte array containing the data to write to the IOMap.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SetIOMapBytesByID(unsigned long moduleId, unsigned int offset, unsigned int count, byte data[]);

/**
 * Set IOMap value by ID.
 * Set one of the fields of an IOMap structure to a new value.  The IOMap
 * structure is specified by its Module ID. You also provide the offset into
 * the IOMap structure where you want to write the value along with a variable
 * containing the new value.
 * \param moduleId The module ID of the IOMap to modify. See \ref ModuleIDConstants.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the new value should be written.
 * \param value A variable containing the new value to write to the IOMap.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SetIOMapValueByID(unsigned long moduleId, unsigned int offset, variant value);

/**
 * Get IOMap bytes by ID.
 * Read one or more bytes of data from an IOMap structure. The IOMap
 * structure is specified by its Module ID. You also provide the offset into
 * the IOMap structure where you want to start reading, the number of bytes to
 * read from that location, and a byte array where the data will be stored.
 * \param moduleId The module ID of the IOMap. See \ref ModuleIDConstants.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the data should be read.
 * \param count The number of bytes to read from the specified IOMap
 * offset.
 * \param data A byte array that will contain the data read from the IOMap.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void GetIOMapBytesByID(unsigned long moduleId, unsigned int offset, unsigned int count, byte & data[]);

/**
 * Get IOMap value by ID.
 * Read a value from an IOMap structure.  The IOMap
 * structure is specified by its Module ID. You also provide the offset into
 * the IOMap structure where you want to read the value along with a variable
 * that will contain the IOMap value.
 * \param moduleId The module ID of the IOMap. See \ref ModuleIDConstants.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read.
 * \param value A variable that will contain the value read from the IOMap.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void GetIOMapValueByID(unsigned long moduleId, unsigned int offset, variant & value);

#endif

/**
 * Set Command module IOMap value.
 * Set one of the fields of the Command module IOMap structure to a new value.
 * You provide the offset into the Command module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param offset The number of bytes offset from the start of the Command
 * module IOMap structure where the new value should be written. See \ref CommandIOMAP.
 * \param value A variable containing the new value to write to the Command
 * module IOMap.
 */
inline void SetCommandModuleValue(unsigned int offset, variant value);

/**
 * Set IOCtrl module IOMap value.
 * Set one of the fields of the IOCtrl module IOMap structure to a new value.
 * You provide the offset into the IOCtrl module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param offset The number of bytes offset from the start of the IOCtrl
 * module IOMap structure where the new value should be written. See \ref IOCtrlIOMAP.
 * \param value A variable containing the new value to write to the IOCtrl
 * module IOMap.
 */
inline void SetIOCtrlModuleValue(unsigned int offset, variant value);

/**
 * Set Loader module IOMap value.
 * Set one of the fields of the Loader module IOMap structure to a new value.
 * You provide the offset into the Loader module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param offset The number of bytes offset from the start of the Loader
 * module IOMap structure where the new value should be written. See \ref LoaderIOMAP.
 * \param value A variable containing the new value to write to the Loader
 * module IOMap.
 */
inline void SetLoaderModuleValue(unsigned int offset, variant value);

/**
 * Set Ui module IOMap value.
 * Set one of the fields of the Ui module IOMap structure to a new value.
 * You provide the offset into the Ui module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param offset The number of bytes offset from the start of the Ui
 * module IOMap structure where the new value should be written. See \ref UiIOMAP.
 * \param value A variable containing the new value to write to the Ui
 * module IOMap.
 */
inline void SetUIModuleValue(unsigned int offset, variant value);

/**
 * Set Sound module IOMap value.
 * Set one of the fields of the Sound module IOMap structure to a new value.
 * You provide the offset into the Sound module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param offset The number of bytes offset from the start of the Sound
 * module IOMap structure where the new value should be written. See \ref SoundIOMAP.
 * \param value A variable containing the new value to write to the Sound
 * module IOMap.
 */
inline void SetSoundModuleValue(unsigned int offset, variant value);

/**
 * Set Button module IOMap value.
 * Set one of the fields of the Button module IOMap structure to a new value.
 * You provide the offset into the Button module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param offset The number of bytes offset from the start of the Button
 * module IOMap structure where the new value should be written. See \ref ButtonIOMAP.
 * \param value A variable containing the new value to write to the Button
 * module IOMap.
 */
inline void SetButtonModuleValue(unsigned int offset, variant value);

/**
 * Set Input module IOMap value.
 * Set one of the fields of the Input module IOMap structure to a new value.
 * You provide the offset into the Input module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param offset The number of bytes offset from the start of the Input
 * module IOMap structure where the new value should be written. See \ref InputIOMAP.
 * \param value A variable containing the new value to write to the Input
 * module IOMap.
 */
inline void SetInputModuleValue(unsigned int offset, variant value);

/**
 * Set Output module IOMap value.
 * Set one of the fields of the Output module IOMap structure to a new value.
 * You provide the offset into the Output module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param offset The number of bytes offset from the start of the Output
 * module IOMap structure where the new value should be written. See \ref OutputIOMAP.
 * \param value A variable containing the new value to write to the Output
 * module IOMap.
 */
inline void SetOutputModuleValue(unsigned int offset, variant value);

/**
 * Set Lowspeed module IOMap value.
 * Set one of the fields of the Lowspeed module IOMap structure to a new value.
 * You provide the offset into the Lowspeed module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param offset The number of bytes offset from the start of the Lowspeed
 * module IOMap structure where the new value should be written. See \ref LowSpeedIOMAP.
 * \param value A variable containing the new value to write to the Lowspeed
 * module IOMap.
 */
inline void SetLowSpeedModuleValue(unsigned int offset, variant value);

/**
 * Set Display module IOMap value.
 * Set one of the fields of the Display module IOMap structure to a new value.
 * You provide the offset into the Display module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param offset The number of bytes offset from the start of the Display
 * module IOMap structure where the new value should be written. See \ref DisplayIOMAP.
 * \param value A variable containing the new value to write to the Display
 * module IOMap.
 */
inline void SetDisplayModuleValue(unsigned int offset, variant value);

/**
 * Set Comm module IOMap value.
 * Set one of the fields of the Comm module IOMap structure to a new value.
 * You provide the offset into the Comm module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param offset The number of bytes offset from the start of the Comm
 * module IOMap structure where the new value should be written. See \ref CommIOMAP.
 * \param value A variable containing the new value to write to the Comm
 * module IOMap.
 */
inline void SetCommModuleValue(unsigned int offset, variant value);

/**
 * Get Command module IOMap value.
 * Read a value from the Command module IOMap structure.  You provide the
 * offset into the Command module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref CommandIOMAP.
 * \param value A variable that will contain the value read from the IOMap.
 */
inline void GetCommandModuleValue(unsigned int offset, variant & value);

/**
 * Get Loader module IOMap value.
 * Read a value from the Loader module IOMap structure.  You provide the
 * offset into the Loader module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref LoaderIOMAP.
 * \param value A variable that will contain the value read from the IOMap.
 */
inline void GetLoaderModuleValue(unsigned int offset, variant & value);

/**
 * Get Sound module IOMap value.
 * Read a value from the Sound module IOMap structure.  You provide the
 * offset into the Sound module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref SoundIOMAP.
 * \param value A variable that will contain the value read from the IOMap.
 */
inline void GetSoundModuleValue(unsigned int offset, variant & value);

/**
 * Get Button module IOMap value.
 * Read a value from the Button module IOMap structure.  You provide the
 * offset into the Button module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref ButtonIOMAP.
 * \param value A variable that will contain the value read from the IOMap.
 */
inline void GetButtonModuleValue(unsigned int offset, variant & value);

/**
 * Get Ui module IOMap value.
 * Read a value from the Ui module IOMap structure.  You provide the
 * offset into the Ui module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref UiIOMAP.
 * \param value A variable that will contain the value read from the IOMap.
 */
inline void GetUIModuleValue(unsigned int offset, variant & value);

/**
 * Get Input module IOMap value.
 * Read a value from the Input module IOMap structure.  You provide the
 * offset into the Input module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref InputIOMAP.
 * \param value A variable that will contain the value read from the IOMap.
 */
inline void GetInputModuleValue(unsigned int offset, variant & value);

/**
 * Get Output module IOMap value.
 * Read a value from the Output module IOMap structure.  You provide the
 * offset into the Output module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref OutputIOMAP.
 * \param value A variable that will contain the value read from the IOMap.
 */
inline void GetOutputModuleValue(unsigned int offset, variant & value);

/**
 * Get LowSpeed module IOMap value.
 * Read a value from the LowSpeed module IOMap structure.  You provide the
 * offset into the Command module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref LowSpeedIOMAP.
 * \param value A variable that will contain the value read from the IOMap.
 */
inline void GetLowSpeedModuleValue(unsigned int offset, variant & value);

/**
 * Get Display module IOMap value.
 * Read a value from the Display module IOMap structure.  You provide the
 * offset into the Display module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref DisplayIOMAP.
 * \param value A variable that will contain the value read from the IOMap.
 */
inline void GetDisplayModuleValue(unsigned int offset, variant & value);

/**
 * Get Comm module IOMap value.
 * Read a value from the Comm module IOMap structure.  You provide the
 * offset into the Comm module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref CommIOMAP.
 * \param value A variable that will contain the value read from the IOMap.
 */
inline void GetCommModuleValue(unsigned int offset, variant & value);


#else

#define SetIOMapBytes(_modName, _offset, _cnt, _arrIn) asm { __SetIOMapBytes(_modName, _offset, _cnt, _arrIn) }
#define SetIOMapValue(_modName, _offset, _n) asm { __SetIOMapValue(_modName, _offset, _n) }

#define GetIOMapBytes(_modName, _offset, _cnt, _arrOut) asm { __getIOMapBytes(_modName, _offset, _cnt, _arrOut) }
#define GetIOMapValue(_modName, _offset, _n) asm { __getIOMapValue(_modName, _offset, _n) }

#define GetLowSpeedModuleBytes(_offset, _cnt, _arrOut) asm { __getLowSpeedModuleBytes(_offset, _cnt, _arrOut) }
#define GetDisplayModuleBytes(_offset, _cnt, _arrOut) asm { __getDisplayModuleBytes(_offset, _cnt, _arrOut) }
#define GetCommModuleBytes(_offset, _cnt, _arrOut) asm { __getCommModuleBytes(_offset, _cnt, _arrOut) }

#ifdef __ENHANCED_FIRMWARE

#define SetIOMapBytesByID(_modID, _offset, _cnt, _arrIn) asm { __SetIOMapBytesByID(_modID, _offset, _cnt, _arrIn) }
#define SetIOMapValueByID(_modID, _offset, _n) asm { __SetIOMapValueByID(_modID, _offset, _n) }

#define GetIOMapBytesByID(_modID, _offset, _cnt, _arrOut) asm { __getIOMapBytesByID(_modID, _offset, _cnt, _arrOut) }
#define GetIOMapValueByID(_modID, _offset, _n) asm { __getIOMapValueByID(_modID, _offset, _n) }

#define SetCommandModuleValue(_offset, _n) SetIOMapValueByID(CommandModuleID, _offset, _n)
#define SetIOCtrlModuleValue(_offset, _n) SetIOMapValueByID(IOCtrlModuleID, _offset, _n)
#define SetLoaderModuleValue(_offset, _n) SetIOMapValueByID(LoaderModuleID, _offset, _n)
#define SetUIModuleValue(_offset, _n) SetIOMapValueByID(UIModuleID, _offset, _n)
#define SetSoundModuleValue(_offset, _n) SetIOMapValueByID(SoundModuleID, _offset, _n)
#define SetButtonModuleValue(_offset, _n) SetIOMapValueByID(ButtonModuleID, _offset, _n)
#define SetInputModuleValue(_offset, _n) SetIOMapValueByID(InputModuleID, _offset, _n)
#define SetOutputModuleValue(_offset, _n) SetIOMapValueByID(OutputModuleID, _offset, _n)
#define SetLowSpeedModuleValue(_offset, _n) SetIOMapValueByID(LowSpeedModuleID, _offset, _n)
#define SetDisplayModuleValue(_offset, _n) SetIOMapValueByID(DisplayModuleID, _offset, _n)
#define SetCommModuleValue(_offset, _n) SetIOMapValueByID(CommModuleID, _offset, _n)

#define SetCommandModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytesByID(CommandModuleID, _offset, _cnt, _arrIn)
#define SetLowSpeedModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytesByID(LowSpeedModuleID, _offset, _cnt, _arrIn)
#define SetDisplayModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytesByID(DisplayModuleID, _offset, _cnt, _arrIn)
#define SetCommModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytesByID(CommModuleID, _offset, _cnt, _arrIn)

#define GetCommandModuleValue(_offset, _n) GetIOMapValueByID(CommandModuleID, _offset, _n)
#define GetLoaderModuleValue(_offset, _n) GetIOMapValueByID(LoaderModuleID, _offset, _n)
#define GetSoundModuleValue(_offset, _n) GetIOMapValueByID(SoundModuleID, _offset, _n)
#define GetButtonModuleValue(_offset, _n) GetIOMapValueByID(ButtonModuleID, _offset, _n)
#define GetUIModuleValue(_offset, _n) GetIOMapValueByID(UIModuleID, _offset, _n)
#define GetInputModuleValue(_offset, _n) GetIOMapValueByID(InputModuleID, _offset, _n)
#define GetOutputModuleValue(_offset, _n) GetIOMapValueByID(OutputModuleID, _offset, _n)
#define GetLowSpeedModuleValue(_offset, _n) GetIOMapValueByID(LowSpeedModuleID, _offset, _n)
#define GetDisplayModuleValue(_offset, _n) GetIOMapValueByID(DisplayModuleID, _offset, _n)
#define GetCommModuleValue(_offset, _n) GetIOMapValueByID(CommModuleID, _offset, _n)

#else

#define SetCommandModuleValue(_offset, _n) SetIOMapValue(CommandModuleName, _offset, _n)
#define SetIOCtrlModuleValue(_offset, _n) SetIOMapValue(IOCtrlModuleName, _offset, _n)
#define SetLoaderModuleValue(_offset, _n) SetIOMapValue(LoaderModuleName, _offset, _n)
#define SetUIModuleValue(_offset, _n) SetIOMapValue(UIModuleName, _offset, _n)
#define SetSoundModuleValue(_offset, _n) SetIOMapValue(SoundModuleName, _offset, _n)
#define SetButtonModuleValue(_offset, _n) SetIOMapValue(ButtonModuleName, _offset, _n)
#define SetInputModuleValue(_offset, _n) SetIOMapValue(InputModuleName, _offset, _n)
#define SetOutputModuleValue(_offset, _n) SetIOMapValue(OutputModuleName, _offset, _n)
#define SetLowSpeedModuleValue(_offset, _n) SetIOMapValue(LowSpeedModuleName, _offset, _n)
#define SetDisplayModuleValue(_offset, _n) SetIOMapValue(DisplayModuleName, _offset, _n)
#define SetCommModuleValue(_offset, _n) SetIOMapValue(CommModuleName, _offset, _n)

#define SetCommandModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytes(CommandModuleName, _offset, _cnt, _arrIn)
#define SetLowSpeedModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytes(LowSpeedModuleName, _offset, _cnt, _arrIn)
#define SetDisplayModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytes(DisplayModuleName, _offset, _cnt, _arrIn)
#define SetCommModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytes(CommModuleName, _offset, _cnt, _arrIn)

#define GetCommandModuleValue(_offset, _n) GetIOMapValue(CommandModuleName, _offset, _n)
#define GetLoaderModuleValue(_offset, _n) GetIOMapValue(LoaderModuleName, _offset, _n)
#define GetSoundModuleValue(_offset, _n) GetIOMapValue(SoundModuleName, _offset, _n)
#define GetButtonModuleValue(_offset, _n) GetIOMapValue(ButtonModuleName, _offset, _n)
#define GetUIModuleValue(_offset, _n) GetIOMapValue(UIModuleName, _offset, _n)
#define GetInputModuleValue(_offset, _n) GetIOMapValue(InputModuleName, _offset, _n)
#define GetOutputModuleValue(_offset, _n) GetIOMapValue(OutputModuleName, _offset, _n)
#define GetLowSpeedModuleValue(_offset, _n) GetIOMapValue(LowSpeedModuleName, _offset, _n)
#define GetDisplayModuleValue(_offset, _n) GetIOMapValue(DisplayModuleName, _offset, _n)
#define GetCommModuleValue(_offset, _n) GetIOMapValue(CommModuleName, _offset, _n)

#endif

#endif


/** @} */ // end of CommandModuleFunctions group
/** @} */ // end of CommandModule group
/** @} */ // end of NXTFirmwareModules group

#endif // COMMAND_H
