/** \file hitechnic.h
 * \brief The NXC HiTechnic API
 *
 * hitechnic.h contains the NXC HiTechnic API
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

#ifndef HITECHNIC_H
#define HITECHNIC_H

#include "hitechnic_constants.h"
#include "lowspeed.h"
#include "input.h"

#ifndef __DOXYGEN_DOCS
asm { asminclude "nbc_hitechnic.h" }
#endif

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// HiTechnic API ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @addtogroup HiTechnicAPI
 * @{
 */

/**
 * Set sensor as HiTechnic Gyro.
 * Configure the sensor on the specified port as a HiTechnic Gyro sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 */
inline void SetSensorHTGyro(const byte & port) {
  SetSensorType(port, SENSOR_TYPE_LIGHT_INACTIVE);
  SetSensorMode(port, SENSOR_MODE_RAW);
  ResetSensor(port);
}

/**
 * Set sensor as HiTechnic Magnet.
 * Configure the sensor on the specified port as a HiTechnic Magnet sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 */
inline void SetSensorHTMagnet(const byte & port) {
  SetSensorType(port, SENSOR_TYPE_LIGHT_INACTIVE);
  SetSensorMode(port, SENSOR_MODE_RAW);
  ResetSensor(port);
}

/**
 * Set sensor as HiTechnic EOPD.
 * Configure the sensor on the specified port as a HiTechnic EOPD sensor in either
 * standard range or long range mode. As with all third party sensors, consult
 * the documentation provided by the manufacturer for additional details
 * regarding how to use their device.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param bStandard Configure in standard range or long range mode,
 * default = standard range mode.
 */
inline void SetSensorHTEOPD(const byte & port, bool bStandard = true) {
  SetSensorType(port, bStandard ? SENSOR_TYPE_LIGHT_INACTIVE : SENSOR_TYPE_LIGHT_ACTIVE);
  SetSensorMode(port, SENSOR_MODE_RAW);
  ResetSensor(port);
}

/**
 * Set sensor as HiTechnic Force.
 * Configure the sensor on the specified port as a HiTechnic Force sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 */
inline void SetSensorHTForce(const byte & port) {
  SetSensorType(port, SENSOR_TYPE_LIGHT_INACTIVE);
  SetSensorMode(port, SENSOR_MODE_RAW);
  ResetSensor(port);
}

/**
 * Read HiTechnic Gyro sensor.
 * Read the HiTechnic Gyro sensor on the specified port. The offset value
 * should be calculated by averaging several readings with an offset of zero
 * while the sensor is perfectly still.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param offset The zero offset.
 * \return The Gyro sensor reading.
 */
inline int SensorHTGyro(const byte & port, int offset = 0) {
  asm {
    getin __RETVAL__, port, RawValueField
    sub __RETVAL__, __RETVAL__, 600
    sub __RETVAL__, __RETVAL__, offset
  }
}

/**
 * Read HiTechnic Magnet sensor.
 * Read the HiTechnic Magnet sensor on the specified port. The offset value
 * should be calculated by averaging several readings with an offset of zero
 * while the sensor is perfectly still.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param offset The zero offset.
 * \return The Magnet sensor reading.
 */
inline int SensorHTMagnet(const byte & port, int offset = 0) {
  asm {
    getin __RETVAL__, port, RawValueField
    sub __RETVAL__, __RETVAL__, 600
    sub __RETVAL__, __RETVAL__, offset
  }
}

/**
 * Read HiTechnic EOPD sensor.
 * Read the HiTechnic EOPD sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The EOPD sensor reading.
 */
inline int SensorHTEOPD(const byte & port) {
  asm {
    getin __RETVAL__, port, RawValueField
    sub __RETVAL__, 1023, __RETVAL__
  }
}

/**
 * Read HiTechnic Force sensor.
 * Read the HiTechnic Force sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The Force sensor reading.
 */
inline int SensorHTForce(const byte & port) {
  asm {
    getin __RETVAL__, port, RawValueField
    sub __RETVAL__, 1023, __RETVAL__
  }
}

#ifdef __DOXYGEN_DOCS

/**
 * Read HiTechnic color sensor color number.
 * Read the color number from the HiTechnic Color sensor on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The color number.
 */
inline int SensorHTColorNum(const byte & port);

/**
 * Read HiTechnic compass.
 * Read the compass heading value of the HiTechnic Compass sensor on the
 * specified port. The port must be configured as a Lowspeed port before
 * using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The compass heading.
 */
