/** \file nbc_comm.h
 * \brief The NBC comm module API
 *
 * nbc_comm.h contains the NBC comm module API
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

#ifndef NBC_COMM_H
#define NBC_COMM_H

#include "command_constants.h"
#include "comm_constants.h"
#include "nbc_command.h"

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// COMM MODULE /////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup CommModule
 * @{
 */
/** @defgroup CommModuleFunctions Comm module functions
 * Functions for accessing and modifying Comm module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

#define __setBTDeviceClass(_p, _n) \
  compchk EQ, sizeof(_n), 4 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleValue(CommOffsetBtDeviceTableClassOfDevice(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 24 \
  SetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __setBTDeviceStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleValue(CommOffsetBtDeviceTableDeviceStatus(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 35 \
  SetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __setBTConnectionClass(_p, _n) \
  compchk EQ, sizeof(_n), 4 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleValue(CommOffsetBtConnectTableClassOfDevice(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 954 \
  SetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __setBTConnectionHandleNum(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleValue(CommOffsetBtConnectTableHandleNr(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 981 \
  SetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __setBTConnectionStreamStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleValue(CommOffsetBtConnectTableStreamStatus(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 982 \
  SetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __setBTConnectionLinkQuality(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleValue(CommOffsetBtConnectTableLinkQuality(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 983 \
  SetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __setBrickDataBluecoreVersion(_n) \
  compchk EQ, sizeof(_n), 2 \
  SetCommModuleValue(CommOffsetBrickDataBluecoreVersion, _n)

#define __setBrickDataBtStateStatus(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBrickDataBtStateStatus, _n)

#define __setBrickDataBtHardwareStatus(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBrickDataBtHwStatus, _n)

#define __setBrickDataTimeoutValue(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBrickDataTimeOutValue, _n)

#define __setBTInputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBtInBufInPtr, _n)

#define __setBTInputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBtInBufOutPtr, _n)

#define __setBTOutputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBtOutBufInPtr, _n)

#define __setBTOutputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBtOutBufOutPtr, _n)

#define __setHSInputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetHsInBufInPtr, _n)

#define __setHSInputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetHsInBufOutPtr, _n)

#define __setHSOutputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetHsOutBufInPtr, _n)

#define __setHSOutputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetHsOutBufOutPtr, _n)

#define __setUSBInputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetUsbInBufInPtr, _n)

#define __setUSBInputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetUsbInBufOutPtr, _n)

#define __setUSBOutputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetUsbOutBufInPtr, _n)

#define __setUSBOutputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetUsbOutBufOutPtr, _n)

#define __setUSBPollBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetUsbPollBufInPtr, _n)

#define __setUSBPollBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetUsbPollBufOutPtr, _n)

#define __setBTDeviceCount(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBtDeviceCnt, _n)

#define __setBTDeviceNameCount(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBtDeviceNameCnt, _n)

#define __setHSFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetHsFlags, _n)

#define __setHSSpeed(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetHsSpeed, _n)

#define __setHSState(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetHsState, _n)

#define __setUSBState(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetUsbState, _n)

#define __setHSAddress(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetHsAddress, _n)

#if (__FIRMWARE_VERSION > 107) && defined(__ENHANCED_FIRMWARE)

#define __setHSMode(_n) \
  compchk EQ, sizeof(_n), 2 \
  SetCommModuleValue(CommOffsetHsMode, _n)

#define __setBTDataMode(_n) \
  compchk EQ, sizeof(_n), 1 \
  compchk EQ, isconst(_n), 1 \
  SetCommModuleValue(CommOffsetBtDataMode, _n|DATA_MODE_UPDATE) \
  wait 1

#define __setHSDataMode(_n) \
  compchk EQ, sizeof(_n), 1 \
  compchk EQ, isconst(_n), 1 \
  SetCommModuleValue(CommOffsetHsDataMode, _n|DATA_MODE_UPDATE) \
  wait 1

#endif

dseg segment
// MessageWrite
TMessageWrite	struct
 Result		sbyte
 QueueID	byte
 Message	byte[]
TMessageWrite	ends

// MessageRead
TMessageRead	struct
 Result		sbyte
 QueueID	byte
 Remove		byte
 Message	byte[]
TMessageRead	ends

  __MWArgs TMessageWrite
  __MRArgs TMessageRead
  __MWMutex mutex
  __MRMutex mutex
  __SRNTmpVal sdword
  __RRNTmpVal sdword
  __RRNErr byte
dseg ends

#define __sendMessage(_queue, _msg, _result) \
  acquire __MWMutex \
  mov __MWArgs.QueueID, _queue \
  mov __MWArgs.Message, _msg \
  syscall MessageWrite, __MWArgs \
  mov _result, __MWArgs.Result \
  release __MWMutex

#define __receiveMessage(_queue, _clear, _msg, _result) \
  acquire __MRMutex \
  mov __MRArgs.QueueID, _queue \
  mov __MRArgs.Remove, _clear \
  syscall MessageRead, __MRArgs \
  mov _msg, __MRArgs.Message \
  mov _result, __MRArgs.Result \
  release __MRMutex

#define __receiveRemoteBool(_queue, _clear, _bval, _result) \
  acquire __MRMutex \
  mov __MRArgs.QueueID, _queue \
  mov __MRArgs.Remove, _clear \
  set _bval, 0 \
  syscall MessageRead, __MRArgs \
  brtst NEQ, __RRB_Err##__I__, __MRArgs.Result \
  index _bval, __MRArgs.Message, NA \
  __RRB_Err##__I__: \
  __IncI__ \
  mov _result, __MRArgs.Result \
  release __MRMutex

#define __receiveRemoteNumber(_queue, _clear, _val, _result) \
  acquire __MRMutex \
  mov __MRArgs.QueueID, _queue \
  mov __MRArgs.Remove, _clear \
  set __RRNTmpVal, 0 \
  syscall MessageRead, __MRArgs \
  unflatten __RRNTmpVal, __RRNErr, __MRArgs.Message, __RRNTmpVal \
  mov _val, __RRNTmpVal \
  mov _result, __MRArgs.Result \
  release __MRMutex

#define __receiveRemoteMessageEx(_queue, _clear, _str, _val, _bval, _result) \
  acquire __MRMutex \
  mov __MRArgs.QueueID, _queue \
  mov __MRArgs.Remove, _clear \
  set __RRNTmpVal, 0 \
  set _bval, 0 \
  syscall MessageRead, __MRArgs \
  brtst NEQ, __RRM_Err##__I__, __MRArgs.Result \
  index _bval, __MRArgs.Message, NA \
  unflatten __RRNTmpVal, __RRNErr, __MRArgs.Message, __RRNTmpVal \
  __RRM_Err##__I__: \
  __IncI__ \
  mov _val, __RRNTmpVal \
  mov _str, __MRArgs.Message \
  mov _result, __MRArgs.Result \
  release __MRMutex

#define __sendResponseBool(_queue, _bval, _result) \
  acquire __MWMutex \
  add __MWArgs.QueueID, _queue, 10 \
  arrbuild __MWArgs.Message, _bval, 0 \
  syscall MessageWrite, __MWArgs \
  mov _result, __MWArgs.Result \
  release __MWMutex

#define __sendResponseNumber(_queue, _val, _result) \
  acquire __MWMutex \
  add __MWArgs.QueueID, _queue, 10 \
  mov __SRNTmpVal, _val \
  flatten __MWArgs.Message, __SRNTmpVal \
  syscall MessageWrite, __MWArgs \
  mov _result, __MWArgs.Result \
  release __MWMutex

#define __sendResponseString(_queue, _msg, _result) \
  acquire __MWMutex \
  add __MWArgs.QueueID, _queue, 10 \
  mov __MWArgs.Message, _msg \
  syscall MessageWrite, __MWArgs \
  mov _result, __MWArgs.Result \
  release __MWMutex


dseg segment
// CommBTCheckStatus
TCommBTCheckStatus	struct
 Result		sbyte
 Connection	byte
TCommBTCheckStatus	ends

// CommBTWrite
TCommBTWrite	struct
 Result		sbyte
 Connection	byte
 Buffer		byte[]
TCommBTWrite	ends

// CommBTRead
TCommBTRead	struct
 Result		sbyte
 Count		byte
 Buffer		byte[]
TCommBTRead	ends

  __CBTCSArgs TCommBTCheckStatus
  __CBTWArgs TCommBTWrite
  __SRSTmpBuf byte[]
  __SRSSendBuf byte[]
  __SRSTmpLongVal sdword
  __SRSTmpWordVal sword
  __SRSTmpByteVal sbyte
  __SRSFlattenBuf byte[]
  __CBTCSMutex mutex
  __CBTWMutex mutex
  __RemoteMutex mutex
dseg ends

dseg segment
  __GenericCmdFilenamePacket byte[] {0xFF, 0xFF, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  __GenericCreateFilePacket byte[]  {0xFF, 0xFF, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0xFF, 0xFF, 0xFF, 0xFF}
  __GenericIOMapPacket byte[]       {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}
// direct commands
  __DCStartProgramPacket byte[]     {0x80, 0x00}
  __DCStopProgramPacket byte[]      {0x80, 0x01}
  __DCPlaySoundFilePacket byte[]    {0x80, 0x02, 0xFF, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  __DCPlayTonePacket byte[]         {0x80, 0x03, 0xFF, 0xFF, 0xFF, 0xFF}
  __DCSetOutputStatePacket byte[]   {0x80, 0x04}
  __DCSetInputModePacket byte[]     {0x80, 0x05}
  __DCGetOutputStatePacket byte[]   {0x00, 0x06}
  __DCGetInputValuesPacket byte[]   {0x00, 0x07}
  __DCResetScaledValuePacket byte[] {0x80, 0x08}
  __DCMessageWritePacket byte[]     {0x80, 0x09, 0xFF, 0xFF}
  __DCResetMotorPosPacket byte[]    {0x80, 0x0a}
  __DCGetBatteryLevelPacket byte[]  {0x00, 0x0b}
  __DCStopSoundPacket byte[]        {0x80, 0x0c}
  __DCKeepAlivePacket byte[]        {0x80, 0x0d}
  __DCLSGetStatusPacket byte[]      {0x00, 0x0e}
  __DCLSWritePacket byte[]          {0x80, 0x0f}
  __DCLSReadPacket byte[]           {0x00, 0x10}
  __DCGetCurProgNamePacket byte[]   {0x00, 0x11}
  __DCMessageReadPacket byte[]      {0x00, 0x13}
  __DCDatalogReadPacket byte[]      {0x00, 0x19}
  __DCDatalogSetTimesPacket byte[]  {0x80, 0x1a}
  __DCBTGetContactCntPacket byte[]  {0x00, 0x1b}
  __DCBTGetContactNamePacket byte[] {0x00, 0x1c}
  __DCBTGetConnectCntPacket byte[]  {0x00, 0x1d}
  __DCBTGetConnectNamePacket byte[] {0x00, 0x1e}
  __DCSetPropertyPacket byte[]      {0x80, 0x1f}
  __DCGetPropertyPacket byte[]      {0x00, 0x20}
  __DCUpdateResetCountPacket byte[] {0x80, 0x21}
// system commands
  __SCOpenReadPacket byte[]         {0x01, 0x80}
  __SCOpenWritePacket byte[]        {0x01, 0x81}
  __SCReadPacket byte[]             {0x01, 0x82}
  __SCWritePacket byte[]            {0x01, 0x83}
  __SCClosePacket byte[]            {0x01, 0x84}
  __SCDeletePacket byte[]           {0x01, 0x85}
  __SCFindFirstPacket byte[]        {0x01, 0x86}
  __SCFindNextPacket byte[]         {0x01, 0x87}
  __SCGetFirmwareVerPacket byte[]   {0x01, 0x88}
  __SCOpenWriteLinearPacket byte[]  {0x01, 0x89}
  __SCOpenWriteDataPacket byte[]    {0x01, 0x8b}
  __SCOpenAppendDataPacket byte[]   {0x01, 0x8c}
  __SCIOMapReadPacket byte[]        {0x01, 0x94}
  __SCIOMapWritePacket byte[]       {0x81, 0x95}
  __SCSetBrickNamePacket byte[]     {0x81, 0x98, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  __SCBTGetAddressPacket byte[]     {0x01, 0x9a}
  __SCGetDeviceInfoPacket byte[]    {0x01, 0x9b}
  __SCDeleteUserFlashPacket byte[]  {0x01, 0xA0}
  __SCPollCommandLenPacket byte[]   {0x01, 0xA1}
  __SCPollCommandPacket byte[]      {0x01, 0xA2} // append buffer number, cmd len,
  __SCRenameFilePacket byte[]       {0x81, 0xA3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  __SCBTFactoryResetPacket byte[]   {0x81, 0xA4}
dseg ends

#define __bluetoothStatus(_conn, _result) \
  acquire __CBTCSMutex \
  mov __CBTCSArgs.Connection, _conn \
  syscall CommBTCheckStatus, __CBTCSArgs \
  mov _result, __CBTCSArgs.Result \
  release __CBTCSMutex

#define __bluetoothWrite(_conn, _buffer, _result) \
  acquire __CBTWMutex \
  mov __CBTWArgs.Connection, _conn \
  mov __CBTWArgs.Buffer, _buffer \
  syscall CommBTWrite, __CBTWArgs \
  mov _result, __CBTWArgs.Result \
  release __CBTWMutex

#define __UseRS485() \
  setin IN_TYPE_HISPEED, IN_4, TypeField \
  wait 1

#ifdef __ENHANCED_FIRMWARE

dseg segment
TCommHSCheckStatus	struct
 SendingData	byte
 DataAvailable	byte
TCommHSCheckStatus	ends

// CommHSRead, CommHSWrite
TCommHSReadWrite	struct
 Status	sbyte
 Buffer	byte[]
#if __FIRMWARE_VERSION > 107
 BufferLen	byte
#endif
TCommHSReadWrite	ends

TCommHSControl	struct
 Result		sbyte
 Command	byte
 BaudRate	byte
#if __FIRMWARE_VERSION > 107
 Mode		word
#endif
TCommHSControl	ends

  __CHSCSArgs TCommHSCheckStatus
  __CHSWArgs TCommHSReadWrite
  __CHSRArgs TCommHSReadWrite
  __CHSCArgs TCommHSControl

  __CHSCSMutex mutex
  __CHSWMutex mutex
  __CHSRMutex mutex
  __CHSCMutex mutex
  __WFRRMutex mutex

  __SHSTmpVal sdword
  __WFRRAvail byte
  __WFRR_I byte
  __WFRRCmd byte
  __WFRRBuffer byte[]
  __WFRRTmpBuffer byte[]
  __WFRRUnflattenBuf byte[]
  __WFRRUnflattenErr byte
  __WFRRTmpByte byte
  __WFRRTmpSWord sword
  __WFRRTmpSDWord sdword
  __WFRRStatus sbyte
dseg ends

#define __RS485Status(_sendingData, _dataAvail) \
  acquire __CHSCSMutex \
  syscall CommHSCheckStatus, __CHSCSArgs \
  mov _sendingData, __CHSCSArgs.SendingData \
  mov _dataAvail, __CHSCSArgs.DataAvailable \
  release __CHSCSMutex

#define __RS485WriteSCDC(_conn, _buffer, _status) \
  acquire __CHSWMutex \
  sub __WFRRTmpByte, _conn, CONN_HS_ALL \
  arrbuild __CHSWArgs.Buffer, __WFRRTmpByte, _buffer \
  syscall CommHSWrite, __CHSWArgs \
  mov _status, __CHSWArgs.Status \
  release __CHSWMutex

#define __RS485Write(_buffer, _status) \
  acquire __CHSWMutex \
  mov __CHSWArgs.Buffer, _buffer \
  syscall CommHSWrite, __CHSWArgs \
  mov _status, __CHSWArgs.Status \
  release __CHSWMutex

#if __FIRMWARE_VERSION > 107

#define __RS485Read(_buffer, _status) \
  acquire __CHSRMutex \
  set __CHSRArgs.BufferLen, 0xFF \
  syscall CommHSRead, __CHSRArgs \
  mov _buffer, __CHSRArgs.Buffer \
  mov _status, __CHSRArgs.Status \
  release __CHSRMutex

#define __RS485ReadEx(_buffer, _buflen, _status) \
  acquire __CHSRMutex \
  mov __CHSRArgs.BufferLen, _buflen \
  syscall CommHSRead, __CHSRArgs \
  mov _buffer, __CHSRArgs.Buffer \
  mov _status, __CHSRArgs.Status \
  release __CHSRMutex

#define __RS485Control(_cmd, _baud, _mode, _result) \
  acquire __CHSCMutex \
  mov __CHSCArgs.Command, _cmd \
  mov __CHSCArgs.BaudRate, _baud \
  mov __CHSCArgs.Mode, _mode \
  syscall CommHSControl, __CHSCArgs \
  mov _result, __CHSCArgs.Result \
  release __CHSCMutex \
  wait 1

#else

#define __RS485Read(_buffer, _status) \
  acquire __CHSRMutex \
  syscall CommHSRead, __CHSRArgs \
  mov _buffer, __CHSRArgs.Buffer \
  mov _status, __CHSRArgs.Status \
  release __CHSRMutex

#define __RS485Control(_cmd, _baud, _result) \
  acquire __CHSCMutex \
  mov __CHSCArgs.Command, _cmd \
  mov __CHSCArgs.BaudRate, _baud \
  syscall CommHSControl, __CHSCArgs \
  mov _result, __CHSCArgs.Result \
  release __CHSCMutex \
  wait 1

#endif

#define __sendRS485Bool(_bval, _status) \
  acquire __CHSWMutex \
  arrbuild __CHSWArgs.Buffer, _bval, 0 \
  syscall CommHSWrite, __CHSWArgs \
  mov _status, __CHSWArgs.Status \
  release __CHSWMutex

#define __sendRS485Number(_val, _status) \
  acquire __CHSWMutex \
  mov __SHSTmpVal, _val \
  flatten __CHSWArgs.Buffer, __SHSTmpVal \
  syscall CommHSWrite, __CHSWArgs \
  mov _status, __CHSWArgs.Status \
  release __CHSWMutex

#define __sendRS485String(_str, _status) __RS485Write(_str, _status)

#endif

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

dseg segment
// ReadLastResponse
TReadLastResponse struct
 Result  sbyte
 Clear   byte
 Length  byte
 Command byte
 Buffer	 byte[]
TReadLastResponse ends

  __ReadLastArgs TReadLastResponse
  __ReadLastMutex mutex
dseg ends

#define __GetLastResponseInfo(_Clear,_Length,_Command,_Buffer,_Result) \
  acquire __ReadLastMutex \
  mov __ReadLastArgs.Clear,_Clear \
  syscall ReadLastResponse,__ReadLastArgs \
  mov _Buffer, __ReadLastArgs.Buffer \
  mov _Length, __ReadLastArgs.Length \
  mov _Command, __ReadLastArgs.Command \
  mov _Result, __ReadLastArgs.Result \
  release __ReadLastMutex


#endif

#ifdef __ENHANCED_FIRMWARE

#define __connectionSCDCWrite(_conn, _buffer, _result) \
  brcmp LT, __ConnWrite_Else##__I__, _conn, 4 \
  __RS485WriteSCDC(_conn, _buffer, _result) \
  jmp __ConnWrite_EndIf##__I__ \
  __ConnWrite_Else##__I__: \
  __bluetoothWrite(_conn, _buffer, _result) \
  __ConnWrite_EndIf##__I__: \
  __IncI__

#define __connectionRawWrite(_conn, _buffer, _result) \
  brcmp LT, __ConnWrite_Else##__I__, _conn, 4 \
  __RS485Write(_buffer, _result) \
  jmp __ConnWrite_EndIf##__I__ \
  __ConnWrite_Else##__I__: \
  __bluetoothWrite(_conn, _buffer, _result) \
  __ConnWrite_EndIf##__I__: \
  __IncI__

#define __remoteConnectionIdle(_conn, _result) \
  brcmp NEQ, __ConnIdle_Else##__I__, _conn, 4 \
  __RS485Status(_result, __SHSTmpVal) \
  jmp __ConnIdle_EndIf##__I__ \
  __ConnIdle_Else##__I__: \
  __bluetoothStatus(_conn, _result) \
  __ConnIdle_EndIf##__I__: \
  tst EQ, _result, _result \
  __IncI__


subroutine __DoWaitForRemoteResponse
  set __WFRR_I, 0
  __wFRR_Repeat:
  __GetLastResponseInfo(FALSE, __WFRRAvail, __WFRRCmd, __WFRRBuffer, __WFRRStatus)
  wait 2
  add __WFRR_I, __WFRR_I, 1
  // if it rolls back around to 0 then break out of loop
  brtst EQ, __wFRR_Break, __WFRR_I
  brtst EQ, __wFRR_Repeat, __WFRRAvail
  // > 0 bytes in last response so read it one more time and clear it
  __GetLastResponseInfo(TRUE, __WFRRAvail, __WFRRCmd, __WFRRBuffer, __WFRRStatus)
  jmp __wFRR_End
  __wFRR_Break:
  set __WFRRStatus, TRUE // timeout error occurred
  __wFRR_End:
  return
ends

#else

#define __connectionSCDCWrite(_conn, _buffer, _result) __bluetoothWrite(_conn, _buffer, _result)
#define __connectionRawWrite(_conn, _buffer, _result) __bluetoothWrite(_conn, _buffer, _result)

#define __remoteConnectionIdle(_conn, _result) \
  __bluetoothStatus(_conn, _result) \
  tst EQ, _result, _result

#endif

#define __sendRemoteBool(_conn, _queue, _bval, _result) \
  acquire __RemoteMutex \
  mov __SRSTmpBuf, __DCMessageWritePacket \
  replace __SRSTmpBuf, __SRSTmpBuf, 2, _queue \
  replace __SRSTmpBuf, __SRSTmpBuf, 3, 2 \
  arrbuild __SRSSendBuf, __SRSTmpBuf, _bval, 0 \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __sendRemoteNumber(_conn, _queue, _val, _result) \
  acquire __RemoteMutex \
  mov __SRSTmpBuf, __DCMessageWritePacket \
  replace __SRSTmpBuf, __SRSTmpBuf, 2, _queue \
  replace __SRSTmpBuf, __SRSTmpBuf, 3, 5 \
  mov __SRSTmpLongVal, _val \
  flatten __SRSFlattenBuf, __SRSTmpLongVal \
  arrbuild __SRSSendBuf, __SRSTmpBuf, __SRSFlattenBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __sendRemoteString(_conn, _queue, _str, _result) \
  acquire __RemoteMutex \
  mov __SRSTmpBuf, __DCMessageWritePacket \
  replace __SRSTmpBuf, __SRSTmpBuf, 2, _queue \
  arrsize __SRSTmpLongVal, _str \
  replace __SRSTmpBuf, __SRSTmpBuf, 3, __SRSTmpLongVal \
  arrbuild __SRSSendBuf, __SRSTmpBuf, _str \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteMessageRead(_conn, _queue, _result) \
  acquire __RemoteMutex \
  add __SRSTmpLongVal, _queue, 10 \
  arrbuild __SRSSendBuf, __DCMessageReadPacket, __SRSTmpLongVal, _queue, 0x01 \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteResetScaledValue(_conn, _port, _result) \
  acquire __RemoteMutex \
  arrbuild __SRSSendBuf, __DCResetScaledValuePacket, _port \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteResetMotorPosition(_conn, _port, _brelative, _result) \
  acquire __RemoteMutex \
  arrbuild __SRSSendBuf, __DCResetMotorPosPacket, _port, _brelative \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteSetInputMode(_conn, _port, _type, _mode, _result) \
  acquire __RemoteMutex \
  arrbuild __SRSSendBuf, __DCSetInputModePacket, _port, _type, _mode \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteSetOutputState(_conn, _port, _speed, _mode, _regmode, _turnpct, _runstate, _tacholimit, _result) \
  acquire __RemoteMutex \
  mov __SRSTmpLongVal, _tacholimit \
  flatten __SRSFlattenBuf, __SRSTmpLongVal \
  arrbuild __SRSTmpBuf, __DCSetOutputStatePacket, _port, _speed, _mode, _regmode, _turnpct, _runstate, __SRSFlattenBuf \
  strtoarr __SRSSendBuf, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remotePlaySoundFile(_conn, _filename, _bloop, _result) \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __DCPlaySoundFilePacket \
  strsubset __SRSTmpBuf, _filename, NA, 19 \
  replace __SRSSendBuf, __SRSSendBuf, 2, _bloop \
  replace __SRSSendBuf, __SRSSendBuf, 3, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remotePlayTone(_conn, _frequency, _duration, _result) \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __DCPlayTonePacket \
  and __SRSTmpLongVal, _frequency, 0xff \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpLongVal \
  div __SRSTmpLongVal, _frequency, 0xff \
  replace __SRSSendBuf, __SRSSendBuf, 3, __SRSTmpLongVal \
  and __SRSTmpLongVal, _duration, 0xff \
  replace __SRSSendBuf, __SRSSendBuf, 4, __SRSTmpLongVal \
  div __SRSTmpLongVal, _duration, 0xff \
  replace __SRSSendBuf, __SRSSendBuf, 5, __SRSTmpLongVal \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteGenericFilenameCommand(_conn, _cmdBuf, _filename, _result) \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __GenericCmdFilenamePacket \
  strsubset __SRSTmpBuf, _filename, NA, 19 \
  replace __SRSSendBuf, __SRSSendBuf, NA, _cmdBuf \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteStartProgram(_conn, _filename, _result) __remoteGenericFilenameCommand(_conn, __DCStartProgramPacket, _filename, _result)

#define __remoteGenericCreateFileCommand(_conn, _cmdBuf, _filename, _size, _result) \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __GenericCreateFilePacket \
  strsubset __SRSTmpBuf, _filename, NA, 19 \
  replace __SRSSendBuf, __SRSSendBuf, NA, _cmdBuf \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpBuf \
  mov __SRSTmpLongVal, _size \
  flatten __SRSFlattenBuf, __SRSTmpLongVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 22, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteGenericByteCommand(_conn, _cmdBuf, _val, _result) \
  compchk EQ, sizeof(_val), 1 \
  acquire __RemoteMutex \
  arrbuild __SRSSendBuf, _cmdBuf, _val \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteResetTachoCount(_conn, _port, _result) __remoteGenericByteCommand(_conn, __DCUpdateResetCountPacket, _port, _result)

#define __remoteDoWrite(_conn, _handle, _data, _result) \
  compchk EQ, sizeof(_handle), 1 \
  acquire __RemoteMutex \
  arrbuild __SRSSendBuf, __SCWritePacket, _handle, _data \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteDoRead(_conn, _handle, _numbytes, _result) \
  compchk EQ, sizeof(_handle), 1 \
  acquire __RemoteMutex \
  mov __SRSTmpWordVal, _numbytes \
  flatten __SRSFlattenBuf, __SRSTmpWordVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  arrbuild __SRSSendBuf, __SCReadPacket, _handle, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteDoPollCommand(_conn, _bufnum, _len, _result) \
  compchk EQ, sizeof(_bufnum), 1 \
  compchk EQ, sizeof(_len), 1 \
  acquire __RemoteMutex \
  arrbuild __SRSSendBuf, __SCPollCommandPacket, _bufnum, _len \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteDoIOMapRead(_conn, _id, _offset, _numbytes, _result) \
  compchk EQ, sizeof(_handle), 1 \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __GenericIOMapPacket \
  replace __SRSSendBuf, __SRSSendBuf, NA, __SCIOMapReadPacket \
  mov __SRSTmpLongVal, _offset \
  flatten __SRSFlattenBuf, __SRSTmpLongVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpBuf \
  mov __SRSTmpWordVal, _offset \
  flatten __SRSFlattenBuf, __SRSTmpWordVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 6, __SRSTmpBuf \
  mov __SRSTmpWordVal, _numbytes \
  flatten __SRSFlattenBuf, __SRSTmpWordVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 8, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex


#ifdef __ENHANCED_FIRMWARE

#define __remoteGetOutputState(_conn, _params, _result) \
  __remoteGenericByteCommand(_conn, __DCGetOutputStatePacket, _params.Port, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGOSR_End##__I__, _result \
  brcmp NEQ, __RRGOSR_End##__I__, __WFRRAvail, 23 \
  unflatten _params, __WFRRUnflattenErr, __WFRRBuffer, _params \
  __RRGOSR_End##__I__: \
  __IncI__

#define __remoteGetInputValues(_conn, _params, _result) \
  __remoteGenericByteCommand(_conn, __DCGetInputValuesPacket, _params.Port, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGIVR_End##__I__, _result \
  brcmp NEQ, __RRGIVR_End##__I__, __WFRRAvail, 14 \
  unflatten _params, __WFRRUnflattenErr, __WFRRBuffer, _params \
  __RRGIVR_End##__I__: \
  __IncI__

#define __remoteGetBatteryLevel(_conn, _value, _result) \
  compchk EQ, sizeof(_value), 2 \
  __connectionSCDCWrite(_conn, __DCGetBatteryLevelPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGBL_End##__I__, _result \
  brcmp NEQ, __RRGBL_End##__I__, __WFRRAvail, 3 \
  unflatten _value, __WFRRUnflattenErr, __WFRRBuffer, _value \
  __RRGBL_End##__I__: \
  __IncI__

#define __remoteLowspeedGetStatus(_conn, _value, _result) \
  __connectionSCDCWrite(_conn, __DCLSGetStatusPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRLGS_End##__I__, _result \
  brcmp NEQ, __RRLGS_End##__I__, __WFRRAvail, 2 \
  index _value, __WFRRBuffer, NA \
  __RRLGS_End##__I__: \
  __IncI__

#define __remoteLowspeedRead(_conn, _port, _bread, _data, _result) \
  __remoteGenericByteCommand(_conn, __DCLSReadPacket, _port, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRLR_End##__I__, _result \
  brcmp NEQ, __RRLR_End##__I__, __WFRRAvail, 18 \
  index _bread, __WFRRBuffer, NA \
  arrsubset _data, __WFRRBuffer, 1, _bread \
  __RRLR_End##__I__: \
  __IncI__

#define __remoteGetCurrentProgramName(_conn, _name, _result) \
  __connectionSCDCWrite(_conn, __DCGetCurProgNamePacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGCPN_End##__I__, _result \
  brcmp NEQ, __RRGCPN_End##__I__, __WFRRAvail, 21 \
  mov _name, __WFRRBuffer \
  __RRGCPN_End##__I__: \
  __IncI__

#define __remoteDatalogRead(_conn, _remove, _cnt, _log, _result) \
  __remoteGenericByteCommand(_conn, __DCDatalogReadPacket, _remove, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRDR_End##__I__, _result \
  brcmp NEQ, __RRDR_End##__I__, __WFRRAvail, 62 \
  index _cnt, __WFRRBuffer, NA \
  arrsubset _log, __WFRRBuffer, 1, _cnt \
  __RRDR_End##__I__: \
  __IncI__

#define __remoteGetContactCount(_conn, _cnt, _result) \
  __connectionSCDCWrite(_conn, __DCBTGetContactCntPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGCTC_End##__I__, _result \
  brcmp NEQ, __RRGCTC_End##__I__, __WFRRAvail, 2 \
  index _cnt, __WFRRBuffer, NA \
  __RRGCTC_End##__I__: \
  __IncI__

#define __remoteGetContactName(_conn, _idx, _name, _result) \
  __remoteGenericByteCommand(_conn, __DCBTGetContactNamePacket, _idx, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGCTN_End##__I__, _result \
  brcmp NEQ, __RRGCTN_End##__I__, __WFRRAvail, 19 \
  mov _name, __WFRRBuffer \
  __RRGCTN_End##__I__: \
  __IncI__

#define __remoteGetConnectionCount(_conn, _cnt, _result) \
  __connectionSCDCWrite(_conn, __DCBTGetConnectCntPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGCNC_End##__I__, _result \
  brcmp NEQ, __RRGCNC_End##__I__, __WFRRAvail, 2 \
  index _cnt, __WFRRBuffer, NA \
  __RRGCNC_End##__I__: \
  __IncI__

#define __remoteGetConnectionName(_conn, _idx, _name, _result) \
  __remoteGenericByteCommand(_conn, __DCBTGetConnectNamePacket, _idx, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGCNN_End##__I__, _result \
  brcmp NEQ, __RRGCNN_End##__I__, __WFRRAvail, 19 \
  mov _name, __WFRRBuffer \
  __RRGCNN_End##__I__: \
  __IncI__

#define __remoteGetProperty(_conn, _property, _value, _result) \
  mov _value, 0 \
  __remoteGenericByteCommand(_conn, __DCGetPropertyPacket, _property, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGP_End##__I__, _result \
  unflatten _value, __WFRRUnflattenErr, __WFRRBuffer, _value \
  __RRGP_End##__I__: \
  __IncI__

#define __remoteOpenRead(_conn, _filename, _handle, _size, _result) \
  __remoteGenericFilenameCommand(_conn, __SCOpenReadPacket, _filename, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RROR_End##__I__, _result \
  brcmp NEQ, __RROR_End##__I__, __WFRRAvail, 6 \
  index _handle, __WFRRBuffer, NA \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 1, 5 \
  unflatten __WFRRTmpSDWord, __WFRRUnflattenErr, __WFRRTmpBuffer, __WFRRTmpSDWord \
  mov _size, __WFRRTmpSDWord \
  __RROR_End##__I__: \
  __IncI__

#define __remoteOpenWrite(_conn, _filename, _size, _handle, _result) \
  __remoteGenericCreateFileCommand(_conn, __SCOpenWritePacket, _filename, _size, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RROW_End##__I__, _result \
  brcmp NEQ, __RROW_End##__I__, __WFRRAvail, 2 \
  index _handle, __WFRRBuffer, NA \
  __RROW_End##__I__: \
  __IncI__

#define __remoteRead(_conn, _handle, _numbytes, _data, _result) \
  mov _result, 1 \
  brcmp GT, __RRRead_End##__J__, _numbytes, 58 \
  __remoteDoRead(_conn, _handle, _numbytes, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  add __WFRRTmpByte, _numbytes, 4 \
  brtst NEQ, __RRRead_End##__J__, _result \
  brcmp NEQ, __RRRead_End##__J__, __WFRRAvail, __WFRRTmpByte \
  index _handle, __WFRRBuffer, NA \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 1, 2 \
  arrtostr __WFRRUnflattenBuf, __WFRRTmpBuffer \
  unflatten __WFRRTmpSWord, __WFRRUnflattenErr, __WFRRUnflattenBuf, __WFRRTmpSWord \
  mov _numbytes, __WFRRTmpSWord \
  arrsubset _data, __WFRRBuffer, 2, _numbytes \
  __RRRead_End##__J__: \
  __IncJ__

#define __remoteWrite(_conn, _handle, _numbytes, _data, _result) \
  mov _result, 1 \
  brcmp GT, __RRWrite_End##__J__, _numbytes, 58 \
  __remoteDoWrite(_conn, _handle, _data, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRWrite_End##__J__, _result \
  brcmp NEQ, __RRWrite_End##__J__, __WFRRAvail, 4 \
  index _handle, __WFRRBuffer, NA \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 1, 3 \
  unflatten __WFRRTmpSWord, __WFRRUnflattenErr, __WFRRTmpBuffer, __WFRRTmpSWord \
  mov _numbytes, __WFRRTmpSWord \
  __RRWrite_End##__J__: \
  __IncJ__

#define __remoteCloseFile(_conn, _handle, _result) \
  __remoteGenericByteCommand(_conn, __SCClosePacket, _handle, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus

#define __remoteDeleteFile(_conn, _filename, _result) \
  __remoteGenericFilenameCommand(_conn, __SCDeletePacket, _filename, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus

#define __remoteDeleteUserFlash(_conn, _result) \
  __connectionSCDCWrite(_conn, __SCDeleteUserFlashPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus

#define __remoteFindFirstFile(_conn, _mask, _handle, _name, _size, _result) \
  __remoteGenericFilenameCommand(_conn, __SCFindFirstPacket, _mask, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRFindFirstFile_End##__I__, _result \
  brcmp NEQ, __RRFindFirstFile_End##__I__, __WFRRAvail, 26 \
  index _handle, __WFRRBuffer, NA \
  arrsubset _name, __WFRRBuffer, 1, 20 \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 21, 5 \
  unflatten __WFRRTmpSDWord, __WFRRUnflattenErr, __WFRRTmpBuffer, __WFRRTmpSDWord \
  mov _size, __WFRRTmpSDWord \
  __RRFindFirstFile_End##__I__: \
  __IncI__

#define __remoteFindNextFile(_conn, _handle, _name, _size, _result) \
  __remoteGenericByteCommand(_conn, __SCFindNextPacket, _handle, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRFindNextFile_End##__I__, _result \
  brcmp NEQ, __RRFindNextFile_End##__I__, __WFRRAvail, 26 \
  index _handle, __WFRRBuffer, NA \
  arrsubset _name, __WFRRBuffer, 1, 20 \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 21, 5 \
  unflatten __WFRRTmpSDWord, __WFRRUnflattenErr, __WFRRTmpBuffer, __WFRRTmpSDWord \
  mov _size, __WFRRTmpSDWord \
  __RRFindNextFile_End##__I__: \
  __IncI__

#define __remoteGetFirmwareVersion(_conn, _pmin, _pmaj, _fmin, _fmaj, _result) \
  __connectionSCDCWrite(_conn, __SCGetFirmwareVerPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGetFirmwareVersion_End##__I__, _result \
  brcmp NEQ, __RRGetFirmwareVersion_End##__I__, __WFRRAvail, 5 \
  index _pmin, __WFRRBuffer, NA \
  index _pmaj, __WFRRBuffer, 1 \
  index _fmin, __WFRRBuffer, 2 \
  index _fmaj, __WFRRBuffer, 3 \
  __RRGetFirmwareVersion_End##__I__: \
  __IncI__

#define __remoteOpenWriteLinear(_conn, _filename, _size, _handle, _result) \
  __remoteGenericCreateFileCommand(_conn, __SCOpenWriteLinearPacket, _filename, _size, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RROWL_End##__I__, _result \
  brcmp NEQ, __RROWL_End##__I__, __WFRRAvail, 2 \
  index _handle, __WFRRBuffer, NA \
  __RROWL_End##__I__: \
  __IncI__

#define __remoteOpenWriteData(_conn, _filename, _size, _handle, _result) \
  __remoteGenericCreateFileCommand(_conn, __SCOpenWriteDataPacket, _filename, _size, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RROWD_End##__I__, _result \
  brcmp NEQ, __RROWD_End##__I__, __WFRRAvail, 2 \
  index _handle, __WFRRBuffer, NA \
  __RROWD_End##__I__: \
  __IncI__

#define __remoteOpenAppendData(_conn, _filename, _handle, _size, _result) \
  __remoteGenericFilenameCommand(_conn, __SCOpenAppendDataPacket, _filename, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RROAD_End##__I__, _result \
  brcmp NEQ, __RROAD_End##__I__, __WFRRAvail, 6 \
  index _handle, __WFRRBuffer, NA \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 1, 5 \
  unflatten __WFRRTmpSDWord, __WFRRUnflattenErr, __WFRRTmpBuffer, __WFRRTmpSDWord \
  mov _size, __WFRRTmpSDWord \
  __RROAD_End##__I__: \
  __IncI__

#define __remoteGetDeviceInfo(_conn, _name, _btaddr, _btsignal, _freemem, _result) \
  __connectionSCDCWrite(_conn, __SCGetDeviceInfoPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGetDeviceInfo_End##__I__, _result \
  brcmp NEQ, __RRGetDeviceInfo_End##__I__, __WFRRAvail, 31 \
  arrsubset _name, __WFRRBuffer, NA, 15 \
  arrsubset _btaddr, __WFRRBuffer, 15, 7 \
  arrsubset _btsignal, __WFRRBuffer, 22, 4 \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 26, 5 \
  unflatten __WFRRTmpSDWord, __WFRRUnflattenErr, __WFRRTmpBuffer, __WFRRTmpSDWord \
  mov _freemem, __WFRRTmpSDWord \
  __RRGetDeviceInfo_End##__I__: \
  __IncI__

#define __remotePollCommandLength(_conn, _bufnum, _length, _result) \
  __remoteGenericByteCommand(_conn, __SCPollCommandLenPacket, _bufnum, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRPollCommandLength_End##__I__, _result \
  brcmp NEQ, __RRPollCommandLength_End##__I__, __WFRRAvail, 3 \
  index _length, __WFRRBuffer, 1 \
  __RRPollCommandLength_End##__I__: \
  __IncI__

#define __remotePollCommand(_conn, _bufnum, _len, _data, _result) \
  mov _result, 1 \
  brcmp GT, __RRPollCommand_End##__J__, _len, 58 \
  __remoteDoPollCommand(_conn, _bufnum, _len, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  add __WFRRTmpByte, _len, 3 \
  brtst NEQ, __RRPollCommand_End##__J__, _result \
  brcmp NEQ, __RRPollCommand_End##__J__, __WFRRAvail, __WFRRTmpByte \
  index _len, __WFRRBuffer, 1 \
  arrsubset _data, __WFRRBuffer, 2, _len \
  __RRPollCommand_End##__J__: \
  __IncJ__

#define __remoteIOMapRead(_conn, _id, _offset, _numbytes, _data, _result) \
  mov _result, 1 \
  brcmp GT, __RRIOMapRead_End##__J__, _numbytes, 58 \
  __remoteDoIOMapRead(_conn, _id, _offset, _numbytes, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  add __WFRRTmpByte, _numbytes, 7 \
  brtst NEQ, __RRIOMapRead_End##__J__, _result \
  brcmp NEQ, __RRIOMapRead_End##__J__, __WFRRAvail, __WFRRTmpByte \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 4, 2 \
  arrtostr __WFRRUnflattenBuf, __WFRRTmpBuffer \
  unflatten __WFRRTmpSWord, __WFRRUnflattenErr, __WFRRUnflattenBuf, __WFRRTmpSWord \
  mov _numbytes, __WFRRTmpSWord \
  arrsubset _data, __WFRRBuffer, 6, _numbytes \
  __RRIOMapRead_End##__J__: \
  __IncJ__

#define __remoteGetBluetoothAddress(_conn, _btaddr, _result) \
  __connectionSCDCWrite(_conn, __SCBTGetAddressPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGetBluetoothAddress_End##__I__, _result \
  brcmp NEQ, __RRGetBluetoothAddress_End##__I__, __WFRRAvail, 8 \
  arrsubset _btaddr, __WFRRBuffer, NA, 7 \
  __RRGetBluetoothAddress_End##__I__: \
  __IncI__

#define __remoteRenameFile(_conn, _oldname, _newname, _result) \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __SCRenameFilePacket \
  strsubset __SRSTmpBuf, _oldname, NA, 19 \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpBuf \
  strsubset __SRSTmpBuf, _newname, NA, 19 \
  replace __SRSSendBuf, __SRSSendBuf, 22, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#else

#define __remoteGetOutputState(_conn, _port, _result) __remoteGenericByteCommand(_conn, __DCGetOutputStatePacket, _port, _result)
#define __remoteGetInputValues(_conn, _port, _result) __remoteGenericByteCommand(_conn, __DCGetInputValuesPacket, _port, _result)
#define __remoteGetBatteryLevel(_conn, _result) __connectionSCDCWrite(_conn, __DCGetBatteryLevelPacket, _result)
#define __remoteLowspeedGetStatus(_conn, _result) __connectionSCDCWrite(_conn, __DCLSGetStatusPacket, _result)
#define __remoteLowspeedRead(_conn, _port, _result) __remoteGenericByteCommand(_conn, __DCLSReadPacket, _port, _result)
#define __remoteGetCurrentProgramName(_conn, _result) __connectionSCDCWrite(_conn, __DCGetCurProgNamePacket, _result)
#define __remoteDatalogRead(_conn, _remove, _result) __remoteGenericByteCommand(_conn, __DCDatalogReadPacket, _remove, _result)
#define __remoteGetContactCount(_conn, _result) __connectionSCDCWrite(_conn, __DCBTGetContactCntPacket, _result)
#define __remoteGetContactName(_conn, _idx, _result) __remoteGenericByteCommand(_conn, __DCBTGetContactNamePacket, _idx, _result)
#define __remoteGetConnectionCount(_conn, _result) __connectionSCDCWrite(_conn, __DCBTGetConnectCntPacket, _result)
#define __remoteGetConnectionName(_conn, _idx, _result) __remoteGenericByteCommand(_conn, __DCBTGetConnectNamePacket, _idx, _result)
#define __remoteGetProperty(_conn, _property, _result) __remoteGenericByteCommand(_conn, __DCGetPropertyPacket, _property, _result)


#define __remoteOpenRead(_conn, _filename, _result) __remoteGenericFilenameCommand(_conn, __SCOpenReadPacket, _filename, _result)
#define __remoteOpenWrite(_conn, _filename, _size, _result) __remoteGenericCreateFileCommand(_conn, __SCOpenWritePacket, _filename, _size, _result)
#define __remoteRead(_conn, _handle, _numbytes, _result) __remoteDoRead(_conn, _handle, _numbytes, _result)
#define __remoteWrite(_conn, _handle, _data, _result) __remoteDoWrite(_conn, _handle, _data, _result)
#define __remoteCloseFile(_conn, _handle, _result) __remoteGenericByteCommand(_conn, __SCClosePacket, _handle, _result)
#define __remoteDeleteFile(_conn, _filename, _result) __remoteGenericFilenameCommand(_conn, __SCDeletePacket, _filename, _result)
#define __remoteFindFirstFile(_conn, _mask, _result) __remoteGenericFilenameCommand(_conn, __SCFindFirstPacket, _mask, _result)
#define __remoteFindNextFile(_conn, _handle, _result) __remoteGenericByteCommand(_conn, __SCFindNextPacket, _handle, _result)
#define __remoteOpenWriteLinear(_conn, _filename, _size, _result) __remoteGenericCreateFileCommand(_conn, __SCOpenWriteLinearPacket, _filename, _size, _result)
#define __remoteOpenWriteData(_conn, _filename, _size, _result) __remoteGenericCreateFileCommand(_conn, __SCOpenWriteDataPacket, _filename, _size, _result)
#define __remoteOpenAppendData(_conn, _filename, _result) __remoteGenericFilenameCommand(_conn, __SCOpenAppendDataPacket, _filename, _result)
#define __remotePollCommandLength(_conn, _bufnum, _result) __remoteGenericByteCommand(_conn, __SCPollCommandLenPacket, _bufnum, _result)
#define __remotePollCommand(_conn, _bufnum, _len, _result) __remoteDoPollCommand(_conn, _bufnum, _len, _result)
#define __remoteIOMapRead(_conn, _id, _offset, _numbytes, _result) __remoteDoIOMapRead(_conn, _id, _offset, _numbytes, _result)

#endif

#define __remoteDatalogSetTimes(_conn, _synctime, _result) \
  acquire __RemoteMutex \
  mov __SRSTmpLongVal, _synctime \
  flatten __SRSFlattenBuf, __SRSTmpLongVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  arrbuild __SRSSendBuf, __DCDatalogSetTimesPacket, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteSetProperty(_conn, _prop, _value, _result) \
  compchk EQ, sizeof(_prop), 1 \
  acquire __RemoteMutex \
  flatten __SRSFlattenBuf, _value \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  arrbuild __SRSSendBuf, __DCSetPropertyPacket, _prop, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteLowspeedWrite(_conn, _port, _txlen, _rxlen, _data, _result) \
  compchk EQ, sizeof(_port), 1 \
  compchk EQ, sizeof(_txlen), 1 \
  compchk EQ, sizeof(_rxlen), 1 \
  acquire __RemoteMutex \
  arrbuild __SRSSendBuf, __DCLSWritePacket, _port, _txlen, _rxlen, _data \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteIOMapWriteValue(_conn, _id, _offset, _value, _result) \
  compchk EQ, sizeof(_handle), 1 \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __GenericIOMapPacket \
  replace __SRSSendBuf, __SRSSendBuf, NA, __SCIOMapWritePacket \
  mov __SRSTmpLongVal, _offset \
  flatten __SRSFlattenBuf, __SRSTmpLongVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpBuf \
  mov __SRSTmpWordVal, _offset \
  flatten __SRSFlattenBuf, __SRSTmpWordVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 6, __SRSTmpBuf \
  set __SRSTmpWordVal, sizeof(_value) \
  flatten __SRSFlattenBuf, __SRSTmpWordVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 8, __SRSTmpBuf \
  flatten __SRSFlattenBuf, _value \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  mov __SRSFlattenBuf, __SRSSendBuf \
  arrbuild __SRSSendBuf, __SRSFlattenBuf, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteIOMapWriteBytes(_conn, _id, _offset, _data, _result) \
  compchk EQ, sizeof(_handle), 1 \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __GenericIOMapPacket \
  replace __SRSSendBuf, __SRSSendBuf, NA, __SCIOMapWritePacket \
  mov __SRSTmpLongVal, _offset \
  flatten __SRSFlattenBuf, __SRSTmpLongVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpBuf \
  mov __SRSTmpWordVal, _offset \
  flatten __SRSFlattenBuf, __SRSTmpWordVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 6, __SRSTmpBuf \
  arrsize __SRSTmpWordVal, _data \
  flatten __SRSFlattenBuf, __SRSTmpWordVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 8, __SRSTmpBuf \
  mov __SRSFlattenBuf, __SRSSendBuf \
  arrbuild __SRSSendBuf, __SRSFlattenBuf, _data \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteSetBrickName(_conn, _name, _result) \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __SCSetBrickNamePacket \
  strsubset __SRSTmpBuf, _name, NA, 15 \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

dseg segment
  __commModuleOffsetMutex mutex
  __commModuleOffset word
dseg ends

#define __GetBTDeviceName(_p, _str) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getCommModuleBytes(CommOffsetBtDeviceTableName(_p), 16, _str) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 8 \
  __getCommModuleBytes(__commModuleOffset, 16, _str) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTDeviceClass(_p, _n) \
  compchk EQ, sizeof(_n), 4 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getCommModuleValue(CommOffsetBtDeviceTableClassOfDevice(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 24 \
  __getCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __getBTDeviceAddress(_p, _btaddr) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getCommModuleBytes(CommOffsetBtDeviceTableBdAddr(_p), 7, _btaddr) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 28 \
  __getCommModuleBytes(__commModuleOffset, 7, _btaddr) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTDeviceStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getCommModuleValue(CommOffsetBtDeviceTableDeviceStatus(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 35 \
  __getCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTConnectionName(_p, _str) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getCommModuleBytes(CommOffsetBtConnectTableName(_p), 16, _str) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 938 \
  __getCommModuleBytes(__commModuleOffset, 16, _str) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTConnectionClass(_p, _n) \
  compchk EQ, sizeof(_n), 4 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getCommModuleValue(CommOffsetBtConnectTableClassOfDevice(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 954 \
  __getCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTConnectionPinCode(_p, _code) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getCommModuleBytes(CommOffsetBtConnectTablePinCode(_p), 16, _code) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 958 \
  __getCommModuleBytes(__commModuleOffset, 16, _code) \
  release __commModuleOffsetMutex \
  compend

#define __getBTConnectionAddress(_p, _btaddr) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getCommModuleBytes(CommOffsetBtConnectTableBdAddr(_p), 7, _btaddr) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 974 \
  __getCommModuleBytes(__commModuleOffset, 7, _btaddr) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTConnectionHandleNum(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getCommModuleValue(CommOffsetBtConnectTableHandleNr(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 981 \
  __getCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTConnectionStreamStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getCommModuleValue(CommOffsetBtConnectTableStreamStatus(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 982 \
  __getCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTConnectionLinkQuality(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getCommModuleValue(CommOffsetBtConnectTableLinkQuality(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 983 \
  __getCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __getBTInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  __getCommModuleBytes(CommOffsetBtInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetBtInBufBuf \
  __getCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __getBTOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  __getCommModuleBytes(CommOffsetBtOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetBtOutBufBuf \
  __getCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __getHSInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  __getCommModuleBytes(CommOffsetHsInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetHsInBufBuf \
  __getCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __getHSOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  __getCommModuleBytes(CommOffsetHsOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetHsOutBufBuf \
  __getCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __getUSBInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  __getCommModuleBytes(CommOffsetUsbInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbInBufBuf \
  __getCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __getUSBOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  __getCommModuleBytes(CommOffsetUsbOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbOutBufBuf \
  __getCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __getUSBPollBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  __getCommModuleBytes(CommOffsetUsbPollBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbPollBufBuf \
  __getCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __setBTDeviceName(_p, _str) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleBytes(CommOffsetBtDeviceTableName(_p), 16, _str) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 8 \
  SetCommModuleBytes(__commModuleOffset, 16, _str) \
  release __commModuleOffsetMutex \
  compend

#define __setBTDeviceAddress(_p, _btaddr) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleBytes(CommOffsetBtDeviceTableBdAddr(_p), 7, _btaddr) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 28 \
  SetCommModuleBytes(__commModuleOffset, 7, _btaddr) \
  release __commModuleOffsetMutex \
  compend

#define __setBTConnectionName(_p, _str) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleBytes(CommOffsetBtConnectTableName(_p), 16, _str) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 938 \
  SetCommModuleBytes(__commModuleOffset, 16, _str) \
  release __commModuleOffsetMutex \
  compend

#define __setBTConnectionPinCode(_p, _code) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleBytes(CommOffsetBtConnectTablePinCode(_p), 16, _code) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 958 \
  SetCommModuleBytes(__commModuleOffset, 16, _code) \
  release __commModuleOffsetMutex \
  compend

#define __setBTConnectionAddress(_p, _btaddr) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleBytes(CommOffsetBtConnectTableBdAddr(_p), 7, _btaddr) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 974 \
  SetCommModuleBytes(__commModuleOffset, 7, _btaddr) \
  release __commModuleOffsetMutex \
  compend

#define __setBTInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetBtInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetBtInBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __setBTOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetBtOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetBtOutBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __setHSInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetHsInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetHsInBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __setHSOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetHsOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetHsOutBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __setUSBInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetUsbInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbInBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __setUSBOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetUsbOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbOutBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __setUSBPollBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetUsbPollBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbPollBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

// these functions really cannot be used for any useful purpose (read-only)
#define SetBTDeviceName(_p, _str) __setBTDeviceName(_p, _str)
#define SetBTDeviceAddress(_p, _btaddr) __setBTDeviceAddress(_p, _btaddr)
#define SetBTConnectionName(_p, _str) __setBTConnectionName(_p, _str)
#define SetBTConnectionPinCode(_p, _code) __setBTConnectionPinCode(_p, _code)
#define SetBTConnectionAddress(_p, _btaddr) __setBTConnectionAddress(_p, _btaddr)
#define SetBrickDataName(_str) SetCommModuleBytes(CommOffsetBrickDataName, 16, _str)
#define SetBrickDataAddress(_btaddr) SetCommModuleBytes(CommOffsetBrickDataBdAddr, 7, _btaddr)
#define SetBTDeviceClass(_p, _n) __setBTDeviceClass(_p, _n)
#define SetBTDeviceStatus(_p, _n) __setBTDeviceStatus(_p, _n)
#define SetBTConnectionClass(_p, _n) __setBTConnectionClass(_p, _n)
#define SetBTConnectionHandleNum(_p, _n) __setBTConnectionHandleNum(_p, _n)
#define SetBTConnectionStreamStatus(_p, _n) __setBTConnectionStreamStatus(_p, _n)
#define SetBTConnectionLinkQuality(_p, _n) __setBTConnectionLinkQuality(_p, _n)
#define SetBrickDataBluecoreVersion(_n) __setBrickDataBluecoreVersion(_n)
#define SetBrickDataBtStateStatus(_n) __setBrickDataBtStateStatus(_n)
#define SetBrickDataBtHardwareStatus(_n) __setBrickDataBtHardwareStatus(_n)
#define SetBrickDataTimeoutValue(_n) __setBrickDataTimeoutValue(_n)
#define SetBTDeviceCount(_n) __setBTDeviceCount(_n)
#define SetBTDeviceNameCount(_n) __setBTDeviceNameCount(_n)

#endif

/**
 * Send a message to a queue/mailbox.
 * Write a message into a local mailbox.
 *
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _msg The message to write to the mailbox.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define SendMessage(_queue, _msg, _result) __sendMessage(_queue, _msg, _result)

/**
 * Read a message from a queue/mailbox.
 * Read a message from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param _msg The message that is read from the mailbox.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define ReceiveMessage(_queue, _clear, _msg, _result) __receiveMessage(_queue, _clear, _msg, _result)

/**
 * Read a boolean value from a queue/mailbox.
 * Read a boolean value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param _bval The boolean value that is read from the mailbox.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define ReceiveRemoteBool(_queue, _clear, _bval, _result) __receiveRemoteBool(_queue, _clear, _bval, _result)

/**
 * Read a numeric value from a queue/mailbox.
 * Read a numeric value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param _val The numeric value that is read from the mailbox.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define ReceiveRemoteNumber(_queue, _clear, _val, _result) \
  __receiveRemoteNumber(_queue, _clear, _val, _result)

/**
 * Read a string value from a queue/mailbox.
 * Read a string value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param _str The string value that is read from the mailbox.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define ReceiveRemoteString(_queue, _clear, _str, _result) \
  __receiveMessage(_queue, _clear, _str, _result)

/**
 * Read a value from a queue/mailbox.
 * Read a value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.  Output the value in string, number, and
 * boolean form.
 *
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param _str The string value that is read from the mailbox.
 * \param _val The numeric value that is read from the mailbox.
 * \param _bval The boolean value that is read from the mailbox.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define ReceiveRemoteMessageEx(_queue, _clear, _str, _val, _bval, _result) \
  __receiveRemoteMessageEx(_queue, _clear, _str, _val, _bval, _result)

/**
 * Write a string value to a local response mailbox.
 * Write a string value to a response mailbox (the mailbox number + 10).
 *
 * \param _queue The mailbox number. See \ref MailboxConstants. This function
 * shifts the specified value into the range of response mailbox numbers by
 * adding 10.
 * \param _msg The string value to write.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define SendResponseString(_queue, _msg, _result) __sendResponseString(_queue, _msg, _result)

/**
 * Write a boolean value to a local response mailbox.
 * Write a boolean value to a response mailbox (the mailbox number + 10).
 *
 * \param _queue The mailbox number. See \ref MailboxConstants. This function
 * shifts the specified value into the range of response mailbox numbers by
 * adding 10.
 * \param _bval The boolean value to write.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define SendResponseBool(_queue, _bval, _result) __sendResponseBool(_queue, _bval, _result)

/**
 * Write a numeric value to a local response mailbox.
 * Write a numeric value to a response mailbox (the mailbox number + 10).
 *
 * \param _queue The mailbox number. See \ref MailboxConstants. This function
 * shifts the specified value into the range of response mailbox numbers by
 * adding 10.
 * \param _val The numeric value to write.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define SendResponseNumber(_queue, _val, _result) __sendResponseNumber(_queue, _val, _result)

/**
 * Check bluetooth status.
 * Check the status of the bluetooth subsystem for the specified connection slot.
 *
 * \param _conn The connection slot (0..3). Connections 0 through 3 are for
 * bluetooth connections. See \ref CommConnectionConstants.
 * \param _result The bluetooth status for the specified connection.
 */
