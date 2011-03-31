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
 * Portions created by John Hansen are Copyright (C) 2009-2010 John Hansen.
 * All Rights Reserved.
 *
 * ----------------------------------------------------------------------------
 *
 * \author John Hansen (bricxcc_at_comcast.net)
 * \date 2011-03-17
 * \version 1
 */

#ifndef MINDSENSORS_H
#define MINDSENSORS_H

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// MindSensors API ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////


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

/**
 * Configure NRLink in 2400 baud mode.
 * Configure the mindsensors NRLink device in 2400 baud mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLink2400(const byte port, const byte i2caddr);

/**
 * Configure NRLink in 4800 baud mode.
 * Configure the mindsensors NRLink device in 4800 baud mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLink4800(const byte port, const byte i2caddr);

/**
 * Flush NRLink buffers.
 * Flush the mindsensors NRLink device buffers. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkFlush(const byte port, const byte i2caddr);

/**
 * Configure NRLink in IR long mode.
 * Configure the mindsensors NRLink device in IR long mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkIRLong(const byte port, const byte i2caddr);

/**
 * Configure NRLink in IR short mode.
 * Configure the mindsensors NRLink device in IR short mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkIRShort(const byte port, const byte i2caddr);

/**
 * Configure NRLink in power function mode.
 * Configure the mindsensors NRLink device in power function mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkSetPF(const byte port, const byte i2caddr);

/**
 * Configure NRLink in RCX mode.
 * Configure the mindsensors NRLink device in RCX mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkSetRCX(const byte port, const byte i2caddr);

/**
 * Configure NRLink in IR train mode.
 * Configure the mindsensors NRLink device in IR train mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkSetTrain(const byte port, const byte i2caddr);

/**
 * Configure NRLink in raw IR transmit mode.
 * Configure the mindsensors NRLink device in raw IR transmit mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkTxRaw(const byte port, const byte i2caddr);

/**
 * Read NRLink status.
 * Read the status of the mindsensors NRLink device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The mindsensors NRLink status.
 */
inline byte NRLinkStatus(const byte port, const byte i2caddr);

/**
 * Run NRLink macro.
 * Run the specified mindsensors NRLink device macro. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param macro The address of the macro to execute.
 * \return The function call result.
 */
inline char RunNRLinkMacro(const byte port, const byte i2caddr, const byte macro);

/**
 * Write data to NRLink.
 * Write data to the mindsensors NRLink device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param data A byte array containing the data to write.
 * \return The function call result.
 */
inline char WriteNRLinkBytes(const byte port, const byte i2caddr, const byte data[]);

/**
 * Read data from NRLink.
 * Read data from the mindsensors NRLink device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param data A byte array that will contain the data read from the device on output.
 * \return The function call result.
 */
inline bool ReadNRLinkBytes(const byte port, const byte i2caddr, byte & data[]);

/**
 * MSIRTrain function.
 * Control an IR Train receiver set to the specified channel using the
 * mindsensors NRLink device. Valid function values are \ref TRAIN_FUNC_STOP,
 * \ref TRAIN_FUNC_INCR_SPEED, \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT.
 * Valid channels are \ref TRAIN_CHANNEL_1 through \ref TRAIN_CHANNEL_3 and
 * \ref TRAIN_CHANNEL_ALL. The port must be configured as a Lowspeed port before
 * using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The IR Train channel.  See \ref IRTrainChannels.
 * \param func The IR Train function. See \ref IRTrainFuncs
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSIRTrain(const byte port, const byte i2caddr, const byte channel, const byte func);

/**
 * MSPFComboDirect function.
 * Execute a pair of Power Function motor commands on the specified channel
 * using the mindsensors NRLink device. Commands for outa and outb are
 * PF_CMD_STOP, PF_CMD_REV, PF_CMD_FWD, and \ref PF_CMD_BRAKE. Valid channels are
 * PF_CHANNEL_1 through PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param outa The Power Function command for output A. See \ref PFCmdConstants.
 * \param outb The Power Function command for output B. See \ref PFCmdConstants.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFComboDirect(const byte port, const byte i2caddr, const byte channel, const byte outa, const byte outb);

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
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param outa The Power Function PWM command for output A. See \ref PFPWMOptions.
 * \param outb The Power Function PWM command for output B. See \ref PFPWMOptions.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFComboPWM(const byte port, const byte i2caddr, const byte channel, const byte outa, const byte outb);

/**
 * MSPFRawOutput function.
 * Control a Power Function receiver set to the specified channel using the
 * mindsensors NRLink device. Build the raw data stream using the 3 nibbles
 * (4 bit values). The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param nibble0 The first raw data nibble.
 * \param nibble1 The second raw data nibble.
 * \param nibble2 The third raw data nibble.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFRawOutput(const byte port, const byte i2caddr, const byte nibble0, const byte nibble1, const byte nibble2);

/**
 * MSPFRepeat function.
 * Repeat sending the last Power Function command using the mindsensors
 * NRLink device. Specify the number of times to repeat the command and the
 * number of milliseconds of delay between each repetition. The port must be
 * configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param count The number of times to repeat the command.
 * \param delay The number of milliseconds to delay between each repetition.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFRepeat(const byte port, const byte i2caddr, const byte count, const unsigned int delay);

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
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param out The Power Function output. See \ref PFOutputs.
 * \param func The Power Function CST function. See \ref PFCSTOptions.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFSingleOutputCST(const byte port, const byte i2caddr, const byte channel, const byte out, const byte func);

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
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param out The Power Function output. See \ref PFOutputs.
 * \param func The Power Function PWM function. See \ref PFPWMOptions.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFSingleOutputPWM(const byte port, const byte i2caddr, const byte channel, const byte out, const byte func);

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
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param out The Power Function output. See \ref PFOutputs.
 * \param pin The Power Function pin. See \ref PFPinConstants.
 * \param func The Power Function single pin function. See \ref PFPinFuncs.
 * \param cont Control whether the mode is continuous or timeout.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFSinglePin(const byte port, const byte i2caddr, const byte channel, const byte out, const byte pin, const byte func, bool cont);

/**
 * MSPFTrain function.
 * Control both outputs on a Power Function receiver set to the specified
 * channel using the mindsensors NRLink device as if it were an IR Train
 * receiver. Valid function values are \ref TRAIN_FUNC_STOP, \ref TRAIN_FUNC_INCR_SPEED,
 * \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT. Valid channels are
 * PF_CHANNEL_1 through PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param func The Power Function train function. See \ref IRTrainFuncs.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFTrain(const byte port, const byte i2caddr, const byte channel, const byte func);

/**
 * MSRCXSetIRLinkPort function.
 * Set the global port in advance of using the MSRCX* and MSScout* API
 * functions for sending RCX and Scout messages over the mindsensors NRLink
 * device. The port must be configured as a Lowspeed port before using any of
 * the mindsensors RCX and Scout NRLink functions.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 */
