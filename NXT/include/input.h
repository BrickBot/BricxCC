/** \file input.h
 * \brief The NXC input module API
 *
 * input.h contains the NXC input module API
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

#ifndef INPUT_H
#define INPUT_H

#include "input_constants.h"

#ifndef __DOXYGEN_DOCS
asm { asminclude "nbc_input.h" }
#endif

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// INPUT MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup InputModule
 * @{
 */
/** @addtogroup InputModuleConstants
 * @{
 */
/** @defgroup InPorts Input port constants
 * Input port constants are used when calling NXC sensor control API functions.
 * @{
 */
#define S1 0 /*!< Input port 1 */
#define S2 1 /*!< Input port 2 */
#define S3 2 /*!< Input port 3 */
#define S4 3 /*!< Input port 4 */
/** @} */ // end of InPorts group

/** @addtogroup InputModuleTypesAndModes
 * @{
 */
/** @defgroup SensorTypes Sensor type constants
 *  Use sensor type constants to configure an input port for a specific type
 *  of sensor.
 *  \sa SetSensorType()
 *  @{
 */
#define SENSOR_TYPE_NONE            IN_TYPE_NO_SENSOR      /*!< No sensor configured */
#define SENSOR_TYPE_TOUCH           IN_TYPE_SWITCH         /*!< NXT or RCX touch sensor */
#define SENSOR_TYPE_TEMPERATURE     IN_TYPE_TEMPERATURE    /*!< RCX temperature sensor */
#define SENSOR_TYPE_LIGHT           IN_TYPE_REFLECTION     /*!< RCX light sensor */
#define SENSOR_TYPE_ROTATION        IN_TYPE_ANGLE          /*!< RCX rotation sensor */
#define SENSOR_TYPE_LIGHT_ACTIVE    IN_TYPE_LIGHT_ACTIVE   /*!< NXT light sensor with light */
#define SENSOR_TYPE_LIGHT_INACTIVE  IN_TYPE_LIGHT_INACTIVE /*!< NXT light sensor without light */
#define SENSOR_TYPE_SOUND_DB        IN_TYPE_SOUND_DB       /*!< NXT sound sensor with dB scaling */
#define SENSOR_TYPE_SOUND_DBA       IN_TYPE_SOUND_DBA      /*!< NXT sound sensor with dBA scaling */
#define SENSOR_TYPE_CUSTOM          IN_TYPE_CUSTOM         /*!< NXT custom sensor */
#define SENSOR_TYPE_LOWSPEED        IN_TYPE_LOWSPEED       /*!< NXT I2C digital sensor */
#define SENSOR_TYPE_LOWSPEED_9V     IN_TYPE_LOWSPEED_9V    /*!< NXT I2C digital sensor with 9V power */
#define SENSOR_TYPE_HIGHSPEED       IN_TYPE_HISPEED        /*!< NXT Hi-speed port (only S4) */
#if __FIRMWARE_VERSION > 107
#define SENSOR_TYPE_COLORFULL       IN_TYPE_COLORFULL      /*!< NXT 2.0 color sensor in full color mode */
#define SENSOR_TYPE_COLORRED        IN_TYPE_COLORRED       /*!< NXT 2.0 color sensor with red light */
#define SENSOR_TYPE_COLORGREEN      IN_TYPE_COLORGREEN     /*!< NXT 2.0 color sensor with green light */
#define SENSOR_TYPE_COLORBLUE       IN_TYPE_COLORBLUE      /*!< NXT 2.0 color sensor with blue light */
#define SENSOR_TYPE_COLORNONE       IN_TYPE_COLORNONE      /*!< NXT 2.0 color sensor with no light */
#endif
/** @} */ // end of SensorTypes group

/** @defgroup SensorModes Sensor mode constants
 * Use sensor mode constants to configure an input port for the desired
 * sensor mode.
 * \sa SetSensorMode()
 * @{
 */
