/** \file nbc_hitechnic_irlink.h
 * \brief The NBC HiTechnic IRLink API
 *
 * nbc_hitechnic_irlink.h contains the NBC HiTechnic IRLink API
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

#ifndef NBC_HITECHNIC_IRLINK_H
#define NBC_HITECHNIC_IRLINK_H

#include "hitechnic_constants.h"
#include "rcxapi_constants.h"
#include "nbc_lowspeed.h"
#include "nbc_rcxapi.h"

/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @addtogroup HiTechnicAPI
 * @{
 */

///////////////////////////////////////////////////////////////////////////////
//////////////////////////// HiTechnic IRLink API /////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup HiTechnicIRLinkAPI
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

dseg segment
  __HTPFStartIRLink  byte[] 0x02, 0x42
  __HTPFCommitIRLink byte[] 0x0B, 0x02, 0x01
  __HTPFBits byte[]
  __HTPFI2CBuf byte[]
  __HTPFI sword
  __HTPFJ sword
  __HTPFValue byte
  __HTPFDx byte
dseg ends

subroutine __HTPowerFunctionCalcBits
  call __PFCalcChecksum
  brtst EQ, __HTPFUseIRTrainMode, __PFPowerFuncMode
  set __HTPFDx, 3
  jmp __HTPFEndPowerFuncModeCheck
__HTPFUseIRTrainMode:
  set __HTPFDx, 2
__HTPFEndPowerFuncModeCheck:
  arrinit __HTPFBits, 0, 88
  arrinit __PFBytes, 0, 11
  // fill in the bits
  set __PFIdx, 0
  replace __HTPFBits, __HTPFBits, __PFIdx, 1
  add __PFIdx, __PFIdx, 8
  // check bits in n0..n3
  set __HTPFI, 0
__lblCalcBitsForIBitSet:
  index __PFNx, __PFNibbles, __HTPFI
  set __HTPFJ, 3
__lblCalcBitsForJBitSet:
  replace __HTPFBits, __HTPFBits, __PFIdx, 1
  shl __PFTmp, 1, __HTPFJ
  and __HTPFValue, __PFNx, __PFTmp
  add __PFIdx, __PFIdx, __HTPFDx
  brcmp NEQ, __lblCalcBitsFoundZero, __HTPFValue, __PFTmp
  add __PFIdx, __PFIdx, 2
__lblCalcBitsFoundZero:
  sub __HTPFJ, __HTPFJ, 1
  brtst GTEQ, __lblCalcBitsForJBitSet, __HTPFJ
  add __HTPFI, __HTPFI, 1
  brcmp LTEQ, __lblCalcBitsForIBitSet, __HTPFI, 3
  replace __HTPFBits, __HTPFBits, __PFIdx, 1
  // now calculate bytes
  set __HTPFI, 0
__lblCalcBitsWhileIByteCalc:
  set __HTPFValue, 0
  set __HTPFJ, 0
__lblCalcBitsForJByteCalc:
  index __PFTmp, __HTPFBits, __HTPFI
  add __HTPFValue, __HTPFValue, __PFTmp
  brcmp GTEQ, __lblCalcBitsByteCalcLastBit, __HTPFJ, 7
  mul __HTPFValue, __HTPFValue, 2
__lblCalcBitsByteCalcLastBit:
  add __HTPFI, __HTPFI, 1
  add __HTPFJ, __HTPFJ, 1
  brcmp LTEQ, __lblCalcBitsForJByteCalc, __HTPFJ, 7
  div __PFIdx, __HTPFI, 8
  sub __PFIdx, __PFIdx, 1
  replace __PFBytes, __PFBytes, __PFIdx, __HTPFValue
  brcmp LT, __lblCalcBitsWhileIByteCalc, __HTPFI, 88
  // set IRLink mode to either PF or IRTrain
  sub __HTPFDx, __HTPFDx, 1
  replace __HTPFCommitIRLink, __HTPFCommitIRLink, 1, __HTPFDx
  // build i2c buffer
  arrbuild __HTPFI2CBuf, __HTPFStartIRLink, __PFBytes, __HTPFCommitIRLink
  return
ends

#define __HTPFComboDirect(_port, _channel, _outa, _outb, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _outa, 4 \
  mod __PF_p3, _outb, 4 \
  call __PFComboDirectSub \
  set __PFPowerFuncMode, TRUE \
  call __HTPowerFunctionCalcBits \
  __lowspeedWrite(_port, 0, __HTPFI2CBuf, _result) \
  release __PFMutex

#define __HTPFSinglePin(_port, _channel, _out, _pin, _func, _cont, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _out, 2 \
  mod __PF_p3, _pin, 2 \
  mod __PF_p4, _func, 4 \
  set __PF_p5, _cont \
  call __PFSinglePinSub \
  set __PFPowerFuncMode, TRUE \
  call __HTPowerFunctionCalcBits \
  __lowspeedWrite(_port, 0, __HTPFI2CBuf, _result) \
  release __PFMutex

#define __HTPFSingleOutput(_port, _channel, _out, _func, _cst, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _out, 2 \
  mod __PF_p3, _func, 16 \
  set __PF_p4, _cst \
  call __PFSingleOutputSub \
  set __PFPowerFuncMode, TRUE \
  call __HTPowerFunctionCalcBits \
  __lowspeedWrite(_port, 0, __HTPFI2CBuf, _result) \
  release __PFMutex

#define __HTPFComboPWM(_port, _channel, _outa, _outb, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _outa, 16 \
  mod __PF_p3, _outb, 16 \
  call __PFComboPWMSub \
  set __PFPowerFuncMode, TRUE \
  call __HTPowerFunctionCalcBits \
  __lowspeedWrite(_port, 0, __HTPFI2CBuf, _result) \
  release __PFMutex