inline void MSRCXSetNRLinkPort(const byte port, const byte i2caddr);

/**
 * MSRCXBatteryLevel function.
 * Send the BatteryLevel command to an RCX to read the current battery level.
 *
 * \return The RCX battery level.
 */
inline int MSRCXBatteryLevel(void);

/**
 * MSRCXPoll function.
 * Send the Poll command to an RCX to read a signed 2-byte value at the
 * specified source and value combination.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 * \return The value read from the specified port and value.
 */
inline int MSRCXPoll(const byte src, const byte value);

/**
 * MSRCXPollMemory function.
 * Send the PollMemory command to an RCX.
 *
 * \param address The RCX memory address.
 * \return The value read from the specified address.
 */
inline int MSRCXPollMemory(const unsigned int address);

/**
 * MSRCXAbsVar function.
 * Send the AbsVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXAbsVar(const byte varnum, const byte byte src, const unsigned int value);

/**
 * MSRCXAddToDatalog function.
 * Send the AddToDatalog command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXAddToDatalog(const byte src, const unsigned int value);

/**
 * MSRCXAndVar function.
 * Send the AndVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXAndVar(const byte varnum, const byte src, const unsigned int value);

/**
 * MSRCXBoot function.
 * Send the Boot command to an RCX.
 */
inline void MSRCXBoot(void);

/**
 * MSRCXCalibrateEvent function.
 * Send the CalibrateEvent command to an RCX.
 *
 * \param evt The event number.
 * \param low The low threshold.
 * \param hi The high threshold.
 * \param hyst The hysterisis value.
 */
inline void MSRCXCalibrateEvent(const byte evt, const byte low, const byte hi, const byte hyst);

/**
 * MSRCXClearAllEvents function.
 * Send the ClearAllEvents command to an RCX.
 */
inline void MSRCXClearAllEvents(void);

/**
 * MSRCXClearCounter function.
 * Send the ClearCounter command to an RCX.
 *
 * \param counter The counter to clear.
 */
inline void MSRCXClearCounter(const byte counter);

/**
 * MSRCXClearMsg function.
 * Send the ClearMsg command to an RCX.
 */
inline void MSRCXClearMsg(void);

/**
 * MSRCXClearSensor function.
 * Send the ClearSensor command to an RCX.
 *
 * \param port The RCX port number.
 */
inline void MSRCXClearSensor(const byte port);

/**
 * MSRCXClearSound function.
 * Send the ClearSound command to an RCX.
 */
inline void MSRCXClearSound(void);

/**
 * MSRCXClearTimer function.
 * Send the ClearTimer command to an RCX.
 *
 * \param timer The timer to clear.
 */
inline void MSRCXClearTimer(const byte timer);

/**
 * MSRCXCreateDatalog function.
 * Send the CreateDatalog command to an RCX.
 *
 * \param size The new datalog size.
 */
inline void MSRCXCreateDatalog(const unsigned int size);

/**
 * MSRCXDecCounter function.
 * Send the DecCounter command to an RCX.
 *
 * \param counter The counter to decrement.
 */
inline void MSRCXDecCounter(const byte counter);

/**
 * MSRCXDeleteSub function.
 * Send the DeleteSub command to an RCX.
 *
 * \param s The subroutine number to delete.
 */
inline void MSRCXDeleteSub(const byte s);

/**
 * MSRCXDeleteSubs function.
 * Send the DeleteSubs command to an RCX.
 */
inline void MSRCXDeleteSubs(void);

/**
 * MSRCXDeleteTask function.
 * Send the DeleteTask command to an RCX.
 *
 * \param t The task number to delete.
 */
inline void MSRCXDeleteTask(const byte t);

/**
 * MSRCXDeleteTasks function.
 * Send the DeleteTasks command to an RCX.
 */
inline void MSRCXDeleteTasks(void);

/**
 * MSRCXDisableOutput function.
 * Send the DisableOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to disable. See \ref RCXOutputConstants.
 */
inline void MSRCXDisableOutput(const byte outputs);

/**
 * MSRCXDivVar function.
 * Send the DivVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXDivVar(const byte varnum, const byte src, const unsigned int value);

/**
 * MSRCXEnableOutput function.
 * Send the EnableOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to enable. See \ref RCXOutputConstants.
 */
inline void MSRCXEnableOutput(const byte outputs);

