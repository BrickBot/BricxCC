/** \file microinfinity.h
 * \brief The NXC microinfinity API
 *
 * microinfinity.h contains the NXC microinfinity API
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

#ifndef MICROINFINITY_H
#define MICROINFINITY_H

#include "microinfinity_constants.h"

#ifndef __DOXYGEN_DOCS
asm { asminclude "nbc_microinfinity.h" }
#endif

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// Microinfinity API /////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @addtogroup MicroinfinityAPI
 * @{
 */

/** @defgroup MicroinfinityTypes Microinfinity types
 * Types used by various Microinfinity device functions.
 * @{
 */

/**
 * Parameters for the \ref ReadSensorMIXG1300L function.
 * This structure is used when calling the \ref ReadSensorMIXG1300L function.
 * After calling the function read the sensor values from the various
 * structure fields.  The values are all scaled by 100.
 */
struct XGPacketType {
  int AccAngle; /*!< The accumulated angle. */
  int TurnRate; /*!< The turn rate. */
  int XAxis;    /*!< The X axis acceleration. */
  int YAxis;    /*!< The Y axis acceleration. */
  int ZAxis;    /*!< The Z axis acceleration. */
};

/** @} */ // end of MicroinfinityTypes group

/** @defgroup MicroinfinityFunctions Microinfinity functions
 * Functions for interfacing with Microinfinity devices.
 * @{
 */
#ifdef __DOXYGEN_DOCS

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
 * \param port The sensor port. See the \ref InPorts group.
 * \return The boolean function call result.
 */
inline bool ResetMIXG1300L(byte port);

/**
 * SensorMIXG1300LScale function.
 * Read the Microinfinity CruizCore XG1300L accelerometer scale.
 * The accelerometer in the CruizCore XG1300L can be set to operate with a
 * scale ranging from +/-2G, +/-4G, or +/-8G.
 * Returns the scale value that the device is currently configured to use.
 * The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See the \ref InPorts group.
 * \return The current scale value.
 */
inline int SensorMIXG1300LScale(byte port);

/**
 * SetSensorMIXG1300LScale function.
 * Set the Microinfinity CruizCore XG1300L accelerometer scale.
 * The accelerometer in the CruizCore XG1300L can be set to operate with a
 * scale ranging from +/-2G, +/-4G, or +/-8G.
 * Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See the \ref InPorts group.
 * \param scale This value must be a constant.  See \ref XG1300LScaleConstants.
 * \return The boolean function call result.
 */
inline bool SetSensorMIXG1300LScale(byte port, const byte scale);

/**
 * ReadSensorMIXG1300L function.
 * Read Microinfinity CruizCore XG1300L values.
 * Read accumulated angle, turn rate, and X, Y, and Z axis acceleration values
 * from the Microinfinity CruizCore XG1300L sensor.
 * Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See the \ref InPorts group.
 * \param packet The output XK1300L data structure.  See \ref XGPacketType.
 * \return The boolean function call result.
 */
inline bool ReadSensorMIXG1300L(byte port, XGPacketType & packet);

#else

#define ResetMIXG1300L(_port) asm { __ResetMIXG1300L(_port, __RETVAL__) }
#define SensorMIXG1300LScale(_port) asm { __ReadSensorMIXG1300LScale(_port, __RETVAL__) }
#define SetSensorMIXG1300LScale(_port, _scale) asm { __SetSensorMIXG1300LScale(_port, _scale, __RETVAL__) }
#define ReadSensorMIXG1300L(_port, _packet) asm { \
  compchktype _packet, XGPacketType \
  __ReadSensorMIXG1300L(_port, _packet, __RETVAL__) \
}

#endif

/** @} */ // end of MicroinfinityFunctions group
/** @} */  // end of MicroinfinityAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // MICROINFINITY_H
