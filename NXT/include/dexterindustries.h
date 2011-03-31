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
 * Portions created by John Hansen are Copyright (C) 2009-2010 John Hansen.
 * All Rights Reserved.
 *
 * ----------------------------------------------------------------------------
 *
 * \author John Hansen (bricxcc_at_comcast.net)
 * \date 2011-03-17
 * \version 1
 */

#ifndef DEXTERINDUSTRIES_H
#define DEXTERINDUSTRIES_H

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// Dexter Industries API /////////////////////////
///////////////////////////////////////////////////////////////////////////////


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

#endif

/** @} */  // end of DexterIndustriesAPI group

#endif // DEXTERINDUSTRIES_H