/**
 * MSRCXEvent function.
 * Send the Event command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXEvent(const byte src, const unsigned int value);

/**
 * MSRCXFloat function.
 * Send commands to an RCX to float the specified outputs.
 *
 * \param outputs The RCX output(s) to float. See \ref RCXOutputConstants.
 */
inline void MSRCXFloat(const byte outputs);

/**
 * MSRCXFwd function.
 * Send commands to an RCX to set the specified outputs to the forward direction.
 *
 * \param outputs The RCX output(s) to set forward. See \ref RCXOutputConstants.
 */
inline void MSRCXFwd(const byte outputs);

/**
 * MSRCXIncCounter function.
 * Send the IncCounter command to an RCX.
 *
 * \param counter The counter to increment.
 */
inline void MSRCXIncCounter(const byte counter);

/**
 * MSRCXInvertOutput function.
 * Send the InvertOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to invert. See \ref RCXOutputConstants.
 */
inline void MSRCXInvertOutput(const byte outputs);

/**
 * MSRCXMulVar function.
 * Send the MulVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXMulVar(const byte varnum, const byte src, unsigned int value);

/**
 * MSRCXMuteSound function.
 * Send the MuteSound command to an RCX.
 */
inline void MSRCXMuteSound(void);

/**
 * MSRCXObvertOutput function.
 * Send the ObvertOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to obvert. See \ref RCXOutputConstants.
 */
inline void MSRCXObvertOutput(const byte outputs);

/**
 * MSRCXOff function.
 * Send commands to an RCX to turn off the specified outputs.
 *
 * \param outputs The RCX output(s) to turn off. See \ref RCXOutputConstants.
 */
inline void MSRCXOff(const byte outputs);

/**
 * MSRCXOn function.
 * Send commands to an RCX to turn on the specified outputs.
 *
 * \param outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 */
inline void MSRCXOn(const byte outputs);

/**
 * MSRCXOnFor function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction for the specified duration.
 *
 * \param outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 * \param ms The number of milliseconds to leave the outputs on
 */
inline void MSRCXOnFor(const byte outputs, const unsigned int ms);

/**
 * MSRCXOnFwd function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction.
 *
 * \param outputs The RCX output(s) to turn on in the forward direction. See \ref RCXOutputConstants.
 */
inline void MSRCXOnFwd(const byte outputs);

/**
 * MSRCXOnRev function.
 * Send commands to an RCX to turn on the specified outputs in the reverse direction.
 *
 * \param outputs The RCX output(s) to turn on in the reverse direction. See \ref RCXOutputConstants.
 */
inline void MSRCXOnRev(const byte outputs);

/**
 * MSRCXOrVar function.
 * Send the OrVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXOrVar(const byte varnum, const byte src, const unsigned int value);

/**
 * MSRCXPBTurnOff function.
 * Send the PBTurnOff command to an RCX.
 */
inline void MSRCXPBTurnOff(void);

/**
 * MSRCXPing function.
 * Send the Ping command to an RCX.
 */
inline void MSRCXPing(void);

/**
 * MSRCXPlaySound function.
 * Send the PlaySound command to an RCX.
 *
 * \param snd The sound number to play.
 */
inline void MSRCXPlaySound(const byte snd);

/**
 * MSRCXPlayTone function.
 * Send the PlayTone command to an RCX.
 *
 * \param freq The frequency of the tone to play.
 * \param duration The duration of the tone to play.
 */
inline void MSRCXPlayTone(const unsigned int freq, const byte duration);

/**
 * MSRCXPlayToneVar function.
 * Send the PlayToneVar command to an RCX.
 *
 * \param varnum The variable containing the tone frequency to play.
 * \param duration The duration of the tone to play.
 */
inline void MSRCXPlayToneVar(const byte varnum, const byte duration);

/**
 * MSRCXRemote function.
 * Send the Remote command to an RCX.
 *
 * \param cmd The RCX IR remote command to send. See \ref RCXRemoteConstants.
 */
inline void MSRCXRemote(unsigned int cmd);

/**
 * MSRCXReset function.
 * Send the Reset command to an RCX.
 */
inline void MSRCXReset(void);

/**
 * MSRCXRev function.
 * Send commands to an RCX to set the specified outputs to the reverse direction.
 *
 * \param outputs The RCX output(s) to reverse direction. See \ref RCXOutputConstants.
 */
inline void MSRCXRev(const byte outputs);

/**
 * MSRCXSelectDisplay function.
 * Send the SelectDisplay command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSelectDisplay(const byte src, const unsigned int value);

/**
 * MSRCXSelectProgram function.
 * Send the SelectProgram command to an RCX.
 *
 * \param prog The program number to select.
 */
inline void MSRCXSelectProgram(const byte prog);

/**
 * MSRCXSendSerial function.
 * Send the SendSerial command to an RCX.
 *
 * \param first The first byte address.
 * \param count The number of bytes to send.
 */
inline void MSRCXSendSerial(const byte first, const byte count);

/**
 * MSRCXSet function.
 * Send the Set command to an RCX.
 *
 * \param dstsrc The RCX destination source.  See \ref RCXSourceConstants.
 * \param dstval The RCX destination value.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSet(const byte dstsrc, const byte dstval, const byte src, unsigned int value);

/**
 * MSRCXSetDirection function.
 * Send the SetDirection command to an RCX to configure the direction of the specified outputs.
 *
 * \param outputs The RCX output(s) to set direction. See \ref RCXOutputConstants.
 * \param dir The RCX output direction. See \ref RCXOutputDirection.
 */
inline void MSRCXSetDirection(const byte outputs, const byte dir);

/**
 * MSRCXSetEvent function.
 * Send the SetEvent command to an RCX.
 *
 * \param evt The event number to set.
 * \param src The RCX source. See \ref RCXSourceConstants.
 * \param type The event type.
 */
