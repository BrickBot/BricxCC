/** \file nbc_mindsensors_nrlink.h
 * \brief The NBC mindsensors.com NRLink API
 *
 * nbc_mindsensors_nrlink.h contains the NBC mindsensors.com NRLink API
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

#ifndef NBC_MINDSENSORS_NRLINK_H
#define NBC_MINDSENSORS_NRLINK_H

#include "mindsensors_constants.h"
#include "rcxapi_constants.h"
#include "nbc_lowspeed.h"
#include "nbc_rcxapi.h"


/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @addtogroup MindSensorsAPI
 * @{
 */

///////////////////////////////////////////////////////////////////////////////
/////////////////////////// MindSensors NRLINK API ////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup MindSensorsNRLinkAPI
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

#define __RunNRLinkMacro(_port, _i2caddr, _macro, _result) \
  acquire __WDSCmutex \
  mov __WDSC_Port, _port \
  mov __WDSC_SensorAddress, _i2caddr \
  arrbuild __WDSC_WriteBytes, NRLINK_CMD_RUN_MACRO, _macro \
  call __I2CWriteBytesSub \
  mov _result, __WDSC_LSStatus \
  release __WDSCmutex

#define __ReadNRLinkStatus(_port, _i2caddr, _value, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, I2C_REG_CMD \
  set __RLSBytesCountVar, 1 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _value, __RLSReadBufVar, NA \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, I2C_REG_CMD \
  set __RLSBytesCount##_port, 1 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _value, __RLSReadBuf##_port, NA \
  release __RLSBmutex##_port \
  compend

#define __WriteNRLinkBytes(_port, _i2caddr, _bytes, _result) \
  __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_FLUSH, _result) \
  __I2CWriteToRegister(_port, _i2caddr, NRLINK_REG_DATA, _bytes, _result) \
  arrsize __WDSC_ByteCount, _bytes \
  __I2CWriteToRegister(_port, _i2caddr, NRLINK_REG_BYTES, __WDSC_ByteCount, _result)

#define __ReadNRLinkBytes(_port, _i2caddr, _bytes, _result) \
  acquire __DNRVmutex \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, NRLINK_REG_BYTES \
  set __RLSBytesCountVar, 1 \
  call __ReadLSBytesVar \
  index __RLSBytesCountVar, __RLSReadBufVar, NA \
  arrbuild __RLSReadBufVar, _i2caddr, NRLINK_REG_DATA \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  mov _bytes, __RLSReadBufVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, NRLINK_REG_BYTES \
  set __RLSBytesCount##_port, 1 \
  call __ReadLSBytes##_port \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, NA \
  arrbuild __RLSReadBuf##_port, _i2caddr, NRLINK_REG_DATA \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  mov _bytes, __RLSReadBuf##_port \
  release __RLSBmutex##_port \
  compend \
  __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_FLUSH, _result) \
  release __DNRVmutex

dseg segment
  __MSPFByte1 byte
  __MSPFByte2 byte
dseg ends

subroutine __MSPowerFunctionCalcBytes
  call __PFCalcChecksum
  // build __PFBytes using two values calculated from the __PFNibbles
  index __MSPFByte1, __PFNibbles, NA
  index __PFTmp, __PFNibbles, 1
  mul __MSPFByte1, __MSPFByte1, 16
  add __MSPFByte1, __MSPFByte1, __PFTmp
  index __MSPFByte2, __PFNibbles, 2
  index __PFTmp, __PFNibbles, 3
  mul __MSPFByte2, __MSPFByte2, 16
  add __MSPFByte2, __MSPFByte2, __PFTmp
  arrbuild __PFBytes, __MSPFByte1, __MSPFByte2
  return
ends

#define __MSPFComboDirect(_port, _i2caddr, _channel, _outa, _outb, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _outa, 4 \
  mod __PF_p3, _outb, 4 \
  call __PFComboDirectSub \
  set __PFPowerFuncMode, TRUE \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _i2caddr, __PFBytes, _result) \
  release __PFMutex

#define __MSPFSinglePin(_port, _i2caddr, _channel, _out, _pin, _func, _cont, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _out, 2 \
  mod __PF_p3, _pin, 2 \
  mod __PF_p4, _func, 4 \
  set __PF_p5, _cont \
  call __PFSinglePinSub \
  set __PFPowerFuncMode, TRUE \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _i2caddr, __PFBytes, _result) \
  release __PFMutex

#define __MSPFSingleOutput(_port, _i2caddr, _channel, _out, _func, _cst, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _out, 2 \
  mod __PF_p3, _func, 16 \
  set __PF_p4, _cst \
  call __PFSingleOutputSub \
  set __PFPowerFuncMode, TRUE \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _i2caddr, __PFBytes, _result) \
  release __PFMutex

#define __MSPFComboPWM(_port, _i2caddr, _channel, _outa, _outb, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _outa, 16 \
  mod __PF_p3, _outb, 16 \
  call __PFComboPWMSub \
  set __PFPowerFuncMode, TRUE \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _i2caddr, __PFBytes, _result) \
  release __PFMutex

#define __MSIRTrain(_port, _i2caddr, _channel, _func, _PFMode, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _func, 5 \
  compif EQ, _PFMode, TRUE \
  call __PFTrainSub \
  compelse \
  call __RCTrainSub \
  compend \
  set __PFPowerFuncMode, _PFMode \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _i2caddr, __PFBytes, _result) \
  release __PFMutex

#define __MSPFRawOutput(_port, _i2caddr, _nibble0, _nibble1, _nibble2, _result) \
  acquire __PFMutex \
  mod __PF_p1, _nibble0, 16 \
  mod __PF_p2, _nibble1, 16 \
  mod __PF_p3, _nibble2, 16 \
  call __PFRawOutputSub \
  set __PFPowerFuncMode, TRUE \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _i2caddr, __PFBytes, _result) \
  release __PFMutex

#define __MSPFRepeatLastCommand(_port, _i2caddr, _count, _delay, _result) \
  acquire __PFMutex \
  mov __PF_p1, _count \
  __MSPFRepeatLoop##__I__: \
  __WriteNRLinkBytes(_port, _i2caddr, __PFBytes, _result) \
  waitv _delay \
  sub __PF_p1, __PF_p1, 1 \
  brtst GT, __MSPFRepeatLoop##__I__, __PF_p1 \
  release __PFMutex \
  __IncI__