#define SENSOR_MODE_RAW         IN_MODE_RAW           /*!< Raw value from 0 to 1023 */
#define SENSOR_MODE_BOOL        IN_MODE_BOOLEAN       /*!< Boolean value (0 or 1) */
#define SENSOR_MODE_EDGE        IN_MODE_TRANSITIONCNT /*!< Counts the number of boolean transitions */
#define SENSOR_MODE_PULSE       IN_MODE_PERIODCOUNTER /*!< Counts the number of boolean periods */
#define SENSOR_MODE_PERCENT     IN_MODE_PCTFULLSCALE  /*!< Scaled value from 0 to 100 */
#define SENSOR_MODE_CELSIUS     IN_MODE_CELSIUS       /*!< RCX temperature sensor value in degrees celcius */
#define SENSOR_MODE_FAHRENHEIT  IN_MODE_FAHRENHEIT    /*!< RCX temperature sensor value in degrees fahrenheit */
#define SENSOR_MODE_ROTATION    IN_MODE_ANGLESTEP     /*!< RCX rotation sensor (16 ticks per revolution) */
/** @} */ // end of SensorModes group

/** @defgroup SensorTypeModes Combined sensor type and mode constants
 * Use the combined sensor type and mode constants to configure both
 * the sensor mode and type in a single function call.
 * \sa SetSensor()
 * @{
 */
#define _SENSOR_CFG(_type,_mode)	(((_type)<<8)+(_mode))                               /*!< Macro for defining \ref SetSensor combined type and mode constants */
#define SENSOR_TOUCH		_SENSOR_CFG(SENSOR_TYPE_TOUCH, SENSOR_MODE_BOOL)             /*!< Touch sensor in boolean mode */
#define SENSOR_LIGHT		_SENSOR_CFG(SENSOR_TYPE_LIGHT, SENSOR_MODE_PERCENT)          /*!< RCX Light sensor in percent mode */
#define SENSOR_ROTATION		_SENSOR_CFG(SENSOR_TYPE_ROTATION, SENSOR_MODE_ROTATION)      /*!< RCX rotation sensor in rotation mode */
#define SENSOR_CELSIUS		_SENSOR_CFG(SENSOR_TYPE_TEMPERATURE, SENSOR_MODE_CELSIUS)    /*!< RCX temperature sensor in celcius mode */
#define SENSOR_FAHRENHEIT	_SENSOR_CFG(SENSOR_TYPE_TEMPERATURE, SENSOR_MODE_FAHRENHEIT) /*!< RCX temperature sensor in fahrenheit mode */
#define	SENSOR_PULSE		_SENSOR_CFG(SENSOR_TYPE_TOUCH, SENSOR_MODE_PULSE)            /*!< Touch sensor in pulse mode */
#define SENSOR_EDGE         _SENSOR_CFG(SENSOR_TYPE_TOUCH, SENSOR_MODE_EDGE)             /*!< Touch sensor in edge mode */
#define SENSOR_NXTLIGHT		_SENSOR_CFG(SENSOR_TYPE_LIGHT_ACTIVE, SENSOR_MODE_PERCENT)   /*!< NXT light sensor in active mode */
#define SENSOR_SOUND		_SENSOR_CFG(SENSOR_TYPE_SOUND_DB, SENSOR_MODE_PERCENT)       /*!< NXT sound sensor (dB) in percent mode */
#define SENSOR_LOWSPEED_9V  _SENSOR_CFG(SENSOR_TYPE_LOWSPEED_9V, SENSOR_MODE_RAW)        /*!< NXT I2C sensor with 9V power in raw mode */
#define SENSOR_LOWSPEED     _SENSOR_CFG(SENSOR_TYPE_LOWSPEED, SENSOR_MODE_RAW)           /*!< NXT I2C sensor without 9V power in raw mode */
#if __FIRMWARE_VERSION > 107
#define SENSOR_COLORFULL	_SENSOR_CFG(SENSOR_TYPE_COLORFULL, SENSOR_MODE_RAW)          /*!< NXT 2.0 color sensor (full) in raw mode */
#define SENSOR_COLORRED		_SENSOR_CFG(SENSOR_TYPE_COLORRED, SENSOR_MODE_PERCENT)       /*!< NXT 2.0 color sensor (red) in percent mode */
#define SENSOR_COLORGREEN	_SENSOR_CFG(SENSOR_TYPE_COLORGREEN, SENSOR_MODE_PERCENT)     /*!< NXT 2.0 color sensor (green) in percent mode */
#define SENSOR_COLORBLUE	_SENSOR_CFG(SENSOR_TYPE_COLORBLUE, SENSOR_MODE_PERCENT)      /*!< NXT 2.0 color sensor (blue) in percent mode */
#define SENSOR_COLORNONE	_SENSOR_CFG(SENSOR_TYPE_COLORNONE, SENSOR_MODE_PERCENT)      /*!< NXT 2.0 color sensor (none) in percent mode */
#endif
/** @} */ // end of SensorModes group
/** @} */ // end of InputModuleTypesAndModes group
/** @} */ // end of InputModuleConstants group