inline void MSRCXSetEvent(const byte evt, const byte src, const byte type);

/**
 * MSRCXSetGlobalDirection function.
 * Send the SetGlobalDirection command to an RCX.
 *
 * \param outputs The RCX output(s) to set global direction. See \ref RCXOutputConstants.
 * \param dir The RCX output direction. See \ref RCXOutputDirection.
 */
inline void MSRCXSetGlobalDirection(const byte outputs, const byte dir);

/**
 * MSRCXSetGlobalOutput function.
 * Send the SetGlobalOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to set global mode. See \ref RCXOutputConstants.
 * \param mode The RCX output mode. See \ref RCXOutputMode.
 */
inline void MSRCXSetGlobalOutput(const byte outputs, const byte mode);

/**
 * MSRCXSetMaxPower function.
 * Send the SetMaxPower command to an RCX.
 *
 * \param outputs The RCX output(s) to set max power. See \ref RCXOutputConstants.
 * \param pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param pwrval The RCX value.
 */
inline void MSRCXSetMaxPower(const byte outputs, const byte pwrsrc, const byte pwrval);

/**
 * MSRCXSetMessage function.
 * Send the SetMessage command to an RCX.
 *
 * \param msg The numeric message to send.
 */
inline void MSRCXSetMessage(const byte msg);

/**
 * MSRCXSetOutput function.
 * Send the SetOutput command to an RCX to configure the mode of the specified outputs
 *
 * \param outputs The RCX output(s) to set mode. See \ref RCXOutputConstants.
 * \param mode The RCX output mode. See \ref RCXOutputMode.
 */
inline void MSRCXSetOutput(const byte outputs, const byte mode);

/**
 * MSRCXSetPower function.
 * Send the SetPower command to an RCX to configure the power level of the specified outputs.
 *
 * \param outputs The RCX output(s) to set power. See \ref RCXOutputConstants.
 * \param pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param pwrval The RCX value.
 */
inline void MSRCXSetPower(const byte outputs, const byte pwrsrc, const byte pwrval);

/**
 * MSRCXSetPriority function.
 * Send the SetPriority command to an RCX.
 *
 * \param p The new task priority.
 */
inline void MSRCXSetPriority(const byte p);

/**
 * MSRCXSetSensorMode function.
 * Send the SetSensorMode command to an RCX.
 *
 * \param port The RCX sensor port.
 * \param mode The RCX sensor mode.
 */
inline void MSRCXSetSensorMode(const byte port, const byte mode);

/**
 * MSRCXSetSensorType function.
 * Send the SetSensorType command to an RCX.
 *
 * \param port The RCX sensor port.
 * \param type The RCX sensor type.
 */
inline void MSRCXSetSensorType(const byte port, const byte type);

/**
 * MSRCXSetSleepTime function.
 * Send the SetSleepTime command to an RCX.
 *
 * \param t The new sleep time value.
 */
inline void MSRCXSetSleepTime(const byte t);

/**
 * MSRCXSetTxPower function.
 * Send the SetTxPower command to an RCX.
 *
 * \param pwr The IR transmit power level.
 */
inline void MSRCXSetTxPower(const byte pwr);

/**
 * MSRCXSetUserDisplay function.
 * Send the SetUserDisplay command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 * \param precision The number of digits of precision.
 */
inline void MSRCXSetUserDisplay(const byte src, const unsigned int value, const byte precision);

/**
 * MSRCXSetVar function.
 * Send the SetVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSetVar(const byte varnum, const byte src, const unsigned int value);

/**
 * MSRCXSetWatch function.
 * Send the SetWatch command to an RCX.
 *
 * \param hours The new watch time hours value.
 * \param minutes The new watch time minutes value.
 */
inline void MSRCXSetWatch(const byte hours, const byte minutes);

/**
 * MSRCXSgnVar function.
 * Send the SgnVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSgnVar(const byte varnum, const byte src, const unsigned int value);

/**
 * MSRCXStartTask function.
 * Send the StartTask command to an RCX.
 *
 * \param t The task number to start.
 */
inline void MSRCXStartTask(const byte t);

/**
 * MSRCXStopAllTasks function.
 * Send the StopAllTasks command to an RCX.
 */
inline void MSRCXStopAllTasks(void);

/**
 * MSRCXStopTask function.
 * Send the StopTask command to an RCX.
 *
 * \param t The task number to stop.
 */
inline void MSRCXStopTask(const byte t);

/**
 * MSRCXSubVar function.
 * Send the SubVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSubVar(const byte varnum, const byte src, const unsigned int value);

/**
 * MSRCXSumVar function.
 * Send the SumVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSumVar(const byte varnum, const byte src, const unsigned int value);

/**
 * MSRCXToggle function.
 * Send commands to an RCX to toggle the direction of the specified outputs.
 *
 * \param outputs The RCX output(s) to toggle. See \ref RCXOutputConstants.
 */
inline void MSRCXToggle(const byte outputs);

/**
 * MSRCXUnlock function.
 * Send the Unlock command to an RCX.
 */
inline void MSRCXUnlock(void);

/**
 * MSRCXUnmuteSound function.
 * Send the UnmuteSound command to an RCX.
 */
inline void MSRCXUnmuteSound(void);

/**
 * MSScoutCalibrateSensor function.
 * Send the CalibrateSensor command to a Scout.
 */
inline void MSScoutCalibrateSensor(void);

/**
 * MSScoutMuteSound function.
 * Send the MuteSound command to a Scout.
 */
inline void MSScoutMuteSound(void);