#define __HTIRTrain(_port, _channel, _func, _PFMode, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _func, 5 \
  compif EQ, _PFMode, TRUE \
  call __PFTrainSub \
  compelse \
  call __RCTrainSub \
  compend \
  set __PFPowerFuncMode, _PFMode \
  call __HTPowerFunctionCalcBits \
  __lowspeedWrite(_port, 0, __HTPFI2CBuf, _result) \
  release __PFMutex

#define __HTPFRawOutput(_port, _nibble0, _nibble1, _nibble2, _result) \
  acquire __PFMutex \
  mod __PF_p1, _nibble0, 16 \
  mod __PF_p2, _nibble1, 16 \
  mod __PF_p3, _nibble2, 16 \
  call __PFRawOutputSub \
  set __PFPowerFuncMode, TRUE \
  call __HTPowerFunctionCalcBits \
  __lowspeedWrite(_port, 0, __HTPFI2CBuf, _result) \
  release __PFMutex

#define __HTPFRepeatLastCommand(_port, _count, _delay, _result) \
  acquire __PFMutex \
  mov __PF_p1, _count \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSWMutex0 \
  acquire __CLSWMutex1 \
  acquire __CLSWMutex2 \
  acquire __CLSWMutex3 \
  mov __CLSWArgs0.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  index __LSWriteOptionsVar, __LSWriteOptions, _port \
  or __CLSWArgs0.Port, _port, __LSWriteOptionsVar \
  mov __CLSWArgs0.ReturnLen, 0 \
  __HTPFRepeatLoop##__I__: \
  syscall CommLSWrite, __CLSWArgs0 \
  waitv _delay \
  sub __PF_p1, __PF_p1, 1 \
  brtst GT, __HTPFRepeatLoop##__I__, __PF_p1 \
  mov _result, __CLSWArgs0.Result \
  release __CLSWMutex0 \
  release __CLSWMutex1 \
  release __CLSWMutex2 \
  release __CLSWMutex3 \
  __IncI__ \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSWMutex##_port \
  mov __CLSWArgs##_port.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  index __LSWriteOptionsVar, __LSWriteOptions, _port \
  or __CLSWArgs##_port.Port, _port, __LSWriteOptionsVar \
  mov __CLSWArgs##_port.ReturnLen, 0 \
  __HTPFRepeatLoop##__I__: \
  syscall CommLSWrite, __CLSWArgs##_port \
  waitv _delay \
  sub __PF_p1, __PF_p1, 1 \
  brtst GT, __HTPFRepeatLoop##__I__, __PF_p1 \
  mov _result, __CLSWArgs##_port.Result \
  release __CLSWMutex##_port \
  __IncI__ \
  compend

subroutine __HTRCXCommandSub
  dseg segment
    __RCSToggle byte
    __RCSI byte
    __RCSInCmd byte[]
    __RCSCmdBytes sbyte
    __RCSCmd byte
    __RCSCSum byte
    __RCSMsgBufSize byte
    __RCSTotalBytes byte
    __RCSTmpByte byte
    __RCSTmpByte2 byte
    __RCSResult byte
    __RCSHeaderMsg byte[] 0x02, 0x4a, 0x55, 0xff, 0x00, 0x03, 0x00, 0x01
  dseg ends
  arrsize __RCSCmdBytes, __gRCXCmd.Command
  index __RCSCmd, __gRCXCmd.Command, NA
  set __RCSCSum, 0

  replace __RCSHeaderMsg, __RCSHeaderMsg, NA, __gRCXCmd.Address
  // send the IR message
  __lowspeedWrite(__gRCXCmd.Port, 0, __RCSHeaderMsg, __RCSTmpByte)
  wait 12

  // build rest of the message
  set __RCSMsgBufSize, 2
  mul __RCSMsgBufSize, __RCSMsgBufSize, __RCSCmdBytes
  add __RCSMsgBufSize, __RCSMsgBufSize, 7
  add __RCSTotalBytes, __RCSMsgBufSize, __gRCXCmd.ResponseBytes

  arrinit __RCSInCmd, 0, __RCSMsgBufSize
  replace __RCSInCmd, __RCSInCmd, NA, __gRCXCmd.Address
  set __RCSTmpByte, 2
  mul __RCSTmpByte, __RCSTmpByte, __RCSCmdBytes
  sub __RCSTmpByte, 0x4b, __RCSTmpByte
  replace __RCSInCmd, __RCSInCmd, 1, __RCSTmpByte

  // put cmd and ~cmd into msg
  or __RCSTmpByte, __RCSCmd, __RCSToggle
  replace __RCSInCmd, __RCSInCmd, 2, __RCSTmpByte
  mov __RCSCSum, __RCSTmpByte
  sub __RCSTmpByte, 0xFF, __RCSTmpByte
  replace __RCSInCmd, __RCSInCmd, 3, __RCSTmpByte

  set __RCSI, 0
  xor __RCSToggle, __RCSToggle, 8

  brcmp LTEQ, __RCSEndWhileILTCmdBytes, __RCSCmdBytes, 1

__RCSWhileILTCmdBytes:
  sub __RCSTmpByte, __RCSCmdBytes, 1
  brcmp GTEQ, __RCSEndWhileILTCmdBytes, __RCSI, __RCSTmpByte
  add __RCSTmpByte, __RCSI, 1
  index __RCSTmpByte2, __gRCXCmd.Command, __RCSTmpByte
  mul __RCSTmpByte, __RCSI, 2
  add __RCSTmpByte, __RCSTmpByte, 4
  replace __RCSInCmd, __RCSInCmd, __RCSTmpByte, __RCSTmpByte2
  add __RCSCSum, __RCSCSum, __RCSTmpByte2
  add __RCSTmpByte, __RCSTmpByte, 1
  sub __RCSTmpByte2, 0xFF, __RCSTmpByte2
  replace __RCSInCmd, __RCSInCmd, __RCSTmpByte, __RCSTmpByte2
  add __RCSI, __RCSI, 1
  jmp __RCSWhileILTCmdBytes