subroutine __MSRCXCommandSub
  dseg segment
    __MSRCSToggle byte
    __MSRCSI byte
    __MSRCSInCmd byte[]
    __MSRCSTmpBuf byte[]
    __MSRCSCmdBytes sbyte
    __MSRCSCmd byte
    __MSRCSCSum byte
    __MSRCSMsgBufSize byte
    __MSRCSTmpByte byte
    __MSRCSTmpSByte sbyte
    __MSRCSTmpWord word
    __MSRCSTmpByte2 byte
    __MSRCSResult byte
  dseg ends
  arrsize __MSRCSCmdBytes, __gRCXCmd.Command
  index __MSRCSCmd, __gRCXCmd.Command, NA
  set __MSRCSCSum, 0

  // build the message
  set __MSRCSMsgBufSize, 2
  mul __MSRCSMsgBufSize, __MSRCSMsgBufSize, __MSRCSCmdBytes
  add __MSRCSMsgBufSize, __MSRCSMsgBufSize, 5

  arrinit __MSRCSInCmd, 0, __MSRCSMsgBufSize
  replace __MSRCSInCmd, __MSRCSInCmd, NA, 0x55
  replace __MSRCSInCmd, __MSRCSInCmd, 1, 0xFF
  replace __MSRCSInCmd, __MSRCSInCmd, 2, 0x00
  // add cmd and ~cmd bytes
  or __MSRCSTmpByte, __MSRCSCmd, __MSRCSToggle
  replace __MSRCSInCmd, __MSRCSInCmd, 3, __MSRCSTmpByte
  mov __MSRCSCSum, __MSRCSTmpByte
  sub __MSRCSTmpByte, 0xFF, __MSRCSCSum
  replace __MSRCSInCmd, __MSRCSInCmd, 4, __MSRCSTmpByte

  set __MSRCSI, 0
  xor __MSRCSToggle, __MSRCSToggle, 8

  brcmp LTEQ, __MSRCSEndWhileILTCmdBytes, __MSRCSCmdBytes, 1

__MSRCSWhileILTCmdBytes:
  sub __MSRCSTmpByte, __MSRCSCmdBytes, 1
  brcmp GTEQ, __MSRCSEndWhileILTCmdBytes, __MSRCSI, __MSRCSTmpByte
  add __MSRCSTmpByte, __MSRCSI, 1
  index __MSRCSTmpByte2, __gRCXCmd.Command, __MSRCSTmpByte
  mul __MSRCSTmpByte, __MSRCSI, 2
  add __MSRCSTmpByte, __MSRCSTmpByte, 5
  replace __MSRCSInCmd, __MSRCSInCmd, __MSRCSTmpByte, __MSRCSTmpByte2
  // calculate checksum
  add __MSRCSCSum, __MSRCSCSum, __MSRCSTmpByte2
  add __MSRCSTmpByte, __MSRCSTmpByte, 1
  sub __MSRCSTmpByte2, 255, __MSRCSTmpByte2
  replace __MSRCSInCmd, __MSRCSInCmd, __MSRCSTmpByte, __MSRCSTmpByte2
  add __MSRCSI, __MSRCSI, 1
  jmp __MSRCSWhileILTCmdBytes
__MSRCSEndWhileILTCmdBytes:

  // add the two checksum bytes
  mul __MSRCSTmpByte, __MSRCSI, 2
  add __MSRCSTmpByte, __MSRCSTmpByte, 5
  replace __MSRCSInCmd, __MSRCSInCmd, __MSRCSTmpByte, __MSRCSCSum
  sub __MSRCSTmpByte2, 255, __MSRCSCSum
  add __MSRCSTmpByte, __MSRCSTmpByte, 1
  replace __MSRCSInCmd, __MSRCSInCmd, __MSRCSTmpByte, __MSRCSTmpByte2

  // if the size of __MSRCSInCmd > 14 then we need to chunk up the transmission
  mov __MSRCSTmpSByte, __MSRCSMsgBufSize
__MSRCSWhileMsgBufSizeGTZero:
  arrsubset __gRCXCmd.Command, __MSRCSInCmd, NA, 14
  arrbuild __MSRCSTmpBuf, __gRCXCmd.Address, 0x42, __gRCXCmd.Command
  // write message bytes to the NRLink device
  __WriteNRLinkBytes(__gRCXCmd.Port, __gRCXCmd.Address, __MSRCSTmpBuf, __MSRCSResult)
  sub __MSRCSTmpSByte, __MSRCSTmpSByte, 14
  brtst LTEQ, __MSRCSEndWhileMsgBufSizeGTZero, __MSRCSTmpSByte
  arrsubset __MSRCSTmpBuf, __MSRCSInCmd, 14, NA
  mov __MSRCSInCmd, __MSRCSTmpBuf
  jmp __MSRCSWhileMsgBufSizeGTZero
__MSRCSEndWhileMsgBufSizeGTZero:

  // Now send the IR message
  arrbuild __MSRCSTmpBuf, __gRCXCmd.Address, 0x40, __MSRCSMsgBufSize
  __WriteNRLinkBytes(__gRCXCmd.Port, __gRCXCmd.Address, __MSRCSTmpBuf, __MSRCSResult)

  // give the message time to be transferred
  mul __MSRCSTmpWord, __MSRCSMsgBufSize, 5
  waitv __MSRCSTmpWord

  // do we need to read a response?
  brtst EQ, __MSRCSNoResponse, __gRCXCmd.ResponseBytes

  // give the message time to be transferred
  add __MSRCSTmpWord, __MSRCSMsgBufSize, __gRCXCmd.ResponseBytes
  mul __MSRCSTmpWord, __MSRCSTmpWord, 5
  waitv __MSRCSTmpWord

  // read the response
  __ReadNRLinkBytes(__gRCXCmd.Port, __gRCXCmd.Address, __gRCXCmd.Response, __MSRCSResult)

__MSRCSNoResponse:
  return
ends


#define __MSRCXSetNRLink(_port, _i2caddr) \
  set __gRCXCmd.Port, _port \
  set __gRCXCmd.Address, _i2caddr

#define __MSRCXPoll(_src, _value, _result) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_PollOp, _src, _value \
  set __gRCXCmd.ResponseBytes, 12 \
  call __MSRCXCommandSub \
  index _result, __gRCXCmd.Response, 4 \
  index __MSRCSTmpByte, __gRCXCmd.Response, 2 \
  mul _result, _result, 256 \
  add _result, _result, __MSRCSTmpByte \
  release __RCXCmdMutex

#define __MSRCXBatteryLevel(_result) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_BatteryLevelOp \
  set __gRCXCmd.ResponseBytes, 12 \
  call __MSRCXCommandSub \
  index _result, __gRCXCmd.Response, 4 \
  index __MSRCSTmpByte, __gRCXCmd.Response, 2 \
  mul _result, _result, 256 \
  add _result, _result, __MSRCSTmpByte \
  release __RCXCmdMutex