/**
 * MSScoutSelectSounds function.
 * Send the SelectSounds command to a Scout.
 *
 * \param grp The Scout sound group to select.
 */
inline void MSScoutSelectSounds(const byte grp);

/**
 * MSScoutSendVLL function.
 * Send the SendVLL command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSendVLL(const byte src, const unsigned int value);

/**
 * MSScoutSetCounterLimit function.
 * Send the SetCounterLimit command to a Scout.
 *
 * \param ctr The counter for which to set the limit.
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetCounterLimit(const byte ctr, const byte src, const unsigned int value);

/**
 * MSScoutSetEventFeedback function.
 * Send the SetEventFeedback command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetEventFeedback(const byte src, const unsigned int value);

/**
 * MSScoutSetLight function.
 * Send the SetLight command to a Scout.
 *
 * \param x Set the light on or off using this value. See \ref ScoutLightConstants.
 */
inline void MSScoutSetLight(const byte x);

/**
 * MSScoutSetScoutMode function.
 * Send the SetScoutMode command to a Scout.
 *
 * \param mode Set the scout mode. See \ref ScoutModeConstants.
*/
inline void MSScoutSetScoutMode(const byte mode);

/**
 * MSScoutSetScoutRules function.
 * Send the SetScoutRules command to a Scout.
 *
 * \param m Scout motion rule. See \ref ScoutMotionRuleConstants.
 * \param t Scout touch rule. See \ref ScoutTouchRuleConstants.
 * \param l Scout light rule. See \ref ScoutLightRuleConstants.
 * \param tm Scout transmit rule. See \ref ScoutTransmitRuleConstants.
 * \param fx Scout special effects rule. See \ref ScoutSpecialEffectConstants.
 */
inline void MSScoutSetScoutRules(const byte m, const byte t, const byte l, const byte tm, const byte fx);

/**
 * MSScoutSetSensorClickTime function.
 * Send the SetSensorClickTime command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetSensorClickTime(const byte src, const unsigned int value);

/**
 * MSScoutSetSensorHysteresis function.
 * Send the SetSensorHysteresis command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetSensorHysteresis(const byte src, const unsigned int value);

/**
 * MSScoutSetSensorLowerLimit function.
 * Send the SetSensorLowerLimit command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetSensorLowerLimit(const byte src, const unsigned int value);

/**
 * MSScoutSetSensorUpperLimit function.
 * Send the SetSensorUpperLimit command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetSensorUpperLimit(const byte src, const unsigned int value);

/**
 * MSScoutSetTimerLimit function.
 * Send the SetTimerLimit command to a Scout.
 *
 * \param tmr The timer for which to set a limit.
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetTimerLimit(const byte tmr, const byte src, const unsigned int value);

/**
 * MSScoutUnmuteSound function.
 * Send the UnmuteSound command to a Scout.
 */
inline void MSScoutUnmuteSound(void);

#else

#define SensorMSDROD(_p) asm { getin __RETVAL__, _p, NormalizedValueField }
#define SensorNXTSumoEyesRaw(_p) asm { getin __RETVAL__, _p, NormalizedValueField }
#define SensorMSPressureRaw(_p) asm { getin __RETVAL__, _p, RawValueField }
#define SensorMSCompass(_port, _i2caddr) asm { ReadSensorMSCompass(_port, _i2caddr, __RETVAL__) }
#define ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year) asm { __ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year, __RETVAL__) }
#define ReadSensorMSTilt(_port, _i2caddr, _x, _y, _z) asm { __ReadSensorMSTilt(_port, _i2caddr, _x, _y, _z, __RETVAL__) }
#define ReadSensorMSAccel(_port, _i2caddr, _x, _y, _z) asm { __ReadSensorMSAccel(_port, _i2caddr, _x, _y, _z, __RETVAL__) }

#define MSReadValue(_port, _i2caddr, _reg, _bytes) asm { __MSReadValue(_port, _i2caddr, _reg, _bytes, __RETVAL__, __TMPBYTE__) }
#define MSEnergize(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, MS_CMD_ENERGIZED, __RETVAL__) }
#define MSDeenergize(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, MS_CMD_DEENERGIZED, __RETVAL__) }
#define MSADPAOn(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, MS_CMD_ADPA_ON, __RETVAL__) }
#define MSADPAOff(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, MS_CMD_ADPA_OFF, __RETVAL__) }

#define DISTNxGP2D12(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2D12, __RETVAL__) }
#define DISTNxGP2D120(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2D120, __RETVAL__) }
#define DISTNxGP2YA21(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2YA21, __RETVAL__) }
#define DISTNxGP2YA02(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2YA02, __RETVAL__) }
#define DISTNxDistance(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, DIST_REG_DIST, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxVoltage(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, DIST_REG_VOLT, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxModuleType(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, DIST_REG_MODULE_TYPE, 1, __RETVAL__, __TMPBYTE__) }
#define DISTNxNumPoints(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, DIST_REG_NUM_POINTS, 1, __RETVAL__, __TMPBYTE__) }
#define DISTNxMinDistance(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, DIST_REG_DIST_MIN, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxMaxDistance(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, DIST_REG_DIST_MAX, 2, __RETVAL__, __TMPBYTE__) }

