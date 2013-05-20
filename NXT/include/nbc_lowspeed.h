/** \file nbc_lowspeed.h
 * \brief The NBC lowspeed module API
 *
 * nbc_lowspeed.h contains the NBC lowspeed module API
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

#ifndef NBC_LOWSPEED_H
#define NBC_LOWSPEED_H

#include "lowspeed_constants.h"
#include "nbc_command.h"

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// LOWSPEED MODULE ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup LowSpeedModule
 * @{
 */
/** @defgroup LowSpeedModuleFunctions LowSpeed module functions
 * Functions for accessing and modifying low speed module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

dseg segment
// CommLSWrite
TCommLSWrite	struct
 Result		sbyte
 Port		byte
 Buffer		byte[]
 ReturnLen	byte
TCommLSWrite	ends

// CommLSRead
TCommLSRead	struct
 Result		sbyte
 Port		byte
 Buffer		byte[]
 BufferLen	byte
TCommLSRead	ends

// CommLSCheckStatus
TCommLSCheckStatus	struct
 Result		sbyte
 Port		byte
 BytesReady	byte
TCommLSCheckStatus	ends

  __WDSC_lswArgs TCommLSWrite
  __RDSD_lswArgs TCommLSWrite
  __RDSD_lsrArgs TCommLSRead

  __lsModuleOffsetMutex mutex
  __WDSCmutex mutex
  __DNRVmutex mutex

  __RLSBbufLSWrite1 byte[] 0x02, 0x42
  __RSEMeterLSBuf byte[] 0x04, 0x0A
  __RSTempLSBuf byte[] 0x98, 0x00
  __RSTempRaw slong

  __lsModuleOffset word
  __WDSC_LSB byte
  __WDSC_MSB byte
  __WDSC_Port byte
  __WDSC_WriteBytes byte[]
  __WDSC_SensorAddress byte
  __WDSC_SensorRegister byte
  __WDSC_ByteCount byte
  __WDSC_LSStatus sbyte
  __WDSC_Result sbyte
  __RDSD_Port byte
  __RDSD_SensorAddress byte
  __RDSD_SensorRegister byte
  __RDSD_NumBytesToRead byte
  __RDSD_Value sdword
  __RDSD_LSStatus sbyte
  __RDSD_bytesRead sdword
  __RDSD_PreviousValue sdword
  __RDSD_Byte byte
dseg ends

dseg segment
// port 0
  __CLSCSArgs0 TCommLSCheckStatus
  __CLSCSMutex0 mutex
  __CLSWArgs0 TCommLSWrite
  __CLSWMutex0 mutex
  __CLSRArgs0 TCommLSRead
  __CLSRMutex0 mutex
// port 1
  __CLSCSArgs1 TCommLSCheckStatus
  __CLSCSMutex1 mutex
  __CLSWArgs1 TCommLSWrite
  __CLSWMutex1 mutex
  __CLSRArgs1 TCommLSRead
  __CLSRMutex1 mutex
// port 2
  __CLSCSArgs2 TCommLSCheckStatus
  __CLSCSMutex2 mutex
  __CLSWArgs2 TCommLSWrite
  __CLSWMutex2 mutex
  __CLSRArgs2 TCommLSRead
  __CLSRMutex2 mutex
// port 3
  __CLSCSArgs3 TCommLSCheckStatus
  __CLSCSMutex3 mutex
  __CLSWArgs3 TCommLSWrite
  __CLSWMutex3 mutex
  __CLSRArgs3 TCommLSRead
  __CLSRMutex3 mutex
  __LSWriteOptions byte[] 0x00, 0x00, 0x00, 0x00
  __LSWriteOptionsVar byte
dseg ends

#define __ReadI2CBytes(_port, _inbuf, _count, _outbuf, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  set __RLSPadVar, 0 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, _inbuf \
  mov __RLSBytesCountVar, _count \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  mov _count, __RLSBytesCountVar \
  mov _outbuf, __RLSReadBufVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  set __RLSPad##_port, 0 \
  mov __RLSReadBuf##_port, _inbuf \
  mov __RLSBytesCount##_port, _count \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  mov _count, __RLSBytesCount##_port \
  mov _outbuf, __RLSReadBuf##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorUS(_port, _value, _wait) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 1 \
  set __RLSPadVar, 1 \
  waitv _wait \
  call __ReadLSBytesVar \
  index _value, __RLSReadBufVar, NA \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 1 \
  set __RLSPad##_port, 1 \
  waitv _wait \
  call __ReadLSBytes##_port \
  index _value, __RLSReadBuf##_port, NA \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorUSEx(_port, _values, _result, _wait) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 8 \
  set __RLSPadVar, 8 \
  waitv _wait \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  mov _values, __RLSReadBufVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 8 \
  set __RLSPad##_port, 8 \
  waitv _wait \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  mov _values, __RLSReadBuf##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorEMeter(_port, _vIn, _aIn, _vOut, _aOut, _joules, _wIn, _wOut, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RSEMeterLSBuf \
  set __RLSBytesCountVar, 14 \
  set __RLSPadVar, 14 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index __RLSBytesCountVar, __RLSReadBufVar, NA \
  index _vIn, __RLSReadBufVar, 1 \
  mul _vIn, _vIn, 256 \
  add _vIn, _vIn, __RLSBytesCountVar \
  div _vIn, _vIn, 1000 \
  index __RLSBytesCountVar, __RLSReadBufVar, 2 \
  index _aIn, __RLSReadBufVar, 3 \
  mul _aIn, _aIn, 256 \
  add _aIn, _aIn, __RLSBytesCountVar \
  div _aIn, _aIn, 1000 \
  index __RLSBytesCountVar, __RLSReadBufVar, 4 \
  index _vOut, __RLSReadBufVar, 5 \
  mul _vOut, _vOut, 256 \
  add _vOut, _vOut, __RLSBytesCountVar \
  div _vOut, _vOut, 1000 \
  index __RLSBytesCountVar, __RLSReadBufVar, 6 \
  index _aOut, __RLSReadBufVar, 7 \
  mul _aOut, _aOut, 256 \
  add _aOut, _aOut, __RLSBytesCountVar \
  div _aOut, _aOut, 1000 \
  index __RLSBytesCountVar, __RLSReadBufVar, 8 \
  index _joules, __RLSReadBufVar, 9 \
  mul _joules, _joules, 256 \
  add _joules, _joules, __RLSBytesCountVar \
  index __RLSBytesCountVar, __RLSReadBufVar, 10 \
  index _wIn, __RLSReadBufVar, 11 \
  mul _wIn, _wIn, 256 \
  add _wIn, _wIn, __RLSBytesCountVar \
  div _wIn, _wIn, 1000 \
  index __RLSBytesCountVar, __RLSReadBufVar, 12 \
  index _wOut, __RLSReadBufVar, 13 \
  mul _wOut, _wOut, 256 \
  add _wOut, _wOut, __RLSBytesCountVar \
  div _wOut, _wOut, 1000 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RSEMeterLSBuf \
  set __RLSBytesCount##_port, 14 \
  set __RLSPad##_port, 14 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, NA \
  index _vIn, __RLSReadBuf##_port, 1 \
  mul _vIn, _vIn, 256 \
  add _vIn, _vIn, __RLSBytesCount##_port \
  div _vIn, _vIn, 1000 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 2 \
  index _aIn, __RLSReadBuf##_port, 3 \
  mul _aIn, _aIn, 256 \
  add _aIn, _aIn, __RLSBytesCount##_port \
  div _aIn, _aIn, 1000 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 4 \
  index _vOut, __RLSReadBuf##_port, 5 \
  mul _vOut, _vOut, 256 \
  add _vOut, _vOut, __RLSBytesCount##_port \
  div _vOut, _vOut, 1000 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 6 \
  index _aOut, __RLSReadBuf##_port, 7 \
  mul _aOut, _aOut, 256 \
  add _aOut, _aOut, __RLSBytesCount##_port \
  div _aOut, _aOut, 1000 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 8 \
  index _joules, __RLSReadBuf##_port, 9 \
  mul _joules, _joules, 256 \
  add _joules, _joules, __RLSBytesCount##_port \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 10 \
  index _wIn, __RLSReadBuf##_port, 11 \
  mul _wIn, _wIn, 256 \
  add _wIn, _wIn, __RLSBytesCount##_port \
  div _wIn, _wIn, 1000 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 12 \
  index _wOut, __RLSReadBuf##_port, 13 \
  mul _wOut, _wOut, 256 \
  add _wOut, _wOut, __RLSBytesCount##_port \
  div _wOut, _wOut, 1000 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorTemperature(_port, _temp) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RSTempLSBuf \
  set __RLSBytesCountVar, 2 \
  set __RLSPadVar, 2 \
  call __ReadLSBytesVar \
  index __RSTempRaw, __RLSReadBufVar, NA \
  index __RLSBytesCountVar, __RLSReadBufVar, 1 \
  mul __RSTempRaw, __RSTempRaw, 256 \
  add __RSTempRaw, __RSTempRaw, __RLSBytesCountVar \
  mul __RSTempRaw, __RSTempRaw, 10 \
  div __RSTempRaw, __RSTempRaw, 16 \
  div _temp, __RSTempRaw, 16 \
  brcmp LTEQ, __RRT_EndIf##__I__, __RSTempRaw, 20470 \
  sub _temp, _temp, 2560 \
  __RRT_EndIf##__I__: \
  __IncI__ \
  brcmp NEQ, __RRT_FloatEndIf##__I__, typeof(_temp), 10 \
  div _temp, _temp, 10 \
  __RRT_FloatEndIf##__I__: \
  __IncI__ \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RSTempLSBuf \
  set __RLSBytesCount##_port, 2 \
  set __RLSPad##_port, 2 \
  call __ReadLSBytes##_port \
  index __RSTempRaw, __RLSReadBuf##_port, NA \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 1 \
  mul __RSTempRaw, __RSTempRaw, 256 \
  add __RSTempRaw, __RSTempRaw, __RLSBytesCount##_port \
  mul __RSTempRaw, __RSTempRaw, 10 \
  div __RSTempRaw, __RSTempRaw, 16 \
  div _temp, __RSTempRaw, 16 \
  brcmp LTEQ, __RRT_EndIf##__I__, __RSTempRaw, 20470 \
  sub _temp, _temp, 2560 \
  __RRT_EndIf##__I__: \
  __IncI__ \
  brcmp NEQ, __RRT_FloatEndIf##__I__, typeof(_temp), 10 \
  div _temp, _temp, 10 \
  __RRT_FloatEndIf##__I__: \
  __IncI__ \
  release __RLSBmutex##_port \
  compend

#define __getLSInputBuffer(_p, _offset, _cnt, _data) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetLowSpeedModuleBytes(LowSpeedOffsetInBufBuf(_p)+_offset, _cnt, _data) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, _offset \
  GetLowSpeedModuleBytes(__lsModuleOffset, _cnt, _data) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSInputBufferInPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getLowSpeedModuleValue(LowSpeedOffsetInBufInPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 16 \
  __getLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSInputBufferOutPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getLowSpeedModuleValue(LowSpeedOffsetInBufOutPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 17 \
  __getLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSInputBufferBytesToRx(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getLowSpeedModuleValue(LowSpeedOffsetInBufBytesToRx(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 18 \
  __getLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __getLSOutputBuffer(_p, _offset, _cnt, _data) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetLowSpeedModuleBytes(LowSpeedOffsetOutBufBuf(_p)+_offset, _cnt, _data) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 76 \
  add __lsModuleOffset, __lsModuleOffset, _offset \
  GetLowSpeedModuleBytes(__lsModuleOffset, _cnt, _data) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSOutputBufferInPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getLowSpeedModuleValue(LowSpeedOffsetOutBufInPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 92 \
  __getLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSOutputBufferOutPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getLowSpeedModuleValue(LowSpeedOffsetOutBufOutPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 93 \
  __getLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSOutputBufferBytesToRx(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getLowSpeedModuleValue(LowSpeedOffsetOutBufBytesToRx(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 94 \
  __getLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSMode(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getLowSpeedModuleValue(LowSpeedOffsetMode(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  add __lsModuleOffset, _p, 152 \
  __getLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSChannelState(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getLowSpeedModuleValue(LowSpeedOffsetChannelState(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  add __lsModuleOffset, _p, 156 \
  __getLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSErrorType(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __getLowSpeedModuleValue(LowSpeedOffsetErrorType(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  add __lsModuleOffset, _p, 160 \
  __getLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSState(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getLowSpeedModuleValue(LowSpeedOffsetState, _n)

#define __GetLSSpeed(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getLowSpeedModuleValue(LowSpeedOffsetSpeed, _n)

#ifdef __ENHANCED_FIRMWARE

#define __GetLSNoRestartOnRead(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getLowSpeedModuleValue(LowSpeedOffsetNoRestartOnRead, _n)

#endif

#define __setLSInputBuffer(_p, _offset, _cnt, _data) \
  compif EQ, isconst(_p+_offset), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __SetLowSpeedModuleBytes(LowSpeedOffsetInBufBuf(_p)+_offset, _cnt, _data) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, _offset \
  __SetLowSpeedModuleBytes(__lsModuleOffset, _cnt, _data) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSOutputBuffer(_p, _offset, _cnt, _data) \
  compif EQ, isconst(_p+_offset), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __SetLowSpeedModuleBytes(LowSpeedOffsetInBufBuf(_p)+_offset, _cnt, _data) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 76 \
  add __lsModuleOffset, __lsModuleOffset, _offset \
  __SetLowSpeedModuleBytes(__lsModuleOffset, _cnt, _data) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSInputBufferInPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __SetLowSpeedModuleValue(LowSpeedOffsetInBufInPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 16 \
  __SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSInputBufferOutPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __SetLowSpeedModuleValue(LowSpeedOffsetInBufOutPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 17 \
  __SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSInputBufferBytesToRx(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __SetLowSpeedModuleValue(LowSpeedOffsetInBufBytesToRx(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 18 \
  __SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSOutputBufferInPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __SetLowSpeedModuleValue(LowSpeedOffsetOutBufInPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 92 \
  __SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSOutputBufferOutPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __SetLowSpeedModuleValue(LowSpeedOffsetOutBufOutPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 93 \
  __SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSOutputBufferBytesToRx(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __SetLowSpeedModuleValue(LowSpeedOffsetOutBufBytesToRx(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 94 \
  __SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSMode(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __SetLowSpeedModuleValue(LowSpeedOffsetMode(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  add __lsModuleOffset, _p, 152 \
  __SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSChannelState(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __SetLowSpeedModuleValue(LowSpeedOffsetChannelState(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  add __lsModuleOffset, _p, 156 \
  __SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSErrorType(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  __SetLowSpeedModuleValue(LowSpeedOffsetErrorType(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  add __lsModuleOffset, _p, 160 \
  __SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSState(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetLowSpeedModuleValue(LowSpeedOffsetState, _n)

#define __setLSSpeed(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetLowSpeedModuleValue(LowSpeedOffsetSpeed, _n)

#ifdef __ENHANCED_FIRMWARE
#define __setLSNoRestartOnRead(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetLowSpeedModuleValue(LowSpeedOffsetNoRestartOnRead, _n)
#endif

#define __ReadI2CDeviceInfo(_port, _i2caddr, _info, _strVal) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  set __RLSPadVar, 0 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, _info \
  set __RLSBytesCountVar, 8 \
  call __ReadLSBytesVar \
  arrtostr _strVal, __RLSReadBufVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  set __RLSPad##_port, 0 \
  arrbuild __RLSReadBuf##_port, _i2caddr, _info \
  set __RLSBytesCount##_port, 8 \
  call __ReadLSBytes##_port \
  arrtostr _strVal, __RLSReadBuf##_port \
  release __RLSBmutex##_port \
  compend

#define __I2CWriteToRegister(_port, _i2caddr, _reg, _bytes, _result) \
  acquire __WDSCmutex \
  mov __WDSC_Port, _port \
  mov __WDSC_SensorAddress, _i2caddr \
  set __WDSC_SensorRegister, _reg \
  compif EQ, valueof(_bytes), NA \
  arrinit __WDSC_WriteBytes, 0, 0 \
  compelse \
  arrbuild __WDSC_WriteBytes, _bytes \
  compend \
  call __I2CReadBEValueSub \
  mov _result, __WDSC_LSStatus \
  release __WDSCmutex

#define __I2CWriteLEIntToRegister(_port, _i2caddr, _reg, _ival, _result) \
  acquire __WDSCmutex \
  mov __WDSC_Port, _port \
  mov __WDSC_SensorAddress, _i2caddr \
  set __WDSC_SensorRegister, _reg \
  and __WDSC_LSB, _ival, 0xFF \
  div __WDSC_MSB, _ival, 0xFF \
  arrbuild __WDSC_WriteBytes, __WDSC_LSB, __WDSC_MSB \
  call __I2CReadBEValueSub \
  mov _result, __WDSC_LSStatus \
  release __WDSCmutex

#define __I2CSendCmd(_port, _i2caddr, _cmd, _result) \
  __I2CWriteToRegister(_port, _i2caddr, I2C_REG_CMD, _cmd, _result)

#define __TempSendCmd(_port, _cmd, _result) \
  __I2CWriteToRegister(_port, LEGO_ADDR_TEMP, TEMP_REG_CONFIG, _cmd, _result)

#define __I2CReadValue(_port, _i2caddr, _reg, _bytes, _out, _result) \
  acquire __DNRVmutex \
  mov __RDSD_Port, _port \
  mov __RDSD_SensorAddress, _i2caddr \
  mov __RDSD_SensorRegister, _reg \
  set __RDSD_NumBytesToRead, _bytes \
  call __I2CReadLEValueSub \
  mov _out, __RDSD_Value \
  mov _result, __RDSD_LSStatus \
  release __DNRVmutex

#define __I2CReadBEValue(_port, _i2caddr, _reg, _bytes, _out, _result) \
  acquire __DNRVmutex \
  mov __RDSD_Port, _port \
  mov __RDSD_SensorAddress, _i2caddr \
  mov __RDSD_SensorRegister, _reg \
  set __RDSD_NumBytesToRead, _bytes \
  call __I2CReadBEValueSub \
  mov _out, __RDSD_Value \
  mov _result, __RDSD_LSStatus \
  release __DNRVmutex

#define __lowspeedStatus(_port, _bready, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSCSMutex0 \
  acquire __CLSCSMutex1 \
  acquire __CLSCSMutex2 \
  acquire __CLSCSMutex3 \
  mov __CLSCSArgs0.Port, _port \
  syscall CommLSCheckStatus, __CLSCSArgs0 \
  mov _bready, __CLSCSArgs0.BytesReady \
  mov _result, __CLSCSArgs0.Result \
  release __CLSCSMutex0 \
  release __CLSCSMutex1 \
  release __CLSCSMutex2 \
  release __CLSCSMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSCSMutex##_port \
  set __CLSCSArgs##_port.Port, _port \
  syscall CommLSCheckStatus, __CLSCSArgs##_port \
  mov _bready, __CLSCSArgs##_port.BytesReady \
  mov _result, __CLSCSArgs##_port.Result \
  release __CLSCSMutex##_port \
  compend

#define __lowspeedCheckStatus(_port, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSCSMutex0 \
  acquire __CLSCSMutex1 \
  acquire __CLSCSMutex2 \
  acquire __CLSCSMutex3 \
  mov __CLSCSArgs0.Port, _port \
  syscall CommLSCheckStatus, __CLSCSArgs0 \
  mov _result, __CLSCSArgs0.Result \
  release __CLSCSMutex0 \
  release __CLSCSMutex1 \
  release __CLSCSMutex2 \
  release __CLSCSMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSCSMutex##_port \
  set __CLSCSArgs##_port.Port, _port \
  syscall CommLSCheckStatus, __CLSCSArgs##_port \
  mov _result, __CLSCSArgs##_port.Result \
  release __CLSCSMutex##_port \
  compend

#define __lowspeedBytesReady(_port, _bready) \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSCSMutex0 \
  acquire __CLSCSMutex1 \
  acquire __CLSCSMutex2 \
  acquire __CLSCSMutex3 \
  mov __CLSCSArgs0.Port, _port \
  syscall CommLSCheckStatus, __CLSCSArgs0 \
  mov _bready, __CLSCSArgs0.BytesReady \
  release __CLSCSMutex0 \
  release __CLSCSMutex1 \
  release __CLSCSMutex2 \
  release __CLSCSMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSCSMutex##_port \
  set __CLSCSArgs##_port.Port, _port \
  syscall CommLSCheckStatus, __CLSCSArgs##_port \
  mov _bready, __CLSCSArgs##_port.BytesReady \
  release __CLSCSMutex##_port \
  compend

#define __lowspeedWrite(_port, _retlen, _buffer, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSWMutex0 \
  acquire __CLSWMutex1 \
  acquire __CLSWMutex2 \
  acquire __CLSWMutex3 \
  index __LSWriteOptionsVar, __LSWriteOptions, _port \
  or __CLSWArgs0.Port, _port, __LSWriteOptionsVar \
  mov __CLSWArgs0.ReturnLen, _retlen \
  mov __CLSWArgs0.Buffer, _buffer \
  syscall CommLSWrite, __CLSWArgs0 \
  mov _result, __CLSWArgs0.Result \
  release __CLSWMutex0 \
  release __CLSWMutex1 \
  release __CLSWMutex2 \
  release __CLSWMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSWMutex##_port \
  index __LSWriteOptionsVar, __LSWriteOptions, _port \
  or __CLSWArgs##_port.Port, _port, __LSWriteOptionsVar \
  mov __CLSWArgs##_port.ReturnLen, _retlen \
  mov __CLSWArgs##_port.Buffer, _buffer \
  syscall CommLSWrite, __CLSWArgs##_port \
  mov _result, __CLSWArgs##_port.Result \
  release __CLSWMutex##_port \
  compend

#define __lowspeedRead(_port, _buflen, _buffer, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSRMutex0 \
  acquire __CLSRMutex1 \
  acquire __CLSRMutex2 \
  acquire __CLSRMutex3 \
  mov __CLSRArgs0.Port, _port \
  mov __CLSRArgs0.BufferLen, _buflen \
  syscall CommLSRead, __CLSRArgs0 \
  mov _buffer, __CLSRArgs0.Buffer \
  mov _result, __CLSRArgs0.Result \
  release __CLSRMutex0 \
  release __CLSRMutex1 \
  release __CLSRMutex2 \
  release __CLSRMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSRMutex##_port \
  set __CLSRArgs##_port.Port, _port \
  mov __CLSRArgs##_port.BufferLen, _buflen \
  syscall CommLSRead, __CLSRArgs##_port \
  mov _buffer, __CLSRArgs##_port.Buffer \
  mov _result, __CLSRArgs##_port.Result \
  release __CLSRMutex##_port \
  compend

#define __setI2COptions(_port, _options) \
  replace __LSWriteOptions, __LSWriteOptions, _port, _options

subroutine __ReadLSBytes0
  dseg segment
    __RLSBmutex0 mutex
    __RLSLastGoodRead0 byte[] 0x00
    __RLSBResult0 sbyte
    __RLSBytesCount0 byte
    __RLSBIterations0 byte
    __RLSReadBuf0 byte[]
    __RLSPad0 byte
  dseg ends
  __lowspeedWrite(0, __RLSBytesCount0, __RLSReadBuf0, __RLSBResult0)
  brtst NEQ, __RLSBError0, __RLSBResult0 // terminate if not NO_ERR
  set __RLSBIterations0, 60
__RLSBDoCheckStatus0:
  __lowspeedStatus(0, __RLSBytesCount0, __RLSBResult0)
  sub __RLSBIterations0, __RLSBIterations0, 1
  brtst LTEQ, __RLSBError0, __RLSBIterations0
  brtst LT, __RLSBError0, __RLSBResult0 // negative results are absolute errors
  brtst EQ, __RLSBReadyToRead0, __RLSBResult0
  // if STAT_COMM_PENDING then wait a bit and then try again (up to 60 ms)
  wait 1
  jmp __RLSBDoCheckStatus0
__RLSBReadyToRead0:
  brtst EQ, __RLSBReturn0, __RLSBytesCount0 // terminate if zero bytes to read
  // Try reading now
  __lowspeedRead(0, __RLSBytesCount0, __RLSReadBuf0, __RLSBResult0)
  brtst NEQ, __RLSBError0, __RLSBResult0 // terminate if not NO_ERR
  mov __RLSLastGoodRead0, __RLSReadBuf0
  jmp __RLSBDone0
__RLSBError0:
  brtst EQ, __RLSBNoPadding0, __RLSPad0
  arrinit __RLSReadBuf0, 0, __RLSPad0
  jmp __RLSBReturn0
__RLSBNoPadding0:
  mov __RLSReadBuf0, __RLSLastGoodRead0
__RLSBDone0:
  arrsize __RLSBytesCount0, __RLSReadBuf0
__RLSBReturn0:
  return
ends

subroutine __ReadLSBytes1
  dseg segment
    __RLSBmutex1 mutex
    __RLSLastGoodRead1 byte[] 0x00
    __RLSBResult1 sbyte
    __RLSBytesCount1 byte
    __RLSBIterations1 byte
    __RLSReadBuf1 byte[]
    __RLSPad1 byte
  dseg ends
  __lowspeedWrite(1, __RLSBytesCount1, __RLSReadBuf1, __RLSBResult1)
  brtst NEQ, __RLSBError1, __RLSBResult1 // terminate if not NO_ERR
  set __RLSBIterations1, 60
__RLSBDoCheckStatus1:
  __lowspeedStatus(1, __RLSBytesCount1, __RLSBResult1)
  sub __RLSBIterations1, __RLSBIterations1, 1
  brtst LTEQ, __RLSBError1, __RLSBIterations1
  brtst LT, __RLSBError1, __RLSBResult1 // negative results are absolute errors
  brtst EQ, __RLSBReadyToRead1, __RLSBResult1
  // if STAT_COMM_PENDING then wait a bit and then try again (up to 60 ms)
  wait 1
  jmp __RLSBDoCheckStatus1
__RLSBReadyToRead1:
  brtst EQ, __RLSBReturn1, __RLSBytesCount1 // terminate if zero bytes to read
  // Try reading now
  __lowspeedRead(1, __RLSBytesCount1, __RLSReadBuf1, __RLSBResult1)
  brtst NEQ, __RLSBError1, __RLSBResult1 // terminate if not NO_ERR
  mov __RLSLastGoodRead1, __RLSReadBuf1
  jmp __RLSBDone1
__RLSBError1:
  brtst EQ, __RLSBNoPadding1, __RLSPad1
  arrinit __RLSReadBuf1, 0, __RLSPad1
  jmp __RLSBReturn1
__RLSBNoPadding1:
  mov __RLSReadBuf1, __RLSLastGoodRead1
__RLSBDone1:
  arrsize __RLSBytesCount1, __RLSReadBuf1
__RLSBReturn1:
  return
ends

subroutine __ReadLSBytes2
  dseg segment
    __RLSBmutex2 mutex
    __RLSLastGoodRead2 byte[] 0x00
    __RLSBResult2 sbyte
    __RLSBytesCount2 byte
    __RLSBIterations2 byte
    __RLSReadBuf2 byte[]
    __RLSPad2 byte
  dseg ends
  __lowspeedWrite(2, __RLSBytesCount2, __RLSReadBuf2, __RLSBResult2)
  brtst NEQ, __RLSBError2, __RLSBResult2 // terminate if not NO_ERR
  set __RLSBIterations2, 60
__RLSBDoCheckStatus2:
  __lowspeedStatus(2, __RLSBytesCount2, __RLSBResult2)
  sub __RLSBIterations2, __RLSBIterations2, 1
  brtst LTEQ, __RLSBError2, __RLSBIterations2
  brtst LT, __RLSBError2, __RLSBResult2 // negative results are absolute errors
  brtst EQ, __RLSBReadyToRead2, __RLSBResult2
  // if STAT_COMM_PENDING then wait a bit and then try again (up to 60 ms)
  wait 1
  jmp __RLSBDoCheckStatus2
__RLSBReadyToRead2:
  brtst EQ, __RLSBReturn2, __RLSBytesCount2 // terminate if zero bytes to read
  // Try reading now
  __lowspeedRead(2, __RLSBytesCount2, __RLSReadBuf2, __RLSBResult2)
  brtst NEQ, __RLSBError2, __RLSBResult2 // terminate if not NO_ERR
  mov __RLSLastGoodRead2, __RLSReadBuf2
  jmp __RLSBDone2
__RLSBError2:
  brtst EQ, __RLSBNoPadding2, __RLSPad2
  arrinit __RLSReadBuf2, 0, __RLSPad2
  jmp __RLSBReturn2
__RLSBNoPadding2:
  mov __RLSReadBuf2, __RLSLastGoodRead2
__RLSBDone2:
  arrsize __RLSBytesCount2, __RLSReadBuf2
__RLSBReturn2:
  return
ends

subroutine __ReadLSBytes3
  dseg segment
    __RLSBmutex3 mutex
    __RLSLastGoodRead3 byte[] 0x00
    __RLSBResult3 sbyte
    __RLSBytesCount3 byte
    __RLSBIterations3 byte
    __RLSReadBuf3 byte[]
    __RLSPad3 byte
  dseg ends
  __lowspeedWrite(3, __RLSBytesCount3, __RLSReadBuf3, __RLSBResult3)
  brtst NEQ, __RLSBError3, __RLSBResult3 // terminate if not NO_ERR
  set __RLSBIterations3, 60
__RLSBDoCheckStatus3:
  __lowspeedStatus(3, __RLSBytesCount3, __RLSBResult3)
  sub __RLSBIterations3, __RLSBIterations3, 1
  brtst LTEQ, __RLSBError3, __RLSBIterations3
  brtst LT, __RLSBError3, __RLSBResult3 // negative results are absolute errors
  brtst EQ, __RLSBReadyToRead3, __RLSBResult3
  // if STAT_COMM_PENDING then wait a bit and then try again (up to 60 ms)
  wait 1
  jmp __RLSBDoCheckStatus3
__RLSBReadyToRead3:
  brtst EQ, __RLSBReturn3, __RLSBytesCount3 // terminate if zero bytes to read
  // Try reading now
  __lowspeedRead(3, __RLSBytesCount3, __RLSReadBuf3, __RLSBResult3)
  brtst NEQ, __RLSBError3, __RLSBResult3 // terminate if not NO_ERR
  mov __RLSLastGoodRead3, __RLSReadBuf3
  jmp __RLSBDone3
__RLSBError3:
  brtst EQ, __RLSBNoPadding3, __RLSPad3
  arrinit __RLSReadBuf3, 0, __RLSPad3
  jmp __RLSBReturn3
__RLSBNoPadding3:
  mov __RLSReadBuf3, __RLSLastGoodRead3
__RLSBDone3:
  arrsize __RLSBytesCount3, __RLSReadBuf3
__RLSBReturn3:
  return
ends

subroutine __ReadLSBytesVar
  dseg segment
    __RLSLastGoodReadVar byte[] 0x00
    __RLSBResultVar sbyte
    __RLSBytesCountVar byte
    __RLSBIterationsVar byte
    __RLSReadBufVar byte[]
    __RLSReadPort byte
    __RLSPadVar byte
  dseg ends
  __lowspeedWrite(__RLSReadPort, __RLSBytesCountVar, __RLSReadBufVar, __RLSBResultVar)
  brtst NEQ, __RLSBErrorVar, __RLSBResultVar // terminate if not NO_ERR
  set __RLSBIterationsVar, 60
__RLSBDoCheckStatusVar:
  __lowspeedStatus(__RLSReadPort, __RLSBytesCountVar, __RLSBResultVar)
  sub __RLSBIterationsVar, __RLSBIterationsVar, 1
  brtst LTEQ, __RLSBErrorVar, __RLSBIterationsVar
  brtst LT, __RLSBErrorVar, __RLSBResultVar // negative results are absolute errors
  brtst EQ, __RLSBReadyToReadVar, __RLSBResultVar
  // if STAT_COMM_PENDING then wait a bit and then try again (up to 60 ms)
  wait 1
  jmp __RLSBDoCheckStatusVar
__RLSBReadyToReadVar:
  brtst EQ, __RLSBReturnVar, __RLSBytesCountVar // terminate if zero bytes to read
  // Try reading now
  __lowspeedRead(__RLSReadPort, __RLSBytesCountVar, __RLSReadBufVar, __RLSBResultVar)
  brtst NEQ, __RLSBErrorVar, __RLSBResultVar // terminate if not NO_ERR
  mov __RLSLastGoodReadVar, __RLSReadBufVar
  jmp __RLSBDoneVar
__RLSBErrorVar:
  brtst EQ, __RLSBNoPaddingVar, __RLSPadVar
  arrinit __RLSReadBufVar, 0, __RLSPadVar
  jmp __RLSBReturnVar
__RLSBNoPaddingVar:
  mov __RLSReadBufVar, __RLSLastGoodReadVar
__RLSBDoneVar:
  arrsize __RLSBytesCountVar, __RLSReadBufVar
__RLSBReturnVar:
  return
ends

subroutine __I2CReadBEValueSub
  index __LSWriteOptionsVar, __LSWriteOptions, __WDSC_Port
  or __WDSC_lswArgs.Port, __WDSC_Port, __LSWriteOptionsVar
  arrbuild __WDSC_lswArgs.Buffer, __WDSC_SensorAddress, __WDSC_SensorRegister, __WDSC_WriteBytes
  set __WDSC_lswArgs.ReturnLen, 0
  syscall CommLSWrite, __WDSC_lswArgs
__WDSC_StatusLoop:
  __lowspeedCheckStatus(__WDSC_Port, __WDSC_LSStatus)
  brtst GT, __WDSC_StatusLoop, __WDSC_LSStatus
  return
ends

subroutine __I2CReadLEValueSub
  index __LSWriteOptionsVar, __LSWriteOptions, __RDSD_Port
  or __RDSD_lswArgs.Port, __RDSD_Port, __LSWriteOptionsVar
  arrbuild __RDSD_lswArgs.Buffer, __RDSD_SensorAddress, __RDSD_SensorRegister
  mov __RDSD_lswArgs.ReturnLen, __RDSD_NumBytesToRead
  syscall CommLSWrite, __RDSD_lswArgs
__RDSD_CheckStatusAfterWriteLoop:
  __lowspeedCheckStatus(__RDSD_Port, __RDSD_LSStatus)
  brtst GT, __RDSD_CheckStatusAfterWriteLoop, __RDSD_LSStatus
  brtst EQ, __RDSD_GoAheadWithRead, __RDSD_LSStatus
  jmp __RDSD_ReadError
__RDSD_GoAheadWithRead:
  mov __RDSD_lsrArgs.Port, __RDSD_Port
  mov __RDSD_lsrArgs.BufferLen, __RDSD_NumBytesToRead
  syscall CommLSRead, __RDSD_lsrArgs
__RDSD_CheckStatusAfterReadLoop:
  __lowspeedCheckStatus(__RDSD_Port, __RDSD_LSStatus)
  brtst GT, __RDSD_CheckStatusAfterReadLoop, __RDSD_LSStatus
  arrsize __RDSD_bytesRead, __RDSD_lsrArgs.Buffer
  brcmp NEQ, __RDSD_ReadError, __RDSD_bytesRead, __RDSD_NumBytesToRead
  brtst EQ, __RDSD_GoAheadAndCalculateValue, __RDSD_LSStatus
__RDSD_ReadError:
  mov __RDSD_Value, __RDSD_PreviousValue
  jmp __RDSD_ReturnResults
__RDSD_GoAheadAndCalculateValue:
  set __RDSD_Value, 0
  brcmp EQ, __RDSD_OneByte, __RDSD_NumBytesToRead, 1
  brcmp EQ, __RDSD_TwoBytes, __RDSD_NumBytesToRead, 2
  brcmp EQ, __RDSD_ThreeBytes, __RDSD_NumBytesToRead, 3
  brcmp NEQ, __RDSD_ReadError, __RDSD_NumBytesToRead, 4
  index __RDSD_Byte, __RDSD_lsrArgs.Buffer, 3
  mul __RDSD_Value, __RDSD_Byte, 256
__RDSD_ThreeBytes:
  index __RDSD_Byte, __RDSD_lsrArgs.Buffer, 2
  add __RDSD_Value, __RDSD_Value, __RDSD_Byte
  mul __RDSD_Value, __RDSD_Value, 256
__RDSD_TwoBytes:
  index __RDSD_Byte, __RDSD_lsrArgs.Buffer, 1
  add __RDSD_Value, __RDSD_Value, __RDSD_Byte
  mul __RDSD_Value, __RDSD_Value, 256
__RDSD_OneByte:
  index __RDSD_Byte, __RDSD_lsrArgs.Buffer, NA
  add __RDSD_Value, __RDSD_Value, __RDSD_Byte
  mov __RDSD_PreviousValue, __RDSD_Value
__RDSD_ReturnResults:
  return
ends

subroutine __I2CReadBEValueSub
  index __LSWriteOptionsVar, __LSWriteOptions, __RDSD_Port
  or __RDSD_lswArgs.Port, __RDSD_Port, __LSWriteOptionsVar
  arrbuild __RDSD_lswArgs.Buffer, __RDSD_SensorAddress, __RDSD_SensorRegister
  mov __RDSD_lswArgs.ReturnLen, __RDSD_NumBytesToRead
  syscall CommLSWrite, __RDSD_lswArgs
__RDSD_CheckStatusAfterWriteLoop:
  __lowspeedCheckStatus(__RDSD_Port, __RDSD_LSStatus)
  brtst GT, __RDSD_CheckStatusAfterWriteLoop, __RDSD_LSStatus
  brtst EQ, __RDSD_GoAheadWithRead, __RDSD_LSStatus
  jmp __RDSD_ReadError
__RDSD_GoAheadWithRead:
  mov __RDSD_lsrArgs.Port, __RDSD_Port
  mov __RDSD_lsrArgs.BufferLen, __RDSD_NumBytesToRead
  syscall CommLSRead, __RDSD_lsrArgs
__RDSD_CheckStatusAfterReadLoop:
  __lowspeedCheckStatus(__RDSD_Port, __RDSD_LSStatus)
  brtst GT, __RDSD_CheckStatusAfterReadLoop, __RDSD_LSStatus
  arrsize __RDSD_bytesRead, __RDSD_lsrArgs.Buffer
  brcmp NEQ, __RDSD_ReadError, __RDSD_bytesRead, __RDSD_NumBytesToRead
  brtst EQ, __RDSD_GoAheadAndCalculateValue, __RDSD_LSStatus
__RDSD_ReadError:
  mov __RDSD_Value, __RDSD_PreviousValue
  jmp __RDSD_ReturnResults
__RDSD_GoAheadAndCalculateValue:
  set __RDSD_Value, 0
  index __RDSD_Byte, __RDSD_lsrArgs.Buffer, NA
  mov __RDSD_Value, __RDSD_Byte
  brcmp EQ, __RDSD_ReturnResults, __RDSD_NumBytesToRead, 1
  mul __RDSD_Value, __RDSD_Value, 256
  index __RDSD_Byte, __RDSD_lsrArgs.Buffer, 1
  add __RDSD_Value, __RDSD_Value, __RDSD_Byte
  brcmp EQ, __RDSD_ReturnResults, __RDSD_NumBytesToRead, 2
  mul __RDSD_Value, __RDSD_Value, 256
  index __RDSD_Byte, __RDSD_lsrArgs.Buffer, 2
  add __RDSD_Value, __RDSD_Value, __RDSD_Byte
  brcmp EQ, __RDSD_ReturnResults, __RDSD_NumBytesToRead, 3
  mul __RDSD_Value, __RDSD_Value, 256
  index __RDSD_Byte, __RDSD_lsrArgs.Buffer, 3
  add __RDSD_Value, __RDSD_Value, __RDSD_Byte
  brcmp NEQ, __RDSD_ReadError, __RDSD_NumBytesToRead, 4
  mov __RDSD_PreviousValue, __RDSD_Value
__RDSD_ReturnResults:
  return
ends

// no documentation for these functions since they are essentially readonly
#define SetLSInputBuffer(_p, _offset, _cnt, _data) __setLSInputBuffer(_p, _offset, _cnt, _data)
#define SetLSInputBufferInPtr(_p, _n) __setLSInputBufferInPtr(_p, _n)
#define SetLSInputBufferOutPtr(_p, _n) __setLSInputBufferOutPtr(_p, _n)
#define SetLSInputBufferBytesToRx(_p, _n) __setLSInputBufferBytesToRx(_p, _n)

#define SetLSOutputBuffer(_p, _offset, _cnt, _data) __setLSOutputBuffer(_p, _offset, _cnt, _data)
#define SetLSOutputBufferInPtr(_p, _n) __setLSOutputBufferInPtr(_p, _n)
#define SetLSOutputBufferOutPtr(_p, _n) __setLSOutputBufferOutPtr(_p, _n)
#define SetLSOutputBufferBytesToRx(_p, _n) __setLSOutputBufferBytesToRx(_p, _n)

#define SetLSMode(_p, _n) __setLSMode(_p, _n)
#define SetLSChannelState(_p, _n) __setLSChannelState(_p, _n)
#define SetLSErrorType(_p, _n) __setLSErrorType(_p, _n)
#define SetLSState(_n) __setLSState(_n)
#define SetLSSpeed(_n) __setLSSpeed(_n)

#ifdef __ENHANCED_FIRMWARE
#define SetLSNoRestartOnRead(_n) __setLSNoRestartOnRead(_n)
#endif

#endif

/**
 * Read ultrasonic sensor value.
 * Return the ultrasonic sensor distance value. Since an
 * ultrasonic sensor is an I2C digital sensor its value cannot be read using
 * the standard Sensor(n) value.
 * The port must be configured as a Lowspeed port before using this function.
 * \param _port The port to which the ultrasonic sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _value The ultrasonic sensor distance value (0..255)
 */
