/** \file nbc_hitechnic.h
 * \brief The NBC HiTechnic API
 *
 * nbc_hitechnic.h contains the NBC HiTechnic API
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

#ifndef NBC_HITECHNIC_H
#define NBC_HITECHNIC_H

#include "input_constants.h"
#include "hitechnic_constants.h"
#include "nbc_input.h"
#include "nbc_lowspeed.h"

/** @addtogroup ThirdPartyDevices
 * @{
 */

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// HiTechnic API ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup HiTechnicAPI
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

#define __SetSensorHTEOPD(_port, _bStd) \
  setin IN_TYPE_LIGHT_ACTIVE+_bStd, _port, TypeField \
  setin IN_MODE_RAW, _port, InputModeField \
  __ResetSensor(_port)

#define __ReadSensorHTEOPD(_port, _val) \
  getin _val, _port, RawValueField \
  sub _val, 1023, _val

#define __SetSensorHTGyro(_port) \
  setin IN_TYPE_LIGHT_INACTIVE, _port, TypeField \
  setin IN_MODE_RAW, _port, InputModeField \
  __ResetSensor(_port)

#define __ReadSensorHTGyro(_port, _offset, _val) \
  getin _val, _port, RawValueField \
  sub _val, _val, 600 \
  sub _val, _val, _offset

#define __ReadSensorHTMagnet(_port, _offset, _val) __ReadSensorHTGyro(_port, _offset, _val)
#define __SetSensorHTMagnet(_port) __SetSensorHTGyro(_port)

#define __ReadSensorHTForce(_port, _val) \
  getin _val, _port, RawValueField \
  sub _val, 1023, _val

#define __SetSensorHTForce(_port) __SetSensorHTGyro(_port)

dseg segment
  __HTMplexRaw word
  __HTMplexScaled dword
  __HTMplexMutex mutex
dseg ends

#define __ReadSensorHTTouchMultiplexer(_p, _t1, _t2, _t3, _t4) \
  acquire __HTMplexMutex \
  getin __HTMplexRaw, _p, RawValueField \
  mul __HTMplexScaled, __HTMplexRaw, 339 \
  sub __HTMplexScaled, 346797, __HTMplexScaled \
  div __HTMplexScaled, __HTMplexScaled, __HTMplexRaw \
  add __HTMplexScaled, __HTMplexScaled, 5 \
  div __HTMplexScaled, __HTMplexScaled, 10 \
  and _t4, __HTMplexScaled, 8 \
  and _t3, __HTMplexScaled, 4 \
  and _t2, __HTMplexScaled, 2 \
  and _t1, __HTMplexScaled, 1 \
  release __HTMplexMutex