__RCSEndWhileILTCmdBytes:

  mul __RCSTmpByte, __RCSI, 2
  add __RCSTmpByte, __RCSTmpByte, 4
  replace __RCSInCmd, __RCSInCmd, __RCSTmpByte, __RCSCSum
  sub __RCSTmpByte2, 0xFF, __RCSCSum
  add __RCSTmpByte, __RCSTmpByte, 1
  replace __RCSInCmd, __RCSInCmd, __RCSTmpByte, __RCSTmpByte2
  // fill in the last three bytes
  add __RCSTmpByte, __RCSTmpByte, 1
  mul __RCSTmpByte2, __RCSCmdBytes, 2
  add __RCSTmpByte2, __RCSTmpByte2, 2
  replace __RCSInCmd, __RCSInCmd, __RCSTmpByte, __RCSTmpByte2
  add __RCSTmpByte, __RCSTmpByte, 1
  replace __RCSInCmd, __RCSInCmd, __RCSTmpByte, 0x00
  add __RCSTmpByte, __RCSTmpByte, 1
  replace __RCSInCmd, __RCSInCmd, __RCSTmpByte, 0x01

  // send the IR message
  __lowspeedWrite(__gRCXCmd.Port, 0, __RCSInCmd, __RCSTmpByte)

  // give the message time to be transferred
  mul __RCSTmpByte, __RCSTotalBytes, 5
  add __RCSTmpByte, __RCSTmpByte, 10
  waitv __RCSTmpByte

  // do we need to read a response?
  brtst EQ, __RCSNoResponse, __gRCXCmd.ResponseBytes

  arrbuild __RCSInCmd, __gRCXCmd.Address, 0x51
  mov __RCSTmpByte, __gRCXCmd.ResponseBytes
  __ReadI2CBytes(__gRCXCmd.Port, __RCSInCmd, __RCSTmpByte, __gRCXCmd.Response, __RCSResult)
__RCSNoResponse:
  return
ends

#define __HTRCXSetIRLinkPort(_port) \
  set __gRCXCmd.Port, _port \
  set __gRCXCmd.Address, 0x02

#define __HTRCXPoll(_src, _value, _result) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_PollOp, _src, _value \
  set __gRCXCmd.ResponseBytes, 12 \
  call __HTRCXCommandSub \
  index _result, __gRCXCmd.Response, 7 \
  index __RCSTmpByte, __gRCXCmd.Response, 5 \
  mul _result, _result, 256 \
  add _result, _result, __RCSTmpByte \
  release __RCXCmdMutex

#define __HTRCXBatteryLevel(_result) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_BatteryLevelOp \
  set __gRCXCmd.ResponseBytes, 12 \
  call __HTRCXCommandSub \
  index _result, __gRCXCmd.Response, 7 \
  index __RCSTmpByte, __gRCXCmd.Response, 5 \
  mul _result, _result, 256 \
  add _result, _result, __RCSTmpByte \
  release __RCXCmdMutex

#define __HTRCXOpNoArgs(_op) \
  acquire __RCXCmdMutex \
  arrinit __gRCXCmd.Command, _op, 1 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetOutput(_outputs, _mode) \
  acquire __RCXCmdMutex \
  add __RCSTmpByte, _outputs, _mode \
  arrbuild __gRCXCmd.Command, RCX_OnOffFloatOp, __RCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetDirection(_outputs, _dir) \
  acquire __RCXCmdMutex \
  add __RCSTmpByte, _outputs, _dir \
  arrbuild __gRCXCmd.Command, RCX_OutputDirOp, __RCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetPower(_outputs, _pwrsrc, _pwrval) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_OutputPowerOp, _outputs, _pwrsrc, _pwrval \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXOnFwd(_outputs) \
  __HTRCXSetDirection(_outputs, RCX_OUT_FWD) \
  __HTRCXSetOutput(_outputs, RCX_OUT_ON)

#define __HTRCXOnRev(_outputs) \
  __HTRCXSetDirection(_outputs, RCX_OUT_REV) \
  __HTRCXSetOutput(_outputs, RCX_OUT_ON)

#define __HTRCXOnFor(_outputs, _ms) \
  __HTRCXSetOutput(_outputs, RCX_OUT_ON) \
  waitv _ms \
  __HTRCXSetOutput(_outputs, RCX_OUT_OFF)

#define __HTRCXSetTxPower(_pwr) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_IRModeOp, _pwr \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXPlaySound(_snd) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_PlaySoundOp, _snd \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXDeleteTask(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DeleteTaskOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXStartTask(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_StartTaskOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXStopTask(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_StopTaskOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSelectProgram(_prog) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SelectProgramOp, _prog \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXClearTimer(_timer) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ClearTimerOp, _timer \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetSleepTime(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_AutoOffOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXDeleteSub(_s) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DeleteSubOp, _s \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXClearSensor(_port) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ClearSensorOp, _port \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXPlayToneVar(_varnum, _duration) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_PlayToneVarOp, _varnum, _duration \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetWatch(_hours, _minutes) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SetWatchOp, _hours, _minutes \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetSensorType(_port, _type) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_InputTypeOp, _port, _type \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetSensorMode(_port, _mode) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_InputModeOp, _port, _mode \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXCreateDatalog(_size) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _size, 0xFF \
  div __RCSTmpByte2, _size, 256 \
  arrbuild __gRCXCmd.Command, RCX_SetDatalogOp, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXAddToDatalog(_src, _value) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DatalogOp, _src, _value \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSendSerial(_first, _count) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SendUARTDataOp, _first, _count \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXRemote(_cmd) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _cmd, 0xFF \
  div __RCSTmpByte2, _cmd, 256 \
  arrbuild __gRCXCmd.Command, RCX_RemoteOp, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXEvent(_src, _value) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _value, 0xFF \
  div __RCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_DirectEventOp, _src, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXPlayTone(_freq, _duration) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _freq, 0xFF \
  div __RCSTmpByte2, _freq, 256 \
  arrbuild __gRCXCmd.Command, RCX_PlayToneOp, __RCSTmpByte, __RCSTmpByte2, _duration \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSelectDisplay(_src, _value) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _value, 0xFF \
  div __RCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_DisplayOp, _src, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXPollMemory(_memaddress, _result) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _memaddress, 0xFF \
  div __RCSTmpByte2, _memaddress, 256 \
  arrbuild __gRCXCmd.Command, RCX_PollMemoryOp, __RCSTmpByte, __RCSTmpByte2, 1 \
  set __gRCXCmd.ResponseBytes, 16 \
  call __HTRCXCommandSub \
  index _result, __gRCXCmd.Response, 7 \
  index __RCSTmpByte, __gRCXCmd.Response, 5 \
  mul _result, _result, 256 \
  add _result, _result, __RCSTmpByte \
  release __RCXCmdMutex