#define ACCLNxCalibrateX(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, ACCL_CMD_X_CAL, __RETVAL__) }
#define ACCLNxCalibrateXEnd(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, ACCL_CMD_X_CAL_END, __RETVAL__) }
#define ACCLNxCalibrateY(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Y_CAL, __RETVAL__) }
#define ACCLNxCalibrateYEnd(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Y_CAL_END, __RETVAL__) }
#define ACCLNxCalibrateZ(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Z_CAL, __RETVAL__) }
#define ACCLNxCalibrateZEnd(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Z_CAL_END, __RETVAL__) }
#define ACCLNxResetCalibration(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, ACCL_CMD_RESET_CAL, __RETVAL__) }
#define SetACCLNxSensitivity(_port, _i2caddr, _slevel) asm { __I2CSendCmd(_port, _i2caddr, _slevel, __RETVAL__) }
#define ACCLNxSensitivity(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, ACCL_REG_sENS_LVL, 1, __RETVAL__, __TMPBYTE__) }
#define ACCLNxXOffset(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, ACCL_REG_X_OFFSET, 2, __RETVAL__, __TMPBYTE__) }
#define ACCLNxXRange(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, ACCL_REG_X_RANGE, 2, __RETVAL__, __TMPBYTE__) }
#define ACCLNxYOffset(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, ACCL_REG_Y_OFFSET, 2, __RETVAL__, __TMPBYTE__) }
#define ACCLNxYRange(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, ACCL_REG_Y_RANGE, 2, __RETVAL__, __TMPBYTE__) }
#define ACCLNxZOffset(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, ACCL_REG_Z_OFFSET, 2, __RETVAL__, __TMPBYTE__) }
#define ACCLNxZRange(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, ACCL_REG_Z_RANGE, 2, __RETVAL__, __TMPBYTE__) }

#define PFMateSend(_port, _i2caddr, _channel, _motors, _cmdA, _spdA, _cmdB, _spdB) asm { __PFMateSend(_port, _i2caddr, _channel, _motors, _cmdA, _spdA, _cmdB, _spdB, __RETVAL__) }
#define PFMateSendRaw(_port, _i2caddr, _channel, _b1, _b2) asm { __PFMateSendRaw(_port, _i2caddr, _channel, _b1, _b2, __RETVAL__) }

#define NXTServoPosition(_port, _i2caddr, _servo) asm { __MSReadValue(_port, _i2caddr, NXTSERVO_REG_S1_POS+(_servo*2), 2, __RETVAL__, __TMPBYTE__) }
#define NXTServoSpeed(_port, _i2caddr, _servo) asm { __MSReadValue(_port, _i2caddr, NXTSERVO_REG_S1_SPEED+_servo, 1, __RETVAL__, __TMPBYTE__) }
#define NXTServoBatteryVoltage(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, NXTSERVO_REG_VOLTAGE, 1, __RETVAL__, __TMPBYTE__) }
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
#define NXTPowerMeterPresentCurrent(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, NXTPM_REG_CURRENT, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterPresentVoltage(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, NXTPM_REG_VOLTAGE, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterCapacityUsed(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, NXTPM_REG_CAPACITY, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterPresentPower(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, NXTPM_REG_POWER, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterTotalPowerConsumed(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, NXTPM_REG_POWER, 4, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterMaxCurrent(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, NXTPM_REG_MAXCURRENT, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterMinCurrent(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, NXTPM_REG_MINCURRENT, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterMaxVoltage(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, NXTPM_REG_MAXVOLTAGE, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterMinVoltage(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, NXTPM_REG_MINVOLTAGE, 2, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterElapsedTime(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, NXTPM_REG_TIME, 4, __RETVAL__, __TMPBYTE__) }
#define NXTPowerMeterErrorCount(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, NXTPM_REG_ERRORCOUNT, 2, __RETVAL__, __TMPBYTE__) }

#define NXTLineLeaderSteering(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, NXTLL_REG_STEERING, 1, __RETVAL__, __TMPBYTE__) }
#define NXTLineLeaderAverage(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, NXTLL_REG_AVERAGE, 1, __RETVAL__, __TMPBYTE__) }
#define NXTLineLeaderResult(_port, _i2caddr) asm { __MSReadValue(_port, _i2caddr, NXTLL_REG_RESULT, 1, __RETVAL__, __TMPBYTE__) }
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

#define NRLink2400(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_2400, __RETVAL__) }
#define NRLink4800(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_4800, __RETVAL__) }
#define NRLinkFlush(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_FLUSH, __RETVAL__) }
#define NRLinkIRLong(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_IR_LONG, __RETVAL__) }
#define NRLinkIRShort(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_IR_SHORT, __RETVAL__) }
#define NRLinkTxRaw(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_TX_RAW, __RETVAL__) }
#define NRLinkSetRCX(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_SET_RCX, __RETVAL__) }
#define NRLinkSetTrain(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_SET_TRAIN, __RETVAL__) }
#define NRLinkSetPF(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_SET_PF, __RETVAL__) }

#define RunNRLinkMacro(_port, _i2caddr, _macro) asm { __RunNRLinkMacro(_port, _i2caddr, _macro, __RETVAL__) }

#define NRLinkStatus(_port, _i2caddr) asm { ReadNRLinkStatus(_port, _i2caddr, __RETVAL__, __TMPBYTE__) }

#define WriteNRLinkBytes(_port, _i2caddr, _bytes) asm { __WriteNRLinkBytes(_port, _i2caddr, _bytes, __RETVAL__) }
#define ReadNRLinkBytes(_port, _i2caddr, _bytes) asm { __ReadNRLinkBytes(_port, _i2caddr, _bytes, __RETVAL__) }

