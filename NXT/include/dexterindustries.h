/** \file dexterindustries.h
 * \brief The NXC Dexter Industries API
 *
 * dexterindustries.h contains the NXC Dexter Industries API
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

#ifndef DEXTERINDUSTRIES_H
#define DEXTERINDUSTRIES_H

#include "dexterindustries_constants.h"

#ifndef __DOXYGEN_DOCS
asm { asminclude "nbc_dexterindustries.h" }
#endif

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// Dexter Industries API /////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @addtogroup DexterIndustriesAPI
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * SensorDIGPSStatus function.
 * Read the status of the GPS satellite link.
 * \param port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \return The boolean GPS status
 */
inline bool SensorDIGPSStatus(byte port);

/**
 * SensorDIGPSTime function.
 * Read the current time reported by the GPS in UTC.
 * \param port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \return The current time in UTC
 */
inline long SensorDIGPSTime(byte port);

/**
 * SensorDIGPSLatitude function.
 * Read the integer latitude reported by the GPS
 * (dddddddd; Positive = North; Negative = South).
 * \param port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \return The integer latitude
 */
inline long SensorDIGPSLatitude(byte port);

/**
 * SensorDIGPSLongitude function.
 * Read the integer longitude reported by the GPS
 * (ddddddddd; Positive = East; Negative = West).
 * \param port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \return The integer longitude
 */
inline long SensorDIGPSLongitude(byte port);

/**
 * SensorDIGPSVelocity function.
 * Read the current velocity in cm/s.
 * \param port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \return The current velocity in cm/s
 */
inline long SensorDIGPSVelocity(byte port);

/**
 * SensorDIGPSHeading function.
 * Read the current heading in degrees.
 * \param port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \return The current heading in degrees
 */
inline int SensorDIGPSHeading(byte port);

/**
 * SensorDIGPSDistanceToWaypoint function.
 * Read the distance remaining to reach the current waypoint in meters.
 * \param port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \return The distance to the waypoint in meters
 */
inline long SensorDIGPSDistanceToWaypoint(byte port);

/**
 * SensorDIGPSHeadingToWaypoint function.
 * Read the heading required to reach the current waypoint.
 * \param port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \return The heading to the waypoint in degrees
 */
inline int SensorDIGPSHeadingToWaypoint(byte port);

/**
 * SensorDIGPSRelativeHeading function.
 * Read the angle travelled since last request. Resets the request coordinates
 * on the GPS sensor. Sends the angle of travel since the last call.
 * \param port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \return The relative heading in degrees
 */
inline int SensorDIGPSRelativeHeading(byte port);

/**
 * SetSensorDIGPSWaypoint function.
 * Set the coordinates of the waypoint destination. The GPS sensor uses
 * this to calculate the heading and distance required to reach
 * the waypoint.
 *
 * \param port The port to which the Dexter Industries GPS sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \param latitude The latitude of the waypoint.
 * \param longitude The longitude of the waypoint.
 * \return The boolean function call result.
 */
inline bool SetSensorDIGPSWaypoint(byte port, long latitude, long longitude);

/**
 * SetSensorDIGyroEx function.
 * Configure DIGyro device on the specified port with the specified scale,
 * output data rate, and bandwidth.
 *
 * \param port The port to which the Dexter Industries IMU Gyro sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \param scale The full scale of the device (250dps, 500dps, or 2000dps).
 * See the \ref DIIMUGyroCtrl4Constants group. You may use a constant or a variable.
 * \param odr The output data rate of the device (100hz, 200hz, 400hz, or 800hz).
 * See the \ref DIIMUGyroCtrl1Constants group. You may use a constant or a variable.
 * \param bw The bandwidth of the device.
 * See the \ref DIIMUGyroCtrl1Constants group. You may use a constant or a variable.
 * \return The boolean function call result.
 */
inline bool SetSensorDIGyroEx(const byte port, byte scale, byte odr, byte bw);

/**
 * SetSensorDIGyro function.
 * Configure DIGyro device on the specified port with default scale of 500dps,
 * output data rate of 100hz, and bandwidth level 1.
 *
 * \param port The port to which the Dexter Industries IMU Gyro sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \return The boolean function call result.
 */
inline bool SetSensorDIGyro(const byte port);