#define BluetoothStatus(_conn, _result) __bluetoothStatus(_conn, _result)

/**
 * Write to a bluetooth connection.
 * This method tells the NXT firmware to write the data in the buffer to the
 * device on the specified Bluetooth connection. Use \ref BluetoothStatus to
 * determine when this write request is completed.
 *
 * \param _conn The connection slot (0..3). Connections 0 through 3 are for
 * bluetooth connections.  See \ref CommConnectionConstants.
 * \param _buffer The data to be written (up to 128 bytes)
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define BluetoothWrite(_conn, _buffer, _result) __bluetoothWrite(_conn, _buffer, _result)

/**
 * Write to a remote connection.
 * This method tells the NXT firmware to write the data in the buffer to the
 * device on the specified connection. Use \ref RemoteConnectionIdle to determine
 * when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _buffer The data to be written (up to 128 bytes)
 * \param _result A char value indicating whether the function call succeeded or not.
 *
 * \warning Writing to the RS485 hi-speed connection requires the enhanced
 * NBC/NXC firmware 
 */
#define RemoteConnectionWrite(_conn, _buffer, _result) __connectionRawWrite(_conn, _buffer, _result)

/**
 * Check if remote connection is idle.
 * Check whether a Bluetooth or RS485 hi-speed port connection is idle,
 * i.e., not currently sending data.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A boolean value indicating whether the connection is idle or busy.
 *
 * \warning Checking the status of the RS485 hi-speed connection requires the
 * enhanced NBC/NXC firmware
 */