#define __HTRCXSetEvent(_evt, _src, _type) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SetEventOp, _evt, _src, _type \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetGlobalOutput(_outputs, _mode) \
  acquire __RCXCmdMutex \
  add __RCSTmpByte, _outputs, _mode \
  arrbuild __gRCXCmd.Command, RCX_GOutputModeOp, __RCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetGlobalDirection(_outputs, _dir) \
  acquire __RCXCmdMutex \
  add __RCSTmpByte, _outputs, _dir \
  arrbuild __gRCXCmd.Command, RCX_GOutputDirOp, __RCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_GOutputPowerOp, _outputs, _pwrsrc, _pwrval \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXIncCounter(_counter) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_IncCounterOp, _counter \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXDecCounter(_counter) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DecCounterOp, _counter \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXClearCounter(_counter) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ClearCounterOp, _counter \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetPriority(_p) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SetPriorityOp, _p \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetMessage(_msg) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_MessageOp, _msg \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSetScoutMode(_mode) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ScoutOp, _mode \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSendVLL(_src, _value) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_VLLOp, _src, _value \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSetSensorClickTime(_src, _value) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _value, 0xFF \
  div __RCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSBlinkTimeOp, _src, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSetSensorHysteresis(_src, _value) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _value, 0xFF \
  div __RCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSHysteresisOp, _src, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSetSensorLowerLimit(_src, _value) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _value, 0xFF \
  div __RCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSLowerThreshOp, _src, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSetSensorUpperLimit(_src, _value) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _value, 0xFF \
  div __RCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSUpperThreshOp, _src, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSetEventFeedback(_src, _value) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _value, 0xFF \
  div __RCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_SetFeedbackOp, _src, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutMuteSound() \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SoundOp, 0x80 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutUnmuteSound() \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SoundOp, 0xc0 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSelectSounds(_grp) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SoundOp, _grp \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSetLight(_x) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_LightOp, _x \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#endif