#define MSPFComboDirect(_port, _i2caddr, _channel, _outa, _outb) asm { __MSPFComboDirect(_port, _i2caddr, _channel, _outa, _outb, __RETVAL__) }
#define MSPFSinglePin(_port, _i2caddr, _channel, _out, _pin, _func, _cont) asm { __MSPFSinglePin(_port, _i2caddr, _channel, _out, _pin, _func, _cont, __RETVAL__) }
#define MSPFSingleOutputCST(_port, _i2caddr, _channel, _out, _func) asm { __MSPFSingleOutput(_port, _i2caddr, _channel, _out, _func, TRUE, __RETVAL__) }
#define MSPFSingleOutputPWM(_port, _i2caddr, _channel, _out, _func) asm { __MSPFSingleOutput(_port, _i2caddr, _channel, _out, _func, FALSE, __RETVAL__) }
#define MSPFComboPWM(_port, _i2caddr, _channel, _outa, _outb) asm { __MSPFComboPWM(_port, _i2caddr, _channel, _outa, _outb, __RETVAL__) }
#define MSPFTrain(_port, _i2caddr, _channel, _func) asm { __MSIRTrain(_port, _i2caddr, _channel, _func, TRUE, __RETVAL__) }
#define MSIRTrain(_port, _i2caddr, _channel, _func) asm { __MSIRTrain(_port, _i2caddr, _channel, _func, FALSE, __RETVAL__) }
#define MSPFRawOutput(_port, _i2caddr, _nibble0, _nibble1, _nibble2) asm { __MSPFRawOutput(_port, _i2caddr, _nibble0, _nibble1, _nibble2, __RETVAL__) }
#define MSPFRepeat(_port, _i2caddr, _count, _delay) asm { __MSPFRepeatLastCommand(_port, _i2caddr, _count, _delay, __RETVAL__) }

#define MSRCXSetNRLinkPort(_port, _i2caddr) asm { __MSRCXSetNRLink(_port, _i2caddr) }
#define MSRCXPoll(_src, _value) asm { __MSRCXPoll(_src, _value, __RETVAL__) }
#define MSRCXBatteryLevel() asm { __MSRCXBatteryLevel(__RETVAL__) }
#define MSRCXPing() asm { __MSRCXOpNoArgs(RCX_PingOp) }
#define MSRCXDeleteTasks() asm { __MSRCXOpNoArgs(RCX_DeleteTasksOp) }
#define MSRCXStopAllTasks() asm { __MSRCXOpNoArgs(RCX_StopAllTasksOp) }
#define MSRCXPBTurnOff() asm { __MSRCXOpNoArgs(RCX_PBTurnOffOp) }
#define MSRCXDeleteSubs() asm { __MSRCXOpNoArgs(RCX_DeleteSubsOp) }
#define MSRCXClearSound() asm { __MSRCXOpNoArgs(RCX_ClearSoundOp) }
#define MSRCXClearMsg() asm { __MSRCXOpNoArgs(RCX_ClearMsgOp) }
#define MSRCXMuteSound() asm { __MSRCXOpNoArgs(RCX_MuteSoundOp) }
#define MSRCXUnmuteSound() asm { __MSRCXOpNoArgs(RCX_UnmuteSoundOp) }
#define MSRCXClearAllEvents() asm { __MSRCXOpNoArgs(RCX_ClearAllEventsOp) }
#define MSRCXSetOutput(_outputs, _mode) asm { __MSRCXSetOutput(_outputs, _mode) }
#define MSRCXSetDirection(_outputs, _dir) asm { __MSRCXSetDirection(_outputs, _dir) }
#define MSRCXSetPower(_outputs, _pwrsrc, _pwrval) asm { __MSRCXSetPower(_outputs, _pwrsrc, _pwrval) }
#define MSRCXOn(_outputs) asm { __MSRCXSetOutput(_outputs, RCX_OUT_ON) }
#define MSRCXOff(_outputs) asm { __MSRCXSetOutput(_outputs, RCX_OUT_OFF) }
#define MSRCXFloat(_outputs) asm { __MSRCXSetOutput(_outputs, RCX_OUT_FLOAT) }
#define MSRCXToggle(_outputs) asm { __MSRCXSetDirection(_outputs, RCX_OUT_TOGGLE) }
#define MSRCXFwd(_outputs) asm { __MSRCXSetDirection(_outputs, RCX_OUT_FWD) }
#define MSRCXRev(_outputs) asm { __MSRCXSetDirection(_outputs, RCX_OUT_REV) }
#define MSRCXOnFwd(_outputs) asm { __MSRCXOnFwd(_outputs) }
#define MSRCXOnRev(_outputs) asm { __MSRCXOnRev(_outputs) }
#define MSRCXOnFor(_outputs, _ms) asm { __MSRCXOnFor(_outputs, _ms) }
#define MSRCXSetTxPower(_pwr) asm { __MSRCXSetTxPower(_pwr) }
#define MSRCXPlaySound(_snd) asm { __MSRCXPlaySound(_snd) }
#define MSRCXDeleteTask(_t) asm { __MSRCXDeleteTask(_t) }
#define MSRCXStartTask(_t) asm { __MSRCXStartTask(_t) }
#define MSRCXStopTask(_t) asm { __MSRCXStopTask(_t) }
#define MSRCXSelectProgram(_prog) asm { __MSRCXSelectProgram(_prog) }
#define MSRCXClearTimer(_timer) asm { __MSRCXClearTimer(_timer) }
#define MSRCXSetSleepTime(_t) asm { __MSRCXSetSleepTime(_t) }
#define MSRCXDeleteSub(_s) asm { __MSRCXDeleteSub(_s) }
#define MSRCXClearSensor(_port) asm { __MSRCXClearSensor(_port) }
#define MSRCXPlayToneVar(_varnum, _duration) asm { __MSRCXPlayToneVar(_varnum, _duration) }
#define MSRCXSetWatch(_hours, _minutes) asm { __MSRCXSetWatch(_hours, _minutes) }
#define MSRCXSetSensorType(_port, _type) asm { __MSRCXSetSensorType(_port, _type) }
#define MSRCXSetSensorMode(_port, _mode) asm { __MSRCXSetSensorMode(_port, _mode) }
#define MSRCXCreateDatalog(_size) asm { __MSRCXCreateDatalog(_size) }
#define MSRCXAddToDatalog(_src, _value) asm { __MSRCXAddToDatalog(_src, _value) }
#define MSRCXSendSerial(_first, _count) asm { __MSRCXSendSerial(_first, _count) }
#define MSRCXRemote(_cmd) asm { __MSRCXRemote(_cmd) }
#define MSRCXEvent(_src, _value) asm { __MSRCXEvent(_src, _value) }
#define MSRCXPlayTone(_freq, _duration) asm { __MSRCXPlayTone(_freq, _duration) }
#define MSRCXSelectDisplay(_src, _value) asm { __MSRCXSelectDisplay(_src, _value) }
#define MSRCXPollMemory(_memaddress) asm { __MSRCXPollMemory(_memaddress, __RETVAL__) }
#define MSRCXSetEvent(_evt, _src, _type) asm { __MSRCXSetEvent(_evt, _src, _type) }
#define MSRCXSetGlobalOutput(_outputs, _mode) asm { __MSRCXSetGlobalOutput(_outputs, _mode) }
#define MSRCXSetGlobalDirection(_outputs, _dir) asm { __MSRCXSetGlobalDirection(_outputs, _dir) }
#define MSRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) asm { __MSRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) }
#define MSRCXEnableOutput(_outputs) asm { __MSRCXSetGlobalOutput(_outputs, RCX_OUT_ON) }
#define MSRCXDisableOutput(_outputs) asm { __MSRCXSetGlobalOutput(_outputs, RCX_OUT_OFF) }
#define MSRCXInvertOutput(_outputs) asm { __MSRCXSetGlobalDirection(_outputs, RCX_OUT_REV) }
#define MSRCXObvertOutput(_outputs) asm { __MSRCXSetGlobalDirection(_outputs, RCX_OUT_FWD) }
#define MSRCXCalibrateEvent(_evt, _low, _hi, _hyst) asm { __MSRCXCalibrateEvent(_evt, _low, _hi, _hyst) }
#define MSRCXSetVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_SetVarOp, _varnum, _src, _value) }
#define MSRCXSumVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_SumVarOp, _varnum, _src, _value) }
#define MSRCXSubVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_SubVarOp, _varnum, _src, _value) }
#define MSRCXDivVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_DivVarOp, _varnum, _src, _value) }
#define MSRCXMulVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_MulVarOp, _varnum, _src, _value) }
#define MSRCXSgnVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_SgnVarOp, _varnum, _src, _value) }
#define MSRCXAbsVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_AbsVarOp, _varnum, _src, _value) }
#define MSRCXAndVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_AndVarOp, _varnum, _src, _value) }
#define MSRCXOrVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_OrVarOp, _varnum, _src, _value) }
#define MSRCXSet(_dstsrc, _dstval, _src, _value) asm { __MSRCXSet(_dstsrc, _dstval, _src, _value) }
#define MSRCXUnlock() asm { __MSRCXUnlock() }
#define MSRCXReset() asm { __MSRCXReset() }
#define MSRCXBoot() asm { __MSRCXBoot() }
#define MSRCXSetUserDisplay(_src, _value, _precision) asm { __MSRCXSetUserDisplay(_src, _value, _precision) }
#define MSRCXIncCounter(_counter) asm { __MSRCXIncCounter(_counter) }
#define MSRCXDecCounter(_counter) asm { __MSRCXDecCounter(_counter) }
#define MSRCXClearCounter(_counter) asm { __MSRCXClearCounter(_counter) }
#define MSRCXSetPriority(_p) asm { __MSRCXSetPriority(_p) }
#define MSRCXSetMessage(_msg) asm { __MSRCXSetMessage(_msg) }