#define RemoteConnectionIdle(_conn, _result) __remoteConnectionIdle(_conn, _result)

/**
 * Send a boolean value to a remote mailbox.
 * Send a boolean value on the specified connection to the
 * specified remote mailbox number.  Use \ref RemoteConnectionIdle to determine
 * when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _bval The boolean value to send.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define SendRemoteBool(_conn, _queue, _bval, _result) __sendRemoteBool(_conn, _queue, _bval, _result)

/**
 * Send a numeric value to a remote mailbox.
 * Send a numeric value on the specified connection to the
 * specified remote mailbox number.  Use \ref RemoteConnectionIdle to determine
 * when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _val The numeric value to send.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define SendRemoteNumber(_conn, _queue, _val, _result) __sendRemoteNumber(_conn, _queue, _val, _result)

/**
 * Send a string value to a remote mailbox.
 * Send a string value on the specified connection to the
 * specified remote mailbox number. Use \ref RemoteConnectionIdle to determine
 * when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _str The string value to send.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define SendRemoteString(_conn, _queue, _str, _result) __sendRemoteString(_conn, _queue, _str, _result)


/** @defgroup CommModuleDCFunctions Direct Command functions
 * Functions for sending direct commands to another NXT.
 * @{
 */

/**
 * Send a MessageRead message.
 * This method sends a MessageRead direct command to the device on the
 * specified connection. Use \ref RemoteConnectionIdle to determine when this write
 * request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _queue The mailbox to read. See \ref MailboxConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteMessageRead(_conn, _queue, _result) __remoteMessageRead(_conn, _queue, _result)

/**
 * Send a MessageWrite message.
 * This method sends a MessageWrite direct command to the device on the
 * specified connection. Use \ref RemoteConnectionIdle to determine when this write
 * request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _queue The mailbox to write. See \ref MailboxConstants.
 * \param _msg The message to write to the mailbox.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteMessageWrite(_conn, _queue, _msg, _result) __sendRemoteString(_conn, _queue, _msg, _result)

/**
 * Send a StartProgram message.
 * Send the StartProgram direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to start running.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteStartProgram(_conn, _filename, _result) __remoteStartProgram(_conn, _filename, _result)

/**
 * Send a StopProgram message.
 * Send the StopProgram direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteStopProgram(_conn, _result) __connectionSCDCWrite(_conn, __DCStopProgramPacket, _result)

/**
 * Send a PlaySoundFile message.
 * Send the PlaySoundFile direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the sound file to play.
 * \param _bloop A boolean value indicating whether to loop the sound file or not.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemotePlaySoundFile(_conn, _filename, _bloop, _result) __remotePlaySoundFile(_conn, _filename, _bloop, _result)

/**
 * Send a PlayTone message.
 * Send the PlayTone direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _frequency The frequency of the tone.
 * \param _duration The duration of the tone.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemotePlayTone(_conn, _frequency, _duration, _result) __remotePlayTone(_conn, _frequency, _duration, _result)

/**
 * Send a StopSound message.
 * Send the StopSound direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteStopSound(_conn, _result) __connectionSCDCWrite(_conn, __DCStopSoundPacket, _result)

/**
 * Send a KeepAlive message.
 * This method sends a KeepAlive direct command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteKeepAlive(_conn, _result) __connectionSCDCWrite(_conn, __DCKeepAlivePacket, _result)

/**
 * Send a ResetScaledValue message.
 * Send the ResetScaledValue direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The input port to reset.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteResetScaledValue(_conn, _port, _result) __remoteResetScaledValue(_conn, _port, _result)

/**
 * Send a ResetMotorPosition message.
 * Send the ResetMotorPosition direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The output port to reset.
 * \param _brelative A flag indicating whether the counter to reset is relative.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteResetMotorPosition(_conn, _port, _brelative, _result) \
  __remoteResetMotorPosition(_conn, _port, _brelative, _result)

/**
 * Send a SetInputMode message.
 * Send the SetInputMode direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The input port to configure. See \ref NBCInputPortConstants.
 * \param _type The sensor type. See \ref NBCSensorTypeConstants.
 * \param _mode The sensor mode. See \ref NBCSensorModeConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteSetInputMode(_conn, _port, _type, _mode, _result) \
  __remoteSetInputMode(_conn, _port, _type, _mode, _result)

/**
 * Send a SetOutputMode message.
 * Send the SetOutputMode direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The output port to configure. See \ref OutputPortConstants.
 * \param _speed The motor speed. (-100..100)
 * \param _mode The motor mode. See \ref OutModeConstants.
 * \param _regmode The motor regulation mode. See \ref OutRegModeConstants.
 * \param _turnpct The motor synchronized turn percentage. (-100..100)
 * \param _runstate The motor run state. See \ref OutRunStateConstants.
 * \param _tacholimit The motor tachometer limit.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteSetOutputState(_conn, _port, _speed, _mode, _regmode, _turnpct, _runstate, _tacholimit, _result) \
  __remoteSetOutputState(_conn, _port, _speed, _mode, _regmode, _turnpct, _runstate, _tacholimit, _result)

#ifdef __ENHANCED_FIRMWARE

/**
 * Send a GetOutputState message.
 * Send the GetOutputState direct command on the specified connection slot.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _params The input and output parameters for the function call.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetOutputState(_conn, _params, _result) \
  compchktype _params, TOutputState \
  __remoteGetOutputState(_conn, _params, _result)

/**
 * Send a GetInputValues message.
 * Send the GetInputValues direct command on the specified connection slot.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _params The input and output parameters for the function call.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetInputValues(_conn, _params, _result) \
  compchktype _params, TInputValues \
__remoteGetInputValues(_conn, _params, _result)

/**
 * Send a GetBatteryLevel message.
 * This method sends a GetBatteryLevel direct command to the device on the specified
 * connection.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _value The battery level value.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetBatteryLevel(_conn, _value, _result) __remoteGetBatteryLevel(_conn, _value, _result)

/**
 * Send a LSGetStatus message.
 * This method sends a LSGetStatus direct command to the device on the specified
 * connection.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _value The count of available bytes to read.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteLowspeedGetStatus(_conn, _value, _result) __remoteLowspeedGetStatus(_conn, _value, _result)

/**
 * Send a LowspeedRead message.
 * Send the LowspeedRead direct command on the specified connection slot.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The input port from which to read I2C data. See \ref NBCInputPortConstants.
 * \param _bread The number of bytes read.
 * \param _data A byte array containing the data read from the I2C device.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteLowspeedRead(_conn, _port, _bread, _data, _result) \
  __remoteLowspeedRead(_conn, _port, _bread, _data, _result)

/**
 * Send a GetCurrentProgramName message.
 * This method sends a GetCurrentProgramName direct command to the device on the specified
 * connection.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _name The current program name.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetCurrentProgramName(_conn, _name, _result) \
  __remoteGetCurrentProgramName(_conn, _name, _result)

/**
 * Send a DatalogRead message.
 * Send the DatalogRead direct command on the specified connection slot.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _remove Remove the datalog message from the queue after reading it (true or false).
 * \param _cnt The number of bytes read from the datalog.
 * \param _log A byte array containing the datalog contents.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteDatalogRead(_conn, _remove, _cnt, _log, _result) \
  __remoteDatalogRead(_conn, _remove, _cnt, _log, _result)

/**
 * Send a GetContactCount message.
 * This method sends a GetContactCount direct command to the device on the specified
 * connection.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _cnt The number of contacts.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetContactCount(_conn, _cnt, _result) \
  __remoteGetContactCount(_conn, _cnt, _result)

/**
 * Send a GetContactName message.
 * Send the GetContactName direct command on the specified connection slot.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _idx The index of the contact.
 * \param _name The name of the specified contact.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetContactName(_conn, _idx, _name, _result) \
  __remoteGetContactName(_conn, _idx, _name, _result)

/**
 * Send a GetConnectionCount message.
 * This method sends a GetConnectionCount direct command to the device on the specified
 * connection.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _cnt The number of connections.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetConnectionCount(_conn, _cnt, _result) \
  __remoteGetConnectionCount(_conn, _cnt, _result)

/**
 * Send a GetConnectionName message.
 * Send the GetConnectionName direct command on the specified connection slot.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _idx The index of the connection.
 * \param _name The name of the specified connection.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetConnectionName(_conn, _idx, _name, _result) \
  __remoteGetConnectionName(_conn, _idx, _name, _result)


#else

/**
 * Send a GetOutputState message.
 * Send the GetOutputState direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The output port from which to read state information. See \ref OutputPortConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetOutputState(_conn, _port, _result) \
  __remoteGetOutputState(_conn, _port, _result)

/**
 * Send a GetInputValues message.
 * Send the GetInputValues direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The input port from which to read sensor values. See \ref NBCInputPortConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetInputValues(_conn, _port, _result) __remoteGetInputValues(_conn, _port, _result)

/**
 * Send a GetBatteryLevel message.
 * This method sends a GetBatteryLevel direct command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetBatteryLevel(_conn, _result) __remoteGetBatteryLevel(_conn, _result)

/**
 * Send a LSGetStatus message.
 * This method sends a LSGetStatus direct command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteLowspeedGetStatus(_conn, _result) __remoteLowspeedGetStatus(_conn, _result)

/**
 * Send a LowspeedRead message.
 * Send the LowspeedRead direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The input port from which to read I2C data. See \ref NBCInputPortConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteLowspeedRead(_conn, _port, _result) __remoteLowspeedRead(_conn, _port, _result)

/**
 * Send a GetCurrentProgramName message.
 * This method sends a GetCurrentProgramName direct command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetCurrentProgramName(_conn, _result) __remoteGetCurrentProgramName(_conn, _result)

/**
 * Send a DatalogRead message.
 * Send the DatalogRead direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _remove Remove the datalog message from the queue after reading it (true or false).
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteDatalogRead(_conn, _remove, _result) __remoteDatalogRead(_conn, _remove, _result)

/**
 * Send a GetContactCount message.
 * This method sends a GetContactCount direct command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetContactCount(_conn, _result) __remoteGetContactCount(_conn, _result)

/**
 * Send a GetContactName message.
 * Send the GetContactName direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _idx The index of the contact.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetContactName(_conn, _idx, _result) __remoteGetContactName(_conn, _idx, _result)

/**
 * Send a GetConnectionCount message.
 * This method sends a GetConnectionCount direct command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write
 * request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetConnectionCount(_conn, _result) __remoteGetConnectionCount(_conn, _result)

/**
 * Send a GetConnectionName message.
 * Send the GetConnectionName direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _idx The index of the connection.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetConnectionName(_conn, _idx, _result) \
  __remoteGetConnectionName(_conn, _idx, _result)


#endif

/**
 * Send a ResetTachoCount message.
 * Send the ResetTachoCount direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The output port to reset the tachometer count on. See \ref OutputPortConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteResetTachoCount(_conn, _port, _result) __remoteResetTachoCount(_conn, _port, _result)

/**
 * Send a GetProperty message.
 * Send the GetProperty direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _property The property to read. See \ref RCPropertyConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetProperty(_conn, _property, _result) \
  __remoteGetProperty(_conn, _property, _result)

/**
 * Send a DatalogSetTimes message.
 * Send the DatalogSetTimes direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _synctime The datalog sync time.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteDatalogSetTimes(_conn, _synctime, _result) \
  __remoteDatalogSetTimes(_conn, _synctime, _result)

/**
 * Send a SetProperty message.
 * Send the SetProperty direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _prop The property to set. See \ref RCPropertyConstants.
 * \param _value The new property value.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteSetProperty(_conn, _prop, _value, _result) \
  __remoteSetProperty(_conn, _prop, _value, _result)

/**
 * Send a LowspeedWrite message.
 * Send the LowspeedWrite direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The I2C port. See \ref NBCInputPortConstants.
 * \param _txlen The number of bytes you are writing to the I2C device.
 * \param _rxlen The number of bytes want to read from the I2C device.
 * \param _data A byte array containing the data you are writing to the device.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteLowspeedWrite(_conn, _port, _txlen, _rxlen, _data, _result) \
  __remoteLowspeedWrite(_conn, _port, _txlen, _rxlen, _data, _result)


/** @} */ // end of CommModuleDCFunctions group

