/** \file input_constants.h
 * \brief NXC Input module constants
 *
 * input_constants.h contains NXC Input module constants
 *
 * License:
 *
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHIN WARRANTY OF ANY KIND, either express or implied. See the
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

#ifndef INPUT_CONSTANTS_H
#define INPUT_CONSTANTS_H

/** @addtogroup InputModule
 * @{
 */
/** @addtogroup InputModuleConstants
 * @{
 */

/** @defgroup NBCInputPortConstants NBC Input port constants
 * Input port constants are used when calling sensor control API functions.
 * These constants are intended for use in NBC.
 * \sa SetSensorType(), SetSensorMode(), S1, S2, S3, S4
 * @{
 */
#define IN_1 0x00 /*!< Input port 1 */
#define IN_2 0x01 /*!< Input port 2 */
#define IN_3 0x02 /*!< Input port 3 */
#define IN_4 0x03 /*!< Input port 4 */
/** @} */  // end of InputPortConstants group

/** @addtogroup InputModuleTypesAndModes
 * @{
 */
/** @defgroup NBCSensorTypeConstants NBC sensor type constants
 * Use sensor type constants to configure an input port for a specific type
 * of sensor. These constants are intended for use in NBC.
 * \sa SetSensorType()
 * @{
 */
#define IN_TYPE_NO_SENSOR      0x00 /*!< No sensor configured */
#define IN_TYPE_SWITCH         0x01 /*!< NXT or RCX touch sensor */
#define IN_TYPE_TEMPERATURE    0x02 /*!< RCX temperature sensor */
#define IN_TYPE_REFLECTION     0x03 /*!< RCX light sensor */
#define IN_TYPE_ANGLE          0x04 /*!< RCX rotation sensor */
#define IN_TYPE_LIGHT_ACTIVE   0x05 /*!< NXT light sensor with light */
#define IN_TYPE_LIGHT_INACTIVE 0x06 /*!< NXT light sensor without light */
#define IN_TYPE_SOUND_DB       0x07 /*!< NXT sound sensor with dB scaling */
#define IN_TYPE_SOUND_DBA      0x08 /*!< NXT sound sensor with dBA scaling */
#define IN_TYPE_CUSTOM         0x09 /*!< NXT custom sensor */
#define IN_TYPE_LOWSPEED       0x0A /*!< NXT I2C digital sensor */
#define IN_TYPE_LOWSPEED_9V    0x0B /*!< NXT I2C digital sensor with 9V power */
#define IN_TYPE_HISPEED        0x0C /*!< NXT Hi-speed port (only S4) */
#if __FIRMWARE_VERSION > 107
#define IN_TYPE_COLORFULL      0x0D /*!< NXT 2.0 color sensor in full color mode */
#define IN_TYPE_COLORRED       0x0E /*!< NXT 2.0 color sensor with red light */
#define IN_TYPE_COLORGREEN     0x0F /*!< NXT 2.0 color sensor with green light */
#define IN_TYPE_COLORBLUE      0x10 /*!< NXT 2.0 color sensor with blue light */
#define IN_TYPE_COLORNONE      0x11 /*!< NXT 2.0 color sensor with no light */
#define IN_TYPE_COLOREXIT      0x12 /*!< NXT 2.0 color sensor internal state */
#endif
/** @} */  // end of NBCSensorTypeConstants group

/** @defgroup NBCSensorModeConstants NBC sensor mode constants
 * Use sensor mode constants to configure an input port for the desired
 * sensor mode. The constants are intended for use in NBC.
 * \sa SetSensorMode()
 * @{
 */
#define IN_MODE_RAW           0x00 /*!< Raw value from 0 to 1023 */
#define IN_MODE_BOOLEAN       0x20 /*!< Boolean value (0 or 1) */
#define IN_MODE_TRANSITIONCNT 0x40 /*!< Counts the number of boolean transitions */
#define IN_MODE_PERIODCOUNTER 0x60 /*!< Counts the number of boolean periods */
#define IN_MODE_PCTFULLSCALE  0x80 /*!< Scaled value from 0 to 100 */
#define IN_MODE_CELSIUS       0xA0 /*!< RCX temperature sensor value in degrees celcius */
#define IN_MODE_FAHRENHEIT    0xC0 /*!< RCX temperature sensor value in degrees fahrenheit */
#define IN_MODE_ANGLESTEP     0xE0 /*!< RCX rotation sensor (16 ticks per revolution) */
#define IN_MODE_SLOPEMASK     0x1F /*!< Mask for slope parameter added to mode */
#define IN_MODE_MODEMASK      0xE0 /*!< Mask for the mode without any slope value */
/** @} */  // end of NBCSensorModeConstants group
/** @} */  // end of InputModuleTypesAndModes group