#define __ReadSensorHTCompass(_port, _value) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 2 \
  set __RLSPadVar, 2 \
  call __ReadLSBytesVar \
  index _value, __RLSReadBufVar, NA \
  index __RLSBytesCountVar, __RLSReadBufVar, 1 \
  add _value, _value, _value \
  add _value, _value, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 2 \
  set __RLSPad##_port, 2 \
  call __ReadLSBytes##_port \
  index _value, __RLSReadBuf##_port, NA \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 1 \
  add _value, _value, _value \
  add _value, _value, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTAccel(_port, _x, _y, _z, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 6 \
  set __RLSPadVar, 6 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _x, __RLSReadBufVar, NA \
  index __RLSBytesCountVar, __RLSReadBufVar, 3 \
  brcmp LTEQ, __RSHTAX##__I__, _x, 127 \
  sub _x, _x, 256 \
  __RSHTAX##__I__: \
  __IncI__ \
  mul _x, _x, 4 \
  add _x, _x, __RLSBytesCountVar \
  index _y, __RLSReadBufVar, 1 \
  index __RLSBytesCountVar, __RLSReadBufVar, 4 \
  brcmp LTEQ, __RSHTAY##__I__, _y, 127 \
  sub _y, _y, 256 \
  __RSHTAY##__I__: \
  __IncI__ \
  mul _y, _y, 4 \
  add _y, _y, __RLSBytesCountVar \
  index _z, __RLSReadBufVar, 2 \
  index __RLSBytesCountVar, __RLSReadBufVar, 5 \
  brcmp LTEQ, __RSHTAZ##__I__, _z, 127 \
  sub _z, _z, 256 \
  __RSHTAZ##__I__: \
  __IncI__ \
  mul _z, _z, 4 \
  add _z, _z, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 6 \
  set __RLSPad##_port, 6 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _x, __RLSReadBuf##_port, NA \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 3 \
  brcmp LTEQ, __RSHTAX##__I__, _x, 127 \
  sub _x, _x, 256 \
  __RSHTAX##__I__: \
  __IncI__ \
  mul _x, _x, 4 \
  add _x, _x, __RLSBytesCount##_port \
  index _y, __RLSReadBuf##_port, 1 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 4 \
  brcmp LTEQ, __RSHTAY##__I__, _y, 127 \
  sub _y, _y, 256 \
  __RSHTAY##__I__: \
  __IncI__ \
  mul _y, _y, 4 \
  add _y, _y, __RLSBytesCount##_port \
  index _z, __RLSReadBuf##_port, 2 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 5 \
  brcmp LTEQ, __RSHTAZ##__I__, _z, 127 \
  sub _z, _z, 256 \
  __RSHTAZ##__I__: \
  __IncI__ \
  mul _z, _z, 4 \
  add _z, _z, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

dseg segment
  __RSHTColorRawBuf byte[] 0x02, 0x46
  __RSHTColorNormBuf byte[] 0x02, 0x4C
  __RSHTColor2NormBuf byte[] 0x02, 0x47
dseg ends

#define __ReadSensorHTRawColor(_port, _Red, _Green, _Blue, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RSHTColorRawBuf \
  set __RLSBytesCountVar, 6 \
  set __RLSPadVar, 6 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _Red, __RLSReadBufVar, 1 \
  index __RLSBytesCountVar, __RLSReadBufVar, NA \
  mul _Red, _Red, 256 \
  add _Red, _Red, __RLSBytesCountVar \
  index _Green, __RLSReadBufVar, 3 \
  index __RLSBytesCountVar, __RLSReadBufVar, 2 \
  mul _Green, _Green, 256 \
  add _Green, _Green, __RLSBytesCountVar \
  index _Blue, __RLSReadBufVar, 5 \
  index __RLSBytesCountVar, __RLSReadBufVar, 4 \
  mul _Blue, _Blue, 256 \
  add _Blue, _Blue, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RSHTColorRawBuf \
  set __RLSBytesCount##_port, 6 \
  set __RLSPad##_port, 6 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _Red, __RLSReadBuf##_port, 1 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, NA \
  mul _Red, _Red, 256 \
  add _Red, _Red, __RLSBytesCount##_port \
  index _Green, __RLSReadBuf##_port, 3 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 2 \
  mul _Green, _Green, 256 \
  add _Green, _Green, __RLSBytesCount##_port \
  index _Blue, __RLSReadBuf##_port, 5 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 4 \
  mul _Blue, _Blue, 256 \
  add _Blue, _Blue, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTColor(_port, _ColorNum, _Red, _Green, _Blue, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 4 \
  set __RLSPadVar, 4 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _ColorNum, __RLSReadBufVar, NA \
  index _Red, __RLSReadBufVar, 1 \
  index _Green, __RLSReadBufVar, 2 \
  index _Blue, __RLSReadBufVar, 3 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 4 \
  set __RLSPad##_port, 4 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _ColorNum, __RLSReadBuf##_port, NA \
  index _Red, __RLSReadBuf##_port, 1 \
  index _Green, __RLSReadBuf##_port, 2 \
  index _Blue, __RLSReadBuf##_port, 3 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTNormalizedColor(_port, _ColorIdx, _Red, _Green, _Blue, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RSHTColorNormBuf \
  set __RLSBytesCountVar, 4 \
  set __RLSPadVar, 4 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _ColorIdx, __RLSReadBufVar, NA \
  index _Red, __RLSReadBufVar, 1 \
  index _Green, __RLSReadBufVar, 2 \
  index _Blue, __RLSReadBufVar, 3 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RSHTColorNormBuf \
  set __RLSBytesCount##_port, 4 \
  set __RLSPad##_port, 4 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _ColorIdx, __RLSReadBuf##_port, NA \
  index _Red, __RLSReadBuf##_port, 1 \
  index _Green, __RLSReadBuf##_port, 2 \
  index _Blue, __RLSReadBuf##_port, 3 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTColor2Active(_port, _ColorNum, _Red, _Green, _Blue, _White, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 5 \
  set __RLSPadVar, 5 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _ColorNum, __RLSReadBufVar, NA \
  index _Red, __RLSReadBufVar, 1 \
  index _Green, __RLSReadBufVar, 2 \
  index _Blue, __RLSReadBufVar, 3 \
  index _White, __RLSReadBufVar, 4 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 5 \
  set __RLSPad##_port, 5 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _ColorNum, __RLSReadBuf##_port, NA \
  index _Red, __RLSReadBuf##_port, 1 \
  index _Green, __RLSReadBuf##_port, 2 \
  index _Blue, __RLSReadBuf##_port, 3 \
  index _White, __RLSReadBuf##_port, 4 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTNormalizedColor2Active(_port, _ColorIdx, _Red, _Green, _Blue, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RSHTColor2NormBuf \
  set __RLSBytesCountVar, 4 \
  set __RLSPadVar, 4 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _ColorIdx, __RLSReadBufVar, NA \
  index _Red, __RLSReadBufVar, 1 \
  index _Green, __RLSReadBufVar, 2 \
  index _Blue, __RLSReadBufVar, 3 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RSHTColor2NormBuf \
  set __RLSBytesCount##_port, 5 \
  set __RLSPad##_port, 5 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _ColorIdx, __RLSReadBuf##_port, NA \
  index _Red, __RLSReadBuf##_port, 1 \
  index _Green, __RLSReadBuf##_port, 2 \
  index _Blue, __RLSReadBuf##_port, 3 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTRawColor2(_port, _Red, _Green, _Blue, _White, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 8 \
  set __RLSPadVar, 8 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _Red, __RLSReadBufVar, NA \
  index __RLSBytesCountVar, __RLSReadBufVar, 1 \
  mul _Red, _Red, 256 \
  add _Red, _Red, __RLSBytesCountVar \
  index _Green, __RLSReadBufVar, 2 \
  index __RLSBytesCountVar, __RLSReadBufVar, 3 \
  mul _Green, _Green, 256 \
  add _Green, _Green, __RLSBytesCountVar \
  index _Blue, __RLSReadBufVar, 4 \
  index __RLSBytesCountVar, __RLSReadBufVar, 5 \
  mul _Blue, _Blue, 256 \
  add _Blue, _Blue, __RLSBytesCountVar \
  index _White, __RLSReadBufVar, 6 \
  index __RLSBytesCountVar, __RLSReadBufVar, 7 \
  mul _White, _White, 256 \
  add _White, _White, __RLSBytesCountVar \
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
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _Red, __RLSReadBuf##_port, NA \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 1 \
  mul _Red, _Red, 256 \
  add _Red, _Red, __RLSBytesCount##_port \
  index _Green, __RLSReadBuf##_port, 2 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 3 \
  mul _Green, _Green, 256 \
  add _Green, _Green, __RLSBytesCount##_port \
  index _Blue, __RLSReadBuf##_port, 4 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 5 \
  mul _Blue, _Blue, 256 \
  add _Blue, _Blue, __RLSBytesCount##_port \
  index _White, __RLSReadBuf##_port, 6 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 7 \
  mul _White, _White, 256 \
  add _White, _White, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTIRSeeker(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 6 \
  set __RLSPadVar, 6 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _dir, __RLSReadBufVar, NA \
  index _s1, __RLSReadBufVar, 1 \
  index _s3, __RLSReadBufVar, 2 \
  index _s5, __RLSReadBufVar, 3 \
  index _s7, __RLSReadBufVar, 4 \
  index _s9, __RLSReadBufVar, 5 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 6 \
  set __RLSPad##_port, 6 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _dir, __RLSReadBuf##_port, NA \
  index _s1, __RLSReadBuf##_port, 1 \
  index _s3, __RLSReadBuf##_port, 2 \
  index _s5, __RLSReadBuf##_port, 3 \
  index _s7, __RLSReadBuf##_port, 4 \
  index _s9, __RLSReadBuf##_port, 5 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTIRSeeker2DC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _avg, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, 0x10, 0x42 \
  set __RLSBytesCountVar, 7 \
  set __RLSPadVar, 7 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _dir, __RLSReadBufVar, NA \
  index _s1, __RLSReadBufVar, 1 \
  index _s3, __RLSReadBufVar, 2 \
  index _s5, __RLSReadBufVar, 3 \
  index _s7, __RLSReadBufVar, 4 \
  index _s9, __RLSReadBufVar, 5 \
  index _avg, __RLSReadBufVar, 6 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, 0x10, 0x42 \
  set __RLSBytesCount##_port, 7 \
  set __RLSPad##_port, 7 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _dir, __RLSReadBuf##_port, NA \
  index _s1, __RLSReadBuf##_port, 1 \
  index _s3, __RLSReadBuf##_port, 2 \
  index _s5, __RLSReadBuf##_port, 3 \
  index _s7, __RLSReadBuf##_port, 4 \
  index _s9, __RLSReadBuf##_port, 5 \
  index _avg, __RLSReadBuf##_port, 6 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTIRSeeker2AC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, 0x10, 0x49 \
  set __RLSBytesCountVar, 6 \
  set __RLSPadVar, 6 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _dir, __RLSReadBufVar, NA \
  index _s1, __RLSReadBufVar, 1 \
  index _s3, __RLSReadBufVar, 2 \
  index _s5, __RLSReadBufVar, 3 \
  index _s7, __RLSReadBufVar, 4 \
  index _s9, __RLSReadBufVar, 5 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, 0x10, 0x49 \
  set __RLSBytesCount##_port, 6 \
  set __RLSPad##_port, 6 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _dir, __RLSReadBuf##_port, NA \
  index _s1, __RLSReadBuf##_port, 1 \
  index _s3, __RLSReadBuf##_port, 2 \
  index _s5, __RLSReadBuf##_port, 3 \
  index _s7, __RLSReadBuf##_port, 4 \
  index _s9, __RLSReadBuf##_port, 5 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTIRSeeker2Addr(_port, _reg, _value) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, 0x10, _reg \
  set __RLSBytesCountVar, 1 \
  set __RLSPadVar, 1 \
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
  arrbuild __RLSReadBuf##_port, 0x10, _reg \
  set __RLSBytesCount##_port, 1 \
  set __RLSPad##_port, 1 \
  call __ReadLSBytes##_port \
  index _value, __RLSReadBuf##_port, NA \
  release __RLSBmutex##_port \
  compend

#define __SetHTIRSeeker2Mode(_port, _mode, _result) __I2CSendCmd(_port, 0x10, _mode, _result)

#define __ReadSensorHTIRReceiver(_port, _pfdata, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 8 \
  set __RLSPadVar, 8 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  mov _pfdata, __RLSReadBufVar \
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
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  mov _pfdata, __RLSReadBuf##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTIRReceiverEx(_port, _reg, _pfchar, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  add __RLSBytesCountVar, 0x42, _reg \
  arrbuild __RLSReadBufVar, 0x02, __RLSBytesCountVar \
  set __RLSBytesCountVar, 1 \
  set __RLSPadVar, 1 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _pfchar, __RLSReadBufVar, NA \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  add __RLSBytesCount##_port, 0x42, _reg \
  arrbuild __RLSReadBuf##_port, 0x02, __RLSBytesCount##_port \
  set __RLSBytesCount##_port, 1 \
  set __RLSPad##_port, 1 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _pfchar, __RLSReadBuf##_port, NA \
  release __RLSBmutex##_port \
  compend

#define __SetHTColor2Mode(_port, _mode, _result) __I2CSendCmd(_port, 0x02, _mode, _result)

#define __ReadSensorHTColorNum(_port, _value) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 1 \
  set __RLSPadVar, 1 \
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
  call __ReadLSBytes##_port \
  index _value, __RLSReadBuf##_port, NA \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTIRSeekerDir(_port, _value) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 1 \
  set __RLSPadVar, 1 \
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
  call __ReadLSBytes##_port \
  index _value, __RLSReadBuf##_port, NA \
  release __RLSBmutex##_port \
  compend

#define __ResetSensorHTAngle(_port, _mode, _result) \
  compchk EQ, isconst(_mode), TRUE \
  __I2CSendCmd(_port, 0x02, _mode, _result) \
  compif EQ, _mode, HTANGLE_MODE_CALIBRATE \
  wait 30 \
  compend

#define __ReadSensorHTAngle(_port, _Angle, _AccAngle, _RPM, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 8 \
  set __RLSPadVar, 8 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _Angle, __RLSReadBufVar, NA \
  add _Angle, _Angle, _Angle \
  index __RLSBytesCountVar, __RLSReadBufVar, 1 \
  add _Angle, _Angle, __RLSBytesCountVar \
  index _AccAngle, __RLSReadBufVar, 2 \
  mul _AccAngle, _AccAngle, 256 \
  index __RLSBytesCountVar, __RLSReadBufVar, 3 \
  add _AccAngle, _AccAngle, __RLSBytesCountVar \
  mul _AccAngle, _AccAngle, 256 \
  index __RLSBytesCountVar, __RLSReadBufVar, 4 \
  add _AccAngle, _AccAngle, __RLSBytesCountVar \
  mul _AccAngle, _AccAngle, 256 \
  index __RLSBytesCountVar, __RLSReadBufVar, 5 \
  add _AccAngle, _AccAngle, __RLSBytesCountVar \
  index _RPM, __RLSReadBufVar, 6 \
  mul _RPM, _RPM, 256 \
  index __RLSBytesCountVar, __RLSReadBufVar, 7 \
  add _RPM, _RPM, __RLSBytesCountVar \
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
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _Angle, __RLSReadBuf##_port, NA \
  add _Angle, _Angle, _Angle \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 1 \
  add _Angle, _Angle, __RLSBytesCount##_port \
  index _AccAngle, __RLSReadBuf##_port, 2 \
  mul _AccAngle, _AccAngle, 256 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 3 \
  add _AccAngle, _AccAngle, __RLSBytesCount##_port \
  mul _AccAngle, _AccAngle, 256 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 4 \
  add _AccAngle, _AccAngle, __RLSBytesCount##_port \
  mul _AccAngle, _AccAngle, 256 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 5 \
  add _AccAngle, _AccAngle, __RLSBytesCount##_port \
  index _RPM, __RLSReadBuf##_port, 6 \
  mul _RPM, _RPM, 256 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 7 \
  add _RPM, _RPM, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

dseg segment
  __ResetHTBCal byte[] 0xaa, 0x55
  __SetHTBCal byte[] 0x55, 0xaa
  __SetHTBCalByte1Var byte
  __SetHTBCalByte2Var byte
  __SetHTBCalByte10 byte
  __SetHTBCalByte20 byte
  __SetHTBCalByte11 byte
  __SetHTBCalByte21 byte
  __SetHTBCalByte12 byte
  __SetHTBCalByte22 byte
  __SetHTBCalByte13 byte
  __SetHTBCalByte23 byte
dseg ends

#define __ResetHTBarometricCalibration(_port, _result) \
  __I2CWriteToRegister(_port, HT_ADDR_BAROMETRIC, HTBAR_REG_COMMAND, __ResetHTBCal, _result) \
  tst EQ, _result, _result

#define __SetHTBarometricCalibration(_port, _cal, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  div __SetHTBCalByte1Var, _cal, 256 \
  and __SetHTBCalByte2Var, _cal, 0xFF \
  arrbuild __RLSReadBufVar, HT_ADDR_BAROMETRIC, HTBAR_REG_CALIBRATION, __SetHTBCalByte1Var, __SetHTBCalByte2Var \
  set __RLSBytesCountVar, 0 \
  set __RLSPadVar, 0 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  div __SetHTBCalByte1##_port, _cal, 256 \
  and __SetHTBCalByte2##_port, _cal, 0xFF \
  arrbuild __RLSReadBuf##_port, HT_ADDR_BAROMETRIC, HTBAR_REG_CALIBRATION, __SetHTBCalByte1##_port, __SetHTBCalByte2##_port \
  set __RLSBytesCount##_port, 0 \
  set __RLSPad##_port, 0 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  release __RLSBmutex##_port \
  compend \
  brtst EQ, __SHTBCal_EndIf##__I__, _result \
  wait 15 \
  __I2CWriteToRegister(_port, HT_ADDR_BAROMETRIC, HTBAR_REG_COMMAND, __SetHTBCal, _result) \
  tst EQ, _result, _result \
  __SHTBCal_EndIf##__I__: \
  __IncI__

#define __ReadSensorHTBarometric(_port, _t, _p, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 4 \
  set __RLSPadVar, 4 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _t, __RLSReadBufVar, NA \
  index __RLSBytesCountVar, __RLSReadBufVar, 1 \
  mul _t, _t, 256 \
  add _t, _t, __RLSBytesCountVar \
  index _p, __RLSReadBufVar, 2 \
  index __RLSBytesCountVar, __RLSReadBufVar, 3 \
  mul _p, _p, 256 \
  add _p, _p, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 4 \
  set __RLSPad##_port, 4 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _t, __RLSReadBuf##_port, NA \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 1 \
  mul _t, _t, 256 \
  add _t, _t, __RLSBytesCount##_port \
  index _p, __RLSReadBuf##_port, 2 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 3 \
  mul _p, _p, 256 \
  add _p, _p, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTProtoAnalog(_port, _i2caddr, _idx, _a, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, _idx \
  set __RLSBytesCountVar, 2 \
  set __RLSPadVar, 2 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _a, __RLSReadBufVar, NA \
  index __RLSBytesCountVar, __RLSReadBufVar, 1 \
  mul _a, _a, 4 \
  add _a, _a, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, _idx \
  set __RLSBytesCount##_port, 2 \
  set __RLSPad##_port, 2 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _a, __RLSReadBuf##_port, NA \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 1 \
  mul _a, _a, 4 \
  add _a, _a, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTProtoAllAnalog(_port, _a0, _a1, _a2, _a3, _a4, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, HT_ADDR_PROTOBOARD, HTPROTO_REG_A0 \
  set __RLSBytesCountVar, 10 \
  set __RLSPadVar, 10 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _a0, __RLSReadBufVar, NA \
  index __RLSBytesCountVar, __RLSReadBufVar, 1 \
  mul _a0, _a0, 4 \
  add _a0, _a0, __RLSBytesCountVar \
  index _a1, __RLSReadBufVar, 2 \
  index __RLSBytesCountVar, __RLSReadBufVar, 3 \
  mul _a1, _a1, 4 \
  add _a1, _a1, __RLSBytesCountVar \
  index _a2, __RLSReadBufVar, 4 \
  index __RLSBytesCountVar, __RLSReadBufVar, 5 \
  mul _a2, _a2, 4 \
  add _a2, _a2, __RLSBytesCountVar \
  index _a3, __RLSReadBufVar, 6 \
  index __RLSBytesCountVar, __RLSReadBufVar, 7 \
  mul _a3, _a3, 4 \
  add _a3, _a3, __RLSBytesCountVar \
  index _a4, __RLSReadBufVar, 8 \
  index __RLSBytesCountVar, __RLSReadBufVar, 9 \
  mul _a4, _a4, 4 \
  add _a4, _a4, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, HT_ADDR_PROTOBOARD, HTPROTO_REG_A0 \
  set __RLSBytesCount##_port, 10 \
  set __RLSPad##_port, 10 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _a0, __RLSReadBuf##_port, NA \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 1 \
  mul _a0, _a0, 4 \
  add _a0, _a0, __RLSBytesCount##_port \
  index _a1, __RLSReadBuf##_port, 2 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 3 \
  mul _a1, _a1, 4 \
  add _a1, _a1, __RLSBytesCount##_port \
  index _a2, __RLSReadBuf##_port, 4 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 5 \
  mul _a2, _a2, 4 \
  add _a2, _a2, __RLSBytesCount##_port \
  index _a3, __RLSReadBuf##_port, 6 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 7 \
  mul _a3, _a3, 4 \
  add _a3, _a3, __RLSBytesCount##_port \
  index _a4, __RLSReadBuf##_port, 8 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 9 \
  mul _a4, _a4, 4 \
  add _a4, _a4, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

#define __SetSensorHTProtoDigitalControl(_port, _i2caddr, _value, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, 0x4E, _value \
  set __RLSBytesCountVar, 0 \
  set __RLSPadVar, 0 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, 0x4E, _value \
  set __RLSBytesCount##_port, 0 \
  set __RLSPad##_port, 0 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  release __RLSBmutex##_port \
  compend

#define __SetSensorHTProtoDigital(_port, _i2caddr, _value, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, 0x4D, _value \
  set __RLSBytesCountVar, 0 \
  set __RLSPadVar, 0 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, 0x4D, _value \
  set __RLSBytesCount##_port, 0 \
  set __RLSPad##_port, 0 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTProtoDigital(_port, _i2caddr, _pins, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, 0x4C \
  set __RLSBytesCountVar, 1 \
  set __RLSPadVar, 1 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _pins, __RLSReadBufVar, NA \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, 0x4C \
  set __RLSBytesCount##_port, 1 \
  set __RLSPad##_port, 1 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _pins, __RLSReadBuf##_port, NA \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTSuperProAllAnalog(_port, _a0, _a1, _a2, _a3, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, HT_ADDR_SUPERPRO, HTSPRO_REG_A0 \
  set __RLSBytesCountVar, 10 \
  set __RLSPadVar, 10 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _a0, __RLSReadBufVar, NA \
  index __RLSBytesCountVar, __RLSReadBufVar, 1 \
  mul _a0, _a0, 4 \
  add _a0, _a0, __RLSBytesCountVar \
  index _a1, __RLSReadBufVar, 2 \
  index __RLSBytesCountVar, __RLSReadBufVar, 3 \
  mul _a1, _a1, 4 \
  add _a1, _a1, __RLSBytesCountVar \
  index _a2, __RLSReadBufVar, 4 \
  index __RLSBytesCountVar, __RLSReadBufVar, 5 \
  mul _a2, _a2, 4 \
  add _a2, _a2, __RLSBytesCountVar \
  index _a3, __RLSReadBufVar, 6 \
  index __RLSBytesCountVar, __RLSReadBufVar, 7 \
  mul _a3, _a3, 4 \
  add _a3, _a3, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, HT_ADDR_SUPERPRO, HTSPRO_REG_A0 \
  set __RLSBytesCount##_port, 10 \
  set __RLSPad##_port, 10 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _a0, __RLSReadBuf##_port, NA \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 1 \
  mul _a0, _a0, 4 \
  add _a0, _a0, __RLSBytesCount##_port \
  index _a1, __RLSReadBuf##_port, 2 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 3 \
  mul _a1, _a1, 4 \
  add _a1, _a1, __RLSBytesCount##_port \
  index _a2, __RLSReadBuf##_port, 4 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 5 \
  mul _a2, _a2, 4 \
  add _a2, _a2, __RLSBytesCount##_port \
  index _a3, __RLSReadBuf##_port, 6 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 7 \
  mul _a3, _a3, 4 \
  add _a3, _a3, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

dseg segment
  __HTSPAOB1Var byte
  __HTSPAOB2Var byte
  __HTSPAOB3Var byte
  __HTSPAOB4Var byte
  __HTSPAOB10 byte
  __HTSPAOB20 byte
  __HTSPAOB30 byte
  __HTSPAOB40 byte
  __HTSPAOB11 byte
  __HTSPAOB21 byte
  __HTSPAOB31 byte
  __HTSPAOB41 byte
  __HTSPAOB12 byte
  __HTSPAOB22 byte
  __HTSPAOB32 byte
  __HTSPAOB42 byte
  __HTSPAOB13 byte
  __HTSPAOB23 byte
  __HTSPAOB33 byte
  __HTSPAOB43 byte
dseg ends

#define __SetSensorHTSuperProAnalogOut(_port, _dac, _mode, _freq, _volt, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  div __HTSPAOB1Var, _freq, 256 \
  and __HTSPAOB2Var, _freq, 0xFF \
  div __HTSPAOB3Var, _volt, 4 \
  and __HTSPAOB4Var, _volt, 0x03 \
  arrbuild __RLSReadBufVar, HT_ADDR_SUPERPRO, _dac, _mode, __HTSPAOB1Var, __HTSPAOB2Var, __HTSPAOB3Var, __HTSPAOB4Var \
  set __RLSBytesCountVar, 0 \
  set __RLSPadVar, 0 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  div __HTSPAOB1##_port, _freq, 256 \
  and __HTSPAOB2##_port, _freq, 0xFF \
  div __HTSPAOB3##_port, _volt, 4 \
  and __HTSPAOB4##_port, _volt, 0x03 \
  arrbuild __RLSReadBuf##_port, HT_ADDR_SUPERPRO, _dac, _mode, __HTSPAOB1##_port, __HTSPAOB2##_port, __HTSPAOB3##_port, __HTSPAOB4##_port \
  set __RLSBytesCount##_port, 0 \
  set __RLSPad##_port, 0 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  release __RLSBmutex##_port \
  compend

#define __SetSensorHTSuperProStrobe(_port, _value, _result) \
  __I2CWriteToRegister(_port, HT_ADDR_SUPERPRO, HTSPRO_REG_STROBE, _value, _result) \
  tst EQ, _result, _result

#define __SetSensorHTSuperProLED(_port, _value, _result) \
  __I2CWriteToRegister(_port, HT_ADDR_SUPERPRO, HTSPRO_REG_LED, _value, _result) \
  tst EQ, _result, _result

#define __SetSensorHTSuperProProgramControl(_port, _value, _result) \
  __I2CWriteToRegister(_port, HT_ADDR_SUPERPRO, HTSPRO_REG_CTRL, _value, _result) \
  tst EQ, _result, _result

#define __ReadSensorHTSuperProAnalogOut(_port, _dac, _mode, _freq, _volt, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, HT_ADDR_SUPERPRO, _dac \
  set __RLSBytesCountVar, 5 \
  set __RLSPadVar, 5 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _mode, __RLSReadBufVar, NA \
  index _freq, __RLSReadBufVar, 1 \
  index __RLSBytesCountVar, __RLSReadBufVar, 2 \
  mul _freq, _freq, 256 \
  add _freq, _freq, __RLSBytesCountVar \
  index _volt, __RLSReadBufVar, 3 \
  index __RLSBytesCountVar, __RLSReadBufVar, 4 \
  mul _volt, _volt, 4 \
  add _volt, _volt, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, HT_ADDR_SUPERPRO, _dac \
  set __RLSBytesCount##_port, 5 \
  set __RLSPad##_port, 5 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _mode, __RLSReadBuf##_port, NA \
  index _freq, __RLSReadBuf##_port, 1 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 2 \
  mul _freq, _freq, 256 \
  add _freq, _freq, __RLSBytesCount##_port \
  index _volt, __RLSReadBuf##_port, 3 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 4 \
  mul _volt, _volt, 4 \
  add _volt, _volt, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

#define __SetSensorHTPIRDeadband(_port, _value, _result) \
  __I2CWriteToRegister(_port, HT_ADDR_PIR, HTPIR_REG_DEADBAND, _value, _result) \
  tst EQ, _result, _result

#define __ReadSensorHTPIR(_port, _out, _result) \
  __I2CReadValue(_port, HT_ADDR_PIR, HTPIR_REG_READING, 1, _out, _result) \
  sub _out, _out, 128


#endif

/**
 * Set sensor as HiTechnic Gyro.
 * Configure the sensor on the specified port as a HiTechnic Gyro sensor.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 */
#define SetSensorHTGyro(_port) __SetSensorHTGyro(_port)

/**
 * Read HiTechnic Gyro sensor.
 * Read the HiTechnic Gyro sensor on the specified port. The offset value
 * should be calculated by averaging several readings with an offset of zero
 * while the sensor is perfectly still.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants.
 * \param _offset The zero offset.
 * \param _val The Gyro sensor reading.
 */
#define ReadSensorHTGyro(_p, _offset, _val) __ReadSensorHTGyro(_p, _offset, _val)

/**
 * Set sensor as HiTechnic Magnet.
 * Configure the sensor on the specified port as a HiTechnic Magnet sensor.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 */
#define SetSensorHTMagnet(_port) __SetSensorHTGyro(_port)

/**
 * Read HiTechnic Magnet sensor.
 * Read the HiTechnic Magnet sensor on the specified port. The offset value
 * should be calculated by averaging several readings with an offset of zero
 * while the sensor is perfectly still.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants.
 * \param _offset The zero offset.
 * \param _val The Magnet sensor reading.
 */
#define ReadSensorHTMagnet(_p, _offset, _val) __ReadSensorHTGyro(_p, _offset, _val)

/**
 * Set sensor as HiTechnic EOPD.
 * Configure the sensor on the specified port as a HiTechnic EOPD sensor.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _bStd Configure in standard or long-range mode.
 */
#define SetSensorHTEOPD(_port, _bStd) __SetSensorHTEOPD(_port, _bStd)

/**
 * Read HiTechnic EOPD sensor.
 * Read the HiTechnic EOPD sensor on the specified port.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _val The EOPD sensor reading.
 */
#define ReadSensorHTEOPD(_port, _val) __ReadSensorHTEOPD(_port, _val)

/**
 * Set sensor as HiTechnic Force.
 * Configure the sensor on the specified port as a HiTechnic Force sensor.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 */
#define SetSensorHTForce(_port) __SetSensorHTForce(_port)

/**
 * Read HiTechnic Force sensor.
 * Read the HiTechnic Force sensor on the specified port.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants.
 * \param _val The Force sensor reading.
 */
#define ReadSensorHTForce(_p, _val) __ReadSensorHTForce(_p, _val)

/**
 * Read HiTechnic touch multiplexer.
 * Read touch sensor values from the HiTechnic touch multiplexer device.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants.
 * \param _t1 The value of touch sensor 1.
 * \param _t2 The value of touch sensor 2.
 * \param _t3 The value of touch sensor 3.
 * \param _t4 The value of touch sensor 4.
 */
#define ReadSensorHTTouchMultiplexer(_p, _t1, _t2, _t3, _t4) \
  __ReadSensorHTTouchMultiplexer(_p, _t1, _t2, _t3, _t4)

/**
 * Read HiTechnic compass.
 * Read the compass heading value of the HiTechnic Compass sensor on the
 * specified port. The port must be configured as a Lowspeed port before
 * using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The compass heading.
 */
#define ReadSensorHTCompass(_port, _value) \
  __ReadSensorHTCompass(_port, _value)

/**
 * Read HiTechnic color sensor color number.
 * Read the color number from the HiTechnic Color sensor on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The color number.
 */
#define ReadSensorHTColorNum(_port, _value) \
  __ReadSensorHTColorNum(_port, _value)

/**
 * Read HiTechnic IRSeeker direction.
 * Read the direction value of the HiTechnic IR Seeker on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The IRSeeker direction.
 */
#define ReadSensorHTIRSeekerDir(_port, _value) \
  __ReadSensorHTIRSeekerDir(_port, _value)

/**
 * Read HiTechnic IRSeeker2 register.
 * Read a register value from the HiTechnic IR Seeker2 on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _reg The register address. See \ref HTIRSeeker2Constants.
 * \param _value The IRSeeker2 register value.
 */
#define ReadSensorHTIRSeeker2Addr(_port, _reg, _value) \
  __ReadSensorHTIRSeeker2Addr(_port, _reg, _value)

/**
 * Read HiTechnic acceleration values.
 * Read X, Y, and Z axis acceleration values from the HiTechnic Accelerometer
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _x The output x-axis acceleration.
 * \param _y The output y-axis acceleration.
 * \param _z The output z-axis acceleration.
 * \param _result The function call result.
 */
#define ReadSensorHTAccel(_port, _x, _y, _z, _result) \
  __ReadSensorHTAccel(_port, _x, _y, _z, _result)

/**
 * Read HiTechnic Color values.
 * Read color number, red, green, and blue values from the HiTechnic Color
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _ColorNum The output color number.
 * \param _Red The red color value.
 * \param _Green The green color value.
 * \param _Blue The blue color value.
 * \param _result The function call result.
 */
#define ReadSensorHTColor(_port, _ColorNum, _Red, _Green, _Blue, _result) \
  __ReadSensorHTColor(_port, _ColorNum, _Red, _Green, _Blue, _result)

/**
 * Read HiTechnic Color raw values.
 * Read the raw red, green, and blue values from the HiTechnic Color sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _Red The raw red color value.
 * \param _Green The raw green color value.
 * \param _Blue The raw blue color value.
 * \param _result The function call result.
 */
#define ReadSensorHTRawColor(_port, _Red, _Green, _Blue, _result) \
  __ReadSensorHTRawColor(_port, _Red, _Green, _Blue, _result)

/**
 * Read HiTechnic Color normalized values.
 * Read the color index and the normalized red, green, and blue values from
 * the HiTechnic Color sensor. Returns a boolean value indicating whether or
 * not the operation completed successfully. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _ColorIdx The output color index.
 * \param _Red The normalized red color value.
 * \param _Green The normalized green color value.
 * \param _Blue The normalized blue color value.
 * \param _result The function call result.
 */
#define ReadSensorHTNormalizedColor(_port, _ColorIdx, _Red, _Green, _Blue, _result) \
  __ReadSensorHTNormalizedColor(_port, _ColorIdx, _Red, _Green, _Blue, _result)

/**
 * Read HiTechnic IRSeeker values.
 * Read direction, and five signal strength values from the HiTechnic
 * IRSeeker sensor. Returns a boolean value indicating whether or not the
 * operation completed successfully. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _dir The direction.
 * \param _s1 The signal strength from sensor 1.
 * \param _s3 The signal strength from sensor 3.
 * \param _s5 The signal strength from sensor 5.
 * \param _s7 The signal strength from sensor 7.
 * \param _s9 The signal strength from sensor 9.
 * \param _result The function call result.
 */
#define ReadSensorHTIRSeeker(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result) \
  __ReadSensorHTIRSeeker(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result)

/**
 * Read HiTechnic IRSeeker2 DC values.
 * Read direction, five signal strength, and average strength values from the
 * HiTechnic IRSeeker2 sensor. Returns a boolean value indicating whether or
 * not the operation completed successfully. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _dir The direction.
 * \param _s1 The signal strength from sensor 1.
 * \param _s3 The signal strength from sensor 3.
 * \param _s5 The signal strength from sensor 5.
 * \param _s7 The signal strength from sensor 7.
 * \param _s9 The signal strength from sensor 9.
 * \param _avg The average signal strength.
 * \param _result The function call result.
 */
#define ReadSensorHTIRSeeker2DC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _avg, _result) \
  __ReadSensorHTIRSeeker2DC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _avg, _result)

/**
 * Read HiTechnic IRSeeker2 AC values.
 * Read direction, and five signal strength values from the HiTechnic
 * IRSeeker2 sensor in AC mode. Returns a boolean value indicating whether or
 * not the operation completed successfully. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _dir The direction.
 * \param _s1 The signal strength from sensor 1.
 * \param _s3 The signal strength from sensor 3.
 * \param _s5 The signal strength from sensor 5.
 * \param _s7 The signal strength from sensor 7.
 * \param _s9 The signal strength from sensor 9.
 * \param _result The function call result.
 */
#define ReadSensorHTIRSeeker2AC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result) \
  __ReadSensorHTIRSeeker2AC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result)

/**
 * Set HiTechnic IRSeeker2 mode.
 * Set the mode of the HiTechnic IRSeeker2 sensor on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _mode The IRSeeker2 mode. See \ref HTIRSeeker2Constants.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define SetHTIRSeeker2Mode(_port, _mode, _result) \
  __SetHTIRSeeker2Mode(_port, _mode, _result)

/**
 * Set HiTechnic Color2 mode.
 * Set the mode of the HiTechnic Color2 sensor on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _mode The Color2 mode. See \ref HTColor2Constants.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define SetHTColor2Mode(_port, _mode, _result) \
  __SetHTColor2Mode(_port, _mode, _result)

/**
 * Read HiTechnic Color2 active values.
 * Read color number, red, green, and blue values from the HiTechnic Color2
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _ColorNum The output color number.
 * \param _Red The red color value.
 * \param _Green The green color value.
 * \param _Blue The blue color value.
 * \param _White The white color value.
 * \param _result The function call result.
 */
#define ReadSensorHTColor2Active(_port, _ColorNum, _Red, _Green, _Blue, _White, _result) \
  __ReadSensorHTColor2Active(_port, _ColorNum, _Red, _Green, _Blue, _White, _result)

/**
 * Read HiTechnic Color2 normalized active values.
 * Read the color index and the normalized red, green, and blue values from
 * the HiTechnic Color2 sensor. Returns a boolean value indicating whether or
 * not the operation completed successfully. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _ColorIdx The output color index.
 * \param _Red The normalized red color value.
 * \param _Green The normalized green color value.
 * \param _Blue The normalized blue color value.
 * \param _result The function call result.
 */
#define ReadSensorHTNormalizedColor2Active(_port, _ColorIdx, _Red, _Green, _Blue, _result) \
  __ReadSensorHTNormalizedColor2Active(_port, _ColorIdx, _Red, _Green, _Blue, _result)

/**
 * Read HiTechnic Color2 raw values.
 * Read the raw red, green, and blue values from the HiTechnic Color2 sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _Red The raw red color value.
 * \param _Green The raw green color value.
 * \param _Blue The raw blue color value.
 * \param _White The raw white color value.
 * \param _result The function call result.
 */
#define ReadSensorHTRawColor2(_port, _Red, _Green, _Blue, _White, _result) \
  __ReadSensorHTRawColor2(_port, _Red, _Green, _Blue, _White, _result)

/**
 * Read HiTechnic IRReceiver Power Function bytes.
 * Read Power Function bytes from the HiTechnic IRReceiver sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _pfdata Eight bytes of power function remote IR data.
 * \param _result The function call result.
 */
#define ReadSensorHTIRReceiver(_port, _pfdata, _result) \
  __ReadSensorHTIRReceiver(_port, _pfdata, _result)

/**
 * Read HiTechnic IRReceiver Power Function value.
 * Read a Power Function byte from the HiTechnic IRReceiver sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _reg The power function data offset. See \ref HTIRReceiverConstants.
 * \param _pfchar A single byte of power function remote IR data.
 * \param _result The function call result.
 */
#define ReadSensorHTIRReceiverEx(_port, _reg, _pfchar, _result) \
  __ReadSensorHTIRReceiverEx(_port, _reg, _pfchar, _result)

/**
 * Reset HiTechnic Angle sensor.
 * Reset the HiTechnic Angle sensor on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _mode The Angle reset mode. See \ref HTAngleConstants.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define ResetSensorHTAngle(_port, _mode, _result) \
  __ResetSensorHTAngle(_port, _mode, _result)

/**
 * Read HiTechnic Angle sensor values.
 * Read values from the HiTechnic Angle sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _Angle Current angle in degrees (0-359).
 * \param _AccAngle Accumulated angle in degrees (-2147483648 to 2147483647).
 * \param _RPM rotations per minute (-1000 to 1000).
 * \param _result The function call result.
 */
#define ReadSensorHTAngle(_port, _Angle, _AccAngle, _RPM, _result) \
  __ReadSensorHTAngle(_port, _Angle, _AccAngle, _RPM, _result)

/**
 * Reset HiTechnic Barometric sensor calibration.
 * Reset the HiTechnic Barometric sensor to its factory calibration.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _result The function call result.
 */
#define ResetHTBarometricCalibration(_port, _result) \
  __ResetHTBarometricCalibration(_port, _result)

/**
 * Set HiTechnic Barometric sensor calibration.
 * Set the HiTechnic Barometric sensor pressure calibration value.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _cal The new pressure calibration value.
 * \param _result The function call result.
 */
#define SetHTBarometricCalibration(_port, _cal, _result) \
  __SetHTBarometricCalibration(_port, _cal, _result)

/**
 * Read HiTechnic Barometric sensor values.
 * Read values from the HiTechnic Barometric sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _temp Current temperature in 1/10ths of degrees Celcius.
 * \param _press Current barometric pressure in 1/1000 inches of mercury.
 * \param _result The function call result.
 */
#define ReadSensorHTBarometric(_port, _temp, _press, _result) \
  __ReadSensorHTBarometric(_port, _temp, _press, _result)

/**
 * Read HiTechnic Prototype board analog input value.
 * Read an analog input value from the HiTechnic prototype board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _input The analog input. See \ref HTProtoAnalogInputConstants.
 * \param _value The analog input value.
 * \param _result The function call result.
 */
#define ReadSensorHTProtoAnalog(_port, _input, _value, _result) \
  __ReadSensorHTProtoAnalog(_port, HT_ADDR_PROTOBOARD, _input, _value, _result)

/**
 * Read all HiTechnic Prototype board analog input values.
 * Read all 5 analog input values from the HiTechnic prototype board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _a0 The A0 analog input value.
 * \param _a1 The A1 analog input value.
 * \param _a2 The A2 analog input value.
 * \param _a3 The A3 analog input value.
 * \param _a4 The A4 analog input value.
 * \param _result The function call result.
 */
#define ReadSensorHTProtoAllAnalog(_port, _a0, _a1, _a2, _a3, _a4, _result) \
  __ReadSensorHTProtoAllAnalog(_port, _a0, _a1, _a2, _a3, _a4, _result)

/**
 * Set HiTechnic Prototype board digital pin direction.
 * Set which of the six digital pins on the HiTechnic prototype board should be outputs.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The digital pin control value. See \ref DigitalPinConstants.
 * OR into this value the pins that you want to be output pins.  The pins not
 * included in the value will be input pins.
 * \param _result The function call result.
 */
#define SetSensorHTProtoDigitalControl(_port, _value, _result) \
  __SetSensorHTProtoDigitalControl(_port, HT_ADDR_PROTOBOARD, _value, _result)

/**
 * Read HiTechnic Prototype board digital pin control value.
 * Read the HiTechnic prototype board digital control value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _out The digital control value. See \ref LEDCtrlConstants.
 * \param _result The function call result.
 */
#define ReadSensorHTProtoDigitalControl(_port, _out, _result) \
  __I2CReadValue(_port, HT_ADDR_PROTOBOARD, HTPROTO_REG_DCTRL, 1, _out, _result)

/**
 * Set HiTechnic Prototype board digital output values.
 * Set the digital pin output values on the HiTechnic prototype board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The digital pin output values. See \ref DigitalPinConstants.
 * \param _result The function call result.
 */
#define SetSensorHTProtoDigital(_port, _value, _result) \
  __SetSensorHTProtoDigital(_port, HT_ADDR_PROTOBOARD, _value, _result)

/**
 * Read HiTechnic Prototype board digital input values.
 * Read digital input values from the HiTechnic prototype board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The digital input values. See \ref DigitalPinConstants.
 * \param _result The function call result.
 */
#define ReadSensorHTProtoDigital(_port, _value, _result) \
  __ReadSensorHTProtoDigital(_port, HT_ADDR_PROTOBOARD, _value, _result)

/**
 * Read HiTechnic SuperPro board analog input value.
 * Read an analog input value from the HiTechnic SuperPro board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _input The analog input. See \ref HTSProAnalogInputConstants.
 * \param _value The analog input value.
 * \param _result The function call result.
 */
#define ReadSensorHTSuperProAnalog(_port, _input, _value, _result) \
  __ReadSensorHTProtoAnalog(_port, HT_ADDR_SUPERPRO, _input, _value, _result)

/**
 * Read all HiTechnic SuperPro board analog input values.
 * Read all 4 analog input values from the HiTechnic SuperPro board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _a0 The A0 analog input value.
 * \param _a1 The A1 analog input value.
 * \param _a2 The A2 analog input value.
 * \param _a3 The A3 analog input value.
 * \param _result The function call result.
 */
#define ReadSensorHTSuperProAllAnalog(_port, _a0, _a1, _a2, _a3, _result) \
  __ReadSensorHTSuperProAllAnalog(_port, _a0, _a1, _a2, _a3, _result)

/**
 * Control HiTechnic SuperPro board digital pin direction.
 * Control the direction of the eight digital pins on the HiTechnic SuperPro board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The digital pin control value. See \ref DigitalPinConstants.
 * OR into this value the pins that you want to be output pins.  The pins not
 * included in the value will be input pins.
 * \param _result The function call result.
 */
#define SetSensorHTSuperProDigitalControl(_port, _value, _result) \
  __SetSensorHTProtoDigitalControl(_port, HT_ADDR_SUPERPRO, _value, _result)

/**
 * Read HiTechnic SuperPro digital control value.
 * Read the HiTechnic SuperPro digital control value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _out The digital control value. See \ref LEDCtrlConstants.
 * \param _result The function call result.
 */
#define ReadSensorHTSuperProDigitalControl(_port, _out, _result) \
  __I2CReadValue(_port, HT_ADDR_SUPERPRO, HTSPRO_REG_DCTRL, 1, _out, _result)

/**
 * Set HiTechnic SuperPro board digital output values.
 * Set the digital pin output values on the HiTechnic SuperPro board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The digital pin output values. See \ref DigitalPinConstants.
 * \param _result The function call result.
 */
#define SetSensorHTSuperProDigital(_port, _value, _result) \
  __SetSensorHTProtoDigital(_port, HT_ADDR_SUPERPRO, _value, _result)

/**
 * Read HiTechnic SuperPro board digital input values.
 * Read digital input values from the HiTechnic SuperPro board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The digital input values. See \ref DigitalPinConstants.
 * \param _result The function call result.
 */
#define ReadSensorHTSuperProDigital(_port, _value, _result) \
  __ReadSensorHTProtoDigital(_port, HT_ADDR_SUPERPRO, _value, _result)

/**
 * Set HiTechnic SuperPro board analog output parameters.
 * Set the analog output parameters on the HiTechnic SuperPro board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _dac The analog output index. See \ref HTSProDACIndexConstants.
 * \param _mode The analog output mode. See \ref DacModeConstants.
 * \param _freq The analog output frequency. Between 1 and 8191.
 * \param _volt The analog output voltage level. A 10 bit value (0..1023).
 * \param _result The function call result.
 */
#define SetSensorHTSuperProAnalogOut(_port, _dac, _mode, _freq, _volt, _result) \
  __SetSensorHTSuperProAnalogOut(_port, _dac, _mode, _freq, _volt, _result)

/**
 * Read HiTechnic SuperPro board analog output parameters.
 * Read the analog output parameters on the HiTechnic SuperPro board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _dac The analog output index. See \ref HTSProDACIndexConstants.
 * \param _mode The analog output mode. See \ref DacModeConstants.
 * \param _freq The analog output frequency. Between 1 and 8191.
 * \param _volt The analog output voltage level. A 10 bit value (0..1023).
 * \param _result The function call result.
 */
#define ReadSensorHTSuperProAnalogOut(_port, _dac, _mode, _freq, _volt, _result) \
  __ReadSensorHTSuperProAnalogOut(_port, _dac, _mode, _freq, _volt, _result)

/**
 * Set HiTechnic SuperPro LED value.
 * Set the HiTechnic SuperPro LED value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The LED value. See \ref LEDCtrlConstants.
 * \param _result The function call result.
 */
#define SetSensorHTSuperProLED(_port, _value, _result) \
  __SetSensorHTSuperProLED(_port, _value, _result)

/**
 * Read HiTechnic SuperPro LED value.
 * Read the HiTechnic SuperPro LED value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _out The LED value. See \ref LEDCtrlConstants.
 * \param _result The function call result.
 */
#define ReadSensorHTSuperProLED(_port, _out, _result) \
  __I2CReadValue(_port, HT_ADDR_SUPERPRO, HTSPRO_REG_LED, 1, _out, _result)

/**
 * Set HiTechnic SuperPro strobe value.
 * Set the HiTechnic SuperPro strobe value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The strobe value. See \ref StrobeCtrlConstants.
 * \param _result The function call result.
 */
#define SetSensorHTSuperProStrobe(_port, _value, _result) \
  __SetSensorHTSuperProStrobe(_port, _value, _result)

/**
 * Read HiTechnic SuperPro strobe value.
 * Read the HiTechnic SuperPro strobe value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _out The strobe value. See \ref StrobeCtrlConstants.
 * \param _result The function call result.
 */
#define ReadSensorHTSuperProStrobe(_port, _out, _result) \
  __I2CReadValue(_port, HT_ADDR_SUPERPRO, HTSPRO_REG_STROBE, 1, _out, _result)

/**
 * Set HiTechnic SuperPro program control value.
 * Set the HiTechnic SuperPro program control value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The program control value.
 * \param _result The function call result.
 */
#define SetSensorHTSuperProProgramControl(_port, _value, _result) \
  __SetSensorHTSuperProProgramControl(_port, _value, _result)

/**
 * Read HiTechnic SuperPro program control value.
 * Read the HiTechnic SuperPro program control value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _out The program control value.
 * \param _result The function call result.
 */
#define ReadSensorHTSuperProProgramControl(_port, _out, _result) \
  __I2CReadValue(_port, HT_ADDR_SUPERPRO, HTSPRO_REG_CTRL, 1, _out, _result)

/**
 * Set HiTechnic PIR deadband value.
 * Set the HiTechnic PIR deadband value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The deadband value. Valid values are 0..47.
 * \param _result The function call result.
 */
#define SetSensorHTPIRDeadband(_port, _value, _result) \
  __SetSensorHTPIRDeadband(_port, _value, _result)

/**
 * Read HiTechnic PIR measurement value.
 * Read the HiTechnic PIR measurement value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref InPorts.
 * \param _value The passive infrared reading.  A signed byte (-128..127).
 * \param _result The function call result.
 */
#define ReadSensorHTPIR(_port, _out, _result) __ReadSensorHTPIR(_port, _out, _result)

/**
 * Read HiTechnic PIR deadband value.
 * Read the HiTechnic PIR deadband value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param _value The PIR deadband value. Values are between 0 and 47.
 * \param _result The function call result.
 */
#define ReadSensorHTPIRDeadband(_port, _out, _result) \
  __I2CReadValue(_port, HT_ADDR_PIR, HTPIR_REG_DEADBAND, 1, _out, _result)

/** @} */ // end of HiTechnicAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // NBC_HITECHNIC_H
