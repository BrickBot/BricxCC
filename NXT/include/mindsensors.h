/** \file mindsensors.h
 * \brief The NXC mindsensors.com API
 *
 * mindsensors.h contains the NXC mindsensors.com API
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

#ifndef MINDSENSORS_H
#define MINDSENSORS_H

#include "mindsensors_constants.h"
#include "input.h"
#include "command.h"

#ifndef __DOXYGEN_DOCS
asm { asminclude "nbc_mindsensors.h" }
#endif

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// MindSensors API ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @addtogroup MindSensorsAPI
 * @{
 */

/**
 * Configure a mindsensors pressure sensor.
 * Configure the specified port for a mindsensors pressure sensor.
 *
 * \param port The port to configure. See \ref InPorts.
 */
inline void SetSensorMSPressure(const byte & port ) {
  SetSensorType(port, SENSOR_TYPE_LIGHT);
  SetSensorMode(port, SENSOR_MODE_RAW);
  ResetSensor(port);
}

/**
 * Configure a mindsensors DROD sensor.
 * Configure the specified port for a mindsensors DROD sensor.
 *
 * \param port The port to configure. See \ref InPorts.
 * \param bActive A flag indicating whether to configure the sensor in active
 * or inactive mode.
 */
inline void SetSensorMSDROD(const byte & port, bool bActive) {
  if (bActive)
    SetSensorType(port, SENSOR_TYPE_LIGHT_ACTIVE);
  else
    SetSensorType(port, SENSOR_TYPE_LIGHT_INACTIVE);
  SetSensorMode(port, SENSOR_MODE_PERCENT);
  ResetSensor(port);
}


/**
 * Configure a mindsensors SumoEyes sensor.
 * Configure the specified port for a mindsensors SumoEyes sensor.
 *
 * \param port The port to configure. See \ref InPorts.
 * \param bLong A flag indicating whether to configure the sensor in long range
 * or short range mode.
 */
inline void SetSensorNXTSumoEyes(const byte & port, bool bLong) {
  if (bLong)
    SetSensorType(port, SENSOR_TYPE_LIGHT_INACTIVE);
  else
    SetSensorType(port, SENSOR_TYPE_LIGHT_ACTIVE);
  SetSensorMode(port, SENSOR_MODE_PERCENT);
  ResetSensor(port);
  Wait(275);
}

/**
 * Read mindsensors pressure sensor.
 * Read the pressure sensor value of the mindsensors pressure sensor on the
 * specified port.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The pressure reading.
 */
inline int SensorMSPressure(const byte & port) {
  asm {
    getin __RETVAL__, port, RawValueField
    sub __RETVAL__, 1024, __RETVAL__
    div __RETVAL__, __RETVAL__, 25
  }
}

/**
 * Read mindsensors NXTSumoEyes obstacle zone.
 * Return the Mindsensors NXTSumoEyes sensor obstacle zone value.  The port
 * should be configured for the NXTSumoEyes device using \ref SetSensorNXTSumoEyes
 * before calling this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The mindsensors NXTSumoEyes obstacle zone value.  See \ref NXTSumoEyesConstants.
 */
char SensorNXTSumoEyes(const byte & port) {
  int value;
  asm {
    getin value, port, NormalizedValueField
    mul value, value, 100
    div value, value, 1023
  }
  if (value > 30 && value < 36)
    return NXTSE_ZONE_LEFT;
  if (value > 63 && value < 69)
    return NXTSE_ZONE_RIGHT;
  if (value > 74 && value <= 80)
    return NXTSE_ZONE_FRONT;
  return NXTSE_ZONE_NONE;
}

#ifdef __DOXYGEN_DOCS

/**
 * Read mindsensors compass value.
 * Return the Mindsensors Compass sensor value.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The mindsensors compass value
 */
inline int SensorMSCompass(const byte & port, const byte i2caddr);

/**
 * Read mindsensors DROD value.
 * Return the Mindsensors DROD sensor value.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The mindsensors DROD value
 */
inline int SensorMSDROD(const byte & port);

/**
 * Read mindsensors NXTSumoEyes raw value.
 * Return the Mindsensors NXTSumoEyes raw sensor value. The port
 * should be configured for the NXTSumoEyes device using \ref SetSensorNXTSumoEyes
 * before calling this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The mindsensors NXTSumoEyes raw value
 */
inline int SensorNXTSumoEyesRaw(const byte & port);

/**
 * Read mindsensors raw pressure value.
 * Return the Mindsensors pressure sensor raw value.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The mindsensors raw pressure value
 */
inline int SensorMSPressureRaw(const byte & port);

/**
 * Read mindsensors acceleration values.
 * Read X, Y, and Z axis acceleration values from the mindsensors Accelerometer
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param x The output x-axis acceleration.
 * \param y The output y-axis acceleration.
 * \param z The output z-axis acceleration.
 * \return The function call result.
 */
inline bool ReadSensorMSAccel(const byte port, const byte i2caddr, int & x, int & y, int & z);