inline int SensorHTCompass(const byte & port);

/**
 * Read HiTechnic IRSeeker direction.
 * Read the direction value of the HiTechnic IR Seeker on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The IRSeeker direction.
 */
inline int SensorHTIRSeekerDir(const byte & port);

/**
 * Read HiTechnic IRSeeker2 register.
 * Read a register value from the HiTechnic IR Seeker2 on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param reg The register address. See \ref HTIRSeeker2Constants.
 * \return The IRSeeker2 register value.
 */
inline int SensorHTIRSeeker2Addr(const byte & port, const byte reg);

/**
 * Read HiTechnic IRSeeker2 DC direction.
 * Read the DC direction value from the HiTechnic IR Seeker2 on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The IRSeeker2 DC direction.
 */
inline int SensorHTIRSeeker2DCDir(const byte & port);

/**
 * Read HiTechnic IRSeeker2 AC direction.
 * Read the AC direction value from the HiTechnic IR Seeker2 on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The IRSeeker2 AC direction.
 */
inline int SensorHTIRSeeker2ACDir(const byte & port);

/**
 * Set HiTechnic Color2 mode.
 * Set the mode of the HiTechnic Color2 sensor on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param mode The Color2 mode. See \ref HTColor2Constants.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char SetHTColor2Mode(const byte & port, byte mode);

/**
 * Set HiTechnic IRSeeker2 mode.
 * Set the mode of the HiTechnic IRSeeker2 sensor on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param mode The IRSeeker2 mode. See \ref HTIRSeeker2Constants.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char SetHTIRSeeker2Mode(const byte & port, const byte mode);

/**
 * Read HiTechnic acceleration values.
 * Read X, Y, and Z axis acceleration values from the HiTechnic Accelerometer
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param x The output x-axis acceleration.
 * \param y The output y-axis acceleration.
 * \param z The output z-axis acceleration.
 * \return The function call result.
 */
inline bool ReadSensorHTAccel(const byte port, int & x, int & y, int & z);

/**
 * Read HiTechnic Color values.
 * Read color number, red, green, and blue values from the HiTechnic Color
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param ColorNum The output color number.
 * \param Red The red color value.
 * \param Green The green color value.
 * \param Blue The blue color value.
 * \return The function call result.
 */
inline bool ReadSensorHTColor(const byte port, byte & ColorNum, byte & Red, byte & Green, byte & Blue);

/**
 * Read HiTechnic IRSeeker values.
 * Read direction, and five signal strength values from the HiTechnic
 * IRSeeker sensor. Returns a boolean value indicating whether or not the
 * operation completed successfully. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param dir The direction.
 * \param s1 The signal strength from sensor 1.
 * \param s3 The signal strength from sensor 3.
 * \param s5 The signal strength from sensor 5.
 * \param s7 The signal strength from sensor 7.
 * \param s9 The signal strength from sensor 9.
 * \return The function call result.
 */
inline bool ReadSensorHTIRSeeker(const byte port, byte & dir, byte & s1, byte & s3, byte & s5, byte & s7, byte & s9);

/**
 * Read HiTechnic Color normalized values.
 * Read the color index and the normalized red, green, and blue values from
 * the HiTechnic Color sensor. Returns a boolean value indicating whether or
 * not the operation completed successfully. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param ColorIdx The output color index.
 * \param Red The normalized red color value.
 * \param Green The normalized green color value.
 * \param Blue The normalized blue color value.
 * \return The function call result.
 */
inline bool ReadSensorHTNormalizedColor(const byte port, byte & ColorIdx, byte & Red, byte & Green, byte & Blue);

/**
 * Read HiTechnic Color raw values.
 * Read the raw red, green, and blue values from the HiTechnic Color sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param Red The raw red color value.
 * \param Green The raw green color value.
 * \param Blue The raw blue color value.
 * \return The function call result.
 */
inline bool ReadSensorHTRawColor(const byte port, unsigned int & Red, unsigned int & Green, unsigned int & Blue);

/**
 * Read HiTechnic Color2 active values.
 * Read color number, red, green, and blue values from the HiTechnic Color2
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param ColorNum The output color number.
 * \param Red The red color value.
 * \param Green The green color value.
 * \param Blue The blue color value.
 * \param White The white color value.
 * \return The function call result.
 */