/**
 * HTPowerFunctionCommand function.
 * Execute a pair of Power Function motor commands on the specified channel
 * using the HiTechnic iRLink device. Commands for outa and outb are
 * \ref PF_CMD_STOP, \ref PF_CMD_REV, \ref PF_CMD_FWD, and \ref PF_CMD_BRAKE.
 * Valid channels are \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _outa The Power Function command for output A. See \ref PFCmdConstants.
 * \param _outb The Power Function command for output B. See \ref PFCmdConstants.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPowerFunctionCommand(_port, _channel, _outa, _outb, _result) \
  __HTPFComboDirect(_port, _channel, _outa, _outb, _result)

/**
 * HTIRTrain function.
 * Control an IR Train receiver set to the specified channel using the
 * HiTechnic iRLink device. Valid func values are \ref TRAIN_FUNC_STOP,
 * \ref TRAIN_FUNC_INCR_SPEED, \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT.
 * Valid channel values are \ref TRAIN_CHANNEL_1 through \ref TRAIN_CHANNEL_3 and
 * \ref TRAIN_CHANNEL_ALL. The port must be configured as a Lowspeed port before
 * using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The IR Train channel.  See \ref IRTrainChannels.
 * \param _func The IR Train function. See \ref IRTrainFuncs
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTIRTrain(_port, _channel, _func, _result) \
  __HTIRTrain(_port, _channel, _func, FALSE, _result)

/**
 * HTPFComboDirect function.
 * Execute a pair of Power Function motor commands on the specified channel
 * using the HiTechnic iRLink device. Commands for outa and outb are
 * \ref PF_CMD_STOP, \ref PF_CMD_REV, \ref PF_CMD_FWD, and \ref PF_CMD_BRAKE. Valid channels are
 * \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _outa The Power Function command for output A. See \ref PFCmdConstants.
 * \param _outb The Power Function command for output B. See \ref PFCmdConstants.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFComboDirect(_port, _channel, _outa, _outb, _result) \
  __HTPFComboDirect(_port, _channel, _outa, _outb, _result)

/**
 * HTPFComboPWM function.
 * Control the speed of both outputs on a Power Function receiver set to the
 * specified channel using the HiTechnic iRLink device. Valid output values
 * are \ref PF_PWM_FLOAT, \ref PF_PWM_FWD1, \ref PF_PWM_FWD2, \ref PF_PWM_FWD3, \ref PF_PWM_FWD4,
 * \ref PF_PWM_FWD5, \ref PF_PWM_FWD6, \ref PF_PWM_FWD7, \ref PF_PWM_BRAKE, \ref PF_PWM_REV7,
 * \ref PF_PWM_REV6, \ref PF_PWM_REV5, \ref PF_PWM_REV4, \ref PF_PWM_REV3, \ref PF_PWM_REV2, and
 * \ref PF_PWM_REV1. Valid channels are \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The
 * port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _outa The Power Function PWM command for output A. See \ref PFPWMOptions.
 * \param _outb The Power Function PWM command for output B. See \ref PFPWMOptions.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFComboPWM(_port, _channel, _outa, _outb, _result) \
  __HTPFComboPWM(_port, _channel, _outa, _outb, _result)

/**
 * HTPFRawOutput function.
 * Control a Power Function receiver set to the specified channel using the
 * HiTechnic iRLink device. Build the raw data stream using the 3 nibbles
 * (4 bit values). The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _nibble0 The first raw data nibble.
 * \param _nibble1 The second raw data nibble.
 * \param _nibble2 The third raw data nibble.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFRawOutput(_port, _nibble0, _nibble1, _nibble2, _result) \
  __HTPFRawOutput(_port, _nibble0, _nibble1, _nibble2, _result)

/**
 * HTPFRepeat function.
 * Repeat sending the last Power Function command using the HiTechnic
 * IRLink device. Specify the number of times to repeat the command and the
 * number of milliseconds of delay between each repetition. The port must be
 * configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _count The number of times to repeat the command.
 * \param _delay The number of milliseconds to delay between each repetition.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFRepeat(_port, _count, _delay, _result) \
  __HTPFRepeatLastCommand(_port, _count, _delay, _result)

/**
 * HTPFSingleOutputCST function.
 * Control a single output on a Power Function receiver set to the specified
 * channel using the HiTechnic iRLink device. Select the desired output
 * using \ref PF_OUT_A or \ref PF_OUT_B. Valid functions are \ref PF_CST_CLEAR1_CLEAR2,
 * \ref PF_CST_SET1_CLEAR2, \ref PF_CST_CLEAR1_SET2, \ref PF_CST_SET1_SET2,
 * \ref PF_CST_INCREMENT_PWM, \ref PF_CST_DECREMENT_PWM, \ref PF_CST_FULL_FWD,
 * \ref PF_CST_FULL_REV, and \ref PF_CST_TOGGLE_DIR. Valid channels are
 * \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _out The Power Function output. See \ref PFOutputs.
 * \param _func The Power Function CST function. See \ref PFCSTOptions.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFSingleOutputCST(_port, _channel, _out, _func, _result) \
  __HTPFSingleOutput(_port, _channel, _out, _func, TRUE, _result)

/**
 * HTPFSingleOutputPWM function.
 * Control the speed of a single output on a Power Function receiver set to
 * the specified channel using the HiTechnic iRLink device. Select the
 * desired output using \ref PF_OUT_A or \ref PF_OUT_B. Valid functions are
 * \ref PF_PWM_FLOAT, \ref PF_PWM_FWD1, \ref PF_PWM_FWD2, \ref PF_PWM_FWD3, \ref PF_PWM_FWD4,
 * \ref PF_PWM_FWD5, \ref PF_PWM_FWD6, \ref PF_PWM_FWD7, \ref PF_PWM_BRAKE, \ref PF_PWM_REV7,
 * \ref PF_PWM_REV6, \ref PF_PWM_REV5, \ref PF_PWM_REV4, \ref PF_PWM_REV3, \ref PF_PWM_REV2, and
 * \ref PF_PWM_REV1. Valid channels are \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The
 * port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _out The Power Function output. See \ref PFOutputs.
 * \param _func The Power Function PWM function. See \ref PFPWMOptions.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFSingleOutputPWM(_port, _channel, _out, _func, _result) \
  __HTPFSingleOutput(_port, _channel, _out, _func, FALSE, _result)

/**
 * HTPFSinglePin function.
 * Control a single pin on a Power Function receiver set to the specified
 * channel using the HiTechnic iRLink device. Select the desired output
 * using \ref PF_OUT_A or \ref PF_OUT_B.  Select the desired pin using \ref PF_PIN_C1 or
 * \ref PF_PIN_C2. Valid functions are \ref PF_FUNC_NOCHANGE, \ref PF_FUNC_CLEAR,
 * \ref PF_FUNC_SET, and \ref PF_FUNC_TOGGLE. Valid channels are \ref PF_CHANNEL_1 through
 * \ref PF_CHANNEL_4. Specify whether the mode by passing true (continuous) or
 * false (timeout) as the final parameter. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _out The Power Function output. See \ref PFOutputs.
 * \param _pin The Power Function pin. See \ref PFPinConstants.
 * \param _func The Power Function single pin function. See \ref PFPinFuncs.
 * \param _cont Control whether the mode is continuous or timeout.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFSinglePin(_port, _channel, _out, _pin, _func, _cont, _result) \
  __HTPFSinglePin(_port, _channel, _out, _pin, _func, _cont, _result)

/**
 * HTPFTrain function.
 * Control both outputs on a Power Function receiver set to the specified
 * channel using the HiTechnic iRLink device as if it were an IR Train
 * receiver. Valid function values are \ref TRAIN_FUNC_STOP, \ref TRAIN_FUNC_INCR_SPEED,
 * \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT. Valid channels are
 * \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _func The Power Function train function. See \ref IRTrainFuncs.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFTrain(_port, _channel, _func, _result) \
  __HTIRTrain(_port, _channel, _func, TRUE, _result)

/**
 * HTRCXSetIRLinkPort function.
 * Set the global port in advance of using the HTRCX* and HTScout* API
 * functions for sending RCX and Scout messages over the HiTechnic iRLink
 * device. The port must be configured as a Lowspeed port before using any of
 * the HiTechnic RCX and Scout iRLink functions.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 */
#define HTRCXSetIRLinkPort(_port) __HTRCXSetIRLinkPort(_port)

/**
 * HTRCXBatteryLevel function.
 * Send the BatteryLevel command to an RCX to read the current battery level.
 *
 * \param _result The RCX battery level.
 */
#define HTRCXBatteryLevel(_result) __HTRCXBatteryLevel(_result)

/**
 * HTRCXPoll function
 * Send the Poll command to an RCX to read a signed 2-byte value at the
 * specified source and value combination.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 * \param _result The value read from the specified port and value.
 */
#define HTRCXPoll(_src, _value, _result) __HTRCXPoll(_src, _value, _result)

/**
 * HTRCXPollMemory function.
 * Send the PollMemory command to an RCX.
 *
 * \param _memaddress The RCX memory address.
 * \param _result The value read from the specified address.
 */