/** @defgroup CommModuleSCFunctions System Command functions
 * Functions for sending system commands to another NXT.
 * @{
 */

#ifdef __ENHANCED_FIRMWARE

/**
 * Send an OpenRead message.
 * Send the OpenRead system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the file to open for reading.
 * \param _handle The handle of the file.
 * \param _size The size of the file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenRead(_conn, _filename, _handle, _size, _result) \
  __remoteOpenRead(_conn, _filename, _handle, _size, _result)

/**
 * Send an OpenAppendData message.
 * Send the OpenAppendData system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the file to open for appending.
 * \param _handle The handle of the file.
 * \param _size The size of the file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenAppendData(_conn, _filename, _handle, _size, _result) \
  __remoteOpenAppendData(_conn, _filename, _handle, _size, _result)

/**
 * Send a DeleteFile message.
 * Send the DeleteFile system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to delete.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteDeleteFile(_conn, _filename, _result) __remoteDeleteFile(_conn, _filename, _result)

/**
 * Send a FindFirstFile message.
 * Send the FindFirstFile system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _mask The filename mask for the files you want to find.
 * \param _handle The handle of the found file.
 * \param _name The name of the found file.
 * \param _size The size of the found file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteFindFirstFile(_conn, _mask, _handle, _name, _size, _result) \
  __remoteFindFirstFile(_conn, _mask, _handle, _name, _size, _result)

/**
 * Send a GetFirmwareVersion message.
 * This method sends a GetFirmwareVersion system command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _pmin The protocol minor version byte.
 * \param _pmaj The protocol major version byte.
 * \param _fmin The firmware minor version byte.
 * \param _fmaj The firmware major version byte.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetFirmwareVersion(_conn, _pmin, _pmaj, _fmin, _fmaj, _result) \
  __remoteGetFirmwareVersion(_conn, _pmin, _pmaj, _fmin, _fmaj, _result)

/**
 * Send a GetBluetoothAddress message.
 * This method sends a GetBluetoothAddress system command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _btaddr The bluetooth address of the remote device.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetBluetoothAddress(_conn, _btaddr, _result) __remoteGetBluetoothAddress(_conn, _btaddr, _result)

/**
 * Send a GetDeviceInfo message.
 * This method sends a GetDeviceInfo system command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _name The name of the remote device.
 * \param _btaddr The bluetooth address of the remote device.
 * \param _btsignal The signal strength of each connection on the remote device.
 * \param _freemem The number of bytes of free flash memory on the remote device.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetDeviceInfo(_conn, _name, _btaddr, _btsignal, _freemem, _result) \
  __remoteGetDeviceInfo(_conn, _name, _btaddr, _btsignal, _freemem, _result)

/**
 * Send a DeleteUserFlash message.
 * This method sends a DeleteUserFlash system command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteDeleteUserFlash(_conn, _result) __remoteDeleteUserFlash(_conn, _result)

/**
 * Send an OpenWrite message.
 * Send the OpenWrite system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for writing (i.e., create the file).
 * \param _size The size for the new file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenWrite(_conn, _filename, _size, _result) \
  __remoteOpenWrite(_conn, _filename, _size, _result)

/**
 * Send an OpenWriteLinear message.
 * Send the OpenWriteLinear system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for writing (i.e., create the file).
 * \param _size The size for the new file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenWriteLinear(_conn, _filename, _size, _result) \
  __remoteOpenWriteLinear(_conn, _filename, _size, _result)

/**
 * Send an OpenWriteData message.
 * Send the OpenWriteData system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for writing (i.e., create the file).
 * \param _size The size for the new file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenWriteData(_conn, _filename, _size, _result) \
  __remoteOpenWriteData(_conn, _filename, _size, _result)

/**
 * Send a CloseFile message.
 * Send the CloseFile system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle of the file to close.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteCloseFile(_conn, _handle, _result) __remoteCloseFile(_conn, _handle, _result)

/**
 * Send a FindNextFile message.
 * Send the FindNextFile system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle returned by the last \ref FindFirstFile or FindNextFile call.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteFindNextFile(_conn, _handle, _result) \
  __remoteFindNextFile(_conn, _handle, _result)

/**
 * Send a PollCommandLength message.
 * Send the PollCommandLength system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _bufnum The poll buffer you want to query (0=USBPoll, 1=HiSpeed).
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemotePollCommandLength(_conn, _bufnum, _result) \
  __remotePollCommandLength(_conn, _bufnum, _result)

/**
 * Send a Write message.
 * Send the Write system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle of the file you are writing to.
 * \param _data A byte array containing the data you are writing.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteWrite(_conn, _handle, _data, _result) \
  __remoteWrite(_conn, _handle, _data, _result)

/**
 * Send a Read message.
 * Send the Read system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle of the file you are reading from.
 * \param _numbytes The number of bytes you want to read.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteRead(_conn, _handle, _numbytes, _result) \
  __remoteRead(_conn, _handle, _numbytes, _result)

/**
 * Send an IOMapRead message.
 * Send the IOMapRead system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _id The ID of the module from which to read data.
 * \param _offset The offset into the IOMap structure from which to read.
 * \param _numbytes The number of bytes of data to read.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteIOMapRead(_conn, _id, _offset, _numbytes, _result) \
  __remoteIOMapRead(_conn, _id, _offset, _numbytes, _result)

/**
 * Send a PollCommand message.
 * Send the PollCommand system command on the specified connection slot to
 * write the data provided.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _bufnum The buffer from which to read data (0=USBPoll, 1=HiSpeed).
 * \param _len The number of bytes to read.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemotePollCommand(_conn, _bufnum, _len, _result) \
  __remotePollCommand(_conn, _bufnum, _len, _result)

/**
 * Send a RenameFile message.
 * Send the RenameFile system command on the specified connection slot to
 * write the data provided.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _oldname The old filename.
 * \param _newname The new filename.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteRenameFile(_conn, _oldname, _newname, _result) \
  __remoteRenameFile(_conn, _oldname, _newname, _result)

#else

/**
 * Send an OpenRead message.
 * Send the OpenRead system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for reading.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenRead(_conn, _filename, _result) __remoteOpenRead(_conn, _filename, _result)

/**
 * Send an OpenAppendData message.
 * Send the OpenAppendData system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for appending.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenAppendData(_conn, _filename, _result) __remoteOpenAppendData(_conn, _filename, _result)

/**
 * Send a DeleteFile message.
 * Send the DeleteFile system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to delete.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteDeleteFile(_conn, _filename, _result) __remoteDeleteFile(_conn, _filename, _result)

/**
 * Send a FindFirstFile message.
 * Send the FindFirstFile system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _mask The filename mask for the files you want to find.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteFindFirstFile(_conn, _mask, _result) __remoteFindFirstFile(_conn, _mask, _result)

/**
 * Send a GetFirmwareVersion message.
 * This method sends a GetFirmwareVersion system command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetFirmwareVersion(_conn, _result) \
  __connectionSCDCWrite(_conn, __SCGetFirmwareVerPacket, _result)

/**
 * Send a GetBluetoothAddress message.
 * This method sends a GetBluetoothAddress system command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetBluetoothAddress(_conn, _result) \
  __connectionSCDCWrite(_conn, __SCBTGetAddressPacket, _result)

/**
 * Send a GetDeviceInfo message.
 * This method sends a GetDeviceInfo system command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetDeviceInfo(_conn, _result) \
  __connectionSCDCWrite(_conn, __SCGetDeviceInfoPacket, _result)

/**
 * Send a DeleteUserFlash message.
 * This method sends a DeleteUserFlash system command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteDeleteUserFlash(_conn, _result) \
  __connectionSCDCWrite(_conn, __SCDeleteUserFlashPacket, _result)

/**
 * Send an OpenWrite message.
 * Send the OpenWrite system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for writing (i.e., create the file).
 * \param _size The size for the new file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenWrite(_conn, _filename, _size, _result) \
  __remoteOpenWrite(_conn, _filename, _size, _result)

/**
 * Send an OpenWriteLinear message.
 * Send the OpenWriteLinear system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for writing (i.e., create the file).
 * \param _size The size for the new file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenWriteLinear(_conn, _filename, _size, _result) \
  __remoteOpenWriteLinear(_conn, _filename, _size, _result)

/**
 * Send an OpenWriteData message.
 * Send the OpenWriteData system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for writing (i.e., create the file).
 * \param _size The size for the new file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenWriteData(_conn, _filename, _size, _result) \
  __remoteOpenWriteData(_conn, _filename, _size, _result)

/**
 * Send a CloseFile message.
 * Send the CloseFile system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle of the file to close.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteCloseFile(_conn, _handle, _result) __remoteCloseFile(_conn, _handle, _result)

/**
 * Send a FindNextFile message.
 * Send the FindNextFile system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle returned by the last \ref FindFirstFile or FindNextFile call.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteFindNextFile(_conn, _handle, _result) __remoteFindNextFile(_conn, _handle, _result)

/**
 * Send a PollCommandLength message.
 * Send the PollCommandLength system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _bufnum The poll buffer you want to query (0=USBPoll, 1=HiSpeed).
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemotePollCommandLength(_conn, _bufnum, _result) __remotePollCommandLength(_conn, _bufnum, _result)

/**
 * Send a Write message.
 * Send the Write system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle of the file you are writing to.
 * \param _data A byte array containing the data you are writing.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteWrite(_conn, _handle, _data, _result) __remoteWrite(_conn, _handle, _data, _result)

/**
 * Send a Read message.
 * Send the Read system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle of the file you are reading from.
 * \param _numbytes The number of bytes you want to read.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteRead(_conn, _handle, _numbytes, _result) __remoteRead(_conn, _handle, _numbytes, _result)

/**
 * Send an IOMapRead message.
 * Send the IOMapRead system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _id The ID of the module from which to read data.
 * \param _offset The offset into the IOMap structure from which to read.
 * \param _numbytes The number of bytes of data to read.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteIOMapRead(_conn, _id, _offset, _numbytes, _result) \
  __remoteIOMapRead(_conn, _id, _offset, _numbytes, _result)

/**
 * Send a PollCommand message.
 * Send the PollCommand system command on the specified connection slot to
 * write the data provided.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _bufnum The buffer from which to read data (0=USBPoll, 1=HiSpeed).
 * \param _len The number of bytes to read.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemotePollCommand(_conn, _bufnum, _len, _result) \
  __remotePollCommand(_conn, _bufnum, _len, _result)

#endif

/**
 * Send a BluetoothFactoryReset message.
 * This method sends a BluetoothFactoryReset system command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteBluetoothFactoryReset(_conn, _result) __connectionSCDCWrite(_conn, __SCBTFactoryResetPacket, _result)

/**
 * Send an IOMapWrite value message.
 * Send the IOMapWrite system command on the specified connection slot to
 * write the value provided.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _id The ID of the module to which to write data.
 * \param _offset The offset into the IOMap structure to which to write.
 * \param _value A scalar variable containing the value you are writing to the IOMap structure.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteIOMapWriteValue(_conn, _id, _offset, _value, _result) \
  __remoteIOMapWriteValue(_conn, _id, _offset, _value, _result)

/**
 * Send an IOMapWrite bytes message.
 * Send the IOMapWrite system command on the specified connection slot to
 * write the data provided.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _id The ID of the module to which to write data.
 * \param _offset The offset into the IOMap structure to which to write.
 * \param _data A byte array containing the data you are writing to the IOMap structure.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteIOMapWriteBytes(_conn, _id, _offset, _data, _result) \
  __remoteIOMapWriteBytes(_conn, _id, _offset, _data, _result)

/**
 * Send a SetBrickName message.
 * Send the SetBrickName system command on the specified connection slot to
 * write the data provided.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _name The new brick name.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteSetBrickName(_conn, _name, _result) \
  __remoteSetBrickName(_conn, _name, _result)

/** @} */ // end of CommModuleSCFunctions group