inline bool ReadSensorHTColor2Active(byte port, byte & ColorNum, byte & Red, byte & Green, byte & Blue, byte & White);

/**
 * Read HiTechnic Color2 normalized active values.
 * Read the color index and the normalized red, green, and blue values from
 * the HiTechnic Color2 sensor. Returns a boolean value indicating whether or
 * not the operation completed successfully. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param ColorIdx The output color index.
 * \param Red The normalized red color value.
 * \param Green The normalized green color value.
 * \param Blue The normalized blue color value.
 * \return The function call result.
 */
inline bool ReadSensorHTNormalizedColor2Active(const byte port, byte & ColorIdx, byte & Red, byte & Green, byte & Blue);

/**
 * Read HiTechnic Color2 raw values.
 * Read the raw red, green, and blue values from the HiTechnic Color2 sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param Red The raw red color value.
 * \param Green The raw green color value.
 * \param Blue The raw blue color value.
 * \param White The raw white color value.
 * \return The function call result.
 */
inline bool ReadSensorHTRawColor2(const byte port, unsigned int & Red, unsigned int & Green, unsigned int & Blue, unsigned int & White);

/**
 * Read HiTechnic IRReceiver Power Function bytes.
 * Read Power Function bytes from the HiTechnic IRReceiver sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param pfdata Eight bytes of power function remote IR data.
 * \return The function call result.
 */
inline bool ReadSensorHTIRReceiver(const byte port, char & pfdata[]);

/**
 * Read HiTechnic IRReceiver Power Function value.
 * Read a Power Function byte from the HiTechnic IRReceiver sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param offset The power function data offset. See \ref HTIRReceiverConstants.
 * \param pfchar A single byte of power function remote IR data.
 * \return The function call result.
 */
inline bool ReadSensorHTIRReceiverEx(const byte port, const byte offset, char & pfchar);

/**
 * Read HiTechnic IRSeeker2 AC values.
 * Read direction, and five signal strength values from the HiTechnic
 * IRSeeker2 sensor in AC mode. Returns a boolean value indicating whether or
 * not the operation completed successfully. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param dir The direction.
 * \param s1 The signal strength from sensor 1.
 * \param s3 The signal strength from sensor 3.
 * \param s5 The signal strength from sensor 5.
 * \param s7 The signal strength from sensor 7.
 * \param s9 The signal strength from sensor 9.
 * \return The function call result.
 */
inline bool ReadSensorHTIRSeeker2AC(const byte port, byte & dir, byte & s1, byte & s3, byte & s5, byte & s7, byte & s9);

/**
 * Read HiTechnic IRSeeker2 DC values.
 * Read direction, five signal strength, and average strength values from the
 * HiTechnic IRSeeker2 sensor. Returns a boolean value indicating whether or
 * not the operation completed successfully. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param dir The direction.
 * \param s1 The signal strength from sensor 1.
 * \param s3 The signal strength from sensor 3.
 * \param s5 The signal strength from sensor 5.
 * \param s7 The signal strength from sensor 7.
 * \param s9 The signal strength from sensor 9.
 * \param avg The average signal strength.
 * \return The function call result.
 */
inline bool ReadSensorHTIRSeeker2DC(const byte port, byte & dir, byte & s1, byte & s3, byte & s5, byte & s7, byte & s9, byte & avg);

/**
 * Reset HiTechnic Angle sensor.
 * Reset the HiTechnic Angle sensor on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param mode The Angle reset mode. See \ref HTAngleConstants.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char ResetSensorHTAngle(const byte port, const byte mode);

/**
 * Read HiTechnic Angle sensor values.
 * Read values from the HiTechnic Angle sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param Angle Current angle in degrees (0-359).
 * \param AccAngle Accumulated angle in degrees (-2147483648 to 2147483647).
 * \param RPM rotations per minute (-1000 to 1000).
 * \return The function call result.
 */
inline bool ReadSensorHTAngle(const byte port, int & Angle, long & AccAngle, int & RPM);

/**
 * Reset HiTechnic Barometric sensor calibration.
 * Reset the HiTechnic Barometric sensor to its factory calibration.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline bool ResetHTBarometricCalibration(byte port);

/**
 * Set HiTechnic Barometric sensor calibration.
 * Set the HiTechnic Barometric sensor pressure calibration value.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param cal The new pressure calibration value.
 * \return The function call result.
 */
inline bool SetHTBarometricCalibration(byte port, unsigned int cal);