/**
 * Read mindsensors playstation controller values.
 * Read playstation controller values from the mindsensors playstation
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param btnset1 The button set 1 values. See \ref MSPSPNXBtnSet1.
 * \param btnset2 The button set 2 values. See \ref MSPSPNXBtnSet2.
 * \param xleft The left joystick x value.
 * \param yleft The left joystick y value.
 * \param xright The right joystick x value.
 * \param yright The right joystick y value.
 * \return The function call result.
 */
inline bool ReadSensorMSPlayStation(const byte port, const byte i2caddr, byte & btnset1, byte & btnset2, byte & xleft, byte & yleft, byte & xright, byte & yright);

/**
 * Read mindsensors RTClock values.
 * Read real-time clock values from the Mindsensors RTClock sensor. Returns
 * a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param sec The seconds.
 * \param min The minutes.
 * \param hrs The hours.
 * \param dow The day of week number.
 * \param date The day.
 * \param month The month.
 * \param year The year.
 * \return The function call result.
 */
inline bool ReadSensorMSRTClock(const byte port, byte & sec, byte & min, byte & hrs, byte & dow, byte & date, byte & month, byte & year);

/**
 * Read mindsensors tilt values.
 * Read X, Y, and Z axis tilt values from the mindsensors tilt
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param x The output x-axis tilt.
 * \param y The output y-axis tilt.
 * \param z The output z-axis tilt.
 * \return The function call result.
 */
inline bool ReadSensorMSTilt(const byte & port, const byte & i2caddr, byte & x, byte & y, byte & z);

/**
 * Send PFMate command.
 * Send a PFMate command to the power function IR receiver.
 * Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The power function IR receiver channel. See the \ref PFMateChannelConstants group.
 * \param motors The motor(s) to control. See the \ref PFMateMotorConstants group.
 * \param cmdA The power function command for motor A.
 * \param spdA The power function speed for motor A.
 * \param cmdB The power function command for motor B.
 * \param spdB The power function speed for motor B.
 * \return The function call result.
 */
inline bool PFMateSend(const byte & port, const byte & i2caddr, const byte & channel, const byte & motors, const byte & cmdA, const byte & spdA, const byte & cmdB, const byte & spdB);

/**
 * Send raw PFMate command.
 * Send a raw PFMate command to the power function IR receiver.
 * Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The power function IR receiver channel. See the \ref PFMateChannelConstants group.
 * \param b1 Raw byte 1.
 * \param b2 Raw byte 2.
 * \return The function call result.
 */
inline bool PFMateSendRaw(const byte & port, const byte & i2caddr, const byte & channel, const byte & b1, const byte & b2);

/**
 * Read a mindsensors device value.
 * Read a one, two, or four byte value from a mindsensors sensor. The value must be
 * stored with the least signficant byte (LSB) first (i.e., little endian). Returns a boolean value
 * indicating whether or not the operation completed successfully. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param reg The device register to read.
 * \param numbytes The number of bytes to read. Only 1, 2 or 4 byte values are supported.
 * \return The function call result.
 */
inline int MSReadValue(const byte port, const byte i2caddr, const byte reg, const byte numbytes);

/**
 * Turn on power to device.
 * Turn the power on for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char MSEnergize(const byte port, const byte i2caddr);

/**
 * Turn off power to device.
 * Turn power off for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char MSDeenergize(const byte port, const byte i2caddr);

/**
 * Turn on mindsensors ADPA mode.
 * Turn ADPA mode on for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char MSADPAOn(const byte port, const byte i2caddr);

/**
 * Turn off mindsensors ADPA mode.
 * Turn ADPA mode off for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char MSADPAOff(const byte port, const byte i2caddr);

/**
 * Configure DISTNx as GP2D12.
 * Configure the mindsensors DISTNx sensor as GP2D12. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char DISTNxGP2D12(const byte port, const byte i2caddr);

/**
 * Configure DISTNx as GP2D120.
 * Configure the mindsensors DISTNx sensor as GP2D120. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char DISTNxGP2D120(const byte port, const byte i2caddr);

/**
 * Configure DISTNx as GP2YA02.
 * Configure the mindsensors DISTNx sensor as GP2YA02. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char DISTNxGP2YA02(const byte port, const byte i2caddr);

/**
 * Configure DISTNx as GP2YA21.
 * Configure the mindsensors DISTNx sensor as GP2YA21. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char DISTNxGP2YA21(const byte port, const byte i2caddr);

/**
 * Read DISTNx distance value.
 * Read the mindsensors DISTNx sensor's distance value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The distance value.
 */
inline int DISTNxDistance(const byte port, const byte i2caddr);

/**
 * Read DISTNx maximum distance value.
 * Read the mindsensors DISTNx sensor's maximum distance value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The maximum distance value.
 */
inline int DISTNxMaxDistance(const byte port, const byte i2caddr);

/**
 * Read DISTNx minimum distance value.
 * Read the mindsensors DISTNx sensor's minimum distance value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The distance value.
 */
inline int DISTNxMinDistance(const byte port, const byte i2caddr);

/**
 * Read DISTNx module type value.
 * Read the mindsensors DISTNx sensor's module type value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The module type value.
 */