#define ReadSensorUS(_port, _value) __ReadSensorUS(_port, _value, 15)

/**
 * Read multiple ultrasonic sensor values.
 * Return eight ultrasonic sensor distance values.
 * \param _port The port to which the ultrasonic sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _values An array of bytes that will contain the 8 distance values
 * read from the ultrasonic sensor.
 * \param _result A status code indicating whether the read completed successfully or not.
 * See \ref TCommLSRead for possible Result values.
 */
#define ReadSensorUSEx(_port, _values, _result) __ReadSensorUSEx(_port, _values, _result, 15)

/**
 * Read the LEGO EMeter values.
 * Read all the LEGO EMeter register values.
 * They must all be read at once to ensure data coherency.
 *
 * \param _port The port to which the LEGO EMeter sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _vIn Input voltage
 * \param _aIn Input current
 * \param _vOut Output voltage
 * \param _aOut Output current
 * \param _joules The number of joules stored in E-Meter
 * \param _wIn The number of watts generated
 * \param _wOut The number of watts consumed
 * \param _result A status code indicating whether the read completed successfully or not.
 * See \ref TCommLSRead for possible Result values.
 */
#define ReadSensorEMeter(_port, _vIn, _aIn, _vOut, _aOut, _joules, _wIn, _wOut, _result) __ReadSensorEMeter(_port, _vIn, _aIn, _vOut, _aOut, _joules, _wIn, _wOut, _result)