/**
 * Read HiTechnic Barometric sensor values.
 * Read values from the HiTechnic Barometric sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param temp Current temperature in 1/10ths of degrees Celcius.
 * \param press Current barometric pressure in 1/1000 inches of mercury.
 * \return The function call result.
 */
inline bool ReadSensorHTBarometric(const byte port, int & temp, unsigned int & press);

/**
 * Read HiTechnic Prototype board analog input value.
 * Read an analog input value from the HiTechnic prototype board.
 * The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param input The analog input. See \ref HTProtoAnalogInputConstants.
 * \return The analog input value.
 */
inline int SensorHTProtoAnalog(const byte port, const byte input);

/**
 * Read all HiTechnic Prototype board analog input values.
 * Read all 5 analog input values from the HiTechnic prototype board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param a0 The A0 analog input value.
 * \param a1 The A1 analog input value.
 * \param a2 The A2 analog input value.
 * \param a3 The A3 analog input value.
 * \param a4 The A4 analog input value.
 * \return The function call result.
 */
inline bool ReadSensorHTProtoAllAnalog(const byte port, int & a0, int & a1, int & a2, int & a3, int & a4);

/**
 * Control HiTechnic Prototype board digital pin direction.
 * Control the direction of the six digital pins on the HiTechnic prototype board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param value The digital pin control value. See \ref DigitalPinConstants.
 * OR into this value the pins that you want to be output pins.  The pins not
 * included in the value will be input pins.
 * \return The function call result.
 */
inline bool SetSensorHTProtoDigitalControl(const byte port, byte value);

/**
 * Read HiTechnic Prototype board digital control values.
 * Read digital control values from the HiTechnic prototype board.
 * The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The digital control values. See \ref DigitalPinConstants.
 */
inline byte SensorHTProtoDigitalControl(const byte port);

/**
 * Set HiTechnic Prototype board digital output values.
 * Set the digital pin output values on the HiTechnic prototype board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param value The digital pin output values. See \ref DigitalPinConstants.
 * \return The function call result.
 */
inline bool SetSensorHTProtoDigital(const byte port, byte value);

/**
 * Read HiTechnic Prototype board digital input values.
 * Read digital input values from the HiTechnic prototype board.
 * The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The digital input values. See \ref DigitalPinConstants.
 */
inline byte SensorHTProtoDigital(const byte port);

/**
 * Read HiTechnic SuperPro board analog input value.
 * Read an analog input value from the HiTechnic SuperPro board.
 * The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param input The analog input. See \ref HTSProAnalogInputConstants.
 * \return The analog input value.
 */
inline int SensorHTSuperProAnalog(const byte port, const byte input);

/**
 * Read all HiTechnic SuperPro board analog input values.
 * Read all 4 analog input values from the HiTechnic SuperPro board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param a0 The A0 analog input value.
 * \param a1 The A1 analog input value.
 * \param a2 The A2 analog input value.
 * \param a3 The A3 analog input value.
 * \return The function call result.
 */
inline bool ReadSensorHTSuperProAllAnalog(const byte port, int & a0, int & a1, int & a2, int & a3);

/**
 * Control HiTechnic SuperPro board digital pin direction.
 * Control the direction of the eight digital pins on the HiTechnic SuperPro board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param value The digital pin control value. See \ref DigitalPinConstants.
 * OR into this value the pins that you want to be output pins.  The pins not
 * included in the value will be input pins.
 * \return The function call result.
 */
inline bool SetSensorHTSuperProDigitalControl(const byte port, byte value);

/**
 * Read HiTechnic SuperPro board digital control values.
 * Read digital control values from the HiTechnic SuperPro board.
 * The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The digital input values. See \ref DigitalPinConstants.
 */
inline byte SensorHTSuperProDigitalControl(const byte port);

/**
 * Set HiTechnic SuperPro board digital output values.
 * Set the digital pin output values on the HiTechnic SuperPro board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param value The digital pin output values. See \ref DigitalPinConstants.
 * \return The function call result.
 */
inline bool SetSensorHTSuperProDigital(const byte port, byte value);

/**
 * Read HiTechnic SuperPro board digital input values.
 * Read digital input values from the HiTechnic SuperPro board.
 * The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The digital input values. See \ref DigitalPinConstants.
 */
inline byte SensorHTSuperProDigital(const byte port);