#define __MSRCXOpNoArgs(_op) \
  acquire __RCXCmdMutex \
  arrinit __gRCXCmd.Command, _op, 1 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetOutput(_outputs, _mode) \
  acquire __RCXCmdMutex \
  add __RCSTmpByte, _outputs, _mode \
  arrbuild __gRCXCmd.Command, RCX_OnOffFloatOp, __RCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetDirection(_outputs, _dir) \
  acquire __RCXCmdMutex \
  add __RCSTmpByte, _outputs, _dir \
  arrbuild __gRCXCmd.Command, RCX_OutputDirOp, __RCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetPower(_outputs, _pwrsrc, _pwrval) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_OutputPowerOp, _outputs, _pwrsrc, _pwrval \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXOnFwd(_outputs) \
  __MSRCXSetDirection(_outputs, RCX_OUT_FWD) \
  __MSRCXSetOutput(_outputs, RCX_OUT_ON)

#define __MSRCXOnRev(_outputs) \
  __MSRCXSetDirection(_outputs, RCX_OUT_REV) \
  __MSRCXSetOutput(_outputs, RCX_OUT_ON)

#define __MSRCXOnFor(_outputs, _ms) \
  __MSRCXSetOutput(_outputs, RCX_OUT_ON) \
  waitv _ms \
  __MSRCXSetOutput(_outputs, RCX_OUT_OFF)