/** @defgroup InputModuleTypes Input module types
 * Types used by various input module functions.
 * @{
 */
#if __FIRMWARE_VERSION > 107
/**
 * Parameters for the ColorSensorRead system call.
 * This structure is used when calling the \ref SysColorSensorRead system call function.
 * Choose the sensor port (\ref InPorts) and after calling the function
 * read the sensor values from the ColorValue field or the raw, normalized, or
 * scaled value arrays.
 * \sa SysColorSensorRead()
 */
struct ColorSensorReadType {
 char Result;                    /*!< The function call result. \ref NO_ERR means it succeeded. */
 byte Port;                      /*!< The sensor port. See the constants in the \ref InPorts group. */
 int ColorValue;                 /*!< The color value returned by the sensor. See the \ref InputColorValueConstants group. */
 unsigned int RawArray[];        /*!< Raw color values returned by the sensor. See the \ref InputColorIdxConstants group. */
 unsigned int NormalizedArray[]; /*!< Normalized color values returned by the sensor. See the \ref InputColorIdxConstants group. */
 int ScaledArray[];              /*!< Scaled color values returned by the sensor. See the \ref InputColorIdxConstants group. */
 bool Invalid;                   /*!< Are the sensor values valid? */
};
#endif

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/**
 * Parameters for the \ref RemoteGetInputValues function.
 * This structure is used when calling the \ref RemoteGetInputValues function.
 * Choose the sensor port (\ref InPorts) and after calling the function
 * read the sensor values from the various structure fields.
 */
struct InputValuesType {
  byte Port;                    /*!< The sensor port. See the \ref InPorts group. */
  bool Valid;                   /*!< Is the sensor value valid? */
  bool Calibrated;              /*!< Is the sensor calibrated? */
  byte SensorType;              /*!< The sensor type. See the \ref SensorTypes group. */
  byte SensorMode;              /*!< The sensor mode. See the \ref SensorModes group. */
  unsigned int RawValue;        /*!< The raw value. */
  unsigned int NormalizedValue; /*!< The normalized value. */
  int ScaledValue;              /*!< The scaled value. */
  int CalibratedValue;          /*!< The calibrated value. */
};

/*
struct InputType {
  unsigned int CustomZeroOffset;
  unsigned int ADRaw;
  unsigned int SensorRaw;
  int SensorValue;
  byte SensorType;
  byte SensorMode;
  bool SensorBoolean;
  byte DigiPinsDir;
  byte DigiPinsIn;
  byte DigiPinsOut;
  byte CustomPctFullScale;
  byte CustomActiveStatus;
  bool InvalidData;
};
*/

/**
 * Parameters for the InputPinFunction system call.
 * This structure is used when calling the \ref SysInputPinFunction system call
 * function.
 * \sa SysInputPinFunction()
 */
struct InputPinFunctionType {
  unsigned int Result; /*!< The function call result. Possible return values are
                            ERR_INVALID_PORT or NO_ERR. */
  byte Cmd;            /*!< The command to execute. See \ref InputPinFuncConstants.
                            You can add a microsecond wait after the command by
                            ORing INPUT_PINCMD_WAIT(usec) with the command value.
                            Wait times can range from 1 to 63 microseconds. */
  byte Port;           /*!< The input port. See \ref InPorts. */
  byte Pin;            /*!< The digital pin(s). See \ref InputDigiPinConstants.
                            When setting pin direction you must OR the desired
                            direction constant into this field.  See
                            INPUT_PINDIR_INPUT and INPUT_PINDIR_OUTPUT
                            from the \ref InputPinFuncConstants group. You
                            can OR together the digital pin constants to
                            operate on both in a single call. */
  byte Data;           /*!< The pin value(s). This field is only used by the
                            INPUT_PINCMD_READ command. */
};


#endif

/** @} */ // end of InputModuleTypes group

/** @defgroup InputModuleFunctions Input module functions
 * Functions for accessing and modifying input module features.
 * @{
 */

/** @defgroup BasicSensorValues Basic analog sensor value names
 * Read analog sensor values using these names.  Returns the current scaled value
 * of the sensor on the specified port.
 * @{
 */