/** @defgroup InputFieldConstants Input field constants
 * Constants for use with SetInput() and GetInput().
 * Each sensor has six fields that are used to define its state.
 * @{
 */
#define TypeField            0 /*!< Type field. Contains one of the sensor type constants. Read/write. */
#define InputModeField       1 /*!< Input mode field. Contains one of the sensor mode constants. Read/write. */
#define RawValueField        2 /*!< Raw value field. Contains the current raw analog sensor value. Read only. */
#define NormalizedValueField 3 /*!< Normalized value field. Contains the current normalized analog sensor value. Read only. */
#define ScaledValueField     4 /*!< Scaled value field. Contains the current scaled analog sensor value. Read/write. */
#define InvalidDataField     5 /*!< Invalid data field. Contains a boolean value indicating whether the sensor data is valid or not. Read/write. */
/** @} */  // end of InputFieldConstants group

/** @defgroup InputDigiPinConstants Input port digital pin constants
 * Constants for use when directly controlling or reading a port's digital pin
 * state.
 * @{
 */
#define INPUT_DIGI0    0x01 /*!< Digital pin 0 */
#define INPUT_DIGI1    0x02 /*!< Digital pin 1*/
/** @} */  // end of InputDigiPinConstants group

#define INPUT_CUSTOMINACTIVE 0x00 /*!< Custom sensor inactive */
#define INPUT_CUSTOM9V       0x01 /*!< Custom sensor 9V */
#define INPUT_CUSTOMACTIVE   0x02 /*!< Custom sensor active */

#define INPUT_INVALID_DATA   0x01 /*!< Invalid data flag */

#if __FIRMWARE_VERSION > 107

/** @defgroup InputColorIdxConstants Color sensor array indices
 * Constants for use with color sensor value arrays to index RGB and blank
 * return values.
 * \sa ReadSensorColorEx(), ReadSensorColorRaw(), SysColorSensorRead(),
 * ColorSensorReadType
 * @{
 */
#define INPUT_RED          0 /*!< Access the red value from color sensor value arrays */
#define INPUT_GREEN        1 /*!< Access the green value from color sensor value arrays */
#define INPUT_BLUE         2 /*!< Access the blue value from color sensor value arrays */
#define INPUT_BLANK        3 /*!< Access the blank value from color sensor value arrays */
#define INPUT_NO_OF_COLORS 4 /*!< The number of entries in the color sensor value arrays */
/** @} */  // end of InputColorIdxConstants group

/** @defgroup InputColorValueConstants Color values
 * Constants for use with the ColorValue returned by the color sensor in full
 * color mode.
 * \sa SensorValue(), SysColorSensorRead(), ColorSensorReadType
 * @{
 */
#define INPUT_BLACKCOLOR  1 /*!< The color value is black */
#define INPUT_BLUECOLOR   2 /*!< The color value is blue */
#define INPUT_GREENCOLOR  3 /*!< The color value is green */
#define INPUT_YELLOWCOLOR 4 /*!< The color value is yellow */
#define INPUT_REDCOLOR    5 /*!< The color value is red */
#define INPUT_WHITECOLOR  6 /*!< The color value is white */
/** @} */  // end of InputColorIdxConstants group

/** @defgroup InputColorCalibrationStateConstants Color calibration state constants
 * Constants for use with the color calibration state function.
 * \sa ColorCalibrationState()
 * @{
 */
#define INPUT_SENSORCAL  0x01 /*!< The state returned while the color sensor is calibrating */
#define INPUT_SENSOROFF  0x02 /*!< The state returned once calibration has completed */
#define INPUT_RUNNINGCAL 0x20 /*!< Unused calibration state constant */
#define INPUT_STARTCAL   0x40 /*!< Unused calibration state constant */
#define INPUT_RESETCAL   0x80 /*!< Unused calibration state constant */
/** @} */  // end of InputColorCalibrationStateConstants group

/** @defgroup InputColorCalibrationConstants Color calibration constants
 * Constants for use with the color calibration functions.
 * \sa ColorCalibration(), ColorCalLimits()
 * @{
 */
#define INPUT_CAL_POINT_0  0 /*!< Calibration point 0 */
#define INPUT_CAL_POINT_1  1 /*!< Calibration point 1 */
#define INPUT_CAL_POINT_2  2 /*!< Calibration point 2 */
#define INPUT_NO_OF_POINTS 3 /*!< The number of calibration points */
/** @} */  // end of InputColorCalibrationConstants group