/**
 * Configure LEGO Temperature sensor options.
 * Set various LEGO Temperature sensor options.
 *
 * \param _port The port to which the LEGO EMeter sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _config The temperature sensor configuration settings.  See
 * \ref TempI2CConstants for configuration constants that can be ORed or added
 * together.
 * \param _result A status code indicating whether the read completed successfully or not.
 * See \ref TCommLSRead for possible Result values.
 */
#define ConfigureTemperatureSensor(_port, _config, _result) __TempSendCmd(_port, _config, _result)

/**
 * Read the LEGO Temperature sensor value.
 * Return the temperature sensor value in degrees celcius. Since a
 * temperature sensor is an I2C digital sensor its value cannot be read using
 * the standard Sensor(n) value.
 * The port must be configured as a temperature sensor port before using this
 * function. Use \ref SetSensorTemperature to configure the port.
 * \param _port The port to which the temperature sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _temp The temperature sensor value in degrees celcius.
 */
#define ReadSensorTemperature(_port, _temp) __ReadSensorTemperature(_port, _temp)

/**
 * Get lowspeed status.
 * This method checks the status of the I2C communication on the specified
 * port. If the last operation on this port was a successful LowspeedWrite
 * call that requested response data from the device then bytesready will
 * be set to the number of bytes in the internal read buffer.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _bready The number of bytes available to be read from the internal I2C buffer.
 * The maximum number of bytes that can be read is 16.
 * \param _result A status code indicating whether the write completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * Avoid calls to \ref LowspeedRead or \ref LowspeedWrite while LowspeedStatus returns
 * \ref STAT_COMM_PENDING.
 * \sa LowspeedRead, LowspeedWrite, and LowspeedCheckStatus
 */