#define SENSOR_1 Sensor(S1) /*!< Read the value of the analog sensor on port S1 */
#define SENSOR_2 Sensor(S2) /*!< Read the value of the analog sensor on port S2 */
#define SENSOR_3 Sensor(S3) /*!< Read the value of the analog sensor on port S3 */
#define SENSOR_4 Sensor(S4) /*!< Read the value of the analog sensor on port S4 */
/** @} */ // end of BasicSensorValues group

/**
 * Set sensor type.
 * Set a sensor's type, which must be one of the predefined sensor type
 * constants.  After changing the type or the mode of a sensor
 * port you must call \ref ResetSensor to give the firmware time to reconfigure
 * the sensor port.
 * \sa SetSensorMode(), SetSensor()
 * \param port The port to configure. See \ref InPorts.
 * \param type The desired sensor type.  See \ref SensorTypes.
 */
inline void SetSensorType(const byte & port, byte type) { asm { setin type, port, TypeField } }

/**
 * Set sensor mode.
 * Set a sensor's mode, which should be one of the predefined sensor mode
 * constants. A slope parameter for boolean conversion, if desired, may be
 * added to the mode. After changing the type or the mode of a sensor
 * port you must call \ref ResetSensor to give the firmware time to reconfigure
 * the sensor port.
 * \sa SetSensorType(), SetSensor()
 * \param port The port to configure. See \ref InPorts.
 * \param mode The desired sensor mode. See \ref SensorModes.
 */
inline void SetSensorMode(const byte & port, byte mode) { asm { setin mode, port, InputModeField } }

/**
 * Clear a sensor value.
 * Clear the value of a sensor - only affects sensors that are configured
 * to measure a cumulative quantity such as rotation or a pulse count.
 * \param port The port to clear. See \ref InPorts.
 */
inline void ClearSensor(const byte & port) { asm { setin 0, port, ScaledValueField } }

/**
 * Reset the sensor port.
 * Sets the invalid data flag on the specified port and waits for it to
 * become valid again. After changing the type or the mode of a sensor
 * port you must call this function to give the firmware time to reconfigure
 * the sensor port.
 * \param port The port to reset. See \ref InPorts.
 */
inline void ResetSensor(const byte & port) { asm { __ResetSensor(port) } }

/**
 * Set sensor configuration.
 * Set the type and mode of the given sensor to the specified configuration,
 * which must be a special constant containing both type and mode information.
 * \sa SetSensorType(), SetSensorMode(), and ResetSensor()
 * \param port The port to configure. See \ref InPorts.
 * \param config The configuration constant containing both the type and mode.
 * See \ref SensorTypeModes.
 */
inline void SetSensor(const byte & port, const unsigned int config) {
  asm {
    setin config>>8, port, TypeField
    setin config&0xff, port, InputModeField
    __ResetSensor(port)
  }
}

/**
 * Configure a touch sensor.
 * Configure the sensor on the specified port as a touch sensor.
 * \param port The port to configure. See \ref InPorts.
 */
inline void SetSensorTouch(const byte & port) { asm { __SetSensorTouch(port) } }

/**
 * Configure a light sensor.
 * Configure the sensor on the specified port as an NXT light sensor.
 * \param port The port to configure. See \ref InPorts.
 * \param bActive A boolean flag indicating whether to configure the port
 * as an active or inactive light sensor.  The default value for this
 * optional parameter is true.
 */
inline void SetSensorLight(const byte & port, bool bActive = true) {
  SetSensorType(port, bActive ? SENSOR_TYPE_LIGHT_ACTIVE : SENSOR_TYPE_LIGHT_INACTIVE);
  SetSensorMode(port, SENSOR_MODE_PERCENT);
  ResetSensor(port);
}

/**
 * Configure a sound sensor.
 * Configure the sensor on the specified port as a sound sensor.
 * \param port The port to configure. See \ref InPorts.
 * \param bdBScaling A boolean flag indicating whether to configure the port
 * as a sound sensor with dB or dBA scaling.  The default value for this
 * optional parameter is true, meaning dB scaling.
 */
inline void SetSensorSound(const byte & port, bool bdBScaling = true) {
  SetSensorType(port, bdBScaling ? SENSOR_TYPE_SOUND_DB : SENSOR_TYPE_SOUND_DBA);
  SetSensorMode(port, SENSOR_MODE_PERCENT);
  ResetSensor(port);
}