inline byte DISTNxModuleType(const byte port, const byte i2caddr);

/**
 * Read DISTNx num points value.
 * Read the mindsensors DISTNx sensor's num points value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The num points value.
 */
inline byte DISTNxNumPoints(const byte port, const byte i2caddr);

/**
 * Read DISTNx voltage value.
 * Read the mindsensors DISTNx sensor's voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The voltage value.
 */
inline int DISTNxVoltage(const byte port, const byte i2caddr);

/**
 * Calibrate ACCL-Nx X-axis.
 * Calibrate the mindsensors ACCL-Nx sensor X-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char ACCLNxCalibrateX(const byte port, const byte i2caddr);

/**
 * Stop calibrating ACCL-Nx X-axis.
 * Stop calibrating the mindsensors ACCL-Nx sensor X-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char ACCLNxCalibrateXEnd(const byte port, const byte i2caddr);

/**
 * Calibrate ACCL-Nx Y-axis.
 * Calibrate the mindsensors ACCL-Nx sensor Y-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char ACCLNxCalibrateY(const byte port, const byte i2caddr);

/**
 * Stop calibrating ACCL-Nx Y-axis.
 * Stop calibrating the mindsensors ACCL-Nx sensor Y-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char ACCLNxCalibrateYEnd(const byte port, const byte i2caddr);

/**
 * Calibrate ACCL-Nx Z-axis.
 * Calibrate the mindsensors ACCL-Nx sensor Z-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char ACCLNxCalibrateZ(const byte port, const byte i2caddr);

/**
 * Stop calibrating ACCL-Nx Z-axis.
 * Stop calibrating the mindsensors ACCL-Nx sensor Z-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char ACCLNxCalibrateZEnd(const byte port, const byte i2caddr);

/**
 * Reset ACCL-Nx calibration.
 * Reset the mindsensors ACCL-Nx sensor calibration to factory settings. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char ACCLNxResetCalibration(const byte port, const byte i2caddr);

/**
 * Set ACCL-Nx sensitivity.
 * Reset the mindsensors ACCL-Nx sensor calibration to factory settings. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param slevel The sensitivity level. See \ref MSACCLNxSLevel.
 * \return The function call result.
 */
inline char SetACCLNxSensitivity(const byte port, const byte i2caddr, byte slevel);

/**
 * Read ACCL-Nx sensitivity value.
 * Read the mindsensors ACCL-Nx sensitivity value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The sensitivity value.
 */
inline byte ACCLNxSensitivity(const byte port, const byte i2caddr);

/**
 * Read ACCL-Nx X offset value.
 * Read the mindsensors ACCL-Nx sensor's X offset value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The X offset value.
 */
inline int ACCLNxXOffset(const byte port, const byte i2caddr);

/**
 * Read ACCL-Nx X range value.
 * Read the mindsensors ACCL-Nx sensor's X range value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The X range value.
 */
inline int ACCLNxXRange(const byte port, const byte i2caddr);

/**
 * Read ACCL-Nx Y offset value.
 * Read the mindsensors ACCL-Nx sensor's Y offset value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The Y offset value.
 */
inline int ACCLNxYOffset(const byte port, const byte i2caddr);

/**
 * Read ACCL-Nx Y range value.
 * Read the mindsensors ACCL-Nx sensor's Y range value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The Y range value.
 */
inline int ACCLNxYRange(const byte port, const byte i2caddr);

/**
 * Read ACCL-Nx Z offset value.
 * Read the mindsensors ACCL-Nx sensor's Z offset value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The Z offset value.
 */
inline int ACCLNxZOffset(const byte port, const byte i2caddr);

/**
 * Read ACCL-Nx Z range value.
 * Read the mindsensors ACCL-Nx sensor's Z range value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The Z range value.
 */
inline int ACCLNxZRange(const byte port, const byte i2caddr);

/**
 * Configure PSPNx in digital mode.
 * Configure the mindsensors PSPNx device in digital mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char PSPNxDigital(const byte & port, const byte & i2caddr);

/**
 * Configure PSPNx in analog mode.
 * Configure the mindsensors PSPNx device in analog mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char PSPNxAnalog(const byte & port, const byte & i2caddr);

/**
 * Read NXTServo servo position value.
 * Read the mindsensors NXTServo device's servo position value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param servo The servo number. See \ref NXTServoNumbers group.
 * \return The specified servo's position value.
 */
inline unsigned int NXTServoPosition(const byte & port, const byte & i2caddr, const byte servo);

/**
 * Read NXTServo servo speed value.
 * Read the mindsensors NXTServo device's servo speed value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param servo The servo number. See \ref NXTServoNumbers group.
 * \return The specified servo's speed value.
 */
inline byte NXTServoSpeed(const byte & port, const byte & i2caddr, const byte servo);

/**
 * Read NXTServo battery voltage value.
 * Read the mindsensors NXTServo device's battery voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \result The battery level.
 */
inline byte NXTServoBatteryVoltage(const byte & port, const byte & i2caddr);