/**
 * Use the RS485 port.
 * Configure port 4 for RS485 usage.
 *
 */
#define UseRS485() __UseRS485()

#ifdef __ENHANCED_FIRMWARE

/**
 * Check RS485 status.
 * Check the status of the RS485 hi-speed port.
 *
 * \param _sendingData A boolean value set to true on output if data is being sent.
 * \param _dataAvail A boolean value set to true on output if data is available to be read.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define RS485Status(_sendingData, _dataAvail) __RS485Status(_sendingData, _dataAvail)

/**
 * Write RS485 data.
 * Write data to the RS485 hi-speed port.
 *
 * \param _buffer A byte array containing the data to write to the RS485 port.
 * \param _status A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define RS485Write(_buffer, _status) __RS485Write(_buffer, _status)

/**
 * Read RS485 data.
 * Read data from the RS485 hi-speed port.
 *
 * \param _buffer A byte array that will contain the data read from the RS485 port.
 * \param _status A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define RS485Read(_buffer, _status) __RS485Read(_buffer, _status)

#if __FIRMWARE_VERSION > 107

/**
 * Read limited RS485 data.
 * Read a limited number of bytes of data from the RS485 hi-speed port.
 *
 * \param _buffer A byte array that will contain the data read from the RS485 port.
 * \param _buflen The number of bytes you want to read.
 * \param _status A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+.
 */