#define LowspeedStatus(_port, _bready, _result) __lowspeedStatus(_port, _bready, _result)

/**
 * Check lowspeed status.
 * This method checks the status of the I2C communication on the specified
 * port.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _result A status code indicating whether the write completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * Avoid calls to \ref LowspeedRead or \ref LowspeedWrite while LowspeedCheckStatus returns
 * \ref STAT_COMM_PENDING.
 * \sa LowspeedRead, LowspeedWrite, and LowspeedStatus
 */
#define LowspeedCheckStatus(_port, _result) __lowspeedCheckStatus(_port, _result)

/**
 * Get lowspeed bytes ready.
 * This method checks the number of bytes that are ready to be read on the
 * specified port. If the last operation on this port was a successful
 * LowspeedWrite call that requested response data from the device then the
 * return value will be the number of bytes in the internal read buffer.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _bready The number of bytes available to be read from the internal I2C buffer.
 * The maximum number of bytes that can be read is 16.
 * \sa LowspeedRead, LowspeedWrite, and LowspeedStatus
 */
#define LowspeedBytesReady(_port, _bready) __lowspeedBytesReady(_port, _bready)

/**
 * Write lowspeed data.
 * This method starts a transaction to write the bytes contained in the array
 * buffer to the I2C device on the specified port. It also tells the I2C device
 * the number of bytes that should be included in the response. The maximum
 * number of bytes that can be written or read is 16.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _retlen The number of bytes that should be returned by the I2C device.
 * \param _buffer A byte array containing the address of the I2C device, the I2C
 * device register at which to write data, and up to 14 bytes of data to be
 * written at the specified register.
 * \param _result A status code indicating whether the write completed successfully or not.
 * See \ref TCommLSWrite for possible Result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * \sa LowspeedRead, LowspeedCheckStatus, LowspeedBytesReady, and LowspeedStatus
 */