/**
 * Set NXTServo servo motor speed.
 * Set the speed of a servo motor controlled by the NXTServo device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param servo The servo number. See \ref NXTServoNumbers group.
 * \param speed The servo speed. (0..255)
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible result values.
 */
inline char SetNXTServoSpeed(const byte & port, const byte & i2caddr, const byte servo, const byte & speed);

/**
 * Set NXTServo servo motor quick position.
 * Set the quick position of a servo motor controlled by the NXTServo device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param servo The servo number. See \ref NXTServoNumbers group.
 * \param qpos The servo quick position. See \ref NXTServoQPos group.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible result values.
 */
inline char SetNXTServoQuickPosition(const byte & port, const byte & i2caddr, const byte servo, const byte & qpos);

/**
 * Set NXTServo servo motor position.
 * Set the position of a servo motor controlled by the NXTServo device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param servo The servo number. See \ref NXTServoNumbers group.
 * \param pos The servo position. See \ref NXTServoPos group.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible result values.
 */
inline char SetNXTServoPosition(const byte & port, const byte & i2caddr, const byte servo, const byte & pos);

/**
 * Reset NXTServo properties.
 * Reset NXTServo device properties to factory defaults.
 * Initial position = 1500.  Initial speed = 0. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible result values.
 */
inline char NXTServoReset(const byte & port, const byte & i2caddr);

/**
 * Halt NXTServo macro.
 * Halt a macro executing on the NXTServo device. This command re-initializes
 * the macro environment.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible result values.
 */
inline char NXTServoHaltMacro(const byte & port, const byte & i2caddr);

/**
 * Resume NXTServo macro.
 * Resume a macro executing on the NXTServo device. This command resumes
 * executing a macro where it was paused last, using the same environment.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible result values.
 */
inline char NXTServoResumeMacro(const byte & port, const byte & i2caddr);

/**
 * Pause NXTServo macro.
 * Pause a macro executing on the NXTServo device. This command will pause the
 * currently executing macro, and save the environment for subsequent resumption.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible result values.
 */
inline char NXTServoPauseMacro(const byte & port, const byte & i2caddr);

/**
 * Initialize NXTServo servo properties.
 * Store the initial speed and position properties of the servo motor 'n'.
 * Current speed and position values of the nth servo is read from the
 * servo speed register and servo position register and written to permanent
 * memory.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param servo The servo number. See \ref NXTServoNumbers group.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible result values.
 */
inline char NXTServoInit(const byte & port, const byte & i2caddr, const byte servo);

/**
 * Goto NXTServo macro address.
 * Run the macro found at the specified EEPROM macro address. This command
 * re-initializes the macro environment.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param macro The EEPROM macro address.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible result values.
 */
inline char NXTServoGotoMacroAddress(const byte & port, const byte & i2caddr, const byte & macro);

/**
 * Edit NXTServo macro.
 * Put the NXTServo device into macro edit mode. This operation changes the
 * I2C address of the device to 0x40.  Macros are written to EEPROM addresses
 * between 0x21 and 0xFF. Use \ref NXTServoQuitEdit to return the device to
 * its normal operation mode.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible result values.
 */
inline char NXTServoEditMacro(const byte & port, const byte & i2caddr);

/**
 * Quit NXTServo macro edit mode.
 * Stop editing NXTServo device macro EEPROM memory. Use \ref NXTServoEditMacro
 * to start editing a macro.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible result values.
 */
inline char NXTServoQuitEdit(const byte & port);

/**
 * Set NXTHID into ASCII data mode.
 * Set the NXTHID device into ASCII data mode. Only printable characters can be
 * transmitted in this mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char NXTHIDAsciiMode(const byte & port, const byte & i2caddr);

/**
 * Set NXTHID into direct data mode.
 * Set the NXTHID device into direct data mode. Any character can be transmitted
 * while in this mode.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char NXTHIDDirectMode(const byte & port, const byte & i2caddr);

/**
 * Transmit NXTHID character.
 * Transmit a single character to a computer using the NXTHID device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char NXTHIDTransmit(const byte & port, const byte & i2caddr);

/**
 * Load NXTHID character.
 * Load a character into the NXTHID device.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param modifier The key modifier. See the \ref NXTHIDModifiers group.
 * \param character The character.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char NXTHIDLoadCharacter(const byte & port, const byte & i2caddr, const byte & modifier, const byte & character);

/**
 * Reset NXTPowerMeter counters.
 * Reset the NXTPowerMeter counters back to zero. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char NXTPowerMeterResetCounters(const byte & port, const byte & i2caddr);

/**
 * Read NXTPowerMeter present current.
 * Read the mindsensors NXTPowerMeter device's present current value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The NXTPowerMeter present current.
 */
inline int NXTPowerMeterPresentCurrent(const byte & port, const byte & i2caddr);

/**
 * Read NXTPowerMeter present voltage.
 * Read the mindsensors NXTPowerMeter device's present voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The NXTPowerMeter present voltage.
 */
inline int NXTPowerMeterPresentVoltage(const byte & port, const byte & i2caddr);