#define RS485ReadEx(_buffer, _buflen, _status) __RS485ReadEx(_buffer, _buflen, _status)

/**
 * Control the RS485 port.
 * Control the RS485 hi-speed port using the specified parameters.
 *
 * \param _cmd The control command to send to the port. See \ref CommHiSpeedCtrlConstants.
 * \param _baud The baud rate for the RS485 port. See \ref CommHiSpeedBaudConstants.
 * \param _mode The RS485 port mode (data bits, stop bits, parity).  See \ref
 * CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants, \ref
 * CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define RS485Control(_cmd, _baud, _mode, _result) __RS485Control(_cmd, _baud, _mode, _result)

/**
 * Configure RS485 UART.
 * Configure the RS485 UART parameters, including baud rate, data bits,
 * stop bits, and parity.
 *
 * \param _baud The baud rate for the RS485 port. See \ref CommHiSpeedBaudConstants.
 * \param _mode The RS485 port mode (data bits, stop bits, parity).  See \ref
 * CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants, \ref
 * CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define RS485Uart(_baud, _mode, _result) __RS485Control(HS_CTRL_UART, _baud, _mode, _result)

/**
 * Initialize RS485 port.
 * Initialize the RS485 UART port to its default values.  The baud rate is
 * set to 921600 and the mode is set to 8N1 (8 data bits, no parity, 1 stop bit).
 * Data cannot be sent or received over the RS485 port until the UART is
 * initialized and the port has been configured for RS485 usage.
 *
 * \param _result A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define RS485Initialize(_result) __RS485Control(HS_CTRL_UART, HS_BAUD_DEFAULT, HS_MODE_DEFAULT, _result)

/**
 * Enable RS485.
 * Turn on the RS485 hi-speed port so that it can be used.
 *
 * \param _result A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define RS485Enable(_result) __RS485Control(HS_CTRL_INIT, HS_BAUD_DEFAULT, HS_MODE_DEFAULT, _result)

/**
 * Disable RS485.
 * Turn off the RS485 port.
 *
 * \param _result A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define RS485Disable(_result) __RS485Control(HS_CTRL_EXIT, HS_BAUD_DEFAULT, HS_MODE_DEFAULT, _result)

#else

#define RS485Control(_cmd, _baud, _result) __RS485Control(_cmd, _baud, _result)
#define RS485Uart(_baud, _result) __RS485Control(HS_CTRL_UART, _baud, _result)
#define RS485Initialize(_result) __RS485Control(HS_CTRL_UART, HS_BAUD_DEFAULT, _result)
#define RS485Enable(_result) __RS485Control(HS_CTRL_INIT, HS_BAUD_DEFAULT, _result)
#define RS485Disable(_result) __RS485Control(HS_CTRL_EXIT, HS_BAUD_DEFAULT, _result)

#endif

/**
 * Write RS485 boolean.
 * Write a boolean value to the RS485 hi-speed port.
 *
 * \param _bval A boolean value to write over the RS485 port.
 * \param _status A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define SendRS485Bool(_bval, _status) __sendRS485Bool(_bval, _status)

/**
 * Write RS485 numeric.
 * Write a numeric value to the RS485 hi-speed port.
 *
 * \param _val A numeric value to write over the RS485 port.
 * \param _status A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define SendRS485Number(_val, _status) __sendRS485Number(_val, _status)

/**
 * Write RS485 string.
 * Write a string value to the RS485 hi-speed port.
 *
 * \param _str A string value to write over the RS485 port.
 * \param _status A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define SendRS485String(_str, _status) __sendRS485String(_str, _status)

#endif

/**
 * Get bluetooth device name.
 * This method returns the name of the device at the specified index in the
 * Bluetooth device table.
 * \param _p The device table index.
 * \param _str The device name of the specified bluetooth device.
 */