#define LowspeedWrite(_port, _retlen, _buffer, _result) __lowspeedWrite(_port, _retlen, _buffer, _result)

/**
 * Read lowspeed data.
 * Read the specified number of bytes from the I2C device on the specified
 * port and store the bytes read in the byte array buffer provided.  The maximum
 * number of bytes that can be written or read is 16.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _buflen The initial size of the output buffer.
 * \param _buffer A byte array that contains the data read from the internal I2C
 * buffer.  If the return value is negative then the output buffer will be empty.
 * \param _result A status code indicating whether the write completed successfully or not.
 * See \ref TCommLSRead for possible Result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * \sa LowspeedWrite, LowspeedCheckStatus, LowspeedBytesReady, and LowspeedStatus
 */
#define LowspeedRead(_port, _buflen, _buffer, _result) __lowspeedRead(_port, _buflen, _buffer, _result)

/**
 * Perform an I2C write/read transaction.
 * This method writes the bytes contained in the input buffer (inbuf) to the
 * I2C device on the specified port, checks for the specified number of bytes
 * to be ready for reading, and then tries to read the specified number (count)
 * of bytes from the I2C device into the output buffer (outbuf).
 *
 * This is a higher-level wrapper around the three main I2C functions. It also
 * maintains a "last good read" buffer and returns values from that buffer if
 * the I2C communication transaction fails.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _inbuf A byte array containing the address of the I2C device, the I2C
 * device register at which to write data, and up to 14 bytes of data to be
 * written at the specified register.
 * \param _count The number of bytes that should be returned by the I2C device.
 * On output count is set to the number of bytes in outbuf.
 * \param _outbuf A byte array that contains the data read from the internal I2C
 * buffer.
 * \param _result Returns true or false indicating whether the I2C transaction
 * succeeded or failed.
 * \sa LowspeedRead, LowspeedWrite, LowspeedCheckStatus, LowspeedBytesReady,
 * and LowspeedStatus
 */