/**
 * Read NXTPowerMeter capacity used.
 * Read the mindsensors NXTPowerMeter device's capacity used since the last reset command.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The NXTPowerMeter capacity used value.
 */
inline int NXTPowerMeterCapacityUsed(const byte & port, const byte & i2caddr);

/**
 * Read NXTPowerMeter present power.
 * Read the mindsensors NXTPowerMeter device's present power value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The NXTPowerMeter present power value.
 */
inline int NXTPowerMeterPresentPower(const byte & port, const byte & i2caddr);

/**
 * Read NXTPowerMeter total power consumed.
 * Read the mindsensors NXTPowerMeter device's total power consumed since the last reset command.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The NXTPowerMeter total power consumed value.
 */
inline long NXTPowerMeterTotalPowerConsumed(const byte & port, const byte & i2caddr);

/**
 * Read NXTPowerMeter maximum current.
 * Read the mindsensors NXTPowerMeter device's maximum current value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The NXTPowerMeter maximum current value.
 */
inline int NXTPowerMeterMaxCurrent(const byte & port, const byte & i2caddr);

/**
 * Read NXTPowerMeter minimum current.
 * Read the mindsensors NXTPowerMeter device's minimum current value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The NXTPowerMeter minimum current value.
 */
inline int NXTPowerMeterMinCurrent(const byte & port, const byte & i2caddr);

/**
 * Read NXTPowerMeter maximum voltage.
 * Read the mindsensors NXTPowerMeter device's maximum voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The NXTPowerMeter maximum voltage value.
 */
inline int NXTPowerMeterMaxVoltage(const byte & port, const byte & i2caddr);

/**
 * Read NXTPowerMeter minimum voltage.
 * Read the mindsensors NXTPowerMeter device's minimum voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The NXTPowerMeter minimum voltage value.
 */
inline int NXTPowerMeterMinVoltage(const byte & port, const byte & i2caddr);

/**
 * Read NXTPowerMeter elapsed time.
 * Read the mindsensors NXTPowerMeter device's elapsed time since the last reset command.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The NXTPowerMeter elapsed time value.
 */
inline long NXTPowerMeterElapsedTime(const byte & port, const byte & i2caddr);

/**
 * Read NXTPowerMeter error count.
 * Read the mindsensors NXTPowerMeter device's error count value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The NXTPowerMeter error count value.
 */
inline int NXTPowerMeterErrorCount(const byte & port, const byte & i2caddr);

/**
 * Powerdown NXTLineLeader device.
 * Put the NXTLineLeader to sleep so that it does not consume power when it is
 * not required. The device wakes up on its own when any I2C communication
 * happens or you can specifically wake it up by using the \ref NXTLineLeaderPowerUp
 * command.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char NXTLineLeaderPowerDown(const byte & port, const byte & i2caddr);

/**
 * Powerup NXTLineLeader device.
 * Wake up the NXTLineLeader device so that it can be used. The device can be
 * put to sleep using the \ref NXTLineLeaderPowerDown command.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char NXTLineLeaderPowerUp(const byte & port, const byte & i2caddr);

/**
 * Invert NXTLineLeader colors.
 * Invert color sensing so that the device can detect a white line on a
 * black background.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char NXTLineLeaderInvert(const byte & port, const byte & i2caddr);

/**
 * Reset NXTLineLeader color inversion.
 * Reset the NXTLineLeader color detection back to its default state (black
 * line on a white background).
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char NXTLineLeaderReset(const byte & port, const byte & i2caddr);

/**
 * Take NXTLineLeader line snapshot.
 * Takes a snapshot of the line under the sensor and tracks that position in
 * subsequent tracking operations.  This function also will set color inversion
 * if it sees a white line on a black background.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char NXTLineLeaderSnapshot(const byte & port, const byte & i2caddr);

/**
 * Calibrate NXTLineLeader white color.
 * Store calibration data for the white color.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char NXTLineLeaderCalibrateWhite(const byte & port, const byte & i2caddr);

/**
 * Calibrate NXTLineLeader black color.
 * Store calibration data for the black color.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char NXTLineLeaderCalibrateBlack(const byte & port, const byte & i2caddr);

/**
 * Read NXTLineLeader steering.
 * Read the mindsensors NXTLineLeader device's steering value. This is the power
 * returned by the sensor to correct your course.  Add this value to your left
 * motor and subtract it from your right motor.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The NXTLineLeader steering value.
 */
inline char NXTLineLeaderSteering(const byte & port, const byte & i2caddr);

/**
 * Read NXTLineLeader average.
 * Read the mindsensors NXTLineLeader device's average value. The
 * average is a weighted average of the bits set to 1 based on the position.
 * The left most bit has a weight of 10, second bit has a weight of 20, and so
 * forth. When all 8 sensors are over a black surface the average will be 45.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The NXTLineLeader average value.
 */
inline char NXTLineLeaderAverage(const byte & port, const byte & i2caddr);