/**
 * Configure an I2C sensor.
 * Configure the sensor on the specified port as an I2C digital sensor
 * for either powered (9 volt) or unpowered devices.
 * \param port The port to configure. See \ref InPorts.
 * \param bIsPowered A boolean flag indicating whether to configure the port
 * for powered or unpowered I2C devices.  The default value for this
 * optional parameter is true.
 */
inline void SetSensorLowspeed(const byte & port, bool bIsPowered = true) {
  SetSensorType(port, bIsPowered ? SENSOR_TYPE_LOWSPEED_9V : SENSOR_TYPE_LOWSPEED);
  SetSensorMode(port, SENSOR_MODE_RAW);
  ResetSensor(port);
}

/**
 * Configure an ultrasonic sensor.
 * Configure the sensor on the specified port as an ultrasonic sensor.
 * \param port The port to configure. See \ref InPorts.
 */
inline void SetSensorUltrasonic(const byte & port) { SetSensorLowspeed(port); }

/**
 * Configure an EMeter sensor.
 * Configure the sensor on the specified port as an EMeter sensor.
 * \param port The port to configure. See \ref InPorts.
 */
inline void SetSensorEMeter(const byte & port) { SetSensorLowspeed(port); }

/**
 * Configure a temperature sensor.
 * Configure the sensor on the specified port as a temperature sensor. Use this
 * to setup the temperature sensor rather than \ref SetSensorLowspeed so that
 * the sensor is properly configured in 12-bit conversion mode.
 * \param port The port to configure. See \ref InPorts.
 */
inline void SetSensorTemperature(const byte & port) {
  SetSensorLowspeed(port);
  asm {
    __MSWriteToRegister(port, LEGO_ADDR_TEMP, TEMP_REG_CONFIG, TEMP_RES_12BIT, __WDSC_LSStatus)
  }
}


#if __FIRMWARE_VERSION > 107

/**
 * Configure an NXT 2.0 full color sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in full color mode. Requires an NXT 2.0 compatible firmware.
 * \param port The port to configure. See \ref InPorts.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SetSensorColorFull(const byte & port) { asm { __SetSensorColorFull(port) } }

/**
 * Configure an NXT 2.0 red light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in red light mode. Requires an NXT 2.0 compatible firmware.
 * \param port The port to configure. See \ref InPorts.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SetSensorColorRed(const byte & port) { asm { __SetSensorColorRed(port) } }

/**
 * Configure an NXT 2.0 green light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in green light mode. Requires an NXT 2.0 compatible firmware.
 * \param port The port to configure. See \ref InPorts.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SetSensorColorGreen(const byte & port) { asm { __SetSensorColorGreen(port) } }

/**
 * Configure an NXT 2.0 blue light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in blue light mode. Requires an NXT 2.0 compatible firmware.
 * \param port The port to configure. See \ref InPorts.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SetSensorColorBlue(const byte & port) { asm { __SetSensorColorBlue(port) } }

/**
 * Configure an NXT 2.0 no light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in no light mode. Requires an NXT 2.0 compatible firmware.
 * \param port The port to configure. See \ref InPorts.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SetSensorColorNone(const byte & port) { asm { __SetSensorColorNone(port) } }

#endif

#ifdef __DOXYGEN_DOCS

/**
 * Get an input field value.
 * Return the value of the specified field of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts.  A constant or a variable may
 * be used (no expressions).
 * \param field An input field constant.  See \ref InputFieldConstants.
 * \return The input field value.
 */
inline variant GetInput(const byte & port, const byte field);

/**
 * Set an input field value.
 * Set the specified field of the sensor on the specified port to the value
 * provided.
 *
 * \param port The sensor port. See \ref InPorts. A constant or a variable
 * may be used (no expressions).
 * \param field An input field constant. See \ref InputFieldConstants.
 * \param value The new value, which may be any valid expression.
 */
inline void SetInput(const byte & port, const int field, variant value);

/**
 * Read sensor scaled value.
 * Return the processed sensor reading for a sensor on the specified port.
 * This is the same value that is returned by the sensor value names
 * (e.g. \ref SENSOR_1).
 *
 * \param port The sensor port. See \ref InPorts. A variable whose value is
 * the desired sensor port may also be used.
 * \return The sensor's scaled value.
 */
inline unsigned int Sensor(const byte & port);

/**
 * Read sensor boolean value.
 * Return the boolean value of a sensor on the specified port. Boolean
 * conversion is either done based on preset cutoffs, or a slope parameter
 * specified by calling SetSensorMode.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \return The sensor's boolean value.
 */