#define GetBTDeviceName(_p, _str) __GetBTDeviceName(_p, _str)

/**
 * Get bluetooth device class.
 * This method returns the class of the device at the specified index within
 * the Bluetooth device table.
 * \param _p The device table index.
 * \param _n The device class of the specified bluetooth device.
 */
#define GetBTDeviceClass(_p, _n) __GetBTDeviceClass(_p, _n)

/**
 * Get bluetooth device address.
 * This method reads the address of the device at the specified index within
 * the Bluetooth device table and stores it in the data buffer provided.
 * \param _p The device table index.
 * \param _btaddr The byte array reference that will contain the device address.
 */
#define GetBTDeviceAddress(_p, _btaddr) __getBTDeviceAddress(_p, _btaddr)

/**
 * Get bluetooth device status.
 * This method returns the status of the device at the specified index within
 * the Bluetooth device table.
 * \param _p The device table index.
 * \param _n The status of the specified bluetooth device.
 */
#define GetBTDeviceStatus(_p, _n) __GetBTDeviceStatus(_p, _n)

/**
 * Get bluetooth device name.
 * This method returns the name of the device at the specified index in the
 * Bluetooth connection table.
 * \param _p The connection slot (0..3).
 * \param _str The name of the bluetooth device at the specified connection slot.
 */
#define GetBTConnectionName(_p, _str) __GetBTConnectionName(_p, _str)

/**
 * Get bluetooth device class.
 * This method returns the class of the device at the specified index within
 * the Bluetooth connection table.
 * \param _p The connection slot (0..3).
 * \param _n The class of the bluetooth device at the specified connection slot.
 */
#define GetBTConnectionClass(_p, _n) __GetBTConnectionClass(_p, _n)

/**
 * Get bluetooth device pin code.
 * This method returns the pin code of the device at the specified index in the
 * Bluetooth connection table.
 * \param _p The connection slot (0..3).
 * \param _code The pin code for the bluetooth device at the specified connection slot.
 */
#define GetBTConnectionPinCode(_p, _code) __GetBTConnectionPinCode(_p, _code)

/**
 * Get bluetooth device address.
 * This method reads the address of the device at the specified index within
 * the Bluetooth connection table and stores it in the data buffer provided.
 * \param _p The connection slot (0..3).
 * \param _btaddr The byte array reference that will contain the device address.
 */
#define GetBTConnectionAddress(_p, _btaddr) __getBTConnectionAddress(_p, _btaddr)

/**
 * Get bluetooth device handle number.
 * This method returns the handle number of the device at the specified index within
 * the Bluetooth connection table.
 * \param _p The connection slot (0..3).
 * \param _n The handle number of the bluetooth device at the specified connection slot.
 */
#define GetBTConnectionHandleNum(_p, _n) __GetBTConnectionHandleNum(_p, _n)

/**
 * Get bluetooth device stream status.
 * This method returns the stream status of the device at the specified index within
 * the Bluetooth connection table.
 * \param _p The connection slot (0..3).
 * \param _n The stream status of the bluetooth device at the specified connection slot.
 */
#define GetBTConnectionStreamStatus(_p, _n) __GetBTConnectionStreamStatus(_p, _n)

/**
 * Get bluetooth device link quality.
 * This method returns the link quality of the device at the specified index within
 * the Bluetooth connection table.
 * \param _p The connection slot (0..3).
 * \param _n The link quality of the specified connection slot (unimplemented).
 * \warning This function is not implemented at the firmware level.
 */
#define GetBTConnectionLinkQuality(_p, _n) __GetBTConnectionLinkQuality(_p, _n)

/**
 * Get NXT name.
 * This method returns the name of the NXT.
 * \param _str The NXT's bluetooth name.
 */
#define GetBrickDataName(_str) __getCommModuleBytes(CommOffsetBrickDataName, 16, _str)

/**
 * Get NXT bluecore version.
 * This method returns the bluecore version of the NXT.
 * \param _n The NXT's bluecore version number.
 */
#define GetBrickDataBluecoreVersion(_n) \
  compchk EQ, sizeof(_n), 2 \
  __getCommModuleValue(CommOffsetBrickDataBluecoreVersion, _n)

/**
 * Get NXT address.
 * This method reads the address of the NXT and stores it in the data buffer
 * provided.
 * \param _btaddr The byte array reference that will contain the device address.
 */
#define GetBrickDataAddress(_btaddr) __getCommModuleBytes(CommOffsetBrickDataBdAddr, 7, _btaddr)

/**
 * Get NXT bluetooth state status.
 * This method returns the Bluetooth state status of the NXT.
 * \param _n The NXT's bluetooth state status.
 */
#define GetBrickDataBtStateStatus(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetBrickDataBtStateStatus, _n)

/**
 * Get NXT bluetooth hardware status.
 * This method returns the Bluetooth hardware status of the NXT.
 * \param _n The NXT's bluetooth hardware status.
 */
#define GetBrickDataBtHardwareStatus(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetBrickDataBtHwStatus, _n)

/**
 * Get NXT bluetooth timeout value.
 * This method returns the Bluetooth timeout value of the NXT.
 * \param _n The NXT's bluetooth timeout value.
 */
#define GetBrickDataTimeoutValue(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetBrickDataTimeOutValue, _n)

/**
 * Get bluetooth input buffer data.
 * This method reads count bytes of data from the Bluetooth input buffer and
 * writes it to the buffer provided.
 * 
 * \param _offset A constant offset into the bluetooth input buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the bluetooth input buffer.
 */
#define GetBTInputBuffer(_offset, _cnt, _data) __getBTInputBuffer(_offset, _cnt, _data)

/**
 * Get bluetooth input buffer in-pointer.
 * This method returns the value of the input pointer of the Bluetooth input
 * buffer.
 * \param _n The bluetooth input buffer's in-pointer value.
 */
#define GetBTInputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetBtInBufInPtr, _n)

/**
 * Get bluetooth input buffer out-pointer.
 * This method returns the value of the output pointer of the Bluetooth input
 * buffer.
 * \param _n The bluetooth input buffer's out-pointer value.
 */
#define GetBTInputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetBtInBufOutPtr, _n)

/**
 * Get bluetooth output buffer data.
 * This method reads count bytes of data from the Bluetooth output buffer and
 * writes it to the buffer provided.
 *
 * \param _offset A constant offset into the bluetooth output buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the bluetooth output buffer.
 */
#define GetBTOutputBuffer(_offset, _cnt, _data) __getBTOutputBuffer(_offset, _cnt, _data)

/**
 * Get bluetooth output buffer in-pointer.
 * This method returns the value of the input pointer of the Bluetooth output
 * buffer.
 * \param _n The bluetooth output buffer's in-pointer value.
 */
#define GetBTOutputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetBtOutBufInPtr, _n)

/**
 * Get bluetooth output buffer out-pointer.
 * This method returns the value of the output pointer of the Bluetooth output
 * buffer.
 * \param _n The bluetooth output buffer's out-pointer value.
 */
#define GetBTOutputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetBtOutBufOutPtr, _n)

/**
 * Get hi-speed port input buffer data.
 * This method reads count bytes of data from the hi-speed port input buffer and
 * writes it to the buffer provided.
 * 
 * \param _offset A constant offset into the hi-speed port input buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the hi-speed port input buffer.
 */
#define GetHSInputBuffer(_offset, _cnt, _data) __getHSInputBuffer(_offset, _cnt, _data)

/**
 * Get hi-speed port input buffer in-pointer.
 * This method returns the value of the input pointer of the hi-speed port input
 * buffer.
 * \param _n The hi-speed port input buffer's in-pointer value.
 */
#define GetHSInputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetHsInBufInPtr, _n)

/**
 * Get hi-speed port input buffer out-pointer.
 * This method returns the value of the output pointer of the hi-speed port input
 * buffer.
 * \param _n The hi-speed port input buffer's out-pointer value.
 */
#define GetHSInputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetHsInBufOutPtr, _n)

/**
 * Get hi-speed port output buffer data.
 * This method reads count bytes of data from the hi-speed port output buffer and
 * writes it to the buffer provided.
 *
 * \param _offset A constant offset into the hi-speed port output buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the hi-speed port output buffer.
 */
#define GetHSOutputBuffer(_offset, _cnt, _data) __getHSOutputBuffer(_offset, _cnt, _data)

/**
 * Get hi-speed port output buffer in-pointer.
 * This method returns the value of the input pointer of the hi-speed port output
 * buffer.
 * \param _n The hi-speed port output buffer's in-pointer value.
 */
#define GetHSOutputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetHsOutBufInPtr, _n)

/**
 * Get hi-speed port output buffer out-pointer.
 * This method returns the value of the output pointer of the hi-speed port output
 * buffer.
 * \param _n The hi-speed port output buffer's out-pointer value.
 */