#define MSScoutCalibrateSensor() asm { __MSRCXOpNoArgs(RCX_LSCalibrateOp) }
#define MSScoutMuteSound() asm { __MSScoutMuteSound() }
#define MSScoutUnmuteSound() asm { __MSScoutUnmuteSound() }
#define MSScoutSelectSounds(_grp) asm { __MSScoutSelectSounds(_grp) }
#define MSScoutSetLight(_x) asm { __MSScoutSetLight(_x) }
#define MSScoutSetCounterLimit(_ctr, _src, _value) asm { __MSScoutSetCounterLimit(_ctr, _src, _value) }
#define MSScoutSetTimerLimit(_tmr, _src, _value) asm { __MSScoutSetTimerLimit(_tmr, _src, _value) }
#define MSScoutSetSensorClickTime(_src, _value) asm { __MSScoutSetSensorClickTime(_src, _value) }
#define MSScoutSetSensorHysteresis(_src, _value) asm { __MSScoutSetSensorHysteresis(_src, _value) }
#define MSScoutSetSensorLowerLimit(_src, _value) asm { __MSScoutSetSensorLowerLimit(_src, _value) }
#define MSScoutSetSensorUpperLimit(_src, _value) asm { __MSScoutSetSensorUpperLimit(_src, _value) }
#define MSScoutSetEventFeedback(_src, _value) asm { __MSScoutSetEventFeedback(_src, _value) }
#define MSScoutSendVLL(_src, _value) asm { __MSScoutSendVLL(_src, _value) }
#define MSScoutSetScoutRules(_m, _t, _l, _tm, _fx) asm { __MSScoutSetScoutRules(_m, _t, _l, _tm, _fx) }
#define MSScoutSetScoutMode(_mode) asm { __MSScoutSetScoutMode(_mode) }

#endif

/** @} */ // end of MindSensorsAPI group

#endif // MINDSENSORS_H