#define ReadI2CBytes(_port, _inbuf, _count, _outbuf, _result) __ReadI2CBytes(_port, _inbuf, _count, _outbuf, _result)

/**
 * Read I2C device information.
 * Read standard I2C device information: version, vendor, and device ID. The
 * I2C device uses the specified address.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _i2caddr The I2C device address.
 * \param _info A value indicating the type of device information you are requesting.
 * See \ref GenericI2CConstants.
 * \param _strVal A string containing the requested device information.
 */
#define ReadI2CDeviceInfo(_port, _i2caddr, _info, _strVal) __ReadI2CDeviceInfo(_port, _i2caddr, _info, _strVal)

/**
 * Read I2C device version.
 * Read standard I2C device version. The I2C device uses the specified address.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _i2caddr The I2C device address.
 * \param _strVal A string containing the device version.
 */
#define ReadI2CVersion(_port, _i2caddr, _strVal) ReadI2CDeviceInfo(_port, _i2caddr, I2C_REG_VERSION, _strVal)

/**
 * Read I2C device vendor.
 * Read standard I2C device vendor. The I2C device uses the specified address.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _i2caddr The I2C device address.
 * \param _strVal A string containing the device vendor.
 */
#define ReadI2CVendorId(_port, _i2caddr, _strVal) ReadI2CDeviceInfo(_port, _i2caddr, I2C_REG_VENDOR_ID, _strVal)