#define HTRCXPollMemory(_memaddress, _result) __HTRCXPollMemory(_memaddress, _result)

/**
 * HTRCXAddToDatalog function.
 * Send the AddToDatalog command to an RCX.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define HTRCXAddToDatalog(_src, _value) __HTRCXAddToDatalog(_src, _value)

/**
 * HTRCXClearAllEvents function.
 * Send the ClearAllEvents command to an RCX.
 */
#define HTRCXClearAllEvents() __HTRCXOpNoArgs(RCX_ClearAllEventsOp)

/**
 * HTRCXClearCounter function.
 * Send the ClearCounter command to an RCX.
 *
 * \param _counter The counter to clear.
 */
#define HTRCXClearCounter(_counter) __HTRCXClearCounter(_counter)

/**
 * HTRCXClearMsg function.
 * Send the ClearMsg command to an RCX.
 */
#define HTRCXClearMsg() __HTRCXOpNoArgs(RCX_ClearMsgOp)

/**
 * HTRCXClearSensor function.
 * Send the ClearSensor command to an RCX.
 *
 * \param _port The RCX port number.
 */
#define HTRCXClearSensor(_port) __HTRCXClearSensor(_port)

/**
 * HTRCXClearSound function.
 * Send the ClearSound command to an RCX.
 */
#define HTRCXClearSound() __HTRCXOpNoArgs(RCX_ClearSoundOp)

/**
 * HTRCXClearTimer function.
 * Send the ClearTimer command to an RCX.
 *
 * \param _timer The timer to clear.
 */
#define HTRCXClearTimer(_timer) __HTRCXClearTimer(_timer)

/**
 * HTRCXCreateDatalog function.
 * Send the CreateDatalog command to an RCX.
 *
 * \param _size The new datalog size.
 */
#define HTRCXCreateDatalog(_size) __HTRCXCreateDatalog(_size)

/**
 * HTRCXDecCounter function.
 * Send the DecCounter command to an RCX.
 *
 * \param _counter The counter to decrement.
 */
#define HTRCXDecCounter(_counter) __HTRCXDecCounter(_counter)

/**
 * HTRCXDeleteSub function.
 * Send the DeleteSub command to an RCX.
 *
 * \param _s The subroutine number to delete.
 */
#define HTRCXDeleteSub(_s) __HTRCXDeleteSub(_s)

/**
 * HTRCXDeleteSubs function.
 * Send the DeleteSubs command to an RCX.
 */
#define HTRCXDeleteSubs() __HTRCXOpNoArgs(RCX_DeleteSubsOp)

/**
 * HTRCXDeleteTask function.
 * Send the DeleteTask command to an RCX.
 *
 * \param _t The task number to delete.
 */
#define HTRCXDeleteTask(_t) __HTRCXDeleteTask(_t)

/**
 * HTRCXDeleteTasks function.
 * Send the DeleteTasks command to an RCX.
 */
#define HTRCXDeleteTasks() __HTRCXOpNoArgs(RCX_DeleteTasksOp)

/**
 * HTRCXDisableOutput function.
 * Send the DisableOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to disable. See \ref RCXOutputConstants.
 */
#define HTRCXDisableOutput(_outputs) __HTRCXSetGlobalOutput(_outputs, RCX_OUT_OFF)

/**
 * HTRCXEnableOutput function.
 * Send the EnableOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to enable. See \ref RCXOutputConstants.
 */
#define HTRCXEnableOutput(_outputs) __HTRCXSetGlobalOutput(_outputs, RCX_OUT_ON)

/**
 * HTRCXEvent function.
 * Send the Event command to an RCX.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define HTRCXEvent(_src, _value) __HTRCXEvent(_src, _value)

/**
 * HTRCXFloat function.
 * Send commands to an RCX to float the specified outputs.
 *
 * \param _outputs The RCX output(s) to float. See \ref RCXOutputConstants.
 */
#define HTRCXFloat(_outputs) __HTRCXSetOutput(_outputs, RCX_OUT_FLOAT)

/**
 * HTRCXFwd function.
 * Send commands to an RCX to set the specified outputs to the forward direction.
 *
 * \param _outputs The RCX output(s) to set forward. See \ref RCXOutputConstants.
 */
#define HTRCXFwd(_outputs) __HTRCXSetDirection(_outputs, RCX_OUT_FWD)

/**
 * HTRCXIncCounter function.
 * Send the IncCounter command to an RCX.
 *
 * \param _counter The counter to increment.
 */
#define HTRCXIncCounter(_counter) __HTRCXIncCounter(_counter)

/**
 * HTRCXInvertOutput function.
 * Send the InvertOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to invert. See \ref RCXOutputConstants.
 */
#define HTRCXInvertOutput(_outputs) __HTRCXSetGlobalDirection(_outputs, RCX_OUT_REV)

/**
 * HTRCXMuteSound function.
 * Send the MuteSound command to an RCX.
 */
#define HTRCXMuteSound() __HTRCXOpNoArgs(RCX_MuteSoundOp)

/**
 * HTRCXObvertOutput function.
 * Send the ObvertOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to obvert. See \ref RCXOutputConstants.
 */
#define HTRCXObvertOutput(_outputs) __HTRCXSetGlobalDirection(_outputs, RCX_OUT_FWD)

/**
 * HTRCXOff function.
 * Send commands to an RCX to turn off the specified outputs.
 *
 * \param _outputs The RCX output(s) to turn off. See \ref RCXOutputConstants.
 */
#define HTRCXOff(_outputs) __HTRCXSetOutput(_outputs, RCX_OUT_OFF)

/**
 * HTRCXOn function.
 * Send commands to an RCX to turn on the specified outputs.
 *
 * \param _outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 */
#define HTRCXOn(_outputs) __HTRCXSetOutput(_outputs, RCX_OUT_ON)