/**
 * Set HiTechnic SuperPro LED value.
 * Set the HiTechnic SuperPro LED value.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param value The LED value. See \ref LEDCtrlConstants.
 * \return The function call result.
 */
inline bool SetSensorHTSuperProLED(const byte port, byte value);

/**
 * Read HiTechnic SuperPro LED value.
 * Read the HiTechnic SuperPro LED value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The LED value. See \ref LEDCtrlConstants.
 */
inline byte SensorHTSuperProLED(const byte port);

/**
 * Set HiTechnic SuperPro strobe value.
 * Set the HiTechnic SuperPro strobe value.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param value The strobe value. See \ref StrobeCtrlConstants.
 * \return The function call result.
 */
inline bool SetSensorHTSuperProStrobe(const byte port, byte value);

/**
 * Read HiTechnic SuperPro strobe value.
 * Read the HiTechnic SuperPro strobe value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The strobe value. See \ref StrobeCtrlConstants.
 */
inline byte SensorHTSuperProStrobe(const byte port);

/**
 * Set HiTechnic SuperPro program control value.
 * Set the HiTechnic SuperPro program control value.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param value The program control value.
 * \return The function call result.
 */
inline bool SetSensorHTSuperProProgramControl(const byte port, byte value);

/**
 * Read HiTechnic SuperPro program control value.
 * Read the HiTechnic SuperPro program control value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The program control value.
 */
inline byte SensorHTSuperProProgramControl(const byte port);

/**
 * Set HiTechnic SuperPro board analog output parameters.
 * Set the analog output parameters on the HiTechnic SuperPro board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param dac The analog output index. See \ref HTSProDACIndexConstants.
 * \param mode The analog output mode. See \ref DacModeConstants.
 * \param freq The analog output frequency. Between 1 and 8191.
 * \param volt The analog output voltage level. A 10 bit value (0..1023).
 * \return The function call result.
 */
inline bool SetSensorHTSuperProAnalogOut(const byte port, const byte dac, byte mode, int freq, int volt);

/**
 * Read HiTechnic SuperPro board analog output parameters.
 * Read the analog output parameters on the HiTechnic SuperPro board.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param dac The analog output index. See \ref HTSProDACIndexConstants.
 * \param mode The analog output mode. See \ref DacModeConstants.
 * \param freq The analog output frequency. Between 1 and 8191.
 * \param volt The analog output voltage level. A 10 bit value (0..1023).
 * \return The function call result.
 */
inline bool ReadSensorHTSuperProAnalogOut(const byte port, const byte dac, byte & mode, int & freq, int & volt);

/**
 * Set HiTechnic PIR deadband value.
 * Set the HiTechnic PIR deadband value.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function. The deadband value must be between 0 and 47.  It defines the
 * half width of the deadband. The sensor has a default deadband value of 12.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param value The PIR deadband value. Valid values are between 0 and 47.
 * \return The function call result.
 */
inline bool SetSensorHTPIRDeadband(const byte port, byte value);

/**
 * Read HiTechnic PIR measurement value.
 * Read the HiTechnic PIR measurement value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The passive infrared reading.  A signed byte (-128..127).
 */
inline char SensorHTPIR(const byte port);

/**
 * Read HiTechnic PIR deadband value.
 * Read the HiTechnic PIR deadband value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The PIR deadband value. Values are between 0 and 47.
 */
inline byte SensorHTPIRDeadband(const byte port);

/**
 * Read HiTechnic touch multiplexer.
 * Read touch sensor values from the HiTechnic touch multiplexer device.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param t1 The value of touch sensor 1.
 * \param t2 The value of touch sensor 2.
 * \param t3 The value of touch sensor 3.
 * \param t4 The value of touch sensor 4.
 */
inline void ReadSensorHTTouchMultiplexer(const byte port, byte & t1, byte & t2, byte & t3, byte & t4);


#else