/**
 * Read NXTLineLeader result.
 * Read the mindsensors NXTLineLeader device's result value. This is a single
 * byte showing the 8 sensor's readings. Each bit corresponding to the sensor
 * where the line is seen is set to 1, otherwise it is set to 0.
 * When all 8 sensors are over a black surface the result will be 255 (b11111111).
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The NXTLineLeader result value.
 */
inline byte NXTLineLeaderResult(const byte & port, const byte & i2caddr);

/**
 * Write NXTLineLeader setpoint.
 * Write a new setpoint value to the NXTLineLeader device. The Set Point is a
 * value you can ask sensor to maintain the average to. The default value is
 * 45, whereby the line is maintained in center of the sensor. If you need to
 * maintain line towards left of the sensor, set the Set Point to
 * a lower value (minimum: 10). If you need it to be towards on the right of the
 * sensor, set it to higher value (maximum: 80). Set point is also useful while
 * tracking an edge of dark and light areas.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param value The new setpoint value (10..80).
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char SetNXTLineLeaderSetpoint(const byte & port, const byte & i2caddr, const byte & value);

/**
 * Write NXTLineLeader Kp value.
 * Write a Kp value to the NXTLineLeader device. This value divided by PID
 * Factor for Kp is the Proportional value for the PID control. Suggested value
 * is 25 with a divisor factor of 32 (which is also a factory default), start
 * with this value, and tune it to meet your needs. Value ranges
 * between 0 and 255.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param value The new Kp value (0..255).
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char SetNXTLineLeaderKpValue(const byte & port, const byte & i2caddr, const byte & value);

/**
 * Write NXTLineLeader Ki value.
 * Write a Ki value to the NXTLineLeader device. This value divided by PID
 * Factor for Ki is the Integral value for the PID control. Suggested value
 * is 0 with a divisor factor of 32 (which is also a factory default), start
 * with this value, and tune it to meet your needs. Value ranges
 * between 0 and 255.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param value The new Ki value (0..255).
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char SetNXTLineLeaderKiValue(const byte & port, const byte & i2caddr, const byte & value);

/**
 * Write NXTLineLeader Kd value.
 * Write a Kd value to the NXTLineLeader device. This value divided by PID
 * Factor for Kd is the Derivative value for the PID control. Suggested value
 * is 8 with a divisor factor of 32 (which is also a factory default), start
 * with this value, and tune it to meet your needs. Value ranges
 * between 0 and 255.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param value The new Kd value (0..255).
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char SetNXTLineLeaderKdValue(const byte & port, const byte & i2caddr, const byte & value);

/**
 * Write NXTLineLeader Kp factor.
 * Write a Kp divisor factor to the NXTLineLeader device. Value ranges between
 * 1 and 255. Change this value if you need more granularities in Kp value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param value The new Kp factor (1..255).
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char SetNXTLineLeaderKpFactor(const byte & port, const byte & i2caddr, const byte & value);

/**
 * Write NXTLineLeader Ki factor.
 * Write a Ki divisor factor to the NXTLineLeader device. Value ranges between
 * 1 and 255. Change this value if you need more granularities in Ki value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param value The new Ki factor (1..255).
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char SetNXTLineLeaderKiFactor(const byte & port, const byte & i2caddr, const byte & value);

/**
 * Write NXTLineLeader Kd factor.
 * Write a Kd divisor factor to the NXTLineLeader device. Value ranges between
 * 1 and 255. Change this value if you need more granularities in Kd value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param value The new Kd factor (1..255).
 * \return A status code indicating whether the operation completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char SetNXTLineLeaderKdFactor(const byte & port, const byte & i2caddr, const byte & value);

#else

#define SensorMSDROD(_p) asm { getin __RETVAL__, _p, NormalizedValueField }
#define SensorNXTSumoEyesRaw(_p) asm { getin __RETVAL__, _p, NormalizedValueField }
#define SensorMSPressureRaw(_p) asm { getin __RETVAL__, _p, RawValueField }
#define SensorMSCompass(_port, _i2caddr) asm { __ReadSensorMSCompass(_port, _i2caddr, __RETVAL__) }
#define ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year) asm { __ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year, __RETVAL__) }
#define ReadSensorMSTilt(_port, _i2caddr, _x, _y, _z) asm { __ReadSensorMSTilt(_port, _i2caddr, _x, _y, _z, __RETVAL__) }
#define ReadSensorMSAccel(_port, _i2caddr, _x, _y, _z) asm { __ReadSensorMSAccel(_port, _i2caddr, _x, _y, _z, __RETVAL__) }

#define MSReadValue(_port, _i2caddr, _reg, _bytes) asm { __I2CReadValue(_port, _i2caddr, _reg, _bytes, __RETVAL__, __TMPBYTE__) }
#define MSEnergize(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, MS_CMD_ENERGIZED, __RETVAL__) }
#define MSDeenergize(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, MS_CMD_DEENERGIZED, __RETVAL__) }
#define MSADPAOn(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, MS_CMD_ADPA_ON, __RETVAL__) }
#define MSADPAOff(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, MS_CMD_ADPA_OFF, __RETVAL__) }

#define DISTNxGP2D12(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2D12, __RETVAL__) }
#define DISTNxGP2D120(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2D120, __RETVAL__) }
#define DISTNxGP2YA21(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2YA21, __RETVAL__) }
#define DISTNxGP2YA02(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2YA02, __RETVAL__) }
#define DISTNxDistance(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, DIST_REG_DIST, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxVoltage(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, DIST_REG_VOLT, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxModuleType(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, DIST_REG_MODULE_TYPE, 1, __RETVAL__, __TMPBYTE__) }
#define DISTNxNumPoints(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, DIST_REG_NUM_POINTS, 1, __RETVAL__, __TMPBYTE__) }
#define DISTNxMinDistance(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, DIST_REG_DIST_MIN, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxMaxDistance(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, DIST_REG_DIST_MAX, 2, __RETVAL__, __TMPBYTE__) }

#define ACCLNxCalibrateX(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, ACCL_CMD_X_CAL, __RETVAL__) }
#define ACCLNxCalibrateXEnd(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, ACCL_CMD_X_CAL_END, __RETVAL__) }
#define ACCLNxCalibrateY(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Y_CAL, __RETVAL__) }
#define ACCLNxCalibrateYEnd(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Y_CAL_END, __RETVAL__) }
#define ACCLNxCalibrateZ(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Z_CAL, __RETVAL__) }
#define ACCLNxCalibrateZEnd(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Z_CAL_END, __RETVAL__) }
#define ACCLNxResetCalibration(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, ACCL_CMD_RESET_CAL, __RETVAL__) }
#define SetACCLNxSensitivity(_port, _i2caddr, _slevel) asm { __I2CSendCmd(_port, _i2caddr, _slevel, __RETVAL__) }
#define ACCLNxSensitivity(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, ACCL_REG_SENS_LVL, 1, __RETVAL__, __TMPBYTE__) }
#define ACCLNxXOffset(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, ACCL_REG_X_OFFSET, 2, __RETVAL__, __TMPBYTE__) }
#define ACCLNxXRange(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, ACCL_REG_X_RANGE, 2, __RETVAL__, __TMPBYTE__) }
#define ACCLNxYOffset(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, ACCL_REG_Y_OFFSET, 2, __RETVAL__, __TMPBYTE__) }
#define ACCLNxYRange(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, ACCL_REG_Y_RANGE, 2, __RETVAL__, __TMPBYTE__) }
#define ACCLNxZOffset(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, ACCL_REG_Z_OFFSET, 2, __RETVAL__, __TMPBYTE__) }
#define ACCLNxZRange(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, ACCL_REG_Z_RANGE, 2, __RETVAL__, __TMPBYTE__) }

#define PFMateSend(_port, _i2caddr, _channel, _motors, _cmdA, _spdA, _cmdB, _spdB) asm { __PFMateSend(_port, _i2caddr, _channel, _motors, _cmdA, _spdA, _cmdB, _spdB, __RETVAL__) }
#define PFMateSendRaw(_port, _i2caddr, _channel, _b1, _b2) asm { __PFMateSendRaw(_port, _i2caddr, _channel, _b1, _b2, __RETVAL__) }

#define NXTServoPosition(_port, _i2caddr, _servo) asm { __I2CReadValue(_port, _i2caddr, NXTSERVO_REG_S1_POS+(_servo*2), 2, __RETVAL__, __TMPBYTE__) }
#define NXTServoSpeed(_port, _i2caddr, _servo) asm { __I2CReadValue(_port, _i2caddr, NXTSERVO_REG_S1_SPEED+_servo, 1, __RETVAL__, __TMPBYTE__) }
#define NXTServoBatteryVoltage(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, NXTSERVO_REG_VOLTAGE, 1, __RETVAL__, __TMPBYTE__) }
#define SetNXTServoSpeed(_port, _i2caddr, _servo, _speed) asm { __MSWriteToRegister(_port, _i2caddr, NXTSERVO_REG_S1_SPEED+_servo, _speed, __RETVAL__) }
#define SetNXTServoQuickPosition(_port, _i2caddr, _servo, _qpos) asm { __MSWriteToRegister(_port, _i2caddr, NXTSERVO_REG_S1_QPOS+_servo, _qpos, __RETVAL__) }
#define SetNXTServoPosition(_port, _i2caddr, _servo, _pos) asm { __MSWriteLEIntToRegister(_port, _i2caddr, NXTSERVO_REG_S1_POS+(_servo*2), _pos, __RETVAL__) }
#define NXTServoReset(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_RESET, __RETVAL__) }
#define NXTServoHaltMacro(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_HALT, __RETVAL__) }
#define NXTServoResumeMacro(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_RESUME, __RETVAL__) }
#define NXTServoPauseMacro(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_PAUSE, __RETVAL__) }
#define NXTServoInit(_port, _i2caddr, _servo) asm { __NXTServoInit(_port, _i2caddr, _servo, __RETVAL__) }
#define NXTServoGotoMacroAddress(_port, _i2caddr, _macro) asm { __NXTServoGotoMacroAddress(_port, _i2caddr, _macro, __RETVAL__) }
#define NXTServoEditMacro(_port, _i2caddr) asm { __NXTServoEditMacro(_port, _i2caddr, __RETVAL__) }
#define NXTServoQuitEdit(_port) asm { __MSWriteToRegister(_port, MS_ADDR_NXTSERVO_EM, NXTSERVO_EM_REG_CMD, NXTSERVO_EM_CMD_QUIT, __RETVAL__) }

#define NXTHIDAsciiMode(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NXTHID_CMD_ASCII, __RETVAL__) }
#define NXTHIDDirectMode(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NXTHID_CMD_DIRECT, __RETVAL__) }
#define NXTHIDTransmit(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NXTHID_CMD_TRANSMIT, __RETVAL__) }
#define NXTHIDLoadCharacter(_port, _i2caddr, _modifier, _character) asm { __NXTHIDLoadCharacter(_port, _i2caddr, _modifier, _character, __RETVAL__) }

#define NXTPowerMeterResetCounters(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NXTPM_CMD_RESET, __RETVAL__) }
#define NXTPowerMeterPresentCurrent(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, NXTPM_REG_CURRENT, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterPresentVoltage(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, NXTPM_REG_VOLTAGE, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterCapacityUsed(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, NXTPM_REG_CAPACITY, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterPresentPower(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, NXTPM_REG_POWER, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterTotalPowerConsumed(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, NXTPM_REG_POWER, 4, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterMaxCurrent(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, NXTPM_REG_MAXCURRENT, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterMinCurrent(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, NXTPM_REG_MINCURRENT, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterMaxVoltage(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, NXTPM_REG_MAXVOLTAGE, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterMinVoltage(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, NXTPM_REG_MINVOLTAGE, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterElapsedTime(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, NXTPM_REG_TIME, 4, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterErrorCount(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, NXTPM_REG_ERRORCOUNT, 2, __RETVAL__, __TMPBYTE__) }

#define NXTLineLeaderSteering(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, NXTLL_REG_STEERING, 1, __RETVAL__, __TMPBYTE__) }
#define NXTLineLeaderAverage(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, NXTLL_REG_AVERAGE, 1, __RETVAL__, __TMPBYTE__) }
#define NXTLineLeaderResult(_port, _i2caddr) asm { __I2CReadValue(_port, _i2caddr, NXTLL_REG_RESULT, 1, __RETVAL__, __TMPBYTE__) }
#define NXTLineLeaderPowerDown(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_POWERDOWN, __RETVAL__) }
#define NXTLineLeaderPowerUp(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_POWERUP, __RETVAL__) }
#define NXTLineLeaderInvert(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_INVERT, __RETVAL__) }
#define NXTLineLeaderReset(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_RESET, __RETVAL__) }
#define NXTLineLeaderSnapshot(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_SNAPSHOT, __RETVAL__) }
#define NXTLineLeaderCalibrateWhite(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_WHITE, __RETVAL__) }
#define NXTLineLeaderCalibrateBlack(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_BLACK, __RETVAL__) }
#define SetNXTLineLeaderSetpoint(_port, _i2caddr, _value) asm { __MSWriteToRegister(_port, _i2caddr, NXTLL_REG_SETPOINT, _value, __RETVAL__) }
#define SetNXTLineLeaderKpValue(_port, _i2caddr, _value) asm { __MSWriteToRegister(_port, _i2caddr, NXTLL_REG_KP_VALUE, _value, __RETVAL__) }
#define SetNXTLineLeaderKiValue(_port, _i2caddr, _value) asm { __MSWriteToRegister(_port, _i2caddr, NXTLL_REG_KI_VALUE, _value, __RETVAL__) }
#define SetNXTLineLeaderKdValue(_port, _i2caddr, _value) asm { __MSWriteToRegister(_port, _i2caddr, NXTLL_REG_KD_VALUE, _value, __RETVAL__) }
#define SetNXTLineLeaderKpFactor(_port, _i2caddr, _value) asm { __MSWriteToRegister(_port, _i2caddr, NXTLL_REG_KP_FACTOR, _value, __RETVAL__) }
#define SetNXTLineLeaderKiFactor(_port, _i2caddr, _value) asm { __MSWriteToRegister(_port, _i2caddr, NXTLL_REG_KI_FACTOR, _value, __RETVAL__) }
#define SetNXTLineLeaderKdFactor(_port, _i2caddr, _value) asm { __MSWriteToRegister(_port, _i2caddr, NXTLL_REG_KD_FACTOR, _value, __RETVAL__) }

#define PSPNxDigital(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, PSP_CMD_DIGITAL, __RETVAL__) }
#define PSPNxAnalog(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, PSP_CMD_ANALOG, __RETVAL__) }

#define ReadSensorMSPlayStation(_port, _i2caddr, _b1, _b2, _xleft, _yleft, _xright, _yright) asm { __ReadSensorMSPlayStation(_port, _i2caddr, _b1, _b2, _xleft, _yleft, _xright, _yright, __RETVAL__) }

// mindsensors_nrlink.h

#endif

/** @} */ // end of MindSensorsAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // MINDSENSORS_H