/**
 * Read I2C device identifier.
 * Read standard I2C device identifier. The I2C device uses the specified address.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _i2caddr The I2C device address.
 * \param _strVal A string containing the device identifier.
 */
#define ReadI2CDeviceId(_port, _i2caddr, _strVal) ReadI2CDeviceInfo(_port, _i2caddr, I2C_REG_DEVICE_ID, _strVal)

/**
 * Read I2C register.
 * Read a single byte from an I2C device register.
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _i2caddr The I2C device address.
 * \param _reg The I2C device register from which to read a single byte.
 * \param _out The single byte read from the I2C device.
 * \param _result A status code indicating whether the read completed successfully or not.
 * See \ref TCommLSRead for possible Result values.
 */
#define ReadI2CRegister(_port, _i2caddr, _reg, _out, _result) __I2CReadValue(_port, _i2caddr, _reg, 1, _out, _result)

/**
 * Write I2C register.
 * Write a single byte to an I2C device register.
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _i2caddr The I2C device address.
 * \param _reg The I2C device register to which to write a single byte.
 * \param _val The byte to write to the I2C device.
 * \param _result A status code indicating whether the write completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define WriteI2CRegister(_port, _i2caddr, _reg, _val, _result) __I2CWriteToRegister(_port, _i2caddr, _reg, _val, _result)

/**
 * Send an I2C command.
 * Send a command to an I2C device at the standard command register: \ref I2C_REG_CMD.
 * The I2C device uses the specified address.
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _i2caddr The I2C device address.
 * \param _cmd The command to send to the I2C device.
 * \param _result A status code indicating whether the write completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define I2CSendCommand(_port, _i2caddr, _cmd, _result) __I2CSendCmd(_port, _i2caddr, _cmd, _result)

/** @defgroup LowLevelLowSpeedModuleFunctions Low level LowSpeed module functions
 * Low level functions for accessing low speed module features.
 * @{
 */