#define SensorHTCompass(_port) asm { __ReadSensorHTCompass(_port, __RETVAL__) }
#define ReadSensorHTAccel(_port, _x, _y, _z) asm { __ReadSensorHTAccel(_port, _x, _y, _z, __RETVAL__) }
#define ReadSensorHTColor(_port, _ColorNum, _Red, _Green, _Blue) asm { __ReadSensorHTColor(_port, _ColorNum, _Red, _Green, _Blue, __RETVAL__) }
#define ReadSensorHTRawColor(_port, _Red, _Green, _Blue) asm { __ReadSensorHTRawColor(_port, _Red, _Green, _Blue, __RETVAL__) }
#define ReadSensorHTNormalizedColor(_port, _ColorIdx, _Red, _Green, _Blue) asm { __ReadSensorHTNormalizedColor(_port, _ColorIdx, _Red, _Green, _Blue, __RETVAL__) }
#define ReadSensorHTIRSeeker(_port, _dir, _s1, _s3, _s5, _s7, _s9) asm { __ReadSensorHTIRSeeker(_port, _dir, _s1, _s3, _s5, _s7, _s9, __RETVAL__) }
#define SensorHTIRSeekerDir(_port) asm { __ReadSensorHTIRSeekerDir(_port, __RETVAL__) }
#define SensorHTColorNum(_port) asm { __ReadSensorHTColorNum(_port, __RETVAL__) }
#define SensorHTIRSeeker2Addr(_port, _reg) asm { __ReadSensorHTIRSeeker2Addr(_port, _reg, __RETVAL__) }
#define SensorHTIRSeeker2DCDir(_port) asm { __ReadSensorHTIRSeeker2Addr(_port, HTIR2_REG_DCDIR, __RETVAL__) }
#define SensorHTIRSeeker2ACDir(_port) asm { __ReadSensorHTIRSeeker2Addr(_port, HTIR2_REG_ACDIR, __RETVAL__) }
#define ReadSensorHTIRSeeker2DC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _avg) asm { __ReadSensorHTIRSeeker2DC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _avg, __RETVAL__) }
#define ReadSensorHTIRSeeker2AC(_port, _dir, _s1, _s3, _s5, _s7, _s9) asm { __ReadSensorHTIRSeeker2AC(_port, _dir, _s1, _s3, _s5, _s7, _s9, __RETVAL__) }
#define SetHTIRSeeker2Mode(_port, _mode) asm { __SetHTIRSeeker2Mode(_port, _mode, __RETVAL__) }

#define SetHTColor2Mode(_port, _mode) asm { __SetHTColor2Mode(_port, _mode, __RETVAL__) }
#define ReadSensorHTColor2Active(_port, _ColorNum, _Red, _Green, _Blue, _White) asm { __ReadSensorHTColor2Active(_port, _ColorNum, _Red, _Green, _Blue, _White, __RETVAL__) }
#define ReadSensorHTNormalizedColor2Active(_port, _ColorIdx, _Red, _Green, _Blue) asm { __ReadSensorHTNormalizedColor2Active(_port, _ColorIdx, _Red, _Green, _Blue, __RETVAL__) }
#define ReadSensorHTRawColor2(_port, _Red, _Green, _Blue, _White) asm { __ReadSensorHTRawColor2(_port, _Red, _Green, _Blue, _White, __RETVAL__) }
#define ReadSensorHTIRReceiver(_port, _pfdata) asm { __ReadSensorHTIRReceiver(_port, _pfdata, __RETVAL__) }
#define ReadSensorHTIRReceiverEx(_port, _reg, _pfchar) asm { __ReadSensorHTIRReceiverEx(_port, _reg, _pfchar, __RETVAL__) }
#define ResetSensorHTAngle(_port, _mode) asm { __ResetSensorHTAngle(_port, _mode, __RETVAL__) }
#define ReadSensorHTAngle(_port, _Angle, _AccAngle, _RPM) asm { __ReadSensorHTAngle(_port, _Angle, _AccAngle, _RPM, __RETVAL__) }
#define ReadSensorHTBarometric(_port, _temp, _press) asm { __ReadSensorHTBarometric(_port, _temp, _press, __RETVAL__) }
#define ResetHTBarometricCalibration(_port) asm { __ResetHTBarometricCalibration(_port, __RETVAL__) }
#define SetHTBarometricCalibration(_port, _cal) asm { __SetHTBarometricCalibration(_port, _cal, __RETVAL__) }