/**
 * HTRCXOnFor function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction for the specified duration.
 *
 * \param _outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 * \param _ms The number of milliseconds to leave the outputs on
 */
#define HTRCXOnFor(_outputs, _ms) __HTRCXOnFor(_outputs, _ms)

/**
 * HTRCXOnFwd function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction.
 *
 * \param _outputs The RCX output(s) to turn on in the forward direction. See \ref RCXOutputConstants.
 */
#define HTRCXOnFwd(_outputs) __HTRCXOnFwd(_outputs)

/**
 * HTRCXOnRev function.
 * Send commands to an RCX to turn on the specified outputs in the reverse direction.
 *
 * \param _outputs The RCX output(s) to turn on in the reverse direction. See \ref RCXOutputConstants.
 */
#define HTRCXOnRev(_outputs) __HTRCXOnRev(_outputs)

/**
 * HTRCXPBTurnOff function.
 * Send the PBTurnOff command to an RCX.
 */
#define HTRCXPBTurnOff() __HTRCXOpNoArgs(RCX_PBTurnOffOp)

/**
 * HTRCXPing function.
 * Send the Ping command to an RCX.
 */
#define HTRCXPing() __HTRCXOpNoArgs(RCX_PingOp)

/**
 * HTRCXPlaySound function.
 * Send the PlaySound command to an RCX.
 *
 * \param _snd The sound number to play.
 */
#define HTRCXPlaySound(_snd) __HTRCXPlaySound(_snd)

/**
 * HTRCXPlayTone function.
 * Send the PlayTone command to an RCX.
 *
 * \param _freq The frequency of the tone to play.
 * \param _duration The duration of the tone to play.
 */
#define HTRCXPlayTone(_freq, _duration) __HTRCXPlayTone(_freq, _duration)

/**
 * HTRCXPlayToneVar function.
 * Send the PlayToneVar command to an RCX.
 *
 * \param _varnum The variable containing the tone frequency to play.
 * \param _duration The duration of the tone to play.
 */
#define HTRCXPlayToneVar(_varnum, _duration) __HTRCXPlayToneVar(_varnum, _duration)

/**
 * HTRCXRemote function.
 * Send the Remote command to an RCX.
 *
 * \param _cmd The RCX IR remote command to send. See \ref RCXRemoteConstants.
 */
#define HTRCXRemote(_cmd) __HTRCXRemote(_cmd)

/**
 * HTRCXRev function.
 * Send commands to an RCX to set the specified outputs to the reverse direction.
 *
 * \param _outputs The RCX output(s) to reverse direction. See \ref RCXOutputConstants.
 */
#define HTRCXRev(_outputs) __HTRCXSetDirection(_outputs, RCX_OUT_REV)

/**
 * HTRCXSelectDisplay function.
 * Send the SelectDisplay command to an RCX.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define HTRCXSelectDisplay(_src, _value) __HTRCXSelectDisplay(_src, _value)

/**
 * HTRCXSelectProgram function.
 * Send the SelectProgram command to an RCX.
 *
 * \param _prog The program number to select.
 */
#define HTRCXSelectProgram(_prog) __HTRCXSelectProgram(_prog)

/**
 * HTRCXSendSerial function.
 * Send the SendSerial command to an RCX.
 *
 * \param _first The first byte address.
 * \param _count The number of bytes to send.
 */
#define HTRCXSendSerial(_first, _count) __HTRCXSendSerial(_first, _count)

/**
 * HTRCXSetDirection function.
 * Send the SetDirection command to an RCX to configure the direction of the specified outputs.
 *
 * \param _outputs The RCX output(s) to set direction. See \ref RCXOutputConstants.
 * \param _dir The RCX output direction. See \ref RCXOutputDirection.
 */
#define HTRCXSetDirection(_outputs, _dir) __HTRCXSetDirection(_outputs, _dir)

/**
 * HTRCXSetEvent function.
 * Send the SetEvent command to an RCX.
 *
 * \param _evt The event number to set.
 * \param _src The RCX source. See \ref RCXSourceConstants.
 * \param _type The event type.
 */
#define HTRCXSetEvent(_evt, _src, _type) __HTRCXSetEvent(_evt, _src, _type)

/**
 * HTRCXSetGlobalDirection function.
 * Send the SetGlobalDirection command to an RCX.
 *
 * \param _outputs The RCX output(s) to set global direction. See \ref RCXOutputConstants.
 * \param _dir The RCX output direction. See \ref RCXOutputDirection.
 */
#define HTRCXSetGlobalDirection(_outputs, _dir) __HTRCXSetGlobalDirection(_outputs, _dir)

/**
 * HTRCXSetGlobalOutput function.
 * Send the SetGlobalOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to set global mode. See \ref RCXOutputConstants.
 * \param _mode The RCX output mode. See \ref RCXOutputMode.
 */
#define HTRCXSetGlobalOutput(_outputs, _mode) __HTRCXSetGlobalOutput(_outputs, _mode)

/**
 * HTRCXSetMaxPower function.
 * Send the SetMaxPower command to an RCX.
 *
 * \param _outputs The RCX output(s) to set max power. See \ref RCXOutputConstants.
 * \param _pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param _pwrval The RCX value.
 */
#define HTRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) __HTRCXSetMaxPower(_outputs, _pwrsrc, _pwrval)

/**
 * HTRCXSetMessage function.
 * Send the SetMessage command to an RCX.
 *
 * \param _msg The numeric message to send.
 */
#define HTRCXSetMessage(_msg) __HTRCXSetMessage(_msg)

/**
 * HTRCXSetOutput function.
 * Send the SetOutput command to an RCX to configure the mode of the specified outputs
 *
 * \param _outputs The RCX output(s) to set mode. See \ref RCXOutputConstants.
 * \param _mode The RCX output mode. See \ref RCXOutputMode.
 */
#define HTRCXSetOutput(_outputs, _mode) __HTRCXSetOutput(_outputs, _mode)