/**
 * Get I2C input buffer data.
 * This method reads count bytes of data from the I2C input buffer for the
 * specified port and writes it to the buffer provided.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _offset A constant offset into the I2C input buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the I2C input buffer.
 */
#define GetLSInputBuffer(_p, _offset, _cnt, _data) __getLSInputBuffer(_p, _offset, _cnt, _data)

/**
 * Get I2C input buffer in-pointer.
 * This method returns the value of the input pointer of the I2C input
 * buffer for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C input buffer's in-pointer value.
 */
#define GetLSInputBufferInPtr(_p, _n) __GetLSInputBufferInPtr(_p, _n)

/**
 * Get I2C input buffer out-pointer.
 * This method returns the value of the output pointer of the I2C input
 * buffer for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C input buffer's out-pointer value.
 */
#define GetLSInputBufferOutPtr(_p, _n) __GetLSInputBufferOutPtr(_p, _n)

/**
 * Get I2C input buffer bytes to rx.
 * This method returns the value of the bytes to rx field of the I2C input
 * buffer for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C input buffer's bytes to rx value.
 */
#define GetLSInputBufferBytesToRx(_p, _n) __GetLSInputBufferBytesToRx(_p, _n)

/**
 * Get I2C output buffer data.
 * This method reads cnt bytes of data from the I2C output buffer for the
 * specified port and writes it to the buffer provided.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _offset A constant offset into the I2C output buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the I2C output buffer.
 */
#define GetLSOutputBuffer(_p, _offset, _cnt, _data) __getLSOutputBuffer(_p, _offset, _cnt, _data)

/**
 * Get I2C output buffer in-pointer.
 * This method returns the value of the input pointer of the I2C output
 * buffer for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C output buffer's in-pointer value.
 */
#define GetLSOutputBufferInPtr(_p, _n) __GetLSOutputBufferInPtr(_p, _n)

/**
 * Get I2C output buffer out-pointer.
 * This method returns the value of the output pointer of the I2C output
 * buffer for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C output buffer's out-pointer value.
 */
#define GetLSOutputBufferOutPtr(_p, _n) __GetLSOutputBufferOutPtr(_p, _n)

/**
 * Get I2C output buffer bytes to rx.
 * This method returns the value of the bytes to rx field of the I2C output
 * buffer for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C output buffer's bytes to rx value.
 */
#define GetLSOutputBufferBytesToRx(_p, _n) __GetLSOutputBufferBytesToRx(_p, _n)

/**
 * Get I2C mode.
 * This method returns the value of the I2C mode for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C port mode. See \ref LowSpeedModeConstants.
 */
#define GetLSMode(_p, _n) __GetLSMode(_p, _n)

/**
 * Get I2C channel state.
 * This method returns the value of the I2C channel state for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C port channel state. See \ref LowSpeedChannelStateConstants.
 */
#define GetLSChannelState(_p, _n) __GetLSChannelState(_p, _n)

/**
 * Get I2C error type.
 * This method returns the value of the I2C error type for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C port error type. See \ref LowSpeedErrorTypeConstants.
 */
#define GetLSErrorType(_p, _n) __GetLSErrorType(_p, _n)

/**
 * Get I2C state.
 * This method returns the value of the I2C state.
 * \param _n The I2C state. See \ref LowSpeedStateConstants.
 */
#define GetLSState(_n) __GetLSState(_n)

/**
 * Get I2C speed.
 * This method returns the value of the I2C speed.
 * \param _n The I2C speed.
 *
 * \warning This function is unimplemented within the firmware.
 */
#define GetLSSpeed(_n) __GetLSSpeed(_n)

#ifdef __ENHANCED_FIRMWARE
/**
 * Get I2C no restart on read setting.
 * This method returns the value of the I2C no restart on read field.
 * \param _n The I2C no restart on read field. See \ref LowSpeedNoRestartConstants.
 */
#define GetLSNoRestartOnRead(_n) __GetLSNoRestartOnRead(_n)
#endif

/** @} */ // end of LowLevelLowSpeedModuleFunctions group

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/**
 * Set I2C options.
 * This method lets you modify I2C options. Use this function to turn on
 * or off the fast I2C mode and also control whether the standard I2C mode
 * performs a restart prior to the read operation.
 *
 * \param _port The port whose I2C options you wish to change. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _options The new option value. See \ref I2COptionConstants.
 */
#define SetI2COptions(_port, _options) __setI2COptions(_port, _options)

#endif

/** @} */ // end of LowSpeedModuleFunctions group
/** @} */ // end of LowSpeedModule group
/** @} */ // end of NXTFirmwareModules group

#endif // NBC_LOWSPEED_H