/**
 * ReadSensorDIGyroRaw function.
 * Read the raw Dexter Industries IMU Gyro X, Y, and Z axis values.
 *
 * \param port The port to which the Dexter Industries IMU Gyro sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \param vector A variable of type VectorType which will contain the raw X, Y, anx Z values.
 * \return The boolean function call result.
 */
inline bool ReadSensorDIGyroRaw(const byte port, VectorType & vector);

/**
 * ReadSensorDIGyro function.
 * Read the scaled Dexter Industries IMU Gyro X, Y, and Z axis values.
 *
 * \param port The port to which the Dexter Industries IMU Gyro sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \param vector A variable of type VectorType which will contain the scaled X, Y, anx Z values.
 * \return The boolean function call result.
 */
inline bool ReadSensorDIGyro(const byte port, VectorType & vector);

/**
 * SensorDIGyroTemperature function.
 * Read the Dexter Industries IMU Gyro temperature value.
 *
 * \param port The port to which the Dexter Industries IMU Gyro sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \return The temperature value.
 */
inline int SensorDIGyroTemperature(const byte port);

/**
 * SensorDIGyroStatus function.
 * Read the Dexter Industries IMU Gyro status value.
 *
 * \param port The port to which the Dexter Industries IMU Gyro sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \return The status value.
 */
inline byte SensorDIGyroStatus(const byte port);



/**
 * SetSensorDIAcclEx function.
 * Configure DIAccl device on the specified port with the specified mode.
 *
 * \param port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \param mode The mode of the device (2G, 4G, or 8G).
 * See the \ref DIIMUAccelModeConstants group. You may use a constant or a variable.
 * \return The boolean function call result.
 */
inline bool SetSensorDIAcclEx(const byte port, byte mode);

/**
 * SetSensorDIAccl function.
 * Configure DIAccl device on the specified port with default mode of 2G.
 *
 * \param port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \return The boolean function call result.
 */
inline bool SetSensorDIAccl(const byte port);

/**
 * ReadSensorDIAcclRaw function.
 * Read the raw Dexter Industries IMU Accl X, Y, and Z axis 10-bit values.
 *
 * \param port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \param vector A variable of type VectorType which will contain the raw X, Y, anx Z 10-bit values.
 * \return The boolean function call result.
 */
inline bool ReadSensorDIAcclRaw(const byte port, VectorType & vector);

/**
 * ReadSensorDIAccl function.
 * Read the scaled Dexter Industries IMU Accl X, Y, and Z axis 10-bit values.
 *
 * \param port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \param vector A variable of type VectorType which will contain the scaled X, Y, anx Z 10-bit values.
 * \return The boolean function call result.
 */
inline bool ReadSensorDIAccl(const byte port, VectorType & vector);

/**
 * ReadSensorDIAccl8Raw function.
 * Read the raw Dexter Industries IMU Accl X, Y, and Z axis 8-bit values.
 *
 * \param port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \param vector A variable of type VectorType which will contain the raw X, Y, anx Z 8-bit values.
 * \return The boolean function call result.
 */
inline bool ReadSensorDIAccl8Raw(const byte port, VectorType & vector);

/**
 * ReadSensorDIAccl8 function.
 * Read the scaled Dexter Industries IMU Accl X, Y, and Z axis 8-bit values.
 *
 * \param port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \param vector A variable of type VectorType which will contain the scaled X, Y, anx Z 8-bit values.
 * \return The boolean function call result.
 */
inline bool ReadSensorDIAccl8(const byte port, VectorType & vector);

/**
 * SensorDIAcclStatus function.
 * Read the Dexter Industries IMU Accl status value.
 *
 * \param port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \return The status value.
 */
inline byte SensorDIAcclStatus(const byte port);

/**
 * ReadSensorDIAcclDrift function.
 * Read the Dexter Industries IMU Accl X, Y, and Z axis 10-bit drift values.
 *
 * \param port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \param x The X axis 10-bit drift value.
 * \param y The Y axis 10-bit drift value.
 * \param z The Z axis 10-bit drift value.
 * \return The boolean function call result.
 */
inline bool ReadSensorDIAcclDrift(const byte port, int & x, int & y, int & z);