/**
 * HTRCXSetPower function.
 * Send the SetPower command to an RCX to configure the power level of the specified outputs.
 *
 * \param _outputs The RCX output(s) to set power. See \ref RCXOutputConstants.
 * \param _pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param _pwrval The RCX value.
 */
#define HTRCXSetPower(_outputs, _pwrsrc, _pwrval) __HTRCXSetPower(_outputs, _pwrsrc, _pwrval)

/**
 * HTRCXSetPriority function.
 * Send the SetPriority command to an RCX.
 *
 * \param _p The new task priority.
 */
#define HTRCXSetPriority(_p) __HTRCXSetPriority(_p)

/**
 * HTRCXSetSensorMode function.
 * Send the SetSensorMode command to an RCX.
 *
 * \param _port The RCX sensor port.
 * \param _mode The RCX sensor mode.
 */
#define HTRCXSetSensorMode(_port, _mode) __HTRCXSetSensorMode(_port, _mode)

/**
 * HTRCXSetSensorType function.
 * Send the SetSensorType command to an RCX.
 *
 * \param _port The RCX sensor port.
 * \param _type The RCX sensor type.
 */
#define HTRCXSetSensorType(_port, _type) __HTRCXSetSensorType(_port, _type)

/**
 * HTRCXSetSleepTime function.
 * Send the SetSleepTime command to an RCX.
 *
 * \param _t The new sleep time value.
 */
#define HTRCXSetSleepTime(_t) __HTRCXSetSleepTime(_t)

/**
 * HTRCXSetTxPower function.
 * Send the SetTxPower command to an RCX.
 *
 * \param _pwr The IR transmit power level.
 */
#define HTRCXSetTxPower(_pwr) __HTRCXSetTxPower(_pwr)

/**
 * HTRCXSetWatch function.
 * Send the SetWatch command to an RCX.
 *
 * \param _hours The new watch time hours value.
 * \param _minutes The new watch time minutes value.
 */
#define HTRCXSetWatch(_hours, _minutes) __HTRCXSetWatch(_hours, _minutes)

/**
 * HTRCXStartTask function.
 * Send the StartTask command to an RCX.
 *
 * \param _t The task number to start.
 */
#define HTRCXStartTask(_t) __HTRCXStartTask(_t)

/**
 * HTRCXStopAllTasks function.
 * Send the StopAllTasks command to an RCX.
 */
#define HTRCXStopAllTasks() __HTRCXOpNoArgs(RCX_StopAllTasksOp)

/**
 * HTRCXStopTask function.
 * Send the StopTask command to an RCX.
 *
 * \param _t The task number to stop.
 */
#define HTRCXStopTask(_t) __HTRCXStopTask(_t)

/**
 * HTRCXToggle function.
 * Send commands to an RCX to toggle the direction of the specified outputs.
 *
 * \param _outputs The RCX output(s) to toggle. See \ref RCXOutputConstants.
 */
#define HTRCXToggle(_outputs) __HTRCXSetDirection(_outputs, RCX_OUT_TOGGLE)

/**
 * HTRCXUnmuteSound function.
 * Send the UnmuteSound command to an RCX.
 */
#define HTRCXUnmuteSound() __HTRCXOpNoArgs(RCX_UnmuteSoundOp)

/**
 * HTScoutCalibrateSensor function.
 * Send the CalibrateSensor command to a Scout.
 */
#define HTScoutCalibrateSensor() __HTRCXOpNoArgs(RCX_LSCalibrateOp)

/**
 * HTScoutMuteSound function.
 * Send the MuteSound command to a Scout.
 */
#define HTScoutMuteSound() __HTScoutMuteSound()

/**
 * HTScoutSelectSounds function.
 * Send the SelectSounds command to a Scout.
 *
 * \param _grp The Scout sound group to select.
 */
#define HTScoutSelectSounds(_grp) __HTScoutSelectSounds(_grp)

/**
 * HTScoutSendVLL function.
 * Send the SendVLL command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define HTScoutSendVLL(_src, _value) __HTScoutSendVLL(_src, _value)

/**
 * HTScoutSetEventFeedback function.
 * Send the SetEventFeedback command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define HTScoutSetEventFeedback(_src, _value) __HTScoutSetEventFeedback(_src, _value)

/**
 * HTScoutSetLight function.
 * Send the SetLight command to a Scout.
 *
 * \param _x Set the light on or off using this value. See \ref ScoutLightConstants.
 */
#define HTScoutSetLight(_x) __HTScoutSetLight(_x)

/**
 * HTScoutSetScoutMode function.
 * Send the SetScoutMode command to a Scout.
 *
 * \param _mode Set the scout mode. See \ref ScoutModeConstants.
*/
#define HTScoutSetScoutMode(_mode) __HTScoutSetScoutMode(_mode)

/**
 * HTScoutSetSensorClickTime function.
 * Send the SetSensorClickTime command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define HTScoutSetSensorClickTime(_src, _value) __HTScoutSetSensorClickTime(_src, _value)

/**
 * HTScoutSetSensorHysteresis function.
 * Send the SetSensorHysteresis command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define HTScoutSetSensorHysteresis(_src, _value) __HTScoutSetSensorHysteresis(_src, _value)

/**
 * HTScoutSetSensorLowerLimit function.
 * Send the SetSensorLowerLimit command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define HTScoutSetSensorLowerLimit(_src, _value) __HTScoutSetSensorLowerLimit(_src, _value)

/**
 * HTScoutSetSensorUpperLimit function.
 * Send the SetSensorUpperLimit command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define HTScoutSetSensorUpperLimit(_src, _value) __HTScoutSetSensorUpperLimit(_src, _value)

/**
 * HTScoutUnmuteSound function.
 * Send the UnmuteSound command to a Scout.
 */
#define HTScoutUnmuteSound() __HTScoutUnmuteSound()

/** @} */ // end of HiTechnicIRLinkAPI group

/** @} */ // end of HiTechnicAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // NBC_HITECHNIC_IRLINK_H