inline bool SensorBoolean(const byte port);

/**
 * Read sensor digital pins direction.
 * Return the digital pins direction value of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \return The sensor's digital pins direction.
 */
inline byte SensorDigiPinsDirection(const byte port);

/**
 * Read sensor digital pins output level.
 * Return the digital pins output level value of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \return The sensor's digital pins output level.
 */
inline byte SensorDigiPinsOutputLevel(const byte port);

/**
 * Read sensor digital pins status.
 * Return the digital pins status value of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \return The sensor's digital pins status.
 */
inline byte SensorDigiPinsStatus(const byte port);

/**
 * Read sensor invalid data flag.
 * Return the value of the InvalidData flag of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. A variable whose value is
 * the desired sensor port may also be used.
 * \return The sensor's invalid data flag.
 */
inline bool SensorInvalid(const byte & port);

/**
 * Read sensor mode.
 * Return the mode of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. A variable whose value is
 * the desired sensor port may also be used.
 * \return The sensor's mode. See \ref SensorModes.
 */
inline byte SensorMode(const byte & port);

/**
 * Read sensor normalized value.
 * Return the normalized value of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. A variable whose value is
 * the desired sensor port may also be used.
 * \return The sensor's normalized value.
 */
inline unsigned int SensorNormalized(const byte & port);

/**
 * Read sensor raw value.
 * Return the raw value of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. A variable whose value is
 * the desired sensor port may also be used.
 * \return The sensor's raw value.
 */
inline unsigned int SensorRaw(const byte & port);

/**
 * Read sensor scaled value.
 * Return the processed sensor reading for a sensor on the specified port.
 * This is the same value that is returned by the sensor value names
 * (e.g. \ref SENSOR_1) or the \ref Sensor function.
 *
 * \param port The sensor port. See \ref InPorts. A variable whose value is
 * the desired sensor port may also be used.
 * \return The sensor's scaled value.
 */
inline unsigned int SensorScaled(const byte & port);

/**
 * Read sensor type.
 * Return the type of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. A variable whose value is
 * the desired sensor port may also be used.
 * \return The sensor's type. See \ref SensorTypes.
 */
inline byte SensorType(const byte & port);

/**
 * Read sensor scaled value.
 * Return the processed sensor reading for a sensor on the specified port.
 * This is the same value that is returned by the sensor value names
 * (e.g. \ref SENSOR_1) or the \ref Sensor function.
 *
 * \param port The sensor port. See \ref InPorts. A variable whose value is
 * the desired sensor port may also be used.
 * \return The sensor's scaled value.
 */
inline unsigned int SensorValue(const byte & port);

/**
 * Read sensor boolean value.
 * Return the boolean value of a sensor on the specified port. Boolean
 * conversion is either done based on preset cutoffs, or a slope parameter
 * specified by calling SetSensorMode.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \return The sensor's boolean value.
 */
inline bool SensorValueBool(const byte port);

/**
 * Read sensor raw value.
 * Return the raw value of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. A variable whose value is
 * the desired sensor port may also be used.
 * \return The sensor's raw value.
 */
inline unsigned int SensorValueRaw(const byte & port);

/**
 * Get the custom sensor active status.
 * Return the custom sensor active status value of a sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The custom sensor active status.
*/
inline byte CustomSensorActiveStatus(byte port);

/**
 * Get the custom sensor percent full scale.
 * Return the custom sensor percent full scale value of a sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The custom sensor percent full scale.
 */
inline byte CustomSensorPercentFullScale(byte port);

/**
 * Get the custom sensor zero offset.
 * Return the custom sensor zero offset value of a sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The custom sensor zero offset.
 */
inline unsigned int CustomSensorZeroOffset(byte port);

/**
 * Set active status.
 * Sets the active status value of a custom sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param activeStatus The new active status value.
 */
inline void SetCustomSensorActiveStatus(byte port, byte activeStatus);

/**
 * Set percent full scale.
 * Sets the percent full scale value of a custom sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param pctFullScale The new percent full scale value.
 */
inline void SetCustomSensorPercentFullScale(byte port, byte pctFullScale);

/**
 * Set custom zero offset.
 * Sets the zero offset value of a custom sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param zeroOffset The new zero offset value.
 */
inline void SetCustomSensorZeroOffset(byte port, int zeroOffset);

/**
 * Set sensor boolean value.
 * Sets the boolean value of a sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param value The new boolean value.
 */