#endif

/** @defgroup InputIOMAP Input module IOMAP offsets
 * Constant offsets into the Input module IOMAP structure.
 * @{
 */
#define InputOffsetCustomZeroOffset(p)   (((p)*20)+0)  /*!< Read/write the zero offset of a custom sensor (2 bytes) uword */
#define InputOffsetADRaw(p)              (((p)*20)+2)  /*!< Read the AD raw sensor value (2 bytes) uword */
#define InputOffsetSensorRaw(p)          (((p)*20)+4)  /*!< Read the raw sensor value (2 bytes) uword */
#define InputOffsetSensorValue(p)        (((p)*20)+6)  /*!< Read/write the scaled sensor value (2 bytes) sword */
#define InputOffsetSensorType(p)         (((p)*20)+8)  /*!< Read/write the sensor type */
#define InputOffsetSensorMode(p)         (((p)*20)+9)  /*!< Read/write the sensor mode */
#define InputOffsetSensorBoolean(p)      (((p)*20)+10) /*!< Read the sensor boolean value */
#define InputOffsetDigiPinsDir(p)        (((p)*20)+11) /*!< Read/write the direction of the Digital pins (1 is output, 0 is input) */
#define InputOffsetDigiPinsIn(p)         (((p)*20)+12) /*!< Read/write the status of the digital pins */
#define InputOffsetDigiPinsOut(p)        (((p)*20)+13) /*!< Read/write the output level of the digital pins */
#define InputOffsetCustomPctFullScale(p) (((p)*20)+14) /*!< Read/write the Pct full scale of the custom sensor */
#define InputOffsetCustomActiveStatus(p) (((p)*20)+15) /*!< Read/write the active or inactive state of the custom sensor */
#define InputOffsetInvalidData(p)        (((p)*20)+16) /*!< Indicates whether data is invalid (1) or valid (0) */

#if __FIRMWARE_VERSION > 107
#define InputOffsetColorCalibration(p, np, nc) (80+((p)*84)+0+((np)*16)+((nc)*4)) /*!< Read/write color calibration point values */
#define InputOffsetColorCalLimits(p, np)       (80+((p)*84)+48+((np)*2)) /*!< Read/write color calibration limits */
#define InputOffsetColorADRaw(p, nc)           (80+((p)*84)+52+((nc)*2)) /*!< Read AD raw color sensor values */
#define InputOffsetColorSensorRaw(p, nc)       (80+((p)*84)+60+((nc)*2)) /*!< Read raw color sensor values */
#define InputOffsetColorSensorValue(p, nc)     (80+((p)*84)+68+((nc)*2)) /*!< Read scaled color sensor values */
#define InputOffsetColorBoolean(p, nc)         (80+((p)*84)+76+((nc)*2)) /*!< Read color sensor boolean values */
#define InputOffsetColorCalibrationState(p)    (80+((p)*84)+80)          /*!< Read color sensor calibration state */
#endif
/** @} */  // end of InputIOMap group


#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/** @defgroup InputPinFuncConstants Constants to use with the Input module's Pin function
 * Constants for use with the Input module's Pin function.  These are the commands
 * that you can pass into the pin function to change digital pin directions,
 * set or clear pins, or read pin values. Also in this group are mask constants
 * and a macro for ORing a microsecond wait onto the command byte which will
 * occur after the command has been executed.
 * @{
 */
#define INPUT_PINCMD_DIR    0x00 /*!< Set digital pin(s) direction */
#define INPUT_PINCMD_SET    0x01 /*!< Set digital pin(s) */
#define INPUT_PINCMD_CLEAR  0x02 /*!< Clear digital pin(s) */
#define INPUT_PINCMD_READ   0x03 /*!< Read digital pin(s) */
#define INPUT_PINCMD_MASK   0x03 /*!< Mask for the two bits used by pin function commands */
#define INPUT_PINCMD_WAIT(_usec) ((_usec)<<2) /*!< A wait value in microseconds that can be added after one of the above commands by ORing with the command */
#define INPUT_PINDIR_OUTPUT 0x00 /*!< Use with the direction command to set direction to input.  OR this with the pin value. */
#define INPUT_PINDIR_INPUT  0x04 /*!< Use with the direction command to set direction to output.  OR this with the pin value. */
/** @} */  // end of InputPinFuncCmdConstants group
#endif

/** @} */  // end of InputModuleConstants group
/** @} */  // end of InputModule group

#endif // INPUT_CONSTANTS_H