/**
 * SetSensorDIAcclDrift function.
 * Set the Dexter Industries IMU Accl X, Y, and Z axis 10-bit drift values.
 *
 * \param port The port to which the Dexter Industries IMU Accl sensor is attached.
 * See the \ref InPorts group. You may use a constant or a variable.
 * \param x The X axis 10-bit drift value.
 * \param y The Y axis 10-bit drift value.
 * \param z The Z axis 10-bit drift value.
 * \return The boolean function call result.
 */
inline bool SetSensorDIAcclDrift(const byte port, int x, int y, int z);


#else

#define SensorDIGPSStatus(_port) asm { __ReadSensorDIGPSStatus(_port, __RETVAL__) }
#define SensorDIGPSTime(_port) asm { __ReadSensorDIGPSTime(_port, __RETVAL__) }
#define SensorDIGPSLatitude(_port) asm { __ReadSensorDIGPSLatitude(_port, __RETVAL__) }
#define SensorDIGPSLongitude(_port) asm { __ReadSensorDIGPSLongitude(_port, __RETVAL__) }
#define SensorDIGPSVelocity(_port) asm { __ReadSensorDIGPSVelocity(_port, __RETVAL__) }
#define SensorDIGPSHeading(_port) asm { __ReadSensorDIGPSHeading(_port, __RETVAL__) }
#define SensorDIGPSDistanceToWaypoint(_port) asm { __ReadSensorDIGPSDistanceToWaypoint(_port, __RETVAL__) }
#define SensorDIGPSHeadingToWaypoint(_port) asm { __ReadSensorDIGPSHeadingToWaypoint(_port, __RETVAL__) }
#define SensorDIGPSRelativeHeading(_port) asm { __ReadSensorDIGPSRelativeHeading(_port, __RETVAL__) }
#define SetSensorDIGPSWaypoint(_port, _lat, _long) asm { __SetSensorDIGPSWaypoint(_port, _lat, _long, __RETVAL__) }

#define SetSensorDIGyroEx(_port, _scale, _odr, _bw) asm { __SetSensorDIGyro(_port, _scale, _odr, _bw, __RETVAL__) }
#define SetSensorDIGyro(_port) asm { __SetSensorDIGyro(_port, DIGYRO_CTRL4_SCALE_500, DIGYRO_CTRL1_DATARATE_100, DIGYRO_CTRL1_BANDWIDTH_1, __RETVAL__) }
#define ReadSensorDIGyroRaw(_port, _vector) asm { __ReadSensorDIGyroRaw(_port, _vector, __RETVAL__) }
#define ReadSensorDIGyro(_port, _vector) asm { __ReadSensorDIGyro(_port, _vector, __RETVAL__) }
#define SensorDIGyroStatus(_port) asm { __ReadSensorDIGyroStatus(_port, __RETVAL__, __TMPBYTE__) }
#define SensorDIGyroTemperature(_port) asm { __ReadSensorDIGyroTemperature(_port, __RETVAL__, __TMPBYTE__) }


#define SetSensorDIAcclEx(_port, _mode) asm { __SetSensorDIAccl(_port, _mode, __RETVAL__) }
#define SetSensorDIAccl(_port) asm { __SetSensorDIAccl(_port, DIACCL_MODE_GLVL2, __RETVAL__) }
#define ReadSensorDIAcclRaw(_port, _vector) asm { __ReadSensorDIAcclRaw(_port, DIACCL_REG_XLOW, _vector, __RETVAL__) }
#define ReadSensorDIAccl(_port, _vector) asm { __ReadSensorDIAccl(_port, _vector, __RETVAL__) }
#define ReadSensorDIAccl8Raw(_port, _vector) asm { __ReadSensorDIAccl8Raw(_port, _vector, __RETVAL__) }
#define ReadSensorDIAccl8(_port, _vector) asm { __ReadSensorDIAccl8(_port, _vector, __RETVAL__) }
#define SensorDIAcclStatus(_port) asm { __ReadSensorDIAcclStatus(_port, __RETVAL__, __TMPBYTE__) }
#define ReadSensorDIAcclDrift(_port, _x, _y, _z) asm { __ReadSensorDIAcclDrift(_port, _x, _y, _z, __RETVAL__) }
#define SetSensorDIAcclDrift(_port, _x, _y, _z) asm { __SetSensorDIAcclDrift(_port, _x, _y, _z, __RETVAL__) }


#endif

/** @} */  // end of DexterIndustriesAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // DEXTERINDUSTRIES_H