inline void SetSensorBoolean(byte port, bool value);

/**
 * Set digital pins direction.
 * Sets the digital pins direction value of a sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param direction The new digital pins direction value.
 */
inline void SetSensorDigiPinsDirection(byte port, byte direction);

/**
 * Set digital pins output level.
 * Sets the digital pins output level value of a sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param outputLevel The new digital pins output level value.
 */
inline void SetSensorDigiPinsOutputLevel(byte port, byte outputLevel);

/**
 * Set digital pins status.
 * Sets the digital pins status value of a sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param status The new digital pins status value.
 */
inline void SetSensorDigiPinsStatus(byte port, byte status);


#if __FIRMWARE_VERSION > 107
/**
 * Read LEGO color sensor.
 * This function lets you read the LEGO color sensor given the parameters you
 * pass in via the \ref ColorSensorReadType structure.
 *
 * \param args The ColorSensorReadType structure containing the required parameters.
 * 
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysColorSensorRead(ColorSensorReadType & args);

/**
 * Read LEGO color sensor extra.
 * This function lets you read the LEGO color sensor. It returns the color value,
 * and three arrays containing raw, normalized, and scaled color values for
 * red, green, blue, and none indices.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param colorval The color value. See \ref InputColorValueConstants.
 * \param raw An array containing four raw color values. See \ref InputColorIdxConstants.
 * \param norm An array containing four normalized color values. See \ref InputColorIdxConstants.
 * \param scaled An array containing four scaled color values. See \ref InputColorIdxConstants.
 * \return The function call result.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline int ReadSensorColorEx(const byte & port, int & colorval, unsigned int & raw[], unsigned int & norm[], int & scaled[]);

/**
 * Read LEGO color sensor raw values.
 * This function lets you read the LEGO color sensor. It returns an array
 * containing raw color values for red, green, blue, and none indices.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param rawVals An array containing four raw color values. See \ref InputColorIdxConstants.
 * \return The function call result.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline int ReadSensorColorRaw(const byte & port, unsigned int & rawVals[]);

/**
 * Read a LEGO color sensor AD raw value.
 * This function lets you directly access a specific LEGO color sensor AD raw value. Both the
 * port and the color index must be constants.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param color The color index. See \ref InputColorIdxConstants.
 * \return The AD raw value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline unsigned int ColorADRaw(byte port, byte color);

/**
 * Read a LEGO color sensor boolean value.
 * This function lets you directly access a specific LEGO color sensor boolean value. Both the
 * port and the color index must be constants.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param color The color index. See \ref InputColorIdxConstants.
 * \return The boolean value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline bool ColorBoolean(byte port, byte color);

/**
 * Read a LEGO color sensor calibration point value.
 * This function lets you directly access a specific LEGO color calibration point value.
 * The port, point, and color index must be constants.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param point The calibration point. See \ref InputColorCalibrationConstants.
 * \param color The color index. See \ref InputColorIdxConstants.
 * \return The calibration point value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline long ColorCalibration(byte port, byte point, byte color);

/**
 * Read LEGO color sensor calibration state.
 * This function lets you directly access the LEGO color calibration state.
 * The port must be a constant.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The calibration state.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline byte ColorCalibrationState(byte port);

/**
 * Read a LEGO color sensor calibration limit value.
 * This function lets you directly access a specific LEGO color calibration limit value.
 * The port and the point must be constants.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param point The calibration point. See \ref InputColorCalibrationConstants.
 * \return The calibration limit value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline unsigned int ColorCalLimits(byte port, byte point);

/**
 * Read a LEGO color sensor raw value.
 * This function lets you directly access a specific LEGO color sensor raw value. Both the
 * port and the color index must be constants.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param color The color index. See \ref InputColorIdxConstants.
 * \return The raw value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline unsigned int ColorSensorRaw(byte port, byte color);

/**
 * Read a LEGO color sensor scaled value.
 * This function lets you directly access a specific LEGO color sensor scaled value. Both the
 * port and the color index must be constants.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param color The color index. See \ref InputColorIdxConstants.
 * \return The scaled value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline unsigned int ColorSensorValue(byte port, byte color);

#ifdef __ENHANCED_FIRMWARE
/**
 * Execute the Input module pin function.
 * This function lets you execute the Input module's pin function using the
 * values specified via the \ref InputPinFunctionType structure.
 *
 * \param args The InputPinFunctionType structure containing the required parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void SysInputPinFunction(InputPinFunctionType & args);
#endif

#endif

#else

enum InputFieldNames {
  Type,
  InputMode,
  RawValue,
  NormalizedValue,
  ScaledValue,
  InvalidData
};

// input fields
#define Sensor(_p) asm { ReadSensor(_p, __RETVAL__) }
#define SensorValue(_p) Sensor(_p)
#define SensorType(_p) GetInput(_p, TypeField)
#define SensorMode(_p) GetInput(_p, InputModeField)
#define SensorRaw(_p) GetInput(_p, RawValueField)
#define SensorNormalized(_p) GetInput(_p, NormalizedValueField)
#define SensorScaled(_p) GetInput(_p, ScaledValueField)
#define SensorInvalid(_p) GetInput(_p, InvalidDataField)
#define SensorValueBool(_p) SensorBoolean(_p)
#define SensorValueRaw(_p) SensorRaw(_p)

#define CustomSensorZeroOffset(_p) asm { GetInCustomZeroOffset(_p, __TMPWORD__) __RETURN__ __TMPWORD__ }
#define CustomSensorPercentFullScale(_p) asm { GetInCustomPercentFullScale(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define CustomSensorActiveStatus(_p) asm { GetInCustomActiveStatus(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SensorBoolean(_p) asm { GetInSensorBoolean(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SensorDigiPinsDirection(_p) asm { GetInDigiPinsDirection(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SensorDigiPinsStatus(_p) asm { GetInDigiPinsStatus(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SensorDigiPinsOutputLevel(_p) asm { GetInDigiPinsOutputLevel(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }

#define SetCustomSensorZeroOffset(_p, _n) asm { __setInCustomZeroOffset(_p, _n) }
#define SetCustomSensorPercentFullScale(_p, _n) asm { __setInCustomPercentFullScale(_p, _n) }
#define SetCustomSensorActiveStatus(_p, _n) asm { __setInCustomActiveStatus(_p, _n) }
#define SetSensorBoolean(_p, _n) asm { __setInSensorBoolean(_p, _n) }
#define SetSensorDigiPinsDirection(_p, _n) asm { __setInDigiPinsDirection(_p, _n) }
#define SetSensorDigiPinsStatus(_p, _n) asm { __setInDigiPinsStatus(_p, _n) }
#define SetSensorDigiPinsOutputLevel(_p, _n) asm { __setInDigiPinsOutputLevel(_p, _n) }


#if __FIRMWARE_VERSION > 107

#define SysColorSensorRead(_args) asm { \
  compchktype _args, ColorSensorReadType \
  syscall ColorSensorRead, _args \
}

#define ReadSensorColorRaw(_port, _rawVals) asm { __ReadSensorColorRaw(_port, _rawVals, __RETVAL__) }
#define ReadSensorColorEx(_port, _colorval, _raw, _norm, _scaled) asm { __ReadSensorColorEx(_port, _colorval, _raw, _norm, _scaled, __RETVAL__) }

#define ColorCalibration(_p, _np, _nc) asm { GetInColorCalibration(_p, _np, _nc, __TMPLONG__) __RETURN__ __TMPLONG__ }
#define ColorCalLimits(_p, _np) asm { GetInColorCalLimits(_p, _np, __TMPWORD__) __RETURN__ __TMPWORD__ }
#define ColorADRaw(_p, _nc) asm { GetInColorADRaw(_p, _nc, __TMPWORD__) __RETURN__ __TMPWORD__ }
#define ColorSensorRaw(_p, _nc) asm { GetInColorSensorRaw(_p, _nc, __TMPWORD__) __RETURN__ __TMPWORD__ }
#define ColorSensorValue(_p, _nc) asm { GetInColorSensorValue(_p, _nc, __TMPWORD__) __RETURN__ __TMPWORD__ }
#define ColorBoolean(_p, _nc) asm { GetInColorBoolean(_p, _nc, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ColorCalibrationState(_p) asm { GetInColorCalibrationState(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }

#ifdef __ENHANCED_FIRMWARE
#define SysInputPinFunction(_args) asm { \
  compchktype _args, InputPinFunctionType \
  syscall InputPinFunction, _args \
}
#endif

#endif

#endif
/** @} */ // end of InputModuleFunctions group
/** @} */ // end of InputModule group
/** @} */ // end of NXTFirmwareModules group

#endif // INPUT_H
