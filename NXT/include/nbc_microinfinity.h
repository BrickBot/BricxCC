/** \file nbc_microinfinity.h
 * \brief The NBC microinfinity API
 *
 * nbc_microinfinity.h contains the NBC microinfinity API
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
 * \date 2013-03-04
 * \version 3
 */

#ifndef NBC_MICROINFINITY_H
#define NBC_MICROINFINITY_H

#include "microinfinity_constants.h"
#include "nbc_lowspeed.h"

///////////////////////////////////////////////////////////////////////////////
/////////////////////////// MicroInfinity API /////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @addtogroup MicroinfinityAPI
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

dseg segment
  __XGAccRangeVar byte 2
  __XGAccRange0 byte 2
  __XGAccRange1 byte 2
  __XGAccRange2 byte 2
  __XGAccRange3 byte 2
  __XGTmpBufVar byte[]
  __XGTmpBuf0 byte[]
  __XGTmpBuf1 byte[]
  __XGTmpBuf2 byte[]
  __XGTmpBuf3 byte[]
  __XGErrVar byte
  __XGErr0 byte
  __XGErr1 byte
  __XGErr2 byte
  __XGErr3 byte

TXGPacket struct
  AccAngle sword
  TurnRate sword
  XAxis sword
  YAxis sword
  ZAxis sword
TXGPacket ends

dseg ends

#define __ResetMIXG1300L(_port, _result) \
  __I2CWriteToRegister(_port, MI_ADDR_XG1300L, XG1300L_REG_RESET, NA, _result) \
  compif EQ, isconst(_port), FALSE \
  set __XGAccRangeVar, 1 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  set __XGAccRange##_port, 1 \
  compend

#define __ReadSensorMIXG1300LScale(_port, _result) \
  compif EQ, isconst(_port), FALSE \
  mul _result, __XGAccRangeVar, 2 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  mul _result, __XGAccRange##_port, 2 \
  compend

#define __SetSensorMIXG1300LScale(_port, _scale, _result) \
  compchk EQ, (_scale==1)||(_scale==2)||(_scale==4), TRUE \
  compif EQ, isconst(_port), FALSE \
  set __XGAccRangeVar, _scale \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  set __XGAccRange##_port, _scale \
  compend \
  compif EQ, _scale, 1 \
  __I2CWriteToRegister(_port, MI_ADDR_XG1300L, XG1300L_REG_2G, NA, _result) \
  compelse \
  compif EQ, _scale, 2 \
  __I2CWriteToRegister(_port, MI_ADDR_XG1300L, XG1300L_REG_4G, NA, _result) \
  compelse \
  __I2CWriteToRegister(_port, MI_ADDR_XG1300L, XG1300L_REG_8G, NA, _result) \
  compend \
  compend

#define __ReadSensorMIXG1300L(_port, _packet, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 10 \
  set __RLSPadVar, 10 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  arrtostr __XGTmpBufVar, __RLSReadBufVar \
  unflatten _packet, __XGErrVar, __XGTmpBufVar, _packet \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  mul _packet.XAxis, _packet.XAxis, __XGAccRangeVar \
  mul _packet.YAxis, _packet.YAxis, __XGAccRangeVar \
  mul _packet.ZAxis, _packet.ZAxis, __XGAccRangeVar \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 10 \
  set __RLSPad##_port, 10 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  arrtostr __XGTmpBuf##_port, __RLSReadBuf##_port \
  unflatten _packet, __XGErr##_port, __XGTmpBuf##_port, _packet \
  release __RLSBmutex##_port \
  mul _packet.XAxis, _packet.XAxis, __XGAccRange##_port \
  mul _packet.YAxis, _packet.YAxis, __XGAccRange##_port \
  mul _packet.ZAxis, _packet.ZAxis, __XGAccRange##_port \
  compend

#endif

// Microinfinity functions

/**
 * ResetMIXG1300L function.
 * Reset the Microinfinity CruizCore XG1300L device.
 *
 * During reset, the XG1300L will recomputed the bias drift value, therefore
 * it must remain stationary. The bias drift value will change randomly over
 * time due to temperature variations, however the internal algorithm in
 * the XG1300L will compensate for these changes. We strongly recommend
 * issuing a reset command to the XG1300L at the beginning of the program.
 *
 * The reset function also resets the accumulate angle value to a zero. Since
 * the accelerometers measurements are taken with respect to the sensor
 * reference frame the reset function will have no effect in the accelerometer
 * measurements.
 *
 * Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _result The function call result.
 */
#define ResetMIXG1300L(_port, _result) __ResetMIXG1300L(_port, _result)

/**
 * ReadSensorMIXG1300LScale function.
 * Read the Microinfinity CruizCore XG1300L accelerometer scale.
 * The accelerometer in the CruizCore XG1300L can be set to operate with a
 * scale ranging from +/-2G, +/-4G, or +/-8G.
 * Returns the scale value that the device is currently configured to use.
 * The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _result The current scale value.
 */
#define ReadSensorMIXG1300LScale(_port, _result) __ReadSensorMIXG1300LScale(_port, _result)

/**
 * SetSensorMIXG1300LScale function.
 * Set the Microinfinity CruizCore XG1300L accelerometer scale factor.
 * Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _scale This value must be a constant.  See \ref XG1300LScaleConstants.
 * \param _result The function call result.
 */
#define SetSensorMIXG1300LScale(_port, _scale, _result) __SetSensorMIXG1300LScale(_port, _scale, _result)

/**
 * ReadSensorMIXG1300L function.
 * Read Microinfinity CruizCore XG1300L values.
 * Read accumulated angle, turn rate, and X, Y, and Z axis acceleration values
 * from the Microinfinity CruizCore XG1300L sensor.
 * Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _packet The output XK1300L data structure.  See \ref TXGPacket.
 * \param _result The function call result.
 */
#define ReadSensorMIXG1300L(_port, _packet, _result) \
  compchktype _packet, TXGPacket \
  __ReadSensorMIXG1300L(_port, _packet, _result)

/** @} */  // end of MicroinfinityAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // NBC_MICROINFINITY_H
