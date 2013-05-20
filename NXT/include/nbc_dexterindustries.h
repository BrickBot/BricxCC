/** \file NBC_dexterindustries.h
 * \brief The NBC Dexter Industries API
 *
 * nbc_dexterindustries.h contains the NBC Dexter Industries API
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

#ifndef NBC_DEXTERINDUSTRIES_H
#define NBC_DEXTERINDUSTRIES_H

#include "dexterindustries_constants.h"
#include "nbc_lowspeed.h"
#include "nbc_cmath.h"

/** @addtogroup ThirdPartyDevices
 * @{
 */

///////////////////////////////////////////////////////////////////////////////
///////////////////////// Dexter Industries API ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup DexterIndustriesAPI
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

#define __ReadSensorDIGPSStatus(_port, _status) __I2CReadBEValue(_port, DI_ADDR_DGPS, DGPS_REG_STATUS, 1, _status, __RDSD_LSStatus)
#define __ReadSensorDIGPSTime(_port, _result) __I2CReadBEValue(_port, DI_ADDR_DGPS, DGPS_REG_TIME, 4, _result, __RDSD_LSStatus)
#define __ReadSensorDIGPSLatitude(_port, _result) __I2CReadBEValue(_port, DI_ADDR_DGPS, DGPS_REG_LATITUDE, 4, _result, __RDSD_LSStatus)
#define __ReadSensorDIGPSLongitude(_port, _result) __I2CReadBEValue(_port, DI_ADDR_DGPS, DGPS_REG_LONGITUDE, 4, _result, __RDSD_LSStatus)
#define __ReadSensorDIGPSVelocity(_port, _result) __I2CReadBEValue(_port, DI_ADDR_DGPS, DGPS_REG_VELOCITY, 3, _result, __RDSD_LSStatus)
#define __ReadSensorDIGPSHeading(_port, _result) __I2CReadBEValue(_port, DI_ADDR_DGPS, DGPS_REG_HEADING, 2, _result, __RDSD_LSStatus)
#define __ReadSensorDIGPSDistanceToWaypoint(_port, _result) __I2CReadBEValue(_port, DI_ADDR_DGPS, DGPS_REG_DISTANCE, 4, _result, __RDSD_LSStatus)
#define __ReadSensorDIGPSHeadingToWaypoint(_port, _result) __I2CReadBEValue(_port, DI_ADDR_DGPS, DGPS_REG_WAYANGLE, 2, _result, __RDSD_LSStatus)
#define __ReadSensorDIGPSRelativeHeading(_port, _result) __I2CReadBEValue(_port, DI_ADDR_DGPS, DGPS_REG_LASTANGLE, 4, _result, __RDSD_LSStatus)

#define __DIGYRO_0250DPS 114.2857
#define __DIGYRO_0500DPS  57.1429
#define __DIGYRO_2000DPS  14.2857

dseg segment
  __digyro_divisor float[] {__DIGYRO_0250DPS, __DIGYRO_0250DPS, __DIGYRO_0250DPS, __DIGYRO_0250DPS}
  __tmp_digyro_divisor float
  __tmp_digyro0 sword
  __tmp_digyro1 sword
  __tmp_digyro2 sword
  __tmp_digyro3 sword
  __tmp_digyroVar sword
  __tmp_digyrotemp sbyte
  __tmp_digyrovector TVector
dseg ends

