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
 * Portions created by John Hansen are Copyright (C) 2009-2010 John Hansen.
 * All Rights Reserved.
 *
 * ----------------------------------------------------------------------------
 *
 * \author John Hansen (bricxcc_at_comcast.net)
 * \date 2011-03-17
 * \version 1
 */

#ifndef HITECHNIC_H
#define HITECHNIC_H

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// HiTechnic API ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup HiTechnicAPI
 * @{
 */

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
 * Set sensor as HiTechnic EOPD.
 * Configure the sensor on the specified port as a HiTechnic EOPD sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param bStandard Configure in standard or long-range mode.
 */
inline void SetSensorHTEOPD(const byte & port, bool bStandard) {
  SetSensorType(port, bStandard ? SENSOR_TYPE_LIGHT_INACTIVE : SENSOR_TYPE_LIGHT_ACTIVE);
  SetSensorMode(port, SENSOR_MODE_RAW);
  ResetSensor(port);
}

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
 * \param port The sensor port. See \ref NBCInputPortConstants.
 * \param Angle Current angle in degrees (0-359).
 * \param AccAngle Accumulated angle in degrees (-2147483648 to 2147483647).
 * \param RPM rotations per minute (-1000 to 1000).
 * \return The function call result.
 */
inline bool ReadSensorHTAngle(const byte port, int & Angle, long & AccAngle, int & RPM);

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

/**
 * HTIRTrain function.
 * Control an IR Train receiver set to the specified channel using the
 * HiTechnic iRLink device. Valid func values are \ref TRAIN_FUNC_STOP,
 * \ref TRAIN_FUNC_INCR_SPEED, \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT.
 * Valid channel values are \ref TRAIN_CHANNEL_1 through \ref TRAIN_CHANNEL_3 and
 * \ref TRAIN_CHANNEL_ALL. The port must be configured as a Lowspeed port before
 * using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param channel The IR Train channel.  See \ref IRTrainChannels.
 * \param func The IR Train function. See \ref IRTrainFuncs
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char HTIRTrain(const byte port, const byte channel, const byte func);

/**
 * HTPFComboDirect function.
 * Execute a pair of Power Function motor commands on the specified channel
 * using the HiTechnic iRLink device. Commands for outa and outb are
 * \ref PF_CMD_STOP, \ref PF_CMD_REV, \ref PF_CMD_FWD, and \ref PF_CMD_BRAKE. Valid channels are
 * \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param outa The Power Function command for output A. See \ref PFCmdConstants.
 * \param outb The Power Function command for output B. See \ref PFCmdConstants.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char HTPFComboDirect(const byte port, const byte channel, const byte outa, const byte outb);

/**
 * HTPFComboPWM function.
 * Control the speed of both outputs on a Power Function receiver set to the
 * specified channel using the HiTechnic iRLink device. Valid output values
 * are \ref PF_PWM_FLOAT, \ref PF_PWM_FWD1, \ref PF_PWM_FWD2, \ref PF_PWM_FWD3, \ref PF_PWM_FWD4,
 * \ref PF_PWM_FWD5, \ref PF_PWM_FWD6, \ref PF_PWM_FWD7, \ref PF_PWM_BRAKE, \ref PF_PWM_REV7,
 * \ref PF_PWM_REV6, \ref PF_PWM_REV5, \ref PF_PWM_REV4, \ref PF_PWM_REV3, \ref PF_PWM_REV2, and
 * \ref PF_PWM_REV1. Valid channels are \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The
 * port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param outa The Power Function PWM command for output A. See \ref PFPWMOptions.
 * \param outb The Power Function PWM command for output B. See \ref PFPWMOptions.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char HTPFComboPWM(const byte port, const byte channel, const byte outa, const byte outb);

/**
 * HTPFRawOutput function.
 * Control a Power Function receiver set to the specified channel using the
 * HiTechnic iRLink device. Build the raw data stream using the 3 nibbles
 * (4 bit values). The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param nibble0 The first raw data nibble.
 * \param nibble1 The second raw data nibble.
 * \param nibble2 The third raw data nibble.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char HTPFRawOutput(const byte port, const byte nibble0, const byte nibble1, const byte nibble2);

/**
 * HTPFRepeat function.
 * Repeat sending the last Power Function command using the HiTechnic
 * IRLink device. Specify the number of times to repeat the command and the
 * number of milliseconds of delay between each repetition. The port must be
 * configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param count The number of times to repeat the command.
 * \param delay The number of milliseconds to delay between each repetition.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char HTPFRepeat(const byte port, const byte count, const unsigned int delay);

/**
 * HTPFSingleOutputCST function.
 * Control a single output on a Power Function receiver set to the specified
 * channel using the HiTechnic iRLink device. Select the desired output
 * using \ref PF_OUT_A or \ref PF_OUT_B. Valid functions are \ref PF_CST_CLEAR1_CLEAR2,
 * \ref PF_CST_SET1_CLEAR2, \ref PF_CST_CLEAR1_SET2, \ref PF_CST_SET1_SET2,
 * \ref PF_CST_INCREMENT_PWM, \ref PF_CST_DECREMENT_PWM, \ref PF_CST_FULL_FWD,
 * \ref PF_CST_FULL_REV, and \ref PF_CST_TOGGLE_DIR. Valid channels are
 * \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param out The Power Function output. See \ref PFOutputs.
 * \param func The Power Function CST function. See \ref PFCSTOptions.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char HTPFSingleOutputCST(const byte port, const byte channel, const byte out, const byte func);

/**
 * HTPFSingleOutputPWM function.
 * Control the speed of a single output on a Power Function receiver set to
 * the specified channel using the HiTechnic iRLink device. Select the
 * desired output using \ref PF_OUT_A or \ref PF_OUT_B. Valid functions are
 * \ref PF_PWM_FLOAT, \ref PF_PWM_FWD1, \ref PF_PWM_FWD2, \ref PF_PWM_FWD3, \ref PF_PWM_FWD4,
 * \ref PF_PWM_FWD5, \ref PF_PWM_FWD6, \ref PF_PWM_FWD7, \ref PF_PWM_BRAKE, \ref PF_PWM_REV7,
 * \ref PF_PWM_REV6, \ref PF_PWM_REV5, \ref PF_PWM_REV4, \ref PF_PWM_REV3, \ref PF_PWM_REV2, and
 * \ref PF_PWM_REV1. Valid channels are \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The
 * port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param out The Power Function output. See \ref PFOutputs.
 * \param func The Power Function PWM function. See \ref PFPWMOptions.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char HTPFSingleOutputPWM(const byte port, const byte channel, const byte out, const byte func);

/**
 * HTPFSinglePin function.
 * Control a single pin on a Power Function receiver set to the specified
 * channel using the HiTechnic iRLink device. Select the desired output
 * using \ref PF_OUT_A or \ref PF_OUT_B.  Select the desired pin using \ref PF_PIN_C1 or
 * \ref PF_PIN_C2. Valid functions are \ref PF_FUNC_NOCHANGE, \ref PF_FUNC_CLEAR,
 * \ref PF_FUNC_SET, and \ref PF_FUNC_TOGGLE. Valid channels are \ref PF_CHANNEL_1 through
 * \ref PF_CHANNEL_4. Specify whether the mode by passing true (continuous) or
 * false (timeout) as the final parameter. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param out The Power Function output. See \ref PFOutputs.
 * \param pin The Power Function pin. See \ref PFPinConstants.
 * \param func The Power Function single pin function. See \ref PFPinFuncs.
 * \param cont Control whether the mode is continuous or timeout.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char HTPFSinglePin(const byte port, const byte channel, const byte out, const byte pin, const byte func, bool cont);

/**
 * HTPFTrain function.
 * Control both outputs on a Power Function receiver set to the specified
 * channel using the HiTechnic iRLink device as if it were an IR Train
 * receiver. Valid function values are \ref TRAIN_FUNC_STOP, \ref TRAIN_FUNC_INCR_SPEED,
 * \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT. Valid channels are
 * \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param func The Power Function train function. See \ref IRTrainFuncs.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char HTPFTrain(const byte port, const byte channel, const byte func);

/**
 * HTRCXSetIRLinkPort function.
 * Set the global port in advance of using the HTRCX* and HTScout* API
 * functions for sending RCX and Scout messages over the HiTechnic iRLink
 * device. The port must be configured as a Lowspeed port before using any of
 * the HiTechnic RCX and Scout iRLink functions.
 *
 * \param port The sensor port. See \ref InPorts.
 */
inline void HTRCXSetIRLinkPort(const byte port);

/**
 * HTRCXBatteryLevel function.
 * Send the BatteryLevel command to an RCX to read the current battery level.
 *
 * \return The RCX battery level.
 */
inline int HTRCXBatteryLevel(void);

/**
 * HTRCXPoll function
 * Send the Poll command to an RCX to read a signed 2-byte value at the
 * specified source and value combination.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 * \return The value read from the specified port and value.
 */
inline int HTRCXPoll(const byte src, const byte value);

/**
 * HTRCXPollMemory function.
 * Send the PollMemory command to an RCX.
 *
 * \param address The RCX memory address.
 * \return The value read from the specified address.
 */
inline int HTRCXPollMemory(const unsigned int address);

/**
 * HTRCXAddToDatalog function.
 * Send the AddToDatalog command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void HTRCXAddToDatalog(const byte src, const unsigned int value);

/**
 * HTRCXClearAllEvents function.
 * Send the ClearAllEvents command to an RCX.
 */
inline void HTRCXClearAllEvents(void);

/**
 * HTRCXClearCounter function.
 * Send the ClearCounter command to an RCX.
 *
 * \param counter The counter to clear.
 */
inline void HTRCXClearCounter(const byte counter);

/**
 * HTRCXClearMsg function.
 * Send the ClearMsg command to an RCX.
 */
inline void HTRCXClearMsg(void);

/**
 * HTRCXClearSensor function.
 * Send the ClearSensor command to an RCX.
 *
 * \param port The RCX port number.
 */
inline void HTRCXClearSensor(const byte port);

/**
 * HTRCXClearSound function.
 * Send the ClearSound command to an RCX.
 */
inline void HTRCXClearSound(void);

/**
 * HTRCXClearTimer function.
 * Send the ClearTimer command to an RCX.
 *
 * \param timer The timer to clear.
 */
inline void HTRCXClearTimer(const byte timer);

/**
 * HTRCXCreateDatalog function.
 * Send the CreateDatalog command to an RCX.
 *
 * \param size The new datalog size.
 */
inline void HTRCXCreateDatalog(const unsigned int size);

/**
 * HTRCXDecCounter function.
 * Send the DecCounter command to an RCX.
 *
 * \param counter The counter to decrement.
 */
inline void HTRCXDecCounter(const byte counter);

/**
 * HTRCXDeleteSub function.
 * Send the DeleteSub command to an RCX.
 *
 * \param s The subroutine number to delete.
 */
inline void HTRCXDeleteSub(const byte s);

/**
 * HTRCXDeleteSubs function.
 * Send the DeleteSubs command to an RCX.
 */
inline void HTRCXDeleteSubs(void);

/**
 * HTRCXDeleteTask function.
 * Send the DeleteTask command to an RCX.
 *
 * \param t The task number to delete.
 */
inline void HTRCXDeleteTask(const byte t);

/**
 * HTRCXDeleteTasks function.
 * Send the DeleteTasks command to an RCX.
 */
inline void HTRCXDeleteTasks(void);

/**
 * HTRCXDisableOutput function.
 * Send the DisableOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to disable. See \ref RCXOutputConstants.
 */
inline void HTRCXDisableOutput(const byte outputs);

/**
 * HTRCXEnableOutput function.
 * Send the EnableOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to enable. See \ref RCXOutputConstants.
 */
inline void HTRCXEnableOutput(const byte outputs);

/**
 * HTRCXEvent function.
 * Send the Event command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void HTRCXEvent(const byte src, const unsigned int value);

/**
 * HTRCXFloat function.
 * Send commands to an RCX to float the specified outputs.
 *
 * \param outputs The RCX output(s) to float. See \ref RCXOutputConstants.
 */
inline void HTRCXFloat(const byte outputs);

/**
 * HTRCXFwd function.
 * Send commands to an RCX to set the specified outputs to the forward direction.
 *
 * \param outputs The RCX output(s) to set forward. See \ref RCXOutputConstants.
 */
inline void HTRCXFwd(const byte outputs);

/**
 * HTRCXIncCounter function.
 * Send the IncCounter command to an RCX.
 *
 * \param counter The counter to increment.
 */
inline void HTRCXIncCounter(const byte counter);

/**
 * HTRCXInvertOutput function.
 * Send the InvertOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to invert. See \ref RCXOutputConstants.
 */
inline void HTRCXInvertOutput(const byte outputs);

/**
 * HTRCXMuteSound function.
 * Send the MuteSound command to an RCX.
 */
inline void HTRCXMuteSound(void);

/**
 * HTRCXObvertOutput function.
 * Send the ObvertOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to obvert. See \ref RCXOutputConstants.
 */
inline void HTRCXObvertOutput(const byte outputs);

/**
 * HTRCXOff function.
 * Send commands to an RCX to turn off the specified outputs.
 *
 * \param outputs The RCX output(s) to turn off. See \ref RCXOutputConstants.
 */
inline void HTRCXOff(const byte outputs);

/**
 * HTRCXOn function.
 * Send commands to an RCX to turn on the specified outputs.
 *
 * \param outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 */
inline void HTRCXOn(const byte outputs);

/**
 * HTRCXOnFor function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction for the specified duration.
 *
 * \param outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 * \param ms The number of milliseconds to leave the outputs on
 */
inline void HTRCXOnFor(const byte outputs, const unsigned int ms);

/**
 * HTRCXOnFwd function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction.
 *
 * \param outputs The RCX output(s) to turn on in the forward direction. See \ref RCXOutputConstants.
 */
inline void HTRCXOnFwd(const byte outputs);

/**
 * HTRCXOnRev function.
 * Send commands to an RCX to turn on the specified outputs in the reverse direction.
 *
 * \param outputs The RCX output(s) to turn on in the reverse direction. See \ref RCXOutputConstants.
 */
inline void HTRCXOnRev(const byte outputs);

/**
 * HTRCXPBTurnOff function.
 * Send the PBTurnOff command to an RCX.
 */
inline void HTRCXPBTurnOff(void);

/**
 * HTRCXPing function.
 * Send the Ping command to an RCX.
 */
inline void HTRCXPing(void);

/**
 * HTRCXPlaySound function.
 * Send the PlaySound command to an RCX.
 *
 * \param snd The sound number to play.
 */
inline void HTRCXPlaySound(const byte snd);

/**
 * HTRCXPlayTone function.
 * Send the PlayTone command to an RCX.
 *
 * \param freq The frequency of the tone to play.
 * \param duration The duration of the tone to play.
 */
inline void HTRCXPlayTone(const unsigned int freq, const byte duration);

/**
 * HTRCXPlayToneVar function.
 * Send the PlayToneVar command to an RCX.
 *
 * \param varnum The variable containing the tone frequency to play.
 * \param duration The duration of the tone to play.
 */
inline void HTRCXPlayToneVar(const byte varnum, const byte duration);

/**
 * HTRCXRemote function.
 * Send the Remote command to an RCX.
 *
 * \param cmd The RCX IR remote command to send. See \ref RCXRemoteConstants.
 */
inline void HTRCXRemote(unsigned int cmd);

/**
 * HTRCXRev function.
 * Send commands to an RCX to set the specified outputs to the reverse direction.
 *
 * \param outputs The RCX output(s) to reverse direction. See \ref RCXOutputConstants.
 */
inline void HTRCXRev(const byte outputs);

/**
 * HTRCXSelectDisplay function.
 * Send the SelectDisplay command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void HTRCXSelectDisplay(const byte src, const unsigned int value);

/**
 * HTRCXSelectProgram function.
 * Send the SelectProgram command to an RCX.
 *
 * \param prog The program number to select.
 */
inline void HTRCXSelectProgram(const byte prog);

/**
 * HTRCXSendSerial function.
 * Send the SendSerial command to an RCX.
 *
 * \param first The first byte address.
 * \param count The number of bytes to send.
 */
inline void HTRCXSendSerial(const byte first, const byte count);

/**
 * HTRCXSetDirection function.
 * Send the SetDirection command to an RCX to configure the direction of the specified outputs.
 *
 * \param outputs The RCX output(s) to set direction. See \ref RCXOutputConstants.
 * \param dir The RCX output direction. See \ref RCXOutputDirection.
 */
inline void HTRCXSetDirection(const byte outputs, const byte dir);

/**
 * HTRCXSetEvent function.
 * Send the SetEvent command to an RCX.
 *
 * \param evt The event number to set.
 * \param src The RCX source. See \ref RCXSourceConstants.
 * \param type The event type.
 */
inline void HTRCXSetEvent(const byte evt, const byte src, const byte type);

/**
 * HTRCXSetGlobalDirection function.
 * Send the SetGlobalDirection command to an RCX.
 *
 * \param outputs The RCX output(s) to set global direction. See \ref RCXOutputConstants.
 * \param dir The RCX output direction. See \ref RCXOutputDirection.
 */
inline void HTRCXSetGlobalDirection(const byte outputs, const byte dir);

/**
 * HTRCXSetGlobalOutput function.
 * Send the SetGlobalOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to set global mode. See \ref RCXOutputConstants.
 * \param mode The RCX output mode. See \ref RCXOutputMode.
 */
inline void HTRCXSetGlobalOutput(const byte outputs, const byte mode);

/**
 * HTRCXSetMaxPower function.
 * Send the SetMaxPower command to an RCX.
 *
 * \param outputs The RCX output(s) to set max power. See \ref RCXOutputConstants.
 * \param pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param pwrval The RCX value.
 */
inline void HTRCXSetMaxPower(const byte outputs, const byte pwrsrc, const byte pwrval);

/**
 * HTRCXSetMessage function.
 * Send the SetMessage command to an RCX.
 *
 * \param msg The numeric message to send.
 */
inline void HTRCXSetMessage(const byte msg);

/**
 * HTRCXSetOutput function.
 * Send the SetOutput command to an RCX to configure the mode of the specified outputs
 *
 * \param outputs The RCX output(s) to set mode. See \ref RCXOutputConstants.
 * \param mode The RCX output mode. See \ref RCXOutputMode.
 */
inline void HTRCXSetOutput(const byte outputs, const byte mode);

/**
 * HTRCXSetPower function.
 * Send the SetPower command to an RCX to configure the power level of the specified outputs.
 *
 * \param outputs The RCX output(s) to set power. See \ref RCXOutputConstants.
 * \param pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param pwrval The RCX value.
 */
inline void HTRCXSetPower(const byte outputs, const byte pwrsrc, const byte pwrval);

/**
 * HTRCXSetPriority function.
 * Send the SetPriority command to an RCX.
 *
 * \param p The new task priority.
 */
inline void HTRCXSetPriority(const byte p);

/**
 * HTRCXSetSensorMode function.
 * Send the SetSensorMode command to an RCX.
 *
 * \param port The RCX sensor port.
 * \param mode The RCX sensor mode.
 */
inline void HTRCXSetSensorMode(const byte port, const byte mode);

/**
 * HTRCXSetSensorType function.
 * Send the SetSensorType command to an RCX.
 *
 * \param port The RCX sensor port.
 * \param type The RCX sensor type.
 */
inline void HTRCXSetSensorType(const byte port, const byte type);

/**
 * HTRCXSetSleepTime function.
 * Send the SetSleepTime command to an RCX.
 *
 * \param t The new sleep time value.
 */
inline void HTRCXSetSleepTime(const byte t);

/**
 * HTRCXSetTxPower function.
 * Send the SetTxPower command to an RCX.
 *
 * \param pwr The IR transmit power level.
 */
inline void HTRCXSetTxPower(const byte pwr);

/**
 * HTRCXSetWatch function.
 * Send the SetWatch command to an RCX.
 *
 * \param hours The new watch time hours value.
 * \param minutes The new watch time minutes value.
 */
inline void HTRCXSetWatch(const byte hours, const byte minutes);

/**
 * HTRCXStartTask function.
 * Send the StartTask command to an RCX.
 *
 * \param t The task number to start.
 */
inline void HTRCXStartTask(const byte t);

/**
 * HTRCXStopAllTasks function.
 * Send the StopAllTasks command to an RCX.
 */
inline void HTRCXStopAllTasks(void);

/**
 * HTRCXStopTask function.
 * Send the StopTask command to an RCX.
 *
 * \param t The task number to stop.
 */
inline void HTRCXStopTask(const byte t);

/**
 * HTRCXToggle function.
 * Send commands to an RCX to toggle the direction of the specified outputs.
 *
 * \param outputs The RCX output(s) to toggle. See \ref RCXOutputConstants.
 */
inline void HTRCXToggle(const byte outputs);

/**
 * HTRCXUnmuteSound function.
 * Send the UnmuteSound command to an RCX.
 */
inline void HTRCXUnmuteSound(void);

/**
 * HTScoutCalibrateSensor function.
 * Send the CalibrateSensor command to a Scout.
 */
inline void HTScoutCalibrateSensor(void);

/**
 * HTScoutMuteSound function.
 * Send the MuteSound command to a Scout.
 */
inline void HTScoutMuteSound(void);

/**
 * HTScoutSelectSounds function.
 * Send the SelectSounds command to a Scout.
 *
 * \param grp The Scout sound group to select.
 */
inline void HTScoutSelectSounds(const byte grp);

/**
 * HTScoutSendVLL function.
 * Send the SendVLL command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void HTScoutSendVLL(const byte src, const unsigned int value);

/**
 * HTScoutSetEventFeedback function.
 * Send the SetEventFeedback command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void HTScoutSetEventFeedback(const byte src, const unsigned int value);

/**
 * HTScoutSetLight function.
 * Send the SetLight command to a Scout.
 *
 * \param x Set the light on or off using this value. See \ref ScoutLightConstants.
 */
inline void HTScoutSetLight(const byte x);

/**
 * HTScoutSetScoutMode function.
 * Send the SetScoutMode command to a Scout.
 *
 * \param mode Set the scout mode. See \ref ScoutModeConstants.
*/
inline void HTScoutSetScoutMode(const byte mode);

/**
 * HTScoutSetSensorClickTime function.
 * Send the SetSensorClickTime command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void HTScoutSetSensorClickTime(const byte src, const unsigned int value);

/**
 * HTScoutSetSensorHysteresis function.
 * Send the SetSensorHysteresis command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void HTScoutSetSensorHysteresis(const byte src, const unsigned int value);

/**
 * HTScoutSetSensorLowerLimit function.
 * Send the SetSensorLowerLimit command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void HTScoutSetSensorLowerLimit(const byte src, const unsigned int value);

/**
 * HTScoutSetSensorUpperLimit function.
 * Send the SetSensorUpperLimit command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void HTScoutSetSensorUpperLimit(const byte src, const unsigned int value);

/**
 * HTScoutUnmuteSound function.
 * Send the UnmuteSound command to a Scout.
 */
inline void HTScoutUnmuteSound(void);

#else

#define SensorHTCompass(_port) asm { ReadSensorHTCompass(_port, __RETVAL__) }
#define ReadSensorHTAccel(_port, _x, _y, _z) asm { __ReadSensorHTAccel(_port, _x, _y, _z, __RETVAL__) }
#define ReadSensorHTColor(_port, _ColorNum, _Red, _Green, _Blue) asm { __ReadSensorHTColor(_port, _ColorNum, _Red, _Green, _Blue, __RETVAL__) }
#define ReadSensorHTRawColor(_port, _Red, _Green, _Blue) asm { __ReadSensorHTRawColor(_port, _Red, _Green, _Blue, __RETVAL__) }
#define ReadSensorHTNormalizedColor(_port, _ColorIdx, _Red, _Green, _Blue) asm { __ReadSensorHTNormalizedColor(_port, _ColorIdx, _Red, _Green, _Blue, __RETVAL__) }
#define ReadSensorHTIRSeeker(_port, _dir, _s1, _s3, _s5, _s7, _s9) asm { __ReadSensorHTIRSeeker(_port, _dir, _s1, _s3, _s5, _s7, _s9, __RETVAL__) }
#define SensorHTIRSeekerDir(_port) asm { ReadSensorHTIRSeekerDir(_port, __RETVAL__) }
#define SensorHTColorNum(_port) asm { ReadSensorHTColorNum(_port, __RETVAL__) }
#define ReadSensorHTTouchMultiplexer(_p, _t1, _t2, _t3, _t4) asm { __ReadSensorHTTouchMultiplexer(_p, _t1, _t2, _t3, _t4) }
#define SensorHTIRSeeker2Addr(_port, _reg) asm { ReadSensorHTIRSeeker2Addr(_port, _reg, __RETVAL__) }
#define SensorHTIRSeeker2DCDir(_port) asm { ReadSensorHTIRSeeker2Addr(_port, HTIR2_REG_DCDIR, __RETVAL__) }
#define SensorHTIRSeeker2ACDir(_port) asm { ReadSensorHTIRSeeker2Addr(_port, HTIR2_REG_ACDIR, __RETVAL__) }
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


#define HTPowerFunctionCommand(_port, _channel, _outa, _outb) asm { __HTPFComboDirect(_port, _channel, _outa, _outb, __RETVAL__) }
#define HTPFComboDirect(_port, _channel, _outa, _outb) asm { __HTPFComboDirect(_port, _channel, _outa, _outb, __RETVAL__) }
#define HTPFSinglePin(_port, _channel, _out, _pin, _func, _cont) asm { __HTPFSinglePin(_port, _channel, _out, _pin, _func, _cont, __RETVAL__) }
#define HTPFSingleOutputCST(_port, _channel, _out, _func) asm { __HTPFSingleOutput(_port, _channel, _out, _func, TRUE, __RETVAL__) }
#define HTPFSingleOutputPWM(_port, _channel, _out, _func) asm { __HTPFSingleOutput(_port, _channel, _out, _func, FALSE, __RETVAL__) }
#define HTPFComboPWM(_port, _channel, _outa, _outb) asm { __HTPFComboPWM(_port, _channel, _outa, _outb, __RETVAL__) }
#define HTPFTrain(_port, _channel, _func) asm { __HTIRTrain(_port, _channel, _func, TRUE, __RETVAL__) }
#define HTIRTrain(_port, _channel, _func) asm { __HTIRTrain(_port, _channel, _func, FALSE, __RETVAL__) }
#define HTPFRawOutput(_port, _nibble0, _nibble1, _nibble2) asm { __HTPFRawOutput(_port, _nibble0, _nibble1, _nibble2, __RETVAL__) }
#define HTPFRepeat(_port, _count, _delay) asm { __HTPFRepeatLastCommand(_port, _count, _delay, __RETVAL__) }

#define HTRCXSetIRLinkPort(_port) asm { __HTRCXSetIRLinkPort(_port) }
#define HTRCXPoll(_src, _value) asm { __HTRCXPoll(_src, _value, __RETVAL__) }
#define HTRCXBatteryLevel() asm { __HTRCXBatteryLevel(__RETVAL__) }
#define HTRCXPing() asm { __HTRCXOpNoArgs(RCX_PingOp) }
#define HTRCXDeleteTasks() asm { __HTRCXOpNoArgs(RCX_DeleteTasksOp) }
#define HTRCXStopAllTasks() asm { __HTRCXOpNoArgs(RCX_StopAllTasksOp) }
#define HTRCXPBTurnOff() asm { __HTRCXOpNoArgs(RCX_PBTurnOffOp) }
#define HTRCXDeleteSubs() asm { __HTRCXOpNoArgs(RCX_DeleteSubsOp) }
#define HTRCXClearSound() asm { __HTRCXOpNoArgs(RCX_ClearSoundOp) }
#define HTRCXClearMsg() asm { __HTRCXOpNoArgs(RCX_ClearMsgOp) }
#define HTRCXMuteSound() asm { __HTRCXOpNoArgs(RCX_MuteSoundOp) }
#define HTRCXUnmuteSound() asm { __HTRCXOpNoArgs(RCX_UnmuteSoundOp) }
#define HTRCXClearAllEvents() asm { __HTRCXOpNoArgs(RCX_ClearAllEventsOp) }
#define HTRCXSetOutput(_outputs, _mode) asm { __HTRCXSetOutput(_outputs, _mode) }
#define HTRCXSetDirection(_outputs, _dir) asm { __HTRCXSetDirection(_outputs, _dir) }
#define HTRCXSetPower(_outputs, _pwrsrc, _pwrval) asm { __HTRCXSetPower(_outputs, _pwrsrc, _pwrval) }
#define HTRCXOn(_outputs) asm { __HTRCXSetOutput(_outputs, RCX_OUT_ON) }
#define HTRCXOff(_outputs) asm { __HTRCXSetOutput(_outputs, RCX_OUT_OFF) }
#define HTRCXFloat(_outputs) asm { __HTRCXSetOutput(_outputs, RCX_OUT_FLOAT) }
#define HTRCXToggle(_outputs) asm { __HTRCXSetDirection(_outputs, RCX_OUT_TOGGLE) }
#define HTRCXFwd(_outputs) asm { __HTRCXSetDirection(_outputs, RCX_OUT_FWD) }
#define HTRCXRev(_outputs) asm { __HTRCXSetDirection(_outputs, RCX_OUT_REV) }
#define HTRCXOnFwd(_outputs) asm { __HTRCXOnFwd(_outputs) }
#define HTRCXOnRev(_outputs) asm { __HTRCXOnRev(_outputs) }
#define HTRCXOnFor(_outputs, _ms) asm { __HTRCXOnFor(_outputs, _ms) }
#define HTRCXSetTxPower(_pwr) asm { __HTRCXSetTxPower(_pwr) }
#define HTRCXPlaySound(_snd) asm { __HTRCXPlaySound(_snd) }
#define HTRCXDeleteTask(_t) asm { __HTRCXDeleteTask(_t) }
#define HTRCXStartTask(_t) asm { __HTRCXStartTask(_t) }
#define HTRCXStopTask(_t) asm { __HTRCXStopTask(_t) }
#define HTRCXSelectProgram(_prog) asm { __HTRCXSelectProgram(_prog) }
#define HTRCXClearTimer(_timer) asm { __HTRCXClearTimer(_timer) }
#define HTRCXSetSleepTime(_t) asm { __HTRCXSetSleepTime(_t) }
#define HTRCXDeleteSub(_s) asm { __HTRCXDeleteSub(_s) }
#define HTRCXClearSensor(_port) asm { __HTRCXClearSensor(_port) }
#define HTRCXPlayToneVar(_varnum, _duration) asm { __HTRCXPlayToneVar(_varnum, _duration) }
#define HTRCXSetWatch(_hours, _minutes) asm { __HTRCXSetWatch(_hours, _minutes) }
#define HTRCXSetSensorType(_port, _type) asm { __HTRCXSetSensorType(_port, _type) }
#define HTRCXSetSensorMode(_port, _mode) asm { __HTRCXSetSensorMode(_port, _mode) }
#define HTRCXCreateDatalog(_size) asm { __HTRCXCreateDatalog(_size) }
#define HTRCXAddToDatalog(_src, _value) asm { __HTRCXAddToDatalog(_src, _value) }
#define HTRCXSendSerial(_first, _count) asm { __HTRCXSendSerial(_first, _count) }
#define HTRCXRemote(_cmd) asm { __HTRCXRemote(_cmd) }
#define HTRCXEvent(_src, _value) asm { __HTRCXEvent(_src, _value) }
#define HTRCXPlayTone(_freq, _duration) asm { __HTRCXPlayTone(_freq, _duration) }
#define HTRCXSelectDisplay(_src, _value) asm { __HTRCXSelectDisplay(_src, _value) }
#define HTRCXPollMemory(_memaddress) asm { __HTRCXPollMemory(_memaddress, __RETVAL__) }
#define HTRCXSetEvent(_evt, _src, _type) asm { __HTRCXSetEvent(_evt, _src, _type) }
#define HTRCXSetGlobalOutput(_outputs, _mode) asm { __HTRCXSetGlobalOutput(_outputs, _mode) }
#define HTRCXSetGlobalDirection(_outputs, _dir) asm { __HTRCXSetGlobalDirection(_outputs, _dir) }
#define HTRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) asm { __HTRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) }
#define HTRCXEnableOutput(_outputs) asm { __HTRCXSetGlobalOutput(_outputs, RCX_OUT_ON) }
#define HTRCXDisableOutput(_outputs) asm { __HTRCXSetGlobalOutput(_outputs, RCX_OUT_OFF) }
#define HTRCXInvertOutput(_outputs) asm { __HTRCXSetGlobalDirection(_outputs, RCX_OUT_REV) }
#define HTRCXObvertOutput(_outputs) asm { __HTRCXSetGlobalDirection(_outputs, RCX_OUT_FWD) }
#define HTRCXIncCounter(_counter) asm { __HTRCXIncCounter(_counter) }
#define HTRCXDecCounter(_counter) asm { __HTRCXDecCounter(_counter) }
#define HTRCXClearCounter(_counter) asm { __HTRCXClearCounter(_counter) }
#define HTRCXSetPriority(_p) asm { __HTRCXSetPriority(_p) }
#define HTRCXSetMessage(_msg) asm { __HTRCXSetMessage(_msg) }

#define HTScoutCalibrateSensor() asm { __HTRCXOpNoArgs(RCX_LSCalibrateOp) }
#define HTScoutMuteSound() asm { __HTScoutMuteSound() }
#define HTScoutUnmuteSound() asm { __HTScoutUnmuteSound() }
#define HTScoutSelectSounds(_grp) asm { __HTScoutSelectSounds(_grp) }
#define HTScoutSetLight(_x) asm { __HTScoutSetLight(_x) }
#define HTScoutSetSensorClickTime(_src, _value) asm { __HTScoutSetSensorClickTime(_src, _value) }
#define HTScoutSetSensorHysteresis(_src, _value) asm { __HTScoutSetSensorHysteresis(_src, _value) }
#define HTScoutSetSensorLowerLimit(_src, _value) asm { __HTScoutSetSensorLowerLimit(_src, _value) }
#define HTScoutSetSensorUpperLimit(_src, _value) asm { __HTScoutSetSensorUpperLimit(_src, _value) }
#define HTScoutSetEventFeedback(_src, _value) asm { __HTScoutSetEventFeedback(_src, _value) }
#define HTScoutSendVLL(_src, _value) asm { __HTScoutSendVLL(_src, _value) }
#define HTScoutSetScoutMode(_mode) asm { __HTScoutSetScoutMode(_mode) }

#endif
/** @} */ // end of HiTechnicAPI group

#endif // HITECHNIC_H