#define __MSRCXSetTxPower(_pwr) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_IRModeOp, _pwr \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXPlaySound(_snd) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_PlaySoundOp, _snd \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXDeleteTask(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DeleteTaskOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXStartTask(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_StartTaskOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXStopTask(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_StopTaskOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSelectProgram(_prog) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SelectProgramOp, _prog \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXClearTimer(_timer) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ClearTimerOp, _timer \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetSleepTime(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_AutoOffOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXDeleteSub(_s) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DeleteSubOp, _s \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXClearSensor(_port) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ClearSensorOp, _port \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXPlayToneVar(_varnum, _duration) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_PlayToneVarOp, _varnum, _duration \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetWatch(_hours, _minutes) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SetWatchOp, _hours, _minutes \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetSensorType(_port, _type) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_InputTypeOp, _port, _type \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetSensorMode(_port, _mode) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_InputModeOp, _port, _mode \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXCreateDatalog(_size) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _size, 0xFF \
  div __MSRCSTmpByte2, _size, 256 \
  arrbuild __gRCXCmd.Command, RCX_SetDatalogOp, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXAddToDatalog(_src, _value) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DatalogOp, _src, _value \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSendSerial(_first, _count) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SendUARTDataOp, _first, _count \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXRemote(_cmd) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _cmd, 0xFF \
  div __MSRCSTmpByte2, _cmd, 256 \
  arrbuild __gRCXCmd.Command, RCX_RemoteOp, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXEvent(_src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_DirectEventOp, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXPlayTone(_freq, _duration) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _freq, 0xFF \
  div __MSRCSTmpByte2, _freq, 256 \
  arrbuild __gRCXCmd.Command, RCX_PlayToneOp, __MSRCSTmpByte, __MSRCSTmpByte2, _duration \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSelectDisplay(_src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_DisplayOp, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXPollMemory(_memaddress, _result) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _memaddress, 0xFF \
  div __MSRCSTmpByte2, _memaddress, 256 \
  arrbuild __gRCXCmd.Command, RCX_PollMemoryOp, __MSRCSTmpByte, __MSRCSTmpByte2, 1 \
  set __gRCXCmd.ResponseBytes, 12 \
  call __MSRCXCommandSub \
  index _result, __gRCXCmd.Response, 4 \
  index __MSRCSTmpByte, __gRCXCmd.Response, 2 \
  mul _result, _result, 256 \
  add _result, _result, __MSRCSTmpByte \
  release __RCXCmdMutex

#define __MSRCXSetEvent(_evt, _src, _type) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SetEventOp, _evt, _src, _type \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetGlobalOutput(_outputs, _mode) \
  acquire __RCXCmdMutex \
  add __MSRCSTmpByte, _outputs, _mode \
  arrbuild __gRCXCmd.Command, RCX_GOutputModeOp, __MSRCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetGlobalDirection(_outputs, _dir) \
  acquire __RCXCmdMutex \
  add __MSRCSTmpByte, _outputs, _dir \
  arrbuild __gRCXCmd.Command, RCX_GOutputDirOp, __MSRCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_GOutputPowerOp, _outputs, _pwrsrc, _pwrval \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXCalibrateEvent(_evt, _low, _hi, _hyst) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_CalibrateEventOp, _evt, _low, _hi, _hyst \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __RCXVarOp(_op, _vnum, _src, _val) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _val, 0xFF \
  div __MSRCSTmpByte2, _val, 256 \
  arrbuild __gRCXCmd.Command, _op, _vnum, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSet(_dstsrc, _dstval, _src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_SetSourceValueOp, _dstsrc, _dstval, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXUnlock() \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_UnlockOp, 1, 3, 5, 7, 11 \
  set __gRCXCmd.ResponseBytes, 16 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXReset() \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_BootModeOp, 1, 3, 5, 7, 11 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXBoot() \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_UnlockFirmOp, 0x4c, 0x45, 0x47, 0x4F, 0xAE \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetUserDisplay(_src, _value, _precision) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_ViewSourceValOp, 0, _precision, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXIncCounter(_counter) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_IncCounterOp, _counter \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXDecCounter(_counter) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DecCounterOp, _counter \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXClearCounter(_counter) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ClearCounterOp, _counter \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetPriority(_p) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SetPriorityOp, _p \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetMessage(_msg) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_MessageOp, _msg \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetScoutMode(_mode) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ScoutOp, _mode \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetScoutRules(_m, _t, _l, _tm, _fx) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ScoutRulesOp, _m, _t, _l, _tm, _fx \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSendVLL(_src, _value) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_VLLOp, _src, _value \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetSensorClickTime(_src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSBlinkTimeOp, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetSensorHysteresis(_src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSHysteresisOp, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetSensorLowerLimit(_src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSLowerThreshOp, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetSensorUpperLimit(_src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSUpperThreshOp, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetEventFeedback(_src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_SetFeedbackOp, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetCounterLimit(_ctr, _src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_SetCounterOp, _ctr, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetTimerLimit(_tmr, _src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_SetTimerLimitOp, _tmr, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutMuteSound() \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SoundOp, 0x80 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutUnmuteSound() \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SoundOp, 0xc0 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSelectSounds(_grp) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SoundOp, _grp \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetLight(_x) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_LightOp, _x \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#endif

/**
 * Configure NRLink in 2400 baud mode.
 * Configure the mindsensors NRLink device in 2400 baud mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLink2400(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_2400, _result)

/**
 * Configure NRLink in 4800 baud mode.
 * Configure the mindsensors NRLink device in 4800 baud mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLink4800(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_4800, _result)

/**
 * Flush NRLink buffers.
 * Flush the mindsensors NRLink device buffers. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLinkFlush(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_FLUSH, _result)

/**
 * Configure NRLink in IR long mode.
 * Configure the mindsensors NRLink device in IR long mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLinkIRLong(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_IR_LONG, _result)

/**
 * Configure NRLink in IR short mode.
 * Configure the mindsensors NRLink device in IR short mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLinkIRShort(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_IR_SHORT, _result)

/**
 * Configure NRLink in power function mode.
 * Configure the mindsensors NRLink device in power function mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLinkSetPF(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_SET_PF, _result)

/**
 * Configure NRLink in RCX mode.
 * Configure the mindsensors NRLink device in RCX mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLinkSetRCX(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_SET_RCX, _result)

/**
 * Configure NRLink in IR train mode.
 * Configure the mindsensors NRLink device in IR train mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLinkSetTrain(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_SET_TRAIN, _result)

/**
 * Configure NRLink in raw IR transmit mode.
 * Configure the mindsensors NRLink device in raw IR transmit mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLinkTxRaw(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_TX_RAW, _result)

/**
 * Read NRLink status.
 * Read the status of the mindsensors NRLink device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The mindsensors NRLink status.
 * \param _result The function call result.
 */
#define ReadNRLinkStatus(_port, _i2caddr, _value, _result) __ReadNRLinkStatus(_port, _i2caddr, _value, _result)

/**
 * Run NRLink macro.
 * Run the specified mindsensors NRLink device macro. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _macro The address of the macro to execute.
 * \param _result The function call result.
 */
#define RunNRLinkMacro(_port, _i2caddr, _macro, _result) __RunNRLinkMacro(_port, _i2caddr, _macro, _result)

/**
 * Write data to NRLink.
 * Write data to the mindsensors NRLink device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _bytes A byte array containing the data to write.
 * \param _result The function call result.
 */
#define WriteNRLinkBytes(_port, _i2caddr, _bytes, _result) __WriteNRLinkBytes(_port, _i2caddr, _bytes, _result)

/**
 * Read data from NRLink.
 * Read data from the mindsensors NRLink device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _bytes A byte array that will contain the data read from the device on output.
 * \param _result The function call result.
 */
#define ReadNRLinkBytes(_port, _i2caddr, _bytes, _result) __ReadNRLinkBytes(_port, _i2caddr, _bytes, _result)

/**
 * MSIRTrain function.
 * Control an IR Train receiver set to the specified channel using the
 * mindsensors NRLink device. Valid function values are \ref TRAIN_FUNC_STOP,
 * \ref TRAIN_FUNC_INCR_SPEED, \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT.
 * Valid channels are \ref TRAIN_CHANNEL_1 through \ref TRAIN_CHANNEL_3 and
 * \ref TRAIN_CHANNEL_ALL. The port must be configured as a Lowspeed port before
 * using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The IR Train channel.  See \ref IRTrainChannels.
 * \param _func The IR Train function. See \ref IRTrainFuncs
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSIRTrain(_port, _i2caddr, _channel, _func, _result) \
  __MSIRTrain(_port, _i2caddr, _channel, _func, FALSE, _result)

/**
 * MSPFComboDirect function.
 * Execute a pair of Power Function motor commands on the specified channel
 * using the mindsensors NRLink device. Commands for outa and outb are
 * PF_CMD_STOP, PF_CMD_REV, PF_CMD_FWD, and \ref PF_CMD_BRAKE. Valid channels are
 * PF_CHANNEL_1 through PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _outa The Power Function command for output A. See \ref PFCmdConstants.
 * \param _outb The Power Function command for output B. See \ref PFCmdConstants.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFComboDirect(_port, _i2caddr, _channel, _outa, _outb, _result) \
  __MSPFComboDirect(_port, _i2caddr, _channel, _outa, _outb, _result)

/**
 * MSPFComboPWM function.
 * Control the speed of both outputs on a Power Function receiver set to the
 * specified channel using the mindsensors NRLink device. Valid output values
 * are \ref PF_PWM_FLOAT, \ref PF_PWM_FWD1, \ref PF_PWM_FWD2, \ref PF_PWM_FWD3, \ref PF_PWM_FWD4,
 * \ref PF_PWM_FWD5, \ref PF_PWM_FWD6, \ref PF_PWM_FWD7, \ref PF_PWM_BRAKE, \ref PF_PWM_REV7,
 * \ref PF_PWM_REV6, \ref PF_PWM_REV5, \ref PF_PWM_REV4, \ref PF_PWM_REV3, \ref PF_PWM_REV2, and
 * \ref PF_PWM_REV1. Valid channels are \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The
 * port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _outa The Power Function PWM command for output A. See \ref PFPWMOptions.
 * \param _outb The Power Function PWM command for output B. See \ref PFPWMOptions.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFComboPWM(_port, _i2caddr, _channel, _outa, _outb, _result) \
  __MSPFComboPWM(_port, _i2caddr, _channel, _outa, _outb, _result)

/**
 * MSPFRawOutput function.
 * Control a Power Function receiver set to the specified channel using the
 * mindsensors NRLink device. Build the raw data stream using the 3 nibbles
 * (4 bit values). The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _nibble0 The first raw data nibble.
 * \param _nibble1 The second raw data nibble.
 * \param _nibble2 The third raw data nibble.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFRawOutput(_port, _i2caddr, _nibble0, _nibble1, _nibble2, _result) \
  __MSPFRawOutput(_port, _i2caddr, _nibble0, _nibble1, _nibble2, _result)

/**
 * MSPFRepeat function.
 * Repeat sending the last Power Function command using the mindsensors
 * NRLink device. Specify the number of times to repeat the command and the
 * number of milliseconds of delay between each repetition. The port must be
 * configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _count The number of times to repeat the command.
 * \param _delay The number of milliseconds to delay between each repetition.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFRepeat(_port, _i2caddr, _count, _delay, _result) \
  __MSPFRepeatLastCommand(_port, _i2caddr, _count, _delay, _result)

/**
 * MSPFSingleOutputCST function.
 * Control a single output on a Power Function receiver set to the specified
 * channel using the mindsensors NRLink device. Select the desired output
 * using \ref PF_OUT_A or \ref PF_OUT_B. Valid functions are \ref PF_CST_CLEAR1_CLEAR2,
 * \ref PF_CST_SET1_CLEAR2, \ref PF_CST_CLEAR1_SET2, \ref PF_CST_SET1_SET2,
 * \ref PF_CST_INCREMENT_PWM, \ref PF_CST_DECREMENT_PWM, \ref PF_CST_FULL_FWD,
 * \ref PF_CST_FULL_REV, and \ref PF_CST_TOGGLE_DIR. Valid channels are
 * \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _out The Power Function output. See \ref PFOutputs.
 * \param _func The Power Function CST function. See \ref PFCSTOptions.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFSingleOutputCST(_port, _i2caddr, _channel, _out, _func, _result) \
  __MSPFSingleOutput(_port, _i2caddr, _channel, _out, _func, TRUE, _result)

/**
 * MSPFSingleOutputPWM function.
 * Control the speed of a single output on a Power Function receiver set to
 * the specified channel using the mindsensors NRLink device. Select the
 * desired output using \ref PF_OUT_A or \ref PF_OUT_B. Valid functions are
 * \ref PF_PWM_FLOAT, \ref PF_PWM_FWD1, \ref PF_PWM_FWD2, \ref PF_PWM_FWD3, \ref PF_PWM_FWD4,
 * \ref PF_PWM_FWD5, \ref PF_PWM_FWD6, \ref PF_PWM_FWD7, \ref PF_PWM_BRAKE, \ref PF_PWM_REV7,
 * \ref PF_PWM_REV6, \ref PF_PWM_REV5, \ref PF_PWM_REV4, \ref PF_PWM_REV3, \ref PF_PWM_REV2, and
 * \ref PF_PWM_REV1. Valid channels are \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The
 * port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _out The Power Function output. See \ref PFOutputs.
 * \param _func The Power Function PWM function. See \ref PFPWMOptions.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFSingleOutputPWM(_port, _i2caddr, _channel, _out, _func, _result) \
  __MSPFSingleOutput(_port, _i2caddr, _channel, _out, _func, FALSE, _result)

/**
 * MSPFSinglePin function.
 * Control a single pin on a Power Function receiver set to the specified
 * channel using the mindsensors NRLink device. Select the desired output
 * using \ref PF_OUT_A or \ref PF_OUT_B.  Select the desired pin using \ref PF_PIN_C1 or
 * \ref PF_PIN_C2. Valid functions are \ref PF_FUNC_NOCHANGE, \ref PF_FUNC_CLEAR,
 * \ref PF_FUNC_SET, and \ref PF_FUNC_TOGGLE. Valid channels are \ref PF_CHANNEL_1 through
 * \ref PF_CHANNEL_4. Specify whether the mode by passing true (continuous) or
 * false (timeout) as the final parameter. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _out The Power Function output. See \ref PFOutputs.
 * \param _pin The Power Function pin. See \ref PFPinConstants.
 * \param _func The Power Function single pin function. See \ref PFPinFuncs.
 * \param _cont Control whether the mode is continuous or timeout.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFSinglePin(_port, _i2caddr, _channel, _out, _pin, _func, _cont, _result) \
  __MSPFSinglePin(_port, _i2caddr, _channel, _out, _pin, _func, _cont, _result)

/**
 * MSPFTrain function.
 * Control both outputs on a Power Function receiver set to the specified
 * channel using the mindsensors NRLink device as if it were an IR Train
 * receiver. Valid function values are \ref TRAIN_FUNC_STOP, \ref TRAIN_FUNC_INCR_SPEED,
 * \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT. Valid channels are
 * PF_CHANNEL_1 through PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _func The Power Function train function. See \ref IRTrainFuncs.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFTrain(_port, _i2caddr, _channel, _func, _result) \
  __MSIRTrain(_port, _i2caddr, _channel, _func, TRUE, _result)

/**
 * MSRCXSetIRLinkPort function.
 * Set the global port in advance of using the MSRCX* and MSScout* API
 * functions for sending RCX and Scout messages over the mindsensors NRLink
 * device. The port must be configured as a Lowspeed port before using any of
 * the mindsensors RCX and Scout NRLink functions.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 */
#define MSRCXSetNRLinkPort(_port, _i2caddr) __MSRCXSetNRLink(_port, _i2caddr)

/**
 * MSRCXBatteryLevel function.
 * Send the BatteryLevel command to an RCX to read the current battery level.
 *
 * \param _result The RCX battery level.
 */
#define MSRCXBatteryLevel(_result) __MSRCXBatteryLevel(_result)

/**
 * MSRCXPoll function.
 * Send the Poll command to an RCX to read a signed 2-byte value at the
 * specified source and value combination.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 * \param _result The value read from the specified port and value.
 */
#define MSRCXPoll(_src, _value, _result) __MSRCXPoll(_src, _value, _result)

/**
 * MSRCXPollMemory function.
 * Send the PollMemory command to an RCX.
 *
 * \param _memaddress The RCX memory address.
 * \param _result The value read from the specified address.
 */
#define MSRCXPollMemory(_memaddress, _result) __MSRCXPollMemory(_memaddress, _result)

/**
 * MSRCXAbsVar function.
 * Send the AbsVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXAbsVar(_varnum, _src, _value) __MSRCXVarOp(RCX_AbsVarOp, _varnum, _src, _value)

/**
 * MSRCXAddToDatalog function.
 * Send the AddToDatalog command to an RCX.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXAddToDatalog(_src, _value) __MSRCXAddToDatalog(_src, _value)

/**
 * MSRCXAndVar function.
 * Send the AndVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXAndVar(_varnum, _src, _value) __MSRCXVarOp(RCX_AndVarOp, _varnum, _src, _value)

/**
 * MSRCXBoot function.
 * Send the Boot command to an RCX.
 */
#define MSRCXBoot() __MSRCXBoot()

/**
 * MSRCXCalibrateEvent function.
 * Send the CalibrateEvent command to an RCX.
 *
 * \param _evt The event number.
 * \param _low The low threshold.
 * \param _hi The high threshold.
 * \param _hyst The hysterisis value.
 */
#define MSRCXCalibrateEvent(_evt, _low, _hi, _hyst) __MSRCXCalibrateEvent(_evt, _low, _hi, _hyst)

/**
 * MSRCXClearAllEvents function.
 * Send the ClearAllEvents command to an RCX.
 */
#define MSRCXClearAllEvents() __MSRCXOpNoArgs(RCX_ClearAllEventsOp)

/**
 * MSRCXClearCounter function.
 * Send the ClearCounter command to an RCX.
 *
 * \param _counter The counter to clear.
 */
#define MSRCXClearCounter(_counter) __MSRCXClearCounter(_counter)

/**
 * MSRCXClearMsg function.
 * Send the ClearMsg command to an RCX.
 */
#define MSRCXClearMsg() __MSRCXOpNoArgs(RCX_ClearMsgOp)

/**
 * MSRCXClearSensor function.
 * Send the ClearSensor command to an RCX.
 *
 * \param _port The RCX port number.
 */
#define MSRCXClearSensor(_port) __MSRCXClearSensor(_port)

/**
 * MSRCXClearSound function.
 * Send the ClearSound command to an RCX.
 */
#define MSRCXClearSound() __MSRCXOpNoArgs(RCX_ClearSoundOp)

/**
 * MSRCXClearTimer function.
 * Send the ClearTimer command to an RCX.
 *
 * \param _timer The timer to clear.
 */
#define MSRCXClearTimer(_timer) __MSRCXClearTimer(_timer)

/**
 * MSRCXCreateDatalog function.
 * Send the CreateDatalog command to an RCX.
 *
 * \param _size The new datalog size.
 */
#define MSRCXCreateDatalog(_size) __MSRCXCreateDatalog(_size)

/**
 * MSRCXDecCounter function.
 * Send the DecCounter command to an RCX.
 *
 * \param _counter The counter to decrement.
 */
#define MSRCXDecCounter(_counter) __MSRCXDecCounter(_counter)

/**
 * MSRCXDeleteSub function.
 * Send the DeleteSub command to an RCX.
 *
 * \param _s The subroutine number to delete.
 */
#define MSRCXDeleteSub(_s) __MSRCXDeleteSub(_s)

/**
 * MSRCXDeleteSubs function.
 * Send the DeleteSubs command to an RCX.
 */
#define MSRCXDeleteSubs() __MSRCXOpNoArgs(RCX_DeleteSubsOp)

/**
 * MSRCXDeleteTask function.
 * Send the DeleteTask command to an RCX.
 *
 * \param _t The task number to delete.
 */
#define MSRCXDeleteTask(_t) __MSRCXDeleteTask(_t)

/**
 * MSRCXDeleteTasks function.
 * Send the DeleteTasks command to an RCX.
 */
#define MSRCXDeleteTasks() __MSRCXOpNoArgs(RCX_DeleteTasksOp)

/**
 * MSRCXDisableOutput function.
 * Send the DisableOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to disable. See \ref RCXOutputConstants.
 */
#define MSRCXDisableOutput(_outputs) __MSRCXSetGlobalOutput(_outputs, RCX_OUT_OFF)

/**
 * MSRCXDivVar function.
 * Send the DivVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXDivVar(_varnum, _src, _value) __MSRCXVarOp(RCX_DivVarOp, _varnum, _src, _value)

/**
 * MSRCXEnableOutput function.
 * Send the EnableOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to enable. See \ref RCXOutputConstants.
 */
#define MSRCXEnableOutput(_outputs) __MSRCXSetGlobalOutput(_outputs, RCX_OUT_ON)

/**
 * MSRCXEvent function.
 * Send the Event command to an RCX.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXEvent(_src, _value) __MSRCXEvent(_src, _value)

/**
 * MSRCXFloat function.
 * Send commands to an RCX to float the specified outputs.
 *
 * \param _outputs The RCX output(s) to float. See \ref RCXOutputConstants.
 */
#define MSRCXFloat(_outputs) __MSRCXSetOutput(_outputs, RCX_OUT_FLOAT)

/**
 * MSRCXFwd function.
 * Send commands to an RCX to set the specified outputs to the forward direction.
 *
 * \param _outputs The RCX output(s) to set forward. See \ref RCXOutputConstants.
 */
#define MSRCXFwd(_outputs) __MSRCXSetDirection(_outputs, RCX_OUT_FWD)

/**
 * MSRCXIncCounter function.
 * Send the IncCounter command to an RCX.
 *
 * \param _counter The counter to increment.
 */
#define MSRCXIncCounter(_counter) __MSRCXIncCounter(_counter)

/**
 * MSRCXInvertOutput function.
 * Send the InvertOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to invert. See \ref RCXOutputConstants.
 */
#define MSRCXInvertOutput(_outputs) __MSRCXSetGlobalDirection(_outputs, RCX_OUT_REV)

/**
 * MSRCXMulVar function.
 * Send the MulVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXMulVar(_varnum, _src, _value) __MSRCXVarOp(RCX_MulVarOp, _varnum, _src, _value)

/**
 * MSRCXMuteSound function.
 * Send the MuteSound command to an RCX.
 */
#define MSRCXMuteSound() __MSRCXOpNoArgs(RCX_MuteSoundOp)

/**
 * MSRCXObvertOutput function.
 * Send the ObvertOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to obvert. See \ref RCXOutputConstants.
 */
#define MSRCXObvertOutput(_outputs) __MSRCXSetGlobalDirection(_outputs, RCX_OUT_FWD)

/**
 * MSRCXOff function.
 * Send commands to an RCX to turn off the specified outputs.
 *
 * \param _outputs The RCX output(s) to turn off. See \ref RCXOutputConstants.
 */
#define MSRCXOff(_outputs) __MSRCXSetOutput(_outputs, RCX_OUT_OFF)

/**
 * MSRCXOn function.
 * Send commands to an RCX to turn on the specified outputs.
 *
 * \param _outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 */
#define MSRCXOn(_outputs) __MSRCXSetOutput(_outputs, RCX_OUT_ON)

/**
 * MSRCXOnFor function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction for the specified duration.
 *
 * \param _outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 * \param _ms The number of milliseconds to leave the outputs on
 */
#define MSRCXOnFor(_outputs, _ms) __MSRCXOnFor(_outputs, _ms)

/**
 * MSRCXOnFwd function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction.
 *
 * \param _outputs The RCX output(s) to turn on in the forward direction. See \ref RCXOutputConstants.
 */
#define MSRCXOnFwd(_outputs) __MSRCXOnFwd(_outputs)

/**
 * MSRCXOnRev function.
 * Send commands to an RCX to turn on the specified outputs in the reverse direction.
 *
 * \param _outputs The RCX output(s) to turn on in the reverse direction. See \ref RCXOutputConstants.
 */
#define MSRCXOnRev(_outputs) __MSRCXOnRev(_outputs)

/**
 * MSRCXOrVar function.
 * Send the OrVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXOrVar(_varnum, _src, _value) __MSRCXVarOp(RCX_OrVarOp, _varnum, _src, _value)

/**
 * MSRCXPBTurnOff function.
 * Send the PBTurnOff command to an RCX.
 */
#define MSRCXPBTurnOff() __MSRCXOpNoArgs(RCX_PBTurnOffOp)

/**
 * MSRCXPing function.
 * Send the Ping command to an RCX.
 */
#define MSRCXPing() __MSRCXOpNoArgs(RCX_PingOp)

/**
 * MSRCXPlaySound function.
 * Send the PlaySound command to an RCX.
 *
 * \param _snd The sound number to play.
 */
#define MSRCXPlaySound(_snd) __MSRCXPlaySound(_snd)

/**
 * MSRCXPlayTone function.
 * Send the PlayTone command to an RCX.
 *
 * \param _freq The frequency of the tone to play.
 * \param _duration The duration of the tone to play.
 */
#define MSRCXPlayTone(_freq, _duration) __MSRCXPlayTone(_freq, _duration)

/**
 * MSRCXPlayToneVar function.
 * Send the PlayToneVar command to an RCX.
 *
 * \param _varnum The variable containing the tone frequency to play.
 * \param _duration The duration of the tone to play.
 */
#define MSRCXPlayToneVar(_varnum, _duration) __MSRCXPlayToneVar(_varnum, _duration)

/**
 * MSRCXRemote function.
 * Send the Remote command to an RCX.
 *
 * \param _cmd The RCX IR remote command to send. See \ref RCXRemoteConstants.
 */
#define MSRCXRemote(_cmd) __MSRCXRemote(_cmd)

/**
 * MSRCXReset function.
 * Send the Reset command to an RCX.
 */
#define MSRCXReset() __MSRCXReset()

/**
 * MSRCXRev function.
 * Send commands to an RCX to set the specified outputs to the reverse direction.
 *
 * \param _outputs The RCX output(s) to reverse direction. See \ref RCXOutputConstants.
 */
#define MSRCXRev(_outputs) __MSRCXSetDirection(_outputs, RCX_OUT_REV)

/**
 * MSRCXSelectDisplay function.
 * Send the SelectDisplay command to an RCX.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXSelectDisplay(_src, _value) __MSRCXSelectDisplay(_src, _value)

/**
 * MSRCXSelectProgram function.
 * Send the SelectProgram command to an RCX.
 *
 * \param _prog The program number to select.
 */
#define MSRCXSelectProgram(_prog) __MSRCXSelectProgram(_prog)

/**
 * MSRCXSendSerial function.
 * Send the SendSerial command to an RCX.
 *
 * \param _first The first byte address.
 * \param _count The number of bytes to send.
 */
#define MSRCXSendSerial(_first, _count) __MSRCXSendSerial(_first, _count)

/**
 * MSRCXSet function.
 * Send the Set command to an RCX.
 *
 * \param _dstsrc The RCX destination source.  See \ref RCXSourceConstants.
 * \param _dstval The RCX destination value.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXSet(_dstsrc, _dstval, _src, _value) __MSRCXSet(_dstsrc, _dstval, _src, _value)

/**
 * MSRCXSetDirection function.
 * Send the SetDirection command to an RCX to configure the direction of the specified outputs.
 *
 * \param _outputs The RCX output(s) to set direction. See \ref RCXOutputConstants.
 * \param _dir The RCX output direction. See \ref RCXOutputDirection.
 */
#define MSRCXSetDirection(_outputs, _dir) __MSRCXSetDirection(_outputs, _dir)

/**
 * MSRCXSetEvent function.
 * Send the SetEvent command to an RCX.
 *
 * \param _evt The event number to set.
 * \param _src The RCX source. See \ref RCXSourceConstants.
 * \param _type The event type.
 */
#define MSRCXSetEvent(_evt, _src, _type) __MSRCXSetEvent(_evt, _src, _type)

/**
 * MSRCXSetGlobalDirection function.
 * Send the SetGlobalDirection command to an RCX.
 *
 * \param _outputs The RCX output(s) to set global direction. See \ref RCXOutputConstants.
 * \param _dir The RCX output direction. See \ref RCXOutputDirection.
 */
#define MSRCXSetGlobalDirection(_outputs, _dir) __MSRCXSetGlobalDirection(_outputs, _dir)

/**
 * MSRCXSetGlobalOutput function.
 * Send the SetGlobalOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to set global mode. See \ref RCXOutputConstants.
 * \param _mode The RCX output mode. See \ref RCXOutputMode.
 */
#define MSRCXSetGlobalOutput(_outputs, _mode) __MSRCXSetGlobalOutput(_outputs, _mode)

/**
 * MSRCXSetMaxPower function.
 * Send the SetMaxPower command to an RCX.
 *
 * \param _outputs The RCX output(s) to set max power. See \ref RCXOutputConstants.
 * \param _pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param _pwrval The RCX value.
 */
#define MSRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) __MSRCXSetMaxPower(_outputs, _pwrsrc, _pwrval)

/**
 * MSRCXSetMessage function.
 * Send the SetMessage command to an RCX.
 *
 * \param _msg The numeric message to send.
 */
#define MSRCXSetMessage(_msg) __MSRCXSetMessage(_msg)

/**
 * MSRCXSetOutput function.
 * Send the SetOutput command to an RCX to configure the mode of the specified outputs
 *
 * \param _outputs The RCX output(s) to set mode. See \ref RCXOutputConstants.
 * \param _mode The RCX output mode. See \ref RCXOutputMode.
 */
#define MSRCXSetOutput(_outputs, _mode) __MSRCXSetOutput(_outputs, _mode)

/**
 * MSRCXSetPower function.
 * Send the SetPower command to an RCX to configure the power level of the specified outputs.
 *
 * \param _outputs The RCX output(s) to set power. See \ref RCXOutputConstants.
 * \param _pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param _pwrval The RCX value.
 */
#define MSRCXSetPower(_outputs, _pwrsrc, _pwrval) __MSRCXSetPower(_outputs, _pwrsrc, _pwrval)

/**
 * MSRCXSetPriority function.
 * Send the SetPriority command to an RCX.
 *
 * \param _p The new task priority.
 */
#define MSRCXSetPriority(_p) __MSRCXSetPriority(_p)

/**
 * MSRCXSetSensorMode function.
 * Send the SetSensorMode command to an RCX.
 *
 * \param _port The RCX sensor port.
 * \param _mode The RCX sensor mode.
 */
#define MSRCXSetSensorMode(_port, _mode) __MSRCXSetSensorMode(_port, _mode)

/**
 * MSRCXSetSensorType function.
 * Send the SetSensorType command to an RCX.
 *
 * \param _port The RCX sensor port.
 * \param _type The RCX sensor type.
 */
#define MSRCXSetSensorType(_port, _type) __MSRCXSetSensorType(_port, _type)

/**
 * MSRCXSetSleepTime function.
 * Send the SetSleepTime command to an RCX.
 *
 * \param _t The new sleep time value.
 */
#define MSRCXSetSleepTime(_t) __MSRCXSetSleepTime(_t)

/**
 * MSRCXSetTxPower function.
 * Send the SetTxPower command to an RCX.
 *
 * \param _pwr The IR transmit power level.
 */
#define MSRCXSetTxPower(_pwr) __MSRCXSetTxPower(_pwr)

/**
 * MSRCXSetUserDisplay function.
 * Send the SetUserDisplay command to an RCX.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 * \param _precision The number of digits of precision.
 */
#define MSRCXSetUserDisplay(_src, _value, _precision) __MSRCXSetUserDisplay(_src, _value, _precision)

/**
 * MSRCXSetVar function.
 * Send the SetVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXSetVar(_varnum, _src, _value) __MSRCXVarOp(RCX_SetVarOp, _varnum, _src, _value)

/**
 * MSRCXSetWatch function.
 * Send the SetWatch command to an RCX.
 *
 * \param _hours The new watch time hours value.
 * \param _minutes The new watch time minutes value.
 */
#define MSRCXSetWatch(_hours, _minutes) __MSRCXSetWatch(_hours, _minutes)

/**
 * MSRCXSgnVar function.
 * Send the SgnVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXSgnVar(_varnum, _src, _value) __MSRCXVarOp(RCX_SgnVarOp, _varnum, _src, _value)

/**
 * MSRCXStartTask function.
 * Send the StartTask command to an RCX.
 *
 * \param _t The task number to start.
 */
#define MSRCXStartTask(_t) __MSRCXStartTask(_t)

/**
 * MSRCXStopAllTasks function.
 * Send the StopAllTasks command to an RCX.
 */
#define MSRCXStopAllTasks() __MSRCXOpNoArgs(RCX_StopAllTasksOp)

/**
 * MSRCXStopTask function.
 * Send the StopTask command to an RCX.
 *
 * \param _t The task number to stop.
 */
#define MSRCXStopTask(_t) __MSRCXStopTask(_t)

/**
 * MSRCXSubVar function.
 * Send the SubVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXSubVar(_varnum, _src, _value) __MSRCXVarOp(RCX_SubVarOp, _varnum, _src, _value)

/**
 * MSRCXSumVar function.
 * Send the SumVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXSumVar(_varnum, _src, _value) __MSRCXVarOp(RCX_SumVarOp, _varnum, _src, _value)

/**
 * MSRCXToggle function.
 * Send commands to an RCX to toggle the direction of the specified outputs.
 *
 * \param _outputs The RCX output(s) to toggle. See \ref RCXOutputConstants.
 */
#define MSRCXToggle(_outputs) __MSRCXSetDirection(_outputs, RCX_OUT_TOGGLE)

/**
 * MSRCXUnlock function.
 * Send the Unlock command to an RCX.
 */
#define MSRCXUnlock() __MSRCXUnlock()

/**
 * MSRCXUnmuteSound function.
 * Send the UnmuteSound command to an RCX.
 */
#define MSRCXUnmuteSound() __MSRCXOpNoArgs(RCX_UnmuteSoundOp)

/**
 * MSScoutCalibrateSensor function.
 * Send the CalibrateSensor command to a Scout.
 */
#define MSScoutCalibrateSensor() __MSRCXOpNoArgs(RCX_LSCalibrateOp)

/**
 * MSScoutMuteSound function.
 * Send the MuteSound command to a Scout.
 */
#define MSScoutMuteSound() __MSScoutMuteSound()

/**
 * MSScoutSelectSounds function.
 * Send the SelectSounds command to a Scout.
 *
 * \param _grp The Scout sound group to select.
 */
#define MSScoutSelectSounds(_grp) __MSScoutSelectSounds(_grp)

/**
 * MSScoutSendVLL function.
 * Send the SendVLL command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSendVLL(_src, _value) __MSScoutSendVLL(_src, _value)

/**
 * MSScoutSetCounterLimit function.
 * Send the SetCounterLimit command to a Scout.
 *
 * \param _ctr The counter for which to set the limit.
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSetCounterLimit(_ctr, _src, _value) __MSScoutSetCounterLimit(_ctr, _src, _value)

/**
 * MSScoutSetEventFeedback function.
 * Send the SetEventFeedback command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSetEventFeedback(_src, _value) __MSScoutSetEventFeedback(_src, _value)

/**
 * MSScoutSetLight function.
 * Send the SetLight command to a Scout.
 *
 * \param _x Set the light on or off using this value. See \ref ScoutLightConstants.
 */
#define MSScoutSetLight(_x) __MSScoutSetLight(_x)

/**
 * MSScoutSetScoutMode function.
 * Send the SetScoutMode command to a Scout.
 *
 * \param _mode Set the scout mode. See \ref ScoutModeConstants.
*/
#define MSScoutSetScoutMode(_mode) __MSScoutSetScoutMode(_mode)

/**
 * MSScoutSetScoutRules function.
 * Send the SetScoutRules command to a Scout.
 *
 * \param _m Scout motion rule. See \ref ScoutMotionRuleConstants.
 * \param _t Scout touch rule. See \ref ScoutTouchRuleConstants.
 * \param _l Scout light rule. See \ref ScoutLightRuleConstants.
 * \param _tm Scout transmit rule. See \ref ScoutTransmitRuleConstants.
 * \param _fx Scout special effects rule. See \ref ScoutSpecialEffectConstants.
 */
#define MSScoutSetScoutRules(_m, _t, _l, _tm, _fx) __MSScoutSetScoutRules(_m, _t, _l, _tm, _fx)

/**
 * MSScoutSetSensorClickTime function.
 * Send the SetSensorClickTime command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSetSensorClickTime(_src, _value) __MSScoutSetSensorClickTime(_src, _value)

/**
 * MSScoutSetSensorHysteresis function.
 * Send the SetSensorHysteresis command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSetSensorHysteresis(_src, _value) __MSScoutSetSensorHysteresis(_src, _value)

/**
 * MSScoutSetSensorLowerLimit function.
 * Send the SetSensorLowerLimit command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSetSensorLowerLimit(_src, _value) __MSScoutSetSensorLowerLimit(_src, _value)

/**
 * MSScoutSetSensorUpperLimit function.
 * Send the SetSensorUpperLimit command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSetSensorUpperLimit(_src, _value) __MSScoutSetSensorUpperLimit(_src, _value)

/**
 * MSScoutSetTimerLimit function.
 * Send the SetTimerLimit command to a Scout.
 *
 * \param _tmr The timer for which to set a limit.
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSetTimerLimit(_tmr, _src, _value) __MSScoutSetTimerLimit(_tmr, _src, _value)

/**
 * MSScoutUnmuteSound function.
 * Send the UnmuteSound command to a Scout.
 */
#define MSScoutUnmuteSound() __MSScoutUnmuteSound()

/** @} */ // end of MindSensorsNRLinkAPI group

/** @} */ // end of MindSensorsAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // NBC_MINDSENSORS_NRLINK_H