#define GetHSOutputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetHsOutBufOutPtr, _n)

/**
 * Get usb input buffer data.
 * This method reads count bytes of data from the usb input buffer and
 * writes it to the buffer provided.
 *
 * \param _offset A constant offset into the usb input buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the usb input buffer.
 */
#define GetUSBInputBuffer(_offset, _cnt, _data) __getUSBInputBuffer(_offset, _cnt, _data)

/**
 * Get usb port input buffer in-pointer.
 * This method returns the value of the input pointer of the usb port input
 * buffer.
 * \param _n The USB port input buffer's in-pointer value.
 */
#define GetUSBInputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetUsbInBufInPtr, _n)

/**
 * Get usb port input buffer out-pointer.
 * This method returns the value of the output pointer of the usb port input
 * buffer.
 * \param _n The USB port input buffer's out-pointer value.
 */
#define GetUSBInputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetUsbInBufOutPtr, _n)

/**
 * Get usb output buffer data.
 * This method reads count bytes of data from the usb output buffer and
 * writes it to the buffer provided.
 * \param _offset A constant offset into the usb output buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the usb output buffer.
 */
#define GetUSBOutputBuffer(_offset, _cnt, _data) __getUSBOutputBuffer(_offset, _cnt, _data)

/**
 * Get usb port output buffer in-pointer.
 * This method returns the value of the input pointer of the usb port output
 * buffer.
 * \param _n The USB port output buffer's in-pointer value.
 */
#define GetUSBOutputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetUsbOutBufInPtr, _n)

/**
 * Get usb port output buffer out-pointer.
 * This method returns the value of the output pointer of the usb port output
 * buffer.
 * \param _n The USB port output buffer's out-pointer value.
 */
#define GetUSBOutputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetUsbOutBufOutPtr, _n)

/**
 * Get usb poll buffer data.
 * This method reads count bytes of data from the usb poll buffer and
 * writes it to the buffer provided.
 * \param _offset A constant offset into the usb poll buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the usb poll buffer.
 */
#define GetUSBPollBuffer(_offset, _cnt, _data) __getUSBPollBuffer(_offset, _cnt, _data)

/**
 * Get usb port poll buffer in-pointer.
 * This method returns the value of the input pointer of the usb port poll
 * buffer.
 * \param _n The USB port poll buffer's in-pointer value.
 */
#define GetUSBPollBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetUsbPollBufInPtr, _n)

/**
 * Get usb port poll buffer out-pointer.
 * This method returns the value of the output pointer of the usb port poll
 * buffer.
 * \param _n The USB port poll buffer's out-pointer value.
 */
#define GetUSBPollBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetUsbPollBufOutPtr, _n)

/**
 * Get bluetooth device count.
 * This method returns the number of devices defined within the Bluetooth
 * device table.
 * \return The count of known bluetooth devices.
 */
#define GetBTDeviceCount(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetBtDeviceCnt, _n)

/**
 * Get bluetooth device name count.
 * This method returns the number of device names defined within the Bluetooth
 * device table. This usually has the same value as BTDeviceCount but it can
 * differ in some instances.
 * \param _n The count of known bluetooth device names.
 */
#define GetBTDeviceNameCount(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetBtDeviceNameCnt, _n)

/**
 * Get hi-speed port flags.
 * This method returns the value of the hi-speed port flags.
 * \param _n The hi-speed port flags. See \ref CommHiSpeedFlagsConstants.
 */
#define GetHSFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetHsFlags, _n)

/**
 * Get hi-speed port speed.
 * This method returns the value of the hi-speed port speed (baud rate).
 * \param _n The hi-speed port speed (baud rate).  See \ref CommHiSpeedBaudConstants.
 */
#define GetHSSpeed(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetHsSpeed, _n)

/**
 * Get hi-speed port state.
 * This method returns the value of the hi-speed port state.
 * \param _n The hi-speed port state. See \ref CommHiSpeedStateConstants.
 */
#define GetHSState(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetHsState, _n)

/**
 * Get USB state.
 * This method returns the value of the USB state.
 * \param _n The USB state.
 */
#define GetUSBState(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetUsbState, _n)

/**
 * Get hi-speed port address.
 * This method returns the value of the hi-speed port address.
 * \param _n The hi-speed port address. See \ref CommHiSpeedAddressConstants.
 */
#define GetHSAddress(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetHsAddress, _n)

#if (__FIRMWARE_VERSION > 107) && defined(__ENHANCED_FIRMWARE)

/**
 * Get hi-speed port mode.
 * This method returns the value of the hi-speed port mode.
 * \param _n The hi-speed port mode (data bits, stop bits, parity).  See
 * \ref CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants,
 * \ref CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define GetHSMode(_n) \
  compchk EQ, sizeof(_n), 2 \
  __getCommModuleValue(CommOffsetHsMode, _n)

/**
 * Get Bluetooth data mode.
 * This method returns the value of the Bluetooth data mode.
 * \param _n The Bluetooth data mode.  See \ref CommDataModeConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define GetBTDataMode(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetBtDataMode, _n)

/**
 * Get hi-speed port data mode.
 * This method returns the value of the hi-speed port data mode.
 * \param _n The hi-speed port data mode.  See \ref CommDataModeConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define GetHSDataMode(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getCommModuleValue(CommOffsetHsDataMode, _n)

#endif  

/**
 * Set bluetooth input buffer data.
 * Write cnt bytes of data to the bluetooth input buffer at offset.
 * \param _offset A constant offset into the input buffer
 * \param _cnt The number of bytes to write
 * \param _data A byte array containing the data to write
 */
#define SetBTInputBuffer(_offset, _cnt, _data) __setBTInputBuffer(_offset, _cnt, _data)

/**
 * Set bluetooth input buffer in-pointer.
 * Set the value of the input buffer in-pointer.
 * \param _n The new in-pointer value (0..127).
 */
#define SetBTInputBufferInPtr(_n) __setBTInputBufferInPtr(_n)

/**
 * Set bluetooth input buffer out-pointer.
 * Set the value of the input buffer out-pointer.
 * \param _n The new out-pointer value (0..127).
 */
#define SetBTInputBufferOutPtr(_n) __setBTInputBufferOutPtr(_n)

/**
 * Set bluetooth output buffer data.
 * Write cnt bytes of data to the bluetooth output buffer at offset.
 * \param _offset A constant offset into the output buffer
 * \param _cnt The number of bytes to write
 * \param _data A byte array containing the data to write
 */
#define SetBTOutputBuffer(_offset, _cnt, _data) __setBTOutputBuffer(_offset, _cnt, _data)

/**
 * Set bluetooth output buffer in-pointer.
 * Set the value of the output buffer in-pointer.
 * \param _n The new in-pointer value (0..127).
 */
#define SetBTOutputBufferInPtr(_n) __setBTOutputBufferInPtr(_n)

/**
 * Set bluetooth output buffer out-pointer.
 * Set the value of the output buffer out-pointer.
 * \param _n The new out-pointer value (0..127).
 */
#define SetBTOutputBufferOutPtr(_n) __setBTOutputBufferOutPtr(_n)

/**
 * Set hi-speed port input buffer data.
 * Write cnt bytes of data to the hi-speed port input buffer at offset.
 * \param _offset A constant offset into the input buffer
 * \param _cnt The number of bytes to write
 * \param _data A byte array containing the data to write
 */
#define SetHSInputBuffer(_offset, _cnt, _data) __setHSInputBuffer(_offset, _cnt, _data)

/**
 * Set hi-speed port input buffer in-pointer.
 * Set the value of the input buffer in-pointer.
 * \param _n The new in-pointer value (0..127).
 */
#define SetHSInputBufferInPtr(_n) __setHSInputBufferInPtr(_n)

/**
 * Set hi-speed port input buffer out-pointer.
 * Set the value of the input buffer out-pointer.
 * \param _n The new out-pointer value (0..127).
 */
#define SetHSInputBufferOutPtr(_n) __setHSInputBufferOutPtr(_n)

/**
 * Set hi-speed port output buffer data.
 * Write cnt bytes of data to the hi-speed port output buffer at offset.
 * \param _offset A constant offset into the output buffer
 * \param _cnt The number of bytes to write
 * \param _data A byte array containing the data to write
 */
#define SetHSOutputBuffer(_offset, _cnt, _data) __setHSOutputBuffer(_offset, _cnt, _data)

/**
 * Set hi-speed port output buffer in-pointer.
 * Set the value of the output buffer in-pointer.
 * \param _n The new in-pointer value (0..127).
 */
#define SetHSOutputBufferInPtr(_n) __setHSOutputBufferInPtr(_n)

/**
 * Set hi-speed port output buffer out-pointer.
 * Set the value of the output buffer out-pointer.
 * \param _n The new out-pointer value (0..127).
 */
#define SetHSOutputBufferOutPtr(_n) __setHSOutputBufferOutPtr(_n)

/**
 * Set USB input buffer data.
 * Write cnt bytes of data to the USB input buffer at offset.
 * \param _offset A constant offset into the input buffer
 * \param _cnt The number of bytes to write
 * \param _data A byte array containing the data to write
 */
#define SetUSBInputBuffer(_offset, _cnt, _data) __setUSBInputBuffer(_offset, _cnt, _data)

/**
 * Set USB input buffer in-pointer.
 * Set the value of the input buffer in-pointer.
 * \param _n The new in-pointer value (0..63).
 */
#define SetUSBInputBufferInPtr(_n) __setUSBInputBufferInPtr(_n)

/**
 * Set USB input buffer out-pointer.
 * Set the value of the input buffer out-pointer.
 * \param _n The new out-pointer value (0..63).
 */
#define SetUSBInputBufferOutPtr(_n) __setUSBInputBufferOutPtr(_n)

/**
 * Set USB output buffer data.
 * Write cnt bytes of data to the USB output buffer at offset.
 * \param _offset A constant offset into the output buffer
 * \param _cnt The number of bytes to write
 * \param _data A byte array containing the data to write
 */
#define SetUSBOutputBuffer(_offset, _cnt, _data) __setUSBOutputBuffer(_offset, _cnt, _data)

/**
 * Set USB output buffer in-pointer.
 * Set the value of the output buffer in-pointer.
 * \param _n The new in-pointer value (0..63).
 */
#define SetUSBOutputBufferInPtr(_n) __setUSBOutputBufferInPtr(_n)

/**
 * Set USB output buffer out-pointer.
 * Set the value of the output buffer out-pointer.
 * \param _n The new out-pointer value (0..63).
 */
#define SetUSBOutputBufferOutPtr(_n) __setUSBOutputBufferOutPtr(_n)

/**
 * Set USB poll buffer data.
 * Write cnt bytes of data to the USB poll buffer at offset.
 * \param _offset A constant offset into the poll buffer
 * \param _cnt The number of bytes to write
 * \param _data A byte array containing the data to write
 */
#define SetUSBPollBuffer(_offset, _cnt, _data) __setUSBPollBuffer(_offset, _cnt, _data)

/**
 * Set USB poll buffer in-pointer.
 * Set the value of the poll buffer in-pointer.
 * \param _n The new in-pointer value (0..63).
 */
#define SetUSBPollBufferInPtr(_n) __setUSBPollBufferInPtr(_n)

/**
 * Set USB poll buffer out-pointer.
 * Set the value of the poll buffer out-pointer.
 * \param _n The new out-pointer value (0..63).
 */
#define SetUSBPollBufferOutPtr(_n) __setUSBPollBufferOutPtr(_n)

/**
 * Set hi-speed port flags.
 * This method sets the value of the hi-speed port flags.
 * \param _n The hi-speed port flags. See \ref CommHiSpeedFlagsConstants.
 */
#define SetHSFlags(_n) __setHSFlags(_n)

/**
 * Set hi-speed port speed.
 * This method sets the value of the hi-speed port speed (baud rate).
 * \param _n The hi-speed port speed (baud rate).  See \ref CommHiSpeedBaudConstants.
 */
#define SetHSSpeed(_n) __setHSSpeed(_n)

/**
 * Set hi-speed port state.
 * This method sets the value of the hi-speed port state.
 * \param _n The hi-speed port state. See \ref CommHiSpeedStateConstants.
 */
#define SetHSState(_n) __setHSState(_n)

/**
 * Set USB state.
 * This method sets the value of the USB state.
 * \param _n The USB state.
 */
#define SetUSBState(_n) __setUSBState(_n)

/**
 * Set hi-speed port address.
 * This method sets the value of the hi-speed port address.
 * \param _n The hi-speed port address. See \ref CommHiSpeedAddressConstants.
 */
#define SetHSAddress(_n) __setHSAddress(_n)

#if (__FIRMWARE_VERSION > 107) && defined(__ENHANCED_FIRMWARE)

/**
 * Set hi-speed port mode.
 * This method sets the value of the hi-speed port mode.
 * \param _n The hi-speed port mode (data bits, stop bits, parity).  See
 * \ref CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants,
 * \ref CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define SetHSMode(_n) __setHSMode(_n)

/**
 * Set Bluetooth data mode.
 * This method sets the value of the Bluetooth data mode.
 * \param _n The Bluetooth data mode.  See \ref CommDataModeConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define SetBTDataMode(_n) __setBTDataMode(_n)

/**
 * Set hi-speed port data mode.
 * This method sets the value of the hi-speed port data mode.
 * \param _n The hi-speed port data mode.  See \ref CommDataModeConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define SetHSDataMode(_n) __setHSDataMode(_n)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/**
 * Read last response information.
 * Read the last direct or system command response packet received by the NXT.
 * Optionally clear the response after retrieving the information.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+.
 *
 * \param _Clear A boolean value indicating whether to clear the response or not.
 * \param _Length The response packet length.
 * \param _Command The original command byte.
 * \param _Buffer The response packet buffer.
 * \param _Result The response status code.
 */
#define GetLastResponseInfo(_Clear,_Length,_Command,_Buffer,_Result) \
  __GetLastResponseInfo(_Clear,_Length,_Command,_Buffer,_Result)

#endif

#endif

/** @} */ // end of CommModuleFunctions group
/** @} */ // end of CommModule group
/** @} */ // end of NXTFirmwareModules group

#endif // NBC_COMM_H