#define SensorHTProtoAnalog(_port, _input) asm { __ReadSensorHTProtoAnalog(_port, HT_ADDR_PROTOBOARD, _input, __RETVAL__, __TMPBYTE__) }
#define ReadSensorHTProtoAllAnalog(_port, _a0, _a1, _a2, _a3, _a4) asm { __ReadSensorHTProtoAllAnalog(_port, _a0, _a1, _a2, _a3, _a4, __RETVAL__) }
#define SetSensorHTProtoDigitalControl(_port, _value) asm { __SetSensorHTProtoDigitalControl(_port, HT_ADDR_PROTOBOARD, _value, __RETVAL__) }
#define SensorHTProtoDigitalControl(_port) asm { __I2CReadValue(_port, HT_ADDR_PROTOBOARD, HTPROTO_REG_DCTRL, 1, __RETVAL__, __TMPBYTE__) }
#define SetSensorHTProtoDigital(_port, _value) asm { __SetSensorHTProtoDigital(_port, HT_ADDR_PROTOBOARD, _value, __RETVAL__) }
#define SensorHTProtoDigital(_port) asm { __ReadSensorHTProtoDigital(_port, HT_ADDR_PROTOBOARD, __RETVAL__, __TMPBYTE__) }

#define SensorHTSuperProAnalog(_port, _input) asm { __ReadSensorHTProtoAnalog(_port, HT_ADDR_SUPERPRO, _input, __RETVAL__, __TMPBYTE__) }
#define ReadSensorHTSuperProAllAnalog(_port, _a0, _a1, _a2, _a3) asm { __ReadSensorHTSuperProAllAnalog(_port, _a0, _a1, _a2, _a3, __RETVAL__) }
#define SetSensorHTSuperProDigitalControl(_port, _value) asm { __SetSensorHTProtoDigitalControl(_port, HT_ADDR_SUPERPRO, _value, __RETVAL__) }
#define SensorHTSuperProDigitalControl(_port) asm { __I2CReadValue(_port, HT_ADDR_SUPERPRO, HTSPRO_REG_DCTRL, 1, __RETVAL__, __TMPBYTE__) }
#define SetSensorHTSuperProDigital(_port, _value) asm { __SetSensorHTProtoDigital(_port, HT_ADDR_SUPERPRO, _value, __RETVAL__) }
#define SensorHTSuperProDigital(_port) asm { __I2CReadValue(_port, HT_ADDR_SUPERPRO, HTSPRO_REG_DIN, 1, __RETVAL__, __TMPBYTE__) }
#define SetSensorHTSuperProLED(_port, _value) asm { __SetSensorHTSuperProLED(_port, _value, __RETVAL__) }
#define SensorHTSuperProLED(_port) asm { __I2CReadValue(_port, HT_ADDR_SUPERPRO, HTSPRO_REG_LED, 1, __RETVAL__, __TMPBYTE__) }
#define SetSensorHTSuperProStrobe(_port, _value) asm { __SetSensorHTSuperProStrobe(_port, _value, __RETVAL__) }
#define SensorHTSuperProStrobe(_port) asm { __I2CReadValue(_port, HT_ADDR_SUPERPRO, HTSPRO_REG_STROBE, 1, __RETVAL__, __TMPBYTE__) }
#define SetSensorHTSuperProProgramControl(_port, _value) asm { __SetSensorHTSuperProProgramControl(_port, _value, __RETVAL__) }
#define SensorHTSuperProProgramControl(_port) asm { __I2CReadValue(_port, HT_ADDR_SUPERPRO, HTSPRO_REG_CTRL, 1, __RETVAL__, __TMPBYTE__) }
#define SetSensorHTSuperProAnalogOut(_port, _dac, _mode, _freq, _volt) asm { __SetSensorHTSuperProAnalogOut(_port, _dac, _mode, _freq, _volt, __RETVAL__) }
#define ReadSensorHTSuperProAnalogOut(_port, _dac, _mode, _freq, _volt) asm { __ReadSensorHTSuperProAnalogOut(_port, _dac, _mode, _freq, _volt, __RETVAL__) }

#define SensorHTPIR(_port) asm { __ReadSensorHTPIR(_port, __RETVAL__, __TMPBYTE__) }
#define SetSensorHTPIRDeadband(_port, _value) asm { __SetSensorHTPIRDeadband(_port, _value, __RETVAL__) }
#define SensorHTPIRDeadband(_port) asm { __I2CReadValue(_port, HT_ADDR_PIR, HTPIR_REG_DEADBAND, 1, __RETVAL__, __TMPBYTE__) }

#define ReadSensorHTTouchMultiplexer(_p, _t1, _t2, _t3, _t4) asm { __ReadSensorHTTouchMultiplexer(_p, _t1, _t2, _t3, _t4) }

#endif

/** @} */ // end of HiTechnicAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // HITECHNIC_H