#define __SetSensorDIGyro(_port, _range, _odr, _bw, _result) \
  __SetSensorLowspeed(_port) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  or __RLSReadPort, _odr, _bw \
  or __RLSReadPort, __RLSReadPort, 0x0F \
  or __RLSBytesCountVar, _range, DIGYRO_CTRL4_BLOCKDATA \
  and __RLSBytesCountVar, __RLSBytesCountVar, 0xF0 \
  arrbuild __RLSReadBufVar, DI_ADDR_GYRO, DIGYRO_REG_CTRL1AUTO, __RLSReadPort, 0x00, 0x08, __RLSBytesCountVar, 0x02, 0x00 \
  set __RLSBytesCountVar, 0 \
  set __RLSPadVar, 0 \
  mov __RLSReadPort, _port \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  mov __tmp_digyro_divisor, __DIGYRO_2000DPS \
  brcmp EQ, __SSDIG_EndIf##__I__, DIGYRO_CTRL4_SCALE_2000, _range \
  mov __tmp_digyro_divisor, __DIGYRO_0500DPS \
  brcmp EQ, __SSDIG_EndIf##__I__, DIGYRO_CTRL4_SCALE_500, _range \
  mov __tmp_digyro_divisor, __DIGYRO_0250DPS \
  __SSDIG_EndIf##__I__: \
  __IncI__ \
  replace __digyro_divisor, __digyro_divisor, _port, __tmp_digyro_divisor \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  or __RLSReadPort, _odr, _bw \
  or __RLSReadPort, __RLSReadPort, 0x0F \
  or __RLSBytesCount##_port, _range, DIGYRO_CTRL4_BLOCKDATA \
  and __RLSBytesCount##_port, __RLSBytesCount##_port, 0xF0 \
  arrbuild __RLSReadBuf##_port, DI_ADDR_GYRO, DIGYRO_REG_CTRL1AUTO, __RLSReadPort, 0x00, 0x08, __RLSBytesCount##_port, 0x02, 0x00 \
  set __RLSBytesCount##_port, 0 \
  set __RLSPad##_port, 0 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  mov __tmp_digyro_divisor, __DIGYRO_2000DPS \
  brcmp EQ, __SSDIG_EndIf##__I__, DIGYRO_CTRL4_SCALE_2000, _range \
  mov __tmp_digyro_divisor, __DIGYRO_0500DPS \
  brcmp EQ, __SSDIG_EndIf##__I__, DIGYRO_CTRL4_SCALE_500, _range \
  mov __tmp_digyro_divisor, __DIGYRO_0250DPS \
  __SSDIG_EndIf##__I__: \
  __IncI__ \
  replace __digyro_divisor, __digyro_divisor, _port, __tmp_digyro_divisor \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorDIGyroRaw(_port, _vector, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, DI_ADDR_GYRO, DIGYRO_REG_XLOWBURST \
  set __RLSBytesCountVar, 6 \
  set __RLSPadVar, 6 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index __RLSBytesCountVar, __RLSReadBufVar, NA \
  index __tmp_digyroVar, __RLSReadBufVar, 1 \
  mul __tmp_digyroVar, __tmp_digyroVar, 256 \
  add __tmp_digyroVar, __tmp_digyroVar, __RLSBytesCountVar \
  mov _vector.Y, __tmp_digyroVar \
  index __RLSBytesCountVar, __RLSReadBufVar, 2 \
  index __tmp_digyroVar, __RLSReadBufVar, 3 \
  mul __tmp_digyroVar, __tmp_digyroVar, 256 \
  add __tmp_digyroVar, __tmp_digyroVar, __RLSBytesCountVar \
  sub _vector.X, 0, __tmp_digyroVar \
  index __RLSBytesCountVar, __RLSReadBufVar, 4 \
  index __tmp_digyroVar, __RLSReadBufVar, 5 \
  mul __tmp_digyroVar, __tmp_digyroVar, 256 \
  add __tmp_digyroVar, __tmp_digyroVar, __RLSBytesCountVar \
  mov _vector.Z, __tmp_digyroVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, DI_ADDR_GYRO, DIGYRO_REG_XLOWBURST \
  set __RLSBytesCount##_port, 6 \
  set __RLSPad##_port, 6 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, NA \
  index __tmp_digyro##_port, __RLSReadBuf##_port, 1 \
  mul __tmp_digyro##_port, __tmp_digyro##_port, 256 \
  add __tmp_digyro##_port, __tmp_digyro##_port, __RLSBytesCount##_port \
  mov _vector.Y, __tmp_digyro##_port \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 2 \
  index __tmp_digyro##_port, __RLSReadBuf##_port, 3 \
  mul __tmp_digyro##_port, __tmp_digyro##_port, 256 \
  add __tmp_digyro##_port, __tmp_digyro##_port, __RLSBytesCount##_port \
  sub _vector.X, 0, __tmp_digyro##_port \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 4 \
  index __tmp_digyro##_port, __RLSReadBuf##_port, 5 \
  mul __tmp_digyro##_port, __tmp_digyro##_port, 256 \
  add __tmp_digyro##_port, __tmp_digyro##_port, __RLSBytesCount##_port \
  mov _vector.Z, __tmp_digyro##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorDIGyro(_port, _vector, _result) \
  __ReadSensorDIGyroRaw(_port, _vector, _result) \
  index __tmp_digyro_divisor, __digyro_divisor, _port \
  div _vector.X, _vector.X, __tmp_digyro_divisor \
  div _vector.Y, _vector.Y, __tmp_digyro_divisor \
  div _vector.Z, _vector.Z, __tmp_digyro_divisor

#define __ReadSensorDIGyroTemperature(_port, _out, _result) \
  __I2CReadValue(_port, DI_ADDR_GYRO, DIGYRO_REG_OUTTEMP, 1, _out, _result)

#define __ReadSensorDIGyroStatus(_port, _out, _result) \
  __I2CReadValue(_port, DI_ADDR_GYRO, DIGYRO_REG_STATUS, 1, _out, _result)

dseg segment
  __diaccl_divisor sword[] {64, 64, 64, 64}
  __tmp_diaccl_divisor sword
  __tmp_diaccl10 sword
  __tmp_diaccl11 sword
  __tmp_diaccl12 sword
  __tmp_diaccl13 sword
  __tmp_diaccl20 sword
  __tmp_diaccl21 sword
  __tmp_diaccl22 sword
  __tmp_diaccl23 sword
  __tmp_diaccl1Var sword
  __tmp_diaccl2Var sword
  __tmp_diaccltemp sbyte
  __tmp_diacclvector TVector
dseg ends

#define __SetSensorDIAccl(_port, _mode, _result) \
  __SetSensorLowspeed(_port) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  or __RLSBytesCountVar, _mode, DIACCL_MODE_MEASURE \
  arrbuild __RLSReadBufVar, DI_ADDR_ACCL, DIACCL_REG_MODECTRL, __RLSBytesCountVar \
  set __RLSBytesCountVar, 0 \
  set __RLSPadVar, 0 \
  mov __RLSReadPort, _port \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  set __tmp_diaccl_divisor, 64 \
  brcmp EQ, __SSDIA_EndIf##__I__, DIACCL_MODE_GLVL2, _mode \
  set __tmp_diaccl_divisor, 32 \
  brcmp EQ, __SSDIA_EndIf##__I__, DIACCL_MODE_GLVL4, _mode \
  set __tmp_diaccl_divisor, 16 \
  __SSDIA_EndIf##__I__: \
  __IncI__ \
  replace __diaccl_divisor, __diaccl_divisor, _port, __tmp_diaccl_divisor \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  or __RLSBytesCount##_port, _mode, DIACCL_MODE_MEASURE \
  arrbuild __RLSReadBuf##_port, DI_ADDR_ACCL, DIACCL_REG_MODECTRL, __RLSBytesCount##_port \
  set __RLSBytesCount##_port, 0 \
  set __RLSPad##_port, 0 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  set __tmp_diaccl_divisor, 64 \
  brcmp EQ, __SSDIA_EndIf##__I__, DIACCL_MODE_GLVL2, _mode \
  set __tmp_diaccl_divisor, 32 \
  brcmp EQ, __SSDIA_EndIf##__I__, DIACCL_MODE_GLVL4, _mode \
  set __tmp_diaccl_divisor, 16 \
  __SSDIA_EndIf##__I__: \
  __IncI__ \
  replace __diaccl_divisor, __diaccl_divisor, _port, __tmp_diaccl_divisor \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorDIAcclRaw(_port, _reg, _vector, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, DI_ADDR_ACCL, _reg \
  set __RLSBytesCountVar, 6 \
  set __RLSPadVar, 6 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index __tmp_diaccl1Var, __RLSReadBufVar, NA \
  index __tmp_diaccl2Var, __RLSReadBufVar, 1 \
  mul __tmp_diaccl1Var, __tmp_diaccl1Var, 64 \
  mul __tmp_diaccl2Var, __tmp_diaccl2Var, 16384 \
  or __tmp_diaccl1Var, __tmp_diaccl1Var, __tmp_diaccl2Var \
  div __tmp_diaccl1Var, __tmp_diaccl1Var, 64 \
  mov _vector.X, __tmp_diaccl1Var \
  index __tmp_diaccl1Var, __RLSReadBufVar, 2 \
  index __tmp_diaccl2Var, __RLSReadBufVar, 3 \
  mul __tmp_diaccl1Var, __tmp_diaccl1Var, 64 \
  mul __tmp_diaccl2Var, __tmp_diaccl2Var, 16384 \
  or __tmp_diaccl1Var, __tmp_diaccl1Var, __tmp_diaccl2Var \
  div __tmp_diaccl1Var, __tmp_diaccl1Var, 64 \
  mov _vector.Y, __tmp_diaccl1Var \
  index __tmp_diaccl1Var, __RLSReadBufVar, 4 \
  index __tmp_diaccl2Var, __RLSReadBufVar, 5 \
  mul __tmp_diaccl1Var, __tmp_diaccl1Var, 64 \
  mul __tmp_diaccl2Var, __tmp_diaccl2Var, 16384 \
  or __tmp_diaccl1Var, __tmp_diaccl1Var, __tmp_diaccl2Var \
  div __tmp_diaccl1Var, __tmp_diaccl1Var, 64 \
  mov _vector.Z, __tmp_diaccl1Var \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, DI_ADDR_ACCL, _reg \
  set __RLSBytesCount##_port, 6 \
  set __RLSPad##_port, 6 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index __tmp_diaccl1##_port, __RLSReadBuf##_port, NA \
  index __tmp_diaccl2##_port, __RLSReadBuf##_port, 1 \
  mul __tmp_diaccl1##_port, __tmp_diaccl1##_port, 64 \
  mul __tmp_diaccl2##_port, __tmp_diaccl2##_port, 16384 \
  or __tmp_diaccl1##_port, __tmp_diaccl1##_port, __tmp_diaccl2##_port \
  div __tmp_diaccl1##_port, __tmp_diaccl1##_port, 64 \
  mov _vector.X, __tmp_diaccl1##_port \
  index __tmp_diaccl1##_port, __RLSReadBuf##_port, 2 \
  index __tmp_diaccl2##_port, __RLSReadBuf##_port, 3 \
  mul __tmp_diaccl1##_port, __tmp_diaccl1##_port, 64 \
  mul __tmp_diaccl2##_port, __tmp_diaccl2##_port, 16384 \
  or __tmp_diaccl1##_port, __tmp_diaccl1##_port, __tmp_diaccl2##_port \
  div __tmp_diaccl1##_port, __tmp_diaccl1##_port, 64 \
  mov _vector.Y, __tmp_diaccl1##_port \
  index __tmp_diaccl1##_port, __RLSReadBuf##_port, 4 \
  index __tmp_diaccl2##_port, __RLSReadBuf##_port, 5 \
  mul __tmp_diaccl1##_port, __tmp_diaccl1##_port, 64 \
  mul __tmp_diaccl2##_port, __tmp_diaccl2##_port, 16384 \
  or __tmp_diaccl1##_port, __tmp_diaccl1##_port, __tmp_diaccl2##_port \
  div __tmp_diaccl1##_port, __tmp_diaccl1##_port, 64 \
  mov _vector.Z, __tmp_diaccl1##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorDIAccl8Raw(_port, _vector, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, DI_ADDR_ACCL, DIACCL_REG_X8 \
  set __RLSBytesCountVar, 3 \
  set __RLSPadVar, 3 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index __tmp_diaccltemp, __RLSReadBufVar, NA \
  mov _vector.X, __tmp_diaccltemp \
  index __tmp_diaccltemp, __RLSReadBufVar, 1 \
  mov _vector.Y, __tmp_diaccltemp \
  index __tmp_diaccltemp, __RLSReadBufVar, 2 \
  mov _vector.Z, __tmp_diaccltemp \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, DI_ADDR_ACCL, DIACCL_REG_X8 \
  set __RLSBytesCount##_port, 3 \
  set __RLSPad##_port, 3 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index __tmp_diaccltemp, __RLSReadBuf##_port, NA \
  mov _vector.X, __tmp_diaccltemp \
  index __tmp_diaccltemp, __RLSReadBuf##_port, 1 \
  mov _vector.Y, __tmp_diaccltemp \
  index __tmp_diaccltemp, __RLSReadBuf##_port, 2 \
  mov _vector.Z, __tmp_diaccltemp \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorDIAccl(_port, _vector, _result) \
  __ReadSensorDIAcclRaw(_port, DIACCL_REG_XLOW, _vector, _result) \
  index __tmp_diaccl_divisor, __diaccl_divisor, _port \
  div _vector.X, _vector.X, __tmp_diaccl_divisor \
  div _vector.Y, _vector.Y, __tmp_diaccl_divisor \
  div _vector.Z, _vector.Z, __tmp_diaccl_divisor

#define __ReadSensorDIAccl8(_port, _vector, _result) \
  __ReadSensorDIAccl8Raw(_port, _vector, _result) \
  index __tmp_diaccl_divisor, __diaccl_divisor, _port \
  div _vector.X, _vector.X, __tmp_diaccl_divisor \
  div _vector.Y, _vector.Y, __tmp_diaccl_divisor \
  div _vector.Z, _vector.Z, __tmp_diaccl_divisor

#define __ReadSensorDIAcclStatus(_port, _out, _result) \
  __I2CReadValue(_port, DI_ADDR_ACCL, DIACCL_REG_STATUS, 1, _out, _result)

#define __ReadSensorDIAcclDrift(_port, _x, _y, _z, _result) \
  __ReadSensorDIAcclRaw(_port, DIACCL_REG_XLOWDRIFT, __tmp_diacclvector, _result) \
  mov _x, __tmp_diacclvector.X \
  mov _y, __tmp_diacclvector.Y \
  mov _z, __tmp_diacclvector.Z

dseg segment
  __DIADWVar word
  __DIADW0 word
  __DIADW1 word
  __DIADW2 word
  __DIADW3 word
  __DIADB1Var byte
  __DIADB2Var byte
  __DIADB3Var byte
  __DIADB4Var byte
  __DIADB5Var byte
  __DIADB6Var byte
  __DIADB10 byte
  __DIADB20 byte
  __DIADB30 byte
  __DIADB40 byte
  __DIADB50 byte
  __DIADB60 byte
  __DIADB11 byte
  __DIADB21 byte
  __DIADB31 byte
  __DIADB41 byte
  __DIADB51 byte
  __DIADB61 byte
  __DIADB12 byte
  __DIADB22 byte
  __DIADB32 byte
  __DIADB42 byte
  __DIADB52 byte
  __DIADB62 byte
  __DIADB13 byte
  __DIADB23 byte
  __DIADB33 byte
  __DIADB43 byte
  __DIADB53 byte
  __DIADB63 byte
dseg ends

#define __SetSensorDIAcclDrift(_port, _x, _y, _z, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __DIADWVar, _x \
  and __DIADB1Var, __DIADWVar, 0xFF \
  div __DIADB2Var, __DIADWVar, 256 \
  mov __DIADWVar, _y \
  and __DIADB3Var, __DIADWVar, 0xFF \
  div __DIADB4Var, __DIADWVar, 256 \
  mov __DIADWVar, _z \
  and __DIADB5Var, __DIADWVar, 0xFF \
  div __DIADB6Var, __DIADWVar, 256 \
  arrbuild __RLSReadBufVar, DI_ADDR_ACCL, DIACCL_REG_XLOWDRIFT, __DIADB1Var, __DIADB2Var, __DIADB3Var, __DIADB4Var, __DIADB5Var, __DIADB6Var \
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
  mov __DIADW##_port, _x \
  and __DIADB1##_port, __DIADW##_port, 0xFF \
  div __DIADB2##_port, __DIADW##_port, 256 \
  mov __DIADW##_port, _y \
  and __DIADB3##_port, __DIADW##_port, 0xFF \
  div __DIADB4##_port, __DIADW##_port, 256 \
  mov __DIADW##_port, _z \
  and __DIADB5##_port, __DIADW##_port, 0xFF \
  div __DIADB6##_port, __DIADW##_port, 256 \
  arrbuild __RLSReadBuf##_port, DI_ADDR_ACCL, DIACCL_REG_XLOWDRIFT, __DIADB1##_port, __DIADB2##_port, __DIADB3##_port, __DIADB4##_port, __DIADB5##_port, __DIADB6##_port \
  set __RLSBytesCount##_port, 0 \
  set __RLSPad##_port, 0 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  release __RLSBmutex##_port \
  compend

dseg segment
  __BEBFLMutex mutex
  __BEBFLIn slong
  __BEBFLB1 byte
  __BEBFLB2 byte
  __BEBFLB3 byte
  __BEBFLB4 byte
  __BEBFLOut byte[]
dseg ends

subroutine __BEBufferFromLong
  flatten __BEBFLOut, __BEBFLIn
  index __BEBFLB1, __BEBFLOut, NA
  index __BEBFLB2, __BEBFLOut, 1
  index __BEBFLB3, __BEBFLOut, 2
  index __BEBFLB4, __BEBFLOut, 3
  arrbuild __BEBFLOut, __BEBFLB4, __BEBFLB3, __BEBFLB2, __BEBFLB1
  return
ends

dseg segment
  __DGPSWay_Buffer byte[]
  __DGPSWaymutex mutex
dseg ends

#define __SetSensorDIGPSWaypoint(_port, _lat, _long, _result) \
  acquire __DGPSWaymutex \
  acquire __BEBFLMutex \
  mov __BEBFLIn, _lat \
  call __BEBufferFromLong \
  arrbuild __DGPSWay_Buffer, DI_ADDR_DGPS, DGPS_REG_SETLATITUDE, __BEBFLOut \
  release __BEBFLMutex \
  __lowspeedWrite(_port, 0, __DGPSWay_Buffer, _result) \
  wait 150 \
  acquire __BEBFLMutex \
  mov __BEBFLIn, _long \
  call __BEBufferFromLong \
  arrbuild __DGPSWay_Buffer, DI_ADDR_DGPS, DGPS_REG_SETLONGITUDE, __BEBFLOut \
  release __BEBFLMutex \
  __lowspeedWrite(_port, 0, __DGPSWay_Buffer, _result) \
  wait 50 \
  release __DGPSWaymutex

#endif

// Dexter Industries GPS functions

/**
 * ReadSensorDIGPSStatus function.
 * Read the status of the GPS satellite link.
 *
 * \param _port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _status The GPS status
 */
#define ReadSensorDIGPSStatus(_port, _status) __ReadSensorDIGPSStatus(_port, _status)

/**
 * ReadSensorDIGPSTime function.
 * Read the current time reported by the GPS in UTC.
 *
 * \param _port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The current time in UTC
 */
#define ReadSensorDIGPSTime(_port, _result) __ReadSensorDIGPSTime(_port, _result)

/**
 * ReadSensorDIGPSLatitude function.
 * Read the integer latitude reported by the GPS
 * (dddddddd; Positive = North; Negative = South).
 *
 * \param _port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The integer latitude
 */
#define ReadSensorDIGPSLatitude(_port, _result) __ReadSensorDIGPSLatitude(_port, _result)

/**
 * ReadSensorDIGPSLongitude function.
 * Read the integer longitude reported by the GPS
 * (ddddddddd; Positive = East; Negative = West).
 *
 * \param _port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The integer longitude
 */
#define ReadSensorDIGPSLongitude(_port, _result) __ReadSensorDIGPSLongitude(_port, _result)

/**
 * ReadSensorDIGPSVelocity function.
 * Read the current velocity in cm/s.
 *
 * \param _port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The current velocity in cm/s
 */
#define ReadSensorDIGPSVelocity(_port, _result) __ReadSensorDIGPSVelocity(_port, _result)

/**
 * ReadSensorDIGPSHeading function.
 * Read the current heading in degrees.
 *
 * \param _port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The current heading in degrees
 */
#define ReadSensorDIGPSHeading(_port, _result) __ReadSensorDIGPSHeading(_port, _result)

/**
 * ReadSensorDIGPSDistanceToWaypoint function.
 * Read the distance remaining to reach the current waypoint in meters.
 *
 * \param _port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The distance to the waypoint in meters
 */
#define ReadSensorDIGPSDistanceToWaypoint(_port, _result) __ReadSensorDIGPSDistanceToWaypoint(_port, _result)

/**
 * ReadSensorDIGPSHeadingToWaypoint function.
 * Read the heading required to reach the current waypoint.
 *
 * \param _port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The heading to the waypoint in degrees
 */
#define ReadSensorDIGPSHeadingToWaypoint(_port, _result) __ReadSensorDIGPSHeadingToWaypoint(_port, _result)

/**
 * ReadSensorDIGPSRelativeHeading function.
 * Read the angle travelled since last request. Resets the request coordinates
 * on the GPS sensor. Sends the angle of travel since the last call.
 *
 * \param _port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The relative heading in degrees
 */
#define ReadSensorDIGPSRelativeHeading(_port, _result) __ReadSensorDIGPSRelativeHeading(_port, _result)

/**
 * SetSensorDIGPSWaypoint function.
 * Set the coordinates of the waypoint destination. The GPS sensor uses
 * this to calculate the heading and distance required to reach
 * the waypoint.
 *
 * \param _port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _lat The latitude of the waypoint.
 * \param _long The longitude of the waypoint.
 * \param _result The boolean function call result.
 */
#define SetSensorDIGPSWaypoint(_port, _lat, _long, _result) __SetSensorDIGPSWaypoint(_port, _lat, _long, _result)

/**
 * SetSensorDIGyroEx function.
 * Configure DIGyro device on the specified port with the specified scale,
 * output data rate, and bandwidth.
 *
 * \param _port The port to which the Dexter Industries IMU Gyro sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _scale The full scale of the device (250dps, 500dps, or 2000dps).
 * See the \ref DIIMUGyroCtrl4Constants group. You may use a constant or a variable.
 * \param _odr The output data rate of the device (100hz, 200hz, 400hz, or 800hz).
 * See the \ref DIIMUGyroCtrl1Constants group. You may use a constant or a variable.
 * \param _bw The bandwidth of the device.
 * See the \ref DIIMUGyroCtrl1Constants group. You may use a constant or a variable.
 * \param _result The boolean function call result.
 */
#define SetSensorDIGyroEx(_port, _scale, _odr, _bw, _result) __SetSensorDIGyro(_port, _scale, _odr, _bw, _result)

/**
 * SetSensorDIGyro function.
 * Configure DIGyro device on the specified port with default scale of 500dps,
 * output data rate of 100hz, and bandwidth level 1.
 *
 * \param _port The port to which the Dexter Industries IMU Gyro sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The boolean function call result.
 */
#define SetSensorDIGyro(_port, _result) __SetSensorDIGyro(_port, DIGYRO_CTRL4_SCALE_500, DIGYRO_CTRL1_DATARATE_100, DIGYRO_CTRL1_BANDWIDTH_1, _result)

/**
 * ReadSensorDIGyroRaw function.
 * Read the raw Dexter Industries IMU Gyro X, Y, and Z axis values.
 *
 * \param _port The port to which the Dexter Industries IMU Gyro sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _vector A variable of type TVector which will contain the raw X, Y, anx Z values.
 * \param _result The boolean function call result.
 */
#define ReadSensorDIGyroRaw(_port, _vector, _result) __ReadSensorDIGyroRaw(_port, _vector, _result)

/**
 * ReadSensorDIGyro function.
 * Read the scaled Dexter Industries IMU Gyro X, Y, and Z axis values.
 *
 * \param _port The port to which the Dexter Industries IMU Gyro sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _vector A variable of type TVector which will contain the scaled X, Y, anx Z values.
 * \param _result The boolean function call result.
 */
#define ReadSensorDIGyro(_port, _vector, _result) __ReadSensorDIGyro(_port, _vector, _result)

/**
 * ReadSensorDIGyroTemperature function.
 * Read the Dexter Industries IMU Gyro temperature value.
 *
 * \param _port The port to which the Dexter Industries IMU Gyro sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _out The output temperature value.
 * \param _result The boolean function call result.
 */
#define ReadSensorDIGyroTemperature(_port, _out, _result) __ReadSensorDIGyroTemperature(_port, _out, _result)

/**
 * ReadSensorDIGyroStatus function.
 * Read the Dexter Industries IMU Gyro status value.
 *
 * \param _port The port to which the Dexter Industries IMU Gyro sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _out The output status value.
 * \param _result The boolean function call result.
 */
#define ReadSensorDIGyroStatus(_port, _out, _result) __ReadSensorDIGyroStatus(_port, _out, _result)


/**
 * SetSensorDIAcclEx function.
 * Configure DIAccl device on the specified port with the specified mode.
 *
 * \param _port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _mode The mode of the device (2G, 4G, or 8G).
 * See the \ref DIIMUAccelModeConstants group. You may use a constant or a variable.
 * \param _result The boolean function call result.
 */
#define SetSensorDIAcclEx(_port, _mode, _result) __SetSensorDIAccl(_port, _mode, _result)

/**
 * SetSensorDIAccl function.
 * Configure DIAccl device on the specified port with default mode of 2G.
 *
 * \param _port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The boolean function call result.
 */
#define SetSensorDIAccl(_port, _result) __SetSensorDIAccl(_port, DIACCL_MODE_GLVL2, _result)

/**
 * ReadSensorDIAcclRaw function.
 * Read the raw Dexter Industries IMU Accl X, Y, and Z axis 10-bit values.
 *
 * \param _port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _vector A variable of type TVector which will contain the raw X, Y, anx Z values.
 * \param _result The boolean function call result.
 */
#define ReadSensorDIAcclRaw(_port, _vector, _result) __ReadSensorDIAcclRaw(_port, DIACCL_REG_XLOW, _vector, _result)

/**
 * ReadSensorDIAccl function.
 * Read the scaled Dexter Industries IMU Accl X, Y, and Z axis 10-bit values.
 *
 * \param _port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _vector A variable of type TVector which will contain the scaled X, Y, anx Z values.
 * \param _result The boolean function call result.
 */
#define ReadSensorDIAccl(_port, _vector, _result) __ReadSensorDIAccl(_port, _vector, _result)

/**
 * ReadSensorDIAccl8Raw function.
 * Read the raw Dexter Industries IMU Accl X, Y, and Z axis 8-bit values.
 *
 * \param _port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _vector A variable of type TVector which will contain the raw X, Y, anx Z values.
 * \param _result The boolean function call result.
 */
#define ReadSensorDIAccl8Raw(_port, _vector, _result) __ReadSensorDIAccl8Raw(_port, _vector, _result)

/**
 * ReadSensorDIAccl8 function.
 * Read the scaled Dexter Industries IMU Accl X, Y, and Z axis 8-bit values.
 *
 * \param _port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _vector A variable of type TVector which will contain the scaled X, Y, anx Z values.
 * \param _result The boolean function call result.
 */
#define ReadSensorDIAccl8(_port, _vector, _result) __ReadSensorDIAccl8(_port, _vector, _result)

/**
 * ReadSensorDIAcclStatus function.
 * Read the Dexter Industries IMU Accl status value.
 *
 * \param _port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _out The output status value.
 * \param _result The boolean function call result.
 */
#define ReadSensorDIAcclStatus(_port, _out, _result) __ReadSensorDIAcclStatus(_port, _out, _result)

/**
 * ReadSensorDIAcclDrift function.
 * Read the Dexter Industries IMU Accl X, Y, and Z axis 10-bit drift values.
 *
 * \param _port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _x The X axis 10-bit drift value.
 * \param _y The Y axis 10-bit drift value.
 * \param _z The Z axis 10-bit drift value.
 * \param _result The boolean function call result.
 */
#define ReadSensorDIAcclDrift(_port, _x, _y, _z, _result) __ReadSensorDIAcclDrift(_port, _x, _y, _z, _result)

/**
 * SetSensorDIAcclDrift function.
 * Set the Dexter Industries IMU Accl X, Y, and Z axis 10-bit drift values.
 *
 * \param _port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _x The X axis 10-bit drift value.
 * \param _y The Y axis 10-bit drift value.
 * \param _z The Z axis 10-bit drift value.
 * \param _result The boolean function call result.
 */
#define SetSensorDIAcclDrift(_port, _x, _y, _z, _result) __SetSensorDIAcclDrift(_port, _x, _y, _z, _result)


/** @} */  // end of DexterIndustriesAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // NBC_DEXTERINDUSTRIES_H
